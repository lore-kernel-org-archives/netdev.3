Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48D43F0BB
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608183; cv=none; b=rGICNVoAGT2xYmc8b2MXZa1x1ph55XbScTHcHkGzKA3x7NYI/mYMktCXy7yh1qtrvKKQY/3LnK3qQTW3IFjsCp6TM+aM1OXKkUlhMCucgwoencGeJVBDBrblLXh1aBXpHyyaVh+ibfAc5xkhoHiy3WAEFuE9Gpoht6atHLOdVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608183; c=relaxed/simple;
	bh=9W2PvUMQeapEDcckXngtdTV3WML/x1kyeG2k9v6PTmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FrcpL+fVQHkb1h54ldOosWF0We4Eqvn0PxtTIkBvFk8TfqrvmBFZeJ1e0j3+7Kytc1W5CZviuPSaMFBl2GbxrgzdE5IwLL/zDKjYfZGzhRyAj1d3IqfDrU2jx0ZScnzD8JiT7nAdpbE8TxYaeAZzcU9/FA3KGPPfFF8BP1iBu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVOowbnZ; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVOowbnZ"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbeeaabcadfso609313a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608180; x=1787212980; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k2xSeduNdJgApUxaU1xhAK6KoyhRvCdW9ULa7d9f3QY=;
        b=oVOowbnZKjhEd+h0bmK6RUwQIu7uzUn6KoSJf8IoeSZnZGIsl+IXLY85GBL+cAnSwf
         EZDuBgA5HOSHmSHHK0sMSct8BDKpYY4Y04kR8qaaVpqRHOiauXdv8kYKMjhgiMAYzQqy
         kPINtW4nK6c9IUS4nhBj8X7/8t7vrpNXOcJCtaIJbSjQdXYWeL3hhEzm7c/dzNbrBAos
         ryUfc1QSXfMojZUR1F/AlaoGJ+gjeaoE6CG11Yz4IkKSwrALpMuqGOYdKR5n/2mqZtMG
         52cm6ZvB4a+xaahrzN+NyHDFcBZGuTC9B2FZeQDJPmZPtVKfV2/o+QVw8ITiPl7xybtN
         YxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608180; x=1787212980;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2xSeduNdJgApUxaU1xhAK6KoyhRvCdW9ULa7d9f3QY=;
        b=D3RkXuGFLbXgbXHRYE9yqmWpUBGtOGKxOpIa5uopRExXy5mIUQoZQrSskJUJQiW/7L
         nIi+uJom4ugL6EaljNmPaU1HDWTGfA/PiIRmew3BqIYZLe+NKDeZDO8Vj/BaLtq6AbXE
         nyxEvrdo6dVN9gu907uWSFJpaN0C1De4QzFIH0+k0IzaG3x2VbvU7nbuWbGVVpag7m8z
         mpdF6SSS4XMMTf9gI4euUf3ijurf2sDr6UqXNq6djNcnLdpzcL5CxtCu3m+TdvYlhk41
         dFoNRclbqjZyJEEQB86o+NUjtGFUOn0lsf/J/nEweoZjGloEHpPSGhEt2tYlMNTvExYS
         R8DA==
X-Forwarded-Encrypted: i=1; AHgh+RqbR9F/HtCSK1KwR7tEX6kgNzXTOzijM6brFjt23GM/cDniaxLxuo2/n4+x7CL2DZIPkqYuJu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0f/cbQc3zJ8z22Budw6PMdUgs78gBLeIy02phMhCa1+c5xH6
	qMQvOf+3y3v5bW6X5hAg1i5tcmdB0tDUDZJolfH8S0Di94QcMOYsozGasXlcumd9W/Z87BC/JSP
	5zmvu0w==
X-Received: from pgmc1.prod.google.com ([2002:a63:1c41:0:b0:cbe:3df6:a1aa])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:697:b0:3c3:875d:c538
 with SMTP id adf61e73a8af0-3cc54f9bb27mr6113091637.8.1786608179897; Thu, 13
 Aug 2026 01:02:59 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:26 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-13-kuniyu@google.com>
Subject: [PATCH v4 net-next 12/15] neighbour: Namespacify neigh_tables.
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

Since each netns has its own sysctl knobs, RTM_SETNEIGHTBL can
configure the default table param (ifindex==0) and GC parameters
per netns.

To avoid potential regression, all the default parameters under
/proc/sys/net/ipv{4,6}/neigh/default/, are inherited from init_net
by default.

This behaviour is controlled by a new sysctl knob,
net.core.neigh_inherit_init_net:

  # sysctl net.core.neigh_inherit_init_net
  net.core.neigh_inherit_init_net = 1
  # sysctl net.ipv4.neigh.default.gc_thresh1
  net.ipv4.neigh.default.gc_thresh1 = 128
  # sysctl net.ipv4.neigh.default.gc_thresh1=129
  net.ipv4.neigh.default.gc_thresh1 = 129
  # unshare -n sysctl net.ipv4.neigh.default.gc_thresh1
  net.ipv4.neigh.default.gc_thresh1 = 129

If it is turned off, all settings are reset in the new netns:

  # sysctl net.core.neigh_inherit_init_net=0
  net.core.neigh_inherit_init_net = 0
  # unshare -n sysctl net.ipv4.neigh.default.gc_thresh1
  net.ipv4.neigh.default.gc_thresh1 = 128

