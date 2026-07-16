Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7F32A3FF
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187578; cv=none; b=dWvYPRZ/hur1KWEU57y5xYlYnmHb8K9rkTDW2nMTv9ftwGqOPo2CJfCrY9Z011te3dc4RA0ELF7pSGuwwVRhHvSJJlixF3uzZniWTJ6ihUKgQC+4lr+lunm9BkwAr71d6C7Ygir4W9LD5RD6hE3JyTjjIXnrVoHR1ixDKTxi4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187578; c=relaxed/simple;
	bh=/tlkLlNyfF7wob/ILwtH2edFuQ716llMXfCy508BZ/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZs1VPnpIWBfW3Txp9IpBNIDqB4sSJb7lcOSy4ZSjuQe5UMHq/1k/+CzYpca1wx87BCj/V8ZlZ94ikgjpKmQmJP4apBwJYLzJSKCHYbc4EwcakiIqsBELMB3ji1WFyIA3DIGa5J8HqazgwO9/6wxw1HIgdaCpM5oJemQnhNhAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1784187518t9d2587b5
X-QQ-Originating-IP: TLbmqWaMObvqN+vbI7vM2eJT7OWaUsDskf53RsUf0NE=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.247.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 15:38:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6097529817103200902
EX-QQ-RecipientCnt: 20
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v11 2/5] net: wangxun: add Tx timeout process
Date: Thu, 16 Jul 2026 15:38:19 +0800
Message-Id: <20260716073822.24356-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260716073822.24356-1-jiawenwu@trustnetic.com>
References: <20260716073822.24356-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NFFHCkPA/x3A5uQCFVJLLUzKT0dhvq3InpJLKFLgosQDeB4uCEOqJAYd
	x7H3aqQ42Q0gJbCzQQ5/u5YEqPKbhRVAYVMvTnBTNmSdbjKLjJ1bvXgY2+kJLPOZ5MJNbxG
	Lz1MygR67lJSjEPmaCcpWh3WANl3K0pEANPsbqYFfU4yNRuI44lryed3fuXQclc6ENpMX8N
	eyW7yVUXcG1mV+6273tJIjmphIEzw3ucojyhv9Xd/MRQ4BpKxD9vTthTl4X7aYwq1UY3PoO
	xkpFYFg/8zI/imPrFlPp0cvu+TiBXCigE2RU8RBl56kXic4N2Gymv8yZcauRoPfGuUrV9Zh
	Tk/Q1fueTYLs+oaLnOBMYKYEOquIoLUxBSNc3xQJRxunHHzb6+GnwV4zsxl9mcwl+unTtoS
	iUVjKx/45yZ1cQixFSxQko3nwsqQcfQ+VQs/R3RTAkEgol8YCxpvR+BYAC2dvcSBmZG7YCh
	/bjSspGUhBQMUJOhef7mTQeHZukWwed+zEur/U0esFrbxBJWCrKm9XOk6D1PMej6UThJQXp
	YhUXPhOOCVme7KnXbPkv6rFmIYexOWRkF665xXREyGm3L3Af8b68VQlUJTeYDLbYSn2jj20
	XOrz+UuigZdCS7+oNAWMR3QpyQe/hKw2PH3dMzdjOFk8mPMiXfpO6JorWCugIl+72HWr2lr
	0sySj8yy/7AiZHJI9m4cjp/wPa6XRCl1HJvYHY7m4zUvyjGpcWl1t+4Bw0KlvDB+Krp7Cl4
	e64zpFnfRp+G8XXlLm7XHaoIockKYCxJyI21yZaKxQSWZayWezovABE1F5J6zx+ZxFpwGCY
	cwDEjS4vhZRJrbtUalo40+AegAGBMaNoIxdyQDbhcmnAZ5LBUEWAOC3UX0XEoJiqXBs97Iy
	RtGii6gwPpo4/xlz6lT6Kx/aVxZdn2DFVrRWfVI0zPXizmAyTT2Mbt/rFA/Ht4l4dsmx6sR
	y9JP2omTsel9bOvsnRsUaXcpO9bzPUmTdDYgV5nHSgrP2D9OcGNjqt4AVArblRP8Thfs+Ma
	KAJzWuddA1gd1PiKASOYmvic8Ge4wQmD9ktI1Su7PW/DJGf3eUwIPYOSP63tWkNCoswWW3A
	NVO7/ymUJn2RfPSf7Bba7nxakmtt08swIfigBcaBzcoYbD8wYlvLew=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Implement .ndo_tx_timeout to handle Tx side timeout event. When a Tx
