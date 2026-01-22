Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74F3E9F7F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083522; cv=none; b=MzXvhbEr/iYeqRE/MA2B/jOGleVTxlCMoH3V9AXd7u1B/RqmAnBA6CrKlU96MpM9ZCRHK6hDqxHlEDfr8KzlaEzbrumdEPW3MG0VEw7gw/DL12nU0wHFVpC9iInF73NkBQWIa0qJQxEUlHdfGLnA3JltdAp2xPmkYKAfGDUCdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083522; c=relaxed/simple;
	bh=OLCZ12e0QX/lX/WusDUYZSH4mUo8CD8TjV7aCnSFIxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvvdPJQdhmw5RU2YVrssmL4uEkiDPx2JTeljb/DuC/xOOT1twnmEGyAT1llrfFqffeAAESEeWN+lMczw98FSsaucDOZ6G94kqpf0+thnz2bGGJxlDtsxNbeZ6gTyUnKa2mY3DA/ZKOz5zRuBFwrQ/HDGciQ82vgad4nztDMTY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=syT0zy3h; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="syT0zy3h"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769083514; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=li2bsbmTagTFxs5QLsxy0h7zjvI554IzOSbZpx0Tjb0=;
	b=syT0zy3hbcEQLyhNQOIwE2RLg8PHI3SNKOvozYwXB6bdnxxhGBYw3thVPyu+8ne6gRwptyvuFjxgmi3mUSkdV+yPejG0OgqEgm3E6WOXElckYo0npTmRtbny5IGlhqkLB2+t2S28PPOzaDxtVFbdXGVf1ZO1FFG6snTe9oSjoYs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WxcE26o_1769083512 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 20:05:13 +0800
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
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v22 6/6] eea: introduce callback for ndo_get_stats64
Date: Thu, 22 Jan 2026 20:05:08 +0800
Message-Id: <20260122120508.17452-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260122120508.17452-1-xuanzhuo@linux.alibaba.com>
References: <20260122120508.17452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: f8898de39b6a
Content-Transfer-Encoding: 8bit

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit introduces ndo_get_stats64 support.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c | 51 ++++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h |  5 +++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index 89a1521d772f..d05c6b5acd14 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -27,8 +27,10 @@ static void enet_bind_new_q_and_cfg(struct eea_net *enet,
 
 	enet->cfg = ctx->cfg;
 
+	spin_lock(&enet->stats_lock);
 	enet->rx = ctx->rx;
 	enet->tx = ctx->tx;
+	spin_unlock(&enet->stats_lock);
 
 	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
 		rx = ctx->rx[i];
@@ -54,11 +56,13 @@ static void eea_free_rxtx_q_mem(struct eea_net *enet)
 	struct eea_net_tx *tx, *tx_array;
 	int i;
 
+	spin_lock(&enet->stats_lock);
 	rx_array = enet->rx;
 	tx_array = enet->tx;
 
 	enet->rx = NULL;
 	enet->tx = NULL;
+	spin_unlock(&enet->stats_lock);
 
 	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
 		rx = rx_array[i];
@@ -264,6 +268,50 @@ static int eea_netdev_open(struct net_device *netdev)
 	return err;
 }
 
+static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u64 packets, bytes;
+	u32 start;
+	int i;
+
+	spin_lock_bh(&enet->stats_lock);
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
+	spin_unlock_bh(&enet->stats_lock);
+}
+
 /* resources: ring, buffers, irq */
 int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 {
@@ -455,6 +503,7 @@ static const struct net_device_ops eea_netdev = {
 	.ndo_stop           = eea_netdev_stop,
 	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
 	.ndo_features_check = passthru_features_check,
 	.ndo_tx_timeout     = eea_tx_timeout,
 };
@@ -480,6 +529,8 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 	enet->edev = edev;
 	edev->enet = enet;
 
+	spin_lock_init(&enet->stats_lock);
+
 	return enet;
 }
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index 78a621c2ce4c..f32d26e156ab 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -157,6 +157,11 @@ struct eea_net {
 	u32 speed;
 
 	u64 hw_ts_offset;
+
+	/* Protect the tx and rx of struct eea_net, when eea_stats accesses the
+	 * stats from rx and tx queues.
+	 */
+	spinlock_t stats_lock;
 };
 
 int eea_tx_resize(struct eea_net *enet, struct eea_net_tx *tx, u32 ring_num);
-- 
2.32.0.3.g01195cf9f

