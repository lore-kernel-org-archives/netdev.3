Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269144E64E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821941; cv=none; b=STFKGGzdo56mdfpXyI/TcJOXWWtb/2P+Sgb5fe/bsirPdB/uXcG/65tx5jOqn7222YLIKk9KniKe3Tii36lMYkcMrSyvL5DPOwWOV21dKOnZ81pmqeO0Au4BRMvNL/xfcqVTY0LjpTqxkyNLxM2sz08V5K5V9j6ZaN9H0qmxYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821941; c=relaxed/simple;
	bh=48BBTfAmlo6oADo47hWjHC/xsUQOQV/0+yuTfS77ul8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OEZ1mjIlCnPXvy5FEolKoZ5ER8AohyR61zhAT60XIUT6p7wt/gVzAANxTrKlPsRmtFxsa/cITKKka2pP3Z3MTeVRH2H1in1NUcDaduirnuR8XyB34Yjr/SzO6pWPSHv0JJaGe2/caxFcQs8VUmInYnwldorEHBCorKqsFfeI2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwH81kgA; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwH81kgA"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d7151120d6so62091445ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788821939; x=1789426739; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAB1/Us3msu+i1ZwzE0vUpvfL4OCnB5ETelbpTnXsk4=;
        b=HwH81kgA9a3vEoAbmINQ+lCe5UqbYlcGLJoJ4yI8Pa3/WrQz0vB+vTPd2hThvne0GE
         uZQjHmpIbEssoMPHc1233eORyaY/9Ksdz1gZ2/v/XHSq06F0fBNl9zODNxigdydESs69
         pZL5n8e3C8p1nLNUsm8RZxzu/IaXFx01/mRr59j2QZoHvisbITJq2A2qWifBotpz5yo6
         Q1dsDm74WFHRuqGZzbEMuOmfl2Z+CNHiigN7PopO/OI+b7ggwyon7N6L2laopVRsdQv+
         U5HWo1yig7XRXp5AWacu/wqDUGO9MFB0EHx9gdQuZw+OkR16R4uIpYtPCxiXx1hxgJSr
         DBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821939; x=1789426739;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAB1/Us3msu+i1ZwzE0vUpvfL4OCnB5ETelbpTnXsk4=;
        b=G1IBPdEh3OZqHAOO/boNTgzrpldgrajmmAnbAvhvrmssTHX0IYzOAYVKAFwvGJFIZk
         McPHCRC3Uxg7ix342PXkHG0DAxFv7/Hl4b0ca9It61+iiPi1ZrpLhHnjVTdAk5fUUD6f
         A6SfZHVH4X+CHIrTRG6HIQj9a99tt6CccOpAgu3ZIkCR5N0WuIlVhpAwdvk/fCRd7Vev
         edeAa33m15myZQ/hoJD9iy2ZqA2aboxqxD9iPoXRryhFnHL7KnI3UwzDbqbVi4JCNs6H
         Nv4nHv81omoGzEY1Wqr/MybWwnA0PRfQitih4HjShQh/FQFTsk7S9K0SJ7ae1hJvFi2m
         ndxA==
X-Forwarded-Encrypted: i=1; AKwUvBzlVCC4U/l6gGyB7Re03y6gwefGsvXNxrn5cRRyVZ/d4+4NMv//NassNB0mX6/bYo1qmFMlo1g=@vger.kernel.org
X-Gm-Message-State: AFuF++kjZzdMu2mzx+m/XGAyFmB4eZ7Za2Af1POusiALtgkrD6++TrjU
	0jwHylTy5ngQ5usePf0Ci8JNrSPOSYlWPyG8jp+8KhVOGsRS5LnumPHbPCcAZaeQ6w3gIeK9MnB
	nsvhC5Q==
X-Received: from plec3.prod.google.com ([2002:a17:902:f303:b0:2cc:77e3:3ef0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228c:b0:2db:73fc:b57f
 with SMTP id d9443c01a7336-2db73fcc702mr40431245ad.10.1788821938695; Mon, 07
 Sep 2026 15:58:58 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:56:51 +0000
In-Reply-To: <20260907225846.3787676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907225846.3787676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907225846.3787676-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 6/7] ip_tunnel: Protect ip_tunnel_net.tunnels[]
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

