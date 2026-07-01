Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D803B7B9D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890728; cv=none; b=k2eaSYdesKp5Sj7yvkNItgb1tv5EmSAtSZgmUXnkTAf2zLJhCANC71wurKiHSKHEUn+oCg37hXPzn037TJFrSlJu3FwGM7hBgFHA+XWpHog3jX+aJ7wWfbqTg982OX7qFl9aNb/GvZSjOzxpOiH4OHxk5PndrT8mY7TfW2ZP6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890728; c=relaxed/simple;
	bh=zqHowAzhs2bi2d5TO10xwmVnyu1fc5+x0DvQs5HDKJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZaiicF8eSHyFHEv58J/qqTVUz0sNXqB28VJJP/Muw3Cm1mn/0QcnvpAItafl/0x4PttBnHFUY5j8sTedz0YLmkLBMmpus4sVqjF7CYTvIK1XVvvby5cu1yBirIxz7HAi5XRgFqvLEoWahqcVc2yycJL9xIJmUkaXBW085lntek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1782890670t24b44925
X-QQ-Originating-IP: 8TAiIii339m0LUj8DM1Ns5Rp90Kzj9z0bAzM+acFzgk=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 15:24:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4564737909176838863
EX-QQ-RecipientCnt: 22
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
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v9 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Wed,  1 Jul 2026 15:23:56 +0800
Message-Id: <20260701072357.33984-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260701072357.33984-1-jiawenwu@trustnetic.com>
References: <20260701072357.33984-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OS2Sqn570Cer42BbLwufC4455l61im7fOHE1K5zS6Flfcta/kWFuqWGr
	YG7cEI+JgjQoAE7kHYpPvjMBZm7VHBeDKMJzR+F8UIfcRkniTKxaeIzZ5rf1hO8yZx5z84E
	v8ugDkHod2d84VCR0UgQXR6OTXZM8HGbcj5Ooo2KtlWKFsiJ2Wkoby6yOmRSuQoh3apjHqz
	tZ+6HEKFRAw9XhSmLrRhtQrnf0cwZIRL4ZZjPe2of9d7asF8C581qUBTh7J17aThKq3xRrl
	xR6B0rzuV7klQd16bkpsKf2p35EqeQ9hCV2ty/O4JsLX4A8jANDXDzIJMzcGoADy+W2vOKf
	x2Z/H4F7B40klA5eF+TLXBLYQjBHfVfXGVNzYDFH1cUQN3lz4rQdpv5AKssLalcUCQo5Ysd
	FFBoxXBJ3OsMBL1igVCzTxCN6IIhnuGBbO6d3y8i8mJJwGFnmZM+fiBMzUYtyV7k94X624Y
	koXCSR7J0tYvdg8+FVHpFt6qrvRXVDOjaNbB8YYw3QFBoKo3qoMj+SRQsq8NXrRt8YIWYnV
	mw96r+B8yRs675T6WBnzGunFUFywHwlY9cfS+/mXYN0u+d/IhLLy1afHvXKu96dcGzsm/zG
	CUFyH5wdI+27CL9a9BQDT+1yqwmHOKENZ7Qns3/YU5PPZ/BPAahl6MpHwXm21gv7BncGcbt
	0cbd4FpiGIt6alAi8NHbyGnctNbNarcAaB9NIt63Z6eX7NOgoukrAcpkcMaHKQouYB+a8XT
	sAZYzj6wb1OWSHjrkNiw9G73yvogp7KY5hNUqFiGxfbWH7bgruRIxUgO9XTqjEWPgwggNv3
	aP7TbGHZP6lH3E3mIPpBmXzyAI3IyylzgjeIIIQ1dOGVyQdCDKRYh+UBmasysBXeQf3Mn/t
	CoaOS4cjfH9lhyvy7Oy40y3VcLpqbMef+h2kc2UZZJcdftwTzs0HxPuYUjj6G69awvc+FH7
	d2C1FVmY/oLVh+R+19lNA3kRaiKYOOwFLlAuafBVF+QdSfQCSom50hIkCk4CBvMfHThngOE
	sdUzPvxC2WxgdSZ4h6v9s1FmFViAiqbrz4uy7LNS2pUQyZ3oYYbU4AIRHrzYLXjwqSzy6qz
	eepzP1v/8i6tBfREfdaXoLzBT7nxfbrxvWwYtxUP8T6QuGwon4qkP9LvafE8p1UPg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Function wx_soft_quiesce() provide a lightweight shutdown path during
