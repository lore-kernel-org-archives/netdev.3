Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB342FFDE1
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071993; cv=none; b=HppHYgtaYOykW/7cymrm6QY4ZcB1h0JqwlzHwE9DmiHl4HECywP6T1lDcYOKMMav+AxGX4QFuMsTaKRTdO5/0WLRgU1AAkEXormjaz0GhaCHXm/+niPKhsygrx991OnXHnKfvg67APTDF4jkXVXgnGgrtwD+aeobOwclDLNjSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071993; c=relaxed/simple;
	bh=oLGJMkzQv+D2ll/KknWw2JVkfwlV69ug8K+E9+qu2ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LobSPUUC5iqLySHstT487ZdtpcQVxa1C++BO6iDiY4ScWvgVR36izk5VbpG/ffeSpvNFyLq/SJZ6aCMsSowDYVBni/oyr+BYW6bYmjm+lNYTPXsaIWQBT4oH3mk+LgrdA90QBF2ue++oTKg5FezGv8yAKmcG+E+LjFpw4tfSons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1781071915t5a7a39c9
X-QQ-Originating-IP: Boc47vuvdkTdl6ASAozJxoUpCXpNcVlaXf2bAi7kcsw=
Received: from lap-jiawenwu.trustnetic.com ( [125.118.31.65])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jun 2026 14:11:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9056144775827947141
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
Subject: [PATCH net-next v6 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Wed, 10 Jun 2026 14:09:16 +0800
Message-Id: <20260610060917.23980-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260610060917.23980-1-jiawenwu@trustnetic.com>
References: <20260610060917.23980-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NvGGTAUhB2iW0XBq2c3bxYdcxPuehoWwvBdA65/gYdRXuOsuaDiy1M/F
	fnQXY/k0xVrYHm038fG21Nea90sxosfH38GEhe1rRHbxwK5ykKlfajPrGHUUprpB7eNNEiN
	0GXxMQ3WcBGS/kkiaGhS/kTQ8nv4qGRcHONWH6lPchEoDbWGWdaf+3Hw6smsywFFatWkswJ
	vHF04JQlC6vGDVILvrVl89op0cWh4HXOm4b1Am3s5TfCkrVw0x/lWx/dV8gu4270N6GQkDV
	jnI6WOna9loRiHk4tfX5omxc5S+/gnTtpspqZwaIRvTwiQGFHFT3OQvXJGqVB0jGcZ3xIbN
	Dm1pW2oG3HT/gfLtgl5wiph1yYt6TR60orpOhrXRGoxF0MO6XeNeoPaXA2FCDlX1u5RaLBB
	zTHCxZviXGqoy8Nb1+BnF/rX8JHbbwSr/J/uegKrsRfLQZ/ObnhwvKXekETSSeu8sqmaaV3
	XSTN6hMaxja8LQ6CV5uTIXKrtGFsdwUDZt25WiwNiaTUzXOBt3YjMn+Pgd6hEYQr7O5ahdz
	QUIxsm0QZb4L1WTmxGIOUxiJCfNShmw/siXB7YxvJMJGjtZRiEkMBrX1O1bvTttddKykxLq
	9ZOr/c0ehpnJyu9TSmag9oMhGQRMRsGc1PCGbva81ZSmmkq1We6ylQNGnYcC78Ui0QTE/36
	cXWnWwmZ9MwegH615WYhvAeqmaRPeHR5Zu8oy5Cd6qLRJgeYb7gOh2Z0YCpEei+Zyt277He
	FJof5IzEnktIaIsIBK2hTm/lZmrwPltGeSD57575Sao2X0Zv0JeWByirixM0X9rXzkdb7P0
	I0Shr2x3o+clvFzxa3sDucuzdokEgU6PZcai5ZPhVJFczVkpDKfvY5eJJx7TSJ5rdxdbK6C
	QnpDxb1vUS7r2GbXATfoAu/ff2rwBhQj8IbHo0TzPIE6nbjgoZ26JL4DhBZx7wWuILMPp+b
	xGzStcDPydpjHMhNbsL1hpjd0yWOAQztrDgMJ76ZRp1bOQ9ZsgeGzd5Vr6SPHdO25sWVXC8
	/SOy18Ze5WXb7ZnxWFxKEdCsoXvWeCiOaavgQ8VT6qrgsusfFtvbKZTdD4z+vnIqc57wG5K
	A==
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 18 ++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 21 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 +++++++
 5 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index e5a45356ba00..c10a3bf5cf02 100644
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

