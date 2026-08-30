Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D90392C42
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076699; cv=none; b=loDaULa0Y37yW/pm18KsQ2oUkJVnHwQAchNtuyhvtWHrk5JipsWtv1ho4dnLhHootyKnFUd0hPs3mRGPJPCmATkOqVNLtA0+rF4k4ITv/q20ijrTbt5CjJlmGdCcx9gAHtbvOC4XKcCpHByhwH/yYmQrhTpJ6r1QSvF4ZfWiX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076699; c=relaxed/simple;
	bh=x8JllFo9rS1hBK/YFwAJzvhldCMKsOtTSJ/EGfuN8Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNWZr/ItNjRKCgzlB4aERbkg5x3rnrt78uU1I42kQ3lb2v7J3iyN58IboHRJK1Kw9bMG951gcC8ExDvyBcqvLfhGnWHYXJAsuxzdUZaCVUeFOiATV6NhV7uV1Ko3tc1uBwXAV4Yywcq+zLgB+v1HIwNOhbXqm/+SHPYI3glNEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVvIQUO6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVvIQUO6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so18649805e9.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788076686; x=1788681486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lK3jDNN57cOcYB2qd2k1oPSR5oRC9dvZDkaFcSv62Xg=;
        b=aVvIQUO6fLe0CX+imaZmpzNf3NcGDHcoWtmwKXZJOCFi14dWBWEDdH05M9PApVvGD/
         9YkUOLE5kcN2Y/KIE9scsgUDghYq8+Sb8q+L93XQwK67VbtyOiAa6FB0Xb9zW6DEnoJa
         +1DsvNmsa05wS6f0YYgJSERpUwsfZlngjfZ6smc4sXH0X7kKk8oS3OftHKc4SNxMKuhv
         AHlg87ijA4MteN8029IBHtOzG7lWfCzEyGygaj8friCGSsFaIg6z/FsneKlngKd0ePwh
         FsffMjBJSvk4+LQFiIJzY6GeaM37JcnxHGY0obn8iUvy3k4bbxByTAgQc1eEDbeufoP1
         UIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788076686; x=1788681486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lK3jDNN57cOcYB2qd2k1oPSR5oRC9dvZDkaFcSv62Xg=;
        b=b9CtjPiei6Gd314/BdIJ8oDKvRixuZZjDyEziHv8xgBEAQzUjGExhu9gkpqSu86bY/
         0I13yorexKTjNIoMtibCPncCdiUDmERWIxe8LhzFBSLzYaViIP3wLz6c/MxSTar4QH6V
         A7AAi2QMGUbprB0F/jOrzLNKdUP0kKLa3mtLADiBh/6kp6yLs8FM7X4bTaYucDih4Bpn
         oLn+fZG+grtQEZnBLC/6RWD9ibqdkjNaTO3Tigg9saAW9yjAshUD6pw36ktR5SKwx0x5
         yiunYe+JW0LzRT9yI9dLNKWhv2cfIvHJ4ycRrp6I1H0dSDY3oFfz/Ku24YvNSYQWNF7k
         1Exw==
X-Forwarded-Encrypted: i=1; AHgh+RpTeHnRFMRFBuoIK23sht2Ef1YvvLxLUXhw0ZA4V83gXtL3oEAFmNSE9Pw4pkGh4DQkSdMOKGg=@vger.kernel.org
X-Gm-Message-State: AFuF++mygATsYfh0Fp+0GhmN80CihU87iN50rQ9H1QbFV+6D/bKlAK4u
	pRJKcth/2gGBFiO3EZ8HwjWD66Tci+AOhAl2oypeLgbfgNGbkc8TxVs=
