Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE031F986
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567843; cv=none; b=N3kx+GeebUzCgLt7BKn1WuYHJfv12JR+XJ2FEZY7rP8ri8MOCGJOVULgSDI8f+tzCydBlcwXKPiagr7Otz2J9RT2ySvrye82ZSJu0nySHVwZBz24icpZhbRh3L0T+Au8PdUtW59e1KUwbwra/xw+wPGEBhL3Ua1NepDE6vPra0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567843; c=relaxed/simple;
	bh=kECWN0/pzXScznSeThBwo3vnkzeXw/lV52803oEcMbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jOGiqzQ2IACtyT5kqD2+2SnBymwKrMR4rLCFVfmXUf43iN6cRLjvLHkxqxVifsK0WNMuYAD1IHegEpvB/y+SqMGcoBtw+qaze+Ci1QsUrqsH+uyxMOtdRRuvDBoro68ZnoXpJxJdhI0xTIB0IBfdWp0d8w5PJFDRMsePele+zSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz6t1787567775te9b9befc
X-QQ-Originating-IP: 6l6kkU4gKuNMLPs8CNFcn9w5nubiblB/T/a1T/hgW8Q=
Received: from localhost.localdomain ( [122.233.170.62])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Aug 2026 18:36:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12417051061719465739
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
Subject: [PATCH net v3] net: libwx: protect ring accesses with RCU
Date: Mon, 24 Aug 2026 18:36:06 +0800
Message-Id: <20260824103606.303-1-mengyuanlou@net-swift.com>
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
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: M0B+OzpJUlV88F42ld9q9gaLhn8qIhqljojRdVsOe7BHrE4E/Tlpmcma
	Kb5qiZeNMfHKqAcH7RyVKbcZvdEFZghYeebDesniUnf5tQO03Kr7wnyJ6QSjDupITP0iHGy
	awoqn/LdR9PzWZXWU7Vs7PPscWbThI8jasDKIzcls5HoKYQa2xE9bv3KigKgpPOi0fAFHal
	BFE/5RYjDLVx74yVDkaD7jceuTZk6MGx8RUi8hQz8EUIU4pUk5HMWde0+XGpXLYLD1Yo/0d
	33U9xEMEJmEluMsHxflVtMInI2Kvnunh6PmhrxGY3mID+osCUiMBOO66dizpf0UkX8UeLen
	kg75Y53oap4f0V/aWRN/rJ9L1UVV7ihjhJpmy48g97UHlBazgBr+Yo2vV/NonXsjVvPCWur
	LL+XyycbkKI1/D7JzFnw9wj/PnZxA3332Jd8KjSZE8Piu/Zv/sHDP8rPjG8mf98hlK7Tn1O
	5TvOhUpa7LDQVFu8CCNNZ6UemBZa2n+qF0CIxrcm2fK8A4o6x4Rt0H7eQJW620QMGC72qSr
	xUI/KbCpOcQojEQ/vaxLSICxPJoTFsLEl/dEDBLU7sAj4cl2p79fJLsuNBTG4npb5YkNMsR
	UHbNwcrmjtvvinKaRbxo/Nr5RoDz1RiMQuv5ocIXnZ4FXOcECsNDtyiQhMdQ6+cawZcpRUW
	vA3qYtvf7HOBsARTIFpHWrOmeQLWC4O7XyFvIOExLzwBuTDqUDV2GcWppjXRxTGCYfFygNf
	WGMZmpdCfgqRZ6s4CvAuiKrqdiyWB4/dU7ELmiWEe2ovSDerBXYoNaff2nM6EguE4diiHpS
	27UUM7oeQWx48uFzxueXzSN1gCry4JdAmxjSQCaArrkuurGl3E7H1UQpLmrBPP8xmICHpT/
	W+u0faGz9HrBLrHO93F4Hr+myQJ8u+jdn9F+zn7vTE71hWTojmEA53t1/VHA6jv72Z0zpmI
	dZIWdL89OEFIzGP12b4vY1PLkBulhxD6FoPoxO0J4m156rSzkiNtotFfMZ0uJ6NjaLFJvb1
	z11c+oglz513AQS0OoLmQatpz33FLNNHcagi1eHLqKA2SuJbAv2NoDUgXYquUBd7Fh+OnQ2
	eOvTBe3Kyczs2sqEcvXaMP3RQBb8a6N2w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

