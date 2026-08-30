Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B638399A
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788073685; cv=none; b=h1o5bAJm3sxV/WTjEuKFiJ4RgJXpNMiZFvNPA5FDpAwTySd/pumpIJVdnGix7GUZqAutsgwrPOw0a90HuTzWKS943bwx+xjgKtXzsOyi5YGieAw5NcafxRHseotMurobX6o/pT3oq2UXxZWt/k0HNQD+9+8hHQi2aNK2Z2ILnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788073685; c=relaxed/simple;
	bh=9EQmXxdFsOdWJOwXtVEvBP/iXEteCmwvLuiOBZae5Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNpF8eRRpYsBEA5C5U8gYyyhGK6g+j73eRxZqImz7PisXWvaCoIClgfl/NyM7rztNZpnTminz48V37iCJyKAgV8B73TztWvP+DS1nMytaxrAxiTFvE/qQrXkMCJu1frEm1CruVyHOTigoyOwcqkHE8a8mCjF3fR7zTNOxKehsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.58.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpip2t1788073609taceb0203
X-QQ-Originating-IP: MVSx1Z/qaqyPoaP4sfWkf4jrI4Xs4jk1YSqR87GDwOE=
Received: from 192.168.1.228 ( [192.168.1.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 30 Aug 2026 15:06:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11642051627260665772
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: linglingzhang@trustnetic.com,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net v4] net: libwx: protect ring accesses with RCU and NULL check
Date: Sun, 30 Aug 2026 15:06:24 +0800
Message-ID: <4353E83B1147D652+20260830070624.7410-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MXZrlka9y5vPXPHXhL4iPj5hddLg6zu/3Y5gyxy9wboJOTXO7v06dnHX
	fvZ2U5RSt02zZEWsuAiiCp3pJ6K8UOGUmj2KZWOp9F8mQWGh2dKFfwkJk1oAxC6VQWlAo0y
	5SXFan8taEWqZ3jwk9wKaiZwoKyGS6NwUBm7Kf1hziihBOfuUvUJeaC7HdMdUXAqyLAE0zk
	JLfYPo85elSvRxslg8Qs1vHal9tretRV5u9Lceb1D+pb9+mNN0J9CoM5haj7eloFVPjk4WK
	c058bj/lkd0E+QbEQR3q8bOJDPl9vaKZKe+NgZ5RK82TUNINspFGoeilrbQ6jbMWL53CK0g
	gbO5VCrffznSlvZuGw0aJzAD+gvFqYEBLdzmBHIh5X1EcS+39dRvUGC28kp8Jo++22/8LEW
	/B/MHVuKYeWFRyIWghqdPL+bLD8gyh7drCiKMI/mnKUYChXgBLZZfTV0wtssD6HwI9nIpmT
	yCQpz6GI4i9rC/k9qM5YlkxnX+RdtU8uaMXje2XlMSTg+OHs78nmEUP52DRkXchue6w6dzX
	yy/GUpGaKjKdRsw83aqfNOaGs/ep3MGztCj1+vd8u0YNbrXfnzg8nSN/TqEjBomqm1NnzM5
	Ax2B/+aZKEKwfnCijdfBGuPyDOuTpA6WuNJoWItpp/HLiy0jrt4B9iTSv8Ktrpdo2tfi5iw
	QI6PZ+tnBNGJKrr/X2X/4k/sjrbz2sQDnQp5OTf0UIS5ucXPfbUbdRfcj1FS1QL8q3WyYEm
	XKoF6M/2anRpzZv+SrNI7SKf1d8mik1MKre3XP3WUJjF0jxY0XJlpqP7T1hFbE+bjsUcMxZ
	TCT0j4ivNZi8qMvp47+NMwKpvuVe9FjXLdKY3VOGH+g7C7h4yYTrnji8H5l1EPpftf1e5Kf
	puil5u6uDa2TvPJF1NWUFV359rer+O7mN+eBLqlNiulhVqK7utSlXOfq8vzqEqedhC2x/Zm
	rmB+JMS+QZC4tAN4BLqlkC6bGO8FS3hdOZCe+pkZmd0ScGRu6L0CIoAvAvJXwa+cJ5O9gKA
	eHzvX/p8lAJlppKISl/Ktdpad5M17Z6W+1NSHWFF8TuFtloRyQxu6NvsdebwU45NkpaEiO1
	HPKiWAsCMw+r/PTZmF7VoRtlzA+gI8drg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

In wx_update_stats(), wx_get_ethtool_stats(), and other service tasks,
the ring pointers wx->rx_ring[i] and wx->tx_ring[i] can become NULL or be
freed asynchronously during queue teardown or channel reconfiguration.

1. Enclosing ring pointer traversals in wx_get_ethtool_stats(),
wx_vlan_strip_control(), wx_update_stats(), wx_update_xoff_rx_lfc(),
wx_err.c, and wx_ptp.c within rcu_read_lock()/rcu_read_unlock() sections.
2. Using READ_ONCE() when reading wx->rx_ring[] and wx->tx_ring[]
pointers alongside NULL check guards before dereferencing them.
3. Using WRITE_ONCE() when assigning and clearing ring pointers in
wx_alloc_q_vector() and wx_free_q_vector() to prevent compiler reordering.

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v4:
- Switched from rcu_dereference()/rcu_assign_pointer() back to
  READ_ONCE()/WRITE_ONCE().
- Standardized on READ_ONCE() and WRITE_ONCE() for all ring pointer
  accesses and assignments across the driver.
- Added RCU read-side critical sections (rcu_read_lock/unlock) and NULL
  pointer checks to wx_get_ethtool_stats() in wx_ethtool.c and
  wx_vlan_strip_control() in wx_hw.c.
- Updated commit message to explicitly document the expanded protection
  in ethtool statistics gathering and VLAN strip configuration tasks.
v3: https://lore.kernel.org/netdev/20260818100841.37483-1-mengyuanlou@net-swift.com/
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 22 +++++++++--
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  6 ++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 39 +++++++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  8 ++--
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  8 +++-
 5 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index b56fbdc959de..70147901b90b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -201,12 +201,18 @@ static bool wx_ring_tx_pending(struct wx *wx)
 {
 	int i;
 
+	rcu_read_lock();
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		struct wx_ring *tx_ring = wx->tx_ring[i];
+		struct wx_ring *tx_ring = READ_ONCE(wx->tx_ring[i]);
 
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
@@ -264,8 +270,16 @@ static void wx_detect_tx_hang(struct wx *wx)
 
 	/* Force detection of hung controller */
 	if (netif_carrier_ok(wx->netdev)) {
-		for (i = 0; i < wx->num_tx_queues; i++)
-			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);
+		rcu_read_lock();
+		for (i = 0; i < wx->num_tx_queues; i++) {
+			struct wx_ring *tx_ring = READ_ONCE(wx->tx_ring[i]);
+
+			if (!tx_ring)
+				continue;
+
+			set_bit(WX_TX_DETECT_HANG, tx_ring->state);
+		}
+		rcu_read_unlock();
 	}
 }
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 940d2e59876c..c0fb5639e370 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -154,8 +154,9 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		}
 	}
 
