Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231249EC49
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287623; cv=none; b=oe2NJmlSzV4Xh319Na2cchy87L+RcssKKjaf0yxk1qoKPq+270eNwdj6bwDaec5GLpPiu3WrY0BEO2i1cJKdbRqxtgGUqEC0cjqn2sydrP7asCkirJ6VWKwZZXVK+8vU6RX5pH6T3rXQKC3GllynnrxUgpTVfXtYRvxmpt68bz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287623; c=relaxed/simple;
	bh=R4bvr1z1GV75LfQyvblLPrV2jyJobzZkqPce4RSM8ys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qjl7xWoCGhm9HracOksQWELodTU6Kq7wradkeoWP8RQoavuKLOoimNnBCvmdU6JNm6aysqdiybKtqAluuks+f06vu8aiHrkbaDUO4dS1UMCHMfPn8kZ3pd7LUhqdgxbQak4ZdQgt0k+3RjjNJZF+b7dne1dJEy75VI9vRPGi7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATFi4BS3; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATFi4BS3"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1c1cc5206so208878a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287620; x=1788892420; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6T6BUYPn8C05hcFrPC9Aa8cNPufpbd2I67dhNrSaM4=;
        b=ATFi4BS3zhrmy+kWRSp6hmQZvYorAw6t87dwYXwfFD/TjbR1FSqHfLEND0vSi/TXLx
         z52pLJk9zI8v+9GPB+h+5mNegDDRp7BfQP+AZDkR2UIMExGvF7rVIbsoNF0JFaZFD37N
         oE9qBcjfvFzzpmp8dR8jIRJI9QVM6EdzRY+q2gR3NvRi+ipnBSeTqtrt6vysDchR2ENc
         8/guK5lB0H3hyeQHlFKieFhJbIxWYn75UYyAfC5lIEMOzd6APlOO2oos0bnKnsVJZdSK
         RFRjkQCgBr5aFu8+qaB7YvpN1/DyTPfKOfcXqHi33MhPhP4nBqC5v04Gy9Qk8ccJmWY4
         Qy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287620; x=1788892420;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6T6BUYPn8C05hcFrPC9Aa8cNPufpbd2I67dhNrSaM4=;
        b=YhJ1e7520TJCnhXNXM/nCLr/FtulFTylv0rxIopq4sRagNVBdcQGycRgfKehfaHtc3
         5A5T2bqMNLx6pveJtvGsLBbBnaKKanZjJsD0TREVMzmrfHfxHeLBddThg+Q9umA81kKL
         0EAN6UQAcrKcsinKUXSQLGRmZ/jaoaFWSKafItZVjAq073vOg5BQsL2nGsAiGCFXAl4P
         RYDdqxLHhkYDAvdeKQxvzy2qev2vSc37WvotTXUNUNKa1nUC4gdr/2GvndeAYXMrv21a
         xgysxT7Kx5Xjqi74qZn+pP181JjPPdSkw/su8I0YjUEbhp8psZqP67PoimhUusgpCgCs
         +fIg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0G/+O8Nsg+pegwsnTa/cie+YA84N99CefcYjVip6669w/RJJTxU9xPg0Gn6q2hYtCDq8dNP8=@vger.kernel.org
X-Gm-Message-State: AFuF++l6dnWM1ovrC3b0aO6/Yh0+J8DUBN2A1S5mphm0S74x85F/9T7F
	WDcmXg/nDUAzpubqrj64OV297xhE1NTbFEUAsW7wNes0yxNhPDt2aPIMt6hAOR1D2GRJBGYOeG0
	DdwKdNg==
X-Received: from pgae21.prod.google.com ([2002:a63:3715:0:b0:cc1:9356:5811])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:502:b0:3d1:2dc5:7d37
 with SMTP id adf61e73a8af0-3d266ebc204mr64011690637.3.1788287620305; Tue, 01
 Sep 2026 11:33:40 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:33:02 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-14-kuniyu@google.com>
Subject: [PATCH v5 net-next 13/15] neighbour: Don't store net in struct pneigh_entry.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

neigh_table is now per-netns, so struct pneigh_entry does not need
to store a net pointer.

Let's remove it and net comparison for pneigh_entry.

We no longer need to pass net to pneigh_create(), pneigh_delete(),
and pneigh_lookup().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2:
  * Split from the next patch
  * Remove net comparison in pneigh_dump_table()
  * Remove net arg of pneigh_create(), pneigh_delete(), and
    pneigh_lookup()
