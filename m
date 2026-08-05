Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069ED3D3D1E
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952170; cv=none; b=SKCWMm1TNf7qqiyusq+hLdGuNLCqp+Cf1tLwLcXGlf0u36MxVejZZedNslFJ03O5mgXaiOUIt72VNOIz+qgRzwmh9YLilbwV6IW76p5IMJWGa2MZDr48XAe3HP5pPyDnD+91NZJp8AuYmbPoPrbQZIgoHVWhz6f/ZBUYo+PgP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952170; c=relaxed/simple;
	bh=OZw9gVHMEi7AGJfsGZLMDrHUpxMAGdZep3AIzs99XbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwmNARPCx75zQ2r0IEwOYjJa7jWRZhGKwHf6i+L5QqqGYMWSwNr2ji6v1hBPGI0buSG3gcF1G4SOtalyCrclX7iJRTRhPMRANBclnmVY9TOcDZP+TOMzILHYRTSjqeqMU2Jc6tdBB7/qNpsulEzchNaiYTn266hgtZT0uBF8HZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAC9Rviv; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAC9Rviv"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6ae534c2aadso856258eaf.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785952166; x=1786556966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ThANLUDodsw1sPmCTcA3DzcnTNWodFf4ilIvEJQxIA=;
        b=kAC9RvivyJV2Zu5ClxiTy5c1ZkxcoxcEeBIPFfNSAQNUulcdvAlJIi6LD2XBDA7bY9
         GSxhomOqKcReEykG8AG9HT4Jo7xhWmxYlXPHj7OMELG1EkbdWYWVsOa3Cop/rhd5kg42
         lDR+jIPK2/nwzwGC555G5OLLOUPRYYJGfHx4l2sJGoNAvvi5kuhps2yf9afsT5Cs4anx
         9lrhZXFFETEVeY2aDXHLCQXvKl9qmBstL7tqW+PjEXekMzLbWiGypxROD5HOvMOxov0a
         4YLTL1hhQXItNsN7L76Ad4HJb5lyGzEGj0rifRLgYkYm4qhi3tIijBER8drTsucZ32MO
         jVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952166; x=1786556966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ThANLUDodsw1sPmCTcA3DzcnTNWodFf4ilIvEJQxIA=;
        b=cOoIUkSBIhg6gLKTkS6XgjNZ1KkJJeDdeWgMcTExHkI0DKWmuQb3IT/Wv1YaK3EHhv
         bZ05vOMo1x7nLl6hymm7wTedLi0pbaT53zOEIuf317/kYcg7dqTpRMykp61lASMgXMKB
         Qa5pe1n1L/Cv0rgwtQCz8Wt2RNhxYKp3L25RFPPLEmcx3q8vuP15bsM47H6sPB1ndD3J
         DiYXvAHC9sMyF1y1ERZMWvYlAMjoIgMWFy5+Yt4C5ai/cyKbktGcVZv/uC85CyFRJ3EC
         TbUv+88MMC1nZEvxy6BhJeWtQV92LrzAMDe8NMeG+VOMN1yuzrdN1jmXkalRFN0fNWMs
         /yXQ==
X-Gm-Message-State: AOJu0YxjdE7r7Jyz8bLO3p0FaaV4EbauYtq0OCEUt/MWYPUJf8/NKavo
	p8zLFw592T/KXgTiQotiwkDcRGIl7NMOmwLFzIh047qeK2kivwiR6sTK
