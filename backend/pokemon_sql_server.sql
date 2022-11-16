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
drop table if exists viewed;
drop table if exists orderLineItems;
drop table if exists orders;
drop table if exists people;
drop table if exists products;
drop table if exists provinces;

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
    typeName text primary key
);

create table move (
    moveName text primary key,
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
    locationName text primary key
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
    eggGroup text not null,
    primary key (dexNum, eggGroup)
);

create table pokemonAbilities (
    dexNum integer references pokemon(dexNum),
    ability text not null,
    primary key (dexNum, ability)
);

create table pokemonHasTypes ( --same as hasType relation
    dexNum integer references pokemon(dexNum),
    pokeType text references type(typeName),
    primary key (dexNum, pokeType)
);

create table pokemonLearnsMoveBy (
    dexNum integer references pokemon(dexNum),
    moveName text references move(moveName),
    learnsBy text,
    primary key (dexNum, moveName, learnsBy)
);

--relatations

create table moveHasType( --isType relation
    moveName text references move(moveName),
    typeName text references type(typeName),
    primary key (moveName, typeName)
);

create table effectiveness(
    atkTypeName text references type(typeName), --attacking type
    defTypeName text references type(typeName), --defending type
    primary key (atkTypeName, defTypeName)
);

create table locatedAt(
    dexNum integer references pokemon(dexNum),
    locationName text references location(locationName),
    primary key (dexNum, locationName)
);

create table trainerOwns(
    dexNum integer references pokemon(dexNum),
    trainerID integer references trainer(trainerID),
    primary key (dexNum, trainerID)
);








-- --------------------------------------FROM DEMO---------------------------------------------
-- clean up
-- Order matters!
drop table if exists viewed;
drop table if exists orderLineItems;
drop table if exists orders;
drop table if exists people;
drop table if exists products;
drop table if exists provinces;

create table provinces (
    provinceID varchar(100) primary key,
    name text not null,
    taxRate REAL not null
);

create table products (
    productID integer primary key IDENTITY(1,1),
    price numeric,
    prodName text
);

create table people (
    personID integer primary key IDENTITY(1,1),
    firstname text not null,
    lastname text not null,
    provinceID varchar(100) references provinces
);

create table viewed (
    personID integer references people(personID),
    productID integer references products(productID),
    -- just to show both ways
    -- foreign key (productID) references products(productID),
    primary key (personID, productID)
);

create table orders(
    orderID integer primary key,
    personID integer references people
    -- could imagine a date here, shipping info, etc.
);

create table orderLineItems(
    lineItemID integer primary key IDENTITY(1,1),
    orderID integer references orders on delete cascade,
    productID integer references products(productID)
);

-- data from 
insert into provinces values ('MB', 'Manitoba', 0.05);
insert into provinces values ('AB', 'Alberta', 0.00);
insert into provinces values ('SK', 'Saskatchewan', 0.06);
insert into provinces values ('BC', 'British Columbia', 0.07);
insert into provinces values ('ON', 'Ontario', 0.08); -- technically HST, but...

