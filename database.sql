/* Part C. create related t able for vaccine rollout tracking*/

PRAGMA foreign_keys = off;

/*Location Table*/
DROP TABLE IF EXISTS Location;
CREATE TABLE Location
(
iso_code                    VARCHAR(3)UNIQUE,
location                     VARCHAR(70) NOT NULL,
last_observation_date        DATE NOT NULL,
vaccines_available            VARCHAR(100) ,

PRIMARY KEY (iso_code)
);

/*Vaccines Table*/
DROP TABLE IF EXISTS Vaccines;

CREATE TABLE Vaccines 
(
vaccine_id                     VARCHAR(10) NOT NULL,
vaccine_name                   VARCHAR(100) NOT NULL,
PRIMARY KEY (vaccine_id)
);


/* Vaccination Table */
DROP TABLE IF EXISTS Vaccination;

CREATE TABLE Vaccinations
(
iso_code                                      VARCHAR(3)NOT NULL,
date                                          DATE NOT NULL,
total_vaccinations                            INTEGER ,
people_vaccinated	                         INTEGER ,
people_fully_vaccinated                       INTEGER ,
total_boosters                                INTEGER ,
daily_vaccinations_raw                        INTEGER ,
daily_vaccinations                            INTEGER ,
total_vaccination_per_hundred                 INTEGER ,
people_vaccinated_per_hundred                 INTEGER ,
people_fully_vaccinated_per_hundred           INTEGER ,
total_boosters_per_hundred                    INTEGER ,
daily_vaccinations_per_million                INTEGER ,
daily_prople_vaccinated                       INTEGER ,
daily_prople_vaccinated_per_hundred           INTEGER ,

FOREIGN KEY (iso_code) REFERENCES Location

);


/*VaccineLocation Table*/
DROP TABLE IF EXISTS VaccineLocation;
CREATE TABLE VaccineLocation 
(
iso_code                    VARCHAR(3) NOT NULL,
vaccine_id                  VARCHAR(10) NOT NULL,
source_id                   VARCHAR(3) NOT NULL,

FOREIGN KEY (iso_code) REFERENCES Location, 
FOREIGN KEY (vaccine_id) REFERENCES Vaccines,
FOREIGN KEY (source_id) REFERENCES Source                    

);

/* Source Table */
DROP TABLE IF EXISTS Source;

CREATE TABLE Source
(source_id                    INTEGER        NOT NULL,
iso_code                      VARCHAR(3)     NOT NULL,
source_name                   VARCHAR(100)   NOT NULL ,
source_website	          VARCHAR(100) ,

PRIMARY KEY (source_id)
FOREIGN KEY (iso_code) REFERENCES Location

);



/* VaccineCountryManufacturer Table */
DROP TABLE IF EXISTS VaccineCountryManufacturer;

CREATE TABLE VaccineCountryManufacturer
(
iso_code                    VARCHAR(3)      NOT NULL,
vaccine_id                     VARCHAR(10) NOT NULL,
date                        DATE            NOT NULL ,
total_vaccinations          INTEGER,

FOREIGN KEY (iso_code) REFERENCES Location
FOREIGN KEY (vaccine_id) REFERENCES Vaccines
);



/* CountryDailyVaccination Table */
DROP TABLE IF EXISTS CountryDailyVaccination;
CREATE TABLE CountryDailyVaccination
(
iso_code                    INTEGER     NOT NULL,
date                        DATE,
vaccine                     VARCHAR(100),
total_vaccinations          INTEGER,
people_vaccinated           INTEGER,
people_fully_vaccinated     INTEGER,
total_boosters              INTEGER,

FOREIGN KEY (iso_code) REFERENCES Location

);


/* AgeGroups Table */
DROP TABLE IF EXISTS AgeGroups;

CREATE TABLE AgeGroups (
age_group_id  INTEGER,
age_group     STRING  NOT NULL,
PRIMARY KEY (age_group_id)
);


/* VaccinationAge Table*/
DROP TABLE IF EXISTS VaccinationAge;

CREATE TABLE VaccinationAge (
iso_code                            VARCHAR(3)  NOT NULL,
date                                DATE        NOT NULL,
age_group_id                        INTEGER     NOT NULL,
people_vaccinated_perhundred        INTEGER,
people_fully_vaccinated_per_hundred INTEGER,

FOREIGN KEY (iso_code) REFERENCES Location
FOREIGN KEY (age_group_id) REFERENCES AgeGroups

);





/* US_state_data Table */
DROP TABLE IF EXISTS US_state_data;

CREATE TABLE US_state_data (
state_code      INTEGER NOT NULL,
state_name      VARCHAR(50)  NOT NULL,
PRIMARY KEY (state_code)
);


/* USStatesDailyVaccination Table */
DROP TABLE IF EXISTS USStatesDailyVaccination;
CREATE TABLE USStatesDailyVaccination 
(
iso_code                            VARCHAR(3)     NOT NULL,
date                                DATE           NOT NULL,
state_code                          INTEGER        NOT NULL,
total_vaccinations                  INTEGER,
total_distributed                   INTEGER,
people_vaccinated                   INTEGER,
people_fully_vaccinated             INTEGER,


FOREIGN KEY (iso_code) REFERENCES Location,
FOREIGN KEY (state_code) REFERENCES US_state_data
);


PRAGMA foreign_keys = on;

