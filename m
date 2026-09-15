Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426027144B;
	Tue, 15 Sep 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430431; cv=fail; b=pVGrbDHkOrqwGHbgh9D2WIVFp0SNG14fHgGfUPFOO8+kZmd8r6tywAuh/7cXT5noxDGtvPvrxvgJvGie4u1lDfhpQuDkbmD2vxqBb4QlSL2owlzuWz6966dFfppdcjClds/wr0VgPFoEd+fJ4H+2RRy+UWkkbJ4dyJ4///dq+f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430431; c=relaxed/simple;
	bh=jeENMW6Kba3npQqACOQAdJlLp6TUb4aYfq34Hreebp4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fDmGdNRHPu3AZF4JUHQD7CbSCGaHJClRzza1WXngblaGQnktFTwevCooAixrs9Z0f0uxcmPSHcoNOsbZ6nnoFYacWti8Gay3ygBrBhV+Kw8rQ0HGVYeTo9JwV7iYTeBc3vNT3puGTJG/aCmKwcnuWxwgY86CHOLbck00beSSCPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=ALLhgYjs; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=0P3oJetx; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="ALLhgYjs";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="0P3oJetx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=JJZv1edS6Ywv17FVyNtpTDxclIbjuRj1c0yVvQGFacc=;
 b=ALLhgYjsY4X16nvFpurmthCgW7x5ZklZ3DMjRun16t8ZkQfdDqEnbGFkKe6FN/gPp1vRDL6XQdcru46rIbB2vnqPL7bXynhXHwUBVyDP2kfI54ILlTCaGpmU16y9Que//9J85K6BSa/nkSzgusIihlOjx8NII27AioJVJYsHUzy9t1iWpK7ZKf4Qp0f4rV4GWVWLIp7XnlixfNa0dio2QhZZLBHEmgebjhLE3MVa/lwWVqQF2G0RM19fBozC53rpd3q0z5dtUDtTpMIUX1iKvD6SVzhrrpdiLZf56pH4f/bTcwT2Bd1/8D1QQAWn/RNzFU8VPsBD+vIkN5A4C/Zk4A==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8409710006B;
	Tue, 15 Sep 2026 00:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1riPvz0o2SxcQCb28EeaR1yW2Wa4OKRHZSVKPWHe2/4phYAkx+vPCczjaltsKtZXWChHteqMEtHU3cjJCi2/pQe+UpCWb12vwYriShzhjL+X9g0dZd4PXW/SwnftvGVS85ONK9EaOwv3cGM3BbgAeoETXTxQTy51e/01oIrNLLoktdmGelzvkKndBagATUKkCU4pV6OcUavfCzjeajM2jCr2MQ62pinLrzykumhmX3MeEY1Ue9Swrsito5n3ByZ4DaZDmFMSUowopWhq9ZMh7ekbJYrvsq3uZDAjCG2K9ICDF7xIWfYqdz4GZ1MCax3KN5hZ0ZMMBIaefeTV/1bPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJZv1edS6Ywv17FVyNtpTDxclIbjuRj1c0yVvQGFacc=;
 b=jOf7LyY6vgL86RdfqAfCDtwj2Pj5IeSu6YNoJfN6KyNhbxwzqzBJpPMpB3aVARkFCCXrduiN9d6j/I7yAinw+Hpk7sjaG/c11S46aGnGsXD3Nai8S00YMn49iICw/O07Y3LkECq7GAFgPVLHg1MLcoN5qjNKJP+o3PdtjwUJ0tEmJSQk+17ZxJLZ+qbGB1fV5SCQMiAyM1m6UJWW+Q1SHCIcHhoAfULNWABURExPz8fDf9qq4zMuRpcN7GxzUgCJ5YoyLLzs+ZW7avzizcEGSEGWe9xjmYRwJS7JSFjpyLVQambwqPW+IWbv9b7k5VHkZGnHynK7Y/oPKGMjK5szLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJZv1edS6Ywv17FVyNtpTDxclIbjuRj1c0yVvQGFacc=;
 b=0P3oJetxVEvht2H4RJKT1BwmX32pZEcvH9wnBwNBHlosnkUE1PiUAU3vKMVe0XZ16f0MAIcvNYRqJQT5HB4p2f5bhIjqriOVKkl+vZH9DB2BJuLBoOl/Sgc9mVVauZk1n4y6FBUlufiC0KPcmJMrpcAvCPsTgn2WxSSmMJhgo2ut5dUXy+cBSpCmF8C5xMtcIm4Qy/KEIx3n/bz0/YNKE3I6WKZaGNweUo0U6w0Sqvp1TsoDI/K0iaEIJ29xVXYN2vM6LTJVum9yFloefo5VSQZ63JmHqXNUPhLiSs3QQsmoIb/JLmHx8HaoPMfj8uz6QRVUk+iSTvREYi1x4nyJgw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:18 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:16 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v9 00/15] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH net-next v9 00/15] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdRKUw/OH0pxadDUOCQtb6uoQA4w==
