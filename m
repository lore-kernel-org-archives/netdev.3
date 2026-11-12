Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467200;
	b=Hrsv71rabXvWnMoRkP2rCZNmZDTXDH3cg2REOAdhoD5UBuwdxA8JHGJZL53B5PMzBLUY
	 M+MvCSjOYCl0sPv7cX3GR7b/gz+rvTadR5oQIhcFaylviZdyHBWN20dqvgz3jsHya81uw
	 scA4y4T2R12KQnqDS//zUO0nD5/u7cfPFwd4OdrzVhT/Ee9dfgBSQHKCW4B4nDF9ZSRyT
	 zAHLUVsJu01Z1eG0mXYp82ApbtcmqH1bSyaC1cZ23kI7lBMfLV8GGH2UvMyfZ4htldVWk
	 1nrVYPN2SApebP7Mv9TXWvwU4HdrFUzRpFUX1vtbWBpsTHy0/YySGewlXNdqx/1QutA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467200;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=2y1JkX6mxnGpfxO0e3S3zqJ7kXfoxTqlTPvPsgfXQZs=;
	b=3u4rRkobZFAPoLBk002bpLr+7/uFty7DxQHbT5yfz+/9x3hgh2ZPwa3ePMD1nc9Go/o9
	 QAYK01YnOiYJ/Buv1qAp/VSfF57578lJcLN8ZHLU4nYVlViJ7W9Nd8zw3TBuxGIzmFcvR
	 t7+AgWAiM5FQwH4pWT7UrYw1Sav0jX7VGoJMjoz4OYwv9+4yYjIVl1aT1kxPiMzh5sLkN
	 c5lbaIFS5XgfWw2Al3WQFmKxYN6QE5C3IetlZewMaN1xB8glSZ7FKiGT+Cpx2p2jOFcZX
	 njzpj3VQmwT8tJdtdcpT51ePcYZOUC39OsNuAQKFkcTNlVwWDtwQDc1x3Bvrd8vPT+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jA+V5vSu;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF1606A882;
	Thu, 12 Nov 2026 07:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7EF1606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jA+V5vSu
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2y1JkX6mxnGpfxO0e3S3zqJ7kXfoxTqlTPvPsgfXQZs=;
	b=jA+V5vSuOhslggVFrLmBUrFPKp5mebOPcKRcEO0Jau81RnxLQEqV0LDwQ5ZfZGnQLtaXB6JEA
	NQI2mlenI+Z6ZaggQGhA2R9LQMpVaKfpTCtgnuewOqKyRYwQVXdtYuJ4IcfeCDJ1QaJyWIBspNS
	FFD7ZW27m/jbW+chpNM4VNs=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jQBJL0yjfz1K97J;
	Thu, 12 Nov 2026 15:06:26 +0800 (CST)
Received: from dggpemr200001.china.huawei.com (unknown [7.185.36.96])
	by mail.maildlp.com (Postfix) with ESMTPS id 025874055B;
	Thu, 12 Nov 2026 15:06:36 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr200001.china.huawei.com (7.185.36.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 12 Nov 2026 15:06:35 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 12 Nov 2026 15:06:33 +0800
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
Subject: [PATCH net-next v03 2/4] hinic3: Avoid concurrent updates on 32-bit systems.
Date: Thu, 12 Nov 2026 15:06:21 +0800
Message-ID: <6e3be192de613fb537fc2050ce28e1bd71346e35.1794467919.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1794467919.git.gongfan1@huawei.com>
References: <cover.1794467919.git.gongfan1@huawei.com>
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

Within the while loop of hinic3_get_stats64(), the counters between
u64_stats_fetch_retry and u64_stats_fetch_begin are incremented by +=.
This operation will cause repeated counting of the counters on a 32-bit
system. Therefore, change += to + and the counters are incremented
out side the wile loop.

csum_errors and other_errors are not the same things. csum_errors will
go to csum_bad in netdev netlink qstats.

Remove unnecessary checks for the nic_dev->txqs and nic_dev->rxqs.

Remove dead stores before the loop.

Fixes: f47872bed40f ("hinic3: Add .ndo_tx_timeout and .ndo_get_stats64")
Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_netdev_ops.c         | 42 +++++++------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index da73811641a9..d1fd91d97ccf 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -791,49 +791,35 @@ static void hinic3_get_stats64(struct net_device *netdev,
 	unsigned int start;
 	int i;
 
-	bytes = 0;
-	packets = 0;
-	dropped = 0;
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
 
-	bytes = 0;
-	packets = 0;
-	errors = 0;
-	dropped = 0;
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

