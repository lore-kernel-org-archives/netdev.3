Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD25426D13;
	Mon, 29 Jun 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746644; cv=none; b=RyOshXcL3j+5D4r8EzKKQjSD1cNBJTDXN6ufcwbIHQ0Yv0h7MyoC9RY/ejjU6UVHvCj0/a2lfFjJPy0pQ6I9A5kP5hJkhrLe8ApByTu8neBnLRZtRnPXPGNTG6i+J+0qqeiNxT2iCNlxBh3f1KuUTgjVft/KQjNN9DS9CShIL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746644; c=relaxed/simple;
	bh=+kK0kN7xbzF7Xk4VSECmRtG5Lvd7I7xKqRO/bXdqniU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUSnIsd4j5yR6WaM0ExOZT4DLMNgRzGgz2fnEe/0YY/EAnBRFwzYreWWC7b3MMBoC+4Cs9YjWGD+8HhqASv+m45ROKB41BmlV4LsqxYtButWhwsuqZHcXP2Y/tKQvoFOxDzq3zdH/H5ZptmDGQSViT5bVCI4VyII6zeZWAAZgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=PK1vDOL4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="PK1vDOL4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746632; x=1783351432;
	i=markus.stockhausen@gmx.de;
	bh=iFS41hWv9EaWYlwZndRGv7grY1BCuTOOcal7SC1ER24=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PK1vDOL4RyXCnyvbU+BPXNH/cZ6T3ftXiLw1TmRO96Dz40PdeeWfhe50D3CWHIBp
	 CLPu4SjR0Hnj1rW1Ivx+ZvpVJj1sx/LIkweTsSW4NB8YnRGaUaEikm1gR4XURDeVD
	 XMpqRzAWl4yQHfIz2RAZ1sCsPdv4e7Iynf4VyJ91I12I8GgXQscKfrObxGGMwhhMr
	 +6lyn/kAsjGypd9Chz3T4mTgOVp3jjS837jnHNbqZ2QM3pLD8eqd53FuCHPoSTMvv
	 /jFZi/xslmt93w9foCcjifdaCbxjl1WmUnOQ22l59tpLnBFC64GyfR0bUnvtkfqGD
	 ZCbanHJu0nshht+AFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1wf2eG3g63-00BtC9; Mon, 29
 Jun 2026 17:23:51 +0200
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
Subject: [PATCH net-next v2 2/8] net: mdio: realtek-rtl9300: Add page tracking
Date: Mon, 29 Jun 2026 17:23:30 +0200
Message-ID: <20260629152336.2239826-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x0Xji8WHYgDbBQyURVw9cgWgJQ78Faw2OC1afGJeB9nb8y9EGAR
 aWhF+kI2XSRRUzQckY/ZfT89pjS9Oqir9bc5lw22/QsCdjDLTiMHZUlp6GeC6ljsulBbCUT
 R7U2OgdCR7MzUk40r1/nTp6ovqCjGMWPhhWGQDFo5Uv0avJFl+WBNAvpGrjLuDBtC8WrW/u
 lfAt4A/GG+RU6I7gK5bLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Geed+qc+QZQ=;7MG/l4hQXXLD24owtdtgxTNJyJp
 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
 3H8JcpvJjApX1zm68fxMfEnB/VzdV6u6lUDC64S

The hardware polling unit of the Realtek switches has a very special
handling for PHY register 31 (aka Realtek page register) in place.

- On the RTL838x it is permanently reset to zero.
- On other devices there is some magic saving/restoring (aka parking)
  in the background in place.

This makes access to PHYs a gamble.

As of now all known existing hardware designs have Realtek based 1G PHYs.
Otherwise the polling engine and the MAC status update will not work at
all and the vendor SDK would fail totally.

This driver differentiates clearly between c22 and c45 buses. During
probing it enables only one of the protocols for a bus. So it is safe
to assume that any c22 access will only target a Realtek based 1G PHY.

Intercept access to register 31 and store the desired value for each port
in the driver. When issuing access to other registers add the saved page.
This given, the hardware will run two consecutive c22 commands that are
not interrupted by polling.

  ... hardware poll ...
  phy_write(phy, 31, page)
  phy_write(phy, reg, value)
  ... hardware poll ...

Remark! To keep this simple, writes to register 31 are only accepted
if they are lower than the device specific raw page - 0..4094/8190.
Otherwise -EINVAL is returned. Under the above assumption (Only 1G
Realtek PHYs on c22 bus) this is no limitation.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 26 +++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 6ece095d7e97..616edcde15d9 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -193,6 +193,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -337,7 +338,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -351,7 +352,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -391,7 +392,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -403,7 +404,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -449,8 +450,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
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
@@ -464,8 +469,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
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
=2D-=20
2.54.0

