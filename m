Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883249C4D2
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141560; cv=none; b=p5MEwm02LBe4+AL4hAwUtjtYhKUaWGZXkhx9aYKfH9sZeTZ9zLSJ9jHR48pX1rn4O+SFcgMAaNsfnUiMcOr0Bc1m6SVNFM1VG0VUyN5Q2IJASffXDkH2mSmn725iejxeQb/WxduHcFkD++YoOu10VWYJF1sE/PhZkw9v8pxLEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141560; c=relaxed/simple;
	bh=o/nuTlqRX+mJR2sIjhL71ai5NXB8U8gBYkqD7yDxOwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3kbtToV3GhXSsItrkeYXdeiGDckLiDM0yUaaSdGcuYgsMosTOVsP9ZDRwvW/sJ7pryQ6eXEJTlAnt+uy3NpRyOFkqjSsxXPpgJLvZucoNKZi+9M2LB2x96r8heFBRON5bXTY5oIvZIolI1NQc49skge+wogJEsFaEZ/IlQyPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr4agfvQ; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr4agfvQ"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d952ac253dso5984345ad.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789141558; x=1789746358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kUuqELK1QtIdlXzlFmG0wXr2/kyNd/dtDl+QfsbVkXg=;
        b=Nr4agfvQezyjY3hVktaQDptt7r4az/RX4iL/E70OOiN2SnDYGvQcWNZ4VgO3dGtYS6
         cZWTBvCeZz+cNC5GlM5AWlBPXmKBN2B/GdXKvhCKn6S+Czt1dIVTVGGfRMg2ERSE9Zh0
         u56P90bjDZDS7lsfByvMSNWRbg5+O6sgluKb42HEAQxOqu86gG78bKg6qwGnFg3sGgNq
         YEnCtCtzrax6eQuBaUlOKxiSGfhzB3cScx5I9KBTi1w0yRcSzIJKA+Bb9OHRSGG5ipfe
         jjtPjCUcnoMRzanyHEOsmYnmjJj1GjzwB1WFIA95bnXJIUJdpc/opK1EDnzV3Op/7hmY
         5GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141558; x=1789746358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kUuqELK1QtIdlXzlFmG0wXr2/kyNd/dtDl+QfsbVkXg=;
        b=QqWUr5ClGl2Uoz4pIcAjoxNztjBcdtvbtznS3DW4nXtay4UO0IJbRbnkfExJAlzI4R
         PdthyvdEWJV9osd/8mKhWjzyoNNqFyNIMy3z8vZV/aYOpT8XG1txR5opfzk+0ZiQEjFZ
         EZhkp1tLtup0cxP34v1dIznkq9bu6Z5mxa0DiEYXDdv/YWrcbaAuzxe0nAZIYSVngZg1
         vEGzMKfWUxKLCfIVL2sfgE3PLGjKJ9m+lMu/GCYAPVE0JXhA0HMZX3vwJSKqp/ag9M/f
         dR9b/BGgr3NkL73jsD1h7uDDkCmJwHVncEU9srgdorWekiS3x0I8SwiBZAHuReBay65k
         gwQQ==
X-Gm-Message-State: AFuF++lWpIkjq9IijEW4u96vlAlLDyk+nEuXZSvHGRYNxhexmsAuxs32
	cF865u3WWdRNTBGHhaXt9YTe9aThr2ZGN0hrSg/t+/MOXGj75QDdzEX6C6FueeCA
X-Gm-Gg: AYBFou3w+exI0mxqh+b7mEgZKWn9e3jWLGSTCAzbI7lz1v9Ep6I4kBBRU9K4z+RlRBy
	j8FruKGHZ49fGGoHxHNHJlEzrofUGRDpU/wYp1aFqfWD0g++hwbW3EEyGOUyLiKCWHt+nS4aRM3
	8DXgGxf94Yzl17Va1UUe3IF9mjRI+/xUSOKYoN0zfLINnsvK2ZAbfVI2ZxVgLMwstV/+MYNe/7t
	fcls3c7HSA9sT6+R1U+DW8UuJEQ6nOLjkPiFvyOKxRHXDoz85g6+9P29eYopz6G3PFZHSzeeJWO
	sdf6H+L6VxwXHKE41J0ff+nt+o0A6BUGEs6hgIWY8MzdlNAj2dnrhrSeaw/x1I2bHUjOcT7uRer
	elM09ZLA8z4CEhfz2i2izpgb3fv1KXg2jlt0Yav87Y/L8ojMcENoX8DJ+c6j+nRv8NMxhv9spPB
	VtLe75qmdVwuP6rZjV22zT0YUFmI9ies+Oyv46b2k5pciaRJZfT0lWYr5KsTWWuzQYQ0FqxkdxI
	Po=
