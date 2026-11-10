Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320155;
	b=rnCLVwhYdvgk8+0Bln4ZnZR83oVuv1TC2sxr+reqfjJwId4qOuV3L68Zm4/mG0BZ5j99
	 hvDFuyfXHTgOabnUYFOcIuEwtYSEIj0axtXJjRVPGK8RWkxwXEfcZgH7bFHL45nQpsZ+M
	 UDW0wuFgrejOo9eNjMErpRPc9yNoZ6ltHyd6oLCceqboK+f+NdXBdBGXEn+Bsw35L+HgE
	 joaoMmHdV9mRjBpt1IxOgBXccCtESpzRaIk24lFZDZA22Oltf4R3BK47wuFgrGQiC88pU
	 2AWO++tguaURumTqPk50jUknDuN4WShhgb2QURBeEULMaZ8OwqaTtlQQIuCBU+oxFJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320155;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2qvfb4Fo/unjOz1qVfjHUVOHmcfjGeXPIG0JJ2vSnUY=;
	b=GATWcxir+GNau8kXj6V+BhY/Be9EbC9rNGY9HWnRJP+9HcDGTQlyW4qnI1fGQRhroqX6
	 /ki0t71GahIEe81VvJd5TfHVEtawfw2/GyaQh57bTcaayjZlIi1bxUqKUbiU08+rVm3FT
	 8ag//6OSSnn5Ypxyu0ygbPHFlqfxX/SMK2aDaofqQci+N48plgJ+OdGwm3A+KdTk0hbWY
	 LEbrZePytGm2LryPeQw/AYQOjCUpoapWK50IX1GXEpIlVNRFEIXDU+u9OG6shTd6ipmxo
	 s6ZzkN5sJZIdBqiWP0IR/PdCQvfV6dsD9k+k0nZDACcSKER7F+Dl6Oo280EDYpW1vyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="B/GN5+MO";
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E6606A335
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D33E6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B/GN5+MO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320154; x=1825856154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lds+yRG9Z+FpmVGF7PuTL3fcaHBTG9+2ihzfq88fO7k=;
  b=B/GN5+MOZHlFWYI2USJ44vAlJR+YKmuhCgzSLFdwQobLGsdzA/2xHcYx
   KiZyiplQznoqs99cy9sx2yQc/HceCY3BYzSzHk6SdsZHLAtFysonZONHr
   DskpDuVxmovmgeeKy6yY+BVbsGtZXUoGkBlxvUL3a2kw+re3dTGVXqnms
   z38Q8YRE+Fx4c7fYl/5Iva70uUO5Qzgu4eHEprmvpCP+XI2c8R3jXUsp3
   suJ9Lai9Oy0WRxg7x0qpQK/picAUL+ZW8P7kOPLogogrdB5CLLIqNaCdp
   fpWdot/inwF25GRmwTMvsH8yTkA77XO187disFmGoBBaQH2zJztm0FLp2
   g==;
X-CSE-ConnectionGUID: wr8DCAnDRqW+GZfR3JSXMQ==
X-CSE-MsgGUID: T9TXu41bRvOHHJQWQFGXUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091069"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091069"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:15:53 -0800
X-CSE-ConnectionGUID: yuAU6uQ3RuSOh2crj4zfBw==
X-CSE-MsgGUID: KiPcRZcORGaR9ART+dWn4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327582"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:15:47 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AFDF72FC5A;
	Tue, 10 Nov 2026 14:15:43 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	ohartoov@nvidia.com,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net-next v5 02/15] ice: use shared devlink to store ice_adapters instead of custom xarray
Date: Tue, 10 Nov 2026 15:07:11 +0100
Message-ID: <20261110141534.95614-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor our storage and deduplication logic of ice_adapters by moving
it to be handled by shared devlink instance, recently added by
Jiri Pirko [1].

We wanted the devlink instance for whole device anyway - later in the
series I will add devlink resources under it.

Make the shared devlink a parent (wrt. nesting) of the actual PF devices.

