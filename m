Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508A431E5E;
	Fri,  9 Oct 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570733; cv=fail; b=F8wqftOieHl5rgS/9XSVEioPNgGWSk6ED7hq833X0zGUQILMf/J/BpSNzga0GdqfxXxQGEDkfdiuVQXVSjlQM6YLcJZiaMmHXzSjmnwBUc0rSY/9mnHPdilUxa1796L4sQjHJAS59ClgrtR4TU4ARkY68Ogswn/NlRzf4oWfKzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570733; c=relaxed/simple;
	bh=1rqcy1+rDcwHpLRxRPvJD5S9k5RLGYJxX9iBOPFFdvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HT/GUDkbuuRqL1J1WpoWBo32i6EyDvxvwSts3qzhU0OKbQ7PFduxLLHu47QGKV7/JX9Te1cjWHxrqHhmhhofyJCQ10YF2e8XE+i3E52PxucqUqU7VMOYauAHvnWAWwe+4f/EiHWk4TBdfwjFERIyT0t9NuzDp5yXU7GHqIy86T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=R0OfmSY6; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=BFxn4XDE; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="R0OfmSY6";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="BFxn4XDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=z9T/O20LCeoqT0V8Sru+BR3WG/V9MF3124O9IGMMUYA=;
 b=R0OfmSY6Dpw7O1knlEUDXGHw3+83WcPVOvf+oRgbRcsKCv5EM0zCI6nsIuDIvYjeANHylkZhVoMunByXb/WAsvASBFh0Tmh2j+nTAwXDXA6qHqjDTsjS1KahYdft9VoSM6DokTWVdusraWxYAyqN4/wwmtPaJaH1PQTEvO0hS3AC6U/CT2p2dCdUWn2TiEQsyLi0Fbdxm6m6TMJZXh81ppoNtqAs1CPM7rMOwjxdFyi3FMqOQOqPdOgA0S0nLSVZ2Hx02FGgreoiTB1Ysp1ilSkuFESQj8JGGqKBy2fsvBxjVNlVP8BuLl96tRU1Rj8Oc/l0pJfc8BaTRvdc/osZaw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023142.outbound.protection.outlook.com [40.93.201.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9782FA80076;
	Fri,  9 Oct 2026 18:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuDBEhXFn1hH9XOvo+yaVByyBcLQ8bIpYgCi5mcfiZjdmjJf/LnX8NvIm2t1bPcxBIahn9vNPyXr2xxLdXJUTWMRgE/2HMjvUFZkQ4scaPDfEk2jB9PWU5e9fYz2PnX2ECFuF8Hwca5cISGvIiN2B56H6cDM4R/cuAm1R0/Uv9bfuFHYYcOttviEn/VH57F1JsunPT9YtUntRQhIXUvaE3pUyxD9rvLABpkWam9rnpHKy8hjOwPBz+t2T9KyWbJ8lc5b2KeoU0yYc4VLEYuoAqBPJ5QTP7onAysVkpvfkPr1UOzKff2DBuajDUvUlSt074S2/Bbiy3Bx7xnnc8KDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9T/O20LCeoqT0V8Sru+BR3WG/V9MF3124O9IGMMUYA=;
 b=I+Cn/lIs9wLDHRqMTLMaoVJXDARWGpH42eYo2BmEOQLxyhmiQcG111VIuR8QxMvvfMvTZ08mhISYt5jrFCOVm8do7bbCLWGPp6vYZgk0A0S3ZCZT/zw1u+2Y4n9+lqlpSLRL4wk5Z4jrbQ6P4xu9NHJk0XcQ6yZpL9ocqEnTScDNATI9zDuuqJijMJnB4EAaNqgtVPu9z+77KgDIXtlNZrkv4pOnVAGPy0DzSAZIgTO09kjasgVRYypBW7+HEP8FenSG8mnYUINMv4u+YQketj/spzETkmq7jLnyt6074DKiaDZSKwNkASuOLC/O2qhsVntrRzQmIYm6Wr0Wb+YazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9T/O20LCeoqT0V8Sru+BR3WG/V9MF3124O9IGMMUYA=;
 b=BFxn4XDEDYzpaMG+3TN4knlXFQ+ax/O8X3ZcPgTp7Is/IqsTzhSvg9Yhy+ERC6DSMk4u1AjoHMM5erOtEWFHHp9s/GiXS5UJxoWB4FhuW2HDXleVMoW4KnCVaRe76LBUoqP8ROAvSnhUcW8O31Am/wix50EBQECGXl0aslQrWyAQgwj8tdpScMyH8NR43Fv7e6N464lpBf0eBWA4MU6o390NQ/hsHNzVJ3ytkhYgQE2OLJ0J+nRJt2Fb6TeVcAS+5hWkQb1eVlc+vqeJ68L+N5Zw/fYXuNykewtHYT2U0f57aTqPNtJLubvvmqSAw2yaUnT/QrwAJJlQTwAi9kwLcQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH8PR20MB995515.namprd20.prod.outlook.com
 (2603:10b6:610:2eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:31:59 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:31:59 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v12 08/12] dpll: sit9531x: add support to get and set
 frequency on pins
Thread-Topic: [PATCH net-next v12 08/12] dpll: sit9531x: add support to get
 and set frequency on pins
Thread-Index: AQHdWBx3uzXzPneuTU+peExtFWrEKg==
Date: Fri, 9 Oct 2026 18:31:57 +0000
Message-ID: <20261009183151.78497-9-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
In-Reply-To: <20261009183151.78497-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH8PR20MB995515:EE_
x-ms-office365-filtering-correlation-id: 4ebbe4b1-7a40-4e89-9bc6-08df26339ae8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|260925021311599003|260925021911599003|260925022911599003|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info:
 e9kXFQ9cOp7Yfny6+4/P2HEBVxQvnh7OVB39fkAdZ0OBe/0peoanR2yWM6ER7M3mbLekVLHEuIGJ+cxFTU/YsP86/LTfFa+YmrVt6t+acrKPstSGcGq7VtooDpYI8KR5YD1m4jN9DRKAvojP+8HRxMO7g1VjSPA4aVZoTtrz3pY2Ixkupxmvco3CQz/MxSbE1DnZjL94uoSZG2BZcG5FWm14YiYCF06Ux4ijfB5D3sCy69bNxJDDn67YFF6j8A9cUSchrMgma71wsj8iMbl7dGcEtDxg32lBcOCeJlmKcavHgPP0r4S4DRsFXE5/yIrlk/UxieOpO2LWa1wzzbPNedTBgkaa+wXiohrNU8ERm8/qw7+0PIoJU/ylob7n0rCSb72IZz+Vd2YM9ToaZ7R3VB64ap4JrVI+pvTuzpBp8ubb+DJKTYIMi5b83uR0qSzKgVikleUxAO2XerZoqIaDoDeUKOVAYrpY/J4oDULdhIzMd5LQV/3nSd7cXXbvnKgzdx1BSoq5DPf9DCnpUvehADid+yQEwdKjICiwkOCmDViuGoL05qOmdrnfT7O8t4IZuqQerMfzg0A2OGmmeSi0okfh3a3ARTlz67Qx+OxHUwyVet5zqIgZNYWJN9UtGSHlIhz5G9LfLBt1LsWLf/TAjQ8kJarKnoVtgyD2ZdOf892JH66X+9Q25e1UszX05hBU2AvEjRJeYInnwAnoMKGZHu+c2Gkn4WgdUu6Wj0P3bLQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VctuxB7n4rjPQWhWqQtpk/TYNcFNHcNoAyKmyGl+Xi8q0H2mMAQGyS8byC?=
 =?iso-8859-1?Q?0CKIejLHufVbQTOMCfRlyj9VzKOKBBMlTwMVoeUB00JqL6zbERYHjWCsJF?=
 =?iso-8859-1?Q?A8AQDtKlnc0F1q9oTt9DIbNeKMiZDS4BY/FkGBvEW1ej9vIrj4mmULLuMM?=
 =?iso-8859-1?Q?Da5y2DdXbsQrT1pLS7ZCjXomYx7XgdRwG4cRRD7INP2AQIDiui2nUQHd7j?=
 =?iso-8859-1?Q?OSy53wgkXwZADUzP5ZRhmNyb29md4Gw16RI4EBPto24lZ5eSTdr79J/vKB?=
 =?iso-8859-1?Q?9ARAcJPqwTVsw8wdK6j3gVMCGeYLi/KL1q4nWbyMWQDcXujJ8kVgMufKCv?=
 =?iso-8859-1?Q?ROuDvzIhu08yboUAXvZFoAT8Y/J0Mey/FYY4b82yWVVpI2fLUu6apNQaIM?=
 =?iso-8859-1?Q?YSbA4q+88MeH2XyjDzcL07UZ0VIQt6aeITKwROaKTfG9UHFCOdejRQNxMf?=
 =?iso-8859-1?Q?BqJ8bDCUr/wHoWf/KnVFNr5AviDHlwkvmuyObTeaqKXRwF6GrU0SexElxi?=
 =?iso-8859-1?Q?sTKxU+xGDVX2WQU3dFSM9FzuBkZODXm7VGU5FvuFUXL25gneeq/G6S476C?=
 =?iso-8859-1?Q?RMDhO/5U/TyzFKe2xaUu5vRdBPMmNTZPmtWL8Rg6WqGTCTGrfhwmee82bo?=
 =?iso-8859-1?Q?vN3ppYbhGZbjxD0O1BrJsxhUDV3hqrLOEy7CfAGy1P1ZXIo4bOHpuhvutZ?=
 =?iso-8859-1?Q?Ismkp+JHgistJWXPeN+sG8l5vyBD1HxD0eZMhMvcPsPSYu+Rp5v0mpcQTJ?=
 =?iso-8859-1?Q?HMK3WZHI21h7mHLflcRr9GhzipkyN17IqZ+RTGVSLdPeMvyHUqUZZNkT5J?=
 =?iso-8859-1?Q?sB+waSM9eoiOkUqVBoRANaRWm86paZjPDXyKY7C1CGhwHXpBh7+FrKE61D?=
 =?iso-8859-1?Q?hOrsaMSX5JpA1evhVqu1fvQpsremvv5AG+2Q1JIV9UoClQmWq2IPSKAf/u?=
 =?iso-8859-1?Q?lIuoTkTRuScR9Bi65c6AzNeU9MVyE9sAe/9AokyWoNt4VK18Ui55vhWLb3?=
 =?iso-8859-1?Q?RS9qdPybAATy6PSryAov8xN4fLy4PFBR5BWv4/zxNfHaYncCtceZrZ5Yju?=
 =?iso-8859-1?Q?2Mn/CIiFZxnDfdfRIm3v4wYWbXlNniytpxvAQUgqcVO37SCjXdA1JNg96+?=
 =?iso-8859-1?Q?WBSjxTvqDB5cAtLyXQHS90GToSaamtOlA/kzSFn1f9o0U4tCmPGjN9jkOQ?=
 =?iso-8859-1?Q?/e+WLlTvShsv4Dq3Z2KGZZZJFn3TWh7URYblHO3mazkmB+AXD07mivmcvo?=
 =?iso-8859-1?Q?mjerbTdIY9U4FGDSxb2fR3cT6EIxG42NabqQF01+50blGr0x50yp0M69/e?=
 =?iso-8859-1?Q?AcFLn00qhF+aSukrXXyW2IsY/DehdvZfhPsPcrlGZ4MUYldNrX2aS5F+ba?=
 =?iso-8859-1?Q?Qqts/xPdc8vB/F8T5L5QzNtVtOQ0GEN4+O9u3WX4p68sxpUKQk1eU043ty?=
 =?iso-8859-1?Q?ECM683W82euSFZdJh+zCsCHZygNGsdQuuEkZ8xD/AwkX+XGD+L+FytZo93?=
 =?iso-8859-1?Q?ZYgDKiLZt/BLOjXEYh9GOrQqOzopqHefEd3g34+QSp+myDlNhjvOxmT28r?=
 =?iso-8859-1?Q?oIdah3spVftxBNOm596LV0JZQV9LMj6xEkSrpQitNtG/DgvPV4egBYz+Nw?=
 =?iso-8859-1?Q?q52IZmlPyUr+j+GJZviz3auYAgectbWMQxEFJzCviBd0DW9Df99hCby/xt?=
 =?iso-8859-1?Q?KpH6FAWItI/yd6o5CKAiQLnGjSSb0CInKNs7cC8Ep8OgFyxQPaRHlXSqT+?=
 =?iso-8859-1?Q?fyjTUPbaEywoN653CtFai9jh+xXGb6VyWjaua4USawVS0r?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UmWlil9oq/O4/bb8OASo7+Jrx8xzY+Fex/wobCyqjHkwAnhn0k3/jXzTNcCHNvZVwtIXwyCybuFnYiUCzxfheVI25IZo70tLymEQN/2LbDhfOsg3fm+TtxQ448dVFBy/OzO/bstUkUWi+obEORndsuHBH4tdF9szJIeumFDlxZ+8GPFB0w+1F5A69LqcJCClNDjjay9+ed1+bNiJj+PQEwdjq8MiV41cClBOL1PIS6JPc5pA/KKhALD9kCU4t5hxtLvAeDXMi0Fn2KV4L+bMuKr2RKS6Kf9D6I5pG+bxATLe1yMxfyapNxTK11sc4qFXWxlGJifZEg3EukhfyE0jgw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebbe4b1-7a40-4e89-9bc6-08df26339ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:57.9040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETCKSWTNlMYj8KVXsdsHcrjOjCQ2Qa/nnNMtt2Rzkt9EpPGdoXG75y97V9atmpVCEXCnh2SHmPYb0GzdRxT3RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR20MB995515
X-MDID: 1791570721-KnhYCOErb4lI
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570721;KnhYCOErb4lI;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Both directions in one patch, since they share everything that matters.=0A=
=0A=
An input's frequency is what the board presents, so it is reported from=0A=
the firmware description rather than read back: the chip has no divider on=
=0A=
an input whose rate it merely qualifies.  An input the firmware gives no=0A=
rate for has no frequency attribute at all rather than a zero, because=0A=
the core abandons the whole pin dump on an error from one pin.=0A=
=0A=
An output's frequency is the VCO divided by that output's divider, so it=0A=
is computed from the divider read back from the chip and set by writing=0A=
a new one.  The VCO in turn comes from the feedback divider, which is=0A=
why the crystal rate is needed at probe.  That rate is trusted only=0A=
inside the band the PLL's VCO runs in: below the low band the divider is=0A=
not programmed and the PLL reports no data, and a request against a rate=0A=
outside the band is refused rather than programmed, since a divider=0A=
computed from a rate the output is not at would be reported as success.=0A=
A divider write only takes effect inside the programming state, and that=0A=
state has to be left with the output loops re-locked whatever happened=0A=
in between, so the exit runs even when a write in the middle failed and=0A=
the first error is the one returned.=0A=
=0A=
Programming a divider costs about a hundred milliseconds under the device=
=0A=
lock: a dozen or so register transactions, then the settling time the part=
=0A=
requires after the loop-lock command, which is a property of the hardware=
=0A=
rather than a conservative guess.  The DPLL core holds its own lock across=
=0A=
the whole callback, so a frequency set on this device delays netlink=0A=
traffic for every DPLL in the system for that long.  Splitting the wait=0A=
out would need the ops to complete asynchronously, which the interface=0A=
does not offer; issuing the commit without waiting would let the next=0A=
request program a part that has not settled.  A rate change is a=0A=
configuration action, not something a running system does per packet, so=0A=
the cost is paid where it is visible rather than hidden behind a=0A=
completion the caller cannot wait for.=0A=
=0A=
The phase flush that follows a divider write realigns every output fed by=
=0A=
that PLL, not only the one that changed.  The flush is a per-PLL function=
=0A=
in the device and there is no per-output equivalent, so an output whose=0A=
rate is set while its siblings are running will step their phase too.=0A=
=0A=
The flush's own error paths restore what they changed: a failed source=0A=
select puts the original source back, a sibling is marked parked before=0A=
it is cleared so a failure cannot leave it unparked, and a failed arm=0A=
disarms rather than unparks.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 805 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |   7 +=0A=
 drivers/dpll/sit9531x/dpll.c | 120 ++++++=0A=
 drivers/dpll/sit9531x/prop.c |  29 +-=0A=
 drivers/dpll/sit9531x/regs.h |  21 +=0A=
 5 files changed, 978 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 79520640dfc8..ea15830b0efa 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -488,6 +488,140 @@ static int sit9531x_output_forced_hiz(struct sit9531x=
_dev *sitdev,=0A=
 					muted);=0A=
 }=0A=
 =0A=
