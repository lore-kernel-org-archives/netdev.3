Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7E3BB102
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737741; cv=none; b=fUbZUT9B/QhKCTJsfHTWROEw+0UJawqBLYCKd/Oxns6ENeat17MOJC/j3D/QFcXKi6Xz7yPHHUQfOBAY/92Z8ov9hjXTrykZHYYA4dZ7Z5LSwLhh6bKZlLfvqkbzN9jIZe2suysgMlh0YZfobAVTgyeES4gPbzn2WENw5XpQRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737741; c=relaxed/simple;
	bh=+h3AlGKrgxCjxVVRZxD+Up7aWMC3JsD2ay1MaLwTx1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyWRG/8kxTUu6GC0GcL5B7syH6GDAJg2gyukqf2vvwKGHQkVB8O6VYdG2NK/IChtIosQJ9d2QGRFUNcjDbvxNTJHx+o4kGdprSN5lBOWNusXneNs/Qoh0cMI569dfOMcqiX2TruhlMntOZR9pC+8oFsxfTR2oJoe5sFOseY+f8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuzRich3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuzRich3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787737739; x=1819273739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+h3AlGKrgxCjxVVRZxD+Up7aWMC3JsD2ay1MaLwTx1c=;
  b=VuzRich34slMimiLw/k8XKOpeTIG6y9zYfUOAWkJkH6Y5JyPjDxWcwlu
   ufT/NyWRldaWhukLoeydRGFMlRvVw59BE4eiW4PXOVNFYCh1o7vgCsgAC
   F6e09t3/u3x3dwJcA4GOpk6RnIoD5iy6YqgsE6Lla+hdy5B2ew8rJCxD0
   blbe6OpDn2yHT+rRrl73UyDp/2pe1ExyNnMY7HX2vmOjhv/25BBvg5Kq0
   yuttozzvBTJM6Nz3AQVQ2k5lxeB4gQxbBOIfJ2wTJoyIkfEByz8b/7Exe
   BiQISXYg0iGoJLbxIxoA8S0T4XiB6vD9u6gJLiOIr5TdccfpjvNpHjx+M
   g==;
X-CSE-ConnectionGUID: D91igFOsSKiGIgvxchwthg==
X-CSE-MsgGUID: SR4yVB6HSg+IJf2e2jfYRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232957"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88232957"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 02:48:55 -0700
X-CSE-ConnectionGUID: wsnH4h7PT+yL4L0hqjElcQ==
X-CSE-MsgGUID: fBB5Kng5RLGRiYst/g/d4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="261404817"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:54 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 4/6] ice: dpll: Check for bounds when updating the pin states
Date: Wed, 26 Aug 2026 09:48:47 +0000
Message-ID: <20260826094849.4112016-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
References: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
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
index f4d6c247e96e..e80460aeac11 100644
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

