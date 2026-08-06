Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F373B8D5C
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978724; cv=none; b=rRhR/31yOIG/88ESpOdqVaMUpXS6iXXwO/ryE+us0h+q2ZPopvEUTqYtSsYlMq7yaP+wtwBWh2O6vBFRUXfCIx9ytzPKXVcOF7QBKpxb4Z098I67Xi092WDQSlT6v4Hq4v0OSlwSYE3i759Knuo5yDCGwqTX1XVUMhi+TPEXwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978724; c=relaxed/simple;
	bh=AOBSNe1NuOp3gf8w9EShF47mOfyRFN83JneKa7mNN5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sphqb3Hk/MlA9EksKPHWATKUvmN6YKLIHH5z5BR3j8mKFbeCzJC1EMFr4mFUMDYpZhdnz2hI26YsdHQg+F/DTIlyCwFvpnltnS9jsfBkWjO6+I0bLLsTh0MbwzdYXTwU85jANk6OIFuSxFBdaSj0EWc0zpHDVq2zIzga4GuUXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chRts3id; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chRts3id"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so845439a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978722; x=1786583522; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvaHaNSRzYDLuKIeXJJbN5TdEtoB/mhFDLRMIyDC5GI=;
        b=chRts3idM+5+R+BfMi3Mk9Z/H8AZjeKUyOI21ajgt+//bRZrOt36fCtfG3c/r6w9Jq
         NX0WPQ2wrP8lqIwkmVVZbWkNrX+kH4sPlqzSAEW6Kd+b/2zmwOGX0P7GdSG4eRW037KE
         Jcwqyry9QoZ9IzcTkej2OJvFhux/SmbWwjVnwi2hsvd3iNRH8sn+2gjK23tBXn6QOtiT
         ePbT7xal8XC/iM4Nd8mWa2p1Bbb7xr2653+sGv7YAixlGZ8CPSbBYjIzICoKbTHINkM9
         F1GwS67Qi6jtuLOZAhM1U339xOBcXjcZLolJq68HqYwZlBbq9Dhjb0PBpCwgutCyVNkJ
         QgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978722; x=1786583522;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zvaHaNSRzYDLuKIeXJJbN5TdEtoB/mhFDLRMIyDC5GI=;
        b=CHKXbFKwfbAtOdPfA0IX7FXyIVA/bIYeugLzZxj4/t+nmWPXpOD7cPeeHndrBe0yOY
         RY1ERoOX+lvzxCMOn/AWb4X8J9TJhehzS3c1J3CVEpLOwpvzOxaamXizfLuLjnuVpBQc
         8cgR8+l6/9O5KCjCeVoQzpQS63qF92bZNviebJBVbh21ISwjAXyGceQZSv5Uo1lp2+9u
         jjMnUNp9Wu1WDWYEbCencSj+xYHI+IxY3YA0kuB1H0qdcqTyzjxBsSetIxGaheceo0BK
         tGt8gY/8MaOslH6gpnEgipaehX57lK3rabWaiU3QtnIrI3BLQCNyrLTzr1oROtbZXZ1L
         rEEg==
X-Forwarded-Encrypted: i=1; AHgh+RqWPbrjc0Sr9TYjrNRtILmwVJaqxMtypSSDIPdtQbbuxEKbYmQpKYU0d9GTZkXxj3YwiEjBDuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/VK99p5ABgC/Xmst4406ajdU8xL/l/PVHpaf9mWjQlvrLjk+
	38X87TatAd5MfBRheKCuDX4XH9IBeM2fDdjpuulvyg6yEjPWCbtzd7C4+/Kx/OkZauwZr6k2AZv
	HSvylvA==
X-Received: from pjsd3.prod.google.com ([2002:a17:90a:bf83:b0:38f:853:5fa4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2785:b0:38e:6c37:d95a
 with SMTP id 98e67ed59e1d1-3903c5e1f07mr12515766a91.19.1785978722091; Wed, 05
 Aug 2026 18:12:02 -0700 (PDT)
Date: Thu,  6 Aug 2026 01:11:31 +0000
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806011152.1170012-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806011152.1170012-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/11] neighbour: Clean up neigh_table_init() and neigh_table_clear().
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
 net/core/neighbour.c | 98 +++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 34da4cdc813d..83915526eb31 100644
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
+	struct neigh_hash_table *nht;
+	struct net *net = &init_net;
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

