Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401938;
	b=UL+6h3xVYpxhO7u8N2kEf4wTi8zTiP4MAQuBRKDBN5Wc144yAdcrOcSPm4cF9kXy/nko
	 Asu/dKwWd7DEWCS6rBrN4dovoRhHlgeQP6FQm2RF6dlAVt5JS5QtExpi+E7APJt7NHIL1
	 iTNYiLOiZdEo6Z/1j5QmcjmfuNuIQkBbrMgist0TSZiJc3Zydt6t8VY6wsH9wvfD+jwnE
	 a6NbSDF2wQFoCfxCaXUGeMsIag2APyIYe+4GgLbjbvp1r0xAeo/+eh2zXiJ2ZAThnSA/p
	 /Hw0cAj/dr9lgbTybo8z4qI9Ug1BH8+fq5/7glRECGRz0C+zje6ZNxdk98dYuZTf5TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401938;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=HXuCN9Zqk+NdU/4KT5IZBaz2ySb1GLqXt6HsbLQInNg=;
	b=pozu1tEYuTR79uPw2O3Nv+P6SU1vwMGuLyhzO8iLRq08/tprMTWerr0iGnWLWTkAfsbw
	 K36DYGd7mh5yd3tHx7r+ASOxwiv19f9dG/pOlOb5+YDZrBxj/lqjE++If3Kofz1iiqkK6
	 NfgmsXkxaJ4+4eFqn5NjkdjPR8b2KtnCNMwZmGyiTwMIKpDZdqWaE4OuLJzVsnX4RF3Rr
	 PSJEzUPKV+Yd8CGqEdBH82Zk8n9RgcqqFcBcDIMrAIexWCF/5TJEZSZtRiiGEcn3Jq+lr
	 rftvkU+4kN8UlPhiysJv5hXtpah28wrw5D2UtGqI3+oxiHvc65h5w+1dZO/RgfegHCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vyjZDEbM;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570A606A31C;
	Wed, 11 Nov 2026 12:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3570A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vyjZDEbM
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HXuCN9Zqk+NdU/4KT5IZBaz2ySb1GLqXt6HsbLQInNg=;
	b=vyjZDEbMnJPByTD9/NNJlq3ijoR6mWb5WBUfmWacTGfA7MAUjRaU1XZaDvtuyayho86J5fOvC
	h2N19D0fd758rmrsZeYtGjHb6kIPKYC0G+ghh/7EFZBHXghd1Qa8ImQKao4A0ydcQLNPvWpdklN
	REOSetuRsMkfi6DTJJ/DtMc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jPk8l23J0zpSyt;
	Wed, 11 Nov 2026 20:58:15 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 0663B202E6;
	Wed, 11 Nov 2026 20:58:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 20:58:52 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net 1/4] net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data
Date: Wed, 11 Nov 2026 20:58:07 +0800
Message-ID: <20261111125810.3359030-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111125810.3359030-1-shaojijie@huawei.com>
References: <20261111125810.3359030-1-shaojijie@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500018.china.huawei.com (7.202.195.199)

When devm_kcalloc() fails for priv->tqp_vector after get_vector() has
already acquired MSI-X vectors, the error path returns without calling
put_vector() to release them, leaving the hclge/hclgevf bookkeeping
(num_msi_used, num_msi_left, vector_status[]) inconsistent.

Call put_vector() for every acquired vector before returning the error,
and reset priv->vector_num to 0 so the count never describes vectors
that were already handed back.

Fixes: dd38c72604dc ("net: hns3: fix for coalesce configuration lost during reset")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v4:
  - Correct the reason for resetting priv->vector_num.  Sashiko pointed
    out that hns3_nic_dealloc_vector_data() is not reachable after
    hns3_nic_alloc_vector_data() fails, so the reset is not protecting
    that path; it keeps the count from describing vectors that were
    already handed back.
v3: https://lore.kernel.org/all/20261030095633.377289-2-shaojijie@huawei.com/
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

