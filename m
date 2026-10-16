Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D73839B9;
	Fri, 16 Oct 2026 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148736; cv=none; b=jaUf1U0BFcyywbh0E4Tbc/wsw9pQwBT2OmfRDnGzft9ItzWUBvvynon7H/tmb3hBOAwXHY046YPzLSYLT5eYSeyyhlbJepjgIOUzlixK1QJZR+Ns8VS/kdSHlJqJ2u/oREQwlUbIsNS3COoOLB8Z6P6NpN6ehtyTWM2R/8TQTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148736; c=relaxed/simple;
	bh=LByWRXajK67wq0RbIlnsmZzP2zDvn44yhPWlX8XvTn0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sbN5ktYZZT3ypQMAZ/pTLtdENWQdOa/QX+zKg/3tyk67GLawblZeAUECaWMJE66AQs7K3t4ZLn4u/I6AKcQqHMYJKGuWCT5UDHZVrA5lR833YW9AMG7TGYuZRrHdY67Hpr1NWN6HxuL4UoXF3SkuISvtqK7M9qDFtYULcMHjsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t4ibAc/n; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t4ibAc/n"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IpH6WpRMGBFFtuBKjnQlmIu8euPNlbEAiplbtgmSkeg=;
	b=t4ibAc/nC9VHOz4F1Qnz6NwePAPT1uH47UiJOFXUpjj5AF5Q1bVJvx8puoZ4cyj9eeogjbwgK
	CEW6rdgdJMlCEsaNG86+8xEUQ56jCDDV9+Qq18ZUE4GSLm9yJdSHblXpFP4dWJrKHQcCBZI/b42
	s8mYDoLL1d/zXZ894N8Ix2k=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j5hcB6Qc6zKm6K;
	Fri, 16 Oct 2026 18:52:58 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id E59304048B;
	Fri, 16 Oct 2026 19:05:21 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 16 Oct 2026 19:05:21 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <shiyongbang@huawei.com>, <fengzheng6@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net] net: hibmcge: set netdev_ops before hbg_init() to fix NULL pointer dereference
Date: Fri, 16 Oct 2026 19:04:21 +0800
Message-ID: <20261016110421.2288670-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500018.china.huawei.com (7.202.195.199)

The driver assigns netdev_ops after hbg_init(), but hbg_init() calls
hbg_mdio_init() -> hbg_phy_connect() -> phy_connect_direct() ->
phy_attach_direct() -> phy_link_topo_add_phy(), which invokes
netdev_need_ops_lock(). With CONFIG_NET_SHAPER enabled, this function
dereferences dev->netdev_ops->net_shaper_ops. Since netdev_ops is still
NULL at this point, a NULL pointer dereference occurs.

Move the netdev_ops assignment before hbg_init() so that
netdev_need_ops_lock() can safely access netdev_ops during PHY
attachment.

Fixes: ff4edac6e9bd ("net: hibmcge: Implement some .ndo functions")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 66792e2b0fad..a518dc66d9ef 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -448,6 +448,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	netdev->netdev_ops = &hbg_netdev_ops;
 	ret = hbg_init(priv);
 	if (ret)
 		return ret;
@@ -460,7 +461,6 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netdev->max_mtu = priv->dev_specs.max_mtu;
 	netdev->min_mtu = priv->dev_specs.min_mtu;
-	netdev->netdev_ops = &hbg_netdev_ops;
 	netdev->watchdog_timeo = 5 * HZ;
 
 	hbg_hw_set_mtu(priv, ETH_DATA_LEN);

base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
-- 
2.43.0

