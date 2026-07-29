Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E548CD68;
	Wed, 29 Jul 2026 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340991; cv=none; b=pnreVZvnU/RmwsiG0G6EvvvdTsQV1ralBGIJDnfkf77mjE4jwyXEJb+LBF8T2YnEkPsQFtgpmPdqXxBYpD7QaOMVy57QwQE+EUjoZpiuKVnh5X7be/CswIDTGWeV6cmlesMEAIAPVXBIUjFOD/HrJN6NiaE6DrdwfgKMqUxka6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340991; c=relaxed/simple;
	bh=XAfIE3gOfvh/xkGUP436JD93ghR66z7H5OI6ZmRTZaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4VJ1Faw/RLXqz85xIVCHvh6Y12VQORbXLD3MEV3vh5D0wqlZJ34rjLklvmHD8MK8Y2DRHTWuEMFfglaTWug0BuVAIJ+ffpaepYNdW1R9s1cs6QP3ymnviR6BKWATwzZ3kym9pxdYbYVN5sIsOGu2UEkC81U0CjARSwvZ3/Ro/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Y2H77Nn0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Y2H77Nn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340969; x=1785945769;
	i=markus.stockhausen@gmx.de;
	bh=etwLJ/cTtBx/+sRjHI+8MFSPTEGLhobaBBc8HutCXR0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y2H77Nn0S+mhnh86Pa6mrdFBUTf01b5wul0Urjl5rcBsu72Faqm/xdJNFBY/VRdB
	 EV2XVXeSqD206+kTITapPhByE8ZHNn+Np5L5LYNkW8RlsII2tcGeGe7tFCy+b4yTy
	 e8HsBRa1T0RSVjDzblmF96vccadIQm/ulLjXbPzwnxc9JZD03znel3HSdvNfxtONj
	 V4B1QDMNeK8D1fnEcTL9E4O992yU/EeahY/YRBySOluuR5qscuwEvhLx2K58VEWPX
	 o1w/oCHKVhLe/KzRynLqxVky1atdectoZ+L6zkWSJWUAPFo7FkRKT+50fZFpXiIeD
	 MnUyTdkvYlkFQRGPYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1wim922gJ7-004vpC; Wed, 29
 Jul 2026 18:02:49 +0200
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
Date: Wed, 29 Jul 2026 18:02:26 +0200
Message-ID: <20260729160227.155613-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729160227.155613-1-markus.stockhausen@gmx.de>
References: <20260729160227.155613-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8nda0Pbgo8FVMuIVJgYgwrvrpjAuB1eiXMQlTqjW3IDuoSulAIo
 lHmgCzpCVU/4F1XiIKupKiCkQTKVsl79qZcFn7+q8cVgzeBV+E5ILFsN8F1h3fmPoHJztmA
 m4rr6f0gj42lGii6cA1hTkUGcjJQEqLxGMRjZHqOSP9H1erdvbNaPoaQbqzQODvUavWlFj2
 EOlwdsXuqb5CIUmqxm9DQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eZL3KSePVD8=;Qiwiv01DYtG88o3JwwPxyW63b57
 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
 RpE0nOdCTI2xKJW0s9qXrkDfLRCZwew39g==

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
index 543f16f84133..26beba9625a8 100644
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
@@ -887,6 +972,28 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -937,6 +1044,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
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

