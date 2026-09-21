Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282033B47D6
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974990; cv=none; b=p8/3V0aqnOXZuY1RmAicw6ERZFTwSv5/vrjBZo3UiiMim37b277XXlSHDGtfn7vgAmdVQEIzoq9W8PM11y4O2IiX5ebZz339FU7QQlAt2zW7RWFaeuhkSSLcEIMDLs/Fb+PTOeHqiy6qHFuxO/AWpsJpvZ9FkCji1C/TmkhHK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974990; c=relaxed/simple;
	bh=C/ZX0gkV7LwTto7TENuOL+p/jXbNqWJHCRxfW7dj2Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdK/xICPoHHq2SI/l4TE72sxAMMgFqOxr4vVWnE+N7X8hYLzews+wP2OIxt2FOrxnusipb6LwFLBFanieVKW6mc5yD8JvPnXnu2KNn/IFaOL8DQUMkQn2B2Q3IJCXV/uJA/Qo97O4Tx1a6weSljSjlRs4LYhdOu8h9dK8skUutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz4t1789974971tf6c43db3
X-QQ-Originating-IP: seX7B6hYRw9mv4L6MkctHaiXSOhZvnCwU1ngZM2z46g=
Received: from w-MS-7E16.trustnetic.com ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Sep 2026 15:15:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11825282507341202180
EX-QQ-RecipientCnt: 14
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3] net: libwx: fix races in Tx timestamp handling
Date: Mon, 21 Sep 2026 15:15:49 +0800
Message-ID: <77431AF9A0E369F3+20260921071549.1141804-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NYwmM76ehjewxfvm8G0NM2rQT4+BvIC4NiCzl344uGSiA+ZGGJ2lFJIt
	PHrDvVtm/KgNNESNYXR7bckyJidfnRgMxBtU3ymRIK43y6w/x3UCJ7sq2Up6qtAjW9xn+gD
	tNXTDnyhZ6TxL0cCDbS7+MnzN//sNodyBWW6QTtTVhEEvrKONmdQs/iLK7fM/+jXnKcjgms
	INDEzVue0meFYugZhs2cSTWDA+n0J6S9tCXn6Lt2VF38Eq4fGxul4rk9xXWZZ5aRR9fNmT5
	77mCWa6ivtkjX+VyD7OJI91GY3Uo4WwNNTjp9DHzEJ9oI7OMKzHWhbFf9bRnMQUAKDCVbV6
	LTX9rJdqocc66PKaTphK/0MhT+eP7SMN63y6YzbROLdfU/nXBHGWpCkIqeSjfzTkHPcXzkG
	76h2a8glf3kIn9Y2J+WLoNbXTDXJro8uVpJB7Dbvd3jvo3yxd/tgr2+E2rMKQCXInCJAObJ
	xdSNIHjOVUB6TqhmmSpEqfG5HFnYJQiUWM6d2M19UCFWxH/ovRUt4LKaHP8hUkSSHrlRV6u
	xjx/V1hdJGPTDrfD/7Ew4rRIZ75RUeHPy6xJI2P5V9vENdODINC+b1lzOPVXFEzJ1gdekxj
	TqsyYidvwX14WzBp4Da2vPwoyZMJ3IwKISKR6pMu3ayBkpim285CK1xZdfOqE+SWTLz6okQ
	wYzXemNsDijb4sP0HNvuRZ4qy5yAYnR++Jp2WkBC5MvinYgtndLR0moWoMzenq/wrTql1tG
	fAOm8AHBYTvURQSh1B9JKsM9O7JxyBAUq5681fI+cCQpuJ5ky0SrrTmswG/J4wETiv3mDNl
	GUgc5ZaXSM9IDeAY6HP4XD9HkFpS4bBW1CyJ1tR5ST3uSxZmWWkzDLhFxiFbJsVo29TR7VI
	3iCIladOTbqBqB2al8ZgVPknDDgmiZ0FsZhXwI9xeJgEoRhgGs9PEolMJE/vrG9cLJs89Rx
	XBi6ErNj3J4aJdO+DNc9m5G8uILpW0IKrtT32OzJSkA5iicHlntcJ6OAWovZoAWbNKGge+K
	++hKp0iBEB50gnQ3jNVOwJhO1Hf5ypwFtt5dTRyEBJ7dOlNRTJikr2sU5qNtpDlS7bkbE83
	KPhf0PSC39zTWXlOrANn3u8pJQIQTVoaZpE9EG10yjdnZZPtknQC/M=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

wx->ptp_tx_skb is shared between the Tx path, the PTP auxiliary
worker and the timestamp cleanup paths. The
WX_STATE_PTP_TX_IN_PROGRESS bit prevents multiple Tx paths from
submitting timestamp requests, but does not serialize the worker
against cleanup.

