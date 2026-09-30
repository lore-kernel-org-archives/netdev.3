Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97424B829B;
	Wed, 30 Sep 2026 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811455; cv=fail; b=mAdf6oUFEn45/w6E7V5Dlybu69W+Fqx1fxO8buVL3UmCwnsKdwyY4+EX7Vx9UVpjTjIYBQZWFLCyRBAQBCHfkAGnS7q9csIwAOsQNpDhwAR62r1ekR/eMiCYyly33NnG1wg7bUhkQZSt0MonZQleqa3SiKvLsAHMBneueLokgm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811455; c=relaxed/simple;
	bh=JrK5GT4VeJS+MCDF3zQ6YAM4CRQ0Q2WMXtWfq0xCxwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYqxQ8Vm0qZbwgHz23WjdaSLTU8pLZ4Ohbf2z6l/6yfSBPptHl77qCtNcar1bctqsHaGs5HSmv0jdL7V0+zsunIrPOMUt2+m+omGEBCElnyVvO3qCCUdIri4PzwNFRvfq1fVdJHXCc8LN4Z1VwzrmE3ZZjQJ98vCC0HFSPpnHT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=hzkOaXsh; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=eJ84Pgi4; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="hzkOaXsh";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="eJ84Pgi4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=9PSCGRR/zORETvNuOeQzO6FtFIp9RfIliqP0pfEPSQw=;
 b=hzkOaXshoXnlPqbDdofdtD+hHmcBAbHVwBci+NNZOV7EV9OUzyPNz5GyTNGjtd48b6PThnbCybP0xxw0ukjhBI6bIs+BiPwFhpzMxIWejuckdzEjfc8HzAan36yYOhpbkVl2j1leC9lsF2O9x1dLUwc6m/4aTuazxBZz7giciThm++t2OSfqe7jR1e8QivfTULurTboBfjCcOXCkwdrnzwRhFKU3oT9ydZaYY1nWM+De8+DHC1mMrf+ycelfqO4klgrtu31mXsBjp1wwK7cPprGoHy1Hl/zJp9W458phU7ypXG4pEpyCopZfi0HrwzeHZ1Cq/s9ljJLcASziLr/URQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 80DD110006C;
	Wed, 30 Sep 2026 23:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXmQieNg7eLC3fHgscT61RgLB/U1ZqZXAhU4NQBLy4rtgXhdULSAcqM4Y/Q6Q5VpdpREEfywM0lNXBYbOdRL7Ai7yXtNWPZLjeNewUrF0etm8HLhV7LPeN56jsJlx0hu9PsZUxG8r07hp4jGGBwcshw5xa9FXyX5jGP9Gt1rS82MtEDKiTp7eVn4j+LOatjOcqoH5n1OOxpVabQYTiLqVG5/RWy4RMSUmwd4Q2W9RYrhtCzWGA2BU3l81QZGpxymC6i8Gp9evz8e51YXQI1OSMyuUQpZ5HXHhpRcGXXls74LbJmELOuPmB/v5XA/nnCZa3pBPRUbKawWgdyBVFMyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PSCGRR/zORETvNuOeQzO6FtFIp9RfIliqP0pfEPSQw=;
 b=xAHp77Ud7fuNN3I9nz20s2a24I1Hmhh/HXPBok4tvUpdCMb3XbG38OOedhlTkggrIFm+ga5sgT+KD0QaWPbIFB1sNnAIIb9ha3Rnr7rod2khcAz+cZJ4pQuBQqeYcy1DqCtKEhqDaOsFWPdof3Oynq+qXzeFJNf26iCCnWy7Ea2zqBji0j6H5N/qN/gGs5F2zdjng57S0cv21cjwt5VP6AGBBJoXI5tlgEqnbNY+es0lWqidhOzCsyoAPfTjJyzXtX31V0LWzDlt/M8eJp7Rhv6iOL4v6jeoepyTMwnmTKAofHcsnEyLHHoN3YE8U9zdTYgmlQgKLpV/aT9tdvMTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PSCGRR/zORETvNuOeQzO6FtFIp9RfIliqP0pfEPSQw=;
 b=eJ84Pgi4haI7Qc090gjbth8ssJ5F8OChD4AOWNppFA/fwnQTQfsXTnMRrJ7u69/dpneVc+kOtWYmhq4lYYklIslbwIdr0Qk12RCNVI2Zv59EE2Pc0WVnfBGMJUqbhPTs7GLYGXGQlT0EZKN2tFNxmoocEKbTh/+epuQ6/hN5K9KteZ83HagVialFe5YV72Kv+F5Ks0zWIbd8T/VRYPrChFRbffZselRXe1PrsoWPdpaTpXPvJKVgjas2/rbc0Mj+LJy+BRK6YIHFJoK3rZQtsLu9ZHZysDZ6m8zhY8ad/a3TWeiwXbALIV4X1+jtbX0bgFb7UInq5HiV2KnIZsf1Eg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5383.namprd20.prod.outlook.com
 (2603:10b6:806:29e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:37:26 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:23 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 11/13] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v11 11/13] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdUTSkd5y/Ix0Z+0CNcg6LO2tBgQ==
