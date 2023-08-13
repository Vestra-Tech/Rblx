local Esp = {
    Switches = {
        Master = false,
        Boxes = false,
        HealthBars = false,
        Tracers = false,
        Distance = false,
        Name = false,
        LookLine = false,
        Skeleton = false,
        HeadDot = false,
    },
    Thickness = {
        Boxes = 1,
        BoxesOutline = 3,
        HealthBars = 1,
        HealthBarsOutline = 3,
        Tracers = 1,
        TracersOutline = 3,
        LookLine = 1,
        LookLineOutline = 3,
        Skeleton = 1,
        SkeletonOutline = 3,
        HeadDot = 1,
        HeadDotOutline = 3,
    },
    Outline = {
        Boxes = true,
        HealthBars = true,
        Tracers = true,
        Distance = true,
        Name = true,
        LookLine = true,
        Skeleton = true,
        HeadDot = true,  
    },
    Size = {
        Distance = 15,
        Name = 15,  
        HeadDot = 10,
    },
    Filled = {
        HeadDot = true,
    },
    Position = {
        TracerFrom = "Top",     -- Top,Bottom,Mouse
        TracerTo = "Head",      -- Head,Root,
    },
    Colour = {
        Enemy = Color3.fromRGB(255,0,0),
        Team = Color3.fromRGB(0,0,255),
        Misc = Color3.fromRGB(255,255,255),
        OutLine = Color3.fromRGB(1,1,1),
        Full = Color3.fromRGB(0,255,0),
        Empty = Color3.fromRGB(255,0,0),
    },
    Settings = {
        MaxDistance = 1000,
        TeamCheck = false,
        CustomCharacters = false,
    },
    Parts = {
        LeftFoot = "LeftFoot",
        RightFoot = "RightFoot",
        LeftHand = "LeftHand",
        RightHand = "RightHand",
        Root = "HumanoidRootPart",
        Head = "Head",
    },
    locals = {
        Player = game.Players,
        LocalPlayer = game.Players.LocalPlayer,
        Camera = workspace.CurrentCamera,
        RunService = game.GetService,
        CoreGui = game.CoreGui,
    },
    OffSets = {
        Head = Vector3.new(0,0.5,0),
        Leg = Vector3.new(0,3,0),
    },
    Utility = {},
    Players = {},
    Misc = {},
}
function Esp.Utility:IsAlive(plr)
    if plr.Character and plr.Character:FindFirstChild("Head") then
        return true
    end
    return false
end
function Esp.Utility:Round(number)
    return math.floor(number + 0.5)
end
function Esp.Utility:GetTeam(plr)
    return plr.Team
end
function Esp.Utility:GetHealth(plr)
    return plr.Character.Humanoid.Health, plr.Character.Humanoid.MaxHealth
end
function Esp.Utility:Square()
    local Square = Drawing.new("Square")
    Square.Color = Color3.fromRGB(255,255,255)
    Square.Thickness = 1
    Square.Filled = false
    return Square
end
function Esp.Utility:Line()
    local Line = Drawing.new("Line")
    Line.Color = Color3.fromRGB(255,255,255)
    Line.Thickness = 1
    return Line
end
function Esp.Utility:Text()
    local Text = Drawing.new("Text")
    Text.Color = Color3.fromRGB(255,255,255)
    Text.Outline = true
    Text.Center = true
    Text.Size = 10
    return Text
end
function Esp.Utility:Circle()
    local Circle = Drawing.new("Circle")
    Circle.Thickness = 1
    Circle.NumSides = 360
    Circle.Radius = 100
    Circle.Filled = false
    return Circle
end
function Esp.Utility:Triangle()
    local Triangle = Drawing.new("Triangle")
    Triangle.Filled = false
    Triangle.Thickness = 1
    return Circle