As a result, wx_ptp_clear_tx_timestamp() can free an skb after
wx_ptp_tx_hwtstamp_work() has obtained its pointer. The worker may
then pass the freed skb to skb_tstamp_tx() and release the same
reference again.

The cleanup path may also clear the in-progress bit while the worker
is still processing the old skb. This allows the Tx path to publish a
new skb which the worker can subsequently overwrite with NULL,
leaking its reference.

Add a dedicated spinlock to protect publication and consumption of
the Tx timestamp skb. Detach the skb and clear the in-progress bit
while holding the lock, then deliver the timestamp and release the skb
after dropping it. Use the same locked cleanup in the quiesce path,
but keep the detach there free of register accesses: quiesce runs
during PCIe error recovery, where MMIO is not reliable, and it
deliberately did not touch the device before. The lock is taken with
interrupts disabled, because netpoll can call ndo_start_xmit() with
hard interrupts already off.

When handling a Tx DMA mapping failure, keep the transmit path
reference until after comparing the skb under the lock. This prevents
skb address reuse from making the error path mistake a newer timestamp
request for the failed one.

Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/6C7EC12D69217315%2B20260818074721.45536-1-jiawenwu%40trustnetic.com
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v3:
- Drop the register access from the quiesce path.
- Increment tx_hwtstamp_errors inside ptp_tx_lock, next to the detach.
- Reword the out_drop comment.

v2: https://lore.kernel.org/all/73D0D3F5D96A6928+20260914080020.211580-1-jiawenwu@trustnetic.com
- Keep the original skb reference alive until the PTP cleanup has compared
  it under the lock, preventing slab address reuse from matching and
  cancelling a newer timestamp request.
- Let the transmit caller release the skb after both DMA rollback and PTP
  cleanup have completed.
- Only cancel the failed timestamp request and increment
  tx_hwtstamp_errors when the outstanding skb still belongs to that
  transmit.
- Factor the common timestamp detach sequence into a locked helper,
  including unlatching the hardware timestamp, detaching ptp_tx_skb and
  clearing the in-progress state bit.
- Make wx_ptp_quiesce() use the common locked timestamp cleanup path.
- Use spin_lock_irqsave() for ptp_tx_lock because ndo_start_xmit() may be
  invoked by netpoll with hard interrupts disabled.
- Protect ptp_tx_skb, ptp_tx_start and the in-progress state bit with the
  same lock.
- Release or deliver detached skbs after dropping the lock.
- Add comments and kernel-doc describing skb ownership, locking and
  timestamp worker return semantics.

v1: https://lore.kernel.org/all/8F4D34F6863177CC+20260908081142.86235-1-jiawenwu@trustnetic.com
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  |  47 ++++--
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c  | 142 +++++++++++++------
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   2 +
 4 files changed, 132 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 122c4952d203..113552586be7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2518,6 +2518,7 @@ int wx_sw_init(struct wx *wx)
 	}
 
 	spin_lock_init(&wx->hw_stats_lock);
+	spin_lock_init(&wx->ptp_tx_lock);
 	mutex_init(&wx->reset_lock);
 	bitmap_zero(wx->state, WX_STATE_NBITS);
 	bitmap_zero(wx->flags, WX_PF_FLAGS_NBITS);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ed5aad7857bd..dcbf5811046e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1200,9 +1200,11 @@ static int wx_tx_map(struct wx_ring *tx_ring,
 		i--;
 	}
 
-	dev_kfree_skb_any(first->skb);
-	first->skb = NULL;
-
+	/* first->skb is released by the caller, which keeps a reference on it
+	 * until the PTP cleanup has compared it against wx->ptp_tx_skb. That
+	 * prevents the address from being reused by a newer request while the
+	 * comparison is pending.
+	 */
 	tx_ring->next_to_use = i;
 
 	return -ENOMEM;
@@ -1649,9 +1651,11 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 	    wx->ptp_clock) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&wx->ptp_tx_lock, flags);
 		if (wx->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !test_and_set_bit_lock(WX_STATE_PTP_TX_IN_PROGRESS,
-					   wx->state)) {
+		    !test_and_set_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state)) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= WX_TX_FLAGS_TSTAMP;
 			wx->ptp_tx_skb = skb_get(skb);
@@ -1659,6 +1663,7 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 		} else {
 			wx->tx_hwtstamp_skipped++;
 		}
+		spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
 	}
 
 	/* record initial flags and protocol */
@@ -1677,19 +1682,35 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 		wx->atr(tx_ring, first, ptype);
 
 	if (wx_tx_map(tx_ring, first, hdr_len))
-		goto cleanup_tx_tstamp;
+		goto out_drop;
 
 	return NETDEV_TX_OK;
 out_drop:
