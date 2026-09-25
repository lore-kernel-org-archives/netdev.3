Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3D4A1DF6
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342839; cv=none; b=BDTL2BoIa0jXuwOWxWmDGfjfvnHNN4Ie+zHG7g0rP4oz4RFidysBaFsfEF9lZTH1QoYrPp7SZqEuQ2e3Ij+ROHNcKBfuL6yGrZobsmb259sVkWsIzUzgUV5ef+hWzfkd8cGa7qf41bIvTcleNU0LnTt4cJkzcMyx3xsbPSKxcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342839; c=relaxed/simple;
	bh=6+u0PFe1nHuFQQKp9ilG1eh4GFW/bVKj9LEehtHjK9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/fhiBwFlByTMaDTY0wa4/hUJZ3zEX3rl9TcTq1tC+uLk9/L7w1e/EZGZLUeJL89k4lfVs4NpCb4Xyy0nIvbhIKDTA5/PNSl3tRDO9+JZuYQsXspO7pRkUMx8yMRFnH3ud1MWGp/ca/DyIXi/3JIocsT9fcbcGsV1vwWj1mVLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moNcJErk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moNcJErk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790342834; x=1821878834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+u0PFe1nHuFQQKp9ilG1eh4GFW/bVKj9LEehtHjK9k=;
  b=moNcJErk+eT7zwh11Fvb7XoO0lObtBJKp+B3i8dTDXx+5sF8N0FACTIx
   9uFe12dSR7sC5FWpd6tMf/y22Qk1cIAY5inEUFNqKo5rgVp+cercQKGix
   vClo4gxYvsoTVXtPSiGqfm+dDWHmxvzyyccV9JKUI5MpAIRse2g7x5kmH
   W9ippcoj4ZUZpnP72HjIO9u4XqSoLL2T+Vd6+dzQHRVFPBmFPNj63vJF9
   f5ZP5NpSsnr8ssEgkVwzPLImmxBdj630+ig6pOrVWJHTTHLXMP3jnqMnF
   4yVuef99K3CX34WZy4GTmw8kGRN4sANUbRO+7IHVzFRIC6DMbCdkcBENX
   A==;
X-CSE-ConnectionGUID: SaJXztqzRfCPsQnls4TQVA==
X-CSE-MsgGUID: B5diE14jRBKWH5lPMuHU4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508274"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="107508274"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:27:01 -0700
X-CSE-ConnectionGUID: Vs+P74epRTKeM1iq0DyKrw==
X-CSE-MsgGUID: LDqo3DzyQqGo7OvB5JCoqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="282414750"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:57 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 188662FC53;
	Fri, 25 Sep 2026 14:26:56 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of reallocating them in place
Date: Fri, 25 Sep 2026 15:15:47 +0200
Message-ID: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_vsi_realloc_stat_arrays() resized the ring stats arrays in place
with krealloc_array(), sizing them from vsi->req_txq/req_rxq. That is
not what ice_vsi_set_num_qs() computes later in ice_vsi_cfg_def(), so
after a rebuild the arrays could end up shorter than vsi->alloc_txq /
vsi->alloc_rxq, and ice_vsi_alloc_ring_stats() then walked past their
end.

The VF case shows the divergence. ice_sriov_set_msix_vec_count() writes
vsi->req_txq and then calls ice_vsi_rebuild(), so the old resizer sized
from req_txq, while ice_vsi_get_num_qs() reads vf->num_req_qs ?:
vf->num_vf_qs and ignores req_txq entirely. Once a guest has raised
vf->num_req_qs through VIRTCHNL_OP_REQUEST_QUEUES the two disagree and
the arrays come out shorter than the alloc_txq/alloc_rxq the rebuild
installs. The reset that such a request triggers is a different path,
ice_vf_reconfig_vsi(), which does not use this resizer at all; that one
is handled by the next patch.

