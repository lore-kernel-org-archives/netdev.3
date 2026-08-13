Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04543FD1F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608181; cv=none; b=tzRxg4bhPJtBHGsSCtm0ho5uEl6z0MXqfEnxM8VHJOnFmutq/9oqw+mI2z0w5I+80DvzHGN5/C0omGDqwmhsqczXvZU/onCtkmxOT1qt5Tcy8y4xuqucKG+TDtebStT7Ls67CO3cnbkW0xXPoc3LjEUkf3oXjKpl2veSlL5Halg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608181; c=relaxed/simple;
	bh=hPCAsH51PX7fQWti1Y0nv5311qLfGBb+hrMiRCh5QWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rtzh0ddZquFuxfkpldkWrruYLW3iz4HkWuOeTgwty5ug4BZIUKMRYuLbIqTrMWZ9VnThVToWcJxZ0xHLtxSLch2LUWLz6G4t1uNhVbK1F1CWZ3CEUtw+amaOvaLebitpYrkg60RTAJKAc20Wt6bL5n23mrNMxx56UtDWB1UQxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxB/Wb/k; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxB/Wb/k"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-392cf18db8eso3043038a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608179; x=1787212979; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIieOsBr918KolZtWgZ4syDR5W1JqAws+dMUu4PmewI=;
        b=NxB/Wb/kJpax9Hm46uIW72iWeNP/0cw/VKCplESOyJmWxlVt7dgGjuMlaOHn+C78A3
         4mNQxmkBx3rS5TgR+oslTrM2EvUDGLQtgyPfcYldWaO16ouUfQ712OHRhZnmC9Yopgw9
         2vtx6ow+3P95Pc+KF2bhwmS1oVYcnnJsDoh+I5VlSpbYpVrZV615calKOeROV+Ur6R0N
         Jvh6fhtIlWZHy7ps16vTF9pKX+4qQSn/szyAA5o/JQbp44fnAuk3AVYoG4WdrESVKCSN
         9NhfzLdkzT5IfUGqdEo99aoR+320V4OhfXTuXMEY0LU2uKzqINMENgL1VX5h9kXv9i7S
         JQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608179; x=1787212979;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yIieOsBr918KolZtWgZ4syDR5W1JqAws+dMUu4PmewI=;
        b=PsoffhXp3K6GuZQpcX7CFJToUoNlV19K+Uam3xS1AS0+TpGLUmozaj7m6fnIuTxj3O
         rQuZJ2135oIxAl35YjE8ZdPWxSh//Ued4sNMjUuu/d0E0p+8dDsxhcCgerWYgtPLWwTh
         djH2/QGckYD/TJoXi/5MDdfd24ynyyXtddN41TwFofJeRLaxl0FkvsGvhbyR3khCLpIF
         PadmkaRHXkX+HZm3NyvWNMlBigtcvHF7Db/0h1EL0MOD8Vmu+temnzg57ml5TJuZIWKJ
         8w/R7xiv0JbPgaRTW2z5zCXAfW6j4/vKI/oEsivYRLU83Nnp6FvXNbpmAL67XB8qDnoT
         /lpA==
X-Forwarded-Encrypted: i=1; AHgh+RpMsHc+InD4h732o830Lf7IH9ch3pm0gmzQ4TIs67PeD0gdCF/gL4u66srZg0LZ2fX1NaCm9M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9Q3N8m/d7RH8RhkGB7fyltKmJ2+9bO/Gcm/3fd57Tff1E5F/
	naIqmu3A/5BCNB3128BF7hAIOJGWU0SkhdlqFIND4P7DBUhnQSxzc+r9mXg5WclbV2WBUYX6WLQ
	aoVXtIQ==
X-Received: from pjpq3.prod.google.com ([2002:a17:90a:a003:b0:38e:c91c:3667])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c1:b0:37f:e1af:df22
 with SMTP id 98e67ed59e1d1-3931e2bd47amr4502710a91.17.1786608178979; Thu, 13
 Aug 2026 01:02:58 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:25 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-12-kuniyu@google.com>
Subject: [PATCH v4 net-next 11/15] neighbour: Convert neigh_table.entries to refcount_t.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will allocate neigh_table for each netns and free it
when netns is destroyed.

neigh_ifdown() cleans up all neighbour entries during netns
dismantle, but there is no synchronisation between timers because
neigh_del_timer() uses timer_delete() to stop a timer.

If neigh_table were freed while timer were running, neigh_destroy()
would touch the freed table.

If we called timer_delete_sync() in neigh_flush_one() under
tbl->lock, lockdep would complain although it is false-positive.

Let's convert neigh_table.entries to refcount_t and destruct
neigh_table only when the count reaches 0.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  2 +-
 net/core/neighbour.c    | 58 ++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 3e31eebf8663..762c8e4cdd96 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -234,7 +234,7 @@ struct neigh_table {
 	struct delayed_work	managed_work;
 	struct timer_list 	proxy_timer;
 	struct sk_buff_head	proxy_queue;
-	atomic_t		entries;
+	refcount_t		entries;
 	atomic_t		gc_entries;
 	struct list_head	gc_list;
 	struct list_head	managed_list;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 36488dbd1512..7dc8f0cdbb45 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -55,6 +55,23 @@ static void neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
 static void __neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
 static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm);
