Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AA4D9F71
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163920; cv=none; b=LnrXMLQyER6UO9gmsfb2QA8jBIZVQasWhcXiXjC62zHnIUWzrdoaE2+fooeMAYqLzsHKqkH7WfjYC1RtJUok9vazL5+H6yRNOvEm+hmIykxt47zODmHMvf8a5y05+fv7XHVsfINAJ2iUleBWFftcNs1XDZZQvY00whnk5DFoWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163920; c=relaxed/simple;
	bh=RyJ5HXL3mAHT1xRWj6+mLJelygFuE8PFN4h6GZEP+2E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XKuyeXrs/yOqE65qfOhb1AcbxXgEMSuXP3FAN8bfpe0Gla1vc60bKKyhxPwSiYVjtAGz2HbA5HL26/XPzjbq3ruNP42E7H0T2VgE9xYtNX39lb8YX6yyWgs+omeRmT3+7vA0JMWTotq6+0O4PbKwNkLZ6mwgOF78FJkC/0BDG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBTqhP5K; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBTqhP5K"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c3613c35145so566133066b.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792163917; x=1792768717; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DdrT9/bm6JcU3yKappBYHRJ/j1CG7LkhSy2cx3C2M6k=;
        b=eBTqhP5KPe28/ti2A8FC7xKjGsr3H/ALHumVl/sRKtZtFdvYGMpEuqChsAFqBYSpAh
         SVtCQ15M++DaO6jpVGnnYur6hoEF6R8Te/gZiMQFudN7BqHrFokMhGmC7wN2F+M024GE
         XCc1Y5KyiOb+Hg15cGkyP9RLR4TGQdj2OJxyXrMoAF9ZMT2NrlJtZ/YAldkzuUEamldR
         ef6WKgs8mGGpq8D2kNqJmi0wyRz7QiniXZx+y7zxTI+MqD3u3OMsaXcdCeT7IQP/5RTe
         f9v8pZ2RQUbGGys/CFOZJQ/yZf/24yLQ/JqaRIW0laBdWyI5FsjSzoEqMxPNghytTury
         F0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163917; x=1792768717;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DdrT9/bm6JcU3yKappBYHRJ/j1CG7LkhSy2cx3C2M6k=;
        b=DUCtR4x4SX8qrgJMmnPaPMiXlJCom+0t8ggGvv81YloQdklNhgdvM6inw4aCwhT24I
         k1xXyNXyZCFGIbjbFgVRrpSkMQvr+QVTLLjHkyZFEunJsh1MxzArks95fgFNvDAShYTv
         E3ClrWU9MA2xmF8YfMCG0ggzw2kyjlIuumHXa/Th6Lzz0z/G6widwzcCAhqYpNSPsA6z
         bFw6KxL+4YIi3sZtThUj09CsvrUn20VQEbGZ8bivUKBEt3BCsc8K+hUVY+CxAZ/JkOC8
         ZGvHvkv+/GZrmSTdyiGM3qeSLkPHIe3BZxT8csNERwv5+HqvwD7G+8sC6hDg3KNnnjgU
         TPFQ==
X-Gm-Message-State: AFq9FYKNXNtsQ768zzNMBLoZ0FfuPLZ3NJ3LWfkey5TdEI5GGnRpkFMX
	jBoi10xb6KolZfmuSuSGwETMVBJ6pkAesEmNYZrbDMAYIxjq6mMUSCnvLLfbrFvflBcSoavnXiU
	kz9gqpQ==
X-Received: from ejcb24.prod.google.com ([2002:a17:906:36d8:b0:c3f:7f5a:30f9])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9713:b0:c2e:856:2a08
 with SMTP id a640c23a62f3a-c419a942d66mr15910266b.1.1792163916834; Fri, 16
 Oct 2026 08:18:36 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:18:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016151835.2500807-1-lrizzo@google.com>
Subject: [PATCH iwl-next] libeth, idpf: use GFP_KERNEL for the initial Rx ring fill
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libeth_rx_alloc() always allocates with GFP_ATOMIC, including when idpf
fills its Rx rings at open or on queue reconfiguration. That fill runs
in process context, right after page_pool_create() and before the
queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is needlessly
restrictive there: it can neither reclaim nor compact, while the initial
fill can allocate tens of thousands of buffers across all queues.

