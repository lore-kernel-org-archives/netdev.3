Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1A4B7A59;
	Wed, 30 Sep 2026 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811454; cv=fail; b=fPKONHzBw8SRnDzO3njf2EG/z/poUxwA7/SevsAgsEAFCgEJUGK2ZhsTjsGoJBJDs+mosyGUX/8BpcirAWBY4/2b03owYx82S2a6kKFctxJgDi2PmBG3lXN3yU3nexa7Csl6J1UySGwJYneG+bjRrOlTerROrmdgqbfFgSMw5Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811454; c=relaxed/simple;
	bh=h13RILXJ03GIe2I+30a1sLuMjjkK9EWDCNG0v2LVyTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HnH79QI1heLhqM06OZPW+bmS8S4hfzuzHyO3zunFrwb9SxzObCCGb5zs+1LabCKlwPNCotulfFOA5IPIVLQn6zlI8SCAbRI0wR8uvw5Wv85LDlkzSbd3fMVS9OPTlSanaY+PDBKVhYsinEN2DzZArD+LIzvokZJa4CdBEg+fzGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=jqItEVEn; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=NhTRa3wb; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="jqItEVEn";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="NhTRa3wb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=ZSQdXQIPc52yhCBDny31GWEtHhHINkMZ9VV0Pch0cKU=;
 b=jqItEVEnmDudsyd4yQYx9f4lrSWF1Aiy6L91xqe9Fztum4oLwHNGPuKPgeQHO3jp5A4jAL7F3EhL1cAUoRkrXAxYkL9NuMFEn1R4ULzNsWPah+wIC7I9R76G6b+L8Dw6fXqMxIEbqgj2qHQnxlhQ1k/raWJFnSI2ZlZbOIDu+bpu93OP394Lx2yjz/Y0ozWvfa+FYO6kl81wX/pY6RS2ccQZS0WXgqX9GPnR8G7tfb4S2tQH9BYMwuwSVa1uFcv4cJCv0daQ74PnDIwqAlwjflBeC9SLaQnkNjT3klEF/HtD5f4XBvTrvXCh3lyOwkSi1j3dAr7jd5IyypSRBMUfBg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E2D5710006C;
	Wed, 30 Sep 2026 23:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLmwkTG0mPiO7ObyRYl5KZUkzuS7kwMAoltHdXuuVhJ6PQ5t7ueBRtw3ulF99CyV3qTV2tTAY4OMmLisEH3P65LD60pvWUcdW3ju4LichqrFAyMYqGXk/EAFGrNnx07yX7IWaKT/qItrtAgqfNdUJDJ13vbxoaBvpIVTJtqtLgCgdFi4nurJq88VxfGxkBu1i8O2BlkLotmqg9vlvZ7HYpzac/r9gMxTxXgug4tWVToefvHkOHIKC8ErtlT3puKCxQo9nmSuWthW5qe1UrnrbCCyqJ0t+lehfhdn/KO8QuL7tW0RjpqI0hjn4tLwQTFOU9J+CG8+W5EJBSqKbjtiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSQdXQIPc52yhCBDny31GWEtHhHINkMZ9VV0Pch0cKU=;
 b=g3I0+QIpAwk0K0OAA0FqyKrggaAqP/5/mOB/zVoWiktl3i7PqA38bkzWA0q0SF1R9WRQxci0F0gcviLs4lXOMKPs61NEzC9AMyHmssxILTtzPnihyZHsly5UY1J3f8dnIioyTrDLputWH4f4UQnM/CJ8lQn7i5ECVDAUkbk8gk3yGqCJxJ5ZFVNqa0g2TnP2VHNDbZynTKfEWgn0z6CKcHkPkcMBYyCBKXVpAdbstfI1YIStbWUQDF9xaJ2BP3cfVLuddyoXbZuKMgvy+uelWTTGoMrInLKLo2JOIhajsFmIyH7PHU1fNX2OqtE8fGNGs7RHhguZKtDDwqEKeBh6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSQdXQIPc52yhCBDny31GWEtHhHINkMZ9VV0Pch0cKU=;
 b=NhTRa3wbi0c+EcXKi0KIoII0PSMMMOMsEdMide//JKojj+cBc5pJvWk0AFnG3ShIQHlJC7r2mhTPDHvbyI55uXsvW5dtCdJyjXBCVGuvqOmZY5jS1Z3blhekKIOcnI0zKDEEfuzCV2shk/6Q1qXVLs5Lppfnwtx/91xfG2Vke30n5Qql1DIuwHaVZVsM0DludIZTT85eNN3D/udiAmJ3MPHcupQOQygeGsTlW0REv3lD6lUFemlp+sk8D/RsnMez+wYPpKkkvgr+kkxah7bkVymmQQqPHpX9T9EIv0tGmFINMkOwPxW+Se2pa9FDdOM6ovII9kXhU3e5nQcuLoFl6w==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5383.namprd20.prod.outlook.com
 (2603:10b6:806:29e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:37:20 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:20 +0000
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
Subject: [PATCH net-next v11 07/13] dpll: sit9531x: implement input pin state
 on a DPLL
Thread-Topic: [PATCH net-next v11 07/13] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Index: AQHdUTSirven4+BgMkagf2I9rPqrtA==
Date: Wed, 30 Sep 2026 23:37:20 +0000
Message-ID: <20260930233714.87679-8-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 8e5e61ca-491d-434b-e079-08df1f4bc573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|3023799007|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 YBCdfV+3T12US229rPX7uhqu3iX/pZBKZI/QtUZ33mTo5r7rM9wHopp+JplwN/cMWNke1Til2EzXnLOKdbZnYtWQ9wWe3YXRDPfgT8ONLWytCvZ5uEaKsdpUuQtG88Z0sTU0c590rzPK9gLsHMuib9GgM/4M9xOeZsm4DPJrjDNF52y7+5EIjLTuZa8eGMpkML1iFFdwFlvYfB6HCAO8QdVM5HYrJx0VZGWryjwO58jbR6PNtGx0zQoVgj8HwfVqTuwZR4G+PHWYO2jzQpoN122SOSfEmOKGXyUYylRXihx/gEa78qmCCRZotncBDVCGPFQtnvgXY9oamTt+PJSHo1r2UnTs3jAuxn2zwxl+5PEGK+G7IwQ1fhsdTXfUaDy98Gdb+GACnTycd3iSxXiDm6Z55KnceQ8GJi7uOXNOeKgpYpcCfbvSeJz+vC67oR8esITKDUkCwkZg1WzCBZu6pUHU6Lee2mxJzOAmREbZyUgXaw4lMF2gACsSwvAVchNQxTEX/lj8VRhxPPuF3+ldnD0Dp2B787ANVDb6Wk5rYop8WDw6w43viYx5Ywfc5GleOoGTQmR24O6jbfVhcQhD/Dr5B/YyjCKaeZhz9CMinVAdPNp1mGFIJkfVF8AIj2O4DuvGiXCoPrytYphstBB+F2wjvLefot7yyEL+fPonRxce+4H81kE5BrhFfnddo9PfwZUYLK4oI0aLy9G8DG1pFri7aJNgBUihhkdi/Ytbtj4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ID7a35IK+LYyvZsBUdj8gFMX2Ybpj3AS1kEas6Zl8JIyIrl8kfipQi52yW?=
 =?iso-8859-1?Q?vd99YS12z+qbf3cag4WMEOBhuvql+YvWOWxCss0aiTScwFISlGpE8fq/Nu?=
 =?iso-8859-1?Q?pVhi9YcEYhJ8Ka+KrWWmRU63DQabQJhxiFt3tqCkIWMU1I0269aw+7NMyP?=
 =?iso-8859-1?Q?GZBLRQiUlZl1eA/a+RLoHbSZZRVPX46GzUIKLI/dpbHCMpTNoS7q6rriiP?=
 =?iso-8859-1?Q?a5CDhPIWUE5NuOMg9217Ah0+3HdWLPVg1bLFZ3L63msFC/eg1+g2O1Drti?=
 =?iso-8859-1?Q?44eOX0ACQgD2B113H9K13BJHqJu+rbm83Rg9I37Lmg7WdFLoDVHClXlZQb?=
 =?iso-8859-1?Q?E2iaY9uxMBlq6+LIeS3HehGWxEAAftYJ3AMYw8FRJZamSDwWVidMiAETpT?=
 =?iso-8859-1?Q?BN47eETODff9hzg0FREr+nsOcVJ81Qu6ATOCdnx6yFjQs6WlCWRwR6L6PU?=
 =?iso-8859-1?Q?N1hpnghbuI4XR0jM5xsJuqR4uGoDs2Cpd+js2L3JIM1lLJK8PXwMQHa3f/?=
 =?iso-8859-1?Q?Tb4/F0d/a1Kz3p7U+B3ndDPWfznZa8TVnnvDjzgtPJblQNAi9mJrMbZlMo?=
 =?iso-8859-1?Q?0gxFSKrSP/PDO4r7RaUxqjSQOfM6LuY+0IVFa9ngxZfv/o473LGAut+GAz?=
 =?iso-8859-1?Q?OSu6VL/7SPzWxWaDOOOje6g7g2ePOUvTRFclxhWUWrDsSzzq2RljkwiXfs?=
 =?iso-8859-1?Q?acGxIwJDtpsGYBkuL4fHYd+2xhel9RSTJ1zUxEdZDttIpSPcHD0l5sMQ1q?=
 =?iso-8859-1?Q?r22rTZ+/nj13LCBkeeeCC2QGbRgauozVBbQm45hv3Qz1ySJHXICOLstLbZ?=
 =?iso-8859-1?Q?QDWshjHC24cArbOlgczPGBY491uYU2G26vRASjqS4tuoYwFNBBybi7D/cz?=
 =?iso-8859-1?Q?66vJqOuTegnxNQYzEON4ba8qtFl/ZuQirQeB3ixGbzWMsogX3aLZb0VQIb?=
 =?iso-8859-1?Q?artmkHvc2gsJX2AJdi6r22EqFE+ea5+IG65Rmp6Fet1KMHIEafwdmoejjD?=
 =?iso-8859-1?Q?vfDWJ1pqi2njaUPOVDFt5tAJc0talBRmCG0q5xNs/CxvlJ+z0ACcFszRES?=
 =?iso-8859-1?Q?ahDXT4gsAbISLaaRez9xtTcOLht+U2iPEZr6wAigaz0AIQfOj4U6dvOVyW?=
 =?iso-8859-1?Q?fht2gzpyGk+TshZkJw56t4W31CzVBYg6AfIuFBJyGcr0GDo3FR1BVa7nSG?=
 =?iso-8859-1?Q?ZJDoSQWbrtR6nVqXINmHH7il8BLaWYh8lUrVIiFPuwNPZ3hY6ow95zrqnX?=
 =?iso-8859-1?Q?oELtu8Yi+5Wx9+dGmXFCwLCwSU4X50MTkaM7nNtbL8Y29uqWjrxLKDBz9c?=
 =?iso-8859-1?Q?X4Zid+YsOccnv6My7Xk8Mw37r2qdgERy2VA0C8HygsBkMcSM06rU6u5fmS?=
 =?iso-8859-1?Q?hpRJRjVB7+djlSzjEw3EEwdqOXBtToB1rPr+8/h80rLkX2GNDjv+yw40P5?=
 =?iso-8859-1?Q?F4ZJgD51Z6eTduC2m0iTQ5BvqQwdZaf+gUAS0qLQ0XjL8FjSZ7w1y8epTN?=
 =?iso-8859-1?Q?qSyvIrN26gNARlI2Fwkn2tO1CFpunrSQfIWIZaA9SdQ6LVIugQpNEmkFSs?=
 =?iso-8859-1?Q?4mUcythANs4lIW6F7y4lKzZE9VlVWbrd6vbkGCOBihHolLi7ssQQguV2KA?=
 =?iso-8859-1?Q?Hq+bZYpfA+5EGf4dbAhhWfVI43/vTGJbc8WS2LZp2yPX6nSM7Xjry43flT?=
 =?iso-8859-1?Q?32JPMgKr1+OkYbk8TucmYIK2L8RN+cbCfrVqd/rafchwCTybLgKG9lcXN0?=
 =?iso-8859-1?Q?P5PXGyG9fDjZs4mQA6oQilRiDqDS2owGmXdoVkonZT49mu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	zjIRucHcOeulSU0cd/Nx1iQri0KHrVIox7FSug10eX300x4Kuq1Ry7uKEtfGjfws/KONgpMYKiGoHBVrtESbV0Y1UV90NrFzrQjo1h6P3NuZnZt8GbXl8DzeLLcmntp9fX4K7IUtzqsvkQsJb5PGNTIEMXqrOeRQJCJHcJOQZIBkimZxWe4JjxqmTqOuBAtrSTQWRsggd73m+qqCdDu0wahIoE7T5V4ISYbIzZkPFZAI/LsExMtyeNP1UxSkIsdPeIW2nwZ2AvoBgkdDsH+2JoAPhKwuMh2qQKo3Tqw107Wo5jwI1pigqT5SlcBSliELIF8EBTh2tSIWvc5k7j2eog==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5e61ca-491d-434b-e079-08df1f4bc573
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:20.5606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QeHYu/dSmG61Wt01ZQzWZ2hHMivWC4hRnXPDntRrdrPeiBx7BBC2J2OS2smuOC4YbmAEs7u2iIbh3/JCE/X4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383
X-MDID: 1790811448-pPls0JtorAZH
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811448;pPls0JtorAZH;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report and set whether an input takes part in a PLL's reference=0A=
selection.  The device selects its reference itself from a priority=0A=
table, so membership of that table is what the state means here: an input=
=0A=
in the table is selectable, one absent from it is disconnected.  Setting=0A=
the state adds the input to the table or removes it, and membership is=0A=
read back from the device rather than remembered.  CONNECTED would ask=0A=
for this input and no other, which the device cannot be told to do, so it=
=0A=
is refused.  A physical input's receiver is shared by the four PLLs and is=
=0A=
powered down only when the last of them lets go of it.=0A=
=0A=
What the device does with an input is its operational state.  The PLL's=0A=
active selection names one source, and that pin is active while the PLL=0A=
is locked to it -- outer loop running, not frozen -- and its lane has=0A=
signal.  The poll reads every lane's clock monitor: an input whose=0A=
monitor reports loss of signal is no-signal, one that reports a frequency=
=0A=
drift is qual-failed, any other is standby.  A selection naming a lane=0A=
without signal reports no pin active: the device has then fallen back to=0A=
another listed source on its own, and this driver does not read which.=0A=
=0A=
The table is built from a priority the driver keeps per source and PLL,=0A=
seeded from the table the device loaded: members in priority order, the=0A=
slots past the last one naming no source.  The four-bit slot encoding=0A=
has two codes for a fifth input pair this part does not have, and one of=0A=
them serves as that.  A disconnected input keeps its priority for when it=
=0A=
comes back, and a table that would come out as the device already holds=0A=
it is not written.=0A=
=0A=
The last register of the table also carries the device's active=0A=
selection.  After a table write the PLL goes to the source it names, and=0A=
leaves it on its own only when that source loses its signal, so every=0A=
write names a source the PLL can use.  When the priorities put a=0A=
different source with signal first, the selection goes to it -- the=0A=
highest-priority valid input, which is how the DPLL interface defines=0A=
automatic mode.  A write that only changes the table below that source=0A=
leaves the selection where it is while it is still listed and has=0A=
signal, so an edit there does not pull a PLL off a healthy reference;=0A=
failing that, it goes to the first listed source that has signal.=0A=
=0A=
Removing the last input is allowed.  The selection then has nothing to=0A=
name, and left as it is it would keep the PLL following its old source=0A=
for as long as that has signal, so the PLL stays in the forced holdover=0A=
the write sequence uses -- the one state in which it follows no input.=0A=
The next write that lists a source releases it.=0A=
=0A=
The pins fall into three roles and only the first answers this question,=0A=
so the contract for all of them is written above the operations rather=0A=
than left to be inferred: inputs and the inter-PLL sync destination take=0A=
part in selection; an output and the sync source are driven by the PLL and=
=0A=
report whether they carry a signal; the crystal is fixed and always=0A=
connected, since a PLL cannot be told to stop using it.=0A=
=0A=
Probe also warns about a firmware pin node whose reg names no pin the=0A=
device can have -- a lane or an output the variant lacks, or the N lane=0A=
of a pair the configuration runs differential -- since nodes are looked=0A=
up from the pins and such a node would otherwise be dropped silently.=0A=
=0A=
Rewriting the table means forcing the PLL into holdover, waiting for it to=
=0A=
take, writing every slot and releasing holdover again, all under the=0A=
device lock -- ten to twenty milliseconds.  The device has no way to=0A=
change one slot in isolation, and holdover is what keeps the loop from=0A=
chasing a table that is momentarily inconsistent, so the sequence is the=0A=
cost of doing it correctly.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 922 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |  25 +-=0A=
 drivers/dpll/sit9531x/dpll.c | 274 +++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  16 +=0A=
 4 files changed, 1215 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index bf6817b9d565..231e2d71dd6f 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -239,6 +239,99 @@ static void sit9531x_input_get_regs(const struct sit95=
31x_dev *sitdev,=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_disable - disable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Sets the force mask bit and clears the state bit for the given=0A=
+ * input, effectively disabling it.  Register selection depends on=0A=
+ * the pair's signal mode (SE/DE) and the lane (P/N); the bit within=0A=
+ * each register addresses the input pair.=0A=
+ *=0A=
+ * Both writes are attempted even when the first fails, and the first=0A=
+ * error is returned.  Neither is rolled back: the force and state bits=0A=
+ * only mean something together, so a transient bus error can leave the=0A=
+ * force bit asserted over a state bit that was never programmed, and the=
=0A=
+ * error is what says the override is not to be trusted.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));=0A=
+=0A=
+	ret =3D sit9531x_read_u8(sitdev, state_reg, &val);=0A=
+	if (!ret)=0A=
+		ret =3D sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/*=0A=
+	 * Drop the claim even when the pair could not be programmed.  The=0A=
+	 * force bit may be asserted over a state bit that never reached the=0A=
+	 * device, so the receiver cannot be relied on; leaving the cache=0A=
+	 * saying it is on makes the next enable skip itself and report a=0A=
+	 * success the signal does not back.  Clearing the force bit again=0A=
+	 * is harmless, so the worst this costs is one redundant write.=0A=
+	 */=0A=
+	ref->enabled =3D false;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_enable - enable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Clears the force mask bit for the given input, returning it to=0A=
+ * hardware default (enabled).=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, force_reg, val & ~BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Output enable / disable (Hi-Z control)=0A=
  *=0A=
