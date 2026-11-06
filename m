Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.22.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964411;
	b=x3F90lPaNF2ubKaMdC6oWoT40wOAyx5gqs6kpPGoN676/cbgArLa+OiY0k4ATOeqJocR
	 Iq8odtsAiU94rr3R631dDIHw0TZSSD5GOt4+rbHSYAmMt3InvrD8n3B7eg9EZLt30dCbG
	 drwjjeff+3PXdmvkWfqJywokvasA287zIrfoX7JgPyzrWWBO3Mt0jnpWWsC0XROmgf1Kn
	 yWk+x6zZyqJ/kBVgM30KmN9AIwpiXyDAFxWzhnctLC839NBScCwvZw92kunLoarQQ9I7m
	 xbKxfgKfkhuPbDwZjqESaFjBNElqgUzk2H/eay+Ulc4yXEIVCyh+wz/M6Wm8Ofrzc9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964411;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=1Cmu59OwsLeFk7RiV0pEi2NRyTdVKjpgyX/YgQnHA+M=;
	b=l5O1Hxi/OiA49vBCwM3bhdQjeG+7Tp7Ae9qhNtu7j5oJbliEsrTdZkII19MTpilmIqyF
	 IUVVkfLxDFQ6FAVCUpoKhLDqumnkAMQHb6CL4jOiDzFfooF+FT/Rzn8LaVI1eeJJpYv1c
	 YjB25lbuqm7qeKJ3Ni7sVX6UvTgZe9P2VkX8xEU/Ru+3pVUKRv20Mtl2HxlI+9vox4sKU
	 N0mYCxR8BtVGAV78/uq37leBMy6yOHWax4wyfwCh2IoR2hJF0VI7Hodchjx1ZT4PIeyis
	 BTki6o53ISB1ealO9DjCqCBjn8TN5gju4XDKrhTwgoFImy80NT/9Zp3D/hyLaWPHMyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=54.207.22.56
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD0606A329;
	Fri,  6 Nov 2026 11:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02DD0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1793964360tc93cdb5a
X-QQ-Originating-IP: fkjkPEPX2xBihsWvGhAbszFk9FhdVmxbSxcQMC+CT2Q=
Received: from nic-Precision-5820-Tower.tail7b ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 19:25:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1888963279000085563
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next 5/5] net: rnpgbe: Add hardware and queue statistics
Date: Fri,  6 Nov 2026 19:25:56 +0800
Message-ID: <07F76435DD841B31+20261106112556.44266-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
References: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MDlC9u6qHHGcLc1zqF5Mms3VbtdGBnhXadqYcU5LPaytgiwP/WIqz9It
	CEMAI3s6JTpptPZrUdAvtHlQSastTZ3NONQ0RkpBL4hTMpN6kOH7UAZAh6YGj31JKccG8/G
	KVAasyOp9qie2ocsywsJlpbDszXIooBczgD/amvjote7fNVmMsHah2WHS9wnAXQL4nj4FJT
	JV+DJWt2id3oeuo741g75GDJJnZwlCuAn1ulM9O5u35+X9TM4KTxuMVhVVLaBBT/kTt+/Wz
	J0EGjqXUmsiVWaf+BiaZJ7TcgK/Vul1kcOQow8cgmcngx6L0F+2DrVIRiMj5qztqyUo3Zuu
	rf0i+axrWbWtFtT3gjqZalICbwMr6k420cLmMUJL5zuESwWEHYaxkiAMcxO4szfltIHhuOL
	xwjzftgw9AY0q206C3FA/jkk04e6xa3SfFeq2W3UXRkboCf6/N9kZP+K8QMIwnpzJ8+FW02
	+lcsHQBQDA/4x4lA0u6QzLC+qV75SyBgY1PO2ahcz527j9k8zhuZN5AQ8pAV11IruqSBsvQ
	WAvSztwREHCE5fvQmdgLHWMDnU7gxj2XrEKgcSJze/XUu7BonTIHDHGdytZl7ThA1tpi/S9
	V61VTtqD60C1P+HhTle3c5B72TlVHl41KU0tZBTFgmRaaXmosfUxoGcsBA7S6tvSe3I551F
	0lj4MM2kHK2HM5dh0QdxPFlkhgAvJghBe7mgTo5LVPI64P4vWVkIt2HNVJ8htkG85G/dEac
	vlSvmVz5E3gQoCKq6neexv90jbKnNo0xUE4OD42XHlW9TiOn6dCyNv5EFlhxvnrXHQe+2zI
	l+hshsz64h2/X78s3Z9bU6hRAZvHd8Jp8GFzAjq2xbY6pMNA6NGLgad1IzA2Hjpsy6hfpoA
	KnsQl5bMsoPXyTWqxsaC6wih28Q2NOOe98PA7Np00PBKyFI6InJkYJmHinmD23g2vVpsguC
	eOCDAUcAcV5np7HreWTNguRyD+QL4Iyg1RcM9g8BbX/LXUX6L4tHg/YI5VwoKNdvX3DosMv
	QNgLDwuY9Nr6CxrGxUtNgiwVKBzyl0WEEAvFjZIPf5qO4cVwFi1MV8W4GY/ratv5RvT70uB
	yGI7kOXuttp
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Add hardware receive CRC-error and multicast counters to
ndo_get_stats64. Accumulate the non-clearing 32-bit counters from the
service task while the interface is open, take a final sample on close
and retain totals across interface down/up cycles.

