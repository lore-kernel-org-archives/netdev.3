Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.153.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189269;
	b=yDwuVNtaBH+3Ai1hRKQEtnYyHH87ejCzww1Ff0VTd8d62Eh7WWZGqaoY6eiwjIIrAR2L
	 NpqoFip6zAoam6biydKW65D8GbFA5bfhJLk8KSDt/AlcImyjAOiMzDi4ev0887/0jESZz
	 GFVsIKzMfRdIdz6xeSslnGQnc7+qhG/nb1oRfgeUbIhkTrpAqLp8dR3hsgd4Ld7WTjBFZ
	 O0q2Ew0LPpXPGwe443qWmsspX66Nr9UWz/C5UKtmREY7604H1DDjdkW2vQAx34oXC9T4z
	 tDAvwcFEeya30tsodyOCRUpDZEf0qW2FmsuUWCrLYdySRKboqgYb8uoKS9xl7Zc3IOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189269;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=4Ce2Opq+3cRum1feb4ndeygKjow9mzh4NOCsEVYyi5E=;
	b=Vh0cyeCc5WqhwiPc9q5zPL50tWL9CTOWJAszsX8XfhCA4OKi710rCO58nQjP3GAuHKiE
	 p63hzpZPCIujYXov1EjP/DA/B0qrkAq0QPQ3tgH+vtEhjZiToYVOMvTSNGsNp4zhvpWGz
	 12U93dmKB4eFtlQhoLQWkGDBnnPqznTuChS4u2xLkksk+4LcEuLVUCGFSPwwJeAF6qptH
	 dGccL9/9SeJTkLG3om8tPYwWc+cOSiSlqwJrGGgp89FvvD8YfSPrDHY3R0yB+B0h3UjvX
	 XALRvU+PfMYQebeaSxHHK21EH3bO/Z5Z1BiDhfMusWFGBaubwJkxCeSYuOGaCGFGBYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=dDGY9mwd;
	arc=none smtp.remote-ip=170.10.153.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41E606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA41E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=dDGY9mwd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1794189267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ce2Opq+3cRum1feb4ndeygKjow9mzh4NOCsEVYyi5E=;
	b=dDGY9mwdnQO828lseRiZcOJPs0DkhHRpR1eCEoIAqdCtggD9AfVreAOEQ91wj5X4BuJ1Ys
	ZfVFjS29gjUirkRk5ncZ8NZ4lf3Tj0xm9tEWgd+dH5uEdzk6Ggu067atZqifrsODYFKDPX
	JlOOWjdaXAnI/AHxZTTOrBfiguBDQJpcVY09CvquzhHRUaFG8X8a/IKvcsJD2Ktmoo4PRZ
	pKnVOe+qQXsAA/DkgK8UwVW1++WPUIeF+UjFfUDT2qbuz3tK7LtxaBFtJNnyWtQjPWO6n8
	Ljr1rIPyfWvu2lPilSL8NKG2o5syQJO9ivUPjh05vYQxfvSkVy2NvdepXA5YyA==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-58-Lk60vyD2MOyqDmZIGEriAQ-1; Sun,
 08 Nov 2026 17:54:08 -0800
