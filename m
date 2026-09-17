Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2884FC34A
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668683; cv=none; b=Cm6AsqzHOBlB0BTyx153zNlNUWMDIdv6RToAtndF4rBzySAlVztumRa+ifZBphKhQzAj3VBOUGYtl/vpsdIf9Lp73SUHuHWJh7YeP9fNOansZJk6TZ5+rmFZCyAB7oO9JmSgEnokInD60Cn5iII/bKtENV5CBmp3+ncb2sKOEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668683; c=relaxed/simple;
	bh=+xgFA1SB2Xp6UmAnIjOjmJ4KEbqPgxrCzKm51uLQBxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr0EVsJ0u0kny2n+HroFG1cH1djutgMPK9le6R9R1iRVbRWOb3zYD0moV9ckQ3tdRpfEMHiKpVyalZGnc2kSUdvJEwcU8kM83jas0lfKJVOAg+uA1Lla0OI19izX3SRrYqV9xNZAma8jWEwmcDGwkheO8jQEqjVKQvdPdDh7H1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrK3e7Q4; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrK3e7Q4"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc188c38a4cso530086a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668678; x=1790273478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OewrFGRHJOj2WekPA/CAeklK7TzcU4RR3M015GddGVk=;
        b=WrK3e7Q4/une2zNNY0kmCw1Hdy/Cc4fUmwGiiGBskU8qejaor4/3pLd5nFG7WNfUYm
         cqudNmcXP3Kgwk03zI2zqgL+34PMLgLPP/213M8yLOWTwpn1QD0DU5FJXehJqne3kgv9
         7t+G03DGe9FxF/xpfWctrnLvSedNG/89HODuPStiqB9y8anLRQ0UWxJIWY1wQzwMcSlZ
         CNN8robTBdIep1gdMKTglbLOObnBkRvhXCFr+rh1mWFQ8FvR3uPdUlzIoE1kxVlI/pOE
         Ss51pghS4kWwd3WN4WD1mR886KloPRXsAqHNVa2zIkYyjK1sY86kSnAexX6ltu0cuAjj
         mytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668678; x=1790273478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OewrFGRHJOj2WekPA/CAeklK7TzcU4RR3M015GddGVk=;
        b=kCfRscKnoXUCCzWHOjMELfF64srUtmjuEeAhHL8OU1PyUQfddbGdbC+UQ4a5Gx5tT2
         qDEiCoxVP03qZrO5NMMyHquXOBm7WZONGnXBp4yCqwNP6SRmT//guiBw8sxedJ+hKo+P
         qmCDE3ZQv+n/XFxCnizZgoimORAIOjRKAo1blq6J3pNNGj9aSXaQSI6itJ8wSxxgpvLi
         rcbK6TjUlNwQ5DYj+JaAQ3lCUJ57Yj3sEE0uvkr6f0pF/X7XY197fC17zRRDwC+VIxFY
         TOLo5l+KWHSrwasWsj92Ws9i1+wPD/Ag6ZhT/UuiYVXIrkCj+rH3oK+qrK2655Ftivor
         2wyw==
X-Gm-Message-State: AFuF++l6EZMNXPtlypFYUDEAbpiHZljx0zb+/UJJV9/eqcLp5u/1VwiO
	2ZRFwTT47PtaBk7FxgRYGp8LV6NTWcT1zLyHxh5ynmxrm8MTw7tU+KMG0DYHO/x5
