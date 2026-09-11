Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456D282F2A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126747; cv=none; b=aE/t4gxCKyKCwyyPQ71Sp4P30thGRgAo9CDVkMvI6xx5cJ5LXp8USn/+aYUnVsk/xWzOMVIsa7qiJ0RnvShDnpXmNcaicyNkDsJQtLpjyU5Xa47VuRrJTKsQtDdWp4OE0Zc8K4rcpVCxF5wbKL+Blq1/aW67DxlxsCCx0nZkBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126747; c=relaxed/simple;
	bh=LLYLDHjuwzMvTr1/Stiz0Wwsjai3Yls5PntYg9C1QHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Plgu65rm5awoErTaz4ACTupCOtQid0JTysCEiXwzv2w28LeJy6xkNIIC5qv56+QBcbBTUM/E/C34xIKhl1MjLET3f7EqtXKBg7bhe9Eb0bWW4VY39GAPk/baE4aggPHCsn9qvt/utV6kcHpYAy7pDXf+iGhX8mweIcIZ71fw7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H566yvg1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H566yvg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789126745; x=1820662745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LLYLDHjuwzMvTr1/Stiz0Wwsjai3Yls5PntYg9C1QHE=;
  b=H566yvg1jJMgz66f7Apij0oSd3PeqnYKwUQXTKloDAftz4s3jBXBp68Q
   g3b2omxTE8MF8gjVXm3X2kYXEJHR5nPrOcriXFSL9EBzGIyoA486sW4Ml
   rwTGwtZqhWJ6cJHfp6+7YDpJT4iguqzQTWKhctMfehsNaM6umdbDThXsR
   xZUMzcXl80E2E85HNYxMKBGNiC9twIx8nd+NNEfTartmdOgrwm4iUmE3Y
   mQiIfkN2eGll9ct39YdGnp0yYb1wmNJnOotiroNn82OKLim+jMs2qE6e8
   qibLUq6XR/kSvRCRxS+KTGpdrTDkcxYZ3wFjPoAWltJ+IhTWZc4tdZ3Dp
   g==;
X-CSE-ConnectionGUID: KazWVllZSBeZ/1OG06r5Tw==
X-CSE-MsgGUID: ZBKZaFfuRb6dfpLiOC64YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359888"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="112359888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 04:39:05 -0700
X-CSE-ConnectionGUID: Lnnl8T9vRIKRqZ4gNhaNOQ==
X-CSE-MsgGUID: iRxC1Hs6TW2Huj+SrRFf5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270135845"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:02 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CF1AE2877B;
	Fri, 11 Sep 2026 12:39:00 +0100 (IST)
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
Subject: [PATCH net v3 1/5] ice: extract __ice_vsi_free_stats()
Date: Fri, 11 Sep 2026 13:26:16 +0200
Message-ID: <20260911113848.44086-2-przemyslaw.kitszel@intel.com>
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

Record the length of each ring stats array in struct ice_vsi_stats, so
that freeing the array entries no longer needs the owning VSI. Keep the
new fields in sync in both places that size the arrays.

With that, the body of ice_vsi_free_stats() becomes independent of the
VSI and can be split out as __ice_vsi_free_stats(). The @free_entries
parameter is always true here; a later commit adds a caller that frees
only the array container, after its entries have been handed over to a
freshly allocated stats structure.

No functional change intended. Just preparation to have easier time
reading subsequent commits.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 52 ++++++++++++++----------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f72bb1aa4067..cf1b0ba8dc29 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -328,6 +328,8 @@ enum ice_vsi_state {
 struct ice_vsi_stats {
 	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array */
 	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array */
+	u16 tx_ring_stats_len;  /* Length of the Tx ring stats array */
+	u16 rx_ring_stats_len;  /* Length of the Rx ring stats array */
 };
 
 /* struct that defines a VSI, associated with a dev */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..cd78c5c69a30 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -330,42 +330,48 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
 	vsi->rxq_map = NULL;
 }
 
+/* free single stats memory */
+static void __ice_vsi_free_stats(struct ice_vsi_stats *vsi_stat, bool free_entries)
+{
+	if (!vsi_stat)
+		return;
+
+	if (free_entries) {
+		for (int i = 0; i < vsi_stat->tx_ring_stats_len; i++) {
+			if (vsi_stat->tx_ring_stats[i]) {
+				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
+				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
+			}
+		}
+		for (int i = 0; i < vsi_stat->rx_ring_stats_len; i++) {
+			if (vsi_stat->rx_ring_stats[i]) {
+				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
+				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
+			}
+		}
+	}
+
+	kfree(vsi_stat->tx_ring_stats);
+	kfree(vsi_stat->rx_ring_stats);
+	kfree(vsi_stat);
+}
+
 /**
  * ice_vsi_free_stats - Free the ring statistics structures
  * @vsi: VSI pointer
  */
 static void ice_vsi_free_stats(struct ice_vsi *vsi)
 {
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
-	int i;
 
 	if (vsi->type == ICE_VSI_CHNL)
 		return;
 	if (!pf->vsi_stats)
 		return;
 
 	vsi_stat = pf->vsi_stats[vsi->idx];
-	if (!vsi_stat)
-		return;
-
-	ice_for_each_alloc_txq(vsi, i) {
-		if (vsi_stat->tx_ring_stats[i]) {
-			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
-			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
-		}
-	}
-
-	ice_for_each_alloc_rxq(vsi, i) {
-		if (vsi_stat->rx_ring_stats[i]) {
-			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
-			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
-		}
-	}
-
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat->rx_ring_stats);
-	kfree(vsi_stat);
+	__ice_vsi_free_stats(vsi_stat, true);
 	pf->vsi_stats[vsi->idx] = NULL;
 }
 
@@ -539,11 +545,13 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
 		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
 	if (!vsi_stat->tx_ring_stats)
 		goto err_alloc_tx;
+	vsi_stat->tx_ring_stats_len = vsi->alloc_txq;
 
 	vsi_stat->rx_ring_stats =
 		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
 	if (!vsi_stat->rx_ring_stats)
 		goto err_alloc_rx;
+	vsi_stat->rx_ring_stats_len = vsi->alloc_rxq;
 
 	pf->vsi_stats[vsi->idx] = vsi_stat;
 
@@ -3048,6 +3056,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		vsi_stat->tx_ring_stats = tx_ring_stats;
 		return -ENOMEM;
 	}
+	vsi_stat->tx_ring_stats_len = req_txq;
 
 	if (req_rxq < prev_rxq) {
 		for (i = req_rxq; i < prev_rxq; i++) {
@@ -3067,6 +3076,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		vsi_stat->rx_ring_stats = rx_ring_stats;
 		return -ENOMEM;
 	}
+	vsi_stat->rx_ring_stats_len = req_rxq;
 
 	return 0;
 }
-- 
2.51.1

