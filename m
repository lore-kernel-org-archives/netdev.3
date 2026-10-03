Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C7456E18
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062649; cv=none; b=l9NPQ2kzilIjl13QWAyyky3Mn+x8uNAXOogfCWtqCRE+92cwzevO8JdGIj2u/jrcjp0/ht5S6tpiUt4DbKIDCNmMKSeVUznG+ngRQKcT8gFt3Nx8F0eAsURwznmXhDaYoQTGi960eSgdgHX8XPpxQvPOLtTY9A2bc8Uraey97tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062649; c=relaxed/simple;
	bh=/2j2QxFnDf+ddiLCZhBdTfongOoCGhwNNuXF+/v6vSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oavLbNlW23m61zKV1l5ZzTK7pa95zdGU9Y9cObXKBSxr43ZCd7ogpffXk6aabmAL9CnC6uIr8ZmADiiAdwMnrOMrgCG0Sj7hrTkqVNT5ObIVpaZhuPPOXIdBG9ByCsqeDUFmhNUsfTfo2Tmjlw937OLRQfhJobs6D6rcF/uBrRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7XJEVRe; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7XJEVRe"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso441088a91.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062647; x=1791667447; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QeW5W5E1AW3R1QgePH0+zeJVnlZw3qE3znhBQ67XAA=;
        b=T7XJEVReOTlDGEMJ2XPw+etxEFufRfQi89PC4QIpsb2Ejsj2W0HqPYdU5oXSjIeSqE
         I6bVpa3c9vZUayRn0GKXdKy1a+j8qAJEjwRHRvZWNZYx71qtB/3faFC4OELtJJ9oVwpn
         O7evgHrb8fARDglD8i3+plo2jjNYEcflXyvhi95a77B9oDkmSadh27D/T0VKKrA0MgKh
         ZGOrXYJmVXsbWHySH7HNoXTggSQ1kYY6biWG8sVEcE1B/I+/1JcLiT1xnKxhu2Ih0Mn/
         YrXKQRpiWdKssqlxuiXtIykHnvm8jjhVc6nyKNc78iHQsOsVUAQ2y76tMoqjh7KfxqmU
         binA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062647; x=1791667447;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1QeW5W5E1AW3R1QgePH0+zeJVnlZw3qE3znhBQ67XAA=;
        b=Bt0oF2TwTJJlebE5wOYXgnUzmFidYofs5fDweqXGxZRCon+pOsKwyCULENHKgtq3ib
         fGVWWHMDvdiZXT+uF5vq0YbcmoycNf8cbf2PtJndKDC1FV0rxS4ZiG+3o4l906exFtpD
         eOj4nUqf6zzUKmTmASZ+9uhZhoaKWQozSun+ozR8/BwC5TzbzgoQaOrtyDd0hqacQwuF
         kTpd4RcnjbD/N3DmLB4GiOqB5QKYrrY6P/hcERBLtts+YY9cNGOWmldZRiOvGLgRUVj/
         wgQFhsELX4wFqtdxW84v1WBqw8vdwfQxW0dMjC31III5D0rvd+bNsnPb3ZrCUt3vaaCL
         D2ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwgqEls5WsZZ1Bvxa5+YpU1M14IUZVoExcqco0CjqErnGnnrF/dBr1GZtv1i8aQs7dh/mUecEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKWIuX+QppWm4cMgnBpZRH96AWaAW5mivANJtuz5uvycEEB3gy
	Fmlmp6QepcVy7w64kcUimU/JXUmS1L8bCVRkIuPNA2K6AO4DWvtn+SqGuGJPMrwzzqncE6j+qn2
	/13zJ1g==
X-Received: from pgap124.prod.google.com ([2002:a63:4282:0:b0:cc7:c04f:b661])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a0a:b0:3a7:82ef:a8a9
 with SMTP id 98e67ed59e1d1-3a782efb176mr2265630a91.26.1791062646684; Sat, 03
 Oct 2026 14:24:06 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:18 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 5/9] mlxsw: spectrum: Resolve neigh_table right
 before neigh_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Petr Machata <petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

