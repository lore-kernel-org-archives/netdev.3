Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55538F25A
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415102; cv=none; b=QFyVF7rvMjVk9v7nn80zyd7Z+cey92DCfUZbaRrP/viBADjWtovOoFlZmxiaa5qAbo3GaRSxd/i2xrXqLH1hm6YYWk9mUjBZ//jkUUUuTW4clyp+Ia/OZIav+ZJ+HrpoU832jrrZA6ZPUpcrbPGK3Bw6QGfaDx3g6sj2R6Y/4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415102; c=relaxed/simple;
	bh=qgSohFgp1reFWMhB3ZL5Rdiw2S6gJnJF9u2bmkbLyeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iXBYXVNxBmkWUwiTOCSwmvz6OJc9hMwn4RNi6ho77w8RPfLe2zJFu/VQ3gF7D1pncLmiy1LQyKi3T4teBX9hUC573egMxBBw067sQmcGSkSe+kFpXyhaC5TcXtJRb493FHm+2/VcKEHXtkvBhJKQ8znIEJSKrozM0+zl5gXFDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iajXr6HN; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iajXr6HN"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so4314816a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415100; x=1787019900; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDX9Mfv9sHPLxTpo51wyn/+0db2qGGb50xJmjyb5NT8=;
        b=iajXr6HNqEtXcPrsdBG+BZo7DIZclRNENbSP2Kx0bbgYDJ4lUHCvZDhBcnlZ21V0nc
         QPm9pp7g7n10R941WpU0NnyE/Y41ikEj9pDGUgQ2I6KTZXKTskz6Uo2aY37TdQU1n1RI
         vR3S9Xj3qWb9i+6U9x886nh1sZcIPJEZjGJDIGTLv/X3j10FS7ZzMjChXAoeUEQcz1u9
         6fnn9H3sKYF9tiltM++k5D7+dBVCvw60gFcsT6aaHyXu8VYlQtKnL86+64+ljoUXebIX
         1OeYwOLqQZZThotiGj93uku37oEAkq3vh1OcfiokasjgbS6LIuFb1JxLj4GORS0ot9Qn
         9j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415100; x=1787019900;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uDX9Mfv9sHPLxTpo51wyn/+0db2qGGb50xJmjyb5NT8=;
        b=Q/dFgiAAE9OH4Wt05q5/Cku+oB8bkOJz0ePoWiOCIyUD7oI1EY5JOcn2irz0X01LF6
         SowoOfYqq9z7v/p9UZqXJxozeXgruVSZs2aebFQhFpF/Adj+ZIQldV51lIVpx696mQa1
         ZZRuoqomjGMaSXQg00hG6CLJffqTbOXHmGRjBABblDPGAR830kZ5NMfSdGiYc2DalNSn
         n6ovp+90rtVZrE8kly2KO3Aw3tW33O1zYb34TM0bG7BcU8ndBsYs5HjRmOuwpGDYJwk8
         ywRrCptUC7XTFOS1PA1QEU/NYHkFY6G3Sh/3458Y1n0ehhvc26Z8FOYQ8gIJrrpMYoFB
         VkZA==
X-Forwarded-Encrypted: i=1; AHgh+RrdAwXEP5tS0uAuXTs7prDenprP2Q/svWEOfpD//yN0QL1I6B91kp7FnXsgm0L62z+sskCGy6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ckOrLq9kyk2sqe+68QyrTpRf2gnEcodyjs9mCqB9yBdlYu0W
	AFcUhQen/Af4/rTigpdauDYMUIiZYHz53tiDIRoZsJkI26Og3iSSV60y24Sa3wzn5xF+QeaYJa/
	EJhlZDQ==
X-Received: from pjkx5.prod.google.com ([2002:a17:90a:7885:b0:38e:a556:bb27])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f81:b0:38c:e9e9:e7ce
 with SMTP id 98e67ed59e1d1-392822bf6abmr20600640a91.3.1786415099921; Mon, 10
 Aug 2026 19:24:59 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:44 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-11-kuniyu@google.com>
Subject: [PATCH v3 net-next 10/15] neighbour: Clean up neigh_table_init() and neigh_table_clear().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, neigh_table_init() and neigh_table_clear() are called
once at the boot time, but we will call them for each netns.

Let's clean up them.

For neigh_table_init(),

  * Allocate all memory first and unwind on failure
  * Remove !tbl->entry_size check since it is always true
     for arp_tbl and nd_tbl
  * Initialise everything before starting delayed works

For neigh_table_clear(),

  * Reorder function to match neigh_table_init()
  * Use timer_shutdown_sync() instead of timer_delete_sync()
  * Remove pneigh_queue_purge() since it is called
     via neigh_ifdown()
  * Replace pr_crit() with DEBUG_NET_WARN_ON_ONCE()
  * Call neigh_hash_free_rcu() directly without call_rcu()

In a later patch, neigh_table_clear() will be split so that
tbl->{stats,phash_buckets,nht} will be freed only when all
neighbour entries are freed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Add __maybe_unused to net in neigh_table_clear() to
    avoid transient W=1 warning for CONFIG_PROC_FS=n
    (next patch removes it anyway)
