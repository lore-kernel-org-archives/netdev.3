Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129CC43D4F7
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126750; cv=none; b=DWj2tBwsDAv0+mww667ajwu7cLGjPDTty4H/ynlrqdKeCzTUcAuJV281ShhOqhbqbWvhh7EDdy/7j0DbcYPwEV+TvvjuHsKiARNiCLapqugMTW8SE90/QnZMP7fRI2JFbaj/5Dd/bX4BoEuOBlVZrVCMSVeq/2J4NQB8T39S56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126750; c=relaxed/simple;
	bh=JTi74+5ytxAlM7eF7gR+vF9lG/giPNoL2rgqGMy0XEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdU4EQV3UEPFNWVkU6tJohr+mZddtW4+4aTBo9zePivG9J1bBdM5kxyCMLNMWBCAFQs72uj6hXwM7x/CPmB3J5BU1tjfNl7jN7KNAtZnFHQO790pZjAPUmOGvh+WAgmtmjy6+xBAl9z2f9ccI0DaiUhmhw5D0A3GRXAzn3GjVNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaaoLaiz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaaoLaiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789126749; x=1820662749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JTi74+5ytxAlM7eF7gR+vF9lG/giPNoL2rgqGMy0XEo=;
  b=CaaoLaiztcrhSq2JTBnv7FG4oy8J9kmibBZo9REBLm9BjWFk7JdizYX0
   MTURKXHpaA5WTv2et83ZAKHxRwmJ8iJCZrtz5VrtE1pLrJ5PLMYmeujkD
   YcAE1SZtNTcrPF6mWjf0soPYk2d3Din8zROz3Gk6nsqpnDqEnVdRlxCot
   6O+NeZ5wzbwwTh4VFyTwpeYZDlwNuNmKrW47KMqdx4saILWnwzpqCeAKd
   OV/NLY9mRe8cwcFnhC/jrI+mPhWpCz661iH0FWXfyPZcCAtG41H5sgPUt
   9Xy1mQb/H5Ovn5TEb4SPrL3y4o1Vych+Vfe/F2PuuKzT2hh5hSQJv+58v
   w==;
X-CSE-ConnectionGUID: 0v5Q3zmiStmtqxKVxSKQGg==
X-CSE-MsgGUID: LXptDHjwRtm55XD771tJww==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359915"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="112359915"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 04:39:08 -0700
X-CSE-ConnectionGUID: YPzREYnhQUO6lhZMRxk8Zg==
X-CSE-MsgGUID: 955cymw8TfqdgKwOWtKumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270135867"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:05 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9AD202877E;
	Fri, 11 Sep 2026 12:39:03 +0100 (IST)
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
Subject: [PATCH net v3 4/5] ice: rebuild ring stats arrays instead of reallocating them in place
Date: Fri, 11 Sep 2026 13:26:19 +0200
Message-ID: <20260911113848.44086-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
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
---
this is an actual fix/improvement, that removes some of the tech debt,
but there is no Fixes tag, as this was not directly caused by an user
observable bug, rather as a pre-work / ai-review resolution for the next
commit
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 118 +++++++++++++----------
 1 file changed, 69 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 998b9eb6e9fe..0cd54af40c37 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2953,6 +2953,51 @@ ice_vsi_rebuild_get_coalesce(struct ice_vsi *vsi,
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
@@ -3039,63 +3084,38 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
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
+ * Returns 0 on success and negative value on failure
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
+	old_stat = pf->vsi_stats[vsi->idx];
+	ice_vsi_set_stat_arrays(vsi, new_stat);
+	if (old_stat) {
+		ice_vsi_free_unused_stat_arrays(old_stat, new_stat);
+		__ice_vsi_free_stats(old_stat, false);
 	}
-	vsi_stat->rx_ring_stats_len = req_rxq;
 
 	return 0;
 }
@@ -3127,7 +3147,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 	mutex_lock(&vsi->xdp_state_lock);
 
-	ret = ice_vsi_realloc_stat_arrays(vsi);
+	ret = ice_vsi_resize_stat_arrays(vsi);
 	if (ret)
 		goto unlock;
 
-- 
2.51.1

