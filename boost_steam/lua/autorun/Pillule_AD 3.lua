local commandCooldown = {} -- Tableau pour stocker le temps de recharge de chaque joueur
local duration = 900 -- Durée en secondes (ici 900 secondes = 15 minutes)

local function GiveHealthAndSpeed(ply, healthIncrease, speedIncrease)
    if commandCooldown[ply:SteamID()] and commandCooldown[ply:SteamID()] > os.time() then
        -- Le joueur est en temps de recharge, donc la commande ne peut pas être utilisée
        ply:ChatPrint("La commande est en cours de recharge.")
        return
    end

    -- Obtient les statistiques de base du joueur
    local baseHealth = ply:GetMaxHealth()
    local baseRunSpeed = ply:GetRunSpeed()

    -- Ajoute les augmentations au joueur
    ply:SetHealth(ply:Health() + healthIncrease)
    ply:SetRunSpeed(ply:GetRunSpeed() + speedIncrease)

    commandCooldown[ply:SteamID()] = os.time() + 3600 -- Définit le temps de recharge à "duration" secondes
    ply:ChatPrint("Tu as reçu un bonus de santé et de vitesse pour 15 minutes !")

    timer.Simple(duration, function()
        -- Remet les paramètres de santé et de vitesse du joueur à leur état initial après la durée spécifiée
        if IsValid(ply) then
            ply:SetHealth(ply:Health() - healthIncrease)
            ply:SetRunSpeed(ply:GetRunSpeed() - speedIncrease)
        end
    end)

    -- Utilise ici une fonction pour enregistrer ou enregistrer le temps de recharge du joueur dans une base de données si tu le souhaites
end

local function CommandPillule(ply)
    -- Code pour la commande !pillule
    local healthIncrease = math.floor(ply:GetMaxHealth() * 0.25)
    local speedIncrease = math.floor(ply:GetRunSpeed() * 0.25)
    GiveHealthAndSpeed(ply, healthIncrease, speedIncrease)
end

local function CommandGekki(ply)
    -- Code pour la commande !gekki
    local healthIncrease = math.floor(ply:GetMaxHealth() * 0.5)
    local speedIncrease = math.floor(ply:GetRunSpeed() * 0.5)
    GiveHealthAndSpeed(ply, healthIncrease, speedIncrease)
end

local function CommandSang(ply)
    -- Code pour la commande !sang
    local healthIncrease = math.floor(ply:GetMaxHealth() * 0.10)
    local speedIncrease = math.floor(ply:GetRunSpeed() * 0.75)
    GiveHealthAndSpeed(ply, healthIncrease, speedIncrease)
end

hook.Add("PlayerSay", "MyAddonCommand", function(ply, text)
    if text == "!pillule" then
        CommandPillule(ply)
    elseif text == "!gekki" then
        CommandGekki(ply)
    elseif text == "!sang" then
        CommandSang(ply)
    end
end)