Date: Tue, 15 Sep 2026 00:00:16 +0000
Message-ID: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: 9eccf7d5-0f94-4311-a2f6-08df12bc52f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 FnefJ9FDccBDFeyvnm/kF9HmJ1n89lLNRylJD9wD45RNkSiFFE2im4oAW6N7oYRrRWJXwS3mVpPiiGKVP0/LQUQZB/tXPimS5ib+Giw7YU/AkKtaiRPHavodDOnqTfug56LExkgxIwxiSnzkc/A1qt4+ByHUc881vOERQjKbC2CL+Dev7Ucmfe2QWd3nMJjwvF6cIpk+T9CwkuRPGLWl0nlatSIYpAPSINcbsAeu+SXyz5Mt9H8UJKqfuPr7oyP5WXCvJ7tAnVITYfxNHgtAh0kpXrSB/F6jUOagNb9Ia9jLreR24NsP7a7lGOVf51JgmEe+qHyxbngqHXfMY+zVL3SQl+QesyI9IoqYQFA0kxMR36CyEcOaCW9UfKzUuooaPe5uPwARRSiwZUHI7ylIl0Ertv7c2Q5Xol9gh9WZJlHuRbxLDurOSknFKjiwI/eGJ5vDsW27qml0DIOqItPivBC7t0BDPIM93BMp1L6tz9o+b+szYQxtQq7QkhCmpctP4Ij6dP9X4zdTKo0rVbdesEtLkO29zCMjYNUNjJWHgGB4gEO3j6d6LMjvzuLOM+H80NQEO7CR+tdG1dlnzzHTY/cwVXnjXIro6gvNPrJlmeGkcaN+kwLHm+0MFfmMhI99HnWOsT9ENXlSN8hU7wp4q+1rGHks0dKlKuIfdWoQZ5omKAGm5u7yXl6sJo2aQDKrGWSpxwTYXJeEy56T70rI/i2QoUTEYnI3D5dkKqZFMQg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?H4yaASBQ5BUVyWQdj0rweU9JDx41wIbfFSPXCA1RSX1TnibrgymAE8eNbP?=
 =?iso-8859-1?Q?/DrSQruLtOCB82yuVps6e6XbwcLIzEOY+4F0njUlqDKoSWsgrmEJLYFBEE?=
 =?iso-8859-1?Q?WLWkWQa4PiJH9KdqKyZSQBu731Szh+CC05hzB78/qarjzw01qVGzmgAanM?=
 =?iso-8859-1?Q?OXZ7KKhndjod7XCsLiQ8C0I86s1vaIBjtRGtz99LuEg5TnwEBRiO1ptrSE?=
 =?iso-8859-1?Q?jPVfmgvh63fCUctdolPphOTMvkyQQTewCKZN7El1B/qsrc+X+LUD9QEnM1?=
 =?iso-8859-1?Q?uZxEfjQJw14MRFWH66MEEIKlyf/YQC1GVqcWOLcwocIXd1KbPB9TFHnrHm?=
 =?iso-8859-1?Q?AR3eJxZVkfrdn4fKnZYfEwEeHe3CztXkq5dvkbl7G5HZRe1y7sEhmoG/p7?=
 =?iso-8859-1?Q?5me7kmpy0973V4XSkoLEcCbcfCAevphuRHREwjY2UDVI1VwEV4LRUZZ0c6?=
 =?iso-8859-1?Q?iSGT//7xrfOKQycX8kg2ez1EWR2Pta5nzmpiZ4Gr/SGW99WD7SaM70R8fm?=
 =?iso-8859-1?Q?fbwgxRIeUMSo8Vp0Ojzf6KOWf3DMfe4dGbVQ5ozKi6ReyLBU3RS8iVQBK1?=
 =?iso-8859-1?Q?IiNdhrvPCFtmpLgbK/uUGhM+puO9vjEppVHcP+PqpHZXOHHEthl8XgMKaU?=
 =?iso-8859-1?Q?CZb1VDgQJnMuw7eF7Vy/Vk/ctb1akt2mcwzMthCgCX40oFaa+NSHEtnrZd?=
 =?iso-8859-1?Q?FKaOkiOa8lOUyd/Cd42TLwHntQRzJdoKNX5IXV5TVmv4EXMzX91jD23C/0?=
 =?iso-8859-1?Q?HNcUTURV2aDp9wLAK2sBmp+GNxLxoFMlQ/4S7dCn9sM+9wwSce46tCEMdu?=
 =?iso-8859-1?Q?3U02mQNZMHH+w7yhvE10uPh51nQ/xS4fwXfmU2lWP3EojhpvTibkGswDKF?=
 =?iso-8859-1?Q?OsJTrQRHbhNB/H8oDWOJS3poOd7FwGMPQb8s4gZRPm3X/0z9tBaHBAwexr?=
 =?iso-8859-1?Q?NSstaxa9Ino07z5dOnvziHPVYnHTVZMhx/BX2GZa+SqLuL5M5EncG69+5+?=
 =?iso-8859-1?Q?f1Kh2KI8mvPZLeR7kJdVLvN7cwkfjGbrM192JUDfI5yxzsng2ug25HJC3X?=
 =?iso-8859-1?Q?rvZ5NWotJtgdIKUxjGr+Pwd6eEXA1WH1zACv9+XMeZXULgzuL2oR+3BOrb?=
 =?iso-8859-1?Q?FWoQ3crrIlFH7wtg3dBKBEaa7g/M60XKqFH3jXIy9+v6OtLGkcS9iYXRcb?=
 =?iso-8859-1?Q?oZPGghzjhQeF7CrIonyzWkMFeSonjVqLN2OAHnXIs8lxfiuzal9eV9QnbT?=
 =?iso-8859-1?Q?SXf2K/7RuR3IqaS0s7kbgjsLi+n33MYhwKMnS9iS5Ti8sE5ULJplMwHAc6?=
 =?iso-8859-1?Q?Y1F6zJNvQ6ohU2pBY4vd0Yng5f5VnMW3cVqknkVOZd+ztiI0Uq0xl1ietB?=
 =?iso-8859-1?Q?Ptg5/4eq4gztG3HTkY/b6dUTdDaihh6XQydQTUWC1KOJoRrc9nisI1wQmu?=
 =?iso-8859-1?Q?4zgUxoFWfKeNKW8c7PtXtvxSOkEw7rfMHUJBvAnz5WpIAU9J9ZzCes8ODh?=
 =?iso-8859-1?Q?XcsDsZpRl+AKM3ldeo6aYcZO9OIJyfIAum2ZR3nzJGfdpi6LFrRniy/qUG?=
 =?iso-8859-1?Q?oBmrvNK0XBaz5a6T+HEmq16IiAWhQpQu0uetSBXefvaT2kGLM64Il+ZhHR?=
 =?iso-8859-1?Q?vJgKzfyTnde1SCmKFRycLNrr2a/aSPw65e5Zy562wD4pkuld4a9781kYOx?=
 =?iso-8859-1?Q?bDNqh5t1Nu0OlGruLmayGkvKelGg2gIjQDRsFRVC8Q8dVlCwi8OmQgNIH3?=
 =?iso-8859-1?Q?kQWz1mUMsv5CJ8dEADGbDWEKhmzlsVK0EUOUXbuYoUYuvR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NRvvYNY8DeIjEb7yC5bquSDLVL1OtnKAozFVejC38QUteyoD2CWZ5AdVpWtZuhMK9618hbeH3IglR8spNq2fUEPkINhZOS+BKmcXcibTmZsejslLU7uLXCcVc+UbxhnO9XCNo+ZLBulcd9dqx/iurYy8U8Qq/BWK89K0D/E7ribqekIKy3UbAP/Pmlju0yPD/E9++ep9KgqNiGGH590vFZFrqr0ZqvEl3Fj4bGoZIxw2WMAUm1zWAkH8xxUMo5FPqgy5vishxNeIlYPKXA2CxrF57Sxw0chFhncfmbDVceAzAL1O20xURT3L52h8YtRR/zRj7+tcypoKlBRTSv0omQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eccf7d5-0f94-4311-a2f6-08df12bc52f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:16.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNk3CmmBU6op0cJTxeQv96cTPz+NOIFx2bFv7KMPf/f33cZkNpg1do8UM/XO39Px/HbIV+LlzVxWOslqbHnWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430428-S17dCQ7GS2Fu
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430428;S17dCQ7GS2Fu;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic reference selection and on-chip TDC phase-offset measurement,=0A=
and is used for synchronization in telecom, networking, and data-center=0A=
timing.=0A=
=0A=
The series contains the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry.=0A=
=0A=
v1 https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com/=
=0A=
v2 https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com/=
=0A=
v3 https://lore.kernel.org/netdev/20260731180951.65725-1-arouhi@sitime.com/=
=0A=
v4 https://lore.kernel.org/netdev/20260806232439.27551-1-arouhi@sitime.com/=
=0A=
v5 https://lore.kernel.org/netdev/20260810230439.22866-1-arouhi@sitime.com/=
=0A=
v6 https://lore.kernel.org/netdev/20260812175337.18155-1-arouhi@sitime.com/=
=0A=
v7 https://lore.kernel.org/netdev/20260815221919.64226-1-arouhi@sitime.com/=
=0A=
v8 https://lore.kernel.org/netdev/20260902214030.20955-1-arouhi@sitime.com/=
=0A=
=0A=
The driver was a single 5.6k-line patch through v7. Vadim and Ivan asked=0A=
for it to be split into logical parts, with the first zl3073x series as=0A=
the model, so v8 introduced it feature by feature and v9 keeps that=0A=
shape:=0A=
=0A=
  1-2   bindings: vendor prefix, then the device schema=0A=
  3     basic support: paged regmap, variant detection, probe=0A=
  4     DPLL types and pin properties from system firmware=0A=
  5     register the DPLL devices and pins, and keep their state=0A=
  6     input pin state on a DPLL, with the pin-state contract=0A=
  7     input pin priority=0A=
  8     pin frequency, both directions=0A=
  9     output pin state (mute)=0A=
  10    output phase adjust=0A=
  11    esync on outputs=0A=
  12    phase offset through the TDC=0A=
  13    fractional frequency offset of the selected reference=0A=
  14    the inter-PLL sync net as a pair of pins=0A=
  15    optional device-tree overrides for two board facts=0A=
