Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5D36B919
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828326; cv=none; b=AYXdFQGPdlxV7pIfenOwYaIRVaI1KlzpFzPNFeczIc96dzuX6T4LSTS4VMvzunX4dHmrfwLbBZkj5EB/tqdap6+L62OjsvH9ehHpLkuQM/YMMF+FTMNEqgh8wRUUUaCg4piSY0ud+lAd6JMSKOxoq0p5sN9JFqXn7iEZDGtpxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828326; c=relaxed/simple;
	bh=dHpZ+xme3JJSwKh/Yg8/VRHcqL3GmOxUAL3ZmLf2Qpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFT3S2otNnBi6Gr+GEAw6O15N9esdKYMVHRKechYAm0tw34vS9AsdoXL3v67fplJs/Lze0URlD+1d1J9EWROts2Z76IxxKJGdfClgWn3stke+0WXoWrz2ndxLaidim44vwkN/SO2+x8gf+aziSabnGk08rxOwBvwTnf2baz5u5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMeS+x9s; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMeS+x9s"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485b358552so977045b3a.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828324; x=1785433124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IuORaTSfX7o3lTc/yqWHMjKSOqYRYljtATPuUNCZ4VY=;
        b=iMeS+x9snkpd4JvThJJEpI+tr7GMh4v0XghXq2M+Pnc6Cf7ohxwJxa6U0oWGMjq+nB
         vvBwKSH0q7JVKmc5b1xbowrwBYqqkPigXOXvFM5bRt6mmvxzrD/rKvkk3WgUMwgCZ0wO
         0CylzXF3Ak/krh/Ziy+/V8YcgqkJapuw30bTCmsyxiZptsoB1BdIrNYtSgph7Wl3K28q
         0RcZFUeeAdd9NfTjloGBCyKq0qRtwmfnNn0zuDN6PJQCzzkdoeZ964MYxg8CRibU+GS2
         Nppu5Zx6sQs9S//IpTEA7zXlZQ4r1N2U09w+eeerAndadILCmzn0qhh5e62bS6FUXlwT
         u8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828324; x=1785433124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IuORaTSfX7o3lTc/yqWHMjKSOqYRYljtATPuUNCZ4VY=;
        b=a/bwaTsiBCTw8zw4WjvFw0lzZk5XT/fYZL60dgyuyesIIMZzEJvMcd2pxrY10dugaH
         x5y2C0lNTskS9AuH4S7DJ3LSkUunmdIz/kHdlFerDRDIG00f/qWPhEUWFdi625u3yjDv
         kTBfdqJbno2x9nQTbnsidmpbvpfxTQA8G4E9+xwk9bAliVCo6mhcGxWrRwAHVd/vG54w
         5Owdxw8wNuH89gSIVpkc82eh9Lu1K67tUHkr9+LJ/NZG8mzpo/7Iyln/Ms9SNmR7rZOw
         QOdQtxFLrpyEwyoluqJPKwnCuFWAcJL8aqmGtoYxaxUzFwx8gJRI5ML0sh6KyfCTvUHp
         d4DA==
X-Gm-Message-State: AOJu0YzTLCvZMXC/Si3A8YUTc1V8o/5VgY++hUkFGAkgJ+LE0sarGL31
	bQPNYuCpONFjoHyZuohL9YRYr2UBNddELVv0Vy9rjZE2KPryYdv66y2QttVwPuQJ5KI=
X-Gm-Gg: AR+sD11EeAdggrcrGIjOq/vaMSAq1n2nWiYBtlc7kiT4TUNNT0Mni28HlFhNyP+n3b0
	AobneTCMNRviUwx2IjeINUK7jA3V8PJTPiGUdx3r4eaTjPtK9h2LtMDlh5pnAbfi78PDmyrnAGp
	+mE+9sB1mR0D9HGRl+HIZQBkLaXk1V8LEHPxNpthKrHn3iRXFTAAFTfWNOjk9UDPtcszO1ll8jI
	5uA2QzWwhSS+5l4iFnoqhGGkrWRRO4y5OtEwujfuMbyy8coCFweTQfMmk1m3bd0JHX74f7roSl8
	9vqcg1Sa7YExujit+PEIDt+kcXewUizIrQDev980pKQu3rLb1mwycI+atSzq0aEcrG5E03Uf8H9
	02GcANmXF1wU1qetDMBwMLS+gtYiKh9L2kRoJqEK6S7t6qZ2s1/kgdqk4K0ks5KFqEfZT6ljYuU
	uwIOJXmfN8ETnv8TyvXOU=
