local a={}local b=Game()local c=SFXManager()local function d()local e=b:GetRoom()local f=Isaac.WorldToScreen(Vector(0,0))-e:GetRenderScrollOffset()-b.ScreenShakeOffset;local g=f.X+60*26/40;local h=f.Y+140*26/40;return g*2+13*26,h*2+7*26 end;local i=Sprite()local j={["Appear"]=33,["Shake"]=36,["ShakeFire"]=32,["Flip"]=33}local k={[0]=Color(1,1,1,1,0,0,0),[1]=Color(1,1,1,1,0,0,0),[2]=Color(1,1,1,1,0,0,0),[3]=Color(1,1,1,1,0,0,0),[4]=Color(1,1,1,1,0,0,0),[5]=Color(1,1,1,1,0,0,0)}local l=0;local m=false;local function n()Isaac.GetPlayer(0):UseCard(Card.RUNE_BERKANO,UseFlag.USE_NOANIM|UseFlag.USE_NOANNOUNCER)for o,p in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.BLUE_FLY,-1,false,false))do if p:Exists()and p.FrameCount<=0 then p:Remove()end end;for o,q in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR,FamiliarVariant.BLUE_SPIDER,-1,false,false))do if q:Exists()and q.FrameCount<=0 then q:Remove()end end end;function a:PlayGiantBook(r,s,t,u,v,w,x)i:Load("gfx/ui/giantbook/giantbook.anm2",true)i:ReplaceSpritesheet(0,"gfx/ui/giantbook/"..s)i:LoadGraphics()i:Play(r,true)l=j[r]k[1]=u;k[2]=t;k[3]=t;k[4]=v;m=true;if not x then n()if w then c:Play(w,0.8,0,false,1)end end end;function a:BookRender()if l>0 then if Isaac.GetFrameCount()%2==0 then i:Update()l=l-1 end;for y=5,0,-1 do i.Color=k[y]local z,A=d()local B=Vector(z/2,A/2)i:RenderLayer(y,B,Vector(0,0),Vector(0,0))end end;if l==0 and m then m=false end end;function a:UseBerkano()if not m then a:PlayGiantBook("Appear","gbookapi_berkano.png",Color(0.2,0.1,0.3,1,0,0,0),Color(0.117,0.0117,0.2,1,0,0,0),Color(0,0,0,0.8,0,0,0),nil,true)end end;local C={}local D=Sprite()local E=0;local F=false;function a:PaperRender()if E<=0 then if F then for y=1,#C-1 do C[y]=C[y+1]end;C[#C]=nil;F=false end;if not F and#C>0 then D:Load("gfx/ui/achievements/achievement.anm2",true)D:ReplaceSpritesheet(2,"gfx/ui/achievements/"..C[1])D:LoadGraphics()D:Play("Idle",true)E=41;F=true;m=true;n()end else if Isaac.GetFrameCount()%2==0 then D:Update()E=E-1 end;for y=0,3,1 do local z,A=d()local B=Vector(z/2,A/2)D:RenderLayer(y,B,Vector(0,0),Vector(0,0))end end;if D:IsEventTriggered("paperIn")then c:Play(SoundEffect.SOUND_PAPER_IN,1,0,false,1)end;if D:IsEventTriggered("paperOut")then c:Play(SoundEffect.SOUND_PAPER_OUT,1,0,false,1)end end;function a:ShowAchievement(G)table.insert(C,#C+1,G)end;local H=Sprite()local I=0;function a:PlayCustomGiantAnimation(J,r,w,x)H:Load("gfx/ui/giantbook/"..J,true)H:LoadGraphics()H:Play(r,true)I=32;m=true;if not x then n()if w then c:Play(w,0.8,0,false,1)end end end;function a:CustomRender()if I>0 then if Isaac.GetFrameCount()%2==0 then H:Update()I=I-1 end;local z,A=d()local B=Vector(z/2,A/2)H:Render(B,Vector(0,0),Vector(0,0))end end;function a:Init(K)K:AddCallback(ModCallbacks.MC_POST_RENDER,a.CustomRender)K:AddCallback(ModCallbacks.MC_POST_RENDER,a.PaperRender)K:AddCallback(ModCallbacks.MC_POST_RENDER,a.BookRender)K:AddCallback(ModCallbacks.MC_USE_CARD,a.UseBerkano,Card.RUNE_BERKANO)end;return a