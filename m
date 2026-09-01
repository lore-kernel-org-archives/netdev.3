Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A349DBB4
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287621; cv=none; b=iuWicXXkjwoO0QWKwQsOy4lKTnB8bmd03Jz2RucIp+uEXIxALeRp7+zUEbqasOthFbaeLKjWGE3Il+JtPMP3w8AGrvwUYG/Sh9NaFqAzJx4SXLlqzhif0cN+cJj6vuD8uCTrwapIwJXCGdLkTjj7VOrp8EViCDf/jneM4ENt8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287621; c=relaxed/simple;
	bh=HlEQwM7PKTQVYGlLwvWSMbsjH3hrro3+Q+QigNQU5u8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u7lF3WWbV0WO/cs1WQ4KhUSLv2YEYooUg5yK1jFdk9Yhpfe0iohKsFJ1FK5TOMcSUMq8kzWqtPu6aahKsCB5TKTlDhTtIqmtcPFOYug5BhgpuBHhyhzZWxAIicFG7GLDq4U4u8K3EuP3KRHDNf8IafuVlwrBlbzn/m5WM3Q1/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/JOSORt; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/JOSORt"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1c2f1acebso260491a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287619; x=1788892419; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9VUvDbf3E2nKoTmVYQrmSHKT4QnmOkpOBGtUWeCA4o=;
        b=u/JOSORtw8fk4OZn1Hc/ney6VQQsU4rzWswgwD/YpprKvZW4n4baxqdIF9SdJPH9ne
         aLw0CBf3DCzAQa2GHbffyXF/N9TAOWZgL42gFXI2gS0ROFw1GdZApbeV9YXJrt5uoGHD
         T6Z5Er704axq4FTrV6+1ep26ySsgJmKl6PuepdjyW6pKjmmcTect0l5u3On8uQYf2jqz
         2CBPPD2JISB2JTmxYee+1OrNTV3aOCnZEvGYrC8UVskTYNo5v/VyhnH3ZBESa29feNoc
         suNITQCxoIA7o9hwtK7BvlGNi1ZWtfxOadmlC7LOpmON3fEmBgP+PI1bC/ds+JNfz71h
         8jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287619; x=1788892419;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9VUvDbf3E2nKoTmVYQrmSHKT4QnmOkpOBGtUWeCA4o=;
        b=Ba3T22AF8kKK0HEztM/vxp6RW64kIwMuyj+A9jmwuWSKqVHrtJYcowpfvTb35nyoXb
         v78bMM+E1M1ZvskfrD8BKF/4VHgh8zD4ztkI9ruOLDdHeNVq0csxdWLwo744tIxPMg8z
         GkQfvHcgRIF+B3ttlxXL+d/Kj61ZZ4kFIE/4d2Z9lsrXSOPL+1um6AttTD/f0EW030HZ
         jMhWCY/NKVJEA8Hf9Ea+rfNR68ddV5nUI8AOevpV3sKDQ+DNf/VUd+Q2+6aqiGzCzhn+
         YPsaNe4sxk05A/4oI+awXsKjiPjeZZ1TD4+XajMes8doKifciOTxvKD5yHLx+t7Ea6RG
         9lHA==
X-Forwarded-Encrypted: i=1; AKwUvBzTouwMRIzg2/1Huq+qiF9Q8bVNmmmPqzDNTFgSuRfV4wG22qT1j0PXNNPYN/K0g+SGo9c1gfs=@vger.kernel.org
X-Gm-Message-State: AFuF++nlYjsgSWYLeuUbwJ0yBWbmCF6EYjUwT5aZkeSgfKecKrGXPUlm
	eNJNy8H2MISNoz9PwwXQcqspRBXEf/CQxmJk8HeBclQkxAW575jyPVHBJbYGs/q9yJr1dPwuMm6
	HQFhC8w==
X-Received: from pjbjs3.prod.google.com ([2002:a17:90b:1483:b0:38e:b97a:cfa1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc2:b0:38e:57a3:f218
 with SMTP id 98e67ed59e1d1-39907df005bmr16938091a91.13.1788287618820; Tue, 01
 Sep 2026 11:33:38 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:33:00 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-12-kuniyu@google.com>
Subject: [PATCH v5 net-next 11/15] neighbour: Convert neigh_table.entries to refcount_t.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
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
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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
2.55.0.966.g6673acef38-goog

