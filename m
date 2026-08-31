Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D4390CBA
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187812; cv=none; b=kDhXZrfts5xLDZUHEwQZHly2R5Es+2QkCWl7+EoaC9nN81QqZT3z69BRODHJSXHzv3eIpqSrp4hZNYMdVtQSsjOk5NTm+XtlALntMjpUlCeE5Z/9Ze1BikLo/Zn5S3aZlTYkvfl4Z351zK45jo1PFfnoFoihdfKGbSDQ30d2Eb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187812; c=relaxed/simple;
	bh=9flqOuqLAwOFhVCFfviEiI+e1fQVhXab9jGjj0nkQ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqWZ4B5eCXMRMXMf6Di5Vyt1KUInPsAkNwDF3sTOlLXvCxYHhQaSn+526Iqdmc1cW2A/J6yZnAncaOXmGM2oUBZsqaQpndLoPSAnG2nTwkpebtpKUuQ1ErrLv1GLIwHyjpMnJfGwZCtRGXhTZKV1h/2zFO+68mF8HGqHgnMqork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkjIDkeR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkjIDkeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788187811; x=1819723811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9flqOuqLAwOFhVCFfviEiI+e1fQVhXab9jGjj0nkQ7s=;
  b=KkjIDkeRcK7P826q0MPA0wJJ3Qv1VWbl2792MRcVxxgKiiAc9qqArUJL
   ObvDWBNOepmO2bbQ8ZTCl8qKQp0/9ThDmSGvndx2UOf5C6wgsmnTDilHK
   H3WEiAHdbtFWzsvkLnENEXWnlZfQGJhonbFKvQ18+/9x5XF5KTD8blXpd
   Vnk7TSvXOKzVz39VQoxCG7I5IzWoRdD/KXM0tJZ+JZ1//YKfEkpN3xUdt
   2BSL7SGfOjHaMtRF49JzEmBH7Z5O5tLKTeCgslZ3zd+27l5HqkqD0c1jR
   8tV0datygiRd9J2q1wqqNPSzGFmg10O24jsoNzVISqxopsJgTc3OJc8jk
   g==;
X-CSE-ConnectionGUID: Hb5PHPHGS9yt7n4cj+YC2Q==
X-CSE-MsgGUID: SQ8GyByATlSkKvWnIZXZjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144527"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="76144527"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:50:09 -0700
X-CSE-ConnectionGUID: 0ct7VCIoQx6jGTW98+iJBQ==
X-CSE-MsgGUID: RKLqn/i0Tqev9MSM4osdEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="273003700"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:09 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 2/6] ice: dpll: Rework multiplexed pin notifications
Date: Mon, 31 Aug 2026 14:50:01 +0000
Message-ID: <20260831145005.191040-3-sergey.temerkhanov@intel.com>
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
index 9b3584fa43a9..ac1a034b7353 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -564,6 +564,29 @@ ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
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
+	if (peer && peer->pin)
+		__dpll_pin_change_ntf(peer->pin);
+}
+
 /**
  * ice_dpll_pin_store_state - updates the state of pin in SW bookkeeping
  * @pin: pointer to a pin
@@ -1189,32 +1212,6 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1276,7 +1273,7 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 	 * backing pin when U.FL becomes inactive because the SMA pin may
 	 * still be using it.
 	 */
-	peer = &d->ufl[p->idx];
+	peer = p->muxed;
 	if (peer->active) {
 		struct ice_dpll_pin *target;
 		enum ice_dpll_pin_type type;
@@ -1406,7 +1403,7 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 unlock:
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
+		ice_dpll_sw_pin_notify_peer(p);
 
 	return ret;
 }
@@ -1526,7 +1523,7 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 unlock:
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, sma);
+		ice_dpll_sw_pin_notify_peer(sma);
 
 	return ret;
 }
@@ -1723,7 +1720,7 @@ ice_dpll_pin_sma_direction_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_dpll_sma_direction_set(p, direction, extack);
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
+		ice_dpll_sw_pin_notify_peer(p);
 
 	return ret;
 }
@@ -4909,6 +4906,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		if (pin->input->ref_sync)
 			pin->ref_sync = pin->input->ref_sync - pin_abs_idx;
 		pin->output = &d->outputs[ICE_DPLL_PIN_SW_OUTPUT_ABS(i)];
+		pin->muxed = &d->ufl[i];
+
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 	for (i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
@@ -4942,6 +4941,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 				(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 				 caps);
 		}
+		pin->muxed = &d->sma[i];
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index bce0bea9a664..f7e6680d124c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -76,6 +76,7 @@ struct ice_dpll_pin {
 	s32 phase_adjust;
 	struct ice_dpll_pin *input;
 	struct ice_dpll_pin *output;
+	struct ice_dpll_pin *muxed;
 	enum dpll_pin_direction direction;
 	s64 phase_offset;
 	u8 status;
-- 
2.53.0

