Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248755;
	b=QuoBr4mFRhFdbLMVKCOtUgo2Men8e2KjM04+/+2VCgJGbmUeYSyXuv29AFVVc1+G6Ws3
	 I10aTP2xj5nZDnaIxKKtX7FKs8SDOxp4TTFtHKzO/fcK8WY7Y++vYA6By4zYnKmUC4gqp
	 hsFzJWx491qArdAS0TK57NwWlQAKfGlul1knoN7G2r+gcBa2HtTeuCkWtRhRp67oqcCad
	 Dd2tSuY4BDbBSbCCX9inKYXL2bUbrevqgnL+0E7gQ4MpI7AFI9BfetMrF1BP8lg/ONHYY
	 37H0JkcThVZu3ecZZ0QcvRT2UcjF32gg9ojz80dnkogY7ky3bqDztx+vz5ZLJ1u6RHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
	b=q5BAa43zGWC3ipP8PKt5UCCNpv77E3QXfM50h3SnOXyR5X/n0kGZzqS79ugF9G35WHdO
	 Rpqfshu8S87XVuQTYGbyzH0uKVWL2Hna2NfxK28lW8U4cXqTxC4+QmQHRikTLWq5DXWGo
	 aY/RIm6SM27iVol6a98YEuDe7gGdmY3m4plwohYVdvGyFx4Q5kKzkqHDVrc5QOdAg3MvY
	 VVv2lwqMIcI+nPBQGhTUeRzq51ueMKKvvDwqZ/PJ4pd7ETKbxG1qxCIkjMndf7WjlT2jc
	 Pn8M1ru/VjRc46TeeSMXuC5b3ckvS8fmAsNbdOBbSuyWHNl4EtkaM+DUN37MtCmHFtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PucykuzF;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBF606CC4C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BCBF606CC4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PucykuzF
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c37b2763f1bso146256766b.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248753; x=1794853553; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
        b=PucykuzF+kI0Fuxe+WUtPrHWdECLJ+HBRvHEY3hGmZsDV+Y42K8qiOX2BzVv79MI4I
         sp6z2uGUNfZO3DNfGXEfg5goMbKSqdSse3Kn4YQwJik9dK5GupSkGDDOHDQXyB8GeeOL
         oOHe117qlnkKsTiiH7yL78B5OhDmfU5ZVZX/HlY5HwmlHtalgSheh1MWEE1rxgowjPyI
         tpDzWcHNPO5WdwAqcxM/c8D2Qmwz14WYetq0bjBADOmHkecHo6oL2868rrbZ4xtWYlAv
         Q93ai98PFrO9ycqoBX092LG8WjGWH+ds/U9P++J5ww0ccv1NclFeVqZLDjUpTTUX2mTz
         T1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248753; x=1794853553;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
        b=iZV6zlaCbsAI7EtqmlRq0bxkfVFgDMpNYfNaJckB2mE9/ApOgybONbPqKv+vKietpt
         z/oD9r1sgSuxOmO909cNl/XRVdeUp74bw42ebvSj2g6GA/LMwi4OaPgqb5UEiMhNLbdD
         2V8ZOigMNtsXTOGvIe+KCmIlfNgJZhM9lgzq+Sla77sf8Ulz+GcfAqDX8PPtUZ1i/ePq
         5KgDKQmFr4/CVzLPX1ycrUi7YzfDInCG4GhuCq9TIc/M1ZeS1i2cUlcFdR5/EGGf+AKS
         AFPQsidUZeu3gbmse+gxWE5E47fdMZ1jwwr5bD40nhddCYxaAGoMmrFzXEYm065wXDYn
         oZgQ==
X-Forwarded-Encrypted: i=1; AL+hErHfu9ZemyR5ZUAoZezqxJe9oT4uYyRjZxlJGYs1Wi4JDuNyXYbRKKXCDcftotAmjRyQeTaINsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tfa48O/m78uDivBBoz1pIeDcNM4uZOMeVZECSrXVJg1Xtc9Et
	QU25Y1p2GtQ8g7wC9gJRB6k2L8IAVjO1npMEe1AEmMpN5ukOTlTqM9UJxD0oq4gP0aKu+2GjBev
	MFLRVFg==
X-Received: from ejpg23.prod.google.com ([2002:a17:906:7c57:b0:c3f:d175:ee6a])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e20:b0:c41:64c1:cc2d
 with SMTP id a640c23a62f3a-c50491bd62emr17871766b.2.1794248752661; Mon, 09
 Nov 2026 10:25:52 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:24 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-17-lrizzo@google.com>
