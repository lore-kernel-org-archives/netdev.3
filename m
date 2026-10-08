Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3644B690
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496643; cv=none; b=RbmluKMRBuGiGrHOOqLlg7U4fLUY+25OGQulJhPPG+rYDIgtMfE8Po3pnggxCf/DgXxXzR8WV+dqlB/kzZiXsrBN5+kIiueSTqWBITW7Mq0HzdUjO92nXt4hj77h/F1hITCzO8ylf7AfrKnsyubuxqbNXfHvz8p1j5E8Nmfd3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496643; c=relaxed/simple;
	bh=EvBYNIvqZGOAFE5BLhy0EYNK5dOi1ry0wJtlbIIwRyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnkLhpZxS4iOPKArSZSkQsLO3jQpnacO0zHMJvAVaiNqAxkIAPeeTEvaQs1IrI04SdPWI0QDUzNRCp2I/OReVJk0xptXypE/7POfyYVGIvSBx+K+zFFq8ipCtcRrla+TcQcPmIfxHVlgtsWl492LqF+yJGxLQB3rucllzOtDGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEQjs7wb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEQjs7wb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496642; x=1823032642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EvBYNIvqZGOAFE5BLhy0EYNK5dOi1ry0wJtlbIIwRyc=;
  b=FEQjs7wbQ2qlfdmK8NVrMmUyztMAMLcGZARyop8QlEpavQJ3vhCQ+1nw
   qV1PP/+x9qsPc6yv/qF4b8Qzhsmv+y2vugseAPWhpvFtIGIlYQIpOVLhb
   xsE7lMLdjKvZm20vufYm6vAgg1Q56TJfxgRQ6RyTL0/KUKXnVufvOoRWj
   juKPs1aaV1MdM6diOvQdaZ2SAHKT1CygKjEqWWpKsWw2jmyPEhJxvSaMr
   BJfnK+PwT3sdJodtG/eq07F1jxc1GBYELVPPmBLZwVPYrCGTTVgwxLNGC
   1oYOBFu4TEmLTHJjAEDXs+BiwCGMyfxPUrIlvcdgu0gZX6toDvM5i45HQ
   Q==;
X-CSE-ConnectionGUID: 4Z+qpMEVRhSwYcVrV5Di0w==
X-CSE-MsgGUID: 0Ya4ZMQwRvmaO+1Nrzw9UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294645"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294645"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:17 -0700
X-CSE-ConnectionGUID: 60x17OHCQRm4FSsYo/j+cQ==
X-CSE-MsgGUID: PJeQLqVEShimtsBLG2iu0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150411"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net v2 05/15] ice: call PTP link change only from link events
Date: Thu,  8 Oct 2026 14:56:02 -0700
Message-ID: <20261008215614.1987250-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261008215614.1987250-1-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Remove redundant ice_ptp_link_change() calls from ice_up_complete() and
ice_down(). These duplicate the call already made from
ice_handle_link_event(), resulting in four problems:

1. Double initialization on link-up: ice_handle_link_event() calls
   ice_ptp_link_change(true), then ice_up_complete() calls it again.
   The second call re-enters ice_ptp_port_phy_restart(), re-setting the
   calibrating flag and restarting the PHY timer while the first
   invocation's offset verification work (ov_work) may still be running.

2. Premature cleanup on administrative down: ice_down() calls
   ice_ptp_link_change(false) during ifconfig down or reset preparation,
   even when the physical link is still up. This clears timestamp state
   unnecessarily and can interfere with ongoing PTP operations.

3. Ordering dependency: ice_down()/ice_up_complete() are called during
   reset sequences where PTP may not be fully initialized, creating
   edge cases with partially configured state.

4. Administrative commands such as changing MTU trigger ice_down_up() which
   then forced a PHY restart that is destructive to outstanding timestamp
   processing that is otherwise unaffected by the administrative actions.

The link event handler is the correct and sufficient place to drive PTP
link state changes, as it reflects actual physical link transitions. Remove
the calls of ice_ptp_link_change from the ice_down()/ice_up() flows.

Initialize the link_up in ice_ptp_init() and ensure that we check and
restore the link status at the end of the rebuild flow, ensuring that we
initialize the PHY timer appropriately after a reset.

Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 41 ++++++++++++++++-------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..f32041dd8b27 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6745,7 +6745,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7273,7 +7272,6 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
 	}
@@ -7794,6 +7792,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_update_pf_netdev_link(pf);
 
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
+		bool link_up;
+
+		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
+			     ICE_AQ_LINK_UP);
+		ice_ptp_link_change(pf, link_up);
+	}
+
 	/* tell the firmware we are up */
 	err = ice_send_version(pf);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index bbb57edcec0f..220d174397ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -583,7 +583,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	}
 
 	/* Drop packets if the link went down */
-	link_up = ptp_port->link_up;
+	link_up = READ_ONCE(ptp_port->link_up);
 
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
@@ -1251,7 +1251,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
 
-	if (!ptp_port->link_up)
+	if (!READ_ONCE(ptp_port->link_up))
 		return ice_ptp_port_phy_stop(ptp_port);
 
 	switch (hw->mac_type) {
@@ -1315,7 +1315,7 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	mutex_lock(&pf->adapter->ps_lock);
 
-	ptp_port->link_up = linkup;
+	WRITE_ONCE(ptp_port->link_up, linkup);
 
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
@@ -1461,7 +1461,7 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (port->link_up)
+		if (READ_ONCE(port->link_up))
 			ice_ptp_port_phy_restart(port);
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -3271,9 +3271,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 }
 
 /**
- * ice_ptp_init_work - Initialize PTP work threads
+ * ice_ptp_init_work - Initialize the PTP kworker
  * @pf: Board private structure
  * @ptp: PF PTP structure
+ *
+ * Allocate the kworker and initialize the periodic work function. The
+ * periodic work is not queued here; the caller starts it once the PTP
+ * state is ICE_PTP_READY.
  */
 static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 {
@@ -3292,9 +3296,6 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 
 	ptp->kworker = kworker;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	return 0;
 }
 
@@ -3414,8 +3415,23 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err_release_tx_tracker;
 
-	/* Start the PHY timestamping block */
+	/* Create the kworker before restarting the PHY, which queues work on
+	 * it in the E82x restart path.
+	 */
+	err = ice_ptp_init_work(pf, ptp);
+	if (err)
+		goto err_clean_pf;
+
+	/* Seed link_up from current PHY status, since link may already be up
+	 * (e.g. after PXE boot) with no link-change edge to catch it later.
+	 */
 	mutex_lock(&pf->adapter->ps_lock);
+	if (pf->hw.port_info)
+		WRITE_ONCE(ptp->port.link_up,
+			   !!(pf->hw.port_info->phy.link_info.link_info &
+			      ICE_AQ_LINK_UP));
+
+	/* Start the PHY timestamping block */
 	ice_ptp_port_phy_restart(&ptp->port);
 	mutex_unlock(&pf->adapter->ps_lock);
 
@@ -3424,9 +3440,10 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_READY;
 
-	err = ice_ptp_init_work(pf, ptp);
-	if (err)
-		goto err_clean_pf;
+	/* Start periodic work only after the state is READY; the worker
+	 * returns without rescheduling while the state is not READY.
+	 */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
-- 
2.47.1

