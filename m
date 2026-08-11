Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048D3914E2
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415107; cv=none; b=LHSDcK8e2cRaV/7ydofuRjjL44p5nYSPaQcTHWz7WBCM5MqUUK/8q1OWM8LegZfVnfrvcSdoORLgOidpP6eZd4oh+9/hTUa9PPNYZ6zJXDbWF0kQMQOjINp+/fhKipH+T6UpK7eUQAxUVIUm+PqoE4lZWtnYFkaUHPBwvF7bLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415107; c=relaxed/simple;
	bh=wK3alYQKNfVaxH4WhMxq+teHvRskGu596Lv2tScZBQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YxtAxQX46NuPKg85mEvwbDaVtjeg5W1gPEYB7l3BOJyoqoXDDnnk7/wpd1ACmq9uJdCoE141xKslzzqukGr4lC7UMbPGFVCnMkHaEdOOvkwqmzJwwt99Y9luzIf6wUWixO8aKRL4mI7IP9ufy2F1vAUbWRWg0zmh84Td2+DWNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4bYMGTX; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4bYMGTX"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84885a4fcabso2785055b3a.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415103; x=1787019903; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7mDR+eQDxG2PnoJFk06xICcS3NzqfzYfozghOisjzYE=;
        b=U4bYMGTXGRYOZlFUsADYeCCJm4/wTFDKh0xke72ISxAYXCBBMdTkAmrS5zVYUZv0SO
         y1LNYoTkDyUe7rmzhoS/0DNbAwhgE4VRPEfUjKvsIWW04Qbx4MxKKVFekmQBU04we/i8
         upMxtIDbSnE4zEh2vzpWJCNb6ctxww+dTHjdjuOFhEVqQgeBZgrnkUSqtU8+U9xG0nhP
         QcG/KP81fCQuHgHzuOeF7hMkwq+gwo7OfkfbfIxOefzdlvZFDIdswatJ9uCuw7gQ28OS
         iFA17JriN3E7/ULWGFFhg0SGE51M0e9zn10cuMHhTN29YauF4SpWChDtmbKElqe22mTF
         g63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415103; x=1787019903;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mDR+eQDxG2PnoJFk06xICcS3NzqfzYfozghOisjzYE=;
        b=myGMaVgD0JDosGisOmhwFz6gx2q9qR40jEwlTtW3Td2LDEFBwZBU7PmJWF8ERq5Ief
         A1brvIAhxEbiyennt4PsVk0e6b7MyVYwXxnofa29t88siG/lqeYTqzwoLbT99DiMSG+o
         TgnsjVtFYU4CXZLdAItTR+qK93A07e8FdIuWZ3NoZtL6+4+AyIjkcB1SRNR6CdvFHbjE
         y7ymeNMYuEIm2yqP4MrVQCWFFhRR0VihNrI/7n1xHmGcMAuUTzPLwLfp2ctnehReaNLY
         DbZE45z6IkP84fZ0qZpY9OadMTCyuM9dG5bwTIQnE8WJUKScpJqRV7KHuQYAb8WRtnIT
         w4Ig==
X-Forwarded-Encrypted: i=1; AHgh+RrRQEDfd8dojps4n859EM+DhgxJlNS+oA0IRHMazBxo2EHQKyJHLll+KHhjkOTDToB11U1Ayfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQGpfwtEVfi1rzgNbIIuxo/1druv04QPPK5vc7fRPC2kV6psA
	mRZp5POOCYGXLci28SXJhuEjxbqUWsv1KlF+dgzSSW5SoB7RY0njUbkb+SGNp6i24/Ol98a7uEZ
	/Pm0noA==
X-Received: from pgja13.prod.google.com ([2002:a63:cd4d:0:b0:c9e:142c:425e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4305:b0:3c6:3c5b:f2e1
 with SMTP id adf61e73a8af0-3cc2baed774mr257824637.32.1786415102529; Mon, 10
 Aug 2026 19:25:02 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:47 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-14-kuniyu@google.com>
Subject: [PATCH v3 net-next 13/15] neighbour: Don't store net in struct pneigh_entry.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_table is now per-netns, so struct pneigh_entry does not need
to store a net pointer.

Let's remove it and net comparison for pneigh_entry.

We no longer need to pass net to pneigh_create(), pneigh_delete(),
and pneigh_lookup().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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
index afe7205b5292..132fcc51f4e2 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -179,7 +179,6 @@ struct neigh_ops {
 
 struct pneigh_entry {
 	struct pneigh_entry	__rcu *next;
-	possible_net_t		net;
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
 	union {
@@ -389,19 +388,14 @@ static inline void neigh_set_reach_time(struct neigh_parms *p)
 
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
index 7a6cbadedc88..9cb8e68246a8 100644
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
@@ -2026,7 +2018,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (ndm->ndm_flags & NTF_PROXY) {
-		err = pneigh_delete(tbl, net, nla_data(dst_attr), dev);
+		err = pneigh_delete(tbl, nla_data(dst_attr), dev);
 		goto out;
 	}
 
@@ -2122,7 +2114,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto out;
 		}
 
-		err = pneigh_create(tbl, net, dst, dev, ndm_flags, protocol,
+		err = pneigh_create(tbl, dst, dev, ndm_flags, protocol,
 				    !!(ndm->ndm_state & NUD_PERMANENT));
 		goto out;
 	}
@@ -2874,11 +2866,10 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
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
@@ -2889,7 +2880,7 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 		for (n = rcu_dereference(tbl->phash_buckets[h]), idx = 0;
 		     n;
 		     n = rcu_dereference(n->next)) {
-			if (idx < s_idx || pneigh_net(n) != net)
+			if (idx < s_idx)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
@@ -3148,7 +3139,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
-		pn = pneigh_lookup(tbl, net, dst, dev);
+		pn = pneigh_lookup(tbl, dst, dev);
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
 			err = -ENOENT;
@@ -3348,7 +3339,6 @@ static struct neighbour *neigh_get_idx(struct seq_file *seq, loff_t *pos)
 static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
 	struct neigh_table *tbl = state->tbl;
 	struct pneigh_entry *pn = NULL;
 	int bucket;
@@ -3356,9 +3346,6 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 	state->flags |= NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket <= PNEIGH_HASHMASK; bucket++) {
 		pn = rcu_dereference(tbl->phash_buckets[bucket]);
-
-		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
@@ -3372,21 +3359,15 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
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
index 1ec32b3c0a7f..25fc57e52b5f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -581,7 +581,7 @@ int ip6_forward(struct sk_buff *skb)
 
 	/* XXX: idev->cnf.proxy_ndp? */
 	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-	    pneigh_lookup(nd_table(net), net, &hdr->daddr, skb->dev)) {
+	    pneigh_lookup(nd_table(net), &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
 
 		hdr = ipv6_hdr(skb);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 05db5bfb16dc..022c2296807a 100644
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
2.55.0.691.gc56d675ccc-goog