Report per-queue RX and TX packet and byte counters through netdev queue
statistics, with RX counters limited to packets delivered to the
networking stack. Report RX page and skb allocation failures together as
rx-alloc-fail, and include inactive queues in device totals.

Expose per-queue TX DMA mapping failures through ethtool statistics.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   1 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   7 +
 .../ethernet/mucse/rnpgbe/rnpgbe_ethtool.c    |   3 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    |  28 ++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_stats.c  | 217 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_stats.h  |  37 +++
 8 files changed, 296 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 4d768324a82c..2b498a3f297a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -10,4 +10,5 @@ rnpgbe-objs := rnpgbe_main.o\
 	       rnpgbe_mbx.o\
 	       rnpgbe_mbx_fw.o\
 	       rnpgbe_ethtool.o\
+	       rnpgbe_stats.o\
 	       rnpgbe_lib.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 8574377e3a22..da2d5d1db9b5 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -13,6 +13,7 @@
 #include <linux/workqueue.h>
 
 #include "rnpgbe_hw.h"
+#include "rnpgbe_stats.h"
 
 enum rnpgbe_boards {
 	board_n500,
@@ -119,8 +120,13 @@ struct mucse_tx_buffer {
 struct mucse_queue_stats {
 	u64 packets;
 	u64 bytes;
+	u64 delivered_packets;
+	u64 delivered_bytes;
 	u64 length_errors;
 	atomic64_t dropped;
+	atomic64_t page_alloc_failures;
+	atomic64_t skb_alloc_failures;
+	atomic64_t dma_map_failures;
 	struct u64_stats_sync syncp;
 } ____cacheline_aligned_in_smp;
 
@@ -231,6 +237,7 @@ struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
+	struct mucse_hw_stats hw_stats;
 	struct mucse_ring *tx_ring[RNPGBE_MAX_QUEUES]
 		____cacheline_aligned_in_smp;
 	struct mucse_ring *rx_ring[RNPGBE_MAX_QUEUES]
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
index cd3cca1474ec..b311d1a70d30 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
@@ -236,4 +236,7 @@ const struct ethtool_ops rnpgbe_ethtool_ops = {
 	.get_link = ethtool_op_get_link,
 	.get_link_ksettings = rnpgbe_get_link_ksettings,
 	.set_link_ksettings = rnpgbe_set_link_ksettings,
+	.get_sset_count = rnpgbe_get_sset_count,
+	.get_strings = rnpgbe_get_strings,
+	.get_ethtool_stats = rnpgbe_get_ethtool_stats,
 };
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 674d4d23c4b0..c717eb6d00b6 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -36,8 +36,10 @@
 #define RNPGBE_LINK_ST                 0x000c
 #define RNPGBE_DMA_AXI_EN              0x0010
 #define RNPGBE_TX_MIN_PKT_LEN          33
+#define RNPGBE_DMA_RX_MULTICAST(_n)    (0x4018 + 0x100 * (_n))
 
 #define MUCSE_ETH_OFF(_n)              (0x10000 + (_n))
+#define RNPGBE_ETH_RX_FCS_ERRORS       MUCSE_ETH_OFF(0x8954)
 #define RNPGBE_RX_RAR_LOW(_n)          MUCSE_ETH_OFF(0xa000 + 4 * (_n))
 #define RNPGBE_RX_RAR_HIGH(_n)         MUCSE_ETH_OFF(0xa400 + 4 * (_n))
 #define RNPGBE_RX_MCAST_HASH(_n)       MUCSE_ETH_OFF(0xac00 + 4 * (_n))
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index b7b0c45a0f66..fe320c4f389b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -4,6 +4,7 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/iopoll.h>
+#include <linux/jiffies.h>
 #include <linux/etherdevice.h>
 #include <linux/vmalloc.h>
 #include <net/netdev_queues.h>
@@ -201,8 +202,10 @@ static bool mucse_alloc_mapped_page(struct mucse_ring *rx_ring,
 	}
 
 	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
-	if (unlikely(!page))
+	if (unlikely(!page)) {
+		atomic64_inc(&rx_ring->stats->page_alloc_failures);
 		return false;
+	}
 	dma = page_pool_get_dma_addr(page);
 
 	bi->dma = dma;
@@ -468,6 +471,7 @@ static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
 			       struct mucse_ring *rx_ring,
 			       int budget)
 {
+	unsigned int delivered_bytes = 0, delivered_packets = 0;
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
 	unsigned int total_rx_length_errors = 0;
@@ -571,6 +575,7 @@ static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
 			skb = rnpgbe_build_skb(rx_buffer, size);
 
 		if (!skb) {
+			atomic64_inc(&rx_ring->stats->skb_alloc_failures);
 			cleaned_count++;
 
 			/* drop until eop if multiple descriptors */
@@ -615,6 +620,8 @@ static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
 
 		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
+		delivered_bytes += skb->len;
+		delivered_packets++;
 		rnpgbe_process_skb_fields(rx_ring, skb);
 		rx_desc->wb.cmd = 0;
 		napi_gro_receive(&q_vector->napi, skb);
@@ -626,6 +633,8 @@ static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
 	u64_stats_update_begin(&rx_ring->stats->syncp);
 	rx_ring->stats->packets += total_rx_packets;
 	rx_ring->stats->bytes += total_rx_bytes;
+	rx_ring->stats->delivered_packets += delivered_packets;
+	rx_ring->stats->delivered_bytes += delivered_bytes;
 	rx_ring->stats->length_errors += total_rx_length_errors;
 	atomic64_add(total_rx_dropped, &rx_ring->stats->dropped);
 	u64_stats_update_end(&rx_ring->stats->syncp);
@@ -1456,7 +1465,7 @@ void rnpgbe_down(struct mucse *mucse)
 	int err;
 
 	spin_lock_irqsave(&mucse->link_lock, flags);
-	mucse->link_event_ready = false;
+	WRITE_ONCE(mucse->link_event_ready, false);
 	mucse->link_pending = false;
 	hw->link = false;
 	hw->speed = 0;
@@ -1491,6 +1500,7 @@ void rnpgbe_down(struct mucse *mucse)
 			 err);
 		dev_warn(&hw->pdev->dev, "Port is not truly down\n");
 	}
+	rnpgbe_update_stats(mucse);
 	rnpgbe_clean_all_rx_rings(mucse);
 }
 