[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
CC: Grzegorz Nitka <grzegorz.nitka@intel.com>

v2:
 * propagate the error from devlink_shd_get() with ERR_CAST()
 * minor kdoc updates
 * check devl_nested_devlink_set() return value, ice_devlink_register()
   returns int now (Sashiko)
 * prefix the shared devlink id with "ice:", to avoid collisions with
   ids used by other drivers (Sashiko)

Sashiko suggestions I don't want to apply:
 S: all PFs without DSN get index 0, and so share one instance
 me: pre-existing, and DSN 0 is only on pre-production samples
---
 .../net/ethernet/intel/ice/devlink/devlink.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  12 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  11 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 106 ++++++------------
 drivers/net/ethernet/intel/ice/ice_main.c     |  11 +-
 5 files changed, 57 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
index 1af3b0763fbb..62af38d11fd9 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
@@ -7,7 +7,7 @@
 struct ice_pf *ice_allocate_pf(struct device *dev);
 struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf);
 
-void ice_devlink_register(struct ice_pf *pf);
+int ice_devlink_register(struct ice_pf *pf);
 void ice_devlink_unregister(struct ice_pf *pf);
 int ice_devlink_register_params(struct ice_pf *pf);
 void ice_devlink_unregister_params(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index c61bd645e460..cdad45e8e81b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -8,7 +8,8 @@
 #include <linux/mutex.h>
 #include <linux/srcu.h>
 #include <linux/spinlock_types.h>
-#include <linux/refcount_types.h>
+
+#include <net/devlink.h>
 
 #include "ice_type.h"
 
@@ -35,31 +36,30 @@ struct ice_port_list {
 
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
- * @refcount: Reference count. struct ice_pf objects hold the references.
+ * @devlink: ice adapter's devlink (whole dev devlink)
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
- * @index: 64-bit index cached for collision detection on 32bit systems
  */
 struct ice_adapter {
-	refcount_t refcount;
+	struct devlink *devlink;
+
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
 	/* For access to GLCOMM_QTX_CNTX_CTL register */
 	spinlock_t txq_ctx_lock;
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
-	u64 index;
 };
 
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
-void ice_adapter_put(struct pci_dev *pdev);
+void ice_adapter_put(struct ice_adapter *adapter);
 
 #endif /* _ICE_ADAPTER_H */
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 8c2b63eef82b..fa64b9744779 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1747,11 +1747,20 @@ struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf)
  *
  * Return: zero on success or an error code on failure.
  */
-void ice_devlink_register(struct ice_pf *pf)
+int ice_devlink_register(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
+	struct ice_adapter *adapter = pf->adapter;
+	int err;
 
+	if (adapter) {
+		err = devl_nested_devlink_set(adapter->devlink, devlink);
+		if (err)
+			return err;
+	}
 	devl_register(devlink);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 536923b6ae97..0cdb13e7bd89 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -1,19 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // SPDX-FileCopyrightText: Copyright Red Hat
 
-#include <linux/cleanup.h>
-#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
-#include <linux/xarray.h>
+
 #include "ice_adapter.h"
 #include "ice.h"
 
-static DEFINE_XARRAY(ice_adapters);
-static DEFINE_MUTEX(ice_adapters_mutex);
-
 #define ICE_ADAPTER_FIXED_INDEX	BIT_ULL(63)
 
 #define ICE_ADAPTER_INDEX_E825C	\
@@ -41,56 +36,41 @@ static u64 ice_adapter_index(struct pci_dev *pdev)
 	}
 }
 
-static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
+static int ice_adapter_init(void *priv, void *init_param)
 {
-	u64 index = ice_adapter_index(pdev);
-
-#if BITS_PER_LONG == 64
-	return index;
-#else
-	return (u32)index ^ (u32)(index >> 32);
-#endif
-}
+	struct ice_adapter *adapter = priv;
+	struct devlink *devlink;
 
-static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
-{
-	struct ice_adapter *adapter;
-	int err;
+	devlink = shd_priv_to_devlink(adapter);
+	adapter->devlink = devlink;
 
-	adapter = kzalloc_obj(*adapter);
-	if (!adapter)
-		return NULL;
-
-	err = init_srcu_struct(&adapter->ports.srcu);
-	if (err) {
-		kfree(adapter);
-		return NULL;
-	}
-
-	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
-	refcount_set(&adapter->refcount, 1);
 
 	spin_lock_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.list);
 
-	return adapter;
+	return init_srcu_struct(&adapter->ports.srcu);
 }
 
