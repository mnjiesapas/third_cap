namespace mnj.sapas;
// esto da error
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
    key field1 : String(1);
        field2 : String(2);
        field3 : String(3);
        field4 : Integer;
}

// Crear una proyección
entity P_Entity_a   as
    projection on Entity_a {
        key fields.field1 as field1_lite,
            fields.field2 as field2_lite
    };

// Exponer la diferencia entre vista y proyección.
// Con una proyección no podemos aprovechar el potencial del SQL; JOIN, UNION, sub selects
// por ejemplo la siguiente sentencia:
entity S_entity_a_b as
    select from Entity_a
    inner join Entity_b
        on Entity_a.fields.field1 = Entity_b.field1
    {
        key Entity_a.fields.field1 as field1,
            Entity_a.fields.field2 as field2,
            Entity_b.field3,
            Entity_b.field4,
    }
    where
        Entity_a.fields.field3 in (
                select field3 from Entity_b
                where
                    field2 = 'AB'
            )
        group by
            Entity_a.fields.field2
        order by
            field1;

// Crear una entidad con parámetros.
// entity Entity_c(pi_1 : String(1), pi_2 : String(2)) as
//     select * from Entity_a
//     where
//             fields.field1 = :pi_1
//         and fields.field2 = :pi_2;

// ¿Cuando es factible crear una entidad con parámetros?
// Cuando estamos en un sistema con base de datos HANA
// Por ejemplo al compilar la Entity_c la terminal devuelve el siguiente mensaje:
// SQLite does not support entities with parameters (in entity:“mnj.sapas.Entity_c”)

// Crear una ampliación de una entidad.
extend Entity_b with {
    field5 : Integer;
    field6 : String(6);
};


// Crear la asociación a 1 que hemos creado tanto de manera administrada como de manera no administrada. ¿Sabrías decir cual es cual?
// Tomando como referencia la entidad Suppliers...
entity Suppliers {
    key ID         : UUID;
        Name       : String;
        Street     : String;
        City       : String;
        State      : String(2);
        PostalCode : String(5);
        Country    : String(3);
        Email      : String;
        Phone      : String;
        Fax        : String;
};

// Administrada en entidad Products
entity Products_adm {
    key ID               : UUID;
        Name             : String;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        ToSupplier       : Association to Suppliers;
        ToEntityb        : Association to Entity_b;
};

// No Administrada en entidad Products
entity Products_no_adm {
    key ID               : UUID;
        Name             : String;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier_ID      : UUID;
        ToSupplier       : Association to one Suppliers
                               on ToSupplier.ID = Supplier_ID;
};

// Crear una asociación adicional a 1 contra otra entidad.
// Mirar entidad Products_adm

// ¿Qué parámetro podemos usar en la url para ver desde el navegador los datos relacionados con otras entidades?
// Con el parametro $expand
// https://port4004-workspaces-ws-l2lv8.us10.trial.applicationstudio.cloud.sap/odata/v4/third-cap/Products_adm?$expand=ToSupplier
// https://port4004-workspaces-ws-l2lv8.us10.trial.applicationstudio.cloud.sap/odata/v4/third-cap/Products_adm?$expand=ToEntityb
// https://port4004-workspaces-ws-l2lv8.us10.trial.applicationstudio.cloud.sap/odata/v4/third-cap/Products_no_adm?$expand=ToSupplier
