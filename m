Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D80448BB8;
	Mon, 21 Sep 2026 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023769; cv=fail; b=DytSYro5kXrP0Y6ent4oQMOvVblw819hG2QCGlhmDDc/WkyxVwmLLFZGXVdF/nNUM5glavGj6rhis3eKuIXYxOakmHHGXlNiOPQoguNPCHFKiA83UohFtPF8NfHldXhpwLPnwTICNka7z45lY8n5VTKa6RwXAt3YCQn/YJfirLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023769; c=relaxed/simple;
	bh=ksL72x6/gAQZDbj1TKRhm0wqymlYCHPd0HR0hEi9D38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVqEVNjYQoSF/UJfFlHdVSSB3jAYYFvg4GPALmeypwQ1hQwAlOsRWbDSauI6kZvK0fc0S3LbFN/YCPLx4QudwkCxDqIUN42nfDVycfJxPxTDsN70n1qH5VWlBg/3JwbYixcxVMNwTngAaTxtwJEuX3lPiYHFqR93PV2Kfho+yOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Ua44Z0Fm; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=k4UjZq/s; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Ua44Z0Fm";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="k4UjZq/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=fFk2C4RY14ZqZsZ2AAmr/KEJoG0xyv2XSYS0ew8yLu0=;
 b=Ua44Z0FmgEx9AXrpSe3gKBRcPansX4C2kJNoHGPT/v5BCJFCPnMVlJ0y0j62ffGJ4CXXqqOaqsRCTqfLnoyu5+LcRKMfOW5EggBijo5134/HpZIRhR5to9nwm9tN3tl1vMMcTckkjb6+KUw2hOYExSRmgpF5+GeRwxHD0nRqIRvbq+aEM9xnxNr4hIF0l1nGLeOmPNULNVi+eHstZNRxX3juf7EbgWTKuAOKeDFknrFTPLRfUbm/QroeBswVwLTlvUUVzaf7Ju3nLDiqoFDjIrneX6f8x405fNKyg0VUn3YjWmB0per1/9vX1mBC09yNZzdA3U4iuZnYNOOSkipGqg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022078.outbound.protection.outlook.com [40.107.209.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 548D03C007B;
	Mon, 21 Sep 2026 20:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esn7v6K8a+Qy7lOla5dfyfFpgiJ9wFdUvmjepTDf+gC+kVhoRFN91Vu07nzIH1vwEyZqTbDOU+5rM6maI4aW6hxgySE2oE67T2NKwroDJFJgeZUH51A0DLM5dTCf7LEiU/h/zKDNZRngQ2CJQWkBEzR32xpbo+2MzdKgaM4lbfiKshOVgz8J4CiaNJEL2fqLVJXlobpIypu+41c4gyTIJBIMHlRR37YntnIFEPWFGFq6Oh7x5fC4vyRkHQUAw843EpTunOJ9Zmt/+djHW1KU8PPiGMH7FdI0EFaKJ1jwvkJ9fruS1P3Z4ykKZDMZBXilHVRWkVYAsYJC4T9SF7+R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFk2C4RY14ZqZsZ2AAmr/KEJoG0xyv2XSYS0ew8yLu0=;
 b=cuoOEHYMZzhrnEr0Eqsp4rd2Fj8ctEEmzwxOOGGVPf4fJjkIwskfocZ7wxCTNwHxUo7RrMQo3VTcxlT2nCjpMKHhiHWHHKP6LVgTMkPxwe676Yaqf23seR1fmVtM+77jGUFEH7Uot3Yw/9H3wklP6JyAYxPWMjEa971H7muBzadWNsAhe6ux5FcyDG/0KNTwGMLS6wkQXlhlQOrh0Z7B8VGPUq4Nl/GmS0tTftd7EzuUNsLpMfAZQHGvTagukpXzH0abVl8Mop63KSNx+0z0NysCl+Uai+sCPMnSYE29nSVCZw1OcGxnzEs6R9DSxBvBlX4xxereoT9+kr4hzFmkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFk2C4RY14ZqZsZ2AAmr/KEJoG0xyv2XSYS0ew8yLu0=;
 b=k4UjZq/s1GiHC4D4sCJwQY7HUy72y/mRZtXRJl2YIBVIh6IwFdNWQaWXpb+lotBen9nx5LXoIFsl5I2b8qAtSDTB/Px/NDbeUESqA/jLsLgkpSkzLbONehgJeizhapXqh5DmE3D+zHRUT6FBWsTX8eUqLZrXx7qBUhCuk0gUUxgNfyR6kX6CkNSf9t3Q6Iz3X5VvlsVt4pm6CRB5zzWbFCWlwpHRK1/NBb97jBTz68HhFlifFiuX6uCCIHfEu/JDDQiQag0K5tPAqHiOxRyVCDvgmhgabaikae2E+lUp6XXZTXqiMrJkrDF16gl8dx7hrd/HCcMNOlzePgSJ7hBfZg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS6PR20MB266123.namprd20.prod.outlook.com
 (2603:10b6:8:418::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 20:49:21 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:49:21 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "arkadiusz.kubalewski@intel.com"
	<arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cjubran@nvidia.com" <cjubran@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v9 10/15] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v9 10/15] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdRKUzk56rBFH9tUGsh9oPnlXYqrbSjBuAgAb/8QA=
Date: Mon, 21 Sep 2026 20:49:21 +0000
Message-ID: <20260921204918.53170-3-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
 <20260915000015.80480-11-arouhi@sitime.com>
 <bde28182-fab2-4ae1-b5f8-d425c2d0aeee@redhat.com>
In-Reply-To: <bde28182-fab2-4ae1-b5f8-d425c2d0aeee@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS6PR20MB266123:EE_
x-ms-office365-filtering-correlation-id: 28014712-9e89-4131-98c9-08df1821d008
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|10067099003|38070700021|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info:
 NRQ7lu4RNWKMbxXOyImxnOm1HTEYXN2Cr4Q6PMZrXGrVzwwicF0cKqLueW2cKyaIPd8qgUz3Ercj3MQuZwGklowqz/weA9ao9f9Bzwj8GLhAYg5CICkOgVpZeo+NkIhwhhoRNzcQWp1reBb+MEmh4+zi9Hvoufc+9VP4/TqevgunlltwGWVc9QJvymw9ktw0V59BnmQRH3sLrRJ6PKge0tt/8UU7yUMUQeA0pUaPHd7dO7j2adCYsqznp/9r0tAjPy0nIRRu96uM0gbZZoe0M/7gVZYL5lN5x2CUFnrkyYbWaaAeK74dUBohEFxYI3fU3I+147TLpUboP/QqvTXiisxiMvNqJYELK3HjHzRz266htY9b94nQag8vAgGQISkVabq3mW/ShBKgst1av/tqlqdf5ojqxcm2oJnpBqt1MOMYvbKzsM0acg+1LofZmRKvRe/iDWaEzmrbDW3iXLjTm5B5ZUwT3+uvqTz+pURgRKzIckq6PNP46xtVmj61eqmV2PRuWmWKq6pg46vn6RloWMCHpFEkUqlNZAMdsvL5jmo+VkHs2Epq6v/QjN4+osESDheLc/2Pzpj2/9WlGvj080RBmlj8BLcUXUYPgCoRKdK+B4iOn2Br1CCKwOyrh+MR1wADTbm1KRBi+XGHrkPvTKPE9jLDWdINtdUAU0s1YTQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(10067099003)(38070700021)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OmrT9peUo4fbFB4kOlee1WucOR3sehmYp14zCVMo4qjVvAHhD+9+HtgN33?=
 =?iso-8859-1?Q?oHL7nPmocsBtlCmh4ypAtnJYDxY/Kfn78l1x1vaJLDwOt0/nh3xzZ2LLYC?=
 =?iso-8859-1?Q?q5lGHPl3bB8lrpt7aNiTM7+QehMEhUM7QQ0OaGTOUadofcotJdqQccZtBh?=
 =?iso-8859-1?Q?lRQTM1WNBDSLvtNlXvuAFWK/d/ME9pDN8eLsXF7TtT7d2aYsAQIQnXMZQw?=
 =?iso-8859-1?Q?SYFqWMIqFZ+Gl8wQoIxyI3xKqmtl0XNIVQ71MPYmTj87fG9tkNO0fv3hbT?=
 =?iso-8859-1?Q?TUStf3uP1+K+yv2f/8fKjGlDuFLSJTtjTmKHpIkxnal0OI3sXeKfmIsJ39?=
 =?iso-8859-1?Q?ME6zeVA7DDa4/IcJ0SXH+mhD4QbUh/vTJSKlTPNmCS8OXwz3psyeCDQDRO?=
 =?iso-8859-1?Q?lQUa7H+IatXZKs0JapBnsagdUZ1+wBF44NRoXIM9M37JJ3E3Gq8RhgsmI4?=
 =?iso-8859-1?Q?/XYbpvdjNVKXGNKaXYSfbTAHWoVcDDoNN7wO9QBMCrsLsl5vN+LC+07hPi?=
 =?iso-8859-1?Q?LEHIbRLbxq6ZM58xeEXA15mOIvnXseTKeX+OOksHagrsfvGPCEVjAqomvc?=
 =?iso-8859-1?Q?K9ltn1gjuN3G3KTG7b8a/V0/TD8BqcibdZRP/HrZ4JBSpzqT4Mr6nlYe9S?=
 =?iso-8859-1?Q?zwAX00/tOETLtBbg+yj639D1Yi9Z2qkhnDPLogalf3Vt+jH9Ng7GYsqVoF?=
 =?iso-8859-1?Q?OBjH5/PUa6NovtKR4mARWuYiT2ijfxOEu+28B8MHUQ5rgTXvSmJCxndXn0?=
 =?iso-8859-1?Q?Bi9pAS4fgHY2FITf0BNXgyN+hVBe4jaXuSr9vdFyNA2ym/Vmcg8k5kzygo?=
 =?iso-8859-1?Q?VynjdPqDK9j69+Q0NXNbqfsTQ0m7+IxzayWhODe5xHY9BcHaJe80cFGvx4?=
 =?iso-8859-1?Q?Lq0mI7TOYxKB9d58rHpKaaham6wtLgUq7wx2zQMZDovjAHs3AbHdNb/7MM?=
 =?iso-8859-1?Q?EUevZTBgzIuz0WlODxI9XyieahzJT62ADHEyw5i8Us0dDiSFpwd7R5qIOb?=
 =?iso-8859-1?Q?TriIyE6wL1uzb+Njj8cnAr/VEFoxDF56cD9oC90raaeDhEJIMQ55btL+uX?=
 =?iso-8859-1?Q?HOPSnsfFrEL6/taISQe7XvXaryhT7+fTyBvcjTRyqWVMUjwCztOn7NZsF/?=
 =?iso-8859-1?Q?deVjIreEnGxoXg/wmIMg1OhsMfKVyVwbgSUrt2v4h2jmo1o2Qjnjvoj223?=
 =?iso-8859-1?Q?3owbCDe4ynCpCcs9BmIT66Wx1kmit4JTga6zeopShDklWysMoWdqaFiAzG?=
 =?iso-8859-1?Q?Cv13aPFKr6CfCw+1m3wMCNozG6kguy7tbVLwgNCWbiNQ1QA6kEQtB1QtoG?=
 =?iso-8859-1?Q?EWZLZ1F7IWgLzfquo8AjxSnks93JqvETDRshaQ6GuQRAtsInRIm774S1ic?=
 =?iso-8859-1?Q?azmGAaYvrGzcvYef/VEwegR25byd4iOsRGvc/TB6uJBBUVElqfCaRhRUug?=
 =?iso-8859-1?Q?cedT1NqwdDeD2GHoCyA/5rf7vKXCWGLYVTgkG+dhpxHQkCEVFusxU852LD?=
 =?iso-8859-1?Q?mCCydtWpbLiPdeSoMDn3ZzD5CgY7Ewzgtji3nPCbfhBHyYqACHlg05SA6H?=
 =?iso-8859-1?Q?XDiX7uyC1AZFN4yz1TTonUv9v5JbhlngWuBBRqhtTpReifPUHRM8Wd33bn?=
 =?iso-8859-1?Q?o5JdYZvCTPpZw6dwocYti1ocb1fva2Gsm7kcScNed8ke+HfNBHJSokZdFl?=
 =?iso-8859-1?Q?ohsjpnBqwSRQUqXstu68lc3MXLlKEWZlf5cNj/FPhKKNrD7eI+97WM45lB?=
 =?iso-8859-1?Q?6c72wKfboiyCvDuQDaZOx5TrL5/WU6DaWmINbrupRvFBwX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qSa2BNh/N/DpK0fDg+Q/Cl8IJUPqj1CfzAlSQASmQg64JqPFweD07sIgivhWzkYNydkJfXVgesHIIP85pSNr0KT0kfAOtxa/GhIgT8CySuphyBzaIvnj/25o3wpwWp4JWHvzXMeHEJWcqunn+6XmRjqjZ2v6yWKMEq3BOI5xY+Vs8OfbVGfutB+43/5ZqBS42sGyaTZNYkm9y9u+/THgkhCmKmFhOQ5ddcKyboRYSv2Kl5tzuDuQ9E/NgJlCkBeruq16uqgUiqQJYAvbIymTr7sHnr5wr8vL8rWTaxVi0kDGM5V7nDGzNSL5u5ozEcImGE92VS6gKzq3dAHwgI8/Hg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28014712-9e89-4131-98c9-08df1821d008
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:49:21.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKwjAuiJEAxxm1FL6MqQ/akWfCIafp8/DV96eZAzkk2BYkMIkWAtYwzHwX8+4X4jOEDVaWFa/nUfrqw+sZEEgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR20MB266123
X-MDID: 1790023766-zP_wR6E2Rl4v
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790023766;zP_wR6E2Rl4v;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

On 9/17/26 11:55 AM, Ivan Vecera wrote:=0A=
>> +	if (phase_ps =3D=3D 0) {=0A=
>> +		abs_ps =3D 0;=0A=
>> +	} else if (phase_ps > 0) {=0A=
>> +		abs_ps =3D (u64)phase_ps;=0A=
>> +		div64_u64_rem(abs_ps, t_out_ps, &abs_ps);=0A=
>> +		phase_norm_ps =3D abs_ps;=0A=
>> +	} else {=0A=
>> +		u64 advance =3D (u64)(-(s64)phase_ps);=0A=
>> +=0A=
>> +		div64_u64_rem(advance, t_out_ps, &advance);=0A=
>> +		phase_norm_ps =3D -(s64)advance;=0A=
>> +		abs_ps =3D (advance =3D=3D 0) ? 0 : (t_out_ps - advance);=0A=
>> +	}=0A=
> =0A=
> This if-else branches could be reduced to:=0A=
> <snip>=0A=
> abs_ps =3D abs(phase_ps); /* Safe. INT_MIN is not possible here*/=0A=
> div64_u64_rem(abs_ps, t_out_ps, &abs_ps);=0A=
> phase_norm_ps =3D phase_ps < 0 ? -(s64)abs_ps : (s64)abs_ps;=0A=
> abs_ps =3D phase_ps < 0 && abs_ps ? t_out_ps - abs_ps : abs_ps;=0A=
> </snip>=0A=
=0A=
Taken as written. v10 has those four lines in place of the three-way=0A=
branch, with only a pair of parentheses added on the last one.=0A=
=0A=
Your INT_MIN note holds, and for a reason I wanted to confirm rather=0A=
than take on trust: the core rejects a phase-adjust request outside the=0A=
advertised phase range before the driver is called, and that range is=0A=
+/-1 ms expressed in ps. The value that reaches this function is=0A=
therefore bounded well inside s32, and abs() cannot be handed INT_MIN.=0A=
The comment above the block now says so, so the next reader does not=0A=
have to re-derive it.=0A=
=0A=
>> +	coarse =3D mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);=0A=
>> +	if (coarse >=3D (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))=0A=
>> +		return -ERANGE;=0A=
>> +=0A=
>> +	/* Fine delay =3D round((abs_ps - coarse * vco_period_ps) / 30 ps) */=
=0A=
>> +	coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
>> +	rem_ps =3D (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;=0A=
>> +	if (rem_ps) {=0A=
>> +		u64 steps;=0A=
>> +=0A=
>> +		steps =3D div64_u64(rem_ps + SIT9531X_OUT_PRG_FINE_STEP_PS / 2,=0A=
>> +				  SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
>> +		if (steps > SIT9531X_OUT_PRG_FINE_MAX)=0A=
>> +			steps =3D SIT9531X_OUT_PRG_FINE_MAX;=0A=
>> +		fine =3D (u8)steps;=0A=
>> +	}=0A=
> =0A=
> Also this whole block can be skipped (and set coarse to 0) in case of =0A=
> abs_ps =3D=3D 0 to avoid expensive divisions.=0A=
=0A=
Also taken. The coarse and fine encoding now sits inside an=0A=
if (abs_ps) block, and coarse is initialized to 0 at its declaration,=0A=
so a zero offset does no division at all. rem_ps moved inside the block=0A=
with it, since nothing outside needs it.=0A=
=0A=
Patch 10 in v10 carries=0A=
=0A=
  Suggested-by: Ivan Vecera <ivecera@redhat.com>=0A=
=0A=
v10 is posted:=0A=
https://lore.kernel.org/netdev/20260921201108.42676-1-arouhi@sitime.com/=0A=
=0A=
Thanks,=0A=
Ali=0A=
