Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594C386C1B
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672488; cv=none; b=WRNGmQwSw81Oxfx5Bd8DyWQ+C0U67bK6pSSKwiFNMX1yQFiurJ66Qmq7zYPSg0KowIRqzMd3XqFSn619SabLpitlKifIGD5DU6/9+5oiXg/nm0OVelzQhsNi7OzLEcRrc06bqY7O8FTEJi/3cazgdQzQNv+dayz4N23FVbEGn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672488; c=relaxed/simple;
	bh=iJfYHjbtQcWXulEhPUnNrNVT7wdpLyZo8wc0yxlsesk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DG53oWIrZcOq2WmP5J3vWNkIkjsAbpieLad0Qf47ANfisoR5BgNXXU93u52K65iyD9lmtH21v3F9nsq5VI/kYfChaX80g27P+7BQVf/d69RCFyt9O+TzIh2kBnLkAKrIpe/RgZ/yB0EWLs7lO0pb+ttEODYEGUWDNx6L23tCLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+9urV6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+9urV6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CADC2BCB3;
	Mon, 20 Apr 2026 08:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776672488;
	bh=iJfYHjbtQcWXulEhPUnNrNVT7wdpLyZo8wc0yxlsesk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e+9urV6K58ahpj9nD4gByGJBfQ2yw6edYmFol3cpas1UUf/+DDiIyXWyXqxNpydt1
	 yuJz8wOQZfrtejlLFgX2wClYdI9997yMSMZRu7QaAEhH7ZHub6Tim87qKTnOX5CD1o
	 S6iQNIcGHpyH0eK30Dqjw+jUJMjobksb8pbGOpf0hup8Li35T0OMG9nlZlmR5x4OXL
	 HkgfKNQC2nfAWuNVL45bmC3hZwJ7AAqw5pPyxDG/cEFZH11ZI+gXRJHFforF92dKOw
	 9STnhtATXXqRFVg9xJmS11ExPXqKHvWazwF5qIuizQP9ITG++4zLaw4HRxDd6MfsGF
	 Tsl8BjwBwkUTQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 20 Apr 2026 10:07:47 +0200
Subject: [PATCH net v2 1/2] net: airoha: Move ndesc initialization at end
 of airoha_qdma_init_rx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-airoha_qdma_init_rx_queue-fix-v2-1-d99347e5c18d@kernel.org>
References: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
In-Reply-To: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3

If queue entry or DMA descriptor list allocation fails in
airoha_qdma_init_rx_queue routine, airoha_qdma_cleanup() will trigger a
NULL pointer dereference running netif_napi_del() for RX queue NAPIs
since netif_napi_add() has never been executed to this particular RX NAPI.
The issue is due to the early ndesc initialization in
airoha_qdma_init_rx_queue() since airoha_qdma_cleanup() relies on ndesc
value to check if the queue is properly initialized. Fix the issue moving
ndesc initialization at end of airoha_qdma_init_tx routine.
Move page_pool allocation after descriptor list allocation in order to
avoid memory leaks if desc allocation fails.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e1ab15f1ee7d..fc79c456743c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -745,14 +745,18 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	dma_addr_t dma_addr;
 
 	q->buf_size = PAGE_SIZE / 2;
-	q->ndesc = ndesc;
 	q->qdma = qdma;
 
-	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
+	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return -ENOMEM;
 
+	q->desc = dmam_alloc_coherent(eth->dev, ndesc * sizeof(*q->desc),
+				      &dma_addr, GFP_KERNEL);
+	if (!q->desc)
+		return -ENOMEM;
+
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
 		int err = PTR_ERR(q->page_pool);
@@ -761,11 +765,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		return err;
 	}
 
-	q->desc = dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
-				      &dma_addr, GFP_KERNEL);
-	if (!q->desc)
-		return -ENOMEM;
-
+	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
 	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), dma_addr);

-- 
2.53.0

