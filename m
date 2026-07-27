Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7FF3C4B68;
	Mon, 27 Jul 2026 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179794; cv=none; b=RdrWAZTCbj3zrSrW24rsdKPUQ1jnmYrmMfz7zTWf4z4rfDhv7OFjhHOXSlP3OcBuDbEGT/X9dymBDc/gUnceE3FI4duLC9Wp2NvFKdVz5vsqm7o3skOix/WnP0yzw6rtc1My4ofEKLdZsAxgPH4BPSD+HJ0Yi+dixJBurmiESQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179794; c=relaxed/simple;
	bh=kJ7oo281iBM9AynOe/FTE4KRyHAoLG6PZ6Dxr0iLzoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPwSx7OhpujrbmJhD50pTOYwXOVT0j9LbtlEMIV7cM1EA2qesxDLzhDLkArDgx0TDY4crppL1nkut86yELx6h0dE8uDCaqM54sQXwCXpNNYFm02F++r8KAvZh+wFcpHOHkcwyG4bCvUDbnDjvlXK6ImnNa1X27Am4/vde/B9kCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=dKHTHRyG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="dKHTHRyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179774; x=1785784574;
	i=markus.stockhausen@gmx.de;
	bh=OAPhVPdK1JERTkmBerDbPX3rdXQul0XCQUq1+AXHa9A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dKHTHRyG8ojJRWjPWBPQP+wvOV7zw56ppjshP/uQnb+DC1zeEMylx7UEV/BcQ9gW
	 rQ2xMTxRUdBAjlzumCeSVY2Tm7Uqu42BymGQhhjzQVW2qSYNEv3UEX7HjT0zp/m6X
	 GueNpcQhjazFOUCeSQlx7gzdJOqJUdnirJSfZ4DGzj4TVxVPSEcyW+CPW3k0Kh4Iv
	 jMmdDvI+VyPgp8sYHZwvfnI/B7+wcSgmv6vCMv8ZTMxuzVcaJq2hC+L7FOZeVNIFS
	 x4XWCIIFHlE0hQ4Hbd5pYzxcqvO4GNtNuHkPp7pi7bkP/g2FjSk0xIze7zoqLVW3c
	 H/bn750ZOu2jA2zong==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO6M-1xLGZZ37iC-00dC9v; Mon, 27
 Jul 2026 21:16:13 +0200
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
Subject: [PATCH net-next v8 5/9] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Mon, 27 Jul 2026 21:15:55 +0200
Message-ID: <20260727191559.19617-6-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:JMsaHHzW3t9mls5xCBIyhDnXwrCQbeqMGpE6WGyRMkm1gJVOJFf
 xWUwlS1/IPXlPMbIYQ1JYn05At3/AUNzO2ALJSRibtTeOPj88Z/v//v87ektY+SPNUimWsi
 0/S1WV2dXkOFfxWji8bvXKmqZgin8PAafatJLE7bI55++/QXMBCFGVn5hdJ7BJKOJtoOdp8
 E2epQqN6HwN04hTKXnyEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TwiQBwk3IxU=;5pTyYTwug82X30BFbZD+J69+nxU
 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
 B7z

During PHY probing and configuration complex configuration sequences
might be issued and firmware might be loaded. Hardware polling can
interfere badly with that. E.g. a hardware polling MMD c45 over c22
request might break an ongoing firmware loading sequence.

To avoid such issues the polling of the Realtek Otto switches can be
(de)activated with one or two 32 bit mask registers. Each bit enables
(=3D1) or disables (=3D0) the polling of the corresponding port. Make use
of this as follows:

- Disable polling for all ports when the MDIO driver starts.
- Reenable polling just after the PHY has been attached.
- Disable polling just before the PHY is being detached.

This synchronizes the kernel and hardware polling to some extent. It
gracefully handles deferred probing of PHYs in case the driver is
loaded asynchronously during boot. Additionally it brings the hardware
polling into a consistent operation mode for devices where U-Boot does
not take care.

