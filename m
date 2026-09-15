Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645B254B03;
	Tue, 15 Sep 2026 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430440; cv=fail; b=Hg0uKxCQGjnuIsDQ2RlH1ZeXzpoCBmO+FvlyzPYONDLfv65JqnT1P+fwqn/PSi69p7422z4cSrHlYqcS0vwRrKvRibbI6pujs16jQCQK1h8WIrx3T0MPkub7qGpepw2JbWdA739wqjJ5f3Z1bBWIn7WeR2tqH/+a9JqIBXXFkQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430440; c=relaxed/simple;
	bh=XnomvEuNqygROXONBBLYmBh60xo5maMldl5Wr6UDexE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YNpuB6w3C+Ey6zR9+oN8u+cyOeod3BKeBGWzdDGiINdtxASyOAvgMcIQh5OO5mHIjyW2ufT3pjXM8NIO00BWPkuQLtIs5N0N0yQI26hIOy8mUwmlieKQSGLpJdJjmao1fi4Byoop75LdrWH0BypXCCxLbRRPrFXMtEwEnM2h+4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=EL0tAoeL; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=P4rsLWj2; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="EL0tAoeL";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="P4rsLWj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=nWRoTR+P3r5Qdbl9y7LWns6vlzIanGiDEx2Rtp+pq/k=;
 b=EL0tAoeL7xoMd1GfX0EFdiUTzh1PKYGiwo88GVrC+IoQFu2w4cOMI9cgTl1QFe2BlRquGlqLjemqGp9oG2cYrYfSPi5Vnhi6zv696ESSj09o6GuA0f77nfUEmSXOgIZpsChukT3ov5mgi4M+nAaU/U0svE4g62JtyTups3/jK55FqPeMhFoceKItG+0Vg99w0QPJOyeFoq38nvlaTjOpZufGAybJzBH0e7/9JEeTWnQ5dxZh+QMEuD+o54X5BdfM4RypCc5T5P9s6wnehRRBO4LC6ZFRGY9o9ZXSmEdlebbShfdjgTlw0ptyGBWrnbbAkLPX9yRwc6ChJtJNifLtqw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4E5B010006F;
	Tue, 15 Sep 2026 00:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7PLCdtO55nKtdbBX0OdOkmf2vDElh5XttPI3kHlKqY35dTVolir+/DiPHgTbrj0ELDOhLOsIj5XjBbjKqPG3cshoOg9hotS5RCZOWy9j3QXXOmHtl2ERXA86IYHPCXb/hXZ8yW8lA++SJYE4DkLKnuD9n0Kuu9xlv6+6SduCAjDKtozPzAEXR2NyME1DgqNUoxqaSY8EEGnc+Ke8rZqzcZiTQIfyu2fBf5KM6+5BqxxHKBeFcpa2gghC56qOgHgLpU9+xCUFLLlDSdsbBOCZTwCveTZ7b//byDUt4wJLIiGxSeSmqMDHBl5rSzYCopG05Gz5hk4RsK19q0zj5xkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWRoTR+P3r5Qdbl9y7LWns6vlzIanGiDEx2Rtp+pq/k=;
 b=VrJqg5i7VrCsX1r4Bn8ku2mpMRcdWV0KBYK26aYi7z5FiWMqGvDs9dWfwj/JFm0rK1+tPQ6Ublznn7/qhD63MrF+JaAAwhUSLi/5oB4s2aXBCvstaciquF1WhFCyEMdkrtLaZZEjxH3K3sKiH/xdLlq1hMBn0RDxqI88pvhLVtEOFuQSGSpYqBXAZeR+JF1H2dKmy2o0bxDvzy+2C+gydi1sUENaQDUyQpE2FFK488nm3htUskGvJQfd6HUbnF74UmI73NZPd72YZxCzAQLpDvzdYsnksAZTqHVUFrJDNru7c6Hssu4opk8bjMUgahC1H5zs2VE1zcb2q+nt+4NUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWRoTR+P3r5Qdbl9y7LWns6vlzIanGiDEx2Rtp+pq/k=;
 b=P4rsLWj2izeButRxUznIrOXkPD21v6MYpPVFG7+erJIhajrk5pkLkyPYy1ScqSOb11cddsMEE32/IWc32YOw7TEPOMqb3A/iTPs69BoWNifJNwGw8ajfb9QfrO8izXl9ez8wR/B/Z8K6raAABDJ+bQCLyV6QxneNWSlBZM0Bw2sw7QLamtlJcRQDUoYyR3mB641F+0EjoWxyt+gfSgjxL7U2SvXqZmtcJwXsu+KUwm3ErzXu5v4PqTQN9ERtLsDCCd4xvOH/HtpKO0AMS8SJ78aAsO01fwqceYczD77zu3SFeelJxtdDOY0+XT5A+pUmvhRB/+sViy3g47JM2BbBsA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:21 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:21 +0000
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
Subject: [PATCH net-next v9 05/15] dpll: sit9531x: register DPLL devices and
 pins
Thread-Topic: [PATCH net-next v9 05/15] dpll: sit9531x: register DPLL devices
 and pins
Thread-Index: AQHdRKUxgI6E38r5SUmass+WRTvQSA==
Date: Tue, 15 Sep 2026 00:00:18 +0000
Message-ID: <20260915000015.80480-6-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: 62d8e511-b0c9-4f3d-0c15-08df12bc55c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 5hmXiPD/nkbcjYZ2RMcJHLXd466dahdf6Fz/fJMDvr1ULSQXnnSfT/Ucgw2A0WjyL2T5DGavWSL0akrZtQ9bNrV0MR0A+rQbDA74gqlIQKSHSHtVceGjtuOaX06whSUUmerfMosAEvKb36IHjugzmSpPb6KckF5Xg6pIxLVaanCNKgBjPYiraXEtkNiqhm+miZ99NpHVAVvcMoXeOrlYq+GMABXf0KRt0vb9FSdW0CPkXLQ4SOHOIzbtUqV4G8O266x8JUDTlUI3jgEOYdSGKB8KTrJF0Q05non2ppQHHdr68rossyIhpE6WlG9DJPEyNv4ZSeHV5As8Qn1Zxxjz7BRdndRQEP8Fet3Lay0Xdm8j25Cq0FRNkETIh5VlIU2+asW5zEEEe2xYGmLPNrc3NOeEia/0JudbigXAO2OMcH1WAtuU6eOx3kJGfAkaFIwclT4cG465ZK3klynzqBkTrOUBtOsjjMFB58aeLYn3bgr+GO58geG+XHiwD3nHwwDXNas57EtRS0KiSZQ9OS1BzkdreTzFj0qaHMwY8QOxLfqc5RHVTH11MMhlfzdiM9b1bqy1M7CS1dNxA0jgzNuuY/2cUuX7+58+ok1LTs3QuCB46EA2ir6qPPG4fssGsckPbo7tVFQKEwfVDUA8qSmTsvJmMu1m0Dd4KE+fnkDEifPL4UxSk01p5wNRyekNsr4qW3Gd9ytDH4woyFN227CnAuTIr++A86UzZhlPesb1IPE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ptVRsZJkJr3WP0d4RETbDTvV1Wu+Ayy6d+Sa1YBe7+0b3Lqx65TPjfjqll?=
 =?iso-8859-1?Q?mXS6SjQQCV25w7HnWx3OuK9gJKhgoh5/9rPnJEXXL+FC5VkdYJNvf2kWiS?=
 =?iso-8859-1?Q?YltriF+5PTZ5DTuTJ55wP1MPMWA0YYbYVYrC70TqgaB8EtD6DeHqdYqk3e?=
 =?iso-8859-1?Q?0NYS1DR9aWKAhHhtH9UMbyUSUFvbjiEQiaC81qgkg0ah9llnSOMtjYo/HY?=
 =?iso-8859-1?Q?Fk6LFriK1lEf9LfR4VNNn0BxCppelPWnOafFvZvniIa+HEevpgYFXmgjt6?=
 =?iso-8859-1?Q?XVsfvrCxz8AbrMLm6WNvsyhQn8W87w9zV60sB0XHeetgUcwJHKxCuLUqGE?=
 =?iso-8859-1?Q?Tx6uoQbQjETgwI1bp26T3VDd2bN17AVOHN/utKrtOlqbeqKzffApSoUg19?=
 =?iso-8859-1?Q?0loHWUcvYRm+FgNBx8d3nGk1VdzB8gPrbkLGw21WsZfKGv/ZbPWqdEfgYX?=
 =?iso-8859-1?Q?FKznWhoh18TnN695e/C2VG+cyxbkVhosilSYcYRzpVsimaNkf2qdK+bSJ5?=
 =?iso-8859-1?Q?yJxSqbIW1wUzJ0mkdeT71VUEkyk09+HnBa0+upHzg/aoAYWQjY7LtIPG79?=
 =?iso-8859-1?Q?Gf4d+igsLT6TVxFUxYoA6SlbyziyyVNgTBjhsBEbsKcX8enPEFDHIRuQH+?=
 =?iso-8859-1?Q?fCKKEdtjroLMxQsgvrHArs6QOc6uYVbK+m0JNv/UG1vkh7wFDe5Sn25xhd?=
 =?iso-8859-1?Q?tXkgHy71FJ18lOuNGOY6V7phm1oehYYl2DXd/y6UqzHE4AFvgukBUb8Obc?=
 =?iso-8859-1?Q?bB/8X04zfljI3OP/igpeIabPKJb1GDov/kLJO+tx1C6z8UrWVrQZj+MxCl?=
 =?iso-8859-1?Q?KrYEBbNF0TRaVjP7y6H6A23hEGynQU5RzqLYX+AV5Rtrwhgz6rN0TRPEAi?=
 =?iso-8859-1?Q?CNQTGHR6f2fKOOKcQ00U7EWexyDV0/4wb//UNtUHrSlPb1igCI0hYQ3kuB?=
 =?iso-8859-1?Q?rZXDWAjNwkhA3aH2W23bYVf50c+I6zHZVyUG0a0qmi+imsbPf87DbMfvHl?=
 =?iso-8859-1?Q?rBBOFZgG27iJOv4OKszpu9sPxdLRNadAx3js+2j37Bo/9YFNiB+7nhqk+X?=
 =?iso-8859-1?Q?xreR2Jz2L//iumIzpNlPVPTYiuOfgeH5acYsS4oTXU5CHgxDI73ZkdkwnO?=
 =?iso-8859-1?Q?YfTs2WZ9C85Lx48GU6xtM+UEb6WFfs41yFc1DSUxc7k9G9wr63mDrqNAQM?=
 =?iso-8859-1?Q?6zqeuSRxU5bbbOnHeQD/EITq6r4p0JRgaWqlOBNVKq2Ljuku46BvKWCHpa?=
 =?iso-8859-1?Q?srGvSprY4It0MJOGRJJDlyfDODV31NP7lxV01kEQvkkh/UttZlKlGxrDVQ?=
 =?iso-8859-1?Q?6yaRy6kR2N607w8SNuOnCxbmma39sEGMFeBKE7ACJJO7Yt+BROXkhDUnHC?=
 =?iso-8859-1?Q?rm9lJfrxLq1B1rqsPlrUEFJhDHkps6K6ofOKFxfdWrUMAwGd7cqPtmv/Zt?=
 =?iso-8859-1?Q?+Q41a9GOYaJ21oOS2+Ka3b8V+2KMSE5WA+9hMUU+rckHY56Rd+8rL/BY5t?=
 =?iso-8859-1?Q?AlYrxYkPOI1Znvn7PsVyGw5BdNXURMwATAf2CO3rfkwHRHJeXp8XGYGGTr?=
 =?iso-8859-1?Q?K7BtFVQa8pwpySiLrZoOvQ2FGMDZjB5jyUMeL7F7NkP040gbLMo5SCU+Y6?=
 =?iso-8859-1?Q?PvHm5wcTcAgwwgugzk2MyrKFz32F5L+R5oq/sFnGfgZJNsnB+Gil/ewafv?=
 =?iso-8859-1?Q?6O21WykwMLkdLDQAkOSCyoBrDqlkiC3MD9LIPKE6fNn/FdcG02i2MVeNWP?=
 =?iso-8859-1?Q?TO1Na95Ifw+H0j7neKWEML3DD9VFMRAUA8x8Ts2MfwfT87?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	k4jzdC29jSgEPQEJft21fdMtFlruUlSNWkfGIlwue1buPUDYG7mwygCsgFTF/smn9fIDBtk5I3p+IOpa/a7zAZAtTDf7k83BzBJOkhlf//4JGTMmTS0jkyPqxWbyJYcQlAbXfartCzBfy2oOTDclYYukXHBl2n3f+lJMU22pVDgMFiVV3MyvhxG5XIZjmP3JwYqXvrZB+nW1Y1O4pOMSG36wgG8ShyL0Nv4qw64FMAEZpeHBSsJWywXJDeV0NXQFVBEIPO9HqRGcmZC4vrGJA3fEO9m8VI3kVlAEb4ifJW7JZvVNbIu7URANZaoCg9mYoLCVpGOe/VVHdHaqDpuEVA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d8e511-b0c9-4f3d-0c15-08df12bc55c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:18.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtFS9ylO94hToAyEAgPCZ+BXa5u+JE4BMjZmMyP4OVXamC2mcHPQOfGjEwV6bFj7b86yoQAcXwLYcDFLK8PRuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430431-roE_fnmnL39y
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430431;roE_fnmnL39y;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Register each of the four on-chip PLLs as a DPLL device and the clocks=0A=
around them as pins: the inputs, the crystal, and the outputs the loaded=0A=
configuration routes to a PLL.  An output routed to no PLL gets no pin,=0A=
since there would be nothing for the core to report about it.=0A=
=0A=
The callbacks a device needs from the start come with it -- lock status=0A=
and the operating mode -- along with the direction of each pin.  The rest=
=0A=
of the pin operations follow in later patches.=0A=
=0A=
Both need somewhere to read from.  The chip reports its state across=0A=
several pages, and a netlink call must not turn into a burst of I2C=0A=
transactions, so a kthread worker polls the interesting registers twice a=
=0A=
second into a per-input, per-output and per-PLL cache, and the callbacks=0A=
answer from it.  The same tick compares the new state against the old and=
=0A=
notifies the core only on a change.  Where a board wires INTRB, the=0A=
interrupt schedules that tick immediately rather than replacing it: the=0A=
poll stays as the fallback, since this device gives no way to be sure an=0A=
edge was not missed.=0A=
=0A=
The clock_id that keys a device in the DPLL core is built from the chip's=
=0A=
variant and its position on the bus, with the adapter number carried in=0A=
eight bits.  Two identical parts at the same address on adapters whose=0A=
numbers differ by a multiple of 256 would therefore collide.  That needs a=
=0A=
machine with more than 256 I2C adapters and the same part twice at the=0A=
same address on two of them; the alternative is a wider identifier that no=
=0A=
other driver expects, so the constraint is stated rather than designed=0A=
around.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/Makefile |    2 +-=0A=
 drivers/dpll/sit9531x/core.c   | 1641 ++++++++++++++++++++++++++++++--=0A=
 drivers/dpll/sit9531x/core.h   |  268 +++++-=0A=
 drivers/dpll/sit9531x/dpll.c   |  444 +++++++++=0A=
 drivers/dpll/sit9531x/dpll.h   |   69 ++=0A=
 drivers/dpll/sit9531x/regs.h   |  232 ++++-=0A=
 6 files changed, 2554 insertions(+), 102 deletions(-)=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
