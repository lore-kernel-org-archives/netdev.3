Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DE2F7F0F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734138; cv=none; b=cONB+zDq9nl5uDUeRb/Jf/XB83zWXYYlrJJvKkXiMUvcn61TM/Ckt25TxORbfOH3IGF3NidhAvYgGlybXQZWHtiIQ6+CN2hk5vZsWb5boVx6qQtTZmxMoQQmAL9ZNET/x+AsEvyoxzxmKFVXYFMb6wXRXsNFI1Qmf99WjRDFd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734138; c=relaxed/simple;
	bh=06Ndjp2qmfFDz4dq/1g4wiH9y+i9NX4WqoGE7f9jRYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbLpawj99QKjYwLWA0sMCrkav83VFJLWtFrH7yCgN9Ka6+J7ecuBszd6aeZ3p2Iys/pniB5EsW7IqI4UT7Lsosr5JPGl/MkS8JIduXmJSH04hc3UEn4BlYzYYiAjzRwKKUIOcYwQeMQNYLxVBx9yAvBhwpGdPiR4dV+3PALv7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLQuYF+J; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLQuYF+J"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so1828570a34.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734132; x=1786338932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wwVnovEquKlLXg/zw4hAH7SWHSDxoW5mo3oFAsopbqY=;
        b=LLQuYF+JvzQf5HzS6vEqxu8/lhBeQDGzlTGwUCQ7CZfsS9X52AUQc3b3U59HkhtPi9
         epG3VFDsLpZMVahhSrFtdtD5J3+uhbsgd0RjHJYkzNPDxmGUT7rDoRi1l6tfNadg1rlT
         /ivSPmVNtxCnwC4xdyP2uZkSQ0LF8LI5A5uzTCDQx6CCNuuQERAMi6FL1MfnFYzz7yDQ
         xKBQT1cxSTcloewYZMn1E95PckmlL1X6UOJLVjqh/JFSLKDVn54TnGdDXWvBfbCq2daQ
         0Q8ssllkgBVkv84vlTEeiHRPmmhQFQQWygno2gVloVeJMiEUXdWIgaX+xn4GVxVt9eif
         gF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734132; x=1786338932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wwVnovEquKlLXg/zw4hAH7SWHSDxoW5mo3oFAsopbqY=;
        b=G3Wg3T7pAfZeFAVdkCoPEob4KM23yrb976OEHH7Za2hoTvRRDEXdzrsRf5Uj/wYWp9
         E/tJx2L1URYq0qTlxZxc/KxbY8JWFozKVa64ldHkPbPExx6qwLbfxZO24Px2cT4glWje
         WKVBCeryVfB7dsNZPOuEWYozfGLpOeRo9RCZKS46mXqIVqC5dHC8QviUDkHmaXu+jdxE
         9IDLBi5RvyoNdS/llI/tO00WOoHQHcswy4HhbmnQVCVvCUGK1S8yDaYuucRBGP7tH1uB
         paH/tiW9aTn9yZ6qU9uyzeWhNLfTX5wTfj64UPSeoz1/oBgqfzNbA/AyjhHFyAbeWifr
         d4IQ==
X-Gm-Message-State: AOJu0YzgERnPD5XGK8MUCk9Q2wDAsjlopSO4d433ib8hAVLCZnXT11ly
	eJK+AYLEdK335iUa0UQfmeDERW0FtRZ3Y7ssc1XPcGEx4ciXjiv08ofI
X-Gm-Gg: AR+sD11D0BfY/kQbSbsOgEbHr095evwhlJxargLcdKrl6EwZVrVGT0JR91U7o6MPMaS
	oMMxkDbaFgNtSWC08c6yQJVic9Oo4YLhYpF67Voo7t9S2cQPim1r77W2x/wd2GbMPwYwJCNS2pv
	EfJ6VfSqNBdC8v09vJfhDGr7z/Sjrv5ryyt3kkP97GVSrMFO8KaymV+zXnfn0JnKUwbquMFqxK3
	LBQR6q2XplW06iwp0Qo1cowAHeHBZ7if74MAL8AIosx6QS0xF0jJyutvzSla7rOlpDCfkg8/WPn
	wDbdRU1Pbh8WveApRP7iV2gqmcJMJRUYa78s7MQVC9pMN25azZ+BojOJoF04iU+6ZsurLfmIEm2
	HK4jytRq5GyRCJv3KY/DKPQlUkfibTzunrNFwNZAbZXbkT+I25Ak4+EOHTHYmdSRLikn4Ax/rA4
	8GDsktFxtTFAqEG1W0UmlREbhxNVmi587jr07URP67MSOTqkaamXZBPVWRi/QmyNzOara8tTvz6
	TDMDLWk0eQMjVR9hINVfeq87gYrufucHzBqFxKdzpNurZr5yjVcDAcibnynkLrupATU3q+UHU+Z
	NqYHGoRTXTJnssRxckyhVNFwEuLr0G1W9JC+d6CCajd0tCE5YrdjLz/UzXqbyv5In3dm0I1d9zE
	Mn5R6S8orBm5pJcoAjmW3DY15Obs=
