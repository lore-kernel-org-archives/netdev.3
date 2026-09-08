Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1D3A784E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855138; cv=none; b=QI4YodTdJ+QH0jRd2qvlNBmUmdLN70eq6g1QtMe6YtPoExguN9/xtuc9ncJPlYt93d+U78DR6uic/49WJ81HXmSIDVXM5ECTKTZQQJp8GDxqJ/nEVgoU9Ku+6MVy98xcZVip74ncJwWCgvUSaEVzn3HXcCux+8ExcuAq6ZPNYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855138; c=relaxed/simple;
	bh=7764vH9jNormvAXGPz5PMmC5DfSlGFBNJcC0JgqfM9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIXT3X3XgBq0w68jD16wuXGim36byyX90x2enUmSOOq8rXB9lJZfvDPjz9JuhzocnEAcnVCcauNaOivaROPT6v6CKrPnA9sE6L6Lr32fVHG4TPjGh1xmtypmm2jVQv5mde7S3xE5jboF83Isv/gvTPLkLBfU2xI9pW10xPEPsr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1788855114t40ee174a
X-QQ-Originating-IP: wkepkfJw+zyxCs/8GirMU9Navv069OPcJoS5uWc345A=
Received: from w-MS-7E16.trustnetic.com ( [36.24.66.61])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 16:11:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2457652173227223468
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
Subject: [PATCH net] net: libwx: fix races in Tx timestamp handling
Date: Tue,  8 Sep 2026 16:11:41 +0800
Message-ID: <8F4D34F6863177CC+20260908081142.86235-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N8Jy6PtD39R8ftL80T2PeddpGWL+tfatchDuKMwu1DoFvNND27yM523U
	bTfi90KcpsafOj5xjhHVRARzkuTGLoWlyv5vwL1d5Dv1UjSvZJkFNGqo6TaI8gAXIdrt3KJ
	pLWRwg10hWiFCx6noFArDkj7zlkBYsOlRZsesHqJ3JtSLR0ziCFlQx59H6Ge2R3lp4lxNNF
	t85XslD9SUlFgv1PSXQGiuTu6TgLnrcxG3Sohp48H2sLRHQThWmBgAsu5w44BZberx9nkYM
	gcu+gwdQYnSNIzOcrlbMZtJ2YoFwPUZoKuoWDeHfpRDXAtnzYI2uAenV2g7FltpI3fKmxSR
	YeGCfpOMaU+LEIaTs9Ua++oTRk87iRMeVoKtqiayBAOB0O88BMWAtW2qlG3HP+ZJpDepjZy
	nO9/httflolNyMIjrzBTJIhXNlmtNQyU3bbsQoa92AzmyHEqYIx8+fvwnffwd0xwQuyE6b9
	RgA3fV6Tec0X1CjO4/IwptRKaDNvp4TdcaeI9N9ZMy0iPtqKgiyoLi7c2rWtuGOhHIcreiY
	pifITGUOF44u37/zYquyyl6rFvq4KMVQVjJvlZRencHkYx9hpmV8i/JlVAUXKjqteb2suOQ
	PoDkcPwxRQu1nT2cuHFxrgF0TdUlZxwT0hSBTvM8PRF1AZUorOlsYbae5+Ug+xaJAg/8eBC
	1vy0KDVzJyn5rZNQKlGnWxY0g9ee9hrzff2dv+l5dSOj0CL/kIjE7vXRdSf0wH1fRZ78f/2
	FD6puEVvHYwKNOzjL4L1PJTasTG09q9jJa3KGizAih5+sTP3Ymj0PiS+kQQgkKSN6e4VxVK
	KR6MnJra1TAIlDoolDNxpUfEL0611kFwhF7fPho14ss5QtFfVisT/84mC5LcAjf+4T+helB
	rXWekJtuEGBiDZtO3Mcg03trTEBL3bk69q2p7cNM+ItS+C5u+EOqa9dgW370qu9UBWIu6ph
	2CGJpdej0UwhgzteChe2nAYmg9sg71H29CL0qzasBxKiaNkJuR0nrzLPmz7/efb1LUb62qc
	6kNgQe1syGTjkVnhCU5P6oOOnoqa+m9o1LzAq1iwkocDdv0Nz56im/8kOgA90ZdxqTw9rB0
	EEr0C1tyE1ldcseYXMOnJE=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
after dropping it.

Also verify the skb identity when handling a Tx DMA mapping failure so
that the error path cannot clear a newer timestamp request.

Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/6C7EC12D69217315%2B20260818074721.45536-1-jiawenwu%40trustnetic.com 
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 16 +++-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c  | 93 ++++++++++----------
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  1 +
 4 files changed, 63 insertions(+), 48 deletions(-)

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
index ed5aad7857bd..9118813334a9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1612,6 +1612,7 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 {
 	struct wx *wx = netdev_priv(tx_ring->netdev);
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
+	struct sk_buff *ptp_tx_skb = NULL;
 	struct wx_tx_buffer *first;
 	u8 hdr_len = 0, ptype;
 	unsigned short f;
@@ -1649,6 +1650,7 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 	    wx->ptp_clock) {
+		spin_lock_bh(&wx->ptp_tx_lock);
 		if (wx->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
 		    !test_and_set_bit_lock(WX_STATE_PTP_TX_IN_PROGRESS,
 					   wx->state)) {
@@ -1659,6 +1661,7 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 		} else {
 			wx->tx_hwtstamp_skipped++;
 		}
+		spin_unlock_bh(&wx->ptp_tx_lock);
 	}
 
 	/* record initial flags and protocol */