Replace it with ice_vsi_resize_stat_arrays(), which allocates a fresh
struct ice_vsi_stats instead, sized with ice_vsi_get_num_qs() and the
queues ice_vsi_decfg() is about to return to the PF pool, which is
exactly what ice_vsi_set_num_qs() will compute once they are back
there, barring a concurrent change of the PF pool; the next patch stops
relying on that. Copy the surviving entry pointers over and install
the new structure, all before ice_vsi_decfg() runs. The entries that
did not fit are freed by ice_vsi_free_unused_stat_arrays(); the old
container itself then goes through __ice_vsi_free_stats() with
@free_entries set to false, since the entries it still points at now
belong to the new structure.

Allocating up front also means a failure no longer leaves a half-updated
ice_vsi_stats behind, with the Tx array already swapped and its surplus
Tx entries already freed, but the Rx allocation failed.

Put the allocate-install-free-surplus sequence in
ice_vsi_install_stat_arrays(), next to ice_vsi_new_stat_arrays(), so
that only the sizing decision is left in the resizer.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
this removes some tech debt, but it is not independently backportable,
as it sits on three preceding refactors; the NULL dereference and the
sizing mismatch are fixed by their own patches, which carry Fixes: tags

v5:
 - drop the false "requesting fewer queues than the PF pool can hand
   out" reproducer, use the VF one that the code can exhibit (Clashiko)
 - describe the real failure-path benefit, the old code already returned
   before ice_vsi_decfg() with the VSI fully configured (Clashiko)
 - split the ICE_VSI_CHNL guard into its own patch with a Fixes: tag
   (Clashiko)
 - factor out ice_vsi_install_stat_arrays(), reused by the new sizing
   patch (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 144 ++++++++++++++---------
 1 file changed, 88 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 134984077d5d..448d3c7780ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -557,6 +557,80 @@ static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int rxq)
 	return vsi_stat;
 }
 
+static void ice_vsi_free_unused_stat_arrays(struct ice_vsi_stats *vsi_stat,
+					    struct ice_vsi_stats *new_vsi_stat)
+{
+	int new_txq = new_vsi_stat->tx_ring_stats_len;
+	int new_rxq = new_vsi_stat->rx_ring_stats_len;
+	int prev_txq = vsi_stat->tx_ring_stats_len;
+	int prev_rxq = vsi_stat->rx_ring_stats_len;
+
+	for (int i = new_txq; i < prev_txq; i++) {
+		if (vsi_stat->tx_ring_stats[i]) {
+			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
+			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
+		}
+	}
+	for (int i = new_rxq; i < prev_rxq; i++) {
+		if (vsi_stat->rx_ring_stats[i]) {
+			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
+			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
+		}
+	}
+}
+
+static void ice_vsi_set_stat_arrays(struct ice_vsi *vsi,
+				    struct ice_vsi_stats *new_vsi_stat)
+{
+	u16 new_txq, new_rxq, prev_txq, prev_rxq;
+	struct ice_vsi_stats *vsi_stat;
+	struct ice_pf *pf = vsi->back;
+
+	new_txq = new_vsi_stat->tx_ring_stats_len;
+	new_rxq = new_vsi_stat->rx_ring_stats_len;
+	vsi_stat = pf->vsi_stats[vsi->idx];
+	pf->vsi_stats[vsi->idx] = new_vsi_stat;
+	if (!vsi_stat)
+		return; /* don't copy if there is no source */
+
+	prev_txq = vsi_stat->tx_ring_stats_len;
+	prev_rxq = vsi_stat->rx_ring_stats_len;
+
+	memcpy(new_vsi_stat->tx_ring_stats, vsi_stat->tx_ring_stats,
+	       sizeof(*vsi_stat->tx_ring_stats) * min(prev_txq, new_txq));
+	memcpy(new_vsi_stat->rx_ring_stats, vsi_stat->rx_ring_stats,
+	       sizeof(*vsi_stat->rx_ring_stats) * min(prev_rxq, new_rxq));
+}
+
+/**
+ * ice_vsi_install_stat_arrays - swap in freshly sized ring stats arrays
+ * @vsi: VSI to install the ring stats arrays of
+ * @txq: number of Tx ring stats entries to make room for
+ * @rxq: number of Rx ring stats entries to make room for
+ *
+ * Surviving entries are carried over, the rest is freed together with the old
+ * container.
+ *
+ * Return: 0 on success and negative value on failure.
+ */
+static int ice_vsi_install_stat_arrays(struct ice_vsi *vsi, u16 txq, u16 rxq)
+{
+	struct ice_vsi_stats *old_stat, *new_stat;
+
+	new_stat = ice_vsi_new_stat_arrays(txq, rxq);
+	if (!new_stat)
+		return -ENOMEM;
+
+	old_stat = vsi->back->vsi_stats[vsi->idx];
+	ice_vsi_set_stat_arrays(vsi, new_stat);
+	if (old_stat) {
+		ice_vsi_free_unused_stat_arrays(old_stat, new_stat);
+		__ice_vsi_free_stats(old_stat, false);
+	}
+
+	return 0;
+}
+
 /**
  * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
  * @vsi: VSI pointer
@@ -3040,69 +3114,27 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 }
 
 /**
- * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
- * @vsi: VSI pointer
+ * ice_vsi_resize_stat_arrays - resize ring stats arrays for new queue count
+ * @vsi: VSI to swap the ring stats arrays of
+ *
+ * Call while @vsi still owns its queues and before ice_vsi_decfg() returns them
+ * to the PF pool, so that the new size is what ice_vsi_set_num_qs() will compute
+ * afterwards. Surviving entries are carried over, the rest is freed.
+ *
+ * Return: 0 on success and negative value on failure.
  */
