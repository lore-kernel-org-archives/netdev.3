Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3A369D62
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010210; cv=none; b=KEORTw4KoCpHwu8me7rS0v093MzHNRzJXpsi5KRDjQsqN4mM119g2c81BYVYNA++cZloswcnFki+jN0ZSLhie6cYt119qvro5aG8QObA6hdoEn3Lf8TUWZPC1xz63wrXg960jsPwHUpvG+iVxPnLtp7Lmjzy2nFURAUh44saJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010210; c=relaxed/simple;
	bh=Dp6YkmgZs+Lizy5HLAZFUbvdYwmuOcVDXFUNddxGqaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0Kb5T42PLc5ETDOyzmbdzWCOZMFyHCSB54uFdbuB/ydJvlZs1/zAGcsHmzsZLxf4YasP4hiGD/SuIxsL7QYXX77OvcS70nr/pCWC7e2JF1gq0cZkHjBVHSvZUX87dgf26d/4M8tg3XFd89vK+Hvyi634RUgRPYEAY/B6JzDt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYmhRNC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYmhRNC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493371F00A3C;
	Thu, 28 May 2026 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010209;
	bh=O+gx8P1hJDreLwKCtrpHSHwvcRxlOvJVM7AMXqdRyWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YYmhRNC+adNN7zJc08qnVARac89KT2YsdFHOTOiGoF2MbxewpbBmD7U1mfMab67m8
	 +CnVbngx50ngltUV6C7eo8QSTJqhcAZUvuYwo7IHtffDyWRh5w8liHrBdB2Hgwa/KG
	 9/jSMVNEiV3fdWt2RYWTc0c1AqeAvJDc4PrHthaTdORMD2Yy0sfs9+Vy//HdbmuoQ5
	 Ei+2nCdYl4nRqnr+iLtvw5UXXb3AbZNPRePiJFzB40CUXywN7535n4ZTrZZuAt+r1a
	 bkZ3ZbY8WQN+KcnT8/vi22HfrgQyFEnlFtdTU3ODVCW2PBo7QLy8Q3Yo6dUerJDBHs
	 gIUfQgzC3290w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/14] net: ethtool: cmis_cdb: hold instance lock for ops locked devices
Date: Thu, 28 May 2026 16:16:24 -0700
Message-ID: <20260528231637.251822-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FW module flashing was written so that the flashing happens
without holding rtnl_lock. This allows flashing multiple modules
at once. Current drivers can handle that well, but we should
let drivers depend on the netdev instance lock. Instance lock
is per netdev, and so is the module so we won't break parallel
updates.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_lock.h    | 6 ++++++
 net/ethtool/cmis_cdb.c       | 3 +++
 net/ethtool/cmis_fw_update.c | 8 ++------
 net/ethtool/module.c         | 2 ++
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 3d3aef80beac..f4c77899fb86 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -80,6 +80,12 @@ netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
 		netdev_ops_assert_locked(dev);
 }
 
+static inline void netdev_assert_locked_if_ops(const struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_assert_locked(dev);
+}
+
 static inline void netdev_lock_ops_compat(struct net_device *dev)
 {
 	if (netdev_need_ops_lock(dev))
diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index f3a53a984460..d2037c0c97f9 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -2,6 +2,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/jiffies.h>
+#include <net/netdev_lock.h>
 
 #include "common.h"
 #include "module_fw.h"
@@ -179,6 +180,7 @@ cmis_cdb_validate_password(struct ethtool_cmis_cdb *cdb,
 
 	pe_pl = *((struct cmis_password_entry_pl *)page_data.data);
 	pe_pl.password = params->password;
+	netdev_assert_locked_if_ops(dev);
 	err = ops->set_module_eeprom_by_page(dev, &page_data, &extack);
 	if (err < 0) {
 		if (extack._msg)
@@ -546,6 +548,7 @@ __ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
 	if (!page_data->data)
 		return -ENOMEM;
 
+	netdev_assert_locked_if_ops(dev);
 	err = ops->set_module_eeprom_by_page(dev, page_data, &extack);
 	if (err < 0) {
 		if (extack._msg)
diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
index 291d04d2776a..8142ac93a381 100644
--- a/net/ethtool/cmis_fw_update.c
+++ b/net/ethtool/cmis_fw_update.c
@@ -435,13 +435,9 @@ cmis_fw_update_commit_image(struct ethtool_cmis_cdb *cdb,
 static int cmis_fw_update_reset(struct net_device *dev)
 {
 	__u32 reset_data = ETH_RESET_PHY;
-	int ret;
 
-	netdev_lock_ops(dev);
-	ret = dev->ethtool_ops->reset(dev, &reset_data);
-	netdev_unlock_ops(dev);
-
-	return ret;
+	netdev_assert_locked_if_ops(dev);
+	return dev->ethtool_ops->reset(dev, &reset_data);
 }
 
 void
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index ea4fb2a76650..c3388e6d7ec8 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -226,7 +226,9 @@ static void module_flash_fw_work(struct work_struct *work)
 	module_fw = container_of(work, struct ethtool_module_fw_flash, work);
 	dev = module_fw->fw_update.dev;
 
+	netdev_lock_ops(dev);
 	ethtool_cmis_fw_update(&module_fw->fw_update);
+	netdev_unlock_ops(dev);
 
 	module_flash_fw_work_list_del(&module_fw->list);
 
-- 
2.54.0

