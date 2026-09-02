Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED874071F5;
	Wed,  2 Sep 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385263; cv=fail; b=Q5HTjgeEdiOyBj63qOirs2U02rZMiM4NXOVXdQ48u4rw0+g5f/EzzPDJbT90ifXf5st8vain+KPYeBzmEiaQB0cjDyoQQMZYNLIcfkYnrE/e4GCPd6F6weAYzCuXzfav14DOmjw/mwSUhF8RUFOKAP9CupJ9iKNeTWOsQwIP02I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385263; c=relaxed/simple;
	bh=gv6Iaeeoxk70e4PuoGFXkInJUBHpDKDOM4ss91Vd3bc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqqQPiOCkkhehi2ZLvMgZAIlB9D514cxqJplraDAZ4VBgmJVNbAJ057PE25e7xUILTGcG6xMf1LKaBd8Cz64eac7cImgs8kYuqYxwecy79DJ01YmkvdMO/HDCESIkUy2F3zaKAszg8bQ3xmZUKTRF+PwlMsbN1IBvkAdyu94O9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=NTyJniIP; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=vS1F05QA; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="NTyJniIP";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="vS1F05QA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=XveBMnzPqmjKurwpVGdNjXPilKDO8tzt4paeocDJFWE=;
 b=NTyJniIPQYV8oeswYnEK5YjQ2l93OUyeipuFpgzXwdg4kZnqCc3M81OH5w4c4jRRfdEBmB5L6+fIi2NeLwRpfWRVBT978VZOyNaAavK656b6nPBI1m4hGhmy9qP2GhRl1Qcggx/rwKJ7m4MSlOqvWn2AnxVRmm0RHTQmVWnwiIn9G1ahw1A7InRuqWPyVlZnDMRRGqc8L2Kw6WmHZf9AQq9Zd4lG+a2/BabpvjdLZubx1GL2nWP8tcGPfAmI7dxvTueSiHGtP+V50Yz9Rjy9tYFOdUR1OREJloMu7yAk5TYfL10oTQ73UVjxWr413fJ042NAc6uUBC0lSCT/FhAi1w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 971E5240065;
	Wed,  2 Sep 2026 21:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCxudX6GIWQq+YOw0A9Yho84TENMqh6r1NUiBijN9qpXHoQM+nhfI1M+b6gm8pQlzjzRU9LRAGmIU5FkmahF5oNAB7ZwQk6+E/ce4s9iAhnrEnhjttTd6uBMlypWgAceQOAmmPuLeXt9uzuewaQGx7XAjVLoWnYcjGVAHcrNWca6XzcdXvi+hrRaZIEUDX0XbnUuerV22vkgBjJ6tFgjX9Ql6QHkU+sQG0PO/HmnK1kC9hP6BRIYCb2NOjRP/yMopIX0Fc8mqODhLQIBYClqhOXc4+4tpRjcD7r+o3LZN1EDIjtcMZ9IBuh0lqaEQf+JcBJ5qN1mQUP4eZ8YyrL2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XveBMnzPqmjKurwpVGdNjXPilKDO8tzt4paeocDJFWE=;
 b=F6Bc07ZqzczqAod8hABUPeZ/ZwHX2cXdrRvutvEKDIpY0lzgW9Fa349bEeKFROggbdCrqHM4H/4tjnpsqxlr6WlHgpcgoATygda1I7zujC1W3yzAcdsbYnlaT+ryEKA5JsWJgzXbJlRYdmQ3tVut3mGRquow3DnkGJ0FeZVLesbFmOH2n6k8+WfUwHXvGjVNTg6C9c8Vh3cbJkNBQmbUDTOXMJ1IuR8KdVLLfWeVLS8tkWaLoHD+upJ1im1V3WYHlhFgu5uFK26BZC1xFNyN5n3Ymt9WHQNMv64DF4KASZaCBbQpLzTj4pTT5KNc2js7fT4SJ6ROcQObqObV/r5AFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XveBMnzPqmjKurwpVGdNjXPilKDO8tzt4paeocDJFWE=;
 b=vS1F05QAGGkCF9lvzqC+UhDsNhUUhWnByROW3IS2bO3LGquPFaPpIid0IYkcjaY7JYqiRDPaPj6XHA5Z4cgZM2U4IDFtZsaYvZopqs+Dyn42CTJo0dxLrEaI5RgErKyomoZCEfmgg49LWiv+1yJQ4ncM5yZRZhhgHNEshA+hCZ1C8Wfn/+5BRD13pCSxEuXCLgCaOI4IYSziO6TyBghQgzKR05URKPAMhSc/wsTbhfGdmRTf5/AMiPh2GH7SDHW3QYkHJf/KoK/gMOluDgWgYff7oFA5un204N+OL4mkavBfC4HQBZiRoEiQmUm6PST5jlCrCwZ8H8d8IoMtDNjaVA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:35 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:35 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next v8 08/15] dpll: sit9531x: add support to get and set
 frequency on pins
