# This file is part of the Astrometry.net suite.
# Licensed under a 3-clause BSD style license - see LICENSE
include $(COMMON)/makefile.cross
PNG_INC ?= $(shell $(PKG_CONIFG) --cflags libpng 2>/dev/null)
PNG_LIB ?= $(shell $(PKG_CONIFG) --libs libpng 2>/dev/null)
