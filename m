Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6C4A3F26
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062603; cv=none; b=AxFo82BC1QZ9OJwWVv7upnMJQmtJS5AC566SL3B9rbcaCVv3Qs1gL1EPJriV3jc2Yil8Pys2LfYpWSWArJnZNW2ID/EYzhxAG9W1lzZz/jswA3yQgG+4oq52nc556eQntEz3IGY+dReKMPLs6zuBV3elCg33koKKSwtPIx80WK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062603; c=relaxed/simple;
	bh=8ZNIlyr1jf4wemFQxYBClG2qYiJuLZwAwwnYI0RRw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h+7JTf+02BnQZYSElfr91Jzi2HrYeZRWkdOh5ANX/qYeogn+k/FdIA9yiMlscPIuHmPLQ4xbQjDS//MefcnpnOKY6dpoJKtgfaX3Nx2y9AB0lFI4KGk3e5wTCJKgXpI0Ed8Vm/uboa0mvfKH5twwLLujcZnZe4/gAdeKZQo+mAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QNv9iQqr; arc=none smtp.client-ip=209.85.208.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNv9iQqr"
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6afbd484c10so218655a12.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062593; x=1791667393; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3OL/zoqqGDD0aU88aaqUVRrKPVNP3UBVkh8EHXtEjE=;
        b=QNv9iQqrUUu7orcAtNIgUYH7vfR9zJ9cwuZfUeYTfO8f0rmOSEv7vFKW7y4zte2P7l
         25uF1LrfBDssZ0shqThTUzqUPW03il45hHKIR5SrcIgGefcYiEx+5V/ZBWjoAhncnr2R
         baFOwuVZm4vqzF7Jws5SZJUumtKMUWoEDl8NadTJJYkAY+pUtanIFNjWq+p4DX/DfPCV
         Ekg0Q+4JneQPYxmeTifdTnegu4kiAbSlmjQnybi5CvL8gPLD8uDibhX07A5lo24nvW+H
         YvQloiy+feBqVox3WPDOAqj0O9qAWyCzJIvFsXNMMUFQO1w4voR1IUFpgRIBpJEJ7Zyz
         81Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062593; x=1791667393;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3OL/zoqqGDD0aU88aaqUVRrKPVNP3UBVkh8EHXtEjE=;
        b=x/wXaVBD5mB6lGZLF/gBBjIM0RdYhh+2JRpVjospTvL8U7/Ulflz8OIEiheBWF/geb
         8ipbXDwozkluiaeeRC5vdDvMOSeIHr0T3g2mL9iipKFY9tkudZxsLFaBXRqCtr3xu+ok
         xfNxlJiNBQHPp+DkZzvhHTvveq0wYOrhqtxtbRck+zygpNOyZn4sjLbQD8waGJcqqWsH
         to88PDpUXetARivcYYjo463oWP6/Fgpz3AJqdu9Xw9bPGnhIwHcugonqzgeskWTn/x4J
         KOXK2nTwFFcb64IIj7KPZeersJeEbJb3YALASyFWVclGJfO8XHttiF9wnQlU+QBY5qu+
         GnfQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1cLQvYjlsE4b0U7axfnaftSgRhgayP83EJzz0OAFbn8kHnfgVtjkUvES0zOEmtbYWOUQSHdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeCiZTK0uwqFk0bRKBDLLEb9SP1EeZTHRPMkpn5FOL9iGCh8BR
	FXYlK8Tt1ezrJdc7Ou9xJFUF9InnPFtdBFiudlnrfY7JUpO9vqHaagj4pdMguOM5D+D6J7GtbPg
	OXeuK7A==
X-Received: from edaa13.prod.google.com ([2002:a05:6402:24cd:b0:6ac:c62c:c5e3])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:461a:b0:6af:9bef:cf6d
 with SMTP id 4fb4d7f45d1cf-6af9e2fc8eemr4684173a12.25.1791062592978; Sat, 03
 Oct 2026 14:23:12 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:39 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-21-lrizzo@google.com>
Subject: [RFC: DMA_PMD 20/22] net/idpf: Use DMA_PMD memory for tx header
 bounce buffers
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

When dev->dma_pmd_tx_hdrs is enabled, allocate a MAX_TCP_HEADER
bounce buffer per TX buffer slot out of the DMA_PMD arena. When the
linear portion of a transmitted packet is at most MAX_TCP_HEADER bytes,
copy it into the pre-mapped bounce buffer and set the SQE unmap length
to 0 instead of calling dma_map_single()/dma_unmap_page() on every
packet.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  6 ++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 21 ++++++++++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 27 ++++++++++++++++++-
 include/net/libeth/tx.h                       |  5 ++--
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf51..24a2dfec6212d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -261,7 +261,7 @@ static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 
 	tx_desc = &tx_q->base_tx[i];
 
-	dma = dma_map_single(tx_q->dev, skb->data, size, DMA_TO_DEVICE);
+	dma = idpf_tx_map_hdr(tx_q, skb, first, size);
 
 	/* write each descriptor with CRC bit */
 	if (idpf_queue_has(CRC_EN, tx_q))
@@ -274,8 +274,7 @@ static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 			return idpf_tx_singleq_dma_map_error(tx_q, skb,
 							     first, i);
 
-		/* record length, and DMA address */
-		dma_unmap_len_set(tx_buf, len, size);
+		/* record DMA address */
 		dma_unmap_addr_set(tx_buf, dma, dma);
 		tx_buf->type = LIBETH_SQE_FRAG;
 