timeout event occur, it will trigger driver into reset process. And
allocate a separate work queue for reset process.

The WX_HANG_CHECK_ARMED bit is set to indicate a potential hang. It will
be cleared if a pause frame is received to avoid false hang detection
caused by pause frames.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 175 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  37 ++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  19 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  14 ++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  14 ++
 8 files changed, 289 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index a71b0ad77de3..c8724bb129aa 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,5 +4,5 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o wx_err.o
 libwx-objs += wx_vf.o wx_vf_lib.o wx_vf_common.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
new file mode 100644
index 000000000000..b6e2d16d4a16
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd. */
+/* Copyright (c) 1999 - 2026 Intel Corporation. */
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_lib.h"
+#include "wx_err.h"
+
+static void wx_pf_reset_subtask(struct wx *wx)
+{
+	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
+		return;
+
+	wx_warn(wx, "Reset adapter.\n");
+	if (wx->do_reset)
+		wx->do_reset(wx->netdev);
+}
+
+static void wx_reset_task(struct work_struct *work)
+{
+	struct wx *wx = container_of(work, struct wx, reset_task);
+
+	rtnl_lock();
+
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		goto out;
+
+	wx_pf_reset_subtask(wx);
+
+out:
+	rtnl_unlock();
+}
+
+void wx_check_err_subtask(struct wx *wx)
+{
+	if (test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
+		queue_work(wx->reset_wq, &wx->reset_task);
+}
+EXPORT_SYMBOL(wx_check_err_subtask);
+
+int wx_init_err_task(struct wx *wx)
+{
+	wx->reset_wq = alloc_workqueue("%s_reset_wq_%x", WQ_UNBOUND | WQ_HIGHPRI,
+				       1, wx->driver_name, pci_dev_id(wx->pdev));
+	if (!wx->reset_wq) {
+		wx_err(wx, "Failed to create wx_reset_wq workqueue\n");
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&wx->reset_task, wx_reset_task);
+	return 0;
+}
+EXPORT_SYMBOL(wx_init_err_task);
+
+static bool wx_ring_tx_pending(struct wx *wx)
+{
+	int i;
+
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = wx->tx_ring[i];
+
+		if (tx_ring->next_to_use != tx_ring->next_to_clean)
+			return true;
+	}
+
+	return false;
+}
+
+static bool wx_vf_tx_pending(struct wx *wx)
+{
+	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
+	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
+	u32 i, j;
+
+	if (!wx->num_vfs)
+		return false;
+
+	for (i = 0; i < wx->num_vfs; i++) {
+		for (j = 0; j < q_per_pool; j++) {
+			u32 h, t;
+
+			h = rd32(wx, WX_PX_TR_RP_PV(q_per_pool, i, j));
+			t = rd32(wx, WX_PX_TR_WP_PV(q_per_pool, i, j));
+
+			if (h != t)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static void wx_watchdog_flush_tx(struct wx *wx)
+{
+	if (!netif_running(wx->netdev))
+		return;
+	if (netif_carrier_ok(wx->netdev))
+		return;
+
+	if (wx_ring_tx_pending(wx) || wx_vf_tx_pending(wx)) {
+		/* We've lost link, so the controller stops DMA,
+		 * but we've got queued Tx work that's never going
+		 * to get done, so reset controller to flush Tx.
+		 * (Do the reset outside of interrupt context).
+		 */
+		wx_warn(wx, "initiating reset due to lost link with pending Tx work\n");
+		set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	}
+}
+
+static void wx_detect_tx_hang(struct wx *wx)
+{
+	int i;
+
+	/* If we're down or resetting, just bail */
+	if (!netif_running(wx->netdev) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
+	/* Force detection of hung controller */
+	if (netif_carrier_ok(wx->netdev)) {
+		for (i = 0; i < wx->num_tx_queues; i++)
+			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);
+	}
+}
+
+void wx_check_hang_subtask(struct wx *wx)
+{
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
+	wx_watchdog_flush_tx(wx);
+	wx_detect_tx_hang(wx);
+}
+EXPORT_SYMBOL(wx_check_hang_subtask);
+
+static void wx_tx_timeout_reset(struct wx *wx)
+{
+	if (test_bit(WX_STATE_DOWN, wx->state))
+		return;
+
+	set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	wx_warn(wx, "initiating reset due to tx timeout\n");
+	wx_service_event_schedule(wx);
+}
+
+void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txqueue)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	wx_tx_timeout_reset(wx);
+}
+EXPORT_SYMBOL(wx_tx_timeout);
+
+void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next)
+{
+	struct wx *wx = netdev_priv(tx_ring->netdev);
+
+	wx_warn(wx,
+		"Detected Tx Unit Hang: Queue %d, TDH %x, TDT %x, ntu %x, ntc %x, ntc.time_stamp %lx, jiffies %lx\n",
+		tx_ring->queue_index,
+		rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx)),
+		rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx)),
+		tx_ring->next_to_use, next,
+		tx_ring->tx_buffer_info[next].time_stamp, jiffies);
+
+	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
+
+	wx_tx_timeout_reset(wx);
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
new file mode 100644
index 000000000000..1eed13e48095
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * WangXun Gigabit PCI Express Linux driver
+ * Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd.
+ */
+
+#ifndef _WX_ERR_H_
+#define _WX_ERR_H_
+
+void wx_check_err_subtask(struct wx *wx);
+int wx_init_err_task(struct wx *wx);
+void wx_check_hang_subtask(struct wx *wx);
+void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue);
+void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next);
+
+#endif /* _WX_ERR_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 260e14d5d541..122c4952d203 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1932,6 +1932,7 @@ static void wx_configure_tx_ring(struct wx *wx,
 	else
 		ring->atr_sample_rate = 0;
 
