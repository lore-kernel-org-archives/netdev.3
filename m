Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B412138F935
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314429; cv=none; b=oykyEAMP2q0l+3RIOc+Cnbu+Lv5E72tAJqu43pWt6dVLLjzQ4nkuhRUU+vEgfAhySt5m3Pc1/Fc3MHIu0DHTmKvwrGOlC4ludb5xIjm7H6xXq5rGqbJBWFNm8ta/Qr2vyM2ZH8U68ykcBvjXZ0qrk2t9l3K90wMIJ6Xm6b02ZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314429; c=relaxed/simple;
	bh=WFRR788yIIpEyKH7mZWh7r1K+EhUZ5aMsHDmf731YUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USlmFfmcTv/ytklYg3GDnDoyS078ICt59mEk591pgzDmKRIerD6NmwYQvWk7pFUbu+Pe1xdZj/6dLJaKdx8wmFnwPipJOlo3Xz5H8ZMx4p6DK8qZoALUwf2BSb9wNSmK7l7JKc+BuSiUX8LQcK3IBuClQarUukomSIDo/jgGQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRNNHhw3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRNNHhw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314428; x=1815850428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFRR788yIIpEyKH7mZWh7r1K+EhUZ5aMsHDmf731YUw=;
  b=dRNNHhw36k99nheYOX6cpeZKJfUt+uhEXkJHwE2XXB9zN3+nWZ5SSX6A
   lKJgAaoDTStWJ4kJrIWhUjtkhRe4ztfpjaNFezacon6HeQWzVGQFrgej5
   DGI9KRTlrCGpdPv2hxangdUSO6U8xF6x1P9vdfN7AQY3DfNbyGbIEpaS3
   mP0RS+4szCiA/UAWdeehVAvbUeCnHPEGC202hjCaLpQxTSKDY1pes3aWm
   eg/CBZhnK6vuvM0GaxWe9qkg+pRxGseqYevdTBNKi/3euKQ7HnB3CGkfC
   F8Zm0CHDIiGFfgGe5Jyts/iuW6itj9GrJpXvtFKtBkE9H2zZhpP8O6PyI
   Q==;
X-CSE-ConnectionGUID: X/7k+wupT6SpfWs9TxUQqg==
X-CSE-MsgGUID: 9wB6IV9aTH6Eh7xoeGrDsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347604"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347604"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:46 -0700
X-CSE-ConnectionGUID: 8sXGT5FNTo2tQJX1IX01rA==
X-CSE-MsgGUID: x6FDsoAjQViw50vaACvcIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827232"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	jramaseu@redhat.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 04/13] ice: always do GCS if hardware supports it
Date: Fri, 17 Jul 2026 11:53:26 -0700
Message-ID: <20260717185340.3595286-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

There is no need to check for NETIF_HW_CSUM. If the code reach
calculating checksum it means that correct checksum flags are set,
because kernel is checking that when setting ip->summed.

Instead of netdev feature flag use Tx ring flag to check if the hardware
can use special descriptor for checksum calculating.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++++
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..fc9d4e0fa755 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1415,6 +1415,10 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, ring->flags);
 		else
 			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG1, ring->flags);
+
+		if (ice_is_feature_supported(pf, ICE_F_GCS))
+			set_bit(ICE_TX_RING_FLAGS_GCS, ring->flags);
+
 		WRITE_ONCE(vsi->tx_rings[i], ring);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index c04c5856dad6..b2063a54d6d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1739,7 +1739,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	l3_len = l4.hdr - ip.hdr;
 	offset |= (l3_len / 4) << ICE_TX_DESC_LEN_IPLEN_S;
 
-	if ((tx_ring->netdev->features & NETIF_F_HW_CSUM) &&
+	if (test_bit(ICE_TX_RING_FLAGS_GCS, tx_ring->flags) &&
 	    !(first->tx_flags & ICE_TX_FLAGS_TSO) &&
 	    !skb_csum_is_sctp(skb)) {
 		/* Set GCS */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 5e517f219379..15dbd5100912 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -217,6 +217,7 @@ enum ice_tx_ring_flags {
 	ICE_TX_RING_FLAGS_VLAN_L2TAG1,
 	ICE_TX_RING_FLAGS_VLAN_L2TAG2,
 	ICE_TX_RING_FLAGS_TXTIME,
+	ICE_TX_RING_FLAGS_GCS,
 	ICE_TX_RING_FLAGS_NBITS,
 };
 
-- 
2.47.1

