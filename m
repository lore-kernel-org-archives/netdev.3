Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D74484893
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100518; cv=none; b=ptlDHTo1QXXKBv/kGWiRD7Phl0REF560h2JU3uZyRgmDgLoTywGeZpcaT5nOHVJwyrNr7wR0sM0bcxeV9gO49muD46uTdZvH+VNGeW957X2sBwtYWxBZInGYJpd7yGbZfH5a2glYY+L0e3NxhlRE9/U9cQsPCNAw1NtZS/DkNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100518; c=relaxed/simple;
	bh=M7hBbcQD5vGwW6hqFncSNh5JpUxUxF+LSHoOAOei/iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2OIbiBKBDCO390d1q6lYEiqZatH7WkWaI98AmHsEMlEFwf7dh+6Y0EFNGwfLeUdJy1TcOi3nzpk1tNv71IMy7JrtBqzEvXItqWFQdMgILVM7CASI3i6tpdUuP4iDbTOc5YGeg4/NVF+vRiC7gHp0+Fs5wzbqdG0jAd24L5vGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIvyI7++; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIvyI7++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100512; x=1821636512;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=M7hBbcQD5vGwW6hqFncSNh5JpUxUxF+LSHoOAOei/iU=;
  b=lIvyI7++4hUV03ygt9jG5Yut4UlX6Mc5K7PmVOCaNxZiDRbqBrCnU6AE
   NM3zNp7J9DTfIu5OqA8Jq3fPui8C6ItuExJjAfMEUJbDd8mVBmqSfUp2f
   gxM09tLRsUpbGHZYcqJxXZUElzs+NCGBmep4u9Gi6CFw4dMI9p7vAUv3O
   KEdKx4HC5P3p1pqkythSJe5lmvB+hhA0Eqn7ZxGY4YKsBg+O8ZXveBuk1
   MG6nhoFQeKVP+HEw/WtPTP4ieZv/I//qpXiUz22RbCHRNlGaPuGO1W03R
   8tXQcrPBmllnGidOiCkO3Z+dmgsIbX/Gtzbg3j9JeU114yAErhAx0j51r
   Q==;
X-CSE-ConnectionGUID: ImDKn55TRciqRmuvk0fplQ==
X-CSE-MsgGUID: z/HcKZt2TimavzOuy2UlBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232041"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232041"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: AVrgMaCeRKKxqmKzSs1LVA==
X-CSE-MsgGUID: aAesbFbkTZGwy26dAYZXsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315321"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:40 -0700
Subject: [PATCH iwl-net v2 07/15] ice: call PTP link change only from link
 events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-7-e55b692d0e6b@intel.com>
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
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Petr Oros <poros@redhat.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=7210;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=WsN1eB+SVYem+/7n5M6oJMVqjX8YPIaxx58vSN4rJ6o=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6WXHXxUeOx2pzP7n0vZnMVFLcYCsTU+Ti+DbILXn
 zvWWT6vo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIks38/IsMpj5h+Tr4oBrz9W
 FeZNnL1nX1viXv4baZOOMLQemG8mxs7wT8t/EcfBovWL+H8wRDI/uOt3yvAP49cJpudvsjJWpq0
 1YQAA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Remove redundant ice_ptp_link_change() calls from ice_up_complete() and
ice_down(). These duplicate the call already made from
ice_handle_link_event(), creating three problems:

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
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++--
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 44 ++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 15 deletions(-)

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
index fccea0511eb2..328e90dc51aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -583,7 +583,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	}
 
 	/* Drop packets if the link went down */
-	link_up = ptp_port->link_up;
+	link_up = READ_ONCE(ptp_port->link_up);
 
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
@@ -1269,7 +1269,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
 
-	if (!ptp_port->link_up)
+	if (!READ_ONCE(ptp_port->link_up))
 		return ice_ptp_port_phy_stop(ptp_port);
 
 	switch (hw->mac_type) {
@@ -1333,7 +1333,7 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing) {
 		mutex_lock(&pf->adapter->ps_lock);
-		ptp_port->link_up = linkup;
+		WRITE_ONCE(ptp_port->link_up, linkup);
 		mutex_unlock(&pf->adapter->ps_lock);
 		return;
 	}
@@ -1381,7 +1381,7 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	 * can't re-order the read and end up stopping the PHY after we start
 	 * it due to a link transition.
 	 */
-	ptp_port->link_up = linkup;
+	WRITE_ONCE(ptp_port->link_up, linkup);
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
@@ -1485,7 +1485,7 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (port->link_up)
+		if (READ_ONCE(port->link_up))
 			ice_ptp_port_phy_restart(port);
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -3322,9 +3322,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
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
@@ -3343,9 +3347,6 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 
 	ptp->kworker = kworker;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	return 0;
 }
 
@@ -3465,8 +3466,24 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err_clean_pf;
 
-	/* Start the PHY timestamping block */
+	/* Create the kworker before restarting the PHY, which queues work on
+	 * it in the E82x restart path. This prevents concurrent link events
+	 * from reaching ice_ptp_port_phy_restart() while kworker is still NULL
+	 */
+	err = ice_ptp_init_work(pf, ptp);
+	if (err)
+		goto err_release_tx_tracker;
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
 
@@ -3475,9 +3492,10 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_READY;
 
-	err = ice_ptp_init_work(pf, ptp);
-	if (err)
-		goto err_release_tx_tracker;
+	/* Start periodic work only after the state is READY; the worker
+	 * returns without rescheduling while the state is not READY.
+	 */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;

-- 
2.56.0.rc0.395.gd1f3524e15dc

