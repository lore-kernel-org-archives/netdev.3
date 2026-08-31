Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D003A5E70
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212870; cv=none; b=Gd1KUGJ+Q5De4qVFZnoV1s21niOEFOafLSBAiUrfaI5KEMTXsKXGCVWt32EaC7w/DkNdNMVlcATnBAyolLYStAQI+Pp5CMXv6C/U4hKawJAN+2QgBCJ0oZSqIUrbiHGM0N7PVtX1whX8rHPQm9vWKgjOXaPj+pQq8SkjxoOJb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212870; c=relaxed/simple;
	bh=UjQ9D/LYa3YuikqqqqDyIAZ76b9a8tZ4moouFUN8afk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Onp7U/CWJV6fap6KjpBXcOjFU/r2YPnANycIVH/+VYQcoMSa4A9pnmNAun0oJyUkWxEvUTcVP8foEcQ/Xq6ayFZLDjsJYR8akfDKwKv7tpbum4xiZavcbuTdYNF97QIaAYdvtRHuBwd+Ys0eTAgF+RdiaUdzXttVI72rSyS74kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+sA+eXG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+sA+eXG"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso1304261fa.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788212863; x=1788817663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXmLTUcCngMrB5jBKoeiBiFNAXXmpHJGCK06GzS0et4=;
        b=g+sA+eXGb0PsRVoGtF3mxz5GkHEzVKka887amcrZ9+kW+FBhBDl0yhVOgwpruMSV29
         cSzD8Do2atPMJqEZTb2C4qzNKIie8sVMVrtvO9BMLSabOLUME9fpZlUHmlOFm2qP7Rv6
         pgbhq60Q2phqCboX2LmK5BpaqIVMd0f5qPwBZzhmXYbPlcapxVk7Gx0EUq4GLzrHHJqM
         PIIrScdC3gqEM+ORqm43LpAdfUIvuwov8Rr882CF/7thA2xZTsLMlVbxOJNGkDA7tLvK
         ET9wOkIOTVG9B22B7EtxiX4gA66K6aQRrwDwx4o5dyHf04JK7wBIGqPDGJYHhrsRjuak
         R9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788212863; x=1788817663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXmLTUcCngMrB5jBKoeiBiFNAXXmpHJGCK06GzS0et4=;
        b=iuoereVxtEtfeZLXVvh0txtSpCeP4Zqo4maUzJ3CAq6EqIb0vsgXlGKbdGXmNhAvej
         f5HQjDMQApLX5WoTCbUMBEMstXquZbIaRyUYNQLFnizJYoN7V1OFgMDYijjzExWGCYoO
         qQL9uADPCnOFnmNW+I1vl9I48sR1g41xvy+IS3VNahquqoYoN7khWFcyo2u8f/rC5lAq
         0X16qpwadyGD+eXR+JtazvPAym0W6K+N/QWWkhV+/kAcs5+QQ8hK4HWtBPhPdSVQ0SX3
         ix7RXHcSmmzcUxOXrCyaTBoHWq8npqQSy3vsKcm5bJhhjtZ73UU2NzP8m5iggOsMLLrj
         TE3g==
X-Forwarded-Encrypted: i=1; AKwUvBzF8xvO/6mYcZ4gstheF/Nl5arssZLdg8UDGLoKJXeLGXsbfZphFgcxl5zAwiQv8j3L70zgxW4=@vger.kernel.org
X-Gm-Message-State: AFuF++k2Y0comyacHVIH2NKdlDoUJGP/njPEFjU+aR8LKdHy7h9ICa9J
	69+pBt9JNELad0K83InZooqHQm8emhROG5MIKUA2D0aQiCrNtupYh0w=
X-Gm-Gg: AYBFou0oZAOpAkBVyUzMdXmNgpnw5qEtEMpe17CfjYzFIwSitE92haSROm4ZgL5oYHP
	jgke+5BJZNCwM7IdjzJe8CGBW67tpdNDVvq8sVlod7SbWrtva24uyrahkFxDHAj2q4/Ivnlao5U
	cTUefwtUPcKF2AvZDBlcppK9zf8c0u/i06tlkBI5VHqhomv8ghM4V6KwkgukEU16hVJcNh1Quce
	WPNm8YwqnXQE8d76iW8s4rVPAA07Zgn2rdyshR23GKxOl01ZP/+uklVNShKIOwEfZlS9Tn683BF
	cP3cOE2xRbdg17HOXDSuVU7Y1nkBaaFPuvGOXB8z99FtdA6+GHe5mJRPl7QjcS0PDE8imlpmQ+A
	cs5Bwi5YIvy/cmqDuhDTLz7xhwKV1E7UhAvDF/6SBOqpHncV87NjNNLcpxUB4r38ha4KGyFUetH
	RSsVJBTVlsXoGDNqP0MhmJZ9QfFPqG3EoPSQ/mz9mm4x+vOOub3Q==