X-Gm-Gg: AR+sD1310mUTGF+JdFXp4Lwqr4aXM4xeIjTu2BXq4N/9pzG51OwioBt/bCNB3kuFnPj
	T7NhW9hNqSrgP2vH2RV4LQvMpX3kmqbig4EoRlWzWdPKKpq4M8QPwsyvZydu9WBfzUy9d1Rih22
	n+IiD/i/Y0tiWUYxrTruN/SyjWefjNYxwa1iDhJjShZbw1wckrz8WiB+JN4uTal0AHjK39fTeMh
	T6NPOxo2yrYR8efE5o8/vsmT8j7kbUsO9RQdHOY8/HlsmDt3QpOlop0JNS7J83vVOLx5I0VmYsl
	W2fnngMCgY35Tx+vwcQluOzPvbyFQbpjb68c6FkvHJTKcE/nBpUQWjqh8g45aHeL5K/TBgedB9c
	oy7aAyNJpg5x02LveFNotP3I18NpLIt7Ho4XrJExBc8eRhih9dYl6ylAAlWw+q2/7hpe3JkiyY5
	DGLKT/3TwDbwsSjqO4Ncb00FGCKYe8cwuCe54cJ4v+xLfBc+OBZz7j4W7zOVV1sA==
X-Received: by 2002:a05:600c:4f49:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49cd52b2c93mr18490055e9.0.1788076685856;
        Sun, 30 Aug 2026 00:58:05 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd53a4678sm14757875e9.13.2026.08.30.00.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:58:05 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH net-next 2/4] net: airoha: recover RX ring after hw completion race
Date: Sun, 30 Aug 2026 10:57:15 +0100
Message-ID: <20260830095717.37218-3-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830095717.37218-1-sochnev.v.74@gmail.com>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On AN7583, hardware can write a completed RX descriptor past the
software-posted boundary (q->head) before airoha_qdma_fill_rx_queue()
has actually posted a fresh buffer there, as if hardware advances its
own completion pointer independently of software's posting
bookkeeping. Since airoha_qdma_rx_process() consumes the ring strictly
sequentially starting at q->tail, the consumer stalls forever waiting
on a descriptor that hardware never writes, even though real,
completed frames are sitting further along in the ring. In practice
this is reachable during PPPoE/DHCP negotiation bursts on the small
shared "force to CPU" ring, and the interface silently stops receiving
on it.

Detect this without inspecting ring/descriptor memory content at all:
REG_RX_DMA_IDX is hardware's own completion counter, independent of
what has or hasn't been posted. If it keeps advancing across polls
while the software consumer (tail) does not move, hardware is making
progress the consumer can never observe - the ring is stuck. Idle
rings, where hardware isn't advancing either, are correctly left
alone. An earlier version of this recovery instead scanned ahead in
the ring for a DONE descriptor and trusted its content; that caused a
real OOM panic once it wandered into genuinely uninitialized DMA
memory that coincidentally had the DONE bit set. Comparing a hardware
register cannot misfire that way.

Once a stall is confirmed, defer to a work item (register access here
can sleep) that disables RX DMA, waits for it to actually go idle,
resyncs the ring via the existing cleanup_rx_queue()/fill_rx_queue()
pair - which only ever touches the software-owned [tail, head) window
and rewrites both RX_CPU_IDX and RX_DMA_IDX from it - and re-enables
RX DMA. This deliberately drops whatever was in flight on the ring
rather than trying to identify and preserve the specific descriptor
hardware used; a prior attempt at the latter caused a page_pool
double-free when the assumptions about which page was safe to free
turned out not to hold in all cases.

GLOBAL_CFG_RX_DMA_EN_MASK in REG_QDMA_GLOBAL_CFG is per-QDMA-instance,
not per-ring, so recovering one ring briefly pauses RX DMA on every
ring behind that QDMA (bounded by the 50ms busy-wait below). No
per-ring equivalent exists in the register map; this is the same bit
airoha_qdma_start()/stop() already use for whole-device up/down. Log
the actual measured duration of that pause alongside the recovery
message, rather than just citing the 50ms read_poll_timeout() upper
bound: that's the real cost paid by every other ring on the same QDMA
instance each time recovery fires, and it's worth having the real
number instead of the theoretical ceiling.

