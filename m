Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010028.outbound.protection.outlook.com [52.101.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C564438484;
	Thu, 30 Jul 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419838; cv=fail; b=jUFcew3uHtJ7iOES/R3xO6Xtg4WklpGjQL/la9uy3uoRVKeq+ecTlCLslbh2P03BCTdgQT1wJk17tLwaFmrSl28yPVCzQ9uyS/1KmQ0t+a9iBnskom5Igqo/f+KyfHjiSeM1z/ShcuvZqyYlUYdwek9YEtQd8b7B5Enr4k+pqsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419838; c=relaxed/simple;
	bh=pchcubdUHkh4uLiEhewabcsBZ8TCx80i1qAFxM9it3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LiAIGmMWWQyC1vj0ctcLcy1xb91q4wZhjN1MV6lv81rvJM5tfTwcTjYQZXLyfrtluHbofAbUlMVKBEzIFWs2NIS2mN+zBVp0JssXAoFUJMuiTGjB5S9F47Uy1ObFYLX0IW39y8aaG026UXH2EcdnqFFX9CHPayElobaipbQNUf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=GIq+zMlI; arc=fail smtp.client-ip=52.101.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="GIq+zMlI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6T5pwKQZ+/hchUF+WfIHD8tjloWVv+n6+qWOixwpfZr9hR3JAB9VDuKX/rJ1deiN82puMoPV0GLhaSEu8DNRou5B16yfoaX/IHToMvhQAXdEzk6fh3zTHW/4PEqJGE+qfHrX6cMvyDf8JxOYJpoZTqRYWApy1w/PWEkCP/mPgIZWu8PBOzhqiC4I9uo11Bq2xYm6d0P1iEXC/tcfa30iBPx66gDTMx52Q2M2dzDTQiHehSOuI7yy/9AIIh1m4Lcs3yp2Ea7o3NmeG8mhf/klPdyAhp9LmF3MB1Q0tJHC/o4+ZKGY4/2qC58gg45/dcsFc8Wl/G11YX3afd/XG6rqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pchcubdUHkh4uLiEhewabcsBZ8TCx80i1qAFxM9it3Q=;
 b=Sak2fYKyNaNKEP2BA35440BBmCQR54eILBLKDz1PpVjVVekFYlNYMxEYDRk6vSOpDbXXGtIU+Xw/W4oCH2PZZgbIqlOHkQ9GMCEG14vXv/2Su6USU7C9ILdnphHJLCYcf+QOp3Z9v+BGGMijW805Nw8Cvy6zpfOtzwdPOsSNaXEME2CPrTEOO+CE+zJPSN7CttQZ4y1D+w0xiJkuFFQmkBSoTG19SUZgZwKUCqyWS/rWaKNeczURvcqRSgq3/7HocACEkb4nFvuG3JqYmSi4RrP7cGTit4SWERqxVTpb4hu2iu7kXTi//gRvCZIoWhRjJVduW6iMD2R7iC78Ofgh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pchcubdUHkh4uLiEhewabcsBZ8TCx80i1qAFxM9it3Q=;
 b=GIq+zMlI3TvUaAAL4M6/EOIrqdT+Zh5E9l+2mfrrz++QZVoqU/rN0PRsfWsv5n4cbnHzYju9f4a5KtVrVDOXaP0ifRbVCGa0ForqBzRePEz0pShWhyFb+Sl+vfUptWySdUtCgFURf87TGyMLU6w9RHw4O9wlfG6NA2DSt9KXNv8=
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com (2603:1096:604:33c::9)
 by TYCPR01MB7195.jpnprd01.prod.outlook.com (2603:1096:400:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 13:57:10 +0000
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f]) by OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:57:03 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "jun.ann.lai@intel.com"
	<jun.ann.lai@intel.com>, "yi.fang.gan@intel.com" <yi.fang.gan@intel.com>,
	"NG, BOON KHAI" <boon.khai.ng@altera.com>, "matthew.gerlach@altera.com"
	<matthew.gerlach@altera.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag handling
Thread-Topic: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Thread-Index: AQHdHz/RntRPJl+oQEefyqoj3xFOEraEXkgAgAGragCAAA0XIA==
Date: Thu, 30 Jul 2026 13:57:03 +0000
Message-ID:
 <OSCPR01MB127691D8052A6BBBBDC10C0BDD3C92@OSCPR01MB12769.jpnprd01.prod.outlook.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
 <af97a4a2-9a1d-4b36-9055-d05124bf4ab9@bootlin.com>
 <d5013c57-258d-44d2-a98d-2b1cbe541380@altera.com>