X-Received: by 2002:a17:903:19d0:b0:2db:20fa:9443 with SMTP id d9443c01a7336-2dd2a332f4fmr92415715ad.13.1789141557759;
        Fri, 11 Sep 2026 08:45:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2c825ff5sm14200065ad.0.2026.09.11.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:45:57 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: devmem: replace gen_pool with freelist
Date: Fri, 11 Sep 2026 08:45:53 -0700
Message-ID: <20260911154555.739041-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911154555.739041-1-sdf@fomichev.me>
References: <20260911154555.739041-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devmem only needs fixed-size net_iov allocations for each dma-buf binding.
The gen_pool tracks the same free set indirectly through DMA addresses,
which makes devmem depend on the generic allocator even though the users
are fixed-size net_iov chunks.

Mirror the io_uring zcrx model more closely by keeping a binding-level
freelist protected by spin_lock_bh(). Use a single net_iov_area owner for
the binding, populate each net_iov's DMA address while walking the SG
table, and check at teardown that all net_iovs have returned to the
freelist.

Drop the NET_DEVMEM select of GENERIC_ALLOCATOR now that devmem no longer
calls gen_pool APIs.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/Kconfig       |   1 -
 net/core/devmem.c | 172 +++++++++++++++++++++-------------------------
 net/core/devmem.h |  16 ++---
 3 files changed, 85 insertions(+), 104 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index e38477393551..76ab44aa439a 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -68,7 +68,6 @@ config SKB_EXTENSIONS
 
 config NET_DEVMEM
 	def_bool y
-	select GENERIC_ALLOCATOR
 	depends on DMA_SHARED_BUFFER
 	depends on PAGE_POOL
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index f4d60654ce7f..4883eb7f3a95 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/dma-buf.h>
-#include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
@@ -30,23 +29,13 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
-static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
-					       struct gen_pool_chunk *chunk,
-					       void *not_used)
+static void
+net_devmem_dmabuf_free_chunk_owner(struct dmabuf_genpool_chunk_owner *owner)
 {
-	struct dmabuf_genpool_chunk_owner *owner = chunk->owner;
-
-	kvfree(owner->area.niovs);
-	kfree(owner);
-}
-
-static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
-{
-	struct dmabuf_genpool_chunk_owner *owner;
-
-	owner = net_devmem_iov_to_chunk_owner(niov);
-	return owner->base_dma_addr +
-	       ((dma_addr_t)net_iov_idx(niov) << owner->binding->niov_shift);
+	if (owner) {
+		kvfree(owner->area.niovs);
+		kfree(owner);
+	}
 }
 
 static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
@@ -62,24 +51,18 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
 
-	size_t size, avail;
-
-	gen_pool_for_each_chunk(binding->chunk_pool,
-				net_devmem_dmabuf_free_chunk_owner, NULL);
-
-	size = gen_pool_size(binding->chunk_pool);
-	avail = gen_pool_avail(binding->chunk_pool);
-
-	if (!WARN(size != avail, "can't destroy genpool. size=%zu, avail=%zu",
-		  size, avail))
-		gen_pool_destroy(binding->chunk_pool);
+	WARN(binding->free_count != binding->total_niovs,
+	     "can't destroy dmabuf binding. total=%zu, free=%zu",
+	     binding->total_niovs, binding->free_count);
 
+	net_devmem_dmabuf_free_chunk_owner(binding->chunk_owner);
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  binding->direction);
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
+	kvfree(binding->freelist);
 	kvfree(binding->tx_vec);
 	kfree(binding);
 }
