Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86243394788
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734139; cv=none; b=cAp5sqGO54uoMQSaeTHMD6+ORrwntgrZU6Ox7rQtIQAiTfalMifozxv/eGofo+G67P9pEw6/itOb/t9CxbnKY2SpgbphBHK9mTmH5+nB9n27kAX0ob7zgRV1d9kyAWuuXydZlIj1OKh3ub7C3OIG48FEPZGw6KD0GkZOaa2lXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734139; c=relaxed/simple;
	bh=Tw9U9x3x5olXZaLQIjQpOA/JFbVYSe4nj6Dx94hoQbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kc+WEqN5+2KupAefrb2OF7+zyeJqCQNxAPTtaNUw4+MyYUB32FP3D+9b0lOcicHZVkvsinBR7DrMAHcUTybXjYtpnH7E8NZ1vKYGs1E1BYWRKzTzc9GCqPzLykcoExBmtAlXAbmTR1YCDoYiXuVgriBOKaGx10OGnEWOTuObjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U90fw1DP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U90fw1DP"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ec58fa3e01so1393111a34.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734133; x=1786338933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=maRxG9UiuybqBbIKlnDyAqHdPuODzpVicj9v0akXa2o=;
        b=U90fw1DPOa85llF/5biOK+L+0aNnJDACHawAvvKfxYLQxOGCTgVgLe1xiT2Grr1AU6
         VPojtxevL3Nc/gqor+u0eNyRjU2nTj4AzrBtOzVzAfNMzJjznxYzM1FxPcZbk/Dyl07D
         qf+YSgDpzl/nmcszYboXNRL3wpLcNVHI+QDRGxjL3g3BNTBUvJpmeeEmg1VrQZE4tltk
         NdXR3uxnV16t8/SDu4gSxGn9bEUQvBC78/WBvr45NGfQriya7TBgbyKmQAjqTLQ7et7s
         YSkwrqxWTFTM1gI8j3yy+sdjFhB2ybT5nDJGrCv745sLnor+gNmoMmmv+Pr+SydzGuh2
         prWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734133; x=1786338933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=maRxG9UiuybqBbIKlnDyAqHdPuODzpVicj9v0akXa2o=;
        b=aXJCavPBjYBfT63eFlO7nqo5oqtYldB4EtEmfBdINoMsHBhr0gq44Nm4zPfYRWzfxm
         kvz8kPz765eNCXvI8UODo1kKwwgvkEuBcg5CZxSJCgyhr3IGtvL3vxgFXCulKaW0W+Jt
         1en8mer/3EKlnRdSs4MXey1VJ4gmAgQQa5bfDwRyf1jxmPjeKsMxSzSIsYsEwFVdpnT7
         1/PUmhhvvmCQmeWiJIPgvrTAG5JbACKR6FdOsENKPqsQ/uXDNvya/dWEHhf8sa0YGas8
         qZCKFLXNNmbLQR3tsv0LChudfFFjk2FgFEZn/XVYOnBoj7+NbbzSXXeTBx+jE/6JFKWH
         mjjA==
X-Gm-Message-State: AOJu0YxSNnIoOyPGZOoNQB4a4EKzY1Gdhc/YKDkwAWUT4RZYBA0ka7Ru
	s+t69jnOyjBSPIeH1JLJOJObFzQnayCYcQEQGZ2HFp1z5X0sT+6B7gtg
X-Gm-Gg: AR+sD11j11X+9KZH/H1H0ECdRVss98UgVjJRB91wm+NBwCDPJURB32nIklTPIEHPuri
	Pr8yCxlhUDVvQ2hOXjjQ7hybGZxko1vbcW3A+o7DOi9Joezpg9GMcEn5xQ0FQ/oIcXIbkNMN5kA
	kSEJxSAyyn+J2exnfVqjFlzIkiI4rQnXplxdY+ZfqDG7kHh1nGdNMfOB9oVtkMus8xMMMrOHG52
	JNuSZAtB7W2IUckuWGB4KaMpn9a5muI3BLlaA+JrdV+O+YFJvWqTkX5v2fn3wGUIKT1IO+z9Xiy
	ImE4CqKLtnqPiZ9q+/sdmMdOMcwr5zlRG9tJwLKxIiLZLL9Nlcq2O2twCHmO0CeHfCBilpcIZxT
	BjophpS6VIGYC8DP/0+jwPhG2BtCwmgzdjykKz5YniV80YY4ytrLrZp+/toAgQ1fcoGd69upo1g
	ef1FzUmK7BIeFfRwkurMbkja2A77XQkugkT8PlMLYlN8dh2XgcITj/naFhE+40eqlH+s6lvZ7Mb
	B9J4cHS1zfIZ1qeWjch+lXTCPqWuAjIY4YRqFenCJv4GN2O5LFqW51DIcDj1CQQHmLPs7aUxgsd
	LvyJRuxjyA946SgR2++f0YiGJPBk7R0gD7MXc1x7USfmxlV+wnx8VRHFYxpGwRgqj2tNVw63aUv
	oL7YH7Lc0wGpzlY9i
