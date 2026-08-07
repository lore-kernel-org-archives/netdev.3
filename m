Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA040FDB9
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145384; cv=none; b=D9mikmqsiwB9bM0jbuzllKk1Wuccz/eM8w7baGGX3XFfFZqVfT8MLp2QmZl7LL5B8H3rUvHk0F/lTmCkYxTbVqnlUWEqrADh7yLzlOBaRcO/3ZAJbkzBHiSnr4Kj2LoVsEgL83ZE2F1a9GRe8xe1wRToGZn9SE+5izzGH/Mq6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145384; c=relaxed/simple;
	bh=cdDjam6vU2xpx0CzBdL4C24L25X1Fm9eBq0XO1S/eF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJnfl3Z3yJA/kVKVHa+aCil6a8TSnsRjNeaDDZd5F3Ntu00Vs3A7a7RZmlk9TItS3q2VrTddlF1Q9MYixME7YCN69D4P7oMOQSse3F3WGDuJjJqGA/YFWC7rs1//reubKcFHicmYzUNxE8ZQCmPudcIyKvxEpw6EpYiBjOfA+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPvML2Fx; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPvML2Fx"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a3514f912so116517b3a.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145382; x=1786750182; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCh+wVgP6Kf6FzpQGc1Cbtbr/EpEXz9JL59wtUpMK6k=;
        b=lPvML2FxNko5s8DTx89I25FTg8uZOsksQAlOuXydIO4z/KJHkem1Oht60pq1suC3Zc
         8uwQNkrPQZSWxpwVtIRGPbgbsaZmgG1WfPVILGEWLjirYoWIqSShDZIDhTLO8f8xYGzE
         2NjCCCcxpQh51Hoisj+YhqzT/DrQ+isrq71+KaVnctfQIsgrfvaUDbrsou6bqMtJ2UuN
         yerywvKuipo6gLGkbqkF2dEVbJHeqKmEIibqC7n+Yiiz3JHBraF50DeycMx0vkbjGiCR
         Gmiuu6ujBO4zduZspI/2yu7fNN61r6+8opcj+CH2bq4saeSuFYithaX0kpz0BYycjlBt
         /VPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145382; x=1786750182;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wCh+wVgP6Kf6FzpQGc1Cbtbr/EpEXz9JL59wtUpMK6k=;
        b=AXaBVXwthiyXzN6OWUwqYVKu4mxbxT3uVHQmnFqVoCxIapdgvtI4PfQkrS/ftXnV9I
         rBjaHywy9ZUZ45IVh9p8zHMxintrd4Ymt6TWoWEyGU+ICIo06AyQTHxdBbUX89xBXMcV
         R1zX0Glu8VW7YAoWvg5v9lXAP0JnBtoCoZitX/9tuNpZE/KCqlvUEXkovIJxWVf02zcW
         vK2nUhjEYpGQ+Tbc40fKBF4f571axQPtw4Qt7RpVrBGQeHWHz8bSSi2sExbVDFeVqK4l
         KoqiSLevTigjLgvT7bpBphJAtVTkB8EXToPUVoZeb2V5aGi/+Ie82hN/NHUvHf+URAEQ
         a/pg==
X-Forwarded-Encrypted: i=1; AHgh+RrZKA247bghMboiOR6NSUWQpgqrrbhwXl38GPRfoUsZdkzbbKqHF0nETBntK/mmbPyhN+11fUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/QVe/EKPlzZl8HJzs9CkgA6lVDiY3ZZlgNjjmJTXUFxcvvgq
	aYXQy4hH5CEpwq0diZYYAUi9qb50R+anjopb4ugNSB9oDsqSqmd3AYzhGe9oyYjS+uw2wVGzWyF
	/aWueJw==
X-Received: from pglx21.prod.google.com ([2002:a63:1715:0:b0:c9a:b3b0:a861])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94e7:b0:848:3f91:da82
 with SMTP id d2e1a72fcca58-84f2e12c1fcmr30293952b3a.32.1786145382202; Fri, 07
 Aug 2026 16:29:42 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:48 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/13] neighbour: Namespacify neigh_tables.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now, neigh_table is ready to be namespacified.

Let's allocate per-netns neigh_table in neigh_table_register()
and call neigh_table_init() and neigh_sysctl_register() for it.

proc_create_seq_data() is changed to proc_create_net_data().

neigh_flush_one() calls timer_shutdown_sync() outside of n->lock
if its netns is dying because neigh_del_timer() uses timer_delete()
and there might be running timer and its neigh_release() might
be executed after neigh_table_clear() frees neigh_table.

The next patch will remove other unnecessary net_eq().