index 819af61123f5..b97d2656a460 100644=0A=
--- a/drivers/dpll/sit9531x/Makefile=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -1,4 +1,4 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-only=0A=
 =0A=
 obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
-sit9531x-y :=3D core.o prop.o=0A=
+sit9531x-y :=3D core.o dpll.o prop.o=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index b0920f76362a..6dfb1b31d491 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -6,9 +6,11 @@=0A=
  * Author: Ali Rouhi <arouhi@sitime.com>=0A=
  * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
  *=0A=
- * I2C probe, paged regmap configuration and register access helpers.=0A=
+ * Core I2C probe, regmap configuration, hardware state management,=0A=
+ * and periodic work thread.=0A=
  */=0A=
 =0A=
+#include <linux/bitfield.h>=0A=
 #include <linux/bits.h>=0A=
 #include <linux/clk.h>=0A=
 #include <linux/delay.h>=0A=
@@ -16,14 +18,26 @@=0A=
 #include <linux/device.h>=0A=
 #include <linux/gpio/consumer.h>=0A=
 #include <linux/i2c.h>=0A=
+#include <linux/interrupt.h>=0A=
 #include <linux/kernel.h>=0A=
+#include <linux/kthread.h>=0A=
 #include <linux/module.h>=0A=
+#include <linux/pm.h>=0A=
 #include <linux/property.h>=0A=
 #include <linux/regmap.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
 =0A=
 #include "core.h"=0A=
+#include "dpll.h"=0A=
+#include "prop.h"=0A=
 #include "regs.h"=0A=
 =0A=
+/* Number of input + output pin positions for pin index allocation */=0A=
+#define SIT9531X_NUM_INPUT_PINS		(SIT9531X_MAX_INPUTS + 2) /* +xtal +INTSY=
NC */=0A=
+#define SIT9531X_NUM_OUTPUT_PINS	(SIT9531X_MAX_OUTPUTS + 1) /* +INTSYNC sr=
c */=0A=
+#define SIT9531X_NUM_PINS_TOTAL		(SIT9531X_NUM_INPUT_PINS + SIT9531X_NUM_O=
UTPUT_PINS)=0A=
+=0A=
 #define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \=0A=
 	{ .id =3D (_id), .num_inputs =3D (_nin), .num_outputs =3D (_nout), \=0A=
 	  .name =3D (_name), .clkout_map =3D (_map) }=0A=
@@ -145,122 +159,1597 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *si=
tdev, u8 pll_idx,=0A=
 	return regmap_update_bits(sitdev->regmap, reg, mask, val);=0A=
 }=0A=
 =0A=
-static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+/*=0A=
+ * sit9531x_input_get_regs - get force mask and state register addresses=
=0A=
+ * @index:	logical input index=0A=
+ * @force_reg:	output force mask register address=0A=
+ * @state_reg:	output state register address=0A=
+ *=0A=
+ * Selects the correct Page 0x02 register pair based on the pair's=0A=
+ * signal mode and the lane (P/N) the index refers to.=0A=
+ */=0A=
+static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,=0A=
+				    u8 index,=0A=
+				    unsigned int *force_reg,=0A=
+				    unsigned int *state_reg)=0A=
 {=0A=
-	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+	if (sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE) {=0A=
+		*force_reg =3D SIT9531X_REG_IN_DE_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_DE_STATE;=0A=
+	} else if (sit9531x_input_is_n(index)) {=0A=
+		*force_reg =3D SIT9531X_REG_IN_SEN_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_SEN_STATE;=0A=
+	} else {=0A=
+		*force_reg =3D SIT9531X_REG_IN_SEP_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_SEP_STATE;=0A=
+	}=0A=
 }=0A=
 =0A=
-static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
-{=0A=
-	unsigned int i;=0A=
+/*=0A=
+ * Output enable / disable (Hi-Z control)=0A=
+ *=0A=
+ * SiT9531x outputs can be configured as differential (DIFF) or=0A=
+ * single-ended (SE) depending on the factory blob.  Each output slot=0A=
+ * has TWO Hi-Z force/state register pairs on Page 0x03 -- one for the=0A=
+ * DIFF path, one for the SE path.=0A=
+ *=0A=
+ * We write to BOTH pairs so the function mutes the output regardless=0A=
+ * of whether it's been configured DIFF or SE on this board.=0A=
+ *=0A=
+ *   slot 0-7 :=0A=
+ *     DIFF mask=3D0xF2 state=3D0xF3   SE mask=3D0xF8 state=3D0xF9=0A=
+ *   slot 8-11:=0A=
+ *     DIFF mask=3D0xF4 state=3D0xF5   SE mask=3D0xFA state=3D0xFB=0A=
+ *=0A=
+ * MASK bit =3D 1  -> driver takes control of that output's Hi-Z state=0A=
+ * STATE bit =3D 0 -> output is forced to Hi-Z (muted)=0A=
+ * STATE bit =3D 1 -> output is driven (active)=0A=
+ *=0A=
+ * The output "index" in the driver is logical; the physical slot comes=0A=
+ * from info->clkout_map[].=0A=
+ */=0A=
 =0A=
-	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
-		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
-			return &sit9531x_chip_ids[i];=0A=
+struct sit9531x_hiz_regs {=0A=
+	unsigned int diff_mask;=0A=
+	unsigned int diff_state;=0A=
+	unsigned int se_mask;=0A=
+	unsigned int se_state;=0A=
+	u8 bit;=0A=
+};=0A=
+=0A=
+static void sit9531x_output_get_hiz_regs(u8 slot,=0A=
+					 struct sit9531x_hiz_regs *r)=0A=
+{=0A=
+	if (slot <=3D 7) {=0A=
+		r->diff_mask  =3D SIT9531X_REG_HIZ_DIFF_07_MASK;=0A=
+		r->diff_state =3D SIT9531X_REG_HIZ_DIFF_07_STATE;=0A=
+		r->se_mask    =3D SIT9531X_REG_HIZ_SE_07_MASK;=0A=
+		r->se_state   =3D SIT9531X_REG_HIZ_SE_07_STATE;=0A=
+		r->bit =3D slot;=0A=
+	} else {=0A=
+		r->diff_mask  =3D SIT9531X_REG_HIZ_DIFF_811_MASK;=0A=
+		r->diff_state =3D SIT9531X_REG_HIZ_DIFF_811_STATE;=0A=
+		r->se_mask    =3D SIT9531X_REG_HIZ_SE_811_MASK;=0A=
+		r->se_state   =3D SIT9531X_REG_HIZ_SE_811_STATE;=0A=
+		r->bit =3D slot - 8;=0A=
 	}=0A=
+}=0A=
 =0A=
-	return NULL;=0A=
+/*=0A=
+ * sit9531x_output_mode_fetch - read how an output is wired=0A=
+ *=0A=
+ * The Hi-Z force is a separate register pair for the differential and the=
=0A=
+ * single-ended path, and only the pair belonging to the way the output is=
=0A=
+ * actually wired says anything about whether it is quiet.  The other pair=
=0A=
+ * holds whatever the loaded configuration left in it.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_output_mode_fetch(struct sit9531x_dev *sitdev, u8 out_=
idx)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, reg, val;=0A=
+	int rc;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+		SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	reg =3D SIT9531X_OUT_MISC0_BASE +=0A=
+	      SIT9531X_OUT_MISC0_STRIDE * (slot % 6);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, reg), &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].cmos =3D !!(val & (SIT9531X_OUT_CMOS_ENP |=0A=
+					      SIT9531X_OUT_CMOS_ENN));=0A=
+=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+/*=0A=
+ * Report whether a slot is currently forced into Hi-Z, i.e. the driver=0A=
+ * (or the blob) took control of the Hi-Z state (MASK bit set) and drives=
=0A=
+ * it low (STATE bit clear).  Either register pair muting the slot counts,=
=0A=
+ * mirroring what sit9531x_output_disable() programs.=0A=
+ */=0A=
+static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,=0A=
+				      u8 out_idx, bool *muted)=0A=
 {=0A=
-	struct clk *xtal_clk;=0A=
-	u8 variant_id;=0A=
+	struct sit9531x_hiz_regs r;=0A=
+	unsigned int mask_reg, state_reg;=0A=
+	u8 mask, state;=0A=
 	int rc;=0A=
 =0A=
+	sit9531x_output_get_hiz_regs(sitdev->info->clkout_map[out_idx], &r);=0A=
+=0A=
 	/*=0A=
-	 * Fvco =3D Fref * (DIVN + frac/2^32) with Fref derived from the XO=0A=
-	 * feeding XIN/XO_CLK, so the rate is needed before anything can be=0A=
-	 * computed from a divider.  The rate normally comes from a "clocks"=0A=
-	 * phandle (clock-names =3D "xtal").  On platforms where the firmware=0A=
-	 * does not expose the XO through the clock framework, fall back to=0A=
-	 * a "clock-frequency" device property.=0A=
+	 * Read the pair that belongs to the way this output is wired.=0A=
+	 * Testing both and taking either as proof of a mute answers=0A=
+	 * from a register nothing drives, and disagrees with itself=0A=
+	 * when a mute lands on one pair and fails on the other.=0A=
 	 */=0A=
-	xtal_clk =3D devm_clk_get_optional_enabled(sitdev->dev, "xtal");=0A=
-	if (IS_ERR(xtal_clk))=0A=
-		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
-				     "Failed to get xtal clock\n");=0A=
-	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
-	if (!sitdev->xtal_freq) {=0A=
-		u32 freq;=0A=
+	if (sitdev->out[out_idx].cmos) {=0A=
+		mask_reg =3D r.se_mask;=0A=
+		state_reg =3D r.se_state;=0A=
+	} else {=0A=
+		mask_reg =3D r.diff_mask;=0A=
+		state_reg =3D r.diff_state;=0A=
+	}=0A=
 =0A=
-		if (!device_property_read_u32(sitdev->dev, "clock-frequency",=0A=
-					      &freq))=0A=
-			sitdev->xtal_freq =3D freq;=0A=
+	rc =3D sit9531x_read_u8(sitdev, mask_reg, &mask);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_read_u8(sitdev, state_reg, &state);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	*muted =3D (mask & BIT(r.bit)) && !(state & BIT(r.bit));=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Input priority selection=0A=
+ *=0A=
+ * The SiT9531x has an 11-slot priority table per PLL on Page 1.  Each=0A=
+ * register holds two slots nibble-packed: the earlier (even, 2n) slot=0A=
+ * in [7:4] and the later (odd, 2n+1) slot in [3:0].=0A=
+ *=0A=
+ * The procedure:=0A=
+ *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)=0A=
+ *   2. Write priority slots on Page 1=0A=
+ *   3. Small change update (Page 0 reg 0x0F bit 1)=0A=
+ *   4. Release holdover=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+=0A=
+/* Page-1 register holding priority slot @slot of @pll_idx. */=0A=
+static u16 sit9531x_prio_reg(u8 pll_idx, u8 slot)=0A=
+{=0A=
+	return SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
+			    SIT9531X_PRIO_BASE_REG +=0A=
+			    SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
+			    slot / SIT9531X_PRIO_SLOTS_PER_REG);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Extract priority slot @slot from its register value.  The register=0A=
+ * holding slots 2n and 2n+1 keeps the earlier slot in the high nibble=0A=
+ * (CLK_SPARE<2n>SEL) and the later one in the low nibble.=0A=
+ */=0A=
+static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return val & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+=0A=
+	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
+ * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
+ * from exactly the values the table holds -- here after a write, and once=
=0A=
+ * per poll from the read-back in sit9531x_chan_state_fetch().=0A=
+ */=0A=
+static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
+				     const u8 *srcs)=0A=
+{=0A=
+	u16 mask =3D 0;=0A=
+	u8 slot;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		mask |=3D BIT(srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+=0A=
+	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prio_table_read - read a PLL's priority-table source codes=0A=
+ * @srcs:	output array of SIT9531X_PRIO_MAX_SLOTS source codes=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *srcs)=0A=
+{=0A=
+	u8 val, slot;=0A=
+	int rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      sit9531x_prio_reg(pll_idx, slot), &val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		srcs[slot] =3D sit9531x_prio_slot_get(val, slot);=0A=
 	}=0A=
-	if (!sitdev->xtal_freq)=0A=
-		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
-				     "no xtal rate: provide clocks=3D<&xo> + clock-names=3D\"xtal\", o=
r a clock-frequency property\n");=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* XO doubler register */=0A=
+#define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
+#define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
+=0A=
+/* VCO frequency bands (Hz) */=0A=
+#define SIT9531X_FVCO_LOWBAND_MIN		4915200000ULL=0A=
+#define SIT9531X_FVCO_LOWBAND_MAX		5898240000ULL=0A=
+#define SIT9531X_FVCO_HIGHBAND_MIN		6875000000ULL=0A=
+#define SIT9531X_FVCO_HIGHBAND_MAX		7812500000ULL=0A=
+=0A=
+/* The output divider is a 34-bit field */=0A=
+#define SIT9531X_DIVO_MAX			GENMASK_ULL(33, 0)=0A=
+=0A=
+/*=0A=
+ * Phase adjust (PRG_RST_DELAY register-based).=0A=
+ *=0A=
+ * The chip exposes a per-output 34-bit coarse delay measured in VCO=0A=
+ * clock periods plus a 3-bit fine delay in fixed 30 ps steps.  The=0A=
+ * five bytes PROG6..PROG2 hold the field across registers:=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserved via RMW)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  PRG_RST_DELAY[7:0]=0A=
+ *=0A=
+ * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each=0A=
+ * output's block at base =3D 0x15 + 16 * (out_idx % 6).=0A=
+ *=0A=
+ * The chip only supports unsigned positive delay.  A negative phase=0A=
+ * adjustment (advance) is wrapped to (T_out - |phase|) modulo one=0A=
+ * output period, which is identical for a periodic signal.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * sit9531x_clear_notifications - clear all notification registers=0A=
+ *=0A=
+ * Clears all write-1-to-clear notification registers:=0A=
+ *   - PLL outer LOL notification (Page 0, reg 0x07)=0A=
+ *   - PLL holdover freeze notification (Page 0, reg 0x0B)=0A=
+ *   - PLL inner LOL notification (Page 0, reg 0x93)=0A=
+ *   - Clock monitor XO/PLL notification (Page 0, reg 0x9E)=0A=
+ *   - Clock input notifications (Page 6, regs 0x03/0x07/0x93/0x97)=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	/* Page 0x00 W1C notification registers */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTER_LOL_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_HO_FREEZE_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_NOTIF, 0xFF);=
=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_CMON_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Page 0x06 clock input monitor notifications */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_01, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_23, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_01, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_23, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "All notification registers cleared\n");=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
+ * @index:	logical input index=0A=
+ *=0A=
+ * Reads LOS and OOF status for the given input lane from the Page 0x06=0A=
+ * clock monitor registers.  P and N lanes have separate register banks;=
=0A=
+ * each register carries two input pairs nibble-packed (even pair in=0A=
+ * bits [3:0], odd pair in [7:4]).=0A=
+ */=0A=
+static int sit9531x_ref_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
+{=0A=
+	unsigned int reg, force_reg, state_reg;=0A=
+	u8 pair, status, force, state;=0A=
+	struct sit9531x_ref *ref;=0A=
+	int rc;=0A=
 =0A=
 	/*=0A=
-	 * Held deasserted, never pulsed: the chip configuration comes from=0A=
-	 * efuse or an NVM blob applied before probe, and a reset would=0A=
-	 * discard it.  Must precede the first I2C access, as a board that=0A=
-	 * powers up asserted keeps the chip unreachable until released.=0A=
+	 * The XTAL/XO reference (index SIT9531X_MAX_INPUTS) is the on-chip=0A=
+	 * oscillator that feeds every PLL.  It cannot be routed or deselected,=
=0A=
+	 * so its pin is modeled as permanently connected (see=0A=
+	 * sit9531x_dpll_xo_pin_ops) and its LOS/OOF flags are never consulted.=
=0A=
+	 * Only the routable per-lane inputs (0..num_inputs-1) are polled here.=
=0A=
 	 */=0A=
-	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
-						     GPIOD_OUT_LOW);=0A=
-	if (IS_ERR(sitdev->reset_gpio))=0A=
-		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
-				     "Failed to request reset gpio\n");=0A=
-	if (sitdev->reset_gpio)=0A=
-		fsleep(10000);	/* internal boot after release */=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
 =0A=
