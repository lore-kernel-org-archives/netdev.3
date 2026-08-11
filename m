Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0B3905EF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415103; cv=none; b=JmiD9O/CtuMgPU5HJYpPJRjXhvlGHYfvtPIRGOs8xGC72qevrXLx+v64k3vvhaSgeF5qF0tbBfvdWeBOsdLyecf6+BDy6vBCYkLuDriGTEainzFcpzpyVIu8Sde8vuMCJcocrnjp0/efr8GcQoY4UKazeplZZVFHbn+oSaD47VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415103; c=relaxed/simple;
	bh=hPCAsH51PX7fQWti1Y0nv5311qLfGBb+hrMiRCh5QWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQiuIM8A5Sv0Oz+rWVg+tf9ky4U0J6J9YgkQRKxUmUkr1VzbZxQ4sVORCHbep+hOEZt3zJWv3A+sGL0cyhVKYgb/boPbYwYUSE3npmFHf6sDHfhhK8L+rjS45D5uQe420E6lcPtERYvIEU/wmkdYt6HABcNipxCInzPU90Op8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovNi94aa; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovNi94aa"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84eccf9d899so3603960b3a.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415101; x=1787019901; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIieOsBr918KolZtWgZ4syDR5W1JqAws+dMUu4PmewI=;
        b=ovNi94aawFDjq4P/hJbzWKnYLu3wKDPuwjpV1xlWZ5FdSWZRvviJolKxTkRMXEF05+
         YpU3rTDhXyRuUafQDtT8ymGyNhshjPJjGAB3xh1paU3UHihjhKAAdNP3+Pl3QIhMSyin
         Qo0CWZaEDvj8DKOidBDUkMDt/QPR9MJZdqhDs40tLtdtEVW8rxm7qQbyS9HmSGW2yQD2
         FGvB37U2ije4U68pKlKYUkZoxwc6d0fpRUg0d2O3EMCatW88JuNIdULGukRU6uKd64Ko
         mS92mlecQIoitZrf0Lh7Lit3ooxlC2yzyfqMBPaPXv4OIIs4sqCmhF5Cn0tIgprcn8/3
         voNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415101; x=1787019901;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yIieOsBr918KolZtWgZ4syDR5W1JqAws+dMUu4PmewI=;
        b=hc4dW7pc6+yZDwlPqWvr+XhCLwvPnAePZbBchAzLrE4ylrnMKwUQ8LgaylFjsHiT8v
         w9wi/0TCxlyOnI+3sUyblQe4WszHTHokn0TOg7plu6gVWuM0jI74KsHhdcxD3H8FtVQr
         7zdSScWhhrJEFWt5ODc/S1JhaC2ZgWknZiftq69xmh27WSZ/B9qAxDsNI5sC2ivH52Lh
         7cEWwPDgdXSCxmPODBqeS8MyImRF63dz/zTLBS1z9T4baDyOwKve4dawhehvFDKSOrgi
         G5rBtaqm8f2K/1R60pQl1NYwGWoYYOaplu0BAnkQi8FVtHGxi9nOG+op6myj/ISbg/wg
         fpGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJfR41JjcKR8vVR6nwgxXtKIJEPgsHRaHCWGZeWNuvYeV2tSuYYAmlqXq0Yu1zdVmlu6JB8zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9SVpxXpFIaDzDzVz+LcjjZd1t9BOK+y9EP2/gt4Net1MItlT
	EUUmlcQ52REDgSdKfR5Wd6y0R4fSMJAw2EatfZ3LxryWbGEISXnoHx+B5AGCYLMWLxlz7xhaD4V
	+GhUfIg==
X-Received: from pgmm15.prod.google.com ([2002:a05:6a02:550f:b0:c9e:3c0b:5818])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:230b:b0:84e:43f:7188
 with SMTP id d2e1a72fcca58-84f9c8f6885mr6694454b3a.12.1786415100810; Mon, 10
 Aug 2026 19:25:00 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:45 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-12-kuniyu@google.com>
Subject: [PATCH v3 net-next 11/15] neighbour: Convert neigh_table.entries to refcount_t.
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