Note that CONFIG_SYSCTL cannot be enabled without CONFIG_PROC_FS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * panic() when register_pernet_subsys(&arp_net_ops) fails
  * Add timer_shutdown_sync() in neigh_flush_one()
---
 include/net/neighbour.h |  2 --
 net/core/neighbour.c    | 45 ++++++++++++++++++++++++++++-------------
 net/ipv4/arp.c          | 20 +++++++++++++-----
 net/ipv6/ndisc.c        | 43 ++++++++++++++-------------------------
 4 files changed, 61 insertions(+), 49 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 3e31eebf8663..b4e89533e1e6 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -341,8 +341,6 @@ static inline void neigh_confirm(struct neighbour *n)
 
 int neigh_table_register(struct net *net, struct neigh_table *tbl, int index);
 void neigh_table_unregister(struct net *net, int index);
-void neigh_table_init(struct neigh_table *tbl);
-int neigh_table_clear(struct neigh_table *tbl);
 struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 			       struct net_device *dev);
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 36488dbd1512..71aadcf9626d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -397,6 +397,9 @@ static void neigh_flush_one(struct neighbour *n)
 
 	write_unlock(&n->lock);
 
+	if (!check_net(neigh_parms_net(n->parms)))
+		timer_shutdown_sync(&n->timer);
+
 	neigh_cleanup_and_release(n);
 }
 
@@ -1807,10 +1810,9 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
-void neigh_table_init(struct neigh_table *tbl)
+static int neigh_table_init(struct net *net, struct neigh_table *tbl)
 {
 	unsigned long now = jiffies;
-	struct net *net = &init_net;
 	unsigned long phsize;
 
 	RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
@@ -1830,8 +1832,9 @@ void neigh_table_init(struct neigh_table *tbl)
 		goto err_stats;
 
 #ifdef CONFIG_PROC_FS
-	if (!proc_create_seq_data(tbl->id, 0, net->proc_net_stat,
-				  &neigh_stat_seq_ops, tbl))
+	if (!proc_create_net_data(tbl->id, 0, net->proc_net_stat,
+				  &neigh_stat_seq_ops,
+				  sizeof(struct seq_net_private), tbl))
 		goto err_proc;
 #endif
 
@@ -1860,7 +1863,7 @@ void neigh_table_init(struct neigh_table *tbl)
 	INIT_DEFERRABLE_WORK(&tbl->managed_work, neigh_managed_work);
 	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work, 0);
 
-	return;
+	return 0;
 
 #ifdef CONFIG_PROC_FS
 err_proc:
@@ -1871,16 +1874,11 @@ void neigh_table_init(struct neigh_table *tbl)
 err_phash:
 	neigh_hash_free_rcu(&rcu_dereference_protected(tbl->nht, 1)->rcu);
 err_hash:
-	panic("cannot allocate memory");
+	return -ENOMEM;
 }
 
-/*
- * Only called from ndisc_cleanup(), which means this is dead code
- * because we no longer can unload IPv6 module.
- */
-int neigh_table_clear(struct neigh_table *tbl)
+static void neigh_table_clear(struct net *net, struct neigh_table *tbl)
 {
-	struct net *net __maybe_unused = &init_net;
 	struct neigh_hash_table *nht;
 
 	cancel_delayed_work_sync(&tbl->managed_work);
@@ -1901,20 +1899,39 @@ int neigh_table_clear(struct neigh_table *tbl)
 	nht = rcu_dereference_protected(tbl->nht, 1);
 	tbl->nht = NULL;
 	neigh_hash_free_rcu(&nht->rcu);
-
-	return 0;
 }
 
 int neigh_table_register(struct net *net, struct neigh_table *tbl, int index)
 {
+	int err;
+
+	tbl = kmemdup(tbl, sizeof(*tbl), GFP_KERNEL);
+	if (!tbl) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	err = neigh_table_init(net, tbl);
+	if (err)
+		goto free_table;
+
 	net->neigh_tables[index] = tbl;
 
 	return 0;
+
+free_table:
+	kfree(tbl);
+err:
+	return err;
 }
 
 void neigh_table_unregister(struct net *net, int index)
 {
+	struct neigh_table *tbl = net->neigh_tables[index];
+
 	net->neigh_tables[index] = NULL;
+	neigh_table_clear(net, tbl);
+	kfree(tbl);
 }
 
 static struct neigh_table *neigh_find_table(struct net *net, int family)
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index a44fa68fdd07..f197051d3aa7 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1518,6 +1518,12 @@ static int __net_init arp_net_init(struct net *net)
 		goto err;
 
 #ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SYSCTL
