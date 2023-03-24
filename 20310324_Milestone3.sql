-- Creating Fact Tables
	--- squirrel_sightings
		--ages
		-- colors
		--shifts
	
	---outings
drop table outings ;
CREATE table if not EXISTS "outings" (
  "outing_id" SERIAL,
  "date" date,
  "start_time" time,
  "end_time" time,
  "park_id" character varying(15),
  "area_id" character(1),
  "condition_id" integer,
  "condition_desc" character varying(250),
  "litter_id" integer,
  "litter_desc" character varying(250),
  "weather_id" integer,
  "weather_desc" character varying(250),
  "temp_id" integer,
  "group_id" character varying(3),
  PRIMARY KEY ("outing_id")
);


  

insert into outings (
date,
area_id,
park_id,
start_time, 
end_time,
condition_desc,
litter_desc,
weather_desc)
select date,
	area_id, 
	park_id,
	start_time :: TIME,
	end_time :: TIME,
	park_condition,
	litter,
	temp_and_weather
from park_data;

--confirming that table is populated with data from park_data
select * from outings limit 5;


--OUTINGS FACT TABLE: animals
create table animals(
 "animal_id" SERIAL,
 "name" character varying  (100));

insert into animals(name)
select distinct other_animal_sighting
from park_data;

select * from animals;
-- Oh no! Animals is still not normalized! Let's start 
--the 1NF process!!!
	select
		unnest(string_to_array(distinct_animals.n1, '(')) as n2
	FROM	
		(select distinct n1
			FROM 
				(SELECT animals.animal_id, 
				unnest(string_to_array(animals.name, ', ')) as n1 
				FROM animals) as split_animals) as distinct_animals;

delete n2 
from distinct_animals
where n2 like '%)%'; --"fuck you" in ice mephit voice

		-- outing_animal_relations table
		--parks
--OUTINGS FACT TABLE: Areas
create table if not exists areas(
	"area_id" character(1),
	"name" character varying(40),
	primary key("area_id")
);

insert into areas(
	area_id,
	name)
	select distinct area_id, 
	area_name
	from  park_data;
-- The litter table is already normalized, as it, so we can move on to the next 
-- demension table!!!!
		--conditions
		--litter
		--weather
		--temperature
			-- convert F to C
			-- convert C to K for kicks
		--groups
		CREATE table if not EXISTS "sighter_groups" (
		  "group_id" character varying(3),
		  "sighter_id" character varying(3),
		  PRIMARY KEY ("group_id")
		);
		
	---nyc_parks
CREATE table if not EXISTS "nyc_parks1" (
  "fid" integer,
  "shape" character varying(7),
  "acquisition" date,
  "acres" numeric,
  "address" character varying(100),
  "borough" character varying(1),
  "class" character(4),
  "commission" date,
  "department" character varying(10),
  "gisobjid" character varying(10),
  "gispropnum" character varying(15),
  "global_id" text,
  "jurisdiction" character varying(50),
  "location" text,
  "mapped" boolean,
  "named311" text,
  "objectid" integer,
  "pip_ratabl" boolean,
  "precinct" integer,
  "retired" boolean,
  "url" text,
  "us_congress" integer,
  "waterfront" boolean,
  "permit_id" integer,
  PRIMARY KEY ("gispropnum")
);


		--boroughs
		--classes
		--departments
		--zipcodes
		--juisdictions
		--permits