X-MC-Unique: Lk60vyD2MOyqDmZIGEriAQ-1
X-Mimecast-MFC-AGG-ID: Lk60vyD2MOyqDmZIGEriAQ_1794189241
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by SA0PR02MB7209.namprd02.prod.outlook.com (2603:10b6:806:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 01:48:56 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 01:48:55 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "piergiorgio.beruto@gmail.com"
	<piergiorgio.beruto@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "jerry.ray@microchip.com"
	<jerry.ray@microchip.com>, "ciprian.regus@analog.com"
	<ciprian.regus@analog.com>
Subject: RE: [PATCH net-next v10 11/11] net: phy: ncn26000: Support for
 loopback
Thread-Topic: [PATCH net-next v10 11/11] net: phy: ncn26000: Support for
 loopback
Thread-Index: AQHdbkU6i9E79EVvikCnHNGf/9UL4LcjUA6AgAF3bdA=
Date: Mon, 9 Nov 2026 01:48:55 +0000
Message-ID: <CH0PR02MB7867732FC15ED54183BAAB0783732@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261106-s2500-mac-phy-support-v10-11-31b5a69b85b7@onsemi.com>
 <179409694533.994134.4523797133943252048@kernel.org>
In-Reply-To: <179409694533.994134.4523797133943252048@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|SA0PR02MB7209:EE_
x-ms-office365-filtering-correlation-id: fbf5158d-91a7-40f3-07d5-08df3e039d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|10067099003|11063799006|4143699003|56012099006|261022105027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|261009220027099003|261026140227099003|261028144727099003|261026121527099003|22082099003|18002099003
x-microsoft-antispam-message-info: rVwCPDQJnDozJAnSGW+MmTxS9t3iqg2Dhf+O+q/4LqFJ/ErWbwDJc5N4hMDJgP7obrm84WdSI5gYSr2llAjYmqpj1lclOvRI5yguo4LplyLwhm82THPj7aRZTU1tTf8/iXp7ByfzoOyGaXy9xDY+ZL1npSU1VWDY7YNEhaXlxZ3xAiCtsL4SzbMQBULWzj179eqTsVkuNPEVA2VuPUuXo8ous9Uu7Z8sQn9d4+TYbEZxDRGUHXOdHKbTEaUzvhA5UT+FiRkndcw/TiV3Q7m/Pbb7EhPVjhkyQptJ60zx1ObPnSPiIhQ9bLfCifDcIyYd4l7oLhfAel8Pvp0mJ8Gmf7l8FPz+9XLSBmVuFSXHlaVhE4v2CpG+RYAfM/uintsa/MG/jVU5LYzfJJCZvQfvoF86sUVmpG+dv8oOhw0fXWBSW3n2T2pzISgZFc3jdvQ23xFgYXzbqKWoiGoCRrjaZ0XUC7+/nFHyBAARff/0T/+NUSudi7sKJVBbG8nvYSA6PKprmGYO9kwu4dhp3QwwGpdssu8TpWzggym4SsElo5Y93hStU7ex2gukao8Zx24KCshUCWpaYubH7eq4YKwdsLQ7RehskIO4ve6GX/+2vWH8/dLdr1gJXv3Kc7mWCxFmca+q27iKuk2fPbvyb3QLlB0qHCB4cOIsVF49gzzmA1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(261026140227099003)(261028144727099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjZIOFVJSHM3Tm9NTkwzOWVSOVltL1BJV0dCL1dXaVdyakVKeFZHZ3JwRUVY?=
 =?utf-8?B?RVlUb2REQi9NYmcrT1NVcDAyanJKZzQ0eDV1QTh4ckFxaHdqTVlkckJvNG45?=
 =?utf-8?B?UWdZckNKdE5SVFJWZm9UbVdwQ29YdHlHVlJMZ0U4dVhGTXQzd3ZZV0J3WStr?=
 =?utf-8?B?eEtPblJQYkNZVm1SYjNncEJabnh6dFB0bThtY0FVamdMeHZ2SDJ6Ynd3dXE1?=
 =?utf-8?B?Tnppb3JtU0p5MUdUSlRJZUFTL2VBeVBXQTA4c0JPZnJYL3VjRzFXNnpQdWhJ?=
 =?utf-8?B?THVEUXdvV0hLSE9SZlhtaWxVK08xaGhpK1ZCQjV0UjZaWEEyeWs0eW9xWkMz?=
 =?utf-8?B?dEl5Vm16ODdBYnMwdytpMHpJNWZSdGRsbHpFR2o4elVBMEJBeG9QWE96Unlq?=
 =?utf-8?B?K1B4U0ZQUVR0M1VCeHhnWHExQzhnTkZkdGRUenlZYVZlTkRJRksvVXMxUUdz?=
 =?utf-8?B?RFROZEpkZDQwYSsxNlorZHg5VUxuaVArb0tjWG40R1JHZlhFTnJpeUtYYi9Q?=
 =?utf-8?B?OThlMHdSbGpla1hBQnBvY0s5dUVNcFF3TzlRMFEwNnJ5OE12YWhnWFBtdHVY?=
 =?utf-8?B?OXI5c0xoeWc3M1JQbDRPeGhhYzNtbUNpdlpMa3F3V3dsRlBIYmNaRWMvOWc5?=
 =?utf-8?B?UXJNaTNXV0pwZWZTU1dtWEwvRTk0OEw1L0dJVG4vNEtHQ2ExdmVzbW03aCtk?=
 =?utf-8?B?TkpsSERrcDhaRmZKcmVNcUJzeFVQcHVZd3pMVWlNN0FKSHhjTUx2dEFpVXVN?=
 =?utf-8?B?TnpGc2U5U0t1TU44ZHRMcklTZFcvZTUveXNGdDROdm9mRVdkaDZXLzJTbG1h?=
 =?utf-8?B?N1owT3NwMExkcEZ3dEFQVkFRVWRqVU9NQ2xZVFN4akYrdUh6NU5WcDFLcjJm?=
 =?utf-8?B?V1EvQ2Z1bGFDWk9XZnAyVFRSYzV5L3ZpNkNoYjZrNjdtYTRHK0Z1cG83MmxL?=
 =?utf-8?B?aURTVmVKek5Qb2lPZlJLbnhMaEdjSzFOaU1HN2M1bHRSckhiM210UVRhOUZ6?=
 =?utf-8?B?QWpEMm9iaENpcmlHRFRPSEpTZWtzdVF6SS9BNGVrLzg3c3NJcDEwQ0cxQTJt?=
 =?utf-8?B?Rlg5ZmZmdk00U1Zwa1NQbWIyUm1hbDlLbUZOT1VZSExtUjkxMElzOTZLRVVp?=
 =?utf-8?B?aHM2eE1qWlNLMkJpaHhjUHc3bXRQemFZdFpEK2oxREYvMXBBNm9wRWlyUzJ4?=
 =?utf-8?B?NTI0NjI1RjNnb3kzUFFuSzNoeVlXQlhMd3FoVG9rRG1zNFc0aVVxSXpNV1FN?=
 =?utf-8?B?emI2OWdjRitEVUs4b1VEUE5jb1pTdnFLNHZLK0FjYWsyckpMTVhEejcwOUpW?=
 =?utf-8?B?TE56d0NRdGVxejZlTEl3MGtXRGc0NSthQVdKelUrTkdUcjJ0bFg4T0kydFpi?=
 =?utf-8?B?UEF2NVh3SUhuNHZDa1BTdFgvLzVlYWxveDkyb0RGVDF2VXpPWFFFTWEzUTFy?=
 =?utf-8?B?UndidkcyMUl5ZFVZaWd5OWp5aEQ3ekt4aVBKYmk5VE1WTi9GNXN5K2thUG5B?=
 =?utf-8?B?V2dyK3FPUWhhRVdTbHRUUCtla0g3NFkvbUlXbTArNEZ0WXlTYy8razg5Qjcz?=
 =?utf-8?B?RzFDVE1UMXBhanhyT3AweWRnV2ZYSFlxVjEwMUZlTUx4VzhITG1FOGc5RDZI?=
 =?utf-8?B?YUVKUi9zdFBzbXVsQ3pTY1JERnhCVWpvdko3TlJtZkxvOTE2WUpCd3hHS1VH?=
 =?utf-8?B?WGhGdWdaSjZSN3k5ZnRXZk5PWFk5WmhSak8yNC9yK2tvVzhJN2dnYXhBMWJh?=
 =?utf-8?B?c21kSkRzVHlZek9qQXJkM0JCR3YxaitNUzhHVHJvN3V4TzZORU9hNjVkTG9Y?=
 =?utf-8?B?aVRwcDZPWk5IUHJuM1hqWFQ5QUVGWEZhWjVHalVkQTBmWSswcS9vbUZ6K3Rs?=
 =?utf-8?B?RFpxTUZTREswbWFWRWZSemExT1JaNlJiSkZRVnJUMXRVYWdwYmFSQkFXTWFC?=
 =?utf-8?B?aldEbHdUV3l3SWN0ZFlJSjV3Qko1SFhiN0ozSjFHSEZLekRWMlVuV3ZPUlVp?=
 =?utf-8?B?bHFrUy8rZDk5MXFBcTY1aDVrdzdhaHJldHl0c2x0UDZuZnFsL1JMQmV4b1Fr?=
 =?utf-8?B?VGxXZlZzcEM0STI0WHkxbGorSEw0L0VaZ3BFbDViUkRLUW9IZngzZkpFSzFi?=
 =?utf-8?B?eituOHh6R2cxTktZeUFpdzJGellkSm5jWEUvTUVLSHlNVW1jdHhIdHJ1KzVl?=
 =?utf-8?B?M3RYZTQwT3k5YkFOTnJnOGdaT01ZQXp1R1JVdFBLU1lBSkNjZURUSS9MaWpP?=
 =?utf-8?B?ekdvbEhlelA2bkNCNEQybDl4U0ZnRTg2Z1orc09qZ0NMZXFXV1lwSmRyRUla?=
 =?utf-8?B?ZGhlOFdlM0V3OEtPU0xNeUhtVTFGWEF3YkhuUWk3OStnU3g2TmV4dz09?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PTJLim1RQZ25ErDKXonQosjEhLsSwKrxjEV6QDQP8QZp899U+OPxhliiSRT1TwYbWBgRwAODpqvFh9X5tt4WXSm5slEokSu73HJMKjUMxdz/g5HQlyrLKyROnoNwgTYN7j5O8rds2FwW/8W37W0UK0hlCCHaXRnbS0q7kAz6HWduCyhBFnI5GEZ62Y2wUuVS88hj1LJalXpKymkRIIPBZZ3hz3pRp2AU9VVtEy5iyrnYgTbGDSL65XujtPFBrQUY4H2FH72gNKvV6DTaK2rj8lHtisiKD33pA3rBjK+Q/gc9mKjfn8J1akdIvsW22ApfYuaJn8tH6v0n9QF9XFpFJA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf5158d-91a7-40f3-07d5-08df3e039d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 01:48:55.7729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1eI5WFd/BygPzShLY6WkTqdtdsY8CgBuFrw0WnV/gRihxo2sAwNmDwKZRWSrzvCNvcT6As3//dSRlHM3WRYsxg0crQhFBGl2L8S6pW4k0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7209
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QSUNnAg7PWmJQNpcOLb9amG7Jdpfi0qL0X6IPEW-4eI_1794189241
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBuZXRkZXYtYm90K3Nhc2hpa29A
a2VybmVsLm9yZyA8bmV0ZGV2LWJvdCtzYXNoaWtvQGtlcm5lbC5vcmc+DQo+IFRvOiBTZWx2YW1h
bmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjEwIDExLzExXSBuZXQ6IHBoeTogbmNuMjYwMDA6IFN1cHBv
cnQgZm9yIGxvb3BiYWNrDQo+IA0KPiANCiANCj4gQ3JpdGljYWw6IDAgwrcgSGlnaDogMCDCtyBN
ZWRpdW06IDEgwrcgTG93OiAyDQo+IA0KPiANCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IENhbiB0
aGUgUzI1MDAncyBvd24gY29uZmlnX2FuZWcgY2FsbGJhY2sgc2lsZW50bHkgY2xlYXIgdGhlIGxv
b3BiYWNrIGJpdA0KPiB0aGF0IHRoaXMgc2V0cz8gZ2VucGh5X2xvb3BiYWNrX25vX3NwZWVkKCkg
ZG9lcyBhIHJlYWQtbW9kaWZ5LXdyaXRlIG9mDQo+IEJNQ1JfTE9PUEJBQ0sgb25seS4gbmNuMjYw
MDBfY29uZmlnX2FuZWcoKSBvdmVyd3JpdGVzIHRoZSB3aG9sZSByZWdpc3RlcjoNCg0KQWdyZWUu
IEFkZGluZyBzMjUwMCdzIG93biBjb25maWdfYW5lZyBjYWxsYmFjayBzbyB0aGF0IGV4aXN0aW5n
IFBIWSdzIGJlaGF2aW9yIHdvbid0IGNoYW5nZQ0KYW5kIGNhdXNlIGFueSByZWdyZXNzaW9uLg0K
DQoNCj4gLS0NCj4gU2FzaGlrbyBBSSByZXZpZXcgwrcgaHR0cHM6Ly9uZXRkZXYtYWkuYm90cy5s
aW51eC5kZXYvc2FzaGlrby8jL3BhdGNoc2V0LzIwMjYxMTA2LXMyNTAwLQ0KPiBtYWMtcGh5LXN1
cHBvcnQtdjEwLTAtMzFiNWE2OWI4NWI3JTQwb25zZW1pLmNvbQ0KPiA8aHR0cHM6Ly9uZXRkZXYt
YWkuYm90cy5saW51eC5kZXYvc2FzaGlrby8jL3BhdGNoc2V0LzIwMjYxMTA2LXMyNTAwLW1hYy1w
aHktc3VwcG9ydC12MTAtMC0zMWI1YTY5Yjg1YjclNDBvbnNlbWkuY29tDQo+IGV0ZGV2LWFpLmJv
dHMubGludXguZGV2Pg0KDQo=

