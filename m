Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7740EBA8
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145383; cv=none; b=lIABj6dvn0m1/VrdVrQqHX6UE+qO+LmKJNlRLhpjnsQxlOEB8B+KWNqEEtWIkbaMeJEUiNIEw/77hGgHEtX3PkvHbTvVMvfqByFYxeJmS9iid7x11ZvmAIuuuzsc4725dIlmQcUB+AOH7SNcG+S3emqCWLcVkG0NB4ShIxAte6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145383; c=relaxed/simple;
	bh=jRVTq/aJwdgf0HhsAbXkowhNqAwig0NMHvHUgkLxh6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pyi5Jw4UFWaDSGm/QonyObTeEOl88lUpzR2ctQZtRD7xnPzEUHRDC3Wv4g475fWvuDlX8pZPgQ+5BHl7aCQyNrvNuQKeaA3jPjYTK4Gf7WcU6+4viwMi6D9Dlma03oKD7Fm43fnEqz+EnvoYLSqQd0qVOWVofuWI/+RSACqGaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+fyz6YW; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+fyz6YW"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso29365a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145381; x=1786750181; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdPQsR6WvClaUBabAiRpHkf8GZhB5LrQA8JYIcpsr8s=;
        b=P+fyz6YWrg6hEcFFy3IPxxMCr1e3hwj6dxEgkQFPsj7YiSPEECx+YUImOuNdW9MZ5P
         W1fsC2f9l3zqdDL3TZtVTMzFzIhx+i3gmux1GjvsXz35kBDpFaApcZdN+/cdVXhiwweZ
         pdCO8KbdR3+wdTYS+uxN2pcsx2GLimYjf9Rgj6u8Xvq88d4yj7QammKE2Z3PTmAYoNqb
         lCkghCiCnQSrLeGL62fIIzQjdzinl0aNxGH+hkPmpHnYHfzH2R2KymZ4+zQhbYPpKtdx
         eQ23FcezpUrBFvRUiRAtumUcD/nyjQ6O8LSxHGI+we4JLj+eumOZk3otHQpGc9/pRUMI
         8xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145382; x=1786750182;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WdPQsR6WvClaUBabAiRpHkf8GZhB5LrQA8JYIcpsr8s=;
        b=Xt0TVQ1d4deV9JnWXdqUXYRcwRVzI2XsjMH5oemyyzdq2WE+xfx6vEGe1hpKsYltY1
         zmaL2TOai8TE9bagA2Fgl64vmmnZ7XBbVw0mmWDTb1ThRz9IDdYNux5It0719MQmbl1p
         qneavmAvJHYckq5LxHLnwJvpx4UTCON50o32sOI7ygsLbKTffciOFPKtLrP9tCc8Dv3a
         8vcuhvITCIpnWLjsVCtPITBZphGfOWFNouogsRtrfgOT7wzwhljLzmXB11W6mV7YGh+m
         OX1hWfEB9UbtR/WTdjFLnHbIGxoo2k1zt24EWQhHj1EdGKYH/o6M1GkJLYq5u2Plnl1D
         05gQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQdhpCC0ZSmfebP5/E3uW6GY9lyTVVAQDVy371QuIfjkeGJ4mIPN2Ghg9zfyfBecM0LKi/a8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQiYNh6HsadXc4ShBDgMqdKESoiGM2+7EXuXU43a3oqe61EEaD
	yAuOkKIUDHa7l1kIxDVyjV5J03exlnLrSlicL+78w3RDtkZ6zCS+FZyzPzKwCUd65tSNNMmGKqc
	FbGDpuQ==
X-Received: from pgco13.prod.google.com ([2002:a63:730d:0:b0:c8b:2b50:846b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d52c:b0:3c3:812a:2198
 with SMTP id adf61e73a8af0-3cb85df190amr34264804637.4.1786145381365; Fri, 07
 Aug 2026 16:29:41 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:47 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/13] neighbour: Clean up neigh_table_init() and neigh_table_clear().
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

In the next patch, neigh_table_clear() will be called from
neigh_table_unregister(), which is called from arp_net_exit()
and ndisc_net_exit().

As of the time, all devices are already unregistered and no one
can access (p)neigh entry, so neigh_table is freed without waiting
RCU grace period.

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
2.55.0.679.g6767b8d81c-goog

