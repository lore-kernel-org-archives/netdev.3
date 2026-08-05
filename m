Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B63CF1F2
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952166; cv=none; b=IMNqJHSs22ONjzQZd7P1kXUlPAWolQ3dHKTcvlIu0bsNciHIFtIbBDqX41roQWBsTLnh8QnNtip9h9vUIJmCClAm/rS63bL/UGW9V+Rx6vDZhqxRk3R14WCaDqJ+wM8qq2bZTReh170qiGYfTFrflGADvGzBCS+Frg9FHBdGPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952166; c=relaxed/simple;
	bh=X5btDcfQTdSHcpvlsmHeLvFsZZ7Fot+driL4QSWR/S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WE1LKEA2gI4eZ7Ujy/lN7rmg0GYPKxFpGc3cHwhLl7b8Zu9k61dSluE9uuEBcdelu43wMPSP5LtWYSdBc9yRxE1t7ptuhHc28MnzkukazOuv8vsQ6/ympVHVVyls0TqhwYA5XCac13bhSfNc13gjA45EPHt07pnHodHuy+zKtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+acojAo; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+acojAo"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43b7e186a0cso472926fac.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785952164; x=1786556964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNdkQ7aeXS5MjicAGAJeJZ2Ggh2c8nR9nvPFAS2N1c8=;
        b=Y+acojAor+hsyzhnx5PUipQaOk8Spjy42Z38oRQxRawJ+d3a89RdkO3H6WOBA/dHmx
         S9W9WTqz2qx/6gYNsFq2BrHImbpKFybzE9r4WPbtG2UWDtK6337jnxWdRsDXOLz0/iC2
         SPtKuym/NDpLZ3SzkpAWdWESZP1UCjNxu6cXaaj5teYsPyrwxdK0g7Vr9tVQJG2oUuX1
         quHsluiVvS5V4wapN1c1YOrua7wic4IHthZX+CeEVjTOCzJzM8ZOqG8qDDoV3ebUOBUN
         xkxXnAG1YRS7DN11hSkraNrJsUMxPZp0us/L2RbCfdLh8YuHEQh/Bw3iJWzVEi+KucNO
         SVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952164; x=1786556964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNdkQ7aeXS5MjicAGAJeJZ2Ggh2c8nR9nvPFAS2N1c8=;
        b=GK0ZO2zeFmnZAYZhTqPvETN/6ioPrEZGU4srow8SH4pN/viCdiOM54LqX4tNN7EIst
         lZ8AC4PduYAE5ejnyZtqBRl5DHnHiwPQd95mlEtPBISVRKPom0AgtElo/TZXqcgwd8b7
         Ece7LA3nYKuf50X+/dP+HZJzfOxrCo8CW1U0GSxLD9Rdx7Ty+R4O6PoM1vMAojWONmoP
         6PH7898xMaztA9gPi7HhUMQ+Y4F3J6DhOVDm3Z84Oa8HsdcUYQpTnHs5RvkzVxPknCX0
         l6HRdtgbCkJwIR41j58aPKwqk2I/s8hxjCrlTiivugr3phlflwCY5nMnprLHIh2hZOPl
         FSJw==
X-Gm-Message-State: AOJu0YxLl7PW3LZVYf3oo4VMP0bMnW9c3nj38SXRgeYBY9hV4v4QO8EH
	x0VIouZUWQEohyWKLN4xpfq/AxqOr1r7hkQw7NwFYRwhZezrejB7I11I
