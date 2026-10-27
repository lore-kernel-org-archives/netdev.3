Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=210.61.82.184
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793091002;
	b=SytIYv7KObKZXDp4RN9gpBAEQWrGXoIyKMQjhdtsuCip3tASnZ0lNDdjHsX1QyTvw9v9
	 rbl4iSYBHdLCuNWcFr5WR764/kvQNhKdMjmCE/QyyOfyPS7Vi9XqdQHFTXVEowkEmuWpb
	 WjLSBxNpUBBX9ac7KvDNsyNyQi1myw0CtxdC/CzrmrgzpfoRt52JThreO0N8ZweIM0KtJ
	 5sPJhQ3rJj3p0RNKlh25P93nmPlxl89/+A2DfjhDwu86KkxGco00ee6iOeIRt2QEr40w1
	 9IYVYF651+L+UkQcNi+rn4jhbiPUy0Q6/Dq2nRs6znlhdAfBHkXnHeGSp+nCjF1gixw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091002;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Zqi1vnxLsdODna0mHKLoPKsyLxI4sMmwzoKJ7ku/mLo=;
	b=lI5cJUhWoEEoT4vxOhP5QtlPxuEqEIHVHa/NDuLHgcNJoVUFWMOD1XCB8UhjBzkRTD1E
	 9oPMSIbbA9XFZ6Z6nDOhMSpJQPKvBS+Y0bD3ffe0dEBAhQSiVNqrIszL/9EQl1AFWLvKt
	 PNrfj2fUi9BuUigLanr0is1FLli/t0lL0M8B8CB93hyNEZ91LPBNH2SMTm7OYcszOQrzx
	 tZ2uAw6E4IYNGov4Wqm87o4bmAgvntuZ8MXe0+b6U76UxlPdnI3O/Et0JptTHOTi4Y14k
	 2Y6jkID68w8PPaw9P3jFLi+kcJOVl8oOgIeWbOcTXjrVz9AtctWPPecAjNgp9oHu4bA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=airoha.com;
	spf=pass smtp.mailfrom=airoha.com;
	dkim=pass header.d=airoha.com header.i=@airoha.com header.a=rsa-sha256 header.s=dk header.b=mLWpAKsW;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=KgDItyuk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93176606A321;
	Tue, 27 Oct 2026 08:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93176606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=airoha.com header.i=@airoha.com header.a=rsa-sha256 header.s=dk header.b=mLWpAKsW;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=KgDItyuk