In-Reply-To: <d5013c57-258d-44d2-a98d-2b1cbe541380@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12769:EE_|TYCPR01MB7195:EE_
x-ms-office365-filtering-correlation-id: 333f2191-9267-4888-d2e4-08deee426f60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|3023799007|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 Dpr50/bTdJSsjU2yxPEB4vMZuMNeK9VXQXn8/VGRyO22yPlrPul5dd2xLBHhRzs8oAVpT5i299YO/hKBKXjwTeQVpl2ldZS7HDyNheCUSOXoqqzRqdnWKv9OBN14DtLGy5exHhHowBdfpzyRSqLVJWnhT79KtDaYklIEVpBPmgMIUlbAQZJV7DAYpcSA4wjEM4YR87UMZbplN9MaTVMFUqUSx1Ph7ljxZZmGRJGplCYmtcr0DyOdjE3WkjPSLxY7JBbTkQvnGCzQzRe+6WkCJLdiptlRKJaTXyz+x6xTRVJccXh9aPVNtSINWKJGUmvIq/b1Lp4EtKky4X+h0+CnYjc0/JttT+7QT9jnp4X3WmRh/vvPWjLM1xQwUT8sRL1Dp8WBf0DmElDmQH5H3HO1EFuNo+cnG/lwVrFDIui07MC+exRWc/sCFf+L0JFyTt1veaEFm7v2gsCnwA0KNllqs6zkBH9mNXmemy5uzt5dCtBB7p+ntQi/HK/bsQJzvkZb2Jn7dFz2h4k0tdcdzf/LizIAvz66UBTeotfsD+cBAv6Z/OzdzBXtbRFP6xMDKJsmZ8N3HE+KIQxyCq8Q6FO62gK2Z2Tvwr0ZkXXV4mq0RJeK/Ayne2DIGI/SoiRGKB87B9nl8rj1P/KWJECMo+VGf1Ha/EzZUi+WQotiWH2eq+Sq5UZVg4TUBwR6dDNbwSkrL21/KjZ8lBktPtfTw9m9GHKl8Tq53Sw0SYLLJP07rN/ZynlvHuluZXeuKAFVt2XL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12769.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(3023799007)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YklDcDNJMzhLVndxa1dYYlM3Tmp2RjdNQm50cmVNQVNkTi9GUEJSbGVnZHk1?=
 =?utf-8?B?eW1TUFZWOFZYYXBONHN6S0FEOVoydkNDRkVhUEJHRDhmWnBTTVlGQWl5S3Yw?=
 =?utf-8?B?blFqQ0p0UTVoWnpmanhWZ0t5ek9icTdpbUlNbWF5NWl6SENSOEtiK3RpajNu?=
 =?utf-8?B?cWdpS3BtWnVQVnk4N0NFT3VIS2V0WmZEUWxhMEVTblNlNVpWdmM3VjNFUmtj?=
 =?utf-8?B?aWc0UGIxZVE2d1ZDYVdDemliNGY0VHNxYlBuTjN5VG5NV3lCU2lrQXFlRTFJ?=
 =?utf-8?B?em4xT254R3ExVGdKMnZmUjdCQ3VhZEEvQTd6d3VLVWczbHR2TitkVWo2aGNI?=
 =?utf-8?B?WCttZytjcFFRUitlWmJBclNtTUJJVmJNUWhWSUY1Q2xKZ3VnYkRzQWtncFlT?=
 =?utf-8?B?eUxwd2pnenlTZmp5TjRKUDlYUFdmdCtjQ1Y4Wkp2UU1VcDZHM3ZRZmpDSVQr?=
 =?utf-8?B?Vm9yNlhaNDNQdFcrdXRFMmF1NHB4QmV3dW4rWEJxam1DKzVXdlhnbk95ZXlo?=
 =?utf-8?B?cnAwZ0xBQUIvR21HZmtuV3VRSjhlK2trRkhWRnFXOEtnQzI5VmZ3d1FqaUdx?=
 =?utf-8?B?V1FEZk1wUHUxTXFJNkZKanRWYlRicXhidkM5ZnhHQW5vZ0JEQVh0bXBKSW1k?=
 =?utf-8?B?K3l1clpnaVRWa3BwSWE3cEM5RVhNdmYwT0NCR0F1VUNpNTV4Ky9GcHYxNStp?=
 =?utf-8?B?c3l1MnhZQ2tPSFUrUC9BUjhVU3J5bUFyTVBKR3RNaURJNjJnSVVESGN5R1dY?=
 =?utf-8?B?WGc2RUt6R3JVWU1nTE1YNFNTNzBBVWMvS3EzaldBc0w3MzVNemFUTVYvQkJw?=
 =?utf-8?B?ZGhwWFc5alhRZEdsZ0wyUVJyYW9NWEl0cHJkUXJYMGpzLzhodUl3cGh6R3NK?=
 =?utf-8?B?c0xNdXFZSDJyN1Y1c3p5a1luaGZhbTdBYkFkRFBvNGRCVXlBSytqMUNuS3pV?=
 =?utf-8?B?Q29CcGYvcnd2c2lPRitOaWdTdnpxWjUzUnkyeWZLcWc2d0VzdHVwR01VcUYv?=
 =?utf-8?B?ZDFxZmszbzkyVTFReXFjbDlBRkFCVnB1Z1NEWXVlbkZVdHFGUjR1aENnRWFH?=
 =?utf-8?B?ZldxdEtzYStTSjNWbC9CSEdvdUxoRVJLRCtGN3M4VDlBbGFUREFhM1MyYnFx?=
 =?utf-8?B?QlZteUwzREhnQWxOM0craXdnMkxhY1Jrd0JWUEJ4cHhydUJESy9FQW55dlE4?=
 =?utf-8?B?cWhyYlQweXV6OFN4OFFIUnZ1ajg3MWMrT2JFblc5aDBtMkNUS3N3NEJCQTVY?=
 =?utf-8?B?SCtTdzF6RGc1WFRXc3kxUWd6Q0JvdkRFOGMrQmxDN1BNU256dklsQnl0NlJJ?=
 =?utf-8?B?SG1iZ0VBdE5PUzkrRnlIWktXb3VFZjVseTllV09IeDBTUlRuMmhCY09saUNp?=
 =?utf-8?B?R3I4T3kxeDVlZFpHcUVtOVdSdGRKSGRORDlpWTA2OGpqSjYyaUJBNmVSazRj?=
 =?utf-8?B?RnVOWGNpL1E1bEFiTkd1RGNXKzByWko4bEhNRkdTbmx0a2E5eURQZ1ltV042?=
 =?utf-8?B?SEZ5ZllTWEVIV0pKTWFvU09TNVgvTDk0enNmOXRaQmJodXRiU2hwc3hPZ09P?=
 =?utf-8?B?bHdXY2I3R015REZJeXZZMlAzV2ttNHk0a3IvMCt5Z05tbGdIV0w0djVFcFZs?=
 =?utf-8?B?RzVITUpxWENBSExxYmxiREtqTkdrdnZtWVdBUGVvTVpDalVITkpMVk9mMFN0?=
 =?utf-8?B?UGFOemdMdFQ3K1NHTG9qK2xZSFV0dDB3NkRURWJsMzVheW9iTlFwb2FQSDF0?=
 =?utf-8?B?S1RkL0YyNjU4bU9GSUhCeEtUbTFXSmdyY21CR3dsb0RmeWN1cXZNVFJFVDBI?=
 =?utf-8?B?Ny82ZGFlb1NwSjlHVFJYcGR3SjRQMzB6aFF2VHpocFpCeTNNMDRhVzF6RUVD?=
 =?utf-8?B?THhJdUhnUkNPUWRBaU1MSzlVM3Y2VEVDaWVNM1VlMXA0R24xR1ViVi9vZnRp?=
 =?utf-8?B?bkhhZS9KZTI2TUlVUTREd3BVY3o5dFV0bkNDYTJldFRYcGFTaTZ6UUJqQ1JU?=
 =?utf-8?B?NEF1NHU2MFVwcndwTmRFMk9LNG9pMUxTbDlCcWVGNGNGVytlcFFmMmw0UEtP?=
 =?utf-8?B?RlZxbm04R0UrVXpPVWJmTW5oR3luQksyQlhJNEhNRS83WmtBMzVJeDVrczMx?=
 =?utf-8?B?NGhzbXhCY3d5K3lCWHlsTVhCSEs3Zno3Z2pHSHd2M0VLajJwY040NnFMc3VT?=
 =?utf-8?B?MHpMSzVRSkpDcXhwSXFMZmRoUEVGUTdwMUVvN3h6ZkpLNktITXZzMWI3VFZi?=
 =?utf-8?B?RDBHT0ZwT0ExUWE0NDhEbnFCYnVad09pMWhBY0F1dDBrcTdQY0RKdFhKc3Bs?=
 =?utf-8?B?QmtoWmRlWmtndEJDL21GZ2dsOEphVitQYjVwaW9yaWc1LzBnYTN2OFR2TUI2?=
 =?utf-8?Q?+4xOpb8pF7PQOxuk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12769.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333f2191-9267-4888-d2e4-08deee426f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 13:57:03.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+I0jQ6M5MRtd6R1MtHJjHAH6UhXc5yNJaFC8NbgRpW5YMBA74rISEyiNmOM7lGN9YyibJLcwSQsnj/VssZmN3wHoggjtSg+MwDiw0s5xFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7195

