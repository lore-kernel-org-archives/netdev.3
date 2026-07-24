Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FE37F748;
	Fri, 24 Jul 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872608; cv=none; b=uMUNfVHtcKk28PE/ey3AozQBejoGUCdMYCRtlHODWqQGRshJfduM/ysqKGc7hI1bI6Xheq+XkCrKgzBiMwHJK2PR9B2xc9kx5mablQMsrhpLjWhoCRqidCUEPEM8h5k/CJMl4uN1QdRr60HGHzRG2tFgPpMGoELSkKH8HhPKBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872608; c=relaxed/simple;
	bh=8ZioG/tzrNPE/2qldr1WmkLM4p3zqAbVfGk+J5HBHa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T13cRF6Pat8NUp9nqEhT0dO9qyjvzjJz9AnVAl/nL6/NLk+JfcQmXCMkrSAt2QMg4Oplvpo0/B5XZiUlezeeF5/yYGUkA5h795ktCNQFI9rIzBX++Ze2trvWitK8p+Ui7oQZFf8dW8H862G95SqfiEBMBurqLMUyvqvwVpLfPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=o2vFS0W9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="o2vFS0W9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872587; x=1785477387;
	i=markus.stockhausen@gmx.de;
	bh=2I65HQfIluk4Q1WjLOfGIW54gPbMTj5dnpLvCJTUEoA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o2vFS0W9TxchqnoLGxs2/uTMuQ354iJ1tuI56KwOGTzn1x/if40nficdnW+mQfBo
	 BCVr+7/VTldFs1W4MSF0hg30qKW38o9YoPgzNTtn4iIRRYGfgldyZzMZq0kD7OjgF
	 ljuVRTMsTwQ5WOq9EGVc/UWQp6Rr35+mc27j7N0UKWPPH0LsKZarwUbgwHJds434w
	 +3PKakQFXYg30sT7nSwmJCTdid8Lt+hVPUP3vlPztx+LSKa+c8ItldXBz0c7XW43K
	 W64vOeFcxXyCnXichHtLICdcgIIF/gMysb5vBS6uYliztDv9VIEKb58I2G0rbsIKt
	 C573XwkC8lgwzqNjsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1x6AqX0dg2-00shEe; Fri, 24
 Jul 2026 07:56:27 +0200
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
Subject: [PATCH net-next v6 7/8] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Fri, 24 Jul 2026 07:56:10 +0200
Message-ID: <20260724055611.1008577-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
References: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i7XFIIbJ7q1gaqETDcvB80apZ8faVh9J5azb8EWH0ZYauhp0vBu
 269/xZ1WfZKxHzhUFytEwQHOtXhtcyq1bh+Vryuc6AsfR+lewbmHWyqnlUJ3bLdqgSI/eEN
 rhK+pJfN1BBEdpM7qPuC5p3+g9wS1EXbakypoWUJLXVYDL6yjgLi5K0M+ebbJzqdmQ/ttP9
 3z9uWHUZtko/tTEN9EiGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nFF+HrvLNBE=;5Fn3fbxPfLeAZixRt7b4bQAzyEf
 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
 pe+EzOhfz7aOhIG4NJ3Tq

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
index b81dd588cd6e..0b1a71e32ad2 100644
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
@@ -351,6 +373,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
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
@@ -571,6 +647,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
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

