Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF651AFDF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109850; cv=none; b=mgpWSb3vx6xqmMmn44w6PIY8ZnBjPPhB6B2CfuX8eFlk1JtItBNVu0q3PWyXIG1VQ7n1UdS1rOQum/18u/HE1AWTjTZpjRP2qLkKvLpOXhdZLm8my3qXUZP8Dr5dbeoYeGh0i9wIGiDX8fM8ruEwn7cbMBsxHZaqOZrVuwMyswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109850; c=relaxed/simple;
	bh=Q5TkZR39NYgiwWRYBslQEVd5kt9MNO8iAajWHVC2zJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABYXcT9K4+lcclGwMo6wSHvhTAChRl6uBuWWQ3VYatsm7WNTYbnRAxa5637mUBLpW8LSBlSQCKFpZLHVffydNx1Wemf8u8LMbj4HZLbAJ9U6nTJYaYqSOifQB2hNEbJo+zzWUYoYrH15/NM1QoMDgn4TZ5IH5CLzwNaOHYRonrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GULKsRoL; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GULKsRoL"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d561173f9fso1765655ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109831; x=1790714631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cxDLGte0XFPc20u8C8dvpS8ZTxM5ZLPAP2KRl1LHufI=;
        b=GULKsRoL3B1k5oOgZqEvQzT6kYYf+gJ1F6N4aKCxIFoxxrOicumRa3xneYsIakhvqL
         B2MaRSiIDD4kjUKGR7ljFPGYWgf28+egxyweSDkcFXMHo6sj9TI3GgtKmXqO7498KtOV
         vXpcBIMrZRUV7u/LWJniRvpL5tNCllyncQlaLoLRLH+3Iupk+2w30hjHP2Udflr5P2jF
         oKcNMLpHwUVD3Z3sv7Aj5cB1kxju3pM4HsCjqMzXlEa9g3skDpNqxqLJ3XZwMD4uQPHq
         xv9a3obnnlTMizaTRv1q5NRhPcsmaqTkY4WW0HNGrxkzcH9K29+UsmfpYhmsaB79R8Z5
         L2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109831; x=1790714631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cxDLGte0XFPc20u8C8dvpS8ZTxM5ZLPAP2KRl1LHufI=;
        b=I/fKNPjD0BaTkF9Ta0iSqY/KcU7roQ5SIdq4ex5sD9tfmsRUc2cGe0q500M/itW8Oy
         MDq4+/VG9hZu2xPBwt5MR14oEU40erW+sqgSin9so1As+CS5p+DSoAjTdKR7rtwCSnVv
         PT/HNuYXANeT7tFO+a6RluMbuyufmlsTH/lsCn0fJdIQ1dMFtV8rZVwBOSBl0n1hmFz3
         Tidd5xQM0mjNoR8266MmrAhFfDcNldjksjWaiVVvFJV1EqF+Kj0yXQGzn6NxOWD4BMEB
         +/9tQ2hBzgW7IFRCaMrOzu3s7P8P/NizrPKWPr2NeT1TITWxPMvZMAvjGX1yDYZHHlMc
         DWsw==
X-Gm-Message-State: AFuF++mIgXAoeRRWmZgZ0O/9uFJ8cUOjGsAm5t7ZjWWP6Us3CcfXcC1b
	Go0skjk+m4d9xQS4YPuG9bbPKNCbaI6QOd+CrhRxaapn4WTzrJIZMDMOHBLamchC
X-Gm-Gg: AYBFou3VZUqylNyifkIKSLkd5/2eOITSdVeUJqgk0wkPUAfszOiMbERXNVmFTsODeid
	KAYBloqj4QpevqjywEjsi+EnCuGr5SLygj2kHnJrSogjqo5pxALcQR7JzCjaXBt8QWFdCRT1kGx
	EqXHO/12UcwK5fqJLg5vhVD6HYb0iI5vqVvB+IULNZ0MxE2dMFUzMwn/btwzRR1KHLH44aSOlqb
	HnnSllIgENEYoE4uGs9JfzymUywG8UtGRDU9BxIAQXGzxIk1l5g3e/TiZPgZazQf9eeyKBt0qBc
	FlglUkg4EGGxtKd8lLmx8rWlnuiAcPm+w4q14oDu9tRjGucBs/+VDgLcC8P5+hFxxppKeVgo2V4
	UjURkGaf+kcKywDe4udX8xj4hUaez0y1JbV3F7xw1ZufgOcCAblcbwYoerq1MOpq1/7p4eh+dAw
	uCLsWJ4JlqNJm/2ap/EfbQc92rxW6KXpiUClMl1/3vtlTs+4bJinyM79zLg1gI9hI=
X-Received: by 2002:a05:6a21:398f:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3ddf7ccd4cfmr658486637.3.1790109830841;
        Tue, 22 Sep 2026 13:43:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3d5ce8sm99133a12.17.2026.09.22.13.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:43:50 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist helpers
