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

AddCSLuaFile( )

DEFINE_BASECLASS( "base_gmodentity" )

ENT.Type = "anim"
ENT.PrintName = "Catherine HL2RP Static Radio"
ENT.Author = "L7D"
ENT.Spawnable = false
ENT.AdminSpawnable = false

if ( SERVER ) then
	function ENT:Initialize( )
		self:SetModel( "models/props_lab/citizenradio.mdl" )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:SetNetVar( "active", false )
		self:SetNetVar( "freq", "XXX.X" )
		
		local physObject = self:GetPhysicsObject( )
		
		if ( IsValid( physObject ) ) then
			physObject:Wake( )
		end
		
		catherine.entity.RegisterUseMenu( self, {
			{
				uniqueID = "ID_SETRADIOFREQ",
				text = "^Item_FuncStr01_SR",
				icon = "icon16/database_gear.png",
				func = function( pl, ent )
					catherine.util.StringReceiver( pl, "StaticRadio_UniqueSetFreq", "^Item_RadioFreqQ_SR", self:GetNetVar( "freq", "XXX.X" ), function( _, val )
						if ( val:find( "^%d%d%d%.%d$" ) ) then
							local one, two, three = val:match( "(%d)%d(%d)%.(%d)" )
							one = tonumber( one ) two = tonumber( two ) three = tonumber( three )
							
							if ( one == 1 and two > 0 and two <= 9 and three > 0 and three <= 9 ) then
								self:SetNetVar( "freq", val )
								catherine.util.NotifyLang( pl, "Item_Notify_FreqSet_SR", val )
							else
								catherine.util.NotifyLang( pl, "Item_Notify_Error01_SR" )
							end
						else
							catherine.util.NotifyLang( pl, "Item_Notify_Error02_SR" )
						end
					end )
				end
			},
			{
				uniqueID = "ID_TOGGLE",
				text = "^Item_FuncStr02_SR",
				icon = "icon16/accept.png",
				func = function( pl, ent )
					self:SetNetVar( "active", !self:GetNetVar( "active", false ) )
				end
			}
		} )
	end
	
	function ENT:RadioReceived( )
		self:EmitSound( "ambient/levels/prison/radio_random" .. math.random( 1, 9 ) .. ".wav", 100 )
	end
else
	local glowMat = Material( "sprites/glow04_noz" )
	local toscreen = FindMetaTable( "Vector" ).ToScreen
	
	function ENT:Draw( pl, ent, a )
		local col = Color( 255, 0, 0 )
		
		if ( self:GetNetVar( "active" ) ) then
			col = Color( 0, 255, 0 )
		end
		
		self:DrawModel( )
		
		render.SetMaterial( glowMat )
		render.DrawSprite( self:GetPos( ) + self:GetForward( ) * 10 + self:GetRight( ) * 10 + self:GetUp( ) * 4, 10, 10, col )
	end
	
	function ENT:DrawEntityTargetID( pl, ent, a )
		local pos = toscreen( self:LocalToWorld( self:OBBCenter( ) ) )
		local x, y = pos.x, pos.y
		local freqDesc = LANG( "Item_NoFreq" )
		
		if ( !ent.sr_name or !ent.sr_desc ) then
			ent.sr_name = LANG( "Item_Name_SR" )
			ent.sr_desc = LANG( "Item_Desc_SR" )
		end
		
		local freq = ent:GetNetVar( "freq" )
		
		if ( freq ) then
			freqDesc = LANG( "Item_Freq", freq )
		end
		
		draw.SimpleText( ent.sr_name, "catherine_outline25", x, y, Color( 255, 255, 255, a ), 1, 1 )
		draw.SimpleText( freqDesc, "catherine_outline15", x, y + 25, Color( 255, 255, 255, a ), 1, 1 )
	end
end