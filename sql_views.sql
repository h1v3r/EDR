/*********************************************************************
/**
/** Table (View): view_user_produkte
/** Developer: Albert Schleidt
/** Description: Lists all products, users are currently offering
/**
/*********************************************************************/
CREATE OR REPLACE view view_user_produkte AS
    SELECT "angebotid" AS "Angebot ID", "produktid" AS "Produkt ID", "name" AS "Produktname", "userid_verkaeufer" AS "User ID Verkäufer", "vorname" "Vorname", "nachname" AS "Nachname"
    FROM "Produkt"
    JOIN "Produkt_Angebot" USING ("produktid")
    JOIN "Angebot" USING ("angebotid")
    JOIN "User" ON "userid_verkaeufer" = "userid";

/*********************************************************************
/**
/** Table: "User"
/** Developer: Florian Weiss
/** Description: Zeigt Userdetails aller User mit Adresse und Rolle
/**
/*********************************************************************/

CREATE OR REPLACE VIEW User_Details AS
SELECT * FROM "User" 
	LEFT JOIN "Adresse" USING("adresseid")
	LEFT JOIN "Ort" USING("plz")
	LEFT JOIN "Rolle" USING("rolleid")
/

/*********************************************************************
/**
/** Table: Bio_Faktor_User_Durchschnitt
/** Developer: Jakob Neuhauser
/** Description: A View which shows the average Bio_factor of every seller. 
/**
/*********************************************************************/

create or replace view Bio_Faktor_User_Durchschnitt as 
  select "userid", avg(to_number(substr("kategorie_bezeichnung", 5, 1))) as Bio_Fakto from "User"
    full join "Angebot" on "User"."userid"="Angebot"."userid_verkaeufer"
    left join "Produkt_Angebot" using ("angebotid")
    left join "Produkt" using ("produktid")
    left join "Bio_Faktor" using ("bioid")
    group by "userid"
    order by "userid" asc;
   
/*********************************************************************
/**
/** Table (View): transaktion_per_saison
/** Developer: Paul Pavlis
/** Description: A View which shows the number of transactions per Saison
/**
/*********************************************************************/

CREATE OR REPLACE VIEW transaktion_per_saison AS
	SELECT "name" AS "Saison Name", COUNT(*) AS "Anzahl Transaktionen"
	FROM "Transaktion"
	JOIN "Angebot" USING ("angebotid")
	JOIN "Produkt_Angebot" USING ("angebotid")
	JOIN "Produkt" USING ("produktid")
	JOIN "Saison" USING ("saisonid")
	GROUP BY "name";
