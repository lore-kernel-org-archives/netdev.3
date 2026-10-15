Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5456E045
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091489; cv=none; b=BFW9fmliiaHrLsSSIHIeCGyI8o6OmSWKxutl69gJSXcCFXErvT4mYGBBUpPM2HYGJPVwEW0k7/5ESJq/PUDP9QyrxtpnJ3Dg0CF+o33HEuH3Jqz8adOoV1lICvgQRnDqpK2Mirb6c0iAYko7XUpkgQFFYn/Eee/910o0Mqa5p14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091489; c=relaxed/simple;
	bh=5LgCkq1/dePD1mexdRovRhsaJy1RFFRUS1dgPdN17hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHQgo5MbB6567RccASPu8RKyY87w9nsk7BrS/yTcsSTTYXCd8QkJdngLoa9nL882XWoKn7os9WYXCazEXxXATsqPcnxjRtFDwIkXCAcno8Y+lixTqPRgZtY0C2JLLHjgmMC3pMjeQxOzhWjMI2smzDlQSPTs+NwRluEGBnd5vtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImUY78VV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImUY78VV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091482; x=1823627482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5LgCkq1/dePD1mexdRovRhsaJy1RFFRUS1dgPdN17hk=;
  b=ImUY78VVM8rnWuC53Unq8Qmd7T/43UgiN06BbZF48fQsL2xdi26dcIT3
   T/W9D47uh471y8l5WatWmaW84rSvidPy/fxJjuHphryT6qxNkyI2RcHZY
   M10bPYvZ5FvVnrasmn2M55q/+HyJAXbu0nqqRHZ8kl7SNSvrsf0qP3njC
   1bviW8jmAaiDzf7hu7eESxDVjX6dDLggmkpm0QTuxYxz+s40Ezz/akrxV
   M5rOh/kZrh6wXeTqGeQHXse5FqGxAXI99rxav/MnEz23QMsp0a1vuiu3L
   8aJzgLhQhdDVYB4K8S4S0FAptUEmqtlxoefczS/qxoP+8+k8xqT6aOMdN
   g==;
X-CSE-ConnectionGUID: SuJ5LjBmTlCQw7Jzx52kVg==
X-CSE-MsgGUID: IHOpUh9dTDacrLaLmyEHlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765569"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765569"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:14 -0700
X-CSE-ConnectionGUID: Rz6NTTnoT8yxMrIo4//EiA==
X-CSE-MsgGUID: ix31+IYtSvOEVBCmfdDSdw==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078476"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:13 -0700
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
Subject: [PATCH net v3 05/14] ice: call PTP link change only from link events
Date: Thu, 15 Oct 2026 12:10:51 -0700
Message-ID: <20261015191102.1174111-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

The ice_ptp_link_change() function is currently called from
ice_up_complete() and ice_down(). The up and down functions are called from
many places including a variety of administrative tasks such as MTU change.
When called, the ice_ptp_link_change() function forces the PHY to restart,
which can be destructive to ongoing timestamps. We must restart the
timestamping block if the link has changed, but we do not need to restart
it for most of the administrative tasks. The calls also cause unnecessary
re-initialization at every ice_open(), and trigger premature cleanup at
ice_down() even if the actual link hasn't dropped.

Ideally we only want to toggle a PHY timestamping block restart if the
physical link has changed or we are fully reconfiguring the clock. To that
end, stop calling ice_ptp_link_change() during ice_up_complete() and
ice_down().

Initialize the PTP link_up field at probe as part of ice_init_link(),
before the service task and link event handling are enabled. Modify
ice_ptp_link_change() to always update port.link_up even if the PTP state
is not ready, so that it reflects the most recent link edge. Update the
ice_ptp_init() function to first set ptp->state to ICE_PTP_READY, and only
then call ice_ptp_port_phy_restart().

