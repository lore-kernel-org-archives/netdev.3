Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2983939BF
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739471; cv=none; b=hB65yqUozeCyvRVLNZUNkYwDgO1wljavts7YfsjXbJVjL07BJ5Qgvmrvfwn3DLmRlpDSKn0GxBWh8C8+IqVPgueSOEh7mWpN0xd7vLMtNF8ZOOmo4rRXvICdoahPfyXEQpHCr2T6yN30uOV+TPZDwSeb9Hkana+zJSR6gtGevHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739471; c=relaxed/simple;
	bh=fYbDrrDOVC/z2K7Go94bgB/Kn5UEej4Ak/KbY8o/e4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbeCB9W+DoDMa0bG2zcs9eqvJl7fsaZT4QinPU6jNlicUh/opohOrZoksaK5d9nbZwku8BBoqMxd8HLU8MK3LMy9QB61Mqgh6pVrEPe9mEk9gGW5X+Xj5EPtNxUJESIgKla/fMQDwf+9IH+8AF3aP74NSccgOYtsGCiVlV2uWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz10t1785739435tec02b7ff
X-QQ-Originating-IP: rvXGV7+5NWEoszCIKFHpcA/gmow5ULbDnlHn3Pbt23A=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 14:43:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3695775508808653438
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
Subject: [PATCH net-next v14 5/5] net: wangxun: add pcie error handler
Date: Mon,  3 Aug 2026 14:43:34 +0800
Message-Id: <20260803064334.21876-6-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NqN/wpVFVRYXQXaKIBWhl53AMH/bLvlW8yRlGo3bLQSO0N8Sne110nwI
	J8Qwjq2AEtgdj2Gbad+znkdr2GvYEritvm98n8wy+Dgx66SsK9Nl7RKbK25uwCA1EhRc9+/
	fuBFY7dqTM2nZB3k+dTKVC+FlXJKkdoQ8+qylKzbfaS/rMRx3jWVF/WLzk/XQcaCcAVoJ6J
	1XuqCdikYjl8V5Qm4BbQ9ej6orhaihGRoh2FIx6uOZE6PFhKxYE64kTxUvuqHp0KbQutKnS
	i40UAArkfpeb7VovRU7r++giNxe4v8dEtaa3X5+xq1kt2XTdgPInr4JfqNbJsz1lUEGwEW4
	tn3nTimr0ygX22Y+audm3lJuOvTuxkeNSKkQS4gXNMRRjH8lcl4UhBWgjuNLF9atp6+bFC2
	1qVLgVlsH11H+8OsXmdryrhP/tfU9YgLGsUGEYmMzOTkltDZNjwBV5s7amw6Hq8ZtCHCMjp
	0fcFD1bVNslmrdhYWGdJs7yS/UEc/t1VacYwc0KnIrhvA61TcagIJsAE0ujQYQgaPD79Mil
	4kAq8dZW7G+ibA9ouuH1+8IyAU+EZG8VTcjyGrdpCpE4UU/UguK6eUO8sjWLdDGNEHE0AFH
	mqO5d/UkvYY4qaXJY/micZYd8KY643Xy9WIOrULQNwlqjuTTnv1V9rTAL3x8qYqcyxh9pif
	zKHTAwSjWl8pJ+4zGDd861U+DNJER7vtlcO+1ePHesPBz9oUtj2RX+4J8i9EeFISngzA3Qy
	v5xNMDV1GVIY6tYNTaZWe1IA+eo9uuWvKuEOs2cRDFFIiHT8hoyoN/WPUsJqKTsmb/ezvGp
	WiBT3w/kPfSC7Q0xywyTWlNTILw+M1S3y0X1MKZjGT6tdTZkaW7raYifajAPmEFzpFsa7tg
	cu/BCnNBm97XXn6977o8oTEFAAdss3Nq+XzvD1UmAKXTB86lLuVZYnTpKSl+ZiUZEnExySX
	dv1rRYYDkcuDuWwe76WkWjU0MHd3p6HBRouV+EpTTOW+31FXXuto5lrdBLhNlQXAAIcywDG
	lcnQiG0VVSLzxOy4/KwLURsfMl8/y2zLE5YR4mDlGyMh6OEmVDN7nNjEPa+8++ks4Cz4pqn
	QaoIfZ5nP/Z53dCSc6nwT5GYCw0Eqb3uw==
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 159 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   4 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  32 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  31 +++-
 5 files changed, 223 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index 4c59a1110120..b56fbdc959de 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -4,11 +4,136 @@
 
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
 static void wx_pf_reset_subtask(struct wx *wx)
 {
 	if (!test_and_clear_bit(WX_FLAG_NEED_DO_RESET, wx->flags))
@@ -25,6 +150,22 @@ static void wx_reset_task(struct work_struct *work)
 
 	rtnl_lock();
 
+	/* If the device has been detached (e.g., due to AER error handling),
+	 * abort the reset task to prevent operating on a dead or unmanaged
+	 * hardware.
+	 */
+	if (!netif_device_present(wx->netdev))
+		goto out;
+
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags)) {
+		/* Double check: Verify if the PCIe error is still present. */
+		if (wx_check_pcie_error(wx))
+			wx_soft_quiesce(wx);
+		else
+			clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+		goto out;
+	}
+
 	if (test_bit(WX_STATE_DOWN, wx->state) ||
 	    test_bit(WX_STATE_RESETTING, wx->state))
 		goto out;
@@ -139,6 +280,19 @@ void wx_check_hang_subtask(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_check_hang_subtask);
 
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
@@ -153,7 +307,10 @@ void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txque
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
index 158e8611f3d6..2eba5ab59925 100644
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
 
@@ -1288,6 +1290,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_DO_RESET,
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
+	WX_FLAG_NEED_PCIE_RECOVERY,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1409,6 +1412,7 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*down_suspend)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 45b166ff0c97..14c00228cede 100644
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
@@ -854,6 +878,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -909,7 +934,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -936,6 +962,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 		wx_err(wx, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
+	clear_bit(WX_STATE_DISABLED, wx->state);
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
@@ -960,6 +987,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 414b2ba8dfc4..eb91c4f28ecd 100644
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
@@ -914,6 +938,7 @@ static int txgbe_probe(struct pci_dev *pdev,
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

