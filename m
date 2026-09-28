Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA346E011
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585761; cv=none; b=PiskznQGc0LNhJOOzWVQ/aMEnnUdQnfj+l8qsaQ2YjjeXKykWBEl2iwPXtDrW7gCXiE/S8Oz3PTkKYLGWqtVTf7BxIAjjTR3+YiTGZ6DWQ/4Rthn4jNqVCwmINs/lyqkBntzm8vJM6jeq7U9R29Wo4sP08642pvyYoJGrDebOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585761; c=relaxed/simple;
	bh=Leg2Pu2GmeIyENw32tVQlBQLiRnddQskegzECBgKeM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d7lF0GnRwOe/4vKZeiL3zRsm4dH/3/hpD7QkJ7p5SGMwVSg5wDbtCbeax4rrER9YeP2fh10NkjxgWZORVDjbS6V8XB8WaySW34vvRf1AfgWbrJBQNHgYqeIYGQWPyfVVbR0inMtFegGKxFZHewaoxahpqLDUGHBZOs7Pf6vJzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz4t1790585697te502f666
X-QQ-Originating-IP: EVmTYR2Jh8a4Ur5S8pDq6kEtySVVxwv9QZ31rbpM1ss=
Received: from localhost.localdomain ( [115.227.112.38])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 28 Sep 2026 16:54:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8988983472008587277
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
Subject: [PATCH net v7] net: wangxun: protect ring accesses with RCU
Date: Mon, 28 Sep 2026 16:54:43 +0800
Message-Id: <20260928085443.14595-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MCXpTX1kEWEBPf1/ZxNa0eeZ3jFYQosFPRLIZlF83rejfI8Vk8hcx4u/
	iKQLHspcNqO2hVcDMMqE3PsT3CoEG4P7g1yZ8cztpFSkGoWH6ZdKRnOVelApIWFougaVTv1
	SRy8IPuybKkfC/Ct8pAsDPJtnSi8wY9Pt4tFs4mBzIjekgTTOKt7wZoPXQn65HuVQSJjZ1j
	CAKZG1i8MRaRyGQdpfo37CsP62qJJHCywz/oYYtTo+VoaUsrHoUAPRpNWrM8I/TBFLZ7Ut1
	pgI7GcoJDxP7gbyVxV85bdA96n1R7bLXGWj2YCVWSvfwLD1AETMoT9n+Be7JzvpkqCSF5jh
	VUbYnYmNIPqPkY4KOgVM+8bLghqgxPU81HezQg8v7m0tQqGfPgdpiyQtIYIxQ1hjjVWF7fZ
	UPK78Z7hXXneAPdzMfVsvs6ipDTtNo/0t9KoQmxJH5kT9ZI2RpfjAGsEUaE1OKfoQVNX2kZ
	eDfk74rjcwUfrWo3LfVRZvx5j+TMlqhgIUfGoGtwfZ9WCi4Su3xEp8fdkWvYjWvHyISA05C
	bPJ0S0E4lgAWvAPw/q9wRSb3qzfHJTatlVs2wuC76fZO0lHzYCK6NVDjoPqlITMnrS7WG/P
	Bvds/jvOb25uUvXz+DCO3vzxYj/FPc1Udjgg3fkJFduwDeEk95e7dqhBL2lJcrplkwP7mLD
	7uW2+yyJvhTnwuxmCQlaSXqz0j0fjkS97zN0OJzmMV2rfKhTEzo0mmwZXGbXiBOYWjMfS9r
	hLwCOtZJnueFaUckv+siyApi3pRYHegLdJNHDarAZZhAQ79n/9TiJgBFr9Q+91vn5TrruEZ
	f8VVmaXj2uceDCkKTLCyJOnYuH/HU2HA5bmEZkhmfo+X1GqZAsWpm31Z4DUYAblauxovA8s
	3U3YS2/3YPis33PGy9rq3DVT5UHsefAW0QcMxBqxTjpC2yaPvVV8TuobD+xpDYAbgGpogd+
	HGMZbnRGOJYCagl3VdIrfilQANpUibgiFqJPtEAhMHWJDxCqcDTwVtO278fXv4WhLThTas8
	gSy70g0WOGI+i00PRoVSIhMNr+GbiWVP7r4TaNaxSVFB8rH/72v+J+NVZPmQZwPxwkE1+m6
	PP0oDCTuT2ZTqq6K2Q04/ePL+ikoautpBRgh/QUp5XNB/TeLRqkMKk7cjt1ls+muZe/IAhk
	kIdv1zYEZhveyYW9U0f1//a++Q==
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
4. Use rtnl_dereference() in control paths guarded by RTNL.

