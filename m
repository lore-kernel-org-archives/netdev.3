Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C34BFE90;
	Fri, 11 Sep 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157677; cv=fail; b=S1Tqgwa49aZoKk4Mvmpcz9G+dNSHchV/m2VBLEoqIUdrQQM0twg8wIQQNh6EsjZvzIygNGbpmS5XAbGAMyL69lpK9lwpGXN3xU05ZTHLyyqdDErKcO7ONjzbKPTu/DwvV5g+wlTDAbSLyGfyc+IRcKO/+F2Gq50vXwvi0Oi7v64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157677; c=relaxed/simple;
	bh=qwGgASt8bDSGtk7QzlsvI0JnOARB0gEZ2TxGQoVGzIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhcXq+DUOO4pbIT28eFJfsWGvOAyhdip4+au8p/B1iZ1HnQf8rkDzrWfP96BIcSov3VucOpq95rrJhvTyu0fewW4Vlhc6RPml0xl4v60zmcoCZkzBABFR3rIoA9vK9eub3MA1O5Hy8P32VHawPD7YIQZQKlPFOBnZoneCdjm5U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jg3j+X+J; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jg3j+X+J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+gSFj8sBoLgpCWydP92PSpyT6VKDJAES/XKLxVHeeI5M2DhY4jr6KAcK6zp8yzhejVA+MD3wkCq5ViLJIjBkSUzj8bEDDJLGIWYhTWZHnzqN5AEcSuxtYHF544KtVzi+WWCV9lt1IwMNjG3qMy45SFTlVHJI1KZvhROkfB8x9r2tx5AdVFua3ZxoR1vmgB6Uf4hlCocM/oV2YRvFu1dh+v2t0e0lF+EOWbXjr4wRfZirC8frjHSQRJMlBJuV5CCyFZxtcNmkqooTDP1e5tB93vT5Wi3w9/scDL8QQj0qIfzf9ikrePAMTOuLoXP7i6ZJMxR7EI0hCgVUX5Aqtk4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwGgASt8bDSGtk7QzlsvI0JnOARB0gEZ2TxGQoVGzIw=;
 b=YTEDOVVaPiXAvjZOwhqJ06+VafLQW0LWhSUJKh/Gkaz9gSUkMFfxMCDg3kiIR7clp0gT8Vwsyq7Tj88v8poG+fMWhJGGG3lLWL6tuVzYsf4+SbcHTcCyB3qIgmxAIiZfeFD0csWJZaohyuUmHeL3PcdCR0wsmeUiuh9nxNW5Qc7GbRjvKPdDHTLUoKjlEW/Ev3P8LV7INQMRpxu75Ahs3PFCGw5Z5MLtY7C19q7XdAiBOxOhn58U7S0WQwZbZfcF25Tvadh+V0lIQh23Nw6rWlO4ZfnqU8avz+II6FA7sWT+UrpBH+rQSMHEj6mWQQSucY5YUDWqhPYqnYJrRa/sZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwGgASt8bDSGtk7QzlsvI0JnOARB0gEZ2TxGQoVGzIw=;
 b=Jg3j+X+J7jckvydNF4ZRo8fs1E9Y5y1cKl7lJCR+Pj53tCHJFB+OZbO9EWijo+6K2sQX/pPn8DV+Xou7TjKNPVqe7W/0e5V/AaSGEVpvp3G58DYcyp5U6nle04c/tEjCS29+ZIxPwtCppgwDxdAneNqvjOvqMPfGjKD/M6qFdtBc1DXT9bkbN04nfi0NdKWc/24KcB+NAHLk8s/pTPeu9bleOzLz7+X/OkGHrtwxv7X96BhCzTHweORwF+kxRe+e3vmux9KW8y6Lp7viIU/SeO/y6MzxIXZgB9Y9Lx3oCQgHcZ67Zkgeg0kifc1FpVWstKrH8nWukRcx6VPsaHPN2g==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by DBBPR04MB7946.eurprd04.prod.outlook.com
 (2603:10a6:10:1ec::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 20:14:31 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:14:30 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: Wei Fang <wei.fang@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 02/15] net: enetc: move msg_task and
 msg_int_name to struct enetc_si