Finally, ensure that ice_rebuild() calls ice_ptp_link_change() to reflect
the current link status in case it changed and an edge was missed during a
reset.

These changes ensure that the link status will reflect the current state of
the physical link without needing to start and stop on every internal
ice_down_up() sequence.

Note that both ice_ptp_init() and ice_rebuild() may result in a duplicate
initialization of the PHY.

In ice_ptp_init() this could happen if a link status event happens
concurrently with ice_ptp_init(). The ice_ptp_init() will call
ice_ptp_port_phy_restart() at the same time as ice_ptp_link_change() is
called by ice_link_event(). While the PHY may be initialized twice, it
should always end up in the correct state. Either the call from
ice_ptp_init() completes first, and then the correct state is set by the
ice_ptp_link_change(), or the link change completes first, and the call
from ice_ptp_init() reconfigures with the updated link_up state.

In ice_ptp_rebuild() if the clock owner has reset, it will call
ice_ptp_restart_all_phy() which will begin a restart on each port. For
large resets, like CORE reset or GLOBAL reset, each port will also reset
and then after rebuild each port will restart its PHY timestamp block
again. This is necessary because the link state may have changed between
the time the clock owner restarts and the rebuild finishes. These duplicate
restarts do force extra work on the PHY, but should only happen during
initialization or hardware reset, and are better than leaving the device
misconfigured.

Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 18 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 20 ++++++++------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..b4ee2cf7cd70 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4810,6 +4810,14 @@ static void ice_init_link(struct ice_pf *pf)
 
 	ice_init_link_dflt_override(pf->hw.port_info);
 
+	/* Seed PTP link status from current PHY status, since link may
+	 * already be up (e.g. after PXE boot) without a link-change edge to
+	 * catch it later.
+	 */
+	WRITE_ONCE(pf->ptp.port.link_up,
+		   !!(pf->hw.port_info->phy.link_info.link_info &
+		      ICE_AQ_LINK_UP));
+
 	ice_check_link_cfg_err(pf,
 			       pf->hw.port_info->phy.link_info.link_cfg_err);
 
@@ -6745,7 +6753,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7273,7 +7280,6 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
 	}
@@ -7794,6 +7800,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
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
index 11416e23dade..776f211290ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -583,7 +583,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	}
 
 	/* Drop packets if the link went down */
-	link_up = ptp_port->link_up;
+	link_up = READ_ONCE(ptp_port->link_up);
 
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
@@ -1258,7 +1258,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
 
-	if (!ptp_port->link_up)
+	if (!READ_ONCE(ptp_port->link_up))
 		return ice_ptp_port_phy_stop(ptp_port);
 
 	switch (hw->mac_type) {
@@ -1315,17 +1315,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
 
-	if (pf->ptp.state != ICE_PTP_READY)
-		return;
-
 	ptp_port = &pf->ptp.port;
 
 	mutex_lock(&pf->adapter->ps_lock);
 
-	ptp_port->link_up = linkup;
+	WRITE_ONCE(ptp_port->link_up, linkup);
 
-	/* Skip HW writes if reset is in progress */
-	if (pf->hw.reset_ongoing)
+	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
 		goto out_unlock;
 
 	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
@@ -1468,7 +1464,7 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (port->link_up)
+		if (READ_ONCE(port->link_up))
 			ice_ptp_port_phy_restart(port);
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -3426,7 +3422,9 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err_release_tx_tracker;
 
-	/* Start the PHY timestamping block */
+	ptp->state = ICE_PTP_READY;
+
+	/* (Re)start the PHY timestamping block */
 	mutex_lock(&pf->adapter->ps_lock);
 	ice_ptp_port_phy_restart(&ptp->port);
 	mutex_unlock(&pf->adapter->ps_lock);
@@ -3434,8 +3432,6 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
 
-	ptp->state = ICE_PTP_READY;
-
 	/* Start periodic work now that the state is READY */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
-- 
2.47.1