X-Received: by 2002:a2e:8696:0:b0:3a1:ffd9:5438 with SMTP id 38308e7fff4ca-3a301ab4102mr53117361fa.1.1788212862381;
        Mon, 31 Aug 2026 14:47:42 -0700 (PDT)
Received: from fedora ([92.36.9.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a31550cefbsm18299201fa.9.2026.08.31.14.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:47:41 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH net v2 2/3] net: airoha: recover RX ring after hw completion stall
Date: Tue,  1 Sep 2026 00:47:00 +0100
Message-ID: <20260831234701.206021-3-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831234701.206021-1-sochnev.v.74@gmail.com>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
 <20260831234701.206021-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On AN7583 hw can stop advancing the descriptor the sequential consumer in
airoha_qdma_rx_process() is waiting on, while its own completion counter
keeps moving. The ring is then dead: NAPI is scheduled, finds DONE clear
at q->tail, and does nothing, forever.

Observed directly on ring 4 at its 16-descriptor default (devmem, qdma0):
REG_RX_CPU_IDX frozen at 15 for over an hour while REG_RX_DMA_IDX advanced
29 -> 96, with a 60-byte frame left stranded in the ring.
QDMA_DESC_DROP_MASK was never set. In practice this is hit during PPPoE
negotiation bursts on the shared "force to CPU" ring, where it stops the
dial-up from ever completing.

Detect it without trusting ring content: REG_RX_DMA_IDX is hw's own
counter, independent of what sw posted. If it advances across polls while
q->tail does not, hw is making progress the consumer cannot observe. Idle
rings, where hw does not advance either, are left alone. An earlier
version scanned the ring for a DONE descriptor and trusted its content;
that OOMed once it reached uninitialised DMA memory that happened to have
the bit set. A register cannot misfire that way.

Recovery is deferred to a work item, since the register access can sleep.
It drops what is in flight and re-arms the ring through the existing
cleanup_rx_queue()/fill_rx_queue() pair, which only touch the sw-owned
[tail, head) window and rewrite both indices from it. Trying instead to
identify and keep the descriptor hw used caused a page_pool double free.

GLOBAL_CFG_RX_DMA_EN_MASK is per-QDMA, not per-ring, so this briefly
pauses every ring behind that instance; there is no per-ring equivalent.
The measured pause is 986-1131 us over 13 recoveries, not the 50 ms
read_poll_timeout() ceiling, so the logged value is worth having.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 98 +++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h |  8 ++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c59201aded26..177a0e10e372 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3,12 +3,14 @@
  * Copyright (c) 2024 AIROHA Inc
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
  */
+#include <linux/ktime.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/workqueue.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
@@ -657,6 +659,34 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
+#define AIROHA_RX_STALL_THRESHOLD	3
+
+/* REG_RX_DMA_IDX is hw's own completion counter, independent of what sw has
+ * posted, so comparing it against q->tail spots the stall without trusting
+ * ring content: if hw keeps advancing while the strictly sequential consumer
+ * does not, it is completing descriptors that consumer can never reach.
+ */
+static void airoha_qdma_rx_check_stall(struct airoha_queue *q)
+{
+	struct airoha_qdma *qdma = q->qdma;
+	int qid = q - &qdma->q_rx[0];
+	u32 dma_idx;
+
+	dma_idx = airoha_qdma_get(qdma, REG_RX_DMA_IDX(qid),
+				  RX_RING_DMA_IDX_MASK);
+
+	if (q->stall_tail == q->tail && dma_idx != q->stall_dma_idx) {
+		if (++q->stall_count >= AIROHA_RX_STALL_THRESHOLD &&
+		    !test_and_set_bit(qid, qdma->rx_recover_mask))
+			schedule_work(&qdma->rx_recover_work);
+	} else {
+		q->stall_count = 0;
+	}
+
+	q->stall_tail = q->tail;
+	q->stall_dma_idx = dma_idx;
+}
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
@@ -675,8 +705,10 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct page *page;
 
 		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
-		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
+		if (!(desc_ctrl & QDMA_DESC_DONE_MASK)) {
+			airoha_qdma_rx_check_stall(q);
 			break;
+		}
 
 		dma_rmb();
 
@@ -895,6 +927,56 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->tail));
 }
 
