(import "java.awt.*")
(import "java.awt.event.*")


(define win (Frame."Hello"))

(define b (Button."Goodbye"))
(.add> win (Label."Hello")
      BorderLayout.NORTH$)
(define p (Label.
  (string-append "sin(PI) = " 
    (Math.sin  Math.PI$))))
(.add win b)
(.add win p  BorderLayout.SOUTH$)
(.addActionListener b
  (Listener. (lambda (e)
    (.hide win))))
(.pack win)
(.show win)
(.println System.out$ "Done")
