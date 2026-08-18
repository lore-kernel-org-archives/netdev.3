Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41644A411
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047805; cv=none; b=j9uiIWUBQC8tITeeChwlR9q3Ymg1BUyyQLklX7dh7F0xzBPSox4e4EFKJoOFcVmiJ2Y2RIBDGDnvayqNVXXWzXWBWmNL2k5tVqZGha22EvmybHME7otoG2IMDy4QvSbv1yjmGwGaJ1WEgjNL9qjQ0LcgUbvqZEElR58QlyTfjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047805; c=relaxed/simple;
	bh=t5YkbLquxs/tQHtHG4AdKcLbR/5xmuAszt2pldSDTE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jQ/1yS2fSZmcN9t7JU9IgIy4iY9lXfewOOWmRl8YKAIAGf/WwJSaOrkm9SGPF8L/NZNN1f8MrQFxTGGQit2DeTKq3XIjnWRv7pTsnrzYi7FjLKja1YJuC3TJJ0Wmf0FUAuu3qRgUJI8V4A2e55FH0NGOpJ7cy/eoSoLDEyr4FEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz15t1787047727t2664674a
X-QQ-Originating-IP: H6Gm5YdDxCMW/QgcfRune4Lr4LPhREzWf7gDTFwVBOE=
Received: from localhost.localdomain ( [36.24.185.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Aug 2026 18:08:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15354848549195636384
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net v2] net: libwx: protect ring accesses with RCU
Date: Tue, 18 Aug 2026 18:08:41 +0800
Message-Id: <20260818100841.37483-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OBrCEnDgNcNqQoq9NU84fgq/TdjLblX9rY6eBQRQdPJMVlegMey1P4St
	5q7PvbioUXpDYlDHP0AuEU7BTPiyUsbE+oCZ/kogMo+Q2y6Bdxj6fDJ+e3qq7ID8mIEz7Mz
	kUq0ZnldZ4CBC7r1jh9Fs5+B/frbu0ElrHm95OnxaVBTP9P88RhzbhwxqSrKWHQysn62GDs
	XiSWMSOkAZ+PWjpLN39bVT9rb7mFruT5xgy44cx8GzwduZRSEiD8Newqdyift+lGLxhQ+1P
	F0KysoMEkrqK58rCja8CNtpvF1s95TWpmB/U5IW4oDRFKGiFQWTv0WD9GuyYmekJPrZy4eh
	a2mNIpuqduZ/DNgJpVIfkaUI8bEYE4kIbrCES12B8epe0iOcNuGi5I/ZXyp/ahJS8JfEzSd
	kAtiyFr7+TwA/eDow+ZK6WwrLfdwNWdz1d8x8SXwqO7LaBYLuyihslFhu/osnDZYYFkVLHM
	MRHx5sObAI2egA5l2EjlKUUBxSSRERTgSeTXmapaszhlcTBFZmUnz3Unbx61cJL5WEmMZk4
	7tMUNGMuWIrQboBsS00EU4+0o3L9rBYlDYJH34RgSYKn/B+1ew4q3VybnmJTfW3Wf5i5PDB
	B9LejWfPyvMA52CYVBjsTutuQufnk2vyy6xKE3Y0HmNeH2Cu9g/P5ihwwUE0K25IvZz8WjF
	K+lQsr0kAVBgZVU1YFh1r3YHlq2tzCXnQS03KnCOhMLTtPnjEMISFTeMWEaD8WFDU3f2SJH
	4PDNz/aCzxtEcyyQuTNHhkQgwznwh5IbgrNDxembmJ6Wy/YU4L/x2//Uw3WVtqBTyYrjR2o
	A0tCSRwVZPF/EEhEm0Q9Oo6RtzKP8S9X3kj9qEE0UinoBz1QNJMYpXMy2ZYFFXkJlt0mwFm
	4FTzpCDYiD4D3BZTse/wdAaXhRTedg/B4ehxlQ2t4DJmmFvRnhORirniN6rIC4eTdPPszgb
	vC3QxalJvj3p3ZFatIhgj+HyANvh7PFtg8cGyBO6dHXHfbevHniWGZhFUF6cSCOQ963pQmq
	3WRZJAP8gO03Z4Gsz2/VqWwy/EE3D9H5lonpuCtM+/ZV2mX4fvSRk9oLM+KNLRPblbbDd+L
	sT3d65SgXjr
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

During queue teardown or channel reconfiguration (e.g. via ethtool -L),
ring pointers in wx->rx_ring[] and wx->tx_ring[] can be cleared to NULL
and freed asynchronously via kfree_rcu().

Concurrency between interface reconfiguration and background tasks
(such as service tasks or dev_get_stats) can result in NULL pointer
dereferences or Use-After-Free (UAF) issues when accessing per-queue
structures. Specifically:
1. wx_update_stats() accesses per-queue Rx, RSC, and Tx rings without
   RCU read-side protection, and lacked NULL checks in the RSC
   accumulation loop.
2. wx_update_xoff_rx_lfc() walks wx->tx_ring[] and modifies ring->state
   without RCU protection or NULL checks, risking a kernel panic when
   flow control pause frames are received during queue teardown.
3. Queue assignment in wx_alloc_q_vector() used plain stores without
   release barrier semantics needed for lockless RCU readers.

Fix these by:
1. Enclosing queue statistics gathering and wx_update_xoff_rx_lfc() inside
   an rcu_read_lock() / rcu_read_unlock() section in wx_update_stats().
2. Adding READ_ONCE() and NULL checks when traversing wx->rx_ring[] and
   wx->tx_ring[] in wx_update_stats() and wx_update_xoff_rx_lfc().
3. Using rcu_assign_pointer() when publishing or clearing ring pointers in
   wx_alloc_q_vector() and wx_free_q_vector().

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v2:
- Moved rcu_read_unlock() after wx_update_xoff_rx_lfc() in wx_update_stats()
  to ensure flow control processing remains fully protected within the RCU
  read-side critical section.
- Replaced WRITE_ONCE() with rcu_assign_pointer() when assigning and clearing
  ring pointers in wx_alloc_q_vector() and wx_free_q_vector(), providing
  proper release memory barrier semantics for lockless RCU readers.
- Added __rcu annotations to tx_ring and rx_ring in struct wx (wx_type.h) to
  align with Linux kernel RCU coding standards and fix Sparse warnings.
v1: https://lore.kernel.org/netdev/20260813095141.88227-1-mengyuanlou@net-swift.com/
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 29 ++++++++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  |  8 +++---
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  4 +--
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 122c4952d203..19ce458f9cc6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2870,8 +2870,13 @@ static void wx_update_xoff_rx_lfc(struct wx *wx)
 	if (!data)
 		return;
 
-	for (i = 0; i < wx->num_tx_queues; i++)
-		clear_bit(WX_HANG_CHECK_ARMED, wx->tx_ring[i]->state);
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = READ_ONCE(wx->tx_ring[i]);
+
+		if (!tx_ring)
+			continue;
+		clear_bit(WX_HANG_CHECK_ARMED, tx_ring->state);
+	}
 }
 
 /**
@@ -2893,10 +2898,13 @@ void wx_update_stats(struct wx *wx)
 
 	spin_lock(&wx->hw_stats_lock);
 
+	rcu_read_lock();
 	/* gather some stats to the wx struct that are per queue */
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *rx_ring = wx->rx_ring[i];
+		struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[i]);
 
