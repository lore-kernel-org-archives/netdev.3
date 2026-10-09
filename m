Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB814BB806
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571433; cv=none; b=eKyUyiyxnU3wypnbqt2eDJUDXRMaXXQuxaa5SaoaP2YMt9vNyCLIGWubigRrOL0yl1UdkgnTcQK57gt2EZl1IibxAi4FA29jIGDPM1dTURWRhtHqO0wmr8enyO4FBW+3lgXEqTqQRP+T6kn99wx6Bpsik8D+R7rApb6uX9LtlEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571433; c=relaxed/simple;
	bh=xtWTu6+pBQMmAzO+f7cu3L2LF1Uc87T95CwGpTaH3P4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Pd8bizYW+Yd6aNzXsHOD1Tsk9FKO2rgx161xpvCMEZaPNq9SZsdrcj9egh3ynUf/2vTiyy8CJkIxmM2kUHEttiTLXT38P3Fll/0Rkmex0iHESDhjutIErOUSwrbKKc/2hp0uoa6qfAUKlNqcq993pRt/k1qvPI8djah/Y0nM+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Fe+XUMNs; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Fe+XUMNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1791571427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtWTu6+pBQMmAzO+f7cu3L2LF1Uc87T95CwGpTaH3P4=;
	b=Fe+XUMNsdfraeChPkfRwKmrwVsw9dujiv3xWK+HgbTJwZdrI8nWe0NG64rRX+KRlm6rzVC
	2bSHMYKdakBTvQ2kmwCiVuCMtp+1+8y59LxGpBxWirIw930YTFCnXMnvQAHSlgPzVl+0Tn
	rugWKGxkm//33FUGKvhSGw/N44ZpjMFvcvqj4OR6wVth8G48+d3kcTSsO9AvbUvOwifgb0
	lqwITjrmkUaUnL7+s9Z8YJGSo5mpyCs0WsmVB8FkT+WxqKDWTm6ZA3Xrc4YfQLQYTqNFvp
	Kl0XzjbzBdsQe8QN6hxlnNcZzRJwsS4367OxKeGerApA8MYqIcgBlK9pxcPXxQ==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010068.outbound.protection.outlook.com
 [52.101.193.68]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-36-5ESpsXamP266Vh4cYkXz-g-1; Fri, 9 Oct 2026 18:43:42 +0000