=0A=
The two bindings patches come first, so the driver never matches on a=0A=
compatible string before the schema that describes it is in the tree.=0A=
=0A=
Each of the thirteen driver patches builds and links on its own: no=0A=
patch calls something a later patch introduces, so a bisect cannot land=0A=
on a tree that fails to compile. For this posting that was re-checked=0A=
patch by patch with W=3D1 and with sparse. checkpatch --strict is clean=0A=
except for the "does MAINTAINERS need updating?" hint on patches 4 and=0A=
5, which add files under drivers/dpll/sit9531x/ -- patch 3 already=0A=
covers that directory with an F: entry.=0A=
=0A=
On process, and on Paolo's note against v8: the v8 AI review raised 86=0A=
comments across the series, and each one now has an individual reply in=0A=
its own sub-thread -- fixed, or answered with the reason it is not a=0A=
bug. The second half of that guidance is the more useful half, and we=0A=
had not been following it. We now run the same review locally before=0A=
posting rather than after; v9 has been through it twice over the whole=0A=
series, and what it found is folded into the patches below instead of=0A=
being left for the bots to raise again. We intend to keep doing this for=0A=
any further revision.=0A=
=0A=
Changes in v9:=0A=
=0A=
  - Put the cost and the constraints in the commit messages, next to the=0A=
    code they apply to, rather than only in replies on the list. A=0A=
    priority-table rewrite forces holdover and takes ten to twenty=0A=
    milliseconds, because the device cannot change one slot in=0A=
    isolation. Programming an output divider costs about a hundred=0A=
    milliseconds under the DPLL core's global lock, most of it the=0A=
    settling time the part requires after the loop-lock command. The=0A=
    phase flush that follows a divider write realigns every output on=0A=
    that PLL, not only the one that changed. The clock_id carries the=0A=
    I2C adapter number in eight bits, so the collision it admits is=0A=
    stated rather than designed around. The debug window returns the=0A=
    previous latch, which is why every read of it triggers three times.=0A=
    The running feedback divider is two taps sampled separately and can=0A=
    tear; on a locked loop it moves below what the measurement resolves,=0A=
    and the part offers no way to latch both at once.=0A=
