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
#define BLOCK_LOG(...)
#define BLOCK_LOG_BEGIN(...)
#define BLOCK_LOG_END(...)
#define INIT_CONSOLE(...)
#else
#include <libio/log.h>
#endif
#include <libmsp/mem.h>
#include <libmsp/periph.h>
#include <libmsp/clock.h>
#include <libmsp/watchdog.h>
#include <libmsp/gpio.h>
//#include <libmspmath/msp-math.h>

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

#include <stdint.h>

#define NUM_BUCKETS 128 // must be a power of 2
#define MAX_RELOCATIONS 8

#define NUM_KEYS (NUM_BUCKETS / 4) // shoot for 25% occupancy
#define INIT_KEY 0x1

typedef uint16_t value_t;
typedef uint16_t hash_t;
typedef uint16_t fingerprint_t;
typedef uint16_t index_t; // bucket index

static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}

void print_filter(fingerprint_t *filter)
{
	unsigned i;
	BLOCK_PRINTF_BEGIN();
	for (i = 0; i < NUM_BUCKETS; ++i) {
		BLOCK_PRINTF("%04x ", filter[i]);
		if (i > 0 && (i + 1) % 8 == 0){
			BLOCK_PRINTF("\r\n");
		}
	}
	BLOCK_PRINTF_END();
}
void log_filter(fingerprint_t *filter)
{
	unsigned i;
	BLOCK_LOG_BEGIN();
	BLOCK_LOG("address: %x\r\n", filter);
	for (i = 0; i < NUM_BUCKETS; ++i) {
		BLOCK_LOG("%04x ", filter[i]);
		if (i > 0 && (i + 1) % 8 == 0)
			BLOCK_LOG("\r\n");
	}
	BLOCK_LOG_END();
}

void print_stats(unsigned inserts, unsigned members, unsigned total)
{
	PRINTF("stats: inserts %u members %u total %u\r\n",
			inserts, members, total);
}

static hash_t djb_hash(uint8_t* data, unsigned len)
{
	uint32_t hash = 5381;
	unsigned int i;

	for(i = 0; i < len; data++, i++) {
		hash = ((hash << 5) + hash) + (*data);
	}

	return hash & 0xFFFF;
}

static index_t hash_fp_to_index(fingerprint_t fp)
{
	hash_t hash = djb_hash((uint8_t *)&fp, sizeof(fingerprint_t));
	return hash & (NUM_BUCKETS - 1); // NUM_BUCKETS must be power of 2
}

static index_t hash_key_to_index(value_t fp)
{
	hash_t hash = djb_hash((uint8_t *)&fp, sizeof(value_t));
	return hash & (NUM_BUCKETS - 1); // NUM_BUCKETS must be power of 2
}

static fingerprint_t hash_to_fingerprint(value_t key)
{
	return djb_hash((uint8_t *)&key, sizeof(value_t));
}

static value_t generate_key(value_t prev_key)
{
	// insert pseufo-random integers, for testing
	// If we use consecutive ints, they hash to consecutive DJB hashes...
	// NOTE: we are not using rand(), to have the sequence available to verify
	// that that are no false negatives (and avoid having to save the values).
	return (prev_key + 1) * 17;
}

