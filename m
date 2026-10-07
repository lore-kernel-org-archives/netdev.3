Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E14CA29F
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397743; cv=none; b=MAcvGURw6CtvhzIMHCrmyxqNKJ5UcIrjNIQcTMvE3Xjsw7S+BNxzSL+IgP+J8DMjP5M6YotVdxtEynzrOn2JGVTDt1Ofc2Qd+fSytcoA73y1lgL274/kWR7UvhmEcJXrzYqMbiabiYabeM9q3G5M0g+4SP50s9S0UsUV+sSgQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397743; c=relaxed/simple;
	bh=YSEwLcfON2Q8ca/3B3FzQGN6k/HHISsbqUMRzHAT3yQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=GfhgUcd5qnNvacafK8WHwqV5tmW9zmTpPurQYV3PmLAUQhtLcOk5rZBBlpW5FdFSRxGe2eQ1KHmdo6omII/SkYVqeLyHrcYDELgY3Rkdc2wbklNZk1S0zXUO0qUE+bX3UbQP6YBQiKKguPHNmbLPee5HvwR9YycVPrWI7sCx6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=LoZojRls; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="LoZojRls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1791397741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSEwLcfON2Q8ca/3B3FzQGN6k/HHISsbqUMRzHAT3yQ=;
	b=LoZojRlsRF7ixIhPekbUQvBX9dqNGECJsEauPdkT+xAxjgr3wCIQE4oHXCdPN3RPqP2AFK
	xEQuh5lOOy0C1RNXH1lBama6Knp9+bZQZBDooQa4BJyCB6k+ErHhbCXnl+ygmZI7zp51W3
	A5o3nvR3oo3iqVvyumaAcnAFfTwU4j9TLDEyCZeBRdTl/XWvKh8PTN0P+53y1GHrTEL4sL
	a5QyyvN8wEQj212fXVpljf4iTcD9uWfhoiQPFBHwCM6xO8ZRGlLHq8h9tEq7ZZhmQI9YJg
	vQwPPK1009t5t6wKcIzZWThtiZUhYF06zMC43/CxoEwnFJHh7UwrvmPPBBOohQ==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-12-n7DUgcFLMciyE5FGuTDm3Q-1; Wed,
 7 Oct 2026 18:27:17 +0000
