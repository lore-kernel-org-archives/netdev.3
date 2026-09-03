Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1993A9DB6;
	Thu,  3 Sep 2026 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438122; cv=none; b=OE8z8N/tuEnj1dDZ0DMSpL61vnGKOjB3I8mUVFtr0aWrAVxfc1JHevCXX3+rw4MvAmWAL+2Y04zPxwrVZZuzTpKIp8iWRm4E51Gcrn5hD33KFoXRd5Q/KksIH4RLjafWlUygVHpcvKku6AdlPOCSUve2EsS6fAARwaMjxN6QXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438122; c=relaxed/simple;
	bh=7Ajgoy8O8X6MXD9YoEN/YcbGF4D/QsArkevbJwb5hmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gq4Vd0Hmu1wfnm7WY818TrI688erglVuHQcHEoEBKWzkAbYQJ0sFcwTgXuCBYDIzez0ljnxxYh5fhP9Jte6wFwRKAk0JyqmEtKEu7KZlzkc6Hq0GjafXRBMrgx6zA7VsIr0BLy53uIrC0Okv+Ga0p1sNPk4JD9Ty1a6eymT7ELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=MtEDhUHV; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="MtEDhUHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788438095; x=1789042895;
	i=markus.stockhausen@gmx.de;
	bh=gXZEfonw0a7Zy5ZyXmm8DvT2ky6qE/zuEBzfD/ihCC0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MtEDhUHVSgxviI1iKcFMojOf+Yyq2zVa7c04JoBBEp3zBH5QYqymLmKgcl8J0i7H
	 IDCae/QAwM9tsHuUGzNbAU5ZBKMfD8gBVf2owwKEhtw2lmSmKGM2WhQa6BQeg/XaL
	 O0OkbsPoHYLVqIaeLQXn9JR4JaJBqROQxdO8D2VYkm6Q5B4b0K3wjLY5U/WoL4LMy
	 wIknBoat0LNzjlR9Zoxa9mcZaiL6HK932wUd/ZINFcW6hfgYCoHyzFoOd6AvR57oE
	 sy7TYM9SZesvTq885WXHQl9cdRuHLthmKvrzX/jIe9JZ7BOyWdZfYJeFDKdHZkI1s
	 nrGGoxOpq946/j6/7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1wNq520frb-00gVYc; Thu, 03
 Sep 2026 14:21:35 +0200
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
Subject: [PATCH net-next 3/3] net: mdio: realtek-rtl9300: Support non-default clock frequency
Date: Thu,  3 Sep 2026 14:21:19 +0200
Message-ID: <20260903122119.2638354-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
References: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A9WVYMR0a0J2LlblYok4uho6LP4Me7RvY58D5L43EaDh1ibkwWg
 jyMOWblBve8i4Izf/FQb66XXwyIeJsfV8Lwl0vx+IifczQ40YrJqQpc1wbTrqRICI0vqrLo
 bEE3K1nTr/1IV5Vo1PbNtY19WZF7osKew44CZB/T7/U0fDQs6DTOz6h98or4nPuI2Hbnq1R
 5ytEUJ53eVqGpENBLf9QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6aqmOlmuf6M=;JgUHj19b1UILjPBEP7rRuMaDHAs
 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
 UE=

The ethernet MDIO controller of the Realtek Otto switches has a default
MDC clock frequency of 2.5MHz. Via configuration bits one can adapt this.
Depending on the series the following can be set

- RTL838x: 2.5Mhz, 10MHz
- RTL839x, RTL930x, RTL931x: 1.25MHz, 2.5MHz, 5Mhz

Enhance the driver so it allows to set the clock frequency via device
tree. This helps to

- simplify protocol analysis with a logic analyzer (lower speeds)
- reduce MDIO access times during normal operation (higher speeds)

