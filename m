Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C71A5BAE
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455377; cv=none; b=cvXi6VJt3XVwvvtFjyET8IbR5NtGirRlZWqLiEhs7sr2OvPpFc2Tq07YcSchLuFTjwvg+2dQAr98TWkBJPG2F+7bJv9P5wBKyTMBvk7+WuFP1n8P9FNbix6mOS3OuPTnYoGhtrrS198ZJUvo5mc3tZDcuCx4ryWI0rzudUkagXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455377; c=relaxed/simple;
	bh=4oNRG/3/xlCDrZh1r349EXj7/LLk+mKdMMx/Zf4qsQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPoKBbjUHw7Ow8+aajsnodyy6d9O0oExpEBRMO+PmEvloO93ZkCqTeqIKXKAwJtVCJOEjWt4W8lO6Cb1wYedTJadFJgwHoMkGWhVr8ZcMSMxA2OVDP2XzKZOw+RdWegi+uPAUpQMGyRDvePQ8qNyqQVSo2ue8PRMo1R/eqO8fAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz5t1789455293tc6a5c6d7
X-QQ-Originating-IP: nFrFQVjY3xtgydLGZB0Ab/zUiFj+SO/HglpdZpanceo=
Received: from localhost.localdomain ( [122.233.172.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Sep 2026 14:54:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14826260696312970751
EX-QQ-RecipientCnt: 12
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
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net v5] net: Wangxun: protect ring accesses with RCU
Date: Tue, 15 Sep 2026 14:54:47 +0800
Message-Id: <20260915065447.4450-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MOpOMm42OY9Cm48SqYWGgZ7gL9fkgfYwcbbKVCuXEZNtIfyqtVdhAbTA
	Jmn0Xwu/rUC1Ivyu1vNg70Y9mzBD64uZkGHHa16qce0WzeUSYKruPvAOFYv1g0AJPEUQ/3a
	xcq048PKEFqR9T5Kyw65VQfF5xCQCFCuX/y5Sg/LA9hHWSiM4l2/wLRPw7HdAcobWX8BdyT
	dno9bK1HwUBm6aftKDAeDYizcR86XjA4l/3IYppXSPi5Y0HbHXcuMEi50uGaMCRTsQy+Tev
	wIgid0182Nzd+1/FxhqrrOEThifDPfbx0S+wAdS1KwIn5RlXxWrcC7oXcdGR/I3jZaaPq0I
	MKc5ZfMyPGmpqsnuuQePqHdjnnnIg8slsDK9VwIE9klNQVvVZgKT0JGeNe9S8ukLg8aEx7h
	IYJi3wlOrpoNWTXMEcPs3Typ3DsbJl398rvJfPvhDvvXowmrFuVGK+SryoCbEkMJiHUUm/G
	foh3ktpZmaNWyIQxcAgfHdAzLhKUBTJi6mezPvbYquj+vo7A7smtmkeYnipBw2Bzu44sNGI
	ArmQJFKhuTO4H8AuV6DCdFQO5pG2OIqlyEsjwASlErArACkNcDjWz0NEU3sUR2OUvCu2zbv
	Nl750WxHGPOcBW8HkTH02+b4RsYxLCXFV3t+BAnIfpMgnj6s2Yt8qa73zk+AGj/Cqne7Eeh
	Z7MPJ3E43DVHI8LkNNeA0M/UplTkdrjp3pjTFjArw2iydofSoukBzpbN1ruI318mXO2E2zH
	RubEk74HJav+XcDVIP+aQ2j5O9kQlXpQwpTA7Be1oA1lDpgxT6D90jyKvt7K78TR7yKqpvl
	tyodh135Wo3cMKNMjceANRCTm9KnGITH5la7ZyamlEkiengC14uVBorwwodKTWgt0BMkVXx
	avOKADgWpceW/VFBj1Y+W7hUDZFI8Hj8WXgAy0MWVlDwOF11x7UQlofTtdaZiS9M1qHpDzc
	QrgqpEmVA3VdSac7a3mkNhrG6cBJDPt02lIPVPsysHdOjaD86hx8E59vT5Cwr+C3hgJsUiu
	AYiS+oniqaZoapkll5ULRkcUTxD1Ho7YVDhKuU2CuBkfGnxteoBU2xycGOxweNqxttkKop5
	h6jUn/4QZ/TYJ6H1Wz9LQsEK/TcLEvJXo49HYuFnSZ5smQh2sguKlc=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

In the Wangxun driver family, ring pointers in wx->rx_ring[] and
wx->tx_ring[] can be published, cleared, or replaced during interrupt
scheme teardown, channel reconfiguration (e.g. via ethtool -L), or
TC setup.

Currently, various lockless readers (such as stats gathering, PTP
watchdogs, and flow control checks) access per-queue ring structures
without formal RCU annotations, relying instead on non-atomic state bit
checks. Although q_vector memory lifetime is managed via kfree_rcu(),
the ring array accesses themselves lack explicit RCU dereference
semantics and barriers.

To harmonize lockless accesses and harden concurrency safety during
dynamic driver reconfigurations, convert the ring pointer management
to use standard RCU primitives:

1. Annotate tx_ring[] and rx_ring[] arrays in 'struct wx' with __rcu.
2. Enclose lockless reader paths inside RCU read-side critical sections
   (rcu_read_lock/unlock) and access ring pointers via rcu_dereference()
   with NULL guards.
3. Use rcu_assign_pointer() when publishing or clearing ring slots
   during queue vector allocation and teardown.
4. Use rcu_dereference_protected() in control paths guarded by locks
   (e.g., RTNL or reset_lock).

Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v6:
- Add Fixes tag.
- Use rcu_dereference_bh in wx_xmit_frame.
- Use lockdep_is_held(&wx->reset_lock) or lockdep_rtnl_is_held() in
  rcu_dereference_protected().
v5: https://lore.kernel.org/netdev/20260909090005.79368-1-mengyuanlou@net-swift.com/
- Switched to rcu_dereference()/rcu_assign_pointer().
- Since the code involved is extensive, rewrite the patch description to
  suit `net-next` rather than a bug fix, and remove the `Fixes` tag.
- Solve warnings from Sparse with rcu_dereference_protected().
v4: https://lore.kernel.org/netdev/4353E83B1147D652+20260830070624.7410-1-mengyuanlou@net-swift.com/
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 20 +++-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 14 ++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 78 +++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 94 +++++++++++++------
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  6 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  5 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  8 +-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  9 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  8 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  9 +-
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  2 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 11 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   |  3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  9 +-
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  2 +
 15 files changed, 209 insertions(+), 69 deletions(-)

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
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 940d2e59876c..414523fe83cb 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -154,8 +154,9 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		}
 	}
 
