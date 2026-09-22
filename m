Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9C47F3C6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100510; cv=none; b=gAv2zqf/Yd20agdSanL55HBVas1LpxhFgxwNsL+4LVQmjh2PWqkd/pd/mH6jjVjSpIr2zUAyJjtIdfCkpfRz0VrwtjFejPqZI2ZGLtkFieBf52sckJhWzVtInRRw8+hOm0XyPUk87bcSszOr80gUH0+4wW81mOB4oM3a/AU3zm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100510; c=relaxed/simple;
	bh=NYECuONazlk8YCbgK0NwCbzoitEyEKd1ntrjQDiCHEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKIG0xWaIeZCEYQhm+kL8+XwamLsYE+w/tfvpAmc654kVJaWaHDwnIv7bR2ggjXEyUetzT4vwjf3MtsyZkOdC/jS6OouFxy2ly3+CVGmPvOjnXgruzwxla6R3q5V8MHHylaDDR4ajfFWdZirBBk+eP71qIvBBFgH6e08PYHBZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnSmPYzA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnSmPYzA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100508; x=1821636508;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NYECuONazlk8YCbgK0NwCbzoitEyEKd1ntrjQDiCHEM=;
  b=BnSmPYzAWuD6RnFB6F51jiHAMNYFV+Y7SEylZflnL84Ifgjc3BwZkBvB
   ItLKVDRGJ6lrCSfasEF/u6vt4BLM/zmeIzAM86p04F9BqLoW5txojGTqm
   2hdYhA3AEYAlB5vI8BqfgA5jvE3zevFBA/sY/vwHWLR4HENp+XsUPTl75
   f7pJyIagfsC+Ad42cCdLL7Phu/4XT54PVL7GPBp9X+OMnJrlBN4tkGcUL
   puIfCOlP86Gcok9r2ZnxPOShiH7NEn83B9c9yDa9hkbJtnXNu1t2bS7ZX
   roKQmbwq17XlLJkFrL0XqbRraJY+7tavKqarzQea4lpuAjH3H7RxHKnUM
   w==;
X-CSE-ConnectionGUID: sD08TkETR+eLsIWztIDASw==
X-CSE-MsgGUID: lIkMIHr0TUOtHYLaYe6TRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232026"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232026"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: +l5IOKy0TJqmHLROb2YMhQ==
X-CSE-MsgGUID: zJcVhBfPQf+iVcLPDabslA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315291"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:22 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:34 -0700
Subject: [PATCH iwl-net v2 01/15] ice: use reference counting and SRCU for
 PTP port access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-1-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=15273;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=NYECuONazlk8YCbgK0NwCbzoitEyEKd1ntrjQDiCHEM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNhyU9bQo1tj3bk3KpbdGq528PKN4OE9HpOZekXbhk8
 /5fjWvqO0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjI7H8M/0NF7h2XmxG92r7R
 KOnIpOc6vu86QsOiDeMrYnI9n83lY2f4Z3dkg8P89uVz8/tVZV95cmlYyNyfVmYh196ak/L7vcE
 UBgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice adapter structure maintains a list of ports associated with the
adapter. This is used for supporting PTP, where the clock owner must handle
many operations that require access to the PTP port structures of the
associated PFs.

This is implemented using a linked list and a mutex. This sort of works,
but a few places within the code do not acquire the mutex when iterating
the list. This includes ice_ptp_flush_all_tx_tracker(),
ice_ptp_restart_all_phy(), and ice_ptp_prepare_rebuild_sec().

Fixing this is tricky, especially since it is not clear if we can simply
acquire the lock around the complete iterations.

The pattern of use for the port list is read-mostly with modifications only
happening during PF initialization when elements are inserted. This
typically only happens during early boot, though a PF could in principle be
removed or loaded at arbitrary times via bind and unbind operations.

The use of a mutex does mean the driver can sleep while holding it, but it
still creates complicates with lock ordering and prevents iterating the
list in any code path that *can't* sleep.

Instead, use SRCU primitives for the port linked list, along with a
reference count on the port. The kref reference counter ensures that a PF
will have a valid lifetime and not be removed until the reference is
released. Note that this change focuses solely on the port list and does
not make an effort to resolve access to ctrl_pf, which is currently being
investigated by another developer.

Use of sleepable RCU is required because we often iterate the PTP port list
and perform operations that might sleep. Attempts at implementing regular
RCU have thus far not proven to be acceptable.

The remove path first removes the port from the list, and we use
kref_get_unless_zero to ensure that such ports are skipped when iterating
the list. This ensures that once a port starts removing we will drop
references and no longer be able to acquire new ones. This avoids loop
iterations chaining together to indefinitely block removal.