Date: Tue, 22 Sep 2026 13:43:46 -0700
Message-ID: <20260922204348.717198-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922204348.717198-1-sdf@fomichev.me>
References: <20260922204348.717198-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring zero-copy receive and devmem both maintain a bounded LIFO for
net_iovs in a contiguous area. Store the freelist in struct net_iov_area
and provide common push and pop helpers.

Leave synchronization to area owners. Keep devmem's area adjacent to its
lock. Use u32 indices and counts, which halves devmem's freelist storage
on 64-bit systems. Reject devmem areas with more than U32_MAX entries
before narrowing the count. With 4 KiB chunks, the limit is almost 16 TiB.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/netmem.h | 28 ++++++++++++++++++++++++++-
 io_uring/zcrx.c      | 25 +++++++++---------------
 io_uring/zcrx.h      |  4 ----
 net/core/devmem.c    | 46 ++++++++++++++++++++++----------------------
 net/core/devmem.h    |  7 +++----
 5 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index bccacd21b6c3..da885d95ea63 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -101,10 +101,15 @@ struct net_iov {
 struct net_iov_area {
 	/* Array of net_iovs for this area. */
 	struct net_iov *niovs;
-	size_t num_niovs;
+
+	/* Stack of free net_iov indices. */
+	u32 *freelist;
 
 	/* Offset into the dma-buf where this chunk starts.  */
 	unsigned long base_virtual;
+
+	u32 num_niovs;
+	u32 free_count;
 };
 
 static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
@@ -117,6 +122,27 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
 	return niov - net_iov_owner(niov)->niovs;
 }
 
+static inline struct net_iov *net_iov_area_pop(struct net_iov_area *area)
+{
+	u32 idx;
+
+	if (unlikely(!area->free_count))
+		return NULL;
+
+	idx = area->freelist[--area->free_count];
+	return &area->niovs[idx];
+}
+
+static inline void net_iov_area_push(struct net_iov_area *area,
+				     struct net_iov *niov)
+{
+	if (WARN_ON_ONCE(net_iov_owner(niov) != area ||
+			 area->free_count >= area->num_niovs))
+		return;
+
+	area->freelist[area->free_count++] = net_iov_idx(niov);
+}
+
 /* Initialize a niov: stamp the owning area, the memory provider type.
  */
 static inline void net_iov_init(struct net_iov *niov,
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 86d580d4410d..fa6061127b9d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -462,7 +462,7 @@ static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
 		io_unaccount_mem(ifq->user, ifq->mm_account,
 				 area->mem.account_pages);
 
-	kvfree(area->freelist);
+	kvfree(area->nia.freelist);
 	kvfree(area->nia.niovs);
 	kvfree(area->user_refs);
 	kfree(area);
@@ -548,9 +548,10 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	if (!area->nia.niovs)
 		goto err;
 
-	area->freelist = kvmalloc_array(nr_iovs, sizeof(area->freelist[0]),
-					GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!area->freelist)
+	area->nia.freelist = kvmalloc_array(nr_iovs,
+					    sizeof(area->nia.freelist[0]),
+					    GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!area->nia.freelist)
 		goto err;
 
 	area->user_refs = kvmalloc_objs(area->user_refs[0], nr_iovs,
@@ -562,7 +563,7 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 		struct net_iov *niov = &area->nia.niovs[i];
 
 		net_iov_init(niov, &area->nia, NET_IOV_IOURING);
-		area->freelist[i] = i;
+		area->nia.freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
 	}
 
@@ -572,7 +573,7 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 			goto err;
 	}
 
-	area->free_count = nr_iovs;
+	area->nia.free_count = nr_iovs;
 	/* we're only supporting one area per ifq for now */
 	area->area_id = zcrx_next_area_id(ifq);
 	area_reg->rq_area_token = zcrx_area_id_to_token(area->area_id);
@@ -689,22 +690,14 @@ static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 	struct io_zcrx_ifq *ifq = area->ifq;
 
 	guard(spinlock_bh)(&ifq->alloc_lock);
-	if (WARN_ON_ONCE(area->free_count >= area->nia.num_niovs))
-		return;
-	area->freelist[area->free_count++] = net_iov_idx(niov);
+	net_iov_area_push(&area->nia, niov);
 }
 
 static struct net_iov *zcrx_get_free_niov(struct io_zcrx_area *area)
 {
-	unsigned niov_idx;
-
 	lockdep_assert_held(&area->ifq->alloc_lock);
 
-	if (unlikely(!area->free_count))
-		return NULL;
-
-	niov_idx = area->freelist[--area->free_count];
-	return &area->nia.niovs[niov_idx];
+	return net_iov_area_pop(&area->nia);
 }
 
 static void io_zcrx_return_niov(struct net_iov *niov)
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index d4a54b4e17fd..a923291defde 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -36,10 +36,6 @@ struct io_zcrx_area {
 	bool			is_mapped;
 	u16			area_id;
 
-	/* freelist */
-	u32			free_count;
-	u32			*freelist;
-
 	struct io_zcrx_mem	mem;
 };
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index a9d86b5a5588..c1c1872b88de 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -42,10 +42,10 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
 
