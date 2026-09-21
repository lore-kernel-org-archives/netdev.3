Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D119375ADD;
	Mon, 21 Sep 2026 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021482; cv=fail; b=NO+2hf34Fe8+3paBwkQsvOYfpBjfUEckHymoczGux83L5gHinOE0IQsbhdKrXaqshF20nDjLqKlxstbSFAqR8pj8gteIk/2VhYkXGwsNmsCPbhcc2NbPnJy4yIxXnRX+GiSG33DyTpWtwI4W5N+3CmhzIHPBxnf3a53SeUB9qd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021482; c=relaxed/simple;
	bh=m1qXU2ok8rgpr1PZgllcy/zDsoyWe9moYsHD5wTBWkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E4JQwkwvppkpJOM1+d6JQZVgBDaur8a9Vvhj7M1N5MQtRfOAJiszePT5vomKg7VY6x65G/jqJLDVsUQq53HCBasheS97xLw1jPKXV/hbOrCzIIJj3XTbWEypmtnD7AEOdjZxCJoLqnXFkj7PyEppslNYubPAz5WMOkEbYbi5PY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=RZKifbV4; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=A7rt6DNQ; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="RZKifbV4";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="A7rt6DNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=Id8Htlr+xtz2y5JV1r/XgGOzhssnFx5tpX2TTB/doiw=;
 b=RZKifbV4S8wzIvW70uAlP+nEb/V1n/8GlHYv5uz8WInGptfzQruPGG88kcsws+KmBZTSmZOUAY8vsMoBetfqHWjjfYuNsIXc5hADG7udm3z2RtJIcuyUrHxSLK7CM3PL8HGSxK2+A6yRxTC9IaM0wVEissRkoGAkhvHTnY/raLVvcHRL8Wnn5tKsq1x1xkse5N8puwlU54hQBZF/uQtmUX2exb05bTnpgK2ozpslhPIgeNynQF5NanxPiCFfgTYzcXK7T+DGQpbX7kXIPgd5Kz6ZMg/zglj2sjRKiHVvYTT1+Q7yhh4+T3ds0EJ9/QQDaLPyLXY77I7rUNz+EW4ujA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021115.outbound.protection.outlook.com [52.101.52.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F36DCAC006C;
	Mon, 21 Sep 2026 20:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2alrDGgKjRPKvbmwMaF2dDrZuZcGezbAAQZHqcZUMVBTwbMuISxFMd5PFa2yXvY1R0fM7CfKaQgcJS7G52qxQ4elnkD/4MT/cml+sgzK7HZf2DXjQkwbdAyDVYEhxyIPwZ/oDpvSTxsyPcQrOmIafPR5hwKOLnGhRNvHwcr5rstrhZ5ONBa96D2CvO2C7CjJnwa26swSNvSUzBsn9mfZjYFICTA7HrvRcltcWFRmfQEzafDCVHNBuc2YP+6bD0Eux2NrAR16187rD67DWATdXSr3rdJ0TQ/zk96xyNr8id/x17onexgj8VtN7bFJfk43gy0fglwY9DOz8RyvPBNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Id8Htlr+xtz2y5JV1r/XgGOzhssnFx5tpX2TTB/doiw=;
 b=OZfq+NM8dbg6nnZ8h0bsVo/76XNmNshiAB2ajAWI+6QERADQoZPYOtcW7fVoayQNi/6sxQrAjsjPgFrsX9ThlKvdWaQPa+tIR/dm2VzHf6lQbmG4ryFKrDrgVBXq1bIJPLtUu5+kQnfjpSIOK3M0lw6hgNdA0GSw5/6j5XMnEhkiKcyM9YfneSSSZByWSswiI1PUkRT8uHZT86Qq+D5shLKeO30o/hupiD74DmlGPXl/F2YSh3wC7yqyk3irTkemYgCSQeXmeHijrQhHK9j/YUA2V5GMJTQ49IijPGbNTwwPE9stx+56w/Xql4H14BFFPc5Rn9WE00mA86v340GYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id8Htlr+xtz2y5JV1r/XgGOzhssnFx5tpX2TTB/doiw=;
 b=A7rt6DNQiKNuHZNkS4wmaKw7upuuaQKvVny0b3ywlBmgY35y8upXdkNvvEFCQdiootzwjwy2HahhT97J46F0PQaRMDSpjWh+49Lj48DsKXhDyNlmKqfgs7zVbZCGAtPbXajWl90EvB/pWAu/dDED/OMHv2XajAfm3ULryNliFHcEKqUG6WatphZ41mqp1koKtkie38xKaIsMDJMofPzZIHI+UeZJOqw2CSVCP95oYnkHAn0Ahq+lDZ7PX7fds7pwBQ0ujiPnLdoWtlkHunfuNsElCexSPf6P2aLWFYaWJ3up968v20zj71GohwD0wEMGA0OVR0AfwvfW3hWTuIHlnQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:10 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:10 +0000
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
Subject: [PATCH v10 02/14] dt-bindings: dpll: add SiTime SiT95316 clock
 generator
Thread-Topic: [PATCH v10 02/14] dt-bindings: dpll: add SiTime SiT95316 clock
 generator
Thread-Index: AQHdSgVXLQ3HaWA+C0iXh/gobXHQUg==
Date: Mon, 21 Sep 2026 20:11:09 +0000
Message-ID: <20260921201108.42676-3-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 54cb3f35-aed5-4fdc-122a-08df181c7a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 VO3sjZQK58QsmbLmgGnLU20+ot5Ryx84j8iZcGH7R08p32boy2Q/ZcSrZFcoVdDJW8JPO6mXJPoiGOXPGAAhbJPpAiPJoQNxvUGopahyAOxIh1Sdf6dim4gtEC7nVsAHorGw6dNbjzPkYoF0VD6gUzm9d1GFHCcCkuPGD0WfCR/qhFwVWeaC2Pxgmz03hPdtWkxNDxrG/Div6jr8J5/gl9ovyrgXH7ApN8q/DFn7wlWk3Qi6/0YF2Ao3i1bPyH/eCye2k3UjMg3ZUjbL0RFG9i1Uef+eIF+K+zCfw3mg8uvUBiAspXLzjNtJMwfU16EfR5+88c8ZilgpN2STIcUnB4g3KDoBngK29W/qYtsEzXCALh2PbP3/bMn9aPM9g3Sp4F+X2fweHGFBqpwcVvJWPwNTtVlNeu/llbnaboWvC34KVPTy/ptw1yA/LYaCYwUKAonYJFv3ozmrksHPRkZhjQLs/cGMB4lMklmCJpTiz4UKGu6s38A4X8Sa7j6kdUiaqU2rcNeghYncNaLnvf3Rxm7dB9cENCC6tWRXvUmQKqbKeVyd5dzsYpcnsW+Fu3h1gMgYRA2U4Q0eYVfjsB81CeP9ICaA1QvnfTWSf2XQSvZettNgGq4yowNfLDHJxTCJUWN3fLcVaOXH5XC/h7+IwmYUu+qSgRTHDuIK5h+3jNY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dCBb6nmqAk8zLF9/tjbHmDUntzgzYklc6NFZ+vBwv8zJ9C6I18+NJUA4hV?=
 =?iso-8859-1?Q?d8JuG770b/02ehrIyYszcsWRd2CY6fW7kaUgUKCkGoNZ0eQ0Cd3o9sEoz7?=
 =?iso-8859-1?Q?erqzSLRs4nEFn9rAqzK1JMhBelNnZ1nQyxudStP48d5hbwxY29bhiwOx0/?=
 =?iso-8859-1?Q?CDWCH8EAgbgnLy3epKjF+nV3nwnJ4U8TR1HHpfyLgWjtK/+PRxs0bp9u/v?=
 =?iso-8859-1?Q?xZMDKYZ0lccw7zL2ljq8Yl5b1ykFv0crt5iTYdtMTBcbFH3Ov4LtgCDkFZ?=
 =?iso-8859-1?Q?6wKbX0n7GybCIqWaDUSBIFwz99TvhwNCFe43ZgJo7u3EKRzUlvo+doKR+t?=
 =?iso-8859-1?Q?xrSOnqigf/RDenrfjLocKEB17UN+ppIuk/PTy29kI1LRWM45p24YZJt8eM?=
 =?iso-8859-1?Q?+vOxVC6zzj5UAON6RmOcqBVY05QrqVTFjevUbA9yyneFulYmVhCzxlejV2?=
 =?iso-8859-1?Q?ywNXXb4JDkm9S/c0HuF3yjSmYnmq30fsjJcmSjIAcYj0NOIJxeiyu+Jrii?=
 =?iso-8859-1?Q?+a4nfiYTibDcn2OiqC69JrpJVKR1TDep2m+V7WLBdeRG+aacmWYOXVsF4D?=
 =?iso-8859-1?Q?iCaMvxfQSLkCG997QEQHeOPvcghbsrOV3yIiMetjisnptXRBGmqIlFbcgp?=
 =?iso-8859-1?Q?6k+VUQvfXvelnhZA7GeHUAXwsS7/EGQ8ANWW2jsaIET4QeLE+xYDzIuaCZ?=
 =?iso-8859-1?Q?TUrdx3MRXQShHhsW3TnYYBlplJrcUxZr7suR8+wCixU6klhHOXl/7yRfSa?=
 =?iso-8859-1?Q?RgQmT6T6+X78P4wPAiRXgLNgMm/mCBFeW1CyUHPKqgxFuMl2+8ZuUqGZhG?=
 =?iso-8859-1?Q?6ApoNA0M614duO9bLvaGT/KMnQeaqe0UzbQc5SqzJZgojqkXoXlcl9fsja?=
 =?iso-8859-1?Q?vdhHoWCpa6+55oWquQ3UE3VIzb+IBGLJsoY5afGpzmbe1OwvfJcISPlSMe?=
 =?iso-8859-1?Q?mvBHnxGxSVBBt7QCzkbYC2eAXdm3RLkxPvflNmC62Mm5fC7YpQnvA0ApCB?=
 =?iso-8859-1?Q?J8GxQGq1LyCs0imivIZw5umjbQ5MBXolG4kr7u+N/SPT38UFz/QdowFeix?=
 =?iso-8859-1?Q?pyKdoDF6+1uEbHnCvVwJgnlsd5k0Ysvg+RNOW0oL466x0Q8dtFx8y+SNjZ?=
 =?iso-8859-1?Q?GSB5iyGrs+WCvE8etGjfGmfAah0lkx5xLqWOP+BdisxX7l2HH0aT7xtkCD?=
 =?iso-8859-1?Q?3Iw3q7qDYez/5cIy4ucRAgw2Wk+DMTDKTfLk252TF1SvwI2SRNFXyoqdXY?=
 =?iso-8859-1?Q?RFmz+fECENDspPJ2eOWgpqN7JdmQi8or1MAQA+o9bnPPmlEFj02nOv6mBZ?=
 =?iso-8859-1?Q?O9hOqr44E7jjc+jEVzvhNU6ANkkRO79Rajp1W89aRZ1/8V//WHweBjdg52?=
 =?iso-8859-1?Q?GlS0O9wafaF8lLwWWzKoUBua7CfP6LAuvFgKywD8NBOUOudDamvf26EBdo?=
 =?iso-8859-1?Q?t9kOH9Qb8ZfnsDtXgPPwy0iYDpK1/9szz8VnGtpsgTEv61xenR7FLfxFTP?=
 =?iso-8859-1?Q?GSjIb6+dR/FB/KU3tCwlb72iEEEJ/LdomIX2A2XF5qcvSVPN154+R9h/9Q?=
 =?iso-8859-1?Q?CCAAXE2eVuI5AQ4bfxh54SO6fBvIS9K3Ds/ztvC5wbHn5zpnm/uvkpfjbT?=
 =?iso-8859-1?Q?Z9HpZ/IawQhK+/lRpJRVaAIQdaIRT5zgODKeCLLlTbgUyX+sQXQbZuNsjA?=
 =?iso-8859-1?Q?jO3vxtRJeuIPnDAFdb5FZDlGWJE8+rWKSF4QaMonjN5Ab0HtLBR4KbuvSR?=
 =?iso-8859-1?Q?XlwqxGuq9s2fTuj4pJ2wwTa7erjeTeBXJmQNOQ/VWXprXP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fLQjX49PhGElCvTUJ+Sg+LH19Z/EE1wsv52amw0ZejNGUntrQAAreNGYht/53NMx2fcu9CK48CYjJSX8ri1TBivJFRK4oDhdaX+JqINnNfeIsSKDGJtMLAISCtZYfhvhZBuArGpv0W63OKUiZneovt7Z/NL8+vmgE+hPFt+Eh3cJNc5Rzc3XwopK9aJNuEtG+UcP5Pos1TaxkWHnXf82Q1moYRvGST3BI4LMn0Io0rnbm79tGL2XHIQSyOfHWWQZ0tlnTOz+/jpSkcKAfTs+zWB2vIX7UCMvtkL8HuoogTWSpVZx/jnXtX9Rqa8Woce/jg0NVyu70vCWwCdkLN1y1w==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cb3f35-aed5-4fdc-122a-08df181c7a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:09.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2y0XLjpxn0aZeap1G8JJXyVzK0jXmb5sPcEuwqxxWhKCDwYzBmVs/Gp4oJBNSkYiJzsmeJWhxEN/DFQPbXO/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021473-7T49lAKz95aA
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790021473;7T49lAKz95aA;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a binding for the SiTime SiT9531x family of clock generators: an=0A=
I2C-controlled device with four independent PLLs, up to eight input=0A=
clocks and up to twelve outputs, described as a DPLL provider.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Bounded dpll-types to the four PLLs the part has.=0A=
    =0A=
    Made the example self-consistent with the driver: the Fvco override is=
=0A=
    on a PLL whose band the value belongs to, and is a rate the example's=
=0A=
    own output pin divides down from exactly.=0A=
    =0A=
    Dropped esync-control from the example, along with the=0A=
    embedded-sync patch it belonged to.=0A=
=0A=
 .../bindings/dpll/sitime,sit95316.yaml        | 183 ++++++++++++++++++=0A=
 MAINTAINERS                                   |   6 +=0A=
 2 files changed, 189 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
new file mode 100644=0A=
index 000000000000..6f4c60ba1cb9=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
@@ -0,0 +1,183 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/dpll/sitime,sit95316.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: SiTime SiT95316/SiT95317 DPLL Clock Generator=0A=
+=0A=
+maintainers:=0A=
+  - Ali Rouhi <arouhi@sitime.com>=0A=
+=0A=
+description: |=0A=
+  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock=0A=
+  generators with integrated DPLL for synchronization applications.  Both=
=0A=
+  variants contain four PLLs with automatic/manual reference selection,=0A=
+  DCO frequency adjustment, and phase offset measurement via an on-chip=0A=
+  TDC (Time-to-Digital Converter).=0A=
+=0A=
+  Both parts have 4 differential input pairs whose lanes can also be=0A=
+  driven independently as single-ended references, so 8 inputs are=0A=
+  individually selectable.  SiT95317 drives 8 outputs, SiT95316=0A=
+  drives 12.=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    enum:=0A=
+      - sitime,sit95316=0A=
+      - sitime,sit95317=0A=
+=0A=
+  reg:=0A=
+    maxItems: 1=0A=
+=0A=
+  clocks:=0A=
+    maxItems: 1=0A=
+=0A=
+  clock-names:=0A=
+    items:=0A=
+      - const: xtal=0A=
+=0A=
+  clock-frequency:=0A=
+    description:=0A=
+      XO rate in Hz feeding XIN/XO_CLK.  Alternative to the "clocks"=0A=
+      phandle for platforms where the firmware does not expose the=0A=
+      oscillator through the clock framework.=0A=
+=0A=
+  reset-gpios:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      GPIO connected to the chip's active-low reset pin (RESETB).=0A=
+=0A=
+  interrupts:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      Interrupt from the chip's active-low INTRB output.  Asserted when=0A=
+      the device detects a status change such as lock acquisition or loss.=
=0A=
+=0A=
+  dpll-types:=0A=
+    maxItems: 4=0A=
+=0A=
+  sitime,pll-fvco:=0A=
+    $ref: /schemas/types.yaml#/definitions/uint64-array=0A=
+    minItems: 4=0A=
+    maxItems: 4=0A=
+    description:=0A=
+      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  The=0A=
+      values exceed 32 bits, which requires an explicit uint64-array=0A=
+      type; the dtschema meta-schema does not permit a type $ref on a=0A=
+      "-hz" unit-suffix property (only opp-hz is defined as 64-bit),=0A=
+      hence no unit suffix.  Override where the standard=0A=
+      Fvco =3D Fref * DIVN derivation does not match the running VCO --=0A=
+      for example a PLL operating in INTSYNC mode.  A value of 0 keeps=0A=
+      the register-derived computation for that PLL.=0A=
+=0A=
+  sitime,output-pll-map:=0A=
+    $ref: /schemas/types.yaml#/definitions/uint32-array=0A=
+    minItems: 8=0A=
+    maxItems: 12=0A=
+    items:=0A=
+      enum: [0, 1, 2, 3, 255]=0A=
+    description:=0A=
+      Source PLL index (0=3DPLLA .. 3=3DPLLD) for each output 0..11.  The=
=0A=
+      value 255 (0xff) marks an output as unmapped and prevents the=0A=
+      driver from registering it as a DPLL pin.  Override for=0A=
+      configurations where the chip's per-PLL OUTPUT_ENABLE bitmaps do=0A=
+      not unambiguously describe output-to-PLL routing.=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+oneOf:=0A=
+  - required:=0A=
+      - clocks=0A=
+      - clock-names=0A=
+  - required:=0A=
+      - clock-frequency=0A=
+=0A=
+allOf:=0A=
+  - $ref: /schemas/dpll/dpll-device.yaml#=0A=
+  # SiT95317 exposes 8 outputs, SiT95316 exposes 12.  Bound the=0A=
+  # output-pll-map length to the variant so a SiT95317 node cannot=0A=
+  # describe more outputs than the part has.=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            const: sitime,sit95317=0A=
+    then:=0A=
+      properties:=0A=
+        sitime,output-pll-map:=0A=
+          maxItems: 8=0A=
+  # SiT95316 has 12 outputs.  When the map is supplied it must describe=0A=
+  # all of them, otherwise the trailing outputs are left ambiguous.=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            const: sitime,sit95316=0A=
+    then:=0A=
+      properties:=0A=
+        sitime,output-pll-map:=0A=
+          minItems: 12=0A=
+=0A=
+unevaluatedProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    #include <dt-bindings/gpio/gpio.h>=0A=
+    #include <dt-bindings/interrupt-controller/irq.h>=0A=
+=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        dpll@68 {=0A=
+            compatible =3D "sitime,sit95316";=0A=
+            reg =3D <0x68>;=0A=
+            clocks =3D <&xo2>;=0A=
+            clock-names =3D "xtal";=0A=
+            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;=0A=
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;=0A=
+            dpll-types =3D "eec", "eec", "eec", "eec";=0A=
+            sitime,pll-fvco =3D /bits/ 64 <0 6875000000 0 0>;=0A=
+            sitime,output-pll-map =3D <0 0 0 0 0 0 0 0 0 0 0 0>;=0A=
+=0A=
+            input-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkin0";=0A=
+                    connection-type =3D "ext";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <10000000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkin1";=0A=
+                    connection-type =3D "synce";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+            };=0A=
+=0A=
+            output-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkout0";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkout1";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <25000000>;=0A=
+                };=0A=
+            };=0A=
+        };=0A=
+    };=0A=
+...=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index cae5962045dd..b4a901e65bfd 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25151,6 +25151,12 @@ S:	Maintained=0A=
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml=0A=
 F:	drivers/usb/misc/sisusbvga/=0A=
 =0A=
+SITIME SIT9531X DPLL DRIVER=0A=
+M:	Ali Rouhi <arouhi@sitime.com>=0A=
+L:	netdev@vger.kernel.org=0A=
+S:	Maintained=0A=
+F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+=0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
 S:	Maintained=0A=
-- =0A=
2.43.0=0A=
=0A=
