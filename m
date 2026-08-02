Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28942386C20;
	Sun,  2 Aug 2026 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659752; cv=none; b=htYtYEdF9aNsKpFv/Ds8JOsfqKhZBxgIX2edZFOnDLaxJp4xc/b6fpTkYIcAziSoArBEReCbU8kCUL37ea1fDiCdqPWwIL0xjLOyT4vOKV2MH02M69kT3AvfomKCfc/ue4ryD8KW+3GfKPAO35ykT6GRD8jFDD4/q8syKoKX3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659752; c=relaxed/simple;
	bh=THH1Gt6XzxPqRkyKnx4EHlmjImNGxUbpltBBeEMURSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWAiQk03MkUS893z7UtiWiJZvRUPum/zL0Q3pU8O7Jl2AnaaC9XD7n4bW/jGoDqL+213JpipuO8C4A6AIcOjzDlGbYmcjYE1uRhA0Ve+DRYBFigatCkoxIuN4UBOK/4ua7qEXHznJQoGLQPyAwhXZEQ6My4qejKPQrUay49OZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=T+su5SH/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="T+su5SH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659747; x=1786264547;
	i=markus.stockhausen@gmx.de;
	bh=lg3FgNQEq49U1KPFvdQBazJGXNKKAkPmuSAcYrfI3sE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T+su5SH/WifLSb2wNe5HRE3SVJwYQxP9IgtezSkHjueRj5whE3LhovnGkbqhsVxF
	 l2dRXjNUGhYU8j70nnz89Vv0u5sKkatAD/97kpjz6PyRLGHbauo04IpfmKYCDPgTO
	 thI1uc9adm1FE2PZmFnpk8YVg3Em5BKa4A/oNTLKUQYunOJu4A0zfaVoqBTiINynP
	 dAw8hWgVXbkqGTybEvAr8akBajKh5qvvkIdKqSOUqs9c+7HgUM/VLFazpiqLDixtd
	 Ul6c3IkO/E+YC1djxpakCweI96FeMD0EFYn5hOrUe1StjVRVkeRmrNXE5nPrMVM4G
	 aiZFLLE+Ha31IYuv0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1xOxPM2ZjX-00brZM; Sun, 02
 Aug 2026 10:35:47 +0200
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
Subject: [PATCH net-next v11 10/10] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Sun,  2 Aug 2026 10:35:28 +0200
Message-ID: <20260802083528.490216-11-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0d5yyIMqNjgJxuHr8uhZKYvDx7hNhcuSw54tsggFN5Tp0LZonPz
 BQDM2XGaYWMnpk0LKzjwfX3R0i+aFYCdmtQiAYPrTv5X9atcXU2ZBeEDNByzISzxOP0S/zf
 b2EPYuHA2/iF6dQHRuiMc5XIGm8mc1OSw/h1H5v4IHzUKtG7tgJcue6YIQFsGjkHjJXwsfl
 UB7wARgcE3oyV9NG7FYjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NMWzJeJMojc=;F49rr2nN39GrHFg3yIO57GE/O/E
 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
 lx53iTw==

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
- As per SDK the broadcast register allows to write to multiple ports
  at the same time. Unlike RTL9310 where this is filled with a bit mask
  for the current port RTL8390 does not use it for normal reads/writes.
- The SDK fills the EXT_PAGE register with 0x1ff for c22 access and with
  0x0 for c45 access. The reason for this is currently unknown and a
  meaningful name can not be given. Align the driver coding with the
  RTL9300_PHY_CTRL_PARK_PAGE settings and simply fill the hardcoded value.

As per the SDK the PHYs on a RTl83xx bus are mainly c22 driven. The
polling unit works in c22 mode and the devicetree usually does not
make use of the ethernet-phy-ieee802.3-c45 flag. Nevertheless there are
some PHY MMD registers (e.g. EEE) that might be of interest for the
future development of the hardware. For completeness and extendability
the c45 read/write functions are already implemented with this commit.
Just like for the RTL93xx devices. But in contrast to them RTL83xx knows
no flag to switch the polling engine between the two modes.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 6a47f872a352..67f3b2fb33bb 100644
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
@@ -970,6 +1048,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
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
@@ -1021,6 +1122,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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

