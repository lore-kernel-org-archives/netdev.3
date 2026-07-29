Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0DC4EA36F;
	Wed, 29 Jul 2026 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340994; cv=none; b=QR3QGqtSzReU8YFixmBQaOoSISFFrrQuMfzMLmhltODN6LktxbqUaLVPSGbqGPRyQ3Ijf00a2YenJWA4D3/tiYXBQNoeIV0ztZZBWH7MZeEx6ff2y0ksjuylDI1HicVwcZqfdUGyCfORfQB72xwm4OZhptRPz0Cmw9On00TK+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340994; c=relaxed/simple;
	bh=iA17tpja5uxYJ74NHHiCc+XWW00pj6uWOW7RXTctgIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJZmZmYq9lCgULpf7s2UNOAPqfqdkVqj0iCiw8gkIyoQ8iDna85lPO/wcsfyXFJhI5EXC8AvHON3fxMR77Vd7d9mnCrM4hxPPL1yv04ygnHBDJwluDAnfC/dQ3F8s1o3MqwogvNzH/VcFi8SfUHxA0cxGmaT2uW2OmeKN3dbdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=NpAv0jx3; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="NpAv0jx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340967; x=1785945767;
	i=markus.stockhausen@gmx.de;
	bh=njNoAImNTiKUlEEVgp1caqEcEErT7w31wOBKVIoE2R8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NpAv0jx3w3Ba2TzRJsIriP+f7rohqtTaoVGPx0+RwE6eBIhrP0rgjtiFU4zxvZwG
	 j1f1debMuV9S/VeHO2dXFJVfyyhNDaGiAV0kArku4xmxsxae6ybf5APUimqQg2TKT
	 5aGiJabrzcPJj2hxoqY7ZPvxMnKuL1FfXx4FaJ9UWpbjtrr+QL2ja3Yty5KBNdfrd
	 WtZBqkYsnRlOnEePHSpOHpoLw0Wb4+x3bjn6TeqD004Yog1XLmYOiwGEuA9KfG5ck
	 rpHtICmNyq2vEdF2HtgNOcgNYh3ImJKKRJcOICUgUvQ4xOsC2AQ1PFT1qubN3L4O9
	 bF+XOtqT/JrfJSaPUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK0R-1x7Bp81mOv-0124yw; Wed, 29
 Jul 2026 18:02:47 +0200
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
Date: Wed, 29 Jul 2026 18:02:23 +0200
Message-ID: <20260729160227.155613-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729160227.155613-1-markus.stockhausen@gmx.de>
References: <20260729160227.155613-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+t0oIZ5BWvX8q4XX6LExMnDGaRIyB5a7KCiYi5OZ6YWY3bFBdIJ
 c6beUibO/5S9fkKtxZ8vHN5DwLlfpAh68SBJOeWmc24OnjRK7NC/HlOqoAB+Thdldto0nIA
 3P/oKkN+cPu9a1Drx2kp17HQwCAG/Y+/qmvrpVFbMPfzUVpFfnA9/5umjCteyxsE1FRc20a
 20OAizjdjV2NvnmyxCsNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:llEFi09f+rg=;Q0zgdFE6ZoolhX6yXeo1zYMnosT
 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
 nO8K/x7UYqjviTTiAUFA/pHGpGVQ+eIQHFF44=

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

Realtek is very inconsistent about its register naming. RTL930x uses
SMI_POLL_CTRL for polling control while it is SMI_PORT_POLLING_CTRL
on RTL931x. Keep these vendor names.

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
index 3b99978a2511..aca0a9448bb0 100644
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

