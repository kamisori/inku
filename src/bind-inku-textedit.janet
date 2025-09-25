(import spork/cjanet :as c)

(import ./bind-glfw :as b)
(import ./bind-gl :as d)
(import ./bind-inku :as e)

(defn get-inku-texteditor-binding []
  ## minimal imgui example


  ##  (print "int (*inku_texteditor_get)(void* p, Janet key, Janet *out);")

  ##  (macex1 (c/typedef inku_texteditor_AT (const JanetAbstractType)))
  
  (print "extern JANET_API const JanetAbstractType inku_texteditor_AT;")
  
  (macex1
   '(c/cfunction
     inku_texteditor_render
     "calls the render function for this texteditor instance, set showBorder to :true to show a border, leave it out or set to any other keyword to not show a border."
     [someTextEditor:Janet title:cstring dimensions:Janet showBorder:Janet] -> Janet
     (printf "%s" "hello from inku__texteditor_render\n")
     (fflush stdout)
     (def (unwrapped_texteditor void*) NULL)
     (if (not (janet_checktype someTextEditor JANET_ABSTRACT))
       (janet_panicf "expected abstract object of type inku_texteditor_AT" )
       (do
         (set unwrapped_texteditor (janet_unwrap_abstract someTextEditor))
         (if (not= (janet_abstract_type unwrapped_texteditor) (addr inku_texteditor_AT))
           (janet_panicf "did not get abstract object of type inku_texteditor_AT")
           (do
             (def (tmpBorder int32_t) ImGuiChildFlags_None)
             # TODO: read imgui beginchild comments in regards to this being actually of type ImGuiChildFlags
             # implement sending multiple keywords for or
             (if (janet_checktype showBorder JANET_KEYWORD)
               (if (not (janet_cstrcmp (janet_unwrap_keyword showBorder) "true"))
                 (set tmpBorder ImGuiChildFlags_Borders)))
             (if (janet_checktypes dimensions JANET_TFLAG_NIL)
               ((-> (cast TextEditor* unwrapped_texteditor)
                    Render)
                title
                (ImVec2 -1 -1)
                tmpBorder)
               #call Render method with arguments
               (if (not (janet_checktypes dimensions JANET_TFLAG_INDEXED))
                 (janet_panicf "expected dimensions to be an indexed type or nil")
                 (if (not (>= (janet_length dimensions) 2))
                   (janet_panicf "expected dimensions to be of length 2 or more")
                   (if (not (janet_checktype (janet_getindex dimensions 0) JANET_NUMBER))
                     (janet_panicf "expected dimensions[0] to be a number")
                     (if (not (janet_checktype (janet_getindex dimensions 1) JANET_NUMBER))
                       (janet_panicf "expected dimensions[1] to be a number")
                       ((-> (cast TextEditor* unwrapped_texteditor)
                            Render)
                        title
                        (ImVec2
                         (janet_unwrap_number
                          (janet_getindex dimensions 0))
                         (janet_unwrap_number
                          (janet_getindex dimensions 1)))
                        tmpBorder))
                     ))))))))
             (return (janet_wrap_nil))))

  (macex1
   (c/declare
    (inku_texteditor_functions
     (array JanetMethod))
    "static const"
    @[
      @["render" _generated_cfunction_inku_texteditor_render]
      @[NULL NULL]
     ]))

  (macex1
   (c/function
    inku_texteditor_get
    ""
    [p:void* key:Janet out:Janet*] -> int
    '"(void) p"
    (printf "%s" "hello from inku__texteditor_get\n")
     (fflush stdout)
    (if (janet_checktype key JANET_KEYWORD)
      (return
       (janet_getmethod
        (janet_unwrap_keyword key) inku_texteditor_functions out))
      (return 0))))

  (macex1
   (c/declare
    (inku_texteditor_AT
     JanetAbstractType)
    "const"
    @[
      "imku Texteditor AT"
      NULL
      NULL
      inku_texteditor_get
      JANET_ATEND_GET
     ]))

  ## a little help from the stl
  (print "static const std::map<std::string, TextEditor*> editor_library;")
  
  (macex1
   (c/function
    inku_texteditor_library_gc
    "clean up library"
    [p:void* s:size_t] -> int
    (printf "%s" "hello from inku__texteditor_library_gc\n")
    (fflush stdout)
    '"(void) s"
    (def (object "std::map<std::string, TextEditor*>*") (cast "std::map<std::string, TextEditor*>*" p))
    (if (!= NULL object)
      (do
        (def arlen ((-> object size)))
        (def (i :int))
        (for [(set i 0) (< i arlen) (++ i)]
            '"delete object[i]")
        ((-> object clear))
        '"delete object"
       (set object NULL)))
    (return 0)))

  (macex1
   (c/function
    inku_texteditor_library_gc_mark
    "calls janet_mark"
    [p:void* s:size_t] -> int
    '"(void) s"
    (printf "%s" "hello from inku__texteditor_library_gc_mark\n")
     (fflush stdout)
    (def (object "std::map<std::string, TextEditor*>*") (cast "std::map<std::string, TextEditor*>*" p))
    (janet_mark (janet_wrap_abstract object))
    (return 0)))

  (macex1
   (c/function
    inku_texteditor_library_get
    "retrieves something out of the object, in this case an instance of TextEditor"
    [p:void* key:Janet out:Janet*] -> int
    '"(void) p"
    (printf "%s" "hello from inku__texteditor_library_get\n")
    (fflush stdout)
    (if (janet_checktype key JANET_TFLAG_STRING)
      (do
        (def keystring (janet_unwrap_string key))
        (def search
          ((-> (janet_unwrap_abstract p)
               find)
           keystring))
        (if search
          (do 
    (printf "%s" "found\n")
            (set *out (janet_wrap_abstract
                       (janet_wrap_abstract
                        (-> search
                            second))))
            (return 1))
          (do
    (printf "%s" "new\n")
            (set (aref (janet_unwrap_abstract p)
                       keystring)
                 '"new(janet_abstract_threaded(&inku_texteditor_AT, sizeof(TextEditor)))TextEditor()")
            (set *out (janet_wrap_abstract
                       (aref (janet_unwrap_abstract p)
                             keystring)))
                 (return 1))))
      (return 0))))
  
  (macex1
   (c/declare
    (inku_texteditor_library_AT
     JanetAbstractType)
    "const"
    @[
      "imku Texteditor Library AT"
      inku_texteditor_library_gc
      inku_texteditor_library_gc_mark
      inku_texteditor_library_get
      JANET_ATEND_GET
     ]))
  
  (macex1
   '(c/cfunction inku__get-texteditor-library
     :static
       ""
     ##  
     [] -> :Janet
       (printf "%s" "hello from inku__get-texteditor-library\n")
     (fflush stdout)
       (def (telib "std::map<std::string, TextEditor*>*")
         '"(std::map<std::string, TextEditor*>*)new(janet_abstract_threaded(&inku_texteditor_AT, sizeof(std::map<std::string, TextEditor*>*)))std::map<std::string, TextEditor*>()")
     (set *telib editor_library)
     (printf "%s" "hello from inku__texteditor____alternative\n")
     (fflush stdout)
     (return
      (janet_wrap_abstract telib))))


  #### now for putting the get method back into the abstract type
  )

(defn get-joinky-loinky-textedit-binding []

  (let [outbuffer (buffer)]
    (with-dyns [*out* outbuffer]
      (c/include <janet.h>)
      (c/include <stdbool.h>)

      (print `#include "GLFW/glfw3.h"`)
      (print `#include "imgui.h"`)

      (print `#include "imgui_impl_glfw.h"`)
      (print `#include "imgui_impl_opengl3.h"`)
      
      (print `#include "TextEditor.h"`)

      (b/get-joinky-binding)
      (d/get-loinky-binding)
      (e/get-inku-binding)
      (get-inku-texteditor-binding)
      (macex1 '(c/module-entry "joinkyloinky"))
      (flush))
    (string outbuffer)))

(def filepath (get (dyn *args*) 1))

(try
  (os/rm filepath)
  ([err] (print "err: " err)))

(->> (get-joinky-loinky-textedit-binding)
     (spit filepath ))
