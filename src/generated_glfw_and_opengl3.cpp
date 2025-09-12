#include <janet.h>
#include <stdbool.h>
#include "GLFW/glfw3.h"
#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include "TextEditor.h"

typedef struct {
  const char* name;
  uint key;
} KeyDef;
static const KeyDef glfw_window_hint_defs[] = {
  {
    "accum-alpha-bits", 
    GLFW_ACCUM_ALPHA_BITS
  }, 
  {
    "accum-blue-bits", 
    GLFW_ACCUM_BLUE_BITS
  }, 
  {
    "accum-green-bits", 
    GLFW_ACCUM_GREEN_BITS
  }, 
  {
    "accum-red-bits", 
    GLFW_ACCUM_RED_BITS
  }, 
  {
    "alpha-bits", 
    GLFW_ALPHA_BITS
  }, 
  {
    "auto-iconify", 
    GLFW_AUTO_ICONIFY
  }, 
  {
    "aux-buffers", 
    GLFW_AUX_BUFFERS
  }, 
  {
    "blue-bits", 
    GLFW_BLUE_BITS
  }, 
  {
    "center-cursor", 
    GLFW_CENTER_CURSOR
  }, 
  {
    "client-api", 
    GLFW_CLIENT_API
  }, 
  {
    "cocoa-frame-name", 
    GLFW_COCOA_FRAME_NAME
  }, 
  {
    "cocoa-graphics-switching", 
    GLFW_COCOA_GRAPHICS_SWITCHING
  }, 
  {
    "cocoa-retina-framebuffer", 
    GLFW_COCOA_RETINA_FRAMEBUFFER
  }, 
  {
    "context-creation-api", 
    GLFW_CONTEXT_CREATION_API
  }, 
  {
    "context-debug", 
    GLFW_CONTEXT_DEBUG
  }, 
  {
    "context-no-error", 
    GLFW_CONTEXT_NO_ERROR
  }, 
  {
    "context-release-behavior", 
    GLFW_CONTEXT_RELEASE_BEHAVIOR
  }, 
  {
    "context-revision", 
    GLFW_CONTEXT_REVISION
  }, 
  {
    "context-robustness", 
    GLFW_CONTEXT_ROBUSTNESS
  }, 
  {
    "context-version-major", 
    GLFW_CONTEXT_VERSION_MAJOR
  }, 
  {
    "context-version-minor", 
    GLFW_CONTEXT_VERSION_MINOR
  }, 
  {
    "decorated", 
    GLFW_DECORATED
  }, 
  {
    "depth-bits", 
    GLFW_DEPTH_BITS
  }, 
  {
    "doublebuffer", 
    GLFW_DOUBLEBUFFER
  }, 
  {
    "floating", 
    GLFW_FLOATING
  }, 
  {
    "focus-on-show", 
    GLFW_FOCUS_ON_SHOW
  }, 
  {
    "focused", 
    GLFW_FOCUSED
  }, 
  {
    "green-bits", 
    GLFW_GREEN_BITS
  }, 
  {
    "maximized", 
    GLFW_MAXIMIZED
  }, 
  {
    "mouse-passthrough", 
    GLFW_MOUSE_PASSTHROUGH
  }, 
  {
    "opengl-debug-context", 
    GLFW_OPENGL_DEBUG_CONTEXT
  }, 
  {
    "opengl-forward-compat", 
    GLFW_OPENGL_FORWARD_COMPAT
  }, 
  {
    "opengl-profile", 
    GLFW_OPENGL_PROFILE
  }, 
  {
    "position-x", 
    GLFW_POSITION_X
  }, 
  {
    "position-y", 
    GLFW_POSITION_Y
  }, 
  {
    "red-bits", 
    GLFW_RED_BITS
  }, 
  {
    "refresh-rate", 
    GLFW_REFRESH_RATE
  }, 
  {
    "resizable", 
    GLFW_RESIZABLE
  }, 
  {
    "samples", 
    GLFW_SAMPLES
  }, 
  {
    "scale-framebuffer", 
    GLFW_SCALE_FRAMEBUFFER
  }, 
  {
    "scale-to-monitor", 
    GLFW_SCALE_TO_MONITOR
  }, 
  {
    "srgb-capable", 
    GLFW_SRGB_CAPABLE
  }, 
  {
    "stencil-bits", 
    GLFW_STENCIL_BITS
  }, 
  {
    "stereo", 
    GLFW_STEREO
  }, 
  {
    "transparent-framebuffer", 
    GLFW_TRANSPARENT_FRAMEBUFFER
  }, 
  {
    "visible", 
    GLFW_VISIBLE
  }, 
  {
    "wayland-app-id", 
    GLFW_WAYLAND_APP_ID
  }, 
  {
    "win32-keyboard-menu", 
    GLFW_WIN32_KEYBOARD_MENU
  }, 
  {
    "win32-showdefault", 
    GLFW_WIN32_SHOWDEFAULT
  }, 
  {
    "x11-class-name", 
    GLFW_X11_CLASS_NAME
  }, 
  {
    "x11-instance-name", 
    GLFW_X11_INSTANCE_NAME
  }
};
static const KeyDef glfw_window_attrib_defs[] = {
  {
    "auto-iconify", 
    GLFW_AUTO_ICONIFY
  }, 
  {
    "decorated", 
    GLFW_DECORATED
  }, 
  {
    "floating", 
    GLFW_FLOATING
  }, 
  {
    "focus-on-show", 
    GLFW_FOCUS_ON_SHOW
  }, 
  {
    "focused", 
    GLFW_FOCUSED
  }, 
  {
    "hovered", 
    GLFW_HOVERED
  }, 
  {
    "iconified", 
    GLFW_ICONIFIED
  }, 
  {
    "maximized", 
    GLFW_MAXIMIZED
  }, 
  {
    "mouse-passthrough", 
    GLFW_MOUSE_PASSTHROUGH
  }, 
  {
    "resizable", 
    GLFW_RESIZABLE
  }, 
  {
    "transparent-framebuffer", 
    GLFW_TRANSPARENT_FRAMEBUFFER
  }, 
  {
    "visible", 
    GLFW_VISIBLE
  }
};
static const KeyDef glfw_value_defs[] = {
  {
    "angle-platform-type-d3d11", 
    GLFW_ANGLE_PLATFORM_TYPE_D3D11
  }, 
  {
    "angle-platform-type-d3d9", 
    GLFW_ANGLE_PLATFORM_TYPE_D3D9
  }, 
  {
    "angle-platform-type-metal", 
    GLFW_ANGLE_PLATFORM_TYPE_METAL
  }, 
  {
    "angle-platform-type-none", 
    GLFW_ANGLE_PLATFORM_TYPE_NONE
  }, 
  {
    "angle-platform-type-opengl", 
    GLFW_ANGLE_PLATFORM_TYPE_OPENGL
  }, 
  {
    "angle-platform-type-opengles", 
    GLFW_ANGLE_PLATFORM_TYPE_OPENGLES
  }, 
  {
    "angle-platform-type-vulkan", 
    GLFW_ANGLE_PLATFORM_TYPE_VULKAN
  }, 
  {
    "any-position", 
    GLFW_ANY_POSITION
  }, 
  {
    "any-release-behavior", 
    GLFW_ANY_RELEASE_BEHAVIOR
  }, 
  {
    "cursor", 
    GLFW_CURSOR
  }, 
  {
    "cursor-captured", 
    GLFW_CURSOR_CAPTURED
  }, 
  {
    "cursor-disabled", 
    GLFW_CURSOR_DISABLED
  }, 
  {
    "cursor-hidden", 
    GLFW_CURSOR_HIDDEN
  }, 
  {
    "cursor-normal", 
    GLFW_CURSOR_NORMAL
  }, 
  {
    "egl-context-api", 
    GLFW_EGL_CONTEXT_API
  }, 
  {
    "lock-key-mods", 
    GLFW_LOCK_KEY_MODS
  }, 
  {
    "lose-context-on-reset", 
    GLFW_LOSE_CONTEXT_ON_RESET
  }, 
  {
    "native-context-api", 
    GLFW_NATIVE_CONTEXT_API
  }, 
  {
    "no-api", 
    GLFW_NO_API
  }, 
  {
    "no-reset-notification", 
    GLFW_NO_RESET_NOTIFICATION
  }, 
  {
    "no-robustness", 
    GLFW_NO_ROBUSTNESS
  }, 
  {
    "opengl-any-profile", 
    GLFW_OPENGL_ANY_PROFILE
  }, 
  {
    "opengl-api", 
    GLFW_OPENGL_API
  }, 
  {
    "opengl-compat-profile", 
    GLFW_OPENGL_COMPAT_PROFILE
  }, 
  {
    "opengl-core-profile", 
    GLFW_OPENGL_CORE_PROFILE
  }, 
  {
    "opengl-es-api", 
    GLFW_OPENGL_ES_API
  }, 
  {
    "osmesa-context-api", 
    GLFW_OSMESA_CONTEXT_API
  }, 
  {
    "raw-mouse-motion", 
    GLFW_RAW_MOUSE_MOTION
  }, 
  {
    "release-behavior-flush", 
    GLFW_RELEASE_BEHAVIOR_FLUSH
  }, 
  {
    "release-behavior-none", 
    GLFW_RELEASE_BEHAVIOR_NONE
  }, 
  {
    "sticky-keys", 
    GLFW_STICKY_KEYS
  }, 
  {
    "sticky-mouse-buttons", 
    GLFW_STICKY_MOUSE_BUTTONS
  }, 
  {
    "unlimited-mouse-buttons", 
    GLFW_UNLIMITED_MOUSE_BUTTONS
  }, 
  {
    "wayland-disable-libdecor", 
    GLFW_WAYLAND_DISABLE_LIBDECOR
  }, 
  {
    "wayland-prefer-libdecor", 
    GLFW_WAYLAND_PREFER_LIBDECOR
  }
};

