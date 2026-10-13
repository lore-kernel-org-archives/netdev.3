Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8E51CF48
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904332; cv=none; b=T+nWnjeN+aO4h1aOvAxQbdpaz2Y7qYoK0R8WnCGZs0ELrl1Nl9zc/NURlcwTl8l6OScytS3vQFcFSjVUwCNU5GsjAV2MakvGF8/FKVEVcRLuYaE3d0JWAw74qgUxVDnw7uA8Fyfh5Yng0mHdA53Tz9CHdQe3zGxvmsVgG7vKtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904332; c=relaxed/simple;
	bh=EVXhf/251b4NIBgQRUFklW9xbqpwNhk58Cr/HQKAyXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqruixMT0OujZqDZDoLQ2pNP59UN9lfWhWkd1qNO7wSR+yJd4CrlEuxR0AQqbcv41is0/mX5Wf4uNelak4upD94pXIkP2QXhn4NN/tBIJjvC5yyEQhZMT1HNn4NbfYG/92tLzBLIepuvMoLblZeKqIhgPERIlU6Tx737Hk0ba9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=VUXjSpY6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="VUXjSpY6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so24918895e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791904329; x=1792509129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rL36bL0UCkmFJxYVj2cYf5qsdJ2CfrKyBeqpQMOoRRo=;
        b=VUXjSpY628skhdAKNugB5l/SAPF97NeXdkNNppgunByp2vtJnN/KeB2nSJbWh4hd/L
         ZXJyy8Dn2fech4fgeb9MqgeG0WWvS6HFb4m8qbIN1J5RCz9VH/qXkF/NO8+zfdR+SXN1
         PtzCDXC0w5pefidpj0XBXey0WgSm21jztqCLt5Pfg0ibxrMgVQIfOrTcOgS5adnyy5AT
         kJ4Z8p+CNlYMp+6bqYS9/LSomG8UPKdT9fBjHWBJRcxs8MxMQMr9hGvpk08V1M2UkPPT
         ukT4DXJLnao5YMJnkqNw6zArovHRf+Q57s2MGlML6fKC+1nyvflfbiVOYOG7b/F+PpXc
         v9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904329; x=1792509129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rL36bL0UCkmFJxYVj2cYf5qsdJ2CfrKyBeqpQMOoRRo=;
        b=1D2WvDuDc8ObecvCYHKxD/OyOrZMGh938ycLMQ2psNR6vIAp6V/jWilG7+AejtFlft
         lyDpzpRwl9lFP0qNoNjnm129aeUhNUX3wmVUiilRCB2/sfy+gmSk8a7Bek9n+gMHXrR8
         B2Naw2VfoU1Y8s8RDm8MwfeZJWWLpRlyTWdE9Zjc5UaIjBzBuOelW580b1Y8YNh4Z7s+
         lCX+iubOjdp1LmJJnlJSKBsxcdjvy4iPAAxcOSoDdQixLCw7YH80z/fDGgv25/6U4P9J
         C8RwF16u2yt0BKrGq9m24SYxWo+ghpCS7DxdfZZUdVQ/uFwRKp9LWT5fmQVIn5KlGqco
         Q65g==
X-Forwarded-Encrypted: i=1; AKwUvBy9u4Ii9fyJqtbOZpCXdETf8jceyBGDuqNh+tfBHUoRk3Hjx/0At7JMV2RH/5tw3YwkyobLtxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPRAEKhTeQXXnSsTpdt6aAjYK7y4NV4xIZDY3yXmfyJYxIUZ3I
	52Ktv5CDvr+W3jlIgh2iO5IPKzNSezQVbEi37hNH9xaQLbMcgA6n3PoEE2zYUkHl8s0=
