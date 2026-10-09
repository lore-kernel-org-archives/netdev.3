Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0314F5E0A;
	Fri,  9 Oct 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570243; cv=fail; b=LfYBDIY0hKrG3/5QdoQF+yDHlsIU+5Kb6TP7J5nZExuaPkWiTHnJG3fV44L1pgpXjE+q0BBkjvN9j5MRhLMC4nPt4Z9t7C6jyrbKP/jIbvyTirTOLfbdcmNGBANRzZ/nENoPFoFphCwDVUHLphwaQcDG38s32U9AtXZWCDOp/nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570243; c=relaxed/simple;
	bh=des3wYqMmHF7h1s8w3EvY0bk2CiU3Gh4ODQ+Y5bQ8r4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4ocw/72OnWDFkdt7CkOlPM0WsglT7LQkNawTmCfIO7AzC+D1UsmHDJ/1zrIJPX/DAM7urb1Fg/ZRVQPWzP7IHbUjibMECCV9WCYxdEZbuzl434XfaC+6BXFtAay+OzMyhRYdY0dhx3tOh/CYEQJdc786dPNuowGG9+8wEOrxwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=PpfQ6a3N; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=xsLuapck; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="PpfQ6a3N";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="xsLuapck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=W2A8uO9dl9RDSmufqG7JCAG43fhLLtbcgssV+gjxp3M=;
 b=PpfQ6a3NXU49P4aNJC5R4SE2pnonOkYaao28UWfnZXVY0HiCasH8RR20VV6zcpmFAFk0K7XqUabkZiHpm74PMv4ppjBjyl3CS2ar3n3kBGiSxYnUY75eK/9rx+W81FhiAG3l2Od8PL3rJ3OMrECcDGFHUBIL+D9gs0SbueXVjnS4kG5uwZSoCZ7vNQNiKQrC6szdZpWTsNM9ZkJ1uuSfRx4lb/SwuDX1eS6XtJbM/ywQ750PNyiqFfbQJ7H5bGOWHINlLDBxE7RF5y0HuON24PYCwbEr564dbiScBGEED1cPI52fHJj8+3EMwTBeUuBP3TMw5Ian7nV64/Az5Xcniw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020073.outbound.protection.outlook.com [52.101.46.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 69213800081;
	Fri,  9 Oct 2026 18:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y13y1uGbrm0VJi3jMUHzC9diCoD4Zh+oaDj1JgEqP4PkYB7ZSThxOwVnHqaUPzfbkNxhMj24VnEM0UGZALeR44HdCuzajrhj/3B4wLtJdq/NjBKPZyH3p93EjTk0nCcMiQP2IUprNPFxE/B1bEUECZGUDNN7QfNp8VRo9qny2yiCbd7oWfSnK8cM9GbhqiWWV9WFboG1x4QW/NyWOdAqYL931ycqhi797p5psJRPPJM1GR8u80xP5G0I4tH7e3+f7vofJ60x5lwsD/b8F7/0Mn26xjkipBcstATGvjhhS6pt674XM90AK8nqoRecI2jFyE6UPzh/rEMNPelSs8iAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2A8uO9dl9RDSmufqG7JCAG43fhLLtbcgssV+gjxp3M=;
 b=Z5Ow3ut+R5tH7TIUjW9LP+tGsd1dWJu+HvNFum71bbsxRCrzzeMpBt/g0R1NGLVjydoxjupi/rLoz+eg0JSnppuVoGp1fpDxvr7s7X9XLWZhZUI8GdrARup2/UNTfJ5YcC/gXJBPIK0JRMWLHb8BbgEvoIy8X4JFc6BBTQwnQjK+pYLPoNpGdhzS2UVej4hdX5DdVDpU12wPfUUFz74AZDLkwQ3B5fQrRV35bLtb39afcmrVmjuBJTU/4b+4K+KyM/sR1ElEf4kUGrX3cZ3K+Y0eTFNnleCRSB1osqgvhBHpLDZ0fLnWFA6yUYCoE6o+KA/YH1yd5rRUSMQbS4Ef+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2A8uO9dl9RDSmufqG7JCAG43fhLLtbcgssV+gjxp3M=;
 b=xsLuapckQrw2wOUkN5dX888ylua3OxQJzQd10DXw19BDhsShFYWsBdkLvqZBZICDohhecjqN0uB6MyTSXSVuvMNP2gvXF6DbNyrOYXFaS5CSUqi373+FIGxWbOLKScPKYT4rKLmOwYQgfoBlIFfCb1ZUEAmKIag65p+6JhFPG85dqi82/wURs3JwQZxlq0qdOiN5WyBmDcSXwfcQnpyFSZKjZYHzJiEaZsPNBuEXdq4pg0t99QQ/W3X2Pd+L3LEfHOYutCmWqGFbpfRIVmvE0TOa+8pV/QjEv7hhJA+B45mUWRsD4vsMqf6hbE7Rvz4fkeOgA84HxIoRlJw4wAxttA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BN7PPFEE39645EB.namprd20.prod.outlook.com
 (2603:10b6:40f:fc02::76d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:57 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:57 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Rob Herring <robh@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Carolina
 Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 03/13] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v11 03/13] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Thread-Index: AQHdUTShUiqVpM3oXk2TUznUAYFs+Lbv4V8AgAWy6AA=
