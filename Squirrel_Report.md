<h1 style="text-align: center;">
A Geospatial Examination of Squirrel Behavior in PostgreSQL
</h1>
  
 <img src="https://user-images.githubusercontent.com/128807596/227682101-0a9af0d3-e314-4ca7-981b-5a97c610b757.png"  width="400" height="550"> <img src="https://s1.dmcdn.net/v/BK6E-1Rmzb6KTOiUF/x1080"  width="540" height="550">

Squirrels have been a fascination to the human race for generations. It has inspired masterpieces ranging from this 15th century Dutch Catholic painting of a squirrel “wearing collar with lead attached to ring on block on which the squirrel is seated, and by fantastic bird,” to contemporary works such as Disney’s Squirrels in my Pants music video. 

Squirrels and their quirky tendencies have brought much unadulterated joy to people. They have also evoked pathos through their struggles, poetically articulated by an anonymous squirrel enthusiast:

>I saw the oldest and noblest struggle of all living things all that live in a caste system, a hierarchy, a food chain äóî the rage of the oppressed majority backed into a corner by their tyrannical overlords. Two trees, two humble villages, two legions of squirrels, unwilling to yield to the fearsome, pompous hawk. Some stayed in the safety of the trunk, screaming warning and encouragement to those who, fed up with the order of the world and drawing their proverbial line in the sand, led creeping assaults on their antagonizer. One by one, they scuttled ever closer, tempting fate and their reflexes, some waiting until the raptor flashed its talons before scampering back out of reach. They came from the trunk. They came from the outer branches. They clung, upside down, inches from its head, as if re-enacting a scene from "Mission: Impossible" they were misremembering. Can you blame them?

Thus, when  the Squirrel Census was conducted in New York City parks in 2018 and 2020, a beautiful albeit chaotic dataset was compiled. 

<h2>
Milestone 1: The Data
  </h2>
