Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC26379ED4;
	Sun, 26 Jul 2026 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050307; cv=none; b=EHy0UutW96Ok5lK1qegyav8VMR9paoP+iLvRpMH8J/bLVVB5GoEAznOiPOCcq9W6pqlulVO4aU+c13ZbclLfufdacDbksxhoyIqCpAD6Xw52VOQ3nOb9DnUkJCa9WQelP+9/26cjj7L8oS4afj10vvcT/2iO0EhC1t8jDGX3n2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050307; c=relaxed/simple;
	bh=2vADXpN6R/2YY89dgCoWK2j1mCRjFjmci8Z1P8eCuUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPn9ASP2OAC37iPMmONKklT2nx7rLyNi0B0ijpz+0UyZA8lW6Hh1qKrTz4okHiTdO+4aIV4OCQYmSWgHvL9apu6lqo3h+9mz6xeHVduVBlW016m3wkkme6KzeuayMun9XOR7zpRXeut/b8nOBv7V91jTnhcCvbyDtKdN000P6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=EDdwkJWh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="EDdwkJWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050289; x=1785655089;
	i=markus.stockhausen@gmx.de;
	bh=8V7XNFJDq1vjHcSS02agsn7rtZcKFw+bP90XtiDVha0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EDdwkJWhEuCex/+lOjZD7pc9UcOcIHdCQQ3m+LjjqUDrqwkYCAVbirYtHsT5hbnr
	 6t5uVLYlz0f7rO2LUecIsZi+6CEv2nzzQx05PaAUzEWLWmzKK33c4GKxmNTGctj49
	 xekho8J39vsXD9teS7JVLrgqZan0Eob6MDR8yz5CTOOFyr/ZdTgr9cMBqyUSc0Zs8
	 WgbQyMmJeOn6Hcu8qQIIkgsEelQruFNyP4VyprqwEsQiwe+vhavWf8PlXqwmnL51D
	 HsxgAN83oOF2uoGKV7n4lILq8dqZJcILiGCB2FfnwO47gZgCnDkqcEJDdNjpmcQXI
	 MflORI5LZVTk268tKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1wMyL10QCM-00MvlQ; Sun, 26
 Jul 2026 09:18:09 +0200
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
Subject: [PATCH net-next v7 5/8] net: mdio: realtek-rtl9300: Add page tracking
Date: Sun, 26 Jul 2026 09:17:48 +0200
Message-ID: <20260726071751.1359156-6-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:OG07lwXTKAK9OvzjOsJP7BIW2077KPCW6tnmHkFlyh/MTer/Tlq
 Ik5UGIhk9egX86PSGDDBsprd5LBU+t4XQc8hZ8uGYBlLNSg9Vf1lW1Dh9aKSzFCCTLBHTp6
 nNaDR2r6AZ05o+gNfUSiVYcQ9ISXWpLZOl99upICwrwY4yIw0YRMCdwiJrVJtycq4+r+uk7
 VHPyeQIA2D9CiN0fXUYzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mCrU7k2W0Pg=;Vi8eF+fs90IadE8MAeqF9tqMjWT
 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
 b6WuqRnFXZxJ

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
towards the controller. This given, the hardware will run two c22
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
any new MDIO callbacks and is the lowest common denominator.

Remark! To keep this simple, writes to register 31 are only accepted if
they are lower than the device specific raw page - 0..4094/8190.
Otherwise -EINVAL is returned. Under the above assumption (Only 1G
Realtek PHYs on c22 bus) this is no limitation.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 34 ++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index c607dad9f0a3..07dcc2231582 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -177,6 +177,7 @@
 #define PHY_CTRL_CMD				BIT(0)
 #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
+#define PHY_VENDOR_REALTEK			0x001cc800
=20
 #define MAP_ADDRS_PER_REG			6
 #define MAP_BITS_PER_ADDR			5
@@ -203,6 +204,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -354,7 +356,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -368,7 +370,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -408,7 +410,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -420,7 +422,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -466,8 +468,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
nt phy_id, int regnum)
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D 31)
+			return priv->page[port];
+
 		ret =3D priv->info->read_c22(bus, port, regnum, &value);
+	}
=20
 	return ret ? ret : value;
 }
@@ -481,8 +487,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D 31) {
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
@@ -595,10 +610,17 @@ static int otto_emdio_notify_phy_attach(struct phy_d=
evice *phydev)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
 	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct otto_emdio_chan *chan =3D phydev->mdio.bus->priv;
=20
 	if (port < 0)
 		return port;
=20
+	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
+	    (!phy_id_compare_vendor(phydev->phy_id, PHY_VENDOR_REALTEK))) {
+		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
+		return -EOPNOTSUPP;
+	}
+
 	return otto_emdio_set_port_polling(priv, port, true);
 }
=20
=2D-=20
2.55.0

