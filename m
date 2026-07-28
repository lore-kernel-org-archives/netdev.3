Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B041DE0A;
	Tue, 28 Jul 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230326; cv=none; b=cqFt/mF/H3LqKsKWdDTdobFru9xwBrTNKkD8QtKvtJAABBDmxAoELs2sK/q8DCUD5lT6WIkm1OMLdo1hBzFGDrr9jig1GZajHi1/HRzHF/WTy43Gw35eI1mQaRo5uPInu1nwtPNu5mWo8kQ0AM+MGSvNf8E/tvARq4vikWIxEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230326; c=relaxed/simple;
	bh=vmdpgy9HmZnxdF1nTRNR7C7DPdtd7GWuftqfURYyQFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5Fib+NCUVH3qsX8tXxKFzfjdA4q/FhYNawv1JE8z0+lp8BOcHzdbksS9fu8+Hdbrx2A+i1yknbCI1VE+m6l2jrdVzLPTPpkfNbwmRIAqSgo5xB84PSb6MlI7QsB/V6P9PkeK/Y+JmI+oHODJOCA7YKgDcdN5+qzwwksJbpq2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Doa7PXdE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Doa7PXdE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785230324; x=1816766324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmdpgy9HmZnxdF1nTRNR7C7DPdtd7GWuftqfURYyQFo=;
  b=Doa7PXdEPXLqB+s7PkkoqeUJru5pX1vRShgLQchYXGgp6OYQKsRcYNT1
   ahTYHHz54BdYTLNiPABJNkvP7X2Np2ldZYyvJeHugWF+V6GDP6YndAiVF
   R8JlyJfgK4Z2LctXuuCcbGN+VIiGUUk2HdYubEC4Dawa79WUHnwfKl2Pa
   A13SZ3du4IEnWF9OX7Iyy4e9ptzz38GuQt+TozylaBFZ1IthOg0hadFeJ
   XqYRIbZczs5VA9cMqF64ndigyY19Lr/de7NBLpQ7iBjsR59Q5uN7SBn2E
   jX9ZtDpT4wcdEMBSbI5rN6bjWELS7vFtvipM47QqmPpNvu0QsShSX6VcL
   A==;
X-CSE-ConnectionGUID: zQ8OXRjOQQO3FowBHQ+FEQ==
X-CSE-MsgGUID: ilepvlslS1OqphDW1nLWFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85677265"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85677265"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 02:18:44 -0700
X-CSE-ConnectionGUID: QiPfYfJERze7O7rEbafFzA==
X-CSE-MsgGUID: HQIK4YgzRp+069YjoKFMMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="258378431"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 02:18:41 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next 3/3] ice: use per-interface clock_id for E825 generic DPLLs
Date: Tue, 28 Jul 2026 11:13:14 +0200
Message-Id: <20260728091314.1420656-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260728091314.1420656-1-grzegorz.nitka@intel.com>
References: <20260728091314.1420656-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 81 +++++++++++++++++++++--
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index fd5636394198..73aadf068dd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3051,6 +3051,68 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
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
  * ice_dpll_tspll_lock_status_get - derive TSPLL state for dpll subsystem
  * @pf: board private structure
@@ -3887,10 +3949,12 @@ static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned long action,
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
@@ -4247,10 +4311,17 @@ static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
 {
 	struct ice_dpll_pin *ref_pin = pf->dplls.txclks;
 	struct ice_dpll *txc = &pf->dplls.txc;
+	u64 clock_id;
 	int ret;
 
+	/*
+	 * EXT_EREF0 is a non-fwnode pin; its clock_id must match the TX-CLK
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
@@ -4535,7 +4606,7 @@ static int
 ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 		   enum dpll_type type)
 {
-	u64 clock_id = pf->dplls.clock_id;
+	u64 clock_id = ice_generate_dpll_clock_id(pf, d, type);
 	int ret;
 
 	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE,
-- 
2.39.3

