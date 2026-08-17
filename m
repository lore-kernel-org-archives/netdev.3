Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160744E67D;
	Mon, 17 Aug 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984032; cv=none; b=sIkSSfeFMoHy6aBh5aFUtk9Ny0Wamcqq+rjCntqHW/zoiYklsKXg+DMtf4ZX5UxmnDxFEkjQaXwW6vZoHAuLj4IBtqbbHGigsu6DvyGAAtc0IPVtmgUp9AjcgFqUCnrHRQCOay8XT28ah+v+F5e7ahHryq5+eBTmi993chJNyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984032; c=relaxed/simple;
	bh=gR1xEMvAlILk8M985N4krzHwN1gVu2yanDT2EQ90M/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRKmPhPKPcSrQBUKySvwizZSXfLJSLh9DPeFawBClP1lH/7zU+YCoGhbq5S4ysqGsJucp3txtvCutuQoWdkDHWvW7TSuKDZgpNVsSM4Z4RRUtWAS4nyPg4rQLWEabuutdA/V6mP5Lcdisw22SN6Gg1wxz5D1fDFHCC9lMYAdBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=RMGPCIrH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="RMGPCIrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984013; x=1787588813;
	i=markus.stockhausen@gmx.de;
	bh=WcwZ+ndusWWH3MPfq8RAMt7kPghEjXD1jDQnwxhYHmI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RMGPCIrHJi9hspxeukL190yqzDl3XL9vP0IB/b3WSwxATmiutijoHDNR1xLFZw2H
	 vYAhOwAQh8WNmtTy4WaxeMXYiaNftKYy4DP0o4gqD5/iHiUAfbHsyIs/iCm2hVCSG
	 5uRLynAGd5J0Rk7DROuVnyQ+XA3ePuCGCNmuTphzlABeTBzTwu8okSz1+S9qP0Vs+
	 xhKiBXU0Ex2lEKDGAve33DPUvtU70Gek/IooCNwDQc6N132WbuE1rnFCJJRKKrTSh
	 v+iiNtOrav0nBEp5smSrobd2yDHeeUolhyZM7ldSGcaxfUdf1bo6IWFkFyvfBUgZW
	 f0MP2rKFTN4ZIfndjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1xL58a0N8H-00IAHh; Mon, 17
 Aug 2026 18:26:53 +0200
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
Subject: [PATCH net-next v14 12/13] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Mon, 17 Aug 2026 18:26:31 +0200
Message-ID: <20260817162632.1208891-13-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:N0yZ0rwyvYSfcgvFBaWn5U+M0pRdUIRR4m+YSyk86pTCK2vWvMm
 3jS/nlqEdIdSA+/ScA5Tt489Nsjz1EOnHBIDi/BQabTgY2n+ZLjXRFihY7rJitKOYli8IB2
 Rxn3f6BezNPmZZsHNzy0a3eieJFWt5ICSpG/ZowxZ1/xIUoFS5A8zcqFzJkq3CrI+vxxhD2
 Wjr+HIGK1g5bUmKwUxlHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L3ea/tFjqno=;UQ8D1+yIf5+4/UtMLv4yASt3Wv2
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
- The bit specific registers (polling & port_mask) are 2x32 bit wide. The
  ports 0..31 got to <reg> and the ports 32..51 go to <reg+4>.
- C22 read/write functions must be called with PARK_PAGE =3D 0. Keep code
  clean and avoid setting it to zero, matching the behavior of the RTL9310
  logic.
- As per SDK the broadcast register allows to write to multiple ports
  at the same time. Unlike RTL9310 where this is filled with a bit mask
  for the current port RTL8390 does not use it for normal reads/writes.
  It is simply set to 0 like the SDK does.
- The SDK fills the EXT_PAGE register with 0x1ff for C22 access and with
  0x0 for C45 access. The reason for this is currently unknown and a
  meaningful name can not be given. Align the driver coding with the
  RTL9300_PHY_CTRL_PARK_PAGE settings and simply fill the hardcoded value.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index be912f2952f0..24c7d91c2870 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -148,6 +148,28 @@
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
@@ -429,6 +451,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
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
@@ -975,6 +1053,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
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
@@ -1026,6 +1127,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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

