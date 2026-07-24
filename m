Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D541DEDC
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888052; cv=none; b=pLUDjl4J4DMJA2QvO36QiLW2r2+JHYFjdq5vCb7KBKQZ9Dqh40hkDtNBia1XLsbERYoz7FNhkrt9Ke13ei/t3hIwZdO9wBpd1fIq6VquBeUpeuQJvWX6+MJ4ZceAEfPdEDyqjpqlD7bOFxgBnDriu8vgzj8v9+vDKbITJ4qrvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888052; c=relaxed/simple;
	bh=s24MekZx04ZExXE6hcTIhiEPasXZqW4PCIQi/BuOMjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fz1PmA2TTHJEH+jbmj8hl5m3MMxTdWzBYw7FtyH7zm0myZqVjOzcTG+08NAEw8w4oviS7s8pG7HqYRYKIfK0O951mD2sKyyMuYVO5tjcApHivyOKit/vrKsJKDzoL1iIn9N5E3EshUSRfjnmGzSWcjDdjg8hGdr7pBxBtG/3AiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1784888017t33430758
X-QQ-Originating-IP: njg3qNvjOBH7BjVKz19zZCL0KFf48xMMesyk2BpGnGc=
Received: from lap-jiawenwu.trustnetic.com ( [115.227.112.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 18:13:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2496269450153154522
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v12 5/5] net: wangxun: add pcie error handler
Date: Fri, 24 Jul 2026 18:13:09 +0800
Message-Id: <20260724101309.23472-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260724101309.23472-1-jiawenwu@trustnetic.com>
References: <20260724101309.23472-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MZ3F7+AyOpurT215A3fDkm54FqIU5KoyjK8943UZGOdAglsVg5XKWndV
	ZH3tyhnWCS2EYtg9vkGf/BFdfA/emU31rJgzlpJmB9PANb2y5RykOO43Str/K137q4dOt2+
	Q0wfutjoPi7FKE9XJzlBgv1ZDhMJnhWrno9MnbiQCf2A3v4VUkrudhNVMCvXvVpzA+GY9eD
	UGNSyDlXAZ3xQDkFCcERUC6U3ToCiGwgAJKW+MwBJH1vjSzUptNe/ssCqoefrDFPPB+dG8g
	8qwHRqhDdax5lJGJcBx/O71vNZf8g0We7FqRBn1Bblpc8Tv6nkfTt1hrIGJx7i3DiObp7Rh
	/Ib5FFy45NSPkoy0wiocYA9e3FA86IZqDxI97wgqf09Oifo+0mqAxR2xyXz/XncF7Pc6WSL
	hj6Rh+SAcEO0AOIchtzrIVvH1vXunaJz0q3hfChzvtExIi6bECe4ug5vnT93LVwteTfDdBy
	Uxjs/XHZJiGWUgzPvYyTyKqj0WOXyRYXT+W/E+Go8xVCBH/bnT4NWFveXV6e8jB1MA4wc6z
	aaU5h7BpK+NdNw2Csrfn7UozPm9Wv1NpWJQ9qDjpVELHpRyk7H2ETSB05I7UT03hYxQNt76
	49VCJiwIQxtoY+9s79+E/JWO42BxXyDR4bzsvnE8uWX4eZM7+nmJUqcrNsr6OeyumF794cJ
	ovcAm/3VJn8G0s8FMWMPEIJOMupXUJzGUIDetq3sywFWRQGnw1X9ML+ZjxLHHG/GS84YvOs
	d3cslUP/yvOkj3lcoJTK4uCfmxEuaRXnwR9AIm0yUAjtEK1GtlmDmZ+JK8v2VkuJco+ILBD
	KNGW9OGyxsodHGcSMJY5eBxmRH6sg6/lLe6LGIVytkCPoaoQePW653cahQj0qOOFv/Lt48A
	/1Z3N3ywhhPnjG60PM6eti9Cz/s8lj5tnQ34BrV2BLdtjFRxU7iRQq7U1bTJepdb3F7OXoj
	8D1+HEksVFY5lp9CNJCqertS9cpTpLJ1esfTW/41ezK9KgxZxUvTwnQjAM6/et/S05VWz9T
	h6wuMne17Z5tTDMc8LyVFcVzBYfrMpZt9aYpaCPUd5msANf7oVwA2XwJo9ZGlTXLNOavx0x
	rKUigLUqB+BrbnnhoEzbf6KOh3uGXTh8FveIoGAaF/i
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
Tx timeout happens before the AER error report when a PCIe error occurs,
CPU blocking would be caused by MMIO during the reset process. To
prevent it, check PCIe error status in .ndo_tx_timeout. The current
function of ngbe is not yet fully developed, it will be completed in the
future.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 146 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   4 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  32 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  31 +++-
 5 files changed, 210 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index ee27f96735dc..7936845c2894 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -4,11 +4,122 @@
 
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
+	rtnl_lock();
+	netif_device_detach(netdev);
+	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+	wx_soft_quiesce(wx);
+
+	if (state == pci_channel_io_perm_failure) {
+		rtnl_unlock();
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
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
@@ -25,6 +136,9 @@ static void wx_reset_task(struct work_struct *work)
 
 	rtnl_lock();
 
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		wx_soft_quiesce(wx);
+
 	if (test_bit(WX_STATE_DOWN, wx->state) ||
 	    test_bit(WX_STATE_RESETTING, wx->state))
 		goto out;
@@ -139,6 +253,33 @@ void wx_check_hang_subtask(struct wx *wx)
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
@@ -153,7 +294,10 @@ void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txque
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
index 11ac4b04f5ee..582ee567e6b9 100644
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
 
@@ -990,7 +1015,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver txgbe_driver = {
@@ -1000,6 +1026,7 @@ static struct pci_driver txgbe_driver = {
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(txgbe_driver);
-- 
2.51.0

