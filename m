Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB83D7D75
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509358; cv=none; b=mqnk0e95RQrcUMifiEWPA+BzwjGwC9LoXWNSF8PvwqWOZxl/8grTUTfXYuqC/NqJlLfOWJvZmMH6uYto0CcjUQqv84WQat19H3JKcDf3ryh1wQZpIAjWels0nExGUphE3PXzpF7XR23HmGMJYp0huh/83TnDkrjIq/xztRI+feI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509358; c=relaxed/simple;
	bh=pE7cN1GvzbE2y4nwVf6pbJQ5LYB0P93SIyPfPfCW1Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TLc8UhUjdXO3GoyvDAk7bWQ4hpqENxl3Pul1QCHX/qJxSQsdzyprK1AjHHY4XGy61jn2qo1InwTxL7hcv/MDKMjePrtM3cGTOISZFZuqhE74SJ5/p9u9QYDqDrrxBpdHx5auHxbgCrf/H16f0RINbJm6xwYsUr68SMUVNoCEQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NMKb0u7u; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NMKb0u7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MO
	4pXFcedS4dIGPS5osjZgGZ/rrJKJyCM5L1ro6VuTQ=; b=NMKb0u7uyy3F22NI3E
	aiY6QZGK/jVPlW/3ITEC3qYdLhsgfyTtX31/7Z7KNBsyPJrM4taXLSRN0JDKvnGX
	r3GGj6WwnUGf0rufp8D3fY6JhBYUTFq8oUHiX1XXw5Vz0hhRAK13kR8jXDyKhS7o
	9WXMNQZou0RTrvdcjAOMRMhgY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB37GlgfJpqs61iAg--.12312S2;
	Fri, 04 Sep 2026 16:08:01 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH] net: sun4i-emac: fix missing of_node_put() for phy_node
Date: Fri,  4 Sep 2026 16:07:58 +0800
Message-Id: <20260904080758.2432748-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB37GlgfJpqs61iAg--.12312S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1Dury3uw4fXFyUKF4rZrb_yoWkJrc_Cr
	48ur93GFWkCrnYyw4Y9r45Zr4UAFyqgFZIqF1v9FWay34qvr43XrnY9rn3Kr9rXrW8KFn8
	GwnF9Fy3Aw1F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbVHq3UUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+QJ4J2qafGKJQQAA3C

From: Li Youhong <liyouhong@kylinos.cn>

of_parse_phandle() returns a node pointer with an elevated refcount.
Add the missing of_node_put() on the probe error path after
register_netdev() fails and in emac_remove().

Fixes: 492205050d77 ("net: Add EMAC ethernet driver found on Allwinner A10 SoC's")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -1067,6 +1067,7 @@ static int emac_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_sram:
+	of_node_put(db->phy_node);
 	sunxi_sram_release(&pdev->dev);
 out_clk_disable_unprepare:
 	clk_disable_unprepare(db->clk);
@@ -1094,6 +1095,7 @@ static void emac_remove(struct platform_device *pdev)
 	}
 
 	unregister_netdev(ndev);
+	of_node_put(db->phy_node);
 	sunxi_sram_release(&pdev->dev);
 	clk_disable_unprepare(db->clk);
 	irq_dispose_mapping(ndev->irq);
-- 
2.25.1