X-Received: by 2002:a05:6830:601b:b0:7e9:c72e:e5d6 with SMTP id 46e09a7af769-7f197075663mr13841824a34.14.1785734126952;
        Sun, 02 Aug 2026 22:15:26 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:15 -0600
Subject: [PATCH 05/21] net: mdio: make device map changes hotplug-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-5-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

MDIO device registration currently publishes directly into mdio_map
without serializing address ownership, and removal frees the object
immediately. That is sufficient while bus population is static, but
dynamic firmware changes can race registration, PHY attachment and bus
teardown. It also cannot safely preserve mdiobus_get_phy()'s
borrowed-pointer convention.

Serialize device-map state and reserve addresses while registration is
in progress. Track active scans, registrations and firmware changes so
bus teardown first blocks new work and waits for existing work before
consuming the final map. Block new registrations and PHY attachment while
a firmware removal owns the map.

Publish initialized devices with release ordering and make PHY attachment
atomic with map removal, including standalone PHY users. Have address
scans atomically claim a matching OF node as well, so explicit OF
population cannot instantiate the same device concurrently.

Keep dynamically removed devices pinned until the MDIO bus is torn down
so existing borrowed pointers cannot become use-after-free references.
Drop their firmware-node reference after device_del() so this does not
keep an overlay node alive. Normal MDIO removal and driver APIs remain
unchanged, and consumers do not need to adopt a new refcounting API.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/mdio_bus.c          |  14 ++-
 drivers/net/phy/mdio_bus_provider.c | 140 +++++++++++++++------
 drivers/net/phy/mdio_device.c       | 235 ++++++++++++++++++++++++++++++++----
 drivers/net/phy/phy_device.c        | 102 ++++++++++++----
 drivers/net/phy/phylib-internal.h   |   4 +-
 include/linux/mdio.h                |   6 +
 include/linux/phy.h                 |  18 +++
 7 files changed, 434 insertions(+), 85 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 00d0e4159e9b..f45c936fe5aa 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -34,7 +34,8 @@ static struct mdio_device *mdiobus_find_device(struct mii_bus *bus, int addr)
 	if (WARN_ONCE(!addr_valid, "addr %d out of range\n", addr))
 		return NULL;
 
-	return bus->mdio_map[addr];
+	/* Pair with map publication in mdiobus_register_device(). */
+	return smp_load_acquire(&bus->mdio_map[addr]);
 }
 
 struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr)
@@ -54,7 +55,16 @@ EXPORT_SYMBOL(mdiobus_get_phy);
 
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
 {
-	return mdiobus_find_device(bus, addr) != NULL;
+	bool addr_valid = addr >= 0 && addr < ARRAY_SIZE(bus->mdio_map);
+	bool registered;
+
+	if (WARN_ONCE(!addr_valid, "addr %d out of range\n", addr))
+		return false;
+
+	registered = READ_ONCE(bus->mdio_map[addr]) ||
+		     (READ_ONCE(bus->mdio_map_pending) & BIT(addr));
+
+	return registered;
 }
 EXPORT_SYMBOL(mdiobus_is_registered_device);
 
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index ce3a607a40cb..b83a0a7a4235 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -330,6 +330,9 @@ struct mii_bus *mdiobus_alloc_size(size_t size)
 		return NULL;
 
 	bus->state = MDIOBUS_ALLOCATED;
+	mutex_init(&bus->mdio_map_lock);
+	init_waitqueue_head(&bus->mdio_map_wait);
+	INIT_LIST_HEAD(&bus->mdio_map_retired);
 	if (size)
 		bus->priv = (void *)bus + aligned_size;
 
