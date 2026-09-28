Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3D37C0F0
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635588; cv=none; b=W9YNy9+ZV78h+pce7He77oYK7rf1cBeUDYKW7qvVEZJSbAKzV8811qiMy9Nis9ypcb3TOUyeWjUQQLeoBvvmfL0AwJkAiKd3GNdA1AIUTvvgaAWcYc19lDJFUMzjL97QM812Q8qjrzo02JVtc1AatyGbiXSEUR9RBDrZ152de6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635588; c=relaxed/simple;
	bh=iFCZtKWX4QQg704LiGrp33iEfEWfvEq9lXLiB/MKOO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pxfDiMH7KNCEYBfNeMPvlm5DhBVbZeXWGmAPMlFN5lqGUUHBC/IUovlPapRtbNLYA7QII/Fvoaqp2u7kZa1+C4MG4t4z8SX44/AqRsBvGg1hgf4wqnGvEnx1FIX8LBdmCbWgCA6DbMjVOSuMO7a3wHd7klkyFka9YFffvrTpXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=an9zJbPA; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="an9zJbPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1790635579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFCZtKWX4QQg704LiGrp33iEfEWfvEq9lXLiB/MKOO0=;
	b=an9zJbPA0grvIwBHxrUD0w2tGbhjKxC8RELqQ1Utmn8fVnad/5aY83EF4oFXyZ9yilwyfQ
	rhKX1jNHeuncwamcFkvXI7Ifhqmu6c1pEP9kHsHNnME/nSXOpIZOz5ffXli7Il0Bw/BOX/
	NLaYU5ogTELvfXytxY0x4SiT/teW5IIOUd6CEXDWi0kRLhOqmezcVT8ByWxQjv+iuGq5nr
	0XOfw/FPV9R85wQQBXOLEa6tvuUPncf15QWaPkf54cehuxAwKM9H4luYNiPwXfQ0XLjC+z
	C4Mk/kkh/dhhKowgC4Fp+8kinBxuKtMLipr1AsV4U6zeWIW6lx1nM67HNW7XHQ==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-13-qep4EmChOEuYlEwl_3dVoA-2; Mon, 28 Sep 2026 15:46:15 -0700