Subject: [RFC PATCH v2 16/25] mm/slub: Add SLAB_CACHE_PISA_RO for PISA-backed
 slab caches
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

skb heads are provided by a slab allocator that is fed by alloc_pages().

Add SLAB_CACHE_PISA_RO so that a slab cache can back its slabs with
zeroed, read-only PISA folios (__GFP_PISA_RO | __GFP_ZERO) via
pisa_alloc_folio(), clamping the slab order to
[2, PAGE_ALLOC_COSTLY_ORDER].
Slabs are still released with free_frozen_pages(), so pages from PISA
return to their allocator via __free_pages_prepare(). Caches with
SLAB_CACHE_PISA_RO skip KFENCE and are never merged.

Existing caches are unaffected.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 27 +++++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c | 19 +++++++++++++++++++
 include/linux/pisa.h       |  7 +++++++
 include/linux/slab.h       | 10 ++++++++++
 mm/slab.h                  |  3 ++-
 mm/slab_common.c           |  5 ++++-
 mm/slub.c                  | 14 +++++++++++++-
 7 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 4b61ec84ed6d1..3b5c49d143a7e 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -848,6 +848,33 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred
 	return pisa_alloc_bulk(pa, gfp & ~__GFP_PISA_RW, nr_pages, page_array, frozen);
 }
 
+/**
+ * pisa_alloc_folio - Allocate a frozen folio for SLUB (SLAB_CACHE_PISA_RO)
+ * @gfp: GFP flags (must have __GFP_PISA_RW or __GFP_PISA_RO set)
+ * @order: Folio order
+ * @nid: Target NUMA node (or NUMA_NO_NODE)
+ *
+ * Drops __GFP_THISNODE before calling the per-node allocator and verifies
+ * node placement afterwards.
+ *
+ * Return: Frozen folio of @order, or NULL.
+ */
+struct folio *pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid)
+{
+	struct page *page;
+
+	page = pisa_alloc_pages(gfp & ~__GFP_THISNODE, order, nid, NULL);
+	if (!page)
+		return NULL;
+	if (unlikely((gfp & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
+		     page_to_nid(page) != nid)) {
+		page_ref_unfreeze(page, 1);
+		__free_pages(page, order);
+		return NULL;
+	}
+	return page_folio(page);
+}
+
 /**
  * pisa_has_free_blocks_rx - Check if @dev has free PISA RX blocks of @order on @nid
  * @dev: Device to check
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 40bf7801183da..9cc1328893ace 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/shrinker.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <net/sock.h>
 
 #include "dma-iommu.h"
@@ -621,6 +622,23 @@ static void test_reservoir_and_scrubber(struct kunit *test)
 	WRITE_ONCE(pisa_scrub_max, old_scrub);
 }
 
+static void test_slub_page_alloc(struct kunit *test)
+{
+	struct kmem_cache *s;
+	void *obj;
+
+	s = kmem_cache_create("pisa_kunit_slab", 1024, NULL,
+			      SLAB_NO_MERGE | SLAB_CACHE_PISA_RO);
+	KUNIT_ASSERT_NOT_NULL(test, s);
+
+	obj = kmem_cache_alloc(s, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+	KUNIT_EXPECT_TRUE(test, is_pisa_page(virt_to_page(obj)));
+	kmem_cache_free(s, obj);
+
+	kmem_cache_destroy(s);
+}
+
 static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_meta_init_and_roundtrip),
 	KUNIT_CASE(test_meta_invalid_phys),
@@ -635,6 +653,7 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_pcp_cache),
 	KUNIT_CASE(test_gfp_pisa),
 	KUNIT_CASE(test_reservoir_and_scrubber),
+	KUNIT_CASE(test_slub_page_alloc),
 	{}
 };
 
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index 89eb0722d90bc..b9c5197f2d88d 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -110,6 +110,7 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order,
 				    int nr_pages, struct page **page_array,
 				    bool frozen);
 
+struct folio *pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid);
 bool pisa_has_free_blocks_rx(const struct device *dev, unsigned int order, int nid);
 bool pisa_page_can_recycle(const struct page *page);
 
@@ -181,6 +182,12 @@ pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred_nid,
 	return 0;
 }
 
+static inline struct folio *
+pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid)
+{
+	return NULL;
+}
+
 static inline gfp_t pisa_rx_gfp(const struct device *dev)
 {
 	return 0;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index cda126def67af..df19c5898e9fe 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -66,6 +66,9 @@ enum _slab_flag_bits {
 #endif
 #endif
 	_SLAB_NO_SHEAVES,
+#ifdef CONFIG_PISA
+	_SLAB_CACHE_PISA_RO,
+#endif
 	_SLAB_FLAGS_LAST_BIT
 };
 
@@ -260,6 +263,13 @@ enum _slab_flag_bits {
 #define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
 #endif
 
+/* Back slabs with zeroed read-only PISA folios (__GFP_PISA_RO | __GFP_ZERO) */
+#ifdef CONFIG_PISA
+#define SLAB_CACHE_PISA_RO	__SLAB_FLAG_BIT(_SLAB_CACHE_PISA_RO)
+#else
+#define SLAB_CACHE_PISA_RO	__SLAB_FLAG_UNUSED
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab.h b/mm/slab.h
index e94ac63d10dc0..53620e40b216b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -473,7 +473,8 @@ void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
 			 SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
 			 SLAB_TEMPORARY | SLAB_ACCOUNT | \
-			 SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE)
+			 SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE | \
+			 SLAB_CACHE_PISA_RO)
 
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 01c64ef661e7f..d6c00047b1623 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -49,7 +49,7 @@ struct kmem_cache *kmem_cache;
  */
 #define SLAB_NEVER_MERGE (SLAB_DEBUG_FLAGS | SLAB_TYPESAFE_BY_RCU | \
 		SLAB_NOLEAKTRACE | SLAB_FAILSLAB | SLAB_NO_MERGE | \
