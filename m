Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A63F075A
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254053; cv=none; b=WOuPiBJT9u5+BILSdoZWcGY474TNSH7QA7kG9LelM5yuvJ1Gfg1+WwZlb9NPQ9t/OmQBEuVTzc9myRuw4jUJbxId+g8yKlzTLYxtxnQtCGnKhTmmQX6AHwYvAexYUeJHqjp4+GjvnMzv+xZQ/Ki/3Sj+0xg1YpW5jigIXoj5Nnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254053; c=relaxed/simple;
	bh=qLaoPwvStspaRAv/ganKBuxjRSKprdDr/z/2aAGIB7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uX/aIfQIpli5htDbTv1h11wuR4ruX8zQ4Tg1x9a5KplBq14WxBWmVrXVU/BO9l379QISWwab1sSl8AIo1hsxQC+EKoLQ86a6I17eMpj1Hk83SMu5ZnrBJ32ENkWHja9DglfAzdAj0EptQsI7QYNANzO6qCI71Jfbc+uSoxXyh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OcCxbHlG; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OcCxbHlG"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a2639398cso3449653b3a.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789254051; x=1789858851; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TokLrwg43bj+pjK3hrRP0G9qECokix+bYlVf2R9B3TY=;
        b=OcCxbHlGQ+ZPXn4PIByJNDwdnz0Ste98LBUgqkbC3WKWvQtzS6B0+q+lBsDMJ9TVYa
         kDh5NKmv+geycc72G/6Slb46Z09jK/v+ez28+ND0+uSTfhcVfgJUJ6TAzSWnamGQQDbH
         p3bHY8eVuQzfQ0P1jnbxQD/Z142ZjqL5QSt9y+oQ2N26shYxdduTCNZPE3q47rL652nW
         0XRnwkWFUiRB7h/es7xz4+UJi26eEcbhyiaNFlMhB6Tnka7i1ND0kEBzmaSb6nyAAduS
         ++DRV4Av9atO99Y+vWMQJ4fmdyg1yZgQqeir+cFC6pJkVj0nZpXH2XHrgs8qM9srACXq
         MA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254051; x=1789858851;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TokLrwg43bj+pjK3hrRP0G9qECokix+bYlVf2R9B3TY=;
        b=lepvqbH4eesU2YgNVpalyUl6O69oWJKUAL1/L7tmiqjxNHXPqGDh2NHEq49fdGMa9K
         ksoQxBNlerKsFgFzq8UmVGGmjpqpdwQKvqxN9CSM3up/6/jGEJQK7Cu0DyvdMGmwE3u7
         boWkJ4qAR/k0/xPOAR2m/DdXilGapdZ/VklwC/m6Z1LDefMhYrAFdv6Ca/S0EaV+Amiy
         aXKsYNGK3pB1zMMCp1jNzOTPCXtrSRVRTUcog2i9bVbdZVGEhqMcI5ABV6wWobIV93/Z
         c/JncGSRzCkk/OG8OIfqrwz4avpq3oRNsVysLSXGbPy+Ck4pyJfci/MAEMOPbpfJKkUc
         lMhQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/HOWP3hxgCkQ5CtXlwHfbJDC/GtgnMKBlZiOpo+vbSCk/B9cpxWJ6cKQZnr4Cmb60qK9naoI=@vger.kernel.org
X-Gm-Message-State: AFuF++naMKfvi1plUK7s9wIDZrHSkMr0dR/8bHmZdRhzwEw8RUI2zI1M
	ZJu+W09iutA62gJyPMtG/3zSwFQY5GOCD6Fu2fInLRffcq36DMI6P8lmkcUS/Jsl1E0gCFrZu/s
	ohUpuGA==
X-Received: from pfnv12.prod.google.com ([2002:aa7:850c:0:b0:84e:1951:8efd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4215:b0:857:7337:5dba
 with SMTP id d2e1a72fcca58-86ccc846301mr7539392b3a.24.1789254050530; Sat, 12
 Sep 2026 16:00:50 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:00:32 +0000
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912230043.2586313-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912230043.2586313-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 6/7] ip_tunnel: Protect ip_tunnel_net.tunnels[]
 with mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct ip_tunnel.net is the netns where encapsulated packets
flow into.

struct ip_tunnel is linked to ip_tunnel_net.tunnels[] of netns.

During netns dismantle or module unload, ip_tunnel_delete_net()
iterates the list and queues devices for destruction regardless
of the devices' netns.

Thus, once RTNL is removed, the list can be modified concurrently
from different netns due to device removal.

Let's protect it with per-netns mutex.

Note that dev_siocdevprivate() calls netdev_lock_ops() but
it must be NOP for tunnel devices to avoid AB-BA deadlock.
DEBUG_NET_WARN_ON_ONCE() is added to annotate the locking
explicitly.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip_tunnels.h |  1 +
 net/ipv4/ip_tunnel.c     | 42 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index a78dfbb98044..7102aa11fae2 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -218,6 +218,7 @@ struct ip_tunnel_net {
 	struct net_device *fb_tunnel_dev;
 	struct rtnl_link_ops *rtnl_link_ops;
 	struct hlist_head tunnels[IP_TNL_HASH_SIZE];
+	struct mutex tunnels_lock;
 	struct ip_tunnel __rcu *collect_md_tun;
 	int type;
 };
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d560ae9f0222..d44976395c7c 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -219,7 +219,8 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 
 	ip_tunnel_flags_copy(flags, parms->i_flags);
 
-	hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
+	hlist_for_each_entry_rcu(t, head, hash_node,
+				 lockdep_is_held(&itn->tunnels_lock)) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
 		    link == READ_ONCE(t->parms.link) &&
@@ -892,6 +893,16 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 	netdev_state_change(dev);
 }
 
