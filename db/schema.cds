namespace mnj.sapas;

type Structure
{
    key field1 : String(1) not null;
    field2 : String(2);
    field3 : String(3);
    field4 : Integer;
}

entity Entity_a
{
    fields : Structure;
}

entity Entity_b
{
    key field1 : String(1);
    field2 : String(2);
    field3 : String(3);
    field4 : Integer;
    field5 : Integer;
    field6 : String(6);
}

entity P_Entity_a as
    projection on Entity_a
    {
        key fields.field1 as field1_lite,
        fields.field2 as field2_lite
    };

entity S_entity_a_b as
    select from Entity_a
    inner join Entity_b on Entity_a.fields.field1 = Entity_b.field1
    {
        key Entity_a.fields.field1 as field1,
        Entity_a.fields.field2 as field2,
        Entity_b.field3,
        Entity_b.field4,
    }
    where Entity_a.fields.field3 in(select field3 from Entity_b
        where field2 = 'AB')
    group by Entity_a.fields.field2
    order by field1;

entity Suppliers
{
    key ID : UUID;
    Name : String;
    Street : String;
    City : String;
    State : String(2);
    PostalCode : String(5);
    Country : String(3);
    Email : String;
    Phone : String;
    Fax : String;
}

entity Products_adm
{
    key ID : UUID;
    Name : String;
    Description : String;
    ImageUrl : String;
    ReleaseDate : DateTime;
    DiscontinuedDate : DateTime;
    Price : Decimal(16,2);
    Height : Decimal(16,2);
    Width : Decimal(16,2);
    Depth : Decimal(16,2);
    Quantity : Decimal(16,2);
    ToSupplier : Association to one Suppliers;
    ToEntityb : Association to one Entity_b;
}

entity Products_no_adm
{
    key ID : UUID;
    Name : String;
    Description : String;
    ImageUrl : String;
    ReleaseDate : DateTime;
    DiscontinuedDate : DateTime;
    Price : Decimal(16,2);
    Height : Decimal(16,2);
    Width : Decimal(16,2);
    Depth : Decimal(16,2);
    Quantity : Decimal(16,2);
    Supplier_ID : UUID;
    ToSupplier : Association to one Suppliers on ToSupplier.ID = Supplier_ID;
}

entity Padre
{
    key ID : UUID;
    Property1 : String(100);
    Property2 : String(100);
    hijo : Association to one Hijo on hijo.padre = $self;
}

entity Hijo
{
    key ID : UUID;
    Property1 : String(100);
    Property2 : String(100);
    padre : Association to one Padre;
}
