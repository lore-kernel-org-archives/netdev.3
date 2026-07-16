Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E33B95EB
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187575; cv=none; b=MIwwmwsYf4utRn5iUe2UeGwngvrJriHjaIFuiIdEZtOQQdh2/ggy5H8PzjRenJbQ0kfAFfo8/FiJ45QvHmpTzu+7m0QwLSmVU8BQGYD6PrbZhmWX7FWgqf93Rs6D7cLHGoLOqW48gadXlUDIyZFk3tVCI3fFcQMUePQ3/GgGuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187575; c=relaxed/simple;
	bh=EvvfpDR1ueywOGGlT0hdL/STo1LPPd31QrFqm2pqmV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgCrcY2H8J4x3u9XD/70IusXXa8zD1ptWI1DB+vaideOEQoOC6Gv2O2gQ+7sKQedie7MofvNFn1eYSYCAMqwLiNB0P+XrpzR8XdmpEoAfWZ9C9Q8AK1KutOSGsJIN6SRIQMJVUvpt8SFFWmvDs3bmh6rhCDK07dB+JCaCzTogaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1784187527t51b8588e
X-QQ-Originating-IP: Gb2dTKxdgsq3QBB//vNkBiNOF3U/kdqv26EhghZTZUA=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.247.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 15:38:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8609164746101243603
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
Subject: [PATCH net-next v11 5/5] net: wangxun: add pcie error handler
Date: Thu, 16 Jul 2026 15:38:22 +0800
Message-Id: <20260716073822.24356-6-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OSUW9vQLVhiZB7IrYTd0rHpZrm22XO8XhVnEs0cdmDAIduWHjlpx26hj
	xZqZH2R2vEJJ9L0FBYYYx2zGxCE3awBwuHoo3fayZEmidODK+Slnb1wO+zX3/hx6N98+9AI
	htvvwbomZpe4R62NFJpjWSDcfvRmom6XaEKYA1CzLSItkKyeSo0EHYBtWmANzOgwe8YaYh7
	HNEfXV+Iij2kAb2lr4joRQ0M6swGJsfedag3vYn8MjjbpHA+kjFf7iVtByqJBlbZK6eo2f7
	nOtALLrklHJ1WKCrW8Ps9yDPJcqnoxNrHAuWyLKOUW/FppoVK7reQKhb54qHNkcgMtyhb+3
	6E+RvafJgMzf6T0vHcpN0xs7HyjZsuo1up2jZGdabH9wv+ShblIrilL1rxu9LMqkyw3FBxS
	6N7la56s5P4PbX7ik9ASxeegLlvYuRtLnQ+20/8QynN2955R7r6Bzh8kqrhuUdqe1W4ZMmE
	BTAe7uOQLW3m3YqhmO1bym1g0ky7DovX+kAaXzEYKdYrz7U732Ewf6Siku+bLlWeqO9MF/b
	anyvMGGAt3jlgVkD3CbTglWOyqP0E5rLV6LA5mTMGY1yw+/Ylrj/QLnZDeXBNpLrYDDLV2S
	VETjVD1UfTNLxFiHNwSn3gbBenaCBOqxUpSYaTYNy1wyYNsdJj7xU3+S+l7HVtsE5fuD75h
	/+x87UOJjGtNi86vBxnE6eSgKI5osiuzTpxSZVCjdlFC9mqFqefE1H+zr0qXe4yRQGIEn2T
	PQgNk7pZRob6C7eLS2DCLn45GJGd5kkKqKAjpPOJMcSYRal8VM60/6+sW3ceYQ4kvRZ1x4X
	8TWb+q5F81CtiH1hAJy+LnXZbnHlxQTe72Ml0cjVcNHHAesd3cwzqeP0Ek+f2BStFvCCrD3
	Nnr/jC3J+pMWP/Vt8ZfMrIBqCEQv+oqEONhOb8/yGtsNgK/XrgIA+GdSBnCWo/bkrUYBvii
	ejUxZScfwjy11mh5i0zPLb0WVAAIQzNZjmg5YzBfgCR19/KiN1rOIFeVbaOH4dhs2WBnqwN
	/DLOXWkmht809yXOSQ5+dNYsc6F8Xw6YHZWIRpnmtWPiGk1xyiKxrGyi7YAfM/diNmcluVm
	g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
Tx timeout happens before the AER error report when a PCIe error occurs,
CPU blocking would be caused by MMIO during the reset process. To
prevent it, check PCIe error status in .ndo_tx_timeout. The current
function of ngbe is not yet fully developed, it will be completed in the
future.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 144 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   4 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  32 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  31 +++-
 5 files changed, 208 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index ee27f96735dc..0cb99e456a1c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -4,11 +4,120 @@
 
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 
 #include "wx_type.h"
 #include "wx_lib.h"
 #include "wx_err.h"
 
