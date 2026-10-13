Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F2566C65;
	Tue, 13 Oct 2026 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931312; cv=fail; b=q/ipnJ9Lh1j06ipSMc76z8+d5CWwYOMA3+OFJYOzoSEz8jaiH9gWxQ92iQ3NXnFbgQSx7xe9/wD3SEF1mMTOvlbctIWf45ZTiRibXBJWFOUSH0OMzdCM8Evjv/oRvyCG+BeVUrvDHWruEywZmIy0gr6cwt3TulunmHJr56yTwvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931312; c=relaxed/simple;
	bh=LIpv6uIckpT/RpH3R+waBhCdVx8/+wHSOroF1ULlmnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=miDoV5phkgImkSOnDZutTHagKzpOU7COkqIYb5tbsShZxwdbuDRRdzAc39CR/rmHJJMeSUghBc6HS65jy+lIqw2zFteEseXd9Le3VHlI1qXCiJLFyQV+k4tH2cG7dUb3INfnpdQYIfIgauPqzVehq+L/h5Ra+BBOF8FSno85wm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=oQEq15UT; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=zAd2o+OW; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="oQEq15UT";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="zAd2o+OW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=DcuSRdncKK3ePDk9CdNJQA3I9hcYIyx2BX+vOnmyzRQ=;
 b=oQEq15UTuQcz8QzC/cPrNZw42gOkuaF/bfDrYjtg/6gqaOBMqdV+gbdbyRv5ZFMRHHkha4ms7B2BuzFlG6V1V8UutzhajEBBdp/YoUCA+w8RLH9pXYphz4hiY28+Alq36mRsmSD4ryQXiqkHuxuHYs0KUQQSKQjbIeafdVz/bAdOAhm7v1rzpSZp5i/fVZARsfXGKuVhrkIeCCfqFJYjtKL6UFN58Ov6k57TBhmy920nbQX3aCTY7+S0FoIRWC0v32ILUTIHaCD6NzQ2xfdBzFB1FBdsHM0HWPAqfhnEn8GxIGPnMJ7sxwJfd2H31SBhLODKuc4vTfLGM104mr+Pnw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020115.outbound.protection.outlook.com [52.101.61.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EA3A8C00072;
	Tue, 13 Oct 2026 22:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pY3BsRoxOJ9n7ACGsTT1fuLGYMzR/FhtPMpcq2HxK/ZeRSa3q7y+Y7DlPaKxGeFMhscPFiJIDBR0TysHPRRXAXUDdheilkqcHHxhardlFNJZPUdFqiwkMYxFTmkHQ9E/wVYnCcjkQH7yrnpnAnql1nERNrkqwF5GQBuvzvvrKMLZzDtQpAM/4Kab+HJSbELp8oG01E+qEK1Nh5XffPgc3ujHijMyyB/N1/TkXq5kZzo4b+eFPeM/Fc/ObbQSFUwXoX+mSvqyIf6/YrZfjJqZBftMxXzpvipP7FP5NRystKOxHme1rx/vSK1UGMO8vFGeROMvSkC+sz6VPH89hbbSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcuSRdncKK3ePDk9CdNJQA3I9hcYIyx2BX+vOnmyzRQ=;
 b=M9Wp8y24UMS3FI4nYJfN3sYkk73LdB9O9G3lCCuigMw52IxVVbYMrzZhypU+WkzOgiRG0iRjs1i3LV8OJ/e69js0glw5KDZxc06RdfpdcaRX63WTHM68gIlBHnW00nZHcfxAglQE62HAhuG6ESIJUvfsaJa4ivJ9avaDUtRstzIH7ph91o5KcbMSg7Enbsmnud2ygC5g1xPrNymlB8zfZIVCfimysWTZdLvZ7hYX1OsIMSHZBunjbyZk1ahrdMZ5BHmPnA6Xgpglz58DK+u0d9p/LrWUJtY2Q40I8kmMz1L5aFNlzf/UVG4A2I1/0dG8pXrwbAMuARs/3nR73CRJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcuSRdncKK3ePDk9CdNJQA3I9hcYIyx2BX+vOnmyzRQ=;
 b=zAd2o+OWU7T8BBUttFOniCq/tPtJjjDJb1JL/m3lq+AoIR8GZmj6wTdPkNN0dQMbmGrtuatPw9GsuwC0ddK4YNn0GnDcPhBh8Mnza+Oo3EZmf32BoxNTcIgNIZP82VXDuND+PPICngpg7vIX4AtFV6btPogCckkslpD78FWDRlCkwElE+BYKNfLcF9ntrGpRKYzd3gxoo+PySFSCDRvlwpCxTuNYkk+rGh08vv6/Yhor7ar84f9ixA/hXmfWUzj5KVeXJUz5zWJqwYXyMKUdiPkaHECzpCYqVyc3SuRFrOibIwSb+bPryijgkaFgCMMT5ycqtvcgwF9Pk+g7e5wbtw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by IA0PR20MB6676.namprd20.prod.outlook.com
 (2603:10b6:208:480::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:36 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:36 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v13 08/12] dpll: sit9531x: add support to get and set
 frequency on pins
Thread-Topic: [PATCH net-next v13 08/12] dpll: sit9531x: add support to get
 and set frequency on pins
Thread-Index: AQHdW2QBp8UyZE8c/UGXh+YsRn/ZUw==
Date: Tue, 13 Oct 2026 22:41:36 +0000
Message-ID: <20261013224131.27149-9-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
In-Reply-To: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|IA0PR20MB6676:EE_
x-ms-office365-filtering-correlation-id: f8d5f24d-a02e-48ae-7210-08df297b23bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|5023799004|261009221727099003|261009221227099003|261009223327099003|261009220027099003|261009223027099003|260925021911599003|10067099003|260925021311599003|260925022911599003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 lH3gxLGX83kTLeAdC7Zt4E8IhSWGX9THIDobqlaPUuWCm29qR7w6afo9P+fBMVnHyGqSZIZHFWbp/msGMCwyXd2Fjdc2zWEDnl1bjY3HNqV2ECKoiJEvEF4AJNzHr3XyDSpVHQYdubIKQjCN+oi4/XxbuQnyXR8AemO+4cH+0OSu3KvyyAUpTHH3xvq3QIeEfUgsK+g+wsFR3rRo9euzHOJ/QV8jUljO2j+5yEC7MMy9n4GUnnCfq9FCEYKASLis5Bz1QP1R93O9jI5VeL2j4VWEBPG1I3vk+/xF8jUd/fVFrGzACx1SXK8LofH1F1wSoyMZMYhuXsYRatW37sYjBDsusz6Ohj9xO8l/eR0vfHcvMC9YJXWydQxWwcrKuSPIwa+HuSSr+i+LSZol1QRFLXCRpir5H6AZ1jHbqJqPkV1BRrmBDRWvr5kD4iMQLFA4vsTP1qjWQEW0J28GyGkkOmcAS1f9wS1jPiD/3h6wmnkWmTvs+/kNQW9m6EaJHJs5OFhWjUXF0BGR9kwO4kZbLHPu8yk2NkGn6mUYrstonHP+GhLv8X1ifJ3uJmuSqzCc1qZQNFoa48A3YZYSyeukGi/jmlNmx5w4Z/ZOVdj2E4ksPnp59tfL3clLA9ZAcp//Ze6xczo4OBGgCugRV66eG+hiuifANBLBVmI77aK6kuGnH8g5xKXnpSuyERJ5pjlUiCxZTRW3L5ODcaeUvC8vqEOmW8tfktgBah7gio0lpBw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(5023799004)(261009221727099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009223027099003)(260925021911599003)(10067099003)(260925021311599003)(260925022911599003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/crid2OSInIWMDvfZ+1WkeI/fLdRNi5X9WpGCzDQzIgYFpGT2/I4EKP1ij?=
 =?iso-8859-1?Q?wtacQ95R/ryNj/PG33Mc0qq2NA19uKxc4ADuZL3wWjhuSQ1v+cRy5Veibo?=
 =?iso-8859-1?Q?qb9PDBi/75xrFKulO6yyMEshk1w/eMsAN7e62AbKt0fEirg8b/4HAcaWEU?=
 =?iso-8859-1?Q?qFBq3tYiXUPDvLJpODGsE2kDPGg54jX+LSbBIDkRcU9CjVcNTRipsjXdoL?=
 =?iso-8859-1?Q?CMqJf10HDSFIdfs2R9jaWOabNL/h1LWRH9ZDf9Pj2xpBaPkjL4fnDbo6SP?=
 =?iso-8859-1?Q?zZejn1M19Mj5h1ZPheSey/htXLJDqdkIk10Gs/LtbOtXrrGPfS1SHoqU7A?=
 =?iso-8859-1?Q?9vNxlkPMXWXto2G4ukoYC11j+CVMQTM2j0o/zJWMPaANtDb2dAcJyASkwl?=
 =?iso-8859-1?Q?8V6vkSDOjWW2mff7j+zWS5X/BPm1BecEcq7zrr7LA91l1uCHeORzobjtx9?=
 =?iso-8859-1?Q?/IV37494VMvptRkg/qaY3FVf04nJLTpwzOhnY/HmvOdk9jzj8p3/wBGOFK?=
 =?iso-8859-1?Q?xQfW8myO6XKM5xBEKV6xhbsj/eAbb0e7ABOYX2907Ya6rQoYneV+B48zes?=
 =?iso-8859-1?Q?qkD6u7e/gWDpsVdLQyp96peD+kayfB9wl7EfzdfWQSML/HGjD5+ndawFJb?=
 =?iso-8859-1?Q?GRVMyN+x69cWt6rkhz1aQMAqlTjyFxOt8lQAweyUahfprLSFIziVjzzwIB?=
 =?iso-8859-1?Q?CTWNiq/qDngFbyVg6El6/suDxcSbbO1yy8yE2giDDqnsZp1BUo608rH4uf?=
 =?iso-8859-1?Q?tdJghlXiCDy+uOujGX67UFOqCKPTXipIwuuziUySad2TM6K+l0W9IC7jXy?=
 =?iso-8859-1?Q?BZAmApIcUIt8vZRsBsnJEZYC8YKRzM7kaXZQ5/aiAqvEhNkLRyUIk2bG8c?=
 =?iso-8859-1?Q?O4ypl14Zy8xmp7xtyl0bvkgp9MdPR5KpVYWekPHFgC4fKmEUzn+yr2lCU2?=
 =?iso-8859-1?Q?kKSdzG/SyaWV9H6iB5iRJL373bsT8sPtCOG/E8Q8VvWzoq3PDCHByjFwF7?=
 =?iso-8859-1?Q?GZJNCuDFbAH1nhMSC9qM1yOB4GP3IGSA3BEyNj/00RBvt7J2ljXdlh4AOy?=
 =?iso-8859-1?Q?cU/iZL4j2qSsDnCJ9mHp1H/sKfH1zAuNsfxaKb55qaxEF9WOhVNQASNlwe?=
 =?iso-8859-1?Q?45LqBV7P7gbRKdxelxmfGvxOxdie0NZGl2oA5TH4INsBL37lVVTUMpb5zK?=
 =?iso-8859-1?Q?LALu/FQAy1f4eIRzV/LH7QyL9riL3TTeBcSnyax0iNqiWZcBhS00k45cVc?=
 =?iso-8859-1?Q?3UKyPNssTIKzBmHSJ3wIhU7IST98KYHrJvsPCkRbCeYXX1Zhsg8/D5+SaY?=
 =?iso-8859-1?Q?TIzjWvH7vOXYi4vs7xBNkOD6/8LyRJCob8L8rwFOwHN5EYjqBGiqt/zF2m?=
 =?iso-8859-1?Q?YW8Pf4JmEj5Cm2hctQjCpHbEx2fg2uSf3DWYuxB4elZSPDVotABgXEaclv?=
 =?iso-8859-1?Q?yGOqU2sTo8D1KgXBowXX5hFNM3Z8ndzlpkYN/j0GmWKnqS/wiUrI/mvJqA?=
 =?iso-8859-1?Q?saCT+FAFLOIGck45eMGA+32fFNfn7B0chYuSiDKMAXZTvo9biN4frgcqNj?=
 =?iso-8859-1?Q?f0eCt2WwkC3CWJn+DYWRaBQotyRRZLqO3xlrfiIGJOYzf0i6GpPTFtii4F?=
 =?iso-8859-1?Q?8vcpVnTphd96hTF1DvbVLlqyP0cu9hwxFZPxxt3d6KeOwq0prt6DWGSEwp?=
 =?iso-8859-1?Q?QoW5bkLK2Zckxhyq/lP/mFitvmEYHR+vLYib6PH/OkqDrCXqvuYzIYNsKh?=
 =?iso-8859-1?Q?Gl3ff6ECBJBKPNDxUe2b+FB351HbEciaNgb/sTYrDjP+x7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	q5+vyruqUdm2hQR7VBa2vGPIHdSQlBKLnEP2+SanHPKTW35hBKBKRqj9l+93K6I1jyw2Uh0+WTzbwDJ9Oc0VJpZp2O21mTxW8eCjLOo5Poc/aopPiSWf9B6Vo8NvduDj+HXaWURo9bnxMYBtKVAz6ZfpDrcnq81ZxF481WP1wo1vqiye6W5E77ntENJo/BcjnLoyyvW5CARJeg52aZJEj75aqEaTbQYlkUGty1AEduGWBKiBf+wvsV5PWWhyICD202f9smbPpDS9bgvrFL+XNOAhbs0gkqjuicQxYcYpyv/svc6zibLz9dTWrAc8CN/t6RpBjTLd/gmVogtSRG1ZUA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d5f24d-a02e-48ae-7210-08df297b23bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:36.7055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UVcTOE0lWMwYMHdNstAD2bW/Yv+O2O2dBjhQJwWErICJlHMFLcd3oKSzM5yM1bpsxcmudwLJjpk7QP9kIvOPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6676
X-MDID: 1791931299-mcWKgYz9jSpy
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931299;mcWKgYz9jSpy;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
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
 drivers/dpll/sit9531x/core.c | 808 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |   7 +=0A=
 drivers/dpll/sit9531x/dpll.c | 120 ++++++=0A=
 drivers/dpll/sit9531x/prop.c |  33 +-=0A=
 drivers/dpll/sit9531x/regs.h |  21 +=0A=
 5 files changed, 985 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index f3dbe949f219..875a5fe783d5 100644=0A=
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
+	int rc =3D -EIO;=0A=
+	u8 attempt;=0A=
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
@@ -1342,6 +1481,675 @@ int sit9531x_input_prio_add(struct sit9531x_dev *si=
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
+	/*=0A=
+	 * DIVO is a 34-bit field; refuse a wider divider rather than=0A=
+	 * truncate it.=0A=
+	 */=0A=
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
+	u8 slot, page, base_reg, divo_bytes[5], old_bytes[5], msb_old;=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
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
index 0b7418922cc9..890a52831484 100644=0A=
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
@@ -258,6 +261,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
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
index 934db566c002..cd2cf2e2ab28 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -295,10 +295,11 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=
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
@@ -313,6 +314,30 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
 		return props;=0A=
 =0A=
+	/*=0A=
+	 * An output's current rate is the one its divider produces, so read=0A=
+	 * it rather than assume the first entry of a list of the rates the=0A=
+	 * board supports is the one in force.  A rate taken from firmware=0A=
+	 * that the part is not running would be reported as current and,=0A=
+	 * worse, used as the output period the phase adjust quantizes=0A=
+	 * against.  The read-back does not depend on the firmware node: an=0A=
+	 * output the board describes without a rate list, or does not=0A=
+	 * describe at all, still runs at whatever its divider produces, and=0A=
+	 * that rate is published ahead of the fallback range below.  An=0A=
+	 * output the configuration does not route has no rate to read,=0A=
+	 * which is not an error.=0A=
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
 	/*=0A=
 	 * Advertise only concrete values from firmware plus current runtime=0A=
 	 * value. For outputs without a firmware list, publish one wide range as=
=0A=
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
