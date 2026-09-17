Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2E4FD269
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668684; cv=none; b=CuZ4eckCKCeGVP5CLflB9xPLmeiudOTecLn9p2aDw0E6uwMM2Mg1mQgD+KSv+mEBqMA9ZYtl+YydEclKD7bKdEnkbHQZaai6o1R9lJaAI07udpSgnc3OuRObVDYeDxE18Dl0Mk9iFy3Zl74ZUoFe0mpN+CEU/BVsZeFqHUxDNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668684; c=relaxed/simple;
	bh=YozIsMvQDzfNdXt3OLFHnc8aWl9/GFlZtvg1jfBFGhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njadq5g+DRJ3ZDchGbsHaifCCPKe8ySuaD/yi408qaWOyR1HwN5mDFnZnNYxdG4Fnet2J8hNbzE8QkObOy5sHXZCdggqpa+BEBPVDJRf3OdSILS864594RHPINA5JEgVkCoYD9bouPV4UKyGT2HnTA6o8TIq5wMAmNBEyL3pTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDxniRGk; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDxniRGk"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cbb818e57c9so479793a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668679; x=1790273479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJwoQyONWQntFcfUwerIyiwwlB2/wy713uP/MmK5r2A=;
        b=DDxniRGkWuiublWw19MFDBsyir4MqHziN6WDJdHb3OnmGwaxMlTKhhvzUwBSs1Mm0+
         R9MOp8K3Aswm4hZaLUDt0qq/8llihFc3LVdiQq1yjxzgjJ7WF+QYYVJ6J838GBj2ZmMI
         NLhmY3BerE0+EPQENaf5ehrZwuZ6rM2discdTpck6CAXGwNbnRhtxCT8UVAw6ZtC4U8H
         8+Zi3mAfSOXFc95ghjmf3JJc5/DPqcj6Y2M5kBhN88RUliDixrKqAXIt69XiuvAASiWY
         IDSCU9UwjdEyb5NzjuISrh6n2ZtyKcnHbyhTIq8MAGMgFdbCJJQ+r9l3gQx1rut/kW/K
         iFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668679; x=1790273479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJwoQyONWQntFcfUwerIyiwwlB2/wy713uP/MmK5r2A=;
        b=pFrdiGUvXn2N1JZe1c31/04+JzovtMMcrV+uueoZJXKWv++FKM4UNqavz4lGZYS5HI
         v/RuKIVHJhhVYxXsIMboG7sma8wvgzupvFG1Wmd9GkgkKKzHjAFTgpdyOery3iTgWqXT
         Yx4kzUAx+Qyab8IluqmIgjvHpufd9BUtu4atoh88T+Ndexow5nSfMENroALALA048Tup
         lZmPhZO5cQVB5qJgVoD/igVoUFW4qbDh9fUklAzZMeS6gwyFILH32F1oeI3ajEy3a0lQ
         fJ5DNxsF4VMCTq5bHpqClD2+AwGzKzrkZqyz6p7Tvk7lV0oVz1U8AN6GaVe6xEVnPt53
         yAGA==
X-Gm-Message-State: AFuF++kV/onc2js42XeiUnPUDBp89ScLUqdh0wJhSyO3kRJeATzD0mDZ
	+Vz6zbUfVf5LfCy18a6JFDg3AuDZt3nk0nDYMzu8x208452vakgd4+hnPCoryEo1
X-Gm-Gg: AYBFou1ov9itswNd3GbL+m7zz8j/dUnkAJX1z6qZKOlCIU7Pl+ALEzuj9Do8A89uvpO
	OytM9CLpc9si2a98uJBDrkdtPGtv/UphvMmJLwyEZ8fmD5+lcfBqlH/UGRlcUIjM8/GswsYTxDh
	7effdaDqhxqpsGQGWNDm+hGW9ExLwiccvnpZtzeohcgJ78czkUqlJIyCo0L7nSEeiO+/2Jg4Maj
	/JnlVlm7krmVv6CYbw6PvbHCVOp2xrTiuns82trkQy555+dkD6LQhdDMdyah0seonOkU1w4Bx96
	ztLd/lTzzCJfHu42X0/MGa7kCQo72ILIrFGLJHHV5mIimxOoap/R5z7eN9oYmIEd3Gf2eiB09pI
	qw518hIQ6HbZx/UTGAas+ZnfjM4gVRDX7b5O2vdl8HzoZPAeyNZFOnOQcvOIpX3liKic1XnY9qH
	NKpXxc6BRnOBLQk/i4MeMDIRUJTdX3YA83L/Z/r5PBLQw7QqQZooZU4P+5kxkX8zgM
