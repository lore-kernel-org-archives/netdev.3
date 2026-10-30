Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793344464;
	b=xeJRrbqU2wdJGCfnwC6UQI81/2KELx9PDkgRPZ31OCP78aEaEqp8NUPx8R9FhFBmEpUE
	 FjrtUjEmlorU5O0MdnX+nQ7zeZZpOKwrDMffPzZ40uVaa0+EpgWcePw2xdn8S5BUtjAU3
	 vYEDhMBeGIa2CL/1BTAW8jh5Mg1ahgg2RhS3kalj2/jNo8MFNHYMx2mWKW81yd6IY/x00
	 rZNW+pQgiZPA8lYlgRFN7xhVgwFrrKqIKGNDD/HBTuxuUfL50vzFbWhRp0nwsfUUJAGyr
	 63M0tmFIMvtd1WBdFT+2iIaoWC70hdjbLi2Q0AuoTyuCY7G04P+TlyW4qsbUj2xfb7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793344464;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9no9jsVoSk1EtlQ+o7ICmPsxoDoe4O/1fqeP0bUSRvQ=;
	b=dtSxR3mpzHc39MXDif3ueZjrOat7+Dn81+sJ51uCQv/NOi5jSGIOY5+FQRJ9VJ1yq1wm
	 OXv7E0ajk3Gl6EQoQ3H4gPlBnoILxCwNLGMOKNo+pe+ULMQRLcNk2d72eCnh+saxbd4lx
	 9GVtFWM9XMTjfA4m9hLEC1UKY4lNoXOBrzQOXyxy1yzx9eKdaFRkzSe2YOjNvIMQlswPm
	 0/T6PpkqAcBhkTHHrYGEuzqpWlNxIBm0z/Hsg1EH5lY3a94gSCReBCo5dCr4NYGWZsZIY
	 E2Np10JBcJ1d9OUDO20/3k0NwsfEZjJY3B6ItQJf3yI0E5i8Aw2yv06089LkeB8vAmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=z2K2Ba76;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.37
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF04606A31C;
	Fri, 30 Oct 2026 07:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=z2K2Ba76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irydcepxVzVAQYwCjiEYHjznixQx3TAUMy3n65oSDuMajE2zCHKCqHtrS+IaXr3mnSNnudQgEGysgEnhpFC8mxE7fnQyxaGJKSyzRTTXVnAt3QMVY8YOfVWEwuvleBsmM8GOLLO4pskFvJm5pUsCIOi6cz/CmxSAjVsR8P1o3f9mHRGMDU7p2PmGII4XzA3zNFXIdOSqLoHvYsVwWpF13kOfLsk5/V6LKRaPGPpQ4qFGhJTw/HeI7EMndA6xNG2NrDsE7uTEVajCF0MnXiHdfdBvFUlJrsCTNz524xdPlxljDaVRGlQOWbeSktUGAun6vjRYMCk1Up6r0S61MKXppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9no9jsVoSk1EtlQ+o7ICmPsxoDoe4O/1fqeP0bUSRvQ=;
 b=riitI/9vkCm6c66kxfqvVyu2Azg08Z6cWV/R1Zb8V8FT3nIksduIg9ZZuLsVmp4/68eBLMFSmMVt9uAbogGeanTgD7+GwjZH/79t8NLurxPPkDGK6B9zOulqXKbtWFEQfTx5htFYJvFY3rVJGCkGkqDwxQjHwo1xeP8XP6xmq+ecpSqDZ6XN+RFpibx6UKT9mskTL0r4dSNpy9BUcxn7HREaGCUaniGDrBJjqYyIuvxv1klSskOgdhYChVL2SKN1icxtByPDn9KaPff35E7MAIzHwX2rs85o3aGBPMCaiarYJRGFKQ9AM5IKtCQd6Bs012r8uKmMVbkBlZ9J42MCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9no9jsVoSk1EtlQ+o7ICmPsxoDoe4O/1fqeP0bUSRvQ=;
 b=z2K2Ba76FRyRbGwurICRWikdbcuvuYCEK5qXcdkPY12pDxNCRGmVUACutmfobHMvlqWr+T26OPy4C9o9fxO8YUiykfqGJcRl/e8ONN7mWmcUfmo7SZctjlKtoE2O0ojY5jkqZ474VulM3NE3JuzGXpZZzAxrJuvfab9QxWI/sI0hMrXloDHKqexUbP0qWNSjNAmW8TAbb1A+D9XpWgodztjN7uaGwXzTkNQiVqe976DHkAY5zoEhURUyvL6VPZ384LOH2WzSw29cUUxE9V4wAIxV3ZNVDlN+r8Yt5Hq5bS6AQPblA7MHgC+eoCWT9P93fTMzXTiKYV3wK90t/PuGvw==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by DB8P189MB0997.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:14:20 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 07:14:20 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
