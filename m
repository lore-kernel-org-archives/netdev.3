Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244A3E49DB;
	Tue, 13 Oct 2026 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858735; cv=none; b=rY7bsB71otxRdQFCNR4StYH+rd//kiipvt73CS95/EbmTXQj5PY3ijOHDyc4iL1+7K1qZvA8/9mpWyA8/JMjIhKDP5y0qXxWgvn7bpCRdNl3W2PgA1zKhS84YCGswCMiAbhH7GT3b0Uh514OgQt52obSx35pB2bEgXHj9y8+eaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858735; c=relaxed/simple;
	bh=vewmwsD6pyPHwConaJrx2eBEfkxDZcWywNAqlv3p6Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3Gee1xo3i0qJDDNqXMFh3Pb/aGZDTDV6ZXOpj2YIGzo+vlwsHtTTDvFNLaH4rBOiWXSZRRFJsjDHkOqQdLNezU/AVPfbIRZaPglYDjaiS0a49rBuejBsewQMNFF59owBEjvmSAq/OS8vVa8YdESnN8gXsN+BcHnrPdU4hM8qGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1791858673t9e5f4eea
X-QQ-Originating-IP: BA1aYf28bd4tKlbognCK61dUapySzdZdOsjTVycTOtc=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:31:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4123626958471619160
EX-QQ-RecipientCnt: 11
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v16 5/5] net: rnpgbe: Add link status handling support
Date: Tue, 13 Oct 2026 10:31:09 +0800
Message-ID: <C41AE78496D9DC2B+20261013023109.63764-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
References: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NImvdRhE6fHpOUu7N4NQ0MKnovAKst8Z8XCga0DDFan4hU0mOQN6TFOV
	L2T4VFvY6GL3sPtetCGXl30/XfFDKpLbonR2mMuRIBGcpvbf/mynEwL/jrZNt3x2sZT5TSb
	OHe2wih6OISSYhCMVmDaNoWsj2iwUEUUPq1R0+hVDgHTM6YeQo5EvQV4Fx2iFr0+vIpo8mK
	HaADVlUYwo8bdKuyb4Eb4H70u8hpwiEymSAZANmQI6uQ58ccYMKwH9jv12oam+qCheIAT0u
	FbMC4/bHO8vWAyNq+snYUT7FiUnZWlGuSZxBZoQIbj8TcqsP4poB+qmW6uTSgtDfRnb0Uqj
	W1W+0J8Vcq0MsMyffkrCFXMzqum1JHKNf2xPzOARudVh9Q56/259FGjqbDmoahn/qRO/ikD
	c/DWVZmNIvoKYm2RiyYYGynH/RVegxq/2yD7zJKnixcDS41d1KZJKZksGyHn9vS0WfZIu7a
	j8GRQ0y3Y1uoO2gPCUKPBFqYZhrolK89nWLdELJzMF5DevBDQcgHWF3R0BDQ2yR3CrLWw7v
	6UMJcIfeTke/3MW401rKN3xLvLRSoUjM8Tf3s6kNnc1Y9p2PP5gzK0vFhs9AVqPPiRG1sdo
	oL5kY/0Q8O0mf4ktDdTntiGJwB1zeOPbv/Pu+CTNJ0QGzouYIwGrlSNFsWEI2X31K8fi9ed
	mpViov5O2Z/jWqzQtT8t/CIxd1PplUx8sI2P9DdF56HtDM/ueynUAoQQ8BmzygwquFoSQ0Q
	hpR5WtVl2STcMEcEDaeuBwktf5LhUftK3rBo+BMw/OP/2SitKoAI/hr6t4Bx3s0iOeTmqop
	rZVfn0By+I+tiCookhmxvUS4YM9RNKH7aCs885DsxTwd500Dh2tbkmHaLWWxx5JMFtD7IWZ
	jR8vs+j0xrgyOKhqWFR7+9Fw7FMsvZJlkboqyT/daYwk5dyDJOHlHitjD5kDGaSjITghblJ
	rVtQGtBG7ukUueFr1+CUAShzprf7Idc19wRYCA3qKq1Z0ey1kHCRZX6I18N/weBglONINxT
	tuFQ2/nTRI3JWUstRu/+4SFegMrrCtqMXvbVnnvbfK4Xdgce7iMXgGErLv2Qw1hYROFTcwq
	N0VsypYnwmj
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Add link status handling for the RNPGBE driver.

Introduce link state data structures for speed, duplex and link state,
and process firmware link events delivered over the mailbox, since
firmware controls the link and phylink is not used. Add a service task
to handle pending events and manage carrier status with
netif_carrier_on()/netif_carrier_off().

Notify firmware when the interface is brought up and after the data path
is quiesced during teardown, and fail interface open if the firmware
port-up or link-report setup fails. Validate firmware link events before
updating the cached link state. Enable the GMAC receiver in receive-all
mode after the chip-level receive filter has been configured, and
document the driver-to-firmware link-state snapshot and reset semantics.

Configure firmware after reset to enable autonegotiation. Advertise
10/100Mb/s half- and full-duplex modes and 1000 Mb/s full-duplex mode.
Fail probe if firmware does not acknowledge the link setup command.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  19 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  63 +++-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 172 ++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   3 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  20 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 167 ++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 278 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  59 ++++
 10 files changed, 790 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 6f71055f180e..4e9776b28bfb 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/timer.h>
@@ -32,11 +33,10 @@ struct mucse_mbx_info {
 	u32 fwpf_ctrl_base;
 };
 
