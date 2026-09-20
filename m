Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB43E51E4;
	Sun, 20 Sep 2026 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896475; cv=none; b=rl288J9LOGd2i+NQutFoNC1JA2FzpMMKfTdhsqP7fl4uh0TwEkL66++f53ONFgseJU+1BlaiLr4MlfPmTrsrqczahA0esdr0pe/BVNpZ4za4kyYW45OKEXHfRIE9imn6C1UZII1+MBsYZmTEb3w1lNmmZCvvng0v7ahho6+hNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896475; c=relaxed/simple;
	bh=nQ6IzEryi3nz6wxgeDZUCbYsoZ+YAv77pLjg4htTm1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJxXNW0iNEd/WMRL0SWiP7PHTM5ijxU5N3TwowOyfJOCmZwMILQ3UnHxIKO8vSTCd01bH5Eu//MdrZRHBBLNCdPZAxES0tz3RvMxM6xgtjgED0dHcoJTaR7bSe6Zreiprb+rllBC8rkQjtZhIMJTf/oO6E7mOlar4/rK/EGA1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz6t1789896424t4e4cbacb
X-QQ-Originating-IP: b3kW9XhTQyVeiiuFQD/3VCtiOt6wA6o3uqVOqwFupl0=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Sep 2026 17:27:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15872735073132448030
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
Subject: [PATCH net-next v13 5/5] net: rnpgbe: Add link status handling support
Date: Sun, 20 Sep 2026 17:27:00 +0800
Message-ID: <DC59A6B88E791E22+20260920092700.345667-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <B8AF0FDE24FAFB51+20260920092424.345309-1-dong100@mucse.com>
References: <B8AF0FDE24FAFB51+20260920092424.345309-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N+ARrNpmMERciaTr23Q6VUpaTJ618Tj5u3LKvvriSvtvdZXg6pvKG36a
	YePYGLSJ1DolRUGiyJr5WjzBaM5LvTfy4FxfsWCEb9UWtfv9+udlaBTreBFhhR0PmAvt7lf
	slr/SXYxE7/2MoTOM+wBPeClqtCGR9FAbEdHf17vq96Td6QPQNYry+WD5gCKSnPbRHrApPN
	zR3y+lNYp/a8xZiJaCR8wz5PHregEvYur/HgJBcQywPNLtye40AfU4ToAgiTT7+P8HL/E7V
	VfVj2mJwb2H3GQAJpQ54JzyDaCISKr4FFqos20ZGpUepY4GKAkpHubTA/Gcd3tVI3Rk7sdC
	iW7nDZ4MwVX7UelsWQlqgzunIGXQ0pjyEXuFsiuwcXHjLOW5CQTkjrdq/hWRbVCDXG/vU82
	Kis65Bg+obWzyhLNnxNcgSpNAMWh6c0CATbaiLzdgDw/9ZRV/bDQhWcstMGWpTld0VmyYmY
	A4S4Kdy7ouiJ/S+MXsiVUaHfGKSkb6Oq1fEooV3eLqHBdVM5pzqrweaoDq0i2W5W45lNriW
	wJCKOpySO6ipedFHl3i8e/zeNxu5qcH9jZk57YVyudG/cigwoxEH1DAuLqLhCCfUgPBHlce
	8ZRFfxrti7Mihd16HpTIHyWB9iXtGIQcFUeTkYzIr0WZx3tmpDjbLmmqcAh9wwmEjvQ2vSP
	gqWiznMDXDk0nD46k1ATnCiaF1yXbuRynYiPayonshHwlR9TP/gbbBg2cdf8qFqTMEJO8cK
	mANzTyWwIKY9qn5BEw17o277AxKeakOk1zySaVW5lZvwoNovkXN5G5Oo79VYCBIfsXqorGr
	fy40sWDabEZx26Q2t0Kl8bf3WvScd+PbVJSEn9ezhegCE1KqOjBFGBwO+HTa5aX2g79dzXs
	dFMgo9kdg1UiyDzQ92kGwesh7Z8v01wdxy3VVNzGEhc8XkLGnKQXIx3pDgQj7nQ1zE9Cmrr
	QkomU2eRE7tvb4dL5fcKkqRoQumGwXc3KUHZtsiw0PAE6+SvUYoUii+OO20NkMi+10P2F2w
	4z4MOG3SC3aeHjSOxhXtCSd3PD2ScbVuV8eo96Z7q3vSTcS54FJRZAMe5bns3HTNiRnxa1h
	qe2KoyFfxGyfO2+koysl7Q=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  15 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  54 +++-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 173 ++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   3 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  20 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 169 ++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 278 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  59 ++++
 10 files changed, 776 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index bd7491671e1e..10aff417b647 100644
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
@@ -222,16 +225,22 @@ struct mucse {
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
 int rnpgbe_reset_hw(struct mucse_hw *hw);
+int rnpgbe_setup_default_link(struct mucse_hw *hw);
 int rnpgbe_send_notify(struct mucse_hw *hw,
 		       bool enable,
 		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 void rnpgbe_set_rx_mode(struct net_device *netdev);
+void rnpgbe_set_link(struct mucse_hw *hw, bool linkup);
 
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 4e2835b71f32..b56263de4a36 100644
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
@@ -224,3 +249,30 @@ void rnpgbe_set_rx_mode(struct net_device *netdev)
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
index 9afd10273a62..2a5349f03a02 100644
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
@@ -664,6 +671,7 @@ int rnpgbe_request_mbx_irq(struct mucse *mucse)
 	snprintf(mucse->mbx_name, sizeof(mucse->mbx_name),
 		 "rnpgbe-mbx:%s", pci_name(pdev));
 	INIT_WORK(&mucse->mbx_work, rnpgbe_mbx_work);
+	atomic_set(&mucse->mbx_irq_seq, 0);
 
 	err = request_irq(pci_irq_vector(pdev, 0), rnpgbe_msix_other, 0,
 			  mucse->mbx_name, mucse);
@@ -1399,7 +1407,19 @@ static void rnpgbe_cancel_rx_retry_timers(struct mucse *mucse)
 void rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	int err;
 
+	spin_lock_irqsave(&mucse->link_lock, flags);
+	WRITE_ONCE(hw->link, false);
+	WRITE_ONCE(hw->speed, 0);
+	WRITE_ONCE(hw->duplex, 0);
+	atomic_set(&mucse->link_pending, 0);
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
+	cancel_delayed_work_sync(&mucse->serv_task);
+
+	netif_carrier_off(netdev);
 	rnpgbe_irq_disable(mucse);
 	rnpgbe_napi_disable_all(mucse);
 	synchronize_net();
@@ -1408,22 +1428,77 @@ void rnpgbe_down(struct mucse *mucse)
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
+	rnpgbe_set_link(hw, false);
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
+	/* Keep the cached state and default snapshot atomic with mailbox
+	 * link-event handling.
+	 */
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
+	return 0;
 }
 
 /**
@@ -2048,3 +2123,99 @@ int rnpgbe_configure_rx(struct mucse *mucse)
 
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
+	if (!netif_running(mucse->netdev))
+		return;
+
+	rnpgbe_process_link_subtask(mucse);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 76b5b0c0ae4a..08b7d22f98ee 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -68,7 +68,7 @@ int rnpgbe_request_irq(struct mucse *mucse);
 void rnpgbe_free_irq(struct mucse *mucse);
 void rnpgbe_irq_disable(struct mucse *mucse);
 void rnpgbe_down(struct mucse *mucse);
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
index 35eb858eb2c1..9ba53bb3629b 100644
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
@@ -237,6 +245,11 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
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
@@ -249,6 +262,10 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_powerdown;
 	}
 
+	INIT_DELAYED_WORK(&mucse->serv_task, rnpgbe_service_task);
+	spin_lock_init(&mucse->link_lock);
+	atomic_set(&mucse->link_pending, 0);
+
 	err = rnpgbe_init_interrupt_scheme(mucse);
 	if (err) {
 		dev_err(&pdev->dev, "init interrupt failed %d\n", err);
@@ -273,6 +290,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		netdev->hw_features |= NETIF_F_HIGHDMA;
 	}
 
+	netif_carrier_off(netdev);
 	err = register_netdev(netdev);
 	if (err)
 		goto err_remove_mbx;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index 2310f01df1f5..74f42be975c2 100644
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
@@ -205,12 +206,11 @@ static int mucse_check_for_msg_pf(struct mucse_hw *hw)
 	u16 fw_req;
 
 	fw_req = mucse_mbx_get_fwreq(mbx);
-	/* chip's register is reset to 0 when rc send reset
-	 * mbx command. Return -EIO if in this state, others
-	 * fw == hw->mbx.fw_req means no new msg.
-	 **/
-	if (fw_req == 0 || fw_req == hw->mbx.fw_req)
+	/* The request counter is reset to zero by a mailbox reset. */
+	if (!fw_req)
 		return -EIO;
+	if (fw_req == hw->mbx.fw_req)
+		return -ENOMSG;
 
 	return 0;
 }
@@ -252,6 +252,68 @@ int mucse_poll_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size)
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
@@ -286,6 +348,36 @@ static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
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
@@ -320,6 +412,44 @@ static int mucse_write_mbx_pf(struct mucse_hw *hw, const __le32 *msg, u16 size)
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
@@ -381,6 +511,33 @@ int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, const __le32 *msg,
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
index e28f3193aa85..6415b6430efc 100644
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
+			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
+			spin_unlock_irqrestore(&mucse->link_lock, flags);
+			dev_warn_ratelimited(&hw->pdev->dev,
+					     "unsupported link speed %u Mbps\n",
+					     speed);
+			return;
+		}
+
+		if (!netif_running(mucse->netdev)) {
+			rnpgbe_set_link(hw, false);
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
+		rnpgbe_set_link(hw, mucse_link_is_up(hw, req));
+		/* update regs to notify link info is received */
+		mucse_update_link_status_reg(hw, req);
+		atomic_set_release(&mucse->link_pending, 1);
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

