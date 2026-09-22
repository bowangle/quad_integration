cmake_minimum_required(VERSION 3.21)
project(integration_method LANGUAGES CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# ---- dependency: fft-tn-quadp manages its transitive dependencies ------------
set(FFT_TN_BUILD_TESTS OFF CACHE BOOL "Build fft-tn-quadp tests" FORCE)
if(NOT TARGET fft_tn_deps)
    add_subdirectory(extern/fft-tn-quadp EXCLUDE_FROM_ALL)
endif()

# ---- interface target: carries our headers + transitive dependencies ----------
add_library(integration_method_deps INTERFACE)

target_sources(integration_method_deps INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/include/integration_method.hpp)

target_include_directories(integration_method_deps INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_compile_features(integration_method_deps INTERFACE cxx_std_20)

target_link_libraries(integration_method_deps INTERFACE fft_tn_deps)

# Compile the public header as part of the default build.
add_library(integration_method STATIC
    src/integration_method.cpp)

target_link_libraries(integration_method PUBLIC integration_method_deps)

target_compile_options(integration_method PRIVATE
    -Wall -Wextra -Wreorder -Wshadow)
