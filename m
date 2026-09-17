Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1906398911;
	Thu, 17 Sep 2026 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613195; cv=fail; b=UvdjAJHT4HCgHchXuk+LMcf+0E612NWxQEqThXMOOExZBAiTDv/5g7MqueQ9N7hta8L8AlCJR881uo/H12F4d89gQASq5Fng+xaLbk0xCOG0TUyyw4OP4B2LMXtYo7kpciZUkPbOLEaGzM2t5O5IdmLWJf/jxZRKPKrNkr4nsXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613195; c=relaxed/simple;
	bh=s3gU5ZFRqJ0AfPQb8DuWHFOqyvcK2qNB3Gt+rC/Ocd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9ZoKFRR26oipdqG26usOdXs++vxl30J/8UUugSFXMrHkugEivD5YDHBsC8AKXmlVbebtbwmG3VcpOvP64tuVZIWdIDnAGjllVGfVDi9h2JqtgMfXL5H9VGI1ncquBcfQbStbhWjRUSHSZGvBJI3Rdo6Wge3UZdjqFOJRXoeOCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=fy5W7/Rp; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="fy5W7/Rp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFH5YyDn8zP6oMLH9dcrjnGHsgmDDe5ZLladsth5HbNO0cVg80M2luP4Z0gTvbrr5PQTg91mHYnOkDdxd4toNAIvyM/JViF9j3oJ180EfGzauzDXEsuCTUWz5Se/P3Syfytsf6xXXBTJtUTvgOdq7Fw/8IAnGLacz2v3EXD9yc1KZaUhWWW3XisuMDuCcFbzeRfrk0jKsvijcb2dDSNokzBQPovzu2plKsEJIrJ4b9k61or42v7vKhHHIxbLHOSpR2ixQhpPVcsRotG8mqONKGTSd2RgAuCX7bsa6oRJLYCZ5aDeo+UM5U3EHIr2wzPNcOxn7JErYmwf5jl0nMaVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3gU5ZFRqJ0AfPQb8DuWHFOqyvcK2qNB3Gt+rC/Ocd8=;
 b=lXaSO9WKqnAqwiXf54use8To5bhsRc4HNTTr2zhnZ27W/tjAK1NkjbQRwp9qSpp2wYnzWgVdRrVts0L/hImNmLRa1WPI4xi2ONaodmWy2JtbVWG/+ZSKXOz2MlfGwp3sQfoGqNcWwzYTFvrz3QGedtBZopIV84kWjJmFHXvLJTBpc12lKoFUkjxH81SFrCLFX2/K6Ad6NpZZ8rPJ6sgdWXn1Yp0G1KhIpLvp80zSXM3NQ0xe6F60RkX/+VF0kfScbjWwMId2ULqHZR/B7PDx6Lfo8jTsjwbY3j7Ah8+63U0B/Ens8BpBPTYHS41wV8G3a1l1168NE7s1JxQj6WnvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3gU5ZFRqJ0AfPQb8DuWHFOqyvcK2qNB3Gt+rC/Ocd8=;
 b=fy5W7/RpHjg/oS9V93YcLfVgNyS74QeyJVRqUtOv1I3cCECuTSiRbE3VAmAiUrsX6IFrSsqufUCINy5xh75JpfTY5D/TCF8YWC8PAXHdEOev0uKpc1TVuYzf4b4q7+/d0g6vd/y1KgeoXkM5AaZJfBVR1oMfDkYH25yjAk3GPMs9NAE566AE+gzWtKKKRyUd4pbH9KdWzqdu+uQ1yqKFooZmLD5cJqLeoCHz22Cs9Oxp6XiZFPoMM1DZQfJpydLW9iWmr4Rn75ybKEcFkTGdMxom4UR5/+LHWGnNGug7/gVF5WvIPCGJbTB8OULtFuBtCM42EP+/5aKS+w6xXVWz/w==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by DU0P189MB2372.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:47c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 02:46:16 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0428.009; Thu, 17 Sep 2026
 02:46:16 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ajith Parappalliyalil Venugopal <ajithpv.linux@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH net-next v6] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Thread-Topic: [PATCH net-next v6] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Thread-Index: AQHdRSJ0fNT8j7DyLk2R+2BbtslJ7bbSEqug
