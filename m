Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25C352031;
	Tue,  4 Aug 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848988; cv=none; b=Dz8rmktnxxtps8cAMv5P7zQekWCNQ3ZXf//5gAMWrM5aEbeT1c8/m/s8z5ouaIHvEjXIlMdJELCmQ9nF7xaMNSXCMGK0ZTiLmpE2U/fC05LCiURfs1t3u3YsJh3E9hxuARLc5feF4iiEy7+CkPc4bI50zBJ4sVdo9R4nnNttQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848988; c=relaxed/simple;
	bh=VNQ3NJKZLD8BZGtDPfpTGdiSTg82c8JEYjYmw406c5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1qZ1J1tVPa6Zc9dU4muEthqNGhQwNyh0mFUjWNlyeCFBtLA1DduKSqZLkJsnXBdjaZ8OjbEgN1HzQ8OcVzEX0tiVj9PDoDocJ+amFLCBvVKbF0pERK2MvACxYXVnsGX1qFT0KCvjYRfP3ATj3DZmvqOL7bi1Fa0o2RoxUWq8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I4EFqBMK; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I4EFqBMK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dG0f8ZeCwJFVnWeho7B6cSGeSNK1TnJBVUhGvvT+9Po=;
	b=I4EFqBMKGuFBgOQney73Hd3rZ3sCUtvLifQN9F1OmAj3Cc+V+XJ4/cnlnhCopeRTP8NlW8Lc1
	YVQD7xgs5qOV1dwEgpF0IOhhbbfcsFRfbm3WXJyUshkjnbMNzfsGK6QUa4SVqi+6vbGtP+VTr+i
	nlhyvHoB+tWd3Ofj1cnDVPw=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hDttd0LyJzLlTm;
	Tue,  4 Aug 2026 21:00:09 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D7E454056C;
	Tue,  4 Aug 2026 21:09:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 21:09:39 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 1/3] net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
Date: Tue, 4 Aug 2026 21:09:31 +0800
Message-ID: <20260804130933.880552-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804130933.880552-1-shaojijie@huawei.com>
References: <20260804130933.880552-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)

From: Jian Shen <shenjian15@huawei.com>

In hclge_query_reg_info(), msg->desc is freed by kfree(), but the
caller continues to use msg across loop iterations. Set msg->desc
to NULL to avoid leaving a dangling pointer in the reused struct.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
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
2.43.0

