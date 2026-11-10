Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342401;
	b=NAaWGI6OjoQ1LFBvM4217YQ+FLJ4NVKfu/zUgxSKulTFzWU3GJ1Oupan8J/q9C9PUltn
	 1UWicj76Ag7fSZv1hdZQt9eW8H6aLVNjtd9B2/4slP1In72JqrpqpoC6BHRaJxxO96H1P
	 qLeculC29TYhjbH+CATy4A9K+nxR76UcN2KziWfUv/ZRgMTaq2ACeMfZ4TcqukWb91DyZ
	 qllYFM2EIqccoxQ41hHVbv9nuAU6ROfCX8eehDk+d4aKNgfoomHg+6cuepinxH6vBB+MO
	 pdJBt+DdRK6R7XLUFgYu9C3Ba9aPGqG1NU3E7s9m4Y0af2LzfF5V1ezt4easkslpKwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342401;
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
	bh=7ajwQ3+SC3HUCzBCRgp4yis1WkABC9Pgzhm4LmIR4AA=;
	b=bVHMtrPwSyc3IfmI2Cv8TqKOQWlkpzryzdRsQOG57hsKXAUlafJt0FYBb62erD06rSED
	 8rsCetPzXj3fznlPj1Pwpfq304A1SuKhOgml0UtnbD6QCk86JKwV1wCMR9bQKxnWBUseJ
	 1+0u17BCywQJ9S01rEC59EW5PjOAEX0Tz03jxXBP+FAeAwS9b1Nwx8tASb/oDnMsQ9547
	 ERpc+D9KhfZDK21yVvdxXimtjzJ75CARrVjKeGEvnkwTogpgvQ8ApowS3xYSJhV7fIvQK
	 n96Vannv2SGj5cMccWqKltbtmDDPcSYyIiHBH/oOw+K6ROdpYQZdW3Nskb/sVvWsdPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=XYhPHCJ5;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=Z88LHHKt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.164
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC660A6F75;
	Tue, 10 Nov 2026 20:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DAC660A6F75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=XYhPHCJ5;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=Z88LHHKt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=7ajwQ3+SC3HUCzBCRgp4yis1WkABC9Pgzhm4LmIR4AA=;
 b=XYhPHCJ5cW9Yr4HveszLABcyoQi1NcTGRG8a2FhWWWYtHTAxJ/WfIvVMIQhbgXYyKfciY07yurdjNOM73+NeqjQTRBQSc27Le5yD2IOuqp2YTh39T79gEm3aZRyb3d7howVTRN0l2jz9y9JzV05S3bT8+CjqWTp5Dr78u5wwW3C0GKpYdvb1brCZBVSq8a6LB8dpZDCto/Cm0mGHAwzdI3NWXVGiqyvI0J/XQlopooP1Qo8nUD8MbYfRUD/BIxomjbboGCsHXeqVHgGOiN9r0BpaMadF8IiizL2oh4iz7cRLfOWWDN5gV+3IkZ+dx5keYizhy8CHruiWYwJzkc8Umg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023085.outbound.protection.outlook.com [40.107.201.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D5C6A3C0090;
	Tue, 10 Nov 2026 20:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9YRuR3VyB6xst2HmWW66ZYWnh+FsfuQ1QjTCeqAiX1YkOYiEU7rw1US+cNTjwEQOP7ZM1sr47QpLh1k6j/b7mdgwb6NVOet6xEYrOgSQg4vAl39LNSmXZ7wUSNrRGEi7cSEdB/FL4DsXVns4p00/mil2c/NqkpaD7xzL3YgIXi2cUHPEkJ72yfVg/PlxC5VYs/hM1VQF1PCw/OwxVLJrwt45InF7Fx6GGIFg6+88sED6yuroyuGsRMjaA1DdwnmVFq3hTPsUKvaGrNk2nw2czZfViAH5OGrUmOPMGi8UjZeek5Y/vP9igFqE5AbbQD4dAkV23PUcgTZ244LlcgUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ajwQ3+SC3HUCzBCRgp4yis1WkABC9Pgzhm4LmIR4AA=;
 b=a4sOKI//BxVa6XskUAtzQH+FD16dv91AMdreXQFi3HacQeyUOlgIcgxEdBmakiSaWGddUMC56t0iLuO7pUMGSFe30NU35qBjN+y0ZPwkfuv0YAfLCFOSidP6h0truJJoa8F9YTGn5Cs+Qf/K6zcNDqkUiT+b8lCL5z2AClJVZDLp5O53N13P4bUArml6C3H04sZ3RyvIVWeBEG5BVldYdlQ7TKnPW3Hq9R8dsRWE9cBqHw9ZqxNe+DT1HkeUkUcEQWneb9iEpqFXz82caLZEaxMHxd9WLv+hsXkinNBl4hGEOJVHa1nG6FJarL/Y0xM1u/hOhC6Fw6SCrvorcniHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ajwQ3+SC3HUCzBCRgp4yis1WkABC9Pgzhm4LmIR4AA=;
 b=Z88LHHKtDPV7KQAikhXy7zU0rbDY9VDECf7r7JBLlJQjyE/ir5OUEtIBBfJheMQ+ye05bfZ/lFQp4ejSCXLb0pEE+RVoYrs7ldaghxl9vhCDWewmUB5To2mJw+f9bPenP2g+DMhMzBIL4UQxKesZOsRuOFjCA7eRBwWcr8Yqud7IBZZ/cULR0Ic0Z2vdE8KMEOcxwSfVv2CQkMYeBSxy/NmlbzaIsBUzBhtaaTeIsoQ/NgTXl0qA8ko+a+eF+ZkRRZlvqU8ObkwpiT8VU7rRUaIgo6iMx2E5z9MSQhrY5dmn96lihkqITnidxpfYedhAptFfe9yGwgkJJC+PKjCLGg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:13 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:10 +0000
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
Subject: [PATCH net-next v15 02/13] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v15 02/13] dt-bindings: vendor-prefixes: add
 SiTime Corporation