@@ -360,18 +363,21 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 		int addr;
 
 		if (of_node_name_eq(child, "ethernet-phy-package")) {
+			int ret;
+
 			/* Validate PHY package reg presence */
 			if (!of_property_present(child, "reg")) {
 				of_node_put(child);
 				return -EINVAL;
 			}
 
-			if (!of_mdiobus_find_phy(dev, mdiodev, child)) {
+			ret = of_mdiobus_find_phy(dev, mdiodev, child);
+			if (ret != -ENODEV) {
 				/* The refcount for the PHY package will be
 				 * incremented later when PHY join the Package.
 				 */
 				of_node_put(child);
-				return 0;
+				return ret;
 			}
 
 			continue;
@@ -382,6 +388,11 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 			continue;
 
 		if (addr == mdiodev->addr) {
+			if (of_node_test_and_set_flag(child, OF_POPULATED)) {
+				of_node_put(child);
+				return -EBUSY;
+			}
+
 			device_set_node(dev, of_fwnode_handle(child));
 			/* The refcount on "child" is passed to the mdio
 			 * device. Do _not_ use of_node_put(child) here.
@@ -393,22 +404,26 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 	return -ENODEV;
 }
 
-static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
-				    struct mdio_device *mdiodev)
+static int of_mdiobus_link_mdiodev(struct mii_bus *bus,
+				   struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
 
 	if (dev->of_node || !bus->dev.of_node)
-		return;
+		return 0;
 
-	of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node);
+	return of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node);
 }
 #endif
 
-static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
+static struct phy_device *__mdiobus_scan(struct mii_bus *bus, int addr,
+					 bool c45)
 {
 	struct phy_device *phydev = ERR_PTR(-ENODEV);
 	struct fwnode_handle *fwnode;
+#if IS_ENABLED(CONFIG_OF_MDIO)
+	bool of_node_populated = false;
+#endif
 	char node_name[16];
 	int err;
 
@@ -420,7 +435,12 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 	/* For DT, see if the auto-probed phy has a corresponding child
 	 * in the bus node, and set the of_node pointer in this case.
 	 */
-	of_mdiobus_link_mdiodev(bus, &phydev->mdio);
+	err = of_mdiobus_link_mdiodev(bus, &phydev->mdio);
+	if (err == -EBUSY) {
+		phy_device_free(phydev);
+		return ERR_PTR(-ENODEV);
+	}
+	of_node_populated = !!phydev->mdio.dev.of_node;
 #endif
 
 	/* Search for a swnode for the phy in the swnode hierarchy of the bus.
@@ -437,6 +457,11 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 
 	err = phy_device_register(phydev);
 	if (err) {
+#if IS_ENABLED(CONFIG_OF_MDIO)
+		if (of_node_populated)
+			of_node_clear_flag(phydev->mdio.dev.of_node,
+					   OF_POPULATED);
+#endif
 		phy_device_free(phydev);
 		return ERR_PTR(-ENODEV);
 	}
@@ -458,7 +483,17 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
  */
 struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, false);
+	struct phy_device *phydev;
+	int err;
+
+	err = mdiobus_device_change_begin(bus, false);
+	if (err)
+		return ERR_PTR(err);
+
+	phydev = __mdiobus_scan(bus, addr, false);
+	mdiobus_device_change_end(bus, false);
+
+	return phydev;
 }
 EXPORT_SYMBOL(mdiobus_scan_c22);
 
@@ -476,7 +511,7 @@ EXPORT_SYMBOL(mdiobus_scan_c22);
  */
 static struct phy_device *mdiobus_scan_c45(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, true);
+	return __mdiobus_scan(bus, addr, true);
 }
 
 static int mdiobus_scan_bus_c22(struct mii_bus *bus)
@@ -487,7 +522,7 @@ static int mdiobus_scan_bus_c22(struct mii_bus *bus)
 		if ((bus->phy_mask & BIT(i)) == 0) {
 			struct phy_device *phydev;
 
-			phydev = mdiobus_scan_c22(bus, i);
+			phydev = __mdiobus_scan(bus, i, false);
 			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
 				return PTR_ERR(phydev);
 		}
@@ -504,7 +539,7 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
 			struct phy_device *phydev;
 
 			/* Don't scan C45 if we already have a C22 device */
-			if (bus->mdio_map[i])
+			if (mdiobus_is_registered_device(bus, i))
 				continue;
 
 			phydev = mdiobus_scan_c45(bus, i);
@@ -536,6 +571,44 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
 	return false;
 }
 
