Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467208;
	b=tx3BNZcGqnLSHylzoluxtPW2yDvh1IR/iTtGJDxiVECHY9ln41+WrZyzPfv4OdY4+D+j
	 nU87lk85LbcI4I4yfpFt9MF5olLBSsmZLglWi31/d8Do3GixytxL2YSkyPFhS7P+PLyKx
	 i01OgzuVV6a/1piC5nlc7FahtL0LIM9DZEA3+gZxJtMTOkKdAAKr23L9fV5AUnSFhD1is
	 wIVTPWQGRWjSn6X2vUnTyUQcimDpbnNmh5xIPfNxMVBGn1v0x6LBoavoHa4u7nrzFYZnw
	 RXMJ0kWslOSzA/cxSybtnr8AW2vq4bBnFMYa0b7QbYdXOYOF8QWAqiIJ8ktRrtvvjGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467208;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=BsCQVVvz9zb7LcZjSNA8RYs4+MpjCM1IzVsegs/bW0A=;
	b=EhnkN3LtRqiI6EcdQmHFXySxAm36cmPgcuu6DohjvcPMfOcSEiyHV2vtGMzwXN6Q26Tw
	 qi4kyOMBIQfgVJVkwK0twwHxR4+Il/fYU7lJzqZ8b9+OWrcEmjd6HHB+xrZbLAutYq07n
	 JgX5ZV2Bkj1n6783t+RaKjHtwXvtGHQyJQcraYuJsGZ4d9JOj12K2aT8PC+J04TIEm4RQ
	 lSKBPs4lFgzZcQWUalYaH5S5QFW5yDzepqXGZWI46HhRi/vfWhE/QazyK+YtrBzX4uw/V
	 zGKdHnL9pobE6T+K/7ueU8HsuSMyPMyBl/XGo/IrVKtyRIQQe3iQzsfVYZPYvw4GTLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=104Vu8B5;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C26606A334;
	Thu, 12 Nov 2026 07:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C26606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=104Vu8B5
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BsCQVVvz9zb7LcZjSNA8RYs4+MpjCM1IzVsegs/bW0A=;
	b=104Vu8B5ayC7TY++qQR8ptb/Ib7+FkAJf43feDhiAbSFGTaGt64rMnh7/njE2pn6lLYeb7ySA
	Yv6vBbQdkcDe/IQsbsN/oN5JWBKHdWUEItV1wNCmZPOw8CtM7VX7AU3c/O9NRO1YIIQpJkp4gRl
	TFBpfkOULy40nHRRVqpwZ2M=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jQBJl2hSxznTWy;
	Thu, 12 Nov 2026 15:06:47 +0800 (CST)
Received: from dggpemr100012.china.huawei.com (unknown [7.185.36.193])
	by mail.maildlp.com (Postfix) with ESMTPS id A353D40565;
	Thu, 12 Nov 2026 15:06:41 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr100012.china.huawei.com (7.185.36.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 12 Nov 2026 15:06:41 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 12 Nov 2026 15:06:39 +0800
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
Subject: [PATCH net-next v03 4/4] hinic3: Ensure that the value of max_qps is not changed
Date: Thu, 12 Nov 2026 15:06:23 +0800
Message-ID: <75d0140471d5f48801d6ad565ccd1829f337e35d.1794467919.git.gongfan1@huawei.com>
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

nic_dev->max_qps is used to allocate hardware resources. Therefore,
it is assigned the value 1 only when its value is abnormal. In other
scenarios, the value cannot be changed. However, the value of
nic_dev->q_params.num_qps can be dynamically changed.

Fixes: 1f3838b84a63 ("hinic3: Add Rss function")
Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_rss.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
index 25db74d8c7dd..75dc0c044071 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
@@ -307,15 +307,13 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
 	int err;
 
 	nic_dev->max_qps = hinic3_func_max_qnum(hwdev);
-	if (nic_dev->max_qps <= 1 ||
+	if (nic_dev->max_qps == 1 ||
 	    !hinic3_test_support(nic_dev, HINIC3_NIC_F_RSS))
 		goto err_reset_q_params;
 
 	err = alloc_rss_resource(netdev);
-	if (err) {
-		nic_dev->max_qps = 1;
+	if (err)
 		goto err_reset_q_params;
-	}
 
 	set_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
 	decide_num_qps(netdev);
@@ -324,7 +322,6 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
 	if (err) {
 		dev_err(hwdev->dev, "Failed to set hardware rss parameters\n");
 		hinic3_clear_rss_config(netdev);
-		nic_dev->max_qps = 1;
 		goto err_reset_q_params;
 	}
 
@@ -332,5 +329,5 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
 
 err_reset_q_params:
 	clear_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
-	nic_dev->q_params.num_qps = nic_dev->max_qps;
+	nic_dev->q_params.num_qps = 1;
 }
-- 
2.43.0