X-Gm-Gg: AR+sD11nHE5wDAMGXIg7itLSbGn9GHyOpQoObtaH6r4wFzgTCvgfTZzuHnr6ZJvNhYw
	6YWGeo8xPS2GXTlrijrzahR1qss5KKHf8+OSj5g1icu7/OvcwFDN/vcK4X3N33wgMIad5rv32KQ
	h2llBKOhwgu0qbG5gYM/4mIN8mOU0cputECi0vjRbrc5UNLtYBkhKVMfqAanNwrfyVo0nDiLTUP
	WQZNjI7vIqPNQTZ/ojNTkXTslRXO9BJgoxAOPNuD0sxeeGvj1UnrVDHEC9A+LVjDQXY8dh2BXbO
	PNAIL0NlCs6rSKSJebu8YlPVKoyA3gI2uqoVScqEAbNkKlQwgEC6uLXAQkJ84Jea32QMnolLgX2
	Y+0vaI67LUsaDaZs5kqmslyalAUkvdkJCEpgiFkwnXYior8rSeolr4Ct/1JhBhO0OpvPWBHlr2Z
	wqDzAMUubUs586Z6P8OPIvxOaFhKZIaQs04xizNGlQK0kxEIZgnccFXwVVrdmlcKdWqRh9HoBvU
	fawi68xTOtI3qwo0jvS0ie4cAdKyrCPbsrwlkOACoKYi7Efgp44J7Fdcx8qcCMv/+NZadQiZIvh
	cPvNQ/MaeqTnpvohHG51Ou+mA5foaRVdV4lt/LoDQCwZY0ZgOv2bReh8JPurTFclmCmNxjHh8/7
	orrUYpP4Q9JqWBzgoMfXRUgeoYe0=
X-Received: by 2002:a05:6820:c83:b0:6a3:955b:8474 with SMTP id 006d021491bc7-6ae96c389b7mr4850575eaf.4.1785952165791;
        Wed, 05 Aug 2026 10:49:25 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599dd615ecsm3281704fac.0.2026.08.05.10.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:49:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 05 Aug 2026 11:49:14 -0600
Subject: [PATCH net-next v3 3/4] net: mdio: make device map changes
 hotplug-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-submit-mdio-of-dynamic-v2-v3-3-16f3cc893b0e@gmail.com>
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

MDIO device registration currently publishes directly into mdio_map
without serializing address ownership, and removal frees the object
immediately. That is sufficient while bus population is static, but
dynamic firmware changes can race registration, PHY attachment and bus
teardown. It also cannot safely preserve mdiobus_get_phy()'s
borrowed-pointer convention.

Serialize device-map state and reserve addresses while registration is
in progress. Track active scans, registrations and firmware changes so
bus teardown first blocks new work and waits for existing work before
consuming the final map. Make firmware removal transactions exclusive
with registration, scanning and other firmware changes: start one only
when no tracked map operation is active, then block new firmware changes,
registrations and PHY attachment until it ends.

Keep an address reserved while device_add() and driver probing run, then
publish the fully registered device with release ordering. Make PHY
attachment atomic with map removal, including standalone PHY users. Have
address scans atomically claim a matching OF node as well, so explicit OF
population cannot instantiate the same device concurrently. Route the
remaining in-tree direct map reader through mdiobus_get_phy() so every
lockless reader observes the same publication ordering.

Keep dynamically removed PHY devices pinned until the MDIO bus is torn
down so existing borrowed pointers cannot become use-after-free
references. Generic MDIO-device lookups already return referenced objects
and do not require retirement. Drop a removed device's firmware-node
reference after device_del() so this does not keep an overlay node alive.

Make the internal removal callback report whether it unpublished the
device. Bus teardown holds a temporary reference while dropping the map
lock and releases the device's registration reference only when its
removal attempt succeeded. When a concurrent normal removal has already
unpublished the device, teardown therefore does not release the same
registration reference again. Public MDIO removal and driver APIs remain
unchanged.

Clear an error-valued optional reset GPIO before the common registration
rollback uses the reset helpers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - hold a device reference across unlocked teardown removal
  - free only devices successfully claimed by the teardown path
  - consolidate normal and dynamic internal removal callbacks
  - publish map entries only after device registration completes
  - route the remaining direct map reader through mdiobus_get_phy()
  - retire only PHY devices which have a borrowed-pointer lookup API
  - make firmware removal exclusive with registration, scanning and other
    firmware changes
  - propagate only population conflicts from recursive package lookup

Changes v1 -> v2:
  - split from the ACx00 series
  - rebase onto net-next after <linux/mdio.h> stopped including
    <linux/mod_devicetable.h>
  - move touched declarations to function scope for netdev style
