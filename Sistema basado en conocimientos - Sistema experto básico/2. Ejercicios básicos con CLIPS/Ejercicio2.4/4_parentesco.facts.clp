
(deffacts Arbol
    (Persona (Nombre Felipe) (Sexo Hombre))
    (Persona (Nombre Isabel) (Sexo Mujer))

        (PadreDe (Padre Felipe) (Hijo Ana))
        (PadreDe (Padre Isabel) (Hijo Ana))
        (Persona (Nombre Ana) (Sexo Mujer))

        (PadreDe (Padre Felipe) (Hijo Andrés))
        (PadreDe (Padre Isabel) (Hijo Andrés))
        (Persona (Nombre Andrés) (Sexo Hombre))

        (PadreDe (Padre Felipe) (Hijo Eduardo))
        (PadreDe (Padre Isabel) (Hijo Eduardo))
        (Persona (Nombre Eduardo) (Sexo Hombre))

        (PadreDe (Padre Felipe) (Hijo Carlos))
        (PadreDe (Padre Isabel) (Hijo Carlos))
        (Persona (Nombre Carlos) (Sexo Hombre))
            
            (PadreDe (Padre Carlos) (Hijo Guillermo))
            (Persona (Nombre Guillermo) (Sexo Hombre))

                (PadreDe (Padre Guillermo) (Hijo Jorge))
                (Persona (Nombre Jorge) (Sexo Hombre))
                (PadreDe (Padre Guillermo) (Hijo Carlota))
                (Persona (Nombre Carlota) (Sexo Mujer))
                (PadreDe (Padre Guillermo) (Hijo Luis))
                (Persona (Nombre Luis) (Sexo Hombre))

            (PadreDe (Padre Carlos) (Hijo Enrique))
            (Persona (Nombre Enrique) (Sexo Hombre))

                (PadreDe (Padre Enrique) (Hijo Archie))
                (Persona (Nombre Archie) (Sexo Hombre))

                (PadreDe (Padre Enrique) (Hijo Lilibet))
                (Persona (Nombre Lilibet) (Sexo Mujer)) 
)