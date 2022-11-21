--Data scraped from : 
--https://www.serebii.net/

--TODO
--pokeAbilities (no hidden?)
--pokeAtLocation (semi hard. go to pokemon page and check each ruote number and add "route" to end of it?)
--pokeLearnsMoves (semi hard unless can easily count amount of moves)

--Deleted learnsBy
--changed baseStats to HP, DEF....
--clean up relations first then entities
--should change effortValues to individual ones like baseStats?
--got rid of gender, supercontest, nature, effortValues, characteristics. evolveMethod on hold for now since very complicated
--changed 'effectiveness' table to isEffectiveAgainst
--ON DELETE CASCADES
--add not nulls?
--remove PokemonType from ER? (since we have pokemonHasType table/relation)
--trainer time change to date instead of int?

use cs3380;

-- clean up
drop table if exists pokemonEggGroups;
drop table if exists pokemonLearnsMoveBy;
drop table if exists pokemonLearnsMoves;
drop table if exists pokemonAbilities;
drop table if exists trainerOwns;
drop table if exists locatedAt;
drop table if exists isEffectiveAgainst;
drop table if exists moveHasType;
drop table if exists pokemonHasTypes;
drop table if exists trainer;
drop table if exists location;
drop table if exists move;
drop table if exists type;
drop table if exists pokemon;


create table pokemon ( --done
    dexNum integer primary key,
    name text not null,
    hp integer not null,
    atk integer not null,
    def integer not null,
    spa integer not null,
    spd integer not null,
    speed integer not null,
    height text not null,
    weight text not null,
    captureRate integer not null,
    classification text,
    expGrowth integer not null,
    baseHappiness integer not null,
    colour text not null,
    eggSteps integer
    --evolveMethod text
);

create table type ( --done
    typeName varchar(100) primary key
);

create table move ( --done
    moveName varchar(100) primary key,
    basePower integer,
    accuracy integer,
	description text,
    effect text,
    --battleType text,
    category text,
    powerPoints integer,
    speedPrio integer
    --moveLevel integer
);

create table location ( --done
    locationName varchar(100) primary key
);

create table trainer ( --done
    trainerID integer primary key,
    secretID integer,
    trainerName text,
    money integer not null,
    score integer not null,
    pokedexCount integer not null,
    time text not null,
    startTime text not null
);

create table pokemonEggGroups ( --done
    dexNum integer references pokemon(dexNum),
    eggGroup varchar(100) not null,
    primary key (dexNum, eggGroup)
);

create table pokemonAbilities (
    dexNum integer references pokemon(dexNum),
    ability varchar(100) not null,
    primary key (dexNum, ability)
);

--create table pokemonLearnsMoveBy ( --MIGHT DELETE
    --dexNum integer references pokemon(dexNum),
    --moveName varchar(100) references move(moveName),
    --learnsBy varchar(100),
    --primary key (dexNum, moveName, learnsBy)
--);

--relatations

create table pokemonHasTypes ( --done
    dexNum integer references pokemon(dexNum),
    typeName varchar(100) references type(typeName),
    primary key (dexNum, typeName)
);

create table pokemonLearnsMoves (
    dexNum integer references pokemon(dexNum),
    moveName varchar(100) references move(moveName),
    primary key (dexNum, moveName)
);

create table moveHasType( --done
    moveName varchar(100) references move(moveName),
    typeName varchar(100) references type(typeName),
    primary key (moveName, typeName)
);

create table isEffectiveAgainst( --done
    atkTypeName varchar(100) references type(typeName), --attacking type
    defTypeName varchar(100) references type(typeName), --defending type
    primary key (atkTypeName, defTypeName)
);

create table locatedAt( 
    dexNum integer references pokemon(dexNum),
    locationName varchar(100) references location(locationName),
    primary key (dexNum, locationName)
);

create table trainerOwns( --done
    dexNum integer references pokemon(dexNum),
    trainerID integer references trainer(trainerID),
    primary key (dexNum, trainerID)
);



INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (001,'Bulbasaur',45,49,49,65,65,45,'2 Feet 04 Inches','15.2lbs',45,'Seed Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (002,'Ivysaur',60,62,63,80,80,60,'3 Feet 03 Inches','28.7lbs',45,'Seed Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (003,'Venusaur',80,82,83,100,100,80,'6 Feet 07 Inches','220.5lbs',45,'Seed Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (004,'Charmander',39,52,43,60,50,65,'2 Feet 00 Inches','18.7lbs',45,'Lizard Pokémon',1059860,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (005,'Charmeleon',58,64,58,80,65,80,'3 Feet 07 Inches','41.9lbs',45,'Flame Pokémon',1059860,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (006,'Charizard',78,84,78,109,85,100,'5 Feet 07 Inches','199.5lbs',45,'Flame Pokémon',1059860,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (007,'Squirtle',44,48,65,50,64,43,'1 Feet 08 Inches','19.8lbs',45,'Tiny Turtle Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (008,'Wartortle',59,63,80,65,80,58,'3 Feet 03 Inches','49.6lbs',45,'Turtle Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (009,'Blastoise',79,83,100,85,105,78,'5 Feet 03 Inches','188.5lbs',45,'Turtle Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (010,'Caterpie',45,30,35,20,20,45,'1 Feet 00 Inches','6.4lbs',255,'Worm Pokémon',1000000,70,'Green',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (011,'Metapod',50,20,55,25,25,30,'2 Feet 04 Inches','21.8lbs',120,'Cocoon Pokémon',1000000,70,'Green',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (012,'Butterfree',60,45,50,80,80,70,'3 Feet 07 Inches','70.5lbs',45,'Butterfly Pokémon',1000000,70,'White',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (013,'Weedle',40,35,30,20,20,50,'1 Feet 00 Inches','7.1lbs',255,'Hairy Bug Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (014,'Kakuna',45,25,50,25,25,35,'2 Feet 00 Inches','22.0lbs',120,'Cocoon Pokémon',1000000,70,'Yellow',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (015,'Beedrill',65,80,40,45,80,75,'3 Feet 03 Inches','65.0lbs',45,'Poison Bee Pokémon',1000000,70,'Yellow',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (016,'Pidgey',40,45,40,35,35,56,'1 Feet 00 Inches','4.0lbs',255,'Tiny Bird Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (017,'Pidgeotto',63,60,55,50,50,71,'3 Feet 07 Inches','66.1lbs',120,'Bird Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (018,'Pidgeot',83,80,75,70,70,91,'4 Feet 11 Inches','87.1lbs',45,'Bird Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (019,'Rattata',30,56,35,25,35,72,'1 Feet 00 Inches','7.7lbs',255,'Mouse Pokémon',1000000,70,'Purple',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (020,'Raticate',55,81,60,50,70,97,'2 Feet 04 Inches','40.8lbs',127,'Mouse Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (021,'Spearow',40,60,30,31,31,70,'1 Feet 00 Inches','4.4lbs',255,'Tiny Bird Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (022,'Fearow',65,90,65,61,61,100,'3 Feet 11 Inches','83.8lbs',90,'Beak Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (023,'Ekans',35,60,44,40,54,55,'6 Feet 07 Inches','15.2lbs',255,'Snake Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (024,'Arbok',60,85,69,65,79,80,'11 Feet 06 Inches','143.3lbs',90,'Cobra Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (025,'Pikachu',35,55,30,50,40,90,'1 Feet 04 Inches','13.0lbs',190,'Mouse Pokémon',1000000,70,'Yellow',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (026,'Raichu',60,90,55,90,80,100,'2 Feet 07 Inches','66.0lbs',75,'Mouse Pokémon',1000000,70,'Yellow',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (027,'Sandshrew',50,75,85,20,30,40,'2 Feet 00 Inches','26.0lbs',255,'Mouse Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (028,'Sandslash',75,100,110,45,55,65,'3 Feet 03 Inches','65.0lbs',90,'Mouse Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (029,'Nidoran♀',55,47,52,40,40,41,'1 Feet 04 Inches','15.4lbs',235,'Poison Pin Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (030,'Nidorina',70,62,67,55,55,56,'2 Feet 07 Inches','44.1lbs',120,'Poison Pin Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (031,'Nidoqueen',90,82,87,75,85,76,'4 Feet 03 Inches','132.3lbs',45,'Drill Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (032,'Nidoran♂',46,57,40,40,40,50,'1 Feet 08 Inches','19.8lbs',235,'Poison Pin Pokémon',1059860,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (033,'Nidorino',61,72,57,55,55,65,'2 Feet 11 Inches','43.0lbs',120,'Poison Pin Pokémon',1059860,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (034,'Nidoking',81,92,77,85,75,85,'4 Feet 07 Inches','136.7lbs',45,'Drill Pokémon',1059860,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (035,'Clefairy',70,45,48,60,65,35,'2 Feet 00 Inches','16.5lbs',150,'Fairy Pokémon',800000,140,'Pink',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (036,'Clefable',95,70,73,85,90,60,'4 Feet 03 Inches','88.2lbs',25,'Fairy Pokémon',800000,140,'Pink',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (037,'Vulpix',38,41,40,50,65,65,'2 Feet 00 Inches','22.0lbs',190,'Fox Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (038,'Ninetales',73,76,75,81,100,100,'3 Feet 07 Inches','44.0lbs',75,'Fox Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (039,'Jigglypuff',115,45,20,45,25,20,'1 Feet 08 Inches','12.0lbs',170,'Balloon Pokémon',800000,70,'Pink',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (040,'Wigglytuff',140,70,45,75,50,45,'3 Feet 03 Inches','26.0lbs',50,'Balloon Pokémon',800000,70,'Pink',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (041,'Zubat',40,45,35,30,40,55,'2 Feet 07 Inches','17.0lbs',255,'Bat Pokémon',1000000,70,'Purple',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (042,'Golbat',75,80,70,65,75,90,'5 Feet 03 Inches','121.0lbs',90,'Bat Pokémon',1000000,70,'Purple',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (043,'Oddish',45,50,55,75,65,30,'1 Feet 08 Inches','12.0lbs',255,'Weed Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (044,'Gloom',60,65,70,85,75,40,'1 Feet 08 Inches','12.0lbs',120,'Weed Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (045,'Vileplume',75,80,85,100,90,50,'3 Feet 11 Inches','41.0lbs',45,'Flower Pokémon',1059860,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (046,'Paras',35,70,55,45,55,25,'1 Feet 00 Inches','11.9lbs',190,'Mushroom Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (047,'Parasect',60,95,80,60,80,30,'3 Feet 03 Inches','65.0lbs',75,'Mushroom Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (048,'Venonat',60,55,50,40,55,45,'3 Feet 03 Inches','66.1lbs',190,'Insect Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (049,'Venomoth',70,65,60,90,75,90,'4 Feet 11 Inches','27.6lbs',75,'Poison Moth Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (050,'Diglett',10,55,25,35,45,95,'0 Feet 08 Inches','1.8lbs',255,'Mole Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (051,'Dugtrio',35,80,50,50,70,120,'2 Feet 04 Inches','73.4lbs',50,'Mole Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (052,'Meowth',40,45,35,40,40,90,'1 Feet 04 Inches','9.3lbs',255,'Scratch Cat Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (053,'Persian',65,70,60,65,65,115,'3 Feet 03 Inches','70.5lbs',90,'Classy Cat Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (054,'Psyduck',50,52,48,65,50,55,'2 Feet 07 Inches','43.0lbs',190,'Duck Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (055,'Golduck',80,82,78,95,80,85,'5 Feet 07 Inches','169.0lbs',75,'Duck Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (056,'Mankey',40,80,35,35,45,70,'1 Feet 08 Inches','61.7lbs',190,'Pig Monkey Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (057,'Primeape',65,105,60,60,70,95,'3 Feet 03 Inches','70.5lbs',75,'Pig Monkey Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (058,'Growlithe',55,70,45,70,50,60,'2 Feet 04 Inches','41.9lbs',190,'Puppy Pokémon',1250000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (059,'Arcanine',90,110,80,100,80,95,'6 Feet 03 Inches','341.7lbs',75,'Legendary Pokémon',1250000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (060,'Poliwag',40,50,40,40,40,90,'2 Feet 00 Inches','27.3lbs',255,'Tadpole Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (061,'Poliwhirl',65,65,65,50,50,90,'3 Feet 03 Inches','44.1lbs',120,'Tadpole Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (062,'Poliwrath',90,85,95,70,90,70,'4 Feet 03 Inches','119.0lbs',45,'Tadpole Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (063,'Abra',25,20,15,105,55,90,'2 Feet 11 Inches','43.0lbs',200,'Psi Pokémon',1059860,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (064,'Kadabra',40,35,30,120,70,105,'4 Feet 03 Inches','125.0lbs',100,'Psi Pokémon',1059860,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (065,'Alakazam',55,50,45,135,85,120,'4 Feet 11 Inches','106.0lbs',50,'Psi Pokémon',1059860,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (066,'Machop',70,80,50,35,35,35,'2 Feet 07 Inches','43.0lbs',180,'Superpower Pokémon',1059860,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (067,'Machoke',80,100,70,50,60,45,'4 Feet 11 Inches','155.0lbs',90,'Superpower Pokémon',1059860,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (068,'Machamp',90,130,80,65,85,55,'5 Feet 03 Inches','287.0lbs',45,'Superpower Pokémon',1059860,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (069,'Bellsprout',50,75,35,70,30,40,'2 Feet 04 Inches','8.8lbs',255,'Flower Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (070,'Weepinbell',65,90,50,85,45,55,'3 Feet 03 Inches','14.1lbs',120,'Flycatcher Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (071,'Victreebel',80,105,65,100,60,70,'5 Feet 07 Inches','34.2lbs',45,'Flycatcher Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (072,'Tentacool',40,40,35,50,100,70,'2 Feet 11 Inches','100lbs',190,'Jellyfish Pokémon',1250000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (073,'Tentacruel',80,70,65,80,120,100,'5 Feet 03 Inches','121lbs',60,'Jellyfish Pokémon',1250000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (074,'Geodude',40,80,100,30,30,20,'1 Feet 04 Inches','44lbs',255,'Rock Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (075,'Graveler',55,95,115,45,45,35,'3 Feet 03 Inches','232lbs',120,'Rock Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (076,'Golem',80,110,130,55,65,45,'4 Feet 07 Inches','662lbs',45,'Megaton Pokķmon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (077,'Ponyta',50,85,55,65,65,90,'3 Feet 03 Inches','66.1lbs',190,'Fire Horse Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (078,'Rapidash',65,100,70,80,80,105,'5 Feet 07 Inches','209.0lbs',60,'Fire Horse Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (079,'Slowpoke',90,65,65,40,40,15,'3 Feet 11 Inches','79.4lbs',190,'Dopey Pokémon',1000000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (080,'Slowbro',95,75,110,100,80,30,'5 Feet 03 Inches','173.0lbs',75,'Hermit Crab Pokémon',1000000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (081,'Magnemite',25,35,70,95,55,45,'1 Feet 00 Inches','13.0lbs',190,'Magnet Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (082,'Magneton',50,60,95,120,70,70,'3 Feet 03 Inches','132.0lbs',60,'Magnet Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (083,'Farfetchd',52,65,55,58,62,60,'2 Feet 07 Inches','33.1lbs',45,'Wild Duck Pokķmon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (084,'Doduo',35,85,45,35,35,75,'4 Feet 07 Inches','86.0lbs',190,'Twin Bird Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (085,'Dodrio',60,110,70,60,60,100,'5 Feet 11 Inches','188.0lbs',45,'Triple Bird Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (086,'Seel',65,45,55,45,70,45,'3 Feet 07 Inches','198.0lbs',190,'Sea Lion Pokémon',1000000,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (087,'Dewgong',90,70,80,70,95,70,'5 Feet 07 Inches','265.0lbs',75,'Sea Lion Pokémon',1000000,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (088,'Grimer',80,80,50,40,50,25,'2 Feet 11 Inches','66.0lbs',190,'Sludge Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (089,'Muk',105,105,75,65,100,50,'3 Feet 11 Inches','66.0lbs',75,'Sludge Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (090,'Shellder',30,65,100,45,25,40,'1 Feet 00 Inches','8.8lbs',190,'Bivalve Pokémon',1250000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (091,'Cloyster',50,95,180,85,45,70,'4 Feet 11 Inches','292.1lbs',60,'Bivalve Pokémon',1250000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (092,'Gastly',30,35,30,100,35,80,'4 Feet 03 Inches','0.2lbs',190,'Gas Pokémon',1059860,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (093,'Haunter',45,50,45,115,55,95,'5 Feet 03 Inches','0.2lbs',90,'Gas Pokémon',1059860,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (094,'Gengar',60,65,60,130,75,110,'4 Feet 11 Inches','89.3lbs',45,'Gas Pokémon',1059860,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (095,'Onix',35,45,160,30,45,70,'28 Feet 10 Inches','463.0lbs',45,'Rock Snake Pokémon',1000000,70,'Gray',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (096,'Drowzee',60,48,45,43,90,42,'3 Feet 03 Inches','71.4lbs',190,'Hypnosis Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (097,'Hypno',85,73,70,73,115,67,'5 Feet 03 Inches','166.7lbs',75,'Hypnosis Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (098,'Krabby',30,105,90,25,25,50,'1 Feet 04 Inches','14.3lbs',225,'River Crab Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (099,'Kingler',55,130,115,50,50,75,'4 Feet 03 Inches','132.3lbs',60,'Pincer Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (100,'Voltorb',40,30,50,55,55,100,'1 Feet 08 Inches','23.0lbs',190,'Ball Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (101,'Electrode',60,50,70,80,80,140,'3 Feet 11 Inches','147.0lbs',60,'Ball Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (102,'Exeggcute',60,40,80,60,45,40,'1 Feet 04 Inches','5.5lbs',90,'Egg Pokémon',1250000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (103,'Exeggutor',95,95,85,125,65,55,'6 Feet 07 Inches','264.6lbs',45,'Coconut Pokémon',1250000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (104,'Cubone',50,50,95,40,50,35,'1 Feet 04 Inches','14.3lbs',190,'Lonely Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (105,'Marowak',60,80,110,50,80,45,'3 Feet 03 Inches','99.2lbs',75,'Bone Keeper Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (106,'Hitmonlee',50,120,53,35,110,87,'4 Feet 11 Inches','109.8lbs',45,'Kicking Pokémon',1000000,70,'Brown',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (107,'Hitmonchan',50,105,79,35,110,76,'4 Feet 07 Inches','110.7lbs',45,'Punching Pokémon',1000000,70,'Brown',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (108,'Lickitung',90,55,75,60,75,30,'3 Feet 11 Inches','144.4lbs',45,'Licking Pokémon',1000000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (109,'Koffing',40,65,95,60,45,35,'2 Feet 00 Inches','2.0lbs',190,'Poison Gas Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (110,'Weezing',65,90,120,85,70,60,'3 Feet 11 Inches','21.0lbs',60,'Poison Gas Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (111,'Rhyhorn',80,85,95,30,30,25,'3 Feet 03 Inches','254.0lbs',120,'Spikes Pokémon',1250000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (112,'Rhydon',105,130,120,45,45,40,'6 Feet 03 Inches','265.0lbs',60,'Drill Pokémon',1250000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (113,'Chansey',250,5,5,35,105,50,'3 Feet 07 Inches','76.3lbs',30,'Egg Pokémon',800000,140,'Pink',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (114,'Tangela',65,55,115,100,40,60,'3 Feet 03 Inches','7.2lbs',45,'Vine Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (115,'Kangaskhan',105,95,80,40,80,90,'7 Feet 03 Inches','176.4lbs',45,'Parent Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (116,'Horsea',30,40,70,70,25,60,'1 Feet 04 Inches','18.0lbs',225,'Dragon Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (117,'Seadra',55,65,95,95,45,85,'3 Feet 11 Inches','55.0lbs',75,'Dragon Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (118,'Goldeen',45,67,60,35,50,63,'2 Feet 00 Inches','33.0lbs',225,'Goldfish Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (119,'Seaking',80,92,65,65,80,68,'4 Feet 03 Inches','86.0lbs',60,'Goldfish Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (120,'Staryu',30,45,55,70,55,85,'2 Feet 07 Inches','76.0lbs',225,'Starshape Pokémon',1250000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (121,'Starmie',60,75,85,100,85,115,'3 Feet 07 Inches','176.0lbs',60,'Mysterious Pokémon',1250000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (122,'Mr. Mime',40,45,65,100,120,90,'4 Feet 03 Inches','120.1lbs',45,'Barrier Pokémon',1000000,70,'Pink',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (123,'Scyther',70,110,80,55,80,105,'4 Feet 11 Inches','123.5lbs',45,'Mantis Pokémon',1000000,70,'Green',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (124,'Jynx',65,50,35,115,95,95,'3 Feet 03 Inches','71.4lbs',45,'Humanshape Pokémon',1000000,70,'Red',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (125,'Electabuzz',65,83,57,95,85,105,'3 Feet 07 Inches','66.1lbs',45,'Electric Pokémon',1000000,70,'Yellow',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (126,'Magmar',65,95,57,100,85,93,'4 Feet 03 Inches','98.1lbs',45,'Spitfire Pokémon',1000000,70,'Red',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (127,'Pinsir',65,125,100,55,70,85,'4 Feet 11 Inches','121.0lbs',45,'Stagbeetle Pokķmon',1250000,70,'Brown',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (128,'Tauros',75,100,95,40,70,110,'4 Feet 07 Inches','194.9lbs',45,'Wild Bull Pokémon',1250000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (129,'Magikarp',20,10,55,15,20,80,'2 Feet 11 Inches','22.0lbs',255,'Fish Pokémon',1250000,70,'Red',1280);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (130,'Gyarados',95,125,79,60,100,81,'21 Feet 04 Inches','518.0lbs',45,'Atrocious Pokémon',1250000,70,'Blue',1280);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (131,'Lapras',130,85,80,85,95,60,'8 Feet 02 Inches','485lbs',45,'Transport Pokémon',1250000,70,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (132,'Ditto',48,48,48,48,48,48,'1 Feet 00 Inches','8.8lbs',35,'Transform Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (133,'Eevee',55,55,50,45,65,55,'1 Feet 00 Inches','14.3lbs',45,'Evolution Pokémon',1000000,70,'Brown',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (134,'Vaporeon',130,65,60,110,95,65,'3 Feet 03 Inches','63.9lbs',45,'Bubble Jet Pokémon',1000000,70,'Blue',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (135,'Jolteon',65,65,60,110,95,130,'2 Feet 07 Inches','54.0lbs',45,'Lightning Pokémon',1000000,70,'Yellow',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (136,'Flareon',65,130,60,95,110,65,'2 Feet 01 Inches','55.1lbs',45,'Flame Pokémon',1000000,70,'Red',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (137,'Porygon',65,60,70,85,75,40,'2 Feet 07 Inches','80.5lbs',45,'Virtual Pokémon',1000000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (138,'Omanyte',35,40,100,90,55,35,'1 Feet 04 Inches','16.5lbs',45,'Spiral Pokémon',1000000,70,'Blue',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (139,'Omastar',70,60,125,115,70,55,'3 Feet 03 Inches','77.2lbs',45,'Spiral Pokémon',1000000,70,'Blue',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (140,'Kabuto',30,80,90,55,45,55,'1 Feet 08 Inches','25.4lbs',45,'Shellfish Pokémon',1000000,70,'Brown',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (141,'Kabutops',60,115,105,65,70,80,'4 Feet 03 Inches','89.3lbs',45,'Shellfish Pokémon',1000000,70,'Brown',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (142,'Aerodactyl',80,105,65,60,75,130,'5 Feet 11 Inches','130.1lbs',45,'Fossil Pokémon',1250000,70,'Purple',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (143,'Snorlax',160,110,65,65,110,30,'6 Feet 11 Inches','1041.1lbs',25,'Sleeping Pokémon',1250000,70,'Black',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (144,'Articuno',90,85,100,95,125,85,'5 Feet 07 Inches','122.1lbs',3,'Freeze Pokémon',1250000,35,'Blue',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (145,'Zapdos',90,90,85,125,90,100,'5 Feet 03 Inches','116.0lbs',3,'Electric Pokémon',1250000,35,'Yellow',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (146,'Moltres',90,100,90,125,85,90,'6 Feet 07 Inches','132.3lbs',3,'Flame Pokémon',1250000,35,'Yellow',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (147,'Dratini',41,64,45,50,50,50,'5 Feet 11 Inches','7.3lbs',45,'Dragon Pokķmon',1250000,35,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (148,'Dragonair',61,84,65,70,70,70,'13 Feet 01 Inches','36.4lbs',45,'Dragon Pokémon',1250000,35,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (149,'Dragonite',91,134,95,100,100,80,'7 Feet 03 Inches','463.0lbs',45,'Dragon Pokémon',1250000,35,'Brown',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (150,'Mewtwo',106,110,90,154,90,130,'6 Feet 07 Inches','269.0lbs',3,'Genetic Pokémon',1250000,0,'Purple',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (151,'Mew',100,100,100,100,100,100,'1 Feet 04 Inches','8.8lbs',45,'New Specie Pokémon',1059860,100,'Pink',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (152,'Chikorita',45,49,65,49,65,45,'2 Feet 11 Inches','14.1lbs',45,'Leaf Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (153,'Bayleef',60,62,80,63,80,60,'3 Feet 11 Inches','34.8lbs',45,'Leaf Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (154,'Meganium',80,82,100,83,100,80,'5 Feet 11 Inches','221.6lbs',45,'Herb Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (155,'Cyndaquil',39,52,43,60,50,65,'1 Feet 08 Inches','17.4lbs',45,'Fire Mouse Pokémon',1059860,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (156,'Quilava',58,64,58,80,65,80,'2 Feet 11 Inches','41.9lbs',45,'Volcano Pokémon',1059860,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (157,'Typhlosion',78,84,78,109,85,100,'5 Feet 07 Inches','175.3lbs',45,'Volcano Pokémon',1059860,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (158,'Totodile',50,65,64,44,48,43,'2 Feet 00 Inches','20.9lbs',45,'Big Jaw Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (159,'Croconaw',65,80,80,59,63,58,'3 Feet 07 Inches','55.1lbs',45,'Big Jaw Pokķmon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (160,'Feraligatr',85,105,100,79,83,78,'7 Feet 07 Inches','195.8lbs',45,'Big Jaw Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (161,'Sentret',35,46,34,35,45,20,'2 Feet 07 Inches','13.2lbs',255,'Scout Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (162,'Furret',85,76,64,45,55,90,'5 Feet 11 Inches','71.6lbs',90,'Long Body Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (163,'Hoothoot',60,30,30,36,56,50,'2 Feet 04 Inches','46.7lbs',255,'Owl Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (164,'Noctowl',100,50,50,76,96,70,'5 Feet 03 Inches','89.9lbs',90,'Owl Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (165,'Ledyba',40,20,30,40,80,55,'3 Feet 03 Inches','23.8lbs',255,'Five Star Pokķmon',800000,70,'Red',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (166,'Ledian',55,35,50,55,110,85,'4 Feet 03 Inches','78.5lbs',90,'Five Star Pokémon',800000,70,'Red',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (167,'Spinarak',40,60,40,40,40,30,'1 Feet 08 Inches','18.7lbs',255,'String Spit Pokémon',800000,70,'Green',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (168,'Ariados',70,90,70,60,60,40,'3 Feet 07 Inches','73.9lbs',90,'Long Leg Pokémon',800000,70,'Red',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (169,'Crobat',85,90,80,70,80,130,'5 Feet 11 Inches','165.3lbs',90,'Bat Pokémon',1000000,70,'Purple',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (170,'Chinchou',75,38,38,56,56,67,'1 Feet 08 Inches','26.0lbs',190,'Angler Pokémon',1250000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (171,'Lanturn',125,58,58,76,76,67,'3 Feet 11 Inches','50.0lbs',75,'Light Pokķmon',1250000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (172,'Pichu',20,40,15,35,35,60,'1 Feet 00 Inches','4.0lbs',190,'Tiny Mouse Pokémon',1000000,70,'Yellow',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (173,'Cleffa',50,25,28,45,55,15,'1 Feet 00 Inches','6.6lbs',150,'Star Shape Pokémon',800000,140,'Pink',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (174,'Igglybuff',90,30,15,40,20,15,'1 Feet 00 Inches','2.0lbs',170,'Balloon Pokémon',800000,70,'Pink',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (175,'Togepi',35,20,65,40,65,20,'1 Feet 00 Inches','3.3lbs',190,'Spike Ball Pokémon',800000,70,'White',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (176,'Togetic',55,40,85,80,105,40,'2 Feet 00 Inches','7.1lbs',75,'Happiness Pokémon',800000,70,'White',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (177,'Natu',40,50,45,70,45,70,'0 Feet 08 Inches','4.0lbs',190,'Little Bird Pokémon',1000000,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (178,'Xatu',65,75,70,95,70,95,'4 Feet 11 Inches','33.0lbs',75,'Mystic Pokémon',1000000,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (179,'Mareep',55,40,40,65,45,35,'2 Feet 00 Inches','17.2lbs',235,'Wool Pokémon',1059860,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (180,'Flaaffy',70,55,55,80,60,45,'2 Feet 07 Inches','29.3lbs',120,'Wool Pokémon',1059860,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (181,'Ampharos',90,75,75,115,90,55,'4 Feet 07 Inches','135.6lbs',45,'Light Pokémon',1059860,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (182,'Bellossom',75,80,85,90,100,50,'1 Feet 04 Inches','13.0lbs',45,'Flower Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (183,'Marill',70,20,50,20,50,40,'1 Feet 04 Inches','18.0lbs',190,'Aquamouse Pokémon',800000,70,'Blue',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (184,'Azumarill',100,50,80,50,80,50,'2 Feet 07 Inches','63.0lbs',75,'Aquarabbit Pokémon',800000,70,'Blue',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (185,'Sudowoodo',70,100,115,30,65,30,'3 Feet 11 Inches','83.8lbs',65,'Imitation Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (186,'Politoed',90,75,75,90,100,70,'3 Feet 07 Inches','74.7lbs',45,'Frog Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (187,'Hoppip',35,35,40,35,55,50,'1 Feet 04 Inches','1.1lbs',255,'Cottonweed Pokémon',1059860,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (188,'Skiploom',55,45,50,45,65,80,'2 Feet 00 Inches','2.2lbs',120,'Cottonweed Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (189,'Jumpluff',75,55,70,55,85,110,'2 Feet 07 Inches','6.6lbs',45,'Cottonweed Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (190,'Aipom',55,70,55,40,55,85,'2 Feet 07 Inches','25.4lbs',45,'Long Tail Pokémon',800000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (191,'Sunkern',30,30,30,30,30,30,'1 Feet 00 Inches','4.0lbs',235,'Seed Pokémon',1059860,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (192,'Sunflora',75,75,55,105,85,30,'2 Feet 07 Inches','18.7lbs',120,'Sun Pokémon',1059860,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (193,'Yanma',65,65,45,75,45,95,'3 Feet 11 Inches','83.8lbs',75,'Clear Wing Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (194,'Wooper',55,45,45,25,25,15,'1 Feet 04 Inches','18.7lbs',255,'Water Fish PokÚmon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (195,'Quagsire',95,85,85,65,65,35,'4 Feet 07 Inches','165.3lbs',90,'Water Fish Pokķmon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (196,'Espeon',65,65,60,130,95,110,'2 Feet 11 Inches','58.4lbs',45,'Sun Pokémon',1000000,70,'Purple',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (197,'Umbreon',95,65,110,60,130,65,'3 Feet 03 Inches','59.5lbs',45,'Moonlight Pokémon',1000000,35,'Black',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (198,'Murkrow',60,85,42,85,42,91,'1 Feet 08 Inches','4.6lbs',30,'Darkness Pokémon',1059860,35,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (199,'Slowking',95,75,80,100,110,30,'6 Feet 07 Inches','175.3lbs',70,'Royal Pokémon',1000000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (200,'Misdreavus',60,60,60,85,85,85,'2 Feet 04 Inches','2.2lbs',45,'Screech Pokémon',800000,35,'Gray',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (201,'Unown',48,72,48,72,48,48,'1 Feet 08 Inches','11.0lbs',225,'Symbol Pokémon',1000000,70,'Black',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (202,'Wobbuffet',190,33,58,33,58,33,'4 Feet 03 Inches','63.0lbs',45,'Patient Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (203,'Girafarig',70,80,65,90,65,85,'4 Feet 11 Inches','91.0lbs',60,'Long Neck Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (204,'Pineco',50,65,90,35,35,15,'2 Feet 00 Inches','15.9lbs',190,'Bagworm Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (205,'Forretress',75,90,140,60,60,40,'3 Feet 11 Inches','277.3lbs',75,'Bagworm Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (206,'Dunsparce',100,70,70,65,65,45,'4 Feet 11 Inches','15.9lbs',190,'Land Snake Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (207,'Gligar',65,75,105,35,65,85,'3 Feet 07 Inches','142.9lbs',60,'Flyscorpion Pokémon',1059860,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (208,'Steelix',75,85,200,55,65,30,'30 Feet 02 Inches','881.8lbs',25,'Iron Snake Pokémon',1000000,70,'Gray',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (209,'Snubbull',60,80,50,40,40,30,'2 Feet 00 Inches','17.2lbs',190,'Fairy Pokémon',800000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (210,'Granbull',90,120,75,60,60,45,'4 Feet 07 Inches','107.4lbs',75,'Fairy Pokémon',800000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (211,'Qwilfish',65,95,75,55,55,85,'1 Feet 08 Inches','8.6lbs',45,'Balloon Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (212,'Scizor',70,130,100,55,80,65,'5 Feet 11 Inches','260.1lbs',25,'Pincer Pokémon',1000000,70,'Red',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (213,'Shuckle',20,10,230,10,230,5,'2 Feet 00 Inches','45.2lbs',190,'Mold Pokémon',1059860,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (214,'Heracross',80,125,75,40,95,85,'4 Feet 11 Inches','120.0lbs',45,'Singlehorn Pokémon',1250000,70,'Blue',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (215,'Sneasel',55,95,55,35,75,115,'2 Feet 11 Inches','61.7lbs',60,'Sharp Claw Pokémon',1059860,35,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (216,'Teddiursa',60,80,50,50,50,40,'2 Feet 00 Inches','19.4lbs',120,'Little Bear Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (217,'Ursaring',90,130,75,75,75,55,'5 Feet 11 Inches','277.3lbs',60,'Hibernator Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (218,'Slugma',40,40,40,70,40,20,'2 Feet 03 Inches','77.0lbs',190,'Lava Pokķmon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (219,'Magcargo',50,50,120,80,80,30,'2 Feet 07 Inches','121.0lbs',75,'Lava Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (220,'Swinub',50,50,40,30,30,50,'1 Feet 04 Inches','14.3lbs',225,'Pig Pokémon',1250000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (221,'Piloswine',100,100,80,60,60,50,'3 Feet 07 Inches','123.0lbs',75,'Swine Pokémon',1250000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (222,'Corsola',55,55,85,65,85,35,'2 Feet 00 Inches','11.0lbs',60,'Coral Pokķmon',800000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (223,'Remoraid',35,65,35,65,35,65,'2 Feet 00 Inches','26.5lbs',190,'Jet Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (224,'Octillery',75,105,75,105,75,45,'2 Feet 11 Inches','62.8lbs',75,'Jet Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (225,'Delibird',45,55,45,65,45,75,'2 Feet 11 Inches','35.3lbs',45,'Delivery Pokémon',800000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (226,'Mantine',65,40,70,80,140,70,'6 Feet 11 Inches','485.0lbs',25,'Kite Pokémon',1250000,70,'Purple',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (227,'Skarmory',65,80,140,40,70,70,'5 Feet 07 Inches','112.0lbs',25,'Armor Bird Pokémon',1250000,70,'Gray',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (228,'Houndour',45,60,30,80,50,65,'2 Feet 00 Inches','23.8lbs',120,'Dark Pokémon',1250000,35,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (229,'Houndoom',75,90,50,110,80,95,'4 Feet 07 Inches','77.2lbs',45,'Dark Pokémon',1250000,35,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (230,'Kingdra',75,95,95,95,95,85,'5 Feet 11 Inches','336.0lbs',45,'Dragon Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (231,'Phanpy',90,60,60,40,40,40,'1 Feet 08 Inches','74.0lbs',120,'Long Nose Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (232,'Donphan',90,120,120,60,60,50,'3 Feet 07 Inches','265.0lbs',60,'Armor Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (233,'Porygon2',85,80,90,105,95,60,'2 Feet 00 Inches','71.6lbs',45,'Virtual Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (234,'Stantler',73,95,62,85,65,85,'4 Feet 07 Inches','157.0lbs',45,'Big Horn Pokémon',1250000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (235,'Smeargle',55,20,35,20,45,75,'3 Feet 11 Inches','127.9lbs',45,'Painter Pokémon',800000,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (236,'Tyrogue',35,35,35,35,35,35,'2 Feet 04 Inches','16.3lbs',75,'Scuffle Pokémon',1000000,70,'Purple',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (237,'Hitmontop',50,95,95,35,110,70,'4 Feet 07 Inches','105.8lbs',45,'Handstand Pokémon',1000000,70,'Brown',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (238,'Smoochum',45,30,15,85,65,65,'1 Feet 04 Inches','13.2lbs',45,'Kiss Pokémon',1000000,70,'Pink',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (239,'Elekid',45,63,37,65,55,95,'2 Feet 00 Inches','51.8lbs',45,'Electric Pokémon',1000000,70,'Yellow',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (240,'Magby',45,75,37,70,55,83,'2 Feet 04 Inches','47.2lbs',45,'Live Coal Pokémon',1000000,70,'Red',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (241,'Miltank',95,80,105,40,70,100,'3 Feet 11 Inches','166.4lbs',45,'Milk Cow Pokémon',1250000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (242,'Blissey',255,10,10,75,135,55,'4 Feet 11 Inches','103.2lbs',30,'Happiness Pokémon',800000,140,'Pink',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (243,'Raikou',90,85,75,115,100,115,'6 Feet 03 Inches','392.4lbs',3,'Thunder Pokémon',1250000,35,'Yellow',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (244,'Entei',115,115,85,90,75,100,'6 Feet 11 Inches','436.5lbs',3,'Volcano Pokémon',1250000,35,'Brown',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (245,'Suicune',100,75,115,90,115,85,'6 Feet 07 Inches','412.3lbs',3,'Aurora Pokémon',1250000,35,'Blue',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (246,'Larvitar',50,64,50,45,50,41,'2 Feet 00 Inches','158.7lbs',45,'Rock Skin Pokémon',1250000,35,'Green',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (247,'Pupitar',70,84,70,65,70,51,'3 Feet 11 Inches','335.1lbs',45,'Hard Shell Pokémon',1250000,35,'Gray',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (248,'Tyranitar',100,134,110,95,100,61,'6 Feet 07 Inches','445.3lbs',45,'Armor Pokémon',1250000,35,'Green',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (249,'Lugia',106,90,130,90,154,110,'17 Feet 10 Inches','476.2lbs',3,'Diving Pokémon',1250000,0,'White',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (250,'Ho-oh',106,130,90,110,154,90,'12 Feet 06 Inches','438.7lbs',3,'Rainbow Pokémon',1250000,0,'Red',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (251,'Celebi',100,100,100,100,100,100,'2 Feet 00 Inches','11.0lbs',45,'Time Travel Pokémon',1059860,100,'Green',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (252,'Treecko',40,45,35,65,55,70,'1 Feet 08 Inches','11.0lbs',45,'Wood Gecko Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (253,'Grovyle',50,65,45,85,65,95,'2 Feet 11 Inches','47.6lbs',45,'Wood Gecko Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (254,'Sceptile',70,85,65,105,85,120,'5 Feet 07 Inches','115.1lbs',45,'Forest Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (255,'Torchic',45,60,40,70,50,45,'1 Feet 04 Inches','5.5lbs',45,'Chick PokÚmon',1059860,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (256,'Combusken',60,85,60,85,60,55,'2 Feet 11 Inches','43.0lbs',45,'Young Fowl Pokémon',1059860,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (257,'Blaziken',80,120,70,110,70,80,'6 Feet 3 Inches','114.6lbs',45,'Blaze Pokémon',1059860,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (258,'Mudkip',50,70,50,50,50,40,'1 Feet 4 Inches','16.8lbs',45,'Mud Fish Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (259,'Marshtomp',70,85,70,60,70,50,'2 Feet 4 Inches','61.7lbs',45,'Mud Fish Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (260,'Swampert',100,110,90,85,90,60,'4 Feet 11 Inches','180.6lbs',45,'Mud Fish Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (261,'Poochyena',35,55,35,30,30,35,'1 Feet 08 Inches','30.0lbs',255,'Bite Pokémon',1000000,70,'Gray',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (262,'Mightyena',70,90,70,60,60,70,'3 Feet 03 Inches','81.6lbs',127,'Bite Pokémon',1000000,70,'Gray',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (263,'Zigzagoon',38,30,41,30,41,60,'1 Feet 04 Inches','38.6lbs',255,'Tinyracoon Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (264,'Linoone',78,70,61,50,61,100,'1 Feet 08 Inches','71.6lbs',90,'Rush Pokémon',1000000,70,'White',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (265,'Wurmple',45,45,35,20,30,20,'1 Feet 00 Inches','7.9lbs',255,'Worm Pokémon',1000000,70,'Red',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (266,'Silcoon',50,35,55,25,25,15,'2 Feet 00 Inches','22.0lbs',120,'Cocoon Pokémon',1000000,70,'White',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (267,'Beautifly',60,70,50,90,50,65,'3 Feet 03 Inches','62.6lbs',45,'Butterfly Pokémon',1000000,70,'Yellow',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (268,'Cascoon',50,35,55,25,25,15,'2 Feet 04 Inches','25.4lbs',120,'Cocoon Pokémon',1000000,70,'Purple',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (269,'Dustox',60,50,70,50,90,65,'3 Feet 11 Inches','69.7lbs',45,'Poison Moth Pokémon',1000000,70,'Green',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (270,'Lotad',40,30,30,40,50,30,'1 Feet 08 Inches','5.7lbs',255,'Water Weed Pokķmon',1059860,70,'Green',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (271,'Lombre',60,50,50,60,70,50,'3 Feet 11 Inches','71.6lbs',120,'Jolly Pokémon',1059860,70,'Green',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (272,'Ludicolo',80,70,70,90,100,70,'4 Feet 11 Inches','121.3lbs',45,'Carefree Pokķmon',1059860,70,'Green',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (273,'Seedot',40,40,50,30,30,30,'1 Feet 08 Inches','8.8lbs',255,'Acorn Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (274,'Nuzleaf',70,70,40,60,40,60,'3 Feet 03 Inches','61.7lbs',120,'Wily Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (275,'Shiftry',90,100,60,90,60,80,'4 Feet 03 Inches','131.4lbs',45,'Wickid Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (276,'Taillow',40,55,30,30,30,85,'1 Feet 00 Inches','5.1lbs',200,'TinySwallow Pokémon',1059860,70,'Blue',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (277,'Swellow',60,85,60,50,50,125,'2 Feet 04 Inches','43.7lbs',45,'Swallow Pokémon',1059860,70,'Blue',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (278,'Wingull',40,30,30,55,30,85,'2 Feet 00 Inches','20.9lbs',190,'Seagull Pokémon',1000000,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (279,'Pelipper',60,50,100,85,70,65,'3 Feet 11 Inches','61.7lbs',45,'Water Bird Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (280,'Ralts',28,25,25,45,35,40,'1 Feet 04 Inches','14.6lbs',235,'Feeling Pokémon',1250000,35,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (281,'Kirlia',38,35,35,65,55,50,'2 Feet 07 Inches','44.5lbs',120,'Emotion Pokémon',1250000,35,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (282,'Gardevoir',68,65,65,125,115,80,'5 Feet 03 Inches','106.7lbs',45,'Embrace Pokémon',1250000,35,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (283,'Surskit',40,30,32,50,52,65,'1 Feet 08 Inches','3.7lbs',200,'Pond Skater Pokémon',1000000,70,'Blue',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (284,'Masquerain',70,60,62,80,82,60,'2 Feet 07 Inches','7.9lbs',75,'Eyeball Pokémon',1000000,70,'Blue',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (285,'Shroomish',60,40,60,40,60,35,'1 Feet 04 Inches','9.9lbs',255,'Mushroom Pokémon',1640000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (286,'Breloom',60,130,80,60,60,70,'3 Feet 11 Inches','86.4lbs',90,'Mushroom Pokémon',1640000,70,'Green',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (287,'Slakoth',60,60,60,35,35,30,'2 Feet 07 Inches','52.9lbs',255,'Slacker Pokémon',1250000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (288,'Vigoroth',80,80,80,55,55,90,'4 Feet 07 Inches','102.5lbs',120,'Wild Monkey Pokémon',1250000,70,'White',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (289,'Slaking',150,160,100,95,65,100,'6 Feet 07 Inches','287.7lbs',45,'Lazy Pokémon',1250000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (290,'Nincada',31,45,90,30,30,40,'1 Feet 08 Inches','12.1lbs',255,'Trainee Pokémon',600000,70,'Gray',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (291,'Ninjask',61,90,45,50,50,160,'2 Feet 07 Inches','26.5lbs',120,'Ninja Pokémon',600000,70,'Yellow',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (292,'Shedinja',1,90,45,30,30,40,'2 Feet 07 Inches','2.6lbs',45,'Shed Pokémon',600000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (293,'Whismur',64,51,23,51,23,28,'2 Feet 00 Inches','35.9lbs',190,'Whisper Pokémon',1059860,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (294,'Loudred',84,71,43,71,43,48,'3 Feet 03 Inches','89.3lbs',120,'Big Voice Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (295,'Exploud',104,91,63,91,63,68,'4 Feet 11 Inches','185.2lbs',45,'Loud Noise Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (296,'Makuhita',72,60,30,20,30,25,'3 Feet 03 Inches','190.5lbs',180,'Guts Pokémon',1640000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (297,'Hariyama',144,120,60,40,60,50,'7 Feet 07 Inches','559.5lbs',200,'Arm Thrust Pokémon',1640000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (298,'Azurill',50,20,40,20,40,20,'0 Feet 08 Inches','4.4lbs',150,'Polka Dot Pokémon',800000,70,'Blue',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (299,'Nosepass',30,45,135,45,90,30,'3 Feet 03 Inches','213.8lbs',255,'Compass Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (300,'Skitty',50,45,45,35,35,50,'2 Feet 00 Inches','24.3lbs',255,'Kitten Pokķmon',800000,70,'Pink',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (301,'Delcatty',70,65,65,55,55,70,'3 Feet 07 Inches','71.9lbs',60,'Prim Pokémon',800000,70,'Purple',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (302,'Sableye',50,75,75,65,65,50,'1 Feet 08 Inches','24.3lbs',45,'Darkness Pokémon',1059860,35,'Purple',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (303,'Mawile',50,85,85,55,55,50,'2 Feet 00 Inches','25.4lbs',45,'Deceiver Pokémon',800000,70,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (304,'Aron',50,70,100,40,40,30,'1 Feet 04 Inches','132.3lbs',180,'Iron Armor Pokémon',1250000,35,'Gray',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (305,'Lairon',60,90,140,50,50,40,'2 Feet 11 Inches','264.6lbs',90,'Iron Armor Pokémon',1250000,35,'Gray',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (306,'Aggron',70,110,180,60,60,50,'6 Feet 11 Inches','793.7lbs',45,'Iron Armor Pokémon',1250000,35,'Gray',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (307,'Meditite',30,40,55,40,55,60,'2 Feet 00 Inches','24.7lbs',180,'Meditate Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (308,'Medicham',60,60,75,60,75,80,'4 Feet 03 Inches','69.4lbs',90,'Meditate Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (309,'Electrike',40,45,40,65,40,65,'2 Feet 00 Inches','33.5lbs',120,'Lightning Pokémon',1250000,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (310,'Manectric',70,75,60,105,60,105,'4 Feet 11 Inches','88.6lbs',45,'Discharge Pokémon',1250000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (311,'Plusle',60,50,40,85,75,95,'1 Feet 04 Inches','9.3lbs',200,'Cheering Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (312,'Minun',60,40,50,75,85,95,'1 Feet 04 Inches','9.3lbs',200,'Cheering Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (313,'Volbeat',65,73,55,47,75,85,'2 Feet 04 Inches','39.0lbs',150,'Firefly Pokémon',600000,70,'Gray',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (314,'Illumise',65,47,55,73,75,85,'2 Feet 00 Inches','39.0lbs',150,'Firefly Pokémon',1640000,70,'Purple',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (315,'Roselia',50,60,45,100,80,65,'1 Feet 00 Inches','4.4lbs',150,'Thorn Pokķmon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (316,'Gulpin',70,43,53,43,53,40,'1 Feet 04 Inches','22.7lbs',225,'Stomach Pokémon',1640000,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (317,'Swalot',100,73,83,73,83,55,'5 Feet 07 Inches','176.4lbs',75,'Poison Bag Pokémon',1640000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (318,'Carvanha',45,90,20,65,20,65,'2 Feet 07 Inches','45.9lbs',225,'Savage Pokémon',1250000,35,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (319,'Sharpedo',70,120,40,95,40,95,'5 Feet 11 Inches','195.8lbs',60,'Brutal Pokķmon',1250000,35,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (320,'Wailmer',130,70,35,70,35,60,'6 Feet 07 Inches','286.6lbs',125,'Ball Whale PokÚmon',1640000,70,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (321,'Wailord',170,90,45,90,45,60,'47 Feet 07 Inches','877.4lbs',60,'Float Whale Pokémon',1640000,70,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (322,'Numel',60,60,40,65,45,35,'2 Feet 04 Inches','52.9lbs',255,'Numb Pokémon',1000000,70,'Yellow',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (323,'Camerupt',70,100,70,105,75,40,'6 Feet 03 Inches','485.0lbs',150,'Eruption Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (324,'Torkoal',70,85,140,85,70,20,'1 Feet 08 Inches','177.2lbs',90,'Coal Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (325,'Spoink',60,25,35,70,80,60,'2 Feet 04 Inches','67.5lbs',255,'Bounce Pokémon',800000,70,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (326,'Grumpig',80,45,65,90,110,80,'2 Feet 11 Inches','157.6lbs',60,'Manipulate Pokémon',800000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (327,'Spinda',60,60,60,60,60,60,'3 Feet 07 Inches','11.0lbs',255,'Spot Panda Pokémon',800000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (328,'Trapinch',45,100,45,45,45,10,'2 Feet 04 Inches','33.1lbs',255,'Ant Pit Pokémon',1059860,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (329,'Vibrava',50,70,50,50,50,70,'3 Feet 07 Inches','33.7lbs',120,'Vibration Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (330,'Flygon',80,100,80,80,80,100,'6 Feet 07 Inches','180.8lbs',45,'Mystic Pokķmon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (331,'Cacnea',50,85,40,85,40,35,'1 Feet 04 Inches','113.1lbs',190,'Cactus Pokémon',1059860,35,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (332,'Cacturne',70,115,60,115,60,55,'4 Feet 03 Inches','170.6lbs',60,'Scarecrow Pokémon',1059860,35,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (333,'Swablu',45,40,60,40,75,50,'1 Feet 04 Inches','2.6lbs',255,'Cotton Bird Pokķmon',600000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (334,'Altaria',75,70,90,70,105,80,'3 Feet 07 Inches','45.4lbs',45,'Humming Pokémon',600000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (335,'Zangoose',73,115,60,60,60,90,'4 Feet 03 Inches','88.8lbs',90,'Cat Ferret Pokémon',600000,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (336,'Seviper',73,100,60,100,60,65,'8 Feet 10 Inches','115.7lbs',90,'Fang Snake Pokémon',1640000,70,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (337,'Lunatone',70,55,65,95,85,70,'3 Feet 03 Inches','370.4lbs',45,'Meteorite Pokémon',800000,70,'Yellow',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (338,'Solrock',70,95,85,55,65,70,'3 Feet 11 Inches','339.5lbs',45,'Meteorite Pokémon',800000,70,'Red',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (339,'Barboach',50,48,43,46,41,60,'1 Feet 04 Inches','4.2lbs',190,'Whiskers Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (340,'Whiscash',110,78,73,76,71,60,'2 Feet 11 Inches','52.0lbs',75,'Whiskers Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (341,'Corphish',43,80,65,50,35,35,'2 Feet 00 Inches','25.4lbs',205,'Ruffian Pokémon',1640000,70,'Red',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (342,'Crawdaunt',63,120,85,90,55,55,'3 Feet 07 Inches','72.3lbs',155,'Rogue Pokémon',1640000,70,'Red',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (343,'Baltoy',40,40,55,40,70,55,'1 Feet 08 Inches','47.4lbs',255,'Clay Doll Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (344,'Claydol',60,70,105,70,120,75,'4 Feet 11 Inches','238.1lbs',90,'Clay Doll Pokémon',1000000,70,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (345,'Lileep',66,41,77,61,87,23,'3 Feet 03 Inches','52.5lbs',45,'Sea Lily Pokémon',600000,70,'Purple',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (346,'Cradily',86,81,97,81,107,43,'4 Feet 11 Inches','133.2lbs',45,'Barnacle Pokémon',600000,70,'Green',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (347,'Anorith',45,95,50,40,50,75,'2 Feet 04 Inches','27.6lbs',45,'Old Shrimp Pokémon',600000,70,'Gray',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (348,'Armaldo',75,125,100,70,80,45,'4 Feet 11 Inches','150.4lbs',45,'Plate Pokémon',600000,70,'Gray',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (349,'Feebas',20,15,20,10,55,80,'2 Feet 00 Inches','16.3lbs',255,'Fish Pokémon',600000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (350,'Milotic',95,60,79,100,125,81,'20 Feet 04 Inches','357.1lbs',60,'Tender Pokémon',600000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (351,'Castform',70,70,70,70,70,70,'1 Feet 04 Inches','1.8lbs',45,'Weather Pokémon',1000000,70,'White',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (352,'Kecleon',60,90,70,60,120,40,'3 Feet 03 Inches','48.5lbs',200,'Color Swap Pokķmon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (353,'Shuppet',44,75,35,63,33,45,'2 Feet 00 Inches','5.1lbs',225,'Puppet Pokémon',800000,35,'Black',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (354,'Banette',64,115,65,83,63,65,'3 Feet 07 Inches','27.6lbs',45,'Marionette Pokémon',800000,35,'Black',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (355,'Duskull',20,40,90,30,90,25,'2 Feet 07 Inches','33.1lbs',190,'Requiem Pokémon',800000,35,'Black',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (356,'Dusclops',40,70,130,60,130,25,'5 Feet 03 Inches','67.5lbs',90,'Beckon Pokķmon',800000,35,'Black',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (357,'Tropius',99,68,83,72,87,51,'6 Feet 07 Inches','220.5lbs',200,'Fruit Pokémon',1250000,70,'Green',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (358,'Chimecho',65,50,70,95,80,65,'2 Feet 00 Inches','2.2lbs',45,'Wind Chime Pokémon',800000,70,'Blue',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (359,'Absol',65,130,60,75,60,75,'3 Feet 11 Inches','103.6lbs',30,'Disaster Pokémon',1059860,35,'White',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (360,'Wynaut',95,23,48,23,48,23,'2 Feet 00 Inches','30.9lbs',125,'Bright Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (361,'Snorunt',50,50,50,50,50,50,'2 Feet 04 Inches','37.0lbs',190,'Snow Hat Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (362,'Glalie',80,80,80,80,80,80,'4 Feet 11 Inches','565.5lbs',75,'Face Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (363,'Spheal',70,40,50,55,50,25,'2 Feet 07 Inches','87.1lbs',255,'Clap Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (364,'Sealeo',90,60,70,75,70,45,'3 Feet 07 Inches','193.1lbs',120,'Ball Roll Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (365,'Walrein',110,80,90,95,90,65,'4 Feet 07 Inches','332.0lbs',45,'Ice Break Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (366,'Clamperl',35,64,85,74,55,32,'1 Feet 04 Inches','115.7lbs',255,'Bivalve Pokémon',600000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (367,'Huntail',55,104,105,94,75,52,'5 Feet 07 Inches','59.5lbs',60,'Deep Sea Pokémon',600000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (368,'Gorebyss',55,84,105,114,75,52,'5 Feet 11 Inches','49.8lbs',60,'South Sea Pokémon',600000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (369,'Relicanth',100,90,130,45,65,55,'3 Feet 03 Inches','51.6lbs',25,'Longevity Pokémon',1250000,70,'Gray',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (370,'Luvdisc',43,30,55,40,65,97,'2 Feet 00 Inches','19.2lbs',225,'Rendezvous Pokémon',800000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (371,'Bagon',45,75,60,40,30,50,'2 Feet 00 Inches','92.8lbs',45,'Rock Head Pokémon',1250000,35,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (372,'Shelgon',65,95,100,60,50,50,'3 Feet 07 Inches','243.6lbs',45,'Endurance Pokémon',1250000,35,'White',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (373,'Salamence',95,135,80,110,80,100,'4 Feet 11 Inches','226.2lbs',45,'Dragon Pokémon',1250000,35,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (374,'Beldum',40,55,80,35,60,30,'2 Feet 00 Inches','209.9lbs',3,'Iron Ball Pokémon',1250000,35,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (375,'Metang',60,75,100,55,80,50,'3 Feet 11 Inches','446.4lbs',3,'Iron Claw Pokķmon',1250000,35,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (376,'Metagross',80,135,130,95,90,70,'5 Feet 03 Inches','1,212.5lbs',3,'Iron Leg Pokémon',1250000,35,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (377,'Regirock',80,100,200,50,100,50,'5 Feet 07 Inches','507.1lbs',3,'Rock Peak Pokémon',1250000,35,'Brown',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (378,'Regice',80,50,100,100,200,50,'5 Feet 11 Inches','385.8lbs',3,'Iceberg Pokémon',1250000,35,'Blue',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (379,'Registeel',80,75,150,75,150,50,'6 Feet 03 Inches','451.9lbs',3,'Iron Pokémon',1250000,35,'Gray',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (380,'Latias',80,80,90,110,130,110,'4 Feet 07 Inches','88.2lbs',3,'Eon Pokémon',1250000,90,'Red',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (381,'Latios',80,90,80,130,110,110,'6 Feet 07 Inches','132.3lbs',3,'Eon Pokémon',1250000,90,'Blue',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (382,'Kyogre',100,100,90,150,140,90,'14 Feet 09 Inches','776.0lbs',5,'Sea Basin Pokémon',1250000,0,'Blue',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (383,'Groudon',100,150,140,100,90,90,'11 Feet 06 Inches','2,094.4lbs',5,'Continent Pokémon',1250000,0,'Red',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (384,'Rayquaza',105,150,90,150,90,95,'23 Feet 00 Inches','455.2lbs',3,'Sky High Pokémon',1250000,0,'Green',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (385,'Jirachi',100,100,100,100,100,100,'1 Feet 00 Inches','2.4lbs',3,'Wish Pokémon',1250000,100,'Yellow',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (386,'Deoxys',50,150,50,150,50,150,'5 Feet 05 Inches','134.0lbs',3,'DNA Pokémon',1250000,0,'Red',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (387,'Turtwig',55,68,64,45,55,31,'1 Feet 03 Inches','22.5lbs',45,'Tiny Leaf Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (388,'Grotle',75,89,85,55,65,36,'3 Feet 07 Inches','214lbs',45,'Grove Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (389,'Torterra',95,109,105,75,85,56,'7 Feet 03 Inches','683.5lbs',45,'Continent Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (390,'Chimchar',44,58,44,58,44,61,'1 Feet 07 Inches','14.0lbs',45,'Chimp Pokémon',1059860,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (391,'Monferno',64,78,52,78,52,81,'2 Feet 11 Inches','48.5lbs',45,'Playful Pokémon',1059860,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (392,'Infernape',76,104,71,104,71,108,'3 Feet 11 Inches','121.0lbs',45,'Flame Pokémon',1059860,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (393,'Piplup',53,51,53,61,56,40,'1 Feet 03 Inches','11.5lbs',45,'Penguin Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (394,'Prinplup',64,66,68,81,76,50,'2 Feet 07 Inches','50.8lbs',45,'Penguin Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (395,'Empoleon',84,86,88,111,101,60,'5 Feet 07 Inches','186.3lbs',45,'Emperor Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (396,'Starly',40,55,30,30,30,60,'1 Feet 00 Inches','4.4lbs',255,'Starling Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (397,'Staravia',55,75,50,40,40,80,'2 Feet 00 Inches','34.2lbs',120,'Starling Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (398,'Staraptor',85,120,70,50,50,100,'3 Feet 11 Inches','55.0lbs',45,'Predator Pokémon',1059860,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (399,'Bidoof',59,45,40,35,40,31,'1 Feet 08 Inches','44.0lbs',255,'Plump Mouse Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (400,'Bibarel',79,85,60,55,60,71,'3 Feet 03 Inches','69.4lbs',127,'Beaver Pokémon',1000000,70,'Brown',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (401,'Kricketot',37,25,41,25,41,25,'1 Feet 00 Inches','5.0lbs',255,'Cricket Pokémon',1059860,70,'Red',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (402,'Kricketune',77,85,51,55,51,65,'3 Feet 03 Inches','56.2lbs',45,'Cricket Pokémon',1059860,70,'Red',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (403,'Shinx',45,65,34,40,34,45,'1 Feet 08 Inches','21.0lbs',235,'Flash PokÚmon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (404,'Luxio',60,85,49,60,49,60,'2 Feet 11 Inches','67.2lbs',120,'Spark Pokémon',1059860,100,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (405,'Luxray',80,120,79,95,79,70,'4 Feet 07 Inches','92.6lbs',45,'Gleam Eyes Pokémon',1059860,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (406,'Budew',40,30,35,50,70,55,'0 Feet 08 Inches','2.6lbs',255,'Bud Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (407,'Roserade',60,70,55,125,105,90,'2 Feet 11 Inches','32.0lbs',75,'Bouquet Pokémon',1059860,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (408,'Cranidos',67,125,40,30,30,58,'2 Feet 11 Inches','69.4lbs',45,'Head Butt Pokémon',600000,70,'Blue',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (409,'Rampardos',97,165,60,65,50,58,'5 Feet 03 Inches','226.0lbs',45,'Head Butt Pokémon',600000,70,'Blue',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (410,'Shieldon',30,42,118,42,88,30,'1 Feet 08 Inches','125.7lbs',45,'Shield Pokémon',600000,70,'Gray',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (411,'Bastiodon',60,52,168,47,138,30,'4 Feet 03 Inches','329.6lbs',45,'Shield Pokémon',600000,70,'Gray',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (412,'Burmy',40,29,45,29,45,36,'0 Feet 08 Inches','7.5lbs',120,'Bagworm Pokémon',1000000,70,'Gray',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (413,'Wormadam',60,59,85,79,105,36,'1 Feet 08 Inches','14.3lbs',45,'Bagworm Pokémon',1000000,70,'Gray',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (414,'Mothim',70,94,50,94,50,66,'2 Feet 11 Inches','51.4lbs',45,'Moth Pokķmon',1000000,70,'Yellow',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (415,'Combee',30,30,42,30,42,70,'1 Feet 00 Inches','12.1lbs',120,'Tiny Bee Pokémon',1059860,70,'Yellow',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (416,'Vespiquen',70,80,102,80,102,40,'3 Feet 11 Inches','84.9lbs',45,'Beehive Pokémon',1059860,70,'Yellow',3840);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (417,'Pachirisu',60,45,70,45,90,95,'1 Feet 04 Inches','8.6lbs',200,'EleSquirrel Pokémon',1000000,100,'White',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (418,'Buizel',55,65,35,60,30,85,'2 Feet 04 Inches','65.0lbs',190,'Sea Weasel Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (419,'Floatzel',85,105,55,85,50,115,'3 Feet 07 Inches','73.9lbs',75,'Sea Weasel Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (420,'Cherubi',45,35,45,62,53,35,'1 Feet 04 Inches','7.3lbs',190,'Cherry Pokémon',1000000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (421,'Cherrim',70,60,70,87,78,85,'1 Feet 08 Inches','20.5lbs',75,'Blossom Pokémon',1000000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (422,'Shellos',76,48,48,57,62,34,'1 Feet 00 Inches','13.9lbs',190,'Sea Slug Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (423,'Gastrodon',111,83,68,92,82,39,'2 Feet 11 Inches','65.9lbs',75,'Sea Slug Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (424,'Ambipom',75,100,66,60,66,115,'3 Feet 11 Inches','44.8lbs',45,'Long Tail Pokémon',800000,100,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (425,'Drifloon',90,50,34,60,44,70,'1 Feet 04 Inches','2.6lbs',125,'Balloon Pokķmon',1640000,70,'Purple',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (426,'Drifblim',150,80,44,90,54,80,'3 Feet 11 Inches','33.1lbs',60,'Blimp Pokémon',1640000,70,'Purple',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (427,'Buneary',55,66,44,44,56,85,'1 Feet 04 Inches','12.1lbs',190,'Rabbit Pokémon',1000000,0,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (428,'Lopunny',65,76,84,54,96,105,'3 Feet 11 Inches','73.4lbs',60,'Rabbit Pokémon',1000000,140,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (429,'Mismagius',60,60,60,105,105,105,'2 Feet 11 Inches','9.7lbs',45,'Magical Pokémon',800000,35,'Purple',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (430,'Honchkrow',100,125,52,105,52,71,'2 Feet 11 Inches','60.2lbs',30,'Big Boss Pokķmon',1059860,35,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (431,'Glameow',49,55,42,42,37,85,'1 Feet 08 Inches','8.6lbs',190,'Catty Pokķmon',800000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (432,'Purugly',71,82,64,64,59,112,'3 Feet 03 Inches','96.6lbs',75,'Tiger Cat Pokémon',800000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (433,'Chingling',45,30,50,65,50,45,'0 Feet 08 Inches','1.3lbs',120,'Bell Pokémon',800000,70,'Yellow',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (434,'Stunky',63,63,47,41,41,74,'1 Feet 04 Inches','42.3lbs',225,'Skunk Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (435,'Skuntank',103,93,67,71,61,84,'3 Feet 03 Inches','83.8lbs',60,'Skunk Pokémon',1000000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (436,'Bronzor',57,24,86,24,86,23,'1 Feet 08 Inches','133.4lbs',255,'Bronze Pokémon',1000000,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (437,'Bronzong',67,89,116,79,116,33,'4 Feet 03 Inches','412.3lbs',90,'Bronze Bell Pokémon',1000000,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (438,'Bonsly',50,80,95,10,45,10,'1 Feet 08 Inches','33.0lbs',255,'Bonsai Pokémon',1000000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (439,'Mime Jr.',20,25,45,70,90,60,'2 Feet 00 Inches','28.6lbs',145,'Mime Pokémon',1000000,70,'Pink',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (440,'Happiny',100,5,5,15,65,30,'2 Feet 00 Inches','53.8lbs',130,'Playhouse Pokķmon',800000,140,'Pink',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (441,'Chatot',76,65,45,92,42,91,'1 Feet 08 Inches','4.0lbs',30,'Music Note Pokémon',1059860,35,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (442,'Spiritomb',50,92,108,92,108,35,'3 Feet 03 Inches','238.1lbs',100,'Forbidden Pokémon',1000000,70,'Purple',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (443,'Gible',58,70,45,40,45,42,'2 Feet 04 Inches','45.2lbs',45,'Land Shark Pokémon',1250000,70,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (444,'Gabite',68,90,65,50,55,82,'4 Feet 07 Inches','123.5lbs',45,'Cave Pokémon',1250000,70,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (445,'Garchomp',108,130,95,80,85,102,'6 Feet 03 Inches','209.4lbs',45,'Mach Pokémon',1250000,70,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (446,'Munchlax',135,85,40,40,85,5,'2 Feet 00 Inches','231.0lbs',50,'Big Eater Pokémon',1250000,70,'Black',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (447,'Riolu',40,70,40,35,40,60,'2 Feet 04 Inches','44.5lbs',75,'Emanation Pokémon',1059860,70,'Blue',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (448,'Lucario',70,110,70,115,70,90,'4 Feet 00 Inches','119.0lbs',45,'Aura Pokémon',1059860,70,'Blue',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (449,'Hippopotas',68,72,78,38,42,32,'2 Feet 07 Inches','109.1lbs',140,'Hippo Pokémon',1250000,70,'Brown',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (450,'Hippowdon',108,112,118,68,72,47,'6 Feet 07 Inches','661.4lbs',60,'Heavyweight Pokémon',1250000,70,'Brown',7680);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (451,'Skorupi',40,50,90,30,55,65,'2 Feet 07 Inches','26.5lbs',120,'Scorpion Pokémon',1250000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (452,'Drapion',70,90,110,60,75,95,'4 Feet 03 Inches','135.6lbs',45,'Ogre Scorp Pokémon',1250000,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (453,'Croagunk',48,61,40,61,40,50,'2 Feet 04 Inches','50.7lbs',140,'Toxic Mouth Pokémon',1000000,100,'Blue',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (454,'Toxicroak',83,106,65,86,65,85,'4 Feet 03 Inches','97.9lbs',75,'Toxic Mouth Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (455,'Carnivine',74,100,72,90,72,46,'4 Feet 07 Inches','59.5lbs',200,'Bug Catcher Pokémon',1250000,70,'Green',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (456,'Finneon',49,49,56,49,61,66,'1 Feet 04 Inches','15.4lbs',190,'Wing Fish Pokémon',600000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (457,'Lumineon',69,69,76,69,86,91,'3 Feet 11 Inches','53.9lbs',75,'Neon Pokémon',600000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (458,'Mantyke',45,20,50,60,120,50,'3 Feet 03 Inches','145.5lbs',25,'Kite Pokémon',1250000,70,'Blue',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (459,'Snover',60,62,50,62,60,40,'3 Feet 03 Inches','111.3lbs',120,'Frosted Tree Pokémon',1250000,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (460,'Abomasnow',90,92,75,92,85,60,'7 Feet 03 Inches','298.7lbs',60,'Frosted Tree Pokémon',1250000,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (461,'Weavile',70,120,65,45,85,125,'3 Feet 08 Inches','75.0lbs',45,'Sharp Claw Pokémon',1059860,35,'Black',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (462,'Magnezone',70,70,115,130,90,60,'3 Feet 11 Inches','396.8lbs',30,'Magnet Area Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (463,'Lickilicky',110,85,95,80,95,50,'5 Feet 07 Inches','308.6lbs',30,'Licking Pokémon',1000000,70,'Pink',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (464,'Rhyperior',115,140,130,55,55,40,'7 Feet 10 Inches','623.5lbs',30,'Drill Pokémon',1250000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (465,'Tangrowth',100,100,125,110,50,50,'6 Feet 07 Inches','283.5lbs',30,'Vine Pokémon',1000000,70,'Blue',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (466,'Electivire',75,123,67,95,85,95,'5 Feet 11 Inches','305.6lbs',30,'Thunderbolt Pokémon',1000000,70,'Yellow',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (467,'Magmortar',75,95,67,125,95,83,'5 Feet 03 Inches','149.9lbs',30,'Blast Pokémon',1000000,70,'Red',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (468,'Togekiss',85,50,95,120,115,80,'4 Feet 11 Inches','83.8lbs',30,'Jubilee Pokémon',800000,70,'White',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (469,'Yanmega',86,76,86,116,56,95,'6 Feet 03 Inches','113.5lbs',30,'Ogre Darner Pokémon',1000000,70,'Green',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (470,'Leafeon',65,110,130,60,65,95,'3 Feet 03 Inches','56.2lbs',45,'Verdant Pokémon',1000000,35,'Green',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (471,'Glaceon',65,60,110,130,95,65,'2 Feet 07 Inches','57.1lbs',45,'Fresh Snow Pokémon',1000000,35,'Blue',8960);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (472,'Gliscor',75,95,125,45,75,95,'6 Feet 07 Inches','93.5lbs',30,'Fang Scorp Pokémon',1059860,70,'Purple',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (473,'Mamoswine',110,130,80,70,60,80,'8 Feet 02 Inches','641.5lbs',50,'Twin Tusk Pokémon',1250000,70,'Brown',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (474,'Porygon-Z',85,80,70,135,75,90,'2 Feet 11 Inches','75.0lbs',30,'Virtual Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (475,'Gallade',68,125,65,65,115,80,'5 Feet 03 Inches','114.6lbs',45,'Blade Pokémon',1250000,35,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (476,'Probopass',60,55,145,75,150,40,'4 Feet 07 Inches','749.6lbs',60,'Compass Pokémon',1000000,70,'Gray',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (477,'Dusknoir',45,100,135,65,135,45,'7 Feet 03 Inches','235.0lbs',45,'Gripper Pokémon',800000,35,'Black',6400);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (478,'Froslass',70,80,70,80,70,110,'4 Feet 03 Inches','58.6lbs',75,'Snow Land Pokémon',1000000,70,'White',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (479,'Rotom',50,50,77,95,77,91,'1 Feet 00 Inches','0.7lbs',45,'Plasma Pokémon',1000000,70,'Red',5120);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (480,'Uxie',75,75,130,75,130,95,'1 Feet 00 Inches','0.7lbs',3,'Knowledge Pokémon',1250000,140,'Yellow',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (481,'Mesprit',80,105,105,105,105,80,'1 Feet 00 Inches','0.7lbs',3,'Emotion Pokémon',1250000,140,'Pink',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (482,'Azelf',75,125,70,125,70,115,'1 Feet 00 Inches','0.7lbs',3,'Willpower Pokémon',1250000,140,'Blue',20480);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (483,'Dialga',100,120,120,150,100,90,'17 Feet 09 Inches','1505.7lbs',30,'Temporal Pokémon',1250000,0,'White',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (484,'Palkia',90,120,100,150,120,100,'13 Feet 09 Inches','740.8lbs',30,'Spatial Pokémon',1250000,0,'Purple',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (485,'Heatran',91,90,106,130,106,77,'5 Feet 07 Inches','948.0lbs',3,'Lava Dome Pokémon',1250000,100,'Brown',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (486,'Regigigas',110,160,110,80,110,100,'12 Feet 02 Inches','925.9lbs',3,'Colossal Pokémon',1250000,0,'White',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (487,'Giratina',150,100,120,100,120,90,'14 Feet 09 Inches','1653.5lbs',3,'Renegade Pokémon',1250000,0,'Black',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (488,'Cresselia',120,70,120,75,130,85,'4 Feet 11 Inches','188.7lbs',3,'Lunar Pokémon',1250000,100,'Yellow',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (489,'Phione',80,80,80,80,80,80,'1 Feet 04 Inches','6.8lbs',30,'Sea Drifter Pokémon',1250000,70,'Blue',10240);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (490,'Manaphy',100,100,100,100,100,100,'1 Feet 00 Inches','3.1lbs',3,'Seafaring Pokémon',1250000,70,'Blue',2560);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (491,'Darkrai',70,90,90,135,90,125,'4 Feet 11 Inches','111.3lbs',3,'Pitch-Black Pokémon',1250000,0,'Black',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (492,'Shaymin',100,100,100,100,100,100,'0 Feet 08 Inches','4.6lbs',45,'Gratitude Pokémon',1059860,100,'Green',30720);
INSERT INTO pokemon (dexNum,name,hp,atk,def,spa,spd,speed,height,weight,captureRate,classification,expGrowth,baseHappiness,colour,eggSteps) VALUES (493,'Arceus',120,120,120,120,120,120,'10 Feet 06 Inches','705.5lbs',3,'Alpha Pokémon',1250000,0,'Gray',30720);

INSERT INTO type (typeName) VALUES('Bug');
INSERT INTO type (typeName) VALUES('Dark');
INSERT INTO type (typeName) VALUES('Dragon');
INSERT INTO type (typeName) VALUES('Electric');
INSERT INTO type (typeName) VALUES('Fighting');
INSERT INTO type (typeName) VALUES('Fire');
INSERT INTO type (typeName) VALUES('Flying');
INSERT INTO type (typeName) VALUES('Ghost');
INSERT INTO type (typeName) VALUES('Grass');
INSERT INTO type (typeName) VALUES('Ground');
INSERT INTO type (typeName) VALUES('Ice');
INSERT INTO type (typeName) VALUES('Normal');
INSERT INTO type (typeName) VALUES('Poison');
INSERT INTO type (typeName) VALUES('Psychic');
INSERT INTO type (typeName) VALUES('Rock');
INSERT INTO type (typeName) VALUES('Steel');
INSERT INTO type (typeName) VALUES('Water');

INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Absorb',20,100,'User recovers half the damage inflicted.','Points +3 if two pokemon raise a judges voltage consecutively','special',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Acid',40,100,'May lower opponents SP. DEF one stage.','No Added Effect','special',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Acid Armor',0,0,'Raises users DEFENSE two stages.','Points of next appeal doubles','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Acupressure',0,0,'','Points of next appeal doubles','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Aerial Ace',60,0,'Cannot miss.','Points +2 if first to appeal','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Aeroblast',100,95,'Has high critical hit ratio.','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Agility',0,0,'Raises users SPEED two stages.','Appeals first in the next turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Air Cutter',55,95,'Has high critical hit ratio.','No Added Effect','special',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Air Slash',75,95,'May cause opponent to flinch.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Amnesia',0,0,'Raises users SP. DEF two stages.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ancientpower',60,100,'May raise all users stats one stage.','Points +2 if last to appeal','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Aqua Jet',40,100,'Always strikes first.','Appeals first in the next turn','physical',20,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Aqua Ring',0,0,'','Points equal to the voltage of the judge','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Aqua Tail',90,90,'No effect.','No Added Effect','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Arm Thrust',15,100,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Aromatherapy',0,0,'Heals partys status problems.','Points equal to the voltage of the judge','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Assist',0,0,'Uses a random move from another Pokémon in the team.','Order of appealing is random in the next turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Assurance',50,100,'','Points doubles if last to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Astonish',30,100,'May cause opponent to flinch.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Attack Order',90,100,'Has high critical hit ratio.','Increases judges voltage by 2','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Attract',0,100,'Induces ATTRACT.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Aura Sphere',90,0,'Cannot miss.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Aurora Beam',65,100,'May lower opponents ATTACK one stage.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Avalanche',60,100,'Power doubles if hit before the attack.','Points doubles if last to appeal','physical',10,-4);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Barrage',15,85,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Barrier',0,0,'Raises users DEFENSE two stages.','Pokemon after self cannot raise any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Baton Pass',0,0,'Switches out the user but status changes remain.','Points equal 4 minus voltage of judge','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Beat Up',10,100,'Does additional damage for every Pokémon in trainers team.','Can be used twice consecutively','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Belly Drum',0,0,'Cuts half of users maximum HP and maximizes ATTACK.','Points of next appeal doubles','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bide',1,0,'User takes hits for 2 rounds, then strikes back.','Points doubles if last to appeal','physical',10,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bind',15,75,'Traps opponent.','First to appeal +1','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bite',60,100,'May cause opponent to flinch.','No Added Effect','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Blast Burn',150,90,'User cannot attack on the next turn.','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Blaze Kick',85,90,'Has high critical hit ratio. May induce burn.','Points +2 if first to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Blizzard',120,70,'','Points +2 if first to appeal','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Block',0,0,'Prevents the opponent from escaping.','Pokemon after self cannot raise any voltage in that turn','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Body Slam',85,100,'May induce paralysis.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bone Club',65,85,'May cause opponent to flinch.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bone Rush',25,80,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bonemerang',50,90,'Attacks twice in a row.','Can be used twice consecutively','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bounce',85,85,'','Points +3 if appeals to the same judge with other pokemon','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Brave Bird',120,100,'User takes recoil damage.','Points +2 if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Brick Break',75,100,'Destroys protective barriers.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Brine',65,100,'','Increases judges voltage by 2','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bubble',20,100,'May lower opponents SPEED one stage.','Appeals last in the next turn','special',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bubblebeam',65,100,'May lower opponents SPEED one stage.','Appeals last in the next turn','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bug Bite',60,100,'','Receives voltage points if previous pokemon reaches max voltage','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bug Buzz',90,100,'May lower opponents SP. DEF one stage.','Increases judges voltage by 2','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bulk Up',0,0,'Raises users ATTACK and DEFENSE one stage.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bullet Punch',40,100,'Always strikes first.','Appeals first in the next turn','physical',30,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Bullet Seed',10,100,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Calm Mind',0,0,'Raises users SP. ATK and SP. DEF one stage.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Camouflage',0,0,'User changes type depending on the location.','Pokemon after self cannot raise any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Captivate',0,100,'','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Charge',0,0,'Increases the power of the next ELECTRIC attack.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Charge Beam',50,90,'','Points +2 if firt to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Charm',0,100,'Lowers opponents ATTACK two stages.','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Chatter',60,100,'','Points +3 if lowest number of points in that turn','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Clamp',35,75,'Traps opponent.','No Added Effect','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Close Combat',120,100,'','Points +3 if previous pokemon reaches max voltage of a judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Comet Punch',18,85,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Confuse Ray',0,100,'May induce CONFUSION.','Lowers voltage of all judges by 1','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Confusion',50,100,'May induce CONFUSION.','No Added Effect','special',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Constrict',10,100,'May lower opponents SPEED one stage.','First to appeal +1','physical',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Conversion',0,0,'User changes type into an own moves type.','Points +3 if lowest number of points in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Conversion 2',0,0,'User becomes a type resistant to opponents last attack.','Points +3 if lowest number of points in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Copycat',0,0,'','Receives voltage points if previous pokemon reaches max voltage','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Cosmic Power',0,0,'Raises users DEFENSE and SP. DEF one stage.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Cotton Spore',0,85,'Lowers opponents SPEED two stages.','Appeals first in the next turn','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Counter',1,100,'If hit by a physical attack, deals double the damage received.','Points doubles if last to appeal','physical',20,-5);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Covet',40,100,'May steal opponents item (temporarily in trainer battles).','Receives voltage points if previous pokemon reaches max voltage','physical',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Crabhammer',90,85,'Has high critical hit ratio.','Points +2 if last to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Cross Chop',100,80,'Has high critical hit ratio.','Points +2 if last to appeal','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Cross Poison',70,100,'Has high critical hit ratio. May induce poison.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Crunch',80,100,'May lower opponents DEFENSE one stage.','Points +2 if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Crush Claw',75,95,'May lower opponents DEFENSE one stage.','No Added Effect','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Crush Grip',1,100,'This attack\s Base Power is anything from 1 up to 110 making it a fairly powerful attack to be used.','','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Curse',0,0,'Ghost type Pokémon: User loses half their maximum HP, and the opponent gets a Nightmare.','First to appeal +1','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Cut',50,95,'No effect.','No Added Effect','physical',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dark Pulse',80,100,'May cause opponent to flinch.','Points +2 if first to appeal','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dark Void',0,80,'Induces sleep.','Pokemon after self cannot lower any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Defense Curl',0,0,'Raises users DEFENSE one stage. Damage from ROLLOUT will be higher.','Pokemon after self cannot raise any voltage in that turn','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Defend Order',0,0,'Raises users DEFENSE and SP. DEF one stage.','Points of next appeal doubles','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Defog',0,0,'','Pokemon after self cannot raise any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Destiny Bond',0,0,'If the user faints, the opponent will also faint.','Points +15 if all pokemon appeal to the same judge','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Detect',0,0,'Evades opponents next attack; the moves accuracy drops.','Points equal 4 minus voltage of judge','other',5,3);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dig',80,100,'','Points +3 if appeals to the same judge with other pokemon','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Disable',0,80,'Disables opponents last move.','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Discharge',80,100,'May induce paralysis.','Points +2 if first to appeal','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dive',80,100,'','Points +3 if appeals to the same judge with other pokemon','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dizzy Punch',70,100,'May induce CONFUSION.','Points equal 4 minus voltage of judge','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Doom Desire',120,85,'Damage delays 2 turns.','Points +2 if first to appeal','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Double Hit',35,90,'Attacks twice in a row.','Can be used twice consecutively','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Double Kick',30,100,'Attacks twice in a row.','Can be used twice consecutively','physical',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Double Team',0,0,'Raises users EVASIVENESS one stage.','Appeals first in the next turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Double-edge',120,100,'User takes recoil damage.','Points +15 if all pokemon appeal to the same judge','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Doubleslap',15,85,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Draco Meteor',140,90,'Lowers users SP. ATK two stages.','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dragon Claw',80,100,'No effect.','Points +2 if first to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dragon Dance',0,0,'Raises users ATTACK and SPEED one stage.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dragon Pulse',90,100,'No effect.','Increases judges voltage by 2','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dragon Rage',1,100,'Inflicts 40 HP damage.','No Added Effect','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dragon Rush',100,75,'May cause opponent to flinch.','Points +2 if last to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dragonbreath',60,100,'May induce paralysis.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Drain Punch',60,100,'User recovers half the damage inflicted.','No Added Effect','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dream Eater',100,100,'User recovers half the damage inflicted on a sleeping opponent.','Points +3 if two pokemon raise a judges voltage consecutively','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Drill Peck',80,100,'No effect.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Dynamicpunch',100,50,'May induce CONFUSION.','Points +2 if last to appeal','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Earth Power',90,100,'May lower opponents SP. DEF one stage.','Points +2 if last to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Earthquake',100,100,'Hits everyone on the field.','Points +2 if last to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Egg Bomb',100,75,'No effect.','No Added Effect','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Embargo',0,100,'','Pokemon after self cannot raise any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ember',40,100,'May induce burn.','No Added Effect','special',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Encore',0,100,'Opponent repears the last move.','Points +3 if two pokemon raise a judges voltage consecutively','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Endeavor',1,100,'Power rises if users HP are less than opponents HP.','Points doubles if last to appeal','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Endure',0,0,'Survives any attack for one turn leaving at least 1 HP but moves accuracy drops.','Pokemon after self cannot raise any voltage in that turn','other',10,3);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Energy Ball',80,100,'May lower opponents SP. DEF one stage.','Points +2 if first to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Eruption',150,100,'Power wise, this attack has a Base Power of 150 but that completely changes all depending on the HP','','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Explosion',250,100,'User faints.','Points +15 if all pokemon appeal to the same judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Extrasensory',80,100,'May cause opponent to flinch.','Points +2 if first to appeal','special',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Extremespeed',80,100,'Always strikes first.','Appeals first in the next turn','physical',5,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Facade',70,100,'ATTACK is doubled when burned, paralyzed, or poisoned.','Points doubles if last to appeal','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Faint Attack',60,0,'Cannot miss.','Points +2 if last to appeal','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fake Out',40,100,'Causes opponent to flinch. Attacks first.','Points +2 if first to appeal','physical',10,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fake Tears',0,100,'Lowers opponents SP. DEF two stages.','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('False Swipe',40,100,'Leaves the foe with at least 1 HP.','Points equal 4 minus voltage of judge','physical',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Featherdance',0,100,'Lowers opponents ATTACK two stages.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Feint',50,100,'','Points equal 4 minus voltage of judge','physical',10,2);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fire Blast',120,85,'May induce burn.','Points +2 if first to appeal','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fire Fang',65,95,'','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fire Punch',75,100,'May induce burn.','Points +2 if first to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fire Spin',15,70,'Traps opponent.','First to appeal +1','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fissure',1,30,'May cause one-hit KO.','Oints +15 if all pokemon appeal to the same judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Flail',1,100,'Inflicts more damage when the users HP is down.','Points doubles if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Flame Wheel',60,100,'May induce burn.','Can be used twice consecutively','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Flamethrower',95,100,'May induce burn.','Points +2 if first to appeal','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Flare Blitz',120,100,'','Points +3 if previous pokemon reaches max voltage of a judge','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Flash',0,100,'Lowers opponents ACCURACY one stage.','Lowers voltage of all judges by 1','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Flash Cannon',80,100,'May lower opponents SP. DEF one stage.','Points +2 if first to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Flatter',0,100,'Induces CONFUSE. Raises opponents SP. ATK two stages.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fling',1,100,'As the Base Power can get up to 130, it adds major strategy possibilities.','Induces Burn status to holder','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fly',90,95,'The user is protected the first turn, attacks the second turn.','Points +3 if appeals to the same judge with other pokemon','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Focus Blast',120,70,'May lower opponents SP. DEF one stage.','Points +2 if first to appeal','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Focus Energy',0,0,'Increases users critical hit rate.','Points of next appeal doubles','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Focus Punch',150,100,'User flinches if hit before attacking.','Points +3 if appeals to the same judge with other pokemon','physical',20,-3);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Follow Me',0,0,'Opponent only attacks the user. Best used in 2VS2 battles.','Order of appealing is random in the next turn','other',20,3);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Force Palm',60,100,'May induce paralysis.','Points +2 if last to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Foresight',0,0,'Resets opponents EVASIVENESS.','Points +3 if two pokemon raise a judges voltage consecutively','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Frenzy Plant',150,90,'User cannot attack on the next turn.','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Frustration',1,100,'Frustration is the move that utilises the Happiness in the negative light, by rewarding the amount the Pokémon hates the trainer.','','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fury Attack',15,85,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fury Cutter',10,95,'Moves power raises if it hits.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Fury Swipes',18,80,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Future Sight',80,90,'Damage delays 2 turns.','Points +2 if first to appeal','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Gastro Acid',0,100,'','Pokemon after self cannot raise any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Giga Drain',60,100,'User recovers half the damage inflicted.','Points +3 if two pokemon raise a judges voltage consecutively','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Giga Impact',150,90,'User cannot attack on the next turn.','Points +3 if previous pokemon reaches max voltage of a judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Glare',0,75,'Induces paralysis','Pokemon after self cannot lower any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Grass Knot',1,100,'This attacks power is based on your targets weight.','','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Grasswhistle',0,55,'Induces sleep.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Gravity',0,0,'','Pokemon after self cannot raise any voltage in that turn','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Growl',0,100,'Lowers opponents ATTACK one stage.','Pokemon after self cannot lower any voltage in that turn','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Growth',0,0,'Raises users SP. ATK one stage.','Points of next appeal doubles','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Grudge',0,0,'If the user faints, deletes the PP of opponents last move.','Lowers voltage of all judges by 1','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Guard Swap',0,0,'','Points equal 4 minus voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Guillotine',1,30,'May cause one-hit KO.','Points +15 if all pokemon appeal to the same judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Gunk Shot',120,70,'May induce poison.','No Added Effect','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Gust',40,100,'Hits even if opponent is using FLY.','No Added Effect','special',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Gyro Ball',1,100,'This attacks Base Power is anything from 1 up to 150 making it a very powerful attack to be used.','','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hail',0,0,'Causes Hailstorm for 5 rounds.','Pokemon after self cannot raise any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hammer Arm',100,90,'','Appeals last in the next turn','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Harden',0,0,'Raises users DEFENSE one stage.','Pokemon after self cannot raise any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Haze',0,0,'Resets all ability stages.','Pokemon after self cannot raise any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Head Smash',150,80,'','Points +3 if previous pokemon reaches max voltage of a judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Headbutt',70,100,'May cause opponent to flinch.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Heal Bell',0,0,'Heals partys status problems.','Points equal to the voltage of the judge','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Heal Block',0,100,'','Pokemon after self cannot raise any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Heal Order',0,0,'User recovers half the maximum HP.','Points equal to the voltage of the judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Healing Wish',0,0,'','Points equal to the voltage of the judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Heart Swap',0,0,'','Points equal 4 minus voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Heat Wave',100,90,'May induce burn.','Points +2 if first to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Helping Hand',0,0,'Boosts receivers attacks. Best used in 2VS2 battles.','Points +3 if two pokemon raise a judges voltage consecutively','other',20,5);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hi Jump Kick',100,90,'If attack misses, user takes 1/8 HP of damage.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hidden Power',1,100,'Power and type depend on users IVs.','Points +3 if lowest number of points in that turn','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Horn Attack',65,100,'No effect.','No Added Effect','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Horn Drill',1,30,'May cause one-hit KO.','Points +15 if all pokemon appeal to the same judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Howl',0,0,'Raises users ATTACK one stage.','Points of next appeal doubles','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hydro Cannon',150,90,'User cannot attack on the next turn.','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hydro Pump',120,80,'No effect.','Points +2 if first to appeal','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hyper Beam',150,90,'User cannot attack on the next turn.','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hyper Fang',80,90,'May cause opponent to flinch.','Points +2 if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hyper Voice',90,100,'No effect.','No Added Effect','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Hypnosis',0,70,'Induces sleep.','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ice Ball',30,90,'Uses the same move for 5 turns; moves power raises if it hits.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ice Beam',95,100,'May induce freeze.','Points +2 if first to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ice Fang',65,95,'','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ice Punch',75,100,'May induce freeze.','Points +2 if first to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ice Shard',40,100,'Always strikes first.','Appeals first in the next turn','physical',30,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Icicle Spear',10,100,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Icy Wind',55,95,'May lower opponents SPEED one stage.','Appeals last in the next turn','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Imprison',0,0,'Opponent cannot use move that user knows.','Points +3 if two pokemon raise a judges voltage consecutively','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ingrain',0,0,'Recovers HP every turn. User cannot switch.','First to appeal +1','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Iron Defense',0,0,'Raises users DEFENSE two stages.','Pokemon after self cannot raise any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Iron Head',80,100,'May cause opponent to flinch.','Points +2 if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Iron Tail',100,75,'May lower opponents DEFENSE one stage.','Points +2 if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Judgment',100,100,'','Order of appealing is random in the next turn','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Jump Kick',85,95,'If attack misses, user takes 1/8 HP of damage.','No Added Effect','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Karate Chop',50,100,'Has high critical hit ratio.','No Added Effect','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Kinesis',0,80,'Lowers opponents ACCURACY one stage.','Points of next appeal doubles','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Knock Off',20,100,'Knocks down opponents held item to prevent its use.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Last Resort',130,100,'','First to appeal +1','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Lava Plume',80,100,'May induce burn.','Points +2 if first to appeal','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Leaf Blade',90,100,'Has high critical hit ratio.','Points +2 if first to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Leaf Storm',140,90,'Lowers users SP. ATK two stages.','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Leech Life',20,100,'User recovers half the damage inflicted.','Points +3 if two pokemon raise a judges voltage consecutively','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Leech Seed',0,90,'User steals HP from the opponent every turn.','First to appeal +1','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Leer',0,100,'Lowers opponents DEFENSE one stage.','Pokemon after self cannot lower any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Lick',20,100,'May induce paralysis.','Points equal 4 minus voltage of judge','physical',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Light Screen',0,0,'Halves SP. ATK damage inflicted on user.','Pokemon after self cannot raise any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Lock-on',0,0,'Ensures that users next move will not fail.','Points +3 if two pokemon raise a judges voltage consecutively','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Lovely Kiss',0,75,'Induces sleep.','Pokemon after self cannot lower any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Low Kick',1,100,'This attacks power is based on your targets weight.','','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Lucky Chant',0,0,'','Pokemon after self cannot raise any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Lunar Dance',0,0,'','Points equal to the voltage of the judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Luster Purge',70,100,'May lower opponents SP. DEF one stage.','Points +3 if previous pokemon reaches a max voltage in a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mach Punch',40,100,'Always strikes first.','Appeals first in the next turn','physical',30,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Magic Coat',0,0,'Magic Coat will reflect the moves used by the opponent on the Pokémon during the next turn back at them.','If it is the opposite gender of the user, the foe becomes infatuated and less likely to attack.','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Magical Leaf',60,0,'Cannot miss.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Magma Storm',120,70,'Traps opponent.','Can be used twice consecutively','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Magnet Bomb',60,0,'Cannot miss.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Magnet Rise',0,0,'','Pokemon after self cannot raise any voltage in that turnt','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Magnitude',1,100,'When the attack is used, the screen will come up with a number saying the Magnitude of the attack.','','physical',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Me First',0,0,'','Appeals first in the next turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mean Look',0,0,'Prevents the opponent from escaping.','Lowers voltage of all judges by 1','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Meditate',0,0,'Raises users ATTACK one stage.','Points of next appeal doubles','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mega Drain',40,100,'User recovers half the damage inflicted.','Points +3 if two pokemon raise a judges voltage consecutively','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mega Kick',120,75,'No effect.','Points +2 if last to appeal','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mega Punch',80,85,'No effect.','Points +2 if last to appeal','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Megahorn',120,85,'No effect.','Points +2 if last to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Memento',0,100,'Lowers opponents stats. User faints.','Points +15 if all pokemon appeal to the same judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Metal Burst',1,100,'','Points doubles if last to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Metal Claw',50,95,'May raise users ATTACK one stage.','Points +2 if last to appeal','physical',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Metal Sound',0,85,'Lowers opponents SP. DEF two stages.','Lowers voltage of all judges by 1','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Meteor Mash',100,85,'May raise users ATTACK one stage.','Points +2 if last to appeal','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Metronome',0,0,'Uses a random move.','Order of appealing is random in the next turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Milk Drink',0,0,'User recovers half the maximum HP.','Points equal to the voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mimic',0,0,'Copies opponents last move.','Receives voltage points if previous pokemon reaches max voltage','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mind Reader',0,0,'Ensures that users next move will not fail.','Points +3 if two pokemon raise a judges voltage consecutively','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Minimize',0,0,'Raises users EVASIVENESS one stage.','Pokemon after self cannot raise any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Miracle Eye',0,0,'','Points +3 if two pokemon raise a judges voltage consecutively','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mirror Coat',1,100,'Counters the foes special attack at double the power.','Points doubles if last to appeal','special',20,-5);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mirror Move',0,0,'User does the last move used by opponent.','Points doubles if last to appeal','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mirror Shot',65,85,'May lower opponents ACCURACY one stage.','Points +2 if first to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mist',0,0,'Stops ability reduction.','Pokemon after self cannot raise any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mist Ball',70,100,'May lower opponents SP. ATK one stage.','Points +3 if previous pokemon reaches a max voltage in a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Moonlight',0,0,'User restores HP.','number of points is equal to the voltage of the judge','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Morning Sun',0,0,'User restores HP.','number of points is equal to the voltage of the judge','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mud Bomb',65,85,'May lower opponents ACCURACY one stage.','Points +2 if last to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mud Shot',55,95,'May lower opponents SPEED one stage.','Appeals last in the next turn','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mud Sport',0,0,'Lowers the power of ELECTRIC moves.','Pokemon after self cannot raise any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Mud-slap',20,100,'May lower opponents ACCURACY one stage.','No Added Effect','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Muddy Water',95,85,'May lower opponents ACCURACY one stage.','Points +2 if last to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Nasty Plot',0,0,'Raises users SP. ATK two stages.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Natural Gift',1,100,'','Points +2 if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Nature Power',0,0,'Depends on battle location.','Order of appealing is random in the next turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Needle Arm',60,100,'May cause opponent to flinch.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Night Shade',1,100,'Inflicts damage equal to the users level.','No Added Effect','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Night Slash',70,100,'Has high critical hit ratio.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Nightmare',0,100,'Inflicts 1/4 damage on a sleeping foe every turn.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Octazooka',65,85,'May lower opponents ACCURACY one stage.','Raises judges voltage by 2','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Odor Sleuth',0,0,'Resets opponents EVASIVENESS.','Points +3 if two pokemon raise a judges voltage consecutively','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Ominous Wind',60,100,'May raise all users stats one stage.','Points of next appeal doubles','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Outrage',120,100,'User uses the same attack for 2-3 turns then becomes confused.','Can be used twice consecutively','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Overheat',140,90,'Lowers users SP. ATK two stages.','Points +3 if previous pokemon reaches a max voltage in a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Pain Split',0,0,'User and opponent share HP.','Lowers voltage of all judges by 1','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Pay Day',40,100,'User gains coins after battle.','Points +3 if lowest number of points in that turn','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Payback',50,100,'','Points +3 if appeals to the same judge with other pokemon','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Peck',35,100,'No effect.','No Added Effect','physical',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Perish Song',0,0,'All Pokémon on the field faint in 3 turns.','Lowers voltage of all judges by 1','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Petal Dance',90,100,'User uses the same attack for 2-3 turns then becomes confused.','First to appeal +1','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Pin Missile',14,85,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Pluck',60,100,'','Receives voltage points if previous pokemon reaches max voltage','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Poison Fang',50,100,'May induce severe poison.','Increases judges voltage by 2','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Poison Gas',0,55,'Induces poison.','No Added Effect','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Poison Jab',80,100,'May induce poison.','Increases judges voltage by 2','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Poison Sting',15,100,'May induce poison.','Pokemon after self cannot lower any voltage in that turn','physical',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Poison Tail',50,100,'Has high critical hit ratio. May induce poison.','Increases judges voltage by 2','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Poisonpowder',0,75,'Induces poison.','Pokemon after self cannot lower any voltage in that turn','other',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Pound',40,100,'No effect.','No Added Effect','physical',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Powder Snow',40,100,'May induce freeze.','No Added Effect','special',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Power Gem',70,100,'No effect.','No Added Effect','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Power Swap',0,0,'','Points equal 4 minus voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Power Trick',0,0,'','Points equal 4 minus voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Power Whip',120,85,'No effect.','No Added Effect','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Present',1,90,'May hit or heal the user or the opponent.','Points equal 4 minus voltage of judge','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Protect',0,0,'Evades opponents next attack; the moves accuracy drops.','Points equal 4 minus voltage of judge','other',10,3);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Psybeam',65,100,'May induce CONFUSION.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Psych Up',0,0,'Copies opponents stat changes.','Points of next appeal doubles','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Psychic',90,100,'May lower opponents SP. DEF one stage.','Points +2 if first to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Psycho Boost',140,90,'Lowers users SP. ATK two stages.','Points +3 if previous pokemon reaches a max voltage in a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Psycho Cut',70,100,'Has high critical hit ratio.','Points +2 if first to appeal','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Psycho Shift',0,90,'','Points equal 4 minus voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Psywave',1,80,'Inflicts damage equal to 0.5 to 1.5 x  users level.','No Added Effect','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Punishment',1,100,'Punishment has a rather low Base Power to start of with.','','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Pursuit',40,100,'Inflicts double damage if the opponent is switching out.','Points +3 if two pokemon raise a judges voltage consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Quick Attack',40,100,'Always strikes first.','Appeals first in the next turn','physical',30,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rage',20,100,'Users ATTACK raises if hit.','Points of next appeal doubles','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rain Dance',0,0,'Causes Rain for 5 rounds.','Pokemon after self cannot raise any voltage in that turn','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rapid Spin',20,100,'User is becomes free from moves like Wrap, Bind and Leech Seed.','Points +2 if first to appeal','physical',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Razor Leaf',55,95,'Has high critical hit ratio.','No Added Effect','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Razor Wind',80,100,'Has high critical hit ratio.','Points +3 if appeals to the same judge with other pokemon','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Recover',0,0,'User recovers half the maximum HP.','Points equal to the voltage of the judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Recycle',0,0,'Recycles an already used held item.','Receives voltage points if previous pokemon reaches max voltage','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Reflect',0,0,'Halves ATTACK damage inflicted on user.','Pokemon after self cannot raise any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Refresh',0,0,'Heals poisoning, paralysis, or a burn.','Points equal to the voltage of judge','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rest',0,0,'User restores health, then sleeps.','Points equal to the voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Return',1,100,'Return is the move that utilises the Happiness in a more positive light, by rewarding the amount the Pokémon likes the trainer.','','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Revenge',60,100,'Power doubles if hit before the attack.','Points doubles if last to appeal','physical',10,-4);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Reversal',1,100,'Inflicts more damage when the users HP is down.','Points doubles if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Roar',0,100,'Ends battle. Switches the opponent Pokémon in a trainer battle.','Pokemon after self cannot lower any voltage in that turn','other',20,-6);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Roar Of Time',150,90,'User cannot attack on the next turn.','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rock Blast',25,80,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rock Climb',90,85,'May induce CONFUSION.','Points +2 if last to appeal','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rock Polish',0,0,'Raises users SPEED two stages.','Appeals first in the next turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rock Slide',75,90,'May cause opponent to flinch.','No Added Effect','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rock Smash',40,100,'May lower opponents DEFENSE one stage.','Points +2 if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rock Throw',50,90,'No effect.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rock Tomb',50,80,'May lower opponents SPEED one stage.','Appeals last in the next turn','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rock Wrecker',150,90,'User cannot attack on the next turn.','Points +3 if previous pokemon reaches max voltage of a judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Role Play',0,0,'Copies targets ability.','Points +3 if lowest number of points in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rolling Kick',60,85,'May cause opponent to flinch.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Rollout',30,90,'Uses the same move for 5 turns; moves power raises if it hits.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Roost',0,0,'','Points equal to the voltage of the judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sacred Fire',100,95,'May induce burn.','Points +3 if previous pokemon reaches max voltage of judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Safeguard',0,0,'Prevents all status problems.','Pokemon after self cannot raise any voltage in that turn','other',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sand Tomb',15,70,'Traps opponent.','First to appeal +1','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sand-attack',0,100,'Lowers opponents ACCURACY one stage.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sandstorm',0,0,'Causes a Sandstorm for 5 turns.','Pokemon after self cannot raise any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Scary Face',0,90,'Lowers opponents SPEED two stages.','Appeals last in the next turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Scratch',40,100,'No effect.','No Added Effect','physical',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Screech',0,85,'Lowers opponents DEFENSE two stages.','Lowers voltage of all judges by 1','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Secret Power',70,100,'Depends on battle location.','Order of appealing is random in the next turn','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Seed Bomb',80,100,'No effect.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Seed Flare',120,85,'','Points +3 if previous pokemon reaches max voltage of a judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Seismic Toss',1,100,'Inflicts damage equal to the users level.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Selfdestruct',200,100,'User faints.','Points +15 if all pokemon appeal to the same judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Shadow Ball',80,100,'May lower opponents SP. DEF one stage.','Points +2 if first to appeal','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Shadow Claw',70,100,'Has high critical hit ratio.','Points +2 if first to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Shadow Force',120,100,'','Points +3 if previous pokemon reaches max voltage of a judge','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Shadow Punch',60,0,'Cannot miss.','Points +2 if first to appeal','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Shadow Sneak',40,100,'Always strikes first.','Appeals first in the next turn','physical',30,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sharpen',0,0,'Raises users ATTACK one stage.','Points of next appeal doubles','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sheer Cold',1,30,'May cause one-hit KO.','Points +15 if all pokemon appeal to the same judge','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Shock Wave',60,0,'Cannot miss.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Signal Beam',75,100,'May induce CONFUSION.','Raises judges voltage by 2','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Silver Wind',60,100,'May raise all users stats one stage.','Raises judges voltage by 2','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sing',0,55,'Induces sleep.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sketch',0,0,'Copies the opponents last move forever.','Points +3 if lowest number of points in that turn','other',1,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Skill Swap',0,0,'Use and target trade abilities.','Receives voltage points if previous pokemon reaches max voltage','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Skull Bash',100,100,'Raises users DEFENSE one stage and attacks next turn.','Points +3 if appeals to the same judge with other pokemon','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sky Attack',140,90,'May cause opponent to flinch.','Points +3 if appeals to the same judge with other pokemon','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sky Uppercut',85,90,'Hits even if opponent is using FLY.','Points +2 if first to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Slack Off',0,0,'User recovers half the maximum HP.','Points equal to the voltage of the judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Slam',80,75,'No effect.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Slash',70,100,'Has high critical hit ratio.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sleep Powder',0,75,'Induces sleep.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sleep Talk',0,0,'Uses an own random move while asleep.','No Added Effect','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sludge',65,100,'May induce poison.','Points +2 if last to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sludge Bomb',90,100,'May induce poison.','Points +2 if last to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Smellingsalt',60,100,'Stronger against a paralyzed opponent but also heals them.','Points equal 4 minus voltage of judge','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Smog',20,70,'May induce poison.','No Added Effect','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Smokescreen',0,100,'Lowers opponents ACCURACY one stage.','Lowers voltage of all judges by 1','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Snatch',0,0,'Steals the effects of opponents next move.','Receives voltage points if previous pokemon reaches max voltage','other',10,4);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Snore',40,100,'Can only be used while asleep.','No Added Effect','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Softboiled',0,0,'User recovers half the maximum HP.','Points equal to the voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Solarbeam',120,100,'Wait for a turn and attacks the next.','Points +3 if appeals to the same judge with other pokemon','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sonicboom',1,90,'Inflicts 20 HP damage.','No Added Effect','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Spacial Rend',100,95,'Has high critical hit ratio.','Increases judges voltage by 2','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Spark',65,100,'May induce paralysis.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Spider Web',0,0,'Prevents the opponent from escaping.','Pokemon after self cannot raise any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Spike Cannon',20,100,'Attacks 2-5 times in a row.','Can be used twice consecutively','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Spikes',0,0,'The damage that is given through Spikes is determined by the amount of layers that you place.','','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Spit Up',1,100,'This move has four tiers of damage; 3 are stockpiled, 1 isnt.','','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Spite',0,100,'Opponents last move loses 2-5 HP.','Pokemon after self cannot lower any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Splash',0,0,'No effect.','Points equal 4 minus voltage of judge','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Spore',0,100,'Induces sleep.','Lowers voltage of all judges by 1','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Stealth Rock',0,0,'Stealth Rocks damaging methods are rather unique.','','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Steel Wing',70,90,'May raise users DEFENSE one stage.','No Added Effect','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Stockpile',0,0,'User stockpiles power for up to 3 turns.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Stomp',65,100,'May cause opponent to flinch.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Stone Edge',100,80,'Has high critical hit ratio.','Increases judges voltage by 2','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Strength',80,100,'No effect.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('String Shot',0,95,'Lowers opponents SPEED one stage.','Pokemon after self cannot lower any voltage in that turn','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Struggle',50,0,'','No Effect','physical',1,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Stun Spore',0,75,'Induces paralysis','Pokemon after self cannot lower any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Submission',80,80,'User takes recoil damage.','No Added Effect','physical',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Substitute',0,0,'Creates a decoy using 1/4 of the users maximum HP.','Points +3 if lowest number of points in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sucker Punch',80,100,'','Appeals first in the next turn','physical',5,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sunny Day',0,0,'Causes Sunshine for 5 rounds.','Pokemon after self cannot raise any voltage in that turn','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Super Fang',1,90,'Cuts half opponents HP.','No Added Effect','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Superpower',120,100,'Lowers users ATTACK and DEFENSE one stage.','Points +2 if last to appeal','physical',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Supersonic',0,55,'May induce CONFUSION.','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Surf',95,100,'','Points +2 if first to appeal','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Swagger',0,90,'Induces CONFUSE. Raises opponents ATTACK two stages.','Pokemon after self cannot lower any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Swallow',0,0,'This move has four tiers of healing; 3 are stockpiled, 1 isnt.','','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sweet Kiss',0,75,'May induce CONFUSION.','Pokemon after self cannot lower any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Sweet Scent',0,100,'Lowers opponents EVASIVENESS one stage.','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Swift',60,0,'Cannot miss.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Switcheroo',0,100,'User trades items with opponent.','Receives voltage points if previous pokemon reaches max voltage','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Swords Dance',0,0,'Raises users ATTACK two stages.','Points of next appeal doubles','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Synthesis',0,0,'User restores HP.','number of points is equal to the voltage of the judge','other',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Tackle',35,95,'No effect.','No Added Effect','physical',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Tail Glow',0,0,'Raises users SP. ATK two stages.','Points of next appeal doubles','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Tail Whip',0,100,'Lowers opponents DEFENSE one stage.','Pokemon after self cannot lower any voltage in that turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Tailwind',0,0,'','Appeals first in the next turn','other',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Take Down',90,85,'User takes recoil damage.','No Added Effect','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Taunt',0,100,'Opponent can only use attack moves.','Points equal 4 minus voltage of judge','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Teeter Dance',0,100,'Confuses all Pokémon on the field.','Order of appealing is random in the next turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Teleport',0,0,'Ends battle. Switches user in trainer battles.','Appeals first in the next turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Thief',40,100,'May steal opponents item (temporarily in trainer battles).','Receives voltage points if previous pokemon reaches max voltage','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Thrash',90,100,'User uses the same attack for 2-3 turns then becomes confused.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Thunder',120,70,'May induce paralysis.','Points +2 if first to appeal','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Thunder Fang',65,95,'','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Thunder Wave',0,100,'Induces paralysis','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Thunderbolt',95,100,'May induce paralysis.','Points +2 if first to appeal','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Thunderpunch',75,100,'May induce paralysis.','Points +2 if first to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Thundershock',40,100,'May induce paralysis.','No Added Effect','special',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Tickle',0,100,'Lowers opponents ATTACK and DEFENSE one stage.','Pokemon after self cannot lower any voltage in that turn','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Torment',0,100,'Opponent cannot use the same move in a row.','Points equal 4 minus voltage of judge','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Toxic',0,85,'Induces severe poison.','Pokemon after self cannot lower any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Toxic Spikes',0,0,'Toxic Spikes is the only Entry Hazard attack that does not afflict damage on the Pokémon straight away.','','other',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Transform',0,0,'Transform can change many features of the Pokémon temporarily.','','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Tri Attack',80,100,'May induce burn, freeze or paralysis.','No Added Effect','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Trick',0,100,'User trades items with opponent.','Receives voltage points if previous pokemon reaches max voltage','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Trick Room',0,0,'','Order of appealing is random in the next turn','other',5,-7);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Triple Kick',10,90,'Attacks 1-3 times in a row.','Can be used twice consecutively','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Trump Card',1,0,'Trump Cards base power is dependant on the amount of PP that it has left.','','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Twineedle',25,100,'Attacks twice. May induce poison.','Can be used twice consecutively','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Twister',40,100,'May cause opponent to flinch. Damage is doubled if opponent is using FLY.','No Added Effect','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('U-turn',70,100,'','Points equal 4 minus voltage of judge','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Uproar',50,100,'User cannot sleep for 2-5 turns.','Lowers voltage of all judges by 1','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Vacuum Wave',40,100,'Always strikes first.','Appeals first in the next turn','special',30,1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Vicegrip',55,100,'No effect.','No Added Effect','physical',30,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Vine Whip',35,100,'No effect.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Vital Throw',70,0,'Cannot miss. Goes last.','Appeals last in the next turn','physical',10,-1);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Volt Tackle',120,100,'','Points +3 if previous pokemon reaches max voltage of a judge','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Wake-up Slap',60,100,'','Points equal 4 minus voltage of judge','physical',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Water Gun',40,100,'No effect.','No Added Effect','special',25,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Water Pulse',60,100,'May induce CONFUSION.','Points +2 if first to appeal','special',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Water Sport',0,0,'Lowers the power of FIRE moves.','Pokemon after self cannot raise any voltage in that turn','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Water Spout',150,100,'Power wise, this attack has a Base Power of 150 but that completely changes all depending on the HP.','','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Waterfall',80,100,'May cause opponent to flinch.','No Added Effect','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Weather Ball',50,100,'Depends on the weather.','Increases judges voltage by 2','special',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Whirlpool',15,70,'','First to appeal +1','special',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Whirlwind',0,100,'Ends battle. Switches the opponent Pokémon in a trainer battle.','Points +15 if all pokemon appeal to the same judge','other',20,-6);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Will-o-wisp',0,75,'Induces burn.','Points +2 if first to appeal','other',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Wing Attack',60,100,'No effect.','No Added Effect','physical',35,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Wish',0,0,'Recovers HP. Delays 1 turn.','Points equal to the voltage of judge','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Withdraw',0,0,'Raises users DEFENSE one stage.','Pokemon after self cannot raise any voltage in that turn','other',40,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Wood Hammer',120,100,'User takes recoil damage.','Points +2 if last to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Worry Seed',0,100,'','Pokemon after self cannot lower any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Wrap',15,85,'Traps opponent.','First to appeal +1','physical',20,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Wring Out',1,100,'This attack\s Base Power is anything from 1 up to 110 making it a fairly powerful attack to be used.','','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('X-scissor',80,100,'No effect.','Points +2 if first to appeal','physical',15,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Yawn',0,0,'User and opponent sleep the next turn.','Pokemon after self cannot lower any voltage in that turn','other',10,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Zap Cannon',120,50,'May induce paralysis.','Increases judges voltage by 2','special',5,0);
INSERT INTO move (moveName,basePower,accuracy,description,effect,category,powerPoints,speedPrio) VALUES ('Zen Headbutt',80,90,'May cause opponent to flinch.','Points +2 if last to appeal','physical',15,0);

INSERT INTO location (locationName) VALUES('Route 201');
INSERT INTO location (locationName) VALUES('Route 202');
INSERT INTO location (locationName) VALUES('Route 203');
INSERT INTO location (locationName) VALUES('Route 204');
INSERT INTO location (locationName) VALUES('Route 205');
INSERT INTO location (locationName) VALUES('Route 206');
INSERT INTO location (locationName) VALUES('Route 207');
INSERT INTO location (locationName) VALUES('Route 208');
INSERT INTO location (locationName) VALUES('Route 209');
INSERT INTO location (locationName) VALUES('Route 210');
INSERT INTO location (locationName) VALUES('Route 211');
INSERT INTO location (locationName) VALUES('Route 212');
INSERT INTO location (locationName) VALUES('Route 213');
INSERT INTO location (locationName) VALUES('Route 214');
INSERT INTO location (locationName) VALUES('Route 215');
INSERT INTO location (locationName) VALUES('Route 216');
INSERT INTO location (locationName) VALUES('Route 217');
INSERT INTO location (locationName) VALUES('Route 218');
INSERT INTO location (locationName) VALUES('Route 219');
INSERT INTO location (locationName) VALUES('Route 220');
INSERT INTO location (locationName) VALUES('Route 221');
INSERT INTO location (locationName) VALUES('Route 222');
INSERT INTO location (locationName) VALUES('Route 223');
INSERT INTO location (locationName) VALUES('Route 224');
INSERT INTO location (locationName) VALUES('Route 225');
INSERT INTO location (locationName) VALUES('Route 226');
INSERT INTO location (locationName) VALUES('Route 227');
INSERT INTO location (locationName) VALUES('Route 228');
INSERT INTO location (locationName) VALUES('Route 229');
INSERT INTO location (locationName) VALUES('Route 230');
INSERT INTO location (locationName) VALUES('Acuity Lakefront');
INSERT INTO location (locationName) VALUES('Amity Square');
INSERT INTO location (locationName) VALUES('Battle Frontier');
INSERT INTO location (locationName) VALUES('Battle Park');
INSERT INTO location (locationName) VALUES('Canalave City');
INSERT INTO location (locationName) VALUES('Celestic Town');
INSERT INTO location (locationName) VALUES('Distortion World');
INSERT INTO location (locationName) VALUES('Eterna City');
INSERT INTO location (locationName) VALUES('Eterna Forest');
INSERT INTO location (locationName) VALUES('Eterna Galactic Building');
INSERT INTO location (locationName) VALUES('Fight Area');
INSERT INTO location (locationName) VALUES('Floaroma Meadow');
INSERT INTO location (locationName) VALUES('Floaroma Town');
INSERT INTO location (locationName) VALUES('Flower Paradise');
INSERT INTO location (locationName) VALUES('Fuego Ironworks');
INSERT INTO location (locationName) VALUES('Full Moon Island');
INSERT INTO location (locationName) VALUES('Galactic Warehouse');
INSERT INTO location (locationName) VALUES('Grand Lake Hotel');
INSERT INTO location (locationName) VALUES('Great Marsh');
INSERT INTO location (locationName) VALUES('Hall of Origin');
INSERT INTO location (locationName) VALUES('Hearthome City');
INSERT INTO location (locationName) VALUES('Iron Island');
INSERT INTO location (locationName) VALUES('Jubilife City');
INSERT INTO location (locationName) VALUES('Lake Acuity');
INSERT INTO location (locationName) VALUES('Lake Valor');
INSERT INTO location (locationName) VALUES('Lake Verity');
INSERT INTO location (locationName) VALUES('Lost Tower');
INSERT INTO location (locationName) VALUES('Mt. Coronet');
INSERT INTO location (locationName) VALUES('New Moon Island');
INSERT INTO location (locationName) VALUES('Old Chateau');
INSERT INTO location (locationName) VALUES('Oreburgh City');
INSERT INTO location (locationName) VALUES('Oreburgh Gate');
INSERT INTO location (locationName) VALUES('Oreburgh Mine');
INSERT INTO location (locationName) VALUES('Pal Park');
INSERT INTO location (locationName) VALUES('Pastoria City');
INSERT INTO location (locationName) VALUES('Pokemon League');
INSERT INTO location (locationName) VALUES('Pokemon Mansion');
INSERT INTO location (locationName) VALUES('Ravaged Path');
INSERT INTO location (locationName) VALUES('Resort Area');
INSERT INTO location (locationName) VALUES('Ruins Maniacs Cave');
INSERT INTO location (locationName) VALUES('Ruins Maniacs Tunnel');
INSERT INTO location (locationName) VALUES('Sandgem Town');
INSERT INTO location (locationName) VALUES('Seabreak Path');
INSERT INTO location (locationName) VALUES('Sendoff Spring');
INSERT INTO location (locationName) VALUES('Snowpoint City');
INSERT INTO location (locationName) VALUES('Snowpoint Temple');
INSERT INTO location (locationName) VALUES('Solaceon Ruins');
INSERT INTO location (locationName) VALUES('Solaceon Town');
INSERT INTO location (locationName) VALUES('Spear Pillar');
INSERT INTO location (locationName) VALUES('Stark Mountain');
INSERT INTO location (locationName) VALUES('Sunyshore City');
INSERT INTO location (locationName) VALUES('Survival Area');
INSERT INTO location (locationName) VALUES('Trophy Garden');
INSERT INTO location (locationName) VALUES('Turnback Cave');
INSERT INTO location (locationName) VALUES('Twinleaf Town');
INSERT INTO location (locationName) VALUES('Valley Windworks');
INSERT INTO location (locationName) VALUES('Valor Lakefront');
INSERT INTO location (locationName) VALUES('Veilstone City');
INSERT INTO location (locationName) VALUES('Veilstone Galactic Building');
INSERT INTO location (locationName) VALUES('Verity Lakefront');
INSERT INTO location (locationName) VALUES('Victory Road');
INSERT INTO location (locationName) VALUES('Wayward Cave');

INSERT INTO trainer (trainerID, secretID, trainerName, money, score, pokedexCount, time, startTime) VALUES(43554, 10005, 'Jerry', 955302, 4987, 477, '50:51', 'Dec. 15, 2008');

INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (001,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (001,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (002,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (002,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (003,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (003,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (004,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (004,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (005,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (005,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (006,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (006,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (007,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (007,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (008,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (008,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (009,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (009,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (010,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (011,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (012,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (013,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (014,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (015,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (016,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (017,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (018,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (019,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (020,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (021,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (022,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (023,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (023,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (024,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (024,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (025,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (025,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (026,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (026,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (027,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (028,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (029,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (029,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (032,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (032,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (033,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (033,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (034,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (034,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (035,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (036,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (037,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (038,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (039,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (040,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (041,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (042,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (043,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (044,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (045,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (046,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (046,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (047,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (047,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (048,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (049,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (050,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (051,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (052,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (053,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (054,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (054,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (055,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (055,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (056,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (057,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (058,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (059,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (060,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (061,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (062,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (063,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (064,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (065,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (066,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (067,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (068,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (069,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (070,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (071,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (072,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (073,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (074,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (075,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (076,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (077,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (078,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (079,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (079,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (080,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (080,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (081,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (082,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (083,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (083,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (084,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (085,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (086,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (086,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (087,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (087,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (088,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (089,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (090,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (091,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (092,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (093,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (094,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (095,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (096,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (097,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (098,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (099,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (100,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (101,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (102,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (103,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (104,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (105,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (106,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (107,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (108,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (109,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (110,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (111,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (111,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (112,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (112,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (113,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (114,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (115,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (116,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (116,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (117,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (117,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (118,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (119,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (120,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (121,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (122,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (123,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (124,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (125,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (126,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (127,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (128,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (129,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (129,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (130,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (130,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (131,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (131,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (132,'Ditto')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (133,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (134,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (135,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (136,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (137,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (138,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (138,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (139,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (139,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (140,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (140,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (141,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (141,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (142,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (143,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (147,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (147,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (148,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (148,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (149,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (149,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (152,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (152,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (153,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (153,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (154,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (154,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (155,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (156,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (157,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (158,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (158,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (159,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (159,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (160,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (160,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (161,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (162,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (163,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (164,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (165,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (166,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (167,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (168,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (169,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (170,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (171,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (176,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (176,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (177,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (178,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (179,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (179,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (180,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (180,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (181,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (181,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (182,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (183,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (183,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (184,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (184,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (185,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (186,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (187,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (187,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (188,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (188,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (189,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (189,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (190,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (191,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (192,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (193,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (194,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (194,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (195,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (195,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (196,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (197,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (198,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (199,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (199,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (200,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (202,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (203,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (204,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (205,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (206,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (207,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (208,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (209,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (209,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (210,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (210,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (211,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (212,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (213,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (214,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (215,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (216,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (217,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (218,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (219,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (220,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (221,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (222,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (222,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (223,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (223,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (224,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (224,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (225,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (225,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (226,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (227,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (228,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (229,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (230,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (230,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (231,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (232,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (233,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (234,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (235,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (237,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (241,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (242,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (246,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (247,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (248,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (252,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (252,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (253,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (253,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (254,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (254,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (255,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (256,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (257,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (258,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (258,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (259,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (259,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (260,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (260,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (261,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (262,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (263,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (264,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (265,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (266,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (267,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (268,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (269,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (270,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (270,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (271,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (271,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (272,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (272,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (273,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (273,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (274,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (274,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (275,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (275,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (276,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (277,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (278,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (278,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (279,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (279,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (280,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (281,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (282,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (283,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (283,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (284,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (284,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (285,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (285,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (286,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (286,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (287,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (288,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (289,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (290,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (291,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (292,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (293,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (293,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (294,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (294,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (295,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (295,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (296,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (297,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (299,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (300,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (300,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (301,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (301,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (302,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (303,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (303,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (304,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (305,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (306,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (307,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (308,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (309,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (310,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (311,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (312,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (313,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (313,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (314,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (314,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (315,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (315,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (316,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (317,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (318,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (319,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (320,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (320,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (321,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (321,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (322,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (323,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (324,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (325,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (326,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (327,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (327,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (328,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (329,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (330,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (331,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (331,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (332,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (332,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (333,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (333,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (334,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (334,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (335,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (336,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (336,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (337,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (338,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (339,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (340,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (341,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (341,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (342,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (342,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (343,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (344,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (345,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (346,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (347,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (348,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (349,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (349,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (350,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (350,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (351,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (351,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (352,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (353,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (354,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (355,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (356,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (357,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (357,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (358,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (359,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (361,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (361,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (362,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (362,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (363,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (363,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (364,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (364,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (365,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (365,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (366,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (367,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (368,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (369,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (369,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (370,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (371,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (372,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (373,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (374,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (375,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (376,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (387,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (387,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (388,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (388,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (389,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (389,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (390,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (390,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (391,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (391,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (392,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (392,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (393,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (393,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (394,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (394,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (395,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (395,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (396,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (397,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (398,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (399,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (399,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (400,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (400,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (401,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (402,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (403,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (404,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (405,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (407,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (407,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (408,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (409,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (410,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (411,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (412,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (413,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (414,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (415,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (416,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (417,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (417,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (418,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (418,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (419,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (419,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (420,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (420,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (421,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (421,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (422,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (422,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (423,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (423,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (424,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (425,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (426,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (427,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (427,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (428,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (428,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (429,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (430,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (431,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (432,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (434,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (435,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (436,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (437,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (441,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (442,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (443,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (443,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (444,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (444,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (445,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (445,'Dragon')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (448,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (448,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (449,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (450,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (451,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (451,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (452,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (452,'Water3')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (453,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (454,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (455,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (456,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (457,'Water2')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (459,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (459,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (460,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (460,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (461,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (462,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (463,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (464,'Monster')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (464,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (465,'Plant')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (466,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (467,'Humanshape')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (468,'Flying')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (468,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (469,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (470,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (471,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (472,'Bug')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (473,'Ground')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (474,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (475,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (476,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (477,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (478,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (478,'Mineral')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (479,'Indeterminate')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (489,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (489,'Fairy')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (490,'Water1')
INSERT INTO pokemonEggGroups (dexNum,eggGroup) VALUES (490,'Fairy')

INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (001,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (001,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (002,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (002,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (003,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (003,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (004,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (005,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (006,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (006,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (007,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (008,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (009,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (010,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (011,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (012,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (012,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (013,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (013,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (014,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (014,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (015,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (015,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (016,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (016,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (017,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (017,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (018,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (018,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (019,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (020,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (021,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (021,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (022,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (022,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (023,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (024,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (025,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (026,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (027,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (028,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (029,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (030,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (031,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (031,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (032,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (033,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (034,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (034,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (035,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (036,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (037,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (038,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (039,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (040,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (041,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (041,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (042,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (042,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (043,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (043,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (044,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (044,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (045,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (045,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (046,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (046,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (047,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (047,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (048,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (048,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (049,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (049,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (050,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (051,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (052,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (053,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (054,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (055,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (056,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (057,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (058,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (059,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (060,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (061,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (062,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (062,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (063,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (064,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (065,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (066,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (067,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (068,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (069,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (069,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (070,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (070,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (071,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (071,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (072,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (072,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (073,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (073,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (074,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (074,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (075,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (075,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (076,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (076,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (077,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (078,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (079,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (079,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (080,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (080,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (081,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (081,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (082,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (082,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (083,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (083,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (084,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (084,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (085,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (085,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (086,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (087,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (087,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (088,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (089,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (090,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (091,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (091,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (092,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (092,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (093,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (093,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (094,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (094,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (095,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (095,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (096,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (097,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (098,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (099,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (100,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (101,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (102,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (102,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (103,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (103,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (104,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (105,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (106,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (107,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (108,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (109,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (110,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (111,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (111,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (112,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (112,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (113,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (114,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (115,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (116,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (117,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (118,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (119,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (120,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (121,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (121,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (122,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (123,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (123,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (124,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (124,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (125,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (126,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (127,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (128,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (129,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (130,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (130,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (131,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (131,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (132,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (133,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (134,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (135,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (136,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (137,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (138,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (138,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (139,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (139,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (140,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (140,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (141,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (141,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (142,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (142,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (143,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (144,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (144,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (145,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (145,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (146,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (146,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (147,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (148,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (149,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (149,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (150,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (151,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (152,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (153,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (154,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (155,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (156,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (157,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (158,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (159,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (160,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (161,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (162,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (163,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (163,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (164,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (164,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (165,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (165,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (166,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (166,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (167,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (167,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (168,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (168,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (169,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (169,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (170,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (170,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (171,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (171,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (172,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (173,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (174,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (175,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (176,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (176,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (177,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (177,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (178,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (178,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (179,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (180,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (181,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (182,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (183,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (184,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (185,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (186,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (187,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (187,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (188,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (188,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (189,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (189,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (190,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (191,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (192,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (193,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (193,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (194,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (194,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (195,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (195,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (196,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (197,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (198,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (198,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (199,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (199,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (200,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (201,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (202,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (203,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (203,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (204,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (205,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (205,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (206,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (207,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (207,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (208,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (208,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (209,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (210,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (211,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (211,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (212,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (212,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (213,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (213,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (214,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (214,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (215,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (215,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (216,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (217,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (218,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (219,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (219,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (220,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (220,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (221,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (221,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (222,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (222,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (223,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (224,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (225,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (225,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (226,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (226,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (227,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (227,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (228,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (228,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (229,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (229,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (230,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (230,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (231,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (232,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (233,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (234,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (235,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (236,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (237,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (238,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (238,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (239,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (240,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (241,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (242,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (243,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (244,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (245,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (246,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (246,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (247,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (247,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (248,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (248,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (249,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (249,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (250,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (250,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (251,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (251,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (252,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (253,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (254,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (255,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (256,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (256,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (257,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (257,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (258,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (259,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (259,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (260,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (260,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (261,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (262,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (263,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (264,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (265,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (266,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (267,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (267,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (268,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (269,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (269,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (270,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (270,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (271,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (271,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (272,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (272,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (273,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (274,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (274,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (275,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (275,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (276,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (276,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (277,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (277,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (278,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (278,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (279,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (279,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (280,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (281,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (282,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (283,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (283,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (284,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (284,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (285,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (286,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (286,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (287,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (288,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (289,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (290,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (290,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (291,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (291,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (292,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (292,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (293,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (294,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (295,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (296,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (297,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (298,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (299,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (300,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (301,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (302,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (302,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (303,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (304,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (304,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (305,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (305,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (306,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (306,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (307,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (307,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (308,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (308,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (309,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (310,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (311,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (312,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (313,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (314,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (315,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (315,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (316,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (317,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (318,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (318,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (319,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (319,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (320,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (321,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (322,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (322,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (323,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (323,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (324,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (325,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (326,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (327,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (328,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (329,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (329,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (330,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (330,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (331,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (332,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (332,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (333,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (333,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (334,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (334,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (335,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (336,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (337,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (337,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (338,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (338,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (339,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (339,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (340,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (340,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (341,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (342,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (342,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (343,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (343,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (344,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (344,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (345,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (345,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (346,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (346,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (347,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (347,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (348,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (348,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (349,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (350,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (351,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (352,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (353,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (354,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (355,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (356,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (357,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (357,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (358,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (359,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (360,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (361,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (362,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (363,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (363,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (364,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (364,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (365,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (365,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (366,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (367,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (368,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (369,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (369,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (370,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (371,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (372,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (373,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (373,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (374,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (374,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (375,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (375,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (376,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (376,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (377,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (378,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (379,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (380,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (380,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (381,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (381,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (382,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (383,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (384,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (384,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (385,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (385,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (386,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (387,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (388,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (389,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (389,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (390,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (391,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (391,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (392,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (392,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (393,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (394,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (395,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (395,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (396,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (396,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (397,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (397,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (398,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (398,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (399,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (400,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (400,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (401,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (402,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (403,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (404,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (405,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (406,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (406,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (407,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (407,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (408,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (409,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (410,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (410,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (411,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (411,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (412,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (413,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (413,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (414,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (414,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (415,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (415,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (416,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (416,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (417,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (418,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (419,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (420,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (421,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (422,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (423,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (423,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (424,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (425,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (425,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (426,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (426,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (427,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (428,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (429,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (430,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (430,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (431,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (432,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (433,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (434,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (434,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (435,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (435,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (436,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (436,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (437,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (437,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (438,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (439,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (440,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (441,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (441,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (442,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (442,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (443,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (443,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (444,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (444,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (445,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (445,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (446,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (447,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (448,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (448,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (449,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (450,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (451,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (451,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (452,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (452,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (453,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (453,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (454,'Poison')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (454,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (455,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (456,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (457,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (458,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (458,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (459,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (459,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (460,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (460,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (461,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (461,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (462,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (462,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (463,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (464,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (464,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (465,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (466,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (467,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (468,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (468,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (469,'Bug')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (469,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (470,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (471,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (472,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (472,'Flying')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (473,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (473,'Ground')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (474,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (475,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (475,'Fighting')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (476,'Rock')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (476,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (477,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (478,'Ice')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (478,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (479,'Electric')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (479,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (480,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (481,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (482,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (483,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (483,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (484,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (484,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (485,'Fire')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (485,'Steel')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (486,'Normal')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (487,'Ghost')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (487,'Dragon')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (488,'Psychic')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (489,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (490,'Water')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (491,'Dark')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (492,'Grass')
INSERT INTO pokemonHasTypes (dexNum,typeName) VALUES (493,'Normal')

INSERT INTO moveHasType (moveName,typeName) VALUES ('Absorb','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Acid','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Acid Armor','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Acupressure','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Aerial Ace','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Aeroblast','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Agility','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Air Cutter','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Air Slash','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Amnesia','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ancientpower','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Aqua Jet','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Aqua Ring','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Aqua Tail','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Arm Thrust','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Aromatherapy','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Assist','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Assurance','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Astonish','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Attack Order','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Attract','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Aura Sphere','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Aurora Beam','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Avalanche','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Barrage','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Barrier','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Baton Pass','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Beat Up','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Belly Drum','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bide','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bind','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bite','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Blast Burn','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Blaze Kick','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Blizzard','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Block','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Body Slam','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bone Club','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bone Rush','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bonemerang','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bounce','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Brave Bird','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Brick Break','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Brine','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bubble','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bubblebeam','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bug Bite','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bug Buzz','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bulk Up','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bullet Punch','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Bullet Seed','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Calm Mind','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Camouflage','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Captivate','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Charge','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Charge Beam','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Charm','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Chatter','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Clamp','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Close Combat','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Comet Punch','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Confuse Ray','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Confusion','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Constrict','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Conversion','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Conversion 2','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Copycat','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Cosmic Power','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Cotton Spore','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Counter','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Covet','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Crabhammer','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Cross Chop','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Cross Poison','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Crunch','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Crush Claw','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Crush Grip','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Curse','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Cut','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dark Pulse','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dark Void','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Defense Curl','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Defend Order','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Defog','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Destiny Bond','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Detect','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dig','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Disable','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Discharge','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dive','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dizzy Punch','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Doom Desire','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Double Hit','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Double Kick','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Double Team','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Double-edge','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Doubleslap','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Draco Meteor','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dragon Claw','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dragon Dance','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dragon Pulse','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dragon Rage','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dragon Rush','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dragonbreath','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Drain Punch','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dream Eater','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Drill Peck','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Dynamicpunch','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Earth Power','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Earthquake','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Egg Bomb','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Embargo','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ember','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Encore','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Endeavor','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Endure','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Energy Ball','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Eruption','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Explosion','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Extrasensory','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Extremespeed','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Facade','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Faint Attack','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fake Out','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fake Tears','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('False Swipe','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Featherdance','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Feint','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fire Blast','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fire Fang','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fire Punch','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fire Spin','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fissure','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Flail','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Flame Wheel','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Flamethrower','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Flare Blitz','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Flash','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Flash Cannon','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Flatter','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fling','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fly','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Focus Blast','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Focus Energy','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Focus Punch','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Follow Me','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Force Palm','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Foresight','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Frenzy Plant','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Frustration','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fury Attack','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fury Cutter','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Fury Swipes','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Future Sight','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Gastro Acid','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Giga Drain','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Giga Impact','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Glare','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Grass Knot','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Grasswhistle','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Gravity','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Growl','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Growth','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Grudge','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Guard Swap','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Guillotine','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Gunk Shot','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Gust','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Gyro Ball','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hail','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hammer Arm','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Harden','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Haze','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Head Smash','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Headbutt','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Heal Bell','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Heal Block','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Heal Order','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Healing Wish','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Heart Swap','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Heat Wave','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Helping Hand','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hi Jump Kick','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hidden Power','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Horn Attack','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Horn Drill','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Howl','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hydro Cannon','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hydro Pump','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hyper Beam','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hyper Fang','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hyper Voice','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Hypnosis','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ice Ball','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ice Beam','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ice Fang','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ice Punch','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ice Shard','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Icicle Spear','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Icy Wind','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Imprison','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ingrain','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Iron Defense','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Iron Head','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Iron Tail','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Judgment','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Jump Kick','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Karate Chop','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Kinesis','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Knock Off','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Last Resort','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Lava Plume','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Leaf Blade','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Leaf Storm','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Leech Life','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Leech Seed','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Leer','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Lick','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Light Screen','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Lock-on','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Lovely Kiss','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Low Kick','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Lucky Chant','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Lunar Dance','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Luster Purge','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mach Punch','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Magic Coat','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Magical Leaf','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Magma Storm','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Magnet Bomb','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Magnet Rise','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Magnitude','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Me First','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mean Look','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Meditate','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mega Drain','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mega Kick','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mega Punch','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Megahorn','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Memento','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Metal Burst','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Metal Claw','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Metal Sound','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Meteor Mash','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Metronome','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Milk Drink','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mimic','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mind Reader','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Minimize','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Miracle Eye','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mirror Coat','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mirror Move','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mirror Shot','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mist','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mist Ball','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Moonlight','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Morning Sun','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mud Bomb','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mud Shot','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mud Sport','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Mud-slap','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Muddy Water','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Nasty Plot','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Natural Gift','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Nature Power','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Needle Arm','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Night Shade','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Night Slash','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Nightmare','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Octazooka','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Odor Sleuth','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Ominous Wind','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Outrage','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Overheat','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Pain Split','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Pay Day','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Payback','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Peck','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Perish Song','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Petal Dance','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Pin Missile','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Pluck','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Poison Fang','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Poison Gas','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Poison Jab','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Poison Sting','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Poison Tail','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Poisonpowder','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Pound','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Powder Snow','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Power Gem','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Power Swap','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Power Trick','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Power Whip','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Present','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Protect','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Psybeam','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Psych Up','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Psychic','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Psycho Boost','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Psycho Cut','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Psycho Shift','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Psywave','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Punishment','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Pursuit','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Quick Attack','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rage','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rain Dance','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rapid Spin','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Razor Leaf','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Razor Wind','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Recover','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Recycle','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Reflect','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Refresh','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rest','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Return','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Revenge','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Reversal','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Roar','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Roar Of Time','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rock Blast','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rock Climb','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rock Polish','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rock Slide','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rock Smash','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rock Throw','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rock Tomb','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rock Wrecker','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Role Play','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rolling Kick','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Rollout','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Roost','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sacred Fire','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Safeguard','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sand Tomb','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sand-attack','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sandstorm','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Scary Face','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Scratch','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Screech','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Secret Power','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Seed Bomb','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Seed Flare','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Seismic Toss','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Selfdestruct','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Shadow Ball','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Shadow Claw','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Shadow Force','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Shadow Punch','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Shadow Sneak','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sharpen','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sheer Cold','Ice')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Shock Wave','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Signal Beam','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Silver Wind','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sing','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sketch','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Skill Swap','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Skull Bash','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sky Attack','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sky Uppercut','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Slack Off','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Slam','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Slash','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sleep Powder','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sleep Talk','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sludge','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sludge Bomb','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Smellingsalt','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Smog','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Smokescreen','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Snatch','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Snore','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Softboiled','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Solarbeam','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sonicboom','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Spacial Rend','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Spark','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Spider Web','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Spike Cannon','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Spikes','Ground')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Spit Up','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Spite','Ghost')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Splash','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Spore','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Stealth Rock','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Steel Wing','Steel')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Stockpile','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Stomp','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Stone Edge','Rock')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Strength','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('String Shot','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Struggle','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Stun Spore','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Submission','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Substitute','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sucker Punch','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sunny Day','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Super Fang','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Superpower','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Supersonic','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Surf','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Swagger','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Swallow','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sweet Kiss','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Sweet Scent','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Swift','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Switcheroo','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Swords Dance','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Synthesis','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Tackle','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Tail Glow','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Tail Whip','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Tailwind','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Take Down','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Taunt','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Teeter Dance','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Teleport','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Thief','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Thrash','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Thunder','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Thunder Fang','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Thunder Wave','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Thunderbolt','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Thunderpunch','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Thundershock','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Tickle','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Torment','Dark')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Toxic','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Toxic Spikes','Poison')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Transform','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Tri Attack','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Trick','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Trick Room','Psychic')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Triple Kick','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Trump Card','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Twineedle','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Twister','Dragon')
INSERT INTO moveHasType (moveName,typeName) VALUES ('U-turn','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Uproar','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Vacuum Wave','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Vicegrip','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Vine Whip','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Vital Throw','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Volt Tackle','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Wake-up Slap','Fighting')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Water Gun','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Water Pulse','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Water Sport','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Water Spout','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Waterfall','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Weather Ball','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Whirlpool','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Whirlwind','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Will-o-wisp','Fire')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Wing Attack','Flying')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Wish','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Withdraw','Water')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Wood Hammer','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Worry Seed','Grass')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Wrap','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Wring Out','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('X-scissor','Bug')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Yawn','Normal')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Zap Cannon','Electric')
INSERT INTO moveHasType (moveName,typeName) VALUES ('Zen Headbutt','Psychic')

INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fire','Grass');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fire','Ice');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fire','Bug');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fire','Steel');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Water','Fire');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Water','Ground');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Water','Rock');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Electric','Water');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Electric','Flying');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Grass','Water');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Grass','Ground');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Grass','Rock');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ice','Grass');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ice','Ground');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ice','Flying');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ice','Dragon');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fighting','Normal');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fighting','Ice');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fighting','Rock');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fighting','Dark');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Fighting','Steel');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Poison','Grass');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ground','Fire');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ground','Electric');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ground','Poison');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ground','Rock');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ground','Steel');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Flying','Grass');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Flying','Fighting');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Flying','Bug');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Psychic','Fighting');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Psychic','Poison');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Bug','Grass');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Bug','Psychic');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Bug','Dark');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Rock','Fire');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Rock','Ice');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Rock','Flying');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Rock','Bug');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ghost','Psychic');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Ghost','Ghost');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Dragon','Dragon');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Dark','Psychic');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Dark','Ghost');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Steel','Ice');
INSERT INTO isEffectiveAgainst (atkTypeName,defTypeName) VALUES ('Steel','Rock');



INSERT INTO trainerOwns (dexNum, trainerID) VALUES(003, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(034, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(105, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(123, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(133, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(267, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(299, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(301, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(311, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(323, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(367, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(420, 43554);
INSERT INTO trainerOwns (dexNum, trainerID) VALUES(421, 43554);













