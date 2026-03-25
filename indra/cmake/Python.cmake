# Allow explicit Python path via environment variable
if(DEFINED ENV{PYTHON})
    set(Python3_ROOT_DIR "$ENV{PYTHON}")
elseif(DEFINED ENV{VIRTUAL_ENV})
    # FindPython3's default VERSION strategy picks the newest system Python (e.g. 3.14 on
    # PATH) over an older interpreter inside an activated venv. Constrain search to the venv.
    set(Python3_ROOT_DIR "$ENV{VIRTUAL_ENV}")
endif()

# On Windows, prefer registry entries to avoid Cygwin/MSYS Python
# The registry is searched first by default, which finds native Windows Python
# installations rather than Cygwin/MSYS Python
if(WINDOWS)
    set(Python3_FIND_REGISTRY FIRST CACHE STRING "Python search order")
endif()

# Find Python 3 interpreter
find_package(Python3 REQUIRED COMPONENTS Interpreter)

# Set legacy variable name for compatibility with existing code
# FORCE: without it, a previously cached PYTHON_EXECUTABLE is never updated when discovery
# changes (e.g. after activating a venv or upgrading Python).
set(PYTHON_EXECUTABLE "${Python3_EXECUTABLE}" CACHE FILEPATH "Python interpreter for builds" FORCE)
mark_as_advanced(PYTHON_EXECUTABLE)
