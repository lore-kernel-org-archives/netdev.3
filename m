Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788432;
	b=nmkC50X/0Z41ujx9XEJIDcdnhNAHWDZ0pDNKy2vGvzpGRVsh3Iqq38zwaU6cJ824hczw
	 Mph4Kt/Vh0BPV+9/fP8Wbvc6g2eFRyHBqj9Krda6i3E7tUWMwXXRsFX0H+vZ0/IwOPGNh
	 yF5nWXPZqIooJtdAoTdkAJew1IOHy9lLUVPauBEHx1PMM1b8JosoEo7eODDUW1+yeNNoh
	 DpN8hjhPPyWeQrbur/lC073ZJF/gTHaSaGMVO6pWziQ/jZtJylB8pZ9zM4fb24Ph9Q0N+
	 izLN7QOHTN5OSg0Mh4R+GUF75b4fn+dH9bJxk2ksYccu9yBkDBMHtp4V4oiKmNFoGTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QNd9ePGbxKwxYGdrV6ECvHObD/IQ45c5rACC6IDcOWk=;
	b=O2ud1bQ5MwWvHYy6UPgyd1BicrDrTNxf+4LNjvmgf0FezIDpdOrKC0jTs1h2wum0g/OW
	 ezauL+jVuB88IFhtQFsWqmdIKksLOGzlMDTDJMfikwwtnUp732UJU/wvt4Q+UomOHU2OO
	 ODa2pBiSTyx9fy+IzyxhVvoNBqwo8PlXrMDXlt1J3xWtOl9FE/HC5XgXJM/fhWktZcjWy
	 aCeh4owJ35/Mdk4JhdBLX16Z+QWwAOLvW2jTvXeooBNscwSwQY6NvNevooU58B6b40KQh
	 WQvh1YzoDukdQW6brDz1ZnJsVKDX3SKdv8vR+bs9wsxDPADgmCnkdQKBr2iOq+sVzwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RFJBQrpA;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBAA606A323
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBAA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RFJBQrpA
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a079256596so1128562b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792788430; x=1793393230; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNd9ePGbxKwxYGdrV6ECvHObD/IQ45c5rACC6IDcOWk=;
        b=RFJBQrpA3M25subqbqry6PsCUwo7VLNKy1E9Ow7lJDV1ilLtVqul1wSwawG3LaF+2C
         H+dXEGnvSWdlVTcqlzb25ZFTin9se6OyEZUaHxLMCIMrdcQelWcNQCxU7U+lxnaOdbmC
         UPdPMPtQnNxg6yD729bUuBre5GRn0ykA241q0ZjPZiS12m1lZo/ES4GsUFpg5anm0qnO
         w9cUWlBbPLHyU8tAYqW/zwI/8AV4ae355CHRD4cJuUbyGMTlaNn1auUPDHGhpv7gPuXm
         N5LQUzJd0aCkU9sG/uQOlFMmaDFnzaVyEBGyj6NVfbXXgdHq/tFt5btx6zkAlm/UL7e8
         JJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788430; x=1793393230;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QNd9ePGbxKwxYGdrV6ECvHObD/IQ45c5rACC6IDcOWk=;
        b=B32LtkxGL5jB2uroWf2N/EAUEC7SjrcoVxTrVZV2fV+Z6xhoO4vPxh7kGSUIpwq/vL
         PnJQ3i6Lt8yZOw2WUpBOLy4+rjFM6W/CYU0ZKaiy7iwfPjA0d70bi3LmtWYPwGdFKNPu
         aGaTKhF6fbSjzTd7pGaLhRKXpXVAQK8ZEy/cl74cV0YLf2rCym7z05lgrYzL1L0oyQlE
         /ZI6gr1RmtPskVdOv+j15kA82vq786QvmtxIM3rx3ZN+bFNh0+fISXrJeQMI2IKOTAlz
         Y5t/czZc4HXG4z1OoUbWTreMpp5A+aYnn43NGT21ykqGeqrzmBWNBjiwPR481ewXiRfZ
         KgLA==
