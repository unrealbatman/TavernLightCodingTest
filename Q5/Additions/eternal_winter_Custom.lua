-- Set up local arrays
local combats = {} -- Array to hold combat instances
local areas = { -- Array to define different combat areas
    -- Area 1
    {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 1, 0, 0, 1, 0},
        {0, 0, 1, 0, 2, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
    -- Area 2
    {
        {0, 0, 0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 2, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
    -- Area 3
    {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 2, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
    -- Area 4
    {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 3, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
	
	 -- Additional Areas
    -- Area 5
    {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 1, 0, 0, 1, 0},
        {0, 0, 1, 0, 2, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
    -- Area 6
    {
        {0, 0, 0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 2, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
    -- Area 7
    {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 2, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
    -- Area 8
    {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 3, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
}

-- Loop to set up combat instances for each area
for i = 1, #areas do
    combats[i] = Combat() -- Create new Combat instance
    combats[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE) -- Set combat type
    combats[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO) -- Set combat effect
    combats[i]:setArea(createCombatArea(areas[i])) -- Set combat area
    
    -- Function to calculate the level/magicLevel -min & -max
    function onGetFormulaValues(player, level, magicLevel)
        local min = (level / 5) + (magicLevel * 8) + 50
        local max = (level / 5) + (magicLevel * 12) + 75
        return -min, -max
    end
    
    -- Set up callback for combat instance
    combats[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end

-- Function to execute the combat spell
local function castSpell(creatureId, variant, combatIndex)
    combats[combatIndex]:execute(creature, variant) -- Execute the instance(s) of the combat(s)
end

-- Function to handle casting spell on creature
function onCastSpell(creature, variant)
    -- Loop twice over all areas
    for _ = 1, 2 do
        -- Loop through each area
        for i = 1, #areas do
            -- Schedule casting spell for each area
            addEvent(castSpell, 250 * i, creature.uid, variant, i)
        end
    end
    -- Execute the first combat instance immediately
    return combats[1]:execute(creature, variant)
end
