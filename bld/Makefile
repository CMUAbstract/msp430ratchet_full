EXEC = $(SRC)
OBJECTS = \
    main_$(SRC).o 

DEPS += \
	libmsp \
	libmspmath \
#	libio \
#	libwispbase \
#	libmspconsole \
#	libmspprintf \

# Relative from toolchain build dir (one down from this file's dir)
SRC_ROOT = ../../src

include $(LIB_ROOT)/libmspbuiltins/bld/Makefile.target
#include $(LIB_ROOT)/libedb/bld/Makefile.target
#include $(LIB_ROOT)/libio/bld/Makefile.target
#include $(LIB_ROOT)/libwispbase/bld/Makefile.target
#include $(LIB_ROOT)/libmspconsole/bld/Makefile.target
#include $(LIB_ROOT)/libmspprintf/bld/Makefile.target

#ifeq ($(BOARD), mspts430)
CONFIG_PRINTF_LIB = libmspconsole
#endif
#ifeq ($(BOARD), wisp)
#CONFIG_PRINTF_LIB = libedb
#CONFIG_EDB = 1
#endif
#include ../Makefile.config

LOGIC = 1
ifeq ($(LOGIC), 1)
override CFLAGS += \
	-DLOGIC=1
endif

ifeq ($(SYS), ratchet)
override CFLAGS += \
	-DRATCHET
endif

include $(LIB_ROOT)/maker/Makefile.console
override CFLAGS += \
	-DENERGY=$(ENERGY) \

#include $(LIB_ROOT)/libedb/bld/Makefile.target

export LIBMSP_CLOCK_SOURCE = DCO
export LIBMSP_DCO_FREQ = 8000000ull
export LIBEDB_BOARD_VERSION_MAJOR=1
export LIBEDB_BOARD_VERSION_MINOR=1