X-Gm-Gg: AR+sD128b/7sdoZ1vwNW/3MuesnjXqdNrkNi1fGn6zfIYUHxyu8INH4CY05v2qXEkW/
	nVnFnnMTT9bnAe/US+mqRAyMEz/QeP/xcP9z/3tEQeMFvyZHqxTNI12r03thaOCVtg4JF9UcHDu
	E/YEDqEC2cb9k86ZcQ/VBre7Ms1RsoFvq/Bp9rbtHyvFRd38qVgTFXXbzhVHRUpepGmxOXvwjXo
	L0HnJ8Ux1iqxR5JnWkPBv/SbP789K2CnW3Xw2KWoj58N+Ho42ZeyOzNEjkZ/vdU74xa0AIePzbo
	EUH9WAV0hhX61bBgs7ftsvm+TNGRGn/9U3OBuYNZEuRavxne5a67l/5odG3YjpCXMrqSC3aJvSy
	Jqoup/HboAVy2Pmt24yh+7tDd9aQkm/3PqkfrpW9g0ebxTCzpf6Xpi02nAqzr585Y34pjgRArjO
	H6p7XNhSRddI72vpaYFtceLo/9iTOTzzg87F5nzhy5ucOMquH0blBYSYF9D4nW8b31Nlg1o4kjh
	kxVLNEHiZhbV+NL1YrHZcq4csFsR8S7RfsVKleIYVhcjMwnEg/6M1jMzGCa/AMmw3jYii9Ia3h2
	ofy1Ek/UBLsUdsQezM65Jv5+nHnOlgEU2pbqaTRU0dos/7Feq+F/FnZ6IG/xVF8WkIVVpwNViep
	bT2Bb7MdAY65ku/Rw
X-Received: by 2002:a05:6870:a40c:b0:456:3973:5a89 with SMTP id 586e51a60fabf-4599eda5c51mr4077499fac.8.1785952163618;
        Wed, 05 Aug 2026 10:49:23 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599dd615ecsm3281704fac.0.2026.08.05.10.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:49:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 05 Aug 2026 11:49:12 -0600
Subject: [PATCH net-next v3 1/4] net: phy: cache MDIO bus owner before
 dropping PHY reference
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-submit-mdio-of-dynamic-v2-v3-1-16f3cc893b0e@gmail.com>
References: <20260805-submit-mdio-of-dynamic-v2-v3-0-16f3cc893b0e@gmail.com>
In-Reply-To: <20260805-submit-mdio-of-dynamic-v2-v3-0-16f3cc893b0e@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

phy_attach_direct() and phy_detach() cache the MDIO bus pointer, drop their
PHY device reference, and then read bus->owner. If the put releases the PHY
during concurrent teardown, the cached pointer does not itself keep the
parent bus alive.

Cache the module pointer before dropping the PHY reference. The existing
module reference protects the cached pointer whenever the MDIO bus and
network device have different owners.

Fixes: ec988ad78ed6 ("phy: Don't increment MDIO bus refcount unless it's a different owner")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phy_device.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..d65f28dd5773 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1752,7 +1752,7 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		      u32 flags, phy_interface_t interface)
 {
-	struct mii_bus *bus = phydev->mdio.bus;
+	struct module *bus_owner = phydev->mdio.bus->owner;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
 	int err;
@@ -1764,7 +1764,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 */
 	if (dev)
 		ndev_owner = dev->dev.parent->driver->owner;
-	if (ndev_owner != bus->owner && !try_module_get(bus->owner)) {
+	if (ndev_owner != bus_owner && !try_module_get(bus_owner)) {
 		phydev_err(phydev, "failed to get the bus module\n");
 		return -EIO;
 	}
@@ -1900,8 +1900,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	d->driver = NULL;
 error_put_device:
 	put_device(d);
-	if (ndev_owner != bus->owner)
-		module_put(bus->owner);
+	if (ndev_owner != bus_owner)
+		module_put(bus_owner);
 	return err;
 }
 EXPORT_SYMBOL(phy_attach_direct);
@@ -1917,6 +1917,7 @@ void phy_detach(struct phy_device *phydev)
 {
 	struct net_device *dev = phydev->attached_dev;
 	struct module *ndev_owner = NULL;
+	struct module *bus_owner;
 	struct mii_bus *bus;
 
 	if (phydev->devlink) {
@@ -1972,17 +1973,15 @@ void phy_detach(struct phy_device *phydev)
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
 
-	/*
-	 * The phydev might go away on the put_device() below, so avoid
-	 * a use-after-free bug by reading the underlying bus first.
-	 */
+	/* The PHY and its parent bus may be released by put_device() below. */
 	bus = phydev->mdio.bus;
+	bus_owner = bus->owner;
 
 	put_device(&phydev->mdio.dev);
 	if (dev)
 		ndev_owner = dev->dev.parent->driver->owner;
-	if (ndev_owner != bus->owner)
-		module_put(bus->owner);
+	if (ndev_owner != bus_owner)
+		module_put(bus_owner);
 }
 EXPORT_SYMBOL(phy_detach);
 

-- 
2.53.0

