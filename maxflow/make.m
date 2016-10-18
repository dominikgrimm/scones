%MAKE   Compiles the maxflowmex library.
%   
%   (c) 2008 Michael Rubinstein, WDI R&D and IDC
%   $Revision: 130 $
%   $Date: 2008-09-02 17:10:31 -0700 (Tue, 02 Sep 2008) $
%

mex -v -g -O -largeArrayDims CC='gcc' LD='gcc' CXX='g++' CXXFLAGS='-fno-common -no-cpp-precomp -fexceptions -fno-implicit-templates -arch x86_64 -isysroot /Developer/SDKs/MacOSX10.7.sdk' CFLAGS='-fno-common -no-cpp-precomp -arch x86_64 -isysroot /Developer/SDKs/MacOSX10.7.sdk -fexceptions -fno-implicit-templates' LDFLAGS='-Wl -fno-implicit-templates,-twolevel_namespace -undefined error -arch x86_64 -Wl,-syslibroot,/Developer/SDKs/MacOSX10.7.sdk -bundle -Wl,-exported_symbols_list,/agbs/share/sw/matlabR2010a/extern/lib/maci64/mexFunction.map' maxflowmex.cpp graph.cpp  maxflow.cpp 
