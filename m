Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.184
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342407;
	b=N17YcsjdD3r64LNC/gd2RiWE/VdU6h7FCoj8muggdLXCjGfb3cqBfM6b7tFo+iCgAT9A
	 c8SGUpqK+ZPqvqxQEHElqi2eO6RGwLgfj0iB7uZAm0ZR/ZeNO8RhnrybnwxxbYCnB+bTL
	 FVI7NPSbHXgYVMbekFfSuvW7Mlj2HlzU7IE+sAkaX+gmSZ/B6zsmGSPDC0BPqBEH0L7O1
	 7dwcBMlEAo8i3RmHqcQ9XWsP59DCHu1V0RIkcnuP+1/nv4mxHD/6hrLTRhioSWlALXwBn
	 aU/X8p/kpw8Y6OzdAGoZY4ilS0+J3jBPF14BfXvPwKP3i2366uoZhi8bwoQenRWQZOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342407;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MDID:X-PPE-STACK:
	 X-MDID-O:X-PPE-TRUSTED;
	bh=/FQklct48N0eSNfCYo3n9D5hIv4z5pVOAjWudgdIF1E=;
	b=YhUJKRBP/28KzqRAzzXLDEryyQpVhasjV2Qb7UNl6nQpVXTvtMVYnTgHaSX0LfW85jWU
	 GBS4jT5Vcwshw8M5hMkjCzcpVZ+rdeH4VvLx9q6V3CJGUOTgZ1Gfz9t46T7+09ARPsvYn
	 KZDVwrKUJ7apaf6s11mjP+bUAmvuPquhR0Jn6RrCnkm5kIpT1+O3rC/JtOmhQc6OFX22G
	 YqA73l87iE/vFajcQg9pG0z4nwWTc2Aho0uMGULu+BBjWBj26JNqYmP0wi8Ro7u1Pj4Vb
	 8GWSiP+5yOKcJIy0ExG9HX07UawVMphopieHo7SU/H5N3/KikZurFx3S3/DH6oEVZJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=BdJUZHAG;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=uLqjSrhP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.184
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0F606D393;
	Tue, 10 Nov 2026 20:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C0F606D393
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=BdJUZHAG;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=uLqjSrhP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=/FQklct48N0eSNfCYo3n9D5hIv4z5pVOAjWudgdIF1E=;
 b=BdJUZHAGmbm1p0MSwyYi9ojz/Jc7Vb0zptIu6dfF3iddM2l+pBOujak6nTgEAJHc9mnIZmxddfLCwC2VltSyel7+yRpruC7pMn2KAH122k7RTQZ3ZSxn/9pa27ZiE8VRSTSHO0yfOtNfaQOL35EqZmfd8pHTRtEnXOz4el8WhervScFtqPvQ4aQjb5fHfY/Yfh29FsXc8hz3+gUXDEHuZP4FkmCqjIOA/onWwnknUxOO3yWNXCkznflJcabsOE+1/1/XrbP/tH6GOe4iXxmwbkHGPb6lUsTo2aDKkLv35h7DqTE2bSP46oBNQeZxg6NYO9KlvkYC06pqW7ECJYZJGQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023085.outbound.protection.outlook.com [40.107.201.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D18DE3C006D;
	Tue, 10 Nov 2026 20:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qk5+oDZDuQGewWP5TDHBWbqcG3rU0+Ubj5rtZNtMlQL4p1UQ8vHD6sdTKnWW6K5rkroyaFFi9WOmkXwwA8fzn0hU3/dYl3JD0S6zs/qATrVwx9sPUa6q5UWXQ6/DVBluJyUszXdZ6awrQ2Q3+C5sWUw3m5PV2wUa8CczMeZ2cufLuA0iBUM7EYaw8SgEWAhdg6dinCw8+MIN+Gy/INBjMlsB8Pasq4Q/IOTwfQLTUJI6RmQEg5p+8dv4wbqnXfw/303ggxNFVgovQ8UwhLGUcYaIOYeKFhiEbMbfatmGvxhquRAf54AE2lB2vEsBsJf9rZRn/D/TqHPW6aJpcd/Vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FQklct48N0eSNfCYo3n9D5hIv4z5pVOAjWudgdIF1E=;
 b=ott16DQ0Yz+SpRiMzbffuYAdb7sRAq65/82nDwSfOGKH+b/vKzzyAZCSAVSTWc3THbadzGSppdUMilp+WKL5OeLzUvPFolGe/2UiI18INkQ5X8kql5OuN33OE2FR22VP41VCxOGUx0UzgyaAchG+Tg88Tesqq6kWrht1mx60bPtW0FEMV5yz0O8QR1me2D+srRtHk7Ms1m6ixWWXYabUpRRaprzQlzE8aPS0aPCp8aeDH5Ok98UujPoUmLuRfJpu3p2YC5Ta9nYiHRvwq0rI8WLrh9yjE9stdxmXzLGN6lqS3G69F/a1/aVTyTkQFfWVv1BBCr+XQZBKfDiKpLn0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FQklct48N0eSNfCYo3n9D5hIv4z5pVOAjWudgdIF1E=;
 b=uLqjSrhPCVJRHlWG5ftym/tFaM2GEFBZgz+8+pxScf50qEdittzGU2oTQ3y0Pdecli/0PwJko9WXO9M3jm8jHsx2Gt+HCHrr7FlbQI+5wMrwu/HtaEO28+UqqwuzMb6yQiWfYpazRqJGYap4xVt/ANnblHmA/6pAYoEUoT9JM6QDLA0cvsnh6czwuJtFqr76AukhKO+QEhs3bTa29iH3iPKenEIfXDRimCr+1ASqKF6eskFEOL73rnP3YyaJcjdqVlfqHP60OkBoTB/zwu+18A4XjC0CDKiEGAuhsEb3ayKCKJHEAon2RfSQdVHCtJIrtKBSk+QAIyIaXmbP/sKiEA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:13 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:13 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v15 03/13] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v15 03/13] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Thread-Index: AQHdcVG5WuhEZDdDyUyqCiz643b54Q==
