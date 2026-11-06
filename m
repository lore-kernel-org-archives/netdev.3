Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945700;
	b=MmPM2pV0OrpQWmVQQxmArSSSEKdvkx6eY433zv0I7hu6AH54S+qNKv93Au3c/ac/rXpB
	 aJsmQTGerYEhHr+VkGqYX1eVthpVyp9sUAHQHC22et0lSPSatoXil2vbLaoxZIK0n2VRW
	 9aYlm1h45M+QSyEsn7JzbPkk3hz1F4uCjtKo0zNLUZwhAC2H82stAQnob6py3bzIdg/8B
	 E1hR7YO3j367+/Un6EqbYb/RUFk2nWNishOvGhEaW60OXRcf0ISeYJKFAgZikT+9SBrZl
	 JfHEvAnPkWt081NZPcH7aXWqAtjm23ZQ1cC8osncDlmYZ+CKGlFRBlD0fTdn+wjfBfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945700;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=QvVp0ukdpyYNfZssIWPn9mU9wd+wDj1I0IxH0hGlSh0=;
	b=fJrCFWyDEiZoS0fmxAtVwNVVgCWBXsQaX5UIqSeULZu98ZtVASyGGAC0Nup2U6NbcsTE
	 Xe37WL4PGkTGqFHV84UmAr3vQAg9EVRoped3Tp0dEMlqZJkl7FnprsuEbMQeTZgqBSRks
	 Ax07YqEOuQpttxUPCMorHU/fEm3FOdvGUYnAD50z4zNW7LZK86NL5JAoS4v9s2nFRuFJo
	 YyHhWaGBbP0/KDz5j98NIbmcaKjOqyiCezi8NXskPnqEVSX0LfEo3eHOuTi9GfoDsEh7X
	 qoR0rwN/z5RU4SfWbwKOtM4EmK+JyvTyMRVfg0r1jY0UjDnoK+FSqE9fYk2CCLRdIaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AhHBr21R;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7E606D80B;
	Fri,  6 Nov 2026 06:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F7E606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AhHBr21R
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QvVp0ukdpyYNfZssIWPn9mU9wd+wDj1I0IxH0hGlSh0=;
	b=AhHBr21R5miBcJAY/L13L4vhGwKTkP5EBP+PlBH1FHWmG0Jx5tw3eksm+scqgEyugQVZy6wP+
	ngMQouUR5a872/TAUWogVRLDADj6hE7gJ2l7TrFrfTm3A23NbQ6pKrG/P2d8aAAO7dSf+NOjaCH
	NLJoHNgGuFp7mvGkjk8obE8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jLTR103BZzcb0R;
	Fri,  6 Nov 2026 14:14:21 +0800 (CST)
Received: from dggpemr200006.china.huawei.com (unknown [7.185.36.167])
	by mail.maildlp.com (Postfix) with ESMTPS id 392BD4057F;
	Fri,  6 Nov 2026 14:14:51 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr200006.china.huawei.com (7.185.36.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:50 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:48 +0800
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
Subject: [PATCH net-next v01 4/4] Fixes: Ensure max_qps is always greater than or equal to num_qps
Date: Fri, 6 Nov 2026 14:14:31 +0800
Message-ID: <4baa1668ede031c9a980e7dae711bbaef91c23e5.1793946318.git.gongfan1@huawei.com>
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

After that, hinic3_sw_init()->hinic3_try_to_enable_rss() can shrink
max_qps to 1 when alloc_rss_resource() or hinic3_set_hw_rss_parameters()
fails:
hinic3_rss.c:hinic3_try_to_enable_rss() {
    ...
    err = alloc_rss_resource(netdev);
    if (err) {
        nic_dev->max_qps = 1;
        goto err_reset_q_params;
    }
    ...
}
Only hinic3_vport_up() lowers real_num_*_queues, and only on a successful
open. A device-scope dump before the first successful open (or after opens
that fail before hinic3_vport_up()) still does this:
netdev_nl_stats_by_netdev()
    netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
                          0, netdev->real_num_tx_queues, &tx_sum);
