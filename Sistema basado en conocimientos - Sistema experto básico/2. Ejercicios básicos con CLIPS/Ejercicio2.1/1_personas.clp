(defrule LosPadresQuierenALosHijos 
    (EsPadre ?variable) 
    => 
    (assert (QuiereASusHijos ?variable))
)