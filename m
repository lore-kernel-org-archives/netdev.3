Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A136C0AC;
	Mon, 24 Aug 2026 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558477; cv=fail; b=X0Y3dyewj2dDOlFMzJi7nste+Hbz14IhpxSeKOevT3ajZlh8eEXEWKQvbJE4b0IEpwvPHBGzIe/3emqVMSdV22BXGgNfPOOJKOVwP55yQoMbeaVSxE1JzOJjHh5a9u7JJ2QbmJpdXT270GuyJjb9KAC4BsxmbS/MLNXLAdHGrps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558477; c=relaxed/simple;
	bh=HcTUqiNyqPc0WqonE/Mmg/JegHqAuA8/+F4ZBIGRXvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6qjLCTYrcNiI9nOYivujAHlnux7vN4taINfLriMQte/FLF9OJVqM1ha7ul0j8Jnkyw5Pz1ZwlXAkDpLBVYJ/et7FGhmx5kcZ3wV9bE3xCJF0rpHpLbRncAFIpgXj+02oXZvyhLiW5aERf2iG061FfjAHHUqtFSutvG3GwckpUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Cb3cf+Z3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rUEMnbXI; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Cb3cf+Z3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rUEMnbXI"
X-UUID: f2e5ab489f9111f1b1788b6acf885367-20260824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HcTUqiNyqPc0WqonE/Mmg/JegHqAuA8/+F4ZBIGRXvM=;
	b=Cb3cf+Z33cFInjRVpm8R3ZVo0h+cAI0JwDPYeiLS/EP4uMmzxKpBEI4aVvGuZ5KjBvPBMhQ9H8M7jnajmc/NqNqzzyt0GekUChvo+8Et094pr6th6885JhL5ZzjfQKYJ9mTLvBWlotwhxCBHgbq1AqTgJbE3TGDNZPk5/MKC6Ik=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7133835f-e572-401e-8800-4ef634a93440,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:2f69cbe2-71f1-405e-92eb-6802d6af74fd,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
	:-5,Content:0|15|51|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
	nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f2e5ab489f9111f1b1788b6acf885367-20260824
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <rex.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 700420822; Mon, 24 Aug 2026 16:01:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Aug 2026 16:01:01 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 24 Aug 2026 16:01:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/zz8lqYG+RfDm+oQoa4yYqf+GAGX4hBb6nsvp6nYMaqcapknGLU1kxrVgYv9po6uTZ0dT2gaJnn3EhZx289CkVgDLynCZGgYFGT6n1fvI6wwiFtVZKZKwJqh48AnihKEOvYD5FJw4hF7ajPxTR1WSNtTT752IVKNca7wCSr23Bh7ZONRueqznBSZU8/+lULI76M4mRT7WT20INyJyOajkqUF2neSjWIi6daY2PtC2o9tHQUmzNFrOcwRVLPv436aFVUHD3zb6nQWIvTpl5FUdPPWxFu09lx9Vw04SixBjlOIC0914wR4GwHpvCnPdO8ICS+kXNt3m33IKSYuiXtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcTUqiNyqPc0WqonE/Mmg/JegHqAuA8/+F4ZBIGRXvM=;
 b=BMdjJPOQk9ZPhfOYQhfthj4A80D6cNAfoHpRm4kF83Ym6Kaw9DYBsERccRe1MF0bzcvO4g6OLJKYuCgoft5sxrVqry45WFpUjvmTsVjxEuRfPcAp2lyONO6ilzNBjcpzsPlzm5IoAsiTDbI4fnBjS62xgNXc2LnLWmLVnNCL5IgKh7ocxTgeR/JrV1anTFH5HHfNyZkMHAh7KBOYj2kgJSs0N11YQ5EDOByyY641ksDsjN2H7w+TL8ouO4+f4k2/V9u/A89rU/dEriBCIxjWtO2brU24fw8SyMWoZI8pc34+vJ3HQ4eXJGy4lNufiJCWFJ2bF4pEGkTb/6QtKNpP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcTUqiNyqPc0WqonE/Mmg/JegHqAuA8/+F4ZBIGRXvM=;
 b=rUEMnbXIPPESiyYev9nyh7KPoIiFAkQZ7uDvrVxV5TCEMGY+foMAjw3MldPeRgXk8k5x6H2knL//Va6X/8mbAEq9yvuifuWwh7SyR3g11DCW0auYD5A0+gJ99ffSYkWDdc0K6v51wpRt6yZn6LihslmjNlNbBP5UPiyjIfMH9/U=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 SEYPR03MB6795.apcprd03.prod.outlook.com (2603:1096:101:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 08:00:54 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::42a2:bb5:d1fd:3ac6]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::42a2:bb5:d1fd:3ac6%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:00:54 +0000
