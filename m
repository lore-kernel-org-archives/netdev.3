Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D14A92D5
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599848; cv=none; b=d/YUnZTfrVcuzKXlRDwzTBbQCZ+iXFVaXzVrHsvnIrP2SNWPBO/BBNMUgJo9gOq8ZPQqflVcuffN0L1bbatQ0+za0kljh2q5kTpPQGIN+JtpvgKdgKTIR2/nhQ4eiPeXXHD9dahTA/TftpqDvx4Twu0aRLilc5kDgL3eTAxoMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599848; c=relaxed/simple;
	bh=irh+9JS9NHC+FrdNJcRbon2AGLrGpM/4F3SJodLYs0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+RDutR4cTgg9UZLovXaqjustv6hRWOIk8tCEOapD+vy47tbzIOcbngbn8yb1obaIAmKqK7+m2b0TCPOYpJIgx37dydzESSGljA/B+O9LKusu/lqcFpod0kHhaVTt31SwhwUNJOSy8wTdumGh13gIUGV/KCcurku+mTjbyskZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4TYumCl; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4TYumCl"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1a439db36so180974a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789599837; x=1790204637; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yFuzndR1oOWk6wOr9CIOAlXO57Z0eWu7JxXvYQpyWhU=;
        b=h4TYumCl/mtaYa+ExvYHB0qZdptIbkZVwCksz0xFkqLBjd0BRKq8XM1JXDXV8PiXRx
         8m/esy131xz0XEpucQ3f5NlwZdbj6iCMbYss7UJerZo30QPwhcv5GcT/0W2YsllNX5CJ
         zY7aqzo5adpuUaEy7GQtP18GaNQLTKts1xb6QuuxqbhPhaD/tZTun6hm4Pak2uxM+1a7
         orw0PP7d9wdXYZ3lY9hIWQ4QSTug0KL8auIy4PXO1UMWkVNaP4uBeZc3oYbe4Yxflpa6
         hLBKLf1FCSrz5KgiuQbovWRy82gySMibCE/aWgz03y/S27Fx83IJR+cLMqSBtwFbuRd7
         I4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789599837; x=1790204637;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFuzndR1oOWk6wOr9CIOAlXO57Z0eWu7JxXvYQpyWhU=;
        b=HEArWF20EEY7KwvFUXx7xs2lgYbEa3lzQqJvh03BFZGHTaqkz7byOUkgVZLdCdHyeX
         MDoOCubRR7Ds7TZsW8kXA+t2FmO8b/p9nHmbI4czkUxTxhrW9857D52cjxEVWIy7YJ80
         kPDi4vTSl+2OpT0GWwF5WYHfAKXcK/e8ehHI/jHDLFsfd//QFo4dil0nasOKhsUafXxb
         mPHjB+Z7MG3CkEy2BYUadAhJuGOFOrR+tPZd7gM/OliyQmaHTLsTaEFFXYyTRApnnKhy
         3sLETJwLKKmWIGkxC4n+qKg/5AwtWwxl4XtmIWdmMX4K5HIbYnpkKSoEsIOTC2d97tOJ
         4ZkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYRjrELXvft0Jd8g4wJS80/8zrer3ofW/tPkFml4ub1JORX6qS8gp6+j/ssREiPAzrEUrG2SI=@vger.kernel.org
X-Gm-Message-State: AFuF++nN7SYetzfryKG6nOJeN8FEKtBdjbKBbwc+FqeyMjS5ACJ0hYBW
	hGeKNbUJQFuDN/p8J1ACKoMQTA3Bj8tcf597Bpvsm0Qv8YNt7NUhu0n3L6XmV5My1EyF+leewrl
	EkKj2ZA==
