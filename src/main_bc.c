#include <msp430.h>
#include <libwispbase/wisp-base.h>

#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include <libmspbuiltins/builtins.h>
#ifdef LOGIC
#define LOG(...)
#define PRINTF(...)
#define BLOCK_PRINTF(...)
#define BLOCK_PRINTF_BEGIN(...)
#define BLOCK_PRINTF_END(...)
#define INIT_CONSOLE(...)
#else
#include <libio/log.h>
#endif
#include <libmsp/mem.h>
#include <libmsp/periph.h>
#include <libmsp/clock.h>
#include <libmsp/watchdog.h>
#include <libmsp/gpio.h>
#include <libmspmath/msp-math.h>

#ifdef CONFIG_EDB
#include <libedb/edb.h>
#else
#define ENERGY_GUARD_BEGIN()
#define ENERGY_GUARD_END()
#endif

#ifdef RATCHET
#include <libratchet/ratchet.h>
#endif
#include "pins.h"
#define SEED 4L
#define ITER 100
#define CHAR_BIT 8

static const char bc_bits[256] =
{
	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,  /* 0   - 15  */
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 16  - 31  */
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 32  - 47  */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 48  - 63  */
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 64  - 79  */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 80  - 95  */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 96  - 111 */
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 112 - 127 */
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 128 - 143 */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 144 - 159 */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 160 - 175 */
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 176 - 191 */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 192 - 207 */
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 208 - 223 */
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 224 - 239 */
	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8   /* 240 - 255 */
};

static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}

void init()
{
	init_hw();

	INIT_CONSOLE();

	__enable_interrupt();
#ifdef LOGIC
	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);

	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_1);
	GPIO(PORT_AUX3, OUT) &= ~BIT(PIN_AUX_3);
	// Output enabled
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_1);
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_2);
	GPIO(PORT_AUX3, DIR) |= BIT(PIN_AUX_3);
#ifdef OVERHEAD
	// When timing overhead, pin 2 is on for
	// region of interest
#else
	// elsewise, pin2 is toggled on boot
	GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_2);
	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);
#endif
#else
	if (cur_reg == regs_0) {
		PRINTF("%x\r\n", regs_1[0]);
	}
	else {
		PRINTF("%x\r\n", regs_0[0]);
	}
#endif
}

unsigned bit_count(uint32_t x)
{
	unsigned n = 0;
	/*
	 ** The loop will execute once for each bit of x set, this is in average
	 ** twice as fast as the shift/test method.
	 */
	if (x) do {
		n++;
	} while (0 != (x = x&(x-1))) ;
	return n;
}
int bitcount(uint32_t i)
{
	i = ((i & 0xAAAAAAAAL) >>  1) + (i & 0x55555555L);
	i = ((i & 0xCCCCCCCCL) >>  2) + (i & 0x33333333L);
	i = ((i & 0xF0F0F0F0L) >>  4) + (i & 0x0F0F0F0FL);
	i = ((i & 0xFF00FF00L) >>  8) + (i & 0x00FF00FFL);
	i = ((i & 0xFFFF0000L) >> 16) + (i & 0x0000FFFFL);
	return (int)i;
}
int ntbl_bitcount(uint32_t x)
{
	return
		bc_bits[ (int) (x & 0x0000000FUL)       ] +
		bc_bits[ (int)((x & 0x000000F0UL) >> 4) ] +
		bc_bits[ (int)((x & 0x00000F00UL) >> 8) ] +
		bc_bits[ (int)((x & 0x0000F000UL) >> 12)] +
		bc_bits[ (int)((x & 0x000F0000UL) >> 16)] +
		bc_bits[ (int)((x & 0x00F00000UL) >> 20)] +
		bc_bits[ (int)((x & 0x0F000000UL) >> 24)] +
		bc_bits[ (int)((x & 0xF0000000UL) >> 28)];
}
int BW_btbl_bitcount(uint32_t x)
{
	union 
	{ 
		unsigned char ch[4]; 
		long y; 
	} U; 

	U.y = x; 

	return bc_bits[ U.ch[0] ] + bc_bits[ U.ch[1] ] + 
		bc_bits[ U.ch[3] ] + bc_bits[ U.ch[2] ]; 
}
int AR_btbl_bitcount(uint32_t x)
{
	unsigned char * Ptr = (unsigned char *) &x ;
	int Accu ;

	Accu  = bc_bits[ *Ptr++ ];
	Accu += bc_bits[ *Ptr++ ];
	Accu += bc_bits[ *Ptr++ ];
	Accu += bc_bits[ *Ptr ];
	return Accu;
}

