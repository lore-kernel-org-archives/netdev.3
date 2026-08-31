Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A113911DD
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187814; cv=none; b=hLfEL4YhPUcpEUQpHaRVj+Sqqe5Z7Q6k2tZpqulYoyXH1dBnbynA0ONHChAsHUat95/0RhYa8SL2nZGdkQK7H9dWj6iklKl2bg7muSx07+s5dqrnzAQsvuni1eVGHu4WObw07mXy5JJilqVomvogPIDsfVnBH0i4/sn61T7wpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187814; c=relaxed/simple;
	bh=43Dndlf/CDKqyjeAZwN2WFq2Ipncl1WyxMlxacvQ3i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ticpAwwhnV8HK1DKh7AslnzkJrYtGVjqQRnY68NRo/eKcNaaMwsnwA0s/Jo8Vn6qjHadGWIm8jwQaUXUD85IszPCtn9cc0uNNQTEApuCUQxrvzCM7XRzF5Pznir/kQsHN4WKfnL5o8hfIGlx7x/xY/gYJlzWoFbRYw8tRYu6f6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZnKFqiT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZnKFqiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788187813; x=1819723813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=43Dndlf/CDKqyjeAZwN2WFq2Ipncl1WyxMlxacvQ3i0=;
  b=RZnKFqiT3XeRnO6GyGQTEhVTmvazdL+BVR6INY+kBcy7QTLR4Zh1VURD
   OKdHgI+uu1F9GBys9kXNjuneQU3FBLVYaggxcvg+dpKkXhbdLCE+/a0uT
   meo2iwQPG+VsUYExPRGO8xQ7+Env6njhU9QhaUNGVYh65YPUg0R81epyI
   G5gY44sLG8MARip306kLEtkUep9Y6DU2cJ0t5602JMOZZE8u0lXEqMv9E
   ZS5LKLrQm1HQadHI48zPbfpRBA54/qG4gCpGqp1Xy4Uzue2/+O/v14n25
   BP9F62eacl4FvEjEI3ZeNVx9eGxXPtWXUactR7s28M0rOh4jhXE3frk0j
   g==;
X-CSE-ConnectionGUID: N8kMlTthR42WsPn+gNrsig==
X-CSE-MsgGUID: u6+PD0uoRsGlunCc9HMGIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144533"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="76144533"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:50:12 -0700
X-CSE-ConnectionGUID: VfIfyqhIRlyeNO7Ii5/lKA==
X-CSE-MsgGUID: /YwqiRsURti3l9qmmUMb4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="273003707"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:11 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 4/6] ice: dpll: Check for bounds when updating the pin states
Date: Mon, 31 Aug 2026 14:50:03 +0000
Message-ID: <20260831145005.191040-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bounds checking code so that any potential out-of-bound
array access is avoided

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 46 +++++++++++++----------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 1c459a604acf..614e222327b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -758,6 +758,8 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			  struct netlink_ext_ack *extack)
 {
 	u8 parent, port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;
+	enum dpll_pin_state eec_state = DPLL_PIN_STATE_DISCONNECTED;
+	enum dpll_pin_state pps_state = DPLL_PIN_STATE_DISCONNECTED;
 	int ret;
 
 	switch (pin_type) {
@@ -769,26 +771,26 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			goto err;
 		if (ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN & pin->flags[0]) {
 			if (pin->pin) {
-				pin->state[pf->dplls.eec.dpll_idx] =
+				eec_state =
 					pin->pin == pf->dplls.eec.active_input ?
 					DPLL_PIN_STATE_CONNECTED :
 					DPLL_PIN_STATE_SELECTABLE;
-				pin->state[pf->dplls.pps.dpll_idx] =
+				pps_state =
 					pin->pin == pf->dplls.pps.active_input ?
 					DPLL_PIN_STATE_CONNECTED :
 					DPLL_PIN_STATE_SELECTABLE;
 			} else {
-				pin->state[pf->dplls.eec.dpll_idx] =
-					DPLL_PIN_STATE_SELECTABLE;
-				pin->state[pf->dplls.pps.dpll_idx] =
-					DPLL_PIN_STATE_SELECTABLE;
+				eec_state = DPLL_PIN_STATE_SELECTABLE;
+				pps_state = DPLL_PIN_STATE_SELECTABLE;
 			}
-		} else {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
 		}
+		/* Commit only after a successful read so lockless readers never
+		 * observe a transient disconnected state.
+		 */
+		if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+			pin->state[pf->dplls.eec.dpll_idx] = eec_state;
+		if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+			pin->state[pf->dplls.pps.dpll_idx] = pps_state;
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
 		ret = ice_aq_get_output_pin_cfg(&pf->hw, pin->idx,
@@ -799,20 +801,17 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 
 		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
 		if (ICE_AQC_GET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				parent == pf->dplls.eec.dpll_idx ?
+			eec_state = parent == pf->dplls.eec.dpll_idx ?
 				DPLL_PIN_STATE_CONNECTED :
 				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				parent == pf->dplls.pps.dpll_idx ?
+			pps_state = parent == pf->dplls.pps.dpll_idx ?
 				DPLL_PIN_STATE_CONNECTED :
 				DPLL_PIN_STATE_DISCONNECTED;
-		} else {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
 		}
+		if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+			pin->state[pf->dplls.eec.dpll_idx] = eec_state;
+		if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+			pin->state[pf->dplls.pps.dpll_idx] = pps_state;
 		break;
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
 		if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
@@ -5180,6 +5179,13 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 
 	de->dpll_idx = abilities.eec_dpll_idx;
 	dp->dpll_idx = abilities.pps_dpll_idx;
+	if (de->dpll_idx >= ICE_DPLL_RCLK_NUM_MAX ||
+	    dp->dpll_idx >= ICE_DPLL_RCLK_NUM_MAX) {
+		dev_err(ice_pf_to_dev(pf),
+			"invalid dpll_idx in cgu abilities: eec=%u, pps=%u\n",
+			de->dpll_idx, dp->dpll_idx);
+		return -EINVAL;
+	}
 	d->num_inputs = abilities.num_inputs;
 	d->num_outputs = abilities.num_outputs;
 	d->input_phase_adj_max = le32_to_cpu(abilities.max_in_phase_adj) &
-- 
2.53.0