/*  */
static int joinky_castdef(Janet argv, const KeyDef* defs, int count)
{
  if (janet_checkint(argv)) {
    return janet_unwrap_integer(argv);
  } else {
    {
      const uint8_t* nameu = janet_getkeyword(&argv, 0);
      const char* name = (const char*)nameu;
      int hi = count - 1;
      int lo = 0;
      while (lo <= hi)       {
        int mid = (lo + hi) / 2;
        int cmp = strcmp((defs[mid]).name, name);
        if (cmp < 0) {
          lo = (mid + 1);
        } else {
          if (cmp > 0) {
            hi = (mid - 1);
          } else {
            return (defs[mid]).key;
          }
        }
      }

      janet_panicf("unknown key :%s", name);
    }
  }
}
/*  */
static int joinky_getwindowhint(Janet argv)
{
  return joinky_castdef(argv, glfw_window_hint_defs, (sizeof(glfw_window_hint_defs)) / (sizeof(KeyDef)));
}
/*  */
static int joinky_getwindowattrib(Janet argv)
{
  return joinky_castdef(argv, glfw_window_attrib_defs, (sizeof(glfw_window_attrib_defs)) / (sizeof(KeyDef)));
}
/*  */
static int joinky_getglfwvalue(Janet argv)
{
  return joinky_castdef(argv, glfw_value_defs, (sizeof(glfw_value_defs)) / (sizeof(KeyDef)));
}
/* gets last error string
    see: https://www.glfw.org/docs/latest/intro_guide.html#error_handling */
static Janet jlfw__get_error()
{
  const char* description_p;
  int result;
  if (GLFW_NO_ERROR == result) {
    return janet_cstringv("Either GLFW was not yet initialized or there was genuinely no Error, i cannot tell.");
  } else {
    return janet_cstringv(description_p);
  }
}

JANET_FN(_generated_cfunction_jlfw__get_error,
        "(jlfw__get-error)", 
        "gets last error string\n    see: https://www.glfw.org/docs/latest/intro_guide.html#error_handling")
{
  janet_fixarity(argc, 0);
  return jlfw__get_error();
}