X-Gm-Gg: AYBFou18sOj/f944CvPWuOIsxgzoicPLqCc3K0063p64lXJM8PNwUYEkHeYtd9Itnvc
	Y542qt/oiz9shKdQYjR5Xo/0h5kgwChPVHLsVCjCt41FfgyJJArtKsDLl5JLPndD3NbT/RFua30
	FrQqSf9D07NG1rKBnLf2v4rkUmOw8KVM970mlTRyKsPXOl8BkH51824lqj+xBcSi7tfFCXBkPAC
	0DOtQYZ3JF3kbY5OBvAU1Ympwsiy5JmgvqERtnq0nWiOJDWYaZ/rs+VdPxAOFgiI+55LYPykALR
	CBFmNMTfUPIJA1bgn8WYGjH4mMjB8o57pdKtlpucflMNSykrf5dYvLQeQW5ZVHFE7dhHb7CgP4I
	4J+Ax6TB4uin2tsKZGH5u8DtIbdRVtEFA5UDuiHsMYhfZkHSc8QdL8jHWhry5u1avj4O43r4Vi5
	M8joeusqHVT08IiStFAfObkm6MWWgfPg0kuRxODndDZS/dJNGTQ7BYU1j+Wzl4+Kii
X-Received: by 2002:a05:6a00:9291:b0:857:7337:5dba with SMTP id d2e1a72fcca58-8723d4366d8mr14304218b3a.24.1789668678268;
        Thu, 17 Sep 2026 11:11:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872025dd04csm3272663b3a.60.2026.09.17.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:11:17 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/3] net: devmem: replace gen_pool with freelist
Date: Thu, 17 Sep 2026 11:11:14 -0700
Message-ID: <20260917181116.3319017-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917181116.3319017-1-sdf@fomichev.me>
References: <20260917181116.3319017-1-sdf@fomichev.me>
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

Validate the DMA-BUF size against the net_iov size up front and derive the
RX and TX entry count from it, avoiding a separate SG-table pass.

Drop the NET_DEVMEM select of GENERIC_ALLOCATOR now that devmem no longer
calls gen_pool APIs.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/Kconfig       |   1 -
 net/core/devmem.c | 182 +++++++++++++++++++++-------------------------
 net/core/devmem.h |  15 ++--
 3 files changed, 88 insertions(+), 110 deletions(-)

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
index f4d60654ce7f..2ac9d74010a9 100644
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
@@ -62,24 +51,20 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
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
+	if (binding->freelist)
+		WARN(binding->free_count != binding->chunk_owner->area.num_niovs,
+		     "destroying dmabuf binding with outstanding net_iovs: total=%zu, free=%zu",
+		     binding->chunk_owner->area.num_niovs,
+		     binding->free_count);
 
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
@@ -87,21 +72,15 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
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
+	spin_unlock_bh(&binding->freelist_lock);
 
 	niov->desc.pp_magic = 0;
 	niov->desc.pp = NULL;
@@ -113,14 +92,16 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 void net_devmem_free_dmabuf(struct net_iov *niov)
 {
 	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
-	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
-	size_t niov_size = 1UL << binding->niov_shift;
 
-	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
-				       niov_size)))
+	spin_lock_bh(&binding->freelist_lock);
+	if (WARN_ON_ONCE(binding->free_count >=
+			 binding->chunk_owner->area.num_niovs)) {
+		spin_unlock_bh(&binding->freelist_lock);
 		return;
+	}
 
-	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
+	binding->freelist[binding->free_count++] = niov;
+	spin_unlock_bh(&binding->freelist_lock);
 }
 
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
@@ -194,12 +175,15 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
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
@@ -249,33 +233,55 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		goto err_detach;
 	}
 
+	if (!IS_ALIGNED(dmabuf->size, niov_size)) {
+		err = -EINVAL;
+		NL_SET_ERR_MSG_FMT(extack,
+				   "dmabuf size %zu not aligned to niov size %zu",
+				   dmabuf->size, niov_size);
+		goto err_unmap;
+	}
+
+	total_niovs = dmabuf->size >> niov_shift;
 	if (direction == DMA_TO_DEVICE) {
-		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
-			err = -EINVAL;
-			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
+		binding->tx_vec = kvmalloc_objs(struct net_iov *, total_niovs);
+		if (!binding->tx_vec) {
+			err = -ENOMEM;
 			goto err_unmap;
 		}
-		binding->tx_vec = kvmalloc_objs(struct net_iov *,
-						dmabuf->size / PAGE_SIZE);
-		if (!binding->tx_vec) {
+	} else {
+		spin_lock_init(&binding->freelist_lock);
+		binding->freelist = kvmalloc_array(total_niovs,
+						   sizeof(binding->freelist[0]),
+						   GFP_KERNEL);
+		if (!binding->freelist) {
 			err = -ENOMEM;
 			goto err_unmap;
 		}
 	}
+	owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
+			     dev_to_node(&dev->dev));
+	if (!owner) {
+		err = -ENOMEM;
+		goto err_free_freelist;
+	}
 