+static void mdiobus_stop_device_changes(struct mii_bus *bus)
+{
+	mutex_lock(&bus->mdio_map_lock);
+	bus->state = MDIOBUS_UNREGISTERING;
+	mutex_unlock(&bus->mdio_map_lock);
+
+	wait_event(bus->mdio_map_wait, !READ_ONCE(bus->mdio_map_ops));
+}
+
+static void mdiobus_remove_devices(struct mii_bus *bus)
+{
+	LIST_HEAD(removed);
+	struct mdio_device *mdiodev, *next;
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		mdiodev = bus->mdio_map[i];
+		if (!mdiodev)
+			continue;
+
+		mdiodev->device_remove(mdiodev);
+		mdiodev->device_free(mdiodev);
+	}
+
+	mutex_lock(&bus->mdio_map_lock);
+	list_splice_init(&bus->mdio_map_retired, &removed);
+	mutex_unlock(&bus->mdio_map_lock);
+
+	list_for_each_entry_safe(mdiodev, next, &removed, retired_node) {
+		list_del_init(&mdiodev->retired_node);
+		mdio_device_put(mdiodev);
+	}
+
+	mutex_lock(&bus->mdio_map_lock);
+	bus->state = MDIOBUS_UNREGISTERED;
+	mutex_unlock(&bus->mdio_map_lock);
+}
+
 /**
  * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
  * @bus: target mii_bus
@@ -552,10 +625,9 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
  */
 int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 {
-	struct mdio_device *mdiodev;
 	struct gpio_desc *gpiod;
 	bool prevent_c45_scan;
-	int i, err;
+	int err;
 
 	if (!bus || !bus->name)
 		return -EINVAL;
@@ -596,7 +668,9 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	 *
 	 * State will be updated later in this function in case of success
 	 */
+	mutex_lock(&bus->mdio_map_lock);
 	bus->state = MDIOBUS_UNREGISTERED;
+	mutex_unlock(&bus->mdio_map_lock);
 
 	err = device_register(&bus->dev);
 	if (err) {
@@ -613,8 +687,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		err = dev_err_probe(&bus->dev, PTR_ERR(gpiod),
 				    "mii_bus %s couldn't get reset GPIO\n",
 				    bus->id);
-		device_del(&bus->dev);
-		return err;
+		goto error_reset_gpiod;
 	} else	if (gpiod) {
 		bus->reset_gpiod = gpiod;
 		fsleep(bus->reset_delay_us);
@@ -629,6 +702,10 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error_reset_gpiod;
 	}
 
+	mutex_lock(&bus->mdio_map_lock);
+	bus->state = MDIOBUS_REGISTERING;
+	mutex_unlock(&bus->mdio_map_lock);
+
 	if (bus->read) {
 		err = mdiobus_scan_bus_c22(bus);
 		if (err)
@@ -643,20 +720,17 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error;
 	}
 
+	mutex_lock(&bus->mdio_map_lock);
 	bus->state = MDIOBUS_REGISTERED;
+	mutex_unlock(&bus->mdio_map_lock);
 	dev_dbg(&bus->dev, "probed\n");
 	return 0;
 
 error:
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		mdiodev = bus->mdio_map[i];
-		if (!mdiodev)
-			continue;
-
-		mdiodev->device_remove(mdiodev);
-		mdiodev->device_free(mdiodev);
-	}
 error_reset_gpiod:
+	mdiobus_stop_device_changes(bus);
+	mdiobus_remove_devices(bus);
+
 	/* Put PHYs in RESET to save power */
 	if (bus->reset_gpiod)
 		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
@@ -668,21 +742,11 @@ EXPORT_SYMBOL(__mdiobus_register);
 
 void mdiobus_unregister(struct mii_bus *bus)
 {
-	struct mdio_device *mdiodev;
-	int i;
-
 	if (WARN_ON_ONCE(bus->state != MDIOBUS_REGISTERED))
 		return;
-	bus->state = MDIOBUS_UNREGISTERED;
-
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		mdiodev = bus->mdio_map[i];
-		if (!mdiodev)
-			continue;
 
-		mdiodev->device_remove(mdiodev);
-		mdiodev->device_free(mdiodev);
-	}
+	mdiobus_stop_device_changes(bus);
+	mdiobus_remove_devices(bus);
 
 	/* Put PHYs in RESET to save power */
 	if (bus->reset_gpiod)
@@ -702,8 +766,11 @@ EXPORT_SYMBOL(mdiobus_unregister);
  */
 void mdiobus_free(struct mii_bus *bus)
 {
+	mutex_lock(&bus->mdio_map_lock);
+
 	/* For compatibility with error handling in drivers. */
 	if (bus->state == MDIOBUS_ALLOCATED) {
+		mutex_unlock(&bus->mdio_map_lock);
 		kfree(bus);
 		return;
 	}
@@ -711,6 +778,7 @@ void mdiobus_free(struct mii_bus *bus)
 	WARN(bus->state != MDIOBUS_UNREGISTERED,
 	     "%s: not in UNREGISTERED state\n", bus->id);
 	bus->state = MDIOBUS_RELEASED;
+	mutex_unlock(&bus->mdio_map_lock);
 
 	put_device(&bus->dev);
 }
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 56080d3d2d25..49092045831f 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -16,6 +16,7 @@
 #include <linux/mdio.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -38,8 +39,12 @@ static int mdio_device_register_reset(struct mdio_device *mdiodev)
 	/* Deassert the optional reset signal */
 	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
 						 "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(mdiodev->reset_gpio))
-		return PTR_ERR(mdiodev->reset_gpio);
+	if (IS_ERR(mdiodev->reset_gpio)) {
+		int err = PTR_ERR(mdiodev->reset_gpio);
+
+		mdiodev->reset_gpio = NULL;
+		return err;
+	}
 
 	if (mdiodev->reset_gpio)
 		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
