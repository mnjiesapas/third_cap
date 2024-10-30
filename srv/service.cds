using mnj.sapas as sapas from '../db/schema';

service third_cap {
    entity Entity_as as projection on sapas.Entity_a;
    entity Entity_bs as projection on sapas.Entity_b;
    entity P_Entity_as as projection on sapas.P_Entity_a;
    entity S_entity_a_bs as projection on sapas.S_entity_a_b;
}