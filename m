Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A661E32D6;
	Sun, 26 Jul 2026 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050306; cv=none; b=ITu6lOScKvpm6gq/sBK9b6V1dJRtaRer5POmEEHyAk0dtzxmOY6q853YNMTarNYUGmKEQqD7pI/96LXYuRZKhL12KKqdpI0oZb39IXt1DRKzbE8uUP3QlU8O1SUYPwCcicGiL5LDMUCYjrudcgFH8gG9L6hsWTQFGCh6JAr4QIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050306; c=relaxed/simple;
	bh=P8TpsHXJYhCo1CHnAMLXXDtKAal2pQX1SxAE8Yo9BlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzlHsuzzudvIGUYzZ2ebJl5BU41cWP7NkZ+NNWrMhqIT53RaYTdQwTxbgQ2bzpFSJicvXDz57sQ5VgCwk3o/d4tHNGyqNzCqX4mX40gK0JeiVMZJr2E2CQk0nBLTdlcsJYUOMcpJlJFuiyz4FnwmJnYo15K3VGy9mKYrvf1C28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=kh4WXCT5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="kh4WXCT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050290; x=1785655090;
	i=markus.stockhausen@gmx.de;
	bh=Q+C3IYDziJMfAspU+0rp5NjEA9vebPpQ0vCH1lIypmM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kh4WXCT5Vg0csRT2uuxNMZXlOqxC+KhyszxTiyQIxD5Nevk0LatSeczbwfja0WlV
	 60Do0OlGPxFwS7wNuPXdBwMXRFSXN9C8DvB4r5DqKhzjyoVN5WrAlxM8uXUCnhJB3
	 ccG245Pm+63si9bbDyydRBB+3iCPpdiyEv//o7T3BPjy3MSuoivvmWoaop9L88GB7
	 BwsEcPNxz9lag/tF+mJpw6Y1zHu5OTUd++A2SBlOagZ7W3HtdEIqTaXFOlzaAv8Qk
	 KCS7cv4zldWaiOJbAJgzwDckqPl5fFZ2Gek7x1W5mY/l4ImmNh+oHHRImzjhiIPyN
	 q8Xduovu9Oucx6ZwbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTRH-1wZMXc455h-00QUWR; Sun, 26
 Jul 2026 09:18:10 +0200
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
Subject: [PATCH net-next v7 8/8] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Sun, 26 Jul 2026 09:17:51 +0200
Message-ID: <20260726071751.1359156-9-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:asEs/OkA9NI4F18HuIVZyHYPJBtN2FiT9fKdr9QpKPWXI4c7TVu
 UkcjoVlHOScJOLXmoMGyCilacAdn/iKgKfzSwRH9iUrnIzPl4815sbyNcULckzs2KgmrhVA
 8KOr/mRpGuB/n/FSajVH/rR8mMoMbeqN9rBH9/8f923qZu2g3Mt0Li/xgeXrP684H4KI7U+
 CwjYqH0DgA5hpjrwUT0zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C8TqvdqlWkE=;vRTMuepNA/XWEBwzOOsasEOBweZ
 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

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL839x (aka cypress) series. This is straightforwar=
d
but some things are worth mentioning.

- The device has a lot in common with the RTL931x series. It has 8192
  (Realtek) pages and 7 MMIO registers.
- There are two SMI buses for 1G PHYs. Neither the bus nor address map
  registers exist.
- The hardware has not much to configure. So the setup_controller()
  function is not needed.
- c22 read/write functions must be called with PARK_PAGE =3D 0. Keep code
  clean and avoid setting it to zero, matching the behavior of the RTL9310
  logic.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 2572842a0442..a73880338416 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -147,6 +147,28 @@
 #define RTL8380_SMI_POLL_CTRL			0xa17c
 #define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
=20
+#define RTL8390_NUM_BUSES			2
+#define RTL8390_NUM_PAGES			8192
+#define RTL8390_NUM_PORTS			52
+#define RTL8390_BCAST_PHYID_CTRL		0x03ec
+#define RTL8390_PHYREG_ACCESS_CTRL		0x03dc
+#define   RTL8390_PHY_CTRL_REG_ADDR		GENMASK(9, 5)
+#define   RTL8390_PHY_CTRL_MAIN_PAGE		GENMASK(22, 10)
+#define   RTL8390_PHY_CTRL_FAIL			BIT(1)
+#define   RTL8390_PHY_CTRL_WRITE		BIT(3)
+#define   RTL8390_PHY_CTRL_READ			0
+#define   RTL8390_PHY_CTRL_TYPE_C45		BIT(2)
+#define   RTL8390_PHY_CTRL_TYPE_C22		0
+#define RTL8390_PHYREG_CTRL			0x03e0
+#define   RTL8390_PHY_CTRL_EXT_PAGE		GENMASK(8, 0)
+#define RTL8390_PHYREG_DATA_CTRL		0x03f0
+#define   RTL8390_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8390_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8390_PHYREG_MMD_CTRL			0x03f4
+#define RTL8390_PHYREG_PORT_CTRL_LOW		0x03e4
+#define RTL8390_PHYREG_PORT_CTRL_HIGH		0x03e8
+#define RTL8390_SMI_PORT_POLLING_CTRL		0x03fc
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -426,6 +448,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
+static int otto_emdio_8390_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8390_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -955,6 +1033,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.write_c45 =3D otto_emdio_8380_write_c45,
 };
=20
+static const struct otto_emdio_info otto_emdio_8390_info =3D {
+	.cmd_fail =3D RTL8390_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8390_PHY_CTRL_READ,
+	.cmd_write =3D RTL8390_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.broadcast =3D RTL8390_BCAST_PHYID_CTRL,
+		.c22_data =3D RTL8390_PHYREG_ACCESS_CTRL,
+		.c45_data =3D RTL8390_PHYREG_MMD_CTRL,
+		.ext_page =3D RTL8390_PHYREG_CTRL,
+		.io_data =3D RTL8390_PHYREG_DATA_CTRL,
+		.port_mask_low =3D RTL8390_PHYREG_PORT_CTRL_LOW,
+		.port_mask_high =3D RTL8390_PHYREG_PORT_CTRL_HIGH,
+	},
+	.num_buses =3D RTL8390_NUM_BUSES,
+	.num_pages =3D RTL8390_NUM_PAGES,
+	.num_ports =3D RTL8390_NUM_PORTS,
+	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.read_c22 =3D otto_emdio_8390_read_c22,
+	.read_c45 =3D otto_emdio_8390_read_c45,
+	.write_c22 =3D otto_emdio_8390_write_c22,
+	.write_c45 =3D otto_emdio_8390_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -1006,6 +1107,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
info =3D {
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
 	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
+	{ .compatible =3D "realtek,rtl8391-mdio", .data =3D &otto_emdio_8390_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.55.0

