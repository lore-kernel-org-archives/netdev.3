Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FD3EBF20
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563472; cv=none; b=Mv0w6UMcivQKZK2QeR3smq7lRsRABJnu1vFIlIltMOGEFrHu5SkaYST2LQx27Ae5V1s7Aj9HqHQxJj8TNP1xYa6/NhXHpnjxkIg2xfFm7frSX4SggtsD3i8gfH8RTdad4un1MD6Y3USAP0QOos6a5uxB1dL+ysaBioimlwqduB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563472; c=relaxed/simple;
	bh=zhBjl3ySxU0pFBE3fLa71iaMOdkH0X/z23f8ldUMfz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVnGJr7EnA4owqtVjiSDy8g3+Emkpzl3zIWeEObghYisc8+gJbivUl7JQQUgmqZTRO9aI42fSCOj+xGZ+RoVVprt4whoKh1RInGtjBhdkpIuEhC9pFny8QMfMY1PxNx/BVjZSASn20TKuVjOwDAeGSyErVtPiyNHHxl8Djx8eEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz9t1780563416t06f15798
X-QQ-Originating-IP: xpQ0ovUE+jVvqw9DbAaEfnY1pdd5xr5DPGLzsIL1GUc=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 16:56:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18187349185832705551
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Thu,  4 Jun 2026 16:56:30 +0800
Message-Id: <20260604085631.12720-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260604085631.12720-1-jiawenwu@trustnetic.com>
References: <20260604085631.12720-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OB9qK8spgGSZb2O+VY+Lth4LG4CMhwRo/zLBR6fJQIj/FcJ0KaT6LSmw
	V5cfA0aoJ91Il7+u+S4kGaDmDQChw7frfHR985ndq67Gz5KtxSVxno93FpybXI9micPysza
	Tqd3FQGUIq18EkvLu7yEHpyQp710dPQfQLadChA3XUEsEbuWJma2CdrtZB5lUpVPm+tpYEo
	YwJ8fynzi4Hyy/l/8p36ykOu5o1+rW6GBRu+BXryyZ12tMdaLR3WYMEIeA2vTk36yDDt1Cn
	oLWO8Hu8I03z9V2/egkfov0KwmwXt7RZV0VzDAq8yATo1eyBTJgm8SsvBTq32IfgiSPHllu
	9oTpY7F/g3kwcClZZjnXE/imyr8MoVdKMNtUm0QFXZqR06QEFD2nRlZkMgIe252+HHmvZDE
	av5C1EM0mbMSIbKSS/fiNXE0dUgXCxiq9DNP/EvAKVd0L+VBidaYSAJRisijS/X2Anx4+Sl
	EgcLXb4NI+xu4tlVyNtseKbnk2YNfqc75s9S2p98HwoMQr0Pyo2Ltle6NqxAws7ZsYZlo1L
	H3kAd8fZnzXw+og98oywHoKdR5zufz0MS2naIQs7I8i/VO5kgwPX/pUyWaho9vJY9l3LCrz
	Alefv+Ws/LyKCF8WJDdUrTSpW5tcZ5da4D4ZyF8/i0HelAuIN/XHLk9TwNtbLkhIaBH7//r
	g1dyZfrS5r0YyayVlwK9g9ynnrwnfDGTHcHShJKDVNtrsQz/KLY77JlqWGwZ+YmEC3nvdhy
	5FRO+eYdHsw8WLjfb+QFL4u9oy0sMR9k3axbAOqToFT+7j6CbyXjSngHgJw7tIjvKhMx6mW
	tuYVMtR2qRv8FYzluF+F0dcrRX0DRCngfvMe5HAR2RMoqFDZ7U/F7gT3SNRGyVEFvlsJtIm
	CTITSA0qi+RNwV+PQdcbhhJGhZVlrbMS2OLPs1+93x+8dGWjdkvjNlg/eI8VDTPidjRAM3k
	DevXGF2W1fN5HXAa0OOF2u1DrL/bcby0nlcQYg2XpXA4HxEEQsmZtrzY5DVnrzf/PFssEBf
	vOCToMBwqDLlOyP5kC5NQAarRT0ASlFfSoH1+kvXAUJNaMcBMJgFpKYHjH9HlpnZtaRO85d
	LccBeEsK7QjzvZ3X1Je0JKolmM/oAO07gmMRM1HNBVrd9ZkyNgb2N2TEqs3rkuGKw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Function wx_soft_quiesce() provide a lightweight shutdown path during
PCIe error recovery. It avoids MMIO-dependent operations in PCIe error
status.

Waiting for the service task to complete may unnecessarily delay PCIe
error recovery, especially if the work item is already blocked by the
hardware failure that triggered AER. So the service task is not
explicitly cancelled in quiesce path. As a measure to block the service
task, the checking of WX_STATE_DOWN and WX_STATE_RESETTING is added at
the entry of every work item.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 14 +++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 21 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 +++++++
 5 files changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index e5a45356ba00..0667eb1fe5fe 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3382,5 +3382,19 @@ void wx_service_timer(struct timer_list *t)
 }
 EXPORT_SYMBOL(wx_service_timer);
 
+void wx_soft_quiesce(struct wx *wx)
+{
+	wx_ptp_quiesce(wx);
+	pci_clear_master(wx->pdev);
+	netif_tx_stop_all_queues(wx->netdev);
+	netif_carrier_off(wx->netdev);
+	netif_tx_disable(wx->netdev);
+	wx_napi_disable_all(wx);
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
index 44f3e6505246..dcc8b3ae1445 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -842,6 +842,27 @@ void wx_ptp_stop(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_ptp_stop);
 
+void wx_ptp_quiesce(struct wx *wx)
+{
+	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
+		return;
+
+	clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
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
index 9251e7a1d416..f6e596eb9217 100644
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

