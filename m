Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180637F741;
	Fri, 24 Jul 2026 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872612; cv=none; b=ezuGJTeLTxzGwvn12wNEYbnBFY3fVAANl126B8Lz0z63QIKFlbfld58Lnf9IpMHdEhE+OH6IvoCrYfuLt78dZV9bRtXUa+tLe+Sc6tx/OScs0e7I1q/AjFX+Swvp3sFhsGos5M4sIJ9Zedj6P0RNZkU8JA9/GjYECmE/DOGXeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872612; c=relaxed/simple;
	bh=510koIl/Xmqfr90YS48inGrB0fzli398UhWGTaPYabU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnPtFlx3cu7ApGhLAzXW2wNwKH/xuE1krc3UFct2R4P/scgpCW6jETwPnM/cAuYU0kAM6KyBbFsEjqCJFxxgyWsixioWzl/3X6X0eyjrnRkJrDUZ106cur7MNl+GuxTN19xXBAICOX/gHPufRMOdyQSgxCQm9i44UIXS5UzpTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=OP8VP0/5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="OP8VP0/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872586; x=1785477386;
	i=markus.stockhausen@gmx.de;
	bh=m1xFjD9vyO7V0LZYpvXnleo4BQpwKWRT/GHDxSnbxbg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OP8VP0/5W0F7auwszYooYfPApSFaD4ixAmNKdir37Ybs1D97sZGnJavgHo9nSKyU
	 thZFAKgBQd6+ppAAX+t8vn21ZGcZqVXf9SUozmZCRtzUtG8qi6wn2Zxgc/X9MYT8K
	 nHOFuuXYR4kw+t3Z/fZRfiv9XE2/0eFMeGSMWXv9LlPC1ufd88FYjLOInCHGbifG2
	 VIWKtIyGvRQFFh0RA9ffUG2vkgfkM7is3c1W653v3geXmq1i1j3aSxW2rWCWnR9gY
	 thWu+hp+3yt1VKBz5GYZT6RgtK3cgkTkMZmzw/9R47gNjyvLqetsyjgk/dpKj0/pn
	 rVOVl2a0cydFMyzXBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1wl9tr1OrB-00EbM3; Fri, 24
 Jul 2026 07:56:26 +0200
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
Subject: [PATCH net-next v6 5/8] net: mdio: realtek-rtl9300: Add page tracking
Date: Fri, 24 Jul 2026 07:56:08 +0200
Message-ID: <20260724055611.1008577-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
References: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4pq7t5ikTJFMcNVaeGwYfhKL3Wuo9z4bEVyvHE53hxCyXnTc/Ii
 Zh6Wt4hTJJgDUbkFSFEIlg2NWVMmLHIwjTogliujGDifrgpe2rpXUPywI1PraAs8DP31iGj
 V6UZUB5w6L3flufOEg9Y/eybxaCR9xnjVUVbhJ9EtXD+M0hfj0bAlUqcSKBQ2YNiaw1YpO4
 o5DcL749X8VmIotsyWLmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xbzNHDwrLOE=;U9NE/TNa5wkHGZtTroKUVvrHkcU
 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
 eRuhke8MGsWS

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
index 4b70aaeb8c3b..b5ec5d39cfcb 100644
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
@@ -204,6 +205,7 @@ struct otto_emdio_priv {
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(phy_poll, MAX_PORTS);
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -355,7 +357,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -369,7 +371,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -409,7 +411,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -421,7 +423,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -467,8 +469,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
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
@@ -482,8 +488,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
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
@@ -596,11 +611,18 @@ static int otto_emdio_notify_phy_attach(struct phy_d=
evice *phydev)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
 	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct otto_emdio_chan *chan =3D phydev->mdio.bus->priv;
 	int ret;
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
 	scoped_guard(mutex, &priv->lock) {
 		ret =3D otto_emdio_set_port_polling(priv, port, true);
 		if (!ret)
=2D-=20
2.55.0

