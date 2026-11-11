Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401942;
	b=C4sd1FRU7duf35LpBbNbiQ6f5ssXLjdhieJmt7/qCPDZZfvAOfYus0jZzTbJ4e+2G4xq
	 ynA/BvVy02OtrFeXdgEkospictNZ5ViXwniJNSGrsRVEHVdOY8WxD3kvrWv3wPkBpv3p7
	 3FMbUg0pPclfAN0v2hlANdi2vqxpShM3lXdBX5a0yMEtvbbv1fnoXIs+TANpyl53lGAQu
	 vb54RteKqKZGTVSv9jGYuFLc733xQTlC0n6j0XNJvuoXUSSzsNKpn2xdlR5BqD07c/vPI
	 tmzW8iXiFY1zrpMudaVi2gfwCoxEtNfU26QSYGiHZ08G23YLOhjrwtfSg1ZAj3uQXaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401942;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=GG7ZhecKdNr7sSzyzxy0l9Argm+o+tLt3NeYRn1EoE0=;
	b=JkliC15Qcsh+AhHNq0lNAYxLOgbid02lKl6p7z7PpeldY37kzbYY24fLP1hmindUqDn7
	 eyCJN+tOuhe6A18BXFwUVuIZVmNpuit4WOlIC+3jhwda43Gx3P9IOH9KaOv7g2TXonI1W
	 EupLjmnieDfZQ2PiYJFAItQY63lOPF1M0x75GKq8tovWrGhtbG5KZ407EGY+6VZErx4rr
	 YRKoFewbMkm9Up/1uNdQvQRz+e04F+Fyu9eWBmYsmTCWgtpt17qBBnuZhXBKQ0QML/wBw
	 x7o4Y1qQgBQHqN1fFGg4/LPP+uUEhzOYKckfGcjv+GAkPULlX3dVjZOedZb1Atirczw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=E1byyRWR;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE260A2603;
	Wed, 11 Nov 2026 12:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AAE260A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=E1byyRWR
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GG7ZhecKdNr7sSzyzxy0l9Argm+o+tLt3NeYRn1EoE0=;
	b=E1byyRWRIQAgavvXOlXx0DJkAujmTp9VBErbf/sTXODfnjGeoPZ+MIzuNCLzDPyePuWAtq8I/
	yIT5WMYDevvLr1FBVomamX+hS4/5DoA3Z6ELDRn5xI6G130VoB6OgeCMmR2XfZEDdeYUiF12RYu
	i6m8ErHtl7QhcGYPpG3UZGQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jPk8j73SFzcZyh;
	Wed, 11 Nov 2026 20:58:13 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id DF55440561;
	Wed, 11 Nov 2026 20:58:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 20:58:53 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net 3/4] net: hns3: fix interface stuck after OOM with full hardware rx queue
Date: Wed, 11 Nov 2026 20:58:09 +0800
Message-ID: <20261111125810.3359030-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111125810.3359030-1-shaojijie@huawei.com>
References: <20261111125810.3359030-1-shaojijie@huawei.com>
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500018.china.huawei.com (7.202.195.199)

NAPI polling on hns3 is driven by hardware RX interrupts. Under
memory pressure, RX skb and frag allocations fail, packets are no
longer reaped from the hardware rx ring. Once the ring fills, the
hardware stops generating RX interrupts and NAPI is never scheduled
again -- even after memory becomes available, leaving the interface
deadlocked.

Break the deadlock by adding a software recovery path that re-arms
NAPI via a 250ms delayed_work, independent of hardware interrupts.
A per-ring bitmap tracks which RX rings are in OOM state; the work
function schedules NAPI for the vector backing each affected ring.
OOM state is marked at every RX allocation failure site and cleared
when the delayed_work fires.

This supersedes the busy-poll recovery from commit 68752b24f51a
("net: hns3: schedule the polling again when allocation fails"),
which returned budget on allocation failure to keep NAPI polling
and caused CPU spinning under prolonged memory pressure. Now
hns3_clean_rx_ring() returns recv_pkts instead of budget on
allocation failure, letting NAPI exit and the delayed_work take
over. The exit refill is still attempted, so the descriptors cleaned
by this poll stay armed. Add rx_oom_cnt ethtool counter, incremented
once per OOM event (on the 0 -> 1 bitmap transition) for diagnostics.
It counts OOM episodes rather than individual allocation failures,
so it is not the standard rx-alloc-fail counter.

The bitmap is allocated in hns3_init_all_ring() and freed in
hns3_uninit_all_ring(). It is allocated after every ring is set up,
so a failure inside hns3_init_all_ring() leaves nothing behind, and
it is reused because hns3_set_ringparam() calls hns3_init_all_ring()
without hns3_uninit_all_ring(). The delayed_work is cancelled in
hns3_nic_uninit_vector_data(), which every teardown path reaches
before the bitmap is freed.

