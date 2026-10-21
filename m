Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620802;
	b=JxSDb6GfZG42D5qlB4sjES4B2dwJKP8icfwIclI3AeogE+URGkOXVvNjQynZqDrCbAsH
	 ByvSVo3ptPoErFletGnU1XJLGjNdahpYl9Cpljz8+W/KqFwjs0mK3GBGZHIeLi/tFwlRh
	 WUfX6My6QLrMeaUhobWf6TlMRRWEwtwA5jom6Yo32H7TZ62UQ9tlX7PHylWTDTHlNgxBN
	 vtaWPT2nsDrS4xA+OwK1Ya1uk+bJCgwnQYSHjnNQ+0FiycGmGwtL5pJqDePAGjeJWRov7
	 T6GAK4Ww4zmJf7pYMnbJJE48BMDEr4QXR6IhuiFAALdWZ852v/n6CuFiI8JVpY6hK3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620802;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=knuQs3FPqFDGUOyRCEf3wE6mk/GKWsb6jjvA3oknn7U=;
	b=MXRK3qtHiIXAle+2oXTKTYLfU6iV93zOh3dMlmAYbfkPf6KGAbBpegDi2Nl7HUF2kBrN
	 ECtM7IIY9MyVXWY3Ig2RpOaIgeHrLyGgrtfc0rE6LVshyeC0rkOmkPbPrNoRwe/TYoGvu
	 VBl39CUFVXh56yelgAbeIMH0CG5c7LywrAVIsWsyhUX4SHA1bC4z9JLB9XHNunwKCvZWm
	 WQ9GoCOSzL5DQhGbpK0PY/RL8Uicqcun2N80mF6JvOm7K+tdlCEmV6JvI3E9tEQKFmLOI
	 L2C2PVfP0EHsBI28BI0dcwOy5spRKIUAMclJaOXz9YT726bFNtVNBVKSWvTrWsVvhMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=(null) smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y+dsA9hK;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED8606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41ED8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y+dsA9hK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792620796; x=1824156796;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vpypxwImkEgUwsAkhk6OOYffIuB6exWjo9q/uoAZ81c=;
  b=Y+dsA9hKSoZ1IU50Jb43AhoXW5sBZmpoV4KGP4igeSxAY9leiwvlHJFV
   Q4/MO5ezTKJIu4lmL/KXFzwGse4r15hFN09uXKBQlhMVTWSPkt56kXmSk
   epKhN6RG6ZndMHe6JwhInwUetTjSQWcMo1zINu9LxlfztVPMNkvUo1zxn
   XmcGcl8DiwxR5FwxauugP6ZwVtUrztCEjwujP+6KeVsJYoSDGrcAq57Jj
   EyWQ4K5IoZmPytAucwmlqIMACDWnUH+g8AQGssJcZvfgAvOqf1riQ+mT0
   nh/37ZpkZ3kVuqaJyyXrr89ZcF5T5JsAHuNSBKzCYvrrm4RRaGo/S/RcT
   Q==;
X-CSE-ConnectionGUID: J/42hsJATgGYm0uqtvGC4g==
X-CSE-MsgGUID: 3xrqgZ83QfOL87W43SrtHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1363162"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1363162"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:11 -0700
X-CSE-ConnectionGUID: iLUgzHvKRPO14EIJyor4YQ==
X-CSE-MsgGUID: b5ljC4ZLQsiLBAZnaJXVfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3275458"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 21 Oct 2026 15:12:46 -0700
Subject: [PATCH net v5 01/13] ice: fix removal of PTP timestamp tracker
 during reset
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
Message-Id: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-1-72289a4ac8eb@intel.com>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
In-Reply-To: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6107;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=vpypxwImkEgUwsAkhk6OOYffIuB6exWjo9q/uoAZ81c=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqybFu+PdguJ/ZsYK35pS9ydb4JbEgXaVy7JvvDNPlgwJ
 OSA6KqAjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZyK4/hv3+hXPjfm5dUytvK
 d66IzF7C37nXQu7BbvXvMguX53EllDP8D3c8y9vT75CvvHeJ1fk7DAx3AmY+a8x49FzzspBsUos
 ENwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 46 +++++++++++++++++++++-----------
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
2.56.0.212.g129ede20d986