@@ -1527,7 +1537,7 @@ int rnpgbe_up_complete(struct mucse *mucse)
 	hw->speed = 0;
 	hw->duplex = 0;
 	mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
-	mucse->link_event_ready = true;
+	WRITE_ONCE(mucse->link_event_ready, true);
 	spin_unlock_irqrestore(&mucse->link_lock, flags);
 	/* Firmware checks RNPGBE_LINK_ST (driver's last-received link state)
 	 * and only asserts LINK_CHANGE_EVT when it differs from the actual link
@@ -1541,6 +1551,7 @@ int rnpgbe_up_complete(struct mucse *mucse)
 		return err;
 	}
 
+	schedule_delayed_work(&mucse->serv_task, HZ);
 	return 0;
 }
 
@@ -1760,8 +1771,10 @@ static int rnpgbe_tx_map(struct mucse_ring *tx_ring,
 	dma_unmap_addr_set(tx_buffer, dma, 0);
 
 	for (;; frag_idx++) {
-		if (dma_mapping_error(tx_ring->dev, dma))
+		if (dma_mapping_error(tx_ring->dev, dma)) {
+			atomic64_inc(&tx_ring->stats->dma_map_failures);
 			goto err_unmap;
+		}
 
 		/* record length, and DMA address */
 		dma_unmap_len_set(tx_buffer, len, size);
