Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CBB21A95D;
	Mon, 27 Jul 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179783; cv=none; b=L2DHZH304jGrocZotBiwlq08GH9KbVIZgCZQZVKtPXEIb6O0BPKbuu47qDdNsl0D00fiGSElHexuwVItYn+B268fKB6ayQa8/JTka5UGM5scr9dR39TZSjAVeciekP3DQNf7weeuMItgs2XlkFbPs9ta7s2HWJ+5WPHsdeLzWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179783; c=relaxed/simple;
	bh=By7MDLL+cVTcGdWuuVep6HCXCevF31nr1KaMjSselns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnagQw4Jjxfbl+qWLJDXFZf33AwSbpT0th97TTv9f4HAD2BXMb8L2BQPVeY/fqktl5XJG2i0iiQjSMNCNbF0FjLruouxCmP+2lMOBKI6T6W+8/o/jpSfkhGc9HRE55v+wtFOIReKdaKdRYuluQo8bdsL2bLZWZdajSZsOwwl+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=TzfEEk/0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="TzfEEk/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179774; x=1785784574;
	i=markus.stockhausen@gmx.de;
	bh=TyG43taYvypdqhwWot/VH6mKOCwQMiyuTkptyJBsmzo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TzfEEk/05zV3u1Adopv8lWfciIqEWpACmK++7pE+YOOSNN0AwRAij80RaACUnyDv
	 2MAYGx+mxpNaqO5kRy603NBOX5DL2S5pUdw4GmCcac0johB/DAwJwWwWPmXbUVvy8
	 JWWQ6UbccE7ykxUhyW3f9og7XA68h8DtUZgvdyAaNyzl4cpzNWEhtLx3ZCZGQWxkI
	 7VBRBJF5D23FgFyEI4mdJx7+Q9b6zLNe0MH0wZXAEVWNXKDn9PrYM3Tss1zy6hCqP
	 v5a8Xuf5kRkEI+piKjz71pGrMJaSfPjj38CUTxYW+tXobi3BcyWBWruCqDgf9tufl
	 F1DGFgMCFnLZnlnlRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1wk0wo2uDw-001eTv; Mon, 27
 Jul 2026 21:16:14 +0200
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
Subject: [PATCH net-next v8 8/9] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Mon, 27 Jul 2026 21:15:58 +0200
Message-ID: <20260727191559.19617-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191559.19617-1-markus.stockhausen@gmx.de>
References: <20260727191559.19617-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1KtcAuUrzGNRNIYIIg00wF78pG5Ff23D6c4wHSh2s9EpdcpOOLv
 9wCvHt6lHGz9BDemmG8r0HbxITBVvcIAqzjPpBSzAsuz+Eb39zz6AbeNyRC9OHhiBSjLKQH
 JaQ++mnVjBxe+6sgIWM4XmaJVvCMjTAcy4WlcUsdb41FcTQGkC+NMSKKTotdeaMk3gxqHrF
 KfLNvO4ohDLFVuNc5d+Uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dytbVNqENdw=;O2UN9X3Jzboo7ThLx9Xg96sr9dX
 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
 WFsnur58DV5O/jVHLX7Qn

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. It has 28 ports,
  4096 (Realtek) pages and 4 MMIO registers.
- The MDIO engine has no fail bit. Thus the mask is set to zero.
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no c45 setup but must activate
  the PHY access.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index ef4fa8e8274f..9f76698a84c5 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -126,6 +126,28 @@
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
@@ -352,6 +374,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
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
@@ -572,6 +648,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
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
@@ -880,6 +965,28 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	return err;
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
@@ -930,6 +1037,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
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

