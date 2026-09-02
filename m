Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA23164C5
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315172; cv=fail; b=CedZyx+db1euRuK4WSLYZUyTxInLOk18F+CijIf94RKfecFM6d5x+BxlfNkt8COu7VX0mXJwYi90Y5PPgzePGn+2e9ZLXQi6OW7GbQtZJGexbl3y8qS9giTyjkUQAQqLrx20pGCOptdzy5y4EMogLwGDg6nNyYddr7lL2RYKxVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315172; c=relaxed/simple;
	bh=eEC/jJQQtO6VC/nMi5N2tq7b8zrx+0l952gkdPNlb34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V9LREm/3lfzT8CShT4ZVQJouvWHeyE/lwKY/sD6F+1eAkaQ3TTc6NkUWtJASDODSdUs1qLz2U9h80nOXP/0dSXb+tWOc5wfDujbxhYswUdIXNVHIaEosaqy0re+axiR9AurQCzE998d8KReKsuSmi/lisAj1kQiCxoJU+HQNmYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PHKq20B6; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PHKq20B6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFZ05uDv3SrLy0pap/fIW1cPb3mKtlmqZWtPf6+BdNTcRh6XiKzqNZakt0dw+UQ2NiTwu3z8Uxv3bnDOin3bEhyuZqh1rckDiRTnhzrhPr/38cqgyoi+djYWdH43MMQcgBsBLnSclfGAD/0mQbbx/Hlw3VuZ75xytmxqVJHBKffb4sSkR5y06mIH1RqskEkRnBRjrN55C7Ws4i2aTNUHNyQrDTlua9Iy4+n1/o4GPXxFZLcOpIYa6jdjLC+0IYAzwytO/onS0GS2E2y0PgKbzBldoaqDAxj/leZhyGdXLx/ACLgi85Qs5Dxa5AdwP4ptZfQLc+WJk1PhK8KgWSVLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEC/jJQQtO6VC/nMi5N2tq7b8zrx+0l952gkdPNlb34=;
 b=wKHSejU8XIqjLm95LjXuyFfrJk+pgqjQ110hdVl95qIEs7GASqTzi76SHIxLinEG7nIVKc48zJcGwdlDFHyZSRqp6Q4ypji+MIZc+zuZ4NFu2Y778KGHBtNVc0InzVWNSI+/9LL8rXIOphZcv8jOtGHEfIR5kZQFjJRd9CNptmfgXcCrtJm8psxsVcBqMsSEUuyxL34VZ99Lot9tQY+uaj01Krndod4bAtcGtZYxY1IZFv4d9UEbGutQWI8TTEtCZwreenf3lD0bJxiVAriMmAD2jjhH9s8pRadL3vNSP/uO9Zn6/JFIsqYBxFRoyz/RVisqOboNmI+EXE7Y42q/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEC/jJQQtO6VC/nMi5N2tq7b8zrx+0l952gkdPNlb34=;
 b=PHKq20B6h4ro0UVsx219+nP9XTyNkY/yYdQFpnuZkTASo7TZfEhBMRG1xAnAukI20SkC5PNJ9qvdgt9re4Xw4yu3i6cY5jHsz5kJXQyamVv634FfVgDmjEPjPhc3PHmgWKxEBg0cSO0vRiQplDC55oaaxIne7qS9ZNfz3HbeK/Z1bD6NlsUV1SeHIMr1UNWzovXL2IMFwuHbzjfd0772jyWnskkqhbimOD6r2BWOVH83B4KfgbdA7wLrBvOuwbVAZBEfdX89pxfQir8+tdkzRQT2a13U8MQ45P3CbwfsCc474Wds0/6USCagmMMPvNoLrgzcf6S30cFdl3SdatX3RA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by VI2PR04MB10113.eurprd04.prod.outlook.com
 (2603:10a6:800:230::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:12:42 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:12:42 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Linux Kernel Network Developers
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 7/8] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Topic: [PATCH v3 net-next 7/8] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Index: AQHdOSGM+xUfu45krU+0s+UyHQnnrLa5YzgAgAErk2A=
Date: Wed, 2 Sep 2026 02:12:41 +0000
Message-ID:
 <GV2PR04MB117394B3CEEB1CA71CAC28AFC88B72@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
 <20260831082335.1184605-8-wei.fang@oss.nxp.com>
 <20260901082026.7F3911F00A3E@smtp.kernel.org>
