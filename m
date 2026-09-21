Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5404FC34F
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014878; cv=none; b=Qfd+mdWEpl+Vm0mQmTZ0xFv0NLjdBDTDG/eGd+xWnGWVtDjOITCPXBQBu44VSYIRJxAuSj96pOMK7MnoDHxBAasvWtUIwb9OvTio/D9YBynAp3W/j1hCuuGdpIbrkCqeL/IxZyYSoRK/mMcC4ZKDkuul9hNnElJB8RogAksts6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014878; c=relaxed/simple;
	bh=ELiO/nX16Gh3hed/5XkBUFhG0N4xJa1vroWXREnsbA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Koy6KJBbshb+K9h/eEpgrs+mxJmWWd98f7zTk18eYzMhdG4sgCiZEx2FKUBK8NUkmYqTkU0EOD/4tslkgH9lrl3AsXJCf4WR+Jdx0yNHw+ZADqQBYisTi3yP/uh8BfnmRB5RFdNz/fX5DQt9eHGS9DtUiInTrh4HR6bhDWkwAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuaL4B+J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuaL4B+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790014876; x=1821550876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ELiO/nX16Gh3hed/5XkBUFhG0N4xJa1vroWXREnsbA8=;
  b=JuaL4B+JRpNDMuLiigq+fgN+FwhSMGDZuunHn7uwU98V8eOskUoDpDlu
   tMJwimE0RdS6PfRk5ciynmx/oqAuM3LAftFifkr+fYGoJMtVf6o+weGJJ
   VFn6SiVVg0ztzJRKmXplfy9MCihKV5Lxfs88y24vwCy4//xjicgdY+vuK
   dQW5PcSkLekXGdvND5QKy/wezMRgGzOGZfsA7I2obzfupanGHrZwnnrJQ
   pZrynDs5RL3ZdADndZ067oKOi1LgSrmW660NFy9mm0C5zVjDJD0RHItqA
   wc2lDEoqBh6HNf4O4twp42hCVW6htYz5YlOtPzWm5GqF26tTiIByJDzNW
   Q==;
X-CSE-ConnectionGUID: 74Pg0MiwSHW0M3/78+6ANA==
X-CSE-MsgGUID: sBa9MNlfS5yWrlom/GfURQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90426160"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90426160"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 11:21:13 -0700
X-CSE-ConnectionGUID: sKq1KN6uQQexSmtxClDCEA==
X-CSE-MsgGUID: hguxELPZRUyiAsDBtIQVkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272267061"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 21 Sep 2026 11:21:12 -0700
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
Subject: [PATCH net v4 3/5] ice: extract ice_vsi_get_num_qs()
Date: Mon, 21 Sep 2026 11:21:02 -0700
Message-ID: <20260921182106.1015019-4-anthony.l.nguyen@intel.com>
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

ice_vsi_set_num_qs() mixed two things: deciding how many queues a VSI
gets, and applying all the side effects of that decision. Split the
decision out into ice_vsi_get_num_qs(), returning both counts at once.

To make that possible, group alloc_txq and alloc_rxq in struct ice_vsi
with struct_group_tagged(), which gives the return type without adding
any new storage. Field order changes slightly, num_txq now follows
alloc_rxq, but nothing depends on it.

ice_vsi_get_num_qs() takes @held_txq and @held_rxq from the start, even
though the only caller so far passes zero for both. They let a caller
ask what the counts would be once the queues the VSI currently owns are
back in the PF pool. A later commit adds the caller that needs this: the
rebuild path has to size its ring stats arrays before ice_vsi_decfg()
releases the queues, yet the arrays must match what ice_vsi_set_num_qs()
computes afterwards.

No functional change intended.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c | 86 ++++++++++++++----------
 2 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fadfe94bf1c8..f1ba86d066be 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -403,9 +403,11 @@ struct ice_vsi {
 	u8 rx_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
 	u16 *txq_map;			 /* index in pf->avail_txqs */
 	u16 *rxq_map;			 /* index in pf->avail_rxqs */
-	u16 alloc_txq;			 /* Allocated Tx queues */
+	struct_group_tagged(ice_vsi_alloc_queues_params, alloc_txq_rxq,
+		u16 alloc_txq;		 /* Allocated Tx queues */
+		u16 alloc_rxq;		 /* Allocated Rx queues */
+	);
 	u16 num_txq;			 /* Used Tx queues */
-	u16 alloc_rxq;			 /* Allocated Rx queues */
 	u16 num_rxq;			 /* Used Rx queues */
 	u16 req_txq;			 /* User requested Tx queues */
 	u16 req_rxq;			 /* User requested Rx queues */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 456b524c0c5f..c6023c11eed3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -153,16 +153,56 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 	}
 }
 
-static u16 ice_get_rxq_count(struct ice_pf *pf)
+static u16 ice_get_rxq_count(struct ice_pf *pf, u16 held)
 {
-	return min(ice_get_avail_rxq_count(pf),
-		   netif_get_num_default_rss_queues());
+	return min_t(u16, ice_get_avail_rxq_count(pf) + held,
+		     netif_get_num_default_rss_queues());
 }
 
