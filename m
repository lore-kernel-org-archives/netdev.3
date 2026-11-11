Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370603;
	b=TBNGB+QxsE+NYXyv+bvTXWMHI/PgIRYrHEeW1Vet6g3R40PHf4ONkKpaxjMhmWIKe/xe
	 7sKusoKR7wh7nYRypMRBjvcjR/awr+4wry0e1NG/UHSyCp1meEb+MxSRbCk5abQHcrzol
	 GahtR97NoXS3/xZXBdUCILnPZUknCnRS+1ifC1VdPt+Dn1lW0h0ygBdt8Azc5X/yUpDnR
	 RPNGuyF+kBJWzi51tCESWLStEc8h4SpApJCq2Xp0rmKRNrZ0WHubm2id+PByGQXw0groT
	 ma2Z2sk22T5qs/6JkvMH+md9qWpFiEmDLXhzk5MoDB4ab6eTg3Hzic+aRi+EMLlmLvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370603;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=pEGlhtHsFfR5ChKdzBp7UcH4TYlGt4oT63PlzdWlMVs=;
	b=iPaOZAYjFS8LiFTaGGzNG+nxafFGHV21qZo87131JriSEIKfP+HRLe7pim4zNgNodn6S
	 DMYxDSggYmKeB8vyEvUA1EZE0+LcdKjPDnz7GU0vyHguO4aVyRrsmPSJsla30G+xplsDf
	 FyPieKp4zaqptIevHV6/5cLQyuVAx1XK+6LS7kmA2onLn1eq0BmykvIOuiAEHSMabc8aU
	 GvAPYoBytnCEQidTLBKKvL86Q771tZ/avK3tVicfaQPp0JiZYNnD6TboghNkQZ85ot79g
	 dta2iICGRjUNWKTtiTPQzGwhBPt8hOsr0FHup6XbpOl1XpqJHNYoEMQ+E8Sr64IU+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PQlNis98;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD5606A33B;
	Wed, 11 Nov 2026 04:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CFD5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PQlNis98
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pEGlhtHsFfR5ChKdzBp7UcH4TYlGt4oT63PlzdWlMVs=;
	b=PQlNis98t3EFe09GZ53o7yoZ1z5giYlpJNNvJs7Z4CKNegN1+8X1BmKxSGFJ5yr//eO0DmGb5
	xyvpa9B0JRrdJJCBhyuine2/AUlOBjfeO0PPTEYfVprc/kVcenr31B6TQ8XWa6pXHSyAiajgQxj
	hUI8RDZRMFZzFOw1p7Y/Wt0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jPVZL4bwLz1T4G1;
	Wed, 11 Nov 2026 12:16:10 +0800 (CST)
Received: from dggpemr500010.china.huawei.com (unknown [7.185.36.210])
	by mail.maildlp.com (Postfix) with ESMTPS id 1312E4057F;
	Wed, 11 Nov 2026 12:16:40 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr500010.china.huawei.com (7.185.36.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 12:16:39 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 11 Nov 2026 12:16:37 +0800
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
Subject: [PATCH net-next v02 3/5] hinic3: fix some checkpatchs.
Date: Wed, 11 Nov 2026 12:15:45 +0800
Message-ID: <a9a5d01e087f5240b514bdf878162a3f42f7291a.1794371175.git.gongfan1@huawei.com>
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

Fixes: 73f37a7e1993 ("hinic3: Queue pair resource initialization")
Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_netdev_ops.c         | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index d1fd91d97ccf..1c6cb1149028 100644
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
 
-- 
2.43.0

