Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151A4F054C;
	Mon, 31 Aug 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186924; cv=none; b=tXqLtNcT0ovfEB46W8B4GH/c3WEJLi2gDzD22PWXuINEDM3S0/btxdVtSS2qj/G1eDlqfyapXGSFL3+0L2KZUV4RqhoGIV1JJyp2wAbYs59PJ99yeGIeMS7HzXJ7HA+yPnvYxh1Q/AiHuvsAnEOUrX9GZ674PQM+r9SGcWD23m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186924; c=relaxed/simple;
	bh=alyT650qgjvHyCIbJVbL6I/qJ0Y//pC+mymKM/O8po8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QL70VZdv1tVjuspCTpoe8MuFNl/djUSQUT42UD7x5wDMSfv6vBROTyoAny2eS6PjacTID+7rZmVylAf6fI3tfHpg5iturI/xQFnWNBtrvF/BIznJrpqV8er9u7vsgKNeLowFzt641xEpnvCVmv5ckNGFU5GltyZDmc/x36VJZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=F4Y6qQIe; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="F4Y6qQIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186898; x=1788791698;
	i=markus.stockhausen@gmx.de;
	bh=aBWSGey0stV5njV69whAETzCYU+PnUIgehG9LtuA30I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F4Y6qQIewfv78UlXuWTd9eM7+UvcReTVMCzR+5J4jP9pz8t/FWKIdyshl8/jsrY4
	 evINIAaNCOjQEjlfCTVgDVnomIF7nY8Bf9ABbvJSugTXLpwBRHfqyn4c2OFa3j4MF
	 wNi74Xh78Gg4932AXHmpGmhHEZWwuoHoFK4WUHpq1Q0BqnULkL22pYC+AA06DPcRL
	 sj7iB5hn/JBHeeeXO18MrVSzHF4HcDU0wH3fsEm+BY4xd7oIVVhX4O/y4Dl3rSbSo
	 Lp4odKQWd+R6Bx0V4F9LGdniI/2oNNwxQWH2Y3z8VyXAdRbSZkQJDAXqsYjnx727k
	 D45pDOjdvzIEHEIbVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1xC5jG1auG-00EKLM; Mon, 31
 Aug 2026 16:34:58 +0200
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
Subject: [PATCH net-next v15 07/13] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Mon, 31 Aug 2026 16:34:33 +0200
Message-ID: <20260831143439.2404484-8-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:UKcV8Cf+AiQWo7KkGKqoGEHmqP1R3bnMblqgtVWRevgpYGozCcf
 l1kdLq2sSAdPzkkNI2/+b0CSRizlaIfdMAlD/P6G6sb9KcBHLlWq6QGISGEQC2cDFY3ig+K
 OYa8mxIEdetnUwP4FZe6jbHg5hKbyrzzMOyPdZYOO4kHFy6QOVNoqWq9IIpjP3M/PaJtgfU
 0DtobSSxvNhak0l7WKE6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DEAwSzfLTKs=;rQqGjYxxFKf/7cnQFZ6x6GO0RJp
 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
 ZVq3VH0fUCWlaY

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
index 7de8adec243b..a925640290cb 100644
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
@@ -596,6 +605,36 @@ static int otto_emdio_9310_setup_controller(struct ot=
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
@@ -625,6 +664,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -741,6 +783,19 @@ static int otto_emdio_map_ports(struct device *dev)
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
@@ -760,6 +815,10 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -800,6 +859,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -825,6 +885,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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

