Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFD419FD4;
	Mon, 21 Sep 2026 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021496; cv=fail; b=TznVxqK2RytIbDUvuIwrP4QVUORdOK91AaKlDj4SpSjd6Kx9Zuqu2Bmt9BT/eDApB9WCrIdJkVXkjpEuK0XmSLY6xjxt5zNUrXkiUWt+A7HdBmfehpnGIpmV3p6Vj+T1Uks1k2Ad8sjsCIlsHhYL+ilUJlWqM3sxzaM9aCOrd7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021496; c=relaxed/simple;
	bh=yLEvwUkGiUs6XchtEln25K7M1n7JsDtIbM3gtrOfb8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IApRb2WZfcCmF7Q4TpFPSf54uw0BEacglAewsMsrpWXTFoGv82FQLeXSi6RTlO4Kmq93FLbgE/AovDzcb2FCvURrOuSy35yGgkm0S0TciouTAplUNmrNRlV8EzXkdUG+IqaqnS+1c0vtcT9mcI/WMmm/3qTU/01XbE9u2h361/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=dGv5kM6M; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=XytcOP1w; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="dGv5kM6M";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="XytcOP1w"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D6896605BD5;
	Mon, 21 Sep 2026 20:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=LDw03ThZQMGggm7Q0WlIZtW8kD0gYkhaTNCRK8m+R7o=;
 b=dGv5kM6M6fM3cIe23Ad8L+2N4TJqkurOxqfQ4Fk/tTTYwWjQ/AGgsuZ3dbPvhIu3RbTFgnVf/Xen2Fw9W3zC4WVLHxUq99g2Bg7+uhtegA47xTFIve0PJEEatvkWRY1ubzCfsL7v+WqqRNMHeawRdZkurumy3fVJDjMZSvwW85qIxJjq3C4YrJip+YSxdwmGzE34bOgo8CpEHmn95OXRUDwvyOqJRKMgv84HB3zN5TpprCc7L4uR7qlcOGTSrE43arDuedj/xX9LHCXl6npT47lM8GSsdS03gmd4in4rc25ud/j+ZNnBhsUqXJqoFdiVAdgBDYwygF/qks46pH6VIw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020131.outbound.protection.outlook.com [52.101.193.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id ACFA49C00A3;
	Mon, 21 Sep 2026 20:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb8x7s/1L8tvrXlFjNHooQlpTLfSV1Z4zLyVuap3hvEeOQMNK2evytLNAJVmWMbBG9YS4CEaNXmjaVBVjdInDTeE5Auh+AeclTjmp0MVftrDUwFJ7xv3oewe0n6M2nnUHafKUTJhiMXDym7Jm1CEayNMYPOO0itVZrXbELfJadQMUOajYsHBWUvkYsGPiPdXYbZOkeD9EkJFE1GnN0lKbT59tq7o1hn62wz1keVdQsbGrpFjDXQ//XloJzPKu2L8kLJcpv04C7HbMVp2oPWq9R6ekwbnGLgKArcp0/SS00k78XkPyWvw3AUNulrzQRToifkULMXZZe4wSwFgc0cX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDw03ThZQMGggm7Q0WlIZtW8kD0gYkhaTNCRK8m+R7o=;
 b=rX4PpUtTtVFYApFTXvVv/La0CYQtepaXm99mn1fXWF670kebZSCz43WX0tl14cvVU050qTcFRVz+yToFH9vDuyqG4rAVsqGF3669M00hYoLn3+EvGq0tsSkZeBqcvAr4bEslfgwZug9K8IQKYCFY654O+47NvtmXZHLHsfs1MIhCdghm1MgsOFAHG6yGD6aJoggm2mlFA0Lf/joBjT+7aBKmaiR7Q6C3Benwy56zdKByJB80ZDoVjoGGuObU61MGPCCY/QJPzC/uEL8PyGTtDH/kTMTPTBAaJqLwh5qfjg1h0BcgJiONcOfkFiqGOadnk7dC12KRYGa8A7nbQy8p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDw03ThZQMGggm7Q0WlIZtW8kD0gYkhaTNCRK8m+R7o=;
 b=XytcOP1wd46pGX0VcCu28sR8DJtY/7Bhf2jfBLUjhjVgam16nxgc9W4imnj/OM8ur4mlhkGZS4YT9azAqWwkGKyZ4U5/nlFXNfVeXbUk0+HLFpzB8y9dnLKw8xIsiV0tGO9Lh7qyA04o081/Z4THyNAVyNjOnW6Na008O/zGyX+AW4Lb2QjuwA4DzBIfumccqXggsIi4eXY+dg+kjrYkqysuGQId2HI4hjBjXPfROs8euRmj2+B1z+OyCTlGKFPgZZP18LV6an/959tOtkqo4Gcga+DGYFB9QcG69P1FKZJSKgx3pIh274f75nGX+hPfsew8zdbbzh1V4tWyJb9Pnw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:18 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:16 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH v10 11/14] dpll: sit9531x: add support to get phase offset on
 the connected input pin
