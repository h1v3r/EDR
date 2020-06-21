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
CREATE OR REPLACE FUNCTION filter_angebot_by_produktname (l_v_suchstring_in IN varchar) RETURN SYS_REFCURSOR AS
    l_return_cursor_cur_out SYS_REFCURSOR;
BEGIN
    OPEN l_return_cursor_cur_out for SELECT * FROM "Angebot" JOIN "Produkt_Angebot" USING ("angebotid") JOIN "Produkt" USING ("produktid") WHERE "name" LIKE '%'||l_v_suchstring_in||'%';
    RETURN l_return_cursor_cur_out;
--exception
END;
/


/*********************************************************************
/**
/** Procedure: add_ort
/** Out: nothing
/** In: l_n_plz_in - the desired PLZ for the new Ort
/** In: l_v_ortsname_in - the desired name for the new Ort
/** Developer: Albert Schleidt
/** Description: Creates a new Ort, IF it doesn't exist already.
/**
/*********************************************************************/
-- Entweder mit OUT Parameter Fehlercode machen oder FUNCTION RETURN NUMBER den PK des erzeugten Eintrags
CREATE OR REPLACE PROCEDURE add_ort (l_n_plz_in IN NUMBER, l_v_ortsname_in IN varchar) AS
    l_n_countEntries NUMBER;
BEGIN
    SELECT count(*) INTO l_n_countEntries FROM "Ort" WHERE "plz" = l_n_plz_in AND "name" = l_v_ortsname_in;
    IF l_n_countEntries > 0 THEN
        dbms_output.put_line(l_n_plz_in);
        RETURN;
    ELSE
        INSERT INTO "Ort" VALUES (l_n_plz_in, l_v_ortsname_in);
        dbms_output.put_line(l_n_plz_in);
    END IF;
exception
    when others THEN
        dbms_output.put_line('-1');
        IF sqlcode = -00001 THEN
            dbms_output.put_line('Unique constraint violated.');
        END IF;
END;
/

-- TODO:
-- Adresse anlegen
-- Rolle anlegen
-- User anlegen
