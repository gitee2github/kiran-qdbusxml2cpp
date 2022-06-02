include(MacroAddFileDependencies)

function(KIRAN_QT5_ADD_DBUS_INTERFACE _sources _interface _basename)
    get_filename_component(_infile ${_interface} ABSOLUTE)
    set(_header "${CMAKE_CURRENT_BINARY_DIR}/${_basename}.h")
    set(_impl "${CMAKE_CURRENT_BINARY_DIR}/${_basename}.cpp")
    set(_moc "${CMAKE_CURRENT_BINARY_DIR}/${_basename}.moc")

    get_source_file_property(_nonamespace ${_interface} NO_NAMESPACE)
    if (_nonamespace)
        set(_params -N -m)
    else ()
        set(_params -m)
    endif ()

    get_source_file_property(_classname ${_interface} CLASSNAME)
    if (_classname)
        set(_params ${_params} -c ${_classname})
    endif ()

    get_source_file_property(_include ${_interface} INCLUDE)
    if (_include)
        set(_params ${_params} -i ${_include})
    endif ()

    add_custom_command(OUTPUT "${_impl}" "${_header}"
            COMMAND ${_KIRANDBUSXML2CPP_EXECUTABLE} ${_params} -p ${_basename} ${_infile}
            DEPENDS ${_infile} VERBATIM)

    set_property(SOURCE ${_impl}  PROPERTY SKIP_AUTOGEN ON)
    set_property(SOURCE ${_header} PROPERTY SKIP_AUTOGEN ON)

    #set_source_files_properties("${_impl}" "${_header}" PROPERTIES SKIP_AUTOMOC TRUE)
    qt5_generate_moc("${_header}" "${_moc}")

    list(APPEND ${_sources} "${_impl}" "${_header}" "${_moc}")
    macro_add_file_dependencies("${_impl}" "${_moc}")
    set(${_sources} ${${_sources}} PARENT_SCOPE)
endfunction()

function(KIRAN_QT5_ADD_DBUS_INTERFACES _sources)
    foreach (_current_FILE ${ARGN})
        get_filename_component(_infile ${_current_FILE} ABSOLUTE)
        get_filename_component(_basename ${_current_FILE} NAME)
        # get the part before the ".xml" suffix
        string(TOLOWER ${_basename} _basename)
        string(REGEX REPLACE "(.*\\.)?([^\\.]+)\\.xml" "\\2" _basename ${_basename})
        qt5_add_dbus_interface(${_sources} ${_infile} ${_basename}interface)
    endforeach ()
    set(${_sources} ${${_sources}} PARENT_SCOPE)
endfunction()


function(KIRAN_QT5_ADD_DBUS_ADAPTOR _sources _xml_file _include _parentClass) # _optionalBasename _optionalClassName)
    get_filename_component(_infile ${_xml_file} ABSOLUTE)

    set(_optionalBasename "${ARGV4}")
    if (_optionalBasename)
        set(_basename ${_optionalBasename})
    else ()
        string(REGEX REPLACE "(.*[/\\.])?([^\\.]+)\\.xml" "\\2adaptor" _basename ${_infile})
        string(TOLOWER ${_basename} _basename)
    endif ()

    set(_optionalClassName "${ARGV5}")
    set(_header "${CMAKE_CURRENT_BINARY_DIR}/${_basename}.h")
    set(_impl "${CMAKE_CURRENT_BINARY_DIR}/${_basename}.cpp")
    set(_moc "${CMAKE_CURRENT_BINARY_DIR}/${_basename}.moc")

    if (_optionalClassName)
        add_custom_command(OUTPUT "${_impl}" "${_header}"
                COMMAND ${_KIRANDBUSXML2CPP_EXECUTABLE} -m -a ${_basename} -c ${_optionalClassName} -i ${_include} -l ${_parentClass} ${_infile}
                DEPENDS ${_infile} VERBATIM
                )
    else ()
        add_custom_command(OUTPUT "${_impl}" "${_header}"
                COMMAND ${_KIRANDBUSXML2CPP_EXECUTABLE} -m -a ${_basename} -i ${_include} -l ${_parentClass} ${_infile}
                DEPENDS ${_infile} VERBATIM
                )
    endif ()

    qt5_generate_moc("${_header}" "${_moc}")
    set_source_files_properties("${_impl}" "${_header}" PROPERTIES SKIP_AUTOMOC TRUE)
    macro_add_file_dependencies("${_impl}" "${_moc}")

    list(APPEND ${_sources} "${_impl}" "${_header}" "${_moc}")
    set(${_sources} ${${_sources}} PARENT_SCOPE)
endfunction()