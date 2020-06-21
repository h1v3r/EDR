-- Zwei Optionen:
-- Option 1: Neuen User mit readonly privileges erstellen
create user edr_readonly identified by edr_readonly;
grant create session to edr_readonly;

grant select on BIO_FAKTOR_USER_DURCHSCHNITT to edr_readonly;
grant select on VIEW_USER_PRODUKTE to edr_readonly;
grant select on TRANSAKTION_PER_SAISON to edr_readonly;

select * from edr_user.BIO_FAKTOR_USER_DURCHSCHNITT;