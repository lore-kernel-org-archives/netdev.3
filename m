Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB249E129
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062651; cv=none; b=tP/RSElFoBlWfsY6RIHaS8AxvLC+vCO0oyZYGF2++d9Se/DAFYTbaCE5S1kdHS7hsOebLZjIWDn4PdUWtnCxbA7YNozTzubrZGuCfCZM6/zj2B5dPLqhF5JerUEyQgp482UlqdTIrG90t36qS03XFpxWNgw/BiUACYgrlty3I3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062651; c=relaxed/simple;
	bh=pJRy5YcwshjlAMeLFbbKe1cBfvTMp8Ak0Cyl1HOk7U0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XRyk1DG5Qj8MmEh1lwCgxlcuAt0D4T/+H+xTkiz45Jk6xLcCzTiqyMFkAomtKBOl4aqBsQLxLQrVhdyobV8XJGrV3o8jiBwwpn3zpeVSDa/X3u8JyaixUv5TL2i/8ghb7piimLolQPIGukWOfJkaMz22RAFLj+VgR0h93dSecTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2Yf1Y9S; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2Yf1Y9S"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so929007a91.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062649; x=1791667449; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/BKQYxYNJsKVPcmH8XOgnyUzNgT1zIc3N4t8BD/9oI=;
        b=T2Yf1Y9SJCHVQ0WM7kLHV6LbaGkeLAKxz7kBaMresvaib6+OC+rQQYqzkEcK8QMovC
         5P8is1k3Db012rp2Zi9yhLH7ZmNOjIjp0IQpHXsCvGMkS7FUi9DlubNTSM1qOkKveEyH
         LNSFX7awJ4xgJzof5ciwulNn3CEOyeUC4ytZJ5fuXV2PH4MsE3dtx9PEZcSzhMZhrRiy
         vvl8EKUL10Wmm4ZKXixcq1EF3NA4asjZb/i+Gb1uW9TaU4UCcS1CJiJzD9DFoGU/8uEw
         RTtxpRXp1a4baeiuk7ydt1d0zFRRWUmwcBfHgBXotWt2LyAvPpV7bJq4gjdIlqQoCtnF
         RJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062649; x=1791667449;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w/BKQYxYNJsKVPcmH8XOgnyUzNgT1zIc3N4t8BD/9oI=;
        b=ae5i8p91zcd1k7dHmrDi9PsOFNoGMcCDsuBimB3gpyH48+tRbCDqGaBqwTmXvZOtap
         UoVnzNKJ8wmmGyjkFXMZwYZ1/Yjyczd8gbw/S0XvH26R7v9Ju0IlhBDT7ZOLS74pVyau
         n5R2eOm5HCu1lRZlHbr4SDl8KhGmkaUJQ70JPVx6FwjwcrOorktsJH5CUOdf1V0x3Nnq
         ALudpwiaStqRck2khG3swAWq2cW79Rqo6cEq82DkkTzvkqbmhJ3RawdZwRGaoXsP7+0H
         HOoPDOdfflyh68hFu1DBJqz0+gIQX/ijGWHkYNvUAUy6s25FGnlAGD+iAOlQ3w5YB5oH
         sx5g==
X-Forwarded-Encrypted: i=1; AKwUvBxBNqe594VeZ+FzL5JkY1IjC61wlYTY0KnWjoPJl33g5xswl+1K6QIAGvxlB7uktLiaUrhNlnI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN2cKRbBKKeeLxQWcuz5LYrps95XMneLtNi2Mt/gRZvlwW6oRt
	TAp3jeVUkhSmSaI6st1g1ZNicVP6APBNKeMqY6i9B/wRMW0axrxEmfyMcRyv8CNWZvgZg22uQsY
	GZyWFKA==
