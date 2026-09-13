Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9573F9A1E
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789329609; cv=none; b=bbEpO9Ns6m+MBjqqsoENgIIbn7b8jHo5w0KMJ1ih/tibRYBKyFbmHieTyWaouFreaImfDRGEFAEffZE4DJ1eEiQ/dcLZH6+/qsnN/JPZt/W6H2TAxZP/ijnWylIiLpj+yjlEt/uR8HPq/xG+7zD4qbYjNUYTauTNvmwrincO9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789329609; c=relaxed/simple;
	bh=O/RJ8UxkScn5Ml5bOIB2svVD3wv6ppSYKTuQhbT7DX8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mVKEqnObouAMsMtmYq0tP5g8xirHOr+rLxOElig8nebZz2n4NnNh4CGxhwmW67HiZ7CrzomX5dvlaVnUUN7Vs/7I9Nr2BgMAX9H9umwaR9V1YC5XO4+Vl1cDX9ILm9LFDkccodUIk4zPU/ph9G2C8Tgc4kXH/WiXM63PaTT4kaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUsaUlqD; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUsaUlqD"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso9754485e9.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789329606; x=1789934406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5BCd/4qm1fpv7p66782CgOKQ0MpRiFbIMJ5Q1aBJGws=;
        b=fUsaUlqD6ZMIQ18gzQ9a2nH2S5GbYEHN008mbW5CmOqRu+kLMG2xs9Yn3MIwzdH5gc
         nBLk99NemqahGqW9LV9XE/qK4OIC9fGroshaY65NlYBDTgrUIEHWIYLSzzfKrCaVvM2T
         RHX97xINgK2BNrvetfreul+WxaVLTcV+u5fIjnTkSdNobWNCds4gFD96d7Pl8iTNWSX6
         oRN0h+EG3Ny0PRoTHz6+n4G7ogXNLndwYA23aAVn30vo8N6IT6Y3YRGZfWxJRbmC6Mkv
         sQRgLRxa78xvh465+IxP+8qIfPoSFRKCOY3DKglaVJjZ0Y6qW58Vs/1hLcrAHVWlZgHn
         Z3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789329606; x=1789934406;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5BCd/4qm1fpv7p66782CgOKQ0MpRiFbIMJ5Q1aBJGws=;
        b=SmHX+G2uVwhh6sRaUNw07cexLSTh4IeDAi5E4rFHSk9NoWcGziO8rqtPnVvF7ZY5as
         RYyRO5ymDh9hSY0y8I16WQU+Z9BMeQxrGuPtQQ3ng+tc4PaWfHx0SC/Ks9D0Km2YRHNG
         56oGyyTwYZexwJfI/x0yO4z+4JfLp73qzoAk8Bw0pmT8YMWqBQ04nHEluJc6bIsyYvJr
         Kar3j2CP6HVkKr/vDn7m4gCHeM3iOWdf9LFHZHPFIGWW3BGMbYZasmMMytWx97WhnSGz
         wbTAFYx4U0j5vLXUeSQOMUJ3Lf2E97ZAzZntL6JQjyT3WrZzv5FBRS/j8tmP6oMMhBQD
         utBQ==
X-Gm-Message-State: AFuF++l9VSegnHu7dUPmcb+nXpu5b+zLe4AoJIawsqhF1so/8Q24i8T5
	NNN7uJlXKWFyA0eHKhl9CKeX3AAP+JObGS5cQ8o/seWFs5mGE8UCM8FW
