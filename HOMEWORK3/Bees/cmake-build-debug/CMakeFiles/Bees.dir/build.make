# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\JetBrains\CLion 2020.2.3\bin\cmake\win\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\JetBrains\CLion 2020.2.3\bin\cmake\win\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:\Users\snate\CLionProjects\Bees

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = C:\Users\snate\CLionProjects\Bees\cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/Bees.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Bees.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Bees.dir/flags.make

CMakeFiles/Bees.dir/main.cpp.obj: CMakeFiles/Bees.dir/flags.make
CMakeFiles/Bees.dir/main.cpp.obj: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:\Users\snate\CLionProjects\Bees\cmake-build-debug\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Bees.dir/main.cpp.obj"
	C:\PROGRA~1\MINGW-~1\X86_64~1.0-P\mingw64\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\Bees.dir\main.cpp.obj -c C:\Users\snate\CLionProjects\Bees\main.cpp

CMakeFiles/Bees.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Bees.dir/main.cpp.i"
	C:\PROGRA~1\MINGW-~1\X86_64~1.0-P\mingw64\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\snate\CLionProjects\Bees\main.cpp > CMakeFiles\Bees.dir\main.cpp.i

CMakeFiles/Bees.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Bees.dir/main.cpp.s"
	C:\PROGRA~1\MINGW-~1\X86_64~1.0-P\mingw64\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\snate\CLionProjects\Bees\main.cpp -o CMakeFiles\Bees.dir\main.cpp.s

# Object files for target Bees
Bees_OBJECTS = \
"CMakeFiles/Bees.dir/main.cpp.obj"

# External object files for target Bees
Bees_EXTERNAL_OBJECTS =

Bees.exe: CMakeFiles/Bees.dir/main.cpp.obj
Bees.exe: CMakeFiles/Bees.dir/build.make
Bees.exe: CMakeFiles/Bees.dir/linklibs.rsp
Bees.exe: CMakeFiles/Bees.dir/objects1.rsp
Bees.exe: CMakeFiles/Bees.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=C:\Users\snate\CLionProjects\Bees\cmake-build-debug\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable Bees.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\Bees.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Bees.dir/build: Bees.exe

.PHONY : CMakeFiles/Bees.dir/build

CMakeFiles/Bees.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\Bees.dir\cmake_clean.cmake
.PHONY : CMakeFiles/Bees.dir/clean

CMakeFiles/Bees.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" C:\Users\snate\CLionProjects\Bees C:\Users\snate\CLionProjects\Bees C:\Users\snate\CLionProjects\Bees\cmake-build-debug C:\Users\snate\CLionProjects\Bees\cmake-build-debug C:\Users\snate\CLionProjects\Bees\cmake-build-debug\CMakeFiles\Bees.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Bees.dir/depend