X-Received: by 2002:a05:6a00:1a88:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84e2bc5d1f1mr4635415b3a.21.1784828323534;
        Thu, 23 Jul 2026 10:38:43 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175f1e8dsm3488867b3a.55.2026.07.23.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:38:43 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kaber@trash.net,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] ipv6: ip6mr: fix mr_table lifetime leak
Date: Fri, 24 Jul 2026 01:38:23 +0800
Message-ID: <70026e78a5cafae9d3ccc560e2b5c4dd47f0a7b0.1784795838.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784795838.git.zihanx@nebusec.ai>
References: <cover.1784795838.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

MRT6_TABLE should only select a multicast routing table, but a fresh
non-default mr_table can still outlive the socket once MRT6_INIT
publishes it. After MRT6_DONE or socket close, ip6mr_sk_done() clears
the routing state but leaves the empty table linked from mr6_tables, so
repeated MRT6_TABLE(fresh id) -> MRT6_INIT -> MRT6_DONE/close cycles
accumulate detached tables until netns teardown.

Simply freeing the table from ip6mr_sk_done() is not safe because
lookups, getsockopt/ioctl paths and multicast data paths can still hold
RCU references to the published table.

Fix this by keeping MRT6_TABLE as a pure selector, adding refcounted
lifetime pins for runtime users, removing empty non-default tables from
the published set with list_del_rcu() after socket teardown, and
deferring the final free to process context when the last reference
drops outside RTNL. Hold the netns while the table exists so deferred
destruction cannot outlive it.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 include/linux/mroute_base.h |   6 +
 net/ipv4/ipmr_base.c        |   6 +-
 net/ipv6/ip6mr.c            | 328 +++++++++++++++++++++++++++---------
 3 files changed, 258 insertions(+), 82 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 4d55827e970..536fa324620 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -2,8 +2,10 @@
 #define __LINUX_MROUTE_BASE_H
 
 #include <linux/netdevice.h>
+#include <linux/refcount.h>
 #include <linux/rhashtable-types.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/fib_notifier.h>
