-----------------------------------
-- Area: Residential Area
-- NPC:  Moogle
-- Defunct Script - Should not be called by anything anymore
-- Moogle scripts are in each zone, calling a function from moghouse.lua
-----------------------------------
require("scripts/globals/moghouse")

-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
    moogleTrade(player,npc,trade);
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
    moogleTrigger(player,npc)
end; 

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 30000) then
        player:setVar("MoghouseExplication",0);
    end
end;

