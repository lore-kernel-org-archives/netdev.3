Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093333F5B8;
	Wed, 22 Jul 2026 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701468; cv=none; b=aGGUITxS7pFXfnrwA1LSYJ0FOU6fv8Ez8YyfnrJRgRz0IBLV6XuAkHNqJZH9CkpeabIPZz17MscKCJyuSs61c24QeJJC3COl9Z8aX9Xsgay8rxjkyPKFwbhvN36JfHl0t4mxmTni2JuKETs6EIU+NwiQMcfCbnR8VEXVr0NT+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701468; c=relaxed/simple;
	bh=AkcGjbJaX2sNakemoCIOhUNajJq4XqsuvF3gNoc9Cmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsPgLn6VOY6FadS8Nk/w4XnlmYcPB9/Nlvts8osqnKULbX9nEN4+cjbMQF0fGPuSm2TSWYHD3l2muXgjWe98L+QPziwDjzstvagTbabH5aELd4sW5Wu4XcKSUn0DCHUfBin7aA9o1amboUtQfHQYXcnF5NI5I57Xj8q9i9qFH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=uK2mir2K; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="uK2mir2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701448; x=1785306248;
	i=markus.stockhausen@gmx.de;
	bh=qNcRYkPYEFMtrvXsxqJFowKuTSeE3OXsj1FwiJ/ZOnU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uK2mir2KorUFUhwl3y/Tc4YgPQdSuwYBupwii5VWr8m2cPKO+QC59AwESwzEEXxi
	 kupwEgg4KlDyq/Zv8rzvtsqXPJ+3m46ex1AkHH1Jb9v2fyZ/Is3PoUfevEoL96AUA
	 CNcDeUEYqMZ7wjCzgmLQaoKolU2NRZT8gMYA2vGHvP7V1UhDGBuy1iN1mYZF4Hviz
	 OP/6k43g1JH/MkXUBwBzQjgfQ8YHc/r8EZx6hqlyKB/V91LGGbkxsVWTRcFIv+KQC
	 HBxos8CRXoN9U02eJgAcfCWFYcP1/iV8TaOM0CUiPaGIvc2Aod74/Ilfpr0oj87Pn
	 iCpEjOkBosquxCAKZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1xBXff3GuZ-00xODd; Wed, 22
 Jul 2026 08:24:08 +0200
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
Subject: [PATCH net-next v5 4/8] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Wed, 22 Jul 2026 08:23:52 +0200
Message-ID: <20260722062356.12291-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722062356.12291-1-markus.stockhausen@gmx.de>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RDRLsZ1WCls0DMm2K2GatUWKIuesUhLPv6CBMkqdjt7m6RT+Xw7
 ZuUZThOYmXDx08PuBPx8F5s9BHJ48C7UbTaq0FvZj4VT7zd92CLkFTUgNDi+cXNYd5NNSvK
 1tIBW1gUubqCUGpxHde6HkupaFF9oE34yIbW2qKPpedsciqJyL5DWdtda00eI/9Ea3VgKpm
 vJwicAEVvpGdyTBEJAfog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7qt9IJmKxtc=;OkKAdw91+semdE5Q3pXoUqudQaS
 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
 0RY

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
 drivers/net/mdio/mdio-realtek-rtl9300.c | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 8269ec5c92c4..2a364ed46902 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -138,6 +138,7 @@
 #define   RTL9300_PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   RTL9300_PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTL9300_SMI_POLL_CTRL			0xca90
 #define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
 #define RTL9310_NUM_BUSES			4
@@ -163,6 +164,7 @@
 #define   RTL9310_PHY_CTRL_INDATA		GENMASK(15, 0)
 #define RTL9310_SMI_INDRT_ACCESS_MMD_CTRL	0x0c18
 #define RTL9310_SMI_PORT_ADDR_CTRL		0x0c74
+#define RTL9310_SMI_PORT_POLLING_CTRL		0x0ccc
 #define RTL9310_SMI_PORT_POLLING_SEL		0x0c9c
=20
 #define PHY_CTRL_CMD				BIT(0)
@@ -193,6 +195,7 @@ struct otto_emdio_priv {
 	const struct otto_emdio_info *info;
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
+	DECLARE_BITMAP(phy_poll, MAX_PORTS);
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
@@ -210,6 +213,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -245,6 +249,14 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
(struct mii_bus *bus)
 	return chan->priv;
 }
=20
+static int otto_emdio_set_port_polling(struct otto_emdio_priv *priv, int =
port, bool active)
+{
+	lockdep_assert_held(&priv->lock);
+
+	return regmap_assign_bits(priv->regmap, priv->info->poll_ctrl + (port / =
32) * 4,
+				  BIT(port % 32), active);
+}
+
 static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
 			      struct otto_emdio_cmd_regs *cmd_data)
 {
@@ -575,6 +587,47 @@ static int otto_emdio_9310_setup_controller(struct ot=
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
+		if (test_bit(port, priv->phy_poll))
+			return 0;
+
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
@@ -604,6 +657,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -720,6 +776,21 @@ static int otto_emdio_map_ports(struct device *dev)
 	return err;
 }
=20
+static int otto_emdio_init_polling(struct otto_emdio_priv *priv)
+{
+	int err;
+
+	for (int port =3D 0; port < priv->info->num_ports; port++) {
+		scoped_guard(mutex, &priv->lock) {
+			err =3D otto_emdio_set_port_polling(priv, port, false);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int otto_emdio_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -739,6 +810,10 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -779,6 +854,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -804,6 +880,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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

