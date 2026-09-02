Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FDC4AA039
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381504; cv=none; b=BBKTud1IbZXcv1PlN9gTMkHXCf/dfUulIBSNdCAN4V3BgJt2P4Lsenine5g9tvkIr3fD0Rxfu/kcmmFz9ZvSvzh5ycSWoULqRpY7IirrW6CGZtwaHldcpFpcB6rRkjz13Uaup3r3ehRlzrPYpL7l8q0sT6Zp794X1SiDM7B+tAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381504; c=relaxed/simple;
	bh=gbgVei+vPWHK9QjfyceL8ugTNWL1tb0BJut3C50AuAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhK+UDpKHWnEAWOcRDxi7v0yW3mEsdx1OmvuikHIMat6mRiBnnt8C6IcPHUzpjIv+BACTWtK/Oz/foLRHIAfaGaq6e9e1kchco4IP4BLhyel6NNdg9Pio8cV1/vaSobysHUdEaMt0RPsdDYbumUdNIXHuKJ7NiuHtOffyQ9Ef6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foxyn+HD; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foxyn+HD"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6fb956002so22247665ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381501; x=1788986301; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nULr4SaoAFLkPoCZGSMkQxNhkYpO3/onyN0i7cuBWo=;
        b=foxyn+HDB5h3QcSpcWKNrBDTMffgr6Mdo0+oJRA6oZ2BVa9vNnmcqjdH12FPjNZjSm
         8drpvXLZiCBPunrk2wYIDDR3o+0dHwZ1EM+iAjajGAox/OCUEN/TgLsGKmUtnR/ghb71
         eKXyqDCl2UoEU3PmqZDEZn2k5f2l2MBruhLNmSzxY2k4Z8khUGPGwrpQMCMxdkw+l573
         I9gWIlCw5DPyXKk9tGCJyJm4/UMjmCJuuJNf/5zdse38oQNsL/vDjLsaju5PpGrgG78t
         AkWNV1vvVdrxPPAAtTtBU36J7H6LHWDyZcj7Vtm1RPSKKtQZD3zwsMO/zDcLxkILav6v
         Gv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381501; x=1788986301;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2nULr4SaoAFLkPoCZGSMkQxNhkYpO3/onyN0i7cuBWo=;
        b=LO1DfFCh4nz9ZYc6b1RkGoi4fxRF4Zq5DKLNzUFVhnp06sTRABn0w9s2++xT3NRP5i
         sQVye9iW38UmXe2D1evJw/XPLOmxpEmi6Oq53YRbnEo82pM5IgWihb2tqdFCzDOX60IV
         uDn0usGZnRTYBfN1kDcTFcmcjt/QF9kGnoWr/aO0yIjpUrhMw3N3OsEd1MLNK7eE8F1K
         qFzZer+j2fRQdNZxPhusTZ8uGcp6iyOmR8YpqPYdqg1yog5WqKztbNJHSYmxHb+F1E3w
         wetweKXmYY6TBQxoBbKJ+pZABBK1uL/CyEJNcn7WTovekGrHl5QS4LQDyCuL39EtIcbS
         5+uQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0sY290aU5l8MYT+rEZTCE6iDccWwdkYg2+tlOYceTIMIf0ZyVl4pDXxCE6kUPZTA+N3fw+/4=@vger.kernel.org
X-Gm-Message-State: AFuF++ls8jinUmzWWipd0B3nLJD+KmReA+nIQJMoTPTrQjMf8NS5kJE+
	8M2a/FIvOnUGO1hM96cWmi4yD/0zadCKafgsaaNv9zchSqSg7ZdGdO8gxfvH4ncbwV3dOQmevZz
	2GUWZPA==
X-Received: from plbmi16.prod.google.com ([2002:a17:902:fcd0:b0:2bf:8db:4516])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3546:b0:2da:f3f6:7cb1
 with SMTP id d9443c01a7336-2daf3f6828amr69872505ad.19.1788381500661; Wed, 02
 Sep 2026 13:38:20 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:54 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-14-kuniyu@google.com>
Subject: [PATCH v6 net-next 13/15] neighbour: Don't store net in struct pneigh_entry.
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
index 414422bcc0ec..9649b979918f 100644
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
@@ -2049,7 +2041,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (ndm->ndm_flags & NTF_PROXY) {
-		err = pneigh_delete(tbl, net, nla_data(dst_attr), dev);
+		err = pneigh_delete(tbl, nla_data(dst_attr), dev);
 		goto out;
 	}
 
@@ -2145,7 +2137,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto out;
 		}
 
-		err = pneigh_create(tbl, net, dst, dev, ndm_flags, protocol,
+		err = pneigh_create(tbl, dst, dev, ndm_flags, protocol,
 				    !!(ndm->ndm_state & NUD_PERMANENT));
 		goto out;
 	}
@@ -2891,11 +2883,10 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
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
@@ -2906,7 +2897,7 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 		for (n = rcu_dereference(tbl->phash_buckets[h]), idx = 0;
 		     n;
 		     n = rcu_dereference(n->next)) {
-			if (idx < s_idx || pneigh_net(n) != net)
+			if (idx < s_idx)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
@@ -3165,7 +3156,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
-		pn = pneigh_lookup(tbl, net, dst, dev);
+		pn = pneigh_lookup(tbl, dst, dev);
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
 			err = -ENOENT;
@@ -3365,7 +3356,6 @@ static struct neighbour *neigh_get_idx(struct seq_file *seq, loff_t *pos)
 static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
 	struct neigh_table *tbl = state->tbl;
 	struct pneigh_entry *pn = NULL;
 	int bucket;
@@ -3373,9 +3363,6 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 	state->flags |= NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket <= PNEIGH_HASHMASK; bucket++) {
 		pn = rcu_dereference(tbl->phash_buckets[bucket]);
-
-		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
@@ -3389,21 +3376,15 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
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
2.55.0.970.g62bdec98f9-goog

