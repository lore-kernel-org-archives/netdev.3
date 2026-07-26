Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052D3E316D
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785106821; cv=none; b=WkrOLGpajRhBrVlhG5fntl5lKavkTRGsaBEjvpW8LWuJUOhBope3WvrcSjBvhXYAF1qsi/Yk1Xy7Nryv8nt8Vc6i/EMBg305wFtqpAg+6nLSFWBQUBX7YoziN6N8vEAh6WdsRyuNqwEITbMqoN15zB9qrr6OOJ8ZR2DyxZq7iz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785106821; c=relaxed/simple;
	bh=/ly5XI1e7QT9hpwD+TDI5BaEDLP/huVYzgjItoQKX1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=QANakaLagGMfIw1F/MTG61C6f4DKatG79v5AiDQ5dGQAYepppGu3H2bz3pR1W9SW3hSBeoSzNfawulsvGhqAov6adll0bwDvh2hgQaoawmcAOH1hgOEnA5UlSkpfMupMS2LVMGHM3ZFTHFJUZAfeQfppuQ9NPre+b4GkdOHxEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Njks9JSp; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Njks9JSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1785106813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ly5XI1e7QT9hpwD+TDI5BaEDLP/huVYzgjItoQKX1Y=;
	b=Njks9JSpicsSlBNGYhwAgFlIniWAxtV0XNwBFzwZqogT4pCcPxABHmIG5sgGVuQ1Kd4nlY
	s/BWhVW9B4U4Q/pgbIDd3AfMrIDUqZ6Kfl7/BBaJLyV2de72w77pDMzYVQtZD/HPn0kxQt
	pY9QDJ9FZimSUbUvNeO8a16SOPm6/Lcb+C87rreLpA1voPKIfjbulKC9y28aGE/z+lVqYQ
	+fAM3xpo3vbO8NitQZltQnw4mBSl+1CZ0RWmz0WI0K/OsLB9Jmzwjcms4XjzbvMnArnq06
	NYczVGicodzhF85fqtDqkIna3fG8pa6CltyxHbBNETE20KZNpDOPJa1hT7a2WA==
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011062.outbound.protection.outlook.com
 [40.93.194.62]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-74-6qaXMnV8MJeRGbTf4E0A-A-1; Sun, 26 Jul 2026 16:00:04 -0700
X-MC-Unique: 6qaXMnV8MJeRGbTf4E0A-A-1
X-Mimecast-MFC-AGG-ID: 6qaXMnV8MJeRGbTf4E0A-A_1785106801
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 BY1PR02MB10411.namprd02.prod.outlook.com (2603:10b6:a03:5ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 22:59:58 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 22:59:57 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH net v4 3/3] net: ethernet: oa_tc6: Disabled tx queues when
 disable_traffic is set
Thread-Topic: [PATCH net v4 3/3] net: ethernet: oa_tc6: Disabled tx queues
 when disable_traffic is set
Thread-Index: AQHdGLerv7mzn/OraUaB1UWeE2zJprZ5UvQAgAce9jA=
Date: Sun, 26 Jul 2026 22:59:57 +0000
Message-ID: <DM5PR02MB3369D45C3C4EEA8D18C485FA83CD2@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
 <20260720-fix-race-condition-and-crash-v4-3-8273e2f38a1f@onsemi.com>
 <b6524b93-593f-49c5-88f2-393297ed86fd@microchip.com>
