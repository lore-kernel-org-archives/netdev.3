Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7724F55D8
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569167; cv=none; b=aYWLR+XMAn3DSkjGPw9rHrYiBhtI3OXavUxiupHthyfAZnPCqA6vzcrNRIKlONCfi6FJICQxwy2ABju+s9EtPD6g+QObLo8MghZX+Z4YoPUY2qLD2tOC6yo0kEIHVNfget6SgWdKZqM8DJfDsj0bvNxGbqbiEK2iHeTPCCpC1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569167; c=relaxed/simple;
	bh=/2Cv2xVv+v510R5T2qQe+0Ygj8mKsSPlin7yXitKkhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYFtVRre1rc36D/kNhVQqAOWdngTFuj1/atPHyIWWx7lO1+DFWYos/5Ql6w4f0zlGuj+J+/YGcWeyxqLFndEzHev6Sm5623xbZnoyqFGthqmunc+Kmiy8K8aLLkvit3p70SirzUxfMc38U6mtQWpnvXwlhJ8mntAbUoYmWsv15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=HAuJP/3T; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="HAuJP/3T"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so1132225e9.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791569163; x=1792173963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSXV2iOxwWqIUa1UIYTqzGUU/lK+07HjT1zCcdAooF8=;
        b=HAuJP/3TXWVFTGPOLjUVHHNoqoBqUaYRPMlL300bU/aIV+Y9kqPXJhWe2hFjpE5upn
         y4LrgV4j19ulAhFhRl2miwUJjQgQ9XWynpV8DAYodlT6i0bVWlN4Alq2751/2bL955eD
         qB7k5NelLuIx7reGvMOCokCQAxFbdP4B9bpRbsdy33mwNTtojAgk0gFN306lSbhW9cNr
         MAnlcYrzL+tWpVdRmpTV9FW6Aa/t/K6NMHCKagQC2Y4l1h12ibxoQk01rFwqS8xa8R71
         RHbLeY5UGAuyNqaX9thQmK6FYDXz3sy1uOoKTBrdSW/GHnP0aYykBbXeK88J3FBHAmQf
         KJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569163; x=1792173963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSXV2iOxwWqIUa1UIYTqzGUU/lK+07HjT1zCcdAooF8=;
        b=tSStyUWjFp9uw8WOKLSrCclz377dzNUJvn6SX/edHnlsdlSlEX9VUp9YNXD3iPzwQX
         IHz0EZa2sFrq4luyTgp0XnlTGcCeI+kCwJDkze8rC8DnnozG1wsMLTcKkU0KmSNGNHiq
         +eB6Np4+FWpjO4+gp4xmoPOBxoWOGCP0cxY2b9gWvDgzbdhL2V/EeRtCZ24qvqbGuWib
         a5RmJkgOsqJgucKd7zUbWlZ+jKA1mFIJV8qpR6FZp0NISEPBzm62yNqRMYznexr8h1Iq
         qimSwL8IhxqSH9k1Bi5ovp0ySuALNFCCgZGkk5dhdBAzkn69dpQJbY9UBT1OY4E78Uhq
         Yg+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzj0fz3DPNtS6CBxWzB6CzDMplX+m5ER5NKsxJFFeQDCZVZbS7lPPgMLU44dCMZlOXIY9XUqbw=@vger.kernel.org
X-Gm-Message-State: AFuF++ldI5uLlNI+xd+Deb5aaQt8Yi/s5zKupinQMtanUL6uCflVztyk
	njYD2BNj86hxoG73X7kyJbNn0M0Wy7qmZgOx+lJp/tBe0szVSa3vE9E9qIZQvLOVY4c=
X-Gm-Gg: AYBFou2jkmwsms3TQbeLtn1ybTEsjqeOjLPE+lSKF6IbFHiqt+J9Fdt1Gz0RzeLr2TI
	1hlC44+/4rm8hFQlguZ7Cw0An+gaYq8sGcjFxwE5VCXJBM50RiGVl6/ryZeHG7tQ9OiyEMsnopg
	IFMtivJFkmzrOjnNUbF0bmqXyla9PeEJcv5iCq/IHZEz5oBUeEd4UjJ9OnMjrKWU/w4shjBds3k
	PnJDNZLRl+nY3EjKdhpDHsQmtuw+R0s59PWnm2+iPr39kihfvpYkNVMqY1qx7aUoeIk/R9ET5as
	NhqzViN4Cnt6fW7+WZkFWzibluPLFAyWYel+YrgzGZwcLI3hNMZYb9Wtofg/pOPWunKz/Twdh1G
	cxkInxLXPDQTWVHguEEDl+/0g5sQEKPRgU4zl2ZwUydWEvTdGS931y3xPPIoHVGSC4yXFzbk1Zp
	D8aVIXLtrDrA9+dhyatcw5SBh746fKhNQmdgNT4NUEGdGJK5aXEg==
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a18e4adc5cmr52679585e9.16.1791569163383;
        Fri, 09 Oct 2026 11:06:03 -0700 (PDT)
