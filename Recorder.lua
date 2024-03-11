-- R2 github: https://github.com/cxTACpro/Uncrepted/blob/main/Recorder.lua
-- v0
repeat wait() until game:IsLoaded()
local plr=game:GetService("Players").LocalPlayer
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Wave=plr.PlayerGui:WaitForChild("Interface"):WaitForChild("GameInfoBar"):WaitForChild("Wave"):WaitForChild("WaveText")
local TimeLeft=plr:WaitForChild("Interface"):WaitForChild("GameInfoBar"):WaitForChild("TimeLeft"):WaitForChild("TimeLeftText")
local namecall
local fullstr='repeat wait() until game:IsLoaded()'
fullstr..='\nlocal islobby=(game.PlaceId==9503261072)'
fullstr..='\nlocal isgame=(game.PlaceId==11739766412)'
fullstr..='\nlocal ReplicatedStorage=game:GetService("ReplicatedStorage")'
fullstr..='\nlocal plr=game:GetService("Players").LocalPlayer'
fullstr..='\n\n\n\r\r ###PUT HERE APC JOIN SCRIPT \r\r\n\n\n'
fullstr..='\nif isgame then'
fullstr..='\nlocal WMS=0'
fullstr..='\nspawn(function() WMS=0 TimeLeft:GetPropertyChangedSignal("Text"):Connect(function() for i=0,9 do wait(0.1) WMS=WMS+1 if i==9 then WMS=0 break end end end) end)'
fullstr..='\nlocal TimeLeft=game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Interface"):WaitForChild("GameInfoBar"):WaitForChild("TimeLeft"):WaitForChild("TimeLeftText")'
fullstr..='\nlocal Wave=game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Interface"):WaitForChild("GameInfoBar"):WaitForChild("Wave"):WaitForChild("WaveText")'
fullstr..='\nfunction returnlobby()'
fullstr..='\n    repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.Interface.GameOverScreen.Visible==true'
fullstr..='\n    game:GetService("TeleportService"):Teleport(9503261072)'
fullstr..='\nend'
local WMS=0
function argmentyp(r,args)
    local __ag='('
    if r.Name=="PlaceTower" then
        __ag..=`{args[1]},`
        __ag..=`"{args[2]}",`
        __ag..=string.format("Vector3.new(%s, %s, %s),",args[3].X,args[3].Y,args[3].Z)
        __ag..=`{args[1]},`
    end
    if r.Name=="TowerUpgradeRequest" then
        __ag..=`{args[1]},`
        __ag..=`{args[2]},`
    end
    if r.Name=="RetargetTower" then
        __ag..=`{args[1]},`
    end
    if r.Name=="SellTower" then
        __ag..=`{args[1]},`
    end
    if r.Name=="TowerUseAbilityRequest" then
        __ag..=`{args[1]},`
    end
    if r.Name=="SkipWaveVoteCast" then
        __ag..=`{args[1]},`
    end
    if r.Name=="DifficultyVoteCast" then
        __ag..=`'{args[1]}' ,`
    end
    __ag..=')'
    return __ag
end
function sorts(r,w,tl,wm_,args,mmxdi)
    local call=(mmxdi=="fireserver" and "Remote:FireServer") or (mmxdi=="invokeserver" and "Remote:InvokeServer")
    local arg_=argmentyp(r,args)
    if r.Parent==ReplicatedStorage:WaitForChild("Remotes")then
        print(`local Remote = game.ReplicatedStorage.Remotes:FindFirstChild('{r.Name}');`)
        print(`if Remote then`)
        print(`repeat wait() until Wave.Text=={w} and TimeLeft.Text=={tl} and WMS=={wm_}`)
        print(string.format('%s,%s',call,arg_))
        fullstr..=`local Remote = game.ReplicatedStorage.Remotes:FindFirstChild('{r.Name}');`
        fullstr..=`if Remote then`
        fullstr..=`repeat wait() until Wave.Text=={w} and TimeLeft.Text=={tl} and WMS=={wm_}`
        fullstr..=string.format('%s,%s',call,arg_)
    end
end
spawn(function()
    WMS=0
    TimeLeft:GetPropertyChangedSignal("Text"):Connect(function()
        for i=0,9 do
            wait(0.1)
            WMS=WMS+1
            if i==9 then WMS=0 break end 
        end
    end)
end)
spawn(function()
    repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.Interface.GameOverScreen.Visible==true
    fullstr..='\nreturnlobby()\nend'
    writefile("AutoStratExample.lua",fullstr)
end)
namecall = hookmetamethod(game,"__namecall",function(self,...)
    local args = {...}
    local method = getnamecallmethod():lower()
    if not checkcaller() and args[#args]~="Rec" and self.Parent==ReplicatedStorage:WaitForChild("Remotes") and method == "fireserver" or method == "invokeserver" then
        sorts(r,Wave.Text,TimeLeft.Text,WMS,args,method)
        return namecall(self,unpack(args),"Rec")
    end
    return namecall(self,...)
end)
