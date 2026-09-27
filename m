Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73143CEDD
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553465; cv=none; b=tHPpDM98EtcTqAWsZJfies22PwAkZFxne2sZmhnIE/Qm6ggyciHmasrilwJNi5puyJJkXIKfvtP534a+E3OEjyg0BsgTiVhNjr150n+yzWYvPRq4JKFvyu3neGSNkv2BTA9mnKJTV7thaXcW3fjMa2pZYR+DSK9hReFvy796Zmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553465; c=relaxed/simple;
	bh=Q2MBoFUHV/smTZZWOcBAdjojsve64nf3Mj4LdcOfrm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q71a2l2msPNasDjKtNEBdenQ403Rp58YRrppzRyRu2aQqXjgGroI5bH5pYdxrTCQwz8e+K19gkPAUKyEP1Lud/CZd4wZz7fEw8bPKCcG+H+JXrtAKYPWXFMjGnaKIcM+h+MP6mC7qlCroxYpnO5j7IgizNkme2JjWLSzXoMDe30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=L2L49zvd; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="L2L49zvd"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso17420405e9.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790553461; x=1791158261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mUPVIFEve71ZMNF6KJowk+Nf2/oAe4+dmXwALOSfNI=;
        b=L2L49zvd4UsnUVQuUR1SX2YqDT6A361lRAdMI46Y7DmufnOOl6x70jdBpWiM2m7JWR
         sJswNYGNZdugKyccJT1LKX2di3Rk6wpKfa+LoZrX8pjpEAS73NoT/bLKPjThlkf+mx2Q
         7VCxdPDLchHDsjwGWmw22ZoVbP1r53Oya0HJJEOBt9Mbz5NVTOatRZ3Kz22rbZEQm0FX
         Az7pjT333yOiTMRlIHRz6l7cKe6AKzQis6h3y9p+G7LWMj5YUhvy/8a/Rt89pOqkeePD
         x2oKC328eeAwphSWc6kBz57n7aqM6OcQzbuTrfu84da2hGrE1oR8tjhtqWlxEUz1D4Eq
         2nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790553461; x=1791158261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3mUPVIFEve71ZMNF6KJowk+Nf2/oAe4+dmXwALOSfNI=;
        b=cfyyIX2a2A9Zs0E7kSTCxmNGH3DEFcQQbDP8z1SgZFRMW37u72fOJKz9tUtiKQH398
         4cH0fF+eSRW3HuWP/baFOKamT0hXZi5JWAnX50fc7C+XthdygysZmmQA0B6m741/tITY
         2AVGO848q+3I5eplR4l6l5iBor+6FUIgoNxRvJhrRC82ftYujdkCRrbr8mEMtHMzGXov
         DhYqJEcU3xvrS4+WvdCPpndfKFBxIUN+bqkL/ImQd/o8aOPZzJzKj9CvjD8FeF9Cw1C6
         Xuh1GxfjWzalOgJF1cS/EjENK1CUglGUzUXVCVr9oPqQTb2sQxCj57Cj+fZBRADhzs7y
         /XeA==
X-Gm-Message-State: AFuF++meGCnOeBThWVyizNdheYhUK3EGTCU+ZJEnI6PCLROUvIyiUCPC
	jFaAqC5hd/xxCfimQnqrwUiGDztvkinktLqMaFfh9+zeYewtC340zer4tzn1O7gKM33jqkJvEaQ
	CEWxbVe2r1SoD
X-Gm-Gg: AYBFou2ONipkiX7loEAL12+1FFlciGRX0hJICYiuQTlNhRUQZL0/EYek3UFCcZgxg57
	CFqWGrQlJcVt7++gzNMXGq/zuzYfIqT6fiGDDeczC6gh75V5GvVHbrsIdqfQq2dbNM+FHRBG3BS
	dvieCW6lLZZRb+NZTpxeiTYfxOGu68w1hkaaHZaLz0RllFC5xwQoU+rOoh3KDkx134N4NBIqdw7
	CSSJrishewslP5TtyZiyzayctBMDC6W11o+uPYrWFLViIC3DnQC5xNp9UyWb8oKo3mxw95cZeVx
	vRCQR6Td1ZV0wiENdnC3ICQ0pWsx07G78jiurE0oFSchbxtx4Uwk7xxU/uOBu/Pd2uGo+nhYAgE
	POtLvAsZaQ995O6HKEIF+yzZDuOddiT7EC3zMKgo3FD56A315u9UwL/ghJ+Ikgh9GOY1gxArCFL
	5ITF7fHTQcSFi8MBzc7XXJjI/jEJbcon+wSWjK5FEkRTZs8OobvA==
X-Received: by 2002:a05:600d:d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-49fe7726ee3mr175937705e9.32.1790553460961;
        Sun, 27 Sep 2026 16:57:40 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017998dbsm137971495e9.14.2026.09.27.16.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:57:40 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	f.fainelli@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v12 1/4] net: usb: lan78xx: register the PHY interrupt with the MDIO bus
Date: Mon, 28 Sep 2026 02:57:30 +0300
Message-ID: <20260927235733.2619081-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927235733.2619081-1-f@lex.la>
References: <20260927235733.2619081-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt this driver maps for its PHY is written only into
phydev->irq, while the bus table mdiobus->irq[] keeps reading PHY_POLL
for the same address. That table is where phylib records what the bus
described - phy_device_create() seeds phydev->irq from it - so the
number lives only as long as nothing else writes that one field.

Put it in the table before the bus is registered, so that the PHY the
scan creates is born with the number, and drop the write to phydev->irq
that phylib then makes by itself. Fill the whole table rather than one
entry: for 7801 the address is not known until the scan, and for the
other two phy_mask leaves only address 1 readable, so a loop costs less
than a second switch on the chip id. A devicetree PHY node that
describes an interrupt now overrides that, where the driver's number
used to win.

Found going through the drivers that keep a PHY interrupt outside the
bus table, so that the restore on detach later in this series has a
number to hand back here as well.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    v12: no change.
    
    Compile-tested only; I have no LAN78xx device. No Fixes: tag, since
    nothing reads the bus table back until patch 3.

 drivers/net/usb/lan78xx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..522fb4daeb46 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2092,6 +2092,7 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 {
 	struct device_node *node;
 	int ret;
+	int i;
 
 	dev->mdiobus = mdiobus_alloc();
 	if (!dev->mdiobus) {
@@ -2118,6 +2119,10 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 		break;
 	}
 
+	if (dev->domain_data.phyirq > 0)
+		for (i = 0; i < PHY_MAX_ADDR; i++)
+			dev->mdiobus->irq[i] = dev->domain_data.phyirq;
+
 	node = of_get_child_by_name(dev->udev->dev.of_node, "mdio");
 	ret = of_mdiobus_register(dev->mdiobus, node);
 	of_node_put(node);
@@ -2892,13 +2897,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		return 0;
 	}
 
-	/* if phyirq is not set, use polling mode in phylib */
-	if (dev->domain_data.phyirq > 0)
-		phydev->irq = dev->domain_data.phyirq;
-	else
-		phydev->irq = PHY_POLL;
-	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
-
 	ret = phylink_connect_phy(dev->phylink, phydev);
 	if (ret) {
 		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
-- 
2.53.0

