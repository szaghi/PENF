# This program is a part of EASIFEM library.
# See. www.easifem.com
# Copyright (c) 2020-2021, All right reserved, Vikas Sharma, Ph.D.
#

import os
import sys
import platform

def getOption(key, opt):
  while True:
    separator = ', '
    return input(f"select option for {key}, possible options are : {separator.join(opt)} : ") + " "

print("Detecting OS type...")
_os = platform.system()
if _os == 'Windows':
    print("ERROR: INSTALLATION on windows is work in progress")
    exit
    #print("Please use Windows Subsystem Linux(WSL) ")
    #print("Installation DONE!!")
else:
    cmake_def = ""
    opt = getOption("USE_OpenMP", ["ON", "OFF"])
    if(opt == " "):
        opt = "ON"
    cmake_def += " -DUSE_OpenMP=" + opt

    opt = getOption("CMAKE_BUILD_TYPE", ["Release", "Debug"])
    if(opt == " "):
        opt = "Release"
    cmake_def += " -DCMAKE_BUILD_TYPE=" + opt

    opt = getOption("BUILD_SHARED_LIBS", ["ON", "OFF"])
    if(opt == " "):
        opt = "ON"
    cmake_def += " -DBUILD_SHARED_LIBS=" + opt

    opt = getOption("CMAKE_INSTALL_PREFIX", ["${PREFIX}"])
    if( opt == " "):
    #   opt = "${HOME}/PENF"
      opt = "${EASIFEM_EXTPKGS}"
    cmake_def += " -DCMAKE_INSTALL_PREFIX=" + opt

    print("CMAKE DEF : ", cmake_def)

    os.system(f"cmake -S ./ -B ./build {cmake_def}")
    os.system(f"cmake --build ./build --target install")
    print("Installation DONE!!")
