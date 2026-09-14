Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DF33993;
	Mon, 14 Sep 2026 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426861; cv=fail; b=MFcAooY4S+M/LlL36EwRVTEkv7F+wAXuo27PWPESd7pQiFUMf93U1oKsx6eUHzHv3dPe3vmBU/gozuVt8mWezoVBdBddJCrIbZBHrIJakpFWHe80fOSSrRiwg6OhAmiqXIVL0WpCX+yypjTT7ez1M73wTmFHoNiEP7aCSLphbMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426861; c=relaxed/simple;
	bh=YkAkPY/uitwRcg/sejQEV1MBtWQiyVMS0T2YO3suWF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BSRLj6PdkEJUL31kc6NHuEA9K+pYX3cY/JIbFOK6LNJnsNFVPfH0796ODUvZXjuFX2Cf5fZEnXvEpki6Y46TQnii98YH4Qgg9sUFO3UClk7DK6wz4QOMCCUcP3z0XXt9YMJf19509nHJugDVYAHjKjITm1swTU8faV373/WuO0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=jEh6u09J; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=CUnuOSqm; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="jEh6u09J";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="CUnuOSqm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=YkAkPY/uitwRcg/sejQEV1MBtWQiyVMS0T2YO3suWF8=;
 b=jEh6u09J6L/euQuXFzBOXv/JjoguixbOq9oyO7PFfTMIvexdsn7PdQTyvH/qUfIJqSgoAfpYkALoAFfJODKqK8Ry3ldeEeYS0OVu464RYI7cQHtgqXX4XgtwGcDWNbOYrlm9jD16HbNqFb7iJpPjSO2A+TC4xNkX0lEUHVXNTj4m9W81yp1sSoeNskNVkeSTAJt5uUjcS51Ak8pocnK7zZJp2KTGE9ElJioLXAdeP5h1gqXh2fh8LGrssBuy0kP8oC8IVXfuUpuiaG/fQfQ8oVDLUdQr0hZC5MQpzzUEtHyuA4n/6uizLZxuB/32rIyC6Xdd0qvBIN9aCEUsuc1x5w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021091.outbound.protection.outlook.com [52.101.57.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F0F0390009B;
	Mon, 14 Sep 2026 23:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItksAuzE+WEYpLsQyRmZa6ps2KN766bi9WRfIpEVWWPWTMbLAJZNiAdI3yCdyrhCPVK0HlYmoyRW6T1xwNHQhxiNLHDhuHw//BiXMk5WLA8x+TYwnsV/K76w7wo9NTk23uWzBd/Z6Sr1Qxb6VQ1P7AhuNxe6xVONAPNIKCPpI6IcSYssFr6zkJYIbwAmXAIL2fQyaXy0UQgMnzOwJDLxiczXpWCjfDqpuPTDt9gPwsMuet5mEk28AMlzttWKYloupi0Lb7EC+K/oCn/LuH8vlIaURomaOlXUfYmtptoU2U+0l4hLSQrgkNCV4IhZ6qMzy331RpbNuTkwXayybtvHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkAkPY/uitwRcg/sejQEV1MBtWQiyVMS0T2YO3suWF8=;
 b=iuPW7+f1H/HhH8Bq038kt5DzeelUpWpMWT6n882cZLD64hPP4DAw8sGkNSwC3vtEDVPwblKy9U/+0zN78ZIsYnAzM5xYFY998s6BtzW93Cw1S+1APpSeDxmozWzwt25dsGMbjHA/9d7OPOdDmuByVEaSSkINXo61qykSgS3KVJCIVwKClDsTfCVaBc5X0sA5p8DdQa3h83nZ6BW9u4CTb+IMPh2pyWL3BqCGRRq6PUZnY8cqm5rMA43uGt/5Uf9O5T7LH3T0SZ4vNVhbIe60W+t01nGP5u3t/I/byd+vXxlVYqQUfpwAB7+/qrvxSPLXXcgLVTWnCfyCYFeBTRC7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkAkPY/uitwRcg/sejQEV1MBtWQiyVMS0T2YO3suWF8=;
 b=CUnuOSqmmw5u4lCqm2dK8fl4qvhFxB3DyB3dZD9dvFNUJa0se38X3l6tQm1xgmJgUGFRg7zBDkeOIgPGYDumlGfGC6lU4+s0N+GT/edKBVWpp8KNntNoVzr4R3A8Y0T1crKUgRuPMQrPBp0qjcwCXayWlO476wx21UbvnB8JdVPQ2Ww2ejK2fRfX7GXsj/ZBV54mw/K3gHIKvvW3bz0v4My5gZpEItDJ+1X36MWRsExZ3CgcKDZa9GeoY/gVxS8fpcSP8dRst9W5Y432hvxJPetfPpl7vDmcbVH5iZvOqZ31dXGtqMITdP/kt8UPpwkjQ3WYL3+0KFFGdUOLa5MM/Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB7131.namprd20.prod.outlook.com
 (2603:10b6:806:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 23:00:44 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:44 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 15/15] dpll: sit9531x: allow the device tree
 to override two board facts
Thread-Topic: [PATCH net-next v8 15/15] dpll: sit9531x: allow the device tree
 to override two board facts
Thread-Index: AQHdOyOxgVkxPL0MGEC6dAn6hw12aLbEqZaAgAoZ04A=
Date: Mon, 14 Sep 2026 23:00:41 +0000
Message-ID: <20260914230034.63861-14-arouhi@sitime.com>
References: <178887153173.219967.10560676348042858719@kernel.org>
In-Reply-To: <178887153173.219967.10560676348042858719@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB7131:EE_
x-ms-office365-filtering-correlation-id: b124ad21-80e6-4618-4191-08df12b4021c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 wjvJGDBUFQGL1fX9vgMJAlwN36QVxuslhbHFYlSw/aoenClOMcDWNsPHiTknPDh6w9AykK9zjJvx1og39w6Gh5bCHRpdAU62oB4cWnq3Y7RuRk89lSljij2/hf5qWzq4wTO+m8boJ2L+G6Hlx2BRF1eA6oO6IcJ7mVmVk1ZzskGpfg7nxSQ5rCQrp0aKOV9neZx5xNGW+WBYsGsLmFCfBVnqCD9/lLab70RSfdfghHpT+F4Uz2Uh6e2gwfqptQJI9q3tZ0U8Kj8c23A+bgv4OCrv2U3KKifIthj3PCmvvAewCuhmBgFNdfrzqR+MElLtoAp+3h5uD8Nr8TeB/USxDjv5O6LulHGpaJ2QMKh2175xbv5eFd1JguBpRYDVXV10T9gBwzGFVnoa24+3vILrstcDJ3pz5x8cWZIZJsTlwYa2sPuquBA+3iMWTB3Rv2p34coXGrf7PqE6pNbGfMC+SutdPAA/fl/xW9Yp5m8/PhW50wq+XQJn2AFSJ9dsrcs89dixnbRtlDE4MJbf3GoSoe3h0lMwhacB52sqBp47V15Ap7DD+/K2S/ziqqMHt+29uU+8D6OeZMeRHNRRXdPjUboc4FiimIIr3FEP/oOmlVG73yOL3F3/mb1BytJFaS/xTuXfBhNVvjBak2W5xfChzXLjcnZgNo8IKHzBa0VZ/MPYI9+v/gZ04w4kZT/Qie171cHESs+d6nh8YkRSqRXHK9IsWGhz3o2RCMaE0540PNc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jwCT2K1tsdepG+JF/0EnBr59cg5202dzS/LLu5C+fP/p/3w1oAG4hxT3GW?=
 =?iso-8859-1?Q?MQh/s1g5rIGSQ3Pwq1ckWzbuuwkI2yd8ajxbSJn5e/GBHlzrO2B8knpklk?=
 =?iso-8859-1?Q?J1O/X3O03Qz8lJIghEb3xj13pdIM7KrwsGEd0Zw/CbtMC4M5ptgBzRTXvM?=
 =?iso-8859-1?Q?l9UmDCSqmdgU/FQIsO95s2gsXiJ78DEDfpnkZ8WUh8op1kdR2LYK8YPxr+?=
 =?iso-8859-1?Q?1jh5rB+hnVpmKAkdB1djN+1AoHPi3MNfsRO9lYESd26VGgpxxpq6bs6OkJ?=
 =?iso-8859-1?Q?FyzenOvAjhZy2ecZl0HTYEWJxsruQgyxW93te4iOFyEerk2HCzIasdSoz3?=
 =?iso-8859-1?Q?xCjVCWNN0pKEuNEYYsws760sukaR9nG/BqB5TmhJ/E+NDOvDNsYEM9v4f2?=
 =?iso-8859-1?Q?SoOgdlpcBGuGGB4bSkBZlysCxNEKxA8H+WtObpjtbNueM8gpP4SFXre7g/?=
 =?iso-8859-1?Q?S8V/KJEvilZMlRGRWu6METoPn+urBGJoNefra9rardA/QRMsQU567vPIxB?=
 =?iso-8859-1?Q?xqhUbt5wl9bA9fQSPNTikN51GOFD6pfKrbYHb5/fNIa0gJaF/PoHp9CMAz?=
 =?iso-8859-1?Q?T7hwQg29gjLyALX+lzga8+JFWXrbYEzl6AkMcDgRAyPunWR9VnMm1QbYPL?=
 =?iso-8859-1?Q?n0t4HzH0Q2NS3vJl3AeLCZniBoPL4gNes2Ragl5VF6IOdsQvEZKjcKnRrP?=
 =?iso-8859-1?Q?woIlU5ux9cyEk9X6aM9L15tgnO/qaiERGdM9jBB1w7CLao97eQLLDjQZlB?=
 =?iso-8859-1?Q?l+z6zZOxXI8L+UHUh2wxhoX/9PnumjvmYA9kVs8E5LpleJzXWJM1svnJoD?=
 =?iso-8859-1?Q?7LeoDNLBI0QCNaWhwnEWahEPuWbtc0XX60Eiqdc+hCjtDVkakPW+zHzgV8?=
 =?iso-8859-1?Q?wcI9bz8iSEQa7IGKqgNgdLm4gtB3daN/ZsY8JKY0iu8UvZecv25EwDIPMc?=
 =?iso-8859-1?Q?lFGrvLpt6+Aliq5B8vyNQqrIVly7H/WBnB0KHF0JD52DE5fjMAAjdls7ew?=
 =?iso-8859-1?Q?CawIa6RP9dI9Y8P8xqkY9esDzslxalJOMkqP7QI80ShDOAi5BwCvIT6PRm?=
 =?iso-8859-1?Q?Vz5iQFNbH8r2nwGXg/O89U5cgIbtxRdNC4hiOi+pHD/RJq7Qqt1Za0UWz3?=
 =?iso-8859-1?Q?bThtzpvOy7Mh7x9Gp/kPaz6ztZEErFWzyyB0Z+AZl4e9cLruhdScIbablh?=
 =?iso-8859-1?Q?4DJvvmrNIF1BZUZLfOPnx/oivs/k5B3wS08E/EEp55GxuKdH86E9QIoJug?=
 =?iso-8859-1?Q?PFW2+QWfpW2+hV6cCd3OLOATf0PtU5kjO30pPA8pRwrdu0aYqrizOUoQpF?=
 =?iso-8859-1?Q?wq0m1NqC5HZ7xxYYdmXRTdwiuFgnNEyewbwea5G65rgLJ2N+DP5rolb0ey?=
 =?iso-8859-1?Q?VG4sDQeMSnzPbNVrEa4B3ssvDYLKOCBLUz4eXbnvYtZ+UnnFill6m7n2fO?=
 =?iso-8859-1?Q?AnWUxSslab/CIu7C3L9dLm2L/6I5jaHkDRpBjyE7+Cwawqc5zx/BJlmxNd?=
 =?iso-8859-1?Q?QVlOVU3RqeOKHIXFm2PY57cnGt/ce/8urxSaCgRPIO4vlo9Eh6iI/PdbO9?=
 =?iso-8859-1?Q?zvj+1C+/nsT5I9LeJ72O3ctrN3YtHY9BXD3YQ22+E9FrmTonlez1a13xHi?=
 =?iso-8859-1?Q?fbdsUF4kYtoS5c5iIE9hlt49lhZTJrfU/pgH/7Q0LATYE6u8i5B3muAx8o?=
 =?iso-8859-1?Q?3rcPFv5QGV91grz4SVyev9GmIIOsVKGkk5p3m6gBPmvlwXC72q/2V1cq3O?=
 =?iso-8859-1?Q?2ERspIDJ+TfKWkifLdlnylYfVbPWl9vDlW/fItRLFVn7OW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	0fg57puqCsRmyi8CZcVdFlsF9SkVjXTtNdBpzB788zh8hQAEiV6aKqmDTFzhIyZjHLWh0zY/TPQt2wJjHu5DjKdqC9bu1zpCrveFX/HW+8bbpUz7KTn5h6JIJA8O8RQBTmgyqSokZYzP0qtLV9z6SvruFXjk0gQEaIucsdFXTyHifzTIG/BFotF4oukvg4tnqFkb1DiLR9Td4+u+p5IKqXqHlA1rl6gs4XTLWYSp2YbVdwkHFCR2SuAgzWWkEnWqC2S++Rs1qy5V66zk/a6ygEi0Q2xaf3I9MoFCywlV/qngNDpsrUyluerjbVV58p09f8dJe8tuIj+QEoonibVnig==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b124ad21-80e6-4618-4191-08df12b4021c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:41.5078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfxwoEmLD3yk5n2WTOOcavpSn/NSDZUJGS9AJvsejsMYffFGZdULrXyhwOsk5R8nLwiuZlLODBygGJToSBM5Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7131
X-MDID: 1789426847-445J-QD6Xe08
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426847;445J-QD6Xe08;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> Is the free-run rationale here consistent with the code the property feed=
s?=0A=
> [...] Should that clamp bypass be called out [...]?=0A=
=0A=
Yes to both -- the v9 changelog names INTSYNC (not free-run)=0A=
as the configuration where Fref*DIVN does not reproduce the VCO, consistent=
=0A=
with the kernel-doc and the binding text, and mentions that a present overr=
ide=0A=
bypasses the band clamp (with the new DIVO width guard bounding the effect,=
=0A=
see below).=0A=
=0A=
> Should the return value of this read be checked?=0A=
=0A=
Yes -- fixed in v9: the read result is checked and a malformed=0A=
property is reported with a warning instead of being silently=0A=
indistinguishable from an absent one.=0A=
=0A=
> Can an out-of-range Fvco here silently misprogram DIVO?=0A=
=0A=
Closed from both ends in v9: an out-of-band VCO override is dropped=0A=
with a warning at parse time, and independently the frequency setter reject=
s=0A=
any DIVO that does not fit the 34-bit field instead of truncating it.=0A=
=0A=
> Should the element values be validated before they are narrowed into the =
u8=0A=
> out_pll_map[]?=0A=
=0A=
Yes -- fixed in v9: every element is validated against the binding's=0A=
enum (0-3 or 255); anything else rejects the property with a warning, so a=
=0A=
bad entry can neither unroute a live output nor mark an output routed to a=
=0A=
PLL that does not drive it.=0A=