-		SLAB_OBJ_EXT_IN_OBJ)
+		SLAB_OBJ_EXT_IN_OBJ | SLAB_CACHE_PISA_RO)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT | SLAB_MAY_ACCOUNT)
@@ -377,6 +377,9 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 	if (s)
 		goto out_unlock;
 
+	if (flags & SLAB_CACHE_PISA_RO)
+		flags |= SLAB_SKIP_KFENCE;
+
 	cache_name = kstrdup_const(name, GFP_KERNEL);
 	if (!cache_name) {
 		err = -ENOMEM;
diff --git a/mm/slub.c b/mm/slub.c
index 45e077c7526c2..63609768f4e3f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -46,6 +46,7 @@
 #include <linux/prandom.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <linux/pisa.h>
 #include <linux/sort.h>
 #include <linux/irq_work.h>
 #include <linux/kprobes.h>
@@ -3378,6 +3379,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	if (unlikely(!allow_spin))
 		page = alloc_frozen_pages_nolock(0/* __GFP_COMP is implied */,
 								  node, order);
+	else if (unlikely(flags & __GFP_PISA_RO))
+		page = (struct page *)pisa_alloc_folio(flags, order, node);
 	else if (node == NUMA_NO_NODE)
 		page = alloc_frozen_pages(flags, order);
 	else
@@ -3484,7 +3487,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 	gfp_t alloc_gfp;
 	void *start;
 
-	flags &= gfp_allowed_mask;
+	flags &= gfp_allowed_mask & ~__GFP_PISA_RW;
 
 	flags |= s->allocflags;
 
@@ -3495,9 +3498,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 	alloc_gfp = (flags | __GFP_NOWARN | __GFP_NORETRY) & ~__GFP_NOFAIL;
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
+	if (unlikely(s->flags & SLAB_CACHE_PISA_RO))
+		alloc_gfp = (flags | __GFP_NOWARN) & ~__GFP_NOFAIL;
 
 	slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
 	if (unlikely(!slab)) {
+		if (s->flags & SLAB_CACHE_PISA_RO)
+			return NULL;
 		oo = s->min;
 		alloc_gfp = flags;
 		/*
@@ -8182,6 +8189,11 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
+	if (s->flags & SLAB_CACHE_PISA_RO) {
+		s->allocflags |= __GFP_PISA_RO | __GFP_ZERO;
+		order = clamp_t(unsigned int, order, 2, PAGE_ALLOC_COSTLY_ORDER);
+	}
+
 	/*
 	 * For kmalloc caches we enable sheaves later by
 	 * bootstrap_kmalloc_sheaves() to avoid recursion.
-- 
2.56.0.542.g3ef89b7020-goog

