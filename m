Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886F3DB65F
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857831; cv=none; b=jHoL5TcYiB2c499Ipq3LLeA8Uf1aOZthKpdDQu/0VSMaoDhDdGCiSoTKsMvyYuCB86MmWJzEhi6v6wjgnHlf+BOu4tmCEgHE8tOoXOoyvPjxF0wzl0lctxs9YYlkAeL4NLkMXzgmz1kmSXFK0FmIvbDqbIiG8D2qQjVomZIOZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857831; c=relaxed/simple;
	bh=iD8czcUowCPG2OArYOu3JAmcxL8vXZ/XaCzkp4i8yFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r9edeqcW47524qYNa0kB6Ip8ArBq8jiRDDSaHxwX2bTeU0VgHF0UzytawvGhbkkTUcmANt/eMb1lSYNtWNLQOx0m9L2La4fJNMerBu5e7V71FKy/VQovxc0VdIoBau9IT8CnzFR+p3ur2gTjzBlRREc2ElMFMLZcQtpH9if2mJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkGHp8fc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkGHp8fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65045C19421;
	Fri, 10 Apr 2026 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775857830;
	bh=iD8czcUowCPG2OArYOu3JAmcxL8vXZ/XaCzkp4i8yFA=;
	h=From:Date:Subject:To:Cc:From;
	b=qkGHp8fc/cJljfObQtZbwKW6AhJaNItV3Npg9TaRNgGsoVm0rLa1zRIvevuyJWu9X
	 zuKBGCWy1TokziWMFg/cbAWTNrP0Y8Xv4ophkdXB2HyUpxHvKN/cxjj2kqeHFJ1Hn8
	 UBPCmOZyVFbztzXJFHtXShmzBAWhJgplE4GZq578cNQq6v43jS4l9F0ajkEV//r4Oj
	 X9LYywpq2zKLOyGeZxA3HhaVPbSUqj32xDHbOmWmHf01BO6h2nOWSWd7U7GyftOCng
	 TIztkDZoJib9khc9DvpZfyulMePBxeRmN4kPhmHSXA2MqKu4NYqYbSh6rDL1+ps612
	 M3zifuX7it+jg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 10 Apr 2026 23:49:49 +0200
Subject: [PATCH net] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NUQqDMBAFryL73YWotba9ipSw6IsutFETUwTx7
 g39HN7w5qCIoIj0LA4K+GrU2WcoLwX1k/gRrENmqkx1M9fSsGiYJ7Hr8BHbvyE+LXbb7ZqQwE5
 39tj4Uddt4xrgbhzlqyUgT/9MR1mg13n+ABFerMx7AAAA
X-Change-ID: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Similar to airoha_qdma_cleanup_rx_queue(), reset DMA TX descriptors in
airoha_qdma_cleanup_tx_queue routine. Moreover, reset TX_DMA_IDX to
TX_CPU_IDX to notify the NIC the QDMA TX ring is empty.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 9285a68f435f..963ab7b8d166 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1044,13 +1044,17 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 
 static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 {
-	struct airoha_eth *eth = q->qdma->eth;
-	int i;
+	struct airoha_qdma *qdma = q->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int i, qid = q - &qdma->q_tx[0];
+	struct airoha_queue_entry *e;
+	u16 index;
 
 	spin_lock_bh(&q->lock);
 	for (i = 0; i < q->ndesc; i++) {
-		struct airoha_queue_entry *e = &q->entry[i];
+		struct airoha_qdma_desc *desc = &q->desc[i];
 
+		e = &q->entry[i];
 		if (!e->dma_addr)
 			continue;
 
@@ -1060,8 +1064,29 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 		e->dma_addr = 0;
 		e->skb = NULL;
 		list_add_tail(&e->list, &q->tx_list);
+
+		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->ctrl, 0);
+		WRITE_ONCE(desc->addr, 0);
+		WRITE_ONCE(desc->data, 0);
+		WRITE_ONCE(desc->msg0, 0);
+		WRITE_ONCE(desc->msg1, 0);
+		WRITE_ONCE(desc->msg2, 0);
+
 		q->queued--;
 	}
+
+	e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
+			     list);
+	index = e - q->entry;
+	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
+	 * empty.
+	 */
+	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
+	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
+			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
+
 	spin_unlock_bh(&q->lock);
 }
 

---
base-commit: 12ff2a4aee6c86746623d5aed24389dbf6dffded
change-id: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