X-Received: by 2002:a05:6830:61ce:b0:7dc:3db6:f02 with SMTP id 46e09a7af769-7f196d51885mr15457605a34.9.1785734128311;
        Sun, 02 Aug 2026 22:15:28 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:16 -0600
Subject: [PATCH 06/21] net: mdio: support dynamic OF device changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-6-0a53cd9e21cc@gmail.com>
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

MDIO buses enumerate firmware children only when the bus is registered.
A later DT overlay or status transition is ignored, unlike I2C and SPI.

Add an OF reconfiguration notifier. On addition, create fixed-address
PHYs and generic MDIO devices, scan free addresses for legacy PHY nodes
without reg, and recurse into Ethernet PHY packages. Track populated
nodes so static enumeration, address scanning and notifier-driven
enumeration cannot create duplicates. Walk every package child and report
the first population error without undoing devices which may already have
acquired consumers.

Serialize static and notifier-driven population while allowing a PHY
probe to enable another node on the same bus. Check the node's current
state after taking that lock so an older notification cannot override a
newer status change.

On removal, reject attached or in-flight PHYs and unregister the object
found by its OF node. This also covers PHYs found by address scanning.
Treat all PHYs in a package as one removal scope, so removing one member
cannot invalidate state used by an attached peer. Preflight overlay
removal while it can still be refused; normal changeset errors are
propagated so the caller can restore the previous state.

Hold a core MDIO change transaction across discovery and registration so
bus teardown cannot race the MDIO reads used to identify a PHY. Compile
the notifier only with CONFIG_OF_DYNAMIC and the overlay preflight only
with CONFIG_OF_OVERLAY.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 448 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 438 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 051e449bbe7c..a8313b3721f6 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -13,6 +13,7 @@
 #include <linux/fwnode_mdio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -20,6 +21,8 @@
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
+#include <linux/sched.h>
+#include <linux/string.h>
 
 #define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
 
@@ -27,6 +30,52 @@ MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("OpenFirmware MDIO bus (Ethernet PHY) accessors");
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+/*
+ * OF changes can nest when probing one MDIO device enables another node on
+ * the same bus. Serialize independent changes while allowing that nesting.
+ */
+static DEFINE_MUTEX(of_mdio_reconfig_mutex);
+static struct task_struct *of_mdio_reconfig_owner;
+static unsigned int of_mdio_reconfig_depth;
+
+static void of_mdio_reconfig_lock(void)
+{
+	if (!mutex_trylock(&of_mdio_reconfig_mutex)) {
+		if (of_mdio_reconfig_owner == current) {
+			of_mdio_reconfig_depth++;
+			return;
+		}
+		mutex_lock(&of_mdio_reconfig_mutex);
+	}
+
+	WARN_ON_ONCE(of_mdio_reconfig_owner);
+	WARN_ON_ONCE(of_mdio_reconfig_depth);
+	of_mdio_reconfig_owner = current;
+	of_mdio_reconfig_depth = 1;
+}
+
+static void of_mdio_reconfig_unlock(void)
+{
+	WARN_ON_ONCE(of_mdio_reconfig_owner != current);
+	WARN_ON_ONCE(!of_mdio_reconfig_depth);
+
+	if (--of_mdio_reconfig_depth)
+		return;
+
+	of_mdio_reconfig_owner = NULL;
+	mutex_unlock(&of_mdio_reconfig_mutex);
+}
+#else
+static inline void of_mdio_reconfig_lock(void)
+{
+}
+
+static inline void of_mdio_reconfig_unlock(void)
+{
+}
+#endif
+
 /* Extract the clause 22 phy ID from the compatible string of the form
  * ethernet-phy-idAAAA.BBBB */
 static int of_get_phy_id(struct device_node *device, u32 *phy_id)
@@ -44,7 +93,7 @@ int of_mdiobus_phy_device_register(struct mii_bus *mdio, struct phy_device *phy,
 EXPORT_SYMBOL(of_mdiobus_phy_device_register);
 
 static int of_mdiobus_register_phy(struct mii_bus *mdio,
-				    struct device_node *child, u32 addr)
+				   struct device_node *child, u32 addr)
 {
 	return fwnode_mdiobus_register_phy(mdio, of_fwnode_handle(child), addr);
 }