Thread-Topic: [PATCH v10 11/14] dpll: sit9531x: add support to get phase
 offset on the connected input pin
Thread-Index: AQHdSgVbHwp6KF+VJk2YLltZIPwt5g==
Date: Mon, 21 Sep 2026 20:11:16 +0000
Message-ID: <20260921201108.42676-12-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
In-Reply-To: <20260921201108.42676-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS3PR20MB7783:EE_
x-ms-office365-filtering-correlation-id: 6f0acf9c-ad1f-4316-792a-08df181c7e4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 Wpiy/saHS79w9pz7FDLk/JjXRt1F+k51vEXyyr+a1eeVsj8/kdcZnUHpkHyiBxlXDfX6eiVWVVvyIQLqFU3+Wd5j2Dw2R/GlMu8MMchKMhqVYBNfZDFidMdDyChHw1pr0EQrGOL2GLMAufH0NYoNK5LgEsoBHJlsqRF+KmUdsK2bpgmfbATqVTLhgQ/hoB59NbvFbCFDBFPlvRne3KgRJLvY7KTh24anUjWuLzm9HTxjwEoNw2kSB2uTaj7vLXW2ZYScF4nIEbEweif2EVZ58RTyTR9GqAToIOOjkFXK8rN1yzBFUxhySsakVHdT13upAGFfbgAo19m2FH2JL1CPxx7Zu/jE0OWO6d0lDGVBc2kKQZhsRZnWwkTmyn54kqFxehniLGZ1Z+L6gijjBW11DzhoFqo/yZ2jR3UJ48Nlc/YX91CgGEcafYPMqtdxY8DP2GzwTXgkWeXn2m86ydAzUsqMze0EDo+htWi26L7wOhvMNI3PIFQ5cmHwYW12rBhlCDRpmR20HPGayln4W1d+c7cn2w8mULKPkaCXP1SacEMLR7o0KtLj248L216Y+cLzHU8MdE8DMP1aRT5i9wd/nxKkY7hvVLXtZDL0LVwJvauhswRUb2ciXNwK0XpPHsi2Y9sqeEp4ZvONkvVe71W+PNxE36zlS4oQbXBX2bGpWZcEVRxc0spDc88jOhePWvMtNBxIh0E3YfqbcFPslVfxDfWQ/NMc2bZPbey+PdNq0/U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gpsJpZGEkyXWlYTIGvmFFUp1CqMlq3tLEW0jxHpl6h4TdxxZuSGfBOndzI?=
 =?iso-8859-1?Q?FhIGhp6zb3W50D1Qw7fNQ2MhJCfisdw5bdRgApOaLLxJ8DwkGNU93gQJlQ?=
 =?iso-8859-1?Q?/D3UE8wrCGj7kZwOvueXLoeAgRA3mc6dEAwHHO6fpteNZ0TvGvdHOw8ikZ?=
 =?iso-8859-1?Q?BJ/UXhX2hLNf2fS2lPBfXBe2Kobz/psUgj063Ftgo68Go+Gg5EclrSuZ0c?=
 =?iso-8859-1?Q?mj79TbR/XEGLuPPEtMwFL83SMirslDLJNT25oJUbgm8unrv2Id1QWzRKrp?=
 =?iso-8859-1?Q?6H7cdfavhGK5Ou4wdkvg+12jdGpYUu5ygDimSPZMFqemA79vineBhlkURR?=
 =?iso-8859-1?Q?QcHTOgEBygnubQqfZBoICyTjqgbg6cezRc1B0f9rIpnF0PiX8rCFXc/NMd?=
 =?iso-8859-1?Q?7xHnQVEu057Za4KNWXMSWaXLxaqpYHV6MY58R2KgzN03OC5jDMuwuemtZU?=
 =?iso-8859-1?Q?NQXr11ZA7Kngw45ffu6BFoFPqIo8qpCPjqnLnbOvqyCmQxrY5f7Jt5e/OS?=
 =?iso-8859-1?Q?SAQm32UoGMPK/lTDvqN1I7twfJ9eICgrTSdET2wmqt5wQ5YUqnN30dyI0Y?=
 =?iso-8859-1?Q?NXt3WXef30uPP98TI2H3A46McsAueohnNlhX3kqwVs9OpF9veAVKiooHss?=
 =?iso-8859-1?Q?qBgN+4eHggL/W1I8bBFCjLD4qAqSoUoc0nEAWhYBfb0qta3bQpy23zGGMH?=
 =?iso-8859-1?Q?4IJO+ICz++C74f3iD+Cg6SV6QmpRN4JqHv/BGtJrqquKyhuK+amR7XO2TZ?=
 =?iso-8859-1?Q?EgR5zlCXB1ID72GStmTq/rMbxhqKZw0c2aYquu/PFqE5aLshfrtzkxxLjN?=
 =?iso-8859-1?Q?M8okVZ+8/0TmGsXvdfde/Ykc0rR9gcS63gG//Nmgj3PGeRRsFxKnXnon+7?=
 =?iso-8859-1?Q?hwV2jrxuUFj802Ek4sUG0Dr8EgMzXOyqYdrgZmdQw8MiVOXKyS5ZjriPq4?=
 =?iso-8859-1?Q?QxJUE4Ud3iUODvJlNbuo5tWCW8jLIQ+FuSai3hRktw5dkUjWKCikrYYtF7?=
 =?iso-8859-1?Q?70TXoGZ+th92Dqi5sBId1HkrlVYD1Xjy2t0NOW0/dymCSD4kOTPXpYjXqE?=
 =?iso-8859-1?Q?1lnguSI/dvfDxkrrqb/xStQ7NyBDEEzQmkgykjVAGw+g/pTR6AqPnGDYBv?=
 =?iso-8859-1?Q?CzYvencGsd6+RHOyvm4VJ/nbnBxiBWjzZ2IGu5rJKIv+TW72ZQXM/4DNxE?=
 =?iso-8859-1?Q?muUEJusL1CR//gcrHpECDeL7kYKxsQ6xKgRxttriSHn4GqEv06ocE94jKs?=
 =?iso-8859-1?Q?shP4XI4Hp65G0TfxsOw+olTM5jqw+Cc7Np6xDMrNSp52913yFom9ykumop?=
 =?iso-8859-1?Q?rwgUgYe2jj+tGwlHlP7viXPjEWwrmqAk5Juo1OciUMKyDjt1/YNfiBPISq?=
 =?iso-8859-1?Q?wXjVBGB68lraerjMcUqmDiKvyao2Ykr6FsTXTYNNk6lUIflmYLnzAyn6Bw?=
 =?iso-8859-1?Q?kPHFvoWW8gcUlHigXH+c9s8cqlZfqRY2b2wm9uB8nu2q27vH4IacUsrZkN?=
 =?iso-8859-1?Q?QtVAUoShgx0zdiIUchZzTt+kYo/QhbqhzvUWoVwLsqC+gNlpVkEv8NaYWL?=
 =?iso-8859-1?Q?Q3g2gh2t0WKDkHI+qjCM7rkkjwpZW6ZaFJSgIVAGvyekvLDKgH4NQJ1HHb?=
 =?iso-8859-1?Q?QRgaUg4L8Ko6QFoN/l74850KV4bimqAYzioqa2hUzcLObXLzaJcF7Rm3Y/?=
 =?iso-8859-1?Q?BC4rMIen3fVe4hv9r6GuzxycML03rh/IqyFX3OeW+1M/xeWw7RrJ8JirZx?=
 =?iso-8859-1?Q?RqDj19Df76DgS5B0CAaw93GE/iEhy1voYmKQlsIDrPieT6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vhA34aUP9zhF0eEVmEOteRYgKSE+oWXZ+3ys7kVFj9kgylYQGRggrNnXhgCZEYuYTeZK/lp4F4iQyxPmEQ+VehhH44OqKXgjYVZ3D4Dp+yjr40hUU+jPL87prYh5E1DjL+pgdkC1AiEZLoGa3Ogtev6UPt/ZUR71qg+DMOvmsSBb2nUaEsLHb6jip/Tr1c6Qkm7qetHdu3QCW+F9AeR37KwDYHHLuyAdS8OC1UOxIE00pFTGJcN7yijDYcKy3cn521K88hwjsmSkqWIHtSuxV77xpJan682Btkb/bEGG7V9pW/7FYldmN+sKmNGEUlE6BrVQRzmJISv60B22J2MW+A==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0acf9c-ad1f-4316-792a-08df181c7e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:16.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nkzat2WptAif/yKZuFVmwPRz4Kb24ST5J/btStik4GhtYfsx7iWYDbb5cAfub3N8SQ/IH9vNzFsso+tEQEb3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021481-sWedNIvcM5Lx
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021481;sWedNIvcM5Lx;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report the phase difference between a PLL's reference and the PLL itself,=
=0A=
which is the loop's own residual error and therefore trends small on a=0A=
locked device -- that is the measurement, not an artefact of it.=0A=
=0A=
The value comes from the on-chip time-to-digital converter, read through=0A=
the debug window: unlock the window, point it at the converter, then read=
=0A=
the trigger register, which latches a fresh sample and returns the=0A=
previous one.  It is read three times per sample for that reason; a single=
=0A=
read hands back the sample from the last call, so a repeated measurement=0A=
would look perfectly steady while saying nothing.=0A=
=0A=
Only the input a PLL has actually selected has a phase offset against it.=
=0A=
For any other pin there is nothing to measure and zero is reported,=0A=
because the core abandons an entire pin dump on an error from any one pin.=
=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Gave the dormant-PLL case its own errno, so a bus error is not reported=
=0A=
    as a valid zero reading.=0A=
    =0A=
    Read the selected reference from the device for the measurement rather=
