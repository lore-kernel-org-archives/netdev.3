Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844547A0A5
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100507; cv=none; b=e/zsYUjY2C3owXXlF8yXfXFbp+YHGK6vtsgxn3qK3VLJoISNNbEgOkxzKAApNgvn4J9KeWc5XtDzp+YHp51H3etCIM1gmKfZ6ok/xkuhGfwSPDxUhEr6gBl1TinRp9MPHt4+sh4uKTaBIsM60rfgrc1q3HZo+xWTUDtAxeklzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100507; c=relaxed/simple;
	bh=UBEiLjWOKI122kTUAfj+4SUrO4xRBdnmc7aWTNRqiC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGgaoMBYDfXBeYmYTYV083/a1z3U/c3c18S6SgE5vkFcKEMgsqpf6wjPxdqXm+XFcuD3u7WFAGWKE/kNQVmYdNBQ4SSKHFUcoft/wRi+yI80aEIh5dQhqqW8j3W14sDECUoRlgvHmYdOJJI7TYvPdypOTy0EfJtl5/AIFD6ruYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8QDfq2i; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8QDfq2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100505; x=1821636505;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UBEiLjWOKI122kTUAfj+4SUrO4xRBdnmc7aWTNRqiC8=;
  b=l8QDfq2iY02MUFYOWuFBTuLEx522zDRcmIUSfROZ6kdXb2x9oZSkOGpe
   7CK7fV3Tnu2Az5FoAKBzB+F3pSctxjatL9ZhGBbhGIyBw5ajMvfbL/9hr
   lmgSzsTckIscMMHYxCZvIVJ0y82YhTeIMfp6MFn6VCddmQ7B+ni76FZkH
   1WPEcLw8RAKl9R3EOOtK9d0z4YR9Vicr8jKCU46dbiP5VadCnnp+InJTP
   zNlxF0SQ4n71L9WTvgUCEbx8PDtGtBSXdLWPBy4w1XdejUZB05QXoY39c
   VSqKn+hALNZBpcyevQ3w5KVyHxzglBWhj+zs2COnig4HZb92vahiCWfOa
   A==;
X-CSE-ConnectionGUID: tFd0+XIKRXC7NJWzsfs9cg==
X-CSE-MsgGUID: yyH+79qAScuAuS6gqSokbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232030"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232030"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: JCC6RXy0TcqRYlzztfJWdw==
X-CSE-MsgGUID: 5CNarpmDTiO4Oe8PtaKFjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315300"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:36 -0700
Subject: [PATCH iwl-net v2 03/15] ice: fix removal of PTP timestamp tracker
 during reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-3-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3902;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=UBEiLjWOKI122kTUAfj+4SUrO4xRBdnmc7aWTNRqiC8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6X2dcyWTjvoHbyQ6XL/8YdJjtec13v67ii6NHfzn
 YqATVpWHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzkRxwjQ8O3yGtfvnLU96vr
 LLn/RLvcMkigsO7C+rVdv050KucWb2JkmLk9ePc9aT5rkyfBbK9rb/P5cMSs3h3H1iHwaYbhNOn
 NPAA=
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
                               offload-shared ram-shared mac-shared phy-shared

Remove the call of ice_ptp_release_tx_tracker() from
ice_ptp_prepare_for_reset(), to keep the tracker memory in place so that
timestamping can resume after a reset.

During review of a previous version of this change, sashiko pointed out
that the teardown flows for ice_ptp_init() and ice_ptp_release() could
potentially leak the PTP timestamp tracker. Fix ice_ptp_init() so that it
correctly calls ice_ptp_release_tx_tracker() as part of its teardown on
exit. Fix ice_ptp_release() so that it handles the cleanup if PTP is in the
error state by cancelling the kworker items and releasing the Tx tracker as
appropriate.

This was found by Sashiko review during feedback for an unrelated change,
and iterated based on further feedback from Sashiko after the initial fix
to remove the call to ice_ptp_release_tx_tracker();

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/
Fixes: 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker during reset")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4422588472d0..2bb9beb94806 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2996,8 +2996,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_perout(pf);
 
@@ -3454,11 +3452,13 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	err = ice_ptp_init_work(pf, ptp);
 	if (err)
-		goto err_exit;
+		goto err_release_tx_tracker;
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
+err_release_tx_tracker:
+	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 err_clean_pf:
 	ice_ptp_cleanup_pf(pf);
 err_exit:
@@ -3488,6 +3488,14 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	if (pf->ptp.state != ICE_PTP_READY) {
 		ice_ptp_cleanup_pf(pf);
+		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
+		if (pf->ptp.kworker) {
+			kthread_cancel_delayed_work_sync(&pf->ptp.work);
+			if (pf->hw.mac_type == ICE_MAC_GENERIC)
+				kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
+			kthread_destroy_worker(pf->ptp.kworker);
+			pf->ptp.kworker = NULL;
+		}
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;

-- 
2.56.0.rc0.395.gd1f3524e15dc

