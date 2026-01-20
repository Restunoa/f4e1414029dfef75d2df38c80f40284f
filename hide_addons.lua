local target_tab, target_container = "CONFIG", "Presets"
local TAB_VARIANTS = {"CONFIG", "Config"}
local HIDE_NAMES = {
    "Hrisito mode",
    "Hrisito DVD",
    "Old ragebot tab",
    "Old skinchanger tab",
    "Nade icons",
    "Refresh all cosmetics",
    "Apply Hrisito skybox",
    "Remove nade background",
    "Unlock hidden cvars",
    "Remove nade timer",
    "Allow unstable features",
    "Original clantag spammer",
    "Show hidden features",
    "Fix cam_ideadist",
    "Doubletap recharge fix",
    "Safe point",
    "Anti-aim correction"
}

local function each_reference(tab, container, name, fn)
    local refs = {ui.reference(tab, container, name)}
    if #refs == 0 or (refs[1] == nil and #refs == 1) then
        return false
    end
    for _, r in ipairs(refs) do
        if r ~= nil then
            fn(r)
        end
    end
    return true
end

local function hide_item(tab, container, name)
    return each_reference(
        tab,
        container,
        name,
        function(r)
            pcall(ui.set_visible, r, false)
        end
    )
end

local function apply_all()
    for _, tab in ipairs(TAB_VARIANTS) do
        for _, name in ipairs(HIDE_NAMES) do
            hide_item(tab, target_container, name)
        end
        for _, cont in ipairs({"lua"}) do
            hide_item(tab, cont, "allow scripts to open links")
        end
    end
end

ui.set_visible(ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks2"), true)
ui.set(ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks2"), 30)
ui.set(ui.reference("CONFIG", "Presets", "Doubletap recharge fix"), false)
ui.set(ui.reference("CONFIG", "Presets", "Safe point"), "Default")
ui.set(ui.reference("CONFIG", "Presets", "Original clantag spammer"), true)
apply_all()