@@ -1685,10 +1688,17 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 	first->skb = NULL;
 cleanup_tx_tstamp:
 	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
-		dev_kfree_skb_any(wx->ptp_tx_skb);
-		wx->ptp_tx_skb = NULL;
+		spin_lock_bh(&wx->ptp_tx_lock);
+		if (wx->ptp_tx_skb == skb) {
+			ptp_tx_skb = wx->ptp_tx_skb;
+			wx->ptp_tx_skb = NULL;
+			clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS,
+					 wx->state);
+		}
+		spin_unlock_bh(&wx->ptp_tx_lock);
+
+		dev_kfree_skb_any(ptp_tx_skb);
 		wx->tx_hwtstamp_errors++;
-		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
 	}
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 4708e7f3958f..a0929b4844e8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -139,12 +139,16 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
  */
 static void wx_ptp_clear_tx_timestamp(struct wx *wx)
 {
+	struct sk_buff *skb;
+
+	spin_lock_bh(&wx->ptp_tx_lock);
 	rd32ptp(wx, WX_TSC_1588_STMPH);
-	if (wx->ptp_tx_skb) {
-		dev_kfree_skb_any(wx->ptp_tx_skb);
-		wx->ptp_tx_skb = NULL;
-	}
+	skb = wx->ptp_tx_skb;
+	wx->ptp_tx_skb = NULL;
 	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+	spin_unlock_bh(&wx->ptp_tx_lock);
+
+	dev_kfree_skb_any(skb);
 }
 
 /**
@@ -174,50 +178,43 @@ static void wx_ptp_convert_to_hwtstamp(struct wx *wx,
 	hwtstamp->hwtstamp = ns_to_ktime(ns);
 }
 
-/**
- * wx_ptp_tx_hwtstamp - utility function which checks for TX time stamp
- * @wx: the private board struct
- *
- * if the timestamp is valid, we convert it into the timecounter ns
- * value, then store that result into the shhwtstamps structure which
- * is passed up the network stack
- */
-static void wx_ptp_tx_hwtstamp(struct wx *wx)
+static int wx_ptp_tx_hwtstamp_work(struct wx *wx)
 {
 	struct skb_shared_hwtstamps shhwtstamps;
-	struct sk_buff *skb = wx->ptp_tx_skb;
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
+	spin_lock_bh(&wx->ptp_tx_lock);
 
 	/* we have to have a valid skb to poll for a timestamp */
 	if (!wx->ptp_tx_skb) {
-		wx_ptp_clear_tx_timestamp(wx);
+		rd32ptp(wx, WX_TSC_1588_STMPH);
+		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+		spin_unlock_bh(&wx->ptp_tx_lock);
 		return 0;
 	}
 
 	/* stop polling once we have a valid timestamp */
 	tsynctxctl = rd32ptp(wx, WX_TSC_1588_CTL);
-	if (tsynctxctl & WX_TSC_1588_CTL_VALID) {
-		wx_ptp_tx_hwtstamp(wx);
-		return 0;
+	if (!(tsynctxctl & WX_TSC_1588_CTL_VALID)) {
+		spin_unlock_bh(&wx->ptp_tx_lock);
+		return -1;
 	}
 
-	return -1;
+	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPL);
+	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPH) << 32;
+	wx_ptp_convert_to_hwtstamp(wx, &shhwtstamps, regval);
+	skb = wx->ptp_tx_skb;
+	wx->ptp_tx_skb = NULL;
+	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+	spin_unlock_bh(&wx->ptp_tx_lock);
+
+	skb_tstamp_tx(skb, &shhwtstamps);
+	dev_kfree_skb_any(skb);
+	wx->tx_hwtstamp_pkts++;
+
+	return 0;
 }
 
 /**
@@ -296,24 +293,30 @@ static void wx_ptp_rx_hang(struct wx *wx)
  */
 static void wx_ptp_tx_hang(struct wx *wx)
 {
-	bool timeout = time_is_before_jiffies(wx->ptp_tx_start +
-					      WX_PTP_TX_TIMEOUT);
+	struct sk_buff *skb = NULL;
 
-	if (!wx->ptp_tx_skb)
-		return;
-
-	if (!test_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state))
-		return;
+	spin_lock_bh(&wx->ptp_tx_lock);
 
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
+		skb = wx->ptp_tx_skb;
+		wx->ptp_tx_skb = NULL;
+		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
 	}
+	spin_unlock_bh(&wx->ptp_tx_lock);
+
+	if (!skb)
+		return;
+
+	dev_kfree_skb_any(skb);
+	wx->tx_hwtstamp_timeouts++;
+	dev_warn(&wx->pdev->dev, "clearing Tx timestamp hang\n");
 }
 
 static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 9454e90258d8..6b9460147ca9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1430,6 +1430,7 @@ struct wx {
 	unsigned long last_overflow_check;
 	unsigned long last_rx_ptp_check;
 	unsigned long ptp_tx_start;
+	spinlock_t ptp_tx_lock; /* protects ptp_tx_skb and ptp_tx_start */
 	seqlock_t hw_tc_lock; /* seqlock for ptp */
 	struct cyclecounter hw_cc;
 	struct timecounter hw_tc;
-- 
2.51.0

