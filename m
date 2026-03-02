Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944682D061D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772419582; cv=none; b=eTdVrTnemGoZ6OdDgeKaTwjaSv5rQs2/Cq8EzCg6Hm64A6Z7TO+L6Lq5CJR76cLD3WBUbf3M0Zc8tWK3LcFcrrraaTOlpo/EGolb9bfIKxyvGOxLktfRTYrRYpdvr7Ku/xfDjurbIbiZuGlZhguEEMJkVGY+fW0hpHSO/aXprT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772419582; c=relaxed/simple;
	bh=2kaBpNODLsQxJ8M1dTsdmjGhKAxf+Kg7OFrqMgOaJko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RycXFLYTRYDlMR8UwO8NeuCfsWbhOrss97EaK/7F7eFva/dd3rNvx/ffbScW6jWshM8eISQTl6jjqnpf1StThDQqo6BqSOay1Y5rVH8l8gqHO+TvDeUV603ceYCDUl9DzjnYweuSuKUnB6tpVhnGK1CwXkBsYA9MwlAKfaj6k/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yPxUYnsT; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yPxUYnsT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772419572; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DXIuX/Q5FbKQ4/2C9EEbUgCLSi9Obci3dIRTStM02Lw=;
	b=yPxUYnsTTjURhQKReuGIdDyFelTriZIwY1FpudlTw5eS+x96tA94BOu7qdBlgLb3BjEw7vj/MRIa0D+02u8MFyRFB50lXrkI6pwsq7xRn/3uB1ES868C781NPDzHTgBVID+hObB3chktPRsdbaUId/KHVdF1xIoEjodVUqZi+wc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-.mEyP_1772419570 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 10:46:10 +0800
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
Subject: [PATCH net-next v28 8/8] eea: introduce callback for ndo_get_stats64
Date: Mon,  2 Mar 2026 10:46:04 +0800
Message-Id: <20260302024604.25354-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260302024604.25354-1-xuanzhuo@linux.alibaba.com>
References: <20260302024604.25354-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1928c291f6f8
Content-Transfer-Encoding: 8bit

This commit introduces ndo_get_stats64 support.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c | 55 ++++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h |  5 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index 67bacd295693..182a57add015 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -107,6 +107,8 @@ static void eea_bind_q_and_cfg(struct eea_net *enet,
 	struct eea_net_tx *tx;
 	int i;
 
+	spin_lock(&enet->stats_lock);
+
 	enet->cfg = ctx->cfg;
 	enet->rx = ctx->rx;
 	enet->tx = ctx->tx;
@@ -126,6 +128,8 @@ static void eea_bind_q_and_cfg(struct eea_net *enet,
 
 		blk->rx = rx;
 	}
+
+	spin_unlock(&enet->stats_lock);
 }
 
 static void eea_unbind_q_and_cfg(struct eea_net *enet,
@@ -135,6 +139,8 @@ static void eea_unbind_q_and_cfg(struct eea_net *enet,
 	struct eea_net_rx *rx;
 	int i;
 
+	spin_lock(&enet->stats_lock);
+
 	ctx->cfg = enet->cfg;
 	ctx->rx = enet->rx;
 	ctx->tx = enet->tx;
@@ -151,6 +157,8 @@ static void eea_unbind_q_and_cfg(struct eea_net *enet,
 
 		blk->rx = NULL;
 	}
+
+	spin_unlock(&enet->stats_lock);
 }
 
 static void eea_free_rxtx_q_mem(struct eea_net_init_ctx *ctx)
@@ -337,6 +345,50 @@ static int eea_netdev_open(struct net_device *netdev)
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
@@ -567,6 +619,7 @@ static const struct net_device_ops eea_netdev = {
 	.ndo_stop           = eea_netdev_stop,
 	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
 	.ndo_features_check = passthru_features_check,
 };
 
@@ -600,6 +653,8 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 		return NULL;
 	}
 
+	spin_lock_init(&enet->stats_lock);
+
 	return enet;
 }
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index fa14976aa335..cbfba365ad2a 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -162,6 +162,11 @@ struct eea_net {
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

