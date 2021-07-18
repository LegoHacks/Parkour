--[[
    Parkour
    Sowd likes schemas, please bully him. Proof: https://i.imgur.com/GzrgHnZ.png
    LegoHacks is winning :flushed:
]]

local getupvalue = (getupvalue or debug.getupvalue);
local getmetatable = (debug.getmetatable or getrawmetatable);
local hookmetamethod = hookmetamethod or function(tbl, mt, func) return hookfunction(getrawmetatable(tbl)[mt], func) end;

repeat wait() until game:IsLoaded();

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LegoHacks/Utilities/main/UI.lua"))();
local players = game:GetService("Players");
local replicatedStorage = game:GetService("ReplicatedStorage");
local client = players.LocalPlayer;
local variables, mainEnv, encrypt;

do
    local banRemotes = {
        "AttemptTeleport";
        "FireToDieInstantly";
        "LandWithForceField";
        "LoadString";
        "FlyRequest";
        "FinishTimeTrial";
        "Under3Seconds";
        "UpdateDunceList";
        "HighCombo";
        "r";
        "t";
        "FF";
    };

    if (typeof(syn) == "table" and syn.run_secure_lua) then
        -- Jfc fix getfenv you cunt
        local fenv;
        fenv = hookfunction(getfenv, newcclosure(function(level)
            if (level == 2) then
                return {
                    script = client.Backpack:FindFirstChild("Main");
                };
            end;
    
            return fenv(level);
        end));
    end;

    local nc;
    nc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local args = {...};
        local method = getnamecallmethod();
    
        if (method == "FireServer" and table.find(banRemotes, self.Name)) then
            return wait(10e16);
        elseif (method == "FireServer" and self.Name == "SubmitCombo" and args[1] > 299) then
            args[1] = math.random(250, 299); --> Hudzell, please suck my cock :)
        end;
    
        return nc(self, unpack(args));
    end));

    local idx;
    idx = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if (key == "PlaybackLoudness" and getfenv(2).script.Name == "RadioScript" and library.flags.audio_bypass) then
            return 0;
        end;

        return idx(self, key);
    end));

    local function onCharacterAdded(char)
        if (not char) then return end;
        wait(1);
        local mainScript = client.Backpack:WaitForChild("Main");
        variables = getupvalue(getsenv(mainScript).charJump, 1);
        variables.adminLevel = 13;
        getfenv().script = mainScript;
        mainEnv = getsenv(mainScript);
        encrypt = mainEnv.encrypt;

        if (library.flags.god_mode) then
            local antiFallField = Instance.new("ForceField");
            antiFallField.Visible = false;
            antiFallField.Name = "joe";
            antiFallField.Parent = char;
        end;
    end;

    onCharacterAdded(client.Character);
    client.CharacterAdded:Connect(onCharacterAdded);
end;

local moves = {
    "slide";
    "dropdown";
    "ledgegrab";
    "edgejump";
    "longjump";
    "vault";
    "wallrun";
    "springboard";
};

