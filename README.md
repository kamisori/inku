# build instructions:

to make sure you have all libraries installed:
 - check the glfw documentation (<inkurootdir>/glfw/docs/compile.md) for build instructions and dependencies.

you should compile and run the following imgui example application to make sure everything looks and feels the same in inku and imgui:
 - <inkurootdir>/imgui/examples/example_glfw_opengl3/

you will also require a janet (https://github.com/janet-lang/janet) implementation on your path + jpm (https://github.com/janet-lang/jpm)

once you have prepared your system and can run the imgui example app, you may run `jpm run gen` and then `jpm test` in the <inkurootdir>.