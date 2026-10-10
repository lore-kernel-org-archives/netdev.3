Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15668383339;
	Sat, 10 Oct 2026 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599190; cv=fail; b=Geb7mIhahjpSXY0xlRL3rKxjOtyWkUugzOPpfmuUm4xBZatHaJfKl0FckPpxCQdGpQZKH9pwsQm7rR4mGKNm1T+/rdeCvGmN7HeTF9K1jJ0ElujufVL5Td8P8xILIW+Yb16Ubzl0L3t2vA6ljc9KnMyyzZKZZTVu8nxAPqqGQmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599190; c=relaxed/simple;
	bh=MJB0qnZ+jSGnF2D2ioz9kijZM7nCcFgiwxvNVvZ0vlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffCnz3jkEww76dZxAwnU2VhsLwKDwkxjiPzt6teIokuiIYhC9nlo7QQ0LspMpVHyoAPsC3yWWmpBxNMNyAD59b72BehUPnMplFKwrpRkp+oW2kyCdbx9sgnm+3gTfk58hdGsD/9QHMgVjEG1YBl1wNXV9TgOimtha8aGzpWwA8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hOaWpG/q; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hOaWpG/q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTC2FCD6ZeFLYH9jvVozJ+w0jHgVEPXgdPBzrsFe7arLTcJ7gnHmscnvAnA6+SeLtqBw8bFSBMtZ3SpvkhDiXXh13Lpg8CpVZY5n9P7TOqUaFgbJF8zMblc/F/N+X+YWObP97TujBZDF7AzJKHJEK5CSjV8PghScUfKGssnaLeYCw2+BoViRXGl+K522UbyRbzDW/2hU75AZkb598iYUXBZNCbGr5yCnvxvov835sNavH0Octnxsjegk33nZAkylq5msu6v3zIN3L9xOmFSjnm4PNjTJ+ApjjhEvnwrUxrS7jijC9Nh3c7fn0+93fGLyQ9Ezl4I8MxT7+CiEK7NESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJB0qnZ+jSGnF2D2ioz9kijZM7nCcFgiwxvNVvZ0vlw=;
 b=RedKJp1u1AEbu7dH1xJsbRTGrv9PAd9Dq4lSGs8mnKLFncXjupT64TAOAHtTYEUVANN6s5Y0QOvxbA0vuT5mT4cNiD7O8S3iUF2lIy1b1WlKZOZO7z0SCUpvcw528oD1ZH/+CRa5K45kb5ezEYlCeF47VF4CMlAG2pWPVcYL1SUfJC8tdQPSsPjDDHCi/ymap0TDFLFuJfTRSV8sCSi1nTKwx+Iy0/aiqK4uvkVTZIM3CWVgT0Q/QdRf4me4jE37ouR5q5oY6hwcV9QGwf00O8Y4RoYTlsJdZNPnAqO1yBsnhVWVuniTGtyId8iVMyxtkKysxwrG+1ocr3YzSyE4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJB0qnZ+jSGnF2D2ioz9kijZM7nCcFgiwxvNVvZ0vlw=;
 b=hOaWpG/quZLI5mlT0z6GGYZMOXlSZybceiz+7FHUbyu9gf+IbqoPK4CIEZ3F/OMjycwxyikUMe7LVrXqwvfEOv3/JwAObzTIj4FhPUi7HnjXHp2x4yeLZpUhdXU2VPxV0Y5fGMUyA3XXqO0UxcEofuzaBUtt6Y6NCltUccNld1/eHYq104VFz2pLJoqYCdjurEqDqhoINI3Y53OO9nDTcSm2eDf7vdPr2JzCzAlSxSOQR01lU85IOGyNv8YpIltfg/S5li5k+/ngrovKeBQEAP9+edqm1Wh1aa3m0UYHhS18SPY/g92K+RJkCj4qVvpxKz2vLyrUfzZzgX2HlZBpyw==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by MI9PR04MB338771.eurprd04.prod.outlook.com (2603:10a6:290:87::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Sat, 10 Oct
 2026 02:26:25 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 02:26:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "vjardin@free.fr" <vjardin@free.fr>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH net v2 3/3] ptp: qoriq: fix support for PTP_EXTTS_REQUEST2
 ioctl