+	bitmap_zero(ring->state, WX_RING_STATE_NBITS);
 	/* reinitialize tx_buffer_info */
 	memset(ring->tx_buffer_info, 0,
 	       sizeof(struct wx_tx_buffer) * ring->count);
@@ -2851,16 +2852,26 @@ EXPORT_SYMBOL(wx_fc_enable);
 static void wx_update_xoff_rx_lfc(struct wx *wx)
 {
 	struct wx_hw_stats *hwstats = &wx->stats;
+	u64 data;
+	int i;
 
 	if (wx->fc.mode != wx_fc_full &&
 	    wx->fc.mode != wx_fc_rx_pause)
 		return;
 
 	if (wx->mac.type >= wx_mac_aml)
-		hwstats->lxoffrxc += rd32_wrap(wx, WX_MAC_LXOFFRXC_AML,
-					       &wx->last_stats.lxoffrxc);
+		data = rd32_wrap(wx, WX_MAC_LXOFFRXC_AML,
+				 &wx->last_stats.lxoffrxc);
 	else
-		hwstats->lxoffrxc += rd64(wx, WX_MAC_LXOFFRXC);
+		data = rd64(wx, WX_MAC_LXOFFRXC);
+	hwstats->lxoffrxc += data;
+
+	/* refill credits (no tx hang) if we received xoff */
+	if (!data)
+		return;
+
+	for (i = 0; i < wx->num_tx_queues; i++)
+		clear_bit(WX_HANG_CHECK_ARMED, wx->tx_ring[i]->state);
 }
 
 /**
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 814d88d2aee4..3a6db657c685 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -14,6 +14,7 @@
 
 #include "wx_type.h"
 #include "wx_lib.h"
+#include "wx_err.h"
 #include "wx_ptp.h"
 #include "wx_hw.h"
 #include "wx_vf_lib.h"
@@ -742,6 +743,37 @@ static struct netdev_queue *wx_txring_txq(const struct wx_ring *ring)
 	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
 }
 
+static u32 wx_get_tx_pending(struct wx_ring *ring)
+{
+	unsigned int head, tail;
+
+	head = ring->next_to_clean;
+	tail = ring->next_to_use;
+
+	return ((head <= tail) ? tail : tail + ring->count) - head;
+}
+
+static bool wx_check_tx_hang(struct wx_ring *ring)
+{
+	u32 tx_done_old = ring->tx_stats.tx_done_old;
+	u32 tx_pending = wx_get_tx_pending(ring);
+	u32 tx_done = ring->stats.packets;
+
+	if (!test_and_clear_bit(WX_TX_DETECT_HANG, ring->state))
+		return false;
+
+	if (tx_done_old == tx_done && tx_pending)
+		/* make sure it is true for two checks in a row */
+		return test_and_set_bit(WX_HANG_CHECK_ARMED, ring->state);
+
+	/* update completed stats and continue */
+	ring->tx_stats.tx_done_old = tx_done;
+	/* reset the countdown */
+	clear_bit(WX_HANG_CHECK_ARMED, ring->state);
+
+	return false;
+}
+
 /**
  * wx_clean_tx_irq - Reclaim resources after transmit completes
  * @q_vector: structure containing interrupt and ring information
@@ -866,6 +898,11 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 	netdev_tx_completed_queue(wx_txring_txq(tx_ring),
 				  total_packets, total_bytes);
 
+	if (wx_check_tx_hang(tx_ring)) {
+		wx_handle_tx_hang(tx_ring, i);
+		return true;
+	}
+
 #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
 	if (unlikely(total_packets && netif_carrier_ok(tx_ring->netdev) &&
 		     (wx_desc_unused(tx_ring) >= TX_WAKE_THRESHOLD))) {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 65e3e55db1cf..e12a59305193 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -450,6 +450,11 @@ enum WX_MSCA_CMD_value {
 #define WX_PX_TR_CFG_THRE_SHIFT      8
 #define WX_PX_TR_CFG_HEAD_WB         BIT(27)
 
+#define WX_PX_TR_RP_PV(q_per_pool, vf_number, vf_q_index) \
+		(WX_PX_TR_RP((q_per_pool) * (vf_number) + (vf_q_index)))
+#define WX_PX_TR_WP_PV(q_per_pool, vf_number, vf_q_index) \
+		(WX_PX_TR_WP((q_per_pool) * (vf_number) + (vf_q_index)))
+
 /* Receive DMA Registers */
 #define WX_PX_RR_BAL(_i)             (0x01000 + ((_i) * 0x40))
 #define WX_PX_RR_BAH(_i)             (0x01004 + ((_i) * 0x40))
