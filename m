Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2353F6618;
	Mon, 27 Jul 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149322; cv=fail; b=tMW8ZCT2gd4V7mL9PIWsuyKgliFaIKlCW1rOSgMpFmb92B+LjBWYjcBZb1F80WFfoF0B4ieGc8PVkFHZ0Ber+3Q6WA1qtNlVfXMzfQVSrYzRQfcIk95KAfy2e0kYHzTLVKCuB18691LDjXZjURk7j4df5MJ2u+CltKJs0VFI8kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149322; c=relaxed/simple;
	bh=TBI63BuuWx7CEuC+d5a9RJ1Hsqihmbe12omS7ybFFKc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QL19u5HJEpX6sbMTbNZfwsBx7iFTuXq6w5VVwmsb0tTNgl22b6t4VX7WD3xYP4H7T8T2DCJHigQXHqFXlIMRX/zfJQGMhemZDzboULDmcia61+53qUus33Hy17Ni6gG6z3oL8KgfWtuRtSUpnQGWqSaraAOls5HYsojazT8VGqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ZbM1Xw42; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="ZbM1Xw42"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENmx7jxGNiVFcUjarRyzQqSwiA6mHxvJP8kvq5BBGykdL3DRjI0r4ymwWA/gZlU4wz4RtrdbcYYWBat7ZNZ/wLQLEmDpZf+VKs45t0KuNuLngpwTXxm1AOB0ptC/UNJGV45pZyBys4UNON6r4gL2UKTM+SLyjoW7yWbK0IkVh6Vz4maf7Jwfvv+eAfy9HgkkgqWArNWIrdVXTJGu0u0s6lZGSOavsuRY2SL2Qq23zzegINABOHQm1E8FCt/ReSH1aG/s5HOasXu1f6Nfcd4qqJp+VZCqd4NYIFHIqBW+23Jp3g45oc3uXkpJfAeFhURemk1Alb4hMNFymtILkGN0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBI63BuuWx7CEuC+d5a9RJ1Hsqihmbe12omS7ybFFKc=;
 b=SHJEfaPYar0+Fc8gC2Zw3j5FF0IwuuEuzSUiIW16KSjciAYta0pL49akM/et8vhPobJ6c5XBDBx2xaNN6b7Ag15tPyLk5WOg+ZlXv9IFSY4bHFDmY37jdyWJJXtMyPu2rbhNvtarbZnOiW1vXkq7yKEXNv3VKbU0On8IG0cUqiDmI1gCHHn6L5AsLc35zSeNuovdVEOTwAIhkB/CSNu/6NmyuQEbYTWmmg++JX1R4NjV9H7/4sHTEOsnFqjiQ+P5paTrHKv3gEOWtrELgwjuVrf9TQ7AVUFS0rmyjllELAss0sJRUwDaYYanxobIF5KiG+ftSoIepVXQmf+ygkO4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBI63BuuWx7CEuC+d5a9RJ1Hsqihmbe12omS7ybFFKc=;
 b=ZbM1Xw42R5GoXPnv1eDUdd2EKAlsVeDMjJV/4LBftUbk3qTZStBRPWKz0JRtMopRGKQILCNnStsYZ2McyopPoA9vmL8G7uV/jMc5jKi/hWp/61MS3tQviT3DiCDCFO/7YUjgtQFtmnjdTsnc6A7phVJKpwFfybPj1nxcaumVa58ImY7t75xoqQC6oy4Gw5KKx6J9YR/J0XcpbBz3rMgBoA+3ZN3NS6Rd2u8OYp0at7BmJGcZUPFDzKCh1egkXschLvw3XU3Vno5jd+ps/MwWMuaM5SZNn1D4T3Dp4myhcVGrBIWtZ+450p8i3yFgTkoE0H4FXyXroFGEHyRCPhjjVQ==
Received: from DU0P189MB1994.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3a6::11)
 by DBBP189MB1291.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Mon, 27 Jul
 2026 10:48:37 +0000
