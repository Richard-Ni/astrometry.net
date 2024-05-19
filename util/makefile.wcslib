# This file is part of the Astrometry.net suite.
# Licensed under a 3-clause BSD style license - see LICENSE

# WCSLIB is (supposed to be) optional.

# if WCSLIB_INC environment variable is set, assume WCSLIB_EXISTS
ifeq ($(origin WCSLIB_INC), environment)
  WCSLIB_EXISTS := 1
else
  X := $(shell $(PKG_CONFIG) --exists wcslib && echo yes || echo no)
  ifeq ($(X), yes)
    WCSLIB_EXISTS ?= 1
  endif
endif

WCSLIB_INC ?= $(shell $(PKG_CONFIG) --cflags wcslib 2>/dev/null)
WCSLIB_LIB ?= $(shell $(PKG_CONFIG) --libs wcslib 2>/dev/null)
WCSLIB_SLIB ?=

WCSLIB_HAS_WCSCCS ?= $(shell $(PKG_CONFIG) --atleast-version=7.5 wcslib 2>/dev/null && echo 1 || echo 0)

#WCSLIB_LIB ?=
#WCSLIB_SLIB ?= $(shell $(PKG_CONFIG) --static wcslib 2>/dev/null)