In-Reply-To: <20260901082026.7F3911F00A3E@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|VI2PR04MB10113:EE_
x-ms-office365-filtering-correlation-id: 0d237996-a0ff-4491-2297-08df0897ab7c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|23010399003|38070700021|3023799007|10067099003|56012099006|5023799004|4143699003|11063799006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Aokb6M95zBVJsk1I40xSDWbbZIFoH4hrbO+0HoZgsrOwuPnqD7Tq8Se2a8bDJWLlj9f0jFIAm0sYZKgN4O5xU1ArUSmHlpPnwGK0ZhDAwxvffrMODnyERvlH197hLhB4y1Mtz6uPaKP8X96919bg0GuCO9ebN1HoWPj7W+7CTLZWrSck/xr6nZ/sOi7CmnLHXj/ha5zGBEpk1mrKbx7+PXheBB6xOq7QOijnNtXUGp7Smfs27+gtq84KARvNT5KiFlVP7c3YkQQgeli2OCHnhNaLnrdwYy9/9z46zbMqGYA/HkDP0JxenCQq6ea8DZTSBEGM8/dgVtQZTyeuajeeeUW2dqed20uu1O5U9Nvw8n5RzNVnlkC5e255QE5Tyv7H5rR/G0xDSP9pazS25EcbdW4s0GlCpnrWQABKAQFxga6FeggMG8CyQpKQdUOa76uwKPxplTJ479PyyMVhrJ6UYe/xGNy1PEQiLZdAL2XRyTCr7vC7+aPZ0q24Uj3alKz9/y2HOeUhlceq6pyLCcLYIKeV5PP4ZcscTh1P5iwdJh2RHb4KoDjZuzGuZYz9CUtfhZHb5m3Xov74/6s3m0rjePTxR+WDL1fHYH2yaA65DaXr+CRUJ+4/1xPFvE9xFNpwmhJiYjcsL4H6Zi5FeqEe7K9gD9i13wYQmk1tz7ww4JrH1O/+ilFs/y828LnA17F0uM6Vf5Hy6Z21QD9brcHG0ijV7xA/5wx8OuMEkzlOBCY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(23010399003)(38070700021)(3023799007)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDFuOVFCbFhkY3E0TGttK3d5NEptNmRIWWRaT2lKNVpCTzBGVCt1TzdTNHR4?=
 =?utf-8?B?ano2ZGFvYUVhVW50ZWI3TUZwa0tTeU45cXdFS3AxT21SejhvQ0VBNm85Vkc2?=
 =?utf-8?B?bndVbXpqbnJrSUNqWFJxN2dXM3ZGTUJYSE5JaVZoMmZRME1pNVpTNnVzMDVh?=
 =?utf-8?B?dFp0VzZKckdmemlSaDdpZ1ZFdTFWeDd2aHdQODNRMzNvS2hhVFlMT3B3Qlor?=
 =?utf-8?B?dkk1UGpIaUlUM1E4RXUrQW5jbDJrMUJkQ2tOb0NWby9vT2ErWHBtWnh0bm1F?=
 =?utf-8?B?YW5zdElsbFZNRExVcVNFeWdSZ3grMEFzUnF1K2VFOThuMzkwY0pxWWVySlJL?=
 =?utf-8?B?Mm0wSzZ5M2ZGdEEzSWlSN0tFd3dQYW53enh1eENROXRDVEVlUnNSRGN0K3BQ?=
 =?utf-8?B?ZFV0RHFtQmVuR242ajhqbzJlZlJXa3EraTQ5MERTMmpwWUZ1VHVhMEliQ0tE?=
 =?utf-8?B?SVJ6eWI3QlRuUjRnZUovMDBSUlR2SlpHTDB4RSsyQmRRV3lQU2xQVjZYVTZK?=
 =?utf-8?B?d2Mxa1ZmU2ZTYW1FYXJpS0JMYkJpNkpDRG4wd3h0MEFrcnhlRVU0WklvcUJT?=
 =?utf-8?B?VkdxYmI2SUpsN1E3VHJXV3diL2p5SkZFMFpDQXRjaUt3L1NJdXd6djc0WTEz?=
 =?utf-8?B?WXZWYWRld3VKdVM0QkRLdVZyeVJETVMvRHBNMDNBeUpxUi9IWEhCRm16dU43?=
 =?utf-8?B?eVBmeC8vb01oN1lWcXBNeUx4UlpQVjJkdk5zM21TL3k4SlZJZHhaNkwwR0o2?=
 =?utf-8?B?L2J6WUhCeVpTU21RNTE3MnVGL0ZQeTdkdmpSUVBKaThwTWl0aGl5cmEwVkIv?=
 =?utf-8?B?MUhvTGdDYmNLei96Mll2QWYxRjB4M3JvSnRaNG9tTHVPM3V6SFg3NnVKWTlo?=
 =?utf-8?B?cjB6NnowOFVJSkp2UkJ3dTF0T3d0NXhYRFVGUjJPQjJCeFBNTnJsbEtuOE5o?=
 =?utf-8?B?Zm9meXZhcjBYY2s1RUhKdXJjZlNPTCthZkJrd2dYSFNNUEZtc0hKeGFLQjVw?=
 =?utf-8?B?UEZSYVhLMHVPemN6Z0dZSXpLV0lzd3BDQ3hQOW5HQmJVcFFIVis1NU9HdDMv?=
 =?utf-8?B?OHZZZ2hRdXdtUlV4SmxRdXJET2JlRndYMUZTVTlQa1ZhcnJzZnBEN2JjM2R2?=
 =?utf-8?B?WC9DQzNlSlB3Qk5ReEYyT0Q0V1B2cjhVT1d6MjNTR3hnMURUNkJSOEdRQ3V0?=
 =?utf-8?B?cU1CTzAvSTV2UlI0Sk9XQkYzMEZJY3JibkpGWlQ0N2dzMU1OSXE4cWVMTUN3?=
 =?utf-8?B?YWZnWVZjME8wcDE1dEYvTUM0MEpoNzAraXYwekNkM0lOekluYnpPSW1MTFpB?=
 =?utf-8?B?ZGpJWklJUHFNR2UrUEFNMCtQc0pBT01oZnhXL1RJRXl0RG1Nd25hMERMb2U2?=
 =?utf-8?B?dnZHT3ZQK0hKRUpUOFBhQXNpUDBQSDliZFN2UTBRKy9mbXVkK3BEbjcyT3Bo?=
 =?utf-8?B?ZjBqSkZERWxwdUR3TmtuYlNLdTBaalhMWHRTcjJwNlRGK2ZFc0gyMkNjUWRH?=
 =?utf-8?B?V1hIMlRTUWhxZEVBS2VwTFpEN2hCblQyYjN4aG5NTHNlNFA3QWhpVWNLZjJB?=
 =?utf-8?B?TThQb0RFV204ejFHK0Z0dXNldDRMVEQyangvQjhPSUpTN3d1M1VJeWJ3LzNK?=
 =?utf-8?B?eHZPYy9xTUszdUhHUkI2eFpQeFlpeFhRNmxmenJRVEVncTNSd2JjNGpIcjVS?=
 =?utf-8?B?UDcybGptZlhhaEhEWWVrVGRTeDB3M00xZGpFeEplTWRTSUNXMVhQcVUvUTdP?=
 =?utf-8?B?UnVkdFcyMDNBMEdRcEVXR0huUlUraU5wMC9xTDdDNzFjUzlFRHluQlZnZlQx?=
 =?utf-8?B?c0RBUEFWWXJ3MURxbksvT2RDckwvT3NGaHVuaHFwcit2R2M2YXlFTHVnUVJI?=
 =?utf-8?B?YW1ubEthdWQ4Z1BrUC8vaXpoeXBUN3RuUUtIYUVOOUxzNWhLeDNOVE9obWhG?=
 =?utf-8?B?M3NzamlIRUQ5eW1NYUh6V1hrOXlBMjIySkV6ekNYMnkrTyt6S0pIZ0NvK2J3?=
 =?utf-8?B?L2hsL3B4Q3JoK2FHVEhicDBqK3NST2d3dHhPOXcvZC9vQ0lsVTZHMVRWTXpW?=
 =?utf-8?B?RmdLbmo3clVhZ054THZsb3dLL0c2RHRXejllcWhtdnlibG1wOEYzL21aZUdt?=
 =?utf-8?B?T25vT2JRZGIvRWdYL01weG1ZQWpBVmpPQmhOQnNQbmp5bEhZL0ZwdXZhTWI3?=
 =?utf-8?B?NXhNM0dEUlNBRFN5Zk9ML1BGZXRDMkE2ekxwRk9IQ3oySWZxS25aYXFjRTNr?=
 =?utf-8?B?Ujdoek05eStjV1BlMnM4eXdqMzI5aG1tT3J1ci9YSlNBK3ZLYWxvUW1QTExM?=
 =?utf-8?Q?ICMlLX7US1KML5qSuo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d237996-a0ff-4491-2297-08df0897ab7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 02:12:41.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Te7jYfGNYocfr16oDBnGk9zTkXwFrqoheepC1cX4cMFlF3doc8i+LFapnjANKlCas+hWyQa4cgXTHH06/+7VaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10113

