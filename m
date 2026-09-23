Received: from mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7170361974
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147494; cv=none; b=NZjMNBx35meqCvnMGhkWAgpF2USI5msydTnmicgJp+21d1tyO4lq5FPl8Wwu0ZetKXa/ngAlTBfaL2aKKRDC7rRrwqB/osyNm3YIwizmDDW2HknpAetWFHYpgo69hgG1KlKbIZasfruV69QsxIKsjC9G3ai10E2pqVQOyqGYPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147494; c=relaxed/simple;
	bh=JmO4KBnV8fO1FD3BarCAqzphzMIX2z2AzICksZ1mlq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hx5GkS4SpX4ZJnwA0Ivq2Ap8QMSxKTuSC+saYFZL9a2I62HpWohC8VXS0bqKjkdikv5rd2JtKPMkEa4jHlHfgtX6y1DL6PVglsBZd2ePsL6B69vilMSL1ChVxU45J1CKvSiU3UMzDvfRXgNB28jOJg/75ZHSeWUREKnP0di086Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYPwZZS5; arc=none smtp.client-ip=91.218.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYPwZZS5"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JmO4KBnV8fO1FD3BarCAqzphzMIX2z2AzICksZ1mlq0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790147489; v=1; x=1790752289;
 b=KYPwZZS5c19n50Zgw3Bo3sbhm2dd1+BpNQq6Y1dV5onk55mCf9zZ2yb1FBAXsxltvqyHWk32
 lFQ1IbuCaziU14qNCo3d52fzKhnYEhyKjYPLVPM1S0FQzfuizBgkKKgEY/RmRzdCncdznw1pOUK
 USYdYn2nzk+qYHPB3dGte+eI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f603e750efc98ad7;
	Wed, 23 Sep 2026 07:11:29 +0000
X-Mizu-Trace-ID: f603e750efc98ad7
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: [PATCH net-next v3] net: phy: make the hwtstamp provider lifetime symmetric with the PHY
Date: Wed, 23 Sep 2026 15:11:32 +0800
Message-Id: <20260923071132.908826-1-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

phy_detach() removes dev->hwprov when it points at the PHY being
detached, but phy_attach() does not install anything: the setup and
teardown are not symmetric. The teardown path is also reached from
the probe error path with no RTNL and an unregistered netdev, making
rtnl_dereference() of dev->hwprov trigger a lockdep splat.

Track the provider with the PHY instead: dev_attach_hwtstamp_phylib()
installs a default provider in phy_attach_direct(), and
dev_clear_hwtstamp_phylib() removes it in phy_detach(). Both sit
next to dev_set_hwtstamp_phylib() so the locking is obviously the
same, relaxed for unregistered netdevs via
netdev_ops_lock_dereference_or_invisible(). No driver callback is
invoked; installation is skipped when the PHY is not the default
hwtstamp provider or when ethtool already set one.

Fixes: 35f7cad1743e ("net: Add the possibility to support a selected hwtstamp in netdevice")
Reported-by: syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=694b49f41098a5df4fd7
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---

v3:
 The original patch only skipped the hwprov cleanup when the netdev
 was NETREG_UNINITIALIZED. The review asked to make the provider
 setup/teardown symmetric instead.
 
 Calling dev_set_hwtstamp_phylib() directly from phy_attach() does not
 work, for a few reasons:
 
  - It reads dev->hwprov under the netdev ops lock, and the phy_ts
    branch goes through phy_hwtstamp_set(), which ASSERT_RTNL().
    phy_attach() runs from the probe path with neither.
 
  - The !phy_ts branch (the common case for non-PTP PHYs) calls
    ops->ndo_hwtstamp_set() unconditionally, but drivers like
    usbnet/asix do not implement that callback.
 
  - Pushing a zero config into ndo_hwtstamp_set() would also wipe
    the MAC hwtstamp configuration on SFP hotplug.
 
 Instead, v3 controls the provider through metadata-only helpers that
 never call back into any driver. A freshly attached PHY is in its
 zero config state by definition, so no explicit zeroing is needed.
 
 The two new helpers match the locking in dev_set_hwtstamp_phylib(),
 with netdev_assert_locked_ops_compat_or_invisible() extended to a
 dereference helper so that unregistered netdevs are accepted.
 Both live in dev_ioctl.c next to dev_set_hwtstamp_phylib().
 ethnl_set_tsconfig() is left unchanged: it keeps its existing
 zero-then-switch sequence and only replaces the setting.
 
 Installation is skipped when:
  - ethtool already chose a provider (hwprov is set);
  - the PHY is not the default hwtstamp provider;
  - the PHY has no ts_info or phc_index < 0;
  - the allocation fails.
 All four degrade to the existing NULL fallback, so the patch changes
 no observable behavior.

v2:
 https://lore.kernel.org/all/20260918022316.237646-1-chenguang.zhao@linux.dev/ 

v1:
 https://lore.kernel.org/all/20260916021505.238990-1-chenguang.zhao@linux.dev/

 drivers/net/phy/phy_device.c | 19 +++++-------
 include/linux/net_tstamp.h   |  8 +++++
 include/net/netdev_lock.h    | 18 +++++++++++
 net/core/dev_ioctl.c         | 71 ++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..2ddb4b214003 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -17,6 +17,7 @@
 #include <linux/ethtool.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/net_tstamp.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -1878,6 +1879,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phy_resume(phydev);
 