X-Gm-Message-State: AFq9FYJUHJwJ2KICorXNGXS0mcfb12hh7PryHExZOwPRTBkYYrqpm8+z
	Y+AMD+1VIasNzE46RZDwvifi522lppdPZhxan7X6wx5mGn/ST9gTpkfbO5yYDpW+uPFvWj6Mli+
	qb3wJHZW7INPKJqoWXEPspplLVgGzyS+hRlcj7afu+CWVF30CAUhJLK7EAQdy5Iq/qGd5wsH24Z
	zFPmPR85zj1vQqNOo/4oP4Q++6Jj1YW3eQiBdsP42Qr2lBlEU9j7osAOuJWvW+mYg=
X-Received: from pfbih21.prod.google.com ([2002:a05:6a00:8c15:b0:8a1:d11:a833])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a229:b0:881:be70:4490 with SMTP id d2e1a72fcca58-8a3686c10c8mr337858b3a.28.1792788429212;
 Fri, 23 Oct 2026 13:47:09 -0700 (PDT)
Date: Fri, 23 Oct 2026 20:47:03 +0000
In-Reply-To: <20261023204706.3112215-1-hramamurthy@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023204706.3112215-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023204706.3112215-2-hramamurthy@google.com>
Subject: [PATCH net v3 1/4] gve: Fix race between stats query and queue reconfig
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pin-yen Lin <treapking@google.com>, Debarghya Kundu <debarghyak@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

Fix a concurrency bug where network statistics queries race with queue
reconfiguration or interface teardown, causing a Use-After-Free (UAF) or
NULL pointer dereference.

Currently, statistics queries access priv->tx and priv->rx without
locking. When an interface is brought down or reconfigured,
gve_queues_mem_remove() frees these arrays. A concurrent stats query
can dereference freed queue structures and crash the kernel.

This issue was discovered and actually triggered by the
drivers/net/stats.py selftest. When an interface was brought down,
querying per-queue statistics via Netlink caused a kernel NULL pointer
dereference in gve_get_rx_queue_stats():

  BUG: kernel NULL pointer dereference, address: 00000000000000a0
  RIP: 0010:gve_get_rx_queue_stats+0x17/0x50 [gve]
  Call Trace:
   <TASK>
   netdev_stat_queue_sum+0x11c/0x250
   netdev_nl_stats_by_netdev+0x21b/0x2d0
   netdev_nl_qstats_get_dumpit+0xd2/0x220
   genl_dumpit+0x32/0x90
   netlink_dump+0x1d2/0x450
   __netlink_dump_start+0x1db/0x2a0
   genl_family_rcv_msg_dumpit+0x9b/0x100
   ...

Additionally, concurrent stats queries during queue reconfiguration can
race with gve_queues_mem_remove(), causing a Use-After-Free.

Fix this by introducing stats_lock to serialize stats queries against
queue teardown. In gve_queues_mem_remove(), queue pointers are set to
NULL under stats_lock before freeing. Stats readers acquire the lock
and verify pointers are non-NULL before reading counters.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Co-developed-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v3:
- Retitled from "gve: Add NULL pointer checks for per-queue statistics"
- Protect all stats queries and queue lifecycle updates with spinlock
  (sashiko)
- Refined the commit message

 drivers/net/ethernet/google/gve/gve.h      |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c | 37 +++++++++++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b7ce6e8632db..104468c2c07f 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -957,6 +957,8 @@ struct gve_priv {
 	struct workqueue_struct *gve_wq;
 	struct work_struct service_task;
 	struct work_struct stats_report_task;
+	/* Synchronizes stats accesses and queue teardown */
+	spinlock_t stats_lock;
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2437cd8ba633..26fdd22644f4 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -69,6 +69,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 	int num_tx_queues;
 	int ring;
 
+	spin_lock_bh(&priv->stats_lock);
 	num_tx_queues = gve_num_tx_queues(priv);
 	if (priv->rx) {
 		for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
@@ -96,6 +97,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 			s->tx_bytes += bytes;
 		}
 	}
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
@@ -642,9 +644,13 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
 
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+
+	spin_lock_bh(&priv->stats_lock);
 	priv->tx = NULL;
 	priv->rx = NULL;
