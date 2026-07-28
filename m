Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6140F8FC
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272971; cv=none; b=YbEiVC+La/yy5h76sEd0Rc4CSCgtedXLVhtiAQgxf5YVoHqtHER4eYdVC0YZyd9CCzIIno+R7ZLVsmZTe5uTbz5JE7wKb9Zy1O/PNAptExgRTcoRtk4uqAXnRXiOQVPfl9/ijFdzvARZqUiwyN0nhb/2KaV/W2iJSqPvdJl2HHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272971; c=relaxed/simple;
	bh=R3MPMV5q2diWuS2I0kxKtrw/c3aAO2Mu4VCBZ82oSVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjfh8CG5Mu9mYsppuvXs5APqVyFb6ECpGSbsojZh835qzUX0D2WbsYdHHhv6agV05QGlXYkww5Luow1U/y5YGPZgCk6P0FiloNXaVraYPD2qtAh1uH+01fX6RHz6PSD+9TasJ0MqIcG2pDekfjvgVh86zB2nRfLlAfu9/c4c/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frpW4MPJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frpW4MPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272970; x=1816808970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3MPMV5q2diWuS2I0kxKtrw/c3aAO2Mu4VCBZ82oSVg=;
  b=frpW4MPJyhb9I0MQBAImVfcOPojDQf5AGowW9tHxjhnj9P+PNpXjvzwJ
   OlMNZZko/L9HGaf7ViSvlNNTYb3FtGg11QzFcMPpL/i2zcSAH/UKZfwy+
   EVkVYNHdAv5hWkv82IPpBSLXdHsdHVzWy7/+VWcwkKPFf8uI1PmFoAAWd
   sLGlRP3e2hMF5f82dLckSdohAuzuh6PMalLa2CWVnNDi6/HGy9e3mXePv
   qZAT2Y6PbwIbZlVjJk/+PStcXlrj61RxlqiIDDMsv2lRnLjTzYulNO/Ec
   hqb+yNgLTXP5orbR00pbMTrNj2MUEozm6iTdoK2ZxEuyiQHpyOcnVgvpJ
   w==;
X-CSE-ConnectionGUID: bpEkszJaQR+mfVxiGT0hBA==
X-CSE-MsgGUID: ticWJZAhQiG9avbkGrYU4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85885065"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85885065"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:19 -0700
X-CSE-ConnectionGUID: LuIOspqzR6OSvLROAJnUaw==
X-CSE-MsgGUID: 9d/su8LhR6OYmDXq9lzUZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558961"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	przemyslaw.kitszel@intel.com,
	arkadiusz.kubalewski@intel.com,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 07/10] ice: suppress DPLL errors during reset recovery
Date: Tue, 28 Jul 2026 14:09:04 -0700
Message-ID: <20260728210909.3042004-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
References: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

During reset recovery, the admin queue returns EBUSY which is expected
behavior. However, the DPLL subsystem was logging these as errors and
incrementing the error counter, potentially leading to unnecessary
warnings and even disabling the DPLL periodic worker if the threshold
was reached.

Suppress error logging and error counter increments when the admin
queue returns EBUSY, as this is expected during reset recovery and
not a real failure condition.

test case:
- ethtool --reset eth3 irq-shared dma-shared filter-shared offload-shared
mac-shared phy-shared ram-shared
- observe if dmesg EBUSY errors are gone

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 30c3a4db7d61..85a74cd6ea1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -793,7 +793,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 				   ret,
 				   libie_aq_str(pf->hw.adminq.sq_last_status),
 				   pin_type_name[pin_type], pin->idx);
-	else
+	else if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
 		dev_err_ratelimited(ice_pf_to_dev(pf),
 				    "err:%d %s failed to update %s pin:%u\n",
 				    ret,
@@ -3024,7 +3024,8 @@ static int ice_dpll_pps_update_phase_offsets(struct ice_pf *pf,
 	*phase_offset_pins_updated = 0;
 	ret = ice_aq_get_cgu_input_pin_measure(&pf->hw, DPLL_TYPE_PPS, meas,
 					       ARRAY_SIZE(meas));
-	if (ret && pf->hw.adminq.sq_last_status == LIBIE_AQ_RC_EAGAIN) {
+	if (ret && (pf->hw.adminq.sq_last_status == LIBIE_AQ_RC_EAGAIN ||
+		    pf->hw.adminq.sq_last_status == LIBIE_AQ_RC_EBUSY)) {
 		return 0;
 	} else if (ret) {
 		dev_err(ice_pf_to_dev(pf),
@@ -3086,10 +3087,12 @@ ice_dpll_update_state(struct ice_pf *pf, struct ice_dpll *d, bool init)
 		d->dpll_idx, d->prev_input_idx, d->input_idx,
 		d->dpll_state, d->prev_dpll_state, d->mode);
 	if (ret) {
-		dev_err(ice_pf_to_dev(pf),
-			"update dpll=%d state failed, ret=%d %s\n",
-			d->dpll_idx, ret,
-			libie_aq_str(pf->hw.adminq.sq_last_status));
+		/* EBUSY is expected during reset recovery, don't log error */
+		if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
+			dev_err(ice_pf_to_dev(pf),
+				"update dpll=%d state failed, ret=%d %s\n",
+				d->dpll_idx, ret,
+				libie_aq_str(pf->hw.adminq.sq_last_status));
 		return ret;
 	}
 	if (init) {
@@ -3158,7 +3161,9 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	    d->periodic_counter % dp->phase_offset_monitor_period == 0)
 		ret = ice_dpll_pps_update_phase_offsets(pf, &phase_offset_ntf);
 	if (ret) {
-		d->cgu_state_acq_err_num++;
+		/* EBUSY is expected during reset recovery */
+		if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
+			d->cgu_state_acq_err_num++;
 		/* stop rescheduling this worker */
 		if (d->cgu_state_acq_err_num >
 		    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {
-- 
2.47.1