@@ -242,6 +244,8 @@ struct mr_table_ops {
  * @mroute_do_assert: Whether to inform userspace on wrong ingress
  * @mroute_do_pim: Whether to receive IGMP PIMv1
  * @mroute_reg_vif_num: PIM-device vif index
+ * @refcnt: lifetime pins for this table
+ * @destroy_work: process-context cleanup before final RCU free
  */
 struct mr_table {
 	struct rcu_work		work;
@@ -261,6 +265,8 @@ struct mr_table {
 	bool			mroute_do_pim;
 	bool			mroute_do_wrvifwhole;
 	int			mroute_reg_vif_num;
+	refcount_t		refcnt;
+	struct work_struct	destroy_work;
 };
 
 static inline bool mr_can_free_table(struct net *net)
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 867b24beded..9710789cfaf 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -32,8 +32,10 @@ static void __mr_free_table(struct work_struct *work)
 {
 	struct mr_table *mrt = container_of(to_rcu_work(work),
 					    struct mr_table, work);
+	struct net *net = read_pnet(&mrt->net);
 
 	rhltable_destroy(&mrt->mfc_hash);
+	put_net(net);
 	kfree(mrt);
 }
 
@@ -56,11 +58,12 @@ mr_table_alloc(struct net *net, u32 id,
 	if (!mrt)
 		return ERR_PTR(-ENOMEM);
 	mrt->id = id;
-	write_pnet(&mrt->net, net);
+	write_pnet(&mrt->net, get_net(net));
 
 	mrt->ops = *ops;
 	err = rhltable_init(&mrt->mfc_hash, mrt->ops.rht_params);
 	if (err) {
+		put_net(read_pnet(&mrt->net));
 		kfree(mrt);
 		return ERR_PTR(err);
 	}
@@ -72,6 +75,7 @@ mr_table_alloc(struct net *net, u32 id,
 	timer_setup(&mrt->ipmr_expire_timer, expire_func, 0);
 
 	mrt->mroute_reg_vif_num = -1;
+	refcount_set(&mrt->refcnt, 1);
 	table_set(mrt, net);
 	return mrt;
 }
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 604a5883890..94bb00bdff9 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -87,6 +87,11 @@ static struct kmem_cache *mrt_cachep __read_mostly;
 static struct mr_table *ip6mr_new_table(struct net *net, u32 id);
 static void ip6mr_free_table(struct mr_table *mrt,
 			     struct list_head *dev_kill_list);
+static void ip6mr_free_table_work(struct work_struct *work);
+static struct mr_table *ip6mr_get_table_hold(struct net *net, u32 id);
+static void ip6mr_put_table(struct mr_table *mrt);
+static void __ip6mr_put_table(struct mr_table *mrt,
+			      struct list_head *dev_kill_list);
 
 static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 			   struct net_device *dev, struct sk_buff *skb,
@@ -179,7 +184,7 @@ static int ip6mr_rule_action(struct fib_rule *rule, struct flowi *flp,
 
 	arg->table = fib_rule_get_table(rule, arg);
 
-	mrt = __ip6mr_get_table(rule->fr_net, arg->table);
+	mrt = ip6mr_get_table_hold(rule->fr_net, arg->table);
 	if (!mrt)
 		return -EAGAIN;
 	res->mrt = mrt;
@@ -271,7 +276,8 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del_rcu(&mrt->list);
-		ip6mr_free_table(mrt, dev_kill_list);
+		synchronize_rcu();
+		__ip6mr_put_table(mrt, dev_kill_list);
 	}
 }
 
@@ -314,7 +320,7 @@ static struct mr_table *__ip6mr_get_table(struct net *net, u32 id)
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
-	*mrt = rcu_dereference(net->ipv6.mrt6);
+	*mrt = ip6mr_get_table_hold(net, RT6_TABLE_DFLT);
 	if (!*mrt)
 		return -EAGAIN;
 	return 0;
@@ -342,7 +348,8 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
 
 	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
-	ip6mr_free_table(mrt, dev_kill_list);
+	synchronize_rcu();
+	__ip6mr_put_table(mrt, dev_kill_list);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -368,6 +375,44 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
 	return mrt;
 }
 
+static struct mr_table *ip6mr_get_table_hold(struct net *net, u32 id)
+{
+	struct mr_table *mrt;
+
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, id);
+	if (mrt && !refcount_inc_not_zero(&mrt->refcnt))
+		mrt = NULL;
+	rcu_read_unlock();
+
+	return mrt;
+}
+
+static void __ip6mr_put_table(struct mr_table *mrt,
+			      struct list_head *head)
+{
+	struct list_head *dev_kill_list;
+	LIST_HEAD(local_dev_kill_list);
+
+	if (!refcount_dec_and_test(&mrt->refcnt))
+		return;
+
+	if (!lockdep_rtnl_is_held()) {
+		schedule_work(&mrt->destroy_work);
+		return;
+	}
+
+	dev_kill_list = head ? head : &local_dev_kill_list;
+	ip6mr_free_table(mrt, dev_kill_list);
+	if (!head)
+		unregister_netdevice_many(dev_kill_list);
+}
+
+static void ip6mr_put_table(struct mr_table *mrt)
+{
+	__ip6mr_put_table(mrt, NULL);
+}
+
 static int ip6mr_hash_cmp(struct rhashtable_compare_arg *arg,
 			  const void *ptr)
 {
@@ -413,8 +458,12 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 	if (mrt)
 		return mrt;
 
-	return mr_table_alloc(net, id, &ip6mr_mr_table_ops,
-			      ipmr_expire_process, ip6mr_new_table_set);
+	mrt = mr_table_alloc(net, id, &ip6mr_mr_table_ops,
+			     ipmr_expire_process, ip6mr_new_table_set);
+	if (!IS_ERR(mrt))
+		INIT_WORK(&mrt->destroy_work, ip6mr_free_table_work);
+
+	return mrt;
 }
 
 static void ip6mr_free_table(struct mr_table *mrt,
@@ -423,8 +472,6 @@ static void ip6mr_free_table(struct mr_table *mrt,
 	struct net *net = read_pnet(&mrt->net);
 	LIST_HEAD(ip6mr_dev_kill_list);
 
-	WARN_ON_ONCE(!mr_can_free_table(net));
-
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
@@ -436,6 +483,17 @@ static void ip6mr_free_table(struct mr_table *mrt,
 	list_splice(&ip6mr_dev_kill_list, dev_kill_list);
 }
 
+static void ip6mr_free_table_work(struct work_struct *work)
+{
+	struct mr_table *mrt = container_of(work, struct mr_table, destroy_work);
+	LIST_HEAD(dev_kill_list);
+
+	rtnl_lock();
+	ip6mr_free_table(mrt, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+}
+
 #ifdef CONFIG_PROC_FS
 /* The /proc interfaces to multicast routing
  * /proc/ip6_mr_cache /proc/ip6_mr_vif
@@ -569,7 +627,7 @@ static int pim6_rcv(struct sk_buff *skb)
 	struct ipv6hdr   *encap;
 	struct net_device  *reg_dev = NULL;
 	struct net *net = dev_net(skb->dev);
-	struct mr_table *mrt;
+	struct mr_table *mrt = NULL;
 	struct flowi6 fl6 = {
 		.flowi6_iif	= skb->dev->ifindex,
 		.flowi6_mark	= skb->mark,
@@ -617,9 +675,12 @@ static int pim6_rcv(struct sk_buff *skb)
 	skb_tunnel_rx(skb, reg_dev, dev_net(reg_dev));
 
 	netif_rx(skb);
+	ip6mr_put_table(mrt);
 
 	return 0;
  drop:
+	if (mrt)
+		ip6mr_put_table(mrt);
 	kfree_skb(skb);
 	return 0;
 }
@@ -634,7 +695,7 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
 	struct net *net = dev_net(dev);
-	struct mr_table *mrt;
+	struct mr_table *mrt = NULL;
 	struct flowi6 fl6 = {
 		.flowi6_oif	= dev->ifindex,
 		.flowi6_iif	= skb->skb_iif ? : LOOPBACK_IFINDEX,
@@ -655,12 +716,15 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb,
 	ip6mr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
 			   MRT6MSG_WHOLEPKT);
 	rcu_read_unlock();
+	ip6mr_put_table(mrt);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 
 tx_lookup_err:
 	rcu_read_unlock();
 tx_err:
+	if (mrt)
+		ip6mr_put_table(mrt);
 	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
@@ -1615,12 +1679,13 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 	}
 }
 
-static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
+static int __ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
 {
 	int err = 0;
 	struct net *net = sock_net(sk);
 
-	rtnl_lock();
+	ASSERT_RTNL();
+
 	spin_lock(&mrt_lock);
 	if (rtnl_dereference(mrt->mroute_sk)) {
 		err = -EADDRINUSE;
@@ -1628,6 +1693,7 @@ static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
 		rcu_assign_pointer(mrt->mroute_sk, sk);
 		sock_set_flag(sk, SOCK_RCU_FREE);
 		atomic_inc(&net->ipv6.devconf_all->mc_forwarding);
+		refcount_inc(&mrt->refcnt);
 	}
 	spin_unlock(&mrt_lock);
 
@@ -1636,7 +1702,6 @@ static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
 					     NETCONFA_MC_FORWARDING,
 					     NETCONFA_IFINDEX_ALL,
 					     net->ipv6.devconf_all);
-	rtnl_unlock();
 
 	return err;
 }
@@ -1646,6 +1711,7 @@ int ip6mr_sk_done(struct sock *sk)
 	struct net *net = sock_net(sk);
 	struct ipv6_devconf *devconf;
 	LIST_HEAD(dev_kill_list);
+	struct mr_table *free_mrt = NULL;
 	struct mr_table *mrt;
 	int err = -EACCES;
 
@@ -1675,6 +1741,15 @@ int ip6mr_sk_done(struct sock *sk)
 
 			mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MFC,
 					    &dev_kill_list);
+			if (mrt->id != RT6_TABLE_DFLT &&
+			    !READ_ONCE(mrt->maxvif) &&
+			    !READ_ONCE(mrt->cache_resolve_queue_len) &&
+			    list_empty(&mrt->mfc_cache_list) &&
+			    list_empty(&mrt->mfc_unres_queue) &&
+			    READ_ONCE(mrt->mroute_reg_vif_num) < 0) {
+				list_del_rcu(&mrt->list);
+				free_mrt = mrt;
+			}
 			err = 0;
 			break;
 		}
@@ -1682,6 +1757,14 @@ int ip6mr_sk_done(struct sock *sk)
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 
+	if (!err)
+		ip6mr_put_table(mrt);
+
+	if (free_mrt) {
+		synchronize_rcu();
+		ip6mr_put_table(free_mrt);
+	}
+
 	return err;
 }
 
@@ -1693,11 +1776,15 @@ bool mroute6_is_socket(struct net *net, struct sk_buff *skb)
 		.flowi6_oif	= skb->dev->ifindex,
 		.flowi6_mark	= skb->mark,
 	};
+	bool ret;
 
 	if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0)
 		return NULL;
 
-	return rcu_access_pointer(mrt->mroute_sk);
+	ret = rcu_access_pointer(mrt->mroute_sk);
+	ip6mr_put_table(mrt);
+
+	return ret;
 }
 EXPORT_SYMBOL(mroute6_is_socket);
 
@@ -1716,20 +1803,24 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	struct mf6cctl mfc;
 	mifi_t mifi;
 	struct net *net = sock_net(sk);
-	struct mr_table *mrt;
+	struct mr_table *mrt = NULL;
+	u32 table = raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT;
 
 	if (sk->sk_type != SOCK_RAW ||
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return -EOPNOTSUPP;
 
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
-
-	if (optname != MRT6_INIT) {
+	if (optname != MRT6_INIT &&
+	    optname != MRT6_TABLE &&
+	    optname != MRT6_DONE) {
+		mrt = ip6mr_get_table_hold(net, table);
+		if (!mrt)
+			return -ENOENT;
 		if (sk != rcu_access_pointer(mrt->mroute_sk) &&
-		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		    !ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+			ip6mr_put_table(mrt);
 			return -EACCES;
+		}
 	}
 
 	switch (optname) {
@@ -1737,32 +1828,41 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		if (optlen < sizeof(int))
 			return -EINVAL;
 
-		return ip6mr_sk_init(mrt, sk);
+		rtnl_lock();
+		mrt = ip6mr_new_table(net, table);
+		if (!IS_ERR(mrt))
+			ret = __ip6mr_sk_init(mrt, sk);
+		else
+			ret = PTR_ERR(mrt);
+		rtnl_unlock();
+		return ret;
 
 	case MRT6_DONE:
 		return ip6mr_sk_done(sk);
 
 	case MRT6_ADD_MIF:
 		if (optlen < sizeof(vif))
-			return -EINVAL;
+			goto out_put_table_einval;
 		if (copy_from_sockptr(&vif, optval, sizeof(vif)))
-			return -EFAULT;
+			goto out_put_table_efault;
 		if (vif.mif6c_mifi >= MAXMIFS)
-			return -ENFILE;
+			goto out_put_table_enfile;
 		rtnl_lock();
 		ret = mif6_add(net, mrt, &vif,
 			       sk == rtnl_dereference(mrt->mroute_sk));
 		rtnl_unlock();
+		ip6mr_put_table(mrt);
 		return ret;
 
 	case MRT6_DEL_MIF:
 		if (optlen < sizeof(mifi_t))
-			return -EINVAL;
+			goto out_put_table_einval;
 		if (copy_from_sockptr(&mifi, optval, sizeof(mifi_t)))
-			return -EFAULT;
+			goto out_put_table_efault;
 		rtnl_lock();
 		ret = mif6_delete(mrt, mifi, 0, NULL);
 		rtnl_unlock();
+		ip6mr_put_table(mrt);
 		return ret;
 
 	/*
@@ -1776,9 +1876,9 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	case MRT6_ADD_MFC_PROXY:
 	case MRT6_DEL_MFC_PROXY:
 		if (optlen < sizeof(mfc))
-			return -EINVAL;
+			goto out_put_table_einval;
 		if (copy_from_sockptr(&mfc, optval, sizeof(mfc)))
-			return -EFAULT;
+			goto out_put_table_efault;
 		if (parent == 0)
 			parent = mfc.mf6cc_parent;
 
@@ -1793,6 +1893,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 					    parent);
 
 		mutex_unlock(&net->ipv6.mfc_mutex);
+		ip6mr_put_table(mrt);
 		return ret;
 
 	case MRT6_FLUSH:
@@ -1801,14 +1902,15 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		int flags;
 
 		if (optlen != sizeof(flags))
-			return -EINVAL;
+			goto out_put_table_einval;
 		if (copy_from_sockptr(&flags, optval, sizeof(flags)))
-			return -EFAULT;
+			goto out_put_table_efault;
 
 		rtnl_lock();
 		mroute_clean_tables(mrt, flags, &dev_kill_list);
 		unregister_netdevice_many(&dev_kill_list);
 		rtnl_unlock();
+		ip6mr_put_table(mrt);
 		return 0;
 	}
 
@@ -1820,10 +1922,11 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		int v;
 
 		if (optlen != sizeof(v))
-			return -EINVAL;
+			goto out_put_table_einval;
 		if (copy_from_sockptr(&v, optval, sizeof(v)))
-			return -EFAULT;
+			goto out_put_table_efault;
 		WRITE_ONCE(mrt->mroute_do_assert, v);
+		ip6mr_put_table(mrt);
 		return 0;
 	}
 
@@ -1834,9 +1937,9 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		int v;
 
 		if (optlen != sizeof(v))
-			return -EINVAL;
+			goto out_put_table_einval;
 		if (copy_from_sockptr(&v, optval, sizeof(v)))
-			return -EFAULT;
+			goto out_put_table_efault;
 
 		do_wrmifwhole = (v == MRT6MSG_WRMIFWHOLE);
 		v = !!v;
@@ -1848,6 +1951,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			WRITE_ONCE(mrt->mroute_do_wrvifwhole, do_wrmifwhole);
 		}
 		rtnl_unlock();
+		ip6mr_put_table(mrt);
 		return ret;
 	}
 
@@ -1864,18 +1968,22 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		/* "pim6reg%u" should not exceed 16 bytes (IFNAMSIZ) */
 		if (v != RT_TABLE_DEFAULT && v >= 100000000)
 			return -EINVAL;
-		if (sk == rcu_access_pointer(mrt->mroute_sk))
+
+		mrt = ip6mr_get_table_hold(net, table);
+		if (mrt && sk == rcu_access_pointer(mrt->mroute_sk)) {
+			ip6mr_put_table(mrt);
 			return -EBUSY;
+		}
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+			if (mrt)
+				ip6mr_put_table(mrt);
+			return -EACCES;
+		}
+		if (mrt)
+			ip6mr_put_table(mrt);
 
-		rtnl_lock();
-		ret = 0;
-		mrt = ip6mr_new_table(net, v);
-		if (IS_ERR(mrt))
-			ret = PTR_ERR(mrt);
-		else
-			raw6_sk(sk)->ip6mr_table = v;
-		rtnl_unlock();
-		return ret;
+		raw6_sk(sk)->ip6mr_table = v;
+		return 0;
 	}
 #endif
 	/*
@@ -1883,8 +1991,25 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	 *	set.
 	 */
 	default:
+		if (mrt)
+			ip6mr_put_table(mrt);
 		return -ENOPROTOOPT;
 	}
