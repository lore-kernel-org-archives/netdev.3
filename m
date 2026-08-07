Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD413FA5DD
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145381; cv=none; b=hou2mN3v/8ZgPDaEtY1oyxxIOeFzx1k+apMPhKUvZyGNKsOCgTql4lXZUxZ2yZ9y6ZkaMDN6RxE+filj/IrJIARhHC01OI22d5D2wFN+UTT3USwNACrZj7Iem+CV/YYOhs6uzozZzuqYNfMv9TrCXqRJxW89fGJtyiPcjKk0HHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145381; c=relaxed/simple;
	bh=5ZbGpBxijKWkSw3SrMjh7xU+oFi1X4TtVJFUtQEt4xM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sMTZsS745AabdMcrHj9C3gnVbCIX9FJzJLrUUraVJmKTB7RH6C15i5XDr1QIRR9zhYbeht1Iw5QQ0TG9zsR9nmkcjHWE+BFVsbgNmsQgZDkVGH1g5sGcPaPR5ZsWTYrFwOjYSXhunJXmCYxod25nL1NysoNjoflKR+/WRsrksOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DK5kuYzn; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DK5kuYzn"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso60219a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145379; x=1786750179; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0oxIIPMSnel8T1Z0acpOQlIuNJ6zPBFkIf+UUtBGPo=;
        b=DK5kuYznQwQPfdcX7tW5daPWiNIh6iJ6LGIaRpD3kuQo8U3xjhr5OGmsjn1ycgHoz/
         j+xiPEC3z4ZAKN4ath5Ob5U4V4p0iJUk+Zz7B7H1X6KBygBZxxX53inelRgkfgAr/VZu
         q84pyeWBydNA454UyL+oPqaEh1tY4w1P+KMz81xln8l1sJpZ0/1nh2JYRjdJJEbxo8g/
         I/LAglxuF+QMjah8P6WvPuHX8DtE0Wpx7NJ0C92hWW+6pyyt49TVGgMXtIl+GTmrh2WK
         PbZ4A0w4euFIbQEhFwBEfCDgTQ2Jw/hv/+7f1o6ACjagOaXOQMiIPsdFkt0kaF1n6tmD
         Jhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145379; x=1786750179;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0oxIIPMSnel8T1Z0acpOQlIuNJ6zPBFkIf+UUtBGPo=;
        b=VyPVIKiiabaI6jPsR3fvl0bMFKskc9ClaCFwrobgiHSfBbArD/EqCLJwH64jb+YSGc
         cNttnT/KxgVQF0Ai64PYKVQdUDLcMnUumMgZ61zvpG7bCrxMHil3vLk3Wo3ztbbx4GvM
         CgLBCQU9UlSIAqPYNXk8FxljGDu70YwUFL1sdtcbZ9bu9Sg/iVAbxgwZV5AkJP8yNAVe
         IZLSxlV0l+p0flvUjRbH7rhfAXQEmwvpzPTJYzWWtTF4aR1vl4YvGcz4Ue1T1vlmieL2
         yX3XtYHIPxsI4Z95PKyYS3Wkp7gpp/+bjBj9aGr7n7uAze/kDwDc/kI2/M/uw6uuRG2J
         jOEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPDhizPRQdJQNVcdt+RkuYNIyRHQUvzgZuO2E5X4eXA0Vrwt6BADOkJnwp7izy4sbzWOfiZLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfwEhJZBOgZTYzrNBZmcgdEtp751i3ECcfkzCew52nrJoLDwI
	+fgLm6LqFhIyidy7mhzGD+us3oGbFFlboodGWIi+FmsdjR4ug4TgdpdeEVaX7ifkvbE2hUkw4JO
	T41pcAw==
X-Received: from pgbep6.prod.google.com ([2002:a05:6a02:2646:b0:cbb:8eba:c0a3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244d:b0:3b3:26aa:5455
 with SMTP id adf61e73a8af0-3cb85de8c46mr29930019637.13.1786145378890; Fri, 07
 Aug 2026 16:29:38 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:44 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/13] neighbour: Remove neigh_tables[].
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now, &arp_tbl and &nd_tbl are stored in net->neigh_tables[].

Let's use net->neigh_tables[] in neighbour.c and remove the
global neigh_tables[].

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  4 ++--
 net/core/neighbour.c    | 34 +++++++++++++++-------------------
 net/ipv4/arp.c          |  2 +-
 net/ipv6/ndisc.c        |  4 ++--
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 700d62605fab..3e31eebf8663 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -341,8 +341,8 @@ static inline void neigh_confirm(struct neighbour *n)
 
 int neigh_table_register(struct net *net, struct neigh_table *tbl, int index);
 void neigh_table_unregister(struct net *net, int index);
-void neigh_table_init(int index, struct neigh_table *tbl);
-int neigh_table_clear(int index, struct neigh_table *tbl);
+void neigh_table_init(struct neigh_table *tbl);
+int neigh_table_clear(struct neigh_table *tbl);
 struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 			       struct net_device *dev);
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 286acb7cd504..34da4cdc813d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1807,9 +1807,7 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
-static struct neigh_table *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
-
-void neigh_table_init(int index, struct neigh_table *tbl)
+void neigh_table_init(struct neigh_table *tbl)
 {
 	unsigned long now = jiffies;
 	unsigned long phsize;
@@ -1863,18 +1861,14 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 
 	tbl->last_flush = now;
 	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
-
-	neigh_tables[index] = tbl;
 }
 
 /*
  * Only called from ndisc_cleanup(), which means this is dead code
  * because we no longer can unload IPv6 module.
  */
