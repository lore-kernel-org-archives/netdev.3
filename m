Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CD43F8A7
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192665; cv=none; b=J3gW98qjRI0SE6AXaKLlEpoEriXRHLfcydLYhRf7tV2goQKCde77Ui4zrEzivbPG4ckLWsBiMS/lGYYCX6L1iGBFFZbIu3rJuouB5oHxt3mAmfH+y8IVbSDFzozNFsts6Z6K4NLwW8sCvadR/QXQ1C9V6r4maDejQWja3WGkunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192665; c=relaxed/simple;
	bh=IwD6K4kyRlobXqoQ3K9YRRFrKFYFz7RBmaw8RRy0dR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buumfZXatE0q0Y7UoeJ4i8pcJMwUOjoPwWM74AqMzmkapIo/meXLcpkGoHkOjof4VGIqudux1dg+n6kG+Shg2bIU/LpnFZYT497obzqOnGaOMz1BwBRXvQ/XTxEk3QqwCEDs7Ad48jm4Xa8dlS/ueityBCTKrjOKaLgex0jLu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9/28oHP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9/28oHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788192664; x=1819728664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IwD6K4kyRlobXqoQ3K9YRRFrKFYFz7RBmaw8RRy0dR0=;
  b=K9/28oHPU//lt22Ps+YGwl8pQ382EpPQwzZJHAYuMsPiA+JFOQImpuoK
   aP1y4Ut2Cny3+Xn5iVIRzAbWSs68W6m7jSkh6RnrI7P8Z2aih41IKL6hc
   P19uDt0xClcTHXQjM5+8tRf8VgliInqWY7URfbVOxjZ0UO9OcYNfONkRf
   pa6395+FTzKxmKIaxPpnYCCwug/Azza44d8NTWMFWpOXSNcg+9/WJWgDg
   62MDc821UaM9jssKMoKJJEDHfjH6r96oJBtqUaluS9nDRb+jhiYUzVdbk
   /FcV/H+UMOpLmVNDr4NHUFi6k0+0/X4UuJDE6O2hvGYZFFKilvilifK+9
   w==;
X-CSE-ConnectionGUID: Bw/DZCqbSzytw3XsyaXFpg==
X-CSE-MsgGUID: 0YbLstA0SJ2h23aPtFJRgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88729032"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88729032"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:11:04 -0700
X-CSE-ConnectionGUID: oAH6JQQJRpKKJj3svqALWQ==
X-CSE-MsgGUID: zR9iogMoQxC1Rcb3gjUSiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="262706482"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2026 09:11:03 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next  v4 2/3] ice: Zero out the PTP control PF pointer at ice_adapter cleanup
Date: Mon, 31 Aug 2026 16:10:59 +0000
Message-ID: <20260831161100.216773-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
References: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zero out the ctrl_pf pointer in ice_adapter when the control PF is removed.
This prevents potential dangling pointer dereference when accessing
PTP-related structures from other PFs of the same adapter.

Fixes: e800654e85b5b ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reported-by: Frederick Lawler <fred@cloudflare.com>
Closes: https://lkml.indiana.edu/2507.3/01388.html
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ec2fd89c18a8..48296a4a8abd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3085,9 +3085,25 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 static void ice_ptp_setup_adapter(struct ice_pf *pf)
 {
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
 	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
+static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
+{
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
+	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+	 * is being removed to prevent any secondary PFs from accessing
+	 * it after it is deleted.
+	 */
+	if (cmpxchg(&pf->adapter->ctrl_pf,
+		    (struct ice_pf __rcu *)pf, NULL) ==
+			(struct ice_pf __rcu *)pf)
+		synchronize_rcu();
+}
+
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
@@ -3397,7 +3413,9 @@ void ice_ptp_init(struct ice_pf *pf)
 err_clean_pf:
 	mutex_destroy(&ptp->port.ps_lock);
 	ice_ptp_cleanup_pf(pf);
+
 err_exit:
+	ice_ptp_cleanup_adapter(pf);
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
@@ -3425,6 +3443,7 @@ void ice_ptp_release(struct ice_pf *pf)
 	if (pf->ptp.state != ICE_PTP_READY) {
 		mutex_destroy(&pf->ptp.port.ps_lock);
 		ice_ptp_cleanup_pf(pf);
+		ice_ptp_cleanup_adapter(pf);
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;
@@ -3439,6 +3458,8 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_cleanup_pf(pf);
 
+	ice_ptp_cleanup_adapter(pf);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	ice_ptp_disable_all_extts(pf);
-- 
2.53.0