X-MC-Unique: qep4EmChOEuYlEwl_3dVoA-2
X-Mimecast-MFC-AGG-ID: qep4EmChOEuYlEwl_3dVoA_1790635572
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by SJ0PR02MB7743.namprd02.prod.outlook.com (2603:10b6:a03:321::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 22:46:10 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 22:46:09 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: RE: [PATCH net-next v8 01/11] dt-bindings: net: add onsemi's S2500
Thread-Topic: [PATCH net-next v8 01/11] dt-bindings: net: add onsemi's S2500
Thread-Index: AQHdT5hRAXZBQB75ek2Pg3KmNqX0Wrbkld8w
Date: Mon, 28 Sep 2026 22:46:09 +0000
Message-ID: <CH0PR02MB786775675C895D0154DBF5AA838D2@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-1-7e011aacc309@onsemi.com>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-1-7e011aacc309@onsemi.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|SJ0PR02MB7743:EE_
x-ms-office365-filtering-correlation-id: cf188217-3d0c-4ff6-15bc-08df1db24a21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|921020|6133799003|56012099006|18002099003|22082099003|4143699003|38070700021
x-microsoft-antispam-message-info: Hyw6CLRv+K9HQyP5g1XwmLhhV0JITYrgxgBIkm+lZVx3ByQPXZ5eHGK16u5nvtAmeNa14skc5lRtmp0PU9+TP31IjfjCNoqXfIxgqReukV/hgNv8V5nkRt4NpPkdzPjiYe4mlcWYNmULBqMAK3OBRd04SuXEGZJjHgjtREWu9Al3OieMZAYxnbx26Jh/ueGbb3xENaG6o01riJP4fH4KlEIMDwFZR6K2pR3E5GXGLdFEOxpo/jWcXgckbSKbAofb15mqRCwGEr4Sd52dWzeovJd5YDDNzWMOWkp2WWTWY+TDe8h0UD6vLWxxrFvdQaGygu8ThB9UTx/IGrHjf9Am2l3qZ3dDJv6uickAMAmb/DsZkVd+IMlEg6Is4cfWDB04t9rL0fnGNpNsN8p8XpsFmxkJ6LkVYIdDvslQBxyHmEyB1z1mIiaL1Ml6zLUqvWxL66W2aCkTnzDVi5nZCOcsII4N0SWn0h8uJRNuhyrhRUI8B7Og8teDlM/Kgdryl/UyJHgz/AkFaDbF0hptYvyh2WLuJRGLB8eZ+739AYjMlPPBAolfSf+yyubFCwLMa+xs2T+/m/n1hs2UUdRoXYoSSbGOoq/bhmaGYHAm6muoGNP5mzoTSPPtqnRROt3NM2pqh2yBMK0lN6A+5fekCuFuArBArWzwU38WJbtUzMbbbsYp9USIo+gl6HQ7M77anC+OJBjF/7S+tLJYOERBj6uTBQGmsGqapl/OJy4WGGbAADAYdUCTvm32WO7i+2swhL80
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(921020)(6133799003)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2xjRTZZandMd2J3WVQ2MTJLeUl5c2ZNY0pHa3NBWmpJL2dhcjZnbS9yS0NL?=
 =?utf-8?B?MTJOWlpFYWFSZThZazQzTFFNM0Q5bUdST1lKM0NSeGJQZVJvTDE3TUJsYVg1?=
 =?utf-8?B?TkVyc2J3am5DYXQyWEdOdnFXcWpKUlg1VGFLN0NOOWlPbWZLeHFIMlhtQkhF?=
 =?utf-8?B?ckJxengrNjFQNmNxdThqaDN6QTJwZjZhc3J1Q0hEY01OdnNzcGNGWFBFRS94?=
 =?utf-8?B?L3VWcyt3RXdEZFVTR2hnU0JINGVhRVJlLzd0UXVxbFZRcVIyNXRJTnNnNzJh?=
 =?utf-8?B?TGlVMWxUa1F6OEdyV2tqWEk5ekl5ei9OeVprSENuTVU5dldTMTBRbmhmTUV3?=
 =?utf-8?B?dTJDaXpra2hZZStscldQTlFkTEQ1cWIyWDVRSFN0NVdZZDlGT2hEaEJGSTh5?=
 =?utf-8?B?QSt5QUk1Y295ZWVNSVBCek1UODhwektlRGJLM1RXUXQ1N2VCWlluSW1YZzB0?=
 =?utf-8?B?WWhZaGJpTk9kcWZPQis4dlVWRFlZSEExOHR6UEJydEpoODZtSkNnc3lvbUdV?=
 =?utf-8?B?YXBaVjRFRkJEYWEzSUVRNWhoNVU1cnAyVlRqdS9wb3F5NVJsdXhCSHNMeWw3?=
 =?utf-8?B?blcvQUt0TzBxcWIwVlhxYWVZdmVUNjFsSTlIaXR2OHpzUUJSSEFzbW1tNG5S?=
 =?utf-8?B?bjVNV2JoUS9ZR1BpSHdCZXRTRTNBK2orekN5ZTVlZExDNWJNTHVzNHpZa21O?=
 =?utf-8?B?TisrOHRhUjNqbXJrQ3JSSWxlSGJJV0FORTFFTWVPZU1pMm9ZZFhWUGpHNnVh?=
 =?utf-8?B?ZGMzdVZJTFNudEpsWXdFNnAzRHVub0UzMTQ4RkpJNnoxM3VJN0V5UEg0bkJF?=
 =?utf-8?B?NDhoaHpxMUtIdHZBRCs1d2VwazN5b0w5VFd1bmlMLzlPQUJadVhMQVlYbFAz?=
 =?utf-8?B?M1JWWGNDNTJLcFNZRVdJZXlPOTdqNG9Ud0c1NERqYnB2Z3ZQUDRrdFVIUmR6?=
 =?utf-8?B?bWdoZWNQTU9NTVNLUW5sQU0vby8xbkVySFZGWDVvWE5Td241cGVqeVcyR2kv?=
 =?utf-8?B?ZCtYVHljZ2RMRkpjQVdtM0Z1d0V3N21IMkZabVBYR1JTQXlzQ3FMNnJpOVFI?=
 =?utf-8?B?c0IwdWhPc0VnNG14YUcxU2xhVjYzSWt6dXg2eVJjNXpmNEtIakUwUWEzVmRs?=
 =?utf-8?B?YnZVNTBSZ0MxdEhzWGY3RXZlS1dPUU8zb1d5d09rVThMV204aTJmNi80UCt6?=
 =?utf-8?B?azBwK2IwdHdua0U0a3dQcnJhM2cxejFCbC9jNmNhWkxXSHh3RGk1dUJLelFI?=
 =?utf-8?B?TXJSM1ZuVUYvQ2dqTldpcHFhQVVWVkloYTRCbVJiOFluTVM1SGlKbmd3S2FZ?=
 =?utf-8?B?QWRyWnEyVzh5WGpVWE5TSk9UV2pSOENXSm1aZUJ2RTc0U3pEWkFVeWIyR3Ew?=
 =?utf-8?B?L2o5TEhhcDhCZmtNUjYvckd5TmFQRHZ3OXVndnFsaTdldnZPcldUa2UvbERM?=
 =?utf-8?B?WTdQeXZMNXdVRXdJM0l0UWVWVGhEQmkyeWJ4Rm1OQm8wQ2k3TkpMcDc4SjVE?=
 =?utf-8?B?RFZzaFJGNDkrcFFkQUV0bnk3ZDVhMlR0QTYvZFhkS1paSGRvRi8za0dYZ1JN?=
 =?utf-8?B?TXg3VUE1WHpaOGYvM2YzVEdxWjVOTTRXT1JYc2lFOVhWNjBmSmZSczd0TS9o?=
 =?utf-8?B?Z3NtRC9jS1A0QWpuMkR0SlY4Z25qcG9uN2RTSDVUQXF1MnlDVFJFaHQyaXpO?=
 =?utf-8?B?eVRSdzlVVXhWbUJEOVgyd2FZMTVZcGFZN3RvTU1qVDFyY2hvRHZqUUFVT2FO?=
 =?utf-8?B?YmliRkd2czVSTS9Dd1V4K2h0UVV3VzVnS1A2bEFnYXZ0ZzhUREJRbkxpaitN?=
 =?utf-8?B?aUduZFA2TFJzcVlSWlE1Vy9yNVBsQlFtUVFYVVNzSzc3S29Cb2hYT1VIa2kr?=
 =?utf-8?B?d3M4VTJ3QTROSFVpb0I3dXIzSXNBYkZwSlBrejZDMUIxaE9FWk5DbVFJSFA1?=
 =?utf-8?B?WmpJYkNobWI5WlB5T0FNRkhsTktJc1QzWi9OZW9aQjhJVnprSFJFWDJSdjN3?=
 =?utf-8?B?ZTB1cHovUHkzV0ViN2hQRm50OEFJZ3Y3cFlXMlpJUVhkQlpNTkZFcm5raS92?=
 =?utf-8?B?MmhWVVdiR0RRclFLVjZjdmY4Q3NoZjhHQ3RrY0JBRXNwdWFQellUQk0xdnN3?=
 =?utf-8?B?b0MyZDNTUDd0VjdLa0M4bU9jWnhwZy9EU2IwWFhFckIzd2t5eU9jS25QWTd1?=
 =?utf-8?B?dWUrL1NQM1ZDWUwwa1VhVnovL2pNYkR5eXJPQkRXYjJ4elNvYkZUMmFkQURj?=
 =?utf-8?B?SXFNVmN4VTFmaEV0dkVGbXF4ZkRHNkNXL2Q5NnNXTS81MHhMYjVpa2FaaDZQ?=
 =?utf-8?B?eXRxRkZueWc2Q21ZUUFMbE0xUFJKcnhNWW82UU9IaDdQZkVoU21VOW9tRy9V?=
 =?utf-8?Q?1ml5gktIE71CYax8=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cG4oO3Hr//UaOfKKk0Pm0MJ3WWbNckodwdw9iRjhA9djj4W8sFXbuCmhVErO+wvmGJQ2xnbY+tMPw4/esdxw7sUdWm3txaEdNu+ncyazeuwd1zG1UV8rbSsPX/Y1XMKgIpJZjUH7U2v41/KLBht5mcycqS7/V1Y6cOH0g4CitGEEfoMIzfZTS6talYx51gf5f+H9p+RpVxfxnakl0uahKs8Fx4Tes2Qnh1Gt6XwcnVnZE9RupQWmieZ1jMiYCdWrLTXK9myFsNP0LL3ISqLYwDJHPSeo6YXmYq2btd4791O8ONh1Nd9wq0cwQNtXP5LvL5SChsRpBZIQ9p2B9aaZrw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf188217-3d0c-4ff6-15bc-08df1db24a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 22:46:09.4753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qIWJoJMyDW5jjsrqpuJyKlJyPyLa9JFG9SCe4ASyNUpHakY/QbL5MF1fv6bNWAorRGGsWIucGre5185kL+EOIVDdyvcaO3CsRRsNATG2N4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7743
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ox2FDJtMKC-pdGSlj2jrlZgsZCDEtUBX_575Qjpwemw_1790635572
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

S3J6eXN6dG9mLA0KDQpOb3Qgc3VyZSB3aGF0IEkgZGlkIGlzIHJpZ2h0LiBJIGRpZG4ndCByZW1v
dmUgdGhlICJSZXZpZXdlZCBieSIgdGFnIHRob3VnaCB0aGVyZSB3YXMgYSBjaGFuZ2UgaW4gdGhl
IFlBTUwgZmlsZQ0KQmVjYXVzZSBpdCB3YXMgYSBtaW5vciBjaGFuZ2UuIFByZXZpb3VzbHkgaXQg
aGFkIGVkZ2UgdHJpZ2dlcmVkIGludGVycnVwdCB0eXBlLiBOb3cgaXQgaXMgY2hhbmdlZCBsZXZl
bCB0cmlnZ2VyZWQuDQoNCklmIEkgaGF2ZSB0byByZW1vdmUgaXQsIGxldCBtZSBrbm93LiBJIGNh
biBkbyBpdCBhbmQgZ2VuZXJhdGUgbmV3IHZlcnNpb24uIA0KDQpTaW5jZXJlbHkNClNlbHZhDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VsdmFtYW5pIFJhamFnb3Bh
bCB2aWEgQjQgUmVsYXkNCj4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0IHY4IDAxLzExXSBkdC1i
aW5kaW5nczogbmV0OiBhZGQgb25zZW1pJ3MgUzI1MDANCj4gDQo+IA0KPiBBZGQgZGV2aWNlIHRy
ZWUgYmluZGluZyBmb3IgdGhlIG9uc2VtaSBTMjUwMCBJRUVFIDgwMi4zY2cNCj4gY29tcGxpYW50
IEV0aGVybmV0IHRyYW5zY2VpdmVyIGRldmljZS4NCj4gDQo+IFMyNTAwIGhhcyBib3RoIE1lZGlh
IEFjY2VzcyBDb250cm9sbGVyIChNQUMpIGFuZCAxMEJhc2UtVDFTDQo+IEV0aGVybmV0IFBIWS4g
TUFDIGltcGxlbWVudHMgMTAgTWJwcyBoYWxmIGR1cGxleCBFdGhlcm5ldA0KPiBNQUMuIENvbW11
bmljYXRpb24gYmV0d2VlbiB0aGUgaG9zdCBhbmQgTUFDLVBIWSBpcyBkZWZpbmVkIGluDQo+IE9Q
RU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsIEludGVyZmFjZSBkb2N1bWVudA0K
PiANCj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2lAb3NzLnF1YWxjb21tLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2VsdmFtYW5pIFJhamFnb3Bh
bCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0KPiANCj4gLS0tDQo+IGNoYW5nZXMg
aW4gdjgNCj4gLSBDaGFuZ2VkIHRoZSBpbnRlcnJ1cHQgdHlwZSB0byBsZXZlbCB0cmlnZ2VyZWQN
Cj4gLSBBZGRlZCByZXNldC1ncGlvIGVudHJ5IHRoYXQgd2FzIHJlY2VudGx5IHN1cHBvcnRlZC4N
Cj4gY2hhbmdlcyBpbiB2Nw0KPiAtIEFkZGVkIHRoZSBtaXNzaW5nIHJldmlldyB0YWcNCg0KDQo+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L29ubm4s
czI1MDAueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvb25u
bixzMjUwMC55YW1sDQogDQoNCg==

