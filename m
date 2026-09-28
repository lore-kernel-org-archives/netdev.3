Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72636194C;
	Mon, 28 Sep 2026 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560223; cv=none; b=Of7KFBHpB8AVyJbGS8UF9MRv56iDGozI+lmXaGPolP6OaMCZMdLPF2OR3mj+HrqX8no/xQpNoX54knZ++lKvh+ifttYokQsG/q1WXXRRarrf2aVn/JGbQedWd6PDkaHMX07WXB6MiAHM5pWSb6EnXn/Wy0BrTYRGZGoKtoeedeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560223; c=relaxed/simple;
	bh=jPF6GWwPpqMHR2e/0rkB/E1sLSmxzcdgG8z7Tdyu79k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMsT+D7BZ3mo/QBtUESKfiI0XF2K6uEd3mlrb8q/MKcYytc1s9mIFc0EY2QohiU4xeY3MnTwstOwB9XqDWq7T72nQH9eOa/pHE7e/oAPMbjXMyHF+M2Sm43fck4rmqWKbOAFyz34sGuMAPUH36ONHrgLSmrZpHAtJ/gmLODEKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e65gIvrw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e65gIvrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790560222; x=1822096222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jPF6GWwPpqMHR2e/0rkB/E1sLSmxzcdgG8z7Tdyu79k=;
  b=e65gIvrwgBsmwsAutUuO00GytD969nx13ALmetwVHiarCHHe9Ve/QPDp
   74BBFdkbLeIHyKhetlcF4HrDMEq5DLE0YV9jfG1Diwkahgb1zhoUaU/LZ
   RoRvfCSUCuxVxAF5ZrRccDEQ0lLLT/0MTM83hqYQmrL2jLOpvQtWZV94V
   OWcjLGrlZHxubej+YY9GxFi8omxjZ/ZME7S6a/FUpOXLDtPfxtkpCujMY
   Xf5z2FdfKyD1i2gWtHp07+3VUJcR82Cl1pzsIg+cSD8Y2HykgVcq2TgL/
   xKGRxvyTOMwIOod04OrY60gCY+2fa2/xSkj+nyu6phQCIpHljaxBggRMC
   g==;
X-CSE-ConnectionGUID: A7FDUBCCQSqKzKgty7sTRQ==
X-CSE-MsgGUID: kSGVuqNmQGKmdLcTeDiLlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101823440"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101823440"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 18:50:21 -0700
X-CSE-ConnectionGUID: kaShKSaXTu+iHshTOi0MFA==
X-CSE-MsgGUID: hjoB8snsSQqQVpjOxOOHnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="301187851"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by fmviesa002.fm.intel.com with ESMTP; 27 Sep 2026 18:50:16 -0700
From: Kris Pan <kris.pan@intel.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	atomasov@redhat.com,
	oliver.sang@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kris Pan <kris.pan@intel.com>
Subject: [PATCH net-next] net: iterate online nodes in skb_defer_free_flush()
Date: Mon, 28 Sep 2026 09:47:08 +0800
Message-ID: <20260928014708.3903028-1-kris.pan@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_attempt_defer_free() only queues skbs on the current CPU's node
(numa_node_id() of a running CPU), which is always online, so the
flush loop never needs to visit nodes that are merely possible.

for_each_node() walks node_possible_map.  On machines where the
possible map is much larger than the online map -- e.g. a POWER10
LPAR with 32 possible but 1 online node -- the flush loop touches 31
cold, always-empty per-node lists on every softirq pass.

Use for_each_online_node() to iterate only node_online_map.  Nodes
that go offline are drained by dev_cpu_dead() ("net: flush
skb_defer_nodes in dev_cpu_dead()"), so the flush no longer needs to
visit offline nodes.

Loopback UDP throughput in a QEMU guest with 32 possible / 1 online
nodes (bench_udp, 8 senders, interleaved runs) improves by ~5%.

Fixes: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Adrian Tomasov <atomasov@redhat.com>
Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com
Signed-off-by: Kris Pan <kris.pan@intel.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0dbc..807640155e649 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6927,7 +6927,7 @@ static void skb_defer_free_flush(void)
 	struct skb_defer_node *sdn;
 	int node;
 
-	for_each_node(node) {
+	for_each_online_node(node) {
 		sdn = this_cpu_ptr(net_hotdata.skb_defer_nodes) + node;
 		__skb_defer_free_flush(sdn, 1);
 	}
-- 
2.43.0