@@ -117,6 +122,13 @@ static void mdio_device_release(struct device *dev)
 	kfree(to_mdio_device(dev));
 }
 
+static int __mdio_device_remove(struct mdio_device *mdiodev, bool dynamic);
+
+static int mdio_device_remove_dynamic(struct mdio_device *mdiodev)
+{
+	return __mdio_device_remove(mdiodev, true);
+}
+
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 {
 	struct mdio_device *mdiodev;
@@ -131,9 +143,11 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 	mdiodev->dev.bus = &mdio_bus_type;
 	mdiodev->device_free = mdio_device_free;
 	mdiodev->device_remove = mdio_device_remove;
+	mdiodev->device_remove_dynamic = mdio_device_remove_dynamic;
 	mdiodev->bus = bus;
 	mdiodev->addr = addr;
 	mdiodev->reset_state = -1;
+	INIT_LIST_HEAD(&mdiodev->retired_node);
 
 	dev_set_name(&mdiodev->dev, PHY_ID_FMT, bus->id, addr);
 
@@ -160,19 +174,27 @@ int mdio_device_register(struct mdio_device *mdiodev)
 		return err;
 
 	err = device_add(&mdiodev->dev);
-	if (err) {
+	if (err)
 		pr_err("MDIO %d failed to add\n", mdiodev->addr);
-		goto out;
-	}
-
-	return 0;
 
- out:
-	mdiobus_unregister_device(mdiodev);
-	return err;
+	return mdiobus_registration_done(mdiodev, err);
 }
 EXPORT_SYMBOL(mdio_device_register);
 
+static int __mdio_device_remove(struct mdio_device *mdiodev, bool dynamic)
+{
+	int err;
+
+	err = mdiobus_begin_remove(mdiodev, dynamic);
+	if (err)
+		return err;
+
+	device_del(&mdiodev->dev);
+	mdiobus_finish_remove(mdiodev, dynamic);
+
+	return 0;
+}
+
 /**
  * mdio_device_remove - Remove a previously registered mdio device from the
  *			MDIO bus
@@ -184,42 +206,211 @@ EXPORT_SYMBOL(mdio_device_register);
  */
 void mdio_device_remove(struct mdio_device *mdiodev)
 {
-	device_del(&mdiodev->dev);
-	mdiobus_unregister_device(mdiodev);
+	__mdio_device_remove(mdiodev, false);
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
 int mdiobus_register_device(struct mdio_device *mdiodev)
 {
+	struct mii_bus *bus = mdiodev->bus;
 	int err;
 
-	if (mdiodev->bus->mdio_map[mdiodev->addr])
-		return -EBUSY;
+	mutex_lock(&bus->mdio_map_lock);
+	if (bus->state != MDIOBUS_REGISTERING &&
+	    bus->state != MDIOBUS_REGISTERED) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+	if (bus->mdio_map_removals) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (bus->mdio_map[mdiodev->addr] ||
+	    bus->mdio_map_pending & BIT(mdiodev->addr)) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	bus->mdio_map_pending |= BIT(mdiodev->addr);
+	bus->mdio_map_ops++;
+	mutex_unlock(&bus->mdio_map_lock);
 
 	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
 		err = mdio_device_register_reset(mdiodev);
-		if (err)
+		if (err) {
+			mdiobus_registration_done(mdiodev, err);
 			return err;
+		}
 
 		/* Assert the reset signal */
 		mdio_device_reset(mdiodev, 1);
 	}
 
-	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;
+	mutex_lock(&bus->mdio_map_lock);
+	/* Teardown waits for this registration before consuming the map. */
+	smp_store_release(&bus->mdio_map[mdiodev->addr], mdiodev);
+	mutex_unlock(&bus->mdio_map_lock);
 
 	return 0;
+
+out_unlock:
+	mutex_unlock(&bus->mdio_map_lock);
+	return err;
 }
 
