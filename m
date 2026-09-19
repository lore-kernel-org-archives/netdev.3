Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29A318EF6
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782816; cv=none; b=pnKYyfegm/n+VdPfQ7pkVNqFbRB8/8yCCAdb7GuKARRzn6ZqMsjJQ6qEst6ZmUnhofezqtpfTGVWDgg9T+7hrSbJvc7+Wc5HP7Ed6nI9hudJ8VVRu5N0lAg3ylHqDZEsPOhMJ91FKS3PLuI1XNyVMFNf4OnG1Rglobzgywpjgis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782816; c=relaxed/simple;
	bh=giD+lcuYcvUOW0A1k5R2q4BABOWv0dD6AJLYXkD489w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy42D4GpCwEL87lzv3Jk30tRYDojiHyY2kUrLNcfA2i5bH75VrUl7cf6tze5LIhGQz+OwJLDPFobfNgKtEE3rcT0a45QhELJmKloPIui8fduEV7w26dxfsI5dCvgDmqujuviSc0Wc/CzdLiyZ1NhYgFAUzN/TbruUUYqCm7wYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=D4X4YY0a; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="D4X4YY0a"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e2406so6233435e9.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789782813; x=1790387613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u74q8XrQmvKEeO+fs7iiC3X9khNmBcbrRJ1f4DsZFbg=;
        b=D4X4YY0aE30bI6BtMiPw/R6VHYOzR9wYNSTEotHzs2GSCgsA8QJHcJKHEU9NcBn4JM
         8ZqVNdKOaobe3zhZiGza29VZANgL07iwQixN0QG6iyXlokRRwOzqsg3wO4lLFWD0dxJu
         9D2ecjI0ZcaDYesMhC2Yoo68GI4GPixHOzuM3goDu5vzTyoV+jAH4331yhIfdB7a3vVa
         A9UZ9DmybSU4kwxZ7iclWZLOBU8FfH6m5rt8aHDqkmZA6CEuJ7wN9SXQTrfd6bmxn0nq
         KNyvi/vd4IV1A55k1T4ZFgMEvTYuijH3drn55aMtvYE6nhMQwSkwIEIopypYJOLWCSUI
         rpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782813; x=1790387613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u74q8XrQmvKEeO+fs7iiC3X9khNmBcbrRJ1f4DsZFbg=;
        b=zwnn9uABb88j42YlyKDTOOovM6KNfU896woeB7W09eQ0yGSoHeKsUgdpyuORj8STf2
         5PK8UhD9XDMdaKwU7fa9jeOZFTInIX4BRlQfOfyndNxsF5/HolEGTlGg7EQRL2Qf5WaS
         T44N1MYJN41kInQzFdqJYs0mU6yoVLT9xrT1tuBCyGV3yU6ctrgtH8XV90JyXCiVgjUF
         ddvPIE4wlbzSCa0D589XJ4tIyhbc4w1R4YxV48S6jz/7gqQzvRzJIBjzLq/0i+sk04yI
         36mAc2Ewhbpj5ECj6uAr2vxaM7QEgyPpYLaN+OLnaqloUZniTKpQczA881CuYMok116D
         k7+g==
X-Gm-Message-State: AFuF++l9ThXEyr/fNXwTE8Ii2hHevMh+1nWRHZUaWCZ6l2+BoWIF1nhV
	t6LzNrurYMRbffCHntFZqCfQO0FXn9LXDgGTYJaKUH/Lk/SI3bNyVjh+wHoKw3rd+2QbiZPrNpI
	JM/ahFVD6mZb8
X-Gm-Gg: AYBFou2f0kr1rtTIJT2xiCcshDVrsmEgMj9LPalPf/ruHnyxMdJ0Jv+PRb5RIZXQJOb
	VuuQDTZTBVxpnPnzBqHnLMG31dqRmr807pSge6u4AEMQRhKkec0Z272BJ1NyFIxneUgoKY748fJ
	Jo/ft+sVV8J9GKx603G2/Ow9A3+LBPec8fnMkLL0Giy65BxLoXdXelK1qA1qJYNjnphUnvTn/iS
	PbO4dkJ73z0BOT8TNwHlxXbQniGT1TFtcTa03FLOR+Rq9LJML39kStrdG/Enso7dADrsXkH/JLP
	f+++tV2wZ/SCv232uG5ZyKov2HGLqAWTyEFTLTxKaLRYsZCxmo3etYSEwSWQ/TdCTLxBzTKiBAz
	gCHqX3Zuwr5qwoG8lkXPNyYIUB8sMNBTv8LUAvdm36DgqhQJwP1Ys0cAygL8PM7RV7yqTfRYxyA
	yCW2Wc8MMsoUzwN5nR5Ep+E/escLEOByPL9qypEVL41dnaLnVfcg==
X-Received: by 2002:a05:600c:4714:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49fc4f72886mr64959255e9.2.1789782813417;
        Fri, 18 Sep 2026 18:53:33 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d174sm34946045e9.11.2026.09.18.18.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:53:33 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v9 1/4] net: usb: lan78xx: register the PHY interrupt with the MDIO bus
Date: Sat, 19 Sep 2026 04:53:23 +0300
Message-ID: <20260919015326.499479-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919015326.499479-1-f@lex.la>
References: <20260919015326.499479-1-f@lex.la>
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
that phylib then makes by itself. The address is not known that early,
so the whole table gets it. A devicetree PHY node still overrides that.

Found going through the drivers that keep a PHY interrupt outside the
bus table, so that the restore on detach later in this series has a
number to hand back here as well.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Compile-tested only; I have no LAN78xx device.
    
    No Fixes: tag on this one. On its own it fixes nothing - nothing reads the
    bus table back until patch 3 - which is also why it sorts ahead of that
    patch rather than after it.
    
    lan78xx_setup_irq_domain() runs before lan78xx_mdio_init() in
    lan78xx_bind(), so the number is already mapped where the table is filled.
    Which address the PHY answers on is not known until of_mdiobus_register()
    has scanned, hence the whole table; mdio-moxart.c fills its own the same
    way.
    
    The fill is a default rather than an override. For a PHY node that
    describes an interrupt, fwnode_mdiobus_phy_device_register() writes the
    devicetree number over the table entry, and into phydev->irq, once the
    device exists. That inverts the old order, where the driver's own number
    was written last and won. Neither in-tree lan78xx PHY node carries an
    interrupts property, so nothing in tree changes, but a devicetree that
    described one would now be believed.
    
    Teardown order keeps the number live for as long as it is read:
    lan78xx_disconnect() detaches the PHY through phylink_disconnect_phy(), and
    lan78xx_unbind() calls lan78xx_remove_irq_domain() only afterwards.

 drivers/net/usb/lan78xx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb782d81d84f..d7472d894c8d 100644
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