Date: Fri, 9 Oct 2026 18:23:57 +0000
Message-ID: <20261009182356.77086-1-arouhi@sitime.com>
References: <179125693789.3539370.5452496490999138147.robh@kernel.org>
In-Reply-To: <179125693789.3539370.5452496490999138147.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BN7PPFEE39645EB:EE_
x-ms-office365-filtering-correlation-id: 5b0899ae-26cf-4bd4-2afb-08df26327ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|5023799004|3023799007|22082099003|10067099003|18002099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 QXpM3LDP/JyzOW6QGJUuopFNe6wIlsOJ/l3BBXiOBVb20wjLi1m2mxuaCNp3m7S4Ft65F+jlcau+lsr4PpkOTqPE1oLH0wcuOj/K5JGMBNaLNqhILFW/Tkb9O+j9y29dF2Ksu2UB8aJdU1kqAQepGkqwN9LwoGMo3gcbOMGpQC3MSLaUmoF5dftu5eVE5gP4/Td6gm1Qq/ibdEOs2GDqF0h0oFp6VWOt5k0ppJxVYM+PFhiJNJQ4ogSP73x0xYhZD/m9OiTsSZ6475BOHnnZbP2wfM2q849zlwQeyXBjLYWcf9MUvYXW3LJoEz4c1yZFxoxZ792xHuWaKTKlCx/w8e419/UVtJdtbf/7wsYsHS0VUlUreZixwiQF8EfLGWgMyOsCIZELdj5W2m+F1fvct1etCO0zPU9H/KNJExbO4QOIzI2xTR4fcm+iqGcgqsksrTAW2vcZyhEB2K7uKi1ueNEsojHoHI8X2LR8+cKruTQf8oAjuqXVAp0z2dd0AXkemN2j9K5dNoDLHFerXvwCGxpGQlMYUgH1RLY4ZlbDSJq3RNUwxFomj2ShpUHiuVx8KrWoHu97WvMfcPw7VmT9AQ9VzoHG80/KU3myD9+76aNlszrbvOt6sOZx6a4my6hnQtBIUP/PecNhpWQSiud+CdqOpwkZ90BfcsFPErK5wI3LgQvxoEH+W0MCB6FzYxmxSb5vOexavXtAXK0UvZ+461EvRvWIlUkCx33E8ZVduLQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(3023799007)(22082099003)(10067099003)(18002099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?F0CFrvTVhy3EhoiM9RebVBqGQRU8zHAz15V80wUuir/vkNJdKOWd17M+ri?=
 =?iso-8859-1?Q?POZyZdAkgYomDDZChymPgPpndyan/qts56tAW3TsBtNnnx8U2XiyfnkDSQ?=
 =?iso-8859-1?Q?YiDwJp+mDSXfBbd43RNWDj469jE9TalkSL8tUv7UKoyH0oJO0kab/EyUgA?=
 =?iso-8859-1?Q?dsT4OEsCWeJnuoWR9f206yNHFtlERiaD7On2qLV09FTp8HJNrvHRHrSCFl?=
 =?iso-8859-1?Q?TyZigA7QJ3Df0aOkQFHPRaFZ1YoZPtE++BXl4k/FulOOHf3J90/vO8cGeC?=
 =?iso-8859-1?Q?8AOMJheDJMre/vhy4Jjw5qFhKAYi2QpSJIjKBWI3zqOg8KQWwFNweqk4K0?=
 =?iso-8859-1?Q?o4bOEbqBG6JjZiG6aDW9ndMb28VfQ/x74V2HFHgUYUrcUfX31VagqjT9+N?=
 =?iso-8859-1?Q?y3Tq4bNfJm+yfYuAKlcY/fH/XxVcjJzDtA4Lib1I4AUhLY6pCQrDJv2W3v?=
 =?iso-8859-1?Q?lV9jdpMQhCaD2CnujCh/XTepkIt2TZWh4qmKyqTDmF2jnqvyIstsHlqwx2?=
 =?iso-8859-1?Q?r6WUlG8vLsWFmSjBW5HiTU/T0qrfeY9VZAvs5dmY2OkhOigpNhUGtBqjKT?=
 =?iso-8859-1?Q?gOY7x/gzfQPmgX9e/FghIgEERGtt4reUTYm1WcgdW+cAYM+1AObQVv/BLS?=
 =?iso-8859-1?Q?bMUfpi1i2xf0xko5VnEQ28+ZdYKQfTUi79tVmgakecPwBCqLfM/D9vpkW8?=
 =?iso-8859-1?Q?g60C9O+rwTXzWe4/PtC925QB0ghw8Iy9Ot2PBR6K3ca1V7+UZGXZYTUTfO?=
 =?iso-8859-1?Q?dOp4N06IDjLSPR1ojcjgkfIONdXjSPvbonfm6HmGsWPdxPXLRzMv9LogSM?=
 =?iso-8859-1?Q?0TC7jFthUDSdCiuSs1pfSPLXDZdVOHtbsRPwcqjNfbtbJ56ySbkB13ndxk?=
 =?iso-8859-1?Q?zvo9M/Q7TwRgxw728fk7iXayCloZ5HyGK8tNltbuiWjGgE9orZnLZmskDd?=
 =?iso-8859-1?Q?5E9d4Ps3IlUMnnBci/0R2+l8u4x81lTyn3dF0xb6OfGieRHpSG5oa3NzEc?=
 =?iso-8859-1?Q?zlrEf5Vr+fHMgQgJL2Fd3ydwZE42sWgPZEZDnZsfv6MnBWPfcdRNGSQ1lI?=
 =?iso-8859-1?Q?bgDiRIzlM8fqCxKMbpcn1bgBgvNS8G6vvPK53mEhW/R8r5/WHFfpiQoHGY?=
 =?iso-8859-1?Q?ytu/AVHXc7TAL4beiYH4CfLSOjiAk/nET21E+1d53qdpSkYvYYW4J1PFwm?=
 =?iso-8859-1?Q?PdfuXtrrdBKwCdHjKE42+mVPugU0A4AEzEA92kRTMAD/jhLbB0HVXCChMc?=
 =?iso-8859-1?Q?cYw7GB4qY+NHWfNb2UwmguuIYrMAFbKKx5xEmD5DXAVrAEztCgmYrI7Z81?=
 =?iso-8859-1?Q?4+GkVv4G+At43aYLIdy3QRc6awsclA495Y21Uua/+RB1XEfw4HgYIziy7k?=
 =?iso-8859-1?Q?m2NfhNVDnc+cCriWKkUQVcbreH90GG+paKzq8GLcVERG/LxhDm0+Xbta9A?=
 =?iso-8859-1?Q?J7IPkz0SuCkCpowH568ox9wKlNRCWyWEY5pNKxWaWw8R3nJpxs2bQSeO/k?=
 =?iso-8859-1?Q?/Ts3VZe+mkhF200SzNaXjv4tUNtsCzd5ueLEjkKSjOnX1foCbjdW4dKHKf?=
 =?iso-8859-1?Q?irnUH8RT0axZ+QIQC3PDvJZ1aKGhN9Nz/8o+GaNnli/6cQM1A3iVaHZh7l?=
 =?iso-8859-1?Q?GGyPa5B0MxqE9VYjjbQusHMl/jPNit4j0NhAvtiUslYNs0mAO9IuZb20GC?=
 =?iso-8859-1?Q?peXG6XZRaj8OSPE0yv1P6a4aBRdnEPgoKfhmEUSaYClHs8zyhbmA0XDhDe?=
 =?iso-8859-1?Q?wJWN4mYZVk9TiPiYyIv5SmYAIS6f/V3sPJuSTAisL7kJ0T?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WAJMltqhQan8jNoVs/+uZvZArClGbhAalnFKNWOHkRfuzuW+YZfVIv4Icn+e8dnJJu4m+hclbZdBapIBrylfAJD6BhM/9U1rynjbAzmxrBbo1D82gmUTe3khNdak8LUpb7HNgRAgtLQMJnUnysgX+2S9INy6q9go9gp1EbDZiWlXxijW6/W/9AO7Hhu4/IGmF5fOrUiJ4kNP3vQ5+P1bKFsQ4+vUYV6lkcWTTbBXUmPKSEV/pYHiDqLlquZOT15UCdkO9z4aSFHL4awF2JoL5vHQeZlig8xIRldoMiweLU9NMu6r8tJR8iTQtUUMQBwxQk/Es0qOgJtQsoZvXcgBVQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0899ae-26cf-4bd4-2afb-08df26327ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:57.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tFd/PGk2LNTOf4Ey3SHh40vIvLpMkm6KbVRo0LIwYOotM75m7WHOp+6bMb8tpuR5AJPzg9YmSDji+EVjc6rRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE39645EB
X-MDID: 1791570240-gEyuJbdMM9aW
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791570240;gEyuJbdMM9aW;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, Rob Herring (Arm) wrote:=0A=
=0A=
> On Wed, 30 Sep 2026 23:37:17 +0000, Ali Rouhi wrote:=0A=
> > Add a binding for the SiTime SiT9531x family of clock generators: an=0A=
> > I2C-controlled device with four independent PLLs, up to eight input=0A=
> > clocks and up to twelve outputs, described as a DPLL provider.=0A=
> >=0A=
> > [...]=0A=
>=0A=
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>=0A=
=0A=
Thanks for the review.  I have not carried the tag to v12, because the=0A=
binding changed there.  It is 02/12 in that series, v11 01/13 having=0A=
gone in as 45ad84d2800e.=0A=
=0A=
Three named supplies were added: vdd for the PLL core, vddin for the=0A=
input receivers and dividers, and vdds for the two GPIO pins on the=0A=
SiT95317 that have a rail of their own.  The per-output VDDO pins are a=0A=
new top-level patternProperties block, with two per-variant blocks=0A=
inside the existing allOf rejecting the VDDO names the other variant=0A=
does not have.  The example gained four supply properties.  The driver=0A=
does not enable any of these; describing them gives a board with=0A=
switchable rails a way to say so.=0A=
=0A=
supported-frequencies-hz on the input pins gained a description saying=0A=
the property names the rate wired to the input, as a single entry.=0A=
maxItems: 1 would say that more strongly, but dtschema types every -hz=0A=
property as a uint32 matrix, so the example's single /bits/ 64 value=0A=
reads as two cells to the tooling and the constraint fails=0A=
dt_binding_check.=0A=
=0A=
Thirty-eight added lines in all, no deletions, and dt_binding_check is=0A=
clean on the result.=0A=
=0A=
Thanks,=0A=
Ali=0A=
