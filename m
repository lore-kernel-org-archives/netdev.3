Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF5361DA9;
	Sun,  6 Sep 2026 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682806; cv=none; b=ElJ0TVfOi9akOcFBuLWRmZkoMuP4haGwLBZms08mMyAOnatJVyBHdNhozOhRiy42XC82zyblCjp6bPOBXFcQT3H2XmiI10ffLX2g8oByLckEkeWoZvT2UeFIL9AcaqXHIqFoSV5RwiK0zBWc30HP+6LbtSq8cVuAsnvVnI4P/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682806; c=relaxed/simple;
	bh=YNRQ38qxKsLhpvFpOoYGigeR6OjYvbHWo9/gIA91Q3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7P7a1vBEESnvhxP1eMSKNahGshnuLvUN9agWho4i+Vx+6sTAuj28EwbGBrj3Fl753pqwI58O/UaQuGQ9zu92GqvT41mPbvxu1ZdKwyAg/oJkFi+rMm0+cnNWdZ3T5DzRBAOuPHQ+E2kGoUU5/kg3bnJSEff1DZLwJWzEHMpccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=SbfRWH6t; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="SbfRWH6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788682802; x=1789287602;
	i=markus.stockhausen@gmx.de;
	bh=eNOQIWFK7o9YXs3xwahYSLNbECysU9jdBhlCBoWfx+E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SbfRWH6tfRFEVyTpeMDLcvww1aWXAIA20Y8LxVtVCPX463e4MiHT4xUfi5pWNfeT
	 qQxiIQQqd8WbgufT5Rp9cwBoVJJKMhVsgi/QhAzxC8M6IQDqWrgyiQ/rQbRBfXMjO
	 GXJXb+ncCgjydSqLg2zl5iwc07wFHKHTgT01AUYtevE5duh4IY+mnrvanOJ50M0YJ
	 6YTAb1dZaJ4WWs393+qyDp/rlYyQdyZj8GoOCg7hlBB4Mlg2VC6A9KQZWmRmvZoi0
	 9A+QQVKFTdURD2kMC1B+Dq7muwOFnYp0uTAfeRumBD5xhTjx4q58TjKRd3DUZ6OTU
	 hr54kJ8M2dmsNWtxBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1x0OHk15GY-001kct; Sun, 06
 Sep 2026 10:20:02 +0200
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
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 3/3] net: mdio: realtek-rtl9300: Support non-default clock frequency
Date: Sun,  6 Sep 2026 10:19:46 +0200
Message-ID: <20260906081946.3499898-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
References: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dXmb6h2koc+srYixdAHN2hUKjRrfamjuKL6M4nH4AvY/19a52px
 DgKBG+pCW5QLIzrmjNWmZBaOOncRoof6Pu3X0vZdi3+V5Penmt/sQo9oCLOjEhfSfTse83G
 M9v0wAXC1It7+NjkMjgGA/3C+UctQEDiFV4I/2uOBRccH46+wiCzNLkskMYe88uxSDVJnxN
 ta7lEwyiRMuo+EjrCAmvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nGh0YnEJGFU=;1Su2sW0VlVllbwRNNYiPNYVhvFP
 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
 I1QYxldyFCYP1Ob+AYyEzqvpLEUTTDr09vtcFk=

The ethernet MDIO controller of the Realtek Otto switches has a default
MDC clock frequency of 2.5MHz. Via configuration bits one can adapt this.
Depending on the series the following can be set

- RTL838x: 2.5 Mhz, 10 MHz
- RTL839x, RTL930x, RTL931x: 1.25 MHz, 2.5 MHz, 5 Mhz

Enhance the driver so it allows to set the clock frequency via device
tree. This helps to

- simplify protocol analysis with a logic analyzer (lower speeds)
- reduce MDIO access times during normal operation (higher speeds)

Note: While the devices normally support a per-bus frequency selection,
the RTL839x is an exception from that. It can only select the speed for
both buses globally. To avoid device tree special treatment for this,
use the per-bus speeds for this series too. Return an error if the
RTL839x Devicetree specifies different frequencies for the first and
second bus.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 81 ++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 429321e9114f..8edb0ba0bcdd 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -130,6 +130,7 @@
 #define RTL8380_NUM_PAGES			4096
 #define RTL8380_NUM_PORTS			28
 #define RTL8380_SMI_GLB_CTRL			0xa100
+#define   RTL8380_SMI_FREQ_SEL			BIT(1)
 #define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
 #define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
 #define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
@@ -169,12 +170,15 @@
 #define RTL8390_PHYREG_PORT_CTRL_LOW		0x03e4
 #define RTL8390_PHYREG_PORT_CTRL_HIGH		0x03e8
 #define RTL8390_SMI_PORT_POLLING_CTRL		0x03fc
+#define RTL8390_SMI_GLB_CTRL			0x03f8
+#define   RTL8390_SMI_FREQ_SEL			GENMASK(6, 5)
=20
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
 #define RTL9300_SMI_GLB_CTRL			0xca00
 #define   RTL9300_GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
+#define   RTL9300_SMI_FREQ_SEL(intf)		GENMASK((intf) * 2 + 9, (intf) * 2 =
+ 8)
 #define RTL9300_SMI_PORT0_15_POLLING_SEL	0xca08
 #define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
 #define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
@@ -196,6 +200,8 @@
 #define RTL9310_NUM_BUSES			4
 #define RTL9310_NUM_PAGES			8192
 #define RTL9310_NUM_PORTS			56
