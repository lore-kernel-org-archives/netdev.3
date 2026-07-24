Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380F37FF46;
	Fri, 24 Jul 2026 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872607; cv=none; b=qcIf8t+HMmzRJObGwTK0eESefuv438YA4U0G/zv6fPmLcJ8UmQNB/OVG7zJCIRmgJGUs2ubOF6F2W3s9gmegsT9YkIiP+rTNLXEAAoJHuKyuK8MgfMeO5MoJCeVlnuysmzoMOz4FyqS/0Df+qGfb3wytcQW42tcEhHen4r4Jxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872607; c=relaxed/simple;
	bh=XDUfnIi9h6+xNF1o2LvPX2pkCxOHgYjlvAnqH97jLnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJqUATQ0ntdWbesWVd9XQWfx3A5u2pkcHfvBMY1WbrW8282v2X1n1tgPfRGjXToVwOWf3kR43EweGnFqtvPaU1Bvahju6jxBkjmp0fVWwHZAM83T2mk7m+Wr7kfvoR7+EvxEVGaYM2Hf3YVMiL6uE0bnBNt/X1oRIzDLTeRG+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=oDAkJnfO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="oDAkJnfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872586; x=1785477386;
	i=markus.stockhausen@gmx.de;
	bh=6SLwOW3wzNM3BFIevYG0UBzBy1iOcEGP6i24RUBJP3c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oDAkJnfOIUo7XV4GlDxbTwSyE5H5utu3OezUPsf9nT/y1D/qobyqZySOWUQYTG3O
	 54QR0ZcyvrQQ9SGrWNvTf/kwzIZ99AOr+sTVynynXDfAVeYDK4EbxzrwcWQrfX2gV
	 TWEIx764cf8hUHH/RZ8YTbhpwBxhT5rFmW5cOY/SVrfHNEEPME+n6aFeetYmvCATB
	 pfuatNdlgo/3h4a8ZrlMSRG7fHSrabnLsE3h/sIH0hkSSGdm8H3cDxIZ+zudCjQjy
	 dQtZowyv3Nj9TnSc0ehCCWZWhbWnN6l24QL/6zTfLMw8mYDDi/MQDUX3zN9MzKvCy
	 ryjelL1r5beBJspBzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1xDubn3svO-00ktEK; Fri, 24
 Jul 2026 07:56:26 +0200
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
Subject: [PATCH net-next v6 4/8] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Fri, 24 Jul 2026 07:56:07 +0200
Message-ID: <20260724055611.1008577-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
References: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NdqybAGJLD+vmGHLC8ZIL601mmhZybKQ38ou9D25PaFm+AnJFR6
 521Joj8sLP9B1RefkpWZwz72TkLUZXu9JPZCKhI3nC8vbQTM7iY9nApd41V0oXAsxjMMhl6
 GVR5ntiJ4647KtBZ4Qj6wLDcxPFbVy3MpGSDpkLQ+wQsJwcDVv0ZB5RetPbVw6aZ+Ztrgq5
 5p7jorbgqiKrHtY0ZLTFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pX1cnNwfc+8=;rYUO60Bo81aqI2b9d0T6iaqGOie
 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
 I0w

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
 drivers/net/mdio/mdio-realtek-rtl9300.c | 70 +++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 3dee5bff4134..4b70aaeb8c3b 100644
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
@@ -200,6 +202,7 @@ struct otto_emdio_priv {
 	const struct otto_emdio_info *info;
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
+	DECLARE_BITMAP(phy_poll, MAX_PORTS);
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
@@ -217,6 +220,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -252,6 +256,12 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
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
@@ -582,6 +592,44 @@ static int otto_emdio_9310_setup_controller(struct ot=
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
+	int ret;
+
+	if (port < 0)
+		return port;
+
+	scoped_guard(mutex, &priv->lock) {
+		ret =3D otto_emdio_set_port_polling(priv, port, true);
+		if (!ret)
+			__set_bit(port, priv->phy_poll);
+	}
+
+	return ret;
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
+	scoped_guard(mutex, &priv->lock) {
+		ret =3D otto_emdio_set_port_polling(priv, port, false);
+		if (!ret)
+			__clear_bit(port, priv->phy_poll);
+	}
+
+	if (ret)
+		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
+}
+
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
 				 struct fwnode_handle *node)
 {
@@ -611,6 +659,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -727,6 +778,19 @@ static int otto_emdio_map_ports(struct device *dev)
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
@@ -746,6 +810,10 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -786,6 +854,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -811,6 +880,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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

