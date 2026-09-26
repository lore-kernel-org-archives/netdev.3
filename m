Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0F39A7F4
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466635; cv=none; b=B/alhpTaysJgzn/+Eh6v+XQkcR5pH8zANVhLiARUurIwxxxICYZooAeKInQNU88lui+qwBcTg/g4NvdO/DfmEl3pOOzYXXL7Ww/WW2s0c5G6XAzmvpXPX2O4gVU9fK339clOlMW5HbNzy0Mx6dCW4DHcIEd0lFeexaowmrUI6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466635; c=relaxed/simple;
	bh=8jMU1Dl9hhLUv5U752LLGbRGkvb/y7qgoM5KbktG3Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgU5diNfLC63YcDHbSSTi7PsMycvepJD+XLcApVQiu+UMmT3xo6POcpoJ7O5ozV4WNQQiqQ0XfgaVFO6n9Oclxp5uQvI9i1NnnBLsSU4L6izk+XP3o9qypO4Mf1zwWhBy9muRdy9+X/FbSZo+SUM9g7vxgF5ljJr9IEhvyf2Ans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=J4/gq92E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="J4/gq92E"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-488885c3844so424389f8f.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790466632; x=1791071432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qteUU/69D9osiNFS2h08w3Fe+zYvU7Pt0cpz1kBDxMs=;
        b=J4/gq92ESeBShUeKplDKIX7kq5OUYXq5aCUoLrOTl/VxYi2klkbyZ+YrBJZjVbau3g
         zhNEVPWPFjjKtTJn+K3Uje7JupA0Mme11hFUuGBWje7OYlvCP8KUaV1SRQM762fZTIxQ
         qXSbjW3R7HbLUJeSBpS+yPXxWEikBxPh+34y9dVqU5N7oxve5D/fO1JkVy1k8tGunxSd
         kGcJunyyjNtjfoK35lpuxfWlhiZw4YtRtQhF55/cJv2MnVrUvi2VnW0SGqVitUt/FoxW
         VtMv597Bww8Zjnb5k29O5tUl+gyBsQeumUJgjvXqn8ZSIxZ4ekgWsmSs1J81/cbxVQs8
         d3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790466632; x=1791071432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qteUU/69D9osiNFS2h08w3Fe+zYvU7Pt0cpz1kBDxMs=;
        b=rV3XDbEPFHrdc6xcvR9dmXmzPh5o61uLRIkl7oB+G/VbxUqRG4+vFjTDTbRm11HIiR
         DxwfCnyKeVUQxHuEaPdJfOuawociyEsXnVA0HXg9wnU1KqNP0NTjNvW5oi0qszVvnj26
         oU32S7rM6SkE/1YFN3MpiOHeiMv36+0X/xWOz5ktLC6xTIB21RhDuVhDfkni+sDnIeOs
         erR/beSMXFToq+l0rmdKrJaz2Yh7fR2ETX/r0yektgUEy+sETQj8sKVy8xHgEtyX3R3I
         LRUk49YxbJdBlI2FPFELfTc6+JnzwzU2dP4NUD1tiFXG+TSBF+4TRXSNUxcMT6j5t2tO
         wYJQ==
X-Gm-Message-State: AFq9FYLBxvn50uatn8eAIC4V75kGfB1mQym2PJKvy0mJ2AARfCdKPnjF
	548v6rLgGu78CKODLLo14uRhiBHTJx8NbgGDs173yVlHy22NLQ7IBQ75aAen0k1sXpRgyxW7K9Q
	Uj8/IVAI7MA==
X-Gm-Gg: AYBFou11o1xOVhEvKpwPj5pjXZrxVTCfpO/hUjy+zzuel3fWHV1qMYvZUsDVKuDIirO
	IJ9GyhFKoTHT7LToKAgpSb7rnPYfJSC0xfajSrf1nYm9/wKi4Rv8urs5Mkk1tCUG6H+5QLiwGaM
	hOkvfRmZOz6VQbAvuzTHFAbKx+ui1GAjC8m963JQ89caYUxoZjYm0lstV1Cgf/43tQ0k+7kC7tW
	pSzCnV0nECVOYrqgRE3qyTPVZVjJBF+nt0ayjyaJdWNJ6DeRrLYUUoJbd+BbrRnHmEATfl7ereH
	wYtqVi/LnHZnOKbZn2vXQKIgU/hWq8cyV5JhFUAH8KFJXzEAhMbO4Mzsn1I2kxPYmOztDLspCDR
	UJ38aLglpr5wJyU92m4Qidj/Wg6y/ZzASw+b/07HspLN323EFQiIBL+GllUUxX7IUQCBfKc/HRS
	te9Azkdw4DWXTSEcVItldh96j+CuqifpqV8s5Vcz5LQygzZegwkgWtm7JtiS6e
X-Received: by 2002:a05:6000:25fb:b0:487:25:71c7 with SMTP id ffacd0b85a97d-488716b96cemr19111229f8f.12.1790466632023;
        Sat, 26 Sep 2026 16:50:32 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349fa1sm24716798f8f.8.2026.09.26.16.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:50:31 -0700 (PDT)
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
Subject: [PATCH net v11 1/4] net: usb: lan78xx: register the PHY interrupt with the MDIO bus
Date: Sun, 27 Sep 2026 02:50:21 +0300
Message-ID: <20260926235024.705646-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926235024.705646-1-f@lex.la>
References: <20260926235024.705646-1-f@lex.la>
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
    The fill covers the whole table because only the 7801 case leaves the
    address open until of_mdiobus_register() has scanned; 7800 and 7850 set
    phy_mask a few lines above, so every entry but address 1 is unreachable
    and writing them costs nothing.
    
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

