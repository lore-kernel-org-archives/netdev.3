Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB29427F91
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767939; cv=none; b=aCbnJUFReIEwUjYdgHEOfAtHf0aFRymrk6laasoDiMgZKgKiWJTh46xPDyc0gpfZtD7fawAwiCxWvJW796TAus+/7gq2JKjL+G17PpPGXY8WhppAWbO8oP7zlUoFTW+UpZ0IN9OnUUbM5BMyBQ9x3pd8kZ8SsTrFVDJqlTgMxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767939; c=relaxed/simple;
	bh=I5C23tUidiLFWvWcalKEr8kUrS4DEBMQLBGYF5/o3zI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4cJmlhU63kuPCD5B/uJgPO9mVWsFXDoDlA2HlRDomV7sZUxblQePbQsuDe9GfKSxIRewXe7aHBFPVb6JKgkOTH9ES8w/72WBbsd4dXc3lE6lfMCV9PAL1ehwN0SaVf1pNuckinux6uupwGH+aTQ2vJqM+hKCK19R2g8HZdfebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9Rkt4Xm; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9Rkt4Xm"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52fc0097865so89248911cf.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767935; x=1789372735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41dAaNPu/Guzaln0usULtrniM3T3/SvoBVZ+fY8Tzyk=;
        b=O9Rkt4Xm4PCOYa2AvBqoSlMuQs3ijuZi6NhGxfCVncNSw3SHsMKoJ3bN6y9eV6s/pt
         jItyErHBWE610R82nLSu7ZGDkJNpyQ5p41PiUf6KCnSJicj56jhGIchuwFhr3KdZBgMv
         I6Fmi9TqfB4/cbbufd7m47/jLCNYrkzf7yV0JS/zCO3mcPAt8t3Q+6pE8WpcDylTiOE9
         1T4TYa5aYmKuQRIM4/5Rr/UfhFSzUH6dbVusbAdgci8PCi4DmLNrvuDZ2LmsHO08fHN7
         WOQhW8tGs/J/GjMIf7NLfnajwoJWgOURVFEFNm5uC36Z5Y01w5sC9Y8TVpNGt1nFZASJ
         9X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767935; x=1789372735;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=41dAaNPu/Guzaln0usULtrniM3T3/SvoBVZ+fY8Tzyk=;
        b=nCYOrkepqh1gJQIyDY1XbUSMYGFcJh/sCdrobGOV3ujkUzFDpRZ+YkYGZ0rjicSW8a
         Gs30eo7tkkznnibKvultCxABXaLX2nUti1vW211QjVth2pTAlWLRDFpsbQybxUUgkcMz
         5by6c3GwSes4Nz1pEAYRAnIHcbP2BRA2zLhncu2F1PsQS6UMuK/KgulbCq16Ouypkwqk
         fQ88AVQq60MdsPMTb6TBNTDqWnqu8Tq4seNNn3bllBvtAFRrs0pYdIjPAeBTp7JVSb4c
         kJ4bHzElhU+6460IGhybw4kuPKtCF16sy2KoSIjqVT9mZmK+lAbTJHi1sFrmkBynCFDB
         PX8g==
X-Forwarded-Encrypted: i=1; AKwUvBzQzGDgsXi98xdSgAez8eLcdrNTMwoTeuPMV/iQg+39gE0vKwsi6i1FTL+aGnR4eAMyHbRU/Bc=@vger.kernel.org
X-Gm-Message-State: AFuF++k3cYSxzd22MD1Z31/KvTP1Yb9ZCIaen8D7cRCo1izUgAo57Xgp
	U4dhkfbSSCdPsL2HAac3ONHTjD8qTYkW6bmfvPT9wUkKrn7I2xgc1mLewvd1SPYeKSOJxm6Ck9W
	8KxbJPIgf+my2IA==
