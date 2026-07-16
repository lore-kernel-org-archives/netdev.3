Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D23F484E
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195362; cv=none; b=KlH0vC0JfjHDnocGIYZpQ3kAy/NQBvew91bn0W2QeUBlItt57SPsiapfMqkZXqhBQgoOP+/dPwfUXVW/ScxM85iJg+qG9jfK9gony55Lq4OCGioPfB4iq6hmXEqYB0xR6VyE0yxloc0quKXpdmnDFlGic/gFKawZF3db+EzB2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195362; c=relaxed/simple;
	bh=x0Y0oi6/jFtaDBYf9V64hgE8ooBJwU7IE0C8/sMtcWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoDLKrRAJb4OtYcsdNHH898gNdkksyvs2QcPeDSobmIpZQEWT9wcfrq6+ZYAfNi5PhonkW4KOrgtlDrl854zQXcHlQf0FMEXlcgQVNTGj2bG2n43DFSMY6LWMKL+KPd3FbxDBe9m3QNW8vR2T6B8h/Pr9D2hBsjiD2DwkVnUsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9TgEmPb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9TgEmPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784195359; x=1815731359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0Y0oi6/jFtaDBYf9V64hgE8ooBJwU7IE0C8/sMtcWQ=;
  b=c9TgEmPbaCUgMkIngV/2JRlwPvr8F75FDgOgzcRZMCbNjdeiZMkLrABT
   SCB0KURV/1z37XpwTj7zCMq2YeuArFlC2cUGKrMgNR8tqGO6RrpJuz62R
   W8djPip1N3NBhAwX/DkOO/z117wCKd2LL8pYILzVNWnKDCbTBW+JUZNlj
   W5KZQ7+cI0lG6USk0x+zhBsVnZt7+GoSHKeVSr7e/at1C2OG162IH80kb
   tF5t03T1uhqm3iz7ksI1QeMbnwv6RLJv3IJEEfVtL0XytI2OdYCQmOfPh
   idOpm4HjfirRwPHTXnskLJESloHdXgTO3Id4WuYVYKdmRijJIDDuX2kWt
   g==;
X-CSE-ConnectionGUID: MRzPzBdaQTqNKYEgM77IwQ==
X-CSE-MsgGUID: mzeWeuD9TaKgG5wO6DcsrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963878"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84963878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:49:16 -0700
X-CSE-ConnectionGUID: bZ3Iz6MdQv6DLFWTy+WwTQ==
X-CSE-MsgGUID: 5CwZwszcQymarUbPFJwuIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="256501626"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:15 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next  v1 2/4] ice: dpll: Use switch statements to handle pin states
Date: Thu, 16 Jul 2026 09:49:09 +0000
Message-ID: <20260716094912.1210865-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
References: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use switch statements to handle pin states to make the code more
readable. This also makes this code more future-proof, should any
new states appear.

