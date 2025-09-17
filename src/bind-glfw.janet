(import spork/cjanet :as c)

(comment todo for glfw ( among others :3 ) :
         glfwGetCocoaWindow
         glfwGetCurrentContext

         glfwGetClipboardString
         glfwSetClipboardString

         glfwSetCharCallback
         glfwSetCursorPosCallback
         glfwSetErrorCallback
         glfwSetKeyCallback
         glfwSetMouseButtonCallback
         glfwSetScrollCallback
         glfwGetWindowAttrib)


(defn get-joinky-binding []
  (macex1
   (c/typedef KeyDef
              (struct
               name (const char*)
               key uint32_t)))

  (macex1
   (c/declare
    (glfw_window_hint_defs (array KeyDef)) "static const"
    @[
      @["accum-alpha-bits" 'GLFW_ACCUM_ALPHA_BITS]
      @["accum-blue-bits" 'GLFW_ACCUM_BLUE_BITS]
      @["accum-green-bits" 'GLFW_ACCUM_GREEN_BITS]
      @["accum-red-bits" 'GLFW_ACCUM_RED_BITS]
      @["alpha-bits" 'GLFW_ALPHA_BITS]
      @["auto-iconify" 'GLFW_AUTO_ICONIFY]
      @["aux-buffers" 'GLFW_AUX_BUFFERS]
      @["blue-bits" 'GLFW_BLUE_BITS]
      @["center-cursor" 'GLFW_CENTER_CURSOR]
      @["client-api" 'GLFW_CLIENT_API]
      @["cocoa-frame-name" 'GLFW_COCOA_FRAME_NAME]
      @["cocoa-graphics-switching" 'GLFW_COCOA_GRAPHICS_SWITCHING]
      @["cocoa-retina-framebuffer" 'GLFW_COCOA_RETINA_FRAMEBUFFER]
      @["context-creation-api" 'GLFW_CONTEXT_CREATION_API]
      @["context-debug" 'GLFW_CONTEXT_DEBUG]
      @["context-no-error" 'GLFW_CONTEXT_NO_ERROR]
      @["context-release-behavior" 'GLFW_CONTEXT_RELEASE_BEHAVIOR]
      @["context-revision" 'GLFW_CONTEXT_REVISION]
      @["context-robustness" 'GLFW_CONTEXT_ROBUSTNESS]
      @["context-version-major" 'GLFW_CONTEXT_VERSION_MAJOR]
      @["context-version-minor" 'GLFW_CONTEXT_VERSION_MINOR]
      @["decorated" 'GLFW_DECORATED]
      @["depth-bits" 'GLFW_DEPTH_BITS]
      @["doublebuffer" 'GLFW_DOUBLEBUFFER]
      @["floating" 'GLFW_FLOATING]
      @["focus-on-show" 'GLFW_FOCUS_ON_SHOW]
      @["focused" 'GLFW_FOCUSED]
      @["green-bits" 'GLFW_GREEN_BITS]
      @["maximized" 'GLFW_MAXIMIZED]
      @["mouse-passthrough" 'GLFW_MOUSE_PASSTHROUGH]
      @["opengl-debug-context" 'GLFW_OPENGL_DEBUG_CONTEXT]
      @["opengl-forward-compat" 'GLFW_OPENGL_FORWARD_COMPAT]
      @["opengl-profile" 'GLFW_OPENGL_PROFILE]
      @["position-x" 'GLFW_POSITION_X]
      @["position-y" 'GLFW_POSITION_Y]
      @["red-bits" 'GLFW_RED_BITS]
      @["refresh-rate" 'GLFW_REFRESH_RATE]
      @["resizable" 'GLFW_RESIZABLE]
      @["samples" 'GLFW_SAMPLES]
      @["scale-framebuffer" 'GLFW_SCALE_FRAMEBUFFER]
      @["scale-to-monitor" 'GLFW_SCALE_TO_MONITOR]
      @["srgb-capable" 'GLFW_SRGB_CAPABLE]
      @["stencil-bits" 'GLFW_STENCIL_BITS]
      @["stereo" 'GLFW_STEREO]
      @["transparent-framebuffer" 'GLFW_TRANSPARENT_FRAMEBUFFER]
      @["visible" 'GLFW_VISIBLE]
      @["wayland-app-id" 'GLFW_WAYLAND_APP_ID]
      @["win32-keyboard-menu" 'GLFW_WIN32_KEYBOARD_MENU]
      @["win32-showdefault" 'GLFW_WIN32_SHOWDEFAULT]
      @["x11-class-name" 'GLFW_X11_CLASS_NAME]
      @["x11-instance-name" 'GLFW_X11_INSTANCE_NAME]
      ]))

  (macex1
   (c/declare
    (glfw_window_attrib_defs (array KeyDef)) "static const"
    @[
      @["auto-iconify" GLFW_AUTO_ICONIFY]
      @["decorated" GLFW_DECORATED]
      @["floating" GLFW_FLOATING]
      @["focus-on-show" GLFW_FOCUS_ON_SHOW]
      @["focused" GLFW_FOCUSED]
      @["hovered" GLFW_HOVERED]
      @["iconified" GLFW_ICONIFIED]
      @["maximized" GLFW_MAXIMIZED]
      @["mouse-passthrough" GLFW_MOUSE_PASSTHROUGH]
      @["resizable" GLFW_RESIZABLE]
      @["transparent-framebuffer" GLFW_TRANSPARENT_FRAMEBUFFER]
      @["visible" GLFW_VISIBLE]
      ]))

  (macex1
   (c/declare
    (glfw_value_defs (array KeyDef)) "static const"
    @[
      @["angle-platform-type-d3d11" GLFW_ANGLE_PLATFORM_TYPE_D3D11]
      @["angle-platform-type-d3d9" GLFW_ANGLE_PLATFORM_TYPE_D3D9]
      @["angle-platform-type-metal" GLFW_ANGLE_PLATFORM_TYPE_METAL]
      @["angle-platform-type-none" GLFW_ANGLE_PLATFORM_TYPE_NONE]
      @["angle-platform-type-opengl" GLFW_ANGLE_PLATFORM_TYPE_OPENGL]
      @["angle-platform-type-opengles" GLFW_ANGLE_PLATFORM_TYPE_OPENGLES]
      @["angle-platform-type-vulkan" GLFW_ANGLE_PLATFORM_TYPE_VULKAN]
      @["any-position" GLFW_ANY_POSITION]
      @["any-release-behavior" GLFW_ANY_RELEASE_BEHAVIOR]
      @["cursor" GLFW_CURSOR]
      @["cursor-captured" GLFW_CURSOR_CAPTURED]
      @["cursor-disabled" GLFW_CURSOR_DISABLED]
      @["cursor-hidden" GLFW_CURSOR_HIDDEN]
      @["cursor-normal" GLFW_CURSOR_NORMAL]
      @["egl-context-api" GLFW_EGL_CONTEXT_API]
      @["lock-key-mods" GLFW_LOCK_KEY_MODS]
      @["lose-context-on-reset" GLFW_LOSE_CONTEXT_ON_RESET]
      @["native-context-api" GLFW_NATIVE_CONTEXT_API]
      @["no-api" GLFW_NO_API]
      @["no-reset-notification" GLFW_NO_RESET_NOTIFICATION]
      @["no-robustness" GLFW_NO_ROBUSTNESS]
      @["opengl-any-profile" GLFW_OPENGL_ANY_PROFILE]
      @["opengl-api" GLFW_OPENGL_API]
      @["opengl-compat-profile" GLFW_OPENGL_COMPAT_PROFILE]
      @["opengl-core-profile" GLFW_OPENGL_CORE_PROFILE]
      @["opengl-es-api" GLFW_OPENGL_ES_API]
      @["osmesa-context-api" GLFW_OSMESA_CONTEXT_API]
      @["raw-mouse-motion" GLFW_RAW_MOUSE_MOTION]
      @["release-behavior-flush" GLFW_RELEASE_BEHAVIOR_FLUSH]
      @["release-behavior-none" GLFW_RELEASE_BEHAVIOR_NONE]
      @["sticky-keys" GLFW_STICKY_KEYS]
      @["sticky-mouse-buttons" GLFW_STICKY_MOUSE_BUTTONS]
      @["unlimited-mouse-buttons" GLFW_UNLIMITED_MOUSE_BUTTONS]
      @["wayland-disable-libdecor" GLFW_WAYLAND_DISABLE_LIBDECOR]
      @["wayland-prefer-libdecor" GLFW_WAYLAND_PREFER_LIBDECOR]
     ]))

  (macex1   
   (c/function joinky_castdef
               :static
      [argv:Janet (definitions "const KeyDef*") (count int)] -> int
      (if (janet_checkint argv)
        (return (janet_unwrap_integer argv))
        (do
          (def (nameu (const uint8_t*)) (janet_getkeyword (addr argv) 0))
          (def (name (const char*)) (cast "const char*" nameu))
          (def (hi int) (- count 1))
          (def (lo int) 0)
          (while (<= lo hi)
            (def (mid int) (/ (+ lo hi) 2))
            (def (cmp int) (strcmp (. (aref definitions mid) name) name))
            (if (< cmp 0)
              (set lo (+ mid 1))
              (if (> cmp 0)
                (set hi (- mid 1))
                (return (. (aref definitions mid) key)))))
          (janet_panicf "unknown key :%s" name)))))

  (macex1
   (c/function joinky_getwindowhint
               :static
      [argv:Janet] -> int
      (return (joinky_castdef argv
                              glfw_window_hint_defs
                              (/ (sizeof glfw_window_hint_defs)
                                 (sizeof KeyDef))))))

  (macex1
   (c/function joinky_getwindowattrib
               :static
      [argv:Janet] -> int
      (return (joinky_castdef argv
                              glfw_window_attrib_defs
                              (/ (sizeof glfw_window_attrib_defs)
                                 (sizeof KeyDef))))))

  (macex1   
   (c/function joinky_getglfwvalue
               :static
      [argv:Janet] -> int
      (return (joinky_castdef argv
                              glfw_value_defs
                              (/ (sizeof glfw_value_defs)
                                 (sizeof KeyDef))))))

  (macex1   
   '(c/cfunction jlfw__get-error
     :static
       ```gets last error string
    see: https://www.glfw.org/docs/latest/intro_guide.html#error_handling```
     [] -> :Janet
       (def (description_p (const char*)))
     (def (result int (glfwGetError (addr description_p))))
     (if (== GLFW_NO_ERROR result)
       (return (janet_cstringv
                "Either GLFW was not yet initialized or there was genuinely no Error, i cannot tell."))
       (return (janet_cstringv description_p)))))

  ##################

  #we might need an abstract type to hold a initialized flag
  (macex1 '(c/cfunction jlfw__initialize-context
            :static
              ```Initializes the GLFW context,
    run once to setup the library.

    returns error on failure
    see: https://www.glfw.org/docs/latest/intro_guide.html#error_handling```
            [] -> :Janet
              (if (glfwInit)
                (return (janet_wrap_boolean :true))
                (return (jlfw__get_error)))))

  (macex1
   '(c/cfunction jlfw__terminate-context
     :static
       ```Terminates the GLFW context,
    run once to shutdown the context.
    If you need GLFW afterwards, call init again to start it back up.

    If init failed, this does not have to be called.

    ---
    TODO: maybe a convenience script/macro for init+terminate? https://janet-lang.org/api/index.html#with```
     [] -> :Janet
       (glfwTerminate)
     (return (janet_wrap_nil))) )

  (macex1  '(c/cfunction jlfw__create-window
             :static
               ```Creates a window (* GLFWwindow)
    hosted by the previously initialized GLFW3 context.

    optionally takes a monitor (* GLFWmonitor)
    to enable true fullscreen, give a monitor you retrieved here:
    https://www.glfw.org/docs/latest/monitor_guide.html#monitor_monitors

    and a share of a window (* GLFWwindow)
    to share its context objects with:
    https://www.glfw.org/docs/latest/context_guide.html#context_sharing

    Returns a wrapped pointer to the window object inside glfwspace.```
             [width:int
              height:int
              title:cstring
              &opt (monitor :pointer NULL)
              (share :pointer NULL)] -> :Janet
               (def (result GLFWwindow*) (cast GLFWwindow* (glfwCreateWindow width
                                                                             height
                                                                             title
                                                                             (cast GLFWmonitor* monitor)
                                                                             (cast GLFWwindow* share))))
             (if result 
               (return (janet_wrap_pointer result))
               (return (jlfw__get_error))))
            #################
            )

  (macex1
   '(c/cfunction jlfw__destroy-window
     :static
       "Destroys a previously created window."
     [&opt (window :pointer NULL)] -> :Janet
       (glfwDestroyWindow (cast GLFWwindow* window))
     (return (janet_wrap_nil)))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__hint-next-window
     :static
       "gives hints to the next call to create-window. [keywords to be implemented](https://www.glfw.org/docs/latest/window_guide.html#window_hints)"
     [hint:Janet value:Janet] -> :Janet
       (glfwWindowHint (joinky_getwindowhint hint) (joinky_getglfwvalue value))
     (return (janet_wrap_nil)))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__close-window?
     :static
       "returns whether or not the window is supposed to close"
     [window:pointer] -> :Janet
       (return
        (janet_wrap_boolean
         (glfwWindowShouldClose
          (cast GLFWwindow* window)))))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__poll-events
     :static
       "polls for events"
     [] -> :Janet
       (glfwPollEvents)
     (return (janet_wrap_nil)))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__get-version
     :static
       "gets version string, which contains supported platforms"
     [] -> :Janet
       (return (janet_cstringv (glfwGetVersionString))))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__get-primary-monitor
     :static
       "gets pointer to primary monitor"
     [] -> :Janet
       (return (janet_wrap_pointer (glfwGetPrimaryMonitor))))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__init-hint
     :static
       "hint for initialize-context"
     [hint:int value:int] -> :Janet
       (glfwInitHint hint value)
     (return (janet_wrap_nil)))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__make-context-current
     :static
       "makes the given windows context current"
     [window:pointer] -> :Janet
       (glfwMakeContextCurrent (cast GLFWwindow* window))
     (return (janet_wrap_nil)))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__get-key
     :static
       "gets last reported state on this key"
     [window:pointer key:int] -> :Janet
       (return (janet_wrap_integer (glfwGetKey (cast GLFWwindow* window) key))))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__get-mouse-button
     :static
       "gets last reported state on this mouse button"
     [window:pointer button:int] -> :Janet
       (return (janet_wrap_integer (glfwGetMouseButton (cast GLFWwindow* window) button))))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__swap-buffers
     :static
       "swaps buffers"
     [window:pointer] -> :Janet
       (glfwSwapBuffers (cast GLFWwindow* window))
     (return (janet_wrap_nil)))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__swap-interval
     :static
       "sets interval between buffer swaps"
     [interval:int] -> :Janet
       (glfwSwapInterval interval)
     (return (janet_wrap_nil)))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__get-cursor-position
     :static
       "gets current cursor position relative to the window"
     [window:pointer] -> :Janet
       (def (xpos double))
     (def (ypos double))
     (def (result Janet*) (janet_tuple_begin 2))
     (glfwGetCursorPos (cast GLFWwindow* window) (addr xpos) (addr ypos))
     (set (aref result 0) (janet_wrap_number xpos))
     (set (aref result 1) (janet_wrap_number ypos))
     (return (janet_wrap_tuple (janet_tuple_end result))))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__get-framebuffer-size
     :static
       "returns size of the framebuffer backing the window"
     [window:pointer] -> :Janet
       (def (width int))
     (def (height int))
     (def (result Janet*) (janet_tuple_begin 2))
     (glfwGetFramebufferSize (cast GLFWwindow* window) (addr width) (addr height))
     (set (aref result 0) (janet_wrap_number width))
     (set (aref result 1) (janet_wrap_number height))
     (return (janet_wrap_tuple (janet_tuple_end result))))
   #######################################
   )

  (macex1
   '(c/cfunction jlfw__get-window-attrib
     :static
       "returns some window attribute"
     [window:pointer attrib:Janet] -> :Janet
       (return (janet_wrap_integer (glfwGetWindowAttrib (cast GLFWwindow* window)
                                                        (joinky_getwindowattrib attrib)))))
   )
)
