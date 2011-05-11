/*
 Created: 07.04.2011
 Author: ZiGGi
*/

#if defined _user_menu_included
  #endinput
#endif

#define _user_menu_included
#pragma library user_menu

#define user_menu_DialogID 998
#define vehicle_menu_DialogID 997

stock show_menu(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		return show_User_Menu(playerid);
	}
	else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		//return show_Vehicle_Menu(playerid);
	}
	return 0;
}

// MSG ������ ������������ � user menu
stock show_User_Menu_Dialog(playerid,string_0[],string[])
{
	return ShowPlayerDialog(playerid,1000,DIALOG_STYLE_MSGBOX,
		string_0,
		string,
		"�����","�����"
	);
}
//

stock show_User_Menu(playerid)
{
	return ShowPlayerDialog(playerid,user_menu_DialogID,DIALOG_STYLE_LIST,
		"���� ������",
		"���������� � ���������\n\
		��� �������\n\
		����� ������\n\
		��������\n\
		�������\n\
		��������� ������\n\
		������������� ������\n\
		����� � ��������������\n\
		���������\n\
		������\n\
		",
		"��","������"
	);
}

stock show_Vehicle_Menu(playerid)
{
	return ShowPlayerDialog(playerid,vehicle_menu_DialogID,DIALOG_STYLE_LIST,
		"���� ����������",
		"\n\
		\n\
		",
		"��","������"
	);
}

stock usermenu_OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	#pragma unused newkeys,oldkeys
	show_menu(playerid);
	return 1;
}

stock usermenu_OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
	#pragma unused inputtext
	switch(dialogid)
	{
		case 1000:
		{
			if(response) show_menu(playerid);
			else return 1;
		}
		case user_menu_DialogID:
		{
			if(!response) return 1;
			new string[1024];
			switch(listitem)
			{
				case 0: // ���������� � ���������
				{
					new vip_status[MAX_NAME];
					if(Player[playerid][VIPDate]) format(vip_status,sizeof(vip_status),"�� %s",Player[playerid][VIPDate]);
					else set(vip_status,"���");
					format(string,sizeof(string),
						"�������: %d, ���� �� ������: %d\n\
						\n\
						�����: %s, ������: %s\n\
						\n\
						������: $%d, ������ � �����: $%d, ����� �����: $%d\n\
						\n\
						�������: %d, �������: %d\n\
						�����: %d\n\
						�����: %d\n\
						\n\
						����� ������: %s\n\
						VIP ������: %s",
						Player[playerid][Level],
						GetXPToLevel(playerid, Player[playerid][Level] + 1),
						
						PlayerGangName[playerid],GetLevelName(Player[playerid][Level]),
						
						Player[playerid][Money],Player[playerid][Bank],GetPlayerTotalMoney(playerid),
						
						Player[playerid][Kills],Player[playerid][Deaths],Player[playerid][Jailed],Player[playerid][Muted],
						
						ConvertFightIdToName(Player[playerid][FightStyleUsed]),
						vip_status
					);
					return show_User_Menu_Dialog(playerid,"���������� � ���������",string);
				}
				case 1: // ��� �������
				{
					new count = 0;
					for(new id=0;id<MAX_BUSINESSES;id++)
					{
						if(!strcmp(Businesses[id][Business_Owner], oGetPlayerName(playerid), true))
						{
							count++;
							format(string,sizeof(string),"%s'%s' ������� ���������� $%d\n",string,Businesses[id][Business_Name],Businesses[id][Business_Vault]);
						}
					}
					if(count == 0) set(string,"�� �� �������� ������� ��������.");
					return show_User_Menu_Dialog(playerid,"��� �������",string);
				}
				case 2: // ����� ������
				{
					showFightStyleMenu(playerid);
					return 1;
				}
				case 3: // ��������
				{
					show_User_Menu(playerid);
					return 1;
				}
				case 4: // �������
				{
					SetPlayerHealth(playerid,0.0);
					return 1;
				}
				case 5: // ��������� ������
				{
					CheckPlayerLevel(playerid);
					return show_User_Menu_Dialog(playerid,"��������� ������","�� ����������� ���������� �� ����� ������.");
				}
				case 6: // ������������� ������
				{
					new idsa = 0,
						admins[MAX_STRING],
						moders[MAX_STRING];
					for(new id=GetMaxPlayers()-1;id>=0;--id)
					{
						if(!IsPlayerConnected(id) || IsPlayerNPC(id)) continue;
						if(IsPlayerAdmin(id) || IsPlayerAdm(id))
						{
							format(admins,sizeof(admins),"%s%s(%d)\n",admins,oGetPlayerName(id),id);
							idsa++;
						}
						if(IsPlayerMod(id))
						{
							format(moders,sizeof(moders),"%s%s(%d)\n",moders,oGetPlayerName(id),id);
							idsa++;
						}
					}
					if(idsa == 0)
						format(string,sizeof(string),"� ������ ������ � ���� ��� ���������������, �� ��� �� ������ ��� ��� �� ����� �� ���� ���������.");
					else format(string,sizeof(string),
						"�������������:\n\
						%s\n\
						\n\
						���������:\n\
						%s\n",
						admins,moders
					);
					return show_User_Menu_Dialog(playerid,"������������� ������",string);
				}
				case 7: // ����� � ��������������
				{
					show_User_Menu(playerid);
					return 1;
				}
				case 8: // ���������
				{
					show_User_Menu(playerid);
					return 1;
				}
				case 9: // ������
				{
					show_User_Menu_Dialog(playerid,
						"���������� � ������",
						"{AFE7FF}�� ������� �������:\n\
						\n\
						\t{FFFFFF}Open - Grand Theft Online {AA3333}"VERSION"{FFFFFF}.\n\
						\n\
						\n\
						{00C0DD}������� {AFE7FF}Iain Gilbert.\n\
						\n\
						{00C0DD}���������� {AFE7FF}Peter Steenbergen,\n\
									\t\tRobin Kikkert,\n\
									\t\tAsturel,\n\
									\t\tDmitry Frolov (FP),\n\
									\t\tOpen-GTO Team,\n\
									\t\tZiGGi.\n\
						\n\
						{00C0DD}Open-GTO Team: {AFE7FF}GhostTT,\n\
									\t\t  heufix,\n\
									\t\t  ZiGGi,\n\
									\t\t  Elbi.\n\
						\n\
						{00C0DD}��������� ������������: {AFE7FF}MX_Master(mxINI,Chat-Guard),\n\
						\n\
						"
					);
					return 1;
				}
			}
			return 1;
		}
		case vehicle_menu_DialogID:
		{
			return 1;
		}
	}
	return 1;
}