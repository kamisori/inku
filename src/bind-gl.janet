(import spork/cjanet :as c)

(defn get-loinky-binding []
  (macex1 (c/function loinky_glClear_which_bitmask_q
               :static
      ""
      [value:Janet] -> GLbitfield
      (if (janet_checktype value JANET_KEYWORD)
        (do
          (def (kw (const uint8_t*)) (janet_unwrap_keyword value))
          (switch (aref kw 0)
                  99 #color
                  (return GL_COLOR_BUFFER_BIT)
                  100 #depth
                  (return GL_DEPTH_BUFFER_BIT)
                  115 #stencil
                  (return GL_STENCIL_BUFFER_BIT)))
        (janet_panic "expected keyword"))
      (return 0)))

  (macex1
   '(c/cfunction jl__clear
     :static
       ""
     [& args:Janet=nil] -> :Janet
     (if (janet_checktypes args JANET_TFLAG_INDEXED)
       (do
         (def (tmp GLbitfield) 0)
         (def arlen (janet_length args))
         (def (i uint32_t) 0)
         (for [(set i 0) (< i arlen) (++ i)]
             (set tmp
                  (bor tmp
                       (loinky_glClear_which_bitmask_q
                        (janet_getindex args i)))))
         (glClear tmp))
       (glClear (loinky_glClear_which_bitmask_q args)))
      (return (janet_wrap_nil))))

  (macex1 '(c/cfunction jl__clear-color
     :static
       ""
     [(r :float 0.0) (g :float 0.0) (b :float 0.0) (a :float 0.0)] -> :Janet
       (do
         
         (glClearColor r g b a)
         (return (janet_wrap_nil)))
    ))

  (macex1 '(c/cfunction jl__viewport
     :static
       ""
     [(x :int32) (y :int32) (width :int32) (height :int32)] -> :Janet
     (do
       (glViewport x y width height)
       (return (janet_wrap_nil)))))
  )

(comment todo for minimal opengl idk
         glActiveTexture
         glAttachShader
         glBindBuffer
         glBindTexture
         glBindVertexArray
         glBlendFunc
         glBufferData
         glClear
         glClearColor
         glCompileShader
         glCopyTexImage2D
         glCreateProgram
         glCreateShader
         glDeleteProgram
         glDeleteShader
         glDeleteTextures
         glDisable
         glDisableVertexAttribArray
         glDrawArrays
         glEnable
         glEnableVertexAttribArray
         glewGetErrorString
         glewGetString
         glewInit
         glGenBuffers
         glGenTextures
         glGenVertexArrays
         glGetAttribLocation
         glGetError
         glGetProgramInfoLog
         glGetProgramiv
         glGetShaderInfoLog
         glGetShaderiv
         glGetString
         glGetUniformLocation
         glLinkProgram
         glMapBuffer
         glProgramUniform1f
         glProgramUniform1i
         glProgramUniform2f
         glProgramUniformMatrix4fv
         glReadPixels
         glScissor
         glShaderSource
         glSwapIntervalEXT
         glTexImage1D
         glTexImage2D
         glTexParameteri
         glTexSubImage1D
         glUnmapBuffer
         glUseProgram
         glVertexAttribPointer
         glViewport)