hns3_nic_net_down() does not cancel the work, so a pending work may
still run after the interface goes down. If it runs while DOWN is
set, it zeroes the bitmap and returns without scheduling NAPI. If
the interface is brought back up within the 250ms window, it sees
the stale bits with DOWN cleared and schedules NAPI for those rings
once, ending in a single extra poll round with no packet to clean.
Both outcomes are harmless.

Fixes: 68752b24f51a ("net: hns3: schedule the polling again when allocation fails")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v4:
  - Allocate rx_ring_oom_bm in hns3_init_all_ring() only after every
    ring has been set up, and free it in hns3_uninit_all_ring().  This
    fixes the leak and the NULL bitmap dereference in the
    hns3_set_ringparam() path, which calls hns3_init_all_ring()
    without a matching hns3_uninit_all_ring(), and reuses the existing
    allocation on a ring resize.
  - Cancel the delayed work in hns3_nic_uninit_vector_data() instead
    of hns3_nic_net_down(), so every teardown path cancels it before
    the bitmap is freed.  The self-test and external loopback paths
    set DOWN without going through hns3_nic_net_down().
  - Drop the cancel and bitmap_zero from hns3_nic_net_down().  A
    pending work that runs while DOWN is set zeroes the bitmap and
    exits, and one that runs after the interface is brought back up
    only schedules a single extra poll round.
  - Always attempt the exit refill in hns3_clean_rx_ring(), so the
    descriptors cleaned by this poll stay armed and the head pointer
    is written as before.
  - Document why rx_oom_cnt is not the standard rx-alloc-fail counter.
v3: https://lore.kernel.org/all/20261030095633.377289-4-shaojijie@huawei.com/
Changes in v3:
  - Rework the OOM bitmap from per-vector to per-ring, indexed by
    ring->queue_index, so each ring's OOM event is counted exactly
    once per oom_task firing cycle regardless of vector sharing.
  - Add cancel_delayed_work_sync(&priv->oom_task) to
    hns3_nic_net_down(), placed after hns3_disable_irqs_and_tqps(),
    eliminating the stop/open window where a preempted worker could
    clear a bit newly set by NAPI on the reopened interface.
  - Remove the hns3_ring_set_oom_state() call from
    hns3_handle_rx_copybreak(): napi_alloc_frag() failure returns
    -ENOMEM but the packet is still delivered via the original page,
    so it should not drive the OOM recovery work.
v2: https://lore.kernel.org/all/20261021121426.3096838-3-shaojijie@huawei.com/
Changes in v2:
  - Clear per-vector OOM bitmap when device is DOWN to avoid
    spurious napi_schedule() on next up event.
  - Move rx_oom_cnt accounting to hns3_ring_set_oom_state() with
    test_and_set_bit() for per-event counting.
  - Expand changelog: reference commit 68752b24f51a, explain
    hns3_clean_rx_ring() return value change, document rx_oom_cnt
    per-event counting semantics.
v1: https://lore.kernel.org/all/20260915132434.1141742-3-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 61 ++++++++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   | 18 ++++++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  1 +
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index dbf32c00bb7f..90f0a8ac9295 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -78,6 +78,8 @@ module_param(page_pool_enabled, bool, 0400);
 #define HNS3_MIN_TX_LEN		33U
 #define HNS3_MIN_TUN_PKT_LEN	65U
 
+#define HNS3_OOM_POLL_INTERVAL_MS	250
+
 /* hns3_pci_tbl - PCI Device ID Table
  *
  * Last entry must be all 0s
@@ -4162,6 +4164,7 @@ static int hns3_add_frag(struct hns3_enet_ring *ring)
 			if (unlikely(!new_skb)) {
 				hns3_rl_err(ring_to_netdev(ring),
 					    "alloc rx fraglist skb fail\n");
+				hns3_ring_set_oom_state(ring);
 				return -ENXIO;
 			}
 
@@ -4451,6 +4454,35 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring)
 	return 0;
 }
 
+static void hns3_oom_task(struct work_struct *work)
+{
+	struct hns3_nic_priv *priv = container_of(work, struct hns3_nic_priv,
+						  oom_task.work);
+	struct hnae3_handle *h = priv->ae_handle;
+	struct hns3_enet_ring *ring;
+	u16 i;
+
+	if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
+		bitmap_zero(priv->rx_ring_oom_bm, h->kinfo.num_tqps);
+		return;
+	}
+
+	for (i = 0; i < h->kinfo.num_tqps; i++)
+		if (test_and_clear_bit(i, priv->rx_ring_oom_bm)) {
+			ring = &priv->ring[i + h->kinfo.num_tqps];
+			napi_schedule(&ring->tqp_vector->napi);
+		}
+}
+
+static void hns3_oom_task_schedule(struct hns3_enet_ring *ring)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
+
+	hns3_ring_set_oom_state(ring);
+	schedule_delayed_work(&priv->oom_task,
+			      msecs_to_jiffies(HNS3_OOM_POLL_INTERVAL_MS));
+}
+
 int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 		       void (*rx_fn)(struct hns3_enet_ring *, struct sk_buff *))
 {
@@ -4472,6 +4504,9 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 
 		/* Poll one pkt */
 		err = hns3_handle_rx_bd(ring);
