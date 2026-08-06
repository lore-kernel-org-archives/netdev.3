Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03D3B9935
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978726; cv=none; b=c4RUs9x4V4Sn0NXU4QE+u6wb1LeRW/dGsovr/cSgWIzTA2wg2Z04FlA+fyFAzy5jx4xNfLOylLeB7z/5OisPml2Rf+y9Ecun2Igjt9vs4CLpxwwPbpC1OEHlPxVh+Z29Y4JhwvDGHQvjJc0jyk+dh32HnRfzywO0dUdY8J65Lz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978726; c=relaxed/simple;
	bh=qBy5P/j7qRz14q7O0BHspiQXNdYCRubr1T20+EZo1Gs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sPA+hDVH+ndl4tMY1+DqQLWv/zRvvoGSCvGdUSryHNNqfZnV6hkoSHMmxSPd8qkVpz1JUIrK7T7G9FOdzVonh2sAqv+RB53Aok/lC+wIAtRJfweidIfD1gcilDXaJCGhlw+oTDyHEHqgG4tpa3wxPQYHt5bw2TK9cQX5RYlMXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdMRCDlH; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdMRCDlH"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so2636189a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978724; x=1786583524; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILT7i5fbiVzR7+4EUKU/rRBqbduGqrluB3i/MyKTKrs=;
        b=BdMRCDlHEsZ+ZAkvLxBdx1dx+HwBeiWceUmFqZtJeTaPs40pbdnUQFutvzlqRwpdnM
         tMgshVjACZUOEeJqf1obftlxRXb+RCIyF7XBcmteTfgfEWGOlPwOKZxSwHDnbJMYR2mY
         qW2kkU6nC8pdmZCKtfaIcvsYVQlF7LG6PNaxnjYS/l5vFGcss23vlrvbzdR8rzugo8ub
         /5Uc9++NKRYfNRd4v9/WYIRDi7bcb57DBUwjL3OaRTYdves5dLYETe1FYi7ug+s3XxVi
         NDaUqYyfMQ0Zj6jnUOjKJ8hXCTLErHqM5NroozpV2uGNDxeJCsD0vI16anKchzuubN7V
         pmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978724; x=1786583524;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILT7i5fbiVzR7+4EUKU/rRBqbduGqrluB3i/MyKTKrs=;
        b=UdxMKlbTPU+JQJ4qtMmcv9LwHFNegliv1Jat25aug43yrychL/39+1NEYBchk7TRl/
         A0bE/05+qjLMAr4bqbr3D9RxcHCOmhpRpHlIdv6Y6PJ7toLMmtLXgDaun1Fk6YIHs7ts
         ZHRLPlby8pyVtKYJw1icmyjycp+YrXyFNig0Sabv4stFIpu1QWQOZfAJKmJkkE2+TfEY
         u5MHE3kxQhVw86TB6r7pRkCYh/nTyJVUbHeVbKmONRLOxmJXe9HO4lEWXqYboodhTHK8
         j94swNNtKSOSJGF4OM6AtrXqgr9ShWfUSzPCScviRN1HCrzpnaeIFqZwJLOEE5AzhdHj
         6sEw==
X-Forwarded-Encrypted: i=1; AHgh+RoUQPDiHuvNt/U8gK10w6g6ORBco/9OLns2rytVjgtIHqyRA8Uop1C5HNKrLSOuZyXqG2aa0yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydfFZY0+RNAu7DnPznx0w04JoT0dX5UGVfuExiEndTEsPDLDUd
	vYLsu6/jsNfI49Kt+QxVredL11/n6nw2/SsqUBCSBAl5245MPoy68J15hrmv06klrE2nUJe9/58
	h4KtD9g==
X-Received: from pjhz8.prod.google.com ([2002:a17:90a:5408:b0:38d:f086:96])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2785:b0:37f:e1af:df22
 with SMTP id 98e67ed59e1d1-3903c5f03a0mr12358543a91.17.1785978723773; Wed, 05
 Aug 2026 18:12:03 -0700 (PDT)
Date: Thu,  6 Aug 2026 01:11:33 +0000
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806011152.1170012-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806011152.1170012-12-kuniyu@google.com>
Subject: [PATCH v1 net-next 11/11] neighbour: Remove unnecessary net_eq().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now, neigh_table is per-netns, and net_eq() is no longer needed.

Let's remove them.

As a bonus, each netns can configure the default table param
(ifindex==0) and GC parameters via RTM_SETNEIGHTBL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 64 ++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 47 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 481f781e7ce8..b2bedad75dd3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -334,8 +334,7 @@ static void neigh_parms_qlen_dec(struct net_device *dev, int family)
 	rcu_read_unlock();
 }
 
