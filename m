Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10933E355;
	Wed,  9 Sep 2026 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940575; cv=fail; b=cmtMdMnA40xhxuM04vhxvamtB9E1EG+cfI9N6QQ09f/7q6LLdj3vxoYSa2nDzlw3MAsEGar2MaLO1Fi58XwdchIZtGR3UYFWQvT1thaZBhdxhRbT8E/ZS+SXDoqJKeyik3HrsDPyylwBxGim7SjKBH9H4RQ+xGBCAYsLihsBSaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940575; c=relaxed/simple;
	bh=sxLt8EpJaSDKqoZg0zwpNGaW2uwKb1F4tdDJUd2wkKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XjUuQXuAZwIl3AMatB0wX6eZRDttN5/4bcHWYOQ7OJy1IHVHzpbPdm8Wcr4mEOzno3HexLeKQsiL8486FeMXetjgl399qM6+NPy0L7o6AaLeUytQsYRh3s526qzTOrZceufVHSr6N/PLqeuu+imCGqWPNTO6Hhs031vmJTok+lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U9NT6PQJ; arc=fail smtp.client-ip=52.101.83.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9NT6PQJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gk2n6VjIuG73tx3e3y33aexqS3kDigImYYigooVHFoPJXECJPrGzkqF8Z1db+8KNaW3tSAzotRdJn9nM21mduNToOkETXqYdRKlUyshXM/GwaxGuGzA+aVnEq3irHuSYn600JL5JXzet6LjRzcU/f3JPJARVhtOm7QzvTNZHogWxa9wJBMa1Zd8c4ClY1QPTzHbUtaexD7bH5NgaNclu8pBFNUv8oECXFuisHfHtFztjT2ZhaBufKzbHP18zGa7Mb8/LAKR5brXvwhd3Z9Mh0IFf7pxFtE1MWdBAuii1+7v34DEDQloae6G9lh7GDhV/Mksmup+2eQIKTJQ2LbniIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxLt8EpJaSDKqoZg0zwpNGaW2uwKb1F4tdDJUd2wkKQ=;
 b=VNs1U8mXIvBVT2GdtOe/PfumCFpix64P4QG17C4VSJaeGEzqWuCzgDhd+RHwX9Om9Uj1D476R6efI6S7Bm+7vmdbrbKKPGGDdxVwpGxbXhetPPNhzkmZNCAIiDxw3s+40bWppEX5HezityV3vTw+TByCMFtlS4XgCr2z8FQ2zlhmujfdi3tt+5t76acdaO+UhCnbMMdJKpnyPNj8fWwyC7sggmwCnyErAXYvehV/fo8mcqByQC6+RksC43qkZ+Gy6KxdWqhfxne56XvXfj1iNxXBXIFdaBydHd7KqMlrpZ3pkL0JiXyLKQeMJrvV4ich2KifJPFNZIO6DKBi9FvK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxLt8EpJaSDKqoZg0zwpNGaW2uwKb1F4tdDJUd2wkKQ=;
 b=U9NT6PQJ+Kep6I/Y3ofvqJFTK76UfPJuMuz9qQdRavN+l2zWGdMjs5/zXHVRhQUxelQrlGUJQEjFDz4EPIUPeFAmVH20u5KutPTbUVQoxhh2/UcYYvQFcES2oIxtc8iw/qws1pyPtWp3GFROtNQoKuJdo8tR7lcGcp/Kkd30TRIR0fB6pIoTgMu4EkIhjz8Unhu9P3CYMe4K2zNsKzLoYp4sRaGU2YbtNlD1/ffYwJg9zK/MRbovq1NFcDS4pO7ppM2TasNJEtBH/y7W17GNNwA6O+adWoc8h0JKLO9iB8IGz9PCQmOFmY2xfrdbQ/f4j2IgsxsukqSpgTtzpZM4VA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AMBPR04MB764262.eurprd04.prod.outlook.com
 (2603:10a6:20b:7af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 07:56:10 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 07:56:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "phucduc.bui@gmail.com" <phucduc.bui@gmail.com>, Frank Li
	<frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Stephen Boyd
	<swboyd@chromium.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v5 2/2] net: fec: Handle optional IRQ lookup errors
 correctly
Thread-Topic: [PATCH net v5 2/2] net: fec: Handle optional IRQ lookup errors
 correctly
