Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52539099C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415104; cv=none; b=rgklj1lhIRaJmF4js+RkYra4rLeExME3A1nODeLdIBqSmV8xDz2pBMv7pUuttn4lKxnibMcr/CD3HZCQGJLikgx2VnYsW1MjbCGAS+7KnTTzmeEA1QOpnq1jfvhLje2OHWHbUOyfq9AWZjwRf08zN+skE19UMjACc2O9uPf+JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415104; c=relaxed/simple;
	bh=n69jk8YVMzMwuuWYDkBOiLEEHV5e8ONsa7erHjWpJfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+QvacN8hJk7YwzcJAEGUZuQ9QktCyxPPIvBK/nSkxVXfMt8i9WUq1SqTUSLoXtcYse6wHO8ponhrAFoFod3E5GEjjdeRSEo9ht5LjRKDv1a94zEMtsykUfZfz34imaFfT6iXKt73whYr1ZOnQqSBCOAJlVSMrls6/wQBd96mkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cziqSyYX; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cziqSyYX"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7621655eso4810264a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415102; x=1787019902; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+kJ3ENIMU1lVW7kbmtx82oKiLbeMAvsL6S6r7Z5LTk=;
        b=cziqSyYXvwQlLDlk543WWTcgTRoGLouihjK/JO7eqlErLDpR79UDBbv0aCau4BU0nd
         NRN8VP7BwUYrYGIJuWuKgDPiBbGCJ5gyd2luv8iCly61u/eKRken2GJpA79Mxh28zvVZ
         Gk2A4wi9aG7dYMY3sDRzAQ+FF60p6y0R9+6TLxBmqW64lZ+Aca+UDM3aIvo8zcK6y6ue
         p8vE1yYBdSb55m4kEkzYS8mqpisVV1HnMOY19OI6o2iUs9Samxw45zqVgdBcyw5i60R8
         CDViTCztbRjjCBmMdPvmIPpf+Qd4a8CL20UI19LP7K2n2t+1t3tCVtLWBoso/QIjqXnf
         ZCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415102; x=1787019902;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+kJ3ENIMU1lVW7kbmtx82oKiLbeMAvsL6S6r7Z5LTk=;
        b=rLMBynD6xRmaCYqHkPe4u6djpRjcnrUFiTl+L5wHJoLbWMqI2VwnSqpkQqLw7ptb6s
         6n500JzyuBs08lAQe5cIjjjMl0YwYA49+nO8/6PCoijI1V7n4LSJMpK6HMVWy6lktUPx
         4U2I8y+GS2bW2wW02Pbr1vN/P8QKuYzgYMbUTZLUUO6GKIEW1CS2YF5zMxCRWEnZYQoP
         Brg8S4G4LUyV695PfaW1Tkwv7+/jJeIYbpVjgLCVYjYPU0IMr1Y4dZqpfwiDAtkk2Wws
         lvEBOwdINFN93gvzn1aU/BndM2c7UPZnP7P34wMXQQ9Wu/vUD9mXEq9Tl9TLAitdan9i
         /+Eg==
X-Forwarded-Encrypted: i=1; AHgh+RobMhwglXLRKRy7MXn8Ym9vEJV3bhTAv8Chb9aYiFK+nirnZbBE7mokTN7pnGbb/cOwyabpWDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8T7fNgMkeeOL+u9u5fPKNc7E7LhOHWWsDHUYpQsSV2erQrrz
	V8LyULNoXiRg3mD70pHn+PGgfjd4Vx2ceMpfanR9iEIWj+NhL6rmh08TZ9m9lj3YO8Wm2CsWdcY
	el+F/EA==
X-Received: from pjbnl15.prod.google.com ([2002:a17:90b:384f:b0:38f:a3cc:f600])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56ce:b0:38d:f94d:4c6e
 with SMTP id 98e67ed59e1d1-3903c5faa8amr50068506a91.17.1786415101667; Mon, 10
 Aug 2026 19:25:01 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:46 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-13-kuniyu@google.com>
Subject: [PATCH v3 net-next 12/15] neighbour: Namespacify neigh_tables.
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

The next patch will remove other unnecessary net_eq().

Note that CONFIG_SYSCTL cannot be enabled without CONFIG_PROC_FS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3:
  * Remove timer_shutdown_sync() in neigh_flush_one() and
    rely on tbl->entries to free it in neigh_table_free().

v2:
  * panic() when register_pernet_subsys(&arp_net_ops) fails
  * Add timer_shutdown_sync() in neigh_flush_one()
