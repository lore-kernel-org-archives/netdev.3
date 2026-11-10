Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342403;
	b=aiTRnER0B85cE0lXTnrHrZLCIpt21JNuCfPj9rMrNGFBdgNz58r6G5FmR/ji59MiVAj/
	 vZwcK6QdDGLw7JLZmNdMMXliZ9S2sDXSf3KYt1kqMRTkR25+DezDgP3J/eZxaXCbYo/+K
	 8de8BlP5QM2QTSJJE4S1kKr4qP/RgZ8fIsHw1FRUpsTOF8A7dBdvXd8Bz99NFgAolqf8n
	 FUOWGUUiNDnm4tPFYY1IUqOQMeogWZeGk/Vm7BZBw8giMtq1yVM5xRd0a9DEiQICretVL
	 bP7OeJRochQESHMNyXn5dwkYEoAMKshHVLPDG1iabBtZKQxz+j57Cr1CpcBmGvaN2XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342403;
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
	bh=kZQa6EXLRdxWH1vwZGO5KhW8ImUdfZRiNY3oApqhYtU=;
	b=D8buVnJA14rHEG8mZKCQTd2J6KeXMCd9HLgVEQ+acoHo/cvghh5ToT8iJHs3fjHg4sMi
	 31BgJ5WXMQn06QMLF1rRkTlHN4wRgw6a0mrO4kWQcUaLYsdFJBVfOwDq1B7yrPS476KkZ
	 x+1mJ4HVNzMgrqkddWE9rrXWALP+BbLQjAmo5GwQxadzV+ntUkdVJhtA7J6Q9VUK4ywXN
	 6Im1hIPBTlsl7cAGq79ZHWdq5SwUCBEFyo5nbyyr9KHHzsdO4Cn+UUZ2FX9Zr9JxBNcoM
	 k8EsLGaiy+r0l+vR77ja7NGmA8LcCtG/ZIIulwmVRV/nt219y3oa4TN/Zzq3AgUqRFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b="mTs/CcYX";
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=x6hbQci+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.52
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB56606BA5A;
	Tue, 10 Nov 2026 20:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB56606BA5A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=mTs/CcYX;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=x6hbQci+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=kZQa6EXLRdxWH1vwZGO5KhW8ImUdfZRiNY3oApqhYtU=;
 b=mTs/CcYXP4AaFOWATUNXMTMJE7QV2EZ0XrJRlo0fw0eKpLlk9ibqPrDoA+S1kHWfEnQ2Fz6tLc2sTNoNDRmyzrtLFhYSGpc+P6BiReyp6axHvPwfzV8WrT3gPYRLbmFxHobdyl4TDi7D1U+LOzXP8UuT04xVeYLDhdC6NOqT1HygnkW6p7QfC7vaZIdfEmCwHH7NsfLKutKc62CTRBlLfrtsyKc3G/aDY+i0O1YL6TzgZ5Vf7wwl0Afsh6xVkZqNMbhFwyKKXlGJEDJ2MztspMtFXq4/1BZZDEqF9WeQTVhtBkeXdOY1f8dJAGGQen9/akYZ5sKYCnr+NkVbzDoNog==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020092.outbound.protection.outlook.com [40.93.198.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 711DD28007D;
	Tue, 10 Nov 2026 20:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7jkDXVNvJfe2+xtzKQQKcto6EjKc6Vcm/H65feuXKNikDkXw4KzH8dUacWaQOGHdBtpmc4ECjV5736MItX1PVUogdX4ZOp79K5b7VvNGA31DFrxI4LopBOnGzcc6zYoXRiQA7wCF3Tgdr98dgkHaE8lzDe9AfKJwmUBkmbzgL1+3xINcdqV8gib+cf69tKIBInouDu2XiUwnX8JLiarrbBOg7kXe1H74V19olB6oiIvINSu09hBupePf+9YeBYNB9kp9tAC/2pWMAi5yiayWe47jm4rnboCRG6Cz+b+sXK8f/Y3NXvCWROLMk7SZwkcgKcu6fXdUC+gfUv/KkBInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZQa6EXLRdxWH1vwZGO5KhW8ImUdfZRiNY3oApqhYtU=;
 b=aKexA+7+ma8fZH/yTfqW/M2emAWVpWsOBM9NiWuj6FDY0PzS5GKnEmATN8FvkxyrJ8jxo8iE5VEsv1OpKnKmaxHBXA1QMsA5id/I3OVttZ6f6i/9+RempxZhBF2eJI9xZ5tPju+Msna9BWQnuYm0Q2EgqcLPOpAVdJ3Wjs8jhp1KgHuOogL0y8+KXk4ss8b5DXz5+iJoi0NLo6B1RHSiSA/hzWr62UT6kqkcIk6o3Suq7+OCowX9yxGzb9WUNEXL0AxaX4UpjusBKVrnoVF8dpZX7q3hqO96EMtiDCV/yjP47B8nZ6zpez3Mdxz/I66In6P+Zlj+nPFze1WaAvIAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZQa6EXLRdxWH1vwZGO5KhW8ImUdfZRiNY3oApqhYtU=;
 b=x6hbQci+I08NVzx0rMXFBiLZz5D1Vq8bl6oZhfin6i49+IzZWqHfHB8U3L/A/7096JXyHYzXfq8HJmNHook1aTwUiT/YgaNR1rNOOVkAfMrP+oe4ei3S9VRapM0Z+BmoixgqMe+mfXASUM6uOt5tWzxnDY/rBHo4aXQIcloEFugJk+tZmoZnkOrrluWIRxLZUMyzITm+oPKlYwdnltk6B8uDljpuKx6LJugr8KIMhmMRSr/QoeE2yAI93X7C1RcFB1KV2Mrlr6EwjlJjA5nbkcYPOa2ldcketecZ/QklMfgP0PJKOmIKLY2+oy6ThMImEBUsIYqzUQANJeJMB/8sew==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:14 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:14 +0000
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
Subject: [PATCH net-next v15 05/13] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
Thread-Topic: [PATCH net-next v15 05/13] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdcVG6os7n7zdz2k+870xKcjJwIQ==
Date: Tue, 10 Nov 2026 20:26:12 +0000
Message-ID: <20261110202607.55744-6-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 16208005-9736-45c2-8af4-08df3f68de23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|260925021911599003|260925021311599003|260925022911599003|56012099006|5023799004|18002099003|22082099003|6133799003|10067099003|261009223027099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|3023799007;
x-microsoft-antispam-message-info:
 V2paDyNskhlcubZZpT5kJnYWA/Y4dwuUbyBNHlhp0ldbJAyejJA3RDm7AgnPiQadB+KjpGMjUTxSAr27e2ClmfqdkqJVxUSfkWqRefNItvR8fqBxz0DTLbpaWRIN+Rt2z7POlaVWveTe3vgifSFbWplTVzK+jnjYxQpPFMN4V28X0IZ9/uphx6Cer1vu9ziJtSTtqOeeRwCiRm0jRHhqNeb30bOFkQOMJIRyM0TQn5pYsj8zi7vdPyuKmXMy1NRFSK1KLatnCoza3AlCVfF//Rxo3nwgmTnJZl1+VJ1NwFLDI8KsIM55sllHQ/ExQSdxjgXwjseWzf6loBQ9BizWi8JaZC0mz6OdBtOk3VY6U2hPzQhh+5gYVujQPXuiZVoeW8aUhSRFuHDsyx7sxV+rNutFV2WVgEYmbOmyFpq53IRL+LE5dKyLL/C78Ed4DuizIszoWAF/1xyys7pdgrIs+wmROVYXxXDppgW8dOsE7sh7oFz837PzNjn/P/Wwd/ne1ezw/SmoO977TuELLuS/DTZwXu/j3WWQfO3RVfQ+vvamACscl9+ZkYvwZS/cLYNLBAK7zigepUefj8VwhRrMKQNH0KjG26TovGbD1wudyxnxO5H9TS/v1IEZvLtbp8uEBw9y79525P73pcTokBISpFD8n1DtcrYRD2y0tEbZkROmBf9ngN9Uh+UY3AIGzV5HsBGXBRJzvDJ1Iec5DdgH1oFCMioITGcQwnCI5OzDcYc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XB+fLG/y69fRX0JpmMh4OH51u1575amYZeJhJGPkYblHBupU0TihVeFuKC?=
 =?iso-8859-1?Q?7fbWDKwliWKw8S3RS3taCDuASo+tdzdd0CeA9p9nZcwpAOgeV0prYEiwwJ?=
 =?iso-8859-1?Q?DWSv218/LPan9jjt3W1qthzR7GQXSI+OqjRqK9eIXpRwvmLsGFKFZfB4OP?=
 =?iso-8859-1?Q?xJXlj+Yp1k1EL0lusbpoEu2GKzUhPMDaKWNcxddkOOpBcFXYVqA5BeKKKw?=
 =?iso-8859-1?Q?BBRscMxMmi1TJM/i+mCw06xcB+pZnU6IW8HDGaDUKCE+s1lcpLxogz/dKn?=
 =?iso-8859-1?Q?Z/WsmPVkzwhDz8BbdAZpe0VSPU+KWlrAS+Xut7KURREXl/yD9CjvJBejjq?=
 =?iso-8859-1?Q?3DhiYmt+l84PqJd9htRzkp2qHXQU1WeZYJVZ7/k5+ss/NPETo7+XQdsdil?=
 =?iso-8859-1?Q?Km3xC2CLGRYCt28TaeKwOgRalJmoiVNp8U3NXz1TD+32i3VPOx+0RhcHwZ?=
 =?iso-8859-1?Q?/QCfUrdkwwkEYSiUhKD0dxfi7UvUh7P1eQjWltFDIUFsjElSzNpa6EhoGd?=
 =?iso-8859-1?Q?1+gP2cUKyXVRfvbI3G6Oty1BXPOEsY6ZOkq2X6sCYPuECOhUf87wYXdaSj?=
 =?iso-8859-1?Q?usZRf0yIP77oh4POwmJFvlbl/w9olVi3dsns2t90/X0+XD30p7SEBfacxO?=
 =?iso-8859-1?Q?Ecb5hrjS1DEuFoDi2piby1+Vu5h1WLDIGQJ9VChKUcBkEpi4Q+IEWwC32P?=
 =?iso-8859-1?Q?93ilV4Lnim9hvcfpB1AeIkVd2RJw19hx4oaqHXYHhmidFW9FjX8REAzfhk?=
 =?iso-8859-1?Q?8hNANLLpo1HWMnhWMnFw7TXKljUSXPCf794PB8ICH4yJ/iCWfZLkygFL84?=
 =?iso-8859-1?Q?eBCpJwXX61GF/POUCqXYkRHZmqtiRYfb2TtNO9urNjwvlU+4DJvCXft42+?=
 =?iso-8859-1?Q?7QmTEdRr5rjMn6oGTuM+jyvZnW811Rp/8HlYEPzcG9j100OCmZbH2b3I5Q?=
 =?iso-8859-1?Q?HHr+z+iG3DZ5X6QEBCyMNaBL20M20ENaUILi0oafxhGO/aHMgS1HVp2sA3?=
 =?iso-8859-1?Q?jb7vLTGuN5eD2M1uNZVCdl8ifxaeolq9CgexIDjhoLwo78U4nfpJt239yn?=
 =?iso-8859-1?Q?/OylsZCWqn7IyFwtwpZ9cM3ecrby5cvgM+6P2MiyLCdiJRvxx+drgCoEL4?=
 =?iso-8859-1?Q?PaXOWNTkb+EcNNO84kEHigOdzUAV5DCZMvnOK+rEDTX1xCGdujgbX28YK9?=
 =?iso-8859-1?Q?h67xryzE9s2D/t3U5zU2cDKJAzZC/PSPiyckZv03aJw17uMTPTa6ixYov2?=
 =?iso-8859-1?Q?65sdm5FitGhlpoqJzyR3X85teHDdSheb5tvZ6AEFpJ+iw4/rz1qfxMLtcO?=
 =?iso-8859-1?Q?U5buucLt8Qk9IFdNdxsgXUaK/XdapuF3LAFn5mAXnoPX9CuNTdFxAeDo1B?=
 =?iso-8859-1?Q?MdUh4xKGvn59yvhfyBamQI5DXCA5w1kIIBw2o7JN18graUp3uXXrLcb4p3?=
 =?iso-8859-1?Q?W+ac5J+aHVofks7wP6+8D1EaEnl5y25gfAqDcXUNRpsBtjsi3ZU9pO4Nb6?=
 =?iso-8859-1?Q?tTFsyNOO4exRpGXwnoDg6dLBkEMHFlNfuxWQhnSIXhTQoDBMV11CT7AuX3?=
 =?iso-8859-1?Q?SlnbLB3C421hbCv5/NzAcQkIvrX0fbNOKkZ3+P+ZUMVrEPJ10RBve6H+N6?=
 =?iso-8859-1?Q?PiAGT7lGo4aX0LcWqTgaR5CKvgVINZwn1mz59o+PUdZqTyFCR7Vi6D0LDa?=
 =?iso-8859-1?Q?xHW7J8pqEUrM86sup5CAipVEPVf81QVeqi0V+kOwJjNjY0EY0qxRRMzya1?=
 =?iso-8859-1?Q?No5jUOXrFY/xC7mP+LDZaXEYHEteF0B6KkPxGCiJNptACv?=
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
	p26U7l/6/qm2IfpHapUjP9ykFQ2Rx/AKAIHYvbQkOtiIgvLOKgtY2YmKGpmVUkUy7Vo7uaKM3Vp27SvS9rbsU06PvfGh3yHJ5mRP1y5+3C/BEsFXa+AqMX9FD9bZ4esNlQMytWkBU9pyvHxPPmjPhAhdysJi1nyofSNzFJRRyn+lcb0Jq9G7UNebEQqi4rlDRmPJyahTn9iXP7EQ523BZaWntRDHokylSul+H3UX4Ud/I29tYGGh8akr/E5IXFKk5xWwkl4Dychy/P8/FrQaA0f9S0zKDtOmks4R+MAvG2jxvkMOHf8GG7RsrqqRYTy7lQhcV8cJufrz07RZHn/yqQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16208005-9736-45c2-8af4-08df3f68de23
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:12.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVzzCeorYc25QCanrgvubK7f0wG7Pp8eCFPt64FQLqdI8+2uYggRxX+NhLhnqhl7557Aijqq6YJqsavqiA2tpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342401-JKn5ltP9OeET
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1794342401;JKn5ltP9OeET;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Read the DPLL type and, for each pin, its label, direction, capabilities=0A=
and supported frequencies from the firmware node, with defaults for a=0A=
node that gives none.=0A=
=0A=
Inputs are the P and N lanes of four pairs: a pair run single-ended=0A=
gives two inputs, a differential pair one. Outputs are labeled OUTn by=0A=
the driver's index, while reg stays the die slot the binding defines, so=0A=
one binding serves both variants.=0A=
=0A=
An output with no supported-frequencies-hz is advertised as a continuous=0A=
range, since the core refuses every frequency request on a pin with=0A=
none.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/Makefile |   2 +-=0A=
 drivers/dpll/sit9531x/core.h   |  56 ++++++=0A=
 drivers/dpll/sit9531x/prop.c   | 327 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/prop.h   |  37 ++++=0A=
 4 files changed, 421 insertions(+), 1 deletion(-)=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
index a221fe55386a..819af61123f5 100644=0A=
--- a/drivers/dpll/sit9531x/Makefile=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -1,4 +1,4 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-only=0A=
 =0A=
 obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
-sit9531x-y :=3D core.o=0A=
+sit9531x-y :=3D core.o prop.o=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 0f826313eff8..7a81c9b14b7f 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -23,7 +23,15 @@=0A=
 =0A=
 #define SIT9531X_NUM_PLLS		4=0A=
 #define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
 #define SIT9531X_MAX_OUTPUTS		12=0A=
+/*=0A=
+ * INTSYNC, the inter-PLL sync line, is two pins: an input pin on the PLL =
that=0A=
+ * locks to it, numbered after the inputs and the xtal, and an output pin =
on the=0A=
+ * PLL that drives it, numbered after the outputs.=0A=
+ */=0A=
+#define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)=0A=
+#define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
 =0A=
 /*=0A=
  * struct sit9531x_chip_info - chip variant identification=0A=
@@ -41,6 +49,35 @@ struct sit9531x_chip_info {=0A=
 	const u8	*clkout_map;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * enum sit9531x_signal_mode - input signal electrical mode=0A=
+ * @SIT9531X_MODE_SE: single-ended=0A=
+ * @SIT9531X_MODE_DE: differential=0A=
+ */=0A=
+enum sit9531x_signal_mode {=0A=
+	SIT9531X_MODE_SE =3D 0,=0A=
+	SIT9531X_MODE_DE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_ref - input reference state=0A=
+ * @freq: configured frequency in Hz=0A=
+ * @sig_mode: signal mode of the input pair, read from CLKINx_INPUT_MODE a=
t=0A=
+ *   probe=0A=
+ */=0A=
+struct sit9531x_ref {=0A=
+	u64		freq;=0A=
+	enum sit9531x_signal_mode	sig_mode;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_out - output state=0A=
+ * @freq: output frequency in Hz=0A=
+ */=0A=
+struct sit9531x_out {=0A=
+	u64		freq;=0A=
+};=0A=
+=0A=
 /*=0A=
  * struct sit9531x_dev - SiT9531x device instance=0A=
  * @dev: parent device=0A=
@@ -51,6 +88,8 @@ struct sit9531x_chip_info {=0A=
  * @page_lock: held across a page select and its transfer; nests inside=0A=
  *   @multiop_lock=0A=
  * @page: current page, -1 when unknown=0A=
+ * @ref: input reference states=0A=
+ * @out: output states=0A=
  * @xtal_freq: crystal frequency in Hz=0A=
  * @reset_gpio: optional reset line, NULL if absent=0A=
  */=0A=
@@ -65,11 +104,28 @@ struct sit9531x_dev {=0A=
 	struct mutex			page_lock;=0A=
 	int				page;=0A=
 =0A=
+	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
+	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
 	u32			xtal_freq;=0A=
 =0A=
 	struct gpio_desc	*reset_gpio;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Input index 2n is the P lane and 2n + 1 the N lane of pair n; index=0A=
+ * SIT9531X_MAX_INPUTS is the XO.=0A=
+ */=0A=
+=0A=
+static inline u8 sit9531x_input_pair(u8 index)=0A=
+{=0A=
+	return index >> 1;=0A=
+}=0A=
+=0A=
+static inline bool sit9531x_input_is_n(u8 index)=0A=
+{=0A=
+	return index & 1;=0A=
+}=0A=
+=0A=
 /* Register page of PLL @pll_idx (0 =3D PLLA, 3 =3D PLLD). */=0A=
 static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
 {=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
new file mode 100644=0A=
index 000000000000..b9405eba49a3=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -0,0 +1,327 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Retrieves pin properties from Device Tree firmware nodes (or=0A=
+ * applies defaults when no firmware node exists).=0A=
+ */=0A=
+=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/fwnode.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "prop.h"=0A=
+=0A=
+static void sit9531x_input_pin_label(struct sit9531x_dev *sitdev,=0A=
+				     struct sit9531x_pin_props *props, u8 id)=0A=
+{=0A=
+	u8 pair =3D sit9531x_input_pair(id);=0A=
+=0A=
+	if (sitdev->ref[id].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u", pair);=0A=
+	else=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u%c", pair,=0A=
+			 sit9531x_input_is_n(id) ? 'N' : 'P');=0A=
+}=0A=
+=0A=
+/* A differential input pair is labeled IN<n>; its N lane is not registere=
d. */=0A=
+static void=0A=
+sit9531x_prop_pin_package_label_set(struct sit9531x_dev *sitdev,=0A=
+				    struct sit9531x_pin_props *props,=0A=
+				    enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		strscpy(props->package_label, "INTSYNC",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT && id =3D=3D SIT9531X_MAX_INPUTS)=
 {=0A=
+		strscpy(props->package_label, "XO",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		strscpy(props->package_label, "SYNCOUT",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		sit9531x_input_pin_label(sitdev, props, id);=0A=
+	else=0A=
+		/*=0A=
+		 * Package numbering; on the SiT95317 it differs from the chip=0A=
+		 * slot that the registers and the binding's reg use.=0A=
+		 */=0A=
+		snprintf(props->package_label, sizeof(props->package_label),=0A=
+			 "OUT%u", id);=0A=
+=0A=
+	props->dpll_props.package_label =3D props->package_label;=0A=
+}=0A=
+=0A=
+/* An output's reg is the chip slot it drives, not the driver's index. */=
=0A=
+static int=0A=
+sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,=0A=
+			     struct sit9531x_pin_props *props,=0A=
+			     enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct fwnode_handle *pins_node, *pin_node;=0A=
+	const char *node_name;=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		node_name =3D "input-pins";=0A=
+	} else {=0A=
+		node_name =3D "output-pins";=0A=
+		if (id < sitdev->info->num_outputs)=0A=
+			id =3D sitdev->info->clkout_map[id];=0A=
+	}=0A=
+=0A=
+	pins_node =3D device_get_named_child_node(sitdev->dev, node_name);=0A=
+	if (!pins_node) {=0A=
+		dev_dbg(sitdev->dev, "'%s' sub-node is missing\n", node_name);=0A=
+		return -ENOENT;=0A=
+	}=0A=
+=0A=
+	fwnode_for_each_child_node(pins_node, pin_node) {=0A=
+		u32 reg;=0A=
+=0A=
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))=0A=
+			continue;=0A=
+=0A=
+		if (id =3D=3D reg)=0A=
+			break;=0A=
+	}=0A=
+=0A=
+	fwnode_handle_put(pins_node);=0A=
+=0A=
+	props->fwnode =3D pin_node;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "Firmware node for %s %sfound\n",=0A=
+		props->package_label, pin_node ? "" : "NOT ");=0A=
+=0A=
+	return pin_node ? 0 : -ENOENT;=0A=
+}=0A=
+=0A=
+/* Free the result with sit9531x_pin_props_put(). */=0A=
+struct sit9531x_pin_props *=0A=
+sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
+		       enum dpll_pin_direction dir, u8 index)=0A=
+{=0A=
+	bool sync_in =3D dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+		       index =3D=3D SIT9531X_INTSYNC_PIN_ID;=0A=
+	bool sync_out =3D dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+			index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID;=0A=
+	bool xo =3D dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+		  index =3D=3D SIT9531X_MAX_INPUTS;=0A=
+	struct dpll_pin_frequency *ranges;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	int i, j, num_freqs =3D 0, rc;=0A=
+	u32 *freqs =3D NULL;=0A=
+	const char *type;=0A=
+	u64 curr_freq;=0A=
+=0A=
+	props =3D kzalloc_obj(*props, GFP_KERNEL);=0A=
+	if (!props)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	if (sync_in) {=0A=
+		/* INTSYNC destination: a reference the PLL can lock to. */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (sync_out) {=0A=
+		/* INTSYNC source: driving it is not a reference selection */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (xo) {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D 0;=0A=
+		curr_freq =3D sitdev->xtal_freq;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->ref[index].freq;=0A=
+	} else {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	}=0A=
+=0A=
+	sit9531x_prop_pin_package_label_set(sitdev, props, dir, index);=0A=
+=0A=
+	/* Internal pins take no properties from the firmware node. */=0A=
+	if (sync_in || sync_out || xo)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	rc =3D sit9531x_prop_pin_fwnode_get(sitdev, props, dir, index);=0A=
+	if (rc)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	fwnode_property_read_string(props->fwnode, "label",=0A=
+				    &props->dpll_props.board_label);=0A=
+=0A=
+	if (!fwnode_property_read_string(props->fwnode, "connection-type",=0A=
+					 &type)) {=0A=
+		if (!strcmp(type, "ext"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		else if (!strcmp(type, "gnss"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;=0A=
+		else if (!strcmp(type, "int"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		else if (!strcmp(type, "synce"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;=0A=
+		else if (!strcmp(type, "mux"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Unknown pin type '%s'\n", type);=0A=
+	}=0A=
+=0A=
+	if (!fwnode_property_present(props->fwnode,=0A=
+				     "supported-frequencies-hz"))=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	/* A -hz property is 32-bit; no rate of this part needs more. */=0A=
+	num_freqs =3D fwnode_property_count_u32(props->fwnode,=0A=
+					      "supported-frequencies-hz");=0A=
+	if (num_freqs <=3D 0) {=0A=
+		rc =3D num_freqs ? num_freqs : -EINVAL;=0A=
+		dev_err(sitdev->dev,=0A=
+			"malformed supported-frequencies-hz for %s: %d\n",=0A=
+			props->package_label, rc);=0A=
+		goto err_alloc_freqs;=0A=
+	}=0A=
+=0A=
+	freqs =3D kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);=0A=
+	if (!freqs) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_freqs;=0A=
+	}=0A=
+=0A=
+	rc =3D fwnode_property_read_u32_array(props->fwnode,=0A=
+					    "supported-frequencies-hz",=0A=
+					    freqs, num_freqs);=0A=
+	if (rc) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "failed to parse supported-frequencies-hz for %s: %d\n",=0A=
+			 props->package_label, rc);=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/* The first listed rate seeds the input's rate */=0A=
+	if (num_freqs > 0 && dir =3D=3D DPLL_PIN_DIRECTION_INPUT && !xo)=0A=
+		curr_freq =3D freqs[0];=0A=
+=0A=
+skip_fwnode_props:=0A=
+	if (sync_in || sync_out)=0A=
+		return props;=0A=
+=0A=
+	/*=0A=
+	 * An output with no listed rates gets one wide range, as the setter=0A=
+	 * checks Fvco/N; the XO gets its one rate.=0A=
+	 */=0A=
+	ranges =3D kcalloc(num_freqs + 1, sizeof(*ranges), GFP_KERNEL);=0A=
+	if (!ranges) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/* Set after the last allocation that can fail */=0A=
+	if (curr_freq && dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		sitdev->ref[index].freq =3D curr_freq;=0A=
+=0A=
+	j =3D 0;=0A=
+=0A=
+	for (i =3D 0; i < num_freqs; i++) {=0A=
+		struct dpll_pin_frequency freq =3D DPLL_PIN_FREQUENCY(freqs[i]);=0A=
+=0A=
+		ranges[j++] =3D freq;=0A=
+	}=0A=
+=0A=
+	if (!num_freqs && dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT) {=0A=
+		ranges[j].min =3D 1;=0A=
+		ranges[j].max =3D 1000000000ULL; /* 1 GHz */=0A=
+		j++;=0A=
+	} else if (!num_freqs && curr_freq) {=0A=
+		struct dpll_pin_frequency f =3D DPLL_PIN_FREQUENCY(curr_freq);=0A=
+=0A=
+		ranges[j++] =3D f;=0A=
+	}=0A=
+=0A=
+	if (j > 0) {=0A=
+		props->dpll_props.freq_supported =3D ranges;=0A=
+		props->dpll_props.freq_supported_num =3D j;=0A=
+	} else {=0A=
+		kfree(ranges);=0A=
+		props->dpll_props.freq_supported =3D NULL;=0A=
+		props->dpll_props.freq_supported_num =3D 0;=0A=
+	}=0A=
+=0A=
+	kfree(freqs);=0A=
+=0A=
+	return props;=0A=
+=0A=
+err_alloc_ranges:=0A=
+	kfree(freqs);=0A=
+err_alloc_freqs:=0A=
+	fwnode_handle_put(props->fwnode);=0A=
+	kfree(props);=0A=
+=0A=
+	return ERR_PTR(rc);=0A=
+}=0A=
+=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props)=0A=
+{=0A=
+	kfree(props->dpll_props.freq_supported);=0A=
+=0A=
+	if (props->fwnode)=0A=
+		fwnode_handle_put(props->fwnode);=0A=
+=0A=
+	kfree(props);=0A=
+}=0A=
+=0A=
+enum dpll_type=0A=
+sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const char *types[SIT9531X_NUM_PLLS];=0A=
+	int count;=0A=
+=0A=
+	count =3D device_property_read_string_array(sitdev->dev, "dpll-types",=0A=
+						  types, ARRAY_SIZE(types));=0A=
+=0A=
+	if (index >=3D count || !types[index])=0A=
+		return DPLL_TYPE_PPS;=0A=
+=0A=
+	if (!strcmp(types[index], "pps"))=0A=
+		return DPLL_TYPE_PPS;=0A=
+	else if (!strcmp(types[index], "eec"))=0A=
+		return DPLL_TYPE_EEC;=0A=
+=0A=
+	dev_warn(sitdev->dev, "Unknown DPLL type '%s', using default\n",=0A=
+		 types[index]);=0A=
+=0A=
+	return DPLL_TYPE_PPS;=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/prop.h b/drivers/dpll/sit9531x/prop.h=0A=
new file mode 100644=0A=
index 000000000000..b16db0bc51c6=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.h=0A=
@@ -0,0 +1,37 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_PROP_H=0A=
+#define _SIT9531X_PROP_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/fwnode.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_pin_props - pin properties from firmware=0A=
+ * @fwnode: firmware node handle, NULL if no DT node=0A=
+ * @dpll_props: DPLL core pin properties=0A=
+ * @package_label: pin package label (e.g. "IN0", "OUT3")=0A=
+ */=0A=
+struct sit9531x_pin_props {=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	struct dpll_pin_properties	dpll_props;=0A=
+	char				package_label[8];=0A=
+};=0A=
+=0A=
+enum dpll_type sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev,=0A=
+					   u8 index);=0A=
+struct sit9531x_pin_props *sit9531x_pin_props_get(struct sit9531x_dev *sit=
dev,=0A=
+						  enum dpll_pin_direction dir,=0A=
+						  u8 index);=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props);=0A=
+=0A=
+#endif /* _SIT9531X_PROP_H */=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
