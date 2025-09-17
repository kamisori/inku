(import spork/cjanet :as c)

(import ./bind-glfw :as b)
(import ./bind-gl :as d)
#(import ./bind-inku-textedit :as e)

(defn get-inku-binding []
  ## minimal imgui example
  (macex1
   '(c/cfunction inku__begin_b
     :static
       ""
     [label:cstring (p_open_i :bool)] -> :Janet
       (do
         (def (p_open_b :bool) (cast bool p_open_i))
         (def tmp (addr p_open_b))
         (ImGui::Begin label tmp)
         (return (janet_wrap_boolean p_open_b)))))

  (macex1
   '(c/cfunction inku__begin
     :static
       ""
     [label:cstring] -> :Janet
       (do
         (ImGui::Begin label NULL)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__button
     :static
       ""
     [label:cstring &opt (x :float 0.0) (y :float 0.0)] -> :Janet
       (return (janet_wrap_boolean (ImGui::Button label (ImVec2 x y))))))

  (macex1
   '(c/cfunction inku__checkbox
     :static
       ""
     [label:cstring (p_open_i :bool)] -> :Janet
       (do
         (def (p_open_b :bool) (cast bool p_open_i))
         (def tmp (addr p_open_b))
         (ImGui::Checkbox label tmp)
         (return (janet_wrap_boolean p_open_b)))))

  (macex1
   '(c/cfunction inku__check-version
     :static
       ""
     [] -> :Janet
       (ImGui::DebugCheckVersionAndDataLayout
        IMGUI_VERSION
        (sizeof ImGuiIO)
        (sizeof ImGuiStyle)
        (sizeof ImVec2)
        (sizeof ImVec4)
        (sizeof ImDrawVert)
        (sizeof ImDrawIdx))
     (return (janet_wrap_nil))))

  (macex1
   '(c/cfunction inku__color-edit3
     :static
       ""
     [label:cstring (r :float) (g :float) (b :float)] -> :Janet
       (do
         (def (cols (array float)) @[r g b])
         (def (result Janet*) (janet_tuple_begin 2))
         (def (focus :bool) (ImGui::ColorEdit3 label cols))
         (set (aref result 0) (janet_wrap_boolean focus))
         (if focus
           (do
             (def (newcols Janet*) (janet_tuple_begin 3))
             (set (aref newcols 0) (janet_wrap_number (aref cols 0)))
             (set (aref newcols 1) (janet_wrap_number (aref cols 1)))
             (set (aref newcols 2) (janet_wrap_number (aref cols 2)))
             (set (aref result 1) (janet_wrap_tuple (janet_tuple_end newcols))))
           (set (aref result 1) (janet_wrap_nil)))
         (return (janet_wrap_tuple (janet_tuple_end result))))))

  (macex1
   '(c/cfunction inku__create-context
     :static
       ""
     [&opt (imFontAtlas :pointer NULL)] -> :Janet
       (return
        (janet_wrap_pointer
         (ImGui::CreateContext
          (cast ImFontAtlas* imFontAtlas))))))

  (macex1
   '(c/cfunction inku__destroy-context
     :static
       ""
     [] -> :Janet
       (do
         (ImGui::DestroyContext)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__end
     :static
       ""
     [] -> :Janet
       (do
         (ImGui::End)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__get-draw-data
     :static
       ""
     [] -> :Janet
       (return (janet_wrap_pointer (ImGui::GetDrawData)))))

  (macex1
   '(c/cfunction inku__impl-glfw-init-for-opengl
     :static
       ""
     [window:pointer (install_callbacks :bool :false)] -> :Janet
       (do
         (return
          (janet_wrap_boolean
           (ImGui_ImplGlfw_InitForOpenGL
            (cast GLFWwindow* window) install_callbacks)
           )))))

  (macex1
   '(c/cfunction inku__impl-glfw-new-frame
     :static
       ""
     [] -> :Janet
       (do
         (ImGui_ImplGlfw_NewFrame)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__impl-glfw-shutdown
     :static
       ""
     [] -> :Janet
       (do
         (ImGui_ImplGlfw_Shutdown)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__impl-glfw-sleep
     :static
       ""
     [(milliseconds :int)] -> :Janet
       (do
         (ImGui_ImplGlfw_Sleep milliseconds)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__impl-opengl3-render-draw-data
     :static
       ""
     [draw_data:pointer] -> :Janet
       (do
         (ImGui_ImplOpenGL3_RenderDrawData (cast ImDrawData* draw_data))
         (return (janet_wrap_nil))
         )))

  (macex1
   '(c/cfunction inku__impl-opengl3-init
     :static
       ""
     [&opt (glsl_version :cstring NULL)] -> :Janet
       (return (janet_wrap_boolean (ImGui_ImplOpenGL3_Init)))))

  (macex1
   '(c/cfunction inku__impl-opengl3-new-frame
     :static
       ""
     [] -> :Janet
       (do
         (ImGui_ImplOpenGL3_NewFrame)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__impl-opengl3-shutdown
     :static
       ""
     [] -> :Janet
       (do
         (ImGui_ImplOpenGL3_Shutdown)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__io-get-framerate
     :static
       ""
     [] -> :Janet
       (return (janet_wrap_number (. (ImGui::GetIO) Framerate)))))

  (macex1
   '(c/cfunction inku__new-frame
     :static
       ""
     [] -> :Janet
       (do
         (ImGui::NewFrame)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__render
     :static
       ""
     [] -> :Janet
       (do
         (ImGui::Render)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__same-line
     :static
       ""
     [&opt (offset :float 0.0) (spacing :float -1.0)] -> :Janet
       (do
         (ImGui::SameLine offset spacing)
         (return (janet_wrap_nil)))))

  (macex1
   (c/declare
    (imgui_config_flags (array KeyDef)) "static const"
    @[
      @["none" ImGuiConfigFlags_None]
      @["nav-enable-keyboard" ImGuiConfigFlags_NavEnableKeyboard]
      @["nav-enable-gamepad" ImGuiConfigFlags_NavEnableGamepad]
      @["nav-enable-set-mouse-pos" ImGuiConfigFlags_NavEnableSetMousePos]
      @["nav-no-capture-keyboard" ImGuiConfigFlags_NavNoCaptureKeyboard]
      @["no-mouse" ImGuiConfigFlags_NoMouse]
      @["no-mouse-cursor-change" ImGuiConfigFlags_NoMouseCursorChange]
      @["no-keyboard" ImGuiConfigFlags_NoKeyboard]
      @["is-srgb" ImGuiConfigFlags_IsSRGB]
      @["is-touch-screen" ImGuiConfigFlags_IsTouchScreen]
     ]))

  (macex1
   (c/function inku_getimguiconfigflag
               :static
      [argv:Janet] -> int
      (return (joinky_castdef argv
                              imgui_config_flags
                              (/ (sizeof imgui_config_flags)
                                 (sizeof KeyDef))))))

  (macex1
   '(c/cfunction inku__set-config-flags-or 
     :static
       ""
     [& flagstoset:Janet=nil] -> :Janet
       (do
         (def (io ImGuiIO&) (ImGui::GetIO))
         (if (janet_checktypes flagstoset JANET_TFLAG_INDEXED)
           (do
             (def arlen (janet_length flagstoset))
             (def (i :int))
             (for [(set i 0) (< i arlen) (++ i)]
                 (set (. io ConfigFlags)
                      (bor (. io ConfigFlags)
                           (inku_getimguiconfigflag
                            (janet_getindex flagstoset i))))))
           (if (janet_checktypes flagstoset JANET_TFLAG_KEYWORD)
            (set (. io ConfigFlags)
                  (bor (. io ConfigFlags)
                       (inku_getimguiconfigflag
                        flagstoset)))))
         (return (janet_wrap_nil))
         )))

  (macex1
   '(c/cfunction inku__show-demo-window_b
     :static
       ""
     [(p_open_i :bool)] -> :Janet
       (do
         (def (p_open_b :bool) (cast bool p_open_i))
         (def tmp (addr p_open_b))
         (ImGui::ShowDemoWindow tmp)
         (return (janet_wrap_boolean p_open_b)))))

  (macex1
   '(c/cfunction inku__show-demo-window
     :static
       ""
     [] -> :Janet
       (do
         (ImGui::ShowDemoWindow NULL)
         (return (janet_wrap_nil)))))

  (macex1
   '(c/cfunction inku__slider-float "float"
     :static
       ""
     [label:cstring value:float minv:float maxv:float] -> :Janet
       (do
         (ImGui::SliderFloat label (addr value) minv maxv)
         (return (janet_wrap_number value))
         )))

  (macex1
   '(c/cfunction inku__style-colors-dark
     :static
       ""
     [] -> :Janet
       (ImGui::StyleColorsDark)
     (return (janet_wrap_nil))
    ))

  (macex1
   '(c/cfunction inku__style-colors-light
     :static
       ""
     [] -> :Janet
       (ImGui::StyleColorsLight)
     (return (janet_wrap_nil))
    ))

  (macex1
   '(c/cfunction inku__text
     :static
       ""
     [str:cstring] -> :Janet
       (do
         (ImGui::Text str NULL)
         (return (janet_wrap_nil)))))
  (macex1
   '(c/cfunction inku__input-text
     :static
       ""
     [label:cstring buffer:buffer] -> :Janet
       (do
         (janet_buffer_ensure buffer (+ 1 (-> buffer capacity)) 1)
         (ImGui::InputText
          label
          (cast char* (-> buffer data))
          (-> buffer capacity))
         (return (janet_wrap_buffer buffer))
         )))

  (macex1
   '(c/cfunction inku__list-box
     :static
       ""
     [label:cstring currentlyselected:int32 items:array] -> :Janet
       (do
         (def arlen (-> items count))
         (def
           (tmparr "char**")
           (cast "char**"
                 (janet_smalloc (* arlen
                                   (sizeof "char**")))))
         (def (i :int))
         (for [(set i 0) (< i arlen) (++ i)]
             (set (aref tmparr i) (cast char* (janet_unwrap_string (aref (-> items data)  i))))
             )
         
         (ImGui::ListBox label
                         (addr currentlyselected)
                         tmparr
                         arlen)
         (janet_sfree tmparr)
         (return (janet_wrap_integer currentlyselected))
         )
    ))

  )

(defn get-joinky-loinky-binding []
  (let [outbuffer (buffer)]
    (with-dyns [*out* outbuffer]
      (c/include <janet.h>)
      (c/include <stdbool.h>)

      (print `#include "GLFW/glfw3.h"`)
      (print `#include "imgui.h"`)

      (print `#include "imgui_impl_glfw.h"`)
      (print `#include "imgui_impl_opengl3.h"`)
      
#      (print `#include "TextEditor.h"`)

      (b/get-joinky-binding)
      (d/get-loinky-binding)
      (get-inku-binding)
#      (e/get-inku-texteditor-binding)
      (macex1 '(c/module-entry "joinkyloinky"))
      (flush))
    (string outbuffer)))

(def filepath (get (dyn *args*) 1))

(try
  (os/rm filepath)
  ([err] (print "err: " err)))

(->> (get-joinky-loinky-binding)
     (spit filepath ))
