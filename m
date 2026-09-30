Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C64ACC94;
	Wed, 30 Sep 2026 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765548; cv=fail; b=nZLxGGVi95g9/BJpPZM/fxwE6E1SwdSordwzPeSyyrMdCC1TN01PtZCGdrktjhEoyPC7iRen+olqlXnXiA8gU01kGd3vYhD9B3OnfXqn3jP+WEsh7n1GsvNp6VTM8oy06ySz/Do8msLpu/xomMhrLTLTZMq0fiun9gCCZXxc15M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765548; c=relaxed/simple;
	bh=Hkol2thpUX8W9PmMI9bdKDTks0UH5A2cEsaWhOtOulA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ksUytxDGGLDVv5BWULqYKHlUPHyXMB3OwSjt3uO0TLsV28jLUjKODfFG9X3LraQ4+VoZq6Kxdka9c1x/IiRFxvUnAdYMzVPcH4aiXjKsmFg+GduvxjlrlBlAPz2xzL1K+MqFHHnNEcpvYWeW6T166bvNuvZfbKpDORqKnfccnxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZXSGovmd; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZXSGovmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f71/82Uc8N8mxZdpyVAUZjLLFE6QccvjHDjnfkOtrlkCZs3I03vk4erVHb8jSVC0hGJBHsiCeMZKArU+5gzjoVOmF8SAdujVXIryH/mJCdk+EOZmSGdjVSNG+OuAlA2ByVA+G7F9E+ThoHOMGhTDTuNHwt3bTzsFNiu+SuT5BaUPPnw3+vkUCzkg0FW8Fnu0m8+dJzDDDAOvrqcddJADHJhX/7tayQLb2RwFhmChPDP/o9jeDbSv27IAuO8Eudi6Iq7dRZsuS8KaKgpR/awgGs2FVqRqEe5kGHN6+Z6PJ8qWgO/vP2Aroj8MDKfMHKC69Y5Zrcwd6ndxC9TiwBB13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkol2thpUX8W9PmMI9bdKDTks0UH5A2cEsaWhOtOulA=;
 b=kxM+6N7OIwECAtXQqXQUs+bBnhUN2/vI4jiJnR8KpT/U3xSKzbTOb3sSp7drLq6Q8iV7nqMKE2L8kenqWiWcz6vFc1vw1dsF46N1K671l9n4ueDkFBgw9sx3x4799My2Byl96QlBoEZ8U1wcWi4HkRn7f9Sos4Vp8uIWClzHLmTBiAtLSFmJ3c5nlLTLzTmTlEFKGFzHi1SXggA5YLk/pU9uF7qx4Qlna9eL1MDtQ2HFpeFWMZgTa3tsJG6etFmVG2toJYnZqKMU91PDg18Hti43lwuBRq6GhPLOUg5bLZWZP/0G5AjpVOa+4r7Gz/yx07gRVcMNn8Ju4xb8gGFofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkol2thpUX8W9PmMI9bdKDTks0UH5A2cEsaWhOtOulA=;
 b=ZXSGovmd01xocQa8CkDDAwkyJewfyBDaTq44cc/hyQbpmTlJx+8b7A2HIJMSMInJc6CyrpQRrqMkcIf4lIiBZlI3FJD5sHq4rtzJUscDJVT5yvzUSHUTZ4m1ZDE2CfC32+ZAIFy1EH/t9TEVygjREoHCmIBNwskuI+H5TSNCQR9JBHZtSqd06sDI1/Z0wlQbR9Yyq5JRes9Y1Pa19UteansTKRBH0GLCQM6lBaaH8KToIinbibuWtdXHRS8v4BI2UxZTAda9BdtYpr1bqhU2zOXIkWBjFPKvHM0ztWkKC93ZJDvTuOA4hqM60tsQZL3YL8jsOx4a+VwhgwQFPr3C4g==
