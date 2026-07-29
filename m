Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B33542F6;
	Wed, 29 Jul 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323008; cv=none; b=Lsv8Rlw7DXHjqGkBaVHEiGC7UjCNbWgXeSSpOgFinYYpZHMoEI7IK5miI3I9BpyGJxDqrZGc85EP+GK5LnjTNB87Q46URcqPZP2wvLlxJrhL2li0BtMYDctpu7+Hdz8KVhN8OBozXpzUpYoRII9c+QxJFTaHESDxDdJHjBk2jPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323008; c=relaxed/simple;
	bh=Rt3ezGDOBlLSUsS+6ibqaXgdJ7z4xEy7osFMIs1rthM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aRMuoReIYES5ldKpsKl0/Q6jz31QUzb/b2bqgeLTNf9SGFNP62U8jrbWwcsQTmTeQF+X2JTsyOcXy0k+X/lApB2rSSr3DJ3d5Q4hpMcskFMatqdyYafKoBQB03Fp2dgZ/CQuJoRBptpLh1uRRJcPfvlOuJyA1d8IEp5xy5PNePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BRMYbiGj; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BRMYbiGj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=emcos6P6WLr6/6ENLqPExL3/ApJpTtn6sqMRB4UGTfU=;
	b=BRMYbiGjPMOLkXVNN/K+dSaMHASGI5u4xWQu8KhZWdqswSOmN2ri+kFcJlvB0KQ3FgLIMnljk
	5eYP3ha6/H89EmOh8H7FcRWSeE9ZD9nour1gtavRXfqiRFgBi0n3SYP5gbO7zIlywTXKp4YAuw1
	0GwHxK1IOfj+Ib6bLPMHI9k=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h98Mc1nQSzmV91;
	Wed, 29 Jul 2026 18:53:48 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7591840586;
	Wed, 29 Jul 2026 19:03:15 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 29 Jul 2026 19:03:14 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <almasrymina@google.com>,
	<toke@redhat.com>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH v3 net] net: page_pool: fix UAF in __page_pool_release_netmem_dma on xa_cmpxchg race
Date: Wed, 29 Jul 2026 19:02:49 +0800
Message-ID: <20260729110249.2824835-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500018.china.huawei.com (7.202.195.199)

page_pool_scrub() iterates pool->dma_mapped via xa_for_each() with no
page ref held. __page_pool_release_netmem_dma() currently reads and
writes netmem fields (dma_addr, DMA index bits in pp_magic) after
xa_cmpxchg() returns. The unref path calls put_page() unconditionally
regardless of the cmpxchg outcome; when it loses the cmpxchg, it still
frees the page before the scrub winner finishes these netmem accesses,
so scrub touches a freed page -- a Use-After-Free.

Fix this by:

1. Cache dma_addr to a local variable before xa_cmpxchg() in
   __page_pool_release_netmem_dma(), so the scrub winner uses the
   cached address for dma_unmap and never touches netmem fields after
   the cmpxchg.

2. Rename page_pool_release_dma_index() to page_pool_remove_dma_mapping()
   and strip it down to a pure cmpxchg wrapper; it no longer clears DMA
   index bits.

3. Move dma_addr and DMA index cleanup to page_pool_return_netmem(),
   which holds a page ref and can safely write netmem fields regardless
   of the cmpxchg outcome.

The scrub path (no ref) only does cmpxchg + dma_unmap on the cached
address; the unref path (holds ref) clears dma_addr and DMA index bits
unconditionally before put_page().

Suggested-by: Mina Almasry <almasrymina@google.com>
Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
Assisted-by: OhMyOpenCode:GLM-5.2
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v3:
- Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
  file convention.
Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojijie@huawei.com

Changes in v2:
- Redesign the fix per Mina's review: v1's unconditional
  netmem_set_dma_index() introduced a UAF when the scrub path
  (no page ref) writes to a page freed by the unref path.
- Cache dma_addr before xa_cmpxchg; move dma_addr/DMA index
  cleanup to page_pool_return_netmem() which holds a page ref.
- Rename page_pool_release_dma_index() to
  page_pool_remove_dma_mapping() to reflect its new role as a
  pure cmpxchg wrapper.
- Link to v1: https://lore.kernel.org/r/20260724092135.414699-1-shaojijie@huawei.com
---
 net/core/page_pool.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 21dc4a9c8714..b7f5cdb6c1c4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -500,8 +500,8 @@ static int page_pool_register_dma_index(struct page_pool *pool,
 	return err;
 }
 
-static int page_pool_release_dma_index(struct page_pool *pool,
-				       netmem_ref netmem)
+static int page_pool_remove_dma_mapping(struct page_pool *pool,
+					netmem_ref netmem)
 {
 	struct page *old, *page = netmem_to_page(netmem);
 	unsigned long id;
@@ -517,12 +517,7 @@ static int page_pool_release_dma_index(struct page_pool *pool,
 		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
 	else
 		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
-	if (old != page)
-		return -1;
-
-	netmem_set_dma_index(netmem, 0);
-
-	return 0;
+	return (old == page) ? 0 : -1;
 }
 
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
@@ -736,16 +731,19 @@ static __always_inline void __page_pool_release_netmem_dma(struct page_pool *poo
 		 */
 		return;
 
-	if (page_pool_release_dma_index(pool, netmem))
-		return;
-
+	/* Cache dma_addr before xa_cmpxchg. The scrub path holds no page ref;
+	 * the unref path calls put_page() regardless of cmpxchg outcome, so
+	 * after the cmpxchg we cannot safely touch netmem fields.
+	 */
 	dma = page_pool_get_dma_addr_netmem(netmem);
 
+	if (page_pool_remove_dma_mapping(pool, netmem))
+		return;
+
 	/* When page is unmapped, it cannot be returned to our pool */
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
-	page_pool_set_dma_addr_netmem(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -759,10 +757,17 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 	bool put;
 
 	put = true;
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops) {
 		put = pool->mp_ops->release_netmem(pool, netmem);
-	else
+	} else {
 		__page_pool_release_netmem_dma(pool, netmem);
+		/* clear dma_addr/DMA index; safe because we hold a ref */
+		if (pool->dma_map) {
+			page_pool_set_dma_addr_netmem(netmem, 0);
+			if (likely(PP_DMA_INDEX_BITS))
+				netmem_set_dma_index(netmem, 0);
+		}
+	}
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.

base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.33.0

