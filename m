Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF63C13E3;
	Mon, 27 Jul 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179777; cv=none; b=rgg7JQjI47i+cfCkvbDjsoR19EwrpmI1VzMoizJGKB/efk29nKBg6JLTgnhixxADP7sZZ0AlkvZuCBqu2VqBjb6dLUgREmxfOUAlBfp037waKdVAAAbV5qx2qeoi/p4k/6AJMuRpVe6lexyv7IcWfw5qJkkVQAEPwxAuFGLqkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179777; c=relaxed/simple;
	bh=u9l3IvHgHRJjLb7Epl+qZpkaJSULBTOSmy0bQjgVXvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQhXcLZtefVaQK1RPbJkToww1t+V+/Xw67+rMU8zcvplr2d8zixlTaOFiQqgwzxXNITtIcj6x6ktHWmtgOWatfRSp3lgwMLzrjO5ulrPbn2WVw278fA/ApMNoivh3z8wtq4OILah0MZrsNJIn3rWBRF7ahUtznUCphtuOI4G7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=iKiwhbrp; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="iKiwhbrp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179774; x=1785784574;
	i=markus.stockhausen@gmx.de;
	bh=WixZb+l2F15iInO5iEbT1j8cikCuNn3EXRmmpxD6E5k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iKiwhbrpEMB8PyHxkbYx5p+OwSv06v6grvcK1TnVinhCvoHcXr8KNTKkJD9SQcOY
	 AXNbH0/C9MS3TdMrp6+UFJk9mGdGQn18O/fIoWxSddDtadm6EuuMkHMvNKpigeaih
	 A+j/1Wg/3Qu+l3M1LZNH809PJO2JBhZlDjNvgbAuyDGTXRpGaCF6pK3MsxJo4PqeD
	 dRcpt8w+54NUsNzrwPGW0grgYBzhLVujoAGsLG5DoSqOBsqI6gayCvGDJuc9K9gE2
	 hA6AbQpbvtiJfxV9nj0CFdypVjmdIgACE/AO4GEEQjr2ADl9O/l0PVngaJgS/st63
	 f0a2Z8ipIi/BYOaJDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1xQFj60Ep4-00iAm9; Mon, 27
 Jul 2026 21:16:14 +0200
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
Date: Mon, 27 Jul 2026 21:15:56 +0200
Message-ID: <20260727191559.19617-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191559.19617-1-markus.stockhausen@gmx.de>
References: <20260727191559.19617-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZeE1cTnAR3J31JxzIKs9VK2IsaDQ+D9cQpFK6wd6C80hgv/InZ9
 ZJ1eCCRIoTgwDOlxJt5B2dBPjz2zlYp175cOpRhLPdRTH8QQEKvJq9SnlJFV2aestYy+xYV
 BAtEnAryQCc1/NgtRe8YOXE4BH4mYXesfaCyqXK7OcHVhWj9A8wSPtmRYEu3lpYNUeEryN+
 PuZbcyI3XclV7gQwpU1LQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zxGI3V20w84=;ufddJeuaaYUzjvws0Xzx61W/8zU
 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

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
index 0d5b9530e43b..6986bed5258a 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -178,6 +178,7 @@
 #define PHY_CTRL_CMD				BIT(0)
 #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
+#define PHY_VENDOR_REALTEK			0x001cc800
=20
 #define MAP_ADDRS_PER_REG			6
 #define MAP_BITS_PER_ADDR			5
@@ -205,6 +206,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -356,7 +358,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -370,7 +372,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -410,7 +412,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -422,7 +424,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -468,8 +470,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
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
@@ -483,8 +489,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
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
@@ -597,10 +612,17 @@ static int otto_emdio_notify_phy_attach(struct phy_d=
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

