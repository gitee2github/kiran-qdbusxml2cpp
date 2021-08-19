cmake_minimum_required(VERSION 3.5)

project(kiran-qdbusxml2cpp)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS DBus Core)

add_executable(kiran-qdbusxml2cpp kiran-qdbusxml2cpp.cpp)

target_link_libraries(kiran-qdbusxml2cpp PRIVATE
        Qt5::Core
        Qt5::DBus)

target_include_directories(kiran-qdbusxml2cpp PRIVATE
        ${Qt5DBus_PRIVATE_INCLUDE_DIRS})