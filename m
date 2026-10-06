Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D47743F4C5
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296214; cv=none; b=dNGMqEDCYID2es+gTbhiCbyZGj3J1aXwkVfwMhmj95n944UW/CXD2LJUr5q65fs8zE4kHX3QY6qudCR5im/kyWayl6VMsHauXbk2P/pjCGiVi3sCQfRCi6YUvuBLYFWIt/ppERhQp39QRSFRw9fmUnwhy+Vcea43YJrdYs2kLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296214; c=relaxed/simple;
	bh=02r4wGAOjM+0zaxUQkQ6LUoyUS4UyZaMWkhJRo0z8G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pLNre24AOQjF128H8is3U6vb4UVnkxz0/+08rzdVL3oB7p/koy+AmAl0ECZTXF4PFk8u3aRTnWSulloclQPhWCd34Ecl0f2DR5jXEABtjIcpQoY6ZPEASqhokDayoekkqvWJQpSwnS+sLy9JedlayYanoazt3FxbpTiwL5TDJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=U6dy56Q1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="U6dy56Q1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38759bcd877so892405a91.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1791296211; x=1791901011; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y7W/stljCR7Yo3LPNubWsyzPTC2BQ+EVRhVLuL/EFgc=;
        b=U6dy56Q1aBkmoRo7wfYzZ0NQnRj6ubXeTkf3XeFKhpT6R0y1K4nKAp3qRyxoiqIVrS
         uJecWmQUFigQuqogS5xFYQLSxuZjqr4Wh0FKQNkBTPXzEeXVcg5p9x7sqjcjd2uGilaJ
         LYU9D5lc8ACTO8mSWXVgpiR79bYImLLYBVvRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296211; x=1791901011;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y7W/stljCR7Yo3LPNubWsyzPTC2BQ+EVRhVLuL/EFgc=;
        b=m/brrLsl9qZkBJYywqGHhGcQzEjaTBxA+a4bOY7h5ofD6VO3f1RjHSEbamSUOAlulM
         x3vcE00NNv3gEUEZnTnyRHwXEdAG1O4zL8QwO5PrvRV0BXCD+BbzKDN8NdrQqIl/fVND
         tpi/JDZopJv25GvS5MtwbyhEvH4Ua765ka9lAmD7Oghro35u+vslx/RQyl4s64i3sVlI
         ka8KB3vxEmelxGnhTq7l8NMKPsa1bX91Gr0cr8elwJalrEWm1XBEKKbvp8oYKVGFq0GG
         xIrdPgAb7CbOlqLuvSuuUiHufwxHJK4Zq6zEwwkkoqR5UoeI57nzgH2mx7JrjE+O1Ycq
         K1zA==
X-Gm-Message-State: AFq9FYJOHPjx31Qh3ZRKjYzlg7FFZZbG9bFi/9PwwH6GBo3jr5O67Hbn
	cFaDPm3xPQoppCf1uM8yXZC2bEI7Md6yeb/T8S7f1t31SZ9QZWOUEhC16NEIgCJno68=
X-Gm-Gg: AYBFou2DIyieFxDYgYgmlIyHF53TKY8jmq/cAqUXOxUAyZDmzhJWgMMiWZ+1jLjFBvd
	6C4AZWXvXL7GhBGSSdv2fr+e8Qc22B8DJjSdSuhkiH3t6vY0vDW8+hP8tS2wJzNvismKJMUqDyR
	Yx646OvSGSN1drws9MMX1UQVPkY149Ydk5Mtk3LukFvVOvjzs3WRPLIzJS3VzcPhJ5NoJXfLD8x
	iMYs9ufLz09ywJ+jP7UUjpJcFuEFmJ6Rwg9o26fbbLgFQPaxAqmWfXaev0+tYwQ85b5yfrx/d+x
	q5df9zJpQh3U9QlRsuiwaPrgSENoGvA1Mud47HnwQJmHRiMi13m30AjfpeZV2z5C5qalHI9tnPw
	QSjKLiRpdcQebYX/fTclMWiIwc+fMDf2mCSVsDvsbwTHzmA+V/6ONCnz++0GOE+RwbX35m0lJJ7
	G3pU3xu4PERGIK7EDWW+Mu4fseWMw23nG2aothemkWmh7t5CfH4amRaliIK+BDGlWgi9EQ0ZVb7
	jk=
X-Received: by 2002:a17:90a:f94e:b0:3a4:c18c:b8a5 with SMTP id 98e67ed59e1d1-3a8737d4695mr910988a91.58.1791296210623;
        Tue, 06 Oct 2026 07:16:50 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853889388sm5969035a91.2.2026.10.06.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:16:50 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Date: Tue, 06 Oct 2026 14:16:45 +0000
Subject: [PATCH net-next v2] net/mlx5: allocate DMA pool structs on the
 pool's NUMA node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-net-mlx5-numa-allocate-pool-page-v2-1-0dc4c2eb1376@snu.ac.kr>
X-B4-Tracking: v=1; b=H4sIAMwCxWoC/42NTQ6CMBCFr0Jm7ZC21D9W3sOwGHGQxtKSthAM4
 e5WTuDuvbyfb4XIwXCEulgh8Gyi8S4bdSig7cm9GM0ze1BCnaQQR3SccLBLFtNASNb6lhLj6L3
 FkXJfMStBQkt9Zsg3Y+DOLDviDr+14yVBk5PexOTDZ2fPcs//x8wSJQrZaXWprpV66Ft0U0lt+
 Q7QbNv2BT4d5Z/aAAAA
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
or fill the pool, while the DMA pages they describe are allocated on
the pool's node.

The pool, page and bitmap are dereferenced on every block allocation
and free. Allocate them on the pool's NUMA node as well, so that all
of a pool's state lives on one node.

These allocations happen on the control path, so the performance gain
is expected to be small; the change is mainly for consistency.

Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
Changes in v2:
- fix typo and specify the structs are allocated on the control path
- add a prefix net-next to the subject
- Link to v1: https://lore.kernel.org/r/20261005-net-mlx5-numa-allocate-pool-page-v1-1-01f4283932b4@snu.ac.kr
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

