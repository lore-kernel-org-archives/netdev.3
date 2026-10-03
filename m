Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8A497B7C
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062604; cv=none; b=fTxJnoPRn83q8I/NUwVPo78vSDTI6Plnoj/VXVViIjZNr6urXmcGmS358MdM0mAzbrcwe60ene40ggn84gzj7NL3Ewgz/ZI8v1Wy7TluaDez/92zHuAG3R6xFF5ECvpc7ZH/NRB0PaTb9P+XEZqz6hrlTDu6A9EXry8rhIBgJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062604; c=relaxed/simple;
	bh=jMV8cgJDxEPGY0Ge+j+1w7LUuIYbV6z8Yuhe0nrl7DE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kt2gCTRhZO1GwS3HgzTE6yGyDZR4HuMlbtWOZvtZC0IvUt70Erf3NKxukf/dVHVYlb8978xV8CFNlyoqLzt/HUPE519I7+6loL96fy7T121PwM9qlEv3aaEyefIt0aHACobwyjnWkJ/9hp83PgTu772GE2JCwYMvDtDdDQlzuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cn8SRU/x; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cn8SRU/x"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2939083cefso89451366b.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062596; x=1791667396; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G22V7xnwxmYg316SURjvKl+D8LO21QtdPNHOpoX1sic=;
        b=Cn8SRU/xm1dqOPfB6LgCbfsdhBUdSh5MbGSYzTi3LpDdjQE3faU5P4qBe8RomnyzJz
         mV38fAA7aqXAS+QQfWzpFdFVWl0F/xEb2AvVnCeySAWtVeaqcgvSJqp7v7d0aA/wdO6p
         JzrhIF31m/mxmziflAfqIR8QjbVkP1nmTLfHb1DIN7uS1TWekh7d3FvwhS3vj3Dl9IOA
         E5TILJl3Q9yC6Kefhk4aOfOR59BtilkP/PyhKWTKUhma0VIGuQ5MHzz/qrFhcauxN1XD
         Bj+M7vb2J0oyhvIMjC+vzHF+szUVITT0GnLwYcP8vzxuJBWukPE1gChn2KqnoLU5EbYh
         8TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062596; x=1791667396;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G22V7xnwxmYg316SURjvKl+D8LO21QtdPNHOpoX1sic=;
        b=d7gajh8hfLoHQ5HC9889JsT9H5DO/z3pVn8DPwyex0G9rJXo7Uivnk4WafrqSW0Xgw
         FR3GYUCoAgHBVYmD51nqcdZnBKta3ZOazY0f79lLS1zUDm2seDop+D2tPtaFRxaOU8Hj
         I7n7eYjd2lJaw+WB6eGEzsuJ+MoG/jrnLu9DZyXzhGMRchKxlhLwABXGBHVKuQLc9onB
         tr8IfPmaDj458bz3b+KWYx6SYRvQw8x6QRSDwYcX9yK3k8Nxia+J7f5A8+dgBBvcUnXB
         0kCGXZi3At032cjxI4SUPyXmSN62hBBIVWHMmuuIoSgzwxIR24YAWEvGMQVmkTEEmsOE
         YMLQ==
X-Forwarded-Encrypted: i=1; AKwUvBz11/xBdaz4IsjRvOGLsyjEXldMTwHQStdfLCIL4oHN/k5wBsd7ET/A2jQPjwKopBsfSzwWLPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBEbVUtYPuRKtpYbR0OEk2sLOK+RdbBwBuA0mIQsfhP0JZ0NpP
	j3OSy9ySEMGDkbJr0ydakqjX5LRQvz5XobzrOubtSQW4gyxjgkIfheKeLRo2HIsoCC/nPINoka8
	0aJWhzA==
X-Received: from edrm21.prod.google.com ([2002:aa7:d355:0:b0:6ae:152a:a437])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:350a:b0:6ac:6318:ab1e
 with SMTP id 4fb4d7f45d1cf-6af9e334a3bmr5072182a12.24.1791062595665; Sat, 03
 Oct 2026 14:23:15 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:41 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-23-lrizzo@google.com>
Subject: [RFC: DMA_PMD 22/22] iommu/dma: Add DMA_PMD statistics and debugfs
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

