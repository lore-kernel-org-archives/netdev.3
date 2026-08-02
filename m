Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021097.outbound.protection.outlook.com [52.101.62.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85930E0C0;
	Sun,  2 Aug 2026 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642454; cv=fail; b=ANxT/1hKCLLF/QN3wHcpJ/4I+2Ivm173SKcybBXVuLHUBb00LkLL6sOc7wzWdiae/vbnsbcsiEJRm72LzrwpUepNdOzz1lod3JIP1Z9gFXGTBYjc/JOTkRhrSCv7rwhdWXc38yGT1eK/sRjBu4fWknmqC4Tb6fhrVsieS4ZGoyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642454; c=relaxed/simple;
	bh=Pr3yIMARJH8Gw2pm3LNaKPTKBo8JPf+1dhYZ9XRWmgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aeDlBp61KqqUkOn0BhAXlzGGKVKL9ag4KrZgrOD9WAfANpkv+xdr3TY8vaZSmWkN7mnEx3SLwsdcKqD+PlkkNv7TbGLpCD0bS4WgjASzrwY0GhOhrp2wcdDcD4wClj2hY8h16m15xZpG6MYS8X/rED7rAPerooGqnpz5ayqb7xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=bIVy8y73; arc=fail smtp.client-ip=52.101.62.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="bIVy8y73"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6hjv624mvQjbapPMigy/0N/KS1OHSaKlP7tw4BbyZ9Y8dIzqooqKua1XoMffzIUjogo1GeQNJ78AVDwDT3xWL3DLkDdvorbijjtlGW3LmDlqDGwEBOlYVKY1pcWZG3Ml1tbd9Z3JGIB8uLbBEGazcXLtXQpoN9LxUiv1kxOJCX3HGjT0OjdozWXhOacuoDTZeNwniVrSbb1tI2iYXFPWCl8uDZ5Rf7biM8qP3ZsN6RMaBijX5wtWa9/kNY++Bm/UkFddOQoJr02B8FD8xUN4QF7AY2VXQlXpEngiWOV5lSIwVvMRDJnP6Pq7NpIQ6b2QhZATLJB7zVpOiLTFcuSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVlDD+sHtDfraNhZsztpY8YDA2sFJfEADaXf1m/z4KI=;
 b=QupNnBBz5U6BmL6+9/uV+KOzHSprtWNhlkGUZXu6QE3XqfveFfxYkvR+KwLDvHYsbhzYQgiw6TSqkfpMTQy66LeyjoINSHzttarFdKpynFW1TAwfNU3SBAU8m72eBMbu6nq4QD9Eh4RB1k+G0UoL1hIbZG8X7Tp9ftwaOD0hkTrANul0Iv7MXQQgw3fpbDLsw4iA/gYfqrXnu4DOmGc0XF3YGj/b6hU0JlCAm/aOYZI1ory7wPrlyN+8erMC63d3NiSnA6ltii8bnXt/NvBClC8Sg6MY+pACWGpBcGiIE370BXDhoIGD/jbhlbC4EcIPUr2ZlAw7Z7QvP9iA+XRA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVlDD+sHtDfraNhZsztpY8YDA2sFJfEADaXf1m/z4KI=;
 b=bIVy8y73Fo2YKcKFHzMQTWUWqYhpt9BucmOJxMpQ/glh1P9aKB09M9XtD3Ub6a9xCeuxOTUGYMQDWVGLiQdIM0nPZR18rqxk62qla1CoxQhBhISY1CRwJ/5E2M/rvRp7P95cbsWZhsFsHRw1yzO4ZUMWjg9Gmt3mHPtJJ3KxAjYBV/xb+xHJcw/yJXJTaGmVUTwBi9PBhJfoqCJXZhHoyGIox0e9Yfjg0upkhcu9Ehnmj+UlbTSJWJAKD8UlcKr5BO1XL8ithJv0wCPnjJU+ULaytLPPMTua5+oUW6noz47HaErtCmNOmniM4aRDxHde+I1zRQIWML2rqY/wcqex2w==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by SA1PR20MB4298.namprd20.prod.outlook.com
 (2603:10b6:806:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 03:47:30 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 03:47:30 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "hzyitc@outlook.com"
	<hzyitc@outlook.com>, "lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next v2 6/6] net: dsa: qca8k: enable assisted learning
 on CPU ports
Thread-Topic: [RFC PATCH net-next v2 6/6] net: dsa: qca8k: enable assisted
 learning on CPU ports
Thread-Index: AQHdIjGlSD60xbmKUkKeAIbQct0HmQ==
Date: Sun, 2 Aug 2026 03:47:30 +0000
Message-ID: <20260802034701.3339052-7-brandon.mahdavi@mahcom.com>
References: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
 <20260802034701.3339052-1-brandon.mahdavi@mahcom.com>
In-Reply-To: <20260802034701.3339052-1-brandon.mahdavi@mahcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Mahcom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF42224DB53:EE_|SA1PR20MB4298:EE_
x-ms-office365-filtering-correlation-id: 2adc8630-5508-41bd-b012-08def048c780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 BA4Y2j3BYpWiObnqm4+gkJGML4bRlOJoJ9L0ocN/foGn8yy3QSAuv+nocB/SZNFtaxHi3ZXp/uhHFxcPcaYjjaXW34yoAUYXfqGOipbSZXEHzcjOYju4Sij0rC/g2fGPLVkTMUzRjPDqFAyUhjcckYYyflcVvaggmlgIDiKlgJCt69c9GaZZYqoSUbYu0nbh+68UlqPLsXgkmYM1ZSuqHfw1/9IWJtVhav+enlcKkYofmTOri5qXvTfgmQN25hoUFq2le3kzLdPt7dywu+GiJh70gf+hRy71XvbW3DunTqmoElnXw8HmBu5LUM0ZLlD3lbdYqkLDPtJMPLE+INid9ngEEWxYuojyBQfTw5mhwoKx7ipxSlPTgqfwxxC0wby7kUr0UrAL65VsvUKmmppCimsZS4b6xh2E7Kka80GvxDmyyuciERak2m+UwFVlBq8+1bmyu9E6lhjQVS6TtlRov0wcawQIlRQChH1hquMujWn2d2dR9NxLTosT9gFsZi9d1i2Aut03B+LL785MZmAlrZPKDmNpjbjHpe0mozXnRN3WW7bd9BODY1jqlX6uBvVYI9hj2lXP6W7MH7V58Wj8/miBEFWBYx5QFMwGV1FgBVUJmEHD9uF83h77vrcqFhqXAqzn4twPWWlvk+kz7as9WZTrI9cCVMzeOuIoe0KMplgty+TkEBc2Jscnpt3/ORCg/e2X0/AIK57qNXTizP2PINtvm8u481u28c7Ec/zOO4I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?inGiZA2FOrSRWfSkt1PxCoM0s9c2XCznlmi+OSoHT2FtgY6Smd/gfRztxt?=
 =?iso-8859-1?Q?9KPtv1dugjc5f1bt598CsbRJzmgda/J28UZh5ChtMeYPoATGPM6I8PXaCo?=
 =?iso-8859-1?Q?gj00tzkzM0gDLhoaRsKGC9Sa4Ccaz9TxO2WDvkAkjc7fDi2Bj4VbbLi4l/?=
 =?iso-8859-1?Q?JFSGe7GAGlYifXjqPjphJCmBlpDWEigTga9B50pwQwAg8fDgmmBYakbHnf?=
 =?iso-8859-1?Q?68Wvnvsju6yCHs27rAbtL/khbFH7gJzHtb+SPZjQfd34/ZQUChiBY++bi2?=
 =?iso-8859-1?Q?PsDkocZVaIVuoY8blZaG6i4ca9+aOU8x8OvapxW+ERI/UKSSug//dBCXmV?=
 =?iso-8859-1?Q?g39jDrNpXtONJrDzx0E7tk+FT5dtwFWuJgvkfycY4rYqh8aSJgo52bshkM?=
 =?iso-8859-1?Q?gWqgyIbfSgZl9QM4dUE3Ox6iUSjI7FpYjehU5obPr4m4qkTxmE/5T/Tlgd?=
 =?iso-8859-1?Q?tJ8kptzteLfj8xeQIMlf83gYBXTCafLUi2j9mZ7XSf0rWx0QB8Rnjhm8fy?=
 =?iso-8859-1?Q?TFTeqEdhoJwrZyS0WY8E+6dVAtH+5YsJE66AtnsaqhnlKT694WXT9VvOzF?=
 =?iso-8859-1?Q?3XlarF56jZaJKiIunwdJI8+LEts7vfAGoGBnLgAUunxZ6gOFmf8EUgOxhX?=
 =?iso-8859-1?Q?UKkkR6AT+km0McLOtOSZ/eLDDJ3QklJIMMpRJbcNP9UJcUbS7iWq9x92mw?=
 =?iso-8859-1?Q?qg0EZfs5hg5hslxSqgDpFZ50gbqRX3YGZooNualPRakMdjm4u6ABAMGPX6?=
 =?iso-8859-1?Q?sBhONs/mOmyvJwPikEZSap+Sf4XAfOLbn1WvDtXmllYeYR0VolF3qlroum?=
 =?iso-8859-1?Q?gSasNRATVA0rq8U1EuuBTsnjnVwgV2fU1trtuh0Xi3CJFAVgBokSo6oq4l?=
 =?iso-8859-1?Q?ev9e25uBgjQaPqx4+f6t9bljj078Ug2lpeTaAVJcwUrodQ96YASYW/M3e2?=
 =?iso-8859-1?Q?F5sdT4VnvTIxv8SbFHGccahTm58vJo01/THGNG9IcCohshQW3BWC2YxK9s?=
 =?iso-8859-1?Q?tXUIVijzcs96AJQWTsXrgecSIiE6kc53zCqrttCn+NeoNPhzj1uKsoJNdh?=
 =?iso-8859-1?Q?uY6PB7Dg056MUloL9WBSQSm/DU8p1EwcyPvIbRUBhuujWmP5y/mkHQv5O5?=
 =?iso-8859-1?Q?HweVoAqPJEaWmOCv6G1YkhuLnx5CpEcu/D/Y+G9YnahjGJBYATq3K/CXFr?=
 =?iso-8859-1?Q?abbTKgc/kUKdfLf3eEcAMsBBql5dgU+v1ItXUDt2ktKMsgtYuiuC4Ssxmb?=
 =?iso-8859-1?Q?jjVkzAhx+KcANwtCrM6fX3NTjRFJLcrkhh8b3MC5I6iEv12jGVlagUdSCK?=
 =?iso-8859-1?Q?YQIRg62J74pZZi4aYXAcdtsINfDBWArEFzYT1WWotf3cQP7sgpM3Hi5Qx/?=
 =?iso-8859-1?Q?vq+7q/1LoldWvP3CSJHQUwGqiuYnWlLTm7rI9oR5PolZLzH2ZPVn5po51F?=
 =?iso-8859-1?Q?SaQtd4U+kIL16e+GQn/Id61ZnD2f4ZAeEr9f1OhYenkwzh3JIdPUflMkGx?=
 =?iso-8859-1?Q?pRO2+ZnA1S9JFrDTRIxYtj3pSzpWmer4IFB1VKP/sgsY2AtvcKThnz/GO2?=
 =?iso-8859-1?Q?r6S8LAD+YVs3qXHKuhC/H0tfWSqAC7imJKazcTn4jLNB5adAtVaYm3KFGD?=
 =?iso-8859-1?Q?rFsIhCfljZvS7MFvsFtIqvsuMeFbPYkuztpzkAFHZXyPKehPenYeruDYxp?=
 =?iso-8859-1?Q?a3MDo8CjhLARY1GNa9YfKJczTAz1MZeekC2cBIRhdxYgJTRth+N6wrfoB2?=
 =?iso-8859-1?Q?Bnq5OnsvNnkYLJTwxDlM+o+DabV8KJ6I5bZmylv3bJXltUmqKq40EnfMui?=
 =?iso-8859-1?Q?IzKl53KxBQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Mahcom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF42224DB53.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adc8630-5508-41bd-b012-08def048c780
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 03:47:30.8145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3uZA91vs/HPADVmFPeoQAK5Tn4tNcsxvRrWU9B1kFY9plvAXkTUxNoDnM/VO2kpkTE+JClmITXqjV+a3csDd0EeoKixJ8p34INaY+w/aQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4298

From: Christian Marangi <ansuelsmth@gmail.com>=0A=
=0A=
Ask DSA to propagate dynamically learned FDB entries from foreign=0A=
software bridge ports as host addresses. This lets QCA8K react as soon=0A=
as a station moves from a switch user port to an interface behind the=0A=
CPU instead of waiting for the old hardware entry to age out.=0A=
=0A=
Disable hardware learning on every port during initial setup,=0A=
including the CPU ports. Bridge and STP configuration will enable it=0A=
again where appropriate on user ports, while CPU-side learning remains=0A=
under software control.=0A=
=0A=
Link: https://github.com/openwrt/openwrt/commit/b0048b314620cc99f155c8c5cd4=
541af5e99e578=0A=
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>=0A=
Signed-off-by: Brandon Mahdavi <brandon.mahdavi@mahcom.com>=0A=
---=0A=
 drivers/net/dsa/qca/qca8k-8xxx.c | 12 +++++-------=0A=
 1 file changed, 5 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8=
xxx.c=0A=
index 32dc626399c9..4af92d51f046 100644=0A=
--- a/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
@@ -2017,9 +2017,10 @@ qca8k_setup(struct dsa_switch *ds)=0A=
 =0A=
 	/* Initial setup of all ports */=0A=
 	dsa_switch_for_each_port(dp, ds) {=0A=
-		/* Disable forwarding by default on all ports */=0A=
+		/* Disable forwarding and learning by default on all ports */=0A=
 		ret =3D qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(dp->index),=0A=
-				QCA8K_PORT_LOOKUP_MEMBER, 0);=0A=
+				QCA8K_PORT_LOOKUP_MEMBER |=0A=
+				QCA8K_PORT_LOOKUP_LEARN, 0);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 	}=0A=
@@ -2061,11 +2062,6 @@ qca8k_setup(struct dsa_switch *ds)=0A=
 		if (ret)=0A=
 			return ret;=0A=
 =0A=
-		ret =3D regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(port),=0A=
-					QCA8K_PORT_LOOKUP_LEARN);=0A=
-		if (ret)=0A=
-			return ret;=0A=
-=0A=
 		ret =3D qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(cpu_port),=0A=
 				BIT(port), BIT(port));=0A=
 		if (ret)=0A=
@@ -2122,6 +2118,8 @@ qca8k_setup(struct dsa_switch *ds)=0A=
 	/* Set max number of LAGs supported */=0A=
 	ds->num_lag_ids =3D QCA8K_NUM_LAGS;=0A=
 =0A=
+	ds->assisted_learning_on_cpu_port =3D true;=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