-	dev_kfree_skb_any(first->skb);
-	first->skb = NULL;
-cleanup_tx_tstamp:
+	/* The frame never reached the hardware, so no timestamp will ever be
+	 * reported for it and the request has to be cancelled. The slot is
+	 * shared, though: wx_ptp_clear_tx_timestamp() or wx_ptp_tx_hang() may
+	 * have dropped our request already, and a transmit on another queue
+	 * can have claimed the slot since. Only cancel it while it is still
+	 * ours, otherwise we would free somebody else's skb and release their
+	 * in-progress bit.
+	 */
 	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
-		dev_kfree_skb_any(wx->ptp_tx_skb);
-		wx->ptp_tx_skb = NULL;
-		wx->tx_hwtstamp_errors++;
-		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+		struct sk_buff *ptp_tx_skb = NULL;
+		unsigned long flags;
+
+		spin_lock_irqsave(&wx->ptp_tx_lock, flags);
+		if (wx->ptp_tx_skb == skb) {
+			ptp_tx_skb = wx->ptp_tx_skb;
+			wx->ptp_tx_skb = NULL;
+			clear_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+			wx->tx_hwtstamp_errors++;
+		}
+		spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
+
+		dev_kfree_skb_any(ptp_tx_skb);
 	}
+	dev_kfree_skb_any(first->skb);
+	first->skb = NULL;
 
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 4708e7f3958f..65b8937f6e94 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -129,6 +129,34 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+/**
+ * __wx_ptp_detach_tx_skb - detach the skb tracking the Tx timestamp request
+ * @wx: the private board structure
+ *
+ * Detach the skb of the outstanding request and release the in-progress bit,
+ * so that a new request can be submitted.
+ *
+ * This performs no register access. Callers that need a timestamp the hardware
+ * may have left latched must unlatch it themselves, while the device is known
+ * to be alive. wx_ptp_quiesce() runs during PCIe error recovery, where MMIO is
+ * not reliable, and therefore deliberately skips the unlatch.
+ *
+ * Context: Expects wx->ptp_tx_lock to be held by the caller.
+ * Return: the detached skb, or NULL if no request was outstanding. The caller
+ * owns the returned reference and must release it once the lock is dropped.
+ */
+static struct sk_buff *__wx_ptp_detach_tx_skb(struct wx *wx)
+{
+	struct sk_buff *skb = wx->ptp_tx_skb;
+
+	lockdep_assert_held(&wx->ptp_tx_lock);
+
+	wx->ptp_tx_skb = NULL;
+	clear_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+
+	return skb;
+}
+
 /**
  * wx_ptp_clear_tx_timestamp - utility function to clear Tx timestamp state
  * @wx: the private board structure
@@ -139,12 +167,16 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
  */
 static void wx_ptp_clear_tx_timestamp(struct wx *wx)
 {
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wx->ptp_tx_lock, flags);
+	/* Unlatch a timestamp the hardware may have left pending. */
 	rd32ptp(wx, WX_TSC_1588_STMPH);
-	if (wx->ptp_tx_skb) {
-		dev_kfree_skb_any(wx->ptp_tx_skb);
-		wx->ptp_tx_skb = NULL;
-	}
-	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+	skb = __wx_ptp_detach_tx_skb(wx);
+	spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
+
+	dev_kfree_skb_any(skb);
 }
 
 /**
@@ -175,49 +207,54 @@ static void wx_ptp_convert_to_hwtstamp(struct wx *wx,
 }
 
 /**
- * wx_ptp_tx_hwtstamp - utility function which checks for TX time stamp
+ * wx_ptp_tx_hwtstamp_work - check for a pending Tx time stamp
  * @wx: the private board struct
  *
- * if the timestamp is valid, we convert it into the timecounter ns
- * value, then store that result into the shhwtstamps structure which
- * is passed up the network stack
+ * If a Tx timestamp request is outstanding and the hardware has latched a
+ * valid value, we convert it into the timecounter ns value, then store that
+ * result into the shhwtstamps structure which is passed up the network stack.
+ *
+ * Return: 0 when there is nothing left to poll for, -1 when the timestamp is
+ * not available yet and the caller should poll again.
  */