+	rcu_read_lock();
 	for (j = 0; j < netdev->num_tx_queues; j++) {
-		ring = wx->tx_ring[j];
+		ring = rcu_dereference(wx->tx_ring[j]);
 		if (!ring) {
 			data[i++] = 0;
 			data[i++] = 0;
@@ -170,7 +171,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		i += 2;
 	}
 	for (j = 0; j < WX_NUM_RX_QUEUES; j++) {
-		ring = wx->rx_ring[j];
+		ring = rcu_dereference(wx->rx_ring[j]);
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
 
@@ -805,9 +807,13 @@ static int wx_set_ringparam_vf(struct net_device *netdev,
 
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
-			wx->tx_ring[i]->count = new_tx_count;
+			rcu_dereference_protected(wx->tx_ring[i],
+						  lockdep_is_held(&wx->reset_lock))->count =
+				new_tx_count;
 		for (i = 0; i < wx->num_rx_queues; i++)
-			wx->rx_ring[i]->count = new_rx_count;
+			rcu_dereference_protected(wx->rx_ring[i],
+						  lockdep_is_held(&wx->reset_lock))->count =
+				new_rx_count;
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 122c4952d203..07e50cdb0b04 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1598,13 +1598,17 @@ static void wx_vlan_strip_control(struct wx *wx, bool enable)
 {
 	int i, j;
 
+	rcu_read_lock();
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *ring = wx->rx_ring[i];
+		struct wx_ring *ring = rcu_dereference(wx->rx_ring[i]);
 
+		if (!ring)
+			continue;
 		j = ring->reg_idx;
 		wr32m(wx, WX_PX_RR_CFG(j), WX_PX_RR_CFG_VLAN,
 		      enable ? WX_PX_RR_CFG_VLAN : 0);
 	}
+	rcu_read_unlock();
 }
 
 static void wx_vlan_promisc_enable(struct wx *wx)
@@ -1797,7 +1801,8 @@ static void wx_set_rx_buffer_len(struct wx *wx)
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		rx_ring = wx->rx_ring[i];
+		rx_ring = rcu_dereference_protected(wx->rx_ring[i],
+						    lockdep_rtnl_is_held());
 		rx_ring->rx_buf_len = WX_RXBUFFER_2K;
 #if (PAGE_SIZE < 8192)
 		if (test_bit(WX_FLAG_RSC_ENABLED, wx->flags))
@@ -2021,8 +2026,13 @@ static void wx_configure_tx(struct wx *wx)
 	      WX_TDM_CTL_TE, WX_TDM_CTL_TE);
 
 	/* Setup the HW Tx Head and Tail descriptor pointers */
-	for (i = 0; i < wx->num_tx_queues; i++)
-		wx_configure_tx_ring(wx, wx->tx_ring[i]);
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring =
+			rcu_dereference_protected(wx->tx_ring[i],
+						  lockdep_rtnl_is_held());
+
+		wx_configure_tx_ring(wx, tx_ring);
+	}
 
 	wr32m(wx, WX_TSC_BUF_AE, WX_TSC_BUF_AE_THR, 0x10);
 
