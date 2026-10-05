Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3D488207
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207990; cv=none; b=gQYTsuTQDvBQDDzWdHy1cYvG6alPF/3J0OOaA3hCBbSod8f9r3Cuxad8AzyyM4DS1oOaJtvWcYr7/DKWGJtQsaoJyQgxnqL3VpkOWe7PVJgUeogtEZyv5/DkePRf1VLTjuP6OsfzsE+vMUkfKBDgiPzi98dkrdI7peiQ+oSLv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207990; c=relaxed/simple;
	bh=jK1xZfZ/ZAjbb1vwQsBgpSKswaKF6V+VUqJKzKbogOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MrJSk2s6YcxDKWDkINrNs17tYX7tOX9jPk30EWs6EWwuZ0i4zv63KSqBEj9AWwykcqSBMC8CYlW1ddVL3dda2gWOWBOoFaDjWUY8GiG6TCE0MFpZ3W0gCa9SAxenguy1XXtdtAPywIsBLTc9cA9551/IrvK1ah20wzmBn6fS7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=DDp+xs0R; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="DDp+xs0R"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a0a911e8d6so766650a91.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1791207986; x=1791812786; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cV4nIo3kAjiqJAr11D0A33XgzPLg22VQeLn4sDhwBQU=;
        b=DDp+xs0Rgq5lUOngPgfgVOd5bxf5QTjAmX5ouVAch38Tzfu8BHbBAIUTn6A6Dy2mZv
         9/0zPDDQvgJERK9EG7CcP+n06syhXrdMDXjhhIaIAAyjdLa5t0Qx7Nf3O1xJSaawpyD2
         C4GX8qzaqWnabQyWLcIPXkYGte4NbIB1NTC4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791207986; x=1791812786;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cV4nIo3kAjiqJAr11D0A33XgzPLg22VQeLn4sDhwBQU=;
        b=DhMiX3Et5mmO5+hQkKU8Ls858om8bDRd+cyQWjz+dt1MXyhGTcFDduw9I6rLFlwXmb
         mONdQn1DHgezRjld0MXhD+7fzG8WCWIK8sTVlHQJRfBoL2UCX+IlU7un62lDYtZd7Rg8
         uVGaViU3/DL/Yl/K+ovffsLh143NTKc41fh2jMkzq0xWO62oB8yV53h6u4/d3jIQLP0Q
         PekZQjh1A2COPueqYlNCfvw/Ssi9NuYFPesQJt//Svnkdd9Mdrf2GMTF6bQoHBUScJDD
         iRXgOrFdatikeHQttbvGL2ekvEXd7u6GwVS++XLPeLYcZBBHJnn9uYiFKlebdQ8KCmnC
         pm9w==
X-Gm-Message-State: AFq9FYJ6qCt7wbgzjML4S4I90j0/Pv1jBTuedpiQKwCVRxyJfQNQNW4n
	x8u+giEXJE+ct0ksLpHxoY+aJzf9ez6Cr5OpLPnNGyhx9oGpWTHzfdnjlCUc2/U3wck=
X-Gm-Gg: AYBFou2uqIvGJbyAHI08IcX6Ezphb6pZE6W35mSqfwqSZ4zxWzieQPNBgust/i1ApNc
	VQ9MT9+k2m1GWsKea45e3gye4mJgpynIs/FVBsshRFXsQ/7BTKZnW11CDvqdHdPmV/HN4Q+HnYa
	6ILET9TaK34VlieEfAxGVtg1LqPWfZEAdtzPXt1j7wVGfts3Z0XNOScYEXGiO+84GAV5n4zTrkP
	EOFfdcR80F0f8Y/53U4nscJC3hR6Mn76ArbAk0LSwtdZLZd81cnHsagLY5YHZ6VcO4KZBU8umUp
	/aOnnuDfu3gYFTCmDhk8NccaGZJPv3cOXUrNQCEZxSc/XCVHqr2uXnke3ZyXsOp5tO044+0nqe9
	3cbfY4ILskfbqh5Ib3j3lokSMJ3gGOKovcckxSJlHAwAFt3C16f3IvVjld8/rdgZ2eWLpE8/UuL
	JuNxKVvHvX6ynzklwAuHk7+8tTs0cedOF4WIRHLB21rRr/E+hlJwDGfI0isXpHoVCU