+#define RTL9310_SMI_GLB_CTRL0			0x0cc0
+#define   RTL9310_SMI_FREQ_SEL(intf)		GENMASK((intf) * 2 + 5, (intf) * 2 =
+ 4)
 #define RTL9310_SMI_GLB_CTRL1			0x0cbc
 #define   RTL9310_SMI_GLB_FMT_SEL_C45(intf)	BIT((intf) * 2 + 1)
 #define RTL9310_SMI_INDRT_ACCESS_CTRL_0		0x0c00
@@ -251,6 +257,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u32 global_freq;
 	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
@@ -269,6 +276,7 @@ struct otto_emdio_info {
 	u8 num_ports;
 	u16 num_pages;
 	u32 poll_ctrl;
+	int (*set_bus_frequency)(struct mii_bus *bus, u32 freq);
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -740,6 +748,17 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+
+	if (freq !=3D 2500000 && freq !=3D 10000000)
+		return -EINVAL;
+
+	return regmap_assign_bits(priv->regmap, RTL8380_SMI_GLB_CTRL,
+				  RTL8380_SMI_FREQ_SEL, freq =3D=3D 10000000);
+}
+
 static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
 {
 	/*
@@ -749,6 +768,40 @@ static int otto_emdio_8380_setup_controller(struct ot=
to_emdio_priv *priv)
 	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
 }
=20
+static int otto_emdio_8390_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	u32 val;
+	int err;
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+	if (priv->global_freq)
+		return freq =3D=3D priv->global_freq ? 0 : -EINVAL;
+
+	val =3D FIELD_PREP(RTL8390_SMI_FREQ_SEL, freq / 2500000);
+	err =3D regmap_update_bits(priv->regmap, RTL8390_SMI_GLB_CTRL, RTL8390_S=
MI_FREQ_SEL, val);
+	if (!err)
+		priv->global_freq =3D freq;
+
+	return err;
+}
+
+static int otto_emdio_9300_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_chan *chan =3D bus->priv;
+	u32 mask, val;
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+
+	mask =3D RTL9300_SMI_FREQ_SEL(chan->mdio_bus);
+	val =3D field_prep(mask, freq / 2500000);
+
+	return regmap_update_bits(priv->regmap, RTL9300_SMI_GLB_CTRL, mask, val)=
;
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -769,6 +822,21 @@ static int otto_emdio_9300_setup_controller(struct ot=
to_emdio_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_9310_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_chan *chan =3D bus->priv;
+	u32 mask, val;
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+
+	mask =3D RTL9310_SMI_FREQ_SEL(chan->mdio_bus);
+	val =3D field_prep(mask, freq / 2500000);
+
+	return regmap_update_bits(priv->regmap, RTL9310_SMI_GLB_CTRL0, mask, val=
);
+}
+
 static int otto_emdio_9310_setup_controller(struct otto_emdio_priv *priv)
 {
 	int i, err;
@@ -835,7 +903,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 {
 	struct otto_emdio_chan *chan;
 	struct mii_bus *bus;
-	u32 mdio_bus;
+	u32 mdio_bus, freq;
 	int err;
=20
 	err =3D of_property_read_u32(node, "reg", &mdio_bus);
@@ -865,6 +933,13 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
+	if (of_property_read_u32(node, "clock-frequency", &freq))
+		freq =3D 2500000;
+	err =3D priv->info->set_bus_frequency(bus, freq);
+	if (err)
+		return dev_err_probe(dev, err, "cannot set frequency %u for MDIO bus %d=
\n",
+				     freq, mdio_bus);
+
 	err =3D devm_of_mdiobus_register(dev, bus, node);
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
@@ -1051,6 +1126,7 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.num_pages =3D RTL8380_NUM_PAGES,
 	.num_ports =3D RTL8380_NUM_PORTS,
 	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_8380_set_bus_frequency,
 	.setup_controller =3D otto_emdio_8380_setup_controller,
 	.read_c22 =3D otto_emdio_8380_read_c22,
 	.read_c45 =3D otto_emdio_8380_read_c45,
@@ -1075,6 +1151,7 @@ static const struct otto_emdio_info otto_emdio_8390_=
info =3D {
 	.num_pages =3D RTL8390_NUM_PAGES,
 	.num_ports =3D RTL8390_NUM_PORTS,
 	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.set_bus_frequency =3D otto_emdio_8390_set_bus_frequency,
 	.read_c22 =3D otto_emdio_8390_read_c22,
 	.read_c45 =3D otto_emdio_8390_read_c45,
 	.write_c22 =3D otto_emdio_8390_write_c22,
@@ -1097,6 +1174,7 @@ static const struct otto_emdio_info otto_emdio_9300_=
info =3D {
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
 	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_9300_set_bus_frequency,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -1123,6 +1201,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
info =3D {
 	.num_pages =3D RTL9310_NUM_PAGES,
 	.num_ports =3D RTL9310_NUM_PORTS,
 	.poll_ctrl =3D RTL9310_SMI_PORT_POLLING_CTRL,
+	.set_bus_frequency =3D otto_emdio_9310_set_bus_frequency,
 	.setup_controller =3D otto_emdio_9310_setup_controller,
 	.read_c22 =3D otto_emdio_9310_read_c22,
 	.read_c45 =3D otto_emdio_9310_read_c45,
=2D-=20
2.55.0