-int neigh_table_clear(int index, struct neigh_table *tbl)
+int neigh_table_clear(struct neigh_table *tbl)
 {
-	neigh_tables[index] = NULL;
-
 	/* It is not clean... Fix it to unload IPv6 module safely */
 	cancel_delayed_work_sync(&tbl->managed_work);
 	cancel_delayed_work_sync(&tbl->gc_work);
@@ -1911,16 +1905,16 @@ void neigh_table_unregister(struct net *net, int index)
 	net->neigh_tables[index] = NULL;
 }
 
-static struct neigh_table *neigh_find_table(int family)
+static struct neigh_table *neigh_find_table(struct net *net, int family)
 {
 	struct neigh_table *tbl = NULL;
 
 	switch (family) {
 	case AF_INET:
-		tbl = neigh_tables[NEIGH_ARP_TABLE];
+		tbl = net->neigh_tables[NEIGH_ARP_TABLE];
 		break;
 	case AF_INET6:
-		tbl = neigh_tables[NEIGH_ND_TABLE];
+		tbl = net->neigh_tables[NEIGH_ND_TABLE];
 		break;
 	}
 
@@ -1974,7 +1968,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	tbl = neigh_find_table(ndm->ndm_family);
+	tbl = neigh_find_table(net, ndm->ndm_family);
 	if (tbl == NULL)
 		return -EAFNOSUPPORT;
 
@@ -2060,7 +2054,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	tbl = neigh_find_table(ndm->ndm_family);
+	tbl = neigh_find_table(net, ndm->ndm_family);
 	if (tbl == NULL)
 		return -EAFNOSUPPORT;
 
@@ -2403,7 +2397,7 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ndtmsg = nlmsg_data(nlh);
 
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
-		tbl = neigh_tables[tidx];
+		tbl = net->neigh_tables[tidx];
 		if (!tbl)
 			continue;
 
@@ -2596,7 +2590,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
 		struct neigh_parms *p;
 
-		tbl = neigh_tables[tidx];
+		tbl = net->neigh_tables[tidx];
 		if (!tbl)
 			continue;
 
@@ -2933,6 +2927,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct neigh_dump_filter filter = {};
+	struct net *net = sock_net(skb->sk);
 	struct neigh_table *tbl;
 	int t, family, s_t;
 	int proxy = 0;
@@ -2956,8 +2951,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	for (t = 0; t < NEIGH_NR_TABLES; t++) {
-		tbl = neigh_tables[t];
-
+		tbl = net->neigh_tables[t];
 		if (!tbl)
 			continue;
 		if (t < s_t || (family && tbl->family != family))
@@ -3079,7 +3073,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 	rcu_read_lock();
 
-	tbl = neigh_find_table(ndm->ndm_family);
+	tbl = neigh_find_table(net, ndm->ndm_family);
 	if (!tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
 		err = -EAFNOSUPPORT;
@@ -3167,9 +3161,11 @@ int neigh_xmit(int index, struct net_device *dev,
 	if (likely(index < NEIGH_NR_TABLES)) {
 		struct neigh_table *tbl;
 		struct neighbour *neigh;
+		struct net *net;
 
 		rcu_read_lock();
-		tbl = neigh_tables[index];
+		net = dev_net_rcu(dev);
+		tbl = net->neigh_tables[index];
 		if (!tbl) {
 			rcu_read_unlock();
 			goto out_kfree_skb;
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index bad17d5aeafc..824c65c70408 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1532,7 +1532,7 @@ static struct pernet_operations arp_net_ops = {
 
 void __init arp_init(void)
 {
-	neigh_table_init(NEIGH_ARP_TABLE, &arp_tbl);
+	neigh_table_init(&arp_tbl);
 
 	dev_add_pack(&arp_packet_type);
 	register_pernet_subsys(&arp_net_ops);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 951c0f484ae7..8e630b47c0b9 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -2019,7 +2019,7 @@ int __init ndisc_init(void)
 	/*
 	 * Initialize the neighbour table
 	 */
-	neigh_table_init(NEIGH_ND_TABLE, &nd_tbl);
+	neigh_table_init(&nd_tbl);
 
 #ifdef CONFIG_SYSCTL
 	err = neigh_sysctl_register(NULL, &nd_tbl.parms,
@@ -2052,6 +2052,6 @@ void ndisc_cleanup(void)
 #ifdef CONFIG_SYSCTL
 	neigh_sysctl_unregister(&nd_tbl.parms);
 #endif
-	neigh_table_clear(NEIGH_ND_TABLE, &nd_tbl);
+	neigh_table_clear(&nd_tbl);
 	unregister_pernet_subsys(&ndisc_net_ops);
 }
-- 
2.55.0.679.g6767b8d81c-goog