X-Received: from pgby17-n2.prod.google.com ([2002:a05:6a02:6511:20b0:cc7:85ef:361e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a89:b0:39e:53a:c8d4
 with SMTP id 98e67ed59e1d1-3a6ce6df006mr6150967a91.12.1791062648400; Sat, 03
 Oct 2026 14:24:08 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:20 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 7/9] ipv4: Use ipv4_neigh_lookup() and friends.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Elad Nachman <enachman@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Petr Machata <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	Edward Cree <ecree.xilinx@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

It is error-prone to require callers to fetch netns and
neigh_table and pass it with dev to neigh_lookup(), etc.

Let's replace neigh_lookup() and friends with IPv4 helpers.

Note that __neigh_lookup(create=false) is replaced with
ipv4_neigh_lookup() and __neigh_lookup(create=true) and
__neigh_lookup_errno() are split into ipv4_neigh_lookup()
and ipv4_neigh_create().

Fixes: 2430df635a59 ("ipv4: Replace &arp_tbl with arp_table(net).")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Convert __teql_resolve()

Cc: Elad Nachman <enachman@marvell.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>
Cc: Boris Pismenny <borisp@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../marvell/prestera/prestera_router.c        | 14 ++++------
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  3 +--
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  6 ++---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 13 +++-------
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  7 ++---
 .../netronome/nfp/flower/tunnel_conf.c        |  4 +--
 drivers/net/ethernet/rocker/rocker_ofdpa.c    |  2 +-
 drivers/net/ethernet/sfc/tc_counters.c        |  6 ++---
 drivers/net/vxlan/vxlan_core.c                |  8 ++----
 net/bridge/br_arp_nd_proxy.c                  |  2 +-
 net/ipv4/arp.c                                | 26 ++++++++++++-------
 net/ipv4/fib_semantics.c                      |  3 +--
 net/ipv4/route.c                              |  2 +-
 net/sched/sch_teql.c                          |  5 +++-
 14 files changed, 42 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/drivers/net/ethernet/marvell/prestera/prestera_router.c
index ba45b61b09bb..44c9c1fa3189 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
@@ -683,8 +683,7 @@ __prestera_k_arb_n_offload_set(struct prestera_switch *sw,
 {
 	struct neighbour *n;
 
-	n = neigh_lookup(arp_table(&init_net), &nc->key.addr.u.ipv4,
-			 nc->key.dev);
+	n = ipv4_neigh_lookup(nc->key.dev, &nc->key.addr.u.ipv4);
 	if (!n)
 		return;
 
@@ -790,7 +789,7 @@ __prestera_k_arb_nc_kern_n_fetch(struct prestera_switch *sw,
 	int err;
 
 	memset(&nc->nh_neigh_info, 0, sizeof(nc->nh_neigh_info));
-	n = neigh_lookup(arp_table(&init_net), &nc->key.addr.u.ipv4, nc->key.dev);
+	n = ipv4_neigh_lookup(nc->key.dev, &nc->key.addr.u.ipv4);
 	if (!n)
 		goto out;
 
@@ -1052,13 +1051,10 @@ static void __prestera_k_arb_hw_state_upd(struct prestera_switch *sw,
 #endif /* PRESTERA_IMPLICITY_RESOLVE_DEAD_NEIGH */
 
 	if (nc->key.addr.v == PRESTERA_IPV4) {
-		struct neigh_table *tbl = arp_table(&init_net);
-
-		n = neigh_lookup(tbl, &nc->key.addr.u.ipv4,
-				 nc->key.dev);
+		n = ipv4_neigh_lookup(nc->key.dev, &nc->key.addr.u.ipv4);
 		if (!n)
-			n = neigh_create(tbl, &nc->key.addr.u.ipv4,
-					 nc->key.dev);
+			n = ipv4_neigh_create(nc->key.dev,
+					      &nc->key.addr.u.ipv4);
 	} else {
 		n = NULL;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index fe0258375ef6..5e40107efa26 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -438,7 +438,6 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 
 	if (neigh_used) {
 		struct net_device *dev = READ_ONCE(nhe->neigh_dev);
-		struct net *net = dev_net(dev);
 
 		nhe->reported_lastuse = jiffies;
 
@@ -450,7 +449,7 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 			n = ipv6_neigh_lookup(dev, &m_neigh->dst_ip);
 		else
 #endif
-			n = neigh_lookup(arp_table(net), &m_neigh->dst_ip, dev);
+			n = ipv4_neigh_lookup(dev, &m_neigh->dst_ip);
 		if (!n)
 			return;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 37a8ddee3ea1..16edd3263aed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -262,7 +262,6 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	struct net_device *netdev = sa_entry->dev;
 	struct xfrm_state *x = sa_entry->x;
 	struct dst_entry *rt_dst_entry;
-	struct neigh_table *tbl;
 	struct flowi4 fl4 = {};
 	struct flowi6 fl6 = {};
 	struct neighbour *n;
@@ -365,10 +364,9 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	return;
 
 neigh:
-	tbl = arp_table(dev_net(netdev));
-	n = neigh_lookup(tbl, pkey, netdev);
+	n = ipv4_neigh_lookup(netdev, pkey);
 	if (!n) {
-		n = neigh_create(tbl, pkey, netdev);
+		n = ipv4_neigh_create(netdev, pkey);
 		if (IS_ERR(n))
 			return;
 		neigh_event_send(n, NULL);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 1f4753213b9c..07d22257b703 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2415,8 +2415,6 @@ static void mlxsw_sp_router_neigh_ent_ipv4_process(struct mlxsw_sp *mlxsw_sp,
 						   int ent_index)
 {
 	u64 max_rifs = MLXSW_CORE_RES_GET(mlxsw_sp->core, MAX_RIFS);
-	struct net *net = mlxsw_sp_net(mlxsw_sp);
-	struct neigh_table *tbl;
 	struct net_device *dev;
 	struct neighbour *n;
 	__be32 dipn;
@@ -2432,10 +2430,9 @@ static void mlxsw_sp_router_neigh_ent_ipv4_process(struct mlxsw_sp *mlxsw_sp,
 		return;
 	}
 
-	tbl = arp_table(net);
 	dipn = htonl(dip);
 	dev = mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
-	n = neigh_lookup(tbl, &dipn, dev);
+	n = ipv4_neigh_lookup(dev, &dipn);
 	if (!n)
 		return;
 
@@ -4300,13 +4297,10 @@ static void __mlxsw_sp_nexthop_neigh_update(struct mlxsw_sp_nexthop *nh,
 static struct neighbour *
 mlxsw_sp_nexthop_neigh_lookup(struct mlxsw_sp_nexthop *nh)
 {
-	struct neigh_table *tbl;
 	struct net_device *dev;
 	struct neighbour *n;
-	struct net *net;
 
 	dev = mlxsw_sp_nexthop_dev(nh);
-	net = dev_net(dev);
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (nh->family == AF_INET6) {
@@ -4319,10 +4313,9 @@ mlxsw_sp_nexthop_neigh_lookup(struct mlxsw_sp_nexthop *nh)
 	} else
 #endif
 	{
-		tbl = arp_table(net);
-		n = neigh_lookup(tbl, &nh->gw_addr, dev);
+		n = ipv4_neigh_lookup(dev, &nh->gw_addr);
 		if (!n) {
-			n = neigh_create(tbl, &nh->gw_addr, dev);
+			n = ipv4_neigh_create(dev, &nh->gw_addr);
 			if (!IS_ERR(n))
 				neigh_event_send(n, NULL);
 		}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 79947f68b10d..0b84a25e2ea8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -229,8 +229,6 @@ static int mlxsw_sp_span_dmac(int family,
 			      struct net_device *dev,
 			      unsigned char dmac[ETH_ALEN])
 {
-	struct net *net = dev_net(dev);
-	struct neigh_table *tbl;
 	struct neighbour *neigh;
 	int err = 0;
 
@@ -245,10 +243,9 @@ static int mlxsw_sp_span_dmac(int family,
 	} else
 #endif
 	{
-		tbl = arp_table(net);
-		neigh = neigh_lookup(tbl, pkey, dev);
+		neigh = ipv4_neigh_lookup(dev, pkey);
 		if (!neigh) {
-			neigh = neigh_create(tbl, pkey, dev);
+			neigh = ipv4_neigh_create(dev, pkey);
 			if (IS_ERR(neigh))
 				return PTR_ERR(neigh);
 		}
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 27d80ec8e895..3b47e9fe64e1 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -209,7 +209,6 @@ void nfp_tunnel_keep_alive(struct nfp_app *app, struct sk_buff *skb)
 {
 	struct nfp_tun_active_tuns *payload;
 	struct net_device *netdev;
-	struct neigh_table *tbl;
 	int count, i, pay_len;
 	struct neighbour *n;
 	__be32 ipv4_addr;
@@ -236,8 +235,7 @@ void nfp_tunnel_keep_alive(struct nfp_app *app, struct sk_buff *skb)
 		if (!netdev)
 			continue;
 
-		tbl = arp_table(dev_net(netdev));
-		n = neigh_lookup(tbl, &ipv4_addr, netdev);
+		n = ipv4_neigh_lookup(netdev, &ipv4_addr);
 		if (!n)
 			continue;
 
diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index ead8b447b89c..ace69a1d5275 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -1336,7 +1336,7 @@ static int ofdpa_port_ipv4_resolve(struct ofdpa_port *ofdpa_port,
 	int err = 0;
 
 	if (!n) {
-		n = neigh_create(arp_table(&init_net), &ip_addr, dev);
+		n = ipv4_neigh_create(dev, &ip_addr);
 		if (IS_ERR(n))
 			return PTR_ERR(n);
 	}
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index ae6cc6b93864..fcb2be6abb20 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -91,7 +91,6 @@ static void efx_tc_counter_work(struct work_struct *work)
 	struct efx_tc_action_set *act;
 	unsigned long touched;
 	struct neighbour *n;
-	struct net *net;
 
 	spin_lock_bh(&cnt->lock);
 	touched = READ_ONCE(cnt->touched);
@@ -106,14 +105,13 @@ static void efx_tc_counter_work(struct work_struct *work)
 			continue;
 
 		encap->neigh->used = touched;
-		net = encap->neigh->net;
 
 		/* We have passed traffic using this ARP entry, so
 		 * indicate to the ARP cache that it's still active
 		 */
 		if (encap->neigh->dst_ip)
-			n = neigh_lookup(arp_table(net), &encap->neigh->dst_ip,
-					 encap->neigh->egdev);
+			n = ipv4_neigh_lookup(encap->neigh->egdev,
+					      &encap->neigh->dst_ip);
 		else
 #if IS_ENABLED(CONFIG_IPV6)
 			n = ipv6_neigh_lookup(encap->neigh->egdev,
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 513779c07621..35bd92f5e460 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1877,7 +1877,6 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 static int arp_reduce(struct net_device *dev, struct sk_buff *skb,
 		      const struct vxlan_config *cfg, __be32 vni)
 {
-	struct neigh_table *tbl = arp_table(dev_net(dev));
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct neighbour *n;
 	struct arphdr *parp;
@@ -1914,8 +1913,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb,
 	    ipv4_is_multicast(tip))
 		goto out;
 
-	n = neigh_lookup(tbl, &tip, dev);
-
+	n = ipv4_neigh_lookup(dev, &tip);
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
 		u8 ha[ETH_ALEN] __aligned(2);
@@ -2145,7 +2143,6 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb,
 static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb,
 			       const struct vxlan_config *cfg)
 {
-	struct neigh_table *tbl;
 	struct neighbour *n;
 
 	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
@@ -2160,9 +2157,8 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb,
 		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
 			return false;
 
-		tbl = arp_table(dev_net(dev));
 		pip = ip_hdr(skb);
-		n = neigh_lookup(tbl, &pip->daddr, dev);
+		n = ipv4_neigh_lookup(dev, &pip->daddr);
 		if (!n && (cfg->flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin.sin_addr.s_addr = pip->daddr,
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index c23b99517cd5..2123344a5677 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -210,7 +210,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
-	n = neigh_lookup(arp_table(dev_net(vlandev)), &tip, vlandev);
+	n = ipv4_neigh_lookup(vlandev, &tip);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
 		u8 ha[ETH_ALEN] __aligned(2);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 95f3359d0f92..1ca4ced280ae 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -892,7 +892,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	/* Update our ARP tables */
 
-	n = __neigh_lookup(tbl, &sip, dev, 0);
+	n = ipv4_neigh_lookup(dev, &sip);
 
 	addr_type = -1;
 	if (n || arp_accept(in_dev, sip)) {
@@ -911,9 +911,14 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 		      (addr_type == RTN_UNICAST ||
 		       (addr_type < 0 &&
 			/* postpone calculation to as late as possible */
-			inet_addr_type_dev_table(net, dev, sip) ==
-				RTN_UNICAST)))))
-			n = __neigh_lookup(tbl, &sip, dev, 1);
+			inet_addr_type_dev_table(net, dev, sip) == RTN_UNICAST))))) {
+			n = ipv4_neigh_lookup(dev, &sip);
+			if (!n) {
+				n = ipv4_neigh_create(dev, &sip);
+				if (IS_ERR(n))
+					n = NULL;
+			}
+		}
 	}
 
 	if (n) {
@@ -1102,7 +1107,6 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 
 static int arp_req_set(struct net *net, struct arpreq *r)
 {
-	struct neigh_table *tbl = arp_table(net);
 	struct neighbour *neigh;
 	struct net_device *dev;
 	__be32 ip;
@@ -1138,7 +1142,9 @@ static int arp_req_set(struct net *net, struct arpreq *r)
 
 	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-	neigh = __neigh_lookup_errno(tbl, &ip, dev);
+	neigh = ipv4_neigh_lookup(dev, &ip);
+	if (!neigh)
+		neigh = ipv4_neigh_create(dev, &ip);
 	err = PTR_ERR(neigh);
 	if (!IS_ERR(neigh)) {
 		unsigned int state = NUD_STALE;
@@ -1174,7 +1180,6 @@ static unsigned int arp_state_to_flags(struct neighbour *neigh)
 static int arp_req_get(struct net *net, struct arpreq *r)
 {
 	__be32 ip = ((struct sockaddr_in *) &r->arp_pa)->sin_addr.s_addr;
-	struct neigh_table *tbl = arp_table(net);
 	struct neighbour *neigh;
 	struct net_device *dev;
 
@@ -1185,7 +1190,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	neigh = neigh_lookup(tbl, &ip, dev);
+	neigh = ipv4_neigh_lookup(dev, &ip);
 	if (!neigh)
 		return -ENXIO;
 
@@ -1210,12 +1215,13 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 
 int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 {
-	struct neigh_table *tbl = arp_table(dev_net(dev));
 	struct neighbour *neigh;
 	int err = -ENXIO;
 
-	neigh = neigh_lookup(tbl, &ip, dev);
+	neigh = ipv4_neigh_lookup(dev, &ip);
 	if (neigh) {
+		struct neigh_table *tbl = neigh->tbl;
+
 		if ((READ_ONCE(neigh->nud_state) & NUD_VALID) && !force) {
 			neigh_release(neigh);
 			return 0;
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index a98c7670d2ce..235c51a6f8e5 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -610,12 +610,11 @@ static int fib_detect_death(struct fib_info *fi, int order,
 			    int dflt)
 {
 	const struct fib_nh_common *nhc = fib_info_nhc(fi, 0);
-	struct net *net = fi->fib_net;
 	int state = NUD_NONE;
 	struct neighbour *n;
 
 	if (likely(nhc->nhc_gw_family == AF_INET))
-		n = neigh_lookup(arp_table(net), &nhc->nhc_gw.ipv4, nhc->nhc_dev);
+		n = ipv4_neigh_lookup(nhc->nhc_dev, &nhc->nhc_gw.ipv4);
 	else if (IS_ENABLED(CONFIG_IPV6) && nhc->nhc_gw_family == AF_INET6)
 		n = ipv6_neigh_lookup(nhc->nhc_dev, &nhc->nhc_gw.ipv6);
 	else
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 50c842617e45..18b588dfbea7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -817,7 +817,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 
 	n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw);
 	if (!n)
-		n = neigh_create(arp_table(net), &new_gw, rt->dst.dev);
+		n = ipv4_neigh_create(rt->dst.dev, &new_gw);
 	if (!IS_ERR(n)) {
 		if (!(READ_ONCE(n->nud_state) & NUD_VALID)) {
 			neigh_event_send(n, NULL);
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 19ccf1a55988..e9cb7d408ca0 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/moduleparam.h>
+#include <net/arp.h>
 #include <net/dst.h>
 #include <net/ndisc.h>
 #include <net/neighbour.h>
@@ -266,7 +267,9 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 		} else
 #endif
 		{
-			mn = __neigh_lookup_errno(n->tbl, n->primary_key, dev);
+			mn = ipv4_neigh_lookup(dev, n->primary_key);
+			if (!mn)
+				mn = ipv4_neigh_create(dev, n->primary_key);
 		}
 		neigh_release(n);
 		if (IS_ERR(mn))
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

