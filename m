Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDF49E5CF
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287620; cv=none; b=gCDCV7apuz7lonOVxTUx9qHEA5NYWnls1YiDKEj8nW2ZDUKwhNdwdcBkyXonAJ+yVAhfpLrztycpsBdZV2584ALPbh5zov1kIhTQ2psaeOD6EisHpLuJDIT+dztL1sUuv2rr31+vRl/SwJ9d1ma0udbmElqHnsQVTlXp4nlJqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287620; c=relaxed/simple;
	bh=eSC21oS7SZrVWJP61MrqaO5tzg1yuPjPnpA5o/8yh6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAQleF6dyMm87WMvM8pDTBZZCS/kLcNr4F5rQQSzGLp4J+NFwIT+YFO0yJ6G/DEgFsVi2H3GoxPZ9Ctyj777Iz05/D1mobDc3g7GDOSeYNJ4D/w1Wrs3UdzLSwt5bW94MrAxVIsJSWZJSRYTub4agx+EAsjm/kh3SntDQOWporI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbhpedj/; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbhpedj/"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso162710a91.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287618; x=1788892418; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0RxYOkneh7UDB4Jpeoqndl/D+yePitGPYRZxzb0/Zs=;
        b=lbhpedj/hghOQRqVsnm2t4BG8+LNqQigrEPlKuRAR30d3Su5t4jhgNQSyl+xDFgdMJ
         2mYtKMdlyFbbUs2fLaKqnPoIF4BpovGXS/fvwAFW1xSGvrmPOfIP/DVdNuROEBPqcMn1
         adc+Y9fPFdHPQTKyT4qEUAJDRd3o5pczRSE98GMek5T0a9Z3X5NOtMC6Jb9/8mDqoFfA
         i8lJuFsJSfXuJCUQmyrK7rwA/cy11x8/qTWBWk0f2c9ZVwgzCzDBevEHq7iqNHI0AvRu
         sTbImQDHGYDSmWFsu2KVQKIlpBahUm88t/+y9YpK4i1ZvqgT37w/S/Ealvw5F7ZbM7CF
         GKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287618; x=1788892418;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0RxYOkneh7UDB4Jpeoqndl/D+yePitGPYRZxzb0/Zs=;
        b=NOML5QZLvsA1+7k5JOLTn4yzwWCGwNwUGMzzOnyTDqYlyWPrfUzNuc7IQ742PiAoAW
         XiZskcbsuPj+rOrFeOrG82BouNUTtZxlpBjbIcmSqUq3bc54vVKpvNRYaK/QiHBd8Q2o
         bmr0j6iAjsZ3Bugn3fLhx2J4mHbgHic+k4eDwtiIPJXa74iXF+GxbBb0BUTghnE51bex
         kQwCqOJaf5qvD5gS36nWx21G1XOJZUwHEYcrwx6gprHvu5NCtEaHWTTivACVcVJE9vUG
         oT4j1XTzoFU6BWIMd10q5fVT7CPpapE0hr2lNrJ6sH5Ol8ycmhFzqO9pQDnNVb8FURTx
         1Lrg==
X-Forwarded-Encrypted: i=1; AKwUvBxJu3eq2QIpgyth2hidoDQ/6+C94ec5FtggclPYK5ubFU40dSItTcudffMRlB8rrjY5i6A1q3U=@vger.kernel.org
X-Gm-Message-State: AFuF++nV0i0O6nyPoGleNVcNiCv2Odeg9xjp76ZlIx+rDQtFQF2CywxW
	XOkNHpCRKF1USgyo2iwjLPSzocEpNLCr0hT/uEG6yCar0MBporCItdVZHOI23fnT5wFlzihYH9k
	PbmJGGg==
X-Received: from pjuj3.prod.google.com ([2002:a17:90a:d003:b0:396:4729:4402])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8a:b0:398:9bd1:3211
 with SMTP id 98e67ed59e1d1-3989bd135cbmr38762596a91.18.1788287618017; Tue, 01
 Sep 2026 11:33:38 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:59 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-11-kuniyu@google.com>
Subject: [PATCH v5 net-next 10/15] neighbour: Clean up neigh_table_init() and neigh_table_clear().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
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
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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
2.55.0.966.g6673acef38-goog

