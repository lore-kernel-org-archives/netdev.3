Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B553CE088;
	Wed, 27 May 2026 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868590; cv=none; b=CLSNCXlqEx9Ko1RNNYS1bR/42kiF7Qtk8dopelnsUEzQq7qWFiCTa7dXzcpcNdxEnJp5ihq11cEx+rXdt+4II4rv6GR0RpDj65lgNM48j3IFJJGKkx4SEUyi2bKagyQYW0vcz07xZj45H+DP56Z6mO9TDY8t/xa8JNFPcnltwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868590; c=relaxed/simple;
	bh=VE/Uvxdg8FIwvx0f/2zMHUwgBpRKzFjfxBzOtBOVQAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzuBCYv6V2eBn0uFyhPtEYE6YwpCT9NdxVSOLC+lHwbm9iJnNONSuns1teCa1F4TioX232Cfv7WM1ImBrK8++GBNBUEbRIp/ViIwkcmXfL+I2AEnG+hruFCf0mtghA8xE1y31+/qXMqF/0f3jT4fsnw1bz5nzw7pEufBliNHLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bI9vXmGV; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bI9vXmGV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C81T0rToaJN6ExYp0e3pyEuR4fh2BEpwPsJlpuc/7PM=;
	b=bI9vXmGVv28Gf7/iVuyWUYGioKWXkOOW0MYcrdGhJbyGacXNnhazDG2pGwLcyKcZbIQ8lFJ3c
	fhimCgLLK3xmYqktytMO2d9auFMEkpDFvpwRpFRU/3V5O8sunV9CbesPlHPJ0Pt/FYzTgdQpP0v
	1gFFOOQ2oYLon8GqrszW38w=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gQMDh4WFLz12LJp;
	Wed, 27 May 2026 15:48:20 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 629FD40561;
	Wed, 27 May 2026 15:56:20 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 27 May 2026 15:56:19 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v06 6/6] hinic3: Remove unneeded coalesce parameters
Date: Wed, 27 May 2026 15:56:01 +0800
Message-ID: <9612cdb3f27a7e67fadc5119e0683995f3c3e613.1779867397.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1779867397.git.zhuyikai1@h-partners.com>
References: <cover.1779867397.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
index cc43773c1984..97dd2a029703 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -149,13 +149,9 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 		nic_dev->intr_coalesce[q_id].resend_timer_cfg;
 
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
index c11d080408a7..2ab691ed11a9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -111,9 +111,6 @@ struct hinic3_rxq {
 	dma_addr_t             cqe_start_paddr;
 
 	struct dim             dim;
-
-	u8                     last_coalesc_timer_cfg;
-	u8                     last_pending_limit;
 } ____cacheline_aligned;
 
 struct hinic3_dyna_rxq_res {
-- 
2.43.0