@@ -1040,6 +1045,7 @@ struct wx_queue_stats {
 struct wx_tx_queue_stats {
 	u64 restart_queue;
 	u64 tx_busy;
+	u32 tx_done_old;
 };
 
 struct wx_rx_queue_stats {
@@ -1055,6 +1061,12 @@ struct wx_rx_queue_stats {
 #define wx_for_each_ring(posm, headm) \
 	for (posm = (headm).ring; posm; posm = posm->next)
 
+enum wx_ring_state {
+	WX_TX_DETECT_HANG,
+	WX_HANG_CHECK_ARMED,
+	WX_RING_STATE_NBITS
+};
+
 struct wx_ring_container {
 	struct wx_ring *ring;           /* pointer to linked list of rings */
 	unsigned int total_bytes;       /* total bytes processed this int */
@@ -1074,6 +1086,7 @@ struct wx_ring {
 		struct wx_tx_buffer *tx_buffer_info;
 		struct wx_rx_buffer *rx_buffer_info;
 	};
+	DECLARE_BITMAP(state, WX_RING_STATE_NBITS);
 	u8 __iomem *tail;
 	dma_addr_t dma;                 /* phys. address of descriptor ring */
 	dma_addr_t headwb_dma;
@@ -1275,6 +1288,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_DO_RESET,
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
+	WX_FLAG_NEED_PF_RESET,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1423,6 +1437,8 @@ struct wx {
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
+	struct work_struct reset_task;
+	struct workqueue_struct *reset_wq;
 	struct mutex reset_lock; /* mutex for reset */
 };
 
@@ -1505,7 +1521,8 @@ rd32_wrap(struct wx *wx, u32 reg, u32 *last)
 
 #define wx_err(wx, fmt, arg...) \
 	dev_err(&(wx)->pdev->dev, fmt, ##arg)
-
+#define wx_warn(wx, fmt, arg...) \
+	dev_warn(&(wx)->pdev->dev, fmt, ##arg)
 #define wx_dbg(wx, fmt, arg...) \
 	dev_dbg(&(wx)->pdev->dev, fmt, ##arg)
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index bbbec9b43bc2..996c48da52d7 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -14,6 +14,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_err.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_sriov.h"
@@ -148,6 +149,8 @@ static void ngbe_service_task(struct work_struct *work)
 	struct wx *wx = container_of(work, struct wx, service_task);
 
 	wx_update_stats(wx);
+	wx_check_hang_subtask(wx);
+	wx_check_err_subtask(wx);
 
 	wx_service_event_complete(wx);
 }
@@ -393,6 +396,7 @@ static void ngbe_disable_device(struct wx *wx)
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
 
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
 	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
 
@@ -644,6 +648,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_stop               = ngbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
+	.ndo_tx_timeout         = wx_tx_timeout,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
@@ -733,6 +738,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	wx->driver_name = ngbe_driver_name;
 	ngbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &ngbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
 
 	netdev->features = NETIF_F_SG | NETIF_F_IP_CSUM |
 			   NETIF_F_TSO | NETIF_F_TSO6 |
@@ -829,6 +835,10 @@ static int ngbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	err = wx_init_err_task(wx);
+	if (err)
+		goto err_free_mac_table;
+
 	ngbe_init_service(wx);
 
 	err = wx_init_interrupt_scheme(wx);
@@ -856,6 +866,8 @@ static int ngbe_probe(struct pci_dev *pdev,
 err_cancel_service:
 	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	cancel_work_sync(&wx->reset_task);
+	destroy_workqueue(wx->reset_wq);
 err_free_mac_table:
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
@@ -887,6 +899,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 
 	timer_shutdown_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	cancel_work_sync(&wx->reset_task);
+	destroy_workqueue(wx->reset_wq);
 
 	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 20c5a295c6c2..b1615f82a265 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -14,6 +14,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_err.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_mbx.h"
@@ -123,6 +124,8 @@ static void txgbe_service_task(struct work_struct *work)
 	txgbe_module_detection_subtask(wx);
 	txgbe_link_config_subtask(wx);
 	wx_update_stats(wx);
+	wx_check_hang_subtask(wx);
+	wx_check_err_subtask(wx);
 
 	wx_service_event_complete(wx);
 }
@@ -224,6 +227,7 @@ static void txgbe_disable_device(struct wx *wx)
 	wx_irq_disable(wx);
 	wx_napi_disable_all(wx);
 
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
 	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
 
@@ -654,6 +658,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_stop               = txgbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
+	.ndo_tx_timeout         = wx_tx_timeout,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
@@ -745,6 +750,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
 	netdev->udp_tunnel_nic_info = &txgbe_udp_tunnels;
 
 	/* setup the private structure */
@@ -814,6 +820,10 @@ static int txgbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	err = wx_init_err_task(wx);
+	if (err)
+		goto err_free_mac_table;
+
 	txgbe_init_service(wx);
 
 	err = wx_init_interrupt_scheme(wx);
@@ -916,6 +926,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 err_cancel_service:
 	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	cancel_work_sync(&wx->reset_task);
+	destroy_workqueue(wx->reset_wq);
 err_free_mac_table:
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
@@ -948,6 +960,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 
 	timer_shutdown_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	cancel_work_sync(&wx->reset_task);
+	destroy_workqueue(wx->reset_wq);
 
 	txgbe_remove_phy(txgbe);
 	wx_free_isb_resources(wx);
-- 
2.51.0