One cost worth calling out explicitly: airoha_qdma_rx_check_stall()
adds an uncached MMIO read of RX_DMA_IDX on the RX path, once per
airoha_qdma_rx_process() call that ends via the non-DONE break - i.e.
essentially every poll, on every ring, even though the condition it
detects is rare and specific to one ring. Gating the read on whether
the *previous* poll for this ring also reaped zero descriptors would
keep it off rings that are actively receiving, and I traced that
through for correctness: once the race actually happens, q->tail
freezes permanently (consumption here is strictly sequential), so
`done` is 0 on every poll after that point, not just some - the gate
would only cost about one extra poll before AIROHA_RX_STALL_THRESHOLD
is reached, not a suppression or false-negative risk. I haven't
implemented that gating here for lack of profiling data justifying the
added per-queue state against the (also unmeasured) cost of the
current unconditional read; happy to add it if it turns out to matter
in practice.

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 135 ++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h |  16 +++
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index a3e5aaeb75b3..b53fe5b17653 100644
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
@@ -657,6 +659,47 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
+/* number of consecutive polls where hw completion (RX_DMA_IDX) advances
+ * while the sw consumer (tail) doesn't, before declaring the ring stuck
+ */
+#define AIROHA_RX_STALL_THRESHOLD	3
+
+/* Detect an RX ring where hw's own completion pointer (RX_DMA_IDX) keeps
+ * moving while the sw consumer (q->tail) doesn't - i.e. hw has written
+ * further descriptors somewhere in the ring, but the strictly sequential
+ * consumer can never reach them because the one at q->head, which it is
+ * waiting on, was never marked DONE. This happens when hw writes a
+ * completed descriptor past q->head before airoha_qdma_fill_rx_queue()
+ * has posted a fresh buffer there, decoupled from sw's own posting
+ * bookkeeping.
+ *
+ * Deliberately does not inspect ring/descriptor memory content to detect
+ * this: an earlier version scanned ahead for a DONE descriptor and trusted
+ * its content, which caused a real OOM panic after it wandered into
+ * genuinely uninitialized DMA memory that coincidentally had the DONE bit
+ * set. RX_DMA_IDX is a hw register with a well-defined value regardless of
+ * ring content, so this can't misfire on garbage memory, and idle rings
+ * (no hw progress either) are naturally left alone.
+ */
+static void airoha_qdma_rx_check_stall(struct airoha_queue *q)
+{
+	struct airoha_qdma *qdma = q->qdma;
+	int qid = q - &qdma->q_rx[0];
+	u32 dma_idx = airoha_qdma_get(qdma, REG_RX_DMA_IDX(qid),
+				      RX_RING_DMA_IDX_MASK);
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
@@ -675,8 +718,10 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct page *page;
 
 		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
-		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
+		if (!(desc_ctrl & QDMA_DESC_DONE_MASK)) {
+			airoha_qdma_rx_check_stall(q);
 			break;
+		}
 
 		dma_rmb();
 
@@ -894,6 +939,75 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->tail));
 }
 