-/* Enum for firmware notification modes,
- * more modes (e.g., portup, link_report) will be added in future
- **/
 enum {
 	mucse_fw_powerup,
+	mucse_fw_portup,
+	mucse_fw_link_report_en,
 };
 
 struct mucse_hw {
@@ -45,8 +45,11 @@ struct mucse_hw {
 	struct pci_dev *pdev;
 	struct mucse_mbx_info mbx;
 	int port;
+	int speed;
+	bool link;
 	u16 cycles_per_us;
 	u8 pfvfnum;
+	u8 duplex;
 };
 
 struct rnpgbe_tx_desc {
@@ -230,12 +233,21 @@ struct mucse {
 	int num_rx_queues;
 	char mbx_name[32];
 	bool mbx_irq_requested;
+	bool link_event_ready;
+	bool link_pending;
 	unsigned long state;
+	atomic_t mbx_irq_seq;
 	struct work_struct mbx_work;
+	struct delayed_work serv_task;
+	/* Protects event readiness, pending state, cached link state and
+	 * driver-side link register updates.
+	 */
+	spinlock_t link_lock;
 };
 
 int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
 int rnpgbe_reset_hw(struct mucse_hw *hw);
+int rnpgbe_setup_default_link(struct mucse_hw *hw);
 int rnpgbe_send_notify(struct mucse_hw *hw,
 		       bool enable,
 		       int mode);
@@ -243,6 +255,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 int rnpgbe_set_rx_mode(struct net_device *netdev,
 		       struct netdev_hw_addr_list *uc,
 		       struct netdev_hw_addr_list *mc);
+void rnpgbe_set_link(struct mucse_hw *hw, bool linkup);
 
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 79d66187d044..dcc8233e024e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -4,12 +4,19 @@
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
 #include "rnpgbe_mbx.h"
 #include "rnpgbe_mbx_fw.h"
 
+#define RNPGBE_DEFAULT_ADV	(RNPGBE_FW_ADV_10_FULL | \
+				 RNPGBE_FW_ADV_100_FULL | \
+				 RNPGBE_FW_ADV_1000_FULL | \
+				 RNPGBE_FW_ADV_10_HALF | \
+				 RNPGBE_FW_ADV_100_HALF)
+
 /**
  * rnpgbe_get_permanent_mac - Get permanent mac
  * @hw: hw information structure
@@ -53,6 +60,18 @@ int rnpgbe_reset_hw(struct mucse_hw *hw)
 	return mucse_mbx_reset_hw(hw);
 }
 
+/**
+ * rnpgbe_setup_default_link - Configure the default link settings
+ * @hw: hardware information structure
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int rnpgbe_setup_default_link(struct mucse_hw *hw)
+{
+	return mucse_mbx_set_link(hw, RNPGBE_DEFAULT_ADV, true, 0, 0,
+				  ETH_TP_MDI_AUTO);
+}
+
 /**
  * rnpgbe_send_notify - Echo fw status
  * @hw: hw information structure
@@ -66,11 +85,17 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
 		       int mode)
 {
 	int err;
-	/* Keep switch struct to support more modes in the future */
+
 	switch (mode) {
 	case mucse_fw_powerup:
 		err = mucse_mbx_powerup(hw, enable);
 		break;
+	case mucse_fw_portup:
+		err = mucse_mbx_phyup(hw, enable);
+		break;
+	case mucse_fw_link_report_en:
+		err = mucse_mbx_link_report(hw, enable);
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -245,3 +270,39 @@ int rnpgbe_set_rx_mode(struct net_device *netdev,
 
 	return 0;
 }
+
+/**
+ * rnpgbe_set_link - Set the hardware link state
+ * @hw: hw information structure
+ * @linkup: link on or not
+ *
+ * Apply the firmware-reported link state to the GMAC. This helper is only
+ * called while processing a firmware link event. The caller must hold the
+ * containing struct mucse's link_lock.
+ * Firmware updates the speed and duplex fields before posting a link event
+ * and waits for the PF acknowledgment, so event handling completes this
+ * read-modify-write before firmware accesses GMAC_CONTROL again.
+ *
+ **/
+void rnpgbe_set_link(struct mucse_hw *hw, bool linkup)
+{
+	struct mucse *mucse = container_of(hw, struct mucse, hw);
+	u32 value;
+
+	lockdep_assert_held(&mucse->link_lock);
+	value = mucse_hw_rd32(hw, GMAC_CONTROL);
+
+	/* ndo_set_rx_mode_async() programs the chip-level filter. Keep the GMAC
+	 * in receive-all mode so it does not discard frames accepted by that
+	 * filter.
+	 */
+	if (linkup) {
+		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, GMAC_RX_ALL);
+		value |= GMAC_CONTROL_RE;
+		mucse_hw_wr32(hw, GMAC_CONTROL, value);
+	} else {
+		value &= ~GMAC_CONTROL_RE;
+		mucse_hw_wr32(hw, GMAC_CONTROL, value);
+		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, 0);
+	}
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 3f103f93ac30..674d4d23c4b0 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -23,6 +23,17 @@
 #define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)
 #define RNPGBE_DMA_RX_STATUS           GENMASK_U32(21, 20)
 #define RX_AXI_RW_EN                   0x03
+/* RNPGBE_LINK_ST is a driver-owned link-state snapshot consumed by firmware.
+ * Set the driver-state marker; all other driver status fields start clear.
+ */
+#define M_DEFAULT_ST                   0xa0000000
+/* Firmware never reports 0xf in the speed field. */
+#define M_INVALID_ST                   (M_DEFAULT_ST | GENMASK_U32(11, 8))
+/* Driver-reported fields: 25:24 pause, 11:8 speed, 6 LLDP, 4 duplex,
+ * and 0 link up/down. M_DEFAULT_ST resets these fields so firmware reports
+ * the current hardware state again.
+ */
+#define RNPGBE_LINK_ST                 0x000c
 #define RNPGBE_DMA_AXI_EN              0x0010
 #define RNPGBE_TX_MIN_PKT_LEN          33
 
@@ -41,5 +52,11 @@
 /* The final two of the 32 hardware RAR entries are reserved for NCSI. */
 #define RNPGBE_RX_RAR_ENTRIES          30
 #define RNPGBE_RX_MCAST_HASH_ENTRIES   128
+
+#define MUCSE_GMAC_OFF(_n)             (0x20000 + (_n))
+#define GMAC_CONTROL_RE                0x00000004
+#define GMAC_CONTROL                   MUCSE_GMAC_OFF(0)
+#define GMAC_RX_ALL                    (BIT(31) | BIT(0))
+#define GMAC_FRAME_FILTER              MUCSE_GMAC_OFF(0x4)
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 22fe284729f2..b7b0c45a0f66 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -16,8 +16,14 @@
 static void rnpgbe_mbx_work(struct work_struct *work)
 {
 	struct mucse *mucse = container_of(work, struct mucse, mbx_work);
+	int irq_seq;
 
+	irq_seq = atomic_read(&mucse->mbx_irq_seq);
 	mucse_fw_irq_handler(&mucse->hw);
+
+	/* A mailbox interrupt while this work runs needs another invocation. */
+	if (irq_seq != atomic_read(&mucse->mbx_irq_seq))
+		queue_work(system_percpu_wq, &mucse->mbx_work);
 }
 
 /**
@@ -31,6 +37,7 @@ static irqreturn_t rnpgbe_msix_other(int irq, void *data)
 {
 	struct mucse *mucse = (struct mucse *)data;
 
+	atomic_inc(&mucse->mbx_irq_seq);
 	queue_work(system_percpu_wq, &mucse->mbx_work);
 
 	return IRQ_HANDLED;
@@ -700,6 +707,7 @@ int rnpgbe_request_mbx_irq(struct mucse *mucse)
 	snprintf(mucse->mbx_name, sizeof(mucse->mbx_name),
 		 "rnpgbe-mbx:%s", pci_name(pdev));
 	INIT_WORK(&mucse->mbx_work, rnpgbe_mbx_work);
+	atomic_set(&mucse->mbx_irq_seq, 0);
 
 	err = request_irq(pci_irq_vector(pdev, 0), rnpgbe_msix_other, 0,
 			  mucse->mbx_name, mucse);
@@ -722,6 +730,7 @@ void rnpgbe_free_mbx_irq(struct mucse *mucse)
 		free_irq(pci_irq_vector(pdev, 0), mucse);
 		cancel_work_sync(&mucse->mbx_work);
 	}
+	cancel_delayed_work_sync(&mucse->serv_task);
 }
 
 /**
@@ -1442,7 +1451,20 @@ static void rnpgbe_cancel_rx_retry_timers(struct mucse *mucse)
 void rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	int err;
 
+	spin_lock_irqsave(&mucse->link_lock, flags);
+	mucse->link_event_ready = false;
+	mucse->link_pending = false;
+	hw->link = false;
+	hw->speed = 0;
+	hw->duplex = 0;
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
+	cancel_delayed_work_sync(&mucse->serv_task);
+
+	netif_carrier_off(netdev);
 	rnpgbe_irq_disable(mucse);
 	rnpgbe_napi_disable_all(mucse);
 	synchronize_net();
@@ -1451,22 +1473,75 @@ void rnpgbe_down(struct mucse *mucse)
 	rnpgbe_stop_all_rx_rings(mucse);
 	rnpgbe_cancel_rx_retry_timers(mucse);
 	rnpgbe_clean_all_tx_rings(mucse);
+
+	err = rnpgbe_send_notify(hw, false, mucse_fw_link_report_en);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send link report to hw failed %d\n",
+			 err);
+		dev_warn(&hw->pdev->dev, "Fw will still report link event\n");
+	}
+
+	/* Firmware owns GMAC_CONTROL_RE and clears it while processing
+	 * port-down. RX DMA is already quiesced, so no local GMAC update is
+	 * needed before freeing the RX buffers.
+	 */
+	err = rnpgbe_send_notify(hw, false, mucse_fw_portup);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send port down to hw failed %d\n",
+			 err);
+		dev_warn(&hw->pdev->dev, "Port is not truly down\n");
+	}
 	rnpgbe_clean_all_rx_rings(mucse);
 }
 
 /**
  * rnpgbe_up_complete - Final step for port up
  * @mucse: pointer to private structure
+ *
+ * Return: 0 on success, negative errno if firmware setup fails
  **/
