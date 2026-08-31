Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B014391E72
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187816; cv=none; b=blVea769+sSEUGssj5H62zv1gPVDRwfdHTG46tttuDIjs+cYART0JsOeRVblwBP/BtdafnUssZlAzBAX7Gch/afeG6uffJWB+40vQ9rODK270Wt/3rXY3oHZqVS0hn39iA6BEeAX0a1A3XxfMY07vbv0jOfUHoGW5uVupTATxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187816; c=relaxed/simple;
	bh=8DUCuJNJhpxI8Wrvufy7d/JkPDIfxbnnJ/Vn4nHIKMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVTgXbUiI6Yn3I7olzQxelOn2Sh8rQftHYsdMPLmHrTTH2TRnEbk4oUh0kUBulzmgnHM7rU+sarac2a8Y873OGy7TOYDS5DaxBROQfOljzJMFGFWThzk9pCmh8gwhup53eztUlw0gqiEKVM/VLvlhbl9T8q57DZnCGdVSmkgXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emUW3s8s; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emUW3s8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788187814; x=1819723814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8DUCuJNJhpxI8Wrvufy7d/JkPDIfxbnnJ/Vn4nHIKMk=;
  b=emUW3s8sur0nltQNsppXjwwjOOMcmAJkI1SGw7ipjOUVVhn3X1l+XFwQ
   K9INA1jDK9EMbBb6JkyXYJdBArK0fRhWiO2cHBV6Q0QlrlxD9wbPeMM0g
   CgnSy4bnbSjj3UcTGqEYXwS2Cl31e0Bdb0cm/StuSoLCR4TqZGxTyQIcK
   jxOVrpmZY2rwEwEnrVWrdOKgi+0SRT+vmNf9d25qoPGE8nXgsbIPTYd00
   xGU5iC8pSsSS5s5BrMBbwtjhRx/07OUW59gN9IdpH/QmyXDa272fDLkTf
   QlTp16trs+KIwJz4dodE43UyA7SReC7nhM0NyhDPDgItWtGfMftoczvjS
   g==;
X-CSE-ConnectionGUID: bcvQhTllQMmnAkYkQ7mcvA==
X-CSE-MsgGUID: dqT59egqT02rAiBGvu5gTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144538"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="76144538"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:50:14 -0700
X-CSE-ConnectionGUID: d26/0LOyRVGyuFQ4uwzLvA==
X-CSE-MsgGUID: IYo0LLS3QRK8Yi+INddWjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="273003712"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:13 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 6/6] ice: dpll: Rework the SMA control logic to match the requirements
Date: Mon, 31 Aug 2026 14:50:05 +0000
Message-ID: <20260831145005.191040-7-sergey.temerkhanov@intel.com>
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

Make the SMA control logic match the requirements:

Setting SMA1 as Rx automatically enables U.FL1 as Tx if U.FL1 is
disconnected.
Setting SMA1 as Tx automatically changes U.FL1 state to disconnected.

