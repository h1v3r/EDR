/*********************************************************************
/**
/** Procedure: sp_add_ort
/** Out: l_n_pk_out - rimary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_n_plz_in - the desired PLZ for the new Ort
/** In: l_v_ortsname_in - the desired name for the new Ort
/** Developer: Albert Schleidt
/** Description: Creates a new Ort, IF it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_ort (l_n_plz_in IN NUMBER, l_v_ortsname_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
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
/** Procedure: sp_add_adresse
/** Out: l_n_pk_out - rimary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_n_plzpk_in - the primary key of the plz to be associated with the Adresse
/** In: l_v_strasse_in - the Strasse parameter to be added to the Adresse
/** In: l_v_hausnummer_in - the Hausnummer parameter to be added to the Adresse
/** Developer: Albert Schleidt
/** Description: Creates a new Adresse, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_adresse (l_n_plzpk_in IN NUMBER, l_v_strasse_in IN VARCHAR, l_v_hausnummer_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
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
/** Procedure: sp_add_rolle
/** Out: l_n_pk_out - rimary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_v_titel_in - Title of the Rolle
/** In: l_v_beschreibung_in - Beschreibung of the Rolle
/** Developer: Albert Schleidt
/** Description: Creates a new Rolle, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_rolle (l_v_titel_in IN VARCHAR, l_v_beschreibung_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
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

/*********************************************************************
/**
/** Procedure: sp_add_user
/** Out: l_n_pk_out - rimary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_n_rollepk_in - rolleid of the user
/** In: l_v_vorname_in - vorname of the user
/** In: l_v_nachname_in - nachname of the user
/** In: l_d_dob_in - date of birth of the user
/** In: l_n_adressepk_in - adresseid of the user
/** Developer: Albert Schleidt
/** Description: Creates a new user, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_user (l_n_rollepk_in IN NUMBER, l_v_vorname_in IN VARCHAR, l_v_nachname_in IN VARCHAR, l_d_dob_in DATE, l_n_adressepk_in IN NUMBER, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
    l_n_maxUserid NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_n_countEntries FROM "User" WHERE "rolleid" = l_n_rollepk_in AND "vorname" = l_v_vorname_in AND "nachname" = l_v_nachname_in AND "dob" = l_d_dob_in AND "adresseid" = l_n_adressepk_in;
    IF l_n_countEntries > 0 THEN
    SELECT "userid" INTO l_n_pk_out FROM "User" WHERE "rolleid" = l_n_rollepk_in AND "vorname" = l_v_vorname_in AND "nachname" = l_v_nachname_in AND "dob" = l_d_dob_in AND "adresseid" = l_n_adressepk_in;
        RETURN;
    ELSE
        SELECT MAX("userid") INTO l_n_maxUserid FROM "User";
        INSERT INTO "User" VALUES (l_n_maxUserid+1, l_n_rollepk_in, l_v_vorname_in, l_v_nachname_in, l_d_dob_in, l_n_adressepk_in);
        l_n_pk_out := l_n_maxUserid+1;
    END IF;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/