+static void airoha_qdma_rx_recover_work(struct work_struct *work)
+{
+	struct airoha_qdma *qdma = container_of(work, struct airoha_qdma,
+						 rx_recover_work);
+	int qid;
+
+	for_each_set_bit(qid, qdma->rx_recover_mask, AIROHA_NUM_RX_RING) {
+		struct airoha_queue *q = &qdma->q_rx[qid];
+		ktime_t rx_dma_off_ts;
+		s64 rx_dma_off_us;
+		u32 status;
+
+		if (!q->ndesc)
+			goto next;
+
+		napi_disable(&q->napi);
+
+		/* GLOBAL_CFG_RX_DMA_EN_MASK is per-QDMA, not per-ring, so
+		 * this pauses every RX ring on this QDMA instance, not just
+		 * the stalled one - track how long for, since that's the
+		 * real-world cost of recovery on unrelated rings.
+		 */
+		rx_dma_off_ts = ktime_get();
+
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
+		/* Drop whatever is currently in flight on this ring and
+		 * re-arm it from a known-clean state. cleanup_rx_queue()
+		 * only ever touches the sw-owned [tail, head) window and
+		 * resyncs both RX_CPU_IDX and RX_DMA_IDX to it, which is
+		 * what un-wedges a ring where hw wrote past the sw head
+		 * without the consumer ever advancing - no need to figure
+		 * out which descriptor hw actually used.
+		 */
+		airoha_qdma_cleanup_rx_queue(q);
+		if (q->skb) {
+			/* discard whatever scatter-gather frame was
+			 * mid-assembly when the stall was hit, cleanup_rx_queue()
+			 * above only resyncs the ring, not this
+			 */
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
+				     "qid=%d RX ring recovered after hw stall (RX DMA paused for %lld us on this QDMA instance)\n",
+				     qid, rx_dma_off_us);
+next:
+		clear_bit(qid, qdma->rx_recover_mask);
+	}
+}
+
 static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
 {
 	int i;
@@ -1594,6 +1708,8 @@ static void airoha_qdma_cleanup(struct airoha_eth *eth,
 {
 	int i;
 
+	cancel_work_sync(&qdma->rx_recover_work);
+
 	if (test_bit(DEV_STATE_INITIALIZED, &eth->state)) {
 		u32 status;
 
@@ -1651,6 +1767,15 @@ static int airoha_hw_init(struct platform_device *pdev,
 	if (err)
 		return err;
 
+	/* INIT_WORK() every instance up front, before any of them can fail
+	 * init and jump to the error path below, since that path tears down
+	 * every eth->qdma[] slot unconditionally, including ones this loop
+	 * never reached.
+	 */
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		INIT_WORK(&eth->qdma[i].rx_recover_work,
+			  airoha_qdma_rx_recover_work);
+
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		err = airoha_qdma_init(pdev, eth, &eth->qdma[i]);
 		if (err)
@@ -1699,6 +1824,14 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 {
 	int i;
 
+	/* Make sure rx_recover_work is neither running nor able to re-arm
+	 * before any napi_disable() below: it also calls napi_disable()/
+	 * napi_enable() on q_rx[].napi, and napi_disable() on an
+	 * already-disabled NAPI spins in napi_disable_locked() forever,
+	 * since only napi_enable() clears the state it waits on.
+	 */
+	disable_work_sync(&qdma->rx_recover_work);
+
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
 		napi_disable(&qdma->q_tx_irq[i].napi);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fa9a8edce22f..483d6b59c351 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -207,6 +207,15 @@ struct airoha_queue {
 	bool txq_stopped;
 	bool flushing;
 
+	/* RX hw stall detection: last REG_RX_DMA_IDX/tail snapshot taken
+	 * whenever the head-of-line descriptor isn't DONE, and how many
+	 * consecutive times hw made progress (DMA_IDX moved) while the
+	 * consumer (tail) didn't. See airoha_qdma_rx_check_stall().
+	 */
+	u32 stall_dma_idx;
+	u16 stall_tail;
+	u8 stall_count;
+
 	struct napi_struct napi;
 	struct page_pool *page_pool;
 	struct sk_buff *skb;
@@ -567,6 +576,13 @@ struct airoha_qdma {
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
 
+	/* recovery for RX rings whose hw completion pointer (RX_DMA_IDX)
+	 * keeps moving while the sw consumer is stuck; see
+	 * airoha_qdma_rx_check_stall() and airoha_qdma_rx_recover_work().
+	 */
+	struct work_struct rx_recover_work;
+	DECLARE_BITMAP(rx_recover_mask, AIROHA_NUM_RX_RING);
+
 	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
-- 
2.55.0

