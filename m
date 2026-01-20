Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C642E000;
	Tue, 20 Jan 2026 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912747; cv=none; b=p+ejKaVRXJBZud0zwY8HG73Ahc1qi23fl62Vurjj52ZEFjKkjKsiEli69Q7mVan+Y7GysiwPRpZXudW6vu2xZo4accgTHSslju8yLPxQaZdGS0ykM9cwU7Z3GC59kBmaXqDvaiuolpTCQNsu+LGxJ84jJXXCM05fPr2149KJ5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912747; c=relaxed/simple;
	bh=EABVssCM123G7jWb1K2EzG7DAOvkk0hnvjBy1LCXY/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ77ZIXHpt1d+LCJZo/nzRPLdkue0HWYR5iDs9sEoEZJ4qFmmDKH0HRo3kXhptfvzgsDPA1hx41nye6JY2uRIOwmgDk62I0QgZ26/q++Ca6+kkNKXOJBip9W7LUu83JmBJCVdPP/+irK/XFmxf8JoLHKfUo9xy4bScyflsiqRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pFH6JFXL; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pFH6JFXL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RyoonJga84J5TYM1qUcca+lnnVeYd8lqRPR77Y61Dr4=;
	b=pFH6JFXLbQyoXthbYVtnz8XH05nCtt8/a74b8NqgOmA90cMyIz71b1r684czZpqvGBTqii1gw
	EwJT6JaTFJUWUDxgaSf1e1NybnJQos/F8513ZI0oGkqz2qtv4KwI2v6VtbBasEwh68HEcD/2BUk
	07caBsoVuxLI1MLC5DEUvhk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dwRcj6GlTzmV6J;
	Tue, 20 Jan 2026 20:35:33 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id BE1414055B;
	Tue, 20 Jan 2026 20:38:57 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 20:38:56 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net v01 4/5] hinic3: Use array_size instead of multiplying
Date: Tue, 20 Jan 2026 20:38:42 +0800
Message-ID: <18c4b650ed9d18d1163c0755bb375364362e8ffa.1768911232.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1768911232.git.zhuyikai1@h-partners.com>
References: <cover.1768911232.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

According to comment of patch 03, check codes that were merged and
use array_size instead of multiplying.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index b6cc7bb7bb0c..44abccf9cb29 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -23,7 +23,8 @@ static int hinic3_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode,
 	feature_nego.func_id = hinic3_global_func_id(hwdev);
 	feature_nego.opcode = opcode;
 	if (opcode == MGMT_MSG_CMD_OP_SET)
-		memcpy(feature_nego.s_feature, s_feature, size * sizeof(u64));
+		memcpy(feature_nego.s_feature, s_feature,
+		       array_size(size, sizeof(u64)));
 
 	mgmt_msg_params_init_default(&msg_params, &feature_nego,
 				     sizeof(feature_nego));
@@ -37,7 +38,8 @@ static int hinic3_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode,
 	}
 
 	if (opcode == MGMT_MSG_CMD_OP_GET)
-		memcpy(s_feature, feature_nego.s_feature, size * sizeof(u64));
+		memcpy(s_feature, feature_nego.s_feature,
+		       array_size(size, sizeof(u64)));
 
 	return 0;
 }
-- 
2.43.0

