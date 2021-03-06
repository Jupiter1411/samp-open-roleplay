stock SendClientMessageToAllEx(colour, const fmat[], va_args<>)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<2>);
	return SendClientMessageToAll(colour, str);
}

stock SendClientMessageEx(playerid, colour, const fmat[],  va_args<>)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);
	return SendClientMessage(playerid, colour, str);
}

stock SendNearbyMessage(playerid, Float:radius, color, const fmat[], {Float,_}:...)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<4>);

	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, str);
		}
	}

	return 1;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	if(targetid == INVALID_PLAYER_ID || !IsPlayerConnected(targetid)) {
		return 0;
	}

	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock IsValidRoleplayName(const name[]) {
	if (!name[0] || strfind(name, "_") == -1)
	    return 0;

	else for (new i = 0, len = strlen(name); i != len; i ++) {
	    if ((i == 0) && (name[i] < 'A' || name[i] > 'Z'))
	        return 0;

		else if ((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z'))
		    return 0;

		else if ((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.')
		    return 0;
	}
	return 1;
}

stock KickEx(playerid)
{
	return SetTimerEx("KickTimer", 100, false, "i", playerid);
}

forward KickTimer(playerid);
public KickTimer(playerid) { return Kick(playerid); }
