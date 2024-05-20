# This file is part of the Astrometry.net suite.
# Licensed under a 3-clause BSD style license - see LICENSE

PNG_INC ?= $(shell $(PKG_CONFIG) --cflags libpng 2>/dev/null)
PNG_LIB ?= $(shell $(PKG_CONFIG) --libs libpng 2>/dev/null)
