Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010069.outbound.protection.outlook.com [52.101.228.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075832470E;
	Wed, 16 Sep 2026 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789526384; cv=fail; b=B2AKWFNiZSrz7QCbr1uyrRoHxIzv/fAETNKOqi45hv6xPf44mPIfpL2uYN+xoTeFz958p19SBq8t2Lql2e22zmb0HMJr93mTWEac7+ID/LVFaUpXN0+lGg7zo4MkuS9C4r0DRBia1BZRlidLVYvTjxiVksj/Bs/IwGZM9SpNUbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789526384; c=relaxed/simple;
	bh=ZQ6ijfmn/pAZbEsS1SCfvOqCtKeWx7ZcU1k2thi5RfI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b6UucbBLplEVzuakpbXZDHhf7fLLOQkOxcXSW4oIF/vS0P4n8lAApDCsKdce7djxbYbfC57utiCRxCtyBi0myeGjvmeSFg7DYJc7oRhUeZ6d3v9oYr/wBIyEm/ZZKTtwjHfMyWDtp+tGGFIVcdsICODIFKR+ghDRjfHoLCpgfHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=jUlQmUBX; arc=fail smtp.client-ip=52.101.228.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="jUlQmUBX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x47kXyYKEkhHvBQ8FJFBhEGQqxtvRFDMF0+5ucdAucdRzeb2jv0DCcyustVm9ad4ILHc63Y1InHM8OdNJ40Qu9uPkk5O7hLxJK4xjWpcy5OiASYlYd4W8wDcMf187dS6kb3OO0i9EF3I+rKde8kNPhg5Ue1VBWfiqKzB8yCDSoSaJPXjPPNHNUqM0koGdIVExWeHQNR66G4sLYw/xB9mue53hFQ0yaNOod9cTTSZ29fdoxT+4gnssy64c5Ew+hDtAWvDrvkJ6QRWq2A0yAyorGPihXnuN1faoVR6GqjnO9AyxNw+BbwOrB9empesZ9jdh/e7E2a110d5MWw3SrCA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ6ijfmn/pAZbEsS1SCfvOqCtKeWx7ZcU1k2thi5RfI=;
 b=qIsXO6Tc2Sv+HhFiDTw6Ld3KFVXITD1jHXRuEyNX3vXDaxSv87zEuTEz4TYuPi+XsQugQBxZE0Xp3+Gk1jOHd7nDt/pRtDdwGSiSdfyB1DSEmWlLdaYgHxZKm0EvVOtwc+ca11gMhjdTPPyNt2OjaIiKX2rRxSJFLma81W+HeGBLjvNBnNymYOe95gy1sbQ1+qzrJN4VUfiXBPK43oSZwnraMi6F+NL6Xuq8n2TaVuCGJJ/pp6X1lXzGewGwQDl2JRoMe3yBUVjPIfq5cjqxKGwttRh6ZgxtAOHYTwq8CemqRLuQuPtG5jmqu7/W92CVtDhdfHOrkdOLbz8YEPt5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ6ijfmn/pAZbEsS1SCfvOqCtKeWx7ZcU1k2thi5RfI=;
 b=jUlQmUBXaRSWxVuvTQ7wv838VRPq7xmViiurvfPNGiluQKUYFd8RL37OH/EfRvXehsF9CTOArV1NsQ2wHB0ais1YyxpPhysnXQBNnTA5raHJjkNCjAyqm9mEcyPK2XlvTMKHGiO9GMCFbGK+aE5ax58F4YFsrfbZc9ObPYhNJWM=
Received: from TYCPR01MB7481.jpnprd01.prod.outlook.com (2603:1096:400:f4::5)
 by TYYPR01MB12355.jpnprd01.prod.outlook.com (2603:1096:405:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Wed, 16 Sep
 2026 02:39:35 +0000
Received: from TYCPR01MB7481.jpnprd01.prod.outlook.com
 ([fe80::8071:f03b:77d1:aeaf]) by TYCPR01MB7481.jpnprd01.prod.outlook.com
 ([fe80::8071:f03b:77d1:aeaf%7]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 02:39:35 +0000
From: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshihisa
 Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
Subject: [PATCH net] net: pcs: rzn1-miic: Reset PRCMD state before unprotect
 sequence
Thread-Topic: [PATCH net] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Index: Ad1FhIqTpUP0rtxUTJWPkJgJUNHxrg==
Date: Wed, 16 Sep 2026 02:39:35 +0000
Message-ID:
 <TYCPR01MB748139F059DF2459B9813416A4B92@TYCPR01MB7481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB7481:EE_|TYYPR01MB12355:EE_
x-ms-office365-filtering-correlation-id: fee1b0ed-8e77-4dd0-a89b-08df139bbef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 DjX2xitDc3uZ0F3BfbDhqMvJWJoANZai7dFPX3FVG7s8wAxTXW0Gk6VkNCD+/fCU7W+KzKBDTIRHaFyVZHvqogHEKDBsWl0JDrUSLjFjhS+EODH1+Wg9rZ01uxaOU6cv58DiGIWh5UWeXx/BpLEfcAxIh333z9PNtmwKFE1h4mhq8ea/IAHF2sWfmyy3x6UTXuZgd006ya4Jw+uYLbUoLY8l2xKPo8W9+rlqhH52m0mV3IrsdvHYgOYz7/9nLt9WUtvAuBP0cPIepRcjw8CHXVimIYkRw4rOAUGO0ORYlEwPQ/HP0MH0wCIYoWTETH7KWiJedBtseGx0ZOhx4KS+mJ7/+/rvDASVBa+uAvUh+6UmCO6+1CATMi9gAkys11EJFSxwYM5jy0iHvLQfCX6bIadWvfpQCuOHHhYXmNIVH+IQRw0HgV+aZJT5EXkb4M2nABVv0B3drNz4BnZ8S0Gzk3rU6cYh+XHuwos/Tqi2m1fm85szgiRBrncvs52/ibb+uUOw++k77KUCrWS1uAiWtYHlVg41V0Fok0tG9Zd3BfvpZScKadHL9/zX9tVXx9QAL2leYlO2kUhOsWqCHymxvKtBjdE6LW5f2+t2m7WQN2l7/UfXA2yJpc6hIiaSpJSMCMmIJZbyyfpIoBfABMGyCTK63C3yARw46p2ALI5bFnM1F46cEEtbp18w0f185Se5rR4aYMBptZYG8l1q26pvzdSMeO52v9u+1lsR5hung+w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB7481.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEhmS282R09CUzBsckZVSmNKYkNxOHVrbkRNYmMrZmNuOFJxTUJSK0RpcXc0?=
 =?utf-8?B?U0NUM0FDMWtYeFdBZTcvUVo2V29NVUZWUTlROHZTcXRNNXdRaDlLazkydERH?=
 =?utf-8?B?aWpBV3NkUWdCcDZoUzJwQlZVWGNkdzl1ZVlqREtvbVErTG93UVBJRnBUUHZG?=
 =?utf-8?B?aVBtQ1I4ZFdhTG9ScmNqWmNpQ3hSd3hkZ0xaeEE0cG0zOUp4YXozMERRZ085?=
 =?utf-8?B?bC9DRTMyN3VkT1BXL3BSbXZjNEl4Zmh2T2xGOHJLTHp4NVExMi92RVl2MDBQ?=
 =?utf-8?B?TzM3RU52QkVmd2hHWTRQc1Bzbno1L1VUWFdoTjhMMXJJRkpLK0lzZm1hSy9X?=
 =?utf-8?B?azJwVVBwM3d5T0pWZ2FDd0VLeVVVNzRMWXhYTXZKNkErU1FhTDBOS0ErcDMy?=
 =?utf-8?B?dGVhTE8wTms3V1p2dmRZU0krYmpxUUZzOW1UV2Y5T1lOWXNqVUk5TW1BQUUv?=
 =?utf-8?B?ZmsrRU5hRVVqeFptWXFuT2gvUlI3bFIzNkRJeHk4aVpYVFhabnhicmYyaWsw?=
 =?utf-8?B?b2oxOFNCTU5TSmFJby9RQmJEeFVMclNYRy9qZE1DWkduekZ3NGZZMnVNK09r?=
 =?utf-8?B?K2MxVktUZUVPZURJSmZLS0ZOZnlpT0M0YjdCWkpyM0llYlBSWnZIRHluRUJy?=
 =?utf-8?B?Q1p0TkhsREFoK05Wei9xL04yVTFoZGhpb3BQNUVYYnJMWUpVYVYrVFMrb3Jx?=
 =?utf-8?B?YVozUGJLVWI1TmU2Nnh4MkI4TENPSmRpdmVGSERqbjRDd0dXenlVTEJqaTZI?=
 =?utf-8?B?WXVmeTRkd3pvZGlEbGpZYnFGU3lvZnJ2VStiWUM5REM2V1Z2M0pPemNReFYz?=
 =?utf-8?B?VnBWVmEwbXNCWVcwdkU1U2JWYkZxampMV2k3STdvUE9GWDdBN1dvazYveTJr?=
 =?utf-8?B?blladkRabG05YStVQ0JEcXpUTGNVdC9GaDZLUXJFVTlCYmFJSFJLblFQcHR2?=
 =?utf-8?B?TUdnL2JadnpHeVcra2ZtWCtQUlZ6WndraEtaS1UvMDVQRURSWDdCZ2Voc0c2?=
 =?utf-8?B?elFWSWh0elZJZEc5cWxFSGxsaGJPT0ZaVFVYc2NXT1I5U3JuRTZMVWZsZXZr?=
 =?utf-8?B?aEVsNGZoUDZEcVQ5Rk5mV0JzN3NUbFh3YXpqbGVDSmhmSStTb3pTRXllWmQv?=
 =?utf-8?B?R0NtQU42OHJFU0k4NUt4WUUxZE1jRXhMbUFpd014Z0FkQTBFZzRscXQ4WHRv?=
 =?utf-8?B?U2dCVkhzYUVkN09tdG1oWFFSelBsSnFwQUZEMGxPS3AvUUFtektYTEZ5L3lj?=
 =?utf-8?B?WVkrb2hrOFhvMFU5bWd0YUpXYkU1enNkSlFyTklBM3NwWDdWc2NmV01jUklY?=
 =?utf-8?B?cTJua3V0Q3JacDBlUTJ6M1c5Qkp4Vi8wTmZNeEZ6dXh5aEN0NXBuZ3RFNE9W?=
 =?utf-8?B?YmdrNXlJSjExSFY0KzhqQUZVQ1Z6YzNySEFCTFdZTmdlUVJJUkg5U1dXd3R1?=
 =?utf-8?B?YUQ2bEkzTFhqWXZuTDE5OUxkOXdiaFR5ckdseFBKV09MWjV5aHA2WjZwRFBj?=
 =?utf-8?B?ZW5KV3pxdElZMW5KeGNvTFhTWFE2Qk5Ld3JlUEtpMVExZjF4Z0o1ZVpOeFZm?=
 =?utf-8?B?dzdYczQvZWVvQSttWGRBbUJXVmpESngvRGpmWFBmL0poSU1JN1F3UURrdGY2?=
 =?utf-8?B?WDRmMk1sTTIxZjRJVkkxUzFaUkhDaForZTVVOW9JcjN4dmQvUUZaeDdONS9u?=
 =?utf-8?B?UjBoRU4yTFhwenVjWGREWmpMQWl1ZHJ5ay9vUmFTd1VZdDBHaVBCSlZ6cVBS?=
 =?utf-8?B?VkVYYUhvVnhrdjh3QVZDZ2pLMFZXam5ic2xqTWtkZk9oTFdzTyttT2RnZ0pC?=
 =?utf-8?B?bTk5Smt5WjhJRkE3U1RjTHZYR3VueGVuVTZnK09DRmV3U010bENZNXR3NjhT?=
 =?utf-8?B?bDg2MEN0WGdlR2p6dHdzekVaUUlKbWI3cFRRV1EwQ0dOWlVaYkNPUXV1Mjl4?=
 =?utf-8?B?Vk94Y1huN0I4V3NIdVhkSmtNSlVKQTEwOVQ1cEdVT3JRTHZoNVhpMWc2RnZo?=
 =?utf-8?B?VHdSbzVQUi96WXk2TWpXSG9ET3daeEZqYitIZVl3UXk2em51NlA3dWRUTXN5?=
 =?utf-8?B?QWx0c3NtZk9kTTV2ZVcvdGEveWZCMFFWRnN2VkJGOGwrTUU4TURmOW9sZ0Vy?=
 =?utf-8?B?OTc4aEc5YUN4WWd0V2tlRkdGVUlYalVsdThneThrdlN4aGhhOC9BdmlaYTdB?=
 =?utf-8?B?L1NhdzRMdWxOTXJLOVNqWDFIVUlUdDNLR1c4SzBuSWVMcTdzZ3hlam5rYUNh?=
 =?utf-8?B?eEllRml0NitscDFWamoyUkpKZTdXeitYLzhVSG90cklCRFJFKzZ2d0oySmJz?=
 =?utf-8?B?ZXZ1c1FJRGxCOElpTUdRVVlaMndtWWtsakZNMHZvZzZIdGM1Q01zNG1sZXJw?=
 =?utf-8?Q?vUL//DKYinNwepWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB7481.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee1b0ed-8e77-4dd0-a89b-08df139bbef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 02:39:35.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1KTaz/xUZo6NiBwtIegDckmfKE3j4QOS8zsyid2sFvU0VlYhQcIL52mqwJg3LGNFZsRa6lr48fBZGnQBcI1RyQ8we/M23vBZBqFUOoKDd0BPFkUBTFdqxvDXNu9yx1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12355

T24gUlovVDJIIE1JSUMsIHdyaXRpbmcgMHgwMDAwIHRvIFBSQ01EIHJlc2V0cyB0aGUgY29tbWFu
ZCBzdGF0ZQ0KbWFjaGluZSB0byB0aGUgSURMRSBzdGF0ZS4NCg0KUmVzZXQgUFJDTUQgYmVmb3Jl
IGlzc3VpbmcgdGhlIHVucHJvdGVjdCBzZXF1ZW5jZSBzbyB0aGF0IGl0IGFsd2F5cw0Kc3RhcnRz
IGZyb20gYSBrbm93biBzdGF0ZSwgcmVnYXJkbGVzcyBvZiBhbnkgcHJldmlvdXMgUFJDTUQgYWN0
aXZpdHkuDQoNClNpZ25lZC1vZmYtYnk6IFlvc2hpaGlzYSBZYW1hbW90byB5b3NoaWhpc2EueWFt
YW1vdG8ueG5AcmVuZXNhcy5jb20NCi0tLQ0KZHJpdmVycy9uZXQvcGNzL3Bjcy1yem4xLW1paWMu
YyB8IDMgKysrDQoxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9wY3MvcGNzLXJ6bjEtbWlpYy5jIGIvZHJpdmVycy9uZXQvcGNzL3Bjcy1y
em4xLW1paWMuYw0KaW5kZXggMmI3MmZhOThkLi44MTg3NTZiYjggMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL25ldC9wY3MvcGNzLXJ6bjEtbWlpYy5jDQorKysgYi9kcml2ZXJzL25ldC9wY3MvcGNzLXJ6
bjEtbWlpYy5jDQpAQCAtMjcwLDYgKzI3MCw5IEBAIHN0YXRpYyBzdHJ1Y3QgbWlpY19wb3J0ICpw
aHlsaW5rX3Bjc190b19taWljX3BvcnQoc3RydWN0IHBoeWxpbmtfcGNzICpwY3MpDQoNCiBzdGF0
aWMgdm9pZCBtaWljX3VubG9ja19yZWdzKHN0cnVjdCBtaWljICptaWljKQ0Kew0KKyAgICAgICAg
ICAgIC8qIFJlc2V0IFBSQ01EIHN0YXRlIGJlZm9yZSB1bnByb3RlY3Qgc2VxdWVuY2UgKi8NCisg
ICAgICAgICAgICB3cml0ZWwoMHgwMDAwLCBtaWljLT5iYXNlICsgTUlJQ19QUkNNRCk7DQorDQog
ICAgICAgICAgICAvKiBVbnByb3RlY3QgcmVnaXN0ZXIgd3JpdGVzICovDQogICAgICAgICAgICB3
cml0ZWwoMHgwMEE1LCBtaWljLT5iYXNlICsgTUlJQ19QUkNNRCk7DQogICAgICAgICAgICB3cml0
ZWwoMHgwMDAxLCBtaWljLT5iYXNlICsgTUlJQ19QUkNNRCk7DQotLSANCjIuMzQuMQ0K
