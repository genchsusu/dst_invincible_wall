local function e_or_z(en, zh)
	return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = e_or_z("Invincible Wall", "多功能墙体")
author = "OpenSource"
version = "1.0.5"
description = e_or_z(
    [[
Features
- Impenetrable: Modified physical properties that prevent all non-player entities, cannot be instantly destroyed by boss units.
- Highly Damage Absorbent: The wall now absorbs the vast majority of damage, making it indestructible.
- Provides Light: The wall provides a certain range of daylight effect.
- Sanity Aura: The sanity aura emitted by the wall helps players maintain their sanity, increasing chances of survival.
- Lightning Protection: These walls have a lightning rod effect, effectively preventing damage to players and buildings from lightning.
- Rainproof Design: The wall has excellent rainproof characteristics.
- Bird Repellent: No birds appear around the wall, providing players with a quieter environment.
- Antlion Pit Prevention: Effectively prevents the formation of antlion traps, protecting players from this natural disaster.
- Intelligent Automatic Door: When players approach, the wall lowers its height automatically; as soon as the player leaves, the wall immediately returns to its original state.
- Increased Production: Produce more walls.
- Show icons: Show wall icons in the minimap.
- RShift+PgUp: Increase the height of the wall.
- RShift+PgDn: Decrease the height of the wall.
    ]],
    [[
    ]],
    [[
功能
- 不可穿越: 修改了物理属性，可以阻止所有非玩家实体，无法被boss单位瞬间摧毁。
- 高效吸收损伤: 墙体现在可以吸收绝大多数伤害，使其坚不可摧。
- 提供光源: 墙体提供一定范围的白昼效果。
- 理智光环: 墙体散发出的理智光环能够帮助玩家保持理智状态，增加生存机会。
- 雷电防护: 这些墙体具备避雷针效果，有效防止雷电对玩家及建筑的伤害。
- 防雨设计: 墙体具备优秀的防雨特性。
- 驱赶鸟类: 墙体周围不会有鸟类出没，为玩家提供一个更加安静的环境。
- 防蚁狮坑: 有效防止蚁狮陷阱的形成，保护玩家不受这种自然灾害的影响。
- 智能自动门: 当玩家靠近时，墙体会自动降低高度；一旦玩家离开，墙体立即恢复原状。
- 提升产量: 造出更多墙体。
- 显示图标：在小地图显示墙的图标。
- RShift+PgUp: 增加墙的高度。
- RShift+PgDn: 降低墙的高度。
    ]]
)

forumthread = ""

api_version = 10

icon_atlas = "images/modicon.xml"
icon = "modicon.tex"

dst_compatible = true
client_only_mod = false
all_clients_require_mod = true

priority = 0.1

local function AddConfig(label, name, hover, options, default)
	return {
		label = label,
		name = name,
		hover = hover or '',
		options = options or {
			{description = e_or_z("On", "开启"), data = true},
			{description = e_or_z("Off", "关闭"), data = false},
		},
		default = default
	}
end

configuration_options =
{
    AddConfig(e_or_z("Light Source", "光源"), "enable_light", e_or_z("Set the range of wall lighting", "设置墙体发光的范围"), 
        {
            {description = e_or_z("Off", "关闭"), data = false},
            {description = "3", data = 3},
            {description = "6", data = 6},
            {description = "12", data = 12}
        }, 6),

    AddConfig(e_or_z("Sanity Aura", "理智光环"), "enable_sanityaura", e_or_z("Enable or disable the wall's sanity aura", "开启或关闭墙体的理智光环"), nil, true),
    AddConfig(e_or_z("Lightning Protection", "雷电防护"), "enable_lightningblocker", e_or_z("Set the effect of the wall's lightning rod", "设置墙体的避雷针效果"), nil, true),
    AddConfig(e_or_z("Bird Repellent", "驱赶鸟类"), "enable_bird_repellent", e_or_z("Enable or disable the wall's bird repellent effect", "开启或关闭墙体的驱赶鸟类效果"), nil, true),
    AddConfig(e_or_z("Absolute Defense", "绝对防御"), "enable_absolute_guard", e_or_z("Enable or disable the wall's rainproof, earthquake-proof, and antlion pit-proof effects", "开启或关闭墙体的防雨防地震防蚁狮坑效果"), nil, true),
    AddConfig(e_or_z("Smart Auto Door", "智能自动门"), "enable_auto_door", e_or_z("Enable or disable the wall's smart auto door effect", "开启或关闭墙体的智能自动门效果"), nil, true),
    AddConfig(e_or_z("Increase Yield", "提升产量"), "enable_increased", e_or_z("Whether to increase the wall's yield", "是否提升墙体的产量"), nil, true),
    AddConfig(e_or_z("Show icons", "显示图标"), "enable_minimapicons", e_or_z("Show wall icons in the minimap", "在小地图显示墙的图标"), nil, true),
}