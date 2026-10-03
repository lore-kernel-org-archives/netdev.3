Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2449E142
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062588; cv=none; b=la2Z6qulVIIotwJCYDU+uRTe/pMZ9BJN5+7/GFQ3p+Zv4YZMEiX9UNwHpHkT0FkJMmcXtPTBvVrV5HrNoLcbz5rt4hglajlTKLns2KkBgnIHJwP0oM/y4GMSnN3huJDZaFvPUtPlHvmv33p3+iBAc5WLZrvYNGuZjgPvGFX0+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062588; c=relaxed/simple;
	bh=Ox+oo5QJRQUMxLVya4s0wzbVsem5Q6Eie6XnmZs8e/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDKzonuDQpsOgQRgSQ87kvnEl16aa3cYR7e1abqX7iJeXnmEXP6NxJopubvBNgZ4Vng7kThyeCmuthDlRA1++2fJ25fRCo4u/+Bue1JtCRXq9iPtyPytqCX/MXVDdfRdoxka5trdmJb4WCJe7tizGOTxZZbvksd+bk3yvr7EH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8eG+7xz; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8eG+7xz"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2939083cefso89434866b.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062581; x=1791667381; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxnWfCtIeX20UabhbwcYMIUINCIuBjoP15nZymAWMw0=;
        b=p8eG+7xzjYO3ZJj0mBg1krOMP0+99ENapN30Kcy2xW/7vytwcF9a4nB3rsUlZVvzOu
         FEAwC5buqmJ8Iz/LK+VatjxxXQiA2WwMQ7FnSneu+nUu6kRvD/B3OMdYpSizV38fSN7a
         z2MbHDPrBSrhhNrEd+lC1d2t9AjfCFXV1rHszyAxfpxiWj0+vBe4TpfDu/kVmx1rJkU7
         xwwN+Q/c1SdSunsQa1LFVNxADOJWtG+zxdgEpsiONTYsfOIW9zI/7572d50sLl9KU3Dv
         4pBeAI244tKsgfnDk6esL3GVQyQEhSNLkcivtRN0Q89biaL0rhbYCGAB/ryoYGdqcSQT
         AnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062581; x=1791667381;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxnWfCtIeX20UabhbwcYMIUINCIuBjoP15nZymAWMw0=;
        b=O64HTd7lRknLnD+r+K94VsGgiiyrVQSIR4idVNQjNYjs1PCmLWPPmEdH9lC5s/Twl2
         Xsc6MTkBiVBMw7VO4Mo/9dFEg2WodIfCdp1s5Vc/16WNbSc7NEdJBYIhWUWIphqj7tfZ
         ntP4esHmt/DncaztRP18D2F9cSDLu4IWzgwD0a1QrThU57rJ5YvWr/8ju0rxYXnRPMYK
         c2Yo/kNwDTmr9ClMzgdon1LJNapsANvmm2DWxaZRQWHUQstoa/1eDKdgWUuAaVs89BrV
         75IR1T1LKo9sl0Kog2hC8E/l5nWT7SBP13rNJ+Xv2OFmMR8knaoDRTw21ujFY+3jZjFs
         0Vdw==
X-Forwarded-Encrypted: i=1; AKwUvBx7TZGmMgHC43Cpt6RGnWZenEQNTL9IJYz/Gf7WkWmhath5C+R6j6gFPkuKWxEW27ftuKhCQF4=@vger.kernel.org
X-Gm-Message-State: AFuF++lz03nxX/I/xYkoMQsP/Te8I0FI0QkQ275E9qMp98qGbqRsHtcH
	Bka35cahs8waI+5HLjmaotfKVNNrvIINSxy7Zl36wu0iNAiQZ1DJ/RJLvTbFzKKsnh6I3ZYDNnS
	Iy13m6A==
X-Received: from edgj17-n2.prod.google.com ([2002:a05:6402:a5d1:20b0:6ae:2baf:8e53])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7282:b0:c2d:fc0b:551c
 with SMTP id a640c23a62f3a-c2e4ad7caa6mr536656666b.16.1791062580744; Sat, 03
 Oct 2026 14:23:00 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:30 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-12-lrizzo@google.com>
