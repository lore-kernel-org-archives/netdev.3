Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D823DBD6B;
	Tue, 31 Mar 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943817; cv=none; b=BK+tZR3dX5W0Q5zphqYOdNHcy6P0WICMUqoT7KMOWCjuQlDzbm9loUkBT39SSthVdzxGBTio/IUMgUFjpRyoJgurEv3Dt2K9UTY63bhUpTZw9YoB8bLZcVmiW5FTGQMRod+kjtEl6Ru5PwXjIJel317ioh68eHs6uAgV47lrOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943817; c=relaxed/simple;
	bh=GHm4Tkq/jR7F1cxZivfMJHrrf7Co+SAMDPUjCIOfEFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5iwIchojYKT5WbG4cpXfXxBfmVMN2KRg+JR/GS1W+7uCCpwaYpALcSNe0b4gWg2fGTZHOmXf1nfkoNE8FcmJbyEKzFReSrFgIexXV4vZY47fZ1eqAoXpGlwR58eaSogLdNtVJENnI5Gzvcpv3ZEkELMSN5VX4IbO4W0ukWjLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6i7myuC9; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6i7myuC9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NnYaVZum+bxrIlqVzYb/4Mb17ttO7H1xxO1BG4kn4W8=;
	b=6i7myuC9ku565MOt7YC/6eD8l6vZ38CHsrH69i4cMWz8u/WtkMxODTYgylx0KAIy10YrOSpLt
	+YemB9Z2r3IKzZ5JHchRT9RrWEqN6x80rPwZglBU7sDlJf5/Ox57uyMjP4jbWPea8hpd9B6muaY
	r9zLG9LuBjSB9zjqSdC7qAo=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4flL0W2KnFznTXc;
	Tue, 31 Mar 2026 15:51:23 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 89BA940565;
	Tue, 31 Mar 2026 15:56:47 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 31 Mar 2026 15:56:46 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v03 6/6] hinic3: Remove unneeded coalesce parameters
Date: Tue, 31 Mar 2026 15:56:25 +0800
Message-ID: <9999532202386c143af05341928de9345d35d94e.1774940117.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1774940117.git.zhuyikai1@h-partners.com>
References: <cover.1774940117.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

  Remove unneeded coalesce parameters in irq handling.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c | 6 +-----
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h  | 3 ---
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index d3b3927b5408..42464c007174 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -156,13 +156,9 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
 
 	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
-	if (err) {
+	if (err)
 		netdev_err(netdev,
 			   "Failed to modify moderation for Queue: %u\n", q_id);
-	} else {
-		nic_dev->rxqs[q_id].last_coalesc_timer_cfg = coalesc_timer_cfg;
-		nic_dev->rxqs[q_id].last_pending_limit = pending_limit;
-	}
 
 	return err;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index cd2dcaab6cf7..a64a51d766c5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -112,9 +112,6 @@ struct hinic3_rxq {
 	dma_addr_t             cqe_start_paddr;
 
 	struct dim             dim;
-
-	u8                     last_coalesc_timer_cfg;
-	u8                     last_pending_limit;
 } ____cacheline_aligned;
 
 struct hinic3_dyna_rxq_res {
-- 
2.43.0