-static u16 ice_get_txq_count(struct ice_pf *pf)
+static u16 ice_get_txq_count(struct ice_pf *pf, u16 held)
 {
-	return min(ice_get_avail_txq_count(pf),
-		   netif_get_num_default_rss_queues());
+	return min_t(u16, ice_get_avail_txq_count(pf) + held,
+		     netif_get_num_default_rss_queues());
+}
+
+/* @held_txq, @held_rxq: queues the VSI still owns but is about to return to the
+ * PF pool, so that the result matches what it will be once they are back there.
+ */
+static struct ice_vsi_alloc_queues_params
+ice_vsi_get_num_qs(struct ice_vsi *vsi, u16 held_txq, u16 held_rxq)
+{
+	struct ice_vsi_alloc_queues_params qs = {};
+	struct ice_pf *pf = vsi->back;
+
+	switch (vsi->type) {
+	case ICE_VSI_PF:
+		qs.alloc_txq = vsi->req_txq ?: ice_get_txq_count(pf, held_txq);
+
+		/* only 1 Rx queue unless RSS is enabled */
+		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags))
+			qs.alloc_rxq = 1;
+		else
+			qs.alloc_rxq = vsi->req_rxq ?:
+				       ice_get_rxq_count(pf, held_rxq);
+		break;
+	case ICE_VSI_SF:
+	case ICE_VSI_CTRL:
+	case ICE_VSI_LB:
+		qs.alloc_txq = 1;
+		qs.alloc_rxq = 1;
+		break;
+	case ICE_VSI_VF:
+		qs.alloc_txq = vsi->vf->num_req_qs ?: vsi->vf->num_vf_qs;
+		qs.alloc_rxq = qs.alloc_txq;
+		break;
+	case ICE_VSI_CHNL:
+		break;
+	default:
+		dev_warn(ice_pf_to_dev(pf), "Unknown VSI type %d\n", vsi->type);
+		return vsi->alloc_txq_rxq;
+	}
+
+	return qs;
 }
 
 /**
@@ -180,44 +220,27 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 	if (WARN_ON(vsi_type == ICE_VSI_VF && !vf))
 		return;
 
+	vsi->alloc_txq_rxq = ice_vsi_get_num_qs(vsi, 0, 0);
+
 	switch (vsi_type) {
 	case ICE_VSI_PF:
-		if (vsi->req_txq) {
-			vsi->alloc_txq = vsi->req_txq;
+		if (vsi->req_txq)
 			vsi->num_txq = vsi->req_txq;
-		} else {
-			vsi->alloc_txq = ice_get_txq_count(pf);
-		}
+		if (vsi->req_rxq && test_bit(ICE_FLAG_RSS_ENA, pf->flags))
+			vsi->num_rxq = vsi->req_rxq;
 
 		pf->num_lan_tx = vsi->alloc_txq;
-
-		/* only 1 Rx queue unless RSS is enabled */
-		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
-			vsi->alloc_rxq = 1;
-		} else {
-			if (vsi->req_rxq) {
-				vsi->alloc_rxq = vsi->req_rxq;
-				vsi->num_rxq = vsi->req_rxq;
-			} else {
-				vsi->alloc_rxq = ice_get_rxq_count(pf);
-			}
-		}
-
 		pf->num_lan_rx = vsi->alloc_rxq;
 
 		vsi->num_q_vectors = max(vsi->alloc_rxq, vsi->alloc_txq);
 		break;
 	case ICE_VSI_SF:
-		vsi->alloc_txq = 1;
-		vsi->alloc_rxq = 1;
 		vsi->num_q_vectors = 1;
 		vsi->irq_dyn_alloc = true;
 		break;
 	case ICE_VSI_VF:
 		if (vf->num_req_qs)
 			vf->num_vf_qs = vf->num_req_qs;
-		vsi->alloc_txq = vf->num_vf_qs;
-		vsi->alloc_rxq = vf->num_vf_qs;
 		/* pf->vfs.num_msix_per includes (VF miscellaneous vector +
 		 * data queue interrupts). Since vsi->num_q_vectors is number
 		 * of queues vectors, subtract 1 (ICE_NONQ_VECS_VF) from the
@@ -226,22 +249,15 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 		vsi->num_q_vectors = vf->num_msix - ICE_NONQ_VECS_VF;
 		break;
 	case ICE_VSI_CTRL:
-		vsi->alloc_txq = 1;
-		vsi->alloc_rxq = 1;
 		vsi->num_q_vectors = 1;
 		break;
 	case ICE_VSI_CHNL:
-		vsi->alloc_txq = 0;
-		vsi->alloc_rxq = 0;
 		break;
 	case ICE_VSI_LB:
-		vsi->alloc_txq = 1;
-		vsi->alloc_rxq = 1;
 		/* A dummy q_vector, no actual IRQ. */
 		vsi->num_q_vectors = 1;
 		break;
 	default:
-		dev_warn(ice_pf_to_dev(pf), "Unknown VSI type %d\n", vsi_type);
 		break;
 	}
 
-- 
2.47.1

