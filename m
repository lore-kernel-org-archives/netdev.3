Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7B2C15AB
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317328; cv=none; b=S14oWZv92oSRDtEgrIXc7eG74z/OW4U/0dEcczA7U8ecJNUgpWp13EQx1xoUwNRzdiexPGjdfn5jpnQ7IaM3MS6rSIbEMuDxlOLDO9ENfijLnObp5286iN8koSz4TtPPQluXTYgZ9sKU4f3tvXRbz6f1aLQHpH8KMfsO5EL5vkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317328; c=relaxed/simple;
	bh=JKIcziNhAUpSVSzm0+hRdhTzDAr9AXuGrCwRbtKX0qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8/K001BeGGK+XuRAHKcoUyEiPWULV4VncQBCcSPcXxI7GzZsB4ogOcGCF75XOqepH+PMSEIUDGjAmGaIJV2t/spfd/ikoFqhJ7ssgmxAcoQvX6JNs/wJHRDpBchSj6Pm49RV9iq3ucxZqHoUbdEaDJxEkMv1EUqmkLzid3igq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRYVqec/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRYVqec/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787317325; x=1818853325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JKIcziNhAUpSVSzm0+hRdhTzDAr9AXuGrCwRbtKX0qo=;
  b=SRYVqec/4/llLduGdpudxo/gqFW8MeyYBCAIFX8164ggabq60WPgxQ1z
   yi5+rYJBsy1+d0l8XD3vHjB8vRN3R2WptvV5PFwYKu5p4ZPWc8jVJ+Hzv
   bdmSkfvMc1Wk8cF5RJj8FuMtoRAIkIwU7xjdb+z5iWUkc1YjrpKfXto5G
   ac4oT04du2xVvPKGmBjMe2mp3tcZovRQ1R0A/KJXsfPIm3gxyos/W2W+h
   ZI19TP56aqYPgeo0qM9luJFIpwo+r6+syNg5IP2B9yIWAtXWDOkCJPum1
   YunfJ91/PSeEe3vS2OIUaiVbwiYdAcne4oGA2/KfPYyjUKef5KyRTPYiD
   A==;
X-CSE-ConnectionGUID: 0R3DqsoOTESlQMO1i7Ck2g==
X-CSE-MsgGUID: nc74/adgS4+z0ydzzqO1BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="75400966"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="75400966"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:02:02 -0700
X-CSE-ConnectionGUID: vAvfO6yqToSF0Yjs1CIUiw==
X-CSE-MsgGUID: A+qg4UzYTOCt/UC7J9vj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271568496"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2026 06:02:00 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2 1/2] i40e: fix set_ringparam error path freeing live Tx rings
Date: Fri, 21 Aug 2026 15:01:56 +0200
Message-ID: <20260821130157.1451118-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
References: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The free_tx: error label in i40e_set_ringparam() is supposed to release
the temporary tx_rings[] array built before i40e_down() is called.
Instead it passes vsi->tx_rings[i] to i40e_free_tx_resources() - a
pointer to the live, NAPI-active ring - rather than &tx_rings[i].

i40e_free_tx_resources() unconditionally NULLs out ring->desc and
ring->tx_bi.  Because i40e_down() has not run at this point, NAPI is
still scheduled and the next i40e_clean_tx_irq() call hits a NULL
descriptor pointer:

    BUG: unable to handle page fault for address: 0000000000002000
    RIP: i40e_napi_poll (i40e_txrx.c:942 i40e_txrx.c:2769)
    RAX: 0000000000000000  RBX: ffff8d0a53ea9800

The trigger is ethtool -G with a TX descriptor count change (so
tx_rings[] is allocated) followed by i40e_alloc_rx_buffers() returning
failure, e.g. under memory pressure.

Pass &tx_rings[i] instead so the temporary rings' DMA descriptors and
software buffer arrays are freed, leaving the live VSI rings intact.

Reproduced on real hardware (XL710/XXV710) by forcing the Rx alloc
failure deterministically instead of relying on real memory pressure;
confirmed the box hangs without this fix and runs clean with it,
including repeated ring resizes and normal (non-error) resize paths.

Verified via git blame that commit 74608d17fe29 ("i40e: add support
for XDP_TX action") introduced the incorrect vsi->tx_rings[i] pointer
at this call site.

Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
Cc: stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2: No functional change to the fix itself. During review, a related
    but distinct pre-existing hazard was pointed out: freeing a
    temporary tx_rings[] clone with i40e_free_tx_resources() also
    resets BQL/dql state for the live queue it was cloned from
    (i40e_clean_tx_ring() -> netdev_tx_reset_queue()), since the
    clone keeps the same ring->netdev/queue_index. That hazard
    predates this bug (Fixes: 9f65e15b4f98, 2013) and is also
    reachable from the i40e_setup_tx_descriptors() failure path
    that this patch does not touch, so it is fixed separately in
    patch 2/2 of this series rather than folded in here.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3da9ec4..6d2b076 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
 			if (i40e_active_tx_ring_index(vsi, i))
-				i40e_free_tx_resources(vsi->tx_rings[i]);
+				i40e_free_tx_resources(&tx_rings[i]);
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.52.0