=0A=
  - Never leave the device armed when a sequence fails partway. The=0A=
    programming state, the debug window, the on-demand phase flush and=0A=
    forced holdover are each entered by one write and left by another,=0A=
    and every fallible step in between now exits through the common=0A=
    path that issues the second write. The first error is the one=0A=
    returned, so a transient I2C failure can no longer leave the chip=0A=
    with its loops open, its debug block unlocked, its flush armed or a=0A=
    PLL parked in holdover.=0A=
=0A=
  - Answer from the device rather than from a cache where the cache can=0A=
    be wrong. Whether an output is muted now reads both the force bit=0A=
    and the state bit, and picks the register bank from the pad's own=0A=
    CMOS enables, so a single-ended pad is no longer interrogated=0A=
    through the differential bank or the reverse. State that a write may=0A=
    have invalidated is marked stale and re-read on the next get instead=0A=
    of being reported from the last poll. Priority-table membership is=0A=
    asked of the table.=0A=
=0A=
  - Make .mode_set() idempotent. It reads the outer-loop disable bit=0A=
    before writing it and does nothing when the PLL is already in=0A=
    automatic mode. Without that, setting the only mode the driver=0A=
    advertises a second time, followed by one failed latch, would=0A=
    restore a disable the PLL never had and drop a running loop into=0A=
    free-run.=0A=
