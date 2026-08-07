Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCF39A067;
	Fri,  7 Aug 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122695; cv=none; b=XED89pIv8j9U0320oGIxBwISxVJZLiLX4jBs2pZDVGYd15KsoZaLwOGRafUfF8ZM4hp3GAtS1xxzoHxNpK+yd4ZLtiADUVe2UTaQofWx2+ri4I3CoMOo6qRGnAZS//EwFPCxhBCtPtZOSio8/YBYz5yvpkICxnmYSjrxxP4SEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122695; c=relaxed/simple;
	bh=UsG6w0pkS39XOA5d8et2rvHLaT1wi7vhO/PQmeITo8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIKmogyd/DT6Y/FZAr6AYdIMCEKt56rfE+kj9ryIgPDyDDVClK6GWyykDZDrB+Hw4hOI/BFPrnllgvUt/HE0GrhhAoWxQuU0viHck6Wcf+GB82IImGXX6ywRa9sSBUZhyzF8Q9fcVGDIJql3kse3Lnty3h7a9Q8ljbEOf6yzN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Dg19r8zv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Dg19r8zv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122674; x=1786727474;
	i=markus.stockhausen@gmx.de;
	bh=B2CD3kFpLzAkUDtPIHbv+cbgFTa4ik6uH8dwEp9FMF8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Dg19r8zvxrxRru53XGE11Wfd5su2pgheae+kAGvB1Kn49kxs3Klib3y7S3p6a6uW
	 nilo/IfULcLo/DGMZPekR0vuLEe7btqYacpjLCNOm1zAisx4PQHjFTxOHaZPRqNQd
	 P7TCh86U8VuVYhtZ+/vmCKwRjwIxOPzgaYgFguTajt0+NVvjoDzRyLzocJxLX96wy
	 KgNX38PEZ4nNEHNT2NYzI/oAq5e939nuce5t8qhX+KFDekpht458wcmq+dOQM7wFZ
	 nI4ILDJB5PUF6UNHJngt38cqNjEvHw2vOhTp4BmQ3twSjL1I8Twm/SmPyYnilMp/G
	 RnfEanMTIPCNvouKrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUs7-1x8G3X28uv-00sb5l; Fri, 07
 Aug 2026 19:11:14 +0200
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
Subject: [PATCH net-next v13 10/11] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Fri,  7 Aug 2026 19:10:57 +0200
Message-ID: <20260807171058.522833-11-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807171058.522833-1-markus.stockhausen@gmx.de>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f/Z1hbxiYqu/tF/ehpq8DOVG6uU4CjTMqN1Nkahx91oFful3Fyr
 DwsQUDQO0zq4cHGMiQX19JataBG33h6nkafA1J445YrjZlYETgodGwoLAKR2YOvYy1+6qcH
 9uXT3QJQPlZI9EFLzMBi/yFey+QFW0f9dhn53lzWSriADllsMwNGFVW3+Mkvkxwm7qI/m2i
 N8rQypWj/AbL0gXL1eAMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mjhnSy8nR2M=;mzxQzrdm09juQhN8ld9/M2wDNFU
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
index 6e37a3f52b5e..7792cdbedda4 100644
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
@@ -947,6 +998,27 @@ static const struct otto_emdio_info otto_emdio_8380_i=
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
@@ -998,6 +1070,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
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

