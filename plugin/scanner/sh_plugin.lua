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
PLUGIN.name = "^Scanner_Plugin_Name"
PLUGIN.author = "L7D, Chessnut"
PLUGIN.desc = "^Scanner_Plugin_Desc"

catherine.util.Include( "cl_plugin.lua" )
catherine.util.Include( "sv_plugin.lua" )

catherine.language.Merge( "english", {
	[ "Scanner_Plugin_Name" ] = "Flashlight",
	[ "Scanner_Plugin_Desc" ] = "Good stuff."
} )

catherine.language.Merge( "korean", {
	[ "Scanner_Plugin_Name" ] = "손전등",
	[ "Scanner_Plugin_Desc" ] = "손전등을 추가합니다."
} )