The ring arrays are managed by wx_alloc_q_vector() and
wx_free_q_vector(), reached through wx_init_interrupt_scheme() and
wx_clear_interrupt_scheme(). Control-path readers use
rtnl_dereference() while holding RTNL, while lockless readers use the
RCU primitives described above. wx_init_interrupt_scheme() is called
without RTNL from ngbe_probe(), txgbe_probe(), ngbevf_probe(),
txgbevf_probe() and wxvf_resume(), so those take RTNL around the call
now; in the probe paths the netdev is not registered yet, so RTNL only
satisfies the assertion there. wxvf_suspend() takes RTNL around
wx_clear_interrupt_scheme() as well, not for the ring arrays but to
serialize the teardown against the VF reset subtask, which rebuilds the
same interrupt scheme under RTNL. ngbe_dev_shutdown() moves its
rtnl_unlock() past the WoL setup as well, so that wx_set_rx_mode() and
wx_configure_rx() are called from inside the RTNL section.

wx_xmit_frame() additionally needs two behavioural changes that the
annotation alone does not give:

- wx_free_q_vectors() zeroes wx->num_tx_queues while the netdev stays
  registered with a non-zero real queue count, so a transmit racing with
  a reconfiguration could evaluate "r_idx % wx->num_tx_queues" with a
  zero divisor. Bail out early when the queue count is zero.

- The same window can leave the ring slot NULL, so the pointer is loaded
  with rcu_dereference_bh() and NULL-checked before use.

Transmits dropped on those paths, and on the pre-existing carrier-off
path, are now accounted in tx_dropped instead of disappearing silently.

Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v7:
- Address the review comments: use rtnl_dereference() for the ring
  accesses in the control paths guarded by RTNL instead of
  rcu_dereference_protected() with explicit lockdep conditions;
  this  also covers the three ethtool set_ringparam paths.
- Keep the WoL setup inside the RTNL section in ngbe_dev_shutdown(), as
  wx_configure_rx() dereferences the ring array with rtnl_dereference().
- Consolidate the drop path of wx_xmit_frame() into a common label and
  account the packets dropped there in tx_dropped.
- Add comments for the __rcu annotated ring arrays and for the RTNL
  sections taken in the probe, shutdown and VF suspend/resume paths.
- Drop the <linux/rtnetlink.h> include; rtnl_dereference() is already
  reachable through <linux/if_vlan.h>.
v6: https://lore.kernel.org/all/20260915065731.6007-1-mengyuanlou@net-swift.com/
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
v3: https://lore.kernel.org/netdev/20260824103606.303-1-mengyuanlou@net-swift.com/
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 20 ++++-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 10 ++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 73 +++++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 81 +++++++++++--------
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  6 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 10 ++-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 14 +++-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  7 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 17 +++-
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  7 ++
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  6 +-
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 11 ++-
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  7 ++
 15 files changed, 201 insertions(+), 74 deletions(-)

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
index 940d2e59876c..2307149b07fd 100644
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
 
@@ -805,9 +807,9 @@ static int wx_set_ringparam_vf(struct net_device *netdev,
 
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
-			wx->tx_ring[i]->count = new_tx_count;
+			rtnl_dereference(wx->tx_ring[i])->count = new_tx_count;
 		for (i = 0; i < wx->num_rx_queues; i++)
-			wx->rx_ring[i]->count = new_rx_count;
+			rtnl_dereference(wx->rx_ring[i])->count = new_rx_count;
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 113552586be7..92fb43f2ed52 100644
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
@@ -1797,7 +1801,7 @@ static void wx_set_rx_buffer_len(struct wx *wx)
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		rx_ring = wx->rx_ring[i];
+		rx_ring = rtnl_dereference(wx->rx_ring[i]);
 		rx_ring->rx_buf_len = WX_RXBUFFER_2K;
 #if (PAGE_SIZE < 8192)
 		if (test_bit(WX_FLAG_RSC_ENABLED, wx->flags))
@@ -2021,8 +2025,11 @@ static void wx_configure_tx(struct wx *wx)
 	      WX_TDM_CTL_TE, WX_TDM_CTL_TE);
 
 	/* Setup the HW Tx Head and Tail descriptor pointers */
