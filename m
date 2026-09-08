Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46058F084
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906285; cv=none; b=lw1EhQxuVUuNhjz9dr+5JI9vgIf/WeI0B3HJ7Iy9kdIYGhKajGHnWJ3HBxpqqD1S56K6+UJyjZ3i8kQKqdQbakRSzTVUUeMpC1+AXya5XFG1xUxR4B2Owz4eKBXkix3GORZ4sRMEN6UBrTDBa3ikuKxXwXKSJtXieEyknJlIxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906285; c=relaxed/simple;
	bh=CRe0s58JQTnKy1ToPw+Jvn2Gha1QD/NaYoXuEsk/Iho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doOzGlU/3ibfN1rwC8csuZOq/ueCVj4rrsovoUv6/ZFgr08S2B/AZlhwSeCIX/+lJo7ld/1xu+mPTY9yPi724MU+mMnq9Ska5TE1xRUzj7Spg5jgx6DqsGFUXolO9HlQy+T3EIvpjPPWK6m6hKFIG9h7q5tKic70L2VREAdve3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Elbr5rVS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Elbr5rVS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788906283; x=1820442283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CRe0s58JQTnKy1ToPw+Jvn2Gha1QD/NaYoXuEsk/Iho=;
  b=Elbr5rVSynb08sZsesXbx4O+7Mww8AW3FOgZEbNbsbdF4cjDrCiOK+8h
   pvAdCfDG745nT/DTgFhWpYXfwM3auY5pyRgJrvUXXl0YaSOn3f6EKz+6g
   fvHxmExYWFKW0TCwF83iVIkIalTd6xjdBkGtJV2lZYrpiyOmQaZOQOIR0
   Q499kYHiyXvxC/p6flLVpS5wxtbgzvimbzEB2YAP79i9C5LgdRcfJEjLl
   PMb+LO9OM9lBNQ4coUg4Urjc8hMtihfGnLZPYgWiXm297XNHqXDI2ndky
   klKKWIFCOrIU4f/c4Gs+SNhFEiEUxxf9qYBphrk0NbJsFxec62BVTV/Bm
   g==;
X-CSE-ConnectionGUID: xjhn8oIXQEqXAVvdk6LryQ==
X-CSE-MsgGUID: hEPzxtnQTAWBLtrAF7C8VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89354888"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="89354888"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 15:24:39 -0700
X-CSE-ConnectionGUID: 1q7oxxjgQUmaVkkSBQ/1uw==
X-CSE-MsgGUID: m1A1rFggRvCM+eYCrOtqPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="274660835"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Sep 2026 15:24:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.korba@intel.com,
	richardcochran@gmail.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 3/3] ice: use per-interface clock_id for E825 generic DPLLs
Date: Tue,  8 Sep 2026 15:24:26 -0700
Message-ID: <20260908222428.872254-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908222428.872254-1-anthony.l.nguyen@intel.com>
References: <20260908222428.872254-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

On E825, the TX-CLK and TSPLL DPLL devices are registered as
DPLL_TYPE_GENERIC. Their clock_id was derived from the board-level
PCIe DSN, which is identical for all interfaces sharing the same
NAC/quad. As a result, userspace (e.g. 'dpll device show') reports
several DPLL devices with the same clock_id and no board or signal
label, making it impossible to unambiguously map a DPLL device to
the interface it belongs to.

Since these DPLLs are per-interface, use the permanent port MAC as
the clock_id basis for E825 generic DPLLs:

  * TX-CLK uses the plain MAC-derived value.
  * TSPLL on the source-timer owner PF uses the same MAC-derived
    value with a dedicated tag bit, so it stays distinct from
    TX-CLK while remaining stable per interface.

Other DPLL objects (EEC/PPS and non-E825 paths) keep the board
DSN-derived clock_id. When the permanent MAC is not yet valid, fall
back to the existing board-level clock_id to preserve init behavior.

Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 80 +++++++++++++++++++++--
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 00e3f7de7810..0109fc34307c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3059,6 +3059,68 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
 	return pci_get_dsn(pf->pdev);
 }
 