Subject: [RFC: DMA_PMD 11/22] dma-mapping: Use DMA_PMD arena for dma_alloc_attrs()
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

Wire dma_alloc_attrs() and dma_free_attrs() into the DMA_PMD arena
when dev->dma_pmd_rings is enabled on a device:
  - Add dma_pmd_dma_alloc() and dma_is_pmd_dma() backed by
    dma_pmd_arena.
  - Route GFP_KERNEL dma_alloc_attrs() requests through dma_pmd_dma_alloc()
    when dev->dma_pmd_rings is set, logging latency when
    dev->dma_pmd_debug is enabled.
  - Reclaim sub-allocations back to the arena in dma_free_attrs() via
    dma_pmd_arena_free() while keeping the PMD_SIZE IOMMU mapping active.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/dma-pmd-arena.c | 27 ++++++++++++++++++++++++
 drivers/iommu/dma-pmd-kunit.c | 11 +++++++---
 drivers/iommu/dma-pmd-map.c   | 17 +++++++++++++++
 include/linux/dma-pmd.h       | 29 ++++++++++++++++++++++++++
 kernel/dma/mapping.c          | 39 +++++++++++++++++++++++++++++------
 5 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-pmd-arena.c b/drivers/iommu/dma-pmd-arena.c
index 578df5be86a86..e1a7d9d6f0f60 100644
--- a/drivers/iommu/dma-pmd-arena.c
+++ b/drivers/iommu/dma-pmd-arena.c
@@ -383,3 +383,30 @@ void *dma_pmd_arena_alloc(struct device *dev, size_t size, dma_addr_t *dma, int
 	return NULL;
 }
 EXPORT_SYMBOL(dma_pmd_arena_alloc);
