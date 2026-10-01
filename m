Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A734ACC68;
	Thu,  1 Oct 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845409; cv=fail; b=hGVy0oP9UU5lfx7qfUM5Pbe27zccOn3RKjU849LA5GT4zHIzBBAliv86CFZ1diBczidxxnV1mUla02EAPv6SjHzhsRb38uG/8WQZYEheuhton2lzR+C6Hmqq1/H0ELDaKrw9Qws3jlEYzQ2KXHNnZmi6pu6QopUPoaG/zhcFzgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845409; c=relaxed/simple;
	bh=Iwt2FcZTUcN/btxjRsH2ZPlE7NgDh1TFOQWaEEJi1PU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uAMNyltUmRU2W68D0Z9Oi9KB8/aasYWQztn01ZZ3ZNnuuFgNVz5hEQMAT9d6B4djFzZHVslQZqNnNoROMa+E75lOU2846t7k3pd16wsLRjEHcy1w6WgZoTKsgan5JQrfe0l/Xflt8o4OwPgQEOlgJvZhED65Pnp50W7rAi7tRFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zkTiiJRt; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zkTiiJRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvDxz2jaA8jdEYcRAFRu7qbJdO4Fh0dVfmTBOqRrjC8mdHlVuCF2/TuHKK+Mf5OiDSjgbvR/zueetn6Sk4aePkHSXy9iTHgcb0WSc33zbqdOq26Gw0Zhlf4eRYvkn6fSdjA0TrwAY5/G5BYGJdi9+QZSEcRU/ZoQf/YdB9mjKF5LFQjmCkmKunrFPr/8FQ/YE/P5mIv4kmk9T69iBaDej9/txxvM1HKrUDlrYaOBuv+xuPn6Ada5Zs0Lox5/GI5oY4qqi06qZCDX7sE72HC+zic0QnMt7rF5q0gpvWtsdKqel8aISUv9As0YSh6LmaTLJKmv6e1SahPdsip+87HLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwt2FcZTUcN/btxjRsH2ZPlE7NgDh1TFOQWaEEJi1PU=;
 b=bHElAwdq1RldKuloqJlxKgMaLsiKI+b6B47yi+/pWEmQVl0x+xcpvehXZz/T/oI40FtNBAXW5VplAypdWwVa6sHN2S6lmndoMeTpsEiHyqG6Hz2NR7i2OhtREWfxVPsBxb2Ob2yHcA5pR2gabO1l407C7yFWRoPLNs1TUpSZHnIa3hW6Sq1USlQtqWAkhYKJXn8g5Vq6E0Ykir7k8wAWJauOT29Aals96CULqSwd1fqWFdOfCYnwU3jkyTViG0o0hdL1Bodc89A/uQTpUoy3QpMjY5r6hQC6+SA18rZ+586TZlNmg5xCjpdIvVNR0t+i5EcOHaWPn2m41E9GELk1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwt2FcZTUcN/btxjRsH2ZPlE7NgDh1TFOQWaEEJi1PU=;
 b=zkTiiJRtofr1m0n4CobcpHoyT4/kPgg6ybnFeC1ZbAsOzE42SDH6nJdgBNOrEBbDjNJcmKBlb+V04Vz7HlL+0cSsYCE2A8nxtme21jQuqK5rPUC0sHdY15ig+5hyOrYNmbpgQ/A8b7waqAJrXTMjV1DoyvtSq6Jxf+Rez+LwHWFrOJyIk6mOzrfKB7j65BA9j7aK/ZSLDgzrgHb6b6JGxQ+AmYXz9I3Qnxup/Xg7o+FoWvZBZmQcm1UMFHG8toApU1cIetouBkMvb8x5fwnYr0H9UdqkG8shkhntxajUIdDyplrKG9E+K8s0/lv/wH4om2c4Sckd35zO5djHlftV7Q==
Received: from DS6PR11MB523643.namprd11.prod.outlook.com (2603:10b6:8:468::12)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:03:22 +0000
Received: from DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954]) by DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954%4]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 09:03:22 +0000
From: <Manikandan.M@microchip.com>
To: <mwalle@kernel.org>, <pratyush@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v7 3/7] mtd: spi-nor: sfdp: expose the SFDP as a read-only
 NVMEM device
Thread-Topic: [PATCH v7 3/7] mtd: spi-nor: sfdp: expose the SFDP as a
 read-only NVMEM device
