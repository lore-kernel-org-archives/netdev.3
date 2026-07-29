Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09243F8BE;
	Wed, 29 Jul 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316116; cv=fail; b=klMKip4TKv8If6+PZOB4mZCnj1iA8UOHo6KPvf19Oci7TXL8B4jJCZnm3dLV2ZVH9423rma6WjIuKVOS1pu4YhwlrCgMip+FC6MbZA7JEoP7OLYxV4zGNZjOEV/m90i5nnfU0YTg0xhSo2rj/Gg4hliW+fdT2g/CoBInj6Go/Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316116; c=relaxed/simple;
	bh=0tIXO4fWmMZ1lsgym5e6HEUw8CjmeKxlsHTeVwWREn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EvzEtzLhs7QnhnDUPC03BK1w6asTsHBoyB84B/zrLZMiXE0jECqmA0pb6KpWe3jGLzW6GRSLlNP9dtJUhhlW2GIdI6bj5Dqq3+bcky/i/vNRv0abD+RZGELYMdf/DPh1J35AtYiYFDEEyNXSAddewuPGi4n8cUjFb4IfxVqBW4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EgyYmujz; arc=fail smtp.client-ip=52.101.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EgyYmujz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ2Bwqakrl3MiAaAEZQ2utsvl3Mwbh1d97z49LbAQygyHulEfFp+3bcMoOP0bi1ESUocPa+hyVd9zoqu6DemOi/69uRT89Yjx2T1dDhvq4tdpRV3nnO7/uMIeRrb9gV1ch2iRcdlahg53/0a1jpkSIVeLCtjtZyK8Jrp0YfvV26YyNA2oVpDm6A3qTqjx6wCPB44SqQ2UOR8pDZ3HNTGNI3qKMPGD5XA1osx7Q+TGTel0ZcXmw//xY8+oETSaLOAmM5F3YkTKWWyRDdXG9BLPglJmCFlfBdPr89HHIlR/XtQJ8qVyGN1iWbZ/L1OuJ88oUAiXIw1Sa4CFNWllwR4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tIXO4fWmMZ1lsgym5e6HEUw8CjmeKxlsHTeVwWREn0=;
 b=A4imAcv4z33WRjkueV69ER3IsaLygqoxVCozo//DdNBmELZcgDIfnSFZVQVgmgqZ/YeKLdsjgmgywG2svJtdAIz65g41+aIjAFQJD2MQqf+0Nc1Lekn5K9bK0+XW79/cofYOcLtPjbekshX8aeDcFvYxfEimZwgOgeDR2rQWpa3Ck2egxQP/cjfFJ4NL/VZaKNasVi5J+PHuvvBpGy/yAM9F+B+Rwsnc5mrPpJ9PFi3qR+T8DlDHx3wXsPsRFwSadiMHlnfMudi+yGy4m93KFsMmgg/JSnRxw1USpbh1NfjFL3/rwlBYk+6/7w84e2xJVtx2P7bA51NXs/uYyIc5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tIXO4fWmMZ1lsgym5e6HEUw8CjmeKxlsHTeVwWREn0=;
 b=EgyYmujzK310A88ttYzlWLkctXUrXmodKas65fJhA8Hn5pgI/fzwiBBq0fu/4EswWzTsuCbmzABZ9EU+kiALBJVwDMNAKX4TQbK7PDGbcYo7WCL6ul8CFLajWu08GEZBZ5zn2dQztpiq/wDsyc6l+dGRYjljMYvSwOpKeticWIfoPjJEYrmctD2y7dOWcmpQ0Ywiu5vtCKFpQ8VjTLK1MBhFY9ClrO1Gqmv5PhEotoOqJzcSxpd8fI+gHT5Hn/GyQV3Rh2zl6zqhTd/swCtc52/rtarUYFZwnEcgyhsbwHw/0iJ58F6K/OvBJ1ULdP/YyGkUJy93GSO3uhk7dCFQJQ==
