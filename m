Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71F49E5E1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287618; cv=none; b=uu9rKkyiFIiAMvfyT6dDhzAxGFNAbi8Qp/GCNHpDzSU0k2L1uFuPovknB/Fve0tYtVPrGjXgnQtfNDYEVgEE6flP4aUGHlgoRoLIRofP+uEtdLFYRTmwyIAE5TF5BkGhsbrMcJByVWnRGvxnCkKM+xzxWPuO+jwOWUhT8VObZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287618; c=relaxed/simple;
	bh=yImDRZUyKpQTDEGn//ID0TBu1f/OV6P5lKg21Z+hi0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cer4wPcC38FVu0IvirUFUl1GmKX8Yu7oQJ5kFibODLz+EWgmSp12c0KZzYBhifQt/wN1zQdWBNZJ0cmGvY3z26VSzLGON97yb269WQNO6q/Rv3BR+aST0VYAQavvnCBEyGoJWq44Xl1gtwdmvSjR/Iw/m7lEVOI5M8YOjJbBkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dmq9+FdU; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dmq9+FdU"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so170947a91.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287616; x=1788892416; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfzNU8aR0UmI3WAKG7LM/B8mxRkiAX1USSxyOdmSxII=;
        b=Dmq9+FdULkiGmBzLBY9dTasUEGMpqPQ5iKZdgz3QeQsbEwSgiSQbKDhECzh+zTEc6e
         FrCGYonQL2UNKPyDk+MLCb1doQVAVoYaKZ2fAizjZ0uZ0WSzhi+EuvqVbJLuNURJQ6q3
         AY9x9tnqbVzDbRXlD9K4UnP69eY8baS5u9/CK57QAyvLlHnCXgu7FGYpov8fg3Fo1yLz
         UwYj9xRndu36e3Rx3odMdP5YKilW7bZ9QH3O9Q8QoiINf5c2LcinL5SVq14tn0f5SqqL
         7opxONwzQ9shVcDNyToS/l6VCb551PUP7M5iLRSrgiV7H5LX7hY/wzAqnNBeHHSEFJgm
         yTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287616; x=1788892416;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfzNU8aR0UmI3WAKG7LM/B8mxRkiAX1USSxyOdmSxII=;
        b=keJNwNV7weghsSWVqR1Z9aB/oWPecsYhbq1nywTMwXbR8pTLJnhKQK/Gd1nDXSVVuT
         yk+/bHmhI1knSgaotOaclo3srXvBUih9mbbyObhbhFJgEEN3ywGuFJkwHB7Pycbwx1xj
         pi1hVwyz6SnyhGfZQhuccpZ1+deBLpZwTWKKD1YnYaPjZycfjcAtNa/saZZDU36m+wyz
         mjIxPeC2MbJopupndIkRbJSbQEL6DaF//4/0HfkamjpJF4b08Om6yJGJLQ2SgqNbUCqU
         UoES3TY/bJu9C0vEKEkj1jpeWhHI3+YxiVKm2yQmjtgwq/+xBvdZj5BEnfdJWzN08N2T
         DdEA==
X-Forwarded-Encrypted: i=1; AKwUvBz4xV3/D36VeUA+UAGTGwZIvO+S3+8RcpeD6VQA+v8BJIe+a3DpGDHDJ/tG7r9cGLZhRfcR6fk=@vger.kernel.org
X-Gm-Message-State: AFuF++nkdnkb0/MzmfR+uruBycj9S3K6xovyUkq6K0TMhbC3LvpxCgVi
	a74Re4CTfptMkjQPBb6P8Cp/sDASELYgv9/lzuA38Zsh4oWlek0nPp9Xra+L6V4qtsi4dErcF9Q
	UplSb0g==
X-Received: from pjbin17.prod.google.com ([2002:a17:90b:4391:b0:381:171e:961c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8c:b0:392:6638:2e6a
 with SMTP id 98e67ed59e1d1-396d0f69d10mr44867886a91.13.1788287615449; Tue, 01
 Sep 2026 11:33:35 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:56 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-8-kuniyu@google.com>
Subject: [PATCH v5 net-next 07/15] neighbour: Remove neigh_tables[].
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

Now, &arp_tbl and &nd_tbl are stored in net->neigh_tables[].

Let's use net->neigh_tables[] in neighbour.c and remove the
global neigh_tables[].

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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
index dc4c083fe27a..ed07cf78d223 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -2022,7 +2022,7 @@ int __init ndisc_init(void)
 	/*
 	 * Initialize the neighbour table
 	 */
-	neigh_table_init(NEIGH_ND_TABLE, &nd_tbl);
+	neigh_table_init(&nd_tbl);
 
 #ifdef CONFIG_SYSCTL
 	err = neigh_sysctl_register(NULL, &nd_tbl.parms,
@@ -2055,6 +2055,6 @@ void ndisc_cleanup(void)
 #ifdef CONFIG_SYSCTL
 	neigh_sysctl_unregister(&nd_tbl.parms);
 #endif
-	neigh_table_clear(NEIGH_ND_TABLE, &nd_tbl);
+	neigh_table_clear(&nd_tbl);
 	unregister_pernet_subsys(&ndisc_net_ops);
 }
-- 
2.55.0.966.g6673acef38-goog

