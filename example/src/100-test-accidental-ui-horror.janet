(use ../../build/joinkyloinky)
(use spork/misc)
(import spork/schema :as schema)

(def- Widget-Types [:button])

(def- Widget
    @{:type :widget
        :valid?
        (schema/predicate
         (props
          :parent (props :children :array)
          :type (enum ;Widget-Types)
          :show-if-valid (or :function
                             :cfunction)
          :get-adopted (or :function
                           :cfunction)
          :inherit-validation (or :function
                                  :cfunction)))
      :get-adopted (fn get-adopted [self new-parent]
                     (update new-parent :children |(array/push $0 self))
                     (:inherit-validation self))
      :show-if-valid |(if-let [self $0
                                    valid? (in $0 :valid? |(eprintf "%m is missing validation predicate: %m" ($0 :type) $0))
                                    is-valid-a-function? (function? valid?)
                                    am-i-valid? (valid? self)]
                             (:show $0)
                             (eprintf "%m did not pass validation: %m" ($0 :type) $0))
      :inherit-validation (fn inherit-validation [heir]
                            (let [heirloom (table/getproto heir)
                                  heirloom-valid? (get heirloom :valid?)
                                  heir-valid? (get heir :valid?)]
                              (put heir :valid?
                                 |(and (if-not (heirloom-valid? $0)
                                         (printf "heirloom validation failed. heirloom: %m heir: %m" heirloom $0)
                                         :true)
                                       (if-not (heir-valid? $0)
                                         (printf "heir validation failed. %m" $0)
                                         :true)))))
     })

(def- Button
  (-> Widget
      (make
       :type :button
         :valid? (schema/predicate
                  (props
                    :label :string
                    :action (or :function
                                :cfunction)
                    :show (or :function
                              :cfunction)))
         
         :show |(when (inku__button ($0 :label))
                  (:action $0)))
      ))

(defn make-button
  ""
  [label action]
  (-> Button
      (make
       :label label :action action)))


(def- Window
  @{:type :window
    :valid? (schema/predicate
      (props
       :label :string
       :children :array
       :show (or :function
                 :cfunction)))
    :label "helloworld"
    :children @[]
    :show
      (fn [self]
        (inku__begin (self :label))
        (each kid (self :children)
          (:show-if-valid kid))
        (inku__end))
   })

(defn make-window
  ""
  [label & children]
  (def resultwindow (-> Window
    (make
      :label label)))
  (each kid children
    (:get-adopted kid resultwindow))
  resultwindow)


(defmacro labelsettermacro [label]
  (fn [self] (put self :label label)))

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
        [window (jlfw__create-window 320 240
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
              (let [btn1 (make-button "clickme"
                                      |(put $0 :label "thanks"))
                    btn2 (make-button "clickme"
                                      |(put $0 :label "run"))
                    buttonlabels @["thanks" "run"]
                    buttons (map |(make-button "clickme" $0)
                                 (map labelsettermacro buttonlabels))
                    state @{:windows @[(make-window "hello" ;buttons)]}]
                (while (not (jlfw__close-window? window))
                  (jlfw__poll-events)
                  (if (not=
                       0
                       (jlfw__get-window-attrib
                        window
                        :iconified))
                    (inku__impl-glfw-sleep 10)
                    (do
                      (inku__impl-opengl3-new-frame)
                      (inku__impl-glfw-new-frame)
                      (inku__new-frame)

                      (map :show (state :windows))
               
                      (inku__render)
                      (let [[display_w display_h]
                            (jlfw__get-framebuffer-size window)]
                        (jl__viewport 0 0 display_w display_h))
                      (let [[r g b a] (get state :clear-color [0.0 0.0 0.0 1.0])]
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
