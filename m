Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523323909A3;
	Sun,  2 Aug 2026 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659774; cv=none; b=X9p/WjpuOXG1t0Dtrue0RlsxyQBe8vcWyBGrJQUaZ4wPYeGcTfkUuDWUHYkjEEgR0PzF0FzcY0e6R9wyQpVpACPcrtonAIfPesE39AILFqQ5QCgdnEYZIniKkuTtRtxSa4qa90jzATp9oKEKLJDOSG38dSm6pKKohAvTgmGSDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659774; c=relaxed/simple;
	bh=bBvpUboZO5xEc8zKtUXfZAZ40GzyaC4oh75qs5cpw0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAc8YSWnAT+KUuk0Sfi9BdCWEZrI2+DSIvi5Rw1rpQB5uxg4FuXda9x1Ih+jNMOzC4tmTLXHMCMvgL14bYbWOQWO+AMTZrVH815zi0c0VEOX4Qn71c4FPA56fuQN3t6JfBd4khfr1Nk20I3OP1ZR7CuYSJqxL73HiYqHcYY+WZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Fh12ttJb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Fh12ttJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659747; x=1786264547;
	i=markus.stockhausen@gmx.de;
	bh=+yO8XVCQaRtmG4WRF8RFownEWZDrC/8EFRYquFx33ps=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fh12ttJbI17wlPq0Yf56fqIhLnlD1o0olLko4LtaaBIaWCDJbshNovjbj1O485OV
	 +mBlIM3L3r0Y8FhrYHupwLgzRh9ORWGKegmdOLnBKULqZSMn47Tesp9Q5cDdmx6/2
	 iDhhkKy+SHASt70g18FXCQOFDi6+fkTjr2ZEVQ93kWWSWBrJILb0tSwxs/RCTn1qj
	 os59h8NMaDvuIf5jayEzQqT+RsH8Vc42PKCwjNry0vH3IIboh/2RSSYNA9wh4DPDJ
	 ObMYtm/Bn4W3Eudzdq0mE7kJizp9n1wL0a+pRMjHjKV7GQqaYjnOrUyF8tcgOebmi
	 tVY8kzFg6iAUnjwI9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1warfO0km1-00Mw2o; Sun, 02
 Aug 2026 10:35:47 +0200
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
Subject: [PATCH net-next v11 09/10] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Sun,  2 Aug 2026 10:35:27 +0200
Message-ID: <20260802083528.490216-10-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gXTHZefQp3CKYvD4DGp/RYWIWoN7SU16LrCDYq0Fv82EUd//r0O
 wcTJkCClFf9sCtqiwe3kBiQYNQIMBFOpkv9M+h2nhBUY2TPhefdYaJL0ZQhmLwfWRweZzrS
 8kCbazqq9fKdkb4wHjK+vYUkvwNM9p2aIPYn8DvVpAC09RodlLuQTA8EzFa4952Sa+abCil
 /I9QbmQdSlW1ieccLjD6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3+agbW0mMfc=;50bSD7wDEVAB905DGfIDrJZpjzC
 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
 97mJpMriUe0Xg2wTqKvaDXK1P2z9g5MDA9FkE=

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

As per the SDK the PHYs on a RTl83xx bus are mainly c22 driven. The
polling unit works in c22 mode and the devicetree usually does not
make use of the ethernet-phy-ieee802.3-c45 flag. Nevertheless there are
some PHY MMD registers (e.g. EEE) that might be of interest for the
future development of the hardware. For completeness and extendability
the c45 read/write functions are already implemented with this commit.
Just like for the RTL93xx devices. But in contrast to them RTL83xx knows
no flag to switch the polling engine between the two modes.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index dc30412a1af9..6a47f872a352 100644
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
@@ -863,6 +948,28 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -913,6 +1020,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
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

