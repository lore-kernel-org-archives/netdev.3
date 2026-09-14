Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85C2D77F7;
	Mon, 14 Sep 2026 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349646; cv=none; b=Ld2Fuc+gpLI7mrBf/zycatdlic+gGGM7zIkluv7fXL1q7aci70xMCOv2TMI+grkxvC2PAwyOuXkEkPr1aBJ6nbUtNtVqS9WXrHU9LIQswADj+p4vkUPf7CAUbbdFiN6oJgzVkT6tmJPtlR5IYKVT2JOcQLtmp8TY8if+3Hg5oYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349646; c=relaxed/simple;
	bh=fhq9F847KLLl8iTSlLgEG7A5r35JwYfmz5wNCpT4p9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhKsdKxl/kfM1wjWDUAJHHJqg/M7UTbu5g4F0ny0utKlx4VDaKnrBJiTJ+HytbrDdlTZZF3PsG1fJo72K+DtxNHlUQyWwwSOYPA6hoQZKGcgssf32u2cX2zcQNP0E2IBZgu5twXlLCMD/ww/k+kih0XcxYUKeVWcjtPp5jZICB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1789349575t3e99e169
X-QQ-Originating-IP: iqo3JHZeptl5ZKG/aVsZr7pRJelEvGyjmP1kGaTi6Rg=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Sep 2026 09:32:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10721695394234581193
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
Subject: [PATCH net-next v12 5/5] net: rnpgbe: Add link status handling support
Date: Mon, 14 Sep 2026 09:32:51 +0800
Message-ID: <37722C0F45E58956+20260914013251.2262704-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <64BE41C2D2C0836A+20260914013019.2262317-1-dong100@mucse.com>
References: <64BE41C2D2C0836A+20260914013019.2262317-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MTGYztYhR5ET+Q/fgzZ1397/gOZ/hauYyr0jHv+sKR+G8qGa7BT2EFdD
	SkduFPfMRbs2wn1Xzq2tRpZkyB/ZW/eDBaNfjKmIA6IRzlSQhRdEq3p5Ob6pRZEi+5fsrnf
	noLtjuVqyojk/F/4YyYiIPN/cfR7uIE4RJsgs4gCRm9Mxr36gUgtXIJ6rxKmN81MPa45zNp
	J/fflyZRiHXq3tGCgkzAXyP79p464KAx2uOCZknGzIc/z09asYbj5x2qE7cqnUTr8AjXKqq
	0Y7P6HaCyyepGUi63xk1jIMuBLfUByl89RKhOKTf01mF6YG4GOlRv72jMjN/lA6HAxUs+0A
	sMsHEBed/eKx5cUKjMKqTpIbx6lPC4GnpuO/SW1oTAU9YJd8MnANGKCWfu03nHaCyPSIJSu
	7y1aIMJLmMMNNEjY4E4mZTRXJ0wT834GMv5OyF6TjNkyZtgGmT30ykMYNl6BQmslwZCxmtb
	AzoOc5lU2RPyUfugAIqqvizmiZwHbjRgTWOx2dEHKeQs0zf0F22BwifKjRNWKzn4N97ichY
	1umodz3AMB4yH4vN6n4q2zHHJDCzDSRLghUBzHvtUoTMdf81sZ/ZN2B4NNEfqWem5lfJOM5
	UdbCWusJWvK4NtxlyR1GiSkaXhFPan0+xooQgevGvfD75aPDo3qgfxdVF8NzgNPMQdFz3Me
	5csI6m4FqtLurOdwh07RHzp1PpaWEgpNKQ4yCdg/Xbu2dK0WgV4BQTzxGnGNZOnhboeYE0K
	N/oD/1sHvoeSpg5wgCIdOs2byZVMBq4siiVMZ+JN/yHPB3QibI4xslusp4qukKZVSXhiKL1
	ixBmjq7X+X3+8ar+DyeZahVjfRhzDjA/amxpH1F3rq/Teg0ikyvRUyOJpabPEL7BZracN+q
	utY0mzHkTXQdNmCMljVQyZ/iT8zM/bKnl808RruLJibYV2IqPd+8Fniq+Kb49ZY3XGjYK/v
	gnGh5tVu4PULl3xSYgS6mQw6rBlOeSojQuqbf5su3xxcZ3goG0wZwY5mYqdPnCEoCR91chJ
	FejFW+4SoDm7KFqJsBWPcqDgdyQx450O2xYjGY2QK9TbRqmQaUw7MQVayXFoxO+vPV24HKK
	I/0EXKpqw9G
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  14 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  35 ++-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 189 +++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   3 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  15 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  20 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 230 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  42 ++++
 10 files changed, 556 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index e85e26319a4d..dfd82d919828 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/rcupdate.h>