X-MC-Unique: n7DUgcFLMciyE5FGuTDm3Q-1
X-Mimecast-MFC-AGG-ID: n7DUgcFLMciyE5FGuTDm3Q_1791397628
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by BL1PR02MB235845.namprd02.prod.outlook.com (2603:10b6:208:28f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 18:27:05 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 18:27:05 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Richard
 Cochran <richardcochran@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Jerry Ray <jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v8 10/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
Thread-Topic: [PATCH net-next v8 10/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
Thread-Index: AQHdT5hJt3XofMKSNkelqcovFu35ibbwlSWAgAHcJuA=
Date: Wed, 7 Oct 2026 18:27:05 +0000
Message-ID: <CH0PR02MB786708E230F4E1AF3B0882E383942@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-10-7e011aacc309@onsemi.com>
 <1203b096-456b-45b0-9c2c-bbea2b0098b6@lunn.ch>
In-Reply-To: <1203b096-456b-45b0-9c2c-bbea2b0098b6@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|BL1PR02MB235845:EE_
x-ms-office365-filtering-correlation-id: 57dfdcf9-be2e-4663-ca1d-08df24a09703
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|10067099003|38070700021|11063799006|4143699003|56012099006
x-microsoft-antispam-message-info: lqCfOx5X23sUdnBQGysvJ0BMub74iKb6RVP3FhwVDs9AQE8+eCGTw2XqGIxswIWJDscCpzLVTaH7v0JRZRhQlG3ff8AfmvqGlRWEsU9jMUwtCc+g6/Ok1UVYwd+0v4OGGWFaJx5vQoDK4PwTLQaO7CERlUBQ4ykajwrQOtFN86INMKwtH9S2GY9cAAScNssIAnQa9I2x/LqHWC+nxJGM45aJerFriw5aJur8n0o7E+sZjsGtxCdQXR9duJ2h2+3IYbwSM2IlyagmJAT0OUAS7J2CjgX97499BZFA2vTU+B0WBDXXub0XF9Ffyhi7Vk5T5ME1wfBG9tXn8Eu5dvl6SZzdoKtJ6lWXl5h6bjZULpOgfzEpmFAw7AXJ42CltXlDntyPsusFR0V3+QCQEuXEDa0/jYdGUXrIKnzA03S512DXCIRi1tlQoPyG0BHOzjtOKqoI9kLhVg/z5+ALmCY+7P3a3UaESM6BJ4SzieDBPVcauGvlSCKS8vgajPWi9KoOsn2n9HseOLIwvw6ETu1s8HJwO8Pb0ugGR9VOdJPPSfk4DzsfD2d3VVs7RBh0Ni6GnEI5oSM4Wql92HySCSVs5cSecEogZOr9EUawy2StwzTSN3ABVq06LeOPqH+xw+T36T1u6GIcxaot9LzF/9UvKY7ulqcyTETY0lbZZ8U523hucdjQRnb34pt3KCdhpQRo2COM+2sgVbU6wpJ53xlD/MeTr1WepuQY0JU4MRvuUxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnJudDVYR3BhVEhycm5GbmJmdERDZFNucHJ2c0p2cUpIeGREU3B0VDgySWth?=
 =?utf-8?B?cmU2djNDV0ludmF1aWJIWkFPaEFZU25yN3ZCN1E3L2taU0tmUHMrT0p5U3da?=
 =?utf-8?B?eTFFd2hFMEg1OFp1VFAyRlEzZ09CWmJnUllPb084LzIwcDBSVjlBb1JsTlVo?=
 =?utf-8?B?OHVramF4MUVNaUV0alhxcmw4TEZDcUdGdldDeXA5TTBHY1IrNE10YVpGOGtF?=
 =?utf-8?B?SUp3VTBVZEpManM3dFZpRFRscmV0T2l5T3N5aFhrRU02Nm8wbVBIVUhCeURM?=
 =?utf-8?B?aFQwVUVNd2FXYVBUb3pRcmM5QXozbE96QndnVm9PbW5UYVdQc0U1dk15V2Iw?=
 =?utf-8?B?U0xvUGMxMzBHcTZTNEJDMXk2SnN0MTlnYUFMTTRWdDgya2htWkdiald1enll?=
 =?utf-8?B?ZU5tV0F5Y29HWTlJclpnZlVuYzRNdHk3am40YS80bUxHVjNUeDVOQmNVZWJK?=
 =?utf-8?B?S0ZYRXp6bURWTlF2T3JUVkhMNUJqMFJ4WWpZWXhVenJSYkJJU3Z4NFptYWtR?=
 =?utf-8?B?dTdNVVozZGJFcnJEaUxvaHFEWnROZ1BuL2taVW5udmNNTit3SmNCR0hvV3lM?=
 =?utf-8?B?ZWpKbFhQQTRGNWZ3Q0ZuaHlONFk2ODkyU3dBbUwzZ0ZaOUxsY2YvTWF3czgw?=
 =?utf-8?B?NlR2T3dkd0huVWdGRGIvV0QwV0U1TXBUWEpMQmhXZmhPSWxCNldXaS9HS093?=
 =?utf-8?B?eEI5NGYySXJOMlRpVzBtL3FTaWJsZHNsUGNzWEJybzY1b1FiRWhIK0U3bCt1?=
 =?utf-8?B?dkRqRVQ0cGU2ZDh3NnNOdzdVa0kxVkFmT1o3YWI4RVdVVE5RUXdGWmdNNkxj?=
 =?utf-8?B?Mm9WTVBmQTVCWnI0SjZzZ1BDQTdIVmJXaHJqLzVubWlLSzgyVm9MOUhsWmFQ?=
 =?utf-8?B?a2ErMUVkcjJEeDN3NVdHWDh1dXEvNk1qdlhUTTFKTWR5YTNwRnY1M2Z3MlNT?=
 =?utf-8?B?NThuelFTWW16M0NOU3ZyVXZaaEhsWE1HbzdZd1pIYXF6ZGN2Sk1LdTBoVlBw?=
 =?utf-8?B?eWhNVzdNL0dkSitNd2R6Nm1NbkdRK25NZzE1YVVPM0dldEdxeDMzUkVRS3ln?=
 =?utf-8?B?R1lQaGdtcXNUcUdjbGNxeUN3Skk4aFhaS0RKUytOYmJ1M2xxUE03MG5ZOEFR?=
 =?utf-8?B?KzR5L1ZERVJiamFOUnBabEFzZlJ4OXQ3RWxjZTdkakFoS2JIdk9PWTNDRnNZ?=
 =?utf-8?B?OVBYSW5QMUFLTlBmQ2ZrR3ljOGNCdHU4cWg3OGw5bDc0Y0xZUGRiRS9BSGM2?=
 =?utf-8?B?a0hoWnJ2TWFlREoxczRUYTZsMDNFTS9LSjYyYjlHMjYxb3k3T2FHdkFzSmUw?=
 =?utf-8?B?K2ZvRWpjeHNML3UveFhVMi9PQmNhTzhYSFZUbzA1RjRYVHgvS1NXV0tuWHFm?=
 =?utf-8?B?MzUzTXJ3NFdwSUwrcHdZOEZVUnIrTlppTDVWOS8venZTQUNTZFNpNzBZbFZI?=
 =?utf-8?B?Zk1la3J4N1VoVVRLMWRISFVHRWRWY0NsSVZpQ3hDdU9RZHlYUHBIaUYzVFdr?=
 =?utf-8?B?bEdRMUtWSHlmTk1aRlBDV2pUVElFVDBSVzBWTzdJYWU5dzAxMWVja1JWOFNm?=
 =?utf-8?B?cVlBZnk5QXVHbXVVbFVVelBicFZYNWM0NGRKdnByVTdXNG9LbHBVRVVETk82?=
 =?utf-8?B?OVdXVG9pYkdsWmxMbGtmWmZsUUhKb2l3OFpzcEJaaW9zc3pzdWNxM0wrWHRT?=
 =?utf-8?B?NXB1d0xiUUVrblRoN1RyRUNsNlE1QjVmNHd1WnU3WlN6QTRhUkJyaWNQV0ZO?=
 =?utf-8?B?VmJUTnVkQUhhOGNWM0N2Rkhjd0FlMDBRWCt3UjRxYlZMWjdpK0NkNGZ4N3Bl?=
 =?utf-8?B?MFlrL3YxaVdRL3J4SmZBbVZvNG16VWNadVdKQ1VOakh2RWJ2NzVNUkFDZmFa?=
 =?utf-8?B?SUtac0UySE9MNUlHb0ZFMVVsMW1qQmZaM0liOEoxQW4zdStGZnFRemhjOC9F?=
 =?utf-8?B?NFpFbSt3UDJReVBiTi9hVklXYXpqc3hHcVpValJ2WkpZYlZxdzBMMURORjho?=
 =?utf-8?B?SGpCNXIzaFB3RHYzS2dicWVKUVpqUjdRNksydGpxWG1IUFZMVE1kSkVCditr?=
 =?utf-8?B?R2R2MUJjcHA2ajNyTSt2U2FTTG5XeFdtWU42OENSSzZKRitGcjJJMWxHRTc4?=
 =?utf-8?B?OHE4UGl4MDl0dzAzWmo2Z1VtazQyYWRQd1dOeUwvVFY4bWlDZm53emNLZDZL?=
 =?utf-8?B?eWdYZ3RyTFlZbkc5NTlPOU16VG5HR2haeUJuS0hXMy85eGxtK3NBa1lJRjdC?=
 =?utf-8?B?MWhDV1pOTWNzWGhqT2NBMCs0d0JNTlEvRVZ3NnoxOGNsL2lWckc2ZlZJMmJN?=
 =?utf-8?B?QUlyeCtnRkxZN09lYVR5clh6NkhqVi9SR0FUbkc1T1dIUW5qUm5KQVVqY2FQ?=
 =?utf-8?Q?w+dGiLM+++EzhDKE=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vR07/W+kbk3KHS+1VqLjzf2uuE2Deiy+hra1zAb5Y/6YW/VPrrJhKxF4smMcyV4WRcTFipEP82+D40mb4ubGWx9emJ2ll5yPyWBWlNBqZWpsCdaWxYU+ofoa/S3GxgpUfoV+Zfh2Yo96jdzbb0pEVxZqFIZD3HO8tan0LLYC1s/+fwYhLutfwzNGS+7ya+sQh5icW40inu51cHPh1XCxYDCdgGstxzJ+JNb/DhSVRRVSDk1A4tO4f0LRkDVHsvGD9CWUCUQRtYEJXIKG3U2lipTV8aQdmxTFAjmoHCrZShvFQBcJic1zFMC6uNbSvOJSEercXtCExFY5kR3UGqCfog==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dfdcf9-be2e-4663-ca1d-08df24a09703
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 18:27:05.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0A007Xe2U5j9e3tDG6+62vKZPkaDw+1XG3btkiXMRyj+lJHS3qsTy7ZPszDmhtN0UNjbYnx0/WQ/MqXAyhZZ0DLOrKmQZPx4MwqaQCpgMHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR02MB235845
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p_9kK5l2L2UCP5EOgiWqXl1niJsreIsfFcc0F6W0Btc_1791397628
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBMdW5uIDxhbmRy
ZXdAbHVubi5jaD4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciA2LCAyMDI2IDY6NTQgQU0NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2OCAxMC8xMV0gb25zZW1pOiBzMjUwMDogQWRk
IGRyaXZlciBzdXBwb3J0IGZvciBTMjUwMCBNQUMtUEhZDQo+IA0KPiANCj4gDQo+ID4gKyAvKiBS
WCBieXRlcyBpcyBhIDY0LWJpdCB2YWx1ZSB0aGF0IGlzIHN0b3JlZCBpbiB0d28gcmVncyAqLw0K
PiA+ICsgKihkYXRhKyspICs9ICgodTY0KSpycHRyKSB8ICgoKHU2NCkqKHJwdHIgKyAxKSkgPDwg
MzIpOw0KPiANCj4gSXMgaXQgZ3VhcmFudGVlZCBieSB0aGUgaGFyZHdhcmUgdGhlc2UgdHdvIHdv
cmRzIGFyZSByZWFkIGF0b21pY2FsbHk/DQoNCg0KWWVzLiBXaGVuIE9DVEVUU1JYTCAobG93ZXIg
MzIgYml0cykgcmVnaXN0ZXIgaXMgcmVhZCwgT0NURVRTUlhMSCAoaGlnaGVyIGJpdHMpIGFyZSBz
YW1wbGVkIGFuZCBzdG9yZWQgaW4gdGhlIHJlZ2lzdGVyLg0KDQogDQo+ID4gK3sNCj4gPiArIHUz
MiBhZGRyOw0KPiA+ICsgdTMyIGRhdGFbMl07DQo+IA0KPiBSZXZlcnNlIGNocmlzdG1hcyB0cmVl
Lg0KDQoNClNvcnJ5IGFib3V0IHRoZSBzbGlwLiBGaXhpbmcgaXQuDQoNCg0KPiANCj4gQW5kcmV3
DQoNCg==

