
(defrule tipoAgente
    =>
    (printout t "Tipo del agente(vehiculo/peaton)?")
    (assert (tipoAgente (read)))
)

(defrule colorSemaforoCoche
    (tipoAgente vehiculo)
    =>
    (printout t "Semaforo para vehiculo(rojo/ambar/verde)?")
    (assert (semaforo (read)))
)

(defrule colorSemaforoPeaton
    (tipoAgente peaton)
    =>
    (printout t "Semaforo para peaton(rojo/ambar/verde)?")
    (assert (semaforo (read)))
)

(defrule accionPasar
    (tipoAgente ?tipo)
    (semaforo verde)
    =>
    (printout t "El agente " ?tipo " puede pasar" crlf)
)

(defrule aacionEsperar
    (tipoAgente ?tipo)
    (semaforo rojo)
    =>
    (printout t "El agente " ?tipo " debe esperar" crlf)
)

(defrule accionPrecacucion
    (tipoAgente ?tipo)
    (semaforo ambar)
    =>
    (printout t "El agente " ?tipo " debe prestar atencion, pero puede pasar" crlf)
)




