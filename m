Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963B35F199;
	Fri, 31 Jul 2026 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478475; cv=none; b=XIP+OEgjF+eQR5fj0v9n3wF3GSXpA1MCLWXiW79IuY6T/YonQF37svdmd+yIAsxVXXHf4bbQk3iJ3jQNHxO6GrIIID02ZjpTtGsgO++xpiczTMFF03xN63II8A2tzRuA2q9MSMTLXMcQ+bC6typrh2vuxpG7vYKNHx5UaPaW+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478475; c=relaxed/simple;
	bh=SLXX5O/tJDtCkW3o3mCXh7amHbc2PHtGz+VIKMbIo4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzudboAAXPLp8sGa+gcGjdvBPZC8rugFx9dI3EInKFau3yUBOciAIYwwbQ3i1VrNX0wGw74MXIn6lAlmxqL/hb2jmZJhA8FrH8ouMDI1fim9qsQLnsO2HfJQPtWFuMerSnTipmE1eba7UQmTgFBDqoLvOEetRnpujnJd70fI2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=PmZ+3hXr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="PmZ+3hXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478457; x=1786083257;
	i=markus.stockhausen@gmx.de;
	bh=Z9aJBNbTAIg/3W5dnD0K2x1DRqULf/qjhCG0hRf4oXk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PmZ+3hXrQlR8GV8nQ/tJtzihup3GKeoESsYXpJSiyzFVgVigfD8EdL17enQDEhgD
	 Wt0KkR0ZloslKQj6rxJLQYjd8fd/zP1jdHUfttY97MUSY4iBQoMiE5ZxpVgFm9p6e
	 OvZvbNLY2NKulLNY5FlA20EyyaUZM6XwpSZvBZReBbQ8r/IFCbv41nrEufCjkLnff
	 RFbITPTp2rexkQCo5lRg/wqsMlvKgbNxGCIMS5Ipz4wndomNem0IueyaIk4ijXIIj
	 j1A+jQPvmmKb9a9xmxtx4BDUBEhPEkHTMXVcvFz8okhql7wKoBS/Vk+f/Rkaf5V3n
	 bRKRkyQP66S9cQQ6bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1xOBqe099p-00dVcO; Fri, 31
 Jul 2026 08:14:17 +0200
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
Subject: [PATCH net-next v10 09/10] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Fri, 31 Jul 2026 08:13:59 +0200
Message-ID: <20260731061400.78301-10-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wAX8PnM8eTQa4gnbhSGs3wFj3llDyEF+2iCrrLr6DNigv5RTD3U
 Q+Qwsh08IYVVOyxwvVPaAeMzszUfMKp76d4ot9BW1BDMHdqav4jRPJkeADocku2vomC0Dcx
 hhPKZpphZi4AVviHnc+Vqa2FFT3pIAddaKaC65a+mvMv7VcmzQZGqPh6kOxpF1fKs9XMOjP
 jYsNM54nKd3kF/LDvemZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bFwnhiq0Mns=;fbC/UmLt08Qohr0apZHiXb0mcFb
 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
 yi+Oh1UYndxGDDMmR3zul+Zs9wftUTu8aA==

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
index 88bd3ecc8a1b..6f8e48be024a 100644
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
@@ -993,6 +1071,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
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
@@ -1044,6 +1145,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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