@@ -1961,6 +1974,8 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 		stats->rx_errors += length_errors;
 		stats->rx_length_errors += length_errors;
 	}
+
+	rnpgbe_get_hw_stats(mucse, stats);
 }
 
 static int mucse_alloc_page_pool(struct mucse_ring *rx_ring)
@@ -2259,4 +2274,9 @@ void rnpgbe_service_task(struct work_struct *work)
 	struct mucse *mucse = container_of(work, struct mucse, serv_task.work);
 
 	rnpgbe_process_link_subtask(mucse);
+	rnpgbe_update_stats(mucse);
+
+	/* Leave an immediate invocation queued by a link event unchanged. */
+	if (READ_ONCE(mucse->link_event_ready))
+		schedule_delayed_work(&mucse->serv_task, HZ);
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 09d499dc10ee..47d4f65c9213 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -177,8 +177,11 @@ static void rnpgbe_sw_init(struct mucse *mucse)
 	for (i = 0; i < RNPGBE_MAX_QUEUES; i++) {
 		u64_stats_init(&mucse->tx_stats[i].syncp);
 		atomic64_set(&mucse->tx_stats[i].dropped, 0);
+		atomic64_set(&mucse->tx_stats[i].dma_map_failures, 0);
 		u64_stats_init(&mucse->rx_stats[i].syncp);
 		atomic64_set(&mucse->rx_stats[i].dropped, 0);
+		atomic64_set(&mucse->rx_stats[i].page_alloc_failures, 0);
+		atomic64_set(&mucse->rx_stats[i].skb_alloc_failures, 0);
 	}
 }
 
@@ -255,6 +258,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
 	netdev->ethtool_ops = &rnpgbe_ethtool_ops;
+	netdev->stat_ops = &rnpgbe_stat_ops;
 	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
 	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
@@ -314,6 +318,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	netif_carrier_off(netdev);
+	rnpgbe_init_stats(mucse);
 	err = register_netdev(netdev);
 	if (err)
 		goto err_remove_mbx;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c
