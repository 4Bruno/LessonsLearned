# LessonsLearned
Lessons learned during dev

General
- Was easier to me to make my own build with python dyn
- Vim Functions are a pain in the ass
- Passing data from python to vim with all those eval/execute commands: No fun

Coding in C/C++
- clang_complete has all you need
- compilation flags file setup can be as simple as a file with include folder:
/I..\include

Pre-built setup
- Maintained .exe is 32bit with +py3-dyn. Your py3.dll must be 32 bit and you need to specify it in your .vimrc
- Check which python version is expected by reading gvim.exe and search pattern "python\d*.dll\c" (most likely 3.6)
- Create your .vimrc
- Create your .vim\
- Create your .vim\colors
- Create your .vim\bundle
- Download solarized colorscheme and copy to bundle
- Include in .vimrc:
-   set pythonthreehome=~/AppData/Local/Programs/Python/Python36-32
-   set pythonthreedll=~/AppData/Local/Programs/Python/Python36-32/python36.dll
- Check which vim.exe is actually in use :). Git installs and adds to path its own git.exe (x64)

Building from source
- Clone vim
- Install vs community
- need all c++ tools
- In cmd line run script for vars "vcvars64.bat" in visual studio folder (use command inside folder):
dir /s/b *vcvars*
- compile cmd:
nmake -f Make_mvc.mak PYTHON3=C:\Python36 DYNAMIC_PYTHON3=yes PYTHON3_VER=36
