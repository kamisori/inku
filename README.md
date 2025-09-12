## inku

### a janet binding for imgui

currently implemented:
 - glfw: `some% # joinked from jlfw`
 - openGL: `microscopic%`
 - ImGui: `enough-to-have-fun-with-but-not-ENOUGH-enough%`
 - ImGuiColorTextEdit: `you-can-instantiate-and-render-ONE-paste-some-text--edit-it-and-copy-it-back-out-again%`

### dependencies:
#### aka "these" boxes:

 - `Linux ayane 6.11.0-29-generic #29-Ubuntu SMP PREEMPT_DYNAMIC Fri Jun 13 20:29:41 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux` my desktop tower, towering on top of the cliff of my desks vertical add-on shelf-thingie
 - `Linux ryuko 6.1.0-38-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.147-1 (2025-08-02) x86_64 GNU/Linux` a thinkpad x220 that says x220i on its panel.. i checked as much as i could that it really did have the faster cpu, but idk and who cares anyway, i get scammed, you get scammed, we all get scammed, im trying to be honest over here
 - `Windows 10 BLUMENKOHL` .. idk much about this one right now... cant just ssh in there... its my wifes box, so yeah but:::
   - while setting up the build environment:
   - spork wouldnt install from `master`
     - because the cmath object file had an unresolved symbol: `_div128`


 - imgui: v1.91.4 # below text editor extension is blocking me from upgrading
 - ImGuiColorTextEdit: master  :fingers-crossed :hj
 - glfw: master
 - janet: master
 - jpm: master
 - spork: master


### build instructions:

make sure you have all libraries installed with development headers:
 - check the glfw documentation (<inkurootdir>/glfw/docs/compile.md) for build instructions and dependencies.

in glfw subdirectory: ( utterly optional btw :)

```
mkdir build
cd build
cmake -S ../ -B ./
cmake --build ./
```


the include path of glfw to your includepath for the next step to work, you may also just install libglfw3-dev


you should compile and run the following imgui example application to make sure everything looks and feels the same in inku and imgui:
 - <inkurootdir>/imgui/examples/example_glfw_opengl3/

(to me this is the lowest bar to entry for you into helping yourself to me helping you helping me helping you to get joinkyloinky to chooch on your box :3 if this example app compiles but the one made with janet doesnt, and you havent messed with the submodules' settings or sources: lets talk :)

in example directory: 

```
make
```

#### janet
you will also require janet (https://github.com/janet-lang/janet) on your path and jpm (https://github.com/janet-lang/jpm)

once you have prepared your system and can run the imgui example app, you may run `jpm run gen` and then `jpm test` in the <inkurootdir>
a native binary with a minimal test app will be put into the build folder along a module file that can be installed using `jpm install`

### usage:

my main reason to attempt the wgpu implementation was the future proofing novelty factor.
i dont remember why building the wgpu example or dawn failed on this machine.
but since vulkan is (abstraction wise speaking) close "enough" to wgpu and metal
and also since... well i dont care much about helping any company that doesnt pay me for my work, frankly and quite generally put: fuck capitalism. and yet i live in it, how curious.

right. pardon me turning this into a blog post, but im trying to give you some context for my thought process...


anyway, using code from another, earlier work of mine: jlfw, i started binding the vulkan implementation because of above reasons, when it occured to me:
while imgui handles most of the heavy lifting by letting me access its show-demo-widget function, openGL would not have all those neat abstractions, that vulkan is beckoning with, in favor of the most general cases like clearing the screen and drawing something another library cooked up while this janet binding tickled it in the background.

## tl;dr:


`(use joinkyloinky)` for the glfw + opengl3 implementation

example uses of what was bound so far can be found in the test directory in this repo

coming soonish:

`(use joinkyvoinky)` for the glfw + vulkan implementation


#### Credits to jaylib for most of the project.janet file ;3
#### Credits to imgui's ocornut for making the most awesome ui implementation out there (for use cases//)

and the other projects too :3


##### pls bear with my unprofessionality in favor of conviviality, but do express concerns if you have any.

otherwise, this tree is mine to piss on and bark at, if you want to join in and help the tree grow, give a yelp :3