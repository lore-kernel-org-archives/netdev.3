Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C235A384;
	Mon,  3 Aug 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777572; cv=none; b=Gfj96lb7RdFSx6D4sGlgtyesG5xBznbYt7VFr6Ehn9lg349bpgBrzkxWg+ozPwdCrHQIUtHDmfXVnfGFcZdRwiN9ndv/9lXUdyUxiAyFDsEhIMi1cUXSaVOEpDKysXstfIJTiBUhEV1tIS7lVvu813BqPgboF11zlubhYmB8l14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777572; c=relaxed/simple;
	bh=L6cOoqUIlyl57NtHpST7cEC58uNysQ48Ct7ql62QfcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=um5w9GHP89eUw7+ziblpQzMKf6UrkZ9l9JU9OkcdEXpb63JtM2YtfDUsyr63hF/j3zMQBJiVEs+WXciVmBqNXayKGJNvnHyyfsOToFeVmfwyz5WT7Mp3Rmn6nTyTCaWIUpUu+q3i6kzz8kAov0IQyj8lTVvYM7o6ujthPDq4cGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=AvDVpRuv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="AvDVpRuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777555; x=1786382355;
	i=markus.stockhausen@gmx.de;
	bh=XRmIY+tlXzuftKrV0VzkOn4AI/MoiLSAuBfskMw/KwY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AvDVpRuvaO8GsA83Cggnx6bPc4lESfa8kUNVncpfjTSleR9IevpjsQd7ia/1V/qN
	 FXYGsxRK+wjR3ygVgtPoHjBGlOZYDjH7garM53ucsQIp09w7mYMejwhG6AUG0Qw+d
	 MbDUXzBF625Qoik6EZiwPZm+QQn9iFImdV2akx9bkqYu1M/KafdSnhCTpfMdH03YB
	 jC1imdUkzB4l9daFRl/+S6zZH76hSnadJDSGb/KqzwrwM2hXg+w+5FUvOs9fcpwkH
	 t80Sdjw63iqapwmMfKzzGsW9JjoeHM6355z6gFBE7s9UzmPBZWm3Apu+vOpABOzYr
	 wyhtu67EkzrYZZtX7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsUp-1whuAv3Vip-00EaqJ; Mon, 03
 Aug 2026 19:19:14 +0200
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
Subject: [PATCH net-next v12 10/11] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Mon,  3 Aug 2026 19:18:52 +0200
Message-ID: <20260803171853.507506-11-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vnlwhse+RClKXwWFD9eVZ+bltyxgY9pWiESe0bV+eu0orJXy0N4
 dwqoDJLaIZcwCOEPBerczLU2wY46MX3vJp98N9YTXLJ3MC4p6XuisphagdQEESb9FixFhFf
 jH9WhycnYQ6rAG8/P6+7gBoFQKn86V2WpbzNgTjq8nYlW2FWPXO2wSrUqXL64vJhCjaDkuN
 pvo+TSu7gGJpAJCuSwJ3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:diTKtfWisk8=;njchAxlTHllJ/7Tjrr12XhI2uPs
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

As per the SDK the PHYs on a RTl83xx bus are mainly C22 driven. The
polling unit works in C22 mode and the devicetree usually does not
make use of the ethernet-phy-ieee802.3-c45 flag. Nevertheless there are
some PHY MMD registers (e.g. EEE) that might be of interest for the
future development of the hardware. Until that is really needed keep
the C45 read/write helpers out of the driver.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 068f5cdf5558..77dc04630c44 100644
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
@@ -402,6 +424,35 @@ static int otto_emdio_8380_write_c22(struct mii_bus *=
bus, int port, int regnum,
 	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data);
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
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -943,6 +994,27 @@ static const struct otto_emdio_info otto_emdio_8380_i=
nfo =3D {
 	.write_c22 =3D otto_emdio_8380_write_c22,
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
+	.write_c22 =3D otto_emdio_8390_write_c22,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -994,6 +1066,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
nfo =3D {
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

