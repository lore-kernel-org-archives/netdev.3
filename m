Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928D4EBAE8;
	Mon, 31 Aug 2026 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186915; cv=none; b=HU3L5cLrm2rbh+JbnQS0hBV2kKlYPo4M6HrMebW4wMH8j5O4WBptonQmQD2FvEWOGOdyIPJ+MvQweJyR0/FE0HgIzc5bjRl5pH42w1VEPlirif6uZ27YkwEG2C7mSlatzeoHD9FBUUnSLQjrjYwsZOxfyHtXdnpzjIMXEY8gG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186915; c=relaxed/simple;
	bh=wAlMISLIxIJwtU039BflmOGU6BTSDZD5cJnSdt7XJTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1bKungmBEutaX/paEDiiKxigN5YvPBWbV+XWLh/xfTt9D+nqH35ltSKJ+U45HGM6s5WO+2VUI6GChkhFmtTQwPAv9hwbWXeT3MbGfeX7e6LxSHLKBREmWrlgeWo+mJ1+54ISUBKOgRWWBGIK4rO38v7ZONl09nmCWWo+SkymzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=qZOUjgm7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="qZOUjgm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186900; x=1788791700;
	i=markus.stockhausen@gmx.de;
	bh=rcRlgJKl6Rsqpxx/sscFMqhs/W4aVpO8urUJn7z8/1Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qZOUjgm7p0+4tqYI7/ro9sE2XkWvbuYA6n9P8HbBGIsxRPE/8r8Ekbt8+m7ESOlM
	 mCOoInRVOOqf4lhxjZ4wGQKXeacpmsFpmZV0pGMPxsumtvryeOfvfXqowThiHk3K/
	 3MiuEGzn02sRvcBEv28Vyo/UX9JsN24eWqDgWwyWkdLxs6HAQ1qaochoqaRQnxpCq
	 l50v76CVzrcQpzoJtQZVqJ9dp94yHMZhrPGdmMt0/mEihLLsdTPqzKFaOY46NDNkz
	 W7/k0Y5AjyMaSGeGj+9SrymxrZ5hZZLF04myF7ilq/iMC24388iWgTd3U+M/5nOAk
	 Q64SLHlOx7WH5PzoFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1xNPTb0zZ5-00UaiF; Mon, 31
 Aug 2026 16:35:00 +0200
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
Subject: [PATCH net-next v15 12/13] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Mon, 31 Aug 2026 16:34:38 +0200
Message-ID: <20260831143439.2404484-13-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ubbSVk1sykregjt5Inl11CF+ifHveymx9QJc5wWscW7gsayLmvb
 OcFfdYcAwEDZiIsjT+xW6fZ7DCVG8vtWJd+KLjOogmdxULuZSRKmFfaAfKbUwGg/6g9aMGU
 wB1mKmCoDdoNQlNsB7gP7ZqJeA3mveWWqC0gwn1OyrT7zoV9TJuh0rE6ovtc85MG7tcGS/S
 o7os7gbu/2vCZDgVztw0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:koT9t1k58i0=;ScWCWu31EXcwNrMRXAK9e0GmqCt
 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
 Q87DFU0H5KsClTjYvatm8Cx

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
index 57ab89afb9e5..86b2040fa333 100644
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
@@ -980,6 +1058,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
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
@@ -1031,6 +1132,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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