INSERT INTO Products (price, prodName) VALUES(24.99,'1 Second Slicer');
INSERT INTO Products (price, prodName) VALUES(92.85,'10-Minute Trainer From Tony Horton');
INSERT INTO Products (price, prodName) VALUES(74.85,'21 Day Fix Extreme');
INSERT INTO Products (price, prodName) VALUES(72.82,'21 Day Fix Fitness and Weight Loss Program');
INSERT INTO Products (price, prodName) VALUES(99.79,'22 Minute Hard Corps Workout');
INSERT INTO Products (price, prodName) VALUES(14.95,'3 Minute Legs');
INSERT INTO Products (price, prodName) VALUES(72.82,'3 Week Yoga Retreat – Now on DVD');
INSERT INTO Products (price, prodName) VALUES(14.95,'30 Second Smile');
INSERT INTO Products (price, prodName) VALUES(19.99,'35 Below Compression Socks – Compression & Warming Socks');
INSERT INTO Products (price, prodName) VALUES(19.99,'35 Below Socks');
INSERT INTO Products (price, prodName) VALUES(149.99,'5 Mins Shaper Pro');
INSERT INTO Products (price, prodName) VALUES(10.99,'5 Second Fix');
INSERT INTO Products (price, prodName) VALUES(19.99,'6 Week Body Makeover');
INSERT INTO Products (price, prodName) VALUES(161.94,'60s Music Revolution 9 CD Box Set');
INSERT INTO Products (price, prodName) VALUES(14.95,'Ab Circle Pro');
INSERT INTO Products (price, prodName) VALUES(299.99,'Ab Coaster');
INSERT INTO Products (price, prodName) VALUES(143.49,'Ab Doer Twist');
INSERT INTO Products (price, prodName) VALUES(89.99,'Ab Flyer');
INSERT INTO Products (price, prodName) VALUES(149.99,'Ab Glider');
INSERT INTO Products (price, prodName) VALUES(14.95,'Ab Rocket Twister');
INSERT INTO Products (price, prodName) VALUES(14.95,'Ab Rocket');
INSERT INTO Products (price, prodName) VALUES(99.99,'Ab Transform');
INSERT INTO Products (price, prodName) VALUES(9.99,'Aero Knife');
INSERT INTO Products (price, prodName) VALUES(19.95,'Ageless Male');
INSERT INTO Products (price, prodName) VALUES(59.99,'Ahh Bra');
INSERT INTO Products (price, prodName) VALUES(99.99,'Air Climber');
INSERT INTO Products (price, prodName) VALUES(69.42,'Alli');
INSERT INTO Products (price, prodName) VALUES(10.99,'Aluma Wallet');
INSERT INTO Products (price, prodName) VALUES(9.95,'Always Fresh Containers');
INSERT INTO Products (price, prodName) VALUES(14.95,'Aqua Globes');
INSERT INTO Products (price, prodName) VALUES(19.99,'Awesome Auger');
INSERT INTO Products (price, prodName) VALUES(39.95,'BackBridge');
INSERT INTO Products (price, prodName) VALUES(39.95,'BackJoy Core');
INSERT INTO Products (price, prodName) VALUES(19.99,'Bake Pops');
INSERT INTO Products (price, prodName) VALUES(22.99,'Ball Pets Plush Toys');
INSERT INTO Products (price, prodName) VALUES(14.69,'Balloon Bonanza');
INSERT INTO Products (price, prodName) VALUES(9.99,'Bare Lifts');
INSERT INTO Products (price, prodName) VALUES(3.99,'BarkOff');
INSERT INTO Products (price, prodName) VALUES(7.98,'Battle Balloons Color Burst');
INSERT INTO Products (price, prodName) VALUES(14.99,'Battle Visor – Perfect vision for driving');
INSERT INTO Products (price, prodName) VALUES(19.99,'BattleVision HD Polarized Sunglasses');
INSERT INTO Products (price, prodName) VALUES(19.99,'Bavarian Edge Knife Sharpener');
INSERT INTO Products (price, prodName) VALUES(155.99,'Beachbody On Demand');
INSERT INTO Products (price, prodName) VALUES(56.96,'Beachbody Performance Premium Workout Supplements');
INSERT INTO Products (price, prodName) VALUES(19.99,'BeActive Back Pain Brace');
INSERT INTO Products (price, prodName) VALUES(439.66,'Beamz by Flo Rida');
INSERT INTO Products (price, prodName) VALUES(19.95,'Bed Renu Custom Sleep Support System');
INSERT INTO Products (price, prodName) VALUES(19.99,'BeDazzler');
INSERT INTO Products (price, prodName) VALUES(34.49,'Bedtime Buddies Stuffed Animals');
INSERT INTO Products (price, prodName) VALUES(19.99,'Bendaroos');
INSERT INTO Products (price, prodName) VALUES(12.99,'Bender Ball');
INSERT INTO Products (price, prodName) VALUES(19.85,'Best of the Ed Sullivan Show DVD Collection');
INSERT INTO Products (price, prodName) VALUES(99.95,'Best of the Tonight Show Starring Johnny Carson DVD Box Set');
INSERT INTO Products (price, prodName) VALUES(89.95,'Better Bladder Supplement');
INSERT INTO Products (price, prodName) VALUES(16.99,'Better Brella – The New Improved Umbrella');
INSERT INTO Products (price, prodName) VALUES(4.99,'Better Strainer');
INSERT INTO Products (price, prodName) VALUES(49.99,'Big Boss Blender');
INSERT INTO Products (price, prodName) VALUES(59.99,'Big Boss Grill');
INSERT INTO Products (price, prodName) VALUES(53.85,'Big Boss InstaMop');
INSERT INTO Products (price, prodName) VALUES(149.99,'Big Boss Rapid Wave Oven');
INSERT INTO Products (price, prodName) VALUES(19.99,'Big City Slider Station');
INSERT INTO Products (price, prodName) VALUES(19.95,'Big Top Cupcake');
INSERT INTO Products (price, prodName) VALUES(19.99,'Big Top Donut');
INSERT INTO Products (price, prodName) VALUES(99.95,'Bill Gaithers Homecoming Hymns Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(19.99,'Billy Blanks PT 24/7');
INSERT INTO Products (price, prodName) VALUES(69.99,'BioEnergiser Detox Spa System');
INSERT INTO Products (price, prodName) VALUES(33.32,'BioEnergiser');
INSERT INTO Products (price, prodName) VALUES(29.99,'Bit 360 Screwdriver');
INSERT INTO Products (price, prodName) VALUES(179.99,'BladeRunner');
INSERT INTO Products (price, prodName) VALUES(19.95,'BlanKid Buddy');
INSERT INTO Products (price, prodName) VALUES(125.95,'Blood Type Workout');
INSERT INTO Products (price, prodName) VALUES(19.99,'Blue Diamond Enhanced Ceramic Non-Stick Pan');
INSERT INTO Products (price, prodName) VALUES(9.99,'Blueberry Giant');
INSERT INTO Products (price, prodName) VALUES(29.99,'Body Back Buddy');
INSERT INTO Products (price, prodName) VALUES(49.85,'Body Beast DVD Workout');
INSERT INTO Products (price, prodName) VALUES(99.95,'Body Gospel');
INSERT INTO Products (price, prodName) VALUES(29.99,'Body Revolution');
INSERT INTO Products (price, prodName) VALUES(19.99,'Boom Cube');
INSERT INTO Products (price, prodName) VALUES(9.99,'Bottle Tops');
INSERT INTO Products (price, prodName) VALUES(999.99,'Bowflex MAX Trainer Cardio Machine M3/M5/M7');
INSERT INTO Products (price, prodName) VALUES(2499.99,'Bowflex TreadClimber');
INSERT INTO Products (price, prodName) VALUES(12.89,'Bowl Light');
INSERT INTO Products (price, prodName) VALUES(14.99,'Brainetics');
INSERT INTO Products (price, prodName) VALUES(145.58,'BrainPill');
INSERT INTO Products (price, prodName) VALUES(92.75,'Brazil Butt Lift');
INSERT INTO Products (price, prodName) VALUES(29.99,'Brez Anti-Snoring Breathing Aid');
INSERT INTO Products (price, prodName) VALUES(14.99,'Brez Snoring Relief');
INSERT INTO Products (price, prodName) VALUES(25.99,'Bright Light Pillow');
INSERT INTO Products (price, prodName) VALUES(8.77,'Bright Time Buddies');
INSERT INTO Products (price, prodName) VALUES(13.28,'Broda Acne Treatment');
INSERT INTO Products (price, prodName) VALUES(9.95,'Buffalo Tribute Proof');
INSERT INTO Products (price, prodName) VALUES(19.95,'Bug Band');
INSERT INTO Products (price, prodName) VALUES(12.99,'Bullseye Pee Pads');
INSERT INTO Products (price, prodName) VALUES(9.99,'Bumpits');
INSERT INTO Products (price, prodName) VALUES(199.99,'Butterball Indoor Electric Turkey Fryer');
INSERT INTO Products (price, prodName) VALUES(159.96,'Butterball Turkey Fryer');
INSERT INTO Products (price, prodName) VALUES(39.99,'Butterfly Abs');
INSERT INTO Products (price, prodName) VALUES(9.99,'Buxton Cell Phone Wallet');
INSERT INTO Products (price, prodName) VALUES(10.99,'Cafe Cup');
INSERT INTO Products (price, prodName) VALUES(9.99,'Callous Clear');
INSERT INTO Products (price, prodName) VALUES(9.99,'Cami Secret');
INSERT INTO Products (price, prodName) VALUES(15.95,'Canada Green Grass');
INSERT INTO Products (price, prodName) VALUES(19.99,'Cats Meow Toy');
INSERT INTO Products (price, prodName) VALUES(39.95,'Chalean Extreme');
INSERT INTO Products (price, prodName) VALUES(9.95,'Chamonix Skin Care');
INSERT INTO Products (price, prodName) VALUES(14.99,'Chef Basket');
INSERT INTO Products (price, prodName) VALUES(19.99,'Chic Shaper');
INSERT INTO Products (price, prodName) VALUES(19.95,'Chop Magic');
INSERT INTO Products (price, prodName) VALUES(9.99,'Cleavage Clip');
INSERT INTO Products (price, prodName) VALUES(19.95,'College Snuggie');
INSERT INTO Products (price, prodName) VALUES(29.95,'Comfortisse Bra');
INSERT INTO Products (price, prodName) VALUES(10.99,'Comfy Control Harness');
INSERT INTO Products (price, prodName) VALUES(14.95,'Contour Abs');
INSERT INTO Products (price, prodName) VALUES(39.99,'CovFurs');
INSERT INTO Products (price, prodName) VALUES(9.99,'Crazy Critters');
INSERT INTO Products (price, prodName) VALUES(14.99,'Criss Angel Magic Kit');
INSERT INTO Products (price, prodName) VALUES(19.99,'CuddleUppets');
INSERT INTO Products (price, prodName) VALUES(19.95,'Curvassure');
INSERT INTO Products (price, prodName) VALUES(39.95,'Curve Control Jeans');
INSERT INTO Products (price, prodName) VALUES(14.99,'DashCam Pro');
INSERT INTO Products (price, prodName) VALUES(99.99,'Dean Martin Celebrity Roasts Complete DVD Collection');
INSERT INTO Products (price, prodName) VALUES(35.99,'Dean Martin Ultimate DVD Collection');
INSERT INTO Products (price, prodName) VALUES(9.99,'Depil Silk');
INSERT INTO Products (price, prodName) VALUES(144.99,'Derm Exclusive Anti-Aging Skin Care');
INSERT INTO Products (price, prodName) VALUES(39.95,'Derm Exclusive');
INSERT INTO Products (price, prodName) VALUES(36.99,'Derma Seta');
INSERT INTO Products (price, prodName) VALUES(15.99,'Dermasolve Psoriasis Treatment');
INSERT INTO Products (price, prodName) VALUES(19.99,'DermaSuction Blackhead Remover');
INSERT INTO Products (price, prodName) VALUES(19.95,'Designer Snuggie');
INSERT INTO Products (price, prodName) VALUES(14.99,'Detail Doctor');
INSERT INTO Products (price, prodName) VALUES(19.99,'Dial Vision Adjustable Eyeglasses');
INSERT INTO Products (price, prodName) VALUES(42.02,'Dial-a-Smile Professional Home Teeth Whitening System');
INSERT INTO Products (price, prodName) VALUES(14.95,'Diamond Radiance');
INSERT INTO Products (price, prodName) VALUES(19.99,'Diamond Z4 Ring');
INSERT INTO Products (price, prodName) VALUES(110.11,'DirecTV Special Offer');
INSERT INTO Products (price, prodName) VALUES(16.99,'Disney Gyro Bowl');
INSERT INTO Products (price, prodName) VALUES(29.95,'Diva Dangler');
INSERT INTO Products (price, prodName) VALUES(19.95,'Dog E-Minder');
INSERT INTO Products (price, prodName) VALUES(199.96,'Dr. Hos Decompression Back Belt');
INSERT INTO Products (price, prodName) VALUES(14.99,'DrainWig Hair Catcher Prevents Clogs');
INSERT INTO Products (price, prodName) VALUES(19.99,'Dream Lash');
INSERT INTO Products (price, prodName) VALUES(19.99,'Dream Look');
INSERT INTO Products (price, prodName) VALUES(11.73,'Dreamie');
INSERT INTO Products (price, prodName) VALUES(32.85,'Dunstan Baby Language System');
INSERT INTO Products (price, prodName) VALUES(17.99,'DuraWallet');
INSERT INTO Products (price, prodName) VALUES(19.95,'Dust Daddy Vacuum Cleaner Attachment');
INSERT INTO Products (price, prodName) VALUES(13.99,'Dutch Glow Amish Cleaning Tonic');
INSERT INTO Products (price, prodName) VALUES(17.26,'Dutch Glow Amish Wood Milk');
INSERT INTO Products (price, prodName) VALUES(29.95,'Eagle Eyes');
INSERT INTO Products (price, prodName) VALUES(9.99,'Easy Curves');
INSERT INTO Products (price, prodName) VALUES(14.99,'Easy Feet');
INSERT INTO Products (price, prodName) VALUES(9.99,'Easy Reach');
INSERT INTO Products (price, prodName) VALUES(9.99,'Edge Of Glory');
INSERT INTO Products (price, prodName) VALUES(9.99,'Eggies');
INSERT INTO Products (price, prodName) VALUES(19.99,'ElimiTag');
INSERT INTO Products (price, prodName) VALUES(19.95,'Emery Cat');
INSERT INTO Products (price, prodName) VALUES(9.99,'Epi Smooth');
INSERT INTO Products (price, prodName) VALUES(14.95,'EvoraPet');
INSERT INTO Products (price, prodName) VALUES(59.95,'Extenze');
INSERT INTO Products (price, prodName) VALUES(9.99,'Ez Combs');
INSERT INTO Products (price, prodName) VALUES(14.95,'EZ Eyes Keyboard');
INSERT INTO Products (price, prodName) VALUES(69.95,'EZ Smoker');
INSERT INTO Products (price, prodName) VALUES(19.99,'Fab Effex');
INSERT INTO Products (price, prodName) VALUES(19.95,'FabriClear Bed Bug Spray');
INSERT INTO Products (price, prodName) VALUES(149.99,'FaceFX Anti-Wrinkle Beauty System');
INSERT INTO Products (price, prodName) VALUES(29.95,'Faces Beautiful');
INSERT INTO Products (price, prodName) VALUES(149.95,'Faith Hope and Country 10 CD Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(9.99,'Fast Brite Headlight Lens Restore');
INSERT INTO Products (price, prodName) VALUES(302.31,'Fein MultiMaster');
INSERT INTO Products (price, prodName) VALUES(19.99,'Finishing Touch Flawless Facial Hair Remover');
INSERT INTO Products (price, prodName) VALUES(19.99,'Finishing Touch Flawless');
INSERT INTO Products (price, prodName) VALUES(4.99,'Finishing Touch Smile Whitening Pen');
INSERT INTO Products (price, prodName) VALUES(9.99,'Finishing Touch Smile');
INSERT INTO Products (price, prodName) VALUES(14.95,'Firma Face XR');
INSERT INTO Products (price, prodName) VALUES(19.95,'Fit Kids Club');
INSERT INTO Products (price, prodName) VALUES(19.95,'Fix It Scratch Remover');
INSERT INTO Products (price, prodName) VALUES(10.95,'Fix It! For Wood');
INSERT INTO Products (price, prodName) VALUES(13.43,'Fix It! Pro');
INSERT INTO Products (price, prodName) VALUES(227.39,'Flash & Go Light Pulse Hair Removal Device');
INSERT INTO Products (price, prodName) VALUES(25.99,'Flashlight Friends');
INSERT INTO Products (price, prodName) VALUES(79.98,'FlavorWave Oven Turbo');
INSERT INTO Products (price, prodName) VALUES(19.99,'Flawless Brows by Finishing Touch');
INSERT INTO Products (price, prodName) VALUES(29.99,'Flawless Legs from Finishing Touch');
INSERT INTO Products (price, prodName) VALUES(199.99,'Flex Belt');
INSERT INTO Products (price, prodName) VALUES(19.99,'Flex Seal Liquid – Rubber in a Can');
INSERT INTO Products (price, prodName) VALUES(19.99,'Flex Shaper');
INSERT INTO Products (price, prodName) VALUES(19.99,'Flex Shot Thick Rubber Adhesive Sealant');
INSERT INTO Products (price, prodName) VALUES(19.99,'Flex Tape');
INSERT INTO Products (price, prodName) VALUES(32.88,'Flexzilla – Lightweight Flexible and Durable Garden Hose');
INSERT INTO Products (price, prodName) VALUES(55.55,'Flip Jack Pancake Pan by Orgreenic');
INSERT INTO Products (price, prodName) VALUES(19.95,'Flip-Up Tac Glasses');
INSERT INTO Products (price, prodName) VALUES(14.95,'Flippin Fantastic Pancake Maker');
INSERT INTO Products (price, prodName) VALUES(19.99,'Flirty Girl Fitness');
INSERT INTO Products (price, prodName) VALUES(18.99,'Focus Factor');
INSERT INTO Products (price, prodName) VALUES(72.82,'Focus T25 Workout DVDs From Beachbody and Shaun T');
INSERT INTO Products (price, prodName) VALUES(39.95,'Focus T25');
INSERT INTO Products (price, prodName) VALUES(58.99,'Food Lovers Fat Loss System');
INSERT INTO Products (price, prodName) VALUES(19.95,'Forearm Forklift');
INSERT INTO Products (price, prodName) VALUES(94.99,'Forever Back');
INSERT INTO Products (price, prodName) VALUES(46.46,'Forever Comfy Gel and Foam Combination Cushion');
INSERT INTO Products (price, prodName) VALUES(39.99,'Forever Lazy Full Body Lounge Wear');
INSERT INTO Products (price, prodName) VALUES(29.95,'Forever Lazy');
INSERT INTO Products (price, prodName) VALUES(53.31,'Four Seasons 4-in-1 Heater Air Purifier Fan & Humidifier');
INSERT INTO Products (price, prodName) VALUES(19.99,'Fridge Locker');
INSERT INTO Products (price, prodName) VALUES(16.99,'Fridge Mate Snap On Drawer');
INSERT INTO Products (price, prodName) VALUES(29.99,'Fuel Shark');
INSERT INTO Products (price, prodName) VALUES(19.99,'Fun Foil Art');
INSERT INTO Products (price, prodName) VALUES(9.99,'Furniture Feet');
INSERT INTO Products (price, prodName) VALUES(32.99,'Furniture Fix');
INSERT INTO Products (price, prodName) VALUES(18.99,'Fushigi Magic Gravity Ball');
INSERT INTO Products (price, prodName) VALUES(19.99,'Futzuki Reflexology Foot Mat');
INSERT INTO Products (price, prodName) VALUES(19.99,'Fuzzoodles');
INSERT INTO Products (price, prodName) VALUES(33.33,'Garden Groom');
INSERT INTO Products (price, prodName) VALUES(49.95,'Garry Vacuum');
INSERT INTO Products (price, prodName) VALUES(59.95,'Gem Keep It Cool');
INSERT INTO Products (price, prodName) VALUES(49.95,'GeneSphere');
INSERT INTO Products (price, prodName) VALUES(59.99,'Genie Bra');
INSERT INTO Products (price, prodName) VALUES(19.95,'Get A Grip');
INSERT INTO Products (price, prodName) VALUES(9.99,'Ghost Pepper');
INSERT INTO Products (price, prodName) VALUES(34.95,'GlassyLite');
INSERT INTO Products (price, prodName) VALUES(19.99,'Glow Crazy');
INSERT INTO Products (price, prodName) VALUES(19.95,'GoGo Pillow');
INSERT INTO Products (price, prodName) VALUES(49.99,'Golds Gym 5 in 1');
INSERT INTO Products (price, prodName) VALUES(9.99,'Grater Plater');
INSERT INTO Products (price, prodName) VALUES(19.99,'Great Hair Day');
INSERT INTO Products (price, prodName) VALUES(14.95,'Greenworks Mower');
INSERT INTO Products (price, prodName) VALUES(14.99,'Grill Daddy');
INSERT INTO Products (price, prodName) VALUES(10.82,'Grill Glove');
INSERT INTO Products (price, prodName) VALUES(14.95,'GripGo Phone Mount');
INSERT INTO Products (price, prodName) VALUES(9.99,'Grout Bully');
INSERT INTO Products (price, prodName) VALUES(14.99,'Gyro Bowl');
INSERT INTO Products (price, prodName) VALUES(99.99,'H2O Mop X5');
INSERT INTO Products (price, prodName) VALUES(39.95,'H2O Vac Turbo');
INSERT INTO Products (price, prodName) VALUES(219.99,'Haan Multiforce Pro Steam Cleaner');
INSERT INTO Products (price, prodName) VALUES(14.95,'HAAN Multiforce Pro');
INSERT INTO Products (price, prodName) VALUES(9.99,'Hair Doctor');
INSERT INTO Products (price, prodName) VALUES(42.02,'Hair Illusion Instant Hair Loss Solution');
INSERT INTO Products (price, prodName) VALUES(19.99,'Half Time Drill Driver');
INSERT INTO Products (price, prodName) VALUES(33.33,'Halo Oven');
INSERT INTO Products (price, prodName) VALUES(27.99,'Hamper Hoops Basketball Hoop and Hamper by Wham-O');
INSERT INTO Products (price, prodName) VALUES(9.99,'Hang A Bunch 6-in-1 Hanger');
INSERT INTO Products (price, prodName) VALUES(9.99,'Hang A Bunch');
INSERT INTO Products (price, prodName) VALUES(14.95,'Hanging Strawberry Garden');
INSERT INTO Products (price, prodName) VALUES(21.99,'Happy Nappers Play Pillow');
INSERT INTO Products (price, prodName) VALUES(9.99,'HD Aviators');
INSERT INTO Products (price, prodName) VALUES(14.99,'HD Free TV Digital Antenna');
INSERT INTO Products (price, prodName) VALUES(14.99,'HD Vision Foldaways');
INSERT INTO Products (price, prodName) VALUES(14.95,'HD Vision Readers with Built-in Bifocals');
INSERT INTO Products (price, prodName) VALUES(19.99,'HD Vision Readers');
INSERT INTO Products (price, prodName) VALUES(19.99,'HD Vision Special Ops Sunglasses');
INSERT INTO Products (price, prodName) VALUES(24.99,'HD Vision Ultras Sunglasses');
INSERT INTO Products (price, prodName) VALUES(19.99,'HD Vision Visor');
INSERT INTO Products (price, prodName) VALUES(19.99,'HD Vision Wrap Arounds');
INSERT INTO Products (price, prodName) VALUES(49.99,'HealthMaster');
INSERT INTO Products (price, prodName) VALUES(59.95,'Heart Factors Plus');
INSERT INTO Products (price, prodName) VALUES(149.95,'Heart of Classic Rock CD Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(174.99,'Heat Surge Mini Glo Electric Fireplace Heater');
INSERT INTO Products (price, prodName) VALUES(149.99,'Heat Surge Mini Glo');
INSERT INTO Products (price, prodName) VALUES(349.99,'Heat Surge');
INSERT INTO Products (price, prodName) VALUES(99.95,'Hee Haw DVD Collection');
INSERT INTO Products (price, prodName) VALUES(9.99,'Heel Dock');
INSERT INTO Products (price, prodName) VALUES(9.99,'Heel Tastic');
INSERT INTO Products (price, prodName) VALUES(19.99,'Hex Light');
INSERT INTO Products (price, prodName) VALUES(25.24,'HideAway Pets');
INSERT INTO Products (price, prodName) VALUES(19.95,'Hip Hop Abs');
INSERT INTO Products (price, prodName) VALUES(7.99,'Hollywood Nails');
INSERT INTO Products (price, prodName) VALUES(57.64,'Hooked on Phonics');
INSERT INTO Products (price, prodName) VALUES(21.75,'Hot Booties');
INSERT INTO Products (price, prodName) VALUES(9.99,'Hot Buns Hair Accessories');
INSERT INTO Products (price, prodName) VALUES(19.99,'Hot Huez Chalk Hair Color');
INSERT INTO Products (price, prodName) VALUES(9.99,'Hover Ball');
INSERT INTO Products (price, prodName) VALUES(12.35,'Hug Light');
INSERT INTO Products (price, prodName) VALUES(29.99,'Huggle Hoodie Oversized Reversible Hooded Sweatshirt');
INSERT INTO Products (price, prodName) VALUES(9.99,'Hummingbird Vine');
INSERT INTO Products (price, prodName) VALUES(99.95,'Hurricane Canless Air System');
INSERT INTO Products (price, prodName) VALUES(19.99,'Hurricane Fur Wizard');
INSERT INTO Products (price, prodName) VALUES(14.99,'Hurricane Lint Lizard');
INSERT INTO Products (price, prodName) VALUES(19.99,'Hurricane Mop');
INSERT INTO Products (price, prodName) VALUES(39.99,'Hurricane Spin Scrubber');
INSERT INTO Products (price, prodName) VALUES(29.95,'HydraLight Water Powered Flashlight');
INSERT INTO Products (price, prodName) VALUES(20.99,'Hydro Mousse Liquid Lawn');
INSERT INTO Products (price, prodName) VALUES(45.52,'Hydroxatone');
INSERT INTO Products (price, prodName) VALUES(279.99,'iHeater');
INSERT INTO Products (price, prodName) VALUES(39.95,'In An Instant Heidi Klum');
INSERT INTO Products (price, prodName) VALUES(9.99,'Indoor Banana Tree');
INSERT INTO Products (price, prodName) VALUES(39.95,'Insanity');
INSERT INTO Products (price, prodName) VALUES(29.95,'Instant Fisherman');
INSERT INTO Products (price, prodName) VALUES(19.99,'Instant Zipper');
INSERT INTO Products (price, prodName) VALUES(14.99,'InStyler');
INSERT INTO Products (price, prodName) VALUES(9.99,'InVinceable');
INSERT INTO Products (price, prodName) VALUES(29.95,'Ionic Pro Turbo');
INSERT INTO Products (price, prodName) VALUES(4.99,'iRenew Bracelet');
INSERT INTO Products (price, prodName) VALUES(19.99,'iRenew Sport');
INSERT INTO Products (price, prodName) VALUES(19.99,'Iron Gym');
INSERT INTO Products (price, prodName) VALUES(29.99,'ISO7X');
INSERT INTO Products (price, prodName) VALUES(1499.99,'Jack La Lanne Power Juicer');
INSERT INTO Products (price, prodName) VALUES(10.37,'Jeaneez Denim-look Leggings');
INSERT INTO Products (price, prodName) VALUES(79.99,'Jillian Michaels Body Revolution');
INSERT INTO Products (price, prodName) VALUES(99.99,'Jitterbug Easy to Use Senior Cell Phone');
INSERT INTO Products (price, prodName) VALUES(39.95,'JNL Fusion');
INSERT INTO Products (price, prodName) VALUES(99.95,'Johnny and Friends – The Tonight Show Starring Johnny Carson DVD Collection');
INSERT INTO Products (price, prodName) VALUES(9.99,'Jupiter Jack');
INSERT INTO Products (price, prodName) VALUES(29.95,'Just Air Laptop Case');
INSERT INTO Products (price, prodName) VALUES(19.99,'Justice Coin');
INSERT INTO Products (price, prodName) VALUES(9.99,'Kangaroo Keeper Brite');
INSERT INTO Products (price, prodName) VALUES(19.95,'Kangaroo Keeper');
INSERT INTO Products (price, prodName) VALUES(19.95,'Lasting Memory Paw');
INSERT INTO Products (price, prodName) VALUES(29.95,'Lauren Hutton Face Disc');
INSERT INTO Products (price, prodName) VALUES(14.99,'Law of Success');
INSERT INTO Products (price, prodName) VALUES(2.99,'Lazer Bond USA');
INSERT INTO Products (price, prodName) VALUES(14.95,'Leak Ender 2000');
INSERT INTO Products (price, prodName) VALUES(19.99,'Learn Our History DVDs');
INSERT INTO Products (price, prodName) VALUES(149.95,'Legendary Voices CD Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(14.95,'Les Mills Pump');
INSERT INTO Products (price, prodName) VALUES(49.95,'Lessons Of A Lifetime');
INSERT INTO Products (price, prodName) VALUES(24.95,'LifeStrength');
INSERT INTO Products (price, prodName) VALUES(39.95,'Light Relief');
INSERT INTO Products (price, prodName) VALUES(14.99,'LightStim');
INSERT INTO Products (price, prodName) VALUES(10.99,'Lint Lizard');
INSERT INTO Products (price, prodName) VALUES(29.95,'LipiGesic M');
INSERT INTO Products (price, prodName) VALUES(374.95,'Living Pure');
INSERT INTO Products (price, prodName) VALUES(39.99,'Lizard Cam Micro-Camera');
INSERT INTO Products (price, prodName) VALUES(399.89,'Lock & Rollin Attic Flooring Starter Pack');
INSERT INTO Products (price, prodName) VALUES(17.52,'Lock Wallet');
INSERT INTO Products (price, prodName) VALUES(29.95,'Looney Tunes Phonics');
INSERT INTO Products (price, prodName) VALUES(69.99,'Lucidal');
INSERT INTO Products (price, prodName) VALUES(19.99,'Luma Candles');
INSERT INTO Products (price, prodName) VALUES(173.38,'Luminess Air');
INSERT INTO Products (price, prodName) VALUES(29.95,'Luminess Tan');
INSERT INTO Products (price, prodName) VALUES(19.99,'Magic Mesh');
INSERT INTO Products (price, prodName) VALUES(19.99,'Magic Tap');
INSERT INTO Products (price, prodName) VALUES(39.99,'MagicJack');
INSERT INTO Products (price, prodName) VALUES(14.99,'Magna Nails');
INSERT INTO Products (price, prodName) VALUES(29.95,'Mari Winsor Pilates');
INSERT INTO Products (price, prodName) VALUES(89.95,'Maxiglide');
INSERT INTO Products (price, prodName) VALUES(39.95,'Meaningful Beauty');
INSERT INTO Products (price, prodName) VALUES(39.95,'MET Rx 180');
INSERT INTO Products (price, prodName) VALUES(5.99,'Micro Smores');
INSERT INTO Products (price, prodName) VALUES(29.99,'MicroBoom Speaker');
INSERT INTO Products (price, prodName) VALUES(19.99,'MicroForce Shaver');
INSERT INTO Products (price, prodName) VALUES(9.99,'Mighty Fix It');
INSERT INTO Products (price, prodName) VALUES(19.99,'Mighty MendIt');
INSERT INTO Products (price, prodName) VALUES(19.99,'Mighty Putty');
INSERT INTO Products (price, prodName) VALUES(19.99,'Minden Anytime Grill');
INSERT INTO Products (price, prodName) VALUES(59.99,'Miracle Blade World Class');
INSERT INTO Products (price, prodName) VALUES(19.99,'Mister Steamy');
INSERT INTO Products (price, prodName) VALUES(39.99,'Morgan Silver Dollars');
INSERT INTO Products (price, prodName) VALUES(29.95,'Murad Acne Complex');
INSERT INTO Products (price, prodName) VALUES(39.95,'Murad Resurgence');
INSERT INTO Products (price, prodName) VALUES(19.99,'Music Bullet');
INSERT INTO Products (price, prodName) VALUES(19.95,'My Best Fish Friend');
INSERT INTO Products (price, prodName) VALUES(10.99,'My Lil Pie Maker');
INSERT INTO Products (price, prodName) VALUES(9.99,'My Scent Atomizer');
INSERT INTO Products (price, prodName) VALUES(39.95,'My Snoring Solution');
INSERT INTO Products (price, prodName) VALUES(19.99,'MyZone Headphones');
INSERT INTO Products (price, prodName) VALUES(9.99,'Nail Perfect');
INSERT INTO Products (price, prodName) VALUES(4.91,'Naked Nails Manicure System');
INSERT INTO Products (price, prodName) VALUES(9.99,'National Park $2 Bill');
INSERT INTO Products (price, prodName) VALUES(6.98,'Natural Solutions to Things That Bug You!');
INSERT INTO Products (price, prodName) VALUES(9.99,'Natures Greetings');
INSERT INTO Products (price, prodName) VALUES(11.99,'Nazis: A Warning from History DVD Set');
INSERT INTO Products (price, prodName) VALUES(52.48,'Neater Feeder Express Pet Feeding Station');
INSERT INTO Products (price, prodName) VALUES(19.99,'Neater Scooper Scoop-to-Bag Cat Litter System');
INSERT INTO Products (price, prodName) VALUES(19.99,'Neckline Slimmer');
INSERT INTO Products (price, prodName) VALUES(19.99,'Nerve Pain Away Natural Nerve Pain Reliever');
INSERT INTO Products (price, prodName) VALUES(29.95,'New Body Shaper');
INSERT INTO Products (price, prodName) VALUES(9.99,'Night View NV Night Driving Glasses');
INSERT INTO Products (price, prodName) VALUES(6.99,'NightSkin');
INSERT INTO Products (price, prodName) VALUES(39.95,'Ninja 1100');
INSERT INTO Products (price, prodName) VALUES(149.99,'Ninja Cooking System');
INSERT INTO Products (price, prodName) VALUES(99.99,'Ninja Kitchen System 1200');
INSERT INTO Products (price, prodName) VALUES(89.95,'No No Hair');
INSERT INTO Products (price, prodName) VALUES(179.99,'NoNo Skin');
INSERT INTO Products (price, prodName) VALUES(19.95,'Notebook Buffer');
INSERT INTO Products (price, prodName) VALUES(14.95,'NuBrilliance');
INSERT INTO Products (price, prodName) VALUES(99.99,'Nutra Sonic');
INSERT INTO Products (price, prodName) VALUES(19.99,'NutraFuels Sleep');
INSERT INTO Products (price, prodName) VALUES(89.94,'NuWave Oven Pro');
INSERT INTO Products (price, prodName) VALUES(39.99,'NuWave Oven');
INSERT INTO Products (price, prodName) VALUES(29.95,'Nuwave Perfect Green');
INSERT INTO Products (price, prodName) VALUES(33.33,'NuWave PIC');
INSERT INTO Products (price, prodName) VALUES(73.03,'NuWave Precision Induction Cooktop PIC2');
INSERT INTO Products (price, prodName) VALUES(29.95,'NV Diet');
INSERT INTO Products (price, prodName) VALUES(14.99,'Obsidian Fitness');
INSERT INTO Products (price, prodName) VALUES(9.99,'One Second Needle');
INSERT INTO Products (price, prodName) VALUES(19.95,'One Touch Can Opener');
INSERT INTO Products (price, prodName) VALUES(14.95,'One Touch Cordless Knife');
INSERT INTO Products (price, prodName) VALUES(59.95,'One Touch Steam Tornado');
INSERT INTO Products (price, prodName) VALUES(59.95,'OPC Factor');
INSERT INTO Products (price, prodName) VALUES(19.98,'Optic 1050');
INSERT INTO Products (price, prodName) VALUES(19.99,'OrGreenic');
INSERT INTO Products (price, prodName) VALUES(99.95,'P3 Back Stretcher');
INSERT INTO Products (price, prodName) VALUES(74.85,'P90 Workout for Everyone');
INSERT INTO Products (price, prodName) VALUES(407.85,'P90X');
INSERT INTO Products (price, prodName) VALUES(139.89,'P90X2 Extreme Workout – A New Level');
INSERT INTO Products (price, prodName) VALUES(139.89,'P90X3 30 Minute Beachbody Workout by Tony Horton');
INSERT INTO Products (price, prodName) VALUES(19.99,'PackIt Lunch Box');
INSERT INTO Products (price, prodName) VALUES(33.33,'Paint Zoom Power Sprayer');
INSERT INTO Products (price, prodName) VALUES(39.99,'Pajama Jeans');
INSERT INTO Products (price, prodName) VALUES(44.99,'Pancake Puffs');
INSERT INTO Products (price, prodName) VALUES(74.98,'Party Rock 10 CD Box Set');
INSERT INTO Products (price, prodName) VALUES(9.99,'Pasta Boat');
INSERT INTO Products (price, prodName) VALUES(19.95,'Patch Perfect');
INSERT INTO Products (price, prodName) VALUES(19.99,'Pawggles');
INSERT INTO Products (price, prodName) VALUES(49.99,'PC Matic – Name That Antivirus');
INSERT INTO Products (price, prodName) VALUES(299.99,'PC Matic the Anti-Virus Secret');
INSERT INTO Products (price, prodName) VALUES(69.99,'Pearl Hair Remover');
INSERT INTO Products (price, prodName) VALUES(19.99,'PedEgg PowerBall');
INSERT INTO Products (price, prodName) VALUES(12.29,'PedEgg');
INSERT INTO Products (price, prodName) VALUES(7.74,'Pedi Pistol');
INSERT INTO Products (price, prodName) VALUES(19.95,'PediPaws');
INSERT INTO Products (price, prodName) VALUES(14.99,'PediSpin');
INSERT INTO Products (price, prodName) VALUES(19.95,'Perfect Brownie Pan');
INSERT INTO Products (price, prodName) VALUES(9.99,'Perfect Fit Button');
INSERT INTO Products (price, prodName) VALUES(19.95,'Perfect Meatloaf');
INSERT INTO Products (price, prodName) VALUES(48.55,'Perfect Pancake Pan');
INSERT INTO Products (price, prodName) VALUES(19.95,'Perfect Pancake');
INSERT INTO Products (price, prodName) VALUES(16.99,'Perfect Polly Singing Parakeet Toy');
INSERT INTO Products (price, prodName) VALUES(9.99,'Perfect Tortilla Bowl');
INSERT INTO Products (price, prodName) VALUES(29.95,'Perks Bra');
INSERT INTO Products (price, prodName) VALUES(19.95,'Pest Free Property');
INSERT INTO Products (price, prodName) VALUES(9.77,'Pet Bath Towel');
INSERT INTO Products (price, prodName) VALUES(14.95,'Pet Pain-Away All Natural Pain Relief for Dogs and Cats');
INSERT INTO Products (price, prodName) VALUES(14.99,'Pet Rider');
INSERT INTO Products (price, prodName) VALUES(19.99,'Pet Zoom Loungee');
INSERT INTO Products (price, prodName) VALUES(41.78,'Pet Zoom Pet Park Indoor Dog Restroom');
INSERT INTO Products (price, prodName) VALUES(29.95,'Pet Zoom Pet Park');
INSERT INTO Products (price, prodName) VALUES(13.94,'Pet Zoom Sonic Pet Trainer');
INSERT INTO Products (price, prodName) VALUES(8.88,'PetZoom Nail Groom for Pets');
INSERT INTO Products (price, prodName) VALUES(8.49,'Phantom Saucer');
INSERT INTO Products (price, prodName) VALUES(34.95,'Phrobi');
INSERT INTO Products (price, prodName) VALUES(19.95,'Pillow Pets');
INSERT INTO Products (price, prodName) VALUES(19.95,'PivoTrim');
INSERT INTO Products (price, prodName) VALUES(72.82,'PiYo Workout');
INSERT INTO Products (price, prodName) VALUES(14.94,'Plaque Attack Pet Dental Spray');
INSERT INTO Products (price, prodName) VALUES(19.95,'Plaque Attack');
INSERT INTO Products (price, prodName) VALUES(9.99,'Plaque Blast');
INSERT INTO Products (price, prodName) VALUES(9.95,'Play Guitar Instantly');
INSERT INTO Products (price, prodName) VALUES(14.99,'Pocket Chair');
INSERT INTO Products (price, prodName) VALUES(56.88,'Pocket Fisherman');
INSERT INTO Products (price, prodName) VALUES(59.99,'Pocket Hose Top Brass');
INSERT INTO Products (price, prodName) VALUES(28.99,'Pocket Hose Ultra');
INSERT INTO Products (price, prodName) VALUES(12.99,'Pocket Hose');
INSERT INTO Products (price, prodName) VALUES(6.97,'Point N Paint');
INSERT INTO Products (price, prodName) VALUES(22.13,'Pop Chef Snack Food Shape Cutter');
INSERT INTO Products (price, prodName) VALUES(149.95,'Pop Goes the 70s CD Collection');
INSERT INTO Products (price, prodName) VALUES(29.99,'Pop Memories of the 60s');
INSERT INTO Products (price, prodName) VALUES(71.48,'Pop Memories of the Sixties');
INSERT INTO Products (price, prodName) VALUES(18.99,'Pops-a-Dent Professional Auto Dent and Ding Repair Kit');
INSERT INTO Products (price, prodName) VALUES(39.95,'PostureNOW Posture Corrective Brace');
INSERT INTO Products (price, prodName) VALUES(13.79,'Potato Express Microwave Bag');
INSERT INTO Products (price, prodName) VALUES(39.99,'Potty Patch');
INSERT INTO Products (price, prodName) VALUES(99.99,'Power Juicer Express');
INSERT INTO Products (price, prodName) VALUES(153.97,'Power Rangers DVD Set');
INSERT INTO Products (price, prodName) VALUES(69.95,'Practice Like A Pro');
INSERT INTO Products (price, prodName) VALUES(34.99,'Prayer Cross Necklace');
INSERT INTO Products (price, prodName) VALUES(19.49,'Prayer Cross');
INSERT INTO Products (price, prodName) VALUES(19.99,'Press Dough');
INSERT INTO Products (price, prodName) VALUES(19.95,'Principal Secret Reclaim');
INSERT INTO Products (price, prodName) VALUES(19.95,'Pro Caulk');
INSERT INTO Products (price, prodName) VALUES(19.95,'Proactiv Solution');
INSERT INTO Products (price, prodName) VALUES(35.97,'Procera AVH Memory Supplement');
INSERT INTO Products (price, prodName) VALUES(79.35,'Profollica Hair Recovery System');
INSERT INTO Products (price, prodName) VALUES(54.93,'Prosvent');
INSERT INTO Products (price, prodName) VALUES(19.99,'PupLight');
INSERT INTO Products (price, prodName) VALUES(199.99,'PurePro');
INSERT INTO Products (price, prodName) VALUES(9.99,'Push Up Pro');
INSERT INTO Products (price, prodName) VALUES(74.88,'Push Up Pump');
INSERT INTO Products (price, prodName) VALUES(19.99,'Quick Chop');
INSERT INTO Products (price, prodName) VALUES(19.95,'QuickLawn');
INSERT INTO Products (price, prodName) VALUES(6.23,'Rabbit TV – As Seen on TV');
INSERT INTO Products (price, prodName) VALUES(9.99,'Rabbit TV');
INSERT INTO Products (price, prodName) VALUES(22.96,'RapidLash Eyelash Renewal System');
INSERT INTO Products (price, prodName) VALUES(19.99,'Raspberry Ketones as seen on Dr. Oz');
INSERT INTO Products (price, prodName) VALUES(9.96,'RC Pocket Racers');
INSERT INTO Products (price, prodName) VALUES(39.99,'Red Copper 5 Minute Chef with Cathy Mitchell');
INSERT INTO Products (price, prodName) VALUES(19.99,'Red Copper Better Pasta Pot');
INSERT INTO Products (price, prodName) VALUES(19.99,'Red Copper Brownie Bonanza');
INSERT INTO Products (price, prodName) VALUES(19.99,'Red Copper Flipwich Sandwich Maker');
INSERT INTO Products (price, prodName) VALUES(19.99,'Red Copper Mug');
INSERT INTO Products (price, prodName) VALUES(19.99,'Red Copper Pan');
INSERT INTO Products (price, prodName) VALUES(44.24,'Red Copper Square Pan');
INSERT INTO Products (price, prodName) VALUES(5.97,'Rejuvenate Floor Restorer');
INSERT INTO Products (price, prodName) VALUES(19.95,'RelaxoBak – Relief from Back Pain');
INSERT INTO Products (price, prodName) VALUES(39.95,'RevAbs');
INSERT INTO Products (price, prodName) VALUES(49.18,'Rhythm Rocker by Kymaro');
INSERT INTO Products (price, prodName) VALUES(13.99,'Richard Simmons Project Hope');
INSERT INTO Products (price, prodName) VALUES(29.95,'Riddex Pulse');
INSERT INTO Products (price, prodName) VALUES(29.99,'Right To Bare Legs');
INSERT INTO Products (price, prodName) VALUES(19.99,'RightSize Smoothie Mix for Weight Loss');
INSERT INTO Products (price, prodName) VALUES(12.49,'Ring X Toilet Bowl Cleaner');
INSERT INTO Products (price, prodName) VALUES(139.99,'Rip 60 Workout');
INSERT INTO Products (price, prodName) VALUES(249.99,'rip:60 Workout System');
INSERT INTO Products (price, prodName) VALUES(39.98,'Robin Williams: Comic Genius 22 DVD Deluxe Box Set');
INSERT INTO Products (price, prodName) VALUES(19.99,'Robo Twist Jar Opener');
INSERT INTO Products (price, prodName) VALUES(8.99,'RoboStir');
INSERT INTO Products (price, prodName) VALUES(19.99,'Rock and Roll Hall of Fame Live 9 DVD Set');
INSERT INTO Products (price, prodName) VALUES(134.95,'Rock and Romance CD Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(8.35,'Rocket Copters');
INSERT INTO Products (price, prodName) VALUES(46.99,'Rocket Fishing Rod');
INSERT INTO Products (price, prodName) VALUES(99.99,'Rockin Abs');
INSERT INTO Products (price, prodName) VALUES(19.95,'Rockin Body');
INSERT INTO Products (price, prodName) VALUES(21.99,'Rodent Sheriff Natural Pest Repellent');
INSERT INTO Products (price, prodName) VALUES(9.99,'Rodent Sheriff');
INSERT INTO Products (price, prodName) VALUES(29.95,'Rollie Eggmaster');
INSERT INTO Products (price, prodName) VALUES(80.97,'Romancing the 60s 10 CD Box Set');
INSERT INTO Products (price, prodName) VALUES(99.99,'Romantically Yours 10 CD Box Set');
INSERT INTO Products (price, prodName) VALUES(39.99,'Ronco Dehydrator and Beef Jerky Maker');
INSERT INTO Products (price, prodName) VALUES(105.99,'Ronco Electric Pasta Maker');
INSERT INTO Products (price, prodName) VALUES(19.99,'Ronco Rotisserie');
INSERT INTO Products (price, prodName) VALUES(197.75,'Ronco Showtime Compact Rotisserie and BBQ Oven');
INSERT INTO Products (price, prodName) VALUES(397.99,'Ronco Showtime Rotisserie and BBQ Oven');
INSERT INTO Products (price, prodName) VALUES(39.99,'Ronco Six Star Knives');
INSERT INTO Products (price, prodName) VALUES(49.95,'Rotorazer Saw');
INSERT INTO Products (price, prodName) VALUES(19.99,'RotoShave');
INSERT INTO Products (price, prodName) VALUES(249.95,'Rowan and Martin‘s Laugh-In: The Complete Series on DVD from Time Life');
INSERT INTO Products (price, prodName) VALUES(8.99,'ROX Ice Ball Maker');
INSERT INTO Products (price, prodName) VALUES(19.99,'Royal Heirloom Ring');
INSERT INTO Products (price, prodName) VALUES(9.99,'Royal Posture Back Supporter');
INSERT INTO Products (price, prodName) VALUES(39.95,'Ruby Reds');
INSERT INTO Products (price, prodName) VALUES(11.95,'RX Locker');
INSERT INTO Products (price, prodName) VALUES(9.95,'Salad Chef');
INSERT INTO Products (price, prodName) VALUES(14.99,'Samurai Pro');
INSERT INTO Products (price, prodName) VALUES(14.95,'Save a Blade');
INSERT INTO Products (price, prodName) VALUES(19.95,'Schticky');
INSERT INTO Products (price, prodName) VALUES(39.95,'Seasonaire');
INSERT INTO Products (price, prodName) VALUES(19.99,'Secret Glo');
INSERT INTO Products (price, prodName) VALUES(39.95,'Secret Solutions Body Shaper');
INSERT INTO Products (price, prodName) VALUES(49.95,'Secrets of the Short Game');
INSERT INTO Products (price, prodName) VALUES(36.85,'Secura Turbo Oven');
INSERT INTO Products (price, prodName) VALUES(4.95,'Sensa Advanced');
INSERT INTO Products (price, prodName) VALUES(29.95,'Shake Weight For Men');
INSERT INTO Products (price, prodName) VALUES(19.95,'Shake Weight');
INSERT INTO Products (price, prodName) VALUES(19.95,'ShamWow');
INSERT INTO Products (price, prodName) VALUES(19.99,'Shapely Secrets');
INSERT INTO Products (price, prodName) VALUES(49.95,'Shark Navigator Lift Away');
INSERT INTO Products (price, prodName) VALUES(199.89,'Shark Rotator');
INSERT INTO Products (price, prodName) VALUES(149.99,'Shark Vac Then Steam');
INSERT INTO Products (price, prodName) VALUES(59.54,'Shark VX3');
INSERT INTO Products (price, prodName) VALUES(9.99,'ShaveMate');
INSERT INTO Products (price, prodName) VALUES(9.99,'Shed Ender');
INSERT INTO Products (price, prodName) VALUES(29.95,'Sheer Cover');
INSERT INTO Products (price, prodName) VALUES(24.99,'Shirley Temple DVD Collection');
INSERT INTO Products (price, prodName) VALUES(9.99,'Shoes Under');
INSERT INTO Products (price, prodName) VALUES(14.95,'Shower Wow');
INSERT INTO Products (price, prodName) VALUES(19.99,'Side Sleeper Pro');
INSERT INTO Products (price, prodName) VALUES(9.99,'Side Socket');
INSERT INTO Products (price, prodName) VALUES(4.95,'Silly Bandz');
INSERT INTO Products (price, prodName) VALUES(19.95,'skiniD');
INSERT INTO Products (price, prodName) VALUES(19.95,'Slap Chop');
INSERT INTO Products (price, prodName) VALUES(70.48,'Slendertone Flex Pro');
INSERT INTO Products (price, prodName) VALUES(19.99,'Slice O Matic');
INSERT INTO Products (price, prodName) VALUES(9.99,'Slim Away');
INSERT INTO Products (price, prodName) VALUES(9.99,'Slim Clip');
INSERT INTO Products (price, prodName) VALUES(19.95,'Slim In 6');
INSERT INTO Products (price, prodName) VALUES(19.99,'Slushy Magic');
INSERT INTO Products (price, prodName) VALUES(19.99,'Smart Mop');
INSERT INTO Products (price, prodName) VALUES(14.99,'Smart Night Light');
INSERT INTO Products (price, prodName) VALUES(15.99,'Smart Spin');
INSERT INTO Products (price, prodName) VALUES(89.95,'Smoke Assist');
INSERT INTO Products (price, prodName) VALUES(49.95,'Smoke Away');
INSERT INTO Products (price, prodName) VALUES(9.99,'Snap-On Feathers');
INSERT INTO Products (price, prodName) VALUES(29.95,'SnoreEzzz');
INSERT INTO Products (price, prodName) VALUES(4.99,'Snow In Seconds');
INSERT INTO Products (price, prodName) VALUES(14.95,'Snuggie For Dogs');
INSERT INTO Products (price, prodName) VALUES(19.95,'Snuggie For Kids');
INSERT INTO Products (price, prodName) VALUES(19.95,'Snuggie New Colors');
INSERT INTO Products (price, prodName) VALUES(19.95,'Snuggie');
INSERT INTO Products (price, prodName) VALUES(25.52,'Soap Magic');
INSERT INTO Products (price, prodName) VALUES(19.99,'Sobakawa Pillow');
INSERT INTO Products (price, prodName) VALUES(29.95,'Solar Animal Repeller');
INSERT INTO Products (price, prodName) VALUES(9.99,'Sonic Pet Trainer');
INSERT INTO Products (price, prodName) VALUES(19.95,'Space Bag Ottoman');
INSERT INTO Products (price, prodName) VALUES(19.95,'Space Bag Tote');
INSERT INTO Products (price, prodName) VALUES(19.99,'Space Bag Underbed Closet');
INSERT INTO Products (price, prodName) VALUES(19.95,'Space Bags To Go');
INSERT INTO Products (price, prodName) VALUES(19.95,'Space Bags');
INSERT INTO Products (price, prodName) VALUES(99.95,'Spinal Stretch');
INSERT INTO Products (price, prodName) VALUES(79.99,'Sport Elec');
INSERT INTO Products (price, prodName) VALUES(49.95,'Stem Cell Therapy');
INSERT INTO Products (price, prodName) VALUES(39.99,'Step360');
INSERT INTO Products (price, prodName) VALUES(9.99,'Sticky Buddy');
INSERT INTO Products (price, prodName) VALUES(9.99,'Stone Wave');
INSERT INTO Products (price, prodName) VALUES(19.99,'Strap Perfect');
INSERT INTO Products (price, prodName) VALUES(9.99,'Stream Clean');
INSERT INTO Products (price, prodName) VALUES(19.99,'Strike N Set');
INSERT INTO Products (price, prodName) VALUES(9.99,'StufZ');
INSERT INTO Products (price, prodName) VALUES(9.99,'Style Snaps');
INSERT INTO Products (price, prodName) VALUES(6.99,'Super Beta Prostate');
INSERT INTO Products (price, prodName) VALUES(79.99,'Super Juicer');
INSERT INTO Products (price, prodName) VALUES(39.95,'Super Wave Oven');
INSERT INTO Products (price, prodName) VALUES(47.95,'Supple');
INSERT INTO Products (price, prodName) VALUES(19.99,'Supreme 90 Day');
INSERT INTO Products (price, prodName) VALUES(9.99,'Sure Clip');
INSERT INTO Products (price, prodName) VALUES(9.99,'Sweet Dream Blackberries');
INSERT INTO Products (price, prodName) VALUES(39.99,'Swivel Sweeper G2 Elite');
INSERT INTO Products (price, prodName) VALUES(19.99,'Swivel Sweeper G2');
INSERT INTO Products (price, prodName) VALUES(29.95,'T-Core For Men');
INSERT INTO Products (price, prodName) VALUES(29.95,'T-Core For Women');
INSERT INTO Products (price, prodName) VALUES(29.95,'Table Mate');
INSERT INTO Products (price, prodName) VALUES(29.95,'Table-Mate Portable Sliding Table');
INSERT INTO Products (price, prodName) VALUES(19.99,'Tac Camera Body Cam');
INSERT INTO Products (price, prodName) VALUES(19.99,'Tac Hearing Amplifier');
INSERT INTO Products (price, prodName) VALUES(19.99,'Tac Zoom Telephoto Lens for Any Phone');
INSERT INTO Products (price, prodName) VALUES(19.99,'Tag Away Skin Tag Remover');
INSERT INTO Products (price, prodName) VALUES(49.99,'Tai Cheng');
INSERT INTO Products (price, prodName) VALUES(8.45,'Tasty Top Cake Pops');
INSERT INTO Products (price, prodName) VALUES(15.99,'Teddy Tanks Stuffed Animal and Fish Tank');
INSERT INTO Products (price, prodName) VALUES(368.99,'Teeter Hang Ups Inversion Table');
INSERT INTO Products (price, prodName) VALUES(14.95,'Teeter Hang Ups');
INSERT INTO Products (price, prodName) VALUES(249.99,'Temptu Air Airbrush Makeup Kit');
INSERT INTO Products (price, prodName) VALUES(19.99,'The Best of the Andy Williams Show DVD Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(19.99,'The Best of the Three Stooges DVD Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(99.99,'The Bible Experience CD Set');
INSERT INTO Products (price, prodName) VALUES(99.99,'The Firm Express');
INSERT INTO Products (price, prodName) VALUES(59.99,'The FIRM Express');
INSERT INTO Products (price, prodName) VALUES(199.99,'The Flex Mini');
INSERT INTO Products (price, prodName) VALUES(24.91,'The Folk Years 8 CD Box Set');
INSERT INTO Products (price, prodName) VALUES(19.99,'The Jackie Gleason Show in Color DVD Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(29.95,'The Kruncher');
INSERT INTO Products (price, prodName) VALUES(49.99,'The Masters Hammer and Chisel Workout');
INSERT INTO Products (price, prodName) VALUES(54.59,'The Perfect Dog');
INSERT INTO Products (price, prodName) VALUES(149.95,'The Power of Love 9 CD Box Set');
INSERT INTO Products (price, prodName) VALUES(99.95,'The Red Skelton Hour in Color DVD Collection from Time Life');
INSERT INTO Products (price, prodName) VALUES(49.97,'The Swedish Diet');
INSERT INTO Products (price, prodName) VALUES(99.95,'The Teen Years 10 CD Box Set');
INSERT INTO Products (price, prodName) VALUES(69.95,'The Total Transformation Program');
INSERT INTO Products (price, prodName) VALUES(6.64,'The Waving Flag – U.S. Flag with Electronic Waving Action');
INSERT INTO Products (price, prodName) VALUES(249.91,'The Wonder Years Complete Series on DVD');
INSERT INTO Products (price, prodName) VALUES(39.99,'The World At War');
INSERT INTO Products (price, prodName) VALUES(29.99,'Thermapulse® Relief Wrap');
INSERT INTO Products (price, prodName) VALUES(14.95,'Thigh Glider');
INSERT INTO Products (price, prodName) VALUES(12.45,'ThingCHARGER Cordless Wall Charger');
INSERT INTO Products (price, prodName) VALUES(209.95,'ThunderBell Total Body Training System');
INSERT INTO Products (price, prodName) VALUES(24.95,'ThunderBell');
INSERT INTO Products (price, prodName) VALUES(44.95,'Thundershirt Dog Anxiety Solution');
INSERT INTO Products (price, prodName) VALUES(19.95,'Tiger Wrench');
INSERT INTO Products (price, prodName) VALUES(26.99,'Time Life Presents The 60s CD Collection');
INSERT INTO Products (price, prodName) VALUES(29.95,'Timeless Secret');
INSERT INTO Products (price, prodName) VALUES(19.77,'Titan Peeler');
INSERT INTO Products (price, prodName) VALUES(99.99,'Tobi Platinum');
INSERT INTO Products (price, prodName) VALUES(9.99,'Tomato Factory');
INSERT INTO Products (price, prodName) VALUES(29.95,'Top Trainers');
INSERT INTO Products (price, prodName) VALUES(99.99,'TopStyler By InStyler');
INSERT INTO Products (price, prodName) VALUES(19.99,'Topsy Turvy Tomato Tree with Steel Grow Stand');
INSERT INTO Products (price, prodName) VALUES(19.95,'Topsy Turvy Tree');
INSERT INTO Products (price, prodName) VALUES(249.49,'Total Flex');
INSERT INTO Products (price, prodName) VALUES(0.99,'Total Gym');
INSERT INTO Products (price, prodName) VALUES(19.99,'Total Pillow');
INSERT INTO Products (price, prodName) VALUES(9.99,'Total View Mirror');
INSERT INTO Products (price, prodName) VALUES(19.99,'TouCan Can Opener');
INSERT INTO Products (price, prodName) VALUES(19.99,'Touch And Brush');
INSERT INTO Products (price, prodName) VALUES(14.95,'Tower 200');
INSERT INTO Products (price, prodName) VALUES(35.95,'Tree Dazzler – Christmas Tree Light Show');
INSERT INTO Products (price, prodName) VALUES(15.99,'Trendy Top Wrap');
INSERT INTO Products (price, prodName) VALUES(9.99,'Trendy Top');
INSERT INTO Products (price, prodName) VALUES(39.95,'Triple Action Joint Formula');
INSERT INTO Products (price, prodName) VALUES(19.95,'Trumpy Bear');
INSERT INTO Products (price, prodName) VALUES(14.99,'Trusty Cane');
INSERT INTO Products (price, prodName) VALUES(15.99,'Tummy Stuffers');
INSERT INTO Products (price, prodName) VALUES(39.95,'Turbo Fire');
INSERT INTO Products (price, prodName) VALUES(17.75,'Turbo Jam Workout With Chalene Johnson');
INSERT INTO Products (price, prodName) VALUES(19.95,'Turbo Jam');
INSERT INTO Products (price, prodName) VALUES(9.99,'Turbo Snake');
INSERT INTO Products (price, prodName) VALUES(119.85,'TurboFire Intense Cardio Workout');
INSERT INTO Products (price, prodName) VALUES(19.95,'Tushee');
INSERT INTO Products (price, prodName) VALUES(14.99,'TV Free-Way Digital Antenna');
INSERT INTO Products (price, prodName) VALUES(14.99,'Tweeze');
INSERT INTO Products (price, prodName) VALUES(19.99,'Twin Draft Guard');
INSERT INTO Products (price, prodName) VALUES(9.99,'UGlu Adhesive');
INSERT INTO Products (price, prodName) VALUES(59.95,'UltraFlex');
INSERT INTO Products (price, prodName) VALUES(14.95,'UV Ultra Vac');
INSERT INTO Products (price, prodName) VALUES(33.33,'VibraRazer Renovating Tool');
INSERT INTO Products (price, prodName) VALUES(19.95,'Vidalia Chop Wizard');
INSERT INTO Products (price, prodName) VALUES(19.95,'WalkFit Platinum');
INSERT INTO Products (price, prodName) VALUES(19.99,'Wandarama');
INSERT INTO Products (price, prodName) VALUES(19.95,'Water Jet');
INSERT INTO Products (price, prodName) VALUES(99.99,'Weider PowerBell');
INSERT INTO Products (price, prodName) VALUES(99.99,'Weider X-Factor');
INSERT INTO Products (price, prodName) VALUES(29.99,'Who Knew? Books');
INSERT INTO Products (price, prodName) VALUES(9.99,'Windshield Wonder');
INSERT INTO Products (price, prodName) VALUES(19.99,'Wipe New');
INSERT INTO Products (price, prodName) VALUES(59.95,'Women Extenze');
INSERT INTO Products (price, prodName) VALUES(19.99,'Wonder File');
INSERT INTO Products (price, prodName) VALUES(19.95,'WOW Storage Containers');
INSERT INTO Products (price, prodName) VALUES(19.99,'Wuggle Pets');
INSERT INTO Products (price, prodName) VALUES(34.24,'Xhose Expanding Garden Hose');
INSERT INTO Products (price, prodName) VALUES(25.11,'XHose Pro Extreme Expandable Hose');
INSERT INTO Products (price, prodName) VALUES(19.95,'XHose');
INSERT INTO Products (price, prodName) VALUES(70.99,'Xpress Redi-Set-Go Cooker');
INSERT INTO Products (price, prodName) VALUES(19.99,'Yoshi Grill and Bake');
INSERT INTO Products (price, prodName) VALUES(19.99,'YoshiBlue');
INSERT INTO Products (price, prodName) VALUES(14.95,'Your Baby Can Read');
INSERT INTO Products (price, prodName) VALUES(59.95,'Zencore Plus');
INSERT INTO Products (price, prodName) VALUES(19.99,'Zip Trim Cordless Trimmer');
INSERT INTO Products (price, prodName) VALUES(25.08,'Zipit Bedding as seen on Shark Tank');
INSERT INTO Products (price, prodName) VALUES(79.99,'Zomm');
INSERT INTO Products (price, prodName) VALUES(157.57,'Zoobooks Magazine for Kids');
INSERT INTO Products (price, prodName) VALUES(9.95,'ZQuiet');

insert into people (firstname, lastname, provinceID) values ('Walter', 'White', 'MB');
insert into people (firstname, lastname, provinceID) values ('Skyler', 'White', 'ON');
insert into people (firstname, lastname, provinceID) values ('Flynn', 'White', 'BC');
insert into people (firstname, lastname, provinceID) values ('Jessie', 'Pinkman', 'SK');
insert into people (firstname, lastname, provinceID) values ('Saul', 'Goodman', 'AB');
insert into people (firstname, lastname, provinceID) values ('Marie', 'Schrader', 'SK');
insert into people (firstname, lastname, provinceID) values ('Hank', 'Schrader', 'AB');
insert into people (firstname, lastname, provinceID) values ('Alberto', 'Salamanca' , 'MB');
insert into people (firstname, lastname, provinceID) values ('Gustavo', 'Fring' , 'MB');

insert into orders values (1, 1);
insert into orderLineItems (orderID, productID) values (1, 614);
insert into orders values (2, 1);
insert into orderLineItems (orderID, productID) values (2, 174);
insert into orderLineItems (orderID, productID) values (2, 613);
insert into orderLineItems (orderID, productID) values (2, 469);
insert into orderLineItems (orderID, productID) values (2, 361);
insert into orderLineItems (orderID, productID) values (2, 255);
insert into orderLineItems (orderID, productID) values (2, 167);
insert into orders values (3, 1);
insert into orderLineItems (orderID, productID) values (3, 557);
insert into orders values (4, 1);
insert into orderLineItems (orderID, productID) values (4, 220);
insert into orderLineItems (orderID, productID) values (4, 10);
insert into orderLineItems (orderID, productID) values (4, 12);
insert into orderLineItems (orderID, productID) values (4, 429);
insert into orderLineItems (orderID, productID) values (4, 273);
insert into orderLineItems (orderID, productID) values (4, 566);
insert into orders values (5, 1);
insert into orderLineItems (orderID, productID) values (5, 101);
insert into orderLineItems (orderID, productID) values (5, 636);
insert into orderLineItems (orderID, productID) values (5, 553);
insert into orderLineItems (orderID, productID) values (5, 50);
insert into orderLineItems (orderID, productID) values (5, 520);
insert into viewed values (1, 66);
insert into viewed values (1, 482);
insert into viewed values (1, 1);
insert into viewed values (1, 217);
insert into viewed values (1, 264);
insert into viewed values (1, 32);
insert into viewed values (1, 216);
insert into viewed values (1, 57);
insert into viewed values (1, 642);
insert into viewed values (1, 442);
insert into viewed values (1, 395);
insert into viewed values (1, 245);
insert into viewed values (1, 309);
insert into viewed values (1, 415);
insert into viewed values (1, 130);
insert into viewed values (1, 203);
insert into viewed values (1, 7);
insert into viewed values (1, 250);
insert into viewed values (1, 589);
insert into viewed values (1, 396);
insert into viewed values (1, 465);
insert into viewed values (1, 544);
insert into viewed values (1, 607);
insert into viewed values (1, 615);
insert into viewed values (1, 425);
insert into viewed values (1, 640);
insert into viewed values (1, 15);
insert into viewed values (1, 543);
insert into viewed values (1, 299);
insert into viewed values (1, 637);
insert into viewed values (1, 94);
insert into viewed values (1, 106);
insert into viewed values (1, 379);
insert into viewed values (1, 634);
insert into viewed values (1, 59);
insert into viewed values (1, 118);
insert into viewed values (1, 585);
insert into viewed values (1, 547);
insert into viewed values (1, 577);
insert into viewed values (1, 369);
insert into viewed values (1, 62);
insert into viewed values (1, 579);
insert into viewed values (1, 635);
insert into viewed values (1, 175);
insert into viewed values (1, 531);
insert into viewed values (1, 215);
insert into viewed values (1, 510);
insert into viewed values (1, 367);
insert into viewed values (1, 266);
insert into viewed values (1, 470);
insert into viewed values (1, 155);
insert into viewed values (1, 304);
insert into viewed values (1, 355);
insert into viewed values (1, 306);
insert into viewed values (1, 625);
insert into viewed values (1, 192);
insert into viewed values (1, 479);
insert into viewed values (1, 499);
insert into viewed values (1, 393);
insert into viewed values (1, 330);
insert into viewed values (1, 303);
insert into viewed values (1, 205);
insert into viewed values (1, 643);
insert into viewed values (1, 269);
insert into viewed values (1, 493);
insert into viewed values (1, 223);
insert into viewed values (1, 489);
insert into viewed values (1, 312);
insert into viewed values (1, 614);
insert into viewed values (1, 275);
insert into viewed values (1, 284);
insert into viewed values (1, 360);
insert into viewed values (1, 179);
insert into viewed values (1, 639);
insert into viewed values (1, 99);
insert into viewed values (1, 239);
insert into viewed values (1, 387);
insert into viewed values (1, 20);
insert into viewed values (1, 376);
insert into viewed values (1, 37);
insert into viewed values (1, 652);
insert into viewed values (1, 286);
insert into viewed values (1, 91);
insert into viewed values (1, 147);
insert into viewed values (1, 248);
insert into viewed values (1, 618);
insert into viewed values (1, 202);
insert into viewed values (1, 423);
insert into viewed values (1, 414);
insert into orders values (6, 2);
insert into orderLineItems (orderID, productID) values (6, 459);
insert into orderLineItems (orderID, productID) values (6, 383);
insert into orders values (7, 2);
insert into orderLineItems (orderID, productID) values (7, 431);
insert into orderLineItems (orderID, productID) values (7, 93);
insert into orders values (8, 2);
insert into orderLineItems (orderID, productID) values (8, 315);
insert into orderLineItems (orderID, productID) values (8, 318);
insert into orderLineItems (orderID, productID) values (8, 476);
insert into orderLineItems (orderID, productID) values (8, 478);
insert into orderLineItems (orderID, productID) values (8, 366);
insert into orders values (9, 2);
insert into orderLineItems (orderID, productID) values (9, 118);
insert into orderLineItems (orderID, productID) values (9, 551);
insert into orderLineItems (orderID, productID) values (9, 655);
insert into orderLineItems (orderID, productID) values (9, 446);
insert into orderLineItems (orderID, productID) values (9, 88);
insert into orderLineItems (orderID, productID) values (9, 455);
insert into orderLineItems (orderID, productID) values (9, 65);
insert into orderLineItems (orderID, productID) values (9, 396);
insert into orderLineItems (orderID, productID) values (9, 443);
insert into orders values (10, 2);
insert into orderLineItems (orderID, productID) values (10, 165);
insert into orderLineItems (orderID, productID) values (10, 331);
insert into orderLineItems (orderID, productID) values (10, 280);
insert into orderLineItems (orderID, productID) values (10, 281);
insert into orderLineItems (orderID, productID) values (10, 537);
insert into orderLineItems (orderID, productID) values (10, 342);
insert into viewed values (2, 607);
insert into viewed values (2, 371);
insert into viewed values (2, 72);
insert into viewed values (2, 121);
insert into viewed values (2, 520);
insert into viewed values (2, 146);
insert into viewed values (2, 521);
insert into viewed values (2, 587);
insert into viewed values (2, 408);
insert into viewed values (2, 367);
insert into viewed values (2, 231);
insert into viewed values (2, 411);
insert into orders values (11, 3);
insert into orderLineItems (orderID, productID) values (11, 466);
insert into orderLineItems (orderID, productID) values (11, 320);
insert into orderLineItems (orderID, productID) values (11, 656);
insert into orderLineItems (orderID, productID) values (11, 325);
insert into orders values (12, 3);
insert into orderLineItems (orderID, productID) values (12, 407);
insert into orderLineItems (orderID, productID) values (12, 556);
insert into orderLineItems (orderID, productID) values (12, 301);
insert into orderLineItems (orderID, productID) values (12, 329);
insert into orderLineItems (orderID, productID) values (12, 198);
insert into orderLineItems (orderID, productID) values (12, 380);
insert into orders values (13, 3);
insert into orderLineItems (orderID, productID) values (13, 237);
insert into orderLineItems (orderID, productID) values (13, 192);
insert into orderLineItems (orderID, productID) values (13, 450);
insert into orders values (14, 3);
insert into orderLineItems (orderID, productID) values (14, 284);
insert into orders values (15, 3);
insert into orderLineItems (orderID, productID) values (15, 229);
insert into orderLineItems (orderID, productID) values (15, 64);
insert into orderLineItems (orderID, productID) values (15, 3);
insert into orderLineItems (orderID, productID) values (15, 587);
insert into orderLineItems (orderID, productID) values (15, 9);
insert into orderLineItems (orderID, productID) values (15, 411);
insert into orders values (16, 3);
insert into orderLineItems (orderID, productID) values (16, 526);
insert into orderLineItems (orderID, productID) values (16, 223);
insert into orderLineItems (orderID, productID) values (16, 228);
insert into orders values (17, 3);
insert into orderLineItems (orderID, productID) values (17, 655);
insert into orderLineItems (orderID, productID) values (17, 392);
insert into orderLineItems (orderID, productID) values (17, 157);
insert into orderLineItems (orderID, productID) values (17, 5);
insert into orderLineItems (orderID, productID) values (17, 420);
insert into orderLineItems (orderID, productID) values (17, 616);
insert into orderLineItems (orderID, productID) values (17, 597);
insert into orders values (18, 3);
insert into orderLineItems (orderID, productID) values (18, 413);
insert into orderLineItems (orderID, productID) values (18, 196);
insert into orders values (19, 3);
insert into orderLineItems (orderID, productID) values (19, 637);
insert into orderLineItems (orderID, productID) values (19, 318);
insert into viewed values (3, 420);
insert into viewed values (3, 46);
insert into viewed values (3, 578);
insert into viewed values (3, 91);
insert into viewed values (3, 508);
insert into viewed values (3, 104);
insert into viewed values (3, 544);
insert into viewed values (3, 657);
insert into viewed values (3, 402);
insert into viewed values (3, 609);
insert into viewed values (3, 218);
insert into viewed values (3, 201);
insert into viewed values (3, 82);
insert into viewed values (3, 170);
insert into viewed values (3, 457);
insert into viewed values (3, 400);
insert into viewed values (3, 631);
insert into viewed values (3, 414);
insert into viewed values (3, 574);
insert into viewed values (3, 581);
insert into viewed values (3, 278);
insert into viewed values (3, 292);
insert into viewed values (3, 455);
insert into viewed values (3, 331);
insert into viewed values (3, 387);
insert into viewed values (3, 506);
insert into viewed values (3, 582);
insert into viewed values (3, 341);
insert into viewed values (3, 128);
insert into viewed values (3, 500);
insert into viewed values (3, 395);
insert into viewed values (3, 660);
insert into viewed values (3, 203);
insert into viewed values (3, 352);
insert into viewed values (3, 4);
insert into viewed values (3, 416);
insert into viewed values (3, 571);
insert into viewed values (3, 257);
insert into viewed values (3, 266);
insert into viewed values (3, 81);
insert into viewed values (3, 300);
insert into viewed values (3, 69);
insert into viewed values (3, 144);
insert into viewed values (3, 654);
insert into viewed values (3, 163);
insert into viewed values (3, 291);
insert into viewed values (3, 181);
insert into viewed values (3, 399);
insert into viewed values (3, 538);
insert into viewed values (3, 220);
insert into viewed values (3, 122);
insert into viewed values (3, 76);
insert into viewed values (3, 155);
insert into viewed values (3, 289);
insert into viewed values (3, 301);
insert into viewed values (3, 171);
insert into viewed values (3, 186);
insert into viewed values (3, 304);
insert into viewed values (3, 193);
insert into viewed values (3, 360);
insert into viewed values (3, 29);
insert into viewed values (3, 431);
insert into viewed values (3, 338);
insert into viewed values (3, 626);
insert into viewed values (3, 651);
insert into viewed values (3, 327);
insert into viewed values (3, 120);
insert into viewed values (3, 190);
insert into viewed values (3, 322);
insert into viewed values (3, 234);
insert into viewed values (3, 389);
insert into viewed values (3, 517);
insert into viewed values (3, 176);
insert into viewed values (3, 520);
insert into viewed values (3, 210);
insert into viewed values (3, 195);
insert into viewed values (3, 197);
insert into viewed values (3, 599);
insert into viewed values (3, 627);
insert into viewed values (3, 125);
insert into viewed values (3, 380);
insert into viewed values (3, 339);
insert into viewed values (3, 227);
insert into viewed values (3, 208);
insert into viewed values (3, 205);
insert into viewed values (3, 535);
insert into viewed values (3, 113);
insert into viewed values (3, 279);
insert into viewed values (3, 77);
insert into viewed values (3, 313);
insert into viewed values (3, 93);
insert into viewed values (3, 373);
insert into viewed values (3, 562);
insert into viewed values (3, 160);
insert into viewed values (3, 374);
insert into viewed values (3, 148);
insert into orders values (20, 4);
insert into orderLineItems (orderID, productID) values (20, 160);
insert into orderLineItems (orderID, productID) values (20, 599);
insert into orderLineItems (orderID, productID) values (20, 239);
insert into orderLineItems (orderID, productID) values (20, 248);
insert into orderLineItems (orderID, productID) values (20, 238);
insert into orderLineItems (orderID, productID) values (20, 561);
insert into orderLineItems (orderID, productID) values (20, 633);
insert into orderLineItems (orderID, productID) values (20, 198);
insert into orderLineItems (orderID, productID) values (20, 19);
insert into orders values (21, 4);
insert into orderLineItems (orderID, productID) values (21, 406);
insert into orderLineItems (orderID, productID) values (21, 164);
insert into orders values (22, 4);
insert into orderLineItems (orderID, productID) values (22, 367);
insert into orderLineItems (orderID, productID) values (22, 187);
insert into orderLineItems (orderID, productID) values (22, 10);
insert into orderLineItems (orderID, productID) values (22, 193);
insert into orderLineItems (orderID, productID) values (22, 227);
insert into orderLineItems (orderID, productID) values (22, 596);
insert into orders values (23, 4);
insert into orderLineItems (orderID, productID) values (23, 567);
insert into orderLineItems (orderID, productID) values (23, 300);
insert into orderLineItems (orderID, productID) values (23, 192);
insert into orders values (24, 4);
insert into orderLineItems (orderID, productID) values (24, 99);
insert into orderLineItems (orderID, productID) values (24, 604);
insert into orderLineItems (orderID, productID) values (24, 40);
insert into orderLineItems (orderID, productID) values (24, 441);
insert into orderLineItems (orderID, productID) values (24, 165);
insert into orderLineItems (orderID, productID) values (24, 2);
insert into orders values (25, 4);
insert into orderLineItems (orderID, productID) values (25, 232);
insert into orderLineItems (orderID, productID) values (25, 648);
insert into orderLineItems (orderID, productID) values (25, 499);
insert into orderLineItems (orderID, productID) values (25, 354);
insert into orderLineItems (orderID, productID) values (25, 388);
insert into orderLineItems (orderID, productID) values (25, 141);
insert into orderLineItems (orderID, productID) values (25, 234);
insert into orderLineItems (orderID, productID) values (25, 370);
insert into orderLineItems (orderID, productID) values (25, 549);
insert into orders values (26, 4);
insert into orders values (27, 4);
insert into orderLineItems (orderID, productID) values (27, 136);
insert into orderLineItems (orderID, productID) values (27, 480);
insert into orderLineItems (orderID, productID) values (27, 668);
insert into orderLineItems (orderID, productID) values (27, 400);
insert into orderLineItems (orderID, productID) values (27, 466);
insert into orderLineItems (orderID, productID) values (27, 484);
insert into orderLineItems (orderID, productID) values (27, 12);
insert into orders values (28, 4);
insert into orderLineItems (orderID, productID) values (28, 201);
insert into orderLineItems (orderID, productID) values (28, 520);
insert into viewed values (4, 19);
insert into viewed values (4, 419);
insert into viewed values (4, 267);
insert into viewed values (4, 313);
insert into viewed values (4, 574);
insert into viewed values (4, 387);
insert into viewed values (4, 105);
insert into viewed values (4, 42);
insert into viewed values (4, 110);
insert into viewed values (4, 87);
insert into viewed values (4, 611);
insert into viewed values (4, 598);
insert into viewed values (4, 123);
insert into viewed values (4, 433);
insert into viewed values (4, 318);
insert into viewed values (4, 406);
insert into viewed values (4, 119);
insert into viewed values (4, 246);
insert into viewed values (4, 294);
insert into viewed values (4, 235);
insert into viewed values (4, 209);
insert into viewed values (4, 539);
insert into viewed values (4, 364);
insert into viewed values (4, 214);
insert into viewed values (4, 179);
insert into viewed values (4, 304);
insert into viewed values (4, 125);
insert into viewed values (4, 478);
insert into viewed values (4, 131);
insert into viewed values (4, 72);
insert into viewed values (4, 231);
insert into viewed values (4, 229);
insert into viewed values (4, 354);
insert into viewed values (4, 273);
insert into viewed values (4, 382);
insert into viewed values (4, 64);
insert into viewed values (4, 467);
insert into viewed values (4, 335);
insert into viewed values (4, 154);
insert into viewed values (4, 587);
insert into viewed values (4, 610);
insert into viewed values (4, 153);
insert into viewed values (4, 208);
insert into viewed values (4, 274);
insert into viewed values (4, 160);
insert into viewed values (4, 386);
insert into viewed values (4, 102);
insert into viewed values (4, 118);
insert into viewed values (4, 180);
insert into viewed values (4, 352);
insert into viewed values (4, 665);
insert into viewed values (4, 164);
insert into viewed values (4, 270);
insert into viewed values (4, 522);
insert into viewed values (4, 185);
insert into viewed values (4, 230);
insert into viewed values (4, 74);
insert into viewed values (4, 621);
insert into viewed values (4, 290);
insert into viewed values (4, 306);
insert into viewed values (4, 366);
insert into viewed values (4, 409);
insert into viewed values (4, 589);
insert into viewed values (4, 233);
insert into viewed values (4, 216);
insert into viewed values (4, 278);
insert into viewed values (4, 242);
insert into viewed values (4, 44);
insert into viewed values (4, 650);
insert into viewed values (4, 484);
insert into viewed values (4, 391);
insert into viewed values (4, 637);
insert into viewed values (4, 548);
insert into viewed values (4, 15);
insert into viewed values (4, 449);
insert into viewed values (4, 300);
insert into viewed values (4, 104);
insert into viewed values (4, 516);
insert into viewed values (4, 30);
insert into viewed values (4, 551);
insert into viewed values (4, 60);
insert into viewed values (4, 16);
insert into viewed values (4, 635);
insert into viewed values (4, 531);
insert into viewed values (4, 188);
insert into orders values (29, 5);
insert into orderLineItems (orderID, productID) values (29, 359);
insert into orderLineItems (orderID, productID) values (29, 471);
insert into orderLineItems (orderID, productID) values (29, 461);
insert into orderLineItems (orderID, productID) values (29, 210);
insert into orderLineItems (orderID, productID) values (29, 624);
insert into orderLineItems (orderID, productID) values (29, 151);
insert into orderLineItems (orderID, productID) values (29, 28);
insert into orders values (30, 5);
insert into orderLineItems (orderID, productID) values (30, 546);
insert into orderLineItems (orderID, productID) values (30, 318);
insert into orders values (31, 5);
insert into orderLineItems (orderID, productID) values (31, 190);
insert into orderLineItems (orderID, productID) values (31, 573);
insert into orderLineItems (orderID, productID) values (31, 54);
insert into orders values (32, 5);
insert into orderLineItems (orderID, productID) values (32, 126);
insert into orderLineItems (orderID, productID) values (32, 215);
insert into orderLineItems (orderID, productID) values (32, 135);
insert into orderLineItems (orderID, productID) values (32, 430);
insert into orderLineItems (orderID, productID) values (32, 346);
insert into orderLineItems (orderID, productID) values (32, 294);
insert into orderLineItems (orderID, productID) values (32, 488);
insert into orderLineItems (orderID, productID) values (32, 340);
insert into orders values (33, 5);
insert into orderLineItems (orderID, productID) values (33, 376);
insert into orderLineItems (orderID, productID) values (33, 55);
insert into orderLineItems (orderID, productID) values (33, 549);
insert into viewed values (5, 229);
insert into viewed values (5, 91);
insert into viewed values (5, 494);
insert into viewed values (5, 458);
insert into viewed values (5, 650);
insert into viewed values (5, 589);
insert into viewed values (5, 639);
insert into viewed values (5, 386);
insert into viewed values (5, 176);
insert into viewed values (5, 46);
insert into viewed values (5, 23);
insert into orders values (34, 6);
insert into orderLineItems (orderID, productID) values (34, 156);
insert into orderLineItems (orderID, productID) values (34, 362);
insert into orderLineItems (orderID, productID) values (34, 70);
insert into orderLineItems (orderID, productID) values (34, 505);
insert into orderLineItems (orderID, productID) values (34, 329);
insert into orderLineItems (orderID, productID) values (34, 573);
insert into orderLineItems (orderID, productID) values (34, 311);
insert into orderLineItems (orderID, productID) values (34, 89);
insert into orderLineItems (orderID, productID) values (34, 77);
insert into orders values (35, 6);
insert into orderLineItems (orderID, productID) values (35, 26);
insert into orderLineItems (orderID, productID) values (35, 157);
insert into orderLineItems (orderID, productID) values (35, 12);
insert into orderLineItems (orderID, productID) values (35, 578);
insert into orderLineItems (orderID, productID) values (35, 558);
insert into orders values (36, 6);
insert into orderLineItems (orderID, productID) values (36, 341);
insert into orderLineItems (orderID, productID) values (36, 436);
insert into orderLineItems (orderID, productID) values (36, 240);
insert into orderLineItems (orderID, productID) values (36, 386);
insert into orderLineItems (orderID, productID) values (36, 662);
insert into orders values (37, 6);
insert into orderLineItems (orderID, productID) values (37, 130);
insert into orderLineItems (orderID, productID) values (37, 312);
insert into orderLineItems (orderID, productID) values (37, 479);
insert into orderLineItems (orderID, productID) values (37, 40);
insert into orderLineItems (orderID, productID) values (37, 580);
insert into orderLineItems (orderID, productID) values (37, 16);
insert into orders values (38, 6);
insert into orderLineItems (orderID, productID) values (38, 90);
insert into orderLineItems (orderID, productID) values (38, 64);
insert into orderLineItems (orderID, productID) values (38, 215);
insert into viewed values (6, 632);
insert into viewed values (6, 553);
insert into viewed values (6, 482);
insert into viewed values (6, 146);
insert into viewed values (6, 161);
insert into viewed values (6, 115);
insert into viewed values (6, 142);
insert into viewed values (6, 600);
insert into viewed values (6, 564);
insert into viewed values (6, 476);
insert into viewed values (6, 539);
insert into viewed values (6, 618);
insert into viewed values (6, 167);
insert into viewed values (6, 466);
insert into viewed values (6, 109);
insert into viewed values (6, 377);
insert into viewed values (6, 354);
insert into viewed values (6, 495);
insert into viewed values (6, 235);
insert into viewed values (6, 284);
insert into viewed values (6, 449);
insert into viewed values (6, 121);
insert into viewed values (6, 207);
insert into viewed values (6, 607);
insert into viewed values (6, 232);
insert into viewed values (6, 225);
insert into viewed values (6, 598);
insert into viewed values (6, 128);
insert into viewed values (6, 367);
insert into viewed values (6, 28);
insert into orders values (39, 7);
insert into orderLineItems (orderID, productID) values (39, 125);
insert into orderLineItems (orderID, productID) values (39, 181);
insert into orderLineItems (orderID, productID) values (39, 370);
insert into orderLineItems (orderID, productID) values (39, 119);
insert into orders values (40, 7);
insert into orderLineItems (orderID, productID) values (40, 513);
insert into orderLineItems (orderID, productID) values (40, 345);
insert into orderLineItems (orderID, productID) values (40, 114);
insert into orderLineItems (orderID, productID) values (40, 424);
insert into orderLineItems (orderID, productID) values (40, 438);
insert into orderLineItems (orderID, productID) values (40, 649);
insert into orderLineItems (orderID, productID) values (40, 470);
insert into orders values (41, 7);
insert into orderLineItems (orderID, productID) values (41, 12);
insert into orderLineItems (orderID, productID) values (41, 80);
insert into orderLineItems (orderID, productID) values (41, 248);
insert into orderLineItems (orderID, productID) values (41, 457);
insert into orderLineItems (orderID, productID) values (41, 610);
insert into orderLineItems (orderID, productID) values (41, 283);
insert into orders values (42, 7);
insert into orderLineItems (orderID, productID) values (42, 498);
insert into orderLineItems (orderID, productID) values (42, 523);
insert into orderLineItems (orderID, productID) values (42, 373);
insert into orderLineItems (orderID, productID) values (42, 210);
insert into orderLineItems (orderID, productID) values (42, 83);
insert into orderLineItems (orderID, productID) values (42, 120);
insert into orderLineItems (orderID, productID) values (42, 578);
insert into orderLineItems (orderID, productID) values (42, 65);
insert into orders values (43, 7);
insert into orderLineItems (orderID, productID) values (43, 251);
insert into orderLineItems (orderID, productID) values (43, 226);
insert into orderLineItems (orderID, productID) values (43, 379);
insert into orderLineItems (orderID, productID) values (43, 400);
insert into orderLineItems (orderID, productID) values (43, 352);
insert into orderLineItems (orderID, productID) values (43, 153);
insert into viewed values (7, 303);
insert into viewed values (7, 29);
insert into viewed values (7, 624);
insert into viewed values (7, 162);
insert into viewed values (7, 400);
insert into viewed values (7, 350);
insert into viewed values (7, 248);
insert into viewed values (7, 395);
insert into viewed values (7, 6);
insert into viewed values (7, 572);
insert into viewed values (7, 526);
insert into viewed values (7, 410);
insert into viewed values (7, 645);
insert into viewed values (7, 207);
insert into viewed values (7, 474);
insert into viewed values (7, 97);
insert into viewed values (7, 22);
insert into viewed values (7, 544);
insert into viewed values (7, 8);
insert into viewed values (7, 331);
insert into viewed values (7, 488);
insert into viewed values (7, 314);
insert into viewed values (7, 644);
insert into viewed values (7, 662);
insert into viewed values (7, 134);
insert into viewed values (7, 225);
insert into viewed values (7, 181);
insert into viewed values (7, 478);
insert into viewed values (7, 302);
insert into viewed values (7, 621);
insert into viewed values (7, 396);
insert into viewed values (7, 257);
insert into viewed values (7, 535);
insert into viewed values (7, 642);
insert into viewed values (7, 369);
insert into viewed values (7, 559);
insert into viewed values (7, 397);
insert into viewed values (7, 233);
insert into viewed values (7, 28);
insert into viewed values (7, 574);
insert into viewed values (7, 117);
insert into viewed values (7, 358);
insert into viewed values (7, 238);
insert into viewed values (7, 467);
insert into viewed values (7, 26);
insert into viewed values (7, 102);
insert into viewed values (7, 536);
insert into viewed values (7, 329);
insert into viewed values (7, 466);
insert into viewed values (7, 260);
insert into viewed values (7, 280);
insert into viewed values (7, 234);
insert into viewed values (7, 251);

-- Tuco, one order, just a few views
insert into orders values (44, 8);
insert into orderLineItems (orderID, productID) values (44, 251);
insert into orderLineItems (orderID, productID) values (44, 226);
insert into orderLineItems (orderID, productID) values (44, 379);
insert into orderLineItems (orderID, productID) values (44, 400);
insert into orderLineItems (orderID, productID) values (44, 352);
insert into orderLineItems (orderID, productID) values (44, 153);
insert into orderLineItems (orderID, productID) values (44, 12);
insert into orderLineItems (orderID, productID) values (44, 12);
insert into orderLineItems (orderID, productID) values (44, 12);
insert into viewed values (8, 251);
insert into viewed values (8, 226);
insert into viewed values (8, 379);
insert into viewed values (8, 400);
insert into viewed values (8, 352);
insert into viewed values (8, 153);
insert into viewed values (8, 544);
insert into viewed values (8, 8);
insert into viewed values (8, 115);
insert into viewed values (8, 142);
insert into viewed values (8, 600);
insert into viewed values (8, 564);
insert into viewed values (8, 476);
insert into viewed values (8, 539);
insert into viewed values (8, 618);

-- gustavo has 1 view, no orders
insert into viewed values (9, 251);
