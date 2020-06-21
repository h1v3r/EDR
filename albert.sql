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
/** Function filter_angebot_by_produktname
/** In: l_v_suchstring_in - the string to search for
/** Returns: A SYS_REFCURSOR with all matching entries fron Angebot joined with Produkt
/** Developer: Albert Schleidt
/** Description: Takes an input string, shows every Angebot that offers a Produkt containing the string. Returns a SYS_REFCURSOR.
/**
/*********************************************************************/
CREATE OR REPLACE FUNCTION filter_angebot_by_produktname (l_v_suchstring_in IN VARCHAR) RETURN SYS_REFCURSOR , l_n_error_out OUT NUMBERAS
    l_return_cursor_cur_out SYS_REFCURSOR;
BEGIN
    OPEN l_return_cursor_cur_out for SELECT * FROM "Angebot" JOIN "Produkt_Angebot" USING ("angebotid") JOIN "Produkt" USING ("produktid") WHERE "name" LIKE '%'||l_v_suchstring_in||'%';
    RETURN l_return_cursor_cur_out;
--EXCEPTION
END;
/


/*********************************************************************
/**
/** Procedure: add_ort
/** Out: Primary Key ID of the existing or added element
/** Out: Error code if error occured
/** In: l_n_plz_in - the desired PLZ for the new Ort
/** In: l_v_ortsname_in - the desired name for the new Ort
/** Developer: Albert Schleidt
/** Description: Creates a new Ort, IF it doesn't exist already.
/**
/*********************************************************************/
-- Entweder mit OUT Parameter Fehlercode machen oder FUNCTION RETURN NUMBER den PK des erzeugten Eintrags
CREATE OR REPLACE PROCEDURE add_ort (l_n_plz_in IN NUMBER, l_v_ortsname_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
BEGIN
    SELECT count(*) INTO l_n_countEntries FROM "Ort" WHERE "plz" = l_n_plz_in AND "name" = l_v_ortsname_in;
    IF l_n_countEntries > 0 THEN
        l_n_pk_out := l_n_plz_in;
        RETURN;
    ELSE
        INSERT INTO "Ort" VALUES (l_n_plz_in, l_v_ortsname_in);
        l_n_pk_out := l_n_plz_in;
    END IF;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/
-- User anlegen