+/* Attempts to re-lock the output loops before reporting them open. */=0A=
+#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
+=0A=
+/*=0A=
+ * sit9531x_prg_abort - leave the programming state without committing=0A=
+ *=0A=
+ * Entering the state is two writes, and the second can fail with the debu=
g=0A=
+ * block already unlocked and the part possibly already in PRG_CMD.  There=
=0A=
+ * is nothing to commit in that case, but the loops still have to be close=
d=0A=
+ * and the debug key put back, which is otherwise only done by=0A=
+ * sit9531x_prg_commit().=0A=
+ */=0A=
+static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 attempt;=0A=
+	int rc =3D -EIO;=0A=
+=0A=
+	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+				       SIT9531X_LOOP_LOCK);=0A=
+		if (!rc)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev,=0A=
+			"output loops left unlocked after a failed entry: %d\n",=0A=
+			rc);=0A=
+=0A=
+	sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			  SIT9531X_DEBUG_LOCK_VAL);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Enter the output-system programming state: unlock the debug=0A=
+ * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
+ * writes that reconfigure the output system only take effect when=0A=
+ * they are made inside this state.=0A=
+ */=0A=
+static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_PRG_CMD_STATE);=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The debug block is unlocked at this point, and a transfer=0A=
+		 * that reported an error may still have reached the part --=0A=
+		 * which would leave the device in PRG_CMD with its output=0A=
+		 * loops open.  Callers skip the commit when the entry=0A=
+		 * fails, so close both here.=0A=
+		 */=0A=
+		sit9531x_prg_abort(sitdev);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a programming sequence started by sit9531x_prg_enter():=0A=
+ * update the NVM shadow and re-lock the loops.  The sleep gives the=0A=
+ * hardware its required settling time after the loop-lock command;=0A=
+ * it is intentional despite the caller holding multiop_lock, as the=0A=
+ * whole NVM + lock sequence must be atomic.=0A=
+ */=0A=
+static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc, rc2 =3D 0, rc3;=0A=
+	u8 attempt;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_UPDATE_NVM);=0A=
+=0A=
+	/*=0A=
+	 * Issue the loop lock even if the update failed: every caller=0A=
+	 * commits whatever happened after the entry so that the chip never=0A=
+	 * stays in the PRG_CMD state with its loops open, and returning=0A=
+	 * early here would defeat that.=0A=
+	 *=0A=
+	 * Re-lock the loops.  Leaving them open is worse than any other=0A=
+	 * failure this function can report, and nothing else closes them,=0A=
+	 * so retry, as the priority commit retries the release of its=0A=
+	 * forced holdover.=0A=
+	 */=0A=
+	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
+		rc2 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+					SIT9531X_LOOP_LOCK);=0A=
+		if (!rc2)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (rc2)=0A=
+		dev_err(sitdev->dev,=0A=
+			"output loops left unlocked after programming: %d\n",=0A=
+			rc2);=0A=
+=0A=
+	msleep(100);=0A=
+=0A=
+	/*=0A=
+	 * Put the output-system debug block back the way the device powers=0A=
+	 * up.  Its key register unlocks every debug register while it holds=0A=
+	 * the unlock value, and each programming sequence writes that value=0A=
+	 * itself, so nothing needs it left unlocked in between.=0A=
+	 */=0A=
+	rc3 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+				SIT9531X_DEBUG_LOCK_VAL);=0A=
+=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (rc2)=0A=
+		return rc2;=0A=
+=0A=
+	/*=0A=
+	 * The programming is committed and the loops are locked by now;=0A=
+	 * only the debug key stayed open, and the next sequence writes it=0A=
+	 * again.  Failing here would make the caller skip what follows a=0A=
+	 * change that did take effect -- and the core drops an identical=0A=
+	 * retry, so it would never run.=0A=
+	 */=0A=
+	if (rc3)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "output debug block left unlocked after programming: %d\n",=0A=
+			 rc3);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -1329,6 +1463,11 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sit=
dev, u8 pll_idx,=0A=
 					 chan->prio_mask | BIT(input_idx));=0A=
 }=0A=
 =0A=