@@ -433,26 +526,537 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
 	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
 }=0A=
 =0A=
+/* Place source @src in priority slot @slot of a register value. */=0A=
+static u8 sit9531x_prio_slot_set(u8 val, u8 slot, u8 src)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return (val & (SIT9531X_PRIO_NIBBLE_MASK <<=0A=
+			       SIT9531X_PRIO_HI_SHIFT)) |=0A=
+		       (src & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+=0A=
+	return (val & SIT9531X_PRIO_NIBBLE_MASK) |=0A=
+	       ((src & SIT9531X_PRIO_NIBBLE_MASK) <<=0A=
+		SIT9531X_PRIO_HI_SHIFT);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a priority-table programming sequence through the Page-0=0A=
+ * programming directive register.=0A=
+ *=0A=
+ * A small change update is all the table needs.  The NVM-bank and=0A=
+ * loop-lock directives that the output system issues do not belong=0A=
+ * here: the former programs non-volatile storage from the efuse and=0A=
+ * the latter only means anything after an escape to the PRG_CMD=0A=
+ * state.  This matches the documented input_priority_sel() procedure.=0A=
+ */=0A=
+static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(1000, 2000);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_mon_fetch - read the clock monitor status of every lane=
=0A=
+ *=0A=
+ * Four registers carry a nibble per lane.  Loss of signal and frequency=
=0A=
+ * drift are what separate an input the device could lock to from one it=
=0A=
+ * could not, which the priority commit uses to choose the active=0A=
+ * selection and the pins report as their operational state.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock, or run before registration.=0A=
+ */=0A=
+static int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	static const unsigned int regs[] =3D {=0A=
+		SIT9531X_CLKMON_P_STATUS_01, SIT9531X_CLKMON_P_STATUS_23,=0A=
+		SIT9531X_CLKMON_N_STATUS_01, SIT9531X_CLKMON_N_STATUS_23,=0A=
+	};=0A=
+	u8 val[ARRAY_SIZE(regs)], i, pair, nib;=0A=
+	int rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(regs); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, regs[i], &val[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		struct sit9531x_ref *ref =3D &sitdev->ref[i];=0A=
+=0A=
+		/* Lane 2k is INkP, 2k + 1 INkN; a register holds two pairs. */=0A=
+		pair =3D sit9531x_input_pair(i);=0A=
+		nib =3D val[(sit9531x_input_is_n(i) ? 2 : 0) + pair / 2];=0A=
+		nib =3D (pair & 1) ? nib >> 4 : nib & 0x0F;=0A=
+=0A=
+		ref->los =3D !!(nib & SIT9531X_CLKMON_LOSS);=0A=
+		ref->qual_fail =3D !ref->los &&=0A=
+				 !!(nib & (SIT9531X_CLKMON_FINE_DRIFT |=0A=
+					   SIT9531X_CLKMON_COARSE_DRIFT));=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
- * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
- * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
- * from exactly the values the table holds -- here after a write, and once=
=0A=
- * per poll from the read-back in sit9531x_chan_state_fetch().=0A=
+ * Can the device lock to this source now?  Only the input lanes have a=0A=
+ * monitor; the on-chip oscillator and the inter-PLL net are taken as=0A=
+ * present.  A differential pair is watched through its P lane, which is=
=0A=
+ * the one its table entries are canonicalised to.=0A=
+ */=0A=
+static bool sit9531x_prio_src_live(const struct sit9531x_dev *sitdev, u8 s=
rc)=0A=
+{=0A=
+	u8 index =3D sit9531x_hw_src_input(src);=0A=
+=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return true;=0A=
+=0A=
+	return !sitdev->ref[index].los;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Fold a source code to the lane a DPLL pin actually represents.=0A=
+ *=0A=
+ * Differential input pairs expose only the P lane as a DPLL pin.  A=0A=
+ * priority table entry encoded as an N lane for such a pair must map to=
=0A=
+ * the P-lane source for pin-facing operations (membership, priority slots=
,=0A=
+ * add/remove/set lookups), matching sit9531x_ref_pll_mask_fetch().=0A=
+ */=0A=
+static u8 sit9531x_prio_src_canon(const struct sit9531x_dev *sitdev, u8 sr=
c)=0A=
+{=0A=
+	u8 index =3D sit9531x_hw_src_input(src);=0A=
+=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return src;=0A=
+=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return sit9531x_input_hw_src(index - 1);=0A=
+=0A=
+	return src;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_present - is a source listed in a PLL's priority ta=
ble=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ *=0A=
+ * Answers from the membership mask that every table write and every poll=
=0A=
+ * refreshes, which is what the pin state getters test.  The priority slot=
=0A=
+ * cannot answer this: a source that is not in the table reports the lowes=
t=0A=
+ * slot, so the slot value alone does not separate absent from last.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				 u8 input_idx)=0A=
+{=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return false;=0A=
+=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return false;=0A=
+=0A=
+	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Take the configured priorities from a table the hardware holds: each=0A=
+ * listed source gets the first slot it occupies.  A source the table does=
=0A=
+ * not list keeps whatever it had, so a disconnected input comes back with=
=0A=
+ * its old priority.=0A=
+ */=0A=
+static void sit9531x_prio_cfg_seed(struct sit9531x_dev *sitdev, u8 pll_idx=
,=0A=
+				   const u8 *srcs)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u16 seeded =3D 0;=0A=
+	u8 slot, src;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
+		src =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (seeded & BIT(src))=0A=
+			continue;=0A=
+		seeded |=3D BIT(src);=0A=
+		chan->cfg_prio[src] =3D slot;=0A=
+		chan->cfg_known |=3D BIT(src);=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * A source this PLL has never listed gets the lowest slot, the value=0A=
+	 * it reports and the one it is connected at, so its priority does not=0A=
+	 * change when its state does.=0A=
+	 */=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++) {=0A=
+		if (chan->cfg_known & BIT(src))=0A=
+			continue;=0A=
+		chan->cfg_prio[src] =3D SIT9531X_PRIO_MAX_SLOTS - 1;=0A=
+		chan->cfg_known |=3D BIT(src);=0A=
+	}=0A=
+=0A=
+	memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));=0A=
+	chan->seen_valid =3D true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Build the table for a set of member sources: ordered by configured=0A=
+ * priority, ties kept in the order the hardware table has them, the slots=
=0A=
+ * past the last member naming no source.  Filling them with the code for=
=0A=
+ * no source rather than with copies of the last member keeps every=0A=
+ * source in exactly one slot, so the order the table encodes is the=0A=
+ * order the priorities say.=0A=
+ */=0A=
+static void sit9531x_prio_table_build(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      u16 members, u8 *srcs)=0A=
+{=0A=
+	const struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 order[SIT9531X_PRIO_NUM_SRC], n =3D 0, i, j, src;=0A=
+=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++)=0A=
+		if (members & BIT(src))=0A=
+			order[n++] =3D src;=0A=
+=0A=
+	/* Insertion sort: at most a dozen entries. */=0A=
+	for (i =3D 1; i < n; i++) {=0A=
+		u8 cur =3D order[i];=0A=
+=0A=
+		for (j =3D i; j > 0; j--) {=0A=
+			u8 prev =3D order[j - 1];=0A=
+			u16 kc, kp;=0A=
+=0A=
+			kc =3D (chan->cfg_known & BIT(cur)) ?=0A=
+			     chan->cfg_prio[cur] : U8_MAX;=0A=
+			kp =3D (chan->cfg_known & BIT(prev)) ?=0A=
+			     chan->cfg_prio[prev] : U8_MAX;=0A=
+			if (kc =3D=3D kp) {=0A=
+				/* Keep the hardware order among equals. */=0A=
+				kc =3D chan->prio_last[cur] ?: U8_MAX;=0A=
+				kp =3D chan->prio_last[prev] ?: U8_MAX;=0A=
+			}=0A=
+			if (kp <=3D kc)=0A=
+				break;=0A=
+			order[j] =3D prev;=0A=
+		}=0A=
+		order[j] =3D cur;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)=0A=
+		srcs[i] =3D i < n ? order[i] : SIT9531X_PRIO_SRC_NONE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Refresh a PLL's cached view of its priority table from the source codes=
=0A=
+ * the table holds -- here after a write, and once per poll from the=0A=
+ * read-back in sit9531x_chan_state_fetch().=0A=
+ *=0A=
+ * The membership mask is what the pin state getters test, the per-slot=0A=
+ * copy is what a rewrite compares against, and the first-slot array=0A=
+ * orders sources of equal priority, so none of them costs a register read=
=0A=
+ * per pin.=0A=
  */=0A=
 static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
 				     const u8 *srcs)=0A=
 {=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 first[SIT9531X_PRIO_NUM_SRC] =3D { 0 };=0A=
 	u16 mask =3D 0;=0A=
-	u8 slot;=0A=
+	u8 slot, src, src_canon;=0A=
 =0A=
 	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
-		u8 src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src =3D srcs[slot];=0A=
+		src &=3D SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		chan->prio_srcs[slot] =3D src;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
+=0A=
+		mask |=3D BIT(src_canon);=0A=
+		if (!first[src_canon])=0A=
+			first[src_canon] =3D slot + 1;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Assign unconditionally: a source that has left the table has no=0A=
+	 * slot, and leaving its old one behind would keep reporting it as=0A=
+	 * listed for as long as the device runs.=0A=
+	 */=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++)=0A=
+		chan->prio_last[src] =3D first[src];=0A=
+=0A=
+	chan->prio_mask =3D mask;=0A=
+}=0A=
+=0A=
+/* Attempts to release a forced holdover before reporting it stuck. */=0A=
+#define SIT9531X_HO_CLEAR_TRIES		3=0A=
+=0A=
+static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *srcs);=0A=
 =0A=
