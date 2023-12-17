;1.1.-Hechos
;(assert (nombre Juanjo))
;(assert (nombre Juan))
;(assert (apellido-1 Cruz))
;(assert (apellido-1 Perez))
;(assert (apellido-2 Lopez))
;(assert (nombre Federico))
;(assert (apellido-1 Perez))
;(assert (apellido-2 Jimenez))

;1.2.-Reglas
(defrule regla1 
        (nombre ?Tu_Nombre) 
    => 
        (printout t "Tu nombre de pila es" ?Tu_Nombre crlf))

(defrule regla2 
        (nombre ?Tu_Nombre) 
        (apellido-1 ?Tu_Apellido1) 
        (apellido-2 ?Tu_Apellido2) 
    => 
        (printout t ?Tu_Nombre " " ?Tu_Apellido1 " " Tu_Apellido2 crlf)
)

;1.3.-Ejecución de Reglas

;1.4.-Definición de hechos con deffacts
(deffacts Hechos
    (nombre Juanjo)
    (nombre Juan)
    (apellido-1 Cruz)
    (apellido-1 Perez)
    (apellido-2 Lopez)
    (nombre Federico)
    (apellido-1 Perez)
    (apellido-2 Jimenez)
)

;1.5.-Uso de variables en las reglas

