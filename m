Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABA420463;
	Mon,  3 Aug 2026 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777557; cv=none; b=cf+emVmQ88/m97fQfenrvnm9VNnktr3nzTE1Ys9+HhrgwOdnw7SWEoqkgJyD2r1FTmntRNZ9A11FNEoSv+a0s5gQdlBGZ+MyX8h52MG//hf3xaRSLawQSVi3XytlBVA2rUP1ilVhQkX/29bud1MKBZoDQbqA9remGG3OtLavYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777557; c=relaxed/simple;
	bh=lngXOmS9Bti1fOVNznoGBpSdP8OKGjskssfy/GGCzqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgFcd4qh7mV5r8HweYoBPtQJtHwvVAdwRGUyTvF8us5tF4V/9yBcQu3cQ9gYIzgQ14yNIjqekPZbNntTMJTc9IT7FJ7be+yHYQ84rgkQsq9ZR7AiL3C5oXdnZS33RjBIkaeTmAkd8R07KwYWMDTjQ3EmDAbnvSy1t6wY6hjokT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Jg38LbmH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Jg38LbmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777552; x=1786382352;
	i=markus.stockhausen@gmx.de;
	bh=ffv3kmC0SahmyIO9gzEtzSCeCZtMX/scC3o8BrrCmg0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Jg38LbmHnjkV3b0ZrNun/szOoef9BUA974z0SwDDtwiE97rrj7sTZ0SIDj96I7CL
	 2h5UH8p8PGOSiLdL53IMnzhOd9Wq7WV/ORDYzBYw0poRwB3c3/u0y9RbjdtxUQcWI
	 /l1pXLyvTeoTjpb3g356dNEqhELKrTouc29TjSUP3LSog1w5tSntye42Z/x2fh0W5
	 181YvYSI+Du44DSYEpuaCxbDH4JkAltptj+tPu7yHlBDXpg28z/clTaIqWkWX2YQv
	 XDB/Gu/wfLGEAJgniUrns4Q8+j+Gcx9A6ZKSKAV7quVNVzcsnwnQcnij7c3mtJ3L2
	 oW8+xBdmA4iDJBWnWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1ww0iB2y0J-016hxn; Mon, 03
 Aug 2026 19:19:12 +0200
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
Subject: [PATCH net-next v12 05/11] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Mon,  3 Aug 2026 19:18:47 +0200
Message-ID: <20260803171853.507506-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:26ThdSGoDRSLXNqXtntVt6qWYa1i12kDydcMJeZNbsW0NqjU4eB
 EhnwU4hG1uUkW/UgpVQI9Sk47GuflqO0cHLzkFASGOB89kDiqmoqKv8p42+pAAELG0d4J4F
 eFtE152KZBkdSAeI+Fq/uo5sFSx/kL69aAsklpG1PsZ+rMXKdYd+YnxCQRvVT49AS+2oDlD
 24dzmzD98MsMvkZhgav7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yKZerhhYTOM=;pK1mt6C4Dw2wjnbWK3qxFr2YWk8
 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

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
 drivers/net/mdio/mdio-realtek-rtl9300.c | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 1873928b362d..210e570c0973 100644
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
@@ -582,6 +591,33 @@ static int otto_emdio_9310_setup_controller(struct ot=
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
@@ -611,6 +647,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -727,6 +766,19 @@ static int otto_emdio_map_ports(struct device *dev)
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
@@ -746,6 +798,10 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -786,6 +842,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -811,6 +868,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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

