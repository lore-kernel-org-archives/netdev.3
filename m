Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7549DBBF
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062651; cv=none; b=H+o7jOSkNRNeN6MHNWKyjhUsYlWDLCDdJLgywivCgvI5mV2MpbR7mhYmMaDYgAOp0PIIR5vg34hjL2SRCXJ5pukLZ1Wcwf6ZCs4xRh6/r/pT4e0sAGVTI0x6+xED+u0UUlOs6UMnu6yjeWFwLyZlwHn6dw4/e6kcF/ODLvayQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062651; c=relaxed/simple;
	bh=P/YdvgEj37Urgzu8AJgtLdVKBog4t/IZFQradyw9yjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VmgDDekZ/xiSryLqzbgtdUWxgJd2w9PByPzEFJBJKD1lPpFtYRg4/J+Eh1eCDCw2S27WAdtHPa40AAYMUvfyWtIqaA4F9es4N7nILTmPCKpwsQBwk1vKm+3ZDnt6iPgEheGvhOnvYHaYiyzxeXDLMM+dom7p+jkvz1ktrQtYrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlcoJJff; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlcoJJff"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a6f4ba619so353513b3a.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062648; x=1791667448; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2FOosWuJa2chDWkXt6fMC0YHXOZDk9z2iFUIslQVgQ=;
        b=HlcoJJffO2iplimj/wWCEhFDeMyHGXAn6/2lB34q6WamLAVIbWKObpoey5A5XKSkjl
         c4Vihv+iO6LCeNvwFKE8KjWFjZ7ga20qUJMXm5hhZGld+5pWaOIDTWFTsVR2Il2UVX0f
         2l8sTbrjCymfSBMYgvDJyfEWcwx8HvjKF7dMOJj4gDCGOjHjIZmkwewpWOSSA22stpMl
         +behU8XRCIicMv+LjBPZGT49fu2hB5/kIMe6FL7SvHdeZ2wRL2KffSHxY5mrTwbngSK1
         YKrCAOfOXcjWmZSLD8svQrxrGDF6StRToWrjTayP7thyel7nMn/LiEQZ67KlCr++sN2U
         ovmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062648; x=1791667448;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2FOosWuJa2chDWkXt6fMC0YHXOZDk9z2iFUIslQVgQ=;
        b=nSu9XmPEDf//qaajtxszAs0B4LaRUF3kiYc4z8RxifryXRar9AvQsBD7tMyphaiG7P
         ans+TsZfvtj0fOl+E/NqRFAsHFi+XUXWR7uNdAEWRD/mATIdjDoOdS7Ynk27ecC6SjdK
         vgjPqAARtXNiZ7YlcJYpAQ46OK+5LHiJgG+idqiBU2xqZMYyreWuQx8jrl9YgaVyUDSu
         WREEkeKcGVwF1O8og5g0pHr0DmaDCHPQZEGaUNMbaANKdmt/34serRO59/ODDnSRbor4
         QAtspeY0cm0gjWfh3hO7qnrUMdL+HWP4d1HbcEOmtG5/oCBjOfeGJ7+kLy19hS3W3XvS
         geFQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1sP1S4+d0gPivY1/YjwEXWFDo+YPr70Vd9ZmgiZJBe1zkvFQbpMYq9pBZl8SPD2OOUPmRlaQ=@vger.kernel.org
X-Gm-Message-State: AFuF++klO+eU0YdzSVjb68sF6UE1EAYDH5hETUv1/iPmnhyyw3uvc4jd
	FjbN5Xoa9LgIGd6CBnVHEckAw+dDuCqc3wpu62A0msWkMCk/t709W181PZJe5zEuTVBXM2fBLHQ
	K36Hrag==
X-Received: from pfst8.prod.google.com ([2002:aa7:8f88:0:b0:88d:a1c2:cf18])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2381:b0:878:34b8:2322
 with SMTP id d2e1a72fcca58-88c6454f7famr2718968b3a.42.1791062647530; Sat, 03
 Oct 2026 14:24:07 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:19 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 6/9] ipv6: Use ipv6_neigh_lookup() and friends.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+5a8857f0b4a0a7b12c62@syzkaller.appspotmail.com, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat below in neigh_mark_dead() [0]