@@ -80,10 +129,20 @@ static int of_mdiobus_register_device(struct mii_bus *mdio,
 static int of_mdiobus_register_child(struct mii_bus *mdio,
 				     struct device_node *child, u32 addr)
 {
+	int rc;
+
+	if (of_node_test_and_set_flag(child, OF_POPULATED))
+		return 0;
+
 	if (of_mdiobus_child_is_phy(child))
-		return of_mdiobus_register_phy(mdio, child, addr);
+		rc = of_mdiobus_register_phy(mdio, child, addr);
+	else
+		rc = of_mdiobus_register_device(mdio, child, addr);
 
-	return of_mdiobus_register_device(mdio, child, addr);
+	if (rc)
+		of_node_clear_flag(child, OF_POPULATED);
+
+	return rc;
 }
 
 /* The following is a list of PHY compatible strings which appear in
@@ -255,13 +314,21 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 	if (rc)
 		return rc;
 
+	of_mdio_reconfig_lock();
+	rc = mdiobus_device_change_begin(mdio, false);
+	if (rc) {
+		of_mdio_reconfig_unlock();
+		mdiobus_unregister(mdio);
+		return rc;
+	}
+
 	/* Loop over the child nodes and register a phy_device for each phy */
 	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys);
 	if (rc)
-		goto unregister;
+		goto out_change;
 
 	if (!scanphys)
-		return 0;
+		goto out_change;
 
 	/* auto scan for PHYs with empty reg property */
 	for_each_available_child_of_node(np, child) {
@@ -272,19 +339,380 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 
 		rc = of_mdiobus_scan_phy(mdio, child);
 		if (rc && rc != -ENODEV)
-			goto put_unregister;
+			goto put_child;
+		rc = 0;
 	}
 
-	return 0;
+out_change:
+	mdiobus_device_change_end(mdio, false);
+	of_mdio_reconfig_unlock();
+	if (!rc)
+		return 0;
 
-put_unregister:
-	of_node_put(child);
-unregister:
 	mdiobus_unregister(mdio);
 	return rc;