static bool insert(fingerprint_t *filter, value_t key)
{
	fingerprint_t fp1, fp2, fp_victim, fp_next_victim;
	index_t index_victim, fp_hash_victim;
	unsigned relocation_count = 0;

	fingerprint_t fp = hash_to_fingerprint(key);

	index_t index1 = hash_key_to_index(key);

	index_t fp_hash = hash_fp_to_index(fp);
	index_t index2 = index1 ^ fp_hash;

	//PRINTF("insert: key %04x fp %04x h %04x i1 %u i2 %u\r\n",
	//		key, fp, fp_hash, index1, index2);

	fp1 = filter[index1];
	//PRINTF("insert: fp1 %04x\r\n", fp1);
	if (!fp1) { // slot 1 is free
		filter[index1] = fp;
	} else {
		fp2 = filter[index2];
		//PRINTF("insert: fp2 %04x\r\n", fp2);
		if (!fp2) { // slot 2 is free
			filter[index2] = fp;
		} else { // both slots occupied, evict
			if (rand() & 0x80) { // don't use lsb because it's systematic
				index_victim = index1;
				fp_victim = fp1;
			} else {
				index_victim = index2;
				fp_victim = fp2;
			}

			LOG("insert: evict [%u] = %04x\r\n", index_victim, fp_victim);
			filter[index_victim] = fp; // evict victim

			do { // relocate victim(s)
				fp_hash_victim = hash_fp_to_index(fp_victim);
				index_victim = index_victim ^ fp_hash_victim;

				fp_next_victim = filter[index_victim];
				filter[index_victim] = fp_victim;

				//PRINTF("insert: moved %04x to %u; next victim %04x\r\n",
				//		fp_victim, index_victim, fp_next_victim);

				fp_victim = fp_next_victim;
			} while (fp_victim && ++relocation_count < MAX_RELOCATIONS);

			if (fp_victim) {
#if ENERGY == 0
				PRINTF("insert: lost fp %04x\r\n", fp_victim);
#endif
				return false;
			}
		}
	}

	return true;
}

static bool lookup(fingerprint_t *filter, value_t key)
{
	fingerprint_t fp = hash_to_fingerprint(key);

	index_t index1 = hash_key_to_index(key);

	index_t fp_hash = hash_fp_to_index(fp);
	index_t index2 = index1 ^ fp_hash;

	LOG("lookup: key %04x fp %04x h %04x i1 %u i2 %u\r\n",
			key, fp, fp_hash, index1, index2);
	LOG("f[%u] %04x f[%u] %04x\r\n",
			index1, filter[index1], index2, filter[index2]);

	return filter[index1] == fp || filter[index2] == fp;
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

	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_2);
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_1);
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

int main()
{
	// init() and restore_regs() should be called at the beginning of main.
	// I could have made the compiler to do that, but was a bit lazy..
	init();
	restore_regs();

	fingerprint_t filter[NUM_BUCKETS];

	unsigned i;
	value_t key;

	//	unsigned count = 0;
	while (1) {
#ifdef LOGIC
		// Out high
		GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_1);
		// Out low
		GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_1);
#endif

		for (unsigned cnt = 0; cnt < 5; ++cnt) {
#if ENERGY == 0
			PRINTF("start\r\n");
#endif
			for (i = 0; i < NUM_BUCKETS; ++i)
				filter[i] = 0;

			key = INIT_KEY;
			unsigned inserts = 0;
			for (i = 0; i < NUM_KEYS; ++i) {
				key = generate_key(key);
				bool success = insert(filter, key);
				LOG("insert: key %04x success %u\r\n", key, success);
				if (!success) {
#if ENERGY == 0
					PRINTF("insert: key %04x failed\r\n", key);
#endif
				}
				//print_filter(filter);

				inserts += success;

			}
			LOG("inserts/total: %u/%u\r\n", inserts, NUM_KEYS);

			key = INIT_KEY;
			unsigned members = 0;
			for (i = 0; i < NUM_KEYS; ++i) {
				key = generate_key(key);
				bool member = lookup(filter, key);
				LOG("lookup: key %04x member %u\r\n", key, member);
				if (!member) {
					fingerprint_t fp = hash_to_fingerprint(key);
#if ENERGY == 0
					PRINTF("lookup: key %04x fp %04x not member\r\n", key, fp);
#endif
				}
				members += member;
			}
			LOG("members/total: %u/%u\r\n", members, NUM_KEYS);

			PRINTF("end\r\n");
			//PRINTF("chkpt cnt: %u\r\n", chkpt_count);
			//PRINTF(".%u.\r\n", curctx->cur_reg[15]);
			//print_filter(filter);
			print_stats(inserts, members, NUM_KEYS);
		}
#ifdef LOGIC
		GPIO(PORT_AUX3, OUT) |= BIT(PIN_AUX_3);
		GPIO(PORT_AUX3, OUT) &= ~BIT(PIN_AUX_3);
#endif
	}

	return 0;
}