+
+out_put_table_efault:
+	if (mrt)
+		ip6mr_put_table(mrt);
+	return -EFAULT;
+
+out_put_table_einval:
+	if (mrt)
+		ip6mr_put_table(mrt);
+	return -EINVAL;
+
+out_put_table_enfile:
+	if (mrt)
+		ip6mr_put_table(mrt);
+	return -ENFILE;
 }
 
 /*
@@ -1895,6 +2020,7 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 			  sockptr_t optlen)
 {
 	int olr;
+	int ret = 0;
 	int val;
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
@@ -1903,7 +2029,7 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return -EOPNOTSUPP;
 
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	mrt = ip6mr_get_table_hold(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
 	if (!mrt)
 		return -ENOENT;
 
@@ -1920,26 +2046,33 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 		val = READ_ONCE(mrt->mroute_do_assert);
 		break;
 	default:
-		return -ENOPROTOOPT;
+		ret = -ENOPROTOOPT;
+		goto out;
 	}
 
-	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
-		return -EFAULT;
+	if (copy_from_sockptr(&olr, optlen, sizeof(int))) {
+		ret = -EFAULT;
+		goto out;
+	}
 
 	olr = min_t(int, olr, sizeof(int));
-	if (olr < 0)
-		return -EINVAL;
+	if (olr < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
-		return -EFAULT;
-	if (copy_to_sockptr(optval, &val, olr))
-		return -EFAULT;
-	return 0;
+	if (copy_to_sockptr(optlen, &olr, sizeof(int)) ||
+	    copy_to_sockptr(optval, &val, olr))
+		ret = -EFAULT;
+out:
+	ip6mr_put_table(mrt);
+	return ret;
 }
 
 /*
  *	The IP multicast ioctl support routines.
  */
