Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D72D6E64
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208504; cv=fail; b=CcTsBahQ2+bp74W2bjS2nNQqxCKfXB52JTJUgzZvHNrxQaBfsHFu4BiiN7wdGTTBnf6zzlS87CBEiqV5NjfTGxryPX7M45u2igr8Ib+CcY6TYvg1pvhXtbJbgv4LDv5ApWQdnevg9WADt3RkA4AFZlEXxVOmppw8X133jzY0XaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208504; c=relaxed/simple;
	bh=Vw+VvbXgqWFIRoUREnkkSogyoJ5RQlyKZ3PgN94J/IY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/V2Gvu6ViDGDVDqQYZwWmC4TpFSUKCYEk7P2qsUMOTVoFhyA45G+mhe1sMGYXuOWhpQqbN1HP6cqs1cl1/wA9fKR7F/iYDRjOJa2JWmk/h19e1xOMDoWkp+ItvmUzxv19liz9MJ8+MktM2VeM3Sf8up2GmQyIWiIFjB6J07tvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=b7lgQVa4; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="b7lgQVa4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKrDT4S8XaS2MJKWpb0dYZJs13bcMvGIoloRPKwhepYltmW9DcuGdsa5JjH9/Br85+mI8gmyXps4AqCZprbbkhvc6FhejKwqZYbn/J/dkYQUgus2YtVAgkxsiFh79TQyZ6Y3BMsl/bMGo1+x/50p1OUAHIyQcOjFJwkPU/9zzI/7r/xuh4WFjl/tJhGtnwZyhEvaQAYDIHl4JGmR/Moq97r3NrtOn/20qtGy1ufu2IdvlzV28fO5dOSYMfKIEJbEaUpqaMIsTOuAJ9fmPBgw9ubk36vad3pYzjPJMVZcj0lGVSqrld47ZffcF4WGFAaSfx1F1HgrkH8AMsEZ5VwhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw+VvbXgqWFIRoUREnkkSogyoJ5RQlyKZ3PgN94J/IY=;
 b=mTWJ9IloXShPhwJLGBFyB5lYLBFR3bVxSbSTWLNtpMk4fuKCg5LgWhxpv0GTERfJVPLk3ioAU/RoyaenS4KRbbWRXVLbbx3FxoxUekpYpLxUC/5PQ+dvW6EOcdDI5Li2cWdxFGcZ+2KGHf9g49ZF0Rzdu2iti23rzWN6h6W/uVWq+wBprGtoGsbuKRviPRZQWaG/Q0rB5Jh8Ck1jUJNKgrV4pSuCaXTvXp3NAU++df69VniVWtktnqeSIQD5ZtftseleHtrHHYSn9dzwAgHs5JoCyLxgp6N+YoBnWO1I4gf0JlAiCydIhzvrThy5dyUkbKWFFuKVuwcRkSo3k2yP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw+VvbXgqWFIRoUREnkkSogyoJ5RQlyKZ3PgN94J/IY=;
 b=b7lgQVa49wulhXe7QmtztNVWfxI17PCfxBde7cNaavRRsilKLKqFdQqns+dxdWKVAzM2YRW84yGTlxt1GKp4JrzHSRvAoFD9ReFijmkfzwPHPcGLB0peT+YlEbDPxeT6E+Cxh/cK3Hb1xtbRl7BsS4+7jZYciiOZxumh93/0HqlmlmIcW8Iva/WsY7P7YM0sVIPaI3XSUYehBHSmJ+GaSSQ/EDwpd9Uq+CoFvGmCxuDgbDrfhSIDgAY59oLeDAM5QA6PJ2LcC3kEaobZuxzn67CC17qlBTXFZ5kXQbCFO8hyuyy/xrew0GU6D1pxg6DGr9qLvx089aPwxQNtPz6rXQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU7PPFF6B9802B3.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::aed) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3; Thu, 20 Aug 2026 06:48:19 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.003; Thu, 20 Aug 2026
 06:48:19 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Chuyf26 <Chuyf26@linux.alibaba.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>
Subject: RE: [PATCH] tipc: limit the memory pinned by incomplete fragment
 chains
Thread-Topic: [PATCH] tipc: limit the memory pinned by incomplete fragment
 chains
Thread-Index: AQHdLy6x+JB5kh+AuEyrMxcXMyDp7ramfrOA
Date: Thu, 20 Aug 2026 06:48:19 +0000
Message-ID:
 <GV1P189MB19888A7AA022334D4DB2F74FC6A42@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260818162633.AC2CF47D940@smtp.subspace.kernel.org>