X-Received: by 2002:a17:90b:3ec1:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3a787510226mr5872122a91.47.1791207986052;
        Mon, 05 Oct 2026 06:46:26 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d65d85csm11168162a91.4.2026.10.05.06.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:46:25 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Date: Mon, 05 Oct 2026 13:46:15 +0000
Subject: [PATCH] net/mlx5: allocate dma pool structs on the pool's NUMA
 node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-net-mlx5-numa-allocate-pool-page-v1-1-01f4283932b4@snu.ac.kr>
X-B4-Tracking: v=1; b=H4sIACaqw2oC/x2N0QrCMBAEf6XcsweXUBX8FfHhqKsepElIaimU/
 ruHbzMw7O7U0QydbsNODat1K9klnAaaPprfYHu6U5R4CSJnzlh4TpvDd1bWlMqkC7iWkriq9xG
 IojKG8Qrymdrwsu1/cX8cxw/U01I1cgAAAA==
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>
X-Mailer: b4 0.13.0

The mlx5 DMA pool structs (mlx5_dma_pool, mlx5_dma_pool_page and its
block bitmap, and mlx5_frag_buf_node_pools) are allocated without a
node hint, so they land on the node of whichever CPU happens to create
or fill the pool, whiile the DMA pages they describe are allocated on
the pool's node.

The pool, page and bitmap are dereferenced on every block allocation
and free. Allocate them on the pool's NUMA node as well, so that all
of a pool's state lives on one node.

Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index a92cf545bdaf..dcd281c4691d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -110,7 +110,7 @@ static struct mlx5_dma_pool *mlx5_dma_pool_create(struct mlx5_core_dev *dev,
 {
 	struct mlx5_dma_pool *pool;
 
-	pool = kzalloc_obj(*pool);
+	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, node);
 	if (!pool)
 		return NULL;
 
@@ -127,19 +127,20 @@ mlx5_dma_pool_page_alloc(struct mlx5_dma_pool *pool)
 {
 	int blocks_per_page = BIT(PAGE_SHIFT - pool->block_shift);
 	struct mlx5_dma_pool_page *page;
+	int node = pool->node;
 
-	page = kzalloc_obj(*page);
+	page = kzalloc_node(sizeof(*page), GFP_KERNEL, node);
 	if (!page)
 		goto err_out;
 
 	page->pool = pool;
-	page->bitmap = bitmap_zalloc(blocks_per_page, GFP_KERNEL);
+	page->bitmap = bitmap_zalloc_node(blocks_per_page, GFP_KERNEL, node);
 	if (!page->bitmap)
 		goto err_free_page;
 
 	bitmap_fill(page->bitmap, blocks_per_page);
 	page->buf = mlx5_dma_zalloc_coherent_node(pool->dev, PAGE_SIZE,
-						  &page->dma, pool->node);
+						  &page->dma, node);
 	if (!page->buf)
 		goto err_free_bitmap;
 
@@ -278,7 +279,7 @@ mlx5_frag_buf_node_pools_create(struct mlx5_core_dev *dev, int node)
 {
 	struct mlx5_frag_buf_node_pools *node_pools;
 
-	node_pools = kzalloc_obj(*node_pools);
+	node_pools = kzalloc_node(sizeof(*node_pools), GFP_KERNEL, node);
 	if (!node_pools)
 		return NULL;
 

---
base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
change-id: 20261005-net-mlx5-numa-allocate-pool-page-2ee20a04147e

Best regards,
-- 
Seongjun Hong

