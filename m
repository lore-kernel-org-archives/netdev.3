Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7B49E5EC
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287620; cv=none; b=oE2PihthDaqym/V7EkQzpxRinSk+CUZ5yJ0UZqf+vOXPX2M5jDD4auX7WmgcRuFUxOqmbvNVzb3YMld13/nMr8OuCCkuzSw8GrhM2U5oFekDvUyZVtBQZIsYFSk0xZT/zMM0QS1MhfuvSlp6v6TLKP1xvclcFQ+aWuxliVjqv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287620; c=relaxed/simple;
	bh=Jim88Zp8Rnx7N1tYeXOljTAYDQdOHy8NUsDJgcIvQh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dkhBhjHqBdQQnRlSOfXLVlbrzGZbq0BX5e8p/JwMm993KXb/WtJ1f/tpXsQWHTL8711FfTJYhSw2sEbRTDMwH3+qo446ABnMf7vKZIT7s1wMO/elw9EV/hWcUmpTPAPuBxPRchcDU6WbaH07ePZcGurkHGug171qNZHYa82zMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lASgZhD5; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lASgZhD5"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398e1fafe17so194818a91.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287617; x=1788892417; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sAjDC98Qvn3mEQzKpAKdQvAvhG5qJTXjaisDXwU1Nw=;
        b=lASgZhD5tqdSXAxBIoy5nPzSjEnLmpUrTnwgrAT2cnw80wXKE+hM0N4Y+HYDkliOEq
         XjVNhMgsHJj0BLRdZQ+DR8QSxJLi8x9UQluKAL8j2LOYIIbjD4xTg61ZzrFknKhlwKOH
         Cxx4g0zx9JIKoAfFRmFvDxHMUyMW3X7E6pyb9my7ny10/s5sZiFxiLTQRGZ1L2TgLZmY
         WTE1mPwRxjLdadsMDKlwZASuKIR3NfP5jx66UL0zq6roZQEmUklfoUQJt87BCcEg5fm6
         D125Z5dPGbVpwO9Xg3UQ0y6NT/4GdDnbnU8xhZhGGuW9nQCYVV4BLLH6qbI4L6lZ+Oy8
         fLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287617; x=1788892417;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+sAjDC98Qvn3mEQzKpAKdQvAvhG5qJTXjaisDXwU1Nw=;
        b=cW4hUiQh5ZKZ/YLCK1gk5G8WF0dFYmCjIjFz2OwsxrugD5zNSjTDPFLEMCYw39eG7X
         H2/xzU1MP5Sot2wtll53vQcgRTR6eR9G6/FpY8JWk38JR3w8U/wneZVVJKz+/em+CDV5
         G0zNdDlaW4cxH+YV39DL+N7nEMseKr2TriAm+4Yw5cwFLq1kXObi6FG+5pxbO++bc+Zm
         0ZuudPK1MQTy+qeZ/ptPjeKrzq+G+8wFFtC0jPJ8kx8cruhsc+qgAcfUztyIYPtAdALV
         gbL81dhsmBzwpe0mVFOZ4hwGsuuESwIOkoesvD3t9mv+pdiD2L8DhgKVcTtcs0znbbdS
         7HWw==
X-Forwarded-Encrypted: i=1; AKwUvBzKz0feU5tix6ECrqyICALZuo6wABkByw8NdDPCQJrDR0niFSprrle8UhgXQzf08mOyk+2YTC4=@vger.kernel.org
X-Gm-Message-State: AFuF++mf6W4/yB8q1UwjwtLOul56x1lvs196yy+x1TyL0Yss/BpkK11s
	jYxzDRGUk3fF/imBJ1wZITqMkqOanTZXnKmmgVHAvPyt1Tu7pRc390fJU35jCSCjuFJLwcg5yZj
	enfSbkQ==
X-Received: from pjff15.prod.google.com ([2002:a17:90b:562f:b0:38e:77e2:3e70])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acf:b0:398:b17b:3bd2
 with SMTP id 98e67ed59e1d1-398b17b3dd4mr34390037a91.4.1788287616317; Tue, 01
 Sep 2026 11:33:36 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:57 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-9-kuniyu@google.com>
Subject: [PATCH v5 net-next 08/15] ipv4: Replace &arp_tbl with arp_table(net).
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Elad Nachman <enachman@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Petr Machata <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	Edward Cree <ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"

We will allocate per-netns neigh_table in net->neigh_tables[].

Let's replace &arp_tbl with arp_table(net) and remove extern
definition for arp_tbl.