Thread-Topic: [PATCH v4 net-next 02/15] net: enetc: move msg_task and
 msg_int_name to struct enetc_si
Thread-Index: AQHdQEb3+NzSVUZTW0udeDj6jLXPILbJxLXA
Date: Fri, 11 Sep 2026 20:14:30 +0000
Message-ID:
 <GV2PR04MB11740974117468CACCD5B556296BE2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
 <20260909100733.1139689-3-wei.fang@oss.nxp.com>
In-Reply-To: <20260909100733.1139689-3-wei.fang@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-11T19:20:40.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|DBBPR04MB7946:EE_
x-ms-office365-filtering-correlation-id: a6ee3aaf-51f0-4074-4ad4-08df104149ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|56012099006|4143699003|38070700021|10067099003|921020|11063799006;
x-microsoft-antispam-message-info:
 UHuq2O6BSYu4B0PG2bmcejo6myxHR5he5O54dcXq4PWqtQIAtGQBsfI0E2GdY1ooLIFeKVNnLLFR+SMIE4hvX95duggWN4oRnhgMq67thj4OiYnEr54K7j4OJTydZdmIJ2voiJcvOdktFmfTASuC9kYwmdnMxlkdXZNg50plWGev3BmrWahepEW3FJ0Mtzn80XcGDeVZbVfwYbocJlHrbjztLN4J/hf9BpsVZxiH+UPyOhUWaxQU3GHLM8uOry/jXXiJE84dO3JiY4fwG7XkXwsQyHstY46RY5HVXivIf0fDAqU9M1PtUn4c4/Gp8WOWb+Ii46X74mWZJD+W5wWWMwjhC/ZKXs0KKapGMijIOi3idO+dVElY6yA4Za0roZTQsIzgqmIMBtc9mPACjX1gharRahbCiVyXfEiWhkrT1R11zZb3+D7yJW/mhREKlXPrILFckQat623F0tG9T9TAUOvVLqhgL4sTNKMRZkrzoKhH64QSpnDjuPqz+SInj7QEwFbUR9krHhsjgjXQJSMjoInJIGcLwgUqWEgyTtj1jtifFw4Rmg0cSGWFLF2rPo6McSyvRY7OKJB/1RG9MwZQkjoTsJvS52h6zqlCiPQpKiQMYGEaAVBZF3U9+rYj+HxSU+kQ9+dzeJgVFiRsYHe5emdwAk1cegidSJOq4yEn0nFJrI/ecGJkkcD7qZRHEUi1Sw6gd28O9qJ409EExJzgDzoNEkEH5ABxhf7ptyiKfSRHpci9Bxm56J+Xr+TvjE+k
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(10067099003)(921020)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFBucm16RlZaNXNGRytoUXFrakd5NmVtL2RvOWRjdjM0M2taZW5LMjhERjg3?=
 =?utf-8?B?K21WRWdjVDRVcnR5eG1FWHZ6Q0ttb3NaRi9IbFJwOEY2aTRyemJMalZMaU03?=
 =?utf-8?B?azU4SE5ES0lEcHJob2hQY0tKMWpZcVhOamtoa0dPdmVKY1YzYUMxWTl1a0ZC?=
 =?utf-8?B?dU5NTHpwY3hXNisxSHp2RHhsQ2NjTDdxZWg2aldtOCtERzNaUURUWGlzbmtJ?=
 =?utf-8?B?MU1lM2Z3RVl4cjFNcnJ1YkVsZXFMdE8yVkd4Ry9qV0c5RjEyMFhpeEY4WXU4?=
 =?utf-8?B?QVlpSFRXRVR0WUhCWkRXWXVIMk1PdlBFeHdNalcwcEhEd0pCbWJuOEI3cUpD?=
 =?utf-8?B?YVRlTlFJSExHTWw0THpnVzRPME81cTA5NFlmbHRzamRtakRDOEg3OTBFNWJ3?=
 =?utf-8?B?M09QR2JBZFROb2Jidng4T1MxMlVJQUJ2SmRKYXY3dU9QQlU0VVZUN0xRTHhL?=
 =?utf-8?B?NXdZRnJ6SFF4ZmtHTUc5TytlVk9aaExMUVdBVnpZVWtVNWdEeWtOUU96QmJx?=
 =?utf-8?B?TkRmQVpIUDVKTmgrWDNnVW5aeTFwQXFZZTd2aldrZ3ZIbFJrMWxLdFQySXdV?=
 =?utf-8?B?Smg1WXJkeUhPbCsySVdlNVNsaVVvREJ2UUtjS25hc09qZm8zc0RtaGxrRTl6?=
 =?utf-8?B?dEg4R3BsZmZEbnN4RW1pV3VFazUzMk9jVG8xdmg4a3hYTDMzR0pjRUp2ZTlq?=
 =?utf-8?B?OFUvenpIcHBXbVc1Z0JJdFA2aTJIalhtbmp2Smp2MDFGWXF1STNlcW9sb2k3?=
 =?utf-8?B?aWNVcHlHcDljdWpxNEtLNGgvaGJ5M3VGcHRMa2tkUThQRUdOcXFENzk2UWND?=
 =?utf-8?B?Nmxxbm9GVURlUk1iRStEajNaejE4S1J3ck1OTnNzK2RKRXpocFN1UHZVdE5i?=
 =?utf-8?B?b0J0VzNJc0F6Vzh3S3ZEVVlkWmVvT1JTYXhOTlZZNTlRT04veGNSa2JHeW50?=
 =?utf-8?B?QnkzTml3R2lDaGxJRXJBLzZLNXFRVitHSVFxaWhwUjY2YndLeEJtNmJXckhw?=
 =?utf-8?B?a09TbEIzcE1ReEpmNGFPRHMrTmJZSUdFMXRRbmdodzB5b2U2c1FrSUF3a1lT?=
 =?utf-8?B?L0duZ3hqd1hYbnFBQ2dhZmM5RmpwcGhLR2N5RUNnajFsdGFqcmdDRzZBRlV0?=
 =?utf-8?B?V0UzdE1rVzBBRjRmZ0lGa2psaU52dzlFNWdSOVk0UStaSFFmN29sLzEzV0xv?=
 =?utf-8?B?b0Z6NXVjaEYyMGFtd0RNQlFMbGRubm1ZSXZWM2t2djZ2SlpTRUc0elhxVmoy?=
 =?utf-8?B?ZG1TTHVYeUZaa0lNZlpocmRWSlB1eHMyVEhOOFNyMEpGcUZMQm5VcmZ4WCtR?=
 =?utf-8?B?UmsxVW9Wb1ZkdmRyWXFFUXZ4UW9mZDZDS0ErNXRUL3podlU1WnhjdTdCUC9Y?=
 =?utf-8?B?ZkpjZWNwaXFJRUpNSjIyY2lsMGlSSlFrdFl1ZkljUW1xcGZGbjREYkpiMWRL?=
 =?utf-8?B?d2lwMzNUcHpBTWROYWsva2xNQk90c0orOFBzT0JqN2NsNEJscEFFVWRWV1hF?=
 =?utf-8?B?NmVhcGFhQXZhYWkrZlE1S0ptbTBnN0k1bW9DYm5Wa2hscW1ha09ncTFTNXMx?=
 =?utf-8?B?b1lGMGEzYVFsbTNxNGNUYjg3ZjhKVWkyV1AyeFB3c0JKMklaRjhVRnZwZ0pT?=
 =?utf-8?B?OWJMZ3Qyd2JHSHl3T1BKMU94V2wzQndQU0JMSHBjNDVGalRxYmNsdzd3blVI?=
 =?utf-8?B?ZWc0L00wbVliUzhKRmZuY1pjRVh6ekVxcUlwTjFiQjhmaEdrNG5OSm96V1JK?=
 =?utf-8?B?SXRIZEpXVHBqMUpuMnVnSHlzak9sRDZEalJ3QlB4WE42c3M3L2dMUWUyeTZW?=
 =?utf-8?B?SWkzc2dPbEliZVdqVFAvOXNqVk5FVFJyVHFpa1MwV1RJQndiN0VvUk1wM2hW?=
 =?utf-8?B?Q3dyNHRZa0QwR1RQamsrczd6Z3Q0NUtRaFNMQ3FaUTRONnpvb3Y3UTN3QlZQ?=
 =?utf-8?B?c1VyYjlScEgwNzREMW9WSTJrR1R0S3ViU1dEa0pKMmEvY2dTS2JabFhCYlN2?=
 =?utf-8?B?K2tLdXBuZlpwOW51UDhydDJMK1FNNjYxOXpON1lXVGMrVm1TUCtORmRzS2Iv?=
 =?utf-8?B?TTRZYU1BKzhwUXlqWGtWNDJ5MGx1NVdqQXZKZVd0TEUyTnhJZFloMDRSTVF3?=
 =?utf-8?B?NWJlTmhYdytSMU9kN2dDbHdqUElLRVpRc1Z3c3VYa1BzZ0g2NmNFUXNiSGMw?=
 =?utf-8?B?RjZxRmUxWjZNZHZRcGRQeE5xV285eGFUTG01c3FjWGZJWVRuMHpKbGJPUE9s?=
 =?utf-8?B?MTdLWDAvR25PK1pSTGs2a1RGa1gzT3ZEelc0RlFQS0tYdldsVmNCQ1JtY21v?=
 =?utf-8?B?MVdBN2dTZE1FWDczQ2xoUVBYZ2lOeXNrU1VQV1FESzhTVmdrMWRJUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ee3aaf-51f0-4074-4ad4-08df104149ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:14:30.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siJfys0pIKeKyXcmIBN/QAIUn7aUypARG5ESGx8lOQDlAXwqmMmtNB10lZ69UAAvl2vFm8NPlnEcL83tX/aMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFdlaSBGYW5nIChPU1MpIDx3ZWkuZmFuZ0Bvc3MubnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBTZXB0ZW1iZXIgOSwgMjAyNiAxOjA3IFBNDQpbLi4uXQ0KPiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2NCBu