+static void neigh_table_free(struct neigh_table *tbl);
+
+static void neigh_table_get(struct neigh_table *tbl)
+{
+	refcount_inc(&tbl->entries);
+}
+
+static void neigh_table_put(struct neigh_table *tbl)
+{
+	if (refcount_dec_and_test(&tbl->entries))
+		neigh_table_free(tbl);
+}
+
+static int neigh_table_entries(struct neigh_table *tbl)
+{
+	return refcount_read(&tbl->entries) - 1;
+}
 
 #ifdef CONFIG_PROC_FS
 static const struct seq_operations neigh_stat_seq_ops;
@@ -522,7 +539,7 @@ static struct neighbour *neigh_alloc(struct neigh_table *tbl,
 	INIT_LIST_HEAD(&n->gc_list);
 	INIT_LIST_HEAD(&n->managed_list);
 
-	atomic_inc(&tbl->entries);
+	neigh_table_get(tbl);
 out:
 	return n;
 
@@ -672,7 +689,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 
-	if (atomic_read(&tbl->entries) > (1 << nht->hash_shift))
+	if (neigh_table_entries(tbl) > (1 << nht->hash_shift))
 		nht = neigh_hash_grow(tbl, nht->hash_shift + 1);
 
 	hash_val = tbl->hash(n->primary_key, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
@@ -924,7 +941,7 @@ void neigh_destroy(struct neighbour *neigh)
 
 	neigh_dbg(2, "neigh %p is destroyed\n", neigh);
 
-	atomic_dec(&neigh->tbl->entries);
+	neigh_table_put(neigh->tbl);
 	kfree_rcu(neigh, rcu);
 }
 EXPORT_SYMBOL(neigh_destroy);
@@ -979,7 +996,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			neigh_set_reach_time(p);
 	}
 
-	if (atomic_read(&tbl->entries) < READ_ONCE(tbl->gc_thresh1))
+	if (neigh_table_entries(tbl) < READ_ONCE(tbl->gc_thresh1))
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
@@ -1845,6 +1862,7 @@ void neigh_table_init(struct neigh_table *tbl)
 	tbl->last_flush = now;
 	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
 
+	refcount_set(&tbl->entries, 1);
 	spin_lock_init(&tbl->lock);
 	mutex_init(&tbl->phash_lock);
 	skb_queue_head_init_class(&tbl->proxy_queue,
@@ -1874,6 +1892,21 @@ void neigh_table_init(struct neigh_table *tbl)
 	panic("cannot allocate memory");
 }
 
+static void neigh_table_free(struct neigh_table *tbl)
+{
+	struct neigh_hash_table *nht;
+
+	free_percpu(tbl->stats);
+	tbl->stats = NULL;
+
+	kfree(tbl->phash_buckets);
+	tbl->phash_buckets = NULL;
+
+	nht = rcu_dereference_protected(tbl->nht, 1);
+	tbl->nht = NULL;
+	neigh_hash_free_rcu(&nht->rcu);
+}
+
 /*
  * Only called from ndisc_cleanup(), which means this is dead code
  * because we no longer can unload IPv6 module.
@@ -1881,26 +1914,15 @@ void neigh_table_init(struct neigh_table *tbl)
 int neigh_table_clear(struct neigh_table *tbl)
 {
 	struct net *net __maybe_unused = &init_net;
-	struct neigh_hash_table *nht;
 
 	cancel_delayed_work_sync(&tbl->managed_work);
 	cancel_delayed_work_sync(&tbl->gc_work);
 	timer_shutdown_sync(&tbl->proxy_timer);
 
 	neigh_ifdown(tbl, NULL);
-	DEBUG_NET_WARN_ON_ONCE(atomic_read(&tbl->entries));
-
 	remove_proc_entry(tbl->id, net->proc_net_stat);
 
-	free_percpu(tbl->stats);
-	tbl->stats = NULL;
-
-	kfree(tbl->phash_buckets);
-	tbl->phash_buckets = NULL;
-
-	nht = rcu_dereference_protected(tbl->nht, 1);
-	tbl->nht = NULL;
-	neigh_hash_free_rcu(&nht->rcu);
+	neigh_table_put(tbl);
 
 	return 0;
 }
@@ -2275,7 +2297,7 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 		struct ndt_config ndc = {
 			.ndtc_key_len		= tbl->key_len,
 			.ndtc_entry_size	= tbl->entry_size,
-			.ndtc_entries		= atomic_read(&tbl->entries),
+			.ndtc_entries		= neigh_table_entries(tbl),
 			.ndtc_last_flush	= jiffies_to_msecs(flush_delta),
 			.ndtc_last_rand		= jiffies_to_msecs(rand_delta),
 			.ndtc_proxy_qlen	= READ_ONCE(tbl->proxy_queue.qlen),
@@ -3495,7 +3517,7 @@ static int neigh_stat_seq_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "%08x %08lx %08lx %08lx   %08lx %08lx %08lx   "
 			"%08lx         %08lx         %08lx         "
 			"%08lx       %08lx            %08lx\n",
-		   atomic_read(&tbl->entries),
+		   neigh_table_entries(tbl),
 
 		   st->allocs,
 		   st->destroys,
-- 
2.55.0.691.gc56d675ccc-goog

