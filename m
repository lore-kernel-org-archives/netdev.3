Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E53CF201;
	Mon, 27 Jul 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179793; cv=none; b=KM/ai36/04/eL8zkOh2mu0HcPlFPcVNgFUh7BuPhncgQQSuaEqdtFvZh7AzWBkS49gPapbGqkRmDHerCDfefSVhQvPsBKDwTYNMJChu2pDkr7zV3ULKn6MwOqoSoiiJIek83lC5nafOT5DMwdbt8yqLuCRhVYmEg8ZqRwjd4rXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179793; c=relaxed/simple;
	bh=ARNCJZpYzyyZkTh/FraYVBDI5wogl84Ep6/xDvK/1vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgzqrqXLuycMcocTjrVJ0+Wdd2KGDkDmlHCcGcSaJdzmNQ81GuiT27A2EBUsQ1XQ612UBH6XuZsBFupCM/L9bP0gNsH1wxRPz5dZH3cMJZ21fvddVhZFIxnwZnTqu7R+c5bsztDprfswvkvUCGiQUtszVUsOHybflVeo9SwqJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=NGrXToIT; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="NGrXToIT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179775; x=1785784575;
	i=markus.stockhausen@gmx.de;
	bh=Vr37C98lvE3tsuRLA5GoFP1k84ysEf9rQsqJUnZym8g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NGrXToITtzibnb9J3OVgUdm0OYuadvtkqVFjh3Y4+qpZmT43fcwiJimOHWjz7qpq
	 q+Z4MZdh+NPd3nPtP7nuLdNmFbASCDGxr4IqWfnaGDtc00g5UieH+cSsbc4UznxWu
	 4JfndVKMLfGnYbPbsvh9k4/Gx1TozQ4u3KwfiOlkCI1FeJdHZ1xqSBHSwNJMVEVdA
	 ftptzabrfKY4ylEveRF5RH79oCtdXvewkQPSBt3ypvSo+B9MbSulVTC966DuseH7C
	 YEZXW5EvEFa79wZ5goD9CFbAmYgpi4bxP8VjGKmAklgVXTXjzszcAa0fOwjmJGc4v
	 xy1qi35l8rYWJWI2Fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1wSkF60Bkl-00K9jk; Mon, 27
 Jul 2026 21:16:15 +0200
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
Date: Mon, 27 Jul 2026 21:15:59 +0200
Message-ID: <20260727191559.19617-10-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191559.19617-1-markus.stockhausen@gmx.de>
References: <20260727191559.19617-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bOQLi39CAqyLVbIbtq/JLC/hW5Rd5CkmwS7xRFs2G+HXjBnfiqJ
 +8AOKhD4gjXOXMDONEG+EItYSMZYPQgW29qaFSOMhPwtcrycvg0lnm0Ok4FVPkb4el4JcM2
 cnlPAUrFwJPc49B1XySVUeGylF643uTqN+1n2BRZgTxzDd9sYbKJzgdylhGikMXCMdxv4V3
 ivlGx97EiHfLw4+cNoIKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BSmZtPrbYfU=;1ISjWDuHdut/G7UFwVnrnU1wLfV
 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
 =

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
index 9f76698a84c5..7df1f6df499b 100644
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
@@ -428,6 +450,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
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
@@ -987,6 +1065,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
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
@@ -1038,6 +1139,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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

