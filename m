Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6153F6C21;
	Fri,  7 Aug 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096509; cv=none; b=NwrWKM9D7YgnmqmvXcJYSd6R1BDKloedoxcOyMHRnHfRcUxSETuDYe0ldXm19ac+MCHOE46W0epcUJqEN4abKYEMwe4QUL8bodazCQEXjz9SLcVqfbj7KK/fVvcRbzzKr8yzIarOTBL6c92MyHD/TfzFbKHuw4RxRWL5ktzFySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096509; c=relaxed/simple;
	bh=Yp7Gql3Z4eZVk1KGaP8S0bv+Z80EHQo7rMzpnKohQrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udO3ukRzlHPAIv9PnS/4ZLMwKulwBKYJfy4Zbo3Ssrej+7R7lnenPvppPzuBDGQpWUZlOb8a7TpRFa3j4WSaUnRhe/PjBsdAjgOoSeW2fusO66GvgXrluq0nxXVgrmmUIr8AxQv0XWf3hnhK2/33559rVcHUy991RsmwRTqLGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uM9LnmJ6; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uM9LnmJ6"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q06cRr8Qj+2tDNsNLIuurUn3/bkoAcG2p2ERpvKWfFU=;
	b=uM9LnmJ6TKbBoNMOIzLya+BskVr/U++gLHYKgTsmKB222N4Z0gmGCZOfE3cTSDhgsJsWIWKFf
	EBPnlLENNt+Gy2B1aU6Dlo38nrO5xzjuPM6ngf51zCGlR4TLDUfoU/Q/HQV+BpVazaRTxKzACqd
	CRDK5eyc8uHhFTwR75o2GgE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hGfPT5bFTzRhVP;
	Fri,  7 Aug 2026 17:44:29 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B72120333;
	Fri,  7 Aug 2026 17:55:02 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 17:55:01 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 1/3] net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
Date: Fri, 7 Aug 2026 17:54:33 +0800
Message-ID: <20260807095435.2959246-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260807095435.2959246-1-shaojijie@huawei.com>
References: <20260807095435.2959246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

From: Jian Shen <shenjian15@huawei.com>

In hclge_query_reg_info(), msg->desc is freed by kfree(), but the
caller continues to use msg across loop iterations. Set msg->desc
to NULL to avoid leaving a dangling pointer in the reused struct.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index dac051e798da..7e124e2c718d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1592,6 +1592,7 @@ hclge_query_reg_info(struct hclge_dev *hdev,
 	}
 
 	kfree(msg->desc);
+	msg->desc = NULL;
 }
 
 static void hclge_query_reg_info_of_ssu(struct hclge_dev *hdev)
-- 
2.33.0