-void rnpgbe_up_complete(struct mucse *mucse)
+int rnpgbe_up_complete(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	int err;
 
 	rnpgbe_configure_msix(mucse);
 	rnpgbe_napi_enable_all(mucse);
 	rnpgbe_schedule_rx_retry(mucse);
 	rnpgbe_irq_enable(mucse);
 	netif_tx_start_all_queues(netdev);
+	err = rnpgbe_send_notify(hw, true, mucse_fw_portup);
+	if (err) {
+		dev_err(&hw->pdev->dev,
+			"Failed to notify firmware that port is up: %d\n", err);
+		return err;
+	}
+	/* Open link-event handling only after the data path is ready. Reset
+	 * the snapshot at the same time so firmware reports the current state.
+	 */
+	spin_lock_irqsave(&mucse->link_lock, flags);
+	mucse->link_pending = false;
+	hw->link = false;
+	hw->speed = 0;
+	hw->duplex = 0;
+	mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
+	mucse->link_event_ready = true;
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
+	/* Firmware checks RNPGBE_LINK_ST (driver's last-received link state)
+	 * and only asserts LINK_CHANGE_EVT when it differs from the actual link
+	 * state AND link_report_en is true.
+	 */
+	err = rnpgbe_send_notify(hw, true, mucse_fw_link_report_en);
+	if (err) {
+		dev_err(&hw->pdev->dev,
+			"Failed to enable firmware link reporting: %d\n",
+			 err);
+		return err;
+	}
+
+	return 0;
 }
 
 /**
@@ -2090,3 +2165,98 @@ int rnpgbe_configure_rx(struct mucse *mucse)
 
 	return 0;
 }
+
+/**
+ * rnpgbe_process_link_event - Consume a pending link event
+ * @mucse: pointer to the device private structure
+ * @link: link status snapshot
+ * @speed: link speed snapshot
+ * @duplex: link duplex snapshot
+ *
+ * Return: true if a link event was consumed, false otherwise
+ **/
+static bool rnpgbe_process_link_event(struct mucse *mucse, bool *link,
+				      int *speed, u8 *duplex)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mucse->link_lock, flags);
+	if (!mucse->link_event_ready || !mucse->link_pending) {
+		spin_unlock_irqrestore(&mucse->link_lock, flags);
+		return false;
+	}
+	mucse->link_pending = false;
+	*link = hw->link;
+	*speed = hw->speed;
+	*duplex = hw->duplex;
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
+
+	return true;
+}
+
+/**
+ * rnpgbe_link_is_up - Update netif_carrier status and
+ * print link up message
+ * @mucse: pointer to the device private structure
+ * @speed: link speed snapshot
+ * @duplex: link duplex snapshot
+ **/
+static void rnpgbe_link_is_up(struct mucse *mucse, int speed, u8 duplex)
+{
+	struct net_device *netdev = mucse->netdev;
+
+	/* Only continue if link was previously down */
+	if (netif_carrier_ok(netdev))
+		return;
+
+	netdev_info(netdev, "NIC Link is Up %d Mbps, %s Duplex\n",
+		    speed, duplex ? "Full" : "Half");
+	netif_carrier_on(netdev);
+}
+
+/**
+ * rnpgbe_link_is_down - Update netif_carrier status and
+ * print link down message
+ * @mucse: pointer to the private structure
+ **/
+static void rnpgbe_link_is_down(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+
+	/* Only continue if link was up previously */
+	if (!netif_carrier_ok(netdev))
+		return;
+	netdev_info(netdev, "NIC Link is Down\n");
+	netif_carrier_off(netdev);
+}
+
+/**
+ * rnpgbe_process_link_subtask - Process a link-state update
+ * @mucse: pointer to the device private structure
+ **/
+static void rnpgbe_process_link_subtask(struct mucse *mucse)
+{
+	bool link;
+	int speed;
+	u8 duplex;
+
+	if (!rnpgbe_process_link_event(mucse, &link, &speed, &duplex))
+		return;
+
+	if (link)
+		rnpgbe_link_is_up(mucse, speed, duplex);
+	else
+		rnpgbe_link_is_down(mucse);
+}
+
+/**
+ * rnpgbe_service_task - Manages and runs subtasks
+ * @work: pointer to work_struct containing our data
+ **/
+void rnpgbe_service_task(struct work_struct *work)
+{
+	struct mucse *mucse = container_of(work, struct mucse, serv_task.work);
+
+	rnpgbe_process_link_subtask(mucse);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 072993494deb..8ebaa9534dac 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -72,7 +72,7 @@ void rnpgbe_free_mbx_irq(struct mucse *mucse);
 int rnpgbe_request_irq(struct mucse *mucse);
 void rnpgbe_free_irq(struct mucse *mucse);
 void rnpgbe_down(struct mucse *mucse);
-void rnpgbe_up_complete(struct mucse *mucse);
+int rnpgbe_up_complete(struct mucse *mucse);
 int rnpgbe_configure_tx(struct mucse *mucse);
 int rnpgbe_configure_rx(struct mucse *mucse);
 void rnpgbe_clean_all_tx_rings(struct mucse *mucse);
@@ -84,4 +84,5 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 			struct rtnl_link_stats64 *stats);
 int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
 void rnpgbe_free_all_rx_resources(struct mucse *mucse);