@@ -2247,8 +2257,13 @@ void wx_configure_rx(struct wx *wx)
 	/* Setup the HW Rx Head and Tail Descriptor Pointers and
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
-	for (i = 0; i < wx->num_rx_queues; i++)
-		wx_configure_rx_ring(wx, wx->rx_ring[i]);
+	for (i = 0; i < wx->num_rx_queues; i++) {
+		struct wx_ring *rx_ring =
+			rcu_dereference_protected(wx->rx_ring[i],
+						  lockdep_rtnl_is_held());
+
+		wx_configure_rx_ring(wx, rx_ring);
+	}
 
 	/* Enable all receives, disable security engine prior to block traffic */
 	ret = wx_disable_sec_rx_path(wx);
@@ -2837,13 +2852,25 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
 	 *  This allows us to avoid head of line blocking for security
 	 *  and performance reasons.
 	 */
+	rcu_read_lock();
 	if (wx->num_rx_queues > 1 && !tx_pause) {
-		for (i = 0; i < wx->num_rx_queues; i++)
-			wx_enable_rx_drop(wx, wx->rx_ring[i]);
+		for (i = 0; i < wx->num_rx_queues; i++) {
+			struct wx_ring *rx_ring = rcu_dereference(wx->rx_ring[i]);
+
+			if (!rx_ring)
+				continue;
+			wx_enable_rx_drop(wx, rx_ring);
+		}
 	} else {
-		for (i = 0; i < wx->num_rx_queues; i++)
-			wx_disable_rx_drop(wx, wx->rx_ring[i]);
+		for (i = 0; i < wx->num_rx_queues; i++) {
+			struct wx_ring *rx_ring = rcu_dereference(wx->rx_ring[i]);
+
+			if (!rx_ring)
+				continue;
+			wx_disable_rx_drop(wx, rx_ring);
+		}
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -2870,8 +2897,15 @@ static void wx_update_xoff_rx_lfc(struct wx *wx)
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
@@ -2893,10 +2927,13 @@ void wx_update_stats(struct wx *wx)
 
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
@@ -2912,19 +2949,28 @@ void wx_update_stats(struct wx *wx)
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
index ed5aad7857bd..bbd670504b27 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1700,6 +1700,7 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
 	unsigned int r_idx = skb->queue_mapping;
 	struct wx *wx = netdev_priv(netdev);
 	struct wx_ring *tx_ring;
+	u16 num_tx_queues;
 
 	if (!netif_carrier_ok(netdev)) {
 		dev_kfree_skb_any(skb);
@@ -1712,9 +1713,18 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
 	if (skb_put_padto(skb, 17))
 		return NETDEV_TX_OK;
 
-	if (r_idx >= wx->num_tx_queues)
-		r_idx = r_idx % wx->num_tx_queues;
-	tx_ring = wx->tx_ring[r_idx];
+	num_tx_queues = READ_ONCE(wx->num_tx_queues);
+	if (unlikely(!num_tx_queues)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	if (r_idx >= num_tx_queues)
+		r_idx = r_idx % num_tx_queues;
+	tx_ring = rcu_dereference_bh(wx->tx_ring[r_idx]);
+	if (unlikely(!tx_ring)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
 
 	return wx_xmit_frame_ring(skb, tx_ring);
 }
@@ -2058,26 +2068,30 @@ static bool wx_cache_ring_vmdq(struct wx *wx)
 			/* If we are greater than indices move to next pool */
 			if ((reg_idx & ~vmdq->mask) >= rss->indices)
 				reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
-			wx->rx_ring[i]->reg_idx = reg_idx;
+			rcu_dereference_protected(wx->rx_ring[i],
+						  lockdep_rtnl_is_held())->reg_idx = reg_idx;
 		}
 		reg_idx = vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
 		for (i = 0; i < wx->num_tx_queues; i++, reg_idx++) {
 			/* If we are greater than indices move to next pool */
 			if ((reg_idx & rss->mask) >= rss->indices)
 				reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
-			wx->tx_ring[i]->reg_idx = reg_idx;
+			rcu_dereference_protected(wx->tx_ring[i],
+						  lockdep_rtnl_is_held())->reg_idx = reg_idx;
 		}
 	} else {
 		/* start at VMDq register offset for SR-IOV enabled setups */
 		reg_idx = vmdq->offset;
 		for (i = 0; i < wx->num_rx_queues; i++)
 			/* If we are greater than indices move to next pool */
-			wx->rx_ring[i]->reg_idx = reg_idx + i;
+			rcu_dereference_protected(wx->rx_ring[i],
+						  lockdep_rtnl_is_held())->reg_idx = reg_idx + i;
 
 		reg_idx = vmdq->offset;
 		for (i = 0; i < wx->num_tx_queues; i++)
 			/* If we are greater than indices move to next pool */
-			wx->tx_ring[i]->reg_idx = reg_idx + i;
+			rcu_dereference_protected(wx->tx_ring[i],
+						  lockdep_rtnl_is_held())->reg_idx = reg_idx + i;
 	}
 
 	return true;
@@ -2098,10 +2112,12 @@ static void wx_cache_ring_rss(struct wx *wx)
 		return;
 
 	for (i = 0; i < wx->num_rx_queues; i++)
-		wx->rx_ring[i]->reg_idx = i;
+		rcu_dereference_protected(wx->rx_ring[i],
+					  lockdep_rtnl_is_held())->reg_idx = i;
 
 	for (i = 0; i < wx->num_tx_queues; i++)
-		wx->tx_ring[i]->reg_idx = i;
+		rcu_dereference_protected(wx->tx_ring[i],
+					  lockdep_rtnl_is_held())->reg_idx = i;
 }
 
 static void wx_add_ring(struct wx_ring *ring, struct wx_ring_container *head)
