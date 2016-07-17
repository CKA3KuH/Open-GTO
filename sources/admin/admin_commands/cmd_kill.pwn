/*

	About: kill admin command
	Author: ziggi

*/

#if defined _admin_cmd_kill_included
	#endinput
#endif

#define _admin_cmd_kill_included

COMMAND:kill(playerid, params[])
{
	if (!IsPlayerHavePrivilege(playerid, PlayerPrivilegeModer)) {
		return 0;
	}

	new
		subparams[32];

	if (sscanf(params, "s[32]", subparams)) {
		Lang_SendText(playerid, $ADMIN_COMMAND_KILL_HELP);
		return 1;
	}

	new
		targetid = INVALID_PLAYER_ID;

	if (strcmp(subparams, "all", true) == 0) {
		targetid = -1;
	} else if (sscanf(subparams, "u", targetid) || targetid == INVALID_PLAYER_ID) {
		Lang_SendText(playerid, $ADMIN_COMMAND_KILL_TARGET_ERROR);
		return 1;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, playername, sizeof(playername));

	if (targetid == -1) {
		foreach (new id : Player) {
			SetPlayerHealth(id, 0.0);
		}

		Lang_SendTextToAll($ADMIN_COMMAND_KILL_ALL, playername, playerid);
	} else {
		GetPlayerName(targetid, targetname, sizeof(targetname));

		SetPlayerHealth(targetid, 0.0);

		format(string, sizeof(string), _(playerid, ADMIN_COMMAND_KILL_PLAYER), playername, playerid, targetname, targetid);
		SendMessageToNearPlayerPlayers(string, 40.0, targetid);

		Lang_SendText(playerid, $ADMIN_COMMAND_KILL_PLAYER_SELF, targetname, targetid);
	}

	return 1;
}