+	rcu_read_lock();
 	for (j = 0; j < netdev->num_tx_queues; j++) {
-		ring = wx->tx_ring[j];
+		ring = READ_ONCE(wx->tx_ring[j]);
 		if (!ring) {
 			data[i++] = 0;
 			data[i++] = 0;
@@ -170,7 +171,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		i += 2;
 	}
 	for (j = 0; j < WX_NUM_RX_QUEUES; j++) {
-		ring = wx->rx_ring[j];
+		ring = READ_ONCE(wx->rx_ring[j]);
 		if (!ring) {
 			data[i++] = 0;
 			data[i++] = 0;
@@ -184,6 +185,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(wx_get_ethtool_stats);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 122c4952d203..9e2cf794f81c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1598,13 +1598,18 @@ static void wx_vlan_strip_control(struct wx *wx, bool enable)
 {
 	int i, j;
 
+	rcu_read_lock();
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *ring = wx->rx_ring[i];
+		struct wx_ring *ring = READ_ONCE(wx->rx_ring[i]);
+
+		if (!ring)
+			continue;
 
 		j = ring->reg_idx;
 		wr32m(wx, WX_PX_RR_CFG(j), WX_PX_RR_CFG_VLAN,
 		      enable ? WX_PX_RR_CFG_VLAN : 0);
 	}
+	rcu_read_unlock();
 }
 
 static void wx_vlan_promisc_enable(struct wx *wx)
@@ -2870,8 +2875,16 @@ static void wx_update_xoff_rx_lfc(struct wx *wx)
 	if (!data)
 		return;
 
-	for (i = 0; i < wx->num_tx_queues; i++)
-		clear_bit(WX_HANG_CHECK_ARMED, wx->tx_ring[i]->state);
+	rcu_read_lock();
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = READ_ONCE(wx->tx_ring[i]);
+
+		if (!tx_ring)
+			continue;
+
+		clear_bit(WX_HANG_CHECK_ARMED, tx_ring->state);
+	}
+	rcu_read_unlock();
 }
 
 /**
@@ -2893,10 +2906,13 @@ void wx_update_stats(struct wx *wx)
 
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
@@ -2912,19 +2928,28 @@ void wx_update_stats(struct wx *wx)
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
 	}
+	rcu_read_unlock();
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ed5aad7857bd..c227e9ab8a4a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2191,7 +2191,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = txr_idx;
 
 		/* assign ring to wx */