Received: from DS6PR11MB523643.namprd11.prod.outlook.com (2603:10b6:8:468::12)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:52:06 +0000
Received: from DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954]) by DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 10:52:06 +0000
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
Thread-Index: AQHdKkh8ssbUvMZsfEyMbU+NvXWKVbbDPUYAgCQBoAA=
Date: Wed, 30 Sep 2026 10:52:06 +0000
Message-ID: <7412c28b-28ec-41f1-b083-ccb2510e3341@microchip.com>
References: <20260812104955.485667-1-manikandan.m@microchip.com>
 <20260812104955.485667-4-manikandan.m@microchip.com>
 <DL93QHVC01B9.3U3K1G8NC0MZA@kernel.org>
In-Reply-To: <DL93QHVC01B9.3U3K1G8NC0MZA@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS6PR11MB523643:EE_|PH7PR11MB7605:EE_
x-ms-office365-filtering-correlation-id: d9ccdfcb-ff41-40c5-d332-08df1ee0dea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|921020|6133799003|3023799007|10067099003|4143699003|56012099006|11063799006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Ny12rO6xmoEAiPcZ7Isy7TzweZY+n2EN2B+ONRp7jnj3tShhgkUTSLMOIKdE+tb/rKS4c5SsFFRJ451ldtsoYJfa75x+F3lcP+mPId5q2ZOSbSk2a8np2Ask/WIniYxlVZAfZabC9SJjGatzHtBagXW3kHg159C1Rm3s8HJRoGFqD3oSk2v0CgKLUZTex87GyTDQH7qzN5Snia0+77WYel7DW23KKUiEUcbvC8Y+Daj+NXxzzZcEI7ASyzUwozahF4Vpzidc0aG27UQzTGvVnOkK31cmRspWYOjwjp0X2NPwFr+UZ3SUkTQpcZGOxyZHHEHUC7IOVti4kjAeVnTw6+LO6dRU4uTJ5QI74xVb3Dw+qksruUkkxni/56SdVf7jfuvB5LUtLeZmr025IOaoV1b2n4eOY386/mWpaGfSsgVRfm6tcUDGIddJbdrGs+nRjMtsmVi9T36vwwEPH3tmakdIGdDP9TFoT7KHCFl6cuQ0MFGqH7mhgy4TecvRvcB/JH/tbiwcuQYBrPkwO49tyZn8fAOLV3zOP0T+hwSD1Gjb0eSWoGJgQFeYm3OkSbY9B7f4MvjiLJLzDAij93+m+YRzXT5i2LUchiXSQ1/v08QKFFIvFbg06zbHTIlM/XeZ5V9RL7ze98X8onoJyObOV8Zr/fVApHg2kF04aEgPEftmfEFDSnC+RLF7tBclwl/1mwzrRU+D3/YY4md4fD0Evh5vxPnE9Mjq8elQYH58MDd+6AvmEyZFFLJwNKKSEOvm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS6PR11MB523643.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(921020)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVZpN1ZGYjJxT2J4bm1Sa1NiSGZ0YUJBUkFxTEVGT0pyaGtKREtZR2ttME1G?=
 =?utf-8?B?cHBseEdnRkxCbFYzS2hwVTIyZk5hUnhwKzBScmhZUHBxdVpGdlRTWVU0NkVM?=
 =?utf-8?B?MDVkMHZPSUcxME9ZalFhNndDR3hwTE9PWVNQbmxqUnpmOXFvWFhxdmNiMWc4?=
 =?utf-8?B?TGQ2Y09qWEh2azlSQ3l6d3h2UXhYZUdaYWN1UDdxbTZUd3Z6ZDFCVGp4TWh0?=
 =?utf-8?B?d0Q1cm5uL1l6Zm8yU0wwemlVV3R2YjVZTER3N2ZPcGs5VzVNM3cyeUNITHZn?=
 =?utf-8?B?ZnhXQ1JXNkhBbEhJK3JXaXd2bGlMNW5VQnlVK0ZMQkg3dC9JNVlySmloT0tr?=
 =?utf-8?B?SDlnQlFuNDN5WmdRQTE2TXUrbFRvQlRoVStDNDNPY09NODcyZWhvd3pMVTEx?=
 =?utf-8?B?azZFTndiT2prOVM0NlppWFNJUXorUml0TzI0QU1WU3hSSkd2R2Z2dkY3YmxC?=
 =?utf-8?B?V2ZvNEcvTFZlUjBBWHdlNzVPcmFtQ1R0N21nVWhibzZJaHNpaVJCV3ZiZTZF?=
 =?utf-8?B?K2RvS240YWRNWkdVS045SnJVb1ZLcTVkOUZnR1pLbVErSExRcnV2MnZ3UFhK?=
 =?utf-8?B?N2lLU0hQaFJHN2FTN3JSZ1hkMlAyY3BUR2JEYmpaZmxxQVdzNHFnUjZXM0pN?=
 =?utf-8?B?QVBuQXU5ZWJiT3duY25heGg2c3BRZXZPMjFzZVkxOVE0TUdya2tmQ2p0VVp4?=
 =?utf-8?B?L1ZhQWZnTE9vNWxDZ0VianBublhadXhFSU4wRklLR3Nhb1ZIV3BML0ptTUNi?=
 =?utf-8?B?RC9HQ0lubUdIT0VkbkJOVFhOSzdnNW9lNVlpajRnZzdNUUt5Sy9iaUFUdzhS?=
 =?utf-8?B?QS9rRFV1U2tQMWk1WEYwaGpXejh2YTZXOWhvYnFUUWhtZEU3Q0V2SkdRNHVR?=
 =?utf-8?B?bnBIUHRLSlNNNFlHVS9VcDhZczZmR01aTFppcjFaOGYvTFpuVWhrVVdYcDZH?=
 =?utf-8?B?UklJTmxoUmtoVHl6NkNQSkpQZ0I4czBDK3FiM3o5c2k2ZzlBa0FCUHF3bjNW?=
 =?utf-8?B?OVRvVVcxdENRMjJwS29VTmtIVWxRQ0l4aGxrS3FBbWFlKy9jYVE3R1M3VU5D?=
 =?utf-8?B?Y1lMeFVTc005aHMrdXFNbll6SGxXSHhKdjBwSzkyNjNtbEVOdkE4bEZ5Sklp?=
 =?utf-8?B?YW9hbFdYTkpnMmw4TlRXdFQxcjM3YVhMelhvamw4d2hvUU5teGM4Mk9pM1Z6?=
 =?utf-8?B?ZXRnQVc2SFhBaTBMS3dNUzFTdzFrOHBreHMvTElEUmpiRTltbzc4bGt2ZmhS?=
 =?utf-8?B?cU8vam16bHg4THpHeXB4QXVQZHRxeFZPWUtmN29JdllMK0dwVUpVOVZTTThy?=
 =?utf-8?B?SmxPMDhCazFsdDJvUGVMK1ZoVzAzeFkxSmRSZk9NY0JCcjYrVGNRSC9oUjFz?=
 =?utf-8?B?bUxnU1luWVJ0ZHBZcTVZaVRML3I4cW5JbE9CMk91a01KTHc1R2RqMjErblE4?=
 =?utf-8?B?MEphVWZPSXQ5eVM3VXZWYm1ENGQrTFpkWk82Qm9GNVBzdzZDUkNucWZLSklr?=
 =?utf-8?B?dFpSSGd0bFdZcVFVU0d2WEpsOURMY1BRQjRQNE1Vdk4yRkI0SzZkSTExb1dR?=
 =?utf-8?B?OG9HR3V6SkhGUXlPalBQNmZjR3B1ZnlyOW5IODJQVXNyaFhuQlhxYzBWS3J4?=
 =?utf-8?B?N09Ya0p0VmdHNkNzSWZIVXRIMkVOM2h6M3U2dEF5d3NjOVpVWUovUzFPVk1R?=
 =?utf-8?B?d0RjU2ErTmpHcUZMK3NPMzFiNDliV3YwVWxWVkcybFF4OVFzbTdKSjRTTE9i?=
 =?utf-8?B?QStrODgrd3dITXlhZjVYMHhXZGxqN290TGdUNmE3bnM5eWxwVzdNMkFJZHdp?=
 =?utf-8?B?alRCZkFmOGk3SnkwQXh0K3IxQ245SHZGR1RoUXpNU09qbytRbXltMjNhdUsy?=
 =?utf-8?B?dEFJd0tZVTFuQmFPQ1BhK29uMzRlRFMvNVI4MGNFR1RUbnRHbUwzU21sTm5F?=
 =?utf-8?B?LzdkV0sxaUdUdXpWZnY2YkI5QlVWVkRPWXJRbXpndmlVOXdkdVc4RkJVYmRG?=
 =?utf-8?B?dmxtSDVyOWYxY1ljS2VCNDJONmZ1ZzlyNjd5eTF0a2FrMFNNTFErRTROUlVR?=
 =?utf-8?B?NENrR2lXYXVabC9scmpkejZNd2w5MElIMk83M0Z1VGJOMW9NNlFqUU9Ma2hJ?=
 =?utf-8?B?aURzY0RVL0VvckZlY282ZHlkaHU4TllLaWpvcENWZGNHNi9RTk1BNjBhd1Nn?=
 =?utf-8?B?K3MvellFcFpTcTFKMkdOVlVIMGwyRHZNQ2s5S3JVSGRFaE9GaDNwRHJmWFBS?=
 =?utf-8?B?VWRGL3VqMndWRFRrRllRQUo1c0VOd1YrQTI3Vzg2MnZhQzdmZ3BZTEpRNjVw?=
 =?utf-8?B?cG9Pd2E3K2FHWHRRZERPOGRIQzNSTDN5d2Vjd3JzeXZ6eG9uck5lUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <907046A04E92EF4093C3A2B3D4D928F6@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ccdfcb-ff41-40c5-d332-08df1ee0dea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 10:52:06.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5waa5amwrMaxm/nAq6kiFPoyFZ7mg3gD9mf2xle2D/0sWYbFXHVLpg9L+XwUNX1VTlrUTnQWA73NeW1EybENiPReRHWFjJM8sNdGuo2wEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605

SGkgTWljaGFlbCwNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5Lg0KDQpPbiA5LzcvMjYgNjoz
MCBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiBXZWQgQXVnIDEyLCAy
MDI2IGF0IDEyOjQ5IFBNIENFU1QsIE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIHdyb3RlOg0KPj4g
VGhlIFNQSSBOT1IgY29yZSBhbHJlYWR5IHJlYWRzIHRoZSBTRkRQIHRhYmxlcyBkdXJpbmcgZW51
bWVyYXRpb24gYW5kDQo+PiBjYWNoZXMgdGhlbSBpbiBub3ItPnNmZHAtPmR3b3JkcyAoc2VlIHNw
aV9ub3JfcGFyc2Vfc2ZkcCgpKS4gUmUtZXhwb3NlDQo+PiB0aGF0IGNhY2hlZCBkYXRhIGFzIGEg
cmVhZC1vbmx5IE5WTUVNIGRldmljZSwgaW4gb24tZmxhc2ggYnl0ZSBvcmRlciwNCj4+IHJvb3Rl
ZCBhdCB0aGUgZmxhc2gncyBTRkRQIGNoaWxkIG5vZGUgKGNvbXBhdGlibGUgImplZGVjLHNmZHAi
KS4NCj4+DQo+PiBUaGlzIGxldHMgTlZNRU0gY2VsbHMgcmVmZXJlbmNlIGFueSBTRkRQIGRhdGE6
IGEgZml4ZWQtbGF5b3V0IGZvcg0KPj4gcGFyYW1ldGVycyBhdCBhIGtub3duIG9mZnNldCwgb3Ig
YW4gbnZtZW0tbGF5b3V0IHBhcnNlciBmb3IgdmVuZG9yIGRhdGENCj4+IHdob3NlIGxvY2F0aW9u
IG11c3QgYmUgZGlzY292ZXJlZCBhdCBydW50aW1lLiBUaGUgZGV2aWNlIGlzIG9ubHkgcmVnaXN0
ZXJlZA0KPj4gd2hlbiBhbiAic2ZkcCIgbm9kZSBpcyBwcmVzZW50IGluIHRoZSBkZXZpY2UgdHJl
ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWth
bmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiBp
bmRleCBjY2Y0Mzk2Y2RjZDAuLjA0MjVhZjZlODk4ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0K
Pj4gQEAgLTE3LDYgKzE3LDcgQEANCj4+ICAgI2luY2x1ZGUgPGxpbnV4L210ZC9tdGQuaD4NCj4+
ICAgI2luY2x1ZGUgPGxpbnV4L210ZC9zcGktbm9yLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9t
dXRleC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9udm1lbS1wcm92aWRlci5oPg0KPj4gICAjaW5j
bHVkZSA8bGludXgvb2YuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1l
ci5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvc2NoZWQvdGFza19zdGFjay5oPg0KPj4gQEAgLTMw
MDEsNiArMzAwMiw3NSBAQCBzdGF0aWMgdm9pZCBzcGlfbm9yX2luaXRfZml4dXBfZmxhZ3Moc3Ry
dWN0IHNwaV9ub3IgKm5vcikNCj4+ICAgCQlub3ItPmZsYWdzIHw9IFNOT1JfRl9JT19NT0RFX0VO
X1ZPTEFUSUxFOw0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyBpbnQgc3BpX25vcl9zZmRwX3Jl
Z19yZWFkKHZvaWQgKnByaXYsIHVuc2lnbmVkIGludCBvZmZzZXQsDQo+PiArCQkJCSB2b2lkICp2
YWwsIHNpemVfdCBieXRlcykNCj4+ICt7DQo+PiArCXN0cnVjdCBzcGlfbm9yICpub3IgPSBwcml2
Ow0KPj4gKwlzdHJ1Y3Qgc2ZkcCAqc2ZkcCA9IG5vci0+c2ZkcDsNCj4+ICsJc2l6ZV90IHNmZHBf
c2l6ZSA9IHNmZHAtPm51bV9kd29yZHMgKiBzaXplb2YoKnNmZHAtPmR3b3Jkcyk7DQo+PiArDQo+
PiArCWlmIChvZmZzZXQgPj0gc2ZkcF9zaXplIHx8IGJ5dGVzID4gc2ZkcF9zaXplIC0gb2Zmc2V0
KQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArDQo+PiArCS8qIFRoZSBjYWNoZWQgU0ZEUCBp
cyBrZXB0IGluIG9uLWZsYXNoIChsaXR0bGUtZW5kaWFuKSBieXRlIG9yZGVyLiAqLw0KPj4gKwlt
ZW1jcHkodmFsLCAodTggKilzZmRwLT5kd29yZHMgKyBvZmZzZXQsIGJ5dGVzKTsNCj4+ICsNCj4+
ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIHNwaV9ub3JfcmVnaXN0
ZXJfc2ZkcF9udm1lbSgpIC0gZXhwb3NlIHRoZSBTRkRQIGFzIGEgcmVhZC1vbmx5IE5WTUVNIGRl
dmljZQ0KPj4gKyAqIEBub3I6CXBvaW50ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3InDQo+PiArICoN
Cj4+ICsgKiBFeHBvc2UgdGhlIHdob2xlIFNGRFAsIGluIG9uLWZsYXNoIGJ5dGUgb3JkZXIsIGFz
IGEgcmVhZC1vbmx5IE5WTUVNIGRldmljZQ0KPj4gKyAqIHJvb3RlZCBhdCB0aGUgZmxhc2gncyBT
RkRQIGNoaWxkIG5vZGUgKGNvbXBhdGlibGUgImplZGVjLHNmZHAiKS4gVGhpcyBsZXRzDQo+PiAr
ICogZ2VuZXJpYyAoZml4ZWQtbGF5b3V0KSBvciB2ZW5kb3IgKG52bWVtLWxheW91dCkgY2VsbHMg
cmVmZXJlbmNlIGFueSBTRkRQDQo+PiArICogZGF0YS4gVGhlIGRldmljZSBpcyBvbmx5IHJlZ2lz
dGVyZWQgd2hlbiBhIGNoaWxkIG5vZGUgd2l0aCB0aGUgImplZGVjLHNmZHAiDQo+PiArICogY29t
cGF0aWJsZSBpcyBkZXNjcmliZWQgaW4gdGhlIGRldmljZSB0cmVlLg0KPj4gKyAqDQo+PiArICog
UmV0dXJuOiAwIG9uIHN1Y2Nlc3Mgb3IgaWYgdGhlcmUgaXMgbm90aGluZyB0byBkbywgLWVycm5v
IG90aGVyd2lzZS4NCj4+ICsgKi8NCj4+ICtzdGF0aWMgaW50IHNwaV9ub3JfcmVnaXN0ZXJfc2Zk
cF9udm1lbShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gK3sNCj4+ICsJc3RydWN0IGRldmljZSAq
ZGV2ID0gbm9yLT5kZXY7DQo+PiArCXN0cnVjdCBudm1lbV9jb25maWcgY29uZmlnID0geyB9Ow0K
Pj4gKwlzdHJ1Y3QgbnZtZW1fZGV2aWNlICpudm1lbTsNCj4+ICsJc3RydWN0IGRldmljZV9ub2Rl
ICpucDsNCj4+ICsNCj4+ICsJaWYgKCFub3ItPnNmZHApDQo+PiArCQlyZXR1cm4gMDsNCj4+ICsN
Cj4+ICsJbnAgPSBvZl9nZXRfY29tcGF0aWJsZV9jaGlsZChkZXZfb2Zfbm9kZShkZXYpLCAiamVk
ZWMsc2ZkcCIpOw0KPj4gKwlpZiAoIW5wKQ0KPj4gKwkJcmV0dXJuIDA7DQo+IA0KPiBXaGF0IGlm
IHRoZXJlIGlzIG5vIGplZGVjLHNmZHAgbm9kZT8gU2hvdWxkIHRoaXMgYmUgYWRkZWQgYW55d2F5
cz8NCj4gDQo+PiArDQo+PiArCWNvbmZpZy5kZXYgPSBkZXY7DQo+PiArCWNvbmZpZy5vZl9ub2Rl
ID0gbnA7DQo+IA0KPiBXaGF0IGFib3V0IGp1c3Q6DQo+IAljb25maWcub2Zfbm9kZSA9IG9mX2dl
dF9jb21wYXRpYmxlX2NoaWxkKGRldl9vZl9ub2RlKGRldiksICJqZWRlYyxzZmRwIik7DQo+IA0K
d2lsbCBkbyB0aGF0LCBUaGFua3MNCj4+ICsJY29uZmlnLm5hbWUgPSAic2ZkcCI7DQo+PiArCWNv
bmZpZy5pZCA9IE5WTUVNX0RFVklEX0FVVE87DQo+PiArCWNvbmZpZy5vd25lciA9IFRISVNfTU9E
VUxFOw0KPj4gKwljb25maWcucmVhZF9vbmx5ID0gdHJ1ZTsNCj4+ICsJY29uZmlnLndvcmRfc2l6
ZSA9IDE7DQo+PiArCWNvbmZpZy5zdHJpZGUgPSAxOw0KPj4gKwljb25maWcuc2l6ZSA9IChpbnQp
KG5vci0+c2ZkcC0+bnVtX2R3b3JkcyAqIHNpemVvZigqbm9yLT5zZmRwLT5kd29yZHMpKTsNCj4+
ICsJY29uZmlnLnJlZ19yZWFkID0gc3BpX25vcl9zZmRwX3JlZ19yZWFkOw0KPj4gKwljb25maWcu
cHJpdiA9IG5vcjsNCj4+ICsNCj4+ICsJbnZtZW0gPSBkZXZtX252bWVtX3JlZ2lzdGVyKGRldiwg
JmNvbmZpZyk7DQo+PiArCW9mX25vZGVfcHV0KG5wKTsNCj4gDQo+IFRoaXMgbm93IGxlYXZlcyB0
aGUgbnZtZW0gZGV2aWNlIHdpdGggYSBkYW5nbGluZyBwb2ludGVyLiBXaGF0IEkNCj4gbWVhbnQg
aW4gbXkgcHJldmlvdXMgcmVwbHksIHdhcyB0aGF0IHlvdSdsbCBhZGQgYW4gb2Zfbm9kZV9nZXQo
KSB0bw0KPiB0aGUgbnZtZW1fcmVnaXN0ZXIoKSwgc28gdGhlIG52bWVtIHN1YnN5c3RlbSB3aWxs
IGhhdmUgaXRzIG93bg0KPiB0cmFja2luZy4NCj4gDQpBbmQgU29ycnksIEkgb3Zlcmxvb2tlZCB0
aGF0IOKAlCBJIG1vdmVkIHRoZSBvZl9ub2RlX3B1dCgpIGluc3RlYWQgb2YgDQphZGRpbmcgdGhl
IG9mX25vZGVfZ2V0KCkgdG8gbnZtZW1fcmVnaXN0ZXIoKS4NCkknbGwgZm9sZCBpdCBpbnRvIHY4
IGFuZCBzZW5kIGl0IHNob3J0bHkg4oCUIGxldCBtZSBrbm93IGlmIHlvdSdkIHJhdGhlciANCnNl
ZSB0aGUgY29yZSBwYXRjaCBwb3N0ZWQgc2VwYXJhdGVseSBmaXJzdC4NCj4gLW1pY2hhZWwNCj4g
DQo+PiArCWlmIChJU19FUlIobnZtZW0pKSB7DQo+PiArCQkvKiBOVk1FTSBzdXBwb3J0IGlzIG9w
dGlvbmFsLiAqLw0KPj4gKwkJaWYgKFBUUl9FUlIobnZtZW0pID09IC1FT1BOT1RTVVBQKQ0KPj4g
KwkJCXJldHVybiAwOw0KPj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKG52
bWVtKSwNCj4+ICsJCQkJICAgICAiZmFpbGVkIHRvIHJlZ2lzdGVyIFNGRFAgTlZNRU0gZGV2aWNl
XG4iKTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlkZXZfZGJnKGRldiwgImV4cG9zZWQgJWQtYnl0ZSBT
RkRQIGFzIGFuIE5WTUVNIGRldmljZVxuIiwgY29uZmlnLnNpemUpOw0KPj4gKw0KPj4gKwlyZXR1
cm4gMDsNCj4+ICt9DQo+PiArDQo+PiAgIC8qKg0KPj4gICAgKiBzcGlfbm9yX2xhdGVfaW5pdF9w
YXJhbXMoKSAtIExhdGUgaW5pdGlhbGl6YXRpb24gb2YgZGVmYXVsdCBmbGFzaCBwYXJhbWV0ZXJz
Lg0KPj4gICAgKiBAbm9yOglwb2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9yJw0KPj4gQEAgLTMy
MDQsNiArMzI3NCwxNCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9wYXJhbXMoc3RydWN0IHNw
aV9ub3IgKm5vcikNCj4+ICAgCQlzcGlfbm9yX2luaXRfcGFyYW1zX2RlcHJlY2F0ZWQobm9yKTsN
Cj4+ICAgCX0NCj4+ICAgDQo+PiArCS8qDQo+PiArCSAqIEV4cG9zZSB0aGUgU0ZEUCB0YWJsZSBh
cyBhbiBOVk1FTSBkZXZpY2Ugb25seSB3aGVuDQo+PiArCSAqIHRoZSBmbGFzaCBhY3R1YWxseSBw
cm92aWRlcyBvbmUNCj4+ICsJICovDQo+PiArCXJldCA9IHNwaV9ub3JfcmVnaXN0ZXJfc2ZkcF9u
dm1lbShub3IpOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJcmV0dXJuIHJldDsNCj4+ICsNCj4+ICAg
CXJldCA9IHNwaV9ub3JfbGF0ZV9pbml0X3BhcmFtcyhub3IpOw0KPj4gICAJaWYgKHJldCkNCj4+
ICAgCQlyZXR1cm4gcmV0Ow0KPiANCg0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNCk1hbmlr
YW5kYW4gTS4NCg==
