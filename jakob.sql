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
/**Description: The procedure takes all the arguments needed for a product and inserts the data into the database. If saisonid or bioid are not valid, the data will not be inserted. 
/**
/*********************************************************************/

create or replace procedure sp_addProduct (l_n_saisonid_in number, l_n_bioid_in number, l_v_name_in varchar) as
  l_n_produktid number;
  l_n_count number;
begin  
  
  select count(*) into l_n_count from "Saison" where "saisonid" = l_n_saisonid_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no saisonid ' || l_n_saisonid_in || '. Aborting!');
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
/*********************************************************************
/**
/** Procedur: sp_addOffer
/** Out: nothing
/** In: l_n_useridVerkaeufer_in - The userid of the seller.
/** In: l_n_kategorieid_in - The id of the kathegorie of the offer.
/** In: l_v_anzeigetext_in - A short discription or the offer or the title. 
/**Developer: Jakob Neuhauser
/**Description: The procedure takes all the arguments needed for an offer and inserts the data into the database. If kategorieid or useridVerkaeufer are not valid, the data will not be inserted. 
/**
/*********************************************************************/

create or replace procedure sp_addOffer (l_n_useridVerkaeufer_in number, l_n_kategorieid_in number, l_v_anzeigetext_in varchar) as
  l_n_angebotid number;
  l_n_count number;
begin  
  
  select count(*) into l_n_count from "User" where "userid" = l_n_useridVerkaeufer_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no userid ' || l_n_useridVerkaeufer_in || '. Aborting!');
    return;
  end if; 
  
  select count(*) into l_n_count from "Angebotskategorie" where "kategorieid" = l_n_kategorieid_in; 
  if l_n_count = 0 then
    dbms_output.put_line('There is no kategorieid ' || l_n_kategorieid_in || '. Aborting!');
    return;
  end if;

  select max("angebotid")+1 into l_n_angebotid from "Angebot";
  insert into "Angebot" ("angebotid", "userid_verkaeufer", "kategorieid", "anzeigetext") values (l_n_angebotid, l_n_useridVerkaeufer_in, l_n_kategorieid_in, l_v_anzeigetext_in);

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
/*********************************************************************
/**
/** Procedur: sp_addTransaction
/** Out: nothing
/** In: l_n_angebotid_in - The angebotid of the transaction.
/** In: l_n_useridKaufer_in - The userid of teh buyer.
/** In: l_v_bewertungVerkaeuferT_in - A rating in Text from the seller. 
/** In: l_v_bewertungVerkaeuferV_in - A rating in form of a value from the seller. 
/** In: l_v_bewertungKaeuferT_in - A rating in Text from the buyer. 
/** In: l_v_bewertungKaeuferV_in - A rating in form of a value from the buyer.
/**Developer: Jakob Neuhauser
/**Description: The procedure takes all the arguments needed for a transaction and inserts the data into the database. If angebotid or useridKaeufer are not valid, the data will not be inserted. 
/**
/*********************************************************************/

create or replace procedure sp_addTransaction (l_n_angebotid_in number, l_n_useridKaeufer_in number, l_v_bewertungVerkaeuferT_in varchar, l_n_bewertungVerkaeuferV_in number, l_v_bewertungKaeuferT_in varchar, l_n_bewertungKaeuferV_in number) as
  l_n_transaktionid number;
  l_n_count number;
begin  
  
  select count(*) into l_n_count from "Angebot" where "angebotid" = l_n_angebotid_in; 
  if l_n_count = 0 then
    dbms_output.put_line('There is no angebotid ' || l_n_angebotid_in || '. Aborting!');
    return;
  end if;

  select count(*) into l_n_count from "User" where "userid" = l_n_useridKaeufer_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no userid ' || l_n_useridKaeufer_in || '. Aborting!');
    return;
  end if; 

  select max("transaktionid")+1 into l_n_transaktionid from "Transaktion";
  insert into "Transaktion" ("transaktionid", "angebotid", "userid_kaeufer", "bewertung_verkaeufer_text", "bewertung_verkaeufer_value", "bewertung_kaeufer_text", "bewertung_kaeufer_value") values (l_n_transaktionid, l_n_angebotid_in, l_n_useridKaeufer_in, l_v_bewertungVerkaeuferT_in, l_n_bewertungVerkaeuferV_in, l_v_bewertungKaeuferT_in, l_n_bewertungKaeuferV_in);

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
/*********************************************************************
/**
/** Procedur: sp_sendMessage
/** Out: nothing
/** In: l_n_useridSender_in - The userid of the sender of the message.
/** In: l_n_useridEmpf_in - The userid of the receiver of the message.
/** In: l_v_inhalt_in - The content of the message. 
/**Developer: Jakob Neuhauser
/**Description: The procedure takes all the arguments needed for a Message and inserts the data into the database. If useridSender or useridEmpf are not valid, the data will not be inserted. The timestamp will be the time the procedure is executed. It is allowd that the userid of the sender and receiver are the same (for saving notes). 
/**
/*********************************************************************/

create or replace procedure sp_sendMessage (l_n_useridSender_in number, l_n_useridEmpf_in number, l_v_inhalt_in varchar) as
  l_n_nachrichtenid number;
  l_n_count number;
  l_d_now timestamp; 
begin  
  
  select count(*) into l_n_count from "User" where "userid" = l_n_useridSender_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no userid ' || l_n_useridSender_in || '. Aborting!');
    return;
  end if; 

  select count(*) into l_n_count from "User" where "userid" = l_n_useridEmpf_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no userid ' || l_n_useridEmpf_in || '. Aborting!');
    return;
  end if; 
  
  select current_date into l_d_now from dual; 

  select max("nachrichtenid")+1 into l_n_nachrichtenid from "Nachrichten";
  insert into "Nachrichten" ("nachrichtenid", "userid_sender", "userid_empf", "message_time", "inhalt") values (l_n_nachrichtenid, l_n_useridSender_in, l_n_useridEmpf_in, l_d_now, l_v_inhalt_in);
  
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
/*********************************************************************
/**
/** Table: Bio_Faktor_User_Durchschnitt
/**Developer: Jakob Neuhauser
/**Description: A View which shows the average Bio_factor of every seller. 
/**
/*********************************************************************/


create or replace view Bio_Faktor_User_Durchschnitt as 
  select "userid", avg(to_number(substr("kategorie_bezeichnung", 5, 1))) as Bio_Fakto from "User"
    full join "Angebot" on "User"."userid"="Angebot"."userid_verkaeufer"
    left join "Produkt_Angebot" using ("angebotid")
    left join "Produkt" using ("produktid")
    left join "Bio_Faktor" using ("bioid")
    group by "userid"
    order by "userid" asc;
   
