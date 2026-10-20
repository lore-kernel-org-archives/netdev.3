Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489577;
	b=ZtxQoRBEba2/bMLK6cCLAENvvfKJAM8Uy33weShR6TBuPUiZqVl3qZoqibRmfkBfL3+B
	 Q7/H7VIH0y6dqJWd30KLKaqg1WJIXC1gArXVwlTqSaknQk2qolW2dgP3W7bFOcj4yUqEx
	 GtkOCyy704x71M5GA8FYwbc2AKK0/fOMqUC3Y9OuAqGDoKZjezfs0ZHNB/V9Lu4TGwYjy
	 SJ1Y/X7xPYelx6b6C3j5EcfDWs7gbdol0aTDuKRAjI9XD+MqD34taGURIudlatXVsoQTF
	 wWVNwz2D+8Ux2Di++6FVtYqoYC0qTb8sIz1gweXW7dxAoVe0TqqE64yl9GbNz1gCKdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489577;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=QlUNAB1Ij2oARhDzTtBQQSk3FmyAQuurIJ7AnucJnMg=;
	b=EbCd110in8qfSyprunCQo9krFD+gv+mpiRnu3WLj7Ei7mPejv5h13ayNq2YArnlGMPv6
	 C4AREhuiLApcjsXh39DXKGkVFmgrEud1/2X2ePvLoRtUPv90qc6M6YXZ0LcqeLDOVh+rE
	 t7r55PrMBXjphIXVkievQnjl4xREvBHj5/pvbfC+UZOqcVbvpYxVkz3mY9HCUwJVPPJF+
	 o3pbl2N6j4DPh+mnJfBOKdkW+L6OxRtW/IPywaHtQw4D8Qx3O8P0z5Yz9u1qR5CwA8pZe
	 Q2h4Lshsc8z7/F8dbMkhPfN+NzdCApz+rTw8OHV6Rp913yD5QH0PXzduwjjjNY8CE7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TMBuP65b;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE52606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TMBuP65b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489576; x=1824025576;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SKqFliR7roJcQKlNSunlIe8qTzQ9pSRnoGuGaJYgDoU=;
  b=TMBuP65bU1FE6IBFlHZNJY0HXO1xi+NZ2Va3B2sCTpHOSxkYNkM6fcy8
   K9m2rjLbx4tGQ4G0kw+0VcjasJ2gmeyXel1mCgGdGhaPcNR82SwDEUMDo
   z6kP8yn511JHeYsVsFnm9tcIPQr4EvJTtd6Zt+XG7+2H0jGo0l51py1Pl
   PHy7+UnOj2/oWoLD21qoLi3QOvBuHMU1FeNV/lxYQLstnfs6t73VGlAcC
   kaA54V5yz88gMJ1vRc15ImBx6iWHLzLXMbSwX1+qD9c8Pnt9jx4LiJfhw
   AItD2JIu0plpL6xyGcFdRnSwPCwa26AV78Z+CXJ+DhAfJ8P976kkRpc66
   Q==;
X-CSE-ConnectionGUID: rr5ea1fiTPS3RjrdrCsSCQ==
X-CSE-MsgGUID: VjdcuJETQ1GtqsxZKd3JOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287877"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287877"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: JBh0+Y3nTgi4897kwQ4Brw==
X-CSE-MsgGUID: EnheH83ASLy15fVbrMiUQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723891"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:33 -0700
Subject: [PATCH iwl-net v4 02/13] ice: use reference counting and SRCU for
 PTP port access
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-2-3e30fc9adc73@intel.com>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=14194;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=SKqFliR7roJcQKlNSunlIe8qTzQ9pSRnoGuGaJYgDoU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvHJ8/Wa9ZuTDUTNpaVmb3wXonCyVfHBni3RTNvZ1
 r6d7HCxo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIn8nsLIcH9pnsmONr+Ku9ov
 stgdP14XE93cuqFpW+q+xqL8Pxsf5zIyLHxocWCNpOTmv1N97qlezWKaZe0elFBnk5+/6MnKQ0V
 X2QA=
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

The ice_ptp_release_port_srcu() function is used as the release function
for the kref_put() call. This uses wake_up_var() to wake the removing
thread. The waiting thread will block until the final reference has been
removed, then it will use synchronize_srcu() to ensure any outstanding SRCU
critical sections have had the necessary grace period.

This flow ensures that accesses to ports via the adapter port list will
remain valid until both the SRCU critical sections have ended and all the
references to the ports have been dropped. Strictly speaking, SRCU alone
might be sufficient for existing code paths, but the reference count allows
the option for passing a pointer to the port on to other functions if
necessary in the future.

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  17 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |  17 +++-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 125 ++++++++++++++++++++-------
 4 files changed, 121 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d..c61bd645e460 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/srcu.h>
 #include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
@@ -17,15 +18,19 @@ struct ice_pf;
 /**
  * struct ice_port_list - data used to store the list of adapter ports
  *
- * This structure contains data used to maintain a list of adapter ports
+ * This structure contains data used to maintain a list of adapter ports.
+ * Writers modifying the list *must* acquire the lock, and use SRCU safe list
+ * operations. Readers should use srcu_read_lock() on the provided domain.
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
index 2dc3629d6d0f..536923b6ae97 100644
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
@@ -54,11 +55,18 @@ static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
 static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
+	int err;
 
 	adapter = kzalloc_obj(*adapter);
 	if (!adapter)
 		return NULL;
 
+	err = init_srcu_struct(&adapter->ports.srcu);
+	if (err) {
+		kfree(adapter);
+		return NULL;
+	}
+
 	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
@@ -66,18 +74,19 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 		mutex_init(&adapter->cpi_phy_lock[i]);
 	refcount_set(&adapter->refcount, 1);
 
-	mutex_init(&adapter->ports.lock);
-	INIT_LIST_HEAD(&adapter->ports.ports);
+	spin_lock_init(&adapter->ports.lock);
+	INIT_LIST_HEAD(&adapter->ports.list);
 
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
index e1c66cd0f94f..55241802d17a 100644
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
@@ -673,20 +676,37 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
+static void ice_ptp_release_port_srcu(struct kref *ref)
+{
+	/* wake_up_var() requires full ordering but kref_put only provides
+	 * release ordering.
+	 */
+	smp_mb__after_atomic();
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
@@ -806,10 +826,19 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
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
@@ -1424,16 +1453,22 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
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
@@ -2694,19 +2729,28 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
 
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
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
 
-			if (ice_port_has_timestamps(tx))
-				return true;
-		}
+		if (ice_port_has_timestamps(&port->tx))
+			have_tstamps = true;
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
+
+		if (have_tstamps)
+			break;
 	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 
-	return false;
+	return have_tstamps;
 }
 
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
@@ -2890,14 +2934,18 @@ void ice_ptp_queue_work(struct ice_pf *pf)
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
@@ -2909,7 +2957,10 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 				ice_ptp_prepare_for_reset(peer_pf, reset_type);
 			}
 		}
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -3084,11 +3135,11 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
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
@@ -3110,13 +3161,23 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 
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
+	spin_lock(&ports->lock);
+	list_del_rcu(&ptp->port.list_node);
+	spin_unlock(&ports->lock);
+
+	ref = &ptp->port.ref;
+	kref_put(ref, ice_ptp_release_port_srcu);
+
+	wait_var_event(ref, !kref_read(ref));
+
+	synchronize_srcu(&ports->srcu);
 }
 
 /**

-- 
2.56.0.212.g129ede20d986