-		if (sit9531x_prio_src_usable(src))=0A=
-			mask |=3D BIT(src);=0A=
+/*=0A=
+ * First source in a table that the device could lock to now, compared as=
=0A=
+ * canonical codes, or SIT9531X_PRIO_SRC_NONE when no listed source has a=
=0A=
+ * signal.=0A=
+ */=0A=
+static u8 sit9531x_prio_top_live(const struct sit9531x_dev *sitdev,=0A=
+				 const u8 *srcs)=0A=
+{=0A=
+	u8 i, src;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++) {=0A=
+		src =3D srcs[i] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (sit9531x_prio_src_usable(src) &&=0A=
+		    sit9531x_prio_src_live(sitdev, src))=0A=
+			return src;=0A=
 	}=0A=
 =0A=
-	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
+	return SIT9531X_PRIO_SRC_NONE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Choose the active selection for a table about to be latched.  After a=
=0A=
+ * table write the PLL goes to the source the selection names; it moves to=
=0A=
+ * another on its own only when that source loses its signal, which is an=
=0A=
+ * event, not a state.  So the selection has to name a source the PLL can=
=0A=
+ * use, and it follows the priorities the way the DPLL interface defines=
=0A=
+ * automatic mode -- the highest-priority valid input:=0A=
+ *=0A=
+ * - When the highest-priority source with signal is not the one the=0A=
+ *   table held before, the priorities now put another source first, and=
=0A=
+ *   the selection goes to it.=0A=
+ * - Otherwise the write only reorders sources below it, or removes one=0A=
+ *   the PLL is not on, and the selection stays where it is while that=0A=
+ *   source is still listed and has signal: a change further down the=0A=
+ *   table must not pull a PLL off a healthy reference.=0A=
+ * - Otherwise the first listed source with signal; with none alive the=0A=
+ *   first listed one is as good as any.=0A=
+ *=0A=
+ * A selection that is still listed but has lost its signal is moved too.=
=0A=
+ * The PLL has then fallen back on its own, and this driver does not read=
=0A=
+ * which source; left alone, the next table write sends it back to the=0A=
+ * dead one and it unlocks.  The device falls back to the best listed=0A=
+ * source that has signal, which is the one chosen here, so moving the=0A=
+ * selection there does not move the PLL.=0A=
+ *=0A=
+ * @old is the table the device holds before this write.=0A=
+ */=0A=
+static u8 sit9531x_prio_activesel_pick(struct sit9531x_dev *sitdev,=0A=
+				       const u8 *old, const u8 *srcs, u8 cur)=0A=
+{=0A=
+	u8 top, i;=0A=
+=0A=
+	top =3D sit9531x_prio_top_live(sitdev, srcs);=0A=
+	if (top !=3D SIT9531X_PRIO_SRC_NONE &&=0A=
+	    top !=3D sit9531x_prio_top_live(sitdev, old))=0A=
+		return top;=0A=
+=0A=
+	/*=0A=
+	 * The table is built from canonical codes, so compare in the same=0A=
+	 * terms: a differential pair selected through its N-lane code is the=0A=
+	 * P-lane entry.=0A=
+	 */=0A=
+	cur =3D sit9531x_prio_src_canon(sitdev, cur & SIT9531X_PRIO_NIBBLE_MASK);=
=0A=
+=0A=
+	if (sit9531x_prio_src_usable(cur) &&=0A=
+	    sit9531x_prio_src_live(sitdev, cur))=0A=
+		for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)=0A=
+			if (srcs[i] =3D=3D cur)=0A=
+				return cur;=0A=
+=0A=
+	if (top !=3D SIT9531X_PRIO_SRC_NONE)=0A=
+		return top;=0A=
+=0A=
+	return srcs[0];=0A=
+}=0A=
+=0A=
+static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      const u8 *srcs)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 val, slot, attempt, written =3D 0, restored =3D 0;=0A=
+	u8 now[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	int rc =3D 0, prg_rc, ho_rc =3D 0;=0A=
+	bool empty;=0A=
+	u16 reg;=0A=
+=0A=
+	empty =3D !sit9531x_prio_src_usable(srcs[0]);=0A=
+=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=
=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(10000, 12000);=0A=
+=0A=
+	/*=0A=
+	 * Two slots share a register, and this writes every slot, so both=0A=
+	 * nibbles are known for every register but the last -- build those=0A=
+	 * bytes outright.  Reading first would raise the question of what a=0A=
+	 * read returns between the write and the latch, and the answer does=0A=
+	 * not matter if nothing is read.=0A=
+	 */=0A=
+	for (slot =3D 0; slot + 1 < SIT9531X_PRIO_MAX_SLOTS; slot +=3D 2) {=0A=
+		reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+		val =3D sit9531x_prio_slot_set(0, slot, srcs[slot]);=0A=
+		val =3D sit9531x_prio_slot_set(val, slot + 1, srcs[slot + 1]);=0A=
+=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+=0A=
+		written =3D slot + 2;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The last register carries slot 10 in its high nibble and the=0A=
+	 * device's active selection in its low one; see=0A=
+	 * sit9531x_prio_activesel_pick() for how the selection is chosen.=0A=
+	 * It needs the signal state now, not as of the last poll.=0A=
+	 *=0A=
+	 * The slot setter picks its nibble by parity, so the selection is=0A=
+	 * addressed as the slot past the last one.  This register has not=0A=
+	 * been written yet in this sequence, so the read returns what the=0A=
+	 * device is running with.=0A=
+	 *=0A=
+	 * A table naming no source at all is what removing the last one=0A=
+	 * asks for.  There is nothing to point the selection at -- the code=0A=
+	 * for no source is not one the selection takes -- so the nibble is=0A=
+	 * left alone and the PLL is kept in holdover below instead.=0A=
+	 */=0A=
+	reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+	if (rc)=0A=
+		goto rollback;=0A=
+=0A=
+	val =3D sit9531x_prio_slot_set(val, slot, srcs[slot]);=0A=
+=0A=
+	if (!empty) {=0A=
+		u8 sel =3D sit9531x_prio_slot_get(val, slot + 1);=0A=
+=0A=
+		if (sit9531x_input_mon_fetch(sitdev))=0A=
+			dev_warn_ratelimited(sitdev->dev,=0A=
+					     "PLL%c: input monitor not read; choosing the selection without i=
t\n",=0A=
+					     'A' + pll_idx);=0A=
+		sel =3D sit9531x_prio_activesel_pick(sitdev, chan->prio_srcs,=0A=
+						   srcs, sel);=0A=
+		val =3D sit9531x_prio_slot_set(val, slot + 1, sel);=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+	if (rc)=0A=
+		goto rollback;=0A=
+=0A=
+	written =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+=0A=
+rollback:=0A=
+	if (rc && written) {=0A=
+		/*=0A=
+		 * Put the slots that did reach the device back the way they=0A=
+		 * were.  Latching a table that is neither the previous order=0A=
+		 * nor the requested one hands the reference selection loop=0A=
+		 * a priority list nobody asked for.  The cache is the table=0A=
+		 * as last read, which is what those slots held.=0A=
+		 */=0A=
+		for (slot =3D 0; slot < written; slot +=3D 2) {=0A=
+			u8 old;=0A=
+=0A=
+			old =3D sit9531x_prio_slot_set(0, slot,=0A=
+						     chan->prio_srcs[slot]);=0A=
+			old =3D sit9531x_prio_slot_set(old, slot + 1,=0A=
+						     chan->prio_srcs[slot + 1]);=0A=
+			if (sit9531x_write_u8(sitdev,=0A=
+					      sit9531x_prio_reg(pll_idx, slot),=0A=
+					      old))=0A=
+				break;=0A=
+=0A=
+			restored =3D slot + 2;=0A=
+		}=0A=
+		written =3D restored;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Latch unconditionally: the slots that reached the device are in=0A=
+	 * the table regardless, so the latch keeps hardware and the cache=0A=
+	 * refresh below consistent with what was actually written.=0A=
+	 */=0A=
+	prg_rc =3D sit9531x_prio_prg_commit(sitdev);=0A=
+	if (prg_rc && !rc)=0A=
+		rc =3D prg_rc;=0A=
+=0A=
+	/*=0A=
+	 * Refresh the cache so a get that follows a set does not have to=0A=
+	 * wait for the next poll.  After a complete write that is the table=0A=
+	 * just written.  After a failure it is whatever the device holds=0A=
+	 * now -- part request, part restore -- so read it back rather than=0A=
+	 * piece it together: the membership test decides what a failed=0A=
+	 * request rolls back, and it must not answer for writes that did not=0A=
+	 * land.  A read-back that fails too leaves the next poll to do it.=0A=
+	 */=0A=
+	if (!rc) {=0A=
+		sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+		memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));=0A=
+		chan->seen_valid =3D true;=0A=
+	} else if (!sit9531x_prio_table_read(sitdev, pll_idx, now)) {=0A=
+		sit9531x_prio_mask_build(sitdev, pll_idx, now);=0A=
+		memcpy(chan->seen_srcs, now, sizeof(chan->seen_srcs));=0A=
+		chan->seen_valid =3D true;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * A table that names no source keeps the PLL in the holdover forced=0A=
+	 * above: that is the one state in which it follows no input, which=0A=
+	 * is what disconnecting every input asks for.  The selection nibble=0A=
+	 * alone would not do it -- it still names the old source, and the=0A=
+	 * PLL keeps following that one for as long as it has signal.  The=0A=
+	 * next table write that lists a source releases it.=0A=
+	 */=0A=
+	if (empty && !rc) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"PLL%c: no source listed, holdover kept\n",=0A=
+			'A' + pll_idx);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Release the forced holdover.  Apart from an empty table, nothing=0A=
+	 * in the driver keeps this bit set, so a PLL left with it reports=0A=
+	 * holdover until the next table write on the same PLL clears it,=0A=
+	 * which may never come.  Retry before giving up, and say so if it=0A=
+	 * stays set.=0A=
+	 */=0A=
+	for (attempt =3D 0; attempt < SIT9531X_HO_CLEAR_TRIES; attempt++) {=0A=
+		ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					       SIT9531X_PLL_REG_HO_CTRL,=0A=
+					       BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+					       0);=0A=
+		if (!ho_rc)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (ho_rc) {=0A=
+		dev_err(sitdev->dev, "PLL%c left in forced holdover: %d\n",=0A=
+			'A' + pll_idx, ho_rc);=0A=
+		if (!rc)=0A=
+			rc =3D ho_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -479,6 +1083,137 @@ static int sit9531x_prio_table_read(struct sit9531x_=
dev *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Rewrite a PLL's table for a new member set, unless it would come out as=
=0A=
+ * the table already holds: every write forces the PLL into holdover for=
=0A=
+ * the length of the sequence, so one that changes nothing is a=0A=
+ * disturbance nobody asked for.=0A=
+ */=0A=
+static int sit9531x_prio_table_apply(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
+				     u16 members)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+=0A=
+	if (hweight16(members) > SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -ENOSPC;=0A=
+=0A=
+	sit9531x_prio_table_build(sitdev, pll_idx, members, srcs);=0A=
+	if (!memcmp(srcs, sitdev->chan[pll_idx].prio_srcs, sizeof(srcs)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_set - set an input's priority on a PLL=0A=
+ * @input_idx:	input source in hardware encoding (0-11, see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	priority, lower is preferred=0A=
+ *=0A=
+ * Records the priority and, when the source is in the PLL's table,=0A=
+ * rebuilds the table from the configured priorities.  A source that is=0A=
+ * not in the table keeps the priority for when it is connected: that is=
=0A=
+ * the pin's state, and it belongs to the state setter.  Other sources=0A=
+ * keep theirs either way, so no sibling's priority moves.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -EINVAL for a bad PLL or source, <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	chan->cfg_prio[input_idx] =3D prio;=0A=
+	chan->cfg_known |=3D BIT(input_idx);=0A=
+=0A=
+	if (!(chan->prio_mask & BIT(input_idx)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_apply(sitdev, pll_idx, chan->prio_mask);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_remove - drop an input from a PLL's priority table=
=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Rebuilds the table without the source, which makes a disconnected=0A=
+ * input ineligible for automatic reference selection, not just gated at=
=0A=
+ * the input buffer.  The source keeps its configured priority for when it=
=0A=
+ * comes back.  Removing a source that is absent succeeds without touching=
=0A=
+ * the table.  Removing the last one leaves a table that names no source;=
=0A=
+ * the commit then keeps the PLL in holdover, which is what disconnecting=
=0A=
+ * every input asks for.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (!(chan->prio_mask & BIT(input_idx)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_apply(sitdev, pll_idx,=0A=
+					 chan->prio_mask & ~BIT(input_idx));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_add - make an input eligible in a PLL's table=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Puts the source back into the table at its configured priority; one the=
=0A=
+ * PLL never listed has the lowest slot (see sit9531x_prio_cfg_seed()).  A=
=0A=
+ * source that is already listed leaves the table untouched.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENOSPC when the table cannot hold another=0A=
+ * source, <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (chan->prio_mask & BIT(input_idx))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_apply(sitdev, pll_idx,=0A=
+					 chan->prio_mask | BIT(input_idx));=0A=
+}=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -569,7 +1304,8 @@ int sit9531x_clear_notifications(struct sit9531x_dev *=
sitdev)=0A=
  * @index:	logical input index=0A=
  *=0A=
  * Reads whether the lane's receiver is on, from the Page 0x02 force and=
=0A=
- * state bits.=0A=
+ * state bits.  Signal status comes from sit9531x_input_mon_fetch(),=0A=
+ * which reads every lane's clock monitor in one pass.=0A=
  */=0A=
 static int sit9531x_ref_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
 {=0A=
@@ -739,12 +1475,27 @@ static int sit9531x_chan_state_fetch(struct sit9531x=
_dev *sitdev, u8 pll_idx)=0A=
 =0A=
 	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
 =0A=
+	/*=0A=
+	 * The configured priorities come from the table the first time it=0A=
+	 * is read, and again whenever it no longer matches what the driver=0A=
+	 * last wrote: something else -- a profile reload, a direct I2C=0A=
+	 * tool -- rewrote it, and that table is now the configuration.=0A=
+	 */=0A=
+	if (!chan->seen_valid ||=0A=
+	    memcmp(srcs, chan->seen_srcs, sizeof(chan->seen_srcs)))=0A=
+		sit9531x_prio_cfg_seed(sitdev, pll_idx, srcs);=0A=
+=0A=
 	/* STATUS_1_GENERIC reports loss of lock, so invert it. */=0A=
 	chan->active =3D active;=0A=
 	chan->locked =3D active && !(outer_lol & BIT(pll_idx));=0A=
 	chan->mode =3D !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);=0A=
-	chan->selected_ref =3D=0A=
-		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+	/*=0A=
+	 * Canonicalise like the table entries: a differential pair selected=0A=
+	 * through its N-lane code is the P-lane pin.=0A=
+	 */=0A=
+	input_sel &=3D SIT9531X_PRIO_NIBBLE_MASK;=0A=
+	input_sel =3D sit9531x_prio_src_canon(sitdev, input_sel);=0A=
+	chan->selected_ref =3D sit9531x_hw_src_input(input_sel);=0A=
 	chan->inner_lol =3D !!(inner_lol & BIT(pll_idx));=0A=
 	chan->ho_freeze =3D !!(ho_freeze & BIT(pll_idx));=0A=
 	chan->ho_valid =3D !!(pll_status_1 & SIT9531X_PLL_STATUS_1_HO_VALID);=0A=
@@ -913,6 +1664,13 @@ static int sit9531x_dev_state_fetch(struct sit9531x_d=
ev *sitdev)=0A=
 		}=0A=
 	}=0A=
 =0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to read the input clock monitors: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * The priority-table read walks the Page-1 registers, so it runs=0A=
 	 * with multiop_lock held like every other multi-register sequence.=0A=
@@ -961,6 +1719,46 @@ static void sit9531x_dev_ref_states_update(struct sit=
9531x_dev *sitdev)=0A=
 			dev_warn(sitdev->dev,=0A=
 				 "Failed to get REF%u status: %d\n", i, rc);=0A=
 	}=0A=
+=0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "Failed to read the input clock monitors: %d\n", rc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_ref_pll_mask_rebuild - re-derive the input receiver refcounts=
=0A=
+ *=0A=
+ * ref->pll_mask decides when an input receiver may be powered down, and=
=0A=
+ * the connect and disconnect paths maintain it by hand.  A request that=
=0A=
+ * failed part way through leaves it describing a table the device does=0A=
+ * not hold, and nothing else corrected it: a later disconnect could then=
=0A=
+ * drop the count to zero and gate an input another PLL is still locked=0A=
+ * to.  Re-derive every mask from the tables the poll has just read.  No=
=0A=
+ * extra bus traffic -- sit9531x_chan_state_fetch() refreshed the masks=0A=
+ * this reads immediately before.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_ref_pll_mask_rebuild(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 pll_idx, src, index;=0A=
+=0A=
+	for (index =3D 0; index < sitdev->info->num_inputs; index++)=0A=
+		sitdev->ref[index].pll_mask =3D 0;=0A=
+=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		u16 mask =3D sitdev->chan[pll_idx].prio_mask;=0A=
+=0A=
+		for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++) {=0A=
+			if (!(mask & BIT(src)))=0A=
+				continue;=0A=
+=0A=
+			index =3D sit9531x_hw_src_input(src);=0A=
+			if (index < sitdev->info->num_inputs)=0A=
+				sitdev->ref[index].pll_mask |=3D BIT(pll_idx);=0A=
+		}=0A=
+	}=0A=
 }=0A=
 =0A=
 static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)=
=0A=
@@ -974,6 +1772,8 @@ static void sit9531x_dev_chan_states_update(struct sit=
9531x_dev *sitdev)=0A=
 				 "Failed to get PLL%c state: %d\n",=0A=
 				 'A' + i, rc);=0A=
 	}=0A=
+=0A=
+	sit9531x_ref_pll_mask_rebuild(sitdev);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -1265,6 +2065,84 @@ static void sit9531x_pll_states_report(struct sit953=
1x_dev *sitdev)=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_pin_is_registrable - check if an input pin is registrabl=
e=0A=
+ *=0A=
+ * Split out so input-model changes stay local to this helper.=0A=
+ *=0A=
+ * Return: true if the input pin should be registered, false otherwise=0A=
+ */=0A=
+static bool sit9531x_input_pin_is_registrable(struct sit9531x_dev *sitdev,=
=0A=
+					      u8 index)=0A=
+{=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * The N lane of a differentially-configured pair is not a=0A=
+	 * standalone input and is skipped (zl3073x model).=0A=
+	 */=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Warn about a pin node in the firmware description whose reg names no=0A=
+ * pin this device can have: an input lane or an output the variant does=
=0A=
+ * not have, or the N lane of a pair the configuration runs differential.=
=0A=
+ * Nodes are looked up from the pins (sit9531x_pin_props_get()), so such a=
=0A=
+ * node would otherwise have its label and frequencies dropped without a=
=0A=
+ * word.  The binding bounds reg per variant; this catches what reaches=0A=
+ * the driver unvalidated, and the pair mode, which only the loaded=0A=
+ * configuration decides.  An output that exists but that no PLL drives=0A=
+ * gets no pin either and is not reported: which outputs a configuration=
=0A=
+ * uses is not a fault in the description.=0A=
+ */=0A=
+static void sit9531x_pin_nodes_check(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct fwnode_handle *pins, *node;=0A=
+	bool found;=0A=
+	u32 reg;=0A=
+	u8 i;=0A=
+=0A=
+	pins =3D device_get_named_child_node(sitdev->dev, "input-pins");=0A=
+	fwnode_for_each_child_node(pins, node) {=0A=
+		if (fwnode_property_read_u32(node, "reg", &reg))=0A=
+			continue;=0A=
+		if (reg < sitdev->info->num_inputs &&=0A=
+		    sit9531x_input_pin_is_registrable(sitdev, reg))=0A=
+			continue;=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "input-pins/%pfwP: reg %u is %s, node ignored\n",=0A=
+			 node, reg,=0A=
+			 reg < sitdev->info->num_inputs ?=0A=
+			 "the N lane of a differential pair" :=0A=
+			 "not an input lane");=0A=
+	}=0A=
+	fwnode_handle_put(pins);=0A=
+=0A=
+	pins =3D device_get_named_child_node(sitdev->dev, "output-pins");=0A=
+	fwnode_for_each_child_node(pins, node) {=0A=
+		if (fwnode_property_read_u32(node, "reg", &reg))=0A=
+			continue;=0A=
+		found =3D false;=0A=
+		for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+			if (sitdev->info->clkout_map[i] =3D=3D reg) {=0A=
+				found =3D true;=0A=
+				break;=0A=
+			}=0A=
+		}=0A=
+		if (!found)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "output-pins/%pfwP: reg %u is not an output of %s, node ignored\n",=
=0A=
+				 node, reg, sitdev->info->name);=0A=
+	}=0A=
+	fwnode_handle_put(pins);=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dev_start - start normal operation=0A=
  *=0A=
@@ -1287,6 +2165,8 @@ int sit9531x_dev_start(struct sit9531x_dev *sitdev)=
=0A=
 	sit9531x_pll_states_report(sitdev);=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
 =0A=
+	sit9531x_pin_nodes_check(sitdev);=0A=
+=0A=
 	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
 		rc =3D sit9531x_dpll_register(sitdpll);=0A=
 		if (rc) {=0A=
@@ -1468,9 +2348,9 @@ static void sit9531x_dpll_pins_unregister(struct sit9=
531x_dpll *sitdpll)=0A=
  * @dir:	pin direction=0A=
  * @index:	pin hardware index=0A=
  *=0A=
- * Only the XO pin has a complete pin-op table in this patch, so only=0A=
- * the XO pin is registrable here.  Other pin classes are registered=0A=
- * once their state callbacks land in the following patches.=0A=
+ * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
+ * A pin class whose state callback the tree does not have yet is not=0A=
+ * registrable: the core refuses a pin without one.=0A=
  *=0A=
  * Return: true if pin should be registered, false otherwise=0A=
  */=0A=
@@ -1478,15 +2358,15 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 					     enum dpll_pin_direction dir,=0A=
 					     u8 index)=0A=
 {=0A=
-	/*=0A=
-	 * Only the XO pin has a complete pin-op table in this patch.=0A=
-	 * Other pin classes are registered once their state callbacks=0A=
-	 * land in the following patches.=0A=
-	 */=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
 	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
 		return false;=0A=
 =0A=
-	return index =3D=3D SIT9531X_MAX_INPUTS;=0A=
+	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+		return true;=0A=
+=0A=
+	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 28fc99f50063..adcdfc46c597 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -77,6 +77,9 @@ enum sit9531x_signal_mode {=0A=
  * @freq:		configured frequency in Hz=0A=
  * @enabled:		the lane's receiver is on=0A=
  * @pll_mask:		bitmask of PLLs this input feeds (bit 0 =3D PLLA)=0A=
+ * @los:		the clock monitor reports loss of signal on the lane=0A=
+ * @qual_fail:		the clock monitor reports a frequency drift on the=0A=
+ *			lane while it still has signal=0A=
  * @sig_mode:		signal mode of the pair this lane belongs to=0A=
  *			(detected from CLKINx_INPUT_MODE at probe)=0A=
  */=0A=
@@ -84,6 +87,8 @@ struct sit9531x_ref {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
 	u8		pll_mask;=0A=
+	bool		los;=0A=
+	bool		qual_fail;=0A=
 	enum sit9531x_signal_mode	sig_mode;=0A=
 };=0A=
 =0A=
@@ -121,7 +126,13 @@ struct sit9531x_out {=0A=
  * @ho_freeze:		holdover freeze active=0A=
  * @ho_valid:		holdover memory acquired, i.e. the holdover window=0A=
  *			holds a valid estimate to fall back on=0A=
- * @prio_mask:		bit per hardware source code present in this PLL's=0A=
+ * @prio_srcs:		cached copy of the priority table, one source code=0A=
+ *			per slot; refreshed together with @prio_mask, it is=0A=
+ *			what a rebuilt table is compared against=0A=
+ * @prio_last:		first slot each source occupies, plus one (0 =3D the=0A=
+ *			source is not in the table); refreshed from the same=0A=
+ *			scan as @prio_mask, so the two never disagree=0A=
+ * @prio_mask:		bit per canonical source present in this PLL's=0A=
  *			priority table, i.e. the sources it may select.  Read=0A=
  *			back from the table by the periodic worker and=0A=
  *			refreshed by every table write, so it tracks the=0A=
@@ -145,6 +156,8 @@ struct sit9531x_chan {=0A=
 	bool		inner_lol;=0A=
 	bool		ho_freeze;=0A=
 	bool		ho_valid;=0A=
+	u8		prio_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8		prio_last[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		prio_mask;=0A=
 	u8		cfg_prio[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		cfg_known;=0A=
@@ -229,8 +242,18 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev=
, u8 pll_idx,=0A=
 			   u8 offset, u8 mask, u8 val);=0A=
 =0A=
 /* ---- Input enable/disable ---- */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
 =0A=
 /* ---- Input priority ---- */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev,=0A=
+				 u8 pll_idx, u8 input_idx);=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx);=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx);=0A=
 =0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 924386aec4d8..f961b7af28fe 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -219,6 +219,125 @@ const struct dpll_device_ops sit9531x_dpll_device_ops=
 =3D {=0A=
  * FIXED role -- XO pin.  Always CONNECTED; it cannot be routed.=0A=
  */=0A=
 =0A=
+/*=0A=
+ * Report a selection-role pin's state on this DPLL.  @pin_id is a logical=
=0A=
+ * input index, SIT9531X_INTSYNC_PIN_ID for the INTSYNC destination.=0A=
+ *=0A=
+ * Membership comes from chan->prio_mask, which is the priority table read=
=0A=
+ * back from the chip -- not a record of what the driver asked for.  The=
=0A=
+ * getter runs on every poll for every input pin of every DPLL, so it take=
s=0A=
+ * the mask the worker refreshed rather than rescanning the table over I2C=
=0A=
+ * each time; table writes refresh it too, so a get right after a set does=
=0A=
+ * not report the old membership.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void=0A=
+sit9531x_dpll_selection_state_get(struct sit9531x_dev *sitdev,=0A=
+				  const struct sit9531x_dpll *sitdpll,=0A=
+				  u8 pin_id, enum dpll_pin_state *state)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	if (chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id)))=0A=
+		*state =3D DPLL_PIN_STATE_SELECTABLE;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Is this the reference the PLL is tracking now?  See the S && L && !N=0A=
+ * predicate in the pin-state contract.  This is also what gates the=0A=
+ * measurements taken against the active reference.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_selection_active(struct sit9531x_dev *sitdev,=0A=
+			       const struct sit9531x_dpll *sitdpll, u8 pin_id)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	if (chan->selected_ref !=3D pin_id || !chan->locked || chan->mode ||=0A=
+	    chan->ho_freeze)=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * A selection naming a lane without signal is not what the PLL runs=0A=
+	 * on: the device has fallen back to another listed source on its=0A=
+	 * own, and this driver does not read which.  Report no pin as=0A=
+	 * active then, rather than the dead one.=0A=
+	 */=0A=
+	if (pin_id < sitdev->info->num_inputs &&=0A=
+	    sit9531x_ref_state_get(sitdev, pin_id)->los)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Report a selection-role pin's operational state on this DPLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void=0A=
+sit9531x_dpll_selection_operstate_get(struct sit9531x_dev *sitdev,=0A=
+				      const struct sit9531x_dpll *sitdpll,=0A=
+				      u8 pin_id,=0A=
+				      enum dpll_pin_operstate *operstate)=0A=
+{=0A=
+	const struct sit9531x_ref *ref;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (sit9531x_dpll_selection_active(sitdev, sitdpll, pin_id)) {=0A=
+		*operstate =3D DPLL_PIN_OPERSTATE_ACTIVE;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (pin_id < sitdev->info->num_inputs) {=0A=
+		ref =3D sit9531x_ref_state_get(sitdev, pin_id);=0A=
+		if (ref->los) {=0A=
+			*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
+			return;=0A=
+		}=0A=
+		if (ref->qual_fail) {=0A=
+			*operstate =3D DPLL_PIN_OPERSTATE_QUAL_FAILED;=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	*operstate =3D DPLL_PIN_OPERSTATE_STANDBY;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_input_pin_operstate_on_dpll_get(const struct dpll_pin *pin,=
=0A=
+					      void *pin_priv,=0A=
+					      const struct dpll_device *dpll,=0A=
+					      void *dpll_priv,=0A=
+					      enum dpll_pin_operstate *state,=0A=
+					      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll, dpin->id,=0A=
+					      state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static int=0A=
 sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
 				      void *pin_priv,=0A=
@@ -231,8 +350,163 @@ sit9531x_dpll_input_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
+ *=0A=
+ * Selection role; see the pin-state contract above.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state *state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_set - set input pin DPLL state=0A=
+ *=0A=
+ * Enables or disables the physical input receiver via Page 0x02=0A=
+ * force/state registers (sit9531x_input_disable/enable()) and updates=0A=
+ * this DPLL's Page 1 priority table so the state is honoured by the=0A=
+ * PLL's automatic reference selection, not just at the input buffer.=0A=
+ * Selection role; see the pin-state contract above for the states.=0A=
+ *=0A=
+ * The priority table is per PLL, so it is always updated for this DPLL.=
=0A=
+ * A single physical input feeds every DPLL, so the hardware receiver is=
=0A=
+ * only cut off once the last DPLL has released it: ref->pll_mask tracks=
=0A=
+ * which DPLLs currently claim the input, and the physical disable=0A=
+ * happens on the transition to an empty mask.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[dpin->id];=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(dpin->id);=0A=
+	u8 pll_bit =3D BIT(sitdpll->id);=0A=
+	bool enabled_here =3D false;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		/*=0A=
+		 * The table write, the latch and the holdover release are=0A=
+		 * three steps behind one return code, so ask the table what=0A=
+		 * actually happened rather than reading the errno as "no=0A=
+		 * change".  A source that is gone from the table has been=0A=
+		 * released whatever else failed.=0A=
+		 */=0A=
+		if (rc && sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						      hw_src))=0A=
+			break;=0A=
+		ref->pll_mask &=3D ~pll_bit;=0A=
+		/*=0A=
+		 * The receiver is shared, so the last DPLL to let go turns it=0A=
+		 * off.  That has to happen even when the table rewrite=0A=
+		 * reported an error, or the input stays powered with nothing=0A=
+		 * tracking it; the first error is the one returned.=0A=
+		 */=0A=
+		if (!ref->pll_mask) {=0A=
+			int off_rc =3D sit9531x_input_disable(sitdev, dpin->id);=0A=
+=0A=
+			if (off_rc && !rc)=0A=
+				rc =3D off_rc;=0A=
+		}=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		/*=0A=
+		 * CONNECTED asks for this input and no other, which the=0A=
+		 * device cannot be told to do: it selects by priority and the=0A=
+		 * manual-active-select path is not wired up (see "Mode").=0A=
+		 * Refuse instead of quietly behaving like SELECTABLE.=0A=
+		 */=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		/*=0A=
+		 * Gate the receiver on whenever it is off, not only when this=0A=
+		 * DPLL holds no claim yet.  The two are tracked separately --=0A=
+		 * the claim comes from the priority table, the receiver from=0A=
+		 * the force bits -- so a PLL that already lists the input can=0A=
+		 * still find it powered down, and skipping the enable would=0A=
+		 * report success for a reference that cannot reach the loop.=0A=
+		 */=0A=
+		if (!ref->enabled) {=0A=
+			rc =3D sit9531x_input_enable(sitdev, dpin->id);=0A=
+			if (rc)=0A=
+				break;=0A=
+			enabled_here =3D true;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc && !sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						       hw_src)) {=0A=
+			/*=0A=
+			 * Undo only what this request did.  A receiver the=0A=
+			 * loaded configuration had already turned on is not=0A=
+			 * this request's to turn off.=0A=
+			 */=0A=
+			if (enabled_here)=0A=
+				sit9531x_input_disable(sitdev, dpin->id);=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * Claim the input for this DPLL only once it is both enabled=0A=
+		 * and present in the priority table.  Setting the mask before=0A=
+		 * prio_add would leak the claim if prio_add failed, keeping the=0A=
+		 * shared input receiver powered even after every DPLL released=0A=
+		 * it.=0A=
+		 */=0A=
+		ref->pll_mask |=3D pll_bit;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Leave the messages the switch already set in place; only a failure=0A=
+	 * that came from the hardware path still needs one.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
+	else if (rc && rc !=3D -EOPNOTSUPP && rc !=3D -EINVAL)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 9349ec722569..d5e378715110 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -126,6 +126,10 @@=0A=
 #define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
 #define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
 =0A=
+/* PLL holdover control (PLL page offset) */=0A=
+#define SIT9531X_PLL_REG_HO_CTRL		0x6F=0A=
+#define SIT9531X_PLL_HO_FORCE_BIT		4=0A=
+=0A=
 /* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
 #define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
 #define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
@@ -266,6 +270,18 @@=0A=
 #define SIT9531X_PLL_REG_STATUS_1		0x06=0A=
 #define SIT9531X_PLL_STATUS_1_HO_VALID	BIT(2)=0A=
 =0A=
+/*=0A=
+ * Page 0x06 clock monitor status, one nibble per input lane: P lanes in=
=0A=
+ * 0x02 (IN0P low, IN1P high) and 0x06 (IN2P, IN3P), N lanes in 0x92=0A=
+ * (IN0N, IN1N) and 0x96 (IN2N, IN3N).=0A=
+ */=0A=
+#define SIT9531X_CLKMON_P_STATUS_01		SIT9531X_REG(0x06, 0x02)=0A=
+#define SIT9531X_CLKMON_P_STATUS_23		SIT9531X_REG(0x06, 0x06)=0A=
+#define SIT9531X_CLKMON_N_STATUS_01		SIT9531X_REG(0x06, 0x92)=0A=
+#define SIT9531X_CLKMON_N_STATUS_23		SIT9531X_REG(0x06, 0x96)=0A=
+#define SIT9531X_CLKMON_FINE_DRIFT		BIT(0)=0A=
+#define SIT9531X_CLKMON_COARSE_DRIFT		BIT(1)=0A=
+#define SIT9531X_CLKMON_LOSS			BIT(2)=0A=
 #define SIT9531X_CLKMON_P_NOTIF_01		SIT9531X_REG(0x06, 0x03)=0A=
 #define SIT9531X_CLKMON_P_NOTIF_23		SIT9531X_REG(0x06, 0x07)=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