+
 int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 {
 	struct sioc_sg_req6 *sr;
@@ -1949,7 +2082,7 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	mrt = ip6mr_get_table_hold(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
 	if (!mrt)
 		return -ENOENT;
 
@@ -1957,7 +2090,7 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	case SIOCGETMIFCNT_IN6:
 		vr = (struct sioc_mif_req6 *)arg;
 		if (vr->mifi >= mrt->maxvif)
-			return -EINVAL;
+			goto out_put_table_einval;
 		vr->mifi = array_index_nospec(vr->mifi, mrt->maxvif);
 		rcu_read_lock();
 		vif = &mrt->vif_table[vr->mifi];
@@ -1967,9 +2100,11 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 			vr->ibytes = READ_ONCE(vif->bytes_in);
 			vr->obytes = READ_ONCE(vif->bytes_out);
 			rcu_read_unlock();
+			ip6mr_put_table(mrt);
 			return 0;
 		}
 		rcu_read_unlock();
+		ip6mr_put_table(mrt);
 		return -EADDRNOTAVAIL;
 	case SIOCGETSGCNT_IN6:
 		sr = (struct sioc_sg_req6 *)arg;
@@ -1982,15 +2117,21 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 			sr->bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
 			sr->wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
+			ip6mr_put_table(mrt);
 			return 0;
 		}
 		rcu_read_unlock();
