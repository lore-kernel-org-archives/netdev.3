Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671935;
	b=cDpH6Z9giHiAb+etD3WByskk9csdHiGta4eYlHf8mq4/cfFO8MB5HkivQygDI0erRcxF
	 YCiD0gb3TP8WCB0Ii+PRfdNji4Mlzg7se+waK7ifwgIs8Ekz72dqhPGYcQ0klC+RnBLsV
	 NT395EDGYIxIEnoBt4cyeo1N33OfQJmNDmdEuLLUMnnh/PqONR7ApjnUUfMd9YascUBx2
	 zd4hUiELQjB3ijpWnEYzOYt8FUnwzEmLcpuAwqQzt5W2Hxq2dja5Fva4o4brWLrlkFfig
	 fKIN6Bwng6S57rwqyx5RmTyVSsMI2K4BTAYucYK/hqc2+/HAkGBjGhRV820IJcYPgQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671935;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=mBUxsbLApWLhRF3wrcUSoNAje6LUvQFE4Pk/81IZDAM=;
	b=GM8hnUpz2ni60rwsjDQtPmiywTzUnt20WegXWWJTein6pC1buQcYkI1tLfrAIDfVan1a
	 ZYRsgAN69EOhHebga1oER0xq476IfMmX2dDazd7wpxhiGAdnveJeR72lAz5jDXH+FSGcr
	 Mqlt+GOEbjbtMLgDmP38ROmuoAt6HuDkYOlaqK3LFna0krtlqhGAamGM4g3wFNFgPw26h
	 y6i/Gps3tx7ZxyqktuKsxtKblfZ+U/le7k8cC90tiu6rnUn8BVV/A12pMe2LanElqvNhL
	 GwQmAWZkOl9gDaYZT/UlHj0CR4Rgdgow9S/1fHgw/1+5plyA5mpFmLqClIS7udJ/UwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KrDeH4GX;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016A606A321;
	Thu, 22 Oct 2026 12:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6016A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KrDeH4GX
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mBUxsbLApWLhRF3wrcUSoNAje6LUvQFE4Pk/81IZDAM=;
	b=KrDeH4GXmOMYxrg3tHroyMbs2BxunwsR+sbrnRDeeOcLu22+ANaigPBJkaEP0YmP9ofgZeZ+M
	UfjNE8jA+9mQBElyGUpfvLdSHMydYxmWdRKNSNgCWAOYvMGaA47qAms806uTyuH109nWdq6JR8r
	qkX3XzoHVRUESFGJIwgKhsY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j9QN76bvFzLlxj;
	Thu, 22 Oct 2026 20:25:27 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id AFC5A40565;
	Thu, 22 Oct 2026 20:25:30 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 22 Oct 2026 20:25:29 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v18 3/4] hinic3: Add Add per queue netdev-genl stats
Date: Thu, 22 Oct 2026 20:25:17 +0800
Message-ID: <b241adb884df2f371ff5399e3be86199eed35250.1792671176.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1792671176.git.gongfan1@huawei.com>
References: <cover.1792671176.git.gongfan1@huawei.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_netdev_ops.c         | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index c71bb3dff39c..10364c4dc11f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -5,6 +5,7 @@
 #include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <net/vxlan.h>
+#include <net/netdev_queues.h>
 
 #include "hinic3_hwif.h"
 #include "hinic3_nic_cfg.h"
@@ -866,7 +867,80 @@ static const struct net_device_ops hinic3_netdev_ops = {
 	.ndo_start_xmit       = hinic3_xmit_frame,
 };
 
+static void hinic3_get_queue_stats_rx(struct net_device *netdev, int i,
+				      struct netdev_queue_stats_rx *stats_rx)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_rxq_stats *rxq_stats;
+	struct hinic3_rxq *rxq;
+	unsigned int start;
+
+	rxq = &nic_dev->rxqs[i];
+	rxq_stats = &rxq->rxq_stats;
+	do {
+		start = u64_stats_fetch_begin(&rxq_stats->syncp);
+		stats_rx->bytes = rxq_stats->bytes;
+		stats_rx->packets = rxq_stats->packets;
+		stats_rx->csum_bad = rxq_stats->csum_errors;
+		stats_rx->alloc_fail = rxq_stats->alloc_fail;
+	} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+}
+
+static void hinic3_get_queue_stats_tx(struct net_device *netdev, int i,
+				      struct netdev_queue_stats_tx *stats_tx)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_txq_stats *txq_stats;
+	struct hinic3_txq *txq;
+	unsigned int start;
+
+	txq = &nic_dev->txqs[i];
+	txq_stats = &txq->txq_stats;
+	do {
+		start = u64_stats_fetch_begin(&txq_stats->syncp);
+		stats_tx->bytes = txq_stats->bytes;
+		stats_tx->packets = txq_stats->packets;
+		stats_tx->stop = txq_stats->busy;
+	} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+}
+
+static void hinic3_get_base_stats(struct net_device *netdev,
+				  struct netdev_queue_stats_rx *stats_rx,
+				  struct netdev_queue_stats_tx *stats_tx)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int i;
+
+	memset(stats_rx, 0, sizeof(*stats_rx));
+	memset(stats_tx, 0, sizeof(*stats_tx));
+
+	for (i = nic_dev->q_params.num_qps; i < nic_dev->max_qps; i++) {
+		struct netdev_queue_stats_rx rx = {0};
+
+		hinic3_get_queue_stats_rx(netdev, i, &rx);
+		stats_rx->bytes += rx.bytes;
+		stats_rx->packets += rx.packets;
+		stats_rx->csum_bad += rx.csum_bad;
+	}
+
+	for (i = nic_dev->q_params.num_qps; i < nic_dev->max_qps; i++) {
+		struct netdev_queue_stats_tx tx = {0};
+
+		hinic3_get_queue_stats_tx(netdev, i, &tx);
+		stats_tx->bytes += tx.bytes;
+		stats_tx->packets += tx.packets;
+		stats_tx->stop += tx.stop;
+	}
+}
+
+static const struct netdev_stat_ops hinic3_stat_ops = {
+	.get_queue_stats_rx  = hinic3_get_queue_stats_rx,
+	.get_queue_stats_tx  = hinic3_get_queue_stats_tx,
+	.get_base_stats      = hinic3_get_base_stats,
+};
+
 void hinic3_set_netdev_ops(struct net_device *netdev)
 {
 	netdev->netdev_ops = &hinic3_netdev_ops;
+	netdev->stat_ops = &hinic3_stat_ops;
 }
-- 
2.43.0