@@ -87,21 +70,16 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
-	struct dmabuf_genpool_chunk_owner *owner;
-	unsigned long dma_addr;
 	struct net_iov *niov;
-	ssize_t offset;
-	ssize_t index;
-
-	dma_addr = gen_pool_alloc_owner(binding->chunk_pool,
-					1UL << binding->niov_shift,
-					(void **)&owner);
-	if (!dma_addr)
+	spin_lock_bh(&binding->freelist_lock);
+	if (unlikely(!binding->free_count)) {
+		spin_unlock_bh(&binding->freelist_lock);
 		return NULL;
+	}
 
-	offset = dma_addr - owner->base_dma_addr;
-	index = offset >> binding->niov_shift;
-	niov = &owner->area.niovs[index];
+	niov = binding->freelist[--binding->free_count];
+	binding->freelist[binding->free_count] = NULL;
+	spin_unlock_bh(&binding->freelist_lock);
 
 	niov->desc.pp_magic = 0;
 	niov->desc.pp = NULL;
@@ -113,14 +91,15 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 void net_devmem_free_dmabuf(struct net_iov *niov)
 {
 	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
-	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
-	size_t niov_size = 1UL << binding->niov_shift;
 
-	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
-				       niov_size)))
+	spin_lock_bh(&binding->freelist_lock);
+	if (WARN_ON_ONCE(binding->free_count >= binding->total_niovs)) {
+		spin_unlock_bh(&binding->freelist_lock);
 		return;
+	}
 
-	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
+	binding->freelist[binding->free_count++] = niov;
+	spin_unlock_bh(&binding->freelist_lock);
 }
 
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
@@ -194,12 +173,15 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
+	struct dmabuf_genpool_chunk_owner *owner;
 	size_t niov_size = 1UL << niov_shift;
 	static u32 id_alloc_next;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
-	unsigned int sg_idx, i;
-	unsigned long virtual;
+	unsigned int sg_idx;
+	size_t total_niovs;
+	size_t niov_idx;
+	size_t i;
 	int err;
 
 	if (!dma_dev) {
@@ -230,6 +212,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		goto err_free_binding;
 
 	mutex_init(&binding->lock);
+	spin_lock_init(&binding->freelist_lock);
 
 	binding->dmabuf = dmabuf;
 	binding->direction = direction;
@@ -262,20 +245,10 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			goto err_unmap;
 		}
 	}
-
-	binding->chunk_pool = gen_pool_create(niov_shift,
-					      dev_to_node(&dev->dev));
-	if (!binding->chunk_pool) {
-		err = -ENOMEM;
-		goto err_tx_vec;
-	}
-
-	virtual = 0;
+	total_niovs = 0;
 	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
 		dma_addr_t dma_addr = sg_dma_address(sg);
-		struct dmabuf_genpool_chunk_owner *owner;
 		size_t len = sg_dma_len(sg);
-		struct net_iov *niov;
 
 		if (!IS_ALIGNED(dma_addr, niov_size) ||
 		    !IS_ALIGNED(len, niov_size)) {
@@ -283,63 +256,74 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			NL_SET_ERR_MSG_FMT(extack,
 					   "dmabuf sg entry (addr=%pad, len=%zu) not aligned to niov size %zu",
 					   &dma_addr, len, niov_size);
-			goto err_free_chunks;
+			goto err_tx_vec;
 		}
 
-		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
-				     dev_to_node(&dev->dev));
-		if (!owner) {
-			err = -ENOMEM;
-			goto err_free_chunks;
-		}
+		total_niovs += len >> niov_shift;
+	}
 
-		owner->area.base_virtual = virtual;
-		owner->base_dma_addr = dma_addr;
-		owner->area.num_niovs = len >> niov_shift;
-		owner->binding = binding;
+	binding->freelist = kvmalloc_array(total_niovs,
+					   sizeof(binding->freelist[0]),
+					   GFP_KERNEL);
+	if (!binding->freelist) {
+		err = -ENOMEM;
+		goto err_tx_vec;
+	}
+	binding->total_niovs = total_niovs;
 