where tbl->lock was not held while neigh_ifdown() should
have acquired one.

This only happens when a neigh_table accidentally has a
neighbour from a different netns.

In ip6_finish_output2(), the net argument is the caller's and
does not always match dev_net(dev) fetched from dst. (e.g. xfrm)

It is error-prone to require callers to fetch netns and
neigh_table and pass it with dev to neigh_lookup(), etc.

Let's replace neigh_lookup() and friends with IPv6 helpers.

Note that __neigh_lookup() is split into ipv6_neigh_lookup()
and ipv6_neigh_create().

[0]:
debug_locks && !(lock_is_held(&(&n->tbl->lock)->dep_map) != 0)
WARNING: net/core/neighbour.c:154 at neigh_mark_dead+0x2fb/0x340 net/core/neighbour.c:154, CPU#0: syz.0.857/9765
Modules linked in:
CPU: 0 UID: 0 PID: 9765 Comm: syz.0.857 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:neigh_mark_dead+0x2fb/0x340 net/core/neighbour.c:154
Code: e8 03 42 80 3c 28 00 74 08 48 89 df e8 ee 9a 80 f8 4c 89 33 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 86 95 10 f8 90 <0f> 0b 90 e9 8f fd ff ff 48 c7 c1 80 9a 7a 90 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90003726600 EFLAGS: 00010287
RAX: ffffffff89b7467a RBX: ffff888022e86000 RCX: 0000000000080000
RDX: ffffc900047fa000 RSI: 0000000000003e08 RDI: 0000000000003e09
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006e4cb8 R12: ffff888022e8613c
R13: dffffc0000000000 R14: ffff888022e86020 R15: ffff888022e86000
FS:  00007f9c30f046c0(0000) GS:ffff888124cc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000076c56000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 neigh_flush_one+0x27c/0x5a0 net/core/neighbour.c:388
 neigh_flush_dev net/core/neighbour.c:432 [inline]
 __neigh_ifdown+0x1fb/0xc70 net/core/neighbour.c:465
 neigh_ifdown+0x1f/0x30 net/core/neighbour.c:487
 rt6_disable_ip+0x751/0x7e0 net/ipv6/route.c:5058
 addrconf_ifdown+0x155/0x1ad0 net/ipv6/addrconf.c:3892
 addrconf_notify+0x1bc/0x1050 net/ipv6/addrconf.c:-1
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_mtu net/core/dev.c:2350 [inline]
 netif_set_mtu_ext+0x5ac/0x830 net/core/dev.c:9963
 do_setlink+0xa81/0x47a0 net/core/rtnetlink.c:3247
 rtnl_setlink+0x578/0x820 net/core/rtnetlink.c:3623
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7159
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 sock_write_iter+0x2de/0x3e0 net/socket.c:1266
 do_iter_readv_writev+0x612/0x8c0 fs/read_write.c:-1
 vfs_writev+0x343/0x990 fs/read_write.c:1058
 do_writev+0x154/0x2e0 fs/read_write.c:1104
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c2ff9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c30f04028 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f9c30225fa0 RCX: 00007f9c2ff9e159
RDX: 0000000000000001 RSI: 00002000000003c0 RDI: 0000000000000004
RBP: 00007f9c3003506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9c30226038 R14: 00007f9c30225fa0 R15: 00007ffed3c74808
 </TASK>