The next patch will remove other unnecessary net_eq().

Note that CONFIG_SYSCTL cannot be enabled without CONFIG_PROC_FS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4:
  * Add sysctl knob, net.core.neigh_inherit_init_net
  * Inherit all neigh parms by default
  * Move RTM_SETNEIGHTBL changes from patch 14

v3:
  * Remove timer_shutdown_sync() in neigh_flush_one() and
    rely on tbl->entries to free it in neigh_table_free().

v2:
  * panic() when register_pernet_subsys(&arp_net_ops) fails
  * Add timer_shutdown_sync() in neigh_flush_one()
---
 Documentation/admin-guide/sysctl/net.rst | 14 +++++
 include/net/neighbour.h                  |  4 +-
 net/core/neighbour.c                     | 79 ++++++++++++++++--------
 net/core/sysctl_net_core.c               | 12 ++++
 net/ipv4/arp.c                           | 20 ++++--
 net/ipv6/ndisc.c                         | 43 +++++--------
 6 files changed, 112 insertions(+), 60 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index e586e17fc7a5..fe43e8595958 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -413,6 +413,20 @@ new netns has been created.
 
 Default : 0  (for compatibility reasons)
 
+neigh_inherit_init_net
+----------------------
+
+Controls if a new network namespace should inherit all current
+settings under /proc/sys/net/ipv{4,6}/neigh/default/.
+
+By default, the value is set to 1, and all settings are inherited
+from init_net.
+
+If set to 0, both IPv4 and IPv6 settings are reset to their default
+values.
+
+Default : 1  (for compatibility reasons)
+
 txrehash
 --------
 
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 762c8e4cdd96..9ff62d1f8287 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -31,6 +31,8 @@
 #include <net/rtnetlink.h>
 #include <net/neighbour_tables.h>
 
+extern int sysctl_neigh_inherit_init_net;
+
 /*
  * NUD stands for "neighbor unreachability detection"
  */
@@ -341,8 +343,6 @@ static inline void neigh_confirm(struct neighbour *n)
 
 int neigh_table_register(struct net *net, struct neigh_table *tbl, int index);
 void neigh_table_unregister(struct net *net, int index);
-void neigh_table_init(struct neigh_table *tbl);
-int neigh_table_clear(struct neigh_table *tbl);
 struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 			       struct net_device *dev);
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7dc8f0cdbb45..c181011744c5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1754,13 +1754,13 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
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
@@ -1923,20 +1919,59 @@ int neigh_table_clear(struct neigh_table *tbl)
 	remove_proc_entry(tbl->id, net->proc_net_stat);
 
 	neigh_table_put(tbl);
+}
 
-	return 0;
+static void neigh_table_inherit(struct net *net, struct neigh_table *tbl,
+				int index)
+{
+	const struct neigh_table *init_tbl = init_net.neigh_tables[index];
+	bool inherit = READ_ONCE(sysctl_neigh_inherit_init_net);
+	int i;
+
+	if (net_eq(net, &init_net) || !inherit)
+		return;
+
+	tbl->gc_interval = READ_ONCE(init_tbl->gc_interval);
+	tbl->gc_thresh1 = READ_ONCE(init_tbl->gc_thresh1);
+	tbl->gc_thresh2 = READ_ONCE(init_tbl->gc_thresh2);
+	tbl->gc_thresh3 = READ_ONCE(init_tbl->gc_thresh3);
+
+	for (i = 0; i < NEIGH_VAR_DATA_MAX; i++)
+		tbl->parms.data[i] = READ_ONCE(init_tbl->parms.data[i]);
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
+	neigh_table_inherit(net, tbl, index);
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
@@ -2469,8 +2504,8 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (tbp[NDTPA_IFINDEX])
 			ifindex = nla_get_u32(tbp[NDTPA_IFINDEX]);
 
-		p = lookup_neigh_parms(tbl, net, ifindex);
-		if (p == NULL) {
+		p = lookup_neigh_parms(tbl, ifindex);
+		if (!p) {
 			err = -ENOENT;
 			goto errout_tbl_lock;
 		}
@@ -2551,12 +2586,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b508618bfc12..9777b9ef5894 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -21,6 +21,7 @@
 
 #include <net/ip.h>
 #include <net/sock.h>
+#include <net/neighbour.h>
 #include <net/net_ratelimit.h>
 #include <net/busy_poll.h>
 #include <net/pkt_sched.h>
@@ -53,6 +54,8 @@ EXPORT_SYMBOL(sysctl_fb_tunnels_only_for_init_net);
 int sysctl_devconf_inherit_init_net __read_mostly;
 EXPORT_SYMBOL(sysctl_devconf_inherit_init_net);
 
+int sysctl_neigh_inherit_init_net __read_mostly = 1;
+
 #if IS_ENABLED(CONFIG_NET_FLOW_LIMIT) || IS_ENABLED(CONFIG_RPS)
 static int dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
 			struct cpumask *mask)
@@ -676,6 +679,15 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_do_skb_defer_max,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "neigh_inherit_init_net",
+		.data		= &sysctl_neigh_inherit_init_net,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static struct ctl_table netns_core_table[] = {
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