Thread-Index: AQHdKkh8ssbUvMZsfEyMbU+NvXWKVbbDPUYAgCQBoACAAXP0AA==
Date: Thu, 1 Oct 2026 09:03:22 +0000
Message-ID: <b175bb3b-7678-4966-974f-6636feed8d83@microchip.com>
References: <20260812104955.485667-1-manikandan.m@microchip.com>
 <20260812104955.485667-4-manikandan.m@microchip.com>
 <DL93QHVC01B9.3U3K1G8NC0MZA@kernel.org>
 <7412c28b-28ec-41f1-b083-ccb2510e3341@microchip.com>
In-Reply-To: <7412c28b-28ec-41f1-b083-ccb2510e3341@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS6PR11MB523643:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: 01375f5d-b207-41ab-8c9d-08df1f9ad874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|38070700021|921020|4143699003|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info:
 rRU5MFW96f+YcXFaOP45Qw4Dq653TUaYYzht3hWfylpkdwERZSOLKPxwYY7RD7j88pIhcHWMdz7TBoB39LJJFtQQF7/cGupeLhZNDcZ1HQ3f2VsoR6DXokdFl4aUt152KrsYBR+M6YYxYDHdMSD7nLnTVLukNIRm5HfRQ5NjuBT132SLxfTvqYsHtAJv1eNWcdl+/FhIXvxR1gOH4LpJh85vhB3oLM0443LaekUO7zLzUhXK4t+GghUyw57+J9w8RbRtL8noq1AXit7fl6RUpypwumOERpG/S+O2h25jmReV420X4K3EcBtU8hKr1onKofErVcIDDTbWW4mVqH6OsL/APHyUlNlNYhNe686JK2D7fsLJVsoG0v+EJA2bJS2grStFtCCxyz8rm7OaJt/APU+vQpDE36VNnCu9kqAW6NLDP0yvJbcwkS+Zc8iC7UEhTP0tfwVDOEDLD+TaUgQfs/obnutru2kANKMpGRDsA6x4eYFU9HNHVMQ0EoPq8oQIwWRhEjCvikPl9X9W81lFLhJsdLGlB0V9bwWaSw4V4z7vtxcu/B5Uu68CozT0gS1MIUaNYCNgIx9cpjSVpWAjx4Kei6gg9sbY6FknyCLjid/uBwt31MJsFXK6O3l8MEzKwMlEYeuJPFUYNNfoLwAzgqbvYBLHgNber+er6MqnnQU6ClPEPpTG2Zq6Fldkk1CRRmSFZwjYddGjZEbHZjxNZfz/6ApCBXBPPUu1Fj3l7AxwVox9x18Z42azNGA6XJXI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS6PR11MB523643.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(921020)(4143699003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnM3N2NiZlBJYVZYOTh5QmkyOUMyMUlRbis0aU9jVnhnckVhVGlNM0J2VDZL?=
 =?utf-8?B?NzhSeThmN3YwZ0hadGRvVE8yQ2dWSDdHSzBZU1F1bjQvMkVyeTNOOUJVSDVI?=
 =?utf-8?B?c1pqM3pKTk1IeWNrWGkxU0FZRVFvWjBrUDJQSHdvUWU2OFdWWENZaEZGNCtE?=
 =?utf-8?B?NWI0RWcybTVmb2xzRndET1RLQ05CZmFrZ0M0VkNuc25FS2lJSHNKaW5qZlpM?=
 =?utf-8?B?WGFGdDdITHlTQjZRR3RhLzd1Z0dVZ29uQmIrU010S2RzVk1JckNva1RESW05?=
 =?utf-8?B?UEd5K2hLME43MXlrOXlvb0I2SlJ5RHVmc3YxUjl0d1lsQW9jWWpiMWhBa1M2?=
 =?utf-8?B?OU04RHhWS3ZiaUprbXJuQ2tNZVkvd0ZkemNxRTF3ekFZcUdMaXJNZUhkN1p6?=
 =?utf-8?B?b0JKZndjSEd5VlcvYWxsSGFPQWhCR3lIWFkxK3JHaHZZam5Wa296NHNUTmF4?=
 =?utf-8?B?TkxvUWw0bGNCZm5HaS92b3FkVmNsWE5oRk45QjZzWTNNeFdCY245UWk4WXI0?=
 =?utf-8?B?TlN1M3R4dU1TdUQzVnlmakVOVk05S1N0cUtSd29veXZib3NqL2wxaUVVOTNz?=
 =?utf-8?B?MzhoeUQycTJjcWpFSVVCVkMwaGVmbEhWWnkzYnNJTTliNFd2VVVkMkhlbHZL?=
 =?utf-8?B?bnJweCsrQ3hNR2NQV1g1Z3Qyd0FtMWtnNEQzOFh3UmlYZk9rczVydlhwcTdj?=
 =?utf-8?B?QW1aOEVITlcvTFNscWtEUGVqY2VnSEp2WTl2ZHo2Um4wbmUyNW1SdnhUL0xu?=
 =?utf-8?B?Q3daTlkzQjV5VmtrNmVGQ2tXVEZIS1FzbVpieDBXZVFOaFpUM2xDYmQzTStG?=
 =?utf-8?B?c2Y5cGsxOHB3bzlCZ2dZekVObEpJK0MzemZ5cUc5aVo5Ky95SFQzbm91Q1hl?=
 =?utf-8?B?aFpJTFpSMTN5ZytlbS9BSTJaeFhCVExrVEJSRVlJSmowT3pudHlRVE50UkNP?=
 =?utf-8?B?QUhCZTR5ZnREQ041S0pzeGhkNlVQRittSXJGR25Dd3IzNXplRk9STURYM0Y4?=
 =?utf-8?B?M0owc2pJbXgvUDRoeGVNaEIwYWc5R1ROYis3aHhrRHRJcEFmaWFsaGNqTGRl?=
 =?utf-8?B?RDROVm5jTGdkQ25nR0ZJSUtyQ2VyYVJKMkY2Mk5MenFHWFdvM1Z5OFV6Y0M2?=
 =?utf-8?B?QW5uVGNRMGdwSSs4UWNuQ0FYdWZSZWV6U2RMcHBOYVNqSkdXVTltVVhheG5z?=
 =?utf-8?B?U3lXMU1VZ295RkRjcENUU3dlbHJNZE5IZllReVB5bURhV0l0RkxhRDNQOGZ0?=
 =?utf-8?B?N3ZDZG0rV3BZMStMSForcW9CWDRsWHVsY1BHMUJRc21WUHZZcTRIdFgyM3da?=
 =?utf-8?B?NGo4YWw4anJha0ZxS0haY2JybkdxUHZ2THZiRi8rQnhXcDBINHBNcXNWdlN0?=
 =?utf-8?B?ZnRxcDhJaW4vMlk5TG5CbkJERnJhZWx0QU5qU01maHUxZEFaYUl3d2FITG5M?=
 =?utf-8?B?dUZkMFlPT3V5QW1TcVI0M1EzL2ZPaWYwS2ZVcmwwSnRYTmNiYjlXOFVrb0E4?=
 =?utf-8?B?SGRIRjJEVDFWdTlDeHlCYjZhT0FCQkgyc09ac3FXR1BuR01zMVo3UDcvd3o2?=
 =?utf-8?B?NythZ3RRcVVvSDBObjZaaHJTT2h3MVBhNW1KaklYWWtyRVVER0VjZWRBTWg3?=
 =?utf-8?B?T1BsZWxPS0tQZlMyRmJZRnhXZFM0NkRIVHUwbWkzTmpaaDlWQjF0NS9ITWxw?=
 =?utf-8?B?ZGFVYmYxcTFHK0JXRkZtc1czR2lQbGpWSUtSVlB5ZXU3YXhmS0p4alpKazNI?=
 =?utf-8?B?WktLdVpLOXJBLy9VOFltTG1SUkNmUHBzeE1zOWJjbEkvU0pKSlBnVVNUUklH?=
 =?utf-8?B?bHhKVGFuVTFkWlJZMEJFdW5UWHZESmVMZmJkSUNCbVh2ODk3UFNscTZzZWN5?=
 =?utf-8?B?V085b1llbG5zVGpPTmx0bjlBZTlpR003Mkt3RFBSNzQ5cm1jSGdjR2hFS1U2?=
 =?utf-8?B?NDZJc3NNcGs1OUt2RytkU2tQVkp3RmxrdjBIOXZ2UjQzRWJqUVBCczNvWjNV?=
 =?utf-8?B?cy92SmFUYk9UVTZJUE5FdElFeVoxWTBFM3BVNGNURWZMeEhNWWVRSkdKYnRm?=
 =?utf-8?B?YVVNMk5vZGpuT1prY212WjdqZFNSRkJKTjFRMmpQaG44N0FkSDI4UGJvUzdE?=
 =?utf-8?B?VkJBMzIrUk5Pck92Mmo3cUlmUExlTjFIR1RRQmwrOTFkdUNYbGVWVWFieFBi?=
 =?utf-8?B?bGtKam5hRXBPcnFjN1dvQ0lESVkvaGphNDl1cTlUcHg5bTFoRzBZYXRxZWxH?=
 =?utf-8?B?T2x6SlBBWnNEeTlrUWQxajEwT3ZMeWNiMmIxTVdUaXlNQzZSUmdkYW5ETmlm?=
 =?utf-8?B?YUJQQ2g5YmV5NEZMMlZTbDRHMGpiREpMcGNSaFNOWVN4cTRYZG5ydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4CE23AAB8CCA24BA49A833C25770955@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB523643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01375f5d-b207-41ab-8c9d-08df1f9ad874
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 09:03:22.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6D2Dip284SNu3VtJSm73E5ajlTKwtvP+6os6/vucPdvsTrlF/O+DQleVHC/H4rXelm6KlIAbq0HplEOgo2DunJbOgKdFrVyfbP+1Fkwjj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784

SGkgTWljaGFlbCwNCg0KT24gOS8zMC8yNiA0OjIyIFBNLCBNYW5pa2FuZGFuLk1AbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4gSGkgTWljaGFlbCwNCj4gDQo+IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXBs
eS4NCj4gDQo+IE9uIDkvNy8yNiA2OjMwIFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4gSGks
DQo+Pg0KPj4gT24gV2VkIEF1ZyAxMiwgMjAyNiBhdCAxMjo0OSBQTSBDRVNULCBNYW5pa2FuZGFu
IE11cmFsaWRoYXJhbiB3cm90ZToNCj4+PiBUaGUgU1BJIE5PUiBjb3JlIGFscmVhZHkgcmVhZHMg
dGhlIFNGRFAgdGFibGVzIGR1cmluZyBlbnVtZXJhdGlvbiBhbmQNCj4+PiBjYWNoZXMgdGhlbSBp
biBub3ItPnNmZHAtPmR3b3JkcyAoc2VlIHNwaV9ub3JfcGFyc2Vfc2ZkcCgpKS4gUmUtZXhwb3Nl
DQo+Pj4gdGhhdCBjYWNoZWQgZGF0YSBhcyBhIHJlYWQtb25seSBOVk1FTSBkZXZpY2UsIGluIG9u
LWZsYXNoIGJ5dGUgb3JkZXIsDQo+Pj4gcm9vdGVkIGF0IHRoZSBmbGFzaCdzIFNGRFAgY2hpbGQg
bm9kZSAoY29tcGF0aWJsZSAiamVkZWMsc2ZkcCIpLg0KPj4+DQo+Pj4gVGhpcyBsZXRzIE5WTUVN
IGNlbGxzIHJlZmVyZW5jZSBhbnkgU0ZEUCBkYXRhOiBhIGZpeGVkLWxheW91dCBmb3INCj4+PiBw
YXJhbWV0ZXJzIGF0IGEga25vd24gb2Zmc2V0LCBvciBhbiBudm1lbS1sYXlvdXQgcGFyc2VyIGZv
ciB2ZW5kb3IgZGF0YQ0KPj4+IHdob3NlIGxvY2F0aW9uIG11c3QgYmUgZGlzY292ZXJlZCBhdCBy
dW50aW1lLiBUaGUgZGV2aWNlIGlzIG9ubHkgcmVnaXN0ZXJlZA0KPj4+IHdoZW4gYW4gInNmZHAi
IG5vZGUgaXMgcHJlc2VudCBpbiB0aGUgZGV2aWNlIHRyZWUuDQo+Pj4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+
DQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCA3OCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA3
OCBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4+IGluZGV4IGNjZjQzOTZj
ZGNkMC4uMDQyNWFmNmU4OThmIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+PiBAQCAtMTcs
NiArMTcsNyBAQA0KPj4+ICAgICNpbmNsdWRlIDxsaW51eC9tdGQvbXRkLmg+DQo+Pj4gICAgI2lu
Y2x1ZGUgPGxpbnV4L210ZC9zcGktbm9yLmg+DQo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L211dGV4
Lmg+DQo+Pj4gKyNpbmNsdWRlIDxsaW51eC9udm1lbS1wcm92aWRlci5oPg0KPj4+ICAgICNpbmNs
dWRlIDxsaW51eC9vZi5oPg0KPj4+ICAgICNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3Vt
ZXIuaD4NCj4+PiAgICAjaW5jbHVkZSA8bGludXgvc2NoZWQvdGFza19zdGFjay5oPg0KPj4+IEBA
IC0zMDAxLDYgKzMwMDIsNzUgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9pbml0X2ZpeHVwX2ZsYWdz
KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+Pj4gICAgCQlub3ItPmZsYWdzIHw9IFNOT1JfRl9JT19N
T0RFX0VOX1ZPTEFUSUxFOw0KPj4+ICAgIH0NCj4+PiAgICANCj4+PiArc3RhdGljIGludCBzcGlf
bm9yX3NmZHBfcmVnX3JlYWQodm9pZCAqcHJpdiwgdW5zaWduZWQgaW50IG9mZnNldCwNCj4+PiAr
CQkJCSB2b2lkICp2YWwsIHNpemVfdCBieXRlcykNCj4+PiArew0KPj4+ICsJc3RydWN0IHNwaV9u
b3IgKm5vciA9IHByaXY7DQo+Pj4gKwlzdHJ1Y3Qgc2ZkcCAqc2ZkcCA9IG5vci0+c2ZkcDsNCj4+
PiArCXNpemVfdCBzZmRwX3NpemUgPSBzZmRwLT5udW1fZHdvcmRzICogc2l6ZW9mKCpzZmRwLT5k
d29yZHMpOw0KPj4+ICsNCj4+PiArCWlmIChvZmZzZXQgPj0gc2ZkcF9zaXplIHx8IGJ5dGVzID4g
c2ZkcF9zaXplIC0gb2Zmc2V0KQ0KPj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPj4+ICsNCj4+PiAr
CS8qIFRoZSBjYWNoZWQgU0ZEUCBpcyBrZXB0IGluIG9uLWZsYXNoIChsaXR0bGUtZW5kaWFuKSBi
eXRlIG9yZGVyLiAqLw0KPj4+ICsJbWVtY3B5KHZhbCwgKHU4ICopc2ZkcC0+ZHdvcmRzICsgb2Zm
c2V0LCBieXRlcyk7DQo+Pj4gKw0KPj4+ICsJcmV0dXJuIDA7DQo+Pj4gK30NCj4+PiArDQo+Pj4g
Ky8qKg0KPj4+ICsgKiBzcGlfbm9yX3JlZ2lzdGVyX3NmZHBfbnZtZW0oKSAtIGV4cG9zZSB0aGUg
U0ZEUCBhcyBhIHJlYWQtb25seSBOVk1FTSBkZXZpY2UNCj4+PiArICogQG5vcjoJcG9pbnRlciB0
byBhICdzdHJ1Y3Qgc3BpX25vcicNCj4+PiArICoNCj4+PiArICogRXhwb3NlIHRoZSB3aG9sZSBT
RkRQLCBpbiBvbi1mbGFzaCBieXRlIG9yZGVyLCBhcyBhIHJlYWQtb25seSBOVk1FTSBkZXZpY2UN
Cj4+PiArICogcm9vdGVkIGF0IHRoZSBmbGFzaCdzIFNGRFAgY2hpbGQgbm9kZSAoY29tcGF0aWJs
ZSAiamVkZWMsc2ZkcCIpLiBUaGlzIGxldHMNCj4+PiArICogZ2VuZXJpYyAoZml4ZWQtbGF5b3V0
KSBvciB2ZW5kb3IgKG52bWVtLWxheW91dCkgY2VsbHMgcmVmZXJlbmNlIGFueSBTRkRQDQo+Pj4g
KyAqIGRhdGEuIFRoZSBkZXZpY2UgaXMgb25seSByZWdpc3RlcmVkIHdoZW4gYSBjaGlsZCBub2Rl
IHdpdGggdGhlICJqZWRlYyxzZmRwIg0KPj4+ICsgKiBjb21wYXRpYmxlIGlzIGRlc2NyaWJlZCBp
biB0aGUgZGV2aWNlIHRyZWUuDQo+Pj4gKyAqDQo+Pj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNz
IG9yIGlmIHRoZXJlIGlzIG5vdGhpbmcgdG8gZG8sIC1lcnJubyBvdGhlcndpc2UuDQo+Pj4gKyAq
Lw0KPj4+ICtzdGF0aWMgaW50IHNwaV9ub3JfcmVnaXN0ZXJfc2ZkcF9udm1lbShzdHJ1Y3Qgc3Bp
X25vciAqbm9yKQ0KPj4+ICt7DQo+Pj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBub3ItPmRldjsN
Cj4+PiArCXN0cnVjdCBudm1lbV9jb25maWcgY29uZmlnID0geyB9Ow0KPj4+ICsJc3RydWN0IG52
bWVtX2RldmljZSAqbnZtZW07DQo+Pj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPj4+ICsN
Cj4+PiArCWlmICghbm9yLT5zZmRwKQ0KPj4+ICsJCXJldHVybiAwOw0KPj4+ICsNCj4+PiArCW5w
ID0gb2ZfZ2V0X2NvbXBhdGlibGVfY2hpbGQoZGV2X29mX25vZGUoZGV2KSwgImplZGVjLHNmZHAi
KTsNCj4+PiArCWlmICghbnApDQo+Pj4gKwkJcmV0dXJuIDA7DQo+Pg0KPj4gV2hhdCBpZiB0aGVy
ZSBpcyBubyBqZWRlYyxzZmRwIG5vZGU/IFNob3VsZCB0aGlzIGJlIGFkZGVkIGFueXdheXM/DQo+
Pg0KaWYgdGhlcmUgaXMgbm8gamVkZWMsc2ZkcCBub2RlLCB0aGUgL3N5cy9idXMvbnZtZW0vZGV2
aWNlcy9zZmRwKiBlbnRyeSANCndpbGwgbm90IGFwcGVhci4NClJlbW92aW5nIHRoaXMgY2hlY2sg
d2lsbCBzaWxlbnRseSByZWdpc3RlcmluZyB0aGUgU0ZEUCBOVk1FTSBkZXZpY2Ugb24gDQpldmVy
eSBTUEktTk9SIGZsYXNoIGJ5IGRlZmF1bHQuDQpEbyB5b3Ugc3VnZ2VzdCByZW1vdmluZyBpdCA/
DQoNCj4+PiArDQo+Pj4gKwljb25maWcuZGV2ID0gZGV2Ow0KPj4+ICsJY29uZmlnLm9mX25vZGUg
PSBucDsNCj4+DQo+PiBXaGF0IGFib3V0IGp1c3Q6DQo+PiAJY29uZmlnLm9mX25vZGUgPSBvZl9n
ZXRfY29tcGF0aWJsZV9jaGlsZChkZXZfb2Zfbm9kZShkZXYpLCAiamVkZWMsc2ZkcCIpOw0KPj4N
Cj4gd2lsbCBkbyB0aGF0LCBUaGFua3MNCj4+PiArCWNvbmZpZy5uYW1lID0gInNmZHAiOw0KPj4+
ICsJY29uZmlnLmlkID0gTlZNRU1fREVWSURfQVVUTzsNCj4+PiArCWNvbmZpZy5vd25lciA9IFRI
SVNfTU9EVUxFOw0KPj4+ICsJY29uZmlnLnJlYWRfb25seSA9IHRydWU7DQo+Pj4gKwljb25maWcu
d29yZF9zaXplID0gMTsNCj4+PiArCWNvbmZpZy5zdHJpZGUgPSAxOw0KPj4+ICsJY29uZmlnLnNp
emUgPSAoaW50KShub3ItPnNmZHAtPm51bV9kd29yZHMgKiBzaXplb2YoKm5vci0+c2ZkcC0+ZHdv
cmRzKSk7DQo+Pj4gKwljb25maWcucmVnX3JlYWQgPSBzcGlfbm9yX3NmZHBfcmVnX3JlYWQ7DQo+
Pj4gKwljb25maWcucHJpdiA9IG5vcjsNCj4+PiArDQo+Pj4gKwludm1lbSA9IGRldm1fbnZtZW1f
cmVnaXN0ZXIoZGV2LCAmY29uZmlnKTsNCj4+PiArCW9mX25vZGVfcHV0KG5wKTsNCj4+DQo+PiBU
aGlzIG5vdyBsZWF2ZXMgdGhlIG52bWVtIGRldmljZSB3aXRoIGEgZGFuZ2xpbmcgcG9pbnRlci4g
V2hhdCBJDQo+PiBtZWFudCBpbiBteSBwcmV2aW91cyByZXBseSwgd2FzIHRoYXQgeW91J2xsIGFk
ZCBhbiBvZl9ub2RlX2dldCgpIHRvDQo+PiB0aGUgbnZtZW1fcmVnaXN0ZXIoKSwgc28gdGhlIG52
bWVtIHN1YnN5c3RlbSB3aWxsIGhhdmUgaXRzIG93bg0KPj4gdHJhY2tpbmcuDQo+Pg0KPiBBbmQg
U29ycnksIEkgb3Zlcmxvb2tlZCB0aGF0IOKAlCBJIG1vdmVkIHRoZSBvZl9ub2RlX3B1dCgpIGlu
c3RlYWQgb2YNCj4gYWRkaW5nIHRoZSBvZl9ub2RlX2dldCgpIHRvIG52bWVtX3JlZ2lzdGVyKCku
DQo+IEknbGwgZm9sZCBpdCBpbnRvIHY4IGFuZCBzZW5kIGl0IHNob3J0bHkg4oCUIGxldCBtZSBr
bm93IGlmIHlvdSdkIHJhdGhlcg0KPiBzZWUgdGhlIGNvcmUgcGF0Y2ggcG9zdGVkIHNlcGFyYXRl
bHkgZmlyc3QuDQo+PiAtbWljaGFlbA0KPj4NCj4+PiArCWlmIChJU19FUlIobnZtZW0pKSB7DQo+
Pj4gKwkJLyogTlZNRU0gc3VwcG9ydCBpcyBvcHRpb25hbC4gKi8NCj4+PiArCQlpZiAoUFRSX0VS
Uihudm1lbSkgPT0gLUVPUE5PVFNVUFApDQo+Pj4gKwkJCXJldHVybiAwOw0KPj4+ICsJCXJldHVy
biBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihudm1lbSksDQo+Pj4gKwkJCQkgICAgICJmYWls
ZWQgdG8gcmVnaXN0ZXIgU0ZEUCBOVk1FTSBkZXZpY2VcbiIpOw0KPj4+ICsJfQ0KPj4+ICsNCj4+
PiArCWRldl9kYmcoZGV2LCAiZXhwb3NlZCAlZC1ieXRlIFNGRFAgYXMgYW4gTlZNRU0gZGV2aWNl
XG4iLCBjb25maWcuc2l6ZSk7DQo+Pj4gKw0KPj4+ICsJcmV0dXJuIDA7DQo+Pj4gK30NCj4+PiAr
DQo+Pj4gICAgLyoqDQo+Pj4gICAgICogc3BpX25vcl9sYXRlX2luaXRfcGFyYW1zKCkgLSBMYXRl
IGluaXRpYWxpemF0aW9uIG9mIGRlZmF1bHQgZmxhc2ggcGFyYW1ldGVycy4NCj4+PiAgICAgKiBA
bm9yOglwb2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9yJw0KPj4+IEBAIC0zMjA0LDYgKzMyNzQs
MTQgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yICpub3Ip
DQo+Pj4gICAgCQlzcGlfbm9yX2luaXRfcGFyYW1zX2RlcHJlY2F0ZWQobm9yKTsNCj4+PiAgICAJ
fQ0KPj4+ICAgIA0KPj4+ICsJLyoNCj4+PiArCSAqIEV4cG9zZSB0aGUgU0ZEUCB0YWJsZSBhcyBh
biBOVk1FTSBkZXZpY2Ugb25seSB3aGVuDQo+Pj4gKwkgKiB0aGUgZmxhc2ggYWN0dWFsbHkgcHJv
dmlkZXMgb25lDQo+Pj4gKwkgKi8NCj4+PiArCXJldCA9IHNwaV9ub3JfcmVnaXN0ZXJfc2ZkcF9u
dm1lbShub3IpOw0KPj4+ICsJaWYgKHJldCkNCj4+PiArCQlyZXR1cm4gcmV0Ow0KPj4+ICsNCj4+
PiAgICAJcmV0ID0gc3BpX25vcl9sYXRlX2luaXRfcGFyYW1zKG5vcik7DQo+Pj4gICAgCWlmIChy
ZXQpDQo+Pj4gICAgCQlyZXR1cm4gcmV0Ow0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KVGhhbmtzIGFu
ZCBSZWdhcmRzLA0KTWFuaWthbmRhbiBNLg0K