During queue teardown or channel reconfiguration (e.g. via ethtool -L),
ring pointers in wx->rx_ring[] and wx->tx_ring[] can be cleared to NULL
and freed asynchronously via kfree_rcu().

Concurrency between interface reconfiguration and background tasks (such
as service tasks or dev_get_stats) can result in NULL pointer dereferences
or Use-After-Free (UAF) issues when accessing per-queue structures.
Specifically:
1. wx_update_stats() accesses per-queue Rx, RSC, and Tx rings without RCU
   read-side protection, and lacked NULL checks in the RSC accumulation
   loop.
2. wx_update_xoff_rx_lfc() walks wx->tx_ring[] and modifies ring->state
   without RCU protection or NULL checks, risking a kernel panic when flow
   control pause frames are received during queue teardown.
3. Queue status checks in wx_err.c and PTP watchdog in wx_ptp.c dereference
   ring pointers without RCU read-side critical sections or NULL checks.
4. Queue assignment in wx_alloc_q_vector() used plain stores without
   release barrier semantics needed for lockless RCU readers.

Fix these by:
1. Enclosing queue statistics gathering in wx_update_stats(),
   xoff processing in wx_update_xoff_rx_lfc(), error handling in wx_err.c,
   and PTP status checks in wx_ptp.c inside
   rcu_read_lock() / rcu_read_unlock() sections.
2. Replacing unprotected accesses with rcu_dereference() and adding NULL
   checks when traversing wx->rx_ring[] and wx->tx_ring[].
3. Using rcu_assign_pointer() when publishing or clearing ring pointers in
   wx_alloc_q_vector() and wx_free_q_vector().

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v3:
- Replaced READ_ONCE() with rcu_dereference() when reading __rcu annotated
  rx_ring and tx_ring pointers to fix Sparse static checker warnings and
  enable Lockdep runtime validation.
- Wrapped wx_update_xoff_rx_lfc() with its own rcu_read_lock() and
  rcu_read_unlock() section to ensure self-contained protection regardless
  of caller context.
- Extended RCU read-side critical sections and NULL pointer checks to other
  background tasks accessing ring arrays, including wx_ring_tx_pending(),
  wx_detect_tx_hang() in wx_err.c, and wx_ptp_rx_hang() in wx_ptp.c.
- Updated commit message to accurately reflect the use of rcu_dereference()
  and the expanded scope of protected functions.
v2: https://lore.kernel.org/netdev/20260818100841.37483-1-mengyuanlou@net-swift.com/
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c  | 20 ++++++++++---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 31 ++++++++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 12 ++++----
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c  |  6 +++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  4 +--
 5 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index b56fbdc959de..8eadb4d3abcf 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -201,12 +201,18 @@ static bool wx_ring_tx_pending(struct wx *wx)
 {
 	int i;
 
+	rcu_read_lock();
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		struct wx_ring *tx_ring = wx->tx_ring[i];
+		struct wx_ring *tx_ring = rcu_dereference(wx->tx_ring[i]);
 
-		if (tx_ring->next_to_use != tx_ring->next_to_clean)
+		if (!tx_ring)
+			continue;
+		if (tx_ring->next_to_use != tx_ring->next_to_clean) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
+	rcu_read_unlock();
 
 	return false;
 }