+
+void *dma_pmd_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma,
+			gfp_t gfp, unsigned long attrs)
+{
+	void *va;
+
+	if (!dev || !dev->iommu_group || !dev_is_dma_coherent(dev))
+		return NULL;
+	/*
+	 * The arena allocates PMD pages, IOMMU page tables, and vmap() areas
+	 * with GFP_KERNEL, and shares PMD pages across allocations on the same
+	 * device. Decline non-GFP_KERNEL requests (including GFP_NOFS/GFP_NOIO
+	 * or scoped memalloc_nofs/noio contexts) and per-allocation modifiers
+	 * such as __GFP_ACCOUNT or __GFP_NORETRY so the caller falls back to
+	 * the standard DMA allocator.
+	 */
+	if ((current_gfp_context(gfp) & ~(__GFP_ZERO | __GFP_NOWARN)) != GFP_KERNEL ||
+	    (attrs & ~DMA_ATTR_NO_WARN))
+		return NULL;
+
+	va = dma_pmd_arena_alloc(dev, size, dma, dev_to_node(dev));
+	if (!va && !(gfp & __GFP_NOWARN) && !(attrs & DMA_ATTR_NO_WARN))
+		dev_warn_ratelimited(dev, "DMA_PMD arena alloc failed (size %zu)\n",
+				     size);
+	return va;
+}
+EXPORT_SYMBOL(dma_pmd_dma_alloc);
diff --git a/drivers/iommu/dma-pmd-kunit.c b/drivers/iommu/dma-pmd-kunit.c
index b91dbcb468879..c2363277e2ecd 100644
--- a/drivers/iommu/dma-pmd-kunit.c
+++ b/drivers/iommu/dma-pmd-kunit.c
@@ -169,11 +169,16 @@ static void test_window_helpers(struct kunit *test)
 static void test_arena_alloc_and_free(struct kunit *test)
 {
 	struct device dev = { .numa_node = NUMA_NO_NODE };
-	void *v1, *v2, *v3, *vl1;
 	dma_addr_t d1, d2, d3, dl1;
+	void *v1, *v2, *v3, *vl1;
 
-	KUNIT_EXPECT_NULL(test,
-			  dma_pmd_arena_alloc(NULL, SZ_4K, &d1, NUMA_NO_NODE));
+	KUNIT_EXPECT_NULL(test, dma_pmd_arena_alloc(NULL, SZ_4K, &d1, NUMA_NO_NODE));
+	KUNIT_EXPECT_NULL(test, dma_pmd_dma_alloc(NULL, SZ_4K, &d1, GFP_KERNEL, 0));
+	KUNIT_EXPECT_NULL(test, dma_pmd_dma_alloc(&dev, SZ_4K, &d1, GFP_KERNEL, 0));
+	KUNIT_EXPECT_NULL(test, dma_pmd_dma_alloc(&dev, SZ_4K, &d1,
+						  GFP_KERNEL | __GFP_ACCOUNT, 0));
+	KUNIT_EXPECT_FALSE(test, dma_pmd_free(&dev, SZ_4K, NULL, 0));
+	KUNIT_EXPECT_FALSE(test, dma_is_pmd_dma(&dev, 0));
 
 	v1 = dma_pmd_arena_alloc(&dev, SZ_64K, &d1, NUMA_NO_NODE);
 	KUNIT_ASSERT_NOT_NULL(test, v1);
diff --git a/drivers/iommu/dma-pmd-map.c b/drivers/iommu/dma-pmd-map.c
index 1147874ac8068..76cb5d01cb1e8 100644
--- a/drivers/iommu/dma-pmd-map.c
+++ b/drivers/iommu/dma-pmd-map.c
@@ -380,6 +380,23 @@ int dma_pmd_window_assign(struct device *dev, struct iommu_domain *domain,
 	return ret;
 }
 
+/**
+ * dma_is_pmd_dma - Test whether @dma lies in @dev's DMA_PMD IOVA window
+ * @dev: Device performing DMA
+ * @dma: DMA address to test
+ */
+bool dma_is_pmd_dma(struct device *dev, dma_addr_t dma)
+{
+	struct dma_pmd_window *win;
+
+	if (!dev || !dev->iommu_group)
+		return false;
+
+	win = dma_pmd_dma_window(iommu_get_dma_domain(dev));
+	return win && dma_pmd_window_owns(win, dma);
+}
+EXPORT_SYMBOL(dma_is_pmd_dma);
+
 /**
  * dma_pmd_dma_map_phys - Derive the IOVA of a pool address, mapping if needed
  * @dev: Device performing DMA
diff --git a/include/linux/dma-pmd.h b/include/linux/dma-pmd.h
index 55c770fe232b0..7b7e9477d44e1 100644
--- a/include/linux/dma-pmd.h
+++ b/include/linux/dma-pmd.h
@@ -96,7 +96,19 @@ static inline struct page *dma_pmd_pool_alloc(struct dma_pmd_pool *pool, gfp_t g
 bool dma_pmd_pool_has_free(struct dma_pmd_pool *pool);
 
 /* Hooks for kernel/dma/mapping.c */
+void *dma_pmd_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma,
+			gfp_t gfp, unsigned long attrs);
 bool dma_pmd_arena_free(struct device *dev, size_t size, void *cpu_addr, dma_addr_t dma);
+bool dma_is_pmd_dma(struct device *dev, dma_addr_t dma);
+
+static inline bool dma_pmd_free(struct device *dev, size_t size,
+				void *cpu_addr, dma_addr_t dma_handle)
+{
+	/* Pairs with smp_store_release() in dma_pmd_meta_init(). */
+	if (likely(!smp_load_acquire(&dma_pmd_meta_array)))
+		return false;
+	return dma_pmd_arena_free(dev, size, cpu_addr, dma_handle);
+}
 
 #else /* !CONFIG_DMA_PMD */
 
@@ -144,11 +156,28 @@ static inline bool dma_pmd_pool_has_free(struct dma_pmd_pool *pool)
 	return false;
 }
 
