# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

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

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/pnotz17/Transmission

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pnotz17/Transmission/build

# Include any dependencies generated for this target.
include daemon/CMakeFiles/transmission-daemon.dir/depend.make

# Include the progress variables for this target.
include daemon/CMakeFiles/transmission-daemon.dir/progress.make

# Include the compile flags for this target's objects.
include daemon/CMakeFiles/transmission-daemon.dir/flags.make

daemon/CMakeFiles/transmission-daemon.dir/daemon.c.o: daemon/CMakeFiles/transmission-daemon.dir/flags.make
daemon/CMakeFiles/transmission-daemon.dir/daemon.c.o: ../daemon/daemon.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pnotz17/Transmission/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object daemon/CMakeFiles/transmission-daemon.dir/daemon.c.o"
	cd /home/pnotz17/Transmission/build/daemon && /bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/transmission-daemon.dir/daemon.c.o -c /home/pnotz17/Transmission/daemon/daemon.c

daemon/CMakeFiles/transmission-daemon.dir/daemon.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/transmission-daemon.dir/daemon.c.i"
	cd /home/pnotz17/Transmission/build/daemon && /bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pnotz17/Transmission/daemon/daemon.c > CMakeFiles/transmission-daemon.dir/daemon.c.i

daemon/CMakeFiles/transmission-daemon.dir/daemon.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/transmission-daemon.dir/daemon.c.s"
	cd /home/pnotz17/Transmission/build/daemon && /bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pnotz17/Transmission/daemon/daemon.c -o CMakeFiles/transmission-daemon.dir/daemon.c.s

daemon/CMakeFiles/transmission-daemon.dir/daemon-posix.c.o: daemon/CMakeFiles/transmission-daemon.dir/flags.make
daemon/CMakeFiles/transmission-daemon.dir/daemon-posix.c.o: ../daemon/daemon-posix.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pnotz17/Transmission/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object daemon/CMakeFiles/transmission-daemon.dir/daemon-posix.c.o"
	cd /home/pnotz17/Transmission/build/daemon && /bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/transmission-daemon.dir/daemon-posix.c.o -c /home/pnotz17/Transmission/daemon/daemon-posix.c

daemon/CMakeFiles/transmission-daemon.dir/daemon-posix.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/transmission-daemon.dir/daemon-posix.c.i"
	cd /home/pnotz17/Transmission/build/daemon && /bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pnotz17/Transmission/daemon/daemon-posix.c > CMakeFiles/transmission-daemon.dir/daemon-posix.c.i

daemon/CMakeFiles/transmission-daemon.dir/daemon-posix.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/transmission-daemon.dir/daemon-posix.c.s"
	cd /home/pnotz17/Transmission/build/daemon && /bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pnotz17/Transmission/daemon/daemon-posix.c -o CMakeFiles/transmission-daemon.dir/daemon-posix.c.s

# Object files for target transmission-daemon
transmission__daemon_OBJECTS = \
"CMakeFiles/transmission-daemon.dir/daemon.c.o" \
"CMakeFiles/transmission-daemon.dir/daemon-posix.c.o"

# External object files for target transmission-daemon
transmission__daemon_EXTERNAL_OBJECTS =

daemon/transmission-daemon: daemon/CMakeFiles/transmission-daemon.dir/daemon.c.o
daemon/transmission-daemon: daemon/CMakeFiles/transmission-daemon.dir/daemon-posix.c.o
daemon/transmission-daemon: daemon/CMakeFiles/transmission-daemon.dir/build.make
daemon/transmission-daemon: libtransmission/libtransmission.a
daemon/transmission-daemon: /usr/lib/libevent-2.1.so
daemon/transmission-daemon: /usr/lib/libsystemd.so
daemon/transmission-daemon: /usr/lib/libz.so
daemon/transmission-daemon: /usr/lib/libssl.so
daemon/transmission-daemon: /usr/lib/libcrypto.so
daemon/transmission-daemon: /usr/lib/libevent-2.1.so
daemon/transmission-daemon: /usr/lib/libcurl.so
daemon/transmission-daemon: third-party/natpmp/lib/libnatpmp.a
daemon/transmission-daemon: third-party/miniupnpc/lib/libminiupnpc.a
daemon/transmission-daemon: third-party/dht/lib/libdht.a
daemon/transmission-daemon: third-party/utp/lib/libutp.a
daemon/transmission-daemon: third-party/b64/lib/libb64.a
daemon/transmission-daemon: /usr/lib/libc.so
daemon/transmission-daemon: daemon/CMakeFiles/transmission-daemon.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pnotz17/Transmission/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable transmission-daemon"
	cd /home/pnotz17/Transmission/build/daemon && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/transmission-daemon.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
daemon/CMakeFiles/transmission-daemon.dir/build: daemon/transmission-daemon

.PHONY : daemon/CMakeFiles/transmission-daemon.dir/build

daemon/CMakeFiles/transmission-daemon.dir/clean:
	cd /home/pnotz17/Transmission/build/daemon && $(CMAKE_COMMAND) -P CMakeFiles/transmission-daemon.dir/cmake_clean.cmake
.PHONY : daemon/CMakeFiles/transmission-daemon.dir/clean

daemon/CMakeFiles/transmission-daemon.dir/depend:
	cd /home/pnotz17/Transmission/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pnotz17/Transmission /home/pnotz17/Transmission/daemon /home/pnotz17/Transmission/build /home/pnotz17/Transmission/build/daemon /home/pnotz17/Transmission/build/daemon/CMakeFiles/transmission-daemon.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : daemon/CMakeFiles/transmission-daemon.dir/depend

