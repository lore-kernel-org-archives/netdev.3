Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B83A9639;
	Mon, 14 Sep 2026 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427161; cv=fail; b=l8/j38FrqtJHdCPBrQhE+bnJLe1IYGBmAA9O6Y+poVBnoTOOebmsruIaVxM3dDFiXqNCpXKfQ9MtVWGxFHKNV7OfMcdQuQtpl/RLiEr9hCfFmisgvDmh+8NTBTzpmDSWBoP5Ktc3KS4kE9giAvrsBH6GZkPkWFcF497DJcwX+OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427161; c=relaxed/simple;
	bh=IbIAevLmgpwgQlvCljyaZOhUiBVwVFl0TILNweDCxbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=htwZeg/0bUYncGK32zm+WNlxDBf4QoUJiRyinY9pbV+iuNDc012PIKOMyRU1PnCN+AL+0K9gOKx3z5r06xSljrbm1Cy2+5TFkg8+fy2LIog8bRy8NAh1aSERzpGFSZYz36pTW2ufHeEXAyWsR2TC937oco5vkP6tJ5FicTjxmjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=liXpwO7B; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=zjz4OhUd; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="liXpwO7B";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="zjz4OhUd"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 031851C6257;
	Mon, 14 Sep 2026 23:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=nWGPdbyJr76o7WFn3S+RW2abYlTblrtiAOFT7X9Cx4w=;
 b=liXpwO7BBOecMLxDp8S4IUTcy4IT6sqbn0FoYFnT3OnWhUIjUtPXtoMvJ0/iscv2vX6qz3Qoy7tefSTSOKQzvNv/snZdD0R0KJfgHBNFjSJ1zV1Qxu8ZJwLlUUJjKrHp10YJ68x2Ad2RcVymGmk0PefiWpt1vokH4KY0TiEuvaaa0QOetcVcbjA9nqo4HvY8kil3C1ocBgdpWDVSB2cO7VIZl7lANgOIcie5yk+Si4j1G03lviYtAph7W3ehs0vJlva71bGqITV0HXVpwC9uuw7lAcayXVXZvLMXth57caMfW6Y8Rb9+WNFGIjd9pfmkve3NC+yn1eIHEyauqlTiBw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021086.outbound.protection.outlook.com [52.101.52.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C1631940095;
	Mon, 14 Sep 2026 23:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQoFflPTB2odh5jTJZdmpkPLZquhmZha0ISRR2uKjEWUqcj3aspQ2wArBGPj4kahYceJ7KZL62bJwdBfHmjgMVnlWygrzEE4N04JxRWUsoCPKp0XrgfIP+xPu8dIF25svY3HvSDCwPVDn6wCVYQgM3OVEGmDi/pa952utUaCb5/Wdp6Vo2wbFHt1EjiGQrU8P1QoGl1wGIxPS5dAD+fJu2kaY1m1PJ/1RD/t4CiYAat9Fmm5fRaZO0EpAQGkbgrwUjLKwM/yBdIvcZQ0UHidmyVo6N/KfCwcX2iOJ5NVnoCabjDYFBMKnX21iyzRHU4pU04sWHBW8DWSog6yUD+/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWGPdbyJr76o7WFn3S+RW2abYlTblrtiAOFT7X9Cx4w=;
 b=JnKMZjQRYTJpFwHMqhS0eSv/pj6F0CYu4nsweUgCXWuBNMnyZDaHjYKlZX/TynYrDsZF4jen1ErhDWfbzyr79Ktnf44yu4oFYSbCTNyztZD5JWBPzYmacLcCxyeg/0xflTm9k59Rv5X5m3HX9LHm36ESJ07UAsj1Fgsjs4W/Y+Utxb73Gcj0/VkjUfMCmwgm7ABKRxoGD1+O58+5r7/KrAaLndVILkYABJFbHOfSVOlu5uv+ZQIzr5EVXtJ8iYRN6StJnIqJMPcPDEu7ArxdDfdFimhKHpk97/FJACMrxGjg5iu9dT3KJvUg2dmmMiYwMHK56h4YrJ04qIs+frUlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWGPdbyJr76o7WFn3S+RW2abYlTblrtiAOFT7X9Cx4w=;
 b=zjz4OhUdtoO5YK0RiZ6S6aeLSUszjc7e6TwPbLEMqYGAC+UGLvGyM0axvC6Gj1gjf06yElAGd4sJv6DTDqyEalCPJdHvmNKTIC4agvKicxTKyDmqmSfztRVw8LxzV8O6WGOHIWujIzP6cJ+IK1qIkr/GwLCKq1SmhAj1jefiksW30kLY+vsGQRvkKVV1r7XigZRPcxf7OMIVCVrYExRYkomYqpEubetBu3KIfhnuw76T4JqALMDDz8a7lOJHkcVZ1yR/kd/L9NlC9hLN88Qk6inE6wqN1w06VpoZ6ddpD/cj6WbUlxPL2KZPCvhjY0DNCNgs+jJjpE/+3tFHdwyBeg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:35 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:34 +0000
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
Subject: Re: [PATCH net-next v8 02/15] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v8 02/15] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Index: AQHdOyOuGzNhwr/bM0uX+E4HTMfYqbbEqX6AgAoZ3AA=
Date: Mon, 14 Sep 2026 23:00:34 +0000
Message-ID: <20260914230034.63861-1-arouhi@sitime.com>
References: <178887151142.219967.9831378889406001382@kernel.org>
In-Reply-To: <178887151142.219967.9831378889406001382@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 48e2a41e-c15c-4062-3ca0-08df12b3fc32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|10067099003|56012099006|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 kXOndVIYIRHEtFG1n1XatM3ppF28Xq6xmGNWgyl3g2UBRBlQT6PciTSIS+CPjIlLm7DR0J46KhD/iOUALT+33kNRiWW3xWkYL9K0MXGhUz7+4E8nox+n+LonCMTZair/BX4c0H+FOW1YcS0tLKruqNCs6cTdjngSnabuh+fZBLbCMLpmz7Qv89UEmD8zP+skSgyBYNvF1wXzkx1EQBHgzYOyS0lxqnkcT/9nEOt2s4ou4Rb3WZ/X4WXDkMXs0SLWe7S90vn/nsuN/w6wL8zcgVPj4FrKGgXJQuPwTD1bd2hASQajIvo6TRqNzfoeOA/WpARC3voXzxyrEglAtXOpx3gh82C2kqV8UZzGQtE2ZZUG4fBe8Zht75E0h6UTYO/3v85cjOytNvlX0vZAaZtNI04TDPfZWBON3Umo3cP6v2g6ZqnrDoqvuEITMvtCf8SUvQaCh3Mkqfu0Am4cpu14LNKMQHWdjkKtJFjn1jkrn3gpbBL9twLrGpF34B/OLoi4K/StOxzKVf2Fi76CvDh6REBtruiSACMzZb6L/xPrhR+0voJ+vj3naXqfQSNp7f/D/4PLWKn8SlVUKGDKu/ZUc2ubkSficMPiX3IejAFn6bQEszo4KTDiNNgKB0XI/QnXxtfI9DniBBIxZ7L0n8Q6Ivynf2i8Ym0t9A+c0cWz/g1PtHdS+ytkJ+JlyTHxbN70fPuRXoWTwNmkA2SCeMII+e5r/kvC/j/STc3BkXlIZpI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?m5E0UH1H+vGCzcxamw+ADD4yhVQL5Ubh+dEhha6ExvFFRnXnLCJHrAXGwA?=
 =?iso-8859-1?Q?ElMJn2qihEiIQIOllrdSA2b6mtqkU54HfcWfxaXRm9YtIH0hKOqBiUGx8G?=
 =?iso-8859-1?Q?K+kwxKZ86Hee4vf3KiPdEBwYdTTDvaNnxxE254Jn9J9/+yj9kTAUhIbuDw?=
 =?iso-8859-1?Q?yjGko5YL1oaaCi2RQsRvmY/d72UKocG9Cx0tkqYS/MR1eb3M9GQC5tPWcS?=
 =?iso-8859-1?Q?MMoHYkjUJYB4zNY8+oVlBc56K/CP0Z7AoUpqF/LE2anH0ihCVuFinHG+cK?=
 =?iso-8859-1?Q?/ErC0YAFwrgxixpJlk3zLyA8Z5EAaiimbln54CJP3hNx8hb5TKdGrtMqsw?=
 =?iso-8859-1?Q?ZzTnRgNE2PYLKMYNHzFg4/lKd2BFcG1CoGe4cOrkVR37BA++Cs+QfNIU62?=
 =?iso-8859-1?Q?SZ6ygU8AMY0Fh8JKazN5Q3588oR8AVDTax7JaBDnxF/qNShvJlVFIQU1vr?=
 =?iso-8859-1?Q?gHLKf59iye0m3xJSiddFabCQULnGLzRuaZYZbKamKVJn5M2DVLkttM6Ckt?=
 =?iso-8859-1?Q?U8RBvFx5nRMgRiHMeq5z9sm+Rffurq3hl/XSMXsxROoUe1n7UYpCNNihtF?=
 =?iso-8859-1?Q?fzE0v0PN7l2ZfQtHJRngf5s2hUbDbOrqmwHy5+Ru4dSKQdFpB9Tfd4FJds?=
 =?iso-8859-1?Q?dEPCedOJWcHJxFfvBvM3QVQO1bxvStnggxXQ9vahidCr4mP8t8TY8D6X96?=
 =?iso-8859-1?Q?KoNR7/CkLNx1woppitlXz+vWjti5SI1Ci/1Div+XqQgQZl4YUX8+DEuqBc?=
 =?iso-8859-1?Q?xOw4gaFpNg1wM8tl6azm8Wr4dwMwW6+lQ1dwhRkvlSuWSczfGKihbMVW3r?=
 =?iso-8859-1?Q?Q4j063ycO7Nudig5kx+ej7EpooDcmw40OtcQSpcGX29GnG14PgQmcW061H?=
 =?iso-8859-1?Q?JTSnN5wO9phEFkmh/XRBgbOnitsiuSixqYyu4jQkQfmQiyysUi/lBK47Rj?=
 =?iso-8859-1?Q?fnsrQRluEyzfbQOY7RMWXuzwrc8csfKS3pJNL2QizsLwgKBz8VAQls7hrx?=
 =?iso-8859-1?Q?yVAUzQgKG3zpxmuK6TXA2GAmBNbsl1zvfyK4tQSZyO/1FAOJ2yoTKFVYWa?=
 =?iso-8859-1?Q?OzclahMG2GzvSsPK05VRHL1aiapfyG3d9eDF7NtQZVOwhX/8bYPJckLDg6?=
 =?iso-8859-1?Q?u/Qi1pJMSYRxcaSmu3YVongpR07JTr7cd1EjarFaNRWQKUENKaqnHE88gg?=
 =?iso-8859-1?Q?n/W0COePtfjqXEFjZ3YUEE0x6E/NtFDUNjcGoz0DEmadwppQz+SdLpIfOD?=
 =?iso-8859-1?Q?MgUL6OhgTXhrCpUdDqwOR3v7SPgchbPTnAyd/XslLrNDYtq5+1VTbFJpTW?=
 =?iso-8859-1?Q?QaST3j9ExkwNVnEd3rued98J6GZcbXhNWqUxIj92oOXGyKKnKs3AL01icJ?=
 =?iso-8859-1?Q?vX2oCOFtDHYJ993V6/SZXnd2OzG6ufBYabUDjmb14AnPWHHeiMvJXZptH1?=
 =?iso-8859-1?Q?CP2QIht0GZtRhz6yYss97PWzex6rcEViffU1Y7hIN8qRibsUTJxbNSX3aX?=
 =?iso-8859-1?Q?2tOCKTxnsArC4AG0lo5lzWhHBgmc3y6ATMMx/qfvZ/BOKM/lxmGOghwnBj?=
 =?iso-8859-1?Q?hqxFOqSvTSDw1hE1jopTDAwhYxlhmc0udPiqzP7YXnzdk3zx+Ir3knNoqN?=
 =?iso-8859-1?Q?XYUpWq7vLOP3VNmHIm9C8l5fCAQPs9cqdgSLppZjBfbg4FRSk8BWM70W7y?=
 =?iso-8859-1?Q?bBeWFFGcs5ci8P6rW0Cz7ykLWIBOpBBhF9ttbUftsTCjNPcZT3Xh78Xmnm?=
 =?iso-8859-1?Q?hDsEgTIchk8/Zg06fk7/R9VhVLFbzInLUHf4W0DHa9HoAm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qV8wqHqPtWDK0u17dRUPTpboYjJvYFGVV7DBBJu+4/CaaUjkjinsnI+dwkMxWsdp3eF7iV4amkurhQMN/5jeqOucz2PoOXRmleWUa/I/JE+2cmtvKv421gBdvMuUUj8N4sfy/KKQfJ2S7l3lqYNG7gDQ/vaW4OCLrvzvCmBF/0HigmkdH3Po6k7tqzGCbDyJOqKoXTEojeuzmTiup+otMO29K3zwVjNJPI5bs50dftrODz0RMJCDv/Q7lgSHxwSQCi1UfLWacEQe3uoNyabXZ6jlhr+hF1t0FN4P/lp0SCryY5HauzZFcpuY9WXByrvzQp3FXXUNLwzR1E+/qDdqfw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e2a41e-c15c-4062-3ca0-08df12b3fc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:34.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wjl+EPNpHAJWZQn+DvL8Phc7PfRc13yHHXpR91Apd0Cl01UiaXzi1kxMrnTrAgq7oQYYZk1lB7uiIxulA9UKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426841-l5USAGoGVk_z
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426841;l5USAGoGVk_z;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Reply inline.=0A=
=0A=
> Is the statement that "every valid value exceeds the 32 bits '-hz' allows=
"=0A=
> correct?  A "-hz" property can carry 64-bit values, so the stated reason =
for=0A=
> dropping the unit suffix does not seem to hold. [...] could the property =
be=0A=
> named sitime,pll-fvco-hz while keeping=0A=
> $ref: /schemas/types.yaml#/definitions/uint64-array [...]=0A=
=0A=
The description's 32-bit rationale was wrong and is corrected in v9.=0A=
The rename itself, however, does not pass dt_binding_check.=0A=
=0A=
dtschema types unit-suffix properties centrally: property-units.yaml maps t=
he=0A=
"-hz" suffix to uint32-matrix (only "opp-hz" is defined as 64-bit), and the=
=0A=
meta-schema rejects a type $ref on any property matching a unit-suffix patt=
ern=0A=
("Standard unit suffix properties don't need a type $ref").  So=0A=
"sitime,pll-fvco-hz" with an explicit uint64-array $ref fails validation, a=
nd=0A=
without the $ref the values are typed as 32-bit cells, which cannot carry a=
=0A=
VCO frequency (4.9-7.8 GHz).  Verified with dt-doc-validate (dtschema 2026.=
6):=0A=
the renamed property produces exactly those two errors.=0A=
=0A=
The examples cited work because they are not new vendor properties:=0A=
"supported-frequencies-hz" is typed 64-bit by the dpll-pin.yaml schema itse=
lf=0A=
and "opp-hz" by property-units.yaml.  A new vendor property has no such hoo=
k,=0A=
so the name stays suffix-less with the explicit uint64-array $ref, and the =
v9=0A=
description now states this real constraint instead of the 32-bit claim.=0A=
