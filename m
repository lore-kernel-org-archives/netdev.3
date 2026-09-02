Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A83A75B1
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385231; cv=none; b=HSLo9Mc6FPd0YBC3Er6PLOjN2dTyfjAZboDtkJCTXkwRPWlY+leirXaebu6u6lFVKXqRVoplomJW5EpuF0l5ifORGt3WusamNTU5WSt5+gexn4VsYCgprmBMLg6kO3a8N9NbOhsQPesv/1XJMF89OiZw6JixpTJVCyf+K+kEBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385231; c=relaxed/simple;
	bh=Dq67t2Rd+hg8V0xvGWnBPE3j+TeyWEEtMdCfDQzDsoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIcTfLK36TD3EIyHtHbK62RSxfjJf/yxyeiMZ8MgWQ8lxNu5Qmts5a6ngAMlifMXgYwFjrPBIkiMryOAE95976nV8XpHHYsU2BE2uK5gSgLxgwcSsVhVrE7cm1qDZE/XvRmPwJBAL5ZMtXvEZPr9lU0z+PD661iEuzC6J9FW9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=HCDoZbHy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="HCDoZbHy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d9004f39d3so19078585ad.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788385222; x=1788990022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fGMF8dux1u/osYh+byEn+SjYk2NnCouch+o/Hv5HJY=;
        b=HCDoZbHyjiQySQGgJPybwUFqVs9FXhqp0l2ytAaZdEy6pFxasLdQfjq09er/yWTX0K
         GYPU5t8Olji2HJ23Jk6DRKRwXdr0JUEm3Qw2540zt7pjwfx5CD9/5R1AMswp8xA0dNEx
         /JhsrGNrITT5lH3IlPyV8QhnyZr1r4sRoELnvLQPE0PqhmgJiswTRz3p1vBnzUuB0VIq
         OssFytNpPgp1ORlS+wUpZ2nZ3bJBVQFlLIGs9K3MGa/k/YGf+46xIPSDUvaoIWoSneEc
         z9ZAx7FvkgHPHxP1iKc6ltE8TrQ+1gYwja/BbUnDeN/fIpaAVNAfSZpi520wb3xfDAo5
         MPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788385222; x=1788990022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fGMF8dux1u/osYh+byEn+SjYk2NnCouch+o/Hv5HJY=;
        b=FACj9flZW0H/jMrWfZ39OSBX9E6mveL+Q8uJHbaq0Ah3qBAg+VBFj4WiVyQuEF5Vaa
         EKa1HnqLJLqfO65qIUGhJKBvXjuxe3zUE+SSYjsgFpExKSy0KLUm0EwwvpXM7JCqrvpd
         6vFkHFEI+j492X3wdCMwMxmHSzuQTyY14QJJIjciyYAlVQDJGVctJaJvZdbi9/0Mh+cV
         xGAqasUqfUv/cZtY57/wtDiWP3l2mzDKdq2vtfIbxvzfti+6Cy/mPPaVHoa7JhE8412r
         V0YuTlnpII/gBbVKTyIzRI4/hF2PFzCdlUhTV6UtWBdjQq49sbVUay0gEc8FPx9slacR
         9NLQ==
X-Gm-Message-State: AFuF++nU1KXwAqX4VejcC5Ksintq/Z4Adpi7gILdg0I2eU0tHSGX0v9R
	v+xHFKCbtTtzaXQ24cINaf1fAyD61S9vCtJN0cPxoViNCSRg2OKAM0szZsZLsWZMV4/UncCdBOu
	NYhjU7Uk=
X-Gm-Gg: AYBFou1//tf4cbFY8Rky7eptXrm2GMeJ0DYkjVpq1GVAaRWJA3UVEIgzgy9ehOVpHmm
	Jc7MhE1qioO/jvCFcLmKIZxqaZ75LhpI3GR55TnCSpwLaOENTILj3Vd80OlRT8Kf+zNZLNvHLu5
	G2P6EUrP6GZjKwFwH2NHfvvLGVch9/f5bGFN1oc7siySJgpq9kqRdtx7fL/vKZ+KrUpnw2QLpbV
	uz6NcWq9Gt2uqW72SJtaT5xoq4ip/a/roG3lkhsBnZZzbRwGIheIEwHE8g+vf2XyWZW/O9R/U6Z
	GsjymsgpQff+e2Nd8ibvPnVhguV+cuMRUcYUXWqoTBRiZkQhlUDthc2m09D7A/OaDMaAfTe5hHh
	EpK6xmKjF7IqUlEBUQeU3421SXaXKrLu81y0AM6xM7HbXRqkI/bpmns+LBvw4iLWK783H+hBBD+
	w6ES1FRZao8KiiXd9WwdzGsZwUFnEaYrQ66CyHcGyiJaiQNFWG1qhM
