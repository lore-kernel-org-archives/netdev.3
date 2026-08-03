Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117503BCD25
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800954; cv=none; b=U4WH7cThZ3NO5zHwolEpLuibccyrCsWb0hg8ddkgBuGyAIIgYzVRhPsTB8Ah2nI3np/Mi0TOhDfRsdo7KNMRCEkV+bCmw9A1uJvsZ9xO385wpnolBQiCjxtQPGHZIQ4K9SI6oiFv0umCjm4jYA8CMeFvTZFlhgZZbVmYF/EBx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800954; c=relaxed/simple;
	bh=grXQKNe0w+OJju9ewydN5GE7QXdhO9GdUWW29RXPp8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfqcT3dj/4vcQugLwR4kKXa3TmZVxUeQoEDMm4PccgPmY2PbKVUdXWUMaTyGZk/yloA63g/lGxEmV7aQZGajbxSLGlre7tMrtFyjPMpXRWMhKhsx/9v4RqhAbnZDjGkYR4dPgr0DnbiHo1t4lcuT90bPZHEa/sv9QXhKRVvrR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj1bk2xq; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj1bk2xq"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so1446441eaf.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800943; x=1786405743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdxDECJ7VkmFlnPEleTjH+xT2i4EwQ2PC/v7KEOQM2Y=;
        b=Hj1bk2xqxZltg0HgBGNzPRTO/gewlmln39+SAqI8W72tRGH69SykvZyvv4gSdBOTSJ
         ujt1Be51e1pwjASqR6HJMdrTYBre52Z5TiGr+NkBnLO3JFoa3UH67v5SatOxTsdMvjE0
         QsQVq98rE3N8OORyfuVTuxjtRZmDZEKraplkqTcE8WT2V3BuzD5/7cy/7UETKTJr8hli
         a9twDxJSDcw7QDVqrwA/vtRjLJrbGB0aChPMLO+J8+AsZP2IyizWYqm1c6tlX3mnjn5k
         NvANXKNqlVvJqF4ZaNJqg243+YbW62QgmkeUtJOo+5A7GkxwOIUaKekpeq+T+t38h0nU
         MzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800943; x=1786405743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jdxDECJ7VkmFlnPEleTjH+xT2i4EwQ2PC/v7KEOQM2Y=;
        b=CZVw775DtrVtYStCadRfUx7DCbo4kKc28wsGGD3zW3zT/y3BKEm0iTF7esZ4qI6Okf
         wRvWrAtMOgKcplD7sjK2aknNAo/pKlmNVE9/IwC9j4mCLJnvXjoALbRI1MiaHrJXoihc
         KDrKc1tEi5ca7fy0OiPc902H3EUcOJF6lxSAWBa4g/DESCB3akU/8ECkQzqEbYdse51e
         owZGEbq6+ugfwuPHPO1G9rIsyXu4nGQQi2j1MRvteyhRY+euOSt6cTYqOoiZV1wIhXl5
         H/2+CPLXYApiLwUIQgtyU6ZTDGd6iFFLyeAr+e6jRMuRiyjrRG57Ab8UKz+KO+Wv8b9y
         A6zw==
X-Gm-Message-State: AOJu0Yz3UgSQupfwfLqh+mLIY3DEQS+ftblkuvLvQLkU1CshSCJVhdkA
	rq+khjq6qYQmpMT1SrJa5IKIPRwQ6jTdbMP57BZFUzz0b5wd7YwQPjO/
X-Gm-Gg: AR+sD12z01nLJwWtXMVS5xz2K+Lr4y64Af8TUJu7IwTL+MW6cXoa+1G8OvmDtHNR5xU
	3aw7H4hiaQLPiEkH21QvXSAqUArZHtFzyoo5y3UmCT7D1tBefTklTYZUDiDzr0tgxk9Upy/BudE
	6o0w0c5qXkQ08fbMYVj7rS8vWSW3D16ltEAVkiSX/bn/9qXW9qv+xMpWHMClvxlhf2MCyGHlIP5
	5Me4g2JBFDxHbxxIPWE+RyiDxCzHD/4BHtNIaHD/wrpYh5uYTwAKU6i7zLNyY6SKj/AAQ7sSPMq
	xxhvH4zQvqztghVRSOYCK+iRbQYgOoVguv5tmfX9N3oTy4u0sfDCPqUMW0SzpXPzbjELP85mYGz
	QYZDkdySMBwe/8BWBm1nOWkbAyH68iW7H0wJNC4HnBgaP7tHnpt3O8k9OKZXTPddkwSFsF665n2
	5N6M1/CeWAqr8rEx9FiZNbU2GPN02XzjDPjDeNiKG2pGxGOrWWToDIb2Bs+aDIZUCQHUfTvnlGn
	SH4LGB+/t8pdtbnm7L9y75OfO4tjEcrg0qOsHDzwTMiilZ0GvsClP9hSc8VeQKIZxIoNfWjTzTy
	UNzGk0xZoLdSTAO2QwXCKBpkl5u1abSRgc/m/mBGi+TqxT+NBtdxad+VwZfmcym8usWTJ8uqQOu
	eA2BfujoLSwTDeaCC
X-Received: by 2002:a05:6820:2010:b0:6ae:648d:9ff9 with SMTP id 006d021491bc7-6ae648dac2emr9965860eaf.26.1785800938544;
        Mon, 03 Aug 2026 16:48:58 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f60ea539sm10452201fac.8.2026.08.03.16.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:48:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 03 Aug 2026 17:48:12 -0600
Subject: [PATCH net-next v2 3/3] net: mdio: support dynamic OF device
 changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-submit-mdio-of-dynamic-v2-v2-3-f8841f3124d7@gmail.com>
References: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>
In-Reply-To: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
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
Changes v1 -> v2:
  - split from the ACx00 series
  - move the PHY declaration to function scope for netdev style
---
 drivers/net/mdio/of_mdio.c | 448 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 438 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 051e449bbe7c..c89f88aacd8d 100644
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
+	struct phy_device *phydev;
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
+		phydev = to_phy_device(&mdiodev->dev);
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