Date: Thu, 17 Sep 2026 02:46:16 +0000
Message-ID:
 <DU4P189MB37500265373FB1510B4CC454C6B82@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260915145641.2434403-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260915145641.2434403-1-ajithpv.linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|DU0P189MB2372:EE_
x-ms-office365-filtering-correlation-id: e9eea8a5-9411-4b52-a1ec-08df1465d865
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|56012099006|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info:
 z5S+MFcneVDS3+ga83GTvSW1Ev2dvu4AyNQW2gHbvymYvTeP77VmoeLdUt8HEMI6esuBeOOUVEpJsXx1D9DcttSC+nV9QCY81/TF+FHafB/Bss89OEfzM2czM7u2XQ5dQGt5scttb/SF7WGUQyf0DujdID/D9Zgvd696/b2Dk7h3bN27jgYMhzjkn6OFC8KCuXKKbdl0WO6K+dumoajMqfGo7P0h0xbZVuUj4+FjAE4hNQr932uLmGrHDxHVhwvBB+Xae4eyEJV/AV905tAA6y0PQk54Xy8dd9TilCAwg2anub8JZQTZHDOjK5rh9ZwHrM6C6UZu5rjX6sGkJ/btoVj6s8JWUb720Kg8Ul58IVrGinLa+YSJKllHfHor0NrEWdde6xINSS1eFzSiBtNrFOFOjeC1YiVtmi5hfDLL6F+dXAMVbTVauQbL0s4PYICQUJrlraj2X8N23fTXJKIqvXipVKZYLyY53Cgah6hRjop62vaAE/aBZ/YHKL/2fBJB0S9Wwc+IvvR5szlyQa+GNaZVD2+/xheNJ218QYZ0EBztIt9jBXTnr/abaDxZoOSvTPn8nZu9IL9lK9ss/33k6VeGyrjtQfBoIoVzhbuD4+b1FgV5eFMbl+vAriL0JmaPWO4MwxWC2kdLjG/LaRBZKJI4JdVgDAUpdTv1552HFec0Dn8p4Hh/PYlQWAsWeMqC7hpM3d+buPwrPbcCmE0pX9GjvbVMBciZfLhQhn7UDk4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?24wVM1iOkKm81aSePSRxzApTqlvI9bO2LAxobRCQXu1eNB75rGa2RF1RBLlq?=
 =?us-ascii?Q?WuaWwRR3vMoCcv6Cx87Sr9+GhYglrfYRZhTZ71uhg5rUH1RrNO9InD521zEl?=
 =?us-ascii?Q?LWChDTTkm0JAONNLS8YYH/wjFpCjDFJZpySRiaNL5aaenFRGOa+83jaFnuh8?=
 =?us-ascii?Q?WghyA2CuXJ51avSWB/2KLiBlmW05SKYvypdmVLx7EoLwo1dZTzJW6Pg0yldk?=
 =?us-ascii?Q?PzwOU/7wL6HqW145bhec/Z6ZztwTvwXCrBWw0rGL8PgP/JzNix0Z1nlivl1L?=
 =?us-ascii?Q?pjPqk4AKsnqzmdYsAR6OXE7yyFvYGq0WRKxf9fBs61YiICO0XoM3dZB/mLxD?=
 =?us-ascii?Q?9MJxqLSbyIebKDh+9jpIDIoZcarez7erwaFNIUXUl37XGxzOtZdQUh1jmeEt?=
 =?us-ascii?Q?54yeLAYTgvhA4PbEiheJTNRF47wh3sr7Bz87hR4WyPeLc/5vVTE/1a2UbO0k?=
 =?us-ascii?Q?/25GFUrHZ6aT3QLpm7vc9GR26906QDDZHc+NMfIXx0yjE/dEU0KcJax05FBY?=
 =?us-ascii?Q?J6xMM11bMLqDwANhifQdH4hk2gSbVPZ5zZIkDyJ8KUjpspa6l2CptEwO+uXm?=
 =?us-ascii?Q?WgBfZL9Im+jW9qaKTesHxulKFmqExj19aVEETLKoQ8PDVHixC9v1bZvfOksI?=
 =?us-ascii?Q?m6e4XhuL3kMEZBDVmAajRitWkbhrEM5pvEanSuD0FLTTUEawm1SeM+/wKsRk?=
 =?us-ascii?Q?ZxYr4wiqGBCMXekNm2nNr8HUFVXU2l4fPP9Xo61GoH4xmQ6OXq26qOfFYOjg?=
 =?us-ascii?Q?T7CT6CtyTO2fGj4eYtKR0iVG4wJ5AmddZiqXVB4sPXV0vwjmQgWqTxgQJHwg?=
 =?us-ascii?Q?dGApYo9gp9P3e0/b2Ho6MaythHjde9/wfw3amKodrB6K1v9RcNP4mYAxQOmu?=
 =?us-ascii?Q?RkgZ1L5m3Cg+M5FyFQ6XeirtX9fB4zvRJPEq74U7gnGPyhUOGwf2Ty53BEfL?=
 =?us-ascii?Q?a0ohDcc8reChVwCadE7WWdRae0DhsBjhcCL6BeB88qgSinRDZS+6FUSjwESj?=
 =?us-ascii?Q?Uks1nFwK3puD68wfVikXVANL0oLvoos9Tt+P31s46BKjzKRFyL+X49mWg5V4?=
 =?us-ascii?Q?TP0ZcHK3DpryMyyRdTyd2/Nm2V7epP2XJRkYUl8ie7oPTGvXgj07mbjFqAW2?=
 =?us-ascii?Q?Ir2tFH9dp0CGn6VbIOm5Nb8BpHNy8M7VcNPr4HkjM5cEhhSnTUs7BxoiJ9gm?=
 =?us-ascii?Q?J0mJmj1IitBX5r/4pHB6WaJsn2EtRs5c3d3Wow2+SVrSCPVoH4fWkieyWICz?=
 =?us-ascii?Q?eeKL+nn8H+2Px8t0vNHnHVyrwiE9BconnpmPeHGSJLayubaFyAb8rbOyNjuq?=
 =?us-ascii?Q?6Rt9t4J1ysaqbUd39K1/CZs75tK6Wrn+7mTDgVvvHK2mmSzo5ulntYUZbfXp?=
 =?us-ascii?Q?4jYLfZ4v8T0uzx2Eor3tSTF4jdNP1fhG+yiDZwq/Ykdnz3GOSHHTUdyVGtvw?=
 =?us-ascii?Q?8HfyLUkiqD8M4I5L8W1ThmS+Ti4Eru7sDJU9UPmQMbEGWm0IvkE9KdGbPyTJ?=
 =?us-ascii?Q?KOgziW+oZdsmir9minstcyiJPrxNs52sAtoJnchoObB6gqKL6d2r1y/bIIsZ?=
 =?us-ascii?Q?FR8IXaGyaf9j+sTGiDo0veso2YqPFR5vv9+Za7IZ+YtrpDf4p0xoaXKOSq8V?=
 =?us-ascii?Q?s4qN+dfQmGZtABDOWxrxvcSOiVZlrjyB3hUYi8yvB012C048SdDn/puvqTFx?=
 =?us-ascii?Q?K7S/88ivo9hqITkitDLsb132pgCLxTRAUYQnpAmYohFcwJfQAFZDpzUheyer?=
 =?us-ascii?Q?eIPEGLoQzw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9eea8a5-9411-4b52-a1ec-08df1465d865
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 02:46:16.4274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lROuCM1ASDNenKiP7fVUdaDkEMJkX1p49Anj6wZf2mXZrFPhKkyjXkP2Yb3lVtkI4EBX2DOFt8yuoBRWxPgJPLOH7LYoa5R7kWflAetrDjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2372

>Subject: [PATCH net-next v6] tipc: replace deprecated strcpy with strscpy =
in
>tipc_bearer_get_name()
>
>The `strcpy()` function is deprecated and moving towards code-tree
>elimination. Replacing it with `strscpy()` fixes potential buffer overflow=
 vectors
>by ensuring safe NULL-termination based on the destination buffer size lim=
it
>[1][2].
>
>To make the interface safer and more robust for future callers, refactor
>`tipc_bearer_get_name()` to accept a destination buffer length parameter.
>Replace `strcpy()` with `strscpy()` and pass through any potential `-E2BIG=
`
>truncation error code up to the caller. Update the existing caller in
>`net/tipc/monitor.c` to pass its array size.
>
>Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcp=
y
>[1]
>Link: https://github.com/KSPP/linux/issues/88 [2]
>
>Signed-off-by: Ajith Parappalliyalil Venugopal <ajithpv.linux@gmail.com>

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
