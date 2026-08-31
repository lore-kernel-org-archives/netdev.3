Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD684EC65D;
	Mon, 31 Aug 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186909; cv=none; b=Wy0U1sPBzmmKWJyjI8v9/yc+zYOM2ow+IRxilR4tXH8iNrBns90TXe61jfVMp0CLhNUW0EShtHhwC/4D6RYANjS+sWZw1Bn591bHulcc2DV7sOnj0niRZR90BfAB606z8pB3wQ6f5TS0EetqMvU1BBGhTKHZDuL1cU5gQHiZmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186909; c=relaxed/simple;
	bh=jWIyDqZc1Tct+n3F9ss58mpDGbguW8LWOzjn8ciwUSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlTWpUpb3Nr7njX0Re+uwFyAqXezoKV7QUDt0vh7BjkdkQVsABxr1hmJg0jQDInxTUJ9JoU6401hyMD5tI9AUaTfQ7BeFy3q6CfIXKOYsVvtt38xbAi2BYanAMeZTyGVv+9RNYyDCnmOwCKrElormF/XoDL83X3LrQJVpf/95Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LG5qLhyO; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="LG5qLhyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186899; x=1788791699;
	i=markus.stockhausen@gmx.de;
	bh=2YbZ5ZVxIGA3WanMcnWuJBY7CP91NnQUIAN3Zjr0SvU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LG5qLhyO+JcTirSkdESDXgRNYKgommjuPczw5nwzTK3e2ZkkhVc4jUmTH8LNp9Md
	 EcEXE+eBrOPR07vqjg4x55uuxs3kg9/bwlKQAIbQpC4ejAh2TGHSFn21IF5tUBNMf
	 hQYhKIlkpYRDL+ZUI3zjAUdXOCOvEbnvERwOL8ub1uZU9Jz12H+G8Tg5VG4pJ7V8t
	 f8djfm6RmIk7xFUcikVo1aEaaPcx3/HhwntmdtKoAzibPTtMvq84mMdbkBmUz2PpC
	 +Pc+aeFKlAV8RSsx0wnlRlskkitsJWSCNopOBs2ajCscC8s5UU38rHsCnnG6FUgpU
	 AYswlf4KqosB47tT4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzT4-1xFPeY3Ake-00HiYK; Mon, 31
 Aug 2026 16:34:58 +0200
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
Subject: [PATCH net-next v15 08/13] net: mdio: realtek-rtl9300: Add page tracking
Date: Mon, 31 Aug 2026 16:34:34 +0200
Message-ID: <20260831143439.2404484-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ch8DSmN25o0Mupa6ChZM2lDk0St6Pck9lE516jMXaFF2Ssc5PNW
 0NBcqCh3dmxUWJrknIh00H0lya8R1EbxBf7ybpTAVHOe/Av1iWr5YcevwvehphIi+E1CqQp
 jw0pNX1hw8Lfjr1ANRgbcIYv6lpfGE6B75K5xkBNkNcwIIoZ2Udw5xJB71u/4caYjYA7kYq
 EbTe7l+HSJzlbfcXh7+RA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XAK0batboC0=;m3+np3Np8NWlEW7A4poQcMsBIlo
 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
 N8=

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
index a925640290cb..d6027062e452 100644
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
@@ -473,8 +477,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
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
@@ -495,8 +503,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum,
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
@@ -607,8 +624,9 @@ static int otto_emdio_9310_setup_controller(struct ott=
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
@@ -616,6 +634,16 @@ static int otto_emdio_notify_phy_attach(struct phy_de=
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
@@ -631,6 +659,10 @@ static void otto_emdio_notify_phy_detach(struct phy_d=
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

