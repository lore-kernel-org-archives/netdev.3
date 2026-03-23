Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1765362128
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251901; cv=none; b=iyD1PO4wUvzXkkMmiu0ntCn8LSX5NIBqvE2UL4Cl43kfFFOLhzNGf1MAihr13X6osg3fCAjHvTY9++v2QHfMYQeNODFI8mvYSk5QNLnHndcG4gcAOLyW0pAr88BBzA7q+/hpSUjJ47JMMQuaCjjRrGrTWkrIvKBmeqJ2nyFptNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251901; c=relaxed/simple;
	bh=o/QciJj9ZMbmMRHfx84GuQkIJ3RBbmNhooSIar++Ekc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWdtpxc8GLp9x6Rb+sCKuwsJF65l8nQHJvPrVHdPYsycu0uZR7+Tm9NwRtDj0gulRvHBB/sTc42PU3QGOlEpYE9VBw4DvXJ7KmVsdvQ5r6id8tgUosyVkhK7blOvza2tbfIOWdOG/pmH8EnM6qmU2bkZx+8fNNLn/Dm5oJVQewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=igf7xkcK; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="igf7xkcK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774251890; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RBLCmHyO5EwL4x5dG5/HTvWdr3oQSTz4SxWAnn/iHeM=;
	b=igf7xkcKYvuw2zBk1R7VLImA3pNfEjHpHgBkOA5laSXMWudXLTHeHBfUPvrmBKJWMyZOKvR/iIYBdc08n49cE5GE4bBjVv5ZoonsFUjkSACkPLSLbCxUhPKyh08afX6nA61dagNFIAz+BfjvKErTCsodlzpEX029dktg2cLSu48=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X.UZD5C_1774251887;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.UZD5C_1774251887 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 15:44:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v35 8/8] eea: introduce callback for ndo_get_stats64
Date: Mon, 23 Mar 2026 15:44:41 +0800
Message-Id: <20260323074441.91691-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260323074441.91691-1-xuanzhuo@linux.alibaba.com>
References: <20260323074441.91691-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e4fbcae2755f
Content-Transfer-Encoding: 8bit

This commit introduces ndo_get_stats64 support.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c | 57 ++++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h |  5 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index a1908ec492fb..02a7e72183d1 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -112,6 +112,8 @@ static void eea_bind_q_and_cfg(struct eea_net *enet,
 	struct eea_net_tx *tx;
 	int i;
 
+	spin_lock(&enet->stats_lock);
+
 	enet->cfg = ctx->cfg;
 	enet->rx = ctx->rx;
 	enet->tx = ctx->tx;
@@ -131,6 +133,8 @@ static void eea_bind_q_and_cfg(struct eea_net *enet,
 
 		blk->rx = rx;
 	}
+
+	spin_unlock(&enet->stats_lock);
 }
 
 static void eea_unbind_q_and_cfg(struct eea_net *enet,
@@ -140,6 +144,8 @@ static void eea_unbind_q_and_cfg(struct eea_net *enet,
 	struct eea_net_rx *rx;
 	int i;
 
+	spin_lock(&enet->stats_lock);
+
 	ctx->cfg = enet->cfg;
 	ctx->rx = enet->rx;
 	ctx->tx = enet->tx;
@@ -156,6 +162,8 @@ static void eea_unbind_q_and_cfg(struct eea_net *enet,
 
 		blk->rx = NULL;
 	}
+
+	spin_unlock(&enet->stats_lock);
 }
 
 static void eea_free_rxtx_q_mem(struct eea_net_init_ctx *ctx)
@@ -341,6 +349,50 @@ static int eea_netdev_open(struct net_device *netdev)
 	return err;
 }
 
+static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u64 packets, bytes;
+	u32 start;
+	int i;
+
+	spin_lock(&enet->stats_lock);
+
+	if (enet->rx) {
+		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+			struct eea_net_rx *rx = enet->rx[i];
+
+			do {
+				start = u64_stats_fetch_begin(&rx->stats.syncp);
+				packets = u64_stats_read(&rx->stats.packets);
+				bytes = u64_stats_read(&rx->stats.bytes);
+			} while (u64_stats_fetch_retry(&rx->stats.syncp,
+						       start));
+
+			tot->rx_packets += packets;
+			tot->rx_bytes   += bytes;
+		}
+	}
+
+	if (enet->tx) {
+		for (i = 0; i < enet->cfg.tx_ring_num; i++) {
+			struct eea_net_tx *tx = &enet->tx[i];
+
+			do {
+				start = u64_stats_fetch_begin(&tx->stats.syncp);
+				packets = u64_stats_read(&tx->stats.packets);
+				bytes = u64_stats_read(&tx->stats.bytes);
+			} while (u64_stats_fetch_retry(&tx->stats.syncp,
+						       start));
+
+			tot->tx_packets += packets;
+			tot->tx_bytes   += bytes;
+		}
+	}
+
+	spin_unlock(&enet->stats_lock);
+}
+
 /* resources: ring, buffers, irq */
 int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 {
@@ -348,7 +400,9 @@ int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 	int err, error;
 
 	if (!netif_running(enet->netdev) || !enet->started) {
+		spin_lock(&enet->stats_lock);
 		enet->cfg = ctx->cfg;
+		spin_unlock(&enet->stats_lock);
 		return 0;
 	}
 
@@ -569,6 +623,7 @@ static const struct net_device_ops eea_netdev = {
 	.ndo_stop           = eea_netdev_stop,
 	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
 	.ndo_features_check = passthru_features_check,
 };
 
@@ -602,6 +657,8 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 		return NULL;
 	}
 
+	spin_lock_init(&enet->stats_lock);
+
 	return enet;
 }
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index a16d662c7fb3..c53c5bcb6bfc 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -163,6 +163,11 @@ struct eea_net {
 	u32 speed;
 
 	u64 hw_ts_offset;
+
+	/* Protect the tx and rx of struct eea_net, when eea_stats accesses the
+	 * stats from rx and tx queues.
+	 */
+	spinlock_t stats_lock;
 };
 
 int eea_net_probe(struct eea_device *edev);
-- 
2.32.0.3.g01195cf9f