-static void ice_adapter_free(struct ice_adapter *adapter)
+static void ice_adapter_fini(void *priv)
 {
+	struct ice_adapter *adapter = priv;
+
 	WARN_ON(!list_empty(&adapter->ports.list));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 
 	cleanup_srcu_struct(&adapter->ports.srcu);
-
-	kfree(adapter);
 }
 
+static const struct devlink_ops ice_adapter_devlink_ops = {
+	.shd_init = ice_adapter_init,
+	.shd_fini = ice_adapter_fini,
+};
+
 /**
  * ice_adapter_get - Get a shared ice_adapter structure.
  * @pdev: Pointer to the pci_dev whose driver is getting the ice_adapter.
@@ -102,59 +82,37 @@ static void ice_adapter_free(struct ice_adapter *adapter)
  *
  * Context: Process, may sleep.
  * Return:  Pointer to ice_adapter on success.
- *          ERR_PTR() on error. -ENOMEM is the only possible error.
+ *          ERR_PTR() on error.
  */
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
-	unsigned long index;
-	int err;
-
-	index = ice_adapter_xa_index(pdev);
-	scoped_guard(mutex, &ice_adapters_mutex) {
-		adapter = xa_load(&ice_adapters, index);
-		if (adapter) {
-			refcount_inc(&adapter->refcount);
-			WARN_ON_ONCE(adapter->index != ice_adapter_index(pdev));
-			return adapter;
-		}
-		err = xa_reserve(&ice_adapters, index, GFP_KERNEL);
-		if (err)
-			return ERR_PTR(err);
-
-		adapter = ice_adapter_new(pdev);
-		if (!adapter) {
-			xa_release(&ice_adapters, index);
-			return ERR_PTR(-ENOMEM);
-		}
-		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
-	}
+	struct devlink *devlink;
+	char devlink_id[32];
+	u64 index;
+
+	index = ice_adapter_index(pdev);
+	snprintf(devlink_id, sizeof(devlink_id), "ice:%llx", index);
+	devlink = devlink_shd_get(devlink_id, &ice_adapter_devlink_ops,
+				  sizeof(*adapter), NULL, pdev->dev.driver);
+	if (IS_ERR(devlink))
+		return ERR_CAST(devlink);
+
+	adapter = devlink_shd_get_priv(devlink);
+
 	return adapter;
 }
 
 /**
  * ice_adapter_put - Release a reference to the shared ice_adapter structure.
- * @pdev: Pointer to the pci_dev whose driver is releasing the ice_adapter.
+ * @adapter: the ice_adapter to release reference to
  *
  * Releases the reference to ice_adapter previously obtained with
  * ice_adapter_get.
  *
  * Context: Process, may sleep.
  */
-void ice_adapter_put(struct pci_dev *pdev)
+void ice_adapter_put(struct ice_adapter *adapter)
 {
-	struct ice_adapter *adapter;
-	unsigned long index;
-
-	index = ice_adapter_xa_index(pdev);
-	scoped_guard(mutex, &ice_adapters_mutex) {
-		adapter = xa_load(&ice_adapters, index);
-		if (WARN_ON(!adapter))
-			return;
-		if (!refcount_dec_and_test(&adapter->refcount))
-			return;
-
-		WARN_ON(xa_erase(&ice_adapters, index) != adapter);
-	}
-	ice_adapter_free(adapter);
+	devlink_shd_put(adapter->devlink);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 454fba07d4ec..6373cd5ac288 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4946,7 +4946,12 @@ static int ice_init_devlink(struct ice_pf *pf)
 		return err;
 
 	ice_devlink_init_regions(pf);
-	ice_devlink_register(pf);
+	err = ice_devlink_register(pf);
+	if (err) {
+		ice_devlink_destroy_regions(pf);
+		ice_devlink_unregister_params(pf);
+		return err;
+	}
 	ice_health_init(pf);
 
 	return 0;
@@ -5291,7 +5296,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 unroll_dev_init:
 	need_dev_deinit = true;
 unroll_adapter:
-	ice_adapter_put(pdev);
+	ice_adapter_put(adapter);
 unroll_hw_init:
 	ice_deinit_hw(hw);
 	if (need_dev_deinit)
@@ -5404,7 +5409,7 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
-	ice_adapter_put(pdev);
+	ice_adapter_put(pf->adapter);
 	ice_deinit_hw(&pf->hw);
 
 	ice_deinit_dev(pf);
-- 
2.51.1

