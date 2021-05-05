# LessonsLearned
Lessons learned during dev


Vim
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

Visual Studio
- Do include clang support & other unix compatible tools