---
 drivers/net/phy/mdio_bus.c          |  14 ++-
 drivers/net/phy/mdio_bus_provider.c | 147 ++++++++++++++++------
 drivers/net/phy/mdio_device.c       | 236 ++++++++++++++++++++++++++++++++----
 drivers/net/phy/mscc/mscc_ptp.c     |   6 +-
 drivers/net/phy/phy_device.c        | 101 ++++++++++-----
 drivers/net/phy/phylib-internal.h   |   4 +-
 include/linux/mdio.h                |   4 +-
 include/linux/phy.h                 |  20 +++
 8 files changed, 433 insertions(+), 99 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 00d0e4159e9b..6eb3ebbbba57 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -34,7 +34,8 @@ static struct mdio_device *mdiobus_find_device(struct mii_bus *bus, int addr)
 	if (WARN_ONCE(!addr_valid, "addr %d out of range\n", addr))
 		return NULL;
 
-	return bus->mdio_map[addr];
+	/* Pair with map publication in mdiobus_registration_done(). */
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
index ce3a607a40cb..ff7e8de88bb0 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -330,6 +330,9 @@ struct mii_bus *mdiobus_alloc_size(size_t size)
 		return NULL;
 
 	bus->state = MDIOBUS_ALLOCATED;
+	mutex_init(&bus->mdio_map_lock);
+	init_waitqueue_head(&bus->mdio_map_wait);
+	INIT_LIST_HEAD(&bus->mdio_map_retired_phys);
 	if (size)
 		bus->priv = (void *)bus + aligned_size;
 
