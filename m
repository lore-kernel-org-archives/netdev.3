Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2720D4F0
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357703; cv=none; b=FBidxb3MrOhfSLoYvMWyOr3wlZDReOnYoRh0KWztQ2oaPD/YRrsoL75ROz1FVJ/w/93P7dwEH7BIWcu6P4N0o7wNvo97205xBH4E8UmhYWp0rME4e1dy5Y3EQnb/EN5+JuQKkm19lw1aElhcUTgEVKbL076Bt0C/fG7Ysc0LhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357703; c=relaxed/simple;
	bh=v49SQFMhOzMtNigLXBHbsxtSesAnp9SN8lNHGpc13Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHZ2B4UBqFXFHUVvESMP0gYLJP2eriqS3xuBydP3NrqQFimpV3iFE7YSO3AGSwe0+gz8u/DDO7EqIM/SlHLwhG+QMWFjDPFVf7Z+FxXwD2KP3VY3bIqEAEARwkMl9EKZpLgfbIW5rGDnpKMRUqyLGr0FiC7zoPX4FjuB4ohscCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSM1/MqG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSM1/MqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787357701; x=1818893701;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v49SQFMhOzMtNigLXBHbsxtSesAnp9SN8lNHGpc13Pk=;
  b=LSM1/MqG2qSjOSwRZ8PXLZu9D59KhReGdOmQVN5p7kWAsps6uGbJC1m/
   9nJpVR95WLMbwCIW23uQZtkFpD94YtokvKyYO99wkqws8mdfI5i0h8wn4
   LFCQ+k54R/z2D7bd7tDyPjthfBtPiew2ZluIIhSysh13588Kr4JetN+eh
   i06s7yJgVKyvBfv0BCplveAGIwNMxjOr5yaY1kWvkuaqc/DQYOOVcVFiY
   LNC2ceoOSGFhFiPOVTHHyKDG9AWusdNUz/Gzhp5rH1RSkWaBrz5i9WQru
   rUIBXjVntr5p74syhbDUi+oKKqg9NlUjkzfwcqRe2VgTRTV8t91iIQbzW
   g==;
X-CSE-ConnectionGUID: feO1r8XRSrG5YMBVZHkg1Q==
X-CSE-MsgGUID: H1aM+0rLQ5S/Ti3pPDdUqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584761"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91584761"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:58 -0700
X-CSE-ConnectionGUID: fGYRyzeQS3aycnBrmsnFRQ==
X-CSE-MsgGUID: /ScqY8EWS0WsXq0sVss3Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263836468"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:58 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:09 -0700
Subject: [PATCH iwl-net 04/12] ice: call PTP link change only from link
 events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-4-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=5978;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=1mxwf1AeCf0zlLsqd8Hitzlm3lT/yjkTggp4qhu4JQw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOlz/Ppie+/q74Y0eqSA/PsaCm7Lsr2ThFDf46qc0OF
 OMSWevVUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwERmxjMy9DJY1Wg9mb5k6dUr
 h93idZu4tkTZ3Cy/67Tgr3R+SFrQBUaGt3U//d6bbO+/Yv9HLdDcJrPAQjdn5+dc7ROSE668OpX
 CDwA=
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
---
 drivers/net/ethernet/intel/ice/ice_main.c | 11 +++++++--
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 38 +++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..bb631ae9e67d 100644
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
@@ -7794,6 +7792,15 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_update_pf_netdev_link(pf);
 
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
+		bool link_up;
+
+		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
+			     ICE_AQ_LINK_UP);
+		if (pf->ptp.port.link_up != link_up)
+			ice_ptp_link_change(pf, link_up);
+	}
+
 	/* tell the firmware we are up */
 	err = ice_send_version(pf);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b8647a39db6d..8aa49dda90a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1327,14 +1327,14 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
 
-	if (pf->ptp.state != ICE_PTP_READY)
-		return;
-
 	ptp_port = &pf->ptp.port;
 
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		return;
+
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
 		return;
@@ -3296,9 +3296,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
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
@@ -3317,9 +3321,6 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 
 	ptp->kworker = kworker;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	return 0;
 }
 
@@ -3441,6 +3442,22 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err_clean_pf;
 
+	/* Seed link_up from current PHY status, since link may already be up
+	 * (e.g. after PXE boot) with no link-change edge to catch it later.
+	 */
+	if (pf->hw.port_info)
+		ptp->port.link_up =
+			!!(pf->hw.port_info->phy.link_info.link_info &
+			ICE_AQ_LINK_UP);
+
+	/* Create the kworker before restarting the PHY, which queues work on
+	 * it in the E82x restart path. This prevents concurrent link events
+	 * from reaching ice_ptp_port_phy_restart() while kworker is still NULL
+	 */
+	err = ice_ptp_init_work(pf, ptp);
+	if (err)
+		goto err_exit;
+
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
 
@@ -3449,9 +3466,10 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_READY;
 
-	err = ice_ptp_init_work(pf, ptp);
-	if (err)
-		goto err_exit;
+	/* Start periodic work only after the state is READY; the worker
+	 * returns without rescheduling while the state is not READY.
+	 */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;

-- 
2.55.0.814.gc42f45431d0f

