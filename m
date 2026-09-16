Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE14D9F75
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599849; cv=none; b=RvNzwofIkbedKhQ3bk3g74g41VNLePDUzYik7G4u75b4aj9+kVgnV03Q2mr/1XVCDyMX1FpzPd/9E+gdRcVzsMSThXR4pLw/1NEf8isxo3NLvZOLlu320xDc4YqES1BNokHru7n9XGTEL8tr/zbzD9QGNnHbNpxv5r5BlLoSf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599849; c=relaxed/simple;
	bh=Oig8UlB3/2zfZZ6V/jlAyKANMkBLVog4Q2LaTddeQR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nn7Bud4+X3fWsFVrmoJzBuPS4jXhqlF7U7MH3kSyio9d5aZZxIot2Mim6SFW5joEp7B4QuBG0qCVhMXlMm9dF5NWu8PYCkLG4jxDzbiNvbfhAYvpnSe3MTRPo89B6/hL93oHbRPD98sWXrLbHCPMfiz+iHZnJWX1MyuX12upJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTsituUX; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTsituUX"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db87f759c5so4591215ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789599840; x=1790204640; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bm3wF7ZAYbBbzaoQhfj7Q5LoYHQwH5jdopTcAvXagiY=;
        b=mTsituUXoD9CUb7OBvdFIS544dnsBQMs5am+mb0PmM4xLn25ra2axBgRNq5DtSPQ8J
         QCpA2ZWrW+2xzair9Sp63wsiDwyf+kbIS0M+L/0R6+9X/VfzdXRPjaKv1+6Iwy/JDye0
         hNoCPLA6kDUn32h16YrlPp1kBrKjJndHCZaWGEXmv2F8DnuSbX4AqbX9cGHIh8Hb+0uD
         DeJmNOtgyBxpbxWCZIESdoh/Yxkdrfwg+MW4Rn++co61h3dl809XLd6TtXXPGoN0Iqdo
         daISUNdUqFnJAGjkUjKWewTzTa4WzmGNP82KQVyx38nopEBG5HvDyMGSjcvO4Q+uNEvQ
         BVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789599840; x=1790204640;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bm3wF7ZAYbBbzaoQhfj7Q5LoYHQwH5jdopTcAvXagiY=;
        b=rCGjgGb3r+JgFMDUR9d18G9K5RGwzkfz93vsQdeKdk9OvKhIJh2z6VuT5ISlWUS/iy
         iG2Sfi5OIVcyvWX7/6f+dYKXbZJImvFGQKDT4oHovb0ZSMSKFOAKqy4KFcg7tFsK0dbL
         AQ91OEFvrZnjA/DBFuh8B101EQ9YgxMDaWWU0fNyzQc+IExLXDE5dVS4igmO9kM3takV
         GWNyfE36ihdztRe3d6mIwacVP/dK+FGINy9NYJjqUBY5ildEXVYJ7/FC8iBYVJgIcJJC
         1rlDsjrdc8jCjFZFA2Luc2BX3G459fOfFO+5Bamg36iexg54lyK5YalYc/2uwnm3rfTL
         5GuA==
X-Forwarded-Encrypted: i=1; AKwUvBwqVrRpPSmul/0qilCVqyRnI6ZiTAH9jeDEOYzW5mqTx9vTfAIFOkqtMPAkvw55dCn3MpwdHSw=@vger.kernel.org
X-Gm-Message-State: AFuF++lK3oLkD+HI8dhvzZH/TyMZix29dKcqPuFiJJcmILOiDEO1efPX
	+Ka1NKonyVuPq3IOFfSjHQU7HO6fGE9WY7/vP84sAVWE9XRgUUzKtgW+pUyWFM5QlrTmWvUA0mc
	kPJBvjA==
X-Received: from plhy17.prod.google.com ([2002:a17:902:d651:b0:2d3:83f2:7e3e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d490:b0:2dd:78d1:65c9
 with SMTP id d9443c01a7336-2dd8e76bcb5mr86416835ad.19.1789599839644; Wed, 16
 Sep 2026 16:03:59 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:02:25 +0000
In-Reply-To: <20260916230353.367014-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916230353.367014-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916230353.367014-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 6/6] ip6_gre: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip6gre_exit_rtnl_net() iterates ip6gre devices and variants whose
link_net is dying and queues them for destruction.

The devices may reside in different netns.

Let's use unregister_netdevice_queue_net() to support per-netns
device unregistration.

Even after ip6gre_exit_rtnl_net() queues a cross-netns ip6gre
device, ip6gre_changelink_common(), ip6gre_dellink(), and
ip6gre_tunnel_siocdevprivate() could be called concurrently for
it (once RTNL is removed).  In such a case, __rtnl_net_unlock()
will perform the unregistration.

Also, ip6gre_tunnel_siocdevprivate() needs to check check_net(t->net),
otherwise it could create a new dev in dying netns after
ip6gre_exit_rtnl_net().

In the example below, we can see the fallback tunnel device
(ip6gre0) and the cross-netns device (ip6gre1) are unregistered
by different processes:

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:ip6gre_tunnel_uninit {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }
  kprobe:ip6gre_exit_rtnl_net {
      printf("PID: %d%s\n", pid, kstack());
  }' &
  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add name ip6gre1 link-netns ns2 \
    type ip6gre local 2001:9292::1 remote 2001:9292::2
  # ip netns del ns2

  PID: 12
          ip6gre_exit_rtnl_net+5
          ops_undo_list+702
          cleanup_net+1122
  ...
  PID: 12 | DEV: ip6gre0  <------ fallback device (itn->fb_tunnel_dev).
          ip6gre_tunnel_uninit+5
          unregister_netdevice_many_notify+7137
          unregister_netdevice_many_net+1050
          __rtnl_net_unlock+37
          ops_undo_list+754
          cleanup_net+1122
  ...
  PID: 10 | DEV: ip6gre1
          ip6gre_tunnel_uninit+5
          unregister_netdevice_many_notify+7137
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_gre.c | 51 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index ac1087330465..c851af22b9fe 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -80,7 +80,8 @@ static void ip6gre_tunnel_setup(struct net_device *dev);
 static void ip6gre_tunnel_link(struct ip6gre_net *ign, struct ip6_tnl *t);
 static void ip6gre_tnl_link_config(struct ip6_tnl *t, int set_mtu);
 static void ip6erspan_tnl_link_config(struct ip6_tnl *t, int set_mtu);
-static void __ip6gre_dellink(struct net_device *dev, struct list_head *head);
+static void __ip6gre_dellink(struct net *net, struct net_device *dev,
+			     struct list_head *head);
 
 /* Tunnel hash table */
 
@@ -285,6 +286,11 @@ static void ip6gre_tunnel_unlink(struct ip6gre_net *ign, struct ip6_tnl *t)
 	hlist_del_init_rcu(&t->hash_node);
 }
 
