Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C73DEAC4
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965752; cv=none; b=I9A7EvJwtIyU6Z/vu9viYw0PMdfaibh6q5/4dglauWdgzwwJfANbnA/MBxTVdLdt8IJ/ILPrSnfkeWLAl0cCZ0Q6yT/78eKpw7okj9EPFJDHNpufUGa4jzeMJ+govTR/3QvE3QTbOs0vdv3S/P0STRzinOvprQI1QrdTmwuhrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965752; c=relaxed/simple;
	bh=u/keAK1xuk/LXKyifPh5p7An7GvyIMrXAdOZneoHM1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq4rzhk0GP68wxfjO9y0IMBchCCcES8UbqFqeMsci0evZ1fDUZfsTle1A87jR43VgffJ2kxVmTMPB5S32qXN/J/Ayi3muGSOCgA/eCwXrppyXtaRtlJ/IhPkRZ77nLMrlnMXUBYyixdrgoWErRsdYcaUmZ4QiVT1/AA4X+E2z4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APbQXdUx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APbQXdUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965750; x=1817501750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/keAK1xuk/LXKyifPh5p7An7GvyIMrXAdOZneoHM1c=;
  b=APbQXdUxdEpJDUxkk4G4uzst1PU7pbwv7WqkpAGDlkg+sCPLY4I1KlJ4
   HXwyWiMFmC3TZI+I5thkewslepccBZ+2EqWeYOYNZnm29q48iY7gumO45
   hUifaDdH0I/ZOAOxnxeQa2cj1XXjwAo5XT90ZylOha/z1GENnWw0tRuIe
   Ei4S6QbEBjyz7WgyHpwDbX55/G3WwtaLTbH2dTJ/r0yQkPEJn1BZaz0+7
   bGBlkxo1u/Z9pimEF9FwkYtPtDVjd5oTwWayBb3wRBWY1Ht49dy5pSAZx
   6cFk92vwYnNM3Y6+Ffz3S9xyK4LxcURgKYaUVtSnLVrCBEx8yYfrGNTmZ
   g==;
X-CSE-ConnectionGUID: SbroXalDRFypMXiExsoudg==
X-CSE-MsgGUID: 3rLhawtpTEGqOgXhHQP6Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343506"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343506"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:47 -0700
X-CSE-ConnectionGUID: rB8FJvB5TUGHdcaukMcE5w==
X-CSE-MsgGUID: 2AT7e3uTRIi/VPHm7V2L7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576057"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	jramaseu@redhat.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 02/15] ice: always do GCS if hardware supports it
Date: Wed,  5 Aug 2026 14:35:27 -0700
Message-ID: <20260805213541.2281287-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
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
index 31303ab5be17..477c86d8c53b 100644
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

