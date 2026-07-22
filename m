Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5C313E0D;
	Wed, 22 Jul 2026 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701465; cv=none; b=X7u1d+l6wDMsPIjRAwz9tMd9X3Rue5f2UBoUbyQet4Vm6BPr8D3txaaaBm7wiwqnvmAN67fZebpAbDu1GdrcnGIsPkKMj4n0sgySXQahcMz0BhEEXZ79c8X7EcnmaWqVDA+/C48qzgyPHmC8CPNJj3meA3wXrTWY5+Rwc/XidMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701465; c=relaxed/simple;
	bh=8Vs3H94srccjhks8OFH0230/Zkt6X16g4sagIyr7R7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZSg+0q7cM5SLCfC4Rd+o5LyCWmj2eQ8VPKJbomdUdKd5lIqItOaPcerKpD9dwXFKO/dnk2pwDS7ZG1L3PumazANilc7jwFmLosFf32WVdNhaDNM33ibuvWpoVVZ/Z0qTJH57kkI9UZFgYQ6m7eOnXmTCe4Vt2iAsl2+zbSJ/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=mhsZaGwE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="mhsZaGwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701450; x=1785306250;
	i=markus.stockhausen@gmx.de;
	bh=A2if5jyqdJfWotWV/bJT8T7sM0kxbTDP/51/Xu6ujDo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mhsZaGwE/DVxNO4jgLlhkQ1bhkNCV9PFrtIRV2DhSyie4wlD+QRg8qw616kwY3Ka
	 FnO8VACXbdxeuszx6ia9pJGDBPm0RdMdH8zSarSwGwKoma+6pSMnYI3YZRCMFKexi
	 7nIXiW0UoadDVXfSnXk0UC9p2O5oTg6gn5i5gBs9SGQnuicg0hf8o3tZqbjAjZPFY
	 1TjRye1AAiB4wiaftBJJZD14HXu+fh75ccwZSy0MdFpjnW5Zs8eWTTtGRaviYpUS0
	 PBpeC7R3KzOM2Z5MI8itsqJSRqXhYDj7wmac31V3Wk+2PYwgoIVnxMhhRAE0zybm7
	 E5aXO0QC0+lhoKc0bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbBu-1x5kFA0SDm-00tnJY; Wed, 22
 Jul 2026 08:24:10 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v5 7/8] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Wed, 22 Jul 2026 08:23:55 +0200
Message-ID: <20260722062356.12291-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722062356.12291-1-markus.stockhausen@gmx.de>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XcvdvC5qp1H9x7Kn/mjlXKAktdz2oAeqvI+57e7S7aNCVykNd/J
 5ArKhx4SEX36pY6jzsKdQJy70GHvJXKIeujNCJKrKQ4ghnbtjrtgmSmBukOfAwa+i1sBPH5
 GgOfq4kST1cfBzoTdN+SXwGa1vb7JdJ7NvYevhUi7gfxHdWBItGYWW11CgQ4aRT874tfi6N
 MDIQMXE9xdmSQfx5Ifw8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:heuiusgy0z4=;+y+nwA5zj7fBx7m+Sfa4f9OGB9P
 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
 sGGHyYR1f5cy05wNWhVI0

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. 28 ports, 4096
  (Realtek) pages, 4 MMIO registers
- The MDIO engine has no fail bit. Thus the mask is set to zero
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no c45 setup but must activate
  the PHY access.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 26d73f5b5422..efea57b678ca 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -118,6 +118,28 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
=20
+#define RTL8380_NUM_BUSES			1
+#define RTL8380_NUM_PAGES			4096
+#define RTL8380_NUM_PORTS			28
+#define RTL8380_SMI_GLB_CTRL			0xa100
+#define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
+#define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
+#define   RTL8380_PHY_CTRL_REG_ADDR		GENMASK(24, 20)
+#define   RTL8380_PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
+#define   RTL8380_PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
+#define   RTL8380_PHY_CTRL_WRITE		BIT(2)
+#define   RTL8380_PHY_CTRL_READ			0
+#define   RTL8380_PHY_CTRL_TYPE_C45		BIT(1)
+#define   RTL8380_PHY_CTRL_TYPE_C22		0
+#define   RTL8380_PHY_CTRL_FAIL			0 /* no fail indicator */
+#define RTL8380_SMI_ACCESS_PHY_CTRL_2		0xa1c0
+#define   RTL8380_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8380_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_3		0xa1c4
+#define RTL8380_SMI_POLL_CTRL			0xa17c
+#define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -346,6 +368,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
u32 cmd,
 	return otto_emdio_run_cmd(bus, cmd | priv->info->cmd_write, cmd_data);
 }
=20
+static int otto_emdio_8380_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8380_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -566,6 +642,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
+{
+	/*
+	 * PHY_PATCH_DONE enables PHY control via SoC. This is required for PHY =
access, including
+	 * patching and must be set before the PHYs are probed.
+	 */
+	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -861,6 +946,28 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	return 0;
 }
=20
+static const struct otto_emdio_info otto_emdio_8380_info =3D {
+	.addr_map_base =3D RTL8380_SMI_PORT0_5_ADDR_CTRL,
+	.cmd_fail =3D RTL8380_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8380_PHY_CTRL_READ,
+	.cmd_write =3D RTL8380_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.c22_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_1,
+		.c45_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_3,
+		.io_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_2,
+		.port_mask_low =3D RTL8380_SMI_ACCESS_PHY_CTRL_0,
+	},
+	.num_buses =3D RTL8380_NUM_BUSES,
+	.num_pages =3D RTL8380_NUM_PAGES,
+	.num_ports =3D RTL8380_NUM_PORTS,
+	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.setup_controller =3D otto_emdio_8380_setup_controller,
+	.read_c22 =3D otto_emdio_8380_read_c22,
+	.read_c45 =3D otto_emdio_8380_read_c45,
+	.write_c22 =3D otto_emdio_8380_write_c22,
+	.write_c45 =3D otto_emdio_8380_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -911,6 +1018,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
nfo =3D {
 };
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
+	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.55.0