+		if (!rx_ring)
+			continue;
 		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
 		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
 		hw_csum_rx_good += rx_ring->rx_stats.csum_good_cnt;
@@ -2912,15 +2920,23 @@ void wx_update_stats(struct wx *wx)
 		u64 rsc_flush = 0;
 
 		for (i = 0; i < wx->num_rx_queues; i++) {
-			rsc_count += wx->rx_ring[i]->rx_stats.rsc_count;
-			rsc_flush += wx->rx_ring[i]->rx_stats.rsc_flush;
+			struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[i]);
+
+			if (!rx_ring)
+				continue;
+
+			rsc_count += rx_ring->rx_stats.rsc_count;
+			rsc_flush += rx_ring->rx_stats.rsc_flush;
 		}
 		wx->rsc_count = rsc_count;
 		wx->rsc_flush = rsc_flush;
 	}
 
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		struct wx_ring *tx_ring = wx->tx_ring[i];
+		struct wx_ring *tx_ring = READ_ONCE(wx->tx_ring[i]);
+
+		if (!tx_ring)
+			continue;
 
 		restart_queue += tx_ring->tx_stats.restart_queue;
 		tx_busy += tx_ring->tx_stats.tx_busy;
@@ -2929,6 +2945,7 @@ void wx_update_stats(struct wx *wx)
 	wx->tx_busy = tx_busy;
 
 	wx_update_xoff_rx_lfc(wx);
+	rcu_read_unlock();
 
 	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
 	hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ed5aad7857bd..4047e5d2bcff 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2191,7 +2191,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = txr_idx;
 
 		/* assign ring to wx */
-		wx->tx_ring[txr_idx] = ring;
+		rcu_assign_pointer(wx->tx_ring[txr_idx], ring);
 
 		/* update count and index */
 		txr_count--;
@@ -2217,7 +2217,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = rxr_idx;
 
 		/* assign ring to wx */
-		wx->rx_ring[rxr_idx] = ring;
+		rcu_assign_pointer(wx->rx_ring[rxr_idx], ring);
 
 		/* update count and index */
 		rxr_count--;
@@ -2245,10 +2245,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
 	struct wx_ring *ring;
 
 	wx_for_each_ring(ring, q_vector->tx)
-		wx->tx_ring[ring->queue_index] = NULL;
+		rcu_assign_pointer(wx->tx_ring[ring->queue_index], NULL);
 
 	wx_for_each_ring(ring, q_vector->rx)
-		wx->rx_ring[ring->queue_index] = NULL;
+		rcu_assign_pointer(wx->rx_ring[ring->queue_index], NULL);
 
 	wx->q_vector[v_idx] = NULL;
 	netif_napi_del(&q_vector->napi);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 2eba5ab59925..ec75ca116979 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1359,8 +1359,8 @@ struct wx {
 	u32 tx_ring_count;
 	u32 rx_ring_count;
 
-	struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
-	struct wx_ring *rx_ring[64];
+	struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
+	struct wx_ring __rcu *rx_ring[64];
 	struct wx_q_vector *q_vector[64];
 	int num_rx_pools;
 	int num_rx_queues_per_pool;
-- 
2.30.1