/* Initializes the GLFW context,
    run once to setup the library.

    returns error on failure
    see: https://www.glfw.org/docs/latest/intro_guide.html#error_handling */
static Janet jlfw__initialize_context()
{
  if (glfwInit()) {
    return janet_wrap_boolean(true);
  } else {
    return jlfw__get_error();
  }
}
JANET_FN(_generated_cfunction_jlfw__initialize_context,
        "(jlfw__initialize-context)", 
        "Initializes the GLFW context,\n    run once to setup the library.\n\n    returns error on failure\n    see: https://www.glfw.org/docs/latest/intro_guide.html#error_handling")
{
  janet_fixarity(argc, 0);
  return jlfw__initialize_context();
}

/* Terminates the GLFW context,
    run once to shutdown the context.
    If you need GLFW afterwards, call init again to start it back up.

    If init failed, this does not have to be called.

    ---
    TODO: maybe a convenience script/macro for init+terminate? https://janet-lang.org/api/index.html#with */
static Janet jlfw__terminate_context()
{
  glfwTerminate();
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jlfw__terminate_context,
        "(jlfw__terminate-context)", 
        "Terminates the GLFW context,\n    run once to shutdown the context.\n    If you need GLFW afterwards, call init again to start it back up.\n\n    If init failed, this does not have to be called.\n\n    ---\n    TODO: maybe a convenience script/macro for init+terminate? https://janet-lang.org/api/index.html#with")
{
  janet_fixarity(argc, 0);
  return jlfw__terminate_context();
}

/* Creates a window (* GLFWwindow)
    hosted by the previously initialized GLFW3 context.

    optionally takes a monitor (* GLFWmonitor)
    to enable true fullscreen, give a monitor you retrieved here:
    https://www.glfw.org/docs/latest/monitor_guide.html#monitor_monitors

    and a share of a window (* GLFWwindow)
    to share its context objects with:
    https://www.glfw.org/docs/latest/context_guide.html#context_sharing

    Returns a wrapped pointer to the window object inside glfwspace. */
static Janet jlfw__create_window(int width, int height, const char * title, void *monitor, void *share)
{
  GLFWwindow* result = (GLFWwindow*)(glfwCreateWindow(width, height, title, (GLFWmonitor*)monitor, (GLFWwindow*)share));
  if (result) {
    return janet_wrap_pointer(result);
  } else {
    return jlfw__get_error();
  }
}

JANET_FN(_generated_cfunction_jlfw__create_window,
        "(jlfw__create-window width:int height:int title:cstring &opt (monitor :pointer NULL) (share :pointer NULL))", 
        "Creates a window (* GLFWwindow)\n    hosted by the previously initialized GLFW3 context.\n\n    optionally takes a monitor (* GLFWmonitor)\n    to enable true fullscreen, give a monitor you retrieved here:\n    https://www.glfw.org/docs/latest/monitor_guide.html#monitor_monitors\n\n    and a share of a window (* GLFWwindow)\n    to share its context objects with:\n    https://www.glfw.org/docs/latest/context_guide.html#context_sharing\n\n    Returns a wrapped pointer to the window object inside glfwspace.")
{
  janet_arity(argc, 3, 5);
  int width = janet_getinteger(argv, 0);
  int height = janet_getinteger(argv, 1);
  const char * title = janet_getcstring(argv, 2);
  void *monitor = janet_optpointer(argv, argc, 3, NULL);
  void *share = janet_optpointer(argv, argc, 4, NULL);
  return jlfw__create_window(width, height, title, monitor, share);
}

/* Destroys a previously created window. */
static Janet jlfw__destroy_window(void *window)
{
  glfwDestroyWindow((GLFWwindow*)window);
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jlfw__destroy_window,
        "(jlfw__destroy-window &opt (window :pointer NULL))", 
        "Destroys a previously created window.")
{
  janet_arity(argc, 0, 1);
  void *window = janet_optpointer(argv, argc, 0, NULL);
  return jlfw__destroy_window(window);
}

/* gives hints to the next call to create-window. [keywords to be implemented](https://www.glfw.org/docs/latest/window_guide.html#window_hints) */
static Janet jlfw__hint_next_window(Janet hint, Janet value)
{
  glfwWindowHint(joinky_getwindowhint(hint), joinky_getglfwvalue(value));
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jlfw__hint_next_window,
        "(jlfw__hint-next-window hint:Janet value:Janet)", 
        "gives hints to the next call to create-window. [keywords to be implemented](https://www.glfw.org/docs/latest/window_guide.html#window_hints)")
{
  janet_fixarity(argc, 2);
  Janet hint = argv[0];
  Janet value = argv[1];
  return jlfw__hint_next_window(hint, value);
}

/* returns whether or not the window is supposed to close */
static Janet jlfw__close_window_X63(void *window)
{
  return janet_wrap_boolean(glfwWindowShouldClose((GLFWwindow*)window));
}
JANET_FN(_generated_cfunction_jlfw__close_window_X63,
        "(jlfw__close-window? window:pointer)", 
        "returns whether or not the window is supposed to close")
{
  janet_fixarity(argc, 1);
  void *window = janet_getpointer(argv, 0);
  return jlfw__close_window_X63(window);
}

/* polls for events */
static Janet jlfw__poll_events()
{
  glfwPollEvents();
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jlfw__poll_events,
        "(jlfw__poll-events)", 
        "polls for events")
{
  janet_fixarity(argc, 0);
  return jlfw__poll_events();
}

/* gets version string, which contains supported platforms */
static Janet jlfw__get_version()
{
  return janet_cstringv(glfwGetVersionString());
}
JANET_FN(_generated_cfunction_jlfw__get_version,
        "(jlfw__get-version)", 
        "gets version string, which contains supported platforms")
{
  janet_fixarity(argc, 0);
  return jlfw__get_version();
}

