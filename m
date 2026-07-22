Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1352C355F47;
	Wed, 22 Jul 2026 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701466; cv=none; b=KULsdkViisOGT25qyT97mOVuhUKZM8A+jbxw/rjUDGgQQem6zsIzTt4TecLuN0AonpV5tcm+/qM8XbBerFMYTad2/QK7O/X70N86ol9Va4ZLwq4hBYPA6TV7A4qhHFOWGu4ieXYaNiPHOyqUcFQAHSvDf/QxO+gCT4evbm7NcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701466; c=relaxed/simple;
	bh=d113MoZAchqL2hvtgo3gL/DPTZTPb+WZ8qpWdhY0uuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKC54Anw1HpV5uzyJ372LgGTkU+ZQVsNWe5qL9fh91xQiYxtHqiJCI141sKqFgGF3/DA33Hd20TfXz+2WKkahWa5Q1PN6nxcAKyFhfqpbL7KQMDYeRpY1idKk6Pk9WjWDT+H6pi17lklgOSMciAF6pV4LZAvjaozht97toz50lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=dgpQKzkd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="dgpQKzkd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701449; x=1785306249;
	i=markus.stockhausen@gmx.de;
	bh=CLDwqTB4FhUMTeDgtuXtOBpHF3qxfM6bNVM7W1QvzCg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dgpQKzkdqZzuQktA6PWPvb7XxzZIIELUZrSceELzaPtUhqqCddXWLewYCuBFt6uc
	 0b1tDX9WTcfjAZn5+9PrJMiTLuzBWAtwTX/DL3ij3KHNyynbo3TpS3WFFUp+XF7uU
	 dbsieaJe3fR5/2Kkk9X15im2/KT10hoI3gy4yJyN+MxZW8bEPJloK9HYbVsg+3ZCQ
	 WFk3VfSiGdqJvUdzSbH4oZ1xsfREsEZ+UrKYNC+oIogqEEpVvtx/jumQ+HRJbKCzH
	 lwAWdWdLDik5Z00wdTdvtq2fYVg+3A0GMCqNnBK8yedm/EmDO61LclVf05eaX/3Yt
	 EDvztGxL4q2PT52Plw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1xNgje0rFH-00cOt7; Wed, 22
 Jul 2026 08:24:09 +0200
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
Subject: [PATCH net-next v5 5/8] net: mdio: realtek-rtl9300: Add page tracking
Date: Wed, 22 Jul 2026 08:23:53 +0200
Message-ID: <20260722062356.12291-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722062356.12291-1-markus.stockhausen@gmx.de>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uns/bNbf8ehOuxb+rYAoOhfhsNfyH0RGa4IB0FrnlSeW8TgBYNd
 CCWJw6XPLXP3nUdjtCBeuvQemgP5AvPU1zegqn1jbhIm18n9G4vkWLLyagTYphK7mZhVcWo
 I4PmR0GAbfIvXlny7VnU8Txn0BubImZGHJCIbnU4iEtyrddCqgJuTbrscHT1YZ3HxHvqSMR
 O72ajr/usr2qR9KIrCtXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v8YcWaY8ous=;ismcF+bG1ewx2E4l+zsUe7TR40o
 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
 VHb3bgkAs1Kh

The hardware polling unit of the Realtek switches has a very special
handling for PHY register 31 (aka Realtek page register) in place.

- On the RTL838x it is permanently reset to zero.
- On other devices there is some magic saving/restoring (aka parking)
  in the background in place.

This makes access to PHYs a gamble.

As of now all known existing hardware designs have Realtek PHYs for 1G
connectivity. Otherwise the polling engine and the MAC status update
will not work at all and the vendor SDK would fail totally.

This driver differentiates clearly between C22 and C45 buses. During
probing it enables only one of the protocols for a bus. So it is safe
to assume that any C22 access will only target a Realtek based 1G PHY.
For safety reasons block any non-Realtek PHY on a C22 bus.

Intercept access to register 31 and handle it internally. Store the
desired value for each port in the driver. When issuing hardware access
to other registers add the page to the command towards the controller.
This given, the hardware will run two consecutive c22 commands that are
not interrupted by polling.

  ... hardware poll ...
  phy_write(phy, 31, page)
  phy_write(phy, reg, value)
  ... hardware poll ...

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
index 2a364ed46902..2d6faa4ccd06 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -170,6 +170,7 @@
 #define PHY_CTRL_CMD				BIT(0)
 #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
+#define PHY_VENDOR_REALTEK			0x001cc800
=20
 #define MAP_ADDRS_PER_REG			6
 #define MAP_BITS_PER_ADDR			5
@@ -197,6 +198,7 @@ struct otto_emdio_priv {
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(phy_poll, MAX_PORTS);
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -350,7 +352,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -364,7 +366,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -404,7 +406,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -416,7 +418,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -462,8 +464,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
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
@@ -477,8 +483,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
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
@@ -591,11 +606,18 @@ static int otto_emdio_notify_phy_attach(struct phy_d=
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
 		if (test_bit(port, priv->phy_poll))
 			return 0;
=2D-=20
2.55.0