-	for (i = 0; i < wx->num_tx_queues; i++)
-		wx_configure_tx_ring(wx, wx->tx_ring[i]);
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = rtnl_dereference(wx->tx_ring[i]);
+
+		wx_configure_tx_ring(wx, tx_ring);
+	}
 
 	wr32m(wx, WX_TSC_BUF_AE, WX_TSC_BUF_AE_THR, 0x10);
 
@@ -2247,8 +2254,11 @@ void wx_configure_rx(struct wx *wx)
 	/* Setup the HW Rx Head and Tail Descriptor Pointers and
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
-	for (i = 0; i < wx->num_rx_queues; i++)
-		wx_configure_rx_ring(wx, wx->rx_ring[i]);
+	for (i = 0; i < wx->num_rx_queues; i++) {
+		struct wx_ring *rx_ring = rtnl_dereference(wx->rx_ring[i]);
+
+		wx_configure_rx_ring(wx, rx_ring);
+	}
 
 	/* Enable all receives, disable security engine prior to block traffic */
 	ret = wx_disable_sec_rx_path(wx);
@@ -2838,13 +2848,25 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
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
@@ -2871,8 +2893,15 @@ static void wx_update_xoff_rx_lfc(struct wx *wx)
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
@@ -2894,10 +2923,13 @@ void wx_update_stats(struct wx *wx)
 
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
@@ -2913,19 +2945,28 @@ void wx_update_stats(struct wx *wx)
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
index dcbf5811046e..cd0e5382ab75 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1721,11 +1721,10 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
 	unsigned int r_idx = skb->queue_mapping;
 	struct wx *wx = netdev_priv(netdev);
 	struct wx_ring *tx_ring;
+	u16 num_tx_queues;
 
-	if (!netif_carrier_ok(netdev)) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
+	if (!netif_carrier_ok(netdev))
+		goto drop;
 
 	/* The minimum packet size for olinfo paylen is 17 so pad the skb
 	 * in order to meet this minimum size requirement.
@@ -1733,11 +1732,22 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
 	if (skb_put_padto(skb, 17))
 		return NETDEV_TX_OK;
 
-	if (r_idx >= wx->num_tx_queues)
-		r_idx = r_idx % wx->num_tx_queues;
-	tx_ring = wx->tx_ring[r_idx];
+	num_tx_queues = READ_ONCE(wx->num_tx_queues);
+	if (unlikely(!num_tx_queues))
+		goto drop;
+
+	if (r_idx >= num_tx_queues)
+		r_idx = r_idx % num_tx_queues;
+	tx_ring = rcu_dereference_bh(wx->tx_ring[r_idx]);
+	if (unlikely(!tx_ring))
+		goto drop;
 
 	return wx_xmit_frame_ring(skb, tx_ring);
+
+drop:
+	dev_core_stats_tx_dropped_inc(netdev);
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
 }
 EXPORT_SYMBOL(wx_xmit_frame);
 
@@ -2079,26 +2089,26 @@ static bool wx_cache_ring_vmdq(struct wx *wx)
 			/* If we are greater than indices move to next pool */
 			if ((reg_idx & ~vmdq->mask) >= rss->indices)
 				reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
-			wx->rx_ring[i]->reg_idx = reg_idx;
+			rtnl_dereference(wx->rx_ring[i])->reg_idx = reg_idx;
 		}
 		reg_idx = vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
 		for (i = 0; i < wx->num_tx_queues; i++, reg_idx++) {
 			/* If we are greater than indices move to next pool */
 			if ((reg_idx & rss->mask) >= rss->indices)
 				reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
-			wx->tx_ring[i]->reg_idx = reg_idx;
+			rtnl_dereference(wx->tx_ring[i])->reg_idx = reg_idx;
 		}
 	} else {
 		/* start at VMDq register offset for SR-IOV enabled setups */
 		reg_idx = vmdq->offset;
 		for (i = 0; i < wx->num_rx_queues; i++)
 			/* If we are greater than indices move to next pool */
-			wx->rx_ring[i]->reg_idx = reg_idx + i;
+			rtnl_dereference(wx->rx_ring[i])->reg_idx = reg_idx + i;
 
 		reg_idx = vmdq->offset;
 		for (i = 0; i < wx->num_tx_queues; i++)
 			/* If we are greater than indices move to next pool */
-			wx->tx_ring[i]->reg_idx = reg_idx + i;
+			rtnl_dereference(wx->tx_ring[i])->reg_idx = reg_idx + i;
 	}
 
 	return true;