Thread-Index: AQHdQCccms2D+Gd81kWz7HhPdEtjFbbF4PfQ
Date: Wed, 9 Sep 2026 07:56:10 +0000
Message-ID:
 <GV2PR04MB117390180B8249854574BB33088B02@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909064712.22539-1-phucduc.bui@gmail.com>
 <20260909064712.22539-2-phucduc.bui@gmail.com>
In-Reply-To: <20260909064712.22539-2-phucduc.bui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AMBPR04MB764262:EE_
x-ms-office365-filtering-correlation-id: a7699d8e-85e2-4a93-f2c4-08df0e47d030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|19092799006|7416014|376014|366016|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 S9HUYxp+infW7VP0N59lM1R7rt8whZiVOgNNcdjmWU+CkCNodeJaeeH49PqahYCgLr/xY/TcxlilHWOH0RcMXzj8aAFKYw30l3JzZmf52SA6tIDyX7jkhcpO8jWFIS3vUyA9xXZYIa1gj6b4evPKzf+2GEdoc5VRqeHR1HseSeoAohfB6kVCi/qwQ06e/zr0egc+W3iJrr1k5GUMCpNzDktwPBzCaxIJQrf+XBK3rmZZQUzpEr7uIIhjh+o2H458OfSbh5PUOggYDGVPcxZBEniOfE9zWrqxac2uSJ2hNhw6I2VqKkPflepfjfcxUhJjKC6R8XB/jWjsr4H0ObXj3lxsg9F8oIH3IMb5WPVUE0d0AU6Olo8LTSIkuXt6EsZG5/r6P4U9A/ymkjZ5sW7lq7ZZZK47CSUjhXPl4T/bjqHfAV0SAXXLOEgXCkpg53KqLfMiQI/daBhXZwhO7vc5QtJJHz5V6GiX/IP1xAUOx7tdm+5d1BiMR0PSYU9prcrFU9bF31uAeXLVEXmDOLJD5waN9bkOIYmazonFlADJyI8XU2G6hfSYm/vN616wMWnT1z1rrtKb4TVFiYTx5Noi5f86dFSAptAUh1u/OFA6IxC2jGP3G4Bomwxbm/qXs27SrXh273Xs1x85uKEmmdtGlhvvXEiPDDMHjnUbEJBOIB7+U8fGx8ITyEfIdMOCCK2RkqOvBnVgg1ZeAL1/C9XvuStkdzX1904f+DMWzUhAVqY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(7416014)(376014)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ogFQAIBBNntOgZHzFV2/p6ID7qYjZAKNRYJXpPmxvlTNaRshRy8IITUXypK4?=
 =?us-ascii?Q?g95o1+0qOSAz//MeZYmB2wDVzsWyJrdfhHR1TWb8vBlKm6qIRgOu+asWc/ot?=
 =?us-ascii?Q?jWS2e/lCE8vz3LZM6QdKD4evZAYrTkvvTRWckDm2ZuajxBvo8dOjlIFk9Het?=
 =?us-ascii?Q?0zPwmhDffl17PbpoWJeB+nnK9lwNU3kpTd5hrc6l3BlkJs8gMLGTAYT0XSDb?=
 =?us-ascii?Q?WhWr3rge7CbUervVKKOftUaMs7Z+FqJCVyP8Jw2zAM1/Mo81omdD0QLYsqQ3?=
 =?us-ascii?Q?tEVOzIjnObSR0LC8xA5hRDWXgHOQDDIEc8duUxWyNVHBTU09VU9NAbavGluo?=
 =?us-ascii?Q?hc+yjsHYKSzxwr+Ir2/Y1RWAscoY9fGUaTOdjSXhoSLC7M2RK2NiyqW8kFlH?=
 =?us-ascii?Q?PMCC+SZTOsjYm8qJboiUo9QnR5HNbllUtoNuvVLGvoYrxZUaRf25BSamHXdU?=
 =?us-ascii?Q?QgQChbqnynmC5Pur7O1byL+4el3c2Vu6+423m92Oat+6JHzb9IdaIYi5Qcny?=
 =?us-ascii?Q?F0AWcdjsFRbdN84KKs1Mtb3OKbjDZLocQojuVkiUZdvG+vquH3pw5Bx6d1UB?=
 =?us-ascii?Q?EtCHfEI8LdTFmOzATLq+Ap+BHIMvLOyFD5s85y9Fmcz7N5JmrTGn9Fbw2mta?=
 =?us-ascii?Q?3wB0yiyBhp4wCsKoNiXKNxbDHiKYT7pLHTgl4Or8akx+BPjRjUibDA/+eAnn?=
 =?us-ascii?Q?TyVeShLC1XNtZO/1xG1xsiyT/Fhbe8mMGM5ZfJDXaPux9Vb0Zg3C289CsipN?=
 =?us-ascii?Q?XDNIgpB7nH5PYjfBX1+Fis1DHRCoaulWZc3k7QZ/PlpmgPRz/Ddw/TtU/er0?=
 =?us-ascii?Q?qKZjctdusBWIrLFOmnusFZjD7nYpI5pzYhqMdGQM/R7heoCNrj96jsbxU44z?=
 =?us-ascii?Q?ZQqsyZ21GvFvd3vprGMIyfXD/6US82B4VXuwilf2Wt9t0CGZSMDRMt8PZE0n?=
 =?us-ascii?Q?Yub7bXWZyGUZ4aCzOZozGZlUh9Czu3kPsxX25mWIGljPzop1/WnnCgVYoyKA?=
 =?us-ascii?Q?ygIzoflsh0mKgC1jaCDekSApr2ipOjvDP/UBEz+2qUPfJ8ITxO/KSqKqsNdl?=
 =?us-ascii?Q?VfVxiyyFI6BrvFByL8xbTofUnLXukAAYtGASi+WKfk4VaglKNOlMvbrcXcVZ?=
 =?us-ascii?Q?b21LWvz6Wz2lQN7n8fp7E5pJ5DDNJAP1nCi4DK2P8eErldKRm4RpQO4PgqbI?=
 =?us-ascii?Q?hp5Dl8ODShpOQoSHt/wRycWTp6INZNPWgwQmYjRycx73X9OsGh1ll9ckPf8U?=
 =?us-ascii?Q?jzwcQFeskFxyymkmwgr+5+tH1HpvmzPgLIjoPByqq9nllpmU4r0U6dnZLcxC?=
 =?us-ascii?Q?/cXXpa2dn+GeT4ZJfSNNIqE8jDqvEUSi1JIye7L2I4tSgDLReKmviXUP5ESK?=
 =?us-ascii?Q?8pu+kiRXRL1ykeQTAJOhc17uWz5BdVKTn7TfpoWpDVXat/cNqnU0vq6hLCUr?=
 =?us-ascii?Q?qjcHLWAB58rYOa2L9rXpbFGtPgK7qgG6pEvbTQ20hOwCuzoxi37dQvsoicQj?=
 =?us-ascii?Q?iTLRfqL6I2pO/bCl75EwKE0qqSpzVMrkgPOAYX0pr3z38QhfmIdc9wScazrb?=
 =?us-ascii?Q?zOd282mA4oegKtQn4BsD3NWeBNHPyTAxTFVo8GYRS7iYGyVmAj+vouYbqJEA?=
 =?us-ascii?Q?wAcT/v+3glPDE/WYdN7dJd10hXszX85r8Poipxak8y5/iVs7zmX6q+71zVOx?=
 =?us-ascii?Q?oESBNp7CBxr72M82hef6gC1gOwwV/658zqU5VopfVYnyXSnU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7699d8e-85e2-4a93-f2c4-08df0e47d030
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 07:56:10.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xe8hrFNdZB+L/SZydhce1SXgsCihFD2YvWxy5Hwf+okN1fQWyKEDLIN6DyuheHeWwzUyMa4tR1EAl1P7w0w/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB764262

> Handle errors from platform_get_irq_byname_optional() explicitly while
> preserving the existing fallback to platform_get_irq() when the named IRQ
> is not available.
>=20
> Propagate errors other than -ENXIO from the optional IRQ lookup instead
> of silently falling back to the indexed IRQ lookup.
>=20
> In particular, silently ignoring -EPROBE_DEFER can cause the driver to
> continue probing instead of deferring as required.
>=20
> Fixes: 3b56be218f65 ("net: fec_main: Use platform_get_irq_byname_optional=
()
> to avoid error message")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Wei Fang <wei.fang@nxp.com>