X-Gm-Gg: AYBFou1WJ6wTsXu3h3QLfQq2QAvVfg66gBSmFR7NzUFdHVY4ay0ZMjI/p6BVO4qO6ly
	PQuWk5BM4QDCexmU34upj/MCK8A6ALvARGXG8Ei7agni6Ut1XZcdfKe0qJASYqlH8krR+3vAWsz
	o03PtjLAxJ2dVsdQQNh4QB4jLmHId5WBEXm8UMjXIXfTOukNKQAVGAZkE4WZBMth1mpUm3AQYeV
	DKLm1wPpvodvz52wiUY+3iXy77Bk63GxNMrOmES/DIGQ34CNqumCWnKAdMIRRAiR7yzWOTnIAmB
	dl4peUwCQ1Ij1n9pqOADgZhHxvW4XmBChgav4FXNO351L8aOKYThw3+G5e6nMVmGJPYo4j9SQFI
	JGKylpS4W45BrbG5fyb5obIOE0MOJmayTiq1v0StSweK5vgwfIXYkON8+V6T2ZGddcOabFjxeXG
	jCfkx5whkixz4ns9cEpdntJoVT5qOtgXLE5Vmrhur0FB6ZoVkW6Wg=
X-Received: by 2002:a05:600c:1908:b0:49f:ce73:5e94 with SMTP id 5b1f17b1804b1-4a18e4dd018mr251293265e9.34.1791904328792;
        Tue, 13 Oct 2026 08:12:08 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf31b83sm380812595e9.12.2026.10.13.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:12:08 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v6 2/2] net: phy: put the driver module the attach took
Date: Tue, 13 Oct 2026 18:12:00 +0300
Message-ID: <20261013151200.2473464-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013151200.2473464-1-f@lex.la>
References: <20261013151200.2473464-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_attach_direct() pins the PHY driver module through d->driver, and
phy_detach() releases it by reading d->driver again. Unbinding the PHY
driver while the PHY is attached clears that pointer, so a detach that
runs while the driver is still unbound skips the put and the module can
no longer be unloaded; if a different driver binds in between, the put
lands on a module that was never pinned. The NULL test added by
commit c2b727df7caa ("net: phy: Avoid NPD upon phy_detach() when driver
is unbound") avoids the oops but skips the put.

Found by reading phy_detach() while chasing a PHY driver unbind race on
a Keenetic KN-1012 (MT7981, air_en8811h built as a module). The leak
itself was not observed there: unbinding air_en8811h under the attached
lan4 DSA port and then unbinding the switch faults earlier on that
board, in phy_free_interrupt() or under phy_stop(), before
phy_detach() gets to the put.

Remember which module was pinned and release that one.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
v6: dropped the Fixes tag, added Andrew's Reviewed-by.

 drivers/net/phy/phy_device.c | 12 ++++++++----
 include/linux/phy.h          |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6bc9cdb7fa69..68691c487eee 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1728,8 +1728,8 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 	phydev->phy_link_change = NULL;
 	phydev->phylink = NULL;
 
-	if (phydev->mdio.dev.driver)
-		module_put(phydev->mdio.dev.driver->owner);
+	module_put(phydev->drv_owner);
+	phydev->drv_owner = NULL;
 
 	/* If the device had no specific driver before (i.e. - it
 	 * was using the generic driver), we unbind the device
@@ -1794,6 +1794,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct mii_bus *bus = phydev->mdio.bus;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
+	struct module *drv_owner;
 	int irq = phydev->irq;
 	int err;
 
@@ -1830,11 +1831,13 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		phydev->is_genphy_driven = 1;
 	}
 
-	if (!try_module_get(d->driver->owner)) {
+	drv_owner = d->driver->owner;
+	if (!try_module_get(drv_owner)) {
 		phydev_err(phydev, "failed to get the device driver module\n");
 		err = -EIO;
 		goto error_put_device;
 	}
+	phydev->drv_owner = drv_owner;
 
 	if (phydev->is_genphy_driven) {
 		err = d->driver->probe(d);
@@ -1942,7 +1945,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	return err;
 
 error_module_put:
-	module_put(d->driver->owner);
+	module_put(phydev->drv_owner);
+	phydev->drv_owner = NULL;
 	phydev->irq = irq;
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c5098a0dd6c..a5a419bc400e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -578,6 +578,7 @@ struct phy_oatc14_sqi_capability {
  *
  * @mdio: MDIO bus this PHY is on
  * @drv: Pointer to the driver for this PHY instance
+ * @drv_owner: Driver module phy_attach_direct() took a reference on
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
  * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
@@ -689,6 +690,7 @@ struct phy_device {
 	/* Information about the PHY type */
 	/* And management functions */
 	const struct phy_driver *drv;
+	struct module *drv_owner;
 
 	struct device_link *devlink;
 
-- 
2.53.0

