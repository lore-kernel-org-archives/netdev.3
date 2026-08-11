Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF03FAE11;
	Tue, 11 Aug 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432121; cv=none; b=ouo+FilnneDj273qEtCTjfJpY7SGWXNl0KGH94TxzJzHLaolug0v1+daeJPst0u/rOSQUf53EybKF2dpr2mTiodUvtOf9T4V+JfsqSw/37dXEH2neLGj189emnl/r4SN9UyMe+cQxENdKjoMJ0IdEaA7LHwm/lY7DMf4YwHM8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432121; c=relaxed/simple;
	bh=kcQzEZTJnAkfGVMO5MjdqSzrpE+Lj72RA0XeoXgI6fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9wSf85cpVBDSLfvq41yC1daG9EpLwFIKpZeAGQSOJzCr1JCvsm0TxtvXj2w0vd57lyJ5v49Mn+gHVejgN6JzBwnqdaHWreD0ogC2YVnDl/NVG1H+MMvPKYno+X5MloeruqFYVMqr6wihPNw8q2KgLqjOCP6oStfUe++MEMb/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Y8gx5QRG; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Y8gx5QRG"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 498977a31;
	Tue, 11 Aug 2026 15:08:19 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] net: ibm: emac: mal: fix NAPI locking
Date: Tue, 11 Aug 2026 15:08:13 +0800
Message-Id: <20260811070813.377573-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fefa6961803a1kunma22632a1d4ed9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGB8fVkNIHkhOGkpCGUlIGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Y8gx5QRGwSyq9jgUSpAFLBCU90Un6AH8jyI6yKvEFGaFirjFV1WWxsMfVMWMIQBdT+HntlU8dx+pYJvAp2ttv9HBfhiHhH4jA5wTcxsqpam73rQsQnFROfh2fiwytO3xGiPFzcr4UefQYW5nK/QXflCy5zZc9ftwNqI0FWGb4kM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=IqQG0t5DuOQ1WwpUNL6EWMUEvEH3+/DK1waeHywCPHQ=;
	h=date:mime-version:subject:message-id:from;

Since commit 413f0271f396 ("net: protect NAPI enablement with
netdev_lock()"), napi_enable() and napi_disable() take netdev_lock().

mal_register_commac() and mal_unregister_commac() call these helpers
while holding mal->lock with interrupts disabled. In the unregister
path, napi_disable() may also wait for polling to finish, while the poll
completion path takes mal->lock.

Take netdev_lock() before mal->lock, use the locked NAPI helpers, and
drop mal->lock before napi_disable_locked().

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/ibm/emac/mal.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 74526002d52b..42027665f2a9 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -34,6 +34,7 @@ int mal_register_commac(struct mal_instance *mal, struct mal_commac *commac)
 {
 	unsigned long flags;
 
+	netdev_lock(mal->napi.dev);
 	spin_lock_irqsave(&mal->lock, flags);
 
 	MAL_DBG(mal, "reg(%08x, %08x)" NL,
@@ -43,7 +44,8 @@ int mal_register_commac(struct mal_instance *mal, struct mal_commac *commac)
 	/* Don't let multiple commacs claim the same channel(s) */
 	if ((mal->tx_chan_mask & commac->tx_chan_mask) ||
 	    (mal->rx_chan_mask & commac->rx_chan_mask)) {
 		spin_unlock_irqrestore(&mal->lock, flags);
+		netdev_unlock(mal->napi.dev);
 		printk(KERN_WARNING "mal%d: COMMAC channels conflict!\n",
 		       mal->index);
 		return -EBUSY;
@@ -51,11 +52,12 @@ int mal_register_commac(struct mal_instance *mal, struct mal_commac *commac)
 
 	if (list_empty(&mal->list))
-		napi_enable(&mal->napi);
+		napi_enable_locked(&mal->napi);
 	mal->tx_chan_mask |= commac->tx_chan_mask;
 	mal->rx_chan_mask |= commac->rx_chan_mask;
 	list_add(&commac->list, &mal->list);
 
 	spin_unlock_irqrestore(&mal->lock, flags);
+	netdev_unlock(mal->napi.dev);
 
 	return 0;
 }
@@ -64,7 +66,9 @@ void mal_unregister_commac(struct mal_instance	*mal,
 		struct mal_commac *commac)
 {
 	unsigned long flags;
+	bool disable_napi;
 
+	netdev_lock(mal->napi.dev);
 	spin_lock_irqsave(&mal->lock, flags);
 
 	MAL_DBG(mal, "unreg(%08x, %08x)" NL,
@@ -73,10 +79,12 @@ void mal_unregister_commac(struct mal_instance	*mal,
 	mal->tx_chan_mask &= ~commac->tx_chan_mask;
 	mal->rx_chan_mask &= ~commac->rx_chan_mask;
 	list_del_init(&commac->list);
-	if (list_empty(&mal->list))
-		napi_disable(&mal->napi);
+	disable_napi = list_empty(&mal->list);
 
 	spin_unlock_irqrestore(&mal->lock, flags);
+	if (disable_napi)
+		napi_disable_locked(&mal->napi);
+	netdev_unlock(mal->napi.dev);
 }
 
 int mal_set_rcbs(struct mal_instance *mal, int channel, unsigned long size)
-- 
2.34.1