[1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/file=
s-6.18/drivers/net/mdio/mdio-realtek-otto.c#L818
[2] https://lore.kernel.org/netdev/680696024a8648535ce6dee771fe4de67802e0e=
8.1769053496.git.daniel@makrotopia.org/

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 9529f877248b..0d5b9530e43b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -146,6 +146,7 @@
 #define   RTL9300_PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   RTL9300_PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTL9300_SMI_POLL_CTRL			0xca90
 #define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
 #define RTL9310_NUM_BUSES			4
@@ -171,6 +172,7 @@
 #define   RTL9310_PHY_CTRL_INDATA		GENMASK(15, 0)
 #define RTL9310_SMI_INDRT_ACCESS_MMD_CTRL	0x0c18
 #define RTL9310_SMI_PORT_ADDR_CTRL		0x0c74
+#define RTL9310_SMI_PORT_POLLING_CTRL		0x0ccc
 #define RTL9310_SMI_PORT_POLLING_SEL		0x0c9c
=20
 #define PHY_CTRL_CMD				BIT(0)
@@ -219,6 +221,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -254,6 +257,12 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
(struct mii_bus *bus)
 	return chan->priv;
 }
=20
+static int otto_emdio_set_port_polling(struct otto_emdio_priv *priv, int =
port, bool active)
+{
+	return regmap_assign_bits(priv->regmap, priv->info->poll_ctrl + (port / =
32) * 4,
+				  BIT(port % 32), active);
+}
+
 static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
 			      struct otto_emdio_cmd_regs *cmd_data)
 {
@@ -584,6 +593,32 @@ static int otto_emdio_9310_setup_controller(struct ot=
to_emdio_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
+	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+
+	if (port < 0)
+		return port;
+
+	return otto_emdio_set_port_polling(priv, port, true);
+}
+
+static void otto_emdio_notify_phy_detach(struct phy_device *phydev)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
+	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct mii_bus *bus =3D phydev->mdio.bus;
+	int ret;
+
+	if (port < 0)
+		return;
+
+	ret =3D otto_emdio_set_port_polling(priv, port, false);
+	if (ret)
+		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
+}
+
 static void otto_emdio_cleanup_controller(struct kref *kref)
 {
 	struct otto_emdio_priv *priv =3D container_of(kref, struct otto_emdio_pr=
iv, kref);
@@ -628,6 +663,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 		bus->write =3D otto_emdio_write_c22;
 	}
 	bus->parent =3D dev;
+	bus->notify_phy_attach =3D otto_emdio_notify_phy_attach;
+	bus->notify_phy_detach =3D otto_emdio_notify_phy_detach;
+
 	chan =3D bus->priv;
 	chan->mdio_bus =3D mdio_bus;
 	chan->priv =3D priv;
@@ -749,6 +787,19 @@ static int otto_emdio_map_ports(struct device *dev)
 	return err;
 }
=20
+static int otto_emdio_init_polling(struct otto_emdio_priv *priv)
+{
+	int err;
+
+	for (int port =3D 0; port < priv->info->num_ports; port++) {
+		err =3D otto_emdio_set_port_polling(priv, port, false);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int otto_emdio_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -770,6 +821,10 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 		goto err_out;
 	}
=20
+	err =3D otto_emdio_init_polling(priv);
+	if (err)
+		return err;
+
 	platform_set_drvdata(pdev, priv);
=20
 	err =3D otto_emdio_map_ports(dev);
@@ -818,6 +873,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -843,6 +899,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
fo =3D {
 	.num_buses =3D RTL9310_NUM_BUSES,
 	.num_pages =3D RTL9310_NUM_PAGES,
 	.num_ports =3D RTL9310_NUM_PORTS,
+	.poll_ctrl =3D RTL9310_SMI_PORT_POLLING_CTRL,
 	.setup_controller =3D otto_emdio_9310_setup_controller,
 	.read_c22 =3D otto_emdio_9310_read_c22,
 	.read_c45 =3D otto_emdio_9310_read_c45,
=2D-=20
2.55.0

