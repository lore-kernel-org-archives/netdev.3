Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE63932CD
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538729; cv=none; b=qUhQPqMKQE6RNGF292DoVi3i4ypfdXAIea2lximUv/0+Y5/lnb/zpys+bqsWFqxqDkdzP66wflhdmMX/FVE5xZEUu1ZngGPeTD/WOQcK6hUv6kssoUV7T1jpAmWJUidB7TQ8ouJwOhXc9t+WVWQqL11IcQ1x8Jex5gAgWWQEZ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538729; c=relaxed/simple;
	bh=jROTR0ITRns0tiedyiy8ATd83fnU+oIF0ulm8QoJPN8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cRlbu9rmk3Mzr/dWq5ZuY7CKul0V6nUjdO2ehmmaPWf9YfuUbraVObTjSl5LHqebZJYN5Sc7C5wz4rC1EWXxW8ooyNwv4vcHAlrsUkv2ug/iYWLhtuE6XdDcOG4y3KTzi5mnvAIOh9r6oaJiT8f2+xrDROOQMfwOdb1GPQ4P80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6KRLndP; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6KRLndP"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so5896855e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538725; x=1790143525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rbq2d0oIKc7y+4xN1GVI1HKIPTsHL3IMPxXwacqWNvY=;
        b=V6KRLndP1hW6Cg3+v0CE+HzTd8Wvx8AQeihMJIn3Cp5Uom93qUc3XMezKL+BDMX1++
         LW8g2o8JPnvbGGuUDCtgEVpeTGgxilIa9COonGAC1+RtGbAXiPG8yA+YJDQFdSJB/Re5
         CkzPg6SpbhrEOb2KAFNOPC4cOB5/koVHp6Cmikbj7hWkctGcT4ktwTUfgwf8ho1xG1Kd
         WI48YiA7kLTScWDjrghh0ajsmknGCMo62rgfrNjbSCcai3T6PUMNayv62Mwqgxmr4XKs
         kn34c6EGDokz/zttw+IsN9iPQYveRY/N5ln5mkJw5V7v2f8pxqce26Wk4/wOIo7eBCcE
         NPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538725; x=1790143525;
        h=content-transfer-encoding:content-type:cc:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rbq2d0oIKc7y+4xN1GVI1HKIPTsHL3IMPxXwacqWNvY=;
        b=t/SJhUKMMbtJVH3lQ6Ud2dsmv2Tbz7I6ZgDwB+Oq/kjyiSIQko1i397+TFLTvLaDgk
         xRQOSlEKJZBLJLQTCwjWhDELtoseABsKwd88C6soZLgF7y5cHm+DSGC1VgzcuS0FJsbI
         cMXyGCEgqUmPuLAxncmi4ZNYogqvopPuLA+Xhy/CLf3pUqzZvCXZ6jxn84TAjkq98/sh
         xv++FTgGN8JJq0i0kcp1rFhvdkqbHhEkXdPHpFuuxq/hTp+L/94t80hnOvZLGEOBlmq8
         cDa5lYv3elTgKein45LrTVJzCuv3qV6OcwiHcMr/nQ5sQ7HkftGdoOkN5/N10wk4L0gK
         eSpA==
X-Gm-Message-State: AFuF++m/CKFfb9GwNg9f/RWYeNYe3LRpFVHvSG5qIZhk27WrhirA7y95
	fieeBQMD00yv/XJ2LFxns1KM6QddVkGbuCFtWGYc92Ma94bFZc5TIZHF
X-Gm-Gg: AYBFou3t44+ZasCAruiFdGhDTHaVBIV/e4VlB+YmGQI99PNddCMWzGGmMew/0xqgJmx
	vc6zU37IK8iiyiyDlcyxSsgk7gWvKWXhP8K+XuJKhJf8qAyBqqAiDI9kRC2JXdIwqMTkXkRLcrq
	Isa3iVlGWROeRTcR97bJhTxY+Rv6DEMCu07da3RUVyHPEWYukv5q94GvCV221kyDqVWOIsluBpj
	ZckS38ZF4zML6HIvLiWP8HQ1key1dNU+SyOh4Sao6drRP6CbcI4/C4aPdixw/Mn/WcG5FpMCbE/
	0sMJ8HCTfEUX1Q6GJycAmqJgygxHfLGQmvu/7b8DBKEYpTYQWYuqIAe3qgZUe8BMGT54/9AnMNf
	UEu3CBS9qzilAjV60SER9RNoCcyt2RxeOanJM3ZOmsPvYytm5d3+jdgXfMyDPETt8+sVZlN5AGE
	UhXZy4MVLintHs0sdZWw5DzN8Zbokw1FWx4PPNFEqc3Qdzc13dL+St9DqhvwlhskD9gVoACO2Ju
	pPj3nB1i5U+mhESEAJOFsSM7yryR31UKT5XlD+iHoq0P42oqCzvnJCg5a+bC68ul1qxZ+od3SFv
	TCJcnlbSe6TrH5k1LTP/bsicCRWze6FPtg==