Thread-Index: AQHdcVG599UMxIrrjkSsN286VGwQdA==
Date: Tue, 10 Nov 2026 20:26:10 +0000
Message-ID: <20261110202607.55744-3-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: f81b2a60-c954-4f00-973a-08df3f68dbcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|18002099003|22082099003|10067099003|261009223027099003|261021121427099003|261102123227099003|261026121527099003|261022113327099003;
x-microsoft-antispam-message-info:
 Cp+zGrUsqjdpwdbWS8u5SinDtpa8CKJKVJ3UTliEAt7muCeFop8bqMBGXPM4/G4cRcx+XKuFC5Nqu6NmErAmHhonpDrZ8/9nXabIOlSCh9mLGHrBfmk+nXE3XVgL+h/S6A8D6F5o24JMNsqBbLq/tlvtoNIyURNI9X+7R3tYcLQ1RsYraCIn8PtCjfLFIsgcgM6mBU0ZswrckWgDwzrpOsOzf+ux98oRW8B+0iyGYm7/HTnz/OTGEjDstlnz08fVfHo358yNd3pX7x7lUE+coYsIC9ubsgEOxtx9zTzE6NlPAki6brfLAGEjoCrEQgnoqgarH06F/tCluMU+bHALD6kHWwo1Rto8bTu61SPSg7zytn5fZi7nL9WeyT6SJupjc6tIFlvYRbdqZClXzJ+H7NdIBl1FRPUy0kvE98qu+KGeQLMUFqawgLf5h/DGfnmrgGtB0Buml+/h1EXw2kk7PIEtpy+EUV9sLIFAkErYujRQSR3u6x4geGllNhICSQtpUdEXpQGVqQEJ/Og6u8EWVspCiee9B3L7ZVxDPaSwMQYZhM6E5iYLDRWgvish1Q8Jax3qTqWHwlNCF0MsEFUNLkbWWdT6v+YZ8Bvl9LOSatl16zOew+dtkRmiDDdNgioqcNSUCfVuBZjQ8dNWlxUcaEdwcIGQg7BZcAVXdh4SsJ7q++wBSFJLOeSL4Iw7U95RY9RpjGvZTuQr98ftkPQQ8ggvCfMVtOxDf1euTTel96w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261022113327099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mszyIYdCrJYmw5dJgdES75ccLQuyuU0uI20bqVLX+EhWqBN/VW3ZkGhEVD?=
 =?iso-8859-1?Q?2Eyb4GzO0+gt/GQRHK6BAyOtjDzfEHsnLpLEx3gj9f2WLzq5c2H4JQ74nw?=
 =?iso-8859-1?Q?dJC1dAgD6H1Hy46EGAXTD2Vw5MUBBGwsAIWe0tYdjxj7ItoFTWbgus0rhp?=
 =?iso-8859-1?Q?PpUlHYNFFX4xHag40v89aB/n6SjEWBMTocSFyLfc4+jcBmK9dKQXxrdyjg?=
 =?iso-8859-1?Q?cSALFjO0iQK6Z5JJSJRF1V6rkDXl66G3T1zf3bE2Bd7Ca6m6HZ7SEOCvRH?=
 =?iso-8859-1?Q?QvOuwokhu/HidpE/g0qTQhK8M5bM933DvF8vc968ya7ZOEXH8B7HES5YTi?=
 =?iso-8859-1?Q?WC0oseGZiNMf+7pgZ5jjxr2FjswweCRQT5GRPrFHu8XtHJgjnXGrDeBUVG?=
 =?iso-8859-1?Q?OsVgtP5tIMuxWaZknSwI4BXo/NaQ3pYblO7vmZ7K1ceS+Jfab0l2Iv/zxQ?=
 =?iso-8859-1?Q?1nDixqV3SgfQXOl4xp9AC3yP9VocIC/Q7rsiaTCT7st0tBKg3tpMKAqYEt?=
 =?iso-8859-1?Q?NPX+hNyLqSQ6UsaycR6vAtHbQRIYfhh2VkBUFHsB/2j2LzJgnigN80p2T8?=
 =?iso-8859-1?Q?xgXl4K61/SoXU8sc2jK1Ea3WpmP1XtHJWKE0Xyezyf8qAVJfIXkL63PwBy?=
 =?iso-8859-1?Q?MA1Y8eq38mYUUkMW2lvEqsZ2gnqzLbFMP8F62z2f+YEvU4i/twK6FD76yo?=
 =?iso-8859-1?Q?RIw1Uzy7IXSLvjYa2rq7ifoUK7ioIHQbEWsOATFagJhBgUhKwdwdyHm2YX?=
 =?iso-8859-1?Q?1rqWBiKjIj93NKY4sGH7Cus6+rxi9DpcW9fhNMijAsCzaR5Lc+Owio4VvH?=
 =?iso-8859-1?Q?sEI4S7nPB3EAHcg8PzImV2THR9bwIVVgDq2wFDXA0FC1OhJwOunNNbyv+7?=
 =?iso-8859-1?Q?B5npJ+a/kV8sCLw5pB4hApyLTnMj9nnd/WiJrtIDfwWfFTjaf1DSgAQxtZ?=
 =?iso-8859-1?Q?jopt4bYZJ8H1+iCuTu+PCsLpq8hxsN9aZ4nhm6o/BEVPAfR/1VEd3/SBPO?=
 =?iso-8859-1?Q?BMe7f9HsB5BhfAEln+SRCXWb7FA7bVRZZd2KQH59KibPkfrhjNTrNR/i9W?=
 =?iso-8859-1?Q?k+Z1HR9M0hSDK6FVAVj8BkEyYNcBj96V8KEHlbrDWrjKHoptLv5v5GYvy4?=
 =?iso-8859-1?Q?ZU1FWqLRET3kgCBwXC6uwMJesZZfF6H1NwYK7gMFAy9u4zBgqsg+6Wpnbn?=
 =?iso-8859-1?Q?f1ATJVcKi65MBNxkP+KGge0rJTdRml31tWFVugZF28RCKf0IZcYGBOu6+S?=
 =?iso-8859-1?Q?DySzezhAw0RpWH6QaoklZHchHaZV85Fw1CSAuyj9mYqryxf5a8YC44YjbG?=
 =?iso-8859-1?Q?otO+w+V5znpy4GrC+uEF9P9rejJHiY1/+ygltlK/wSAtvNs+gmV0qiWTpg?=
 =?iso-8859-1?Q?rWw4SB2a1Sy0UWktqYzw6cS1PhAies30IF0oKKmg2n7zOPHGkE0tFd8hv5?=
 =?iso-8859-1?Q?/Fso4biAKZ7RnAGp+UQj1zvalqJrcVAjQXTJAWYeedJNay3XZvxQH7BUWp?=
 =?iso-8859-1?Q?wSx6SPN7PMYFxWL73OlOPPeQUC1AjTGKUGrTlGNRqKCImjhvv4nNay7tOY?=
 =?iso-8859-1?Q?I6gMVM7w+B9Hct+urK5ysXiVCn0viLx+JmgH2rbmlXMB/7FZxeka/rOPgk?=
 =?iso-8859-1?Q?477Iux03aZsxzNWXO+wMD1X4xaordZrdUAdNAVbxuHTsFvMv9To184vNqa?=
 =?iso-8859-1?Q?yrqr4YS39fy+uf2vpE9gIKqhuAOJIjBU8Phos4hg9S45tUVkeLgaiOOGcF?=
 =?iso-8859-1?Q?CGKVDB0Qp4tji+7H/ayKjZ2vV9zfATQSBW28xQXBfyw3nx?=
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
	sxaK5MAXicwPcts+MFEbbjZ3W4vmvMTOMEWzlAS82IEPzoLUHmwpkTg4HOHTWfZlKtv7ZuQ0wrO3HuOLEBHPGJnz3H56iZ7YoVOqvE0Jt0HyBUvdWT6PUCqZ7xSahhpRXn4Sg7UsBpV3zhVo2GhNO3x755+f8VNmZ8pxBUhHrO+ThoqTuZWutGeZjhqk96hvbvw4f9yGLKrr24ODlCq6jFKgDS+zhjDGikYsIPwf35gJ30Fw+SKJKazF6zJ4se0Anxoew3nPW4/vym8lY9aLYCakGHC7gfKYTYt3obMUqLlwSsNUkxVUj+SGX8TRresClUNDz2h14RCwcgv26eTwDA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81b2a60-c954-4f00-973a-08df3f68dbcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:10.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHq7usERKXF8vfIAV+8zFcI0J0Jn1FewhjUMBTQyhNNT3zHclcWYBow4yCqsXus8/NqJ6N+S37UjyYMHTcbQAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342399-izg2hCKYfFC4
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1794342399;izg2hCKYfFC4;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

Add vendor prefix for SiTime Corporation, manufacturer of=0A=
programmable clock generators and MEMS oscillators.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Acked-by: Conor Dooley <conor.dooley@microchip.com>=0A=
---=0A=
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml=0A=
index 5471a06f93f1..b0f26ab800be 100644=0A=
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
@@ -1581,6 +1581,8 @@ patternProperties:=0A=
     description: SiRF Technology, Inc.=0A=
   "^sis,.*":=0A=
     description: Silicon Integrated Systems Corp.=0A=
+  "^sitime,.*":=0A=
+    description: SiTime Corporation=0A=
   "^sitronix,.*":=0A=
     description: Sitronix Technology Corporation=0A=
   "^skov,.*":=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