Remark! While the devices normally support a per-bus frequency selection,
the RTL839x is an exception from that. It can only select the speed for
both buses globally. To avoid device tree special treatment for this,
use the per-bus speeds for this series too. The driver sets the global
speed according to the first probed bus and will issue warnings if the
second probed bus wants to change that.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 69 ++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 429321e9114f..4af281b924ad 100644
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
@@ -740,6 +748,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+
+	return regmap_assign_bits(priv->regmap, RTL8380_SMI_GLB_CTRL,
+					 RTL8380_SMI_FREQ_SEL,
+					 freq >=3D 10000000);
+}
+
 static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
 {
 	/*
@@ -749,6 +766,34 @@ static int otto_emdio_8380_setup_controller(struct ot=
to_emdio_priv *priv)
 	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
 }
=20
+static int otto_emdio_8390_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	u32 val =3D FIELD_PREP(RTL8390_SMI_FREQ_SEL, min_t(u32, freq / 2500000, =
2U));
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+
+	if (priv->global_freq) {
+		/* With only one global frequency available skip setup for second bus. =
*/
+		if (freq !=3D priv->global_freq)
+			dev_warn(&bus->dev, "Only one frequency for all buses supported");
+		return 0;
+	}
+	priv->global_freq =3D freq;
+
+	return regmap_update_bits(priv->regmap, RTL8390_SMI_GLB_CTRL, RTL8390_SM=
I_FREQ_SEL, val);
+}
+
+static int otto_emdio_9300_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_chan *chan =3D bus->priv;
+	u32 mask, val;
+
+	mask =3D RTL9300_SMI_FREQ_SEL(chan->mdio_bus);
+	val =3D field_prep(mask, min_t(u32, freq / 2500000, 2U));
+
+	return regmap_update_bits(priv->regmap, RTL9300_SMI_GLB_CTRL, mask, val)=
;
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -769,6 +814,18 @@ static int otto_emdio_9300_setup_controller(struct ot=
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
+	mask =3D RTL9310_SMI_FREQ_SEL(chan->mdio_bus);
+	val =3D field_prep(mask, min_t(u32, freq / 2500000, 2U));
+
+	return regmap_update_bits(priv->regmap, RTL9310_SMI_GLB_CTRL0, mask, val=
);
+}
+
 static int otto_emdio_9310_setup_controller(struct otto_emdio_priv *priv)
 {
 	int i, err;
@@ -835,7 +892,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 {
 	struct otto_emdio_chan *chan;
 	struct mii_bus *bus;
-	u32 mdio_bus;
+	u32 mdio_bus, freq;
 	int err;
=20
 	err =3D of_property_read_u32(node, "reg", &mdio_bus);
@@ -865,6 +922,12 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
+	if (of_property_read_u32(node, "clock-frequency", &freq))
+		freq =3D 2500000;
+	err =3D priv->info->set_bus_frequency(bus, freq);
+	if (err)
+		return dev_err_probe(dev, err, "cannot set frequency for MDIO bus %d\n"=
, mdio_bus);
+
 	err =3D devm_of_mdiobus_register(dev, bus, node);
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
@@ -1051,6 +1114,7 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.num_pages =3D RTL8380_NUM_PAGES,
 	.num_ports =3D RTL8380_NUM_PORTS,
 	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_8380_set_bus_frequency,
 	.setup_controller =3D otto_emdio_8380_setup_controller,
 	.read_c22 =3D otto_emdio_8380_read_c22,
 	.read_c45 =3D otto_emdio_8380_read_c45,
@@ -1075,6 +1139,7 @@ static const struct otto_emdio_info otto_emdio_8390_=
info =3D {
 	.num_pages =3D RTL8390_NUM_PAGES,
 	.num_ports =3D RTL8390_NUM_PORTS,
 	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.set_bus_frequency =3D otto_emdio_8390_set_bus_frequency,
 	.read_c22 =3D otto_emdio_8390_read_c22,
 	.read_c45 =3D otto_emdio_8390_read_c45,
 	.write_c22 =3D otto_emdio_8390_write_c22,
@@ -1097,6 +1162,7 @@ static const struct otto_emdio_info otto_emdio_9300_=
info =3D {
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
 	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_9300_set_bus_frequency,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -1123,6 +1189,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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