@@ -2191,7 +2207,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = txr_idx;
 
 		/* assign ring to wx */
-		wx->tx_ring[txr_idx] = ring;
+		rcu_assign_pointer(wx->tx_ring[txr_idx], ring);
 
 		/* update count and index */
 		txr_count--;
@@ -2217,7 +2233,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = rxr_idx;
 
 		/* assign ring to wx */
-		wx->rx_ring[rxr_idx] = ring;
+		rcu_assign_pointer(wx->rx_ring[rxr_idx], ring);
 
 		/* update count and index */
 		rxr_count--;
@@ -2245,10 +2261,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
 	struct wx_ring *ring;
 
 	wx_for_each_ring(ring, q_vector->tx)
-		wx->tx_ring[ring->queue_index] = NULL;
+		rcu_assign_pointer(wx->tx_ring[ring->queue_index], NULL);
 
 	wx_for_each_ring(ring, q_vector->rx)
-		wx->rx_ring[ring->queue_index] = NULL;
+		rcu_assign_pointer(wx->rx_ring[ring->queue_index], NULL);
 
 	wx->q_vector[v_idx] = NULL;
 	netif_napi_del(&q_vector->napi);
@@ -2659,7 +2675,8 @@ void wx_clean_all_rx_rings(struct wx *wx)
 	int i;
 
 	for (i = 0; i < wx->num_rx_queues; i++)
-		wx_clean_rx_ring(wx->rx_ring[i]);
+		wx_clean_rx_ring(rcu_dereference_protected(wx->rx_ring[i],
+							   lockdep_rtnl_is_held()));
 }
 EXPORT_SYMBOL(wx_clean_all_rx_rings);
 
@@ -2701,7 +2718,8 @@ static void wx_free_all_rx_resources(struct wx *wx)
 	int i;
 
 	for (i = 0; i < wx->num_rx_queues; i++)