=0A=
  - Park the poll worker and the INTRB interrupt across system suspend=0A=
    and take a fresh sample on resume. The tick talks to the device over=0A=
    I2C, and one landing mid-suspend could tear a paged sequence between=0A=
    the page-selector write and the register access.=0A=
=0A=
  - Check a PLL's VCO frequency against the device's two bands before=0A=
    using it, so a value that fell in the gap between them cannot reach=0A=
    the divider arithmetic.=0A=
=0A=
  - Binding: accept clock-frequency as an alternative to the clocks=0A=
    phandle, for platforms whose firmware does not expose the crystal=0A=
    through the clock framework; exactly one of the two is now required.=0A=
    The sitime,pll-fvco description was also rewritten to say why the=0A=
    property carries no unit suffix: the values exceed 32 bits and so=0A=
    need an explicit uint64-array type, and the dtschema meta-schema=0A=
    does not permit a type $ref on a "-hz" property. That was a review=0A=
    suggestion we tried and dt_binding_check rejected, so the reason is=0A=
    recorded in the binding itself. The schema changed, so Krzysztof's=0A=
    Reviewed-by is not carried across it. Patch 1 is unchanged since v8=0A=
    and keeps Conor's Acked-by.=0A=
=0A=
One finding from the v8 review is declined rather than fixed, and the=0A=
reply on patch 8 gives the argument: a frequency request of 0 Hz is=0A=
refused with -EINVAL instead of being treated as a request to stop the=0A=
output. Nothing in the ABI says zero means off, and this device already=0A=
has a mute control that says so explicitly.=0A=
=0A=
The use-after-free report on the pin properties remains a false=0A=
positive: dpll_pin_alloc() calls dpll_pin_prop_dup(), which copies=0A=
freq_supported with kmemdup() and the labels with kstrdup(), so the core=0A=
owns its copies and the driver has to free its own.=0A=
=0A=
The review also turned up one bug that is not ours: dpll_pin_freq_set()=0A=
reads the requested frequency as a u64 and validates it through a helper=0A=
that takes a u32, so a rate of U32_MAX + 1 + N is accepted as N against=0A=
the supported ranges, which are themselves u64. That affects every=0A=
driver behind the interface, not just this one. It is a separate patch=0A=
against the core and will be posted on its own rather than buried in a=0A=
driver series; this driver range-checks its own input in the meantime.=0A=
=0A=
Ali Rouhi (2):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT95316 clock generator=0A=
=0A=
Oleg Zadorozhnyi (13):=0A=
  dpll: add basic SiTime SiT9531x support=0A=
  dpll: sit9531x: read DPLL types and pin properties from system=0A=
    firmware=0A=
  dpll: sit9531x: register DPLL devices and pins=0A=
  dpll: sit9531x: implement input pin state on a DPLL=0A=
  dpll: sit9531x: add support to get and set priority on input pins=0A=
  dpll: sit9531x: add support to get and set frequency on pins=0A=
  dpll: sit9531x: implement output pin state on a DPLL=0A=
  dpll: sit9531x: add support to adjust output phase=0A=
  dpll: sit9531x: add support to get and set esync on pins=0A=
  dpll: sit9531x: add support to get phase offset on the connected input=0A=
    pin=0A=
  dpll: sit9531x: add support to get fractional frequency offset=0A=
  dpll: sit9531x: model the inter-PLL sync net as a pair of pins=0A=
  dpll: sit9531x: allow the device tree to override two board facts=0A=
=0A=
 .../bindings/dpll/sitime,sit95316.yaml        |  181 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    2 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 4130 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  407 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1486 ++++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   70 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  437 ++=0A=
 drivers/dpll/sit9531x/prop.h                  |   39 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  394 ++=0A=
 14 files changed, 7177 insertions(+)=0A=
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
base-commit: d0ec95a8a4e79f2fd6063fc8932415db8c227689=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