SGkgTmF6aW0gQW1pcnVsLA0KDQo+IE9uIDI5LzcvMjAyNiA3OjM1IHBtLCBNYXhpbWUgQ2hldmFs
bGllciB3cm90ZToNCj4gPiArIE5hemltIEFtaXJ1bA0KPiA+DQo+ID4gT24gNy8yOS8yNiAxMTo1
MSwgT3ZpZGl1IFBhbmFpdCB3cm90ZToNCj4gPj4gQ3VycmVudGx5LCBoYXJkd2FyZSBWTEFOIHN0
cmlwcGluZyBpcyBicm9rZW4gZm9yIDgwMi4xYWQgdGFncy4NCj4gdmxhbl9yeF9odygpDQo+ID4+
IGhhcmRjb2RlcyBFVEhfUF84MDIxUSB3aGVuIHB1dHRpbmcgdGhlIGhhcmR3YXJlIHRhZyBpbnRv
IHRoZSBza2IsDQo+IHJhdGhlcg0KPiA+PiB0aGFuIHVzaW5nIHRoZSBhY3R1YWwgcHJvdG9jb2wg
ZnJvbSB0aGUgcGFja2V0LiBCZWNhdXNlIG9mIHRoaXMsDQo+IHBhY2tldHMNCj4gPj4gdGhhdCBj
b250YWluIGFuIDgwMi4xYWQgb3V0ZXIgdGFnIGFyZSBpbmNvcnJlY3RseSBwYXNzZWQgdXAgdGhl
IHN0YWNrDQo+IGFzDQo+ID4+IGhhdmluZyBhbiA4MDIuMVEgdGFnLg0KPiA+Pg0KPiA+PiBUaGlz
IGlzc3VlIHdhcyBvYnNlcnZlZCBvbiB0aGUgUmVuZXNhcyBSWi9WMkggcGxhdGZvcm0gKHdoaWNo
IGhhcyBhDQo+IGR3bWFjNA0KPiA+PiBJUCksIHdoZW4gdGVzdGluZyBRaW5RIHBpbmc6DQo+ID4+
DQo+ID4+ICAgICMgRFVUDQo+ID4+ICAgIGlwIGxpbmsgYWRkIGxpbmsgZW5kMCBuYW1lIGVuZDAu
MTAwIHR5cGUgdmxhbiBwcm90byA4MDIuMWFkIGlkIDEwMA0KPiA+PiAgICBpcCBsaW5rIGFkZCBs
aW5rIGVuZDAuMTAwIG5hbWUgZW5kMC4xMDAuMjAwIHR5cGUgdmxhbiBwcm90byA4MDIuMXENCj4g
aWQgMjAwDQo+ID4+ICAgIGlwIGFkZHIgYWRkIDE3Mi4xNi4zLjIvMjQgZGV2IGVuZDAuMTAwLjIw
MA0KPiA+PiAgICBpcCBsaW5rIHNldCBlbmQwIHVwDQo+ID4+ICAgIGlwIGxpbmsgc2V0IGVuZDAu
MTAwIHVwDQo+ID4+ICAgIGlwIGxpbmsgc2V0IGVuZDAuMTAwLjIwMCB1cA0KPiA+Pg0KPiA+PiAg
ICAjIFBlZXINCj4gPj4gICAgaXAgbGluayBhZGQgbGluayBldGgwIG5hbWUgZXRoMC4xMDAgdHlw
ZSB2bGFuIHByb3RvIDgwMi4xYWQgaWQgMTAwDQo+ID4+ICAgIGlwIGxpbmsgYWRkIGxpbmsgZXRo
MC4xMDAgbmFtZSBldGgwLjEwMC4yMDAgdHlwZSB2bGFuIHByb3RvIDgwMi4xcQ0KPiBpZCAyMDAN
Cj4gPj4gICAgaXAgYWRkciBhZGQgMTcyLjE2LjMuMS8yNCBkZXYgZXRoMC4xMDAuMjAwDQo+ID4+
ICAgIGlwIGxpbmsgc2V0IGV0aDAgdXANCj4gPj4gICAgaXAgbGluayBzZXQgZXRoMC4xMDAgdXAN
Cj4gPj4gICAgaXAgbGluayBzZXQgZXRoMC4xMDAuMjAwIHVwDQo+ID4+ICAgIHBpbmcgMTcyLjE2
LjMuMg0KPiA+PiAgICAgIC0tIEZBSUwgLS0NCj4gPj4NCj4gPj4gVGhpcyBzZXJpZXMgYWRkcmVz
c2VzIHRoZSBpc3N1ZSBmb3IgYm90aCBkd21hYzQgYW5kIGR3eGdtYWMyOg0KPiA+PiAtIGR3bWFj
NDogc2luY2UgZHdtYWM0IGRvZXMgbm90IGV4cG9zZSB0aGUgdGFnIHR5cGUgaW4gdGhlIFJERVMz
DQo+ID4+ICAgIGRlc2NyaXB0b3IsIGl0IGNhbm5vdCBzdXBwb3J0IGhhcmR3YXJlIGRvdWJsZSBW
TEFOIHN0cmlwcGluZw0KPiBjb3JyZWN0bHkuDQo+ID4+ICAgIFRoaXMgc2VyaWVzIGRpc2FibGVz
IGRvdWJsZSBWTEFOIHN0cmlwcGluZyBmb3IgaXQsIHNvIHRoZSA4MDIuMWFkDQo+IHRhZ3MNCj4g
Pj4gICAgYXJlIGxlZnQgaW4gcGxhY2UgYW5kIGFyZSBoYW5kbGVkIGJ5IHRoZSBzb2Z0d2FyZSBW
TEFOIHBhdGguDQo+ID4+DQo+ID4+IC0gZHd4Z21hYzI6IHRoZSBSREVTMyBkZXNjcmlwdG9yIGRv
ZXMgcmVwb3J0IHRoZSB0eXBlLCBzbyB0aGUgY29kZSB3YXMNCj4gPj4gICAgdXBkYXRlZCB0byBy
ZWFkIGl0IGluc3RlYWQgb2YgaGFyZGNvZGluZyBFVEhfUF84MDIxUS4NCj4gPj4NCj4gPj4gTm90
ZTogcGF0Y2ggNS81IHdhcyBjb21waWxlIHRlc3RlZCBvbmx5LCBhcyBJIGRvIG5vdCBoYXZlIHRo
ZSBoYXJkd2FyZS4NCj4gPj4gSG93ZXZlciwgaXQgdXNlcyB0aGUgc2FtZSBjb2RlcGF0aCBhcyBk
d21hYzQsIHNvIGl0IGhhcyB0aGUgc2FtZSBpc3N1ZS4NCj4gPiBOYXppbSBBbWlydWwsIGFzIHlv
dSBzZWVtIHRvIGhhdmUgYWNjZXNzIHRvIHNvbWUgQWdpbGVYNSB3aXRoIFhHTUFDLCBjYW4NCj4g
eW91DQo+ID4gc2VlIGlmIHlvdSBjYW4gcmVwcm9kdWNlIHRoZSBpc3N1ZSBvbiB5b3VyIHNpZGUg
YW5kIGlmIHRoaXMgc2VyaWVzDQo+IHNvbHZlcyBpdCA/DQo+IA0KPiBIaSBNYXhpbWUsDQo+IA0K
PiBUZXN0ZWQgb24gbXkgZW5kIGFuZCBzZWVpbmcgdGhlIHNhbWUgZmFpbHVyZSBhcyBhYm92ZSB3
aXRob3V0IHRoaXMNCj4gc2VyaWVzLCBpcyB0aGlzIHBhdGNoIDUgaXMgdGhlIG9ubHkgcGF0Y2gg
bmVlZGVkIHRvIGZpeCB0aGUgcHJvYmxlbT8NCg0KRm9yIGR3eGdtYWMyIHllcywgcGF0Y2ggNSBp
cyB0aGUgb25seSBvbmUgdGhhdCBpcyBuZWVkZWQuIER3bWFjNCBkb2Vzbid0IHJlcG9ydA0KdGhl
IHR5cGUgb2YgdGhlIHN0cmlwcGVkIHRhZyAoODAyLjFhZCB2cyA4MDIuMVEpIHNvIHRoZSBvdGhl
ciBwYXRjaGVzIGFyZSBuZWVkZWQNCnRvIGRpc2FibGUgdGhlIGRvdWJsZSBWTEFOIHN0cmlwcGlu
Zy4NCg0KVGhhbmtzLA0KT3ZpZGl1DQoNCj4gPiBUaGFua3MgOikNCj4gPg0KPiA+IE1heGltZQ0K
DQo=