-static void wx_ptp_tx_hwtstamp(struct wx *wx)
+static int wx_ptp_tx_hwtstamp_work(struct wx *wx)
 {
 	struct skb_shared_hwtstamps shhwtstamps;
-	struct sk_buff *skb = wx->ptp_tx_skb;
+	unsigned long flags;
+	struct sk_buff *skb;
+	u32 tsynctxctl;
 	u64 regval = 0;
 
-	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPL);
-	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPH) << 32;
-
-	wx_ptp_convert_to_hwtstamp(wx, &shhwtstamps, regval);
-
-	wx->ptp_tx_skb = NULL;
-	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
-	skb_tstamp_tx(skb, &shhwtstamps);
-	dev_kfree_skb_any(skb);
-	wx->tx_hwtstamp_pkts++;
-}
-
-static int wx_ptp_tx_hwtstamp_work(struct wx *wx)
-{
-	u32 tsynctxctl;
+	spin_lock_irqsave(&wx->ptp_tx_lock, flags);
 
 	/* we have to have a valid skb to poll for a timestamp */
 	if (!wx->ptp_tx_skb) {
-		wx_ptp_clear_tx_timestamp(wx);
+		rd32ptp(wx, WX_TSC_1588_STMPH);
+		__wx_ptp_detach_tx_skb(wx);
+		spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
 		return 0;
 	}
 
 	/* stop polling once we have a valid timestamp */
 	tsynctxctl = rd32ptp(wx, WX_TSC_1588_CTL);
-	if (tsynctxctl & WX_TSC_1588_CTL_VALID) {
-		wx_ptp_tx_hwtstamp(wx);
-		return 0;
+	if (!(tsynctxctl & WX_TSC_1588_CTL_VALID)) {
+		spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
+		return -1;
 	}
 
-	return -1;
+	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPL);
+	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPH) << 32;
+	skb = wx->ptp_tx_skb;
+	wx->ptp_tx_skb = NULL;
+	clear_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+	spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
+
+	wx_ptp_convert_to_hwtstamp(wx, &shhwtstamps, regval);
+	skb_tstamp_tx(skb, &shhwtstamps);
+	dev_kfree_skb_any(skb);
+	wx->tx_hwtstamp_pkts++;
+
+	return 0;
 }
 
 /**
@@ -296,24 +333,29 @@ static void wx_ptp_rx_hang(struct wx *wx)
  */
 static void wx_ptp_tx_hang(struct wx *wx)
 {
-	bool timeout = time_is_before_jiffies(wx->ptp_tx_start +
-					      WX_PTP_TX_TIMEOUT);
-
-	if (!wx->ptp_tx_skb)
-		return;
+	struct sk_buff *skb = NULL;
+	unsigned long flags;
 
-	if (!test_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state))
-		return;
+	spin_lock_irqsave(&wx->ptp_tx_lock, flags);
 
 	/* If we haven't received a timestamp within the timeout, it is
 	 * reasonable to assume that it will never occur, so we can unlock the
 	 * timestamp bit when this occurs.
 	 */
-	if (timeout) {
-		wx_ptp_clear_tx_timestamp(wx);
-		wx->tx_hwtstamp_timeouts++;
-		dev_warn(&wx->pdev->dev, "clearing Tx timestamp hang\n");
+	if (wx->ptp_tx_skb &&
+	    test_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state) &&
+	    time_is_before_jiffies(wx->ptp_tx_start + WX_PTP_TX_TIMEOUT)) {
+		rd32ptp(wx, WX_TSC_1588_STMPH);
+		skb = __wx_ptp_detach_tx_skb(wx);
 	}
+	spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
+
+	if (!skb)
+		return;
+
+	dev_kfree_skb_any(skb);
+	wx->tx_hwtstamp_timeouts++;
+	dev_warn(&wx->pdev->dev, "clearing Tx timestamp hang\n");
 }
 
 static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
@@ -841,6 +883,9 @@ EXPORT_SYMBOL(wx_ptp_stop);
 
 void wx_ptp_quiesce(struct wx *wx)
 {
+	struct sk_buff *skb;
+	unsigned long flags;
+
 	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
 		return;
 
@@ -849,11 +894,14 @@ void wx_ptp_quiesce(struct wx *wx)
 	if (wx->ptp_clock)
 		ptp_cancel_worker_sync(wx->ptp_clock);
 
-	if (wx->ptp_tx_skb) {
-		dev_kfree_skb_any(wx->ptp_tx_skb);
-		wx->ptp_tx_skb = NULL;
-	}
-	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+	/* Drop a pending Tx timestamp request. Do not touch the registers
+	 * here: quiesce runs during PCIe error recovery, where the device may
+	 * already be gone and MMIO is not reliable.
+	 */
+	spin_lock_irqsave(&wx->ptp_tx_lock, flags);
+	skb = __wx_ptp_detach_tx_skb(wx);
+	spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
+	dev_kfree_skb_any(skb);
 
 	if (wx->ptp_clock) {
 		ptp_clock_unregister(wx->ptp_clock);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 9454e90258d8..afd980dbb793 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1430,6 +1430,8 @@ struct wx {
 	unsigned long last_overflow_check;
 	unsigned long last_rx_ptp_check;
 	unsigned long ptp_tx_start;
+	/* protects ptp_tx_skb, ptp_tx_start and the in-progress state bit */
+	spinlock_t ptp_tx_lock;
 	seqlock_t hw_tc_lock; /* seqlock for ptp */
 	struct cyclecounter hw_cc;
 	struct timecounter hw_tc;
-- 
2.51.0

