Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3483390234;
	Sun,  2 Aug 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659760; cv=none; b=FuAne7s5dnjV+haRYGCn/Qs4/CLAnGIK3PfOkJeFgrRKI1KWmJtLkCYh1Er5+x3GfvEa+YbFHFxR3b6oWpYdPHA7ANENJ+79szwdKQrVZgS8bHX3HfODFU67tub/mbmAElQi+9QaAVccA1ihOHEj4lGDy1pkk24aE5FGlmyixDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659760; c=relaxed/simple;
	bh=FA7np9L7XmtYB6WcIII5aqURUmzfBOOg0Byttzm07uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAzkctHfjHB2ioRcFJmk4kMMgKdeENjh7n7tyimlE0PibypOd+fbnho0/E74V9Vs2s4Qr7/gpYWUpgj7ZyvlonTKPRAWlhQUOb53RWsczxL8xTlXxvd7nDDtQhcCW28HbMmNu+cvXGKjh1JhVRbcN74pn9LVbzvQipbYj6oFT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=aaAsmob6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="aaAsmob6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659746; x=1786264546;
	i=markus.stockhausen@gmx.de;
	bh=AXOuIupmZe+SioIL5hdg1XGichCmQcTBEHMsKzImA6A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aaAsmob6r5xFUiShPdPdSsiSxFYVUjppqSr6VqaCbhTjlG5Gy7RxOP52CbnZr5hg
	 T7g2j1Uz+6/yIaZBn0DPxNYzAHQdyRN3/vBtIOdP5xZXcj6gLR/4MYBJKRP8rL7q+
	 iyHegMxXDgHqOaZAxNdDxEY9RRarqPg8cyAvpZIinL/FalvrVHB/07KN0wahbIsX3
	 ShnoMEbyftFphCY3Mz5Z8FV9pEsmd/bsiVRkJq/kZ/zsLhCY9ZX7AB0DPJ3yeLeci
	 tDkBW7rFNsfXVrQk0r7ObeXmM+sP6eoMHgS2BsQoW4JhA9UHBrHIAf0SVVSpCQJ7Y
	 OEcNPvH9MumSLxx7Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7iCg-1x3M361Ki2-016P8P; Sun, 02
 Aug 2026 10:35:46 +0200
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
Subject: [PATCH net-next v11 07/10] net: mdio: realtek-rtl9300: Add page tracking
Date: Sun,  2 Aug 2026 10:35:25 +0200
Message-ID: <20260802083528.490216-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+hhp0WXN14Uy/OJ+wNO5GDp1Jakvqqk904zqi6IWnzXw6ERUvT6
 WeUIdqjM53w3Cra88eZamswedh39QWFaRZO8TQYL0ACZelo5/ELTSIkjz6hT3t+msZDWqxz
 7ht4NB7iCw0wXC1t5AqeJVZWX2wA65VhPfVupjpYw7fDNp93FNf1/sKZYHHf701voG1otW3
 bobPWIoY4HTLhEHHkA63Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9cOMbx1GKhA=;/YaCS5ZTN05AhU3lCDBMJxkKxfn
 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
 JpfHp1p7/zvLBNwQwMOaqvpUsqaBLpBaV6LzU=

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
place before the check in notify_phy_attach(). This is accepted for
now.

Remark: To keep this simple, writes to register 31 are only accepted
if they are lower than the device specific raw page - 0..4094/8190.
Otherwise -EINVAL is returned. Under the above assumption (Only 1G
Realtek PHYs on a c22 bus) this is no limitation.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 46 +++++++++++++++++++++----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 161df1818d02..95641052bc9b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -178,6 +178,9 @@
 #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
=20
+#define RTL_VENDOR_ID				0x001cc800
+#define RTL_PAGE_SELECT				31
+
 #define MAP_ADDRS_PER_REG			6
 #define MAP_BITS_PER_ADDR			5
 #define MAP_BITS_PER_BUS			2
@@ -203,6 +206,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -354,7 +358,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -368,7 +372,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -408,7 +412,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -420,7 +424,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -466,8 +470,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
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
@@ -481,8 +489,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
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
@@ -593,12 +610,23 @@ static int otto_emdio_9310_setup_controller(struct o=
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
+	/* "sync" page in case of previously failed attachment */
+	scoped_guard(mutex, &priv->lock)
+		priv->page[port] =3D 0;
+
+	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
+	    !phy_id_compare_vendor(phydev->phy_id, RTL_VENDOR_ID)) {
+		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
+		return -EOPNOTSUPP;
+	}
+
 	return otto_emdio_set_port_polling(priv, port, true);
 }
=20
@@ -618,6 +646,10 @@ static void otto_emdio_notify_phy_detach(struct phy_d=
evice *phydev)
 	if (port < 0)
 		return;
=20
+	/* "sync" page for next attachment */
+	scoped_guard(mutex, &priv->lock)
+		priv->page[port] =3D 0;
+
 	if (otto_emdio_set_port_polling(priv, port, false))
 		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
 }
=2D-=20
2.55.0