X-UUID: 6253538ad1e311f18dc8c9802ae25ab1-20261027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Zqi1vnxLsdODna0mHKLoPKsyLxI4sMmwzoKJ7ku/mLo=;
	b=mLWpAKsWZaG1d3ABHyPrc4nDIuNtIfUtNp2wK4+Fbbbi4tnw/Y6B5cDSDAOeUclKkrv7jpuLsob9qw/eL+F2gcux7D7KfM0F/Y4EGOyMvGGT2e+rE3h2HvsRRpWny4Cc7Op1rivvAot0axi7Mtem2z8kcmTihgXd31CT93q/i/o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:0976076d-6689-48a9-a40a-485f0b09c165,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:291e20b,CLOUDID:3672713d-7132-4bd9-9ada-f79a4f8833bf,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6253538ad1e311f18dc8c9802ae25ab1-20261027
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <weiting.lee@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1550016170; Tue, 27 Oct 2026 16:49:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 27 Oct 2026 16:49:55 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 27 Oct 2026 16:49:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voUUgXaCQMvBCMpq4j27bDbyaG4Y4NbNMwwZfBII9ZsSp3/MEmNvk4kZ2rLbUqQn6ffgmwxI1zi2k5LX/oqlCcGNWKIrU8j8Ya4PpDObOmWh25ytqcFCCrjj7oRr+r4uc9DX7rqclz64xGjI4EGPSa3GDi6t+nlcgyJKA6nkt4DH/hDEjMyMqjkA4tnCJvsKSK5i3yjIkW848O/vI+xK89jangdqyVWSk43KoGatXQBML+fFdT1cKbcZ9pFo7Wi4YQ9rCvDgTGPh/lc55qPEa4OAWPxEEm70Do+tU0/LDzGY55xzW5LZE9Gyva/dZ0JZlWji7kqDssvK3ZuGszIKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqi1vnxLsdODna0mHKLoPKsyLxI4sMmwzoKJ7ku/mLo=;
 b=BkOO3Kg3b7ItuXopImVLepp9IIprXp0hopOmhFnwuY9X0LAKBz/TOmsKyJmplTFFnOKv+M47s6nQtOi2bKDzoPD9askPYeZl5yTgNm6CJmoX155xTLLCWCgpQo8lxw0tQ3+DOHZdxthXHhWMMUoyjhX/JySqz7JMfG1cxfk3AjW0G0qbdg/d64jWj7jyCmkVaHuNV9uaB1j/yMhomtmdKyBUpileLELIqAoU5SFD+go4rlsIR7I8GbFAWOWLRWxTLE37KfrijNWQTs5GMkegaK1Yk2k0uFXMduwaNCLIl8iOBdQh9FBFpgeZaNPJBNCySBufSPidPuU7mcAgvVmKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqi1vnxLsdODna0mHKLoPKsyLxI4sMmwzoKJ7ku/mLo=;
 b=KgDItyukHKQciyw1aT6czMOaEktryABQRC7dRRiLI3oC/wMk6s303L1nUjBIDtebaYfTy9oU9GPWa6W3KhcM6hoHLJO/FSnJLa/YzsIpfXprDtZuNXyujHwS3+enefEn+LKhzZVGCBPy/JDe/ZnIA+P7+spAUVXY7aTBghp3KpE=
