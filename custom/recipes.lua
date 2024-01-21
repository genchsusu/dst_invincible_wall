GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

Recipe2("wall_hay_item",               {Ingredient("cutgrass", 4), Ingredient("twigs", 2)},                          TECH.SCIENCE_ONE,   {numtogive=99})
Recipe2("wall_wood_item",              {Ingredient("boards", 2), Ingredient("rope", 1)},                             TECH.SCIENCE_ONE,   {numtogive=99})
Recipe2("wall_stone_item",             {Ingredient("cutstone", 2)},                                                  TECH.SCIENCE_TWO,   {numtogive=99})
Recipe2("wall_moonrock_item",          {Ingredient("moonrocknugget", 4)},                                            TECH.SCIENCE_TWO,   {numtogive=99})
Recipe2("wall_dreadstone_item",        {Ingredient("dreadstone", 4)},                                                TECH.LOST,          {numtogive=99})
Recipe2("wall_ruins_item",             {Ingredient("thulecite", 1)},                                                 TECH.ANCIENT_TWO,   {numtogive=99})