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
CREATE OR REPLACE FUNCTION filter_angebot_by_produktname (l_v_suchstring_in IN VARCHAR) RETURN SYS_REFCURSOR AS
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

/*********************************************************************
/**
/** Procedure: add_adresse
/** Out: Primary Key ID of the existing or added element
/** Out: Error code if error occured
/** In: l_n_plzpk_in - the primary key of the plz to be associated with the Adresse
/** In: l_v_strasse_in - the Strasse parameter to be added to the Adresse
/** In: l_v_hausnummer_in - the Hausnummer parameter to be added to the Adresse
/** Developer: Albert Schleidt
/** Description: Creates a new Adresse, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE add_adresse (l_n_plzpk_in IN NUMBER, l_v_strasse_in IN VARCHAR, l_v_hausnummer_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
    l_n_adresseid NUMBER;
    l_n_maxAdresseid NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_n_countEntries FROM "Adresse" WHERE "plz" = l_n_plzpk_in AND "strasse" = l_v_strasse_in AND "hausnummer" = l_v_hausnummer_in;
    IF l_n_countEntries > 0 THEN
        SELECT "adresseid" INTO l_n_pk_out FROM "Adresse" WHERE "plz" = l_n_plzpk_in AND "strasse" = l_v_strasse_in AND "hausnummer" = l_v_hausnummer_in;
        RETURN;
    ELSE
        SELECT MAX("adresseid") INTO l_n_maxAdresseid FROM "Adresse";
        INSERT INTO "Adresse" VALUES (l_n_maxAdresseid+1, l_n_plzpk_in, l_v_strasse_in, l_v_hausnummer_in);
        l_n_pk_out := l_n_maxAdresseid+1;
    END IF;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/

/*********************************************************************
/**
/** Procedure: add_rolle
/** Out: Primary Key ID of the existing or added element
/** Out: Error code if error occured
/** In: l_v_titel_in - Title of the Rolle
/** In: l_v_beschreibung_in - Beschreibung of the Rolle
/** Developer: Albert Schleidt
/** Description: Creates a new Rolle, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE add_rolle (l_v_titel_in IN VARCHAR, l_v_beschreibung_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
    l_n_maxRolleid NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_n_countEntries FROM "Rolle" WHERE "title" = l_v_titel_in AND "beschreibung" = l_v_beschreibung_in;
    IF l_n_countEntries > 0 THEN
        SELECT "rolleid" INTO l_n_pk_out FROM "Rolle" WHERE "title" = l_v_titel_in AND "beschreibung" = l_v_beschreibung_in;
        RETURN;
    ELSE
        SELECT MAX("rolleid") INTO l_n_maxRolleid FROM "Rolle";
        INSERT INTO "Rolle" VALUES (l_n_maxRolleid+1, l_v_titel_in, l_v_beschreibung_in);
        l_n_pk_out := l_n_maxRolleid+1;
    END IF;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/
-- TODO:
-- Rolle anlegen
-- User anlegen