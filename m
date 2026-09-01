Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05B49E5C3
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287621; cv=none; b=l3bNQBNwTP+C8BThR+WUO9L2v6clf+Dsg8fuD6yHfOTATkgbUWjB1dEI20DrMS23Yrby/Kgo6TbcVfeWQICCyUPQxNawYzUE/2Ye+VGIXdiLuhosCPOGxmjqvnt+734AvryPevjNzuX4gZgILnynM0cwGjwCDhjtR2+3kpp3BE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287621; c=relaxed/simple;
	bh=5xm4lepHPs+mzvQ7Hvr0NNjSTJDBkkNXlh4fafS1pFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pYlG5h+mk8gLN9Ef5sSrmu+KwowTHM9aMtvVLUKfLFdGhA8Kc6lfML9XG8BJX9TFkW2ppIg1ywN9IoSqo2bOKrvsHsBhJMYmkLHYWvwsuoZr/wK7z4LIQMy4+2okbELa275q5JrGXWxtNk4o1QvPk30d0qClkwt2NKVFMPSjmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPklqWbM; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPklqWbM"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so1551378a91.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287617; x=1788892417; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5Ne5gav41nhD7R7/Rf9bDBiTuYXtBGUQ6LxaHZYs6U=;
        b=uPklqWbMKcwz6mVvtm8W9N3hy5kNIbnIi5RNXNYYf5ecya2YiNRXQprzpEroVv0ekt
         wJCst6uW0EmNn3EkVBjD+1kTGKBnKurUhWer2B7zoc5S2DhPgLvXarjxATDMQfZlV7lb
         i7KD0W4QzfONruqRWE3h5v6ZthWqC9UC5nQ7zg0zj/kN+Vz2N9u2s7fys4I8vCwHCfWW
         mJS/X171thBYldrg+saxRMs6pIjj5btMK1EY3H/pDcrhgwLqkT62bcAEok1LSytKZx2p
         CzwrLDLFd4d8pNVmtK7MclSO3gHTSg0RDEST7/xL6J7GoUAV65GkOLgbDGC2NGjCD922
         5AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287617; x=1788892417;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5Ne5gav41nhD7R7/Rf9bDBiTuYXtBGUQ6LxaHZYs6U=;
        b=jxuzb30IfRRgc6BpfCF79o0jBomIBiZ1oYBzpz0hJNiIdI4ABblyCOr+4HRd9PXKlO
         5l4WOzQnzqkJSoqPngBIDCTPG4lsF42hyQ7k+NuC3ZoSJw78IvFWBNemWR1aFkE3VA8B
         MAC1PZXzFic++KkMqq5ZEg8f3KbPW9Lr7oCxHCflBUj7rvVbB8f6bJm3xUtLvmPLRqOc
         7NLpzdHvh4yCYnndxg+IyioFvRjNtfWMgiE7Hwi55ow1RWGrhJI7Jo2H5i3OHOjbxBEp
         vW+6IbYPGdezP+gXNcqeCVeJi34KdUf4z7Y63H8qnOqI8IPThk2vztMK/FUaFzepf+W1
         Oteg==
X-Forwarded-Encrypted: i=1; AKwUvBzCRTTIWA+u7lV0cEBnEaYE4Cj7/MbkoLVz4YaFKNCaPm8toxEywi4OfLhjxmj1UqkySRfoePg=@vger.kernel.org
X-Gm-Message-State: AFuF++lFSP2ZCALcEhjDWHVCU40BS6yOdDnUUKDROQ7kgVrS/gVGsYzv
	qcTjiLnC1qAROkJuc/QmUP8Umphmavc72rEQ2n3VqzQ8qDKTKVTXG6u5I5xM9B+DaNnJl8cndKN
	Fq+2CDQ==
