Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AB556BB6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083208; cv=none; b=hFK9V845iHzVaGSvHWS8/ISCKWHNSCUk5fpXVhXOeV6/Ky8PDAa5S8qUDLlCpXghpweoFLCyZen9gAlQpwAeTA/T3mlUu18KTGqpZ3t3sgUbzl0HKGWCxv4EtFJB4bIy7sTMWwrWcSBJvUpGDTOX4IPxP264Hjr5aGWnGOyVIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083208; c=relaxed/simple;
	bh=Sgp77iYbLIi+6Rz08RYYMpSvbU+J3sLsxaKpfNa+/AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtVXsQeLC0cm8HH/FlhdN1v//ivgOlVXe4Q04Vzu//z+cDp+wDi/dervc+rLMQrhBjclGxXrgZDx301NjRjKkckPh7kVcHQcNF2fYXWqtOd7OHx7gmHLZEK3EhSHHOYLG4dj4fQ4ob680qWyPNB9wCRPNamck5OE8/WxlA3jQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=B0kAQczk; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="B0kAQczk"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so2814719f8f.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790083204; x=1790688004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzOBEh/e/FQTnUBYv6JcL5S3LbvXz87hjn6nnrCmcuo=;
        b=B0kAQczkt4MnvF3N/Ax0VYDUdL7f12dSVBWJp46XG3nyq/d563WIJBbeuEKEHXLVjn
         kn0Ttkwxloc4LNcL9var4Tjh1SBHtyLDf0luNo382KPeNmJPDqrp0nuMQhiX0+RZpNsl
         ffOmhRvw+0ClxxioQrhHjNCW/eO+XOaM59Qs60fSTz5xGbdxSY8jA9DLNyVPpabc+VIb
         kNzDiZ8e/IfEhMbjqdh/70txA7FeOoyO/h/Amz0bdrS6Tt3y7b0fxviQJgmxmU+4jpwz
         jTiuN9KJMk03kEBf4GnSLQzWLzS8EHZF3sH3AORXezORVBfgHmFefcE5t3qk6bViyR0r
         jtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083204; x=1790688004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzOBEh/e/FQTnUBYv6JcL5S3LbvXz87hjn6nnrCmcuo=;
        b=xbmsn8ECwut1GA8v7E9Sb3reTdofRWtCew07wWYqt/UHeQSIgdyLW8nNByzZ9EXldR
         EhzKKV87xBLhJWqouvKzBX9v9sPsyIKeDFnCpJI+kFOY0JYxRmLRy6YH2CRCCRyP/+MH
         sOsyLUoKdXxL4nfeZuCyd6OdRlKCRwZC2KAiT87ysdz+jngLEoKNeJ/qtAIcCvK8lUSG
         3lNxeaZzz07SM7GTMbGh8VM2MtUJdyJVtnioyWSDK6Z4wo39JdBJeazdwadKT87zEjes
         YrBV5AJA5otnKDa7VJoBNM4lXjo+XadSn05745x+RflplWC8VUEufPYMojcyktyxzea9
         3SGQ==
X-Gm-Message-State: AFuF++kfLpJXd6QsUueoksKv+mVbRZjk/teaoR9N28PgeFVaIKTPJLzU
	Rz5eUhMkdsaTQ327G/H42K0RIie6YBbMPtVGDW3BG8nunEOL1KshvGhZRfkfIi/yTRMoMsVkIz6
	9uWqnYkTjWB4D
X-Gm-Gg: AYBFou2uihKjMHfetdBBRfr6VN87RqiYYkbxXb5CRX2nKAimar4cYOQJftvIn8xjgMB
	47EicwU+Ps4WBbaewEL4eyMSltYQX4X4C0q72QLSSF/qytdpfEcNgJDMfoLjyG7RR5UA0hbJFbj
	70nxm5SLf+z5nbASGJc2IlF809XB19Q+DST5mLwRG2FeeeMZC2E87MsDcLKRxk9/o/VFgJkCJeG
	xullqA0xKbE9sEze6fbaQEQ64+X4fRHKOFRB24q3M6sS6GEFkV6qnZpNaPPtYf/cGRVjFwyRa+L
	c8yev6z+wkTbeBrgLAnObxYP0IqJUkYLXfGA7WMvbcJM0SXhokQ8qv1OGQsCZHYnNK7ZAsLXSBl
	+hHN4RcR80W8yyBDBlrAFlcv+aCU87sjO5Vo7lsY47W3to4P7iLTxZiCOIgytUtl+yezsg8zAEb
	dY/AOYznKgKhRmvC/4fGSu6Ssr7SsqJS3AsrerQSmynfOMx93esYgGWwI1X3bx
X-Received: by 2002:a5d:64e6:0:b0:487:27f9:83b with SMTP id ffacd0b85a97d-48727f90bbfmr16658287f8f.48.1790083204353;
        Tue, 22 Sep 2026 06:20:04 -0700 (PDT)
Received: from remote-01 ([84.17.55.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627929a4sm4085220f8f.35.2026.09.22.06.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:20:03 -0700 (PDT)
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
Subject: [PATCH net v10 2/4] net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
Date: Tue, 22 Sep 2026 16:19:53 +0300
Message-ID: <20260922131955.4175785-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922131955.4175785-1-f@lex.la>
References: <20260922131955.4175785-1-f@lex.la>
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

The bus is the one this function is about to register, so put the number
in its table first and let the scan seed the PHY from there. The whole
table gets it: with an external PHY the address is not known until the
scan, and with the internal one phy_mask has already left a single
reachable entry, so a loop costs less than a branch on which case this
is.

Found going through the drivers that keep a PHY interrupt outside the
bus table, so that the restore on detach later in this series has a
number to hand back here as well.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Compile-tested only; I have no LAN95xx device.
    
    No Fixes: tag, for the same reason as patch 1: the write has no reader until
    patch 3 lands.
    
    The mapping is created before mdiobus_alloc(), so the number is in hand
    where the table is filled, and mdiobus_alloc_size() is the only thing in the
    tree that writes PHY_POLL into that table - a fill placed after the alloc
    and before mdiobus_register() is not undone by the scan. The fill covers the
    whole table because the external-PHY case leaves the address to
    phy_find_first() afterwards; on the internal path phy_mask has already
    reduced it to one entry.
    
    Teardown order keeps the number live for as long as it is read:
    smsc95xx_unbind() disconnects the PHY before it disposes the interrupt
    mapping.

 drivers/net/usb/smsc95xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 42e4048b574b..b629092b94c2 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1147,8 +1147,8 @@ static void smsc95xx_handle_link_change(struct net_device *net)
 static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct smsc95xx_priv *pdata;
+	int ret, phy_irq, i;
 	char usb_path[64];
-	int ret, phy_irq;
 	u32 val;
 
 	ret = usbnet_get_endpoints(dev, intf);
@@ -1239,6 +1239,9 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	snprintf(pdata->mdiobus->id, ARRAY_SIZE(pdata->mdiobus->id),
 		 "usb-%03d:%03d", dev->udev->bus->busnum, dev->udev->devnum);
 
+	for (i = 0; i < PHY_MAX_ADDR; i++)
+		pdata->mdiobus->irq[i] = phy_irq;
+
 	ret = mdiobus_register(pdata->mdiobus);
 	if (ret) {
 		netdev_err(dev->net, "Could not register MDIO bus\n");
@@ -1252,7 +1255,6 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		goto unregister_mdio;
 	}
 
-	pdata->phydev->irq = phy_irq;
 	pdata->phydev->is_internal = pdata->is_internal_phy;
 
 	/* detect device revision as different features may be available */
-- 
2.53.0