Fixes: df5f4f372de5 ("ipv6: Replace &nd_tbl with nd_table(net).")
Reported-by: syzbot+5a8857f0b4a0a7b12c62@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6abd69a9.80e1c6cc.22483f.0005.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Convert __teql_resolve()

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../mellanox/mlx5/core/en/tc_tun_encap.c      | 13 +++----
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 29 ++++++++-------
 .../ethernet/mellanox/mlxsw/spectrum_span.c   | 24 ++++++++-----
 .../netronome/nfp/flower/tunnel_conf.c        |  4 +--
 drivers/net/ethernet/sfc/tc_counters.c        |  5 ++-
 drivers/net/vrf.c                             |  4 +--
 drivers/net/vxlan/vxlan_core.c                |  6 ++--
 include/net/ndisc.h                           |  7 ++--
 net/bridge/br_arp_nd_proxy.c                  |  2 +-
 net/ieee802154/6lowpan/tx.c                   |  3 +-
 net/ipv4/fib_semantics.c                      |  2 +-
 net/ipv6/ip6_output.c                         |  2 +-
 net/ipv6/ndisc.c                              | 36 ++++++++++++-------
 net/ipv6/route.c                              | 11 +++---
 net/sched/sch_teql.c                          | 12 ++++++-
 15 files changed, 90 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 67c12ca19d59..fe0258375ef6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -439,21 +439,18 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 	if (neigh_used) {
 		struct net_device *dev = READ_ONCE(nhe->neigh_dev);
 		struct net *net = dev_net(dev);
-		struct neigh_table *tbl;
 
 		nhe->reported_lastuse = jiffies;
 
+		/* find the relevant neigh according to the cached device and
+		 * dst ip pair
+		 */
 #if IS_ENABLED(CONFIG_IPV6)
 		if (m_neigh->family != AF_INET)
-			tbl = nd_table(net);
+			n = ipv6_neigh_lookup(dev, &m_neigh->dst_ip);
 		else
 #endif
-			tbl = arp_table(net);
-
-		/* find the relevant neigh according to the cached device and
-		 * dst ip pair
-		 */
-		n = neigh_lookup(tbl, &m_neigh->dst_ip, dev);
+			n = neigh_lookup(arp_table(net), &m_neigh->dst_ip, dev);
 		if (!n)
 			return;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index ba8a7a44ce9e..1f4753213b9c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2449,8 +2449,6 @@ static void mlxsw_sp_router_neigh_ent_ipv6_process(struct mlxsw_sp *mlxsw_sp,
 						   char *rauhtd_pl,
 						   int rec_index)
 {
-	struct net *net = mlxsw_sp_net(mlxsw_sp);
-	struct neigh_table *tbl;
 	struct net_device *dev;
 	struct neighbour *n;
 	struct in6_addr dip;
@@ -2464,9 +2462,8 @@ static void mlxsw_sp_router_neigh_ent_ipv6_process(struct mlxsw_sp *mlxsw_sp,
 		return;
 	}
 
-	tbl = nd_table(net);
 	dev = mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
-	n = neigh_lookup(tbl, &dip, dev);
+	n = ipv6_neigh_lookup(dev, &dip);
 	if (!n)
 		return;
 
@@ -4312,17 +4309,23 @@ mlxsw_sp_nexthop_neigh_lookup(struct mlxsw_sp_nexthop *nh)
 	net = dev_net(dev);
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (nh->family == AF_INET6)
-		tbl = nd_table(net);
-	else
+	if (nh->family == AF_INET6) {
+		n = ipv6_neigh_lookup(dev, &nh->gw_addr);
+		if (!n) {
+			n = ipv6_neigh_create(dev, &nh->gw_addr);
+			if (!IS_ERR(n))
+				neigh_event_send(n, NULL);
+		}
+	} else
 #endif
+	{
 		tbl = arp_table(net);
-
-	n = neigh_lookup(tbl, &nh->gw_addr, dev);
-	if (!n) {
-		n = neigh_create(tbl, &nh->gw_addr, dev);
-		if (!IS_ERR(n))
-			neigh_event_send(n, NULL);
+		n = neigh_lookup(tbl, &nh->gw_addr, dev);
+		if (!n) {
+			n = neigh_create(tbl, &nh->gw_addr, dev);
+			if (!IS_ERR(n))
+				neigh_event_send(n, NULL);
+		}
 	}
 
 	return n;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index d34d2040177b..79947f68b10d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -235,17 +235,23 @@ static int mlxsw_sp_span_dmac(int family,
 	int err = 0;
 
 #if IS_ENABLED(CONFIG_IPV6_GRE)
-	if (family == AF_INET6)
-		tbl = nd_table(net);
-	else
+	if (family == AF_INET6) {
+		neigh = ipv6_neigh_lookup(dev, pkey);
+		if (!neigh) {
+			neigh = ipv6_neigh_create(dev, pkey);
+			if (IS_ERR(neigh))
+				return PTR_ERR(neigh);
+		}
+	} else
 #endif
+	{
 		tbl = arp_table(net);
-
-	neigh = neigh_lookup(tbl, pkey, dev);
-	if (!neigh) {
-		neigh = neigh_create(tbl, pkey, dev);
-		if (IS_ERR(neigh))
-			return PTR_ERR(neigh);
+		neigh = neigh_lookup(tbl, pkey, dev);
+		if (!neigh) {
+			neigh = neigh_create(tbl, pkey, dev);
+			if (IS_ERR(neigh))
+				return PTR_ERR(neigh);
+		}
 	}
 
 	neigh_event_send(neigh, NULL);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index d650d33e3709..27d80ec8e895 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -253,7 +253,6 @@ void nfp_tunnel_keep_alive_v6(struct nfp_app *app, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	struct nfp_tun_active_tuns_v6 *payload;
 	struct net_device *netdev;
-	struct neigh_table *tbl;
 	int count, i, pay_len;
 	struct neighbour *n;
 	void *ipv6_add;
@@ -280,8 +279,7 @@ void nfp_tunnel_keep_alive_v6(struct nfp_app *app, struct sk_buff *skb)
 		if (!netdev)
 			continue;
 
-		tbl = nd_table(dev_net(netdev));
-		n = neigh_lookup(tbl, ipv6_add, netdev);
+		n = ipv6_neigh_lookup(netdev, ipv6_add);
 		if (!n)
 			continue;
 
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index 793a562fc1f7..ae6cc6b93864 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -116,9 +116,8 @@ static void efx_tc_counter_work(struct work_struct *work)
 					 encap->neigh->egdev);
 		else
 #if IS_ENABLED(CONFIG_IPV6)
-			n = neigh_lookup(nd_table(net),
-					 &encap->neigh->dst_ip6,
-					 encap->neigh->egdev);
+			n = ipv6_neigh_lookup(encap->neigh->egdev,
+					      &encap->neigh->dst_ip6);
 #else
 			n = NULL;
 #endif
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 320f3584a43b..79d433f49f80 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -614,9 +614,9 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 
 	rcu_read_lock();
 	nexthop = rt6_nexthop(dst_rt6_info(dst), &ipv6_hdr(skb)->daddr);
-	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
+	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(nd_table(net), nexthop, dst->dev, false);
+		neigh = ipv6_neigh_create_noref(dev, nexthop);
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb, false);
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 27b0b6567d52..513779c07621 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2091,8 +2091,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb,
 	    ipv6_addr_is_multicast(&msg->target))
 		goto out;
 
-	n = neigh_lookup(nd_table(dev_net(dev)), &msg->target, dev);
-
+	n = ipv6_neigh_lookup(dev, &msg->target);
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
 		u8 ha[ETH_ALEN] __aligned(2);
@@ -2189,9 +2188,8 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb,
 		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
 			return false;
 
-		tbl = nd_table(dev_net(dev));
 		pip6 = ipv6_hdr(skb);
-		n = neigh_lookup(tbl, &pip6->daddr, dev);
+		n = ipv6_neigh_lookup(dev, &pip6->daddr);
 		if (!n && (cfg->flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin6.sin6_addr = pip6->daddr,
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 2fce6fccf55a..91898a2475e7 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -423,11 +423,8 @@ static inline struct neighbour *ip_neigh_gw6(struct net_device *dev,
 	struct neighbour *neigh;
 
 	neigh = __ipv6_neigh_lookup_noref(dev, addr);
-	if (unlikely(!neigh)) {
-		struct neigh_table *tbl = nd_table(dev_net(dev));
-
-		neigh = __neigh_create(tbl, addr, dev, false);
-	}
+	if (unlikely(!neigh))
+		neigh = ipv6_neigh_create_noref(dev, addr);
 
 	return neigh;
 #else
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index ba4a63840b21..c23b99517cd5 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -487,7 +487,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
-	n = neigh_lookup(nd_table(dev_net(vlandev)), &msg->target, vlandev);
+	n = ipv6_neigh_lookup(vlandev, &msg->target);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
 		u8 ha[ETH_ALEN] __aligned(2);
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 4f511476b992..b261daedc290 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -58,9 +58,8 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 		info->daddr.mode = IEEE802154_ADDR_SHORT;
 	} else {
 		__le16 short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
-		struct neigh_table *tbl = nd_table(dev_net(ldev));
 
-		n = neigh_lookup(tbl, &hdr->daddr, ldev);
+		n = ipv6_neigh_lookup(ldev, &hdr->daddr);
 		if (n) {
 			llneigh = lowpan_802154_neigh(neighbour_priv(n));
 			read_lock_bh(&n->lock);
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index e3bcc25229b0..a98c7670d2ce 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -617,7 +617,7 @@ static int fib_detect_death(struct fib_info *fi, int order,
 	if (likely(nhc->nhc_gw_family == AF_INET))
 		n = neigh_lookup(arp_table(net), &nhc->nhc_gw.ipv4, nhc->nhc_dev);
 	else if (IS_ENABLED(CONFIG_IPV6) && nhc->nhc_gw_family == AF_INET6)
-		n = neigh_lookup(nd_table(net), &nhc->nhc_gw.ipv6, nhc->nhc_dev);
+		n = ipv6_neigh_lookup(nhc->nhc_dev, &nhc->nhc_gw.ipv6);
 	else
 		n = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 10146a57b69e..25fe0ba98b1a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -127,7 +127,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	if (IS_ERR_OR_NULL(neigh)) {
 		if (unlikely(!neigh))
-			neigh = __neigh_create(nd_table(net), nexthop, dev, false);
+			neigh = ipv6_neigh_create_noref(dev, nexthop);
 		if (IS_ERR(neigh)) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
 			kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index e1cbffaa0ad0..0ed1a619372b 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -947,8 +947,12 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	 *	update / create cache entry
 	 *	for the source address
 	 */
-	neigh = __neigh_lookup(tbl, saddr, dev,
-			       !inc || lladdr || !dev->addr_len);
+	neigh = ipv6_neigh_lookup(dev, saddr);
+	if (!neigh && (!inc || lladdr || !dev->addr_len)) {
+		neigh = ipv6_neigh_create(dev, saddr);
+		if (IS_ERR(neigh))
+			neigh = NULL;
+	}
 	if (neigh)
 		ndisc_update(dev, neigh, lladdr, NUD_STALE,
 			     NEIGH_UPDATE_F_WEAK_OVERRIDE|
@@ -998,7 +1002,6 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	struct net *net = dev_net(dev);
 	struct ndisc_options ndopts;
 	struct inet6_ifaddr *ifp;
-	struct neigh_table *tbl;
 	struct neighbour *neigh;
 	struct inet6_dev *idev;
 	u8 *lladdr = NULL;
@@ -1063,8 +1066,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		return reason;
 	}
 
-	tbl = nd_table(net);
-	neigh = neigh_lookup(tbl, &msg->target, dev);
+	neigh = ipv6_neigh_lookup(dev, &msg->target);
 
 	/* RFC 9131 updates original Neighbour Discovery RFC 4861.
 	 * NAs with Target LL Address option can now create a STALE neighbor
@@ -1093,7 +1095,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 			return reason;
 		}
 		if (!neigh)
-			neigh = neigh_create(tbl, &msg->target, dev);
+			neigh = ipv6_neigh_create(dev, &msg->target);
 		new_state = NUD_STALE;
 	}
 
@@ -1108,7 +1110,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
 		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-		    pneigh_lookup(tbl, &msg->target, dev)) {
+		    pneigh_lookup(nd_table(dev_net(dev)), &msg->target, dev)) {
 			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
 		}
@@ -1141,7 +1143,6 @@ static enum skb_drop_reason ndisc_recv_rs(struct sk_buff *skb)
 	unsigned long ndoptlen = skb->len - sizeof(*rs_msg);
 	struct net_device *dev = skb->dev;
 	struct ndisc_options ndopts;
-	struct neigh_table *tbl;
 	struct neighbour *neigh;
 	struct inet6_dev *idev;
 	u8 *lladdr = NULL;
@@ -1177,8 +1178,12 @@ static enum skb_drop_reason ndisc_recv_rs(struct sk_buff *skb)
 			goto out;
 	}
 
-	tbl = nd_table(dev_net(dev));
-	neigh = __neigh_lookup(tbl, saddr, dev, 1);
+	neigh = ipv6_neigh_lookup(dev, saddr);
+	if (!neigh) {
+		neigh = ipv6_neigh_create(dev, saddr);
+		if (IS_ERR(neigh))
+			goto out;
+	}
 	if (neigh) {
 		ndisc_update(dev, neigh, lladdr, NUD_STALE,
 			     NEIGH_UPDATE_F_WEAK_OVERRIDE|
@@ -1478,9 +1483,14 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	 *	Process options.
 	 */
 
-	if (!neigh)
-		neigh = __neigh_lookup(nd_table(net), &ipv6_hdr(skb)->saddr,
-				       skb->dev, 1);
+	if (!neigh) {
+		neigh = ipv6_neigh_lookup(skb->dev, &ipv6_hdr(skb)->saddr);
+		if (!neigh) {
+			neigh = ipv6_neigh_create(skb->dev, &ipv6_hdr(skb)->saddr);
+			if (IS_ERR(neigh))
+				neigh = NULL;
+		}
+	}
 	if (neigh) {
 		u8 *lladdr = NULL;
 		if (ndopts.nd_opts_src_lladdr) {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8baac4d85251..ea9f0a4c34f9 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -218,7 +218,7 @@ struct neighbour *__ip6_dst_neigh_lookup(const struct in6_addr *gw,
 	if (n)
 		return n;
 
-	n = neigh_create(nd_table(dev_net(dev)), daddr, dev);
+	n = ipv6_neigh_create(dev, daddr);
 	return IS_ERR(n) ? NULL : n;
 }
 
@@ -4277,9 +4277,12 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	 */
 	dst_confirm_neigh(&rt->dst, &ipv6_hdr(skb)->saddr);
 
-	neigh = __neigh_lookup(nd_table(dev_net(dev)), &msg->target, dev, 1);
-	if (!neigh)
-		return;
+	neigh = ipv6_neigh_lookup(dev, &msg->target);
+	if (!neigh) {
+		neigh = ipv6_neigh_create(dev, &msg->target);
+		if (IS_ERR(neigh))
+			return;
+	}
 
 	/*
 	 *	We have finally decided to accept it.
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..19ccf1a55988 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -16,6 +16,7 @@
 #include <linux/skbuff.h>
 #include <linux/moduleparam.h>
 #include <net/dst.h>
+#include <net/ndisc.h>
 #include <net/neighbour.h>
 #include <net/pkt_sched.h>
 
@@ -257,7 +258,16 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	if (dst->dev != dev) {
 		struct neighbour *mn;
 
-		mn = __neigh_lookup_errno(n->tbl, n->primary_key, dev);
+#if IS_ENABLED(CONFIG_IPV6)
+		if (n->tbl->family == AF_INET6) {
+			mn = ipv6_neigh_lookup(dev, n->primary_key);
+			if (!mn)
+				mn = ipv6_neigh_create(dev, n->primary_key);
+		} else
+#endif
+		{
+			mn = __neigh_lookup_errno(n->tbl, n->primary_key, dev);
+		}
 		neigh_release(n);
 		if (IS_ERR(mn))
 			return PTR_ERR(mn);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

