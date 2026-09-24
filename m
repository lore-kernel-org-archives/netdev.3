Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011054.outbound.protection.outlook.com [40.107.74.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586C45DF68;
	Thu, 24 Sep 2026 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246235; cv=fail; b=QXbaRB5p4CuQSWi9ItPb4iRYeaOts7iTIt2Z4bumvEcFutHfjNzHwV/AXabM1kbLkCaH031QsNW9odInHOU9iJLnBG+96E5hnabZinO34AETTnFIOxtn0YagQlnljZdSgxJRP18y+XtbZG67B3T7ED6qLCkaAEK1qmrodSxRQTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246235; c=relaxed/simple;
	bh=Eg6Mn1z++CUkcyepbRrYQez6Xe2WagwkychoWo/DS4E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=odJNY1apfJ/kWlUlol6etUCONZ0lSALkScsFrksNtmd+8r8GaAi3/UdeQHIcqlLsTjgoyGDUkME1doxUiTfvGGx74aGu8sNKSbDXYHqkmNsq9rjb/o8tNyauNGRKezzTXE1hz1O03i/KSeT9l8fX3dnky7ly+/i60lC6GaKnoXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=GSe6i7ps; arc=fail smtp.client-ip=40.107.74.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="GSe6i7ps"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bko4tz+nFwWnsrrifldjHhkLEyqsQEj1A9RI1ujkpZcZEkN84RUMqXy/FGaLUuBNl8tG1OpJe/pS4CgPrw7PGoRzCekxgmAK8q9hfzbp+3eZSHBTodu3CQIgZNzS0pak7qOrs0fo9RG/PnRqHPYW0Hg2EMk1G3aj2Um9CInBajcIbzOd+eppEQuCIx2JfMGouArHfCKiGD487bL18ttBrNsEgNsz0fk2wNpkws9RLGXvrUCrQuwcullpsMbz4RkWXrmGfkO39UH7hAASXq2pLDNOgRcQkQQSESlsBfrfX86tULneMGmCGNDfdduATFt49ltn2KhaF6ucaIMEPmdXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMS4xOp4pSQUDD5uqiCMjNeNI9Myw1d/pA0mUe3zgic=;
 b=hhCnRUMBq24yZRXSI2jnMp6hbL40MVrtEWKOUgxjfiS95Xeb56YPjOq/du163iQELwrahtTe1kfklQwC4RaQu7yZnnxC0XFB185nWymz96rjdAaZFeG3ZN6wMCBs8VG+d8Khrdh9K1GgRQ6V93/UgHb6hiC5o0AcvS3txVa2XAMEV27BPGDhl7Dz5x85PDE1GdcJ7/+6EqSLttxp5a6WtHiM6CPnUMeLIZcTcDr5242I4iGP0kxM4umwDCYKQi/hVsoWd8Yhh8f12CB75cY7Vk7AlNa+Qw3BhWaP5WUx6xveUcMEfOTaz1qvQBPTkcrlKM9AOYdicAMJvGSrd7Gs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMS4xOp4pSQUDD5uqiCMjNeNI9Myw1d/pA0mUe3zgic=;
 b=GSe6i7pscC66+eBddj9TM7jGwusVTm6TjldNzLSyw+HOam4fqgRiFUM5qbZj20t9W32KGY92oKBlS8yApkmRMK20iaz/uYTUr/zanaA62BNpWJtUHRnk/PzNZ/0YkC1DBJoui8sBWfc/ErrlWYYJmAjmtLTFt09xuEKBMyOMpFY=
Received: from TYCPR01MB7481.jpnprd01.prod.outlook.com (2603:1096:400:f4::5)
 by TY3PR01MB10093.jpnprd01.prod.outlook.com (2603:1096:400:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 10:37:10 +0000
Received: from TYCPR01MB7481.jpnprd01.prod.outlook.com
 ([fe80::8071:f03b:77d1:aeaf]) by TYCPR01MB7481.jpnprd01.prod.outlook.com
 ([fe80::8071:f03b:77d1:aeaf%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:36:58 +0000
From: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net v4] net: pcs: rzn1-miic: Clear MIIC protection state
 before unprotect sequence
Thread-Topic: [PATCH net v4] net: pcs: rzn1-miic: Clear MIIC protection state
 before unprotect sequence
Thread-Index: Ad1MDgkxGEUOEfMGT/6Pbl5yvy3Q+g==
Date: Thu, 24 Sep 2026 10:36:57 +0000
Message-ID:
 <TYCPR01MB74815955A10817B64BD6FB93A4812@TYCPR01MB7481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB7481:EE_|TY3PR01MB10093:EE_
x-ms-office365-filtering-correlation-id: 8e8c656e-b214-4aea-0927-08df1a27c281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|38070700021|56012099006|10067099003|11063799006|18002099003;
x-microsoft-antispam-message-info:
 FOMB0Y5RWs0KGNJPYBUFcbp3qh1jMuP3XMuXHaOLcpbLbFb41/b2qFkCUuhwf5UnmU8b0607fJ35MPFL5seiQ1A9zLjkd9slZnKGroXcmVyenXbo8/baQ+IexsYAS3yqicgq2xQ+5CtwxLq5To/vlwtO0kEk3vyJeoDGmXyyvy1Qxg6+ytquCqQzCxmr0F0I75or8QclMm+wzeGf8VbmtC3fAiiX//T2Xo4Z1/vkRKoL2nkxOpKQH6WVrgvQca3InrYK7UDHgLc4yUqGXa+iQ5HukpjMEnoe1CdlcksrpI7RmPDIrodp98vy87u13r0Mf+haK+HvXyzgdnBBXcVciVlsFGEOtucq9v+P1vg+rIfEJhvTHbFXnNKP2txoXi2StxEqFl/AR12RGaOhnCPo/XHh54q/zy0igCcRQ7ddfQf8xO/+jUPdd+wWXgroBxvXUW4KGhCezLdWWswvb99C5RsaPYtAKnC4m3j4G41UtBR6R6T3n7qhUV7Kwj32Iw2ekzNTVR4WnWu8IPEGREpgJS5mw5URbyyyvCnKE328NkFUQj9mrMuklf1VEKM457yOUX0rCUkhKmL2Yc8JbHokKc/AzF1ZNNyd4ellhn5WJEAF433wcoDtVq/fXRHTl4kjfYW9FadEAYBbk0da+LA65kcxFWDJVxGEDO7Q9O0TWPWzJGW9Jj/Mq02dT1M2Dv+2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB7481.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tppzrav1yxsPS0ZkMS5Ynz49E8/6fqgDGQvULT2mj/e58Kh+5yD0BhV4X8?=
 =?iso-8859-1?Q?9JfKum/0J5nmRneb0sFkGv7iCY3Ew8FQSeU18cxaobf0EVEDcWlJYdfS15?=
 =?iso-8859-1?Q?e8NNOsJwaRDSDV1DFwdSUvG8H7vkRR6OkT/fvgIKA60KfkXGpqhjqTHke2?=
 =?iso-8859-1?Q?27xMBGRS1cHQZzFS2+Hl3VcMCJBBwO1SCSLM9Y2QXvEoFjnnVUxHfGqwmG?=
 =?iso-8859-1?Q?Ycu8NDmJXxS2B+tWEjvOS50sF8vd4zklEa9kdiRHsFrDSF75bpwkDOZkGU?=
 =?iso-8859-1?Q?XEeeymUc2kLgRZ2pn2mvyXSGXyv6uyFHwplR0ddCWTmcXpuWDjgQ+WwnrD?=
 =?iso-8859-1?Q?0uS5nfC1HAYdQDlljc9JnV5abp2DC91tuR1PR9HNl639CrGSFN67CNSP1u?=
 =?iso-8859-1?Q?uOHXmo88+j0q+6bmpGM6GjTSMCSq9CbJezeOVMeY5pu+/eoKoyYx0T3pxV?=
 =?iso-8859-1?Q?V2TJxJwZinHw1zr5AnquX4vCsOjvrsAtFb1cYLDuGiglo62TXXc56U0buj?=
 =?iso-8859-1?Q?RobVK1fr0R9kbY8EccqRBdZdieYqzjUDqiZLZtCidJxzAoevuKHpEEFhd4?=
 =?iso-8859-1?Q?vp2FNXQRs4mdB+mEpyopmZWTo8wp50bZvoTYtULQALXowyFPiR/BU4Fedn?=
 =?iso-8859-1?Q?TFuN0mFoZaM16goQyE/vVQgq2S3OZbDRK0DhYEAzT5dUp+5pEQAs0x8LzB?=
 =?iso-8859-1?Q?c5s2gj12mKXd0zocMXY46vYQLjFg11/SIjHleZyXuEJUgvdfvebbJj3P1n?=
 =?iso-8859-1?Q?Bd9k/JPn9lWi2OHhqHGBnYcPgHdYiGpLQnZQ0/4kKSv8HT1u1kSqoW78pY?=
 =?iso-8859-1?Q?bNpiHDthiiJZ4LZaM6j1hzk3ajuMRTYUqMddIFdo0m0tnQCnYzgGTKDfx3?=
 =?iso-8859-1?Q?W9qApV7NbuOEedWdSWz73JWPy9pTk4f/ayIZ+v/mlzUJSCwovzJSuLP051?=
 =?iso-8859-1?Q?nHZkEWI4i8xsvvl+R4nSuETOQ9ZFwtyk6VftUA+CgAfsb3yXomYLAgl6O+?=
 =?iso-8859-1?Q?Y9R2pJhTEclak+lT6QahNCZaZPz92um9RREZwa6YU8T+xkGLATdnpXVRTg?=
 =?iso-8859-1?Q?+5X0UYoMIfDAf8aieLAinHmCdBibspkhp1laappZkFQdOrWpIdEdxcxRvu?=
 =?iso-8859-1?Q?NKpSq5VAtcJzevMKdRtbdkVWozZIr/vKWPEvHQzq9+ZVDIxSfSxTqgnBYu?=
 =?iso-8859-1?Q?8Z9PoJorv3gwKIhanvJ4/wd5ejemtN9gt0Qtg/PfCUm+OLy/+C48J/qOdI?=
 =?iso-8859-1?Q?ATaiwq+Qij3ckT6bx3CSp9Wu8KczC3ruXmQHp543T5L3fWf7566OU2xbS0?=
 =?iso-8859-1?Q?+/p5YIlOQbRsqgWxZKy9uBG62ddDJ5eLuRhxqzQJpJBlTT6sqkDV8cp09Y?=
 =?iso-8859-1?Q?eEAuIaPYP7lYOwUi/EJ+DiaqJnnkm09J/MyWWovoa+7NcAsb0qShzz60vV?=
 =?iso-8859-1?Q?VZ8zanUOud4TO+fqcuOCp7HwUXp1KvnBdjMCMneS4ylEJL7Xmt/fPbzHtj?=
 =?iso-8859-1?Q?njUR11dWS2oHZo5WtKKdPP2XRHklzcgwzhJ11PIItAEBBLmeyVmY9AudzQ?=
 =?iso-8859-1?Q?oTPt6o16JYhqSMkf9+EwTwNih92mIRoZpTZxnJc9EXMF0WI9Ft12Yy50Fr?=
 =?iso-8859-1?Q?w90PlHdcBq8h9G+/qfc8R+PVg+TeunbmNRN7UCbxWdsaO45isEuAB8v1sX?=
 =?iso-8859-1?Q?0ahBsfbk67WxDvzxeVHw4clRxuqSV/fi/Tb8160dHdlsIMwWJq2sy3/6p7?=
 =?iso-8859-1?Q?1vgLOSpuLuiQdYe4groSTihgFN1RY3JmNTzhvEJXp+y3YNs7udwzimfu2i?=
 =?iso-8859-1?Q?OXkioHv4XO1vk0FEhBsk5BK6U1v3avg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB7481.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8c656e-b214-4aea-0927-08df1a27c281
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 10:36:57.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKiDR8wQgITL0G+UNV1mkt3YzTFDC9uHHLIscmRUj3pTo/6ThzpgDYRBSNnw0o6VryfQ99F8JsRZur2bdk5xT8PuvsoQJRlQwGojGrDdwt85jJlu4Q23t5Q96b/2HNvg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10093

On RZ/T2H and RZ/N1D MIIC, writing 0x0000 to the MIIC protection
register clears the protection state machine.

The initial protection state cannot be assumed to be constant,
as it may be influenced by previous activity before the driver
takes ownership of the hardware.

Clear the protection state before issuing the unprotect sequence
so that register access always starts from a known state, regardless
of any previous activity.

Fixes: 7dc54d3b8d91 ("net: pcs: add Renesas MII converter driver")
Signed-off-by: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
---
V4:
- Clarify commit message
- Point Fixes tag to 7dc54d3b8d91, as the issue also affects RZ/N1D

v3: https://lore.kernel.org/all/TYCPR01MB7481CE8351FDB2CDCA229955A4872@TYCP=
R01MB7481.jpnprd01.prod.outlook.com
- Add Fixes tag

v2: https://lore.kernel.org/all/TYCPR01MB748157ECB6B92D8E3FFD433BA4B82@TYCP=
R01MB7481.jpnprd01.prod.outlook.com
- Fix indentation

v1: https://lore.kernel.org/all/TYCPR01MB748139F059DF2459B9813416A4B92@TYCP=
R01MB7481.jpnprd01.prod.outlook.com

 drivers/net/pcs/pcs-rzn1-miic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-mii=
c.c
index 2b72fa98ddf1..279f709c889b 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -270,6 +270,9 @@ static struct miic_port *phylink_pcs_to_miic_port(struc=
t phylink_pcs *pcs)
=20
 static void miic_unlock_regs(struct miic *miic)
 {
+	/* Clear protection state */
+	writel(0x0000, miic->base + MIIC_PRCMD);
+
 	/* Unprotect register writes */
 	writel(0x00A5, miic->base + MIIC_PRCMD);
 	writel(0x0001, miic->base + MIIC_PRCMD);
--=20
2.34.1
