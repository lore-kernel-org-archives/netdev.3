Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF641A508
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895239; cv=none; b=CyDCW5Cb7Ck+lWlnLIi1N2BBHi0gSLvzYXe1Y9WHr3lHeC6YgRSdSb9BeF8oJI9TGp3zJ4adEgsiDnb3ehIjyPVNwXCvhVHK4kRXfzrLFsmwhIVuslXmhWmXgxb9pxLX6xbOnJX84pTMLrwsdCAdgn3JLyJ5HPjt2oHxL9Wta+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895239; c=relaxed/simple;
	bh=fW4um8qozIDoVKGhh05w0Iwe35alS3ohczF4Q21jOiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L24HBa0hQzyVawR2jMk6uQGbZRNUaA3o+SzfN+TGEofXnnMC8drHuNV+XjzaWFoG44ThcF4Z2DJHDMXOLrz1yuqJhdfbii5D4P3VjeEtlHv9TpcJeykJI5UGWQbkoyR9k8SPtUFZfU1OtzAjOAEAK1rqYZ/HP3GWqQgwxqJB8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFKqEMxR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFKqEMxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784895236; x=1816431236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fW4um8qozIDoVKGhh05w0Iwe35alS3ohczF4Q21jOiM=;
  b=OFKqEMxRCvnALyrMa68gTNPk9HldpN4+mP+Pyg+v9wTxrbZqEyaJFO8l
   VIbeoT5xX0oACe1w3TYAbwwL7QKkxLVAJ56wenuwKqS23QPtIcfRWYEJk
   y5j3FKHJVYXlW8kmFvmNwPu4QOA/QwN44JeCU3cmbSeuzUnu+IJtm1eRw
   tZAj2LPsCuuvihK5n88wCwtlbAROllyeuRbNG7OQp2an1XtQeMdnC8Dp+
   /P+6UDPwJEomUO/7twkGZwI4qB+B7JvxB8SmPyz+JMOb/Sj4iGdkQ6Sdz
   OAAQYk0ZAEg8Y/Vpek5X8TAcJUgKo7LcaRe/XUGX8YME48tXTrcwpFRKv
   Q==;
X-CSE-ConnectionGUID: GsJmXZm2QjuY3BfRLbrJLg==
X-CSE-MsgGUID: QiA6GgmhSdWlUNRunGTVqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84686076"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="84686076"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 05:13:55 -0700
X-CSE-ConnectionGUID: koCgI1vyTl+kpVD12YZndg==
X-CSE-MsgGUID: iWSifpX/QPGq+you6SdqcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="252367705"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2026 05:13:54 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 3/4] ice: dpll: Rework U.FL muxed pin (SMA) control
Date: Fri, 24 Jul 2026 12:13:49 +0000
Message-ID: <20260724121350.1565330-4-sergey.temerkhanov@intel.com>
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

Rework multiplexed pin control to match the state change listed in
the design requirements.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 86 +++++++++++++++++++++--
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 54958e17713b..cf54a7f2f836 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1268,7 +1268,8 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 			type = ICE_DPLL_PIN_TYPE_INPUT;
 		}
 		ret = ice_dpll_pin_enable(&p->pf->hw, target,
-					  d->eec.dpll_idx, type, extack);
+					  d->pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX && target->state[d->pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
+					  d->pps.dpll_idx : d->eec.dpll_idx, type, extack);
 		if (!ret)
 			ret = ice_dpll_pin_state_update(p->pf, target,
 							type, extack);
@@ -1304,6 +1305,7 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	enum ice_dpll_pin_type type;
 	struct ice_pf *pf = p->pf;
 	struct ice_hw *hw;
+	u8 old_data = 0;
 	bool enable;
 	u8 data;
 	int ret;
@@ -1316,6 +1318,7 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_read_sma_ctrl(hw, &data);
 	if (ret)
 		goto unlock;
+	old_data = data;
 
 	ret = -EINVAL;
 	switch (p->idx) {
@@ -1379,14 +1382,85 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_dpll_pin_state_update(pf, p, ICE_DPLL_PIN_TYPE_SOFTWARE,
 					extack);
 	if (ret)
-		goto unlock;
+		goto restore_sma_ctrl;
 
-	if (enable)
+	if (enable) {
 		ret = ice_dpll_pin_enable(hw, target, d->dpll_idx, type, extack);
-	else
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (!ret && p->muxed && p->muxed->active) {
+			struct ice_dpll_pin *peer = p->muxed;
+			struct ice_dpll_pin *peer_target;
+			enum ice_dpll_pin_type peer_type;
+			int peer_ret;
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
+			peer_ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+					       pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX &&
+					       peer_target->state[pf->dplls.pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
+					       pf->dplls.pps.dpll_idx : pf->dplls.eec.dpll_idx,
+						       peer_type, NULL);
+			if (!peer_ret)
+				peer_ret = ice_dpll_pin_state_update(pf, peer_target,
+							     peer_type, NULL);
+			if (peer_ret) {
+				ret = peer_ret;
+				goto disable_pin;
+			}
+		}
+	} else {
 		ret = ice_dpll_pin_disable(hw, target, type, extack);
-	if (!ret)
-		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type, extack);
+	}
+
+	goto unlock;
+
+disable_pin:
+	ice_dpll_pin_disable(hw, target, type, extack);
+	if (p->muxed && p->muxed->active) {
+		struct ice_dpll_pin *peer = p->muxed;
+		struct ice_dpll_pin *peer_target = NULL;
+		enum ice_dpll_pin_type peer_type;
+
+		if (peer->direction == DPLL_PIN_DIRECTION_OUTPUT) {
+			peer_target = peer->output;
+			peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+		} else if (peer->direction == DPLL_PIN_DIRECTION_INPUT) {
+			peer_target = peer->input;
+			peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+		}
+		if (peer_target)
+			ice_dpll_pin_disable(&pf->hw, peer_target, peer_type, extack);
+	}
+restore_sma_ctrl:
+	{
+		int restore_ret;
+
+		restore_ret = ice_write_sma_ctrl(hw, old_data);
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