---
 net/core/neighbour.c | 98 +++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 34da4cdc813d..36488dbd1512 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1810,57 +1810,68 @@ static struct lock_class_key neigh_table_proxy_queue_class;
 void neigh_table_init(struct neigh_table *tbl)
 {
 	unsigned long now = jiffies;
+	struct net *net = &init_net;
 	unsigned long phsize;
 
-	INIT_LIST_HEAD(&tbl->parms_list);
-	INIT_LIST_HEAD(&tbl->gc_list);
-	INIT_LIST_HEAD(&tbl->managed_list);
+	RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
+	if (!tbl->nht)
+		goto err_hash;
 
-	list_add(&tbl->parms.list, &tbl->parms_list);
-	write_pnet(&tbl->parms.net, &init_net);
-	refcount_set(&tbl->parms.refcnt, 1);
-	neigh_set_reach_time(&tbl->parms);
-	tbl->parms.qlen = 0;
+	phsize = (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_entry *);
+	tbl->phash_buckets = kzalloc(phsize, GFP_KERNEL);
+	if (!tbl->phash_buckets)
+		goto err_phash;
+
+	tbl->entry_size = ALIGN(offsetof(struct neighbour, primary_key) +
+				tbl->key_len, NEIGH_PRIV_ALIGN);
 
 	tbl->stats = alloc_percpu(struct neigh_statistics);
 	if (!tbl->stats)
-		panic("cannot create neighbour cache statistics");
+		goto err_stats;
 
 #ifdef CONFIG_PROC_FS
-	if (!proc_create_seq_data(tbl->id, 0, init_net.proc_net_stat,
-			      &neigh_stat_seq_ops, tbl))
-		panic("cannot create neighbour proc dir entry");
+	if (!proc_create_seq_data(tbl->id, 0, net->proc_net_stat,
+				  &neigh_stat_seq_ops, tbl))
+		goto err_proc;
 #endif
 
-	RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
-
-	phsize = (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_entry *);
-	tbl->phash_buckets = kzalloc(phsize, GFP_KERNEL);
-
-	if (!tbl->nht || !tbl->phash_buckets)
-		panic("cannot allocate neighbour cache hashes");
-
-	if (!tbl->entry_size)
-		tbl->entry_size = ALIGN(offsetof(struct neighbour, primary_key) +
-					tbl->key_len, NEIGH_PRIV_ALIGN);
-	else
-		WARN_ON(tbl->entry_size % NEIGH_PRIV_ALIGN);
+	tbl->parms.tbl = tbl;
+	tbl->parms.qlen = 0;
+	INIT_LIST_HEAD(&tbl->parms_list);
+	list_add(&tbl->parms.list, &tbl->parms_list);
+	write_pnet(&tbl->parms.net, net);
+	refcount_set(&tbl->parms.refcnt, 1);
+	neigh_set_reach_time(&tbl->parms);
+	tbl->last_flush = now;
+	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
 
 	spin_lock_init(&tbl->lock);
 	mutex_init(&tbl->phash_lock);
+	skb_queue_head_init_class(&tbl->proxy_queue,
+				  &neigh_table_proxy_queue_class);
+	timer_setup(&tbl->proxy_timer, neigh_proxy_process, 0);
 
+	INIT_LIST_HEAD(&tbl->gc_list);
 	INIT_DEFERRABLE_WORK(&tbl->gc_work, neigh_periodic_work);
 	queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
-			tbl->parms.reachable_time);
+			   tbl->parms.reachable_time);
+
+	INIT_LIST_HEAD(&tbl->managed_list);
 	INIT_DEFERRABLE_WORK(&tbl->managed_work, neigh_managed_work);
 	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work, 0);
 
-	timer_setup(&tbl->proxy_timer, neigh_proxy_process, 0);
-	skb_queue_head_init_class(&tbl->proxy_queue,
-			&neigh_table_proxy_queue_class);
+	return;
 
-	tbl->last_flush = now;
-	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
+#ifdef CONFIG_PROC_FS
+err_proc:
+	free_percpu(tbl->stats);
+#endif
+err_stats:
+	kfree(tbl->phash_buckets);
+err_phash:
+	neigh_hash_free_rcu(&rcu_dereference_protected(tbl->nht, 1)->rcu);
+err_hash:
+	panic("cannot allocate memory");
 }
 
 /*
@@ -1869,26 +1880,27 @@ void neigh_table_init(struct neigh_table *tbl)
  */
 int neigh_table_clear(struct neigh_table *tbl)
 {
-	/* It is not clean... Fix it to unload IPv6 module safely */
+	struct net *net __maybe_unused = &init_net;
+	struct neigh_hash_table *nht;
+
 	cancel_delayed_work_sync(&tbl->managed_work);
 	cancel_delayed_work_sync(&tbl->gc_work);
-	timer_delete_sync(&tbl->proxy_timer);
-	pneigh_queue_purge(&tbl->proxy_queue, NULL, tbl->family);
+	timer_shutdown_sync(&tbl->proxy_timer);
+
 	neigh_ifdown(tbl, NULL);
-	if (atomic_read(&tbl->entries))
-		pr_crit("neighbour leakage\n");
+	DEBUG_NET_WARN_ON_ONCE(atomic_read(&tbl->entries));
 
-	call_rcu(&rcu_dereference_protected(tbl->nht, 1)->rcu,
-		 neigh_hash_free_rcu);
-	tbl->nht = NULL;
+	remove_proc_entry(tbl->id, net->proc_net_stat);
+
+	free_percpu(tbl->stats);
+	tbl->stats = NULL;
 
 	kfree(tbl->phash_buckets);
 	tbl->phash_buckets = NULL;
 
-	remove_proc_entry(tbl->id, init_net.proc_net_stat);
-
-	free_percpu(tbl->stats);
-	tbl->stats = NULL;
+	nht = rcu_dereference_protected(tbl->nht, 1);
+	tbl->nht = NULL;
+	neigh_hash_free_rcu(&nht->rcu);
 
 	return 0;
 }
-- 
2.55.0.691.gc56d675ccc-goog

