Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E04A0135;
	Thu,  3 Sep 2026 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438122; cv=none; b=pNxTk0aiPMCEy0/O9hr/oQI3CfBMHoJBqUJSIBynJwGfIQaVxEsd9mF1X8taD68OsDVmLHoDUsN72zfcH7vdRE8/IlbfKxzamuUaY5uq8zfF2GQ/HA4TwCxE95zNFCJ2YdGj0NnGYetC08VSdOOyuw+B/HINlSC/Sd1nLJT5F58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438122; c=relaxed/simple;
	bh=98BtpwOrfxkyCIOn6gpz7djvGdoHy1Kdi5XFUej2Qjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwJXB+d/vQxJaREqDUL8WjHFEilsv13Nem96oRHAsSPAwfGhoHeeMSSgGnye5UWf1o04nNHZR3sSIcJMNRpZ687Kztep7Ih9xPgO8TO7pTIDnnLiu/pUDUyx8hEBotz0KycfeDA3jKVw9hADGIf5AXMci/SFTRvkzy8h/LErzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Ou+BtGzu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Ou+BtGzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788438095; x=1789042895;
	i=markus.stockhausen@gmx.de;
	bh=ce3bfDLo0EOu7kNRcMVWNeGgEbSQIjqzOvpap0Kufuo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ou+BtGzug/IzR4vn6JW/aVdbj4hePfnoC63uVwAhEkiYUJlQg+B+MM538SSiW+gm
	 eEXUJeWZmSMTZWGA8mCzs8RMXgjGyAx5tLPZPJ1f09vG6uLnKnu/r0T89Kq5kkSat
	 YzOKsd4s3kPCCSnvvZhe0Q95A2MFNuXQcLOvTbx+cAqt8jEdnEutxCWBB57IQ/Puz
	 wum5yOp76+AfZIKIhuwWfBthfh4cQQPKHvhEoAY1MVjoLlysRbx66ApFDeF2r9JSq
	 htU8Rmk3bQbJA1gcAH/JcCnVdvphWJSN+UvftOHp+fKAC+GV/bWjm6hRrO4B3Nlll
	 a3Wr4KtDyYu+40Gvew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGi9-1xSfin3HXv-00SA4o; Thu, 03
 Sep 2026 14:21:34 +0200
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
Subject: [PATCH net-next 2/3] net: mdio: realtek-rtl9300: Convert "fwnode" left-overs to "of"
Date: Thu,  3 Sep 2026 14:21:18 +0200
Message-ID: <20260903122119.2638354-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
References: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yRxujvxOPYJ4qiUz35bgiyRB45XR0ZJDri9Lhg9f2FuZM1jvaiq
 AQ7te3UeTxDfFoxPx2/m/dsf3rV+x7Zw1mSEdRkiMnw277YlWMYCpG9yM3tw31hQvqmOPRH
 mx9kEhiBMZv68fsYPrym9YjMIfv6UPPF17j3GW46Cikfmsu4yJwcOQmJLriWDkAzhD17FP/
 PYS3iUyT7vCn4n1LcVbLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mSBnjjkMrhQ=;N4wQWa7f9Lck/QRrE1RrIQDlAfn
 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
 q6qkVgd5yai38rDP6NXLX6m

The latest developments of the MDIO driver consistently used the
"of" API. Convert the remaining "fwnode" left-overs too.

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