Received: from remote-01 ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm118184915e9.8.2026.10.09.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:06:02 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/4] net: phy: serialise attach and detach with PHY driver bind and unbind
Date: Fri,  9 Oct 2026 21:05:49 +0300
Message-ID: <20261009180551.1234107-4-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009180551.1234107-1-f@lex.la>
References: <20261009180551.1234107-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_attach_direct() reads phydev->drv and d->driver with nothing held
against the driver core, then calls into the driver through
phy_init_hw() and phy_resume(). An unbind that runs during an attach
can remove the driver under it, and an attach that runs while a driver
is still probing can call config_init before the driver's probe has
finished.

Found on a Keenetic KN-1012 (MT7981) while testing how a port copes
with its PHY driver coming and going, on an OpenWrt 6.18 kernel.
Unbinding the wan PHY driver through sysfs while "ip link set wan up"
ran oopsed on the first attempt, with nothing added to widen the
window, inside the driver's own calibration code:

  Unable to handle kernel access to user memory outside uaccess
  routines at virtual address 0000000000000098
  Comm: ip
  Call trace:
   tx_amp_fill_result.isra.0+0x90/0x3a0 (P)
   mt798x_phy_calibration+0x164/0x520
   mt798x_phy_config_init+0x470/0x6f8
   phy_init_hw+0x64/0xa0
   phy_attach_direct+0x184/0x380
   phylink_fwnode_phy_connect+0x198/0x27c
   phylink_of_phy_connect+0x18/0x20
   mtk_open+0x38/0xb70
   __dev_open+0xf8/0x1e0

phy_remove() had cleared phydev->drv while config_init was running,
and the driver read phydev->drv->phy_id. No NULL test in phylib reaches
that dereference.

The device lock cannot be taken here: attach may run under rtnl, while
phy_probe() and phy_remove() take rtnl under the device lock, through
the SFP bus of a PHY with a cage and through the netdev LED trigger.
Add a per-PHY mutex and a flag saying that a driver has finished
probing and is not being removed. The driver-core callbacks take the
mutex only to flip the flag; attach and detach hold it while they call
into the driver. An attach that finds a driver bound but the flag clear
refuses with -EAGAIN; a MAC or switch that attaches from its own probe
then fails that probe rather than call into a half-probed driver. The
"already attached" test moves under the mutex too, so two attaches of
one PHY cannot both pass it. Detach clears phy_link_change and takes
the recorded module in one section under it, so an attach that passes
the test right after cannot lose its module reference to that detach.

phy_remove() clears the flag before any teardown, so the rest of it can
run without the mutex: an attach that loses the race is refused, and
one that wins holds the mutex until it is done with the driver. The
unbind then goes on to remove the driver from the PHY that attach just
attached; what the consumer does with it after that is not changed
here. The generic driver fallback is not covered either: attach binds
it without the device lock, so a real driver binding through the
driver core at the same moment can still collide with it.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes in v5:
- The "already attached" test from patch 1 runs under bind_lock and
  leaves through error_unlock.
- The message names the generic-driver exception and the -EAGAIN a
  consumer probing at that moment gets.
- The bind_lock kernel-doc names phy_probe() and phy_remove().
- Detach clears phy_link_change and takes the recorded module in one
  section under bind_lock, and puts the module it took there.

 drivers/net/phy/phy_device.c | 72 +++++++++++++++++++++++++++++++-----
 include/linux/phy.h          |  6 +++
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 68691c487eee..0ffaa456a308 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -711,6 +711,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	dev->max_n_ports = 1;
 
 	mutex_init(&dev->lock);
+	mutex_init(&dev->bind_lock);
 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
 
 	/* Request the appropriate module unconditionally; don't
@@ -1668,6 +1669,8 @@ static void phy_sfp_release(struct phy_device *phydev)
 	}
 }
 
+static int __phy_probe(struct device *dev);
+
 static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 {
 	return phydrv->config_intr && phydrv->handle_interrupt;
@@ -1685,6 +1688,7 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 {
 	struct net_device *dev = phydev->attached_dev;
 	struct module *ndev_owner = NULL;
+	struct module *drv_owner;
 	struct mii_bus *bus;
 
 	if (phydev->devlink) {
@@ -1702,7 +1706,10 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 		sysfs_remove_file(&phydev->mdio.dev.kobj,
 				  &dev_attr_phy_standalone.attr);
 
-	phy_suspend(phydev);
+	mutex_lock(&phydev->bind_lock);
+	if (phydev->bound)
+		phy_suspend(phydev);
+	mutex_unlock(&phydev->bind_lock);
 
 	if (notify_bus && phydev->mdio.bus->notify_phy_detach)
 		phydev->mdio.bus->notify_phy_detach(phydev);
@@ -1725,11 +1732,18 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 		phy_link_topo_del_phy(dev, phydev);
 	}
 
-	phydev->phy_link_change = NULL;
 	phydev->phylink = NULL;
 
-	module_put(phydev->drv_owner);
+	/* A new attach may pass its "already attached" test as soon as
+	 * phy_link_change is clear, so take the owner in the same section.
+	 */
+	mutex_lock(&phydev->bind_lock);
+	phydev->phy_link_change = NULL;
+	drv_owner = phydev->drv_owner;
 	phydev->drv_owner = NULL;
