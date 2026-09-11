Received: from mail-pz2-f11.google.com (mail-pz2-f11.google.com [74.125.228.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0D49DB91
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141561; cv=none; b=U83t2p2f0Cxr95mEbw51K9qoiUfDFJ+JWbxBytNZbJjK/CMNOj8BxgCrsWbtcnySw2dsD/1W+lf6rmwUWVljB3Xs61ZKO3VcNldAEYBHL2KoBNe26dT13qPUD8Ew1a9R0OWpBYqfWnuHMrDTMHU1xYxfpiuyDpqu4ms/+8Qe1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141561; c=relaxed/simple;
	bh=RudCEYnuc6J48k1REQnXqckswDqKj6d2EnaaGRHKhIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCePcM7ixEMSNDv/lDHtwFnR1Av/N+OWvyImzQJdGu5z/KwmoD77So42Q9x/mOpAbqTijCmua5IwO4Nv3Euys+vL01NaJ50lfNkp/z2ATH1OD0ClvQh6C6fhhaqUrCEEF5poPOMmqfpWnt9ssQ9FPDU2L6QelNaQZu+8EcQSeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ykz9tFdJ; arc=none smtp.client-ip=74.125.228.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykz9tFdJ"
Received: by mail-pz2-f11.google.com with SMTP id 41be03b00d2f7-cc1c2963c92so270903a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789141559; x=1789746359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EqLWvLZmzqdbYQJ9xM7Lpiu5RpgWcEW8R8Rm+W/rL7Y=;
        b=Ykz9tFdJhl7XkYKZDQ4r0qhM0eA+lNFYy8dWHhkfZ66wM8wfXhjgC36WAHDIQYpNIc
         mHVXQdb5DX6MLguSp325xlwjFBAqceVKS9YpBaqlM8JIfB2LbKOPBWltP7Jfh6DmwHhP
         XMFBQW+mGXpNxuP17bnrC6Y/qdKz8QAR6b8Je7g6VPT7XRUPzUtHMxFhIoREGn5+RzNL
         civZlxou4hWzcQypz4+oI2rQwWKzN+OSmAQJzXbpi/3jxZTRGp8nxnD9/Rggwx6uQLBT
         kK/qnabjYJN9K9SRn3lv/IEeP+n8hUvnIDfwo2zPqe5gq0yitQqatQpHPaG65980fScb
         +meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141559; x=1789746359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EqLWvLZmzqdbYQJ9xM7Lpiu5RpgWcEW8R8Rm+W/rL7Y=;
        b=d7fL8QDDvTD02NoN5oumoHErTqcQf4L+TRul+C4+yx9PEYGm2cBIcpGBs0Jobs4o4i
         q020qCMpUL2IjReoNWldnywq7dOrfmG1sBEiIjjHFzcRwUH5pge9kxOcLhcEl1Y03U+I
         YfzaqybvOpZU5o97mgI0S4DnJ/4DeaiJ6Vwd50h/7HEuNViymaBAZWoG810Edm6PPtno
         BLlhp/dV1MOk6Nm5njCN+hdqP40cwq3UQjidfNkDfEUl8OyaJem+hpIwSLYs9RRyqSEZ
         dpMocbzTKenXBBGu9Db0kNWyuAIeQKIib2q4QpIEyNqoe7QLx5zM1rhlBtajAYb2rtQq
         aSuw==
X-Gm-Message-State: AFuF++m7haqio6uAn1wLR0prHvqJnl9qdp5cPpKvI7Q0xDGcsEW3VJ8R
	r7AYW7jaGBRYMUk99EhqFEQLP+kGnCvWgWR5hQVdDe+UctQMuT/qDMrq36O2WHph
X-Gm-Gg: AYBFou1BupEvJetdocxErkRZ0Vx8R5QY/vS4qzLlWu0XbnFcZ6gzTxKumSIzoJ5tpg9
	cHIg8RdN0nr1BDUdHvcEsSYLgkFPWfa1aUSSumMwul2Eh46sHqecJWguOsxOZuYDh8yO6EHDT2P
	Xvx//uXtwg8uI4227iZ+X2ljcCegTihynd3CKYRmuqwVqx6iqtDkSF4oCLzj+uMjZhJ4hIEnhgp
	/UH6T+Pc092AYNATK385Ji72O5ETZaKwE7KdYq9fO6Vzyo8RhPnwli16fFcX7ZeJ0SfRI7EeyTY
	btF4gjyRy1oSkXjVs5aIlSLbXJZewEl0JaWhY28m95toDoQ5nJNYXKsmn2a9d/vNnbjxXemz6s1
	11CdpzuG4H71aIniYLqGQPrGgc7CINT+13T1LOnIxfLUUf/G7749mz7n74MD57K3x5KlwLZFgWw
	zold+5KtskjnLBNmwzG5eSged7HA3T0FZ7SfPV82s7Ipo+oIPlVR9lO1gZfVRByD2ElA==
X-Received: by 2002:a05:6a00:22d4:b0:857:73e2:9103 with SMTP id d2e1a72fcca58-86b336d6a0bmr7215011b3a.19.1789141558662;
        Fri, 11 Sep 2026 08:45:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a1b827esm1318332b3a.51.2026.09.11.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:45:58 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/3] net: devmem: embed net_iov_area in binding
Date: Fri, 11 Sep 2026 08:45:54 -0700
Message-ID: <20260911154555.739041-3-sdf@fomichev.me>
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

After replacing the gen_pool with a binding-level freelist, devmem no
longer needs a separate chunk owner object. There is only one
net_iov_area for the binding, so store it directly in struct
net_devmem_dmabuf_binding.

Derive the binding from net_iov_owner() with container_of(), matching the
pattern used by io_uring zcrx. This removes the leftover
dmabuf_genpool_chunk_owner wrapper and its allocation/free path.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/devmem.c | 41 ++++++++++-------------------------------
 net/core/devmem.h | 26 +++++++-------------------
 2 files changed, 17 insertions(+), 50 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 4883eb7f3a95..7949f8425bcd 100644
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
@@ -55,7 +46,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	     "can't destroy dmabuf binding. total=%zu, free=%zu",
 	     binding->total_niovs, binding->free_count);
 