-int mdiobus_unregister_device(struct mdio_device *mdiodev)
+/**
+ * mdiobus_device_change_begin - start changing devices on a registered bus
+ * @bus: MDIO bus that will be scanned or changed
+ * @removing: whether PHY attachment must be blocked during the change
+ *
+ * Return: zero on success or a negative error code when the bus is unavailable
+ */
+int mdiobus_device_change_begin(struct mii_bus *bus, bool removing)
 {
-	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
-		return -EINVAL;
+	int err = 0;
+
+	mutex_lock(&bus->mdio_map_lock);
+	if (bus->state != MDIOBUS_REGISTERED) {
+		err = -ENODEV;
+	} else {
+		bus->mdio_map_ops++;
+		if (removing)
+			bus->mdio_map_removals++;
+	}
+	mutex_unlock(&bus->mdio_map_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mdiobus_device_change_begin);
 
-	mdio_device_unregister_reset(mdiodev);
+static void mdiobus_operation_done_locked(struct mii_bus *bus)
+{
+	lockdep_assert_held(&bus->mdio_map_lock);
 
-	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
+	if (WARN_ON_ONCE(!bus->mdio_map_ops))
+		return;
+	bus->mdio_map_ops--;
+	if (!bus->mdio_map_ops)
+		wake_up_all(&bus->mdio_map_wait);
+}
 
-	return 0;
+/**
+ * mdiobus_device_change_end - finish changing devices on an MDIO bus
+ * @bus: MDIO bus previously passed to mdiobus_device_change_begin()
+ * @removing: value passed to mdiobus_device_change_begin()
+ */
+void mdiobus_device_change_end(struct mii_bus *bus, bool removing)
+{
+	mutex_lock(&bus->mdio_map_lock);
+	if (removing) {
+		if (!WARN_ON_ONCE(!bus->mdio_map_removals))
+			bus->mdio_map_removals--;
+	}
+	mdiobus_operation_done_locked(bus);
+	mutex_unlock(&bus->mdio_map_lock);
+}
+EXPORT_SYMBOL_GPL(mdiobus_device_change_end);
+
+static void mdiobus_operation_done(struct mii_bus *bus)
+{
+	mutex_lock(&bus->mdio_map_lock);
+	mdiobus_operation_done_locked(bus);
+	mutex_unlock(&bus->mdio_map_lock);
+}
+
+static void mdiobus_unpublish_device(struct mdio_device *mdiodev)
+{
+	struct mii_bus *bus = mdiodev->bus;
+
+	lockdep_assert_held(&bus->mdio_map_lock);
+
+	if (bus->mdio_map[mdiodev->addr] == mdiodev)
+		WRITE_ONCE(bus->mdio_map[mdiodev->addr], NULL);
+	if (mdiodev->dev.of_node)
+		of_node_clear_flag(mdiodev->dev.of_node, OF_POPULATED);
+}
+
+int mdiobus_registration_done(struct mdio_device *mdiodev, int err)
+{
+	struct mii_bus *bus = mdiodev->bus;
+
+	mutex_lock(&bus->mdio_map_lock);
+	if (WARN_ON_ONCE(!(bus->mdio_map_pending & BIT(mdiodev->addr))))
+		goto out_unlock;
+
+	if (err)
+		mdiobus_unpublish_device(mdiodev);
+	else
+		WARN_ON_ONCE(bus->mdio_map[mdiodev->addr] != mdiodev);
+
+	bus->mdio_map_pending &= ~BIT(mdiodev->addr);
+
+out_unlock:
+	mutex_unlock(&bus->mdio_map_lock);
+	if (err) {
+		if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+			mdio_device_reset(mdiodev, 1);
+			mdio_device_unregister_reset(mdiodev);
+		}
+	}
+	mdiobus_operation_done(bus);
+
+	return err;
+}
+
+int mdiobus_begin_remove(struct mdio_device *mdiodev, bool dynamic)
+{
+	struct mii_bus *bus = mdiodev->bus;
+	int err = 0;
+
+	mutex_lock(&bus->mdio_map_lock);
+	if (dynamic && (bus->state == MDIOBUS_UNREGISTERED ||
+			bus->state == MDIOBUS_RELEASED)) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+	if (bus->mdio_map_pending & BIT(mdiodev->addr)) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (bus->mdio_map[mdiodev->addr] != mdiodev) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+
+	if (dynamic && mdiodev->flags & MDIO_DEVICE_FLAG_PHY &&
+	    to_phy_device(&mdiodev->dev)->attached) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	mdiobus_unpublish_device(mdiodev);
+
+	if (dynamic) {
+		mdio_device_get(mdiodev);
+		list_add_tail(&mdiodev->retired_node, &bus->mdio_map_retired);
+	}
+
+out_unlock:
+	mutex_unlock(&bus->mdio_map_lock);
+	return err;
+}
+
+void mdiobus_finish_remove(struct mdio_device *mdiodev, bool dynamic)
+{
+	struct fwnode_handle *fwnode;
+
+	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY)
+		mdio_device_unregister_reset(mdiodev);
+
+	/* Do not keep an overlay node alive with the retired device. */
+	if (dynamic) {
+		fwnode = dev_fwnode(&mdiodev->dev);
+		device_set_node(&mdiodev->dev, NULL);
+		fwnode_handle_put(fwnode);
+	}
 }
 
 /**
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef..f7472a743185 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -227,6 +227,8 @@ static void phy_device_release(struct device *dev)
 	kfree(to_phy_device(dev));
 }
 
+static int __phy_device_remove(struct phy_device *phydev, bool dynamic);
+
 static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 {
 	struct phy_device *phydev;
@@ -235,6 +237,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 	phy_device_remove(phydev);
 }
 
+static int phy_mdio_device_remove_dynamic(struct mdio_device *mdiodev)
+{
+	struct phy_device *phydev;
+
+	phydev = container_of(mdiodev, struct phy_device, mdio);
+	return __phy_device_remove(phydev, true);
+}
+
 static struct phy_driver genphy_driver;
 
 static LIST_HEAD(phy_fixup_list);
@@ -768,7 +778,9 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	mdiodev->flags = MDIO_DEVICE_FLAG_PHY;
 	mdiodev->device_free = phy_mdio_device_free;
 	mdiodev->device_remove = phy_mdio_device_remove;
+	mdiodev->device_remove_dynamic = phy_mdio_device_remove_dynamic;
 	mdiodev->reset_state = -1;
+	INIT_LIST_HEAD(&mdiodev->retired_node);
 
 	dev->speed = SPEED_UNKNOWN;
 	dev->duplex = DUPLEX_UNKNOWN;
@@ -1121,25 +1133,40 @@ int phy_device_register(struct phy_device *phydev)
 	err = phy_scan_fixups(phydev);
 	if (err) {
 		phydev_err(phydev, "failed to initialize\n");
-		goto out;
+		return mdiobus_registration_done(&phydev->mdio, err);
 	}
 
 	err = device_add(&phydev->mdio.dev);
-	if (err) {
+	if (err)
 		phydev_err(phydev, "failed to add\n");
-		goto out;
-	}
 
-	return 0;
+	return mdiobus_registration_done(&phydev->mdio, err);
+}
+EXPORT_SYMBOL(phy_device_register);
+
+static int __phy_device_remove(struct phy_device *phydev, bool dynamic)
+{
+	int err;
+
+	err = mdiobus_begin_remove(&phydev->mdio, dynamic);
+	if (dynamic && err == -EBUSY)
+		dev_warn(&phydev->mdio.dev,
+			 "cannot remove a PHY while it is attached or being registered\n");
+	if (err)
+		return err;
+
+	unregister_mii_timestamper(phydev->mii_ts);
+	pse_control_put(phydev->psec);
+
+	device_del(&phydev->mdio.dev);
 
- out:
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
 
-	mdiobus_unregister_device(&phydev->mdio);
-	return err;
+	mdiobus_finish_remove(&phydev->mdio, dynamic);
+
+	return 0;
 }
-EXPORT_SYMBOL(phy_device_register);
 
 /**
  * phy_device_remove - Remove a previously registered phy device from the MDIO bus
@@ -1151,15 +1178,7 @@ EXPORT_SYMBOL(phy_device_register);
  */
 void phy_device_remove(struct phy_device *phydev)
 {
-	unregister_mii_timestamper(phydev->mii_ts);
-	pse_control_put(phydev->psec);
-
-	device_del(&phydev->mdio.dev);
-
-	/* Assert the reset signal */
-	phy_device_reset(phydev, 1);
-
-	mdiobus_unregister_device(&phydev->mdio);
+	__phy_device_remove(phydev, false);
 }
 EXPORT_SYMBOL(phy_device_remove);
 
