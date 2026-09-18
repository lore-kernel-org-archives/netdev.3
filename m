Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010036.outbound.protection.outlook.com [52.101.229.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD532ED21;
	Fri, 18 Sep 2026 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789705823; cv=fail; b=tpB4ncEqBPAx7XsFiohEPJuhsL//SVLyvCZh4yS4OW6y9yqeDt2DtzisT2WQsY17fuZbHJR+ynHEMxJXFoMWv0hzhNblqJ75bUX78ztY0O+36+M1tB7+fos+3fKAd3stH6mQF/fi3e6GTbyBmtYz9jdbp8n1hIgQ4e66KCVqri8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789705823; c=relaxed/simple;
	bh=L216I3W634iuk9FebVOTmFkM9FSo4zfueLfo5J7HvjI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NFYpqZKc+MmSTtPMASAizVYiLPATTV3UMuy0SXIp/YSqrLR1GwhuvKPcW4HpxQE569n38feyWrIIKUqhHMeQo9xsIU4nR1TmDXrk8dBWS7am8n1V0WIpN2qlmwLLiVGLuTxyRfgEFHI2TjVmuQg4Xym5ep89kXnXPvEbi2nV+mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=K+pNnmEm; arc=fail smtp.client-ip=52.101.229.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="K+pNnmEm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWlU71frw2VvryuWnfETywu2X3GjvOqRWbAJKH9oML0zm/siXFTpdwnSWpIeOOrYgMJ4v4doSaIOnI3zc5E8U4LYptGoYFZVOIoILjnK8K1E/G3XIqDq6Wq74CnXkPLOkgDIk6uarzvtRbnJ5YT1IONMCBU2HTTIcrB2k5wy/g6N4yiQ7Y53cuttBiMz6ojZ4qJxRKlW2K6vB/MgtroduCTD6yxUuSfW9IWXalPTwA5/29sOmgYY6L9AjKOJG4K6vMhieZ7coRTLnhhRbHzSI/3tflppoPRWMwAiu6aAyl30anrdGsihfSPQ/wIBOQR8r2awmoMGI4pteCYYWk7dLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaCYzECCFpS6tPTPzxFpcw2KpHgWQQDUVT/y3NLLRXU=;
 b=P4lnCVmIk21FqKoMaoycVPXPED9cxzrZvd38/+EXAG41nRCHknND2p05fYcB5d5W63xQkD8+jti2K6VX0EsUnYQarYjRLI4HkyiNLafoH8bkh2eIfdQ9brH/eSQyMD/cw7nq3u2zKnyrF+zbW9hDiRA+5rpTgzgT/QiXXS07HTWzsOuzvzP2msinXiqf6ASJpEaMG8M3oB4rzYM30h9vRrIxj6GI+fXl8Eb//aBBG3DvA3rPro0RyDcN42AUeCQw49VkblCyrK4umhNJmJSRs/MPfeT2HdNPJfcqoCVz3StUKv0jJtaKOdqy9yioyoFk2Iet0Y9uxCSAB3ColkL/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaCYzECCFpS6tPTPzxFpcw2KpHgWQQDUVT/y3NLLRXU=;
 b=K+pNnmEmxXPVuQFQAqr9s19gvx67FBLlwvMhqcHbfVniWU80CbK4Yw6Wu67GZTggkQlK489z16jGHdqCRAWuRGxWdsQ60A0j/UMN1434ujj8UKTPaJbzqAXEr5TawqLHrvuNc6iWzSoP8JPy/yzn5nMemPfvmBmGRbmiadR8DSU=
Received: from TYCPR01MB7481.jpnprd01.prod.outlook.com (2603:1096:400:f4::5)
 by OS9PR01MB12372.jpnprd01.prod.outlook.com (2603:1096:604:2e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 04:30:16 +0000
Received: from TYCPR01MB7481.jpnprd01.prod.outlook.com
 ([fe80::8071:f03b:77d1:aeaf]) by TYCPR01MB7481.jpnprd01.prod.outlook.com
 ([fe80::8071:f03b:77d1:aeaf%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 04:30:16 +0000
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
Subject: [PATCH net v3] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Topic: [PATCH net v3] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Index: Ad1HGbSgtZ0GfGRfRzuoBdIzDmUtDw==
Date: Fri, 18 Sep 2026 04:30:16 +0000
Message-ID:
 <TYCPR01MB7481CE8351FDB2CDCA229955A4872@TYCPR01MB7481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB7481:EE_|OS9PR01MB12372:EE_
x-ms-office365-filtering-correlation-id: 27f4b028-1e1d-4cfe-786f-08df153d89f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|18002099003|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info:
 BKTZQchiJbD0FBUyKdMnWJGVXxeriUwt23EPZ5txDWWcgj5NxTvyolJq4aK+W/ok+GLjyQB+8I/SCUKCPMTgGFkGvrkLPzhsUf3acVTiwvF2DzH7mNa+XowPT//KGFJKtN6OgytTwYvvVxkN9GseSsy5Icc3+dRRii5YJ8mXCB6IqLjuUmI7kp0w3Qv0OLHxqapqhBUWqyy9RfMQcx5jmqk3X8HeivvGrVdiKaWY4ibHwo6b+Z28LQ2c+BEjIO0funLaMJj8DJJOD4u7n/fhAS93a1py3iIlRELEJ4AWMV1h5ogL80P6BH4EcYR7zpkbInHIw1d3JJBA7uNeaZ4kb9k7LBjx02+YtblAcPTHqzzEepvUUUTBaz9X6Mn1f0FHcGQLYyk1QAZAPIvHIasU4v7fmGtFmsk9evGaUaqp8okFbEhaqFn+cIuZoZFjK0r7K7MNbBdd0cEPxKBh4iKFwnLX7RNKUnw0q3uenztVzXipiMefeZTvGwCZ8CU8SXYtpbznMgnIXYtBm7p6Ov8WXBaiMYed/0u8IlOgw5uwO5zfUKWef6Hr5Mv249XGiLudh0CUS03DZvBaPjf7mGCwpLAE4PHhDVePNcRQMy9Mvutl8++0UgOHMn4fYjqYhKN4Em3/gr6O+55/iHRi9/klJwjPrWib6Atnn1vg36g+3wjVQFaO96MQh6FIX8eyz7Pak0E7Yh2RXBTtttyLQ3B37uOqvMCLuvqRmVUJE0B3dIc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB7481.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NFcixv9npNJFrRP4lRemsiJPZhrBbB2DSShA32p4VfVd2TF4OXEzF+pAev?=
 =?iso-8859-1?Q?6jHDXj/P3jHWlDKPBCWgadpE9WtBXjYpRtvbZME+x1q9JVB2ztbrJjoNWw?=
 =?iso-8859-1?Q?mqzl6P0jw3JNvN+w3FI5/EzB3cUf5ebfpUYDoGnc9a0oMoVPiakWXZ/ZCL?=
 =?iso-8859-1?Q?h9E7iNbboPnTZMlbXRQZ+OieFn1QRQYtSEzcbyN8PLb9fqupXi3cQVeztB?=
 =?iso-8859-1?Q?347Gc5WY3USMaws376+FXKQ9E0jOD4ADTmfUFdM8UmFAG1ZTa1YFftsIbt?=
 =?iso-8859-1?Q?DkyMLr+My7zW/Ydi2uDL7he4M8xGYaZ5wYoUoN3+LguzlhK0JDFbR0zFDE?=
 =?iso-8859-1?Q?GylqWzC/TcH15ahtvuZX4eizPvZMCw4go6oV8K1itPKFwLEu/A2MCQZIAT?=
 =?iso-8859-1?Q?wXE/Z3ztfVY47zuDJ+LonQ7vm1P7MSdvuDYf3nXliA8CPFR10XwdVDV7J3?=
 =?iso-8859-1?Q?P6jF/3M2va/tAAm65eDASleI5Did8F2mIFeOH41LyU/gwCROKNxzStBBMZ?=
 =?iso-8859-1?Q?qdH29YkrB50+Lama/4mqlIAiR13gtcfJaDyMliuMvC9EqEVEiLfAOItznL?=
 =?iso-8859-1?Q?xP7AbkYt1zHuhzq1rlEqxmfMVT0so1PgNNaZiJVZKYNIQflJ95lU9LSkW3?=
 =?iso-8859-1?Q?YMPfzQPq3cd0p8M270xt9LZL9Ba2OhO6/j1Jrw37PhvNpoLVSlHs4+676b?=
 =?iso-8859-1?Q?9cEPsq2zCjgYgc8KBA1Vy2QzN+0HSxM4y4uuyy7B7LV8jJuJDjoxUvRynm?=
 =?iso-8859-1?Q?grrL6Unyin8Li4dSHuOMW5oqpYqtacYgo+prRJqo4ZP4ACSwnv97pIkCm1?=
 =?iso-8859-1?Q?/QJRUbKtL0BKd78T5j05ONEfpXg8cczkqPRyG7nOnpViSiDFwJKWJd5QeV?=
 =?iso-8859-1?Q?cA6/mawKk/ytvWgjtO3Rlm98EbKOxOQJgyzagJQEOB1WaW20XSqjOqISyJ?=
 =?iso-8859-1?Q?T7UF1lSGAo9H0GVigJXBAuTcuTGhcSviHZT+VWHC2/4B0sczzWx6s2fxCC?=
 =?iso-8859-1?Q?3Ulyo3s82H+c+gzXfOng1t8PGRbEIXLqZ4AhW41/WF4jXT/dprNlE5DI1l?=
 =?iso-8859-1?Q?Y4OQdjb+/6Xm3/E+Qg5pIZWbywkXfvv3Wb8t1mvCRDDGR1HKCdLX3xVRvL?=
 =?iso-8859-1?Q?eD7yWSDXRJRKuAfB2HzMc/dvrx9B4u2QJWA+Y9aCPlaz6EOy115hLXrfJw?=
 =?iso-8859-1?Q?4yxRl8DmCdLJkN3/nSlAEZjQM6xlAGyMAGTWmWWzBzt4G75Xcuh3udt1LE?=
 =?iso-8859-1?Q?tg8OLR9qJYIpThtZy+SaqbFUXEbucx+Q/B0yMet/Zeu4Idb0Ah0DWpupCp?=
 =?iso-8859-1?Q?pRXkeKOTmSpbbbr04SiHqrbCKf2D7h5GuoNWd2sykLaYL8UfTjvEQrLpEC?=
 =?iso-8859-1?Q?7HJ6kD1KgtbgXeMXBsz4fx0Rq0CqZha+VvDh/1tr7nZy/GK4yl241Wqu0Q?=
 =?iso-8859-1?Q?Uqhv9SML1ECKrWHB3DYhRAfVV76KMdNfX06rP+j4yHyxDkJ8Wdr2rk4MGQ?=
 =?iso-8859-1?Q?w6xRENV0GqAevQ/XBxdbx2hx8TLCiwPjpvs4mPGQNqpbew1m9Z900lmw5e?=
 =?iso-8859-1?Q?w/Tm8lXuHoQkv0xawEYkcSjYI+LbWdr8EoxQshv67gSmYve3WsEiCaplCm?=
 =?iso-8859-1?Q?eNMkoMaYrBa7Kw51nVKSMYfaXGeraeTUTbVCYeB0LNQBbeSqaQ/JDFfZ/A?=
 =?iso-8859-1?Q?iUyTMoO5dIxFEuEGztY1eJE0d8xcOUG9Qq4QXXc9QqcKBCf4I8a3/IfUmz?=
 =?iso-8859-1?Q?U0EEzrvOhH8hNHwXiP7Lx5I/TXd4goCKMyKn4V0+8qy1MdyxbX2T4Kz8Qx?=
 =?iso-8859-1?Q?ngnWRm3YM4e4wT2qRtlIdDH/KBry9mA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f4b028-1e1d-4cfe-786f-08df153d89f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 04:30:16.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYpZDeGsLmwAMgITFyDZxuQxMIuIQSPNS1Nqu2j9lBQe9gJGFb6vlYhE2FwIWEa2wrgcxJEsli/vjOobf3EFmU6V97x+anI3V48GSSx0cZ88lg/yxod4lIstII/dAUoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12372

On RZ/T2H MIIC, writing 0x0000 to PRCMD resets the command state
machine to the IDLE state.

Reset PRCMD before issuing the unprotect sequence so that it always
starts from a known state, regardless of any previous PRCMD activity.

Fixes: 419747319e3a ("net: pcs: rzn1-miic: Add per-SoC control for MIIC reg=
ister unlock/lock")
Signed-off-by: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
---
v3:
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
index 2b72fa98d..818756bb8 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -270,6 +270,9 @@ static struct miic_port *phylink_pcs_to_miic_port(struc=
t phylink_pcs *pcs)
=20
 static void miic_unlock_regs(struct miic *miic)
 {
+	/* Reset PRCMD state before unprotect sequence */
+	writel(0x0000, miic->base + MIIC_PRCMD);
+
 	/* Unprotect register writes */
 	writel(0x00A5, miic->base + MIIC_PRCMD);
 	writel(0x0001, miic->base + MIIC_PRCMD);
--=20
2.34.1