In-Reply-To: <20260818162633.AC2CF47D940@smtp.subspace.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU7PPFF6B9802B3:EE_
x-ms-office365-filtering-correlation-id: a9f93c18-d36f-4fdc-921a-08defe87050d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info:
 4p6e3waBqGC9kP4mC/WJNulWtb/FmiDozXEg1KS2K3IVvmWp57q5Rqxa4tdgxgM+Qdh1JwyLa70UwSO5fTRhgZK9qM0Pe8q9u2k0+Dj9zbaGJm+48Ehj6BiN9wA+IJ7OeU3I1LcpUGxSbDc0WzGUigFWn/I7ElTXKQfBocNgfBkXV+l1whogQhVAoUjcGBHOJQFaSomlj8ZpxGpX9lpvqU/vqn/xe4xG5M8RckwuaSMv+lcwpKNe/jzdlcRIk2O2MHdCoOAelOgHvD2OpiI7g5m1nZgOheBmzaQbek+shQjkTEzvPlSNq2joMtpaxO03ZmU47NDl0uFg/ePTRxjXcVkmgu7rx39GxNBpAjvEvEH87sgjSUdH7pR4QqZjoLvcWS/d4oErgllOsndO9d9V2Mkxz1wpP85j8nSOX25YlHmiVGZpqJooxfz8Zveqjf8iLabTX3IRsNSiFi7RYohOlAGO53KNHLLQt7TUZKi/77HSmmPUR2NPyyEg6wUOnM5/a6Pk/bf/RQJwSwH8D/cYI4J76HH/Dc1VriAzqM7uWFwTybRvsOaIIhr5QzV+Ov88k95f/jtTJqEQOSK1db/RdRIhEVdBBlG27WWY3eEmRcm0oY0n82z+0PWFgKYr3FqBjRhx8tR8LT+3BtImrVwUmr8stgsGTZOlD1AS2Jr71TI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3dMRDU2TEg1M1hSZUtlRmFZZ0gvcGlnMzlVRzZES2ExOGloeERHUk5KeVFi?=
 =?utf-8?B?allQSnYrTlZYZHJWZGdweDJXTjhaWWJBMG5uTCtUVDhmNHdVMGRHUzcyMXhG?=
 =?utf-8?B?SE9sWDFUYWlGZEkyM1BzWGJFWkN5RWRjamhNelVhZHhCbUplSk9Xa1kvdXRi?=
 =?utf-8?B?Sk90ZEY3Qk1Pa0g3YWtWV2ExY2RmOTJYRmkvMGFDV3NQdE9LTjhIYUhaK3kz?=
 =?utf-8?B?bVpOeGRPb0lWTmN0RE5KWEp5MmtVVUE2bkRvYXYrdXBnVHY2LzY1WklRb1hK?=
 =?utf-8?B?OU1Jekh6YUp0ZE40ZDFVZnNucHRvSEt5aVB2T1hlamxWQkdpT3V0b3d2cU1u?=
 =?utf-8?B?WjFKRUVSSzBZNmhJT0V4aW1YcjhGeElSR0Jjb0hDL0ZPOFZlM2JqdUg2L1B1?=
 =?utf-8?B?dVlXWDNwSzRSUnNod3gxek1LRkI1Wkg5UXk0WkdabmtOVUQrcHZtRDZjREty?=
 =?utf-8?B?OGc5Sis4UUo3M1BOeFBsK1lWVXRpQnhlM3Rla0NXbWNBOU5nVi9rdWNpRkJu?=
 =?utf-8?B?cVk4K2JzVS8wQk8xdjBsZGhnWkh5bVk5RVd3RFg4cGd4OFFxODBpVTg0WGZX?=
 =?utf-8?B?dzAxM2lNQmtZbXJmeFJMd0RYelJMdCszdHlNMWk3OFJDRG5jOHZwTHhlMjVZ?=
 =?utf-8?B?TFpFcWlWWmU1V1FPRHVEZGE1WTRkaHgxS3BveXFxRWcza0wzclN1WHkwS3pL?=
 =?utf-8?B?VDA2cm1PY1BLR0MxMExMTFlSYmZEV1ZHWTc5K2JmNzhxQTQ0c2dRZldQKy93?=
 =?utf-8?B?WmRqMkJtcWc1aFFiTTU3NCtGTUlueCtOYVBTbWxXcE9uV0lGQVp2RldYNC9F?=
 =?utf-8?B?QjJkcTF2MUxjSDlXbVRUWlJQUTlTd1dtUTQwWWtkZXlMN05SR1QyOWc3YkZ3?=
 =?utf-8?B?TXZpTHA2Nm1RdExDYWxzL21nZ1RhZzIxNXJudW01Rnk0bkk2YVZjRnZLLzRu?=
 =?utf-8?B?anBBdU81ZmNmNXNpWnVGNUJNSUtKRWUvOHBIQlVlazNUb3ZzSktaNlBiQVVF?=
 =?utf-8?B?N1AwTjR3QTR1b0NIbTVvaGVNY2Frb2RWNEhyVmJHVCtwdVIvd3RocElhMlEx?=
 =?utf-8?B?WFFEQVJHeHhLYmhTblZXWFpYWXdqWUpPb3ZkLzZ3NW4vWm9VN0ljb2NKR29k?=
 =?utf-8?B?TTRrZHpzVjdVL25tU2tTS0MzZzk2c0ZSK05GdmxVTmcwRzdtdVd5RnpjU1FC?=
 =?utf-8?B?OTZoc3RESjcycThiRmIwMFowL1BONTBlWnBzREprSmZ2VXExQXNrckpWekMw?=
 =?utf-8?B?WW5kbmx3NGJuaEl6Y21MNnpKYm9oYzd6eDlPc0hPaDFlbEQ3ajJsbkVqU3FX?=
 =?utf-8?B?SEtPRFJXanZRRWpBc1ZQWWFJa3BRbGh2eGNJQnBHdFozQWtvaitnd1hXQ3A3?=
 =?utf-8?B?MmZseG1XbmMyNGRDTUZtYVZia0lkbnM1b2R0RjFid1BoWkRESEJsWU14NjRQ?=
 =?utf-8?B?TVdYak1WaU8relJSOVNrUG45b25DQ1FKaWpsUlQxaWtobWxrTU1xSVdEd245?=
 =?utf-8?B?bVE3NE9YN3ZROGFGQjVhbythaUU2ZzNwaDBpc0I1N1R6c3dkeHhONGdaSU5j?=
 =?utf-8?B?NnRCRjMzTmpYRjZiWXRUNytVYllENzh1cVM0SjVDZmVVNlYvOGVJWHJ3UnhJ?=
 =?utf-8?B?RjRZVlRqOE5HbHUzY2pacEppK2tNYVhML1FaY0VCNm4xb3oxRmRkUmxsUG9R?=
 =?utf-8?B?OTlXcE5PcFFTRlR6TUZHVE1ISWxpMG0yekNaU3JpZ2Y4K2xhMEdDaitSY29u?=
 =?utf-8?B?SW4rMEhOOEtydVhsSVlxMnFjMlB3NGs0aHlVS0NNa1pWeExJUDgyUHZ1ZFow?=
 =?utf-8?B?TGRvOEwzY01mazMwcHdhRmlkNlpWemVFQ3V0YjQvVEtXVjNFS0U0MHN5OUdQ?=
 =?utf-8?B?b05jWWtHQ3B3YlNuQ0hWNU9wYXBLaXl4MDB6cmU2dmVFbHhNV0RoVko0bkRY?=
 =?utf-8?B?Z3B1dGE5bnBFemxBaWJncXFhdVh5S0phclcwRWlJZWxoTkNuZTFTSVJDMHk3?=
 =?utf-8?B?OTdMNmcxK1F6TFBsbnI3a3BmY2lvVDB6SHJNdStsakdhWm4rR1c5MHQySHlP?=
 =?utf-8?B?SnBHZVI0Z01zdzBackRPSnhYbk1oZ0tSL3hiU2lOdytiQS9OUUJvaU1iTXdC?=
 =?utf-8?B?L3VnRlkyUkZHcWJvSVdEME4zRDJET0NOL3ZldGxIWG1CbmxzMjFhVStiUC9o?=
 =?utf-8?B?alVkS083VE5tL2RKSmFCT1E5K0FseG90ZGdKaEdPUzh3SVB4R1hSOXR6cGVu?=
 =?utf-8?B?MVI5NXI1TUVBQks4VE80RTgwRDM5akxtbnRvOXdBa01TOVRPd21Cby9neHVY?=
 =?utf-8?B?bzBXaXRDNjlxSmxVTFA2NUJMUHpEcTErUTczYjVhWENXNHU0ZGR1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f93c18-d36f-4fdc-921a-08defe87050d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 06:48:19.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sy+fk9YnDpZmfgUvkZIG04SgP7l/8+24Um0zSoMwCfba8MRLRCGFKzLAkBvCW+J4py71q9RPsQiChiD70wDTrFycMfxvJQSy3rFfrazs2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPFF6B9802B3

