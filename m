Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE85490BE3
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698511; cv=none; b=RNvDjmiRlMiP0suoDeVlV0I8+KgCT9uqj1Cs7CgD2WrKcaGoJcIjB7P+XX/nR6ibOugfQvfV/VBJn1KwTk/2CXd9uPzRDz1zYjDFKI2TFg+zu2ojQ4WpNq9LicSpMXXfp793JN+LUNmQUTmaRB7rsRGBwh9iDXnp5fhWhzAG5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698511; c=relaxed/simple;
	bh=dQ+G9+rNRMpePTvVPLCG6ubLQxrn0xBhcpiVls7SI4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTZuDctLWMhu6TaeKrG4NGsYNtbhDudAU375MyNcMThTU6eW7UIaZRvX7NxulLSHHfDhHbZfw/8zGvpBU2NfFj1lbB5RASnNQRvPNzrgbHxKvkwi2TOe0WgrSxNUgs5d3epNsOd958toSWahJQvM6VtMjYbY3JM18t6g2GYP1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPhF/rz/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPhF/rz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698510; x=1819234510;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dQ+G9+rNRMpePTvVPLCG6ubLQxrn0xBhcpiVls7SI4Q=;
  b=EPhF/rz/n0NsfLyqd8DzNGFGALSTi0ATrQ+Re189nHDlxLlDnXICXneJ
   k59UFRZQvZnuOSxixwB99RQIm4esc1YK04YnEP6BLTFhgw2thQQS0Giye
   TU08krhoVGX9FhYZ2j2YSpXrQaNcUj7ZsToUXIFroJHMIixDokkQ/L7bq
   sSMUDXJSxKJAgyHakRiuUn3qSlSa1Fb8p/r1yqfT+XKA9LhPMktAHJNMb
   Yo958XoIyKdcGMLc6NseHlf4mfO20x6MdcakOXQZ59WFslarmeq0d+ZSI
   bEAmZ/8WUBIsnPT3QNITib031VOFaUqgqqGAMv9QUcA2lrHUaWmwGckQW
   A==;
X-CSE-ConnectionGUID: qa8jh9QAQs6m2PKCF/HSOA==
X-CSE-MsgGUID: qZF/BYf/TnSCrrggWA6V9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120429"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120429"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:06 -0700
X-CSE-ConnectionGUID: 3SvaR91SSWqQm6NA5o4LLQ==
X-CSE-MsgGUID: GNx0LH52Ttm9TcbuY+Yf/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789677"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:30 -0700
Subject: [PATCH iwl-net v2 06/14] ice: call PTP link change only from link
 events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-6-8223f95d26e3@intel.com>
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
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=6083;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=rH8lYRCTAzMmlC72hCDT79twpPC7KTiaz617iQWXhTY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WZtAtchuy84YM+tDe0t8lvztqy2P7n2q1ukq0Xsw5
 bSnzd+OUhYGMS4GWTFFFgWHkJXXjSeEab1xloOZw8oEMoSBi1MAJpITyvA/Oude/c30Zn22A3ZX
 964V5nAo7ZjZXMlcwfRm9ly3j6L3GP4HXsi7wP7sW1/EPhHfl6lpJj/DtfZdbJz6YP06tgvmAkl
 MAA==
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
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++--
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 38 +++++++++++++++++++++++--------
 2 files changed, 36 insertions(+), 12 deletions(-)

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
index 9bf3bac552f1..c535658b30fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1323,9 +1323,6 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
 
-	if (pf->ptp.state != ICE_PTP_READY)
-		return;
-
 	ptp_port = &pf->ptp.port;
 
 	if (!kref_get_unless_zero(&ptp_port->ref))
@@ -1334,6 +1331,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		goto exit_kref_put;
+
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
 		goto exit_kref_put;
@@ -3298,9 +3298,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
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
@@ -3319,9 +3323,6 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 
 	ptp->kworker = kworker;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	return 0;
 }
 
@@ -3443,6 +3444,22 @@ void ice_ptp_init(struct ice_pf *pf)
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
 
@@ -3451,9 +3468,10 @@ void ice_ptp_init(struct ice_pf *pf)
 
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

