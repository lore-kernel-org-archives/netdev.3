Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021091.outbound.protection.outlook.com [40.107.208.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FF30AAA6;
	Sun,  2 Aug 2026 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642451; cv=fail; b=Vc9BJLFS+Yyavip5xPsYE3po9abARN/7T+8El2stV2gNQYuLTWuWfzQyhs8DcmUyXaqVWwq+wOLe7AuD5EkEtOgJQ7Fwj1jHkANgd7XcWv1vQRNlzf9DIdS1aRZbBgYP+GqRo/E4JdgBPCjqQHaX92i++AOSjfbo2oUXjFA94HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642451; c=relaxed/simple;
	bh=TPa3b+Kn5vdZORiWCvOZYQFxHC/2fxygtkvOAGcRqAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W70A0bQPPugtvdGklz1Bh70VhA8sie87MCYha3RxaL8vkTpO7qid+PAsjs0fPCDttYJE/EvlFLYc/Y7SB8mF/L7QaIetMsDrExikJxqGoh60mxHfoNqF+VY/mlpygM4kBFBS3O/3fU4HJ5IvBs2xfMTHMEzhMrhyLAHjT9yuuCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=U9Pz+vbI; arc=fail smtp.client-ip=40.107.208.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="U9Pz+vbI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO0rWsTV0rfsL+LWqQ+v7118J/rinEpxEq01joNbzpWnSHDBUwPtUCk1zEW/qlCQ0lXzTUbviDtzyv4bJrQHHMOhPVX5DARpRSOPUCGeQrb185+crl1EywGiSq45FYwB1WSttRxlmZ/SIz49rrmJ+406+4EHEXUPN1vpxH3wvsK8fqx01lounP388pz+zsc5TfP3nbDg6hw0zobJ5d+hMg2SjdPqjW/catn8N8b2CJ5U7XjvHbNeY4qTBUctlDFC9/6rLpIoJbpGz9DN22Dar5U0aNy7MgrnY58bR4LALUSDIyLytjcFaYElfJYrx9bKzhj5PWkkEW69XqnXi9yhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31Y8TvBv+gXYVrUSCUIR4jao6Z4WlQiVVmIaeBNyG9o=;
 b=KnxHBN8Mf2i0lLvmWascNQ4456mujrgJw2wMNvQCKU+z5cLWf1NHUgif/aG3n+eouY14J5oo8ffe6bLgdeaL2K+PmaHzIeSpZfQJhlAZ1Q4tcQBlziczhKewM756BfRcGtE4aLFJ/hwXypNic8ZHabuSxr6rSA1D449R1C0tPvbVj0QGRhAp7gK4oANWbEMVb2bCKd9Lv8eNIqrSE4cUJiJI+a/E7RJihOzRkR75fxbDrhTMyaOZSt/I6oAeBhjJ6wROXWDDzI5VK9X8J+GZo7nw+WN7XDcEwe78+aRo/61EntF6i7eHHmQo1j/VRds0+vs2PsmZiIYgbasrZMTRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31Y8TvBv+gXYVrUSCUIR4jao6Z4WlQiVVmIaeBNyG9o=;
 b=U9Pz+vbI7TfIi1pGVKtxjw8yX8xxortRHmoyIeIlkc9Qmv7rGBCT7ncbDF2bEqjlIK3kGEWfX0RiGq23zltpmX1OT0oey8jqqC1QUeh+K4gS8bvv9JJBV2zv0OxLmOfa1vJjq6pPhSfI/q02wu13WCy2+KG4ZfgSpd/fE+7YZ/lx6M9t1HOTbbX8Qy6lA9hGwpfhSPP0BDTE3KH4HRNshl98DbwXDV/htgO74YHxslUcktIrn6p+ub74qEisOM5Kfb5HQkt/VKy/TxJ+yktRKAFN5xz2RY7hzPX0/QjgIskkE4MJRPyyLmSFT4J/SuAvCdt4ybnrHtrR8mEl3WrhXw==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by SA1PR20MB4298.namprd20.prod.outlook.com
 (2603:10b6:806:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 03:47:27 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 03:47:27 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "hzyitc@outlook.com"
	<hzyitc@outlook.com>, "lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next v2 5/6] net: dsa: qca8k: support changing the CPU
 conduit
Thread-Topic: [RFC PATCH net-next v2 5/6] net: dsa: qca8k: support changing
 the CPU conduit
Thread-Index: AQHdIjGjFYWuYLpFB0eKlQiM7aQkdg==
Date: Sun, 2 Aug 2026 03:47:27 +0000
Message-ID: <20260802034701.3339052-6-brandon.mahdavi@mahcom.com>
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
x-ms-office365-filtering-correlation-id: 35a41538-cd6e-43fe-21b6-08def048c5b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|10067099003|5023799004|4143699003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 Uveo+OEdnHLcaALXed4ccS/sDqh/QRSOq3CZCNCrKb0UAs2SGRxDY1MSIaDygwJTFTwFhaC4G4ugamabe2I4KKlEwvmlEBuThN6anaGuOiIlPz0MnVwhehGeLsMlIWWfDdzdJVx/6hU3MYTGDPz28ywpa6g96aDKUr21ODCqkk+7/5S2+PgsnSPdAjP/zIlJWS6H1FffeA5ppe894c1h5Yw+26Vw8OaY5xkLPdMHyrp72s3tSuk5bAtek4YHC7P0yWQA8r32Bs0x6RbzYfrGveZjqjZzL85hhhc6+bEo268TZYEX3jxZQS/VsPTTT4cZwAGrMLMEtl2HqpwMzeTxVshkQHO5qgFLTkZgZyqKV6JCq58pqdeVqVjKCcsa0Rp8pJHNqWvhlCDqN+bN5YSTrmkqXztisDVvj6iViVz+Rfd/ht7ahwPaSK4SvWjADPsbI/F9hhxpygLzUClw3MfCqYQ2asU8Qduy5G9bfNtylTdfnVy2Khzn2QWC3gIDfJIlsoSnlsDblVVFB6Wso2vA/zCloqHd0tNSshHrJAOvikWCH7+TPE3yJnbhDQXpMj/68PPUz1mLZ1vIFYEB5ETfpdqtdOTZ10/x5oMe5w8QR5NSaU5Inyc2Pyd7nu/y2VuT7wSMKhv7ADchcnqKjrFz0n0zJvXwnZkDKg/jchDaR594f5/4+4Yf2+3G03JR0Pf/PMTMwmKRAo8bZsol7Yc+JynYKrKlQHJp32tkg6gf8qY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(5023799004)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pBwNNODpmt8PaHBJr/IaBCS3majrqj2slSqTC9ykLveN8gHy9ylV423pTT?=
 =?iso-8859-1?Q?GK1BqtpLg3pzvUfaSUOakndhutuqZqCPo4WSxMvhJqzWLxzsloY/Q5d0mj?=
 =?iso-8859-1?Q?s0D66J1f7nxQOzzl0iRNZ+9wV/uN+lpkg5bp+7OnHKKZdA4lMEkSQqELe4?=
 =?iso-8859-1?Q?0eVkIa9a2qm1cDHNUjIPB6ol3BnL2yctgVkbBNK7M4U3fIIkSwNSmHy4NI?=
 =?iso-8859-1?Q?gWOk/f8+m7oqZpLRyXcvO2GepK7fQzdllZxOfJgjNVsuQjwP9r1usij9we?=
 =?iso-8859-1?Q?BzvwhQfvg/jW3whVAy7yY6XKdVsabDVWz89m0D3eAoDTxQ9JbFnAXcGJZo?=
 =?iso-8859-1?Q?OVKt6JC8hSNId0AfUsMsZdshsenqVuRHOKfM8D91XOKresb2KCXMfhexhX?=
 =?iso-8859-1?Q?PJJGhBB/oUmuQrCjAojCrSGwQNK5c2GSYyAKkYGq2rPShsCLGipIqXuNad?=
 =?iso-8859-1?Q?9yGcOM+MOqfJ1txligL2XKCbtlEQLtk4wLbjZWNw5QJd7bFS7a0u1vdkKC?=
 =?iso-8859-1?Q?vRxv0UJkUcEamQk9o5fbo4daWsnUm3gNno+Nq5oljm42ny/hCGEry3oU4Y?=
 =?iso-8859-1?Q?8kMnPToSFwPBUdBqY5nGuP+UZgaBK8g0Tint7xQ1ua+L3fay827zwzceWh?=
 =?iso-8859-1?Q?bgJYHGZ+NqKUz1xFkrzd6BJVgiXuxnUO5Gv/aVoaqa/QgZyt+s9o6ScMZc?=
 =?iso-8859-1?Q?Nd/YhXtnbUgjefffoTKsQkV7yW77enhTYsCtykWRgd6Mn8X1WBPB3vg8WP?=
 =?iso-8859-1?Q?2pDixjUE8QLueiF86UAhQpxA9V7JWV6OnA893z2UJ1h+Yg/a7olzaeDSR/?=
 =?iso-8859-1?Q?6fShYj4PXe/Z9grBIbmEHAtw0C+oK40ZA022h+oFwoXc0sjKIh06QhC0zX?=
 =?iso-8859-1?Q?sgBRn5690kfQQNpLzfoknegbVuSjE47cWmPCRvs8VZyXfgxunAE93scOpH?=
 =?iso-8859-1?Q?JpM7XiotxopIKE0D+mQz8RN9yEtvPts0EKtWayy2QXU2Ud+rRKCG3cOhza?=
 =?iso-8859-1?Q?JRbWEBAmffJRK0oIWEV/1ZNGClAWazz3phtqiESO9muul5VCwWdw3GfAMs?=
 =?iso-8859-1?Q?16Jt4u9Dl5PTG/VOMwSD31FgtgZ7b1KXOgNlHivdIjwKyAhR+jwdSiHMef?=
 =?iso-8859-1?Q?5H+yrASX6LhwEazgNhaQ9oe1ujzX65driIR351rmgJxYYag8K9kDi+mRKR?=
 =?iso-8859-1?Q?Ocg3r7qvwNRTLJeUGgXOtg992ASp7l6tol2tOriXONsAhm+dGq+tQtMzjN?=
 =?iso-8859-1?Q?gQMiqeq1dxmavS9P2ReMY+LXJvHlrO1NB/77Gk2ArPTyws2DERwVaviGdH?=
 =?iso-8859-1?Q?8A+LNcVYjrpNkFCr1eNfvS0jXp7Jf1l6hm7Xe+MC8WWQ9ICLzlGykPEfrb?=
 =?iso-8859-1?Q?ygwLg3EO4UeCN07Fm85nt3aMGml+ewKAOSuJg2pGAtmvfCBtruhuLC5K3E?=
 =?iso-8859-1?Q?MHTyoKYYctFT1paNZ6BXfKftsM6AgwyVoZk3GQXeZxP/XYPe5lBbKCXPj1?=
 =?iso-8859-1?Q?yOETuA7EaG12J0Qu7W3+jAksDqR94XI5+LvzcLLVVnj+SAJKQryMj0uCcv?=
 =?iso-8859-1?Q?R1JY0KYrW8jxo//+QSRlsrnGuOmmApEFWOWdK4fzLhCMlUFHWKFHaOp366?=
 =?iso-8859-1?Q?eWsFwxnc8WkDGnfett10Fdx3J4UCnR7xZz2zGs/+krbnQGdNoscA83FEn5?=
 =?iso-8859-1?Q?UARxiXn7B5gp9gDHHCBP4W5cSQmIGr8JTysl9XVO1YFV8dXhaCMY8vHOdx?=
 =?iso-8859-1?Q?kxBrteJ/xru9EvbOHje0IdWzD5QItXvfi/pgDADPAgh8XTx3j8ASITokhF?=
 =?iso-8859-1?Q?cS9U2kp59Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a41538-cd6e-43fe-21b6-08def048c5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 03:47:27.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDM81TBhfgLiEx5uOSa7l+1aVdWyQV2xoF71QUas2xZDQ0KcwZAmzxDK7ZsX5fyoNweW1B9bs4d+FXhb6Xnb5+YlaMsxTzd2I33auRalBzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4298

From: Christian Marangi <ansuelsmth@gmail.com>=0A=
=0A=
Allow DSA to move a user port between the local QCA8K CPU ports or=0A=
onto a LAG made from those ports. Update both sides of lookup=0A=
membership so traffic can flow only between the user port and its=0A=
selected conduit.=0A=
=0A=
A CPU port can join or leave a conduit LAG without DSA changing the=0A=
conduit netdev of user ports already assigned to that LAG. Wrap the=0A=
LAG callbacks and refresh those users after hardware trunk membership=0A=
changes. Derive bridge membership from the complete conduit mask as=0A=
well, so a later bridge rejoin does not reduce a conduit LAG to one=0A=
physical CPU port.=0A=
=0A=
Snapshot both directions of the old lookup membership before a live=0A=
change and restore them if any register update fails. This keeps the=0A=
hardware on the old conduit when DSA rejects or unwinds the change.=0A=
=0A=
Link: https://github.com/openwrt/openwrt/commit/500dbaefd2a6a1c9c0d81e275a2=
8c6a8e26519e4=0A=
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>=0A=
Co-developed-by: Brandon Mahdavi <brandon.mahdavi@mahcom.com>=0A=
Signed-off-by: Brandon Mahdavi <brandon.mahdavi@mahcom.com>=0A=
---=0A=
 drivers/net/dsa/qca/qca8k-8xxx.c   | 138 ++++++++++++++++++++++++++++-=0A=
 drivers/net/dsa/qca/qca8k-common.c |  47 +++++++++-=0A=
 drivers/net/dsa/qca/qca8k.h        |   4 +=0A=
 3 files changed, 186 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8=
xxx.c=0A=
index 9eae921ad716..32dc626399c9 100644=0A=
--- a/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
@@ -1743,6 +1743,139 @@ qca8k_get_tag_protocol(struct dsa_switch *ds, int p=
ort,=0A=
 	return DSA_TAG_PROTO_QCA;=0A=
 }=0A=
 =0A=
+static int qca8k_port_get_conduit_membership(struct dsa_switch *ds, int po=
rt,=0A=
+					     u32 *user_members,=0A=
+					     u32 *cpu_members)=0A=
+{=0A=
+	struct qca8k_priv *priv =3D ds->priv;=0A=
+	struct dsa_port *cpu_dp;=0A=
+	u32 val;=0A=
+	int ret;=0A=
+=0A=
+	ret =3D regmap_read(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(port), &val);=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
+	*user_members =3D val & dsa_cpu_ports(ds);=0A=
+	*cpu_members =3D 0;=0A=
+=0A=
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {=0A=
+		ret =3D regmap_read(priv->regmap,=0A=
+				  QCA8K_PORT_LOOKUP_CTRL(cpu_dp->index), &val);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
+		if (val & BIT(port))=0A=
+			*cpu_members |=3D BIT(cpu_dp->index);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int qca8k_port_set_conduit_membership(struct dsa_switch *ds, int po=
rt,=0A=
+					     u32 user_members,=0A=
+					     u32 cpu_members)=0A=
+{=0A=
+	struct qca8k_priv *priv =3D ds->priv;=0A=
+	struct dsa_port *cpu_dp;=0A=
+	int ret;=0A=
+=0A=
+	ret =3D regmap_update_bits(priv->regmap,=0A=
+				 QCA8K_PORT_LOOKUP_CTRL(port),=0A=
+				 dsa_cpu_ports(ds), user_members);=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {=0A=
+		u32 member =3D cpu_members & BIT(cpu_dp->index) ? BIT(port) : 0;=0A=
+=0A=
+		ret =3D regmap_update_bits(priv->regmap,=0A=
+					 QCA8K_PORT_LOOKUP_CTRL(cpu_dp->index),=0A=
+					 BIT(port), member);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int qca8k_port_change_conduit(struct dsa_switch *ds, int port,=0A=
+				     struct net_device *conduit,=0A=
+				     struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct qca8k_priv *priv =3D ds->priv;=0A=
+	u32 cpu_port_mask, old_cpu_members, old_user_members;=0A=
+	int restore_ret, ret;=0A=
+=0A=
+	ret =3D qca8k_conduit_port_mask(ds, conduit, &cpu_port_mask, extack);=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
+	ret =3D qca8k_port_get_conduit_membership(ds, port, &old_user_members,=0A=
+						&old_cpu_members);=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
+	ret =3D qca8k_port_set_conduit_membership(ds, port, cpu_port_mask,=0A=
+						cpu_port_mask);=0A=
+	if (!ret)=0A=
+		return 0;=0A=
+=0A=
+	restore_ret =3D qca8k_port_set_conduit_membership(ds, port,=0A=
+							old_user_members,=0A=
+							old_cpu_members);=0A=
+	if (restore_ret)=0A=
+		dev_err(priv->dev,=0A=
+			"failed to restore conduit membership for port %d: %pe\n",=0A=
+			port, ERR_PTR(restore_ret));=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int qca8k_lag_refresh_conduit_ports(struct dsa_switch *ds,=0A=
+					   struct dsa_lag lag)=0A=
+{=0A=
+	struct dsa_port *dp;=0A=
+	int ret;=0A=
+=0A=
+	dsa_switch_for_each_user_port(dp, ds) {=0A=
+		if (dsa_port_to_conduit(dp) !=3D lag.dev)=0A=
+			continue;=0A=
+=0A=
+		ret =3D qca8k_port_change_conduit(ds, dp->index, lag.dev, NULL);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int qca8k_port_lag_join_with_conduits(struct dsa_switch *ds, int po=
rt,=0A=
+					     struct dsa_lag lag,=0A=
+					     struct netdev_lag_upper_info *info,=0A=
+					     struct netlink_ext_ack *extack)=0A=
+{=0A=
+	int ret;=0A=
+=0A=
+	ret =3D qca8k_port_lag_join(ds, port, lag, info, extack);=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
+	return qca8k_lag_refresh_conduit_ports(ds, lag);=0A=
+}=0A=
+=0A=
+static int qca8k_port_lag_leave_with_conduits(struct dsa_switch *ds, int p=
ort,=0A=
+					      struct dsa_lag lag)=0A=
+{=0A=
+	int ret;=0A=
+=0A=
+	ret =3D qca8k_port_lag_leave(ds, port, lag);=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
+	return qca8k_lag_refresh_conduit_ports(ds, lag);=0A=
+}=0A=
+=0A=
 static void=0A=
 qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *condu=
it,=0A=
 		     bool operational)=0A=
@@ -2032,8 +2165,9 @@ static const struct dsa_switch_ops qca8k_switch_ops =
=3D {=0A=
 	.port_vlan_del		=3D qca8k_port_vlan_del,=0A=
 	.phylink_get_caps	=3D qca8k_phylink_get_caps,=0A=
 	.get_phy_flags		=3D qca8k_get_phy_flags,=0A=
-	.port_lag_join		=3D qca8k_port_lag_join,=0A=
-	.port_lag_leave		=3D qca8k_port_lag_leave,=0A=
+	.port_lag_join		=3D qca8k_port_lag_join_with_conduits,=0A=
+	.port_lag_leave		=3D qca8k_port_lag_leave_with_conduits,=0A=
+	.port_change_conduit	=3D qca8k_port_change_conduit,=0A=
 	.conduit_state_change	=3D qca8k_conduit_change,=0A=
 	.connect_tag_protocol	=3D qca8k_connect_tag_protocol,=0A=
 };=0A=
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k=
-common.c=0A=
index c0a0d44e7c70..73e36f5fb358 100644=0A=
--- a/drivers/net/dsa/qca/qca8k-common.c=0A=
+++ b/drivers/net/dsa/qca/qca8k-common.c=0A=
@@ -637,15 +637,60 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, =
int port, u8 state)=0A=
 	qca8k_port_configure_learning(ds, port, learning);=0A=
 }=0A=
 =0A=
+int qca8k_conduit_port_mask(struct dsa_switch *ds,=0A=
+			    struct net_device *conduit,=0A=
+			    u32 *port_mask,=0A=
+			    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct dsa_switch_tree *dst =3D ds->dst;=0A=
+	struct dsa_port *dp;=0A=
+	int id;=0A=
+=0A=
+	*port_mask =3D 0;=0A=
+=0A=
+	if (!netif_is_lag_master(conduit)) {=0A=
+		dp =3D conduit->dsa_ptr;=0A=
+		if (!dp || dp->ds !=3D ds || !dsa_port_is_cpu(dp)) {=0A=
+			NL_SET_ERR_MSG_MOD(extack,=0A=
+					   "Conduit is not a local CPU port");=0A=
+			return -EOPNOTSUPP;=0A=
+		}=0A=
+=0A=
+		*port_mask =3D BIT(dp->index);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	id =3D dsa_lag_id(dst, conduit);=0A=
+	if (id < 0)=0A=
+		return id;=0A=
+=0A=
+	dsa_lag_foreach_port(dp, dst, dsa_lag_by_id(dst, id))=0A=
+		if (dp->ds =3D=3D ds && dsa_port_is_cpu(dp))=0A=
+			*port_mask |=3D BIT(dp->index);=0A=
+=0A=
+	if (!*port_mask) {=0A=
+		NL_SET_ERR_MSG_MOD(extack,=0A=
+				   "Conduit LAG has no local CPU port");=0A=
+		return -EOPNOTSUPP;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static int qca8k_update_port_member(struct qca8k_priv *priv, int port,=0A=
 				    const struct net_device *bridge_dev,=0A=
 				    bool join)=0A=
 {=0A=
 	bool isolated =3D !!(priv->port_isolated_map & BIT(port)), other_isolated=
;=0A=
 	struct dsa_port *dp =3D dsa_to_port(priv->ds, port), *other_dp;=0A=
-	u32 port_mask =3D BIT(dp->cpu_dp->index);=0A=
+	u32 port_mask;=0A=
 	int i, ret;=0A=
 =0A=
+	ret =3D qca8k_conduit_port_mask(priv->ds, dsa_port_to_conduit(dp),=0A=
+				      &port_mask, NULL);=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
 	for (i =3D 0; i < QCA8K_NUM_PORTS; i++) {=0A=
 		if (i =3D=3D port)=0A=
 			continue;=0A=
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h=0A=
index ab8ea261c0b9..333b343886de 100644=0A=
--- a/drivers/net/dsa/qca/qca8k.h=0A=
+++ b/drivers/net/dsa/qca/qca8k.h=0A=
@@ -523,6 +523,10 @@ int qca8k_get_sset_count(struct dsa_switch *ds, int po=
rt, int sset);=0A=
 int qca8k_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee=
 *eee);=0A=
 =0A=
 /* Common bridge function */=0A=
+int qca8k_conduit_port_mask(struct dsa_switch *ds,=0A=
+			    struct net_device *conduit,=0A=
+			    u32 *port_mask,=0A=
+			    struct netlink_ext_ack *extack);=0A=
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);=
=0A=
 int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,=0A=
 				struct switchdev_brport_flags flags,=0A=
-- =0A=
2.43.0=0A=
=0A=
