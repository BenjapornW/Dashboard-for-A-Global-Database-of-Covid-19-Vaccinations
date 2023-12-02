/* Queries*/
   

/*Query 1*/
SELECT l.location AS 'Country Name(CN)',date AS 'Administered Vaccine on OD(VOD)',v.daily_vaccinations AS 'Total Adminstered Vaccines'
FROM Location l JOIN Vaccinations v
    ON  l.iso_code = v.iso_code;
                  
-----------------------------------------------------------------------------------------

/*Query 2* cumulative numbers of COVID-19 doses administered*/
SELECT l.location AS Country , MAX(NULLIF(total_vaccinations, "")) AS 'Cumulative Doses'
FROM Location l JOIN Vaccinations v
    ON  l.iso_code = v.iso_code
WHERE v.total_vaccinations NOT NULL AND Country NOT NULL
GROUP BY Country
ORDER BY Country ASC; 

-----------------------------------------------------------------------------------------

/*Query 3*/
SELECT l.location AS Country, vc.vaccine_name AS Vaccine
FROM (Location l Join VaccineLocation vl ON  l.iso_code = vl.iso_code)
                Join Vaccines vc on vl.vaccine_id = vc.vaccine_id
                        
ORDER BY Country ASC;

-----------------------------------------------------------------------------------------

/*Query 4*/
SELECT sourcename||" ( "||sourcewebsite ||" )" AS 'Source Name(URL)',
        SUM(Total_vaccines_administered) AS 'Total Vaccines Administered'
FROM (
        SELECT s.source_name AS sourcename, s.source_website AS sourcewebsite, v.iso_code,
            MAX (IIF (v.total_vaccinations != "",v.total_vaccinations, NULL) ) AS Total_vaccines_administered
            FROM Vaccinations v LEFT JOIN Source s ON v.iso_code = s.iso_code
            WHERE s.source_name NOT NULL
            GROUP BY v.iso_code
                )
GROUP BY sourcewebsite
ORDER BY sourcename ASC;


-----------------------------------------------------------------------------------------
/*Query 5*/

SELECT CountryDailyVaccination.date As Date ,

    MAX (IIF( CountryDailyVaccination.iso_code IN 
    (
        SELECT iso_code
        FROM Location 
        WHERE lower(location) LIKE 'australia'
        ),CountryDailyVaccination.people_fully_vaccinated,0)) AS 'Australia',
        
    MAX (IIF( CountryDailyVaccination.iso_code IN 
    (
        SELECT iso_code
        FROM Location
        WHERE lower(location) LIKE 'united states'
    ), CountryDailyVaccination.people_fully_vaccinated, 0)) AS 'United States',
    
    MAX (IIF( CountryDailyVaccination.iso_code IN 
    (
        SELECT iso_code
        FROM Location
        WHERE lower(location) LIKE 'germany'
    ), CountryDailyVaccination.people_fully_vaccinated,0)) AS 'Germany',
    
    MAX (IIF( CountryDailyVaccination.iso_code IN
    (
        SELECT iso_code
        FROM Location
        WHERE lower(location) LIKE 'italy'
    ),CountryDailyVaccination.people_fully_vaccinated, 0)) AS 'Italy'

FROM CountryDailyVaccination  
WHERE CountryDailyVaccination.date LIKE '%2022%'
GROUP BY CountryDailyVaccination.date
ORDER BY CountryDailyVaccination.date ASC;

