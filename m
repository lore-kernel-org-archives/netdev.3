Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771C25B082
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478785; cv=none; b=Y4E1Amg1epbjXXCBNu8m6iYMSPc5FeHjjkvPy15rwJi7c56qyQCiUiQBphtOElo5bvrUQRt6/j+mhrlsg9DfU8FuI39bCOCX6eyET19kGcKvWONNoQhxdGendB6WiP7hdsDu4au1fruoamLEjhceOObtv0dCz7R39aiXzYKBKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478785; c=relaxed/simple;
	bh=th49+m0WYExbcxHe8V7zKCIYMiFYBxHXb2HQk5HnbmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ofpd2G/ZVvVMFgtv6EZrIzGOUOQivkjadTbCEvV+9zoaBgMLhR0djiNesi4F7hzxSwC6moqrSO3qtckDXrtFp7d+p7sEdWyCsi77ZSuWD84K95mW7nFerQ8BTFaBPUmwGYHiGNU2SsVKvJlzK+2cJEb515iVh3vqibnr8/7CVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1785478739te9cd11fc
X-QQ-Originating-IP: puPVxjxcso2/LajEj1O7qerVemInbZ5OYJ5S8YqR+DE=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 14:18:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4706500170331659947
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
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v13 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Fri, 31 Jul 2026 14:18:36 +0800
Message-Id: <20260731061837.12672-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260731061837.12672-1-jiawenwu@trustnetic.com>
References: <20260731061837.12672-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MQZgAqo1fbg5Ehx6hSNTWF887trNvYEvGiNdtWpmtbAFM+1UlqnI+v7/
	ub3d7uKlpUOZr6bGWLusU5bYk/odwitrJi+YTl9guQjTQZOOvTMMzwZDkaGBsLTM6XnC0nl
	aUBx8qJxDwMJ0QcQIsk7OxCVELrAe//W8Sg7EIuB+Kx3MYPqV3d+vUiNJWoSYPDyhFEiSPC
	ml3E3PB0NdEp9tZ+bJ85buRGid7jw/UiZy+wh1L8dmKUZU/K/7oAT5f27cKAZ19EmfvYO5r
	2c90cIHYQ7pgkTV43oN+ytXPGwn9tGNZf5i8Hna5p3j2S0htvvHkrQrpEWWZxf8BdNv1oQ/
	P9VzdB93XHQegyBATeZ7aYHdJNMunsVgq+kit7SyiYojiq26ouS8M+R7xpdCGeSzZBygdMm
	iVtulNUBMmVPsMmRxchEO8pi6pIah2oTwQRcOWsc0Igfe3vVAW9YoiLz06YJgofkoPwK3j6
	xXAChMO5jmYdUJXjfgquewBXu/Br0XkekMH5n2aZwownX/XzKpUy6XGhErU86jjTAisngMk
	ZsYrSg5SBCoxxuIkkouVIJgq1bRwyKbVZk4VBcMrIkScMGX3tQOCIG9GxagBCEeggh8XEfM
	/LUsWPQIGb6wRd3DK6H2JZIZMCtz5+bvfuQhFcFXazICotWkTL7ikt6Vlfaqk8eZRZNJnM4
	cOvK0oS1IWnViKLDIO53GaNT5KO9Btqkrdsy/jefKI7XPtNjy0+8GV4+gowbwc5XDnj+71v
	T2NSIbaoyNz/h253sO1tExOM4ucna4obPXZ2ALcTjOIhhBM3BznwK6mTXJzmNuC31sNp8HO
	FD3S+Xuz44sykp8tG+sZGpQi5nV6uQtjsTBx0L9LICbN/OPtxgCmtpUF84XAmOtisV5fhub
	VCvDeXUwpfl8RGoc7S0SjWWqcNVUeOuKU2JfbtVS/tbHIdZsIwBxjgvGa/CCOS8D7KIioMA
	OF9ToI4zaKb0kDw7SXx4FBnwLS7H1bVfPSv2KyjrenseZlx4gWCZi061SVN8u1egpel2eN1
	nlp91AhFqK+qciPosTUqtUZQTlEDrhzdjNWUmsvQ6ZdlBTIWGBp0eE8zKXFTnhYAJ1cJTVC
	t2hW2qeOrZhh1tKpWOSrp4OKcuIStshsOHPcRRW89v0AOG9VsfFOHAmStlXFHFbGg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index 67af8640a49e..7e1ce08a797a 100644
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
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
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
index dea5506dc9d2..11ac4b04f5ee 100644
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