X-Received: from qtqv19.prod.google.com ([2002:ac8:7493:0:b0:52f:b382:accc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:88:b0:51c:217f:518 with SMTP id d75a77b69052e-530547e3342mr240763761cf.6.1788767935033;
 Mon, 07 Sep 2026 00:58:55 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:42 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-6-edumazet@google.com>
Subject: [PATCH net-next 5/9] sit: convert 6RD configuration to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to allow lockless readers in future patches, convert
'tunnel->ip6rd' to an RCU protected pointer.

Updating 6RD configuration via ipip6_tunnel_update_6rd() or
ipip6_tunnel_clone_6rd() now allocates a struct ip_tunnel_6rd_parm and
uses rcu_assign_pointer() to publish it, freeing the previous
parameters with kfree_rcu().

Readers in check_6rd() and only_dnatted() use rcu_dereference() under
existing RCU read lock, preventing torn reads on the 128-bit IPv6
prefix.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h |   3 +-
 net/ipv6/sit.c           | 160 ++++++++++++++++++++++++++++-----------
 2 files changed, 117 insertions(+), 46 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7c9aadfe8fe396da10a47e93499a97141ac04f4c..7fff59bab53b682ac0d1efd1f47082ba7d633fd2 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -127,6 +127,7 @@ struct ip_tunnel_6rd_parm {
 	__be32			relay_prefix;
 	u16			prefixlen;
 	u16			relay_prefixlen;
+	struct rcu_head		rcu;
 };
 #endif
 
@@ -185,7 +186,7 @@ struct ip_tunnel {
 
 	/* for SIT */
 #ifdef CONFIG_IPV6_SIT_6RD
-	struct ip_tunnel_6rd_parm ip6rd;
+	struct ip_tunnel_6rd_parm __rcu *ip6rd;
 #endif
 	struct ip_tunnel_prl_entry __rcu *prl;	/* potential router list */
 	unsigned int		prl_count;	/* # of entries in PRL */
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index e85fa80e80d1ad2c593b860685b9f5bac21e66d9..7cabcd3afbc4f06d9a08374e6d8df2fb1bfb9676 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -183,21 +183,47 @@ static void ipip6_tunnel_link(struct sit_net *sitn, struct ip_tunnel *t)
 	rcu_assign_pointer(*tp, t);
 }
 
-static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
+static int ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
 {
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct ip_tunnel_6rd_parm *new_6rd, *old_6rd;
+
+	new_6rd = kmalloc_obj(*new_6rd);
+	if (!new_6rd)
+		return -ENOMEM;
 
 	if (dev == sitn->fb_tunnel_dev || !sitn->fb_tunnel_dev) {
-		ipv6_addr_set(&t->ip6rd.prefix, htonl(0x20020000), 0, 0, 0);
-		t->ip6rd.relay_prefix = 0;
-		t->ip6rd.prefixlen = 16;
-		t->ip6rd.relay_prefixlen = 0;
+		ipv6_addr_set(&new_6rd->prefix, htonl(0x20020000), 0, 0, 0);
+		new_6rd->relay_prefix = 0;
+		new_6rd->prefixlen = 16;
+		new_6rd->relay_prefixlen = 0;
 	} else {
 		struct ip_tunnel *t0 = netdev_priv(sitn->fb_tunnel_dev);
-		memcpy(&t->ip6rd, &t0->ip6rd, sizeof(t->ip6rd));
+		struct ip_tunnel_6rd_parm *t0_6rd;
+
+		t0_6rd = rtnl_dereference(t0->ip6rd);
+		if (t0_6rd) {
+			*new_6rd = *t0_6rd;
+		} else {
+			ipv6_addr_set(&new_6rd->prefix, htonl(0x20020000), 0, 0, 0);
+			new_6rd->relay_prefix = 0;
+			new_6rd->prefixlen = 16;
+			new_6rd->relay_prefixlen = 0;
+		}
+	}
+
+	old_6rd = rcu_dereference_protected(t->ip6rd,
+					    lockdep_rtnl_is_held() ||
+					    dev->reg_state == NETREG_UNINITIALIZED);
+	rcu_assign_pointer(t->ip6rd, new_6rd);
+	if (old_6rd) {
+		dst_cache_reset(&t->dst_cache);
+		netdev_state_change(t->dev);
+		kfree_rcu(old_6rd, rcu);
 	}
 #endif
+	return 0;
 }
 
 static int ipip6_tunnel_create(struct net_device *dev)
@@ -206,6 +232,10 @@ static int ipip6_tunnel_create(struct net_device *dev)
 	struct sit_net *sitn = net_generic(t->net, sit_net_id);
 	int err;
 
+	err = ipip6_tunnel_clone_6rd(dev, sitn);
+	if (err < 0)
+		goto out;
+
 	__dev_addr_set(dev, &t->parms.iph.saddr, 4);
 	memcpy(dev->broadcast, &t->parms.iph.daddr, 4);
 
@@ -218,8 +248,6 @@ static int ipip6_tunnel_create(struct net_device *dev)
 	if (err < 0)
 		goto out;
 
-	ipip6_tunnel_clone_6rd(dev, sitn);
-
 	ipip6_tunnel_link(sitn, t);
 	return 0;
 
@@ -281,6 +309,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	return nt;
 
 failed_free:
+	ipip6_dev_free(dev);
 	free_netdev(dev);
 failed:
 	return NULL;
@@ -631,8 +660,13 @@ static bool only_dnatted(const struct ip_tunnel *tunnel,
 	int prefix_len;
 
 #ifdef CONFIG_IPV6_SIT_6RD
-	prefix_len = tunnel->ip6rd.prefixlen + 32
-		- tunnel->ip6rd.relay_prefixlen;
+	const struct ip_tunnel_6rd_parm *ip6rd;
+
+	ip6rd = rcu_dereference(tunnel->ip6rd);
+	if (ip6rd)
+		prefix_len = ip6rd->prefixlen + 32 - ip6rd->relay_prefixlen;
+	else
+		prefix_len = 48;
 #else
 	prefix_len = 48;
 #endif
@@ -810,25 +844,28 @@ static bool check_6rd(struct ip_tunnel *tunnel, const struct in6_addr *v6dst,
 		      __be32 *v4dst)
 {
 #ifdef CONFIG_IPV6_SIT_6RD
-	if (ipv6_prefix_equal(v6dst, &tunnel->ip6rd.prefix,
-			      tunnel->ip6rd.prefixlen)) {
+	const struct ip_tunnel_6rd_parm *ip6rd;
+
+	ip6rd = rcu_dereference(tunnel->ip6rd);
+	if (ip6rd && ipv6_prefix_equal(v6dst, &ip6rd->prefix,
+				       ip6rd->prefixlen)) {
 		unsigned int pbw0, pbi0;
 		int pbi1;
 		u32 d;
 
-		pbw0 = tunnel->ip6rd.prefixlen >> 5;
-		pbi0 = tunnel->ip6rd.prefixlen & 0x1f;
+		pbw0 = ip6rd->prefixlen >> 5;
+		pbi0 = ip6rd->prefixlen & 0x1f;
 
-		d = tunnel->ip6rd.relay_prefixlen < 32 ?
+		d = ip6rd->relay_prefixlen < 32 ?
 			(ntohl(v6dst->s6_addr32[pbw0]) << pbi0) >>
-		    tunnel->ip6rd.relay_prefixlen : 0;
+		    ip6rd->relay_prefixlen : 0;
 
-		pbi1 = pbi0 - tunnel->ip6rd.relay_prefixlen;
+		pbi1 = pbi0 - ip6rd->relay_prefixlen;
 		if (pbi1 > 0)
 			d |= ntohl(v6dst->s6_addr32[pbw0 + 1]) >>
 			     (32 - pbi1);
 
-		*v4dst = tunnel->ip6rd.relay_prefix | htonl(d);
+		*v4dst = ip6rd->relay_prefix | htonl(d);
 		return true;
 	}
 #else
@@ -1164,6 +1201,7 @@ static void ipip6_tunnel_update(struct ip_tunnel *t,
 static int ipip6_tunnel_update_6rd(struct ip_tunnel *t,
 				   struct ip_tunnel_6rd *ip6rd)
 {
+	struct ip_tunnel_6rd_parm *new_6rd, *old_6rd;
 	struct in6_addr prefix;
 	__be32 relay_prefix;
 
@@ -1183,10 +1221,20 @@ static int ipip6_tunnel_update_6rd(struct ip_tunnel *t,
 	if (relay_prefix != ip6rd->relay_prefix)
 		return -EINVAL;
 
-	t->ip6rd.prefix = prefix;
-	t->ip6rd.relay_prefix = relay_prefix;
-	t->ip6rd.prefixlen = ip6rd->prefixlen;
-	t->ip6rd.relay_prefixlen = ip6rd->relay_prefixlen;
+	new_6rd = kmalloc_obj(*new_6rd);
+	if (!new_6rd)
+		return -ENOMEM;
+
+	new_6rd->prefix = prefix;
+	new_6rd->relay_prefix = relay_prefix;
+	new_6rd->prefixlen = ip6rd->prefixlen;
+	new_6rd->relay_prefixlen = ip6rd->relay_prefixlen;
+
+	old_6rd = rtnl_dereference(t->ip6rd);
+	rcu_assign_pointer(t->ip6rd, new_6rd);
+	if (old_6rd)
+		kfree_rcu(old_6rd, rcu);
+
 	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(t->dev);
 	return 0;
@@ -1195,6 +1243,7 @@ static int ipip6_tunnel_update_6rd(struct ip_tunnel *t,
 static int
 ipip6_tunnel_get6rd(struct net_device *dev, struct ip_tunnel_parm __user *data)
 {
+	const struct ip_tunnel_6rd_parm *ip6rd_parm;
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	struct ip_tunnel_6rd ip6rd;
@@ -1207,10 +1256,15 @@ ipip6_tunnel_get6rd(struct net_device *dev, struct ip_tunnel_parm __user *data)
 	if (!t)
 		t = netdev_priv(dev);
 
-	ip6rd.prefix = t->ip6rd.prefix;
-	ip6rd.relay_prefix = t->ip6rd.relay_prefix;
-	ip6rd.prefixlen = t->ip6rd.prefixlen;
-	ip6rd.relay_prefixlen = t->ip6rd.relay_prefixlen;
+	ip6rd_parm = rtnl_dereference(t->ip6rd);
+	if (ip6rd_parm) {
+		ip6rd.prefix = ip6rd_parm->prefix;
+		ip6rd.relay_prefix = ip6rd_parm->relay_prefix;
+		ip6rd.prefixlen = ip6rd_parm->prefixlen;
+		ip6rd.relay_prefixlen = ip6rd_parm->relay_prefixlen;
+	} else {
+		memset(&ip6rd, 0, sizeof(ip6rd));
+	}
 	if (copy_to_user(data, &ip6rd, sizeof(ip6rd)))
 		return -EFAULT;
 	return 0;
@@ -1222,20 +1276,16 @@ ipip6_tunnel_6rdctl(struct net_device *dev, struct ip_tunnel_6rd __user *data,
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_6rd ip6rd;
-	int err;
 
 	if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 	if (copy_from_user(&ip6rd, data, sizeof(ip6rd)))
 		return -EFAULT;
 
-	if (cmd != SIOCDEL6RD) {
-		err = ipip6_tunnel_update_6rd(t, &ip6rd);
-		if (err < 0)
-			return err;
-	} else
-		ipip6_tunnel_clone_6rd(dev, dev_to_sit_net(dev));
-	return 0;
+	if (cmd != SIOCDEL6RD)
+		return ipip6_tunnel_update_6rd(t, &ip6rd);
+
+	return ipip6_tunnel_clone_6rd(dev, dev_to_sit_net(dev));
 }
 
 #endif /* CONFIG_IPV6_SIT_6RD */
@@ -1406,8 +1456,17 @@ static const struct net_device_ops ipip6_netdev_ops = {
 static void ipip6_dev_free(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+#ifdef CONFIG_IPV6_SIT_6RD
+	struct ip_tunnel_6rd_parm *ip6rd;
 
-	dst_cache_destroy(&tunnel->dst_cache);
+	ip6rd = rcu_dereference_protected(tunnel->ip6rd, 1);
+	RCU_INIT_POINTER(tunnel->ip6rd, NULL);
+	kfree(ip6rd);
+#endif
+	if (tunnel->dst_cache.cache) {
+		dst_cache_destroy(&tunnel->dst_cache);
+		tunnel->dst_cache.cache = NULL;
+	}
 }
 
 #define SIT_FEATURES (NETIF_F_SG	   | \
@@ -1576,8 +1635,10 @@ static int ipip6_newlink(struct net_device *dev,
 		return -EEXIST;
 
 	err = ipip6_tunnel_create(dev);
-	if (err < 0)
+	if (err < 0) {
+		ipip6_dev_free(dev);
 		return err;
+	}
 
 	if (tb[IFLA_MTU]) {
 		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
@@ -1695,6 +1756,9 @@ static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct ip_tunnel_parm_kern *parm = &tunnel->parms;
+#ifdef CONFIG_IPV6_SIT_6RD
+	const struct ip_tunnel_6rd_parm *ip6rd;
+#endif
 
 	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
 	    nla_put_in_addr(skb, IFLA_IPTUN_LOCAL, parm->iph.saddr) ||
@@ -1710,14 +1774,16 @@ static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		goto nla_put_failure;
 
 #ifdef CONFIG_IPV6_SIT_6RD
-	if (nla_put_in6_addr(skb, IFLA_IPTUN_6RD_PREFIX,
-			     &tunnel->ip6rd.prefix) ||
-	    nla_put_in_addr(skb, IFLA_IPTUN_6RD_RELAY_PREFIX,
-			    tunnel->ip6rd.relay_prefix) ||
-	    nla_put_u16(skb, IFLA_IPTUN_6RD_PREFIXLEN,
-			tunnel->ip6rd.prefixlen) ||
-	    nla_put_u16(skb, IFLA_IPTUN_6RD_RELAY_PREFIXLEN,
-			tunnel->ip6rd.relay_prefixlen))
+	ip6rd = rcu_dereference_rtnl(tunnel->ip6rd);
+	if (ip6rd &&
+	    (nla_put_in6_addr(skb, IFLA_IPTUN_6RD_PREFIX,
+			      &ip6rd->prefix) ||
+	     nla_put_in_addr(skb, IFLA_IPTUN_6RD_RELAY_PREFIX,
+			     ip6rd->relay_prefix) ||
+	     nla_put_u16(skb, IFLA_IPTUN_6RD_PREFIXLEN,
+			 ip6rd->prefixlen) ||
+	     nla_put_u16(skb, IFLA_IPTUN_6RD_RELAY_PREFIXLEN,
+			 ip6rd->relay_prefixlen)))
 		goto nla_put_failure;
 #endif
 
@@ -1863,17 +1929,21 @@ static int __net_init sit_init_net(struct net *net)
 	t = netdev_priv(sitn->fb_tunnel_dev);
 	t->net = net;
 
+	err = ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
+	if (err < 0)
+		goto err_reg_dev;
+
 	err = register_netdev(sitn->fb_tunnel_dev);
 	if (err)
 		goto err_reg_dev;
 
-	ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
 	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
 
 	strscpy(t->parms.name, sitn->fb_tunnel_dev->name);
 	return 0;
 
 err_reg_dev:
+	ipip6_dev_free(sitn->fb_tunnel_dev);
 	free_netdev(sitn->fb_tunnel_dev);
 err_alloc_dev:
 	return err;
-- 
2.55.0.979.g7e5102b832-goog

