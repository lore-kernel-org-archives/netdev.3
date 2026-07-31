Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D63EDE60;
	Fri, 31 Jul 2026 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499473; cv=none; b=RdEwn0mlwWE+GVUo+pbd1/1cknmfc7xJqUaU53zV1gZtLn2yYRIA0eKeCQbZBtPymwd9PdE9T2aZ2BHa4sGL4HfFpgdkC8aI/N9AhWJHEqtRjKFBCEoMQDWws2mMycAO1K2XWXT9ZHyHMxh3psWcz8us6Qj98QFJbtkb4RBVukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499473; c=relaxed/simple;
	bh=3t/9J0+MiYcc+rSQ8pxXervxC+CpReO9SXAwLuUMM+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tLJUk4yMw8cfx0J5/kRJFI+k+pUbvypXFL3YY+KGli6d+3E4UcUOOTqE9fhoHg5dC5mRDLHUYp4+DEjZ6ytPBGOcMsCpiGqBcycIrgjUcE8s5DEWsh7DFLn9X17VmNotWbAKYJ/2sAZqsQiBzBW9N7ze43PEYx9dQZgV3LwSFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1785499425tbaeb4c29
X-QQ-Originating-IP: lUeaKPgEfq2G2SrE1hdtKKqGcAqrcULfskB2xbcsKyU=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 20:03:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6665516176600731113
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v8 4/4] net: rnpgbe: Add link status handling support
Date: Fri, 31 Jul 2026 20:03:22 +0800
Message-Id: <20260731120322.895955-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260731120322.895955-1-dong100@mucse.com>
References: <20260731120322.895955-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M94I2jolx1v3QxBbUf6GAqjxCKYJTwD2Wy0xRSSvW6vLYxC6ZAM1Qul4
	OFInA+qJ7ntgOj6+BDy1MNfFNcSrkQBM53VSY44S7Oqf7uPMAK3BO4ry2H5aqB2QkxkPt3n
	N4mLfaw0uIeK2Kijoi0VmHRk5Zepfe6fzZXDQ/JEz55FBcHnqF8ldU7FWn5Nu8GgXv7S7fH
	hYaLTtat8+MfiVdZO9/4FKuNs4LDA0sXbao2ze11A8Ahk8mnUjdB7j/C6cvlqgXmjy5Y5HH
	SVMKLQB9BqnC8oe8h8Lk9q5YbuxpKeGxDYE5X6xwdTyVzQ4s5yjKFBP/BgDF4Gt4f5yjSm9
	6g/y+Q6K+O2MXNRIlzxZXqSj6b6JK6bK72jWDkJcVUhW7zaWKifgBmen5Lfni8LL2jdkJMK
	ovTWSN7uhrT8m5HB+C3KwqKqh8n5tWBRMZNNwTvJwbX9F1CAkFdsOZ6jEKGOA5NyOmNKNvo
	GE5UW+X4miRoFUQXdD39SQ3hgo9wkf21x5502SZaavRzd2ovu9S5z2HZVfJkf3X7bB5VmWj
	syi3M87tZmIxeNs3aryp7MAwuEJ9A5OOJl05PT/3rYRy1/vm5gNQmsbHdpKAXO0Eukdkfi6
	DBBfAJ36wrsDWU7bSoypXbVhDMoQwDOLtItSmaszYsjgLQSup2FILbqvFL4JdhAsxf5e1GX
	HI3gOXl2Uhl+2asen9S/rgbO5k9FTTI+jlRwMaaPOT3erHVSz3iUzJdqrBt+hPO/BMeNZRe
	s5NnkyiRw4s/Yvd9g6er3zOHZ1f8R74y9VfRpEM3HcYrjyUh1Nut2pPjUwZMn1pX5cj0DKH
	rSutue+3DPyZu+hxCjDXqGm2ZoaE7m1IgUvMW4hJp1QxMv+I2HfhpAG/TOGmM36CWw/NqM7
	zKBDBDbjfA9NSeTVFQo/lqgZXI8MYr5SxskcK+Csd6x/3Sjf9UVMRSgFbHRcDPOJz0HyKlE
	DWEncSV3harGtWB8xKgeLLoLN65Wc0EM8MBa6/woqriIh9VZcUpnZH0b4YzLtW93Lo3FrKa
	ldI0CVMEKPJpKCyrg74DkXQzofk/7mgW84O+LgVVMj/b56ArvHpmJeH8qfHVu4qB2YR2SRE
	4ehwbKvRt7VTPOLHom8Io9nOda75ktWGu7mkKXfgj/w
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Add link status management infrastructure to the rnpgbe driver:
- Add link status related data structures (speed, duplex, link state)
- Implement firmware link event handling via mailbox
  (fw controls link states, does not support phylink)
