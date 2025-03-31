# Introduction
This is the auto-profiling script for C code based on gprof and gprof2dot.
The script will detect executable file automatically and generate the PDF filr of profiled result.

# Dependencies
You should install pip3 and Python3 first.

For Ubuntu, run following commands.
```
sudo apt update
sudo apt upgrade
sudo apt install gprof 
pip3 install gprof2dot
```

For macOS, run following command. You have to install Homebrew first. We should use GNU GCC to use gprof.
```
brew install gcc gprof2dot
```

# How to use
First, create a Makefile in the root direcroty.
Make sure that the executable file is generated in the `build` directory.
If not, you have to edit the `BUILD_DIR` variable in `auto_prof.sh`.

The type of executable file does not matter. It works well with both of `.out` and no-type(for Ubuntu).

Then, run `auto_prof.sh` and enter a name of result file name you want. It will generate the PDF file automatically with the name you entered.

