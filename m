Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFC37CD52;
	Wed,  9 Sep 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940387; cv=fail; b=aE2lJ4cPME4rzH8YXcnRaeAoEgaSMuXBsYV844QYtQJEuThwVPd7rDwywvOE3TJCm6El2H1DRZX4Hi5WvL8CdKZWU8XDqAVpcPtyBMU63P8o7rqvI4KnXhApq7wFx0OOO36tv4q3P8b/A1WrNx3CABD8rnNjcXp0LAOBdjQvG8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940387; c=relaxed/simple;
	bh=8F7b4F+Z/ViyDzWiWNvDU+Qu5NSNFvc57daENO61V0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YU5pAadDmoOT7Ohovc7svcSB4kYVdsuijKgfGP8CvGaa+ePfDliLDeqgiJMYgrGm67xogRYG12n1MhoPnH556TXndTe9k7WOvidhk51anWMHQnb/7TeLGyKX3WYycRSq1a8JqAQhqS1v0FbPBMpfirUk5S515y89IxzXFyNamL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MC/9ZCGF; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MC/9ZCGF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxRg3XGQ5+3bMrUB9aM9+zpmUi1hWs288G9JrWoJbX7Jyfek5SpDK9IwEh8HyL6JBZLm72iwdHaJIGfJLte9SdUIs8h1JdR7C/y+zsVspaTvts2AyCs1Y4lEMKRxQjaRY2YoaaMnWhford5/CqqeUFrwmJS8mvJpZCXfDLWEJRG5j7IEwfpDUMx+q+5xplD4tEPeNtMEQFfyqrO9Fdh8p452TK+EnRRIOE+37W7KqhR0uje7wTnbcFyxCl67MelFkOtzmkeuPIZBI5xoXW66SgVcZGZiZEcOAdLaFIg9b2YN2C2o5lAPzfPExboqG3CDcTIbU9revYCd6WiATyCMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F7b4F+Z/ViyDzWiWNvDU+Qu5NSNFvc57daENO61V0g=;
 b=wYPYmyG/Yk4uGN+QzCjSkkBqJLEUf9LDyLJyIv3ZYs4i0j9IMa2lmS0CbiHOgU4DO/CGXdnO602vURLh490t1EUx3Z+w/eD0PqELIqFLNMplG5FPKFdCLRiSNsxbgcZubcKZeYZBCH5+0+iKLUygbYhABGlPadupXnJcWoIsp1QTZ/EM5b2o/H4CHU913BNmVecvBsSQRAWIoix94ZK1XR6ZLGx7UjpZY64txy70FNO50ZuMNhrtmJQ+/P+dTvtEG+l6bsjO9UNIuySEMb3UY4eE8qzpYBkDqriTgmlou8BLs2823hOFuorznUM8W9UEAGqfzj1y5xXlCfkRhlOILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F7b4F+Z/ViyDzWiWNvDU+Qu5NSNFvc57daENO61V0g=;
 b=MC/9ZCGFAJPko2kZfHOrEePoPMcE0MIsLP9SbKlxTJy26oiVehlxuE5EKyfXx1THi+/walMVf5RkY11OuQcvaHykcDcAwARrbHKLbVxX0gyP3apCfrVSSWbSVhrf1xL2xRaIxQOgVZ2SE2QaBZmeHnsPDyh3/mvG6iPLysEugg7g6UkkNf5qfpBtpRoyQy7AziNIqT/ppSkanpj0pUQ3+DeIT9IVPj2k+Ge6Y0oeepGbH3gyFjafmbysJIKNGTj+dJupDxF5TpSaJj5OnxISKUtcu2AueXzKqF3RztD9zGQOetgH8Pdk1KUINcSN4MJbHqFEHKqkSvYLA/hGZdAveg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB9594.eurprd04.prod.outlook.com
 (2603:10a6:102:23c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 07:53:00 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 07:52:59 +0000
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
Subject: RE: [PATCH net v5 1/2] net: fec: Propagate PTP initialization errors
Thread-Topic: [PATCH net v5 1/2] net: fec: Propagate PTP initialization errors
Thread-Index: AQHdQCcXgvMi7cC7CkO80AiUYzxD8LbF3/LA
Date: Wed, 9 Sep 2026 07:52:59 +0000
Message-ID:
 <GV2PR04MB1173990A59F69EA8ED8929EE188B02@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909064712.22539-1-phucduc.bui@gmail.com>
In-Reply-To: <20260909064712.22539-1-phucduc.bui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB9594:EE_
x-ms-office365-filtering-correlation-id: 9f65461a-8848-48d4-df64-08df0e475e15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 G8Lvo0dBXeH7ns5W2DEYvo3fxcEe371nxdoa/YmMzb4VqPK7dI3NS50QFp09wcWra9dsteSkh5WOvXxZdH7W2940hzaqB4OYTLlpFyKg26GleWDAgPmOXNosqwtJvf7wW7/vn8e548aB/yd9SbQdVAogtvEgD3xob9UGWvXM3LzKetGZLU0mHGHAc3MJASgu9B0vKY8MZCOHZ1Nk+OFsG4v9wGS7ZrFNlC8p37g0VfUKhAHiVYH3+D8DCAHmd9yTDMrDlztletBZCAI7YpJ/z6mJS+fbch1Pt+bmh/LfYCZAhpWGTSdZN2CLPvkaAMCbKY2nVAW9NraepiMUiP3ZiCw33+2QkxHqww54cjqux65Ee/lrdFsq7U0W9LCzJQT3IUHFuuNyu8ryWMTAA3f4+aXNWGcZZjMrkgh8trkH/6qLX16FTCBzhMSWL4tbgx6AT+9apJy6PXKnm4xoZm1dO/RQG+OocUxv1FacB+P80hvaZ7aAvVDvTBiF/uqqU27F+LL6I2tAahqZ8GtOvtxVyqa3DIjdm+lRK/GSQqWFiuJvaMm9fhei4BOjUpXl0rRhKeTejBa9/bC3lnkl4VaYPqEypOxrgHAz/RcjIm1A2AEgxsBGE8k329MuTdgYPUPTxgLOGOlk9baYEDnfFmpFciTzvqk4BZQq9EJNeJzXTe9KLs1DgvcrTPNuZFBLmqJ3It9ifrLyB3eKbpalAiX1GmPh2Dd4bXyrIzNYkLE3K1Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PGcSEUNvvjgVuj1ieJwaHtNhlWWQBTFi9PY2b2akXzCPT4pN20JXv/nItdra?=
 =?us-ascii?Q?m/oIMwBJ0Mdf2993rhhOkA6k2z3Ig+AQo93+fCx2tCKftm8GPI/Ie/jsFM6y?=
 =?us-ascii?Q?i44P5xxGN7YKBLquFRDYQZERujIo1RHnTutk9fJdBR5yljt/FvdOG91fOF0n?=
 =?us-ascii?Q?7LVVvPhIMhTJboJikxO4VuUBM2XElt+l1MHlGu4SGaWPGl3YIFr365wyqBxo?=
 =?us-ascii?Q?kzl5g58giHSEqquoNmDpeBxdgz/X1HxudoTiqQtxhw2bujVzpLWBHsHHhb+b?=
 =?us-ascii?Q?NX27xL06s2XgBEPevsxOwhHGQ3CxgY3wijdJD3oQAliOLfxb5GyQdf1rA5gJ?=
 =?us-ascii?Q?4F3Wtw6WXPnmV+yx7p544XTcNXb5/gv5Viy5nGo1559p68owHWfVuP+Ny08v?=
 =?us-ascii?Q?bfjkp9eJVy5NWCRnyoO4S+vbe3JxFWoSesFGTfQtBwUr1ziHKpGYN25l3I1r?=
 =?us-ascii?Q?yqXnGaQGIfPljrBLNYZRq25slRdEt/+VjtwfVlqa3FLduLRbSOxqflscKMHv?=
 =?us-ascii?Q?OGqBK1VAAca7Y65MI1R/WhFC39Fec4H6Hrs3Jachzhg6TXAKqopUTwprV/XK?=
 =?us-ascii?Q?7mFh8hwyziYjB2FT15z5LaNix6FVQFIm2yUL1tZRXtGG+r3bM6w22q/jNcoY?=
 =?us-ascii?Q?pc1NhlHocoK+ZPtV7SJuRxYonEPG/jpohkQU+RnzjsTLfVAauSp9d1SkzCHc?=
 =?us-ascii?Q?B1VPoVmLQEXMM2SXcFkN5pvwcrHgra5SVPkjWQSk8J+Zs1V3DTU4aLBGEly2?=
 =?us-ascii?Q?Br7cTckKBZNohyDLA933alMDFuUV64qjCL74+nttA4MgL69RZ7O/SarTodKc?=
 =?us-ascii?Q?4DyDgPL/YKIJNTp1OH+kS/zAWuTKc0FNtuHiwYNt6qSWTDBj7dKM7krRFq1d?=
 =?us-ascii?Q?o35+bd9IiLIsqnrOuH6J5ZHzN6qa0hZcitoeyxmecDoCPt6UM03bXwhq4eIn?=
 =?us-ascii?Q?2oetErEEJABSJvnktcctLq9oh4tJuL0hRuiXLlBBJi1+PYtSCVQ93ux5rXqA?=
 =?us-ascii?Q?tO2EY+uQJLv2/ttgpHV396+UYVQRYOM6C+AWgXRgAA3TsqmA2vJxvPJb9K6f?=
 =?us-ascii?Q?TVdcZTcqOJFtrKgAK9Q5flCmiUJHnQsOjuEs1nP4CtbJqMWpg5uBk3RBmufN?=
 =?us-ascii?Q?vYX0o87ZMwVYi940roqU3fGuZ/iM191n3/5jDt0J/KfHlPH+P0L0lHSrHp3g?=
 =?us-ascii?Q?my1/6m3Rt0lgOvpXNMMYWh9XggWlyfRqmLqAJCpWx/UBu6OVE3EO27Aq5GOD?=
 =?us-ascii?Q?tCDq50ISxBEUYMtA5Im6tXmKdwE/PilOpz2elIFf6zFSBCZTA4CBmnWOyZ21?=
 =?us-ascii?Q?fyTa2ZQpQtLdEnTmCCzgX5aDCctAGbu2IPixOY5j+8hxmZjdUDboqJRcX2I8?=
 =?us-ascii?Q?bqLaS+aemHllrZRrs990ec09X4k265xZj7X34LlZjiwRmE0y7bzUOuuOf9QA?=
 =?us-ascii?Q?IS5w/JxA8XKwrQUw7e7ydqfEERhuI8ui8ygLZ87tb7nYMI7TTLNTP7Kd9jY+?=
 =?us-ascii?Q?OrKq2vi/FDJN74PCH4ashhtiS2NzBgKUuu7MH2epWRHOHkwABah1PcMpd5ul?=
 =?us-ascii?Q?wsrWYSX+YTh09IkRZANrhQ4XWREt5lMOAwAevl9o4ObMiqwtnWCHptHD8vOb?=
 =?us-ascii?Q?MOz87P4f7+TTysobbAXv2UjZGZORLL4TmpZTyZCoe6jgKA8vzAGiDRDij/Bl?=
 =?us-ascii?Q?MkHvSngOXLn2cQYUd14wTHwGjH2jex2sucQsokx8h+zXWmSr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f65461a-8848-48d4-df64-08df0e475e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 07:52:59.3334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r43f96g/gzwQHGe2hDIX7fTEw5JKjjXESrqA65m6h3F/b4UVjgav4vgm5ZUJdhlhmFuHxxpUlZ49DGMUPa2+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9594

> Change fec_ptp_init() to return an error code instead of silently
> ignoring failures during PTP initialization.
>=20
> The PPS IRQ is not required for the FEC/PTP functionality, so its
> absence should not make the probe fail. However, an unavailable
> optional IRQ should be distinguished from an actual error returned
> during the IRQ lookup.
>=20
> If a platform does not support the PPS IRQ, it can omit the IRQ from
> its device tree and the optional lookup will return -ENXIO. Propagate
> other errors from the IRQ lookup instead of silently ignoring them.
> In particular, silently ignoring -EPROBE_DEFER can cause the driver to
> continue probing instead of deferring as required.
>=20
> Also propagate failures from devm_request_irq() and ptp_clock_register().
>=20
> Update the function declaration in fec.h accordingly.
>=20
> Found by manual code inspection.
>=20
> Fixes: b86bcb299092 ("net: fec_ptp: Use platform_get_irq_xxx_optional() t=
o
> avoid error message")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Wei Fang <wei.fang@nxp.com>

