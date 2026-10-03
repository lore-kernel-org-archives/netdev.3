Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3349552C
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062601; cv=none; b=bScImA0JKdtnr8BD2ZmcNmwVMUVVlNJzLtflDQ1FKNN98fKBSZkVygq4T0qzeibAe8hhI6eXNL+3dWz4jzvTA7UWkVuTjlSUrXXVGw+WFVkIrHGPEyXkcsE9VwqyUTWc8lyaJ60wVRSKmsS5+gQgNMX8kVGbuzgUhZd8XY2xuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062601; c=relaxed/simple;
	bh=0UEzNPYoMtYU8V6tV9CGaZXf2SYy9Eg3sYnpmfOu5WA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i2wODw+SDAJvll7ALVq6rdkAtHWiuVZo1qP5S4RfcRb2sN8h+o11e0+JiGruDEd94lqccGlel5lwIk1GEe3+N5iI3FSZodQxuE8rO15IUy+Kj+bbcBLNg4ZLYd6REPUmWnfGIvQKQMQhVUusXFXrP5avDOliDiKHK6vPrRm+H8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6+GS01h; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6+GS01h"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6ae18a3adaeso964804a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062592; x=1791667392; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aZwzLkeC5Zd1WFKT0DwnrS8SKkPjkbpjbdTgKohmOY=;
        b=X6+GS01h6zUqI8yReMwjT+GPSVBZdAtuOWNNuvGt3HZsdH8BxKJLVCq9CNfl6xl405
         aFEvlpfEiyiYZ0O6qEL5sFmUB4D2kMdeFREM7Xbl2RQfEg6JimL0AJvl7k249+lDzAQN
         KX9DblBYeP2bUPlEpx8Uk83DmErCRQSZW3tH8Yz3ZXquvy+OOApx08tlcpjUmUMitSMm
         AuK6DftvKtLZGzewPYJ77sa+vkTReWec0ty9brAgFpDR+ng9KDZqJHwT7L8aT/dx61BS
         +X94YINQvcho0kNCKSTIjvzzoNm4+64zpVZx0ACWQSN44O12WJQDIFZcOXii1kVvWR29
         j47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062592; x=1791667392;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aZwzLkeC5Zd1WFKT0DwnrS8SKkPjkbpjbdTgKohmOY=;
        b=f2nV2uHclvkk/HswEC7IzDiio2VonU9RPULK3if4vAKOCyKdlHX/C2sJIcPYcKIQN4
         HCWq2t4pJI4OrAnvVzcl7gspxej3p/H9Vsj4M8y//2swNLqNJEzpnxc6YSa9oQyjrrjH
         eChmMA1mSunpxhB9L3f0c4WAMQZa5wP2A5IqAS9aNOnTGSfvMhPCcnHCHm8ZB686ODWK
         nkOriJA4ps5iu+/7RifdGAYfacMPbmgl7K5innAg/QRR74zMqTCKfeQB+Ur2yrf0Zo2w
         S8cCnfB9xKh8E/SRVYoTva6YuSzvMQJxfx6divtH+G0vuJkLGj6QLd4Ii8pDWkgTqOql
         RNCA==
X-Forwarded-Encrypted: i=1; AKwUvBycvjvMPNlVF5cDUgl7fSZOMv04fc5Bl/GjaUly8uGAXrS6yawms2UkOZbJ5zTH8bBzOKXudho=@vger.kernel.org
X-Gm-Message-State: AFuF++kld/1LV7OqYQ4zMpX0iImnuTtKqkagh12VvgWV4/6cKLTg973N
	dBfAxNK13/GXXAmjcJYLxDaaAXl9y/6EClkpRVbiCoSThd97TQevTP+biYXRBOg+/XS8F0inhwq
	2K0Wg8g==
X-Received: from ejcfv45.prod.google.com ([2002:a17:907:50ad:b0:c2e:8121:1730])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9728:b0:c2e:7fe7:2898
 with SMTP id a640c23a62f3a-c2e7fe738bbmr76710966b.12.1791062591766; Sat, 03
 Oct 2026 14:23:11 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:38 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-20-lrizzo@google.com>