Thread-Topic: [PATCH net v2 3/3] ptp: qoriq: fix support for
 PTP_EXTTS_REQUEST2 ioctl
Thread-Index: AQHdV4FKwq7Yam6vUUSJoKQJulVz+bb2DiQg
Date: Sat, 10 Oct 2026 02:26:24 +0000
Message-ID:
 <AS4PR04MB933853F7561C433BC4D45D6D88912@AS4PR04MB9338.eurprd04.prod.outlook.com>
References:
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-0-0f4eeff2295d@free.fr>
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-3-0f4eeff2295d@free.fr>
In-Reply-To:
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-3-0f4eeff2295d@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|MI9PR04MB338771:EE_
x-ms-office365-filtering-correlation-id: 1d9c2843-5589-4c38-e76c-08df2675e1b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|38070700021|10067099003|4143699003|11063799006|6133799003|56012099006|22082099003|18002099003|41080700001|15866825006;
x-microsoft-antispam-message-info:
 xt06lb+Tx9HuUBQdk4Q8z4Cr0H7TeZYqukcd5g9VdHQcWnkpqRBRZnGtOlIOtfErXi+SvD9HwbCnwZ3/Bhk028k1GQq91vvxS+hVlnlj9qANWMUs3PtJc2+VkaoDlputeyWv2Yf3upPzWsvRmYD9i7voG72gn/pHbciF+s+czVB2G4I1GVZZD+H1Jk2o0EVUIPq3jI9HQUC5ZFlYeCve1Bk9Z2YOedOLeC8wrG76+q2HpOnarzm6fIuCFJ9poeS9EA1Tshlt1Wh5Kkdg2BHnlgmSR0MTpabspN/zK6Hf9bQlpdCnnGAMFsYyzNjITmtUytpO0fLx2+wzwwwjm4hyEHp+ACa6L3P9vLAG+aChA54nJZEpdhUPP6HgZdzCviBW5GtiUZ/DiycMiRuBpzQ8ZMHUYX8FMOqM0DgokQpKklva7fdgccf5/GScCHaZvvI2YAIYJCSVrNSd0AD7HPr/Hueiz1t3h+g2hlMZPhEXFPFwtc3CM7AKsBjL8qqM8LuXDHurPZZ9vzUDfbsw4HtwiLKEDzxl1gYbvVs8VYXmOIG0c9uGSKUbKPAU8721xUtGu0Q5u+amo5qKpjVljJaQj0akLUdvvgKueKMU9cPvPphm8VMkMobQUKO708I7hDF4NM6hyFgfJZYDi1DgfSMd2EHMEEwcuMrsaUqAPsfO/4+7GNrfGzeXsLI1z3PKFSXW8sNmSHTXNuz9f3cgtLE/odGz/V+WqrCGhhY+uqNaxrKsvIg0S+bOQqDkrlpLilx8Ooraq6knstKhfMC37KGvd/v1q34QfBIoKpMBfFFiOQY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700021)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkQzZzhuakpyKzUrb3FLUzlkWG1mcmxsd3B4amlZa3NFUW9mcHhTdmdycFJq?=
 =?utf-8?B?cFJpSDByVlRMVnlpclB5a2pQMGdiVTl6TzFwQVozS1YraXJ4dCtJNmdKZHZW?=
 =?utf-8?B?ejRpdUhrUnIyV0NuSjZMT3ZXbFFWNHNicmdiZC9WWnpVckp1Q2kwWU9IT2ZF?=
 =?utf-8?B?OER1VDMxRnlFaENXTm9IVXk5cjNFN0V3azk2djgzN3g0N0xUcEUwRHVOaGhY?=
 =?utf-8?B?M1hWcVJENUF0eEpra0s3Y3VjUHo2SG41QjdFUDJFakFyd1YvenlHOEVaOE94?=
 =?utf-8?B?T3ZoazJiY3JBMlFIWEc2NGJ0WjBoV2JoQUM2ME1NNk1HSXZkQnVhUEE0akMx?=
 =?utf-8?B?VEpoUXVZQXh5VG1HazJVT0J5ZXpUUGo5V0tiQUkxU09kV2g5aWh5ZGV2V2N0?=
 =?utf-8?B?N2VadHdPa2JUODFTQmxuWlZoSnh0czYxMGpMeFRQcmg3c0NEMnpMbUhvTEZM?=
 =?utf-8?B?OTFldHNUYWMwUEREL3Jjc2gxeGVSYmhhUTVFVkVFVVIyck12NlMybmVpLzlB?=
 =?utf-8?B?aFR4UE9RVzc2V1UvTnE4c1owVW5tcDgwRzAvRC85Yk1mdHErK282UUgzQTB2?=
 =?utf-8?B?dnhZazB3OC9kV2cwSk56NzREb2FVeUpYeGNFOURSRDZjY3ZjcFZBNVhTdTc2?=
 =?utf-8?B?TlF3eUdmcVJSaUZEcnNpS0llRVpUdkdIY2RZZmg1NmRJODVsUmRJUHcvRjNU?=
 =?utf-8?B?bGxDRnVMd0JhaHNnczN1bUhkek9nMWQ5ZHF5MHM5aHpaOXhoS01CclVUZXFC?=
 =?utf-8?B?TGkwOXBCejhCRzhOY2lFeExjYzAvelEwbTN4T2NSYzJsTUYrVjZHd2pDWUdq?=
 =?utf-8?B?Z1ZlSENncHZXYUNEMFNLQ2p0NFBaNzl0alk5OXhydVFFWHAweUlldnlyVUNq?=
 =?utf-8?B?dWs1QWhZdEJnd1I1dEZwOVNQZG9TMkNJc2VvTkdjOHlEaFRPZmpQVzF1RVh6?=
 =?utf-8?B?eGFTTEx3c3JJMTdROWRaUzlyZXRyOThjeWhTeHlPZk5lY003dTJpRCs0UnFa?=
 =?utf-8?B?dnhFaHVyUHJCZVFiQU1CZFY0OTNSYVRXVDBUNzV5ZFhleWpNcmo3ME12Q0J5?=
 =?utf-8?B?eis1M0I2TFhLR1ZzM3BCakJhUDVNWElNVU1mWnowLzkrZ2xJc25ERWpuWFoz?=
 =?utf-8?B?bGYrbWxLRzEwTlM5YkpBcXUvd0FHMW8wOUs4Ukc3NDVnRWdHR2R3Nm10Mzk0?=
 =?utf-8?B?Vlg3dmFlNE9QbWFUemJpanRMQVF5TjNKS2prczZPNzVlOTgvazNPTWErOU9Y?=
 =?utf-8?B?VFNZQmJ6Q09jd0ljK2ZaQzJSb3czbS9rUzIwQXI4dWxrUmNpTlBJdEpUUWwr?=
 =?utf-8?B?cCtKK1JSSlB4dmJtcDIxdXkyek1KL1VHYU1oSWc4VlpjajQzUjRiTy91UEpl?=
 =?utf-8?B?RTVRN1VyMUxpK3g2S0pxYllMTjJORWZPdHk4N1FXU1J5ZXpUMHBwNnNmZnJ0?=
 =?utf-8?B?eWRrU2J4cDgyVitTYldCVCtIK2dTSXJsTTdQN3dzRFhyemp4TUFwNWJDU0x2?=
 =?utf-8?B?K2p6RENheHRqb05KMVBCVG1JNTRJWU4wa29uTXZkelB5ZFhDbHQ3WEZNMWdL?=
 =?utf-8?B?Z0NKMGp1SzVBb1NCRER5R0dPWWtiVmRZNU0zZGJsTU9VUWZ1RUpEK20xc1Nv?=
 =?utf-8?B?dUhlRFJVWW51MVk4WkpMdDlVRVRsdk9PSGZwenpkd0ZZUVltYmo3RERGZXY0?=
 =?utf-8?B?MXhmMDVtTEh1N3NQWEgyV2xmTDVyalBOK0dFL25rQmNrOVlTR0ZhN2N4MlRt?=
 =?utf-8?B?SUw4M2gwSUsxTUNJV1ZpclNaOEpxRmhkVG5tU3lhQlA1TlhmWGxxemdEVnds?=
 =?utf-8?B?S01HczJZNEQrcXB5R3d3NVpad2Zoby9oMDJNZnRjQXJCQnprOW10L3lCZEEx?=
 =?utf-8?B?K2Y2TFFUUFVnUUJCN005UmdxaDZDaW81VWJxeEtGRE5VY0xxWWdmbm5sbkZ3?=
 =?utf-8?B?OG4zZ3RvOGliV0dYWms3dytxamtTaEN1VWowNXN2cURMN1ZFeGlvL1ZsZHVN?=
 =?utf-8?B?Y0ZpV3FGZHhsWGJpOS9BSFhMSmZjUUJqNjBYTWNSak9OdnFKQ2srK29Ja3J4?=
 =?utf-8?B?NFBaQW9QZmRBVXY5WTBuWjc0b3lqcDZPeWUzTmtoYTJIdGQrblk1cU5TSEFK?=
 =?utf-8?B?ZFdidUdLZFVKUURDNHlnUGFTTVgrZXFOVmIwWldqenljc2dLdndwbVRDSmZY?=
 =?utf-8?B?UmFKd2xZcm9oS3JrR283eEZIaTRNN1B3WFUzek1yWW14dUVVbFlPWGxaTG43?=
 =?utf-8?B?RkY1d2svTmhnZ3JaM01BVnRySms4eFR3WFljVVY4TTNDUVVGcENjUnJKc0Jw?=
 =?utf-8?Q?D5M2s01oCGUrYLRc84?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9c2843-5589-4c38-e76c-08df2675e1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 02:26:24.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHioOcZAPOJYyJVWo6CJAOD95adqvwofrNKeuUgBHToMib2MSCD7HAW3fQFO6s5B2oR32hTR0pTDAQ5B8qVjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB338771