+	err = neigh_sysctl_register(NULL, &arp_table(net)->parms, NULL);
+	if (err)
+		goto err_sysctl;
+#endif
+
 	if (!proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
 			     sizeof(struct neigh_seq_state))) {
 		err = -ENOMEM;
@@ -1529,6 +1535,10 @@ static int __net_init arp_net_init(struct net *net)
 
 #ifdef CONFIG_PROC_FS
 err_proc_create:
+#ifdef CONFIG_SYSCTL
+	neigh_sysctl_unregister(&arp_table(net)->parms);
+err_sysctl:
+#endif
 	neigh_table_unregister(net, NEIGH_ARP_TABLE);
 #endif
 err:
@@ -1538,6 +1548,9 @@ static int __net_init arp_net_init(struct net *net)
 static void __net_exit arp_net_exit(struct net *net)
 {
 	remove_proc_entry("arp", net->proc_net);
+#ifdef CONFIG_SYSCTL
+	neigh_sysctl_unregister(&arp_table(net)->parms);
+#endif
 	neigh_table_unregister(net, NEIGH_ARP_TABLE);
 }
 
@@ -1548,12 +1561,9 @@ static struct pernet_operations arp_net_ops = {
 
 void __init arp_init(void)
 {
-	neigh_table_init(&arp_tbl);
+	if (register_pernet_subsys(&arp_net_ops))
+		panic("Cannot allocate arp table\n");
 
 	dev_add_pack(&arp_packet_type);
-	register_pernet_subsys(&arp_net_ops);
-#ifdef CONFIG_SYSCTL
-	neigh_sysctl_register(NULL, &arp_tbl.parms, NULL);
-#endif
 	register_netdevice_notifier(&arp_netdev_notifier);
 }
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 3a458b188595..13e24c64dcdc 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1984,6 +1984,13 @@ static int __net_init ndisc_net_init(struct net *net)
 	if (err)
 		goto err;
 
+#ifdef CONFIG_SYSCTL
+	err = neigh_sysctl_register(NULL, &nd_table(net)->parms,
+				    ndisc_ifinfo_sysctl_change);
+	if (err)
+		goto err_sysctl;
+#endif
+
 	err = inet_ctl_sock_create(&sk, PF_INET6,
 				   SOCK_RAW, IPPROTO_ICMPV6, net);
 	if (err < 0) {
@@ -2002,6 +2009,10 @@ static int __net_init ndisc_net_init(struct net *net)
 	return 0;
 
 err_sock_create:
+#ifdef CONFIG_SYSCTL
+	neigh_sysctl_unregister(&nd_table(net)->parms);
+err_sysctl:
+#endif
 	neigh_table_unregister(net, NEIGH_ND_TABLE);
 err:
 	return err;
@@ -2010,6 +2021,9 @@ static int __net_init ndisc_net_init(struct net *net)
 static void __net_exit ndisc_net_exit(struct net *net)
 {
 	inet_ctl_sock_destroy(net->ipv6.ndisc_sk);
+#ifdef CONFIG_SYSCTL
+	neigh_sysctl_unregister(&nd_table(net)->parms);
+#endif
 	neigh_table_unregister(net, NEIGH_ND_TABLE);
 }
 
@@ -2020,30 +2034,7 @@ static struct pernet_operations ndisc_net_ops = {
 
 int __init ndisc_init(void)
 {
-	int err;
-
-	err = register_pernet_subsys(&ndisc_net_ops);
-	if (err)
-		return err;
-	/*
-	 * Initialize the neighbour table
-	 */
-	neigh_table_init(&nd_tbl);
-
-#ifdef CONFIG_SYSCTL
-	err = neigh_sysctl_register(NULL, &nd_tbl.parms,
-				    ndisc_ifinfo_sysctl_change);
-	if (err)
-		goto out_unregister_pernet;
-out:
-#endif
-	return err;
-
-#ifdef CONFIG_SYSCTL
-out_unregister_pernet:
-	unregister_pernet_subsys(&ndisc_net_ops);
-	goto out;
-#endif
+	return register_pernet_subsys(&ndisc_net_ops);
 }
 
 int __init ndisc_late_init(void)
@@ -2058,9 +2049,5 @@ void ndisc_late_cleanup(void)
 
 void ndisc_cleanup(void)
 {
-#ifdef CONFIG_SYSCTL
-	neigh_sysctl_unregister(&nd_tbl.parms);
-#endif
-	neigh_table_clear(&nd_tbl);
 	unregister_pernet_subsys(&ndisc_net_ops);
 }
-- 
2.55.0.679.g6767b8d81c-goog