<details> 
	<summary> <h3> Summary of Relations </h3> </summary>
  
   ![nonnormal_sqrls](https://user-images.githubusercontent.com/128807596/227696298-2d604427-2e74-406a-a6fb-908a03449831.jpeg)
  
  </h2>
  
  </summary>
  
</details>

<details>
   <summary>
	   Park Data Table
  </summary>
	
	     area_name     | area_id |                  park_name                   | park_id | start_time |  end_time  | total_time |                          park_condition                          |                           other_animal_sighting                            |                              litter                               |          temp_and_weather          | squirrel_count | squirrel_sighter | sighter_count |    date
	-------------------|---------|----------------------------------------------|---------|------------|------------|------------|------------------------------------------------------------------|----------------------------------------------------------------------------|-------------------------------------------------------------------|------------------------------------|----------------|------------------|---------------|------------
	 UPPER MANHATTAN   | A       | Fort Tryon Park                              |       1 | 3:14:00 PM | 4:05:00 PM |         51 | Busy                                                             | Humans, Dogs, Pigeons, Cardinals                                           | Some                                                              | 43 degrees, sunny                  |             12 | 01, 02, 03, 04   |             4 | 2020-03-01
	 UPPER MANHATTAN   | A       | J. Hood Wright Park                          |       2 | 3:30:00 PM | 4:00:00 PM |         30 | Calm                                                             | Humans, Hawks, Dogs, Pigeons, Rat                                          | Some, in trees                                                    | cold, clear                        |             24 | 05, 06           |             2 | 2020-03-01
	 UPPER MANHATTAN   | A       | Highbridge Park                              |       3 | 3:21:00 PM | 4:15:00 PM |         54 | Calm, pick-up baseball game                                      | Humans, Dogs (3, all on leashes), Downy Woodpecker (2), Robins, Song Birds | Some, especially caught in wooded area in East, balloons in trees | 43 degrees                         |             16 | 07, 08, 09       |             3 | 2020-03-01
	 UPPER MANHATTAN   | A       | St. Nicholas Park                            |       4 | 3:15:00 PM | 3:45:00 PM |         30 | Calm                                                             | Humans, Dogs                                                               | Some, backside of park                                            | 43 degrees, clear                  |             15 | 10, 11, 12       |             3 | 2020-03-01
	 UPPER MANHATTAN   | A       | Riverside Park (section near Grant Memorial) |       5 | 3:15:00 PM | 3:45:00 PM |         30 | Calm                                                             | Humans, Dogs                                                               |                                                                   |                                    |             28 | 13, 14, 15       |             3 | 2020-03-01
	 UPPER MANHATTAN   | A       | Marcus Garvey Park                           |       6 | 3:45:00 PM | 4:15:00 PM |         30 | Calm, re: humans, but a hawk is certainly not a calming presence | Hawks, Dogs, Pigeons                                                       | Abundant                                                          | 42 degrees, clear                  |             34 | 16               |             1 | 2020-03-01
	 CENTRAL MANHATTAN | B       | Madison Square Park                          |       7 | 2:30:00 PM | 3:50:00 PM |         80 | Busy                                                             | Humans, Dogs, Pigeons                                                      |                                                                   | 43 degrees, sunny                  |             11 | 17, 18, 19, 20   |             4 | 2020-03-01
	 CENTRAL MANHATTAN | B       | Union Square Park                            |       8 | 3:15:00 PM | 3:45:00 PM |         30 | Busy                                                             | Humans, Dogs, Pigeons                                                      |                                                                   | 40 degrees, sunny                  |             16 | 21, 22, 23, 24   |             4 | 2020-03-01
	 CENTRAL MANHATTAN | B       | Stuyvesant Square Park                       |       9 | 3:00:00 PM | 4:00:00 PM |         60 | Calm, 20èùû30 ppl on each side                                   | Humans, Dogs, Sparrows                                                     | Some                                                              | 45 degrees, sunny                  |             25 | 25, 26           |             2 | 2020-03-01
	 CENTRAL MANHATTAN | B       | Washington Square Park                       |      10 | 3:20:00 PM | 4:00:00 PM |         40 | Busy                                                             | Humans, Dogs                                                               | None                                                              | 45 degrees, sunny with shade spots |             51 | 27, 28           |             2 | 2020-03-01

	
	
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
	
 gid |      acquisitio      |               acres               |        address        | borough | class |      commission      | communityb | councildis | department |               eapply                |             gisobjid              | gispropnum |               global_id                | jurisdicti |                           location                            | mapped |             name311             | nys_assemb | nys_senate |             objectid              | omppropid | parentid | permit | permitdist | permitpare | pip_ratabl | precinct | retired |            signname             |         subcategor         |         typecatego          |                   url                   | us_congres | waterfront | zipcode |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         geom                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
-----|----------------------|-----------------------------------|-----------------------|---------|-------|----------------------|------------|------------|------------|-------------------------------------|-----------------------------------|------------|----------------------------------------|------------|---------------------------------------------------------------|--------|---------------------------------|------------|------------|-----------------------------------|-----------|----------|--------|------------|------------|------------|----------|---------|---------------------------------|----------------------------|-----------------------------|-----------------------------------------|------------|------------|---------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   1 | 19990222000000.00000 | 20.907000000000000000000000000000 |                       | R       | PARK  | 20100106000000.00000 | 503        | 51         | R-03       | Seaside Wildlife Nature Park        | 100005021.00000000000000000000000 | R145       | {EC14E5C9-9687-49BC-9A7A-77F977DC0448} | DPR        | Nelson Ave., Tennyson Dr. and Bulkhead Line                   | True   | Seaside Wildlife Nature Park    | 64         | 24         | 6367.0000000000000000000000000000 | R145      | R-03     | Y      | R-03       | R-03       | Yes        | 122      | False   | Seaside Wildlife Nature Park    | Neighborhood Park          | Neighborhood Park           | http://www.nycgovparks.org/parks/R145/  | 11         | Yes        | 10308   | 0106000000020000000103000000010000001E00000020BB0B011B8952C09B3CE9AE6645444054E65C81198952C0A2041A896445444014B2B64D198952C0BE2C07DD64454440CDBBBB1D088952C0A1EBD73B4C454440C851898E088952C03D138D844B4544403481AC9D078952C052E704F64545444055219A7AF98852C0358C0A603345444025E96FDEFD8852C00F4085640C454440059E5A1FFA8852C02AC9CD43F64444403DB1EDEBFE8852C0E868FF9AD94444404F3917FA1D8952C05CF0067F0245444052D7AFDB278952C042EF12E711454440A2053D1F298952C01FE4EE03104544403E5BC4872C8952C09DC06854154544409F2EDAA02C8952C0A44F3F472845444095D39C932C8952C05AC64C9A2C454440C3087B602C8952C07ACCC7EA30454440B9AD98072C8952C05C9BAE353545444020FB32892B8952C0E86BFD7739454440850FA3E52A8952C09AFEBBAE3D4544401C655B1D2A8952C0D3CFF7D641454440E38DE630298952C0DD07C6ED454544406348EC20288952C014234DF049454440779E28EE268952C0743BBDDB4D4544405B3E7299258952C0F0AF59AD51454440EB35B923248952C04D36776255454440479C008E228952C050DF7BF858454440F52E66D9208952C054CEE66C5C454440177219071F8952C0FE4F4EBD5F45444020BB0B011B8952C09B3CE9AE664544400103000000010000000A000000E7048C3D318952C06A2E1FB12845444053380085318952C0F5E137381D45444010999917348952C08D77C54921454440A5878589378952C0DBC878BC2645444084A4B0C6348952C00B6593E32A4544402DAFE91C358952C0DBB879742B454440861F5A19328952C05ACE4BC22F4544405EC06B03318952C0CF2FE5192E4544406DA39326318952C0A0F519662B454440E7048C3D318952C06A2E1FB128454440
   2 | 19530514000000.00000 | 0.0610000000000000000000000000000 |                       | Q       | PARK  | 20090423000000.00000 | 401        | 22         | Q-01       | Strippoli Square                    | 100000375.00000000000000000000000 | Q355       | {62700020-4840-4F4A-A15A-7D65B9A6A794} | DPR        | 31 Ave., 51 St., 54 St.                                       | True   | Strippoli Square                | 30         | 12         | 5916.0000000000000000000000000000 | Q355      | Q-01     | Y      | Q-01       | Q-01       | Yes        | 114      | False   | Strippoli Square                | Sitting Area/Triangle/Mall | Triangle/Plaza              | http://www.nycgovparks.org/parks/Q355/  | 14         | No         | 11377   | 010600000001000000010300000001000000050000003A4E583E147A52C0F972574CE8604440810D706C177A52C0C64020BAE76044404E1E58AC157A52C091A2C10EF160444036735424157A52C0E1D5CD2DF16044403A4E583E147A52C0F972574CE8604440
   3 | 19400528000000.00000 | 1.1300000000000000000000000000000 | 150 34 STREET         | B       | PARK  | 20100106000000.00000 | 307        | 38         | B-07       | D'Eemic Playground                  | 100004733.00000000000000000000000 | B210B      | {BFD91324-49C1-46B5-B3E9-E43A989DC40B} | DPR        | 3 Ave. bet. 35 St. and 34 St.                                 | True   | D'Emic Playground               | 51         | 25         | 5465.0000000000000000000000000000 | B210B     | B-07     | Y      | B-07       | B-07       | Yes        | 72       | False   | D'Emic Playground               | Neighborhood Plgd          | Playground                  | http://www.nycgovparks.org/parks/B210B/ | 7          | No         | 11232   | 01060000000100000001030000000100000007000000D5B71BAF4C8052C0B95A3A92F2534440CB86F89C508052C0B75A6428EB53444087D285D45A8052C060EA5F80F75344405BCA5836538052C0C5EFBB01065444409D0CB838468052C0583B544DF6534440A3E30EF3498052C0A190BB44EF534440D5B71BAF4C8052C0B95A3A92F2534440
   4 | 20100517000000.00000 | 2.1600000000000000000000000000000 | 201/125 BOLTON AVENUE | X       | PARK  | 20100106000000.00000 | 209        | 18         | X-09       | Harding Park                        | 100004033.00000000000000000000000 | X262       | {BDFFC8B5-573A-4771-8E51-601D03705C78} | DPR        | Bolton Ave. bet. O'Brien Ave. and G St.                       | False  | Harding Park                    | 85         | 34         | 4857.0000000000000000000000000000 | X262      | X-09     | Y      | X-09       | X-09       | Yes        | 43       | False   | Harding Park                    | Neighborhood Plgd          | Neighborhood Park           | http://www.nycgovparks.org/parks/X262/  | 15         | No         | 10473   | 010600000002000000010300000001000000070000005C0C553CCF7652C06ED2DF5B95674440294D0A20D57652C0F8A219DF936744403553CD0BDA7652C0F755869EBD674440976C42C1D97652C01C1D19B3BD674440CCFEACD6DA7652C0AF0B98E4C667444003646065D57652C0CCDE9348C96744405C0C553CCF7652C06ED2DF5B95674440010300000001000000060000000B02A90BCA7652C001010542656744407A278CBECF7652C0D040B5B26367444008BA74C7D37652C0307FFA8F866744401F238C55D27652C0E1C82D9988674440CAFDA543CE7652C011EF5BB6896744400B02A90BCA7652C00101054265674440
   5 | 19550427000000.00000 | 1.1040000000000000000000000000000 | 4522 CARPENTER AVENUE | X       | PARK  | 20100106000000.00000 | 212        | 11         | X-12       | Wakefield Playground                | 100004702.00000000000000000000000 | X188       | {E33C24CE-ACEB-4018-BAF0-3CE447C8A2AF} | DPR/DOE    | Matilda Ave. to Carpenter Ave. bet. E. 239 St. and E. 240 St. | False  | Wakefield Playground            | 81         | 36         | 6621.0000000000000000000000000000 | X188      | X-12     | Y      | X-12       | X-12       | Yes        | 47       | False   | Wakefield Playground            | JOP                        | Jointly Operated Playground | http://www.nycgovparks.org/parks/X188/  | 16         | No         | 10470   | 0106000000020000000103000000010000000A0000006A82F17AAA7652C0AFF24C9F70734440E69E2BE0B07652C07F41ADB160734440F5FF4323B17652C008293E04617344402222891EB17652C0CCB2A00061734440B42BE288B57652C0737683976673444041657A9EB67652C0924470E367734440530ADE04BA7652C05CFB2CF46B7344402084E540BA7652C03BAEF13B6C734440148FD4BFB47652C0A67863F8797344406A82F17AAA7652C0AFF24C9F7073444001030000000100000005000000126A13C5A27652C0C2FE43D383734440B4CD448CA57652C0B17F07E87C73444046363CC1AA7652C0747D015281734440152DF7E9A77652C096FE0C8288734440126A13C5A27652C0C2FE43D383734440
(5 rows)
	
	
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
	March 2020 via the Squirrel Census Phone Tree across 24 parks. The research team consisted of many nameless volunteers. Throughout the script, it shall be 	referred to as squadata. 

  </details>
  
  <details>
   <summary>
  Squirrel Sightings Table
  </summary>
	
 gid |       x        |       y       |   unique_squ   | hectare | shift |   date   |     hectare_sq      |  age  | primary_fu | highlight_ |   combinatio   |                                      color_note                                       |   location   | above_grou |  specific_l   | running | chasing | climbing | eating | foraging | other_acti | kuks | quaas | moans | tail_flags | tail_twitc | approaches | indifferen | runs_from | other_inte |                    geom                 
-----|----------------|---------------|----------------|---------|-------|----------|---------------------|-------|------------|------------|----------------|---------------------------------------------------------------------------------------|--------------|------------|---------------|---------|---------|----------|--------|----------|------------|------|-------|-------|------------|------------|------------|------------|-----------|------------|--------------------------------------------
   1 | -73.9561344938 | 40.7940823884 | 37F-PM-1014-03 | 37F     | PM    | 10142018 | 3.00000000000000000 |       |            |            | +              |                                                                                       |              |            |               |       0 |       0 |        0 |      0 |        0 |            |    0 |     0 |     0 |          0 |          0 |          0 |          0 |         0 |            | 0101000000E258BB4E317D52C0B245E07DA4654440
   2 | -73.9688574691 | 40.7837825208 | 21B-AM-1019-04 | 21B     | AM    | 10192018 | 4.00000000000000000 |       |            |            | +              |                                                                                       |              |            |               |       0 |       0 |        0 |      0 |        0 |            |    0 |     0 |     0 |          0 |          0 |          0 |          0 |         0 |            | 01010000001314C2C2017E52C0001A53FC52644440
   3 | -73.9742811485 | 40.7755336191 | 11B-PM-1014-08 | 11B     | PM    | 10142018 | 8.00000000000000000 |       | Gray       |            | Gray+          |                                                                                       | Above Ground | 10         |               |       0 |       1 |        0 |      0 |        0 |            |    0 |     0 |     0 |          0 |          0 |          0 |          0 |         0 |            | 01010000009D76519F5A7E52C07B7485AF44634440
   4 | -73.9596413904 | 40.7903128889 | 32E-PM-1017-14 | 32E     | PM    | 10172018 |       14.0000000000 | Adult | Gray       |            | Gray+          | Nothing selected as Primary. Gray selected as Highlights. Made executive adjustments. |              |            |               |       0 |       0 |        0 |      1 |        1 |            |    0 |     0 |     0 |          0 |          0 |          0 |          0 |         1 |            | 01010000008DE8B8C36A7D52C0FEB805F928654440
   5 | -73.9702676473 | 40.7762126855 | 13E-AM-1017-05 | 13E     | AM    | 10172018 | 5.00000000000000000 | Adult | Gray       | Cinnamon   | Gray+Cinnamon  |                                                                                       | Above Ground |            | on tree stump |       0 |       0 |        0 |      0 |        1 |            |    0 |     0 |     0 |          0 |          0 |          0 |          0 |         0 |            | 0101000000AA5679DD187E52C06A75F1EF5A634440
   6 | -73.9683613516 | 40.7725908847 | 11H-AM-1010-03 | 11H     | AM    | 10102018 | 3.00000000000000000 | Adult | Cinnamon   | White      | Cinnamon+White |                                                                                       |              |            |               |       0 |       0 |        0 |      0 |        1 |            |    0 |     0 |     0 |          0 |          1 |          0 |          1 |         0 |            | 010100000075FBE3A1F97D52C022981342E4624440
   7 | -73.9541201790 | 40.7931811701 | 36H-AM-1010-02 | 36H     | AM    | 10102018 | 2.00000000000000000 | Adult | Gray       |            | Gray+          | just outside hectare                                                                  | Ground Plane | FALSE      |               |       0 |       0 |        0 |      0 |        1 |            |    0 |     0 |     0 |          0 |          0 |          0 |          0 |         0 |            | 0101000000EB4A154E107D52C078B5E8F586654440
   8 | -73.9582694312 | 40.7917367820 | 33F-AM-1008-02 | 33F     | AM    | 10082018 | 2.00000000000000000 | Adult | Gray       |            | Gray+          |                                                                                       | Ground Plane | FALSE      |               |       0 |       0 |        0 |      0 |        1 |            |    0 |     0 |     0 |          0 |          0 |          0 |          1 |         0 |            | 01010000009EF84E49547D52C07FEB80A157654440
   9 | -73.9674285955 | 40.7829723920 | 21C-PM-1006-01 | 21C     | PM    | 10062018 | 1.00000000000000000 | Adult | Gray       |            | Gray+          |                                                                                       | Ground Plane | FALSE      |               |       0 |       0 |        0 |      0 |        0 |            |    0 |     0 |     0 |          1 |          1 |          0 |          0 |         0 |            | 0101000000DEC0A059EA7D52C0B899787038644440
  10 | -73.9722500197 | 40.7742879599 | 11D-AM-1010-03 | 11D     | AM    | 10102018 | 3.00000000000000000 | Adult | Gray       | Cinnamon   | Gray+Cinnamon  |                                                                                       | Above Ground | 30         |               |       0 |       0 |        1 |      0 |        0 | grooming   |    0 |     0 |     0 |          0 |          0 |          0 |          1 |         0 |            | 01010000001C852558397E52C0EFBB2CDE1B634440

	
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
  
   ![Copy of Open Source Shakespeare ERD - Page 3](https://user-images.githubusercontent.com/128807596/229255637-4336c68c-273b-4332-87de-606363a52ecd.jpeg)
  
  ![Copy of Open Source Shakespeare ERD - Copy of Copy of Normalization_Draft1 (1)](https://user-images.githubusercontent.com/128807596/229326813-6236a5fa-49ca-428a-96cd-49720388ae0d.jpeg)

  

  <details>
   <summary>
	   <h3> The Entire Normalization Script </h3>
  </summary>
  </details>

  <details>
   <summary>
  Ages Table
  </summary>
	
	~~~~postgresql
	CREATE TABLE "ages" (
		"id" serial,
		"age" character varying(10),
		PRIMARY KEY ("id")
		);
	
	INSERT INTO ages(age) 
	SELECT DISTINCT age 
	FROM squirrel_sightings1 
	WHERE age is not null;
	
	SELECT * FROM ages;
	
	~~~~
	
 id |   age
----|----------
  1 | ?
  2 | Adult
  3 | Juvenile
	
	
  </details>

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
	SELECT * FROM areas;
	~~~~
	


 area_id |       name
---------|-------------------
 A       | UPPER MANHATTAN
 D       | BROOKLYN
 B       | CENTRAL MANHATTAN
 C       | LOWER MANHATTAN
	
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
  Colors Table
  </summary>
	
	~~~~postgresql
	
	  CREATE TABLE "colors" (
			"id" serial,
			"color" character varying(10),
			PRIMARY KEY ("id")
 			);
	
	INSERT INTO colors(color) 
	SELECT DISTINCT primary_fu 
	FROM squirrel_sightings1 
	WHERE primary_fu IS NOT NULL;

	SELECT * FROM colors;
	
	~~~~
	
 id |  color
----|----------
  1 | Gray
  2 | Black
  3 | Cinnamon
	
	
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
  Jurisdiction Table
  </summary>
	
	~~~~postgresql
	
	CREATE TABLE "jurisdictions" (
  		"id" serial,
  		"name" character varying(20),
  		PRIMARY KEY ("id")
		);


	
	INSERT INTO jurisdictions(name)
	SELECT DISTINCT SPLIT_PART(UPPER(UNNEST((STRING_TO_ARRAY(jurisdicti  ,'/')))), ',',1)
	FROM nyc_parks1
	WHERE jurisdicti NOT LIKE '%?%' AND jurisdicti NOT LIKE '%Authority%';
                      ^
	SELECT * FROM jurisdictions;
	
	~~~~
 id |      name
----|----------------
  1 | DCAS
  2 | DSBS
  3 | NYPD
  4 | MTA
  5 | BORO PRES.
  6 | TRANSIT
  7 | NYCHA
  8 | FEDERAL
  9 | CULT
 10 | DBS
 11 | SDOT
 12 | DEP
 13 | EDC
 14 | LINCOLN CENTER
 15 | CDOT
 16 | SBS
 17 | BBPC
 18 | DOE
 19 | DPR
 20 | DOT
 21 | TBTA
 22 | NPS
 23 | UNKNOWN
 24 | PRIVATE
 25 | HPD

	
	~~~~
	
</details>

<details>
   <summary>
  DRAFT Squirrel Table
  </summary>

Squirrel is one of the three fact tables in this dataset, so the process of normalizing this table starts at a dramatically different place from the look-up tables. First, one must aggregate squirrel_sightings1 and squdata into one table, as both tables represent the same entities, but were recorded in slightly different ways a couple years apart.
	
		
	<h3> Agglomerate Squirrel Tables </h3>

First, one must aggegrate the two squirrel tables into one. This exercise will funnel data into the squirrel_sightings1, as the data structure offers multiple choice instead of open response regarding squirrel activities and vocalizations. While some of the written open responses are absolutely delightful, the qualitative data makes it harder to analyze data in SQL. To combine the squirrel-centered tables together, one must begin by converting all of columns pertaining to squirrel activities in the squirrel_sightings1 table from the integer data type into boolean.
	
	~~~~postgresql
	
	ALTER TABLE squirrel_sightings1
	ALTER COLUMN kuks TYPE boolean USING (kuks :: boolean)
	ALTER COLUMN running type boolean using (running :: boolean),
	ALTER COLUMN chasing TYPE boolean USING (chasing :: boolean),
	ALTER COLUMN climbing TYPE boolean USING (climbing :: boolean),
	ALTER COLUMN eating TYPE boolean USING (eating :: boolean),
	ALTER COLUMN foraging TYPE boolean USING (foraging :: boolean),
	ALTER COLUMN quaas TYPE boolean USING (quaas :: boolean),
	ALTER COLUMN moans TYPE boolean USING (moans :: boolean),
	ALTER COLUMN tail_flags TYPE boolean USING (tail_flags :: boolean),
	ALTER COLUMN tail_twitc TYPE boolean USING (tail_twitc :: boolean),
	ALTER COLUMN approaches TYPE boolean USING (approaches :: boolean),
	ALTER COLUMN indifferen TYPE boolean USING (indifferen :: boolean),
	ALTER COLUMN runs_from  TYPE boolean USING (runs_from  :: boolean);
	
	~~~~
Now, it is time to insert data from squdata into squirrel_sightings1. (EDIT LATER)	
	
	~~~~POSTGRESQL
	INSERT INTO squirrel_sightings1 (
		gid ,
		x,
		y,
		unique_squ,
		primary_fu,
		highlight_,
		color_note,
		location,
		above_grou,
		running,
		chasing,
		climbing,
		eating,
		foraging,
		kuks,
		quaas,
		moans,
		tail_flags,
		tail_twitc,
		approaches,
		indifferen,
		runs_from,
		geom)
	SELECT 
			gid+4000 AS fid,
			squirrel_1 AS x,
			squirrel_l AS y,
			squirrel_i AS unique_squ,
			primary_fu AS primary_color,
			highlights,
			color_note,
			location,
			--above ground?
			--is squirrel above the ground (1) or on the ground plane (0)?
			CASE 
				WHEN split_part(LOWER(location), ',', 1) LIKE '%above ground%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS above_ground,
			--running
			CASE 
				WHEN split_part(LOWER(activities), ',', 1) LIKE '%running%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS running,
			--chasing
			CASE 
				WHEN split_part(LOWER(activities), ',', 1) LIKE '%chasing%' then CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS chasing ,
			--climbing
			CASE 
				WHEN split_part(LOWER(activities), ',', 1) LIKE '%climbing%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS climbing,

			--eating
			CASE 
				WHEN split_part(LOWER(activities), ',', 1) LIKE '%eating%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS eating,

			CASE 
				WHEN split_part(LOWER(activities), ',', 1) LIKE '%foraging%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS foraging,
			--was a kuk reported?
			CASE
				WHEN LOWER(activities) LIKE '%kuk%' THEN CAST(1 AS boolean)
				WHEN LOWER(interactio) LIKE '%kuk%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS kuk,
			--quaa
			CASE
				WHEN LOWER(activities) LIKE '%quaa%' THEN CAST(1 AS boolean)
				WHEN LOWER(interactio) LIKE '%quaa%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS quaa,
			--moan
			CASE
				WHEN LOWER(activities) LIKE '%moan%' THEN CAST(1 AS boolean)
				WHEN LOWER(interactio) LIKE '%moan%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS moan,
			--tail flag
			CASE
				WHEN LOWER(activities) LIKE '%tail flag%' THEN CAST(1 AS boolean)
				WHEN LOWER(interactio) LIKE '%tail flag%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS tail_flag,
			--tail_twitch 
				CASE
				WHEN LOWER(activities) LIKE '%tail twitch%' THEN CAST(1 AS boolean)
				WHEN LOWER(interactio) LIKE '%tail twitch%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS tail_twitch,	

			-- approaches humans
			CASE 
				WHEN split_part(LOWER(interactio), ',', 1) LIKE '%approaches%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS approaches,	
			--indifferent interaction to humans
			CASE 
				WHEN split_part(LOWER(interactio), ',', 1) LIKE '%indifferent%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS indifferent,
			--runs away from
			CASE 
				WHEN split_part(LOWER(interactio), ',', 1) LIKE '%runs from%' THEN CAST(1 AS boolean)
				ELSE CAST(0 AS boolean)
			END AS run_from,
			-- geom
			geom
	FROM squdata;
	~~~~
	
	
<h3> Normalization </h3>

Now that the squirrels tables are now one, it is time to normalize the table using the following demention tables:
	
	~~~~postgresql
	
	--Removing columns from the table.  
	
	ALTER TABLE squirrel_sightings1 
	DROP COLUMN hectare, --this study does not require hectare to be in it. 
	DROP COLUMN hectare_sq,  -- this column was dependant on hectare
	DROP COLUMN combinatio; --this data was composed of a combination of primary_fu and highlights. 
	
	
	
	~~~~


 gid |       x        |       y       |   unique_squ   | shift |   date   |  age  | primary_fu | highlight_ |                                      color_note                                       |   location   | above_grou | specific_l | running | chasing | climbing | eating | foraging | other_acti | kuks | quaas | moans | tail_flags | tail_twitc | approaches | indifferen | runs_from | other_inte |                    geom
-----|----------------|---------------|----------------|-------|----------|-------|------------|------------|---------------------------------------------------------------------------------------|--------------|------------|------------|---------|---------|----------|--------|----------|------------|------|-------|-------|------------|------------|------------|------------|-----------|------------|--------------------------------------------
   1 | -73.9561344938 | 40.7940823884 | 37F-PM-1014-03 | PM    | 10142018 |       |            |            |                                                                                       |              |            |            | f       | f       | f        | f      | f        |            | f    | f     | f     | f          | f          | f          | f          | f         |            | 0101000000E258BB4E317D52C0B245E07DA4654440
   2 | -73.9688574691 | 40.7837825208 | 21B-AM-1019-04 | AM    | 10192018 |       |            |            |                                                                                       |              |            |            | f       | f       | f        | f      | f        |            | f    | f     | f     | f          | f          | f          | f          | f         |            | 01010000001314C2C2017E52C0001A53FC52644440
   3 | -73.9742811485 | 40.7755336191 | 11B-PM-1014-08 | PM    | 10142018 |       | Gray       |            |                                                                                       | Above Ground | 10         |            | f       | t       | f        | f      | f        |            | f    | f     | f     | f          | f          | f          | f          | f         |            | 01010000009D76519F5A7E52C07B7485AF44634440
   4 | -73.9596413904 | 40.7903128889 | 32E-PM-1017-14 | PM    | 10172018 | Adult | Gray       |            | Nothing selected as Primary. Gray selected as Highlights. Made executive adjustments. |              |            |            | f       | f       | f        | t      | t        |            | f    | f     | f     | f          | f          | f          | f          | t         |            | 01010000008DE8B8C36A7D52C0FEB805F928654440
(4 rows)

	
	  ~~~~postgresql
		--Normalizing Colors
	
		--insert the color_id into squirrel_sightings1 table

		ALTER TABLE squirrel_sightings1
		ADD primary_color integer;	
		
		-- populate new column with the color table's primary key
	
		UPDATE public.squirrel_sightings1 --format schema.table_name
		SET 
		primary_color = colors.id
		FROM colors
		WHERE squirrel_sightings1.primary_fu = colors.color;
		
		-- remove original column containing 
		ALTER TABLE squirrel_sightings1
		DROP primary_fu;
	
		--Normalizing Highlights
		
	
		-- Normalizing Age
		
		--insert the age_id into table
		ALTER TABLE squirrel_sightings1
			ADD age_id integer;

			-- populate new column with the color table's primary key
			UPDATE public.squirrel_sightings1 --format schema.table_name
			SET 
			age_id = ages.id
			FROM ages
			WHERE squirrel_sightings1.age = ages.age;

			ALTER TABLE squirrel_sightings1 
			DROP age;
	~~~~


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
 	Outings is one of the three fact tables. In fact, it is the core of this database. 
	
<h3> Making the Table </h3>
	
	~~~~postgresql
	
	--Create Table
	
	CREATE table"outings" (
	  "outing_id" SERIAL,
	  "date" date,
	  "start_time" time,
	  "end_time" time,
	  "park_id" character varying,
	  "area_id" character(1),
	  "condition_id" integer,
	  "condition_desc" character varying,
	  "litter_id" integer,
	  "weather_id" integer,
	  "weather_desc" character varying,
	  "temp_id" integer,
	  "group_id" character varying,
	  PRIMARY KEY ("outing_id")
	);

	-- Populate Table
	
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
	
	--Let's see what the table looks like.
	SELECT * FROM outings LIMIT 20;
	
	~~~~
	
	
 outing_id |    date    | start_time | end_time | park_id | area_id | condition_id |                          condition_desc                          | litter_id |                            litter_desc                            | weather_id |              weather_desc               | temp_id | group_id
-----------|------------|------------|----------|---------|---------|--------------|------------------------------------------------------------------|-----------|-------------------------------------------------------------------|------------|-----------------------------------------|---------|----------
         1 | 2020-03-01 | 15:14:00   | 16:05:00 | 1       | A       |              | Busy                                                             |           | Some                                                              |            | 43 degrees, sunny                       |         |
         2 | 2020-03-01 | 15:30:00   | 16:00:00 | 2       | A       |              | Calm                                                             |           | Some, in trees                                                    |            | cold, clear                             |         |
         3 | 2020-03-01 | 15:21:00   | 16:15:00 | 3       | A       |              | Calm, pick-up baseball game                                      |           | Some, especially caught in wooded area in East, balloons in trees |            | 43 degrees                              |         |
         4 | 2020-03-01 | 15:15:00   | 15:45:00 | 4       | A       |              | Calm                                                             |           | Some, backside of park                                            |            | 43 degrees, clear                       |         |
         5 | 2020-03-01 | 15:15:00   | 15:45:00 | 5       | A       |              | Calm                                                             |           |                                                                   |            |                                         |         |
         6 | 2020-03-01 | 15:45:00   | 16:15:00 | 6       | A       |              | Calm, re: humans, but a hawk is certainly not a calming presence |           | Abundant                                                          |            | 42 degrees, clear                       |         |
         7 | 2020-03-01 | 14:30:00   | 15:50:00 | 7       | B       |              | Busy                                                             |           |                                                                   |            | 43 degrees, sunny                       |         |
         8 | 2020-03-01 | 15:15:00   | 15:45:00 | 8       | B       |              | Busy                                                             |           |                                                                   |            | 40 degrees, sunny                       |         |
         9 | 2020-03-01 | 15:00:00   | 16:00:00 | 9       | B       |              | Calm, 20èùû30 ppl on each side                                   |           | Some                                                              |            | 45 degrees, sunny                       |         |
        10 | 2020-03-01 | 15:20:00   | 16:00:00 | 10      | B       |              | Busy                                                             |           | None                                                              |            | 45 degrees, sunny with shade spots      |         |
        11 | 2020-03-01 | 15:15:00   | 15:45:00 | 11      | B       |              |                                                                  |           |                                                                   |            |                                         |         |
        12 | 2020-03-01 | 15:01:00   | 15:45:00 | 12      | B       |              | Calm                                                             |           |                                                                   |            | windy, clear                            |         |
        13 | 2020-03-01 | 15:30:00   | 16:00:00 | 13.1    | C       |              | Busy                                                             |           | Some                                                              |            | 44 degrees, sunny                       |         |
        14 | 2020-03-01 | 15:30:00   | 16:00:00 | 13.2    | C       |              | Busy                                                             |           | Some                                                              |            | 43 degrees, sunny                       |         |
        15 | 2020-03-01 | 15:25:00   | 15:55:00 | 14      | C       |              | Busy                                                             |           | Some                                                              |            | 40 degrees, sunny                       |         |
        16 | 2020-03-01 | 15:35:00   | 16:15:00 | 15      | C       |              | Calm                                                             |           | Some, mostly in trees                                             |            | 48 degrees, sunny                       |         |
        17 | 2020-03-01 | 15:47:00   | 16:38:00 | 16      | C       |              | Busy                                                             |           | None                                                              |            | 42 degrees, windy, dry, clear           |         |
        18 | 2020-03-01 | 15:35:00   | 15:45:00 | 17      | C       |              | Calm                                                             |           | None                                                              |            | 42 degrees, windy, dry, clear           |         |
        19 | 2020-03-01 | 15:37:00   | 16:00:00 | 18      | C       |              |                                                                  |           | Some                                                              |            | 43 degrees, sunny, with 20-30 mph gusts |         |
        20 | 2020-03-01 | 15:34:00   | 16:04:00 | 19      | C       |              | Calm                                                             |           | None                                                              |            | 44 degrees, sunny                       |         |
(20 rows)

Note the empty columns in this table. Unlike in Squirrel, the forgein key columns were made at the same time as the others in the pervious code blcok. 

<h3> Normalization </h3>

	~~~~postgresql
	-- Insert litter_id into Outings
	
	UPDATE public.outings --format schema.table_name
	SET 
	litter_id = litter.litter_id :: integer
	FROM litter
	WHERE split_part(outings.litter_desc, ',',1) = litter.name;
	
	/* Unfortunately, there is not enough time to normalize the open responses at this time. So details about where the litter was located will be
	tabled for another time. For now, the descriptions of the litter shall be dropped. */
	
	ALTER TABLE outings
	DROP litter_desc ;
	
	-- Insert conditions_id into Outings
		UPDATE public.outings --format schema.table_name
		SET 
		condition_id = conditions.condition_id :: integer
		FROM conditions
		WHERE split_part(split_part(condition_desc,'-',1),',',1) = conditions.name;
	
		/* There is not enough time to normalize the open responses of the park conditions. A formal apology specifically to 7-year-old Hank,
		whose commentary throughout the database has brought much insight and delight. */
		ALTER TABLE outings
		DROP condition_desc ;
	
	--Extract the temperature from the Weather column and insert it into its own column, temp_fahrenheit
		ALTER TABLE outings 
		ADD COLUMN temp_fahrenheit integer;

		UPDATE public.outings --format schema.table_name
		SET 
		temp_fahrenheit = split_part(split_part(split_part(weather_desc , ',', 1), ' ', 1), '-', 1) :: integer
		WHERE weather_desc  LIKE '%1%'  
		or weather_desc  like '%2%'
		or weather_desc like '%3%'
		or weather_desc  like '%4%'
		or weather_desc  like '%5%'
		or weather_desc  like '%6%'
		or weather_desc  like '%7%'
		or weather_desc  like '%8%'
		or weather_desc  like '%9%'
		or weather_desc  like '%0%';
	
	~~~~
	
	
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
  DRAFT
  </summary>

  
  
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
  
  
   <details>
   <summary>
  Zipcode Table
  </summary>
	
	~~~~postgresql
	 CREATE TABLE "zipcodes" (
  		"zipcode" character(5),
  		"park_id" character varying(15)		,
  		PRIMARY KEY ("zipcode")
		);


		INSERT INTO zipcodes(zipcode) SELECT DISTINCT  ltrim(unnest(string_to_array(zipcode, ',')))
			FROM nyc_parks1
			WHEERE LENGTH(zipcode) = 5 ;
	
	~~~~
  </details>
  
 <h2 style="text-align: center;">
Milestone 3: The Script
  
  ![03-complete_works_300x300-1](https://user-images.githubusercontent.com/128807596/227696099-a3556597-c5af-4a71-802c-5c44405ac3bb.jpg)


  
 
<h2 style="text-align: center;">
Milestone 5: Discussion
  </h2>
 
<details>	
<summary>
<h2 style="text-align: center;">
Appendix A: Loading the Data
  </h2>
<details>	
	
1. Activate PostGIS Shapefile Import/Export Manager

	![image](https://user-images.githubusercontent.com/128807596/229322820-64f63052-2c85-49b7-a432-489bde334a4a.png)

2. Click on "View Connection Details..." and enter in credentials.

	![image](https://user-images.githubusercontent.com/128807596/229322844-b0bacd1e-ec13-4a0e-b5df-e4157c15c6a3.png)

3. Next, press "Add File," and select the three shapefiles: squdata, squirrel_sightings1, and nyc_parks1.

	![image](https://user-images.githubusercontent.com/128807596/229323328-c6d31d67-6a4e-4c98-af73-85289d79db66.png)

	
4. Use the Start menu t activate SQL Shell (psql). Enter credentials.
	
5. Next, connect to the database via the \c database_name command.
	
6. Once connected, type CREATE EXTENSION POSTGIS;
	
	![image](https://user-images.githubusercontent.com/128807596/229323651-572f444a-3e70-41ce-8efe-67c171e3d0fd.png)

7. Return to the PostGIS Shapefile Import/Export Manager window. Press "Import."
	
	![image](https://user-images.githubusercontent.com/128807596/229323691-eba9d5bf-c811-46f9-8bda-bbed2a96b987.png)
	
8. Copy the parks_data CSV into the database via 

	</summary>
	</details	 

	<img src="{![image]([
](https://phineasandferb.fandom.com/wiki/S.I.M.P._(Squirrels_In_My_Pants)?file=S.I.M.P.jpg))
}" alt="Alternate Text" />
</a>

<details>	
<summary>
<h2 style="text-align: center;">
References
  </h2>

Culross, M., Marsh, J., &amp; Povenmire, D. (2009). Phineas and Ferb. Squirrels In My Pants. YouTube. 
	Retrieved April 1, 2023, from https://www.youtube.com/watch?v=OID7gA8fcaw. 

"Margins decorated with border of foliate ornament and bunches of twigs, and inhabited by squirrel, wearing collar with lead attached to ring on block on which the 	squirrel is seated, and by fantastic bird.". (n.d.). The Morgan Library and Museum. 
	Retrieved April 1, 2023, from http://ica.themorgan.org/manuscript/page/9/76938. 	

	</summary>
	</details
	
  
  ![Copy of Open Source Shakespeare ERD - Page 3](https://user-images.githubusercontent.com/128807596/229255637-4336c68c-273b-4332-87de-606363a52ecd.jpeg)