-		wx->tx_ring[txr_idx] = ring;
+		WRITE_ONCE(wx->tx_ring[txr_idx], ring);
 
 		/* update count and index */
 		txr_count--;
@@ -2217,7 +2217,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = rxr_idx;
 
 		/* assign ring to wx */
-		wx->rx_ring[rxr_idx] = ring;
+		WRITE_ONCE(wx->rx_ring[rxr_idx], ring);
 
 		/* update count and index */
 		rxr_count--;
@@ -2245,10 +2245,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
 	struct wx_ring *ring;
 
 	wx_for_each_ring(ring, q_vector->tx)
-		wx->tx_ring[ring->queue_index] = NULL;
+		WRITE_ONCE(wx->tx_ring[ring->queue_index], NULL);
 
 	wx_for_each_ring(ring, q_vector->rx)
-		wx->rx_ring[ring->queue_index] = NULL;
+		WRITE_ONCE(wx->rx_ring[ring->queue_index], NULL);
 
 	wx->q_vector[v_idx] = NULL;
 	netif_napi_del(&q_vector->napi);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 4708e7f3958f..01071386409a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -257,7 +257,6 @@ static void wx_ptp_overflow_check(struct wx *wx)
  */
 static void wx_ptp_rx_hang(struct wx *wx)
 {
-	struct wx_ring *rx_ring;
 	unsigned long rx_event;
 	u32 tsyncrxctl;
 	int n;
@@ -274,11 +273,16 @@ static void wx_ptp_rx_hang(struct wx *wx)
 
 	/* determine the most recent watchdog or rx_timestamp event */
 	rx_event = wx->last_rx_ptp_check;
+	rcu_read_lock();
 	for (n = 0; n < wx->num_rx_queues; n++) {
-		rx_ring = wx->rx_ring[n];
+		struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[n]);
+
+		if (!rx_ring)
+			continue;
 		if (time_after(rx_ring->last_rx_timestamp, rx_event))
 			rx_event = rx_ring->last_rx_timestamp;
 	}
+	rcu_read_unlock();
 
 	/* only need to read the high RXSTMP register to clear the lock */
 	if (time_is_before_jiffies(rx_event + 5 * HZ)) {
-- 
2.53.0

