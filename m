Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825C43F087
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195361; cv=none; b=g5XF4DZECChgMyIIRZ1/0zOuNtQDpfRYBuOfXJNL8OXqQJkNuF7aHBjM4DxQkeWes3w6NttE6pmiqEtg8dXPqVL8Ryui+j35fiUfKVOmSq4sWzE5D2XVwU12mxhX+xFerXBj6wesouBBCCIvF8ah5cE5o+u0o6hAWWXNljLO4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195361; c=relaxed/simple;
	bh=w0QiPrSSbSxJPJWdLNfgBVxrpdJJbxJ/8HRKxXozyGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZfgm95uzJA3T99gWQ+QWh7kSDyXYTaxownPGA7gPUCdZlQieh4iFCDmWXzVw7rdBP3OFWCHIGPLoFyP5HWKClqNm9txvrW7abywPlpTF/72lYUofVGM9dtwIW5r8Rl6pequa0hq/5vjOBZi/4VBSi1GUrgZDs97L29Om1CM1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFPhXJVU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFPhXJVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784195358; x=1815731358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w0QiPrSSbSxJPJWdLNfgBVxrpdJJbxJ/8HRKxXozyGk=;
  b=KFPhXJVULieh1smSb3+5IY9E5FXvOKLz63pJGEzHUXsqCiMEPx2Jo+Ko
   ldtK1Nky0W1D5U0Cd9+3kWJVP4BjdFVvgGyFCzphz6I2AZ9p2Db6buz7K
   Oc3H3hqDd7KsE9Y5myZ9SjJCEdvl3e1eVbi/NgHLYDDbiAQLdPogeHTwV
   sPUk3qfdqmu3heJkZuonPJQG4yk9kl1xJa51Ux8qavtm+A2FJ+oHMQ9ae
   I9IHoLv9vPwwdqT5eiVZhlOy3p0dOzdyROt3P/PHbSywphrqI4An6xJTv
   V400KTcApGCFvQHmsyzLPDfx9ZHMi9OEGmF7xeZxK/IeEHwSrqo+eaO59
   w==;
X-CSE-ConnectionGUID: D+5gVoadRJ6vjo91B1MHUQ==
X-CSE-MsgGUID: MlZeaHP6RY+DbzzfRYZQkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963875"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84963875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:49:15 -0700
X-CSE-ConnectionGUID: YykEGDFwS2Kt8cdkT04uqQ==
X-CSE-MsgGUID: IhT8kgY3QU6iJSOMLpmelA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="256501623"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:14 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next  v1 1/4] ice: dpll: Rework multiplexed pin notifications
Date: Thu, 16 Jul 2026 09:49:08 +0000
Message-ID: <20260716094912.1210865-2-sergey.temerkhanov@intel.com>
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

Use a pointer to the struct ice_dpll_pin to link multiplexed
pins. This allows to simplify the selection logic.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 60 +++++++++++------------
 drivers/net/ethernet/intel/ice/ice_dpll.h |  1 +
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 1ca137f67dd4..fed7c9fea953 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -544,6 +544,29 @@ ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
 	return ret;
 }
 
+/**
+ * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a state change
+ * @changed: the SW pin that was explicitly changed (already notified by dpll core)
+ *
+ * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
+ * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
+ * expander, the paired pin's state may also change.  Send a change
+ * notification for the peer pin so userspace consumers monitoring the
+ * peer via dpll netlink learn about the update.
+ *
+ * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
+ *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
+ *          still held by the dpll netlink layer.
+ */
+static void ice_dpll_sw_pin_notify_peer(struct ice_dpll_pin *changed)
+{
+	struct ice_dpll_pin *peer;
+
+	peer = changed->muxed;
+	if (peer->pin)
+		__dpll_pin_change_ntf(peer->pin);
+}
+
 /**
  * ice_dpll_pin_store_state - updates the state of pin in SW bookkeeping
  * @pin: pointer to a pin
@@ -1171,32 +1194,6 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
 }
 
-/**
- * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a state change
- * @d: pointer to dplls struct
- * @changed: the SW pin that was explicitly changed (already notified by dpll core)
- *
- * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
- * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
- * expander, the paired pin's state may also change.  Send a change
- * notification for the peer pin so userspace consumers monitoring the
- * peer via dpll netlink learn about the update.
- *
- * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
- *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
- *          still held by the dpll netlink layer.
- */
-static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
-					struct ice_dpll_pin *changed)
-{
-	struct ice_dpll_pin *peer;
-
-	peer = (changed >= d->sma && changed < d->sma + ICE_DPLL_PIN_SW_NUM) ?
-		&d->ufl[changed->idx] : &d->sma[changed->idx];
-	if (peer->pin)
-		__dpll_pin_change_ntf(peer->pin);
-}
-
 /**
  * ice_dpll_sma_direction_set - set direction of SMA pin
  * @p: pointer to a pin
@@ -1258,7 +1255,7 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 	 * backing pin when U.FL becomes inactive because the SMA pin may
 	 * still be using it.
 	 */
-	peer = &d->ufl[p->idx];
+	peer = p->muxed;
 	if (peer->active) {
 		struct ice_dpll_pin *target;
 		enum ice_dpll_pin_type type;
@@ -1388,7 +1385,7 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 unlock:
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
+		ice_dpll_sw_pin_notify_peer(p);
 
 	return ret;
 }
@@ -1508,7 +1505,7 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 unlock:
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, sma);
+		ice_dpll_sw_pin_notify_peer(sma);
 
 	return ret;
 }
@@ -1705,7 +1702,7 @@ ice_dpll_pin_sma_direction_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_dpll_sma_direction_set(p, direction, extack);
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
+		ice_dpll_sw_pin_notify_peer(p);
 
 	return ret;
 }
@@ -4623,6 +4620,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		if (pin->input->ref_sync)
 			pin->ref_sync = pin->input->ref_sync - pin_abs_idx;
 		pin->output = &d->outputs[ICE_DPLL_PIN_SW_OUTPUT_ABS(i)];
+		pin->muxed = &d->ufl[i];
+
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 	for (i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
@@ -4656,6 +4655,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 				(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 				 caps);
 		}
+		pin->muxed = &d->sma[i];
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index c59d746a8567..c102ff2649d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -78,6 +78,7 @@ struct ice_dpll_pin {
 	s32 phase_adjust;
 	struct ice_dpll_pin *input;
 	struct ice_dpll_pin *output;
+	struct ice_dpll_pin *muxed;
 	enum dpll_pin_direction direction;
 	s64 phase_offset;
 	u8 status;
-- 
2.53.0