X-MC-Unique: 5ESpsXamP266Vh4cYkXz-g-1
X-Mimecast-MFC-AGG-ID: 5ESpsXamP266Vh4cYkXz-g_1791571414
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by LV0PR02MB11298.namprd02.prod.outlook.com (2603:10b6:408:32e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:43:32 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:43:32 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Eric Dumazet
	<edumazet@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>, Ciprian Regus <ciprian.regus@analog.com>
Subject: RE: [PATCH net-next v9 06/11] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Thread-Topic: [PATCH net-next v9 06/11] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Thread-Index: AQHdWBFjHk5k1TxWY0OZmj2HwDxZRrb1i4Xg
Date: Fri, 9 Oct 2026 18:43:32 +0000
Message-ID: <CH0PR02MB786741F5B98271E09EA2B1DB83922@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
 <20261009-s2500-mac-phy-support-v9-6-dcefe1d0bf0d@onsemi.com>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-6-dcefe1d0bf0d@onsemi.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|LV0PR02MB11298:EE_
x-ms-office365-filtering-correlation-id: 59d638ab-33e4-4042-79df-08df2635382c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|6133799003|22082099003|10067099003|18002099003|921020|4143699003|11063799006|38070700021|56012099006
x-microsoft-antispam-message-info: 1GsRvhiWwxu0QFtVQr3lrfaOkEOIGp8k9PpGw920U9HYjKa+5fKfwPJWdImrOEZXGzuiFyqhqOww0a1+Re350THSBrZCkbjqJMj43iwAOjCml0j+Zv2jvL5LkTnLoHFX1uaFjXHpWKPhEoAdVhR2YOz0vzGHb40V14xI4WPK9AG96MtjR1V0SA8NvJ3XhvHeHniH5AdamIrt6OFkNUpADBtG9ejXiuPr7NmknZc+7dV/Q8xoUUH6uMAjx/ols16i03JtmfvbEKFKOwC1TCo30UOcU6vbTGJdlPP+druSWsrLCl5OII/l2rK7l2HaUONCPGulwNR72HXcz4C0gr/FZ7Yp1Kr8zNABIUdM+RLo6MffLtLWw0sosUenMp9OsXjwsdqHGd/r9MqT4snJ8bqFX+1++QG5XT8unNCrtX7L7DtEpTqe6Sb5P+YT9UpW2szp/3Ky74aAcPI8n31WIpcmHdH+5CIfsQwaH1MI7Zsme0Az7ba8OsSz/4yKtlXAelo0CS0XNJb+ZUMewfr1gdj6BSTrWVj9Ock4WjcBon9ychFGTQ0Hz4rPpa5g3LMwV4epttYNX5DPwxASL1LmT6VR/gliPskUSl9h2K8oU2/9VR0zBdOiJ1rW3ORFqK500ssBC9wOP0Gjfa3UlgvHS7FJ465kOd4MgpbqGaQ4Ktt6OlVWLt2DFXlmaGgcjB0TQdZ1z5hY/NP+58Mt374KsJoZbnjTN6UeeC5nLw1RA9g0VDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(921020)(4143699003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFhySTUwUkUvbzkra2o2N0NvYi90QVpncmdoVGJEWkVQZmZEdzVGSUZiWTdh?=
 =?utf-8?B?NlBYQ1JacVkzRnRXVWc3L1BVTGczMDgyN01Qa3ZCTzJMVUQzanZPeWMrRzg2?=
 =?utf-8?B?bmJvd1J4NHg1dS8wc2Jha0xiTDQ3RXR5dUV0bGlDUXRjM3ZjdGUxdlorejhY?=
 =?utf-8?B?Mk9VUGRCYnlPV0FRdDBuQVJoTEFWaSsxR1ZvVkRUdHczenNhcDhHMXFYd2kw?=
 =?utf-8?B?UVFSaGc5UVRVRHowTW81WjhidG9oeDdrbHVJYWV2dUdMbXNFSGdRMTlNZWZV?=
 =?utf-8?B?aXEvOXBMMzQ4SGpsNlcrOGhZYmZzNkl1aFJDbFFTczhPd2M4NVcyUnFrRTc3?=
 =?utf-8?B?VG1HZi81LzRnWCtkdzZpNmJnWldIZE14aDJLRXplcDVmeVN4bGwrUnU3cktx?=
 =?utf-8?B?NWw5L0JpQi80Z1o3RXU4cmVFQjNtVDhXTlIzTXRSZ0tWdWZVLzdaWkgzSUJ5?=
 =?utf-8?B?VUsxaFVwWGhGTTNZd1kwZ0FpcTVmRXdYcEFUU2Ivb2J1T2NxRWpMRFFQSnV6?=
 =?utf-8?B?QUhWS0h4R3lZbmsxUjRCYXVHQThsVjJTRkIxTExUQmIyUkpWWG9TQ3RFbTFr?=
 =?utf-8?B?UTF0cEIyZ242WTRtZEM1YzBwa2JzUWxOL0ljdURhbkc2QkhqeDNoNWZVSzVL?=
 =?utf-8?B?SmlzSnJ2Z1l6WDVldDhsUlNFQ0pIQnV1eGFjVFFlMUgwODZvaitDMWx2Y1dv?=
 =?utf-8?B?WnNJRDlVb1NweGdGaFFNRGtCV1IyMmFzeXE1cHQ0K28xcE5tbWNJZlZONVFR?=
 =?utf-8?B?ODE3QXQzak8zM0dCeFZVdVVheWhhVmhhOGYyVHB3YzVjSHYxUVRkRGp2dnVv?=
 =?utf-8?B?bUd5czN2empDdEhETUhFQkhIblpLZ2lOSmJLSFh5dTNZeFVqenJRNmRFQ3A2?=
 =?utf-8?B?dzd6ZTd4M0ZEbmkxN2crbVJXOUV4NGdseTRhQkhldlhzSGNiaWFPYUpRYmVW?=
 =?utf-8?B?N2NoZ0oyTktjbTVRWHFFTlFTR3c2MEF3cjVWQ1VoLzJKSStNdHVjR1kyeU4r?=
 =?utf-8?B?OE9WQnNSNkw5cnNLSW0wajJ6bG1Qdzd0bUlkdHpzaENEZDZHSVdseHhOWmUw?=
 =?utf-8?B?djdHYW1JajI2d2IrcmdCZmtJcDNkckVlL0hJRmJsU25OdUV0c0xzd3JxdUhX?=
 =?utf-8?B?a2hyYjFVL2xwKzRibGx3RWUwOUE5UXd5R1BPRVZSd1ROZFplVy9HOVozR3Qz?=
 =?utf-8?B?b0NrRHNUNDRMZ1lOY29xWWZRZVIwQnJHeWdkNThCTHlpTnQ1clQrY053Qm1M?=
 =?utf-8?B?SWVNaVNXNGh3MGFZU1N6L3l4TzNOYlNBajBRNmF0eW9vdFJMNUtPaHBRMDI1?=
 =?utf-8?B?dHkycVlLeCtlZldWNGdCS2FzOEgrTlNnVFQyWmlNUHhXUFJzN0ttWTV2endv?=
 =?utf-8?B?Y1lRWGUwNGMrZTJYa2hFSm1XQVNFa3dJMTVyNXJrN3gwS016NkpKT1d4S0JZ?=
 =?utf-8?B?MTFXSFZyVmdaYmhORm9FVmo4TVdzVlp0Nnp4ajdNcS9qNDdnaVV6YlVKcFJQ?=
 =?utf-8?B?K21hSEpUdDhHbzlXY2tNbnBtNCtzTzlHZjRURHJwdkNJcVFOcGwwYjZoNnlk?=
 =?utf-8?B?ZnRtU1ZoVFVIYVMvZzJ1TEd1QUdvWlhOdDJaQjJJdzNwWHd2S3pobjJqOGwr?=
 =?utf-8?B?Q2NvNE1Na1c2Z1p0VHUrUGVET0Z4Qzd6aFdzaVdTQ25BNnRZQVYwbnEvK3JD?=
 =?utf-8?B?NHloalhYdHNnYjNiSStGRU9tTVM0NGVuWm5rT0M0TVVIQjROVGJhN3ZqajNX?=
 =?utf-8?B?eEVoRTFHYWdZVnR4dkFMaFZndDlwaXhsSis4RnlEUjFheHNRL2xLQWNFcjla?=
 =?utf-8?B?V2lNelM4WE5EdlNlVmkyR2NPcWlHV2JvL0VFdUN5b01XVkR1T3FrRVV0MytI?=
 =?utf-8?B?czMyWmJDSkVnNWgySHA0V2YydHFkQ0xNUUgzQUpqVHZkWVIyU0RIcVBlZlI3?=
 =?utf-8?B?cXRmYThwQ2JaQmNWaEJuQzVzeFYwWU1zNEwxTnJZR0EyRzZqbTFsdFg4MC9u?=
 =?utf-8?B?N3lrWDV3K1Y5YXZ1eUg0WGl5UzJHYitiNjNUUEFwbG93UlY1YWQzaURGTFRD?=
 =?utf-8?B?S29uS2l6YlhlYkpUdENHeHpDOU9EWkM5OHVBajBETkpqbUM1SzRHM1A0cFZq?=
 =?utf-8?B?T3pPNHY1NllTZUZ2VHpHU1J1ZGQ2SmpJaDdxSWZLVThPVkdqbEpkYVhHdDl6?=
 =?utf-8?B?eXN1Szc2ZXJDRklNWmwzcytXSUNvSzVqTDRhTHAxb3dVV0o5V0dRL3NOVkYv?=
 =?utf-8?B?RnFhY3V6bnNvMllPaEJvVFpXNnFxdFd0S3FaZ2Vsa2VEQUF5Rlc1RzcwMkxM?=
 =?utf-8?B?a3BXdm9ucitGaFhpL2hhU1Y1dCt3V1BpTVZyK2tPNnVvK3ppdzgrMVZOK1ZV?=
 =?utf-8?Q?ywKgzqlAV210Cb1A=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S2XagUPJP6Un025xxXrvrO4+yy27z2tfn626cTnbjT7n1i/Bc5k7sk+7p3U5Bu2zMH5OjBE1t+FDusFI3ZzxTBCfYlL04oI2SrrNdEuu/JD9hl7h76CN1eWMO7PDrriuGQj0nOXwgOR69s/qSmexSMTTYXedIUPG+U1M+zgRWhfJc1o8zJKZEdQd7soQtvZeFETvmyQfWJXKyIMuXqPtfm9UmnYZhz00yHxFcSvItDbKD4Pc8VfJCReBjjYlyZIvnxyEgnlHGAx6uNU/uv1xdNN8o/skejx5B3QenYayRo+S6iAeDcl535KUTdLcmxnTEVI1Gc7KIiGrXgeqTsZWYQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d638ab-33e4-4042-79df-08df2635382c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:43:32.7077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QS0vRBoSw1oJy6zr0NAosfZAIl+8bq2OdwdWLXJdp8TroKrcQH1uxlSyxOCmn1ijRWllOj7IzGcsjcVZ86i1a+oFUjCSyfo3vFScSlkcwxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11298
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8OZV5reA-eUblonpa3lJsDnWvR1gMkVZe6vjemwejao_1791571414
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

QW5kcmV3LA0KDQpNaW5vciBjaGFuZ2UgYWZ0ZXIgeW91ciByZXZpZXdlZCB0YWcuDQoNClNpbmNl
cmVseQ0KU2VsdmENCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNl
bHZhbWFuaSBSYWphZ29wYWwgdmlhIEI0IFJlbGF5DQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4
dCB2OSAwNi8xMV0gbmV0OiBldGhlcm5ldDogb2FfdGM2OiBTdXBwb3J0IGZvciB2ZW5kb3Igc3Bl
Y2lmaWMgTU1TDQo+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVu
bi5jaD4NCj4gU2lnbmVkLW9mZi1ieTogU2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJh
amFnb3BhbEBvbnNlbWkuY29tPg0KPiANCj4gLS0tDQo+IGNoYW5nZXMgaW4gdjkNCj4gLSBBZGRl
ZCB0aGUgbWlzc2luZyB2ZW5kMV9tbXMgaW5pdGlhbGl6ZXIgdG8gd2hlcmUgaXQgYmVsb25nZWQN
Cj4gLSBBZGRlZCBSZXZpZXdlZCB0YWcNCg0K

