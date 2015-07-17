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

local PLUGIN = PLUGIN
PLUGIN.name = "^SignalAmplifier_Plugin_Name"
PLUGIN.author = "L7D"
PLUGIN.desc = "^SignalAmplifier_Plugin_Desc"

catherine.language.Merge( "english", {
	[ "SignalAmplifier_Plugin_Name" ] = "Signal Amplifier",
	[ "SignalAmplifier_Plugin_Desc" ] = "Good stuff."
} )

catherine.language.Merge( "korean", {
	[ "SignalAmplifier_Plugin_Name" ] = "신호 증폭기",
	[ "SignalAmplifier_Plugin_Desc" ] = "라디오의 신호를 증폭시켜 줍니다."
} )

if ( CLIENT ) then return end

local Schema = Schema

function Schema:GetRadioListeners( pl, isSignalOnly )
	local listeners = { pl }
	local isStaticRadio = false
	local rec = { }
	
	for k, v in pairs( ents.FindInSphere( pl:GetPos( ), 100 ) ) do
		if ( ( v:GetClass( ) == "cat_hl2rp_static_radio" or v:GetClass( ) == "cat_hl2rp_radio_signal_amplifier" ) and v:GetNetVar( "active" ) and ( v:GetNetVar( "freq" ) != "XXX.X" or v:GetNetVar( "freq" ) != "" ) ) then
			rec[ #rec + 1 ] = {
				ent = v,
				freq = v:GetNetVar( "freq" )
			}
			isStaticRadio = true
		end
	end

	if ( #rec > 0 ) then
		for k, v in pairs( rec ) do
			for k1, v1 in pairs( player.GetAllByLoaded( ) ) do
				if ( pl == v1 ) then continue end
				
				if ( v1:HasItem( "portable_radio" ) ) then
					local targetItemDatas = v1:GetInvItemDatas( "portable_radio" )
				
					if ( targetItemDatas.freq == v.freq and targetItemDatas.toggle and targetItemDatas.freq and ( targetItemDatas.freq != "xxx.x" and targetItemDatas.freq != "" ) ) then
						listeners[ #listeners + 1 ] = v1
					else
						for k2, v2 in pairs( ents.FindInSphere( v1:GetPos( ), 100 ) ) do
							if ( ( v2:GetClass( ) == "cat_hl2rp_static_radio" or v2:GetClass( ) == "cat_hl2rp_radio_signal_amplifier" ) and v2:GetNetVar( "active" ) and ( v2:GetNetVar( "freq" ) != "XXX.X" or v2:GetNetVar( "freq" ) != "" ) ) then
								if ( v2:GetNetVar( "freq" ) == v.freq ) then
									listeners[ #listeners + 1 ] = v1
									
									if ( v1.RadioReceived and !isSignalOnly ) then
										v1:RadioReceived( )
									end
								end
							end
						end
					end
				else
					for k2, v2 in pairs( ents.FindInSphere( v1:GetPos( ), 100 ) ) do
						if ( ( v2:GetClass( ) == "cat_hl2rp_static_radio" or v2:GetClass( ) == "cat_hl2rp_radio_signal_amplifier" ) and v2:GetNetVar( "active" ) and ( v2:GetNetVar( "freq" ) != "XXX.X" or v2:GetNetVar( "freq" ) != "" ) ) then
							if ( v2:GetNetVar( "freq" ) == v.freq ) then
								listeners[ #listeners + 1 ] = v1
								
								if ( v1.RadioReceived and !isSignalOnly ) then
									v1:RadioReceived( )
								end
							end
						end
					end
				end
			end
		end
	else
		local playerFreq = pl:GetInvItemData( "portable_radio", "freq" )
		local playerToggle = pl:GetInvItemData( "portable_radio", "toggle" )
		
		for k, v in pairs( player.GetAllByLoaded( ) ) do
			if ( pl == v ) then continue end
			
			if ( v:HasItem( "portable_radio" ) ) then
				local targetItemDatas = v:GetInvItemDatas( "portable_radio" )
			
				if ( targetItemDatas.freq == playerFreq and targetItemDatas.toggle and playerToggle and targetItemDatas.freq and ( targetItemDatas.freq != "xxx.x" and targetItemDatas.freq != "" ) ) then
					listeners[ #listeners + 1 ] = v
				else
					for k1, v1 in pairs( ents.FindInSphere( v:GetPos( ), 100 ) ) do
						if ( ( v1:GetClass( ) == "cat_hl2rp_static_radio" or v1:GetClass( ) == "cat_hl2rp_radio_signal_amplifier" ) and v1:GetNetVar( "active" ) and ( v1:GetNetVar( "freq" ) != "XXX.X" or v1:GetNetVar( "freq" ) != "" ) ) then
							if ( v1:GetNetVar( "freq" ) == playerFreq and playerToggle ) then
								listeners[ #listeners + 1 ] = v
								
								if ( v1.RadioReceived and !isSignalOnly ) then
									v1:RadioReceived( )
								end
							end
						end
					end
				end
			else
				for k1, v1 in pairs( ents.FindInSphere( v:GetPos( ), 100 ) ) do
					if ( ( v1:GetClass( ) == "cat_hl2rp_static_radio" or v1:GetClass( ) == "cat_hl2rp_radio_signal_amplifier" ) and v1:GetNetVar( "active" ) and ( v1:GetNetVar( "freq" ) != "XXX.X" or v1:GetNetVar( "freq" ) != "" ) ) then
						if ( v1:GetNetVar( "freq" ) == playerFreq and playerToggle ) then
							listeners[ #listeners + 1 ] = v
							
							if ( v1.RadioReceived and !isSignalOnly ) then
								v1:RadioReceived( )
							end
						end
					end
				end
			end
		end
	end

	return listeners, isStaticRadio
end