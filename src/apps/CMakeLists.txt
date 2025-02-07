
# Add tiff library 
############################################################
if( OJPH_ENABLE_TIFF_SUPPORT AND (NOT EMSCRIPTEN))

  FIND_PACKAGE( TIFF )

  if( TIFF_FOUND )
    set(USE_TIFF TRUE CACHE BOOL "Add TIFF support")
    add_definitions(-DOJPH_ENABLE_TIFF_SUPPORT)
  else()
    message(WARNING "TIFF support has been requested but no path to the TIFF library "
    "has been specified; please configure with -DCMAKE_PREFIX_PATH=<TIFF library directory>, "
    "or disable TIFF support using -DOJPH_ENABLE_TIFF_SUPPORT=OFF.")
  endif( TIFF_FOUND )

  if(TIFF_FOUND)
    message(STATUS "   TIFF_INCLUDE_DIR = ${TIFF_INCLUDE_DIR}")
    message(STATUS "  TIFF_INCLUDE_DIRS = ${TIFF_INCLUDE_DIRS}")
    message(STATUS "       TIFF_LIBRARY = ${TIFF_LIBRARY}")
    message(STATUS "     TIFF_LIBRARIES = ${TIFF_LIBRARIES}")
  endif(TIFF_FOUND)

endif(OJPH_ENABLE_TIFF_SUPPORT AND (NOT EMSCRIPTEN)) 
############################################################

# Add OPENEXR library 
############################################################
if( OJPH_ENABLE_OPENEXR_SUPPORT )

  find_package(IlmBase QUIET)
  if(IlmBase_FOUND)
    message(STATUS "Found IlmBase ${IlmBase_VERSION}")
    find_package(OpenEXR 2 QUIET)
  endif()
  
  if(NOT OpenEXR_FOUND)
    find_package(OpenEXR CONFIG QUIET)
    if(OpenEXR_FOUND)
      set(OpenEXR_FOUND_WITH_CONFIG TRUE BOOL "found OpenEXR with Config")
    endif()
  endif()
  
  if(OpenEXR_FOUND)
    message(STATUS "Found OpenEXR ${OpenEXR_VERSION}")
    set(USE_OPENEXR TRUE CACHE BOOL "Add OpenEXR support")
    add_definitions(-DOJPH_ENABLE_OPENEXR_SUPPORT)
    if(OpenEXR_FOUND_WITH_CONFIG)
      message(STATUS " found OpenEXR with Config")
    else(OpenEXR_FOUND_WITH_CONFIG)
      message(STATUS " found OpenEXR with FindModule")
    endif(OpenEXR_FOUND_WITH_CONFIG)
  else(OpenEXR_FOUND)
    message(STATUS "OpenEXR support has been requested but no path to the OpenEXR or IlmBase library "
      "has been specified; please configure with -DCMAKE_PREFIX_PATH=<OpenEXR library directory>, "
      "or disable OpenEXR support using -DOJPH_ENABLE_OpenEXR_SUPPORT=OFF.")
  endif(OpenEXR_FOUND)

  if(IlmBase_FOUND)
    message(STATUS "IlmBase info:")
    message(STATUS "       IlmBase_VERSION = ${IlmBase_VERSION}")
    message(STATUS "   IlmBase_INCLUDE_DIR = ${IlmBase_INCLUDE_DIR}")
    message(STATUS "  IlmBase_INCLUDE_DIRS = ${IlmBase_INCLUDE_DIRS}")
    message(STATUS "       IlmBase_LIBRARY = ${IlmBase_LIBRARY}")
    message(STATUS "     IlmBase_LIBRARIES = ${IlmBase_LIBRARIES}")
  endif(IlmBase_FOUND)

  if(OpenEXR_FOUND)
    message(STATUS "OpenEXR info:")
    message(STATUS "       OpenEXR_VERSION = ${OpenEXR_VERSION}")
    if( NOT OpenEXR_FOUND_WITH_CONFIG)
      message(STATUS "   OpenEXR_INCLUDE_DIR = ${OpenEXR_INCLUDE_DIR}")
      message(STATUS "  OpenEXR_INCLUDE_DIRS = ${OpenEXR_INCLUDE_DIRS}")
      message(STATUS "       OpenEXR_LIBRARY = ${OpenEXR_LIBRARY}")
      message(STATUS "     OpenEXR_LIBRARIES = ${OpenEXR_LIBRARIES}")
    endif(NOT OpenEXR_FOUND_WITH_CONFIG)
  endif(OpenEXR_FOUND)

endif(OJPH_ENABLE_OPENEXR_SUPPORT) 
############################################################

if (EMSCRIPTEN)
  add_link_options(-sWASM=1 -sASSERTIONS=1 -sALLOW_MEMORY_GROWTH=1 -sNODERAWFS=1 -sENVIRONMENT=node -sEXIT_RUNTIME=1 -sEXCEPTION_CATCHING_ALLOWED=['fake'])
endif()

## Build executables
add_subdirectory(ojph_expand)
add_subdirectory(ojph_compress)
if (OJPH_BUILD_STREAM_EXPAND)
  add_subdirectory(ojph_stream_expand)
endif()