Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B64B0491;
	Mon, 17 Aug 2026 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984016; cv=none; b=AoobXS0YcFRUYMHuME59PgnPMbgKK8gNm0q2Guu+VhyM1rYp4km6fsejwwRsh0aWSi7ZzHp6d8X7CuBL5LOQLklqmzppyszn6+u/YiZpsTvZ2UOqgfqWaFAYqLO2SsNZrUlJ4hiWasGeyyBLZf5W4Mi80+s+NKLh6z5+85Kann0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984016; c=relaxed/simple;
	bh=eXK8dmuhrtXoHD1lcxZI/l5n00xpyxUEx2mnTBmkOO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9KXiCqGzqtxEPZhioJYP4Mm1Nx0or9l+l6NWNwpuixbIsZSzK7HYn8fwMFYoXiAWgc9/AtQuAhFZk3FTb477qTIEPYbP7glRFjp1rS0xvWD47f1f78t7fDVsP0T5VNJ1YTEsdSK3/NHay6lXKKWtJTazqpVviPYL0X0pw8xiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=aEYLr4xF; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="aEYLr4xF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984011; x=1787588811;
	i=markus.stockhausen@gmx.de;
	bh=RDhlkI8FuGgLwIIqdi2BdGaK9L1rrTHsncuLwHFw05M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aEYLr4xFF/ee3oYcJZxdPBW+9vkE/zO9kuYBD1os9clKOz7eMMYNX7hj0qCA/Wa4
	 Bt+4SRH8fJhZ2RJyNuZcdXU1uDxd/yDwy4XSvHsQ2uh/G5SbIeL6cLE4NcUEi4fhR
	 koyBdWW56tpHT9nCWuZW77Qvo039JR1uXWxUcMYkAQy8NZVZ2UMGAxqU8gatagoba
	 ge46WV+PDNA/STzaoK9U0P9HxpumXIJhFmX+9w3TbX74X62UM4jQKTYJ/bdQBvtfb
	 D7s5tuLx6rn03ragbQ9ZRQVgqa9GoNpaeyz4Xo2JDwhhK1MFzTSdFkfR5ebnM+uOr
	 ouAXucDhTOnN6I6aaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1wMfUI15Yv-00hfnJ; Mon, 17
 Aug 2026 18:26:51 +0200
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
Subject: [PATCH net-next v14 07/13] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Mon, 17 Aug 2026 18:26:26 +0200
Message-ID: <20260817162632.1208891-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fzQmXrNu3IcTrVVFD6Pqwgw1Lip24/PfnL8JIyq9f4FMa1JOD2Z
 df0K3P6v4z/ePi4zPDtXb4MbUONlCQoME7xUIDoYbcXlPwB8IfNKHsdUjNypt82YjoYmTGR
 UYYrIaLnXugPI50ZQL6MAAgB+XEn4rEojRcHyjR9OUI7v9roUjt1LaegtUVm5ihErqYJ16r
 3sY6xZ+hDZsVcdtWl9IEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3ee301RVVnU=;glNXbicnSqhXdL0MNkGDMW31d2z
 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
 ZFf0yhiVwk=

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
index 3360cadfb7f3..456827879a62 100644
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
@@ -218,6 +220,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -253,6 +256,12 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
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
@@ -591,6 +600,36 @@ static int otto_emdio_9310_setup_controller(struct ot=
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
@@ -620,6 +659,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -736,6 +778,19 @@ static int otto_emdio_map_ports(struct device *dev)
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
@@ -755,6 +810,10 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -795,6 +854,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -820,6 +880,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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