In-Reply-To: <b6524b93-593f-49c5-88f2-393297ed86fd@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|BY1PR02MB10411:EE_
x-ms-office365-filtering-correlation-id: 28e93b8e-aa84-4e08-6141-08deeb699d6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003
x-microsoft-antispam-message-info: CEPvr36SLOMK/k7g5IOs1BuQJuehrIyQfJIu4qfVIhQPLFI4xFCSD9xxdmrYrs7pPlZLmDPRBpdyLYDI/GdWg5UdXzCmmELfhE/ib7xINAMsr4JuZQP6htXfLjICp+n0tCMnbOlhvxCTLx9m7MGsgDOP+SRNcMSnx8EQ9jm+Doq4ncp0+PF6jKvw61XrESi+DfQkUAUxcUMrWSPAqSZEgr8tDO7Yvhb/MTLrkxZ8BWotLrBzepkwDbOrdh4wtxzkknh1ZaabIzA1AH2CEMs/HLIn3I4Jgs0+DwGg2/FpLeHLVKWgK9p/Ux45iZlM7RKmU8/s0P99P1gKUkNcLx4AWMwKMYvbnS/FEsQ2a/K9t4O1TOJ4RfPs18LsxXWIhmC/DapSPIy5KtgtSZMuXkQMi+52RCg7GjTdraK+4LIIvSnj+HzwTBKnr+VCx27+ZO56D1PE7Y+Yi3Iwp5lkmG2qKmCQM3tOJCc/4ZfGpF4oLSJJtE5uGrAhuCK1aaI2hdyKAtXe+HmrKBy1R7LXZEIoqq7n8pFppvYh/rzhoatxyIL9OIE8XwdFINoONf92LNcJZni0cnfcn4FTwx7vd3Begzt5mATOdnQIEFyB4WyN0xubON48O+A2yXIfHnzP6DWmAxbQNZxcSQ40HYFFQXnIEU5ZvVJz6i+fgwWw2GnmRLYGuRgKj6Y2SZthEh8KDjNQRJwEMU/TMrvLVAY2zWA3KZOxofnNRx230SOFqEdZdPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck9xSXBYcDZVOHJWMHZTVU96alRQenpYeC9PL3JHK3pzWExrMWZET1ZhbWdS?=
 =?utf-8?B?SGdEayswakhVc0JTRlVrcTNRdEhPSkV2blh4SUJ6a1ljMmgyMnRHRE5zSjZh?=
 =?utf-8?B?YlltaWFTVW1Gc2Yvc1lLTjBueWpFWTJoc3BYTTRSVW5kalovUzFwSElYNFd2?=
 =?utf-8?B?dDY3TFRKc3AzL2YyQy9kblRFdmdzSnpGWE8wWXJJclNRSFlhMWtQTVZEWldH?=
 =?utf-8?B?ZTlRZktNRVF5Z2hucjdqRVJ4RFpDdUh0aTl2UkFSdWhOaThzd1dtMVRyUStV?=
 =?utf-8?B?K2R3Wi91dXRvSlo1ZVhSNDFldWx3K083bG5WZFZmenBadnMyejBFMFpKaG9L?=
 =?utf-8?B?MXNXS1gzWFdPRmN0cVBnc2RVSjVFWHVnTk9GQTZzZkJJNjZGNUszblVZVnJR?=
 =?utf-8?B?UE00Ui93bEpoL1R5NExpN2w5M2cxNUZEdnYzd2VJbUorRTBZQzYrSHVUQXZa?=
 =?utf-8?B?V0Vidjcyc0tBSythdjVtV1ZBdjZ4YVFsdmJUWXhuL0c3dzdiemEwVDBFNDlG?=
 =?utf-8?B?bmdQSXBBUmFOZW9henNIMnl4eW8wNHMwRmlIdk9Jd3Rhb1JsVTdyZTFDc3Jw?=
 =?utf-8?B?ZHcxQ1FnUmdXeEsxTW9qVjZTQTRIaiswRXFTNldRRzR3MmdvemRhelF2eUVM?=
 =?utf-8?B?ci8xZC8rZG9IaDFUZnVHaVZxZlp6NTlsVHdES1pEQUNTVkZBVTM1dU0xZnlq?=
 =?utf-8?B?SDRMSjh4TUdMdEZsZ3dGR2U0cEhqeVNNQjQwWjhteHZGTU5zVUR0dUozd1hL?=
 =?utf-8?B?Tjg0azZ5Y2twSWpIUTJoM1BGUjVISCtPRitPSC80d0cyejc5NGNRN2F4K0FP?=
 =?utf-8?B?NUtmelhHSTAyV01wc0RFVVRHZ2JLZURFOGZMbk1FdU56ZzhEa3V2cUNteG5o?=
 =?utf-8?B?WkJTUnZOdnQ5dUNjQ2xKVzl1UjJmcVZndnVVWlkyRGgwbno3bTFlMXd6RmRT?=
 =?utf-8?B?TERvV2tGb0hpeVlLbDBlcmNRYjE5RmpZOGJqL2h1YkJlclQreHBVanZ6dnQx?=
 =?utf-8?B?Q0prRk4wU0RHSDQwNlpKRzY2eE85OFk4d01Td0k2S09EVDUvVDJSL3RZR1F1?=
 =?utf-8?B?NE9ZL2swUUNrL2JuTCtPWjZCYjA3ckFObW9nSXdmZm9RVCtmTkZxV3dGWjNu?=
 =?utf-8?B?MjZVNVcrOWNHL2NZcWN5U3M4Y1VtSmpJM2VLQnhsSzZkS0hkeVN1em9DbUpB?=
 =?utf-8?B?UDBadER6cGVzbGFYMkNlbVF1M3lsTnpIbXRLbFJ4VEdiQVJ3dEtJZ1ZvQUFK?=
 =?utf-8?B?Q242dnROc1g4Mk9abXpudjJSbkd3VFlzcTltdCthNHF3MThmYllRV1lKd2th?=
 =?utf-8?B?SnhJUTFRS0hZZ1NST3pONGoxK2NjNVRvcEFUMiswZHpRaGNvblB2aWlpbGZu?=
 =?utf-8?B?MnZXN1hBS0s2RWRIcVBwWGNvQVEyS1RNc1pQc1pZckNsWklBRk5JTGo1a1gy?=
 =?utf-8?B?bUhuRDRxMXJpd1RyeFhOVHBrZC9EN1JDZEFqZ0hsY094eDUyd0FUZmVVY05l?=
 =?utf-8?B?bDk0RHJHa1ZhZ0N0UGdLdWR3cHcyQS9RWUM1M211V0t6QktBbVQyM3Q4azR4?=
 =?utf-8?B?NXkxY1dCU1lNajcwQm1SOWQ0aWczQVlqbGl0Sk91NTcwU09iZUJ4UjZYakdS?=
 =?utf-8?B?cFNMYW1rTDltMENUN1VMd1B2NnJxNFRYWlloUEthaWFkejM3aEhtb3VaVHZD?=
 =?utf-8?B?QitpeHZEenlqNmVWZUlGM3hDUXJ4M25Zd3VqYjRaVWNkRHZYOXBHVXUwaDE4?=
 =?utf-8?B?TW5RTVd4dm4rTlV4MDd1aW92aWJKM3Bta0F6U0RrSWtSWUlLNkJqWm5lbEZW?=
 =?utf-8?B?bm0vNFJ4ekxKNTM3VWVtV2JqQlBaSlFQdDUybjY2eFJscFcrd0RuQ3pUWXlS?=
 =?utf-8?B?b1lUaVVwSHcvRlNDUi9qcU50TEpnSlBWV2ROZ2lmMnRrZEE3UVpSeXZCU0Zk?=
 =?utf-8?B?RFN4RWF1RmZuZGpiVTBQUXVQVjdReWJSMDRyWStab1J2VjVZc2tnUmw3bHJE?=
 =?utf-8?B?aXcxMklqeVlBcnl0bnQ4YmdUVnhsRDZPd3ZGQlFaaWpJcW96bjNramJiMFFx?=
 =?utf-8?B?MlA4WFV6aFhRd2RkZkpTL3VIMk9tM1VwVXZVdTlrYzkrZlArWWdMbjVaaG43?=
 =?utf-8?B?aThib1BVT3NBaEpyaVM5YTV0R2ZFNHVmclhsRGdPT1kydUNuaEhMb1I3a21N?=
 =?utf-8?B?dm9CU0JEVDMwdjdtOHowamZDZ2lQMXBGSVV0dWJwVS9WSFJ4YzU3SEM3cGFQ?=
 =?utf-8?B?Tlk4U0ZJUEdFem9rRTlwVVNEdzVNSmdOSzh1VHVJaGFBNmE4clJLQ2JqNVlz?=
 =?utf-8?B?ZHN3NkloelFGTk1tY2tkUlBiSzdrVWYydnNFNFZRR0JXeHdVSHM5b3U2MVBQ?=
 =?utf-8?Q?qtSR2E4MVPzVbzzU=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NCFc7ISl2zzGA3q6HknAPnSVYsX3rJXD4IZZPLp0cifZOvKIOTLBIgg3jPRy/b21VsxLJrzTPhBecTN+pj2E8Q15YGwZ+efI0aDVqAfiCyvVa5fV5dPZaJpPymZzElVY/IXVX9kmivug1NTiPy/VeydRfAKMn4eJgf1hhfdGkA6joAlx6WCLvjZNDyrNqi+HAfx+i+ZVQ2UDYHLirBKmlMKmYyGx5GjkfJ2Ax6CH2tZKUIpgu0fH2vFXOpnEDmi26lZchsArHaqGaIMIVjTsuPiAr0ZAKovXd1Y31v87bFZQF0g1zM2xsLRDEMaFpNLsTs5EH6+uDgBiNFbeO4IBwA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e93b8e-aa84-4e08-6141-08deeb699d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2026 22:59:57.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nG9r2JAp+4MyWKoavRCQNHY+fzODDEqHpo2BeJxS3YwLO7egbgGF2jqvLNDHjdWI59ZaRGBW6zx3z+jNiPRLzcstgTu+1OXjQJqGA3qqcAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10411
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Niobytp8mTkqPF9Lk_dhdpFbCTBYNI9TmnuGSnlLFXk_1785106801
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