=0A=
    than from a cache up to a poll period old.=0A=
    =0A=
    Restored the debug tap selection the read changes, and dropped the=0A=
    cached per-pin phase offset, which was written on every path of the=0A=
    getter and read on none.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 215 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |   4 +=0A=
 drivers/dpll/sit9531x/dpll.c | 118 +++++++++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  36 ++++++=0A=
 4 files changed, 373 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index c8c3cd6a64ba..8f6f8ffc8dc1 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -2314,6 +2314,221 @@ int sit9531x_clear_notifications(struct sit9531x_de=
v *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * sit9531x_chan_selected_ref_read - read a PLL's active reference now=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @ref:	result, logical input index of the selected reference=0A=
+ *=0A=
+ * chan->selected_ref is refreshed by the monitor twice a second, which is=
=0A=
+ * close enough for reporting pin state but not for attributing a=0A=
+ * measurement: the device picks its own reference, so a sample taken now=
=0A=
+ * can belong to a pin the cache has not caught up with.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+int sit9531x_chan_selected_ref_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *ref)=0A=
+{=0A=
+	u8 activesel_reg, input_sel;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
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
+	*ref =3D sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_phase_offset_read - read phase difference via TDC=0A=
+ * @phase_ps:	output phase difference in picoseconds=0A=
+ *=0A=
+ * Reads the Time-to-Digital Converter (TDC) signed 35-bit code from the=
=0A=
+ * PLL page registers, then converts to picoseconds using the VCO=0A=
+ * frequency: phase_diff =3D tdc_code / fvco.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps)=0A=
+{=0A=
+	u8 v, old_write_code, old_read_code;=0A=
+	bool have_old =3D false;=0A=
+	int rc, lock_rc, i;=0A=
+	u64 fvco, mag_ps;=0A=
+	s64 tdc_signed;=0A=
+	u64 tdc_raw;=0A=
+	bool sign;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* Unlock the debug page so the TDC registers are accessible. */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Remember the tap selection so it can be put back.  The key=0A=
+	 * register is re-locked below, but the mux is not part of the key:=0A=
+	 * leaving it parked on the TDC with a slow sampling clock selected=0A=
+	 * is a state change the caller did not ask for, and the next reader=0A=
+	 * of a different tap would have to know to undo it.=0A=
+	 */=0A=
+	if (!sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				  &old_write_code) &&=0A=
+	    !sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				  &old_read_code))=0A=
+		have_old =3D true;=0A=
+=0A=
+	/*=0A=
+	 * Select the debug clock for taps below 200 kHz, then point the=0A=
+	 * readback at the TDC.  Only the one bit is touched: writing the=0A=
+	 * modifier register whole would clear the fields belonging to=0A=
+	 * other taps.=0A=
+	 */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				   SIT9531X_DBG_READ_CODE_TDC);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Latch a sample by reading the trigger register.  A single=0A=
+	 * read returns the previous latch, so read it three times as=0A=
+	 * the documented phase-difference procedure does.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_LATCH_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	tdc_raw =3D 0;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_4, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	sign =3D !!(v & BIT(SIT9531X_TDC_SIGN_BIT));=0A=
+	tdc_raw =3D (u64)(v & SIT9531X_TDC_MAG_HI_MASK) << 32;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_3, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 24;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_2, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 16;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_1, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 8;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_0, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D v;=0A=
+=0A=
+	/*=0A=
+	 * Apply sign.  Per the register map the sign bit is active-high=0A=
+	 * for a positive offset: bit set -> +code, bit clear -> -code.=0A=
+	 */=0A=
+	tdc_signed =3D sign ? (s64)tdc_raw : -(s64)tdc_raw;=0A=
+=0A=
+	/*=0A=
+	 * Get VCO frequency for conversion.  -ENODATA means DIVN is not=0A=
+	 * programmed (PLL unused on this board) -- skip silently rather=0A=
+	 * than spamming the log on every poll cycle.  It is passed up as=0A=
+	 * itself rather than as -ENODEV, which the I2C layer produces for=0A=
+	 * an adapter that has gone away: the caller turns the dormant-PLL=0A=
+	 * case into a zero reading, and a bus failure must not take that=0A=
+	 * path.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc) {=0A=
+		if (rc =3D=3D -ENODATA)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"PLL%c: Fvco unknown, skip TDC\n",=0A=
+				'A' + pll_idx);=0A=
+		goto relock;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * phase_diff (seconds) =3D tdc_code / fvco=0A=
+	 * phase_diff (ps) =3D tdc_code * 1e12 / fvco=0A=
+	 *=0A=
+	 * mul_u64_u64_div_u64() keeps the exact Hz denominator; dividing=0A=
+	 * by whole MHz instead would lose up to ~40 ppm of scale on a=0A=
+	 * fractional-DIVN Fvco.=0A=
+	 */=0A=
+	mag_ps =3D mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,=
=0A=
+				     1000000000000ULL, fvco);=0A=
+	*phase_ps =3D tdc_signed < 0 ? -(s64)mag_ps : (s64)mag_ps;=0A=
+=0A=
+	rc =3D 0;=0A=
+=0A=
+relock:=0A=
+	if (have_old) {=0A=
+		sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				      SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				      old_read_code);=0A=
+		sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				      SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				      old_write_code);=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Close the debug window again.  The key register opens every debug=0A=
+	 * register on this PLL while it holds the unlock value, and this read=0A=
+	 * runs on every pin-get of a connected input, so leaving it open=0A=
+	 * would mean normal monitoring permanently unlocks the block.=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					SIT9531X_PLL_REG_DEBUG,=0A=
+					SIT9531X_PLL_DEBUG_LOCK);=0A=
+	if (lock_rc && !rc)=0A=
+		rc =3D lock_rc;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
  * @index:	logical input index=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 7848ac9bd6ca..f2750c319ff3 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -289,6 +289,10 @@ int sit9531x_clear_notifications(struct sit9531x_dev *=
sitdev);=0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
+int sit9531x_chan_selected_ref_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *ref);=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps);=0A=
 =0A=
 /* ---- State helpers ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index af1089f192b6..5f7c2d01562c 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -638,6 +638,123 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pi=
n *pin, void *pin_priv,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference=
=0A=
+ *=0A=
+ * What this reports, and what it deliberately does not:=0A=
+ *=0A=
+ * The ABI defines the attribute as the phase difference between the signa=
l=0A=
+ * on a pin and its parent DPLL device, so this is the loop's own residual=
=0A=
+ * error, sampled with the loop closed.  On a locked DPLL it therefore=0A=
+ * trends small -- that is the measurement, not an artefact of it.  The=0A=
+ * documentation describes the reported value as one that may be averaged=
=0A=
+ * over prior measurements, which suits a closed-loop residual and not a=
=0A=
+ * one-shot open-loop capture; the core publishes whatever this callback=
=0A=
+ * returns, so the averaging, if any, would be this driver's to do.=0A=
+ *=0A=
+ * The chip can also measure the reference against the local oscillator=0A=
+ * with the outer loop's correction frozen, which is a different quantity=
=0A=
+ * and the one the documented phase-difference procedure produces.  That=
=0A=
+ * needs the digital loop filter held (and, on the 1PPS PLL, the automatic=
=0A=
+ * phase- and frequency-lock helpers held off), which leaves the PLL=0A=
+ * undisciplined until it is released.  A netlink read must not do that,=
=0A=
+ * so that measurement is not offered here at all; it belongs to a caller=
=0A=
+ * that can own the freeze and restore it.=0A=
+ *=0A=
+ * Precondition, which this callback cannot create: the TDC compares=0A=
+ * against a signal the PLL drives, so a PLL driving no output with its=0A=
+ * zero-delay buffer off has nothing to measure.  SiTime confirms this is=
=0A=
+ * a property of the hardware rather than of their measurement script.=0A=
+ * The script satisfies it by mapping a spare output and restarting the=0A=
+ * PLL -- side effects that do not belong in a getter, so a reading taken=
=0A=
+ * in that state is simply not meaningful.=0A=
+ *=0A=
+ * Non-selected pins and a PLL with no programmed divider report zero=0A=
+ * rather than an error: the DPLL core propagates any error from this=0A=
+ * callback and fails the whole pin dump with it, unlike the frequency=0A=
+ * offset getter, where -ENODATA makes the core omit the attribute.  There=
=0A=
+ * is no per-pin "no data" for phase offset, so it is a value or no=0A=
+ * callback at all.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,=0A=
+					 void *pin_priv,=0A=
+					 const struct dpll_device *dpll,=0A=
+					 void *dpll_priv, s64 *phase_offset,=0A=
+					 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	enum dpll_pin_state state;=0A=
+	s64 offset;=0A=
+	u8 selected;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The on-chip TDC is a per-PLL resource that always measures the=0A=
+	 * phase difference between the VCO and the PLL's currently=0A=
+	 * selected reference; it cannot be pointed at an arbitrary input.=0A=
+	 * For any input that is not the active reference there is no=0A=
+	 * meaningful per-pin phase offset, so report 0 instead of the=0A=
+	 * active reference's value.=0A=
+	 */=0A=
+	/*=0A=
+	 * Which pin the sample belongs to is read from the device rather=0A=
+	 * than taken from the monitor's cache: the device selects its own=0A=
+	 * reference, so a cache up to a poll period old could attribute a=0A=
+	 * live measurement to the pin that used to be selected.=0A=
+	 */=0A=
+	rc =3D sit9531x_chan_selected_ref_read(sitdev, sitdpll->id,=0A=
+					     &selected);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Selected reference could not be read back");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, &state);=0A=
+	if (state !=3D DPLL_PIN_STATE_CONNECTED || selected !=3D dpin->id) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * -ENODATA means the PLL has no programmed DIVN (unused on this=0A=
+	 * board); report phase_offset =3D 0 so a full pin-get dump does not=0A=
+	 * fail just because one DPLL is dormant.  Every other errno,=0A=
+	 * -ENODEV from a vanished adapter included, is a failure.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENODATA) {=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "TDC phase readback failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The ABI reports phase offset in units of 1/DPLL_PHASE_OFFSET_DIVIDER=
=0A=
+	 * picoseconds: the integer part of the attribute is the value divided=0A=
+	 * by the divider, the remainder is the fraction.  The TDC resolves one=
=0A=
+	 * VCO period (hundreds of picoseconds), so the fractional digits are=0A=
+	 * always zero here, but the magnitude still has to be scaled or every=0A=
+	 * reading would be reported a thousand times too small.=0A=
+	 */=0A=
+	offset *=3D DPLL_PHASE_OFFSET_DIVIDER;=0A=
+=0A=
+	*phase_offset =3D offset;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
@@ -645,6 +762,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_ops =3D {=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index cbce62404c97..a9731c360bc0 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -255,6 +255,42 @@=0A=
 #define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
 #define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
 =0A=
+/* Debug register unlock */=0A=
+#define SIT9531X_PLL_REG_DEBUG		0xBD=0A=
+#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3=0A=
+#define SIT9531X_PLL_DEBUG_LOCK			0x00=0A=
+=0A=
+/*=0A=
+ * Signal pathway debug readback -- PLL page.  Dig_Sys_ReadCode selects=0A=
+ * which point of the pathway is tapped, Dig_Sys_WriteCode carries the=0A=
+ * modifiers for that read, Dig_Sys_read7..read0 hold the sampled bytes=0A=
+ * and the trigger register latches a sample.  The TDC phase=0A=
+ * measurement is one tap among several, reached through read code 69.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_READ_CODE	0xB3=0A=
+#define SIT9531X_PLL_REG_DBG_WRITE_CODE	0xB4=0A=
+#define SIT9531X_DBG_LOW_FREQ_CLK_BIT	BIT(7)=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_0		0xB5  /* [7:0] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_1		0xB6  /* [15:8] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_2		0xB7  /* [23:16] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [34:32] + sign */=0A=
+/* read to latch a sample */=0A=
+#define SIT9531X_PLL_REG_DBG_TRIGGER		0xD0=0A=
+=0A=
+/*=0A=
+ * Reads of the trigger needed to latch a fresh sample.  One returns the=
=0A=
+ * previous latch, which the documented procedures work around by reading =
it=0A=
+ * three times.=0A=
+ */=0A=
+#define SIT9531X_DBG_LATCH_READS		3=0A=
+#define SIT9531X_DBG_DATA_BYTES		8=0A=
+=0A=
+/* Read code of the TDC phase tap, and the sign bit of its sample */=0A=
+#define SIT9531X_DBG_READ_CODE_TDC		69=0A=
+#define SIT9531X_TDC_SIGN_BIT		3=0A=
+#define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)=0A=
+=0A=
 /*=0A=
  * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
  * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
-- =0A=
2.43.0=0A=
=0A=