@@ -264,8 +270,14 @@ static void wx_detect_tx_hang(struct wx *wx)
 
 	/* Force detection of hung controller */
 	if (netif_carrier_ok(wx->netdev)) {
-		for (i = 0; i < wx->num_tx_queues; i++)
-			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);
+		rcu_read_lock();
+		for (i = 0; i < wx->num_tx_queues; i++) {
+			struct wx_ring *tx_ring = rcu_dereference(wx->tx_ring[i]);
+
+			if (tx_ring)
+				set_bit(WX_TX_DETECT_HANG, tx_ring->state);
+		}
+		rcu_read_unlock();
 	}
 }
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 122c4952d203..96ce3a4bbec7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2870,8 +2870,15 @@ static void wx_update_xoff_rx_lfc(struct wx *wx)
 	if (!data)
 		return;
 
-	for (i = 0; i < wx->num_tx_queues; i++)
-		clear_bit(WX_HANG_CHECK_ARMED, wx->tx_ring[i]->state);
+	rcu_read_lock();
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = rcu_dereference(wx->tx_ring[i]);
+
+		if (!tx_ring)
+			continue;
+		clear_bit(WX_HANG_CHECK_ARMED, tx_ring->state);
+	}
+	rcu_read_unlock();
 }
 
 /**
@@ -2893,10 +2900,13 @@ void wx_update_stats(struct wx *wx)
 
 	spin_lock(&wx->hw_stats_lock);
 
+	rcu_read_lock();
 	/* gather some stats to the wx struct that are per queue */
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *rx_ring = wx->rx_ring[i];
+		struct wx_ring *rx_ring = rcu_dereference(wx->rx_ring[i]);
 
+		if (!rx_ring)
+			continue;
 		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
 		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
 		hw_csum_rx_good += rx_ring->rx_stats.csum_good_cnt;
@@ -2912,19 +2922,28 @@ void wx_update_stats(struct wx *wx)
 		u64 rsc_flush = 0;
 
 		for (i = 0; i < wx->num_rx_queues; i++) {
-			rsc_count += wx->rx_ring[i]->rx_stats.rsc_count;
-			rsc_flush += wx->rx_ring[i]->rx_stats.rsc_flush;
+			struct wx_ring *rx_ring = rcu_dereference(wx->rx_ring[i]);
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
+		struct wx_ring *tx_ring = rcu_dereference(wx->tx_ring[i]);
+
+		if (!tx_ring)
+			continue;
 
 		restart_queue += tx_ring->tx_stats.restart_queue;
 		tx_busy += tx_ring->tx_stats.tx_busy;
 	}
+	rcu_read_unlock();
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ed5aad7857bd..423b14c56949 100644
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
@@ -3097,7 +3097,7 @@ void wx_get_stats64(struct net_device *netdev,
 
 	rcu_read_lock();
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *ring = READ_ONCE(wx->rx_ring[i]);
+		struct wx_ring *ring = rcu_dereference(wx->rx_ring[i]);
 		u64 bytes, packets;
 		unsigned int start;
 
@@ -3113,7 +3113,7 @@ void wx_get_stats64(struct net_device *netdev,
 	}
 
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		struct wx_ring *ring = READ_ONCE(wx->tx_ring[i]);
+		struct wx_ring *ring = rcu_dereference(wx->tx_ring[i]);
 		u64 bytes, packets;
 		unsigned int start;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 3eea647c4742..47b1599a1afa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -274,11 +274,15 @@ static void wx_ptp_rx_hang(struct wx *wx)
 
 	/* determine the most recent watchdog or rx_timestamp event */
 	rx_event = wx->last_rx_ptp_check;
+	rcu_read_lock();
 	for (n = 0; n < wx->num_rx_queues; n++) {
-		rx_ring = wx->rx_ring[n];
+		rx_ring = rcu_dereference(wx->rx_ring[n]);
+		if (!rx_ring)
+			continue;
 		if (time_after(rx_ring->last_rx_timestamp, rx_event))
 			rx_event = rx_ring->last_rx_timestamp;
 	}
+	rcu_read_unlock();
 
 	/* only need to read the high RXSTMP register to clear the lock */
 	if (time_is_before_jiffies(rx_event + 5 * HZ)) {
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