Subject: [RFC: DMA_PMD 19/22] net/mlx5e: Use DMA_PMD memory for tx header
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
bounce buffer per TX DMA FIFO slot out of the DMA_PMD arena. When the
linear portion of a transmitted packet is at most MAX_TCP_HEADER bytes,
copy it into the pre-mapped bounce buffer instead of calling
dma_map_single()/dma_unmap_single() on every packet.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 28 +++++++++++++++----
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index a3945195f454e..d762ad1c1ffaf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -442,6 +442,8 @@ struct mlx5e_txqsq {
 		struct mlx5e_sq_dma       *dma_fifo;
 		struct mlx5e_skb_fifo      skb_fifo;
 		struct mlx5e_tx_wqe_info  *wqe_info;
+		void                      *tx_hdr_bufs;
+		dma_addr_t                 tx_hdr_bufs_dma;
 	} db;
 	void __iomem              *uar_map;
 	struct netdev_queue       *txq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index f2a8453d8dce0..6de7a2a430d72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -365,7 +365,9 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
 {
 	switch (dma->type) {
 	case MLX5E_DMA_MAP_SINGLE:
-		dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
+		if (dma->size)
+			dma_unmap_single(pdev, dma->addr, dma->size,
+					 DMA_TO_DEVICE);
 		break;
 	case MLX5E_DMA_MAP_PAGE:
 		netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4c6060d54fbed..efd766aa43a02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1666,6 +1666,13 @@ static void mlx5e_free_icosq(struct mlx5e_icosq *sq)
 
 void mlx5e_free_txqsq_db(struct mlx5e_txqsq *sq)
 {
+	if (sq->db.tx_hdr_bufs) {
+		int wq_sz = mlx5_wq_cyc_get_size(&sq->wq);
+		int df_sz = wq_sz * MLX5_SEND_WQEBB_NUM_DS;
+
+		dma_free_coherent(sq->pdev, df_sz * MAX_TCP_HEADER,
+				  sq->db.tx_hdr_bufs, sq->db.tx_hdr_bufs_dma);
+	}
 	kvfree(sq->db.wqe_info);
 	kvfree(sq->db.skb_fifo.fifo);
 	kvfree(sq->db.dma_fifo);
@@ -1690,6 +1697,13 @@ int mlx5e_alloc_txqsq_db(struct mlx5e_txqsq *sq, int numa)
 		return -ENOMEM;
 	}
 
+	if (sq->pdev->dma_pmd_tx_hdrs)
+		sq->db.tx_hdr_bufs =
+			dma_alloc_coherent(sq->pdev,
+					   df_sz * MAX_TCP_HEADER,
+					   &sq->db.tx_hdr_bufs_dma,
+					   GFP_KERNEL | __GFP_NOWARN);
+
 	sq->dma_fifo_mask = df_sz - 1;
 
 	sq->db.skb_fifo.pc   = &sq->skb_fifo_pc;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 0b5e600e4a6a9..3b6a7a8b0128e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -177,6 +177,27 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb)
 	return ihs;
 }
 
+static inline dma_addr_t
+mlx5e_tx_map_hdr(struct mlx5e_txqsq *sq, unsigned char *data, u32 len)
+{
+	dma_addr_t dma_addr;
+
+	if (sq->db.tx_hdr_bufs && len <= MAX_TCP_HEADER) {
+		u32 off = (sq->dma_fifo_pc & sq->dma_fifo_mask) *
+			  MAX_TCP_HEADER;
+
+		memcpy(sq->db.tx_hdr_bufs + off, data, len);
+		dma_addr = sq->db.tx_hdr_bufs_dma + off;
+		mlx5e_dma_push_single(sq, dma_addr, 0);
+		return dma_addr;
+	}
+
+	dma_addr = dma_map_single(sq->pdev, data, len, DMA_TO_DEVICE);
+	if (likely(!dma_mapping_error(sq->pdev, dma_addr)))
+		mlx5e_dma_push_single(sq, dma_addr, len);
+	return dma_addr;
+}
+
 static inline int
 mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 			unsigned char *skb_data, u16 headlen,
@@ -187,8 +208,7 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	int i;
 
 	if (headlen) {
-		dma_addr = dma_map_single(sq->pdev, skb_data, headlen,
-					  DMA_TO_DEVICE);
+		dma_addr = mlx5e_tx_map_hdr(sq, skb_data, headlen);
 		if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
 			goto dma_unmap_wqe_err;
 
@@ -196,7 +216,6 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		dseg->lkey       = sq->mkey_be;
 		dseg->byte_count = cpu_to_be32(headlen);
 
-		mlx5e_dma_push_single(sq, dma_addr, headlen);
 		num_dma++;
 		dseg++;
 	}
@@ -578,7 +597,7 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	txd.data = skb->data;
 	txd.len = skb->len;
 
-	txd.dma_addr = dma_map_single(sq->pdev, txd.data, txd.len, DMA_TO_DEVICE);
+	txd.dma_addr = mlx5e_tx_map_hdr(sq, txd.data, txd.len);
 	if (unlikely(dma_mapping_error(sq->pdev, txd.dma_addr)))
 		goto err_unmap;
 
@@ -591,7 +610,6 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 	sq->stats->xmit_more += xmit_more;
 
-	mlx5e_dma_push_single(sq, txd.dma_addr, txd.len);
 	mlx5e_skb_fifo_push(&sq->db.skb_fifo, skb);
 	mlx5e_tx_mpwqe_add_dseg(sq, &txd);
 	mlx5e_tx_skb_update_ts_flags(skb);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

