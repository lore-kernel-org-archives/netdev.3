Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3394E534B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287206; cv=none; b=UxyFW0NG1JrsGX/sTmN/jloOWrUHKfbBQmShBYPzb2JcAzCwqU/DFDaHyuXQYeJRv7pEeLuLFN39USihdJIB1K1dKWpCN/wqVB2vUC9xjniU6KyaiBihcqeOnwmRxEzPb/5/FiPb1JoYQnGiVViRZ7npB5ShXf0h1vwFn9/hL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287206; c=relaxed/simple;
	bh=hNwSVB2vFVc7+4knITW8htmzGXAVBiMA8q51ZXzH8X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncqtkH17VWBqaaxyvMsIft7A5zgGW4PQMZbB4yqLJV5TdIPxGmbhGgmDiBDPFT0uQhKpt1aW4gvPEP1gtEDC4lwxRjyxFUijdIqu5zlcRHsTCz/O0jKphD16XQZuKrJ+wkmMHTwewoILWR3btRJa5bEy7mVe8MA4XgWgKcHHQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=jDm8Dmbp; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="jDm8Dmbp"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so2936205e9.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790287200; x=1790892000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gg9yrizrMl4/k9V3nbOjH8/DtnKpdRRaKslCiuugtC8=;
        b=jDm8Dmbp8+YdaUU+uADEpixnR7eFbwe9TUb0N/NWSIQweflZwL0QYDVDvIb2ZmKQ7u
         XHnG6qMj1UvdER6zSHGoToamWudUhZFXulizEv2XX39W+zF1Q1GDyx65MhHKmw89Df5f
         iZLqL7g5uVaNj3d/sgzc1td2QcCQ9jXUiTGew0dp3iS4nCr4/QJzeffODM05ahZWUX99
         yja91dffVnTLNQSzzRsKtMu0RKFOEzspxoBCH2U3D2KQoXf+UoPvZ8a9kftVRH0AZZnO
         dIcl4LtFao52HE0BsdbAj7Wqp9LzGWGBKAWHbvtRTl4SmVhbSR/wv20ATjHtSZVCjkTK
         XpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287200; x=1790892000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gg9yrizrMl4/k9V3nbOjH8/DtnKpdRRaKslCiuugtC8=;
        b=Z3ErRHu+FHnSczWoueTxJykVgbXGnMd8Cek1nxQX0TGsBMMfh/hW9+pAIG9sNLHYJU
         NgW3WihT9dPGaHyfhmbgSe8uK9c83L3LkkvdfeJczyhhlANEGqS3b7jT30FAGvdElNOH
         I/U28kRd+3Iq+Q4gp93Vq0gc5NXN1fCTPsLwERhEKD4ogcN2U4fjqAetmVRTXQn34AXH
         fptJppUB2b82y+9d3DPITfQzArEmoY/8xQ5s+k+/ww7izFz654xWkrpx6XLOgxgyONH9
         kzXl1tyD7CfK6reNtasF7ZE5y0/MZQWHJLlnLEKJMwpYY5VfZ2isvcaJWpEwkID2rF+4
         oBiw==
X-Forwarded-Encrypted: i=1; AKwUvBzm2zPPFGb+4LXXx1ol+7fYUvn5cqtVOXjzO9rzNUygqB2WmX7t+SgqizMVEFrn5/a8i5mmLVg=@vger.kernel.org
X-Gm-Message-State: AFuF++kxtsspaCT5yVoAUhiFiULO68g+djphQk394+85hr79TykC6Exn
	yoIqqSWq9pDp78cHp/oou+8lYutO9x+MqWBKe0SBdmWMGmn+9p9QdOQ8M+0P0nFw4nI=
X-Gm-Gg: AYBFou0AErm4DAlqnPgq2BDOfzvj57zJR3AEhVUntXmg56Nc6fsQ8ukIhU/7KbbYVH6
	6playvML5Ez1dBiMg0K2v+PBqJmlt1JhzekIbU5g+9+6+NDXQ1inAQpE74VItY/bJ5sJhp//gSQ
	Gh4BY315zJtWsb5QtGmthhvUb9Sh7JyOeH8QU4sJLSIlVon0PFoXEqNDyMs5NJRODMoulyVekI7
	sS96a3zTQkKyez7KCHYjpffzxCZ36xYSP7ZmepeWcq1XF1zehWTSlrac3fjKeWLPVSFEZbVUFqw
	IrHFsUArOohRU8xBVV0FlDUcGS5KMnb5rUvIWIgZXtZsHWoZ3N1rtzP4lz6wn1VFdruGzWTmnCK
	gYVSD0rRrFlSNzsWz9EIa512LCVMHO74JG9G23b9cxpegAs1SnFAzpT5CJBmDtKuHvXQSCCJm/L
	fygBSJflvuwbRk731jElwtfxG8RVe7Q8ZHBHZ0ynJe2U/x+VQKKw==