-	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+=0A=
+	if (sit9531x_input_is_n(index))=0A=
+		reg =3D pair < 2 ? SIT9531X_CLKMON_N_STATUS_01=0A=
+			       : SIT9531X_CLKMON_N_STATUS_23;=0A=
+	else=0A=
+		reg =3D pair < 2 ? SIT9531X_CLKMON_P_STATUS_01=0A=
+			       : SIT9531X_CLKMON_P_STATUS_23;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &status);=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
-	if (!sitdev->info)=0A=
-		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
-				     "Unknown variant ID: 0x%02x\n",=0A=
-				     variant_id);=0A=
+	if (pair & 1)=0A=
+		status >>=3D 4;=0A=
 =0A=
-	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	ref->los =3D !!(status & (BIT(SIT9531X_CLKMON_CLK_LOSS) |=0A=
+				BIT(SIT9531X_CLKMON_CLK_LOSS_FD)));=0A=
+	ref->oof =3D !!(status & (BIT(SIT9531X_CLKMON_FREQ_FINE) |=0A=
+				BIT(SIT9531X_CLKMON_FREQ_COARSE)));=0A=
+=0A=
+	/*=0A=
+	 * Whether the receiver is on.  This has to come from the chip: it=0A=
+	 * is the loaded configuration that decides, and without reading it=0A=
+	 * back every input would look disabled until something called=0A=
+	 * sit9531x_input_enable().  A lane counts as disabled only while=0A=
+	 * the force bit overrides it to the off state; with the force bit=0A=
+	 * clear it follows the configuration, which is the enabled case.=0A=
+	 */=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &force);=0A=
 	if (rc)=0A=
-		return dev_err_probe(sitdev->dev, rc,=0A=
-				     "Failed to initialize mutex\n");=0A=
+		return rc;=0A=
+	rc =3D sit9531x_read_u8(sitdev, state_reg, &state);=0A=
+	if (rc)=0A=
+		return rc;=0A=
 =0A=
-	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",=0A=
-		 sitdev->info->name, sitdev->info->num_inputs,=0A=
-		 sitdev->info->num_outputs);=0A=
+	ref->enabled =3D !((force & BIT(pair)) && !(state & BIT(pair)));=0A=
 =0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+/*=0A=
+ * sit9531x_input_mode_fetch - detect SE/DE configuration of an input pair=
=0A=
+ * @pair:	input pair number (0-3)=0A=
+ *=0A=
+ * Reads CLKINx_INPUT_MODE and stores the detected signal mode on both=0A=
+ * lanes of the pair.  A pair with neither SE lane enabled is running=0A=
+ * differential.=0A=
+ */=0A=
+static int sit9531x_input_mode_fetch(struct sit9531x_dev *sitdev, u8 pair)=
=0A=
 {=0A=
-	struct sit9531x_dev *sitdev;=0A=
-	struct regmap *regmap;=0A=
+	enum sit9531x_signal_mode sig_mode;=0A=
+	u8 mode;=0A=
+	int rc;=0A=
 =0A=
-	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
-	if (IS_ERR(regmap))=0A=
-		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
-				     "Failed to initialize regmap\n");=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_IN_MODE(pair), &mode);=0A=
+	if (rc)=0A=
+		return rc;=0A=
 =0A=
-	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
-	if (!sitdev)=0A=
-		return -ENOMEM;=0A=
+	if (mode & (SIT9531X_IN_MODE_SE_P_EN | SIT9531X_IN_MODE_SE_N_EN))=0A=
+		sig_mode =3D SIT9531X_MODE_SE;=0A=
+	else=0A=
+		sig_mode =3D SIT9531X_MODE_DE;=0A=
 =0A=
-	sitdev->dev =3D &client->dev;=0A=
-	sitdev->client =3D client;=0A=
-	sitdev->regmap =3D regmap;=0A=
-	i2c_set_clientdata(client, sitdev);=0A=
+	sitdev->ref[pair * 2].sig_mode =3D sig_mode;=0A=
+	sitdev->ref[pair * 2 + 1].sig_mode =3D sig_mode;=0A=
 =0A=
