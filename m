Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130869;
	b=ayYvRoInor8Uci0Xi1rU/WcDtJl1WHj4U0hlg1xFZstHHRAiRiCBxeX2N20+lYtiumLB
	 SVygOoXWUgDSImrJlJM6qBB0igHt39lI/Qe8aN41t0cypx77PGuZoELwv4egMFfF+8c0H
	 0IZRm4NqTpLfXWxMzpJTgp1uhnZ2WiNQTBwVh7DE8Mrva8kW/Gs/v6oYviN4gpVOgLRzL
	 fHi9KhbZCXsbbYilTL6PQC4+uqMiAAupnPEvAHtSF59OKSIj3DRmNoCd7u8rvNuURaAYy
	 T8V/HnDe4H4u2SvT6O8RqbFby4C6uDxKj75DndtcE8q8a0tMdMIGnARxUcEGTbmJJDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130869;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=aGER03RWGtoC6pTzGaMF8rcAs+TK4n4VOk3mZ3NGJrw=;
	b=FlZQJIadIOdlrzh5ycycSBX4tXpoBjMvko9PPLZW+0k8qHw4VmRRUQPDrM7EtUfpelez
	 4Z2CQpPzmc6UxYaXz6DjaBcS4QRYsHObv5DLrjnBm3AyjVfaHPe6Y7XNRRugh3h4t+Z0P
	 KJmZNqt5cDQZur0P4jXjO9nXy6VQvVNym3LQXreRWQyJB57ZzBx1EK8xIVOoxrcMCHnU/
	 qNPQHhgqhg4UTIPpJldC4o5mkVUTbonoiVVhoB6d4Bjmv/TSQgaWOzeXzmV0Ndxd1zHWV
	 1KC9I0G0VuL43AN8CwN8DVDJ4bClQHvpLUr65FulFW/w6muNIgUv97rkpQKNGensccA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34D606A31F;
	Tue, 27 Oct 2026 19:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A34D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A68B6A50C9;
	Tue, 27 Oct 2026 20:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793130866; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aGER03RWGtoC6pTzGaMF8rcAs+TK4n4VOk3mZ3NGJrw=;
	b=J54+9hrB5z/EoZe9/eHmxL7DcXZ0zqrC1MT8PoQvw078XJdvI7ONZCV5F4g0kKkNtETku0
	wkkiTMY7NEIqF96pvcD3dJgFSZTWWqMAQtIo2/tw+oy6Cu3O7kWbnvUqbkzMNzMDamsdpV
	1aH+OuQ2IPZga5gHVTlMuIR6r7HBH5jlaPMFSGMrOU431fKrKhptH+akdDPgGfxnnZmz+9
	tPnyNBJIdWhIxpZ/t2J2J02+KqbIAvQGn8XrJnTTSARtWY3AWARgPEtnhY9s0lCC8FbLEg
	BFvoi5bV+vFSj37rSr01Q/rSoY6mLU8Bzn30OMsWUdNebs/EqfEZFev8LJWhVg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 27 Oct 2026 20:54:07 +0100
Subject: [PATCH net 2/2] octeontx2-pf: pass the skb to
 otx2_dma_unmap_skb_frags()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-2-2114c4f10c36@tipi-net.de>
References: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
In-Reply-To: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

After a DMA mapping error, the unmap reads an skb pointer that is not
set yet. It can be NULL or left over from an earlier packet.

Fixes: 195c3d463181 ("octeontx2-pf: map skb data as device writeable")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c |  2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c |  5 ++---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h |  3 ++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c   | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 3920cd0985831..4434356087814 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -1037,7 +1037,7 @@ bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
 	cn10k_cpt_inst_flush(pf, &inst, sizeof(struct cpt_inst_s));
 	return true;
 drop:
-	otx2_dma_unmap_skb_frags(pf, &sq->sg[sq->head]);
+	otx2_dma_unmap_skb_frags(pf, &sq->sg[sq->head], skb);
 	sq->sg[sq->head].skb = (u64)NULL;
 	atomic_long_inc(&pf->hw.dev_stats.tx_discards);
 	dev_kfree_skb_any(skb);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index c441c0161dbf4..c85436457286e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -2132,13 +2132,12 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 	return otx2_dma_map_page(pfvf, page, offset, *len, dir);
 }
 
-void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
+void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg,
+			      struct sk_buff *skb)
 {
 	enum dma_data_direction dir = DMA_TO_DEVICE;
-	struct sk_buff *skb = NULL;
 	int seg;
 
-	skb = (struct sk_buff *)sg->skb;
 	if (unlikely(xfrm_offload(skb)))
 		dir = DMA_BIDIRECTIONAL;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 3c7275d545bba..8417af94a02a0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1252,7 +1252,8 @@ static inline int mcam_entry_cmp(const void *a, const void *b)
 
 dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 				 struct sk_buff *skb, int seg, int *len);
-void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
+void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg,
+			      struct sk_buff *skb);
 int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
 void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
 			int first, int mdevs, u64 intr);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 3d38ca2402e38..90af9b9044aa0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -160,7 +160,7 @@ static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
 
 	*tx_bytes += skb->len;
 	(*tx_pkts)++;
-	otx2_dma_unmap_skb_frags(pfvf, sg);
+	otx2_dma_unmap_skb_frags(pfvf, sg, skb);
 	napi_consume_skb(skb, budget);
 	sg->skb = (u64)NULL;
 }
@@ -872,7 +872,7 @@ static int otx2_dma_map_tso_skb(struct otx2_nic *pfvf,
 	}
 	return 0;
 unmap:
-	otx2_dma_unmap_skb_frags(pfvf, sg);
+	otx2_dma_unmap_skb_frags(pfvf, sg, skb);
 	return -EINVAL;
 }
 
@@ -1261,7 +1261,7 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
 		ret = otx2_sqe_add_sg(pfvf, sq, skb, num_segs, &offset);
 
 	if (!ret) {
-		otx2_dma_unmap_skb_frags(pfvf, &sq->sg[sq->head]);
+		otx2_dma_unmap_skb_frags(pfvf, &sq->sg[sq->head], skb);
 		return false;
 	}
 
@@ -1353,7 +1353,7 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 		if (skb) {
 			tx_bytes += skb->len;
 			tx_pkts++;
-			otx2_dma_unmap_skb_frags(pfvf, sg);
+			otx2_dma_unmap_skb_frags(pfvf, sg, skb);
 			dev_kfree_skb_any(skb);
 			sg->skb = (u64)NULL;
 		}
@@ -1408,7 +1408,7 @@ void otx2_free_pending_sqe(struct otx2_nic *pfvf)
 			if (skb) {
 				tx_bytes += skb->len;
 				tx_pkts++;
-				otx2_dma_unmap_skb_frags(pfvf, sg);
+				otx2_dma_unmap_skb_frags(pfvf, sg, skb);
 				dev_kfree_skb_any(skb);
 				sg->skb = (u64)NULL;
 			}

-- 
2.53.0

