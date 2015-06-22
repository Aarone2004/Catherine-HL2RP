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
local isHidden = false
local zoom = 0
local deltaZoom = zoom
	
function PLUGIN:CalcView( pl, pos, ang, fov )
	local viewEnt = pl:GetViewEntity( )

	if ( IsValid( viewEnt ) and viewEnt:GetClass( ):find( "scanner" ) ) then
		return {
			angles = pl:GetAimVector( ):Angle( ),
			fov = fov - deltaZoom
		}
	end
end

function PLUGIN:PreDrawOpaqueRenderables( )
	local viewEnt = LocalPlayer( ):GetViewEntity( )

	if ( IsValid( self.lastViewEnt ) and self.lastViewEnt != viewEnt ) then
		self.lastViewEnt:SetNoDraw( false )
		self.lastViewEnt = nil

		isHidden = false
	end

	if ( IsValid( viewEnt ) and viewEnt:GetClass( ):find( "scanner" ) ) then
		viewEnt:SetNoDraw( true )
		self.lastViewEnt = viewEnt

		isHidden = true
	end
end

function PLUGIN:RenderScreenspaceEffects( )
	if ( isHidden and LocalPlayer( ):GetNetVar( "isScanner" ) ) then
		local tab = { }
		tab[ "$pp_colour_addr" ] = 0.4
		tab[ "$pp_colour_addg" ] = 0.15
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = 0
		tab[ "$pp_colour_contrast" ] = 1
		tab[ "$pp_colour_colour" ] = 0.9
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0

		DrawColorModify( tab )
	end
end

function PLUGIN:CantDrawBar( )
	return LocalPlayer( ):GetNetVar( "isScanner" )
end

function PLUGIN:InputMouseApply( cmd, x, y, ang )
	zoom = math.Clamp( zoom + cmd:GetMouseWheel( ) * 1.5, 0, 40 )
	deltaZoom = Lerp( FrameTime( ) * 2, deltaZoom, zoom )
end

function PLUGIN:HUDDraw( )
	if ( !isHidden or !LocalPlayer( ):GetNetVar( "isScanner" ) or !LocalPlayer( ):Alive( ) ) then
		return
	end
	
	local scrW, scrH = ScrW( ), ScrH( )
	
	draw.NoTexture( )
	surface.SetDrawColor( 0, 0, 0, 200 )
	catherine.geometry.DrawCircle( scrW / 2, scrH / 2, scrH / 2 - 20, scrW, 10, 360, 50 )
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	
	surface.DrawLine( scrW / 2 - scrW / 2 / 2 - 5, scrH / 2 - scrH / 2 / 2, scrW / 2 + scrW / 2 / 2 + 5, scrH / 2 - scrH / 2 / 2 )
	surface.DrawLine( scrW / 2 - scrW / 2 / 2 - 5, scrH / 2 + scrH / 2 / 2, scrW / 2 + scrW / 2 / 2 + 5, scrH / 2 + scrH / 2 / 2 )
	surface.DrawLine( scrW / 2 - scrW / 2 / 2 - 5, scrH / 2 + scrH / 2 / 2, scrW / 2 - scrW / 2 / 2 - 5, scrH / 4 )
	surface.DrawLine( scrW / 2 + scrW / 2 / 2 + 5, scrH / 2 + scrH / 2 / 2, scrW / 2 + scrW / 2 / 2 + 5, scrH / 4 )

	local pl = LocalPlayer( )
	local pos = pl:GetPos( )
	local ang = pl:GetAngles( )
	draw.SimpleText( "POWER ( " .. pl:Health( ) .. "% )", "catherine_hl2rp_scanner25", scrW - 10, 75, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, 1 )
	draw.SimpleText( "POSITION ( X:" .. math.floor( pos[ 1 ] ) .. ", Y:" .. math.floor( pos[ 2 ] ) .. ", Z:" .. math.floor( pos[ 3 ] ) .. " )", "catherine_hl2rp_scanner15", scrW - 10, scrH - 20, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, 1 )
	draw.SimpleText( "ANGLES ( P:" .. math.floor( ang[ 1 ] ) .. ", Y:" .. math.floor( ang[ 2 ] ) .. ", R:" .. math.floor( ang[ 3 ] ) .. " )", "catherine_hl2rp_scanner15", scrW - 10, scrH - 40, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, 1 )
	draw.SimpleText( "#" .. pl:Name( ) .. "", "catherine_hl2rp_scanner25", scrW - 10, 50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, 1 )
	draw.SimpleText( "ZOOM  ( " .. ( math.Round( zoom / 40, 2 ) * 100 ) .. "% )", "catherine_hl2rp_scanner15", scrW - 10, 100, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, 1 )
	
	local viewEnt = self.lastViewEnt
	
	if ( IsValid( viewEnt ) ) then
		local data = { }
		data.start = viewEnt:GetPos( )
		data.endpos = data.start + pl:GetAimVector( ) * 500
		data.filter = viewEnt
		local ent = util.TraceLine( data ).Entity

		ent = ( IsValid( ent ) and ent:IsPlayer( ) ) and ent:Name( ) or "NULL"

		draw.SimpleText( "TARGET ( " .. ent .. " )", "catherine_hl2rp_scanner20", scrW - 10, scrH - 90, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, 1 )
	end
end

catherine.font.Register( "catherine_hl2rp_scanner15", {
	font = "Consolas",
	size = 15,
	weight = 1000
} )

catherine.font.Register( "catherine_hl2rp_scanner20", {
	font = "Consolas",
	size = 20,
	weight = 1000
} )

catherine.font.Register( "catherine_hl2rp_scanner25", {
	font = "Consolas",
	size = 25,
	weight = 1000
} )