Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36549EC67
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062590; cv=none; b=nv8wTyvwf4eHrk778etbJRKdX3YDqe6QUnPxJyWig9+o78qGYewXlg5m8R1l7MttPHX1kH946gA6kAfaUqqjXHAUW+OV6cunLOeYXB0kAIANruXkRTM30BWqkHf5HALN+quXyx+iHXsYTLwE2v46X3u9iJnEGdE6SNq9UpN4dkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062590; c=relaxed/simple;
	bh=7/+K5UbPoLVagSVVzP6ds9SnbBN5AQfhr70LFIIqoBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GlY9TnXYqePbYhi8fm/AekFx3qVUlRyQiDDVvf1f9O6xBVp9mO139x0tpcA+UEPnbF/ettx9PufJe+wP2cT4H6leWuG3g1k8CByAd9TenjGJa5LZmPsk/wxp19yrzzjfKUXnwyI0/7p2tHIL0FyQTYvi/R1fSd0usFfCVAKsAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGrZLVIF; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGrZLVIF"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e6affec80so71661466b.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062583; x=1791667383; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Y6eccMU3oNOC6nPRXFDlu2gRIyDfLt0ekbGijFBkOg=;
        b=fGrZLVIFCBViVUFrMfdnmp0BRQfbj2ypV08ZfOadC6iiQsZBU+XKMDlVyaVk+nvzz0
         fySaTe85YkJBXuxQ5+DAgOvEvPkgrHrtqDKfxaERDdaNMDWwLEg3jGw03kHN9njIFfCH
         7oI37+VbWKORjbaGKNgIBmjc88WTo1JagMR176Wg62kw/iVnEe9lAFK3/ZZ14bXuNnMz
         H0+yEMX/G/aZg2bvc2c65/nBoni6Ly08Az0oc9doElsG6WtZ4heeY12GwFztvXmzf7Rg
         MGSJ5ieTJgM1hqoFyafNCRrQG11rtYvf7Td573CqaZ629mA/uWynmwmnFvBjWluuCi4f
         0SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062583; x=1791667383;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Y6eccMU3oNOC6nPRXFDlu2gRIyDfLt0ekbGijFBkOg=;
        b=x+dDC8plYjQtyHqbSDBZuJsmOR7Nu3Fa2daNOjZgXmqwB5SPlCk/3U6RpoOBALgeEM
         ntN9eTW7ksul4cpbldO8ZZoKI1HYn3P8r15G3VQ87TYEzhxFrHYCexWWf8uzsoo+3x+Z
         QXNr/2dlBAKvmp/LBmjRqRej+vVh5WiaQwtfUhkwgVwAmwyA8qQhGVfBvkdMTrDL2KhY
         jbnlA4zX6M4Kt6KgP6CH++JRz7cj4uxV6bJl9kZYJKXCqXEETf6zKsMn6Aa6ZEZAkOgB
         20yTZcE/t2Q3CLvGIA/7Ocmiqay++KcbrWkeSTa0WnXDZbn6zxcZNKwRcExB5cxKsfqd
         050g==
X-Forwarded-Encrypted: i=1; AKwUvByDbbz5odlopC2hMZ8Gu+bb2tQ+184mazk9QAt/ChAmqhga7sO4xqw2mKyMP7mH/t+cTG2n6qM=@vger.kernel.org
X-Gm-Message-State: AFuF++lI1ExUCtdH/Q9Yc3+vY61fs9p4qm/n12xatYR1ZcObnLKxkPtL
	0irKZbqHPGGMICQOhBzs3vnLriX/WXHdWyyP5jKvPIyKx5Shezpkh0XuHEpjsQWw794ECceJZHP
	S9YI6VQ==
X-Received: from ejbs7.prod.google.com ([2002:a17:906:607:b0:c2e:1f26:6d02])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:72cf:b0:c2d:cbc9:3529
 with SMTP id a640c23a62f3a-c2e4af393e2mr567647366b.20.1791062582284; Sat, 03
 Oct 2026 14:23:02 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:31 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-13-lrizzo@google.com>
Subject: [RFC: DMA_PMD 12/22] net/core: Use per-CPU DMA_PMD pools for skb_page_frag_refill()
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

Add sysctl net.core.tx_enable_dma_pmd to back skb_page_frag_refill() with
per-CPU order-3 (32KB block) and order-0 (4KB block) DMA_PMD page pools.

When enabled, TX socket buffer page fragment allocations draw fragments
from DMA_PMD physical pages registered with per-CPU dma_pmd_pool. The
first allocation maps the entire DMA_PMD page, subsequent allocations
reuse the cached PMD_SIZE IOVA mapping locklessly without per-packet unmap
or IOTLB flush.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/sock.h         |  3 ++
 net/core/sock.c            | 86 +++++++++++++++++++++++++++++++++++++-
 net/core/sysctl_net_core.c |  7 ++++
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60ea55dc18854..a06b53e9ff225 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3092,6 +3092,9 @@ extern __u32 sysctl_rmem_default;
 
 #define SKB_FRAG_PAGE_ORDER	get_order(32768)
 DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