Setting SMA2 as Tx automatically enables U.FL2 as Rx if U.FL2 is
disconnected.
Setting SMA2 as Rx automatically changes U.FL2 state to disconnected.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 180 ++++++++++++++++++----
 1 file changed, 150 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 359cf42c21e5..759aee5628c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1343,30 +1343,39 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 				      enum dpll_pin_direction direction,
 				      struct netlink_ext_ack *extack)
 {
+	struct ice_dpll_pin_config peer_config;
 	struct ice_dplls *d = &p->pf->dplls;
+	int peer_dpll_idx, restore_err, ret;
+	struct ice_dpll_pin *target = NULL;
+	enum ice_dpll_pin_type type = 0;
 	struct ice_dpll_pin *peer;
-	u8 data;
-	int ret;
+	u8 data, old_data = 0;
 
 	if (p->direction == direction && p->active)
 		return 0;
 	ret = ice_read_sma_ctrl(&p->pf->hw, &data);
 	if (ret)
 		return ret;
+	old_data = data;
 
 	switch (p->idx) {
 	case ICE_DPLL_PIN_SW_1_IDX:
-		data &= ~ICE_SMA1_MASK;
-		if (direction == DPLL_PIN_DIRECTION_OUTPUT)
+		if (direction == DPLL_PIN_DIRECTION_OUTPUT) {
+			data &= ~ICE_SMA1_TX_EN;
 			data |= ICE_SMA1_DIR_EN;
+		} else {
+			data &= ~ICE_SMA1_DIR_EN;
+			data &= ~ICE_SMA1_TX_EN;
+		}
 		break;
 	case ICE_DPLL_PIN_SW_2_IDX:
 		if (direction == DPLL_PIN_DIRECTION_INPUT) {
 			data &= ~ICE_SMA2_DIR_EN;
-			data |= ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
 		} else {
-			data &= ~(ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS);
 			data |= ICE_SMA2_DIR_EN;
+			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
 		}
 		break;
 	default:
@@ -1378,7 +1387,7 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 						ICE_DPLL_PIN_TYPE_SOFTWARE,
 						extack);
 	if (ret)
-		return ret;
+		goto restore_sma;
 
 	/* When a direction change activates the paired U.FL pin, enable
 	 * its backing CGU pin so the pin reports as connected. Without
@@ -1389,27 +1398,44 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 	 */
 	peer = p->muxed;
 	if (peer->active) {
-		struct ice_dpll_pin *target;
-		enum ice_dpll_pin_type type;
-		int peer_ret;
-
 		if (peer->output) {
 			target = peer->output;
 			type = ICE_DPLL_PIN_TYPE_OUTPUT;
-		} else {
+		} else if (peer->input) {
 			target = peer->input;
 			type = ICE_DPLL_PIN_TYPE_INPUT;
+		} else {
+			ret = -EINVAL;
+			goto restore_sma;
 		}
-		peer_ret = ice_dpll_get_fallback_idx(d, target);
-		if (peer_ret < 0)
-			peer_ret = d->eec.dpll_idx;
-		ret = ice_dpll_pin_enable(&p->pf->hw, target, peer_ret, type,
-					  extack);
-		if (!ret)
-			ret = ice_dpll_pin_state_update(p->pf, target,
-							type, extack);
+
+		ret = ice_dpll_pin_config_get(p->pf, target, type,
+					      &peer_config, extack);
+		if (ret)
+			goto restore_sma;
+
+		peer_dpll_idx = ice_dpll_get_fallback_idx(d, target);
+		if (peer_dpll_idx < 0)
+			peer_dpll_idx = d->eec.dpll_idx;
+		ret = ice_dpll_pin_enable(&p->pf->hw, target, peer_dpll_idx,
+					  type, extack);
+		if (ret)
+			goto restore_peer;
+		ret = ice_dpll_pin_state_update(p->pf, target, type, extack);
+		if (ret)
+			goto restore_peer;
 	}
 
+	return 0;
+
+restore_peer:
+	restore_err =
+		ice_dpll_pin_config_restore(p->pf, target, type, &peer_config,
+					    extack, ret);
+	if (restore_err)
+		ret = restore_err;
+restore_sma:
+	ice_dpll_restore_sma_ctrl(p->pf, old_data, ret);
 	return ret;
 }
 
