-----------------------------------
--
-- Zone: Valkurm_Dunes (103)
--
-----------------------------------
package.loaded["scripts/zones/Valkurm_Dunes/TextIDs"] = nil;
package.loaded["scripts/globals/chocobo_digging"] = nil;
-----------------------------------

require("scripts/zones/Valkurm_Dunes/TextIDs");
require("scripts/globals/zone");
require("scripts/globals/icanheararainbow");
require("scripts/globals/status");
require("scripts/globals/weather");
require("scripts/globals/conquest");
require("scripts/globals/chocobo_digging");

-----------------------------------
-- Chocobo Digging vars
-----------------------------------
local itemMap = {
                    -- itemid, abundance, requirement
                    { 880, 224, DIGREQ_NONE },
                    { 887, 39, DIGREQ_NONE },
                    { 645, 14, DIGREQ_NONE },
                    { 893, 105, DIGREQ_NONE }, 
                    { 737, 17, DIGREQ_NONE },
                    { 643, 64, DIGREQ_NONE },
                    { 17296, 122, DIGREQ_NONE },
                    { 942, 6, DIGREQ_NONE },
                    { 642, 58, DIGREQ_NONE },
                    { 864, 22, DIGREQ_NONE },
                    { 843, 4, DIGREQ_NONE },
                    { 4096, 100, DIGREQ_NONE },
                    { 4097, 100, DIGREQ_NONE },
                    { 4098, 100, DIGREQ_NONE },
                    { 4099, 100, DIGREQ_NONE },
                    { 4100, 100, DIGREQ_NONE },
                    { 4101, 100, DIGREQ_NONE },
                    { 4102, 100, DIGREQ_NONE },
                    { 4103, 100, DIGREQ_NONE },
                    { 845, 122, DIGREQ_BURROW },
                    { 844, 71, DIGREQ_BURROW },
                    { 1845, 33, DIGREQ_BURROW },
                    { 838, 11, DIGREQ_BURROW },
                    { 902, 6, DIGREQ_BORE },
                    { 886, 3, DIGREQ_BORE },
                    { 867, 3, DIGREQ_BORE },
                    { 1587, 19, DIGREQ_BORE },
                    { 888, 25, DIGREQ_BORE },
                    { 1586, 8, DIGREQ_BORE },
                    { 885, 10, DIGREQ_BORE },
                    { 866, 3, DIGREQ_BORE },
                    { 4570, 10, DIGREQ_MODIFIER },
                    { 4487, 11, DIGREQ_MODIFIER },
                    { 4409, 12, DIGREQ_MODIFIER },
                    { 1188, 10, DIGREQ_MODIFIER },
                    { 4532, 12, DIGREQ_MODIFIER },
                };

local messageArray = { DIG_THROW_AWAY, FIND_NOTHING, ITEM_OBTAINED };

-----------------------------------
-- onChocoboDig
-----------------------------------
function onChocoboDig(player, precheck)

    -- Let's get the weather of the zone

    local weather = player:getWeather();

    if (weather ~= nil) then
      if (weather >= 0 and weather <= 4) then
        zoneWeather = "WEATHER_NONE";
      elseif (weather > 4 and weather % 2 ~= 0) then -- If the weather is 5, 7, 9, 11, 13, 15, 17 or 19, checking for odd values
        zoneWeather = "WEATHER_DOUBLE";
      else
        zoneWeather = "WEATHER_SINGLE";
      end
    else
      zoneWeather = "WEATHER_NONE";
    end
    
    return chocoboDig(player, itemMap, precheck, messageArray, zoneWeather);
end;

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
    local manuals = {17199751,17199752,17199753};

    SetFieldManual(manuals);

    SetRegionalConquestOverseers(zone:getRegionID())
end;

-----------------------------------
-- onZoneIn
-----------------------------------

function onZoneIn( player, prevZone)
    local cs = -1;

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos( 60.989, -4.898, -151.001, 198);
    end

    if (triggerLightCutscene(player)) then -- Quest: I Can Hear A Rainbow
        cs = 0x0003;
    end

    return cs;
end;

-----------------------------------
-- onConquestUpdate
-----------------------------------

function onConquestUpdate(zone, updatetype)
    local players = zone:getPlayers();

    for name, player in pairs(players) do
        conquestUpdate(zone, player, updatetype, CONQUEST_BASE);
    end
end;

-----------------------------------
-- onRegionEnter
-----------------------------------

function onRegionEnter( player, region)
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate( player, csid, option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 0x0003) then
        lightCutsceneUpdate(player); -- Quest: I Can Hear A Rainbow
    end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish( player, csid, option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 0x0003) then
        lightCutsceneFinish(player); -- Quest: I Can Hear A Rainbow
    end
end;

-----------------------------------
-- onZoneWeatherChange
-----------------------------------

function onZoneWeatherChange(weather)
    local qm1 = GetNPCByID(17199699); -- Quest: An Empty Vessel
    if (weather == WEATHER_DUST_STORM) then
        qm1:setStatus(STATUS_NORMAL);
    else
        qm1:setStatus(STATUS_DISAPPEAR);
    end
end;