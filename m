Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354232;
	b=bUAK9E4E+EKTIMqh0bewKi/WQjsZM83nm+htSCnh9n0/YMRjcM8ZStmnau9lkNz/hoIU
	 IiDk6iz2VXIJ+EM7IyoGHGxbDR+E9RKASkFIy2TmmlguMjCgf2v4FPukf67AQwdT9F8IC
	 aaak6QdYCWBj3qdNKZqcoAA4A6zCcchptfC9yMmIr7OSdtNoN9wyTZbeHArLLKdExGYdZ
	 51K7v3Es4uTGVhgaDmQ2BVfGgGWxrfSqvOAuzQU0ByYlWuJX/SOFeSvGIKX4RuBbDboL8
	 f+svwjgNmisSIlyPG66beFywamNBaCcRU30bkVkC+xi8h08HdRXEturaPyM78x1vZbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354232;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=l0b3yzd8jLZmsfAxCZxOg5bbVvZkTGrh8kBJd1GCz+w=;
	b=iLuM01E6zmWUAt45ZOEM9zQKK/t16tZdKdHxGnwtHra3UkwQEkvkPXnrhzKnBzHbL8TY
	 OiAWjvARnfuMW5LPFAkTgR6pu7NYow5yOO2ZFZVIGplShbH3lvia3Iq3nBkzAtb4pN9Sw
	 F541N403kwWgwTo9E/zRTOc9T95MCiig3+YIOBTjcHnkE2ylb7AN+C1ScpHat/F3snkaG
	 4PVOS4fEq6mU+GVhKBUWEfPdNqxD8xKfwvmOAFaSUooMZqW6SSyHSgYoe8rLmKqiJ4wcQ
	 mfMp+FqDR6qGXlnNvtsEdptUQASCvLI/AkqB7SXvNqQ6qHlZ/2hGivtcolxT+wCk73w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=U0TSMmgH;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503F606A320;
	Fri, 30 Oct 2026 09:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9503F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=U0TSMmgH
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l0b3yzd8jLZmsfAxCZxOg5bbVvZkTGrh8kBJd1GCz+w=;
	b=U0TSMmgHfS9LfZ5Oarbw1SMk7BaUUz1E5HC9FG6jJlriPIYPPTzsQScmkhhVZ9k5e9vHt05NG
	QI7z7KubOPqPhOrlMLksdmzFN0dFII8WckyKyEQEbpLmJGE0acT0B8PNId8Pyy5Ha7nxcf9PZ2H
	FoUzkZcQlKek+q/pV8qG8aw=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jGGjH0YdLz12LJL;
	Fri, 30 Oct 2026 17:57:07 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D6A140537;
	Fri, 30 Oct 2026 17:57:09 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 30 Oct 2026 17:57:08 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v3 net 1/4] net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data
Date: Fri, 30 Oct 2026 17:56:30 +0800
Message-ID: <20261030095633.377289-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030095633.377289-1-shaojijie@huawei.com>
References: <20261030095633.377289-1-shaojijie@huawei.com>
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
 kwepemo500018.china.huawei.com (7.202.195.199)

When devm_kcalloc() fails for priv->tqp_vector after get_vector() has
already acquired MSI-X vectors, the error path returns without calling
put_vector() to release them, leaving the hclge/hclgevf bookkeeping
(num_msi_used, num_msi_left, vector_status[]) inconsistent.

Call put_vector() for every acquired vector before returning the
error, and reset priv->vector_num to 0 to avoid a NULL deref in the
subsequent hns3_nic_dealloc_vector_data(), which iterates
priv->tqp_vector (still NULL after the kcalloc failure) using
priv->vector_num.

Fixes: dd38c72604dc ("net: hns3: fix for coalesce configuration lost during reset")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v3:
  - Simplify commit message: drop the accumulated-leak consequence
    paragraph and clarify that the vector_num reset avoids a NULL
    deref in hns3_nic_dealloc_vector_data().
v2: https://lore.kernel.org/all/20261021121426.3096838-2-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 47788be64be6..2f3aeade558c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4854,7 +4854,7 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
 			     GFP_KERNEL);
 	if (!priv->tqp_vector) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_put_vector;
 	}
 
 	for (i = 0; i < priv->vector_num; i++) {
@@ -4865,7 +4865,13 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
 		hns3_vector_coalesce_init(tqp_vector, priv);
 	}
 
-out:
+	devm_kfree(&pdev->dev, vector);
+	return 0;
+
+err_put_vector:
+	for (i = 0; i < vector_num; i++)
+		h->ae_algo->ops->put_vector(h, vector[i].vector);
+	priv->vector_num = 0;
 	devm_kfree(&pdev->dev, vector);
 	return ret;
 }
-- 
2.43.0

