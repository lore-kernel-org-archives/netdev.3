Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD03472061
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342839; cv=none; b=kb9OEQL1oulNP5JWIiVUwTcHi/wlNfVHS2kUH4ky7l/mLSj7GBibUV5BL/t7lHXbtkfCJ9jfFqVSP+sbIomy7FcGqYSmty+OrLeZfhgQp2eeK+CAWlaxpNV8lyuZSQeXvf8fT9X72vUTl3U9sAC+dgWSgwh3nstYa2Fi48Xu1BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342839; c=relaxed/simple;
	bh=h+ue+vc6ZyDuBSyrcnvHI2NC8aUuThBba84HNiRQPVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLQYraR01bUGbm+0aABrNgKR1PQH+YA+OdR2NAO63VLn/D60fIY6Zab4LKV69V5WglUHKXgmlhcogGXpIH0mt77eTMGhRdxnmeImO5lYVPTGyrQle/OX9F0lhTgHTFk1nENvkaIijAkcqxB+MSQGMOSa0ibpwzSWuvO9U0CZ/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArKTeOta; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArKTeOta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790342829; x=1821878829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h+ue+vc6ZyDuBSyrcnvHI2NC8aUuThBba84HNiRQPVI=;
  b=ArKTeOtaCovtErZVJ9m1dwgUKZ9eBXDV5TKHoznZ4pBZlsmzgSWNEn/u
   p9zBZavtKXGKY7/DsDXEMe5AvafyFxWO2UXllO+ahQfU9nGgUuAXUtaY8
   qhmYE1UECYJ4TPdvPkIME02dQYfgH9i2DyA34IooF0ENaIS/6Im5v/g1M
   +0DNLSn/lYRBQPLktSmHix/3k/9Ab56ncw0Dt1yopkIfGq7NeqrDi4RF3
   UKJT36/vBBKvw9jgDv8W9JWHFJP57Fp8o4kZaFg/vEXJiH2j+B1hEwyYc
   eV6+CQ7UBZqRjNpS+nKiNCBkdp6HFRHCzdjIrSmkDfQqvJIsooT81gOOb
   Q==;
X-CSE-ConnectionGUID: uMVT5mudTRahRJyHHGM5ww==
X-CSE-MsgGUID: 2m264uNGQz2IFnPvbszWuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508261"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="107508261"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:26:58 -0700
X-CSE-ConnectionGUID: hZgSwvmgRSabT3jqnqkNGA==
X-CSE-MsgGUID: 9MJ2x+c/SWSRYlw3NGeScA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="282414705"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:55 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1CE882FC56;
	Fri, 25 Sep 2026 14:26:54 +0100 (IST)
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
Subject: [PATCH net v5 3/6] ice: extract ice_vsi_new_stat_arrays()
Date: Fri, 25 Sep 2026 15:15:45 +0200
Message-ID: <20260925132636.123300-4-przemyslaw.kitszel@intel.com>
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

Split the allocation of a struct ice_vsi_stats and its two ring stats
arrays out of ice_vsi_alloc_stat_arrays(), which is left with just the
lookup and the store into pf->vsi_stats[].

The sole caller keeps passing the very same queue counts as before,
vsi->alloc_txq and vsi->alloc_rxq. A later commit adds a second caller
in the rebuild path, which cannot use vsi->alloc_* because it has to
size the arrays before the VSI is reconfigured.

Note that the error path no longer clears pf->vsi_stats[vsi->idx]; the
early return above guarantees it is already NULL.

No functional change intended.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 47 +++++++++++++-----------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1414127d32cd..ed32ae2667c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -519,6 +519,30 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int rxq)
+{
+	struct ice_ring_stats **tx_ring_stats;
+	struct ice_ring_stats **rx_ring_stats;
+	struct ice_vsi_stats *vsi_stat;
+
+	vsi_stat = kzalloc_obj(*vsi_stat);
+	tx_ring_stats = kzalloc_objs(*tx_ring_stats, txq);
+	rx_ring_stats = kzalloc_objs(*rx_ring_stats, rxq);
+	if (!vsi_stat || !tx_ring_stats || !rx_ring_stats) {
+		kfree(vsi_stat);
+		kfree(tx_ring_stats);
+		kfree(rx_ring_stats);
+		return NULL;
+	}
+
+	vsi_stat->tx_ring_stats = tx_ring_stats;
+	vsi_stat->rx_ring_stats = rx_ring_stats;
+	vsi_stat->tx_ring_stats_len = txq;
+	vsi_stat->rx_ring_stats_len = rxq;
+
+	return vsi_stat;
+}
+
 /**
  * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
  * @vsi: VSI pointer
@@ -537,33 +561,12 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
 	/* realloc will happen in rebuild path */
 		return 0;
 
-	vsi_stat = kzalloc_obj(*vsi_stat);
+	vsi_stat = ice_vsi_new_stat_arrays(vsi->alloc_txq, vsi->alloc_rxq);
 	if (!vsi_stat)
 		return -ENOMEM;
 
-	vsi_stat->tx_ring_stats =
-		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
-	if (!vsi_stat->tx_ring_stats)
-		goto err_alloc_tx;
-	vsi_stat->tx_ring_stats_len = vsi->alloc_txq;
-
-	vsi_stat->rx_ring_stats =
-		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
-	if (!vsi_stat->rx_ring_stats)
-		goto err_alloc_rx;
-	vsi_stat->rx_ring_stats_len = vsi->alloc_rxq;
-
 	pf->vsi_stats[vsi->idx] = vsi_stat;
-
 	return 0;
-
-err_alloc_rx:
-	kfree(vsi_stat->rx_ring_stats);
-err_alloc_tx:
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat);
-	pf->vsi_stats[vsi->idx] = NULL;
-	return -ENOMEM;
 }
 
 /**
-- 
2.51.1

