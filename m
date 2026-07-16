Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1643F86E7
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195364; cv=none; b=sq0G03GYACDz4xl2k9GkgSt/NVsZOmNC0XqpCHDvqU7FyODLTGqedBZnAxkdGbsfeKeykhz7qxgEFoqigUlDmYjZWEB8DPW3EbbeOJGw2fXk5PostCiuRr9UeXjnIOhtB3Tm4FQn7yB+13GkdvF4wOWuvfU8vrThKFYLf5jumvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195364; c=relaxed/simple;
	bh=TPTzoaH7iXUJJlNOdjQQNXyuCi3pEzwVvdsdYUEj+sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeSq92dV+t5aIAZa0blxGxASKGATaPmI8bfZaibyHtuC8/E58MReIPjwISInE0teB9ju7q7cWc8ydFoejEnnTm/zonnlTyaG4LVgjfVVPIPaZMOa7pem7e0Kenht596P60W1OlyPq3YVmBZE3cLB4zBWPBy5KWR/rGVsfzMUfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAtBhuU/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAtBhuU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784195362; x=1815731362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TPTzoaH7iXUJJlNOdjQQNXyuCi3pEzwVvdsdYUEj+sA=;
  b=GAtBhuU/vydohk3Fy03R8CT2dEPK5on6AGcyF6Vdbs3L+TxoFtvXYm82
   GKe1Xf9B0ZxCqB6eBYKfxQkjDcSv+4NXNyvy/cR7XdeXwsEcrJbtdroGA
   nvAv/ZAwMQ+qRdpixVJ0gU/j4WGToyvLkd3Xd62Y7+yri84Stg4FLAtOs
   yv7EC1C4obwR9etQOSV/6gXuN9H3um0iBe6DC5cGs/1wYpohnNvbKabP3
   F6aKqvazvJBax2gS4FGddP1sIqpK8CnZgm/N0b7zCKQxlgmoQJCmQxTHv
   Dp60DAQkSyIdua1y+JfBpMRpwJIDpaErxHvsVOlLvWMFJs2KlEk7MWuie
   g==;
X-CSE-ConnectionGUID: wuOWi3XfTQaggcBCUzFWdQ==
X-CSE-MsgGUID: QREmIUE6SyeYP7BYzRynUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963884"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84963884"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:49:18 -0700
X-CSE-ConnectionGUID: Vkf9EZj5Txqkop5pOCdNKA==
X-CSE-MsgGUID: QDJVphzUTXC2x7IjK6LnKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="256501631"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:17 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next  v1 4/4] ice: dpll: Rework the SMA control logic to match the requirements
Date: Thu, 16 Jul 2026 09:49:11 +0000
Message-ID: <20260716094912.1210865-5-sergey.temerkhanov@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 88 ++++++++++++++++++++---
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index cb14621b3aef..f11d90ed80f2 100644
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
@@ -1505,6 +1509,7 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll *d = dpll_priv;
 	struct ice_pf *pf = sma->pf;
 	enum ice_dpll_pin_type type;
+	u8 old_data = 0;
 	bool enable;
 	int ret;
 
@@ -1556,13 +1561,76 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
+		if (sma->idx == ICE_DPLL_PIN_SW_1_IDX) {
+			data &= ~ICE_SMA1_TX_EN;
+		} else if (sma->idx == ICE_DPLL_PIN_SW_2_IDX) {
+			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
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
-		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
-	if (!ret)
+		if (ret)
+			goto restore_sma_ctrl;
+		/* refresh target state first so a peer-side error cannot leave it stale */
 		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (ret)
+			goto restore_sma_ctrl;
+
+		if (sma->muxed->active) {
+			struct ice_dpll_pin *peer = sma->muxed;
+			struct ice_dpll_pin *peer_target;
+			enum ice_dpll_pin_type peer_type;
+
+			if (peer->direction == DPLL_PIN_DIRECTION_OUTPUT) {
+				peer_target = peer->output;
+				peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+			} else {
+				peer_target = peer->input;
+				peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+			}
+			ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+						  d->dpll_idx,
+						  peer_type, extack);
+			if (!ret)
+				ret = ice_dpll_pin_state_update(pf, peer_target,
+								peer_type, extack);
+			if (ret)
+				goto restore_sma_ctrl;
+		}
+	} else {
+		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type,
+							extack);
+	}
+	goto unlock;
+
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

