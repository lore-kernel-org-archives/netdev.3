Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C96357D0D
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126750; cv=none; b=G2J456wfmAwf7FcghgThpnOhdsFxwSrUzKpKej5wPVB+pGpQag9BnxmGHnVuIj8+jH10ep+if57A32oPkluJi3BAugXdwLkI0fTfrJn605PQe8ZAvWT/yz0/AYiXou1NdLKOE9TuEyPoHVSkMRob1b1NLB2KoFsQGrjRTjuL84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126750; c=relaxed/simple;
	bh=AuaOWD3jGMYAysDk1Aw30zB+BClJT8BRzZUW50HSm5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux6JorCA0ziS1czc6co21P61uQXyEYBG9Afw8pcQ8z4nXGtbLvSRv9FVNQDxush+ysevTyWVzh8oeMBt5jgxn3klGS6S3tymtdZf5p+7YTB08EvpJcMX5VXZ1TTYxPfuqt2dMztmiJi5S8hC6QUzqEetNk/JOEdrlm3LndI3duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVj7zqd9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVj7zqd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789126748; x=1820662748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AuaOWD3jGMYAysDk1Aw30zB+BClJT8BRzZUW50HSm5U=;
  b=aVj7zqd9cIXj7cbpQuHcSTOT8d8GQUphdMrABlOgJrBN3EsZjpKjXYJw
   R5opt3bWBzvKXbzV59+vraEgxsMS1LNOBQA17yafgaLTssDls1NMf3nIS
   iD+qJWhEUJQwVKhEt60J5tYKdTzlf+DZ7bhDQ+KgftXkQjJelZl8/HVWW
   5wmWlkVhtT3CeSALp/Ap3xNNTr/fxcXb0TyL4e9lFhFIdqSsDfzX2zFC0
   tIOjHuE4ZMFpe8wV5tPTXB4+9EMnTnIXRNjPl+I1oZ01xQZieUE1+Fl3D
   VdRY7hnHxLAwOOb5M26kXxp6AjqecAoR1MxzMtn7IixWdAAiZlWBYl1OR
   Q==;
X-CSE-ConnectionGUID: wsh+RDjVSXqNpxaCF07ZBw==
X-CSE-MsgGUID: wFvrX7y8Sqq3p2d5LXnFCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359902"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="112359902"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 04:39:07 -0700
X-CSE-ConnectionGUID: 0lrwuez5Rhm/SZ0o0nLzhQ==
X-CSE-MsgGUID: Qyt2asG6RCmbaOBJYSQfeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270135862"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:04 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B6A9728781;
	Fri, 11 Sep 2026 12:39:02 +0100 (IST)
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
Subject: [PATCH net v3 3/5] ice: extract ice_vsi_get_num_qs()
Date: Fri, 11 Sep 2026 13:26:18 +0200
Message-ID: <20260911113848.44086-4-przemyslaw.kitszel@intel.com>
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
---
 drivers/net/ethernet/intel/ice/ice.h     |  6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c | 86 ++++++++++++++----------
 2 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index cf1b0ba8dc29..48f4312df4a4 100644
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
index 9c2863fc696c..998b9eb6e9fe 100644
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
@@ -180,68 +220,44 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
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
 		 * original vector count
 		 */
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
2.51.1