X-Gm-Gg: AYBFou1/OrZln7RpXRkskYhBqSA+3h2EbuzmEPRdLLD6M9/iWmPJa6Scuj4+KS2h9K0
	SyILKT6Vc8i0vSgdrrfbtG69WEWMwpa0xcgdtmBfVxBi2eSKAcp3xfhvuEA1kdZWkvI//cozIzU
	m0fZk00Vg7XgZfTGRVpzPoKfrrewu6b5PkCeZR9AwJ1gYoDEKS4MzXg5gFeh1D3OJ+EC68DFluP
	xygYCc6b22bVmEruvgJ8t79NGBQNk4yJtJRh9lHvV439KWIGyIAUwdFUsoaAKqYctpNZ1JM9Pvq
	hZ7Chn0AeBppYPIwtofuTfUf6H/3iBijkCfq5jEXNiFz3OiriinXxOxF9hZIZBIFl6wOh8C557T
	dqYBJXUTE4i5k4TAidHlRi4B8t6mYsZtH0hRbsRuZCZHsHQBWNkqYGkXLusfPoOHGekugtbOo5w
	tz4HIIwhz2XGtIhmXY+I1c6ATPHDZi9YGiHQ8/IXDUleZLvcoqueKVHyjvt/kNN5aSQmV4EKGcU
	ZD8ud5XPttPOO+/j6YIjHqxvj6TEvIDbzsBDwva4XoZejVGUrlV1TrLclJHHm8nyIjQQz51jZ6J
	2vJVvozm5iwjUrJ3mW0pb1hbIidIArLx
