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

catherine.command.Register( {
	command = "radio",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )
		
		if ( args != "" ) then
			if ( pl:HasItem( "portable_radio" ) ) then
				local itemData = pl:GetInvItemDatas( "portable_radio" )
				
				if ( itemData.toggle ) then
					if ( itemData.freq != "xxx.x" and itemData.freq != "" ) then
						Schema:SayRadio( pl, args )
					else
						catherine.util.NotifyLang( pl, "Item_Notify_Error05_PR" )
					end
				else
					catherine.util.NotifyLang( pl, "Item_Notify_Error04_PR" )
				end
			else
				catherine.util.NotifyLang( pl, "Item_Notify_Error03_PR" )
			end
		else
			catherine.util.NotifyLang( pl, "Basic_Notify_InputText" )
		end
	end
} )

catherine.command.Register( {
	command = "request",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )
		
		if ( args != "" ) then
			if ( pl:HasItem( "request_device" ) ) then
				Schema:SayRequest( pl, args )
			else
				catherine.util.NotifyLang( pl, "Item_Notify_Error01_RD" )
			end
		else
			catherine.util.NotifyLang( pl, "Basic_Notify_InputText" )
		end
	end
} )

catherine.command.Register( {
	command = "dispatch",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )
		local team = pl:Team( )

		if ( team == FACTION_ADMIN or team == FACTION_OW or ( team == FACTION_CP and table.HasValue( { "EpU", "SeC", "DvL" }, Schema:GetRankByName( pl:Name( ) ) or "ERROR" ) ) ) then
			if ( args != "" ) then
				Schema:SayDispatch( pl, args )
			else
				catherine.util.NotifyLang( pl, "Basic_Notify_InputText" )
			end
		else
			catherine.util.NotifyLang( pl, "Player_Message_HasNotPermission" )
		end
	end
} )

catherine.command.Register( {
	command = "breencast",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )

		if ( pl:Team( ) == FACTION_ADMIN ) then
			if ( args != "" ) then
				Schema:SayBreenCast( pl, args )
			else
				catherine.util.NotifyLang( pl, "Basic_Notify_InputText" )
			end
		else
			catherine.util.NotifyLang( pl, "Player_Message_HasNotPermission" )
		end
	end
} )

catherine.command.Register( {
	command = "dispenseradd",
	canRun = function( pl ) return pl:IsAdmin( ) end,
	runFunc = function( pl, args )
		local pos, ang = pl:GetEyeTraceNoCursor( ).HitPos, pl:EyeAngles( )
		ang.p = 0
		ang.y = ang.y - 180
		
		local ent = ents.Create( "cat_hl2rp_ration_dispenser" )
		ent:SetPos( pos )
		ent:SetAngles( ang )
		ent:Spawn( )
		ent:Activate( )
	end
} )