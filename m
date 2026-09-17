Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F139F190;
	Thu, 17 Sep 2026 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613402; cv=fail; b=rvvms7O7joVRaVT7kO5/QpbjLVXI/O2NZ6eQtH5cFeUP+IiOM1hwmOmAgC4Brt1MnJyw5H5qISub+QR+lIWE2WBDQBtPsl0cv1gl+sOCdIeeFj+5rbsE1UtZ8u8dN9KbUymWHPgozFzoBSYvUBMbJtZ+jrHsvLAYlJiDZd8ev8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613402; c=relaxed/simple;
	bh=qPxWsCMhOTEOA/afsFjVKEELsfbX36hpqjntXeNSsZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GsEBF2lZ6EFC+jVt6XJDFG03/vnyPpTVZ23asbM99hwIcgXJhLkdqlYYJiG4ssn8MoTA4TNFXCS4Pz9vbuPK0AS8nMXzATg4/6TLuvegzL9fPycUfp5o0gJc8huM2DcmUtYHm8EGdOGQHitrUzv9/EoqmRZGS35DOY0N9tRub9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WYwl3hhT; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WYwl3hhT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVCsaT+n/c6QDqdW7r2sp2G0EOe0wD9/f/UjQ7NhX9i6HcgFE5mb/xM6pC55WqvHjTEmN0WGo068n9CRaC46yWkKC+iWuSFYZ3AKFLD5W0whWyfJ4iSid8bu4iCIBZiLG4tWPWW46wMyucKNebP2wJKLLdm6fVZQ5B7ZPftbZDDaNdl7Rzc7qFvS1LsrvPCx1vSWOJWG4RWP8Oh6rcQGMi6ndQT4LqzJ3CAZmK7UjTClJdtXniEuKnd4dG7RlXbRNMT5WeDC/wH2ZuwDMZtLLERqU8orp4KaYQv+ib6XslX6/rrwZfPcUk3c8HMRqQfyDjlz6lGOb+WrAc/KvybhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPxWsCMhOTEOA/afsFjVKEELsfbX36hpqjntXeNSsZg=;
 b=cOBmoupR/iJHcvcjlaJQxhlVfQ/y6jJxYQ8pr+M7H3w0m+5FWVbOUsu2fkTKQmO1KhejFK47KbymBGY4gMX6T7AVdevSpZdbpgs7kf8ZoE5npXo4Ug++6O/0ghZ9N0OicL62pkBbMrOH1sjjq1bd3+Bl5H1sz/vQdQmUUwFVGHQqA/Wnkl6vNA+AEgUZSy/0D/FGYQYPTU2+RvEmtUSPLYuXFZ6XD+pQ14kUrfZuqTRWCX7omPopX0BHtVDSlppVD4+ObZuh0IKB89qWrLYrhy61xmRA/XnvmcmMlqmFwCeeyKoRy1OteWQZXabbQvP3/5bUJ5/n+eY9g6AQC8DNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPxWsCMhOTEOA/afsFjVKEELsfbX36hpqjntXeNSsZg=;
 b=WYwl3hhTa0OGZ09rvCYT3PXTWchkg34qo0b0zKmK0tefCbi1PONrpjzLD4F+rmDhcSBPIFo2z0HSXheXxZzubw4Zr5zp/GUpqJMHeMP7VzuYQRLDwn7gZdjw4NnJmMsqcbHKonIN56dP0f+L8ud/rU4VxTJez3egl0iwBo8KTvs=
