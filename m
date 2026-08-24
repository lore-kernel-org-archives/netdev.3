Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984254418F2
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585386; cv=none; b=I+2tixlvK+S20FD3NCgNSDd2zpmbF2mXB7KDhn1NqeL3YcI0kNaMRvz9ZsMfcyVn2Ip9sHKlV4Iq7vtHLXOA9OKNX65x7xNXENMMN3Ur7dTx3gY3JPDiQ5tSSvfX1lTYtV6I6iRbZuLSskF6eY92Qqxs5UYulteN/o+M6vBqWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585386; c=relaxed/simple;
	bh=Y8jENIUNDeT2CaDx0lPDFpqJK/OjLgdPk5Qq7s+pqKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hWFko/6hiX1psd74vgAdD42J1KzmQlOQaW7crNL7NOydjWlRNxWOjRXGiYPAPUpisDlF13p5SUQzuO0aEwYuQeiReWIaVE54j2keWjHwbpODni0Z0S7y9tKnHPCMhvA3IfLplVzIyj+PgOCCM6zygtBBBz1O8OpPS0wujT/VUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irk2HsTW; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irk2HsTW"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6983e9c028dso2781928a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585381; x=1788190181; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPV7mwpWvFlRgLJpo7McYGSN9ACQlDljrVAQMeggU7g=;
        b=irk2HsTWJIob0bXN0S/1VWBAdk/hIXUxQmHMNj/ZLztvvnPw+e4O7yiNJkdF4vwsnW
         QKpQvDuRRaqPu8LY5wScdbwQI/Z1FaEnzqfoPNo0g0kLxBdcXXikbnPySRuPPss12xzX
         kj6pd9ftfSSi18JSExUYEypmW623o5d2Fv523g9FHmfAtanZiDyssGNk3MY8lSF5I9PE
         EsBWLVBiVz1F2YPRkCDjj97pWQWYfEJTd5uVmpdvSWwEBcRmVkVk2u8fHA+K9FmHQiUv
         fvZ+ngiqC92nqsOd3AH7w6b9NuUiDj9rgLPNycqV2ijbP7ZxEWtfq5qv5mWzbSXFRjuQ
         +UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585381; x=1788190181;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPV7mwpWvFlRgLJpo7McYGSN9ACQlDljrVAQMeggU7g=;
        b=cXq2tFbIoh8ERMdt+9xv2N3pmxuazBFTECTbg4m7XBW+yU5+TH0olfsYVJLgbcbBfR
         J+ODH4qltF9CUBpj4z6HFbS6ZmW+09Qfc58kt6vzoDssYLpJIYx6ao7jFj1Crl66r0D6
         3PzaOaeQOmshrB6VF4ZPiiLxBy/2X7ODs5m3K2hQxoTLO8IxPrxOM+MbY+kAbPotT54Q
         FtXq6kVMd2K2MTJapTtWHgatpcdArq7P99eSmCu3noq2qhkh2+6xj6tDVZlxZDlM++Bu
         RU/FyiL75V44yBLuq8tdc2INQ+ojCXzDof8UUb7b7r7B3agfFlMwf8soNzCfxvPinq1b
         R2Eg==
X-Forwarded-Encrypted: i=1; AHgh+RrfoIw77svBbH1x4NB2OEpn2GaJ01vA2zRfmrUCA8pV0NcEnVLCNZQsg9tsj7dO5gnqwlhIVDU=@vger.kernel.org
X-Gm-Message-State: AFuF++m+qth5yDoiBNTVfjz+X9azuJ9hrz69sL/Y0FdLuDXT1U3w6wHh
	y5ncKndx/TEGWE7wALanyW597prXAIWxkAeeeUnZAmIvOOb+WF6xwmbtAkUKmFVoBfJsIZ7JQYU
	A4N1nbQ==
X-Received: from edro3.prod.google.com ([2002:aa7:d3c3:0:b0:698:6d8c:dd8e])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:321a:b0:6a3:f3dc:d7f3
 with SMTP id 4fb4d7f45d1cf-6a42f216053mr33518684a12.16.1787585381419; Mon, 24
 Aug 2026 08:29:41 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:29:32 +0000