X-Received: from pgfa26.prod.google.com ([2002:a63:bd1a:0:b0:cc5:1163:51a3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7484:b0:3c3:a20f:f729
 with SMTP id adf61e73a8af0-3dd5f45e96dmr10668733637.7.1789599836491; Wed, 16
 Sep 2026 16:03:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:02:21 +0000
In-Reply-To: <20260916230353.367014-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916230353.367014-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916230353.367014-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/6] ip6_gre: Convert ip6gre_net.tunnels[][] to hlist.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct ip6_tnl has a pointer to the next one.

Single linked list requires O(n) iteration for device removal
and IPv4 tunnel already uses hlist for its hash table.

Let's convert ip6gre_net.tunnels[][] to hlist.

Once we convert other users (ip6_tunnel.c, sit.c), we can remove
the *next pointer from struct ip6_tnl.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip6_tunnel.h |  1 +
 net/ipv6/ip6_gre.c       | 91 +++++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index b99805ee2fd1..d1f0a427e9c8 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -45,6 +45,7 @@ struct __ip6_tnl_parm {
 /* IPv6 tunnel */
 struct ip6_tnl {
 	struct ip6_tnl __rcu *next;	/* next tunnel in list */
+	struct hlist_node hash_node;
 	struct net_device *dev;	/* virtual device associated with tunnel */
 	netdevice_tracker dev_tracker;
 	struct net *net;	/* netns for packet i/o */
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 183218100d69..d3a879fa296e 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
 
 static unsigned int ip6gre_net_id __read_mostly;
 struct ip6gre_net {
-	struct ip6_tnl __rcu *tunnels[4][IP6_GRE_HASH_SIZE];
+	struct hlist_head tunnels[4][IP6_GRE_HASH_SIZE];
 
 	struct ip6_tnl __rcu *collect_md_tun;
 	struct ip6_tnl __rcu *collect_md_tun_erspan;
@@ -141,20 +141,24 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 		const struct in6_addr *remote, const struct in6_addr *local,
 		__be32 key, __be16 gre_proto)
 {
-	struct net *net = dev_net(dev);
-	int link = dev->ifindex;
-	unsigned int h0 = HASH_ADDR(remote);
-	unsigned int h1 = HASH_KEY(key);
-	struct ip6_tnl *t, *cand = NULL;
-	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
 	int dev_type = (gre_proto == htons(ETH_P_TEB) ||
 			gre_proto == htons(ETH_P_ERSPAN) ||
 			gre_proto == htons(ETH_P_ERSPAN2)) ?
 		       ARPHRD_ETHER : ARPHRD_IP6GRE;
+	unsigned int h0 = HASH_ADDR(remote);
+	unsigned int h1 = HASH_KEY(key);
+	struct ip6_tnl *t, *cand = NULL;
+	struct net *net = dev_net(dev);
 	struct net_device *ndev;
+	struct hlist_head *head;
+	int link = dev->ifindex;
+	struct ip6gre_net *ign;
 	int cand_score = 4;
 
-	for_each_ip_tunnel_rcu(t, ign->tunnels_r_l[h0 ^ h1]) {
+	ign = net_generic(net, ip6gre_net_id);
+
+	head = &ign->tunnels_r_l[h0 ^ h1];
+	hlist_for_each_entry_rcu(t, head, hash_node) {
 		if (!ipv6_addr_equal(local, &t->parms.laddr) ||
 		    !ipv6_addr_equal(remote, &t->parms.raddr) ||
 		    key != t->parms.i_key ||
@@ -165,7 +169,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 			return cand;
 	}
 
-	for_each_ip_tunnel_rcu(t, ign->tunnels_r[h0 ^ h1]) {
+	head = &ign->tunnels_r[h0 ^ h1];
+	hlist_for_each_entry_rcu(t, head, hash_node) {
 		if (!ipv6_addr_equal(remote, &t->parms.raddr) ||
 		    key != t->parms.i_key ||
 		    !(t->dev->flags & IFF_UP))
@@ -175,7 +180,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 			return cand;
 	}
 
-	for_each_ip_tunnel_rcu(t, ign->tunnels_l[h1]) {
+	head = &ign->tunnels_l[h1];
+	hlist_for_each_entry_rcu(t, head, hash_node) {
 		if ((!ipv6_addr_equal(local, &t->parms.laddr) &&
 			  (!ipv6_addr_equal(local, &t->parms.raddr) ||
 				 !ipv6_addr_is_multicast(local))) ||
@@ -187,7 +193,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 			return cand;
 	}
 
-	for_each_ip_tunnel_rcu(t, ign->tunnels_wc[h1]) {
+	head = &ign->tunnels_wc[h1];
+	hlist_for_each_entry_rcu(t, head, hash_node) {
 		if (t->parms.i_key != key ||
 		    !(t->dev->flags & IFF_UP))
 			continue;
@@ -215,8 +222,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 	return NULL;
 }
 
-static struct ip6_tnl __rcu **__ip6gre_bucket(struct ip6gre_net *ign,
-		const struct __ip6_tnl_parm *p)
+static struct hlist_head *__ip6gre_bucket(struct ip6gre_net *ign,
+					  const struct __ip6_tnl_parm *p)
 {
 	const struct in6_addr *remote = &p->raddr;
 	const struct in6_addr *local = &p->laddr;
@@ -258,56 +265,46 @@ static void ip6erspan_tunnel_unlink_md(struct ip6gre_net *ign,
 		rcu_assign_pointer(ign->collect_md_tun_erspan, NULL);
 }
 
-static inline struct ip6_tnl __rcu **ip6gre_bucket(struct ip6gre_net *ign,
-		const struct ip6_tnl *t)
+static inline struct hlist_head *ip6gre_bucket(struct ip6gre_net *ign,
+					       const struct ip6_tnl *t)
 {
 	return __ip6gre_bucket(ign, &t->parms);
 }
 
 static void ip6gre_tunnel_link(struct ip6gre_net *ign, struct ip6_tnl *t)
 {
-	struct ip6_tnl __rcu **tp = ip6gre_bucket(ign, t);
+	struct hlist_head *head = ip6gre_bucket(ign, t);
 
-	rcu_assign_pointer(t->next, rtnl_dereference(*tp));
-	rcu_assign_pointer(*tp, t);
+	hlist_add_head_rcu(&t->hash_node, head);
 }
 
 static void ip6gre_tunnel_unlink(struct ip6gre_net *ign, struct ip6_tnl *t)
 {
-	struct ip6_tnl __rcu **tp;
-	struct ip6_tnl *iter;
-
-	for (tp = ip6gre_bucket(ign, t);
-	     (iter = rtnl_dereference(*tp)) != NULL;
-	     tp = &iter->next) {
-		if (t == iter) {
-			rcu_assign_pointer(*tp, t->next);
-			break;
-		}
-	}
+	hlist_del_init_rcu(&t->hash_node);
 }
 
 static struct ip6_tnl *ip6gre_tunnel_find(struct net *net,
 					   const struct __ip6_tnl_parm *parms,
 					   int type)
 {
+	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
 	const struct in6_addr *remote = &parms->raddr;
 	const struct in6_addr *local = &parms->laddr;
 	__be32 key = parms->i_key;
+	struct hlist_head *head;
 	int link = parms->link;
 	struct ip6_tnl *t;
-	struct ip6_tnl __rcu **tp;
-	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
 
-	for (tp = __ip6gre_bucket(ign, parms);
-	     (t = rtnl_dereference(*tp)) != NULL;
-	     tp = &t->next)
+	head = __ip6gre_bucket(ign, parms);
+
+	hlist_for_each_entry(t, head, hash_node) {
 		if (ipv6_addr_equal(local, &t->parms.laddr) &&
 		    ipv6_addr_equal(remote, &t->parms.raddr) &&
 		    key == t->parms.i_key &&
 		    link == t->parms.link &&
 		    type == t->dev->type)
 			break;
+	}
 
 	return t;
 }
@@ -1551,7 +1548,8 @@ static struct inet6_protocol ip6gre_protocol __read_mostly = {
 	.flags       = INET6_PROTO_FINAL,
 };
 
-static void __net_exit ip6gre_exit_rtnl_net(struct net *net, struct list_head *head)
+static void __net_exit ip6gre_exit_rtnl_net(struct net *net,
+					    struct list_head *dev_kill_list)
 {
 	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
 	struct net_device *dev, *aux;
@@ -1561,23 +1559,21 @@ static void __net_exit ip6gre_exit_rtnl_net(struct net *net, struct list_head *h
 		if (dev->rtnl_link_ops == &ip6gre_link_ops ||
 		    dev->rtnl_link_ops == &ip6gre_tap_ops ||
 		    dev->rtnl_link_ops == &ip6erspan_tap_ops)
-			unregister_netdevice_queue(dev, head);
+			unregister_netdevice_queue(dev, dev_kill_list);
 
 	for (prio = 0; prio < 4; prio++) {
 		int h;
+
 		for (h = 0; h < IP6_GRE_HASH_SIZE; h++) {
+			struct hlist_head *head = &ign->tunnels[prio][h];
 			struct ip6_tnl *t;
 
-			t = rtnl_net_dereference(net, ign->tunnels[prio][h]);
-
-			while (t) {
+			hlist_for_each_entry(t, head, hash_node) {
 				/* If dev is in the same netns, it has already
 				 * been added to the list by the previous loop.
 				 */
 				if (!net_eq(dev_net(t->dev), net))
-					unregister_netdevice_queue(t->dev, head);
-
-				t = rtnl_net_dereference(net, t->next);
+					unregister_netdevice_queue(t->dev, dev_kill_list);
 			}
 		}
 	}
@@ -1587,8 +1583,15 @@ static int __net_init ip6gre_init_net(struct net *net)
 {
 	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
 	struct net_device *ndev;
+	struct ip6_tnl *t;
+	int prio, h;
 	int err;
 
+	for (prio = 0; prio < 4; prio++) {
+		for (h = 0; h < IP6_GRE_HASH_SIZE; h++)
+			INIT_HLIST_HEAD(&ign->tunnels[prio][h]);
+	}
+
 	if (!net_has_fallback_tunnels(net))
 		return 0;
 	ndev = alloc_netdev(sizeof(struct ip6_tnl), "ip6gre0",
@@ -1607,8 +1610,8 @@ static int __net_init ip6gre_init_net(struct net *net)
 	ip6gre_fb_tunnel_init(ign->fb_tunnel_dev);
 	ign->fb_tunnel_dev->rtnl_link_ops = &ip6gre_link_ops;
 
-	rcu_assign_pointer(ign->tunnels_wc[0],
-			   netdev_priv(ign->fb_tunnel_dev));
+	t = netdev_priv(ign->fb_tunnel_dev);
+	hlist_add_head_rcu(&t->hash_node, &ign->tunnels_wc[0]);
 
 	err = register_netdev(ign->fb_tunnel_dev);
 	if (err)
-- 
2.55.0.1082.g2b9226bbc0-goog