+/* Per-slot DIVO base register offsets (6 slots per page) */=0A=
+static const u8 clkout_odr_divn_base[] =3D {=0A=
+	0x14, 0x24, 0x34, 0x44, 0x54, 0x64=0A=
+};=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -1342,6 +1481,672 @@ int sit9531x_input_prio_add(struct sit9531x_dev *si=
tdev, u8 pll_idx,=0A=
 /* The output divider is a 34-bit field */=0A=
 #define SIT9531X_DIVO_MAX			GENMASK_ULL(33, 0)=0A=
 =0A=
+/*=0A=
+ * sit9531x_is_xo_doubler_enabled - check if Fref doubler is active=0A=
+ *=0A=
+ * Register 0x2D bit 7 is active-low: 0 =3D doubler enabled, 1 =3D disable=
d.=0A=
+ *=0A=
+ * Return: 1 if enabled, 0 if disabled, <0 on error=0A=
+ */=0A=
+static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_XO2_GENERIC, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * DIVN as a fixed-point value: int_part plus fracn/fracd, carried with=0A=
+ * SIT9531X_DIVN_SCALE steps per unit.  The scale keeps a whole DIVN=0A=
+ * well inside s64 while resolving far below the parts-per-trillion the=0A=
+ * frequency offset is reported in.=0A=
+ */=0A=
+static s64 sit9531x_divn_fixed(u32 int_part, s64 fracn, u64 fracd)=0A=
+{=0A=
+	s64 whole =3D (s64)int_part * SIT9531X_DIVN_SCALE;=0A=
+	u64 frac;=0A=
+=0A=
+	if (!fracd)=0A=
+		return whole;=0A=
+=0A=
+	frac =3D mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd);=0A=
+=0A=
+	return fracn < 0 ? whole - (s64)frac : whole + (s64)frac;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_divn_static - read the configured DIVN of a PLL=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @divn:	result, fixed point as per sit9531x_divn_fixed()=0A=
+ *=0A=
+ * Reads PLL page regs 0x30 (integer part), 0x32-0x35 (numerator) and=0A=
+ * 0x38-0x3B (denominator).  The numerator is a two's complement 32-bit=0A=
+ * value, so DIVN can sit below the integer part, and the denominator=0A=
+ * register holds the divisor minus one.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_divn_static(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				s64 *divn)=0A=
+{=0A=
+	u32 int_part, fracn_raw =3D 0, fracd_raw =3D 0;=0A=
+	u64 fracd;=0A=
+	s64 fracn;=0A=
+	int rc, i;=0A=
+	u8 v;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DIVN_INT, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	int_part =3D v;=0A=
+=0A=
+	for (i =3D 3; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DIVN_NUM + i, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		fracn_raw =3D (fracn_raw << 8) | v;=0A=
+	}=0A=
+=0A=
+	for (i =3D 3; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DIVN_DEN + i, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		fracd_raw =3D (fracd_raw << 8) | v;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * NUM/DEN is the fractional part of DIVN, so |NUM| is below DEN by=0A=
+	 * construction.  A pair that says otherwise did not come from a=0A=
+	 * programmed divider, and handing it on would divide by a=0A=
+	 * denominator small enough for the quotient to leave u64 -- which=0A=
+	 * is a divide-error exception on x86, not a value a caller could=0A=
+	 * reject.=0A=
+	 */=0A=
+	fracn =3D (s32)fracn_raw;=0A=
+	fracd =3D (u64)fracd_raw + 1;=0A=
+	if ((u64)abs(fracn) >=3D fracd)=0A=
+		return -ENODATA;=0A=
+=0A=
+	*divn =3D sit9531x_divn_fixed(int_part, fracn, fracd);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* PLLB and PLLD run their VCO in the high band, PLLA and PLLC in the low.=
 */=0A=
+static bool sit9531x_fvco_in_band(u8 pll_idx, u64 fvco)=0A=
+{=0A=
+	if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3)=0A=
+		return fvco >=3D SIT9531X_FVCO_HIGHBAND_MIN &&=0A=
+		       fvco <=3D SIT9531X_FVCO_HIGHBAND_MAX;=0A=
+	return fvco >=3D SIT9531X_FVCO_LOWBAND_MIN &&=0A=
+	       fvco <=3D SIT9531X_FVCO_LOWBAND_MAX;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
+ *=0A=
+ * Fvco =3D Fref * DIVN, where DIVN comes from sit9531x_divn_static() and=
=0A=
+ * Fref =3D xtal_freq << doubler.  DIVN is the steady-state Fvco/Fref=0A=
+ * target programmed by the NVM blob and is authoritative in both=0A=
+ * free-run and sync modes.=0A=
+ *=0A=
+ * Return: 0 with *fvco set on success, -ENODATA when DIVN is not=0A=
+ * programmed (dormant PLL), or the register access error.  A bus=0A=
+ * failure is never folded into the -ENODATA case, so callers can fail=0A=
+ * a request instead of acting on a guessed rate.=0A=
+ */=0A=
+static int sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			     u64 *fvco)=0A=
+{=0A=
+	int doubler, rc;=0A=
+	u64 fref;=0A=
+	s64 divn;=0A=
+=0A=
+	rc =3D sit9531x_divn_static(sitdev, pll_idx, &divn);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (divn <=3D 0)=0A=
+		return -ENODATA;=0A=
+=0A=
+	doubler =3D sit9531x_is_xo_doubler_enabled(sitdev);=0A=
+	if (doubler < 0)=0A=
+		return doubler;=0A=
+=0A=
+	fref =3D (u64)sitdev->xtal_freq << doubler;=0A=
+=0A=
+	/*=0A=
+	 * Round to the nearest hertz: DIVN is carried in fixed point, so a=0A=
+	 * fraction such as 1/6 is already floored once, and flooring the=0A=
+	 * product again reads an exact 5 GHz VCO as 4999999999 Hz -- which=0A=
+	 * then refuses every rate the VCO divides exactly.=0A=
+	 */=0A=
+	*fvco =3D mul_u64_u64_div_u64(2 * fref, (u64)divn, SIT9531X_DIVN_SCALE);=
=0A=
+	*fvco =3D (*fvco + 1) / 2;=0A=
+=0A=
+	/*=0A=
+	 * No VCO of this family runs below the low band, so a product under=0A=
+	 * it is not a rate: a DIVN of a cycle or less, say, which the check=0A=
+	 * above lets through and which a profile that never programmed the=0A=
+	 * divider can leave behind.  Callers scale 34-bit register fields by=0A=
+	 * 1e12 / Fvco or more, and for a rate far enough below the band that=0A=
+	 * quotient leaves u64 -- a divide-error exception on x86, not a=0A=
+	 * value they could reject.  Report the unprogrammed divider instead.=0A=
+	 */=0A=
+	if (*fvco < SIT9531X_FVCO_LOWBAND_MIN)=0A=
+		return -ENODATA;=0A=
+=0A=
+	/*=0A=
+	 * A rate outside the band the PLL's VCO runs in usually means=0A=
+	 * Fref * DIVN is not what this PLL runs at -- a PLL fed from another=0A=
+	 * PLL rather than from the XO, for one.  The rate derived from the=0A=
+	 * registers is still the only estimate there is, so a read reports=0A=
+	 * what it derives; a set refuses to program a divider against it=0A=
+	 * (sit9531x_output_divo_calc()), since substituting the band edge=0A=
+	 * would program against a rate nothing supports and report the=0A=
+	 * result as exact.  Say so once per PLL.=0A=
+	 */=0A=
+	if (!sit9531x_fvco_in_band(pll_idx, *fvco) &&=0A=
+	    !(sitdev->fvco_band_warned & BIT(pll_idx))) {=0A=
+		sitdev->fvco_band_warned |=3D BIT(pll_idx);=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c: Fref * DIVN =3D %llu Hz is outside its VCO band\n",=0A=
+			 'A' + pll_idx, *fvco);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* Latch a change to a PLL page with a small update. */=0A=
+static int sit9531x_pll_small_update(struct sit9531x_dev *sitdev, u8 pll_i=
dx)=0A=
+{=0A=
+	return sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				     SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				     SIT9531X_SMALL_UPDATE_CMD);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_phase_flush - flush the output phase of a PLL=0A=
+ *=0A=
+ * Fires the chip's on-demand phase-flush (PHFL) so every output divider=
=0A=
+ * of @pll_idx restarts aligned to the PLL phase.  Without it a rewritten=
=0A=
+ * DIVO keeps counting from an arbitrary point and the output edge lands=
=0A=
+ * with a persistent offset against the tracked reference (only a power=0A=
+ * cycle realigned it).=0A=
+ *=0A=
+ * The sequence mirrors the documented procedure: arm the on-demand PHFL a=
nd=0A=
+ * latch it with the PLL-page small-change update, then select the=0A=
+ * in-register phase trigger on Page 0 and pulse it.  The Page 0 trigger=
=0A=
+ * register is touched read-modify-write so the unrelated OEb bits are=0A=
+ * preserved.=0A=
+ *=0A=
+ * A PLL the loaded configuration builds without the phase-flush feature=
=0A=
+ * (PLL page 0x47 bit 7 clear) has nothing to fire; it is restarted=0A=
+ * instead, which restarts its output dividers from the PLL phase.  That=
=0A=
+ * is what SiTime's Dely_program_output.py does for such a PLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll=
_idx)=0A=
+{=0A=
+	u8 ctrl, orig, phfl, armed_mask =3D 0, parked =3D 0, i;=0A=
+	int rc, ret;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_CONFIG47,=
=0A=
+				  &phfl);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (!(phfl & SIT9531X_PLL_CONFIG47_PHFL_EN))=0A=
+		return sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					     SIT9531X_PLL_REG_DIRECTIVES,=0A=
+					     SIT9531X_PLL_DIRECTIVE_RESTART);=0A=
+=0A=
+	/*=0A=
+	 * The trigger below is chip-global: every PLL whose on-demand flush=0A=
+	 * is armed answers it.  Note which ones the loaded profile arms --=0A=
+	 * this one so its setting can be put back, the others so they can=0A=
+	 * be parked for the pulse and do not realign outputs nobody asked=0A=
+	 * to move.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, i, SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					  &phfl);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (phfl & SIT9531X_PLL_PHFL_ON_DEMAND_EN)=0A=
+			armed_mask |=3D BIT(i);=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		if (i =3D=3D pll_idx || !(armed_mask & BIT(i)))=0A=
+			continue;=0A=
+		/*=0A=
+		 * A clear whose write reported an error may still have=0A=
+		 * landed, latched or not: put it back either way.=0A=
+		 */=0A=
+		parked |=3D BIT(i);=0A=
+		rc =3D sit9531x_update_pll_u8(sitdev, i,=0A=
+					    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					    SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);=0A=
+		if (rc)=0A=
+			goto unpark;=0A=
+		rc =3D sit9531x_pll_small_update(sitdev, i);=0A=
+		if (rc)=0A=
+			goto unpark;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Arm the on-demand phase-flush on the PLL page.  An arm whose write=0A=
+	 * failed may have landed too, so it goes through the disarm below.=0A=
+	 */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Latch it with the PLL small-change update.  Written whole, like=0A=
+	 * every other issue of this directive: the register is a command=0A=
+	 * register, and a read-modify-write skips the write entirely when=0A=
+	 * the bit still reads back set from the previous command.=0A=
+	 */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Select the in-register phase trigger, preserving the OEb bits.=0A=
+	 * Remember the original register value (with the trigger de-asserted)=0A=
+	 * so the trigger-source select can be restored once the pulse has=0A=
+	 * fired.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	orig =3D ctrl & ~SIT9531X_DIVO_PHASE_TRIG;=0A=
+	ctrl =3D orig | SIT9531X_DIVO_PHASE_SEL_REG;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);=0A=
+	if (rc)=0A=
+		goto restore;=0A=
+=0A=
+	/*=0A=
+	 * Pulse the phase trigger.  No explicit delay is needed between the=0A=
+	 * set and clear writes: each I2C transaction takes far longer than=0A=
+	 * any minimum pulse width.=0A=
+	 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,=0A=
+			       ctrl | SIT9531X_DIVO_PHASE_TRIG);=0A=
+=0A=
+restore:=0A=
+	/*=0A=
+	 * Restore the original trigger-source select.  The pulse above has=0A=
+	 * already latched the flush, so a one-shot flush must not leave the=0A=
+	 * phase trigger permanently pinned to the in-register source.  This=0A=
+	 * runs even when the pulse write failed, and when the select write=0A=
+	 * itself reported a failure, since the transfer may have reached=0A=
+	 * the part all the same; otherwise a failed flush would keep a=0A=
+	 * hardware trigger source hijacked.  The restore error is only=0A=
+	 * surfaced when it would not mask the earlier failure.=0A=
+	 */=0A=
+	ret =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+disarm:=0A=
+	/*=0A=
+	 * Put the on-demand flush enable back as the profile had it.  One the=0A=
+	 * profile left clear must not stay armed: a later assertion of the=0A=
+	 * restored trigger source would re-flush every output divider of this=0A=
+	 * PLL.  One the profile armed -- a board realigning from a GPIO, say=0A=
+	 * -- must not be switched off by an unrelated rate change.=0A=
+	 */=0A=
+	if (!(armed_mask & BIT(pll_idx))) {=0A=
+		ret =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					     SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);=0A=
+		if (!ret)=0A=
+			ret =3D sit9531x_pll_small_update(sitdev, pll_idx);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+unpark:=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		if (!(parked & BIT(i)))=0A=
+			continue;=0A=
+		ret =3D sit9531x_update_pll_u8(sitdev, i,=0A=
+					     SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+		if (!ret)=0A=
+			ret =3D sit9531x_pll_small_update(sitdev, i);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_divo_calc - work out an output's divider and its VCO=0A=
+ *=0A=
+ * Separated from the write so a caller that programs more than the=0A=
+ * divider in one sequence can compute the value before it enters the=0A=
+ * programming state.=0A=
+ */=0A=
+static int sit9531x_output_divo_calc(struct sit9531x_dev *sitdev, u8 out_i=
dx,=0A=
+				     u8 pll_idx, u64 frequency, u64 *fvco_out,=0A=
+				     u64 *divo_out)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo;=0A=
+	int rc;=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs || pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (!frequency)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * The core validates the request against the supported ranges with=0A=
+	 * the value narrowed to u32 but hands the full u64 down, so a value=0A=
+	 * like U32_MAX + 1 Hz validates as 1 Hz.  Reject anything that does=0A=
+	 * not fit the narrowed width the validation actually covered.=0A=
+	 */=0A=
+	if (frequency > U32_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * sit9531x_get_fvco() returns the register-derived rate, so a=0A=
+	 * frequency get and a frequency set divide the same number.  A VCO=0A=
+	 * that cannot be read fails the request: programming a divider from a=0A=
+	 * guessed rate would put the output far from what was asked for=0A=
+	 * while reporting success.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	/*=0A=
+	 * Fref * DIVN outside the VCO band is not what the PLL runs at, and=0A=
+	 * sit9531x_get_fvco() has said so.  A divider computed against it=0A=
+	 * would put the output at some other rate while the exactness check=0A=
+	 * below passes and the read-back, dividing the same number, confirms=0A=
+	 * the request.  Refuse the set instead.=0A=
+	 */=0A=
+	if (!sit9531x_fvco_in_band(pll_idx, fvco)) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"out%u: PLL%c Fvco %llu Hz is outside its VCO band, rate not settable\n=
",=0A=
+			out_idx, 'A' + pll_idx, fvco);=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Round to nearest rather than down: flooring picks the worse of the=0A=
+	 * two adjacent dividers whenever the remainder is above half the=0A=
+	 * request.=0A=
+	 */=0A=
+	divo =3D div64_u64(fvco + frequency / 2, frequency);=0A=
+	if (!divo)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* DIVO is a 34-bit field; refuse a wider divider rather than truncate it=
. */=0A=
+	if (divo > SIT9531X_DIVO_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * The output divider is an integer divider of the VCO, so the only=0A=
+	 * rates the part can make are Fvco/N.  An output pin that lists no=0A=
+	 * supported frequencies advertises a continuous range, because the=0A=
+	 * divisors cannot be enumerated ahead of a known Fvco, so a request=0A=
+	 * for a rate between two of them arrives here.  Refuse it: running=0A=
+	 * the output at the nearest divider instead and reporting success=0A=
+	 * would leave the pin several percent off what was asked for with=0A=
+	 * nothing saying so.=0A=
+	 */=0A=
+	if (div64_u64(fvco, divo) !=3D frequency) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"out%u: %llu Hz is not Fvco/N (Fvco=3D%llu, nearest %llu Hz)\n",=0A=
+			out_idx, frequency, fvco, div64_u64(fvco, divo));=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	dev_dbg(sitdev->dev,=0A=
+		"out%u: Fvco=3D%llu freq=3D%llu DIVO=3D%llu (effective %llu Hz)\n",=0A=
+		out_idx, fvco, frequency, divo, div64_u64(fvco, divo));=0A=
+=0A=
+	*fvco_out =3D fvco;=0A=
+	*divo_out =3D divo;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_divo_write - write the five DIVO bytes of an output=0A=
+ *=0A=
+ * The caller must already be in the programming state.  Bytes written=0A=
+ * before a failure are put back, so the output keeps the divider it had=
=0A=
+ * rather than a mixture of the two.=0A=
+ */=0A=
+static int sit9531x_output_divo_write(struct sit9531x_dev *sitdev, u8 out_=
idx,=0A=
+				      u64 divo)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, divo_bytes[5], old_bytes[5], msb_old;=0A=
+	int rc, j, rb_rc;=0A=
+	u8 written =3D 0;=0A=
+=0A=
+	/* Map output index to physical slot */=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+=0A=
+	/* Determine page and per-page slot register */=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	divo_bytes[0] =3D (divo >>  0) & 0xFF;=0A=
+	divo_bytes[1] =3D (divo >>  8) & 0xFF;=0A=
+	divo_bytes[2] =3D (divo >> 16) & 0xFF;=0A=
+	divo_bytes[3] =3D (divo >> 24) & 0xFF;=0A=
+	divo_bytes[4] =3D (divo >> 32) & 0x03;  /* only bits [1:0] */=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j),=0A=
+				      &old_bytes[j]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	msb_old =3D old_bytes[4];=0A=
+	divo_bytes[4] |=3D msb_old & 0xFC;=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base_reg - j),=0A=
+				       divo_bytes[j]);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+		written++;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+=0A=
+rollback:=0A=
+	/*=0A=
+	 * The byte whose write reported the error may still have reached=0A=
+	 * the part, so it is put back along with the ones that did.=0A=
+	 */=0A=
+	for (j =3D 0; j <=3D written && j < 5; j++) {=0A=
+		rb_rc =3D sit9531x_write_u8(sitdev,=0A=
+					  SIT9531X_REG(page, base_reg - j),=0A=
+					  old_bytes[j]);=0A=
+		if (rb_rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"out%u: DIVO rollback failed (%d), the divider is part old and part ne=
w\n",=0A=
+				out_idx, rb_rc);=0A=
+			if (!rc)=0A=
+				rc =3D rb_rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read an output's divider back from the device.=0A=
+ *=0A=
+ * Return: 0 with *divo set, -ENODATA when the divider is not programmed,=
=0A=
+ * or the register access error=0A=
+ */=0A=
+static int sit9531x_output_divo_read(struct sit9531x_dev *sitdev, u8 out_i=
dx,=0A=
+				     u64 *divo)=0A=
+{=0A=
+	u8 slot, page, base_reg, v;=0A=
+	int rc, j;=0A=
+=0A=
+	slot =3D sitdev->info->clkout_map[out_idx];=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	*divo =3D 0;=0A=
+	for (j =3D 4; j >=3D 0; j--) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j), &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (j =3D=3D 4)=0A=
+			v &=3D 0x03;=0A=
+		*divo =3D (*divo << 8) | v;=0A=
+	}=0A=
+=0A=
+	return *divo ? 0 : -ENODATA;=0A=
+}=0A=
+=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency)=0A=
+{=0A=
+	u64 fvco, divo;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_divo_calc(sitdev, out_idx, pll_idx, frequency,=0A=
+				       &fvco, &divo);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_divo_write(sitdev, out_idx, divo);=0A=
+	/*=0A=
+	 * Step 4: NVM update + loop lock.  Always run prg_commit() so the chip=
=0A=
+	 * leaves the PRG_CMD state with the output loops re-locked, even when a=
=0A=
+	 * write above failed; keep the first error to return.  It also carries=
=0A=
+	 * the required post-lock settling sleep.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Step 5: flush the PLL's output phase so the new DIVO starts=0A=
+	 * aligned instead of keeping the arbitrary phase the divider=0A=
+	 * happened to be at.=0A=
+	 */=0A=
+	/*=0A=
+	 * The divider is committed by this point, so the part is already=0A=
+	 * running at the new rate.  A flush that fails leaves the output=0A=
+	 * divider on its old phase, which is a realignment that did not=0A=
+	 * happen rather than a rate that did not change -- and reporting a=0A=
+	 * failure would be doubly wrong, because the core asks for the=0A=
+	 * current rate first and would drop an identical retry.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "out%u: rate changed but the divider phase was not realigned (%d)\n",=
=0A=
+			 out_idx, rc);=0A=
+		rc =3D 0;=0A=
+	}=0A=
+=0A=
+	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_freq_get - read output clock frequency from hardware=0A=
+ * @out_idx:	output index (0-N for this chip variant)=0A=
+ * @frequency:	output frequency in Hz=0A=
+ *=0A=
+ * Reads the 34-bit DIVO divider back from the output system registers=0A=
+ * and computes the live output frequency as Fvco / DIVO.  This stays=0A=
+ * correct even when the divider was reprogrammed behind the driver's=0A=
+ * back (e.g. by a direct-I2C userspace tool), where the cached value=0A=
+ * would be stale.=0A=
+ *=0A=
+ * The cached output state is refreshed with the computed value.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA when the output divider or VCO rate=0A=
+ *	   is not resolvable, <0 on register access error.  -ENODATA and not=0A=
+ *	   -ENODEV, which the I2C layer returns for an adapter that is gone=0A=
+ *	   and which must not read as "no rate to report".=0A=
+ */=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo;=0A=
+	u8 pll_idx;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS || !sitdev->out[out_idx].routed)=0A=
+		return -ENODATA;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_divo_read(sitdev, out_idx, &divo);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	*frequency =3D div64_u64(fvco, divo);=0A=
+	sitdev->out[out_idx].freq =3D *frequency;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Phase adjust (PRG_RST_DELAY register-based).=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index fa1197bfc81c..006a7fee76ab 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -192,6 +192,8 @@ struct sit9531x_chan {=0A=
  *			synchronization (INTSYNC), or -1 when disabled=0A=
  * @irq_ack_fails:	consecutive failures to acknowledge the=0A=
  *			notification latches from the interrupt handler=0A=
+ * @fvco_band_warned:	bit per PLL whose Fref * DIVN has been reported as=
=0A=
+ *			outside its VCO band; written under @multiop_lock=0A=
  */=0A=
 struct sit9531x_dev {=0A=
 	struct device			*dev;=0A=
@@ -203,6 +205,7 @@ struct sit9531x_dev {=0A=
 =0A=
 	/* Hardware state */=0A=
 	u8			irq_ack_fails;=0A=
+	u8			fvco_band_warned;=0A=
 	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
 	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
 	struct sit9531x_chan	chan[SIT9531X_NUM_PLLS];=0A=
@@ -265,6 +268,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
 =0A=
 /* ---- Output frequency ---- */=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency);=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency);=0A=
 =0A=
 /* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 0400444d91a5..aa021b374c45 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -411,6 +411,32 @@ sit9531x_dpll_input_pin_direction_get(const struct dpl=
l_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_frequency_get - read input pin frequency=0A=
+ *=0A=
+ * Returns the rate the board wired to the input, the first entry of its=
=0A=
+ * supported-frequencies-hz; an input has no frequency setter.  An input=
=0A=
+ * the firmware lists no rate for is registered without this callback=0A=
+ * (sit9531x_dpll_pin_ops_get()), so its attribute is absent rather than=
=0A=
+ * zero.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,=0A=
+				      void *pin_priv,=0A=
+				      const struct dpll_device *dpll,=0A=
+				      void *dpll_priv, u64 *frequency,=0A=
+				      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	const struct sit9531x_ref *ref;=0A=
+=0A=
+	ref =3D sit9531x_ref_state_get(sitdpll->dev, dpin->id);=0A=
+	*frequency =3D ref->freq;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
  *=0A=
@@ -644,6 +670,23 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin=
 *pin, void *pin_priv,=0A=
 }=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * The same without frequency_get, for an input whose firmware node lists=
=0A=
+ * no supported-frequencies-hz (or that has no node at all): there is no=
=0A=
+ * rate to report, and the core fails a whole pin dump on an error from=0A=
+ * any one callback, so the attribute is left out rather than reported=0A=
+ * as 0 Hz.=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_norate_ops =3D {=
=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
@@ -704,6 +747,7 @@ sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpl=
l_pin *pin,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
 };=0A=
 =0A=
@@ -719,8 +763,78 @@ sit9531x_dpll_output_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_get - read output pin frequency=0A=
+ *=0A=
+ * Reads the DIVO divider back from the chip and computes the live=0A=
+ * frequency as Fvco / DIVO.  Falls back to the cached value only when=0A=
+ * the output is not resolvable through the divider chain (e.g. not=0A=
+ * mapped to a PLL), so transport/register errors still surface.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_frequency_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv, u64 *frequency,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_freq_get(sitdev, dpin->id, frequency);=0A=
+	if (rc =3D=3D -ENODATA)=0A=
+		*frequency =3D sit9531x_out_state_get(sitdev, dpin->id)->freq;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc =3D=3D -ENODATA ? 0 : rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_set - set output pin frequency=0A=
+ *=0A=
+ * computes DIVO =3D Fvco / frequency and writes the=0A=
+ * 34-bit output divider to the output system registers via=0A=
+ * sit9531x_output_freq_set().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv, u64 frequency,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 actual_pll;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Read the PLL that drives this output from its OUT_MAP state=0A=
+	 * (populated by out_state_fetch from the chip's OUT_MAP registers).=0A=
+	 * That is the index the output register programming below is keyed=0A=
+	 * by; the output is registered under the DPLL matching this PLL.=0A=
+	 */=0A=
+	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,=0A=
+				      frequency);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack, "Output frequency set failed");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
+	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
@@ -730,6 +844,12 @@ sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_p=
in *pin)=0A=
 		return &sit9531x_dpll_output_pin_ops;=0A=
 	if (sit9531x_dpll_is_xo_pin(pin))=0A=
 		return &sit9531x_dpll_xo_pin_ops;=0A=