Three notes:

  1. mlx5e_rep_netevent_event() and nfp_tun_neigh_event_handler()
     have code assuming neigh_table other than &arp_tbl and
     &nb_tbl, and the part is removed as it will be false once
     per-netns table is allocated.

  2. prestera and rocker uses init_net because they set
     dev->netns_immutable to true.

  3. mlx5e_tc_update_neigh_used_value() dereferences nhe->neigh_dev
     in trace_mlx5e_tc_update_neigh_used_value().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: Add note about mlx5e_tc_update_neigh_used_value()

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Elad Nachman <enachman@marvell.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>
Cc: Boris Pismenny <borisp@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c     | 27 ++++--
 .../marvell/prestera/prestera_router.c        | 10 ++-
 .../mellanox/mlx5/core/en/rep/neigh.c         | 22 ++---
 .../mellanox/mlx5/core/en/tc_tun_encap.c      | 23 ++---
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  6 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 18 ++--
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  5 +-
 .../netronome/nfp/flower/tunnel_conf.c        | 10 +--
 drivers/net/ethernet/rocker/rocker_main.c     |  2 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c    |  2 +-
 drivers/net/ethernet/sfc/tc_counters.c        |  6 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |  2 +-
 drivers/net/vxlan/vxlan_core.c                | 10 ++-
 include/net/arp.h                             |  6 +-
 include/net/route.h                           |  7 +-
 net/bridge/br_arp_nd_proxy.c                  |  2 +-
 net/ipv4/arp.c                                | 88 +++++++++++--------
 net/ipv4/devinet.c                            | 18 ++--
 net/ipv4/fib_semantics.c                      |  5 +-
 net/ipv4/route.c                              |  2 +-
 20 files changed, 159 insertions(+), 112 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 6c14246befb1..dfee72c8e46a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1378,7 +1378,8 @@ struct ipoib_neigh *ipoib_neigh_get(struct net_device *dev, u8 *daddr)
 	return neigh;
 }
 