-	return sit9531x_dev_probe(sitdev);=0A=
+	dev_dbg(sitdev->dev, "CLKIN%u mode reg 0x%02x -> %s\n", pair, mode,=0A=
+		sig_mode =3D=3D SIT9531X_MODE_DE ? "differential" : "single-ended");=0A=
+=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-static const struct of_device_id sit9531x_of_match[] =3D {=0A=
-	{ .compatible =3D "sitime,sit95316" },=0A=
-	{ .compatible =3D "sitime,sit95317" },=0A=
-	{ }=0A=
-};=0A=
-MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+/*=0A=
+ * sit9531x_chan_state_fetch - read PLL channel status from hardware=0A=
+ *=0A=
+ * Reads lock status and mode from the PLL status register.=0A=
+ */=0A=
+/* Read the PLL active-state bit (PLL page reg 0x02 bit 0). */=0A=
+static int sit9531x_pll_is_active(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  bool *active)=0A=
+{=0A=
+	u8 v;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_ACTIVE, &v)=
;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	*active =3D !!(v & SIT9531X_PLL_ACTIVE_BIT);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_chan_state_fetch(struct sit9531x_dev *sitdev, u8 pll_i=
dx)=0A=
+{=0A=
+	u8 status, outer_lol, input_sel, inner_lol, ho_freeze, activesel_reg;=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 pll_status_1;=0A=
+	bool active;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Whether the PLL is running at all.  The loss-of-lock bit read=0A=
+	 * below is driven by the PLL itself, so on one the loaded=0A=
+	 * configuration leaves unused it simply stays clear and would=0A=
+	 * otherwise read as a lock.=0A=
+	 */=0A=
+	rc =3D sit9531x_pll_is_active(sitdev, pll_idx, &active);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_STATUS, &status);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_OUTER_LOL_STATUS,=0A=
+			      &outer_lol);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Read the input source the PLL has currently selected as its=0A=
+	 * active reference.  This lives in the low nibble of the last=0A=
+	 * register of the PLL's page-1 priority block (CLK_ACTIVESEL_PLL),=0A=
+	 * not on the PLL page -- PLL-page 0x29 is a config register.=0A=
+	 */=0A=
+	activesel_reg =3D SIT9531X_PRIO_BASE_REG +=0A=
+			SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
+			SIT9531X_PRIO_ACTIVESEL_OFF;=0A=
+	rc =3D sit9531x_read_u8(sitdev,=0A=
+			      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
+					   activesel_reg),=0A=
+			      &input_sel);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_STATUS,=0A=
+			      &inner_lol);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_HO_FREEZE_STATUS, &ho_freeze=
);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_STATUS_1,=
=0A=
+				  &pll_status_1);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Which sources this PLL may select.  The table is configuration and=0A=
+	 * changes only through the driver, but reading it back keeps the=0A=
+	 * membership the pin state getters report tied to the hardware=0A=
+	 * instead of to a value the driver maintains on the side.=0A=
+	 */=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+=0A=
+	/* STATUS_1_GENERIC reports loss of lock, so invert it. */=0A=
+	chan->active =3D active;=0A=
+	chan->locked =3D active && !(outer_lol & BIT(pll_idx));=0A=
+	chan->mode =3D !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);=0A=
+	chan->selected_ref =3D=0A=
+		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+	chan->inner_lol =3D !!(inner_lol & BIT(pll_idx));=0A=
+	chan->ho_freeze =3D !!(ho_freeze & BIT(pll_idx));=0A=
+	chan->ho_valid =3D !!(pll_status_1 & SIT9531X_PLL_STATUS_1_HO_VALID);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_out_state_fetch - read output status from hardware=0A=
+ *=0A=
+ * Reads the output PLL association from the PLL page output map=0A=
+ * registers into out->routed / out->pll_idx, and the current drive=0A=
+ * state from the Hi-Z force bits into out->enabled.  The two are=0A=
+ * separate: routing decides whether the output gets a DPLL pin at all,=0A=
+ * while a muted but routed output keeps its pin and reports=0A=
+ * DPLL_PIN_STATE_DISCONNECTED until it is un-muted.=0A=
+ */=0A=
+static int sit9531x_out_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
+{=0A=
+	struct sit9531x_out *out =3D &sitdev->out[index];=0A=
+	u8 map_lo, map_hi, slot;=0A=
+	int pll_idx;=0A=
+	bool muted;=0A=
+	int rc;=0A=
+=0A=
+	slot =3D sitdev->info->clkout_map[index];=0A=
+=0A=
+	rc =3D sit9531x_output_mode_fetch(sitdev, index);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * DT board-config override: the per-PLL OUTPUT_ENABLE bitmaps=0A=
+	 * (0x27/0x28) do not unambiguously express output->PLL routing on=0A=
+	 * every config (overlaps, and some outputs routed outside that=0A=
+	 * path).  When the board supplies an explicit map, trust it.=0A=
+	 */=0A=
+	if (sitdev->out_pll_map_valid) {=0A=
+		u8 m =3D sitdev->out_pll_map[index];=0A=
+=0A=
+		if (m < SIT9531X_NUM_PLLS) {=0A=
+			out->pll_idx =3D m;=0A=
+			out->routed =3D true;=0A=
+			out->enabled =3D !muted;=0A=
+		} else {=0A=
+			out->pll_idx =3D 0;=0A=
+			out->routed =3D false;=0A=
+			out->enabled =3D false;=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The OUT_MAP_LO/HI bitmaps are indexed by the physical slot the=0A=
+	 * output occupies on the chip, not by the driver's logical output=0A=
+	 * index (translated above via the chip-info clkout_map[]: identity=0A=
+	 * on SiT95316, non-contiguous on SiT95317).=0A=
+	 *=0A=
+	 * Determine which PLL drives this output by checking each PLL's=0A=
+	 * output map registers (0x27 =3D slots 8-11, 0x28 =3D slots 0-7).=0A=
+	 */=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_OUT_MAP_LO, &map_lo);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_OUT_MAP_HI, &map_hi);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		if (slot < 8) {=0A=
+			if (map_lo & BIT(slot)) {=0A=
+				out->pll_idx =3D pll_idx;=0A=
+				out->routed =3D true;=0A=
+				out->enabled =3D !muted;=0A=
+				return 0;=0A=
+			}=0A=
+		} else {=0A=
+			if (map_hi & BIT(slot - 8)) {=0A=
+				out->pll_idx =3D pll_idx;=0A=
+				out->routed =3D true;=0A=
+				out->enabled =3D !muted;=0A=
+				return 0;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/* Output not mapped to any PLL */=0A=
+	out->pll_idx =3D 0;=0A=
+	out->routed =3D false;=0A=
+	out->enabled =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_ref_pll_mask_fetch - seed the input-to-PLL usage masks=0A=
+ *=0A=
+ * ref->pll_mask is the refcount the disconnect path uses to decide when=
=0A=
+ * an input receiver may be powered down: the physical input is only=0A=
+ * disabled once the last DPLL has released it.  It therefore has to=0A=
+ * start out matching the hardware.  Without this pass every mask starts=
=0A=
+ * at zero, and disconnecting an input from one DPLL drops the mask to=0A=
+ * zero and disables a receiver the other DPLLs are still locked to.=0A=
+ *=0A=
+ * An input is counted for a PLL when it appears in that PLL's Page-1=0A=
+ * priority table, which is exactly the condition the connect and=0A=
+ * disconnect callbacks maintain.  Sources that are not physical inputs=0A=
+ * (OCXO, INTSYNC) and reserved codes are skipped.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_ref_pll_mask_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 pll_idx, slot, index;=0A=
+	int rc;=0A=
+=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+			index =3D sit9531x_hw_src_input(srcs[slot]);=0A=
+			if (index >=3D sitdev->info->num_inputs)=0A=
+				continue;=0A=
+=0A=
+			/*=0A=
+			 * On a differentially configured pair only the P lane=0A=
+			 * has a DPLL pin, so that is the lane the connect and=0A=
+			 * disconnect callbacks account for.  Fold an N-lane=0A=
+			 * table entry onto its P lane, otherwise the count=0A=
+			 * would land on a lane nothing ever releases.  The=0A=
+			 * signaling mode is already known here:=0A=
+			 * sit9531x_input_mode_fetch() runs first.=0A=
+			 */=0A=
+			if (sit9531x_input_is_n(index) &&=0A=
+			    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+				index--;=0A=
+=0A=
+			sitdev->ref[index].pll_mask |=3D BIT(pll_idx);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dev_state_fetch - read all hardware state at startup=0A=
+ *=0A=
+ * Called once during probe to populate the initial state cache.=0A=
+ */=0A=
+static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+	u8 i;=0A=
+=0A=
+	/* Detect SE/DE configuration before any per-lane access */=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs / 2; i++) {=0A=
+		rc =3D sit9531x_input_mode_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch CLKIN%u mode: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		rc =3D sit9531x_ref_state_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch input %u state: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The priority-table read walks the Page-1 registers, so it runs=0A=
+	 * with multiop_lock held like every other multi-register sequence.=0A=
+	 * Nothing can race with it here -- the DPLLs are not registered and=0A=
+	 * the monitor is not running yet -- but the page handling stays=0A=
+	 * serialized the same way as at runtime.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_ref_pll_mask_fetch(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to fetch input priority tables: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		rc =3D sit9531x_out_state_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch output %u state: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch PLL%c state: %d\n",=0A=
+				'A' + i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int i, rc;=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		rc =3D sit9531x_ref_state_fetch(sitdev, i);=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Failed to get REF%u status: %d\n", i, rc);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)=
=0A=
+{=0A=
+	int i, rc;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Failed to get PLL%c state: %d\n",=0A=
+				 'A' + i, rc);=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dev_periodic_work - periodic hardware state polling=0A=
+ * @work:	kthread_work pointer=0A=
+ *=0A=
+ * Polls hardware state at SIT9531X_STATUS_POLL_MS intervals.=0A=
+ * Updates reference and channel states, then delegates change=0A=
+ * detection to sit9531x_dpll_changes_check() for each registered DPLL.=0A=
+ */=0A=
+static void sit9531x_dev_periodic_work(struct kthread_work *work)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D container_of(work, struct sit9531x_dev,=
=0A=
+						   work.work);=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Update the cached ref[]/chan[] arrays under multiop_lock so the=0A=
+	 * fetches are serialized against the DPLL callbacks that read=0A=
+	 * these fields and against the chip's page selector.=0A=
+	 *=0A=
+	 * The lock is then dropped before sit9531x_dpll_changes_check(),=0A=
+	 * which calls dpll_pin_change_ntf() / dpll_device_change_ntf().=0A=
+	 * Those notification helpers take DPLL-subsystem locks that are=0A=
+	 * already held when our callbacks are invoked from netlink=0A=
+	 * context, and nesting multiop_lock around them would invert the=0A=
+	 * lock order.  changes_check() reads the cache published above,=0A=
+	 * which is already consistent.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dev_ref_states_update(sitdev);=0A=
+	sit9531x_dev_chan_states_update(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list)=0A=
+		sit9531x_dpll_changes_check(sitdpll);=0A=
+=0A=
+	/*=0A=
+	 * Acknowledge the chip's notification latches after the tick has=0A=
+	 * read and acted on them.  Without this, the W1C bits remain set=0A=
+	 * and -- on boards that wire INTRB -- the line stays asserted,=0A=
+	 * re-firing the threaded handler back to back.  The helper writes=0A=
+	 * W1C bits across page 0 and page 6 and must run under=0A=
+	 * multiop_lock to serialize the page selector against userspace=0A=
+	 * dpll ops.  Failure is non-fatal: status was already consumed=0A=
+	 * for this tick and the next tick re-processes whatever stayed=0A=
+	 * latched.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_clear_notifications(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		dev_warn_ratelimited(sitdev->dev,=0A=
+				     "Failed to clear notifications: %d\n",=0A=
+				     rc);=0A=
+=0A=
+	/* Run twice a second */=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,=0A=
+				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_irq_thread_fn - threaded IRQ handler for the chip's INTRB line=
=0A=
+ *=0A=
+ * Triggered when the chip asserts INTRB (and only when DT wires up the=0A=
+ * client interrupt; absent property =3D=3D handler never installed).  The=
=0A=
+ * action mirrors a periodic-work tick: queue an immediate run so status=
=0A=
+ * registers are read and DPLL changes_check fires without waiting for=0A=
+ * the next poll deadline.  Polling continues to run as a fallback.=0A=
+ */=0A=
+static irqreturn_t sit9531x_irq_thread_fn(int irq, void *data)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D data;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Acknowledge the chip's notification latches from the threaded=0A=
+	 * handler itself.  With IRQF_ONESHOT the line is unmasked on=0A=
+	 * return, so deferring the W1C clear to the async kworker would=0A=
+	 * let a still-asserted INTRB re-fire immediately (interrupt storm).=0A=
+	 * Clear here, then kick the poll worker to read state and run=0A=
+	 * changes_check.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_clear_notifications(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_warn_ratelimited(sitdev->dev,=0A=
+				     "IRQ: failed to clear notifications: %d\n",=0A=
+				     rc);=0A=
+		/*=0A=
+		 * The latch was not acknowledged, so with IRQF_ONESHOT the=0A=
+		 * still-asserted line would re-enter this handler back to=0A=
+		 * back forever.  Report the interrupt as unhandled so the=0A=
+		 * spurious-IRQ detector can engage if the bus stays broken.=0A=
+		 */=0A=
+		return IRQ_NONE;=0A=
+	}=0A=
+=0A=
+	kthread_mod_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+	return IRQ_HANDLED;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dev_start - start normal operation=0A=
+ *=0A=
+ * Fetches initial hardware state, registers all DPLL devices and=0A=
+ * their pins, and starts the periodic monitoring thread.=0A=
+ */=0A=
+/*=0A=
+ * Report what the device loaded from its EEPROM, and warn if it does not=
=0A=
+ * look like a healthy load.=0A=
+ *=0A=
+ * A profile that failed to load leaves the part running something other=
=0A=
+ * than what the board was designed around -- dividers, output routing=0A=
+ * and priority tables all differ -- while every register still reads=0A=
+ * back a plausible value.  Naming the profile and saying whether the=0A=
+ * load was clean turns that into something visible at startup instead of=
=0A=
+ * something inferred from measurements later.=0A=
+ *=0A=
+ * This only reports.  Boards in this family may have their=0A=
+ * configuration pushed over I2C rather than held in an EEPROM, and there=
=0A=
+ * the CRC pair means nothing, so a mismatch is not grounds for refusing=
=0A=
+ * to drive the device.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_eeprom_state_report(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u32 rec_crc =3D 0, cal_crc =3D 0, prof_id =3D 0;=0A=
+	u8 notif, v;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	/* Profile id: three bytes, least significant first. */=0A=
+	for (i =3D 2; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_PROFILE_ID + i, &v);=0A=
+		if (rc)=0A=
+			return;=0A=
+		prof_id =3D prof_id << 8 | v;=0A=
+	}=0A=
+=0A=
+	dev_info(sitdev->dev, "profile id %u\n", prof_id);=0A=
+=0A=
+	/* Both CRCs: four bytes, most significant first. */=0A=
+	for (i =3D 0; i < 4; i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_REC_CRC + i, &v);=0A=
+		if (rc)=0A=
+			return;=0A=
+		rec_crc =3D rec_crc << 8 | v;=0A=
+=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_CAL_CRC + i, &v);=0A=
+		if (rc)=0A=
+			return;=0A=
+		cal_crc =3D cal_crc << 8 | v;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_EEPROM_NOTIF, &notif);=0A=
+	if (rc)=0A=
+		return;=0A=
+=0A=
+	/*=0A=
+	 * A clean load leaves the read-done bit set and every defect bit=0A=
+	 * clear.  Both CRCs zero means no EEPROM read happened at all:=0A=
+	 * boards in this family may take their configuration over I2C=0A=
+	 * instead of an EEPROM, and there the CRC pair means nothing, so=0A=
+	 * that case is not a mismatch worth warning about.=0A=
+	 */=0A=
+	if (!rec_crc && !cal_crc)=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"no EEPROM profile (configuration pushed over I2C)\n");=0A=
+	else if (rec_crc !=3D cal_crc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "EEPROM CRC mismatch: stored %08x, computed %08x\n",=0A=
+			 rec_crc, cal_crc);=0A=
+	else if (notif !=3D SIT9531X_EEPROM_READ_DONE)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "EEPROM read reported defects (notify %02x)\n",=0A=
+			 notif);=0A=
+	else=0A=
+		dev_dbg(sitdev->dev, "EEPROM profile loaded, CRC %08x\n",=0A=
+			cal_crc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Report which PLLs came up, and flag the one case that is a real=0A=
+ * inconsistency rather than a configuration choice.=0A=
+ *=0A=
+ * A PLL the loaded configuration leaves unused never reaches its active=
=0A=
+ * state, which is normal and not worth a warning.  A PLL that has=0A=
+ * outputs routed to it and is still not active is different: something=0A=
+ * that is meant to be generating clocks is not running, and every value=
=0A=
+ * read from it -- lock state, phase, frequency offset -- describes a=0A=
+ * stopped loop.  Say so once at startup rather than leaving it to be=0A=
+ * discovered through measurements that quietly read as zero.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_pll_states_report(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	unsigned int idx, i;=0A=
+	bool routed;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		if (sitdev->chan[i].active) {=0A=
+			dev_dbg(sitdev->dev, "PLL%c active\n", 'A' + i);=0A=
+			continue;=0A=
+		}=0A=
+=0A=
+		routed =3D false;=0A=
+		for (idx =3D 0; idx < sitdev->info->num_outputs; idx++) {=0A=
+			const struct sit9531x_out *out;=0A=
+=0A=
+			out =3D sit9531x_out_state_get(sitdev, idx);=0A=
+			if (out->routed && out->pll_idx =3D=3D i) {=0A=
+				routed =3D true;=0A=
+				break;=0A=
+			}=0A=
+		}=0A=
+=0A=
+		if (routed)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c drives outputs but is not in its active state\n",=0A=
+				 'A' + i);=0A=
+		else=0A=
+			dev_dbg(sitdev->dev, "PLL%c unused by the loaded configuration\n",=0A=
+				'A' + i);=0A=
+	}=0A=
+}=0A=
+=0A=
+int sit9531x_dev_start(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	int rc;=0A=
+=0A=
+	/* Fetch device state */=0A=
+	rc =3D sit9531x_dev_state_fetch(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_eeprom_state_report(sitdev);=0A=
+	sit9531x_pll_states_report(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		rc =3D sit9531x_dpll_register(sitdpll);=0A=
+		if (rc) {=0A=
+			dev_err_probe(sitdev->dev, rc,=0A=
+				      "Failed to register DPLL%u\n",=0A=
+				      sitdpll->id);=0A=
+			goto err_unregister;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_unregister:=0A=
+	/*=0A=
+	 * Unregister what did register.  The caller frees the list on this=0A=
+	 * path, so leaving a DPLL registered would hand the subsystem a=0A=
+	 * pointer to freed memory.=0A=
+	 */=0A=
+	list_for_each_entry_continue_reverse(sitdpll, &sitdev->dplls, list)=0A=
+		sit9531x_dpll_unregister(sitdpll);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dev_stop - stop normal operation=0A=
+ *=0A=
+ * Cancels the monitoring thread and unregisters all DPLL devices=0A=
+ * and their pins.=0A=
+ */=0A=
+void sit9531x_dev_stop(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+=0A=
+	kthread_cancel_delayed_work_sync(&sitdev->work);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		if (sitdpll->dpll_dev)=0A=
+			sit9531x_dpll_unregister(sitdpll);=0A=
+	}=0A=
+}=0A=
+=0A=
+static struct sit9531x_dpll_pin *=0A=
+sit9531x_dpll_pin_alloc(struct sit9531x_dpll *sitdpll,=0A=
+			enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+=0A=
+	pin =3D kzalloc_obj(*pin, GFP_KERNEL);=0A=
+	if (!pin)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	pin->dpll =3D sitdpll;=0A=
+	pin->dir =3D dir;=0A=
+	pin->id =3D id;=0A=
+=0A=
+	return pin;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_pin_register - register a DPLL pin with the subsystem=0A=
+ * @index:	absolute pin index for clock_id namespace=0A=
+ *=0A=
+ * Gets pin properties from firmware, creates or gets a dpll_pin,=0A=
+ * and registers it with the parent DPLL device.=0A=
+ */=0A=
+static int sit9531x_dpll_pin_register(struct sit9531x_dpll_pin *pin,=0A=
+				      u32 index)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	const struct dpll_pin_ops *ops;=0A=
+	int rc;=0A=
+=0A=
+	props =3D sit9531x_pin_props_get(sitdpll->dev, pin->dir, pin->id);=0A=
+	if (IS_ERR(props))=0A=
+		return PTR_ERR(props);=0A=
+=0A=
+	strscpy(pin->label, props->package_label, sizeof(pin->label));=0A=
+	pin->fwnode =3D fwnode_handle_get(props->fwnode);=0A=
+	pin->esync_control =3D props->esync_control;=0A=
+=0A=
+	pin->dpll_pin =3D dpll_pin_get(sitdpll->dev->clock_id, index,=0A=
+				     THIS_MODULE, &props->dpll_props,=0A=
+				     &pin->tracker);=0A=
+	if (IS_ERR(pin->dpll_pin)) {=0A=
+		rc =3D PTR_ERR(pin->dpll_pin);=0A=
+		goto err_pin_get;=0A=
+	}=0A=
+	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);=0A=
+=0A=
+	ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+=0A=
+	rc =3D dpll_pin_register(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);=0A=
+	if (rc)=0A=
+		goto err_register;=0A=
+=0A=
+	sit9531x_pin_props_put(props);=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_register:=0A=
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);=0A=
+err_pin_get:=0A=
+	/* dpll_pin_get() left an ERR_PTR here. */=0A=
+	pin->dpll_pin =3D NULL;=0A=
+	fwnode_handle_put(pin->fwnode);=0A=
+	pin->fwnode =3D NULL;=0A=
+	sit9531x_pin_props_put(props);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_pin_unregister(struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+	const struct dpll_pin_ops *ops;=0A=
+=0A=
+	ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+=0A=
+	dpll_pin_unregister(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);=0A=
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);=0A=
+	pin->dpll_pin =3D NULL;=0A=
+=0A=
+	fwnode_handle_put(pin->fwnode);=0A=
+	pin->fwnode =3D NULL;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_pins_unregister(struct sit9531x_dpll *sitdpll)=
=0A=
+{=0A=
+	struct sit9531x_dpll_pin *pin, *next;=0A=
+=0A=
+	list_for_each_entry_safe(pin, next, &sitdpll->pins, list) {=0A=
+		sit9531x_dpll_pin_unregister(pin);=0A=
+		list_del(&pin->list);=0A=
+		kfree(pin);=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_pin_is_registrable - check if a pin should be registered=
=0A=
+ * @dir:	pin direction=0A=
+ * @index:	pin hardware index=0A=
+ *=0A=
+ * Only the XO pin has a complete pin-op table in this patch, so only=0A=
+ * the XO pin is registrable here.  Other pin classes are registered=0A=
+ * once their state callbacks land in the following patches.=0A=
+ *=0A=
+ * Return: true if pin should be registered, false otherwise=0A=
+ */=0A=
+static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll=
,=0A=
+					     enum dpll_pin_direction dir,=0A=
+					     u8 index)=0A=
+{=0A=
+	/*=0A=
+	 * Only the XO pin has a complete pin-op table in this patch.=0A=
+	 * Other pin classes are registered once their state callbacks=0A=
+	 * land in the following patches.=0A=
+	 */=0A=
+	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		return false;=0A=
+=0A=
+	return index =3D=3D SIT9531X_MAX_INPUTS;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_pins_register - register all registrable pins=0A=
+ *=0A=
+ * Enumerates all possible input and output pins, checks registrability,=
=0A=
+ * and registers each one.  Input pins come first, then output pins,=0A=
+ * with input pins first, then output pins.=0A=
+ */=0A=
+static int sit9531x_dpll_pins_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+	enum dpll_pin_direction dir;=0A=
+	u8 id, index;=0A=
+	int rc;=0A=
+=0A=
+	for (index =3D 0; index < SIT9531X_NUM_PINS_TOTAL; index++) {=0A=
+		if (index < SIT9531X_NUM_INPUT_PINS) {=0A=
+			id =3D index;=0A=
+			dir =3D DPLL_PIN_DIRECTION_INPUT;=0A=
+		} else {=0A=
+			id =3D index - SIT9531X_NUM_INPUT_PINS;=0A=
+			dir =3D DPLL_PIN_DIRECTION_OUTPUT;=0A=
+		}=0A=
+=0A=
+		if (!sit9531x_dpll_pin_is_registrable(sitdpll, dir, id))=0A=
+			continue;=0A=
+=0A=
+		pin =3D sit9531x_dpll_pin_alloc(sitdpll, dir, id);=0A=
+		if (IS_ERR(pin)) {=0A=
+			rc =3D PTR_ERR(pin);=0A=
+			goto error;=0A=
+		}=0A=
+=0A=
+		rc =3D sit9531x_dpll_pin_register(pin, index);=0A=
+		if (rc) {=0A=
+			kfree(pin);=0A=
+			goto error;=0A=
+		}=0A=
+=0A=
+		list_add(&pin->list, &sitdpll->pins);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+=0A=
+error:=0A=
+	sit9531x_dpll_pins_unregister(sitdpll);=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int sit9531x_dpll_device_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	sitdpll->ops =3D sit9531x_dpll_device_ops;=0A=
+=0A=
+	sitdpll->dpll_dev =3D dpll_device_get(sitdev->clock_id, sitdpll->id,=0A=
+					    THIS_MODULE, &sitdpll->tracker);=0A=
+	if (IS_ERR(sitdpll->dpll_dev)) {=0A=
+		rc =3D PTR_ERR(sitdpll->dpll_dev);=0A=
+		sitdpll->dpll_dev =3D NULL;=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	rc =3D dpll_device_register(sitdpll->dpll_dev,=0A=
+				  sit9531x_prop_dpll_type_get(sitdev,=0A=
+							      sitdpll->id),=0A=
+				  &sitdpll->ops, sitdpll);=0A=
+	if (rc) {=0A=
+		dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);=0A=
+		sitdpll->dpll_dev =3D NULL;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_device_unregister(struct sit9531x_dpll *sitdpll)=
=0A=
+{=0A=
+	dpll_device_unregister(sitdpll->dpll_dev, &sitdpll->ops, sitdpll);=0A=
+	dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);=0A=
+	sitdpll->dpll_dev =3D NULL;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_alloc - allocate a DPLL device structure=0A=
+ * @sitdev:	parent device=0A=
+ * @ch:		PLL channel number (0-3)=0A=
+ *=0A=
+ * Return: pointer to allocated DPLL on success, error pointer on error=0A=
+ */=0A=
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 =
ch)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+=0A=
+	sitdpll =3D kzalloc_obj(*sitdpll, GFP_KERNEL);=0A=
+	if (!sitdpll)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	sitdpll->dev =3D sitdev;=0A=
+	sitdpll->id =3D ch;=0A=
+	sitdpll->lock_status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	INIT_LIST_HEAD(&sitdpll->pins);=0A=
+=0A=
+	return sitdpll;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_free - deallocate a DPLL device structure=0A=
+ * @sitdpll:	DPLL to free=0A=
+ */=0A=
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	kfree(sitdpll);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_register - register DPLL device and all its pins=0A=
+ *=0A=
+ * Registers the DPLL device with the subsystem and then registers=0A=
+ * all input and output pins that are connected to this PLL.=0A=
+ */=0A=
+int sit9531x_dpll_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_dpll_device_register(sitdpll);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_dpll_pins_register(sitdpll);=0A=
+	if (rc) {=0A=
+		sit9531x_dpll_device_unregister(sitdpll);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* sit9531x_dpll_unregister - unregister DPLL device and its pins */=0A=
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	sit9531x_dpll_pins_unregister(sitdpll);=0A=
+	sit9531x_dpll_device_unregister(sitdpll);=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_list_free(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll, *next;=0A=
+=0A=
+	list_for_each_entry_safe(sitdpll, next, &sitdev->dplls, list) {=0A=
+		list_del(&sitdpll->list);=0A=
+		sit9531x_dpll_free(sitdpll);=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Runs only once the device is fully started, see the caller. */=0A=
+static void sit9531x_dev_dpll_fini(void *ptr)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D ptr;=0A=
+=0A=
+	sit9531x_dev_stop(sitdev);=0A=
+	kthread_destroy_worker(sitdev->kworker);=0A=
+	sit9531x_dpll_list_free(sitdev);=0A=
+}=0A=
+=0A=
+static int sit9531x_devm_dpll_init(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct kthread_worker *kworker;=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	unsigned int i;=0A=
+	int rc;=0A=
+=0A=
+	INIT_LIST_HEAD(&sitdev->dplls);=0A=
+	kthread_init_delayed_work(&sitdev->work, sit9531x_dev_periodic_work);=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		sitdpll =3D sit9531x_dpll_alloc(sitdev, i);=0A=
+		if (IS_ERR(sitdpll)) {=0A=
+			rc =3D dev_err_probe(sitdev->dev, PTR_ERR(sitdpll),=0A=
+					   "Failed to alloc DPLL%u\n", i);=0A=
+			goto err_free_dplls;=0A=
+		}=0A=
+=0A=
+		list_add_tail(&sitdpll->list, &sitdev->dplls);=0A=
+	}=0A=
+=0A=
+	kworker =3D kthread_run_worker(0, "sit9531x-%s", dev_name(sitdev->dev));=
=0A=
+	if (IS_ERR(kworker)) {=0A=
+		rc =3D PTR_ERR(kworker);=0A=
+		goto err_free_dplls;=0A=
+	}=0A=
+	sitdev->kworker =3D kworker;=0A=
+=0A=
+	rc =3D sit9531x_dev_start(sitdev);=0A=
+	if (rc) {=0A=
+		rc =3D dev_err_probe(sitdev->dev, rc, "Failed to start device\n");=0A=
+		goto err_destroy_worker;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Only now is every field the cleanup touches valid, so this is the=0A=
+	 * first point at which the action may be registered.  On failure it=0A=
+	 * runs the action itself, which is correct here and only here.=0A=
+	 */=0A=
+	return devm_add_action_or_reset(sitdev->dev, sit9531x_dev_dpll_fini,=0A=
+					sitdev);=0A=
+=0A=
+err_destroy_worker:=0A=
+	kthread_destroy_worker(sitdev->kworker);=0A=
+err_free_dplls:=0A=
+	sit9531x_dpll_list_free(sitdev);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_variant_id - read chip variant ID byte from hardware=0A=
+ * @id:		output variant ID byte=0A=
+ *=0A=
+ * Reads the single-byte variant identification register from Page 0=0A=
+ * reg 0x02 (95317 =3D 0x17, 95316 =3D 0x31).  Reg 0x03 holds a separate=
=0A=
+ * revision byte and is intentionally not consumed here.=0A=
+ */=0A=
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+}=0A=
+=0A=
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
+{=0A=
+	unsigned int i;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
+		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
+			return &sit9531x_chip_ids[i];=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_derive_clock_id - build EUI-64 clock identifier=0A=
+ *=0A=
+ * Generates a deterministic 64-bit identifier from the SiTime OUI,=0A=
+ * the chip ID, the I2C bus number and the I2C address.  The bus number=0A=
+ * disambiguates two same-variant parts at the same address on=0A=
+ * different adapters (or behind a mux), which the DPLL core would=0A=
+ * otherwise fold onto one set of objects; DT bus aliases keep the=0A=
+ * numbering, and with it the clock_id, stable across reboots.=0A=
+ *=0A=
+ * Return: 64-bit clock identifier=0A=
+ */=0A=
+static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u64 clkid;=0A=
+=0A=
+	clkid  =3D SIT9531X_OUI << 24;=0A=
+	clkid |=3D (u64)(i2c_adapter_id(sitdev->client->adapter) & 0xff) << 16;=
=0A=
+	clkid |=3D (u64)sitdev->info->id << 8;=0A=
+	clkid |=3D (u64)sitdev->client->addr;=0A=
+=0A=
+	return clkid;=0A=
+}=0A=
+=0A=
+int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct clk *xtal_clk;=0A=
+	u8 variant_id;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Fvco =3D Fref * (DIVN + frac/2^32) with Fref =3D xtal_freq << doubler,=
=0A=
+	 * so every freq_set and phase_adjust path divides by a rate derived=0A=
+	 * from the XO feeding XIN/XO_CLK.  The rate normally comes from a=0A=
+	 * "clocks" phandle (clock-names =3D "xtal").  On platforms where the=0A=
+	 * firmware does not expose the XO through the clock framework, fall=0A=
+	 * back to a "clock-frequency" device property.=0A=
+	 */=0A=
+	xtal_clk =3D devm_clk_get_optional_enabled(sitdev->dev, "xtal");=0A=
+	if (IS_ERR(xtal_clk))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
+				     "Failed to get xtal clock\n");=0A=
+	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
+	if (!sitdev->xtal_freq) {=0A=
+		u32 freq;=0A=
+=0A=
+		if (!device_property_read_u32(sitdev->dev, "clock-frequency",=0A=
+					      &freq))=0A=
+			sitdev->xtal_freq =3D freq;=0A=
+	}=0A=
+	if (!sitdev->xtal_freq)=0A=
+		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
+				     "no xtal rate: provide clocks=3D<&xo> + clock-names=3D\"xtal\", o=
r a clock-frequency property\n");=0A=
+=0A=
+	/*=0A=
+	 * Held deasserted, never pulsed: the chip configuration comes from=0A=
+	 * efuse or an NVM blob applied before probe, and a reset would=0A=
+	 * discard it.  Must precede the first I2C access, as a board that=0A=
+	 * powers up asserted keeps the chip unreachable until released.=0A=
+	 */=0A=
+	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
+						     GPIOD_OUT_LOW);=0A=
+	if (IS_ERR(sitdev->reset_gpio))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
+				     "Failed to request reset gpio\n");=0A=
+	if (sitdev->reset_gpio)=0A=
+		fsleep(10000);	/* internal boot after release */=0A=
+=0A=
+	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
+	if (!sitdev->info)=0A=
+		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
+				     "Unknown variant ID: 0x%02x\n", variant_id);=0A=
+=0A=
+	sitdev->clock_id =3D sit9531x_derive_clock_id(sitdev);=0A=
+	sitdev->intsync_src =3D -1;=0A=
+=0A=
+	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return dev_err_probe(sitdev->dev, rc,=0A=
+				     "Failed to initialize mutex\n");=0A=
+=0A=
+	/*=0A=
+	 * Before the IRQ: the handler reaches sitdev->kworker through=0A=
+	 * kthread_mod_delayed_work(), so the worker has to exist before an=0A=
+	 * INTRB assertion can land.=0A=
+	 */=0A=
+	rc =3D sit9531x_devm_dpll_init(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Absent "interrupts" leaves client->irq 0 and the poll in charge. */=0A=
+	sitdev->irq =3D sitdev->client ? sitdev->client->irq : 0;=0A=
+	if (sitdev->irq > 0) {=0A=
+		rc =3D devm_request_threaded_irq(sitdev->dev, sitdev->irq,=0A=
+					       NULL, sit9531x_irq_thread_fn,=0A=
+					       IRQF_ONESHOT,=0A=
+					       dev_name(sitdev->dev), sitdev);=0A=
+		if (rc)=0A=
+			return dev_err_probe(sitdev->dev, rc,=0A=
+					     "Failed to request IRQ %d\n",=0A=
+					     sitdev->irq);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev;=0A=
+	struct regmap *regmap;=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
+	if (IS_ERR(regmap))=0A=
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
+				     "Failed to initialize regmap\n");=0A=
+=0A=
+	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
+	if (!sitdev)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	sitdev->dev =3D &client->dev;=0A=
+	sitdev->client =3D client;=0A=
+	sitdev->regmap =3D regmap;=0A=
+	i2c_set_clientdata(client, sitdev);=0A=
+=0A=
+	return sit9531x_dev_probe(sitdev);=0A=
+}=0A=
+=0A=
+static const struct of_device_id sit9531x_of_match[] =3D {=0A=
+	{ .compatible =3D "sitime,sit95316" },=0A=
+	{ .compatible =3D "sitime,sit95317" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+=0A=
+/*=0A=
+ * The poll worker is not freezable and would keep issuing paged I2C=0A=
+ * transfers into a suspended adapter, where i2c_transfer() fails and a=0A=
+ * tick landing mid-suspend could tear a paged sequence between the=0A=
+ * page-selector write and the register access.  Park the worker (and=0A=
+ * the IRQ that kicks it) across suspend and take a fresh sample on=0A=
+ * resume.=0A=
+ */=0A=
+static int sit9531x_suspend(struct device *dev)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D dev_get_drvdata(dev);=0A=
+=0A=
+	if (sitdev->irq > 0)=0A=
+		disable_irq(sitdev->irq);=0A=
+	kthread_cancel_delayed_work_sync(&sitdev->work);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_resume(struct device *dev)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D dev_get_drvdata(dev);=0A=
+=0A=
+	if (sitdev->irq > 0)=0A=
+		enable_irq(sitdev->irq);=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static DEFINE_SIMPLE_DEV_PM_OPS(sit9531x_pm_ops,=0A=
+				sit9531x_suspend, sit9531x_resume);=0A=
 =0A=
 static struct i2c_driver sit9531x_i2c_driver =3D {=0A=
 	.driver			=3D {=0A=
 		.name		=3D "sit9531x",=0A=
 		.of_match_table	=3D sit9531x_of_match,=0A=
+		.pm		=3D pm_sleep_ptr(&sit9531x_pm_ops),=0A=
 	},=0A=
 	.probe		=3D sit9531x_i2c_probe,=0A=
 };=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 230b21b9e238..5ead3811e14b 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -15,6 +15,8 @@=0A=
 =0A=
 #include <linux/gpio/consumer.h>=0A=
 #include <linux/i2c.h>=0A=
+#include <linux/kthread.h>=0A=
+#include <linux/list.h>=0A=
 #include <linux/mutex.h>=0A=
 #include <linux/regmap.h>=0A=
 #include <linux/types.h>=0A=
@@ -25,6 +27,8 @@=0A=
 #define SIT9531X_MAX_INPUTS		8=0A=
 #define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
 #define SIT9531X_MAX_OUTPUTS		12=0A=
+/* out_pll_map[] entry meaning "this output is not routed to any PLL" */=
=0A=
+#define SIT9531X_OUT_PLL_UNMAPPED	0xFF=0A=
 /*=0A=
  * INTSYNC (the inter-PLL sync net) is modeled as two pins.  The=0A=
  * destination PLL that locks to INTSYNC sees an input pin=0A=
@@ -34,6 +38,15 @@=0A=
  */=0A=
 #define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)=0A=
 #define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
+#define SIT9531X_STATUS_POLL_MS		500=0A=
+=0A=
+/* selected_ref value when the active source is not a registered input */=
=0A=
+#define SIT9531X_REF_INVALID		0xFF=0A=
+=0A=
+/* SiTime IEEE OUI for EUI-64 generation */=0A=
+#define SIT9531X_OUI			0x0090C2FFFEULL=0A=
+=0A=
+struct sit9531x_dpll;=0A=
 =0A=
 /*=0A=
  * struct sit9531x_chip_info - chip variant identification=0A=
@@ -64,37 +77,97 @@ enum sit9531x_signal_mode {=0A=
 /*=0A=
  * struct sit9531x_ref - input reference state=0A=
  * @freq:		configured frequency in Hz=0A=
+ * @enabled:		reference is enabled for monitoring=0A=
+ * @los:		loss-of-signal detected=0A=
+ * @oof:		out-of-frequency detected=0A=
+ * @pll_mask:		bitmask of PLLs this input feeds (bit 0 =3D PLLA)=0A=
  * @label:		board label from DT or default=0A=
  * @sig_mode:		signal mode of the pair this lane belongs to=0A=
  *			(detected from CLKINx_INPUT_MODE at probe)=0A=
  */=0A=
 struct sit9531x_ref {=0A=
-	u32				freq;=0A=
-	const char			*label;=0A=
+	u64		freq;=0A=
+	bool		enabled;=0A=
+	bool		los;=0A=
+	bool		oof;=0A=
+	u8		pll_mask;=0A=
+	const char	*label;=0A=
 	enum sit9531x_signal_mode	sig_mode;=0A=
 };=0A=
 =0A=
 /*=0A=
  * struct sit9531x_out - output state=0A=
- * @freq:		configured frequency in Hz=0A=
+ * @enabled:		output is driving, i.e. not forced into Hi-Z=0A=
+ * @cmos:		output is wired single-ended; the Hi-Z pair that=0A=
+ *			speaks for it is the SE one, not the differential=0A=
+ * @routed:		output is mapped to @pll_idx by the initial=0A=
+ *			configuration; an unrouted output has no DPLL pin=0A=
+ * @pll_idx:		PLL driving this output (0-3)=0A=
  * @label:		board label from DT or default=0A=
  */=0A=
 struct sit9531x_out {=0A=
-	u32		freq;=0A=
+	u64		freq;=0A=
+	bool		enabled;=0A=
+	bool		cmos;=0A=
+	bool		routed;=0A=
+	u8		pll_idx;=0A=
 	const char	*label;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * struct sit9531x_chan - per-PLL channel state=0A=
+ * @active:		PLL has reached its active state; a PLL the loaded=0A=
+ *			configuration leaves unused never does, and its=0A=
+ *			loss-of-lock bit stays clear because nothing drives it=0A=
+ * @locked:		PLL is locked (raw status register bit)=0A=
+ * @mode:		0 =3D sync (outer loop enabled), 1 =3D free-run=0A=
+ * @selected_ref:	logical input index of the currently selected=0A=
+ *			reference (the INTSYNC net maps to=0A=
+ *			SIT9531X_INTSYNC_PIN_ID), or SIT9531X_REF_INVALID=0A=
+ *			when the hardware source encoding is reserved=0A=
+ * @inner_lol:		PLL inner loop loss-of-lock detected=0A=
+ * @ho_freeze:		holdover freeze active=0A=
+ * @ho_valid:		holdover memory acquired, i.e. the holdover window=0A=
+ *			holds a valid estimate to fall back on=0A=
+ * @prio_mask:		bit per hardware source code present in this PLL's=0A=
+ *			priority table, i.e. the sources it may select.  Read=0A=
+ *			back from the table by the periodic worker and=0A=
+ *			refreshed by every table write, so it tracks the=0A=
+ *			hardware rather than the driver's intent=0A=
+ */=0A=
+struct sit9531x_chan {=0A=
+	bool		active;=0A=
+	bool		locked;=0A=
+	u8		mode;=0A=
+	u8		selected_ref;=0A=
+	bool		inner_lol;=0A=
+	bool		ho_freeze;=0A=
+	bool		ho_valid;=0A=
+	u16		prio_mask;=0A=
+};=0A=
+=0A=
 /*=0A=
  * struct sit9531x_dev - SiT9531x device instance=0A=
- * @dev:		parent device=0A=
- * @client:		I2C client=0A=
- * @regmap:		paged register map=0A=
  * @info:		detected chip variant info=0A=
- * @multiop_lock:	serializes multi-register sequences=0A=
+ * @multiop_lock:	mutex for multi-register atomic operations=0A=
  * @ref:		array of input reference states=0A=
  * @out:		array of output states=0A=
+ * @chan:		array of per-PLL channel states=0A=
  * @xtal_freq:		crystal oscillator frequency in Hz=0A=
+ * @kworker:		kthread worker for periodic polling=0A=
+ * @work:		delayed work for periodic state checks=0A=
+ * @clock_id:		IEEE 1588 EUI-64 clock identifier=0A=
  * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
+ * @irq:		optional INTRB IRQ number (from DT "interrupts" via the=0A=
+ *			I2C client), 0 if no IRQ is wired=0A=
+ * @pll_fvco:		optional per-PLL VCO in Hz from DT=0A=
+ *			"sitime,pll-fvco"; 0 means derive from DIVN=0A=
+ * @out_pll_map:	optional per-output source PLL (0-3, 0xff =3D=0A=
+ *			unmapped) from DT "sitime,output-pll-map"=0A=
+ * @out_pll_map_valid:	true when out_pll_map[] was populated from DT;=0A=
+ *			false means use the chip's OUT_MAP registers=0A=
+ * @intsync_src:	PLL index currently sourcing inter-PLL=0A=
+ *			synchronization (INTSYNC), or -1 when disabled=0A=
  */=0A=
 struct sit9531x_dev {=0A=
 	struct device			*dev;=0A=
@@ -107,11 +180,107 @@ struct sit9531x_dev {=0A=
 	/* Hardware state */=0A=
 	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
 	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
+	struct sit9531x_chan	chan[SIT9531X_NUM_PLLS];=0A=
 	u32			xtal_freq;=0A=
 =0A=
+	/* DPLL channels */=0A=
+	struct list_head	dplls;=0A=
+=0A=
+	/* Monitor */=0A=
+	struct kthread_worker		*kworker;=0A=
+	struct kthread_delayed_work	work;=0A=
+=0A=
+	/* Device identity */=0A=
+	u64			clock_id;=0A=
+=0A=
+	/* Optional DT-described GPIO / IRQ lines */=0A=
 	struct gpio_desc	*reset_gpio;=0A=
+	int			irq;=0A=
+=0A=
+	/* Optional DT board-config overrides */=0A=
+	u64			pll_fvco[SIT9531X_NUM_PLLS];=0A=
+	u8			out_pll_map[SIT9531X_MAX_OUTPUTS];=0A=
+	bool			out_pll_map_valid;=0A=
+=0A=
+	/* Inter-PLL synchronization state */=0A=
+	s8			intsync_src;=0A=
+=0A=
 };=0A=
 =0A=
+extern const struct regmap_config sit9531x_regmap_config;=0A=
+=0A=
+/* ---- Core lifecycle ---- */=0A=
+int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);=0A=
+int  sit9531x_dev_start(struct sit9531x_dev *sitdev);=0A=
+void sit9531x_dev_stop(struct sit9531x_dev *sitdev);=0A=
+=0A=
+/* ---- Register access ---- */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val);=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val);=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val);=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val);=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val);=0A=
+=0A=
+/* ---- Input enable/disable ---- */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+=0A=
+/* ---- Input priority ---- */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio);=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx);=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx);=0A=
+=0A=
+/* ---- Output enable/disable (Hi-Z control) ---- */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+=0A=
+/* ---- Output frequency ---- */=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency);=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency);=0A=
+=0A=
+/* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */=0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps);=0A=
+=0A=
+/* ---- Notification clear ---- */=0A=
+int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);=0A=
+=0A=
+/* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+=0A=
+/* ---- Output pulse control ---- */=0A=
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,=0A=
+				   u8 out_idx, u8 pulse_ctrl);=0A=
+=0A=
+/* ---- Phase offset (TDC readback) ---- */=0A=
+int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo=
);=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps);=0A=
+=0A=
+/* ---- State helpers ---- */=0A=
+=0A=
+/*=0A=
+ * sit9531x_pll_page - get register page for PLL index=0A=
+ * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
+ */=0A=
+static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+{=0A=
+	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Logical input pins are interleaved: even index =3D P lane, odd=0A=
  * index =3D N lane of pair index/2 (IN0P, IN0N, IN1P, IN1N, ...).=0A=
@@ -137,27 +306,78 @@ static inline bool sit9531x_input_is_n(u8 index)=0A=
 }=0A=
 =0A=
 /*=0A=
- * sit9531x_pll_page - get register page for PLL index=0A=
- * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
+ * sit9531x_input_hw_src - translate logical input index to source encodin=
g=0A=
+ * @index: logical input pin index=0A=
+ *=0A=
+ * The priority table and CLK_ACTIVESEL registers use a non-contiguous=0A=
+ * source encoding: 0-3 =3D CLK0P..CLK3P, 5 =3D OCXO, 6 =3D INTSYNC,=0A=
+ * 7-10 =3D CLK0N..CLK3N.=0A=
  */=0A=
