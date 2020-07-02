SET SERVEROUTPUT ON;
/
---Function testen
DECLARE
test SYS_REFCURSOR;
v_trans_id NUMBER;
v_trans_vk_id NUMBER;
v_trans_text VARCHAR(255);
xxx VARCHAR(255);

BEGIN
test := f_transaktion_userx_cur(10004,xxx);

LOOP
FETCH test INTO v_trans_id, v_trans_vk_id, v_trans_text;
EXIT WHEN test%NOTFOUND;
dbms_output.put_line(v_trans_id ||v_trans_vk_id ||v_trans_text);

END LOOP;

	

END;
/
---?Test Select f�r f_Transaktionen_UserX
Select * from "User" 
	LEFT JOIN "Transaktion" on "userid" = "userid_kaeufer"
	LEFT JOIN "Angebot" using("angebotid")
	
	WHERE "userid" = 10004
/
---Function testen
DECLARE
test SYS_REFCURSOR;
v_mes_vn VARCHAR(255);
v_mes_nn VARCHAR(255);
v_mes_text VARCHAR(255);
v_mes_time DATE;
xxx VARCHAR(255);

BEGIN
test := f_Nachrichten_UserX_cur(10002, xxx);

LOOP
FETCH test INTO v_mes_vn, v_mes_nn, v_mes_text,v_mes_time;
EXIT WHEN test%NOTFOUND;
dbms_output.put_line(v_mes_vn||v_mes_nn||v_mes_text||v_mes_time);

END LOOP;
END;
/
-- Test Select f�r die f_Nachrichten_UserX_cur
SELECT empf."vorname", empf."nachname", n."inhalt", n."message_time" FROM "User" s
	LEFT JOIN "Nachrichten" n ON s."userid" = n."userid_sender"
	LEFT JOIN "User" empf ON n."userid_empf" = empf."userid"
		WHERE s."userid" = 10002

/
---Function testen
DECLARE
test SYS_REFCURSOR;
v_ang_id VARCHAR(255);
v_ang_name VARCHAR(255);
v_ang_text VARCHAR(255);
xxx VARCHAR(255);

BEGIN
test := f_angebote_saison(1000, xxx);

LOOP
FETCH test INTO v_ang_id, v_ang_name, v_ang_text;
EXIT WHEN test%NOTFOUND;
dbms_output.put_line(v_ang_id||v_ang_name||v_ang_text);

END LOOP;

END;
/
-- Test select 
select a."angebotid", a."anzeigetext", p."name" from "Angebot" a 
		LEFT JOIN "Produkt_Angebot" pa on a."angebotid"= pa."angebotid"
		LEFT JOIN "Produkt" p using("produktid")
		WHERE "saisonid" = 3
/
