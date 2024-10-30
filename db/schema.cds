namespace mnj.sapas;

type Structure {
    key field1 : String(1);
        field2 : String(2);
        field3 : String(3);
        field4 : Integer;
};

entity Entity_a {
    fields : Structure;
}

entity Entity_b {
    fields : Structure;
}

// Crear una proyección
entity P_Entity_a                                   as
    projection on Entity_a {
        fields.field1 as field1_lite,
        fields.field2 as field2_lite
    };

// Exponer la diferencia entre vista y proyección.
// Con una proyección no podemos aprovechar el potencial del SQL; JOIN, UNION, sub selects
// por ejemplo la siguiente sentencia:
entity S_entity_a_b                                 as
    select from Entity_a
    inner join Entity_b
        on Entity_a.fields.field1 = Entity_b.fields.field1
    {
        Entity_a.fields.field1 as field1,
        Entity_a.fields.field2 as field2,
        Entity_b.fields.field3 as field3,
        Entity_b.fields.field4 as field4,
    }
    where
        Entity_a.fields.field3 in (
            select fields.field3 from Entity_b
            where
                fields.field2 = 'AB'
        )
        group by
            Entity_a.fields.field2
        order by
            field1;

// Crear una entidad con parámetros.
entity Entity_c(pi_1 : String(1), pi_2 : String(2)) as
    select * from Entity_a
    where
            fields.field1 = :pi_1
        and fields.field2 = :pi_2;

// ¿Cuando es factible crear una entidad con parámetros?
// Cuando estamos en un sistema con base de datos HANA

// Crear una ampliación de una entidad.
// Crear la asociación a 1 que hemos creado tanto de manera administrada como de manera no administrada. ¿Sabrías decir cual es cual?
// Crear una asociación adicional a 1 contra otra entidad.
// ¿Qué parámetro podemos usar en la url para ver desde el navegador los datos relacionados con otras entidades?
