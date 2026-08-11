Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81139021D
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415098; cv=none; b=ZkNNAQRwgizWV0J1RdtsXXGh2T8yXow4O/B6XS24Su1URpeDpcqPISoetAJFHb3c42TaB5knNwpq91XDCacrukzbyXjwRxoHmQ88UCFXJ71TZzsCnrxkq0t8rMkC1QDMAu2xIAL583m8drBnKj+ZzAsO+qnO/cmNfjA0uSQO1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415098; c=relaxed/simple;
	bh=5XyKS5mZGHeeaE5lEtWrawjVFVXrUQT/YEO8BLM9gUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CQTHM/LzZqH8u5BiAPks3DvAAMudVxMAhlXuKQ4rdYc92yAfCfCvRrwurzdCjxPOG6KkXDjiHus9JtLqr1tH0MrLGfkuOHg3UqfYr8t7iiOd+qgkFxHQygquq+QJMo3C1qwUbPJcD7O0JijZ8dawP29CumAkAoBKZN0kRcHaIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7yv8mJi; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7yv8mJi"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso2133512a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415096; x=1787019896; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WP+syNrPVT5NyOtwSWZhGxhwL1VRsixXUdLfY3dQx8o=;
        b=D7yv8mJiBJZfUxrHIjFZcBFKxLmEd4rg2ZNkWIC1UWVbRRj55o3W+D1RUAQjdRxJCH
         98/GQn954CTUmQSq/m0wTitf9kNXALR2glxrDmjR8kGx9jA8+6T5tLf7efQxwLNbPtjV
         8ypJQCtePPvi7UZ8jsHINcQRQte1QZ4o6eMDM4IyEmqzlLrCu8sZDzXbAj1ebni1JRML
         ZRXfyR1+GorPJDFeV7hxcHItjqmjI/cCVjavTVpkhmYlY+d+1YRb0v7IJjP4qFYe7gJ1
         /rDNB51uu+zls42ENO+wGwYMLhAQF5FOSj49KYxX6NMZIQrNQ2I6FzzsfNJeTcQyXXx7
         K2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415096; x=1787019896;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WP+syNrPVT5NyOtwSWZhGxhwL1VRsixXUdLfY3dQx8o=;
        b=hxNSyYBy+lcgy19ehiqTweeCmR3PYkQ3dbLT7YbCzTnQlbUQMJ41GjZj0vXcPg6uA0
         8lvFQHbc+zBVKzuWnNbiY4LILEazLYQCfLCHzFUd1CWYWZpZKXAkaW0u9ilKMo2HjFXz
         aA+KNHk6D1fSBbz9ytjln6GtGFIsZpcrdMtnO6pqebEOavJyp9xQjnACD5Zlvgv7P3DY
         rGYz9vzKPN2rNFk/Y8jD1PJ0hXGgEl9kAgO+Xh0qPhT6c/1nHLZikXbKlxnUkcp/RjTm
         Vq3kJKOx3davYwQ9VLc93dunsUz4FlGf4QEJUphN0IRCXFHi7+1OMno+2ipX9mCnXuKv
         5V9g==
X-Forwarded-Encrypted: i=1; AHgh+RrVl/5+93QczIpjqESB2mG7730xi/xBgqGmicktlPhpsBRpEWQ20OA0RaP4Ly1WbclKY6RpiC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/p6OsYlvb/zpLb8k+074ELML8wLFyLgy2M0d6xZgOqctUhCO
	KP9Ry88WVVCHQvmua3fIVQy74chHOUSs3Hi+VXGugyq+GI3pbZcxyLYNzuBvaeM3P2ZsMzVgfHx
	ffYOzmQ==
X-Received: from pgkg21.prod.google.com ([2002:a63:fa55:0:b0:c7f:cbe1:2d84])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:608a:b0:3c0:b55a:80ff
 with SMTP id adf61e73a8af0-3cc2bb017d4mr370892637.24.1786415095564; Mon, 10
 Aug 2026 19:24:55 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:39 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 05/15] neighbour: Remove __rcu from neigh_tables[].
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit 1bf20cc62a54 ("neighbour: remove obsolete
EXPORT_SYMBOL()") unexported neigh_table_init(), neigh_table
cannot be registered dynamically.

Let's remove RCU protection for neigh_tables[].

Note that neightbl_set() no longer needs RCU because it holds
spin_lock_bh(&tbl->lock).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6fda0052027b..caa52bf64a2d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1807,7 +1807,7 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
-static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
+static struct neigh_table *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
 
 void neigh_table_init(int index, struct neigh_table *tbl)
 {
@@ -1864,7 +1864,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 	tbl->last_flush = now;
 	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
 
-	rcu_assign_pointer(neigh_tables[index], tbl);
+	neigh_tables[index] = tbl;
 }
 
 /*
@@ -1873,8 +1873,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
  */
 int neigh_table_clear(int index, struct neigh_table *tbl)
 {
-	RCU_INIT_POINTER(neigh_tables[index], NULL);
-	synchronize_rcu();
+	neigh_tables[index] = NULL;
 
 	/* It is not clean... Fix it to unload IPv6 module safely */
 	cancel_delayed_work_sync(&tbl->managed_work);
@@ -1906,10 +1905,10 @@ static struct neigh_table *neigh_find_table(int family)
 
 	switch (family) {
 	case AF_INET:
-		tbl = rcu_dereference_rtnl(neigh_tables[NEIGH_ARP_TABLE]);
+		tbl = neigh_tables[NEIGH_ARP_TABLE];
 		break;
 	case AF_INET6:
-		tbl = rcu_dereference_rtnl(neigh_tables[NEIGH_ND_TABLE]);
+		tbl = neigh_tables[NEIGH_ND_TABLE];
 		break;
 	}
 
@@ -2391,10 +2390,8 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	ndtmsg = nlmsg_data(nlh);
 
-	rcu_read_lock();
-
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
-		tbl = rcu_dereference(neigh_tables[tidx]);
+		tbl = neigh_tables[tidx];
 		if (!tbl)
 			continue;
 
@@ -2408,7 +2405,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (!found) {
-		rcu_read_unlock();
 		err = -ENOENT;
 		goto errout;
 	}
@@ -2537,7 +2533,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 errout_tbl_lock:
 	spin_unlock_bh(&tbl->lock);
-	rcu_read_unlock();
 errout:
 	return err;
 }
@@ -2589,7 +2584,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
 		struct neigh_parms *p;
 
-		tbl = rcu_dereference(neigh_tables[tidx]);
+		tbl = neigh_tables[tidx];
 		if (!tbl)
 			continue;
 
@@ -2949,7 +2944,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	for (t = 0; t < NEIGH_NR_TABLES; t++) {
-		tbl = rcu_dereference(neigh_tables[t]);
+		tbl = neigh_tables[t];
 
 		if (!tbl)
 			continue;
@@ -3162,7 +3157,7 @@ int neigh_xmit(int index, struct net_device *dev,
 		struct neighbour *neigh;
 
 		rcu_read_lock();
-		tbl = rcu_dereference(neigh_tables[index]);
+		tbl = neigh_tables[index];
 		if (!tbl) {
 			rcu_read_unlock();
 			goto out_kfree_skb;
-- 
2.55.0.691.gc56d675ccc-goog