We will replace neigh_lookup() and neigh_create() with
IPv4/IPv6-specific helpers.

mlxsw has two paths where neigh_table is fetched in advance
and passed down to a function which calls neigh_lookup() and
neigh_create().

To keep the changes simple, let's prepare them beforehand
by delaying the neigh_table resolution until right before
neigh_lookup().

struct mlxsw_sp_nexthop caches neigh_tbl, so it is replaced with
family, and a new helper, mlxsw_sp_nexthop_neigh_lookup(),
resolves neigh_table and calls neigh_lookup() and neigh_create().

Similarly, mlxsw_sp_span_entry_gretap[46]_parms() now pass family
to mlxsw_sp_span_dmac() to resolve neigh_table there just before
neigh_lookup() and neigh_create().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 65 ++++++++++++-------
 .../ethernet/mellanox/mlxsw/spectrum_span.c   | 31 +++++----
 2 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index f4a435885ba4..ba8a7a44ce9e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3072,9 +3072,9 @@ struct mlxsw_sp_nexthop {
 						   * this nexthop belongs to
 						   */
 	struct rhash_head ht_node;
-	struct neigh_table *neigh_tbl;
 	struct mlxsw_sp_nexthop_key key;
 	unsigned char gw_addr[sizeof(struct in6_addr)];
+	int family;
 	int ifindex;
 	int nh_weight;
 	int norm_nh_weight;
@@ -4300,28 +4300,49 @@ static void __mlxsw_sp_nexthop_neigh_update(struct mlxsw_sp_nexthop *nh,
 	nh->update = 1;
 }
 
+static struct neighbour *
+mlxsw_sp_nexthop_neigh_lookup(struct mlxsw_sp_nexthop *nh)
+{
+	struct neigh_table *tbl;
+	struct net_device *dev;
+	struct neighbour *n;
+	struct net *net;
+
+	dev = mlxsw_sp_nexthop_dev(nh);
+	net = dev_net(dev);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (nh->family == AF_INET6)
+		tbl = nd_table(net);
+	else
+#endif
+		tbl = arp_table(net);
+
+	n = neigh_lookup(tbl, &nh->gw_addr, dev);
+	if (!n) {
+		n = neigh_create(tbl, &nh->gw_addr, dev);
+		if (!IS_ERR(n))
+			neigh_event_send(n, NULL);
+	}
+
+	return n;
+}
+
 static int
 mlxsw_sp_nexthop_dead_neigh_replace(struct mlxsw_sp *mlxsw_sp,
 				    struct mlxsw_sp_neigh_entry *neigh_entry)
 {
 	struct neighbour *n, *old_n = neigh_entry->key.n;
 	struct mlxsw_sp_nexthop *nh;
-	struct net_device *dev;
 	bool entry_connected;
 	u8 nud_state, dead;
 	int err;
 
 	nh = list_first_entry(&neigh_entry->nexthop_list,
 			      struct mlxsw_sp_nexthop, neigh_list_node);
-	dev = mlxsw_sp_nexthop_dev(nh);
-
-	n = neigh_lookup(nh->neigh_tbl, &nh->gw_addr, dev);
-	if (!n) {
-		n = neigh_create(nh->neigh_tbl, &nh->gw_addr, dev);
-		if (IS_ERR(n))
-			return PTR_ERR(n);
-		neigh_event_send(n, NULL);
-	}
+	n = mlxsw_sp_nexthop_neigh_lookup(nh);
+	if (IS_ERR(n))
+		return PTR_ERR(n);
 
 	mlxsw_sp_neigh_entry_remove(mlxsw_sp, neigh_entry);
 	neigh_entry->key.n = n;
@@ -4402,7 +4423,6 @@ static int mlxsw_sp_nexthop_neigh_init(struct mlxsw_sp *mlxsw_sp,
 				       struct mlxsw_sp_nexthop *nh)
 {
 	struct mlxsw_sp_neigh_entry *neigh_entry;
-	struct net_device *dev;
 	struct neighbour *n;
 	u8 nud_state, dead;
 	int err;
@@ -4412,20 +4432,16 @@ static int mlxsw_sp_nexthop_neigh_init(struct mlxsw_sp *mlxsw_sp,
 
 	if (!nh->nhgi->gateway || nh->neigh_entry)
 		return 0;
-	dev = mlxsw_sp_nexthop_dev(nh);
 
 	/* Take a reference of neigh here ensuring that neigh would
 	 * not be destructed before the nexthop entry is finished.
 	 * The reference is taken either in neigh_lookup() or
 	 * in neigh_create() in case n is not found.
 	 */
-	n = neigh_lookup(nh->neigh_tbl, &nh->gw_addr, dev);
-	if (!n) {
-		n = neigh_create(nh->neigh_tbl, &nh->gw_addr, dev);
-		if (IS_ERR(n))
-			return PTR_ERR(n);
-		neigh_event_send(n, NULL);
-	}
+	n = mlxsw_sp_nexthop_neigh_lookup(nh);
+	if (IS_ERR(n))
+		return PTR_ERR(n);
+
 	neigh_entry = mlxsw_sp_neigh_entry_lookup(mlxsw_sp, n);
 	if (!neigh_entry) {
 		neigh_entry = mlxsw_sp_neigh_entry_create(mlxsw_sp, n);
@@ -4630,7 +4646,7 @@ static int mlxsw_sp_nexthop4_init(struct mlxsw_sp *mlxsw_sp,
 	nh->nh_weight = 1;
 #endif
 	memcpy(&nh->gw_addr, &fib_nh->fib_nh_gw4, sizeof(fib_nh->fib_nh_gw4));
-	nh->neigh_tbl = arp_table(mlxsw_sp_net(mlxsw_sp));
+	nh->family = AF_INET;
 	err = mlxsw_sp_nexthop_insert(mlxsw_sp, nh);
 	if (err)
 		return err;
@@ -5120,7 +5136,6 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 			  struct nh_notifier_single_info *nh_obj, int weight)
 {
 	struct net_device *dev = nh_obj->dev;
-	struct net *net = dev_net(dev);
 	int err;
 
 	nh->nhgi = nh_grp->nhgi;
@@ -5129,12 +5144,12 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 	switch (nh_obj->gw_family) {
 	case AF_INET:
 		memcpy(&nh->gw_addr, &nh_obj->ipv4, sizeof(nh_obj->ipv4));
-		nh->neigh_tbl = arp_table(net);
+		nh->family = AF_INET;
 		break;
 	case AF_INET6:
 		memcpy(&nh->gw_addr, &nh_obj->ipv6, sizeof(nh_obj->ipv6));
 #if IS_ENABLED(CONFIG_IPV6)
-		nh->neigh_tbl = nd_table(net);
+		nh->family = AF_INET6;
 #endif
 		break;
 	}
@@ -6990,7 +7005,7 @@ static int mlxsw_sp_nexthop6_init(struct mlxsw_sp *mlxsw_sp,
 	nh->nh_weight = rt->fib6_nh->fib_nh_weight;
 	memcpy(&nh->gw_addr, &rt->fib6_nh->fib_nh_gw6, sizeof(nh->gw_addr));
 #if IS_ENABLED(CONFIG_IPV6)
-	nh->neigh_tbl = nd_table(mlxsw_sp_net(mlxsw_sp));
+	nh->family = AF_INET6;
 #endif
 
 	err = mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 1cd8347c274d..d34d2040177b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -224,14 +224,24 @@ struct mlxsw_sp_span_entry_ops mlxsw_sp_span_entry_ops_phys = {
 	.deconfigure = mlxsw_sp_span_entry_phys_deconfigure,
 };
 
-static int mlxsw_sp_span_dmac(struct neigh_table *tbl,
+static int mlxsw_sp_span_dmac(int family,
 			      const void *pkey,
 			      struct net_device *dev,
 			      unsigned char dmac[ETH_ALEN])
 {
-	struct neighbour *neigh = neigh_lookup(tbl, pkey, dev);
+	struct net *net = dev_net(dev);
+	struct neigh_table *tbl;
+	struct neighbour *neigh;
 	int err = 0;
 
+#if IS_ENABLED(CONFIG_IPV6_GRE)
+	if (family == AF_INET6)
+		tbl = nd_table(net);
+	else
+#endif
+		tbl = arp_table(net);
+
+	neigh = neigh_lookup(tbl, pkey, dev);
 	if (!neigh) {
 		neigh = neigh_create(tbl, pkey, dev);
 		if (IS_ERR(neigh))
@@ -355,8 +365,7 @@ mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *edev,
 					union mlxsw_sp_l3addr saddr,
 					union mlxsw_sp_l3addr daddr,
 					union mlxsw_sp_l3addr gw,
-					__u8 ttl,
-					struct neigh_table *tbl,
+					__u8 ttl, int family,
 					struct mlxsw_sp_span_parms *sparmsp)
 {
 	unsigned char dmac[ETH_ALEN];
@@ -365,7 +374,7 @@ mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *edev,
 	if (mlxsw_sp_l3addr_is_zero(gw))
 		gw = daddr;
 
-	if (!edev || mlxsw_sp_span_dmac(tbl, &gw, edev, dmac))
+	if (!edev || mlxsw_sp_span_dmac(family, &gw, edev, dmac))
 		goto unoffloadable;
 
 	if (is_vlan_dev(edev))
@@ -456,7 +465,6 @@ mlxsw_sp_span_entry_gretap4_parms(struct mlxsw_sp *mlxsw_sp,
 	bool inherit_tos = tparm.iph.tos & 0x1;
 	bool inherit_ttl = !tparm.iph.ttl;
 	union mlxsw_sp_l3addr gw = daddr;
-	struct neigh_table *tbl = NULL;
 	struct net_device *l3edev;
 
 	if (!(to_dev->flags & IFF_UP) ||
@@ -470,11 +478,10 @@ mlxsw_sp_span_entry_gretap4_parms(struct mlxsw_sp *mlxsw_sp,
 		return mlxsw_sp_span_entry_unoffloadable(sparmsp);
 
 	l3edev = mlxsw_sp_span_gretap4_route(to_dev, &saddr.addr4, &gw.addr4);
-	if (l3edev)
-		tbl = arp_table(dev_net(l3edev));
+
 	return mlxsw_sp_span_entry_tunnel_parms_common(l3edev, saddr, daddr, gw,
 						       tparm.iph.ttl,
-						       tbl, sparmsp);
+						       AF_INET, sparmsp);
 }
 
 static int
@@ -564,7 +571,6 @@ mlxsw_sp_span_entry_gretap6_parms(struct mlxsw_sp *mlxsw_sp,
 	union mlxsw_sp_l3addr daddr = { .addr6 = tparm.raddr };
 	bool inherit_ttl = !tparm.hop_limit;
 	union mlxsw_sp_l3addr gw = daddr;
-	struct neigh_table *tbl = NULL;
 	struct net_device *l3edev;
 
 	if (!(to_dev->flags & IFF_UP) ||
@@ -578,11 +584,10 @@ mlxsw_sp_span_entry_gretap6_parms(struct mlxsw_sp *mlxsw_sp,
 		return mlxsw_sp_span_entry_unoffloadable(sparmsp);
 
 	l3edev = mlxsw_sp_span_gretap6_route(to_dev, &saddr.addr6, &gw.addr6);
-	if (l3edev)
-		tbl = nd_table(dev_net(l3edev));
+
 	return mlxsw_sp_span_entry_tunnel_parms_common(l3edev, saddr, daddr, gw,
 						       tparm.hop_limit,
-						       tbl, sparmsp);
+						       AF_INET6, sparmsp);
 }
 
 static int
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

