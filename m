Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489578;
	b=M5zXZfb1xBR9J05Fk6iTiFXK8XId2sWnjrHDhygcQgA54fIKAYLF+b8olMjbqkkGuINm
	 Ss/3ge4meUSU8TU2eBX+37dOh0Qv+IRBzQvlRgxPLTxr9mGCX48nN+myvIoX6Ndk0lID4
	 1mXGIV7ROP9kh/jFs47EIiu0+y9hgTBB1qfBojDihZU0lFZeT9uA29XFQQvg9VBldQJGo
	 od8qrsoWsedhLoS8+/7oAGYI963FJNtLid4QLL3OZeeQCk0Rs7YDfF1W7BwlEZDXjDCcZ
	 UdEx0hn4ZDPil7+X9KZZEh1xGpY0JW19idFOFX3sClovGx39497VoVP4Nfk93vFubZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489578;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=P4i9J0xOHJRbRNVAadjMHPShGM5k3dZz4wKy871yF9A=;
	b=U3r3I7CKuxaLPU6HZuCfTkF9ESgfe6lRtiwd8Bs6fIOW15mc5y/OTXzZKsDMrghVqvEu
	 MildN01jTfcGNSwRkmpemVRV/vuVERIas5+mpRk3O6CZbkY0Niz69kfxYIXiqvI09vvEv
	 revWZ5kMIwe+1i1wgSBms7eqEDGdxp6UrfdYO04p6D0trzEhguRmIszP3URumL3uF4b7O
	 8WX22a+I/ys/LX+AnYBQ3387A+zpyZRvOeMV+2mwi9Kb/6h0sPOqSk2YqF01fLqF8Mb+d
	 R2Xlf07lvNx3osY9Pr8HW7GVYRp79/JGkRC5Ku58HDwVaahpk3ppE+VbYCi32VIvrrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZbnU3aa8;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BD606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C47BD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZbnU3aa8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489576; x=1824025576;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vnCO/ZTdxut6FJHqvRRSq59TV6JNQiFMcLgw8O4l/to=;
  b=ZbnU3aa82oUOANnllJg66HBtPp5c7loFkqIt2fYcbgw5U0004JF5t19c
   db3HEZt73wwI6/dI5wRf6w+oEJ3t05blfPUh/SorSBGyYppIhexGiG/JI
   EQ0KeH5vcVww0yvTLsudPPj7LG7YRsQg0gKAUJVrlj1ImLDM62wFb53SH
   oUtCjRNR3jp6+LQzVt/16jTvOuMtP4Cp+DO8gTeBTzLa66aVYJNfheD4+
   ZdiHb4yrH3D1c1NujDLauuBNFQStEwF0VLuVIQXOkRZiFebMxN96o+Z+Q
   9oNfGidj5Gvl0FTMMSV/ditj6+ZmPmwc9vvC86GiFDLB9Fl26hnREiHYZ
   g==;
X-CSE-ConnectionGUID: 2/qBv5lTRvSiKnTuHyWILg==
X-CSE-MsgGUID: KVofeCrGTtCgC6YXxrCItQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287883"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: vcGX+AeMQ/CCy3FK2C+tvw==
X-CSE-MsgGUID: +DuiYYhAR7uc5mZhrEY07A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723894"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:34 -0700
Subject: [PATCH iwl-net v4 03/13] ice: fix PHY port restart serialization
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
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-3-3e30fc9adc73@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13095;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=vnCO/ZTdxut6FJHqvRRSq59TV6JNQiFMcLgw8O4l/to=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvGzn5aW3jtxvsD3CiOjxvkv5jvNorO9lt70Zt/rX
 hUTdUW8o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIkcn8bIMG2pfaO0uqhXTsyG
 hE1XVCrD7R5W8X6puPO0sEi8zO/sTkaGXWLn9s/L33vgzWItl5+7ratvlqVInCy9FFilImZespG
 LFQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice_port_phy_restart() function is responsible for restarting a PHY
port, primarily after a link transition. PHY ports must also all be
restarted after a reset, and the E822 devices also restart the PHY after
the .settime64 operation.

If a PHY restart occurs concurrently with a link transition, it is possible
that the link state read could be re-ordered such that the link transition
would start the PHY but a concurrent restart (such as from .settime64)
could see the old link state and decide it must stop the PHY.

This occurs because the restart procedure depends on the link state value
but setting that value is not serialized with the per-port ps_lock. A
following fix for E825 is going to modify the .setttime64 to also correctly
restart the PHY timers, opening the E825 device to a race between
.settime64 and a concurrent link change.

To avoid this, we need to ensure that the port link_up field is set within
the same critical section as the restart procedure. This way we ensure that
the end result is the PHY programmed to the correct state.

