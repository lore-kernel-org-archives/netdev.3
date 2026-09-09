Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8FF52ED3A
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997474; cv=none; b=LloO1eHFR/IkkMkZFu6OT8SjwkMdK6Ad7W+fmE0NEfBfFGGNWbhSRnlc22YEEyCg7agu7VlgPBjmdXBWU/YUGpH9M65F+o3bvJCQhnKVm8C8yJK5bYmcccsvnwxYlMhqXz94Ced/YljKlmEch2NXUtAGnxnLRgnSI21RjR7r5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997474; c=relaxed/simple;
	bh=3CeC7KeGUYFKdiU6OPh4jsRRVdVM0RUNgHri/YP9S1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KEEpYNdGwu4ss/O394f5JudXRtXnmN6kYYV6QToLgyg5IpWNtZjNs276qssEOR4MGWccI/KlgkxEZ+9FLrPBAodyQFKzBoiU9vVE+jRuRXfCip9dBTXLS+aN10/ZV5GERSIW30zHKfOxQs/qFqrC41j1aICbVflNrmY6d4X0wis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlMSHMND; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlMSHMND"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc39363cc88so6711047a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788997472; x=1789602272; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkI+h5zU6wiffLqaNf2icG+4uwW7ZM+vGh7mFfFb9tw=;
        b=UlMSHMND5Iho23pc01Bj6heVlNwkLQvOZSBw3dkp5kxUdHYLz5yz6SRlcgmP6f/gdY
         9/b3NDfpkLqNJCHgwDH32aFTKGnn1Pzg83neSvstkt8a4UtTGBt6vzzpaQeaUl8+YOLo
         Ekk8JIxpzQExztxoXvohS+Jk0C/CTuFiEioCp2W5LlgGF79hMMz+CpASBVtsqVcu6d8i
         OtpytfPH3KjbaVJMx/HjHU+sa0RyTIKEOeFeggwhPCg4RVT1j50colxHaI0tEsmCIOAu
         EWhTrjHbPPt/PUw8Vx9QZ8804+jJWpXR5tTTfJ6GlEdAOqrR1m5AD7sroAY0nKqG1DMV
         L7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997472; x=1789602272;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hkI+h5zU6wiffLqaNf2icG+4uwW7ZM+vGh7mFfFb9tw=;
        b=SixfJFDPDLhHgUn9qzn8cS7fwODUj7sLJOsul9MFDdsAwa1JtIVaMDh98ibU7v/dNp
         7ji6K3/9RPbQEu2v29rjFVtKTMAz39dz96goPXcDxiPTMtxErYjB5Wz8HCjo1N7WOh4I
         upL0gCZFerguLTmd8s/7c/Ve5RK30yNBKSzeOQnGKbeHxqidPKiuwCAFYgcWAPnuhaaL
         pNMicHjbf84C9ehEv7Pg575tdO1YB1EgHAFf9H6a7MLfS8W6to6o2/P6LxXCXQ95copK
         uCHVloE5Sl6jbrQiY/LpJ7jGFCLXlsn19w51Dq+Fq87kXwA6qUJSDASK0C1aLKywbmf7
         e42Q==
X-Forwarded-Encrypted: i=1; AKwUvBzhNd6HsnifxJjjvs9R8lMk2TeOMOqyDFuKrPLiT3F+UG62XzqTlDTUgfADQ1N0GU2UOG5152Y=@vger.kernel.org
X-Gm-Message-State: AFuF++l+0pAFzMAnAZFjiXf24LFyX6DiaCZfFM2LYnqYLeMGerHiaVxC
	9WUNPlqd1T+NE/vo4uBRw5U51L5g63XcqVG1s0Se3FcgdHuRz4Pv+YILcWwPY6gOyYTIhNlhz5S
	MxSvfMQ==
