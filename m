Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DE43F4C6
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608181; cv=none; b=f4ih+RE7ba6e5SteX0zF6+CrXRbC1QkKX9utFi1pd7TkeZPVhwO+1ClEuK+CX0WK9BqNLUOwS8+NNTNVnuKe8ViCpvY4RbPfqdGuv8RpYNRpHicGUi4Yn8qqU96i8McprZjUjF3LbxLcEDmaWrlqnxFzarECDSQiqB37h5+xmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608181; c=relaxed/simple;
	bh=qgSohFgp1reFWMhB3ZL5Rdiw2S6gJnJF9u2bmkbLyeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kqgtO/RQKVax0Ml54PPgwy90QgEM3OpbVB4MSaDb1j021W51WmM3uHJhxvoYXyUdDJVsi56laujp3fJIXSnGZGzb33HvuKOXo8M9Fpv9l9O0HhBWl4S1PXA952Qd9xkbD+SJkzyoFH5LPLcb9bR9l5SXw1IhhH2pRfBDmASXsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBCK79QS; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBCK79QS"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso25892175ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608178; x=1787212978; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDX9Mfv9sHPLxTpo51wyn/+0db2qGGb50xJmjyb5NT8=;
        b=WBCK79QS4X/616bNlOZeHpreilZWC/EP5czaF3zWrD/we8W2pbZM1fvQxWVU93bVL6
         Ts3zIEjS10JuadphOWMZwAm4UQ+hBeEJ5pqUlbsMuSXmKEEZrR2IeFV8wDZmPK9J7NqZ
         pPGpb9HD3WA8PYOQ+ayGI1ZiErJbSAF9cAXpql6wUNoRkxhhT0TrH4zv6FDQBae5t+yz
         EcwAZvB10VIQQ4qs0+xQGcFZW7EqHGl+BPObuSgZvPTfJRa96dpgMBEaxlQDnPoIhxU6
         yqoLVaDczPlUtT9nkCyTwg3u6kCA0hZLraB1gLf+5CFnK3xMrrDXQnKd7njWTgYv83YN
         rsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608178; x=1787212978;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uDX9Mfv9sHPLxTpo51wyn/+0db2qGGb50xJmjyb5NT8=;
        b=YtInceqDF5mxmnxHHilhkONaSaoYQdVpt/kC0jH8sSCNaAnfJLgUzNxwi4iPFb7FGv
         D021mnMeJf4K69fjCBXoHuxcC7JYFJVDgTR0p4baa3ofmPbDZBONP5W8DGZjAmoFrqBq
         0oIheEG1UvgdhxZnD2xF7fPQMhX0dTekIps+UOkpQ7PERqF1OvMPr290Vl8Gl28DpbCk
         PayENknBJFlvVZANBKHATknR4dnIgG/d8QFfNDiw7gHocDotmgg9LdB2+LPb630YZyjy
         eGO8jXoZYLfGjdHQRl7tUIqC3lw5t/LdqW8imGwmwUysduFlls6qPlJLMOBQ0bFgU/BM
         xNQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2b13TfuF6lEhXEYjUsemTA64Qx49dY/L3dkcEoHIQMRMqo3Ox5s0PV3uSnRW3dJJaZPVKuks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+g0Sali0Cs/faT3DOA/g601v562alXco83NtPfKFSHEitt1E
	QpU+vrVD6PExK2soj68xFOODExHuPIU+VV4phZfegoziAXzaBu84qc0aqNV7gqovhmrsoTL77U9
	PhSX/pw==
X-Received: from pldt5.prod.google.com ([2002:a17:903:40c5:b0:2ce:72a1:4ac4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:28e:b0:2ce:8e70:3210
 with SMTP id d9443c01a7336-2d37e8a09b5mr47613095ad.16.1786608178206; Thu, 13
 Aug 2026 01:02:58 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:24 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-11-kuniyu@google.com>
Subject: [PATCH v4 net-next 10/15] neighbour: Clean up neigh_table_init() and neigh_table_clear().
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

