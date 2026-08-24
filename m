Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C0440A34
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585385; cv=none; b=T5wQfl+cD3EP9YJ4IBI9d0xCEX1a6uVlwdkrwOmHAfFfBJEXy+1AweXIWaV14oBvJmZgNWQm69dFDo1irfiUhSEilleOkN6MOliWaGZdexeN1in9ENyyRn2AUHEzTdCAS+eE0hh4SyT2LNN3T5eQvmW/63+YaVc2p1qWOpeMhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585385; c=relaxed/simple;
	bh=+6KIs91WDIoo1NCHsUEn1NH39VCNgHI6xfWJXRyhn7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qc3Psq2BHg+hG7xTjmvbHy+aKG9xgsxvrgOdn+fDdGMgm+L0KsbXHKrRvx9IRFdcreovjVw77Ta0sWQjOWHVRAYu1KqdFbhgG9PcnWiGi/tig29N4wcCsshADGeiHX/RRTg/Dtwej4aCHxP6qMr9PtOUeqekXNDauPKpq1SM1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpCPblvD; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpCPblvD"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15e6109f9aso327396866b.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585380; x=1788190180; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MUtQgSiF1UT5gfL8VJuu1JZ6DoMTlmedVjUdmZy7TI=;
        b=KpCPblvDJy2tMEq1IPjMdd04a+i8jlbqqVDFPGF45vrxkOF/sellLLxEB9ZUVyUK4C
         sN+CHykIbuQFIkRjDKMKWhajhWxTATcM/9wPezSbVx28+VhLI0PGZ6riA+N8J1coaqIX
         7HmoujthLPmm+AHURxIzzckc8RXw6W9+zX1Vdr7qf/djDEbH1+za/+RBJYiwwKLoWIp1
         fgvT6GREto2rKYxWd3CQLAq89mRfyGLq5bimM32xfHDMcJrSxUajFdOojq/N939GFks/
         FZGsnwEnmIP12OgrIqE1+tshYhC/mO6VvT2rvv4EGZdPouHcHDu9MjNraQ5F0OwLoRhq
         VpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585380; x=1788190180;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MUtQgSiF1UT5gfL8VJuu1JZ6DoMTlmedVjUdmZy7TI=;
        b=gObCPSNXBHsWSndOj8e67Fi/t3/hRzML16U2A7wlZMyzrbfGxHHbxkQHNzrqMYU1Nw
         y1sB4KG9sfBjgNJUwP3PHZHf8GRU9lCSg8s3eqxmVfsGosHeY4wy7Wb5dD9rb89oxNn6
         PFwINTMHrK3eSLgMmye0hJsu/U741iBcXmAc0NlES3upbJ9W8IBsCTrWO5Fm+QN2L52l
         1qRwhnzY082cDYabkf1HAVr4c4L672TnsCzRWqU02elhQlhioSzu3plauYtl2hGAo7rG
         murFwDdXSnGSp94TQ5p4t0CzZP4uxc3skOvS20O0tJmTvm/OaVaJevf11WWXpJojfq8/
         H+Uw==
X-Forwarded-Encrypted: i=1; AHgh+RqBDnlwkZptQ+dgtzgcpGYp/ycMGge4OUcOKi4a++IXEF36DmmyOtIKAUvgCcg6ZFElwAWuruw=@vger.kernel.org
X-Gm-Message-State: AFuF++low+Buda1tUP7Ygrxms5imsfi22WXmfNoLZ9gWl8ECo3vkPQ60
	ppMXwlrYSYlMJAbMyKgNE9X562yZMUL/QgAk5+TZcmuyEqb8wqXAtjVnJr+jC5STLgBSjSRs21b
	FRnVnzw==
X-Received: from ejdcu6.prod.google.com ([2002:a17:906:ba86:b0:c1f:97d8:cdd8])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:f59b:b0:c20:7cb1:9046
 with SMTP id a640c23a62f3a-c24924b7508mr2143073766b.8.1787585380008; Mon, 24
 Aug 2026 08:29:40 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:29:31 +0000
In-Reply-To: <20260824152932.1583506-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260824152932.1583506-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824152932.1583506-5-lrizzo@google.com>
Subject: [PATCH v2 4/5] net: Divert socket allocations to SWIOTLB for nocopy TX
From: Luigi Rizzo <lrizzo@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <lrizzo@google.com>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conditionally intercept socket buffer page allocations and direct them
to the SWIOTLB page allocator when nocopy tx is active.