Date: Wed, 30 Sep 2026 23:37:23 +0000
Message-ID: <20260930233714.87679-12-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB5383:EE_
x-ms-office365-filtering-correlation-id: 034f752f-1716-4018-aeb6-08df1f4bc71e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|3023799007|10067099003|260925021311599003|260925022911599003|5023799004|260925021911599003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 DhVtz6pQCtZDPEo5vURMbykhXuthKZEq3b2ci4G+33Cuc28WVG8SrqSLxQbCMgNwHybn3rY4Os84p6Ki3igLNjMUiwswUS9V5duWTRn6CuBuZN+cWY0XMEWWtjzoBjqwtmJH4GwsJG+kvag3QCWasl9FIo0mxx9kP6WLDyHRg3WA6zN49sWG97gsDvrSZkDfoboYi/ts3xEb7+WGehySFWdLh8X23KwPQ5q10CuwuSVkeGDj7Mzs4pMVGpTL4W3lZyidXeDNrgty6NWzWJc4fl53lSSiGZBYyBS04hcm5Qe4NZnfPlX975S2j+GJMUMFmkmgae2eu6wPkQJUty2to0Emd7TKM1fu85+BNWJrQ5IHDPeIyl+1wCyYQZjGneZlkUXJqpVwGRGo4P1rlG8LLQ5hHyGrCd2pfkp3dZFysDY7Aio7aP9DWQ3TEfobXWumW5bpA3LJrcLzcCqjwTqHs8IVids6e/12PiKbqKqcrYQQZSP2jJmghODVDah4yXLNVm7rBL8jaoG63qEqKBSXwnsVrY9+EHNaHdOI8gxRHXjLfByQmqexCvtZqUdj81/sVmIbOBiLX0bBDBHMOnBp9DqJg7l6KxBuEI3/senBfo+MNaxF9CtIwXDF+7e+uJAwpa7CULdCsmstTo16jq83nqMek3kW0jjXbkyZv3TAaBYc7zVQ/FuNSeDTwijMc1hK6jnHJR95f1F8UODCWX1FEGHUc3Wau4HmStxm+VKfC3w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(3023799007)(10067099003)(260925021311599003)(260925022911599003)(5023799004)(260925021911599003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NsjCQn+MpL0kfGCF54N/nXD7DAgZ8HSjwIA8SMPIJparLNpAkTpghKd8jb?=
 =?iso-8859-1?Q?ALIqyN3LtnQfopGWE+hh/9hLDrCn3X7LJt7GrCfF42xLopEmOPtyUjxxcK?=
 =?iso-8859-1?Q?+UFsBjR43W8am6GRVDgNW8eKmmOwvwXVtign0kIJt9R6IZXZ+pJ2kPDXWT?=
 =?iso-8859-1?Q?cPTh4wv5yfes5EC3BmTCBZvA/cR3TESP+V5piq1p61pKJlWGjwfX/NqPAo?=
 =?iso-8859-1?Q?O4LHiQa3dNCJxfQOJ7EZR9fcnlM/2/i6V17U5Kq8Vy5RGvYR+LRWy4gxCk?=
 =?iso-8859-1?Q?0Bo0RkCtGGtzHFP7SVgE0aE0uq2cV4CX+Voq48pkCSx/3st8bufV5uIV9o?=
 =?iso-8859-1?Q?o5Uh2tfbtXey2ON4CoWA+uijFWh4JPKbe330vLyAdmCh6E6y6IMtY9WI7v?=
 =?iso-8859-1?Q?FiS9ZDgrM7R6CLU+K7iYhCq5d06rp0cIsQU926aY50WDAauYkkfEqhHRXh?=
 =?iso-8859-1?Q?yg8NffvFX55x7/VmpUeZrLsSVJUFnX+SGYiUc5yVUPNyz9up0oOcBxiAjM?=
 =?iso-8859-1?Q?gzYokdyKpP71U8YBO+/5QZPHPnYCLi03EqDl4CghPxcvQaOIAMztIdjOPc?=
 =?iso-8859-1?Q?CgAico9M2jbx9nu2udnKLzhm4NIdpvkgggKq9TyaRnBpWpeyZua6LhnasD?=
 =?iso-8859-1?Q?7rWF6adlcv1kWKJaNw6TtpNmWXI024FYdBgYVWgOX4soJlKMxCsPBwgN1o?=
 =?iso-8859-1?Q?Toeyo3eGcQVRWWpXZFYV/JCdthln4XDXE8sstKp93UauffIAPGaPWgSqe8?=
 =?iso-8859-1?Q?F+e0qSjW/ir+SnSDW2lshWYUzYhmw2Cd9hTyGRlUm8OoMzV3e4xU3w5HEO?=
 =?iso-8859-1?Q?gjhJUzUskyzWZAcrMu+qJj/PUP4L0QVcQIMntXIEAsev2P9Rh8smAqk/pm?=
 =?iso-8859-1?Q?ffyYaEaZ/O7zgeFhWSDiVyruuubE2mPaWNcPMDxxsyhijsH6ByWrgsDkhs?=
 =?iso-8859-1?Q?AgEXdqmEiHz1gvCt8WywYymtkqc2O02JjMiOIea8DkDPxued9YBME2PXxv?=
 =?iso-8859-1?Q?VAFpTCuor85g1mBh0YnaoHLebbcSatK3o4UE7V5ZUoRxLN7a2m43vWeuF2?=
 =?iso-8859-1?Q?It4zrzor3EYq+dxIy4WfuC+r7ma6ay2GeBkm+ZXvnpcVcUdDZfwGmYphvP?=
 =?iso-8859-1?Q?RK96VX3o3o0Ke7s2otSHZBD9PK9sNlGU+l+t+D/R1Xvn+4NzBhtBLEDOjZ?=
 =?iso-8859-1?Q?LGEqewJE3qoInIZVq0xB9rwjFyWH/8/9EKOyTeAWEi+BP05vbhrJaidX8h?=
 =?iso-8859-1?Q?q3fLPv1sRfNSWSpJUlHTupcyqEr6qjNQfq0gl6H8wbkP71f9zt31yN3jKa?=
 =?iso-8859-1?Q?zhOywbplUEZ+X6k2RLebztR5dXBX7Fw2yFQHH+DrN2Qxlt7QLBix+v6s7G?=
 =?iso-8859-1?Q?yFdMWSd2kX8VPjG0qTnCQkWKs5bYpxSHuvctbauoHuEMCg88uubVhBrd4r?=
 =?iso-8859-1?Q?jbInxGI3BC8I6l1MMKGV2w6oMwR+NFn+XdeAl0iQaE7XYuXsS8dz96wsbg?=
 =?iso-8859-1?Q?Z+L36ely2+1+4+u0xCj3E9mAgkFd0rD3iVUPJKWj+rC6Q0/Y8UYfaxyBOb?=
 =?iso-8859-1?Q?BwKktMoJHbOCQQWhDGgsGy/4Jq1/LIgvyfXg8xORZHBx86mqD5l/uFDVru?=
 =?iso-8859-1?Q?2pUTFxTedm+5QapCUS2sT17eoVxpGWXeBUrSfgcW9JJ4JEOo0lwLfKzzPs?=
 =?iso-8859-1?Q?D6g+alm9Sc/hlw/WRaHTYg9N8Hpa3f4y6hDHA4KVtxuVdhrDQutQw3omJQ?=
 =?iso-8859-1?Q?fDE52aTxACCdK4ALkcb9XMvh24bmwRX58SepfLuYx7dhaD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	g25OQDhuUuO4rEa9jz7HPtVt/ZeJ3XJSbLgfY5YGSJVkkFHO1vQuiFr//6+ofTaFobHFY1dWKpohXeDyapxo9yC2Z1bEPuROVKg8p6SHvs+parP+vQYSSS8eZs1++Hp9gTXljPKSnx8QCG1PV9UEhtfPB/cgAE2/lTspSGWB8AZ3hTR9n0qmJwPxfC/PVdL3ZYKo5pbvPYCB4ZaEt82iVwdp6Rg1fwmXV1WjkeIJkbMU+JQu9v5Hgy4HBys5hLWBDmwyE9NkiUdAMKiaYt3eNUVPZNrFkbVuMgQxxGcXmW+UPvqk/tj0YFDRGqain0iKMIlY+uTN/MOJYNMWp577pQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034f752f-1716-4018-aeb6-08df1f4bc71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:23.3214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wahg5fcMwhxkAYGPOsTD8UQiqNjyZueDt1MOvkv3aa2j8Q+69c6M5r5vrdT2FESWnAJGOuWSioxOxLotykLp7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383
X-MDID: 1790811450-p4iQD2j9LUgA
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811450;p4iQD2j9LUgA;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Shift an output in time against the others driven by the same PLL.  The=0A=
device has a coarse delay counted in VCO cycles and a three-bit fine field=
=0A=
in fixed thirty-picosecond steps, so a requested offset is split between=0A=
the two and what the core reads back is what the registers hold rather=0A=
than what was asked for.  The divider spends two VCO cycles acting on a=0A=
programmed delay before it releases the output, so the registers hold the=
=0A=
request plus those two cycles and the read-back takes them off again.=0A=
=0A=
The window advertised to the core is one millisecond either way, which is=
=0A=
wider than the dynamic range but costs nothing and is what keeps the=0A=
subsystem from refusing every request; the granularity is one picosecond,=
=0A=
because the achievable delays are whole VCO cycles plus thirty-picosecond=
=0A=
steps and so form no uniform lattice for the core to check against.=0A=
=0A=
Delay only ever advances, so an offset larger than one output period is=0A=
folded back into a single period -- for a periodic signal that is the same=
=0A=
phase.  The write takes effect in the programming state, which is left=0A=
with the loops re-locked even when a write inside it failed.=0A=
=0A=
The device has no per-output phase flush, so realigning the adjusted=0A=
output restarts the divider phase of every output that PLL drives.  On a=0A=
part where outputs are deliberately skewed against each other that is a=0A=
visible edge jump on the others, and there is no register that would let=0A=
the driver avoid it.=0A=
=0A=
Suggested-by: Ivan Vecera <ivecera@redhat.com>=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 435 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |  16 ++=0A=
 drivers/dpll/sit9531x/dpll.c |  78 +++++++=0A=
 drivers/dpll/sit9531x/prop.c |  20 ++=0A=
 drivers/dpll/sit9531x/regs.h |  36 +++=0A=
 5 files changed, 579 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 8fed14d8dca6..d2719ff24249 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -2183,6 +2183,110 @@ static int sit9531x_output_divo_read(struct sit9531=
x_dev *sitdev, u8 out_idx,=0A=
 	return *divo ? 0 : -ENODATA;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * sit9531x_output_phase_read - read an output's programmed delay back=0A=
+ * @sitdev:	device pointer=0A=
+ * @out_idx:	logical output index=0A=
+ * @phase_ps:	result in picoseconds, in the advertised range=0A=
+ *=0A=
+ * The delay the chip holds is part of the profile it loads before probe,=
=0A=
+ * and a rate or phase request that failed after its writes reached the=0A=
+ * device leaves the cache describing something else.  Decoding the five=
=0A=
+ * PRG_RST_DELAY bytes is the only way to say what the output is really=0A=
+ * doing.  The registers carry an unsigned delay; one beyond the=0A=
+ * advertised range whose complement to the output period is within it is=
=0A=
+ * how an advance is held, and reads back as that advance.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA for an output no PLL drives or whose VCO=
=0A=
+ * rate is unknown, <0 on register access error=0A=
+ */=0A=
+int sit9531x_output_phase_read(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			       s32 *phase_ps)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 bytes[5], page, base, slot, fine, i;=0A=
+	u64 coarse =3D 0, fvco, ps, divo;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * An output no PLL drives has no Fvco to decode its delay against;=0A=
+	 * pll_idx then holds a placeholder, not a routing.=0A=
+	 */=0A=
+	if (!sitdev->out[out_idx].routed)=0A=
+		return -ENODATA;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, sitdev->out[out_idx].pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	base =3D SIT9531X_OUT_PRG_DELAY_BASE +=0A=
+	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(bytes); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, base + i),=0A=
+				      &bytes[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	fine =3D (bytes[0] & SIT9531X_OUT_PRG_FINE_MASK) >>=0A=
+	       SIT9531X_OUT_PRG_FINE_SHIFT;=0A=
+	coarse =3D (u64)(bytes[0] & SIT9531X_OUT_PRG_COARSE_HI_MASK) << 32;=0A=
+	coarse |=3D (u64)bytes[1] << 24;=0A=
+	coarse |=3D (u64)bytes[2] << 16;=0A=
+	coarse |=3D (u64)bytes[3] << 8;=0A=
+	coarse |=3D bytes[4];=0A=
+=0A=
+	/*=0A=
+	 * The register carries the divider's settling time on top of the=0A=
+	 * delay that was asked for, so take it back off.  A profile can=0A=
+	 * leave a value below it, which describes no delay at all.=0A=
+	 */=0A=
+	coarse =3D (coarse > SIT9531X_OUT_PRG_DIVO_CYCLES) ?=0A=
+		 coarse - SIT9531X_OUT_PRG_DIVO_CYCLES : 0;=0A=
+=0A=
+	ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	ps +=3D (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;=0A=
+=0A=
+	/*=0A=
+	 * The setter holds an advance as T_out - |advance|, so a delay=0A=
+	 * beyond the advertised range whose complement is within it is that=0A=
+	 * advance and reads back as one.  Anything else a profile left=0A=
+	 * beyond the range -- wider than an s32 on a slow output -- reports=0A=
+	 * the end of the range rather than a value the setter would refuse.=0A=
+	 *=0A=
+	 * The period comes from the divider rather than from the cached rate,=0A=
+	 * which is still unset at probe and whole hertz at best.  An output=0A=
+	 * without a programmed divider has no period to fold against.=0A=
+	 */=0A=
+	if (!sit9531x_output_divo_read(sitdev, out_idx, &divo)) {=0A=
+		u64 t_out_ps =3D mul_u64_u64_div_u64(divo, 1000000000000ULL,=0A=
+						   fvco);=0A=
+=0A=
+		if (t_out_ps) {=0A=
+			div64_u64_rem(ps, t_out_ps, &ps);=0A=
+			if (ps > SIT9531X_OUT_PHASE_ADJ_MAX_PS &&=0A=
+			    t_out_ps - ps <=3D SIT9531X_OUT_PHASE_ADJ_MAX_PS) {=0A=
+				*phase_ps =3D -(s32)(t_out_ps - ps);=0A=
+				return 0;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	*phase_ps =3D (s32)min_t(u64, ps, SIT9531X_OUT_PHASE_ADJ_MAX_PS);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
 			     u8 pll_idx, u64 frequency)=0A=
 {=0A=
@@ -2236,7 +2340,38 @@ int sit9531x_output_freq_set(struct sit9531x_dev *si=
tdev, u8 out_idx,=0A=
 =0A=
 	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
 =0A=
-	return 0;=0A=
+	/*=0A=
+	 * The programmed reset delay counts VCO cycles, and a rate change=0A=
+	 * moves only the divider, so a positive delay keeps its timing; an=0A=
+	 * advance, though, is held as T_out - |advance| and has to be=0A=
+	 * re-encoded against the new period.  Re-encode whatever was asked=0A=
+	 * for: for a positive delay that lands on the same register bytes,=0A=
+	 * and sit9531x_output_phase_adjust_set() then writes nothing.=0A=
+	 */=0A=
+	if (sitdev->out[out_idx].phase_armed) {=0A=
+		s32 phase_ps =3D sitdev->out[out_idx].phase_adj;=0A=
+		int ph_rc;=0A=
+=0A=
+		/*=0A=
+		 * The rate is already programmed and latched at this point.=0A=
+		 * Failing the request for a re-timing that did not take=0A=
+		 * would report a frequency set that did not happen, and the=0A=
+		 * core drops an identical retry because it asks the driver=0A=
+		 * for the current rate first -- which is the new one.  Say=0A=
+		 * what went wrong and mark the delay for a read-back=0A=
+		 * instead.=0A=
+		 */=0A=
+		ph_rc =3D sit9531x_output_phase_adjust_set(sitdev, out_idx,=0A=
+							 phase_ps);=0A=
+		if (ph_rc) {=0A=
+			sitdev->out[out_idx].phase_stale =3D true;=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "out%u: rate changed but the phase adjust was not re-timed (%d)\n",=
=0A=
+				 out_idx, ph_rc);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -2304,14 +2439,277 @@ int sit9531x_output_freq_get(struct sit9531x_dev *=
sitdev, u8 out_idx,=0A=
  *   base + 3  PROG3  PRG_RST_DELAY[15:8]=0A=
  *   base + 4  PROG2  PRG_RST_DELAY[7:0]=0A=
  *=0A=
- * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each=0A=
- * output's block at base =3D 0x15 + 16 * (out_idx % 6).=0A=
+ * Slots 0-5 live on Page 3, slots 6-11 on Page 4, with each slot's=0A=
+ * block at base =3D 0x15 + 16 * (slot % 6); the slot is the physical=0A=
+ * output position from clkout_map[], not the logical output index.=0A=
  *=0A=
- * The chip only supports unsigned positive delay.  A negative phase=0A=
- * adjustment (advance) is wrapped to (T_out - |phase|) modulo one=0A=
- * output period, which is identical for a periodic signal.=0A=
+ * The chip only supports unsigned positive delay.  Requests are folded=0A=
+ * modulo one output period: positive delays wrap naturally and a negative=
=0A=
+ * phase adjustment (advance) is rendered as (T_out - |phase|).=0A=
  */=0A=
 =0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 abs_ps, fvco, coarse =3D 0, coarse_ps, t_out_ps, prg_coarse;=0A=
+	s64 phase_norm_ps =3D 0;=0A=
+	u8 page, base, prog6_val, fine =3D 0;=0A=
+	u8 old_bytes[5], new_bytes[5], i;=0A=
+	u8 pll_idx, slot;=0A=
+	u64 divo;=0A=
+	int rc, ret, rb_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	/*=0A=
+	 * The output period comes from the divider the output runs on, not=0A=
+	 * from the cached rate: that is whole hertz, so a profile's output at=0A=
+	 * a fractional rate would fold an advance against the wrong period.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_divo_read(sitdev, out_idx, &divo);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	t_out_ps =3D mul_u64_u64_div_u64(divo, 1000000000000ULL, fvco);=0A=
+	if (!t_out_ps)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Convert to unsigned absolute delay.  Both signs are folded=0A=
+	 * modulo one period: positive delays wrap naturally, negative=0A=
+	 * delays are rendered as T_out - |phase|.  abs() is safe here=0A=
+	 * because the core rejects anything outside the advertised phase=0A=
+	 * range, which is +/-1 ms.  div64_u64_rem() rather than the %=0A=
+	 * operator: a 64-bit modulo has no compiler helper on 32-bit=0A=
+	 * targets and leaves the module with an undefined __umoddi3.=0A=
+	 */=0A=
+	abs_ps =3D abs(phase_ps);=0A=
+	div64_u64_rem(abs_ps, t_out_ps, &abs_ps);=0A=
+	phase_norm_ps =3D phase_ps < 0 ? -(s64)abs_ps : (s64)abs_ps;=0A=
+	abs_ps =3D (phase_ps < 0 && abs_ps) ? t_out_ps - abs_ps : abs_ps;=0A=
+=0A=
+	if (abs_ps) {=0A=
+		u64 rem_ps, err, up_ps;=0A=
+=0A=
+		/*=0A=
+		 * coarse_cycles =3D abs_ps * Fvco / 1e12 ps/s.=0A=
+		 * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches=0A=
+		 * one second of 1 PPS wrap-around.=0A=
+		 */=0A=
+		coarse =3D mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);=0A=
+=0A=
+		/*=0A=
+		 * Fine =3D round((abs_ps - coarse * vco_period_ps) / 30 ps).=0A=
+		 * The fine field tops out below one VCO period on a slow VCO,=0A=
+		 * so one more coarse cycle can land closer than the capped=0A=
+		 * fine field; take whichever of the two is nearer.=0A=
+		 */=0A=
+		coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+		rem_ps =3D (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;=0A=
+		if (rem_ps) {=0A=
+			u64 steps;=0A=
+=0A=
+			steps =3D div64_u64(rem_ps +=0A=
+					  SIT9531X_OUT_PRG_FINE_STEP_PS / 2,=0A=
+					  SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
+			if (steps > SIT9531X_OUT_PRG_FINE_MAX)=0A=
+				steps =3D SIT9531X_OUT_PRG_FINE_MAX;=0A=
+			fine =3D (u8)steps;=0A=
+		}=0A=
+		err =3D abs_diff(abs_ps, coarse_ps +=0A=
+			       (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
+		up_ps =3D mul_u64_u64_div_u64(coarse + 1, 1000000000000ULL,=0A=
+					    fvco);=0A=
+		if (up_ps - abs_ps < err) {=0A=
+			coarse++;=0A=
+			fine =3D 0;=0A=
+		}=0A=
+=0A=
+		/*=0A=
+		 * A delay that quantizes to a whole output period or beyond=0A=
+		 * is the same edge as no delay at all; program none, so the=0A=
+		 * registers hold no residual past the period and the cache=0A=
+		 * below describes exactly what they realize.=0A=
+		 */=0A=
+		coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+		if (coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS >=3D=0A=
+		    t_out_ps) {=0A=
+			coarse =3D 0;=0A=
+			fine =3D 0;=0A=
+		}=0A=
+=0A=
+		if (coarse + SIT9531X_OUT_PRG_DIVO_CYCLES >=3D=0A=
+		    (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))=0A=
+			return -ERANGE;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Map logical output index to the chip's physical output slot.=0A=
+	 * On SiT95317 the eight logical outputs land on chip slots=0A=
+	 * {0, 3, 4, 5, 7, 8, 9, 11}; on SiT95316 the map is identity.=0A=
+	 * Page/base must address the slot, not the logical index.=0A=
+	 */=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	base =3D SIT9531X_OUT_PRG_DELAY_BASE +=0A=
+	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(old_bytes); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, base + i),=0A=
+				      &old_bytes[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Carry the divider's own settling time.  Everything above works in=0A=
+	 * the delay the caller asked for; the register wants that plus the=0A=
+	 * two VCO cycles the divider spends acting on it, and a request of=0A=
+	 * zero still waits those two.  Only the register value carries them:=0A=
+	 * coarse stays the requested delay, which is what gets cached.=0A=
+	 */=0A=
+	prg_coarse =3D coarse + SIT9531X_OUT_PRG_DIVO_CYCLES;=0A=
+=0A=
+	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */=0A=
+	prog6_val =3D old_bytes[0] & SIT9531X_OUT_PRG_OPSTG_MASK;=0A=
+	prog6_val |=3D (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &=0A=
+		     SIT9531X_OUT_PRG_FINE_MASK;=0A=
+	prog6_val |=3D (u8)((prg_coarse >> 32) & SIT9531X_OUT_PRG_COARSE_HI_MASK)=
;=0A=
+=0A=
+	new_bytes[0] =3D prog6_val;=0A=
+	new_bytes[1] =3D (u8)((prg_coarse >> 24) & 0xFF);=0A=
+	new_bytes[2] =3D (u8)((prg_coarse >> 16) & 0xFF);=0A=
+	new_bytes[3] =3D (u8)((prg_coarse >> 8) & 0xFF);=0A=
+	new_bytes[4] =3D (u8)(prg_coarse & 0xFF);=0A=
+=0A=
+	/*=0A=
+	 * The pin advertises 1 ps granularity but caches the quantized=0A=
+	 * value, so a repeated off-grid request reaches here with the=0A=
+	 * registers already holding it.  Rewriting them would still restart=0A=
+	 * the divider phase of every output on the PLL; skip it unless an=0A=
+	 * earlier failure left the delay unconfirmed.=0A=
+	 */=0A=
+	if (!memcmp(old_bytes, new_bytes, sizeof(new_bytes)) &&=0A=
+	    !sitdev->out[out_idx].phase_stale)=0A=
+		goto cache;=0A=
+=0A=
+	/*=0A=
+	 * The PRG_RST_DELAY bytes live in the output system, so the writes=0A=
+	 * only take effect when made inside the PRG_CMD programming state and=0A=
+	 * committed to the NVM shadow, exactly like sit9531x_output_freq_set().=
=0A=
+	 */=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(new_bytes); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base + i),=0A=
+				       new_bytes[i]);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+	}=0A=
+=0A=
+	goto commit;=0A=
+=0A=
+rollback:=0A=
+	rb_rc =3D 0;=0A=
+	for (i =3D 0; i < ARRAY_SIZE(old_bytes); i++) {=0A=
+		ret =3D sit9531x_write_u8(sitdev,=0A=
+					SIT9531X_REG(page, base + i),=0A=
+					old_bytes[i]);=0A=
+		if (ret && !rb_rc)=0A=
+			rb_rc =3D ret;=0A=
+	}=0A=
+	if (rb_rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"out%u: phase-adjust rollback failed (%d), the delay registers are part=
 old and part new\n",=0A=
+			out_idx, rb_rc);=0A=
+		if (!rc)=0A=
+			rc =3D rb_rc;=0A=
+	}=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD state via prg_commit(), even on a=0A=
+	 * mid-sequence write failure, so the output loops are re-locked rather=
=0A=
+	 * than stranded unlocked; keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The delay registers were written and the rollback may not=0A=
+		 * have put all of them back, so what the output realizes is=0A=
+		 * no longer what the cache says.  Mark it so the getter reads=0A=
+		 * the registers instead of reporting the value that was=0A=
+		 * cached before this call.=0A=
+		 */=0A=
+		sitdev->out[out_idx].phase_stale =3D true;=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Restart the output divider phase so the freshly programmed delay is=0A=
+	 * applied against a known edge instead of the divider's arbitrary=0A=
+	 * running phase.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc) {=0A=
+		/* The delay is programmed but not re-timed; same reasoning. */=0A=
+		sitdev->out[out_idx].phase_stale =3D true;=0A=
+		return rc;=0A=
+	}=0A=
+	sitdev->out[out_idx].phase_stale =3D false;=0A=
+=0A=
+cache:=0A=
+	/*=0A=
+	 * Cache what the registers realize, and only once every step has=0A=
+	 * succeeded: the core drops a repeated request with the same value,=0A=
+	 * so a cache updated by a failed call would make the retry a no-op.=0A=
+	 * The encoding above keeps the realized delay below one period.=0A=
+	 */=0A=
+	coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	abs_ps =3D coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;=0A=
+	/*=0A=
+	 * Quantization can also land a few picoseconds past the end of the=0A=
+	 * advertised range, which the getter must not report.  Bound both=0A=
+	 * signs to the range; the positive one is also what keeps the cast=0A=
+	 * to the s32 the ABI carries safe.=0A=
+	 */=0A=
+	if (phase_norm_ps < 0)=0A=
+		sitdev->out[out_idx].phase_adj =3D=0A=
+			abs_ps ? -(s32)min_t(u64, t_out_ps - abs_ps,=0A=
+					     SIT9531X_OUT_PHASE_ADJ_MAX_PS) : 0;=0A=
+	else=0A=
+		sitdev->out[out_idx].phase_adj =3D=0A=
+			(s32)min_t(u64, abs_ps, SIT9531X_OUT_PHASE_ADJ_MAX_PS);=0A=
+=0A=
+	/*=0A=
+	 * Record whether a delay was asked for, whatever it quantized to: an=0A=
+	 * advance is held as T_out - |advance|, which the rate change that=0A=
+	 * follows has to re-encode against the new period.  A request of 0=0A=
+	 * leaves nothing to re-time.=0A=
+	 */=0A=
+	sitdev->out[out_idx].phase_armed =3D phase_norm_ps !=3D 0;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_clear_notifications - clear all notification registers=0A=
  *=0A=
@@ -2753,12 +3151,37 @@ static int sit9531x_dev_state_fetch(struct sit9531x=
_dev *sitdev)=0A=
 	}=0A=
 =0A=
 	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		s32 phase_ps;=0A=
+=0A=
 		rc =3D sit9531x_out_state_fetch(sitdev, i);=0A=
 		if (rc) {=0A=
 			dev_err(sitdev->dev,=0A=
 				"Failed to fetch output %u state: %d\n", i, rc);=0A=
 			return rc;=0A=
 		}=0A=
+=0A=
+		/*=0A=
+		 * The delay registers are part of the profile the chip loads=0A=
+		 * before probe, so an output can already carry one.  Seeding=0A=
+		 * the cache from the device is what lets a request of 0 ps=0A=
+		 * clear it: the core drops a request equal to what the=0A=
+		 * getter reports, and a cache that started at zero would=0A=
+		 * make clearing a programmed delay impossible.  An output=0A=
+		 * the configuration does not route has no Fvco to decode=0A=
+		 * against, which is not an error here.=0A=
+		 */=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_phase_read(sitdev, i, &phase_ps);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (!rc) {=0A=
+			sitdev->out[i].phase_adj =3D phase_ps;=0A=
+			sitdev->out[i].phase_armed =3D !!phase_ps;=0A=
+		} else if (rc !=3D -ENODATA) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to read output %u delay: %d\n",=0A=
+				i, rc);=0A=
+			return rc;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 8e1378d04b77..66c87e8f0387 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -27,6 +27,8 @@=0A=
 #define SIT9531X_MAX_INPUTS		8=0A=
 #define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
 #define SIT9531X_MAX_OUTPUTS		12=0A=
+/* Output phase-adjust range advertised to the core, +/-1 ms in ps */=0A=
+#define SIT9531X_OUT_PHASE_ADJ_MAX_PS	1000000000=0A=
 /*=0A=
  * INTSYNC (the inter-PLL sync net) is modeled as two pins.  The=0A=
  * destination PLL that locks to INTSYNC sees an input pin=0A=
@@ -104,6 +106,13 @@ struct sit9531x_ref {=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
+ * @phase_stale:	the programmed delay may differ from @phase_adj=0A=
+ * @phase_armed:	a phase adjust has been programmed, so a rate=0A=
+ *			change has to re-time it even when it quantized=0A=
+ *			to zero=0A=
+ * @phase_adj:		phase adjust the delay registers actually realize,=0A=
+ *			i.e. the last request quantized to whole VCO cycles=0A=
+ *			plus 30 ps fine steps, in the request's sign=0A=
  */=0A=
 struct sit9531x_out {=0A=
 	u64		freq;=0A=
@@ -112,6 +121,9 @@ struct sit9531x_out {=0A=
 	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
+	s32		phase_adj;=0A=
+	bool		phase_armed;=0A=
+	bool		phase_stale;=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -273,6 +285,10 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitd=
ev, u8 out_idx,=0A=
 			     u64 *frequency);=0A=
 =0A=
 /* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */=0A=
+int sit9531x_output_phase_read(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			       s32 *phase_ps);=0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps);=0A=
 =0A=
 /* ---- Notification clear ---- */=0A=
 int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index ac2d977d36f7..8a5e3a1decd0 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -851,12 +851,90 @@ sit9531x_dpll_output_pin_state_on_dpll_set(const stru=
ct dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustmen=
t=0A=
+ *=0A=
+ * Returns what the delay registers hold, i.e. the value=0A=
+ * sit9531x_output_phase_adjust_set() programmed after quantization, read=
=0A=
+ * from the cache unless a failed request left it unconfirmed.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 *phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	/*=0A=
+	 * A request whose writes reached the device but whose commit or=0A=
+	 * phase flush failed left the cache describing the delay before it.=0A=
+	 * There is no poll of the delay registers to correct that, so read=0A=
+	 * them here rather than report a value the output is not using.=0A=
+	 */=0A=
+	if (sitdev->out[dpin->id].phase_stale) {=0A=
+		s32 phase_ps;=0A=
+=0A=
+		rc =3D sit9531x_output_phase_read(sitdev, dpin->id, &phase_ps);=0A=
+		if (rc) {=0A=
+			mutex_unlock(&sitdev->multiop_lock);=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Output delay could not be read back");=0A=
+			return rc;=0A=
+		}=0A=
+		sitdev->out[dpin->id].phase_adj =3D phase_ps;=0A=
+		sitdev->out[dpin->id].phase_armed =3D !!phase_ps;=0A=
+		sitdev->out[dpin->id].phase_stale =3D false;=0A=
+	}=0A=
+	*phase_adjust =3D sit9531x_out_state_get(sitdev, dpin->id)->phase_adj;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_set - set output phase adjustment=
=0A=
+ *=0A=
+ * Programs the per-output PRG_RST_DELAY registers for deterministic=0A=
+ * phase offset; see sit9531x_output_phase_adjust_set() in core.c.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adjust);=
=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Phase adjust failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
+	.phase_adjust_get	=3D sit9531x_dpll_output_pin_phase_adjust_get,=0A=
+	.phase_adjust_set	=3D sit9531x_dpll_output_pin_phase_adjust_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 42f3e53b6def..02181e8bbaf8 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -228,6 +228,26 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 		props->dpll_props.capabilities =3D=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D sitdev->out[index].freq;=0A=
+=0A=
+		/*=0A=
+		 * Allow phase-adjust over a +/-1 ms window.  The subsystem=0A=
+		 * rejects pin_set(phase-adjust, X) when X falls outside=0A=
+		 * [min, max], so leaving these at 0 silently blocks every=0A=
+		 * netlink call.  1 ms is well beyond the DCO dynamic range=0A=
+		 * but costs nothing.  Only outputs get a range: input pins=0A=
+		 * have no .phase_adjust_set, and advertising one there would=0A=
+		 * promise userspace something every set would refuse.=0A=
+		 */=0A=
+		props->dpll_props.phase_range.min =3D=0A=
+			-SIT9531X_OUT_PHASE_ADJ_MAX_PS;=0A=
+		props->dpll_props.phase_range.max =3D=0A=
+			SIT9531X_OUT_PHASE_ADJ_MAX_PS;=0A=
+		/*=0A=
+		 * The fine step is 30 ps, but requests are accepted at 1 ps=0A=
+		 * resolution and rounded to the nearest achievable delay, so=0A=
+		 * advertise the request granularity, not the hardware step.=0A=
+		 */=0A=
+		props->dpll_props.phase_gran =3D 1;=0A=
 	}=0A=
 =0A=
 	/* Generate package label */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index d2e1ac547cbc..b805cbc41fc1 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -202,6 +202,42 @@=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
 #define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
+/*=0A=
+ * Per-output programmable phase delay: 34-bit coarse (in VCO clock=0A=
+ * cycles) plus a 3-bit fine field with fixed 30 ps steps.  Each output=0A=
+ * has a five-byte block PROG6..PROG2:=0A=
+ *=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserve via RMW)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY[2:0]=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  [7:0] PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  [7:0] PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  [7:0] PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  [7:0] PRG_RST_DELAY[7:0]=0A=
+ *=0A=
+ * Slots 0-5 are on Page 3, slots 6-11 on Page 4.  The block base=0A=
+ * within a page is 0x15 + 16 * (slot % 6), where slot is the physical=0A=
+ * output slot from clkout_map[], not the logical output index.=0A=
+ */=0A=
+#define SIT9531X_OUT_PRG_DELAY_BASE		0x15=0A=
+#define SIT9531X_OUT_PRG_SLOT_STRIDE		0x10=0A=
+/* bits [7:5], preserve */=0A=
+#define SIT9531X_OUT_PRG_OPSTG_MASK		0xE0=0A=
+#define SIT9531X_OUT_PRG_FINE_SHIFT		2=0A=
+#define SIT9531X_OUT_PRG_FINE_MASK		0x1C	/* bits [4:2] */=0A=
+#define SIT9531X_OUT_PRG_COARSE_HI_MASK		0x03	/* bits [1:0] */=0A=
+/*=0A=
+ * The divider takes two VCO cycles to act on a programmed delay and=0A=
+ * release the output, so the encoded value carries them and the realized=
=0A=
+ * delay is the register value less that.  The reference flow adds the=0A=
+ * same two.=0A=
+ */=0A=
+#define SIT9531X_OUT_PRG_DIVO_CYCLES	2=0A=
+=0A=
+#define SIT9531X_OUT_PRG_FINE_STEP_PS		30=0A=
+#define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */=0A=
+#define SIT9531X_OUT_PRG_COARSE_BITS		34=0A=
+=0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
  * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
-- =0A=
2.43.0=0A=
=0A=
