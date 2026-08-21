Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5174D2ED4
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325901; cv=none; b=M3At71uwCSWREnVGcRJfdBwYnxYo4hWEZdPkwtSgkc18OziRme8Iq6xyhcU9m/jW7udSWPtSQ44aqatAALS9Z4O4r8wUMu1KWb1W3iL50cjVQKV3J71VLpMlJiFFi78mimmYw+lt8wWSRSvsfqPqy9dHVfiBMP8VX3v2qVLbt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325901; c=relaxed/simple;
	bh=5hxnhXlA5Xb/ihW/XSDFjdHywkbHy7X5nAnOsvgQnDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FK1f43W0H8RG1DsqwaQC3aPWO0EXixpQ0yjaX+U3PTkI/xUiNQNGhdsvCinSPnKB2cIFYxGWbvpBwV57Noe24XyWYClXlg/I+A1sbokoq8B75/+gRv3tWC5+3RQi/Edarq4g9zXwOrP7u1jyJgrZjYGbhxZUiwE5S3AXyHRVGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHdHBUlf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHdHBUlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787325900; x=1818861900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hxnhXlA5Xb/ihW/XSDFjdHywkbHy7X5nAnOsvgQnDk=;
  b=JHdHBUlfCMcpDV2oUrJXPssJ3D0NZ6sZldL0ejblKjdNudpbglbhZN7z
   qoQteD7Cj+eju8bkH4ITkHFOIiyZ03cvd7pTNzPqQsKy4Grpgo1Ti+ZuL
   RMnHFrLwcooQU9UPug6jym0OweC13WNCY3k+ukL+3r6t+wES+1Hju2p9x
   6HBdjAvbKg7Y9MZgpCkqCp/Rv2NqrY/zZoYAw0m/Zvg648VjrOWXF0bJn
   Qpj078MzHEfSUx8/8zLSKvHt3yiQxj1ZfKqDzdW42cLKs3o7XGquKKYxR
   8xGR5SzFjf/G+nK2vjtcfNszL3bflLbfD4MKIfB5mwcLBDCstTqYI79e7
   w==;
X-CSE-ConnectionGUID: sHatuIsdQraJMS+x2qIY8Q==
X-CSE-MsgGUID: TqDZa7HOSCSlJ2knVwj4cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91553205"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="91553205"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 08:24:59 -0700
X-CSE-ConnectionGUID: jki8o265TRmCNeX4bVD4wQ==
X-CSE-MsgGUID: PcxvA5+LTGC09KsTzn/n1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="270602193"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa005.jf.intel.com with ESMTP; 21 Aug 2026 08:24:58 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v3 4/6] ice: dpll: Check for bounds when updating the pin states
Date: Fri, 21 Aug 2026 15:24:52 +0000
Message-ID: <20260821152454.3703979-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
References: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 76 ++++++++++++++---------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index f4d6c247e96e..d0225097cd10 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -760,6 +760,9 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 	u8 parent, port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;
 	int ret;
 
+	for (int i = 0; i < ICE_DPLL_RCLK_NUM_MAX; i++)
+		pin->state[i] = DPLL_PIN_STATE_DISCONNECTED;
+
 	switch (pin_type) {
 	case ICE_DPLL_PIN_TYPE_INPUT:
 		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, &pin->status,
@@ -769,25 +772,31 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			goto err;
 		if (ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN & pin->flags[0]) {
 			if (pin->pin) {
-				pin->state[pf->dplls.eec.dpll_idx] =
-					pin->pin == pf->dplls.eec.active_input ?
-					DPLL_PIN_STATE_CONNECTED :
-					DPLL_PIN_STATE_SELECTABLE;
-				pin->state[pf->dplls.pps.dpll_idx] =
-					pin->pin == pf->dplls.pps.active_input ?
-					DPLL_PIN_STATE_CONNECTED :
-					DPLL_PIN_STATE_SELECTABLE;
+				if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+					pin->state[pf->dplls.eec.dpll_idx] =
+						pin->pin == pf->dplls.eec.active_input ?
+						DPLL_PIN_STATE_CONNECTED :
+						DPLL_PIN_STATE_SELECTABLE;
+				if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+					pin->state[pf->dplls.pps.dpll_idx] =
+						pin->pin == pf->dplls.pps.active_input ?
+						DPLL_PIN_STATE_CONNECTED :
+						DPLL_PIN_STATE_SELECTABLE;
 			} else {
-				pin->state[pf->dplls.eec.dpll_idx] =
-					DPLL_PIN_STATE_SELECTABLE;
-				pin->state[pf->dplls.pps.dpll_idx] =
-					DPLL_PIN_STATE_SELECTABLE;
+				if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+					pin->state[pf->dplls.eec.dpll_idx] =
+						DPLL_PIN_STATE_SELECTABLE;
+				if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+					pin->state[pf->dplls.pps.dpll_idx] =
+						DPLL_PIN_STATE_SELECTABLE;
 			}
 		} else {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.eec.dpll_idx] =
+					DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.pps.dpll_idx] =
+					DPLL_PIN_STATE_DISCONNECTED;
 		}
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
@@ -799,19 +808,23 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 
 		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
 		if (ICE_AQC_GET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				parent == pf->dplls.eec.dpll_idx ?
-				DPLL_PIN_STATE_CONNECTED :
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				parent == pf->dplls.pps.dpll_idx ?
-				DPLL_PIN_STATE_CONNECTED :
-				DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.eec.dpll_idx] =
+					parent == pf->dplls.eec.dpll_idx ?
+					DPLL_PIN_STATE_CONNECTED :
+					DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.pps.dpll_idx] =
+					parent == pf->dplls.pps.dpll_idx ?
+					DPLL_PIN_STATE_CONNECTED :
+					DPLL_PIN_STATE_DISCONNECTED;
 		} else {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.eec.dpll_idx] =
+					DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.pps.dpll_idx] =
+					DPLL_PIN_STATE_DISCONNECTED;
 		}
 		break;
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
@@ -5180,6 +5193,13 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 
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