CC: "David S.Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net v4] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
Thread-Topic: [PATCH net v4] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
Thread-Index: AQHdZzJ+80OrhcpClUyxUdNHeu3l0bcVrY8g
Date: Fri, 30 Oct 2026 07:14:20 +0000
Message-ID:
 <AM7P189MB1137B1760C380E81E5A3CD8AC66D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <179322942644.17111.4355153262478871713@gmail.com>
In-Reply-To: <179322942644.17111.4355153262478871713@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|DB8P189MB0997:EE_
x-ms-office365-filtering-correlation-id: a6a2d987-f47c-4955-de8b-08df36556acf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|10067099003;
x-microsoft-antispam-message-info:
 mK+ikeb517AANRME9fZ55/3S/VNc7XkOihLIOINFJwcRliVOJfDZokEVPjLm719PqfepFx+1IyjtqViveG3Z9/7967VNk72E7npmBhbMUKsNAJI1CtnJN205A312d1rhQWc9pGUHq4fkV4d1pTt6mYfH63uWbRAaHM5Mz8LLbnuz13tl2bDo1ioawZ6JX6YnsVM/KQ6tKDDk2Iy37XX7k1T1kDGq1c7ELkYCA/jHO4pLhCOgjEwUlFmJAnJj8R7tLoqGYHpLdU4xz6Ra3WdoGX1TDGM8jKGMOhIngU+cy+arqRFrwmaXXx3OLZ6a340lUuAOpUTJf3WZZxSJNpG9Lke/3KoBydvqmF37+hBGa+DDAniuedeUCkq0iajaXIos7ytom7bv9QFP1uj/3gm6slWtg/VbkYay5TLSPYSrgiu6ax4aUZo6fKzd80QM4R7DwEZXZ5tgt5/Mscn9X1Jr9oJqxSpiiom2OWdZQWGut8lMpl+fQjNnPj9U8nrNpZIlz+YHYGDacqQ8qfnZwKvctIdnPSHnZaBwKF4EAEVgPbQHF2PsKttd2Q48D52QViLue+Pfw/K+y1bNW7DxI12zZw066VOGwkh9WOyjVAda8r+XGd8+uVzozhAP6webCtcHJr1PioMKifnD0pExDDeyU3NIlmIt5Ed00Uyr1Jj9XAk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1VYWGhIR3VKLy9mQ0Q0S2h2Tlg2R1grT2UycDZyb1UwckNudTdCTlZmWDJk?=
 =?utf-8?B?MGwzVHFxNEdkUmxMWkJ2N3QxWVdtTU1DMTJEbEx4anVUZ2xqb2dGcjhqU3Js?=
 =?utf-8?B?ZnhsQlhIc1p0Qkg3SWU2QmpIdGpWOU9qMTIvSlFPMWRpM0JCdkdjOGlibUtk?=
 =?utf-8?B?OWs0cHdXTlRJRlBpMDVEcWVwclIxNCs5WWtnTmRtTkE1eDlpWG1rWEVZQ0JC?=
 =?utf-8?B?N0drZlNRWGVVWnNFcjRmL2dPck00bDB2STJiNTYrV2o1bVdablpyZEx4S0tm?=
 =?utf-8?B?WlZQWEwrUDQ5QW5mNzFON3Y1SXZETDBjNzJ6S09jU3NSUk82d216Zy9xQ05l?=
 =?utf-8?B?Tm1OYXVXOUhvckhValFxRG5Yaks1NU1TWm1Ud3BlZk5wK0Q1MnpUa2U0UXZp?=
 =?utf-8?B?N2hTNGh1K0VNd0NFc1I0YllxQnF0R3FiSzVKTFhJMTAwS1NpcXRRYmQ2TCts?=
 =?utf-8?B?SkVVRWRIdjNvczVSamtrc3RFVmI3MExBMmZTRDZjcGgwaGJkODBjQ3NaRDY1?=
 =?utf-8?B?TkpwOWlrK05EOEtaNnFGNDUybGkwWnQ1b3pOZzludmJNNitvaVJUeTdIQlF0?=
 =?utf-8?B?ZWFHeHUyS25McXgrOHRack4yRXh3MkgyVDJJNXhPWU9yU2FYL1FKc0hPVzk0?=
 =?utf-8?B?N0oyOHNlMHo0YkYyRXFabHZ6d0V2VjR0OUdzZUI4T1c1dU5TUGhab1dXTDN0?=
 =?utf-8?B?N1NmTzRtNDVoZEZaRXdEM2doeFJlMUIxK0NYdWs1cVZPazlOZThFZjFSUlZT?=
 =?utf-8?B?ay9mdDhLZVNBVW1OVDMxV2lVdmJYQytscGFRc2dQM1k2cU9hT1k0NzN2eU8r?=
 =?utf-8?B?dXVMZzJ3MmpVZ1FtTEFBNy9nS29kVnhjd3dpOElqZVBhanVZOGRxTzZMakEw?=
 =?utf-8?B?TTl6Y05PWlREb2dsOGluZ1lKUWpjcE4vNXFIWGxjTkJkNU95NVk5dVBkOGth?=
 =?utf-8?B?VmtONkZvSjRRcXJkbDlrVXpaaXpISWRkUlplaGVLUmxNK0M4Y282L0oxOFpX?=
 =?utf-8?B?V3pwcDhjVGVSb1hXYXowYkRUaC9xeFpUUEtUclhRY04yUW0rUThiK1J6SG9i?=
 =?utf-8?B?TzdnT1NvWm10SU1XTFB0ZTZodnJIY0lKQmROWXhxblY4UzY2NVl4aWJYdlh6?=
 =?utf-8?B?bitlVGtEbmEvM3ovNk9YaFl5WXNyakZBZTNNQVdpOXpabWtBeWVpZ1JKamRC?=
 =?utf-8?B?Wlc0Z3dDcDM2Q2FmMncyWjNFcThCcGFqU3Rpb1U3NTJ0TmU2aXBQNWUyS2hW?=
 =?utf-8?B?ZWRIeGJtV2VENG1ueitPL1BoTnllek1rYU90WmVvSXFPcVlXWlFudlNHclNw?=
 =?utf-8?B?dWl1cGZkSE1ESHh0bnNOb2RMdnB2aUJWeEdTankzY21hMEUyV3Z2YVJKUmUv?=
 =?utf-8?B?SEtEck4yTFVITWpob3FVZ05POFhmVDNENHZGZzY3S2w3eXFCa3Y4SmRBUkNI?=
 =?utf-8?B?TVg2M0lkcGJLNnFSSEwyUlBzaFhiWUVtVmtPa040bm1vQ0hxd2JOUnRGckhN?=
 =?utf-8?B?MDg2OTVhalF4Sk5nbXp6bzIxOE5SRUdzcWdnakN6VlB0MGVJVlVabGtEQlVu?=
 =?utf-8?B?RzlvbmYwNDRoRWJyaitTMjVRVzM0a0Nhek50a2kwNjBrdjN1U2lZVUtXNXF5?=
 =?utf-8?B?Q1krUUQ0NDJtdit4WmVmMi96TGlUL0dZaHpYM29mbVptZ0ZtQU5PR0FVTG9J?=
 =?utf-8?B?U0FHUTJTc3VEVEtKUlRhRHRIMVlDdVRVTDE4U09GTDJ6SS9aNnVMNUE4eUN2?=
 =?utf-8?B?UXZlL0luekVjL09RRlI1UzZnb2VlYm4xRzROTVhKN3JoYUJ4ZWNSTFJ3SG9O?=
 =?utf-8?B?TzJYTGUwQzhpc2hUSDZqMjdrNUJmUGpBckczVU55bU5UTWI3NHMzRFdLZ0V2?=
 =?utf-8?B?bEhseDFGYS8yWDVUc1RRcWFnQUpIK0ozajNHajVHN2FWc3ptdE00VjN5WUxN?=
 =?utf-8?B?QkkvWksxUWYwWC9lOS9OSmVpMW82ZlRJRy9MVEdnSTFiKzhFaVNndHFlSXNZ?=
 =?utf-8?B?VXRVVWF2TGM2dFpac0NhaDNYN0NsQ3d3UmxIelNpQ2pEWlMrazZCSTdiOSth?=
 =?utf-8?B?RzJRQXNNS2hYY1k2eHI0RWt2L1hpVVR2VWdNTFJReVVzejZBanRMaVJtb1NV?=
 =?utf-8?B?cXptYjRlNDU1SkVxQXRTampnbytCemgyYTdROWZlbjBMV2U0MW04K0FQVlIw?=
 =?utf-8?B?ejY0VzB6K010dFpGR2E2dGorZkZQaHRjZUdBelh6M0Y4azUwMWVNQjh0UkM1?=
 =?utf-8?B?dXk0MHp6cnZUVElXYU5oZkhJMW96MmtHenlLbklxZzd6QlhKNkNWWWxackJB?=
 =?utf-8?B?SW4xbWFqT0ZiWUoyeDlzd2c4THJuUDlTNFk2YVEvT0NIeWM3cUxlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a2d987-f47c-4955-de8b-08df36556acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 07:14:20.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYt7qyTnQsil6ElHkQ2eZgXH5touiRytst2u7g7+iKR5rqG+uX719pBskYDWogEcq7YyaXplKibW/Pg9E2JLSUffE86wxTX4+f7WAJ0syXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0997