- Add service task for periodic link status monitoring
- Implement carrier status management (netif_carrier_on/off)
- Add port up/down notification to firmware

This enables the driver to properly track and report link status changes.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  13 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  37 +++-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  13 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 179 +++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   8 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  20 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 200 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  44 ++++
 10 files changed, 509 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 8b0ac3e4255e..2e6820f59c72 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/if.h>
@@ -31,11 +32,10 @@ struct mucse_mbx_info {
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
@@ -44,8 +44,11 @@ struct mucse_hw {
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
@@ -224,7 +227,10 @@ struct mucse {
 	int num_rx_queues;
 	char mbx_name[32];
 	unsigned long state;
+	atomic_t link_pending;
 	struct work_struct mbx_work;
+	struct delayed_work serv_task;
+	spinlock_t link_lock; /* spinlock for link update */
 };
 
 int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
@@ -233,6 +239,7 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
 		       bool enable,
 		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
+void rnpgbe_set_link(struct mucse_hw *hw, bool linkup);
 
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 291e77d573fe..2b4f4c63bb02 100644
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
@@ -149,3 +155,32 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 
 	return 0;
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
+	if (linkup)
+		value |= GMAC_CONTROL_RE;
+	else
+		value &= ~GMAC_CONTROL_RE;
+
+	mucse_hw_wr32(hw, GMAC_CONTROL, value);
+
+	/* RX_ALL always be set when link is up -- the GMAC requires it
+	 * for passing all packet. Promiscuous/unicast filtering is
+	 * handled by other separate chip-level register.
+	 */
+	if (linkup)
+		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, GMAC_RX_ALL);
+	else
+		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, 0);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 03688586b447..4d1a9a386e9d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -17,7 +17,20 @@
 
 #define TX_AXI_RW_EN                   0xc
 #define RX_AXI_RW_EN                   0x03
+/* mask all valid info */
+#define M_ST_MASK                      0xff000f11
+/* 31:28 set 0xa to valid it is a driver set info */
+#define M_DEFAULT_ST                   0xa0000000
+/* driver setup this by own info */
+/*bit:   25:24   |  11:8   |     4   | 0       */
+/*fun:   pause   |  speed  |  duplex | up/down */
+#define RNPGBE_LINK_ST                 0x000c
 #define RNPGBE_DMA_AXI_EN              0x0010
 
+#define MUCSE_GMAC_OFF(_n)             (0x20000 + (_n))
+#define GMAC_CONTROL_RE                0x00000004
+#define GMAC_CONTROL                   MUCSE_GMAC_OFF(0)
+#define GMAC_RX_ALL                    (BIT(31) | BIT(0))
+#define GMAC_FRAME_FILTER              MUCSE_GMAC_OFF(0x4)
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 7825a36fdfbe..f7a9d9ea5549 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -665,11 +665,16 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 			clean_complete = false;
 	}
 