X-Received: by 2002:a05:600c:870e:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-49fe670b208mr67813525e9.33.1790287200360;
        Thu, 24 Sep 2026 15:00:00 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm1922324f8f.9.2026.09.24.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:59:59 -0700 (PDT)
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
	Mao Wenan <maowenan@huawei.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v3 3/4] net: phy: serialise attach and detach with PHY driver bind and unbind
Date: Fri, 25 Sep 2026 00:59:49 +0300
Message-ID: <20260924215951.2127682-4-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924215951.2127682-1-f@lex.la>
References: <20260924215951.2127682-1-f@lex.la>
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
refuses with -EAGAIN.

phy_remove() clears the flag before any teardown, so the rest of it can
run without the mutex: an attach that loses the race is refused, and
one that wins holds the mutex until it is done with the driver. The
unbind then goes on to remove the driver from the PHY that attach just
attached; what the consumer does with it after that is not changed
here.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phy_device.c | 57 +++++++++++++++++++++++++++++++-----
 include/linux/phy.h          |  6 ++++
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 29d65f6cfd59..1355ea78c86f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -801,6 +801,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	dev->max_n_ports = 1;
 
 	mutex_init(&dev->lock);
+	mutex_init(&dev->bind_lock);
 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
 
 	/* Request the appropriate module unconditionally; don't
@@ -1729,6 +1730,8 @@ static int phy_sfp_probe(struct phy_device *phydev)
 	return ret;
 }
 
+static int __phy_probe(struct device *dev);
+
 static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 {
 	return phydrv->config_intr && phydrv->handle_interrupt;
@@ -1743,11 +1746,15 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
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
@@ -1776,6 +1783,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	get_device(d);
 
+	mutex_lock(&phydev->bind_lock);
+
 	/* Assume that if there is no driver, that it doesn't
 	 * exist, and we should use the genphy driver.
 	 */
@@ -1786,22 +1795,28 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			d->driver = &genphy_driver.mdiodrv.driver;
 
 		phydev->is_genphy_driven = 1;
+	} else if (!phydev->bound) {
+		phydev_err(phydev, "driver is binding or unbinding\n");
+		err = -EAGAIN;
+		goto error_unlock;
 	}
 
 	if (!try_module_get(d->driver->owner)) {
 		phydev_err(phydev, "failed to get the device driver module\n");
 		err = -EIO;
-		goto error_put_device;
+		goto error_unlock;
 	}
 	phydev->drv_owner = d->driver->owner;
 
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
@@ -1878,6 +1893,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phy_resume(phydev);
 
+	mutex_unlock(&phydev->bind_lock);
+
 	/**
 	 * If the external phy used by current mac interface is managed by
 	 * another mac interface, so we should create a device link between
@@ -1890,6 +1907,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	return err;
 
 error:
+	mutex_unlock(&phydev->bind_lock);
 	/* phy_detach() does all of the cleanup below */
 	phy_detach(phydev);
 	return err;
@@ -1899,7 +1917,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	phydev->drv_owner = NULL;
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
-error_put_device:
+error_unlock:
+	mutex_unlock(&phydev->bind_lock);
 	put_device(d);
 	if (ndev_owner != bus->owner)
 		module_put(bus->owner);
@@ -1935,7 +1954,11 @@ void phy_detach(struct phy_device *phydev)
 		sysfs_remove_file(&phydev->mdio.dev.kobj,
 				  &dev_attr_phy_standalone.attr);
 
-	phy_suspend(phydev);
+	mutex_lock(&phydev->bind_lock);
+	if (phydev->bound)
+		phy_suspend(phydev);
+	mutex_unlock(&phydev->bind_lock);
+
 	if (dev) {
 		struct hwtstamp_provider *hwprov;
 
@@ -3678,12 +3701,12 @@ struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_get_phy_node);
 
 /**
- * phy_probe - probe and init a PHY device
+ * __phy_probe - probe and init a PHY device
  * @dev: device to probe and init
  *
  * Take care of setting up the phy_device structure, set the state to READY.
  */
-static int phy_probe(struct device *dev)
+static int __phy_probe(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -3827,10 +3850,30 @@ static int phy_probe(struct device *dev)
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
index 33a207ac5c30..8903123d25c8 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -653,6 +653,8 @@ struct phy_oatc14_sqi_capability {
  * @n_ports: Number of ports currently attached to the PHY
  * @max_n_ports: Max number of ports this PHY can expose
  * @lock:  Mutex for serialization access to PHY
+ * @bind_lock: Serialises attach and detach with driver bind and unbind
+ * @bound: A driver has finished probing and is not being removed
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -784,6 +786,10 @@ struct phy_device {
 
 	struct mutex lock;
 
+	/* Serialises attach and detach with bind and unbind */
+	struct mutex bind_lock;
+	bool bound;
+
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;
 	struct sfp_bus *sfp_bus;
-- 
2.53.0