X-Received: by 2002:a17:902:fac7:b0:2d7:203b:9863 with SMTP id d9443c01a7336-2daec5ff49bmr82734015ad.1.1788385221561;
        Wed, 02 Sep 2026 14:40:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe62d872sm909995ad.23.2026.09.02.14.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:40:20 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] bnxt_en: Prevent queue stop with deferred completions
Date: Wed,  2 Sep 2026 14:39:54 -0700
Message-ID: <20260902213956.4160615-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the driver receives a burst of packets, it can mark a BD with the
NO_CMPL bit to defer completions. The expectation is that the last
packet in the ring will have this bit unset and the completion generated
by that packet will cleanup that packet and the ones preceding it. This
helps to reduce the number of completions fired.

The suppressed completions are controlled by the driver and the number
of packets with suppressed completions scales with the size of the ring.
SW USO packets, on the other hand, have an upper bound on the maximum
number of BDs which can be consumed which does not scale with the ring
size.

So, for small rings it is possible that: a burst of packets is handed to
the driver, the driver defers completions for all of the packets because
the number of free descriptors stays above the threshold in the driver.
Then, a USO packet arrives, but the number of BDs available is not
enough and the USO code exits early.

In this case, you end up in a state where the ring is full of packets
with their completions suppressed, which can cause the queue to stop and
never be restarted.

Assuming default CONFIG_MAX_SKB_FRAGS, this is only possible for small
rings (<= 457 descriptors, below the driver default value) when
a burst of packets fills the ring, followed by a large USO packet that
can't fit. For larger rings, the delta between the completion
suppression threshold and the BDs required for SW USO is large enough
that completions will fire and this case is unreachable.

This issue was pointed out by Sashiko and while it seems fairly unlikely
given that the queue size must be small to trigger this, it is indeed
possible.

Fix this by tracking the last BD which deferred completions and
centralizing the logic for deciding when to ring the doorbell. The NO_CMPL
bit is now cleared in bnxt_txr_db_kick(), so every doorbell site is
covered, including the SW USO early exit. This guarantees the ring always
ends in a BD which generates a completion to clean it and wake the queue.

Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")
Cc: <stable@vger.kernel.org> # v7.1+: 4e15e89faac9: net: bnxt: ring the doorbell when SW USO exits early
Signed-off-by: Joe Damato <joe@dama.to>
---
v2:
  - Add kick_txbd0 to track the BD where completions were most recently
    deferred.
  - Update the logic in bnxt_txr_db_kick to clear the NO_CMPL bit if needed.
  - Remove the open-coded NO_CMPL clear from tx_done in bnxt_start_xmit()
    and key the flush off txr->kick_pending.
  - Update the signature of bnxt_sw_udp_gso_xmit to return 1/0/-1 when SW USO
    transmits, drops, or is busy. This delegates the handling of the doorbell
    to the caller, cleaning up the code as Jakub Kicinski suggested.

v1: https://lore.kernel.org/all/20260827230233.94878-1-joe@dama.to/

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 42 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 21 ++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  6 +--
 4 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59bcca73a2b..8c6e2ee6bee4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -462,6 +462,16 @@ u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 static void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			     u16 prod)
 {
+	/* If the most recent BD has its completion suppressed, unset the bit
+	 * so that a completion is generated, otherwise nothing is left to
+	 * clean the ring and wake the queue.
+	 */
+	if (txr->kick_txbd0) {
+		txr->kick_txbd0->tx_bd_len_flags_type &=
+			cpu_to_le32(~TX_BD_FLAGS_NO_CMPL);
+		txr->kick_txbd0 = NULL;
+	}
+
 	/* Sync BD data before updating doorbell */
 	wmb();
 	bnxt_db_write(bp, &txr->tx_db, prod);
@@ -485,7 +495,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
 	skb_frag_t *frag;
-	netdev_tx_t ret;
 
 	i = skb_get_queue_mapping(skb);
 	if (unlikely(i >= bp->tx_nr_rings)) {
@@ -509,11 +518,22 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_is_gso(skb) &&
 	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
 	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
-		ret = bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
-		if (txr->kick_pending)
+		int rc = bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+
+		/* if SW USO queued a packet, the doorbell will be written
+		 * below and there is no reason to track the last BD with
+		 * suppressed completions
+		 */
+		if (rc > 0)
+			txr->kick_txbd0 = NULL;
+
+		/* if a packet was queued by SW USO or a doorbell was pending
+		 * from a previous xmit that was deferred, write the doorbell.
+		 */
+		if (rc > 0 || txr->kick_pending)
 			bnxt_txr_db_kick(bp, txr, txr->tx_prod);
 
-		return ret;
+		return rc < 0 ? NETDEV_TX_BUSY : NETDEV_TX_OK;
 	}
 
 	free_size = bnxt_tx_avail(bp, txr);
@@ -751,23 +771,23 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	prod = NEXT_TX(prod);
 	WRITE_ONCE(txr->tx_prod, prod);
 
+	txr->kick_txbd0 = NULL;
 	if (!netdev_xmit_more() || netif_xmit_stopped(txq)) {
 		bnxt_txr_db_kick(bp, txr, prod);
 	} else {
-		if (free_size >= bp->tx_wake_thresh)
+		if (free_size >= bp->tx_wake_thresh) {
 			txbd0->tx_bd_len_flags_type |=
 				cpu_to_le32(TX_BD_FLAGS_NO_CMPL);
+			txr->kick_txbd0 = txbd0;
+		}
 		txr->kick_pending = 1;
 	}
 
 tx_done:
 
 	if (unlikely(bnxt_tx_avail(bp, txr) <= MAX_SKB_FRAGS + 1)) {
-		if (netdev_xmit_more() && !tx_buf->is_push) {
-			txbd0->tx_bd_len_flags_type &=
-				cpu_to_le32(~TX_BD_FLAGS_NO_CMPL);
+		if (txr->kick_pending)
 			bnxt_txr_db_kick(bp, txr, prod);
-		}
 
 		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
 				   bp->tx_wake_thresh);
@@ -5427,6 +5447,8 @@ static void bnxt_clear_ring_indices(struct bnxt *bp)
 			txr->tx_prod = 0;
 			txr->tx_cons = 0;
 			txr->tx_hw_cons = 0;
+			txr->kick_pending = 0;
+			txr->kick_txbd0 = NULL;
 		}
 
 		rxr = bnapi->rx_ring;
