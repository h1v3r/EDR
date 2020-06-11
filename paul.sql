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

/** To test the view */
--SELECT * FROM transaktion_per_saison;