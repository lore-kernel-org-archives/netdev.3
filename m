Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4EE41CB56;
	Mon,  3 Aug 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777572; cv=none; b=b4yooDyDhkb2XxvOqL6opuMgFUQfQWR9IKLdgO01nozElgTnn45CB3yxdBPIlOwc6l55XPzAime3/Qces3EXP6jl2+QRiGYmFvjTR2X/3D4v96TxzOhQ5+V2NzUvzPeAJM5dlMNSh+bsRRlpXqyjvhAkYJmgx+sVnu1TtKafT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777572; c=relaxed/simple;
	bh=bA4sHGxDa+lclDy423KzHT/7d1nKFUd9Xq0Fdc6fYh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1H69y8fiA56vaBcHzeDuWvjvkPyNUU/IImFTYdpwaYHJie5/sluPRiJhTkqyc+vNUwPsKACX1nxLHQ5ZY3+47tvdsHGN+FeeL5P5N6caa1MNZlt0/RJMOpVSgBH3TqbNzTM+qmGPX0MN/4eYZt57zNLaELhxIENf84EASzBwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=n4heC+oa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="n4heC+oa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777554; x=1786382354;
	i=markus.stockhausen@gmx.de;
	bh=hRgwrtTC9cV+Q/wombxr0VkWEi3iBpwv8Xe6TXsGnKk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n4heC+oanWShlBxfW9kh01TBJIQA252y8ajtTN4i71dkOGDcQkpUCcTH2dhPn4ma
	 2H9dm4m3RSztYRXawlDDFQseljzDApAE0zzhrzc+TgxkOVvbVnpHrgzV98YB2UmMb
	 YCrNV3WWCCOfUUoDXz0q8aEzQYT5GSLP8RhHfFm7HhoGTncR/sNRrE97mCSPR2g0S
	 jrbLOSVTOS0K7VQ6dMeZreqKDzlT9NVIlwqZhoK2gmKfVEMwEaIExcr3ljB25wbsB
	 1ABYpr6jrsCfCTrCLUWtpYalp4L0Gr1bgIr0k3307H3lo9t1LW+jL9f/waRUha/b9
	 cDpP6Ex939xmdnxLUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1wYRzj1hBF-00O2kz; Mon, 03
 Aug 2026 19:19:14 +0200
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
Subject: [PATCH net-next v12 09/11] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Mon,  3 Aug 2026 19:18:51 +0200
Message-ID: <20260803171853.507506-10-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IYMUKqbcGjc46VHD3giDb41WoYyesKwqu6EYX1UmxIRdulWf0Qv
 MwSd2L3HGQZr3jNq2WmsZKwCWR+Mel87bBmyhBF9FTyKJ8VUvge+dXoP4YpeTQuEmPH3DUy
 Yk9ApmwnCn8L/Au69kpOJgg8/786g7EzxHZDt+19/S1200EDQ13d+0oPLLffW3jR5LH5i2i
 AHmLLLkOXF966FP/UZTFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vZcniaqG52Y=;A7szxaffHBQLmAD8my3NvmxlK3U
 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
 zyETxLEFSALLBSMFEb+FeTNeVU0jesTC8VZgM=

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. It has 28 ports,
  4096 (Realtek) pages and 4 MMIO registers. With this a lot of the
  existing RTL9300 defines could be reused. But to avoid confusion and
  for better readability duplicate the defines with a proper prefix.
- The MDIO engine has no fail bit. Thus the mask is set to zero.
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no C45 setup but must activate
  the PHY access.

As per the SDK the PHYs on a RTl83xx bus are mainly C22 driven. The
polling unit works in C22 mode and the devicetree usually does not
make use of the ethernet-phy-ieee802.3-c45 flag. Nevertheless there are
some PHY MMD registers (e.g. EEE) that might be of interest for the
future development of the hardware. Until that is really needed keep
the C45 read/write helpers out of the driver.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 80 +++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 368166061aef..068f5cdf5558 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -125,6 +125,28 @@
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
@@ -352,6 +374,34 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
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
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -572,6 +622,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
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
@@ -864,6 +923,26 @@ static int otto_emdio_probe(struct platform_device *p=
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
+	.write_c22 =3D otto_emdio_8380_write_c22,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -914,6 +993,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
fo =3D {
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

