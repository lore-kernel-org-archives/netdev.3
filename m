Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21237266D
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254053; cv=none; b=E/YjJKQRActukhCef/poq5ZpzBdv+CZDj9xUzPsWivQ11wYC8SgPzZ9fKfxLhEmlXS3feEXPk+jDjjfQ9hWITXIz0+4BjWdEXG+ke54QOaDGnKM3PnKYd8vzjPkmsWBL1iqdrBZ3Zfk8PR0GeYa3X2o6sRZBOq1yLfNfs0IkM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254053; c=relaxed/simple;
	bh=MBK+AAggVkqdDEULbJD0NQ4pmVPuj8I2vF/crb95Dsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ak7BctRMC/VPnsc1BPa6fNjLItx+cC6sOvurhc+mRguChxKebn9TIIx87VHcaqHQQA5ksYpjKN3EI9/CE4/sZ90gGbCw7vGa3mt3ymYEY7pgZ0AjR6Fz01k9zoz1FftEWJIWl9vWeIc3DZr7pneYfoZ9JmuZwPmHQd2QVSPS65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cf/5W/3E; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cf/5W/3E"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd188e16a2so24725995ad.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789254052; x=1789858852; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yuqdAGhjOzxrL4ZzMAF6n+eOcMdghu7gCR8WCgEyRaI=;
        b=Cf/5W/3EMgVNyTw6QoldbkSBzzM0mKLHUl+Jsq/9yqrBIqbIP0PBwEZRdvJ6YOKDE5
         dMigrsooXRUiPKY7w+dsVPkvfHNEXc0hCqjArail7WOzfhPXhTC5EfYY6xHu9UCJlBVk
         eKcPPBbcIaflyr52z2QEQa5u9g+qwa59EL1bzvxWxt9PY02N7OBH+NObyD/JrC3r+Jqy
         PNc7mt7dsFeN4hKP6/C/HX9XmD9IVwwDsrGClaRBkOElkR960CRxJF6nnTSoQ2BghIuO
         RHGc8SNFBAv4s4lWHgVBM7PQAUQbvweEfMZp4oFwRKUOCCUPVMFcO5D4NktWQ8eGketu
         LI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254052; x=1789858852;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yuqdAGhjOzxrL4ZzMAF6n+eOcMdghu7gCR8WCgEyRaI=;
        b=XHt69Di3HJ6kglIEfqJUetZgn9auIQvqTS48cY6Rdp/TJTTffEo8Yeg+fi92YPcXDp
         ItO99ub6Q6cz+zXe4F0iROA2oLF0rl6bvTyg+q16q3VLSL+QQ9BT3d9FGwtfWfmL61eT
         qbHv7Mg0Q31bfFFLE5gF/XNLFFt829/k1h818U91EIDmfGR1T4awjI572zbp5aukdHSG
         y6L6Mw+hQuggdioiOlZYq17y+QwRrFP6qgA5ROOSMUctK+uGBKVhdEOfY6SR9d/W+4tv
         FvzVWduqWvmkNXJBkTdE6rtIInT3sJqzBYUtqHvggG802eAwR+jW0BfhPU4LloqZjzIs
         tyHQ==
X-Forwarded-Encrypted: i=1; AKwUvByBL0kvNSlY+V31RL0EI481MCVJHvCEXOh7UpmDJ7zXaKutk+6EgZ2gkQMG8K6cVYQpLIrCr/s=@vger.kernel.org
X-Gm-Message-State: AFuF++mQUh0rEH3J9GMpzjSslYAYidEAZnzzuR2TfW7ndBwqkAUFFiDI
	GdqV0vNxsHeU4gPn1PJ61d0ErKeSFLnbTfZ0hV4NTTglBBT89+C1jkAIAI5VYOena2v7Jqh6uUm
	x+pdotw==
X-Received: from plbjv3.prod.google.com ([2002:a17:903:583:b0:2dd:4fa9:1917])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f651:b0:2dc:fcfc:bdeb
 with SMTP id d9443c01a7336-2dd4bdbe1b0mr84442865ad.22.1789254051420; Sat, 12
 Sep 2026 16:00:51 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:00:33 +0000
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912230043.2586313-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912230043.2586313-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 7/7] ip_tunnel: Support per-netns device unregistration.
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

Also, ip_tunnel_ctl() needs to check check_net(t->net), otherwise
it could create a new dev in dying netns after ip_tunnel_delete_net().

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
v3: Use check_net() in ip_tunnel_ctl().
v2: Check if (!itn->fb_tunnel_dev) in ip_tunnel_ctl().
---
 net/ipv4/ip_tunnel.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d44976395c7c..0875474a578a 100644
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
@@ -893,20 +898,22 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
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
@@ -918,6 +925,11 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 
 	mutex_lock(&itn->tunnels_lock);
 
+	if (!check_net(net)) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	switch (cmd) {
 	case SIOCGETTUNNEL:
 		if (dev == itn->fb_tunnel_dev) {
@@ -977,7 +989,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 			}
 		}
 
-		if (t) {
+		if (t && !ip_tunnel_unregistering(t)) {
 			err = 0;
 			ip_tunnel_update(itn, t, dev, p, true, 0);
 		} else {
@@ -1001,7 +1013,9 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 			dev = t->dev;
 		}
 
-		__ip_tunnel_dellink(dev, &dev_kill_list);
+		if (!ip_tunnel_unregistering(t))
+			__ip_tunnel_dellink(orig_net, dev, &dev_kill_list);
+
 		err = 0;
 		break;
 
@@ -1109,7 +1123,8 @@ void ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
 
 	if (itn->fb_tunnel_dev != dev) {
 		mutex_lock(&itn->tunnels_lock);
-		__ip_tunnel_dellink(dev, head);
+		if (!ip_tunnel_unregistering(tunnel))
+			__ip_tunnel_dellink(dev_net(dev), dev, head);
 		mutex_unlock(&itn->tunnels_lock);
 	}
 }
@@ -1192,7 +1207,7 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			__ip_tunnel_dellink(t->dev, head);
+			__ip_tunnel_dellink(net, t->dev, head);
 	}
 
 	mutex_unlock(&itn->tunnels_lock);
@@ -1302,6 +1317,11 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
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
2.55.0.1007.g17ff1f9808-goog