-static int
-ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
+static int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
 {
-	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
-	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
-	struct ice_ring_stats **tx_ring_stats;
-	struct ice_ring_stats **rx_ring_stats;
-	struct ice_vsi_stats *vsi_stat;
-	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
-	int i;
+	struct ice_vsi_alloc_queues_params qs;
 
 	/* channel VSIs have no entry in pf->vsi_stats[] */
 	if (vsi->type == ICE_VSI_CHNL)
 		return 0;
 
-	vsi_stat = pf->vsi_stats[vsi->idx];
-
-	if (req_txq < prev_txq) {
-		for (i = req_txq; i < prev_txq; i++) {
-			if (vsi_stat->tx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
-			}
-		}
-	}
-
-	tx_ring_stats = vsi_stat->tx_ring_stats;
-	vsi_stat->tx_ring_stats =
-		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
-			       sizeof(*vsi_stat->tx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->tx_ring_stats) {
-		vsi_stat->tx_ring_stats = tx_ring_stats;
-		return -ENOMEM;
-	}
-	vsi_stat->tx_ring_stats_len = req_txq;
+	qs = ice_vsi_get_num_qs(vsi, vsi->alloc_txq + vsi->num_xdp_txq,
+				vsi->alloc_rxq);
 
-	if (req_rxq < prev_rxq) {
-		for (i = req_rxq; i < prev_rxq; i++) {
-			if (vsi_stat->rx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
-			}
-		}
-	}
-
-	rx_ring_stats = vsi_stat->rx_ring_stats;
-	vsi_stat->rx_ring_stats =
-		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
-			       sizeof(*vsi_stat->rx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->rx_ring_stats) {
-		vsi_stat->rx_ring_stats = rx_ring_stats;
-		return -ENOMEM;
-	}
-	vsi_stat->rx_ring_stats_len = req_rxq;
-
-	return 0;
+	return ice_vsi_install_stat_arrays(vsi, qs.alloc_txq, qs.alloc_rxq);
 }
 
 /**
@@ -3132,7 +3164,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 	mutex_lock(&vsi->xdp_state_lock);
 
-	ret = ice_vsi_realloc_stat_arrays(vsi);
+	ret = ice_vsi_resize_stat_arrays(vsi);
 	if (ret)
 		goto unlock;
 
-- 
2.51.1