+	/* Track the default hwtstamp provider of the netdev, if the
+	 * attached PHY is the one. Cleared symmetrically by phy_detach().
+	 */
+	if (dev)
+		dev_attach_hwtstamp_phylib(dev, phydev);
+
 	/**
 	 * If the external phy used by current mac interface is managed by
 	 * another mac interface, so we should create a device link between
@@ -1936,17 +1943,7 @@ void phy_detach(struct phy_device *phydev)
 
 	phy_suspend(phydev);
 	if (dev) {
-		struct hwtstamp_provider *hwprov;
-
-		/* hwprov may technically be protected by ops lock but
-		 * not for devices with a phydev, see phy_link_topo_add_phy()
-		 */
-		hwprov = rtnl_dereference(dev->hwprov);
-		/* Disable timestamp if it is the one selected */
-		if (hwprov && hwprov->phydev == phydev) {
-			rcu_assign_pointer(dev->hwprov, NULL);
-			kfree_rcu(hwprov, rcu_head);
-		}
+		dev_clear_hwtstamp_phylib(dev, phydev);
 
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index f4936d9c2b3c..d214253df2d3 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -41,6 +41,14 @@ struct hwtstamp_provider {
 	struct hwtstamp_provider_desc desc;
 };
 
+struct net_device;
+struct phy_device;
+
+void dev_attach_hwtstamp_phylib(struct net_device *dev,
+				struct phy_device *phydev);
+void dev_clear_hwtstamp_phylib(struct net_device *dev,
+			       struct phy_device *phydev);
+
 /**
  * struct kernel_hwtstamp_config - Kernel copy of struct hwtstamp_config
  *
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 9fb3e93857c3..b2f94902afff 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -149,6 +149,24 @@ static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 #define netdev_ops_lock_dereference(p, dev)				\
 	rcu_dereference_protected(p, netdev_is_locked_ops_compat(dev))
 
+/* Same as netdev_is_locked_ops_compat(), but a netdev which is not
+ * registered cannot be reached from user space, so its state cannot
+ * be accessed concurrently and no lock is needed.
+ */
+static inline int
+netdev_is_locked_ops_compat_or_invisible(const struct net_device *dev)
+{
+	if (dev->reg_state != NETREG_REGISTERED &&
+	    dev->reg_state != NETREG_UNREGISTERING)
+		return 1;
+
+	return netdev_is_locked_ops_compat(dev);
+}
+
+#define netdev_ops_lock_dereference_or_invisible(p, dev)		\
+	rcu_dereference_protected(p,					\
+		netdev_is_locked_ops_compat_or_invisible(dev))
+
 int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 		       void *ptr);
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index a320e264eaaf..fb586bcbda1f 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -5,6 +5,8 @@
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
 #include <linux/net_tstamp.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
 #include <linux/phylib_stubs.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/wireless.h>
@@ -388,6 +390,75 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 	return 0;
 }
 
+/**
+ * dev_attach_hwtstamp_phylib() - Install the default hwtstamp provider of a
+ *	netdev for a newly attached PHY, if the PHY qualifies.
+ * @dev: Network device
+ * @phydev: PHY device being attached
+ *
+ * Only sets metadata (source, phydev pointer, PHC descriptor); it never
+ * calls into any driver callback. A freshly attached PHY is by definition
+ * in its zero-config state so no zeroing is needed. Installation is skipped
+ * when the PHY is not the default hwtstamp provider, has no ts_info, or when
+ * a provider was already set (by ethtool). The locking convention is the
+ * same as for dev_set_hwtstamp_phylib(), but also accepts unregistered netdevs.
+ */
+void dev_attach_hwtstamp_phylib(struct net_device *dev,
+				struct phy_device *phydev)
+{
+	struct kernel_ethtool_ts_info ts_info = {};
+	struct hwtstamp_provider *hwprov;
+
+	/* Don't override an explicitly selected provider */
+	hwprov = netdev_ops_lock_dereference_or_invisible(dev->hwprov, dev);
+	if (hwprov)
+		return;
+
+	if (!phy_is_default_hwtstamp(phydev) || !phy_has_tsinfo(phydev))
+		return;
+
+	if (phy_ts_info(phydev, &ts_info) || ts_info.phc_index < 0)
+		/* No usable PTP hardware clock description */
+		return;
+
+	hwprov = kzalloc_obj(*hwprov);
+	if (!hwprov)
+		/* Degrade to the NULL fallback */
+		return;
+
+	hwprov->source = HWTSTAMP_SOURCE_PHYLIB;
+	hwprov->phydev = phydev;
+	hwprov->desc.index = ts_info.phc_index;
+	hwprov->desc.qualifier = ts_info.phc_qualifier;
+
+	rcu_assign_pointer(dev->hwprov, hwprov);
+}
+EXPORT_SYMBOL(dev_attach_hwtstamp_phylib);
+
+/**
+ * dev_clear_hwtstamp_phylib() - Remove the hwtstamp provider if it matches
+ *	a PHY that is being detached.
+ * @dev: Network device
+ * @phydev: PHY device being detached
+ *
+ * Clears dev->hwprov when it points at @phydev, whether the provider was
+ * installed by dev_attach_hwtstamp_phylib() or by dev_set_hwtstamp_phylib()
+ * (via ethtool). Called from phy_detach() for symmetry with attach.
+ */
+void dev_clear_hwtstamp_phylib(struct net_device *dev,
+			       struct phy_device *phydev)
+{
+	struct hwtstamp_provider *hwprov;
+
+	hwprov = netdev_ops_lock_dereference_or_invisible(dev->hwprov, dev);
+	/* Disable timestamping if the provider is the detached PHY */
+	if (hwprov && hwprov->phydev == phydev) {
+		rcu_assign_pointer(dev->hwprov, NULL);
+		kfree_rcu(hwprov, rcu_head);
+	}
+}
+EXPORT_SYMBOL(dev_clear_hwtstamp_phylib);
+
 static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-- 
2.25.1

