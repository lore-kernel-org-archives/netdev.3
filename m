Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791F568FB9
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091479; cv=none; b=aAVo31ci+1W9FjbbcMbiyZ/Ryh5j2LIJUMh8duEJHfGDkSojV5Z3dZgdqZ/ws47ciBSy3FJ2pXTCfPYPzzB1jSEFY2C4ubI1YD6b0jlmeX49W1tPIV66VvpxLRlFB6sonYYCbpOUhTlSKD3XrW+uZnJ7T5UEmbw7ddzrf22KNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091479; c=relaxed/simple;
	bh=rkBUtYpRM3EniMLH9e7yNZajcs7pPdoThg1g7FqftGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvAg8RoOyzn2taoFk71kjYviLUWTvGbwJ3CYHV0FVnfxTAtbpHda/Gkx5j4Yth3deYUbmTwyN78oQeYkjE0zywTm+qMHOpuZ2xonayP2D/vDvoIZYhRunDdYh+azRdrptCWb9MPKEUTaud35uTVRMrGHLysF55WfkpxBIOTVGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJHlTXeF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJHlTXeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091474; x=1823627474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkBUtYpRM3EniMLH9e7yNZajcs7pPdoThg1g7FqftGY=;
  b=DJHlTXeFwiD0E93gtdNknD0QJnPKsobJvGtwhn4rdLBac0w9z5sb7ZFZ
   6k/SuWb3JQ9n4+xDUzebjemnIuX102Q+pXw0hXrQPkpSATxWe19GFc9Sr
   72rGNetOb/+Ld8DtxTE7qWlwqo8EBO6sLQYPR7Tc803jI19bEjh10VuPH
   UFAyTzlH3rnzCtkmZy7q9Gxd7uWkYeSlE3O5s7szBBeVnFzJClE930EdW
   JA6itr2JDz4hxSF2YfAZ8RQiMBd03Wt7XHa8RbbfCTODKKZ/sZ05a9Qm8
   xHM8sGF7FrfznUf3HD4lgdOrgANxV8UuZ4ag0hrU3pOduQnJYA94j5che
   w==;
X-CSE-ConnectionGUID: 0iZsPT/4ST+z4Y5BunH7Ww==
X-CSE-MsgGUID: s4I2AyquQGyzqZu6C+uQwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765540"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765540"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:12 -0700
X-CSE-ConnectionGUID: QskjP71USaWudVgNTdzRLw==
X-CSE-MsgGUID: JWp/lN/iQPKbGGimwRoukQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078456"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org
Subject: [PATCH net v3 01/14] ice: fix removal of PTP timestamp tracker during reset
Date: Thu, 15 Oct 2026 12:10:47 -0700
Message-ID: <20261015191102.1174111-2-anthony.l.nguyen@intel.com>
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

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker
during reset") intended to modify the PTP reset flow of the driver so that
it stopped calling ice_ptp_reset_tx_tracker() during teardown and stopped
calling ice_ptp_init_tx_*() during rebuild.

Unfortunately, the commit only removed the calls to ice_ptp_init_tx_*().
This fixed a memory leak in PF reset. However, now a CORE, GLOBAL, or EMP
reset will leave the device unable to initiate Tx timestamp requests
indefinitely.

In practice the CORE and GLOBAL resets rarely happen in production
environments, while EMP resets happen after a firmware update that is often
followed by a platform reboot. This explains why this has not been caught
until now. However, it is trivial to verify by triggering the reset from
userspace via ethtool. For ice the following command will trigger a GLOBAL
reset:

  $ ethtool --reset eno8303np0 irq-shared dma-shared filter-shared \
                               offload-shared ram-shared           \
                               mac-shared phy-shared

Remove the call of ice_ptp_release_tx_tracker() from
ice_ptp_prepare_for_reset(), to keep the tracker memory in place so that
timestamping can resume after a reset.

During review of a previous version of this change, sashiko pointed out
that the teardown flows for ice_ptp_init() and ice_ptp_release() could
potentially leak the PTP timestamp tracker.

Fix ice_ptp_init() so that it allocates the tracker before adding the port
to the port list, and properly calls ice_ptp_release_tx_tracker() as part
of its cleanup on error. Ensure the ps_lock mutex isn't destroyed until the
PF has been cleared from the port list. Also fix the initialization order
of the kworker to happen before inserting the port into the list.

Fix ice_ptp_release() so that it handles the cleanup if PTP is in the
error state by cancelling the kworker items and releasing the Tx tracker as
appropriate.

This was found by Sashiko review during feedback for an unrelated change,
and iterated based on further feedback from Sashiko after the initial fix
to remove the call to ice_ptp_release_tx_tracker(); It was again iterated
after further sequencing issues were found with initialization and
teardown.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/
Fixes: 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker during reset")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 46 ++++++++++++++++--------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index eaec36ab6ae3..e1c66cd0f94f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2939,8 +2939,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_perout(pf);
 
@@ -3210,9 +3208,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 }
 
 /**
- * ice_ptp_init_work - Initialize PTP work threads
+ * ice_ptp_init_work - Initialize the PTP kworker
  * @pf: Board private structure
  * @ptp: PF PTP structure
+ *
+ * Allocate the kworker and initialize the periodic work function. The
+ * periodic work is not queued here; Instead, it will be scheduled once the
+ * PTP state is set to ICE_PTP_READY.
  */
 static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 {
@@ -3231,9 +3233,6 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 
 	ptp->kworker = kworker;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	return 0;
 }
 
@@ -3347,13 +3346,17 @@ void ice_ptp_init(struct ice_pf *pf)
 		}
 	}
 
-	err = ice_ptp_setup_pf(pf);
+	err = ice_ptp_init_work(pf, ptp);
 	if (err)
 		goto err_exit;
 
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
-		goto err_clean_pf;
+		goto err_release_kworker;
+
+	err = ice_ptp_setup_pf(pf);
+	if (err)
+		goto err_release_tx_tracker;
 
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
@@ -3363,16 +3366,19 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_READY;
 
-	err = ice_ptp_init_work(pf, ptp);
-	if (err)
-		goto err_exit;
+	/* Start periodic work now that the state is READY */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
-err_clean_pf:
+err_release_tx_tracker:
+	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
+err_release_kworker:
+	kthread_cancel_delayed_work_sync(&ptp->work);
+	kthread_destroy_worker(ptp->kworker);
+	ptp->kworker = NULL;
 	mutex_destroy(&ptp->port.ps_lock);
-	ice_ptp_cleanup_pf(pf);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
@@ -3399,12 +3405,22 @@ void ice_ptp_release(struct ice_pf *pf)
 		return;
 
 	if (pf->ptp.state != ICE_PTP_READY) {
-		mutex_destroy(&pf->ptp.port.ps_lock);
-		ice_ptp_cleanup_pf(pf);
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;
 		}
+		ice_ptp_cleanup_pf(pf);
+		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
+		if (pf->ptp.kworker) {
+			kthread_cancel_delayed_work_sync(&pf->ptp.work);
+			if (pf->hw.mac_type == ICE_MAC_GENERIC)
+				kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
+			kthread_destroy_worker(pf->ptp.kworker);
+			pf->ptp.kworker = NULL;
+		}
+		mutex_destroy(&pf->ptp.port.ps_lock);
+
+		pf->ptp.state = ICE_PTP_UNINIT;
 		return;
 	}
 
-- 
2.47.1

