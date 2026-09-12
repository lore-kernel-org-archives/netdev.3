Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505847F3CE;
	Sat, 12 Sep 2026 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218330; cv=none; b=aSUfTenkcrTTMzoCMFd78SUa7tQdxmXvC1iqGpIDCNUPkt3GS5xB+8yZvRAj8Cf3Hx34XdIi0WEVIiVrJ99gWK6Uj4hyYAlATuQKsaf3P3DiTJj2h2NhPBiBnXHhTJW6tGyuyKqEq3fNmwACYEgicf9pWUT0mK54cwfW0ngHvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218330; c=relaxed/simple;
	bh=EY57UGmucd+pZ2XVvMVbqlwqaiF2HXHIqk6FybOAauE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDMrkwNTrnTIbgjo0utDW6kFLyVns8hIDApXgJhoEd22Mf3FUz4EnK7MCKTW78qhRd+x4meJMxB/Nlcv7zmPu+lnhkfFZezyN2hfKXCEh6zjcHRIC+M5+dcViZLTXW538hG7CduQ/XNggkWlIt7N3dl6vLh/TxBDSLUFeYlqFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=UXFTZOE0; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="UXFTZOE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789218309; x=1789823109;
	i=markus.stockhausen@gmx.de;
	bh=StWHul0884vPGnKHNiGVh9R6PCBJqF8F8tlYvXoK2jI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UXFTZOE0zww4icarBMoPUP/qCHGv7U+wN+iNWUQVD9RyDRxWXxAftlU5t22O/5Pd
	 iMvV30wDruMX8Q9DdSdyAaCNxwtiuLNaG0VpZ810nzguh9TuLfyfck4VJz8Vtj7LC
	 0pND+NKi2eN1QALg7eQCR1ZYak8Fu/sN0n8AcF1qF8+5CyVO5V6qF6ZEmI1VDDITN
	 jsEMQL5E3auirM5DW/rpwI9LSP6+tu/N17mKZLnDbG5ASFmCAA8TDZli2kizad/lb
	 TDRwJsY72ICrrBBiec8FVlXOL3rnYlWy7Zm7+qbT6x/t7y3UUFbI3hCBJuGUvgrTX
	 S6Z1et9RN+Ihn0ZPxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1wlxrq1WV1-0187HY; Sat, 12
 Sep 2026 15:05:09 +0200
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
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v4 3/5] net: mdio: realtek-rtl9300: convert "fwnode" left-overs to "of"
Date: Sat, 12 Sep 2026 15:04:49 +0200
Message-ID: <20260912130451.3757276-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fbWIM3c2lpDayDBwXqHB7KNayZ5XdShRou5DhzWKGfBV7XQf2iF
 f4Jd6TJ80Jwn0eSn0aCybOoaIUTRBmzBHH8E/SZGeutoKA5kWKonRLGSQvhXF2kpWvQTtZU
 AHZ3XjZWBscwlhRs7EmsyY3/dtDf/FX1JujECJnP3HyCyNCwK2kAkx9Z6dWhHfGidXLEerE
 jAxxabzpGL0qcoU9NfyrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nF3sIaFRrZ0=;MmWrdTqQpNE8uPdTzjtyoNCSI24
 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
 +SoMHknwn4fEax2fV1korQpeuBfkdFQD8zRl88=

The latest developments of the MDIO driver consistently used the
"of" API. Convert the remaining "fwnode" left-overs too. Also
align the continuation line of otto_emdio_probe_one() with the
opening parenthesis, as required by the kernel coding style.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 11d078ef941c..8ca917d9aea3 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -123,7 +123,6 @@
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
-#include <linux/property.h>
 #include <linux/regmap.h>
=20
 #define RTL8380_NUM_BUSES			1
@@ -831,14 +830,14 @@ static void otto_emdio_notify_phy_detach(struct phy_=
device *phydev)
 }
=20
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
-				 struct fwnode_handle *node)
+				struct device_node *node)
 {
 	struct otto_emdio_chan *chan;
 	struct mii_bus *bus;
 	u32 mdio_bus;
 	int err;
=20
-	err =3D fwnode_property_read_u32(node, "reg", &mdio_bus);
+	err =3D of_property_read_u32(node, "reg", &mdio_bus);
 	if (err)
 		return dev_err_probe(dev, err, "undefined smi bus number\n");
=20
@@ -865,7 +864,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
-	err =3D devm_of_mdiobus_register(dev, bus, to_of_node(node));
+	err =3D devm_of_mdiobus_register(dev, bus, node);
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
=20
@@ -901,8 +900,8 @@ static int otto_emdio_map_ports(struct device *dev)
=20
 	ports_dn =3D of_get_child_by_name(parent->of_node, "ethernet-ports");
 	if (!ports_dn)
-		return dev_err_probe(dev, -EINVAL, "%pfwP missing ethernet-ports\n",
-				     dev_fwnode(parent));
+		return dev_err_probe(dev, -EINVAL, "%pOFP missing ethernet-ports\n",
+				     parent->of_node);
=20
 	for_each_available_child_of_node_scoped(ports_dn, port_dn) {
 		ctrl_dn =3D NULL;
@@ -1002,7 +1001,7 @@ static int otto_emdio_probe(struct platform_device *=
pdev)
 	if (err)
 		return err;
=20
-	priv->info =3D device_get_match_data(dev);
+	priv->info =3D of_device_get_match_data(dev);
 	priv->regmap =3D syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
@@ -1027,7 +1026,7 @@ static int otto_emdio_probe(struct platform_device *=
pdev)
 			return dev_err_probe(dev, err, "failed to setup MDIO bus controller\n"=
);
 	}
=20
-	device_for_each_child_node_scoped(dev, child) {
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		err =3D otto_emdio_probe_one(dev, priv, child);
 		if (err)
 			return err;
=2D-=20
2.55.0