PiBGcm9tOiBWaW5jZW50IEphcmRpbiA8dmphcmRpbkBmcmVlLmZyPg0KPiANCj4gQ29tbWl0IDdj
NTcxYWM1N2Q5ZCAoIm5ldDogcHRwOiBpbnRyb2R1Y2UgLnN1cHBvcnRlZF9leHR0c19mbGFncyB0
bw0KPiBwdHBfY2xvY2tfaW5mbyIpIG1vdmVkIHRoZSB2YWxpZGF0aW9uIG9mIHRoZSBleHRlcm5h
bCB0aW1lc3RhbXAgcmVxdWVzdA0KPiBmbGFncyBpbnRvIHRoZSBQVFAgY29yZS4gQSBkcml2ZXIg
dGhhdCBkb2VzIG5vdCBzZXQNCj4gLnN1cHBvcnRlZF9leHR0c19mbGFncyBzdGlsbCBhY2NlcHRz
IHRoZSBsZWdhY3kgUFRQX0VYVFRTX1JFUVVFU1QgaW9jdGwsDQo+IGJ1dCBldmVyeSBQVFBfRVhU
VFNfUkVRVUVTVDIgcmVxdWVzdCBpcyByZWplY3RlZCB3aXRoIC1FT1BOT1RTVVBQLCBzaW5jZQ0K
PiB0aGUgY29yZSBhbHdheXMgYWRkcyBQVFBfU1RSSUNUX0ZMQUdTIHRvIGl0Lg0KPiANCj4gcHRw
X3FvcmlxX2luaXQoKSBwcm9ncmFtcyBUTVJfQ1RSTCB3aXRoIEVURVAxIGFuZCBFVEVQMiBjbGVh
cmVkLCBzbyB0aGUNCj4gdGltZXIgdGltZXN0YW1wcyB0aGUgcmlzaW5nIGVkZ2Ugb2YgaXRzIGV4
dGVybmFsIHRyaWdnZXIgaW5wdXRzLiBEZWNsYXJlDQo+IHRoYXQsIHdpdGggUFRQX1NUUklDVF9G
TEFHUywgc28gdGhhdCBhIGZhbGxpbmcgZWRnZSByZXF1ZXN0IGlzIHJlamVjdGVkDQo+IGluc3Rl
YWQgb2YgYmVpbmcgdGltZXN0YW1wZWQgb24gdGhlIHJpc2luZyBlZGdlLg0KPiANCj4gVGhpcyBh
bHNvIG1ha2VzIHRoZSBsZWdhY3kgUFRQX0VYVFRTX1JFUVVFU1QgaW9jdGwgc3RyaWN0OiBhIHJl
cXVlc3QgZm9yDQo+IHRoZSBmYWxsaW5nIGVkZ2UsIG9yIGZvciBib3RoIGVkZ2VzLCBub3cgZmFp
bHMgd2l0aCAtRU9QTk9UU1VQUCBpbnN0ZWFkDQo+IG9mIGJlaW5nIHRpbWVzdGFtcGVkIG9uIHRo
ZSByaXNpbmcgZWRnZS4gVGhhdCBjYW5ub3QgYmUgYXZvaWRlZDogdGhlIGNvcmUNCj4gYWRkcyBQ
VFBfU1RSSUNUX0ZMQUdTIHRvIGV2ZXJ5IFBUUF9FWFRUU19SRVFVRVNUMiByZXF1ZXN0LCBzbyBh
IGRyaXZlcg0KPiBoYXMgdG8gZGVjbGFyZSBpdCB0byBhY2NlcHQgdGhlbSwgYW5kIG9uY2UgZGVj
bGFyZWQgaXQgYXBwbGllcyB0byBib3RoDQo+IGlvY3Rscy4gQ29tbWl0IDMyMDBmZGQ0MDIxZCAo
ImJyb2FkY29tOiBmaXggc3VwcG9ydCBmb3INCj4gUFRQX0VYVFRTX1JFUVVFU1QyIGlvY3RsIikg
bWFkZSB0aGUgc2FtZSBjaGFuZ2UgZm9yIGJjbS1waHktcHRwLg0KPiANCj4gRml4ZXM6IDdjNTcx
YWM1N2Q5ZCAoIm5ldDogcHRwOiBpbnRyb2R1Y2UgLnN1cHBvcnRlZF9leHR0c19mbGFncyB0bw0K
PiBwdHBfY2xvY2tfaW5mbyIpDQo+IFJldmlld2VkLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUu
a2VsbGVyQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtvcnkgTWFpbmNlbnQgPGtvcnkubWFp
bmNlbnRAYm9vdGxpbi5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZpbmNlbnQgSmFyZGluIDx2amFy
ZGluQGZyZWUuZnI+DQo+IC0tLQ0KPiAgZHJpdmVycy9wdHAvcHRwX3FvcmlxLmMgfCAxICsNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcHRwL3B0cF9xb3JpcS5jIGIvZHJpdmVycy9wdHAvcHRwX3FvcmlxLmMNCj4gaW5kZXggNzYy
NzJlNWFjNWI4Li5iY2QyOTEwNGVmZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcHRwL3B0cF9x
b3JpcS5jDQo+ICsrKyBiL2RyaXZlcnMvcHRwL3B0cF9xb3JpcS5jDQo+IEBAIC0zNTUsNiArMzU1
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwdHBfY2xvY2tfaW5mbyBwdHBfcW9yaXFfY2FwcyA9
IHsNCj4gIAkubl9wZXJfb3V0CT0gMCwNCj4gIAkubl9waW5zCQk9IDAsDQo+ICAJLnBwcwkJPSAx
LA0KPiArCS5zdXBwb3J0ZWRfZXh0dHNfZmxhZ3MgPSBQVFBfUklTSU5HX0VER0UgfCBQVFBfU1RS
SUNUX0ZMQUdTLA0KPiAgCS5hZGpmaW5lCT0gcHRwX3FvcmlxX2FkamZpbmUsDQo+ICAJLmFkanRp
bWUJPSBwdHBfcW9yaXFfYWRqdGltZSwNCj4gIAkuZ2V0dGltZTY0CT0gcHRwX3FvcmlxX2dldHRp
bWUsDQo+IA0KPiAtLQ0KPiAyLjQzLjANCj4gDQoNClJldmlld2VkLWJ5OiBXZWkgRmFuZyA8d2Vp
LmZhbmdAbnhwLmNvbT4NCg0K