new file mode 100644
index 000000000000..595faa16b7d0
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2026 Mucse Corporation. */
+
+#include <linux/ethtool.h>
+#include <net/netdev_queues.h>
+
+#include "rnpgbe.h"
+#include "rnpgbe_stats.h"
+
+struct rnpgbe_queue_stat {
+	char name[ETH_GSTRING_LEN];
+	unsigned int offset;
+};
+
+#define RNPGBE_QUEUE_STAT(_field) \
+	{ #_field, offsetof(struct mucse_queue_stats, _field) }
+
+static const struct rnpgbe_queue_stat rnpgbe_tx_queue_stats[] = {
+	RNPGBE_QUEUE_STAT(dma_map_failures),
+};
+
+static void rnpgbe_get_queue_stats_rx(struct net_device *netdev, int idx,
+				      struct netdev_queue_stats_rx *stats)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	const struct mucse_queue_stats *queue;
+	unsigned int start;
+
+	queue = &mucse->rx_stats[idx];
+	do {
+		start = u64_stats_fetch_begin(&queue->syncp);
+		stats->packets = queue->delivered_packets;
+		stats->bytes = queue->delivered_bytes;
+	} while (u64_stats_fetch_retry(&queue->syncp, start));
+	stats->alloc_fail = atomic64_read(&queue->page_alloc_failures) +
+			    atomic64_read(&queue->skb_alloc_failures);
+}
+
+static void rnpgbe_get_queue_stats_tx(struct net_device *netdev, int idx,
+				      struct netdev_queue_stats_tx *stats)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	const struct mucse_queue_stats *queue;
+	unsigned int start;
+
+	queue = &mucse->tx_stats[idx];
+	do {
+		start = u64_stats_fetch_begin(&queue->syncp);
+		stats->packets = queue->packets;
+		stats->bytes = queue->bytes;
+	} while (u64_stats_fetch_retry(&queue->syncp, start));
+}
+
+static void rnpgbe_get_base_stats(struct net_device *netdev,
+				  struct netdev_queue_stats_rx *rx,
+				  struct netdev_queue_stats_tx *tx)
+{
+	rx->packets = 0;
+	rx->bytes = 0;
+	rx->alloc_fail = 0;
+	tx->packets = 0;
+	tx->bytes = 0;
+
+	/* Queue counters persist across interface down/up. Include any queues
+	 * outside the active range when reporting device totals.
+	 */
+	netdev_stat_queue_sum(netdev, netdev->real_num_rx_queues,
+			      netdev->num_rx_queues, rx,
+			      netdev->real_num_tx_queues,
+			      netdev->num_tx_queues, tx);
+}
+
+const struct netdev_stat_ops rnpgbe_stat_ops = {
+	.get_queue_stats_rx = rnpgbe_get_queue_stats_rx,
+	.get_queue_stats_tx = rnpgbe_get_queue_stats_tx,
+	.get_base_stats = rnpgbe_get_base_stats,
+};
+
+static void rnpgbe_read_stats(struct mucse *mucse)
+{
+	struct mucse_hw_stats *stats = &mucse->hw_stats;
+	struct mucse_hw *hw = &mucse->hw;
+	u32 value;
+	int i;
+
+	/* These 32-bit counters do not clear on read. Unsigned differences
+	 * extend them across wraparound; hardware reset clears them.
+	 */
+	value = mucse_hw_rd32(hw, RNPGBE_ETH_RX_FCS_ERRORS);
+	stats->rx_crc_errors += (u32)(value - stats->rx_crc_errors_prev);
+	stats->rx_crc_errors_prev = value;
+
+	for (i = 0; i < mucse->num_rx_queues; i++) {
+		u32 index = mucse->rx_ring[i]->rnpgbe_queue_idx;
+
+		value = mucse_hw_rd32(hw, RNPGBE_DMA_RX_MULTICAST(index));
+		stats->multicast += (u32)(value - stats->multicast_prev[i]);
+		stats->multicast_prev[i] = value;
+	}
+}
+
+/**
+ * rnpgbe_update_stats - Accumulate the hardware counters
+ * @mucse: device private structure
+ */
+void rnpgbe_update_stats(struct mucse *mucse)
+{
+	spin_lock_bh(&mucse->hw_stats.lock);
+	rnpgbe_read_stats(mucse);
+	spin_unlock_bh(&mucse->hw_stats.lock);
+}
+
+/**
+ * rnpgbe_init_stats - Initialize counter snapshots after the probe reset
+ * @mucse: device private structure
+ */
+void rnpgbe_init_stats(struct mucse *mucse)
+{
+	struct mucse_hw_stats *stats = &mucse->hw_stats;
+	struct mucse_hw *hw = &mucse->hw;
+	int i;
+
+	spin_lock_init(&stats->lock);
+
+	stats->rx_crc_errors_prev = mucse_hw_rd32(hw, RNPGBE_ETH_RX_FCS_ERRORS);
+	for (i = 0; i < mucse->num_rx_queues; i++) {
+		u32 index = mucse->rx_ring[i]->rnpgbe_queue_idx;
+
+		stats->multicast_prev[i] =
+			mucse_hw_rd32(hw, RNPGBE_DMA_RX_MULTICAST(index));
+	}
+}
+
+/**
+ * rnpgbe_get_hw_stats - Add cached counters to the interface statistics
+ * @mucse: device private structure
+ * @stats: interface statistics to update
+ */
+void rnpgbe_get_hw_stats(struct mucse *mucse, struct rtnl_link_stats64 *stats)
+{
+	spin_lock_bh(&mucse->hw_stats.lock);
+	stats->rx_crc_errors += mucse->hw_stats.rx_crc_errors;
+	stats->rx_errors += mucse->hw_stats.rx_crc_errors;
+	stats->multicast += mucse->hw_stats.multicast;
+	spin_unlock_bh(&mucse->hw_stats.lock);
+}
+
+/**
+ * rnpgbe_get_sset_count - Return the number of queue counters
+ * @netdev: network interface
+ * @sset: requested string set
+ *
+ * Return: counter count, or -EOPNOTSUPP for other string sets
+ */
+int rnpgbe_get_sset_count(struct net_device *netdev, int sset)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	return mucse->num_tx_queues * ARRAY_SIZE(rnpgbe_tx_queue_stats);
+}
+
+/**
+ * rnpgbe_get_strings - Report the queue counter names
+ * @netdev: network interface
+ * @sset: requested string set
+ * @data: buffer for fixed-width counter names
+ */
+void rnpgbe_get_strings(struct net_device *netdev, u32 sset, u8 *data)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	int i, j;
+
+	if (sset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < mucse->num_tx_queues; i++)
+		for (j = 0; j < ARRAY_SIZE(rnpgbe_tx_queue_stats); j++)
+			ethtool_sprintf(&data, "tx_queue_%u_%s", i,
+					rnpgbe_tx_queue_stats[j].name);
+}
+
+static void rnpgbe_get_queue_stats(const struct mucse_queue_stats *queue,
+				   const struct rnpgbe_queue_stat *table,
+				   unsigned int count, u64 *data)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		const void *counter;
+
+		counter = (const u8 *)queue + table[i].offset;
+		data[i] = atomic64_read(counter);
+	}
+}
+
+/**
+ * rnpgbe_get_ethtool_stats - Report the queue counter values
+ * @netdev: network interface
+ * @stats: ethtool statistics request
+ * @data: buffer for values in the order returned by rnpgbe_get_strings()
+ */
+void rnpgbe_get_ethtool_stats(struct net_device *netdev,
+			      struct ethtool_stats *stats, u64 *data)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	int i;
+
+	for (i = 0; i < mucse->num_tx_queues; i++) {
+		rnpgbe_get_queue_stats(&mucse->tx_stats[i],
+				       rnpgbe_tx_queue_stats,
+				       ARRAY_SIZE(rnpgbe_tx_queue_stats), data);
+		data += ARRAY_SIZE(rnpgbe_tx_queue_stats);
+	}
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.h
new file mode 100644
index 000000000000..43fa4265ce6e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2022 - 2026 Mucse Corporation. */
+
+#ifndef _RNPGBE_STATS_H
+#define _RNPGBE_STATS_H
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "rnpgbe_hw.h"
+
+struct ethtool_stats;
+struct net_device;
+struct netdev_stat_ops;
+struct rtnl_link_stats64;
+struct mucse;
+
+struct mucse_hw_stats {
+	/* Protects the hardware snapshots and software totals. */
+	spinlock_t lock;
+	u64 rx_crc_errors;
+	u64 multicast;
+	u32 rx_crc_errors_prev;
+	u32 multicast_prev[RNPGBE_MAX_QUEUES];
+};
+
+extern const struct netdev_stat_ops rnpgbe_stat_ops;
+
+void rnpgbe_init_stats(struct mucse *mucse);
+void rnpgbe_update_stats(struct mucse *mucse);
+void rnpgbe_get_hw_stats(struct mucse *mucse, struct rtnl_link_stats64 *stats);
+int rnpgbe_get_sset_count(struct net_device *netdev, int sset);
+void rnpgbe_get_strings(struct net_device *netdev, u32 sset, u8 *data);
+void rnpgbe_get_ethtool_stats(struct net_device *netdev,
+			      struct ethtool_stats *stats, u64 *data);
+
+#endif /* _RNPGBE_STATS_H */
-- 
2.50.1