@@ -326,6 +325,7 @@ static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 
 		size = skb_frag_size(frag);
 		data_len -= size;
+		dma_unmap_len_set(tx_buf, len, size);
 
 		dma = skb_frag_dma_map(tx_q->dev, frag, 0, size,
 				       DMA_TO_DEVICE);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb18..4bdec468ea2ce 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -90,6 +90,14 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 	else
 		idpf_tx_buf_clean(txq);
 
+	if (txq->hdr_buf_va) {
+		dma_free_coherent(txq->dev,
+				  txq->buf_pool_size * MAX_TCP_HEADER,
+				  txq->hdr_buf_va, txq->hdr_buf_dma);
+		txq->hdr_buf_va = NULL;
+		txq->hdr_buf_dma = 0;
+	}
+
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
 }
@@ -187,6 +195,13 @@ static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
 	if (!tx_q->tx_buf)
 		return -ENOMEM;
 
+	if (tx_q->dev->dma_pmd_tx_hdrs)
+		tx_q->hdr_buf_va =
+			dma_alloc_coherent(tx_q->dev,
+					   tx_q->buf_pool_size * MAX_TCP_HEADER,
+					   &tx_q->hdr_buf_dma,
+					   GFP_KERNEL | __GFP_NOWARN);
+
 	return 0;
 }
 
@@ -2663,7 +2678,7 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 
 	tx_desc = &tx_q->flex_tx[i];
 
-	dma = dma_map_single(tx_q->dev, skb->data, size, DMA_TO_DEVICE);
+	dma = idpf_tx_map_hdr(tx_q, skb, first, size);
 
 	tx_buf = first;
 	first->nr_frags = 0;
@@ -2680,8 +2695,7 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 		first->nr_frags++;
 		tx_buf->type = LIBETH_SQE_FRAG;
 
-		/* record length, and DMA address */
-		dma_unmap_len_set(tx_buf, len, size);
+		/* record DMA address */
 		dma_unmap_addr_set(tx_buf, dma, dma);
 
 		/* buf_addr is in same location for both desc types */
@@ -2784,6 +2798,7 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 
 		size = skb_frag_size(frag);
 		data_len -= size;
+		dma_unmap_len_set(tx_buf, len, size);
 
 		dma = skb_frag_dma_map(tx_q->dev, frag, 0, size,
 				       DMA_TO_DEVICE);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2a..39458a8e5baa0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -8,6 +8,7 @@
 #include <linux/net/intel/virtchnl2_lan_desc.h>
 
 #include <net/libeth/cache.h>
+#include <net/libeth/tx.h>
 #include <net/libeth/types.h>
 #include <net/netdev_queues.h>
 #include <net/tcp.h>
@@ -639,6 +640,8 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
  * @q_vector: Backreference to associated vector
  * @buf_pool_size: Total number of idpf_tx_buf
  * @rel_q_id: relative virtchnl queue index
+ * @hdr_buf_va: Base of the TX header bounce buffer array, or NULL
+ * @hdr_buf_dma: DMA address matching @hdr_buf_va
  */
 struct idpf_tx_queue {
 	__cacheline_group_begin_aligned(read_mostly);
@@ -715,6 +718,8 @@ struct idpf_tx_queue {
 
 	u32 buf_pool_size;
 	u32 rel_q_id;
+	void *hdr_buf_va;
+	dma_addr_t hdr_buf_dma;
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
@@ -723,7 +728,7 @@ libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
 			    offsetofend(struct idpf_tx_queue, timer) +
 			    offsetof(struct idpf_tx_queue, q_stats) -
 			    offsetofend(struct idpf_tx_queue, tstamp_task),
-			    32);
+			    48);
 
 /**
  * struct idpf_buf_queue - software structure representing a buffer queue
@@ -1131,4 +1136,24 @@ int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 
 void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq);
 
+static inline dma_addr_t idpf_tx_map_hdr(struct idpf_tx_queue *tx_q,
+					 const struct sk_buff *skb,
+					 struct libeth_sqe *first,
+					 unsigned int size)
+{
+	u32 buf_idx = first - tx_q->tx_buf;
+
+	if (tx_q->hdr_buf_va && buf_idx < tx_q->buf_pool_size &&
+	    size <= MAX_TCP_HEADER) {
+		u32 offset = buf_idx * MAX_TCP_HEADER;
+
+		memcpy(tx_q->hdr_buf_va + offset, skb->data, size);
+		dma_unmap_len_set(first, len, 0);
+		return tx_q->hdr_buf_dma + offset;
+	}
+
+	dma_unmap_len_set(first, len, size);
+	return dma_map_single(tx_q->dev, skb->data, size, DMA_TO_DEVICE);
+}
+
 #endif /* !_IDPF_TXRX_H_ */
diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index c3db5c6f16410..2720ab9393e90 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -130,8 +130,9 @@ static inline void libeth_tx_complete(struct libeth_sqe *sqe,
 	case LIBETH_SQE_SKB:
 	case LIBETH_SQE_FRAG:
 	case LIBETH_SQE_SLAB:
-		dma_unmap_page(cp->dev, dma_unmap_addr(sqe, dma),
-			       dma_unmap_len(sqe, len), DMA_TO_DEVICE);
+		if (dma_unmap_len(sqe, len))
+			dma_unmap_page(cp->dev, dma_unmap_addr(sqe, dma),
+				       dma_unmap_len(sqe, len), DMA_TO_DEVICE);
 		break;
 	default:
 		break;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

