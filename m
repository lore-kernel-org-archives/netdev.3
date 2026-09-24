Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010029.outbound.protection.outlook.com [52.101.228.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39A349CFF;
	Thu, 24 Sep 2026 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229821; cv=fail; b=j9jOfhfqQkTbpGl8rjCVlhmNWi8bmnWWRqyl7WMF5dAgUfU3G/tvKGmTYBK5bvS5WtvpANoEj0CRHBrYsbAQRPzXZLLswX8XHWmAuupqwtjExb79/MAJ8WqqPwm0Z5fl09P9tWlrgjN9BgIKNZ4Ta20IUQ7FN8Zq/h9apfLNyvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229821; c=relaxed/simple;
	bh=yjXho3s6C8XLwrTH9RUluVdcaAPV5wm5ZSuKmvPWLsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pf/Gn5eHlYOR2PpKLcU3siR1EqClU3ylcUsRCwpYNCNXZLfJdcbkF8nmoAU4K5lrXX6vPXghZjFVy7R9z3BJxGJLyR7k+c2mKtfp56c0Tt2YFtnEN8H2omh1kVIhzeuiJH/zBzv0aZmO55kUhD9I0hyyCKuesfZ2a2CuNd4QexQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=OYUIg+uN; arc=fail smtp.client-ip=52.101.228.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="OYUIg+uN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8AtSlARkqdmBHCs21R5jWNTditZ5qPuh710ZBGB/CR8ZuUMUx1VBlNea0dWrnI9R2jxLS55Js/9nDMrkLipvdysSOd1wr34yboj1FmHtuUz797TpWJUMsCRTkGBrZdH4DHjj1e6S9sKNom8EL6irI//Ad6IbTGnazRlxfR3zoG6bMG6JlzMeQMD/mTfUTP+wYeCJps4ErDfno7YIwXPDqUu2IbRHHflZyJuu4MnyIHjuwnbjslZbKlgag2hS/XCMaEx9X0INUCB9HWdBPO2wrZl3qlpI4BysyXieBNZ81ovNJZ7btJpO07WfaxQjVKfIMVZURWebDJ7mx/cowczpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjXho3s6C8XLwrTH9RUluVdcaAPV5wm5ZSuKmvPWLsE=;
 b=iyX0ek4r6lMg83bTbKdi3eTFBw8H/RQZ8SdyXcdB+t7p0zSNkvERagoSssIbZGmm8AK6Wzf2lRjEhsZR7fpQwXbLOTW1wAVyYWYFEOlvu4YkcoE7qVDQFdTOf2U0AikJ6qbuGwwZ8fxXjCzJXSdWIZC2a3z5Y2K4DHy9SyRBfgrk8RfHFNF/6ns/RJk3E+eX0BajciS1p/PhjPIlqK/uJEdRSmD3sk34/ra54pgmJ4lMD+4lTNoCzDMKJ/6fQxF2wwt2K1T2G1m6fRWFBFcvdCrPw0auQLkXIM7u9KQUZNO41yk7byBS4Q9hlWBEgBjtObhRVYbH7j7HCuuUNF5uQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjXho3s6C8XLwrTH9RUluVdcaAPV5wm5ZSuKmvPWLsE=;
 b=OYUIg+uNb+fCIP6DPhfIT2mJ2Dw8Agf9EzuTHmYghIf3q6gjscp0hL7O7JQxt1V/qitvSulC1D2JhOrG7nobEboB3XlZnAIUhwHRfcbcu1asEBRUV0orhPo6JMPsQDsTflFAM0YpwL9+PX8aAV3+Dq6n7BwNbRKKPW0Xiw6EC+4=
Received: from OS3PR01MB7479.jpnprd01.prod.outlook.com (2603:1096:604:14d::9)
 by TYYPR01MB15561.jpnprd01.prod.outlook.com (2603:1096:405:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 06:03:36 +0000
Received: from OS3PR01MB7479.jpnprd01.prod.outlook.com
 ([fe80::1ddb:79b8:584:4fc]) by OS3PR01MB7479.jpnprd01.prod.outlook.com
 ([fe80::1ddb:79b8:584:4fc%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 06:03:35 +0000
From: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "clement.leger@bootlin.com" <clement.leger@bootlin.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v3] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Topic: [PATCH net v3] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Index: AQHdSk3QskULaBVyuka57WHyJfzw9rbdOq1w
Date: Thu, 24 Sep 2026 06:03:35 +0000
Message-ID:
 <OS3PR01MB7479E750953DF2E157518996A4812@OS3PR01MB7479.jpnprd01.prod.outlook.com>
References: =?utf-8?q?=3CTYCPR01MB7481CE8351FDB2CDCA229955A4872=40TYCPR01MB7?=
 =?utf-8?q?481=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
 <179005258996.2160803.11359360903588205993@kernel.org>
In-Reply-To: <179005258996.2160803.11359360903588205993@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB7479:EE_|TYYPR01MB15561:EE_
x-ms-office365-filtering-correlation-id: ab517ee8-3ac3-4440-a017-08df1a01920f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|56012099006|38070700021|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info:
 tQp3C+XHhTaDq674Jh1tJ8aZESI51J3O1ya6fzHD7pFgaf1TdEDKE5fb6Fi1HZOdV8wWZLiwflsCerDlbLSll9D+Br6DRavUReU1/whKUloBBllG7rX0lQZKUL9jBiTfwXV/sMbj1xjvQfAq3IqhJmnrjhRbahWlYeNdrShPclSHEqEbZ4n4EMRMJcaUWCb5Zak1AMP7tdMc5PVqZ145/oruTLewNitiUsYFxTOqJ73UNo2qoznSitVRaJGMSs1R7XZJg+SYIRpGUeahI8060XfuW1beaEGKuffe8AhNUiMFtfwmcastlJq1L9kX7TGJIjgVskwNnRo1v8rb5ojCfTpvz2MA3nn1XA58avq3znoaSZ5JuMp+cZ2hjC5hcNLppyxrjzPtNUVybt7YGcYzl/EthCtI0ySlZduWaGDjiVfaAjuf4uS1d5vyy81Duo1AzT5wvxO6ub39PxxpN/gV9Pjpu8b08UeJXNYqptq+yodOjmQRyvjEMnj06oFaBFD0GuUBiU/CBUuZ9iPJBvt4VRFqiFI4l4SSonrNjAC3LNB2MBpPG+4/c2h33h0jRexhlzrJkft1KUaYU7C+PdZWLmYqbkwKIk0z7+O9yBlZFVccQjZ2+h5I+oqR63eOwXftufAVGIobUFnH2D1tsZ9dxJyS2rdJFy4dQz2wIfp7yS4M9HqQ1r7tumq1ENJetYaJMhncpXl1z8Mp4ST5FEbqd8dwnkJdUpkfURa1iW2cdGo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7479.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8JK9/0IM+JCr8EEx/WmZSb6OjJsqEqMEwY+Mdi3jKQxuaK7m/Cu8ARCMlo?=
 =?iso-8859-1?Q?q+g9mMwAQ8Vbb2MS1D5zxG7b0N59Im9FhqVvMVr68mCznj4BHjtZzEEIkB?=
 =?iso-8859-1?Q?6SNDhpj/E9gZXFFd11AVBM/NyhSNlTDxcYwBQaj9e/2mcLFX7m9TenBDn+?=
 =?iso-8859-1?Q?juLKMG8ATtJAoQeSnhrlG1pU8iioAqCDZyaqlRsIl3IOUx56BFIfKljd4V?=
 =?iso-8859-1?Q?Icuu/kPD5Jg6SlyAVZwp4TobE9UcQB0BdFAey2QdeuA6QiHvymy0KCbFUz?=
 =?iso-8859-1?Q?p/ShGg1CSgCrVK3vw6g5Zm2RoQzucKhxFjTKASZKEqaEV+JtAtE/vl0oeJ?=
 =?iso-8859-1?Q?BVp7mkGtv0Q9iSPl1EYpvpEEeRxCfu095/ofeX296QKkNwXra66JGawBtW?=
 =?iso-8859-1?Q?HbvWQC+YzAZdlKs4AgM3aqAVItjFZB0+mr56otueyj/OH2jJINo7Ozyeg3?=
 =?iso-8859-1?Q?qZ/9sxAUH2QK2TbqEH+vNTKQEvppMnCzyGid87/C4h8ln5Edk81FnOdsjp?=
 =?iso-8859-1?Q?FFK43a1+KAHCnjPYxfIqJqoRyvAE3uUHz3rLkObpG8i7drPaQCc1B1nEHI?=
 =?iso-8859-1?Q?eGJ7Y2irNSDwHLH7z1jWvk2fU6cFkvya7iKeR+g4aaDyLtf1rSGr6pPj/Q?=
 =?iso-8859-1?Q?MZWD+isqQFAMyb0Z7kPxm+PkEVWR6Bzg0vLt9zRU3J3JE5O/D9LQSlDyxC?=
 =?iso-8859-1?Q?dzwDVf7dnXibCE5T7nMuUjg7ACwNbKUU4OUt9MnucTkx7O3sOA8h6HY+GC?=
 =?iso-8859-1?Q?hSOudPPOm66CMWumh51H+QRHpF1LHVuMJi4gD+wTWwR4pzijpYlOKibX7D?=
 =?iso-8859-1?Q?ZDZI/iE2n6U5ZUIQiIDdd4ZeFIEyNb9GxFbh68gTd8sJ+eLCfTaTTj/JEb?=
 =?iso-8859-1?Q?UKaOryAE+8FS46ZIKcDpgUnGnti7k66cdFEo10Bzy8OpCoG7/rwaAWb6h9?=
 =?iso-8859-1?Q?IS31oQJlxoDUia5Nfjfdhz/G1XGircvYL5U/S1hV9ugzO45cpVBxT1VHoE?=
 =?iso-8859-1?Q?6mVWj+q3anqYMdJMVzVq3hJHJyM6V9OF03utX+NSMXx3Kv7gc/rlxRFHox?=
 =?iso-8859-1?Q?xy5lC1HVqhGvZkx3UHCRboG4qOuoIfPAbFk38CcqjFc/YYpknokfWe4wD9?=
 =?iso-8859-1?Q?uYmMyf7znATYWtK/OrklumaQK3b1TyV2xKjIASqBsyKn4r+Jps8IsLJflD?=
 =?iso-8859-1?Q?e94JdSv0E6OMF0b5sFjEBstAbD9nVVmc88U/5Ix51MRNGMLhSGjVrOjtmc?=
 =?iso-8859-1?Q?SH5yj6PCCJOuLmR6OSGYsZZIGqMFjC5zuUe2XTyAEUQKYNOOB9U0J/aLxN?=
 =?iso-8859-1?Q?c0/IzY9IN0NFuKCQAvg3dBCO/eY88o6dlpQknZQL9/k+34mS2JgL+1GkAC?=
 =?iso-8859-1?Q?W02OP2dfvneiA75ZGAW95iTwvOO8jL/jxmJ0XGG8ZkGLMx90WEpEpFPr2p?=
 =?iso-8859-1?Q?rXvUNCl0A/eQZ5bcDCUHgSaZ1YgOPmfrjQBuujVmNaUiJRbh1KsouNosUl?=
 =?iso-8859-1?Q?R2DTRYFgQV59XVUA+vnKKiLOuNQG2b8rYl3lRIn20aCGrI2v9g6y9HJrpz?=
 =?iso-8859-1?Q?rO6V4is8L/oNkkse7jBrvWYJAO19QdGmekYe3JVMSSMeZn9tO9mjvvBeDZ?=
 =?iso-8859-1?Q?6udRFy99E9xDTmejW7uDpZ+DlUCz8qaq/3Z0Lbwg9usR78VqvCU28broTu?=
 =?iso-8859-1?Q?Y5rHHaw0d9AR/tEEYpdxDaOPsYLCuewwWfLkLZWjqcIQ0L65bDfIyuPol7?=
 =?iso-8859-1?Q?4yf5fmeyY+AyiryC9XyGJUtWQfSVDc4MKWYaHhhHEJD3AIakyAozfsDKkN?=
 =?iso-8859-1?Q?0uBTvHhPdqjespTP5fbfkvo/v1JBr30=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7479.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab517ee8-3ac3-4440-a017-08df1a01920f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 06:03:35.7536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gsiLz9xABJFKECe/dUfS4GBAjF4VoT3jN1Xhm50vCOmnU011mQJ/MCOV7D2/ZwY58nzZDfAxw0xaKHAQKlnmw4qlD0ziwjj0XuUVbF0sy5qDHIaUm6FCOcvUjwUjrrU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15561

Thank you for the review.

> - [Medium] SoC-specific PRCMD semantics are applied unconditionally in a
> shared helper: the new `writel(0x0000, miic->base + MIIC_PRCMD)` is.

The unprotect and reset sequences are identical on both
RZ/T2H and RZ/N1D. I checked the hardware manuals for both
devices and confirmed that the additional PRCMD write is
harmless on RZ/N1D as well.
=A0
I'll clarify this in the commit message in v4.

Also, I'll update the comment to avoid using the RZ/T2H-
specific register name "PRCMD".
