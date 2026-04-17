Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A630AD1C
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407889; cv=none; b=bkx5glGozmFI7qLPOgJHbwo38mfcj83W25CDEWqq+y0noqKh2Nw5vcHtGC6fwLUmXuBbI2pMTkUX9NyhoMdts+yqOpjWMkylqQn9Gv0VioJbyw9SvFceb1iCbWnbKFtK1oPh74vEYiP+9GOkhuX2EZSQu0yi5YuE65ZA+RBomnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407889; c=relaxed/simple;
	bh=xnA99lEk24eFu5lu4XONa125B5SYET6G9LGPg2c6iYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlR2dhhtUUv1LgofeQvZub4OYljcyNz77jTuH+XNvG37QAj62v6qdf4Z0qGuCEYoDeYLxlVFQNCSbJiF1zvfYZaE8yXXzgMPqXWJSIN1/ofchRcLd4fFneEZF2k9O5BDRcBDNuAQX/aGt3mU8TL2z0ScgbkzrbJH3FOTIVPxxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxoQeiDE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxoQeiDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E9DC19425;
	Fri, 17 Apr 2026 06:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776407889;
	bh=xnA99lEk24eFu5lu4XONa125B5SYET6G9LGPg2c6iYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TxoQeiDEVjSHullntG9HbL2NRx5KNzWI0IwXvkJUBzsETe9Si4n2Ub5eZMYYtXn+A
	 7tQzwgUdkD/RDQe4Pw3RK959VpGqo42/eNJSEuMmG5aMD3ipGPteiehEKhSmCLSaFp
	 ltT2LMMD71DByOfBxhMf64mvVBNvEe0e3Co4viTJEIMX81jaM+XkTERFMz5tlqBJGL
	 dcQnbyfHp1RfGcJFWRv470Ld7A1wc29il1Obl+wnKoa3MN093aFGHTyntkvfSKsxbu
	 m7h9ysIzBsyy6PWhjeeoRerPbv6GTcf2GE8GtcqSXtJBDvvAPVNq2bs3CPMeUJ5sLp
	 aYY30XN/+LzOw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Apr 2026 08:36:31 +0200
Subject: [PATCH net v4 1/2] net: airoha: Move ndesc initialization at end
 of airoha_qdma_init_tx()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-1-e04bcc2c9642@kernel.org>
References: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
In-Reply-To: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
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