@@ -33,11 +34,10 @@ struct mucse_mbx_info {
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
@@ -46,8 +46,11 @@ struct mucse_hw {
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
@@ -223,7 +226,11 @@ struct mucse {
 	int num_rx_queues;
 	char mbx_name[32];
 	unsigned long state;
+	atomic_t link_pending;
+	atomic_t mbx_irq_seq;
 	struct work_struct mbx_work;
+	struct delayed_work serv_task;
+	spinlock_t link_lock; /* spinlock for link update */
 };
 
 int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
@@ -233,6 +240,7 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
 		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 void rnpgbe_set_rx_mode(struct net_device *netdev);
+void rnpgbe_set_link(struct mucse_hw *hw, bool linkup);
 
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 4e2835b71f32..798e4fa3905a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -66,11 +66,17 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
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
@@ -224,3 +230,30 @@ void rnpgbe_set_rx_mode(struct net_device *netdev)
 	mucse_hw_wr32(hw, RNPGBE_RX_MCAST_CTRL, mcast_ctrl);
 	mucse_hw_wr32(hw, RNPGBE_RX_FILTER_CTRL, filter_ctrl);
 }
+
+/**
+ * rnpgbe_set_link - Set the hardware link state
+ * @hw: hw information structure
+ * @linkup: link on or not
+ *
+ * rnpgbe_set_link setup link status
+ *
+ **/
+void rnpgbe_set_link(struct mucse_hw *hw, bool linkup)
+{
+	u32 value = mucse_hw_rd32(hw, GMAC_CONTROL);
+
+	/* The chip-level filter is programmed by ndo_set_rx_mode(). Keep the
+	 * GMAC in receive-all mode so it does not discard frames accepted by
+	 * that filter.
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
index feb84704d602..5659e91f3497 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -21,6 +21,17 @@
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
 
@@ -39,5 +50,11 @@
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
index e4b7ff992c4d..8b73bd4bb5db 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -16,8 +16,15 @@
 static void rnpgbe_mbx_work(struct work_struct *work)
 {
 	struct mucse *mucse = container_of(work, struct mucse, mbx_work);
+	int irq_seq;
 
+	irq_seq = atomic_read(&mucse->mbx_irq_seq);
 	mucse_fw_irq_handler(&mucse->hw);
+
+	/* A mailbox interrupt while this work runs needs another invocation. */
+	if (irq_seq != atomic_read(&mucse->mbx_irq_seq) &&
+	    !test_bit(__MUCSE_DOWN, &mucse->state))
+		queue_work(system_percpu_wq, &mucse->mbx_work);
 }
 
 /**
@@ -31,6 +38,7 @@ static irqreturn_t rnpgbe_msix_other(int irq, void *data)
 {
 	struct mucse *mucse = (struct mucse *)data;
 
+	atomic_inc(&mucse->mbx_irq_seq);
 	queue_work(system_percpu_wq, &mucse->mbx_work);
 
 	return IRQ_HANDLED;
@@ -666,6 +674,7 @@ int rnpgbe_request_mbx_irq(struct mucse *mucse)
 	snprintf(mucse->mbx_name, sizeof(mucse->mbx_name),
 		 "rnpgbe-mbx:%s", pci_name(pdev));
 	INIT_WORK(&mucse->mbx_work, rnpgbe_mbx_work);
+	atomic_set(&mucse->mbx_irq_seq, 0);
 
 	err = request_irq(pci_irq_vector(pdev, 0), rnpgbe_msix_other, 0,
 			  mucse->mbx_name, mucse);
@@ -1372,10 +1381,23 @@ static void rnpgbe_cancel_rx_retry_timers(struct mucse *mucse)
 bool rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	int err;
 
 	if (test_and_set_bit(__MUCSE_DOWN, &mucse->state))
 		return false;
 
+	spin_lock_irqsave(&mucse->link_lock, flags);
+	WRITE_ONCE(hw->link, false);
+	WRITE_ONCE(hw->speed, 0);
+	WRITE_ONCE(hw->duplex, 0);
+	atomic_set(&mucse->link_pending, 0);
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
+	cancel_delayed_work_sync(&mucse->serv_task);
+	rnpgbe_set_link(hw, false);
+
+	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 	rnpgbe_irq_disable(mucse);
 	rnpgbe_napi_disable_all(mucse);
@@ -1384,6 +1406,20 @@ bool rnpgbe_down(struct mucse *mucse)
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
+	err = rnpgbe_send_notify(hw, false, mucse_fw_portup);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send port down to hw failed %d\n",
+			 err);
+		dev_warn(&hw->pdev->dev, "Port is not truly down\n");
+	}
 	rnpgbe_clean_all_rx_rings(mucse);
 
 	return true;
@@ -1392,17 +1428,60 @@ bool rnpgbe_down(struct mucse *mucse)
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
+	/* Clear stale link state and tell firmware the driver hasn't
+	 * seen any link yet. Firmware will re-assert LINK_CHANGE_EVT
+	 * when link_report_en is sent below since RNPGBE_LINK_ST
+	 * no longer matches the actual (possibly up) link state.
+	 */
+	spin_lock_irqsave(&mucse->link_lock, flags);
+	WRITE_ONCE(hw->link, false);
+	WRITE_ONCE(hw->speed, 0);
+	WRITE_ONCE(hw->duplex, 0);
+	atomic_set(&mucse->link_pending, 0);
+	/* echo fw driver now in default state */
+	mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
+	/* Keep the default snapshot and DOWN state transition atomic to
+	 * mailbox link-event handling.
+	 */
 	clear_bit(__MUCSE_DOWN, &mucse->state);
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
 	rnpgbe_schedule_rx_retry(mucse);
 	rnpgbe_irq_enable(mucse);
 	netif_tx_start_all_queues(netdev);
+	err = rnpgbe_send_notify(hw, true, mucse_fw_portup);
+	if (err) {
+		dev_err(&hw->pdev->dev,
+			"Failed to notify firmware that port is up: %d\n", err);
+		return err;
+	}
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
+	queue_delayed_work(system_percpu_wq, &mucse->serv_task,
+			   msecs_to_jiffies(500));
+
+	return 0;
 }
 
 /**
@@ -2059,3 +2138,111 @@ int rnpgbe_configure_rx(struct mucse *mucse)
 
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
+	if (!atomic_xchg(&mucse->link_pending, 0))
+		return false;
+
+	spin_lock_irqsave(&mucse->link_lock, flags);
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
+	struct mucse_hw *hw = &mucse->hw;
+
+	/* Only continue if link was previously down */
+	if (netif_carrier_ok(netdev))
+		return;
+
+	netdev_info(netdev, "NIC Link is Up %d Mbps, %s Duplex\n",
+		    speed, duplex ? "Full" : "Half");
+	rnpgbe_set_link(hw, true);
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
+	struct mucse_hw *hw = &mucse->hw;
+
+	/* Only continue if link was up previously */
+	if (!netif_carrier_ok(netdev))
+		return;
+	netdev_info(netdev, "NIC Link is Down\n");
+	rnpgbe_set_link(hw, false);
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
+	/* if interface is down do nothing */
+	if (test_bit(__MUCSE_DOWN, &mucse->state))
+		return;
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
+	if (test_bit(__MUCSE_DOWN, &mucse->state))
+		return;
+
+	rnpgbe_process_link_subtask(mucse);
+
+	if (!test_bit(__MUCSE_DOWN, &mucse->state))
+		queue_delayed_work(system_percpu_wq, &mucse->serv_task,
+				   msecs_to_jiffies(500));
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 234b3bff94c4..27c0acebb58f 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -68,7 +68,7 @@ int rnpgbe_request_irq(struct mucse *mucse);
 void rnpgbe_free_irq(struct mucse *mucse);
 void rnpgbe_irq_disable(struct mucse *mucse);
 bool rnpgbe_down(struct mucse *mucse);