X-Received: by 2002:a05:600c:3494:b0:49c:edd8:ba35 with SMTP id 5b1f17b1804b1-49eac46394amr10945995e9.6.1789538724510;
        Tue, 15 Sep 2026 23:05:24 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f24:d900:2d12:4011:929:f698? (p200300ea8f24d9002d1240110929f698.dip0.t-ipconnect.de. [2003:ea:8f24:d900:2d12:4011:929:f698])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83a89258sm52716815e9.2.2026.09.15.23.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 23:05:24 -0700 (PDT)
Message-ID: <2d722b84-a263-400b-ac91-bf37125eb85b@gmail.com>
Date: Wed, 16 Sep 2026 08:05:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: phy: factor out legacy PHY fixup support and
 make it always built-in
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-doc@vger.kernel.org
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

Last but not least reflect the change in the documentation,
and add a hint that fixup's are legacy functionality.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- adjust kdoc and reflect the change in the documentation
---
 Documentation/networking/phy.rst  | 17 +++---
 drivers/net/phy/Makefile          |  2 +-
 drivers/net/phy/phy_device.c      | 90 ----------------------------
 drivers/net/phy/phy_fixup.c       | 98 +++++++++++++++++++++++++++++++
 drivers/net/phy/phylib-internal.h |  1 +
 include/linux/phy.h               |  8 +--
 6 files changed, 114 insertions(+), 102 deletions(-)
 create mode 100644 drivers/net/phy/phy_fixup.c

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index 0170c9d4dc5..d53067ab1a6 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -511,24 +511,27 @@ Board Fixups
 Sometimes the specific interaction between the platform and the PHY requires
 special handling.  For instance, to change where the PHY's clock input is,
 or to add a delay to account for latency issues in the data path.  In order
-to support such contingencies, the PHY Layer allows platform code to register
-fixups to be run when the PHY is brought up (or subsequently reset).
+to support such contingencies, the PHY Layer allows platform init code to
+register fixups to be run when the PHY is brought up (or subsequently reset).
+
+Note: This is legacy functionality and not supposed to be used in new code.
+      Fixup's should be handled in the PHY driver.
 
 When the PHY Layer brings up a PHY it checks to see if there are any fixups
 registered for it, matching based on UID (contained in the PHY device's phy_id
 field) and the bus identifier (contained in phydev->dev.bus_id).  Both must
-match, however two constants, PHY_ANY_ID and PHY_ANY_UID, are provided as
-wildcards for the bus ID and UID, respectively.
+match, however NULL for the bus identifier and 0 for phy_uid_mask can be
+used to disable the respective type of matching.
 
 When a match is found, the PHY layer will invoke the run function associated
 with the fixup.  This function is passed a pointer to the phy_device of
-interest.  It should therefore only operate on that PHY.
+interest. It should therefore only operate on that PHY.
 
 The platform code can register the fixup using one of::
 
- int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
+ void __init phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
 		int (*run)(struct phy_device *));
- int phy_register_fixup_for_id(const char *phy_id,
+ void __init phy_register_fixup_for_id(const char *phy_id,
 		int (*run)(struct phy_device *));
 
 Standards
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 25c4a3c2429..6c2ee118a12 100644
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
index 41d1b20cde2..5b13a74e2fa 100644
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
index 00000000000..75ed9b142cc
--- /dev/null
+++ b/drivers/net/phy/phy_fixup.c
@@ -0,0 +1,98 @@
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
+ * @bus_id: A string which matches phydev->mdio.dev.bus_id (or NULL)
+ * @phy_uid: Used to match against phydev->phy_id (the UID of the PHY)
+ * @phy_uid_mask: Applied to phydev->phy_id and fixup->phy_uid before
+ *	comparison (or 0 to disable id-based matching)
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
index 3d8afe6b7f1..257634a543a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2440,10 +2440,10 @@ int phy_get_mac_termination(struct phy_device *phydev, struct device *dev,
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

