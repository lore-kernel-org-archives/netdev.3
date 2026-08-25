Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124A3546FF
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698509; cv=none; b=V+6Z8VmKdDjMZSZogMoscM0D3npKYrzowQBMjFFCeaeewLFgqLI0Z5O8K0rKWKtlhSo5frLlwDR2iVVgvXsz3ZdElzDNokYFphZwbfiw+sXAXGBsGINKqycLa5xBosv8YLGYkIYs6OrbZz0IlNktj8e9M8yX62JNA1wMD719t0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698509; c=relaxed/simple;
	bh=DdvrBoJ4NTFO/2AeiiFJhSA9KDx/CvzfI6937fUFPKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9Ta5H31R7DM0zl+0M6hDhkYPqvCUAGZq8BX2oeiAifh9eRQip6ANRzsl3/jBGEFmaLxCy8hrHQsSjsZwBERFi8nj8MU8/+zY/LF8ThiYYOGxpdjvDLD9pxM/shQNuZt+X/8KN/vMrOl6saAgFOsaGKiD0IFhTYCgYUOGfcCbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zcy5PPnT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zcy5PPnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698507; x=1819234507;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DdvrBoJ4NTFO/2AeiiFJhSA9KDx/CvzfI6937fUFPKc=;
  b=Zcy5PPnTGn0ABDZWZwygpSh/czEfcp2Pmc3BSRva26bwASM/aq8mB6ZW
   Sii3U/88cZFkrKkvUDavd8jyQNTcX3wAtW0GROGn8lglUMEsDi2nRd6ds
   JFxAHPpjNL9KEmVvSyWchncrUy5EVqqtxNCYkSg8Ed9jtXoDmzSfwRIBp
   7yDawD2w6qIuyz82gg4i2lFKWCxUY6HYgGsWHZVNiI0tafXRT7EXtAU7t
   raU8bX9sscl4pBkzD/W32++wBze4huS4C8Hz/IJRG1LFH4H0xp3bIUiPF
   JXjgT8lz8ZCl/CNYO5PALJeHF4cXNgUT03IAZvzn20DXbETqWXIGouUff
   Q==;
X-CSE-ConnectionGUID: NcdzGe9wSd60Kkw4S/GefA==
X-CSE-MsgGUID: BhWeR3MDQrOSndqzyoBWYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120413"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120413"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:05 -0700
X-CSE-ConnectionGUID: OvMQqAt0TjuPiqVWssttQg==
X-CSE-MsgGUID: i7u//RuDTkCDLiSdQ7ksIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789655"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:25 -0700
Subject: [PATCH iwl-net v2 01/14] ice: use reference counting and RCU for
 PTP port access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-1-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=14234;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=DdvrBoJ4NTFO/2AeiiFJhSA9KDx/CvzfI6937fUFPKc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WauZSmuT/nYv7EpRnVuQ/MAkPsjnwGqBrF6B2oZrx
 ex2bekdpSwMYlwMsmKKLAoOISuvG08I03rjLAczh5UJZAgDF6cATMR2IyPDM2XOFSmzzzLeft/0
 ovfhG13p3bMD7GcIW22WXPVJlfnwXob/yTwy36RWcBal5V2w+COXEhYeImM/r3Qq05MEEamCo/I
 8AA==
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

Instead, use the RCU primitives for the port linked list, along with a
reference count on the port. The kref reference counter ensures that we can
safely acquire pointers with a guarantee of their lifetime, ensuring the
associated PF will not be removed until the reference is released.

For port iterations which are short and definitely can't sleep, wrap the
entire loop with rcu_read_lock() and rcu_read_unlock().

For longer operations, or those which might sleep, we need to close the
critical section between each loop iteration. To make this safe, start
the loop iteration with rcu_read_lock(), then acquire a reference for the
port with kref_get_unless_zero. If this returns 0, the port is already in
the process of being removed, so that port should be skipped when
iterating. Once a reference to the port is acquired, exit the RCU critical
section. Then, perform the desired operations on the port, followed by
re-entering the RCU critical section and releasing the reference with
kref_put.

The ice_ptp_release_port_rcu() function is used as the release function for
the kref_put() call. To avoid a potential infinite loop of new references,
the release function simply uses a wake_up_var() call to wake the closing
thread. The ice_ptp_cleanup_pf() function will remove the port from the linked
list using list_del_rcu, then release its primary reference, then wait for all
references to drop via wait queue. Finally synchronize_rcu() is called to
guarantee the port remains valid for at least one RCU grace period. Then PF
removal will continue.

This flow ensures that all accesses to ports via the port list will remain
valid until either the RCU critical sections end, or the references have
been dropped.

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
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |   7 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 132 +++++++++++++++++++--------
 4 files changed, 106 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d..39923dedd534 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -19,13 +19,13 @@ struct ice_pf;
  *
  * This structure contains data used to maintain a list of adapter ports
  *
