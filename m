Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB231E820;
	Sun, 26 Jul 2026 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050297; cv=none; b=tgOGZ2vteqP/+fbmSxcXC6v7Wc83ikOn9qcZyflxfjVMxbR9c5THp1PHc5xw2eYJfuOdQMa4BoQbatqEsmYj2gC/y0EqXQ/C+z0Et6z1bUCc7U5aybIVaaikksBXq3NQ/Rzi5nzToO+NC2dH675U77eeMCrBWJqbiK2pdJsXfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050297; c=relaxed/simple;
	bh=OUaYfgw02lZWPXCt6CxXYrgLwfES3QDoHUSqcbtmyUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBdyADtMolN1ezpaUHtdV8T8KSOPqAurjRmvxRHyHaptGBsXZF7Ro1W30GKnrvoRYvCziHNDmkp4tPfS8VzHNwijjeMxKHsh11ZuRa6zkhhDB6SAmoqnYa8xAVrL2NJfaYJAth1mZ4fXpG4xVh72sFmL72P30B0zjj9xV5AcnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LMmV2Lzb; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="LMmV2Lzb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050288; x=1785655088;
	i=markus.stockhausen@gmx.de;
	bh=iMlohu9d71BMLvFAuv9aWuuGzS/S6WJK2GFZ21EX3Ro=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LMmV2Lzbe0ey19J53iRU+OmJ8Nbe9mlzfjV3DGpPjcgas13gig0j+ch3gU+j2XIz
	 FlyiRc+vGmXrYMhK2r5uBXNRXkGQjEwMsWlScDqqm1IC2uKf+R9azpt9dGcgOgCG0
	 P9NfqLuSUXR/IIstRQFSjx20iD+RrZixO/qKe/1GJ7ZKTUm7Qro4On8Y9VKDQfq4J
	 apbN6Pe/j3q9j7iimXw0+Thk8a4c8fX/LTCdQUTSgxRvbMGrY6xfll2iPeL3glCLu
	 w2+0MVoi4jdluqSeGQHEAJST9i6u7X0aUbiy9Bx8GXQzNzvtXZRfLx/ib4qe68apT
	 DdagV8FCPrqvyc+Frg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1wibv53DTL-000bgX; Sun, 26
 Jul 2026 09:18:08 +0200
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
Subject: [PATCH net-next v7 4/8] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Sun, 26 Jul 2026 09:17:47 +0200
Message-ID: <20260726071751.1359156-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
References: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HYa5ZgpcqUL9ECc9tFW+CB4w+i+xI+OXh9cOx6aOwH7JlDGHJi/
 XHQaZJALLWiAz4tKDHXBX6OiZW3wPTh+nuMnLR7+O9U25xnlY41ddM5MXjpQwJga82sf0nk
 d+ELixDwxHMYmeZhyk3OVOx6mpvrrRv9Q1bFmtwKczUfGVbnz44Wj2VFJq9e2mm2M3NTxo/
 wOQU6ye9Rds59ZfkB07kQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sO/+3fZqR7c=;a33rmSfMTHsgZhUKFYw5q8KAPDp
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
index 3dee5bff4134..c607dad9f0a3 100644
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
@@ -582,6 +591,32 @@ static int otto_emdio_9310_setup_controller(struct ot=
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
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
 				 struct fwnode_handle *node)
 {
@@ -611,6 +646,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -727,6 +765,19 @@ static int otto_emdio_map_ports(struct device *dev)
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
@@ -746,6 +797,10 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -786,6 +841,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -811,6 +867,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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