The ice_ptp_release_port_srcu() function is used as the release function for
the kref_put() call. This uses wake_up_var() to wake the removing thread.
The waiting thread will block until the final reference has been removed,
then it will use synchronize_srcu() to ensure any outstanding SRCU critical
sections have had the necessary grace period.

This flow ensures that accesses to ports via the adapter port list will
remain valid until both the SRCU critical sections have ended and all the
references to the ports have been dropped. Strictly speaking, SRCU alone
might be sufficient for existing code paths, but the reference count allows
the option for passing a pointer to the port on to other functions if
necessary in the future.

One major complication of this reference count is that ice_ptp_port is
embedded inside of other structures and not merely allocated. As a result,
we can't use the standard pattern of kfree_rcu() to just delay freeing
until references are dropped, and instead are delaying PF port teardown. If
any code path leaks the reference, the driver will be unable to teardown.
Instead, a 15 second timeout with a WARN() is used when waiting to finally
allow PF teardown to continue. This has the risk of potentially allowing
use-after-free, assuming some path really is stuck for 15 seconds. However,
this both less likely and a less bad outcome compared to blocking
indefinitely on a reference leak.

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  16 +--
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 145 +++++++++++++++++++++------
 4 files changed, 134 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d..93f041943bdd 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -17,15 +17,19 @@ struct ice_pf;
 /**
  * struct ice_port_list - data used to store the list of adapter ports
  *
- * This structure contains data used to maintain a list of adapter ports
+ * This structure contains data used to maintain a list of adapter ports.
+ * Writers *must* acquire the lock, and use SRCU safe operations. Readers may
+ * use SRCU or acquire the lock.
  *
- * @ports: list of ports
- * @lock: protect access to the ports list
+ * @list: list of ports
+ * @lock: protect write access to the list
+ * @srcu: Sleepable RCU domain for this adapter
  */
 struct ice_port_list {
-	struct list_head ports;
-	/* To synchronize the ports list operations */
-	struct mutex lock;
+	struct list_head list;
+	/* To synchronize write operations on the port list */
+	spinlock_t lock;
+	struct srcu_struct srcu;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index c4b0da7ce20e..da2003ba3bb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -5,6 +5,8 @@
 #define _ICE_PTP_H_
 
 #include <linux/ptp_clock_kernel.h>
+#include <linux/rculist.h>
+#include <linux/kref.h>
 #include <linux/kthread.h>
 
 #include "ice_ptp_hw.h"
@@ -138,6 +140,7 @@ struct ice_ptp_tx {
  * and determine when the port's PHY offset is valid.
  *
  * @list_node: list member structure
+ * @ref: reference counter for use with adapter ports list
  * @tx: Tx timestamp tracking for this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
  * @ps_lock: mutex used to protect the overall PTP PHY start procedure
@@ -149,6 +152,7 @@ struct ice_ptp_tx {
  */
 struct ice_ptp_port {
 	struct list_head list_node;
+	struct kref ref;
 	struct ice_ptp_tx tx;
 	struct kthread_delayed_work ov_work;
 	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 2dc3629d6d0f..84ac5ee5a739 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
 #include <linux/xarray.h>
 #include "ice_adapter.h"
 #include "ice.h"
@@ -66,18 +67,20 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 		mutex_init(&adapter->cpi_phy_lock[i]);
 	refcount_set(&adapter->refcount, 1);
 
-	mutex_init(&adapter->ports.lock);
-	INIT_LIST_HEAD(&adapter->ports.ports);
+	spin_lock_init(&adapter->ports.lock);
+	INIT_LIST_HEAD(&adapter->ports.list);
+	init_srcu_struct(&adapter->ports.srcu);
 
 	return adapter;
 }
 
 static void ice_adapter_free(struct ice_adapter *adapter)
 {
-	WARN_ON(!list_empty(&adapter->ports.ports));
+	WARN_ON(!list_empty(&adapter->ports.list));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
-	mutex_destroy(&adapter->ports.lock);
+
+	cleanup_srcu_struct(&adapter->ports.srcu);
 
 	kfree(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index eaec36ab6ae3..9881a7a9e570 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/rculist.h>
+#include <linux/srcu.h>
+#include <linux/wait_bit.h>
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
@@ -673,20 +676,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
+static void ice_ptp_release_port_srcu(struct kref *ref)
+{
+	wake_up_var(ref);
+}
+
 static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 {
+	struct ice_port_list *ports = &pf->adapter->ports;
 	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	mutex_lock(&pf->adapter->ports.lock);
-	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
 		struct ice_ptp_tx *tx = &port->tx;
 
-		if (!tx || !tx->init)
+		if (!tx->init)
+			continue;
+
+		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
 		ice_ptp_process_tx_tstamp(tx);
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
-	mutex_unlock(&pf->adapter->ports.lock);
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -806,10 +822,19 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
 static void
 ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
 {
+	struct ice_port_list *ports = &pf->adapter->ports;
 	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
+	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -1424,16 +1449,22 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
  */
 static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
-	struct list_head *entry;
+	struct ice_port_list *ports = &pf->adapter->ports;
+	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	list_for_each(entry, &pf->adapter->ports.ports) {
-		struct ice_ptp_port *port = list_entry(entry,
-						       struct ice_ptp_port,
-						       list_node);
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
 
 		if (port->link_up)
 			ice_ptp_port_phy_restart(port);
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -2694,19 +2725,30 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
 
 static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 {
+	struct ice_port_list *ports = &pf->adapter->ports;
+	bool have_tstamps = false;
 	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	scoped_guard(mutex, &pf->adapter->ports.lock) {
-		list_for_each_entry(port, &pf->adapter->ports.ports,
-				    list_node) {
-			struct ice_ptp_tx *tx = &port->tx;
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
+
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+
+		if (ice_port_has_timestamps(&port->tx))
+			have_tstamps = true;
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
+
+		if (have_tstamps)
+			break;
 
-			if (ice_port_has_timestamps(tx))
-				return true;
-		}
 	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 
-	return false;
+	return have_tstamps;
 }
 
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
@@ -2890,14 +2932,18 @@ void ice_ptp_queue_work(struct ice_pf *pf)
 static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 					enum ice_reset_req reset_type)
 {
-	struct list_head *entry;
+	struct ice_port_list *ports = &pf->adapter->ports;
+	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	list_for_each(entry, &pf->adapter->ports.ports) {
-		struct ice_ptp_port *port = list_entry(entry,
-						       struct ice_ptp_port,
-						       list_node);
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
 		struct ice_pf *peer_pf = ptp_port_to_pf(port);
 
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+
 		if (!ice_is_primary(&peer_pf->hw)) {
 			if (rebuild) {
 				/* TODO: When implementing rebuild=true:
@@ -2909,7 +2955,10 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 				ice_ptp_prepare_for_reset(peer_pf, reset_type);
 			}
 		}
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -3086,11 +3135,11 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&ptp->port.list_node);
-	mutex_lock(&pf->adapter->ports.lock);
+	kref_init(&ptp->port.ref);
 
-	list_add(&ptp->port.list_node,
-		 &pf->adapter->ports.ports);
-	mutex_unlock(&pf->adapter->ports.lock);
+	spin_lock(&pf->adapter->ports.lock);
+	list_add_rcu(&ptp->port.list_node, &pf->adapter->ports.list);
+	spin_unlock(&pf->adapter->ports.lock);
 
 	/* Seed the per-PHY Tx reference clock usage map for this port.
 	 * Only meaningful on E825 (other MAC types don't expose tx-clk
@@ -3112,13 +3161,45 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 
 static void ice_ptp_cleanup_pf(struct ice_pf *pf)
 {
+	struct ice_port_list *ports = &pf->adapter->ports;
 	struct ice_ptp *ptp = &pf->ptp;
+	struct kref *ref;
 
-	if (pf->hw.mac_type != ICE_MAC_UNKNOWN) {
-		mutex_lock(&pf->adapter->ports.lock);
-		list_del(&ptp->port.list_node);
-		mutex_unlock(&pf->adapter->ports.lock);
-	}
+	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
+		return;
+
+	/* The PF should not be removed until there are no more outstanding
+	 * references on the PTP port. First, remove the port from the list to
+	 * prevent new references from being acquired. Then, drop the primary
+	 * reference this PF holds on the port. Wait until the references are
+	 * dropped and then finally synchronize_srcu() to ensure the SRCU
+	 * critical sections have finished.
+	 *
+	 * Since this blocks PF removal (and doesn't merely result in a memory
+	 * leak), have a maximum timeout of 15 seconds before continuing
+	 * removal. Since the port is already removed from the list, new
+	 * references will not be acquired. The only way to trigger
+	 * use-after-free should be for a single thread already holding
+	 * a reference becoming blocked for 15 seconds.
+	 *
+	 * This intentionally trades off allowing a possible but unlikely
+	 * use-after-free for avoiding permanently blocking the ability to
+	 * remove the driver due a programming bug resulting in a true
+	 * reference leak.
+	 */
+
+	spin_lock(&ports->lock);
+	list_del_rcu(&ptp->port.list_node);
+	spin_unlock(&ports->lock);
+
+	ref = &ptp->port.ref;
+	kref_put(ref, ice_ptp_release_port_srcu);
+
+	dev_WARN_ONCE(ice_pf_to_dev(pf),
+		      !wait_var_event_timeout(ref, !kref_read(ref), 15 * HZ),
+		      "Timed out waiting for port references to release. Continuing to unload anyways.");
+
+	synchronize_srcu(&ports->srcu);
 }
 
 /**

-- 
2.56.0.rc0.395.gd1f3524e15dc