-		wx_free_rx_resources(wx->rx_ring[i]);
+		wx_free_rx_resources(rcu_dereference_protected(wx->rx_ring[i],
+							       lockdep_rtnl_is_held()));
 }
 
 /**
@@ -2775,7 +2793,8 @@ void wx_clean_all_tx_rings(struct wx *wx)
 	int i;
 
 	for (i = 0; i < wx->num_tx_queues; i++)
-		wx_clean_tx_ring(wx->tx_ring[i]);
+		wx_clean_tx_ring(rcu_dereference_protected(wx->tx_ring[i],
+							   lockdep_rtnl_is_held()));
 }
 EXPORT_SYMBOL(wx_clean_all_tx_rings);
 
@@ -2823,7 +2842,8 @@ static void wx_free_all_tx_resources(struct wx *wx)
 	int i;
 
 	for (i = 0; i < wx->num_tx_queues; i++)
-		wx_free_tx_resources(wx->tx_ring[i]);
+		wx_free_tx_resources(rcu_dereference_protected(wx->tx_ring[i],
+							       lockdep_rtnl_is_held()));
 }
 
 void wx_free_resources(struct wx *wx)
@@ -2933,7 +2953,8 @@ static int wx_setup_all_rx_resources(struct wx *wx)
 	int i, err = 0;
 
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		err = wx_setup_rx_resources(wx->rx_ring[i]);
+		err = wx_setup_rx_resources(rcu_dereference_protected(wx->rx_ring[i],
+								      lockdep_rtnl_is_held()));
 		if (!err)
 			continue;
 
@@ -2945,7 +2966,8 @@ static int wx_setup_all_rx_resources(struct wx *wx)
 err_setup_rx:
 	/* rewind the index freeing the rings as we go */
 	while (i--)
-		wx_free_rx_resources(wx->rx_ring[i]);
+		wx_free_rx_resources(rcu_dereference_protected(wx->rx_ring[i],
+							       lockdep_rtnl_is_held()));
 	return err;
 }
 
@@ -3036,7 +3058,8 @@ static int wx_setup_all_tx_resources(struct wx *wx)
 	int i, err = 0;
 
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		err = wx_setup_tx_resources(wx->tx_ring[i]);
+		err = wx_setup_tx_resources(rcu_dereference_protected(wx->tx_ring[i],
+								      lockdep_rtnl_is_held()));
 		if (!err)
 			continue;
 
@@ -3048,7 +3071,8 @@ static int wx_setup_all_tx_resources(struct wx *wx)
 err_setup_tx:
 	/* rewind the index freeing the rings as we go */
 	while (i--)
-		wx_free_tx_resources(wx->tx_ring[i]);
+		wx_free_tx_resources(rcu_dereference_protected(wx->tx_ring[i],
+							       lockdep_rtnl_is_held()));
 	return err;
 }
 
