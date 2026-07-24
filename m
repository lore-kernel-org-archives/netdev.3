Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993441B355
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895243; cv=none; b=RIBL1cp0UcOm3TYeD9Yqwl6DH2arft7kanE239KoV+wiiPBu/if9qy0fMPfUNEbwg0j3jPm647Hkj8/qG2T6qwQJnok3uWbYQGMRELWErc1Kw6nWDSP6XqIqrkUo7QxYIXiDbuWlljifsSR98daD7MVvHCk+C225gqgtw6SY5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895243; c=relaxed/simple;
	bh=x81AropZ8wmafCaQqgumhWgAWlIX9ggQCy3dvBjj+pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh3TLLCJV/XPpJxJsPXIGTXL3jeXxuNe7fI92vCfhZ51Gp0Jwf3G32v+h65sfNJ/YH6IjKxgjtUt6vwxm8YmWsMvoMoYVHc9Skqsd6mXbyGe6e5XXxw1WZdXjHMq3nPv2VH1qBR1iR1O2FecsS5YMUOFA24BStPyEa0kwuBRGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTT4Ht8h; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTT4Ht8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784895239; x=1816431239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x81AropZ8wmafCaQqgumhWgAWlIX9ggQCy3dvBjj+pg=;
  b=QTT4Ht8hv+yClx0BAgbtKd2kdCy8dpiIhyl8jATRdcNQ+3MBYwqN0fon
   rk2Tw9zqb7dhL9AwNwn0w7U3BaUk3haQ01PfqJkkqHPrR6K1Cl9a+BZcD
   fbkRoR3SDxIulJukxmSEWzrOCS1ba+YCNTyEeHRa+LYaTvL359aVVsO2h
   pBTOY3DxEnIHjGVLSPhuLYgOXp3ZyLBcwbDEgPn0mTuWV3Gj0CipR96mN
   6v1P4vGzu8Qa61hk417HW8YslDOPH4bIoAhrtw369VtbH61FZN2LRGasD
   A4Rj41Vob+beqQ7lXweQ/xz5WXJgLGiYoCBUHQMuu0/gknNzM6PJuY3j8
   g==;
X-CSE-ConnectionGUID: /V5dXYZiTvm+0bMW1NbZqw==
X-CSE-MsgGUID: lXK0U0BFTaiK/hGtHq27ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84686078"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="84686078"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 05:13:57 -0700
X-CSE-ConnectionGUID: 3+QMDdrUSNu3vbOAkflRaA==
X-CSE-MsgGUID: IjKGqXiUQQCOR1kU6qAD3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="252367707"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2026 05:13:55 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 4/4] ice: dpll: Rework the SMA control logic to match the requirements
Date: Fri, 24 Jul 2026 12:13:50 +0000
Message-ID: <20260724121350.1565330-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
References: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 138 ++++++++++++++++++++--
 1 file changed, 127 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index cf54a7f2f836..e663f13a2f11 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -698,10 +698,10 @@ ice_dpll_sw_pins_update(struct ice_pf *pf)
 	p = &d->sma[ICE_DPLL_PIN_SW_2_IDX];
 	p->active = true;
 	p->direction = DPLL_PIN_DIRECTION_INPUT;
+	if (data & ICE_SMA2_DIR_EN)
+		p->direction = DPLL_PIN_DIRECTION_OUTPUT;
 	if ((data & ICE_SMA2_INACTIVE_MASK) == ICE_SMA2_INACTIVE_MASK)
 		p->active = false;
-	else if (data & ICE_SMA2_DIR_EN)
-		p->direction = DPLL_PIN_DIRECTION_OUTPUT;
 
 	p = &d->ufl[ICE_DPLL_PIN_SW_1_IDX];
 	if (!(data & (ICE_SMA1_DIR_EN | ICE_SMA1_TX_EN)))
@@ -1224,17 +1224,21 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 
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
 		} else {
-			data &= ~(ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS);
 			data |= ICE_SMA2_DIR_EN;
+			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
 		}
 		break;
 	default:
@@ -1263,12 +1267,16 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 		if (peer->output) {
 			target = peer->output;
 			type = ICE_DPLL_PIN_TYPE_OUTPUT;
-		} else {
+		} else if (peer->input) {
 			target = peer->input;
 			type = ICE_DPLL_PIN_TYPE_INPUT;
+		} else {
+			return -EINVAL;
 		}
+
 		ret = ice_dpll_pin_enable(&p->pf->hw, target,
-					  d->pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX && target->state[d->pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
+                                         d->pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX &&
+                                          target->state[d->pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
 					  d->pps.dpll_idx : d->eec.dpll_idx, type, extack);
 		if (!ret)
 			ret = ice_dpll_pin_state_update(p->pf, target,
@@ -1552,6 +1560,7 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll *d = dpll_priv;
 	struct ice_pf *pf = sma->pf;
 	enum ice_dpll_pin_type type;
+	u8 old_data = 0;
 	bool enable;
 	int ret;
 
@@ -1603,13 +1612,120 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
+			goto unlock;
+		ret = ice_dpll_sw_pins_update(pf);
+		if (ret)
+			goto restore_sma_ctrl;
+
 		ret = ice_dpll_pin_enable(&pf->hw, target, d->dpll_idx, type,
 					  extack);
-	else
+		if (ret)
+			goto restore_sma_ctrl;
+		/* refresh target state first so a peer-side error cannot leave it stale */
+		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (ret) {
+			ice_dpll_pin_disable(&pf->hw, target, type, extack);
+			goto restore_sma_ctrl;
+		}
+
+		if (sma->muxed && sma->muxed->active) {
+			struct ice_dpll_pin *peer = sma->muxed;
+			struct ice_dpll_pin *peer_target;
+			enum ice_dpll_pin_type peer_type;
+
+			switch (peer->direction) {
+			case DPLL_PIN_DIRECTION_OUTPUT:
+				peer_target = peer->output;
+				peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+				break;
+			case DPLL_PIN_DIRECTION_INPUT:
+				peer_target = peer->input;
+				peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+				break;
+			default:
+				ret = -EINVAL;
+				goto disable_pin;
+			}
+			if (!peer_target) {
+				ret = -EINVAL;
+				goto disable_pin;
+			}
+			ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+						  pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX &&
+						    peer_target->state[pf->dplls.pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
+						  pf->dplls.pps.dpll_idx : pf->dplls.eec.dpll_idx,
+						  peer_type, extack);
+			if (!ret)
+				ret = ice_dpll_pin_state_update(pf, peer_target,
+								peer_type, extack);
+			if (ret)
+				goto disable_pin;
+		}
+	} else {
 		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type,
+							extack);
+	}
+	goto unlock;
+
+disable_pin:
 	if (!ret)
-		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		ret = -EINVAL;
+	ice_dpll_pin_disable(&pf->hw, target, type, extack);
+	if (sma->muxed && sma->muxed->active) {
+		struct ice_dpll_pin *peer = sma->muxed;
+		struct ice_dpll_pin *peer_target = NULL;
+		enum ice_dpll_pin_type peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+
+		switch (peer->direction) {
+		case DPLL_PIN_DIRECTION_OUTPUT:
+			peer_target = peer->output;
+			peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+			break;
+		case DPLL_PIN_DIRECTION_INPUT:
+			peer_target = peer->input;
+			peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+			break;
+		default:
+			break;
+		}
+		if (peer_target)
+			ice_dpll_pin_disable(&pf->hw, peer_target, peer_type, extack);
+	}
+restore_sma_ctrl:
+	{
+		int restore_ret;
+
+		restore_ret = ice_write_sma_ctrl(&pf->hw, old_data);
+		if (!restore_ret)
+			restore_ret = ice_dpll_sw_pins_update(pf);
+		if (restore_ret)
+			dev_warn(ice_pf_to_dev(pf),
+				 "Failed to restore SMA control after pin state error %d, restore err %d\n",
+				 ret, restore_ret);
+	}
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
-- 
2.53.0

