Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEFD37BE6E;
	Mon,  5 Oct 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186583; cv=none; b=ZE5cstVqSVMXqZN51+sK4newxUfX1Z7dwUx3xOMRSa5l8YMGP6a5Vix2Vc2AVInE2UK1HWwW6Oe3CxNSMoHFRizblk/BhFNNifiGEqZh2Ad4XSKL4GeOq1GygXrpn7z/AUDX3mvTolU34Kq9t65lJ6o0iy7HMaCaCYMIKwXV1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186583; c=relaxed/simple;
	bh=K2r5T/eDvSj+rpbiSn2+Xv5lmx4gjTaGnU/ZjiKEKEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6Uu6AQXB1O1FFyznbnrFZ/E2EplTQKEslvZrNxxoJnse8pSEihYpXHwl/LOgGuCgWDB+o/luTMtoyYRGPm13adYh+v35twY5oEQW91EOVjG8PN8XyX9HECqioYpdG5qsaLP3GA+nGjAnP288nS1IQrs0ZNjq3mueNRjigjtP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=cOm+eAu8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="cOm+eAu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791186565; x=1791791365;
	i=markus.stockhausen@gmx.de;
	bh=92/BWRAh70Qxk21kTLKmIM5PeqfPOlGMbavhUMEVHD0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cOm+eAu8F/xkMIuqgJ3NsqZt3fbXylyCwsiSq9p393hh25tFEKvIQR6PcOpQRWSf
	 tLe63Y7XsUnVxorjvhpyxQDkXMmPEXqhXUEppcZqAc9gZk/V17NmQx4+TIuEZMoZc
	 WRvl7BfgxrwBJM1bPfr91InNFHi0O2lpvAX4vW72g8V3X7EYomW+9conUT0QL5e9B
	 Tz0bk0b+gB10+jq/xRcKFpEYSASc8m6239V9PGcYLysOcE0cRyqwWRUsYdfBjgGF7
	 YKftsnOtbiNHU2xxZe1guDErPDkPN84ifXIZ1gMANnO9NQ65Mcoy6nBLuVrAptzxo
	 hbFfPXxkeFrNfAZlfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1wbVRW1CJv-0150zQ; Mon, 05
 Oct 2026 09:49:25 +0200
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
Subject: [PATCH net-next v5 3/5] net: mdio: realtek-rtl9300: convert "fwnode" left-overs to "of"
Date: Mon,  5 Oct 2026 09:49:06 +0200
Message-ID: <20261005074908.1273383-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
References: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1tve68xS8syID6juz563p0uqGVVMNDuUSKDYJFbt/l0bweSwbjI
 eJv/ahb+wzeRWhvbB0oONOwJbR3IHrqSnQVvZdB14oP4h/7sZtG7hFvuRVPeZZEKBOShzXi
 HU+CwCYIAau6aoedTJy737TBOwJYzFpTwC8+hhSPiBa+FqyS0farJImok1bpQezYfHEAgNY
 maAJ2huqSjaGKJx16LvRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M31LIkfbqKQ=;msdpTrFpcfEN0CPF63PXOdmbrAy
 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
 Se9IkXiEGt06esPQ9/XU=

The latest developments of the MDIO driver consistently used the
"of" API. Convert the remaining "fwnode" left-overs too. Also
align the continuation line of otto_emdio_probe_one() with the
opening parenthesis, as required by the kernel coding style.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a6daf4a5a664..79422893cc85 100644
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
@@ -837,14 +836,14 @@ static void otto_emdio_notify_phy_detach(struct phy_=
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
@@ -871,7 +870,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
-	err =3D devm_of_mdiobus_register(dev, bus, to_of_node(node));
+	err =3D devm_of_mdiobus_register(dev, bus, node);
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
=20
@@ -907,8 +906,8 @@ static int otto_emdio_map_ports(struct device *dev)
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
@@ -1008,7 +1007,7 @@ static int otto_emdio_probe(struct platform_device *=
pdev)
 	if (err)
 		return err;
=20
-	priv->info =3D device_get_match_data(dev);
+	priv->info =3D of_device_get_match_data(dev);
 	priv->regmap =3D syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
@@ -1033,7 +1032,7 @@ static int otto_emdio_probe(struct platform_device *=
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

