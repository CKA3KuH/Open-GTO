/*

	About: admin click system
	Author: ziggi

*/

AdminClick_OnGameModeInit()
{
	// moder
	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_KICK_DIALOG_HEADER",
	              "ADMIN_CLICK_KICK_DIALOG_MESSAGE",
	              "ADMIN_CLICK_KICK_DIALOG_BUTTON_KICK", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	              PlayerPrivilegeModer,
	              "AdminClick_KickPlayer");

	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_MUTE_DIALOG_HEADER",
	              "ADMIN_CLICK_MUTE_DIALOG_MESSAGE",
	              "ADMIN_CLICK_MUTE_DIALOG_BUTTON_MUTE", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	              PlayerPrivilegeModer,
	              "AdminClick_MutePlayer");

	Click_AddItem(DIALOG_STYLE_NONE,
	              "ADMIN_CLICK_UNMUTE_DIALOG_HEADER",
	              "",
	              "", "",
	              PlayerPrivilegeModer,
	              "AdminClick_UnMutePlayer");

	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_JAIL_DIALOG_HEADER",
	              "ADMIN_CLICK_JAIL_DIALOG_MESSAGE",
	              "ADMIN_CLICK_JAIL_DIALOG_BUTTON_JAIL", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	              PlayerPrivilegeModer,
	              "AdminClick_JailPlayer");

	Click_AddItem(DIALOG_STYLE_NONE,
	              "ADMIN_CLICK_UNJAIL_DIALOG_HEADER",
	              "",
	              "", "",
	              PlayerPrivilegeModer,
	              "AdminClick_UnJailPlayer");

	// admin
	Click_AddItem(DIALOG_STYLE_NONE,
	              "ADMIN_CLICK_INFO_DIALOG_HEADER",
	              "",
	              "", "",
	              PlayerPrivilegeAdmin,
	              "AdminClick_InfoPlayer");

	Click_AddItem(DIALOG_STYLE_NONE,
	              "ADMIN_CLICK_KILL_DIALOG_HEADER",
	              "",
	              "", "",
	              PlayerPrivilegeAdmin,
	              "AdminClick_KillPlayer");

	Click_AddItem(DIALOG_STYLE_NONE,
	              "ADMIN_CLICK_TELEPORT_TO_DIALOG_HEADER",
	              "",
	              "", "",
	              PlayerPrivilegeAdmin,
	              "AdminClick_TeleportToPlayer");

	Click_AddItem(DIALOG_STYLE_NONE,
	              "ADMIN_CLICK_TELEPORT_HERE_DIALOG_HEADER",
	              "",
	              "", "",
	              PlayerPrivilegeAdmin,
	              "AdminClick_TeleportToMe");

	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_HEALTH_DIALOG_HEADER",
	              "ADMIN_CLICK_HEALTH_DIALOG_MESSAGE",
	              "ADMIN_CLICK_MESSAGE_BUTTON_CHANGE", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	              PlayerPrivilegeAdmin,
	              "AdminClick_SetHealth");

	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_ARMOUR_DIALOG_HEADER",
	              "ADMIN_CLICK_ARMOUR_DIALOG_MESSAGE",
	              "ADMIN_CLICK_MESSAGE_BUTTON_CHANGE", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	              PlayerPrivilegeAdmin,
	              "AdminClick_SetArmour");

	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_LEVEL_DIALOG_HEADER",
	              "ADMIN_CLICK_LEVEL_DIALOG_MESSAGE",
	              "ADMIN_CLICK_MESSAGE_BUTTON_CHANGE", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	               PlayerPrivilegeAdmin,
	               "AdminClick_SetLevel");

	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_XP_DIALOG_HEADER",
	              "ADMIN_CLICK_XP_DIALOG_MESSAGE",
	              "ADMIN_CLICK_MESSAGE_BUTTON_GIVE", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	              PlayerPrivilegeAdmin,
	              "AdminClick_GiveXP");

	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_MONEY_DIALOG_HEADER",
	              "ADMIN_CLICK_MONEY_DIALOG_MESSAGE",
	              "ADMIN_CLICK_MESSAGE_BUTTON_GIVE", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	              PlayerPrivilegeAdmin,
	              "AdminClick_GiveMoney");

	Click_AddItem(DIALOG_STYLE_INPUT,
	              "ADMIN_CLICK_FREEZE_DIALOG_HEADER",
	              "ADMIN_CLICK_FREEZE_DIALOG_MESSAGE",
	              "ADMIN_CLICK_FREEZE_DIALOG_BUTTON", "ADMIN_CLICK_MESSAGE_BUTTON_BACK",
	              PlayerPrivilegeAdmin,
	              "AdminClick_FreezePlayer");

	Click_AddItem(DIALOG_STYLE_NONE,
	              "ADMIN_CLICK_UNFREEZE_DIALOG_HEADER",
	              "",
	              "", "",
	              PlayerPrivilegeAdmin,
	              "AdminClick_UnFreezePlayer");

	Click_AddItem(DIALOG_STYLE_NONE,
	              "ADMIN_CLICK_NETSTATS_DIALOG_HEADER",
	              "",
	              "", "",
	              PlayerPrivilegeAdmin,
	              "AdminClick_GetNetStats");
}