+DECLARE_STATIC_KEY_FALSE(net_tx_enable_dma_pmd_key);
+int net_tx_dma_pmd_sysctl(const struct ctl_table *table, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos);
 
 static inline int sk_get_wmem0(const struct sock *sk, const struct proto *proto)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index e8551df8330ff..1fd338a547ce1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -115,6 +115,7 @@
 #include <linux/memcontrol.h>
 #include <linux/prefetch.h>
 #include <linux/compat.h>
+#include <linux/dma-pmd.h>
 #include <linux/mroute.h>
 #include <linux/mroute6.h>
 #include <linux/icmpv6.h>
@@ -3173,6 +3174,87 @@ static void sk_leave_memory_pressure(struct sock *sk)
 }
 
 DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
+DEFINE_STATIC_KEY_FALSE(net_tx_enable_dma_pmd_key);
+
+static DEFINE_PER_CPU(struct dma_pmd_pool *, tx_pmd_pool_high);
+static DEFINE_PER_CPU(struct dma_pmd_pool *, tx_pmd_pool_order0);
+
+/*
+ * Lazily initialize the per-CPU DMA_PMD page pools on the first write to sysctl
+ * net.core.tx_enable_dma_pmd.
+ *
+ * Once initialized, the struct dma_pmd_pool descriptors remain allocated for
+ * the lifetime of the kernel so that lockless raw_cpu_read() in
+ * __alloc_pmd() is always safe against concurrent sysctl
+ * toggles. If pool creation fails partway through, all pools created so far are
+ * destroyed and per-CPU pointers are reset to NULL.
+ */
+static int net_tx_dma_pmd_init(void)
+{
+	static DEFINE_MUTEX(mutex);
+	struct dma_pmd_pool *pool;
+	static bool initialized;
+	int cpu;
+
+	if (!IS_ENABLED(CONFIG_DMA_PMD))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mutex);
+	if (initialized) {
+		mutex_unlock(&mutex);
+		return 0;
+	}
+
+	for_each_possible_cpu(cpu) {
+		if (SKB_FRAG_PAGE_ORDER) {
+			pool = dma_pmd_pool_create(SKB_FRAG_PAGE_ORDER, 16);
+			if (!pool)
+				goto err_cleanup;
+			per_cpu(tx_pmd_pool_high, cpu) = pool;
+		}
+
+		pool = dma_pmd_pool_create(0, 16);
+		if (!pool)
+			goto err_cleanup;
+		per_cpu(tx_pmd_pool_order0, cpu) = pool;
+	}
+
+	initialized = true;
+	mutex_unlock(&mutex);
+	return 0;
+
+err_cleanup:
+	for_each_possible_cpu(cpu) {
+		per_cpu(tx_pmd_pool_high, cpu) =
+			dma_pmd_pool_destroy(per_cpu(tx_pmd_pool_high, cpu));
+		per_cpu(tx_pmd_pool_order0, cpu) =
+			dma_pmd_pool_destroy(per_cpu(tx_pmd_pool_order0, cpu));
+	}
+	mutex_unlock(&mutex);
+	return -ENOMEM;
+}
+
+int net_tx_dma_pmd_sysctl(const struct ctl_table *table, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (write) {
+		int ret = net_tx_dma_pmd_init();
+
+		if (ret)
+			return ret;
+	}
+
+	return proc_do_static_key(table, write, buffer, lenp, ppos);
+}
+
+static struct page *__alloc_pmd(gfp_t gfp, unsigned int order)
+{
+	if (!static_branch_unlikely(&net_tx_enable_dma_pmd_key))
+		return alloc_pages(gfp, order);
+	if (order == SKB_FRAG_PAGE_ORDER)
+		return dma_pmd_pool_alloc(raw_cpu_read(tx_pmd_pool_high), gfp);
+	return dma_pmd_pool_alloc(raw_cpu_read(tx_pmd_pool_order0), gfp) ?: alloc_page(gfp);
+}
 
 /**
  * skb_page_frag_refill - check that a page_frag contains enough room
@@ -3200,7 +3282,7 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 	if (SKB_FRAG_PAGE_ORDER &&
 	    !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
 		/* Avoid direct reclaim but allow kswapd to wake */
-		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
+		pfrag->page = __alloc_pmd((gfp & ~__GFP_DIRECT_RECLAIM) |
 					  __GFP_COMP | __GFP_NOWARN |
 					  __GFP_NORETRY,
 					  SKB_FRAG_PAGE_ORDER);
@@ -3209,7 +3291,7 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 			return true;
 		}
 	}
-	pfrag->page = alloc_page(gfp);
+	pfrag->page = __alloc_pmd(gfp, 0);
 	if (likely(pfrag->page)) {
 		pfrag->size = PAGE_SIZE;
 		return true;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index eb35da3556f4a..d9a7d9cb349e0 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -651,6 +651,13 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_static_key,
 	},
+	{
+		.procname	= "tx_enable_dma_pmd",
+		.data		= &net_tx_enable_dma_pmd_key.key,
+		.maxlen		= sizeof(net_tx_enable_dma_pmd_key),
+		.mode		= 0644,
+		.proc_handler	= net_tx_dma_pmd_sysctl,
+	},
 	{
 		.procname	= "gro_normal_batch",
 		.data		= &net_hotdata.gro_normal_batch,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

