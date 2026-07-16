Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598F3BA22E
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187575; cv=none; b=HMzSUWF+MgHJsUoZsdXR2VugZuXH8jwdlspOf+KpWsAIKDwYKsqdMF+H/RgvGCG2M6+oh0O0oZZYeEBFwHNqZzwnHM+5gasfutclZNpTgftJPLqV4fP9NeWRXcDx5xFbuMnoAZ9aEIwvyYDkOwEHIGJGRHbpAA6TfWJAqkeh/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187575; c=relaxed/simple;
	bh=+D2QHY6I425xEs+cCUbTONXTENon03LuxSA6KNXCtFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onincc6DtGnECHicC/3jsv7XoKyoIaaaffWpVgYTBgiXB+hOXlM0lY+G+rQbCk9vNkDcn2OREBgb4/+WCM9joGQ30IHLbAa9D2YXG+kZtj1OhXPotbdQ0VkNGDRXKmHGXdDPLSyvCoZ/nqjjg+0p2oGlusPOSODkNdh7fTzyQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1784187524t7ba3506b
X-QQ-Originating-IP: cAApJt7LUwkkkJuaNg/8Qt8mufKWP9ESnKMy8VaNR6I=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.247.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 15:38:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4305915322469834997
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
Subject: [PATCH net-next v11 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Thu, 16 Jul 2026 15:38:21 +0800
Message-Id: <20260716073822.24356-5-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NPGD67rP9LS2i2DcMHXlHlkQE+SCACMo8GQ8KEfoAgSzdPQ/DdpAHwq/
	Dvqc3inH9x01qCttVsT8XytatgIV3B6hbDIxkJgwTQBoH7Ta4S9s3bRXdQygAWu7Sbrvhxi
	e2J0USrdRaRBgRboNnrdt+hLU1SMCuiFmw42Fbpj7FCzgLuLJvkwmobtUnSdnsX2VvLtp5W
	ZAyluhvE/9a0kIU8b89PclVaPkAULspF0kXpuPAW2VoiiRiHB7rLc/YA9jvuozzIwzxkS4Z
	tfxevAWNU+E8iK+C76gwSmlCN5blHJ/tD3o/BbToL6AR3mHkqhKeEZLZwuo8xcl5kXFQ8S7
	92NK01QCmuDt4BpiNQDX7G5I/mUaux8e1cSmn0deaRgz6Ve5PQk11znxigmLCgbm19LMCAI
	ccrvjh0PkHGHd9bkOzP0VYNrkcBtxgVIjhqATzat0X5n7bt9vVdz9MZGDUQ5FsD1RUT5tY+
	P9HtReuK2T6OvBmqFWsMhRAgSFHpvQ0ZK5Ok6oG5GdLWS//IZ5uhpwWZeqzXENB7L9Texgq
	GTHi8Dwo65vYOjStgob2zjpWBO5/jw+wKgjSRLq+noBpjf00cUZN52Q6KuqmLZIdj/ETJHz
	RB8g5r2o1bi3Wpmn5qHMR5nvXU3vi4Xkb1zQ0S/efVDIChXlcbUw/3m36nqQ1MxMMdyNX8k
	I4P0+9uo36vHdsdP9QACjf8Agi8dMAkVe2EtgP90AEa7e1DurTE6cxS6xiUXnUT7Yqk/mlK
	r4gpJ/D7PKX913uDPd6zPwQYGETGVndMsrX5edWUbl8QcaOCOkab4sye9NgySd4fc+bMy6k
	agERt3yC6hc5SgfxrRrinx4peVzMF1gUsquZdK10tIOerOBLJs20xXrGBMuNK2rMPeXGzrb
	nnTdPy9MOgOC6iBY4r9q/A4+9hEFcUa8Z/2yUiIewvjKfgEP09EgDj+M9XvzAN3LqdoV+Ej
	Sybd0EFcTStrv+Y5pw3eCpswvfCidLJpmk/IpsDixRV2a6mX9ja+4wibpFTyftVN8YoAvwd
	XKvS6AWMZsvISL7fcOE2MylTdP8azD4sSUz2OLgqpLfSwfpgpdbZzgQqITsQND40d3IcXSb
	WXYokbAP9ewuJ0jFgsM2ezryKzqsS/93dI38xGXbwmbgkYxf5EzZJQ=
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
index c8a4822d3819..a65312c8078f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3383,5 +3383,23 @@ void wx_service_timer(struct timer_list *t)
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
index a8773712cff8..7a05661b1d80 100644
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