+	mutex_unlock(&phydev->bind_lock);
+
+	module_put(drv_owner);
 
 	/* If the device had no specific driver before (i.e. - it
 	 * was using the generic driver), we unbind the device
@@ -1782,11 +1796,15 @@ EXPORT_SYMBOL(phy_detach);
  *
  * Description: Called by drivers to attach to a particular PHY
  *     device. The phy_device is found, and properly hooked up
- *     to the phy_driver.  If no driver is attached, then a
+ *     to the phy_driver.  If no driver is bound, then a
  *     generic driver is used.  The phy_device is given a ptr to
  *     the attaching device, and given a callback for link status
  *     change.  The phy_device is returned to the attaching driver.
  *     This function takes a reference on the phy device.
+ *
+ * Return: 0 on success, -EAGAIN if a driver is being bound to or
+ * unbound from the PHY, -EBUSY if the PHY is already attached, or
+ * another negative error code.
  */
 int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		      u32 flags, phy_interface_t interface)
@@ -1812,11 +1830,13 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	get_device(d);
 
+	mutex_lock(&phydev->bind_lock);
+
 	/* Set by every attach, with or without a netdev */
 	if (phydev->phy_link_change) {
 		phydev_err(phydev, "PHY already attached\n");
 		err = -EBUSY;
-		goto error_put_device;
+		goto error_unlock;
 	}
 
 	/* Assume that if there is no driver, that it doesn't
@@ -1829,23 +1849,29 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			d->driver = &genphy_driver.mdiodrv.driver;
 
 		phydev->is_genphy_driven = 1;
+	} else if (!phydev->bound) {
+		phydev_err(phydev, "driver is binding or unbinding\n");
+		err = -EAGAIN;
+		goto error_unlock;
 	}
 
 	drv_owner = d->driver->owner;
 	if (!try_module_get(drv_owner)) {
 		phydev_err(phydev, "failed to get the device driver module\n");
 		err = -EIO;
-		goto error_put_device;
+		goto error_unlock;
 	}
 	phydev->drv_owner = drv_owner;
 
 	if (phydev->is_genphy_driven) {
-		err = d->driver->probe(d);
+		err = __phy_probe(d);
 		if (err >= 0)
 			err = device_bind_driver(d);
 
 		if (err)
 			goto error_module_put;
+
+		phydev->bound = true;
 	}
 
 	phydev->phy_link_change = phy_link_change;
@@ -1928,6 +1954,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phy_resume(phydev);
 
+	mutex_unlock(&phydev->bind_lock);
+
 	/**
 	 * If the external phy used by current mac interface is managed by
 	 * another mac interface, so we should create a device link between
@@ -1940,6 +1968,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	return err;
 
 error:
+	mutex_unlock(&phydev->bind_lock);
 	/* phy_detach_internal() does all of the cleanup below */
 	phy_detach_internal(phydev, false);
 	return err;
@@ -1950,7 +1979,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	phydev->irq = irq;
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
-error_put_device:
+error_unlock:
+	mutex_unlock(&phydev->bind_lock);
 	put_device(d);
 	if (ndev_owner != bus->owner)
 		module_put(bus->owner);
@@ -3654,12 +3684,14 @@ struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_get_phy_node);
 
 /**
- * phy_probe - probe and init a PHY device
+ * __phy_probe - probe and init a PHY device
  * @dev: device to probe and init
  *
  * Take care of setting up the phy_device structure, set the state to READY.
+ *
+ * Return: 0 on success or a negative error code.
  */
-static int phy_probe(struct device *dev)
+static int __phy_probe(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -3807,10 +3839,30 @@ static int phy_probe(struct device *dev)
 	return err;
 }
 
+static int phy_probe(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	int err;
+
+	err = __phy_probe(dev);
+	if (err)
+		return err;
+
+	mutex_lock(&phydev->bind_lock);
+	phydev->bound = true;
+	mutex_unlock(&phydev->bind_lock);
+
+	return 0;
+}
+
 static int phy_remove(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 
+	mutex_lock(&phydev->bind_lock);
+	phydev->bound = false;
+	mutex_unlock(&phydev->bind_lock);
+
 	cancel_delayed_work_sync(&phydev->state_queue);
 
 	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a5a419bc400e..db7c8696743c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -671,6 +671,8 @@ struct phy_oatc14_sqi_capability {
  * @n_ports: Number of ports currently attached to the PHY
  * @max_n_ports: Max number of ports this PHY can expose
  * @lock:  Mutex for serialization access to PHY
+ * @bind_lock: Serialises attach and detach with phy_probe() and phy_remove()
+ * @bound: A driver has finished probing and is not being removed
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -802,6 +804,10 @@ struct phy_device {
 
 	struct mutex lock;
 
+	/* Protects bound */
+	struct mutex bind_lock;
+	bool bound;
+
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;
 	struct sfp_bus *sfp_bus;
-- 
2.53.0

