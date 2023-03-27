<h1 style="text-align: center;">
A Geospatial Examination of Squirrel Behavior in PostgreSQL
</h1>
  
 <img src="https://user-images.githubusercontent.com/128807596/227682101-0a9af0d3-e314-4ca7-981b-5a97c610b757.png"  width="400" height="550"> <img src="https://s1.dmcdn.net/v/BK6E-1Rmzb6KTOiUF/x1080"  width="540" height="550">

"Margins decorated with border of foliate ornament and bunches of twigs, and inhabited by squirrel, wearing collar with lead attached to 
ring on block on which the squirrel is seated, and by fantastic bird." 

<h2>
Milestone 1: The Data
  </h2>
<details> 
<summary> Summary of Relations </summary>
  
   ![nonnormal_sqrls](https://user-images.githubusercontent.com/128807596/227696298-2d604427-2e74-406a-a6fb-908a03449831.jpeg)
  
  </h2>
  
  </summary>
  
</details>

<details>
   <summary>
  Park Data Table
  </summary>
	
Park Data is a non-geocoded dataset articulates the state in which the parks were in when observing the squirrels. It contains the
	area name (e.i Upper Manhattan, Lower Manhattan) as well as the area’s ID. Next, it details the parks’ names and a park ID that
	appears to have no relation to official Geo-IDs. The date, start_time, end_time, and total_time columns refer to the date, times, 
	and length in which the observers were looking for squirrels. The park_conditions column denote how busy the park was.
	Other_animal_sightings, litter, and temp_and_weather, expands upon the park conditions. The final three columns tell how many
	squirrels were spotted during that sighting, as well as the number of sighters. This is polygon data.This dataset came from New 
	York City’s Department of Data (https://www.thesquirrelcensus.com/ ). The research team consisted of many nameless volunteers. The
	dataset is from March 2020.

  </details>

<details>
   <summary>
  New York City Parks Table
  </summary>

The final table centers on all parks in New York City.This geocoded polygon dataset contains information pertaining to all of the parks in
	New York City. This contains primarily political information including the parks’ senate_nys [Senate district(?)], councils, and
	Congressional districts. There is also a column dedicated to whether or not the park borders a waterfront, which may affect squirrel
	population. This dataset will primarily be used as a means of joining parks_data to geographic information. This data came from New
	York City’s OpenData (https://data.cityofnewyork.us/City-Government/ARCHIVED-Parks-Properties/k2ya-ucmv ) . It was published by the
	Department of Parks and Recreation in the year 2020. 

  </details>
  
  <details>
   <summary>
  Squirrel Data Table
  </summary>
Squirrel Data is a 16-columned table is similar to the above table in its observations of squirrels. It is less normalized, as many
	of the cells contain multiple pieces of information including a list of squirrel activities instead of the TRUE/FALSE style 
	of Squirrel Sightings. The geometry of this dataset is points. The temporal component of this data collection is unknown, but 
	the geographic diversity (the data spans across many parks in New York City) make it a valuable dataset. The data hails from 
	New York City’s Department of Data via (https://www.thesquirrelcensus.com/ ). It was created with data compiled primarily from
	March 2020 via the Squirrel Census Phone Tree across 24 parks. The research team consisted of many nameless volunteers. 

  </details>
  
  <details>
   <summary>
  Squirrel Sightings Table
  </summary>
	
Squirrel Sightings contains the  number of squirrels observed primarily in Central Park, New York City throughout October 2018. 
	It has about 31 rows. One cohort of rows pertains to the geographic whereabouts of the squirrels. Another section is dedicated
	to the appearance of the squirrels. The other primary grouping of interest centers on the boolean actions of the squirrels 
	including how they interact with humans (run away, indifferent, or approaches) and, delightfully, the sorts of communication 
	they exhibit (kuks, quaas, tail flags, ect.). These behaviors in relation to the parks’ conditions are of particular interest 
	for this project. The geometry of this data set is points. The data originates from New York City’s Department of Data
	(https://www.thesquirrelcensus.com/ ).

  </details>
 
 <h2 style="text-align: center;">
Milestone 2: Normalization
  </h2>
  
  ![normalsqrls](https://user-images.githubusercontent.com/128807596/227696480-e0c1d53c-51d9-40b8-ab41-5d5f6e1d27a7.jpeg)

  <details>
   <summary>
  Animals Table
  </summary>
  </details>

  <details>
   <summary>
  Areas Table
  </summary>
	
	~~~~postgresql
	
	create table if not exists areas(
	"area_id" character(1),
	"name" character varying(40),
	primary key("area_id"));

	insert into areas(
		area_id,
		name)
		select distinct area_id, 
		area_name
		from  park_data;
	
	~~~~
  </details>

  <details>
   <summary>
  Boroughs Table
  </summary>
	
	~~~~postgresql
	
	create table boroughs(
		borough_id character varying(6),
		primary key("borough_id"));
	
	insert into boroughs(borough_id)
		select distinct borough from nyc_parks1;
	
	~~~~
  </details>

  <details>
   <summary>
  Classes Table
  </summary>
	
	~~~~postgresql
	
	CREATE TABLE "classes" (
		"id" serial,
	  	"class" character varying(30),
	  	PRIMARY KEY ("id")
	 );

	INSERT INTO classes(class)
		SELECT DISTINCT class 
		FROM nyc_parks1;
	
	~~~~
	
  </details>

  <details>
   <summary>
  Conditions Park Table
    
  </summary>
  
       ~~~~postgresql

         create table conditions(
              "condition_id" character(1),
               "name" character varying(10),
              primary key("condition_id")
      );
        insert into conditions(
           name, 
          condition_id)
        select
          distinct split_part(split_part(park_condition,'-',1),',',1),
          case
            when park_condition ~'Calm' then '1'
            when park_condition ~ 'Medium' then '2'
            when park_condition ~'Busy' then '3'
            else '0'
          end as honeydew
        from park_data
        where park_condition is not null
        order by
          honeydew;

        DELETE FROM conditions WHERE condition_id = '0'; --verified 3.26.23
     ~~~~
  
</details>

  <details>
   <summary>
  Departments Table
  </summary>
	
	~~~~postgresql
	
	create table departments(
		"id" serial,
		"name" character varying(10),
		primary key("id"));

	insert into departments(name)
		select distinct department from nyc_parks1;
	
	~~~~
	
  </details>

<details>
   <summary>
  Squirrel Data Table
  </summary>
</details>

<details>
   <summary>
  New York City Parks Table
  </summary>
</details>

 <details>
   <summary>
  Litter Data Table
  </summary>
  
  ~~~~ postgresql
  -- Creating table
  create table litter(
"litter_id" character(1),
"name" character varying(10),
primary key("litter_id")
);
  
insert into litter(name, 
	litter_id)
select
	distinct split_part(litter, ',',1), -- spliting qualitative data into categorical qualitative data
	case
		when park_data.litter ~'None' then '1'
		when park_data.litter ~ 'Some' then '2'
		when park_data.litter ~'Abundant' then '3'
		else '0'
	end as pineapple
from park_data
where park_data.litter is not null
order by
	pineapple;
  
  ~~~~
  
  </details>
  
   <details> 
   <summary>
  Outings Data Table
  </summary>
  
  
  </details>
  
 <details>
   <summary>
  Permits Data Table
  </summary>

  ~~~~postgresql
  --Create the table
  CREATE TABLE "permits" (
  "permit_id" SERIAL,
  "permit" boolean,
  "district" character varying(20),
  "parent" character varying(20),
  PRIMARY KEY ("permit_id")
);
 -- Insert data into table
insert into permits (
	permit,
	district,
	parent)
select 
		case
			when permit = 'Y' then 1 :: boolean --convert into boolean
			when permit = 'N' then 0 :: boolean
		end,
	permitdist,
	permitpare
from nyc_parks1;
  ~~~~
  
  </details>
  
  <details>
   <summary>
  Sighters Table   
  </summary>
	
	~~~~postgresql
	
	create table if not exists "sighters"(
		"sighter_id" character(2),
		primary key ("sighter_id")
		);
	
	insert into sighters
	select distinct ltrim(unnest(string_to_array(squirrel_sighter ,',')))
	from park_data
	where squirrel_sighter is not null;
	
	~~~~
	
  </details>
  
 <details>
   <summary>
  Squirrel Data Table
  </summary>
  </details>
  
   <details>
   <summary>
  Subcategories Table
  </summary>
	
	~~~~postgresql
	
	create table subcategories(
	"id" SERIAL,
	"name" character varying (254),
	primary key("id"));
	
	~~~~
	
  </details>
  
  
   <details>
   <summary>
  Type Categories Table
  </summary>
	
	~~~~postgresql
	
	create table subcategories(
	"id" SERIAL,
	"name" character varying (254),
	primary key("id"));

	INSERT INTO subcategories (name)
	SELECT distinct subcategor
	FROM nyc_parks1;
	
	~~~~
	
  </details>
  
  
 <h2 style="text-align: center;">
Milestone 3: The Script
  
  ![03-complete_works_300x300-1](https://user-images.githubusercontent.com/128807596/227696099-a3556597-c5af-4a71-802c-5c44405ac3bb.jpg)


  
<h2 style="text-align: center;">
Milestone 4: Optimization
  </h2>
 
<h2 style="text-align: center;">
Milestone 5: Discussion
  </h2>
 
  <img src="{![image]([
](https://phineasandferb.fandom.com/wiki/S.I.M.P._(Squirrels_In_My_Pants)?file=S.I.M.P.jpg))
}" alt="Alternate Text" />
</a>

<details>
<summary>My top languages</summary>

| Rank | Languages |
|-----:|-----------|
|     1| Python    |
|     2| SQL       |
|     3| R         |

</details>

<details>
<summary> List of Relations Test </summary>
 
| Rank | Languages |
|-----:|-----------|
|     1| Python    |
|     2| SQL       |
|     3| R         |
</details>

<details>
<summary>Data Used </summary>
 
 Schema |        Name         | Type  | Description  |
-------:|---------------------|-------|--------------|
 public | animals             | table |              |
 public | areas               | table |              |
 public | nyc_parks           | table |              |
 public | nyc_parks1          | table |              |
 public | outings             | table |              |
 public | park_data           | table |              |
 public | sighter_groups      | table |              |
 public | spatial_ref_sys     | table |              |
 public | squdata             | table |              |
 public | squirrel_data       | table |              |
 public | squirrel_sightings  | table |              |
 public | squirrel_sightings1 | table |              |
 
    <details>
      <summary> Outings </summary>
      
  </details>
</details>


<table border="0">
 <tr>
    <td><b style="font-size:30px">Title</b></td>
    <td><b style="font-size:30px">Title 2</b></td>
 </tr>
 <tr>
    <td>Lorem ipsum ...</td>
    <td>Lorem ipsum ...</td>
 </tr>
</table>