From: =?big5?B?UmV4IEx1ICi/Y6vYu8op?= <Rex.Lu@mediatek.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: Shiji Yang <yangshiji66@outlook.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: =?big5?B?pl7C0DogW1BBVENIXSBuZXQ6IGV0aGVybmV0OiBtdGtfd2VkOiBpbmNyZWFzZSBX?=
 =?big5?Q?ED_v2_WDMA_RESV=5FBUFF_to_0x80?=
Thread-Topic: [PATCH] net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF
 to 0x80
Thread-Index: AQHdMc7z2xMCKWyxjkee1QJbfSjYYrapw4UAgAMSxICAAAIE8g==
Date: Mon, 24 Aug 2026 08:00:54 +0000
Message-ID: <SI2PR03MB55456905E3D6E84E2337F6ADF3A02@SI2PR03MB5545.apcprd03.prod.outlook.com>
References: <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
 <20260821174121.326f3c49@kernel.org> <aoljUFw-rQTLDXg0@lore-qca>
 <aov3TTKBZ68yl50k@lore-desk>
In-Reply-To: <aov3TTKBZ68yl50k@lore-desk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|SEYPR03MB6795:EE_
x-ms-office365-filtering-correlation-id: ff66c7b1-9f82-47c7-3d4d-08df01b5d2b0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: PQVEU4flY27F4dkaTZKbPAVS9KD4JQpZ1EsGVgjeHyLi6k6eGG8wditsHBo7NUjSET67vycACnCTqSRnDm5PVSm4t2dCu84AbNta1zdFvjIAWOuQPOAX6enWV/NBS6exxk7uu8Zqj0Pk97GS9FTd3PixAwCsu50BtVhshU2yZWQEEcR6JckC8BxUPj9hA4IIsbUxYJ24L3Q1BYWPKxyZSGIlvNkAoIecX9JKWB5w3FoAdOlMGIbirNK7qPUsMVBMzipEmj4JwzT8vUIdbdREno2iWgj3jmc+WbFZxjBd49yqGRLSLtdoyfZpVA7hLg15gV4wlNrXLk7zBXESRBjNGRCw7i749JFqEuCer3WQ6JfEA9kEfD5yzTVp6CM+Oaz6VfQubg+1v+pcu9cjNHT7HMLn7zrvc0TG5GgJYjrtI91R/+b5NdAvUa0f5LQIbtUQebOPTf7+5rTTTjlRVNfyA1kjH2llLmCnZVdgukwjp+AR1ZFrZjsM3HTYOzLG8aEc1jiihjgwiq4oEMbYMfi1nKO30YHLuAO8QHcterbrlUHKYwpwlE6D4WBWrhk6lSqqmD7dFvAbaJ+9U9PiBE8QlF5z8XK93z518xR/WLU0tkYZMZ8Vn3MD97rGrLhPZ2F5qH/npFwr3wpFj2FSrtEf29PLBSdageaHcGleVkPY9XIPdJ+SlzpbCD2UzmJa8LuzuoslvkjHB5H3x/oefDuEG4I5/lQGQFgt+2bzD4EGxmA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?WlJJZzZCVnhVS3EwbDAvMzhMMFJQbDZyeURJMTFZV0c2bDl4WmlVaC9jeWpvU1Rp?=
 =?big5?B?a2hVWnpBaUNBaGVoU0FtMyt0cGZKVzh5enVtRDZ2WHkvOVA2M2Y2R2F0cGdaZk1t?=
 =?big5?B?T0pLeXFhczF1a0FJUXFreGJRUWlDcGtvSHRDcjQrMDM0T3pFcWpiY2lobEN2U0Jm?=
 =?big5?B?L1A5aGE0UUtHNnFTUFZ0MVJ6aGVreFJGQ1g1ck5OTGdPSm5oUXFTMGxBWEJ2SnNW?=
 =?big5?B?emtKZlJTeTV0RmdXZjZJRnhjL3hvUVNhZ2FodFR1NmRCQmg1UUJHSG1xZElJTjI1?=
 =?big5?B?cytrUXZBV2RKeW54NTRtK2FtV3NsUjU2MzV2amRhOW4xeWJYeXpRSjgzdVNqd2JF?=
 =?big5?B?TjFjSlFqNEVvTEYyVHhCRDlHSmp5NVN2SUxtdEZaa3kzb1g0ZmVOc0w4QXUxRWlv?=
 =?big5?B?amhDVnM4SmVCZk13TVU4STMrc3VUcG9HMzdmdVg0U0o4cUVrWjQ1dHBRalVZWDJt?=
 =?big5?B?R0xYMHhkMloxMWZXMkhpLytrQ1dSK1htU25adVQrclNTeEV6V2YyRHhlR3J5OW13?=
 =?big5?B?a2gveFpDc2dnRGRZYXdRelJ6RWlDSDF3a2RWRCt6b0xVYzlTdEZTakg0d0RIeURn?=
 =?big5?B?Y1EyZUZ6NWdsVnN4VnVHTnZzMXhMZWRkbmJOVU01dXFidG91M21GeEpja2g1eGhW?=
 =?big5?B?QU5vUmNaODRpN25pZ093VWNVcnp3RC9FbmdES243bys2UkVuUlIzZkZBbVhtUGw4?=
 =?big5?B?RFYrNTVvaUFTd0V3WXRTaUVNMElsL0ZpU0FtVXZlN1A2amRzclNWZEJXTTczTFMx?=
 =?big5?B?a2l1NUdEdk5XcWYxR1cwZFhNUGZWTDJOY2NRZ3p4d2ZCaUtIZjJTbVpUVHlXYitW?=
 =?big5?B?YlIwOTNZaHljMDNobzJrc2ZRaDdrRnVOMUxyRnJRQjNMVnhEMGZXR0NBYi9ob1pz?=
 =?big5?B?cEZvVFRiV3oxbDh4VkVOYU42blQ4TEp5MUZJeUxpRFdhWDl0emllOWFUc3dXeDdo?=
 =?big5?B?cDdWSHNtL255MnFkRWRxQ1YveCtmbkJNSE0wYlpyc3V0dTJyRjBCWHNkMEFMZUlX?=
 =?big5?B?UW16YVZDZUxUTkprRzVROFJmTXJydTlZaTlydW9DV0ZUaXhVajMwL1EvRTBndTRH?=
 =?big5?B?eStFYzdsdE01azZvQkprVWR6RVB3di9KTGpnU3NMTllrNU9Cd21Rb0NLL0JIL3Y4?=
 =?big5?B?VC9yeldnRS9nR2RwRzJRbkEvb240VUxMbUx2RGNoMlRCZ0ZlSnp1Tms4WnpPeEJs?=
 =?big5?B?MlRldlo2ejh4Wk9YZEUwOEpwT3JrbWlZRmhuQ1hpUHNaMzNaZXNDWnVtWFc1SzRj?=
 =?big5?B?eWp6SGg2bzlDdkpFTFF2OHdCK0VTaUgxS0lQeGVnUzM3QTExWFFLSGpoMHl4RkVl?=
 =?big5?B?dWUycURJN2E4ZFl6VFZTTzI4ZFZlRlZobU5FbHYvcCszN3hZT1NhRHhwSjF0SE9P?=
 =?big5?B?aHZEWm9mUVpEaTUyWnFyQm5UTVZSZFlXZDg0aUFDbTRDNEZDUy9WZnNOVndrUVFm?=
 =?big5?B?VW8vS1licUE0cEtiY2NhRzFmZ3E3T2lvSFpNdlhJSXhiTjN3WlB1aUZDQkUxa1Y1?=
 =?big5?B?emZpSURreGUwTW1ERWQzbDJGSnpQWXBWMitaRlI2YWVZc3REM1hEdFRkbW9Oendu?=
 =?big5?B?by9MSDd1OW9NSzN2WXhJVnZXMHh2dzZmNjlwMEtETHVyWGJzc2ZGckVhNVgycEhC?=
 =?big5?B?cW1JZDlxMThTeXdOUjR1dmc3ZHRVcEx1NzdFMFpvOG5ybGRxcTVGSklvaUIxN0o0?=
 =?big5?B?QUdsUitkM0JXZlkveTlhRThQRjdNdXFXNEFaZ3B2U2R0ZjhnV1hzbjNXa2NlYXN5?=
 =?big5?B?OU9JeHYxK2NuaGhYVzlzczRXWFJVUTR6cktaREt5eUpVQ2NtUXBvaldmZFlZVytQ?=
 =?big5?B?aVBHVmJ1SUliSVhvMGxmTjMyRWphSDNnaTM1SG1rdU8vZjdwcVVCZEtiekMvTytu?=
 =?big5?B?V2plUWxVMTFFQWtSM2M4TXp1b0VnV1BEeGFTYTMvbmptQkFMMzlpN0RqVEpocUs4?=
 =?big5?B?THh4c0dJUWtuUk1JZis1ZVpnQVNpdWdBL09jd1VuTUlhOE9wM2RJd3krUmFNdUhh?=
 =?big5?B?eVpFdlR4ZVNCUHhWa1k5N0Z5SFRSYkxwaW14UjFnTEFkVFgzaGVmN0NCVkdlWVpI?=
 =?big5?B?T0M2MFNrWU9pblFxbnBpRmlSSExIZVJsWmFzdGRLRlJod25iT2g0UHN3UnYvaWdq?=
 =?big5?Q?KMp7JgrgJ0SURMj6dxWBeQzn+9sXndbcchgQAscBpXp2qFFw?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VcMfKN/FMgE6PuH4A33gy6QN0gzuSzh6EGOU2B0sDK36TJXyiDzPjob9iwDZQ1+xv8fyhTQUBUcdFjVVNPnqEix6T3ry7dx0nlqP2fNCvtAnuvWyAnWDq4c9iGZ9vJZHLirUf0D1VKHuvu0Jzvuhc8mAXlzEzRkvByZzFDX2KIcYjOmwIO131xMKweznjfkONq9N6OF6Xh33xfHssHR8JHcPrD1D55C19YTstQCcRgbiigplGuXmpRq/TvoSPq9pGLWFsCLNcF3tWSpFubL3XiOpozGBo/vdc+BbcnG1XMEAHNhnj6Y76ZEmFV/e7BxhbybMd+YYEEjRRbjTnN9OTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff66c7b1-9f82-47c7-3d4d-08df01b5d2b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 08:00:54.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4/e5gL+hZpnO3JcC5/uTRBDXfUrXNmiDH+8tKo+2AW3vZRoxcgG8LYFZV3NwzWhB/JMM3wELlf2lQGxT7fjHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6795

