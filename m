Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED1389444
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324475; cv=none; b=i16H1mX1X7cOm87U0cPDDgHidY/NCie74y5ug4V7RwgdG3jPhzgs6FiDf6H1ZujZikv3X01UuXMR4EIR3uYkYP8r2NsCwg3Jpe4QZ3ewQvyYhGSkhO3ywQtuYOjDYuKjX/AmkM8qaq6WXemYMLSmm3oW/saFo7PmvdqBD4G5ba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324475; c=relaxed/simple;
	bh=xnA99lEk24eFu5lu4XONa125B5SYET6G9LGPg2c6iYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/fbikJgxFsOu5UDue+JKCLQceaRuKIzfL//AXwNN6//PcOgtIlY5b+fyw1R4iu2oLKs4iFHaMjLXdxDVSh9NjlB1uFKETCZ0WFIrFlglg9vJj/7RJTWKFwd2xMNGO/A3cmJRZlEMd9Ewze+rV0RnWz0sVHht6fwbRZvN4XPYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcugYh46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcugYh46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A988C2BCAF;
	Thu, 16 Apr 2026 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776324474;
	bh=xnA99lEk24eFu5lu4XONa125B5SYET6G9LGPg2c6iYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FcugYh46xO/1o+DGDNuqbzII092MzRwrrE39xlazpcwMUOes4a8URJZE7jYa9BDxH
	 1PqUgbu46qAY9DHK/etaAkUrQS0RKPd76YPB9dphpM/ymeIjcSOeDzutmy5PkrSfRk
	 ZCOrmedv0D0wgxc6Qu2rEzsYH0bOEvjfoGtMLMllSltd06VmuBTSujGLES4G5qrus2
	 JO5FAP7sbguHqxjumXTXcNSOikDtlEqckcrCDhL+7twzoqy6fw+RGvxtPzvTwwQNxx
	 IKU/VYVAf243RnIydVpitQA80TfmJVU0Dr5pJTW1UwDtnBMtqJwblDcwGzZbYtwW1s
	 Qg5fXX6uxGj1w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Apr 2026 09:27:39 +0200
Subject: [PATCH net v3 1/3] net: airoha: Move ndesc initialization at end
 of airoha_qdma_init_tx()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-1-2b69f5788580@kernel.org>
References: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>
In-Reply-To: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3

If queue entry list allocation fails in airoha_qdma_init_tx_queue routine,
airoha_qdma_cleanup_tx_queue() will trigger a NULL pointer dereference
accessing the queue entry array. The issue is due to the early ndesc
initialization in airoha_qdma_init_tx_queue(). Fix the issue moving ndesc
initialization at end of airoha_qdma_init_tx routine.

Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e1ab15f1ee7d..690bfaf8d7d9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -954,27 +954,27 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 	dma_addr_t dma_addr;
 
 	spin_lock_init(&q->lock);
-	q->ndesc = size;
 	q->qdma = qdma;
 	q->free_thr = 1 + MAX_SKB_FRAGS;
 	INIT_LIST_HEAD(&q->tx_list);
 
-	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
+	q->entry = devm_kzalloc(eth->dev, size * sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return -ENOMEM;
 
-	q->desc = dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
+	q->desc = dmam_alloc_coherent(eth->dev, size * sizeof(*q->desc),
 				      &dma_addr, GFP_KERNEL);
 	if (!q->desc)
 		return -ENOMEM;
 
-	for (i = 0; i < q->ndesc; i++) {
+	for (i = 0; i < size; i++) {
 		u32 val = FIELD_PREP(QDMA_DESC_DONE_MASK, 1);
 
 		list_add_tail(&q->entry[i].list, &q->tx_list);
 		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
 	}
+	q->ndesc = size;
 
 	/* xmit ring drop default setting */
 	airoha_qdma_set(qdma, REG_TX_RING_BLOCKING(qid),

-- 
2.53.0