+
+put_child:
+	of_node_put(child);
+	goto out_change;
 }
 EXPORT_SYMBOL(__of_mdiobus_register);
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+static bool of_mdiobus_node_is_available(struct device_node *node)
+{
+	return !of_node_check_flag(node, OF_DETACHED) &&
+	       of_device_is_available(node);
+}
+
+static int of_mdiobus_add_node(struct mii_bus *mdio,
+			       struct device_node *node)
+{
+	struct device_node *child;
+	int addr, rc, ret = 0;
+
+	if (!of_mdiobus_node_is_available(node))
+		return 0;
+
+	if (of_node_name_eq(node, "ethernet-phy-package")) {
+		if (!of_property_present(node, "reg"))
+			return 0;
+
+		for_each_available_child_of_node(node, child) {
+			rc = of_mdiobus_add_node(mdio, child);
+			if (rc && rc != -ENODEV && !ret)
+				ret = rc;
+		}
+
+		return ret;
+	}
+
+	addr = of_mdio_parse_addr(&mdio->dev, node);
+	if (addr < 0)
+		rc = of_mdiobus_scan_phy(mdio, node);
+	else
+		rc = of_mdiobus_register_child(mdio, node, addr);
+
+	if (rc == -ENODEV && addr >= 0)
+		dev_err(&mdio->dev,
+			"MDIO device at address %d is missing.\n", addr);
+
+	return rc;
+}
+
+static bool of_mdiobus_node_is_busy(struct mii_bus *mdio,
+				    struct device_node *node)
+{
+	struct mdio_device *mdiodev;
+	bool busy = false;
+
+	if (of_node_name_eq(node, "ethernet-phy-package")) {
+		for_each_child_of_node_scoped(node, child) {
+			if (of_mdiobus_node_is_busy(mdio, child))
+				return true;
+		}
+
+		return false;
+	}
+
+	if (!of_node_check_flag(node, OF_POPULATED))
+		return false;
+
+	mdiodev = of_mdio_find_device(node);
+	if (!mdiodev)
+		return true;
+	if (mdiodev->bus != mdio) {
+		put_device(&mdiodev->dev);
+		return false;
+	}
+
+	mutex_lock(&mdio->mdio_map_lock);
+	busy = mdio->mdio_map[mdiodev->addr] != mdiodev ||
+	       (mdio->mdio_map_pending & BIT(mdiodev->addr));
+	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+		struct phy_device *phydev = to_phy_device(&mdiodev->dev);
+
+		if (phydev->attached) {
+			busy = true;
+			dev_warn(&mdiodev->dev,
+				 "cannot remove an attached PHY; remove its consumer first\n");
+		}
+	}
+	mutex_unlock(&mdio->mdio_map_lock);
+	put_device(&mdiodev->dev);
+
+	return busy;
+}
+
+static struct device_node *
+of_mdiobus_get_removal_scope(struct device_node *node)
+{
+	struct device_node *parent;
+
+	if (of_node_name_eq(node, "ethernet-phy-package"))
+		return of_node_get(node);
+
+	parent = of_get_parent(node);
+	if (of_node_name_eq(parent, "ethernet-phy-package"))
+		return parent;
+
+	of_node_put(parent);
+	return of_node_get(node);
+}
+
+static int of_mdiobus_remove_node(struct mii_bus *mdio,
+				  struct device_node *node)
+{
+	struct mdio_device *mdiodev;
+	struct device_node *child;
+	int ret;
+
+	if (of_node_name_eq(node, "ethernet-phy-package")) {
+		for_each_child_of_node(node, child) {
+			ret = of_mdiobus_remove_node(mdio, child);
+			if (ret) {
+				of_node_put(child);
+				return ret;
+			}
+		}
+		return 0;
+	}
+
+	if (!of_node_check_flag(node, OF_POPULATED))
+		return 0;
+
+	/* The OF node lookup also covers PHYs found by address scanning. */
+	mdiodev = of_mdio_find_device(node);
+	if (!mdiodev)
+		return -EBUSY;
+	if (mdiodev->bus != mdio) {
+		put_device(&mdiodev->dev);
+		return -ENODEV;
+	}
+
+	ret = mdiodev->device_remove_dynamic(mdiodev);
+	if (!ret)
+		mdiodev->device_free(mdiodev);
+	put_device(&mdiodev->dev);
+
+	return ret == -ENODEV ? 0 : ret;
+}
+
+static struct mii_bus *of_mdiobus_find_parent(struct device_node *node)
+{
+	struct device_node *parent, *bus_node;
+	struct mii_bus *mdio;
+
+	parent = of_get_parent(node);
+	if (!parent)
+		return NULL;
+
+	if (of_node_name_eq(parent, "ethernet-phy-package")) {
+		if (!of_device_is_available(parent) ||
+		    !of_property_present(parent, "reg")) {
+			of_node_put(parent);
+			return NULL;
+		}
+
+		bus_node = of_get_parent(parent);
+		of_node_put(parent);
+	} else {
+		bus_node = parent;
+	}
+
+	mdio = of_mdio_find_bus(bus_node);
+	of_node_put(bus_node);
+
+	return mdio;
+}
+
+#if IS_ENABLED(CONFIG_OF_OVERLAY)
+/* Overlay entry notifier errors cannot stop removal after the tree changed. */
+static bool of_mdiobus_live_node_is_busy(struct device_node *node)
+{
+	struct device_node *scope;
+	struct mii_bus *mdio;
+	bool busy = true;
+
+	scope = of_mdiobus_get_removal_scope(node);
+	mdio = of_mdiobus_find_parent(scope);
+	if (!mdio)
+		goto out_put_scope;
+
+	if (!mdiobus_device_change_begin(mdio, true)) {
+		busy = of_mdiobus_node_is_busy(mdio, scope);
+		mdiobus_device_change_end(mdio, true);
+	}
+	put_device(&mdio->dev);
+
+out_put_scope:
+	of_node_put(scope);
+	return busy;
+}
+
+static struct device_node *
+of_mdiobus_overlay_target_child(struct device_node *target,
+				struct device_node *overlay_child)
+{
+	const char *name = kbasename(overlay_child->full_name);
+	struct device_node *child;
+
+	for_each_child_of_node(target, child) {
+		if (!of_node_cmp(kbasename(child->full_name), name))
+			return child;
+	}
+
+	return NULL;
+}
+
+static bool of_mdiobus_overlay_node_is_busy(struct device_node *overlay,
+					    struct device_node *target,
+					    bool added)
+{
+	struct device_node *overlay_child, *target_child;
+	bool busy, child_added;
+
+	if ((added || of_property_present(overlay, "status")) &&
+	    of_mdiobus_live_node_is_busy(target))
+		return true;
+
+	for_each_child_of_node(overlay, overlay_child) {
+		target_child = of_mdiobus_overlay_target_child(target,
+							       overlay_child);
+		if (!target_child)
+			continue;
+
+		child_added = of_node_check_flag(target_child, OF_OVERLAY);
+		busy = of_mdiobus_overlay_node_is_busy(overlay_child,
+						       target_child, child_added);
+		of_node_put(target_child);
+		if (busy) {
+			of_node_put(overlay_child);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static int of_mdiobus_overlay_notify(struct notifier_block *nb,
+				     unsigned long action, void *arg)
+{
+	struct of_overlay_notify_data *nd = arg;
+	bool busy;
+
+	if (action != OF_OVERLAY_PRE_REMOVE)
+		return NOTIFY_OK;
+
+	of_mdio_reconfig_lock();
+	busy = of_mdiobus_overlay_node_is_busy(nd->overlay, nd->target,
+					       false);
+	of_mdio_reconfig_unlock();
+
+	return busy ? notifier_from_errno(-EBUSY) : NOTIFY_OK;
+}
+
+static struct notifier_block of_mdio_overlay_notifier = {
+	.notifier_call = of_mdiobus_overlay_notify,
+};
+#endif
+
+static int of_mdiobus_notify(struct notifier_block *nb, unsigned long action,
+			     void *arg)
+{
+	struct of_reconfig_data *rd = arg;
+	struct device_node *scope;
+	struct mii_bus *mdio;
+	enum of_reconfig_change change;
+	bool removing;
+	int rc, ret = NOTIFY_OK;
+
+	of_mdio_reconfig_lock();
+	change = of_reconfig_get_state_change(action, rd);
+	switch (change) {
+	case OF_RECONFIG_CHANGE_ADD:
+		/* A newer change may have made this notification stale. */
+		if (!of_mdiobus_node_is_available(rd->dn))
+			goto out_unlock;
+		removing = false;
+		break;
+	case OF_RECONFIG_CHANGE_REMOVE:
+		/* A newer change may have made this notification stale. */
+		if (of_mdiobus_node_is_available(rd->dn))
+			goto out_unlock;
+		removing = true;
+		break;
+	default:
+		goto out_unlock;
+	}
+
+	mdio = of_mdiobus_find_parent(rd->dn);
+	if (!mdio)
+		goto out_unlock;
+
+	rc = mdiobus_device_change_begin(mdio, removing);
+	if (rc) {
+		if (!removing)
+			ret = notifier_from_errno(-EPROBE_DEFER);
+		goto out_put_mdio;
+	}
+
+	if (!removing) {
+		rc = of_mdiobus_add_node(mdio, rd->dn);
+	} else {
+		/* The node may already be detached from its parent hierarchy. */
+		scope = of_mdiobus_get_removal_scope(rd->dn);
+		if (of_mdiobus_node_is_busy(mdio, scope))
+			rc = -EBUSY;
+		else
+			rc = of_mdiobus_remove_node(mdio, rd->dn);
+		of_node_put(scope);
+	}
+
+	mdiobus_device_change_end(mdio, removing);
+	if (rc && (removing || rc != -ENODEV))
+		ret = notifier_from_errno(rc);
+
+out_put_mdio:
+	put_device(&mdio->dev);
+out_unlock:
+	of_mdio_reconfig_unlock();
+
+	return ret;
+}
+
+static struct notifier_block of_mdio_notifier = {
+	.notifier_call = of_mdiobus_notify,
+};
+
+static int __init of_mdio_init(void)
+{
+	int ret;
+
+	ret = of_reconfig_notifier_register(&of_mdio_notifier);
+	if (ret)
+		return ret;
+
+#if IS_ENABLED(CONFIG_OF_OVERLAY)
+	ret = of_overlay_notifier_register(&of_mdio_overlay_notifier);
+	if (ret)
+		of_reconfig_notifier_unregister(&of_mdio_notifier);
+#endif
+
+	return ret;
+}
+module_init(of_mdio_init);
+
+static void __exit of_mdio_exit(void)
+{
+#if IS_ENABLED(CONFIG_OF_OVERLAY)
+	of_overlay_notifier_unregister(&of_mdio_overlay_notifier);
+#endif
+	of_reconfig_notifier_unregister(&of_mdio_notifier);
+}
+module_exit(of_mdio_exit);
+#endif /* CONFIG_OF_DYNAMIC */
+
 /**
  * of_mdio_find_device - Given a device tree node, find the mdio_device
  * @np: pointer to the mdio_device's device tree node

-- 
2.53.0