+static inline void *dma_pmd_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma,
+				      gfp_t gfp, unsigned long attrs)
+{
+	return NULL;
+}
+
 static inline bool dma_pmd_arena_free(struct device *dev, size_t size,
 				      void *cpu_addr, dma_addr_t dma)
 {
 	return false;
 }
 
+static inline bool dma_is_pmd_dma(struct device *dev, dma_addr_t dma)
+{
+	return false;
+}
+
+static inline bool dma_pmd_free(struct device *dev, size_t size,
+				void *cpu_addr, dma_addr_t dma_handle)
+{
+	return false;
+}
+
 #endif /* CONFIG_DMA_PMD */
 #endif /* _LINUX_DMA_PMD_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index bf2651a70b7c2..cc18896017e35 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -10,6 +10,8 @@
 #include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
+#include <linux/ktime.h>
+#include <linux/dma-pmd.h>
 #include <linux/iommu-dma.h>
 #include <linux/kmsan.h>
 #include <linux/of_device.h>
@@ -180,7 +182,8 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	if (!is_mmio)
 		kmsan_handle_dma(phys, size, dir);
 	trace_dma_map_phys(dev, phys, addr, size, dir, attrs);
-	debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
+	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) && !dma_is_pmd_dma(dev, addr))
+		debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
 
 	return addr;
 }
@@ -223,7 +226,8 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 	else if (ops->unmap_phys)
 		ops->unmap_phys(dev, addr, size, dir, attrs);
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
-	debug_dma_unmap_phys(dev, addr, size, dir, attrs);
+	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) && !dma_is_pmd_dma(dev, addr))
+		debug_dma_unmap_phys(dev, addr, size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(dma_unmap_phys);
 
@@ -633,7 +637,11 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs)
 {
+	bool debug = unlikely(READ_ONCE(dev->dma_pmd_debug)) && gfpflags_allow_blocking(flag);
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	bool can_block = gfpflags_allow_blocking(flag);
+	bool from_arena = false;
+	u64 start_ns = 0;
 	void *cpu_addr;
 
 	WARN_ON_ONCE(!dev->coherent_dma_mask);
@@ -655,10 +663,14 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (force_dma_unencrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
+	if (debug) {
+		start_ns = ktime_get_ns();
+		*dma_handle = 0;
+	}
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
 		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
 				DMA_BIDIRECTIONAL, flag, attrs);
-		return cpu_addr;
+		goto out_debug;
 	}
 
 	/* let the implementation decide on the zone to allocate from: */
@@ -667,18 +679,31 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (use_dma_iommu(dev)) {
-		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
+		if (READ_ONCE(dev->dma_pmd_rings) && can_block) {
+			cpu_addr = dma_pmd_dma_alloc(dev, size, dma_handle, flag, attrs);
+			from_arena = !!cpu_addr;
+		}
+		if (!from_arena)
+			cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (ops->alloc) {
 		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
 	} else {
+		cpu_addr = NULL;
 		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
 				attrs);
-		return NULL;
+		goto out_debug;
 	}
 
 	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, DMA_BIDIRECTIONAL,
 			flag, attrs);
-	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
+	if (!from_arena)
+		debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
+out_debug:
+	if (debug)
+		dev_info(dev,
+			 "dma_alloc_coherent(size=%zu, gfp=%pGg, attrs=%#lx) -> va=%p, dma=%pad, arena=%d in %llu ns\n",
+			 size, &flag, attrs, cpu_addr, dma_handle, from_arena,
+			 ktime_get_ns() - start_ns);
 	return cpu_addr;
 }
 EXPORT_SYMBOL(dma_alloc_attrs);
@@ -703,6 +728,8 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		       attrs);
 	if (!cpu_addr)
 		return;
+	if (use_dma_iommu(dev) && dma_pmd_free(dev, size, cpu_addr, dma_handle))
+		return;
 
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle, attrs);
 	if (dma_alloc_direct(dev, ops) || arch_dma_free_direct(dev, dma_handle))
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