@@ -2119,10 +2129,10 @@ static void wx_cache_ring_rss(struct wx *wx)
 		return;
 
 	for (i = 0; i < wx->num_rx_queues; i++)
-		wx->rx_ring[i]->reg_idx = i;
+		rtnl_dereference(wx->rx_ring[i])->reg_idx = i;
 
 	for (i = 0; i < wx->num_tx_queues; i++)
-		wx->tx_ring[i]->reg_idx = i;
+		rtnl_dereference(wx->tx_ring[i])->reg_idx = i;
 }
 
 static void wx_add_ring(struct wx_ring *ring, struct wx_ring_container *head)
@@ -2212,7 +2222,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = txr_idx;
 
 		/* assign ring to wx */
-		wx->tx_ring[txr_idx] = ring;
+		rcu_assign_pointer(wx->tx_ring[txr_idx], ring);
 
 		/* update count and index */
 		txr_count--;
@@ -2238,7 +2248,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = rxr_idx;
 
 		/* assign ring to wx */
-		wx->rx_ring[rxr_idx] = ring;
+		rcu_assign_pointer(wx->rx_ring[rxr_idx], ring);
 
 		/* update count and index */
 		rxr_count--;
@@ -2266,10 +2276,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
 	struct wx_ring *ring;
 
 	wx_for_each_ring(ring, q_vector->tx)
-		wx->tx_ring[ring->queue_index] = NULL;
+		rcu_assign_pointer(wx->tx_ring[ring->queue_index], NULL);
 
 	wx_for_each_ring(ring, q_vector->rx)
-		wx->rx_ring[ring->queue_index] = NULL;
+		rcu_assign_pointer(wx->rx_ring[ring->queue_index], NULL);
 
 	wx->q_vector[v_idx] = NULL;
 	netif_napi_del(&q_vector->napi);
@@ -2680,7 +2690,7 @@ void wx_clean_all_rx_rings(struct wx *wx)
 	int i;
 
 	for (i = 0; i < wx->num_rx_queues; i++)
-		wx_clean_rx_ring(wx->rx_ring[i]);
+		wx_clean_rx_ring(rtnl_dereference(wx->rx_ring[i]));
 }
 EXPORT_SYMBOL(wx_clean_all_rx_rings);
 
@@ -2722,7 +2732,7 @@ static void wx_free_all_rx_resources(struct wx *wx)
 	int i;
 
 	for (i = 0; i < wx->num_rx_queues; i++)
-		wx_free_rx_resources(wx->rx_ring[i]);
+		wx_free_rx_resources(rtnl_dereference(wx->rx_ring[i]));
 }
 
 /**
@@ -2796,7 +2806,7 @@ void wx_clean_all_tx_rings(struct wx *wx)
 	int i;
 
 	for (i = 0; i < wx->num_tx_queues; i++)
-		wx_clean_tx_ring(wx->tx_ring[i]);
+		wx_clean_tx_ring(rtnl_dereference(wx->tx_ring[i]));
 }
 EXPORT_SYMBOL(wx_clean_all_tx_rings);
 
@@ -2844,7 +2854,7 @@ static void wx_free_all_tx_resources(struct wx *wx)
 	int i;
 
 	for (i = 0; i < wx->num_tx_queues; i++)
-		wx_free_tx_resources(wx->tx_ring[i]);
+		wx_free_tx_resources(rtnl_dereference(wx->tx_ring[i]));
 }
 
 void wx_free_resources(struct wx *wx)
@@ -2954,7 +2964,7 @@ static int wx_setup_all_rx_resources(struct wx *wx)
 	int i, err = 0;
 
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		err = wx_setup_rx_resources(wx->rx_ring[i]);
+		err = wx_setup_rx_resources(rtnl_dereference(wx->rx_ring[i]));
 		if (!err)
 			continue;
 
@@ -2966,7 +2976,7 @@ static int wx_setup_all_rx_resources(struct wx *wx)
 err_setup_rx:
 	/* rewind the index freeing the rings as we go */
 	while (i--)