-	if (binding->freelist)
-		WARN(binding->free_count != binding->area.num_niovs,
-		     "destroying dmabuf binding with outstanding net_iovs: total=%zu, free=%zu",
-		     binding->area.num_niovs, binding->free_count);
+	if (binding->area.freelist)
+		WARN(binding->area.free_count != binding->area.num_niovs,
+		     "destroying dmabuf binding with outstanding net_iovs: total=%u, free=%u",
+		     binding->area.num_niovs, binding->area.free_count);
 
 	kvfree(binding->area.niovs);
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
@@ -54,7 +54,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
-	kvfree(binding->freelist);
+	kvfree(binding->area.freelist);
 	kvfree(binding->tx_vec);
 	kfree(binding);
 }
@@ -67,12 +67,10 @@ net_devmem_alloc_dmabuf_bulk(struct net_devmem_dmabuf_binding *binding,
 
 	spin_lock_bh(&binding->freelist_lock);
 
-	count = min_t(size_t, count, binding->free_count);
-	for (i = 0; i < count; i++) {
-		struct net_iov *niov = binding->freelist[--binding->free_count];
-
-		netmems[i] = net_iov_to_netmem(niov);
-	}
+	count = min(count, binding->area.free_count);
+	for (i = 0; i < count; i++)
+		netmems[i] =
+			net_iov_to_netmem(net_iov_area_pop(&binding->area));
 
 	spin_unlock_bh(&binding->freelist_lock);
 
@@ -84,12 +82,7 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
 	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
 
 	spin_lock_bh(&binding->freelist_lock);
-	if (WARN_ON_ONCE(binding->free_count >= binding->area.num_niovs)) {
-		spin_unlock_bh(&binding->freelist_lock);
-		return;
-	}
-
-	binding->freelist[binding->free_count++] = niov;
+	net_iov_area_push(&binding->area, niov);
 	spin_unlock_bh(&binding->freelist_lock);
 }
 
@@ -228,6 +221,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		goto err_unmap;
 	}
 
+	if ((dmabuf->size >> niov_shift) > U32_MAX) {
+		err = -E2BIG;
+		NL_SET_ERR_MSG(extack, "dmabuf contains too many net_iovs");
+		goto err_unmap;
+	}
+
 	binding->area.base_virtual = 0;
 	binding->area.num_niovs = dmabuf->size >> niov_shift;
 	if (direction == DMA_TO_DEVICE) {
@@ -239,10 +238,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		}
 	} else {
 		spin_lock_init(&binding->freelist_lock);
-		binding->freelist = kvmalloc_array(binding->area.num_niovs,
-						   sizeof(binding->freelist[0]),
-						   GFP_KERNEL);
-		if (!binding->freelist) {
+		binding->area.freelist =
+			kvmalloc_array(binding->area.num_niovs,
+				       sizeof(binding->area.freelist[0]),
+				       GFP_KERNEL);
+		if (!binding->area.freelist) {
 			err = -ENOMEM;
 			goto err_unmap;
 		}
@@ -279,7 +279,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			if (direction == DMA_TO_DEVICE)
 				binding->tx_vec[niov_idx] = niov;
 			else
-				binding->freelist[binding->free_count++] = niov;
+				net_iov_area_push(&binding->area, niov);
 			dma_addr += niov_size;
 		}
 	}
@@ -297,7 +297,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 err_free_niovs:
 	kvfree(binding->area.niovs);
 err_free_freelist:
-	kvfree(binding->freelist);
+	kvfree(binding->area.freelist);
 	kvfree(binding->tx_vec);
 err_unmap:
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
diff --git a/net/core/devmem.h b/net/core/devmem.h
index f71d9a2bcb3d..5edb763b89b2 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -17,6 +17,9 @@ struct netlink_ext_ack;
 
 struct net_devmem_dmabuf_binding {
 	struct net_iov_area area;
+	/* Protects area.freelist and area.free_count. */
+	spinlock_t freelist_lock;
+
 	struct dma_buf *dmabuf;
 	struct dma_buf_attachment *attachment;
 	struct sg_table *sgt;
@@ -57,10 +60,6 @@ struct net_devmem_dmabuf_binding {
 	/* rxq's this binding is active on. */
 	struct xarray bound_rxqs;
 
-	spinlock_t freelist_lock ____cacheline_aligned_in_smp;
-	size_t free_count;
-	struct net_iov **freelist;
-
 	/* ID of this binding. Globally unique to all bindings currently
 	 * active.
 	 */
-- 
2.53.0-Meta

