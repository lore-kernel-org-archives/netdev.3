Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4756260D;
	Tue, 13 Oct 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931018; cv=fail; b=WQn8sf+FQuu9F4hSo0YwGTWGjMxTuQ2N2OrGjoe8DPZY6lkfuLXWT3OLiHLdaB5CUxC0AXFdEgFS4JM2gT4sQCYQLOnNPHLAqomyPknsQPAy/p7SLES3ZzbCbu0Mln1wehG5wbe70myOttubFr7PpOPGnxzbJoYyAMkwiHfwDWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931018; c=relaxed/simple;
	bh=1mW6yJ3hljbmQHU8WSYfq5bpFKIQm5tv1Sw0fg4UY2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=at/kmRHabEVviK9RSsiwEwKU3OBsaISt/PsPx7F19RhJNbMC0ogeBX3H3LTQ65+Ro3HrM9o8PDAq1L7LD80jomHjyeWy3Vple2cwnDthfiHPObrO7RJcqu+fPbEzIiczf9pKrdWUPMiBBFKwZN13Sy3N1aycYX8OAj7Jj6Kiwrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=XwkHilas; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=VzLPQwnn; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="XwkHilas";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="VzLPQwnn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=GAVUHqqNkHEiJH8OE5GbQ45tHUHL/1bM3T+VuxaBJjU=;
 b=XwkHilas5T43pdtzoErDBoWwcOQ5IIn53t5S3M4AS7YnIP3tNbWhTbOB/J5+KfWcDHw+pCt/bpzLeh+/aPtRg9nHkj8aa44ia5mPbYTvG5UViL3GVanPcDI2Dfdps48r3h4ptK+bXfJ8L9j+yPDepluP9yfpvjvjpmjFaWrtXpib6fA3AkNVwwz1ZSsIbjbOnikOcmGxH59qRnU6rWUMkXHi/mQvvzM3Q1UPAVuixIMhU0oMiKfZIJP6wdJl9+uNZX7Lz8zB0LAiLbQzv4b1J9FIjdtJj2AkEOcn3ZYB8CzzVey2pGJooqelozdOPYfNCr0A9rj/lEauQhOjUs00rg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020079.outbound.protection.outlook.com [52.101.56.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DFEEF98006A;
	Tue, 13 Oct 2026 22:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3Q4jpHlCOHxh8oFHBTHjqBXGgxkIhX2R3zrzWTHfW3+vDgr88TDwyK5cU6FJv/E6KLF8hne4WAJmZ736KQ+buNWgk01mBdGsbKw98gl+52YNt8rYoh9zipq2OgHaDsj/33uLMenUyjQrcGUMGDnZig+JfUuDKMSpOy9MfJEQ9LVURel/v7AamILMh8eBnXFbRZ7Uc8wpyltV80pdcTUpsru6zSzSfx93slO0yFc2gX89shbGtCxbYkbr2JBoic/4F0b2X6JGiHUh3vp39p3HkdCw4aYhHhe3uD8iKQODC4Zr7zaU77XHF9hfq0QHwLfNT2f3UlxY9U6iq3p096ImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAVUHqqNkHEiJH8OE5GbQ45tHUHL/1bM3T+VuxaBJjU=;
 b=eVmUQvW1Fm7ACI6EjSq0aQ0JZ5XY9VjX1p/DTI0WbFyIQ77QU/oUtKGOG7FVfiI6SvvsimovxAoklQKipbQAAj52is8Ky/erPTyNZ+NmL6n2s/+dLhkyWucHNkvjycwqF312UXDiuNXnDC2gAUcz9TNqmZfdduF/+QssubNnBEmLpj8ppZkVLDw6DRfX9TuRkfrSUap+DZMLFiUFS5h1Q0UrbFx1sdr7UhNLU/jm+eoJCj5/tFTHqRQZfDZ/TmfnonBkJcvKF+hooITUJy/o7ATwA87CVe44cOUovMNMRzsO26U90rBQpyCYWOKLrNTmKWKnoIe+sYjXkUd4NWThXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAVUHqqNkHEiJH8OE5GbQ45tHUHL/1bM3T+VuxaBJjU=;
 b=VzLPQwnn3dJ5CjA6SJS2MQ0kFkPzr4Uu172/g4L8Zpll9tJ58bUKsyGCXvwP0w8uUA1TzEwPItnjZ2PDT58TjdwfXm3enOPBPBnMQ94WJEZGowl7joIvG/HT1pZqNnC2SqgTBs2ztD/prU/odriLLZQGG28V1a1cJ/8qBFCxk65RmeVVag2BjOGZTep9TNYpxKNlfJ8ylOkj80jtgMD62MeBL/JMO9c4yTs75dDnK/a9iqWmfB505BvtoC6TjWn7rOiOUsQLoWiqMyG5n1hXU+YjT8ssTieczqaSqjYRY4ubUQSHxUJTmy8l4+kfhlgWIppiDwAvltwWuzs+zTNt3g==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB596672.namprd20.prod.outlook.com
 (2603:10b6:806:3be::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:36:44 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:36:44 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v12 10/12] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v12 10/12] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdWBx4eh1tRDHf9E+4XHHRd+Qvq7b7Q4+AgADS2oA=