Date: Tue, 10 Nov 2026 20:26:11 +0000
Message-ID: <20261110202607.55744-4-arouhi@sitime.com>
References: <20261110202607.55744-1-arouhi@sitime.com>
In-Reply-To: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH3PR20MB5745:EE_
x-ms-office365-filtering-correlation-id: afa2aa6b-e5e7-4cef-ad92-08df3f68dda4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|5023799004|18002099003|22082099003|6133799003|10067099003|261009223027099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261021121427099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|3023799007;
x-microsoft-antispam-message-info:
 cDmEzNObsdteYwgeoFALVA1O+LRNm71vZIXFO9/brFklYYI9VUeTjFO+RAw1xhOpKNtI8cSG2/offRhxbciz049IC69lscx4zsABBJlWJZG2r+8LplVZfnKPzhLQzpXI4J2OYHQrmUPUxpjy7/1C93yhMiNBhehouBGqmGdsnTjRw9dgj1mBK2Nxe/Q45SokbZt1mQEVwCnIbCB1HGrNZ2igGhbeL3c5iNh6YNgkXm7wt1GQkd+1Wrgj01nr9PkFdUbXXUrMkVdL5RDiIue53hNxuDs37jqgiM+/8096V4+LHZ3Q+wholshFP6Q8vw+5Az/F3rpCNRzSnyX7wlUCE2aa/0wK4OOma/4CtC3mLJwHXZDQrrtX6HtgsnPcP+U42pNG2M7duzmW50wHBMdeCXLlKofvhmFLdiljQ8EojQUXdUHJ73Ba1spQuvWfe2MvbLsvUnei3hJj6nhH4PQfujcg2qxRywFox9hsDczerrU4n6de7cGiAYJFrWw8RUNg5lwr4VPwUPt0BFnYBOlLvdA0WHz4FPzy2ZZfa7NpsTvFkPwDE1GupubSS8uohYDBufnA5CQkzhLSQnDPA53oQL4GAMhJsIgofugSH9TR5Zy+MvbSsfdAccQvmXm7zzTHp2rVqX48ublAdeXpbDatgcqNK0Hjksa8ZbMEnok4PDU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261021121427099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ThZD/nUWKEMdaJOb/Sa4Nl5eld5Yx2ypFkU6gthsUpE4tvxo8S1YycJDeo?=
 =?iso-8859-1?Q?kCoXp5Bfz7cQHshLvd+5Un18XqSMD+9FZE/HxD7a/ScCSl6h3Ndx1ifFp+?=
 =?iso-8859-1?Q?17tUGAlniZiz4bW9fuXglkVggw3GoTzJE4AtxYQ8w+FyNvtEos7ALEBSgk?=
 =?iso-8859-1?Q?nX8tIeYSrHt+J/+QJWiudbFVxTQ1kKtba3gT9n8XBjyA9UCugy7edeplgC?=
 =?iso-8859-1?Q?l265+duAfZ1loKS6oFyEEs2BzGuuO9Fk7VbnaFNvIWb2s+Xopp5rj7naB+?=
 =?iso-8859-1?Q?amsHwrJdgUExdgf+LLoymAnPclhvmyzTR1RmSHzLEoXxceMCpma5eZOwJL?=
 =?iso-8859-1?Q?18ynlG+WFqr0gKF3NxsYEcChXDiuTXvDkuz1nWt4aO47JgUcOUjlCnBJXM?=
 =?iso-8859-1?Q?2o991JKZIeJWp5w8DeCCGlrBA/F4WpO6aR3lILq5y7M4FYBGFgzsQjJfRU?=
 =?iso-8859-1?Q?U9FFZHSSDr8OaPm/5nY5PeXiazqgBKG1YKFRq7UKLulXK9/zBFyid5LHDD?=
 =?iso-8859-1?Q?5jp1yGM5fqZdGKcYhRusZ1NZJJozuAFzmYjWpBcIgEaq2uSzGphs5XLSh1?=
 =?iso-8859-1?Q?ZYFRmYw+lyjCGIZnhX5m5Qj2w7uIq4mwsXy43BH+1an2a2KYK6P3DK3wsZ?=
 =?iso-8859-1?Q?MGGMVTkmvsb6C6KCxnInj166jUdLLqHzaulZqzBkMClfGOt3I77lAdXn5k?=
 =?iso-8859-1?Q?0TH/FGdWcCIxXe0R506OFmNVAy9vk1mYkTIH++sLj1Ajxg4eV++5RWeYq5?=
 =?iso-8859-1?Q?c9P7qsIGzNhRyk2iKp8k16kWbIVrHk/Mru4/l/vALapH3o/j5K2iL8ukOz?=
 =?iso-8859-1?Q?MR73ISCKlPkwKMAvYtwV8Ffa3nj3Uc872+DnveZmsRWpyKHX9qwhdHghxd?=
 =?iso-8859-1?Q?2FwEVHjQM0Gn0FsoTOyuOq9n7ErSZoQngKMn6dJna6Q7hHZa3Prz1+vIpT?=
 =?iso-8859-1?Q?GPakX2CmwC6Fh8ag9J6FJY9HTob8ykUyUCP0vzqClkGG/z+3vJMtYYVfJ+?=
 =?iso-8859-1?Q?wl3XYm3lkGekgTUrPIITDE2Y06O7cSt0wbgSSRDy2n/WQPsT47z1GFmUhw?=
 =?iso-8859-1?Q?aSf1/LEhFy97uoH5RVidLAPfKvmbMcD+3/G8Z8fAzeATKAXaYvDA+gSLvl?=
 =?iso-8859-1?Q?G4+ZhcewQzinpxO7QuWsYjb5r4IPj82F3eUsNjHcqXUsCz2D6CrUOMozMO?=
 =?iso-8859-1?Q?5uW3Egg//7u0yAhTW9B8hnAcEwx794gfWk8p7chn33MOuhw4P8Rz3p+sxn?=
 =?iso-8859-1?Q?byKfQ6osWDeJ2dBcF6Jpbx6zCzZH+ZlSUiivD6Uw17LMvdl/IUzSOPIySx?=
 =?iso-8859-1?Q?V6YdS6HXI9QqFs6jFX/sXYJW57XVenM4VcQuhO4hSDZ5BMpoBTA5Gzpp+x?=
 =?iso-8859-1?Q?oSHNpgiNZYGDzUto7SaSsBNHNktkfd/o5j+QFVYEhllXE3gNAhAOpo8q39?=
 =?iso-8859-1?Q?92muq6abYo2Ypw82wPHB0+dw3RA7YMBoRzp+Y5ukhkAhBJIg9Qf49ovQLR?=
 =?iso-8859-1?Q?xAn/GgDbmUoEYEwga8i+Q+QrOGk2TReOPhPbgXIey6IdUHHU8INcE57ZAT?=
 =?iso-8859-1?Q?acKwGOF1IRTAcENJCDjf4q5DGMkhMSHiewCNYo7J5AExXJGtfbcfbgUZ1U?=
 =?iso-8859-1?Q?3kZKawlxhQKkrH/58LbYwlaytOWj7W7idspbpdj0GOvfN+UDcGKYq6r8B4?=
 =?iso-8859-1?Q?UREwR/vfNmakzxaR8zSqBlnI6Brl16fD2ZW2WbiY808VSb/9XK0OS9B12h?=
 =?iso-8859-1?Q?mwPcOQCoZ5oq947jKb5TXINZxkT/8GhNHgeY/tn7Ni0kDU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XGq8XoEdQn5M5+6HnYRKG7id9vXowILnwpJ/q7of3RwvhBVJKYANEtAqY3C1Z/iCAuMrvjWFBI0+X8Ea4lIS2/fI5/p7ZLUtn5sz4hLsa4bF80/k7LPgRr5slP26+N3irUIvxps+/o65vvFzUndlr0+PzCXfsR3TUuaTT0p1cZNGmKjWBQAnJdDT6INvOoAiKrba3W7i5AbOjZGGcilx2JJiVxjtvL9RHgnIL5Vr630TUylfviQN7rVDU+pU25a122MO8TW/Lgmf/FnsHy08Fo1qgGkChxDuvDR2h9n41sKTgvnpyj9NbBELsLmtbaMfD2UmgTqkA2WiggmvgT0CUQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa2aa6b-e5e7-4cef-ad92-08df3f68dda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:11.0535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VkfJAd4y8mdQjR0K4wf2G0K+NEF55fFJ2XVfL2PWx6elALbkhdC8LvWxXLXvV9PhAQDVyoVlfc+2gkRU253YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342399-9iZywjbtBT6M
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1794342399;9iZywjbtBT6M;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a binding for the SiTime SiT9531x family of clock generators: an=0A=
I2C-controlled device with four independent PLLs, up to eight input=0A=
clocks and up to twelve outputs, described as a DPLL provider.=0A=
=0A=
The XO is given either as a clock or, for firmware that describes the=0A=
oscillator as a property rather than as a clock provider, such as ACPI,=0A=
as clock-frequency.=0A=
=0A=
The supplies are described by their pin names: the core and input rails,=0A=
the GPIO rail the SiT95317 has, and one per output-driver pin: VDDO0 to=0A=
VDDO7 on the SiT95317, VDDO0_1, VDDO2 to VDDO9 and VDDO10_11 on the=0A=
SiT95316.  The driver does not enable them, since the boards so far=0A=
power the part permanently; describing them gives a board with=0A=
switchable rails a way to say so.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>=0A=
---=0A=
 .../bindings/dpll/sitime,sit95316.yaml        | 214 ++++++++++++++++++=0A=
 MAINTAINERS                                   |   6 +=0A=
 2 files changed, 220 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
