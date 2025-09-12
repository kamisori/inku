(use joinkyloinky)



(defn main [& args]
  (with
   [context (jlfw__initialize-context)
    (fn [ctx] (jlfw__terminate-context))]
   (if-not context
     (error "could not initialize joinkyloinky context")
     (do
       (jlfw__hint-next-window :context-version-major 3)
       (jlfw__hint-next-window :context-version-minor 0)
       (with
        [window (jlfw__create-window 1280 720
                                     "joinkyloinky example")
         (fn [win] (jlfw__destroy-window win))]
        (if-not window
          (error "could not create window")
          (do
            (jlfw__make-context-current window)
            (jlfw__swap-interval 1)
            (inku__check-version)
            (inku__create-context)
            (let [glsl_version "#version 130"
                  # io (inku__get-io)
                 ]
              (inku__set-config-flags-or
               :nav-enable-keyboard
                 :nav-enable-gamepad)
              (inku__style-colors-dark)
              (inku__style-colors-light)
              (inku__impl-glfw-init-for-opengl window true)
              (inku__impl-opengl3-init glsl_version)
              (let [state @{:show-my-window @{:value true
                                              :updater |(inku__checkbox "Demo Window" $0)
                                             # :window :main
                                             }
                            :show-demo-window true
                            :show-another-window false
                            :clear-color [0.45 0.55 0.60 1.00]
                            :f 0.0
                            :counter 0}]
                (while (not (jlfw__close-window? window))
                  (jlfw__poll-events)
                  (if (not= 0
                            (jlfw__get-window-attrib window
                                                     :iconified))
                    (inku__impl-glfw-sleep 10)
                    (do
                      (inku__impl-opengl3-new-frame)
                      (inku__impl-glfw-new-frame)
                      (inku__new-frame)

                      (when-let [prevstate
                                 (get state :show-demo-window)]
                        (update state :show-demo-window
                           |(inku__show-demo-window_b $0)))
                      (do
                        (inku__begin "Hello, world!")
                        (inku__text "This is some useful text.")
                        (update state :show-demo-window
                           |(inku__checkbox "Demo Window" $0))
                        (update state :show-another-window 
                           |(inku__checkbox "Another Window" $0))
                        (update state :f
                           |(inku__slider-float "float"
                                                 $0 0.0 1.0))
                        (update state :clear-color
                           |(let [[r g b a] $0]
                              (let [[foc new-colors] (inku__color-edit3 "clear color" r g b)]
                                (if foc
                                  (let [[nr ng nb] new-colors]
                                    [nr ng nb a])
                                  [r g b a]))))
                        (when (inku__button "Button")
                          (update state :counter inc))
                        (inku__same-line)
                        (inku__text (string/format
                                      "counter = %d"
                                      (state :counter)))
                        (let [framerate
                              (inku__io-get-framerate)]
                          (inku__text (string/format
                                        "Avg. %.3f ms/frame (%.1f FPS)"
                                        (/ 1000.0 framerate)
                                        framerate)))
                        (inku__end))

                      (when-let [show-another-window
                                 (get state :show-another-window)]
                        (update state :show-another-window
                           |(inku__begin_b "Another Window" $0))
                        (inku__text "Hello from another window!")
                        (when (inku__button "Close Me")
                          (put state :show-another-window false))
                        (if-not (has-key? state :te)
                          (when (inku__button "init texteditor")
                            (put state :te (inku__texteditor)))
                          (when (inku__button "deinit texteditor")
                            (put state :te nil)))
                        (when (has-key? state :te)
                          (:render (state :te) "TextEditor"))
                        (inku__end))
                      
                      (inku__render)
                      (let [[display_w display_h]
                            (jlfw__get-framebuffer-size window)]
                        (jl__viewport 0 0 display_w display_h))
                      (let [[r g b a] (get state :clear-color)]
                        (jl__clear-color (* r a)
                                         (* g a)
                                         (* b a)
                                         a))
                      (jl__clear :color-buffer-bit)
                      (inku__impl-opengl3-render-draw-data
                       (inku__get-draw-data))
                      (jlfw__swap-buffers window) )
                    )))
              (inku__impl-opengl3-shutdown)
              (inku__impl-glfw-shutdown)
              (inku__destroy-context)
              ))))))))
