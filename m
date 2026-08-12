Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92583E2ADF
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568867; cv=none; b=kWaaKx8lQ8ZafhMZKF+ekXDxZ4u5sCowG7VvM9bhoAKqJe8X72WUKcECSDrftKjk1ibXlMek1lroD/fI0r7ZLsemFqsCNwR0EO+2NXUm1mqq4hWnpT8PMvWGx73adIySESF34/IJm8Jyl9B6W1oEN1bkiu1tvKwZd8LpPsvOWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568867; c=relaxed/simple;
	bh=j7qqvd/8ANOEEngPSMsev/0PS8oYI9qn0PvPif1zqzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt19IzyBqfPUxBtA9cS86Cl1PX603/ImrMKb1OFx4Da3eSQVQS/UwjJzFj9LRj0KuBoUbAfLWjXjO3/be6sntxXMA/JPM04tM5Y3t0u0y9yL63YmtoH3VJZ1bqQs2SR9BPse3/VsVOH5o/cI9HelhqGOlJQXK+77Ph1db34Pb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaybwssT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaybwssT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786568866; x=1818104866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j7qqvd/8ANOEEngPSMsev/0PS8oYI9qn0PvPif1zqzk=;
  b=XaybwssTmW+lZKVDRrbqDOcBzZG8zHLQHwTWSSNr539BMT0YCgbAl+dD
   cmMSCTNOn99m668KDlycwP2V/pe+t7/QTOOLZZWlKMT6oys06Sl4jz4yj
   //ItmMpZAGcRw8U3rRNO7ACsDJLg6zLdaYXu9RMSI53LGg1d1dStYlZcw
   M+FBlcjO6c9l08AXJL63fSGqMQK37xHyjN8qgQ9ashdK8EuCXaK5BLgRZ
   CxmWHoTrtOYLmgOKKOStF1KSiTtuwQJMS+6X1yLSPjSpo2vWMU1T4lLcf
   eAzsmN1AZBFYjvFBhTTDRsFA5WQNRDvaoZpRUMjmYuIPuoebbBWycM+x8
   A==;
X-CSE-ConnectionGUID: Si+pZnY4TEKNYH74Iu1OQA==
X-CSE-MsgGUID: 0P7+6Zb9SDqQIzSUipmKAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98652109"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="98652109"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:07:45 -0700
X-CSE-ConnectionGUID: LfF6yiwjRFKzh0SCDQnjkA==
X-CSE-MsgGUID: 6qCxCW7ATaGnDpyLcyvzAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="261985765"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Aug 2026 14:07:42 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2AC30332A6;
	Wed, 12 Aug 2026 22:07:41 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/2] ice: move ice_vsi_realloc_stat_arrays() up
Date: Wed, 12 Aug 2026 22:18:05 +0200
Message-ID: <20260812204619.32253-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
References: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ice_vsi_realloc_stat_arrays() up, to allow calling it from
ice_vsi_cfg_def() by the next commit.

Fix kdoc for touched code. One line break removed, "int i" scope
minimized to the loop, no changes otherwise.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
changelog:
add collected tags from IWL's v3
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 119 +++++++++++------------
 1 file changed, 59 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..e48ee5940f17 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2303,6 +2303,65 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
 	return 0;
 }
 
+/**
+ * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
+ * @vsi: VSI pointer
+ * Return: 0 on success or -ENOMEM on allocation failure.
+ */
+static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
+{
+	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
+	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
+	struct ice_ring_stats **tx_ring_stats;
+	struct ice_ring_stats **rx_ring_stats;
+	struct ice_vsi_stats *vsi_stat;
+	struct ice_pf *pf = vsi->back;
+	u16 prev_txq = vsi->alloc_txq;
+	u16 prev_rxq = vsi->alloc_rxq;
+
+	vsi_stat = pf->vsi_stats[vsi->idx];
+
+	if (req_txq < prev_txq) {
+		for (int i = req_txq; i < prev_txq; i++) {
+			if (vsi_stat->tx_ring_stats[i]) {
+				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
+				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
+			}
+		}
+	}
+
+	tx_ring_stats = vsi_stat->tx_ring_stats;
+	vsi_stat->tx_ring_stats =
+		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
+			       sizeof(*vsi_stat->tx_ring_stats),
+			       GFP_KERNEL | __GFP_ZERO);
+	if (!vsi_stat->tx_ring_stats) {
+		vsi_stat->tx_ring_stats = tx_ring_stats;
+		return -ENOMEM;
+	}
+
+	if (req_rxq < prev_rxq) {
+		for (int i = req_rxq; i < prev_rxq; i++) {
+			if (vsi_stat->rx_ring_stats[i]) {
+				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
+				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
+			}
+		}
+	}
+
+	rx_ring_stats = vsi_stat->rx_ring_stats;
+	vsi_stat->rx_ring_stats =
+		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
+			       sizeof(*vsi_stat->rx_ring_stats),
+			       GFP_KERNEL | __GFP_ZERO);
+	if (!vsi_stat->rx_ring_stats) {
+		vsi_stat->rx_ring_stats = rx_ring_stats;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /**
  * ice_vsi_cfg_def - configure default VSI based on the type
  * @vsi: pointer to VSI
@@ -3011,66 +3070,6 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 	}
 }
 
-/**
- * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
- * @vsi: VSI pointer
- */
-static int
-ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
-{
-	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
-	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
-	struct ice_ring_stats **tx_ring_stats;
-	struct ice_ring_stats **rx_ring_stats;
-	struct ice_vsi_stats *vsi_stat;
-	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
-	int i;
-
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
-
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
-
-	return 0;
-}
-
 /**
  * ice_vsi_rebuild - Rebuild VSI after reset
  * @vsi: VSI to be rebuild
-- 
2.54.0

