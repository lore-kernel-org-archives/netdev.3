Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B93C10AF;
	Tue, 15 Sep 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478806; cv=none; b=rC2s9YAlK8+4MrN17Z4LKf8Btl4VHlzLB/cXNVJOxoVPjgxdaB1B0pO23t64ADl5NatMnKzCPwwZLUBx/L8IwfeavVcT60NsNfc50IxYZgQTnDVVyfLolOO9VfMS3DuBPWmFPFb+5IAjw409AsO6nAvwdeRzA1nHr9gEhgrjURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478806; c=relaxed/simple;
	bh=sk0GpVTuDyxzFHdUWJhUkLuwP5xOab3A1wc2PKBTvmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5Tg/vApiKGtEsL5cwXcnyX2h48djobTAawSG6S80s3PeGxBnVV6zdy5+OB+V/Uu4DXvM+zy/TC6r+iBrSVp3Ma/bAGJqGbNfZ06YQRzl6zUl98TJNNC//RTidH2AdJ+uU2ZLdR/FTFTscBt7O2caTxTlg17YuAGDKC4i0xHAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ulo7PBC9; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ulo7PBC9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1aLCrCY83kZmeumsZ3gfrMmWKqOZ+LFH4SgSm2GvtO4=;
	b=Ulo7PBC9+384LLGpKjq1CHJP8849stoAn9H763QxZmixrE2zbfELnU07fvHP0qSI7iutqwwvK
	bxqG4/bSe5oMrPMdNqW7Yr630Isg09cjQfQWmDeQG3phFhgrtwNhMTnWN3/+hKxJfmRPekHdnVH
	8S0f3aGwud73SoUywN72gV0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hkjFC4k1GzLlSh;
	Tue, 15 Sep 2026 21:15:43 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C5E154048B;
	Tue, 15 Sep 2026 21:26:41 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 15 Sep 2026 21:26:41 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 1/3] net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data
Date: Tue, 15 Sep 2026 21:24:32 +0800
Message-ID: <20260915132434.1141742-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915132434.1141742-1-shaojijie@huawei.com>
References: <20260915132434.1141742-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

