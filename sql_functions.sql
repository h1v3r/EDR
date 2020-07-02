/*********************************************************************
/**
/** Function f_filter_angebot_by_produktname_cur
/** In: l_v_suchstring_in - the string to search for
/** Returns: A SYS_REFCURSOR with all matching entries fron Angebot joined with Produkt
/** Developer: Albert Schleidt
/** Description: Takes an input string, shows every Angebot that offers a Produkt containing the string. Returns a SYS_REFCURSOR.
/**
/*********************************************************************/
CREATE OR REPLACE FUNCTION f_filter_ang_prodname_cur (l_v_suchstring_in IN VARCHAR, l_v_error_out OUT NUMBER) RETURN SYS_REFCURSOR AS
    l_return_cursor_cur_out SYS_REFCURSOR;
BEGIN
    OPEN l_return_cursor_cur_out FOR SELECT * FROM "Angebot" JOIN "Produkt_Angebot" USING ("angebotid") JOIN "Produkt" USING ("produktid") WHERE "name" LIKE '%'||l_v_suchstring_in||'%';
    RETURN l_return_cursor_cur_out;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/

/*********************************************************************
/**
/** Function: Transaktionen_UserX
/** In: UserID ? ID des Users der seine Transaktionen sehen will.
/** Returns: Cursor der alle Transaktionen auflistet diese Users Values: Transaktionsid, Userid_verk�ufer und der Anzeigetext
/** Developer: Florian Weiss
/** Description: Diese Funktion Liefert einen Cursor mit allen Transaktionen eines Users zur�ck. 
/**
/*********************************************************************/

CREATE OR REPLACE FUNCTION f_transaktion_userx (i_n_userid IN NUMBER, l_v_error_ou OUT VARCHAR) RETURN SYS_REFCURSOR 
AS

rc SYS_REFCURSOR;

BEGIN
 OPEN rc FOR SELECT "transaktionid", "userid_verkaeufer", "anzeigetext" FROM "User" 
	LEFT JOIN "Transaktion" ON "userid" = "userid_kaeufer"
	LEFT JOIN "Angebot" USING("angebotid")
	WHERE "userid" = i_n_userid;
	
RETURN rc;
 EXCEPTION 
 WHEN others THEN
        l_v_error_ou := SQLCODE;
 

END;
/

/*********************************************************************
/**
/** Function: Nachrichten_UserX
/** In: UserID ? ID des Users der seine Nachrichten sehen will.
/** Returns: Cursor der alle Nachriten auflistet die der User versendet hat Values: Vorname empf�nger, Nachname Empf�nger, Text und Timestamp
/** Developer: Florian Weiss
/** Description: Diese Funktion Liefert einen Cursor mit allen Nachrichten die ein Users versendet hat zur�ck. 
/**
/*********************************************************************/

CREATE OR REPLACE FUNCTION f_Nachrichten_UserX (i_n_userid IN number, l_v_error_ou OUT VARCHAR) RETURN SYS_REFCURSOR 
AS

rc SYS_REFCURSOR;

BEGIN
 OPEN rc FOR SELECT empf."vorname", empf."nachname", n."inhalt", n."message_time" FROM "User" s
	LEFT JOIN "Nachrichten" n ON s."userid" = n."userid_sender"
	LEFT JOIN "User" empf ON n."userid_empf" = empf."userid"
		WHERE s."userid" = i_n_userid;
	
RETURN rc;

 EXCEPTION 
 WHEN others THEN
        l_v_error_ou := SQLCODE;
 
END;
/

/*********************************************************************
/**
/** Function: Angebote_Saison
/** In: SaisonId ? ID der gew�nschten Saison 
/** Returns: Cursor der alle Angebote einer saison zur�ck liefert
/** Developer: Florian Weiss
/** Description: Diese Funktion Liefert einen Cursor mit allen Angeboten die einer bestimmten Saison zugewiesen sind. 
/**
/*********************************************************************/
CREATE OR REPLACE FUNCTION f_angebote_saison (i_in_sid IN NUMBER, l_v_error_ou OUT VARCHAR) RETURN SYS_REFCURSOR
AS

rc SYS_REFCURSOR;

BEGIN
OPEN rc FOR SELECT a."angebotid", a."anzeigetext", p."name" FROM "Angebot" a 
		LEFT JOIN "Produkt_Angebot" pa ON a."angebotid"= pa."angebotid"
		LEFT JOIN "Produkt" p USING("produktid")
		WHERE "saisonid" = i_in_sid;
		
RETURN rc;

 EXCEPTION 
 WHEN others THEN
        l_v_error_ou := SQLCODE;
 
END;
/