+static void __ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+	struct ip_tunnel_net *itn;
+
+	itn = net_generic(tunnel->net, tunnel->ip_tnl_net_id);
+	ip_tunnel_del(itn, tunnel);
+	unregister_netdevice_queue(dev, head);
+}
+
 int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 		  int cmd)
 {
@@ -901,8 +912,12 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 	struct net *net = t->net;
 	int err = 0;
 
+	DEBUG_NET_WARN_ON_ONCE(netdev_need_ops_lock(dev));
+
 	itn = net_generic(net, t->ip_tnl_net_id);
 
+	mutex_lock(&itn->tunnels_lock);
+
 	switch (cmd) {
 	case SIOCGETTUNNEL:
 		if (dev == itn->fb_tunnel_dev) {
@@ -986,7 +1001,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 			dev = t->dev;
 		}
 
-		ip_tunnel_dellink(dev, &dev_kill_list);
+		__ip_tunnel_dellink(dev, &dev_kill_list);
 		err = 0;
 		break;
 
@@ -995,6 +1010,8 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 	}
 
 done:
+	mutex_unlock(&itn->tunnels_lock);
+
 	unregister_netdevice_many(&dev_kill_list);
 
 	return err;
@@ -1091,8 +1108,9 @@ void ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
 	itn = net_generic(tunnel->net, tunnel->ip_tnl_net_id);
 
 	if (itn->fb_tunnel_dev != dev) {
-		ip_tunnel_del(itn, netdev_priv(dev));
-		unregister_netdevice_queue(dev, head);
+		mutex_lock(&itn->tunnels_lock);
+		__ip_tunnel_dellink(dev, head);
+		mutex_unlock(&itn->tunnels_lock);
 	}
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_dellink);
@@ -1124,6 +1142,8 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 	for (i = 0; i < IP_TNL_HASH_SIZE; i++)
 		INIT_HLIST_HEAD(&itn->tunnels[i]);
 
+	mutex_init(&itn->tunnels_lock);
+
 	if (!ops || !net_has_fallback_tunnels(net)) {
 		struct ip_tunnel_net *it_init_net;
 
@@ -1162,6 +1182,8 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 
 	ASSERT_RTNL_NET(net);
 
+	mutex_lock(&itn->tunnels_lock);
+
 	WRITE_ONCE(itn->fb_tunnel_dev, NULL);
 
 	for (h = 0; h < IP_TNL_HASH_SIZE; h++) {
@@ -1170,8 +1192,10 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			ip_tunnel_dellink(t->dev, head);
+			__ip_tunnel_dellink(t->dev, head);
 	}
+
+	mutex_unlock(&itn->tunnels_lock);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
 
@@ -1187,6 +1211,8 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 	nt = netdev_priv(dev);
 	itn = net_generic(net, nt->ip_tnl_net_id);
 
+	mutex_lock(&itn->tunnels_lock);
+
 	if (nt->collect_md) {
 		if (rtnl_dereference(itn->collect_md_tun))
 			err = -EEXIST;
@@ -1223,6 +1249,8 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 
 	ip_tunnel_add(itn, nt);
 out:
+	mutex_unlock(&itn->tunnels_lock);
+
 	return err;
 
 err_dev_set_mtu:
@@ -1246,6 +1274,8 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (dev == itn->fb_tunnel_dev)
 		return -EINVAL;
 
+	mutex_lock(&itn->tunnels_lock);
+
 	t = ip_tunnel_find(itn, p, dev->type);
 
 	if (t) {
@@ -1274,6 +1304,8 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	ip_tunnel_update(itn, t, dev, p, !tb[IFLA_MTU], fwmark);
 out:
+	mutex_unlock(&itn->tunnels_lock);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_changelink);
-- 
2.55.0.1007.g17ff1f9808-goog

