Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1854E2F35
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599849; cv=none; b=iAXTpaCkd8BtD92TbIowySbx4CDedBQM2dL4wutwvGkmhvzcgTbGYdZi5l4QOA6VUZgtxF4Kh5jVyxNYu9xY994klFWExkF7WNk0lPFolzKH56Z/mEHZ+7orRofClI1Yc22pi+r5iC61xf6wSUjJvimh0+s4hxW4+sX8vujqxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599849; c=relaxed/simple;
	bh=q0i2k+92JUy6RFRymcltFfRRUvruXGqXQqEtuwrw6+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mj1YfNrMZbxcljWBUeBrKgycEjmE0C7JaQGqgfZdcsYZH0wPnEaNpFpK1hwv+N1Wx17M2wlc99eUXt7vSbwKQSmUDdbiZHi457XOf+npZiF4Oq+n4N3K3m79hiqbMxWx7H3h1CB95HinhOhtca8Xallwg4ODUApSMYJW3wx8Xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqsuJ8xm; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqsuJ8xm"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so169376a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789599839; x=1790204639; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wy4sAt3F0UzR266c1dQIrUQbEHkExHdtZVCiSZUK0y0=;
        b=tqsuJ8xmvqx8YKG/lndjsxrbuL6NSyRJHc/jX4M7wkl7kW+5bFVcp5XFDHclwDq221
         P7v1D/De2BZOtI/Km7rBBy1cnF0i7aMYwmFIXycnb7ecwJCeKtV3d9p2RXLZbQHUoenC
         WFlmn+9zsl+CTDkibp2gaXwSFeLpJwbDV2OECVI5oJjjCjMxnOZt57YcmePtMAooXgZX
         DW8pBOsBzoIY1h03+x9sbBy7nTehyJ0Re87Aweu1YGvLt/LBzq57RcNupXurNK+MdjLZ
         kKXjJdZHxpXkV86lPfAuuw2bVu6V6K9m0/+X+nDsgsbfyO7JEemOLPYF1L57BzHTeTsJ
         sGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789599839; x=1790204639;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wy4sAt3F0UzR266c1dQIrUQbEHkExHdtZVCiSZUK0y0=;
        b=VMiRjuzre+lj7x6HF6iiQC1yvSZt2D4KUmfdpUTcrcnzZGafjyyjksYRgYfES5pLE+
         62f06NO9yHMQ7wIDSgluPzxSj7/PBfqceEmXRCL8FW22oleH9k+MpWp70Te9bgOwHyvw
         TCx3+HNNSCzlxgERZ6F6nkWUQksdFFS7fRRLmaHqFiE6Ji/ql0dvgBV7rXGREI+ldQJg
         KRDhejvPf06TvGq1pKwK1lsIfjEfMYB9od3E3E0uZ6+wGrE8U3UvsHY82F9wXsN+CoyO
         GlbxuJMPcJjnB9rZzUJGVf30hwgzs2Isx+LRk3JmagDV4l0CW4eyeTJzx7n2oVeYn3cc
         M19w==
X-Forwarded-Encrypted: i=1; AKwUvBzrQBTYqfSB8k00tLyHw4XFifdSRrt57d1iMzmCEebfhA7yei9nmBhCGo8N1z3RTRzCUAATPSI=@vger.kernel.org
X-Gm-Message-State: AFuF++nefYgwwvXIAcXBLsiw60rQwjB+SX1l3XhJ4i2BSW/pcbujMfIG
	b/GaklfOrTvmTNsFunHpjOASbhtGvk/mIxqN7MpsmaQQea3xe98v4OoRRVkxN3uOS3bC1Tj08KU
	oDTybjA==
