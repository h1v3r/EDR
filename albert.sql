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
/** Function filter_angebot_by_produktname
/** In: l_v_suchstring_in - the string to search for
/** Returns: A SYS_REFCURSOR with all matching entries fron Angebot joined with Produkt
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


/*********************************************************************
/**
/** Procedure: add_ort
/** Out: nothing
/** In: l_n_plz_in - the desired PLZ for the new Ort
/** In: l_v_ortsname_in - the desired name for the new Ort
/** Developer: Albert Schleidt
/** Description: Creates a new Ort, if it doesn't exist already.
/**
/*********************************************************************/
create or replace procedure add_ort (l_n_plz_in in number, l_v_ortsname_in in varchar) as
    l_n_countEntries number;
begin
    select count(*) into l_n_countEntries from "Ort" where "plz" = l_n_plz_in and "name" = l_v_ortsname_in;
    if l_n_countEntries > 0 then
        dbms_output.put_line(l_n_plz_in);
        return;
    else
        insert into "Ort" values (l_n_plz_in, l_v_ortsname_in);
        dbms_output.put_line(l_n_plz_in);
    end if;
exception
    when others then
        dbms_output.put_line('-1');
        if sqlcode = -00001 then
            dbms_output.put_line('Unique constraint violated.');
        end if;
end;
/