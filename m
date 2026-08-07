Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFB3FD96B;
	Fri,  7 Aug 2026 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122698; cv=none; b=nS0y9N+v+7VYIcoueDM8s/f3BHJ9TpY4LDRipiuL7KdMJpx8Z3oqKVMZi2lEhrSFH8HJ/157sCngVMf9TpdOvze3UivStp5Iw+Nsmt/mMf7btIG3MQh33RX2h8qcX9qBVbxl0DY73l+7CFrAc7nNsamd/Sr5PY4XJZ22f3H6sNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122698; c=relaxed/simple;
	bh=Wv9WxvatIFvhHtfBGS8RVK2s/7ZoDpO6oTT/qUiNeMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTQQir4Jj9+S6KpuOb5LWpa1nfvDY5h2nEnsEGGahNTGJxrcGvYWZmxNSqAs5bvdCH9xkyRGYlze3MfY7H8Yq3OiyBEN7rctVEzS3cmETicxrqUplCK3/Rp8L/HqABjT4lrioe9xP4NSLzfnHJHMMtxHpw3pofPV8SWUPPiF5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Kk3773mJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Kk3773mJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122673; x=1786727473;
	i=markus.stockhausen@gmx.de;
	bh=lrBmCNQTqbCLimjFx6QZFTi+6/j9gNHGkOxx70jugM0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kk3773mJ9LvEZqzabyByeTzEeotIrV0ZgqDtnh+DG9SUMrs283nz3W6/kHKAF357
	 0X3vcEgGFwAB12v+HFXaIHLsKb8ZxEpY39S1ZKnjUQyPZpxMH/RRsHOg4jt5MNb8L
	 kgJJGQDZnLBr3NHRDWymf0XXkVxdRthyFdB3Xk23HhmJ0THifphLGvMi0/fGE4qSz
	 MgiaWKuUq/hDBK820SvRCg6D13XBiYqfRbuk/IUoaPCEL6mvEFK/dWehX5g2yQMg6
	 FCRJXCAt0Uxt4+oBCdZzJBMWnFZxdnLURcADwcPlVXFWgU7KLrmFHiVvLqSeF/1Rw
	 RvhwtyoKoytLdrUUcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO2E-1xGkTw3kPA-00kAtU; Fri, 07
 Aug 2026 19:11:12 +0200
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
Subject: [PATCH net-next v13 05/11] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Fri,  7 Aug 2026 19:10:52 +0200
Message-ID: <20260807171058.522833-6-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:WjKP7YMAYa3BbceWOBOy2GKrinqzGn32QLAVnpiX/sd/Df3x9IO
 5arYlkoYmatklIY13cX60+sG+cYS+AUamhoLo39EB+Bde+j92hHGdcgDgtxkqs2uAxyJGsA
 057/UYz9Y8jo4qnojlrLEfCNOMK4VrQh9AexPiaIcpwrwBcENdiUOPemOMima+VG7c2Lkh3
 2BCVsD5mSK8dt0hsGndRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y48pEhTliZU=;UaN6QX5DjnjNjoc/aHYqYhX+2AE
 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
 Wh+FkM/Pf8=

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

Important notes about the implementation:

Realtek is very inconsistent about its register naming. RTL930x uses
SMI_POLL_CTRL for polling control while it is SMI_PORT_POLLING_CTRL
on RTL931x. Keep these vendor names.

These devices do not support power management for the whole system.
So mdio_bus_phy_resume() is not used and it is not required to
disable/enable hardware polling for that usecase.

These devices have no CPU MAC to PHY design. Thus abort phy_attach()
in case PHYs are not mapped to valid switch ports. All MDIO bus
commands will fail afterwards, leaving it in an unusable state.

Enabling/disabling hardware polling is a simple regmap bit access.
For this it is enough to rely on the regmap internal lock.

This polling enabling/disabling does not solve the current inability
of the driver to handle C45-over-C22 access during normal operation.
For all existing designs this is not needed.

[1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/file=
s-6.18/drivers/net/mdio/mdio-realtek-otto.c#L818
[2] https://lore.kernel.org/netdev/680696024a8648535ce6dee771fe4de67802e0e=
8.1769053496.git.daniel@makrotopia.org/

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 1873928b362d..a30be66c4b17 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -145,6 +145,7 @@
 #define   RTL9300_PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   RTL9300_PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTL9300_SMI_POLL_CTRL			0xca90
 #define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
 #define RTL9310_NUM_BUSES			4
@@ -170,6 +171,7 @@
 #define   RTL9310_PHY_CTRL_INDATA		GENMASK(15, 0)
 #define RTL9310_SMI_INDRT_ACCESS_MMD_CTRL	0x0c18
 #define RTL9310_SMI_PORT_ADDR_CTRL		0x0c74
+#define RTL9310_SMI_PORT_POLLING_CTRL		0x0ccc
 #define RTL9310_SMI_PORT_POLLING_SEL		0x0c9c
=20
 #define PHY_CTRL_CMD				BIT(0)
@@ -217,6 +219,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -252,6 +255,12 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
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
@@ -582,6 +591,36 @@ static int otto_emdio_9310_setup_controller(struct ot=
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
+	if (port < 0) {
+		/* All subsequent bus operations will fail */
+		phydev_err(phydev, "PHY is not mapped to a valid switch port\n");
+		return port;
+	}
+
+	return otto_emdio_set_port_polling(priv, port, true);
+}
+
+static void otto_emdio_notify_phy_detach(struct phy_device *phydev)
+{
+	struct mii_bus *bus =3D phydev->mdio.bus;
+	struct otto_emdio_priv *priv;
+	int port;
+
+	priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus);
+	port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr);
+
+	if (port < 0)
+		return;
+
+	if (otto_emdio_set_port_polling(priv, port, false))
+		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
+}
+
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
 				 struct fwnode_handle *node)
 {
@@ -611,6 +650,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -727,6 +769,19 @@ static int otto_emdio_map_ports(struct device *dev)
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
@@ -746,6 +801,10 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
=20
+	err =3D otto_emdio_init_polling(priv);
+	if (err)
+		return err;
+
 	platform_set_drvdata(pdev, priv);
=20
 	err =3D otto_emdio_map_ports(dev);
@@ -786,6 +845,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -811,6 +871,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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

