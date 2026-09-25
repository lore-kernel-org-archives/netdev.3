Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429346D2CF
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342828; cv=none; b=SV4qN5shOClDOjb6aSiMB3O6oxRUAd/VhABuTwnB13Jgquvla2/ttun0fxXAfUHSMGHAxZLyiidVuwFD08qMqBAuo5aOygw4lv4IHB7kdloayLzIJXXjSNRk2Pn/zIsdE2/JwxRB59hyk0/BX1ZFZ0PdrCcUCWinL/VkaaYNk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342828; c=relaxed/simple;
	bh=x2wwEbPVie6CMsrf1xJi1pIqXQS+S3mYG3w++bGGjHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqLhhwa7oN8WAqt6NoVP7mthvuRx+4kWidDTdob8eI+agJ29R8VrhTaHqNaIfrY/PLa/kGuCdXDI0P93jYkiUrGpSE7nju+ZPToACVD2MxjusASpgQkrrmWM1y7pywN1jJ/Ug0dodroUV599sM3xXYFkL6csfyar648s8eNPrv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRGYoY89; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRGYoY89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790342824; x=1821878824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x2wwEbPVie6CMsrf1xJi1pIqXQS+S3mYG3w++bGGjHU=;
  b=GRGYoY891B2zCKWtg3HrdCRKKWrNK9G5OMkl4LPfAc/GCDut5tQ98ZbN
   /fOagHlJKkrtcOuN35A1ehs8mtuja9YrbIfCkUr+X5W0VQd4hHaMZ9rOV
   /Eq2FJjN0zSK4XVXsFjDnEEhAa0oe5NHmnYndn03ucxV4eJ8AAOR0woj1
   mVpXeGJ3IWLKGeL3UexTR9iwycHSkToM9hVxohUWcSA8NUEDhrem8QDzP
   p8hJn+PK1Llfkrg6ftAb6Mk7UzxYAFt1W9gHoGLv8TDtQLHMtbiJ/5Q9P
   EyW1C1fVwS6r/RDBJOtM+ON2vUat92PZOKB4Z0h6ukeRpLyn8JF3+GER9
   w==;
X-CSE-ConnectionGUID: 70S3heONS6KRp5SWHzBZsQ==
X-CSE-MsgGUID: qN2EUCQvT5GGyUSHMB5zLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508255"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="107508255"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:26:58 -0700
X-CSE-ConnectionGUID: kt8f7c0mRNOUJqYFHMmuPg==
X-CSE-MsgGUID: cHXg2R/fQAGgV3VM1fr8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="282414690"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:54 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1DE9E2FC55;
	Fri, 25 Sep 2026 14:26:53 +0100 (IST)
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
Subject: [PATCH net v5 2/6] ice: extract __ice_vsi_free_stats()
Date: Fri, 25 Sep 2026 15:15:44 +0200
Message-ID: <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
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

Record the length of each ring stats array in struct ice_vsi_stats, so
that freeing the array entries no longer needs the owning VSI. Keep the
new fields in sync in both places that size the arrays.

With that, the body of ice_vsi_free_stats() becomes independent of the
VSI and can be split out as __ice_vsi_free_stats(). The @free_entries
parameter is always true here; a later commit adds a caller that frees
only the array container, after its entries have been handed over to a
freshly allocated stats structure.

The free path now stops at the recorded length instead of the VSI queue
count, so it follows the real allocation rather than a number that can
disagree with it. Sizing still does not: "ice: rebuild ring stats arrays
instead of reallocating them in place" starts using the lengths to carry
entries over, and only "ice: size ring stats arrays from the final queue
count" makes them authoritative for the allocation path.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
 - drop the "no functional change intended" claim, the bound of the free
   loop changes owner here (Clashiko)
 - state that the recorded lengths govern only the free path at this
   point in the series (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 52 ++++++++++++++----------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c..fadfe94bf1c8 100644
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
index 31af378aa0e7..1414127d32cd 100644
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
 
@@ -3055,6 +3063,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		vsi_stat->tx_ring_stats = tx_ring_stats;
 		return -ENOMEM;
 	}
+	vsi_stat->tx_ring_stats_len = req_txq;
 
 	if (req_rxq < prev_rxq) {
 		for (i = req_rxq; i < prev_rxq; i++) {
@@ -3074,6 +3083,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		vsi_stat->rx_ring_stats = rx_ring_stats;
 		return -ENOMEM;
 	}
+	vsi_stat->rx_ring_stats_len = req_rxq;
 
 	return 0;
 }
-- 
2.51.1