Received: from SEZPR03MB7899.apcprd03.prod.outlook.com (2603:1096:101:185::14)
 by SEYPR03MB7535.apcprd03.prod.outlook.com (2603:1096:101:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:49:51 +0000
Received: from SEZPR03MB7899.apcprd03.prod.outlook.com
 ([fe80::504:b6df:9e2:87e]) by SEZPR03MB7899.apcprd03.prod.outlook.com
 ([fe80::504:b6df:9e2:87e%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:49:51 +0000
From: =?big5?B?V2VpVGluZyBMZWUgKKf1q8K+Xik=?= <weiting.lee@airoha.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bjorn@mork.no" <bjorn@mork.no>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>, "frank-w@public-files.de"
	<frank-w@public-files.de>, =?big5?B?Sm9zZXBoIExpbiAoqky9q7fXKQ==?=
	<Joseph.Lin@airoha.com>, =?big5?B?V2Vuc2hpbiBDaHVuZyAowemw3axQKQ==?=
	<wenshin.chung@airoha.com>, =?big5?B?THVjaWVuIEpoZW5nICi+R7K7tnYp?=
	<lucien.jheng@airoha.com>, =?big5?B?QWxiZXJ0LUFMIExlZSAop/WuYae7KQ==?=
	<albert-al.lee@airoha.com>
Subject: Re: [PATCH] net: phy: air_en8811h: add dedicated suspend callback for
 AN8811HB
Thread-Topic: [PATCH] net: phy: air_en8811h: add dedicated suspend callback
 for AN8811HB
Thread-Index: AQHdRkLyZL/VE+g59U6bl2Fs6feVyrbSAwGAgD8ouRU=
Date: Tue, 27 Oct 2026 08:49:51 +0000
Message-ID: <SEZPR03MB7899D16736B1D8F171C7FF3884602@SEZPR03MB7899.apcprd03.prod.outlook.com>
References: <20260917012102.3103131-1-weiting.lee@airoha.com>
 <d9ec8019-0603-4884-9bbc-d20153dba204@lunn.ch>
In-Reply-To: <d9ec8019-0603-4884-9bbc-d20153dba204@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7899:EE_|SEYPR03MB7535:EE_
x-ms-office365-filtering-correlation-id: fd064909-7fc4-4b1f-6cc9-08df3407438d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|261026121527099003|22082099003|10067099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: ksKQP3bPLkY/BywfDGuV2iMACfXK8buI6km3c0ZtyuOgROQujxxDeQSfprB/JigxvJjE9JRtaCY+kRu/0IMxVguZv/PLUg1F+wk3T20DiowGujP4eBnYlV8EbXVZEBN5YTl/xq5Q0iLGknB89OzJjnykThHKgGPXlWI67rozxfh/YvxCmIHr9XfnGVe1065TSdc2hh8BcmwrDytQAaOnt2vZPQFuXQBM98h7r/SE/Ju2GsWYFCmA1ahMdTk/ZETKP/8uRee2FjDYUizg07HFlnFlq5c19E/cI0IJJl+5oPViJPH8tdmePqYkt35sN7LY789Qr78O4uGW8BISVTxvBTNhWThe6bbuOn5B55ktGL2cllqOqaz+pMPLer5/8wLVx1ZBU8UMdu9sxe4YE2kiGfTXBLyYoB0TI3shljT5mKyQkdodWpD/EOVC3R9n1ysDpptYbCA6io6QiHsXkYTiQVth/smBNhhxwAFp0/ckqCWIFtV/3Q+aHhCXKG43t6a313pb2LvyOWKxDaV7MD5dwu9kX8zhkuK3aGWJ+YCkicgh8LeQ1QKG7YGuUg2RYvmRthjMzyYEE55t3O9g8Cu6x8b+3TolVnZ4JnYGYGYaclI20mTEP2iuH1rzCiYNeFqSruIoH73upMJVIfXTpYbfWSYxzP2FEV5w6gpgsuLCEwEOq9FZzc9VUqjy37/g2qsYcSTP6xkjsIweGQOxDck7gCCcDzG6ejmY0PHqvcl/JfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7899.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(261026121527099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?cElNNXpLTHNGazd5YzF3OTdYN1RIS3I2R240N0xjWmd2aTBDYXd6NE5oR1RPd0Q0?=
 =?big5?B?MjFmMERaMFc4WkoySWpxV3U3QzMzWkgxQlk2OW9aSzB0UElYWUx6emtaUmhBUWpI?=
 =?big5?B?amd3VHZYanhuZVpmTnJhQ3pvUTZMTWtLOWFNWXZua1RHM2gzd29UcGxMbWJreXV2?=
 =?big5?B?dU5PNDV3UWFEdnBZQnQ5VlFBNk9MSmExNHFMem1sWTVWR0FSek9OL01oY0xQL1F6?=
 =?big5?B?c0RiSTZrWG5Ed2hTTUtUcTdmdHowQ2F4bW03c0Z1V3hQZytnVHBJRmhrdzFsNURG?=
 =?big5?B?MFpkVnRLSEZEZHRhMDlnYytHYk9lWnBxQzN5cGdLVFBFZ2pUR2Z1TUFvZ1lJSDQ4?=
 =?big5?B?QU9uRmloM2tQUmhHMWpvL29CcGlHWitqUkdCVGtDdlBJc2tQbk50T2ZveUlCZEUr?=
 =?big5?B?OXRQWHppUXA0TWd6Nm5KTm9hTXZTUFF0VEt5WnpvNVJUQmZDL1U5WFBXVU4vZkw2?=
 =?big5?B?dzB6Rzh6ZmFaTHUvZGNWYWhaMnUyUWJ3NEZtL2pmQmJMaFJoRVF6WEgrOHp0Wjc1?=
 =?big5?B?RWNyejF0M0xSR05pNnA5bnk3M3g0TzRuUGFkbzhKUDVJRVJqWk5SaEZZYUF2dWhy?=
 =?big5?B?S3JhTjFMVHcyMmZxanlDUFFHYnBqbGEzdnBleThRZEJ1MEhlMlNuWVZvbThpdVJu?=
 =?big5?B?SWdGdmoxaVJBUm5EUVpLclE3eXhwak1BTFJNRm8vUnRYTVRqcFFITTF6YmVLR1Q3?=
 =?big5?B?S284WHU0WTdXU1F6cWgxV25xcUxpTjFxRk13UlRodUQ4aXRYVVp3TE9uc3JJZFNL?=
 =?big5?B?Mjh4L1JROUF4Sm5xdTZRejlDTkwyM3BPdkxaQThMNGpwTlpFVXU1NVNXbUYzMHpU?=
 =?big5?B?bzJuWXpwQjc5UXAxVUN5L0FCQWVGenk1VE5oSmQ1Mmg0bkVLSmZlWm9XaG1UZDBx?=
 =?big5?B?SURMellHYWxQNUNMT0JaVG1va0xzaDlGRVlVRmJmaVhEK0xUd2tQU1p0bnk4VS9n?=
 =?big5?B?V054Y1Fua3cxNFB0S3FRSmNlbXlOSWptQlE2T2hsNHRmOTBHZU8rb0hvVVJ2OHl2?=
 =?big5?B?d1NxaFZVclB1ZDZvRlRPamZrTXFFbTEvVmRibld5dThGNnlDeWFvR2pLMmpERG5X?=
 =?big5?B?V0FvSjk5QkRzU0kzNXRuc1Jkc0pBWTdlenZmNFJuZUlSd0Z1amNCRmpEbUIvK2Ey?=
 =?big5?B?K0V6R2tsWVZTRUtqRkFocFYwT2VpV1l4VVg3KzhWdktJZ1F4QWNuOFMraG50Z1RQ?=
 =?big5?B?c050QTRNWVM2a2hEc21paVF5WExRRndCWUxydkpLL0dWTy9NMC92L2VIN3QxUG9j?=
 =?big5?B?QXNpUUpjT2R4WFhVUmZReGxrRFhrd3YwL0dtZnNzb2lvZDBET0ZVRFdvWGZhcFl6?=
 =?big5?B?NC9HUGFsMXg2dkJ1dGJLWnQ4T1E1UmUzZGxZKy9YcFB1N29TTit6aWMrRjJDL2U4?=
 =?big5?B?bXEvQUhRSlF5cnFpd1pKSEc4NmY3T3BUano5M3RBK2QwUFp3TGxLa2JSTXkvQmlO?=
 =?big5?B?WUJackthU1R0azFPWEdaZmRuYmJJUVJpV3NpdVdRQUk1VERUbzhYSWR4elN4dDJa?=
 =?big5?B?SmJUR2tVbkpvNFlONkxKMDQvNjlmVEs4RDU4ZndKb25wZUQwaXlkMitFZ2pFL0dL?=
 =?big5?B?Q1pVdmE2aEdxRmZzM2x0b29vdUQ1YW5icFhxMEJnN0ZiUEc3M1g4YzdEWnJ6ZGtJ?=
 =?big5?B?UnFJOHp0QWUzNkpWSCtYNmkxUmV6MFF4SjdxWDBNbE9KMndNdEl2eW9RTlFIV1hv?=
 =?big5?B?MjVVNFJwK0Rtb1VxZEQ0VER6ekpUd3h5Z0Z4dGZmL1FHUzIwSGJ1YTA5SFVTOTV2?=
 =?big5?B?RW05S0pkR2MrQmwwbGhGdmpLb3F5N3RzRHdrK052TVhpT2pOTjl6TlpQQ0tPc2pD?=
 =?big5?B?eUtjQnhBNXU5NFZsYXRyVk9nRmNHaTgwSHhpNWFOQVpQblMxd1ZNNi94ZDY2dVZn?=
 =?big5?B?dk1ROVNQWk9LVnZtdkVTTkdmRTNYbzQrK2Vnb0tDeS82YStlWXdSVmIzeWxXQldS?=
 =?big5?B?c2VpallLaTdybnlDeUd6WnI4eFVlL1dObUxvQ2tzL1JIQ2htVUVOWnRReGR1TkJl?=
 =?big5?B?RzJxOStPR2xPU1kxWGp3bzlleWZqRjkzc0lST3kwdm93ZjBTWUVYQ3JOWU5UQ2pm?=
 =?big5?B?YXdoUTd1MytNV1BQZjJyZm1RMjJxOEx6VlROclB1UEZXMXh4dVFNWmwxd0dyamI1?=
 =?big5?B?aVN4MURGRjRxaUUvc1FBRHZTTXhndmh2cWZpWUplVjZmQVprdEh2RzVhSDljaU5O?=
 =?big5?B?RnEwSmR5OSt0Zkh2VUhzL3J0OW54UT09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kLXF0KOxUcztaKj2/q+ieYlHKp6ZM2KriYvK2KA/7RgoQNpgW+rwV30wJb/kzN4rc0s1T+MSqFrF2kICks94zwGFajQsQKOZH2FYdqeB7OpzMrHmO1KuSiTkYNXz7LE4mt3nawSt5UuKFZv7OCQGF5cVLD56Mo0v3Fteg6scRSaMx8QHrF6GWC2IzLOlnsRzZEpJFbyNTAhGyrXQXmF8YzGWhqNEdWVNpR3WM5jFzjM+Tdr124g2MY4ZmSfk2k/QnjYBhw8o3PlHHG1QQABg24f1jNQnvfyoDO+nfx7Ue6m7QyH7XBuEi3lbS8VT2xe0t+Busu2QphhhoMR78Jp53Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7899.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd064909-7fc4-4b1f-6cc9-08df3407438d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 08:49:51.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+GUNU5zNEO4PzuOwdO5uTKSlhlE4twhxM9ruib+ElqlDYYBpBgVjimzU+q5hFtnkWYB1K47s0rDS8txyf/L3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7535

SGkgQW5kcmV3LAoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIG5lZWQgdG8gY2hlY2sgdGhpcyBp
bnRlcm5hbGx5LCB3aGljaCB3aWxsCnRha2Ugc29tZSB0aW1lLiBJIHdpbGwgY29udGludWUgd2l0
aCB0aGUgb3RoZXIgcGF0Y2hlcyBpbiB0aGUKbWVhbnRpbWUuCgpUaGFua3MsCldlaXRpbmcKCk9u
IFRodSwgU2VwIDE3LCAyMDI2IGF0IDA5OjU2ICswODAwLCBBbmRyZXcgTHVubiB3cm90ZToKPiA+
IFRoZSBBTjg4MTFIQiBoYXJkd2FyZSByZXF1aXJlcyBhIHJlLW5lZ290aWF0aW9uIHNlcXVlbmNl
IGJlZm9yZQo+ID4gZW50ZXJpbmcgcG93ZXItZG93biB0byBjb3JyZWN0bHkgcmVzdG9yZSB0aGUg
bGluayB1cG9uIHJlc3VtZS4KPiA+IEFkZCBhbjg4MTFoYl9zdXNwZW5kKCkgdG8gaGFuZGxlIHRo
aXMuCj4KPiBJcyB0aGVyZSBhbiBlcnJhdGEgZm9yIHRoaXM/IFBsZWFzZSBtZW50aW9uIGl0IGlu
IHRoZSBjb21taXQgbWVzc2FnZS4KPgo+ID4gK3N0YXRpYyBpbnQgYW44ODExaGJfc3VzcGVuZChz
dHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQo+ID4gK3sKPiA+ICsgICAgIGludCByZXQ7Cj4gPiAr
Cj4gPiArICAgICBjbGtfc2F2ZV9jb250ZXh0KCk7Cj4gPiArCj4gPiArICAgICByZXQgPSBwaHlf
bW9kaWZ5KHBoeWRldiwgTUlJX0JNQ1IsIDAsIEJNQ1JfQU5SRVNUQVJUKTsKPgo+IFdoeSB1c2Ug
cGh5X21vZGlmeSgpIGlmIHlvdSBhcmUgZ29pbmcgdG8gcGFzcyBhIG1hc2sgb2YgMD8KPgo+ICAg
ICAgICAgQW5kcmV3