- * @ports: list of ports
+ * @list: list of ports
  * @lock: protect access to the ports list
  */
 struct ice_port_list {
-	struct list_head ports;
+	struct list_head list;
 	/* To synchronize the ports list operations */
-	struct mutex lock;
+	spinlock_t lock;
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
index 2dc3629d6d0f..d1643bf8a1b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -66,18 +66,17 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
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
 
 	kfree(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index eaec36ab6ae3..b12181b8c843 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/rculist.h>
+#include <linux/wait_bit.h>
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
@@ -673,20 +675,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
+static void ice_ptp_release_port_rcu(struct kref *ref)
+{
+	wake_up_var(ref);
+}
+
 static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 {
 	struct ice_ptp_port *port;
 
-	mutex_lock(&pf->adapter->ports.lock);
-	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
 		struct ice_ptp_tx *tx = &port->tx;
 
-		if (!tx || !tx->init)
+		if (!tx->init)
 			continue;
 
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+
+		rcu_read_unlock();
+
 		ice_ptp_process_tx_tstamp(tx);
+
+		rcu_read_lock();
+		kref_put(&port->ref, ice_ptp_release_port_rcu);
 	}
-	mutex_unlock(&pf->adapter->ports.lock);
+	rcu_read_unlock();
 }
 
 /**
@@ -808,8 +823,16 @@ ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
 {
 	struct ice_ptp_port *port;
 
-	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+		rcu_read_unlock();
 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
+		rcu_read_lock();
+		kref_put(&port->ref, ice_ptp_release_port_rcu);
+	}
+	rcu_read_unlock();
 }
 
 /**
@@ -1285,12 +1308,15 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	ptp_port = &pf->ptp.port;
 
+	if (!kref_get_unless_zero(&ptp_port->ref))
+		return;
+
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
 
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
-		return;
+		goto exit_kref_put;
 
 	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
 	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
@@ -1333,17 +1359,20 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
 		/* Do not reconfigure E810 or E830 PHY */
-		return;
+		goto exit_kref_put;
 	case ICE_MAC_GENERIC:
 		ice_ptp_port_phy_restart(ptp_port);
-		return;
+		goto exit_kref_put;
 	case ICE_MAC_GENERIC_3K_E825:
 		if (linkup)
 			ice_ptp_port_phy_restart(ptp_port);
-		return;
+		goto exit_kref_put;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
 	}
+
+exit_kref_put:
+	kref_put(&ptp_port->ref, ice_ptp_release_port_rcu);
 }
 
 /**
@@ -1424,16 +1453,21 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
  */
 static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
-	struct list_head *entry;
+	struct ice_ptp_port *port;
 
-	list_for_each(entry, &pf->adapter->ports.ports) {
-		struct ice_ptp_port *port = list_entry(entry,
-						       struct ice_ptp_port,
-						       list_node);
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+		rcu_read_unlock();
 
 		if (port->link_up)
 			ice_ptp_port_phy_restart(port);
+
+		rcu_read_lock();
+		kref_put(&port->ref, ice_ptp_release_port_rcu);
 	}
+	rcu_read_unlock();
 }
 
 /**
@@ -2694,19 +2728,19 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
 
 static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 {
+	bool have_tstamps = false;
 	struct ice_ptp_port *port;
 
-	scoped_guard(mutex, &pf->adapter->ports.lock) {
-		list_for_each_entry(port, &pf->adapter->ports.ports,
-				    list_node) {
-			struct ice_ptp_tx *tx = &port->tx;
-
-			if (ice_port_has_timestamps(tx))
-				return true;
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
+		if (ice_port_has_timestamps(&port->tx)) {
+			have_tstamps = true;
+			break;
 		}
 	}
+	rcu_read_unlock();
 
-	return false;
+	return have_tstamps;
 }
 
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
@@ -2890,14 +2924,16 @@ void ice_ptp_queue_work(struct ice_pf *pf)
 static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 					enum ice_reset_req reset_type)
 {
-	struct list_head *entry;
+	struct ice_ptp_port *port;
 
-	list_for_each(entry, &pf->adapter->ports.ports) {
-		struct ice_ptp_port *port = list_entry(entry,
-						       struct ice_ptp_port,
-						       list_node);
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
 		struct ice_pf *peer_pf = ptp_port_to_pf(port);
 
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+		rcu_read_unlock();
+
 		if (!ice_is_primary(&peer_pf->hw)) {
 			if (rebuild) {
 				/* TODO: When implementing rebuild=true:
@@ -2909,7 +2945,11 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 				ice_ptp_prepare_for_reset(peer_pf, reset_type);
 			}
 		}
+
+		rcu_read_lock();
+		kref_put(&port->ref, ice_ptp_release_port_rcu);
 	}
+	rcu_read_unlock();
 }
 
 /**
@@ -3086,11 +3126,11 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
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
@@ -3113,12 +3153,32 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 static void ice_ptp_cleanup_pf(struct ice_pf *pf)
 {
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
+	/* The PF cannot be removed until there are no more remaining
+	 * outstanding references to the PTP port. To make sure this is true,
+	 * first remove the port from the list, then drop the primary
+	 * reference this PF holds on the port. Once done, wait until all
+	 * existing references are dropped. Finally, synchronize_rcu() to
+	 * ensure that all RCU critical sections that might attempt to
+	 * dereference the port are finished.
+	 */
+
+	spin_lock(&pf->adapter->ports.lock);
+	list_del_rcu(&ptp->port.list_node);
+	spin_unlock(&pf->adapter->ports.lock);
+
+	ref = &ptp->port.ref;
+	kref_put(ref, ice_ptp_release_port_rcu);
+
+	dev_WARN_ONCE(ice_pf_to_dev(pf),
+		      !wait_var_event_timeout(ref, !kref_read(ref), 15 * HZ),
+		      "Timed out waiting for port references to release. Continuing to unload anyways.");
+
+	synchronize_rcu();
 }
 
 /**

-- 
2.55.0.814.gc42f45431d0f

