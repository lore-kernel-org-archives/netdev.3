Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9BA3451BA;
	Fri, 31 Jul 2026 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478476; cv=none; b=cdYxR8OKP9rocQTYxt/90rVLgGwkEJBy40R+0wZDDwf2UpI8uPEeeC2tFNDh7Xd0sUiXgraD4TpBLLC1pV6QVJsLZGz48ITeTLqQgMWrNR2r+dei/E3amnmm6nO++rc6e2gE4XUSVi7qb+ygyYPl1V9sm9DMcGvrKLMHbImo9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478476; c=relaxed/simple;
	bh=MXUXR4CvsNq+nUBeCX9FsiCAXcDufDg8kYWq+226UT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsWH1BO96Tvorj+GD7wQmImgPeyFOxY2+Q2DiPBivxhyprnDnXv8tVifw8FG7ilZ28t972aYx0rLRsSP9qnw9tQLr6+cttOiIyZsi0F7jvxY2529z6dCZb3hq8FyxzQoFN+Hd0S+yiaSxOpz7W0R7JYxUeVOaQtabtLChSOKums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=CUjZG6R6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="CUjZG6R6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478456; x=1786083256;
	i=markus.stockhausen@gmx.de;
	bh=gJHWBBHDqfBM6iE0tu2S67eQUpiMYIBtM9VXAsK87rc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CUjZG6R640L73KG5QfKdBEzlOa5p/Z0jHeHwcj0SluN7tY+yrKD6NyZxD44MAPtd
	 CzIcHqzINoi10ObMRhU5nygWWXnI1xsGoV5PCMp4TgMXv0M+xvZDrIUCPfKgET26J
	 M3wrkTMMDZTqKHCOOcSlaAtjcmgGxweZ+03Ut5xkE/A7e9imnxz191rbbso18gGDY
	 LeM67CFaK4Ueww/tl2mEv9b/HtOeAaFMDyU+IG/j1eVC96sLJmrHlJWauea77GmHk
	 XWYP5MPOBy6ODPTiMH5+lj+kI/2c1y97uUsuLGTKQIUXDkdfEdiqVXE3Ev7FVwCW2
	 h5dpCa0NiJ0zLqb7hQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1wr1oj2OS5-006Niq; Fri, 31
 Jul 2026 08:14:16 +0200
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
Subject: [PATCH net-next v10 08/10] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Fri, 31 Jul 2026 08:13:58 +0200
Message-ID: <20260731061400.78301-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JBJBDePdi9wCoAzO0Ctndi5fqH+JTuBTey+yCCIww9fO5blvuOE
 8zHuu3LTVXE1nVLwRYwPTGNC6TjY69+gs4vwGJTBuwGJKDOh0a5AUqFp3LIkhRXXNYtCDQl
 zKGX9SwfhbFMk9oegCvBJgQ2/1td0zC5BGLlusLx1kaWI3xxMsmHD7LobEV7yEjtMNsjjaw
 K8zSepbR0cmK+zLUls97g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/XYjXeun1YM=;gjf9+7/5OipgdHXFH/UT2LYLhdA
 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
 HP/

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. It has 28 ports,
  4096 (Realtek) pages and 4 MMIO registers. With this a lot of the
  existing RTL9300 defines could be reused. But to avoid confusion and
  for better readability duplicate the defines with a proper prefix.
- The MDIO engine has no fail bit. Thus the mask is set to zero.
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no c45 setup but must activate
  the PHY access.

While all existing RTL838x designs only use c22 bus access, this patch
implements the c45 code paths too. The hardware supports it and this
simplifies future expandability. Leave it to the devicetree if someone
wants to use c45 on these devices. This avoids adding extra checks to
the driver.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 1408e252bbba..88bd3ecc8a1b 100644
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
@@ -354,6 +376,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
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
@@ -574,6 +650,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
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
@@ -886,6 +971,28 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -936,6 +1043,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
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