There is no netdev->up check on this path, so i runs from 1 to
func_max_qnum - 1 against a one-entry array.
Would this read past the end of the rxqs and txqs slab objects and return
those values to user space? NETDEV_CMD_QSTATS_GET does not require
GENL_ADMIN_PERM, so any local user can issue it.
The same applies to nic_dev->txqs[i] in hinic3_get_queue_stats_tx().
Before this patch hinic3 had no stat_ops, and hinic3_get_stats64() bounds
its loops by max_qps.

This patch also solve some defects reported by checkpatch.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_netdev_ops.c         | 24 ++++++++++---------
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 11 ++++-----
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 474ea81f1750..7428c4d98917 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -251,16 +251,17 @@ static void hinic3_remove_configure(struct net_device *netdev)
 		hinic3_rss_uninit(netdev);
 }
 
-static int hinic3_alloc_channel_resources(struct net_device *netdev,
-					  struct hinic3_dyna_qp_params *qp_params,
-					  struct hinic3_dyna_txrxq_params *trxq_params)
+static int
+hinic3_alloc_channel_resources(struct net_device *netdev,
+			       struct hinic3_dyna_qp_params *qp_params,
+			       struct hinic3_dyna_txrxq_params *q_params)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	int err;
 
-	qp_params->num_qps = trxq_params->num_qps;
-	qp_params->sq_depth = trxq_params->sq_depth;
-	qp_params->rq_depth = trxq_params->rq_depth;
+	qp_params->num_qps = q_params->num_qps;
+	qp_params->sq_depth = q_params->sq_depth;
+	qp_params->rq_depth = q_params->rq_depth;
 
 	err = hinic3_alloc_qps(nic_dev, qp_params);
 	if (err) {
@@ -268,7 +269,7 @@ static int hinic3_alloc_channel_resources(struct net_device *netdev,
 		return err;
 	}
 
-	err = hinic3_alloc_txrxq_resources(netdev, trxq_params);
+	err = hinic3_alloc_txrxq_resources(netdev, q_params);
 	if (err) {
 		netdev_err(netdev, "Failed to alloc txrxq resources\n");
 		hinic3_free_qps(nic_dev, qp_params);
@@ -278,13 +279,14 @@ static int hinic3_alloc_channel_resources(struct net_device *netdev,
 	return 0;
 }
 
-static void hinic3_free_channel_resources(struct net_device *netdev,
-					  struct hinic3_dyna_qp_params *qp_params,
-					  struct hinic3_dyna_txrxq_params *trxq_params)
+static void
+hinic3_free_channel_resources(struct net_device *netdev,
+			      struct hinic3_dyna_qp_params *qp_params,
+			      struct hinic3_dyna_txrxq_params *q_params)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 
-	hinic3_free_txrxq_resources(netdev, trxq_params);
+	hinic3_free_txrxq_resources(netdev, q_params);
 	hinic3_free_qps(nic_dev, qp_params);
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
index 25db74d8c7dd..4aa725339e60 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
@@ -308,14 +308,14 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
 
 	nic_dev->max_qps = hinic3_func_max_qnum(hwdev);
 	if (nic_dev->max_qps <= 1 ||
-	    !hinic3_test_support(nic_dev, HINIC3_NIC_F_RSS))
+	    !hinic3_test_support(nic_dev, HINIC3_NIC_F_RSS)) {
+		nic_dev->max_qps = 1;
 		goto err_reset_q_params;
+	}
 
 	err = alloc_rss_resource(netdev);
-	if (err) {
-		nic_dev->max_qps = 1;
+	if (err)
 		goto err_reset_q_params;
-	}
 
 	set_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
 	decide_num_qps(netdev);
@@ -324,7 +324,6 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
 	if (err) {
 		dev_err(hwdev->dev, "Failed to set hardware rss parameters\n");
 		hinic3_clear_rss_config(netdev);
-		nic_dev->max_qps = 1;
 		goto err_reset_q_params;
 	}
 
@@ -332,5 +331,5 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
 
 err_reset_q_params:
 	clear_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
-	nic_dev->q_params.num_qps = nic_dev->max_qps;
+	nic_dev->q_params.num_qps = 1;
 }
-- 
2.43.0