+		ip6mr_put_table(mrt);
 		return -EADDRNOTAVAIL;
 	default:
+		ip6mr_put_table(mrt);
 		return -ENOIOCTLCMD;
 	}
-}
 
+out_put_table_einval:
+	ip6mr_put_table(mrt);
+	return -EINVAL;
+}
 #ifdef CONFIG_COMPAT
 struct compat_sioc_sg_req6 {
 	struct sockaddr_in6 src;
@@ -2017,16 +2158,16 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	mrt = ip6mr_get_table_hold(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
 	if (!mrt)
 		return -ENOENT;
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		if (copy_from_user(&vr, arg, sizeof(vr)))
-			return -EFAULT;
+			goto out_put_table_efault;
 		if (vr.mifi >= mrt->maxvif)
-			return -EINVAL;
+			goto out_put_table_einval;
 		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
 		rcu_read_lock();
 		vif = &mrt->vif_table[vr.mifi];
@@ -2038,14 +2179,16 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 			rcu_read_unlock();
 
 			if (copy_to_user(arg, &vr, sizeof(vr)))
-				return -EFAULT;
+				goto out_put_table_efault;
+			ip6mr_put_table(mrt);
 			return 0;
 		}
 		rcu_read_unlock();
+		ip6mr_put_table(mrt);
 		return -EADDRNOTAVAIL;
 	case SIOCGETSGCNT_IN6:
 		if (copy_from_user(&sr, arg, sizeof(sr)))
-			return -EFAULT;
+			goto out_put_table_efault;
 
 		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
@@ -2056,14 +2199,25 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 			rcu_read_unlock();
 
 			if (copy_to_user(arg, &sr, sizeof(sr)))
-				return -EFAULT;
+				goto out_put_table_efault;
+			ip6mr_put_table(mrt);
 			return 0;
 		}
 		rcu_read_unlock();
