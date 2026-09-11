Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96B3E49F7;
	Fri, 11 Sep 2026 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094482; cv=none; b=aBBwxplrVF277BQ95qYAuo960AtY02BqkpSqs+UtMlJtWFL9eR/wnlJOd0NoQtKA0K37CpEb9s3FhxCFGmEUWTfrb4SNCmn8vOCqELSnxBKWwE0TPN3UiE9jYGja7z5afH0x6vtJJPjDT9tiy1eFJqiGfbgksSrblSICXvDptic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094482; c=relaxed/simple;
	bh=RpS5lxvIqvCnyCF5vcYKjHed80SBUp0dNIQ0rgcc1dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwUzrvYodzVz18MXyx6BpbmJWmDNDMwINgyKB3CUDWSJ1nJKoSHsdlIin0uRTUL8U9EAg2gbhCM0N7pFmAqZbH71I6cjp6R7cJjxaLPBusZA4WVlZLEddjiTrLFwVhywNqu4KxYvXyCTMxLewMYgU5bolwwzn8qEK7e4cP2JEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCKEos94; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCKEos94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789094480; x=1820630480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RpS5lxvIqvCnyCF5vcYKjHed80SBUp0dNIQ0rgcc1dA=;
  b=UCKEos941qLkpNqeWgl+CqusfmwF2r5xi8uWJAROBeUW1d8P7Lf4G60I
   9rdBU9BiB1VN9BVEbx9LXUGmefxMOnIjA7SIVBRJEoH/DyAggldL/1cf+
   7WAYD6XNW05kgKAQe9+TXxDKkbgKt/UD3Ls8c3QDEpjGq3GpLB2N74wZJ
   TLfCyYU1a/vujsWOnKV4QBo2GYLAS6iHF3JTc6KJqnw5SKQjaAOcP39xj
   shBiv2068PYHO47t4oKCkrYCrWVxqSq3gi2yGuS+6gw9GS1KK3GSY1fXZ
   G/8wbOdbluU5uFaOxvFEb1cLc8A9eDDkduCkG2Fd+JdnNoMQ4DLrsCY6c
   A==;
X-CSE-ConnectionGUID: wSUQV0fETmmT20vYLT0yyg==
X-CSE-MsgGUID: XtQgg8DiRCm+WPQNFffUkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100151354"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="100151354"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 19:41:19 -0700
X-CSE-ConnectionGUID: y/s/pk7YS2a6KV1g9cJQuQ==
X-CSE-MsgGUID: nvZFIjuyTc+nSfkolQcyTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="271326838"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by orviesa008.jf.intel.com with ESMTP; 10 Sep 2026 19:41:16 -0700
From: Kris Pan <kris.pan@intel.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	atomasov@redhat.com,
	oliver.sang@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kris Pan <kris.pan@intel.com>
Subject: [PATCH v2] net: iterate online nodes in skb_defer_free_flush()
Date: Fri, 11 Sep 2026 10:38:04 +0800
Message-ID: <20260911023804.3503989-1-kris.pan@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911020438.3502801-1-kris.pan@intel.com>
References: <20260911020438.3502801-1-kris.pan@intel.com>
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
cold, always-empty per-node lists on every softirq pass, showing up
as skb_defer_free_flush() and _find_next_bit() overhead.

Use for_each_online_node() to iterate only node_online_map.

Loopback UDP throughput in a QEMU guest with 32 possible / 1 online
nodes (bench_udp, 8 senders, 6 interleaved runs) improves by ~5%.

Fixes: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Adrian Tomasov <atomasov@redhat.com>
Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com
Signed-off-by: Kris Pan <kris.pan@intel.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 290e0f099e6bf..b528b6a986fcf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6907,7 +6907,7 @@ static void skb_defer_free_flush(void)
 	struct skb_defer_node *sdn;
 	int node;
 
-	for_each_node(node) {
+	for_each_online_node(node) {
 		sdn = this_cpu_ptr(net_hotdata.skb_defer_nodes) + node;
 
 		if (llist_empty(&sdn->defer_list))
-- 
2.43.0