X-Received: from pgda8.prod.google.com ([2002:a63:7f08:0:b0:cbe:b8ad:f9bf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d8d:b0:369:7491:7b24
 with SMTP id 98e67ed59e1d1-3990f6fde75mr6227173a91.6.1788287617115; Tue, 01
 Sep 2026 11:33:37 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:58 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-10-kuniyu@google.com>
Subject: [PATCH v5 net-next 09/15] ipv6: Replace &nd_tbl with nd_table(net).
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

We will allocate per-netns neigh_table in net->neigh_tables[].

Let's replace &nd_tbl with nd_table(net).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../mellanox/mlx5/core/en/rep/neigh.c         |  7 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  2 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 13 ++-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  5 +-
 .../netronome/nfp/flower/tunnel_conf.c        |  4 +-
 drivers/net/ethernet/sfc/tc_counters.c        |  2 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |  2 +-
 drivers/net/vrf.c                             |  2 +-
 drivers/net/vxlan/vxlan_core.c                |  6 +-
 include/net/ndisc.h                           | 11 ++-
 net/bridge/br_arp_nd_proxy.c                  |  2 +-
 net/ieee802154/6lowpan/tx.c                   |  3 +-
 net/ipv4/fib_semantics.c                      |  2 +-
 net/ipv6/addrconf.c                           | 17 ++--
 net/ipv6/ip6_output.c                         |  4 +-
 net/ipv6/ndisc.c                              | 91 ++++++++++---------
 net/ipv6/route.c                              | 18 ++--
 17 files changed, 112 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
index 9894a0527789..6a8d8aac7d16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
@@ -17,26 +17,27 @@
 #include "fs_core.h"
 #include "diag/en_rep_tracepoint.h"
 
-static unsigned long mlx5e_rep_ipv6_interval(void)
+static unsigned long mlx5e_rep_ipv6_interval(struct net *net)
 {
 	if (IS_ENABLED(CONFIG_IPV6) && ipv6_mod_enabled())
-		return NEIGH_VAR(&nd_tbl.parms, DELAY_PROBE_TIME);
+		return NEIGH_VAR(&nd_table(net)->parms, DELAY_PROBE_TIME);
 
 	return ~0UL;
 }
 
 static void mlx5e_rep_neigh_update_init_interval(struct mlx5e_rep_priv *rpriv)
 {
-	unsigned long ipv6_interval = mlx5e_rep_ipv6_interval();
 	struct net_device *netdev = rpriv->netdev;
 	struct net *net = dev_net(netdev);
 	unsigned long ipv4_interval;
+	unsigned long ipv6_interval;
 	struct neigh_table *tbl;
 	struct mlx5e_priv *priv;
 
 	priv = netdev_priv(netdev);
 	tbl = arp_table(net);
 	ipv4_interval = NEIGH_VAR(&tbl->parms, DELAY_PROBE_TIME);
+	ipv6_interval = mlx5e_rep_ipv6_interval(net);
 
 	rpriv->neigh_update.min_interval = min_t(unsigned long, ipv6_interval, ipv4_interval);
 	mlx5_fc_update_sampling_interval(priv->mdev, rpriv->neigh_update.min_interval);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 33737a29ab97..67c12ca19d59 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -445,7 +445,7 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 
 #if IS_ENABLED(CONFIG_IPV6)
 		if (m_neigh->family != AF_INET)
-			tbl = &nd_tbl;
+			tbl = nd_table(net);
 		else
 #endif
 			tbl = arp_table(net);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index d2a840ce42e3..f4a435885ba4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2403,7 +2403,7 @@ mlxsw_sp_router_neighs_update_interval_init(struct mlxsw_sp *mlxsw_sp)
 #if IS_ENABLED(CONFIG_IPV6)
 	interval = min_t(unsigned long,
 			 NEIGH_VAR(&arp_table(net)->parms, DELAY_PROBE_TIME),
-			 NEIGH_VAR(&nd_tbl.parms, DELAY_PROBE_TIME));
+			 NEIGH_VAR(&nd_table(net)->parms, DELAY_PROBE_TIME));
 #else
 	interval = NEIGH_VAR(&arp_table(net)->parms, DELAY_PROBE_TIME);
 #endif
@@ -2449,6 +2449,8 @@ static void mlxsw_sp_router_neigh_ent_ipv6_process(struct mlxsw_sp *mlxsw_sp,
 						   char *rauhtd_pl,
 						   int rec_index)
 {
+	struct net *net = mlxsw_sp_net(mlxsw_sp);
+	struct neigh_table *tbl;
 	struct net_device *dev;
 	struct neighbour *n;
 	struct in6_addr dip;
@@ -2462,8 +2464,9 @@ static void mlxsw_sp_router_neigh_ent_ipv6_process(struct mlxsw_sp *mlxsw_sp,
 		return;
 	}
 
+	tbl = nd_table(net);
 	dev = mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
-	n = neigh_lookup(&nd_tbl, &dip, dev);
+	n = neigh_lookup(tbl, &dip, dev);
 	if (!n)
 		return;
 
@@ -3028,7 +3031,7 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 		goto err_arp;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+	neigh_for_each(nd_table(net), mlxsw_sp_neigh_rif_made_sync_each, &rms);
 #endif
 	if (rms.err)
 		goto err_nd;
@@ -5131,7 +5134,7 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 	case AF_INET6:
 		memcpy(&nh->gw_addr, &nh_obj->ipv6, sizeof(nh_obj->ipv6));
 #if IS_ENABLED(CONFIG_IPV6)
-		nh->neigh_tbl = &nd_tbl;
+		nh->neigh_tbl = nd_table(net);
 #endif
 		break;
 	}
@@ -6987,7 +6990,7 @@ static int mlxsw_sp_nexthop6_init(struct mlxsw_sp *mlxsw_sp,
 	nh->nh_weight = rt->fib6_nh->fib_nh_weight;
 	memcpy(&nh->gw_addr, &rt->fib6_nh->fib_nh_gw6, sizeof(nh->gw_addr));
 #if IS_ENABLED(CONFIG_IPV6)
-	nh->neigh_tbl = &nd_tbl;
+	nh->neigh_tbl = nd_table(mlxsw_sp_net(mlxsw_sp));
 #endif
 
 	err = mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 2e8577b555ca..1cd8347c274d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -564,6 +564,7 @@ mlxsw_sp_span_entry_gretap6_parms(struct mlxsw_sp *mlxsw_sp,
 	union mlxsw_sp_l3addr daddr = { .addr6 = tparm.raddr };
 	bool inherit_ttl = !tparm.hop_limit;
 	union mlxsw_sp_l3addr gw = daddr;
+	struct neigh_table *tbl = NULL;
 	struct net_device *l3edev;
 
 	if (!(to_dev->flags & IFF_UP) ||
@@ -577,9 +578,11 @@ mlxsw_sp_span_entry_gretap6_parms(struct mlxsw_sp *mlxsw_sp,
 		return mlxsw_sp_span_entry_unoffloadable(sparmsp);
 
 	l3edev = mlxsw_sp_span_gretap6_route(to_dev, &saddr.addr6, &gw.addr6);
+	if (l3edev)
+		tbl = nd_table(dev_net(l3edev));
 	return mlxsw_sp_span_entry_tunnel_parms_common(l3edev, saddr, daddr, gw,
 						       tparm.hop_limit,
-						       &nd_tbl, sparmsp);
+						       tbl, sparmsp);
 }
 
 static int
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 551db6417405..d650d33e3709 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -253,6 +253,7 @@ void nfp_tunnel_keep_alive_v6(struct nfp_app *app, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	struct nfp_tun_active_tuns_v6 *payload;
 	struct net_device *netdev;
+	struct neigh_table *tbl;
 	int count, i, pay_len;
 	struct neighbour *n;
 	void *ipv6_add;
@@ -279,7 +280,8 @@ void nfp_tunnel_keep_alive_v6(struct nfp_app *app, struct sk_buff *skb)
 		if (!netdev)
 			continue;
 
-		n = neigh_lookup(&nd_tbl, ipv6_add, netdev);
+		tbl = nd_table(dev_net(netdev));
+		n = neigh_lookup(tbl, ipv6_add, netdev);
 		if (!n)
 			continue;
 
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index f039836eaec8..793a562fc1f7 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -116,7 +116,7 @@ static void efx_tc_counter_work(struct work_struct *work)
 					 encap->neigh->egdev);
 		else
 #if IS_ENABLED(CONFIG_IPV6)
-			n = neigh_lookup(&nd_tbl,
+			n = neigh_lookup(nd_table(net),
 					 &encap->neigh->dst_ip6,
 					 encap->neigh->egdev);
 #else
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index f75c87b166ea..152c4639ecc6 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -530,7 +530,7 @@ static int efx_neigh_event(struct efx_nic *efx, struct neighbour *n)
 	if (n->tbl->family == AF_INET) {
 		keysize = sizeof(keys.dst_ip);
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (n->tbl == &nd_tbl) {
+	} else if (n->tbl->family == AF_INET6) {
 		ipv6 = true;
 		keysize = sizeof(keys.dst_ip6);
 #endif
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index a0557a3a7026..50ec04cc0213 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -616,7 +616,7 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 	nexthop = rt6_nexthop(dst_rt6_info(dst), &ipv6_hdr(skb)->daddr);
 	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(&nd_tbl, nexthop, dst->dev, false);
+		neigh = __neigh_create(nd_table(net), nexthop, dst->dev, false);
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb, false);
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 03e932744e3e..0f0dfb4e176a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2052,7 +2052,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	    ipv6_addr_is_multicast(&msg->target))
 		goto out;
 
-	n = neigh_lookup(&nd_tbl, &msg->target, dev);
+	n = neigh_lookup(nd_table(dev_net(dev)), &msg->target, dev);
 
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
@@ -2149,8 +2149,10 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 			return false;
 		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
 			return false;
+
+		tbl = nd_table(dev_net(dev));
 		pip6 = ipv6_hdr(skb);
-		n = neigh_lookup(&nd_tbl, &pip6->daddr, dev);
+		n = neigh_lookup(tbl, &pip6->daddr, dev);
 		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin6.sin6_addr = pip6->daddr,
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 8516c7ff6e92..96e3bb6e83af 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -363,7 +363,9 @@ static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, _
 
 static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev, const void *pkey)
 {
-	return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, ndisc_hashfn, pkey, dev);
+	struct neigh_table *tbl = nd_table(dev_net(dev));
+
+	return ___neigh_lookup_noref(tbl, neigh_key_eq128, ndisc_hashfn, pkey, dev);
 }
 
 static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, const void *pkey)
@@ -397,8 +399,11 @@ static inline struct neighbour *ip_neigh_gw6(struct net_device *dev,
 	struct neighbour *neigh;
 
 	neigh = __ipv6_neigh_lookup_noref(dev, addr);
-	if (unlikely(!neigh))
-		neigh = __neigh_create(&nd_tbl, addr, dev, false);
+	if (unlikely(!neigh)) {
+		struct neigh_table *tbl = nd_table(dev_net(dev));
+
+		neigh = __neigh_create(tbl, addr, dev, false);
+	}
 
 	return neigh;
 #else
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 92a3abb1e357..09458935a49e 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -470,7 +470,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
-	n = neigh_lookup(&nd_tbl, &msg->target, vlandev);
+	n = neigh_lookup(nd_table(dev_net(vlandev)), &msg->target, vlandev);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
 		u8 ha[ETH_ALEN] __aligned(2);
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 4df76ff50699..4f511476b992 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -58,8 +58,9 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 		info->daddr.mode = IEEE802154_ADDR_SHORT;
 	} else {
 		__le16 short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+		struct neigh_table *tbl = nd_table(dev_net(ldev));
 
-		n = neigh_lookup(&nd_tbl, &hdr->daddr, ldev);
+		n = neigh_lookup(tbl, &hdr->daddr, ldev);
 		if (n) {
 			llneigh = lowpan_802154_neigh(neighbour_priv(n));
 			read_lock_bh(&n->lock);
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 10a6b48218ca..d8ef92792a4a 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -617,7 +617,7 @@ static int fib_detect_death(struct fib_info *fi, int order,
 	if (likely(nhc->nhc_gw_family == AF_INET))
 		n = neigh_lookup(arp_table(net), &nhc->nhc_gw.ipv4, nhc->nhc_dev);
 	else if (IS_ENABLED(CONFIG_IPV6) && nhc->nhc_gw_family == AF_INET6)
-		n = neigh_lookup(&nd_tbl, &nhc->nhc_gw.ipv6, nhc->nhc_dev);
+		n = neigh_lookup(nd_table(net), &nhc->nhc_gw.ipv6, nhc->nhc_dev);
 	else
 		n = NULL;
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9d89be7e0544..3dba94bd2ba0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -376,6 +376,8 @@ static int snmp6_alloc_dev(struct inet6_dev *idev)
 
 static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 {
+	struct net *net = dev_net(dev);
+	struct neigh_table *tbl;
 	struct inet6_dev *ndev;
 	int err = -ENOMEM;
 
@@ -393,14 +395,15 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	ndev->dev = dev;
 	INIT_LIST_HEAD(&ndev->addr_list);
 	timer_setup(&ndev->rs_timer, addrconf_rs_timer, 0);
-	memcpy(&ndev->cnf, dev_net(dev)->ipv6.devconf_dflt, sizeof(ndev->cnf));
+	memcpy(&ndev->cnf, net->ipv6.devconf_dflt, sizeof(ndev->cnf));
 
 	if (ndev->cnf.stable_secret.initialized)
 		ndev->cnf.addr_gen_mode = IN6_ADDR_GEN_MODE_STABLE_PRIVACY;
 
+	tbl = nd_table(net);
 	ndev->cnf.mtu6 = dev->mtu;
 	ndev->ra_mtu = 0;
-	ndev->nd_parms = neigh_parms_alloc(dev, &nd_tbl);
+	ndev->nd_parms = neigh_parms_alloc(dev, tbl);
 	if (!ndev->nd_parms) {
 		kfree(ndev);
 		return ERR_PTR(err);
@@ -413,7 +416,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	if (snmp6_alloc_dev(ndev) < 0) {
 		netdev_dbg(dev, "%s: cannot allocate memory for statistics\n",
 			   __func__);
-		neigh_parms_release(&nd_tbl, ndev->nd_parms);
+		neigh_parms_release(tbl, ndev->nd_parms);
 		netdev_put(dev, &ndev->dev_tracker);
 		kfree(ndev);
 		return ERR_PTR(err);
@@ -481,7 +484,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	return ndev;
 
 err_release:
-	neigh_parms_release(&nd_tbl, ndev->nd_parms);
+	neigh_parms_release(tbl, ndev->nd_parms);
 	ndev->dead = 1;
 	in6_dev_finish_destroy(ndev);
 	return ERR_PTR(err);
@@ -4039,9 +4042,11 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 
 	/* Last: Shot the device (if unregistered) */
 	if (unregister) {
+		struct neigh_table *tbl = nd_table(net);
+
 		addrconf_sysctl_unregister(idev);
-		neigh_parms_release(&nd_tbl, idev->nd_parms);
-		neigh_ifdown(&nd_tbl, dev);
+		neigh_parms_release(tbl, idev->nd_parms);
+		neigh_ifdown(tbl, dev);
 		in6_dev_put(idev);
 	}
 	return 0;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8fc4766c8da9..995fad3bf3b2 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -127,7 +127,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	if (IS_ERR_OR_NULL(neigh)) {
 		if (unlikely(!neigh))
-			neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
+			neigh = __neigh_create(nd_table(net), nexthop, dev, false);
 		if (IS_ERR(neigh)) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
 			kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
@@ -583,7 +583,7 @@ int ip6_forward(struct sk_buff *skb)
 
 	/* XXX: idev->cnf.proxy_ndp? */
 	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {
+	    pneigh_lookup(nd_table(net), net, &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
 
 		hdr = ipv6_hdr(skb);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ed07cf78d223..e5670af1856c 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -767,10 +767,11 @@ static void ndisc_solicit(struct neighbour *neigh, struct sk_buff *skb)
 static int pndisc_is_router(const void *pkey,
 			    struct net_device *dev)
 {
+	struct net *net = dev_net(dev);
 	struct pneigh_entry *n;
 	int ret = -1;
 
-	n = pneigh_lookup(&nd_tbl, dev_net(dev), pkey, dev);
+	n = pneigh_lookup(nd_table(net), net, pkey, dev);
 	if (n)
 		ret = !!(READ_ONCE(n->flags) & NTF_ROUTER);
 
@@ -788,19 +789,21 @@ void ndisc_update(const struct net_device *dev, struct neighbour *neigh,
 
 static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 {
+	u32 ndoptlen = skb_tail_pointer(skb) - (skb_transport_header(skb) +
+				    offsetof(struct nd_msg, opt));
 	struct nd_msg *msg = (struct nd_msg *)skb_transport_header(skb);
 	const struct in6_addr *saddr = &ipv6_hdr(skb)->saddr;
 	const struct in6_addr *daddr = &ipv6_hdr(skb)->daddr;
-	u8 *lladdr = NULL;
-	u32 ndoptlen = skb_tail_pointer(skb) - (skb_transport_header(skb) +
-				    offsetof(struct nd_msg, opt));
-	struct ndisc_options ndopts;
 	struct net_device *dev = skb->dev;
-	struct inet6_ifaddr *ifp;
+	struct net *net = dev_net(dev);
+	int dad = ipv6_addr_any(saddr);
 	struct inet6_dev *idev = NULL;
+	struct ndisc_options ndopts;
+	struct inet6_ifaddr *ifp;
+	struct neigh_table *tbl;
 	struct neighbour *neigh;
-	int dad = ipv6_addr_any(saddr);
 	int is_router = -1;
+	u8 *lladdr = NULL;
 	SKB_DR(reason);
 	u64 nonce = 0;
 	bool inc;
@@ -845,9 +848,10 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	if (ndopts.nd_opts_nonce && ndopts.nd_opts_nonce->nd_opt_len == 1)
 		memcpy(&nonce, (u8 *)(ndopts.nd_opts_nonce + 1), 6);
 
-	inc = ipv6_addr_is_multicast(daddr);
+	tbl = nd_table(net);
 
-	ifp = ipv6_get_ifaddr(dev_net(dev), &msg->target, dev, 1);
+	inc = ipv6_addr_is_multicast(daddr);
+	ifp = ipv6_get_ifaddr(net, &msg->target, dev, 1);
 	if (ifp) {
 have_ifp:
 		if (ifp->flags & (IFA_F_TENTATIVE|IFA_F_OPTIMISTIC)) {
@@ -880,8 +884,6 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 
 		idev = ifp->idev;
 	} else {
-		struct net *net = dev_net(dev);
-
 		/* perhaps an address on the master device */
 		if (netif_is_l3_slave(dev)) {
 			struct net_device *mdev;
@@ -918,7 +920,7 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 				 */
 				struct sk_buff *n = skb_clone(skb, GFP_ATOMIC);
 				if (n)
-					pneigh_enqueue(&nd_tbl, idev->nd_parms, n);
+					pneigh_enqueue(tbl, idev->nd_parms, n);
 				goto out;
 			}
 		} else {
@@ -937,15 +939,15 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	}
 
 	if (inc)
-		NEIGH_CACHE_STAT_INC(&nd_tbl, rcv_probes_mcast);
+		NEIGH_CACHE_STAT_INC(tbl, rcv_probes_mcast);
 	else
-		NEIGH_CACHE_STAT_INC(&nd_tbl, rcv_probes_ucast);
+		NEIGH_CACHE_STAT_INC(tbl, rcv_probes_ucast);
 
 	/*
 	 *	update / create cache entry
 	 *	for the source address
 	 */
-	neigh = __neigh_lookup(&nd_tbl, saddr, dev,
+	neigh = __neigh_lookup(tbl, saddr, dev,
 			       !inc || lladdr || !dev->addr_len);
 	if (neigh)
 		ndisc_update(dev, neigh, lladdr, NUD_STALE,
@@ -987,17 +989,19 @@ static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr *saddr)
 
 static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 {
-	struct nd_msg *msg = (struct nd_msg *)skb_transport_header(skb);
-	struct in6_addr *saddr = &ipv6_hdr(skb)->saddr;
-	const struct in6_addr *daddr = &ipv6_hdr(skb)->daddr;
-	u8 *lladdr = NULL;
 	u32 ndoptlen = skb_tail_pointer(skb) - (skb_transport_header(skb) +
 				    offsetof(struct nd_msg, opt));
-	struct ndisc_options ndopts;
+	struct nd_msg *msg = (struct nd_msg *)skb_transport_header(skb);
+	const struct in6_addr *daddr = &ipv6_hdr(skb)->daddr;
+	struct in6_addr *saddr = &ipv6_hdr(skb)->saddr;
 	struct net_device *dev = skb->dev;
-	struct inet6_dev *idev = __in6_dev_get(dev);
+	struct net *net = dev_net(dev);
+	struct ndisc_options ndopts;
 	struct inet6_ifaddr *ifp;
+	struct neigh_table *tbl;
 	struct neighbour *neigh;
+	struct inet6_dev *idev;
+	u8 *lladdr = NULL;
 	SKB_DR(reason);
 	u8 new_state;
 
@@ -1020,6 +1024,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	 * and thus should not be accepted.
 	 * drop_unsolicited_na takes precedence over accept_untracked_na
 	 */
+	idev = __in6_dev_get(dev);
 	if (!msg->icmph.icmp6_solicited && idev &&
 	    READ_ONCE(idev->cnf.drop_unsolicited_na))
 		return reason;
@@ -1034,7 +1039,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 			return reason;
 		}
 	}
-	ifp = ipv6_get_ifaddr(dev_net(dev), &msg->target, dev, 1);
+	ifp = ipv6_get_ifaddr(net, &msg->target, dev, 1);
 	if (ifp) {
 		if (skb->pkt_type != PACKET_LOOPBACK
 		    && (ifp->flags & IFA_F_TENTATIVE)) {
@@ -1058,7 +1063,8 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		return reason;
 	}
 
-	neigh = neigh_lookup(&nd_tbl, &msg->target, dev);
+	tbl = nd_table(net);
+	neigh = neigh_lookup(tbl, &msg->target, dev);
 
 	/* RFC 9131 updates original Neighbour Discovery RFC 4861.
 	 * NAs with Target LL Address option without a corresponding
@@ -1078,14 +1084,13 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
 	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
 		if (accept_untracked_na(idev, saddr)) {
-			neigh = neigh_create(&nd_tbl, &msg->target, dev);
+			neigh = neigh_create(tbl, &msg->target, dev);
 			new_state = NUD_STALE;
 		}
 	}
 
 	if (neigh && !IS_ERR(neigh)) {
 		u8 old_flags = neigh->flags;
-		struct net *net = dev_net(dev);
 
 		if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
 			goto out;
@@ -1098,7 +1103,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
 		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
+		    pneigh_lookup(tbl, net, &msg->target, dev)) {
 			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
 		}
@@ -1127,18 +1132,20 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 static enum skb_drop_reason ndisc_recv_rs(struct sk_buff *skb)
 {
 	struct rs_msg *rs_msg = (struct rs_msg *)skb_transport_header(skb);
+	const struct in6_addr *saddr = &ipv6_hdr(skb)->saddr;
 	unsigned long ndoptlen = skb->len - sizeof(*rs_msg);
+	struct net_device *dev = skb->dev;
+	struct ndisc_options ndopts;
+	struct neigh_table *tbl;
 	struct neighbour *neigh;
 	struct inet6_dev *idev;
-	const struct in6_addr *saddr = &ipv6_hdr(skb)->saddr;
-	struct ndisc_options ndopts;
 	u8 *lladdr = NULL;
 	SKB_DR(reason);
 
 	if (skb->len < sizeof(*rs_msg))
 		return SKB_DROP_REASON_PKT_TOO_SMALL;
 
-	idev = __in6_dev_get(skb->dev);
+	idev = __in6_dev_get(dev);
 	if (!idev) {
 		net_err_ratelimited("RS: can't find in6 device\n");
 		return reason;
@@ -1156,19 +1163,19 @@ static enum skb_drop_reason ndisc_recv_rs(struct sk_buff *skb)
 		goto out;
 
 	/* Parse ND options */
-	if (!ndisc_parse_options(skb->dev, rs_msg->opt, ndoptlen, &ndopts))
+	if (!ndisc_parse_options(dev, rs_msg->opt, ndoptlen, &ndopts))
 		return SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS;
 
 	if (ndopts.nd_opts_src_lladdr) {
-		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr,
-					     skb->dev);
+		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr, dev);
 		if (!lladdr)
 			goto out;
 	}
 
-	neigh = __neigh_lookup(&nd_tbl, saddr, skb->dev, 1);
+	tbl = nd_table(dev_net(dev));
+	neigh = __neigh_lookup(tbl, saddr, dev, 1);
 	if (neigh) {
-		ndisc_update(skb->dev, neigh, lladdr, NUD_STALE,
+		ndisc_update(dev, neigh, lladdr, NUD_STALE,
 			     NEIGH_UPDATE_F_WEAK_OVERRIDE|
 			     NEIGH_UPDATE_F_OVERRIDE|
 			     NEIGH_UPDATE_F_OVERRIDE_ISROUTER,
@@ -1232,6 +1239,7 @@ static void ndisc_ra_useropt(struct sk_buff *ra, struct nd_opt_hdr *opt)
 static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 {
 	struct ra_msg *ra_msg = (struct ra_msg *)skb_transport_header(skb);
+	struct net *net = dev_net(skb->dev);
 	bool send_ifinfo_notify = false;
 	struct neighbour *neigh = NULL;
 	struct ndisc_options ndopts;
@@ -1241,7 +1249,6 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	u32 defrtr_usr_metric;
 	unsigned int pref = 0;
 	__u32 old_if_flags;
-	struct net *net;
 	SKB_DR(reason);
 	int lifetime;
 	int optlen;
@@ -1330,7 +1337,6 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	/* Do not accept RA with source-addr found on local machine unless
 	 * accept_ra_from_local is set to true.
 	 */
-	net = dev_net(in6_dev->dev);
 	if (!READ_ONCE(in6_dev->cnf.accept_ra_from_local) &&
 	    ipv6_chk_addr(net, &ipv6_hdr(skb)->saddr, in6_dev->dev, 0)) {
 		net_dbg_ratelimited("RA from local address detected on dev: %s: default router ignored\n",
@@ -1468,7 +1474,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	 */
 
 	if (!neigh)
-		neigh = __neigh_lookup(&nd_tbl, &ipv6_hdr(skb)->saddr,
+		neigh = __neigh_lookup(nd_table(net), &ipv6_hdr(skb)->saddr,
 				       skb->dev, 1);
 	if (neigh) {
 		u8 *lladdr = NULL;
@@ -1861,12 +1867,15 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct netdev_notifier_change_info *change_info;
 	struct net *net = dev_net(dev);
+	struct neigh_table *tbl;
 	struct inet6_dev *idev;
 	bool evict_nocarrier;
 
+	tbl = nd_table(net);
+
 	switch (event) {
 	case NETDEV_CHANGEADDR:
-		neigh_changeaddr(&nd_tbl, dev);
+		neigh_changeaddr(tbl, dev);
 		fib6_run_gc(0, net, false);
 		fallthrough;
 	case NETDEV_UP:
@@ -1890,12 +1899,12 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 
 		change_info = ptr;
 		if (change_info->flags_changed & IFF_NOARP)
-			neigh_changeaddr(&nd_tbl, dev);
+			neigh_changeaddr(tbl, dev);
 		if (evict_nocarrier && !netif_carrier_ok(dev))
-			neigh_carrier_down(&nd_tbl, dev);
+			neigh_carrier_down(tbl, dev);
 		break;
 	case NETDEV_DOWN:
-		neigh_ifdown(&nd_tbl, dev);
+		neigh_ifdown(tbl, dev);
 		fib6_run_gc(0, net, false);
 		break;
 	case NETDEV_NOTIFY_PEERS:
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6a40c5074543..9da705638d55 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -217,7 +217,7 @@ struct neighbour *ip6_neigh_lookup(const struct in6_addr *gw,
 	if (n)
 		return n;
 
-	n = neigh_create(&nd_tbl, daddr, dev);
+	n = neigh_create(nd_table(dev_net(dev)), daddr, dev);
 	return IS_ERR(n) ? NULL : n;
 }
 
@@ -4241,6 +4241,7 @@ static int ip6_route_del(struct fib6_config *cfg,
 static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buff *skb)
 {
 	struct netevent_redirect netevent;
+	struct net_device *dev = skb->dev;
 	struct rt6_info *rt, *nrt = NULL;
 	struct fib6_result res = {};
 	struct ndisc_options ndopts;
@@ -4274,7 +4275,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 		return;
 	}
 
-	in6_dev = __in6_dev_get(skb->dev);
+	in6_dev = __in6_dev_get(dev);
 	if (!in6_dev)
 		return;
 	if (READ_ONCE(in6_dev->cnf.forwarding) ||
@@ -4286,15 +4287,14 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	 *	first-hop router for the specified ICMP Destination Address.
 	 */
 
-	if (!ndisc_parse_options(skb->dev, msg->opt, optlen, &ndopts)) {
+	if (!ndisc_parse_options(dev, msg->opt, optlen, &ndopts)) {
 		net_dbg_ratelimited("rt6_redirect: invalid ND options\n");
 		return;
 	}
 
 	lladdr = NULL;
 	if (ndopts.nd_opts_tgt_lladdr) {
-		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr,
-					     skb->dev);
+		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr, dev);
 		if (!lladdr) {
 			net_dbg_ratelimited("rt6_redirect: invalid link-layer address length\n");
 			return;
@@ -4313,7 +4313,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	 */
 	dst_confirm_neigh(&rt->dst, &ipv6_hdr(skb)->saddr);
 
-	neigh = __neigh_lookup(&nd_tbl, &msg->target, skb->dev, 1);
+	neigh = __neigh_lookup(nd_table(dev_net(dev)), &msg->target, dev, 1);
 	if (!neigh)
 		return;
 
@@ -4321,7 +4321,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	 *	We have finally decided to accept it.
 	 */
 
-	ndisc_update(skb->dev, neigh, lladdr, NUD_STALE,
+	ndisc_update(dev, neigh, lladdr, NUD_STALE,
 		     NEIGH_UPDATE_F_WEAK_OVERRIDE|
 		     NEIGH_UPDATE_F_OVERRIDE|
 		     (on_link ? 0 : (NEIGH_UPDATE_F_OVERRIDE_ISROUTER|
@@ -5042,9 +5042,11 @@ void rt6_sync_down_dev(struct net_device *dev, unsigned long event)
 
 void rt6_disable_ip(struct net_device *dev, unsigned long event)
 {
+	struct net *net = dev_net(dev);
+
 	rt6_sync_down_dev(dev, event);
 	rt6_uncached_list_flush_dev(dev);
-	neigh_ifdown(&nd_tbl, dev);
+	neigh_ifdown(nd_table(net), dev);
 }
 
 struct rt6_mtu_change_arg {
-- 
2.55.0.966.g6673acef38-goog

