Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DBE39CD0C;
	Mon, 14 Sep 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426856; cv=fail; b=Qz8bFmUCJJZ2FZe5HTfFdeF9vtCrinlKKNEbGlHzZp65gURyl7iynhAFdNLXWnSSeh6q3Vzg02df6RlqnN8O/vE7QyawkPsEscystg7X4HQRIcCCTm8r5w4xfzN+kNdbHT4jGaOFRrVD1FU0kG2JA04jB1YJInccvGfAvnixjfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426856; c=relaxed/simple;
	bh=H4RY7o6n9F2KGgubDaspXP/OoYmGAR1kA92NOl7Xr7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CYomuVRwOLPLnLUcl+ymALf96ziMhPktUDWwAp/s7rLf3G65BMgBapLFENt9hK2C1Ank8spIS2kbY8UZW3flAKokUrV56Z6OPMTskaTGapRmNMwTQ7ZnRmoI/tEu6//KSis8/Ht/2Ymx7abbU60OIjiZQaNNF39Nbhshw8rRZJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=YnuA3esP; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=SKe8qkX1; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="YnuA3esP";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="SKe8qkX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=DMlpw857yAjbYGkdxiWjPsuzPslHEMZkUEYkdW5KXVY=;
 b=YnuA3esPU9g7tdoQnIZzDlmL/JTXFCRHtrYNpVrwbWTmCw5bhBMpOdnzHuMUtFUdz+8Hge+QBH0rfhvwq1YrcA/h2+wu4WTyiUdQ3hrYB3o8rcXh28dtt477Ep8VHi7j29kHlmOCXIxqj1OKNV9kELlDfALDiTE/8avW2U6/0FLg9UvkZP3IBZAOyosv+o8jWaJJ8r6GibkUC7uS1o2Nlw4f8PlarQ/UxWSjW/k/8qAmpVfaOWncJeYPQgfT7e2NAM2bVAuiimz0dsRyuoDszwgTrD7g7RDEbvr/VGLqCh/UC0is3RYtysjQFEWHXvR894zfC34tAGNzEvihaB0Vog==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021086.outbound.protection.outlook.com [52.101.52.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 759FD94008C;
	Mon, 14 Sep 2026 23:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0CCYSJ40cMQCrCZV0F4CsEyFGNovQthecGj0njnYlmls77BmV8kLvjgN9ch8aze6SHqI/3ukmWRNIgN4A95r4M7Fg3WuEamEXK7Ekf2xCIkbWBNjpBAb/2LtXswWGY0/58kypvBxklmKSgVmIWmTAtcm7e8U0xdXjmBUenjrH7hRK0STajkzpUyAziAyldk0M5eGPccxVXwR2rfYFgN66MN2NCi4XpJsgQuLhuEjKSQWFbj3qNxW0nX4LvEiQkRhKYW5Y2u58YvdNbi1v+TH3nULHoZyNcMMAVcxi8MTUR69M7J7QtwaCynnn3kuE3Lc/m3dqoc7r5/mlstkXXC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMlpw857yAjbYGkdxiWjPsuzPslHEMZkUEYkdW5KXVY=;
 b=mXPtuGR38FhXin1+Il+MSewijPdeK4gamoNKO5pwSohRrtym7Aj6i1OxWrMPYR4XPy+akj1uo7rwhV9FhA44OiwWyS1LNkv+1oMxYIBttU1JqHyFHjGgBwaZ2fv9YW5XaVkOwulVgWrDq55K2JfSPFNgf1XfHTuSSDxrboNsLltX7srJOivmLgAhl2PWk/6mjy9UaY25ygqHqdREdZiGz11LatYo2VQzUre7NArLjAYwfcKnMdVGiEnfVpIEILUkVhtdyW3UnLA9rDVU4chSZTDWrgUhbckgUyKmHM+EGjktSKM4amx7I4QsuMzRq3Zm/gtGMHZnwQFTUkGHmmUCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMlpw857yAjbYGkdxiWjPsuzPslHEMZkUEYkdW5KXVY=;
 b=SKe8qkX10yMe2AQTY5DDD/7mVFwkV2lB9m7Vj8089YsJNrMn3GnAQbuuP1DIRcupGsGVJW/PXG1+Ad/wFbNeO0idUiGUf+tPNlESxSaeWQ3AAFH2SobXr1EY19ADWL4ngCeNrR7REvGSYhzGq4k6IdutvzW/BoO2NOUBee2TsIqvxv0gtafq4VQI6BYw5UZNalo2+9ZyfGjOTscbI2VEqirEvKjtomNnXqLYtwX5IZrN+RHcCPAMrE431UTBA911EcVMSCZ6/GkWq7WzAo77aMUczE3ui95fyOkldUguOqI8EQ4jsDCcrdLoAmP+wh8La/9muR9WE+DSmxluvLzqug==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:42 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:42 +0000
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
Subject: Re: [PATCH net-next v8 10/15] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v8 10/15] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdOyOwjZgFSvu6YEO+bGTsW6Wpy7bEqYsAgAoZ2AA=
Date: Mon, 14 Sep 2026 23:00:38 +0000
Message-ID: <20260914230034.63861-9-arouhi@sitime.com>
References: <178887152267.219967.2296326775875022935@kernel.org>
In-Reply-To: <178887152267.219967.2296326775875022935@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: f96c3639-5522-454f-4c0e-08df12b400b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 uPsiBVWfupAkBe+5kyGs4kg8gLE2L2fw/01UO8UgFeIOpCRp7LCiPZhowN1kw+ejaBDeoBuj30VLHkYilaAl0s3xel3flZbA57M8550sK7Ya7P57BARTpgQya0J7dRq5P4urujKQd0GTVg/katxpdOF2FU+3JdTXUvGAEdtRkjIE1DdyQv16jG1wpAfYH7lDaAAB2Z9I9G0thJ8DabM1FNlsdrDWUgDna7oFr3w2/alrT+GEi43eBLp1Ida1gm0A0Vu6VsxGU5cyIgbXX+dsLOhCyc9TYlVFQrXgc+PxPB0rx6fTDkVm5Af1G43Cn3Fv8cfrXFWtkHb+qsuTPNziSdRhNPBJaDicPjcTR/YIPRETSX00hFtm63r7iOQA97WpDvS52Uob9GsDN7Z4XsDhE0mMaTdmzltamwpkzxTwe0W96z392Gh2pQhH4K8YRjeHZsIcVUm6gT06TA/FGYE888DPz9bnF4JzPIWJNrRZFJo1vL++3zfoNRzx+7RfOCVVS66twFwMq/S4Ur6eOPFxZZ9PhULky7IzHXgLxt0yW/EM/0pFT/tpnZUaPXJCfoAkwXI+Ba8lHnS7q1OD8Wrkc8qm2CvrTuotGecDLysE07xLwlDIcZYLiUVLmCw3e4Le1AMvMJ4s2i8mNA1ZP6fv+Ivv/fO8bugEfprcYDjX+FWJtGwmrQqlryGA6/vkFOHAO2IB2M4XJ9silwQzQUTKOaPqKwMpCI2u5zl5g9kLcVU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lSq4PLIQvPXrNMq+C1latJU7Pw46//ClDM667epSVib15TAX25uAImQC+1?=
 =?iso-8859-1?Q?19oKZZ4GyBbb9YGqcRJemsHZ2EYaePedi8s17uOWAWAMagBwdb9Hij/Ig2?=
 =?iso-8859-1?Q?3Rg2OUCNjNvqVvjIZ0+N4CeKZZvH01C6JBVc1X8Gt/c2SD8csOzfXxV3Db?=
 =?iso-8859-1?Q?pw7oWz699REF+N509RuvQhWVrINHrxB7Am0nQ+Eyk9fq9cClG1hS5IY8+X?=
 =?iso-8859-1?Q?CDvCJ1iqMNvV8AhoXUf+ctdWdN2/70FCmKNIY5WZoePnkkOMFD0MMk6jqx?=
 =?iso-8859-1?Q?Sv3mmmZuymLiJQykmalBUcIu0X2EQRTBqyEIaxPEsA+MX2NQ09bLhnvoCk?=
 =?iso-8859-1?Q?dibq7uU2zgvd47s86Jp2/S2RMHlxAsHKi1QvrpWFG/P//kEOeTVZLG2vqc?=
 =?iso-8859-1?Q?JudbHzjdj/nwTZWBG6nxnSoLYVVIZI4WyWrpkJfUDCODc3Aii4dqvxL2Oc?=
 =?iso-8859-1?Q?810XBzbhY7f+KsqETl7+LFLv5Bw6s9XKiI0TKMsvEZaBWgcup8PwIYxrk7?=
 =?iso-8859-1?Q?1w8eTx/i2ak1An9RzgrtKUkDwNtNU4qcLHJDvRehEI7O8gcwX5GMlB4xBa?=
 =?iso-8859-1?Q?8uV1BKvQkw0tNH3mEWX/GaEZGSmtqgz1HWbu+TYCBFT8RnNPHkcK+clcto?=
 =?iso-8859-1?Q?885vPTzEk7lFofGSQ1fbKHlPxVglWwmIC69mvJaImbX+4jNFFYAQa1tFho?=
 =?iso-8859-1?Q?CgX0C6WS0DmKE4lIgR0JU+qYoKlrZ74ZHcvt7fsIoUw/21IWOrCtNUVw7y?=
 =?iso-8859-1?Q?CAO5c6jd+cWh6s+SzLNUqYtLoFAoK/6RDNHKLYZo3n/bu//U0ZJDhbV6Oq?=
 =?iso-8859-1?Q?TPKTBP+hcoy9isbRTFc/5TaPcA+D6m8KxOYtG8akb8GAyDJYgll7udrDqg?=
 =?iso-8859-1?Q?uEsFFPhIsoBYMdH+1o8aWYcg6PJvo6tBSrWveHd1FgpWMMsHugFd5zDZll?=
 =?iso-8859-1?Q?z6HYcZGRV9nNzaAcfDGRpf95juD+bPI4OZahziZGOh3ITeZAGADSUvombM?=
 =?iso-8859-1?Q?gqrh88Wx+yJG4E48cUHex74JNaYseXpqiOq/7MjOO1xAL4jTBEr9mAfEl/?=
 =?iso-8859-1?Q?1iweGGHSoV35lfR21NXZCQZMnSz3A9rUpOz0w21/RUKZ7HekeBLxaeuphP?=
 =?iso-8859-1?Q?YmqVedxDcCqHegeEnmYuiX+NfUbJUo781I9RPkoq4ml97EnHgAkb3YXypZ?=
 =?iso-8859-1?Q?gj7lSBznBB64/0edWD7A7eZ96J7mT51Bi0YEc1Es7nGImhAmAMpyKp+RWc?=
 =?iso-8859-1?Q?gtMhwyRYi0BAbDcLcaRcBuSjT0VI1CNm1sqQAf+wAiqmSFuVnq7DbQPA7T?=
 =?iso-8859-1?Q?6lmG6hEvCuL9wAdByKJVCTUo/zXYxRB5wLl17mjFnVH/uKCY+rwneqmvbw?=
 =?iso-8859-1?Q?WqGTquEUXBpkvsSipuOS7u5NmcWwEwZwWWueNX4e+SinvUW4x28qkjkARa?=
 =?iso-8859-1?Q?u7BRckiRozDOWzjvzzY0aXefFdu2zwN9LvJIOg9sBCVmPhDYxFZ0fNRmkS?=
 =?iso-8859-1?Q?LgE89vIUXRQ+4qbCpO8883Eiy2BLjqu1ZtOqD6wA6g1x3kLpgQWA6r2BoP?=
 =?iso-8859-1?Q?vTur7fgiWUKZq/zhGBbqvSeE+xKodEFADeAe8wE7UmufvaIDTijec8zPln?=
 =?iso-8859-1?Q?bomH3wY2XiO1mPYwgnea8HCIwrxGeZjS4jQJc75snKzrVjgQZn0so+cuZh?=
 =?iso-8859-1?Q?V1dglx7wIRYJJs84C3F5a7CJ6povbUbE+wEx07hn68lvAG9MQPcbxSF30I?=
 =?iso-8859-1?Q?g+YIj+b0Yl84v+XH0g+1Y5FoIvpFNO7L0OyQpZGmj5xvLG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	4BwkCAJXtWDpGXIl4ybPxQZkUnXSYjyohesTj+aVZ3MTGvYHmx7OkGtnMTkcH7fj5hQjVylYl2b1uRGo7RUwTzeRttLW/8RgEjE3bcYxMNM1k161VO1CfX6PkrcsN/0EAb76Pnf58vRZ4c1ZLQwU6juLcMJL2WRwg4rKTJlT5sc12K+BvjASjHT+eQ+akxPvN3eKtD9OPJ7RmqNE25grlINDhX9Xe4H+n3Ce3JbczoqpYQAqvZ8GyaKlYRbkZUUBWZ1DMgFkq9x+uH4QIisvOzWcUoIwmKfkkpRBMpksmtdVHBXTt5pGLUWFftH9Tqnq4KjtHPE5GSx9/HYhpbHS8g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96c3639-5522-454f-4c0e-08df12b400b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:38.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gd7tzE640M2RgZ957pZ5yNuMnBrHYEw4DWtc2ouLBHekw4yobohdK+A03ILMF2Zm//DEcDP3AJBlatNUfDOXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426845-u4TwTtCHfWmQ
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426845;u4TwTtCHfWmQ;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> Could the commit message mention the NVM shadow write, the sibling-output=
=0A=
> phase restart, and the ~100 ms cost per call?=0A=
=0A=
Yes -- the v9 changelog describes all three.  The PLL-wide=0A=
divider restart is the chip's only phase-apply mechanism; a per-output flus=
h=0A=
does not exist in this hardware.=0A=
=0A=
> Should this bail out apply to every request?  [zero cached freq rejects=
=0A=
> everything]=0A=
=0A=
Fixed in v9: when the cache is empty the setter seeds the rate from=0A=
the divider chain (the same readback frequency_get uses), so boards whose D=
T=0A=
lists no output frequencies can still adjust phase; the request is only=0A=
rejected when the rate cannot be determined at all.=0A=
=0A=
> Should the positive branch also reduce modulo the output period?=0A=
=0A=
Yes -- fixed in v9: both branches reduce modulo the output period, so=0A=
a positive request larger than one period no longer programs millions of VC=
O=0A=
cycles of reset delay.=0A=
=0A=
> nothing recomputes it when the frequency changes later.=0A=
=0A=
Fixed in v9: a frequency change re-encodes the cached phase adjust=0A=
against the new period, so the programmed delay and the reported value stay=
=0A=
consistent across rate changes.=0A=
=0A=
> Can a mid-sequence I2C failure commit a half-written delay word?=0A=
=0A=
v9 saves the five delay bytes before the write=0A=
and restores them on a mid-sequence failure before the commit, the same sha=
pe=0A=
as the DIVO write in the frequency path.=0A=
=0A=
> Does this match the commit message claim that "what the core reads back i=
s=0A=
> what the registers hold rather than what was asked for"?=0A=
=0A=
The getter reports the administrative request, which is the=0A=
convention the cache implements; the v9 changelog is reworded to say so.=0A=
Sub-step quantisation is bounded by the 30 ps fine step and the request is=
=0A=
preserved exactly in the cache, so the round trip is stable; reporting the=
=0A=
quantised register value instead would make a set followed by a get disagre=
e=0A=
with what userspace asked, which the core's equality short-circuit then tur=
ns=0A=
into an un-clearable state.=0A=
=0A=
> should struct dpll_pin_properties::phase_gran be populated too?=0A=
=0A=
Yes -- fixed in v9: phase_gran is populated so=0A=
PHASE_ADJUST_MIN/MAX/GRAN are all reported as driver-api/dpll.rst prescribe=
s.=0A=
It is set to 1 ps rather than the 30 ps fine step deliberately: requests ar=
e=0A=
accepted at picosecond resolution and encoded to the nearest achievable=0A=
coarse+fine delay, so the request granularity, not the hardware step, is wh=
at=0A=
the attribute must gate.=0A=
=0A=
> Could both comments be reworded in terms of the slot [...]?=0A=
=0A=
Fixed in v9 -- both blocks are stated in terms of the physical slot.=0A=
