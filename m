Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304045C6F7;
	Wed, 29 Jul 2026 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341005; cv=none; b=uwyu20LUSJtRU7QIxiyKHqQWiZ7HEXGIPi8/faD0ptw43Ddzx9vLvQa2dfQ4dHTHPUVc565A5WOtS4ANpdUUKEZHBcfzhzrjDpwmaaCEJuHybhmZ+pYltkRghm/9BwkHrwQmzPHy8TX7MrlGJKR1FTl3RWTqbRiT3XK6k9p3zDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341005; c=relaxed/simple;
	bh=tr3zosLqy5AEyBjKKmwI8S9X4u4c0EWZkPV8IRq5Tbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmztbGTAMNqkHb1CnGms000nligaV6bZXpJLJTWOsnfiFgciDMmBG06OhClAM+eGZITcLSWtGGyaqrHc25ClFeQrCqVhmc8qKHtyvvDlry0zbT/18zrRzOHf+08jkX8PKUxvaCnMOQt2RXW5a4OnhdW3bVeifVE5+P7jFVk39L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LOZMAME/; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="LOZMAME/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340968; x=1785945768;
	i=markus.stockhausen@gmx.de;
	bh=+5RtAuqLgOz3LQXYbKeaq4yBuCMSanrAHF9AV10czq0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LOZMAME/AQQ7djW1ZzTtaXX/q70IPPlhP7nvy0MLUczUZKSNcPbg1UlTUaXioi6v
	 UaTewmWiUbU011tLFCCCUyu4+g25RFTMQnpi4wMlpbFC3/Pu2hO6j3sXF9Cicgewa
	 3NJQyqWRrYesa5dbkv4Ae4d2Kemr7/zeJd1bPYsZCrlF2dtTbivNN4GeVYpQngKZ4
	 pfLDsPIjkJq4RTjtBjcoOynNndaD5ho5/BfOyXAu4xAd8THttFy9j+4Iny41N7viA
	 nJydf92h7o6/Dfv0iVL2h3GI1+mqoM3nsKFAxgzqcMURZiiP27O6sRDk2s01pP6+1
	 rUwtqFxFii0Uwqfb8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1wVvzq0OrO-00SC0D; Wed, 29
 Jul 2026 18:02:48 +0200
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
Subject: [PATCH net-next v8 6/9] net: mdio: realtek-rtl9300: Add page tracking
Date: Wed, 29 Jul 2026 18:02:24 +0200
Message-ID: <20260729160227.155613-7-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:VneAPVrRnacFN1R8ZzFy1qmXWoYRFwXgzZaWA5BpJW5i9zb3tfJ
 ZS7NTj8o6uMRexwv+Dv4oCOfgoiEcd74AxtwPscs7hzAibsT2MY0A9+EM6aPjsCUTMp/TcZ
 FDUE38UuvmFIff5OheIo0EzxyNX8WzuoRd254dVNZnIC0lm4hU8xwHupNsvHou5Ofr9pF6F
 cjBV4+gRZUcIyS6JM5Q+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kdy1cx4gdAs=;k5tkj+G4Va5Qy3DrWZeqvCz+EoB
 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
 4y5

The hardware polling unit of the Realtek switches has a very special
handling for c22 PHY register 31 (aka Realtek page register) in place.

- On the RTL838x it is permanently reset to zero.
- On other devices there is some magic saving/restoring (aka parking)
  in the background in place.

This makes access to PHYs a gamble.

It is vital to keep the polling alive so the MAC layer can rely on
consistent data. Intercept access to c22 register 31 and handle it
internally. Store the desired value for each port in the driver. When
issuing hardware access to other registers add the page to the command
towards the controller. Given this, the hardware will run two c22
commands that are not interrupted by polling.

  ... hardware poll ...
  phy_write(phy, 31, page)
  phy_write(phy, reg, value)
  ... hardware poll ...

Looking at this implementation one might argue that disabling/enabling
polling might be a cleaner solution. But one must remember that

- This driver differentiates clearly between C22 and C45 buses. During
  probing it enables only one of the protocols for a bus.
- All known devices run RTL8218 (B/D/E) or RTL8214FC on 1G
- RTL839x gives link flapping when deactivating polling for a port

So a solution for a Realtek-only ecosystem is required. This commit
copies the downstream-proven driver-only page handling patch without
any new MDIO callbacks and is the lowest common denominator. If a
non-Realtek PHY is identified on a c22 bus the attachment aborts. It
should be noted that bus scan runs with the page handling already in
place before the check in notify_phy_attach(). This delay is accepted
for not-yet-known hardware designs with non-Realtek c22 PHYs.

Remark! To keep this simple, writes to register 31 are only accepted if
they are lower than the device specific raw page - 0..4094/8190.
Otherwise -EINVAL is returned. Under the above assumption (Only 1G
Realtek PHYs on c22 bus) this is no limitation.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 43 +++++++++++++++++++++----
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index aca0a9448bb0..dc3661b2cd94 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -179,6 +179,9 @@
 #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
=20
+#define RTL_VENDOR_ID				0x001cc800
+#define RTL_PAGE_SELECT				31
+
 #define MAP_ADDRS_PER_REG			6
 #define MAP_BITS_PER_ADDR			5
 #define MAP_BITS_PER_BUS			2
@@ -205,6 +208,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -356,7 +360,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -370,7 +374,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -410,7 +414,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -422,7 +426,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -468,8 +472,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
nt phy_id, int regnum)
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D RTL_PAGE_SELECT)
+			return priv->page[port];
+
 		ret =3D priv->info->read_c22(bus, port, regnum, &value);
+	}
=20
 	return ret ? ret : value;
 }
@@ -483,8 +491,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D RTL_PAGE_SELECT) {
+			if (value >=3D RAW_PAGE(priv))
+				return -EINVAL;
+
+			priv->page[port] =3D value;
+			return 0;
+		}
+
 		ret =3D priv->info->write_c22(bus, port, regnum, value);
+	}
=20
 	return ret;
 }
@@ -595,12 +612,19 @@ static int otto_emdio_9310_setup_controller(struct o=
tto_emdio_priv *priv)
=20
 static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
 {
-	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
 	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct otto_emdio_chan *chan =3D phydev->mdio.bus->priv;
+	struct otto_emdio_priv *priv =3D chan->priv;
=20
 	if (port < 0)
 		return port;
=20
+	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
+	    !phy_id_compare_vendor(phydev->phy_id, RTL_VENDOR_ID)) {
+		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
+		return -EOPNOTSUPP;
+	}
+
 	return otto_emdio_set_port_polling(priv, port, true);
 }
=20
@@ -608,12 +632,17 @@ static void otto_emdio_notify_phy_detach(struct phy_=
device *phydev)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
 	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct otto_emdio_chan *chan =3D phydev->mdio.bus->priv;
 	struct mii_bus *bus =3D phydev->mdio.bus;
 	int ret;
=20
 	if (port < 0)
 		return;
=20
+	/* avoid wrong cached page for next attachment */
+	if (!priv->smi_bus_is_c45[chan->mdio_bus])
+		priv->page[port] =3D 0;
+
 	ret =3D otto_emdio_set_port_polling(priv, port, false);
 	if (ret)
 		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
=2D-=20
2.55.0

