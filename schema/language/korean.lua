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

catherine.language.Merge( "korean", {
	// Basic
	[ "Basic_Schema_Title" ] = "하프 - 라이프 2",
	[ "Basic_Schema_Desc" ] = "이곳은 안전합니다.",
	[ "Basic_Schema_IntroTitle" ] = "2016 년, 18번 지구",
	[ "Basic_Schema_IntroDesc" ] = "이곳은 안전합니다.",
	[ "Basic_Schema_Author" ] = "%s 에 의해 개발 및 디자인.",
	
	// Cash
	[ "Cash_UI_HasStr" ] = "당신은 %s " .. catherine.configs.cashName .. " 를 가지고 있습니다.",
	[ "Cash_Notify_HasNot" ] = "당신은 충분한 " .. catherine.configs.cashName .. " 가 없습니다!",
	
	// Faction Name
	[ "Faction_Name_Citizen" ] = "시민",
	[ "Faction_Name_Administrator" ] = "관리자",
	[ "Faction_Name_OW" ] = "콤바인 군대",
	[ "Faction_Name_CP" ] = "시민 보호 기동대",
	
	// Faction Description
	[ "Faction_Desc_Citizen" ] = "더러운 옷을 입고 있습니다.",
	[ "Faction_Desc_Administrator" ] = "이 도시의 관리자 입니다.",
	[ "Faction_Desc_OW" ] = "콤바인에 의해 강제로 개조당한 기계 인간 입니다.",
	[ "Faction_Desc_CP" ] = "시민들을 보호합니다.",

	// Item
	[ "Item_Desc_Wallet" ] = catherine.configs.cashName .. " 가 쌓여있습니다.",
	[ "Item_FuncStr01_Wallet" ] = catherine.configs.cashName .. " 가지기",
	[ "Item_FuncStr02_Wallet" ] = catherine.configs.cashName .. " 떨어트리기",
	
	[ "Item_Name_LargeBag" ] = "큰 가방",
	[ "Item_Desc_LargeBag" ] = "당신의 인벤토리의 공간을 많이 늘려줍니다.",
	
	[ "Item_Name_SmallBag" ] = "작은 가방",
	[ "Item_Desc_SmallBag" ] = "당신의 인벤토리의 공간을 조금 늘려줍니다.",
	
	[ "Item_Name_CID" ] = "시민 아이디 카드",
	[ "Item_Desc_CID" ] = "당신의 정보를 보여주고 있습니다.",
	
	[ "Item_Name_PR" ] = "휴대용 라디오",
	[ "Item_Desc_PR" ] = "다른 사람들과 통신을 할 수 있습니다.",
	[ "Item_FuncStr01_PR" ] = "라디오 주파수 설정",
	[ "Item_FuncStr02_PR" ] = "전원 켜기/끄기",
	[ "Item_DataStr01_PR" ] = "주파수",
	[ "Item_DataStr02_PR" ] = "전원",
	[ "Item_DataStr02_On_PR" ] = "켜짐",
	[ "Item_DataStr02_Off_PR" ] = "꺼짐",
	
	[ "Item_RadioFreqQ_PR" ] = "라디오 주파수를 무엇으로 설정하시겠습니까?",
	[ "Item_Notify_FreqSet_PR" ] = "당신은 라디오 주파수를 %s 로 설정하셨습니다.",
	[ "Item_Notify_Error01_PR" ] = "라디오 주파수의 범위는 101.1 ~ 199.9 입니다!",
	[ "Item_Notify_Error02_PR" ] = "라디오 주파수 형식은 XXX.X 가 되어야 합니다!",
	[ "Item_Notify_Error03_PR" ] = "당신은 휴대용 라디오가 없습니다!",
	[ "Item_Notify_Error04_PR" ] = "휴대용 라디오의 전원을 키십시오!",
	[ "Item_Notify_Error05_PR" ] = "휴대용 라디오의 주파수를 설정하십시오!",
	
	[ "Item_Name_RD" ] = "신고 장치",
	[ "Item_Desc_RD" ] = "이것을 사용하면 콤바인에게 신고를 할 수 있습니다.",
	[ "Item_Notify_Error01_RD" ] = "당신은 신고 장치가 없습니다!",
	
	[ "Item_Name_SC" ] = "스프래이 캔",
	[ "Item_Desc_SC" ] = "누르면 페인트가 나와서 벽에다 그릴 수 있습니다.",

	[ "Item_Name_BW" ] = "브린 워터",
	[ "Item_Desc_BW" ] = "흔들어서 드세요.",
	
	[ "Item_Name_RBW" ] = "고급 브린 워터",
	[ "Item_Desc_RBW" ] = "흔들어서 드세요.",
	
	[ "Item_Name_GBW" ] = "최고급 브린 워터",
	[ "Item_Desc_GBW" ] = "흔들어서 드세요.",
	
	[ "Item_Name_9MM" ] = ".9mm 피스톨",
	[ "Item_Desc_9MM" ] = "기본적인 .9mm 피스톨 입니다.",
	
	[ "Item_Name_AR2" ] = "AR2",
	[ "Item_Desc_AR2" ] = "강력한 화력을 자랑합니다.",
	
	[ "Item_Name_SMG" ] = "SMG",
	[ "Item_Desc_SMG" ] = "기본적인 SMG 입니다.",
	
	[ "Item_Name_357" ] = ".357 매그넘",
	[ "Item_Desc_357" ] = "6발의 .357 매그넘 입니다.",
	
	[ "Item_Name_CB" ] = "크로스보우",
	[ "Item_Desc_CB" ] = "크로스보우 입니다, 반시민들이 사용합니다.",
	
	[ "Item_Name_Buckshot" ] = "샷건",
	[ "Item_Desc_Buckshot" ] = "산탄이 날라가는 강력한 위력의 샷건 입니다.",
	
	[ "Item_Name_RPG" ] = "로켓 런처",
	[ "Item_Desc_RPG" ] = "강력한 화력을 자랑하는 로켓 런처 입니다.",
	
	[ "Item_Name_CrowB" ] = "크로우 바",
	[ "Item_Desc_CrowB" ] = "녹슬어 보이는 이 도구에는 추억이 깃들어 있습니다.",
	
	[ "Item_Name_SS" ] = "전기봉",
	[ "Item_Desc_SS" ] = "사람을 때려서 기절시킬 수 있습니다.",
	
	[ "Item_Name_Ration" ] = "배급식",
	[ "Item_Desc_Ration" ] = "약간의 돈과 음식이 들어있습니다.",
	[ "Item_FuncStr01_Ration" ] = "개봉하기",
	
	[ "Item_Name_CitizenS" ] = "시민 보급식",
	[ "Item_Desc_CitizenS" ] = "시민들의 생계를 이어가기 위해 기본적으로 제공되는 보급식 입니다.",
	
	[ "Item_Name_Rebel" ] = "반시민 복장",
	[ "Item_Desc_Rebel" ] = "콤바인에 대항하여 싸우는 반시민들의 복장 입니다.",
	
	[ "Item_Name_RebelMedic" ] = "반시민 메딕 복장",
	[ "Item_Desc_RebelMedic" ] = "반시민들을 치료하는 메딕병 복장 입니다.",
	
	[ "Item_Name_Bleach" ] = "표백제",
	[ "Item_Desc_Bleach" ] = "치명적인 독성이 있는 표백제 입니다.",
	
	[ "Item_Name_ZT" ] = "수갑",
	[ "Item_Desc_ZT" ] = "사람을 묶을 수 있습니다.",
	[ "Item_FuncStr01_ZT" ] = "묶기",

	[ "Item_Category_Communication" ] = "통신",
	[ "Item_Category_Food" ] = "음식",
	[ "Item_FuncStr01_Food" ] = "먹기",
	
	[ "Item_Name_PistolAmmo" ] = ".9mm 피스톨 탄약",
	[ "Item_Desc_PistolAmmo" ] = ".9mm 피스톨에 들어가는 탄약입니다.",
	
	[ "Item_Name_AR2Ammo" ] = "펄스 에너지 카트리지",
	[ "Item_Desc_AR2Ammo" ] = "펄스 에너지가 카트리지 안에 들어있습니다.",
	
	[ "Item_Name_SMGAmmo" ] = "SMG 탄약",
	[ "Item_Desc_SMGAmmo" ] = "SMG 탄약이 상자안에 들어있습니다.",
	
	[ "Item_Name_SMG_G_Ammo" ] = "SMG 유탄",
	[ "Item_Desc_SMG_G_Ammo" ] = "SMG 유탄 입니다, 터지면서 피해를 줍니다.",
	
	[ "Item_Name_Buckshot_Ammo" ] = "샷건 탄약",
	[ "Item_Desc_Buckshot_Ammo" ] = "샷건 탄약이 상자안에 들어있습니다.",
	
	[ "Item_Name_Crossbow_Ammo" ] = "크로스 보우 탄약",
	[ "Item_Desc_Crossbow_Ammo" ] = "크로스 보우 탄약 입니다.",
	
	[ "Item_Name_RPGAmmo" ] = "RPG 로켓",
	[ "Item_Desc_RPGAmmo" ] = "RPG 로켓 발사기에 들어가는 로켓 입니다.",

	[ "Item_Name_357Ammo" ] = ".357 매그넘 탄약",
	[ "Item_Desc_357Ammo" ] = ".357 매그넘 탄약 입니다.",
	
	[ "Item_Name_CBAmmo" ] = "에너지 오브",
	[ "Item_Desc_CBAmmo" ] = "펄스 라이플에 들어가는 에너지 오브 입니다.",
	
	[ "Item_Name_Breach" ] = "문 돌파기",
	[ "Item_Desc_Breach" ] = "문을 돌파할 수 있는 기구 입니다.",
	[ "Item_FuncStr01_Breach" ] = "장치",
	[ "Item_Notify_ComLock_Breach" ] = "이 문에는 장치할 수 없습니다!",
	[ "Breach_BlastStr" ] = "문 돌파",
	
	// Radio
	[ "Item_Name_SR" ] = "고정식 라디오",
	[ "Item_Desc_SR" ] = "다른 사람들과 통신을 할 수 있습니다.",
	[ "Item_NoFreq" ] = "아직 주파수가 설정되지 않았습니다.",
	[ "Item_Freq" ] = "주파수 : %s.",
	[ "Item_FuncStr01_SR" ] = "라디오 주파수 설정",
	[ "Item_FuncStr02_SR" ] = "전원 켜기/끄기",
	[ "Item_FuncStr03_SR" ] = "라디오 장치하기",
	[ "Item_RadioFreqQ_SR" ] = "라디오 주파수를 무엇으로 설정하시겠습니까?",
	[ "Item_Notify_FreqSet_SR" ] = "당신은 라디오 주파수를 %s 로 설정하셨습니다.",
	[ "Item_Notify_Error01_SR" ] = "라디오 주파수의 범위는 101.1 ~ 199.9 입니다!",
	[ "Item_Notify_Error02_SR" ] = "라디오 주파수 형식은 XXX.X 가 되어야 합니다!",
	
	// Chat
	[ "Chat_Dispatch" ] = "콤바인 방송 - %s",
	[ "Chat_Radio" ] = "%s 님의 라디오 말 %s",
	[ "Chat_Request" ] = "%s 님의 신고 %s",
	[ "Chat_Breencast" ] = "브린 방송 - %s",
	
	// Basic
	[ "Basic_Notify_IsNotCombine" ] = "당신은 콤바인이 아닙니다!",
	
	// Combine Overlay
	[ "CombineOverlay_Str01" ] = "바이오 시그널을 기다리는 중 ...",
	[ "CombineOverlay_Str02" ] = "메세지를 번역 하는 중 ...",
	[ "CombineOverlay_Str03" ] = "주파수를 필터링 하는 중 ...",
	[ "CombineOverlay_Str04" ] = "시더 찾는 중 ...",
	[ "CombineOverlay_Str05" ] = "피어 찾는 중 ...",
	[ "CombineOverlay_Str06" ] = "CAT-이퀄라이제이션을 필터링 하는 중 ...",
	[ "CombineOverlay_Str07" ] = "네트워킹 메세지를 수신 하는 중 ...",
	[ "CombineOverlay_Str08" ] = "시타델 메세지를 등록 하는 중 ...",
	[ "CombineOverlay_Str09" ] = "유휴 상태 ...",
	
	[ "CombineOverlay_Request" ] = "%s 님의 신고 - %s",
	[ "CombineOverlay_HealthFullRecovered" ] = "체력 상태가 복구됨 ...",
	[ "CombineOverlay_TakeDmg_Local" ] = "경고 ! 물리적인 피해가 감지됨 ...",
	[ "CombineOverlay_TakeDmg_NoLocal" ] = "경고 ! 유닛 '%s' 가 알 수 없는 요인에게서 물리적인 피해를 입음 ...",
	[ "CombineOverlay_HealthRecovering" ] = "체력 상태를 복구 중 [%s] ...",
	[ "CombineOverlay_LocalPlayerDeath_CP" ] = "오류 ! 심각한 오류 발생 - ...",
	[ "CombineOverlay_LocalPlayerDeath_OW" ] = "심각한 오류 - ...",
	[ "CombineOverlay_PlayerDeath_CP" ] = "경고 ! 유닛 '%s' 의 신호가 소멸, 주의 요망 ...",
	[ "CombineOverlay_PlayerDeath_OW" ] = "경고 ! 오버와치 유닛 '%s' 의 신호가 소멸, 주의 요망 ...",
	[ "CombineOverlay_Online" ] = "온라인 ...",
	[ "CombineOverlay_RFCitizens" ] = "시민 리스트 새로고침 중 ...",
	
	// Attribute
	[ "Jump_Title" ] = "점프력",
	[ "Jump_Desc" ] = "높을 경우 높이 점프를 뛸 수 있습니다.",
	
	// Help Category
	[ "Help_Category_CombineVoice" ] = "콤바인 보이스",
	
	// Weapon
	[ "Weapon_Stunstick_Name" ] = "전기봉",
	[ "Weapon_Stunstick_Instructions" ] = "왼쪽 키 : 때리기.\n오른쪽 키 : 밀치기/노크.\nAlt + 왼쪽 키 : 전기 키기, 끄기",
	[ "Weapon_Stunstick_Purpose" ] = "사람을 때려서 기절시키거나, 문을 노크할 수 있습니다."
} )