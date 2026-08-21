Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237A48D869
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317333; cv=none; b=iD11YyR6sn4g1JF16S/+Q1W8dLmogXsJ6l3N9iZv0Ma2tZ6b1d4x77u6erBHOeb7mlgD2YsMVAnSCjZp5geenuv9JxhsHQbDH4AdII4wz3PYO1dmSAix9go+pbTTwHaKwJvESuYBnkgYQw3HEBas3TPc7VuA/KWXDJUcY1DJQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317333; c=relaxed/simple;
	bh=/Kg4fShpoVUcUgg5AO18lGQL4ky1Jj9dnSBMcNpbOMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqh0uPISDDp77F64Li4sYrZxjPyjO+A0/sH9nPfNN2Mcj6HXKtDOySmnVNS8ofE2CNKbAvXkXM3CEUIqBbdwThDT5cWnPA1PmAL6MLkHOtmx3fhaT9ZIpH4vXecB+pXmJBkMDXip6laM1UT+oSLPNeuscdvpTONhb0MSy/lWCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9tH+Ogv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9tH+Ogv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787317328; x=1818853328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Kg4fShpoVUcUgg5AO18lGQL4ky1Jj9dnSBMcNpbOMg=;
  b=j9tH+Ogv5HJ1E0jLJHm67BQQfy8WgqYICJJ6XKXFGC4lkgk/4qUxWgLC
   M0Y6Kfw6jmq4AeI5nvWQ9TnoZdXgjt9xu+3S+qBziK4qkCQlNiV0KzUqW
   YmxtSRRcLa/E4kN/l++Mr2loLUh05fCWJ3kCMWzkFbzfUtt0RNLjpwGug
   SP9MXEylmECvtSqj/F/HrtEf0ZwEL2SYKLKDkpJrujXyx/3GnYyN2AH13
   36ST5fICczDtgm2qeVd3cuHNWnV29DMC8E7DVv0ySqWyvb3hb8lg7MkMg
   4cpR9JfbDFr9HmfDpn2BFJ19Fn/bGdPM74vsMLo8dTw8oQfTG98zyZDiF
   Q==;
X-CSE-ConnectionGUID: WlEjRK8uStaGpR/b8ytw3A==
X-CSE-MsgGUID: +J9lCq1IRtuuxGWLOvTTgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="75400970"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="75400970"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:02:04 -0700
X-CSE-ConnectionGUID: IcVdrkDdQsWJh7adZEEzag==
X-CSE-MsgGUID: dF42Ex6CRC6dDruG9TFAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271568507"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2026 06:02:02 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2 2/2] i40e: avoid resetting BQL state when freeing temporary Tx rings in set_ringparam
Date: Fri, 21 Aug 2026 15:01:57 +0200
Message-ID: <20260821130157.1451118-3-aleksandr.loktionov@intel.com>
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

Temporary Tx rings built by i40e_set_ringparam() while resizing
descriptor counts are shallow struct copies of the live vsi->tx_rings[]
entries, so they retain the same ring->netdev and ring->queue_index as
the live ring they are staged to replace.

If an error path frees one of these clones with
i40e_free_tx_resources() before i40e_down() has run - either the
i40e_setup_tx_descriptors() failure unwind loop, or the free_tx: error
label - i40e_clean_tx_ring() will call netdev_tx_reset_queue() on
txring_txq(tx_ring), which resolves to the *same* netdev_queue as the
live ring because netdev/queue_index alias. That call resets the
queue's BQL/dql state (dql_reset(): num_queued = num_completed = 0)
while the live ring is still actively transmitting and completing
Tx on that same queue.

The next time the live ring reports completions for bytes that were
queued before the reset, dql_completed() can underflow its own
sanity check and hit:

	BUG_ON(count > num_queued - dql->num_completed);

i.e. a guaranteed kernel panic, not just a warning, given a queue with
outstanding (queued but not yet completed) Tx traffic at the moment
the clone is freed.

Reproduced on real hardware by forcing i40e_setup_tx_descriptors() to
fail partway through building tx_rings[] while flooding real Tx
traffic on the affected queues:

    kernel BUG at lib/dynamic_queue_limits.c:99!
    RIP: 0010:dql_completed+0x285/0x2a0
    Call Trace:
     <IRQ>
     i40e_napi_poll+0x74b/0x1700 [i40e]
     __napi_poll+0x10a/0x200
     net_rx_action+0x2f7/0x380
     handle_softirqs+0xcc/0x270

Confirmed the same trigger no longer panics with this fix applied,
including repeated resize/traffic cycles.

Clear the clone ring netdev before freeing it in both error paths, so
i40e_clean_tx_ring()'s existing `if (!tx_ring->netdev) return;` guard
skips the netdev_tx_reset_queue() call for the clone. This mirrors the
same idiom i40e already uses for XDP Tx rings, which also have no
netdev_queue of their own (ring->netdev = NULL in i40e_vsi_setup_tx()).
Only the temporary, about-to-be-freed clone is touched; the live ring
in vsi->tx_rings[] keeps its netdev.

Fixes: 9f65e15b4f98 ("i40e: Move rings from pointer to array to array of pointers")
Cc: stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2: New patch, split out of the set_ringparam NULL-deref fix (1/2)
    after review pointed out this related but distinct, older,
    pre-existing hazard on the same error path. Trimmed the inline
    comments to one line each.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 6d2b076..0e5b456 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2143,6 +2143,8 @@ static int i40e_set_ringparam(struct net_device *netdev,
 					i--;
 					if (!i40e_active_tx_ring_index(vsi, i))
 						continue;
+					/* not live yet, skip its BQL reset on free */
+					tx_rings[i].netdev = NULL;
 					i40e_free_tx_resources(&tx_rings[i]);
 				}
 				kfree(tx_rings);
@@ -2248,8 +2250,11 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	/* error cleanup if the Rx allocations failed after getting Tx */
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
-			if (i40e_active_tx_ring_index(vsi, i))
-				i40e_free_tx_resources(&tx_rings[i]);
+			if (i40e_active_tx_ring_index(vsi, i)) {
+				/* not live yet, skip its BQL reset on free */
+				tx_rings[i].netdev = NULL;
+				i40e_free_tx_resources(&tx_rings[i]);
+			}
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.52.0