+static void airoha_qdma_rx_recover_work(struct work_struct *work)
+{
+	struct airoha_qdma *qdma = container_of(work, struct airoha_qdma,
+						rx_recover_work);
+	int qid;
+
+	for_each_set_bit(qid, qdma->rx_recover_mask, AIROHA_NUM_RX_RING) {
+		struct airoha_queue *q = &qdma->q_rx[qid];
+		ktime_t rx_dma_off_ts;
+		s64 rx_dma_off_us;
+		u32 status;
+
+		napi_disable(&q->napi);
+
+		/* per-QDMA, not per-ring: this pauses every RX ring behind
+		 * this instance, hence the measured duration below
+		 */
+		rx_dma_off_ts = ktime_get();
+		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+				  GLOBAL_CFG_RX_DMA_EN_MASK);
+		if (read_poll_timeout(airoha_qdma_rr, status,
+				      !(status & GLOBAL_CFG_RX_DMA_BUSY_MASK),
+				      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
+				      qdma, REG_QDMA_GLOBAL_CFG))
+			dev_warn(qdma->eth->dev,
+				 "qid=%d RX DMA busy timeout during recovery\n",
+				 qid);
+
+		airoha_qdma_cleanup_rx_queue(q);
+		if (q->skb) {
+			dev_kfree_skb(q->skb);
+			q->skb = NULL;
+		}
+		airoha_qdma_fill_rx_queue(q);
+
+		airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
+				GLOBAL_CFG_RX_DMA_EN_MASK);
+		rx_dma_off_us = ktime_us_delta(ktime_get(), rx_dma_off_ts);
+
+		q->stall_count = 0;
+		napi_enable(&q->napi);
+		napi_schedule(&q->napi);
+
+		dev_warn_ratelimited(qdma->eth->dev,
+				     "qid=%d RX ring recovered after hw stall (RX DMA paused %lld us)\n",
+				     qid, rx_dma_off_us);
+		clear_bit(qid, qdma->rx_recover_mask);
+	}
+}
+
 static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
 {
 	int i;
@@ -1582,6 +1664,8 @@ static void airoha_qdma_cleanup(struct airoha_eth *eth,
 {
 	int i;
 
+	cancel_work_sync(&qdma->rx_recover_work);
+
 	if (test_bit(DEV_STATE_INITIALIZED, &eth->state)) {
 		u32 status;
 
@@ -1639,6 +1723,13 @@ static int airoha_hw_init(struct platform_device *pdev,
 	if (err)
 		return err;
 
+	/* init every instance up front: the error path below tears down all
+	 * of eth->qdma[], including entries the init loop never reached
+	 */
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		INIT_WORK(&eth->qdma[i].rx_recover_work,
+			  airoha_qdma_rx_recover_work);
+
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		err = airoha_qdma_init(pdev, eth, &eth->qdma[i]);
 		if (err)
@@ -1687,6 +1778,11 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 {
 	int i;
 
+	/* must not run or re-arm past this point: the work calls
+	 * napi_disable() too, and doing that twice spins forever
+	 */
+	disable_work_sync(&qdma->rx_recover_work);
+
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
 		napi_disable(&qdma->q_tx_irq[i].napi);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fa9a8edce22f..c195dad5ed58 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -207,6 +207,11 @@ struct airoha_queue {
 	bool txq_stopped;
 	bool flushing;
 
+	/* see airoha_qdma_rx_check_stall() */
+	u32 stall_dma_idx;
+	u16 stall_tail;
+	u8 stall_count;
+
 	struct napi_struct napi;
 	struct page_pool *page_pool;
 	struct sk_buff *skb;
@@ -567,6 +572,9 @@ struct airoha_qdma {
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
 
+	struct work_struct rx_recover_work;
+	DECLARE_BITMAP(rx_recover_mask, AIROHA_NUM_RX_RING);
+
 	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
-- 
2.55.0