-static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+static inline u8 sit9531x_input_hw_src(u8 index)=0A=
 {=0A=
-	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+		return SIT9531X_PRIO_SRC_OCXO;=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return SIT9531X_PRIO_SRC_INTSYNC;=0A=
+	if (sit9531x_input_is_n(index))=0A=
+		return SIT9531X_PRIO_SRC_N_BASE + sit9531x_input_pair(index);=0A=
+	return sit9531x_input_pair(index);=0A=
 }=0A=
 =0A=
-extern const struct regmap_config sit9531x_regmap_config;=0A=
+/*=0A=
+ * sit9531x_hw_src_input - translate source encoding to logical input inde=
x=0A=
+ * @src: 4-bit hardware source encoding=0A=
+ *=0A=
+ * Return: logical input index (INTSYNC maps to SIT9531X_INTSYNC_PIN_ID),=
=0A=
+ * or SIT9531X_REF_INVALID if @src is a reserved value=0A=
+ */=0A=
+static inline u8 sit9531x_hw_src_input(u8 src)=0A=
+{=0A=
+	if (src < SIT9531X_NUM_INPUT_PAIRS)=0A=
+		return src * 2;=0A=
+	if (src =3D=3D SIT9531X_PRIO_SRC_OCXO)=0A=
+		return SIT9531X_MAX_INPUTS;=0A=
+	if (src =3D=3D SIT9531X_PRIO_SRC_INTSYNC)=0A=
+		return SIT9531X_INTSYNC_PIN_ID;=0A=
+	if (src >=3D SIT9531X_PRIO_SRC_N_BASE &&=0A=
+	    src < SIT9531X_PRIO_SRC_N_BASE + SIT9531X_NUM_INPUT_PAIRS)=0A=
+		return (src - SIT9531X_PRIO_SRC_N_BASE) * 2 + 1;=0A=
+	return SIT9531X_REF_INVALID;=0A=
+}=0A=
 =0A=