static stock ShowErrorDialog(playerid, error_msg[])
{
	Dialog_MessageEx(playerid, Dialog:AdminErrorPlayerClick,
	                 _(playerid, ADMIN_CLICK_MESSAGE_HEADER),
	                 error_msg,
	                 _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK), _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_BACK));
}

DialogResponse:AdminErrorPlayerClick(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerClick);
	}

	return 1;
}

forward AdminClick_KickPlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_KickPlayer(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		players[MAX_PLAYERS],
		playername[MAX_PLAYER_NAME + 1],
		targetname[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, playername, sizeof(playername));
	GetPlayerName(targetid, targetname, sizeof(targetname));

	GetPlayerNearPlayers(targetid, 40.0, players);
	Lang_SendTextToPlayers(players, $ADMIN_COMMAND_KICK_PLAYER, playername, playerid, targetname, targetid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_KICK_PLAYER_SELF), targetname, targetid);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	KickPlayer(targetid, inputtext);

	return 1;
}

forward AdminClick_MutePlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_MutePlayer(playerid, targetid, listitem, inputtext[])
{
	new
		time;

	if (sscanf(inputtext, "k<ftime>", time)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TIME_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		timeword[MAX_LANG_VALUE_STRING],
		playername[MAX_PLAYER_NAME + 1],
		targetname[MAX_PLAYER_NAME + 1];

	Declension_GetWord(timeword, sizeof(timeword), time, _(playerid, DECLENSION_SECOND_4), _(playerid, DECLENSION_SECOND_2), _(playerid, DECLENSION_SECOND_3));
	GetPlayerName(playerid, playername, sizeof(playername));
	GetPlayerName(targetid, targetname, sizeof(targetname));

	Lang_SendTextToAll($ADMIN_COMMAND_MUTE_PLAYER, playername, playerid, targetname, targetid, time, timeword);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_MUTE_PLAYER_SELF), targetname, targetid, time, timeword);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	MutePlayer(targetid, time);

	return 1;
}

forward AdminClick_UnMutePlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_UnMutePlayer(playerid, targetid, listitem, inputtext[])
{
	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		playername[MAX_PLAYER_NAME + 1],
		targetname[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, playername, sizeof(playername));
	GetPlayerName(targetid, targetname, sizeof(targetname));

	Lang_SendTextToAll($ADMIN_COMMAND_UNMUTE_PLAYER, playername, playerid, targetname, targetid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_UNMUTE_PLAYER_SELF), targetname, targetid);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	UnMutePlayer(targetid);

	return 1;
}

forward AdminClick_JailPlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_JailPlayer(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		time;

	if (sscanf(inputtext, "k<ftime>", time)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TIME_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		timeword[MAX_LANG_VALUE_STRING],
		playername[MAX_PLAYER_NAME + 1],
		targetname[MAX_PLAYER_NAME + 1];

	Declension_GetWord(timeword, sizeof(timeword), time, _(playerid, DECLENSION_SECOND_4), _(playerid, DECLENSION_SECOND_2), _(playerid, DECLENSION_SECOND_3));
	GetPlayerName(playerid, playername, sizeof(playername));
	GetPlayerName(targetid, targetname, sizeof(targetname));

	Lang_SendTextToAll($ADMIN_COMMAND_JAIL_PLAYER, playername, playerid, targetname, targetid, time, timeword);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_JAIL_PLAYER_SELF), targetname, targetid, time, timeword);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	JailPlayer(targetid, time);

	return 1;
}

forward AdminClick_UnJailPlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_UnJailPlayer(playerid, targetid, listitem, inputtext[])
{
	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	if (!IsPlayerJailed(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_JAIL_BAD_TARGET));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		playername[MAX_PLAYER_NAME + 1],
		targetname[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, playername, sizeof(playername));
	GetPlayerName(targetid, targetname, sizeof(targetname));

	Lang_SendTextToAll($ADMIN_COMMAND_UNJAIL_PLAYER, playername, playerid, targetname, targetid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_UNJAIL_PLAYER_SELF), targetname, targetid);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	UnJailPlayer(targetid);

	return 1;
}