Received: from TYCPR01MB7481.jpnprd01.prod.outlook.com (2603:1096:400:f4::5)
 by TYRPR01MB15821.jpnprd01.prod.outlook.com (2603:1096:405:2ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 02:49:30 +0000
Received: from TYCPR01MB7481.jpnprd01.prod.outlook.com
 ([fe80::8071:f03b:77d1:aeaf]) by TYCPR01MB7481.jpnprd01.prod.outlook.com
 ([fe80::8071:f03b:77d1:aeaf%7]) with mapi id 15.21.0428.009; Thu, 17 Sep 2026
 02:49:29 +0000
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Topic: [PATCH net v2] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Index: AQHdRk8pQQg5yBPFg0i+b+y+ykWM9Q==
Date: Thu, 17 Sep 2026 02:49:29 +0000
Message-ID:
 <TYCPR01MB748157ECB6B92D8E3FFD433BA4B82@TYCPR01MB7481.jpnprd01.prod.outlook.com>
References:
 <TYCPR01MB748139F059DF2459B9813416A4B92@TYCPR01MB7481.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB748139F059DF2459B9813416A4B92@TYCPR01MB7481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB7481:EE_|TYRPR01MB15821:EE_
x-ms-office365-filtering-correlation-id: c0876fb9-8795-4785-ac1a-08df14664b95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|10067099003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 3tIEw1G/O05J0OusRoz1Rlbw1//chiJlE9VMMoEHxy8GxGQUQwUoRIT0WYGKzL8uhS3YUy8IFar/+CsvnJhaWG5OLoMGKs9tnHjOZ0pg8IV1I3P8wE+0/Uv5U+8mUqieq5zhwHHmn1Ib5o4rZo4W1EGgt7wSlOhYX+LMINrhM9zNcjXRFN2aosdYUSTaIXwkQX6TUlKM76nMk5uWQ3INWv7zG/quHnl4MZT1udrl9Mn6P4hK6YQpGLYIZZh5ab1GtUgz36s0Gr+eU/u21ZdnEymlIoAJNAmpiELya3yQEW1nufh0m0tDmDFiKw3qttGnz/k98jyIX+dQO7qKuU2L3Cz+rcxnENx29YLVs+2t9sIbLVSpsKKbXSYc5jKKjqFY11xi5B6E0gFyewiGyGUVtOD0sL/I1x4NDVbR4hfCI6SpkcyNkDIbmkYGZigCCqGHsl5LSJsT0+1BAgjLk+EiyhA0eXJphWpuJG8iSQtg8e3dq4XS5uFJHCsDCHztnpI1YmcjYn39c8gPMqnwXPWOVz4ZSzCkNnucbRpreF0IVcgelWxEEIzgTZuVUWmQSG9jsVzEjrzrV2xGFIz7MPz37SfHP7UvCIu/eYL0tFF8IDFB3d5I5C3Vfub6hw2xKZazINvWKorXcvbhaiNHKl3IkAtW+T5679hzqFgeab9jCbNnMRTxb/FLh9/ePEtHF1PIphoODXkON44J4lA5KULTGXEBI15G27wqkzt9gs4IKKI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB7481.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0tGMEorbmhxVW44NTNCNGU1K3VtZFQwZzZpS0g0ajBteWJnRXZtSC9NR1pw?=
 =?utf-8?B?bzRQT0l3ZHRzSjc3WGtWMCtzWWs2N2NCaURzVU9GUjJ6QlFXb2lYaThtQ29R?=
 =?utf-8?B?Q3RvcVVDRllscU85amJjS1hURDNvM0J0M0p0WXJjd3ZmTUFuWXV5a2xJUnZn?=
 =?utf-8?B?L0JxakFqRHZYRkxuL1NwbzJkcnMyOUZwRFNWMFhxSldTcHZuS1FMTDNDdlF5?=
 =?utf-8?B?dWUrY0JaVVlTWFZqRnR5ZkJseU81YTJHaVMzTnJQdzVTSzVZMVBudUg4dm41?=
 =?utf-8?B?YWNMcmYrSEU3Y2tHTXh0blI4T0xVdGp0RHZYRlMyUHJRRHhKbS8rd1ViaTRw?=
 =?utf-8?B?cFZ1ZkxMeVIxRnBwQlQyL2VuVlZ1bWNFQVZRR2ozQ1ZEdXg1b1BWd2FodmNY?=
 =?utf-8?B?NTBSbVFnUTkvSnFUOE5mR1ViUzhCVmNIMXlwU3lVdU9uY2QrL1J4TnNFcUlI?=
 =?utf-8?B?b0lBVGpRRW1iMG9VSHh3eHBsVVljZ2dKMVp5YkhKMmsvSm1rSHBrZ29NTXBh?=
 =?utf-8?B?WUF0S3NFK2tVTWhVZ0pGRW1MdXhJbmY2NHBMQm9JL1JkZmJvYU5DdWxGOHZS?=
 =?utf-8?B?djkwWTI3U3B2QWF1dnNZNHZNajV2Z0p1U0hLTHFoOHJmMlU1V01ZaGNLZmxF?=
 =?utf-8?B?NklKUEFLMW9PSzM4NWhobXpoemZuOXM3TWYvWmNYeWdrT1IyeDhjZVNZOU1w?=
 =?utf-8?B?a0lSZHdHb0wrdGlPdHc5VkRkMWlPUUczaEl2bGNPSUtnT2o5RUU4ZSt6Wmd3?=
 =?utf-8?B?QjdiU2xTMS9zT3FST2tBeUF1cVdCZWowWkZoUGZwZWxWZ2FSRkcrcnRyQWVv?=
 =?utf-8?B?enhmZ2lmL0ovdDUyKzJzODg4TXhHemRXdGFxUWNhNGdQWU51WkZodW1mV0Qx?=
 =?utf-8?B?aW9SSzhVUHdHNUdCQ1ZORTNEN3kvSHcvTlNuMHFsdmVrcU0zanNuMWlIcXZ6?=
 =?utf-8?B?RFl1VzY0bUJDTEZzbzMvYzU3YjVsZU0xU0NTclZ3VW1JemlHZzBEclJFQlNh?=
 =?utf-8?B?OC9aeEFxRlp6SWVWakozQnFkVnpwNFc0RTFYNU9tRDlRSXp1ckZualNYSUNr?=
 =?utf-8?B?dTM2aU02bFFyNk5aQXViSFVVL25jZnpyczNEVlNGQTZaWXBYUUI4NzlrM1VE?=
 =?utf-8?B?SGFVUTBJZkpwd2xTM2tITkRCM3hLeWF3cmlaQzFUZnFXSk95SHl2bG5tbHZ3?=
 =?utf-8?B?ZlRBSzFRQ1NPWGtDTVFRckV5T0s1eFY1bStYRlpiS1JyajBudkdIdzJTUFlK?=
 =?utf-8?B?N3J0WUV3cnBkQXAzZUtDL2xQcCtvUWJiV1M1Z1hCcDRqOFZSU0JsQVNZYmRq?=
 =?utf-8?B?OUpoNGRuWVoyVEUvNzgvN3F5QUFVdE5PV0E3aERiWk80OHZaYlFkSXBzYWNo?=
 =?utf-8?B?enJhaWhRdHorbGw4ZnlUdWZIazdGNzY2Y2s0c1hQTE9hTzEwQndodHNNRW5L?=
 =?utf-8?B?VkkyQW9lODFZR0puOE8wUmRGZDBFSlV0YnpnZGtweElDTnNYeHBPb0ZlSlZM?=
 =?utf-8?B?Z05tME5xRVJrRVNzUUNFTjM0RnBjOFY3MjZURmtGdlRwWmNnOENaRU1XVllN?=
 =?utf-8?B?UWtsdm92c2s0REJnNVErSTFFaXlRSEN4Z3hHTlhJSHRIRVpJblU0LzZESDBi?=
 =?utf-8?B?L2ZFRmNHYkNoRm9LRzJza0MzaFphUEdTMUlrM2J3L0NtUW9TdnJiN1QrOU45?=
 =?utf-8?B?czk3UE5aNDJYWWcyMzhtT3creVU5Y3JsajVKS0NCRHJqelg4b2pGaitrdHFy?=
 =?utf-8?B?MXNoVit6SDhUMnpPSUpOd2pQcTcwV3hrSUhVbWFWK3o1eSsrL0hQMWp4V3Q1?=
 =?utf-8?B?SkpPaEdFaVpsSjdjK1d2TGZsOS9idUt2bXNVdXlvNjlhUlRXenMrK0NQY2U5?=
 =?utf-8?B?MjlRUmJ6M09nNGxvZURhUkhnZE5oUXRrVDlKRlNZbEQ2b2FuTUhhVSs2Yi9X?=
 =?utf-8?B?Zkptam1vRTZ0N3FHckowUXpHYk92WkdQeDVDWnhOc2xJOUp5cjBTVGxhblpQ?=
 =?utf-8?B?RzRyalRPd0xFVW40WGZwTHNhVnFoOVp3NElJQjUxMkRsNWdKcmdVbDJ4eDhy?=
 =?utf-8?B?YStqd28za2RJZWU5V0NBYlVZVEUzaGJveHZ5MEk0cGZVOFloOTlDNEMrNy9W?=
 =?utf-8?B?MS9pd3pSV0hhSDFzQUFCNjRyN1Q2WmlpU2pQRExVK29uWHhyVEJUUWQyT2dv?=
 =?utf-8?B?c2VRUXpkQWREVXE2ZDRxeWJkYW4wT0tyNjgzUHUrWFRVZk13dWR2ZUg5bURz?=
 =?utf-8?B?c2cwQ0F3VEpiczFKM09zbXNvZlAwVWN5NXBNaVhScncxN0ZQbGhCVVpnMDUz?=
 =?utf-8?B?OTdDdGpicFltRS9SWkZwOFEyK1prTWN3ZXBtR0xaTXJOUFBiTUdrbDlnZUJS?=
 =?utf-8?Q?qGi2BTAlSL/L6us0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0876fb9-8795-4785-ac1a-08df14664b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 02:49:29.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUaovxwkVhGooVZQQAQpnW1tk07Fh2kh1HuZ5lF2PWYh/b/h/xQnW9qDDYTtPO60zZGAGMVkJ++7KLpbFu5Of5ttFIGWTYZn4jNb0KSTA8zk7lMD0deb1ruFzg8OKPGJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15821

T24gUlovVDJIIE1JSUMsIHdyaXRpbmcgMHgwMDAwIHRvIFBSQ01EIHJlc2V0cyB0aGUgY29tbWFu
ZCBzdGF0ZQ0KbWFjaGluZSB0byB0aGUgSURMRSBzdGF0ZS4NCg0KUmVzZXQgUFJDTUQgYmVmb3Jl
IGlzc3VpbmcgdGhlIHVucHJvdGVjdCBzZXF1ZW5jZSBzbyB0aGF0IGl0IGFsd2F5cw0Kc3RhcnRz
IGZyb20gYSBrbm93biBzdGF0ZSwgcmVnYXJkbGVzcyBvZiBhbnkgcHJldmlvdXMgUFJDTUQgYWN0
aXZpdHkuDQoNClNpZ25lZC1vZmYtYnk6IFlvc2hpaGlzYSBZYW1hbW90byA8eW9zaGloaXNhLnlh
bWFtb3RvLnhuQHJlbmVzYXMuY29tPg0KLS0tDQoNCnYyOg0KLSBGaXggaW5kZW50YXRpb24NCg0K
IGRyaXZlcnMvbmV0L3Bjcy9wY3MtcnpuMS1taWljLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Bjcy9wY3Mtcnpu
MS1taWljLmMgYi9kcml2ZXJzL25ldC9wY3MvcGNzLXJ6bjEtbWlpYy5jDQppbmRleCAyYjcyZmE5
OGQuLjgxODc1NmJiOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3Bjcy9wY3MtcnpuMS1taWlj
LmMNCisrKyBiL2RyaXZlcnMvbmV0L3Bjcy9wY3MtcnpuMS1taWljLmMNCkBAIC0yNzAsNiArMjcw
LDkgQEAgc3RhdGljIHN0cnVjdCBtaWljX3BvcnQgKnBoeWxpbmtfcGNzX3RvX21paWNfcG9ydChz
dHJ1Y3QgcGh5bGlua19wY3MgKnBjcykNCiANCiBzdGF0aWMgdm9pZCBtaWljX3VubG9ja19yZWdz
KHN0cnVjdCBtaWljICptaWljKQ0KIHsNCisJLyogUmVzZXQgUFJDTUQgc3RhdGUgYmVmb3JlIHVu
cHJvdGVjdCBzZXF1ZW5jZSAqLw0KKwl3cml0ZWwoMHgwMDAwLCBtaWljLT5iYXNlICsgTUlJQ19Q
UkNNRCk7DQorDQogCS8qIFVucHJvdGVjdCByZWdpc3RlciB3cml0ZXMgKi8NCiAJd3JpdGVsKDB4
MDBBNSwgbWlpYy0+YmFzZSArIE1JSUNfUFJDTUQpOw0KIAl3cml0ZWwoMHgwMDAxLCBtaWljLT5i
YXNlICsgTUlJQ19QUkNNRCk7DQotLSANCjIuMzQuMQ0K