@@ -1435,18 +1461,18 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			   enum dpll_pin_state state,
 			   struct netlink_ext_ack *extack)
 {
+	enum ice_dpll_pin_type peer_type = 0, type;
 	struct ice_dpll_pin *p = pin_priv, *target;
 	struct ice_dpll_pin *peer_target = NULL;
+	struct ice_dpll_pin_config peer_config;
+	struct ice_dpll_pin_config old_config;
+	int peer_dpll_idx, restore_err, ret;
 	struct ice_dpll *d = dpll_priv;
-	enum ice_dpll_pin_type peer_type = 0, type;
 	struct ice_pf *pf = p->pf;
-	struct ice_dpll_pin_config old_config;
-	struct ice_dpll_pin_config peer_config;
 	struct ice_hw *hw;
 	u8 old_data = 0;
 	bool enable;
 	u8 data;
-	int peer_dpll_idx, restore_err, ret;
 
 	if (ice_dpll_is_reset(pf, extack))
 		return -EBUSY;
@@ -1666,12 +1692,16 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			   enum dpll_pin_state state,
 			   struct netlink_ext_ack *extack)
 {
+	int peer_dpll_idx, restore_err, ret = -EINVAL;
 	struct ice_dpll_pin *sma = pin_priv, *target;
+	enum ice_dpll_pin_type peer_type = 0, type;
+	struct ice_dpll_pin *peer_target = NULL;
+	struct ice_dpll_pin_config peer_config;
+	struct ice_dpll_pin_config old_config;
 	struct ice_dpll *d = dpll_priv;
 	struct ice_pf *pf = sma->pf;
-	enum ice_dpll_pin_type type;
+	u8 old_data = 0;
 	bool enable;
-	int ret;
 
 	if (ice_dpll_is_reset(pf, extack))
 		return -EBUSY;
@@ -1679,6 +1709,10 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	mutex_lock(&pf->dplls.lock);
 	switch (state) {
 	case DPLL_PIN_STATE_SELECTABLE:
+		/* Reject direction-mismatched requests: SELECTABLE + OUTPUT
+		 * is an invalid combination, return -EINVAL in this case
+		 * immediately instead of disabling the pin.
+		 */
 		if (sma->direction == DPLL_PIN_DIRECTION_OUTPUT) {
 			enable = false;
 			ret = -EINVAL;
@@ -1687,6 +1721,10 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 		enable = true;
 		break;
 	case DPLL_PIN_STATE_CONNECTED:
+		/* Reject direction-mismatched requests: CONNECTED + INPUT
+		 * is an invalid combination, return -EINVAL in this case
+		 * immediately instead of disabling the pin.
+		 */
 		if (sma->direction == DPLL_PIN_DIRECTION_INPUT) {
 			enable = false;
 			ret = -EINVAL;
@@ -1722,13 +1760,95 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			goto unlock;
 	}
 
-	if (enable)
+	if (enable) {
+		u8 data;
+
+		ret = ice_read_sma_ctrl(&pf->hw, &data);
+		if (ret)
+			goto unlock;
+		old_data = data;
+		switch (sma->idx) {
+		case ICE_DPLL_PIN_SW_1_IDX:
+			data &= ~ICE_SMA1_TX_EN;
+			break;
+		case ICE_DPLL_PIN_SW_2_IDX:
+			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
+			break;
+		default:
+			ret = -EINVAL;
+			goto unlock;
+		}
+		ret = ice_write_sma_ctrl(&pf->hw, data);
+		if (ret)
+			goto restore_sma_ctrl;
+		ret = ice_dpll_sw_pins_update(pf);
+		if (ret)
+			goto restore_sma_ctrl;
+
+		ret = ice_dpll_pin_config_get(pf, target, type, &old_config,
+					      extack);
+		if (ret)
+			goto restore_sma_ctrl;
 		ret = ice_dpll_pin_enable(&pf->hw, target, d->dpll_idx, type,
 					  extack);
-	else
-		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
-	if (!ret)
+		if (ret)
+			goto restore_target;
+		/* Refresh target state before peer-side operations. */
 		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (ret)
+			goto restore_target;
+
+		if (sma->muxed && sma->muxed->active) {
+			ice_dpll_get_peer_target(sma->muxed, &peer_target,
+						 &peer_type);
+			if (!peer_target) {
+				ret = -EINVAL;
+				goto restore_target;
+			}
+
+			ret = ice_dpll_pin_config_get(pf, peer_target, peer_type,
+						      &peer_config, extack);
+			if (ret)
+				goto restore_target;
+
+			peer_dpll_idx =
+				ice_dpll_get_fallback_idx(&pf->dplls, peer_target);
+			if (peer_dpll_idx < 0)
+				peer_dpll_idx = d->dpll_idx;
+			ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+						  peer_dpll_idx, peer_type, extack);
+			if (ret)
+				goto restore_peer;
+			ret = ice_dpll_pin_state_update(pf, peer_target, peer_type,
+							extack);
+			if (ret)
+				goto restore_peer;
+		}
+	} else {
+		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type,
+							extack);
+	}
+	goto unlock;
+
+restore_peer:
+	restore_err =
+		ice_dpll_pin_config_restore(pf, peer_target, peer_type,
+					    &peer_config, extack, ret);
+	if (restore_err)
+		ret = restore_err;
+restore_target:
+	restore_err =
+		ice_dpll_pin_config_restore(pf, target, type, &old_config,
+					    extack, ret);
+	if (restore_err)
+		ret = restore_err;
+restore_sma_ctrl:
+	restore_err = ice_dpll_restore_sma_ctrl(pf, old_data, ret);
+	if (restore_err)
+		ret = restore_err;
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
-- 
2.53.0