Additionally note that the PHY restart procedure already cannot run
concurrently across two ports. The procedure requires executing timer
commands which in turn require the PTP hardware semaphore.

Thus, to simplify the locking behavior, convert the per-port ps_lock to a
single mutex in the ice_adapter. Acquire this in ice_ptp_restart_all_phy(),
and hold it while calling ice_ptp_port_phy_stop() and
ice_ptp_port_phy_restart().

The ice_ptp_link_change() function now acquires the port lock for the
entire change. This ensures that the link state is set under lock. Note the
function does also acquire the dplls.lock for E825 devices. This ordering
is safe because the other callers of dplls.lock do not acquire the
ps_lock.

The switch to a single lock for the adapter instead of one per port is
easier to reason about. It also could be a first step in a plan to replace
the PTP hardware semaphore completely, which is under investigation for the
future.

To avoid losing a link edge, modify the ice_ptp_link_change function so
that it always updates the current link status even if the state is not
ready. Modify the ice_ptp_init function to set the PTP state to ready
before performing its final PTP state initialization. This way, a link edge
that occurs during PTP initialization will not be lost. One of two things
will happen:

a) the link change happens before the link state is set to ready, in which
case the driver will set the current PTP link state before the
ice_ptp_port_phy_restart() intiiates. Since this is under ps_lock it will
be reflected as the current state when programming the PHY from
ice_ptp_init()

b) the link change happens after the ice_ptp_init restarts. In this case,
the ice_ptp_init will set the PHY to the old state, then
ice_ptp_link_change() will initiate a new start that sets the PHY to the
proper state.

Finally, update the link_up field to use READ_ONCE/WRITE_ONCE since the
value is read from the IRQ without a lock.

This fixes one of the issues reported by Sashiko during a previous review
of this series, linked here as the Closes tag.

Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/
Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  2 -
 drivers/net/ethernet/intel/ice/ice_adapter.c |  3 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 73 +++++++++++++---------------
 4 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index c61bd645e460..5cefcd7af8b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -41,6 +41,7 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
+ * @ps_lock: Mutex to serialize PHY port start/stop across adapter.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
@@ -54,6 +55,9 @@ struct ice_adapter {
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 
+	/* For serializing PHY port start/stop sequences */
+	struct mutex ps_lock;
+
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
 	u64 index;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index da2003ba3bb0..27ea502b7576 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -143,7 +143,6 @@ struct ice_ptp_tx {
  * @ref: reference counter for use with adapter ports list
  * @tx: Tx timestamp tracking for this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
- * @ps_lock: mutex used to protect the overall PTP PHY start procedure
  * @link_up: indicates whether the link is up
  * @tx_fifo_busy_cnt: number of times the Tx FIFO was busy
  * @port_num: the port number this structure represents
@@ -155,7 +154,6 @@ struct ice_ptp_port {
 	struct kref ref;
 	struct ice_ptp_tx tx;
 	struct kthread_delayed_work ov_work;
-	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
 	bool link_up;
 	u8 tx_fifo_busy_cnt;
 	u8 port_num;
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 536923b6ae97..572862fcd247 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -77,6 +77,8 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	spin_lock_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.list);
 
+	mutex_init(&adapter->ps_lock);
+
 	return adapter;
 }
 
@@ -87,6 +89,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 
 	cleanup_srcu_struct(&adapter->ports.srcu);
+	mutex_destroy(&adapter->ps_lock);
 
 	kfree(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 55241802d17a..7a1deb3ea212 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -583,7 +583,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	}
 
 	/* Drop packets if the link went down */
-	link_up = ptp_port->link_up;
+	link_up = READ_ONCE(ptp_port->link_up);
 
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
@@ -1195,6 +1195,8 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 /**
  * ice_ptp_port_phy_stop - Stop timestamping for a PHY port
  * @ptp_port: PTP port to stop
+ *
+ * Context: must hold the adapter ps_lock.
  */
 static int
 ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
@@ -1204,7 +1206,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	mutex_lock(&ptp_port->ps_lock);
+	lockdep_assert_held(&pf->adapter->ps_lock);
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
@@ -1226,8 +1228,6 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d down, err %d\n",
 			port, err);
 
-	mutex_unlock(&ptp_port->ps_lock);
-
 	return err;
 }
 
@@ -1238,6 +1238,8 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
  * Start the PHY timestamping block, and initiate Vernier timestamping
  * calibration. If timestamping cannot be calibrated (such as if link is down)
  * then disable the timestamping block instead.
+ *
+ * Context: must hold the adapter ps_lock.
  */
 static int
 ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
@@ -1248,10 +1250,10 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 	unsigned long flags;
 	int err;
 
