## building ojph_expand
#######################

file(GLOB OJPH_EXPAND         "ojph_expand.cpp")
file(GLOB OJPH_IMG_IO         "../others/ojph_img_io.cpp")
file(GLOB OJPH_IMG_IO_SSE4    "../others/ojph_img_io_sse41.cpp")
file(GLOB OJPH_IMG_IO_AVX2    "../others/ojph_img_io_avx2.cpp")
file(GLOB OJPH_IMG_IO_H       "../common/ojph_img_io.h")

list(APPEND SOURCES ${OJPH_EXPAND} ${OJPH_IMG_IO} ${OJPH_IMG_IO_H})

source_group("main"        FILES ${OJPH_EXPAND})
source_group("others"      FILES ${OJPH_IMG_IO})
source_group("common"      FILES ${OJPH_IMG_IO_H})

if(EMSCRIPTEN)
  if (OJPH_ENABLE_WASM_SIMD)
    list(APPEND SOURCES ${OJPH_IMG_IO_SSE4})
    source_group("others" FILES ${OJPH_IMG_IO_SSE4})
    set_source_files_properties(${OJPH_IMG_IO_SSE4} PROPERTIES COMPILE_FLAGS -msse4.1)
  endif()
else()
  if (NOT OJPH_DISABLE_SIMD)
    if (("${OJPH_TARGET_ARCH}" MATCHES "OJPH_ARCH_X86_64") OR ("${OJPH_TARGET_ARCH}" MATCHES "OJPH_ARCH_I386"))
      if (NOT OJPH_DISABLE_SSE4)
        list(APPEND SOURCES ${OJPH_IMG_IO_SSE4})
        source_group("others" FILES ${OJPH_IMG_IO_SSE4})
      endif()
      if (NOT OJPH_DISABLE_AVX2)
        list(APPEND SOURCES ${OJPH_IMG_IO_AVX2})
        source_group("others" FILES ${OJPH_IMG_IO_AVX2})
      endif()

      # Set compilation flags
      if (MSVC)
        set_source_files_properties(${OJPH_IMG_IO_AVX2} PROPERTIES COMPILE_FLAGS "/arch:AVX2")
      else()
        set_source_files_properties(${OJPH_IMG_IO_SSE4} PROPERTIES COMPILE_FLAGS -msse4.1)
        set_source_files_properties(${OJPH_IMG_IO_AVX2} PROPERTIES COMPILE_FLAGS -mavx2)
      endif()
    elseif ("${OJPH_TARGET_ARCH}" MATCHES "OJPH_ARCH_ARM")

    endif()

  endif()

  # add_executable(ojph_expand ${SOURCES})

  # if( USE_TIFF )
  #   if( USE_OPENEXR )
  #     target_link_libraries(ojph_expand PUBLIC openjph ${TIFF_LIBRARIES} 
  #     	    # For OpenEXR/Imath 3.x:
	# 	        $<$<TARGET_EXISTS:OpenEXR::OpenEXR>:OpenEXR::OpenEXR>
	# 	        $<$<TARGET_EXISTS:Imath::Imath>:Imath::Imath>
	# 	        $<$<TARGET_EXISTS:Imath::Half>:Imath::Half>
	#           # For OpenEXR 2.4/2.5:
	# 	        $<$<TARGET_EXISTS:OpenEXR::IlmImf>:OpenEXR::IlmImf>
	# 	        $<$<TARGET_EXISTS:IlmBase::Imath>:IlmBase::Imath>
	# 	        $<$<TARGET_EXISTS:IlmBase::Half>:IlmBase::Half>
	# 	        $<$<TARGET_EXISTS:IlmBase::IlmThread>:IlmBase::IlmThread>
	# 	        $<$<TARGET_EXISTS:IlmBase::Iex>:IlmBase::Iex>
	#           # ZLIB for OpenEXR 2.x:
	#   	      $<$<TARGET_EXISTS:ZLIB::ZLIB>:ZLIB::ZLIB>)
  #   else()
  #     target_link_libraries(ojph_expand PUBLIC openjph ${TIFF_LIBRARIES})
  #   endif()
  # else()
  #   if( USE_OPENEXR )
  #   target_link_libraries(ojph_expand PUBLIC openjph 
  #         	    # For OpenEXR/Imath 3.x:
  #               $<$<TARGET_EXISTS:OpenEXR::OpenEXR>:OpenEXR::OpenEXR>
  #               $<$<TARGET_EXISTS:Imath::Imath>:Imath::Imath>
  #               $<$<TARGET_EXISTS:Imath::Half>:Imath::Half>
  #               # For OpenEXR 2.4/2.5:
  #               $<$<TARGET_EXISTS:OpenEXR::IlmImf>:OpenEXR::IlmImf>
  #               $<$<TARGET_EXISTS:IlmBase::Imath>:IlmBase::Imath>
  #               $<$<TARGET_EXISTS:IlmBase::Half>:IlmBase::Half>
  #               $<$<TARGET_EXISTS:IlmBase::IlmThread>:IlmBase::IlmThread>
  #               $<$<TARGET_EXISTS:IlmBase::Iex>:IlmBase::Iex>
  #               # ZLIB for OpenEXR 2.x:
  #               $<$<TARGET_EXISTS:ZLIB::ZLIB>:ZLIB::ZLIB>)
  #   else()
  #     target_link_libraries(ojph_expand PUBLIC openjph)
  #   endif()
  # endif()

  # install(TARGETS ojph_expand DESTINATION bin)
endif()

add_executable(ojph_expand ${SOURCES})
target_include_directories(ojph_expand PRIVATE ../common)
target_link_libraries(ojph_expand PRIVATE openjph 
  # TIFF
  $<TARGET_NAME_IF_EXISTS:TIFF::TIFF>
  # For OpenEXR/Imath 3.x:
  $<$<TARGET_EXISTS:OpenEXR::OpenEXR>:OpenEXR::OpenEXR>
  $<$<TARGET_EXISTS:Imath::Imath>:Imath::Imath>
  $<$<TARGET_EXISTS:Imath::Half>:Imath::Half>
  # For OpenEXR 2.4/2.5:
  $<$<TARGET_EXISTS:OpenEXR::IlmImf>:OpenEXR::IlmImf>
  $<$<TARGET_EXISTS:IlmBase::Imath>:IlmBase::Imath>
  $<$<TARGET_EXISTS:IlmBase::Half>:IlmBase::Half>
  $<$<TARGET_EXISTS:IlmBase::IlmThread>:IlmBase::IlmThread>
  $<$<TARGET_EXISTS:IlmBase::Iex>:IlmBase::Iex>
  # ZLIB for OpenEXR 2.x:
  $<$<TARGET_EXISTS:ZLIB::ZLIB>:ZLIB::ZLIB>)

install(TARGETS ojph_expand)