@@ -1734,6 +1753,36 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
 
+static int phy_claim(struct phy_device *phydev)
+{
+	struct mdio_device *mdiodev = &phydev->mdio;
+	struct mii_bus *bus = mdiodev->bus;
+	int err = 0;
+
+	mutex_lock(&bus->mdio_map_lock);
+	if (bus->state != MDIOBUS_REGISTERED ||
+	    bus->mdio_map_removals ||
+	    bus->mdio_map[mdiodev->addr] != mdiodev ||
+	    (bus->mdio_map_pending & BIT(mdiodev->addr)))
+		err = -ENODEV;
+	else if (phydev->attached)
+		err = -EBUSY;
+	else
+		phydev->attached = true;
+	mutex_unlock(&bus->mdio_map_lock);
+
+	return err;
+}
+
+static void phy_release(struct phy_device *phydev)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+
+	mutex_lock(&bus->mdio_map_lock);
+	phydev->attached = false;
+	mutex_unlock(&bus->mdio_map_lock);
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1755,6 +1804,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct mii_bus *bus = phydev->mdio.bus;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
+	bool claimed = false;
 	int err;
 
 	/* For Ethernet device drivers that register their own MDIO bus, we
@@ -1770,6 +1820,13 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	}
 
 	get_device(d);
+	err = phy_claim(phydev);
+	if (err == -EBUSY)
+		phydev_err(phydev, "PHY already attached\n");
+	if (!err)
+		claimed = true;
+	if (err)
+		goto error_put_device;
 
 	/* Assume that if there is no driver, that it doesn't
 	 * exist, and we should use the genphy driver.
@@ -1798,12 +1855,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			goto error_module_put;
 	}
 
-	if (phydev->attached_dev) {
-		dev_err(&dev->dev, "PHY already attached\n");
-		err = -EBUSY;
-		goto error;
-	}
-
 	phydev->phy_link_change = phy_link_change;
 	if (dev) {
 		phydev->attached_dev = dev;
@@ -1899,6 +1950,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
+	if (claimed)
+		phy_release(phydev);
 	put_device(d);
 	if (ndev_owner != bus->owner)
 		module_put(bus->owner);
@@ -1977,6 +2030,7 @@ void phy_detach(struct phy_device *phydev)
 	 * a use-after-free bug by reading the underlying bus first.
 	 */
 	bus = phydev->mdio.bus;