+		ip6mr_put_table(mrt);
 		return -EADDRNOTAVAIL;
 	default:
+		ip6mr_put_table(mrt);
 		return -ENOIOCTLCMD;
 	}
+
+out_put_table_efault:
+	ip6mr_put_table(mrt);
+	return -EFAULT;
+
+out_put_table_einval:
+	ip6mr_put_table(mrt);
+	return -EINVAL;
 }
 #endif
 
@@ -2392,13 +2546,16 @@ int ip6_mr_input(struct sk_buff *skb)
 		if (vif >= 0) {
 			int err = ip6mr_cache_unresolved(mrt, vif, skb, dev);
 
+			ip6mr_put_table(mrt);
 			return err;
 		}
+		ip6mr_put_table(mrt);
 		kfree_skb(skb);
 		return -ENODEV;
 	}
 
 	ip6_mr_forward(net, mrt, dev, skb, cache);
+	ip6mr_put_table(mrt);
 
 	return 0;
 }
@@ -2441,19 +2598,25 @@ int ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	/* No usable cache entry */
 	if (!cache) {
 		vif = ip6mr_find_vif(mrt, dev);
-		if (vif >= 0)
-			return ip6mr_cache_unresolved(mrt, vif, skb, dev);
-		goto ip6_output;
+		if (vif >= 0) {
+			err = ip6mr_cache_unresolved(mrt, vif, skb, dev);
+			ip6mr_put_table(mrt);
+			return err;
+		}
+		goto out_put;
 	}
 
 	/* Wrong interface */
 	vif = cache->_c.mfc_parent;
 	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev)