Received: from DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 ([fe80::7181:423c:55f1:76d]) by DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 ([fe80::7181:423c:55f1:76d%6]) with mapi id 15.21.0270.009; Mon, 27 Jul 2026
 10:48:37 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Xiang Mei <xmei5@asu.edu>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
Thread-Topic: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
Thread-Index: AQHdFpdz5rod5J9+cEGekGyYwc7wpbZ2jdiwgADA0ICAAANSUIAJ5r+AgAADS3A=
Date: Mon, 27 Jul 2026 10:48:37 +0000
Message-ID:
 <DU0P189MB19947FAEDA9517313091A423C6CC2@DU0P189MB1994.EURP189.PROD.OUTLOOK.COM>
References: <20260718092544.785289-1-bestswngs@gmail.com>
 <20260718092544.785289-2-bestswngs@gmail.com>
 <GV1P189MB1988EC5A7F5CB5DD69F331AEC6C32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <CANgPUi2hfRO8OebwBFm2f8240DYmqdPYNQtWyQL0VOP8beeSFQ@mail.gmail.com>
 <GV1P189MB1988CB4E92D2BDFB80894B4BC6C22@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <CANgPUi2bEtnuW3P2epaX+Mat7Szj=Pb6L6o_RL5C8BiHcVkYKg@mail.gmail.com>
In-Reply-To:
 <CANgPUi2bEtnuW3P2epaX+Mat7Szj=Pb6L6o_RL5C8BiHcVkYKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P189MB1994:EE_|DBBP189MB1291:EE_