-static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
-			       int family)
+static void pneigh_queue_purge(struct sk_buff_head *list, int family)
 {
 	struct sk_buff_head tmp;
 	unsigned long flags;
@@ -346,13 +345,11 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 	skb = skb_peek(list);
 	while (skb != NULL) {
 		struct sk_buff *skb_next = skb_peek_next(skb, list);
-		struct net_device *dev = skb->dev;
 
-		if (net == NULL || net_eq(dev_net(dev), net)) {
-			neigh_parms_qlen_dec(dev, family);
-			__skb_unlink(skb, list);
-			__skb_queue_tail(&tmp, skb);
-		}
+		neigh_parms_qlen_dec(skb->dev, family);
+		__skb_unlink(skb, list);
+		__skb_queue_tail(&tmp, skb);
+
 		skb = skb_next;
 	}
 	spin_unlock_irqrestore(&list->lock, flags);
@@ -456,8 +453,7 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 	spin_unlock_bh(&tbl->lock);
 
 	pneigh_ifdown(tbl, dev, skip_perm);
-	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
-			   tbl->family);
+	pneigh_queue_purge(&tbl->proxy_queue, tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
 		timer_delete_sync(&tbl->proxy_timer);
 	return 0;
@@ -751,7 +747,6 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 
 	while (n) {
 		if (!memcmp(n->key, pkey, key_len) &&
-		    net_eq(pneigh_net(n), net) &&
 		    (n->dev == dev || !n->dev))
 			return n;
 
@@ -831,8 +826,7 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 	for (np = &tbl->phash_buckets[hash_val];
 	     (n = rcu_dereference_protected(*np, 1)) != NULL;
 	     np = &n->next) {
-		if (!memcmp(n->key, pkey, key_len) && n->dev == dev &&
-		    net_eq(pneigh_net(n), net)) {
+		if (!memcmp(n->key, pkey, key_len) && n->dev == dev) {
 			rcu_assign_pointer(*np, n->next);
 
 			mutex_unlock(&tbl->phash_lock);
@@ -1737,13 +1731,13 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 }
 
 static inline struct neigh_parms *lookup_neigh_parms(struct neigh_table *tbl,
-						      struct net *net, int ifindex)
+						     int ifindex)
 {
 	struct neigh_parms *p;
 
 	list_for_each_entry(p, &tbl->parms_list, list) {
-		if ((p->dev && p->dev->ifindex == ifindex && net_eq(neigh_parms_net(p), net)) ||
-		    (!p->dev && !ifindex && net_eq(net, &init_net)))
+		if ((p->dev && p->dev->ifindex == ifindex) ||
+		    (!p->dev && !ifindex))
 			return p;
 	}
 
@@ -2461,8 +2455,8 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (tbp[NDTPA_IFINDEX])
 			ifindex = nla_get_u32(tbp[NDTPA_IFINDEX]);
 
-		p = lookup_neigh_parms(tbl, net, ifindex);
-		if (p == NULL) {
+		p = lookup_neigh_parms(tbl, ifindex);
+		if (!p) {
 			err = -ENOENT;
 			goto errout_tbl_lock;
 		}
@@ -2543,12 +2537,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	err = -ENOENT;
-	if ((tb[NDTA_THRESH1] || tb[NDTA_THRESH2] ||
-	     tb[NDTA_THRESH3] || tb[NDTA_GC_INTERVAL]) &&
-	    !net_eq(net, &init_net))
-		goto errout_tbl_lock;
-
 	if (tb[NDTA_THRESH1])
 		WRITE_ONCE(tbl->gc_thresh1, nla_get_u32(tb[NDTA_THRESH1]));
 
@@ -2631,9 +2619,6 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		nidx = 0;
 		p = list_next_entry(&tbl->parms, list);
 		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
-			if (!net_eq(neigh_parms_net(p), net))
-				continue;
-
 			if (nidx < neigh_skip)
 				goto next;
 
@@ -2811,12 +2796,11 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			    struct netlink_callback *cb,
 			    struct neigh_dump_filter *filter)
 {
-	struct net *net = sock_net(skb->sk);
-	struct neighbour *n;
-	int err = 0, h, s_h = cb->args[1];
 	int idx, s_idx = idx = cb->args[2];
-	struct neigh_hash_table *nht;
+	int err = 0, h, s_h = cb->args[1];
 	unsigned int flags = NLM_F_MULTI;
+	struct neigh_hash_table *nht;
+	struct neighbour *n;
 
 	if (filter->dev_idx || filter->master_idx)
 		flags |= NLM_F_DUMP_FILTERED;
@@ -2828,7 +2812,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			s_idx = 0;
 		idx = 0;
 		neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[h]) {
-			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
+			if (idx < s_idx)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
@@ -3234,10 +3218,6 @@ static struct neighbour *neigh_get_valid(struct seq_file *seq,
 					 loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
-
-	if (!net_eq(dev_net(n->dev), net))
-		return NULL;
 
 	if (state->neigh_sub_iter) {
 		loff_t fakep = 0;
@@ -3326,7 +3306,6 @@ static struct neighbour *neigh_get_idx(struct seq_file *seq, loff_t *pos)
 static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
 	struct neigh_table *tbl = state->tbl;
 	struct pneigh_entry *pn = NULL;
 	int bucket;
@@ -3334,9 +3313,6 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 	state->flags |= NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket <= PNEIGH_HASHMASK; bucket++) {
 		pn = rcu_dereference(tbl->phash_buckets[bucket]);
-
-		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
@@ -3350,21 +3326,15 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
 					    loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
 	struct neigh_table *tbl = state->tbl;
 
-	do {
-		pn = rcu_dereference(pn->next);
-	} while (pn && !net_eq(pneigh_net(pn), net));
+	pn = rcu_dereference(pn->next);
 
 	while (!pn) {
 		if (++state->bucket > PNEIGH_HASHMASK)
 			break;
 
 		pn = rcu_dereference(tbl->phash_buckets[state->bucket]);
-
-		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
-- 
2.55.0.679.g6767b8d81c-goog