In-Reply-To: <20260824152932.1583506-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260824152932.1583506-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824152932.1583506-6-lrizzo@google.com>
Subject: [PATCH v2 5/5] swiotlb: Implement RX nocopy with fast recycling eviction
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

Conditionally divert receive buffer allocations in page_pool
to the SWIOTLB page allocator.

This only happens when swiotlb usage is below the threshold set by module
parameter swiotlb.nocopy_rx_percent (default 0, range 0..90).
A value of 0 disables the feature.

To prevent existing DRAM or SWIOTLB pages from circulating indefinitely
in the lockless receive ring after changing the parameter at runtime,
__page_pool_put_page() checks residency against the active parameter
state. Mismatched pages are immediately evicted back to their
respective allocators, achieving rapid, lockless mode conversion across
active network streams without requiring interface or queue resets.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/swiotlb.h |  1 +
 kernel/dma/swiotlb.c    |  5 +++++
 net/core/page_pool.c    | 25 ++++++++++++++++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3baf52e6572d0..f4597fd01c52d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -205,6 +205,7 @@ void swiotlb_destroy_compound_page(struct page *page, unsigned int order);
 void swiotlb_safe_put_device(struct device *dev);
 
 extern unsigned int nocopy_tx_percent;
+extern unsigned int nocopy_rx_percent;
 
 /* Track epoch (number of delete operations) for leaf device info. */
 extern atomic_t global_device_epoch;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7b818a796ff96..91f175c34a34e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -129,6 +129,11 @@ struct io_tlb_slot {
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
+/* enable nocopy rx swiotlb and set the percentage of buffers allowed for it. */
+unsigned int nocopy_rx_percent;
+module_param(nocopy_rx_percent, uint, 0644);
+MODULE_PARM_DESC(nocopy_rx_percent, "percentage of swiotlb buffer allowed for nocopy rx");
+
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 
 static void swiotlb_dyn_alloc(struct work_struct *work);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 50ee550fef73a..fe8839a7c70a8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -19,6 +19,7 @@
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
+#include <linux/swiotlb.h>
 #include <linux/page-flags.h>
 #include <linux/mm.h> /* for put_page() */
 #include <linux/poison.h>
@@ -578,10 +579,16 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 						 gfp_t gfp)
 {
+	unsigned int pct = READ_ONCE(nocopy_rx_percent);
 	struct page *page;
 
 	gfp |= __GFP_COMP;
-	page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
+	page = NULL;
+	if (pct && is_swiotlb_active(pool->p.dev))
+		page = swiotlb_alloc_pages(pool->p.dev, pool->p.order, gfp,
+					   pct);
+	if (!page)
+		page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
 	if (unlikely(!page))
 		return NULL;
 
@@ -616,8 +623,9 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
 	if ((gfp & GFP_ATOMIC) == GFP_ATOMIC)
 		gfp |= __GFP_NOWARN;
 
-	/* Don't support bulk alloc for high-order pages */
-	if (unlikely(pp_order))
+	/* Don't support bulk alloc for high-order pages or nocopy SWIOTLB */
+	if (unlikely(pp_order || (READ_ONCE(nocopy_rx_percent) &&
+				  is_swiotlb_active(pool->p.dev))))
 		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
@@ -835,6 +843,17 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 {
 	lockdep_assert_no_hardirq();
 
+	/*
+	 * If runtime nocopy mode toggled, evict circulating buffers immediately
+	 * back to their respective allocators rather than recycling them.
+	 */
+	if (unlikely(!netmem_is_net_iov(netmem) &&
+		     swiotlb_is_nocopy_addr(pool->p.dev, page_to_phys(netmem_to_page(netmem))) !=
+		     (READ_ONCE(nocopy_rx_percent) > 0))) {
+		page_pool_return_netmem(pool, netmem);
+		return 0;
+	}
+
 	/* This allocator is optimized for the XDP mode that uses
 	 * one-frame-per-page, but have fallbacks that act like the
 	 * regular page allocator APIs.
-- 
2.55.0.766.g2966f0265a-goog

