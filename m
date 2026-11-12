Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467208;
	b=i1IB+JwJAxZC7bRQDATZS4XFqSZP0ZVkvSnJ/HVSOm0TqZ5T9eVFXlDwTDAx+f37ZKks
	 N7lNKVi7Gt2d6DMxGtdo1tHVVSesAPD2gLOGuxoBLGH/nIPejfVoq7OUX2iwyqlo7Fe2d
	 d/WqIy/NjFFZHlT/Attos2tZvkKzzBEyvCWf6d1IftFafgmrrPLb+wDkCQEInK25iXDip
	 WiLQTKzPvBkN4abpVulS/uvs0dtzhmqRVJI29xX8yaNeS/wBqPRkEFqjNqAm9ADLDDWLV
	 SGHb3jO/W5F/YH6d1Ngwre9drP3gA2+t5JpOVlOm3WNisuTKRB7L3k7mfASkxxRf3kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467208;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=wOgLppMITza0pnjiPtPVOh92L0e/zxieb1pVGYd6x98=;
	b=a7G+IznoyIetH3EBephFqfc/7C3aTQyLBA0EcM0JB3KbY1Pwrz66KIiN4qhPQCZ72cTa
	 4pZWU5s81LgnCAjMSw4d409T0n7iYf9gMAn/t8lczc6Lz7bjZoOIQDR7p0KjPqNW0/42I
	 ZgcMgZbEjoVXGTps+gWC8oOGQndfv6pVA/wJbe/hQ89IkdMqXa/bohOTD8odEai/Opi7l
	 zJUZ8TtLfaNLjeTMtbgAPNmmgG5UhrVNhF6DFlZBaRPXD5Kp4unNho7/d0Pg/7SI8IVUn
	 tug7ZkBajViR4ebRABZ8DZuyCkT0Ni/i3hBZJG0T3hRdkgnV0dc4IgJxlPQSFThBxUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xMOMxl99;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D434606A339;
	Thu, 12 Nov 2026 07:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D434606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xMOMxl99
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wOgLppMITza0pnjiPtPVOh92L0e/zxieb1pVGYd6x98=;
	b=xMOMxl99ja65ncnH94KpC4vbR9s8MBfQ1kb4Ufc2MX+aDQUhYfRpZBFAj6m4asiyn6JAlg90b
	YcmeMbD9GPc5s1n8pChPEX8DcyzZTbl+/A/uo60uBpg8tx5NHibcAWiqzro0G3Jql+HYdDvTtLn
	5eRxrLGaquYatlN+JanSGNQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jQBJh0c2Kz12LDK;
	Thu, 12 Nov 2026 15:06:44 +0800 (CST)
Received: from dggpemr100014.china.huawei.com (unknown [7.185.36.48])
	by mail.maildlp.com (Postfix) with ESMTPS id AA37740537;
	Thu, 12 Nov 2026 15:06:38 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr100014.china.huawei.com (7.185.36.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 12 Nov 2026 15:06:38 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 12 Nov 2026 15:06:36 +0800
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
Subject: [PATCH net-next v03 3/4] hinic3: fix some checkpatchs.
Date: Thu, 12 Nov 2026 15:06:22 +0800
Message-ID: <59ce18b47a2b268640831999b518ae662f86ff7f.1794467919.git.gongfan1@huawei.com>
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

Cleanup checkpatchs of lines exceeding 80 columns.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_netdev_ops.c         | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index d1fd91d97ccf..621d8b12e247 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -121,8 +121,9 @@ static void hinic3_destroy_num_qps(struct net_device *netdev)
 	kfree(nic_dev->qps_msix_entries);
 }
 
-static int hinic3_alloc_txrxq_resources(struct net_device *netdev,
-					struct hinic3_dyna_txrxq_params *q_params)
+static int
+hinic3_alloc_txrxq_resources(struct net_device *netdev,
+			     struct hinic3_dyna_txrxq_params *q_params)
 {
 	int err;
 
@@ -176,8 +177,9 @@ static int hinic3_alloc_txrxq_resources(struct net_device *netdev,
 	return err;
 }
 
-static void hinic3_free_txrxq_resources(struct net_device *netdev,
-					struct hinic3_dyna_txrxq_params *q_params)
+static void
+hinic3_free_txrxq_resources(struct net_device *netdev,
+			    struct hinic3_dyna_txrxq_params *q_params)
 {
 	hinic3_free_rxqs_res(netdev, q_params->num_qps, q_params->rq_depth,
 			     q_params->rxqs_res);
@@ -251,16 +253,17 @@ static void hinic3_remove_configure(struct net_device *netdev)
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
@@ -268,7 +271,7 @@ static int hinic3_alloc_channel_resources(struct net_device *netdev,
 		return err;
 	}
 
-	err = hinic3_alloc_txrxq_resources(netdev, trxq_params);
+	err = hinic3_alloc_txrxq_resources(netdev, q_params);
 	if (err) {
 		netdev_err(netdev, "Failed to alloc txrxq resources\n");
 		hinic3_free_qps(nic_dev, qp_params);
@@ -278,13 +281,14 @@ static int hinic3_alloc_channel_resources(struct net_device *netdev,
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
 
-- 
2.43.0