-/* ---- Core lifecycle ---- */=0A=
-int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);=0A=
+/*=0A=
+ * sit9531x_ref_state_get - get reference state by index=0A=
+ * @index:	logical input index=0A=
+ *=0A=
+ * Return: pointer to the cached input reference state=0A=
+ */=0A=
+static inline const struct sit9531x_ref *=0A=
+sit9531x_ref_state_get(const struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	return &sitdev->ref[index];=0A=
+}=0A=
 =0A=
-/* ---- Register access ---- */=0A=
-int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 *va=
l);=0A=
-int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 va=
l);=0A=
-int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offse=
t,=0A=
-			 u8 *val);=0A=
-int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offs=
et,=0A=
-			  u8 val);=0A=
-int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 off=
set,=0A=
-			   u8 mask, u8 val);=0A=
+/*=0A=
+ * sit9531x_out_state_get - get output state by index=0A=
+ * @index:	logical output index=0A=
+ *=0A=
+ * Return: pointer to the cached output state=0A=
+ */=0A=
+static inline const struct sit9531x_out *=0A=
+sit9531x_out_state_get(const struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	return &sitdev->out[index];=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_chan_state_get - get channel state by PLL index=0A=
+ *=0A=
+ * Return: pointer to the cached per-PLL channel state=0A=
+ */=0A=
+static inline const struct sit9531x_chan *=0A=
+sit9531x_chan_state_get(const struct sit9531x_dev *sitdev, u8 pll_idx)=0A=
+{=0A=
+	return &sitdev->chan[pll_idx];=0A=
+}=0A=
 =0A=
 #endif /* _SIT9531X_CORE_H */=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
new file mode 100644=0A=
index 000000000000..b4984335e6bf=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -0,0 +1,444 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL subsystem callbacks and registration=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * DPLL device ops, pin ops (separate input/output), pin registration,=0A=
+ * and periodic change detection.=0A=
+ */=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/kthread.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/netlink.h>=0A=
+#include <linux/slab.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "dpll.h"=0A=
+#include "prop.h"=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_ESYNC_FREQ_10MHZ	10000000ULL=0A=
+#define SIT9531X_ESYNC_PULSE_DEFAULT	50=0A=
+=0A=
+static bool sit9531x_dpll_is_input_pin(const struct sit9531x_dpll_pin *pin=
)=0A=
+{=0A=
+	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
+}=0A=
+=0A=
+static bool=0A=
+sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_MAX_INPUTS;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The cached state this reports comes from the outer loss-of-lock byte=0A=
+ * (page 0, reg 0x06), the PLL mode bit (PLL page, reg 0x31), inner LOL=0A=
+ * (reg 0x92), the holdover freeze byte (reg 0x0A) and the per-PLL=0A=
+ * holdover-valid bit (PLL page, reg 0x06).=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_p=
riv,=0A=
+			      enum dpll_lock_status *status,=0A=
+			      enum dpll_lock_status_error *status_error,=0A=
+			      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	if (status_error)=0A=
+		*status_error =3D DPLL_LOCK_STATUS_ERROR_NONE;=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (!chan->active) {=0A=
+		/*=0A=
+		 * A PLL the loaded configuration leaves unused never reaches=0A=
+		 * its active state.  Nothing drives its loss-of-lock bit, so=0A=
+		 * without this it would report a lock it does not have.=0A=
+		 */=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	} else if (chan->mode) {=0A=
+		/*=0A=
+		 * Free-run: the outer loop is disabled, so the PLL tracks no=0A=
+		 * reference at all and its loss-of-lock bit means nothing.=0A=
+		 * That is what UNLOCKED describes -- "not yet locked to any=0A=
+		 * valid input (or was forced by user)".=0A=
+		 */=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	} else if (chan->locked) {=0A=
+		/*=0A=
+		 * HO_ACQ is locked *and* holdover memory acquired, so it needs=0A=
+		 * the holdover-valid bit rather than following from the lock.=0A=
+		 */=0A=
+		if (chan->ho_valid)=0A=
+			*status =3D DPLL_LOCK_STATUS_LOCKED_HO_ACQ;=0A=
+		else=0A=
+			*status =3D DPLL_LOCK_STATUS_LOCKED;=0A=
+	} else if (chan->ho_freeze) {=0A=
+		*status =3D DPLL_LOCK_STATUS_HOLDOVER;=0A=
+	} else {=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	}=0A=
+=0A=
+	/* Report inner LOL as an error condition */=0A=
+	if (status_error && chan->inner_lol)=0A=
+		*status_error =3D DPLL_LOCK_STATUS_ERROR_UNDEFINED;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Mode=0A=
+ * =3D=3D=3D=3D=0A=
+ * enum dpll_mode differentiates how a DPLL selects an input: AUTOMATIC=0A=
+ * has the device pick the highest-priority one, MANUAL has userspace=0A=
+ * request one.  The device only implements the former through this=0A=
+ * driver, so AUTOMATIC is the only mode advertised.=0A=
+ *=0A=
+ * Free-run -- the outer loop disabled through PLL page reg 0x31[5] -- is=
=0A=
+ * not a mode in those terms, because no input is selected either way.  It=
=0A=
+ * is reported through lock status instead, and reached through the=0A=
+ * chip-specific tool rather than over netlink.=0A=
+ *=0A=
+ * The device could implement real MANUAL: MISCINNER_PLL (PLL page reg=0A=
+ * 0x18) bit 5 switches a PLL from priority-based to manual active select,=
=0A=
+ * and GPIO_INPUT_FUNC_CTRL5..8 (page 0, regs 0xE8-0xEB) bit 4 makes the=
=0A=
+ * choice come from the register's own low nibble instead of the GPIO=0A=
+ * pins, which pins one reference while the loop keeps running.  Wiring=0A=
+ * that up would let .state_on_dpll_set() accept CONNECTED; it needs bench=
=0A=
+ * validation first, and reg 0x18 carries GUI-generated configuration in=
=0A=
+ * its other bits, so it is left out until then.  Advertising MANUAL and=
=0A=
+ * then refusing the one request MANUAL exists for is the worse of the two=
=0A=
+ * incomplete answers, and after merge it would be ABI.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,=0A=
+		       enum dpll_mode *mode, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*mode =3D DPLL_MODE_AUTOMATIC;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_mode_set - put the PLL in automatic selection mode=0A=
+ *=0A=
+ * Clears the outer loop disable bit (PLL page reg 0x31[5]) and triggers a=
=0A=
+ * small update via reg 0x0F, so a PLL left free-running by the loaded=0A=
+ * configuration or by the chip-specific tool returns to selecting its=0A=
+ * reference from the priority table.  Any other mode is refused.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,=0A=
+		       enum dpll_mode mode, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc, restore_rc;=0A=
+	u8 status;=0A=
+=0A=
+	if (mode !=3D DPLL_MODE_AUTOMATIC) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; only automatic mode i=
s supported");=0A=
+		return -EOPNOTSUPP;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Read before writing.  Automatic is the only mode this driver=0A=
+	 * advertises, so userspace setting it again is a no-op the device=0A=
+	 * must not feel: without this, a redundant set followed by one=0A=
+	 * failed latch would restore an outer-loop disable the PLL never=0A=
+	 * had and put a running loop into free-run.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, sitdpll->id,=0A=
+				  SIT9531X_PLL_REG_STATUS, &status);=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to read PLL mode register");=0A=
+		goto unlock;=0A=
+	}=0A=
+	if (!(status & SIT9531X_PLL_STATUS_OUTER_DIS)) {=0A=
+		sitdev->chan[sitdpll->id].mode =3D 0;=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, sitdpll->id,=0A=
+				    SIT9531X_PLL_REG_STATUS,=0A=
+				    SIT9531X_PLL_STATUS_OUTER_DIS, 0);=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to write PLL mode register");=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
+	/* Trigger small update to apply without full NVM cycle */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, sitdpll->id,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The cleared disable bit was never latched.  Put it back so=0A=
+		 * the register does not read "outer loop enabled" for a loop=0A=
+		 * that is still free-running, which the poll would then hand=0A=
+		 * to the lock-status getter as a live mode.=0A=
+		 */=0A=
+		restore_rc =3D sit9531x_update_pll_u8(sitdev, sitdpll->id,=0A=
+						    SIT9531X_PLL_REG_STATUS,=0A=
+						    SIT9531X_PLL_STATUS_OUTER_DIS,=0A=
+						    SIT9531X_PLL_STATUS_OUTER_DIS);=0A=
+		if (restore_rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c outer loop left enabled without a latch: %d\n",=0A=
+				 'A' + sitdpll->id, restore_rc);=0A=
+		NL_SET_ERR_MSG(extack, "Failed to trigger small update");=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Keep the cached mode in step with the register.  The periodic=0A=
+	 * monitor refreshes it too, but the pin state getters and lock status=0A=
+	 * read this cache and would otherwise keep reporting free-run until=0A=
+	 * the next poll.=0A=
+	 */=0A=
+	sitdev->chan[sitdpll->id].mode =3D 0;=0A=
+=0A=
+unlock:=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_supported_modes_get(const struct dpll_device *dpll,=0A=
+				  void *dpll_priv, unsigned long *modes,=0A=
+				  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	__set_bit(DPLL_MODE_AUTOMATIC, modes);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+const struct dpll_device_ops sit9531x_dpll_device_ops =3D {=0A=
+	.lock_status_get	=3D sit9531x_dpll_lock_status_get,=0A=
+	.mode_get		=3D sit9531x_dpll_mode_get,=0A=
+	.mode_set		=3D sit9531x_dpll_mode_set,=0A=
+	.supported_modes_get	=3D sit9531x_dpll_supported_modes_get,=0A=
+	/* temp_get not available -- SiT9531x has no on-die temp sensor */=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Pin-state contract=0A=
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+ * The five pin ops tables below fall into three roles, and only the first=
=0A=
+ * has a selection state machine.  Each state_on_dpll callback implements=
=0A=
+ * the rules for its role and nothing else, so the tables cannot drift=0A=
+ * apart the way five independent encodings of this did.=0A=
+ *=0A=
+ * SELECTION role -- physical input pins, INTSYNC destination pin.=0A=
+ *   Where does this reference sit in this DPLL's selection process?=0A=
+ *   Predicates, all evaluated under multiop_lock:=0A=
+ *     M  source is present in THIS PLL's hardware priority table=0A=
+ *     A  chan->mode =3D=3D 0                      (outer loop running)=0A=
+ *     L  chan->locked && !chan->inner_lol     (only meaningful when A)=0A=
+ *     S  chan->selected_ref =3D=3D this pin's id=0A=
+ *   get:=0A=
+ *     CONNECTED     A && L && S && M=0A=
+ *     SELECTABLE    M && !(A && L && S)=0A=
+ *     DISCONNECTED  !M=0A=
+ *   set:=0A=
+ *     DISCONNECTED  remove from this PLL's table; a physical input also=
=0A=
+ *                   releases this DPLL's claim and powers the shared=0A=
+ *                   receiver down on the last release=0A=
+ *     SELECTABLE    add to this PLL's table; a physical input powers the=
=0A=
+ *                   receiver up and takes the claim, in that order=0A=
+ *     CONNECTED     -EOPNOTSUPP -- the device selects by priority and has=
=0A=
+ *                   no mode that pins one reference (see mode_set())=0A=
+ *     other         -EINVAL=0A=
+ *=0A=
+ *   A is what separates CONNECTED from SELECTABLE: chan->locked is derive=
d=0A=
+ *   from the outer loss-of-lock bit, which can read clear while the outer=
=0A=
+ *   loop is disabled, so a free-running PLL would otherwise claim its=0A=
+ *   reference as the active input of a loop that is ignoring it.=0A=
+ *=0A=
+ *   M is read from the hardware priority table, not from ref->pll_mask.=
=0A=
+ *   pll_mask is only the shared-receiver refcount and says nothing about=
=0A=
+ *   one DPLL's eligibility; it also drifts, because .prio_set writes the=
=0A=
+ *   table without touching it.  Signal quality is reported through the=0A=
+ *   pin's own attributes rather than by demoting the state, so a source=
=0A=
+ *   that is momentarily in LOS stays selectable.=0A=
+ *=0A=
+ * DRIVE role -- output pins, INTSYNC source pin.=0A=
+ *   Is this pin or net being driven?  Nothing is selected here, so:=0A=
+ *     CONNECTED     pin or net is driven=0A=
+ *     DISCONNECTED  pin is muted (Hi-Z), or this PLL does not drive it=0A=
+ *     SELECTABLE    -EINVAL on set, never reported by get=0A=
+ *=0A=
+ * FIXED role -- XO pin.  Always CONNECTED; it cannot be routed.=0A=
+ */=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
+				      void *pin_priv,=0A=
+				      const struct dpll_device *dpll,=0A=
+				      void *dpll_priv,=0A=
+				      enum dpll_pin_direction *direction,=0A=
+				      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*direction =3D DPLL_PIN_DIRECTION_INPUT;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * INTSYNC pin ops=0A=
+ *=0A=
+ * INTSYNC is the chip's inter-PLL sync net: one PLL drives it and other=
=0A=
+ * PLLs may lock to it instead of to an external reference.  The two=0A=
+ * roles are exposed as two separate pins so neither overloads the other:=
=0A=
+ *=0A=
+ *   - a source (output) pin registered on every DPLL.  Connecting it on a=
=0A=
+ *     DPLL makes that DPLL drive INTSYNC; only one DPLL may drive it at a=
=0A=
+ *     time.  It has no priority ops -- driving the net is not a reference=
=0A=
+ *     selection.=0A=
+ *   - a destination (input) pin registered on every DPLL.  Connecting it=
=0A=
+ *     on a DPLL makes that DPLL eligible to lock to INTSYNC as a=0A=
+ *     reference, so it carries the priority ops.=0A=
+ */=0A=
+=0A=
+/* ---- INTSYNC source (output) pin ---- */=0A=
+=0A=
+/* The INTSYNC source pin is an output; its direction_get is defined below=
. */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_direction *direction,=0A=
+				       struct netlink_ext_ack *extack);=0A=
+=0A=
+/* ---- INTSYNC destination (input) pin ---- */=0A=
+=0A=
+/*=0A=
+ * XO (crystal oscillator) pin ops=0A=
+ *=0A=
+ * The XO is the chip's internal reference oscillator that feeds every=0A=
+ * PLL.  It is exposed so userspace can see the on-chip reference, but it=
=0A=
+ * cannot be routed or disconnected, so it is reported permanently=0A=
+ * connected and offers no state_on_dpll_set / prio ops.=0A=
+ */=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_state *state,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
+};=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_direction *direction,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*direction =3D DPLL_PIN_DIRECTION_OUTPUT;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+};=0A=
+=0A=
+const struct dpll_pin_ops *=0A=
+sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	if (!sit9531x_dpll_is_input_pin(pin))=0A=
+		return &sit9531x_dpll_output_pin_ops;=0A=
+	if (sit9531x_dpll_is_xo_pin(pin))=0A=
+		return &sit9531x_dpll_xo_pin_ops;=0A=
+	return &sit9531x_dpll_input_pin_ops;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_changes_check - check for state changes and notify=0A=
+ *=0A=
+ * Called from sit9531x_dev_periodic_work().  Compares current hardware=0A=
+ * state against cached values and sends netlink notifications on changes.=
=0A=
+ */=0A=
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	enum dpll_lock_status lock_status;=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_dpll_lock_status_get(sitdpll->dpll_dev, sitdpll,=0A=
+					   &lock_status, NULL, NULL);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev, "Failed to get DPLL%u lock status: %d\n",=0A=
+			sitdpll->id, rc);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* If lock status changed, notify DPLL core */=0A=
+	if (sitdpll->lock_status !=3D lock_status) {=0A=
+		sitdpll->lock_status =3D lock_status;=0A=
+		dpll_device_change_ntf(sitdpll->dpll_dev);=0A=
+	}=0A=
+=0A=
+	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
+		const struct dpll_pin_ops *ops;=0A=
+		enum dpll_pin_state state;=0A=
+=0A=
+		/*=0A=
+		 * Poll input pins whose state can change autonomously: regular=0A=
+		 * references and the INTSYNC destination pin.  Outputs (incl.=0A=
+		 * the INTSYNC source) change only through their own set=0A=
+		 * callback and the XO is permanently connected, so skip those.=0A=
+		 * Each pin's own state_on_dpll_get resolves to the right getter.=0A=
+		 */=0A=
+		if (!sit9531x_dpll_is_input_pin(pin) ||=0A=
+		    sit9531x_dpll_is_xo_pin(pin))=0A=
+			continue;=0A=
+=0A=
+		ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+		rc =3D ops->state_on_dpll_get(pin->dpll_pin, pin,=0A=
+					    sitdpll->dpll_dev, sitdpll,=0A=
+					    &state, NULL);=0A=
+		if (rc)=0A=
+			continue;=0A=
+=0A=
+		if (state !=3D pin->pin_state) {=0A=
+			dev_dbg(sitdev->dev, "%s state changed: %u->%u\n",=0A=
+				pin->label, pin->pin_state, state);=0A=
+			pin->pin_state =3D state;=0A=
+			dpll_pin_change_ntf(pin->dpll_pin);=0A=
+		}=0A=
+	}=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h=0A=
new file mode 100644=0A=
index 000000000000..901aec238f4f=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/dpll.h=0A=
@@ -0,0 +1,69 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL subsystem interface=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * DPLL device and pin structures, and function declarations for=0A=
+ * the DPLL registration and callback layer.=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_DPLL_H=0A=
+#define _SIT9531X_DPLL_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/types.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+/* Per-pin DPLL state. */=0A=
+struct sit9531x_dpll_pin {=0A=
+	struct list_head		list;=0A=
+	struct sit9531x_dpll		*dpll;=0A=
+	struct dpll_pin			*dpll_pin;=0A=
+	dpll_tracker			tracker;=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	char				label[8];	/* "IN0", "OUT3" */=0A=
+	enum dpll_pin_direction		dir;=0A=
+	u8				id;		/* hardware index */=0A=
+	u8				prio;=0A=
+	enum dpll_pin_state		pin_state;=0A=
+	/* in 1/DPLL_PHASE_OFFSET_DIVIDER picosecond units */=0A=
+	s64				phase_offset;=0A=
+	bool				esync_control;=0A=
+	u64				esync_freq;	/* 0 =3D=3D disabled */=0A=
+};=0A=
+=0A=
+/* Per-PLL DPLL device state. */=0A=
+struct sit9531x_dpll {=0A=
+	struct list_head		list;=0A=
+	struct sit9531x_dev		*dev;=0A=
+	struct dpll_device		*dpll_dev;=0A=
+	dpll_tracker			tracker;=0A=
+	struct dpll_device_ops		ops;	/* per-instance copy */=0A=
+	struct list_head		pins;=0A=
+	u8				id;	/* 0 =3D PLLA .. 3 =3D PLLD */=0A=
+	enum dpll_lock_status		lock_status;=0A=
+};=0A=
+=0A=
+/* ---- DPLL allocation and registration ---- */=0A=
+/*=0A=
+ * The callback tables stay with the callbacks; the registration code that=
=0A=
+ * hands them to the subsystem lives next to probe() in core.c.=0A=
+ */=0A=
+extern const struct dpll_device_ops sit9531x_dpll_device_ops;=0A=
+const struct dpll_pin_ops *=0A=
+sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin);=0A=
+=0A=
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 =
ch);=0A=
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll);=0A=
+int  sit9531x_dpll_register(struct sit9531x_dpll *sitdpll);=0A=
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll);=0A=
+=0A=
+/* ---- Periodic change detection ---- */=0A=
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll);=0A=
+=0A=
+#endif /* _SIT9531X_DPLL_H */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index ae553bec0fd8..a892948da38d 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -49,7 +49,237 @@=0A=
  */=0A=
 #define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)=0A=
 =0A=
