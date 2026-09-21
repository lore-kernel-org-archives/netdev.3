Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B93AB29D;
	Mon, 21 Sep 2026 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974107; cv=none; b=l5gKQltqor80U/OtUgv6/Z+z7HH93aEcdSbuBtTj2szcmW9fb2rZljxtDI7EsMX+0M7U/+ITu6CScu8VW+r9hf0NqnCispwaQnqenVIugnBaR0R71E9kHojsQJToArlzU0rnLotKxpA5WS+wRv2PU1+MaXuixKxSS+YBRL0nGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974107; c=relaxed/simple;
	bh=EFctsjqpZY5vmSgGoUDUwqmoG4EY3+Bc/KM/arPjU8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kGrMM+l7tX06GoJoG9itqjZgKQn33YDoZJeWhlauoKrtSrYC5bfYGFBf9Ph4u4DhvKcICXXUORYtDJE3fvKBWuwF/A9Ck8oHDic+TyLsUdyHUhSAcusHCM4Py0qhEDj2J2dXe4tukaqdP/xSwK+fJXTqId5Ry9h7vnPssGElCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cEEKLAmw; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="cEEKLAmw"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e88912d1;
	Mon, 21 Sep 2026 15:01:33 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	"Denis V . Lunev" <den@openvz.org>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2] net: neighbour: Serialize proxy timer teardown
Date: Mon, 21 Sep 2026 15:01:27 +0800
Message-Id: <20260921070127.42998-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c2c5204803a1kunm5ea332a937ac0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhkZVkIeSB8ZGR4YSkhLQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=cEEKLAmwHaVtC1dIDgcIKoiF3xwIiHGww6Yyti0nfOb4b14MyQLtcRw39A7yooGn1zRB7VyQ9Q6k1RGnE7lGctRiaC7PQgny/gDXhHpnbEAHRnqvgcBLKnCqvRhVRMJKcuS59VIPmnm5MkxzOmabtCOeSJ+x4xeuqS0/q8u/r7o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=S9J7DBqhf2sP5XW2NokysucD3JgbfbwIAjcMcXKddak=;
	h=date:mime-version:subject:message-id:from;

__neigh_ifdown() purges device-specific entries and then checks whether
the shared proxy queue is empty before deleting proxy_timer. A concurrent
ARP or NDISC request can enqueue a delayed proxy response between the check
and timer_delete_sync(). The timer deletion can then leave the new skb
queued without a timer to process it.

Serialize proxy queue insertion and timer rearming with the purge, empty
check, and timer deletion. The timer callback does not take the new lock,
so timer_delete_sync() can still wait for an in-flight callback. Keep
timer_delete_sync() rather than timer_shutdown_sync(), since the timer is
reused after per-device and carrier teardown.

A check of netif_running() in pneigh_enqueue() alone would not serialize
the insertion with the purge, empty check, and timer deletion. An enqueue
can pass that check while the device is still up and then be delayed until
after __neigh_ifdown() has observed an empty queue. Also, __neigh_ifdown()
is used by neigh_carrier_down(), where netif_running() can remain true.

Tested in an x86_64 QEMU guest with proxy ARP, three network namespaces,
and veth pairs. An AF_PACKET helper sent valid broadcast ARP requests while
the proxy-ARP ingress interface was repeatedly brought down and up. A
temporary test-only build flag added a 5 ms delay before pneigh_enqueue()
and after the empty-queue check before timer_delete_sync() to amplify the
narrow scheduling window.

The unfixed kernel reached both paths and observed a non-empty proxy_queue
with proxy_timer not pending 772 times. The fixed kernel reached both paths
under the same workload without observing this state. Natural-load runs
reached both paths but did not hit the narrow race without the temporary
delay.

Fixes: 66ba215cb513 ("neigh: fix possible DoS due to net iface start/stop loop")

Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Add the QEMU reproduction and buggy/fixed results.
- Explain why a device-state check does not serialize carrier teardown.

 include/net/neighbour.h | 2 ++
 net/core/neighbour.c    | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 8860cc2175fc1c9eb6b67f2c5ef149188c9feb16..15107c00b4df473e53e6cf2e757fb2ef3c4fd3f7 100644
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
index 1349c0eedb642539b28391390fd82f543e004353..1ea794a541efb6852700062da2e25efac6c060e8 100644
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
