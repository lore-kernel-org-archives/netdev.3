Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B53392837
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439012; cv=none; b=W1HgMC33eb7PuELBoXQjLffz0eWW7zGaxCtC7QNgDSW/2lGoeO1JJNxazLxK/PfKyDWvYVDXJqF3KlecGhHI3yWPxm09thSMwFb7KCvGVnY6O/YZINg9/7d9hN9sFxDQw9GrJ4OFTzqk9sqnX+vAkTalTiMjoaKkoDD//UTe650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439012; c=relaxed/simple;
	bh=7vyyHo2XoHSus7sI6PsiunSp/TiB2abe5+PgQKTdUf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxVBVPZABi0voDHm3NEmjJ+ipMvo8uTmUOG5XAor1ORR8/Yo2/OUynJIDg3mj3QwRdlskXwWgNQ/dOziyKSWTdbp4Zqw88+rvb/qnBBSTphBGh0C7dkvGXg9NcruXkoYe+V2MBWbR8R8/FfIsByanMne8PBUt3QwRZLEjut8264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX2tFd8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX2tFd8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894321F000FF;
	Tue, 15 Sep 2026 02:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789439011;
	bh=IhRxIf37D0YOWYoneErFsfknt2cvKOI+nEaIg6TEoFY=;
	h=From:To:Cc:Subject:Date;
	b=PX2tFd8srsa7Yss6JC6He3RufmDiX8vQoCIAhP3xB3OC9si9vk/9eNbXb523ezX2Y
	 72WHBzd89k4gEPlylYBm0G+V+13HonoD2KOelp3t+QJ0Dp4UNecaDbORl0B+Yh4KK1
	 d/5SE9ma3bqOF1xS+2MtitnYkyEGWQD5uVVhdo5fnP8BbP+MYRm485sk3uVPEkr0hd
	 WCf7fWJNhqWERQTPGYqHvfmf6py89f6nwlnkFzku1cvFvK4XxYjUeA+0kKJRBGFsqA
	 h/0qnMH7tP+iKYMKk33lsykoxS7uEoa/mJqvQd1Axm7uCMHh6QDNtmy723KE5QL4Te
	 3mNsRPX/NuV5w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: [PATCH net] eth: fbnic: ring the doorbell if a burst ends in a drop
Date: Mon, 14 Sep 2026 19:23:27 -0700
Message-ID: <20260915022327.913218-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic_tx_map() skips the doorbell write, and the completion request,
for every packet handed to it with xmit_more set, counting on the
packet which ends the burst to publish them all. When that packet is
dropped instead - skb_put_padto(), skb_cow_head() or a DMA mapping
failure - nothing rings. The descriptors of the preceding packets stay
invisible to the HW until the next transmit on that queue, which for a
burst-then-idle workload may never come.

Remember the meta descriptor of the last packet left without a doorbell
and flush it from the error paths. The completion request has to be set
on that descriptor rather than simply writing the tail, otherwise the HW
would transmit the packets but never report a head, and the ring would
fill up and stall for good.

This is very similar to Joe's recent series of fixes for bnxt.
Not seen in real life, reproduced under QEMU with failure injection.

Fixes: 9a57bacd574b ("eth: fbnic: Add basic Tx handling")
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Reproduced under the QEMU fbnic model by failing the DMA mapping of the
last segment of a software-GSO burst: 21 descriptors (7 packets) stayed
in the ring with head stuck at 24 and tail at 45, 10094 bytes stuck in
BQL, and QEMU saw none of the 7 frames.
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h |  9 ++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 42 +++++++++++++++-----
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index e03c9d2c38dc..f5899446dcc5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -128,9 +128,14 @@ struct fbnic_ring {
 		/* Rx BDQs only */
 		struct page_pool *page_pool;
 
-		/* Deferred_head is used to cache the head for TWQ1 if
+		/* TWQ0 only, index of the meta descriptor of the last packet
+		 * placed in the ring without ringing the doorbell, -1 if the
+		 * doorbell is in sync with the tail.
+		 */
+		s32 deferred_meta;
+
+		/* TCQ only, used to cache the head for TWQ1 if
 		 * an attempt is made to clean TWQ1 with zero napi_budget.
-		 * We do not use it for any other ring.
 		 */
 		s32 deferred_head;
 	};
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 401f8b8ae1ca..e7918d3f6aba 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -311,6 +311,29 @@ fbnic_rx_csum(u64 rcd, struct sk_buff *skb, struct fbnic_ring *rcq,
 	}
 }
 
+static void fbnic_tx_doorbell(struct fbnic_ring *ring, __le64 *meta)
+{
+	*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_COMPLETION);
+	ring->deferred_meta = -1;
+
+	/* Force DMA writes to flush before writing to tail */
+	dma_wmb();
+
+	writel(ring->tail, ring->doorbell);
+}
+
+/* Packets handed to us with xmit_more set are left in the ring without a
+ * doorbell, and without a completion request, in the expectation that the
+ * packet ending the burst will ring for all of them. If that packet gets
+ * dropped instead we have to ring here, otherwise the descriptors sit in
+ * the ring until the next transmit, which may never come.
+ */
+static void fbnic_tx_flush_doorbell(struct fbnic_ring *ring)
+{
+	if (ring->deferred_meta >= 0)
+		fbnic_tx_doorbell(ring, &ring->desc[ring->deferred_meta]);
+}
+
 static bool
 fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 {
@@ -378,14 +401,10 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	/* Verify there is room for another packet */
 	fbnic_maybe_stop_tx(skb->dev, ring, FBNIC_MAX_SKB_DESC);
 
-	if (fbnic_tx_sent_queue(skb, ring)) {
-		*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_COMPLETION);
-
-		/* Force DMA writes to flush before writing to tail */
-		dma_wmb();
-
-		writel(tail, ring->doorbell);
-	}
+	if (fbnic_tx_sent_queue(skb, ring))
+		fbnic_tx_doorbell(ring, meta);
+	else
+		ring->deferred_meta = meta - ring->desc;
 
 	return false;
 dma_error:
@@ -425,8 +444,10 @@ fbnic_xmit_frame_ring(struct sk_buff *skb, struct fbnic_ring *ring)
 	 * otherwise try next time
 	 */
 	desc_needed = skb_shinfo(skb)->nr_frags + 10;
-	if (fbnic_maybe_stop_tx(skb->dev, ring, desc_needed))
+	if (fbnic_maybe_stop_tx(skb->dev, ring, desc_needed)) {
+		fbnic_tx_flush_doorbell(ring);
 		return NETDEV_TX_BUSY;
+	}
 
 	*meta = cpu_to_le64(FBNIC_TWD_FLAG_DEST_MAC);
 
@@ -447,6 +468,8 @@ fbnic_xmit_frame_ring(struct sk_buff *skb, struct fbnic_ring *ring)
 err_free:
 	dev_kfree_skb_any(skb);
 err_count:
+	fbnic_tx_flush_doorbell(ring);
+
 	u64_stats_update_begin(&ring->stats.syncp);
 	ring->stats.dropped++;
 	u64_stats_update_end(&ring->stats.syncp);
@@ -2491,6 +2514,7 @@ static void fbnic_enable_twq0(struct fbnic_ring *twq)
 	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_CTL, FBNIC_QUEUE_TWQ_CTL_RESET);
 	twq->tail = 0;
 	twq->head = 0;
+	twq->deferred_meta = -1;
 
 	/* Store descriptor ring address and size */
 	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_BAL, lower_32_bits(twq->dma));
-- 
2.55.0

