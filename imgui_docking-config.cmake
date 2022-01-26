# validate the cmake version is met
if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()

# push our cmake import file pollcy
cmake_policy(PUSH)
cmake_policy(VERSION 2.6...3.19)
set(CMAKE_IMPORT_FILE_VERSION 1)

# get our import path
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)

# create our library
add_library(imgui_docking STATIC IMPORTED)  
set_target_properties(imgui_docking PROPERTIES 
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE   "CXX"
    IMPORTED_LOCATION_RELEASE   "${_IMPORT_PREFIX}/lib/release/imgui_docking.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG     "CXX"
    IMPORTED_LOCATION_DEBUG     "${_IMPORT_PREFIX}/lib/debug/imgui_docking.lib"
    )

set_property(TARGET imgui_docking APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE DEBUG)

# corresponding pop on policy scope
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)
