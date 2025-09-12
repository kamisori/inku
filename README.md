

## build instructions:

### dependencies:

imgui: v1.91.4
ImGuiColorTextEdit: master
glfw: master


make sure you have all libraries installed with development headers:
 - check the glfw documentation (<inkurootdir>/glfw/docs/compile.md) for build instructions and dependencies.

in glfw subdirectory:
```
mkdir build
cd build
cmake -S ../ -B ./
cmake --build ./
```


the include path of glfw to your includepath for the next step to work, you may also just install libglfw3-dev


you should compile and run the following imgui example application to make sure everything looks and feels the same in inku and imgui:
 - <inkurootdir>/imgui/examples/example_glfw_opengl3/
 
in example directory:
```
make
```

### janet
you will also require janet (https://github.com/janet-lang/janet) on your path and jpm (https://github.com/janet-lang/jpm)

once you have prepared your system and can run the imgui example app, you may run `jpm run gen` and then `jpm test` in the <inkurootdir>
a native binary with a minimal test app will be put into the build folder along a module file that can be installed using `jpm install`