+	if (test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
+		clean_complete = true;
+
 	if (!clean_complete)
 		return budget;
 
-	if (likely(napi_complete_done(napi, work_done)))
-		rnpgbe_irq_enable_queues(q_vector);
+	if (likely(napi_complete_done(napi, work_done))) {
+		if (!test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
+			rnpgbe_irq_enable_queues(q_vector);
+	}
 
 	return work_done;
 }
@@ -1349,8 +1354,35 @@ static void rnpgbe_clean_all_rx_rings(struct mucse *mucse)
 void rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	int err;
 
 	set_bit(__MUCSE_DOWN, &mucse->state);
+	cancel_delayed_work_sync(&mucse->serv_task);
+
+	spin_lock_irqsave(&mucse->link_lock, flags);
+	WRITE_ONCE(hw->link, false);
+	WRITE_ONCE(hw->speed, 0);
+	WRITE_ONCE(hw->duplex, 0);
+	atomic_set(&mucse->link_pending, 0);
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
+	rnpgbe_set_link(hw, false);
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
+	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 	rnpgbe_napi_disable_all(mucse);
 	rnpgbe_irq_disable(mucse);
@@ -1365,6 +1397,9 @@ void rnpgbe_down(struct mucse *mucse)
 void rnpgbe_up_complete(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	int err;
 
 	if (mucse->flags & (M_FLAG_MSIX_EN | M_FLAG_MSIX_SINGLE_EN))
 		rnpgbe_configure_msix(mucse);
@@ -1372,11 +1407,43 @@ void rnpgbe_up_complete(struct mucse *mucse)
 		rnpgbe_configure_msi(mucse);
 
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
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
 	clear_bit(__MUCSE_DOWN, &mucse->state);
 	rnpgbe_irq_enable(mucse);
 	netif_tx_start_all_queues(netdev);
 	for (int i = 0; i < mucse->num_rx_queues; i++)
 		mucse_ring_wr32(mucse->rx_ring[i], RNPGBE_RX_START, 1);
+
+	err = rnpgbe_send_notify(hw, true, mucse_fw_portup);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send portup to hw failed %d\n", err);
+		dev_warn(&hw->pdev->dev, "Port is not truly up\n");
+	}
+	/* Firmware checks RNPGBE_LINK_ST (driver's last-received link state)
+	 * and only asserts LINK_CHANGE_EVT when it differs from the actual link
+	 * state AND link_report_en is true.
+	 */
+	err = rnpgbe_send_notify(hw, true, mucse_fw_link_report_en);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send link report to hw failed %d\n",
+			 err);
+		dev_warn(&hw->pdev->dev, "Fw will not report link event\n");
+	}
+
+	queue_delayed_work(system_wq, &mucse->serv_task,
+			   msecs_to_jiffies(500));
 }
 
 /**
@@ -2027,3 +2094,111 @@ void rnpgbe_configure_rx(struct mucse *mucse)
 	dma_axi_ctl |= RX_AXI_RW_EN;
 	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
 }
+
+/**
+ * rnpgbe_process_link_event - Consume a pending link event
+ * @mucse: pointer to the device private structure
+ *
+ * Return: link status
+ **/
+static int rnpgbe_process_link_event(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	bool link;
+
+	/* Only event consumption needs a consistent link-state snapshot. */
+	if (!atomic_read(&mucse->link_pending) ||
+	    !atomic_xchg(&mucse->link_pending, 0))
+		return READ_ONCE(hw->link);
+
+	spin_lock_irqsave(&mucse->link_lock, flags);
+
+	link = hw->link;
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
+
+	return link;
+}
+
+/**
+ * rnpgbe_link_is_up - Update netif_carrier status and
+ * print link up message
+ * @mucse: pointer to the device private structure
+ **/
+static void rnpgbe_link_is_up(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	int speed;
+	u8 duplex;
+
+	/* Only continue if link was previously down */
+	if (netif_carrier_ok(netdev))
+		return;
+	spin_lock_irqsave(&mucse->link_lock, flags);
+	speed = hw->speed;
+	duplex = hw->duplex;
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
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
+	/* if interface is down do nothing */
+	if (test_bit(__MUCSE_DOWN, &mucse->state))
+		return;
+
+	if (rnpgbe_process_link_event(mucse))
+		rnpgbe_link_is_up(mucse);
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
+	/* Periodic requeue is intentional: future patches will add
+	 * statistics polling and other housekeeping tasks beyond
+	 * link state handling.
+	 */
+	if (!test_bit(__MUCSE_DOWN, &mucse->state))
+		queue_delayed_work(system_wq, &mucse->serv_task,
+				   msecs_to_jiffies(500));
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 9ee224d9e7eb..2d216804b299 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -83,4 +83,5 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring);
 int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
 void rnpgbe_free_all_rx_resources(struct mucse *mucse);
+void rnpgbe_service_task(struct work_struct *work);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 3eeea9f51d7e..882db435ff5a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -52,6 +52,7 @@ static int rnpgbe_open(struct net_device *netdev)
 	struct mucse *mucse = netdev_priv(netdev);
 	int err;
 
+	netif_carrier_off(netdev);
 	err = rnpgbe_request_irq(mucse);
 	if (err)
 		return err;
@@ -182,6 +183,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "Init hw err %d\n", err);
 		goto err_free_net;
 	}