This also changes how direction-mismatched state requests are handled in
ice_dpll_sma_pin_state_set(). Previously, requesting CONNECTED on an
INPUT-direction SMA pin or SELECTABLE on an OUTPUT-direction pin would
fall through to ice_dpll_pin_disable() and return success. After this
change those requests return -EINVAL without issuing a firmware command.
Because the DPLL netlink core does not filter pin states by direction
before calling the driver, this is a user-visible netlink API change.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 65 ++++++++++++++++++-----
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index fed7c9fea953..54958e17713b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1320,10 +1320,12 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = -EINVAL;
 	switch (p->idx) {
 	case ICE_DPLL_PIN_SW_1_IDX:
-		if (state == DPLL_PIN_STATE_CONNECTED) {
+		switch (state) {
+		case DPLL_PIN_STATE_CONNECTED:
 			data &= ~ICE_SMA1_MASK;
 			enable = true;
-		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			break;
+		case DPLL_PIN_STATE_DISCONNECTED:
 			/* Skip if U.FL1 is not active, setting TX_EN
 			 * while DIR_EN is set would also deactivate
 			 * the paired SMA1 output.
@@ -1334,18 +1336,21 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			}
 			data |= ICE_SMA1_TX_EN;
 			enable = false;
-		} else {
+			break;
+		default:
 			goto unlock;
 		}
 		target = p->output;
 		type = ICE_DPLL_PIN_TYPE_OUTPUT;
 		break;
 	case ICE_DPLL_PIN_SW_2_IDX:
-		if (state == DPLL_PIN_STATE_SELECTABLE) {
+		switch (state) {
+		case DPLL_PIN_STATE_SELECTABLE:
 			data |= ICE_SMA2_DIR_EN;
 			data &= ~ICE_SMA2_UFL2_RX_DIS;
 			enable = true;
-		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			break;
+		case DPLL_PIN_STATE_DISCONNECTED:
 			/* Skip if U.FL2 is not active, setting
 			 * UFL2_RX_DIS could also disable the paired
 			 * SMA2 input.
@@ -1357,7 +1362,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			}
 			data |= ICE_SMA2_UFL2_RX_DIS;
 			enable = false;
-		} else {
+			break;
+		default:
 			goto unlock;
 		}
 		target = p->input;
@@ -1484,14 +1490,43 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 		if (ret)
 			goto unlock;
 	}
-	if (sma->direction == DPLL_PIN_DIRECTION_INPUT) {
-		enable = state == DPLL_PIN_STATE_SELECTABLE;
+	switch (state) {
+	case DPLL_PIN_STATE_SELECTABLE:
+		if (sma->direction == DPLL_PIN_DIRECTION_OUTPUT) {
+			enable = false;
+			ret = -EINVAL;
+			goto unlock;
+		}
+		enable = true;
+		break;
+	case DPLL_PIN_STATE_CONNECTED:
+		if (sma->direction == DPLL_PIN_DIRECTION_INPUT) {
+			enable = false;
+			ret = -EINVAL;
+			goto unlock;
+		}
+		enable = true;
+		break;
+	case DPLL_PIN_STATE_DISCONNECTED:
+		enable = false;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	switch (sma->direction) {
+	case DPLL_PIN_DIRECTION_INPUT:
 		target = sma->input;
 		type = ICE_DPLL_PIN_TYPE_INPUT;
-	} else {
-		enable = state == DPLL_PIN_STATE_CONNECTED;
+		break;
+	case DPLL_PIN_DIRECTION_OUTPUT:
 		target = sma->output;
 		type = ICE_DPLL_PIN_TYPE_OUTPUT;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
 	}
 
 	if (enable)
@@ -4631,7 +4666,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		pin->prop.capabilities = caps;
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_ufl[i];
-		if (i == ICE_DPLL_PIN_SW_1_IDX) {
+		switch (i) {
+		case ICE_DPLL_PIN_SW_1_IDX:
 			pin->direction = DPLL_PIN_DIRECTION_OUTPUT;
 			pin_abs_idx = ICE_DPLL_PIN_SW_OUTPUT_ABS(i);
 			pin->prop.freq_supported =
@@ -4641,7 +4677,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 			pin->prop.freq_supported_num = freq_supp_num;
 			pin->input = NULL;
 			pin->output = &d->outputs[pin_abs_idx];
-		} else if (i == ICE_DPLL_PIN_SW_2_IDX) {
+			break;
+		case ICE_DPLL_PIN_SW_2_IDX:
 			pin->direction = DPLL_PIN_DIRECTION_INPUT;
 			pin_abs_idx = ICE_DPLL_PIN_SW_INPUT_ABS(i) +
 				      input_idx_offset;
@@ -4654,6 +4691,10 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 			pin->prop.capabilities =
 				(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 				 caps);
+			break;
+		default:
+			dev_err(ice_pf_to_dev(pf), "Invalid U.FL pin index: %d\n", i);
+			return -EINVAL;
 		}
 		pin->muxed = &d->sma[i];
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
-- 
2.53.0

