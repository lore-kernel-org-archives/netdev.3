Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFC361DA9;
	Sun,  6 Sep 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682812; cv=none; b=k5zOl3tMnn8xOUbuWNdxU4nQtPKm65PWApGxeiEkUhD6pk5fMGSHNOhCE7MvJkddQSMJEUpUZcezZnqFBSqDiTIQoeeLqH3FhWPDqOQidByy7yY03d0xBgufBmuPh8DXgIYGEpbmRAz+mms4IfssU9qUAujoRz7q74fuZ90zCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682812; c=relaxed/simple;
	bh=WI5bMY1Xmu2I3JR2ry52uDmdj6lw+r8egvmQdMMOQAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoSIyZowGtGnZixCfUeGpUh80DmHADN4oB6sGNggwuKJkDznoS/ueXuHBY10miPDuzeuVho1l/ZEPdIA1XA2FCmvMwWhKyT7g0Ws1t1y+RRWALpPrQt9jcGvR7651V5H4MKJHEVKxfh+k/wipiq10OmEfaQPzXilHhon8mIWjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=gGFxOfyW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="gGFxOfyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788682802; x=1789287602;
	i=markus.stockhausen@gmx.de;
	bh=SABIvor2werSar2AYf8ldHOwFNBcXzIdU4ilJjfE33A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gGFxOfyW/xN1gN0vHJg/eLAfQTx4pndO5B5qIEE4toB3OlWw7MQ/Fx1XOfZzyXGf
	 W6PDFFe3laretQDIxocHYO4MLLQ6lvd+o6VDqe92mTMkp/0AXBuLzFtx1cMJ4uYF/
	 Lqz+jmM1Duom3MhD62+CEBpVPHFizGEr9scZfuyNMR1UXgpm/hTWxi9YLSBrkYptj
	 54WsdYIHXfIu4Zfr/r6p3IcLGZyT5v3ToAhZt56U+l7xldpGb2S9MUBwTOaeEk2wY
	 4eUJe6O+H9s3Lt9IvR9ZvhUh1JY6FRBPDWcJ3U18xXdIkGNaDiFM1bFuNS+Cczh5s
	 W4JltE73XVyUUMHGgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1wTFSQ3ZCh-00dYHa; Sun, 06
 Sep 2026 10:20:02 +0200
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
Subject: [PATCH net-next v2 2/3] net: mdio: realtek-rtl9300: Convert "fwnode" left-overs to "of"
Date: Sun,  6 Sep 2026 10:19:45 +0200
Message-ID: <20260906081946.3499898-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
References: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:40HptvJVXOKpPzEGMyEMfwwewEREtYGi0vyx/gylwBAkAdoflYB
 ae/uqT3At9LbE+/I8yewqfjMRNbgfhlxaYWZ0CSkFv7I+U9CP7BfKQ9JSIOikYjgnPsB09q
 /+E+bc+F1TtTV64Rn8BTOSgEJqVSQLrdoJUkWBxVI715/IOX4oZ8+G+rHaQyrbrZvqk6ciU
 iBKOBqbQ9YMHT5r17gfJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sscfBaGg/4s=;jZvJLIYijtw4Ip8jkXJCu5uXjwa
 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
 vIKTXEIKwbMKC3FKw==

The latest developments of the MDIO driver consistently used the
"of" API. Convert the remaining "fwnode" left-overs too. With this
align the continued parameter of otto_emdio_probe_one() with the
opening parenthesis to follow the kernel coding style.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 11d078ef941c..429321e9114f 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -831,14 +831,14 @@ static void otto_emdio_notify_phy_detach(struct phy_=
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
@@ -865,7 +865,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
-	err =3D devm_of_mdiobus_register(dev, bus, to_of_node(node));
+	err =3D devm_of_mdiobus_register(dev, bus, node);
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
=20
@@ -1027,7 +1027,7 @@ static int otto_emdio_probe(struct platform_device *=
pdev)
 			return dev_err_probe(dev, err, "failed to setup MDIO bus controller\n"=
);
 	}
=20
-	device_for_each_child_node_scoped(dev, child) {
+	for_each_child_of_node_scoped(dev->of_node, child) {
 		err =3D otto_emdio_probe_one(dev, priv, child);
 		if (err)
 			return err;
=2D-=20
2.55.0