-void rnpgbe_up_complete(struct mucse *mucse);
+int rnpgbe_up_complete(struct mucse *mucse);
 int rnpgbe_configure_tx(struct mucse *mucse);
 int rnpgbe_configure_rx(struct mucse *mucse);
 void rnpgbe_clean_all_tx_rings(struct mucse *mucse);
@@ -80,4 +80,5 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 			struct rtnl_link_stats64 *stats);
 int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
 void rnpgbe_free_all_rx_resources(struct mucse *mucse);
+void rnpgbe_service_task(struct work_struct *work);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index ab46d9b8aaca..bd87af9f625b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -67,6 +67,7 @@ static int rnpgbe_open(struct net_device *netdev)
 	if (test_bit(__MUCSE_AXI_FAULT, &mucse->state))
 		return -EIO;
 
+	netif_carrier_off(netdev);
 	err = rnpgbe_request_irq(mucse);
 	if (err)
 		return err;
@@ -86,9 +87,16 @@ static int rnpgbe_open(struct net_device *netdev)
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
@@ -252,6 +260,10 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_powerdown;
 	}
 
+	INIT_DELAYED_WORK(&mucse->serv_task, rnpgbe_service_task);
+	spin_lock_init(&mucse->link_lock);
+	atomic_set(&mucse->link_pending, 0);
+
 	err = rnpgbe_init_interrupt_scheme(mucse);
 	if (err) {
 		dev_err(&pdev->dev, "init interrupt failed %d\n", err);
@@ -276,6 +288,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		netdev->hw_features |= NETIF_F_HIGHDMA;
 	}
 