X-Received: from pgbdr2.prod.google.com ([2002:a05:6a02:fc2:b0:cc5:10e3:bb0e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d70f:b0:3db:2c66:6638
 with SMTP id adf61e73a8af0-3dd5f471e3emr11586532637.10.1789599838855; Wed, 16
 Sep 2026 16:03:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:02:24 +0000
In-Reply-To: <20260916230353.367014-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916230353.367014-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916230353.367014-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/6] ip6_gre: Protect ip6gre_net.tunnels[][] with mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct ip6_tnl.net is the netns where encapsulated packets
flow into.

struct ip6_tnl is linked to ip6gre_net.tunnels[][] of netns.

During netns dismantle or module unload, ip6gre_exit_rtnl_net()
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
 net/ipv6/ip6_gre.c | 78 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index a9059f3841ac..ac1087330465 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -65,6 +65,7 @@ MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
 static unsigned int ip6gre_net_id __read_mostly;
 struct ip6gre_net {
 	struct hlist_head tunnels[4][IP6_GRE_HASH_SIZE];
+	struct mutex tunnels_lock;
 
 	struct ip6_tnl __rcu *collect_md_tun;
 	struct ip6_tnl __rcu *collect_md_tun_erspan;
@@ -1254,8 +1255,12 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 	struct ip6gre_net *ign;
 	int err = 0;
 
+	DEBUG_NET_WARN_ON_ONCE(netdev_need_ops_lock(dev));
+
 	ign = net_generic(net, ip6gre_net_id);
 
+	mutex_lock(&ign->tunnels_lock);
+
 	switch (cmd) {
 	case SIOCGETTUNNEL:
 		if (dev == ign->fb_tunnel_dev) {
@@ -1353,6 +1358,8 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 	}
 
 done:
+	mutex_unlock(&ign->tunnels_lock);
+
 	unregister_netdevice_many(&dev_kill_list);
 	return err;
 }
@@ -1552,6 +1559,8 @@ static void __net_exit ip6gre_exit_rtnl_net(struct net *net,
 
 	WRITE_ONCE(ign->fb_tunnel_dev, NULL);
 
+	mutex_lock(&ign->tunnels_lock);
+
 	for (prio = 0; prio < 4; prio++) {
 		int h;
 
@@ -1564,6 +1573,8 @@ static void __net_exit ip6gre_exit_rtnl_net(struct net *net,
 				__ip6gre_dellink(t->dev, dev_kill_list);
 		}
 	}
+
+	mutex_unlock(&ign->tunnels_lock);
 }
 
 static int __net_init ip6gre_init_net(struct net *net)
@@ -1579,6 +1590,8 @@ static int __net_init ip6gre_init_net(struct net *net)
 			INIT_HLIST_HEAD(&ign->tunnels[prio][h]);
 	}
 
+	mutex_init(&ign->tunnels_lock);
+
 	if (!net_has_fallback_tunnels(net))
 		return 0;
 	ndev = alloc_netdev(sizeof(struct ip6_tnl), "ip6gre0",
@@ -1975,18 +1988,22 @@ static int ip6gre_newlink(struct net_device *dev,
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
 	struct ip6gre_net *ign;
-	int err;
+	int err = 0;
 
 	ip6gre_netlink_parms(data, &nt->parms);
 	ign = net_generic(net, ip6gre_net_id);
 
+	mutex_lock(&ign->tunnels_lock);
+
 	if (nt->parms.collect_md) {
 		if (rtnl_dereference(ign->collect_md_tun))
-			return -EEXIST;
+			err = -EEXIST;
 	} else {
 		if (ip6gre_tunnel_find(net, &nt->parms, dev->type))
-			return -EEXIST;
+			err = -EEXIST;
 	}
+	if (err)
+		goto unlock;
 
 	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
@@ -1994,6 +2011,10 @@ static int ip6gre_newlink(struct net_device *dev,
 		ip6gre_tunnel_link_md(ign, nt);
 		ip6gre_tunnel_link(net_generic(net, ip6gre_net_id), nt);
 	}
+
+unlock:
+	mutex_unlock(&ign->tunnels_lock);
+
 	return err;
 }
 
@@ -2036,22 +2057,32 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 			     struct netlink_ext_ack *extack)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
+	struct ip6gre_net *ign;
+	int err = 0;
+
+	ign = net_generic(t->net, ip6gre_net_id);
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
+	mutex_lock(&ign->tunnels_lock);
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
-	if (IS_ERR(t))
-		return PTR_ERR(t);
+	if (IS_ERR(t)) {
+		err = PTR_ERR(t);
+		goto unlock;
+	}
 
 	ip6gre_tunnel_unlink_md(ign, t);
 	ip6gre_tunnel_unlink(ign, t);
 	ip6gre_tnl_change(t, &p, !tb[IFLA_MTU]);
 	ip6gre_tunnel_link_md(ign, t);
 	ip6gre_tunnel_link(ign, t);
-	return 0;
+unlock:
+	mutex_unlock(&ign->tunnels_lock);
+
+	return err;
 }
 
 static void __ip6gre_dellink(struct net_device *dev, struct list_head *head)
@@ -2077,8 +2108,12 @@ static void ip6gre_dellink(struct net_device *dev, struct list_head *head)
 
 	ign = net_generic(t->net, ip6gre_net_id);
 
+	mutex_lock(&ign->tunnels_lock);
+
 	if (dev != ign->fb_tunnel_dev)
 		__ip6gre_dellink(dev, head);
+
+	mutex_unlock(&ign->tunnels_lock);
 }
 
 static size_t ip6gre_get_size(const struct net_device *dev)
@@ -2234,19 +2269,23 @@ static int ip6erspan_newlink(struct net_device *dev,
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
 	struct ip6gre_net *ign;
-	int err;
+	int err = 0;
 
 	ip6gre_netlink_parms(data, &nt->parms);
 	ip6erspan_set_version(data, &nt->parms);
 	ign = net_generic(net, ip6gre_net_id);
 
+	mutex_lock(&ign->tunnels_lock);
+
 	if (nt->parms.collect_md) {
 		if (rtnl_dereference(ign->collect_md_tun_erspan))
-			return -EEXIST;
+			err = -EEXIST;
 	} else {
 		if (ip6gre_tunnel_find(net, &nt->parms, dev->type))
-			return -EEXIST;
+			err = -EEXIST;
 	}
+	if (err)
+		goto unlock;
 
 	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
@@ -2254,6 +2293,10 @@ static int ip6erspan_newlink(struct net_device *dev,
 		ip6erspan_tunnel_link_md(ign, nt);
 		ip6gre_tunnel_link(net_generic(net, ip6gre_net_id), nt);
 	}
+
+unlock:
+	mutex_unlock(&ign->tunnels_lock);
+
 	return err;
 }
 
@@ -2278,14 +2321,20 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
+	int err = 0;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
 	ign = net_generic(t->net, ip6gre_net_id);
+
+	mutex_lock(&ign->tunnels_lock);
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
-	if (IS_ERR(t))
-		return PTR_ERR(t);
+	if (IS_ERR(t)) {
+		err = PTR_ERR(t);
+		goto unlock;
+	}
 
 	ip6erspan_set_version(data, &p);
 	ip6gre_tunnel_unlink_md(ign, t);
@@ -2293,7 +2342,10 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
 	ip6erspan_tunnel_link_md(ign, t);
 	ip6gre_tunnel_link(ign, t);
-	return 0;
+unlock:
+	mutex_unlock(&ign->tunnels_lock);
+
+	return err;
 }
 
 static struct rtnl_link_ops ip6gre_link_ops __read_mostly = {
-- 
2.55.0.1082.g2b9226bbc0-goog