+void rnpgbe_service_task(struct work_struct *work);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 8e1eebf32723..708a7297233e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -70,6 +70,7 @@ static int rnpgbe_open(struct net_device *netdev)
 	if (test_bit(__MUCSE_AXI_FAULT, &mucse->state))
 		return -EIO;
 
+	netif_carrier_off(netdev);
 	err = rnpgbe_request_irq(mucse);
 	if (err)
 		return err;
@@ -89,9 +90,16 @@ static int rnpgbe_open(struct net_device *netdev)
 	err = rnpgbe_configure(mucse);
 	if (err)
 		goto err_free_rx;
-	rnpgbe_up_complete(mucse);
+	err = rnpgbe_up_complete(mucse);
+	if (err)
+		goto err_down;
 
 	return 0;
+err_down:
+	rnpgbe_down(mucse);
+	rnpgbe_free_all_rx_resources(mucse);
+	rnpgbe_free_all_tx_resources(mucse);
+	goto err_free_irqs;
 err_free_rx:
 	rnpgbe_free_all_rx_resources(mucse);
 err_free_tx:
@@ -249,6 +257,11 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
 		goto err_powerdown;
 	}
+	err = rnpgbe_setup_default_link(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Setup link failed %d\n", err);
+		goto err_powerdown;
+	}
 
 	err = rnpgbe_get_permanent_mac(hw, perm_addr);
 	if (!err) {
@@ -261,6 +274,11 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_powerdown;
 	}
 