-	net_devmem_dmabuf_free_chunk_owner(binding->chunk_owner);
+	kvfree(binding->area.niovs);
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  binding->direction);
 	dma_buf_detach(binding->dmabuf, binding->attachment);
@@ -271,23 +262,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	}
 	binding->total_niovs = total_niovs;
 
-	owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
-			     dev_to_node(&dev->dev));
-	if (!owner) {
+	binding->area.num_niovs = total_niovs;
+	binding->area.niovs = kvmalloc_objs(*binding->area.niovs,
+					    binding->area.num_niovs);
+	if (!binding->area.niovs) {
 		err = -ENOMEM;
 		goto err_free_freelist;
 	}
 
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
@@ -296,8 +278,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		size_t nr_niovs = len >> niov_shift;
 
 		for (i = 0; i < nr_niovs; i++, niov_idx++) {
-			niov = &owner->area.niovs[niov_idx];
-			net_iov_init(niov, &owner->area, NET_IOV_DMABUF);
+			niov = &binding->area.niovs[niov_idx];
+			net_iov_init(niov, &binding->area, NET_IOV_DMABUF);
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      dma_addr);
 			if (direction == DMA_TO_DEVICE)
@@ -311,17 +293,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
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
 err_tx_vec:
diff --git a/net/core/devmem.h b/net/core/devmem.h
index a5ee2d8d9169..20a3eb90ea7f 100644
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
 
@@ -83,11 +82,6 @@ struct net_devmem_dmabuf_binding {
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
@@ -102,18 +96,12 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
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
+	struct net_iov_area *owner = net_iov_owner(niov);
+
+	return container_of(owner, struct net_devmem_dmabuf_binding, area);
 }
 
 static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
@@ -123,11 +111,11 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 
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

