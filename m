Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB43B19BA
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821941; cv=none; b=dCexvTL2mSJkp2Ipiwl9mfwYuTTZX/YJcibgTrfpKM8O/r6svjkiuYDSspokExZwXEEFJKwU4cCwXHxCtyj4MKj4PW+fqR1HQ9ouJV4VyKD2Th2oQw9yKYYgOV1vC+9dbkhuwg1J+Y//gsqWPhzMTS/vceVlimVJqy6WvCVBDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821941; c=relaxed/simple;
	bh=Bcl9VVwJmtGqwfQwdOx9rGzXDg6ruShYvRk8wkfj0hA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rqqHAmU/VtJX9eHLz9z+tLN5mvH8NQBVvx6h15c6E6kv4kAXGQqRQrlFy1vjrtD7sLhYZvNrtZKMWAOybsJToDBRgK1L1MtzwjK/LnmAQtAyqxUzNwF9fbGc1IvC7ur6wkPn8/VEZ2wfkR5wVw9OulAoWKFjLsnKynXN/u3mYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RuEvvu7L; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuEvvu7L"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so8228030a91.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788821940; x=1789426740; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWpDJoyTTPmffT0gO/clYV5NPcmKghn2JTPNOEL9fX4=;
        b=RuEvvu7LITMhYcRsk6t7m4pOwZYG8claNVba/AiGpoNVSB38oAT5pQg/8jLRJWrXwL
         gqfRYJPtJWpixzi3Pr7W6BTIuqNRc/QNtGzu7ELWjzXK6E2gBl001XwLq6ptcRp96zD7
         VilAEVTkE9rS/GCO85RpAwJDSWsDF8zIMlDyYPNkJ6/28ntokUO3yUR1m3tsUdm7qAwW
         cozg0TPa6dbf0Ne5vLKg9dyoONjdcjcWfIjxysLXzWKEpPFd/l+4tSOsgNuTnN4SrSEN
         Fhd3bqi4TKBjJ2ie4XJ0ctL0oBM0CiClsXDkltgUo8Lm+E7bqd/wO7hMKWXLbjjX6iBC
         /wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821940; x=1789426740;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWpDJoyTTPmffT0gO/clYV5NPcmKghn2JTPNOEL9fX4=;
        b=a1fMoPt+uQt5CyrTeWMBpOSscWHZqM5bxRylVuQEevm2sKXhjwX7iXI0/g4dxwI9GU
         wfqMzhFHh2KSfvKDoASPeN6ZualIJTrJozsnSwbq9d5i2Gg7LMh3/v2FOqeAYtxU6Dtx
         OKmCryvNrl51f0lvcLlHJpDsMt2fbwbg6oTHzvN/BERuWZRfxSOC++qSTQK8QGF+oFm3
         K+kkT0q9b5UVkoBW9YtKaEQ2FPSVBKkY5s/tnLbQYvAfxqOiGCad1R05e/DLnIwgjUc0
         A1oxAPydTvlVVvFSBRIfq7Bib0ineIKYGzLkFVEJUVcksgwOH41wCVbuTdCsd+8TorZy
         Xuzw==
X-Forwarded-Encrypted: i=1; AKwUvBxCmDed51KYyC4z3Ac6GhEzTgzU8q1MgS6kWP9bjdaDd4Gnd0ShQeBpGp9+0zEOdZ1WWoHFejk=@vger.kernel.org
X-Gm-Message-State: AFuF++m8lTPZ7wAY0a6Xsj26fxChb/g+feBgtPm6kvIfeLuUMv5SdPeV
	9CNFR4G+txtpwmCWmitLVVGpozWkTSAm9bX9kXxZFRGiDsjYpoTnsYWlgvZlTCaYatpxNPSgQ1G
	DZ3zg6A==
X-Received: from pjbfr8.prod.google.com ([2002:a17:90a:e2c8:b0:38f:f04:c1e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8e:b0:398:bbe9:73af
 with SMTP id 98e67ed59e1d1-39b26107ab5mr37526342a91.7.1788821939465; Mon, 07
 Sep 2026 15:58:59 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:56:52 +0000
In-Reply-To: <20260907225846.3787676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907225846.3787676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907225846.3787676-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 7/7] ip_tunnel: Support per-netns device unregistration.
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
 net/ipv4/ip_tunnel.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9ad63f1af37a..051d7fd68902 100644
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
@@ -979,7 +986,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 			}
 		}
 
-		if (t) {
+		if (t && !ip_tunnel_unregistering(t)) {
 			err = 0;
 			ip_tunnel_update(itn, t, dev, p, true, 0);
 		} else {
@@ -1003,7 +1010,9 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 			dev = t->dev;
 		}
 
-		__ip_tunnel_dellink(dev, &dev_kill_list);
+		if (!ip_tunnel_unregistering(t))
+			__ip_tunnel_dellink(orig_net, dev, &dev_kill_list);
+
 		err = 0;
 		break;
 
@@ -1111,7 +1120,8 @@ void ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
 
 	if (itn->fb_tunnel_dev != dev) {
 		mutex_lock(&itn->tunnels_lock);
-		__ip_tunnel_dellink(dev, head);
+		if (!ip_tunnel_unregistering(tunnel))
+			__ip_tunnel_dellink(dev_net(dev), dev, head);
 		mutex_unlock(&itn->tunnels_lock);
 	}
 }
@@ -1194,7 +1204,7 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			__ip_tunnel_dellink(t->dev, head);
+			__ip_tunnel_dellink(net, t->dev, head);
 	}
 
 	mutex_unlock(&itn->tunnels_lock);
@@ -1304,6 +1314,11 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
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