Date: Tue, 13 Oct 2026 22:36:44 +0000
Message-ID: <20261013223641.25560-4-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-11-arouhi@sitime.com>
 <96179bac-03aa-472a-bffc-51a5252a2089@redhat.com>
In-Reply-To: <96179bac-03aa-472a-bffc-51a5252a2089@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB596672:EE_
x-ms-office365-filtering-correlation-id: 31356f66-3430-43b8-6623-08df297a759c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|5023799004|38070700021|56012099006|18002099003|22082099003|3023799007|261009223027099003|10067099003;
x-microsoft-antispam-message-info:
 R+HbNg8euY8DCDiiV7zV7Qjrw2XBJyDE1Ghz3RAtnJE01pEG7yhOGKxuGEGKVlrET9dguw1fMR5F+G4AS77+RC6e+J6AxnbNbg5OhfhQem3MVJEuQUcfJcy+EavmOe69L7lTWYjC8qLDHPFrloPPzOqowyaW+g5uTwxbWjnSF2q5NUYrvrkqxoe1I3lH5epAL8+E5iWpfMcCq5mQ/LJtjnq8jXRooSYLxoFXJ4Evv1l+Le0vpPXtLDEkZMlyv7CQYve+bqTN4fR75VYyMrz/+XM+AxQfBDs4Kv7GLBOs7oXeIPgMQV3MZkFA0by7J78yGj60LI01TbLcQHFyYUNmyCbFchQUc57z2NzGN9maIX0aaHbF0nP1CI2rrlUyZ/LaZb8ubZz8UQQnPPhQv4ZrfdDcQLLEZUWQFE9VgkBri0IIZKsF1gtszM4dxND13LWkR004NkjR1o9JUytrbXP/9gV3Ym7YPb0aUdM9+y6D3PHpPbTs+11m6VxfEJw85Bui4XfloIRCtvdrirt6y6vTjBV6vnWNkIb0cPA9f2nQkd0pxue5BRYBKP/xMdHPHg2a+EBLD9s7BeLGu0jMZZMez1wBIcBPluifsga31ZA3TDk7G1WqEkuBkGvx6UurUSoTk0RTpDkJqOfZlpSgJmw8QWpH6Gb6rnBkk/wh24KnExIFwDJ6Di4UWllW0DzN3z51WoT4BTzo/+qzHikqIHtMSgTAEfB/JGKL+hf5BDPeaHw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(5023799004)(38070700021)(56012099006)(18002099003)(22082099003)(3023799007)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2gPysHa6uZXqRo/Zj9/vpRZO0OG2GrFtE/iA+GzW/Ohq57cSbt4ll3WBbb?=
 =?iso-8859-1?Q?WqQJG+I18FzugBFAqJBS1iIPAGQVPpcpfuQN6IzNTqkvv+q598tN+cLzz9?=
 =?iso-8859-1?Q?ViRajAqgaprqxjRmwiRmUw6Z/TzngQt3pl6WIPhUnXYjt8QT9HJLlCzcKJ?=
 =?iso-8859-1?Q?ei640uKdTIp+BL0/dFPTabzCpnvphYRQgDP6wrKSI0YdJZFtfsHQ7clFaa?=
 =?iso-8859-1?Q?bsCsXeADIMPvpa2zNOaRlj4myhnhZ14ryOse72ufkonAOKFRek5jTuHZWL?=
 =?iso-8859-1?Q?2A2fazVqxvQvhFYBNDr7/daevYkB7whLmJynFGD8jdTv2glQVny/joftXe?=
 =?iso-8859-1?Q?6eVX7jULQ03mOj+n/LX0fZyRfwDnm2fBH/+UFxFcgfZyLVY1Z9D6LHQ8MF?=
 =?iso-8859-1?Q?yij6TcV9TX9ZuLrer/ydliixV5lkj0ds7WZRwLbrLJG+xMr8OHyuFDlty/?=
 =?iso-8859-1?Q?kiuZdfJN9ylm7n62f+b9R3C+fUtq1pLcF1lm9T/rGxsbcJ8aaYT4pX0H/E?=
 =?iso-8859-1?Q?DNd4AgphLWRCI5vJYn43gJagUOB5Vpy8E43zf8xZUV60CxeB6XTTe6bdPq?=
 =?iso-8859-1?Q?zcwqhPj3cx0cp0uxsBUxCzAc9g0ikzmwtGGEMECINA2USpAFwrmfoZsmmd?=
 =?iso-8859-1?Q?J4S30b6eUXjM0WaEC7XsNSvwcC6HJ/d5I2+PtdgZwHCXjUO2Re7Qa4aWLf?=
 =?iso-8859-1?Q?Fy0FFIlvzf2W+AZ7A4OQrRnNpKK/XsvQ1XGQ7YNMt0enJssyHs5v1hsh18?=
 =?iso-8859-1?Q?FojUZAIsvtBnWH4TYxouZWFdTFktrpQtONfO4KoOK4M0KsDQ7GbX8f0xvP?=
 =?iso-8859-1?Q?gLk/kBRybc4rcvwQRp3TB6gEBkR9x9+UXDegToVCtVALnOKXZ+meQ0HWWZ?=
 =?iso-8859-1?Q?KlSkHfQPLM6eBj9NhxNOsiEqepq46fhb93DnmQhTAOIctYmxbZXETR5oAT?=
 =?iso-8859-1?Q?2ve7dOfc9qB0sUfIxuSigeef+RWEcTDPzrik4nzAXH9EgvxpcYPNSB/dp9?=
 =?iso-8859-1?Q?nFamia1CbevO9U1GKFVPpdmkLvsRLe9YXLO25UT5T3NCM1nOKEOwAr1ol3?=
 =?iso-8859-1?Q?zLgdkmkVZIkfXzj0QBLTrdoXGfbsncT51rxtiJhH3uoFT8NKEv1CkS0IFB?=
 =?iso-8859-1?Q?6FHyKYQL9QHRoIsp9phGdEFY9G2SpGBZ+A6qfNgRIJzGsT5YGI8CVmJMWs?=
 =?iso-8859-1?Q?wNrWj9A7EUxZlhphS9o66FiYMQyVsobrGoh2CHGcXOzPv886SX1kt4THPL?=
 =?iso-8859-1?Q?jP8lt2cr7QYjVDcTKWhq1ehfDN/lm7XRbUGnJe14/izyYxB/do9fL9cROl?=
 =?iso-8859-1?Q?EECkWlvO3ZdklWREbxBepWTocSqM05SzGFpTPwBlzMJdZq2n9Zj+Dd+ZWh?=
 =?iso-8859-1?Q?LoB/FSSsDsoEy8vpB2XR/ctYGUQ4reeDzx4/LcdABH+lRznuBQmhHC7Czl?=
 =?iso-8859-1?Q?/P6UIOzxWM/onasgFSEnmtBwfEJf6PGqrpbi5hSbUO8NTKzZMAHEDmhVYC?=
 =?iso-8859-1?Q?c5byNINjEYkRXzu9j7e8bF0zmLlpi/Tu796Dfeh/fulruiokapyMkn2Tsf?=
 =?iso-8859-1?Q?v6+jMbjmLDK/eadbYaE2SLFio2TIRDrmNyhugZTkLI+FSk9eAMX8pT8ORP?=
 =?iso-8859-1?Q?vzzN5CbCVXa6D0mgiTMIhZ3lthXSGdbiEIicO554mynCtUncAc8pQVETyK?=
 =?iso-8859-1?Q?+cnbcrca8J4YxGf3p41oGZgvLSF5Gy6r14atwdJA83kYYsaZwYE7yDIQ7d?=
 =?iso-8859-1?Q?zQnfODiKaRPvUHoz1t57FcFAzwgIi9/aYv15RE77ePcibP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IdusG5EW61nVHM2oy6YHkXDIo8LN15Gj5CK4BHtHgN5sq+YJqcVfj+0zXcfdPrTNKo40HVs/NLw69j9VSzNSJ9IU8yeYgrOOn2BsFkI0YugxZfd+a4RScCnfLBWWCYSIFRjQMANOCKWaVRtb6PgRtAQlWggpC4FDD/tM65Lj69CFyW664SVgQIaFTqYqYBup7IvMy3Ap9KkmRm7NtaC5xKnakvbX2wsClp1Dg16dBj/dPEwiG+UKjzFvRIxy1NUDtx/1ygupUtDMDHEM5aF2rqsjX1w5Lv/pEnZUTZk3LT0QYNoSq2Bw1TPI7iarYeTsTqvYyyOpSFFOtyJgAZ4yAQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31356f66-3430-43b8-6623-08df297a759c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:36:44.5798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baTEjAV1CKhbBnGC1xuRaE2I+f82ouHZ1Ha63AvVTvkx9PPMy/RgUKIE7x40VEADwwGXFI8YLhfH3h5zkltrtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB596672