-/* Variant ID values (page 0 reg 0x02) */=0A=
+/* DCO trigger pulse timing: minimum 6 ns required by hardware */=0A=
+=0A=
+#define SIT9531X_REG_HOLDOVER_HISTORY	SIT9531X_REG(0x00, 0x58)=0A=
+=0A=
+/* Page 0 -- PLL inner loop loss-of-lock */=0A=
+#define SIT9531X_REG_PLL_INNER_LOL_STATUS	SIT9531X_REG(0x00, 0x92)=0A=
+#define SIT9531X_REG_PLL_INNER_LOL_NOTIF	SIT9531X_REG(0x00, 0x93)=0A=
+=0A=
+/* Page 0 -- Clock monitor PLL / XO status */=0A=
+#define SIT9531X_REG_CMON_NOTIF		SIT9531X_REG(0x00, 0x9E)=0A=
+=0A=
+/* Page 0 -- PLL outer-loop loss-of-lock */=0A=
+#define SIT9531X_REG_OUTER_LOL_STATUS	SIT9531X_REG(0x00, 0x06)=0A=
+#define SIT9531X_REG_OUTER_LOL_NOTIF		SIT9531X_REG(0x00, 0x07)=0A=
+=0A=
+/* Page 0 -- PLL holdover freeze status */=0A=
+#define SIT9531X_REG_HO_FREEZE_STATUS	SIT9531X_REG(0x00, 0x0A)=0A=
+#define SIT9531X_REG_HO_FREEZE_NOTIF	SIT9531X_REG(0x00, 0x0B)=0A=
+=0A=
+/* Page 0 -- INTSYNC (inter-PLL synchronization) global enable */=0A=
+#define SIT9531X_REG_INTSYNC_GLOBAL		SIT9531X_REG(0x00, 0x40)=0A=
+#define SIT9531X_INTSYNC_EN_BIT		6=0A=
+=0A=
+/*=0A=
+ * Priority table: 6 registers per PLL, each holds two priority slots=0A=
+ * nibble-packed.  The register holding slots 2n and 2n+1 keeps the=0A=
+ * earlier slot (CLK_SPARE<2n>SEL_PLL) in [7:4] and the later one in=0A=
+ * [3:0].=0A=
+ *=0A=
+ * Base registers for PLLA: 0x16-0x1B (slots 0-10 plus the=0A=
+ * active-reference nibble).=0A=
+ * For PLL N:  base + 6 * N  (e.g. PLLB starts at 0x1C).=0A=
+ *=0A=
+ * Input source encoding (4-bit value):=0A=
+ *   0=3DIN0P, 1=3DIN1P, 2=3DIN2P, 3=3DIN3P,=0A=
+ *   5=3DOCXO, 6=3DINTSYNC,=0A=
+ *   7=3DIN0N, 8=3DIN1N, 9=3DIN2N, 10=3DIN3N=0A=
+ *=0A=
+ * Codes 4 and 11 address a fifth input pair that this part does=0A=
+ * not have.  They read back as no valid reference.=0A=
+ */=0A=
+#define SIT9531X_PAGE_PRIOSYS		0x01=0A=
+#define SIT9531X_PRIO_BASE_REG		0x16=0A=
+#define SIT9531X_PRIO_REGS_PER_PLL		6=0A=
+#define SIT9531X_PRIO_SLOTS_PER_REG		2=0A=
+/*=0A=
+ * 11 priority slots, CLK_SPARE0SEL_PLL through CLK_SPARE10SEL_PLL.=0A=
+ * The twelfth nibble of the block is not a slot: it is=0A=
+ * CLK_ACTIVESEL_PLL, see SIT9531X_PRIO_ACTIVESEL_OFF below.=0A=
+ */=0A=
+#define SIT9531X_PRIO_MAX_SLOTS		11=0A=
+/* Number of source encodings (0-11), unrelated to the slot count */=0A=
+#define SIT9531X_PRIO_NUM_SRC		12=0A=
+#define SIT9531X_PRIO_NIBBLE_MASK		0x0F=0A=
+#define SIT9531X_PRIO_HI_SHIFT		4=0A=
+/* Input source encoding values (see table above) */=0A=
+#define SIT9531X_PRIO_SRC_OCXO		5=0A=
+#define SIT9531X_PRIO_SRC_INTSYNC		6=0A=
+#define SIT9531X_PRIO_SRC_N_BASE		7=0A=
+/*=0A=
+ * The last register of each PLL's priority block holds, in its low=0A=
+ * nibble, the input source the PLL has currently selected as its=0A=
+ * active reference (CLK_ACTIVESEL_PLL, same 4-bit encoding as above).=0A=
+ */=0A=
+#define SIT9531X_PRIO_ACTIVESEL_OFF		5=0A=
+=0A=
+/*=0A=
+ * Page 0 -- PRG_Directives_GENERIC_0, the main system's programming=0A=
+ * directive register.  Every page carries its own copy of this=0A=
+ * register at offset 0x0F with the same bit layout:=0A=
+ *=0A=
+ *   bit 6  proceed to loop lock / active state from the PRG_CMD state=0A=
+ *   bit 4  update the NVM bank from the efuse contents=0A=
+ *   bit 3  read the efuse into the volatile registers=0A=
+ *   bit 2  program the efuse=0A=
+ *   bit 1  small change update (SIT9531X_SMALL_UPDATE_CMD)=0A=
+ *   bit 0  escape to the PRG_CMD state=0A=
+ *=0A=
+ * The NVM bank is a volatile shadow, so bits 4 and 1 are both fine in=0A=
+ * a runtime path: bit 1 for a change made in the active state, bit 4=0A=
+ * to close a PRG_CMD sequence.  Only bit 2 writes non-volatile=0A=
+ * storage, and the driver never issues it.=0A=
+ */=0A=
+#define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
+#define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
+=0A=
+/* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
+#define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
+#define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
+#define SIT9531X_REG_IN_SEP_FORCE		SIT9531X_REG(0x02, 0xEA)=0A=
+#define SIT9531X_REG_IN_SEP_STATE		SIT9531X_REG(0x02, 0xEB)=0A=
+#define SIT9531X_REG_IN_SEN_FORCE		SIT9531X_REG(0x02, 0xF2)=0A=
+#define SIT9531X_REG_IN_SEN_STATE		SIT9531X_REG(0x02, 0xF3)=0A=
+=0A=
+/*=0A=
+ * One register per input pair at 0x1B + 0x10 * pair=0A=
+ * (CLKIN0 =3D 0x1B, CLKIN1 =3D 0x2B, CLKIN2 =3D 0x3B, CLKIN3 =3D 0x4B).=
=0A=
+ * SE_P_EN/SE_N_EN set means the corresponding lane is configured=0A=
+ * single-ended; both clear means the pair runs differential.=0A=
+ */=0A=
+#define SIT9531X_REG_IN_MODE(_pair)		\=0A=
+	SIT9531X_REG(0x02, 0x1B + 0x10 * (_pair))=0A=
+#define SIT9531X_IN_MODE_SE_P_EN		BIT(0)=0A=
+#define SIT9531X_IN_MODE_SE_N_EN		BIT(1)=0A=
+=0A=
+/* ---- Page 0x03 (Output System) registers -- Hi-Z control ---- */=0A=
+#define SIT9531X_REG_HIZ_DIFF_07_MASK	SIT9531X_REG(0x03, 0xF2)=0A=
+#define SIT9531X_REG_HIZ_DIFF_07_STATE	SIT9531X_REG(0x03, 0xF3)=0A=
+#define SIT9531X_REG_HIZ_DIFF_811_MASK	SIT9531X_REG(0x03, 0xF4)=0A=
+#define SIT9531X_REG_HIZ_DIFF_811_STATE	SIT9531X_REG(0x03, 0xF5)=0A=
+#define SIT9531X_REG_HIZ_SE_07_MASK		SIT9531X_REG(0x03, 0xF8)=0A=
+#define SIT9531X_REG_HIZ_SE_07_STATE		SIT9531X_REG(0x03, 0xF9)=0A=
+#define SIT9531X_REG_HIZ_SE_811_MASK		SIT9531X_REG(0x03, 0xFA)=0A=
+#define SIT9531X_REG_HIZ_SE_811_STATE	SIT9531X_REG(0x03, 0xFB)=0A=
+=0A=
+/*=0A=
+ * Output driver configuration.  Either CMOS enable means the output=0A=
+ * is wired single-ended -- one lane, or both driven as CMOS; with=0A=
+ * neither set it is a differential pair.=0A=
+ */=0A=
+#define SIT9531X_OUT_MISC0_BASE		0x1E=0A=
+#define SIT9531X_OUT_MISC0_STRIDE		0x10=0A=
+#define SIT9531X_OUT_CMOS_ENP		BIT(3)=0A=
+#define SIT9531X_OUT_CMOS_ENN		BIT(2)=0A=
+=0A=
+/*=0A=
+ * Output divider registers in Pages 3/4.  Each output has a 34-bit=0A=
+ * integer divider mapped to 5 bytes (LSB at base reg, MSB at base-4).=0A=
+ * Outputs 0-5 are on Page 3, outputs 6-11 are on Page 4.=0A=
+ *=0A=
+ * The base register for slot N within a page is:=0A=
+ *   clkout_odr_divn_base[slot] =3D { 0x14, 0x24, 0x34, 0x44, 0x54, 0x64 }=
=0A=
+ *=0A=
+ * Layout: base=3DLSB, base-1, base-2, base-3, base-4[1:0]=3DMSB.=0A=
+ *=0A=
+ * Per-chip clkout_map[] translates output index to slot position.=0A=
+ */=0A=
+#define SIT9531X_PAGE_OUTSYS0_SLOT_MAX	5   /* slots 0-5 on Page 0x03 */=0A=
+=0A=
+/* Misc output system registers */=0A=
+#define SIT9531X_REG_PRG_DIR_GEN		SIT9531X_REG(0x03, 0x0F)=0A=
+#define SIT9531X_PRG_CMD_STATE		0x01=0A=
+#define SIT9531X_UPDATE_NVM			0x10=0A=
+#define SIT9531X_LOOP_LOCK			0x40=0A=
+=0A=
+/* Debug register (same offset, per-page) */=0A=
+#define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
+#define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
+=0A=
+/*=0A=
+ * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
+ * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
+ * DIVO_PHASE_TRIG flushes the output phase when pulsed high then low.=0A=
+ * The unrelated OEb trigger pair in bits [7:6] must be preserved.=0A=
+ */=0A=
+#define SIT9531X_REG_GPIO_FUNC_CTRL1	SIT9531X_REG(0x00, 0x65)=0A=
+#define SIT9531X_DIVO_PHASE_SEL_REG	BIT(5)=0A=
+#define SIT9531X_DIVO_PHASE_TRIG	BIT(4)=0A=
+=0A=
+/* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */=0A=
+#define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
+=0A=
+/*=0A=
+ * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +=0A=
+ * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must =
not be=0A=
+ * reprogrammed at runtime; the register map flags them as=0A=
+ * "GUI generated configuration should not change manually".=0A=
+ */=0A=
+=0A=
+#define SIT9531X_PLL_REG_OUT_MAP_HI		0x27=0A=
+#define SIT9531X_PLL_REG_OUT_MAP_LO		0x28=0A=
+#define SIT9531X_PLL_REG_STATUS		0x31=0A=
+#define SIT9531X_PLL_REG_NVM_UPDATE		0x3F=0A=
+=0A=
+#define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
+#define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
+#define SIT9531X_PLL_REG_ZDB0		0x2B=0A=
+#define SIT9531X_PLL_REG_ZDB1		0x1E=0A=
+#define SIT9531X_PLL_ZDB_EN_BIT		BIT(4)  /* zero-delay buffer enabled */=
=0A=
+=0A=
+/* PLL STATUS register bits */=0A=
+#define SIT9531X_PLL_STATUS_LOCK		BIT(0)=0A=
+#define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
+=0A=
+/*=0A=
+ * Per-PLL status register.  HO_VALID says the holdover window holds a=0A=
+ * valid frequency estimate, i.e. holdover memory has been acquired; it is=
=0A=
+ * not the same as HO_FREEZE (page 0, reg 0x0A), which says the PLL has=0A=
+ * already switched over to holdover.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_STATUS_1		0x06=0A=
+#define SIT9531X_PLL_STATUS_1_HO_VALID	BIT(2)=0A=
+=0A=
+/* P-polarity status registers */=0A=
+#define SIT9531X_CLKMON_P_STATUS_01		SIT9531X_REG(0x06, 0x02)  /* inputs 0=
,1 */=0A=
+#define SIT9531X_CLKMON_P_NOTIF_01		SIT9531X_REG(0x06, 0x03)=0A=
+#define SIT9531X_CLKMON_P_STATUS_23		SIT9531X_REG(0x06, 0x06)  /* inputs 2=
,3 */=0A=
+#define SIT9531X_CLKMON_P_NOTIF_23		SIT9531X_REG(0x06, 0x07)=0A=
+=0A=
+/* N-polarity status registers */=0A=
+#define SIT9531X_CLKMON_N_STATUS_01		SIT9531X_REG(0x06, 0x92)  /* inputs 0=
,1 */=0A=
+#define SIT9531X_CLKMON_N_NOTIF_01		SIT9531X_REG(0x06, 0x93)=0A=
+#define SIT9531X_CLKMON_N_STATUS_23		SIT9531X_REG(0x06, 0x96)  /* inputs 2=
,3 */=0A=
+#define SIT9531X_CLKMON_N_NOTIF_23		SIT9531X_REG(0x06, 0x97)=0A=
+=0A=
+/* Per-input bit offsets within clock monitor nibble */=0A=
+#define SIT9531X_CLKMON_FREQ_FINE		0  /* bit 0 / bit 4 */=0A=
+#define SIT9531X_CLKMON_FREQ_COARSE		1  /* bit 1 / bit 5 */=0A=
+#define SIT9531X_CLKMON_CLK_LOSS		2  /* bit 2 / bit 6 */=0A=
+#define SIT9531X_CLKMON_CLK_LOSS_FD		3  /* bit 3 / bit 7 */=0A=
+=0A=
+/* ---- Debug / NVM unlock registers ---- */=0A=
+#define SIT9531X_REG_DBG_UNLOCK1		0x24=0A=
+#define SIT9531X_REG_DBG_UNLOCK2		0x25=0A=
+=0A=
+/*=0A=
+ * EEPROM profile load, page 0.  The device compares the CRC stored in the=
=0A=
+ * EEPROM against the one it computes from what it read; a mismatch means=
=0A=
+ * the profile on the part is not the profile the board expects.=0A=
+ * NOTIFY_4 collects the read-done bit and the defect bits, all sticky, so=
=0A=
+ * a healthy load leaves exactly the read-done bit set.=0A=
+ */=0A=
+#define SIT9531X_REG_REC_CRC		SIT9531X_REG(0x00, 0x8A)  /* 4 bytes, MSB fi=
rst */=0A=
+#define SIT9531X_REG_CAL_CRC		SIT9531X_REG(0x00, 0x8E)  /* 4 bytes, MSB fi=
rst */=0A=
+#define SIT9531X_REG_EEPROM_NOTIF		SIT9531X_REG(0x00, 0x97)=0A=
+#define SIT9531X_EEPROM_READ_DONE		BIT(0)=0A=
+=0A=
+/* Profile identifier the loaded configuration carries, page 1, 24 bits */=
=0A=
+#define SIT9531X_REG_PROFILE_ID		SIT9531X_REG(0x01, 0x44)  /* 3 bytes, LSB=
 first */=0A=
+=0A=
+/* ---- Variant ID values (single byte read from SIT9531X_REG_VARIANT_ID) =
---- */=0A=
 #define SIT9531X_VARIANT_ID_95317	0x17=0A=
 #define SIT9531X_VARIANT_ID_95316	0x31=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