ZXQtbmV4dCAwMi8xNV0gbmV0OiBlbmV0YzogbW92ZSBtc2dfdGFzayBhbmQNCj4gbXNnX2ludF9u
YW1lIHRvIHN0cnVjdCBlbmV0Y19zaQ0KPg0KPiBGcm9tOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhw
LmNvbT4NCj4NCj4gVGhlIEVORVRDIFBGIGN1cnJlbnRseSB1c2VzIG1zZ190YXNrIGFuZCBtc2df
aW50X25hbWUgaW4gc3RydWN0IGVuZXRjX3BmDQo+IHRvIGhhbmRsZSBWU0ktdG8tUFNJIG1haWxi
b3ggbWVzc2FnZXMgdmlhIGEgd29ya3F1ZXVlIGFuZCBhIGRlZGljYXRlZA0KPiBpbnRlcnJ1cHQu
DQo+DQo+IFBTSS10by1WU0kgbWVzc2FnZSBzdXBwb3J0IHdpbGwgYmUgYWRkZWQgdG8gdGhlIFZG
IGRyaXZlciwgd2hpY2ggd2lsbA0KPiByZXF1aXJlIHRoZSBzYW1lIG1lY2hhbmlzbTogYSBtZXNz
YWdlIGludGVycnVwdCBhbmQgYSB3b3JrcXVldWUgaGFuZGxlci4NCj4gU2luY2Ugc3RydWN0IGVu
ZXRjX3NpIGlzIHRoZSBjb21tb24gc3RydWN0dXJlIHNoYXJlZCBiZXR3ZWVuIFBGIGFuZCBWRiwN
Cj4gbW92ZSBtc2dfdGFzayBhbmQgbXNnX2ludF9uYW1lIGZyb20gc3RydWN0IGVuZXRjX3BmIHRv
IHN0cnVjdCBlbmV0Y19zaQ0KPiB0byBhbGxvdyBib3RoIGRyaXZlcnMgdG8gdXNlIHRoZW0gd2l0
aG91dCBkdXBsaWNhdGlvbi4NCj4NCj4gQWxzbyByZWxvY2F0ZSB0aGUgRU5FVENfSU5UX05BTUVf
TUFYIG1hY3JvIGRlZmluaXRpb24gYWhlYWQgb2Ygc3RydWN0DQo+IGVuZXRjX3NpIHNvIGl0IGNh
biBiZSB1c2VkIGZvciB0aGUgbXNnX2ludF9uYW1lIGFycmF5IGRlY2xhcmF0aW9uLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0KDQo=