X-MDID: 1791931009-0ocG7Xd-VSbR
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931009;0ocG7Xd-VSbR;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Tue, 13 Oct 2026, Ivan Vecera wrote:=0A=
=0A=
> > +static int sit9531x_output_phase_encode(u64 fvco, u64 divo, s32 phase_=
ps,=0A=
> > +                                       u64 *coarse_out, u8 *fine_out,=
=0A=
> > +                                       s32 *phase_adj)=0A=
> > +{=0A=
> > +       u64 abs_ps, cycles, frac_ps, coarse =3D 0, coarse_ps, t_out_ps;=
=0A=
> > +       s64 phase_norm_ps =3D 0;=0A=
> > +       u8 fine =3D 0;=0A=
> > +=0A=
> > +       t_out_ps =3D mul_u64_u64_div_u64(divo, 1000000000000ULL, fvco);=
=0A=
> > +       if (!t_out_ps)=0A=
> > +               return -EINVAL;=0A=
> > +=0A=
>=0A=
> I think you can do this here:=0A=
>=0A=
> if (!phase_ps) {=0A=
> 	*coarse_out =3D 0;=0A=
> 	*fine_out =3D 0;=0A=
> 	*phase_adj =3D 0;=0A=
> 	return 0;=0A=
> }=0A=
>=0A=
> and saves CPU cycles consumed by divisions below.=0A=
=0A=
Done as suggested, right after the period check, with your=0A=
Suggested-by on the patch. A zero request has nothing for the fold or=0A=
the quantizer to do, and the three outputs are what the rest of the=0A=
function would have produced for it anyway.=0A=
=0A=
Thanks,=0A=
Ali=0A=
