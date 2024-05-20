
# find cairo library
find_library(CAIRO_LIBRARY cairo)
if (NOT CAIRO_LIBRARY)
    message(FATAL_ERROR "cairo library not found")
endif()

#find cfitsio library
find_library(CFITSIO_LIBRARY cfitsio)
if (NOT CFITSIO_LIBRARY)
    message(FATAL_ERROR "cfitsio library not found")
endif()

#find gsl library
find_library(GSL_LIBRARY gsl)
if (NOT GSL_LIBRARY)
    message(FATAL_ERROR "gsl library not found")
endif()

#find jpeg library
find_library(JPEG_LIBRARY jpeg)
if (NOT JPEG_LIBRARY)
    message(FATAL_ERROR "jpeg library not found")
endif()

#find netpbm library
find_library(NETPBM_LIBRARY netpbm)
if (NOT NETPBM_LIBRARY)
    message(FATAL_ERROR "netpbm library not found")
endif()

#find png library
find_library(PNG_LIBRARY png)
if (NOT PNG_LIBRARY)
    message(FATAL_ERROR "png library not found")
endif()

#find zlib library
find_library(ZLIB_LIBRARY z)
if (NOT ZLIB_LIBRARY)
    message(FATAL_ERROR "zlib library not found")
endif()

# find wcslib library
find_library(WCSLIB_LIBRARY wcs)
if (NOT WCSLIB_LIBRARY)
    message(FATAL_ERROR "wcs library not found")
endif()