-static void __ipoib_reap_neigh(struct ipoib_dev_priv *priv)
+static void __ipoib_reap_neigh(struct ipoib_dev_priv *priv,
+			       int gc_interval)
 {
 	struct ipoib_neigh_table *ntbl = &priv->ntbl;
 	struct ipoib_neigh_hash *htbl;
@@ -1397,7 +1398,7 @@ static void __ipoib_reap_neigh(struct ipoib_dev_priv *priv)
 		goto out_unlock;
 
 	/* neigh is obsolete if it was idle for two GC periods */
-	dt = 2 * arp_tbl.gc_interval;
+	dt = 2 * gc_interval;
 	neigh_obsolete = jiffies - dt;
 
 	for (i = 0; i < htbl->size; i++) {
@@ -1433,11 +1434,16 @@ static void ipoib_reap_neigh(struct work_struct *work)
 {
 	struct ipoib_dev_priv *priv =
 		container_of(work, struct ipoib_dev_priv, neigh_reap_task.work);
+	struct net_device *dev = priv->dev;
+	struct net *net = dev_net(dev);
+	struct neigh_table *tbl;
+	int gc_interval;
 
-	__ipoib_reap_neigh(priv);
+	tbl = arp_table(net);
+	gc_interval = tbl->gc_interval;
+	__ipoib_reap_neigh(priv, gc_interval);
 
-	queue_delayed_work(priv->wq, &priv->neigh_reap_task,
-			   arp_tbl.gc_interval);
+	queue_delayed_work(priv->wq, &priv->neigh_reap_task, gc_interval);
 }
 
 
@@ -1590,8 +1596,11 @@ void ipoib_neigh_free(struct ipoib_neigh *neigh)
 static int ipoib_neigh_hash_init(struct ipoib_dev_priv *priv)
 {
 	struct ipoib_neigh_table *ntbl = &priv->ntbl;
-	struct ipoib_neigh_hash *htbl;
 	struct ipoib_neigh __rcu **buckets;
+	struct net_device *dev = priv->dev;
+	struct net *net = dev_net(dev);
+	struct ipoib_neigh_hash *htbl;
+	struct neigh_table *tbl;
 	u32 size;
 
 	clear_bit(IPOIB_NEIGH_TBL_FLUSH, &priv->flags);
@@ -1599,7 +1608,9 @@ static int ipoib_neigh_hash_init(struct ipoib_dev_priv *priv)
 	htbl = kzalloc_obj(*htbl);
 	if (!htbl)
 		return -ENOMEM;
-	size = roundup_pow_of_two(arp_tbl.gc_thresh3);
+
+	tbl = arp_table(net);
+	size = roundup_pow_of_two(tbl->gc_thresh3);
 	buckets = kvzalloc_objs(*buckets, size);
 	if (!buckets) {
 		kfree(htbl);
@@ -1614,7 +1625,7 @@ static int ipoib_neigh_hash_init(struct ipoib_dev_priv *priv)
 
 	/* start garbage collection */
 	queue_delayed_work(priv->wq, &priv->neigh_reap_task,
-			   arp_tbl.gc_interval);
+			   tbl->gc_interval);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/drivers/net/ethernet/marvell/prestera/prestera_router.c
index 0c4f462baa6e..ba45b61b09bb 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
@@ -683,7 +683,7 @@ __prestera_k_arb_n_offload_set(struct prestera_switch *sw,
 {
 	struct neighbour *n;
 
-	n = neigh_lookup(&arp_tbl, &nc->key.addr.u.ipv4,
+	n = neigh_lookup(arp_table(&init_net), &nc->key.addr.u.ipv4,
 			 nc->key.dev);
 	if (!n)
 		return;
@@ -790,7 +790,7 @@ __prestera_k_arb_nc_kern_n_fetch(struct prestera_switch *sw,
 	int err;
 
 	memset(&nc->nh_neigh_info, 0, sizeof(nc->nh_neigh_info));
-	n = neigh_lookup(&arp_tbl, &nc->key.addr.u.ipv4, nc->key.dev);
+	n = neigh_lookup(arp_table(&init_net), &nc->key.addr.u.ipv4, nc->key.dev);
 	if (!n)
 		goto out;
 
@@ -1052,10 +1052,12 @@ static void __prestera_k_arb_hw_state_upd(struct prestera_switch *sw,
 #endif /* PRESTERA_IMPLICITY_RESOLVE_DEAD_NEIGH */
 
 	if (nc->key.addr.v == PRESTERA_IPV4) {
-		n = neigh_lookup(&arp_tbl, &nc->key.addr.u.ipv4,
+		struct neigh_table *tbl = arp_table(&init_net);
+
+		n = neigh_lookup(tbl, &nc->key.addr.u.ipv4,
 				 nc->key.dev);
 		if (!n)
-			n = neigh_create(&arp_tbl, &nc->key.addr.u.ipv4,
+			n = neigh_create(tbl, &nc->key.addr.u.ipv4,
 					 nc->key.dev);
 	} else {
 		n = NULL;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
index 648f4521c096..9894a0527789 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
@@ -27,10 +27,16 @@ static unsigned long mlx5e_rep_ipv6_interval(void)
 
 static void mlx5e_rep_neigh_update_init_interval(struct mlx5e_rep_priv *rpriv)
 {
-	unsigned long ipv4_interval = NEIGH_VAR(&arp_tbl.parms, DELAY_PROBE_TIME);
 	unsigned long ipv6_interval = mlx5e_rep_ipv6_interval();
 	struct net_device *netdev = rpriv->netdev;
-	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct net *net = dev_net(netdev);
+	unsigned long ipv4_interval;
+	struct neigh_table *tbl;
+	struct mlx5e_priv *priv;
+
+	priv = netdev_priv(netdev);
+	tbl = arp_table(net);
+	ipv4_interval = NEIGH_VAR(&tbl->parms, DELAY_PROBE_TIME);
 
 	rpriv->neigh_update.min_interval = min_t(unsigned long, ipv6_interval, ipv4_interval);
 	mlx5_fc_update_sampling_interval(priv->mdev, rpriv->neigh_update.min_interval);
@@ -217,12 +223,6 @@ static int mlx5e_rep_netevent_event(struct notifier_block *nb,
 	switch (event) {
 	case NETEVENT_NEIGH_UPDATE:
 		n = ptr;
-#if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl != &nd_tbl && n->tbl != &arp_tbl)
-#else
-		if (n->tbl != &arp_tbl)
-#endif
-			return NOTIFY_DONE;
 
 		update_work = mlx5e_alloc_neigh_update_work(priv, n);
 		if (!update_work)
@@ -238,11 +238,7 @@ static int mlx5e_rep_netevent_event(struct notifier_block *nb,
 		 * changes in the default table, we only care about changes
 		 * done per device delay prob time parameter.
 		 */
-#if IS_ENABLED(CONFIG_IPV6)
-		if (!p->dev || (p->tbl != &nd_tbl && p->tbl != &arp_tbl))
-#else
-		if (!p->dev || p->tbl != &arp_tbl)
-#endif
+		if (!p->dev)
 			return NOTIFY_DONE;
 
 		rcu_read_lock();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 8b827201935e..33737a29ab97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -393,20 +393,10 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 	struct mlx5e_encap_entry *e = NULL;
 	struct mlx5e_tc_flow *flow;
 	struct mlx5_fc *counter;
-	struct neigh_table *tbl;
 	bool neigh_used = false;
 	struct neighbour *n;
 	u64 lastuse;
 
-	if (m_neigh->family == AF_INET)
-		tbl = &arp_tbl;
-#if IS_ENABLED(CONFIG_IPV6)
-	else if (m_neigh->family == AF_INET6)
-		tbl = &nd_tbl;
-#endif
-	else
-		return;
-
 	/* mlx5e_get_next_valid_encap() releases previous encap before returning
 	 * next one.
 	 */
@@ -447,12 +437,23 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 	trace_mlx5e_tc_update_neigh_used_value(nhe, neigh_used);
 
 	if (neigh_used) {
+		struct net_device *dev = READ_ONCE(nhe->neigh_dev);
+		struct net *net = dev_net(dev);
+		struct neigh_table *tbl;
+
 		nhe->reported_lastuse = jiffies;
 
+#if IS_ENABLED(CONFIG_IPV6)
+		if (m_neigh->family != AF_INET)
+			tbl = &nd_tbl;
+		else
+#endif
+			tbl = arp_table(net);
+
 		/* find the relevant neigh according to the cached device and
 		 * dst ip pair
 		 */
-		n = neigh_lookup(tbl, &m_neigh->dst_ip, READ_ONCE(nhe->neigh_dev));
+		n = neigh_lookup(tbl, &m_neigh->dst_ip, dev);
 		if (!n)
 			return;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index db260e3d1412..37a8ddee3ea1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -262,6 +262,7 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	struct net_device *netdev = sa_entry->dev;
 	struct xfrm_state *x = sa_entry->x;
 	struct dst_entry *rt_dst_entry;
+	struct neigh_table *tbl;
 	struct flowi4 fl4 = {};
 	struct flowi6 fl6 = {};
 	struct neighbour *n;
@@ -364,9 +365,10 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	return;
 
 neigh:
-	n = neigh_lookup(&arp_tbl, pkey, netdev);
+	tbl = arp_table(dev_net(netdev));
+	n = neigh_lookup(tbl, pkey, netdev);
 	if (!n) {
-		n = neigh_create(&arp_tbl, pkey, netdev);
+		n = neigh_create(tbl, pkey, netdev);
 		if (IS_ERR(n))
 			return;
 		neigh_event_send(n, NULL);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 3d6fdbab05e0..d2a840ce42e3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2397,14 +2397,15 @@ mlxsw_sp_neigh_entry_lookup(struct mlxsw_sp *mlxsw_sp, struct neighbour *n)
 static void
 mlxsw_sp_router_neighs_update_interval_init(struct mlxsw_sp *mlxsw_sp)
 {
+	struct net *net = mlxsw_sp_net(mlxsw_sp);
 	unsigned long interval;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	interval = min_t(unsigned long,
-			 NEIGH_VAR(&arp_tbl.parms, DELAY_PROBE_TIME),
+			 NEIGH_VAR(&arp_table(net)->parms, DELAY_PROBE_TIME),
 			 NEIGH_VAR(&nd_tbl.parms, DELAY_PROBE_TIME));
 #else
-	interval = NEIGH_VAR(&arp_tbl.parms, DELAY_PROBE_TIME);
+	interval = NEIGH_VAR(&arp_table(net)->parms, DELAY_PROBE_TIME);
 #endif
 	mlxsw_sp->router->neighs_update.interval = jiffies_to_msecs(interval);
 }
@@ -2414,6 +2415,8 @@ static void mlxsw_sp_router_neigh_ent_ipv4_process(struct mlxsw_sp *mlxsw_sp,
 						   int ent_index)
 {
 	u64 max_rifs = MLXSW_CORE_RES_GET(mlxsw_sp->core, MAX_RIFS);
+	struct net *net = mlxsw_sp_net(mlxsw_sp);
+	struct neigh_table *tbl;
 	struct net_device *dev;
 	struct neighbour *n;
 	__be32 dipn;
@@ -2429,9 +2432,10 @@ static void mlxsw_sp_router_neigh_ent_ipv4_process(struct mlxsw_sp *mlxsw_sp,
 		return;
 	}
 
+	tbl = arp_table(net);
 	dipn = htonl(dip);
 	dev = mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
-	n = neigh_lookup(&arp_tbl, &dipn, dev);
+	n = neigh_lookup(tbl, &dipn, dev);
 	if (!n)
 		return;
 
@@ -3014,11 +3018,12 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 		.mlxsw_sp = mlxsw_sp,
 		.rif = rif,
 	};
+	struct net *net = mlxsw_sp_net(mlxsw_sp);
 
 	if (!mlxsw_sp_dev_lower_is_port(mlxsw_sp_rif_dev(rif)))
 		return 0;
 
-	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+	neigh_for_each(arp_table(net), mlxsw_sp_neigh_rif_made_sync_each, &rms);
 	if (rms.err)
 		goto err_arp;
 
@@ -4622,7 +4627,7 @@ static int mlxsw_sp_nexthop4_init(struct mlxsw_sp *mlxsw_sp,
 	nh->nh_weight = 1;
 #endif
 	memcpy(&nh->gw_addr, &fib_nh->fib_nh_gw4, sizeof(fib_nh->fib_nh_gw4));
-	nh->neigh_tbl = &arp_tbl;
+	nh->neigh_tbl = arp_table(mlxsw_sp_net(mlxsw_sp));
 	err = mlxsw_sp_nexthop_insert(mlxsw_sp, nh);
 	if (err)
 		return err;
@@ -5112,6 +5117,7 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 			  struct nh_notifier_single_info *nh_obj, int weight)
 {
 	struct net_device *dev = nh_obj->dev;
+	struct net *net = dev_net(dev);
 	int err;
 
 	nh->nhgi = nh_grp->nhgi;
@@ -5120,7 +5126,7 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 	switch (nh_obj->gw_family) {
 	case AF_INET:
 		memcpy(&nh->gw_addr, &nh_obj->ipv4, sizeof(nh_obj->ipv4));
-		nh->neigh_tbl = &arp_tbl;
+		nh->neigh_tbl = arp_table(net);
 		break;
 	case AF_INET6:
 		memcpy(&nh->gw_addr, &nh_obj->ipv6, sizeof(nh_obj->ipv6));
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index ae63d549b542..2e8577b555ca 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -456,6 +456,7 @@ mlxsw_sp_span_entry_gretap4_parms(struct mlxsw_sp *mlxsw_sp,
 	bool inherit_tos = tparm.iph.tos & 0x1;
 	bool inherit_ttl = !tparm.iph.ttl;
 	union mlxsw_sp_l3addr gw = daddr;
+	struct neigh_table *tbl = NULL;
 	struct net_device *l3edev;
 
 	if (!(to_dev->flags & IFF_UP) ||
@@ -469,9 +470,11 @@ mlxsw_sp_span_entry_gretap4_parms(struct mlxsw_sp *mlxsw_sp,
 		return mlxsw_sp_span_entry_unoffloadable(sparmsp);
 
 	l3edev = mlxsw_sp_span_gretap4_route(to_dev, &saddr.addr4, &gw.addr4);
+	if (l3edev)
+		tbl = arp_table(dev_net(l3edev));
 	return mlxsw_sp_span_entry_tunnel_parms_common(l3edev, saddr, daddr, gw,
 						       tparm.iph.ttl,
-						       &arp_tbl, sparmsp);
+						       tbl, sparmsp);
 }
 
 static int
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index ca30702f8878..551db6417405 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -209,6 +209,7 @@ void nfp_tunnel_keep_alive(struct nfp_app *app, struct sk_buff *skb)
 {
 	struct nfp_tun_active_tuns *payload;
 	struct net_device *netdev;
+	struct neigh_table *tbl;
 	int count, i, pay_len;
 	struct neighbour *n;
 	__be32 ipv4_addr;
@@ -235,7 +236,8 @@ void nfp_tunnel_keep_alive(struct nfp_app *app, struct sk_buff *skb)
 		if (!netdev)
 			continue;
 
-		n = neigh_lookup(&arp_tbl, &ipv4_addr, netdev);
+		tbl = arp_table(dev_net(netdev));
+		n = neigh_lookup(tbl, &ipv4_addr, netdev);
 		if (!n)
 			continue;
 
@@ -729,12 +731,6 @@ nfp_tun_neigh_event_handler(struct notifier_block *nb, unsigned long event,
 	default:
 		return NOTIFY_DONE;
 	}
-#if IS_ENABLED(CONFIG_IPV6)
-	if (n->tbl != &nd_tbl && n->tbl != &arp_tbl)
-#else
-	if (n->tbl != &arp_tbl)
-#endif
-		return NOTIFY_DONE;
 
 	app_priv = container_of(nb, struct nfp_flower_priv, tun.neigh_nb);
 	app = app_priv->app;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 84a55f2b48ff..0fcd65fc0af7 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -3134,7 +3134,7 @@ static int rocker_netevent_event(struct notifier_block *unused,
 
 	switch (event) {
 	case NETEVENT_NEIGH_UPDATE:
-		if (n->tbl != &arp_tbl)
+		if (n->tbl != arp_table(&init_net))
 			return NOTIFY_DONE;
 		dev = n->dev;
 		if (!rocker_port_dev_check(dev))
diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 15d19a8a1710..ead8b447b89c 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -1336,7 +1336,7 @@ static int ofdpa_port_ipv4_resolve(struct ofdpa_port *ofdpa_port,
 	int err = 0;
 
 	if (!n) {
-		n = neigh_create(&arp_tbl, &ip_addr, dev);
+		n = neigh_create(arp_table(&init_net), &ip_addr, dev);
 		if (IS_ERR(n))
 			return PTR_ERR(n);
 	}
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index b84235e93ffe..f039836eaec8 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -91,6 +91,7 @@ static void efx_tc_counter_work(struct work_struct *work)
 	struct efx_tc_action_set *act;
 	unsigned long touched;
 	struct neighbour *n;
+	struct net *net;
 
 	spin_lock_bh(&cnt->lock);
 	touched = READ_ONCE(cnt->touched);
@@ -103,12 +104,15 @@ static void efx_tc_counter_work(struct work_struct *work)
 			continue;
 		if (time_after_eq(encap->neigh->used, touched))
 			continue;
+
 		encap->neigh->used = touched;
+		net = encap->neigh->net;
+
 		/* We have passed traffic using this ARP entry, so
 		 * indicate to the ARP cache that it's still active
 		 */
 		if (encap->neigh->dst_ip)
-			n = neigh_lookup(&arp_tbl, &encap->neigh->dst_ip,
+			n = neigh_lookup(arp_table(net), &encap->neigh->dst_ip,
 					 encap->neigh->egdev);
 		else
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index c2ad3a358d20..f75c87b166ea 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -527,7 +527,7 @@ static int efx_neigh_event(struct efx_nic *efx, struct neighbour *n)
 	if (WARN_ON(!efx->tc))
 		return NOTIFY_DONE;
 
-	if (n->tbl == &arp_tbl) {
+	if (n->tbl->family == AF_INET) {
 		keysize = sizeof(keys.dst_ip);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (n->tbl == &nd_tbl) {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 459f19f7071e..03e932744e3e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1841,11 +1841,12 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 
 static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 {
+	struct neigh_table *tbl = arp_table(dev_net(dev));
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct neighbour *n;
 	struct arphdr *parp;
 	u8 *arpptr, *sha;
 	__be32 sip, tip;
-	struct neighbour *n;
 
 	if (dev->flags & IFF_NOARP)
 		goto out;
@@ -1877,7 +1878,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	    ipv4_is_multicast(tip))
 		goto out;
 
-	n = neigh_lookup(&arp_tbl, &tip, dev);
+	n = neigh_lookup(tbl, &tip, dev);
 
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
@@ -2106,6 +2107,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct neigh_table *tbl;
 	struct neighbour *n;
 
 	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
@@ -2119,8 +2121,10 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 
 		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
 			return false;
+
+		tbl = arp_table(dev_net(dev));
 		pip = ip_hdr(skb);
-		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
+		n = neigh_lookup(tbl, &pip->daddr, dev);
 		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin.sin_addr.s_addr = pip->daddr,
diff --git a/include/net/arp.h b/include/net/arp.h
index f8d18b1f8b28..e932def63d62 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -7,8 +7,6 @@
 #include <linux/hash.h>
 #include <net/neighbour.h>
 
-extern struct neigh_table arp_tbl;
-
 static inline struct neigh_table *arp_table(struct net *net)
 {
 	return net->neigh_tables[NEIGH_ARP_TABLE];
@@ -25,10 +23,12 @@ static inline u32 arp_hashfn(const void *pkey, const struct net_device *dev, u32
 #ifdef CONFIG_INET
 static inline struct neighbour *__ipv4_neigh_lookup_noref(struct net_device *dev, u32 key)
 {
+	struct neigh_table *tbl = arp_table(dev_net(dev));
+
 	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
 		key = INADDR_ANY;
 
-	return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn, &key, dev);
+	return ___neigh_lookup_noref(tbl, neigh_key_eq32, arp_hashfn, &key, dev);
 }
 #else
 static inline
diff --git a/include/net/route.h b/include/net/route.h
index 45290177a33c..6b55de2e4df8 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -405,8 +405,11 @@ static inline struct neighbour *ip_neigh_gw4(struct net_device *dev,
 	struct neighbour *neigh;
 
 	neigh = __ipv4_neigh_lookup_noref(dev, (__force u32)daddr);
-	if (unlikely(!neigh))
-		neigh = __neigh_create(&arp_tbl, &daddr, dev, false);
+	if (unlikely(!neigh)) {
+		struct neigh_table *tbl = arp_table(dev_net(dev));
+
+		neigh = __neigh_create(tbl, &daddr, dev, false);
+	}
 
 	return neigh;
 }
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 87a40e2f1c50..92a3abb1e357 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -193,7 +193,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
-	n = neigh_lookup(&arp_tbl, &tip, vlandev);
+	n = neigh_lookup(arp_table(dev_net(vlandev)), &tip, vlandev);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
 		u8 ha[ETH_ALEN] __aligned(2);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 824c65c70408..a44fa68fdd07 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -149,7 +149,7 @@ static const struct neigh_ops arp_direct_ops = {
 	.connected_output =	neigh_direct_output,
 };
 
-struct neigh_table arp_tbl = {
+static struct neigh_table arp_tbl = {
 	.family		= AF_INET,
 	.key_len	= 4,
 	.protocol	= cpu_to_be16(ETH_P_IP),
@@ -182,7 +182,6 @@ struct neigh_table arp_tbl = {
 	.gc_thresh2	= 512,
 	.gc_thresh3	= 1024,
 };
-EXPORT_SYMBOL(arp_tbl);
 
 int arp_mc_map(__be32 addr, u8 *haddr, struct net_device *dev, int dir)
 {
@@ -222,14 +221,18 @@ static bool arp_key_eq(const struct neighbour *neigh, const void *pkey)
 
 static int arp_constructor(struct neighbour *neigh)
 {
-	__be32 addr;
 	struct net_device *dev = neigh->dev;
-	struct in_device *in_dev;
-	struct neigh_parms *parms;
+	struct net *net = dev_net(dev);
 	u32 inaddr_any = INADDR_ANY;
+	struct neigh_parms *parms;
+	struct in_device *in_dev;
+	struct neigh_table *tbl;
+	__be32 addr;
+
+	tbl = arp_table(net);
 
 	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
-		memcpy(neigh->primary_key, &inaddr_any, arp_tbl.key_len);
+		memcpy(neigh->primary_key, &inaddr_any, tbl->key_len);
 
 	addr = *(__be32 *)neigh->primary_key;
 	rcu_read_lock();
@@ -239,7 +242,7 @@ static int arp_constructor(struct neighbour *neigh)
 		return -EINVAL;
 	}
 
-	neigh->type = inet_addr_type_dev_table(dev_net(dev), dev, addr);
+	neigh->type = inet_addr_type_dev_table(net, dev, addr);
 
 	parms = in_dev->arp_parms;
 	__neigh_parms_put(neigh->parms);
@@ -701,24 +704,24 @@ static bool arp_is_garp(struct net *net, struct net_device *dev,
 
 static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	struct neigh_table *tbl = arp_table(net);
+	struct dst_entry *reply_dst = NULL;
 	struct net_device *dev = skb->dev;
-	struct in_device *in_dev = __in_dev_get_rcu(dev);
-	struct arphdr *arp;
+	unsigned char *sha, *tha = NULL;
+	struct in_device *in_dev;
+	u16 dev_type = dev->type;
 	unsigned char *arp_ptr;
+	bool is_garp = false;
+	struct neighbour *n;
+	struct arphdr *arp;
 	struct rtable *rt;
-	unsigned char *sha;
-	unsigned char *tha = NULL;
 	__be32 sip, tip;
-	u16 dev_type = dev->type;
 	int addr_type;
-	struct neighbour *n;
-	struct dst_entry *reply_dst = NULL;
-	bool is_garp = false;
 
 	/* arp_rcv below verifies the ARP header and verifies the device
 	 * is ARP'able.
 	 */
-
+	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev)
 		goto out_free_skb;
 
@@ -850,7 +853,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			if (!dont_send && IN_DEV_ARPFILTER(in_dev))
 				dont_send = arp_filter(sip, tip, dev);
 			if (!dont_send) {
-				n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
+				n = neigh_event_ns(tbl, sha, &sip, dev);
 				if (n) {
 					arp_send_dst(ARPOP_REPLY, ETH_P_ARP,
 						     sip, dev, tip, sha,
@@ -865,8 +868,8 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			    (arp_fwd_proxy(in_dev, dev, rt) ||
 			     arp_fwd_pvlan(in_dev, dev, rt, sip, tip) ||
 			     (rt->dst.dev != dev &&
-			      pneigh_lookup(&arp_tbl, net, &tip, dev)))) {
-				n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
+			      pneigh_lookup(tbl, net, &tip, dev)))) {
+				n = neigh_event_ns(tbl, sha, &sip, dev);
 				if (n)
 					neigh_release(n);
 
@@ -878,7 +881,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 						     dev->dev_addr, sha,
 						     reply_dst);
 				} else {
-					pneigh_enqueue(&arp_tbl,
+					pneigh_enqueue(tbl,
 						       in_dev->arp_parms, skb);
 					goto out_free_dst;
 				}
@@ -889,7 +892,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	/* Update our ARP tables */
 
-	n = __neigh_lookup(&arp_tbl, &sip, dev, 0);
+	n = __neigh_lookup(tbl, &sip, dev, 0);
 
 	addr_type = -1;
 	if (n || arp_accept(in_dev, sip)) {
@@ -910,7 +913,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			/* postpone calculation to as late as possible */
 			inet_addr_type_dev_table(net, dev, sip) ==
 				RTN_UNICAST)))))
-			n = __neigh_lookup(&arp_tbl, &sip, dev, 1);
+			n = __neigh_lookup(tbl, &sip, dev, 1);
 	}
 
 	if (n) {
@@ -1077,9 +1080,10 @@ static int arp_req_set_proxy(struct net *net, struct net_device *dev, int on)
 }
 
 static int arp_req_set_public(struct net *net, struct arpreq *r,
-		struct net_device *dev)
+			      struct net_device *dev)
 {
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
+	struct neigh_table *tbl = arp_table(net);
 
 	if (!dev && (r->arp_flags & ATF_COM)) {
 		dev = dev_getbyhwaddr(net, r->arp_ha.sa_family,
@@ -1090,7 +1094,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	if (mask) {
 		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-		return pneigh_create(&arp_tbl, net, &ip, dev, 0, 0, false);
+		return pneigh_create(tbl, net, &ip, dev, 0, 0, false);
 	}
 
 	return arp_req_set_proxy(net, dev, 1);
@@ -1098,6 +1102,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 
 static int arp_req_set(struct net *net, struct arpreq *r)
 {
+	struct neigh_table *tbl = arp_table(net);
 	struct neighbour *neigh;
 	struct net_device *dev;
 	__be32 ip;
@@ -1133,7 +1138,7 @@ static int arp_req_set(struct net *net, struct arpreq *r)
 
 	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-	neigh = __neigh_lookup_errno(&arp_tbl, &ip, dev);
+	neigh = __neigh_lookup_errno(tbl, &ip, dev);
 	err = PTR_ERR(neigh);
 	if (!IS_ERR(neigh)) {
 		unsigned int state = NUD_STALE;
@@ -1169,6 +1174,7 @@ static unsigned int arp_state_to_flags(struct neighbour *neigh)
 static int arp_req_get(struct net *net, struct arpreq *r)
 {
 	__be32 ip = ((struct sockaddr_in *) &r->arp_pa)->sin_addr.s_addr;
+	struct neigh_table *tbl = arp_table(net);
 	struct neighbour *neigh;
 	struct net_device *dev;
 
@@ -1179,7 +1185,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	neigh = neigh_lookup(&arp_tbl, &ip, dev);
+	neigh = neigh_lookup(tbl, &ip, dev);
 	if (!neigh)
 		return -ENXIO;
 
@@ -1204,10 +1210,11 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 
 int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 {
-	struct neighbour *neigh = neigh_lookup(&arp_tbl, &ip, dev);
+	struct neigh_table *tbl = arp_table(dev_net(dev));
+	struct neighbour *neigh;
 	int err = -ENXIO;
-	struct neigh_table *tbl = &arp_tbl;
 
+	neigh = neigh_lookup(tbl, &ip, dev);
 	if (neigh) {
 		if ((READ_ONCE(neigh->nud_state) & NUD_VALID) && !force) {
 			neigh_release(neigh);
@@ -1228,14 +1235,15 @@ int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 }
 
 static int arp_req_delete_public(struct net *net, struct arpreq *r,
-		struct net_device *dev)
+				 struct net_device *dev)
 {
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
+	struct neigh_table *tbl = arp_table(net);
 
 	if (mask) {
 		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-		return pneigh_delete(&arp_tbl, net, &ip, dev);
+		return pneigh_delete(tbl, net, &ip, dev);
 	}
 
 	return arp_req_set_proxy(net, dev, 0);
@@ -1325,18 +1333,22 @@ static int arp_netdev_event(struct notifier_block *this, unsigned long event,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct netdev_notifier_change_info *change_info;
+	struct net *net = dev_net(dev);
 	struct in_device *in_dev;
+	struct neigh_table *tbl;
 	bool evict_nocarrier;
 
+	tbl = arp_table(net);
+
 	switch (event) {
 	case NETDEV_CHANGEADDR:
-		neigh_changeaddr(&arp_tbl, dev);
-		rt_cache_flush(dev_net(dev));
+		neigh_changeaddr(tbl, dev);
+		rt_cache_flush(net);
 		break;
 	case NETDEV_CHANGE:
 		change_info = ptr;
 		if (change_info->flags_changed & IFF_NOARP)
-			neigh_changeaddr(&arp_tbl, dev);
+			neigh_changeaddr(tbl, dev);
 
 		in_dev = __in_dev_get_rtnl(dev);
 		if (!in_dev)
@@ -1345,7 +1357,7 @@ static int arp_netdev_event(struct notifier_block *this, unsigned long event,
 			evict_nocarrier = IN_DEV_ARP_EVICT_NOCARRIER(in_dev);
 
 		if (evict_nocarrier && !netif_carrier_ok(dev))
-			neigh_carrier_down(&arp_tbl, dev);
+			neigh_carrier_down(tbl, dev);
 		break;
 	default:
 		break;
@@ -1364,7 +1376,9 @@ static struct notifier_block arp_netdev_notifier = {
  */
 void arp_ifdown(struct net_device *dev)
 {
-	neigh_ifdown(&arp_tbl, dev);
+	struct neigh_table *tbl = arp_table(dev_net(dev));
+
+	neigh_ifdown(tbl, dev);
 }
 
 
@@ -1479,10 +1493,12 @@ static int arp_seq_show(struct seq_file *seq, void *v)
 
 static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
 {
+	struct neigh_table *tbl = arp_table(seq_file_net(seq));
+
 	/* Don't want to confuse "arp -a" w/ magic entries,
 	 * so we tell the generic iterator to skip NUD_NOARP.
 	 */
-	return neigh_seq_start(seq, pos, &arp_tbl, NEIGH_SEQ_SKIP_NOARP);
+	return neigh_seq_start(seq, pos, tbl, NEIGH_SEQ_SKIP_NOARP);
 }
 
 static const struct seq_operations arp_seq_ops = {
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a90be57c63be..247d666824a4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -265,7 +265,9 @@ EXPORT_SYMBOL(in_dev_finish_destroy);
 
 static struct in_device *inetdev_init(struct net_device *dev)
 {
+	struct net *net = dev_net(dev);
 	struct in_device *in_dev;
+	struct neigh_table *tbl;
 	int err = -ENOMEM;
 
 	ASSERT_RTNL();
@@ -273,11 +275,12 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	in_dev = kzalloc_obj(*in_dev);
 	if (!in_dev)
 		goto out;
-	memcpy(&in_dev->cnf, dev_net(dev)->ipv4.devconf_dflt,
-			sizeof(in_dev->cnf));
+
+	tbl = arp_table(net);
+	memcpy(&in_dev->cnf, net->ipv4.devconf_dflt, sizeof(in_dev->cnf));
 	in_dev->cnf.sysctl = NULL;
 	in_dev->dev = dev;
-	in_dev->arp_parms = neigh_parms_alloc(dev, &arp_tbl);
+	in_dev->arp_parms = neigh_parms_alloc(dev, tbl);
 	if (!in_dev->arp_parms)
 		goto out_kfree;
 	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
@@ -291,7 +294,7 @@ static struct in_device *inetdev_init(struct net_device *dev)
 		err = devinet_sysctl_register(in_dev);
 		if (err) {
 			in_dev->dead = 1;
-			neigh_parms_release(&arp_tbl, in_dev->arp_parms);
+			neigh_parms_release(tbl, in_dev->arp_parms);
 			in_dev_put(in_dev);
 			in_dev = NULL;
 			goto out;
@@ -313,13 +316,12 @@ static struct in_device *inetdev_init(struct net_device *dev)
 
 static void inetdev_destroy(struct in_device *in_dev)
 {
-	struct net_device *dev;
+	struct net_device *dev = in_dev->dev;
+	struct net *net = dev_net(dev);
 	struct in_ifaddr *ifa;
 
 	ASSERT_RTNL();
 
-	dev = in_dev->dev;
-
 	in_dev->dead = 1;
 
 	RCU_INIT_POINTER(dev->ip_ptr, NULL);
@@ -332,7 +334,7 @@ static void inetdev_destroy(struct in_device *in_dev)
 	}
 
 	devinet_sysctl_unregister(in_dev);
-	neigh_parms_release(&arp_tbl, in_dev->arp_parms);
+	neigh_parms_release(arp_table(net), in_dev->arp_parms);
 	arp_ifdown(dev);
 
 	in_dev_put(in_dev);
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 0483519b7fb0..10a6b48218ca 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -610,11 +610,12 @@ static int fib_detect_death(struct fib_info *fi, int order,
 			    int dflt)
 {
 	const struct fib_nh_common *nhc = fib_info_nhc(fi, 0);
-	struct neighbour *n;
+	struct net *net = fi->fib_net;
 	int state = NUD_NONE;
+	struct neighbour *n;
 
 	if (likely(nhc->nhc_gw_family == AF_INET))
-		n = neigh_lookup(&arp_tbl, &nhc->nhc_gw.ipv4, nhc->nhc_dev);
+		n = neigh_lookup(arp_table(net), &nhc->nhc_gw.ipv4, nhc->nhc_dev);
 	else if (IS_ENABLED(CONFIG_IPV6) && nhc->nhc_gw_family == AF_INET6)
 		n = neigh_lookup(&nd_tbl, &nhc->nhc_gw.ipv6, nhc->nhc_dev);
 	else
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 37674d76f90f..d7da2f1acbb5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -817,7 +817,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 
 	n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw);
 	if (!n)
-		n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
+		n = neigh_create(arp_table(net), &new_gw, rt->dst.dev);
 	if (!IS_ERR(n)) {
 		if (!(READ_ONCE(n->nud_state) & NUD_VALID)) {
 			neigh_event_send(n, NULL);
-- 
2.55.0.966.g6673acef38-goog