new file mode 100644=0A=
index 000000000000..5356a73a8062=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
@@ -0,0 +1,214 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/dpll/sitime,sit95316.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: SiTime SiT95316/SiT95317 DPLL Clock Generator=0A=
+=0A=
+maintainers:=0A=
+  - Ali Rouhi <arouhi@sitime.com>=0A=
+=0A=
+description: |=0A=
+  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock=0A=
+  generators with integrated DPLL for synchronization applications.  Both=
=0A=
+  variants contain four PLLs with automatic/manual reference selection,=0A=
+  DCO frequency adjustment, and phase offset measurement via an on-chip=0A=
+  TDC (Time-to-Digital Converter).=0A=
+=0A=
+  Both parts have 4 differential input pairs whose lanes can also be=0A=
+  driven independently as single-ended references, so 8 inputs are=0A=
+  individually selectable.  SiT95317 drives 8 outputs, SiT95316=0A=
+  drives 12.=0A=
+=0A=
+  Pin numbering.  An input pin's reg is its lane: 2k is INkP and 2k + 1=0A=
+  is INkN, 0 to 7.  A pair the loaded configuration runs differential is=
=0A=
+  one input, described at 2k.  An output pin's reg is its physical output=
=0A=
+  OUTn, 0 to 11; the SiT95317 bonds out the die's outputs 0, 3, 4, 5, 7, 8=
,=0A=
+  9 and 11, which its datasheet names OUT0 to OUT7 in that order.=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    enum:=0A=
+      - sitime,sit95316=0A=
+      - sitime,sit95317=0A=
+=0A=
+  reg:=0A=
+    maxItems: 1=0A=
+=0A=
+  clocks:=0A=
+    maxItems: 1=0A=
+=0A=
+  clock-names:=0A=
+    items:=0A=
+      - const: xtal=0A=
+=0A=
+  clock-frequency:=0A=
+    description:=0A=
+      XO rate in Hz feeding XIN/XO_CLK, for firmware that describes the=0A=
+      oscillator as a property rather than as a clock provider, such as=0A=
+      ACPI.  Use either this or "clocks", not both.=0A=
+=0A=
+  reset-gpios:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      GPIO connected to the chip's active-low reset pin (RESETB).=0A=
+=0A=
+  interrupts:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      Interrupt from the chip's active-low INTRB output.  Asserted when=0A=
+      the device detects a status change such as lock acquisition or loss.=
=0A=
+=0A=
+  dpll-types:=0A=
+    maxItems: 4=0A=
+=0A=
+  vdd-supply:=0A=
+    description: Core supply of the PLLs, 1.8 V (the VDD pins).=0A=
+=0A=
+  vddin-supply:=0A=
+    description:=0A=
+      Supply of the input receivers and dividers, 3.3 V (VDDIN).=0A=
+=0A=
+  vdds-supply:=0A=
+    description:=0A=
+      Supply of the two GPIO pins that have their own rail (VDDS).  The=0A=
+      SiT95316 has no such pin.=0A=
+=0A=
+  input-pins:=0A=
+    type: object=0A=
+    patternProperties:=0A=
+      "^pin@[0-9a-f]+$":=0A=
+        type: object=0A=
+        properties:=0A=
+          reg:=0A=
+            maximum: 7=0A=
+=0A=
+          supported-frequencies-hz:=0A=
+            maxItems: 1=0A=
+            description:=0A=
+              The rate wired to the input, in Hz, as a single entry.  An=
=0A=
+              input runs at the rate the board feeds it and has no=0A=
+              frequency to select, so that entry is what the pin reports=
=0A=
+              as its frequency.=0A=
+=0A=
+patternProperties:=0A=
+  "^vddo([0-9]|1[01]|0_1|10_11)-supply$":=0A=
+    description: |=0A=
+      Supply of an output driver, named after its VDDO pin.  The SiT95317=
=0A=
+      has one per output, VDDO0 to VDDO7, numbered as that part's=0A=
+      datasheet numbers its outputs; in the pin numbering of this binding=
=0A=
+      those are outputs 0, 3, 4, 5, 7, 8, 9 and 11, in that order.  The=0A=
+      SiT95316 has VDDO0_1, VDDO2 to VDDO9 and VDDO10_11, the two shared=
=0A=
+      pins each powering the pair of outputs they are named after.=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+dependencies:=0A=
+  clocks: [ clock-names ]=0A=
+=0A=
+oneOf:=0A=
+  - required:=0A=
+      - clocks=0A=
+  - required:=0A=
+      - clock-frequency=0A=
+=0A=
+allOf:=0A=
+  - $ref: /schemas/dpll/dpll-device.yaml#=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          const: sitime,sit95317=0A=
+    then:=0A=
+      properties:=0A=
+        output-pins:=0A=
+          patternProperties:=0A=
+            "^pin@[0-9a-f]+$":=0A=
+              properties:=0A=
+                reg:=0A=
+                  enum: [0, 3, 4, 5, 7, 8, 9, 11]=0A=
+      patternProperties:=0A=
+        "^vddo(8|9|1[01]|0_1|10_11)-supply$": false=0A=
+    else:=0A=
+      properties:=0A=
+        vdds-supply: false=0A=
+        output-pins:=0A=
+          patternProperties:=0A=
+            "^pin@[0-9a-f]+$":=0A=
+              properties:=0A=
+                reg:=0A=
+                  maximum: 11=0A=
+      patternProperties:=0A=
+        "^vddo(1[01]|[01])-supply$": false=0A=
+=0A=
+unevaluatedProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    #include <dt-bindings/gpio/gpio.h>=0A=
+    #include <dt-bindings/interrupt-controller/irq.h>=0A=
+=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        dpll@68 {=0A=
+            compatible =3D "sitime,sit95316";=0A=
+            reg =3D <0x68>;=0A=
+            clocks =3D <&xo2>;=0A=
+            clock-names =3D "xtal";=0A=
+            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;=0A=
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;=0A=
+            vdd-supply =3D <&reg_1v8>;=0A=
+            vddin-supply =3D <&reg_3v3>;=0A=
+            vddo0_1-supply =3D <&reg_3v3>;=0A=
+            vddo10_11-supply =3D <&reg_1v8>;=0A=
+            dpll-types =3D "eec", "eec", "eec", "eec";=0A=
+=0A=
+            input-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                /* IN0P and IN0N: pair 0 runs single-ended */=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkin0";=0A=
+                    connection-type =3D "ext";=0A=
+                    supported-frequencies-hz =3D <10000000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkin1";=0A=
+                    connection-type =3D "synce";=0A=
+                    supported-frequencies-hz =3D <156250000>;=0A=
+                };=0A=
+            };=0A=
+=0A=
+            output-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkout0";=0A=
+                    supported-frequencies-hz =3D <156250000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkout1";=0A=
+                    supported-frequencies-hz =3D <25000000>;=0A=
+                };=0A=
+=0A=
+                pin@a {=0A=
+                    reg =3D <10>;=0A=
+                    label =3D "clkout10";=0A=
+                    supported-frequencies-hz =3D <10000000>;=0A=
+                };=0A=
+            };=0A=
+        };=0A=
+    };=0A=
+...=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index fe23913b1e43..6c831bf9e812 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25870,6 +25870,12 @@ S:	Maintained=0A=
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml=0A=
 F:	drivers/usb/misc/sisusbvga/=0A=
 =0A=
+SITIME SIT9531X DPLL DRIVER=0A=
+M:	Ali Rouhi <arouhi@sitime.com>=0A=
+L:	netdev@vger.kernel.org=0A=
+S:	Maintained=0A=
+F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+=0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
 S:	Maintained=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
