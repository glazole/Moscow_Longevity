/*
CREATED BY: Oleg Glazkov
CREATED ON: 10/09/2023
DESCRIPTION: Таблица содержащая информацию об участниках 
проекта Московское долголетие
*/

CREATE TABLE
  mos_long.users (
    num_client INTEGER PRIMARY KEY CHECK (num_client > 0),
    date_reg VARCHAR(25) NOT NULL,
    sex VARCHAR(32) NOT NULL,
	date_birth VARCHAR(25) NOT NULL,
	address VARCHAR(250) NOT NULL
  );
  
/*
CREATED BY: Oleg Glazkov
CREATED ON: 10/09/2023
DESCRIPTION: Таблица содержащая информацию о группах активностей 
проекта Московское долголетие
*/
  
CREATE TABLE
  mos_long.groups_activity (
    num_group INTEGER PRIMARY KEY CHECK (num_group > 0),
    level1 VARCHAR(250) NOT NULL,
	level2 VARCHAR(250) NOT NULL,
	level3 VARCHAR(250) NOT NULL,
    address VARCHAR(250) NOT NULL,
	okrug_ex VARCHAR(250),
	region_ex VARCHAR(250)	  
  );

/*
CREATED BY: Oleg Glazkov
CREATED ON: 10/09/2023
DESCRIPTION: Таблица содержащая исторические данные обо всех прошедших активностях
проекта Московское долголетие
*/
  
CREATE TABLE
  mos_long.attend (
    num_zan INTEGER NOT NULL,
    num_group INTEGER NOT NULL,
	num_client INTEGER NOT NULL,
	level2 VARCHAR(250) NOT NULL,
	level3 VARCHAR(250) NOT NULL,
	online VARCHAR(10) NOT NULL,
	date_zan VARCHAR(25) NOT NULL,
    time_begin VARCHAR(25) NOT NULL,
	time_end VARCHAR(25) NOT NULL
  );