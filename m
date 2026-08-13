Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527E43F4CE
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608180; cv=none; b=abjFEj07vnsD1Abx8YQReqMV8iBMkQ1WvYyZ9uhj1Lvp2JuVnxd2wdund5QACOY20hNvBfRDO+tgqCUHUgIwob3wySLx7Ckhl3AE0zbwQtYnKhucSSC4XpCJc8epuYNDlEmpJt0t4GKy64f6dRJ0LeUUTVK4R8dWkljyPfyAYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608180; c=relaxed/simple;
	bh=ipSboq/kc2aoiVizJ8rlb+gBJu9UNv6Y5rFgLGDYNys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YXlgGnIDzTstWIQ5PZ7Jwqq5mZdQKdvOuRplx3CqBOCWU8kLoEcviW7T4Szl71yRmxk0KdlcUcN/OGkBhKdRbkNM5Imml67D60k8gj1a41wx7vZVmvTE6ZoEIZQu93ldyRwEhewEgjmiPnQ42GYhPBdcmX90S15s0Sxoioy6eao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkXS50WL; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkXS50WL"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d04908139bso25882425ad.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608176; x=1787212976; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6SwGjkMBjgeTIPIBZLyXQnSRomAElVlQN8O05l/e5w=;
        b=kkXS50WLVMioFkg2a4VquahQv6BnBx1hNJr9XjRAjuVJnxcrxIu/znnvrK7qPuQVig
         fJrami44tOhQbUZN7Wg/DbkgXXa4otsiWiqb4fL1jSQkkoMnBmC7gePK39zfB6SOOnj7
         +G95MWZ82Kk+Y3DamOofYy7leZ8UEonoYRsMhSo3wA0Pyuvp7q9l/gv7SdqkEBdcHhQ6
         wnLzBZefaybKfLZorvqYMOSfDelOoZrv4TzXKkfQZlD4GovEVGlzTxzn3EE94AxWsyav
         avGkQCJCFIcU6pLBFgnbrLcyWNWcyT2TIhEfQlAcy6HitVm7TpV8qgC+6WkeErkOdfZ9
         mLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608176; x=1787212976;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6SwGjkMBjgeTIPIBZLyXQnSRomAElVlQN8O05l/e5w=;
        b=TK9lvxWaMLIDWBZtrQQEVnhsVGk58vJczjbNFezdtm3aoUOI3LUbbkKPFWLk6j/wBL
         JuEgoEQEW/9bLFSxGUGekR3H4XDVZwL9Sn3XCyFKEL0L8ozIncYnLrp+JceX7rSWPlmS
         12oNasF23o6itGlSTHOaxp/Rw3RCzGf35o8hXswurAmTy0x33NjVbbBpvL3XtMVFP0C/
         7UI+qf4hy4kd53EosWLODTiWiYnE3ouvuU09QOXf7c5qTyBZMOVkaxQSaCPoZn+3BK0Y
         KQqr4+X5hpk35mJQwn2kAs6VjAyCCgNd8qq20JfkXGEX8JipqWBN3xIS7l9M/M6NMAwN
         H9tQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYq7mdFBSB0YCt3ELFLa++aU2vx7G0N65x997DCHr/Xqe32gWC0uBlv610yEiklPC1uit8qlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Drq1FiYc7BtPEGF93BgkfPqOVCfutXn3o8iibdSyaBsAmdwP
	edyTXrl2D+1i85ERL5aCtrHocrA8hwdRUh8+S/nGEzaEEnZhhd2eXNiY1cfZ4ASiyRSyH27lYzo
	YJg78Lw==
X-Received: from plij15.prod.google.com ([2002:a17:903:380f:b0:2cf:3e66:d26c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2442:b0:2ca:d820:b9a6
 with SMTP id d9443c01a7336-2d37f0da29cmr34444685ad.23.1786608175745; Thu, 13
 Aug 2026 01:02:55 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:21 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-8-kuniyu@google.com>
Subject: [PATCH v4 net-next 07/15] neighbour: Remove neigh_tables[].
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
index 7af1ba5084bd..3b63c7fa5ffb 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -2020,7 +2020,7 @@ int __init ndisc_init(void)
 	/*
 	 * Initialize the neighbour table
 	 */
-	neigh_table_init(NEIGH_ND_TABLE, &nd_tbl);
+	neigh_table_init(&nd_tbl);
 
 #ifdef CONFIG_SYSCTL
 	err = neigh_sysctl_register(NULL, &nd_tbl.parms,
@@ -2053,6 +2053,6 @@ void ndisc_cleanup(void)
 #ifdef CONFIG_SYSCTL
 	neigh_sysctl_unregister(&nd_tbl.parms);
 #endif
-	neigh_table_clear(NEIGH_ND_TABLE, &nd_tbl);
+	neigh_table_clear(&nd_tbl);
 	unregister_pernet_subsys(&ndisc_net_ops);
 }
-- 
2.55.0.691.gc56d675ccc-goog