/* gets pointer to primary monitor */
static Janet jlfw__get_primary_monitor()
{
  return janet_wrap_pointer(glfwGetPrimaryMonitor());
}
JANET_FN(_generated_cfunction_jlfw__get_primary_monitor,
        "(jlfw__get-primary-monitor)", 
        "gets pointer to primary monitor")
{
  janet_fixarity(argc, 0);
  return jlfw__get_primary_monitor();
}

/* hint for initialize-context */
static Janet jlfw__init_hint(int hint, int value)
{
  glfwInitHint(hint, value);
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jlfw__init_hint,
        "(jlfw__init-hint hint:int value:int)", 
        "hint for initialize-context")
{
  janet_fixarity(argc, 2);
  int hint = janet_getinteger(argv, 0);
  int value = janet_getinteger(argv, 1);
  return jlfw__init_hint(hint, value);
}

/* makes the given windows context current */
static Janet jlfw__make_context_current(void *window)
{
  glfwMakeContextCurrent((GLFWwindow*)window);
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jlfw__make_context_current,
        "(jlfw__make-context-current window:pointer)", 
        "makes the given windows context current")
{
  janet_fixarity(argc, 1);
  void *window = janet_getpointer(argv, 0);
  return jlfw__make_context_current(window);
}

/* gets last reported state on this key */
static Janet jlfw__get_key(void *window, int key)
{
  return janet_wrap_integer(glfwGetKey((GLFWwindow*)window, key));
}
JANET_FN(_generated_cfunction_jlfw__get_key,
        "(jlfw__get-key window:pointer key:int)", 
        "gets last reported state on this key")
{
  janet_fixarity(argc, 2);
  void *window = janet_getpointer(argv, 0);
  int key = janet_getinteger(argv, 1);
  return jlfw__get_key(window, key);
}

/* gets last reported state on this mouse button */
static Janet jlfw__get_mouse_button(void *window, int button)
{
  return janet_wrap_integer(glfwGetMouseButton((GLFWwindow*)window, button));
}
JANET_FN(_generated_cfunction_jlfw__get_mouse_button,
        "(jlfw__get-mouse-button window:pointer button:int)", 
        "gets last reported state on this mouse button")
{
  janet_fixarity(argc, 2);
  void *window = janet_getpointer(argv, 0);
  int button = janet_getinteger(argv, 1);
  return jlfw__get_mouse_button(window, button);
}

/* swaps buffers */
static Janet jlfw__swap_buffers(void *window)
{
  glfwSwapBuffers((GLFWwindow*)window);
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jlfw__swap_buffers,
        "(jlfw__swap-buffers window:pointer)", 
        "swaps buffers")
{
  janet_fixarity(argc, 1);
  void *window = janet_getpointer(argv, 0);
  return jlfw__swap_buffers(window);
}

/* sets interval between buffer swaps */
static Janet jlfw__swap_interval(int interval)
{
  glfwSwapInterval(interval);
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jlfw__swap_interval,
        "(jlfw__swap-interval interval:int)", 
        "sets interval between buffer swaps")
{
  janet_fixarity(argc, 1);
  int interval = janet_getinteger(argv, 0);
  return jlfw__swap_interval(interval);
}

/* gets current cursor position relative to the window */
static Janet jlfw__get_cursor_position(void *window)
{
  double xpos;
  double ypos;
  Janet* result = janet_tuple_begin(2);
  glfwGetCursorPos((GLFWwindow*)window, &xpos, &ypos);
  (result[0]) = (janet_wrap_number(xpos));
  (result[1]) = (janet_wrap_number(ypos));
  return janet_wrap_tuple(janet_tuple_end(result));
}

JANET_FN(_generated_cfunction_jlfw__get_cursor_position,
        "(jlfw__get-cursor-position window:pointer)", 
        "gets current cursor position relative to the window")
{
  janet_fixarity(argc, 1);
  void *window = janet_getpointer(argv, 0);
  return jlfw__get_cursor_position(window);
}

/* returns size of the framebuffer backing the window */
static Janet jlfw__get_framebuffer_size(void *window)
{
  int width;
  int height;
  Janet* result = janet_tuple_begin(2);
  glfwGetFramebufferSize((GLFWwindow*)window, &width, &height);
  (result[0]) = (janet_wrap_number(width));
  (result[1]) = (janet_wrap_number(height));
  return janet_wrap_tuple(janet_tuple_end(result));
}

JANET_FN(_generated_cfunction_jlfw__get_framebuffer_size,
        "(jlfw__get-framebuffer-size window:pointer)", 
        "returns size of the framebuffer backing the window")
{
  janet_fixarity(argc, 1);
  void *window = janet_getpointer(argv, 0);
  return jlfw__get_framebuffer_size(window);
}

/* returns some window attribute */
static Janet jlfw__get_window_attrib(void *window, Janet attrib)
{
  return janet_wrap_integer(glfwGetWindowAttrib((GLFWwindow*)window, joinky_getwindowattrib(attrib)));
}
JANET_FN(_generated_cfunction_jlfw__get_window_attrib,
        "(jlfw__get-window-attrib window:pointer attrib:Janet)", 
        "returns some window attribute")
{
  janet_fixarity(argc, 2);
  void *window = janet_getpointer(argv, 0);
  Janet attrib = argv[1];
  return jlfw__get_window_attrib(window, attrib);
}

/*  */
static GLbitfield loinky_glClear_which_bitmask_q(Janet value)
{
  if (janet_checktype(value, JANET_KEYWORD)) {
    {
      const uint8_t* kw = janet_unwrap_keyword(value);
      switch (kw[0]) {
        case 99:
        return GL_COLOR_BUFFER_BIT;

        case 100:
        return GL_DEPTH_BUFFER_BIT;

        case 115:
        return GL_STENCIL_BUFFER_BIT;

      }
    }
  } else {
    janet_panic("expected keyword");
  }
  return 0;
}

