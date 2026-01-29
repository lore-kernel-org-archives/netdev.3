Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CC293C4E;
	Thu, 29 Jan 2026 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769659296; cv=none; b=bv1H/3hP4JR5/t5kbxOWlbNn6zJfG0Er1tM3XhcgqV5d7pOIrIGjDmd4o8pJVvrpGWigeVs4dauozwKyD6Ca9nG52NL8pjZ5jQEkt7hEdCZx0vVoMcedTM1WueHyaDfqkVL4tsx41nwlviL7faR9udNBj7fRHUSYmGA4dga6x5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769659296; c=relaxed/simple;
	bh=UKr6hUIN8lEhbTpowr90NC6/IYy5O2qLuzxD7VvO16w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCnx6aUC9d8TzPcqCcLwCKzB3P7+erIs9N4GNRKOVhbwtVq4wZMz/sLOF007NA6XlS3uybBXmnIP9RD/IfrNiOwtoIITkq3J6bkdI5Wi9OuyakzDQ3cAOfzx9AVHBB6CKsmGUWOxjTjYlLezbHYUi+ZT4R6xuoPtkXpnOBoyjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uspDWEAa; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uspDWEAa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WTmurGlQCMkCkWDcKq8Td0eQuXfFJHK3iydsOHwlq3E=;
	b=uspDWEAapNM0peGZe1Ks2sXOV5CeHQTUXiYaF+I2e8mrXw4bJV6H7Y+dmCNcEEzL21x7wivMC
	706qs7uJ1rMfUfD3coFXjoxHnvRstbuWHiaphnUGaTYSF6oB0bl6D88MhNun5wCKBv1AP1+r6ch
	PndnLR32e3amlttLKhxeSU4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4f1ljF5FDGz1cyv1;
	Thu, 29 Jan 2026 11:57:53 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id AAE6640565;
	Thu, 29 Jan 2026 12:01:21 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 29 Jan 2026 12:01:20 +0800
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
Subject: [PATCH net-next v03 2/4] hinic3: Remove defensive txq_num check
Date: Thu, 29 Jan 2026 12:01:09 +0800
Message-ID: <c23daa9b79fa731c1caaec9b8245f6b2c4994afb.1769656467.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1769656467.git.zhuyikai1@h-partners.com>
References: <cover.1769656467.git.zhuyikai1@h-partners.com>
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

Since commit 1f3838b84a63 ("hinic3: Add Rss function") nic_dev->num_txqs
cannot be zero in hinic3_alloc_txqs(). So remove the check for this case.

Link: https://lore.kernel.org/netdev/20250902180843.5ba05bf2@kernel.org/
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 4e361c9bd043..6d3dc930ca97 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -44,16 +44,10 @@ static void hinic3_txq_stats_init(struct hinic3_txq *txq)
 int hinic3_alloc_txqs(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
 	u16 q_id, num_txqs = nic_dev->max_qps;
 	struct pci_dev *pdev = nic_dev->pdev;
 	struct hinic3_txq *txq;
 
-	if (!num_txqs) {
-		dev_err(hwdev->dev, "Cannot allocate zero size txqs\n");
-		return -EINVAL;
-	}
-
 	nic_dev->txqs = kcalloc(num_txqs, sizeof(*nic_dev->txqs),  GFP_KERNEL);
 	if (!nic_dev->txqs)
 		return -ENOMEM;
-- 
2.43.0