X-Received: from pfbdk20.prod.google.com ([2002:a05:6a00:4894:b0:868:9a45:dae8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a38d:b0:3d3:adbf:777d
 with SMTP id adf61e73a8af0-3da3a14ecbbmr61692844637.25.1788997471816; Wed, 09
 Sep 2026 16:44:31 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:43:50 +0000
In-Reply-To: <20260909234422.2416506-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909234422.2416506-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909234422.2416506-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 7/7] ip_tunnel: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip_tunnel_delete_net() iterates ip_tunnel devices whose link_net
is dying and queues them for destruction.

The devices may reside in different netns.

Let's use unregister_netdevice_queue_net() to support per-netns
device unregistration.

Even after ip_tunnel_delete_net() queues a cross-netns ip_tunnel
device, ip_tunnel_changelink(), ip_tunnel_dellink(), and
ip_tunnel_ctl() could be called concurrently for it (once RTNL is
removed).  In such a case, __rtnl_net_unlock() will perform the
unregistration.

Also, ip_tunnel_ctl() needs to check if itn->fb_tunnel_dev is
NULL, otherwise it could create a new dev in dying netns after
ip_tunnel_delete_net().

In the example below, we can see the fallback tunnel device (gre0)
and the cross-netns device (gre1) are unregistered by different
processes:

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:ip_tunnel_uninit {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }
  kprobe:ipgre_exit_rtnl {
      printf("PID: %d%s\n", pid, kstack());
  }' &

  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add name gre1 link-netns ns2 \
    type gre local 192.168.0.1 remote 192.168.1.1
  # ip netns del ns2

  PID: 12
          ipgre_exit_rtnl+5
          ops_undo_list+702
          cleanup_net+1122
          process_scheduled_works+2538
  ...
  PID: 12 | DEV: gre0  <------ fallback device (itn->fb_tunnel_dev).
          ip_tunnel_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          __rtnl_net_unlock+37
          ops_undo_list+754
          cleanup_net+1122
          process_scheduled_works+2538
  ...
  PID: 10 | DEV: gre1
          ip_tunnel_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Check if (!itn->fb_tunnel_dev) in ip_tunnel_ctl().
---
 net/ipv4/ip_tunnel.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9ad63f1af37a..b07cc453e28b 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -205,6 +205,11 @@ static void ip_tunnel_del(struct ip_tunnel_net *itn, struct ip_tunnel *t)
 	hlist_del_init_rcu(&t->hash_node);
 }
 
+static bool ip_tunnel_unregistering(struct ip_tunnel *t)
+{
+	return hlist_unhashed(&t->hash_node);
+}
+
 static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 					struct ip_tunnel_parm_kern *parms,
 					int type)
@@ -895,20 +900,22 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 	netdev_state_change(dev);
 }
 
-static void __ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
+static void __ip_tunnel_dellink(struct net *net, struct net_device *dev,
+				struct list_head *head)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct ip_tunnel_net *itn;
 
 	itn = net_generic(tunnel->net, tunnel->ip_tnl_net_id);
 	ip_tunnel_del(itn, tunnel);
-	unregister_netdevice_queue(dev, head);
+	unregister_netdevice_queue_net(net, dev, head);
 }
 
 int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 		  int cmd)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct net *orig_net = dev_net(dev);
 	struct ip_tunnel_net *itn;
 	LIST_HEAD(dev_kill_list);
 	struct net *net = t->net;
@@ -920,6 +927,11 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 
 	mutex_lock(&itn->tunnels_lock);
 
+	if (!itn->fb_tunnel_dev) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	switch (cmd) {
 	case SIOCGETTUNNEL:
 		if (dev == itn->fb_tunnel_dev) {
@@ -979,7 +991,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 			}
 		}
 
-		if (t) {
+		if (t && !ip_tunnel_unregistering(t)) {
 			err = 0;
 			ip_tunnel_update(itn, t, dev, p, true, 0);
 		} else {
@@ -1003,7 +1015,9 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 			dev = t->dev;
 		}
 
-		__ip_tunnel_dellink(dev, &dev_kill_list);
+		if (!ip_tunnel_unregistering(t))
+			__ip_tunnel_dellink(orig_net, dev, &dev_kill_list);
+
 		err = 0;
 		break;
 
@@ -1111,7 +1125,8 @@ void ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
 
 	if (itn->fb_tunnel_dev != dev) {
 		mutex_lock(&itn->tunnels_lock);
-		__ip_tunnel_dellink(dev, head);
+		if (!ip_tunnel_unregistering(tunnel))
+			__ip_tunnel_dellink(dev_net(dev), dev, head);
 		mutex_unlock(&itn->tunnels_lock);
 	}
 }
@@ -1194,7 +1209,7 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			__ip_tunnel_dellink(t->dev, head);
+			__ip_tunnel_dellink(net, t->dev, head);
 	}
 
 	mutex_unlock(&itn->tunnels_lock);
@@ -1304,6 +1319,11 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 	}
 
+	if (ip_tunnel_unregistering(t)) {
+		err = -ENODEV;
+		goto out;
+	}
+
 	ip_tunnel_update(itn, t, dev, p, !tb[IFLA_MTU], fwmark);
 out:
 	mutex_unlock(&itn->tunnels_lock);
-- 
2.55.0.1003.g10538fe699-goog