-		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
-					 dma_addr, len, dev_to_node(&dev->dev),
-					 owner);
-		if (err) {
-			kfree(owner);
-			err = -EINVAL;
-			goto err_free_chunks;
-		}
+	owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
+			     dev_to_node(&dev->dev));
+	if (!owner) {
+		err = -ENOMEM;
+		goto err_free_freelist;
+	}
 
-		owner->area.niovs = kvmalloc_objs(*owner->area.niovs,
-						  owner->area.num_niovs);
-		if (!owner->area.niovs) {
-			err = -ENOMEM;
-			goto err_free_chunks;
-		}
+	owner->area.num_niovs = total_niovs;
+	owner->binding = binding;
+	owner->area.niovs = kvmalloc_objs(*owner->area.niovs,
+					  owner->area.num_niovs);
+	if (!owner->area.niovs) {
+		err = -ENOMEM;
+		goto err_free_owner;
+	}
+	binding->chunk_owner = owner;
+
+	niov_idx = 0;
+	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		size_t len = sg_dma_len(sg);
+		struct net_iov *niov;
+		size_t nr_niovs = len >> niov_shift;
 
-		for (i = 0; i < owner->area.num_niovs; i++) {
-			niov = &owner->area.niovs[i];
+		for (i = 0; i < nr_niovs; i++, niov_idx++) {
+			niov = &owner->area.niovs[niov_idx];
 			net_iov_init(niov, &owner->area, NET_IOV_DMABUF);
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
-						      net_devmem_get_dma_addr(niov));
+						      dma_addr);
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->tx_vec[niov_idx] = niov;
+			binding->freelist[binding->free_count++] = niov;
+			dma_addr += niov_size;
 		}
-
-		virtual += len;
 	}
 
 	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
 			      binding, xa_limit_32b, &id_alloc_next,
 			      GFP_KERNEL);
 	if (err < 0)
-		goto err_free_chunks;
+		goto err_free_chunk_owner;
 
 	list_add(&binding->list, &priv->bindings);
 
 	return binding;
 
-err_free_chunks:
-	gen_pool_for_each_chunk(binding->chunk_pool,
-				net_devmem_dmabuf_free_chunk_owner, NULL);
-	gen_pool_destroy(binding->chunk_pool);
+err_free_chunk_owner:
+	net_devmem_dmabuf_free_chunk_owner(binding->chunk_owner);
+	goto err_free_freelist;
+err_free_owner:
+	kfree(owner);
+err_free_freelist:
+	kvfree(binding->freelist);
 err_tx_vec:
 	kvfree(binding->tx_vec);
 err_unmap:
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 4a293a7d1149..a5ee2d8d9169 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -14,6 +14,7 @@
 #include <net/netdev_netlink.h>
 
 struct netlink_ext_ack;
+struct dmabuf_genpool_chunk_owner;
 
 struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
@@ -26,7 +27,7 @@ struct net_devmem_dmabuf_binding {
 	 * dereferenced.
 	 */
 	void *vdev;
-	struct gen_pool *chunk_pool;
+	struct dmabuf_genpool_chunk_owner *chunk_owner;
 	/* Protect dev */
 	struct mutex lock;
 
@@ -57,6 +58,11 @@ struct net_devmem_dmabuf_binding {
 	/* rxq's this binding is active on. */
 	struct xarray bound_rxqs;
 
+	spinlock_t freelist_lock ____cacheline_aligned_in_smp;
+	size_t free_count;
+	size_t total_niovs;
+	struct net_iov **freelist;
+
 	/* ID of this binding. Globally unique to all bindings currently
 	 * active.
 	 */
@@ -77,17 +83,9 @@ struct net_devmem_dmabuf_binding {
 };
 
 #if defined(CONFIG_NET_DEVMEM)
-/* Owner of the dma-buf chunks inserted into the gen pool. Each scatterlist
- * entry from the dmabuf is inserted into the genpool as a chunk, and needs
- * this owner struct to keep track of some metadata necessary to create
- * allocations from this chunk.
- */
 struct dmabuf_genpool_chunk_owner {
 	struct net_iov_area area;
 	struct net_devmem_dmabuf_binding *binding;
-
-	/* dma_addr of the start of the chunk.  */
-	dma_addr_t base_dma_addr;
 };
 
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
-- 
2.53.0-Meta

