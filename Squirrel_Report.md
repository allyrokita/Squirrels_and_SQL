<h1 style="text-align: center;">
A Geospatial Examination of Squirrel Behavior in PostgreSQL
</h1>
<h2 style="text-align: center;">
Or Why Squirrels are the Best
  </h2>
  
 <img src="https://user-images.githubusercontent.com/128807596/227682101-0a9af0d3-e314-4ca7-981b-5a97c610b757.png"  width="400" height="550"> <img src="https://s1.dmcdn.net/v/BK6E-1Rmzb6KTOiUF/x1080"  width="540" height="550">

"Margins decorated with border of foliate ornament and bunches of twigs, and inhabited by squirrel, wearing collar with lead attached to 
ring on block on which the squirrel is seated, and by fantastic bird." 

<h2>
Milestone 1: The OG ERD
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
  </details>

<details>
   <summary>
  New York City Parks Table
  </summary>
  </details>
  
  <details>
   <summary>
  Squirrel Data Table
  </summary>
  Testing testing do I work?
  </details>
  
  <details>
   <summary>
  Squirrel Sightings Table
  </summary>
  </details>
 
 <h2 style="text-align: center;">
Milestone 2: Normalization
  </h2>
  
  ![normalsqrls](https://user-images.githubusercontent.com/128807596/227696480-e0c1d53c-51d9-40b8-ab41-5d5f6e1d27a7.jpeg)

  <details>
   <summary>
  Boroughs Table
  </summary>
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
  </details>
  
 <details>
   <summary>
  Squirrel Data Table
  </summary>
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
