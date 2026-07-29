Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77084DBD6B;
	Wed, 29 Jul 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340975; cv=none; b=oL1SDaF6Kk9Ae7piXYNF3BX3o1SGe13RsF0B+LIL95/X1S3IFUvq3w6UlAQxnf1llJSjbKfWIQXGBaTSb3nEtdDZZOTEFWTq6RjQID5Ax2w2Wc3S2AfJ0Xq33cCVKwqg2SE/y7+ZprcvnA5xO9LTgY7ZuljA0xZSHJgIR+wN5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340975; c=relaxed/simple;
	bh=rUjKOz0hgC93tkQgnBPacPolu0ZMUpqGCII/5RWiTo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN3TZtLptLBN/pymLdZt7YNYge3zMESt10NBgjdEwGrjl3L8v/tic41FznOQgG3Ad6I4U5qG8DiFXsSwyoZc3H8Rxu9JxPAi43VZiiBWmq3kjExbQRM48btM3H+6njRkpttJz5n5FFHJJyD/AqQwP3v65FTZF+LHhhFibucWaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=WvlxxnK8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="WvlxxnK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340970; x=1785945770;
	i=markus.stockhausen@gmx.de;
	bh=Zj5nJHLPt1anZLcpeL+A2tDkKjQSW5p0T0raLBujKXU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WvlxxnK8vIc9fvs53czA8O7516f0wZoeNdgZz/t154X7J++K95wUUY5rtixlO0OS
	 rzV5QmfO5WSfuCWr4qXi60OJ/pdWiF4ofFCWR5w+AMSjTkKTy2wAqEBRIk+h3a31H
	 rDZ8Wc+L2JZiXMnRQ6qrqaJDntFKW2pmDRLFt0aW2wYPYkwQaJno2CnjWd0HMoisQ
	 DnsCrPt3Wtrqj+9seiu2gMujpFJ4Q45OAlPB/mZrpcAVOyv8Wt29FiyJVpq/F3q7X
	 oPyUg8cWTl3nq1MY+B1sMSN5EhqPp+PiruzIBMrrK7/+1faEwRdxnNqOC3S+hMlhJ
	 QFB6uKD0xCjke3VVcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1wQ7EV1Vf3-00LMFa; Wed, 29
 Jul 2026 18:02:50 +0200
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
Subject: [PATCH net-next v8 9/9] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Wed, 29 Jul 2026 18:02:27 +0200
Message-ID: <20260729160227.155613-10-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:dFDzSKjIvwfXNIso61Mos+hutZdms7ITeZUBI4SqZCxVrTZR2qr
 UlqWNO2+JqBi+a0frcLUxRHeORjfJ+MXOynqQdfKccLOmvixT1c/zAEDn/vKeTHdx/kHLIF
 8tsV3UDt9TAy5f1nkxo1SjmX9PtTXKfUItIJx8C8oieWIjYgpiV1Cm7pup72uDCPlO+wz1R
 nzZZfu+r/G4BQaa1+51AQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mX3iOKT/sEc=;ScYgGiC8i6Rdx68H4hqB0WZZfzN
 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
 VSi+xR6c71if1vSG2qbn6zWWBUigw9itPQ==

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

While all existing RTL839x designs only use c22 bus access, this patch
implements the c45 code paths too. The hardware supports it and this
simplifies future expandability. Leave it to the devicetree if someone
wants to use c45 on these devices. This avoids adding extra checks to
the driver.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 26beba9625a8..d9d4b704afb3 100644
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
@@ -430,6 +452,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
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
@@ -994,6 +1072,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
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
@@ -1045,6 +1146,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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