-		goto ip6_output;
+		goto out_put;
 
 	ip6_mr_output_finish(net, mrt, dev, skb, cache);
+	ip6mr_put_table(mrt);
 	return 0;
 
+out_put:
+	ip6mr_put_table(mrt);
 ip6_output:
 	return ip6_output(net, sk, skb);
 }
@@ -2755,33 +2918,35 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
-	rcu_read_lock();
-
-	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
+	mrt = ip6mr_get_table_hold(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
 		err = -ENOENT;
-		goto err;
+		goto err_free;
 	}
 
+	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &src, &grp);
 	if (!cache) {
+		rcu_read_unlock();
 		NL_SET_ERR_MSG_MOD(extack, "MR cache entry not found");
 		err = -ENOENT;
-		goto err;
+		goto err_put;
 	}
 
 	err = ip6mr_fill_mroute(mrt, skb, NETLINK_CB(in_skb).portid,
 				nlh->nlmsg_seq, cache, RTM_NEWROUTE, 0);
-	if (err < 0)
-		goto err;
-
 	rcu_read_unlock();
+	if (err < 0)
+		goto err_put;
 
-	return rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+	ip6mr_put_table(mrt);
+	return err;
 
-err:
-	rcu_read_unlock();
+err_put:
+	ip6mr_put_table(mrt);
+err_free:
 	kfree_skb(skb);
 	return err;
 }
@@ -2804,7 +2969,7 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 	if (filter.table_id) {
 		struct mr_table *mrt;
 
-		mrt = __ip6mr_get_table(sock_net(skb->sk), filter.table_id);
+		mrt = ip6mr_get_table_hold(sock_net(skb->sk), filter.table_id);
 		if (!mrt) {
 			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IP6MR) {
 				err = skb->len;
@@ -2818,6 +2983,7 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 
 		err = mr_table_dump(mrt, skb, cb, _ip6mr_fill_mroute,
 				    &mfc_unres_lock, &filter);
+		ip6mr_put_table(mrt);
 		err = skb->len ? : err;
 		goto unlock;
 	}
-- 
2.43.0