Add libeth_rx_alloc_gfp(), which takes the allocation flags, and make
libeth_rx_alloc() its GFP_ATOMIC wrapper. Use GFP_KERNEL for the initial
fill in idpf.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 +++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
 include/net/libeth/rx.h                       | 23 +++++++++++++++----
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf51..d623e4ab8511f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -885,11 +885,12 @@ static void idpf_rx_buf_hw_update(struct idpf_rx_queue *rxq, u32 val)
  * idpf_rx_singleq_buf_hw_alloc_all - Replace used receive buffers
  * @rx_q: queue for which the hw buffers are allocated
  * @cleaned_count: number of buffers to replace
+ * @gfp: GFP_KERNEL for the initial fill, GFP_ATOMIC from NAPI
  *
  * Returns false if all allocations were successful, true if any fail
  */
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
-				      u16 cleaned_count)
+				      u16 cleaned_count, gfp_t gfp)
 {
 	struct virtchnl2_singleq_rx_buf_desc *desc;
 	const struct libeth_fq_fp fq = {
@@ -908,7 +909,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
 	do {
 		dma_addr_t addr;
 
-		addr = libeth_rx_alloc(&fq, nta);
+		addr = libeth_rx_alloc_gfp(&fq, nta, gfp);
 		if (addr == DMA_MAPPING_ERROR)
 			break;
 
@@ -1095,7 +1096,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 
 	page_pool_nid_changed(rx_q->pp, numa_mem_id());
 	if (cleaned_count)
-		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
+		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count, GFP_ATOMIC);
 
 	u64_stats_update_begin(&rx_q->stats_sync);
 	u64_stats_add(&rx_q->q_stats.packets, rs.packets);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb18..b1127ab48ef3f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -600,6 +600,9 @@ static void idpf_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
  * @bufq: buffer queue to post to
  * @buf_id: buffer id to post
  *
+ * Only used for the initial fill, from process context, so it allocates
+ * with GFP_KERNEL.
+ *
  * Return: %false if buffer could not be allocated, %true otherwise.
  */
 static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
@@ -618,7 +621,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 		fq.fqes = bufq->hdr_buf;
 		fq.truesize = bufq->hdr_truesize;
 
-		addr = libeth_rx_alloc(&fq, buf_id);
+		addr = libeth_rx_alloc_gfp(&fq, buf_id, GFP_KERNEL);
 		if (addr == DMA_MAPPING_ERROR)
 			return false;
 
@@ -629,7 +632,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 	fq.fqes = bufq->buf;
 	fq.truesize = bufq->truesize;
 
-	addr = libeth_rx_alloc(&fq, buf_id);
+	addr = libeth_rx_alloc_gfp(&fq, buf_id, GFP_KERNEL);
 	if (addr == DMA_MAPPING_ERROR)
 		return false;
 
@@ -675,7 +678,7 @@ static bool idpf_rx_post_init_bufs(struct idpf_buf_queue *bufq,
  */
 static int idpf_rx_buf_alloc_singleq(struct idpf_rx_queue *rxq)
 {
-	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1))
+	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1, GFP_KERNEL))
 		goto err;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2a..e27438c78ec79 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1123,7 +1123,7 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
 netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev);
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
-				      u16 cleaned_count);
+				      u16 cleaned_count, gfp_t gfp);
 bool idpf_rx_process_skb_fields(struct sk_buff *skb,
 				const struct libeth_xdp_buff *xdp,
 				struct libeth_rq_napi_stats *rs);
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..14a528ea8a075 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -96,20 +96,23 @@ int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
 void libeth_rx_fq_destroy(struct libeth_fq *fq);
 
 /**
- * libeth_rx_alloc - allocate a new Rx buffer
+ * libeth_rx_alloc_gfp - allocate a new Rx buffer
  * @fq: fill queue to allocate for
  * @i: index of the buffer within the queue
+ * @gfp: allocation flags: GFP_KERNEL where the caller may sleep (e.g. the
+ *	 initial fill of the ring), GFP_ATOMIC from NAPI
  *
  * Return: DMA address to be passed to HW for Rx on successful allocation,
  * ```DMA_MAPPING_ERROR``` otherwise.
  */
-static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+static inline dma_addr_t libeth_rx_alloc_gfp(const struct libeth_fq_fp *fq,
+					     u32 i, gfp_t gfp)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize, gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
@@ -117,6 +120,18 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 	       fq->pp->p.offset;
 }
 
+/**
+ * libeth_rx_alloc - allocate a new Rx buffer from NAPI context
+ * @fq: fill queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: as libeth_rx_alloc_gfp().
+ */
+static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+{
+	return libeth_rx_alloc_gfp(fq, i, GFP_ATOMIC);
+}
+
 void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
-- 
2.56.0.176.g3575e65682-goog