+	INIT_DELAYED_WORK(&mucse->serv_task, rnpgbe_service_task);
+	spin_lock_init(&mucse->link_lock);
+	mucse->link_event_ready = false;
+	mucse->link_pending = false;
+
 	err = rnpgbe_init_interrupt_scheme(mucse);
 	if (err) {
 		dev_err(&pdev->dev, "init interrupt failed %d\n", err);
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index 2310f01df1f5..ef00b948ad0f 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -197,7 +197,8 @@ static int mucse_read_mbx_pf(struct mucse_hw *hw, __le32 *msg, u16 size)
  * mucse_check_for_msg_pf - Check to see if the fw has sent mail
  * @hw: pointer to the HW structure
  *
- * Return: 0 if the fw has set the Status bit or else -EIO
+ * Return: 0 if firmware has posted a new message, -ENOMSG if there is no
+ * new message, or -EIO if the mailbox has been reset
  **/
 static int mucse_check_for_msg_pf(struct mucse_hw *hw)
 {
@@ -209,8 +210,13 @@ static int mucse_check_for_msg_pf(struct mucse_hw *hw)
 	 * mbx command. Return -EIO if in this state, others
 	 * fw == hw->mbx.fw_req means no new msg.
 	 **/
-	if (fw_req == 0 || fw_req == hw->mbx.fw_req)
+	/* Firmware skips zero for valid FW-to-PF requests and wraps the
+	 * counter from U16_MAX to 1.
+	 **/
+	if (!fw_req)
 		return -EIO;
+	if (fw_req == hw->mbx.fw_req)
+		return -ENOMSG;
 
 	return 0;
 }
@@ -252,6 +258,68 @@ int mucse_poll_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size)
 	return mucse_read_mbx_pf(hw, msg, size);
 }
 
