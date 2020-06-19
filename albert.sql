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


/*********************************************************************
/**
/** Procedure filter_angebot_by_produktname
/** Out: nothing
/** In: l_v_suchstring_in
/** Developer: Albert Schleidt
/** Description: Takes an input string, shows every Angebot that offers a Produkt containing the string. Returns a SYS_REFCURSOR.
/**
/*********************************************************************/
create or replace function filter_angebot_by_produktname (l_v_suchstring_in in varchar) return SYS_REFCURSOR as
    l_return_cursor_cur_out SYS_REFCURSOR;
begin
    open l_return_cursor_cur_out for select * from "Angebot" join "Produkt_Angebot" using ("angebotid") join "Produkt" using ("produktid") where "name" like '%'||l_v_suchstring_in||'%';
    return l_return_cursor_cur_out;
--exception
end;
/