PlN1YmplY3Q6IFtQQVRDSF0gdGlwYzogbGltaXQgdGhlIG1lbW9yeSBwaW5uZWQgYnkgaW5jb21w
bGV0ZSBmcmFnbWVudCBjaGFpbnMNCj4NCj5GcmFnbWVudCBjaGFpbnMgYXJlIHJlYXNzZW1ibGVk
IHBlciBsaW5rIGFuZCBrZXB0IGluIG1lbW9yeSB1bnRpbCB0aGUgbGFzdA0KPmZyYWdtZW50IGFy
cml2ZXMuICBUaGVyZSBpcyBubyBsaW1pdCBvbiBob3cgbXVjaCBtZW1vcnkgb25lIGluLWZsaWdo
dCBjaGFpbg0KPm1heSBwaW46IGEgcGVlciBjYW4gc2VuZCBmaXJzdCBhbmQgbWlkZGxlIGZyYWdt
ZW50cyB3aXRob3V0IGV2ZXIgc2VuZGluZyB0aGUNCj5sYXN0IG9uZSwgYW5kIGV2ZXJ5IHJlY2Vp
dmVkIHBhY2tldCByZXNldHMgdGhlIGxpbmsgc2lsZW5jZSBjb3VudGVyLCBzbyB0aGUgbGluaw0K
Pm5ldmVyIHRpbWVzIG91dCBhbmQgdGhlIGNoYWlucyBhcmUgbmV2ZXIgZnJlZWQuDQogDQpUaGlz
IHN0YXRlbWVudCBpcyB3cm9uZy4gVGhlIHNlbmRlciBhbHdheXMgc2VuZHMgZmlyc3QsIG1pZGRs
ZSBhbmQgbGFzdCBmcmFnbWVudHMNCnRvIHRoZSByZWNlaXZlci4gVElQQyBndWFyYW50ZWVzIHRo
YXQuIFRoZSByZWNlaXZlciBpcyBndWFyYW50ZWVkIHRvIHJlY2VpdmUgYWxsDQpmcmFnbWVudHMg
YW5kIGlmIG5vdCAoZHVlIHRvIGxvc3NlcyksIHRoZSBsaW5rIHdpbGwgYmUgcmVzZXQuIEFzIGEg
cmVzdWx0LCAncmVhc21fc2tiJw0KaXMgZnJlZWQuDQoNCj4NCj5UaGUgcGF0aCBpczogZnJhZ21l
bnRzIGFycml2aW5nIG9uIGEgYmVhcmVyIGFyZSBkZWxpdmVyZWQgYnkgdGlwY19yY3YoKSB0byB0
aGUNCj5saW5rLCB0aXBjX2xpbmtfaW5wdXQoKSByZWNvZ25pemVzIE1TR19GUkFHTUVOVEVSIG1l
c3NhZ2VzIGFuZCBhcHBlbmRzDQo+dGhlbSB0byB0aGUgcGVyLWxpbmsgcmVhc3NlbWJseSBxdWV1
ZSB0aHJvdWdoIHRpcGNfYnVmX2FwcGVuZCgpLCB3aGljaA0KPmNoYXJnZXMgdGhlIGFjY3VtdWxh
dGVkIHNpemUgYWdhaW5zdCB0aGUgaGVhZCBidWZmZXIuICBUaGUgb25seSBzeW1wdG9tIGlzDQo+
a2VybmVsIG1lbW9yeSBncm93aW5nIHVudGlsIHRoZSBzeXN0ZW0gcnVucyBvdXQgb2YgaXQuDQo+
DQo+QSBsZWdpdGltYXRlIHJlYXNzZW1ibGVkIG1lc3NhZ2UgY2FuIG5ldmVyIGV4Y2VlZCBNQVhf
TVNHX1NJWkUsIHNvIGRyb3ANCj5hIGNoYWluIG9uY2UgaXRzIGFjY3VtdWxhdGVkIHNpemUgZXhj
ZWVkcyB0d2ljZSB0aGF0IHZhbHVlLg0KPg0KPkZpeGVzOiAxM2U5Yjk5NzJmYTAgKCJ0aXBjOiBt
YWtlIHRpcGNfYnVmX2FwcGVuZCgpIG1vcmUgcm9idXN0IikNCj5SZXBvcnRlZC1ieTogQWJhY2kg
PGFiYWNpQGxpbnV4LmFsaWJhYmEuY29tPg0KPkFzc2lzdGVkLWJ5OiBhYmFjaTpxd2VuMy44LW1h
eA0KPlNpZ25lZC1vZmYtYnk6IENodXlmMjYgPENodXlmMjZAbGludXguYWxpYmFiYS5jb20+DQo+
LS0tDQo+IG5ldC90aXBjL2xpbmsuYyB8IDE3ICsrKysrKysrKysrKysrKystDQo+IDEgZmlsZSBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBh
L25ldC90aXBjL2xpbmsuYyBiL25ldC90aXBjL2xpbmsuYyBpbmRleCA2YzZkODU0NmM1NzguLmFk
YmZkYzUwNThjYg0KPjEwMDY0NA0KPi0tLSBhL25ldC90aXBjL2xpbmsuYw0KPisrKyBiL25ldC90
aXBjL2xpbmsuYw0KPkBAIC0xMzQwLDcgKzEzNDAsMjIgQEAgc3RhdGljIGludCB0aXBjX2xpbmtf
aW5wdXQoc3RydWN0IHRpcGNfbGluayAqbCwgc3RydWN0DQo+c2tfYnVmZiAqc2tiLA0KPiAJCWlm
ICh0aXBjX2J1Zl9hcHBlbmQocmVhc21fc2tiLCAmc2tiKSkgew0KPiAJCQlsLT5zdGF0cy5yZWN2
X2ZyYWdtZW50ZWQrKzsNCj4gCQkJdGlwY19kYXRhX2lucHV0KGwsIHNrYiwgaW5wdXRxKTsNCj4t
CQl9IGVsc2UgaWYgKCEqcmVhc21fc2tiICYmICFsaW5rX2lzX2JjX3JjdmxpbmsobCkpIHsNCj4r
CQl9IGVsc2UgaWYgKCpyZWFzbV9za2IpIHsNClRoaXMgYnJlYWtzIGV4aXN0aW5nIGNvbmRpdGlv
bi4gU2VlIHNhc2hpa28ncyBmaW5kaW5nczoNCmh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNl
dC8yMDI2MDgxODE2MjYzMS5Ca1pBclp2LVhlMy1tNllXZ0g0ZC15eVF0eTNIb2dmVEJqOTNaaDFR
OVdvJTQweg0KDQo+KwkJCS8qIEEgbGVnaXRpbWF0ZSByZWFzc2VtYmxlZCBtZXNzYWdlIGNhbiBu
ZXZlciBleGNlZWQNCj4rCQkJICogTUFYX01TR19TSVpFLiBMaW1pdCB0aGUgbWVtb3J5IG9uZSBp
bmNvbXBsZXRlDQo+KwkJCSAqIGZyYWdtZW50IGNoYWluIGNhbiBwaW4sIG90aGVyd2lzZSBhIHBl
ZXIgY2FuIGdyb3cNCj4rCQkJICoga2VybmVsIG1lbW9yeSB1bmJvdW5kZWRseSBieSBzdHJlYW1p
bmcgZnJhZ21lbnQNCj4rCQkJICogY2hhaW5zIHRoYXQgbmV2ZXIgY29tcGxldGU6IHJlY2VpdmVk
IHRyYWZmaWMgYWxzbw0KPisJCQkgKiByZXNldHMgdGhlIGxpbmsgc2lsZW5jZSBjb3VudGVyLCBz
byB0aGUgbGluayBuZXZlcg0KPisJCQkgKiB0aW1lcyBvdXQgYW5kIHRoZSBjaGFpbnMgYXJlIG5l
dmVyIGZyZWVkLg0KPisJCQkgKi8NCj4rCQkJaWYgKCgqcmVhc21fc2tiKS0+dHJ1ZXNpemUgPiAy
ICogTUFYX01TR19TSVpFKSB7DQo+KwkJCQlwcl93YXJuX3JhdGVsaW1pdGVkKCJGcmFnbWVudCBj
aGFpbiBsYXJnZXINCj50aGFuICV1IGJ5dGVzLCBkcm9wcGluZ1xuIiwNCj4rCQkJCQkJICAgIDIg
KiBNQVhfTVNHX1NJWkUpOw0KPisJCQkJa2ZyZWVfc2tiKCpyZWFzbV9za2IpOw0KPisJCQkJKnJl
YXNtX3NrYiA9IE5VTEw7DQo+KwkJCX0NCj4rCQl9IGVsc2UgaWYgKCFsaW5rX2lzX2JjX3Jjdmxp
bmsobCkpIHsNCj4gCQkJcHJfd2Fybl9yYXRlbGltaXRlZCgiVW5hYmxlIHRvIGJ1aWxkIGZyYWdt
ZW50DQo+bGlzdFxuIik7DQo+IAkJCXJldHVybiB0aXBjX2xpbmtfZnNtX2V2dChsLCBMSU5LX0ZB
SUxVUkVfRVZUKTsNCj4gCQl9DQo+LS0NCj4yLjQzLjUNCg0K
