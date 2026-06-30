Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40663769FF
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802553; cv=none; b=Si+/+9oZa8yIzxMmwCJDq+ZUFg66P0MYfclGMuabUjtM1Dtn6eRiJzEC9qQMrhXcJw/0YDcxusilm3WxNYYaDrcOZAogD3f7K91q/7g0OXs9aTWWQRrOCOlT5D3nqIGUONpRo0iz58q+p6IxL0qp9G0h+Npnfy+Oy7iDnHtAKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802553; c=relaxed/simple;
	bh=RzuoUUZ6tYzgPoyMYxyxx8mWj6eTajWQBCMtPu4AUYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fNP8flaChJeREUGXj02gcioD9dPwsCh/J3/b8hQwDQds7LV5p+XMPqSpIDHwl+XGU7qdOJe7w6qVlLFjD+6UjFxOAOY59qqlrxoC3fMtOmnq3ByJRoz0JvXgB3xn4AGVqz1PhXfB3UrMhwwYYOVfiPSSs1swLiy2bjuIWdkYnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HvmidflY; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HvmidflY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iN
	CHxb/XEYBf2o87FGPSKIto5KYs578bW7m8tmP/sPA=; b=HvmidflYU60hros/tV
	1oH0H4n1UVOmwWJB6IIvVmXSQgv0WbFCcj0aNGo7+03cw7tqyy1CMLKcEjFpzdx2
	T80RmY0QOmOIzdmbp2MVBpo0+8iQM4TvEv5x5L3y3McEJTF87wcc089+5E7KkVNJ
	k+GUeMSc7EewVwyg2uHaqmCaI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBX1PJBaENq4+DbEQ--.36962S2;
	Tue, 30 Jun 2026 14:54:59 +0800 (CST)
From: Lei Zhu <zhulei_szu@163.com>
To: brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	zhulei_szu@163.com
Subject: [PATCH net-next v2] ionic: Change list definition method
Date: Tue, 30 Jun 2026 14:54:57 +0800
Message-Id: <20260630065457.160081-1-zhulei_szu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBX1PJBaENq4+DbEQ--.36962S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr15tw1UXr4UArWkKrWUtwb_yoW8Xr1Upr
	W5Ja48Xw47Xr4UW3Wktr4xZFZ5Xa48ZrWDur1qk3yrWrn7tF4xAa1jqFW5J3WkXrW8G3WS
	qr9F9an8AF1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEAhLUUUUUU=
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbC7wOV4mpDaEOfXQAA3b

From: Lei Zhu <zhulei@kylinos.cn>

The LIST_HEAD macro can both define a linked list and initialize
it in one step. To simplify code, we replace the separate operations
of linked list definition and manual initialization with the LIST_HEAD
macro.

Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
---
Changes in v2:
  - Order the variable declaration lines longest to shortest

 drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
index 528114877677..c999754afb5f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
@@ -558,18 +558,15 @@ struct sync_item {
 void ionic_rx_filter_sync(struct ionic_lif *lif)
 {
 	struct device *dev = lif->ionic->dev;
-	struct list_head sync_add_list;
-	struct list_head sync_del_list;
 	struct sync_item *sync_item;
 	struct ionic_rx_filter *f;
+	LIST_HEAD(sync_add_list);
+	LIST_HEAD(sync_del_list);
 	struct hlist_head *head;
 	struct hlist_node *tmp;
 	struct sync_item *spos;
 	unsigned int i;
 
-	INIT_LIST_HEAD(&sync_add_list);
-	INIT_LIST_HEAD(&sync_del_list);
-
 	clear_bit(IONIC_LIF_F_FILTER_SYNC_NEEDED, lif->state);
 
 	/* Copy the filters to be added and deleted
-- 
2.25.1