---
 include/net/neighbour.h |  2 --
 net/core/neighbour.c    | 44 +++++++++++++++++++++++++++--------------
 net/ipv4/arp.c          | 20 ++++++++++++++-----
 net/ipv6/ndisc.c        | 43 ++++++++++++++--------------------------
 4 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 762c8e4cdd96..afe7205b5292 100644
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
index 7dc8f0cdbb45..7a6cbadedc88 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1824,10 +1824,9 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
-void neigh_table_init(struct neigh_table *tbl)
+static int neigh_table_init(struct net *net, struct neigh_table *tbl)
 {
 	unsigned long now = jiffies;
-	struct net *net = &init_net;
 	unsigned long phsize;
 
 	RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
@@ -1847,8 +1846,9 @@ void neigh_table_init(struct neigh_table *tbl)
 		goto err_stats;
 
 #ifdef CONFIG_PROC_FS
-	if (!proc_create_seq_data(tbl->id, 0, net->proc_net_stat,
-				  &neigh_stat_seq_ops, tbl))
+	if (!proc_create_net_data(tbl->id, 0, net->proc_net_stat,
+				  &neigh_stat_seq_ops,
+				  sizeof(struct seq_net_private), tbl))
 		goto err_proc;
 #endif
 
@@ -1878,7 +1878,7 @@ void neigh_table_init(struct neigh_table *tbl)
 	INIT_DEFERRABLE_WORK(&tbl->managed_work, neigh_managed_work);
 	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work, 0);
 
-	return;
+	return 0;
 
 #ifdef CONFIG_PROC_FS
 err_proc:
@@ -1889,7 +1889,7 @@ void neigh_table_init(struct neigh_table *tbl)
 err_phash:
 	neigh_hash_free_rcu(&rcu_dereference_protected(tbl->nht, 1)->rcu);
 err_hash:
-	panic("cannot allocate memory");
+	return -ENOMEM;
 }
 
 static void neigh_table_free(struct neigh_table *tbl)
@@ -1905,16 +1905,12 @@ static void neigh_table_free(struct neigh_table *tbl)
 	nht = rcu_dereference_protected(tbl->nht, 1);
 	tbl->nht = NULL;
 	neigh_hash_free_rcu(&nht->rcu);
+
+	kfree(tbl);
 }
 
-/*
- * Only called from ndisc_cleanup(), which means this is dead code
- * because we no longer can unload IPv6 module.
- */
-int neigh_table_clear(struct neigh_table *tbl)
+static void neigh_table_clear(struct net *net, struct neigh_table *tbl)
 {
-	struct net *net __maybe_unused = &init_net;
-
 	cancel_delayed_work_sync(&tbl->managed_work);
 	cancel_delayed_work_sync(&tbl->gc_work);
 	timer_shutdown_sync(&tbl->proxy_timer);
@@ -1923,20 +1919,38 @@ int neigh_table_clear(struct neigh_table *tbl)
 	remove_proc_entry(tbl->id, net->proc_net_stat);
 
 	neigh_table_put(tbl);
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
index 597a07ff8f10..05db5bfb16dc 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1985,6 +1985,13 @@ static int __net_init ndisc_net_init(struct net *net)
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
@@ -2003,6 +2010,10 @@ static int __net_init ndisc_net_init(struct net *net)
 	return 0;
 
 err_sock_create:
+#ifdef CONFIG_SYSCTL
+	neigh_sysctl_unregister(&nd_table(net)->parms);
+err_sysctl:
+#endif
 	neigh_table_unregister(net, NEIGH_ND_TABLE);
 err:
 	return err;
@@ -2011,6 +2022,9 @@ static int __net_init ndisc_net_init(struct net *net)
 static void __net_exit ndisc_net_exit(struct net *net)
 {
 	inet_ctl_sock_destroy(net->ipv6.ndisc_sk);
+#ifdef CONFIG_SYSCTL
+	neigh_sysctl_unregister(&nd_table(net)->parms);
+#endif
 	neigh_table_unregister(net, NEIGH_ND_TABLE);
 }
 
@@ -2021,30 +2035,7 @@ static struct pernet_operations ndisc_net_ops = {
 
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
@@ -2059,9 +2050,5 @@ void ndisc_late_cleanup(void)
 
 void ndisc_cleanup(void)
 {
-#ifdef CONFIG_SYSCTL
-	neigh_sysctl_unregister(&nd_tbl.parms);
-#endif
-	neigh_table_clear(&nd_tbl);
 	unregister_pernet_subsys(&ndisc_net_ops);
 }
-- 
2.55.0.691.gc56d675ccc-goog

