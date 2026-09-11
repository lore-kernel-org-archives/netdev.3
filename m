Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99035CB7F;
	Fri, 11 Sep 2026 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092477; cv=none; b=JbGpeqvqOWQPKKGIHPtwzABjNWu9vcHzsmOQm9sLBWfybtP5Voam5pAgSXnfDgEZoTvWOSI9/uw8Cjlbd/VgULO22ER9n3FadUrVRQLYwMUdKHhJZXDgVG7qTdZM1xLWBgUe1PeXXCMvGUadvcRWhCInxKqu0e3I5Zz+JUr//vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092477; c=relaxed/simple;
	bh=5ZSezPgL8RvDa829HOfJft8+065d7PRQjPG2zmtL3I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lU1NL9x7xuo/GNrbkfneoPO8zqfOH2bvU3R4tW79EHvFstRnp8chC0DslEw90XQx7nOGnoTwy/ArBh2xd6b5ad6/OFgam3JeI0HMsj1/gBxM83TxHfkaIelvIQ1wVVnXpUTDSzU3Q3JX3t/u32QT33f+nh3N3bociXAByURTpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNaBou1t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNaBou1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789092475; x=1820628475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ZSezPgL8RvDa829HOfJft8+065d7PRQjPG2zmtL3I8=;
  b=HNaBou1tt4RDDx8i2cQ4TDEr9yyrt47Si/WU5G3IVfUgTdZZH94jQIzl
   9GcIbDPP2Rfu661wqdElej3e3nw7uelZwtQMrOEebuNedUdRzuNakFL+L
   ryc/c7CD1YpNggKJtxtfhOHuN1WnG94YZguPs33gkRTVeOZy8YZCUkzS4
   S7V2EJoGt7TKLdr+IndpNKCEmGHThUHXwxtJm0oqewh+2ExWP55SIhbT1
   +FEEzJ8hiQkTFn+O4hIaQinJD+wcApjFFrf6K/YftHJxVgbMCkSOz9REb
   bDPntIJEMtyijrwPdsQbnSIZ25N0UYfLhK4Om/T1iFcWqVb5yfu5xdiRX
   A==;
X-CSE-ConnectionGUID: ygw3Ht9hSw6Vn+w6FA+sRw==
X-CSE-MsgGUID: 4Pp7+BXCRJGzOZxkDiSojg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88697692"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="88697692"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 19:07:52 -0700
X-CSE-ConnectionGUID: g1ydOlmIRbOuoRSY/CyTUw==
X-CSE-MsgGUID: UGIvXrs0Qb2L0QxuMT5TBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="265595484"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by fmviesa009.fm.intel.com with ESMTP; 10 Sep 2026 19:07:50 -0700
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
Subject: [PATCH] net: iterate online nodes in skb_defer_free_flush()
Date: Fri, 11 Sep 2026 10:04:38 +0800
Message-ID: <20260911020438.3502801-1-kris.pan@intel.com>
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
cold, always-empty per-node lists on every softirq pass, showing up
as skb_defer_free_flush() and _find_next_bit() overhead.

Use for_each_online_node() to iterate only node_online_map.

Loopback UDP throughput in a QEMU guest with 32 possible / 1 online
nodes (bench_udp, 8 senders, 6 interleaved runs) improves by ~5%.

Fixes: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com
Signed-off-by: Kris Pan <kris.pan@intel.com>
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