PlN1YmplY3Q6IFtQQVRDSCBuZXQgdjRdIHRpcGM6IHJhaXNlIHRoZSBtaW5pbXVtIGJlYXJlciBN
VFUgdG8gZml0IHR1bm5lbCBhbmQNCj5jcnlwdG8gb3ZlcmhlYWQNCj4NCj5BIHBlZXIgY2FuIGxv
d2VyIHRoZSBsaW5rIE1UVSB0byBUSVBDX01JTl9CRUFSRVJfTVRVICgxMDAgYnl0ZXMsIHBsdXMg
dGhlDQo+VURQIGVuY2Fwc3VsYXRpb24gaGVhZGVyKSB3aXRoIHRoZSBtYXhfcGt0IGZpZWxkIG9m
IGEgUkVTRVQgb3IgQUNUSVZBVEUNCj5tZXNzYWdlOyB0aXBjX2xpbmtfcHJvdG9fcmN2KCkgb25s
eSBjaGVja3MgdGhlIGxvd2VyIGJvdW5kIHJldHVybmVkIGJ5DQo+dGlwY19iZWFyZXJfbWluX210
dSgpLiAgVGhlIHNhbWUgYm91bmQgaXMgYXBwbGllZCB0byB0aGUgZGV2aWNlIE1UVSB3aGVuIGEN
Cj5iZWFyZXIgaXMgZW5hYmxlZC4NCj4NCj5UaGF0IGJvdW5kIHByZWRhdGVzIHR3byBsYXRlciBy
ZWR1Y3Rpb25zIG9mIHRoZSBsaW5rIE1TUzoNCj4NCj4gIHRpcGNfbGlua19tc3MoKSA9IG10dSAt
IElOVF9IX1NJWkUgICAgICAgICAgICAgICAgICAgICh0dW5uZWwgaGVhZGVyKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAtIEVNU0dfT1ZFUkhFQUQgICAgICAgICAgICAgICAoQ09ORklHX1RJ
UENfQ1JZUFRPKQ0KPg0KPldpdGggQ09ORklHX1RJUENfQ1JZUFRPPXksIHdoaWNoIGlzIHRoZSBk
ZWZhdWx0LCBhbiBNVFUgb2YgMTAwIGdpdmVzIGFuDQo+TVNTIG9mIDI4LiAgT25jZSB0aGUgbGlu
ayBjb21lcyB1cCwgdGlwY19uYW1lZF9ub2RlX3VwKCkgY2FsbHMNCj5uYW1lZF9kaXN0cmlidXRl
KCksIHdoaWNoIGNvbXB1dGVzDQo+DQo+ICBtc2dfZHN6ID0gKCh0aXBjX25vZGVfZ2V0X210dSgp
IC0gSU5UX0hfU0laRSkgLyBJVEVNX1NJWkUpICogSVRFTV9TSVpFOw0KPg0KPkZvciBhbiBNU1Mg
b2YgMjggdGhlIHN1YnRyYWN0aW9uIGlzIG5lZ2F0aXZlIGFuZCB0aGUgcmVzdWx0IHRydW5jYXRl
cyB0bw0KPjB4ZmZmZmZmZjA7IGZvciBhbiBNU1MgYmV0d2VlbiA0MCBhbmQgNTkgaXQgaXMgMC4g
IG5hbWVkX3ByZXBhcmVfYnVmKCkgdGhlbg0KPmFsbG9jYXRlcyBhIGJ1ZmZlciB3aXRoIG5vIHJv
b20gZm9yIGFueSBpdGVtICh0aGUgdTMyIHNpemUgd3JhcHMpLCBhbmQNCj5tc2dfcmVtIG5ldmVy
IHJlYWNoZXMgemVybywgc28gZXZlcnkgY2x1c3Rlci1zY29wZSBwdWJsaWNhdGlvbiBvbiB0aGUg
bm9kZSBpcw0KPndyaXR0ZW4gd2l0aCBwdWJsX3RvX2l0ZW0oKSBwYXN0IHRoZSBlbmQgb2YgdGhh
dCBvbmUgc2tiLCBvdmVyDQo+c2tiX3NoYXJlZF9pbmZvIGFuZCBpbnRvIGFkamFjZW50IG1lbW9y
eS4NCj4NCj5XaXRob3V0IGNyeXB0byB0aGUgTVNTIGlzIGF0IGxlYXN0IDYwLCB3aGljaCBzdGls
bCBkb2VzIG5vdCBob2xkIHRoZSBmaXJzdA0KPmZyYWdtZW50IGJ1aWx0IGJ5IHRpcGNfbXNnX2J1
aWxkKCk6IElOVF9IX1NJWkUgZnJhZ21lbnQgaGVhZGVyIHBsdXMgYQ0KPm1lc3NhZ2UgaGVhZGVy
IG9mIHVwIHRvIE1BWF9IX1NJWkUuICBXaXRoIHBrdG1heCBiZWxvdyB0aGF0LCB0aGUgaGVhZGVy
DQo+Y29waWVzIHJ1biBwYXN0IHRoZSBwa3RtYXggYnl0ZXMgYWxsb2NhdGVkIGZvciB0aGUgZnJh
Z21lbnQuDQo+DQo+UmFpc2UgVElQQ19NSU5fQkVBUkVSX01UVSB0byBNQVhfSF9TSVpFICsgMiAq
IElOVF9IX1NJWkUgc28gdGhlIE1TUw0KPmNhbiBhbHdheXMgaG9sZCBJTlRfSF9TSVpFICsgTUFY
X0hfU0laRSwgd2hpY2ggYWxzbyBsZWF2ZXMgcm9vbSBmb3IgbmFtZQ0KPnRhYmxlIGl0ZW1zLCBh
bmQgYWRkIHRpcGNfYmVhcmVyX210dV9mbG9vcigpLCB3aGljaCBhZGRzIEVNU0dfT1ZFUkhFQUQN
Cj5vbiB0b3AgZm9yIENPTkZJR19USVBDX0NSWVBUTz15LiAgVXNlIGl0IGZvciB0aGUgZGV2aWNl
IE1UVSBjaGVjaw0KPih0aXBjX210dV9iYWQoKSksIHRoZSBVRFAgTVRVIGNoZWNrLCB0aGUgbmV0
bGluayBNVFUgc2V0dGluZyBhbmQNCj50aXBjX2JlYXJlcl9taW5fbXR1KCksIHdoaWNoIGFsc28g
Ym91bmRzIHRoZSBtYXhfcGt0IG5lZ290aWF0aW9uLg0KPg0KPkZvdW5kIGJ5IG1hbnVhbCBjb2Rl
IHJldmlldywgYXNzaXN0ZWQgYnkgYW4gTExNLCBhbmQgcmVwcm9kdWNlZCB3aXRoIEtBU0FODQo+
dXNpbmcgdHdvIG5ldHdvcmsgbmFtZXNwYWNlcyBqb2luZWQgYnkgYSB2ZXRoIHBhaXIgKHNlZSBi
ZWxvdykuDQo+DQoNCkNhbiB5b3UgY2hlY2sgdGhpcyBmYWlsdXJlID8NCmh0dHBzOi8vbmV0ZGV2
LWN0cmwuYm90cy5saW51eC5kZXYvbG9ndmlldy5odG1sP2Y9L2xvZ3MvYnVpbGQvMTE5NTc4OS8x
NDkyMjcyMy9jaGVja3BhdGNoL3N0ZG91dA0KDQoNCg==