+	/*=0A=
+	 * Seeded from the firmware node before the pin is registered and=0A=
+	 * never written afterwards, so register and unregister agree.=0A=
+	 */=0A=
+	if (!sit9531x_ref_state_get(pin->dpll->dev, pin->id)->freq)=0A=
+		return &sit9531x_dpll_input_pin_norate_ops;=0A=
 	return &sit9531x_dpll_input_pin_ops;=0A=
 }=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 934db566c002..8270b8ee91be 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -295,15 +295,36 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=
=0A=
 	}=0A=
 =0A=
 	/*=0A=
-	 * Seed an input's runtime ref->freq with the first DT-listed=0A=
-	 * supported frequency: for an input the board lists the rate that is=0A=
-	 * physically wired to it first.  An output's current rate is what its=0A=
-	 * divider produces, not an entry of the list it may be set to.=0A=
+	 * Seed the runtime ref->freq with the first DT-listed supported=0A=
+	 * frequency: an input's rate is a board fact the device cannot be=0A=
+	 * asked for, so firmware is the only source.  An output is left to=0A=
+	 * the read-back below, which knows what the divider is actually=0A=
+	 * doing.=0A=
 	 */=0A=
 	if (num_freqs > 0 && dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
 	    index !=3D SIT9531X_MAX_INPUTS)=0A=
 		curr_freq =3D freqs[0];=0A=
 =0A=
