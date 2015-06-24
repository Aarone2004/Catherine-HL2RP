--[[
< CATHERINE > - A free role-playing framework for Garry's Mod.
Development and design by L7D.

Catherine is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Catherine.  If not, see <http://www.gnu.org/licenses/>.
]]--

-- Add the resource pack.
resource.AddWorkshop( "104491619" )
resource.AddWorkshop( "105042805" )

catherine.util.AddResourceInFolder( "materials/CAT_HL2RP" )

CAT_SCHEMA_COMBINEOVERLAY_LOCAL = 1
CAT_SCHEMA_COMBINEOVERLAY_GLOBAL = 2
CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL = 3

function Schema:DataSave( )
	local data = { }

	for k, v in pairs( ents.FindByClass( "cat_hl2rp_ration_dispenser" ) ) do
		data[ #data + 1 ] = {
			pos = v:GetPos( ),
			ang = v:GetAngles( ),
			active = v:GetActive( )
		}
	end

	catherine.data.Set( "ration_dispenser", data )
end

function Schema:DataLoad( )
	local data = catherine.data.Get( "ration_dispenser", { } )

	for k, v in pairs( data ) do
		local ent = ents.Create( "cat_hl2rp_ration_dispenser" )
		ent:SetPos( v.pos )
		ent:SetAngles( v.ang )
		ent:Spawn( )
		
		if ( v.active ) then
			ent:SetActive( true )
		end
	end
end

function Schema:ShowSpare1( pl )
	if ( !pl:HasItem( "zip_tie" ) ) then return end
	local data = { }
	data.start = pl:GetShootPos( )
	data.endpos = data.start + pl:GetAimVector( ) * 160
	data.filter = pl
	local ent = util.TraceLine( data ).Entity
	
	if ( !IsValid( ent ) ) then
		catherine.util.NotifyLang( pl, "Entity_Notify_NotPlayer" )
		return
	end
	
	if ( ent:GetClass( ) == "prop_ragdoll" ) then
		ent = catherine.entity.GetPlayer( ent )
	end
	
	if ( IsValid( ent ) and ent:IsPlayer( ) ) then
		catherine.player.SetTie( pl, ent, true, nil, true )
	else
		catherine.util.NotifyLang( pl, "Entity_Notify_NotPlayer" )
	end
end

function Schema:PlayerCanSpray( pl )
	return pl:HasItem( "spray_can" )
end

function Schema:GetRationCash( pl )
	return math.random( 20, 40 )
end

function Schema:PlayerInteract( pl, target )
	if ( target:IsTied( ) ) then
		return catherine.player.SetTie( pl, target, false )
	end
end

