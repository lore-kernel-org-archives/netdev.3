Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C55293EE
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997473; cv=none; b=qhG+q3kmg+rTgyR38HhGuKJJlIX/ymtp3JWDfJwOHvhZ6xT2e2MQz0Z+iKasaFxZifaTC4OIVZkY11rvdeArfnFazS8yoHxCXSXk9Q0dKhAf/f2E3ifWinoPxDIddbWNZUI4QIlJuW7ebntUhQ6DKRcYnypQeHs+Ju/nSRtGoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997473; c=relaxed/simple;
	bh=48BBTfAmlo6oADo47hWjHC/xsUQOQV/0+yuTfS77ul8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GmsYt6D211thxUhHFRltR4YFW21t6R5Xkvap48J6jV+JQWsWOI5dt4fROBRRf2vX6glJekic/547n06OcpANO8QOB4/jfujbf3L1oMnlycujOpKT0M7TKAbix/beYFJRc1/r6BrNBtGHz7dwCJmtTsHI5TPpcyEK9unyBNzA6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLMs5vnA; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLMs5vnA"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd03492f9fso15512625ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788997471; x=1789602271; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAB1/Us3msu+i1ZwzE0vUpvfL4OCnB5ETelbpTnXsk4=;
        b=wLMs5vnABuHGl1AkZO45j/xquDMk8C0IwM9+jehg8Z+2JmO0I6U4WHQIlHu3jhrKwN
         FzB6rRUy6KE+CYiKcR4Gi6n4ZRSjJpBZ7yO2hygIuWlTdhAAnw1RLccRAWLeCemx1YlJ
         KAOycGsMG0JpVXnM5aDVsN9coYRmuFqP9Ex6s5nDp02hF1Iqnf4kAewTy8j4yoWimrs1
         fLcOUlEhydErbn6mjURG9I1hD/apKFPbVNlJhqCiab3uzEa3I/DlmkZcfUan57LzHKAq
         FSe4XS2mwE3kRfwZd4g06Yng34WP9bZXwptnMY5b2S+EVTR3aDtI0MSrpSS+Aw+2WTiM
         3Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997471; x=1789602271;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAB1/Us3msu+i1ZwzE0vUpvfL4OCnB5ETelbpTnXsk4=;
        b=sSXlTNYfCShjEjpm0LiaWSjC3+wfv2Rd92Vvaw3KYojgLsiTdQnPAKOlNW3162Pg2U
         A5wLtOyqULjIMthCbDC2ZSB/D5Vuv+h4LBgx00VzMbfDncSMDbXoeN9MrDgYmQ7pplJv
         307OZU5/nImwcmH36T+fmb714Ch4n3lrx84H39StUE+EQYpXHEpSQ4ZcJ7RcCEuAxo79
         Ogzum+p7ZIbd7bpYvxQmithYhgQmrwhYxFm4ButtlF4+b7yUuEz3krVzhgxHg/qnnLJe
         +Bl9sHFudRysmtAtqAa9MJXwiP0TXZcV/d8gtTgOfpxVL2d7xxObZveX2SDxZEn9RgOO
         KfiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwm+OjuyWzLivVLMKmnf4OXny5IIOaksGkQLzNs04eKSeT0WCnLrfFBARqfnxmTnmhfNiNuzzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l7bcGKwW4Ap2MzJNfyiUjZdFwEsf2jdGGwMlVbqdvQ6VED1h8H
	SMD/N4u/CGQNkCIjhux1GoGPBZ07MJwtrkq8vko22FXAfbwKRDESYJ8sCcuHif+iEIattzs4EON
	ykTFVeA==
X-Received: from plei1.prod.google.com ([2002:a17:902:e481:b0:2db:4036:e5b4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1670:b0:2d9:438e:b70d
 with SMTP id d9443c01a7336-2db1232c88emr581797095ad.1.1788997471003; Wed, 09
 Sep 2026 16:44:31 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:43:49 +0000
In-Reply-To: <20260909234422.2416506-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909234422.2416506-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909234422.2416506-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 6/7] ip_tunnel: Protect ip_tunnel_net.tunnels[]
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
index b0f9d02a7f18..57a67900e2d3 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -215,6 +215,7 @@ struct ip_tunnel_net {
 	struct net_device *fb_tunnel_dev;
 	struct rtnl_link_ops *rtnl_link_ops;
 	struct hlist_head tunnels[IP_TNL_HASH_SIZE];
+	struct mutex tunnels_lock;
 	struct ip_tunnel __rcu *collect_md_tun;
 	int type;
 };
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 3ba03c2b3b90..9ad63f1af37a 100644
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
@@ -894,6 +895,16 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
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
@@ -903,8 +914,12 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
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
@@ -988,7 +1003,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 			dev = t->dev;
 		}
 
-		ip_tunnel_dellink(dev, &dev_kill_list);
+		__ip_tunnel_dellink(dev, &dev_kill_list);
 		err = 0;
 		break;
 
@@ -997,6 +1012,8 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 	}
 
 done:
+	mutex_unlock(&itn->tunnels_lock);
+
 	unregister_netdevice_many(&dev_kill_list);
 
 	return err;
@@ -1093,8 +1110,9 @@ void ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
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
@@ -1126,6 +1144,8 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 	for (i = 0; i < IP_TNL_HASH_SIZE; i++)
 		INIT_HLIST_HEAD(&itn->tunnels[i]);
 
+	mutex_init(&itn->tunnels_lock);
+
 	if (!ops || !net_has_fallback_tunnels(net)) {
 		struct ip_tunnel_net *it_init_net;
 
@@ -1164,6 +1184,8 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 
 	ASSERT_RTNL_NET(net);
 
+	mutex_lock(&itn->tunnels_lock);
+
 	WRITE_ONCE(itn->fb_tunnel_dev, NULL);
 
 	for (h = 0; h < IP_TNL_HASH_SIZE; h++) {
@@ -1172,8 +1194,10 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			ip_tunnel_dellink(t->dev, head);
+			__ip_tunnel_dellink(t->dev, head);
 	}
+
+	mutex_unlock(&itn->tunnels_lock);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
 
@@ -1189,6 +1213,8 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 	nt = netdev_priv(dev);
 	itn = net_generic(net, nt->ip_tnl_net_id);
 
+	mutex_lock(&itn->tunnels_lock);
+
 	if (nt->collect_md) {
 		if (rtnl_dereference(itn->collect_md_tun))
 			err = -EEXIST;
@@ -1225,6 +1251,8 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 
 	ip_tunnel_add(itn, nt);
 out:
+	mutex_unlock(&itn->tunnels_lock);
+
 	return err;
 
 err_dev_set_mtu:
@@ -1248,6 +1276,8 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (dev == itn->fb_tunnel_dev)
 		return -EINVAL;
 
+	mutex_lock(&itn->tunnels_lock);
+
 	t = ip_tunnel_find(itn, p, dev->type);
 
 	if (t) {
@@ -1276,6 +1306,8 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	ip_tunnel_update(itn, t, dev, p, !tb[IFLA_MTU], fwmark);
 out:
+	mutex_unlock(&itn->tunnels_lock);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_changelink);
-- 
2.55.0.1003.g10538fe699-goog

