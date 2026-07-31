Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F2364EB0;
	Fri, 31 Jul 2026 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478478; cv=none; b=WkX3y1XuayAN7Z1I+I3sIRklpOL30VAyPpXqEgJsdmNdsmnbhIRRdftJM4YirYT7QPSxVtyctv9hIOB/cVeJu3BbfPoDbJhQnxM9/OV4wMPimiGF+M91KCbTDR+XgXwh6hwodEIi0l62cGr7kbGYHwkEj9KnAAXCMgiT4nqz7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478478; c=relaxed/simple;
	bh=41ZLh29ZpKO2636UcK40mBRirCRLh95qAI/7Z+umWsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgO3uuZMppmBQdaqr6t5CywVwDzJ3tYsoOCYYbyg9pdBbGWF55aJg3MJ1Pisu++SM3M2MrxnAjkZYz/8zMWoBNJhrYU+DUUrz9ynMIOAnwT4MlDyas/nq7+BUc/F3xtTwBvIYNIJIU2T982vdXZqjHzVkkHwXdxa/7lW6X/ojE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=aHfbYOZq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="aHfbYOZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478455; x=1786083255;
	i=markus.stockhausen@gmx.de;
	bh=Gox618FZ6nszoiYlWBdeIFQRcLKkWcqUDk+IDOSok/Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aHfbYOZq8u8OSHYHbD9zEcdAhbpnu4eQYj/IPtbBM41V97CC8vpjXagd07Ord+eE
	 KZGUbZCJ1IaZNSl+g/QfBUuCkyOryA5yZF+/6jjM5yKBDXdoa0QtjbqLaHFIIAB+8
	 CjJTXeq8q9VJUbEohKpsl63tb31d5d4YVYoTmsR0E9Edqi+eNHu9DqV5+GZDga/sm
	 ELTjOIvZzaf1E0qry2GDx7P34BfjIcLLkKMbnLY4j9iOKntib7V3A7zhO4hw/NAzu
	 jpV1yDuHHHoYBf/Kzu5/sR+0upavgyOquYCuQSmYpQ0c9V02PMAnz1OzInXwVwKnl
	 7y3tp1RApDPpJixrrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1wUWsW35EJ-00XMnu; Fri, 31
 Jul 2026 08:14:15 +0200
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
Subject: [PATCH net-next v10 06/10] net: mdio: realtek-rtl9300: Add page tracking
Date: Fri, 31 Jul 2026 08:13:56 +0200
Message-ID: <20260731061400.78301-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FDAFgtZ+hefulMkFb4rhFYFYbY6I8J/b6PloeLzr8WZklkjcaJQ
 lw8jj67XAKfz/DnNUeipbdYyRWoIhOXQjzRt6GdItuP4/whsQslRi1zc/jPWA3WZWDru4CY
 CVN2qGC31kVETMfARQu91MyMxPSR5O+CrJyjQOG9y0JCIHw2lLj1TqBRZg/OpygmNr5Amg5
 Hb8+cZHgWU6FRjTVN5VbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0PCI7PQXmjE=;x+1yxDnsZR41vevmFjYbISNqNjq
 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
 Tfm

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
 drivers/net/mdio/mdio-realtek-rtl9300.c | 42 ++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index f1f15ad23dd3..9663f644a313 100644
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
@@ -614,6 +638,10 @@ static void otto_emdio_notify_phy_detach(struct phy_d=
evice *phydev)
 	if (port < 0)
 		return;
=20
+	/* avoid wrong cached page for next attachment */
+	scoped_guard(mutex, &priv->lock)
+		priv->page[port] =3D 0;
+
 	ret =3D otto_emdio_set_port_polling(priv, port, false);
 	if (ret)
 		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
=2D-=20
2.55.0

