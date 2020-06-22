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

/*********************************************************************
/**
/** Table: Bio_Faktor_User_Durchschnitt
/** Developer: Jakob Neuhauser
/** Description: A View which shows the average Bio_factor of every seller. 
/**
/*********************************************************************/

CREATE OR REPLACE VIEW Bio_Faktor_User_Durchschnitt AS 
  SELECT "userid", AVG(TO_NUMBER(SUBSTR("kategorie_bezeichnung", 5, 1))) AS bio_faktor FROM "User"
    FULL JOIN "Angebot" ON "User"."userid"="Angebot"."userid_verkaeufer"
    LEFT JOIN "Produkt_Angebot" USING ("angebotid")
    LEFT JOIN "Produkt" USING ("produktid")
    LEFT JOIN "Bio_Faktor" USING ("bioid")
    GROUP BY "userid"
    ORDER BY "userid" ASC;
    
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
