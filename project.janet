( declare-project
  :name "inku"
  :description "bindings for ocornut/imgui"
  :url "https://awesemble.de"
  :author "Janet Brüll <mlatu@mlatu.de>")


(def this-os (os/which))

(def cflags
  (case this-os
    :macos '["-Iglfw/src" "-Iglfw/include" "-ObjC"]
    :windows ["-Iglfw/src" "-Iglfw/include"]
    :openbsd '["-Iglfw/src" "-Iglfw/include" "-I/usr/X11R6/include" "-Du_char=unsigned char" "-Dalloca(x)=malloc(x)"]    
    #default
    '["-Iglfw/src" "-Iglfw/include" "-Iimgui" "-Iimgui/backends" "-IImGuiColorTextEdit"]))

(def lflags
  (case this-os
    :windows '["user32.lib" "gdi32.lib" "winmm.lib" "shell32.lib"]
    :macos '["-lpthread" "-framework" "Cocoa" "-framework" "CoreVideo" "-framework" "IOKit" "-framework" "OpenGL"]
    :linux '["-lpthread" "-lX11"]
    :openbsd '["-lpthread" "-lX11" "-L/usr/X11R6/lib"]
    #default
    '["-lpthread"]))

(def source-files
  ["imgui/imgui.cpp"
   "imgui/imgui_demo.cpp"
   "imgui/imgui_draw.cpp"
   "imgui/imgui_tables.cpp"
   "imgui/imgui_widgets.cpp"
   "imgui/backends/imgui_impl_glfw.cpp"
   "imgui/backends/imgui_impl_opengl3.cpp"
   "ImGuiColorTextEdit/TextEditor.cpp"
   "glfw/src/context.c"
   "glfw/src/egl_context.c"
   "glfw/src/glx_context.c"
   "glfw/src/init.c"
   "glfw/src/input.c"
   "glfw/src/monitor.c"
   "glfw/src/platform.c"
   "glfw/src/window.c"
   "glfw/src/osmesa_context.c"
   "glfw/src/vulkan.c"
   "glfw/src/wgl_context.c"
   "glfw/src/null_init.c"
   "glfw/src/null_joystick.c"
   "glfw/src/null_monitor.c"
   "glfw/src/null_window.c"
   ;(case this-os
      :macos   ["glfw/src/cocoa_time.c"]

      :windows ["glfw/src/win32_init.c"
                "glfw/src/win32_joystick.c"
                "glfw/src/win32_module.c"
                "glfw/src/win32_monitor.c"
                "glfw/src/win32_thread.c"
                "glfw/src/win32_time.c"
                "glfw/src/win32_window.c"]
      # linux
      ["glfw/src/linux_joystick.c"
       "glfw/src/posix_module.c"
       "glfw/src/posix_poll.c"
       "glfw/src/posix_thread.c"
       "glfw/src/posix_time.c"
       "glfw/src/wl_init.c"
       "glfw/src/wl_monitor.c"
       "glfw/src/wl_window.c"
       "glfw/src/x11_init.c"
       "glfw/src/x11_monitor.c"
       "glfw/src/x11_window.c"
       "glfw/src/xkb_unicode.c"
      ])])

(def header-files
  ["glfw/include/GLFW/glfw3.h"
   "glfw/include/GLFW/glfw3native.h"
   "glfw/src/internal.h"
   "glfw/src/mappings.h"
   "glfw/src/platform.h"
   "glfw/src/null_joystick.h"
   "glfw/src/null_platform.h"
   ;(case this-os
      :macos   ["glfw/src/cocoa_joystick.h"
                "glfw/src/cocoa_platform.h"
                "glfw/src/cocoa_time.h"]
      :windows ["glfw/src/win32_joystick.h"
                "glfw/src/win32_platform.h"
                "glfw/src/win32_thread.h"
                "glfw/src/win32_time.h"]
      :linux
       ["glfw/src/linux_joystick.h"
        "glfw/src/posix_poll.h"
        "glfw/src/posix_thread.h"
        "glfw/src/posix_time.h"
        "glfw/src/wl_platform.h"
        "glfw/src/x11_platform.h"
        "glfw/src/xkb_unicode.h"
       ])])

(def glfw-platform-define (case this-os
              :macos "_GLFW_COCOA"
              :windows "_GLFW_WIN32"
              :linux "_GLFW_X11" #"_GLFW_WAYLAND"
              ))

(declare-native
 :name "joinkyloinky"
 
 :cflags [;default-cflags
          ;cflags]
 
 :cppflags [;default-cppflags
          ;cflags]
 
 :defines { glfw-platform-define true
           "_POSIX_C_SOURCE" "200809L"
           "_DARWIN_C_SOURCE" (if (= this-os :macos) "1" nil)
           "_GNU_SOURCE" true}
 
 :source ["src/generated_glfw_and_opengl3.cpp" ;source-files]

 :headers header-files

 :lflags [;default-lflags
          ;lflags  "-lGL"])


(comment declare-native
 :name "joinkyvoinky"
 
 :cflags [;default-cflags
          ;cflags]
 
 :cppflags [;default-cppflags
          ;cflags]
 
 :defines { glfw-platform-define true
           "_POSIX_C_SOURCE" "200809L"
           "_DARWIN_C_SOURCE" (if (= this-os :macos) "1" nil)
           "_GNU_SOURCE" true}

 :source ["src/generated_glfw_and_vulkan.cpp" ;source-files]

 :headers header-files

 :lflags [;default-lflags
          ;lflags])

(phony "gen" []
       (os/execute ["janet" "src/bind-inku.janet"] :p)
       #       (os/execute ["janet" "src/bind-vk.janet"] :p)
       )

(phony "tst" ["gen" "build"]
       (os/execute ["jpm" "test"] :p)
       (os/cd "example")
       #(os/execute ["sh" "-c" "\"cd example && jpm build && cd ..\""] :p)
       (os/execute ["jpm" "build"] :p)
       )



# `jpm run repl` to run a repl with access to some imgui implementation binding :3
(phony "repl" ["gen" "build"]
       (os/execute ["janet" "-l" "./build/joinkyloinky"
                            #"-l" "./build/joinkyvoinky"
                   ] :p))
