Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E01444E655;
	Mon, 17 Aug 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984026; cv=none; b=GxS+dkdEx2BKhsXTA7OpRkghyYL4FUiOSzKAo3pRk3g3I3STeiS0Y5ki2z7xBYz7isCsVQwovG5xuSLS87SAkfII7hb7oPf41FG3krkM6aOh/CKVRjmlPPJT6s5okC6NnU8gcJkKtwLO1jfZDVt6LLU2IM0Dpwoy4QvycjLrAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984026; c=relaxed/simple;
	bh=2pQZgmpdhmNXGH9t38wSgsN/adB7qH4/Nu6hXX8ncgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2v7Zz/z7XUSZavalWWjfbC4S//1m9CQV2iSEgATtCgplNtvkccSbd3LNBhkLo+uHweUSra79kfhStuOpzEwSqhBsSAGQ7W7b5uG0rydm5dZ8vG5/Uga3FXG2V82ZqXRavijgGgQWWnWKoI1DUxqjMlT7PbQ6+t2Ufyv4POCFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=cJv/3sFQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="cJv/3sFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984012; x=1787588812;
	i=markus.stockhausen@gmx.de;
	bh=r8IB37iEmjaAogt+uRat+nPA+p5ERgVafRkuTUi3SWs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cJv/3sFQP9VWjWqrOJY7mP6D+FT8Zr5hGcLQmOlk+V5YgHOjI8cqPYLijfS+U5Tc
	 yvQoGUDkK9/hro80ukUELv0WoTmndGxKnrczit6FB03P39sK+ibnFatofXMZQoK6o
	 tWIv8LWls2IUMWA9ZMVMeHM8cbErD/h+sj5ANzK6Ku+E+y74avIVKhMjbkn9D6cId
	 Bv16K4lqlKxxj1GQ6fzsdBAZ/hEGg4Rj4lKimbJp2Rvn+RQGUCJrDfYIhrDSAnYIC
	 B+r/RRddukCo6unUIbMw7iWvPkRC4tNwzkFS2envIdnx9qsvwWLhMLSVb91Mj5MIz
	 91zx6VqO166mseBhRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1wQUyl30F9-00chiB; Mon, 17
 Aug 2026 18:26:52 +0200
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
Subject: [PATCH net-next v14 11/13] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Mon, 17 Aug 2026 18:26:30 +0200
Message-ID: <20260817162632.1208891-12-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nnaqy5Ka7Lqpi9zNzc5CamkJyh06Rdz2Ckecn77JsAqJHKH0kaV
 B99km9nfN0Uv1BfldATAd1LstEitoLlkrPe5/l+XZdzjxgE0Yrr1hTtWTa30lWyVKm9MJn1
 w3xj96oWXzhxKMrDjR3FPXC0WQvaTV8BsvyvB4q4oXEtQAXtX43Oi0GQHtUBMpJPEPotNgD
 593BS3BBxbTex+JhV8iyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:psSsveYh/eE=;NNNN24/GeBnp+Pz4IkzijTaxoVX
 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

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. It has 28 ports,
  4096 (Realtek) pages and 4 MMIO registers. With this a lot of the
  existing RTL9300 defines could be reused. But to avoid confusion and
  for better readability duplicate the defines with a proper prefix.
- The MDIO engine has no fail bit. Thus the mask is set to zero.
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no C45 configuration as polling
  only works in C22 mode
- The PHY access must be activated by a special register flag.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index c417a2e3d613..be912f2952f0 100644
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
@@ -353,6 +375,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
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
@@ -581,6 +657,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
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
@@ -868,6 +953,28 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -918,6 +1025,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
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

