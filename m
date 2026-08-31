Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF143030D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201335; cv=none; b=Bo31cEy0Es6ET34ak4XUPN4ycgUOo69gCUNNXAG1GlXCPoTiNHZybgDTs7IjJ1HcSeVdFh94gVbDWwOVc9zzNvGxULrX9VyeLStVUC41KT085fWa45goquzlU0k4iwmILRIxxIKkb5sxHnKZs2HSOquKC+9rPTY2UYNA/0bZu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201335; c=relaxed/simple;
	bh=4iVf7t97UW510/E2DMObHL05eGnOxJRLphj/d0ZxrH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2ueYHutJElL1kt/FYf1DcjvFIUom9ZDt8RhcwTrdNRkOgBaDxax+MWk4zaW9YfLW3UpjL8egDHsz1eIN4SsQwYMW7eZZjuwgaID+BOnfdaXOsbB0S1ZTzqBoZyZv35ZET9ztkqp9ELFEXTmQjzIyWrCeXB0diQgsPsEcPoxthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmO5ZtRA; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmO5ZtRA"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6fbdc8772so16113225ad.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788201332; x=1788806132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v0+SDIEBVHj9mRl1DUgh1GeAd0CNKoJa5JQSnxAm35k=;
        b=pmO5ZtRACD9EUdICV7/N8Sd+dBhJNtkshKPGSgnufh0Z8GQjiFVmKKcDUYlIKgGB36
         RyC80L3//5rmKNs1irSH3G2hYTQ7UxIjCfiPTSO2RCf+jPrEAVJWBAMiPLHic1qRAGFi
         EsFPpwB/EcpRZ83wwEvJkA4WFLMqFEa0FQ1V3Xjv9glf0F0PW5cyRd2u9qQBDFLxzceG
         wlA78acCoIixCtNB5vpV3d/35JOTYMO2hyk65kWAhiui6JD04qbxVXuvpsm421f6Jam0
         119nSggyStUSz9PHywk6ulXwSiUQROhlzG8B7svqccyWOJA8r9x7H9KL2V/atSUNwbnk
         vbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788201332; x=1788806132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v0+SDIEBVHj9mRl1DUgh1GeAd0CNKoJa5JQSnxAm35k=;
        b=gm6rQkcXsg5FHFrP3m0DcgXPsibn/gzOwdtuU0xcKh237BZhCJvCg9ChDrUH+0tKFY
         0d75qfQEjhu+x5ghoa+gruBnQu45sg4Vr2kl0HwDYW22rlZcAUdY/gHjblgoTgyzn241
         95H5ljNJH+ootnxWlm7L7JdXP5hcMInKiAlieItwYhL8veV7Sq8CLOivt0cQH1clWSSs
         ZzFbXJddiSfshIp9SMteZHvpfvpslkskjk55RrgQv8zhrBfgvu9TAS57KGUQRdKevtoc
         PCarNybaBdeGdF/NBdwxNpKIv4CWrTEIfilyvdKhUHfKH76bS8sY57Jp0dFa3qAiwAWx
         Dtvw==
X-Gm-Message-State: AFuF++nbmXea3cBn/p9qjtaDvHDRFtUWuPT5G0wPFtv6XCnf3pvHnm/j
	93wS0SvUuWxqPQyEdXeM+dFfUJKie4RWHAZE1AQly8/LidFyD4d0jC9UOdNa21HI
X-Gm-Gg: AYBFou2vhnhgoVK7mvxfQ+vk8P3+0GbZvHQe//uLqcJse5x748FeR5/Xdks5nluPWo9
	yMFQaj8JfmCTJz/lZTeLr3Y+McmuF4lhWwXlsDCsvU2M+Tx3m7/alNNYKvQLgZ6aUM8PxR0+L5P
	2SngkgyBZaHEsbo7/WEbIwxLo+7xji5JqbhzSHNrOndphMqyCLGK/zhRqu7Bhi7dxoAJiU3X74e
	vwamzvBHYMvgACxMh+mq/KBENbrPy5Y+nVELf3eBMPxKnzzt6zFdwVQFWALWgMf2hQXLS4F54VR
	Ts74TF+mM2QgoEkCA63iam/bOMtceEeO2gIkHi1CMul3cHSufT8tZxoXMkgitA6vbrL6YPMQYUY
	lMSlbBoZUoxs3/BPX/PRfrhAdM6q/AI72sFtx5PG4hORLPtT5ElVNhK9Udt6B648uaKkuXDcdKJ
	pBprfyDfJa9ijpLuDCs8LF9GQfxxy2h/hpn6HQc7Po3+8p9kYr33lGiQ==
X-Received: by 2002:a17:902:ef4e:b0:2d8:d4cd:dc93 with SMTP id d9443c01a7336-2d8d4cddf80mr314186475ad.22.1788201332054;
        Mon, 31 Aug 2026 11:35:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869e32sm39629205ad.49.2026.08.31.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:35:31 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] net: devmem: replace gen_pool with freelist
Date: Mon, 31 Aug 2026 11:35:28 -0700
Message-ID: <20260831183529.2517322-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831183529.2517322-1-sdf@fomichev.me>
References: <20260831183529.2517322-1-sdf@fomichev.me>
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
index f4d60654ce7f..34b3157677e1 100644
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
@@ -198,8 +177,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	static u32 id_alloc_next;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
-	unsigned int sg_idx, i;
-	unsigned long virtual;
+	struct dmabuf_genpool_chunk_owner *owner;
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

