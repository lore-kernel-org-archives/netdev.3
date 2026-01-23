Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141130F812;
	Fri, 23 Jan 2026 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151448; cv=none; b=UVpFrdX007s+d5WqYG+rBInjpg81+QCA//go/p36VIAE9pSD2askj+Fs4dPwhpw5hyhLcyzG73og3wwo4epRjsajX3fkNTVvkRjEXO3hOCPpm0YW6r73ptgWGRNVgYofXTma5N5W0AnQWb2a8D9ZjneMkUtPLOzWgwtcFAVAT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151448; c=relaxed/simple;
	bh=d6tVuQB9kxWWABGsFkTqtufONnZXyqU6rQB2WgIfPf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WLvyiyPBSqflom7MuLKx4ne8C2YulSACaPoCuDzuRlvzomiUvjuqszAxhNz7kTntD0ZcSv066bRDINxtd9HqUHjjd+X+XffqBcJHYQUqS6+1uAkByt7bkSnLaAMMXCDcAIZr+KK/NO0XVAwz3F7+56t78NDUwmqPnQmgCpd9CDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=S7kLzLRR; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="S7kLzLRR"
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31b470a2f;
	Fri, 23 Jan 2026 14:57:20 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: marcin.s.wojtas@gmail.com
Cc: linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v2] net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()
Date: Fri, 23 Jan 2026 06:57:16 +0000
Message-Id: <20260123065716.2248324-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be9a4a35903a1kunmd3d2fb92681de
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0tIVk4YSxoaHhpMQhhNGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=S7kLzLRR5KlPhJVnmGiOHAb6agq/65IlHxLqqKIrc8NXecX8NFf6BNkHvKWGumokqUwCktuaZqLblbBHKYApoNv3ymYaWQGHtTf7jwaAqfvrC5i7m/+0kvJxVpXuJBB9XozO6se69DaOxTtbVU++bVyUYzPeMs8M3sr+oJawWKE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=lQ2Fr8sNf6vuSAhrEgQCKZgVL2bhPTFJxxQvht9W+2Q=;
	h=date:mime-version:subject:message-id:from;

In mvpp2_ethtool_cls_rule_ins(), the ethtool_rule is allocated by
ethtool_rx_flow_rule_create(). If the subsequent conversion to flow
type fails, the function jumps to the clean_rule label.

However, the clean_rule label only frees efs, skipping the cleanup
of ethtool_rule, which leads to a memory leak.

Fix this by jumping to the clean_eth_rule label, which properly calls
ethtool_rx_flow_rule_destroy() before freeing efs.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: f4f1ba18195d ("net: mvpp2: cls: Report an error for unsupported flow types")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Cc the author of the commit under Fixes.

 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 44b201817d94..c116da7d7f18 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1389,7 +1389,7 @@ int mvpp2_ethtool_cls_rule_ins(struct mvpp2_port *port,
 	efs->rule.flow_type = mvpp2_cls_ethtool_flow_to_type(info->fs.flow_type);
 	if (efs->rule.flow_type < 0) {
 		ret = efs->rule.flow_type;
-		goto clean_rule;
+		goto clean_eth_rule;
 	}
 
 	ret = mvpp2_cls_rfs_parse_rule(&efs->rule);
-- 
2.34.1

