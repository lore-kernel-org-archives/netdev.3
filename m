Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F126FA60;
	Wed, 16 Sep 2026 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519066; cv=none; b=QqzE9k2rU1Q2dM0fiD3s6CSS3CynFL75BxMauW6OPQUHZT0AlLLRcvp62t7cZ0X2C1wa8buxIJipG0FZ5lLR/GbdbmUiPXEVH0C7C+E7cXY1w9HOq+VcmEe2tenK8gtL/kz0gyxHr1x2drHdSlcAkyLic5t8mgVbjKf89z7C0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519066; c=relaxed/simple;
	bh=DtVYUA/vYJIivPuXrZGBtVMOp3omOx7ZxIZlX+85/uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8JK6++RK+Afptgan4PMfNrep3uz2Tfi+dz6K06LFyI+0bQAvai/8MPdu1oPCn2nnk8KUS0EOHfWTua6Q4uxHGtBM5sDB6WpMZRhsDr83x7b51/Ja2yZEnOf29ky6CtniYAoobpJg8WcwqTs+FYGxGEhxhN/nVVY/e5lXRc6TpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8/+wIab; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8/+wIab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789519064; x=1821055064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DtVYUA/vYJIivPuXrZGBtVMOp3omOx7ZxIZlX+85/uk=;
  b=b8/+wIabVkbnu2sJ8K3DMqsSan33a3HWsK7Qpr7KTVdtA3QZNIhEuzuK
   Zuv7fbgdLHL0Sy3zmpGa6n3xvEvh1NMc3zWtoZ34E3HWVozo6L7DsPk4V
   +ps61NvjoWIYOi8l573cKWgexUy/OQ4hiekFwb09rmRSwK50xFUG8Xfzi
   f2BLiRrL3wmzk/g3h2c5TuAH468DFm7ZSGJi0OZYrzo4Kjxx1nFan2k88
   osrl4/RyfFlt2LcpkHaf0M1vby5xJH5ygxahwt7bVg5IVb4MGgkab2Wu1
   QU/PsvnNdCyZ/Lg8jbiKHN6E310peote8/35IQcmQ8lHo2Hk+5ZRu9owm
   A==;
X-CSE-ConnectionGUID: kaS2K0DiRoST8/9biesJVQ==
X-CSE-MsgGUID: G+j+g3ZeQImXDnNUomkjgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89765849"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89765849"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:37:43 -0700
X-CSE-ConnectionGUID: YDHxOXJXR4G0wTwtU+16hA==
X-CSE-MsgGUID: 6JHzmVFGTNqWl/g3qaRE9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="278414208"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by fmviesa005.fm.intel.com with ESMTP; 15 Sep 2026 17:37:41 -0700
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
Subject: [PATCH net v3] net: iterate online nodes in skb_defer_free_flush()
Date: Wed, 16 Sep 2026 08:34:30 +0800
Message-ID: <20260916003430.3612956-1-kris.pan@intel.com>
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

Use for_each_online_node() to iterate only node_online_map.

Since the flush now skips offline nodes, also drain the per-node
lists in dev_cpu_dead().  A skb is queued on the alloc CPU's list at
the freeing CPU's node index; if that node is offlined before the
alloc CPU flushes, the skb is stranded.  Likewise, skbs queued on a
CPU that later goes offline are never freed, since its softirq no
longer runs.

Loopback UDP throughput in a QEMU guest with 32 possible / 1 online
nodes (bench_udp, 8 senders, interleaved runs) improves by ~5%.

Fixes: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Adrian Tomasov <atomasov@redhat.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com
Signed-off-by: Kris Pan <kris.pan@intel.com>
---
 net/core/dev.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ecfbd72d5d1a4..896498b349500 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6907,7 +6907,7 @@ static void skb_defer_free_flush(void)
 	struct skb_defer_node *sdn;
 	int node;
 
-	for_each_node(node) {
+	for_each_online_node(node) {
 		sdn = this_cpu_ptr(net_hotdata.skb_defer_nodes) + node;
 
 		if (llist_empty(&sdn->defer_list))
@@ -12895,9 +12895,12 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 static int dev_cpu_dead(unsigned int oldcpu)
 {
 	struct sk_buff **list_skb;
-	struct sk_buff *skb;
+	struct llist_node *free_list;
+	struct sk_buff *skb, *next;
+	struct skb_defer_node *sdn;
 	unsigned int cpu;
 	struct softnet_data *sd, *oldsd, *remsd = NULL;
+	int node;
 
 	local_irq_disable();
 	cpu = smp_processor_id();
@@ -12957,6 +12960,26 @@ static int dev_cpu_dead(unsigned int oldcpu)
 		rps_input_queue_head_incr(oldsd);
 	}
 
+	/* Drain skbs deferred to the offlining CPU: its softirq no longer
+	 * runs, so skb_defer_free_flush() would never free them.  Also drain
+	 * skbs deferred to this CPU's node, which may leave node_online_map
+	 * and thus be skipped by the for_each_online_node() loop in
+	 * skb_defer_free_flush().
+	 */
+	for_each_node(node) {
+		sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, oldcpu) + node;
+		free_list = llist_del_all(&sdn->defer_list);
+		llist_for_each_entry_safe(skb, next, free_list, ll_node)
+			dev_consume_skb_any(skb);
+	}
+	node = cpu_to_node(oldcpu);
+	for_each_online_cpu(cpu) {
+		sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + node;
+		free_list = llist_del_all(&sdn->defer_list);
+		llist_for_each_entry_safe(skb, next, free_list, ll_node)
+			dev_consume_skb_any(skb);
+	}
+
 	return 0;
 }
 
-- 
2.43.0