+static bool ip6gre_tunnel_unregistering(struct ip6_tnl *t)
+{
+	return hlist_unhashed(&t->hash_node);
+}
+
 static struct ip6_tnl *ip6gre_tunnel_find(struct net *net,
 					   const struct __ip6_tnl_parm *parms,
 					   int type)
@@ -1248,6 +1254,7 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 					int cmd)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	struct net *orig_net = dev_net(dev);
 	struct __ip6_tnl_parm p1 = {};
 	LIST_HEAD(dev_kill_list);
 	struct net *net = t->net;
@@ -1261,6 +1268,11 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 
 	mutex_lock(&ign->tunnels_lock);
 
+	if (!check_net(net)) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	switch (cmd) {
 	case SIOCGETTUNNEL:
 		if (dev == ign->fb_tunnel_dev) {
@@ -1302,7 +1314,7 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 		t = ip6gre_tunnel_locate(net, &p1, cmd == SIOCADDTUNNEL);
 
 		if (dev != ign->fb_tunnel_dev && cmd == SIOCCHGTUNNEL) {
-			if (t) {
+			if (t && !ip6gre_tunnel_unregistering(t)) {
 				if (t->dev != dev) {
 					err = -EEXIST;
 					break;
@@ -1310,23 +1322,26 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 			} else {
 				t = netdev_priv(dev);
 
-				ip6gre_tunnel_unlink(ign, t);
-				synchronize_net();
-				ip6gre_tnl_change(t, &p1, 1);
-				ip6gre_tunnel_link(ign, t);
-				netdev_state_change(dev);
+				if (!ip6gre_tunnel_unregistering(t)) {
+					ip6gre_tunnel_unlink(ign, t);
+					synchronize_net();
+					ip6gre_tnl_change(t, &p1, 1);
+					ip6gre_tunnel_link(ign, t);
+					netdev_state_change(dev);
+				}
 			}
 		}
 
-		if (t) {
+		if (t && !ip6gre_tunnel_unregistering(t)) {
 			err = 0;
 
 			memset(&p, 0, sizeof(p));
 			ip6gre_tnl_parm_to_user(&p, &t->parms);
 			if (copy_to_user(data, &p, sizeof(p)))
 				err = -EFAULT;
-		} else
+		} else {
 			err = (cmd == SIOCADDTUNNEL ? -ENOBUFS : -ENOENT);
+		}
 		break;
 
 	case SIOCDELTUNNEL:
@@ -1349,7 +1364,8 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 			dev = t->dev;
 		}
 
-		__ip6gre_dellink(dev, &dev_kill_list);
+		if (!ip6gre_tunnel_unregistering(t))
+			__ip6gre_dellink(orig_net, dev, &dev_kill_list);
 		err = 0;
 		break;
 
@@ -1570,7 +1586,7 @@ static void __net_exit ip6gre_exit_rtnl_net(struct net *net,
 			struct ip6_tnl *t;
 
 			hlist_for_each_entry_safe(t, tmp, head, hash_node)
-				__ip6gre_dellink(t->dev, dev_kill_list);
+				__ip6gre_dellink(net, t->dev, dev_kill_list);
 		}
 	}
 
@@ -2049,6 +2065,9 @@ ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
 		t = nt;
 	}
 
+	if (ip6gre_tunnel_unregistering(t))
+		return ERR_PTR(-ENODEV);
+
 	return t;
 }
 
@@ -2085,7 +2104,8 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	return err;
 }
 
-static void __ip6gre_dellink(struct net_device *dev, struct list_head *head)
+static void __ip6gre_dellink(struct net *net, struct net_device *dev,
+			     struct list_head *head)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct ip6gre_net *ign;
@@ -2098,7 +2118,7 @@ static void __ip6gre_dellink(struct net_device *dev, struct list_head *head)
 		ip6gre_tunnel_unlink_md(ign, t);
 
 	ip6gre_tunnel_unlink(ign, t);
-	unregister_netdevice_queue(dev, head);
+	unregister_netdevice_queue_net(net, dev, head);
 }
 
 static void ip6gre_dellink(struct net_device *dev, struct list_head *head)
@@ -2110,8 +2130,9 @@ static void ip6gre_dellink(struct net_device *dev, struct list_head *head)
 
 	mutex_lock(&ign->tunnels_lock);
 
-	if (dev != ign->fb_tunnel_dev)
-		__ip6gre_dellink(dev, head);
+	if (dev != ign->fb_tunnel_dev &&
+	    !ip6gre_tunnel_unregistering(t))
+		__ip6gre_dellink(dev_net(dev), dev, head);
 
 	mutex_unlock(&ign->tunnels_lock);
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