+/**
+ * wx_io_error_detected - called when PCI error is detected
+ * @pdev: Pointer to PCI device
+ * @state: The current pci connection state
+ *
+ * Return: pci_ers_result_t.
+ *
+ * This function is called after a PCI bus error affecting
+ * this device has been detected.
+ */
+static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
+					     pci_channel_state_t state)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	if (!wx)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	netdev = wx->netdev;
+	if (!netif_device_present(netdev))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	rtnl_lock();
+	netif_device_detach(netdev);
+	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+	wx_soft_quiesce(wx);
+
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
+	rtnl_unlock();
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * wx_io_slot_reset - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Return: pci_ers_result_t.
+ *
+ * Restart the card from scratch, as if from a cold-boot.
+ */
+static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+
+	if (pci_enable_device_mem(pdev)) {
+		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	/* make all memory operations done before clearing the flag */
+	smp_mb__before_atomic();
+	clear_bit(WX_STATE_DISABLED, wx->state);
+	clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+	pci_set_master(pdev);
+	pci_restore_state(pdev);
+	pci_wake_from_d3(pdev, false);
+
+	rtnl_lock();
+	if (netif_running(wx->netdev) && wx->down_suspend)
+		wx->down_suspend(wx);
+	if (wx->do_reset)
+		wx->do_reset(wx->netdev, false);
+	rtnl_unlock();
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * wx_io_resume - called when traffic can start flowing again.
+ * @pdev: Pointer to PCI device
+ *
+ * This callback is called when the error recovery driver tells us that
+ * its OK to resume normal operation.
+ */
+static void wx_io_resume(struct pci_dev *pdev)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+	int err;
+
+	netdev = wx->netdev;
+	rtnl_lock();
+	if (netif_running(netdev)) {
+		err = netdev->netdev_ops->ndo_open(netdev);
+		if (err) {
+			wx_err(wx, "Failed to open netdev after reset\n");
+			goto out;
+		}
+	}
+	netif_device_attach(netdev);
+out:
+	rtnl_unlock();
+}
+
+const struct pci_error_handlers wx_err_handler = {
+	.error_detected = wx_io_error_detected,
+	.slot_reset = wx_io_slot_reset,
+	.resume = wx_io_resume,
+};
+EXPORT_SYMBOL(wx_err_handler);
+
 static void wx_pf_reset_subtask(struct wx *wx)
 {
 	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
@@ -25,6 +134,9 @@ static void wx_reset_task(struct work_struct *work)
 
 	rtnl_lock();
 
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		wx_soft_quiesce(wx);
+
 	if (test_bit(WX_STATE_DOWN, wx->state) ||
 	    test_bit(WX_STATE_RESETTING, wx->state))
 		goto out;
@@ -139,6 +251,33 @@ void wx_check_hang_subtask(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_check_hang_subtask);
 
+static bool wx_check_pcie_error(struct wx *wx)
+{
+	u16 vid, pci_cmd;
+
+	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
+	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
+
+	/* PCIe link loss or memory space can't access */
+	if (vid == U16_MAX || !(pci_cmd & PCI_COMMAND_MEMORY))
+		return true;
+
+	return false;
+}
+
+static void wx_tx_timeout_recovery(struct wx *wx)
+{
+	/*
+	 * When a PCIe hardware error occurs, the driver should initiate a PCIe
+	 * recovery mechanism. However, this recovery flow relies on the AER
+	 * driver for current kernel policy. Therefore, a self-contained
+	 * recovery mechanism is not implemented yet.
+	 */
+	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+	wx_err(wx, "PCIe error detected during tx timeout\n");
+	queue_work(wx->reset_wq, &wx->reset_task);
+}
+
 static void wx_tx_timeout_reset(struct wx *wx)
 {
 	if (test_bit(WX_STATE_DOWN, wx->state))
@@ -153,7 +292,10 @@ void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txque
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	wx_tx_timeout_reset(wx);
+	if (wx_check_pcie_error(wx))
+		wx_tx_timeout_recovery(wx);
+	else
+		wx_tx_timeout_reset(wx);
 }
 EXPORT_SYMBOL(wx_tx_timeout);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
index 1eed13e48095..a6a82a263528 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
@@ -7,6 +7,8 @@
 #ifndef _WX_ERR_H_
 #define _WX_ERR_H_
 
+extern const struct pci_error_handlers wx_err_handler;
+
 void wx_check_err_subtask(struct wx *wx);
 int wx_init_err_task(struct wx *wx);
 void wx_check_hang_subtask(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index edcb8d121b86..aa357e260c4c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1222,6 +1222,8 @@ enum wx_state {
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_SERVICE_SCHED,
+	WX_STATE_DISABLED,
+	WX_STATE_RES_FREED,
 	WX_STATE_NBITS		/* must be last */
 };
 
@@ -1289,6 +1291,7 @@ enum wx_pf_flags {
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_FLAG_NEED_PF_RESET,
+	WX_FLAG_NEED_PCIE_RECOVERY,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1410,6 +1413,7 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*down_suspend)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 92895f503511..56d4b63387fd 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -47,6 +47,20 @@ static const struct pci_device_id ngbe_pci_tbl[] = {
 	{ }
 };
 
+static void ngbe_down_suspend(struct wx *wx)
+{
+	if (test_and_set_bit(WX_STATE_RES_FREED, wx->state))
+		return;
+
+	phylink_stop(wx->phylink);
+	phylink_disconnect_phy(wx->phylink);
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+	wx_free_irq(wx);
+	wx_free_isb_resources(wx);
+	wx_free_resources(wx);
+}
+
 /**
  *  ngbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -135,6 +149,7 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
 	wx->do_reset = ngbe_do_reset;
+	wx->down_suspend = ngbe_down_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -413,6 +428,9 @@ static void ngbe_disable_device(struct wx *wx)
 
 static void ngbe_reset(struct wx *wx)
 {
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		return;
+
 	wx_flush_sw_mac_table(wx);
 	wx_mac_set_default_filter(wx, wx->mac.addr);
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
@@ -435,6 +453,7 @@ static void ngbe_up_complete(struct wx *wx)
 	/* make sure to complete pre-operations */
 	smp_mb__before_atomic();
 	clear_bit(WX_STATE_DOWN, wx->state);
+	clear_bit(WX_STATE_RES_FREED, wx->state);
 	wx_napi_enable_all(wx);
 	/* enable transmits */
 	netif_tx_start_all_queues(wx->netdev);
@@ -529,12 +548,16 @@ static int ngbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (test_bit(WX_STATE_RES_FREED, wx->state))
+		goto out;
+
 	wx_ptp_stop(wx);
 	ngbe_down(wx);
 	wx_free_irq(wx);
 	wx_free_isb_resources(wx);
 	wx_free_resources(wx);
 	phylink_disconnect_phy(wx->phylink);
+out:
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -566,7 +589,8 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void ngbe_shutdown(struct pci_dev *pdev)
@@ -855,6 +879,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -910,7 +935,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -937,6 +963,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 		wx_err(wx, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
+	clear_bit(WX_STATE_DISABLED, wx->state);
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
@@ -961,6 +988,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 7a05661b1d80..499f48619f00 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -163,6 +163,7 @@ static void txgbe_up_complete(struct wx *wx)
 	/* make sure to complete pre-operations */
 	smp_mb__before_atomic();
 	clear_bit(WX_STATE_DOWN, wx->state);
+	clear_bit(WX_STATE_RES_FREED, wx->state);
 	wx_napi_enable_all(wx);
 
 	switch (wx->mac.type) {
@@ -206,6 +207,9 @@ static void txgbe_reset(struct wx *wx)
 	u8 old_addr[ETH_ALEN];
 	int err;
 
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		return;
+
 	err = txgbe_reset_hw(wx);
 	if (err != 0)
 		wx_err(wx, "Hardware Error: %d\n", err);
@@ -312,6 +316,20 @@ void txgbe_up(struct wx *wx)
 	txgbe_up_complete(wx);
 }
 
+static void txgbe_down_suspend(struct wx *wx)
+{
+	if (test_and_set_bit(WX_STATE_RES_FREED, wx->state))
+		return;
+
+	phylink_stop(wx->phylink);
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
+	wx_free_resources(wx);
+	txgbe_fdir_filter_exit(wx);
+}
+
 /**
  *  txgbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -428,6 +446,7 @@ static int txgbe_sw_init(struct wx *wx)
 
 	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	wx->down_suspend = txgbe_down_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	switch (wx->mac.type) {
@@ -538,12 +557,16 @@ static int txgbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (test_bit(WX_STATE_RES_FREED, wx->state))
+		goto out;
+
 	wx_ptp_stop(wx);
 	txgbe_down(wx);
 	wx_free_irq(wx);
 	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 	txgbe_fdir_filter_exit(wx);
+out:
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -564,7 +587,8 @@ static void txgbe_dev_shutdown(struct pci_dev *pdev)
 
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void txgbe_shutdown(struct pci_dev *pdev)
@@ -915,6 +939,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 		goto err_remove_phy;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -989,7 +1014,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver txgbe_driver = {
@@ -999,6 +1025,7 @@ static struct pci_driver txgbe_driver = {
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(txgbe_driver);
-- 
2.51.0