@@ -11772,6 +11794,8 @@ static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
 		txr->tx_prod = 0;
 		txr->tx_cons = 0;
 		txr->tx_hw_cons = 0;
+		txr->kick_pending = 0;
+		txr->kick_txbd0 = NULL;
 start_tx:
 		WRITE_ONCE(txr->dev_state, 0);
 		synchronize_net();
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ab894f8addef..dc5a16ec5943 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -993,6 +993,7 @@ struct bnxt_tx_ring_info {
 	u16			txq_index;
 	u8			tx_napi_idx;
 	u8			kick_pending;
+	struct tx_bd		*kick_txbd0;
 	struct bnxt_db_info	tx_db;
 
 	struct tx_bd		*tx_desc_ring[MAX_TX_PAGES];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index f7e18bea0fb8..6c1060fa2ea5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -31,10 +31,14 @@ static u32 bnxt_sw_gso_lhint(unsigned int len)
 		return TX_BD_FLAGS_LHINT_2048_AND_LARGER;
 }
 
-netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
-				 struct bnxt_tx_ring_info *txr,
-				 struct netdev_queue *txq,
-				 struct sk_buff *skb)
+/* Transmit an skb requiring software UDP segmentation.
+ *
+ * Returns 1 if the skb was queued and new BDs were produced, 0 if the skb
+ * was dropped, or -1 if the ring is full and the skb should be retried.
+ * The caller owns the doorbell for all three cases.
+ */
+int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			 struct netdev_queue *txq, struct sk_buff *skb)
 {
 	unsigned int last_unmap_len __maybe_unused = 0;
 	dma_addr_t last_unmap_addr __maybe_unused = 0;
@@ -69,7 +73,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
 		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
 				   bp->tx_wake_thresh);
-		return NETDEV_TX_BUSY;
+		return -1;
 	}
 
 	/* BD backpressure alone cannot prevent overwriting in-flight
@@ -77,7 +81,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	 */
 	if (!netif_txq_maybe_stop(txq, bnxt_inline_avail(txr),
 				  num_segs, num_segs))
-		return NETDEV_TX_BUSY;
+		return -1;
 
 	if (unlikely(tso_dma_map_init(&map, &pdev->dev, skb, hdr_len)))
 		goto drop;
@@ -223,16 +227,15 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	netdev_tx_sent_queue(txq, skb->len);
 
 	WRITE_ONCE(txr->tx_prod, prod);
-	txr->kick_pending = 1;
 
 	if (unlikely(bnxt_tx_avail(bp, txr) <= bp->tx_wake_thresh))
 		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
 				   bp->tx_wake_thresh);
 
-	return NETDEV_TX_OK;
+	return 1;
 
 drop:
 	dev_kfree_skb_any(skb);
 	dev_core_stats_tx_dropped_inc(bp->dev);
-	return NETDEV_TX_OK;
+	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
index 47528c20f311..77d9af97cc22 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -38,9 +38,7 @@ static inline int bnxt_min_tx_desc_cnt(struct bnxt *bp,
 	return BNXT_MIN_TX_DESC_CNT;
 }
 
-netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
-				 struct bnxt_tx_ring_info *txr,
-				 struct netdev_queue *txq,
-				 struct sk_buff *skb);
+int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			 struct netdev_queue *txq, struct sk_buff *skb);
 
 #endif

base-commit: 544d85de4dc22c01badfd8cefa59829ce35c4858
-- 
2.53.0-Meta

