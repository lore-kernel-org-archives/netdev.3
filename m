Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F50D5678C9;
	Wed,  9 Sep 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966111; cv=none; b=NQVSv9OGxi9QjpHqqbmGgleAAByl4tgnYrZYe15BDqg927qoWVyO34wqzxfayFWWF60tK0lt1q2EsQ70kacv5lc+hfYSAKkkgaKsir9XN6J/PAeyVqTiM9I0mwubuhNdeKOJ7L8jHx33susxQQUBZndoKLnj6AdELjfrE1xM7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966111; c=relaxed/simple;
	bh=4pUDAKRzUetys1ylpX6f8igfxJohQSgTi6nWcO8bZvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USj95gUCVId/93Yy3ucbu77at82+4iLGtwzBPWx6VZwOShIbJX7Zo1+IT28XTS7usSIB60VW/U7MZfj8oTP17VsYOOW2B2VM/rOKGnX7ZeGdC+QcJ94l/uubkc4PBKHf2/6phID6eKDNbSXlumDmdBVJFd4XxnXXdcaEjHPx+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=n6AcKbl7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="n6AcKbl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788966089; x=1789570889;
	i=markus.stockhausen@gmx.de;
	bh=2so2aq9r3Goo0jF3DchOvlylV+anfdqOuJR9YKfK0x4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n6AcKbl7XX4p2I6h1C1St2C4JGDhpNc+CIjAvLw5Zk7XPynlu8x0BtByh4cUOhn4
	 orae4QjaP/H+NWOMkB0Yv5iFyLxHJKCyV6WheDxLdeVlJjtOPQaKYKdr5nH/fKJ4K
	 vi3+8I3GUcvE61M2BKu8c7M1cS4/o4Q7Uep69ZVDZ0pS9YqPCE6RgmsizTYAkoZRQ
	 Q0GY8ghB+/iTNmy85qCvgrbFX2vKA6hutsSSJzoHfKgM57SNkKP82qdxU58iPaQMv
	 XJjqEpAnRAvOL8zBtgb0VJtGh8jIHkYUkv5FCqhSptFALL3hqdEBSQqlCBE+sjej6
	 2BXpgtJEDdHH153hgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1wbZh33PU9-00e6MC; Wed, 09
 Sep 2026 17:01:28 +0200
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
Subject: [PATCH net-next v3 2/4] net: mdio: realtek-rtl9300: Convert "fwnode" left-overs to "of"
Date: Wed,  9 Sep 2026 17:01:05 +0200
Message-ID: <20260909150107.3602067-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
References: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dv4katFuhJcyuoVRSNs4S8eSHOymfAw921TrSiHdQ+0Yw44Mo/U
 GQZHlVzbpeVYpI8krVWM9X1J6rtPA1Y10QWzgQAR9E54888cBd7pvjw9qve+Z8DO+K6IjkM
 7EdT7TGKIN8WgnNAI0bgy4UkhA4/JXSNcHJssH7BSOl8Yuct7AYsGhv0/1F8Tm9fY0IS3hF
 wV3u0zoWNVSQrc+eXutIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pp87qRKlIoc=;45sxXpXU+IohPnTwRVkgGy4Xg7N
 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
 JkZ9wDXgsO/S3nyqw==

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
index 11d078ef941c..de0204d8be48 100644
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
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		err =3D otto_emdio_probe_one(dev, priv, child);
 		if (err)
 			return err;
=2D-=20
2.55.0

