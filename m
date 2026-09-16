Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E52543F080
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599849; cv=none; b=Fy+AFoJ/xiaBeCmeUFApw6eJypfmSLWd2/QtP5BZLNjsfpxFTK2w6liOMB+Jg7zLy1GVt285FEV2bamom98pOYz8jTQCNaSXJ2jYl7Vr8HYDi/zZvX4zI4s+BcHXwNJJI7bBz+CRAvN053ClYxLutdpGRIoIc7zNTrGinbqV5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599849; c=relaxed/simple;
	bh=50kfcomhxBmJ0HL+qlD60ZsQRO3fpeiyB9uEkG1CLY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=etju2by2kZeZ6n2px7Fl2NtCMGo37noUgqCuvyKWQthtX50uEfEiZ2RNQKH5jQMffGG6KznOiZ8Vbjr+1hf8gXKBCclC1osWA7N9rTA5xGEVr4fBaxFibjCMf4RQ3NZFGiHtGaZ+GoUE0okto5bCZ5hAOMLI+xuF474a4eQyXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHceJFWh; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHceJFWh"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so197167a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789599838; x=1790204638; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2saP/NMHYOyuXWQWom5I+zLVvYROEMWeQ8iGK0p2CQ=;
        b=RHceJFWhX/SNmR8kQnZUiA1SNAlMKZAUH20wp0citdcwN5Gh+iON6xoxAGGsbAzRuz
         GV30xXABFHpjgTtLQ/QsA9FF6zlsMVLHScIvID8+hdSGxLmpvw1EeOQz1iFUSJgF9jzD
         3us+f1nWox3Ba6RV07t/qFl2OXV08vNCbc93InFJ20zm4RtfsK3MoczSaWRWO+yHdN8B
         7pCR5hjBH9bx+N+M4eMh/ck7M+xfQtv2FVRcVdPJLRgQMIpITXJJqMZPz03FLWyAEh3a
         c0eHLc2O3u4twHQd+9JPssA02swQHVXldaZjIaKoMiInQCK3kptda8uH/pY0PqK8K7BB
         doig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789599838; x=1790204638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2saP/NMHYOyuXWQWom5I+zLVvYROEMWeQ8iGK0p2CQ=;
        b=JXYxhP3v2iMLlTMNpkBR22AAx3MF1QOW0Cnxm4fnaxhJ/sm0NdguHJzgE2Tfuwan1q
         DqfgGs94gQQ44KsKCnEEkTFCQZNm0wzfwTqECklaYublossa8bz+AT+OectbasxPQyG6
         Df0wOfcBMn2gVEiiRpa9WqqPWbOWh5RstwTnWeo4fqUeUN5sN1SQfSlpOr0P74mV4uqK
         lX9ZgF7eKLEFMqLebkRuO8+SWHnKa8RnEUs790nfJDCDPaoC55Z6fNjWISriOngY5BB9
         OkRswTdKqHZfFkh/hzRzs099fEAFEkuRmjzxMisYNJoO4CO1qL4ZFVxD4T6P1BjNHhlN
         /Qhg==
X-Forwarded-Encrypted: i=1; AKwUvBwTCq6ycS6HNE4mAcIEPTNHqitnzxLczDxGruRC/eZYWgRxkyY5v5TB3r5HbwqGBK43lytgTlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m/bvnHOE4cdEHgqjrynFMg6g2qBgnM8KMLE4vEBmYS9tQWRDFY
	Bqpy6tZz9Nlhl5G/rwMGroC7s0EJbLUE9+ik679+/F3MnB3/efxMZviznaSgniFCGU/lporcSZV
	h1TIwZw==
X-Received: from pgdg2.prod.google.com ([2002:a05:6a02:51c2:b0:cc5:1352:f0e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9090:b0:3d0:e034:a26f
 with SMTP id adf61e73a8af0-3dd5f5d8672mr12798993637.17.1789599838113; Wed, 16
 Sep 2026 16:03:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:02:23 +0000
In-Reply-To: <20260916230353.367014-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916230353.367014-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916230353.367014-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/6] ip6_gre: Unlink ip6gre_tunnel_unlink() from ->dellink().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the previous patch, itn->fb_tunnel_dev can be removed
via ->dellink().

However, ioctl(SIOCDELTUNNEL) still uses unregister_netdevice(),
which requires ip6gre_tunnel_unlink() in ip6gre_tunnel_uninit().

Let's use __ip6gre_dellink() everywhere to remove ip6gre (and
variant) devices and remove ip6gre_tunnel_unlink() and
ip6gre_tunnel_unlink_md() in ip6gre_tunnel_uninit().

ip6erspan_tunnel_uninit() is also changed accordingly.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_gre.c | 50 +++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d5d98474aeb5..a9059f3841ac 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -79,6 +79,7 @@ static void ip6gre_tunnel_setup(struct net_device *dev);
 static void ip6gre_tunnel_link(struct ip6gre_net *ign, struct ip6_tnl *t);
 static void ip6gre_tnl_link_config(struct ip6_tnl *t, int set_mtu);
 static void ip6erspan_tnl_link_config(struct ip6_tnl *t, int set_mtu);