forward AdminClick_InfoPlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_InfoPlayer(playerid, targetid, listitem, inputtext[])
{
	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	static
		message[MAX_LANG_VALUE_STRING * 6 * MAX_PLAYER_INFO_LINES];

	message[0] = '\0';

	new
		string[MAX_LANG_VALUE_STRING],
		account_info[e_Account_Info],
		player_info[MAX_PLAYER_INFO_LINES][MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		year,
		month,
		day;

	Account_GetData(targetid, account_info);
	GetPlayerInfoArray(targetid, player_info, sizeof(player_info[]), playerid);
	GetPlayerName(targetid, targetname, sizeof(targetname));
	account_info[e_aPlayedSeconds] = Account_GetCurrentPlayedTime(playerid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_GETINFO_PLAYER_HEADER), targetname);
	strcat(message, string);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_GETINFO_PLAYER_IP), account_info[e_aIP]);
	strcat(message, string);

	gmtime(account_info[e_aCreationTime], year, month, day);
	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_GETINFO_PLAYER_CREATION), day, month, year);
	strcat(message, string);

	gmtime(account_info[e_aLoginTime], year, month, day);
	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_GETINFO_PLAYER_LOGIN), day, month, year);
	strcat(message, string);

	gmtime(account_info[e_aPremiumTime], year, month, day);
	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_GETINFO_PLAYER_PREMIUM), day, month, year);
	strcat(message, string);

	GetTimeStringFromSeconds(playerid, account_info[e_aPlayedSeconds], string);
	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_GETINFO_PLAYER_PLAYED), string);
	strcat(message, string);

	for (new i = 0; i < sizeof(player_info); i++) {
		__(playerid, ADMIN_COMMAND_GETINFO_PLAYER_PREFIX, string);
		strcat(string, player_info[i]);

		strcat(message, string);
	}

	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), message, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	return 1;
}

forward AdminClick_KillPlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_KillPlayer(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	SetPlayerHealth(targetid, 0.0);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_KILL_PLAYER), playername, playerid, targetname, targetid);
	SendMessageToNearPlayerPlayers(string, 40.0, targetid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_KILL_PLAYER_SELF), targetname, targetid);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	return 1;
}

forward AdminClick_TeleportToPlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_TeleportToPlayer(playerid, targetid, listitem, inputtext[])
{
	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	TeleportPlayerToPlayer(playerid, targetid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_TELEPORT_TO_PLAYER), targetname, targetid, playername, playerid);
	SendMessageToNearPlayerPlayers(string, 40.0, targetid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_TELEPORT_TO_SELF), targetname, targetid);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	return 1;
}

forward AdminClick_TeleportToMe(playerid, targetid, listitem, inputtext[]);
public AdminClick_TeleportToMe(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	TeleportPlayerToPlayer(targetid, playerid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_TELEPORT_HERE_PLAYER), playername, playerid, targetname, targetid);
	SendMessageToNearPlayerPlayers(string, 40.0, targetid);

	return 1;
}

forward AdminClick_SetHealth(playerid, targetid, listitem, inputtext[]);
public AdminClick_SetHealth(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		Float:amount;

	if (sscanf(inputtext, "f", amount)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_HEALTH_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	SetPlayerHealth(targetid, amount);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_HEALTH_SET_PLAYER), playername, playerid, targetname, targetid, amount);
	SendMessageToNearPlayerPlayers(string, 40.0, playerid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_HEALTH_SET_SELF), targetname, targetid, amount);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	return 1;
}

forward AdminClick_SetArmour(playerid, targetid, listitem, inputtext[]);
public AdminClick_SetArmour(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		Float:amount;

	if (sscanf(inputtext, "f", amount)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_ARMOUR_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	SetPlayerArmour(targetid, amount);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_ARMOUR_SET_PLAYER), playername, playerid, targetname, targetid, amount);
	SendMessageToNearPlayerPlayers(string, 40.0, playerid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_ARMOUR_SET_SELF), targetname, targetid, amount);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	return 1;
}

forward AdminClick_SetLevel(playerid, targetid, listitem, inputtext[]);
public AdminClick_SetLevel(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		amount,
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	amount = strval(inputtext);
	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	if (!IsValidPlayerLevel(amount)) {
		Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), _(playerid, ADMIN_CLICK_LEVEL_ERROR), _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));
		return 0;
	}

	SetPlayerLevel(targetid, amount);

	Lang_SendText(targetid, $ADMIN_COMMAND_LEVEL_SET_PLAYER, playername, playerid, amount);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_LEVEL_SET_SELF), targetname, targetid, amount);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	return 1;
}

