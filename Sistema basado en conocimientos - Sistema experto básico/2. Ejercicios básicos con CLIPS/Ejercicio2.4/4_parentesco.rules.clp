(defrule esHermanoDe
    (PadreDe (Padre ?Padre) (Hijo ?Hijo1))
    (PadreDe  (Padre ?Padre) (Hijo ?Hijo2))
    (test(neq ?Hijo1 ?Hijo2))
    (Persona (Nombre ?Hijo1) (Sexo Hombre))
    =>
    (printout t ?Hijo1" es Hermano de " ?Hijo2 crlf)(assert(Hermano ?Hijo1 ?Hijo2))
)

(defrule esHermanaDe
    (PadreDe (Padre ?Padre) (Hijo ?Hijo1))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo2))
    (test(neq ?Hijo1 ?Hijo2))
    (Persona (Nombre ?Hijo1) (Sexo Mujer))
    =>
    (printout t ?Hijo1" es Hermana de " ?Hijo2 crlf)(assert(Hermana ?Hijo1 ?Hijo2))
)

(defrule esTio
    (PadreDe (Padre ?Abuelo) (Hijo ?Padre))
    (PadreDe (Padre ?Abuelo) (Hijo ?Tio))
    (test(neq ?Padre ?Tio))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo))
    (Persona (Nombre ?Tio) (Sexo Hombre))
    =>
    (printout t ?Tio " es tío de " ?Hijo crlf)(assert(Tio ?Tio ?Hijo))
)

(defrule esTia
    (PadreDe (Padre ?Abuelo) (Hijo ?Padre))
    (PadreDe (Padre ?Abuelo) (Hijo ?Tio))
    (test(neq ?Padre ?Tio))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo))
    (Persona (Nombre ?Tio) (Sexo Mujer))
    =>
    (printout t ?Tio " es tía de " ?Hijo crlf)(assert(Tia ?Tio ?Hijo))
)

(defrule esSobrino
    (PadreDe (Padre ?Abuelo) (Hijo ?Padre))
    (PadreDe (Padre ?Abuelo) (Hijo ?Tio))
    (test(neq ?Padre ?Tio))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo))
    (Persona (Nombre ?Hijo) (Sexo Hombre))
    =>
    (printout t ?Hijo " es Sobrino de " ?Tio crlf)(assert(Sobrino ?Hijo ?Tio)
  )
)

(defrule esSobrina
    (PadreDe (Padre ?Abuelo) (Hijo ?Padre))
    (PadreDe (Padre ?Abuelo) (Hijo ?Tio))
    (test(neq ?Padre ?Tio))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo))
    (Persona (Nombre ?Hijo) (Sexo Mujer))
    =>
    (printout t ?Hijo " es Sobrina de " ?Tio crlf)(assert(Sobrina ?Hijo ?Tio))
)

(defrule esPrimo
    (PadreDe (Padre ?Abuelo) (Hijo ?Padre))
    (PadreDe (Padre ?Abuelo) (Hijo ?Tio))
    (test(neq ?Padre ?Tio))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo))
    (PadreDe (Padre ?Tio) (Hijo ?Primo))
    (test(neq ?Hijo ?Primo))
    (Persona (Nombre ?Hijo)(Sexo Hombre))
    =>
    (printout t ?Hijo " es Primo de " ?Primo crlf)(assert(Primo ?Hijo ?Primo))
)

(defrule esPrima
    (PadreDe (Padre ?Abuelo) (Hijo ?Padre))
    (PadreDe (Padre ?Abuelo) (Hijo ?Tio))
    (test(neq ?Padre ?Tio))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo))
    (PadreDe (Padre ?Tio) (Hijo ?Primo))
    (test(neq ?Hijo ?Primo))
    (Persona (Nombre ?Hijo)(Sexo Mujer))
    =>
    (printout t ?Hijo " es Prima de " ?Primo crlf)(assert(Prima ?Hijo ?Primo))
)

(defrule esAbuelo
    (PadreDe (Padre ?Abuelo) (Hijo ?Padre))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo))
    (test(neq ?Abuelo ?Hijo))
    (Persona (Nombre ?Abuelo) (Sexo Hombre))
    =>
    (printout t ?Abuelo " es Abuelo de " ?Hijo crlf)(assert(Abuelo ?Abuelo ?Hijo))
)

(defrule esAbuela
    (PadreDe (Padre ?Abuelo) (Hijo ?Padre))
    (PadreDe (Padre ?Padre) (Hijo ?Hijo))
    (test(neq ?Abuelo ?Hijo))
    (Persona (Nombre ?Abuelo) (Sexo Mujer))
    =>
    (printout t ?Abuelo " es Abuela de " ?Hijo crlf)(assert(Abuela ?Abuelo ?Hijo))
)
