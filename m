Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FB368D66;
	Mon, 14 Sep 2026 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372585; cv=none; b=njyP4W3EykttAdGkFyd1h36Hq7Mnb8iGFxmeUvU55Qjvbz9ACVKyajREMnCLeNJJENIb0Hk6W0coJ3vISOsvSnKgxiE7DkzAaJzF5cQL7nF+0lhwQmJ58jeq3117DIlP2xWlt5VII4ydvoR/H/AsGnLBVA6cOnKOgjCodDM/+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372585; c=relaxed/simple;
	bh=m6KeYkp/2qyk9kllJdtAY8e4X2o8u/ogoxZk79ngweY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Isj711f6weXr+j0ZDVC6XvQDH+LqUA/l1S//2rSWn8Tfg9a4PqMTGWs2fZQWiUhl4B2z78i1nwaGXnduBNKMplPk0is2qLpOcKGZkNKUwb2rgH00O0JDleLSLdU6NQBca9xLAUsfwKw77300fb2HkJGe4Xax7S0MdV1aOXskPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=FFC9RJne; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="FFC9RJne"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4da815583;
	Mon, 14 Sep 2026 15:56:10 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	den@openvz.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net] net: neighbour: Serialize proxy timer teardown
Date: Mon, 14 Sep 2026 15:56:04 +0800
Message-Id: <20260914075604.120183-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09eea9bbf03a1kunm9151719e282acb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSEkZVk4eSk1OHkoZSUxKTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FFC9RJneWQ9aTDio8XR53ctdVNFehevkrHcIPUCPFHZ/eIJLUhzIdoQZl7tMl2+TeWMs/XP/gEy5lpuMeZp2pVurR1QYN7lvsJRw2C9jy/4WSGeo6TTGU+RYkl7h/bVwWKdfG43gu9XyKIzerGnKkerYFYsUX9aXObKfkJSGewU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=m6qSJMOGZomrlhHkDs2SzUtJH/3UxLmtfyenGSbF3Gk=;
	h=date:mime-version:subject:message-id:from;

__neigh_ifdown() purges device-specific entries and then checks
whether the shared proxy queue is empty before deleting proxy_timer. A
concurrent ARP or NDISC request can enqueue a delayed proxy response
between the check and timer_delete_sync(). The timer deletion can then
leave the new skb queued without a timer to process it.

Serialize proxy queue insertion and timer rearming with the purge, empty
check, and timer deletion. The timer callback does not take the new lock,
so timer_delete_sync() can still wait for an in-flight callback. Keep
timer_delete_sync() rather than timer_shutdown_sync(), since the timer is
reused after per-device and carrier teardown.

A controlled QEMU test with explicit 5 ms schedule injection reproduced
the orphaned queue state on the unfixed kernel and did not reproduce it
with this change. Natural-load runs reached both paths but did not
trigger the narrow race.

Fixes: 66ba215cb513 ("neigh: fix possible DoS due to net iface start/stop loop")
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 include/net/neighbour.h | 2 ++
 net/core/neighbour.c    | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 8860cc2175fc1..15107c00b4df4 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -239,6 +239,8 @@ struct neigh_table {
 	struct list_head	gc_list;
 	struct list_head	managed_list;
 	spinlock_t		lock;
+	/* Serializes proxy timer rearming with teardown. */
+	spinlock_t		proxy_timer_lock;
 	unsigned long		last_rand;
 	struct neigh_statistics	__percpu *stats;
 	struct neigh_hash_table __rcu *nht;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb642..1ea794a541efb 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -471,10 +471,13 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 	spin_unlock_bh(&tbl->lock);
 
 	pneigh_ifdown(tbl, dev, skip_perm);
+	/* The callback does not take this lock, so sync deletion can wait for it. */
+	spin_lock_bh(&tbl->proxy_timer_lock);
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
 			   tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
 		timer_delete_sync(&tbl->proxy_timer);
+	spin_unlock_bh(&tbl->proxy_timer_lock);
 	return 0;
 }
 
@@ -1729,6 +1732,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 	NEIGH_CB(skb)->sched_next = sched_next;
 	NEIGH_CB(skb)->flags |= LOCALLY_ENQUEUED;
 
+	spin_lock_bh(&tbl->proxy_timer_lock);
 	spin_lock(&tbl->proxy_queue.lock);
 	if (timer_delete(&tbl->proxy_timer)) {
 		if (time_before(tbl->proxy_timer.expires, sched_next))
@@ -1740,6 +1744,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 	p->qlen++;
 	mod_timer(&tbl->proxy_timer, sched_next);
 	spin_unlock(&tbl->proxy_queue.lock);
+	spin_unlock_bh(&tbl->proxy_timer_lock);
 }
 EXPORT_SYMBOL(pneigh_enqueue);
 
@@ -1858,6 +1863,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 		WARN_ON(tbl->entry_size % NEIGH_PRIV_ALIGN);
 
 	spin_lock_init(&tbl->lock);
+	spin_lock_init(&tbl->proxy_timer_lock);
 	mutex_init(&tbl->phash_lock);
 
 	INIT_DEFERRABLE_WORK(&tbl->gc_work, neigh_periodic_work);
-- 
2.34.1

