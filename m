Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7694F5DEE;
	Fri,  9 Oct 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570220; cv=fail; b=Pqbd7yLbVrchiLiA9wPN3AwKIj5BFrnoANkKfOydzGu6bNJ0R+syHK/xzGiypk2tj8PwN5X2NqPA5vt50C8NNYOJ9iEfyEnRUTb/Ma2Mg/UEnIirPRFXAx30/0UVboTcXJ5TL/yoXbQ7Yep44mIG0EIX3YVGo4t7vHI9AijSyOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570220; c=relaxed/simple;
	bh=GwzplQBweKIvxt3Ng6VMlNthM/avwgvQOnsEYUgIUu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0MdIUWQM4JxssOd/n3jCEVxYAUCmPNPTawyWZiNdNlHA7Sm29MjleKhg0JaU9435zmNo5LbvbG81yDvMLe79G1fCa5Hny8rNqWV7fSm5KnQ6lIZLjAeZTJEuyqc9ajZdWuVzdXtq0yDF+e/jB4RqSBMmUa4SJRl9SqOWWSpggc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=d0bDgnQh; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=BXBEtrU3; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="d0bDgnQh";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="BXBEtrU3"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9E23024D78F;
	Fri,  9 Oct 2026 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=GwzplQBweKIvxt3Ng6VMlNthM/avwgvQOnsEYUgIUu0=;
 b=d0bDgnQhrpzSBYa7EWmJP4Y5jzOoKp3XBweo6eNWnRUm8pPzoLzZvBXm5OLKlPbQ0Z8bSX20Ic8tCU2Uomps7X5NquaYpXRU5nDKoDViFARgHmiopaaF+FPp500SkVhutHNzBWjNXm8W2CCgVPING/lxQnfkvC5muF/358U2RN1p87GnoemcxrQDowgdwpPJctxcismgsHqZ8YSsdfI3FviTX3+Pw21jtEmeihv11OO4t1nOmvAonrIrzsAwzfHAwaO3Q0+bPD0fd8+6KrPmgoih2sx6KKG9LCCOVoguRr5wkx0PFEes3mUJY7P+4yluHDJuTgjLvZe9maB6EpCPzA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022092.outbound.protection.outlook.com [40.107.209.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 080E6100075;
	Fri,  9 Oct 2026 18:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKqUIME1Z9KyOjXtobn4u/O2QMxI5ZbIg7Y+DyIR1d7Yymnga3e7H6Dhf0a6O9z3R3McP3WolfejoY+2fSPs/V00VwL84BiiJnfdBF9e4Zx4OQRgJYTn4pylaMtxX3mO4fq+k5/fp5EWHNxOCw9afHLucMCka0SwNfjNXXbzE5Y3Rbx8gGV1zL27INRNKDkqIjz9LNYW3dazKKDmCUijZiBXu+01T4+Tpu3EMBAruYwd4ULQvC9vpkrU7I1uE2rPaxx3u+T7aywEAA/IqMUjMPs7M9AAMmDm1BMBVb6Bdi2mmkdzLwxGArNU6/MHZBg6QayZgEz9e8QSGyvoGszRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwzplQBweKIvxt3Ng6VMlNthM/avwgvQOnsEYUgIUu0=;
 b=Pe80BJz27+huVPoYIuBdJsuzbTDe/u+ALQdc3WHRhBC9e79PKFuE62kKzO6oF7i0tU1+Fb18nR/vVDCdu1lKWHKCtoA1G3n0SGwqFl+prvsS3+rc55X+1iJIvKaKEGy4DS6RJjoKr7myMA1WHpUXWJu1Br9VSARF/Go7pTNKIIwqSrKvVJSmuIAnnLQH+h4bAnhUrZdEcBukXa785CQz5N9KeZHGKM7xLIspJCyHDwaZsNXnvrRBCYVEYLANQIu/yen8zpNSEnxIo4VUICqe6RVn/6Uor4PsYgV8JPI7lCrmG+/B408PpRA6Idd1mUn/hMeP6q5kETJTcY2ZlRFzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwzplQBweKIvxt3Ng6VMlNthM/avwgvQOnsEYUgIUu0=;
 b=BXBEtrU3kVBNpHEJYJX7FRXkrAs8JE+3MaMxEG8vYoEoqX6w7a3LgFYVRKoSFxHBKPIp1aLKRGHXqjG0K8NJGuMpARhD4XjWXAq+vUGUWwubGRbuHgtZdaHW0B2LJtdYeTFsfalQLLuhKYkBKmePs1g3HSrfHEcKoMJLQwGzPpA/SbFtID6Kk5niBJo5rTSU4pzVIOfYPWzQqB50bRbou+QlRBIzZG5CyNnq6bMuXdM1gH40dUG4T7V7dQSOlX/QkjkJ67yjTSULNJyzbh7oZNQW4nKeC88Rn2F6ZIBkEQuDGjKADqAUA6rQ/IeE8ze7AeDfWU4+kUjCNbq04UZFNw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH9PR20MB007164.namprd20.prod.outlook.com
 (2603:10b6:610:314::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:26 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:26 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 05/13] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Topic: [PATCH net-next v11 05/13] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdUTSi2pzMpFO4ak+N/kx5A4KK6bbuKg+AgAdqB4A=
Date: Fri, 9 Oct 2026 18:23:26 +0000
Message-ID: <20261009182323.76166-3-arouhi@sitime.com>
References: <179116259780.434549.13866707323299859257@kernel.org>
In-Reply-To: <179116259780.434549.13866707323299859257@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH9PR20MB007164:EE_
x-ms-office365-filtering-correlation-id: 569994de-d3d7-4973-1f5e-08df26326904
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|5023799004|22082099003|10067099003|3023799007;
x-microsoft-antispam-message-info:
 U2B+Kyg82gQbQwfvW/HO7VWCO+jTjpA9V9X9Mpn3Riq3eUQ76eQt1ujXYbQPjQJSWnQWiJy+6ZAcQK1Io6lVhsfD6uHNSLWwpEghGl8dxNxrB5Z8wQ8j+/rjEXtjQ16auKfZFzlvCwbmSf1wwVTFAYjbdVP9Z3nz5tIavAOt/itKwUjtwG67N9y8p82bJgWUI05w+CR8Riw0YERc3jxVDonHWxqa6+phGxfpX3osjZRwclsnJzuxE6BOpH01dmmpCO5I85MFRBMW0bW72fc0G37PfBrWdr2df4LAcQYj6ZMzdWflmVTr/gPsBErhLIS9Z0beXLnwKBQ6bmzgWV39tx1z7yDA0WAS5mFYPBAsR0Z8CEV1cMlQbYynAuFLGtU4SgU1zp/o37me87bqUMu70+t0fHVvXXnkkTe1Knemn/cV6u6cwJVow7Bcb/98r0lzFtFywSMTcPsHCyKufdTksILzQrheAza4Ek8rRFTqHeLZdSTeWj/OUhpmfOhEGY85SrQIoqxUuE+xdhVIz4AcO2eSQkSJnpO5l1c52ydDhOY02S+sYp7EPLN7gPps8N/u33MaeEioFDpLmeC2Z19x4dM2u46H2bbwiAywGfh/gWzDNODCeh4gqhNqBXS76u8AZXFm6N1FaL0aueTYxtkYbE+li9b0jKqWM2N8hInb9m/jZtEXJ09imQlpatkSBGqwx/YpoDHbWNr7L30SxB6wlxx/1qS8ZnlaCkc+cEvH1hY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(5023799004)(22082099003)(10067099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XwnnY8yt7FJ9V/xstgMjIw3AUAWFLQ+ORWF8C6VtP71mCIdRHnRSXlNyML?=
 =?iso-8859-1?Q?PNVuFctKouUvm9S6qWWH/WwWrJowa7Fd4m8ZHc1Icjvih0kbVGzD0egHIJ?=
 =?iso-8859-1?Q?HlHzBZqWjHrvaBphLmeST6Z9fgg4EgrtykP4V9AwhCw/8ZAmZB61IgmMk4?=
 =?iso-8859-1?Q?XViQrmejhPed42u2v/4Mge/wGusfDHcDnIxxQ/a6lAlZctIrw5qkR9lKIt?=
 =?iso-8859-1?Q?EEf7Kve/fLXuXk6/lB6BNmaDHTyhQXfsWGoTRrGuAAER3FhKzsHkTwuebs?=
 =?iso-8859-1?Q?B+TK0JUMeRYNtOJ9OAh/gZiqZWJLBOS8pj561VHWm4H5kPFaPzENs387Rj?=
 =?iso-8859-1?Q?SPfsJ3WWJz54HcsdqGd0OvBeGkJvHSdJohflkWKDy1fBuyj2+brN4yHhpK?=
 =?iso-8859-1?Q?zyHrpolU6UIxjKzTZuAG92kY0YdDZTb8CVqlOWrYuHhEophm+x1jA8y/nn?=
 =?iso-8859-1?Q?0QeordmndQakh9qZD32q3l4phVO2yL22DlMkDrigE7uQKGWbKiDY1e71t3?=
 =?iso-8859-1?Q?Wtoy72a/hGunAY5sZMpY4u+uO1MezDmsYJ0/PePsQZ/4Rs6nUVjLvZpHXf?=
 =?iso-8859-1?Q?TiCi1hmAoDN13tkPT4oNjiaQ2YRUjbjjCSsMZ4T/AGUcUl0/KYDJcQOp+v?=
 =?iso-8859-1?Q?nPSL+yC5rYGsUEMZL5XAzhUuLz6MGzf17/KQKiK22zzilJpVmuexuVfAQk?=
 =?iso-8859-1?Q?a852e8fotXHA9I0UZCDp0uB3aeq+sMDh5Ld+IZPieNZFXSl3H+k2elU/sz?=
 =?iso-8859-1?Q?eInpX8Wi0yELdCgzmia9ojk+hY39GOZ6oNrBI2gO9X0O7cxL2RuzhGGbrO?=
 =?iso-8859-1?Q?mjydlxzeRLiECdT1SCa+bwtFKzGJBvLgdIq5uYiDxnLlleaqbA5kCXy7g0?=
 =?iso-8859-1?Q?kT/FxkIsgEGJp30PH+GTcY9Fh5n2v2gLcnCTISEdigaBIrX3spPtkM1+8N?=
 =?iso-8859-1?Q?19IsgnRncONIUklP4mF2td5kdk+6S/hqQxoz6ApeAofjf/9zk74ajw0H54?=
 =?iso-8859-1?Q?4DqZDpz5ihGwPy4Ka7OFQX6syhhWgr0L56I4Bq24ye0Ta4hcYVw4VVd2P8?=
 =?iso-8859-1?Q?xlj1pWNRwmuOAuqH27JMgHunMuZ6hHDc0Ltrrd1kK226bXt5cKQ8f3dZi6?=
 =?iso-8859-1?Q?bGrmX4UZqUMHV4/8bwLmeWNsmzFQsrCm2ZDojmR6X5a8tNNAp/OCly2j1Y?=
 =?iso-8859-1?Q?YYsUp9pcnRzaHZa1v6tFm+DsEPml7sD8TvkdaUMR5wqmTN2b/j6Dyd7XLS?=
 =?iso-8859-1?Q?7EEHFj/iBMk5DZ5X+ibOdGJaMdXNY2JL3xcOCEYCUN3nXbZN0xC1SWRFWJ?=
 =?iso-8859-1?Q?3ajWDl2PjLTntwfJFEI/o5FEUlQW0+OAjpRzRVFhHqjo2bBdI30ABx/H5A?=
 =?iso-8859-1?Q?RnY6ToO43uxuKCchppHyS0pYC790foZ+ZHOMupd2IEx40xYOc4r7xmHPbq?=
 =?iso-8859-1?Q?7aXoBUAncmTVovOtQohHEMgdyyQLSWu6J4zcI/LkgHXI4agbSX65EACumc?=
 =?iso-8859-1?Q?KmgOmei6UDw15VMzInKlLNSxS+Sa+riEq9MIOycY1XPnKUW5zhGTjZ+oR4?=
 =?iso-8859-1?Q?4a708UqPLlmkI4YrdCuN7NXQeyLcC2w9VQU1p/cSuROGe7sdMmRf8vBHa5?=
 =?iso-8859-1?Q?B5ow37xeGCIc8v8m1uZZDuBcIQuLOSIbKDNlCMO6u2qlJeFlWPL+2smXOS?=
 =?iso-8859-1?Q?7HGNV764po26lg97lgBbWY+9bD/BO8mc1r+R9to3gzAPy42rTlYzFExNr3?=
 =?iso-8859-1?Q?kHdpF7DApFs3LHQjKmIbZHwHsglqs5G0reIWWoWK9caDd4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QO1Zr0z4raHihGNsb1KuNo5rcRQId54KPZ0tfsgmFMt7O9SrMsQFrn4yH/EjPh6DoPiz/FxeNAmULjMmKe6t3jegGLzYzpjwQk6+xGJkHjfGvXhvGSnCsKeSxQ/uoKXDUuOAYUQlqLD4kcui2TpMJD/4HSABCIvi1NTS9udveqBkjAghgfSpGNBE6w/2G10v8e46Ubtut8o3lcb67tHngX6mLvu1e5PKnUVa4P9MaC1Pc0zRitjKEh0TfK2p4PPXlxOsQmctACBe4VPYcsTx3pDVcyTMGooB+DD9/zz75++Glha9buki42LdnpCi5EkGRhn2iu4Duk3QWqxK1shIkQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569994de-d3d7-4973-1f5e-08df26326904
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:26.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCwLew5fTqcTd3dfU0Pl0x3jFpaiVp309NVx7sc9iE48OnPQFIcqgYGIB/AUKrIzzBysZhT+BFR2MRTCQTjLzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR20MB007164
X-MDID: 1791570210-qS65ImdiDG0H
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570210;qS65ImdiDG0H;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Reply inline.=0A=
=0A=
> [Severity: Medium]=0A=
> Do the bindings define an order for supported-frequencies-hz?=0A=
>=0A=
> The generic binding in dpll-pin.yaml describes it only as "List of=0A=
> supported frequencies for this pin, expressed in Hz.". The input-pins=0A=
> section of sitime,sit95316.yaml documents the reg numbering, but it says=
=0A=
> nothing about the first entry being the rate wired to the input. The comm=
it=0A=
> message doesn't mention this rule either. It only appears in the comment=
=0A=
> above.=0A=
=0A=
Right, and the binding is where it belongs.=0A=
=0A=
The driver takes the first entry because an input has one rate: the one=0A=
wired to it. The part qualifies that rate, it does not select among=0A=
several, and there is no frequency set on an input.=0A=
=0A=
> Since this ordering would become de facto DT ABI once boards ship, could =
the=0A=
> binding document it? Two other options: carry the wired rate in a separat=
e=0A=
> property, or stop inferring the current rate from its position in the lis=
t.=0A=
=0A=
v12 documents it. The input pins' supported-frequencies-hz now carries=0A=
a description stating that the property names the rate wired to the=0A=
input, as a single entry.=0A=
=0A=
A maxItems constraint would have been the stronger form, but dtschema=0A=
types every -hz property as a uint32 matrix, so the single /bits/ 64=0A=
value of the example reads as two cells to the tooling and maxItems: 1=0A=
fails dt_binding_check. The description is what the schema language=0A=
allows here.=0A=
