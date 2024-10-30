using mnj.sapas as sapas from '../db/schema';

service third_cap {
    entity Entity_as as projection on sapas.Entity_a;
    entity Entity_bs as projection on sapas.Entity_b;
    entity P_Entity_as as projection on sapas.P_Entity_a;
    entity S_entity_a_bs as projection on sapas.S_entity_a_b;
    entity Products_adm as projection on sapas.Products_adm;
    entity Products_no_adm as projection on sapas.Products_no_adm;
    entity Suppliers as projection on sapas.Suppliers;
}