X-Received: by 2002:a05:6a21:9086:b0:3d2:5eb3:596 with SMTP id adf61e73a8af0-3dd5f57c1admr19617115637.16.1789668679280;
        Thu, 17 Sep 2026 11:11:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5256e04c7sm1192926a12.22.2026.09.17.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:11:18 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/3] net: devmem: embed net_iov_area in binding
Date: Thu, 17 Sep 2026 11:11:15 -0700
Message-ID: <20260917181116.3319017-3-sdf@fomichev.me>
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

After replacing the gen_pool with a binding-level freelist, devmem no
longer needs a separate chunk owner object. There is only one
net_iov_area for the binding, so store it directly in struct
net_devmem_dmabuf_binding.

Derive the binding from net_iov_owner() with container_of(), matching the
pattern used by io_uring zcrx. This removes the leftover
dmabuf_genpool_chunk_owner wrapper and its allocation/free path.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/devmem.c | 61 ++++++++++++++---------------------------------
 net/core/devmem.h | 25 +++++--------------
 2 files changed, 24 insertions(+), 62 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 2ac9d74010a9..7cac0dab8ea8 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -29,15 +29,6 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
-static void
-net_devmem_dmabuf_free_chunk_owner(struct dmabuf_genpool_chunk_owner *owner)
-{
-	if (owner) {
-		kvfree(owner->area.niovs);
-		kfree(owner);
-	}
-}
-
 static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 {
 	struct net_devmem_dmabuf_binding *binding =
@@ -52,12 +43,11 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
 
 	if (binding->freelist)
-		WARN(binding->free_count != binding->chunk_owner->area.num_niovs,
+		WARN(binding->free_count != binding->area.num_niovs,
 		     "destroying dmabuf binding with outstanding net_iovs: total=%zu, free=%zu",
-		     binding->chunk_owner->area.num_niovs,
-		     binding->free_count);
+		     binding->area.num_niovs, binding->free_count);
 
-	net_devmem_dmabuf_free_chunk_owner(binding->chunk_owner);
+	kvfree(binding->area.niovs);
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  binding->direction);
 	dma_buf_detach(binding->dmabuf, binding->attachment);
@@ -94,8 +84,7 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
 	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
 
 	spin_lock_bh(&binding->freelist_lock);
-	if (WARN_ON_ONCE(binding->free_count >=
-			 binding->chunk_owner->area.num_niovs)) {
+	if (WARN_ON_ONCE(binding->free_count >= binding->area.num_niovs)) {
 		spin_unlock_bh(&binding->freelist_lock);
 		return;
 	}
@@ -175,13 +164,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
-	struct dmabuf_genpool_chunk_owner *owner;
 	size_t niov_size = 1UL << niov_shift;
 	static u32 id_alloc_next;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx;
-	size_t total_niovs;
 	size_t niov_idx;
 	size_t i;
 	int err;
@@ -241,16 +228,18 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		goto err_unmap;
 	}
 
