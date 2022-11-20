--Data scraped from : 
--

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
-- Order matters!
drop table if exists pokemonEggGroups;
drop table if exists pokemonLearnsMoveBy;
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


create table pokemon (
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
    eggSteps integer,
    --evolveMethod text
);

create table type (
    typeName varchar(100) primary key
);

create table move (
    moveName varchar(100) primary key,
    basePower integer,
    accuracy integer,
    effect text,
    battleType text,
    category text,
    powerPoints integer,
    description text,
    speedPrio text, --bit value?
    moveLevel integer
);

create table location (
    locationName varchar(100) primary key
);

create table trainer (
    trainerID integer primary key,
    secretID integer,
    trainerName text,
    money integer not null,
    score integer not null,
    pokedexCount integer not null,
    time text not null, --DATE?
    startTime text not null --DATE?
);

create table pokemonEggGroups (
    dexNum integer references pokemon(dexNum),
    eggGroup varchar(100) not null,
    primary key (dexNum, eggGroup)
);

create table pokemonAbilities (
    dexNum integer references pokemon(dexNum),
    ability varchar(100) not null,
    primary key (dexNum, ability)
);

create table pokemonLearnsMoveBy (
    dexNum integer references pokemon(dexNum),
    moveName varchar(100) references move(moveName),
    learnsBy varchar(100),
    primary key (dexNum, moveName, learnsBy)
);

--relatations

create table pokemonHasTypes ( --same as hasType relation
    dexNum integer references pokemon(dexNum),
    pokeType varchar(100) references type(typeName),
    primary key (dexNum, pokeType)
);

create table moveHasType( --isType relation
    moveName varchar(100) references move(moveName),
    typeName varchar(100) references type(typeName),
    primary key (moveName, typeName)
);

create table isEffectiveAgainst(
    atkTypeName varchar(100) references type(typeName), --attacking type
    defTypeName varchar(100) references type(typeName), --defending type
    primary key (atkTypeName, defTypeName)
);

create table locatedAt(
    dexNum integer references pokemon(dexNum),
    locationName varchar(100) references location(locationName),
    primary key (dexNum, locationName)
);

create table trainerOwns(
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

INSERT INTO trainer (trainerID, secretID, trainerName, money, score, pokedexCount, time, startTime) VALUES(43554, 10005, 'Jerry', 955302, 4987, 477, '50:51', 'Dec. 15, 2008');

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