VGhhbmtzIGZvciByZXZpZXdpbmcuIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8cGFydGhpYmFuLnZlZXJhc29vcmFuQG1pY3Jv
Y2hpcC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHY0IDMvM10gbmV0OiBldGhlcm5l
dDogb2FfdGM2OiBEaXNhYmxlZCB0eCBxdWV1ZXMgd2hlbg0KPiBkaXNhYmxlX3RyYWZmaWMgaXMg
c2V0DQo+IA0KPiANCj4gSW1wZXJhdGl2ZSBtb29kIGZvciB0aGUgc3ViamVjdDogIkRpc2FibGUg
dHggcXVldWVzIHdoZW4gZGlzYWJsZV90cmFmZmljDQo+IGlzIHNldCIgKG5ldGRldiBjb252ZW50
aW9uKS4NCg0KRG9uZQ0KDQo+IA0KPiA+IGRpc2FibGVfdHJhZmZpYyBpcyBzZXQuIENhcnJpZXIg
aXMgYWxzbyBtYXJrZWQgb2ZmDQo+ICJDYXJyaWVyIGlzIGFsc28gbWFya2VkIG9mZiIgY29udHJh
ZGljdHMgYm90aCB0aGUgY29kZSBhbmQgeW91ciBvd24gdjQNCj4gY2hhbmdlbG9nOiB0aGUgcGF0
Y2ggb25seSBhZGRzIG5ldGlmX3R4X2Rpc2FibGUoKSwgdGhlcmUgaXMgbm8NCj4gbmV0aWZfY2Fy
cmllcl9vZmYoKSwgYW5kIHY0IHNheXMgeW91IHJldmVydGVkIHRoZSBjYXJyaWVyIGNoYW5nZS4g
UGxlYXNlDQo+IGRyb3AgdGhpcyBzZW50ZW5jZSDigJQgdGhlIG1lc3NhZ2UgY3VycmVudGx5IGRl
c2NyaWJlcyBiZWhhdmlvciB0aGUgcGF0Y2gNCj4gZG9lc24ndCBpbXBsZW1lbnQuDQoNClRoYW5r
cyBmb3IgY2F0Y2hpbmcuIERyb3BwZWQgdGhlIHJlZmVyZW5jZSB0byBjYXJyaWVyDQoNCj4gPg0K
PiAtLS0gaXMgbWlzc2luZw0KDQphZGRlZA0KDQoNCj4gPiBjaGFuZ2VzIGluIHY0DQo+ID4gLSBS
ZXZlcnRlZCB0aGUgdGhlIHN0YXRlbWVudCB0aGF0IHR1cm5lZCBjYXJyaWVyIG9mZiBvbg0KPiB0
eXBvDQoNClJlbW92ZWQgdGhlIGV4Y2VzcyAidGhlIi4gVXN1YWxseSBjaGVja19wYXRjaCBjYXRj
aGVzIHRoaXMga2luZCBvZiB0eXBvcy4NCk1heSBiZSBpdCBkb2Vzbid0IGNoZWNrIHRoZSBjb21t
aXQgbWVzc2FnZXMNCg0KLg0KPiA+IGRpc2JsZV90cmFmZmljLCBhcyBpdCBtYXkgaGF2ZSBzaWRl
IGVmZmVjdHMNCj4gdHlwby4NCg0KRml4ZWQgdGhlIHR5cG8gaW4gImRpc2FibGUiDQoNCj4gPiBj
aGFuZ2VzIGluIHYzDQoNCg==

