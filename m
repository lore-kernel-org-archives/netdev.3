Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8F27603F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739471; cv=none; b=Q4FPxPTMR8hezHoAQFFceVQXCVDC2vRIZvVe9O7Rk0pdBWZlzaEaR5g871EppMgJlvlDkEA6SMuJbpoDCwDxh53u7ymqwY27D5rOj/NSuXOOGILEXnc3AVTJUZ220qe7NokT4xN89iFbiyoClhTjL/FGw5Q2RUEjN2RRdTWwRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739471; c=relaxed/simple;
	bh=atgdLSzIhiQoUh6tVUnmBaJSAlTCrOqB7c7uKoGn+3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5hcu46GQQkRfigtIUPvJ5u4RfL0R0KLvXdZG9DpQrfPnSHm7+NNAd1VUoCVFG5zu8TigXzz6pNcoo9dRwZyEE1/nXDlzHVHPQREX3VcDnAzy/ecRK37IKFuTf8mVWg1xgvTmEVNj1c/bs135ydB8396H1/ihm3v0kd13tcxJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz10t1785739432t41156f2f
X-QQ-Originating-IP: RxWexDzZkMAynwWRj9bDkgePDJRDD0twSpGK02PFhBs=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 14:43:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16123786121465675644
EX-QQ-RecipientCnt: 21
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
	Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Joe Damato <joe@dama.to>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v14 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Mon,  3 Aug 2026 14:43:33 +0800
Message-Id: <20260803064334.21876-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260803064334.21876-1-jiawenwu@trustnetic.com>
References: <20260803064334.21876-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MIBXG9KNq+3GR/fhiXXVXVucyRmpRtsEK1a5p15ga0G+4qqUBmMxHqZW
	JaF8TNQobFi0J/smqzBHlk0UyjByGK60dwTxOj4L/+zbTZBChzjfUr+nlBu51ro3UBVfDuk
	2qFy/cFbeeMVTdKa6Xj0EHktNITMukGUUpRWOG/cAIVauYfYm6CfO4yhe9bpcMoQcP6b6Ly
	A6NM2YBy0A4k8rwcW4+F4ByxAsSPHRYyGKptAF9aiN5DjF/UYfufEeGrk92rQnXK8r6FOyu
	IVuZXB/LeSJj0Ji6Gkd7zYY//V5WElPEr6APqOGXAnf0aOxksKB8DC1FkwBlJCY6XRVLWFe
	TjyXDAUTSWsOOhONrgH3M+k+cpQ7ZQCFp7h9LVTJjyNxaWoCTIsYBQd4GI/uwhycmyvjqOR
	UHzTyFqMCz/jJb5wBBh7qbjgvGOQ/UtYUZ/Yluq6vm7cYGfDM0qB+xvSjk76bOaH5nExh4P
	X3G2cvKXYbvQ/7dfJvLlmCzZGXfv473nrXTD0NyxjYToQu7A5D1QBOsXXadBahxzsh04GMt
	M3qpi1RqUdrPQmO9bSYgAtJ7Ls6HGx51D8ODI+qP/s2wwd9oa6El182aAo9IynCm6HP0jq1
	r1RRph87Q1LWuzwlFaaT5TfI7en5ZRJvfuUzOc+VP6+06VfGycDfD2bo0j5cvHB45YbxO+T
	YKzyVBtWyup4tds5AKA2ZCOX9iTjPHu79hKNESwkmxiQjYokEv98/tYnDZrMFdAbs3zMrnR
	eHZY5nEoiiwzwv9U7sMfS/abJDasB2iWSOvTniNjocV+EwpZH3OQdEPTThX+uENDZZuS7xk
	bR3yZSw37weeh33UocBxwFh6URf3UpMaU91hfX0LrosqvsTC9TXEmWyHBlBVKBNHW6SvoqF
	Pkrd4XGol9zyIB/YevWVBmhAHForHFZv+3xEz5CD3hu/PAEC0KtsSgi6hflK9yiQfIpcZKT
	XSnW0w9ji6Ny3IWkK3jvYZiBvfiJ3VJsTcC36zgJ0BTGY8Y8FxTXM1I26WkPM28i0UVPIGj
	VGrxbm5rMNPtDuyrcB/2maTw3qRQA4GbcxaVUWJ/rqHEBVvdV2l9b8tG1elru2sgrWCmXgu
	GKrl32Roe3XY8oACCcCsq2pzG9VtAsoepz8R/UM5dzBLf8e3czUHKs=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 18 +++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 27 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 16 +++++++++++
 5 files changed, 63 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 67af8640a49e..ed5aad7857bd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3410,5 +3410,23 @@ void wx_service_timer(struct timer_list *t)
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
+	clear_bit(WX_FLAG_NEED_DO_RESET, wx->flags);
+	timer_delete_sync(&wx->service_timer);
+}
+EXPORT_SYMBOL(wx_soft_quiesce);
+
 MODULE_DESCRIPTION("Common library for Wangxun(R) Ethernet drivers.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index bc671786978e..9d85d399e17f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -41,5 +41,6 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
 void wx_service_event_schedule(struct wx *wx);
 void wx_service_event_complete(struct wx *wx);
 void wx_service_timer(struct timer_list *t);
+void wx_soft_quiesce(struct wx *wx);
 
 #endif /* _WX_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 44f3e6505246..3eea647c4742 100644
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
@@ -842,6 +845,30 @@ void wx_ptp_stop(struct wx *wx)
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
+
+	if (wx->ptp_clock) {
+		ptp_clock_unregister(wx->ptp_clock);
+		wx->ptp_clock = NULL;
+		dev_info(&wx->pdev->dev, "removed PHC on %s\n", wx->netdev->name);
+	}
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
index f25249ddf2c6..414b2ba8dfc4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -94,12 +94,24 @@ static void txgbe_module_detection_subtask(struct wx *wx)
 {
 	int err;
 
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
 	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
 		return;
 
 	/* wait for SFF module ready */
 	msleep(200);
 
+	/* Re-check state to avoid racing with down/reset paths.
+	 * Module identification is deferred to the next up event,
+	 * so it is safe to bail out here.
+	 */
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
 	err = txgbe_identify_module(wx);
 	if (err == -ENODEV)
 		set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
@@ -107,6 +119,10 @@ static void txgbe_module_detection_subtask(struct wx *wx)
 
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

