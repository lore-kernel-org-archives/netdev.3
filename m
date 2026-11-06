Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945695;
	b=N1FZRS3WljaJUTBJhW3lMwpODdWTw3A0pIZU9OPqY0tscQFP9juXUiTw/lqWlzgPklbI
	 +LFysu6VoxBYxpQLWUMhkxcsEFjVZvasijXuYqBb3o97HOo0y78FfQfHTI6wJEGW1p2V2
	 5tQLL1sDHtCorCYLQP2mGGqRXmlQha0KbkTJAeXcxxgGMi+/m1dwzgQqQs4wX/yGncr/6
	 3pnDXNu5RuDETXt3uZf55ne7X0DxF5UrBXUUPbv0YIg/H2e9E/7I2UeRN/O6KSgeSQueS
	 YxwqNbbYZ1DsrvOh7FbMUvD5UNyelXuB0Be/PXkQ7kQAGBuXzJfZ4gPmBw0Ie8CGTwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945695;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=e7knqyg+MQ9CfNG60ixCD1kzHXPnfmQw4mzjFXvAiMg=;
	b=dILUy0q6xT3KLsyRd1rQNjDCvzePgNEUaFU+YTidYuVX+hHhCb97LeqF6UicRLsiN9w5
	 rp0KNGOZyKovkJym6gsDO8qZnHoxKAyZETF7qguQ0xjkcKl1gLradfjln9U5hSBpbjZnI
	 IBLZ1KfQkLFBI5o33iRO2L6GWTj7xHdjCr9PUmGHy4w9gRZXdoxsJC/EdSQNAzVgC+AN5
	 W4HvGKX2RDmXbmyMy+DJo82UsnMYUF+J72SK8jiK6buxUFheskQAGKNc0MzurLTZrviOj
	 xmxHpKZAnQncrJhiLkhxe0SF8ivkVMeP7H+1p8JLLBz/KaUuUvTMp6IhLXH8/K+K62A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=LnJEw0FK;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D33606A329;
	Fri,  6 Nov 2026 06:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D33606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=LnJEw0FK
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e7knqyg+MQ9CfNG60ixCD1kzHXPnfmQw4mzjFXvAiMg=;
	b=LnJEw0FKsAInVyYKxDKYmXXB5kbjn5tfbHWvM2TTZcDhiXn1Mw9DuHKHaJcRn0RSSP2ETGruU
	b6v6zXrgniHwmKPUhU7IKawmZo0OSFTdDqyMeS3HHFYVsETjuIQpthkNwhWbRGZ4C19sE8QpRom
	dTqalFN4wi1Cw7ukvVITCqg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jLTQv4BGzzcb0J;
	Fri,  6 Nov 2026 14:14:15 +0800 (CST)
Received: from dggpemr200010.china.huawei.com (unknown [7.185.36.16])
	by mail.maildlp.com (Postfix) with ESMTPS id C4B4C40538;
	Fri,  6 Nov 2026 14:14:45 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr200010.china.huawei.com (7.185.36.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:45 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:43 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v01 2/4] Fixes: Avoid concurrent updates on 32-bit systems.
Date: Fri, 6 Nov 2026 14:14:29 +0800
Message-ID: <bebc65bd3d1af9d6f3cb0c8dcf9421bd6a432c58.1793946318.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1793946318.git.gongfan1@huawei.com>
References: <cover.1793946318.git.gongfan1@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemq100015.china.huawei.com (7.152.185.230)

As noted in the subsequent review.

In hinic3_get_stats64() in hinic3_netdev_ops.c, the reader retry loops
accumulate txq_stats and rxq_stats using '+=':
    do {
        start = u64_stats_fetch_begin(&txq_stats->syncp);
        bytes += txq_stats->bytes;
        ...
    } while (u64_stats_fetch_retry(&txq_stats->syncp, start));
If the loop retries due to concurrent updates on 32-bit systems,
the counters are added multiple times. This was previously benign
since the fields weren't populated by the driver, but these new
updates will cause incorrect statistics on 32-bit platforms.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_netdev_ops.c         | 35 ++++++++-----------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index da73811641a9..474ea81f1750 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -795,45 +795,38 @@ static void hinic3_get_stats64(struct net_device *netdev,
 	packets = 0;
 	dropped = 0;
 	for (i = 0; i < nic_dev->max_qps; i++) {
-		if (!nic_dev->txqs)
-			break;
-
 		txq = &nic_dev->txqs[i];
 		txq_stats = &txq->txq_stats;
 		do {
 			start = u64_stats_fetch_begin(&txq_stats->syncp);
-			bytes += txq_stats->bytes;
-			packets += txq_stats->packets;
-			dropped += txq_stats->dropped;
+			bytes = txq_stats->bytes;
+			packets = txq_stats->packets;
+			dropped = txq_stats->dropped;
 		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+		stats->tx_packets += packets;
+		stats->tx_bytes   += bytes;
+		stats->tx_dropped += dropped;
 	}
-	stats->tx_packets = packets;
-	stats->tx_bytes   = bytes;
-	stats->tx_dropped = dropped;
 
 	bytes = 0;
 	packets = 0;
 	errors = 0;
 	dropped = 0;
 	for (i = 0; i < nic_dev->max_qps; i++) {
-		if (!nic_dev->rxqs)
-			break;
-
 		rxq = &nic_dev->rxqs[i];
 		rxq_stats = &rxq->rxq_stats;
 		do {
 			start = u64_stats_fetch_begin(&rxq_stats->syncp);
-			bytes += rxq_stats->bytes;
-			packets += rxq_stats->packets;
-			errors += rxq_stats->csum_errors +
-				rxq_stats->other_errors;
-			dropped += rxq_stats->dropped;
+			bytes = rxq_stats->bytes;
+			packets = rxq_stats->packets;
+			errors = rxq_stats->other_errors;
+			dropped = rxq_stats->dropped;
 		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+		stats->rx_packets += packets;
+		stats->rx_bytes   += bytes;
+		stats->rx_errors  += errors;
+		stats->rx_dropped += dropped;
 	}
-	stats->rx_packets = packets;
-	stats->rx_bytes   = bytes;
-	stats->rx_errors  = errors;
-	stats->rx_dropped = dropped;
 }
 
 static void hinic3_nic_set_rx_mode(struct net_device *netdev)
-- 
2.43.0