@@ -3097,7 +3121,7 @@ void wx_get_stats64(struct net_device *netdev,
 
 	rcu_read_lock();
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *ring = READ_ONCE(wx->rx_ring[i]);
+		struct wx_ring *ring = rcu_dereference(wx->rx_ring[i]);
 		u64 bytes, packets;
 		unsigned int start;
 
@@ -3113,7 +3137,7 @@ void wx_get_stats64(struct net_device *netdev,
 	}
 
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		struct wx_ring *ring = READ_ONCE(wx->tx_ring[i]);
+		struct wx_ring *ring = rcu_dereference(wx->tx_ring[i]);
 		u64 bytes, packets;
 		unsigned int start;
 
@@ -3324,7 +3348,9 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 	 */
 	if (new_tx_count != wx->tx_ring_count) {
 		for (i = 0; i < wx->num_tx_queues; i++) {
-			memcpy(&temp_ring[i], wx->tx_ring[i],
+			memcpy(&temp_ring[i],
+			       rcu_dereference_protected(wx->tx_ring[i],
+							 lockdep_rtnl_is_held()),
 			       sizeof(struct wx_ring));
 
 			temp_ring[i].count = new_tx_count;
@@ -3340,9 +3366,13 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 		}
 
 		for (i = 0; i < wx->num_tx_queues; i++) {
-			wx_free_tx_resources(wx->tx_ring[i]);
+			struct wx_ring *tx_ring =
+				rcu_dereference_protected(wx->tx_ring[i],
+							  lockdep_rtnl_is_held());
 
-			memcpy(wx->tx_ring[i], &temp_ring[i],
+			wx_free_tx_resources(tx_ring);
+
+			memcpy(tx_ring, &temp_ring[i],
 			       sizeof(struct wx_ring));
 		}
 
@@ -3352,7 +3382,9 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 	/* Repeat the process for the Rx rings if needed */
 	if (new_rx_count != wx->rx_ring_count) {
 		for (i = 0; i < wx->num_rx_queues; i++) {
-			memcpy(&temp_ring[i], wx->rx_ring[i],
+			memcpy(&temp_ring[i],
+			       rcu_dereference_protected(wx->rx_ring[i],
+							 lockdep_rtnl_is_held()),
 			       sizeof(struct wx_ring));
 
 			temp_ring[i].count = new_rx_count;
@@ -3368,8 +3400,12 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 		}
 
 		for (i = 0; i < wx->num_rx_queues; i++) {
-			wx_free_rx_resources(wx->rx_ring[i]);
-			memcpy(wx->rx_ring[i], &temp_ring[i],
+			struct wx_ring *rx_ring =
+				rcu_dereference_protected(wx->rx_ring[i],
+							  lockdep_rtnl_is_held());
+
+			wx_free_rx_resources(rx_ring);
+			memcpy(rx_ring, &temp_ring[i],
 			       sizeof(struct wx_ring));
 		}
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 4708e7f3958f..68dc62977aab 100644
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
index 9454e90258d8..9d06003259db 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -6,6 +6,7 @@
 
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
+#include <linux/rtnetlink.h>
 #include <linux/bitfield.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
@@ -1359,8 +1360,8 @@ struct wx {
 	u32 tx_ring_count;
 	u32 rx_ring_count;
 
-	struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
-	struct wx_ring *rx_ring[64];
+	struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
+	struct wx_ring __rcu *rx_ring[64];
 	struct wx_q_vector *q_vector[64];
 	int num_rx_pools;
 	int num_rx_queues_per_pool;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..93a4d7632ea8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -17,7 +17,9 @@ int wxvf_suspend(struct device *dev_d)
 	struct wx *wx = pci_get_drvdata(pdev);
 
 	netif_device_detach(wx->netdev);
+	rtnl_lock();
 	wx_clear_interrupt_scheme(wx);
+	rtnl_unlock();
 	pci_disable_device(pdev);
 
 	return 0;
@@ -36,8 +38,10 @@ int wxvf_resume(struct device *dev_d)
 	struct wx *wx = pci_get_drvdata(pdev);
 
 	pci_set_master(pdev);
+	rtnl_lock();
 	wx_init_interrupt_scheme(wx);
 	netif_device_attach(wx->netdev);
+	rtnl_unlock();
 
 	return 0;
 }
@@ -205,7 +209,9 @@ static void wx_configure_rx_vf(struct wx *wx)
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *rx_ring = wx->rx_ring[i];
+		struct wx_ring *rx_ring =
+			rcu_dereference_protected(wx->rx_ring[i],
+						  lockdep_rtnl_is_held());
 #ifdef HAVE_SWIOTLB_SKIP_CPU_SYNC
 		wx_set_rx_buffer_len_vf(wx, rx_ring);
 #endif
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index 7325b475ee10..d3bb9b4f22a3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -175,8 +175,13 @@ void wx_configure_tx_vf(struct wx *wx)
 	u32 i;
 
 	/* Setup the HW Tx Head and Tail descriptor pointers */
-	for (i = 0; i < wx->num_tx_queues; i++)
-		wx_configure_tx_ring_vf(wx, wx->tx_ring[i]);
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring =
+			rcu_dereference_protected(wx->tx_ring[i],
+						  lockdep_rtnl_is_held());
+
+		wx_configure_tx_ring_vf(wx, tx_ring);
+	}
 }
 
 static void wx_configure_srrctl_vf(struct wx *wx, struct wx_ring *ring,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 1960f7154151..09a9727b6437 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -37,9 +37,13 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
-			wx->tx_ring[i]->count = new_tx_count;
+			rcu_dereference_protected(wx->tx_ring[i],
+						  lockdep_is_held(&wx->reset_lock))->count =
+				new_tx_count;
 		for (i = 0; i < wx->num_rx_queues; i++)
-			wx->rx_ring[i]->count = new_rx_count;
+			rcu_dereference_protected(wx->rx_ring[i],
+						  lockdep_is_held(&wx->reset_lock))->count =
+				new_rx_count;
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 855dc963c610..c670f4eb2759 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -406,7 +406,9 @@ static void ngbe_disable_device(struct wx *wx)
 	/* disable all enabled rx queues */
 	for (i = 0; i < wx->num_rx_queues; i++)
 		/* this call also flushes the previous write */
-		wx_disable_rx_queue(wx, wx->rx_ring[i]);
+		wx_disable_rx_queue(wx,
+				    rcu_dereference_protected(wx->rx_ring[i],
+							      lockdep_rtnl_is_held()));
 	/* disable receives */
 	wx_disable_rx(wx);
 	wx_napi_disable_all(wx);
@@ -422,7 +424,8 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_irq_disable(wx);
 	/* disable transmits in the hardware now that interrupts are off */
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		u8 reg_idx = wx->tx_ring[i]->reg_idx;
+		u8 reg_idx = rcu_dereference_protected(wx->tx_ring[i],
+						       lockdep_rtnl_is_held())->reg_idx;
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
@@ -866,7 +869,9 @@ static int ngbe_probe(struct pci_dev *pdev,
 
 	ngbe_init_service(wx);
 
+	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
+	rtnl_unlock();
 	if (err)
 		goto err_cancel_service;
 
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index d79cf8d8484f..aac88c77d3b8 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -202,7 +202,9 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
 	wxvf_init_service(wx);
+	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
+	rtnl_unlock();
 	if (err)
 		goto err_free_sw_init;
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 3e32aca72806..6523d0e7e237 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -61,9 +61,13 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
-			wx->tx_ring[i]->count = new_tx_count;
+			rcu_dereference_protected(wx->tx_ring[i],
+						  lockdep_is_held(&wx->reset_lock))->count =
+				new_tx_count;
 		for (i = 0; i < wx->num_rx_queues; i++)
-			wx->rx_ring[i]->count = new_rx_count;
+			rcu_dereference_protected(wx->rx_ring[i],
+						  lockdep_is_held(&wx->reset_lock))->count =
+				new_rx_count;
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
@@ -366,7 +370,8 @@ static int txgbe_add_ethtool_fdir_entry(struct txgbe *txgbe,
 
 		/* Map the ring onto the absolute queue index */
 		if (!vf)
-			queue = wx->rx_ring[ring]->reg_idx;
+			queue = rcu_dereference_protected(wx->rx_ring[ring],
+							  lockdep_rtnl_is_held())->reg_idx;
 		else
 			queue = ((vf - 1) * wx->num_rx_queues_per_pool) + ring;
 	}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
index a84010828551..9fa1006f2f60 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
@@ -599,7 +599,8 @@ static void txgbe_fdir_filter_restore(struct wx *wx)
 			}
 
 			/* Map the ring onto the absolute queue index */
-			queue = wx->rx_ring[ring]->reg_idx;
+			queue = rcu_dereference_protected(wx->rx_ring[ring],
+							  lockdep_rtnl_is_held())->reg_idx;
 		}
 
 		ret = txgbe_fdir_write_perfect_filter(wx,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index eb91c4f28ecd..3d2f99e272ad 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -239,7 +239,9 @@ static void txgbe_disable_device(struct wx *wx)
 	/* disable all enabled rx queues */
 	for (i = 0; i < wx->num_rx_queues; i++)
 		/* this call also flushes the previous write */
-		wx_disable_rx_queue(wx, wx->rx_ring[i]);
+		wx_disable_rx_queue(wx,
+				    rcu_dereference_protected(wx->rx_ring[i],
+							      lockdep_rtnl_is_held()));
 
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
@@ -275,7 +277,8 @@ static void txgbe_disable_device(struct wx *wx)
 
 	/* disable transmits in the hardware now that interrupts are off */
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		u8 reg_idx = wx->tx_ring[i]->reg_idx;
+		u8 reg_idx = rcu_dereference_protected(wx->tx_ring[i],
+			lockdep_rtnl_is_held())->reg_idx;
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
@@ -865,7 +868,9 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	txgbe_init_service(wx);
 
+	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
+	rtnl_unlock();
 	if (err)
 		goto err_cancel_service;
 
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 8b16b900820a..a4a829c65336 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -267,7 +267,9 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
 	wxvf_init_service(wx);
+	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
+	rtnl_unlock();
 	if (err)
 		goto err_free_sw_init;
 
-- 
2.30.1

