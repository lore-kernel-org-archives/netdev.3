Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D793ED132;
	Fri, 31 Jul 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496545; cv=none; b=l4tMcJaKtnfuiJyv270f0jioQ4j29675dO8/Fz+llrUoRzatSi5Sl2Y/DrrtIWg70E8O9Vtw7JUuAereMaByXR3MKaFGbLqJK2/nRliNqGZP9uN2QAEutuRvfZueNOz0C1SZs9qxw4vrAloqjSPabIAuSypbahAxiHgmlRhN50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496545; c=relaxed/simple;
	bh=/2m5hcTmtuLW74gAWEjdMx2iJZ4wS4ZFmWTTHM4mwtU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WronzR3MtxK+7DNUWCAnCxM//yzOjHbn1dHmA4eVglSNURPGgg+f6vr4AVW++lohGU5yOjTMqtScflAruG3gVbSnGFBYifb3xMK/G5VK2VPOsABMOsnzIbQfdlPK8iiw1jjAadF1iRTF3bYRwQ2otH7qWeRNaQ5kpteQN3gti2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zNgGlicO; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zNgGlicO"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qaTJiqKj0B/4XarzkFvIQFLZSht/1QQ07TK3EhZ2830=;
	b=zNgGlicOMoZGYJkZAn4opIVkWhwYy8WsPSWX/gZ702+/hnuEoJPl5lFoBPjlPUirWE9dN6h6x
	qpSNbkjn4WAmIcdgbfk/ZlynHn0/NHiGGZOJmHh/D9QU7GtdIm7ZKddJUyAG2xphIdyrVSQ4OtU
	0DGIjLz3KIj+/MxYSqW6pXg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hBNXS5Nyszcb3L;
	Fri, 31 Jul 2026 19:05:44 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id E253E2025F;
	Fri, 31 Jul 2026 19:15:27 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 31 Jul 2026 19:15:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <almasrymina@google.com>,
	<toke@redhat.com>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH v4 net] net: page_pool: fix UAF in __page_pool_release_netmem_dma on xa_cmpxchg race
Date: Fri, 31 Jul 2026 19:15:07 +0800
Message-ID: <20260731111507.2355601-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

page_pool_scrub() iterates pool->dma_mapped via xa_for_each() with no
page ref held. __page_pool_release_netmem_dma() currently reads and
writes netmem fields (dma_addr, DMA index bits in pp_magic) after
xa_cmpxchg() returns. The unref path calls put_page() unconditionally
regardless of the cmpxchg outcome; when it loses the cmpxchg, it still
frees the page before the scrub winner finishes these netmem accesses,
so scrub touches a freed page -- a Use-After-Free.

Fix this by splitting the DMA release into two functions:

1. __page_pool_unmap_netmem_dma() caches dma_addr before xa_cmpxchg(),
   does the cmpxchg to remove the DMA mapping, and calls dma_unmap on
   the cached address. It never touches netmem fields after the cmpxchg,
   making it safe for the scrub path which holds no page ref.

2. __page_pool_release_netmem_dma() wraps the above and additionally
   clears dma_addr and DMA index bits in netmem fields. This is safe
   only when the caller holds a page ref, so it is used by the return
   path (page_pool_return_netmem).

The scrub path calls __page_pool_unmap_netmem_dma() directly; the return
path calls __page_pool_release_netmem_dma().

Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
Suggested-by: Mina Almasry <almasrymina@google.com>
Assisted-by: OhMyOpenCode:GLM-5.2
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v4:
- Restructure per Mina's review: merge page_pool_remove_dma_mapping()
  into __page_pool_unmap_netmem_dma() with dma_unmap inlined via goto
  label; simplify __page_pool_release_netmem_dma() to a thin wrapper.
- Link to v3: https://lore.kernel.org/r/20260729110249.2824835-1-shaojijie@huawei.com

Changes in v3:
- Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
  file convention.
- Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojijie@huawei.com

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
 net/core/page_pool.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 21dc4a9c8714..497bb1906fc3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -500,29 +500,40 @@ static int page_pool_register_dma_index(struct page_pool *pool,
 	return err;
 }
 
-static int page_pool_release_dma_index(struct page_pool *pool,
-				       netmem_ref netmem)
+static void __page_pool_unmap_netmem_dma(struct page_pool *pool,
+					 netmem_ref netmem)
 {
 	struct page *old, *page = netmem_to_page(netmem);
 	unsigned long id;
+	dma_addr_t dma;
+
+	if (!pool->dma_map)
+		return;
+
+	/* Cache dma_addr before xa_cmpxchg. The scrub path holds no page ref;
+	 * the unref path calls put_page() regardless of cmpxchg outcome, so
+	 * after the cmpxchg we cannot safely touch netmem fields.
+	 */
+	dma = page_pool_get_dma_addr_netmem(netmem);
 
 	if (unlikely(!PP_DMA_INDEX_BITS))
-		return 0;
+		goto unmap;
 
 	id = netmem_get_dma_index(netmem);
 	if (!id)
-		return -1;
+		return;
 
 	if (in_softirq())
 		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
 	else
 		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
 	if (old != page)
-		return -1;
-
-	netmem_set_dma_index(netmem, 0);
+		return;
 
-	return 0;
+unmap:
+	dma_unmap_page_attrs(pool->p.dev, dma,
+			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
+			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 }
 
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
@@ -728,24 +739,13 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
 							   netmem_ref netmem)
 {
-	dma_addr_t dma;
-
 	if (!pool->dma_map)
-		/* Always account for inflight pages, even if we didn't
-		 * map them
-		 */
 		return;
 
-	if (page_pool_release_dma_index(pool, netmem))
-		return;
-
-	dma = page_pool_get_dma_addr_netmem(netmem);
-
-	/* When page is unmapped, it cannot be returned to our pool */
-	dma_unmap_page_attrs(pool->p.dev, dma,
-			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
-			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
+	__page_pool_unmap_netmem_dma(pool, netmem);
 	page_pool_set_dma_addr_netmem(netmem, 0);
+	if (likely(PP_DMA_INDEX_BITS))
+		netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -1172,7 +1172,7 @@ static void page_pool_scrub(struct page_pool *pool)
 		}
 
 		xa_for_each(&pool->dma_mapped, id, ptr)
-			__page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
+			__page_pool_unmap_netmem_dma(pool, page_to_netmem((struct page *)ptr));
 	}
 
 	/* No more consumers should exist, but producers could still

base-commit: 2195424c3da2ef1829a63b807e3a900a90e57d85
-- 
2.33.0

