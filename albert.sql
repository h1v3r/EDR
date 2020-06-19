/*********************************************************************
/**
/** Table (View): view_user_produkte
/** Developer: Albert Schleidt
/** Description: Lists all products, users are currently offering
/**
/*********************************************************************/
create or replace view view_user_produkte as
    select "angebotid" as "Angebot ID", "produktid" as "Produkt ID", "name" as "Produktname", "userid_verkaeufer" as "User ID Verkäufer", "vorname" "Vorname", "nachname" as "Nachname"
    from "Produkt"
    join "Produkt_Angebot" using ("produktid")
    join "Angebot" using ("angebotid")
    join "User" on "userid_verkaeufer" = "userid";