//non-recursive form
int ntbl_bitcnt(uint32_t x)
{
	int cnt = bc_bits[(int)(x & 0x0000000FL)];

	while (0L != (x >>= 4)) {
		cnt += bc_bits[(int)(x & 0x0000000FL)];
	}

	return cnt;
}

static int bit_shifter(uint32_t x)
{
	int i, n;
	for (i = n = 0; x && (i < (sizeof(uint32_t) * CHAR_BIT)); ++i, x >>= 1)
		n += (int)(x & 1L);
	return n;
}
int main()
{
	// init() and restore_regs() should be called at the beginning of main.
	// I could have made the compiler to do that, but was a bit lazy..
	init();
	restore_regs();

	unsigned n_0, n_1, n_2, n_3, n_4, n_5, n_6;
	uint32_t seed;
	unsigned iter;
	unsigned func;

	while (1) {
#ifdef LOGIC
		// Out high
		GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_1);
		// Out low
		GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_1);
#endif
		n_0=0;
		n_1=0;
		n_2=0;
		n_3=0;
		n_4=0;
		n_5=0;
		n_6=0;
		PRINTF("start\r\n");
		for (func = 0; func < 7; func++) {
			LOG("func: %u\r\n", func);
			seed = (uint32_t)SEED;
			if(func == 0){
				for(iter = 0; iter < ITER; ++iter, seed += 13){
					n_0 += bit_count(seed);
				}
			}
			else if(func == 1){
				for(iter = 0; iter < ITER; ++iter, seed += 13){
					n_1 += bitcount(seed);
				}
			}
			else if(func == 2){
				for(iter = 0; iter < ITER; ++iter, seed += 13){
					n_2 += ntbl_bitcnt(seed);
				}
			}
			else if(func == 3){
				for(iter = 0; iter < ITER; ++iter, seed += 13){
					n_3 += ntbl_bitcount(seed);
				}
			}
			else if(func == 4){
				for(iter = 0; iter < ITER; ++iter, seed += 13){
					n_4 += BW_btbl_bitcount(seed);
				}
			}
			else if(func == 5){
				for(iter = 0; iter < ITER; ++iter, seed += 13){
					n_5 += AR_btbl_bitcount(seed);
				}
			}
			else if(func == 6){
				for(iter = 0; iter < ITER; ++iter, seed += 13){
					n_6 += bit_shifter(seed);
				}
			}
		}

		PRINTF("end\r\n");
		BLOCK_PRINTF_BEGIN();
		BLOCK_PRINTF("%u\r\n", n_0);
		BLOCK_PRINTF("%u\r\n", n_1);
		BLOCK_PRINTF("%u\r\n", n_2);
		BLOCK_PRINTF("%u\r\n", n_3);
		BLOCK_PRINTF("%u\r\n", n_4);
		BLOCK_PRINTF("%u\r\n", n_5);
		BLOCK_PRINTF("%u\r\n", n_6);
		BLOCK_PRINTF_END();
#ifdef LOGIC
		GPIO(PORT_AUX3, OUT) |= BIT(PIN_AUX_3);
		GPIO(PORT_AUX3, OUT) &= ~BIT(PIN_AUX_3);
#endif
	}
	return 0;
}