+static void __ip6gre_dellink(struct net_device *dev, struct list_head *head);
 
 /* Tunnel hash table */
 
@@ -359,10 +360,7 @@ static struct ip6_tnl *ip6gre_tunnel_locate(struct net *net,
 static void ip6erspan_tunnel_uninit(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 
-	ip6erspan_tunnel_unlink_md(ign, t);
-	ip6gre_tunnel_unlink(ign, t);
 	dst_cache_reset(&t->dst_cache);
 	netdev_put(dev, &t->dev_tracker);
 }
@@ -370,10 +368,7 @@ static void ip6erspan_tunnel_uninit(struct net_device *dev)
 static void ip6gre_tunnel_uninit(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 
-	ip6gre_tunnel_unlink_md(ign, t);
-	ip6gre_tunnel_unlink(ign, t);
 	dst_cache_reset(&t->dst_cache);
 	netdev_put(dev, &t->dev_tracker);
 }
@@ -1251,14 +1246,15 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 					struct ifreq *ifr, void __user *data,
 					int cmd)
 {
-	int err = 0;
-	struct ip6_tnl_parm2 p;
-	struct __ip6_tnl_parm p1;
 	struct ip6_tnl *t = netdev_priv(dev);
+	struct __ip6_tnl_parm p1 = {};
+	LIST_HEAD(dev_kill_list);
 	struct net *net = t->net;
-	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
+	struct ip6_tnl_parm2 p;
+	struct ip6gre_net *ign;
+	int err = 0;
 
-	memset(&p1, 0, sizeof(p1));
+	ign = net_generic(net, ip6gre_net_id);
 
 	switch (cmd) {
 	case SIOCGETTUNNEL:
@@ -1347,7 +1343,8 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 				goto done;
 			dev = t->dev;
 		}
-		unregister_netdevice(dev);
+
+		__ip6gre_dellink(dev, &dev_kill_list);
 		err = 0;
 		break;
 
@@ -1356,6 +1353,7 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 	}
 
 done:
+	unregister_netdevice_many(&dev_kill_list);
 	return err;
 }
 
@@ -1563,7 +1561,7 @@ static void __net_exit ip6gre_exit_rtnl_net(struct net *net,
 			struct ip6_tnl *t;
 
 			hlist_for_each_entry_safe(t, tmp, head, hash_node)
-				unregister_netdevice_queue(t->dev, dev_kill_list);
+				__ip6gre_dellink(t->dev, dev_kill_list);
 		}
 	}
 }
@@ -2056,13 +2054,31 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
+static void __ip6gre_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct ip6_tnl *t = netdev_priv(dev);
+	struct ip6gre_net *ign;
+
+	ign = net_generic(t->net, ip6gre_net_id);
+
+	if (dev->rtnl_link_ops == &ip6erspan_tap_ops)
+		ip6erspan_tunnel_unlink_md(ign, t);
+	else
+		ip6gre_tunnel_unlink_md(ign, t);
+
+	ip6gre_tunnel_unlink(ign, t);
+	unregister_netdevice_queue(dev, head);
+}
+
 static void ip6gre_dellink(struct net_device *dev, struct list_head *head)
 {
-	struct net *net = dev_net(dev);
-	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
+	struct ip6_tnl *t = netdev_priv(dev);
+	struct ip6gre_net *ign;
+
+	ign = net_generic(t->net, ip6gre_net_id);
 
 	if (dev != ign->fb_tunnel_dev)
-		unregister_netdevice_queue(dev, head);
+		__ip6gre_dellink(dev, head);
 }
 
 static size_t ip6gre_get_size(const struct net_device *dev)
@@ -2304,6 +2320,7 @@ static struct rtnl_link_ops ip6gre_tap_ops __read_mostly = {
 	.validate	= ip6gre_tap_validate,
 	.newlink	= ip6gre_newlink,
 	.changelink	= ip6gre_changelink,
+	.dellink	= ip6gre_dellink,
 	.get_size	= ip6gre_get_size,
 	.fill_info	= ip6gre_fill_info,
 	.get_link_net	= ip6_tnl_get_link_net,
@@ -2318,6 +2335,7 @@ static struct rtnl_link_ops ip6erspan_tap_ops __read_mostly = {
 	.validate	= ip6erspan_tap_validate,
 	.newlink	= ip6erspan_newlink,
 	.changelink	= ip6erspan_changelink,
+	.dellink	= ip6gre_dellink,
 	.get_size	= ip6gre_get_size,
 	.fill_info	= ip6gre_fill_info,
 	.get_link_net	= ip6_tnl_get_link_net,
-- 
2.55.0.1082.g2b9226bbc0-goog