/*  */
static Janet jl__clear(Janet args)
{
  if (janet_checktypes(args, JANET_TFLAG_INDEXED)) {
    {
      GLbitfield tmp = 0;
      auto arlen = janet_length(args);
      uint i = 0;
      for (i = 0; i < arlen; ++i) {
        tmp = (tmp | (loinky_glClear_which_bitmask_q(janet_getindex(args, i))));
      }
      glClear(tmp);
    }
  } else {
    glClear(loinky_glClear_which_bitmask_q(args));
  }
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_jl__clear,
        "(jl__clear & args:Janet=nil)", 
        "")
{
  janet_arity(argc, 0, -1);
  Janet args = (argc > 0) ? (argv[0]) : (janet_wrap_nil());
  return jl__clear(args);
}

/*  */
static Janet jl__clear_color(float r, float g, float b, float a)
{
  {
    glClearColor(r, g, b, a);
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_jl__clear_color,
        "(jl__clear-color (r :float 0) (g :float 0) (b :float 0) (a :float 0))", 
        "")
{
  janet_fixarity(argc, 4);
  float r = janet_getnumber(argv, 0);
  float g = janet_getnumber(argv, 1);
  float b = janet_getnumber(argv, 2);
  float a = janet_getnumber(argv, 3);
  return jl__clear_color(r, g, b, a);
}

/*  */
static Janet jl__viewport(int32_t x, int32_t y, int32_t width, int32_t height)
{
  {
    glViewport(x, y, width, height);
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_jl__viewport,
        "(jl__viewport (x :int32) (y :int32) (width :int32) (height :int32))", 
        "")
{
  janet_fixarity(argc, 4);
  int32_t x = janet_getinteger(argv, 0);
  int32_t y = janet_getinteger(argv, 1);
  int32_t width = janet_getinteger(argv, 2);
  int32_t height = janet_getinteger(argv, 3);
  return jl__viewport(x, y, width, height);
}
extern JANET_API const JanetAbstractType inku_texteditor_AT;

/*  */
Janet inku_texteditor_render(Janet te, const char * label)
{
  void* unwrapped = NULL;
  if (janet_checktype(te, JANET_ABSTRACT)) {
    unwrapped = (janet_unwrap_abstract(te));
  }
  if ((janet_abstract_type(unwrapped)) == (&inku_texteditor_AT)) {
    (((TextEditor*)unwrapped)->Render)(label);
  }
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_inku_texteditor_render,
        "(inku_texteditor_render te:Janet label:cstring)", 
        "")
{
  janet_fixarity(argc, 2);
  Janet te = argv[0];
  const char * label = janet_getcstring(argv, 1);
  return inku_texteditor_render(te, label);
}
static const JanetMethod inku_texteditor_functions[] = {
  {
    "render", 
    _generated_cfunction_inku_texteditor_render
  }, 
  {
    NULL, 
    NULL
  }
};

/*  */
int inku_texteditor_gc(void* p, size_t s)
{
  printf("p: %p s: %ld\n", p, s);
  fflush(stdout);
  TextEditor* te = (TextEditor*)p;
  if (NULL != te) {
    {
      delete te;
      te = NULL;
    }
  }
  return 0;
}

/*  */
int inku_texteditor_gc_mark(void* p, size_t s)
{
  (void) s;
  TextEditor* te = (TextEditor*)p;
  janet_mark(janet_wrap_abstract(te));
  return 0;
}

/*  */
int inku_texteditor_get(void* p, Janet key, Janet* out)
{
  (void) p;
  if (janet_checktype(key, JANET_KEYWORD)) {
    return janet_getmethod(janet_unwrap_keyword(key), inku_texteditor_functions, out);
  } else {
    return 0;
  }
}
const JanetAbstractType inku_texteditor_AT = {
  "imku Texteditor AT", 
  NULL, 
  NULL, 
  inku_texteditor_get, 
  JANET_ATEND_GET
};
static const TextEditor editor;

/*  */
static Janet inku__texteditor()
{
  TextEditor* nte = new(janet_abstract_threaded(&inku_texteditor_AT, sizeof(TextEditor)))TextEditor();
  return janet_wrap_abstract(nte);
}

JANET_FN(_generated_cfunction_inku__texteditor,
        "(inku__texteditor)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__texteditor();
}

/*  */
static Janet inku__texteditor____alternative()
{
  TextEditor* nte = (TextEditor*)janet_abstract_threaded(&inku_texteditor_AT, sizeof(TextEditor));
  *nte = editor;
  return janet_wrap_abstract(nte);
}

JANET_FN(_generated_cfunction_inku__texteditor____alternative,
        "(inku__texteditor____alternative)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__texteditor____alternative();
}

/*  */
static Janet inku__begin_b(const char * label, int p_open_i)
{
  {
    bool p_open_b = (bool)p_open_i;
    auto tmp = &p_open_b;
    ImGui::Begin(label, tmp);
    return janet_wrap_boolean(p_open_b);
  }
}
JANET_FN(_generated_cfunction_inku__begin_b,
        "(inku__begin_b label:cstring (p_open_i :bool))", 
        "")
{
  janet_fixarity(argc, 2);
  const char * label = janet_getcstring(argv, 0);
  int p_open_i = janet_getboolean(argv, 1);
  return inku__begin_b(label, p_open_i);
}

/*  */
static Janet inku__begin(const char * label)
{
  {
    ImGui::Begin(label, NULL);
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__begin,
        "(inku__begin label:cstring)", 
        "")
{
  janet_fixarity(argc, 1);
  const char * label = janet_getcstring(argv, 0);
  return inku__begin(label);
}

/*  */
static Janet inku__button(const char * label, float x, float y)
{
  return janet_wrap_boolean(ImGui::Button(label, ImVec2(x, y)));
}
JANET_FN(_generated_cfunction_inku__button,
        "(inku__button label:cstring &opt (x :float 0) (y :float 0))", 
        "")
{
  janet_arity(argc, 1, 3);
  const char * label = janet_getcstring(argv, 0);
  float x = janet_optnumber(argv, argc, 1, 0);
  float y = janet_optnumber(argv, argc, 2, 0);
  return inku__button(label, x, y);
}

/*  */
static Janet inku__checkbox(const char * label, int p_open_i)
{
  {
    bool p_open_b = (bool)p_open_i;
    auto tmp = &p_open_b;
    ImGui::Checkbox(label, tmp);
    return janet_wrap_boolean(p_open_b);
  }
}
JANET_FN(_generated_cfunction_inku__checkbox,
        "(inku__checkbox label:cstring (p_open_i :bool))", 
        "")
{
  janet_fixarity(argc, 2);
  const char * label = janet_getcstring(argv, 0);
  int p_open_i = janet_getboolean(argv, 1);
  return inku__checkbox(label, p_open_i);
}

/*  */
static Janet inku__check_version()
{
  ImGui::DebugCheckVersionAndDataLayout(IMGUI_VERSION, sizeof(ImGuiIO), sizeof(ImGuiStyle), sizeof(ImVec2), sizeof(ImVec4), sizeof(ImDrawVert), sizeof(ImDrawIdx));
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_inku__check_version,
        "(inku__check-version)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__check_version();
}

/*  */
static Janet inku__color_edit3(const char * label, float r, float g, float b)
{
  {
    float cols[] = {
      r, 
      g, 
      b
    };
    Janet* result = janet_tuple_begin(2);
    bool focus = ImGui::ColorEdit3(label, cols);
    (result[0]) = (janet_wrap_boolean(focus));
    if (focus) {
      {
        Janet* newcols = janet_tuple_begin(3);
        (newcols[0]) = (janet_wrap_number(cols[0]));
        (newcols[1]) = (janet_wrap_number(cols[1]));
        (newcols[2]) = (janet_wrap_number(cols[2]));
        (result[1]) = (janet_wrap_tuple(janet_tuple_end(newcols)));
      }
    } else {
      (result[1]) = (janet_wrap_nil());
    }
    return janet_wrap_tuple(janet_tuple_end(result));
  }
}
JANET_FN(_generated_cfunction_inku__color_edit3,
        "(inku__color-edit3 label:cstring (r :float) (g :float) (b :float))", 
        "")
{
  janet_fixarity(argc, 4);
  const char * label = janet_getcstring(argv, 0);
  float r = janet_getnumber(argv, 1);
  float g = janet_getnumber(argv, 2);
  float b = janet_getnumber(argv, 3);
  return inku__color_edit3(label, r, g, b);
}

/*  */
static Janet inku__create_context(void *imFontAtlas)
{
  return janet_wrap_pointer(ImGui::CreateContext((ImFontAtlas*)imFontAtlas));
}
JANET_FN(_generated_cfunction_inku__create_context,
        "(inku__create-context &opt (imFontAtlas :pointer NULL))", 
        "")
{
  janet_arity(argc, 0, 1);
  void *imFontAtlas = janet_optpointer(argv, argc, 0, NULL);
  return inku__create_context(imFontAtlas);
}

/*  */
static Janet inku__destroy_context()
{
  {
    ImGui::DestroyContext();
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__destroy_context,
        "(inku__destroy-context)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__destroy_context();
}

/*  */
static Janet inku__end()
{
  {
    ImGui::End();
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__end,
        "(inku__end)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__end();
}

/*  */
static Janet inku__get_draw_data()
{
  return janet_wrap_pointer(ImGui::GetDrawData());
}
JANET_FN(_generated_cfunction_inku__get_draw_data,
        "(inku__get-draw-data)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__get_draw_data();
}

/*  */
static Janet inku__impl_glfw_init_for_opengl(void *window, int install_callbacks)
{
{
    return janet_wrap_boolean(ImGui_ImplGlfw_InitForOpenGL((GLFWwindow*)window, install_callbacks));
  }}
JANET_FN(_generated_cfunction_inku__impl_glfw_init_for_opengl,
        "(inku__impl-glfw-init-for-opengl window:pointer (install_callbacks :bool :false))", 
        "")
{
  janet_fixarity(argc, 2);
  void *window = janet_getpointer(argv, 0);
  int install_callbacks = janet_getboolean(argv, 1);
  return inku__impl_glfw_init_for_opengl(window, install_callbacks);
}

/*  */
static Janet inku__impl_glfw_new_frame()
{
  {
    ImGui_ImplGlfw_NewFrame();
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__impl_glfw_new_frame,
        "(inku__impl-glfw-new-frame)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__impl_glfw_new_frame();
}

/*  */
static Janet inku__impl_glfw_shutdown()
{
  {
    ImGui_ImplGlfw_Shutdown();
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__impl_glfw_shutdown,
        "(inku__impl-glfw-shutdown)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__impl_glfw_shutdown();
}

/*  */
static Janet inku__impl_glfw_sleep(int milliseconds)
{
  {
    ImGui_ImplGlfw_Sleep(milliseconds);
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__impl_glfw_sleep,
        "(inku__impl-glfw-sleep (milliseconds :int))", 
        "")
{
  janet_fixarity(argc, 1);
  int milliseconds = janet_getinteger(argv, 0);
  return inku__impl_glfw_sleep(milliseconds);
}

/*  */
static Janet inku__impl_opengl3_render_draw_data(void *draw_data)
{
  {
    ImGui_ImplOpenGL3_RenderDrawData((ImDrawData*)draw_data);
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__impl_opengl3_render_draw_data,
        "(inku__impl-opengl3-render-draw-data draw_data:pointer)", 
        "")
{
  janet_fixarity(argc, 1);
  void *draw_data = janet_getpointer(argv, 0);
  return inku__impl_opengl3_render_draw_data(draw_data);
}

/*  */
static Janet inku__impl_opengl3_init(const char * glsl_version)
{
  return janet_wrap_boolean(ImGui_ImplOpenGL3_Init());
}
JANET_FN(_generated_cfunction_inku__impl_opengl3_init,
        "(inku__impl-opengl3-init &opt (glsl_version :cstring NULL))", 
        "")
{
  janet_arity(argc, 0, 1);
  const char * glsl_version = janet_optcstring(argv, argc, 0, NULL);
  return inku__impl_opengl3_init(glsl_version);
}

/*  */
static Janet inku__impl_opengl3_new_frame()
{
  {
    ImGui_ImplOpenGL3_NewFrame();
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__impl_opengl3_new_frame,
        "(inku__impl-opengl3-new-frame)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__impl_opengl3_new_frame();
}

/*  */
static Janet inku__impl_opengl3_shutdown()
{
  {
    ImGui_ImplOpenGL3_Shutdown();
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__impl_opengl3_shutdown,
        "(inku__impl-opengl3-shutdown)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__impl_opengl3_shutdown();
}

/*  */
static Janet inku__io_get_framerate()
{
  return janet_wrap_number((ImGui::GetIO()).Framerate);
}
JANET_FN(_generated_cfunction_inku__io_get_framerate,
        "(inku__io-get-framerate)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__io_get_framerate();
}

/*  */
static Janet inku__new_frame()
{
  {
    ImGui::NewFrame();
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__new_frame,
        "(inku__new-frame)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__new_frame();
}

/*  */
static Janet inku__render()
{
  {
    ImGui::Render();
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__render,
        "(inku__render)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__render();
}

/*  */
static Janet inku__same_line(float offset, float spacing)
{
  {
    ImGui::SameLine(offset, spacing);
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__same_line,
        "(inku__same-line &opt (offset :float 0) (spacing :float -1))", 
        "")
{
  janet_arity(argc, 0, 2);
  float offset = janet_optnumber(argv, argc, 0, 0);
  float spacing = janet_optnumber(argv, argc, 1, -1);
  return inku__same_line(offset, spacing);
}
static const KeyDef imgui_config_flags[] = {
  {
    "none", 
    ImGuiConfigFlags_None
  }, 
  {
    "nav-enable-keyboard", 
    ImGuiConfigFlags_NavEnableKeyboard
  }, 
  {
    "nav-enable-gamepad", 
    ImGuiConfigFlags_NavEnableGamepad
  }, 
  {
    "nav-enable-set-mouse-pos", 
    ImGuiConfigFlags_NavEnableSetMousePos
  }, 
  {
    "nav-no-capture-keyboard", 
    ImGuiConfigFlags_NavNoCaptureKeyboard
  }, 
  {
    "no-mouse", 
    ImGuiConfigFlags_NoMouse
  }, 
  {
    "no-mouse-cursor-change", 
    ImGuiConfigFlags_NoMouseCursorChange
  }, 
  {
    "no-keyboard", 
    ImGuiConfigFlags_NoKeyboard
  }, 
  {
    "is-srgb", 
    ImGuiConfigFlags_IsSRGB
  }, 
  {
    "is-touch-screen", 
    ImGuiConfigFlags_IsTouchScreen
  }
};

/*  */
static int inku_getimguiconfigflag(Janet argv)
{
  return joinky_castdef(argv, imgui_config_flags, (sizeof(imgui_config_flags)) / (sizeof(KeyDef)));
}
/*  */
static Janet inku__set_config_flags_or(Janet flagstoset)
{
  {
    ImGuiIO& io = ImGui::GetIO();
    if (janet_checktypes(flagstoset, JANET_TFLAG_INDEXED)) {
      {
        auto arlen = janet_length(flagstoset);
        int i;
        for (i = 0; i < arlen; ++i) {
          (io.ConfigFlags) = ((io.ConfigFlags) | (inku_getimguiconfigflag(janet_getindex(flagstoset, i))));
        }
      }
    } else {
      if (janet_checktypes(flagstoset, JANET_TFLAG_KEYWORD)) {
        (io.ConfigFlags) = ((io.ConfigFlags) | (inku_getimguiconfigflag(flagstoset)));
      }
    }
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__set_config_flags_or,
        "(inku__set-config-flags-or & flagstoset:Janet=nil)", 
        "")
{
  janet_arity(argc, 0, -1);
  Janet flagstoset = (argc > 0) ? (argv[0]) : (janet_wrap_nil());
  return inku__set_config_flags_or(flagstoset);
}

/*  */
static Janet inku__show_demo_window_b(int p_open_i)
{
  {
    bool p_open_b = (bool)p_open_i;
    auto tmp = &p_open_b;
    ImGui::ShowDemoWindow(tmp);
    return janet_wrap_boolean(p_open_b);
  }
}
JANET_FN(_generated_cfunction_inku__show_demo_window_b,
        "(inku__show-demo-window_b (p_open_i :bool))", 
        "")
{
  janet_fixarity(argc, 1);
  int p_open_i = janet_getboolean(argv, 0);
  return inku__show_demo_window_b(p_open_i);
}

/*  */
static Janet inku__show_demo_window()
{
  {
    ImGui::ShowDemoWindow(NULL);
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__show_demo_window,
        "(inku__show-demo-window)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__show_demo_window();
}

/* float */
static Janet inku__slider_float(const char * label, float value, float minv, float maxv)
{
  {
    ImGui::SliderFloat(label, &value, minv, maxv);
    return janet_wrap_number(value);
  }
}
JANET_FN(_generated_cfunction_inku__slider_float,
        "(inku__slider-float label:cstring value:float minv:float maxv:float)", 
        "float")
{
  janet_fixarity(argc, 4);
  const char * label = janet_getcstring(argv, 0);
  float value = janet_getnumber(argv, 1);
  float minv = janet_getnumber(argv, 2);
  float maxv = janet_getnumber(argv, 3);
  return inku__slider_float(label, value, minv, maxv);
}

/*  */
static Janet inku__style_colors_dark()
{
  ImGui::StyleColorsDark();
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_inku__style_colors_dark,
        "(inku__style-colors-dark)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__style_colors_dark();
}

/*  */
static Janet inku__style_colors_light()
{
  ImGui::StyleColorsLight();
  return janet_wrap_nil();
}

JANET_FN(_generated_cfunction_inku__style_colors_light,
        "(inku__style-colors-light)", 
        "")
{
  janet_fixarity(argc, 0);
  return inku__style_colors_light();
}

/*  */
static Janet inku__text(const char * str)
{
  {
    ImGui::Text(str, NULL);
    return janet_wrap_nil();
  }
}
JANET_FN(_generated_cfunction_inku__text,
        "(inku__text str:cstring)", 
        "")
{
  janet_fixarity(argc, 1);
  const char * str = janet_getcstring(argv, 0);
  return inku__text(str);
}

JANET_MODULE_ENTRY(JanetTable *env) {
  JanetRegExt cfuns[] = {
    JANET_REG("jlfw__get-error", _generated_cfunction_jlfw__get_error), 
    JANET_REG("jlfw__initialize-context", _generated_cfunction_jlfw__initialize_context), 
    JANET_REG("jlfw__terminate-context", _generated_cfunction_jlfw__terminate_context), 
    JANET_REG("jlfw__create-window", _generated_cfunction_jlfw__create_window), 
    JANET_REG("jlfw__destroy-window", _generated_cfunction_jlfw__destroy_window), 
    JANET_REG("jlfw__hint-next-window", _generated_cfunction_jlfw__hint_next_window), 
    JANET_REG("jlfw__close-window?", _generated_cfunction_jlfw__close_window_X63), 
    JANET_REG("jlfw__poll-events", _generated_cfunction_jlfw__poll_events), 
    JANET_REG("jlfw__get-version", _generated_cfunction_jlfw__get_version), 
    JANET_REG("jlfw__get-primary-monitor", _generated_cfunction_jlfw__get_primary_monitor), 
    JANET_REG("jlfw__init-hint", _generated_cfunction_jlfw__init_hint), 
    JANET_REG("jlfw__make-context-current", _generated_cfunction_jlfw__make_context_current), 
    JANET_REG("jlfw__get-key", _generated_cfunction_jlfw__get_key), 
    JANET_REG("jlfw__get-mouse-button", _generated_cfunction_jlfw__get_mouse_button), 
    JANET_REG("jlfw__swap-buffers", _generated_cfunction_jlfw__swap_buffers), 
    JANET_REG("jlfw__swap-interval", _generated_cfunction_jlfw__swap_interval), 
    JANET_REG("jlfw__get-cursor-position", _generated_cfunction_jlfw__get_cursor_position), 
    JANET_REG("jlfw__get-framebuffer-size", _generated_cfunction_jlfw__get_framebuffer_size), 
    JANET_REG("jlfw__get-window-attrib", _generated_cfunction_jlfw__get_window_attrib), 
    JANET_REG("jl__clear", _generated_cfunction_jl__clear), 
    JANET_REG("jl__clear-color", _generated_cfunction_jl__clear_color), 
    JANET_REG("jl__viewport", _generated_cfunction_jl__viewport), 
    JANET_REG("inku_texteditor_render", _generated_cfunction_inku_texteditor_render), 
    JANET_REG("inku__texteditor", _generated_cfunction_inku__texteditor), 
    JANET_REG("inku__texteditor____alternative", _generated_cfunction_inku__texteditor____alternative), 
    JANET_REG("inku__begin_b", _generated_cfunction_inku__begin_b), 
    JANET_REG("inku__begin", _generated_cfunction_inku__begin), 
    JANET_REG("inku__button", _generated_cfunction_inku__button), 
    JANET_REG("inku__checkbox", _generated_cfunction_inku__checkbox), 
    JANET_REG("inku__check-version", _generated_cfunction_inku__check_version), 
    JANET_REG("inku__color-edit3", _generated_cfunction_inku__color_edit3), 
    JANET_REG("inku__create-context", _generated_cfunction_inku__create_context), 
    JANET_REG("inku__destroy-context", _generated_cfunction_inku__destroy_context), 
    JANET_REG("inku__end", _generated_cfunction_inku__end), 
    JANET_REG("inku__get-draw-data", _generated_cfunction_inku__get_draw_data), 
    JANET_REG("inku__impl-glfw-init-for-opengl", _generated_cfunction_inku__impl_glfw_init_for_opengl), 
    JANET_REG("inku__impl-glfw-new-frame", _generated_cfunction_inku__impl_glfw_new_frame), 
    JANET_REG("inku__impl-glfw-shutdown", _generated_cfunction_inku__impl_glfw_shutdown), 
    JANET_REG("inku__impl-glfw-sleep", _generated_cfunction_inku__impl_glfw_sleep), 
    JANET_REG("inku__impl-opengl3-render-draw-data", _generated_cfunction_inku__impl_opengl3_render_draw_data), 
    JANET_REG("inku__impl-opengl3-init", _generated_cfunction_inku__impl_opengl3_init), 
    JANET_REG("inku__impl-opengl3-new-frame", _generated_cfunction_inku__impl_opengl3_new_frame), 
    JANET_REG("inku__impl-opengl3-shutdown", _generated_cfunction_inku__impl_opengl3_shutdown), 
    JANET_REG("inku__io-get-framerate", _generated_cfunction_inku__io_get_framerate), 
    JANET_REG("inku__new-frame", _generated_cfunction_inku__new_frame), 
    JANET_REG("inku__render", _generated_cfunction_inku__render), 
    JANET_REG("inku__same-line", _generated_cfunction_inku__same_line), 
    JANET_REG("inku__set-config-flags-or", _generated_cfunction_inku__set_config_flags_or), 
    JANET_REG("inku__show-demo-window_b", _generated_cfunction_inku__show_demo_window_b), 
    JANET_REG("inku__show-demo-window", _generated_cfunction_inku__show_demo_window), 
    JANET_REG("inku__slider-float", _generated_cfunction_inku__slider_float), 
    JANET_REG("inku__style-colors-dark", _generated_cfunction_inku__style_colors_dark), 
    JANET_REG("inku__style-colors-light", _generated_cfunction_inku__style_colors_light), 
    JANET_REG("inku__text", _generated_cfunction_inku__text), 
    JANET_REG_END
  };
  janet_cfuns_ext(env, "joinkyloinky", cfuns);
}