+	netif_carrier_off(netdev);
 	err = register_netdev(netdev);
 	if (err)
 		goto err_remove_mbx;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index 2310f01df1f5..185465d4e0dc 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -252,6 +252,26 @@ int mucse_poll_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size)
 	return mucse_read_mbx_pf(hw, msg, size);
 }
 
+/**
+ * mucse_check_and_read_mbx - check if there is notification and receive message
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * Return: 0 if it successfully received a message notification and
+ * copied it into the receive buffer, negative errno on failure
+ **/
+int mucse_check_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size)
+{
+	int err;
+
+	err = mucse_check_for_msg_pf(hw);
+	if (err)
+		return err;
+
+	return mucse_read_mbx_pf(hw, msg, size);
+}
+
 /**
  * mucse_mbx_get_fwack - Read fw ack from reg
  * @mbx: pointer to the MBX structure
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index 75b88b18b04d..3af008a67fb1 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -18,4 +18,5 @@ int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw,
 				 const __le32 *msg, u16 size);
 void mucse_init_mbx_params_pf(struct mucse_hw *hw);
 int mucse_poll_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size);
+int mucse_check_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size);
 #endif /* _RNPGBE_MBX_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index e28f3193aa85..9a40c73f357f 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -3,6 +3,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/bitfield.h>
+#include <linux/pci.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_mbx.h"
@@ -199,12 +200,235 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 }
 
 /**
- * mucse_fw_irq_handler - Deferred firmware mailbox notification hook
+ * mucse_mbx_phyup - Request that firmware bring the PHY up or down
  * @hw: pointer to the HW structure
+ * @is_phyup: true for up, false for down
  *
- * No asynchronous firmware events are enabled until link status support is
- * added.
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
+	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
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
+	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
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
+			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
+			spin_unlock_irqrestore(&mucse->link_lock, flags);
+			dev_warn_ratelimited(&hw->pdev->dev,
+					     "unsupported link speed %u Mbps\n",
+					     speed);
+			return;
+		}
+
+		if (test_bit(__MUCSE_DOWN, &mucse->state)) {
+			mucse_update_link_status_reg(hw, req);
+			spin_unlock_irqrestore(&mucse->link_lock, flags);
+			return;
+		}
+
+		if (mucse_link_is_up(hw, req))
+			WRITE_ONCE(hw->link, true);
+		else
+			WRITE_ONCE(hw->link, false);
+
+		WRITE_ONCE(hw->speed, le16_to_cpu(req->link_stat.st.speed));
+		WRITE_ONCE(hw->duplex, req->link_stat.st.flags & DUPLEX_BIT);
+		/* update regs to notify link info is received */
+		mucse_update_link_status_reg(hw, req);
+		atomic_set_release(&mucse->link_pending, 1);
+		/* Run link handling immediately; the service task also remains
+		 * periodically scheduled for future maintenance work.
+		 */
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
+	err = mucse_check_and_read_mbx(hw, msg.dwords, sizeof(msg));
+	mutex_unlock(&hw->mbx.lock);
+	/* Firmware releases the mailbox lock before raising the interrupt and
+	 * waits for the ACK. A failure is not transient contention to retry.
+	 */
+	if (err)
+		return;
+
+	mucse_mbx_fw_req_handler(hw, &msg.r);
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
index a6bf5de55aa3..7480732c102c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -14,6 +14,9 @@ enum MUCSE_FW_CMD {
 	GET_HW_INFO     = 0x0601,
 	GET_MAC_ADDRESS = 0x0602,
 	RESET_HW        = 0x0603,
+	LINK_CHANGE_EVT = 0x0608,
+	LINK_REPORT_EN  = 0x0613,
+	SET_PHY_UP      = 0x0800,
 	POWER_UP        = 0x0803,
 };
 
@@ -36,6 +39,16 @@ struct mucse_hw_info {
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
@@ -55,6 +68,24 @@ struct mbx_fw_cmd_req {
 			__le32 port_mask;
 			__le32 pfvf_num;
 		} get_mac_addr;
+		struct {
+			__le32 port_mask;
+			__le32 status;
+		} phy_status;
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
 
@@ -94,10 +125,21 @@ union mbx_fw_cmd_reply_u {
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
+int mucse_mbx_phyup(struct mucse_hw *hw, bool is_phyup);
+int mucse_mbx_link_report(struct mucse_hw *hw, bool is_report);
 void mucse_fw_irq_handler(struct mucse_hw *hw);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.50.1