function Schema:SayRadio( pl, text )
	local listeners = self:GetRadioListeners( pl )
	local blockPl = nil
	local radioSignal = pl:GetNetVar( "radioSignal", 0 )

	if ( radioSignal == 2 ) then
		local ex = string.Explode( " ", text )
		
		for k, v in pairs( ex ) do
			ex[ k ] = ex[ k ] .. string.rep( ".", math.random( 2, 10 ) )
		end
		
		text = table.concat( ex, "" )
	elseif ( radioSignal == 1 ) then
		text = string.rep( ".", #text )
		
		for k, v in pairs( listeners ) do
			v:EmitSound( "ambient/levels/prison/radio_random" .. math.random( 1, 9 ) .. ".wav", 40 )
		end
		
		blockPl = pl
	elseif ( radioSignal == 0 ) then
		catherine.chat.RunByID( pl, "radio", string.rep( ".", #text ) )
		pl:EmitSound( "ambient/levels/prison/radio_random" .. math.random( 1, 9 ) .. ".wav", 40 )
		
		return
	end

	catherine.chat.RunByID( pl, "radio", text, listeners, blockPl )
end

function Schema:SayRequest( pl, text )
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_GLOBAL, nil, { "CombineOverlay_Request", { pl:Name( ), text } }, 9, Color( 255, 150, 150 ) )
	catherine.chat.RunByID( pl, "request", text, self:GetCombines( ) )
end

function Schema:SayDispatch( pl, text )
	catherine.chat.RunByID( pl, "dispatch", text )
end

function Schema:SayBreenCast( pl, text )
	catherine.chat.RunByID( pl, "breencast", text )
end

function Schema:ChatPrefix( pl, classTable )
	local uniqueID = classTable.uniqueID
	
	if ( pl:PlayerIsCombine( ) and ( uniqueID == "ic" or uniqueID == "yell" or uniqueID == "whisper" ) ) then
		return "< :: "
	end
end

function Schema:OnChatControl( chatInformation )
	local pl = chatInformation.pl
	local uniqueID = chatInformation.uniqueID

	if ( uniqueID == "ic" or uniqueID == "radio" or uniqueID == "yell" or uniqueID == "whisper" ) then
		local text = chatInformation.text
		local tab = {
			sounds = { },
			text = text
		}
		local ex = string.Explode( ", ", text )
		local vol = true

		if ( uniqueID == "ic" ) then
			vol = 80
		elseif ( uniqueID == "yell" ) then
			vol = 100
		elseif ( uniqueID == "whisper" ) then
			vol = 30
		end

		for k, v in pairs( self.vo.normalVoice ) do
			if ( !table.HasValue( v.faction, pl:Team( ) ) ) then continue end
			local isFemale = false
			
			if ( pl:Team( ) == FACTION_CITIZEN and pl:IsFemale( ) and v.allowFemale ) then
				isFemale = true
			end
			
			for k1, v1 in pairs( ex ) do
				if ( v1:lower( ) == v.command:lower( ) ) then
					local sound = v.sound
					
					if ( isFemale ) then
						sound = sound:gsub( "male01", "female01" )
					end
					
					local sounds = {
						dir = sound,
						len = SoundDuration( sound ),
						vol = vol
					}

					tab.sounds[ #tab.sounds + 1 ] = sounds
					tab.text = k1 == 1 and ( v.output ) or ( tab.text .. ", " .. v.output )
				end
			end
		end

		chatInformation.voice = tab.sounds
		chatInformation.text = tab.text
		
		return chatInformation
	elseif ( uniqueID == "dispatch" ) then
		local text = chatInformation.text:lower( )
		local tab = {
			sounds = { },
			text = text
		}
		
		for k, v in pairs( self.vo.dispatchVoice ) do
			if ( v.command:lower( ) == text ) then
				tab.sounds[ #tab.sounds + 1 ] = {
					dir = v.sound,
					len = SoundDuration( v.sound ),
					vol = true
				}
				tab.text = v.output
			end
		end
		
		chatInformation.voice = tab.sounds
		chatInformation.text = tab.text
		
		return chatInformation
	elseif ( uniqueID == "breencast" ) then
		local text = chatInformation.text:lower( )
		local tab = {
			sounds = { },
			text = text
		}
		
		for k, v in pairs( self.vo.breenCast ) do
			if ( v.command:lower( ) == text ) then
				tab.sounds[ #tab.sounds + 1 ] = {
					dir = v.sound,
					len = SoundDuration( v.sound ),
					vol = true
				}
				tab.text = v.output
			end
		end
		
		chatInformation.voice = tab.sounds
		chatInformation.text = tab.text
		
		return chatInformation
	end
end

function Schema:ChatPosted( chatInformation )
	if ( !chatInformation.voice ) then return end
	local pl = chatInformation.pl
	local len = 0

	for k, v in pairs( chatInformation.voice ) do
		len = len + ( k == 1 and 0 or v.len + 0.3 )
		
		timer.Simple( len, function( )
			if ( !IsValid( pl ) or !pl:Alive( ) ) then return end
			
			if ( v.vol == true ) then
				pl:EmitSound( v.dir, 70 )
				catherine.util.PlaySimpleSound( chatInformation.target and chatInformation.target or nil, v.dir )
			else
				pl:EmitSound( v.dir, v.vol )
			end
		end )
	end
end

function Schema:PlayerUseDoor( pl, ent )
	local partner = catherine.util.GetDoorPartner( ent )

	if ( IsValid( ent.lock ) or ( IsValid( partner ) and IsValid( partner.lock ) ) and !ent:HasSpawnFlags( 256 ) and !ent:HasSpawnFlags( 1024 ) ) then
		if ( ( IsValid( ent.lock ) and !ent.lock:GetLocked( ) ) or ( IsValid( partner ) and IsValid( partner.lock ) and !partner.lock:GetLocked( ) ) ) then
			ent:Fire( "Open", "", 0 )
		
			return true
		end
	end
	
	if ( pl:PlayerIsCombine( ) and !ent:HasSpawnFlags( 256 ) and !ent:HasSpawnFlags( 1024 ) ) then
		ent:Fire( "Open", "", 0 )
		
		return true
	end
end

function Schema:AddCombineOverlayMessage( targetType, pl, langTable, time, col, textMakeDelay )
	targetType = targetType or CAT_SCHEMA_COMBINEOVERLAY_GLOBAL
	local combines = self:GetCombines( )
	
	if ( targetType == CAT_SCHEMA_COMBINEOVERLAY_LOCAL and IsValid( pl ) ) then
		combines = pl
	elseif ( targetType == CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL and IsValid( pl ) ) then
		table.RemoveByValue( combines, pl )
	end
	
	for k, v in pairs( type( combines ) == "Player" and { combines } or combines ) do
		netstream.Start( v, "catherine.Schema.AddCombineOverlayMessage", {
			LANG( v, langTable[ 1 ], unpack( langTable[ 2 ] or { } ) ),
			time or 6,
			col or Color( 255, 255, 255 ),
			textMakeDelay or 0.05
		} )
	end
end

function Schema:ClearCombineOverlayMessages( pl )
	if ( !IsValid( pl ) ) then return end
	
	netstream.Start( pl, "catherine.Schema.ClearCombineOverlayMessages" )
end

function Schema:PlayerFootstep( pl, pos, foot, soundName, vol )
	if ( !pl:PlayerIsCombine( ) or !pl:IsRunning( ) ) then return true end
	local sound = "npc/metropolice/gear" .. math.random( 1, 6 ) .. ".wav"
	
	if ( pl:Team( ) == FACTION_OW ) then
		sound = "npc/combine_soldier/gear" .. math.random( 1, 6 ) .. ".wav"
	end
	
	pl:EmitSound( sound, 70 )
	
	return true
end

function Schema:GetPlayerPainSound( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	local team = pl:Team( )
	
	if ( team == FACTION_CP ) then
		return "npc/metropolice/pain" .. math.random( 1, 3 ) .. ".wav"
	elseif ( team == FACTION_OW ) then
		return "npc/combine_soldier/pain" .. math.random( 1, 3 ) .. ".wav"
	end
end

function Schema:GetPlayerDeathSound( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	local team = pl:Team( )
	
	if ( team == FACTION_CP ) then
		return "npc/metropolice/die" .. math.random( 1, 4 ) .. ".wav"
	elseif ( team == FACTION_OW ) then
		return "npc/combine_soldier/die" .. math.random( 1, 3 ) .. ".wav"
	end
end

function Schema:HealthFullRecovered( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, { "CombineOverlay_HealthFullRecovered" }, 4, Color( 150, 255, 150 ) )
end

function Schema:PlayerTakeDamage( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	
	if ( ( pl.CAT_HL2RP_nextHurtDelay or CurTime( ) ) <= CurTime( ) ) then
		self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, { "CombineOverlay_TakeDmg_Local" }, 7, Color( 255, 150, 0 ) )
		self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL, pl, { "CombineOverlay_TakeDmg_NoLocal", { pl:Name( ) } }, 7, Color( 255, 150, 0 ) )
		pl.CAT_HL2RP_nextHurtDelay = CurTime( ) + 5
	end
end

function Schema:HealthRecovering( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end

	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, { "CombineOverlay_HealthRecovering", { ( pl:Health( ) / pl:GetMaxHealth( ) ) * 100 } }, 4, Color( 255, 150, 150 ) )
end

function Schema:PlayerDeath( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	local name = pl:Name( )
	local localMessage = { "CombineOverlay_LocalPlayerDeath_CP" }
	local globalMessage = { "CombineOverlay_PlayerDeath_CP", { name } }
	
	if ( pl:Team( ) == FACTION_OW ) then
		localMessage = { "CombineOverlay_LocalPlayerDeath_OW" }
		globalMessage = { "CombineOverlay_PlayerDeath_OW", { name } }
	end

	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, localMessage, 10, Color( 255, 0, 0 ), 0.04 )
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL, pl, globalMessage, 10, Color( 255, 0, 0 ), 0.04 )

	for k, v in pairs( self:GetCombines( ) or { } ) do
		v:EmitSound( "npc/overwatch/radiovoice/on1.wav" )
		v:EmitSound( "npc/overwatch/radiovoice/lostbiosignalforunit.wav" )
		
		timer.Simple( 1.5, function( )
			v:EmitSound( "npc/overwatch/radiovoice/off4.wav" )
		end )
	end
end

function Schema:OnSpawnedInCharacter( pl )
	if ( pl:Team( ) == FACTION_CP ) then
		local rankID, classID = self:GetRankByName( pl:Name( ) )
		
		self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, { "CombineOverlay_Online" }, 5, Color( 150, 255, 150 ), 0.04 )

		if ( pl:Class( ) != nil and pl:Class( ) != classID ) then
			if ( rankID and classID ) then
				catherine.class.Set( pl, classID )
				pl:SetModel( self:GetModelByRank( rankID ) )
			else
				if ( pl:Class( ) == CLASS_CP_UNIT ) then return end
				catherine.class.Set( pl, CLASS_CP_UNIT )
			end
		elseif ( pl:Class( ) != nil and pl:Class( ) == classID and self:GetModelByRank( rankID ) != pl:GetModel( ) ) then
			pl:SetModel( self:GetModelByRank( rankID ) )
		elseif ( pl:Class( ) == nil ) then
			if ( rankID and classID ) then
				catherine.class.Set( pl, classID )
				pl:SetModel( self:GetModelByRank( rankID ) )
			else
				if ( pl:Class( ) == CLASS_CP_UNIT ) then return end
				catherine.class.Set( pl, CLASS_CP_UNIT )
			end
		end
		
		hook.Run( "CombineClassSetFinished", pl )
		
		return
	end
	
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_GLOBAL, nil, { "CombineOverlay_RFCitizens" }, 7, Color( 150, 255, 150 ) )
end

function Schema:GetBeepSound( pl, IsOff )
	local team = pl:Team( )
	
	if ( team == FACTION_CP ) then
		if ( IsOff ) then
			return "npc/metropolice/vo/off" .. math.random( 1, 4 ) .. ".wav"
		else
			if ( math.random( 1, 9 ) <= 5 ) then
				return "npc/metropolice/vo/on" .. math.random( 1, 2 ) .. ".wav"
			else
				return "npc/overwatch/radiovoice/on3.wav"
			end
		end
	elseif ( team == FACTION_OW ) then
		if ( IsOff ) then
			return "npc/combine_soldier/vo/off" .. math.random( 1, 3 ) .. ".wav"
		else
			return "npc/combine_soldier/vo/on" .. math.random( 1, 2 ) .. ".wav"
		end
	end
end

function Schema:ChatTypingChanged( pl, bool )
	if ( !pl:Alive( ) or !pl:PlayerIsCombine( ) ) then return end
	
	pl:EmitSound( self:GetBeepSound( pl, !bool ), 60 )
end

function Schema:CharacterNameChanged( pl, newName )
	if ( pl:Team( ) != FACTION_CP ) then return end
	local rankID, classID = self:GetRankByName( pl:Name( ) )

	if ( pl:Class( ) != nil and pl:Class( ) != classID ) then
		if ( rankID and classID ) then
			catherine.class.Set( pl, classID )
			pl:SetModel( self:GetModelByRank( rankID ) )
		else
			if ( pl:Class( ) == CLASS_CP_UNIT ) then return end
			
			catherine.class.Set( pl, CLASS_CP_UNIT )
		end
	elseif ( pl:Class( ) != nil and pl:Class( ) == classID and self:GetModelByRank( rankID ) != pl:GetModel( ) ) then
		pl:SetModel( self:GetModelByRank( rankID ) )
	elseif ( pl:Class( ) == nil ) then
		if ( rankID and classID ) then
			catherine.class.Set( pl, classID )
			pl:SetModel( self:GetModelByRank( rankID ) )
		else
			if ( pl:Class( ) == CLASS_CP_UNIT ) then return end
			
			catherine.class.Set( pl, CLASS_CP_UNIT )
		end
	end
end

function Schema:CharacterLoadingStart( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	
	self:ClearCombineOverlayMessages( pl )
end

function Schema:GetRadioListeners( pl )
	local listeners = { }
	local playerFreq = pl:GetInvItemData( "portable_radio", "freq" )
	
	if ( !playerFreq ) then
		return listeners
	end
	
	for k, v in pairs( player.GetAllByLoaded( ) ) do
		if ( !v:HasItem( "portable_radio" ) ) then continue end
		local targetItemDatas = v:GetInvItemDatas( "portable_radio" )
		
		if ( targetItemDatas.freq == playerFreq and targetItemDatas.toggle and targetItemDatas.freq and ( targetItemDatas.freq != "xxx.x" and targetItemDatas.freq != "" ) ) then
			listeners[ #listeners + 1 ] = v
		end
	end
	
	return listeners
end

function Schema:Think( )
	if ( ( self.NextRadioSignalCheckTick or 0 ) <= CurTime( ) ) then
		self:RadioThink( )
		self.NextRadioSignalCheckTick = CurTime( ) + 2
	end
end

function Schema:PlayerJump( pl, velo )
	catherine.attribute.AddProgress( pl, CAT_ATT_JUMP, 0.0009 )
end

local defJumpPower = catherine.configs.playerDefaultJumpPower

function Schema:GetCustomPlayerDefaultJumpPower( pl )
	local jumpAttribute = catherine.attribute.GetProgress( pl, CAT_ATT_JUMP )

	return defJumpPower + math.min( jumpAttribute * 1.5, 100 )
end

function Schema:RadioThink( )
	for k, v in pairs( player.GetAllByLoaded( ) ) do
		if ( !v:HasItem( "portable_radio" ) or v:GetInvItemData( "portable_radio", "toggle" ) == false ) then continue end
		local newSignal = self:CalcRadio( v )
		
		if ( v.GetNetVar( v, "radioSignal", 0 ) != newSignal ) then
			v:SetNetVar( "radioSignal", newSignal )
		end
	end
end

local radioSignalData = {
	{ 5, 800 },
	{ 4, 1800 },
	{ 3, 3000 },
	{ 2, 5000 },
	{ 1, 8000 },
	{ 0, 10000 }
}

function Schema:CalcRadio( pl )
	local listeners = self:GetRadioListeners( pl )
	local max = 1000000 // max map size.

	for k, v in pairs( listeners ) do
		if ( pl == v ) then continue end
		local dis = catherine.util.CalcDistanceByPos( pl, v )
		
		if ( dis < max ) then
			max = dis
		end
	end

	for k, v in pairs( radioSignalData ) do
		if ( v[ 2 ] >= max and radioSignalData[ math.min( k + 1, #radioSignalData ) ][ 2 ] > max ) then
			return v[ 1 ]
		end
	end
	
	return 0
end