PCIe error recovery. It avoids MMIO-dependent operations in PCIe error
status.

Waiting for the service task to complete may unnecessarily delay PCIe
error recovery, especially if the work item is already blocked by the
hardware failure that triggered AER. So the service task is not
explicitly cancelled in quiesce path. As a measure to block the service
task, the checking of WX_STATE_DOWN and WX_STATE_RESETTING is added at
the entry of relevant work item.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 18 ++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 21 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 +++++++
 5 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index e5a45356ba00..d3340b2b0682 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3382,5 +3382,23 @@ void wx_service_timer(struct timer_list *t)
 }
 EXPORT_SYMBOL(wx_service_timer);
 
+void wx_soft_quiesce(struct wx *wx)
+{
+	if (!netif_running(wx->netdev) ||
+	    test_and_set_bit(WX_STATE_DOWN, wx->state))
+		return;
+
+	pci_clear_master(wx->pdev);
+	netif_tx_stop_all_queues(wx->netdev);
+	netif_carrier_off(wx->netdev);
+	netif_tx_disable(wx->netdev);
+	wx_napi_disable_all(wx);
+	wx_ptp_quiesce(wx);
+
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	timer_delete_sync(&wx->service_timer);
+}
+EXPORT_SYMBOL(wx_soft_quiesce);
+
 MODULE_DESCRIPTION("Common library for Wangxun(R) Ethernet drivers.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index aed6ea8cf0d6..11bd79985e17 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -41,5 +41,6 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 void wx_service_event_schedule(struct wx *wx);
 void wx_service_event_complete(struct wx *wx);
 void wx_service_timer(struct timer_list *t);
+void wx_soft_quiesce(struct wx *wx);
 
 #endif /* _WX_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 44f3e6505246..a25eb6aed566 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -321,6 +321,9 @@ static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
 	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
 	int ts_done;
 
+	if (!test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		return HZ;
+
 	ts_done = wx_ptp_tx_hwtstamp_work(wx);
 
 	wx_ptp_overflow_check(wx);
@@ -842,6 +845,24 @@ void wx_ptp_stop(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_ptp_stop);
 
+void wx_ptp_quiesce(struct wx *wx)
+{
+	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
+		return;
+
+	clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+
+	if (wx->ptp_clock)
+		ptp_cancel_worker_sync(wx->ptp_clock);
+
+	if (wx->ptp_tx_skb) {
+		dev_kfree_skb_any(wx->ptp_tx_skb);
+		wx->ptp_tx_skb = NULL;
+	}
+	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+}
+EXPORT_SYMBOL(wx_ptp_quiesce);
+
 /**
  * wx_ptp_rx_hwtstamp - utility function which checks for RX time stamp
  * @wx: pointer to wx struct
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
index 50db90a6e3ee..ad2f824875d5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
@@ -10,6 +10,7 @@ void wx_ptp_reset(struct wx *wx);
 void wx_ptp_init(struct wx *wx);
 void wx_ptp_suspend(struct wx *wx);
 void wx_ptp_stop(struct wx *wx);
+void wx_ptp_quiesce(struct wx *wx);
 void wx_ptp_rx_hwtstamp(struct wx *wx, struct sk_buff *skb);
 int wx_hwtstamp_get(struct net_device *dev,
 		    struct kernel_hwtstamp_config *cfg);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a8773712cff8..a7bde03a98fe 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -94,6 +94,10 @@ static void txgbe_module_detection_subtask(struct wx *wx)
 {
 	int err;
 
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
 	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
 		return;
 
@@ -107,6 +111,10 @@ static void txgbe_module_detection_subtask(struct wx *wx)
 
 static void txgbe_link_config_subtask(struct wx *wx)
 {
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
 	if (!test_and_clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
 		return;
 
-- 
2.51.0

