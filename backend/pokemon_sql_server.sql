--Data scraped from : 
--

--changed baseStats to HP, DEF....
--clean up relations first then entities
--should change effortValues to individual ones like baseStats?
--check superContest
--ON DELETE CASCADES
--add not nulls?
--remove PokemonType from ER? (since we have pokemonHasType table/relation)
--trainer time change to date instead of int?
--DO CLEANUP

use cs3380;

-- clean up
-- Order matters!
drop table if exists pokemonEggGroups;
drop table if exists pokemonLearnsMoveBy;
drop table if exists pokemonAbilities;
drop table if exists trainerOwns;
drop table if exists locatedAt;
drop table if exists effectiveness;
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
    gender text,
    height REAL not null,
    weight REAL not null,
    captureRate REAL not null,
    classification text,
    nature text not null,
    expGrowth REAL not null,
    baseHappiness REAL not null,
    colour text not null,
    eggSteps integer,
    effortValues text,
    characteristic text,
    evolveMethod text
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
    superContest text, --could be a bit value instead?
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
    time integer not null, --DATE?
    startTime integer not null --DATE?
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

create table effectiveness(
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











