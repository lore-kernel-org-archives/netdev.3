Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCEB41F5CC;
	Mon,  3 Aug 2026 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777559; cv=none; b=ZmuXetTG2BuPnk08KIi2vE249YJyLvzNXRsW9yy9p2EwFka+FQZb5KUZ7rV0sv4A68sdchmrlMUuZXDUFexocRrjKaU6nLkQX+Xe468kPkydN+OYDt6wqAu3O3qU8zRhpjwOugdO/Xl9LPkDmnM04IG+ryUFlYRGLobDNZW821M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777559; c=relaxed/simple;
	bh=HiULOfPbyETK+Wp9CpBb/T+1+2K6Peq4DcYQuFuHoV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebwkdnaCykybZOlwV/MC56pdTQAg4HtwpayxqdkegXPFtW0wXnM0h+nFHaEiL8w69L8/OCoSuVqeHz4O7wppen8wj7BW0kFOlMbnHsHUNrdSlGxqdYlR19YqEMV6g2V8gH98HAtyUlpZiLI0C1QC52J8UnmH/KV9wjwEBTM3qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=jbllnXyh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="jbllnXyh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777553; x=1786382353;
	i=markus.stockhausen@gmx.de;
	bh=BBHBrToxzvuLNl1BuhXUogYlKEsVzDW2Rr12RQB1G/0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jbllnXyhDkLRC4ASVN10WJuiCviIXewn5QAeRr80S5YSe4oCMF9PdA9JA/l3w9FI
	 CfKHMd/NgAkK/mrxkTvvJ+WgPZq1GwRiQoi24bwMrwsoikFriO6t66HBoCZFV0Eje
	 fXzS0ImOZ/Vvc58JgKcd+De29xaSYVDsUCZtFIyyAwhJTB/+ebHHcFe0vMql+HUU1
	 zkUOXKNDHZgtjIFvHkao4f3n70MoyAKt7tz/Z5qdsQIH1Xy32mX5qWSW0olZ1I4aO
	 /3AEebCrZVBJt7+gAoUkCB2ruivTysKbUs9Ai8b4TNIAyipgQ/984PIzoze7gHE+t
	 S3GiagOtbbmYNfknxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1wh4xh0PvA-00ErpA; Mon, 03
 Aug 2026 19:19:13 +0200
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
Subject: [PATCH net-next v12 06/11] net: mdio: realtek-rtl9300: Add page tracking
Date: Mon,  3 Aug 2026 19:18:48 +0200
Message-ID: <20260803171853.507506-7-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:s+NH3mjL74y43cyHJOsnPQ/83wu+yONyoHt55SOfdx0LyFj+8jc
 i0ibQvNA3Uo8ar8afAaExxkJ70pfRSXs5zaOk0XThb7IAnpnFiK0hwURlyliI9moE6eIv/B
 H8Ha1mc74gx1QfgJ7vU0NyZFxFM2N4GZRSGmxxcJzTzBk7algfOLbDgNbbisnCx777JvMws
 sMag7e+jsaG8XaKzx2uew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rna2zBRLcM8=;YCNvhqC3EEdBYqmoOE7PQoCwt51
 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
 E49hwVJ/Fplq3TAg==

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
index 210e570c0973..914686135006 100644
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
@@ -614,6 +642,10 @@ static void otto_emdio_notify_phy_detach(struct phy_d=
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