+		if (unlikely(err == -ENOMEM))
+			failure = true;
+
 		/* Do not get FE for the packet or failed to alloc skb */
 		if (unlikely(!ring->skb || err == -ENXIO)) {
 			goto out;
@@ -4490,10 +4525,12 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 	 * FBD number with head pointer
 	 */
 	if (unused_count > 0)
-		failure = failure ||
-			  hns3_nic_alloc_rx_buffers(ring, unused_count);
+		failure |= hns3_nic_alloc_rx_buffers(ring, unused_count);
 
-	return failure ? budget : recv_pkts;
+	if (unlikely(failure || hns3_ring_is_oom_state(ring)))
+		hns3_oom_task_schedule(ring);
+
+	return recv_pkts;
 }
 
 static void hns3_update_rx_int_coalesce(struct hns3_enet_tqp_vector *tqp_vector)
@@ -4788,6 +4825,7 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 			       hns3_nic_common_poll);
 	}
 
+	INIT_DELAYED_WORK(&priv->oom_task, hns3_oom_task);
 	return 0;
 
 map_ring_fail:
@@ -4889,6 +4927,8 @@ static void hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 	struct hns3_enet_tqp_vector *tqp_vector;
 	int i;
 
+	cancel_delayed_work_sync(&priv->oom_task);
+
 	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
 
@@ -5204,6 +5244,16 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
 		cond_resched();
 	}
 
+	/* hns3_set_ringparam() calls this without hns3_uninit_all_ring(). */
+	if (!priv->rx_ring_oom_bm) {
+		priv->rx_ring_oom_bm = bitmap_zalloc(h->kinfo.num_tqps,
+						     GFP_KERNEL);
+		if (!priv->rx_ring_oom_bm) {
+			ret = -ENOMEM;
+			goto out_when_alloc_ring_memory;
+		}
+	}
+
 	return 0;
 
 out_when_alloc_ring_memory:
@@ -5222,6 +5272,11 @@ static void hns3_uninit_all_ring(struct hns3_nic_priv *priv)
 		hns3_fini_ring(&priv->ring[i]);
 		hns3_fini_ring(&priv->ring[i + h->kinfo.num_tqps]);
 	}
+
+	if (priv->rx_ring_oom_bm) {
+		bitmap_free(priv->rx_ring_oom_bm);
+		priv->rx_ring_oom_bm = NULL;
+	}
 }
 
 /* Set mac addr if it is configured. or leave it to the AE driver */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 933e3527ed82..5470df5d8efb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -449,6 +449,7 @@ struct ring_stats {
 			u64 non_reuse_pg;
 			u64 frag_alloc_err;
 			u64 frag_alloc;
+			u64 rx_oom_cnt;
 		};
 		__le16 csum;
 	};
@@ -585,6 +586,8 @@ struct hns3_nic_priv {
 	struct hns3_enet_tqp_vector *tqp_vector;
 	u16 vector_num;
 	u8 max_non_tso_bd_num;
+	struct delayed_work oom_task;
+	unsigned long *rx_ring_oom_bm;
 
 	u64 tx_timeout_count;
 
@@ -711,6 +714,21 @@ static inline unsigned int hns3_page_order(struct hns3_enet_ring *ring)
 #define hns3_rl_usec_to_reg(int_rl) ((int_rl) >> 2)
 #define hns3_rl_round_down(int_rl) round_down(int_rl, 4)
 
+static inline void hns3_ring_set_oom_state(struct hns3_enet_ring *ring)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
+
+	if (!test_and_set_bit(ring->queue_index, priv->rx_ring_oom_bm))
+		hns3_ring_stats_update(ring, rx_oom_cnt);
+}
+
+static inline bool hns3_ring_is_oom_state(struct hns3_enet_ring *ring)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
+
+	return test_bit(ring->queue_index, priv->rx_ring_oom_bm);
+}
+
 void hns3_ethtool_set_ops(struct net_device *netdev);
 int hns3_set_channels(struct net_device *netdev,
 		      struct ethtool_channels *ch);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 7b92a3c73ef6..14642f81efe1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -62,6 +62,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 	HNS3_TQP_STAT("non_reuse_pg", non_reuse_pg),
 	HNS3_TQP_STAT("frag_alloc_err", frag_alloc_err),
 	HNS3_TQP_STAT("frag_alloc", frag_alloc),
+	HNS3_TQP_STAT("rx_oom_cnt", rx_oom_cnt),
 };
 
 #define HNS3_PRIV_FLAGS_LEN ARRAY_SIZE(hns3_priv_flags)
-- 
2.43.0