+	spin_unlock_bh(&priv->stats_lock);
+
+	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 }
 
 static void gve_free_control_plane_resources(struct gve_priv *priv)
@@ -1383,6 +1389,7 @@ static int gve_queues_start(struct gve_priv *priv,
 	int err;
 
 	/* Record new resources into priv */
+	spin_lock_bh(&priv->stats_lock);
 	priv->tx = tx_alloc_cfg->tx;
 	priv->rx = rx_alloc_cfg->rx;
 
@@ -1396,10 +1403,11 @@ static int gve_queues_start(struct gve_priv *priv,
 	priv->rx_pages_per_qpl = rx_alloc_cfg->pages_per_qpl;
 	priv->header_split_enabled = rx_alloc_cfg->enable_header_split;
 	priv->rx_cfg.packet_buffer_size = rx_alloc_cfg->packet_buffer_size;
+	gve_init_sync_stats(priv);
+	spin_unlock_bh(&priv->stats_lock);
 
 	gve_tx_start_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg_rx->num_queues);
-	gve_init_sync_stats(priv);
 
 	err = netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);
 	if (err)
@@ -2266,6 +2274,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 	if (!gve_get_report_stats(priv))
 		return;
 
+	spin_lock_bh(&priv->stats_lock);
 	be64_add_cpu(&priv->stats_report->written_count, 1);
 	/* tx stats */
 	if (priv->tx) {
@@ -2330,6 +2339,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 			};
 		}
 	}
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 /* Handle NIC status register changes, reset requests and report stats */
@@ -2786,9 +2796,15 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
 				   struct netdev_queue_stats_rx *rx_stats)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct gve_rx_ring *rx = &priv->rx[idx];
+	struct gve_rx_ring *rx;
 	unsigned int start;
 
+	spin_lock_bh(&priv->stats_lock);
+	if (!priv->rx)
+		goto unlock;
+
+	rx = &priv->rx[idx];
+
 	do {
 		start = u64_stats_fetch_begin(&rx->statss);
 		rx_stats->packets = rx->rpackets;
@@ -2796,20 +2812,32 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
 		rx_stats->alloc_fail = rx->rx_skb_alloc_fail +
 				       rx->rx_buf_alloc_fail;
 	} while (u64_stats_fetch_retry(&rx->statss, start));
+
+unlock:
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static void gve_get_tx_queue_stats(struct net_device *dev, int idx,
 				   struct netdev_queue_stats_tx *tx_stats)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct gve_tx_ring *tx = &priv->tx[idx];
+	struct gve_tx_ring *tx;
 	unsigned int start;
 
+	spin_lock_bh(&priv->stats_lock);
+	if (!priv->tx)
+		goto unlock;
+
+	tx = &priv->tx[idx];
+
 	do {
 		start = u64_stats_fetch_begin(&tx->statss);
 		tx_stats->packets = tx->pkt_done;
 		tx_stats->bytes = tx->bytes_done;
 	} while (u64_stats_fetch_retry(&tx->statss, start));
+
+unlock:
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static void gve_get_base_stats(struct net_device *dev,
@@ -2935,6 +2963,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	INIT_WORK(&priv->service_task, gve_service_task);
 	INIT_WORK(&priv->stats_report_task, gve_stats_report_task);
+	spin_lock_init(&priv->stats_lock);
 	priv->tx_cfg.max_queues = max_tx_queues;
 	priv->rx_cfg.max_queues = max_rx_queues;
 
-- 
2.56.0.257.gf7497c7d27-goog