SGkgTG9yZW56bywKCiAgICBpdCBpcyBvbmx5IGZvciB2Mi4gIHYzIGNoYW5nZWQgdGhlIGh3IGRl
c2lnbiBhbmQgZml4ZWQgaXQuICBzbyB0aGlzIFJFU1ZfQlVGRiByZWdpc3RlciB3YXMgcmVtb3Zl
ZCAgCgpUaGFua3MKUmV4IEx1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KsUil86rMOiBMb3JlbnpvIEJpYW5jb25pCqR3tsewZTogrFC0waRALCAyMDI2IKZ+IDggpOsg
MjQgpOkgIKRVpMggMDM6NDgKpqyl86rMOiBKYWt1YiBLaWNpbnNraQqwxqW7OiBTaGlqaSBZYW5n
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBSZXggTHUgKL9jq9i7yik7IEZlbGl4IEZpZXRrYXU7
IEFuZHJldyBMdW5uOyBEYXZpZCBTLiBNaWxsZXI7IEVyaWMgRHVtYXpldDsgUGFvbG8gQWJlbmk7
IE1hdHRoaWFzIEJydWdnZXI7IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcKpUSmrjogUmU6IFtQQVRDSF0gbmV0
OiBldGhlcm5ldDogbXRrX3dlZDogaW5jcmVhc2UgV0VEIHYyIFdETUEgUkVTVl9CVUZGIHRvIDB4
ODAKCj4gT24gQXVnIDIxLCBKYWt1YiBLaWNpbnNraSB3cm90ZToKPiA+IE9uIFdlZCwgMTkgQXVn
IDIwMjYgMjE6MDc6MDcgKzA4MDAgU2hpamkgWWFuZyB3cm90ZToKPiA+ID4gQ2hhbmdlIFdETUEg
UkVTVl9CVUZGIGZyb20gMHg0MCB0byAweDgwIHRvIGF2b2lkIENETSBUWCBGSUZPIG92ZXJmbG93
Lgo+ID4gPiBXaXRob3V0IHRoaXMgcGF0Y2ggbXQ3OTg2IGFuZCBtdDc5ODEgbWF5IGhhdmUgV0RN
QSBUWCBoYW5nIGlzc3VlLiBUaGlzCj4gPiA+IHBhdGNoIHdhcyBwdWxsZWQgZnJvbSBtdGstb3Bl
bndydC1mZWVkcyBHUEwgb3BlbiBzb3VyY2UgcHJvamVjdC4KPiA+Cj4gPiBMb3JlbnpvLCBjb3Vs
ZCB5b3UgVEFMPyAoaW5jbC4gU2ltb24ncyBzdWdnZXN0aW9uIG9mIHRoZSBGaXhlcyB0YWcpCgpJ
IGFtIHdvbmRlcmluZyBpZiB0aGlzIGlzIG5lY2Vzc2FyeSBmb3IgdjMgYXMgd2VsbC4KQFJleCBh
bnkgaW5wdXQgb24gaXQ/CgpSZWdhcmRpbmcgRml4ZXMgdGFnLCBJIHRoaW5rIGNmMjZkZjg4MzNj
YyBpcyB0aGUgcmlnaHQgb25lLgoKUmVnYXJkcywKTG9yZW56bwoKPgo+IHN1cmUsIEkgYW0gQUZL
IG5vdywgSSB3aWxsIHJldmlldyBpdCBuZXh0IHdlZWsuCj4KPiBSZWdhcmRzLAo+IExvcmVuem8K
Cgo=