DMA_PMD pools fail silently. dma_pmd_pool_alloc() returns NULL for four
distinct reasons - allocation backoff, the global DMA_PMD page ceiling, an
PMD_ORDER allocation failure, and a split_page_compound() rejection - and
every caller quietly falls back to a plain page, so a pool that has
stopped pooling looks exactly like one that is working. The map path is no
better: a buffer can be mapped individually because the domain has no
usable IOVA window, because the domain has no 2MB page size, or because
the PMD_ORDER page mapping itself failed, and none of that was observable
either. The only symptom is a throughput loss with no counter to point at.

Add a counter for each of those cases plus the number of 2M page mappings
established and dropped, and export them, along with the existing per-pool
statistics, through /sys/kernel/debug/dma_pmd/pools.

The new counters are atomic64_t rather than being folded into the existing
lock-protected statistics because their update sites cannot take
pool->lock: dma_pmd_add_page() runs outside it, and the map slow path
holds p2m->map_lock, so taking pool->lock there would invert the order
against dma_pmd_domain_release().

Also emit a one-shot warning on the first PMD_ORDER allocation failure.
That request carries __GFP_NOWARN, so the page allocator says nothing, and
this is the one failure mode that is worth a line in dmesg rather than a
counter somebody has to know to look at.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/dma-pmd-map.c  |  16 +++-
 drivers/iommu/dma-pmd-pool.c | 143 ++++++++++++++++++++++++++++++++---
 drivers/iommu/dma-pmd-priv.h |  43 ++++++++++-
 3 files changed, 186 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/dma-pmd-map.c b/drivers/iommu/dma-pmd-map.c
index 76cb5d01cb1e8..46c6ab5c1b7de 100644
--- a/drivers/iommu/dma-pmd-map.c
+++ b/drivers/iommu/dma-pmd-map.c
@@ -468,8 +468,13 @@ dma_addr_t dma_pmd_dma_map_phys(struct device *dev, struct iommu_domain *domain,
 		else
 			ret = dma_pmd_window_assign(dev, domain, win);
 
-		if (ret)
+		if (ret) {
+			if (ret == -EOPNOTSUPP)
+				atomic64_inc(&meta->pool->fallback_nopool);
+			else
+				atomic64_inc(&meta->pool->fallback_nowindow);
 			return DMA_MAPPING_ERROR;
+		}
 		win_size = READ_ONCE(win->size);
 	}
 
@@ -482,8 +487,10 @@ dma_addr_t dma_pmd_dma_map_phys(struct device *dev, struct iommu_domain *domain,
 	 * device mask.
 	 */
 	if (unlikely(iova - win->base + size > win_size ||
-		     iova + size - 1 > min_not_zero(dma_mask, dev->bus_dma_limit)))
+		     iova + size - 1 > min_not_zero(dma_mask, dev->bus_dma_limit))) {
+		atomic64_inc(&meta->pool->fallback_nowindow);
 		return DMA_MAPPING_ERROR;
+	}
 
 	domain_idx = win->domain_idx - DMA_PMD_IDX_FIRST;
 	if (likely(test_bit(domain_idx, &meta->domains_mapped)))
@@ -510,12 +517,15 @@ dma_addr_t dma_pmd_dma_map_phys(struct device *dev, struct iommu_domain *domain,
 			 */
 			smp_mb__before_atomic();
 			set_bit(domain_idx, &meta->domains_mapped);
+			atomic64_inc(&meta->pool->pmd_map_cnt);
 		}
 	}
 	spin_unlock_irqrestore(&meta->map_lock, flags);
 
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		atomic64_inc(&meta->pool->fallback_maperr);
 		return DMA_MAPPING_ERROR;
+	}
 
 	return iova;
 }