PiA+ICtzdGF0aWMgdm9pZCBuZXRjX3R3b3N0ZXBfdHN0YW1wX3Byb2Nlc3Moc3RydWN0IG5ldGNf
dGFnX3RoX3N1YnR5cGUyICp0YWcsDQo+ID4gKwkJCQkJc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4g
PiArew0KPiA+ICsJdTggdHNfcmVxX2lkID0gRklFTERfR0VUKE5FVENfVEFHX1RTX1JFUV9JRCwg
dGFnLT5ocl90c3JlcV9pZCk7DQo+ID4gKwlzdHJ1Y3QgZHNhX3BvcnQgKmRwID0gZHNhX3VzZXJf
dG9fcG9ydChza2ItPmRldik7DQo+ID4gKwl1NjQgdHMgPSBnZXRfdW5hbGlnbmVkX2JlNjQoJnRh
Zy0+dGltZXN0YW1wKTsNCj4gPiArCXN0cnVjdCBuZXRjX3RhZ2dlcl9kYXRhICp0YWdnZXJfZGF0
YTsNCj4gPiArCXN0cnVjdCBkc2Ffc3dpdGNoICpkcyA9IGRwLT5kczsNCj4gPiArDQo+ID4gKwl0
YWdnZXJfZGF0YSA9IGRzLT50YWdnZXJfZGF0YTsNCj4gPiArCWlmICh1bmxpa2VseSghdGFnZ2Vy
X2RhdGEtPnR3b3N0ZXBfdHN0YW1wX2hhbmRsZXIpKQ0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0K
PiBDYW4gdGFnZ2VyX2RhdGEgYmUgTlVMTCBoZXJlLCBsZWFkaW5nIHRvIGEga2VybmVsIHBhbmlj
Pw0KPiANCj4gSW4gdGhlIERTQSB0ZWFyZG93biBzZXF1ZW5jZSAoZHNhX3RyZWVfdGVhcmRvd24o
KSksDQo+IGRzYV9zd2l0Y2hfdGVhcmRvd25fdGFnX3Byb3RvY29sKCkgaXMgY2FsbGVkIGZpcnN0
LCBpbnZva2luZw0KPiBuZXRjX2Rpc2Nvbm5lY3QoKSB3aGljaCBmcmVlcyBkcy0+dGFnZ2VyX2Rh
dGEgYW5kIHNldHMgaXQgdG8gTlVMTC4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBjb25kdWl0IGRldmlj
ZSdzIHJ4X2hhbmRsZXIgaXMgbm90IHJlbW92ZWQgdW50aWwNCj4gZHNhX3RyZWVfdGVhcmRvd25f
Y29uZHVpdHMoKSBpcyBjYWxsZWQgbGF0ZXIuIElmIGEgaGFyZHdhcmUtZ2VuZXJhdGVkIFRvX0hv
c3QNCj4gc3VidHlwZSAyIHJlc3BvbnNlIGFycml2ZXMgaW4gdGhpcyB3aW5kb3csIHRoZSBjb25k
dWl0J3MgcnhfaGFuZGxlciB3aWxsIHN0aWxsDQo+IGludm9rZSBuZXRjX3JjdigpLCBldmVudHVh
bGx5IGNhbGxpbmcgbmV0Y190d29zdGVwX3RzdGFtcF9wcm9jZXNzKCkuDQo+IFRoaXMgd291bGQg
cmVzdWx0IGluIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHdoZW4NCj4gZXZhbHVhdGluZyAh
dGFnZ2VyX2RhdGEtPnR3b3N0ZXBfdHN0YW1wX2hhbmRsZXIuDQo+IA0KPiBOb3RlIHRoYXQgYSBm
b2xsb3ctdXAgcGF0Y2ggKDgvOCkgaW50cm9kdWNlcyBhIHNpbWlsYXIgdW5jaGVja2VkIGRlcmVm
ZXJlbmNlDQo+IGluIG5ldGNfb25lc3RlcF9zeW5jX2VucXVldWUoKSwgc28gdGhpcyBpc3N1ZSBt
aWdodCBzdGlsbCBiZSBwcmVzZW50IGF0IHRoZSBlbmQNCj4gb2YgdGhlIHNlcmllcy4NCg0KRmFs
c2UgcG9zaXRpdmUg4oCUIHRoZSB0ZWFyZG93biBvcmRlcmluZyBpcyByZXZlcnNlZC4NCg0KSW4g
ZHNhX3RyZWVfdGVhcmRvd24oKSwgdGhlIGNvbmR1aXQgaXMgdG9ybiBkb3duIGJlZm9yZSB0aGUg
c3dpdGNoLg0KbmV0Y19kaXNjb25uZWN0KCkgKHdoaWNoIGZyZWVzIHRhZ2dlcl9kYXRhIGFuZCBz
ZXRzIGl0IE5VTEwpIHJ1bnMgZHVyaW5nDQpzd2l0Y2ggdGVhcmRvd24sIHdoaWNoIGhhcHBlbnMg
YWZ0ZXIgdGhlIGNvbmR1aXQgaXMgYWxyZWFkeSBzaHV0IGRvd24uDQoNCkRTQSBSWCBpbnRvIHRo
ZSB0YWdnZXIgaXMgZ2F0ZWQgYnkgdGhlIGNvbmR1aXQncyBkc2FfcHRyLiBDb25kdWl0IHRlYXJk
b3duDQpjbGVhcnMgZHNhX3B0ciAod2l0aCBhIGJhcnJpZXIpLCBzbyBubyBmdXJ0aGVyIGZyYW1l
cyByZWFjaCBuZXRjX3JjdigpIGZyb20NCnRoYXQgcG9pbnQgb24uIEJ5IHRoZSB0aW1lIHRhZ2dl
cl9kYXRhIGlzIGZyZWVkLCB0aGUgUlggcGF0aCBpcyBhbHJlYWR5IHN0b3BwZWQsDQpzbyB0aGUg
d2luZG93IHlvdSBkZXNjcmliZSAoInRhZ2dlcl9kYXRhIE5VTEwgYnV0IGZyYW1lcyBzdGlsbCBh
cnJpdmluZyIpIG5ldmVyDQpvY2N1cnMuIE5vIE5VTEwgZGVyZWZlcmVuY2UgaXMgcG9zc2libGUs
IGFuZCB0aGUgc2FtZSBvcmRlcmluZyBjb3ZlcnMgdGhlIDgvOA0KY2FzZSB0b28uIE5vIGNoZWNr
IG5lZWRlZC4NCg0K
