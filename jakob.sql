set serveroutput on;
/

/*********************************************************************
/**
/** Procedur: sp_addProduct
/** Out: nothing
/** In: l_n_saisonid_in - The Saisonid of the product.
/** In: l_n_bioid_in - The Bioid of the product.
/** In: l_v_name_in - The name of the product.
/**Developer: Jakob Neuhauser
/**Description: The procedure takes all the arguments needed for a product and inserts the data into the database. If saisonid or bioid is not valid, the data will not be inserted. 
/**
/*********************************************************************/

create or replace procedure sp_addProduct (l_n_saisonid_in number, l_n_bioid_in number, l_v_name_in varchar) as
  l_n_produktid number;
  l_n_count number;
begin  
  
  select count(*) into l_n_count from "Saison" where "saisonid" = l_n_saisonid_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no saisonis ' || l_n_saisonid_in || '. Aborting!');
    return;
  end if; 
  
  select count(*) into l_n_count from "Bio_Faktor" where "bioid" = l_n_bioid_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no bioid ' || l_n_bioid_in || '. Aborting!');
    return;
  end if;

  select max("produktid")+1 into l_n_produktid from "Produkt";
  insert into "Produkt" ("produktid", "saisonid", "bioid", "name") values (l_n_produktid, l_n_saisonid_in, l_n_bioid_in, l_v_name_in);

exception 
  when no_data_found then 
    dbms_output.put_line('No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200));
  when too_many_rows then 
    dbms_output.put_line('Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200));
  when timeout_on_resource then 
    dbms_output.put_line('Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200));
  when others then
    dbms_output.put_line('Some unknowen error occoured!'    ||  SUBSTR(SQLERRM, 1, 200));

end;

/