---
 include/net/neighbour.h | 12 +++------
 net/core/neighbour.c    | 55 ++++++++++++++---------------------------
 net/ipv4/arp.c          |  6 ++---
 net/ipv6/ip6_output.c   |  2 +-
 net/ipv6/ndisc.c        |  4 +--
 5 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 9ff62d1f8287..ed9d9ae6d3a6 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -181,7 +181,6 @@ struct neigh_ops {
 
 struct pneigh_entry {
 	struct pneigh_entry	__rcu *next;
-	possible_net_t		net;
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
 	union {
@@ -391,19 +390,14 @@ static inline void neigh_set_reach_time(struct neigh_parms *p)
 
 void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 		    struct sk_buff *skb);
-struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl, struct net *net,
+struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 				   const void *key, struct net_device *dev);
-int pneigh_create(struct neigh_table *tbl, struct net *net, const void *key,
+int pneigh_create(struct neigh_table *tbl, const void *key,
 		  struct net_device *dev, u32 flags, u8 protocol,
 		  bool permanent);
-int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *key,
+int pneigh_delete(struct neigh_table *tbl, const void *key,
 		  struct net_device *dev);
 
-static inline struct net *pneigh_net(const struct pneigh_entry *pneigh)
-{
-	return read_pnet(&pneigh->net);
-}
-
 void neigh_app_ns(struct neighbour *n);
 void neigh_for_each(struct neigh_table *tbl,
 		    void (*cb)(struct neighbour *, void *), void *cookie);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c181011744c5..7054b05625b1 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -351,8 +351,7 @@ static void neigh_parms_qlen_dec(struct net_device *dev, int family)
 	rcu_read_unlock();
 }
 
-static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
-			       int family)
+static void pneigh_queue_purge(struct sk_buff_head *list, int family)
 {
 	struct sk_buff_head tmp;
 	unsigned long flags;
@@ -363,13 +362,11 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
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
@@ -473,8 +470,7 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 	spin_unlock_bh(&tbl->lock);
 
 	pneigh_ifdown(tbl, dev, skip_perm);
-	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
-			   tbl->family);
+	pneigh_queue_purge(&tbl->proxy_queue, tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
 		timer_delete_sync(&tbl->proxy_timer);
 	return 0;
@@ -754,8 +750,7 @@ static u32 pneigh_hash(const void *pkey, unsigned int key_len)
 }
 
 struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
