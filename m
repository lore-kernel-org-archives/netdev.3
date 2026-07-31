Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723D3451BA;
	Fri, 31 Jul 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478459; cv=none; b=uFUFPJA734FgotfU1AOPmFoWu4Yd1Ky2yOe7mV+KDOQ2gYGq5jA80iSsk8JEZ+HiBM/MfMeBJ7k8I7yjiU8BD7PaJhllfc2ldC/uHxFKFgYvIWpq+wEEECMU2+f3nqQtsSS5J4C+AQxL0KrD2D1yxhnYGaeVLyfBJmQHd6Bk9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478459; c=relaxed/simple;
	bh=Uyo0MLtBDn7xB+YKtsnyF9jipI0kEMrrzKLmixh/FQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdsuSd9o1VE6E4nsubFXrJiHW3i1rmqN2JXYOBr67RabX0yX12/17aQS/Lk5YIpz1kNwhPwLanI3gvzC7KhBbIFyy5FrEvuq6wJHDAaor97WUQPUXvBzzoJkaKhqxFrDR2ixtKyTHETAqhtQZRwLJUmAxHS2ojY6Oza8MDV2smo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=szBZvxAj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="szBZvxAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478455; x=1786083255;
	i=markus.stockhausen@gmx.de;
	bh=cOR5wmd9dXP3K+KUFYDal2LEGL94knaBQNhrKMNJ7tg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=szBZvxAjgbJG0pMpIaNSU3MSa0G2aXS8QCWJEOfMGIK4PzB5Q5Ziot7FLpMC4Bfb
	 PfYXWTIgqkopFmnS4LjpZYp5sEalCKWBvybrU3yb892Cp77lJYPARn4ZBMsZo3rFg
	 aG9h5zKuB7KwFyPQCECwcnPiiCXzZWgfPA6Fz/RCyQO3tg8PWvsZibMq3tQ3oZSGG
	 f/ii7Ck/X3Vq88lKeoFiIW50hyZATQR0YGEq0nocIfvxPr4qaseHaw8APJVQbktDs
	 L90Rb6n1+Qc/SwZ0CknGrv2ooeDdDImBelyQhy2VHGF7XOvQJ9eGJqNF+Bcu+6kfd
	 RA5rQ6uYyuthikjbRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1wUqGx1Hjg-00JMIz; Fri, 31
 Jul 2026 08:14:15 +0200
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
Subject: [PATCH net-next v10 05/10] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Fri, 31 Jul 2026 08:13:55 +0200
Message-ID: <20260731061400.78301-6-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:SOWi6tqct9lKNvCwj5oQipfIjTsVWmi6Pj5223FqZfpELm2B9hc
 wGMSFSohHgtJUyj/+0vGrQEKu2znNkGOuHXbI0fTOCiNs/HnLR4kGr0DvA5NJ+TVeiQ+p5j
 kI9wVGPvRqREi55hDXcJAL7BoXQhs9JMCuvcyMcSU1nKZybabrle836WC/BeFY0/xkKatPr
 CaJnmb9WCdBhgz6ijMZaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t97h24x409A=;OJjR3FEd8t86xMB8IXYO990Lp/h
 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
 kEXBphHG/FzaM2Fw==

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
index 7dcfb72ed818..f1f15ad23dd3 100644
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
+		goto err_out;
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