diff --git a/drivers/iommu/dma-pmd-pool.c b/drivers/iommu/dma-pmd-pool.c
index d48c8e19741ab..a85aa550b500c 100644
--- a/drivers/iommu/dma-pmd-pool.c
+++ b/drivers/iommu/dma-pmd-pool.c
@@ -682,16 +682,21 @@ unsigned int dma_pmd_pools_forget_domain(int idx)
 
 	mutex_lock(&dma_pmd_pools_lock);
 	list_for_each_entry(pool, &dma_pmd_pools, node) {
+		unsigned int n = 0;
+
 		spin_lock_irqsave(&pool->lock, flags);
 		list_for_each_entry(meta, &pool->partial, list)
-			dropped += dma_pmd_forget_domain(meta, idx);
+			n += dma_pmd_forget_domain(meta, idx);
 		list_for_each_entry(meta, &pool->partial_dirty, list)
-			dropped += dma_pmd_forget_domain(meta, idx);
+			n += dma_pmd_forget_domain(meta, idx);
 		list_for_each_entry(meta, &pool->idle, list)
-			dropped += dma_pmd_forget_domain(meta, idx);
+			n += dma_pmd_forget_domain(meta, idx);
 		list_for_each_entry(meta, &pool->full, list)
-			dropped += dma_pmd_forget_domain(meta, idx);
+			n += dma_pmd_forget_domain(meta, idx);
 		spin_unlock_irqrestore(&pool->lock, flags);
+
+		atomic64_add(n, &pool->domain_forget_cnt);
+		dropped += n;
 	}
 	mutex_unlock(&dma_pmd_pools_lock);
 