-				   struct net *net, const void *pkey,
-				   struct net_device *dev)
+				   const void *pkey, struct net_device *dev)
 {
 	struct pneigh_entry *n;
 	unsigned int key_len;
@@ -768,7 +763,6 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 
 	while (n) {
 		if (!memcmp(n->key, pkey, key_len) &&
-		    net_eq(pneigh_net(n), net) &&
 		    (n->dev == dev || !n->dev))
 			return n;
 
@@ -778,7 +772,7 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 	return NULL;
 }
 
-int pneigh_create(struct neigh_table *tbl, struct net *net,
+int pneigh_create(struct neigh_table *tbl,
 		  const void *pkey, struct net_device *dev,
 		  u32 flags, u8 protocol, bool permanent)
 {
@@ -789,7 +783,7 @@ int pneigh_create(struct neigh_table *tbl, struct net *net,
 
 	mutex_lock(&tbl->phash_lock);
 
-	n = pneigh_lookup(tbl, net, pkey, dev);
+	n = pneigh_lookup(tbl, pkey, dev);
 	if (n)
 		goto update;
 
@@ -800,7 +794,6 @@ int pneigh_create(struct neigh_table *tbl, struct net *net,
 		goto out;
 	}
 
-	write_pnet(&n->net, net);
 	memcpy(n->key, pkey, key_len);
 	n->dev = dev;
 	netdev_hold(dev, &n->dev_tracker, GFP_KERNEL);
@@ -833,7 +826,7 @@ static void pneigh_destroy(struct rcu_head *rcu)
 	kfree(n);
 }
 
-int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
+int pneigh_delete(struct neigh_table *tbl, const void *pkey,
 		  struct net_device *dev)
 {
 	struct pneigh_entry *n, __rcu **np;
@@ -848,8 +841,7 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 	for (np = &tbl->phash_buckets[hash_val];
 	     (n = rcu_dereference_protected(*np, 1)) != NULL;
 	     np = &n->next) {
-		if (!memcmp(n->key, pkey, key_len) && n->dev == dev &&
-		    net_eq(pneigh_net(n), net)) {
+		if (!memcmp(n->key, pkey, key_len) && n->dev == dev) {
 			rcu_assign_pointer(*np, n->next);
 
 			mutex_unlock(&tbl->phash_lock);
@@ -2047,7 +2039,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (ndm->ndm_flags & NTF_PROXY) {
-		err = pneigh_delete(tbl, net, nla_data(dst_attr), dev);
+		err = pneigh_delete(tbl, nla_data(dst_attr), dev);
 		goto out;
 	}
 
@@ -2143,7 +2135,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto out;
 		}
 
-		err = pneigh_create(tbl, net, dst, dev, ndm_flags, protocol,
+		err = pneigh_create(tbl, dst, dev, ndm_flags, protocol,
 				    !!(ndm->ndm_state & NUD_PERMANENT));
 		goto out;
 	}
@@ -2889,11 +2881,10 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			     struct netlink_callback *cb,
 			     struct neigh_dump_filter *filter)
 {
-	struct pneigh_entry *n;
-	struct net *net = sock_net(skb->sk);
-	int err = 0, h, s_h = cb->args[3];
 	int idx, s_idx = idx = cb->args[4];
+	int err = 0, h, s_h = cb->args[3];
 	unsigned int flags = NLM_F_MULTI;
+	struct pneigh_entry *n;
 
 	if (filter->dev_idx || filter->master_idx)
 		flags |= NLM_F_DUMP_FILTERED;
@@ -2904,7 +2895,7 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 		for (n = rcu_dereference(tbl->phash_buckets[h]), idx = 0;
 		     n;
 		     n = rcu_dereference(n->next)) {
-			if (idx < s_idx || pneigh_net(n) != net)
+			if (idx < s_idx)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
@@ -3163,7 +3154,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
-		pn = pneigh_lookup(tbl, net, dst, dev);
+		pn = pneigh_lookup(tbl, dst, dev);
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
 			err = -ENOENT;
@@ -3363,7 +3354,6 @@ static struct neighbour *neigh_get_idx(struct seq_file *seq, loff_t *pos)
 static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
 	struct neigh_table *tbl = state->tbl;
 	struct pneigh_entry *pn = NULL;
 	int bucket;
@@ -3371,9 +3361,6 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 	state->flags |= NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket <= PNEIGH_HASHMASK; bucket++) {
 		pn = rcu_dereference(tbl->phash_buckets[bucket]);
-
-		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
@@ -3387,21 +3374,15 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
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
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index f197051d3aa7..90bc53fb8090 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -868,7 +868,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			    (arp_fwd_proxy(in_dev, dev, rt) ||
 			     arp_fwd_pvlan(in_dev, dev, rt, sip, tip) ||
 			     (rt->dst.dev != dev &&
-			      pneigh_lookup(tbl, net, &tip, dev)))) {
+			      pneigh_lookup(tbl, &tip, dev)))) {
 				n = neigh_event_ns(tbl, sha, &sip, dev);
 				if (n)
 					neigh_release(n);
@@ -1094,7 +1094,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	if (mask) {
 		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-		return pneigh_create(tbl, net, &ip, dev, 0, 0, false);
+		return pneigh_create(tbl, &ip, dev, 0, 0, false);
 	}
 
 	return arp_req_set_proxy(net, dev, 1);
@@ -1243,7 +1243,7 @@ static int arp_req_delete_public(struct net *net, struct arpreq *r,
 	if (mask) {
 		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-		return pneigh_delete(tbl, net, &ip, dev);
+		return pneigh_delete(tbl, &ip, dev);
 	}
 
 	return arp_req_set_proxy(net, dev, 0);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 995fad3bf3b2..96ee3de55f93 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -583,7 +583,7 @@ int ip6_forward(struct sk_buff *skb)
 
 	/* XXX: idev->cnf.proxy_ndp? */
 	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-	    pneigh_lookup(nd_table(net), net, &hdr->daddr, skb->dev)) {
+	    pneigh_lookup(nd_table(net), &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
 
 		hdr = ipv6_hdr(skb);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ffb8a8b81821..90cd5d852569 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -771,7 +771,7 @@ static int pndisc_is_router(const void *pkey,
 	struct pneigh_entry *n;
 	int ret = -1;
 
-	n = pneigh_lookup(nd_table(net), net, pkey, dev);
+	n = pneigh_lookup(nd_table(net), pkey, dev);
 	if (n)
 		ret = !!(READ_ONCE(n->flags) & NTF_ROUTER);
 
@@ -1103,7 +1103,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
 		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-		    pneigh_lookup(tbl, net, &msg->target, dev)) {
+		    pneigh_lookup(tbl, &msg->target, dev)) {
 			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
 		}
-- 
2.55.0.966.g6673acef38-goog

