Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2603DD87B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139148; cv=fail; b=b2YvJzGx30uU9vFZAWwgjtmT08Liu1VIgY6rSAV57IQGpXEkaT5QH7IAKVmRs5DwuFZzd5P7thIIWpQSmrDEWIUkdRUQm1AEBQDumS0l4eN2rJoCTESrwFhwR0bo9HFeyISd7ww37A3G95jO0sCOGEpw+uyGA83MAIylsHBQZwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139148; c=relaxed/simple;
	bh=yItzUFt5PWxD++h+ax/KeHuILukS6661v2U6bZSh/1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LlyrofoA0EtMgH4c1oXpYsXGb8uCgoa4LVJEw5pShIylZw2vh+xn5K2wvXlvEX6M20DyzjUqLRtRTMEVQu1PI3Sk93jyHOkCMqnAEjS2lNARYB5LBhdFC95y+ltw483c1xlkfNAP44CC5BZhqUunXyEbkvOL8JZFdR1BK1YKMkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rlf8HLf4; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="rlf8HLf4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz4Gm7mIRLfVrAmYCHj/C8wnpkRXUVMBrm7A5bq4kZEvYBVLI1JZ9IMiDeQ8+Bwa//n5ApZ/ECGAUmOXtFZ6yr5+eFGbLe1gGIxhjDRzfXub4tcQnCI9bjp1Pq6GzihP4aTj4fHakWFuQu5Gze1j73wB4SAd3KUQngaGE//E4LL/+uk8IzxJwAVF9na3e+3bGQ9lPFP631YqjE8y32klV15DeJo6KA3WxPtSNtoiPQQYbcUa6SlTIwuO9Sinf1HvEPdJKwkmg3UZIYgiVbj/n7fRg0bj47aIZiB39YSMN6x5+DqTJAXVmyHGlUF1GPA26TKdiV3y2G2eQeJINuSz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yItzUFt5PWxD++h+ax/KeHuILukS6661v2U6bZSh/1c=;
 b=yM/RJpyNjn7NynMDf9D6bzIq/ns9iRkGWXWKZE77H6gVnMEQhopwcCGuvhYJyzBjom9eBWt9uF5kZqzy67Mzx7vYv3ZOBE4qQIsgb7MD+dIcmbl1/+277cuz8XkZHfFVImp/i80qnx28harfC6R3exSZId4Z7FucZCJfPf9VHDzFzBQic+bB2CvbrMdxx8mOp54nrluHMeHAVt3IojxnZGIUbvOlFX+54jzqycqtoYQtlRlAm1KsNTTe1b6oV7KqK+VpURgd4GUYNXYy1lIFC0W0TVE3FNOZioSIScDXLXyKNOwLeg0zakIwgN2mKtpPFNXuZiU3CMmpzyXuI+QY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yItzUFt5PWxD++h+ax/KeHuILukS6661v2U6bZSh/1c=;
 b=rlf8HLf4fXKyYfue7vyrn/MySP7VYX3kOXM+aDax/DQmL6WMq4xVitVHMnOHacSnpROK1oEM+CARF/J6nauqIgogA9aB3A4ITzlY5Kt85cggZSp2D5WqabGC6l6wx6ZiWd98O37DpyXgpzpREo+D7zHJIysvsb00rWHmYavbaizMyMNOurZAl7jNPEvOyjjFk30iL9PCEGP4ca+f0W45JVmbmItzzUbb2FkSOwmaoMCQOLe/H6mbo/c2vE9Nfwa9+QsZSAtn4LQsFKETJYNixWp8L66XeZ1lGqEQ7EbDLvp8raY/WE1DhynZhiaoSYHyTfHstoqRn3lZ8uZAvaB4PQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BN9PR03MB6106.namprd03.prod.outlook.com (2603:10b6:408:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:59:03 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 07:59:03 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "G Thomas, Rohan" <rohan.g.thomas@altera.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>
Subject: Re: [PATCH net] net: stmmac: Fix E2E delay mechanism
Thread-Topic: [PATCH net] net: stmmac: Fix E2E delay mechanism
Thread-Index: AQHdHW9C1LxS6/B90Eil795H6yg8praA/tSAgAAB4AA=
Date: Mon, 27 Jul 2026 07:59:03 +0000
Message-ID: <04c444c7-606d-44bc-a2f7-b01dcdb53210@altera.com>
References:
 <20260727022524.7521-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <1af74c3b-f717-482c-9715-7f91f14d86aa@bootlin.com>
In-Reply-To: <1af74c3b-f717-482c-9715-7f91f14d86aa@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|BN9PR03MB6106:EE_
x-ms-office365-filtering-correlation-id: cf326bfc-4412-4547-792d-08deebb4ecee
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|11063799006|10067099003|56012099006|4143699003|18002099003|55112099003|22082099003;
x-microsoft-antispam-message-info:
 dlvi4ytr4h/1Xx+Rx67Tez8Z6vI9Iz0ga+tctUBCOGD9kgwPiftDwWz9VKKSk5hPW+J0l7Pl5eyssPCN5XJ9Q5LPbvoDObcSYT8TEKtYizHILg6hlpYtIVEljTIy8VcMEOKiou4phAYt/wt4/VZf9CqINsOhlCTVGIEDymFjst6ajpsIPXIKeZrlcS+7UHV+EikLkb9CBC/dx31IrxIPU6Gb7a7el00JyfeWnYWX7PDNq5XBdQP+XPi4bGXBp7JpMoE0EqGchr8sf+1H0S3D1me1KnLrjK3WKLIHoM0lhFstGHgCWRR8Tft7OeZYyj39H/NsxlXSOtqsquTYj8xoTy1ZSVCzFpkncwc5xEW/O5Hl6Qz6wlkkP10Juqc/xJJiltDV1dGCckk05T1eShVtXstBY0VBoXd1hbdOBsqg1m1v6fgR9BMgo0EAJSvGaokBwnjw7BnaJmyxxTcZzSFFkrzUcLo6iKQP4c1oEdem3NIOZvUOj8xKCM5iwmmZ49ZLTa65mw1Mew1RqXvtbSgTT8sIDq4eW6RRITPkWO6hn6n5G9dHNaGB4/mtlw0YixbnG7FG6KcPH1Y0vb1WarF+IVXlgJIIMb81jJlTxnfvB41pAY130yXZzcFd04UOYiveXXooZ1y5hosmISNhpP1EIowMdhhvJbmf7nVJlOsOPzcExKaje1dLY4rzg0nr/xUY6+GT/+EtGyC0MXAlBxyJzg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2FGV09qTTMvTk1LTFdFVFRBenlYWWhnSU5jS3NWaUNxc3pZV2VhYjg3U3V2?=
 =?utf-8?B?SDd2VXZjSnRMVVJSd1BXdWx5a0Z0OVFUdXRWNEIzQ245SlJHazMyTEZlanFx?=
 =?utf-8?B?MnpldjJJSXNWSEN4aEpXalFodnBQa0Z0aDBXVnRyZmdiS0pEZ20yYk84Q0xZ?=
 =?utf-8?B?Z1pTdGZrREhSYXhMaHo0MFdOdDhYUnU1UERCNzRhSnV4dCt0N2l1UmVubjI5?=
 =?utf-8?B?dlpiRVY3UW9Da2RHRGY2S2RZTk4xQTUwWW9ZOGpOVk5lU2xQQnIycURBYzJQ?=
 =?utf-8?B?L3YrU21zWGJOKzkxZURkd1pRYWxqNEpOTmdobi9ERnJwVVdSYVlhdHZ3L3BI?=
 =?utf-8?B?MWtmUFVzN0dNUUpBRHRKekNRMlpMTzVPVmtzejhKTUluUnQwQkxzNHBaanNt?=
 =?utf-8?B?cjlsR3FzYXZsc1FMd2JvYXEvOUpvTmNxZ0htdXpSY2EwekpiUVRaaGlaVFFZ?=
 =?utf-8?B?UWo4WDN2R2hHUTlTZE91WjFBZnJadERSVENUWStLcGZBK3FzcTBkRnY0SUYz?=
 =?utf-8?B?N3ZCcEUraUZiNExKTEV2eERxVUlMU3RNZkk1ZzZlL25CbXhKeHB2NXFlL3lE?=
 =?utf-8?B?SHlvaHVCYXJ1eU5kQ2E1RTdKUk9mWFVRMHF4cVJMbXBxVEFqYzFrR21NckxT?=
 =?utf-8?B?SVllemlQM2U1RkpNcXpJc1JCVWQ2UzI2N2NkVWhMMk1nS1ZxSlB4TWcxKzhy?=
 =?utf-8?B?Zm0xbkpIcXdoeTk1WjBVd3crQldqdmlqVmFrWkx3WC8xMHB4ZnN2L2dvbllk?=
 =?utf-8?B?Y3VnRzRYQmxjVDg4S0FtZHg2WFByemw2aWxJK0hVT241Qk9iUUlMRERLSmdy?=
 =?utf-8?B?Ui9ya0NXVktDdm5PcGxBWkN4WHRlUmZkMDBOWTBWM0RZSEs0am4xZlJrd0c1?=
 =?utf-8?B?TW1VbjFFYlV1cjRIZUpmZU4yWkVOMThGMk1GZUpLalFjTXorclBaT3VKTHl2?=
 =?utf-8?B?MjNxdnlFbGhnTXc0TzNNUHBnam5nTUN1dlZ1bXdYdHcvZDZLZzFBc3JnNjh5?=
 =?utf-8?B?a2FHUVFCT1VKc3AvVUlSY2JwTm9MZlZ0N2hTbjlkYnR0ZFBCMkE0ZG9hZWNn?=
 =?utf-8?B?ZTh6YkNxUXRsdXc0dW5DMU9SODN1R2RSaCs2V1lheDBYYm81ckIwVXRMWnB6?=
 =?utf-8?B?NlNnVzVldXIwQ3NkaVMycFp6NTNnNjFvUjRYR3RKYTNWNU9lVldDNnY4OXpi?=
 =?utf-8?B?bU9sZWo1bXljMFV2K1hPeGRKSkJoa2pZZ1M1djk2VWJMQm5VY0h4eitTOEpR?=
 =?utf-8?B?ZVRzcXJpT1liZlRMVnB5aG8zM2s2bStKTHRaOVZ1WUVJMk9xYWQ3c3RWVjIz?=
 =?utf-8?B?QytnS1BwaFlxcUY4UWRQMXppdlNQVitaKzBQMWx5cDNxWDQ1aHQzWUVjNEor?=
 =?utf-8?B?Z0xHVWNlSzFtZFQ0cHpnbitIVTFCY0VsWjJxajB1NXBqOERaNDUvcWlkdENx?=
 =?utf-8?B?TExGMzJjMzVJWDRFVnRFUUl1eHo2aytRZWFweGMyK1lzeGRkSm02N2pYcTJX?=
 =?utf-8?B?cTIyaHNRNUh3QVFUclJTWlNrNDhqdG1hNlZEV0hBNGdySldHdXZseDM2Wm1G?=
 =?utf-8?B?NmJRVEVwK08zeVpYQUFGd3oyMGZ6ZjhxTDVVRjBFWHRHZ2xvMjZPVjZuWkxp?=
 =?utf-8?B?cElLdkJzYlJKK3lHQnpobURKT204R3R4dGdvQ2czcG5jWnlVWDZONmxkWEZC?=
 =?utf-8?B?Sk0vUkJQTFc5Z2RrbTR3NkxvSHVER0Ftd1hhM2graTBYbGZvWEVFTUo5S2Ru?=
 =?utf-8?B?cWR4NUlhS2JXcW1FQzh0V0xOSXRrd1pyQk9VMHVwWGZOMlhJcVVjdnk2SjRD?=
 =?utf-8?B?TEJ6TmVUZGwzbVVJTkVzWU9NZ2h2VVJDN0VjOGRlc1k3NlZtTlBlWEg4b0Nq?=
 =?utf-8?B?ZnQxdXJFang3L0ozVDRnT3MzSE1ZQ0l6RHl1eFYwdkZ4YmVZWnFjN0pYemR2?=
 =?utf-8?B?UnVUVUhMa0FBZDR0N2d1V0wrTGx4aUljK09vVzc3U0pZT3dDUmNGai90d0E1?=
 =?utf-8?B?c29BTGpjeG92M2pFa3BjR2hhZTkvTzRoQWRpQy9Zc21naW0wRGNSMnNpR0tZ?=
 =?utf-8?B?amc1QnFzYmQvUm1WZGZ5WlRzRlFCUFd5RkVhSklLcEtVcytIQ0RQcFRwUXhn?=
 =?utf-8?B?YlpKeFMzUXpxVW5SQldza2ppcm5kTGNLcDlTSlljajh6U2J2ZjhXNHNFYndl?=
 =?utf-8?B?c2wrbmV2L0lrbXhWT0gvOFdrd0p0elJ4UUQwclk4UVhTN2hRTXAzdkVZK2c3?=
 =?utf-8?B?djFPclBLUDZ5eTBBd2QyQm9SNGhvVHBGdzZyZENKMldwekxGb3JpN2QweDNK?=
 =?utf-8?B?Uzd2am1aeDg4Z1o2VG1Ia29TT1dzREVJYnd3SVVaQWxMOFJnWlNYYzhyZW9C?=
 =?utf-8?Q?FRnPP0ZJGAZNtytPTe2tf1L/NhMHhYF1ysPNCYp7nVgBI?=
x-ms-exchange-antispam-messagedata-1: l5EwPb0x/BOgVOcZ/UY1v5yhQYmqTcNbEO8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C60D6317C576204F8481C8CCE2F25E05@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf326bfc-4412-4547-792d-08deebb4ecee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 07:59:03.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwgu0KOFaMAKdKSFxA1yD2l7LZ6teUnsmnkTL6HME/X7P0HdiTq/WJsso2Wt0Ayjz8URHAiMcpulG7zdd4Jj6yK3KciKRCD7HiMb+uyjLvTKTGlNRruIETDdwYkxElwA/a2TWJT6gZEyXmQ+JMEGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6106

T24gMjcvNy8yMDI2IDM6NTIgcG0sIE1heGltZSBDaGV2YWxsaWVyIHdyb3RlOg0KPiANCj4gDQo+
IE9uIDcvMjcvMjYgMDQ6MjUsIG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5hc21hZGVAYWx0
ZXJhLmNvbSB3cm90ZToNCj4+IEZyb206IE5hemltIEFtaXJ1bCA8bXVoYW1tYWQubmF6aW0uYW1p
cnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPj4NCj4+IEZvciBFMkUgZGVsYXkgbWVjaGFu
aXNtLCAicmVjZWl2ZWQgREVMQVlfUkVRIHdpdGhvdXQgdGltZXN0YW1wIiBlcnJvcg0KPj4gbWVz
c2FnZXMgc2hvdyB1cCBmb3IgZHdtYWMgdjMuNzArIGFuZCBkd3hnbWFjIElQcy4NCj4+DQo+PiBU
aGlzIGlzc3VlIGFmZmVjdHMgc29jZnBnYSBwbGF0Zm9ybXMsIEFnaWxleDcgKGR3bWFjIDMuNzAp
IGFuZA0KPj4gQWdpbGV4NSAoZHd4Z21hYykuIEFjY29yZGluZyB0byB0aGUgZGF0YWJvb2ssIHRv
IGVuYWJsZSB0aW1lc3RhbXBpbmcNCj4+IGZvciBhbGwgZXZlbnRzLCB0aGUgU05BUFRZUFNFTCBi
aXRzIGluIHRoZSBNQUNfVGltZXN0YW1wX0NvbnRyb2wNCj4+IHJlZ2lzdGVyIG11c3QgYmUgc2V0
IHRvIDInYjAxLCBhbmQgdGhlIFRTRVZOVEVOQSBiaXQgbXVzdCBiZSBjbGVhcmVkDQo+PiB0byAw
J2IwLg0KPj4NCj4+IENvbW1pdCAzY2I5NTgwMjdjYjggKCJuZXQ6IHN0bW1hYzogRml4IEUyRSBk
ZWxheSBtZWNoYW5pc20iKSBhbHJlYWR5DQo+PiBhZGRyZXNzZXMgdGhpcyBwcm9ibGVtIGZvciBh
bGwgZHdtYWNzIGFib3ZlIHZlcnNpb24gdjQuMTAuIEhvd2V2ZXIsDQo+PiBzYW1lIGhvbGRzIHRy
dWUgZm9yIHYzLjcwIGFuZCBhYm92ZSwgYXMgd2VsbCBhcyBmb3IgZHd4Z21hYy4gVXBkYXRlcw0K
Pj4gdGhlIGNoZWNrIGFjY29yZGluZ2x5Lg0KPj4NCj4+IEZpeGVzOiAxNGYzNDczMzRiZjIgKCJu
ZXQ6IHN0bW1hYzogQ29ycmVjdGx5IHRha2UgdGltZXN0YW1wIGZvciBQVFB2MiIpDQo+PiBGaXhl
czogZjJmYjZiNjI3NWViICgibmV0OiBzdG1tYWM6IGVuYWJsZSB0aW1lc3RhbXAgc25hcHNob3Qg
Zm9yIHJlcXVpcmVkIFBUUCBwYWNrZXRzIGluIGR3bWFjIHY1LjEwYSIpDQo+PiBGaXhlczogM2Ni
OTU4MDI3Y2I4ICgibmV0OiBzdG1tYWM6IEZpeCBFMkUgZGVsYXkgbWVjaGFuaXNtIikNCj4+IFNp
Z25lZC1vZmYtYnk6IFJvaGFuIEcgVGhvbWFzIDxyb2hhbi5nLnRob21hc0BhbHRlcmEuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogTmF6aW0gQW1pcnVsIDxtdWhhbW1hZC5uYXppbS5hbWlydWwubmF6
bGUuYXNtYWRlQGFsdGVyYS5jb20+DQo+IA0KPiBHaXZlbiB0aGUgb3JpZ2luYWwgZGlzY3Vzc2lv
bnMgdGhhdCB0b29rIHBsYWNlLCBpdCBzZWVtc8KgdGhhdCB0aGlzIGlzDQo+IHRoZSBjb3JyZWN0
IGZpeC4gQXMgUnVzc2VsbCBzdWdnZXN0LCB3ZSBuZWVkIHNvbWUgdGltZXN0YW1waW5nIHNlbGZ0
ZXN0DQo+IHRvIG1ha2UgaXQgZWFzeSB0byBmaW5kIHJlZ3Jlc3Npb25zIHdpdGggdGhpcyBraW5k
IG9mIHBhdGNoZXMsIGJ1dA0KPiBJJ3ZlIGV4cGVyaW1lbnRlZCB3aXRoIHN0bW1hYyBzZWxmdGVz
dHMgb3ZlciB0aGUgd2Vla2VuZCBhbmQgdGhleSBhcmUNCj4gaW4gYSBzb3JyeSBzdGF0ZSByaWdo
dCBub3cuLi4NCj4gDQo+IFJldmlld2VkLWJ5OiBNYXhpbWUgQ2hldmFsbGllciA8bWF4aW1lLmNo
ZXZhbGxpZXJAYm9vdGxpbi5jb20+DQoNClRoYW5rcyBNYXhpbWUhPg0KPiBNYXhpbWUNCj4gDQo+
IA0KDQo=
