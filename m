Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851637B020;
	Sun, 26 Jul 2026 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050310; cv=none; b=LCoekUxJFKRebe3v70f5WvUb6tipNdqolBtcZoY+g0mwsimuN4rBFyRFML7FcJ7obUPMeh1GaYmoao4EkmfdECaAD2+MM0fI49TxbMQFQEUu61DEsM9CfANAg4V6BfzpAD5LQQsGNt/A/Thp0pkXDlU1Nh3nAUZ5CjFfyDY7O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050310; c=relaxed/simple;
	bh=o4Zs3JO1QzDJu/g7rONC8oHbPMtGi6SrhoIwRNrAb0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/0lUrNKdcXkKeHA7/NgeojJ+PzHCjUGp9e2Ot2VXOx3nQsIY3LW/b9JkW+WsjghBQ7EVW7AciQpXhCvnSOENwrMedOA610O8df8+zUfeJ0cQ2CQrt/4hczczUBRAbp/HAdF/x37veytumKWnhYLXWe54zWhYbqe7Tj3cJqFspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=YyUfDxct; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="YyUfDxct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050289; x=1785655089;
	i=markus.stockhausen@gmx.de;
	bh=85rR3/Is4h1vez9tRaCkie/IcvwfmD3vlW4HDMzaMz0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YyUfDxct0pxlqJKA3srCleLw2v9VGpKzIqN+kkcGLqF4F7tAvm0c3a7fTdyCR94r
	 cvIjN8quCJgFi/YSnFNkFChOw8hlbbh7JPQcbsOKkki9VMfwajKsMv0ktR4BDhbVF
	 tt+lvKwp29mcACY4NuULchXAnPoLnyMw+A8G2SjrnMYYc/A08yc3hoJY7+ipbZZnx
	 7IMv1+/imEi7LadQ9izY2Y9+X58az1X+wIG447zbAXMaudRIB9VKD6nJsPtqf/XNR
	 TTeF9C+Q4SJ6r6D77HNtm6+TzhRvIFPG9jwopWChxhW4UrIU+abNDv5VkXHZwMP+d
	 eM3DHQlAFxP9NhmAYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1xHONB2tG8-00ZfSE; Sun, 26
 Jul 2026 09:18:09 +0200
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
Subject: [PATCH net-next v7 7/8] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Sun, 26 Jul 2026 09:17:50 +0200
Message-ID: <20260726071751.1359156-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
References: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Byh9zmXbA+S0986ax7OW1/tcnbmeCAleeI/YcfxH+fC3LbnmCcA
 jm+Jmh7zo8uANdrVK3pAah5Ba9nVDgikyTIL0n0pJvSU3gTfUp70hwBY14f3KJ678WGEkBf
 Zgw+YPUvCTZiXtiuu2crF/0j3hTDHs9ts+Bq14yGDHPmQRyYpVv48xibHXRKwpfnjaT5QC6
 D0xEaTEAJ0ryupdFHcEeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IRx/ZqNkMHQ=;9CJ6mJTI0HCEjSFwDBa4a2HIgP5
 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
 A4iCnsdiHD/Ochty+dUhK

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
index f9c02140aba7..2572842a0442 100644
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
@@ -350,6 +372,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
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
@@ -570,6 +646,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
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
@@ -848,6 +933,28 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -898,6 +1005,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
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