-	total_niovs = dmabuf->size >> niov_shift;
+	binding->area.base_virtual = 0;
+	binding->area.num_niovs = dmabuf->size >> niov_shift;
 	if (direction == DMA_TO_DEVICE) {
-		binding->tx_vec = kvmalloc_objs(struct net_iov *, total_niovs);
+		binding->tx_vec = kvmalloc_objs(struct net_iov *,
+						binding->area.num_niovs);
 		if (!binding->tx_vec) {
 			err = -ENOMEM;
 			goto err_unmap;
 		}
 	} else {
 		spin_lock_init(&binding->freelist_lock);
-		binding->freelist = kvmalloc_array(total_niovs,
+		binding->freelist = kvmalloc_array(binding->area.num_niovs,
 						   sizeof(binding->freelist[0]),
 						   GFP_KERNEL);
 		if (!binding->freelist) {
@@ -258,24 +247,13 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			goto err_unmap;
 		}
 	}
-	owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
-			     dev_to_node(&dev->dev));
-	if (!owner) {
+	binding->area.niovs = kvmalloc_objs(*binding->area.niovs,
+					    binding->area.num_niovs);
+	if (!binding->area.niovs) {
 		err = -ENOMEM;
 		goto err_free_freelist;
 	}
 
-	owner->area.base_virtual = 0;
-	owner->area.num_niovs = total_niovs;
-	owner->binding = binding;
-	owner->area.niovs = kvmalloc_objs(*owner->area.niovs,
-					  owner->area.num_niovs);
-	if (!owner->area.niovs) {
-		err = -ENOMEM;
-		goto err_free_owner;
-	}
-	binding->chunk_owner = owner;
-
 	niov_idx = 0;
 	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
 		dma_addr_t dma_addr = sg_dma_address(sg);
@@ -289,13 +267,13 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			NL_SET_ERR_MSG_FMT(extack,
 					   "dmabuf sg entry (addr=%pad, len=%zu) not aligned to niov size %zu",
 					   &dma_addr, len, niov_size);
-			goto err_free_chunk_owner;
+			goto err_free_niovs;
 		}
 
 		nr_niovs = len >> niov_shift;
 		for (i = 0; i < nr_niovs; i++, niov_idx++) {
-			niov = &owner->area.niovs[niov_idx];
-			net_iov_init(niov, &owner->area, NET_IOV_DMABUF);
+			niov = &binding->area.niovs[niov_idx];
+			net_iov_init(niov, &binding->area, NET_IOV_DMABUF);
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      dma_addr);
 			if (direction == DMA_TO_DEVICE)
@@ -310,17 +288,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			      binding, xa_limit_32b, &id_alloc_next,
 			      GFP_KERNEL);
 	if (err < 0)
-		goto err_free_chunk_owner;
+		goto err_free_niovs;
 
 	list_add(&binding->list, &priv->bindings);
 
 	return binding;
 
-err_free_chunk_owner:
-	net_devmem_dmabuf_free_chunk_owner(binding->chunk_owner);
-	goto err_free_freelist;
-err_free_owner:
-	kfree(owner);
+err_free_niovs:
+	kvfree(binding->area.niovs);
 err_free_freelist:
 	kvfree(binding->freelist);
 	kvfree(binding->tx_vec);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index db2eb6372aee..6ed16b4b4687 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -14,9 +14,9 @@
 #include <net/netdev_netlink.h>
 
 struct netlink_ext_ack;
-struct dmabuf_genpool_chunk_owner;
 
 struct net_devmem_dmabuf_binding {
+	struct net_iov_area area;
 	struct dma_buf *dmabuf;
 	struct dma_buf_attachment *attachment;
 	struct sg_table *sgt;
@@ -27,7 +27,6 @@ struct net_devmem_dmabuf_binding {
 	 * dereferenced.
 	 */
 	void *vdev;
-	struct dmabuf_genpool_chunk_owner *chunk_owner;
 	/* Protect dev */
 	struct mutex lock;
 
@@ -82,11 +81,6 @@ struct net_devmem_dmabuf_binding {
 };
 
 #if defined(CONFIG_NET_DEVMEM)
-struct dmabuf_genpool_chunk_owner {
-	struct net_iov_area area;
-	struct net_devmem_dmabuf_binding *binding;
-};
-
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
@@ -101,18 +95,11 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack);
 
-static inline struct dmabuf_genpool_chunk_owner *
-net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
-{
-	struct net_iov_area *owner = net_iov_owner(niov);
-
-	return container_of(owner, struct dmabuf_genpool_chunk_owner, area);
-}
-
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_iov_binding(const struct net_iov *niov)
 {
-	return net_devmem_iov_to_chunk_owner(niov)->binding;
+	return container_of(net_iov_owner(niov),
+			    struct net_devmem_dmabuf_binding, area);
 }
 
 static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
@@ -122,11 +109,11 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 
 static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 {
-	struct dmabuf_genpool_chunk_owner *co =
-		net_devmem_iov_to_chunk_owner(niov);
+	struct net_devmem_dmabuf_binding *binding =
+		net_devmem_iov_binding(niov);
 
 	return net_iov_owner(niov)->base_virtual +
-	       ((unsigned long)net_iov_idx(niov) << co->binding->niov_shift);
+	       ((unsigned long)net_iov_idx(niov) << binding->niov_shift);
 }
 
 static inline bool
-- 
2.53.0-Meta

