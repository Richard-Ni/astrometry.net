# This file is part of the Astrometry.net suite.
# Licensed under a 3-clause BSD style license - see LICENSE

ZLIB_INC ?= $(shell $(PKG_CONFIG) --cflags zlib 2>/dev/null)
ZLIB_LIB ?= $(shell $(PKG_CONFIG) --libs zlib 2>/dev/null || echo "-lz")
