all: compile link clean run

# Directory where the source files are located
SourceDirectory = build 
# Name of the final executable
ApplicationName = AIFA.exe 
# Mention the compiler you are using, e.g., g++, clang++, etc.
Compiler = g++
# Path to your SFML installation
SFML_DIR = C:\SFML-2.6.2

MINGW_Libraries = -lmingw32 
SFML_Libraries = -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lsfml-network -lsfml-main 

#-------------------------------------------------------------Compile-------------------------------------------------------------#

# Compile each .cpp into a .o
$(SourceDirectory)/%.o: $(SourceDirectory)/%.cpp
	$(Compiler) -I"$(SFML_DIR)\include" -c $< -o $@

SOURCES := $(wildcard $(SourceDirectory)/*.cpp)
OBJECTS := $(SOURCES:.cpp=.o)

# Compile target to trigger all object builds
compile: $(OBJECTS)
	@echo _____ All source files compiled.

#-------------------------------------------------------------Link-------------------------------------------------------------#

# Links the object files to create the final executable
link: 
	$(Compiler) -I"$(SFML_DIR)\include" $(SourceDirectory)/*.o -o $(ApplicationName) -L"$(SFML_DIR)\lib" $(MINGW_Libraries) $(SFML_Libraries)
	@echo _____ Linked object files to create the executable.

#-------------------------------------------------------------Clean-------------------------------------------------------------#

# Cleans up the build directory
clean: 
	del /Q "$(SourceDirectory)\*.o" 2>nul || exit 0
	@echo _____ Cleaned up object files.

#-------------------------------------------------------------Run-------------------------------------------------------------#

# Runs the application
run: 
	./$(ApplicationName)
	@echo _____ Application executed.