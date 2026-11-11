Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370601;
	b=tMM7+Vpl2xU0lVtAyW2Kcq7uyENci+j9VkawK3yumPGsHYKBO5pFVsFsxATKlXZoD2+x
	 rL8jyslTkWzLju9Rsf29X3dUJOeBTTCfFi5HlOxMVPHvnIaczFZwGmeDqYbxv7/dmMZxp
	 i15LeYvxhiTAs3hCpneC+vtmxruYoj/A7aSjLxq50cZC+HAEFWWAuPpPDp05IrYGvXlMR
	 c7FixTE32icN0mU1ucFsy3wZH+w3JfXvDZx37Fe6hi5DEu62jfX+XVzK5kRLMReDYIMOK
	 hivZZJB+cEt+qCrWCKMyYIMzg07Az7XFvV767lxCvGkuCEqd8WEZ+eSOB2fQjd2iLgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370601;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=2y1JkX6mxnGpfxO0e3S3zqJ7kXfoxTqlTPvPsgfXQZs=;
	b=WadTL8rihiWmwwgmPHY6MeGz/hRXJAe7Ks2KEwYanOpYk4XsB/LgIYvJu/R1D87jGKZc
	 S9+OmXI+5v13UL3QDoY9MwQpW4yK5EHCKIS8MI9tzuc7Sr7GXDvxwUlHvk0o6JrNM/bhs
	 VaDiY9IVBSwWvgB5KWg61AE4SJjEpXMPT1nKtPrKinCyaLSigOa8Hhl1VhkqQKtrvuf3s
	 QVVsymFID10TENLDgWKD4FG5q9jaC+Vb6quetBJpfTXCmFN/WLgA+dKqzLA9ZSIdLzXDx
	 MONWJ257xdMp0rBBuoSMh2grAvLWoUk4P4yMmmLqY1o6In8FVL6AzAkhzKUIpPN7U3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jA+V5vSu;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED93606A33F;
	Wed, 11 Nov 2026 04:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED93606A33F
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
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jPVZh4zbQz1prQX;
	Wed, 11 Nov 2026 12:16:28 +0800 (CST)
Received: from dggpemr500014.china.huawei.com (unknown [7.185.36.230])
	by mail.maildlp.com (Postfix) with ESMTPS id 56ACF40579;
	Wed, 11 Nov 2026 12:16:37 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr500014.china.huawei.com (7.185.36.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 12:16:37 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 11 Nov 2026 12:16:34 +0800
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
Subject: [PATCH net-next v02 2/5] hinic3: Avoid concurrent updates on 32-bit systems.
Date: Wed, 11 Nov 2026 12:15:44 +0800
Message-ID: <3c49f9de764a5d8c463706882e191a945f376518.1794371175.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1794371175.git.gongfan1@huawei.com>
References: <cover.1794371175.git.gongfan1@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