+
 	/* Step 1: Send power-up notification to firmware (no response expected)
 	 * This informs firmware to initialize hardware power state, but
 	 * firmware only acknowledges receipt without returning data. Must be
@@ -224,6 +226,10 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_powerdown;
 	}
 
+	INIT_DELAYED_WORK(&mucse->serv_task, rnpgbe_service_task);
+	spin_lock_init(&mucse->link_lock);
+	atomic_set(&mucse->link_pending, 0);
+
 	err = rnpgbe_init_interrupt_scheme(mucse);
 	if (err) {
 		dev_err(&pdev->dev, "init interrupt failed %d\n", err);
@@ -243,6 +249,8 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	if (err)
 		goto err_remove_mbx;
 
+	netif_carrier_off(netdev);
+
 	return 0;
 
 err_remove_mbx:
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
index 754016f6b4f0..1397f72fef0d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -3,6 +3,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/bitfield.h>
+#include <linux/ethtool.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_mbx.h"
@@ -27,10 +28,14 @@ static int mucse_fw_send_cmd_wait_resp(struct mucse_hw *hw,
 	int retry_cnt = 3;
 	int err;
 
+	BUILD_BUG_ON(sizeof(struct mbx_fw_cmd_reply) != 56);
+
 	mutex_lock(&hw->mbx.lock);
+
 	err = mucse_write_and_wait_ack_mbx(hw, req->dwords, len);
 	if (err)
 		goto out;
+
 	do {
 		err = mucse_poll_and_read_mbx(hw, reply->dwords,
 					      sizeof(reply->r));
@@ -199,9 +204,202 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 }
 
 /**
- * mucse_fw_irq_handler - Try to handle a req from hw
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
+/**
+ * mucse_update_link_status_reg - update driver speed inf to reg
+ * @hw: pointer to the HW structure
+ * @req: pointer to req data
+ *
+ * mucse_update_link_status_reg update reg according to driver info,
+ * fw will send irq if status is differ with reg
+ *
+ **/
+static void mucse_update_link_status_reg(struct mucse_hw *hw,
+					 struct mbx_fw_cmd_req *req)
+{
+	u16 status = le16_to_cpu(req->link_stat.st.status);
+	u16 speed = le16_to_cpu(req->link_stat.st.speed);
+	u32 value;
+
+	value = mucse_hw_rd32(hw, RNPGBE_LINK_ST);
+	value &= ~M_ST_MASK;
+	value |= M_DEFAULT_ST;
+
+	if (le16_to_cpu(req->link_stat.port_status)) {
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
+			/* Firmware only reports 10/100/1000 Mbps. */
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
+		spin_lock_irqsave(&mucse->link_lock, flags);
+		if (test_bit(__MUCSE_DOWN, &mucse->state)) {
+			if (magic == ST_VALID_MAGIC)
+				mucse_update_link_status_reg(hw, req);
+			else
+				mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
+			spin_unlock_irqrestore(&mucse->link_lock, flags);
+			return;
+		}
+
+		if (le16_to_cpu(req->link_stat.port_status))
+			WRITE_ONCE(hw->link, true);
+		else
+			WRITE_ONCE(hw->link, false);
+
+		if (magic == ST_VALID_MAGIC) {
+			WRITE_ONCE(hw->speed,
+				   le16_to_cpu(req->link_stat.st.speed));
+			WRITE_ONCE(hw->duplex,
+				   req->link_stat.st.flags & DUPLEX_BIT);
+			/* update regs to notify link info is received */
+			mucse_update_link_status_reg(hw, req);
+		} else {
+			WRITE_ONCE(hw->speed, 0);
+			WRITE_ONCE(hw->duplex, 0);
+			/* if not valid magic, just set reg to default,
+			 * firmware will check status and report a new
+			 * event if needed.
+			 */
+			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
+		}
+		atomic_set_release(&mucse->link_pending, 1);
+		spin_unlock_irqrestore(&mucse->link_lock, flags);
+	}
+}
+
+/**
+ * mucse_fw_handle_event - Handle one pending firmware event
+ * @hw: pointer to the hardware structure
+ *
+ * Return: true if an event was handled, false otherwise
+ **/
+static bool mucse_fw_handle_event(struct mucse_hw *hw)
+{
+	union mbx_fw_cmd_u msg = {};
+	int err;
+
+	/* try to check and read fw req */
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_check_and_read_mbx(hw, msg.dwords, sizeof(msg));
+	mutex_unlock(&hw->mbx.lock);
+	if (err)
+		return false;
+
+	mucse_mbx_fw_req_handler(hw, &msg.req);
+
+	return true;
+}
+
+/**
+ * mucse_fw_irq_handler - Drain firmware events from the mailbox
  * @hw: pointer to the HW structure
  **/
 void mucse_fw_irq_handler(struct mucse_hw *hw)
 {
+	while (mucse_fw_handle_event(hw))
+		continue;
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index a6bf5de55aa3..f5ee16f0de9a 100644
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
@@ -55,10 +68,27 @@ struct mbx_fw_cmd_req {
 			__le32 port_mask;
 			__le32 pfvf_num;
 		} get_mac_addr;
+		struct {
+			__le32 port_mask;
+			__le32 status;
+		} phy_status;
+		struct {
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
 
 struct mbx_fw_cmd_reply {
+#define FLAGS_REPLY       BIT(0)
+#define FLAGS_ERR         BIT(2)
 	__le16 flags;
 	__le16 opcode;
 	__le16 error_code;
@@ -94,10 +124,24 @@ union mbx_fw_cmd_reply_u {
 	__le32 dwords[sizeof(struct mbx_fw_cmd_reply) / sizeof(__le32)];
 };
 
+union mbx_fw_cmd_u {
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+	__le32 dwords[sizeof(struct mbx_fw_cmd_reply) / sizeof(__le32)];
+};
+
+enum mucse_speed {
+	mucse_speed_10,
+	mucse_speed_100,
+	mucse_speed_1000,
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
2.25.1

