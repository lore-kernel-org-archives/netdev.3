Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8884FC8C3
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014878; cv=none; b=aDjhsZT/3OELtJ+dGkynxOn54c4/C15pc/3pCvQaf252je5GVW/LhCmr+BMj6XpY4TQSacy/Dgg7+ire/pGmvL6PIQkt/+ogW0kasxv5kK2bUGoZAOadL/xvGOjfngA2iHnJy3zQPYFU+9G1plRmEtS8dhoY7nYoPh+IbCz1UMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014878; c=relaxed/simple;
	bh=McSJ/+gl6XAaywlQcDch6zvkPEdCzUvQXdgpRHkgP3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR8MANe0/8f1O98g+xZcQBS7HONZD9i7oUxHbrKdHSNi9yUAR2pTbew5RwHPPEL0tJb8xH9ABpb4vk6hPhiioaaIT1HX21rGquu+CfEOg4hhfN7yckeZdZpw/Drw9k946VPmjiMHWLqEiZyRG4Rpv9H/uWa0M98N2Dc0HA5KXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOlC/biV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOlC/biV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790014876; x=1821550876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=McSJ/+gl6XAaywlQcDch6zvkPEdCzUvQXdgpRHkgP3U=;
  b=WOlC/biVEnRxiDEO9TSKVOPiAJEik4rCdLJAhN0i1De0kI0AsCgW5QGq
   Rf3o8Q35yo+MXGSbdK4ZnwNuwt/SvVzhYpB/tCkMbKQPmKtwKPXZ30Oza
   8oH3q79PVtzeOgYf7bXz477g/NoyqjgzZfotwFrkSh3MEdCZgYrBWHIG/
   u3nHP/qu/0PA0mBeWLfa2QDtTkZnGoMHXj0r4j/KQfu2TH5juE2KuxIEU
   CknZ/giUe/P3nTGrb97nFoJpGFk6DwuVZgNSIEHRutmRsqZidQ4EPwMQn
   9UKSMw2+hW+hugaQGmI/rAR5BUGpW5aBkZ7Cp37rG+ZinLAZp1wLDhIsd
   g==;
X-CSE-ConnectionGUID: Azn5LefgScK8Fv34TfsAtw==
X-CSE-MsgGUID: gjzlwLrsQEeM1YTFwcItGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90426166"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90426166"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 11:21:13 -0700
X-CSE-ConnectionGUID: 5WSv4ngdT8qtBiQOxFPsPA==
X-CSE-MsgGUID: cUwhkWulRu6+G0mDFOi75w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272267064"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 21 Sep 2026 11:21:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	aleksandr.loktionov@intel.com,
	horms@kernel.org
Subject: [PATCH net v4 4/5] ice: rebuild ring stats arrays instead of reallocating them in place
Date: Mon, 21 Sep 2026 11:21:03 -0700
Message-ID: <20260921182106.1015019-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260921182106.1015019-1-anthony.l.nguyen@intel.com>
References: <20260921182106.1015019-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

ice_vsi_realloc_stat_arrays() resized the ring stats arrays in place
with krealloc_array(), sizing them from vsi->req_txq/req_rxq. That is
not what ice_vsi_set_num_qs() computes later in ice_vsi_cfg_def(), so
after a rebuild the arrays could end up shorter than vsi->alloc_txq /
vsi->alloc_rxq, and ice_vsi_alloc_ring_stats() then walked past their
end. Requesting fewer queues than the PF pool can hand out was enough
to trigger it.

Replace it with ice_vsi_resize_stat_arrays(), which allocates a fresh
struct ice_vsi_stats instead, sized with ice_vsi_get_num_qs() and the
queues ice_vsi_decfg() is about to return to the PF pool, which is
exactly what ice_vsi_set_num_qs() will compute once they are back
there. Copy the surviving entry pointers over and install the new
structure, all before ice_vsi_decfg() runs. The entries that did not
fit are freed together with the old container, via
__ice_vsi_free_stats() with @free_entries set to false.

Doing the allocation up front also means the failure path is a plain
unlock and return, with the VSI still fully configured, rather than a
half-torn-down VSI to unwind.

While at it, skip the stats handling for ICE_VSI_CHNL, which has no
entry in pf->vsi_stats[] to begin with.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 118 +++++++++++++----------
 1 file changed, 69 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c6023c11eed3..c6166ff44fc9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2956,6 +2956,51 @@ ice_vsi_rebuild_get_coalesce(struct ice_vsi *vsi,
 	return vsi->num_q_vectors;
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
 /**
  * ice_vsi_rebuild_set_coalesce - set coalesce from earlier saved arrays
  * @vsi: VSI connected with q_vectors
@@ -3042,63 +3087,38 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
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
+ * Return: 0 on success and negative value on failure
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
+	struct ice_vsi_alloc_queues_params qs;
+	struct ice_vsi_stats *old_stat;
+	struct ice_vsi_stats *new_stat;
 	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
-	int i;
 
-	vsi_stat = pf->vsi_stats[vsi->idx];
+	if (vsi->type == ICE_VSI_CHNL)
+		return 0;
 
-	if (req_txq < prev_txq) {
-		for (i = req_txq; i < prev_txq; i++) {
-			if (vsi_stat->tx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
-			}
-		}
-	}
+	qs = ice_vsi_get_num_qs(vsi, vsi->alloc_txq + vsi->num_xdp_txq,
+				vsi->alloc_rxq);
 
-	tx_ring_stats = vsi_stat->tx_ring_stats;
-	vsi_stat->tx_ring_stats =
-		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
-			       sizeof(*vsi_stat->tx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->tx_ring_stats) {
-		vsi_stat->tx_ring_stats = tx_ring_stats;
+	new_stat = ice_vsi_new_stat_arrays(qs.alloc_txq, qs.alloc_rxq);
+	if (!new_stat)
 		return -ENOMEM;
-	}
-	vsi_stat->tx_ring_stats_len = req_txq;
-
-	if (req_rxq < prev_rxq) {
-		for (i = req_rxq; i < prev_rxq; i++) {
-			if (vsi_stat->rx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
-			}
-		}
-	}
 
-	rx_ring_stats = vsi_stat->rx_ring_stats;
-	vsi_stat->rx_ring_stats =
-		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
-			       sizeof(*vsi_stat->rx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->rx_ring_stats) {
-		vsi_stat->rx_ring_stats = rx_ring_stats;
-		return -ENOMEM;
+	old_stat = pf->vsi_stats[vsi->idx];
+	ice_vsi_set_stat_arrays(vsi, new_stat);
+	if (old_stat) {
+		ice_vsi_free_unused_stat_arrays(old_stat, new_stat);
+		__ice_vsi_free_stats(old_stat, false);
 	}
-	vsi_stat->rx_ring_stats_len = req_rxq;
 
 	return 0;
 }
@@ -3130,7 +3150,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 	mutex_lock(&vsi->xdp_state_lock);
 
-	ret = ice_vsi_realloc_stat_arrays(vsi);
+	ret = ice_vsi_resize_stat_arrays(vsi);
 	if (ret)
 		goto unlock;
 
-- 
2.47.1