Received: from SN6PR11MB2813.namprd11.prod.outlook.com (2603:10b6:805:61::18)
 by IA4PR11MB9297.namprd11.prod.outlook.com (2603:10b6:208:56f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 09:08:31 +0000
Received: from SN6PR11MB2813.namprd11.prod.outlook.com
 ([fe80::ac7:12a7:9c3d:947f]) by SN6PR11MB2813.namprd11.prod.outlook.com
 ([fe80::ac7:12a7:9c3d:947f%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:08:31 +0000
From: <Manikandan.M@microchip.com>
To: <mwalle@kernel.org>
CC: <pratyush@kernel.org>, <takahiro.kuwano@infineon.com>,
	<miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<srini@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] mtd: spi-nor: sfdp: expose the SFDP as a read-only
 NVMEM device
Thread-Topic: [PATCH v6 3/7] mtd: spi-nor: sfdp: expose the SFDP as a
 read-only NVMEM device
Thread-Index: AQHdHxMaG58RBbgodE+Y0bFvqrqnl7aEIumAgAASlgA=
Date: Wed, 29 Jul 2026 09:08:30 +0000
Message-ID: <0c9ade0b-f499-4bd3-824b-f8718a870802@microchip.com>
References: <20260729043026.1811147-1-manikandan.m@microchip.com>
 <20260729043026.1811147-4-manikandan.m@microchip.com>
 <DKAWBT1F1VM2.1LA8AKQ6B17AE@kernel.org>
In-Reply-To: <DKAWBT1F1VM2.1LA8AKQ6B17AE@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2813:EE_|IA4PR11MB9297:EE_
x-ms-office365-filtering-correlation-id: 8bb6a5d1-e99b-495b-98c3-08deed50f5cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|10067099003|4143699003|11063799006|5023799004|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 6uZT87asQMF1GdGPLd/1r4AgjUCTo3jjBpgZl2HVVduiK/bnlqqIjyg7Wn7Fh7cmc/qCiBPF7Vd8M3PUT3NS+vVeYfwIuztBLYTDL+BTA1KUgd2n9leV9AwoLewIbcarvpHLzm83KzIa3zeBCEIPaxLkupYbIJLhZ5cSvOIwodajeYzKugOMQ76RpnCNeobTN2qS0vQUrdwxCjZmz5ZHz1Nbk7uz4TkEWFzLAEoDTDwElK8Tvd1gtY1cIBbYTVFh5SqhK+2qSD2f5ZIsSVf6ipmscTXmTuF7K0WscjVExIx8jqzPdD0mY4To4D1PrXk5fUHvLcaiFP0EZbx64klksCIll4G3/RIpHCVHXn6YtVIDuR51STu3K8Vd5ni7Qbv5ka0l4P7j5LRcqUtk/MACLbUMZT50SrdUNjCgd85PKfuHBBhHUxIMtP9jwXnS3iA50w1DQaZfx0cblJsGHyy+38vshyzTLhlxNduYPUCGuM46H6LaBOc64SQ+eycuE+iuP3Yafsb+bUfY1NkOUy2csjbTvr9Q7a4JOvCZ5FjdKSiE1iR7wJJVX9jqjGSoEyiuLD09MUc0VEcae2DfK4KdEUzQZVJ1+r1pJyk7KljxHJep5S94ROGReNhyoGRijc0ImqWR2YlnACf0NHrbs9w41UjUgwIryLnaPL7NGXsfKDE7UnvpoNpkG+FyxMuRm9YtlBY9uVdL1ZurVlciZ1cIqr5r9rTx664F4HkZrA33WqY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2813.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V21zbkloMUo3MlZudWNka2I4MnlURWEyZTRDYmxPVkFnTzNjZ3hrUHJKOExM?=
 =?utf-8?B?RDE2T2s2RHM0ZEZLKzJNZWhBWWZxYmhSbWowZkIvMzZSSElzN1J2L2RTVkdP?=
 =?utf-8?B?dkJqMEgrT2tGOGYzZXExU21lNGdTN3kwWEIrZ0h0YUtRaGNKNnlncFVkWCtK?=
 =?utf-8?B?UWRudHU5OGFtSWExTkdzVnhNdWhkRFZCSnlMcWRVeFoxSFRvZEUzeTcyVnUy?=
 =?utf-8?B?R3dTdzFhQWIwblRpbjd0WU5OQStEQnRBeWhGWi9yV0RrZVFHSmdMVEhQY2xK?=
 =?utf-8?B?NkZBeG5JVDZMbXNwT2Z4Mlc2Ui9uT0Q0c3NTODV2dE5oU2d0K25SQUZCZ1hw?=
 =?utf-8?B?YVFYUG8vdGkxajYza3VHSGtuYlMrRFNKMzRaN2NrWEcrSDlWcDBuQTg2aUJW?=
 =?utf-8?B?ZlUxcEtrMVZkdmJabjBVa2V2SUNjSWtITHY5U0NLanp2ejNXaW16aHVITmhC?=
 =?utf-8?B?NWNWSENOS05KZHVyOENVajJQTVJlTW5lTlV3aEo4V3c1QnlvcDRVYjRpS3Jy?=
 =?utf-8?B?TnZocnJrOGNWcWUvZ29pTTdUVHVLZVNZR2NnRXpBaXRGbGR4N0lIRC9PZnZY?=
 =?utf-8?B?UndXbTNtTlIrVXA5MDNkdkJWZjNBa3AxRi9MREhyQmNqRHFsVmNLNGVOVHB1?=
 =?utf-8?B?RjFyS3ZPd0tNWklKSUNpd0tsQngyUEtRU2FGbGxEa3pZMU1OUUxDaFZBMFlZ?=
 =?utf-8?B?ZmtvU3FpTTZZWFRuRm04RG1jMzAxbVgzYVhXcTRia0ZmYzF1T0p1ZVUzQ3Fl?=
 =?utf-8?B?YzgyblMwVEdEZ2lDTTd2ZFJBaDd2UnBjTkFneXlwcjQvS1NHZS9oOG5tM1Q0?=
 =?utf-8?B?R3Q3ZkVxQUdTRkVVandFT09xVEpsOFQ1cVNqd0tqNkhxOTN0ZXZ5eEZvTEJw?=
 =?utf-8?B?REQrd21WN2kwUUlTYmY2aEIrNGRiRkdrOVRReHp4OENnZmNTTzU3V1pSeFRT?=
 =?utf-8?B?dnEwenhFbXVQNS9OMXQwbmVIeHphUCtDdVVyVGxaNVI4TkcvdXpMamtKdHRy?=
 =?utf-8?B?blcrVXg2aUdTUC9INlRFQ2Vjb2YvdzE3U2sxTk9ab3BEcmtyY2RWYTBrSVNr?=
 =?utf-8?B?UmZ0V0xBOFl6QlBtcS9WSzBOODRzcXVWYkwxcVVTeUpqZE5pUXluaXpZMHMv?=
 =?utf-8?B?cVkvMlBBbVE0NHNRamtZUzVpYnlScEJwdU9yV3lsaitxUzRPOStVc1JBdjVE?=
 =?utf-8?B?RHVDdWdZR0k3aUhQeHNYME5PaDBzaGg4ZER4T2lJeFZxdkVDRFhhdCtYRFBu?=
 =?utf-8?B?T2oyUGRISHVjcGo3aVl4WDdrUml3S3h2RGlKTDRlZXo0T0RzWWN2UGQ3aHRB?=
 =?utf-8?B?THlIVmRFMHpoZk5Kdm5pMTFrTVIvUmY1UVUvU0NYMEsrR1orRkVWQ05Lck1z?=
 =?utf-8?B?QW1nTitic3hBSENmVDlMbUxxcGp3WlRNVnNtTHlBc2VCaCswZmI3Rlp1VW9q?=
 =?utf-8?B?SkpCdk1QL1AxSGFOYUF3Vzh0b2Z6cm5HUUNkdEpEUE9BSVFpay9HTjF4VVZU?=
 =?utf-8?B?VEJSelN3MUdjOGZpZXZWRXNjSHBHMkNxWFZHSzhmUEZRbGZWWUVzY3FPaVB3?=
 =?utf-8?B?bVZIcXhuaC9sUXVLdGQ4UVNxQnBsVEtZSUxRZHdLYUNOemJoUWwrT1NtMXhG?=
 =?utf-8?B?VFFlSHBBSWlzaE1La1dCYkltR0hCWk1MYkNjcVQydjlBT2tzeW4zQ0RBK20v?=
 =?utf-8?B?dmF0bHdBRHJuK0ZVOVFYYnJqcUZwUTg3WExTd2MvODkraEpMS1NjWityMVAx?=
 =?utf-8?B?RUYxWndXaWFsS3lIZUZMZklaQVc4UzNzYkJXZ0NJL3RjaXdBbUJ1Z0g0ZGRq?=
 =?utf-8?B?bWFOdU5tRm5USHBvaTV0WmNhVEl5OExUTWZoUWhBbU5BdUdkQmNRZVNkamQx?=
 =?utf-8?B?NUs3Z3pEYXRmN0VmdHl4UExTY0pSVmxqb0dKYktJMWdmM0hYT2JsV091RWhn?=
 =?utf-8?B?SjZpQmVpOGVwaDl0a2dwRDZtWHRSY0xrY3BWZzZqdXlieEc5MzNtUlpsZ3Zp?=
 =?utf-8?B?YlJhbjl3aS9uV29YVFhCYVdVNXp3dDJ3bndyY1dFQ2JSQ0dzWWplLzlTQTUr?=
 =?utf-8?B?Z2g0NnkxVUw3OVV3eFNMTEtwQWxoUDJBRTEzN2V2M09vRTRXSlNMdjlKVVp3?=
 =?utf-8?B?K1pYNHlCYnNMaFhKUEVLa2ZFckhId3pHTXlIYk04b0dnY09Xa3lraHNuL2k2?=
 =?utf-8?B?VFdaRXNEWk1pcHI0MVg2UTJ4MXJtZ2ZQMDF2SWViZDBCVDlxY1VZc3lLbUtT?=
 =?utf-8?B?aHBVanR0Zmppby82aXpLais1dUxpK3lPVFNRd1VHVlFQVUNQbG5yNVBWVjZ4?=
 =?utf-8?B?d3ZrUTFGYWg3RlpPeXl4bXpDdVFtWnBxUi9sKzFmRHVhcDZFMnlNQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04E96A6FF5C90F45B3B4AB9469C9C3E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2813.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb6a5d1-e99b-495b-98c3-08deed50f5cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 09:08:31.0086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPx8M0hCUCl/qjhWwzY0KMNKhWGdaEm/3E1xFjOmaqdDcdMRqevLhZ4fLgnudsB/xx06Iy3XHt3FQTMEv5cBQuqgL4fAUjz/bqNBTJcBYKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9297

SGkgTWljaGFlbCwNCg0KT24gNy8yOS8yNiAxMzozMSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4g
T24gV2VkIEp1bCAyOSwgMjAyNiBhdCA2OjMwIEFNIENFU1QsIE1hbmlrYW5kYW4gTXVyYWxpZGhh
cmFuIHdyb3RlOg0KPiAuLg0KPiANCj4+ICtzdGF0aWMgdm9pZCBzcGlfbm9yX3NmZHBfbnZtZW1f
cHV0X25wKHZvaWQgKmRhdGEpDQo+PiArew0KPj4gKwlvZl9ub2RlX3B1dChkYXRhKTsNCj4+ICt9
DQo+PiArDQo+PiArLyoqDQo+PiArICogc3BpX25vcl9yZWdpc3Rlcl9zZmRwX252bWVtKCkgLSBl
eHBvc2UgdGhlIFNGRFAgYXMgYSByZWFkLW9ubHkgTlZNRU0gZGV2aWNlDQo+PiArICogQG5vcjoJ
cG9pbnRlciB0byBhICdzdHJ1Y3Qgc3BpX25vcicNCj4+ICsgKg0KPj4gKyAqIEV4cG9zZSB0aGUg
d2hvbGUgU0ZEUCwgaW4gb24tZmxhc2ggYnl0ZSBvcmRlciwgYXMgYSByZWFkLW9ubHkgTlZNRU0g
ZGV2aWNlDQo+PiArICogcm9vdGVkIGF0IHRoZSBmbGFzaCdzIFNGRFAgY2hpbGQgbm9kZSAoY29t
cGF0aWJsZSAiamVkZWMsc2ZkcCIpLiBUaGlzIGxldHMNCj4+ICsgKiBnZW5lcmljIChmaXhlZC1s
YXlvdXQpIG9yIHZlbmRvciAobnZtZW0tbGF5b3V0KSBjZWxscyByZWZlcmVuY2UgYW55IFNGRFAN
Cj4+ICsgKiBkYXRhLiBUaGUgZGV2aWNlIGlzIG9ubHkgcmVnaXN0ZXJlZCB3aGVuIGEgY2hpbGQg
bm9kZSB3aXRoIHRoZSAiamVkZWMsc2ZkcCINCj4+ICsgKiBjb21wYXRpYmxlIGlzIGRlc2NyaWJl
ZCBpbiB0aGUgZGV2aWNlIHRyZWUuDQo+PiArICoNCj4+ICsgKiBSZXR1cm46IDAgb24gc3VjY2Vz
cyBvciBpZiB0aGVyZSBpcyBub3RoaW5nIHRvIGRvLCAtZXJybm8gb3RoZXJ3aXNlLg0KPj4gKyAq
Lw0KPj4gK3N0YXRpYyBpbnQgc3BpX25vcl9yZWdpc3Rlcl9zZmRwX252bWVtKHN0cnVjdCBzcGlf
bm9yICpub3IpDQo+PiArew0KPj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBub3ItPmRldjsNCj4+
ICsJc3RydWN0IG52bWVtX2NvbmZpZyBjb25maWcgPSB7IH07DQo+PiArCXN0cnVjdCBudm1lbV9k
ZXZpY2UgKm52bWVtOw0KPj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPj4gKwlpbnQgcmV0
Ow0KPj4gKw0KPj4gKwlpZiAoIW5vci0+c2ZkcCkNCj4+ICsJCXJldHVybiAwOw0KPj4gKw0KPj4g
KwlucCA9IG9mX2dldF9jb21wYXRpYmxlX2NoaWxkKGRldl9vZl9ub2RlKGRldiksICJqZWRlYyxz
ZmRwIik7DQo+PiArCWlmICghbnApDQo+PiArCQlyZXR1cm4gMDsNCj4+ICsNCj4+ICsJLyoNCj4+
ICsJICogUmVnaXN0ZXIgdGhlIHB1dCBiZWZvcmUgZGV2bV9udm1lbV9yZWdpc3RlcigpIHNvIGl0
IHJ1bnMgbGFzdCBvbg0KPj4gKwkgKiBkZXRhY2gsIGFmdGVyIHRoZSBOVk1FTSBkZXZpY2UgdGhh
dCB1c2VzIHRoZSBub2RlIGlzIGdvbmUuDQo+PiArCSAqLw0KPj4gKwlyZXQgPSBkZXZtX2FkZF9h
Y3Rpb25fb3JfcmVzZXQoZGV2LCBzcGlfbm9yX3NmZHBfbnZtZW1fcHV0X25wLCBucCk7DQo+PiAr
CWlmIChyZXQpDQo+PiArCQlyZXR1cm4gcmV0Ow0KPiANCj4gU29ycnkgSSd2ZSBtaXNzZWQgdGhh
dCBpbiB0aGUgcHJldmlvdXMgdmVyc2lvbi4gSSBndWVzcyB3ZSBkbyB0aGF0DQo+IGJlY2F1c2Ug
d2UgaGFuZCB0aGUgZGV2aWNlX25vZGUgdG8gbnZtZW0uIEJ1dCBzaG91bGRuJ3QgaXQgYmUgcGFy
dA0KPiBvZiB0aGUgTlZNRU0gZnJhbWV3b3JrIHRvIGRvIGEgb2Zfbm9kZV9nZXQoKT8NCj4gDQpZ
ZXMsIFlvdSdyZSByaWdodCDigJQgTlZNRU0gZG9lc24ndCB0YWtlIGl0cyBvd24gcmVmZXJlbmNl
IG9uIGNvbmZpZy5vZl9ub2RlLg0KPj4gKw0KPj4gKwljb25maWcuZGV2ID0gZGV2Ow0KPj4gKwlj
b25maWcub2Zfbm9kZSA9IG5wOw0KPj4gKwljb25maWcubmFtZSA9ICJzZmRwIjsNCj4+ICsJY29u
ZmlnLmlkID0gTlZNRU1fREVWSURfQVVUTzsNCj4+ICsJY29uZmlnLm93bmVyID0gVEhJU19NT0RV
TEU7DQo+PiArCWNvbmZpZy5yZWFkX29ubHkgPSB0cnVlOw0KPj4gKwljb25maWcud29yZF9zaXpl
ID0gMTsNCj4+ICsJY29uZmlnLnN0cmlkZSA9IDE7DQo+PiArCWNvbmZpZy5zaXplID0gKGludCko
bm9yLT5zZmRwLT5udW1fZHdvcmRzICogc2l6ZW9mKCpub3ItPnNmZHAtPmR3b3JkcykpOw0KPj4g
Kwljb25maWcucmVnX3JlYWQgPSBzcGlfbm9yX3NmZHBfcmVnX3JlYWQ7DQo+PiArCWNvbmZpZy5w
cml2ID0gbm9yOw0KPj4gKw0KPj4gKwludm1lbSA9IGRldm1fbnZtZW1fcmVnaXN0ZXIoZGV2LCAm
Y29uZmlnKTsNCj4+ICsJaWYgKElTX0VSUihudm1lbSkpIHsNCj4+ICsJCS8qIE5WTUVNIHN1cHBv
cnQgaXMgb3B0aW9uYWwuICovDQo+PiArCQlpZiAoUFRSX0VSUihudm1lbSkgPT0gLUVPUE5PVFNV
UFApDQo+PiArCQkJcmV0dXJuIDA7DQo+PiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBU
Ul9FUlIobnZtZW0pLA0KPj4gKwkJCQkgICAgICJmYWlsZWQgdG8gcmVnaXN0ZXIgU0ZEUCBOVk1F
TSBkZXZpY2VcbiIpOw0KPj4gKwl9DQo+PiArDQo+IA0KPiBzbyB3ZSBjYW4gZG8gYSBvZl9ub2Rl
X3B1dCgpIGhlcmU/DQpJJ2xsIGZvbGxvdyB0aGF0IGluIHY3IGFuZCBkcm9wIHRoZSBkZXZtX2Fk
ZF9hY3Rpb25fb3JfcmVzZXQoKS4NCj4gDQo+IC1taWNoYWVsDQo+IA0KPj4gKwlkZXZfZGJnKGRl
diwgImV4cG9zZWQgJWQtYnl0ZSBTRkRQIGFzIGFuIE5WTUVNIGRldmljZVxuIiwgY29uZmlnLnNp
emUpOw0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQoNCg0KLS0gDQpUaGFua3Mg
YW5kIFJlZ2FyZHMsDQpNYW5pa2FuZGFuIE0uDQo=
