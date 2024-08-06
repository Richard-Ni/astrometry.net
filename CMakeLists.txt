cmake_minimum_required(VERSION 3.5)
PROJECT(AstrometryNet C CXX)
set(CMAKE_CXX_STANDARD 17)

set (AstrometryNet_VERSION_MAJOR 0)
set (AstrometryNet_VERSION_MINOR 95)

execute_process(
        COMMAND git log -n 1 --format=%cd
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_DATE
        OUTPUT_STRIP_TRAILING_WHITESPACE
)

if(NOT GIT_DATE)
    message(WARNING "Failed to get the git date. Defaulting to a placeholder.")
    set(GIT_DATE "1970-01-01 00:00:00")
else()
    message(STATUS "Git date: ${GIT_DATE}")
endif()
string(REPLACE "\"" "" GIT_DATE ${GIT_DATE})
add_definitions(-DAN_GIT_DATE=\"${GIT_DATE}\")

execute_process(
        COMMAND git describe
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE
)

if (NOT GIT_VERSION)
    message(WARNING "Failed to get the git version. Defaulting to a placeholder.")
    set(GIT_VERSION "v0.0")
else()
    message(STATUS "Git version: ${GIT_VERSION}")
endif()
string(REPLACE "\"" "" GIT_VERSION ${GIT_VERSION})
add_definitions(-DAN_GIT_REVISION=\"${GIT_VERSION}\")

add_definitions(-DAN_GIT_URL="https://github.com/dstndstn/astrometry.net")

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

find_package(BZip2 REQUIRED)
include_directories(${BZIP2_INCLUDE_DIR})

##find netpbm library
#find_library(NETPBM_LIBRARY netpbm)
#if (NOT NETPBM_LIBRARY)
#    message(FATAL_ERROR "netpbm library not found")
#endif()

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

file(GLOB_RECURSE HEADER_FILES "*/*.h")
list(REMOVE_DUPLICATES HEADER_FILES)


include_directories(${HEADER_PATH})

add_executable(solve-field solver/solve-field.c
                           solver/augment-xylist.c
                           solver/image2xy-files.c)

set(ENGINE_SRCS solver/engine.c
                solver/solverutils.c
                solver/onefield.c
                solver/solver.c
                solver/quad-utils.c
                solver/solvedfile.c
                solver/tweak2.c
                solver/verify.c
                solver/tweak.c
                solver/new-wcs.c
                solver/fits-guess-scale.c
                solver/cut-table.c
                solver/resort-xylist.c)

set(BUILD_INDEX_SRCS solver/build-index.c
                     solver/uniformize-catalog.c
                     solver/startree.c
                     solver/hpquads.c
                     solver/quad-builder.c
                     solver/quad-utils.c
                     solver/codefile.c
                     solver/codetree.c
                     solver/unpermute-stars.c
                     solver/unpermute-quads.c
                     solver/merge-index.c)

add_library(libastrometry STATIC ${ENGINE_SRCS} ${BUILD_INDEX_SRCS})

target_include_directories(libastrometry PUBLIC include/astrometry include util)

add_library(libcatalogs STATIC catalogs/openngc.c
                               catalogs/brightstars.c
                               catalogs/constellations.c
                               catalogs/tycho2-fits.c
                               catalogs/tycho2.c
                               catalogs/usnob-fits.c
                               catalogs/usnob.c
                               catalogs/nomad.c
                               catalogs/nomad-fits.c
                               catalogs/ucac3-fits.c
                               catalogs/ucac3.c
                               catalogs/ucac4-fits.c
                               catalogs/ucac4.c
                               catalogs/ucac5-fits.c
                               catalogs/ucac5.c
                               catalogs/2mass-fits.c
                               catalogs/2mass.c
                               catalogs/hd.c
                               catalogs/constellation-boundaries.c)

target_include_directories(libcatalogs PUBLIC catalogs include/astrometry include)

add_custom_command(
        TARGET libcatalogs
        PRE_BUILD
        COMMAND sh ${CMAKE_SOURCE_DIR}/catalogs/ngc.sh
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/catalogs
        COMMENT "Generating openngc-entries.csv, openngc-names.csv, openngc-names.c, openngc-entries.c"
)

add_library(libanfiles STATIC util/multiindex.c
                              util/index.c
                              util/indexset.c
                              util/codekd.c
                              util/starkd.c
                              util/rdlist.c
                              util/xylist.c
                              util/starxy.c
                              util/qidxfile.c
                              util/quadfile.c
                              util/scamp.c
                              util/scamp-catalog.c
                              util/tabsort.c
                              util/wcs-xy2rd.c
                              util/wcs-rd2xy.c
                              util/matchfile.c
)

target_include_directories(libanfiles PUBLIC include include/astrometry)

add_library(libanbase STATIC util/starutil.c
                             util/mathutil.c
                             util/bl-sort.c
                             util/bl.c
                             util/bt.c
                             util/healpix-utils.c
                             util/healpix.c
                             util/permutedsort.c
                             util/ioutils.c
                             util/fileutils.c
                             util/md5.c
                             util/an-endian.c
                             util/errors.c
                             util/an-opts.c
                             util/tic.c
                             util/log.c
                             util/datalog.c
                             util/sparsematrix.c
                             util/coadd.c
                             util/convolve-image.c
                             util/resample.c
                             util/intmap.c
                             util/histogram.c
                             util/histogram2d.c)
target_include_directories(libanbase PUBLIC include include/astrometry)

set(UTILS_SRC util/sip-utils.c
              util/fit-wcs.c
              util/sip.c
              util/anwcs.c
              util/wcs-resample.c
              util/gslutils.c
              util/wcs-pv2sip.c
              util/matchobj.c
              util/fitsioutils.c
              util/sip_qfits.c
              util/fitstable.c
              util/fitsbin.c
              util/fitsfile.c
              util/tic.c)

set(SIMPLEXY_SRC util/dallpeaks.c
                  util/dcen3x3.c
                  util/dfind.c
                  util/dmedsmooth.c
                  util/dobjects.c
                  util/dpeaks.c
                  util/dselip.c
                  util/dsigma.c
                  util/dsmooth.c
                  util/image2xy.c
                  util/simplexy.c
                  util/ctmf.c)

add_library(libanutils STATIC ${UTILS_SRC} ${SIMPLEXY_SRC})

target_link_libraries(solve-field libcatalogs libastrometry libanfiles libanutils libanbase
        ${BZIP2_LIBRARIES}
        ${ZLIB_LIBRARY}
        ${JPEG_LIBRARY}
        gsl m)