forward AdminClick_GiveXP(playerid, targetid, listitem, inputtext[]);
public AdminClick_GiveXP(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		amount,
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	amount = strval(inputtext);
	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	GivePlayerXP(targetid, amount);

	Lang_SendText(targetid, $ADMIN_COMMAND_XP_GIVE_PLAYER, playername, playerid, amount);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_XP_GIVE_SELF), targetname, targetid, amount);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	return 1;
}

forward AdminClick_GiveMoney(playerid, targetid, listitem, inputtext[]);
public AdminClick_GiveMoney(playerid, targetid, listitem, inputtext[])
{
	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	new
		amount,
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	amount = strval(inputtext);
	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	GivePlayerMoney(targetid, amount);

	Lang_SendText(targetid, $ADMIN_COMMAND_MONEY_GIVE_PLAYER, playername, playerid, amount);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_MONEY_GIVE_SELF), targetname, targetid, amount);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	return 1;
}

forward AdminClick_FreezePlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_FreezePlayer(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		time;

	if (sscanf(inputtext, "k<ftime>", time)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TIME_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		timeword[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	Declension_GetWord(timeword, sizeof(timeword), time, _(playerid, DECLENSION_SECOND_4), _(playerid, DECLENSION_SECOND_2), _(playerid, DECLENSION_SECOND_3));
	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	Lang_SendTextToAll($ADMIN_COMMAND_FREEZE_PLAYER, playername, playerid, targetname, targetid, time, timeword);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_FREEZE_PLAYER_SELF), targetname, targetid, time, timeword);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	FreezePlayer(targetid, time);

	return 1;
}

forward AdminClick_UnFreezePlayer(playerid, targetid, listitem, inputtext[]);
public AdminClick_UnFreezePlayer(playerid, targetid, listitem, inputtext[])
{
	if (IsPlayerHavePrivilege(targetid, PlayerPrivilegeRcon) && !IsPlayerHavePrivilege(playerid, PlayerPrivilegeRcon)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_PRIVILEGE_ERROR));
		return 0;
	}

	if (!IsPlayerConnected(targetid)) {
		ShowErrorDialog(playerid, _(playerid, ADMIN_CLICK_TARGET_ERROR));
		return 0;
	}

	new
		string[MAX_LANG_VALUE_STRING],
		targetname[MAX_PLAYER_NAME + 1],
		playername[MAX_PLAYER_NAME + 1];

	GetPlayerName(targetid, targetname, sizeof(targetname));
	GetPlayerName(playerid, playername, sizeof(playername));

	Lang_SendTextToAll($ADMIN_COMMAND_UNFREEZE_PLAYER, playername, playerid, targetname, targetid);

	format(string, sizeof(string), _(playerid, ADMIN_COMMAND_UNFREEZE_PLAYER_SELF), targetname, targetid);
	Dialog_Message(playerid, _(playerid, ADMIN_CLICK_MESSAGE_HEADER), string, _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK));

	UnFreezePlayer(targetid);

	return 1;
}

forward AdminClick_GetNetStats(playerid, targetid, listitem, inputtext[]);
public AdminClick_GetNetStats(playerid, targetid, listitem, inputtext[])
{
	new
		message[MAX_LANG_MULTI_STRING],
		ip_port[22];

	NetStats_GetIpPort(targetid, ip_port, sizeof(ip_port));

	__m(playerid, ADMIN_COMMAND_NETSTATS, message);
	format(message, sizeof(message),
	       message,
	       ip_port,
	       NetStats_GetConnectedTime(targetid),
	       NetStats_ConnectionStatus(targetid),
	       NetStats_PacketLossPercent(targetid),
	       NetStats_MessagesReceived(targetid),
	       NetStats_MessagesSent(targetid),
	       NetStats_MessagesRecvPerSecond(targetid));

	Dialog_Open(playerid, Dialog:PlayerClickNetStats, DIALOG_STYLE_MSGBOX,
	            _(playerid, ADMIN_CLICK_MESSAGE_HEADER),
	            message,
	            _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_OK), _(playerid, ADMIN_CLICK_MESSAGE_BUTTON_BACK));

	new
		timerid;

	timerid = SetTimerEx("AdminClick_GetNetStats", 2000, 0, "dd", playerid, targetid);
	SetPVarInt(playerid, "click_NetStats_TimerID", timerid);
}

DialogResponse:PlayerClickNetStats(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerClick);
	}

	new timerid = GetPVarInt(playerid, "click_NetStats_TimerID");
	if (timerid != 0) {
		KillTimer(timerid);
	}

	return 1;
}
