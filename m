Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E173BB684
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737741; cv=none; b=cJg6nZ3tim76/DyrvKV/OhEOjV/kMdjKs59MUfPGoiZbaEWcG19IPaSt+8L4PL4o+ZifoEkZVW3cLhbRu3tjK3TXJufSWTTJTPDCkBhVk6C4+fb5kojrcuyu695z0eFukpMlCJOXdenSMNIy/yN2g7Y6oRwAPK0RW4XMarpEmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737741; c=relaxed/simple;
	bh=BWEJljClCLoMqdC5CrvRogdJO+tr/guzV0d1rSKboEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiwOsiD68byFt8hRRl3slEnANLNS/uuvnkdbvQmLnJ/P82DTQk4YieUkftZVWklZCFFri1wp69Q85/j5fyFxfotQb9ZiNUh9NvHFt/q++TcbrH7QuEbCVFpfQPEubuwcI41dFymAdFiFDlW9aWmeUnFdDwWrVPnsQkIfbiYotc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4rX8LZE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4rX8LZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787737739; x=1819273739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWEJljClCLoMqdC5CrvRogdJO+tr/guzV0d1rSKboEs=;
  b=a4rX8LZER8Rb5hvT++BxFIGkr6Pb9guVcIeFh7YQXbRXY2oWTNZhxHcq
   XA5ixOfXuHAFwZJDzEzgrgKl5RC7bAtC1/d0jB4EzQ62f99+VLhu/trXr
   310IeTLT2WZ7+jUCa+DCRAdJMBHuJ4U6so3Qy5Sw/oHGlmwxPJfmCeIZL
   dXxGxm+ggblEUKZS5wf/dw99iZg/9aItMnXWRQsYxIPZLOu8Vo97hivWG
   XUjyKSsEzQjjRcd3aEOFk8dLwkSEiVQot73w5uG8nc3ss7XzAecnf0T2P
   PaG9jhWDJFRdnqcAALfG68Y4JexAuJXSFYbxEL8DQUjAsAEl/HHms4pSD
   g==;
X-CSE-ConnectionGUID: KtgUUxKgQ76By7RcSwUd5w==
X-CSE-MsgGUID: /yVeQvKFRqmrvjhZ4MOu5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232955"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88232955"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 02:48:54 -0700
X-CSE-ConnectionGUID: eDefGgG5TsaXs5a4PNkJAQ==
X-CSE-MsgGUID: xAOMNQgNS7CBD3aLR9FiVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="261404806"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:53 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 3/6] ice: dpll: Use switch statements to handle pin states
Date: Wed, 26 Aug 2026 09:48:46 +0000
Message-ID: <20260826094849.4112016-4-sergey.temerkhanov@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 72 ++++++++++++++++++-----
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 4dcbbabee7aa..f4d6c247e96e 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1338,10 +1338,12 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1352,18 +1354,21 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1375,7 +1380,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			}
 			data |= ICE_SMA2_UFL2_RX_DIS;
 			enable = false;
-		} else {
+			break;
+		default:
 			goto unlock;
 		}
 		target = p->input;
@@ -1497,19 +1503,49 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 		return -EBUSY;
 
 	mutex_lock(&pf->dplls.lock);
-	if (!sma->active) {
-		ret = ice_dpll_sma_direction_set(sma, sma->direction, extack);
-		if (ret)
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
 			goto unlock;
+		}
+		enable = true;
+		break;
+	case DPLL_PIN_STATE_DISCONNECTED:
+		enable = false;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
 	}
-	if (sma->direction == DPLL_PIN_DIRECTION_INPUT) {
-		enable = state == DPLL_PIN_STATE_SELECTABLE;
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
+	}
+
+	if (!sma->active) {
+		ret = ice_dpll_sma_direction_set(sma, sma->direction, extack);
+		if (ret)
+			goto unlock;
 	}
 
 	if (enable)
@@ -4917,7 +4953,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		pin->prop.capabilities = caps;
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_ufl[i];
-		if (i == ICE_DPLL_PIN_SW_1_IDX) {
+		switch (i) {
+		case ICE_DPLL_PIN_SW_1_IDX:
 			pin->direction = DPLL_PIN_DIRECTION_OUTPUT;
 			pin_abs_idx = ICE_DPLL_PIN_SW_OUTPUT_ABS(i);
 			pin->prop.freq_supported =
@@ -4927,7 +4964,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 			pin->prop.freq_supported_num = freq_supp_num;
 			pin->input = NULL;
 			pin->output = &d->outputs[pin_abs_idx];
-		} else if (i == ICE_DPLL_PIN_SW_2_IDX) {
+			break;
+		case ICE_DPLL_PIN_SW_2_IDX:
 			pin->direction = DPLL_PIN_DIRECTION_INPUT;
 			pin_abs_idx = ICE_DPLL_PIN_SW_INPUT_ABS(i) +
 				      input_idx_offset;
@@ -4940,6 +4978,10 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
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