Thread-Topic: [PATCH net-next v8 08/15] dpll: sit9531x: add support to get and
 set frequency on pins
Thread-Index: AQHdOyOwcC+FoFSTvEyLo9BKWxvO6Q==
Date: Wed, 2 Sep 2026 21:40:35 +0000
Message-ID: <20260902214030.20955-9-arouhi@sitime.com>
References: <20260902214030.20955-1-arouhi@sitime.com>
In-Reply-To: <20260902214030.20955-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4877:EE_
x-ms-office365-filtering-correlation-id: 4bccc1d9-d2d0-4d50-af41-08df093ad281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 DoJDlTCVsCTmouXZcCR6tDi6TWPEffsKTglkkcs8VSXSQFfuB5PAQoaJGgQD7iwbGZV0vqQgWYF61wMn9bIb5bgPvHIkfYHqvfR7EHPCU1pRHlVkuoX2ft+dtZ0VoB2ruRh0wOA7faPCtlYug4AyiBZa+M+Q21p5ntIZ1Nyp4yy0hnrpxPuE7wFQeCC5NWRlWZzginZ6MjJFyrPB5KeFuIF4rFb6ivrARpoeSHIG8nPmuDNzxnM2di+lUaL8FI3MZlqG5p777vrQoOHjYWbD9+WrtZt5SIP6ofxMXRO5eMNAgWAjRWsn3GLTeQDedAPJ8YlzDdE//D/0U3hzUpuDPyGWHFHe8Xli401mgRgqpjeWg5nYoVidMo3lzbUwO7FKHI0SmKL2apbhORXGKvp/RKo6MCGugHPnpQcdkG8V5q62I9i+qUW5oSeRWYB//aMuqN4yyPQcbpKbqWvD7vGqcKkS3VWixZ1w4+8bcwrZ5oULimdtHJ+qenBqHPTUjxSlEadIP984AK2yMvveRHWqEHFc+KiW/0YdiAd3nwecwy8U9/6T4vj6U6tG9MiD4TBIr8bfNc5RZ9udlQ9VFLndn8TnztOkOqmX9aTLqm8koIUUpG5aN/3DKluaAr0ioqm3HcFP3U27zPvVfrRJNLsHpVOwYtbj5Cz4Jd/KwV7+8E28AEkyEtbaPXcFMOYQQcyTEkR7lroAASnLcLZriw44VaAdCRDhlz4ZnoCp4DS4eIo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8hXZaM4j8ZVHCkWLFUBVqr4gcF1mCquKGhvCSg2chbjY5FVlivNWWeSmRA?=
 =?iso-8859-1?Q?DUzsZPv0+Dud5Qk2rw4QB9VAuUTRtw8dDRZpGuHin7r1EEsaszjUZVBhAP?=
 =?iso-8859-1?Q?mQjiLqIv4u1olBWxWOgQwDBavCLl8lJANQyu10sHfa5r6qbaxzlWwGMl9H?=
 =?iso-8859-1?Q?y22By8x+GfdOUmRk4hgLhwUmyPZvLW/SgXTdKAnWPLmVqvgtDpPDSz2rNF?=
 =?iso-8859-1?Q?l6zh4DjSIhewrNXI95FCfFLV/BsQMiZfJF2Wj1WPqNDf246B/E/8ZJVrn1?=
 =?iso-8859-1?Q?/z3ZvLduhifh4STWi8xvXlhcNP8UBEip8BsgKVxwJZOII3bfhl24Qyqrvs?=
 =?iso-8859-1?Q?TEuOx2/XGuHGcnLmZehlkrkbDrlmSN1xR3Vum5az2VYqL/5EqFq6LKSkBU?=
 =?iso-8859-1?Q?3u8c84y43jMcfJQEO2euyYvSRRjfW1bYUscSJdCM8XR/TLuNoPvCkvAKHm?=
 =?iso-8859-1?Q?rSAQZexbXQB+oLywAzTQIm91pMyssOuqLvJkC1QajCjYjlin7zGkSgP/kK?=
 =?iso-8859-1?Q?f09k7YYyNpz2+YqKB/Uc6HDy9ug/Np5ZFS1VdJQG83aKIfpjd32zVDHAuS?=
 =?iso-8859-1?Q?/nIwfCZ1uU7SaFui6I3Y93armdmM/l0W4f25m22N5K2dsob9gBKo6W20jH?=
 =?iso-8859-1?Q?Ma44V8TBA+UlRmTCRbxJwXGlcSEVBgYEob8lPLt09F5twWPFkSPcWiepmE?=
 =?iso-8859-1?Q?aNhCPAMzo23vsCntZUVXKGDiERWohthXcmi1EZvSU6tsQ+YMm8Q0wo/aN+?=
 =?iso-8859-1?Q?UR3sLbGv1CLgq0EWRDky17/Vb5+BV1jRBBLhZcaXDBRxJ0TUaAEdvpvv8o?=
 =?iso-8859-1?Q?BEt1KX3C5MDQ+rnKizgqDoHxTcTjFGeDSbCg4jUh3lZUriyJ6h+6LWiilJ?=
 =?iso-8859-1?Q?g4MV8BnNzVyvO9G/2q4P1dtvqaHOz7zl7oY8yR9/uz1wWvjBcGEmQSDyMo?=
 =?iso-8859-1?Q?Lub5RVu8uLU0DHXLqr8Qmd6929DUOqnTB/jZHpyCSGAuFbfHKs0HwCR9qv?=
 =?iso-8859-1?Q?WGCyEyqNBI1U3XJKvCGch50JgWQqOrpg0F4CEzYaJT0flPH1/jB3S6wvgK?=
 =?iso-8859-1?Q?sIAoh7ca/viGA2BfCCIK8S6iQNRsCbHv9312Xn/i94WhE9Tw/ppGEgnQnX?=
 =?iso-8859-1?Q?RooH1h+a8sVfQW0m/X2Q86Tnr0Dd93Y8HWJDG87dkzuloXkHAaTDzKMFk/?=
 =?iso-8859-1?Q?ZH0KYVi1gaVtJ9TlOWp7s2qdoOZJQfNX7IrvJi/g1h+cLk2gQzme+BcqYS?=
 =?iso-8859-1?Q?liTTTdG4NoV1ZRsV669g79LWOhJmzEic9F2avznjKGovLWAzdlqJ6oMp74?=
 =?iso-8859-1?Q?jRdz8PWFn4DWM3zP5ajp7CaauYcgIq8Hs5UAGufEexxBY7Bruj+4Ci6HLw?=
 =?iso-8859-1?Q?pP0NoZ2obTZgTi2IM6j+RCmxlbbXgq9kYTKJ7u+2wF9y6TLC5NvI4vbbKB?=
 =?iso-8859-1?Q?13cRmKU63ziee9pUiJEAdTCDD8Fs1b4rM7wxwaEzgYo0/YF2oXDLS75k/D?=
 =?iso-8859-1?Q?n7sjO13DThr/k3IF7T6ij/H4ZyPqtPViInk6NODNwX8Sj5ndvq69/ToTm+?=
 =?iso-8859-1?Q?PdYv73U0InfhUnUBFAWhgvFbi1TgznqrknW9wZYtmuL0MeaKQUDHzHDYeY?=
 =?iso-8859-1?Q?hMaj5ZyMPn0qy7rU+DxnyUqDsWupNAuHA9EPIDyz8GZG6Jpx0ETVlqZyYb?=
 =?iso-8859-1?Q?GpbiJrL2ScbvA12y7UlM++dOq8Io532/EyeE8yo0giOZSsDftWBrEmjlYx?=
 =?iso-8859-1?Q?Bl5t7roGSeJpNa3/5iffI07llBMCt3RBBPLfcHrR+RqAE1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NaTXCinFqiaYy8UriKkalt3D0kXOHJJkQfK+zK9g5ROEu515z5pVBB5RG6a7FlyQ/yBWSta5JhUX7UXwTE3GXSGdFFmj9DUduJiTtc9J8mRykwDme144vpYB5GpV8M87p9FDjqCDr+FtYCAmvjRQo9XewBUYxv3ZpfoCFhe5+4D/Tee13YeyidWU2sqz+XaVkiTQJfJ0LRUEiNmfS1yFaJg2cSU1t5Q9UBkA40BSmZ5G4o0mbqIZheFHF8KRKrae0ZEuJz1Gb9boo/KhLVvfs1mdlcW08pR97caYRUzHns+85q2Hpmhi7n1WGpeGAgZWx6OB7Ljk6uZr0Zm91sZ77Q==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bccc1d9-d2d0-4d50-af41-08df093ad281
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:35.3995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7zb2G+74YFXJ5OPYXoGetLYFX9WDxeu4tLrH03Zos0qAcVIvAR8Dy6Zg+xGoX1wW833STESvixKqMD0e7PD6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385243-pQz3uNqH9C3h
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385243;pQz3uNqH9C3h;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Both directions in one patch, since they share everything that matters.=0A=
=0A=
An input's frequency is what the board presents, so it is reported from=0A=
the firmware description rather than read back: the chip has no divider on=
=0A=
an input whose rate it merely qualifies.=0A=
=0A=
An output's frequency is the VCO divided by that output's divider, so it=0A=
is computed from the divider read back from the chip and set by writing a=
=0A=
new one.  The VCO in turn comes from the feedback divider, which is why=0A=
the crystal rate is needed at probe.  A divider write only takes effect=0A=
inside the programming state, and that state has to be left with the=0A=
output loops re-locked whatever happened in between, so the exit runs even=
=0A=
when a write in the middle failed and the first error is the one returned.=
=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 442 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c |  95 ++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  16 ++=0A=
 3 files changed, 553 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index e706f6942f65..721b2c451d59 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -339,6 +339,35 @@ static int sit9531x_output_forced_hiz(struct sit9531x_=
dev *sitdev, u8 slot,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Commit a programming sequence started by sit9531x_prg_enter():=0A=
+ * update the NVM shadow and re-lock the loops.  The sleep gives the=0A=
+ * hardware its required settling time after the loop-lock command;=0A=
+ * it is intentional despite the caller holding multiop_lock, as the=0A=
+ * whole NVM + lock sequence must be atomic.=0A=
+ */=0A=
+static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc, rc2;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_UPDATE_NVM);=0A=
+=0A=
+	/*=0A=
+	 * Issue the loop lock even if the update failed.  Callers reach=0A=
+	 * this function through a goto so that the chip never stays in=0A=
+	 * the PRG_CMD state with its loops open; returning early here=0A=
+	 * would defeat that and leave the outputs unlocked until the=0A=
+	 * next successful commit.=0A=
+	 */=0A=
+	rc2 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+				SIT9531X_LOOP_LOCK);=0A=
+=0A=
+	msleep(100);=0A=
+=0A=
+	return rc ? rc : rc2;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -725,6 +754,11 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
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
@@ -735,6 +769,414 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitd=
ev, u8 pll_idx,=0A=
 #define SIT9531X_FVCO_HIGHBAND_MIN		6875000000ULL=0A=
 #define SIT9531X_FVCO_HIGHBAND_MAX		7812500000ULL=0A=
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
+	*divn =3D sit9531x_divn_fixed(int_part, (s32)fracn_raw,=0A=
+				    (u64)fracd_raw + 1);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
+ *=0A=
+ * Fvco =3D Fref * DIVN, where DIVN comes from sit9531x_divn_static() and=
=0A=
+ * Fref =3D xtal_freq << doubler.  DIVN is the=0A=
+ * steady-state Fvco/Fref target programmed by the NVM blob and is=0A=
+ * authoritative in both free-run and sync modes; the previous split=0A=
+ * between free-run and sync formulas returned 0 on chips that didn't=0A=
+ * have a sync input populated, which broke the TDC phase readback.=0A=
+ *=0A=
+ * Return: Fvco in Hz, or 0 on error=0A=
+ */=0A=
+static u64 sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx)=0A=
+{=0A=
+	int doubler, rc;=0A=
+	s64 divn;=0A=
+	u64 fref;=0A=
+=0A=
+	/*=0A=
+	 * DT board-config override: some configs (e.g. an INTSYNC PLL)=0A=
+	 * run a VCO that Fref*DIVN does not reproduce.  When the board=0A=
+	 * supplies the measured VCO, use it verbatim.=0A=
+	 */=0A=
+	if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx])=0A=
+		return sitdev->pll_fvco[pll_idx];=0A=
+=0A=
+	rc =3D sit9531x_divn_static(sitdev, pll_idx, &divn);=0A=
+	if (rc || divn <=3D 0)=0A=
+		return 0;=0A=
+=0A=
+	doubler =3D sit9531x_is_xo_doubler_enabled(sitdev);=0A=
+	if (doubler < 0)=0A=
+		return 0;=0A=
+=0A=
+	fref =3D (u64)sitdev->xtal_freq << doubler;=0A=
+=0A=
+	return mul_u64_u64_div_u64(fref, (u64)divn, SIT9531X_DIVN_SCALE);=0A=
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
+ * The sequence mirrors the vendor procedure: arm the on-demand PHFL and=
=0A=
+ * latch it with the PLL-page small-change update, then select the=0A=
+ * in-register phase trigger on Page 0 and pulse it.  The Page 0 trigger=
=0A=
+ * register is touched read-modify-write so the unrelated OEb bits are=0A=
+ * preserved.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll=
_idx)=0A=
+{=0A=
+	u8 ctrl, orig;=0A=
+	int rc, ret;=0A=
+=0A=
+	/* Arm the on-demand phase-flush on the PLL page. */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Latch it with the PLL small-change update. */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				    SIT9531X_SMALL_UPDATE_CMD,=0A=
+				    SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Select the in-register phase trigger, preserving the OEb bits.=0A=
+	 * Remember the original register value (with the trigger de-asserted)=0A=
+	 * so the trigger-source select can be restored once the pulse has=0A=
+	 * fired.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	orig =3D ctrl & ~SIT9531X_DIVO_PHASE_TRIG;=0A=
+	ctrl =3D orig | SIT9531X_DIVO_PHASE_SEL_REG;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Pulse the phase trigger.  No explicit delay is needed between the=0A=
+	 * set and clear writes: each I2C transaction takes far longer than=0A=
+	 * any minimum pulse width.=0A=
+	 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,=0A=
+			       ctrl | SIT9531X_DIVO_PHASE_TRIG);=0A=
+=0A=
+	/*=0A=
+	 * Restore the original trigger-source select.  The pulse above has=0A=
+	 * already latched the flush, so a one-shot flush must not leave the=0A=
+	 * phase trigger permanently pinned to the in-register source.  This=0A=
+	 * runs even when the pulse write failed, otherwise a failed flush=0A=
+	 * would keep a hardware trigger source hijacked; the restore error=0A=
+	 * is only surfaced when it would not mask the pulse failure.=0A=
+	 */=0A=
+	ret =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_freq_set - set output clock frequency=0A=
+ * @out_idx:	output index (0-N for this chip variant)=0A=
+ * @pll_idx:	PLL driving this output (0-3)=0A=
+ * @frequency:	desired output frequency in Hz=0A=
+ *=0A=
+ * Computes DIVO =3D Fvco / frequency and writes the 34-bit output divider=
=0A=
+ * to the output system registers on Pages 3/4.  The write sequence is:=0A=
+ *   1. Unlock debug registers (Page 3)=0A=
+ *   2. Enter PRG_CMD state=0A=
+ *   3. Write 5-byte DIVO to the correct page/slot=0A=
+ *   4. NVM update=0A=
+ *   5. Loop lock=0A=
+ *   6. Wait for lock to settle=0A=
+ *   7. Flush the output phase so the new divider starts aligned=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error.  Actual frequency may differ=0A=
+ *         due to integer division; the output state is updated with=0A=
+ *         the effective frequency (Fvco / DIVO).=0A=
+ */=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, divo_bytes[5], msb_old;=0A=
+	u64 fvco, divo, fvco_min, fvco_max;=0A=
+	int rc, j, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs || pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (!frequency)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* Determine VCO frequency band limits */=0A=
+	if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3) {=0A=
+		/* PLLB, PLLD: high band */=0A=
+		fvco_min =3D SIT9531X_FVCO_HIGHBAND_MIN;=0A=
+		fvco_max =3D SIT9531X_FVCO_HIGHBAND_MAX;=0A=
+	} else {=0A=
+		/* PLLA, PLLC: low band */=0A=
+		fvco_min =3D SIT9531X_FVCO_LOWBAND_MIN;=0A=
+		fvco_max =3D SIT9531X_FVCO_LOWBAND_MAX;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Read current VCO frequency.  When the board supplies an explicit=0A=
+	 * Fvco via "sitime,pll-fvco" the override is the source of truth=0A=
+	 * (e.g. a chip variant that runs out of the documented band, or a=0A=
+	 * mode like INTSYNC where Fref*DIVN does not reproduce the VCO), so=0A=
+	 * skip the band clamp in that case.=0A=
+	 */=0A=
+	fvco =3D sit9531x_get_fvco(sitdev, pll_idx);=0A=
+	if (!fvco) {=0A=
+		fvco =3D fvco_min;=0A=
+	} else if (!sitdev->pll_fvco[pll_idx]) {=0A=
+		if (fvco < fvco_min)=0A=
+			fvco =3D fvco_min;=0A=
+		else if (fvco > fvco_max)=0A=
+			fvco =3D fvco_max;=0A=
+	}=0A=
+=0A=
+	divo =3D div64_u64(fvco, frequency);=0A=
+	if (!divo)=0A=
+		return -EINVAL;=0A=
+=0A=
+	dev_dbg(sitdev->dev,=0A=
+		"out%u: Fvco=3D%llu freq=3D%llu DIVO=3D%llu (effective %llu Hz)\n",=0A=
+		out_idx, fvco, frequency, divo, div64_u64(fvco, divo));=0A=
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
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_PRG_CMD_STATE);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	divo_bytes[0] =3D (divo >>  0) & 0xFF;=0A=
+	divo_bytes[1] =3D (divo >>  8) & 0xFF;=0A=
+	divo_bytes[2] =3D (divo >> 16) & 0xFF;=0A=
+	divo_bytes[3] =3D (divo >> 24) & 0xFF;=0A=
+	divo_bytes[4] =3D (divo >> 32) & 0x03;  /* only bits [1:0] */=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev,=0A=
+			      SIT9531X_REG(page, base_reg - 4), &msb_old);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	divo_bytes[4] |=3D msb_old & 0xFC;=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base_reg - j),=0A=
+				       divo_bytes[j]);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+	}=0A=
+=0A=
+commit:=0A=
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
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].freq =3D (u32)div64_u64(fvco, divo);=0A=
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
+ * Return: 0 on success, -ENODEV when the output divider or VCO rate=0A=
+ *	   is not resolvable, <0 on register access error=0A=
+ */=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, pll_idx, v;=0A=
+	u64 fvco, divo =3D 0;=0A=
+	int rc, j;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -ENODEV;=0A=
+=0A=
+	fvco =3D sit9531x_get_fvco(sitdev, pll_idx);=0A=
+	if (!fvco)=0A=
+		return -ENODEV;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	for (j =3D 4; j >=3D 0; j--) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j), &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (j =3D=3D 4)=0A=
+			v &=3D 0x03;=0A=
+		divo =3D (divo << 8) | v;=0A=
+	}=0A=
+=0A=
+	if (!divo)=0A=
+		return -ENODEV;=0A=
+=0A=
+	*frequency =3D div64_u64(fvco, divo);=0A=
+	sitdev->out[out_idx].freq =3D (u32)*frequency;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Phase adjust (PRG_RST_DELAY register-based).=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 67b9fbba9f2e..a7510ca721b6 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -302,6 +302,28 @@ sit9531x_dpll_input_pin_direction_get(const struct dpl=
l_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_frequency_get - read input pin frequency=0A=
+ *=0A=
+ * returns cached frequency from DT or last set.=0A=
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
@@ -497,6 +519,7 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin =
*pin, void *pin_priv,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
@@ -561,6 +584,7 @@ sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpl=
l_pin *pin,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
 };=0A=
 =0A=
