Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506840EBB6
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272964; cv=none; b=Lz8ChIfFIC383r1K/Z+E5HqOCC7l40M+NoqorQUVdCxss1LAdw0DKxqDDlCqtkNYG1CRtnofUst8VKZnzzBtdXXh/njpxnTitJbSSt4/vLgRR24evYYt+uPQv75ej+U35+uHlxJbY+AQAI3ZY8Zz61uE2vUOV/qiTgaRNEwGUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272964; c=relaxed/simple;
	bh=mrsu0jKBIYvNRuCU+xpi63km6urdHuCHRLfZ60oX2zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f73Bv0uhx7O7Ea065kGquMQC3Jy4ONRJi8KoTiNeswiWGbIcJOlNC4eaP7KhpeCoh9d5UXpBH9vANud99hoL8IGGJz9HKovDuyWBFdxVyE1na37gVU10FaaVUsF5bLv+eIrx//oQHiYVEZF1bKdj7ZX97x7+hg1SzbI1wRY/mP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3W8ZE0s; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3W8ZE0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272964; x=1816808964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mrsu0jKBIYvNRuCU+xpi63km6urdHuCHRLfZ60oX2zQ=;
  b=R3W8ZE0sc/k0UsmZ/fmlULuXseRbUJQbqMiHQVTY+8QfTEN64bEGZnIU
   wm/H5FEZpSB4sKXz7+zSMm1fzvxXUmoMFhvi+8gunaO+L29F/jMedZq8P
   5tKzLWUrBD6plXYYSam7TtKFDFClWL1Yk9PB3M6efHxLJjH89w75VS/42
   2lDxifeNpy89rMXPUnyNpeZTKiet82TL4XxjzBHmoIDvtVRu3pjCobseE
   Z/+5xwBBkfWNUYjTpyoqLiHX9YwJ79xj7rXKBpkY17ZUN5ib7VwSNkoND
   f2c8hRhNj1sYSguMP7rp8670od8ZlX6c+YmzO2F7d2WCEXag5tFtpZdpC
   w==;
X-CSE-ConnectionGUID: XUL6MWbRT8mmPmnPiE44Qw==
X-CSE-MsgGUID: amhTYGWJSMeKITmUWcD2mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85885010"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85885010"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:18 -0700
X-CSE-ConnectionGUID: IrmX02ESRcaAAcMHw53tlQ==
X-CSE-MsgGUID: zdqzYUFZSsinkfsIpx3R8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558943"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	brianvv@google.com,
	lrizzo@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 02/10] idpf: adjust TxQ ring count minimum
Date: Tue, 28 Jul 2026 14:08:59 -0700
Message-ID: <20260728210909.3042004-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
References: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

Set the TxQ ring count minimum to 128 descriptors. Any lower than this,
and the queue will stall and trigger Tx timeouts in flow based
scheduling mode. This is because next_to_clean might never be updated.

In flow based scheduling mode, next_to_clean is only updated after a
descriptor completion is processed, i.e. after the RE bit is set in the
last descriptor of a Tx packet. This will never happen with a ring size
of 64 and an IDPF_TX_SPLITQ_RE_MIN_GAP of 64. No matter what the value
of last_re is initialized/set to, the calculated gap will be at most 63
and never trigger the RE bit.

Even a ring size of 96 does not solve this. Because of how infrequent
next_to_clean is updated and how small the ring is, IDPF_DESC_UNUSED
will be much smaller on average. This increases the chance the queue
will be stopped because a multi-descriptor packet, e.g. a large LSO
packet, does not see enough resources on the ring. In this case, the
queue will trigger the stop logic. The queue permanently stalls because
there is no chance for a descriptor completion to update next_to_clean
since it is dependent on a packet being sent.

Fixes: 5f417d551324 ("idpf: replace flow scheduling buffer ring with buffer pool")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 7f9056404f64..c724d429a7aa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3097,10 +3097,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
-		/* Set the RE bit to periodically "clean" the descriptor ring.
-		 * MIN_GAP is set to MIN_RING size to ensure it will be set at
-		 * least once each time around the ring.
-		 */
+		/* Set the RE bit periodically to "clean" the descriptor ring */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
 			tx_q->txq_grp->num_completions_pending++;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..908dfa28674e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -21,7 +21,7 @@
 /* Mailbox Queue */
 #define IDPF_MAX_MBXQ				1
 
-#define IDPF_MIN_TXQ_DESC			64
+#define IDPF_MIN_TXQ_DESC			128
 #define IDPF_MIN_RXQ_DESC			64
 #define IDPF_MIN_TXQ_COMPLQ_DESC		256
 #define IDPF_MAX_QIDS				256
-- 
2.47.1