X-Received: by 2002:a05:600c:4f8e:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49e619a1c3bmr314991135e9.1.1789329605508;
        Sun, 13 Sep 2026 13:00:05 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4f:7700:985e:3d25:6999:4ab9? (p200300ea8f4f7700985e3d2569994ab9.dip0.t-ipconnect.de. [2003:ea:8f4f:7700:985e:3d25:6999:4ab9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60acff8bsm260001815e9.9.2026.09.13.13.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 13:00:05 -0700 (PDT)
Message-ID: <9bf96f6b-2d08-402a-af5b-cc6b33fc6d26@gmail.com>
Date: Sun, 13 Sep 2026 22:00:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RESUBMIT net-next] net: phy: factor out legacy PHY fixup
 support and make it always built-in
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

PHY fixup registration is used from platform code in init phase only.
Let's move the PHY fixup code from the modular part of phylib to the
always built-in part of phylib. This allows to annotate the fixup
registration as __init. No caller uses the return code of PHY fixup
registration, therefore change related functions to return void.

phy_needs_fixup() and phy_scan_fixups() wouldn't have to be moved to
the built-in part of phylib. But doing so allows to fully factor out
legacy fixup support into its own source code file, and make struct
phy_fixup and phy_fixup_list strictly private to phy_fixup.c.

phy_scan_fixups() is used after init phase only, then phy_fixup_list
is read-only. So we don't need the mutex when accessing the list.
Also when registering PHY fixups the mutex isn't needed, because
fixup registration is done sequentially from platform init code.
Actually there is only one platform with more than one fixup.

In addition this change lays the foundation for enabling modular
phylib on platforms where the fixup just sets a flag.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
This is a resubmit from Jan 2026. The change depends on removal of the
dnet driver, and at that time the dnet driver had just been removed,
with a certain risk that this removal has to be reverted.
---
 drivers/net/phy/Makefile          |  2 +-
 drivers/net/phy/phy_device.c      | 90 ----------------------------
 drivers/net/phy/phy_fixup.c       | 99 +++++++++++++++++++++++++++++++
 drivers/net/phy/phylib-internal.h |  1 +
 include/linux/phy.h               |  8 +--
 5 files changed, 105 insertions(+), 95 deletions(-)
 create mode 100644 drivers/net/phy/phy_fixup.c

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index e23df5e836e..4674eaf243e 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -8,7 +8,7 @@ libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
 
 ifdef CONFIG_PHYLIB
 # built-in whenever PHYLIB is built-in or module
-obj-y				+= stubs.o
+obj-y				+= stubs.o phy_fixup.o
 endif
 
 libphy-$(CONFIG_SWPHY)		+= swphy.o
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a..27c0cb13860 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -49,14 +49,6 @@ MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
 
-struct phy_fixup {
-	struct list_head list;
-	char bus_id[MII_BUS_ID_SIZE + 3];
-	u32 phy_uid;
-	u32 phy_uid_mask;
-	int (*run)(struct phy_device *phydev);
-};
-
 static struct phy_driver genphy_c45_driver = {
 	.phy_id         = 0xffffffff,
 	.phy_id_mask    = 0xffffffff,
@@ -237,9 +229,6 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 
 static struct phy_driver genphy_driver;
 
-static LIST_HEAD(phy_fixup_list);
-static DEFINE_MUTEX(phy_fixup_lock);
-
 static bool phy_drv_wol_enabled(struct phy_device *phydev)
 {
 	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
@@ -427,85 +416,6 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
 			 mdio_bus_phy_resume);
 
-/**
- * phy_register_fixup - creates a new phy_fixup and adds it to the list
- * @bus_id: A string which matches phydev->mdio.dev.bus_id (or NULL)
- * @phy_uid: Used to match against phydev->phy_id (the UID of the PHY)
- * @phy_uid_mask: Applied to phydev->phy_id and fixup->phy_uid before
- *	comparison (or 0 to disable id-based matching)
- * @run: The actual code to be run when a matching PHY is found
- */
-static int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
-			      int (*run)(struct phy_device *))
-{
-	struct phy_fixup *fixup = kzalloc_obj(*fixup);
-
-	if (!fixup)
-		return -ENOMEM;
-
-	if (bus_id)
-		strscpy(fixup->bus_id, bus_id, sizeof(fixup->bus_id));
-	fixup->phy_uid = phy_uid;
-	fixup->phy_uid_mask = phy_uid_mask;
-	fixup->run = run;
-
-	mutex_lock(&phy_fixup_lock);
-	list_add_tail(&fixup->list, &phy_fixup_list);
-	mutex_unlock(&phy_fixup_lock);
-
-	return 0;
-}
-
-/* Registers a fixup to be run on any PHY with the UID in phy_uid */
-int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
-			       int (*run)(struct phy_device *))
-{
-	return phy_register_fixup(NULL, phy_uid, phy_uid_mask, run);
-}
-EXPORT_SYMBOL(phy_register_fixup_for_uid);
-
-/* Registers a fixup to be run on the PHY with id string bus_id */
-int phy_register_fixup_for_id(const char *bus_id,
-			      int (*run)(struct phy_device *))
-{
-	return phy_register_fixup(bus_id, 0, 0, run);
-}
-EXPORT_SYMBOL(phy_register_fixup_for_id);
-
-static bool phy_needs_fixup(struct phy_device *phydev, struct phy_fixup *fixup)
-{
-	if (!strcmp(fixup->bus_id, phydev_name(phydev)))
-		return true;
-
-	if (fixup->phy_uid_mask &&
-	    phy_id_compare(phydev->phy_id, fixup->phy_uid, fixup->phy_uid_mask))
-		return true;
-
-	return false;
-}
-
-/* Runs any matching fixups for this phydev */
-static int phy_scan_fixups(struct phy_device *phydev)
-{
-	struct phy_fixup *fixup;
-
-	mutex_lock(&phy_fixup_lock);
-	list_for_each_entry(fixup, &phy_fixup_list, list) {
-		if (phy_needs_fixup(phydev, fixup)) {
-			int err = fixup->run(phydev);
-
-			if (err < 0) {
-				mutex_unlock(&phy_fixup_lock);
-				return err;
-			}
-			phydev->has_fixups = true;
-		}
-	}
-	mutex_unlock(&phy_fixup_lock);
-
-	return 0;
-}
-
 /**
  * genphy_match_phy_device - match a PHY device with a PHY driver
  * @phydev: target phy_device struct
diff --git a/drivers/net/phy/phy_fixup.c b/drivers/net/phy/phy_fixup.c
new file mode 100644
index 00000000000..f49fc4cefe8
--- /dev/null
+++ b/drivers/net/phy/phy_fixup.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PHY fixup support
+ */
+
+#include <linux/list.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "phylib-internal.h"
+
+static struct list_head phy_fixup_list __ro_after_init =
+	LIST_HEAD_INIT(phy_fixup_list);
+
+struct phy_fixup {
+	struct list_head list;
+	char bus_id[MII_BUS_ID_SIZE + 3];
+	u32 phy_uid;
+	u32 phy_uid_mask;
+	int (*run)(struct phy_device *phydev);
+};
+
+/**
+ * phy_register_fixup - creates a new phy_fixup and adds it to the list
+ * @bus_id: A string which matches phydev->mdio.dev.bus_id (or PHY_ANY_ID)
+ * @phy_uid: Used to match against phydev->phy_id (the UID of the PHY)
+ *	It can also be PHY_ANY_UID
+ * @phy_uid_mask: Applied to phydev->phy_id and fixup->phy_uid before
+ *	comparison
+ * @run: The actual code to be run when a matching PHY is found
+ */
+static void __init phy_register_fixup(const char *bus_id, u32 phy_uid,
+				      u32 phy_uid_mask,
+				      int (*run)(struct phy_device *))
+{
+	struct phy_fixup *fixup = kzalloc_obj(*fixup);
+
+	if (!fixup)
+		return;
+
+	if (bus_id)
+		strscpy(fixup->bus_id, bus_id);
+	fixup->phy_uid = phy_uid;
+	fixup->phy_uid_mask = phy_uid_mask;
+	fixup->run = run;
+
+	list_add_tail(&fixup->list, &phy_fixup_list);
+}
+
+/* Registers a fixup to be run on any PHY with the UID in phy_uid */
+void __init phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
+				       int (*run)(struct phy_device *))
+{
+	phy_register_fixup(NULL, phy_uid, phy_uid_mask, run);
+}
+
+/* Registers a fixup to be run on the PHY with id string bus_id */
+void __init phy_register_fixup_for_id(const char *bus_id,
+				      int (*run)(struct phy_device *))
+{
+	phy_register_fixup(bus_id, 0, 0, run);
+}
+
+static bool phy_needs_fixup(struct phy_device *phydev, struct phy_fixup *fixup)
+{
+	if (!strcmp(fixup->bus_id, phydev_name(phydev)))
+		return true;
+
+	if (fixup->phy_uid_mask &&
+	    phy_id_compare(phydev->phy_id, fixup->phy_uid, fixup->phy_uid_mask))
+		return true;
+
+	return false;
+}
+
+/**
+ * phy_scan_fixups - runs any matching fixups for this phydev
+ * @phydev: the phydev to search and run fixups for
+ * Returns: 0 or an errno
+ */
+int phy_scan_fixups(struct phy_device *phydev)
+{
+	struct phy_fixup *fixup;
+
+	list_for_each_entry(fixup, &phy_fixup_list, list) {
+		if (phy_needs_fixup(phydev, fixup)) {
+			int err = fixup->run(phydev);
+
+			if (err < 0)
+				return err;
+
+			phydev->has_fixups = true;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(phy_scan_fixups);
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index 664ed7faa51..38ee294f3c9 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -23,6 +23,7 @@ void of_set_phy_eee_broken(struct phy_device *phydev);
 void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 void phy_check_downshift(struct phy_device *phydev);
+int phy_scan_fixups(struct phy_device *phydev);
 
 int mdiobus_register_device(struct mdio_device *mdiodev);
 int mdiobus_unregister_device(struct mdio_device *mdiodev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868e0..f799b3684cd 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2422,10 +2422,10 @@ int phy_get_mac_termination(struct phy_device *phydev, struct device *dev,
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 
-int phy_register_fixup_for_id(const char *bus_id,
-			      int (*run)(struct phy_device *));
-int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
-			       int (*run)(struct phy_device *));
+void __init phy_register_fixup_for_id(const char *bus_id,
+				      int (*run)(struct phy_device *));
+void __init phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
+				       int (*run)(struct phy_device *));
 
 int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
 int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
-- 
2.55.0

