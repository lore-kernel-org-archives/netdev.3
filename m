Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342402;
	b=sMQM4RNKCNRA7GFIyZ981YmBvrWeiO02nMDemqBvCfj2lnulhFl03SnoRi66+tPANCdC
	 /9GVaTl8q87geBBcOcmY/HVLQkcVCRIeZXz4VNGVsa/8Hs7ztN5Mxr1Iory/AWcItZeVx
	 ozNgYkpd33zW2Nv16RPUtZfAla7QnarfptMl3krxSJLp3RQrTS7Mo5QFzdey5TB/F6Pw4
	 FAIKp5or9Ygl2hW7eYXeDrSWJvheA2/aik0EHiifoGRyJa4ePsNDPY8OsuJtCJnvgbVjN
	 kenVYVqv441Iz8maFAqEWwe5RB9B9Y1SX0IT3LobBt1sgbNvX9ordJuZOnLn33BXQaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342402;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=SND9JXDUktuAw2obMqnnKWhIk0Ls9zgpZgU15tGo9kE=;
	b=LLS7L+FbAjBtXAAdX5YD2SiQaf37EPLdZdW5/to8ig27FRdOKBncSZSuu3HQoAcDTD82
	 Gk8s/6Gxytf8ixj6xjm3aUJtmyMaEFlmvJ4S3Np95VVHbq7drht2GKsdd9DUJdU2zEzsb
	 EPl3ghSu4yb8EOWVow+xfoEls8zxfmtPhZJwKZaULdoyF2HW0tBLR2EIbEGUaJsMGYwB1
	 SgvUVI0i1Yv/vSuIKAmo4di0C1LWLOoEa7j9MCLNQWFV/eDqaVEu9cnTZM3QNeTrTjVY2
	 fJhYJ2WzboxyFZ1yTkkD0l3PMWsCSpeSPS80WppoN525TDMFODr49HxO6y9JQ/CfHXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=k2jFevpR;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=mdXwhtgk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.164
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D760A260B;
	Tue, 10 Nov 2026 20:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B6D760A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=k2jFevpR;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=mdXwhtgk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=SND9JXDUktuAw2obMqnnKWhIk0Ls9zgpZgU15tGo9kE=;
 b=k2jFevpRqB5HZY7g2UCWJKUxawfr0fhRydkTzwEbMme+JgxMVrKMppHirhUi3esB779QupdgHU0kR57HfjeSpaKV3kxttI4hhTHYZCgBBirE18E94yhYXnklZQ/qx6+uhRqnltF+tWIiSFCR4GoqDo3i9SHvqiQ+G9XpPmD7z44ZsnhVdLfBrNv0AIW4Z3JzQUOSxzjAViSsCeKFs9+tzZz6eSEGqunx8mrDTtO6oJ5aBCuG3EyRCcAI4w6AyLQdZcvC7i5rwUoocmEK9L9sj+tDRqsTtfQgmz/gps1h3o16JuTCDS9Xk8XaRuc+PkfHWFZXMknfyG+6xu9hhabp8w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023085.outbound.protection.outlook.com [40.107.201.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1A4C23C006A;
	Tue, 10 Nov 2026 20:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp6rE41CQfuE8atklrxtx4oyj8vRLOP94nfmzTynSWxTW7OPPzKEoqTzq8juhKUW2+Mha9cUfpDDVHS6oB5tM4K3rwT3kmBznUNpkvJjKfGCJlffWZolOKWdH0BIjYVuIihKe5ryGErClxFdVsZibTrIztbYv6NKPwOHTkL72E7Woadl+9GZOHdSXyd4FMB4MixeZImLYe1/zdUd5X+HfNUvo1dHZb29pquTc/aqCechZ8aLlntTpcCM9MV9ne2gxI5FENaVwpRdMHLseoLw8SLm13SJH5YNdk4lMD+gZ5S/AQssmsV76jgfy2HRsCvFzR4KJhvC5k2Ip/2LC21fQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SND9JXDUktuAw2obMqnnKWhIk0Ls9zgpZgU15tGo9kE=;
 b=sVvHqZEpNNwewLVtRS4pIgKhrKVs5Z1kzm1ivr7PjBzlWZqh/5nLDv0I5zaliBY0TLItZpmuchlnfbNFisYUtoTFqsRfyINkkoDet2gTnWUFp54kL+SII55MxIutFNPcqLMLsd1Kt62vBVlUWbo3UTAL/8BA2bz3DeO8He+/3OahpDBT6rO5M91I5dzXSTcPGCJRhyBjT/RBx6XGOtbeWQPVKo/k5crXHJqGldZ3FODU1ALsPlY9B0z2wB2nA1LZ/sQL9KeECvWt+xB+kQQLa21oN/qMXWZzp+WNJ6wKNxvd3wXtZtqtn36pTSrvMTLpzvOHztsXGUPXoOT3DHPcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SND9JXDUktuAw2obMqnnKWhIk0Ls9zgpZgU15tGo9kE=;
 b=mdXwhtgkctulWsp6J0TdyhFpTqow9hnbERVofrvB/R2vQNuXmB5mEnBVRGOPrGZS5QRucS+csTVWfBPm2lrfgyD9zsoorrT0KxDE1I/TMUy9669Dus4ytHkBTfRU3lTCHRKPMaBIHqvlIOvvBVte9nJy1hbMCc0h/dVz2rRIUO5oWwfS7CYgYYuMlBaYlFpIlybUiVqrxOjeby9U4rGuFe0mRdJ8epCXdzga7+uQkXw0+loZdmxMtRHJtk2eBw7OIs3JFDOSYdszJI/yK/kOQjfXhK42QHhX/bi2JWkQdHPp8jV7jTJg51hij5Dksa/oM3mTpYv7+uFntoDf7kj3aA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:09 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:09 +0000
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
Subject: [PATCH net-next v15 00/13] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v15 00/13] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdcVG4n8Ct+DKqV0qyHNDMCn5jvg==
Date: Tue, 10 Nov 2026 20:26:09 +0000
Message-ID: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH3PR20MB5745:EE_
x-ms-office365-filtering-correlation-id: 51b693d4-bd6e-4b35-cebf-08df3f68db09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|5023799004|18002099003|6133799003|10067099003|261009223027099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261022113327099003|3023799007;
x-microsoft-antispam-message-info:
 rCz3dpGaS8h5JAEhlmCJqzCAt2judEdsVTUBPjXNLiZx9tOHe9+TAOG0w3a1roTisaXi70eahn6bOV/eMd0tjjMbqPfQ8S+W1FxlnNuv9kufq/BY0CjjVpoxTIUT1mZGAKs+tQEcfoHPSVgISPo52wJdniuC4vGtl8Ky2jhZ1w4hsaON2lXlvNah7XXzqPHK88+GPHSWSbN4nJgFzzbO5x8+8pg/KZNxnX1gTmr3fn2UxHB1q/2VUj8IGAf/gaWstAWC4OYMwfSznx7MMkBMQLfpLdLu2r8Bw+ALqlHJm/7fuSda+gVw93a6fk2x1GxYtWAY45SvOAFphz0LBJwWJ4oN4hegt3SpGiZNpcd5mTylTqg1CPiiLaQk6+A2enj+xtHoLtrFzQNfEBV45Oa6NKrR4y3RLH4xUs8hBjf5XWaK+0f/ITHA5EGaVQTDeeqkPGvRa7UDGTGcLer+8x1x59Neig/ccmiz/E/mmgDkDWD0HkXXLD8hxKrbZK3Z30B6sI15ySzT0aGydPabOktVLL5Cloil3IJfloy9ua2FnhGfUKZydhwC+XOaS4c5q7z9DincqlEu1MisrnpRtM03H5EGlRjZtYrZ49NnH5ZCnkQuAWOzYcebhT3GErirSpnoxIzVaJSwqnDmEodAx/riKU7ggANNrSAlUTHfs9rRYSE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(5023799004)(18002099003)(6133799003)(10067099003)(261009223027099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022113327099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1HuBqVqjdyBYYiYQb2OoO5dXTyCjXZyqZiPzwu/UyIkMdzNZvm3WqNjHVE?=
 =?iso-8859-1?Q?I7lt4zeAP611rFKC0NB6uq4V9DvRSZeLCjAy3gqOQpaxJ4SRBq43sxCFn1?=
 =?iso-8859-1?Q?43QuSlF+EBkfpfOaG2ool5uW2ptdXH+DQ57ITp+bOPD7oE2p7TfdWMZaRU?=
 =?iso-8859-1?Q?apilLrMLybabv71bYIKuIIpg0SOCRigP1gjW2BphaYRIEEOyVBlWHPtI8O?=
 =?iso-8859-1?Q?HyEp6sMb2C0ZYeuFNoMSLT3OqPtL0/VMp/e7uxwOWRfjf7gGjsyRyG6u/Y?=
 =?iso-8859-1?Q?XtJvqdwPUSHw+pCHgrX2Ps0QVzcVzsMx8Yg/37INdnrFuLKHx+ZFtfgy0B?=
 =?iso-8859-1?Q?I5r1vqzVTj7b/gu+jk6NhfRdOkgkU2JqiRjFgO0PGEDuOzSfHjaMNVBdIy?=
 =?iso-8859-1?Q?vXunsX6IpHLQJuuY8xy13wpFj9SRwyH1+W9cHoDtRt9YaojG+Gu5miGj7f?=
 =?iso-8859-1?Q?Fk+jyNVcZp97B0aIuz9jWHKb/vPV80N7Z5Lz+saIKVCK50TJLFFKXz5iGm?=
 =?iso-8859-1?Q?nzplphKdoLL8/3XHXn69jXY+Vbgb5m6CJjal9MX9IrRuXVWALD5Iv4msjW?=
 =?iso-8859-1?Q?ntfuvp2eSrZdKg/PfwweTg4FgV2ly1PEfFHk+4yoyZbx4Ptk8K1c8JCJEm?=
 =?iso-8859-1?Q?8K32x5datbLDuKZdCrEDypk1VFKT5JY6kHOTPb9ELI+fQ/pcbhmYDfLs1D?=
 =?iso-8859-1?Q?0MWxWflHkU+6ZIw3aYBGx4sj5N+LjdoX1BcaAm3Vau0l6aSqyqmqErZpnr?=
 =?iso-8859-1?Q?h0eJcILeHKnnekcUu/KNq3tLSSCsnds+Q9kHU3/dROicOg7neYIWl1niV0?=
 =?iso-8859-1?Q?qpLgEsjem7Cfbh15tXFJHr5XSW1RlEg5iRkxeAgzBIiSvDKOJA2tHhOneR?=
 =?iso-8859-1?Q?ENC/VOgZy81XI/V1FEb7Y/XMo2ngWbHms7SBJ+yMoBZIz4zeKkr6FGu8Og?=
 =?iso-8859-1?Q?2HOv53RKcqPl0/SGxURvPjyUTqyXMWFRoNPbbQq9QfpobZQl5+lyGsT9Zu?=
 =?iso-8859-1?Q?d8tgM8A6m/yZNWT/jp/i0jk9Nm7U0y+DLIHBcNpDBemAMtOJlvT6H+3p8Q?=
 =?iso-8859-1?Q?KGI/ZKWWojtr5zJIi85Jr0VZ67VR1/QLWxFj4EeJUaOLlMvbEDun9c/ABo?=
 =?iso-8859-1?Q?U5JMawCwUfl0Ce3jO9jlrXcKtw//0lYumpEgbfEKVuRgcYKEXZ8cji5NYN?=
 =?iso-8859-1?Q?f+uCyRdGx+o/v1wl4AtKLoXhe1/0tkpwm2cSJNSjxhBynr82n7UfJ4h8rE?=
 =?iso-8859-1?Q?qA41N+DmlBGEDQB9LTwzaYKcTdMbw03tjYJSBb0o+K4jQNrFB2Ycl82HQa?=
 =?iso-8859-1?Q?ZCpRJZaeEiqsa5OraqK43P5Woti9b/W8iuxliUNk8d0gg6FrDX+7EspuVq?=
 =?iso-8859-1?Q?yrED6h1pqKeKsJowwYxJ1BerRwBqYxjMC7pgK0cTEm7vhiKrGGQoGXsERf?=
 =?iso-8859-1?Q?F1YqG8BdW88awU3WLcgTiWuiAy8zdZI7I9Ma32kDt57/AMFHGwSGp26qmv?=
 =?iso-8859-1?Q?Fw5yZqDRIwWo+1g3XCD7tUa0ZQ+b5vah9eIf7fxlk4PR5oQD/Hr7ncndzG?=
 =?iso-8859-1?Q?Eprf5K/u5XFzwZG91jxB7BKrHzzKYKRjb5Hul/G+tY/XO8FRmGFc9fgZ6p?=
 =?iso-8859-1?Q?unITC2OQXq6/cuktK3Y/eTyeTMvNAb+rnjYWu6axFFh9CGCf4DMs0xpdjd?=
 =?iso-8859-1?Q?uCRRkN4kTuYOjgiSPOLomn2OCW1sB8iOPMZpq2O5t0FkV/SKrXRrTrmSGd?=
 =?iso-8859-1?Q?6lxNSSw3MKCiECKAKBIlW61fNY1WyR1dfLebDr6Fi/du/7?=
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
	RFOc+6N1RYAFDtD1QAc6wxvs8ZiRnDo4Fg/x+SDDNZZHwYu9OGVgeCJllHmKO7ci2wyJbEyg3CyjSTil7yiIoY8KSsm8A8Xyu6Kby3c5f+hLBaYITEMMd7Lk4rSmS2DnikCzD0hl+eDXN4CS1NcK519Nxy5mkS1tsoUca8py3EkZwYMGvG/IT8lH8RDfU16rOY7XBZwYVlAu3bzThvcPDZohSkDetlZ2IiBeCxhPCqmg8g4/VZIIORJEQNICokGUgE9JhV73WmTYKXcBockmD5pnLF+9D9dMepBhC2ejr/kA16cCfcxGMg7C3S59XSYJaGAWz78X3h8EjG1Hbgjv7g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b693d4-bd6e-4b35-cebf-08df3f68db09
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:09.3444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbhzmA2sh4YoAxqgOI2+gvauReiCk7MjxG1Sn+r7NwXVHcVfOZrFEzFriP/UXWglZXvU34Fm4CZg8fUcqVOrTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342399-BfkehAOhUhtu
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1794342399;BfkehAOhUhtu;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic reference selection and on-chip TDC phase-offset measurement,=0A=
and is used for synchronization in telecom, networking, and data-center=0A=
timing.=0A=
=0A=
Patch 1 changes the DPLL core: phase_offset_get and phase_adjust_get=0A=
may return -ENODATA, and the core then leaves the attribute out of the=0A=
pin message instead of failing the dump. Patches 11 and 12 use it. The=0A=
rest is the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry.=0A=
=0A=
v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com=
/=0A=
v2: https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com=
/=0A=
v3: https://lore.kernel.org/netdev/20260731180951.65725-1-arouhi@sitime.com=
/=0A=
v4: https://lore.kernel.org/netdev/20260806232439.27551-1-arouhi@sitime.com=
/=0A=
v5: https://lore.kernel.org/netdev/20260810230439.22866-1-arouhi@sitime.com=
/=0A=
v6: https://lore.kernel.org/netdev/20260812175337.18155-1-arouhi@sitime.com=
/=0A=
v7: https://lore.kernel.org/netdev/20260815221919.64226-1-arouhi@sitime.com=
/=0A=
v8: https://lore.kernel.org/netdev/20260902214030.20955-1-arouhi@sitime.com=
/=0A=
v9: https://lore.kernel.org/netdev/20260915000015.80480-1-arouhi@sitime.com=
/=0A=
v10: https://lore.kernel.org/netdev/20260921201108.42676-1-arouhi@sitime.co=
m/=0A=
v11: https://lore.kernel.org/netdev/20260930233714.87679-1-arouhi@sitime.co=
m/=0A=
v12: https://lore.kernel.org/netdev/20261009183151.78497-1-arouhi@sitime.co=
m/=0A=
v13: https://lore.kernel.org/netdev/20261013224131.27149-1-arouhi@sitime.co=
m/=0A=
v14: https://lore.kernel.org/netdev/20261016005823.13690-1-arouhi@sitime.co=
m/=0A=
=0A=
Most of the changes in v15 answer the netdev AI reviewer's findings on=0A=
v14 and further runs of the same reviewer on drafts of this revision.=0A=
Each fix is folded into the patch that introduces the code. The design=0A=
section below states once the decisions those findings kept returning=0A=
to. One v14 finding doesn't hold: the DIVN fraction read is not=0A=
byte-reversed, because the part stores the fraction least significant=0A=
byte first, and the kernel-doc of sit9531x_divn_static() now says so.=0A=
=0A=
Rob Herring's Reviewed-by on the binding is carried on patch 3. One=0A=
sentence of its description changed since v14: it now lists the die=0A=
outputs the SiT95317 bonds out and the names its datasheet gives them.=0A=
Ivan Vecera's Reviewed-by on v14 patches 4, 6, 7, 9 and 11 is not=0A=
carried, since each of those patches changed.=0A=
=0A=
Oleg and I used LLM coding assistants to write parts of the driver code=0A=
and of the commit messages, and reviewed and revised what they=0A=
produced. v14 marked each such patch with Assisted-by: LLM; v15 drops=0A=
the tag following commit 1e035297ffda ("docs: remove Assisted-by=0A=
references").=0A=
=0A=
  1     dpll core: omit phase attributes a driver has no value for=0A=
  2     bindings: vendor prefix=0A=
  3     bindings: the device schema=0A=
  4     basic support: paged regmap, variant detection, probe=0A=
  5     DPLL types and pin properties from system firmware=0A=
  6     register the DPLL devices and pins, and keep their state=0A=
  7     input pin state and operational state on a DPLL=0A=
  8     input pin priority=0A=
  9     pin frequency, both directions=0A=
  10    output pin state (mute)=0A=
  11    output phase adjust=0A=
  12    phase offset through the TDC=0A=
  13    the inter-PLL sync line as a pair of pins=0A=
=0A=
The two bindings patches come before the driver, so the driver never=0A=
matches on a compatible string before the schema that describes it is=0A=
in the tree.=0A=
=0A=
Every patch builds with only the earlier patches applied: no patch=0A=
calls something a later patch introduces. This was re-checked for this=0A=
posting patch by patch with W=3D1 and with sparse, and kernel-doc -Wall=0A=
is clean on every driver patch. checkpatch --strict at 80 columns is=0A=
clean except for the "does MAINTAINERS need updating?" hint on patches=0A=
5 and 6, which add files under drivers/dpll/sit9531x/; patch 4 already=0A=
covers that directory with an F: entry.=0A=
=0A=
Design decisions and hardware assumptions=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Configuration ownership. The part runs a configuration it loaded before=0A=
the driver binds, from efuse or from a blob the board applies. The=0A=
driver reads that configuration and never resets the part, rewrites=0A=
loop-filter coefficients or touches a register the configurator sets.=0A=
What it changes at runtime is what the DPLL API asks it to change:=0A=
input selection and priorities, output enables, rates and delays, the=0A=
inter-PLL sync source. Where the loaded configuration puts a PLL=0A=
outside what the API can express, the driver reports what the part=0A=
does and withholds the control rather than reconfiguring the part:=0A=
a PLL in manual input select is reported in MANUAL mode with no=0A=
selection or priority setters; a half-armed fast lock registers without=0A=
the attribute. The driver does not write the part at probe or resume,=0A=
with one exception below.=0A=
=0A=
Automatic selection. A PLL whose profile arbitrates by priority is=0A=
reported AUTOMATIC: the part picks among the listed inputs by the=0A=
priorities it is given, and the driver keeps the table and the active=0A=
selection register in step with the priorities it was asked for. When=0A=
a PLL that lost every input sits in holdover and an input returns, the=0A=
driver doesn't wait for the part: it re-selects the PLL when an input=0A=
edge is sampled, and once on the first sample after probe or resume,=0A=
where no edge could have been seen. Whether a PLL returns to a=0A=
higher-priority input that recovers is the profile's REVERT_EN; the=0A=
DPLL API has no attribute for revertive selection and no driver=0A=
exposes its setting.=0A=
=0A=
Qualification. The driver selects on loss of signal and reports ACTIVE=0A=
from it. The frequency-drift monitors are reported as a qualification=0A=
failure on an input the PLL is not on; an input the part keeps tracking=0A=
while its drift flag is set is reported as the part reports it.=0A=
=0A=
Register access. The part shows one 256-byte page at a time, selected=0A=
through the register at offset 0xFF of every page and latched on the=0A=
STOP of that write. The regmap is that flat window; the driver selects=0A=
the page itself under its own lock, remembers the page it selected,=0A=
forgets it on any failed transfer and on resume, and re-selects on the=0A=
next access. No other regmap user, debugfs included, can move the=0A=
page. The I2C_SLAVE_FORCE path of i2c-dev is the=0A=
documented debugging override and is not defended against.=0A=
=0A=
Clocks and supplies. The XO is taken through=0A=
devm_clk_get_optional_enabled() for its rate and to hold a reference,=0A=
so clk_disable_unused() cannot gate an XO the loaded configuration runs=0A=
from; the enable is not what starts the XO, and the reference goes back=0A=
to the provider on unbind or a failed probe. A clock or a rail the part=0A=
must keep without a driver bound is the provider's property=0A=
(CLK_IS_CRITICAL, regulator-always-on), as for any part that is=0A=
configured before Linux runs.=0A=
=0A=
VCO rate. The VCO rate is derived as Fref * DIVN, the XO rate (with the=0A=
doubler) times the PLL page's static divider, which is how the register=0A=
map defines the inner loop; the binding describes the XO and no other=0A=
reference. The estimate is bounded: a product outside the PLL's VCO=0A=
band is reported once and refuses every frequency request, and inside=0A=
the band a rate is programmed only when the estimated Fvco is a whole=0A=
multiple of it.=0A=
=0A=
Output pads. The driver reads the pad-enable bits only to tell a CMOS=0A=
output from a differential one, and mutes a CMOS output by forcing both=0A=
pads off. It reports an output muted when both pads are forced off, the=0A=
only state its own mute produces; a profile that forces one pad is=0A=
reported as driven. The debug key gates the Force registers only; the=0A=
directive registers that commit a programming sequence are written=0A=
without it, as the configurator's scripts do.=0A=
=0A=
Phase offset. The measurement compares the selected input against a=0A=
physical output the PLL drives, as the documented procedure does, so a=0A=
PLL with no routed, enabled output reports no phase offset (the=0A=
attribute is omitted). A sample taken while the input disappears is=0A=
rejected when the monitor reports the loss afterwards.=0A=
=0A=
Notifications. The driver sends again a change notification it could=0A=
not build for a change it made itself (a failed request that moved=0A=
hardware, a read-through that moved a value, the sync-line source). It=0A=
does not retry the notifications the core sends after a successful=0A=
request: dpll_pin_prio_set() and dpll_pin_state_set() discard that=0A=
result for every driver, and a retry in the driver would notify the=0A=
change twice.=0A=
=0A=
Recovery after a failed write. A sequence that fails part-way leaves=0A=
the part in a state the driver records as pending: a priority table=0A=
not latched, a forced holdover to release, a delay to re-time, an=0A=
output realignment, a debug window to close, a sync-line page half=0A=
written. The poll retries each until the write succeeds; unbind retries=0A=
once more and warns about what is left; resume drops the pending delay=0A=
and realignment, since the registers it re-reads describe the part=0A=
after a suspend that may have reloaded it, and keeps the sync-line=0A=
ownership records until a retry resolves them.=0A=
=0A=
Changes in v15:=0A=
=0A=
  - Rebased onto net-next after the v7.4 merge window.=0A=
=0A=
  - New patch 1 in the DPLL core, described above.=0A=
=0A=
  - Patch 3: the description names the die outputs the SiT95317 bonds=0A=
    out.=0A=
=0A=
  - Patch 6: a PLL in manual input select is reported MANUAL. A PLL=0A=
    whose status read failed is marked stale and reports UNLOCKED=0A=
    until a read succeeds.=0A=
=0A=
  - Patch 7: the poll re-selects a PLL that fell into holdover by=0A=
    itself when an input returns, and once after probe or resume.=0A=
=0A=
  - Patches 7 to 13: a sequence that fails part-way is recorded as=0A=
    pending and retried, as described under Recovery after a failed=0A=
    write.=0A=
=0A=
  - Patch 11: phase adjust on an output no PLL drives fails with=0A=
    -ENODEV; it was computed against PLL A's VCO rate. A profile delay=0A=
    the s32 attribute cannot carry leaves the attribute out.=0A=
=0A=
  - Patch 12: a pin with no measurement returns -ENODATA instead of=0A=
    zero, and a sample taken while the lane lost its signal is=0A=
    rejected.=0A=
=0A=
  - Patch 13: resume re-reads the owner of the sync line, the output=0A=
    mutes and the output delays from the part.=0A=
=0A=
  - Decisions that held across several patches moved out of the commit=0A=
    messages into the design section above, and each message now says=0A=
    only what its patch adds.=0A=
=0A=
  - Comments rewritten in the style of the zl3073x driver: a one-line=0A=
    label, a register fact, a datasheet or procedure citation, a=0A=
    locking rule, or the reason an order of operations matters.=0A=
=0A=
Ali Rouhi (2):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT95316 clock generator=0A=
=0A=
Oleg Zadorozhnyi (11):=0A=
  dpll: omit pin phase attributes the driver has no value for=0A=
  dpll: add basic SiTime SiT9531x support=0A=
  dpll: sit9531x: read DPLL types and pin properties from system=0A=
    firmware=0A=
  dpll: sit9531x: register DPLL devices and pins=0A=
  dpll: sit9531x: implement input pin state on a DPLL=0A=
  dpll: sit9531x: add support to get and set priority on input pins=0A=
  dpll: sit9531x: add support to get and set frequency on pins=0A=
  dpll: sit9531x: implement output pin state on a DPLL=0A=
  dpll: sit9531x: add support to adjust output phase=0A=
  dpll: sit9531x: add support to get phase offset on the connected input=0A=
    pin=0A=
  dpll: sit9531x: model the inter-PLL sync line as a pair of pins=0A=
=0A=
 .../bindings/dpll/sitime,sit95316.yaml        |  214 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    2 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/dpll_netlink.c                   |   14 +-=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 5148 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  433 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1496 +++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   63 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  365 ++=0A=
 drivers/dpll/sit9531x/prop.h                  |   37 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  351 ++=0A=
 15 files changed, 8150 insertions(+), 4 deletions(-)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
=0A=
base-commit: fa5196392691051963726787944db872420dfa75=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