local parkour = library:CreateWindow("Parkour");
parkour:AddToggle({
    text = "Auto Farm";
    flag = "auto_farm";
    callback = function(enabled)
        if (not enabled) then return end;

        while library.flags.auto_farm do
            if (client.Backpack and client.Backpack:FindFirstChild("Main") and client.PlayerScripts:FindFirstChild("Points") and getsenv(client.Backpack.Main)) then
                local pointsEnv = getsenv(client.PlayerScripts.Points);
                pointsEnv.changeParkourRemoteParent(workspace);

                local scoreRemote = getupvalue(pointsEnv.changeParkourRemoteParent, 2);

                scoreRemote:FireServer(encrypt("walljump"), {
                    [encrypt("walljumpDelta")] = encrypt(tostring(math.random(2.02, 3.55)));
                    [encrypt("combo")] = encrypt(tostring(math.random(4, 5)));
                });

                wait(0.4);

                scoreRemote:FireServer(encrypt(moves[math.random(1, #moves)]), {
                    [encrypt("combo")] = encrypt(tostring(1));
                });

                wait(math.random(1.25, 1.35));
            end;
            wait();
        end;
    end;
});

parkour:AddToggle({
    text = "No Fall Damage";
    flag = "god_mode";
    callback = function(enabled)
        if (enabled) then
            if (client.Character and not client.Character:FindFirstChild("joe")) then --> I know who joe is.
                local antiFallField = Instance.new("ForceField");
                antiFallField.Visible = false;
                antiFallField.Name = "joe";
                antiFallField.Parent = client.Character;
            end;
        elseif (client.Character and client.Character:FindFirstChild("joe")) then
            client.Character.joe:Destroy();
        end;
    end;
});

parkour:AddToggle({
    text = "Maxed Combo";
    flag = "maxed_combo";
    callback = function(enabled)
        if (not enabled) then
            return mainEnv.breakCombo();
        end;

        replicatedStorage.UpdateCombo:FireServer(5);

        while library.flags.maxed_combo do
            variables.comboTime = math.huge
            variables.comboHealth = math.huge;
            variables.comboXp = math.huge;
            variables.comboLevel = 5;
            wait();
        end;
    end;
});

parkour:AddToggle({
    text = "Always Flow";
    flag = "always_flow";
    callback = function(enabled)
        if (not enabled) then return end;

        while library.flags.always_flow do
            variables.flowActive = true;
            variables.flowDelta = 100;
            wait();
        end;
    end;
});

parkour:AddToggle({
    text = "Audio Bypass";
    flag = "audio_bypass";
})

parkour:AddToggle({
    text = "No Cola Cooldown";
    flag = "fast_cola";
    callback = function(enabled)
        if (not enabled) then return end;

        while library.flags.fast_cola do
            variables.drinkingCola = false;
            wait();
        end;
    end;
});

parkour:AddToggle({
    text = "Free Tricks Pass";
    flag = "tricks_pass";
    callback = function(enabled)
        if (not enabled) then return end;

        while library.flags.fast_cola do
            variables.hasTricksPass = false;
            wait();
        end;
    end;
});

parkour:AddToggle({
    text = "Ear Rape";
    flag = "ear_rape";
    callback = function(enabled)
        if (not enabled) then return end;

        while library.flags.ear_rape do
            replicatedStorage.PlayCharacterSound:FireServer("DoorBust");
            wait();
        end;
    end;
});

parkour:AddToggle({
    text = "Slide Speed";
    flag = "slide_speed_enabled";
    callback = function(enabled)
        if (not enabled) then return end;

        while library.flags.slide_speed_enabled do
            variables.slidespeed = (library.flags.slide_speed or 0);
            wait();
        end;
    end;
});

parkour:AddSlider({
    text = "Slide Speed";
    flag = "slide_speed";
    min = 0;
    max = 1000;
});

parkour:AddToggle({
    text = "Halloween";
    flag = "halloween";
    callback = function(enabled)
        replicatedStorage.IsHalloween.Value = enabled;
    end;
});

parkour:AddButton({
    text = "Unlock All Badges";
    callback = function()
        for i, v in next, workspace:GetChildren() do
            if (v.Name ~= "BadgeAwarder" or not client.Character) then continue end;
        
            local part = v:FindFirstChildWhichIsA("Part");
            firetouchinterest(client.Character.HumanoidRootPart, part, 1);
            firetouchinterest(client.Character.HumanoidRootPart, part, 0);
        end;
    end;
});

parkour:AddButton({
    text = "Discover all Spawns";
    callback = function()
        for i, v in next, workspace:GetChildren() do
            if (not v:IsA("SpawnLocation") or v.Name == "SpawnLocation" or not client.Character) then continue end;
            
            client.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0);
            wait(0.5);
        end;
    end;
});

library:Init();