@@ -576,8 +600,79 @@ sit9531x_dpll_output_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_get - read output pin frequency=0A=
+ *=0A=
+ * Reads the DIVO divider back from the chip and computes the live=0A=
+ * frequency as Fvco / DIVO.  Falls back to the cached value when the=0A=
+ * output is not resolvable through the divider chain (e.g. not mapped=0A=
+ * to a PLL), so a netlink dump never fails on such pins.=0A=
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
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		*frequency =3D sit9531x_out_state_get(sitdev, dpin->id)->freq;=0A=
+=0A=
+	return 0;=0A=
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
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index dd027142b370..031c1a460d4a 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -202,6 +202,10 @@=0A=
 /* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */=0A=
 #define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
 =0A=
+/* On-demand phase-flush enable (PLL page reg 0x3D bit 7) */=0A=
+#define SIT9531X_PLL_REG_PHFL_CTRL	0x3D=0A=
+#define SIT9531X_PLL_PHFL_ON_DEMAND_EN	BIT(7)=0A=
+=0A=
 /*=0A=
  * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +=0A=
  * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must =
not be=0A=
@@ -214,6 +218,18 @@=0A=
 #define SIT9531X_PLL_REG_STATUS		0x31=0A=
 #define SIT9531X_PLL_REG_NVM_UPDATE		0x3F=0A=
 =0A=
+/* DIVN registers (free-run divider readback) */=0A=
+#define SIT9531X_PLL_REG_DIVN_INT		0x30=0A=
+#define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
+#define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
+=0A=
+/*=0A=
+ * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
+ * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
+ */=0A=
+#define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
+#define SIT9531X_PPT_PER_UNIT		1000000000000ULL=0A=
+=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 #define SIT9531X_PLL_REG_ZDB0		0x2B=0A=
-- =0A=
2.43.0=0A=
=0A=