end
function Esp.Utility:Draw(plr)
    local InnerBox = Esp.Utility:Square()
    local OuterBox = Esp.Utility:Square()
    local CornerTopLeft = Esp.Utility:Line()
    local CornerTopRight = Esp.Utility:Line()
    local CornerBottomLeft = Esp.Utility:Line()
    local CornerBottomRight = Esp.Utility:Line()
    local CornerTopLeftOutline = Esp.Utility:Line()
    local CornerTopRightOutline = Esp.Utility:Line()
    local CornerBottomLeftOutline = Esp.Utility:Line()
    local CornerBottomRightOutline = Esp.Utility:Line()
    local HealthBar = Esp.Utility:Square()
    local HealthBarOutline = Esp.Utility:Square()
    local InnerTracer = Esp.Utility:Line()
    local OuterTracer = Esp.Utility:Line()
    local Distance = Esp.Utility:Text()
    local Names = Esp.Utility:Text()
    local Health = Esp.Utility:Text()
    local InnerLookLine = Esp.Utility:Line()
    local OuterLookLine = Esp.Utility:Line()
    local SkeletonLeftLeg = Esp.Utility:Line()
    local SkeletonRightLeg = Esp.Utility:Line()
    local SkeletonLeftArm = Esp.Utility:Line()
    local SkeletonRightArm = Esp.Utility:Line()
    local SkeletonHead = Esp.Utility:Line()
    local SkeletonLeftLegOutline = Esp.Utility:Line()
    local SkeletonRightLegOutline = Esp.Utility:Line()
    local SkeletonLeftArmOutline = Esp.Utility:Line()
    local SkeletonRightArmOutline = Esp.Utility:Line()
    local SkeletonHeadOutline = Esp.Utility:Line()
    local HeadDotInner = Esp.Utility:Circle()
    local HeadDotOuter = Esp.Utility:Circle()
    local connections = game:GetService("RunService").Stepped:Connect(function()
        if Esp.Switches.Master and Esp.Utility:IsAlive(plr) and plr.Character:FindFirstChild("Head") and plr.Character:WaitForChild("Humanoid") 
        and plr ~= Esp.locals.LocalPlayer and Esp.locals.LocalPlayer.Character:WaitForChild("Head") 
        and Esp.Utility:Round((Esp.locals.LocalPlayer.Character.Head.Position - plr.Character.Head.Position).Magnitude) <= Esp.Settings.MaxDistance 
        and plr.Character.Humanoid.Health > 0 then
    if not Esp.Settings.CustomCharacters then
        if plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Esp.Parts.LeftHand = "Left Arm"
            Esp.Parts.RightHand = "Right Arm"
            Esp.Parts.LeftFoot = "Left Leg"
            Esp.Parts.RightFoot = "Right Leg"
        else
            Esp.Parts.LeftHand = "LeftHand"
            Esp.Parts.RightHand = "RightHand"
            Esp.Parts.LeftFoot = "LeftFoot"
            Esp.Parts.RightFoot = "RightFoot"
        end
    end
        local LeftFoot = plr.Character:WaitForChild(Esp.Parts.LeftFoot)
        local RightFoot = plr.Character:WaitForChild(Esp.Parts.RightFoot)
        local LeftHand = plr.Character:WaitForChild(Esp.Parts.LeftHand)
        local RightHand = plr.Character:WaitForChild(Esp.Parts.RightHand)
        local Root = plr.Character:WaitForChild(Esp.Parts.Root)
        local Head = plr.Character:WaitForChild(Esp.Parts.Head)
        local RootPos,OnScreen = Esp.locals.Camera:worldToViewportPoint(Root.Position)
        local HeadPos = Esp.locals.Camera:worldToViewportPoint(Head.Position + Esp.OffSets.Head)
        local LeftFootPos =Esp.locals.Camera:worldToViewportPoint(LeftFoot.Position)
        local RightFootPos =Esp.locals.Camera:worldToViewportPoint(RightFoot.Position)
        local LeftHandPos =Esp.locals.Camera:worldToViewportPoint(LeftHand.Position)
        local RightHandPos =Esp.locals.Camera:worldToViewportPoint(RightHand.Position)
        local RayHitPosition, HitPosition = workspace:FindPartOnRayWithIgnoreList(Ray.new(plr.Character.Head.Position,plr.Character.Head.CFrame.LookVector*5,1,-1),{Esp.locals.Camera,plr.Character},false,true,"")
        local hitpoint = Esp.locals.Camera:worldToViewportPoint(HitPosition)
        -- Got sent code for BoundingBox as i had a shit static size box
        local BoxOrintation, BoxSize = Head.Parent:GetBoundingBox()
        local Width = (workspace.CurrentCamera.CFrame-workspace.CurrentCamera.CFrame.p)*Vector3.new((math.clamp(BoxSize.X,1,10)+0.5)/2,0,0)
        local Height = (workspace.CurrentCamera.CFrame-workspace.CurrentCamera.CFrame.p)*Vector3.new(0,(math.clamp(BoxSize.X,1,10)+2)/2,0)
        Width = math.abs(workspace.CurrentCamera:WorldToViewportPoint(BoxOrintation.Position+Width).X-workspace.CurrentCamera:WorldToViewportPoint(BoxOrintation.Position-Width).X)
        Height = math.abs(workspace.CurrentCamera:WorldToViewportPoint(BoxOrintation.Position+Height).Y-workspace.CurrentCamera:WorldToViewportPoint(BoxOrintation.Position-Height).Y)
        local Size = Vector2.new(math.floor(Width), math.floor(Height))       
        local CurrentHealth,MaxHealth = Esp.Utility:GetHealth(plr)
        if Esp.Settings.TeamCheck and Esp.Utility:GetTeam(plr) == game.Players.LocalPlayer.Team then
            CanShow = false
        else
            CanShow = true
        end
        if Esp.Switches.Boxes and OnScreen then
            InnerBox.Visible = CanShow
            OuterBox.Visible = Esp.Outline.Boxes and CanShow
            InnerBox.Size = Size
            OuterBox.Size = Size
            InnerBox.Position = Vector2.new(math.floor(RootPos.X), math.floor(RootPos.Y)) - (InnerBox.Size / 2)
            OuterBox.Position = Vector2.new(math.floor(RootPos.X), math.floor(RootPos.Y)) - (OuterBox.Size / 2)
            InnerBox.Thickness = Esp.Thickness.Boxes
            OuterBox.Thickness = Esp.Thickness.BoxesOutline
            InnerBox.ZIndex = 2
            OuterBox.ZIndex = 1
        else
            InnerBox.Visible = false
            OuterBox.Visible = false          
        end 
        if Esp.Switches.HealthBars and OnScreen then
            HealthBar.Visible = CanShow
            HealthBarOutline.Visible = Esp.Outline.HealthBars and CanShow
            HealthBar.Thickness = Esp.Thickness.HealthBars
            HealthBarOutline.Thickness = Esp.Thickness.HealthBarsOutline
            HealthBar.Color = Esp.Colour.Full
            HealthBarOutline.Color = Esp.Colour.OutLine
            HealthBar.ZIndex = 4
            HealthBarOutline.ZIndex = 3
            HealthBar.Filled = CanShow
            HealthBar.Position = Vector2.new(math.floor(RootPos.X) - 6, math.floor(RootPos.Y) + (Size.Y - math.floor(HealthBar.Size.Y))) - Size / 2
            HealthBarOutline.Position = Vector2.new(math.floor(RootPos.X) - 7, math.floor(RootPos.Y) - 1) - Size / 2   
            HealthBar.Size = Vector2.new(2, Size.Y * (1-((100 - CurrentHealth) / MaxHealth)))
            HealthBarOutline.Size = Vector2.new(4, Size.Y + 2)
        else
            HealthBar.Visible = false
            HealthBarOutline.Visible = false
        end
        if Esp.Switches.Tracers and OnScreen then
            InnerTracer.Visible = CanShow
            OuterTracer.Visible = Esp.Outline.Tracers and CanShow
            InnerTracer.ZIndex = 6
            OuterTracer.ZIndex = 5  
            InnerTracer.Thickness = Esp.Thickness.Tracers
            OuterTracer.Thickness = Esp.Thickness.TracersOutline
            if Esp.Position.TracerFrom == "Top" then
                InnerTracer.From = Vector2.new(Esp.locals.Camera.ViewportSize.X / 2, 0)
                OuterTracer.From = Vector2.new(Esp.locals.Camera.ViewportSize.X / 2, 0)
            elseif Esp.Position.TracerFrom == "Bottom" then
                InnerTracer.From = Vector2.new(Esp.locals.Camera.ViewportSize.X / 2, 1000)
                OuterTracer.From = Vector2.new(Esp.locals.Camera.ViewportSize.X / 2, 1000)
            elseif Esp.Position.TracerFrom == "Mouse" then
                InnerTracer.From = game.UserInputService:GetMouseLocation()
                OuterTracer.From = game.UserInputService:GetMouseLocation()
            end
            if Esp.Position.TracerTo == "Head" then
                InnerTracer.To = Vector2.new(HeadPos.X,HeadPos.Y)
                OuterTracer.To = Vector2.new(HeadPos.X,HeadPos.Y)
            elseif Esp.Position.TracerTo == "Root" then
                InnerTracer.To = Vector2.new(RootPos.X,RootPos.Y)
                OuterTracer.To = Vector2.new(RootPos.X,RootPos.Y)
            end
        else
            InnerTracer.Visible = false
            OuterTracer.Visible = false
        end
        if Esp.Switches.Name and OnScreen then
            Names.Visible = CanShow
            Names.Center = true
            Names.Outline = Esp.Outline.Name
            Names.Text = plr.Name
            Names.Size = Esp.Size.Name
            Names.Font = Drawing.Fonts["UI"]
            Names.Position = Vector2.new(math.floor(RootPos.X), math.floor(RootPos.Y) - Size.Y / 2 - 16)
        else
            Names.Visible = false
        end
        if Esp.Switches.Distance and OnScreen then
            Distance.Visible = CanShow
            Distance.Center = true
            Distance.Outline = Esp.Outline.Distance
            Distance.Text = "".. tostring(Esp.Utility:Round((Esp.locals.LocalPlayer.Character.Head.Position - plr.Character.Head.Position).Magnitude)) .." Studs"
            Distance.Size = Esp.Size.Distance
            Distance.Font = Drawing.Fonts["UI"]
            Distance.Position = Vector2.new(math.floor(RootPos.X), math.floor(RootPos.Y) - Size.Y / 20)
        else
            Distance.Visible = false
        end
        if Esp.Switches.LookLine and OnScreen then
            InnerLookLine.Visible = CanShow
            OuterLookLine.Visible = Esp.Outline.LookLine and CanShow
            InnerLookLine.ZIndex = 8
            OuterLookLine.ZIndex = 7
            InnerLookLine.Thickness = Esp.Thickness.LookLine
            OuterLookLine.Thickness = Esp.Thickness.LookLineOutline
            InnerLookLine.To = Vector2.new(hitpoint.X,hitpoint.Y)
            OuterLookLine.To = Vector2.new(hitpoint.X,hitpoint.Y)
            OuterLookLine.From = Vector2.new(HeadPos.X,HeadPos.Y)
            InnerLookLine.From = Vector2.new(HeadPos.X,HeadPos.Y)
        else
            InnerLookLine.Visible = false
            OuterLookLine.Visible = false
        end
        if Esp.Switches.Skeleton and OnScreen then
            SkeletonLeftLeg.Visible = CanShow
            SkeletonRightLeg.Visible = CanShow
            SkeletonLeftArm.Visible = CanShow
            SkeletonRightArm.Visible = CanShow
            SkeletonHead.Visible = CanShow
            SkeletonLeftLegOutline.Visible = Esp.Outline.Skeleton and CanShow 
            SkeletonRightLegOutline.Visible = Esp.Outline.Skeleton and CanShow
            SkeletonLeftArmOutline.Visible = Esp.Outline.Skeleton and CanShow
            SkeletonRightArmOutline.Visible = Esp.Outline.Skeleton and CanShow 
            SkeletonHeadOutline.Visible = Esp.Outline.Skeleton and CanShow
            SkeletonLeftLeg.ZIndex = 12
            SkeletonRightLeg.ZIndex = 14
            SkeletonLeftArm.ZIndex = 16
            SkeletonRightArm.ZIndex = 18
            SkeletonHead.ZIndex = 10
            SkeletonLeftLegOutline.ZIndex = 11
            SkeletonRightLegOutline.ZIndex = 13
            SkeletonLeftArmOutline.ZIndex = 14
            SkeletonRightArmOutline.ZIndex = 17
            SkeletonHeadOutline.ZIndex = 9
            SkeletonLeftLeg.Thickness = Esp.Thickness.Skeleton
            SkeletonRightLeg.Thickness = Esp.Thickness.Skeleton
            SkeletonLeftArm.Thickness = Esp.Thickness.Skeleton
            SkeletonRightArm.Thickness = Esp.Thickness.Skeleton
            SkeletonHead.Thickness = Esp.Thickness.Skeleton
            SkeletonLeftLegOutline.Thickness = Esp.Thickness.SkeletonOutline
            SkeletonRightLegOutline.Thickness = Esp.Thickness.SkeletonOutline
            SkeletonLeftArmOutline.Thickness = Esp.Thickness.SkeletonOutline
            SkeletonRightArmOutline.Thickness = Esp.Thickness.SkeletonOutline
            SkeletonHeadOutline.Thickness = Esp.Thickness.SkeletonOutline
            SkeletonLeftLeg.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonLeftLeg.To = Vector2.new(LeftFootPos.X,LeftFootPos.Y)
            SkeletonRightLeg.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonRightLeg.To = Vector2.new(RightFootPos.X,RightFootPos.Y)
            SkeletonLeftArm.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonLeftArm.To = Vector2.new(LeftHandPos.X,LeftHandPos.Y)
            SkeletonRightArm.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonRightArm.To = Vector2.new(RightHandPos.X,RightHandPos.Y)
            SkeletonHead.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonHead.To = Vector2.new(HeadPos.X,HeadPos.Y)
            SkeletonLeftLegOutline.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonLeftLegOutline.To = Vector2.new(LeftFootPos.X,LeftFootPos.Y)
            SkeletonRightLegOutline.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonRightLegOutline.To = Vector2.new(RightFootPos.X,RightFootPos.Y)
            SkeletonLeftArmOutline.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonLeftArmOutline.To = Vector2.new(LeftHandPos.X,LeftHandPos.Y)
            SkeletonRightArmOutline.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonRightArmOutline.To = Vector2.new(RightHandPos.X,RightHandPos.Y)
            SkeletonHeadOutline.From = Vector2.new(RootPos.X,RootPos.Y)
            SkeletonHeadOutline.To = Vector2.new(HeadPos.X,HeadPos.Y)
        else
            SkeletonLeftLeg.Visible = false
            SkeletonRightLeg.Visible = false
            SkeletonLeftArm.Visible = false
            SkeletonRightArm.Visible = false
            SkeletonHead.Visible = false
            SkeletonLeftLegOutline.Visible = false
            SkeletonRightLegOutline.Visible = false
            SkeletonLeftArmOutline.Visible = false
            SkeletonRightArmOutline.Visible = false
            SkeletonHeadOutline.Visible = false
        end 
        if Esp.Switches.HeadDot and OnScreen then
            HeadDotInner.Visible = CanShow
            HeadDotOuter.Visible = Esp.Outline.HeadDot and CanShow
            HeadDotInner.Thickness = Esp.Thickness.HeadDot
            HeadDotOuter.Thickness = Esp.Thickness.HeadDotOutline
            HeadDotInner.Filled = Esp.Filled.HeadDot
            HeadDotInner.Position = Vector2.new(HeadPos.X,HeadPos.Y)
            HeadDotOuter.Position = Vector2.new(HeadPos.X,HeadPos.Y)
            HeadDotInner.Radius = Esp.Size.HeadDot
            HeadDotOuter.Radius = Esp.Size.HeadDot
        else
            HeadDotInner.Visible = false
            HeadDotOuter.Visible = false
        end    
        if Esp.locals.LocalPlayer.TeamColor ~= plr.TeamColor then
            InnerBox.Color = Esp.Colour.Enemy
            OuterBox.Color = Esp.Colour.OutLine
            InnerTracer.Color = Esp.Colour.Enemy
            OuterTracer.Color = Esp.Colour.OutLine
            Names.Color = Esp.Colour.Enemy
            Distance.Color = Esp.Colour.Enemy
            InnerLookLine.Color = Esp.Colour.Enemy
            OuterLookLine.Color = Esp.Colour.OutLine
            SkeletonLeftLeg.Color = Esp.Colour.Enemy
            SkeletonRightLeg.Color = Esp.Colour.Enemy
            SkeletonLeftArm.Color = Esp.Colour.Enemy
            SkeletonRightArm.Color = Esp.Colour.Enemy
            SkeletonHead.Color = Esp.Colour.Enemy
            SkeletonLeftLegOutline.Color = Esp.Colour.OutLine
            SkeletonRightLegOutline.Color = Esp.Colour.OutLine
            SkeletonLeftArmOutline.Color = Esp.Colour.OutLine
            SkeletonRightArmOutline.Color = Esp.Colour.OutLine
            SkeletonHeadOutline.Color = Esp.Colour.OutLine      
            HeadDotInner.Color = Esp.Colour.Enemy
            HeadDotOuter.Color = Esp.Colour.OutLine  
        else
            InnerBox.Color = Esp.Colour.Team
            OuterBox.Color = Esp.Colour.OutLine
            InnerTracer.Color = Esp.Colour.Team
            OuterTracer.Color = Esp.Colour.OutLine
            Names.Color = Esp.Colour.Team
            Distance.Color = Esp.Colour.Team
            InnerLookLine.Color = Esp.Colour.Team
            OuterLookLine.Color = Esp.Colour.OutLine
            SkeletonLeftLeg.Color = Esp.Colour.Team
            SkeletonRightLeg.Color = Esp.Colour.Team
            SkeletonLeftArm.Color = Esp.Colour.Team
            SkeletonRightArm.Color = Esp.Colour.Team
            SkeletonHead.Color = Esp.Colour.Team
            SkeletonLeftLegOutline.Color = Esp.Colour.OutLine
            SkeletonRightLegOutline.Color = Esp.Colour.OutLine
            SkeletonLeftArmOutline.Color = Esp.Colour.OutLine
            SkeletonRightArmOutline.Color = Esp.Colour.OutLine
            SkeletonHeadOutline.Color = Esp.Colour.OutLine   
            HeadDotInner.Color = Esp.Colour.Team
            HeadDotOuter.Color = Esp.Colour.OutLine    
        end
        else
            InnerBox.Visible = false
            OuterBox.Visible = false
            HealthBar.Visible = false
            HealthBarOutline.Visible = false
            InnerTracer.Visible = false
            OuterTracer.Visible = false
            Names.Visible = false
            Distance.Visible = false
            InnerLookLine.Visible = false
            OuterLookLine.Visible = false
            SkeletonLeftLeg.Visible = false
            SkeletonRightLeg.Visible = false
            SkeletonLeftArm.Visible = false
            SkeletonRightArm.Visible = false
            SkeletonHead.Visible = false
            SkeletonLeftLegOutline.Visible = false
            SkeletonRightLegOutline.Visible = false
            SkeletonLeftArmOutline.Visible = false
            SkeletonRightArmOutline.Visible = false
            SkeletonHeadOutline.Visible = false   
            HeadDotInner.Visible = false
            HeadDotOuter.Visible = false
        end
    end)
    return connections
end
for i,v in pairs(game.Players:GetPlayers()) do
    Esp.Players[v.Name] = Esp.Utility:Draw(v)
end
game.Players.PlayerAdded:Connect(function(plr)
    Esp.Players[plr.Name] = Esp.Utility:Draw(plr)
end)
game.Players.PlayerRemoving:Connect(function(v)
   if table.find(Esp.Players, v.Name) then
       Esp.Players[v.Name]:Disable()
       table.remove(Esp.Players, v.Name)
   end
end)
return Esp
