--[[
    Parkour
    Sowd likes schemas, please bully him. Proof: https://i.imgur.com/GzrgHnZ.png
    LegoHacks is winning :flushed:
]]

local getupvalue = (getupvalue or debug.getupvalue);
local getmetatable = (debug.getmetatable or getrawmetatable);

repeat wait() until game:IsLoaded();

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LegoHacks/Utilities/main/UI.lua"))();
local players = game:GetService("Players");
local replicatedStorage = game:GetService("ReplicatedStorage");
local client = players.LocalPlayer;
local variables, mainEnv, encrypt;

do
    local banRemotes = {
        ["AttemptTeleport"] = true;
        ["FireToDieInstantly"] = true;
        ["LandWithForceField"] = true;
        ["LoadString"] = true;
        ["FlyRequest"] = true;
        ["FinishTimeTrial"] = true;
        ["Under3Seconds"] = true;
        ["UpdateDunceList"] = true;
        ["HighCombo"] = true;
        ["r"] = true;
        ["t"] = true;
    };
    
    local mt = getmetatable(game);
    local idx = mt.__index;
    local namecall = mt.__namecall;
    
    setreadonly(mt, false);
    
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...};
        local method = getnamecallmethod();
    
        if (method == "FireServer" and banRemotes[self.Name]) then
            return;
        elseif (method == "FireServer" and self.Name == "SubmitCombo" and args[1] > 299) then
            args[1] = math.random(250, 299); --> Hudzell, please suck my cock :)
        end;
    
        return namecall(self, unpack(args));
    end);

    mt.__index = newcclosure(function(self, v)
        if (tostring(v) == "PlaybackLoudness" and getfenv(2).script.Name == "RadioScript" and library.flags.audio_bypass) then
            return 0;
        end;

        return idx(self, v);
    end);
    
    setreadonly(mt, true);

    local function onCharacterAdded()
        wait(1);
        local mainScript = client.Backpack:WaitForChild("Main");
        variables = getupvalue(getsenv(mainScript).hasGauntlet, 1);
        variables.adminLevel = 13;
        getfenv().script = mainScript;
        mainEnv = getsenv(mainScript);
        encrypt = mainEnv.encrypt;
    end;

    if (client.Character) then
        onCharacterAdded();
    end;

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
            while library.flags.god_mode do
                if (client.Character and not client.Character:FindFirstChild("joe")) then --> I know who joe is.
                    local antiFallField = Instance.new("ForceField");
                    antiFallField.Visible = false;
                    antiFallField.Name = "joe";
                    antiFallField.Parent = client.Character;
                end;
                wait();
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

library:Init();
