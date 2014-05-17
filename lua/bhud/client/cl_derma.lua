function cl_bHUD.addfrm( x, y, w, h )

	local frame = vgui.Create( "DFrame" )
	frame:SetPos( x, y )
	frame:SetSize( w, h )
	frame:SetTitle( "" )
	frame:SetVisible( true )
	frame:SetDraggable( false )
	frame:ShowCloseButton( false )
	frame:SetBackgroundBlur( true )
	frame:MakePopup()

	--function frame:PaintOver()
	function frame:Paint()

		draw.RoundedBoxEx( 4, 0, 0, w, 25, Color( 255, 150, 0 ), true, true, false, false )
		draw.RoundedBoxEx( 4, 0, 25, w, h - 25, Color( 50, 50, 50 ), false, false, true, true )
		draw.SimpleText( "bHUD - Settings", "bhud_roboto_18_ns", 5, 3, Color( 50, 50, 50 ), 0, 0 )

	end

	local close_button = vgui.Create( "DButton", frame )
	close_button:Center()
	close_button:SetFont( "bhud_roboto_18_ns" )
	close_button:SetTextColor( Color( 255, 255, 255 ) )
	close_button:SetText( "x" )
	close_button:SetPos( w - 50, 0 )
	close_button:SetSize( 45, 20 )
	close_button:SetDark( false )

	function close_button:Paint()

		if close_button:IsHovered() then
			draw.RoundedBox( 0, 0, 0, close_button:GetWide(), close_button:GetTall(), Color( 224, 67, 67 ) )
		else
			draw.RoundedBox( 0, 0, 0, close_button:GetWide(), close_button:GetTall(), Color( 200, 80, 80 ) )
		end

	end

	close_button.DoClick = function()

		frame:Close()

	end

	return frame

end

function cl_bHUD.addlbl( derma, text, x, y )

	local lbl = vgui.Create( "DLabel", derma )
	lbl:SetPos( x, y )
	lbl:SetColor( Color( 255, 255, 255 ) )
	lbl:SetFont( "bhud_roboto_16" )
	lbl:SetText( text )
	lbl:SetDark( false )
	lbl:SizeToContents()

end

function cl_bHUD.addchk( derma, text, x, y, setting )

	local chk = vgui.Create( "DCheckBoxLabel", derma )
	chk:SetPos( x, y )
	chk:SetText( "" )
	chk:SetChecked( cl_bHUD_sqldata[setting] )
	chk:SizeToContents()

	function chk:PaintOver()

		draw.RoundedBox( 2, 0, 0, chk:GetTall(), chk:GetTall(), Color( 100, 100, 100 ) )
		if chk:GetChecked() == false then return end
		draw.RoundedBox( 2, 0, 0, chk:GetTall(), chk:GetTall(), Color( 255, 150, 0 ) )

	end

	function chk:OnChange()

		local IsChecked = chk:GetChecked() and "1" or "0"
		sql.Query( "UPDATE bhud_settings SET value = " .. IsChecked .. " WHERE setting = '" .. setting .. "'" )
		cl_bHUD_sqldata[setting] = chk:GetChecked() and true or false

	end

	local lbl = vgui.Create( "DLabel", derma )
	lbl:SetPos( x + 20, y )
	lbl:SetColor( Color( 255, 255, 255 ) )
	lbl:SetFont( "bhud_roboto_16" )
	lbl:SetText( text )
	lbl:SetDark( false )
	lbl:SizeToContents()

end

function cl_bHUD.addsld( derma, text, x, y, w, min, max, value, variable )

	local sld = vgui.Create( "DNumSlider", derma )
	sld:SetPos( x - 20, y )
	sld:SetWide( w )
	sld:SetMin( min )
	sld:SetMax( max )
	sld:SetDecimals( 0 )
	sld:SetText( "" )
	sld:SetDark( false )
	sld:SetValue( value )

	local lbl = vgui.Create( "DLabel", derma )
	lbl:SetPos( x, y + 8 )
	lbl:SetColor( Color( 255, 255, 255 ) )
	lbl:SetFont( "bhud_roboto_16" )
	lbl:SetText( text )
	lbl:SetDark( false )
	lbl:SizeToContents()

	local lbl2 = vgui.Create( "DLabel", derma )
	lbl2:SetPos( x + w - 60, y + 8 )
	lbl2:SetColor( Color( 255, 255, 255 ) )
	lbl2:SetFont( "bhud_roboto_16" )
	lbl2:SetText( tostring( value ) )
	lbl2:SetDark( false )
	lbl2:SizeToContents()

	local posx = value

	sld.ValueChanged = function( self, number )
		
		if variable == "radius" then
			bhud_map_radius = math.floor( number )
			bhud_map_left = ScrW() - bhud_map_radius - 10 - 5
			bhud_map_top = ScrH() - bhud_map_radius - 10 - 5
		end
		lbl2:SetText( tostring( math.floor( number ) ) )
		lbl2:SizeToContents()
		posx = math.floor( number )

	end

	function sld:PaintOver()

		draw.RoundedBox( 2, 125, 8, w - 137, 17, Color( 100, 100, 100 ) )
		draw.RoundedBox( 2, posx + 75 + ( posx * 0.1 ), 12, 10, 10, Color( 255, 150, 0 ) )

	end

end