+/**
+ * ice_generate_dpll_clock_id - generate clock_id for a specific dpll device
+ * @pf: board private structure
+ * @d: dpll device context
+ * @type: dpll type being registered
+ *
+ * For E825 generic DPLLs, use per-interface permanent MAC as the clock_id
+ * basis so userspace can unambiguously map DPLL devices to interfaces.
+ * TX-CLK keeps plain MAC-derived ID, while TSPLL uses the same basis with
+ * a dedicated tag bit to remain distinct on source-timer owner PFs.
+ * Other DPLL objects keep board-level DSN-derived clock_id.
+ *
+ * Return: generated clock id for a dpll device
+ */
+static u64 ice_generate_dpll_clock_id(struct ice_pf *pf, struct ice_dpll *d,
+				      enum dpll_type type)
+{
+	struct ice_hw *hw = &pf->hw;
+	u64 mac_clock_id;
+
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
+	    type == DPLL_TYPE_GENERIC &&
+	    hw->port_info &&
+	    is_valid_ether_addr(hw->port_info->mac.perm_addr)) {
+		mac_clock_id = ether_addr_to_u64(hw->port_info->mac.perm_addr);
+
+		if (d->dpll_idx >= E825_DPLL_TXCLK_BASE_IDX)
+			return mac_clock_id;
+
+		if (d->dpll_idx == E825_DPLL_TSPLL_BASE_IDX)
+			return mac_clock_id | BIT_ULL(63);
+	}
+
+	return pf->dplls.clock_id;
+}
+
+/**
+ * ice_dpll_is_own_dpll_clock_id - check if clock_id belongs to this pf's DPLLs
+ * @pf: board private structure
+ * @clock_id: clock_id from a DPLL notification
+ *
+ * Match info->src_clock_id from a DPLL pin notification against any DPLL
+ * device this PF has registered. Used to suppress self-notifications
+ * generated as a side effect of our own dpll_pin_register() and
+ * dpll_pin_unregister() calls on the fwnode-backed SYNCE and TIME_REF pins,
+ * whose DPLLs (TXC and TSPLL) use MAC-derived clock_ids on E825.
+ *
+ * Return: true if clock_id matches one of this PF's registered DPLL devices.
+ */
+static bool ice_dpll_is_own_dpll_clock_id(struct ice_pf *pf, u64 clock_id)
+{
+	if (clock_id == pf->dplls.clock_id)
+		return true;
+	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825)
+		return false;
+	if (clock_id == ice_generate_dpll_clock_id(pf, &pf->dplls.txc,
+						   DPLL_TYPE_GENERIC))
+		return true;
+	return clock_id == ice_generate_dpll_clock_id(pf, &pf->dplls.tspll,
+						      DPLL_TYPE_GENERIC);
+}
+
 /**
  * ice_dpll_pin_ntf - notify pin change including any SW pin wrappers
  * @dplls: pointer to dplls struct
@@ -3858,10 +3920,12 @@ static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned long action,
 	if (pin->fwnode != info->fwnode)
 		return NOTIFY_DONE; /* Not this pin */
 
-	/* Ignore notification which are the outcome of internal pin
-	 * registration/unregistration calls - synce pin case.
+	/* Ignore notifications that are a side effect of internal pin
+	 * registration/unregistration calls. E825 uses per-device
+	 * MAC-derived clock_ids for the TXC and TSPLL generic DPLLs, so
+	 * info->src_clock_id may not equal pf->dplls.clock_id.
 	 */
-	if (info->src_clock_id == pin->pf->dplls.clock_id)
+	if (ice_dpll_is_own_dpll_clock_id(pin->pf, info->src_clock_id))
 		return NOTIFY_DONE;
 
 	work = kzalloc_obj(*work);
@@ -4206,10 +4270,16 @@ static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
 {
 	struct ice_dpll_pin *ref_pin = pf->dplls.txclks;
 	struct ice_dpll *txc = &pf->dplls.txc;
+	u64 clock_id;
 	int ret;
 
+	/* EXT_EREF0 is a non-fwnode pin; its clock_id must match the TX-CLK
+	 * DPLL device clock_id (see dpll_pin_register()).
+	 */
+	clock_id = ice_generate_dpll_clock_id(pf, txc, DPLL_TYPE_GENERIC);
+
 	/* Configure EXT_EREF0 pin */
-	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, pf->dplls.clock_id);
+	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, clock_id);
 	if (ret)
 		return ret;
 	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,
@@ -4487,7 +4557,7 @@ static int
 ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 		   enum dpll_type type)
 {
-	u64 clock_id = pf->dplls.clock_id;
+	u64 clock_id = ice_generate_dpll_clock_id(pf, d, type);
 	int ret;
 
 	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE,
-- 
2.47.1