+/**
+ * mucse_mbx_event_begin - Lock and read a pending firmware event
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * On success the hardware mailbox remains locked. The caller must process
+ * the event and call mucse_mbx_event_end() to acknowledge it and release
+ * the hardware mailbox lock.
+ *
+ * Firmware releases the hardware mailbox lock before raising the event
+ * interrupt and does not access the shared window again until the PF
+ * acknowledges the event. Therefore, failure to acquire the lock indicates
+ * a mailbox fault rather than transient contention.
+ *
+ * Return: 0 on success, -ENOMSG if no event is pending, or another negative
+ * errno on failure
+ **/
+int mucse_mbx_event_begin(struct mucse_hw *hw, __le32 *msg, u16 size)
+{
+	const int size_in_words = size / sizeof(__le32);
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int off = MUCSE_MBX_FWPF_SHM;
+	int err;
+
+	err = mucse_check_for_msg_pf(hw);
+	if (err)
+		return err;
+
+	err = mucse_obtain_mbx_lock_pf(hw);
+	if (err)
+		return err;
+
+	/* Check again after taking ownership of the shared mailbox. */
+	err = mucse_check_for_msg_pf(hw);
+	if (err) {
+		mucse_release_mbx_lock_pf(hw, false);
+		return err;
+	}
+
+	for (int i = 0; i < size_in_words; i++)
+		msg[i] = cpu_to_le32(mbx_data_rd32(mbx, off + 4 * i));
+
+	return 0;
+}
+
+/**
+ * mucse_mbx_event_end - Acknowledge a firmware event and unlock the mailbox
+ * @hw: pointer to the HW structure
+ *
+ * Pair with a successful mucse_mbx_event_begin().
+ **/
+void mucse_mbx_event_end(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM, 0);
+	hw->mbx.fw_req = mucse_mbx_get_fwreq(mbx);
+	mucse_mbx_inc_pf_ack(hw);
+	mucse_release_mbx_lock_pf(hw, false);
+}
+
 /**
  * mucse_mbx_get_fwack - Read fw ack from reg
  * @mbx: pointer to the MBX structure
@@ -286,6 +354,36 @@ static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
 	mbx_data_wr32(mbx, MUCSE_MBX_PF2FW_CNT, val);
 }
 
+/**
+ * mucse_ack_pending_event - Acknowledge a level-like firmware event
+ * @hw: pointer to the HW structure
+ *
+ * The caller must own the hardware mailbox lock.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_ack_pending_event(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 fw_req;
+
+	fw_req = mucse_mbx_get_fwreq(mbx);
+	if (fw_req == hw->mbx.fw_req)
+		return 0;
+	if (!fw_req)
+		return -EIO;
+
+	/* Firmware only posts LINK_CHANGE_EVT asynchronously. It is level-like,
+	 * so leaving the link snapshot unchanged lets firmware report the
+	 * current state again if reporting stays enabled.
+	 */
+	mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM, 0);
+	hw->mbx.fw_req = fw_req;
+	mucse_mbx_inc_pf_ack(hw);
+
+	return 0;
+}
+
 /**
  * mucse_write_mbx_pf - Place a message in the mailbox
  * @hw: pointer to the HW structure
@@ -320,6 +418,44 @@ static int mucse_write_mbx_pf(struct mucse_hw *hw, const __le32 *msg, u16 size)
 	return 0;
 }
 
+/**
+ * mucse_write_mbx_pf_coalesce_event - Write around a level-like event
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_write_mbx_pf_coalesce_event(struct mucse_hw *hw,
+					     const __le32 *msg, u16 size)
+{
+	const int size_in_words = size / sizeof(__le32);
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int err;
+
+	err = mucse_obtain_mbx_lock_pf(hw);
+	if (err)
+		return err;
+
+	err = mucse_ack_pending_event(hw);
+	if (err)
+		goto release;
+
+	for (int i = 0; i < size_in_words; i++)
+		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4,
+			      le32_to_cpu(msg[i]));
+
+	hw->mbx.fw_ack = mucse_mbx_get_fwack(mbx);
+	mucse_mbx_inc_pf_req(hw);
+	mucse_release_mbx_lock_pf(hw, true);
+
+	return 0;
+
+release:
+	mucse_release_mbx_lock_pf(hw, false);
+	return err;
+}
+
 /**
  * mucse_check_for_ack_pf - Check to see if the fw has ACKed
  * @hw: pointer to the HW structure
@@ -381,6 +517,33 @@ int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, const __le32 *msg,
 	return mucse_poll_for_ack(hw);
 }
 
+/**
+ * mucse_write_mbx_coalesce_event - Send a command while coalescing an event
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * A pending link event is acknowledged without updating its snapshot, then
+ * the PF command is written while the hardware mailbox remains locked. If
+ * event reporting remains enabled, firmware reports the event again because
+ * its snapshot still differs from the hardware state. This function waits
+ * for firmware to acknowledge the PF command before returning.
+ *
+ * Return: 0 after firmware acknowledges the command, negative errno on
+ * failure
+ **/
+int mucse_write_mbx_coalesce_event(struct mucse_hw *hw,
+				   const __le32 *msg, u16 size)
+{
+	int err;
+
+	err = mucse_write_mbx_pf_coalesce_event(hw, msg, size);
+	if (err)
+		return err;
+
+	return mucse_poll_for_ack(hw);
+}
+
 /**
  * mucse_mbx_reset - Reset mbx info, sync info from regs
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index 75b88b18b04d..50597dd9dde9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -16,6 +16,10 @@
 
 int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw,
 				 const __le32 *msg, u16 size);
+int mucse_write_mbx_coalesce_event(struct mucse_hw *hw,
+				   const __le32 *msg, u16 size);
 void mucse_init_mbx_params_pf(struct mucse_hw *hw);
 int mucse_poll_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size);
+int mucse_mbx_event_begin(struct mucse_hw *hw, __le32 *msg, u16 size);
+void mucse_mbx_event_end(struct mucse_hw *hw);
 #endif /* _RNPGBE_MBX_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index e28f3193aa85..683e0ea74113 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -3,6 +3,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/bitfield.h>
+#include <linux/pci.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_mbx.h"
@@ -199,12 +200,283 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 }
 
 /**
- * mucse_fw_irq_handler - Deferred firmware mailbox notification hook
+ * mucse_mbx_set_link - Configure firmware link settings
  * @hw: pointer to the HW structure
+ * @advertising: firmware link-mode advertisement mask
+ * @autoneg: whether to enable autonegotiation
+ * @speed: forced link speed when autonegotiation is disabled
+ * @duplex: forced duplex mode when autonegotiation is disabled
+ * @mdix_ctrl: MDI/MDI-X control mode
  *
- * No asynchronous firmware events are enabled until link status support is
- * added.
+ * Firmware ignores @speed, @duplex when @autoneg is true.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
+		       u32 speed, u32 duplex, u32 mdix_ctrl)
+{
+	union mbx_fw_cmd_req_u req = {
+		.r = {
+			.datalen = cpu_to_le16(sizeof(req.r.phy_link_set) +
+					       MUCSE_MBX_REQ_HDR_LEN),
+			.opcode = cpu_to_le16(PHY_LINK_SET),
+			.phy_link_set = {
+				.adv_speed_mask = cpu_to_le32(advertising),
+				.autoneg = cpu_to_le32(autoneg),
+				.speed = cpu_to_le32(speed),
+				.duplex = cpu_to_le32(duplex),
+				.nr_lane = cpu_to_le32(hw->port),
+				.tp_mdix_ctrl = cpu_to_le32(mdix_ctrl),
+			},
+		},
+	};
+	int len, err;
+
+	len = le16_to_cpu(req.r.datalen);
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_phyup - Request that firmware bring the PHY up or down
+ * @hw: pointer to the HW structure
+ * @is_phyup: true for up, false for down
+ *
+ * mucse_mbx_phyup echo fw to change phy status
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_phyup(struct mucse_hw *hw, bool is_phyup)
+{
+	union mbx_fw_cmd_req_u req = {
+		.r = {
+			.datalen = cpu_to_le16(sizeof(req.r.phy_status) +
+					       MUCSE_MBX_REQ_HDR_LEN),
+			.opcode  = cpu_to_le16(SET_PHY_UP),
+			.phy_status = {
+				.port_mask = cpu_to_le32(BIT(hw->port)),
+				.status  = cpu_to_le32(is_phyup ? 1 : 0),
+			},
+		},
+	};
+	int len, err;
+
+	len = le16_to_cpu(req.r.datalen);
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_mbx_coalesce_event(hw, req.dwords, len);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_link_report - Configure firmware link-change event reporting
+ * @hw: pointer to the HW structure
+ * @is_report: true for report, false for no
+ *
+ * mucse_mbx_link_report echo fw to change event report state
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_link_report(struct mucse_hw *hw, bool is_report)
+{
+	union mbx_fw_cmd_req_u req = {
+		.r = {
+			.datalen = cpu_to_le16(sizeof(req.r.report_status) +
+					       MUCSE_MBX_REQ_HDR_LEN),
+			.opcode  = cpu_to_le16(LINK_REPORT_EN),
+			.report_status = {
+				.port_mask = cpu_to_le16(BIT(hw->port)),
+				.status  = cpu_to_le16(is_report ? 1 : 0),
+			},
+		},
+	};
+	int len, err;
+
+	len = le16_to_cpu(req.r.datalen);
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_mbx_coalesce_event(hw, req.dwords, len);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+static bool mucse_link_speed_valid(const struct mbx_fw_cmd_req *req)
+{
+	switch (le16_to_cpu(req->link_stat.st.speed)) {
+	case 10:
+	case 100:
+	case 1000:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mucse_link_is_up(const struct mucse_hw *hw,
+			     const struct mbx_fw_cmd_req *req)
+{
+	return le16_to_cpu(req->link_stat.port_status) & BIT(hw->port);
+}
+
+/**
+ * mucse_update_link_status_reg - update driver speed inf to reg
+ * @hw: pointer to the HW structure
+ * @req: pointer to req data
+ *
+ * Update the driver's link-state snapshot exported to firmware. Firmware
+ * sends a new event when this snapshot differs from the hardware state.
+ * The default snapshot clears the driver-reported fields;
+ * a valid event then repopulates them, including the LLDP status in bit 6.
+ *
+ **/
+static void mucse_update_link_status_reg(struct mucse_hw *hw,
+					 struct mbx_fw_cmd_req *req)
+{
+	u16 status = le16_to_cpu(req->link_stat.st.status);
+	u16 speed = le16_to_cpu(req->link_stat.st.speed);
+	u32 value;
+
+	value = M_DEFAULT_ST;
+
+	if (mucse_link_is_up(hw, req)) {
+		value |= BIT(0);
+		switch (speed) {
+		case 10:
+			value |= (mucse_speed_10 << 8);
+			break;
+		case 100:
+			value |= (mucse_speed_100 << 8);
+			break;
+		case 1000:
+			value |= (mucse_speed_1000 << 8);
+			break;
+		default:
+			break;
+		}
+
+		value |= FIELD_PREP(BIT(4),
+				    !!(req->link_stat.st.flags & DUPLEX_BIT));
+		value |= FIELD_PREP(GENMASK_U32(25, 24),
+				    status & GENMASK(1, 0));
+	} else {
+		value &= ~BIT(0);
+	}
+
+	if (status & ST_STATUS_LLDP_STATUS_MASK)
+		value |= BIT(6);
+	else
+		value &= ~BIT(6);
+
+	mucse_hw_wr32(hw, RNPGBE_LINK_ST, value);
+}
+
+/**
+ * mucse_mbx_fw_req_handler - Handle fw req
+ * @hw: pointer to the HW structure
+ * @req: pointer to req data
+ *
+ * mucse_mbx_fw_req_handler handler fw req, such as a link event req.
+ **/
+static void mucse_mbx_fw_req_handler(struct mucse_hw *hw,
+				     struct mbx_fw_cmd_req *req)
+{
+	struct mucse *mucse = container_of(hw, struct mucse, hw);
+	u32 magic = le32_to_cpu(req->link_stat.port_magic);
+	unsigned long flags;
+
+	if (le16_to_cpu(req->opcode) == LINK_CHANGE_EVT) {
+		u16 speed = le16_to_cpu(req->link_stat.st.speed);
+
+		spin_lock_irqsave(&mucse->link_lock, flags);
+		if (magic != ST_VALID_MAGIC) {
+			/* Do not change the cached state for an invalid event.
+			 * Use an invalid speed encoding to make firmware report
+			 * again.
+			 */
+			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_INVALID_ST);
+			spin_unlock_irqrestore(&mucse->link_lock, flags);
+			return;
+		}
+
+		if (mucse_link_is_up(hw, req) &&
+		    !mucse_link_speed_valid(req)) {
+			/* Do not acknowledge an invalid speed as valid.
+			 * Keep the snapshot mismatched so firmware retries it.
+			 * Firmware limits link reports to one per 500 ms.
+			 */
+			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_INVALID_ST);
+			spin_unlock_irqrestore(&mucse->link_lock, flags);
+			dev_warn_ratelimited(&hw->pdev->dev,
+					     "unsupported link speed %u Mbps\n",
+					     speed);
+			return;
+		}
+
+		if (!mucse->link_event_ready) {
+			rnpgbe_set_link(hw, false);
+			mucse_update_link_status_reg(hw, req);
+			spin_unlock_irqrestore(&mucse->link_lock, flags);
+			return;
+		}
+
+		if (mucse_link_is_up(hw, req))
+			hw->link = true;
+		else
+			hw->link = false;
+
+		hw->speed = le16_to_cpu(req->link_stat.st.speed);
+		hw->duplex = req->link_stat.st.flags & DUPLEX_BIT;
+		rnpgbe_set_link(hw, mucse_link_is_up(hw, req));
+		/* update regs to notify link info is received */
+		mucse_update_link_status_reg(hw, req);
+		mucse->link_pending = true;
+		/* Run link handling immediately. */
+		mod_delayed_work(system_percpu_wq, &mucse->serv_task, 0);
+		spin_unlock_irqrestore(&mucse->link_lock, flags);
+	}
+}
+
+/**
+ * mucse_fw_handle_event - Handle one pending firmware event
+ * @hw: pointer to the hardware structure
+ **/
+static void mucse_fw_handle_event(struct mucse_hw *hw)
+{
+	union mbx_fw_cmd_req_u msg = {};
+	int err;
+
+	/* try to check and read fw req */
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_mbx_event_begin(hw, msg.dwords, sizeof(msg));
+	/* A PF command may have coalesced the event before stale mailbox work
+	 * runs, in which case there is no event left to handle.
+	 */
+	if (err) {
+		mutex_unlock(&hw->mbx.lock);
+		if (err != -ENOMSG)
+			dev_warn_ratelimited(&hw->pdev->dev,
+					     "failed to read firmware event: %d\n",
+					     err);
+		return;
+	}
+
+	mucse_mbx_fw_req_handler(hw, &msg.r);
+	mucse_mbx_event_end(hw);
+	mutex_unlock(&hw->mbx.lock);
+}
+
+/**
+ * mucse_fw_irq_handler - Handle one pending firmware mailbox event
+ * @hw: pointer to the HW structure
+ *
+ * Process at most one event per work-item invocation. The caller requeues
+ * mailbox work when a dedicated mailbox interrupt arrives during handling.
  **/
 void mucse_fw_irq_handler(struct mucse_hw *hw)
 {
+	mucse_fw_handle_event(hw);
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index a6bf5de55aa3..93ce0e796442 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -14,9 +14,19 @@ enum MUCSE_FW_CMD {
 	GET_HW_INFO     = 0x0601,
 	GET_MAC_ADDRESS = 0x0602,
 	RESET_HW        = 0x0603,
+	LINK_CHANGE_EVT = 0x0608,
+	LINK_REPORT_EN  = 0x0613,
+	PHY_LINK_SET    = 0x0630,
+	SET_PHY_UP      = 0x0800,
 	POWER_UP        = 0x0803,
 };
 
+#define RNPGBE_FW_ADV_10_FULL		BIT(2)
+#define RNPGBE_FW_ADV_100_FULL		BIT(3)
+#define RNPGBE_FW_ADV_1000_FULL		BIT(4)
+#define RNPGBE_FW_ADV_10_HALF		BIT(10)
+#define RNPGBE_FW_ADV_100_HALF		BIT(11)
+
 struct mucse_hw_info {
 	u8 link_stat;
 	u8 port_mask;
@@ -36,6 +46,16 @@ struct mucse_hw_info {
 	__le32 ext_info;
 } __packed;
 
+#define ST_STATUS_LLDP_STATUS_MASK        BIT(12)
+
+#define DUPLEX_BIT                        BIT(0)
+struct st_status {
+	u8 phyid;
+	u8 flags;
+	__le16 speed;
+	__le16 status;
+} __packed;
+
 struct mbx_fw_cmd_req {
 	__le16 flags;
 	__le16 opcode;
@@ -55,6 +75,32 @@ struct mbx_fw_cmd_req {
 			__le32 port_mask;
 			__le32 pfvf_num;
 		} get_mac_addr;
+		struct {
+			__le32 port_mask;
+			__le32 status;
+		} phy_status;
+		struct {
+			__le32 adv_speed_mask;
+			__le32 autoneg;
+			__le32 speed;
+			__le32 duplex;
+			__le32 nr_lane;
+			__le32 tp_mdix_ctrl;
+		} phy_link_set;
+		struct {
+			/* LINK_REPORT_EN uses its own 16-bit payload layout:
+			 * status precedes port_mask.
+			 */
+			__le16 status;
+			__le16 port_mask;
+		} report_status;
+		struct {
+			__le16 changed_lanes;
+			__le16 port_status;
+			__le32 port_magic;
+#define ST_VALID_MAGIC 0xa4a6a8a9
+			struct st_status st;
+		} link_stat;
 	};
 } __packed;
 
@@ -94,10 +140,23 @@ union mbx_fw_cmd_reply_u {
 	__le32 dwords[sizeof(struct mbx_fw_cmd_reply) / sizeof(__le32)];
 };
 
+/* Firmware encoding for RNPGBE_LINK_ST[11:8]. Valid link events report
+ * only these three speeds.
+ */
+enum mucse_speed {
+	mucse_speed_10 = 0,
+	mucse_speed_100 = 1,
+	mucse_speed_1000 = 2,
+};
+
 int mucse_mbx_sync_fw(struct mucse_hw *hw);
 int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup);
 int mucse_mbx_reset_hw(struct mucse_hw *hw);
 int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			  u8 *mac_addr, int port);
+int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
+		       u32 speed, u32 duplex, u32 mdix_ctrl);
+int mucse_mbx_phyup(struct mucse_hw *hw, bool is_phyup);
+int mucse_mbx_link_report(struct mucse_hw *hw, bool is_report);
 void mucse_fw_irq_handler(struct mucse_hw *hw);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.50.1