+	/*=0A=
+	 * An output's current rate is the one its divider produces, so read=0A=
+	 * it rather than assume the first entry of a list of the rates the=0A=
+	 * board supports is the one in force.  A rate taken from firmware=0A=
+	 * that the part is not running would be reported as current and,=0A=
+	 * worse, used as the output period the phase adjust quantizes=0A=
+	 * against.  An output the configuration does not route has no rate=0A=
+	 * to read, which is not an error.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index < sitdev->info->num_outputs) {=0A=
+		u64 hw_freq;=0A=
+=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_freq_get(sitdev, index, &hw_freq);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (!rc)=0A=
+			curr_freq =3D hw_freq;=0A=
+	}=0A=
+=0A=
 skip_fwnode_props:=0A=
 	/* Neither INTSYNC pin carries a frequency attribute */=0A=
 	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index fd1068982cd7..eea38150b50f 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -200,6 +200,7 @@=0A=
 /* Debug register (same offset, per-page) */=0A=
 #define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
+#define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
@@ -214,6 +215,18 @@=0A=
 /* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */=0A=
 #define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
 =0A=
+/* On-demand phase-flush enable (PLL page reg 0x3D bit 7) */=0A=
+#define SIT9531X_PLL_REG_PHFL_CTRL	0x3D=0A=
+#define SIT9531X_PLL_PHFL_ON_DEMAND_EN	BIT(7)=0A=
+=0A=
+/* Whether the PLL has the phase-flush feature (PLL page reg 0x47 bit 7) *=
/=0A=
+#define SIT9531X_PLL_REG_CONFIG47	0x47=0A=
+#define SIT9531X_PLL_CONFIG47_PHFL_EN	BIT(7)=0A=
+=0A=
+/* Directives_GENERIC_PLL: the restart bit restarts the PLL, self-clearing=
 */=0A=
+#define SIT9531X_PLL_REG_DIRECTIVES	0x05=0A=
+#define SIT9531X_PLL_DIRECTIVE_RESTART	BIT(0)=0A=
+=0A=
 /*=0A=
  * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +=0A=
  * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must =
not be=0A=
@@ -229,6 +242,14 @@=0A=
 #define SIT9531X_PLL_REG_OUT_MAP_LO		0x28=0A=
 #define SIT9531X_PLL_REG_STATUS		0x31=0A=
 =0A=
+/* DIVN registers (free-run divider readback) */=0A=
+#define SIT9531X_PLL_REG_DIVN_INT		0x30=0A=
+#define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
+#define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
+=0A=
+/* DIVN is carried as fixed point, in steps of 1e-12 of a whole divider */=
=0A=
+#define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
+=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
