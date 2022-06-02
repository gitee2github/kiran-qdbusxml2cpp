cmake_minimum_required(VERSION 3.5)

project(kiran-qdbusxml2cpp)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS DBus Core)

add_executable(${PROJECT_NAME} kiran-qdbusxml2cpp.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt5::Core
        Qt5::DBus)

target_include_directories(${PROJECT_NAME} PRIVATE
        ${Qt5DBus_PRIVATE_INCLUDE_DIRS})

include(GNUInstallDirs)

set(KIRANDBUSXML2CPP_INSTALL_PATH ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR})
install(TARGETS ${PROJECT_NAME} DESTINATION ${KIRANDBUSXML2CPP_INSTALL_PATH})

configure_file(${CMAKE_SOURCE_DIR}/data/KiranDBusGenerateConfig.cmake.in ${CMAKE_BINARY_DIR}/KiranDBusGenerateConfig.cmake @ONLY)
install(FILES ${CMAKE_BINARY_DIR}/KiranDBusGenerateConfig.cmake DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/KiranDBusGenerate/)

install(FILES data/KiranDBusGenerateMacros.cmake DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/KiranDBusGenerate/)