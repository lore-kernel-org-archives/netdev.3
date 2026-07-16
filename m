Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5D3F787F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195362; cv=none; b=rsN2ZyBvtDByE+47lLe7oSuebS+v1ccyV7WYHbdDGnCaspDhoRWUQRZbk5Qup+FNC2/pLInlyxo0eEXwXIemTEeVhwwRMI9QbHxcDp1BXfNfE1qlB27BytYOXZ2h4Xv3CTbYqMAPhbVlTUnMDPDe2hqSuTWjwssQY0azng/L/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195362; c=relaxed/simple;
	bh=SksVPDM8MtMFs/A4NjrOmOmXL+uWqXN/8PvffGz9b+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6p7307XUdLhiH4NJcvGe6yJq+uuMFvPWtb/Yx/S4P5Nn9MbAlrNEW7HnexgKuDXYlZezOk7YJeI4ZjdzZe0EsdmXTZ5R6OBVwsPJpOKSadEAJLlLKOPngTPxrLld7Q4T33ExqmAqCsoXq+MJhq6xkIrbIxV75dj/9Q+rwknzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gr7xAr4s; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gr7xAr4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784195360; x=1815731360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SksVPDM8MtMFs/A4NjrOmOmXL+uWqXN/8PvffGz9b+8=;
  b=Gr7xAr4swftPXQ5Eaq7MELx6fCkKIO0LHycEUVnmB2kDdeVz6bEdS/5k
   FdrD+/1XWmD7ekPoIP/bt8D+nk4Xolm71/CbLj/BC2r6l8+8FaCAnDecE
   e3Bl5yF4w3nGgI9ZURto1h/WPZFix8hgBZbXvtr6Xi4Va7DHEtK3UYEDv
   8Da7/hMRULU60WJMzBdIgqypdLFrca7huHHQaDlfjShC8ReqKoc76RMT1
   kcP160P/mA0GnmKdEVSwJV7pnh/h580wwxrJqBJBOTYqhvix/sNsmxZ7S
   9XJ8UsPo6ZHjIz3snc2UCaQP1lEPJgG799fok7N6ziuWn8GTkaPPGXmdh
   Q==;
X-CSE-ConnectionGUID: 8M2O6x2DSc2K1fC4X6n/Nw==
X-CSE-MsgGUID: 9vO49FL8SNmX6XMx57h//Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963881"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84963881"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:49:17 -0700
X-CSE-ConnectionGUID: rTSjzYjkR++uQI6VWc7qdg==
X-CSE-MsgGUID: 4ZkwPuwEQ026n7b5ZXd+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="256501630"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:16 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next  v1 3/4] ice: dpll: Rework U.FL muxed pin (SMA) control
Date: Thu, 16 Jul 2026 09:49:10 +0000
Message-ID: <20260716094912.1210865-4-sergey.temerkhanov@intel.com>
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

Rework multiplexed pin control to match the state change listed in
the design requirements.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 35 ++++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 54958e17713b..cb14621b3aef 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1381,12 +1381,39 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	if (ret)
 		goto unlock;
 
-	if (enable)
+	if (enable) {
 		ret = ice_dpll_pin_enable(hw, target, d->dpll_idx, type, extack);
-	else
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (!ret && p->muxed->active) {
+			struct ice_dpll_pin *peer = p->muxed;
+			struct ice_dpll_pin *peer_target;
+			enum ice_dpll_pin_type peer_type;
+			int peer_ret;
+
+			if (peer->direction == DPLL_PIN_DIRECTION_OUTPUT) {
+				peer_target = peer->output;
+				peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+			} else {
+				peer_target = peer->input;
+				peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+			}
+			peer_ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+						       pf->dplls.eec.dpll_idx,
+						       peer_type, NULL);
+			if (!peer_ret)
+				peer_ret = ice_dpll_pin_state_update(pf, peer_target,
+							     peer_type, NULL);
+			if (peer_ret)
+				dev_warn(ice_pf_to_dev(pf),
+					 "Failed to sync peer pin %u after enabling U.FL pin %u, err %d\n",
+					 peer_target->idx, target->idx, peer_ret);
+		}
+	} else {
 		ret = ice_dpll_pin_disable(hw, target, type, extack);
-	if (!ret)
-		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type, extack);
+	}
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
-- 
2.53.0

