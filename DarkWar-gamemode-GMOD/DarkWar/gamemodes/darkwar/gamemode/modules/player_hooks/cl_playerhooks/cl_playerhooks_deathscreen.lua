local canRespawnBoolTransl = {

	[false] = { txt = 'Возрождение доступно!', color = Color(35, 200, 0, 255) },
	[true] = { txt = 'Вы мертвы! Ожидайте...', color = Color(200, 35, 0, 255) }
}

hook.Add('HUDPaint', 'PlayerInterface_DrawDeathScreen', function()

	if not cl_VarsLoaded then return end
	if not lcply:GetAuthorised() then return end
	if lcply_hp > 0 then return end

	drawTextWithShadow(canRespawnBoolTransl[lcply_dead].txt, "SplashFont", scrw / 2, scrh / 2, canRespawnBoolTransl[lcply_dead].color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end)