-	if (!ptp_port->link_up)
-		return ice_ptp_port_phy_stop(ptp_port);
+	lockdep_assert_held(&pf->adapter->ps_lock);
 
-	mutex_lock(&ptp_port->ps_lock);
+	if (!READ_ONCE(ptp_port->link_up))
+		return ice_ptp_port_phy_stop(ptp_port);
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
@@ -1294,8 +1296,6 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
 			port, err);
 
-	mutex_unlock(&ptp_port->ps_lock);
-
 	return err;
 }
 
@@ -1309,17 +1309,14 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
 
-	if (pf->ptp.state != ICE_PTP_READY)
-		return;
-
 	ptp_port = &pf->ptp.port;
 
-	/* Update cached link status for this port immediately */
-	ptp_port->link_up = linkup;
+	mutex_lock(&pf->adapter->ps_lock);
 
-	/* Skip HW writes if reset is in progress */
-	if (pf->hw.reset_ongoing)
-		return;
+	WRITE_ONCE(ptp_port->link_up, linkup);
+
+	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
+		goto out_unlock;
 
 	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
 	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
@@ -1362,17 +1359,20 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
 		/* Do not reconfigure E810 or E830 PHY */
-		return;
+		break;
 	case ICE_MAC_GENERIC:
 		ice_ptp_port_phy_restart(ptp_port);
-		return;
+		break;
 	case ICE_MAC_GENERIC_3K_E825:
 		if (linkup)
 			ice_ptp_port_phy_restart(ptp_port);
-		return;
+		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
 	}
+
+out_unlock:
+	mutex_unlock(&pf->adapter->ps_lock);
 }
 
 /**
@@ -1438,18 +1438,11 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 	}
 }
 
-/**
- * ice_ptp_reset_phy_timestamping - Reset PHY timestamping block
- * @pf: Board private structure
- */
-static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
-{
-	ice_ptp_port_phy_restart(&pf->ptp.port);
-}
-
 /**
  * ice_ptp_restart_all_phy - Restart all PHYs to recalibrate timestamping
  * @pf: Board private structure
+ *
+ * Context: acquires the adapter ps_lock
  */
 static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
@@ -1457,18 +1450,22 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 	struct ice_ptp_port *port;
 	int srcu_idx;
 
+	mutex_lock(&pf->adapter->ps_lock);
+
 	srcu_idx = srcu_read_lock(&ports->srcu);
 	list_for_each_entry_srcu(port, &ports->list, list_node,
 				 srcu_read_lock_held(&ports->srcu)) {
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (port->link_up)
+		if (READ_ONCE(port->link_up))
 			ice_ptp_port_phy_restart(port);
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
 	srcu_read_unlock(&ports->srcu, srcu_idx);
+
+	mutex_unlock(&pf->adapter->ps_lock);
 }
 
 /**
@@ -3308,8 +3305,6 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 {
 	struct ice_hw *hw = &pf->hw;
 
-	mutex_init(&ptp_port->ps_lock);
-
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
@@ -3419,14 +3414,16 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err_release_tx_tracker;
 
-	/* Start the PHY timestamping block */
-	ice_ptp_reset_phy_timestamping(pf);
-
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
 
 	ptp->state = ICE_PTP_READY;
 
+	/* (Re)start the PHY timestamping block */
+	mutex_lock(&pf->adapter->ps_lock);
+	ice_ptp_port_phy_restart(&ptp->port);
+	mutex_unlock(&pf->adapter->ps_lock);
+
 	/* Start periodic work now that the state is READY */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
@@ -3439,7 +3436,6 @@ void ice_ptp_init(struct ice_pf *pf)
 	kthread_cancel_delayed_work_sync(&ptp->work);
 	kthread_destroy_worker(ptp->kworker);
 	ptp->kworker = NULL;
-	mutex_destroy(&ptp->port.ps_lock);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
@@ -3479,7 +3475,6 @@ void ice_ptp_release(struct ice_pf *pf)
 			kthread_destroy_worker(pf->ptp.kworker);
 			pf->ptp.kworker = NULL;
 		}
-		mutex_destroy(&pf->ptp.port.ps_lock);
 
 		pf->ptp.state = ICE_PTP_UNINIT;
 		return;
@@ -3498,8 +3493,10 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	kthread_cancel_delayed_work_sync(&pf->ptp.work);
 
+	mutex_lock(&pf->adapter->ps_lock);
 	ice_ptp_port_phy_stop(&pf->ptp.port);
-	mutex_destroy(&pf->ptp.port.ps_lock);
+	mutex_unlock(&pf->adapter->ps_lock);
+
 	if (pf->ptp.kworker) {
 		kthread_destroy_worker(pf->ptp.kworker);
 		pf->ptp.kworker = NULL;

-- 
2.56.0.212.g129ede20d986