@@ -843,8 +848,10 @@ static struct dma_pmd_meta *dma_pmd_add_page(struct dma_pmd_pool *pool,
 	 * A high-order allocation is expensive when it fails, and under fragmentation
 	 * it fails on every pool miss. For GFP_ATOMIC, back off briefly.
 	 */
-	if (!can_block && time_before(jiffies, READ_ONCE(pool->next_alloc_attempt)))
+	if (!can_block && time_before(jiffies, READ_ONCE(pool->next_alloc_attempt))) {
+		atomic64_inc(&pool->fail_backoff);
 		return NULL;
+	}
 
 	/* Aggregate ceiling across every pool, independent of max_idle_pages. */
 	if (atomic_long_inc_return(&dma_pmd_nr_pages) > READ_ONCE(dma_pmd_max_pages)) {
@@ -852,6 +859,7 @@ static struct dma_pmd_meta *dma_pmd_add_page(struct dma_pmd_pool *pool,
 		if (!can_block)
 			WRITE_ONCE(pool->next_alloc_attempt,
 				   jiffies + DIV_ROUND_UP(HZ, 100));
+		atomic64_inc(&pool->fail_budget);
 		return NULL;
 	}
 
@@ -890,6 +898,14 @@ static struct dma_pmd_meta *dma_pmd_add_page(struct dma_pmd_pool *pool,
 		if (!can_block)
 			WRITE_ONCE(pool->next_alloc_attempt,
 				   jiffies + DIV_ROUND_UP(HZ, 100));
+		atomic64_inc(&pool->fail_nomem);
+		/*
+		 * __GFP_NOWARN suppresses the page allocator's own report, so
+		 * without this the pool can stop pooling entirely and look
+		 * exactly like one that is working.
+		 */
+		pr_warn_once("dma_pmd: order-%u allocation failed for pool %p; further failures are counted in debugfs only\n",
+			     PMD_ORDER, pool);
 		return NULL;
 	}
 
@@ -922,6 +938,7 @@ static struct dma_pmd_meta *dma_pmd_add_page(struct dma_pmd_pool *pool,
 			__free_pages(page, PMD_ORDER);
 			atomic_long_dec(&dma_pmd_nr_pages);
 		}
+		atomic64_inc(&pool->fail_split);
 		return NULL;
 	}
 
@@ -1020,7 +1037,7 @@ static struct dma_pmd_meta *dma_pmd_pick_meta(struct dma_pmd_pool *pool, bool ze
 /* Extract up to @want available blocks from @meta under @pool->lock. */
 static unsigned long dma_pmd_take_blocks(struct dma_pmd_pool *pool,
 					 struct dma_pmd_meta *meta,
-					 unsigned long want,
+					 int target_nid, unsigned long want,
 					 struct page **out, bool zero)
 {
 	unsigned long base_pfn = dma_pmd_meta_to_pfn(meta);
@@ -1040,6 +1057,8 @@ static unsigned long dma_pmd_take_blocks(struct dma_pmd_pool *pool,
 		meta->nr_dirty = 0;
 	}
 	dma_pmd_place_meta(pool, meta);
+	if (page_to_nid(pfn_to_page(base_pfn)) != target_nid)
+		pool->numa_mismatch_cnt += used;
 
 	return got;
 }
@@ -1075,13 +1094,18 @@ unsigned long dma_pmd_pool_alloc_bulk_node(struct dma_pmd_pool *pool, gfp_t gfp,
 {
 	unsigned long allocated = 0, flags;
 	bool should_scrub = false;
+	int target_nid;
 	bool zero;
 
-	if (unlikely(!pool || pool->destroyed || !nr_pages ||
-		     (gfp & (__GFP_DMA | __GFP_DMA32 | __GFP_THISNODE |
-			     __GFP_ACCOUNT))))
+	if (unlikely(!pool || pool->destroyed || !nr_pages))
+		return 0;
+
+	if (unlikely(gfp & (__GFP_DMA | __GFP_DMA32 | __GFP_THISNODE | __GFP_ACCOUNT))) {
+		atomic64_inc(&pool->fail_gfp);
 		return 0;
+	}
 
+	target_nid = (nid == NUMA_NO_NODE) ? numa_mem_id() : nid;
 	zero = want_init_on_alloc(gfp);
 
 	spin_lock_irqsave(&pool->lock, flags);
@@ -1093,8 +1117,11 @@ unsigned long dma_pmd_pool_alloc_bulk_node(struct dma_pmd_pool *pool, gfp_t gfp,
 			/* Fallback to a new allocation */
 			spin_unlock_irqrestore(&pool->lock, flags);
 			meta = dma_pmd_add_page(pool, gfp, nid, zero);
-			if (!meta)
+			if (!meta) {
+				if (!allocated)
+					atomic64_inc(&pool->block_alloc_fail);
 				goto out;
+			}
 			spin_lock_irqsave(&pool->lock, flags);
 			pool->pmd_alloc_cnt++;
 			list_add(&meta->list, &pool->partial);
@@ -1102,7 +1129,7 @@ unsigned long dma_pmd_pool_alloc_bulk_node(struct dma_pmd_pool *pool, gfp_t gfp,
 				should_scrub = true;
 		}
 
-		allocated += dma_pmd_take_blocks(pool, meta,
+		allocated += dma_pmd_take_blocks(pool, meta, target_nid,
 						 nr_pages - allocated,
 						 &page_array[allocated], zero);
 	}
@@ -1366,6 +1393,91 @@ static unsigned long dma_pmd_shrink_scan(struct shrinker *shrink,
 	return freed ?: SHRINK_STOP;
 }
 
+/*
+ * One block of lines per pool, in /sys/kernel/debug/dma_pmd/pools.
+ *
+ * Pools that have seen no activity at all are skipped: two are created per
+ * possible CPU and one per RX queue, so on a large machine the overwhelming
+ * majority are idle and would bury the few that carry traffic. A pool that
+ * tried and failed is never skipped - that is the case this file exists for.
+ *
+ * The u64 statistics are snapshotted under @pool->lock and printed after it is
+ * dropped; the atomic64 ones are read locklessly, so a line is not a
+ * consistent instant. That is fine for what this is used for - watching which
+ * way a counter moves - and keeps the file off the locking hot path.
+ *
+ * The partial/full split is not reported: counting it means walking both lists
+ * with @pool->lock held and interrupts off, which is unbounded in the number of
+ * PMD pages a pool holds. "held" is derived from the got/put counters instead.
+ */
+static int dma_pmd_pools_show(struct seq_file *s, void *unused)
+{
+	unsigned int reservoir_nr = 0;
+	struct dma_pmd_pool *pool;
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY)
+		reservoir_nr += READ_ONCE(dma_pmd_reservoirs[nid].nr_pages);
+
+	seq_printf(s, "2m_pages %ld/%lu reservoir %u; pools with no activity are omitted\n",
+		   atomic_long_read(&dma_pmd_nr_pages), dma_pmd_max_pages, reservoir_nr);
+
+	mutex_lock(&dma_pmd_pools_lock);
+	list_for_each_entry(pool, &dma_pmd_pools, node) {
+		u64 alloc_2m, free_2m, block_alloc, block_free, block_scrub;
+		u64 block_fail, fail_gfp, numa_mismatch;
+		unsigned int num_idle, max_idle;
+		unsigned long flags;
+
+		block_fail = atomic64_read(&pool->block_alloc_fail);
+		fail_gfp = atomic64_read(&pool->fail_gfp);
+
+		spin_lock_irqsave(&pool->lock, flags);
+		alloc_2m = pool->pmd_alloc_cnt;
+		free_2m = pool->pmd_free_cnt;
+		block_alloc = pool->block_alloc_cnt;
+		block_free = pool->block_free_cnt;
+		block_scrub = pool->block_scrub_cnt;
+		numa_mismatch = pool->numa_mismatch_cnt;
+		num_idle = pool->num_idle_pages;
+		max_idle = pool->max_idle_pages;
+		spin_unlock_irqrestore(&pool->lock, flags);
+
+		/*
+		 * A pool that acquired no PMD page is the one worth looking at,
+		 * not the one to hide: it is indistinguishable from a healthy
+		 * pool everywhere else, because its callers just fall back.
+		 * Omit a pool only when nothing has ever happened to it, which
+		 * is the idle-per-CPU case this filter exists for.
+		 */
+		if (!alloc_2m && !block_alloc && !block_fail && !fail_gfp)
+			continue;
+
+		seq_printf(s, "pool %p order %u\n", pool, pool->order);
+		seq_printf(s, "  2m_pages  got %llu put %llu held %llu idle %u/%u\n",
+			   alloc_2m, free_2m, alloc_2m - free_2m, num_idle, max_idle);
+		seq_printf(s, "  blocks    alloc %llu free %llu scrub %llu numa_mismatch %llu failed %llu gfp %llu\n",
+			   block_alloc, block_free, block_scrub, numa_mismatch,
+			   block_fail, fail_gfp);
+		seq_printf(s, "  no_2m     backoff %lld budget %lld nomem %lld split %lld\n",
+			   atomic64_read(&pool->fail_backoff),
+			   atomic64_read(&pool->fail_budget),
+			   atomic64_read(&pool->fail_nomem),
+			   atomic64_read(&pool->fail_split));
+		seq_printf(s, "  domains   mapped %lld forgotten %lld\n",
+			   atomic64_read(&pool->pmd_map_cnt),
+			   atomic64_read(&pool->domain_forget_cnt));
+		seq_printf(s, "  per_buf   no_window %lld no_pool %lld map_err %lld\n",
+			   atomic64_read(&pool->fallback_nowindow),
+			   atomic64_read(&pool->fallback_nopool),
+			   atomic64_read(&pool->fallback_maperr));
+	}
+	mutex_unlock(&dma_pmd_pools_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(dma_pmd_pools);
+
 static int __init dma_pmd_init(void)
 {
 	struct shrinker *shrink;
@@ -1377,7 +1489,7 @@ static int __init dma_pmd_init(void)
 	}
 
 	/*
-	 * Hard ceiling on memory diverted from the buddy allocator into 2MB
+	 * Hard ceiling on memory diverted from the buddy allocator into DMA_PMD
 	 * pools, in PMD pages. One eighth of RAM is far above what the per-pool
 	 * watermarks should ever reach; it exists to bound a pathological
 	 * configuration (many queues, many CPUs, all pools at their high
@@ -1403,6 +1515,13 @@ static int __init dma_pmd_init(void)
 	if (!dma_pmd_wq)
 		pr_warn("dma_pmd: no reclaim workqueue, falling back to system_wq\n");
 
+	/*
+	 * No error handling and no dentry kept: this is built in and never
+	 * unloaded, and the stubs are no-ops when debugfs is disabled.
+	 */
+	debugfs_create_file("pools", 0444, debugfs_create_dir("dma_pmd", NULL),
+			    NULL, &dma_pmd_pools_fops);
+
 	shrink = shrinker_alloc(0, "dma_pmd");
 	if (!shrink) {
 		pr_warn("dma_pmd: shrinker registration failed\n");
diff --git a/drivers/iommu/dma-pmd-priv.h b/drivers/iommu/dma-pmd-priv.h
index 82a5c869aa216..b9bf48eb7f0f7 100644
--- a/drivers/iommu/dma-pmd-priv.h
+++ b/drivers/iommu/dma-pmd-priv.h
@@ -178,7 +178,8 @@ static inline unsigned int dma_pmd_meta_avail(const struct dma_pmd_meta *m)
  * struct dma_pmd_pool - Pool managing PMD-backed blocks of a fixed order
  *
  * @lock:	Spinlock protecting @partial, @idle, @full, @num_idle_pages,
- *		block bitmaps and the statistics counters
+ *		the block bitmaps and the u64 statistics counters. The
+ *		atomic64_t counters below are deliberately outside it.
  * @order:	Block order managed by this pool (<= PMD_ORDER)
  * @destroyed:	Set when dma_pmd_pool_destroy() has been called
  * @partial:	List of partially used PMD pages with @nr_free > 0 (clean-only
@@ -196,6 +197,7 @@ static inline unsigned int dma_pmd_meta_avail(const struct dma_pmd_meta *m)
  * @block_alloc_cnt: Statistics counter of block allocations satisfied
  * @block_free_cnt: Statistics counter of block frees recycled into pool
  * @block_scrub_cnt: Statistics counter of dirty blocks zeroed by scrubber
+ * @numa_mismatch_cnt: Block allocations satisfied from a non-target NUMA node
  * @next_alloc_attempt: Do not attempt a new order-9 allocation before this time.
  *		Damps repeated high-order GFP_ATOMIC failures under
  *		fragmentation, which would otherwise be retried on every
@@ -203,6 +205,26 @@ static inline unsigned int dma_pmd_meta_avail(const struct dma_pmd_meta *m)
  * @refcount:	Reference count; held by pool creator and each active PMD page
  * @node:	Node in the global dma_pmd_pools list
  * @dead_node:	Node in dma_pmd_dead_pools once @refcount reaches 0
+ * @fail_backoff: PMD page acquisitions skipped because @next_alloc_attempt was set
+ * @fail_budget: PMD page acquisitions refused by global dma_pmd_max_pages
+ * @fail_nomem: PMD page acquisitions that ran out of memory for the order-9
+ *		allocation. Silent otherwise: the request carries __GFP_NOWARN
+ *		so the page allocator says nothing.
+ * @fail_split: split_page_compound() rejections
+ * @block_alloc_fail: PMD page acquisitions that failed, making
+ *		dma_pmd_pool_alloc() return NULL so the caller had to fall
+ *		back to a plain page
+ * @fail_gfp:	dma_pmd_pool_alloc() calls declined due to unsupported GFP
+ *		flags (__GFP_DMA, __GFP_DMA32, __GFP_THISNODE, __GFP_ACCOUNT)
+ * @pmd_map_cnt: PMD page mappings established across all domains
+ * @fallback_nowindow: Buffers mapped individually because the domain has no
+ *		usable IOVA window - no free range large enough, no free
+ *		domain index, or a window the device cannot address
+ * @fallback_nopool: Buffers mapped individually because the domain can never
+ *		pool: direct isolation, or no PMD page size
+ * @fallback_maperr: Buffers mapped individually because the PMD page mapping
+ *		itself failed
+ * @domain_forget_cnt: Cached mappings dropped by dma_pmd_domain_release()
  */
 struct dma_pmd_pool {
 	/* First cacheline: hot fields touched on block alloc and free. */
@@ -222,12 +244,31 @@ struct dma_pmd_pool {
 	u64			block_alloc_cnt;
 	u64			block_free_cnt;
 	u64			block_scrub_cnt;
+	u64			numa_mismatch_cnt;
 
 	/* Cold. */
 	unsigned long		next_alloc_attempt;
 	struct kref		refcount;
 	struct list_head	node;
 	struct llist_node	dead_node;
+
+	/*
+	 * Statistics updated without @lock. dma_pmd_add_page() runs outside
+	 * it, and the map slow path holds @meta->map_lock - taking @lock there
+	 * would invert the order against dma_pmd_domain_release(), which
+	 * walks @lock then map_lock.
+	 */
+	atomic64_t		fail_backoff;
+	atomic64_t		fail_budget;
+	atomic64_t		fail_nomem;
+	atomic64_t		fail_split;
+	atomic64_t		block_alloc_fail;
+	atomic64_t		fail_gfp;
+	atomic64_t		pmd_map_cnt;
+	atomic64_t		fallback_nowindow;
+	atomic64_t		fallback_nopool;
+	atomic64_t		fallback_maperr;
+	atomic64_t		domain_forget_cnt;
 } ____cacheline_aligned;
 
 extern unsigned long dma_pmd_meta_nframes;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

