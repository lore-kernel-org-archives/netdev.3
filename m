Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC034CDDC2;
	Mon, 28 Sep 2026 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602906; cv=none; b=PLFOqaz3yQvao7xxdwbvQjhaS6PpO/LlpTLd9K/tGc207ZTOPllejvAcSaWuD24MXVzRkWCL+WyMw/5M1+Vy2fMnoS+qXPIT+mUz4muwEuzRTGyBhsMoecQKg20Uj1pEDGFyv4lJVbu38zF/j7phbmjm43HoLWScUT6w+0/Hst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602906; c=relaxed/simple;
	bh=/2iOoMYsPzA3Df+V55vppw7WLTnw2r0wtg5wlEM0nak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Egf4KwUwg5cKSp2CA8IIizyCWN6ClhVXn635RRbREjBTKgedg6OiTcezq64Hia38MCrbwu+/89ytDsR3zAwJ7U+19sJqrunKailOowiBKg6I8/ZwP33GKiR21vHx9KvcR3+4ktD2pVfvLSX3IYQavwYFnrXY/4g+xaI3HVtMMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=VXl1gbDC; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="VXl1gbDC"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f5d6f437;
	Mon, 28 Sep 2026 21:41:37 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net
Cc: edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH net] net: plip: quiesce private work when stopping the interface
Date: Mon, 28 Sep 2026 21:41:36 +0800
Message-ID: <20260928134136.1213-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e83fe45403a1kunmbd8064332001ea
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUkZVkgeH0ofHhpDS05DGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
	hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=VXl1gbDCpeIXAF2V0WHdoY754UKTpK0x4DHZWjDi/09Rn6Q3fPBqOrlhrr8GNNWBJMPon9cvOvmbFt8r7w1WTn61hDPD3vfwZC4fgqaiEowPeYYvbKuZEjVH007TiD4OOZiOPVyDbu5+FjRbA28pM9D08xGKRXmOUdmYeXQlZBw=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=5bNsCuX0zSXm1psUbgNeXdk1Glg+yrCcYxUbte1h7ns=;
	h=date:mime-version:subject:message-id:from;

PLIP interrupt, transmit, and work paths schedule the immediate and
deferred work items embedded in netdev private state. plip_close() stops
IRQ or polling publication, but it releases the parport and pending skbs
without draining those work items first. A callback can therefore continue
using resources released by an ordinary interface close or device teardown.

Initialize both work items disabled. On open, reset protocol state before
enabling the work and its IRQ or polling publishers. On close, stop those
publishers and then disable and drain the work before releasing resources.
The balanced enable and disable operations support later interface reopen.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/net/plip/plip.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index d81163bc910a..97bbac0b95da 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -308,6 +308,8 @@ plip_init_netdev(struct net_device *dev)
 	/* Initialize task queue structures */
 	INIT_WORK(&nl->immediate, plip_bh);
 	INIT_DELAYED_WORK(&nl->deferred, plip_kick_bh);
+	disable_work(&nl->immediate);
+	disable_delayed_work(&nl->deferred);
 
 	if (dev->irq == -1)
 		INIT_DELAYED_WORK(&nl->timer, plip_timer_bh);
@@ -1077,6 +1079,17 @@ plip_open(struct net_device *dev)
 
 	nl->should_relinquish = 0;
 
+	/* Initialize the state machine. */
+	nl->rcv_data.state = PLIP_PK_DONE;
+	nl->snd_data.state = PLIP_PK_DONE;
+	nl->rcv_data.skb = NULL;
+	nl->snd_data.skb = NULL;
+	nl->connection = PLIP_CN_NONE;
+	nl->is_deferred = 0;
+
+	enable_work(&nl->immediate);
+	enable_work(&nl->deferred.work);
+
 	/* Clear the data port. */
 	write_data (dev, 0x00);
 
@@ -1088,12 +1101,6 @@ plip_open(struct net_device *dev)
 		schedule_delayed_work(&nl->timer, 1);
 	}
 
-	/* Initialize the state machine. */
-	nl->rcv_data.state = nl->snd_data.state = PLIP_PK_DONE;
-	nl->rcv_data.skb = nl->snd_data.skb = NULL;
-	nl->connection = PLIP_CN_NONE;
-	nl->is_deferred = 0;
-
 	/* Fill in the MAC-level header.
 	   We used to abuse dev->broadcast to store the point-to-point
 	   MAC address, but we no longer do it. Instead, we fetch the
@@ -1141,6 +1148,9 @@ plip_close(struct net_device *dev)
 		wait_for_completion(&nl->killed_timer_cmp);
 	}
 
+	disable_work_sync(&nl->immediate);
+	disable_delayed_work_sync(&nl->deferred);
+
 #ifdef NOTDEF
 	outb(0x00, PAR_DATA(dev));
 #endif
-- 
2.50.1.windows.1

