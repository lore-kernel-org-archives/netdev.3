Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584894;
	b=pn7nZpZtJ4CeOw04HrgCnfza/xrarDEgRYI2cX9TbosgvVpSdRWZrM/W/eL66Gggn1BR
	 g8bGZVqs6H+6lscRwAQUUlT/ju27nQtjICEyDzGog+tiU10bkNt2ChwXLikOKJDAuFoV1
	 P8+p3HhU/EJrRJY4gpxMDfIhoBPAfbJzvfLU3kNLjmoxv89+7OGQw/XXAivrVJo+vbvbq
	 shfbar4v0kz8SdgFjQy58SyDiJ9M5cbN+SJd6V2wRFfvoaZNmOxJ4k5RK/6E9M9oal1eF
	 UPU0O3MdphXt10jMJPa7cR75ODB8cOo6SS9sQR0PWGrEkZ7YFD2TsNdZwTXK/MV1SFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584894;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=1aLCrCY83kZmeumsZ3gfrMmWKqOZ+LFH4SgSm2GvtO4=;
	b=eCkCIlqppFM9TU7xR0yIh2FH0GO7RsbLbkbkl0xH9KDfcI7WSK1mTa1x4okm3BFQL40P
	 4E0/D57uxwKwQsyl5zOdM67yYNUQTQcQH8tDFYCFjL45btx99zUyLxZZxML0ayZBRz+Rp
	 W6b4rL5E/qarDjDVHtEsXc5psuD3v+8jbdw7IgT9hja/nHaUoeopKGhUKHtvjxFxKR557
	 jgtYuNq8fflGVdRAYctYLxQAoWJbwRvaXDd5kKuEO4wnJQXv7U+cvJVYWqXdiguj+k4T7
	 5ljnntZLMIS7YnZjMx6d/gHodlrhwvEU2ez/c7PvjEC/FGjTqF++gjt5JnR3Rrjsl3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ulo7PBC9;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACE606A31B;
	Wed, 21 Oct 2026 12:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDACE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ulo7PBC9
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1aLCrCY83kZmeumsZ3gfrMmWKqOZ+LFH4SgSm2GvtO4=;
	b=Ulo7PBC9+384LLGpKjq1CHJP8849stoAn9H763QxZmixrE2zbfELnU07fvHP0qSI7iutqwwvK
	bxqG4/bSe5oMrPMdNqW7Yr630Isg09cjQfQWmDeQG3phFhgrtwNhMTnWN3/+hKxJfmRPekHdnVH
	8S0f3aGwud73SoUywN72gV0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4j8pB64HHDzpTL5;
	Wed, 21 Oct 2026 20:14:38 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 39CBD40579;
	Wed, 21 Oct 2026 20:14:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 21 Oct 2026 20:14:47 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net 1/3] net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data
Date: Wed, 21 Oct 2026 20:14:24 +0800
Message-ID: <20261021121426.3096838-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021121426.3096838-1-shaojijie@huawei.com>
References: <20261021121426.3096838-1-shaojijie@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

After h->ae_algo->ops->get_vector() has acquired MSI-X vectors, a
subsequent devm_kcalloc failure for priv->tqp_vector jumps to 'out'
and returns without calling put_vector() to release them. The
underlying hclge/hclgevf bookkeeping (num_msi_used, num_msi_left,
vector_status[]) is left inconsistent: the vectors are marked as in
use but hns3_enet never tracks or releases them.

On the reset path this leak accumulates across failed reset attempts,
steadily reducing num_msi_left until get_vector() can no longer
satisfy the requested count, at which point the interface fails to
recover.

Call put_vector() for every vector acquired by get_vector() before
returning an error, and reset priv->vector_num so the dealloc path
cannot dereference a NULL priv->tqp_vector.

Fixes: dd38c72604dc ("net: hns3: fix for coalesce configuration lost during reset")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
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