This only happens when the swiotlb usage is below module parameter
swiotlb.nocopy_tx_percent (default 0, range 0..90)
A value of 0 disables the feature.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/dma-iommu.c |  9 +++++-
 include/linux/skbuff.h    |  7 ++++-
 include/linux/swiotlb.h   |  2 ++
 kernel/dma/direct.h       | 11 +++++++
 kernel/dma/swiotlb.c      | 12 ++++++++
 mm/page_alloc.c           | 10 ++++++-
 net/core/sock.c           | 62 ++++++++++++++++++++++++++++++++++-----
 7 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9a07eb39336eb..956d5e11b2896 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1228,7 +1228,14 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	 * If both the physical buffer start address and size are page aligned,
 	 * we don't need to use a bounce page.
 	 */
-	if (dev_use_swiotlb(dev, size, dir) &&
+	bool is_nocopy = false;
+
+	if (swiotlb_is_nocopy_addr(dev, phys)) {
+		swiotlb_nocopy_inc_ref(&dev->dma_io_tlb_mem->defpool, phys);
+		is_nocopy = true;
+	}
+
+	if (!is_nocopy && dev_use_swiotlb(dev, size, dir) &&
 	    iova_unaligned(iovad, phys, size)) {
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index add0d282dea6e..d8f7041edc400 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3786,7 +3786,12 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
 	fragto->netmem = fragfrom->netmem;
 }
 
-bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
+/* nocopy swiotlb uses an additional non-null struct sock pointer. */
+bool __skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio, struct sock *sk);
+static inline bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio)
+{
+	return __skb_page_frag_refill(sz, pfrag, prio, NULL);
+}
 
 /**
  * __skb_frag_dma_map - maps a paged fragment via the DMA API
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b1140db3cc397..3baf52e6572d0 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -204,6 +204,8 @@ void swiotlb_prep_compound_page(struct page *page, unsigned int order);
 void swiotlb_destroy_compound_page(struct page *page, unsigned int order);
 void swiotlb_safe_put_device(struct device *dev);
 
+extern unsigned int nocopy_tx_percent;
+
 /* Track epoch (number of delete operations) for leaf device info. */
 extern atomic_t global_device_epoch;
 
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 7140c208c1238..21c65acb13823 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -88,6 +88,17 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 {
 	dma_addr_t dma_addr;
 
+	if (swiotlb_is_nocopy_addr(dev, phys)) {
+		dma_addr_t unenc_addr = phys_to_dma_unencrypted(dev, phys);
+
+		if (likely(dma_capable(dev, unenc_addr, size, true))) {
+			swiotlb_nocopy_inc_ref(&dev->dma_io_tlb_mem->defpool, phys);
+			if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+				arch_sync_dma_for_device(phys, size, dir);
+			return unenc_addr;
+		}
+	}
+
 	if (is_swiotlb_force_bounce(dev)) {
 		if (!(attrs & DMA_ATTR_CC_SHARED)) {
 			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d4a07a7c570e1..7b818a796ff96 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -63,6 +63,11 @@
  */
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
 
+/* enable nocopy tx swiotlb and set the percentage of buffers allowed for it. */
+unsigned int nocopy_tx_percent;
+module_param(nocopy_tx_percent, uint, 0644);
+MODULE_PARM_DESC(nocopy_tx_percent, "percentage of swiotlb buffer allowed for nocopy tx");
+
 /**
  * struct io_tlb_slot - IO TLB slot descriptor
  * @orig_addr:	The original address corresponding to a mapped entry.
@@ -1640,6 +1645,13 @@ void __swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 		size_t mapping_size, enum dma_data_direction dir,
 		unsigned long attrs, struct io_tlb_pool *pool)
 {
+	int index = (tlb_addr - pool->start) >> IO_TLB_SHIFT;
+
+	if (pool->slots[index].flags & SWIOTLB_SLOT_NOCOPY) {
+		swiotlb_nocopy_dec_ref(pool, tlb_addr);
+		return;
+	}
+
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ea148562a76d0..32d5d630f9840 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3002,9 +3002,14 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 {
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
-	unsigned long pfn = page_to_pfn(page);
+	unsigned long pfn;
 	int migratetype;
 
+	if (unlikely(swiotlb_free_pages(page, order)))
+		return;
+
+	pfn = page_to_pfn(page);
+
 	if (!pcp_allowed_order(order)) {
 		__free_pages_ok(page, order, fpi_flags);
 		return;
@@ -3070,6 +3075,9 @@ void free_unref_folios(struct folio_batch *folios)
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
+		if (unlikely(swiotlb_free_pages(&folio->page, order)))
+			continue;
+
 		if (!__free_pages_prepare(&folio->page, order, FPI_NONE))
 			continue;
 		/*
diff --git a/net/core/sock.c b/net/core/sock.c
index ca3e08d3de141..ef40d1ff1de9f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -188,6 +188,52 @@ void sk_record_bounce_device(struct sock *sk, struct device *dev)
 	}
 }
 EXPORT_SYMBOL(sk_record_bounce_device);
+
+/*
+ * Wrap alloc_pages in __skb_page_frag_refill(). If the socket's dma_device requires
+ * SWIOTLB bounce buffering, divert allocation to the SWIOTLB slot allocator.
+ * This ensures the packet payload is written directly to a bounce buffer from the start,
+ * enabling nocopy during driver DMA mapping.
+ */
+static inline struct page *alloc_any_pg(gfp_t gfp, unsigned int order, struct sock *sk)
+{
+	unsigned int pct = READ_ONCE(nocopy_tx_percent);
+
+	if (sk && pct && !sock_flag(sk, SOCK_ZEROCOPY)) {
+		struct page *page = NULL;
+		bool release_dev = false;
+		struct device *dev;
+
+		rcu_read_lock();
+		dev = rcu_dereference(sk->sk_swiotlb.dev);
+		if (dev) {
+			/*
+			 * The epoch check is just for cache invalidation, UAF is
+			 * protected by the reference held in the sk.
+			 */
+			if (swiotlb_dev_epoch() != READ_ONCE(sk->sk_swiotlb.epoch)) {
+				struct device __force **pdev =
+					(struct device __force **)&sk->sk_swiotlb.dev;
+
+				release_dev = (cmpxchg(pdev, (struct device __force *)dev,
+						       NULL) == dev);
+			} else {
+				page = swiotlb_alloc_pages(dev, order, gfp, pct);
+			}
+		}
+		rcu_read_unlock();
+		if (release_dev)
+			swiotlb_safe_put_device(dev);
+		if (page)
+			return page;
+	}
+	return alloc_pages(gfp, order);
+}
+#else
+static inline struct page *alloc_any_pg(gfp_t gfp, unsigned int order, struct sock *sk)
+{
+	return alloc_pages(gfp, order);
+}
 #endif
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
@@ -3213,7 +3259,7 @@ DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
  * no guarantee that allocations succeed. Therefore, @sz MUST be
  * less or equal than PAGE_SIZE.
  */
-bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
+bool __skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp, struct sock *sk)
 {
 	if (pfrag->page) {
 		if (page_ref_count(pfrag->page) == 1) {
@@ -3229,27 +3275,27 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 	if (SKB_FRAG_PAGE_ORDER &&
 	    !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
 		/* Avoid direct reclaim but allow kswapd to wake */
-		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
-					  __GFP_COMP | __GFP_NOWARN |
-					  __GFP_NORETRY,
-					  SKB_FRAG_PAGE_ORDER);
+		pfrag->page = alloc_any_pg((gfp & ~__GFP_DIRECT_RECLAIM) |
+					   __GFP_COMP | __GFP_NOWARN |
+					   __GFP_NORETRY,
+					   SKB_FRAG_PAGE_ORDER, sk);
 		if (likely(pfrag->page)) {
 			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
 			return true;
 		}
 	}
-	pfrag->page = alloc_page(gfp);
+	pfrag->page = alloc_any_pg(gfp, 0, sk);
 	if (likely(pfrag->page)) {
 		pfrag->size = PAGE_SIZE;
 		return true;
 	}
 	return false;
 }
-EXPORT_SYMBOL(skb_page_frag_refill);
+EXPORT_SYMBOL(__skb_page_frag_refill);
 
 bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 {
-	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
+	if (likely(__skb_page_frag_refill(32U, pfrag, sk->sk_allocation, sk)))
 		return true;
 
 	if (!sk->sk_bypass_prot_mem)
-- 
2.55.0.766.g2966f0265a-goog