+	phy_release(phydev);
 
 	put_device(&phydev->mdio.dev);
 	if (dev)
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index 664ed7faa518..7e9161fcdd90 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -25,7 +25,9 @@ int phy_speed_down_core(struct phy_device *phydev);
 void phy_check_downshift(struct phy_device *phydev);
 
 int mdiobus_register_device(struct mdio_device *mdiodev);
-int mdiobus_unregister_device(struct mdio_device *mdiodev);
+int mdiobus_registration_done(struct mdio_device *mdiodev, int err);
+int mdiobus_begin_remove(struct mdio_device *mdiodev, bool dynamic);
+void mdiobus_finish_remove(struct mdio_device *mdiodev, bool dynamic);
 
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index f4f9d9609448..41c60798fa0e 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -8,6 +8,7 @@
 
 #include <uapi/linux/mdio.h>
 #include <linux/bitfield.h>
+#include <linux/list.h>
 #include <linux/mod_devicetable.h>
 
 struct gpio_desc;
@@ -33,6 +34,9 @@ struct mdio_device {
 	int (*bus_match)(struct device *dev, const struct device_driver *drv);
 	void (*device_free)(struct mdio_device *mdiodev);
 	void (*device_remove)(struct mdio_device *mdiodev);
+	int (*device_remove_dynamic)(struct mdio_device *mdiodev);
+	/* Entry in mii_bus::mdio_map_retired. */
+	struct list_head retired_node;
 
 	/* Bus address of the MDIO device (0-31) */
 	int addr;
@@ -690,6 +694,8 @@ static inline int mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
 
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr);
 struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr);
+int mdiobus_device_change_begin(struct mii_bus *bus, bool removing);
+void mdiobus_device_change_end(struct mii_bus *bus, bool removing);
 
 /**
  * mdio_module_driver() - Helper macro for registering mdio drivers
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fc680901275b..2eba54e068f6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -22,6 +22,7 @@
 #include <linux/mii_timestamper.h>
 #include <linux/module.h>
 #include <linux/timer.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/device-id/mdio.h>
 #include <linux/u64_stats_sync.h>
@@ -391,7 +392,9 @@ struct mii_bus {
 	/** @state: State of bus structure */
 	enum {
 		MDIOBUS_ALLOCATED = 1,
+		MDIOBUS_REGISTERING,
 		MDIOBUS_REGISTERED,
+		MDIOBUS_UNREGISTERING,
 		MDIOBUS_UNREGISTERED,
 		MDIOBUS_RELEASED,
 	} state;
@@ -401,6 +404,18 @@ struct mii_bus {
 
 	/** @mdio_map: list of all MDIO devices on bus */
 	struct mdio_device *mdio_map[PHY_MAX_ADDR];
+	/** @mdio_map_pending: addresses with registration in progress */
+	u32 mdio_map_pending;
+	/** @mdio_map_lock: protects the MDIO device map and bus state */
+	struct mutex mdio_map_lock;
+	/** @mdio_map_wait: wait for active map operations during teardown */
+	wait_queue_head_t mdio_map_wait;
+	/** @mdio_map_ops: active registrations and firmware changes */
+	unsigned int mdio_map_ops;
+	/** @mdio_map_removals: firmware removals blocking PHY attachment */
+	unsigned int mdio_map_removals;
+	/** @mdio_map_retired: removed devices pinned until bus teardown */
+	struct list_head mdio_map_retired;
 
 	/** @phy_mask: PHY addresses to be ignored when probing */
 	u32 phy_mask;
@@ -652,6 +667,8 @@ struct phy_oatc14_sqi_capability {
  * @n_ports: Number of ports currently attached to the PHY
  * @max_n_ports: Max number of ports this PHY can expose
  * @lock:  Mutex for serialization access to PHY
+ * @attached: Whether a network device or standalone user attached the PHY;
+ *	protected by the MDIO bus map lock
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -781,6 +798,7 @@ struct phy_device {
 	struct delayed_work state_queue;
 
 	struct mutex lock;
+	bool attached;
 
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;

-- 
2.53.0