-		wx_free_rx_resources(wx->rx_ring[i]);
+		wx_free_rx_resources(rtnl_dereference(wx->rx_ring[i]));
 	return err;
 }
 
@@ -3057,7 +3067,7 @@ static int wx_setup_all_tx_resources(struct wx *wx)
 	int i, err = 0;
 
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		err = wx_setup_tx_resources(wx->tx_ring[i]);
+		err = wx_setup_tx_resources(rtnl_dereference(wx->tx_ring[i]));
 		if (!err)
 			continue;
 
@@ -3069,7 +3079,7 @@ static int wx_setup_all_tx_resources(struct wx *wx)
 err_setup_tx:
 	/* rewind the index freeing the rings as we go */
 	while (i--)
-		wx_free_tx_resources(wx->tx_ring[i]);
+		wx_free_tx_resources(rtnl_dereference(wx->tx_ring[i]));
 	return err;
 }
 
@@ -3118,7 +3128,7 @@ void wx_get_stats64(struct net_device *netdev,
 
 	rcu_read_lock();
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *ring = READ_ONCE(wx->rx_ring[i]);
+		struct wx_ring *ring = rcu_dereference(wx->rx_ring[i]);
 		u64 bytes, packets;
 		unsigned int start;
 
@@ -3134,7 +3144,7 @@ void wx_get_stats64(struct net_device *netdev,
 	}
 
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		struct wx_ring *ring = READ_ONCE(wx->tx_ring[i]);
+		struct wx_ring *ring = rcu_dereference(wx->tx_ring[i]);
 		u64 bytes, packets;
 		unsigned int start;
 
@@ -3345,7 +3355,8 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 	 */
 	if (new_tx_count != wx->tx_ring_count) {
 		for (i = 0; i < wx->num_tx_queues; i++) {
-			memcpy(&temp_ring[i], wx->tx_ring[i],
+			memcpy(&temp_ring[i],
+			       rtnl_dereference(wx->tx_ring[i]),
 			       sizeof(struct wx_ring));
 
 			temp_ring[i].count = new_tx_count;
@@ -3361,9 +3372,11 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 		}
 
 		for (i = 0; i < wx->num_tx_queues; i++) {
-			wx_free_tx_resources(wx->tx_ring[i]);
+			struct wx_ring *tx_ring = rtnl_dereference(wx->tx_ring[i]);
 
-			memcpy(wx->tx_ring[i], &temp_ring[i],
+			wx_free_tx_resources(tx_ring);
+
+			memcpy(tx_ring, &temp_ring[i],
 			       sizeof(struct wx_ring));
 		}
 
@@ -3373,7 +3386,7 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 	/* Repeat the process for the Rx rings if needed */
 	if (new_rx_count != wx->rx_ring_count) {
 		for (i = 0; i < wx->num_rx_queues; i++) {
-			memcpy(&temp_ring[i], wx->rx_ring[i],
+			memcpy(&temp_ring[i], rtnl_dereference(wx->rx_ring[i]),
 			       sizeof(struct wx_ring));
 
 			temp_ring[i].count = new_rx_count;
@@ -3389,8 +3402,10 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 		}
 
 		for (i = 0; i < wx->num_rx_queues; i++) {
-			wx_free_rx_resources(wx->rx_ring[i]);
-			memcpy(wx->rx_ring[i], &temp_ring[i],
+			struct wx_ring *rx_ring = rtnl_dereference(wx->rx_ring[i]);
+
+			wx_free_rx_resources(rx_ring);
+			memcpy(rx_ring, &temp_ring[i],
 			       sizeof(struct wx_ring));
 		}
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 65b8937f6e94..e4f61cbd8aaa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -311,11 +311,15 @@ static void wx_ptp_rx_hang(struct wx *wx)
 
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
index afd980dbb793..6d258bb0db83 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1359,8 +1359,14 @@ struct wx {
 	u32 tx_ring_count;
 	u32 rx_ring_count;
 
-	struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
-	struct wx_ring *rx_ring[64];
+	/* Ring pointers are published and cleared by the interrupt scheme
+	 * setup and teardown paths with RCU pointer operations. Control-path
+	 * readers use rtnl_dereference() while holding RTNL. Lockless readers
+	 * (such as xmit, stats, and watchdog paths) must use rcu_dereference()
+	 * inside an RCU read-side critical section and NULL-check the result.
+	 */
+	struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
+	struct wx_ring __rcu *rx_ring[64];
 	struct wx_q_vector *q_vector[64];
 	int num_rx_pools;
 	int num_rx_queues_per_pool;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..acacf3b35aa5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -17,7 +17,14 @@ int wxvf_suspend(struct device *dev_d)
 	struct wx *wx = pci_get_drvdata(pdev);
 
 	netif_device_detach(wx->netdev);
+	/* wx_clear_interrupt_scheme() only clears the ring slots with
+	 * rcu_assign_pointer(), so RTNL is not needed for the ring arrays
+	 * here; it serializes this teardown against the VF reset subtask,
+	 * which rebuilds the same interrupt scheme under RTNL.
+	 */
+	rtnl_lock();
 	wx_clear_interrupt_scheme(wx);
+	rtnl_unlock();
 	pci_disable_device(pdev);
 
 	return 0;
@@ -36,8 +43,13 @@ int wxvf_resume(struct device *dev_d)
 	struct wx *wx = pci_get_drvdata(pdev);
 
 	pci_set_master(pdev);
+	/* wx_init_interrupt_scheme() reaches rtnl_dereference() through
+	 * wx_cache_ring_rss(), which requires RTNL.
+	 */
+	rtnl_lock();
 	wx_init_interrupt_scheme(wx);
 	netif_device_attach(wx->netdev);
+	rtnl_unlock();
 
 	return 0;
 }
@@ -205,7 +217,7 @@ static void wx_configure_rx_vf(struct wx *wx)
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *rx_ring = wx->rx_ring[i];
+		struct wx_ring *rx_ring = rtnl_dereference(wx->rx_ring[i]);
 #ifdef HAVE_SWIOTLB_SKIP_CPU_SYNC
 		wx_set_rx_buffer_len_vf(wx, rx_ring);
 #endif
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index 7325b475ee10..0ccf1de4010d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -175,8 +175,11 @@ void wx_configure_tx_vf(struct wx *wx)
 	u32 i;
 
 	/* Setup the HW Tx Head and Tail descriptor pointers */
-	for (i = 0; i < wx->num_tx_queues; i++)
-		wx_configure_tx_ring_vf(wx, wx->tx_ring[i]);
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = rtnl_dereference(wx->tx_ring[i]);
+
+		wx_configure_tx_ring_vf(wx, tx_ring);
+	}
 }
 
 static void wx_configure_srrctl_vf(struct wx *wx, struct wx_ring *ring,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 1960f7154151..2997a93f786c 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -37,9 +37,9 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
-			wx->tx_ring[i]->count = new_tx_count;
+			rtnl_dereference(wx->tx_ring[i])->count = new_tx_count;
 		for (i = 0; i < wx->num_rx_queues; i++)
-			wx->rx_ring[i]->count = new_rx_count;
+			rtnl_dereference(wx->rx_ring[i])->count = new_rx_count;
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 855dc963c610..f13b16b6b193 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -406,7 +406,7 @@ static void ngbe_disable_device(struct wx *wx)
 	/* disable all enabled rx queues */
 	for (i = 0; i < wx->num_rx_queues; i++)
 		/* this call also flushes the previous write */
-		wx_disable_rx_queue(wx, wx->rx_ring[i]);
+		wx_disable_rx_queue(wx, rtnl_dereference(wx->rx_ring[i]));
 	/* disable receives */
 	wx_disable_rx(wx);
 	wx_napi_disable_all(wx);
@@ -422,7 +422,7 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_irq_disable(wx);
 	/* disable transmits in the hardware now that interrupts are off */
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		u8 reg_idx = wx->tx_ring[i]->reg_idx;
+		u8 reg_idx = rtnl_dereference(wx->tx_ring[i])->reg_idx;
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
@@ -578,8 +578,10 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	if (netif_running(netdev))
 		ngbe_close(netdev);
 	wx_clear_interrupt_scheme(wx);
-	rtnl_unlock();
 
+	/* wx_configure_rx() dereferences the ring array, so the WoL setup has
+	 * to stay inside the RTNL section.
+	 */
 	if (wufc) {
 		wx_set_rx_mode(netdev);
 		wx_configure_rx(wx);
@@ -587,6 +589,8 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	} else {
 		wr32(wx, WX_PSR_WKUP_CTL, 0);
 	}
+	rtnl_unlock();
+
 	pci_wake_from_d3(pdev, !!wufc);
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
@@ -866,7 +870,14 @@ static int ngbe_probe(struct pci_dev *pdev,
 
 	ngbe_init_service(wx);
 
+	/* wx_init_interrupt_scheme() reaches rtnl_dereference() through
+	 * wx_cache_ring_rss(), which asserts that RTNL is held.  The netdev is
+	 * not registered yet, so the lock does not serialize this against any
+	 * other caller; it is only there to satisfy that assertion.
+	 */
+	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
+	rtnl_unlock();
 	if (err)
 		goto err_cancel_service;
 
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index d79cf8d8484f..93221b175c15 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -202,7 +202,14 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
 	wxvf_init_service(wx);
+	/* wx_init_interrupt_scheme() reaches rtnl_dereference() through
+	 * wx_cache_ring_rss(), which asserts that RTNL is held.  The netdev is
+	 * not registered yet, so the lock does not serialize this against any
+	 * other caller; it is only there to satisfy that assertion.
+	 */
+	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
+	rtnl_unlock();
 	if (err)
 		goto err_free_sw_init;
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 3e32aca72806..d2d43fec0157 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -61,9 +61,9 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
-			wx->tx_ring[i]->count = new_tx_count;
+			rtnl_dereference(wx->tx_ring[i])->count = new_tx_count;
 		for (i = 0; i < wx->num_rx_queues; i++)
-			wx->rx_ring[i]->count = new_rx_count;
+			rtnl_dereference(wx->rx_ring[i])->count = new_rx_count;
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
@@ -366,7 +366,7 @@ static int txgbe_add_ethtool_fdir_entry(struct txgbe *txgbe,
 
 		/* Map the ring onto the absolute queue index */
 		if (!vf)
-			queue = wx->rx_ring[ring]->reg_idx;
+			queue = rtnl_dereference(wx->rx_ring[ring])->reg_idx;
 		else
 			queue = ((vf - 1) * wx->num_rx_queues_per_pool) + ring;
 	}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
index 59a47532618c..e0a18aae2785 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
@@ -606,7 +606,7 @@ static void txgbe_fdir_filter_restore(struct wx *wx)
 
 			/* Map the ring onto the absolute queue index */
 			if (!vf)
-				queue = wx->rx_ring[ring]->reg_idx;
+				queue = rtnl_dereference(wx->rx_ring[ring])->reg_idx;
 			else
 				queue = ((vf - 1) * wx->num_rx_queues_per_pool) + ring;
 		}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index eb91c4f28ecd..4c607bde88d7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -239,7 +239,7 @@ static void txgbe_disable_device(struct wx *wx)
 	/* disable all enabled rx queues */
 	for (i = 0; i < wx->num_rx_queues; i++)
 		/* this call also flushes the previous write */
-		wx_disable_rx_queue(wx, wx->rx_ring[i]);
+		wx_disable_rx_queue(wx, rtnl_dereference(wx->rx_ring[i]));
 
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
@@ -275,7 +275,7 @@ static void txgbe_disable_device(struct wx *wx)
 
 	/* disable transmits in the hardware now that interrupts are off */
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		u8 reg_idx = wx->tx_ring[i]->reg_idx;
+		u8 reg_idx = rtnl_dereference(wx->tx_ring[i])->reg_idx;
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
@@ -865,7 +865,14 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	txgbe_init_service(wx);
 
+	/* wx_init_interrupt_scheme() reaches rtnl_dereference() through
+	 * wx_cache_ring_rss(), which asserts that RTNL is held.  The netdev is
+	 * not registered yet, so the lock does not serialize this against any
+	 * other caller; it is only there to satisfy that assertion.
+	 */
+	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
+	rtnl_unlock();
 	if (err)
 		goto err_cancel_service;
 
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 8b16b900820a..4d1037d3245c 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -267,7 +267,14 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
 	wxvf_init_service(wx);
+	/* wx_init_interrupt_scheme() reaches rtnl_dereference() through
+	 * wx_cache_ring_rss(), which asserts that RTNL is held.  The netdev is
+	 * not registered yet, so the lock does not serialize this against any
+	 * other caller; it is only there to satisfy that assertion.
+	 */
+	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
+	rtnl_unlock();
 	if (err)
 		goto err_free_sw_init;
 
-- 
2.30.1

