Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9E44AB97
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342832; cv=none; b=DDp06Zzv9NTCmUyXyFCr61r+YU7l/AB+sUtQnAq+lizZWjRpSXEN1oq6wqSN66SR/RhcnKrMxzy/GhHKq7M53lHcb3j6p5HcI2KoptVc93tQbPLDbORCuyYzEYmEOCsgumz8P/xlHs51pGHbE1k7Tk3Pkj7v2hbaLhLntotJT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342832; c=relaxed/simple;
	bh=LEzCYFgeUadabV2t5Leusuxox4hmHs2CPHTpzz+dv30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGIr+vRVk5hCXHO8lkcB9xWdeQgftm+3Gcs7q4iF7MyLz5YtjblvQO580mms2U3KnQReKdiVvTXMjREMRl89D9a9HZay0JPC4lkYUgz46F/HtR9esTj7PaNiHrEr8yeD6V7FRE3PEunXG9ybahJQVbTRJBaETayItK7+GcE0UJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEeD6C5G; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEeD6C5G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790342829; x=1821878829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEzCYFgeUadabV2t5Leusuxox4hmHs2CPHTpzz+dv30=;
  b=TEeD6C5GENeXzsaHrtENfz/hWXsxCR/wCJXm8wrnGEE9yh+KvYDoVu+U
   P+5eOEsEtFJoFJnAvdzOeaUnkOvbwTGMLO1wwPOH1VTDLc+uXWkPHSZoJ
   bYsGYplRND+JWskjSEoWWlXqd+JKxXYeR2RbwLj12IaGMuSEGKop83nTT
   eovUDxFBYdwug//IB+uucLG7i/w8A8EEDE7U3jZzgkun9/NqBHbZ880fB
   dWkhcnIzfq55OqoRz4JHvh7TQ6BoBXOK47qUVcmZzxkeJ+3rrl3Yj7xNl
   Ebk7cNKe9qLPJvlBYMj6K9ezyp+sRgOEkHB5exoWOjvOGJTtOzQaq9Q3J
   g==;
X-CSE-ConnectionGUID: YdMbGPzJSEWeFRVQ0O/UCg==
X-CSE-MsgGUID: oZpHX7mJSIWUgKQe140sAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508268"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="107508268"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:27:00 -0700
X-CSE-ConnectionGUID: oE33mZCQSbabuJp1YmSrsA==
X-CSE-MsgGUID: zXKMwclCTKWdfc/3rOTslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="282414743"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:56 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1916E2FC57;
	Fri, 25 Sep 2026 14:26:55 +0100 (IST)
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
Subject: [PATCH net v5 4/6] ice: extract ice_vsi_get_num_qs()
Date: Fri, 25 Sep 2026 15:15:46 +0200
Message-ID: <20260925132636.123300-5-przemyslaw.kitszel@intel.com>
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

While reshaping the whole body, drop the kernel-doc line promising a
return value; ice_vsi_set_num_qs() returns void.

No functional change intended.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
 - drop the stale "Return 0 on success and a negative value on error"
   from the kernel-doc of the void ice_vsi_set_num_qs() (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice.h     |  6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c | 88 ++++++++++++++----------
 2 files changed, 55 insertions(+), 39 deletions(-)

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
index ed32ae2667c5..134984077d5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -153,23 +153,61 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
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
  * ice_vsi_set_num_qs - Set number of queues, descriptors and vectors for a VSI
  * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
  */
 static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 {
@@ -180,68 +218,44 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
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