-	binding->chunk_pool = gen_pool_create(niov_shift,
-					      dev_to_node(&dev->dev));
-	if (!binding->chunk_pool) {
+	owner->area.base_virtual = 0;
+	owner->area.num_niovs = total_niovs;
+	owner->binding = binding;
+	owner->area.niovs = kvmalloc_objs(*owner->area.niovs,
+					  owner->area.num_niovs);
+	if (!owner->area.niovs) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_free_owner;
 	}
+	binding->chunk_owner = owner;
 
-	virtual = 0;
+	niov_idx = 0;
 	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
 		dma_addr_t dma_addr = sg_dma_address(sg);
-		struct dmabuf_genpool_chunk_owner *owner;
 		size_t len = sg_dma_len(sg);
 		struct net_iov *niov;
+		size_t nr_niovs;
 
 		if (!IS_ALIGNED(dma_addr, niov_size) ||
 		    !IS_ALIGNED(len, niov_size)) {
@@ -283,64 +289,40 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			NL_SET_ERR_MSG_FMT(extack,
 					   "dmabuf sg entry (addr=%pad, len=%zu) not aligned to niov size %zu",
 					   &dma_addr, len, niov_size);
-			goto err_free_chunks;
-		}
-
-		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
-				     dev_to_node(&dev->dev));
-		if (!owner) {
-			err = -ENOMEM;
-			goto err_free_chunks;
+			goto err_free_chunk_owner;
 		}
 
-		owner->area.base_virtual = virtual;
-		owner->base_dma_addr = dma_addr;
-		owner->area.num_niovs = len >> niov_shift;
-		owner->binding = binding;
-
-		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
-					 dma_addr, len, dev_to_node(&dev->dev),
-					 owner);
-		if (err) {
-			kfree(owner);
-			err = -EINVAL;
-			goto err_free_chunks;
-		}
-
-		owner->area.niovs = kvmalloc_objs(*owner->area.niovs,
-						  owner->area.num_niovs);
-		if (!owner->area.niovs) {
-			err = -ENOMEM;
-			goto err_free_chunks;
-		}
-
-		for (i = 0; i < owner->area.num_niovs; i++) {
-			niov = &owner->area.niovs[i];
+		nr_niovs = len >> niov_shift;
+		for (i = 0; i < nr_niovs; i++, niov_idx++) {
+			niov = &owner->area.niovs[niov_idx];
 			net_iov_init(niov, &owner->area, NET_IOV_DMABUF);
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
-						      net_devmem_get_dma_addr(niov));
+						      dma_addr);
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->tx_vec[niov_idx] = niov;
+			else
+				binding->freelist[binding->free_count++] = niov;
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
-err_tx_vec:
+err_free_chunk_owner:
+	net_devmem_dmabuf_free_chunk_owner(binding->chunk_owner);
+	goto err_free_freelist;
+err_free_owner:
+	kfree(owner);
+err_free_freelist:
+	kvfree(binding->freelist);
 	kvfree(binding->tx_vec);
 err_unmap:
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 4a293a7d1149..db2eb6372aee 100644
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
 
@@ -57,6 +58,10 @@ struct net_devmem_dmabuf_binding {
 	/* rxq's this binding is active on. */
 	struct xarray bound_rxqs;
 
+	spinlock_t freelist_lock ____cacheline_aligned_in_smp;
+	size_t free_count;
+	struct net_iov **freelist;
+
 	/* ID of this binding. Globally unique to all bindings currently
 	 * active.
 	 */
@@ -77,17 +82,9 @@ struct net_devmem_dmabuf_binding {
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

