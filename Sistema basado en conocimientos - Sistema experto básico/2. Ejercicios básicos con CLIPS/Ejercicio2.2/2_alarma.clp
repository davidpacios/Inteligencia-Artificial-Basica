(deftemplate Emergencia 
    (field tipo) 
    (field sector) 
    (field campo) 
) 

(deftemplate SistemaExtincion 
    (field tipo) 
    (field status) 
    (field UltimaRevision) 
) 

(defrule EmergenciaFuegoClaseB 
    (Emergencia 
        (tipo ClaseB)
  ) 
    (SistemaExtincion 
        (tipo DioxidoCarbono) 
        (status operativo)
  ) 
    => 
    (printout t "Usar extintor CO2" crlf) 
)