@@ -355,10 +358,9 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 			       struct device_node *np)
 {
 	struct device_node *child;
+	int addr, ret;
 
 	for_each_available_child_of_node(np, child) {
-		int addr;
-
 		if (of_node_name_eq(child, "ethernet-phy-package")) {
 			/* Validate PHY package reg presence */
 			if (!of_property_present(child, "reg")) {
@@ -366,12 +368,13 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 				return -EINVAL;
 			}
 
-			if (!of_mdiobus_find_phy(dev, mdiodev, child)) {
+			ret = of_mdiobus_find_phy(dev, mdiodev, child);
+			if (!ret || ret == -EBUSY) {
 				/* The refcount for the PHY package will be
 				 * incremented later when PHY join the Package.
 				 */
 				of_node_put(child);
-				return 0;
+				return ret;
 			}
 
 			continue;
@@ -382,6 +385,11 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
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
@@ -393,22 +401,26 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
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
 
@@ -420,7 +432,12 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
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
@@ -437,6 +454,11 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 
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
@@ -458,7 +480,17 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
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
 
@@ -476,7 +508,7 @@ EXPORT_SYMBOL(mdiobus_scan_c22);
  */
 static struct phy_device *mdiobus_scan_c45(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, true);
+	return __mdiobus_scan(bus, addr, true);
 }
 
 static int mdiobus_scan_bus_c22(struct mii_bus *bus)
@@ -487,7 +519,7 @@ static int mdiobus_scan_bus_c22(struct mii_bus *bus)
 		if ((bus->phy_mask & BIT(i)) == 0) {
 			struct phy_device *phydev;
 
-			phydev = mdiobus_scan_c22(bus, i);
+			phydev = __mdiobus_scan(bus, i, false);
 			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
 				return PTR_ERR(phydev);
 		}
@@ -504,7 +536,7 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
 			struct phy_device *phydev;
 
 			/* Don't scan C45 if we already have a C22 device */
-			if (bus->mdio_map[i])
+			if (mdiobus_is_registered_device(bus, i))
 				continue;
 
 			phydev = mdiobus_scan_c45(bus, i);
@@ -536,6 +568,50 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
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
+	struct mdio_device *mdiodev;
+	struct phy_device *phydev, *next;
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		mutex_lock(&bus->mdio_map_lock);
+		mdiodev = bus->mdio_map[i];
+		if (mdiodev)
+			mdio_device_get(mdiodev);
+		mutex_unlock(&bus->mdio_map_lock);
+		if (!mdiodev)
+			continue;
+
+		if (!mdiodev->device_remove(mdiodev, false))
+			mdiodev->device_free(mdiodev);
+		mdio_device_put(mdiodev);
+	}
+
+	mutex_lock(&bus->mdio_map_lock);
+	list_splice_init(&bus->mdio_map_retired_phys, &removed);
+	mutex_unlock(&bus->mdio_map_lock);
+
+	list_for_each_entry_safe(phydev, next, &removed, retired_node) {
+		list_del_init(&phydev->retired_node);
+		mdio_device_put(&phydev->mdio);
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
@@ -552,10 +628,9 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
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
@@ -596,7 +671,9 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	 *
 	 * State will be updated later in this function in case of success
 	 */
+	mutex_lock(&bus->mdio_map_lock);
 	bus->state = MDIOBUS_UNREGISTERED;
+	mutex_unlock(&bus->mdio_map_lock);
 
 	err = device_register(&bus->dev);
 	if (err) {
@@ -613,8 +690,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		err = dev_err_probe(&bus->dev, PTR_ERR(gpiod),
 				    "mii_bus %s couldn't get reset GPIO\n",
 				    bus->id);
-		device_del(&bus->dev);
-		return err;
+		goto error_reset_gpiod;
 	} else	if (gpiod) {
 		bus->reset_gpiod = gpiod;
 		fsleep(bus->reset_delay_us);
@@ -629,6 +705,10 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error_reset_gpiod;
 	}
 
+	mutex_lock(&bus->mdio_map_lock);
+	bus->state = MDIOBUS_REGISTERING;
+	mutex_unlock(&bus->mdio_map_lock);
+
 	if (bus->read) {
 		err = mdiobus_scan_bus_c22(bus);
 		if (err)
@@ -643,20 +723,17 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
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
@@ -668,21 +745,11 @@ EXPORT_SYMBOL(__mdiobus_register);
 
 void mdiobus_unregister(struct mii_bus *bus)
 {
-	struct mdio_device *mdiodev;
-	int i;
-
 	if (WARN_ON_ONCE(bus->state != MDIOBUS_REGISTERED))
 		return;
-	bus->state = MDIOBUS_UNREGISTERED;
 
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		mdiodev = bus->mdio_map[i];
-		if (!mdiodev)
-			continue;
-
-		mdiodev->device_remove(mdiodev);
-		mdiodev->device_free(mdiodev);
-	}
+	mdiobus_stop_device_changes(bus);
+	mdiobus_remove_devices(bus);
 
 	/* Put PHYs in RESET to save power */
 	if (bus->reset_gpiod)
@@ -702,8 +769,11 @@ EXPORT_SYMBOL(mdiobus_unregister);
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
@@ -711,6 +781,7 @@ void mdiobus_free(struct mii_bus *bus)
 	WARN(bus->state != MDIOBUS_UNREGISTERED,
 	     "%s: not in UNREGISTERED state\n", bus->id);
 	bus->state = MDIOBUS_RELEASED;
+	mutex_unlock(&bus->mdio_map_lock);
 
 	put_device(&bus->dev);
 }
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 06151f207134..119fd2fbc12d 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -15,6 +15,7 @@
 #include <linux/mdio.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -33,12 +34,16 @@
 static int mdio_device_register_reset(struct mdio_device *mdiodev)
 {
 	struct reset_control *reset;
+	int err;
 
 	/* Deassert the optional reset signal */
 	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
 						 "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(mdiodev->reset_gpio))
-		return PTR_ERR(mdiodev->reset_gpio);
+	if (IS_ERR(mdiodev->reset_gpio)) {
+		err = PTR_ERR(mdiodev->reset_gpio);
+		mdiodev->reset_gpio = NULL;
+		return err;
+	}
 
 	if (mdiodev->reset_gpio)
 		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
@@ -116,6 +121,8 @@ static void mdio_device_release(struct device *dev)
 	kfree(to_mdio_device(dev));
 }
 
+static int __mdio_device_remove(struct mdio_device *mdiodev, bool dynamic);
+
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 {
 	struct mdio_device *mdiodev;
@@ -129,7 +136,7 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 	mdiodev->dev.parent = &bus->dev;
 	mdiodev->dev.bus = &mdio_bus_type;
 	mdiodev->device_free = mdio_device_free;
-	mdiodev->device_remove = mdio_device_remove;
+	mdiodev->device_remove = __mdio_device_remove;
 	mdiodev->bus = bus;
 	mdiodev->addr = addr;
 	mdiodev->reset_state = -1;
@@ -159,19 +166,27 @@ int mdio_device_register(struct mdio_device *mdiodev)
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
@@ -183,42 +198,215 @@ EXPORT_SYMBOL(mdio_device_register);
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
+	if (bus->mdio_map_removing) {
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
-
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
+ * @removing: whether to start an exclusive removal transaction
+ *
+ * Return: zero on success or a negative error code when the bus is unavailable
+ */
+int mdiobus_device_change_begin(struct mii_bus *bus, bool removing)
 {
-	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
-		return -EINVAL;
+	int err = 0;
 
-	mdio_device_unregister_reset(mdiodev);
+	mutex_lock(&bus->mdio_map_lock);
+	if (bus->state != MDIOBUS_REGISTERED) {
+		err = -ENODEV;
+	} else if (bus->mdio_map_removing ||
+		   (removing && bus->mdio_map_ops)) {
+		err = -EBUSY;
+	} else {
+		bus->mdio_map_ops++;
+		if (removing)
+			bus->mdio_map_removing = true;
+	}
+	mutex_unlock(&bus->mdio_map_lock);
 
-	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
+	return err;
+}
+EXPORT_SYMBOL_GPL(mdiobus_device_change_begin);
 
-	return 0;
+static void mdiobus_operation_done_locked(struct mii_bus *bus)
+{
+	lockdep_assert_held(&bus->mdio_map_lock);
+
+	if (WARN_ON_ONCE(!bus->mdio_map_ops))
+		return;
+	bus->mdio_map_ops--;
+	if (!bus->mdio_map_ops)
+		wake_up_all(&bus->mdio_map_wait);
+}
+
+/**
+ * mdiobus_device_change_end - finish changing devices on an MDIO bus
+ * @bus: MDIO bus previously passed to mdiobus_device_change_begin()
+ * @removing: value passed to mdiobus_device_change_begin()
+ */
+void mdiobus_device_change_end(struct mii_bus *bus, bool removing)
+{
+	mutex_lock(&bus->mdio_map_lock);
+	if (removing) {
+		WARN_ON_ONCE(!bus->mdio_map_removing);
+		bus->mdio_map_removing = false;
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
+	if (err) {
+		mdiobus_unpublish_device(mdiodev);
+	} else {
+		WARN_ON_ONCE(bus->mdio_map[mdiodev->addr]);
+		/* Teardown waits for this operation before consuming the map. */
+		smp_store_release(&bus->mdio_map[mdiodev->addr], mdiodev);
+	}
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
+	struct phy_device *phydev = NULL;
+	int err = 0;
+
+	mutex_lock(&bus->mdio_map_lock);
+	if (dynamic && bus->state != MDIOBUS_REGISTERED) {
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
+	if (dynamic && mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+		phydev = to_phy_device(&mdiodev->dev);
+		if (phydev->attached) {
+			err = -EBUSY;
+			goto out_unlock;
+		}
+	}
+
+	mdiobus_unpublish_device(mdiodev);
+
+	if (dynamic && mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+		mdio_device_get(mdiodev);
+		list_add_tail(&phydev->retired_node,
+			      &bus->mdio_map_retired_phys);
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
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 4865eac74b0e..546911858e3e 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1279,10 +1279,8 @@ static struct vsc8531_private *vsc8584_base_priv(struct phy_device *phydev)
 	struct vsc8531_private *vsc8531 = phydev->priv;
 
 	if (vsc8531->ts_base_addr != phydev->mdio.addr) {
-		struct mdio_device *dev;
-
-		dev = phydev->mdio.bus->mdio_map[vsc8531->ts_base_addr];
-		phydev = container_of(dev, struct phy_device, mdio);
+		phydev = mdiobus_get_phy(phydev->mdio.bus,
+					 vsc8531->ts_base_addr);
 
 		return phydev->priv;
 	}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d65f28dd5773..55a0e06acdf5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -227,12 +227,14 @@ static void phy_device_release(struct device *dev)
 	kfree(to_phy_device(dev));
 }
 
-static void phy_mdio_device_remove(struct mdio_device *mdiodev)
+static int __phy_device_remove(struct phy_device *phydev, bool dynamic);
+
+static int phy_mdio_device_remove(struct mdio_device *mdiodev, bool dynamic)
 {
 	struct phy_device *phydev;
 
 	phydev = container_of(mdiodev, struct phy_device, mdio);
-	phy_device_remove(phydev);
+	return __phy_device_remove(phydev, dynamic);
 }
 
 static struct phy_driver genphy_driver;
@@ -769,6 +771,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	mdiodev->device_free = phy_mdio_device_free;
 	mdiodev->device_remove = phy_mdio_device_remove;
 	mdiodev->reset_state = -1;
+	INIT_LIST_HEAD(&dev->retired_node);
 
 	dev->speed = SPEED_UNKNOWN;
 	dev->duplex = DUPLEX_UNKNOWN;
@@ -1121,25 +1124,40 @@ int phy_device_register(struct phy_device *phydev)
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
@@ -1151,15 +1169,7 @@ EXPORT_SYMBOL(phy_device_register);
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
 
@@ -1734,6 +1744,36 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
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
+	    bus->mdio_map_removing ||
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
@@ -1755,6 +1795,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct module *bus_owner = phydev->mdio.bus->owner;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
+	bool claimed = false;
 	int err;
 
 	/* For Ethernet device drivers that register their own MDIO bus, we
@@ -1770,6 +1811,13 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
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
@@ -1798,12 +1846,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
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
@@ -1899,6 +1941,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
+	if (claimed)
+		phy_release(phydev);
 	put_device(d);
 	if (ndev_owner != bus_owner)
 		module_put(bus_owner);
@@ -1918,7 +1962,6 @@ void phy_detach(struct phy_device *phydev)
 	struct net_device *dev = phydev->attached_dev;
 	struct module *ndev_owner = NULL;
 	struct module *bus_owner;
-	struct mii_bus *bus;
 
 	if (phydev->devlink) {
 		device_link_del(phydev->devlink);
@@ -1974,8 +2017,8 @@ void phy_detach(struct phy_device *phydev)
 	phy_device_reset(phydev, 1);
 
 	/* The PHY and its parent bus may be released by put_device() below. */
-	bus = phydev->mdio.bus;
-	bus_owner = bus->owner;
+	bus_owner = phydev->mdio.bus->owner;
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
index a7d9e3ae362a..7ce784af0c66 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -31,7 +31,7 @@ struct mdio_device {
 
 	int (*bus_match)(struct device *dev, const struct device_driver *drv);
 	void (*device_free)(struct mdio_device *mdiodev);
-	void (*device_remove)(struct mdio_device *mdiodev);
+	int (*device_remove)(struct mdio_device *mdiodev, bool dynamic);
 
 	/* Bus address of the MDIO device (0-31) */
 	int addr;
@@ -694,6 +694,8 @@ static inline int mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
 
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr);
 struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr);
+int mdiobus_device_change_begin(struct mii_bus *bus, bool removing);
+void mdiobus_device_change_end(struct mii_bus *bus, bool removing);
 
 /**
  * mdio_module_driver() - Helper macro for registering mdio drivers
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868e0f..9a8fe5ea2b74 100644
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
+	/** @mdio_map_ops: active registrations, scans and firmware changes */
+	unsigned int mdio_map_ops;
+	/** @mdio_map_removing: firmware removal blocking map changes and attachment */
+	bool mdio_map_removing;
+	/** @mdio_map_retired_phys: removed PHYs pinned until bus teardown */
+	struct list_head mdio_map_retired_phys;
 
 	/** @phy_mask: PHY addresses to be ignored when probing */
 	u32 phy_mask;
@@ -652,6 +667,9 @@ struct phy_oatc14_sqi_capability {
  * @n_ports: Number of ports currently attached to the PHY
  * @max_n_ports: Max number of ports this PHY can expose
  * @lock:  Mutex for serialization access to PHY
+ * @attached: Whether a network device or standalone user attached the PHY;
+ *	protected by the MDIO bus map lock
+ * @retired_node: Entry in mii_bus::mdio_map_retired_phys
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -781,6 +799,8 @@ struct phy_device {
 	struct delayed_work state_queue;
 
 	struct mutex lock;
+	bool attached;
+	struct list_head retired_node;
 
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;

-- 
2.53.0