x-ms-office365-filtering-correlation-id: 6c43e24c-c3dc-4f28-9472-08deebcc9cef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|4143699003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 IB0XzAODQTGHCxCmY8meQMPC7jZf9dW9oq6yUIUz6BxPM+4NN9MJ/S1lxSauY9lenY8svR9dDkIBMdQdnNxoNLH5kD10XodV2IalPxh/Q0vII29CeVV1lZCje3umZZcTUZimttMwZK9lxiX21mF2o9IAghkpATdSbWPr9ja6ZrlfWlG1Gzlf0VcrrCWHk5FJKzt2m+RGNzAtNb6gxWTuXwXHwGFm5YuO+Y+67HQfoxl19VXV7CDcX0SitLfZxb9pXp1P5AFDrhzmwl435VP3JEpQy5G1i/Gu7OGIV74n2szlDqPLBwfHAOcoItybfdxYQNOiqIExWkxxDJCvRRiEAhIMdRW3Kl4dl1193SP/7SwE4sWGY1q7twL6LW3DBPNCH9DPIFFaTvDpUyKTDW3kPjAHEUgY8kBlMbavUQ9sBYVHJCwxF8VRvUwNRVzQvZV42mYWNytS04y4pqVsCVLwdOxG5i4N1qZXqBA4ZGMO1Ukhkjxu72jk717rRhKDrS2AkRyDYIpXXG4DxcYlMG4UuZ8BI0RjfGDbIlSJMeS7s+iAETEcbZ5Cz0iHc0imU44R0UBVYZfCProQ6IUJ2LjC+NcAol5ttvEVaccgHtVhl+ZpUH0aVeJccR8k3IpoiXmSOmNRBcXn2SVJqA75oyoGhdi9T37CcSPsDjb7XWgLbmwlBnhsuH5bEvFXxhMTfWviL5c6Lo3vUtKsB1vjftsetwsY1qF0cRPquP/mKoMv+JU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P189MB1994.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkFMN3RheGdDcUlibkxITWdIVlMxT21QZlk3U204bTBnYjhQZHFTSmwzZTJa?=
 =?utf-8?B?akpzSVJ6L3czTjExMW0zK0MrRCtaS3FqbWxRVmxnNEFzdmJTaXBoL3BXY2V0?=
 =?utf-8?B?OWhKbkgxTGd2YWdHUDFmUWpneWlRblBpSno5bi9ZQWtVNENUcDdMbGp2RVFX?=
 =?utf-8?B?UHZVOXV3a0w2ZXQ0TmltdlFZdWMzRktneXRBZk5idXYrRXY3RHFXQmE1ZjMw?=
 =?utf-8?B?RVhucGVqY2Qvby9rZ2c0a1hTdkxDbVBNMzhwR1hOWXlxMGp4b2FqVXpSK1JZ?=
 =?utf-8?B?cTNDbExXZjcyUGVhc2ZFek1UeSt6UUkwbnZQaFU5WVdaM3N1UUw0S0tYZzVq?=
 =?utf-8?B?c2psZXEzZlA3S2k1ek1KRzZNRGxuQVlkVGdRMUpGWFBTSnV5ZmJvRnFkTFlQ?=
 =?utf-8?B?czdxenhyRjFSVFREZ0t0VkVaMXltTUUzZkRLVDZzcVk0RHJHSWNYaEtaTkFN?=
 =?utf-8?B?RjJNMm03TWdDNEt5THpkbjlBR2lla2d0bVpKUVpxak9FbGgyLzBsTmNlbVph?=
 =?utf-8?B?UWFXRlpFd1Z1dStIWkErOStCdStnaGhuTkROU1oraUJEYjBFOWwxZ0RjNTA5?=
 =?utf-8?B?N2xUNlhTNmJrRjBNcEExYXVBSUtjT2Yvckk2bi9RRUlaUHZBdkExNVd0eXpV?=
 =?utf-8?B?ZDBvcUZXRUZRajAxU3o2R1k5VDM5bjVYcGtKdkx5TXZXTVRyV3JpTDZpelhh?=
 =?utf-8?B?UEdhVklDTDdDUnZtOFdSczJvYzQwQnVPb1JGQTREblhzdXpMWnprN3ZTUWNB?=
 =?utf-8?B?T3F3ZGFMUjN6ZFREdVBRQVY5WjV0Q3RLUTN0VTVqM1JPZ1M1c1dXeCtVZ1lq?=
 =?utf-8?B?TEE0Y1ViWVZ4VVdIT1R3TXVTeXp5QnIrWVlZYWhORTdDeDkrd2w1QTd0OEdJ?=
 =?utf-8?B?YXpPemxQWWxwTkNETTl1WkduOW5nbmhmZ0NKbzJaTnZwSDA4SVd0RWdZbDFv?=
 =?utf-8?B?MjJkdlBsMHV4L3NhUklreUY3RWJqQ3RLeHRkblczSFFZckJUekhIaGs2WkFY?=
 =?utf-8?B?anpITG0yS1BTSWFqeHpPbVo4bGcvRlQyMk9ZYWRGWllXbHhPZ1g3N1VTd090?=
 =?utf-8?B?aEhEZmV4bnJXanh2L2p6WjdXMmJFT1lKZFNiNEJCSUxjZEYza3h6dUJsVkZM?=
 =?utf-8?B?cTVtdlg2bzRkWWhURmtMVnZlaTcwU1hUYUlrRlBEaEpkMnExTEVNa2N5Tjhi?=
 =?utf-8?B?UHZac2NBZlUzTkpCOWxrQUJEVjhXYkdVZTR3TUtVQnc5cDRQS1YwWUlPSmh2?=
 =?utf-8?B?YnZYdUdIVG9iSlUrRUlXbFR4L0pqSGJHYWR0TkR1T09RMCszQ2dzVVlnRXhZ?=
 =?utf-8?B?RXhFSjRsTjZRL3BPdXJXWmFBUU82L05VZmQyTnA5WndsS0Q5ZnRZcDB6VEJP?=
 =?utf-8?B?QVZPdkVkalRoTGQ5dU9SNUR4OXhXZHFobFdvYndvSHJjZVVvR2xOSjhuS25o?=
 =?utf-8?B?YThUaEI0QnhTa3VRM3dwRmgwb2xvcnNYQlQ3Nmp6UGV0Z05OcCtjM2Q1UU1J?=
 =?utf-8?B?K0I2N1hrKyt5RE1DK254ellOY29EcVh0MnUvQUpENjlXU2lMdkZJbHZtZjVw?=
 =?utf-8?B?VDZMVTByc2RjYUllN0x4QVBsVXNpVTZUOEZ5bTRDa2lxUUg0OTRoOHZFVDMv?=
 =?utf-8?B?U0JXeCsxdUhPYTJ1WVc3U2luMXhPb00xTnJVZHZLM3FnNlZ0S1JNZno4YWtl?=
 =?utf-8?B?bWxlS2lOOUVtNVdCNVc1NC9wcnkrRDg3QlZDdmZpMUdYemk0dFk2cisyYzF3?=
 =?utf-8?B?NmttOHdTK2hZbWMwQnJHMlZ5bjl2Q2xNWFdQOENPbXQva1hKbmhKdGNGYVlG?=
 =?utf-8?B?WFlnQXpZVC8zV1FDVDBqdXdoMVFxM3QvMTVMWW4xbk93dW16WjY1Wkk4Vkxv?=
 =?utf-8?B?OW9iRHpVcHplUDZoTzA3ZFFxR1FORVFlZWtLL1dmV1hRSnlCV3ltbTNJR2Nv?=
 =?utf-8?B?UmltTGVDM1QwWU9CK2RIY2c0NzhralNMQ3FFYnl4cHpHR1VoalpPV3JNZTZR?=
 =?utf-8?B?U2QxNjdtRUo3ZGJmMzNrZGR5SlIwNjRKaFk3M0RzUVQzTG1yRktIcTlDdDE0?=
 =?utf-8?B?aEQ4MFZzWHg0elJ2Y0ZSaXhlbmhScnMzaTdRVnZlQ24yY0psb215WVhXYjhu?=
 =?utf-8?B?Vlg3cXorSnFPQ05JRHBLamhRVkZzK1VqVWNqcHBZYjlOeW5RajNWeGNsUXpa?=
 =?utf-8?B?SjU4Zjd5MkJQd2VsdERvQjdoY1VYdSsvMnZZMkxYazJDcnRReCs2SVk5WVJJ?=
 =?utf-8?B?WTlKbzRiMFpOSTJ3NmxQb0l0MG42TkZHb2ErN1c4NkRJdkdwRC9mMWs1dks3?=
 =?utf-8?B?eFpSZWZ6TTRvbFZ3cDA0NmEyMTVEME9CdFVkK0tZdTJxT2RPODBvdz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c43e24c-c3dc-4f28-9472-08deebcc9cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 10:48:37.1974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMDxTQHS0NYXWkYRcGu6CyIWV4tb9HQjFUpzGb1pI97iim77vT58qe1BS11CfyKRxn/3JIqgxoaKRBQGE/ACt/kK8b7Bsfgm77ZBWOn6uqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1291

PkhpIFR1bmcsDQo+DQo+SnVzdCBmb2xsb3dpbmcgdXAgb24gdGhlIGlzc3VlLiBMZXQgbWUga25v
dyBpZiB5b3UgbmVlZCBhbnkgaGVscCBmcm9tIG15IHNpZGUNCj53aXRoIHRlc3Rpbmcgb3IgdmFs
aWRhdGlvbi4NClRoYW5rcy4gSSBhbSB3b3JraW5nIG9uIHRoZSBuZXcgcGF0Y2ggdmVyc2lvbiB0
byBhZGRyZXNzIHRoaXMgaXNzdWUuDQpJbiBmYWN0LCB5b3VyIHJlcHJvZHVjZXIgZXhwb3NlcyBz
b21lIGV4aXN0aW5nIFRJUEMgaXNzdWVzIHRoYXQgbmVlZCB0byBiZSBhZGRyZXNzZWQgYWxzby4N
Ckkgd2lsbCB0cnkgdG8gc2VuZCB0aGUgbmV3IHZlcnNpb24gdG9tb3Jyb3cgc28gdGhhdCB5b3Ug
Y2FuIGhlbHAgdmVyaWZ5Lg0K
