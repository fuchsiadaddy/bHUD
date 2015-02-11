----------------------
--  DEFAULT VALUES  --
----------------------

-- bHUD
bhud.defs.drawhud = true

-- HoverHUD
bhud.defs.hhud = { draw = true }

-- PlayerHUD
bhud.defs.phud = { draw = true, design = 1, name = true }

-- TimeHUD
bhud.defs.thud = { draw = true, day = false }

-- MapHUD
bhud.defs.mhud = { draw = true, left = ScrW() - 103 - 10, top = ScrH() - 103 - 10, rad = 100, bor = 3, tol = 200 }



----------------------------
--  SAVE / LOAD SETTINGS  --
----------------------------

-- Load Settings
if file.Exists( "bhud_settings.txt", "DATA" ) then

	local json = file.Read( "bhud_settings.txt", "DATA" )
	local s = util.JSONToTable( json )
	table.foreach( s, function( k, v )

		if istable( v ) then
			table.foreach( s[ k ], function( key, val )
				bhud[ k ][ key ] = s[ k ][ key ]
			end )
		else
			bhud[ k ] = v
		end

	end )

end

-- Save Settings
function bhud.save()

	local s = {}

	table.foreach( bhud.defs, function( k, v )
		if istable( v ) then
			table.foreach( bhud.defs[ k ], function( key, val )
				if !s[ k ] then s[ k ] = {} end
				if bhud[ k ][ key ] != nil then s[ k ][ key ] = bhud[ k ][ key ] else s[ k ][ key ] = bhud.defs[ k ][ key ] end
			end )
		else
			if bhud[ k ] != nil then s[ k ] = bhud[ k ] else s[ k ] = bhud.defs[ k ] end
		end

	end )

	file.Write( "bhud_settings.txt", util.TableToJSON( s ) )

end



----------------------
--  SETTINGS PANEL  --
----------------------

function bhud.spanel()

	local frm = bhud.addfrm( 250, 400, "Settings:" )

	bhud.addlbl( frm, "General:", true )
	bhud.addchk( frm, 230, "Enable bHUD", bhud.drawhud, function( c ) bhud.drawhud = c end )

	bhud.addlbl( frm, "HUDs:", true, true )
	bhud.addchk( frm, 230, "Draw PlayerHUD", bhud.phud.draw, function( c ) bhud.phud.draw = c end )
	bhud.addchk( frm, 230, "Draw TimeHUD", bhud.thud.draw, function( c ) bhud.thud.draw = c end )
	bhud.addchk( frm, 230, "Draw Minimap", bhud.mhud.draw, function( c ) bhud.mhud.draw = c end )
	bhud.addchk( frm, 230, "Draw Hovernames", bhud.hhud.draw, function( c ) bhud.hhud.draw = c end )

	bhud.addlbl( frm, "PlayerHUD:", true, true )
	bhud.addchk( frm, 230, "Draw player-name", bhud.phud.name, function( c ) bhud.phud.name = c end )
	bhud.addsld( frm, 230, "Design", bhud.phud.design, 1, bhud.phud.designs, function( v ) bhud.phud.design = v end )

	bhud.addlbl( frm, "TimeHUD:", true, true )
	bhud.addchk( frm, 230, "Draw date", bhud.thud.day, function( c ) bhud.thud.day = c end )

	bhud.addlbl( frm, "Minimap:", true, true )
	bhud.addsld( frm, 230, "Radius", bhud.mhud.rad, 50, 150, function( v ) bhud.mhud.rad = v end )
	bhud.addsld( frm, 230, "Border", bhud.mhud.bor, 0, 5, function( v ) bhud.mhud.bor = v end )
	bhud.addsld( frm, 230, "X-Pos", bhud.mhud.left, 20 + bhud.mhud.bor + bhud.mhud.rad, ScrW() - bhud.mhud.rad - bhud.mhud.bor - 20, function( v ) bhud.mhud.left = v end )
	bhud.addsld( frm, 230, "Y-Pos", bhud.mhud.top, 20 + bhud.mhud.bor + bhud.mhud.rad, ScrH() - bhud.mhud.rad - bhud.mhud.bor - 20, function( v ) bhud.mhud.top = v end )

end

-- BHUD-SETTINGS INFORMATION
chat.AddText( Color( 255, 50, 0 ), "[bHUD - Settings]", Color( 255, 255, 255 ), " Hold '", Color( 255, 150, 0 ), "C", Color( 255, 255, 255 ), "' and click on the ", Color( 255, 150, 0 ), "orange symbol", Color( 255, 255, 255 ), " in the right bottom corner to open the settings!" )
