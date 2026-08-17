Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0F45040C;
	Mon, 17 Aug 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984041; cv=none; b=kXCu0Qic2OQhBNVtb5+QM7Dh2AGSc9oxKbFxSpgZRNLza8un/aybWO2Kgj/ay5Fs/fL4DPdcUOA8XeruEpyDOKuSsvw/AGwp/zulpccXpHy6tM7WSTcLxtUCnzNBW/3UwqRW9lBQivtQIwyGggJUxxuzdVvcLjdygg1Df1qOqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984041; c=relaxed/simple;
	bh=8jmvjRRAEKzcfVpGrveoB63o3X7VP1QvTRrUz7lhDm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCammRTdzpSrz7FUkllIjo2kZvJDpJfFlypink9PM5gM7Q2sbsZWpkqhHsjThYtZfRc0hUmKQZsXqOvm+pHa4DOBjQS0toznYSl3tccAiGzqaQT9ByYDKXNt4u5zmbb/oTUPd9XLhf0Iv/iRXq9gH8vp0hW/rOI4edpnkabKpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=abxLQjen; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="abxLQjen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984011; x=1787588811;
	i=markus.stockhausen@gmx.de;
	bh=SaBrrIgUmcJDdNpsfyvXT71EgngS10UuVvb3gsCMp90=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=abxLQjenXA4YD23yzVI4NdObxjeHYqAI55LkvvYmpQJIfbomJSeGBehMGHtrx9Bf
	 u9EtITlujRsONTsTRZ4DOB8EpchA79t8x23ikqjO3nmwIIVwre7XdWfk7Hy1Jrpq3
	 ri7ZOuXCAjlzXNcTcjXClvVjWv8QcwLwJvzgamCjhLSRHSEbQZtPHvqL1BT3DI8Z9
	 cu2Wby1FM6oWV32PmKFzzNgD2czkKiUv/eLDjKKvT0p/R3X4tAYS8GebTE3aA6Pe+
	 GkMNGpb8Y4NGXO643r2R8NB5TCOcSJLbfjksQ3lzbF2z9Sf8B0pgNBZMjFzkO3RpY
	 JBA5Qnc7UBKazMrNkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1wnuzF2eDm-016fBi; Mon, 17
 Aug 2026 18:26:51 +0200
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
Subject: [PATCH net-next v14 08/13] net: mdio: realtek-rtl9300: Add page tracking
Date: Mon, 17 Aug 2026 18:26:27 +0200
Message-ID: <20260817162632.1208891-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n8ZIPYDbfYOxFEfYGstRyHN+6L4N1Bdpt5geRDo0dPcnfa1wBbU
 uwuSJlZbrWzdOxWeHrV5nu23dTsE4JswRS5BFU3pJhHcscCoJ/UwbSce2TJsBAjaIB3DNjL
 QjfxCKrym7F9YBDNaLUYFqhYZfcE3g3blF85iSfKdQ6tHoGP17IMTKGHpJc/h4KCr49AbGl
 x2FPdpxNarEjPkzUOccjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LrFQtRkzgK4=;ndVxX4GaJMNFUipZcPrTudFmSHE
 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
 gatZTeA5JwsLmqqQntkSH8Icg270=

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
index 456827879a62..6774494d4ecf 100644
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
@@ -204,6 +207,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -355,7 +359,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -369,7 +373,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -409,7 +413,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -421,7 +425,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -471,8 +475,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
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
@@ -490,8 +498,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
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
@@ -602,8 +619,9 @@ static int otto_emdio_9310_setup_controller(struct ott=
o_emdio_priv *priv)
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
 	if (port < 0) {
 		/* All subsequent bus operations will fail */
@@ -611,6 +629,16 @@ static int otto_emdio_notify_phy_attach(struct phy_de=
vice *phydev)
 		return port;
 	}
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
@@ -626,6 +654,10 @@ static void otto_emdio_notify_phy_detach(struct phy_d=
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

