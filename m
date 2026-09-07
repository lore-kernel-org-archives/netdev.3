Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14274457D3
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821939; cv=none; b=cap1kptnqEdOOMlWvd9oYy0/H3guPXFu0D/+Pwflwer3mE2Z/NI64E16oB2ODZC+IvMlxnPJvMpqpd6V4dwY4GOUjsSedxO4Oei7gkVH3rs8H7l/UN0aoshLHVd1ogLnmdjwzsOlmQxqMRzj5p752aC3Gqwbb4rjODzzwtYUdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821939; c=relaxed/simple;
	bh=ekb8cnXJN6IhVShuPmqPv5+DOjSyCuJ0BV8cevW4n38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QzwvcFWKgnr29oeGe+b4LY0dhm01ZYc0cmm+05Jnani/fz5fmv4cuwmpa3dzELCrbr7NLIWE1EzDwXslZAHMszsW+5ABdTC1W62IYHLTdyTPUpTqxRtHZcu3hYMKldC7xwgD/5fzyJtwu0ednazTIdiksFqlTQ75uqEh25IW7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e3axYgO9; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e3axYgO9"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfc52ddc55so56812555ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788821937; x=1789426737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIQMjAqTIwtT9S0LMA4qcau8Y2sq3v6Hjp+lwZWXkSg=;
        b=e3axYgO9m3uLAl5ow7YFGP7uuPyRUM59ZAmPiaPDkxz2bUMkD8itRXoJQA53ESYMkq
         VtyOFSHGAhgvGKwlHUiao7f5pPdp25B/aU0yHLD8+OFtgMRp+Bqy79ah7fWVqFlL0a20
         shZihPfn0t25DWT6/m7D6FK83BVJNRfHIDH3TLHy+6emJs8axC2H++9j9wcpBcOFmsyk
         Ggq+jGIrsAj5Zcq2czftAQCXvgiuGRI7j6dwif8OGGfJzzyQWdAv0IONSdLq818RXRuK
         xerrjc36Nr51RHV5PQymYAONaXvT+UM3jte7kdxx+aVa5mg/7jneKyd3wyt9LCPkiUTI
         jCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821937; x=1789426737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rIQMjAqTIwtT9S0LMA4qcau8Y2sq3v6Hjp+lwZWXkSg=;
        b=EYIUoGRvIU/O19bZOLZnfDivsVOU7MhEOp40Dg6AV2CsyZ0NHayLbvYCNAdxQQ64Zn
         n5cKRymutJ1EBE5CCJTDsYphdad9w9GBTU2Rk1bG2xdjcqb6n/Hxvfp9R0uVWM9bqlqK
         F8cklvIubUytLjCAvOexhib/ZpGNOHP64SZxDQ4edXAz4H5tH9UcbVfnweesPsBi6Fwq
         WroFA0yGvSX5GXfUgS6/zbIsCzNkscW+6Ru+k3X0rRHXKHp5dkgs4qvIvyT68qyZb6uZ
         KVnnfPXnhstv3cuO5QE1xZdtNiybbFsEQbm8tv451ja8zRraoBvxF6uryfA4UNnWdMcW
         96/A==
X-Forwarded-Encrypted: i=1; AKwUvBwe9yAf7Q26j73URQwtzXzaymO9Z9fC+Tr3v6LCCeADUZKebPxftO/graAeOAF/cv1AjRws14Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mi43HLxbfmxutpx9bxRam+CPwjF1dD1E910IcdclvxQCRvgmpa
	7k0XlW0mnAmznL634+LmAXgwyX/l5OPovhhDJW4heuYgWf+4eADmwQM7LXheB/S0HIeOsQIbzh+
	M4ATV3A==
X-Received: from pleb11.prod.google.com ([2002:a17:902:d40b:b0:2db:2f11:a00])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3804:b0:2cf:9347:f445
 with SMTP id d9443c01a7336-2db126d8a54mr412050525ad.10.1788821937088; Mon, 07
 Sep 2026 15:58:57 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:56:49 +0000
In-Reply-To: <20260907225846.3787676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907225846.3787676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907225846.3787676-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/7] ip_tunnel: Centralise ip_tunnel_del() to ip_tunnel_dellink().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the previous patch, itn->fb_tunnel_dev can be removed
via ->dellink().

However, ioctl(SIOCDELTUNNEL) still uses unregister_netdevice(),
which requires ip_tunnel_del() in ip_tunnel_uninit().

Let's use ip_tunnel_dellink() everywhere to remove ip_tunnel device
and remove ip_tunnel_del() in ip_tunnel_uninit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ip_tunnel.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 1696ba1f3ed9..5833f93c1964 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -897,10 +897,13 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 		  int cmd)
 {
-	int err = 0;
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct ip_tunnel_net *itn;
+	LIST_HEAD(dev_kill_list);
 	struct net *net = t->net;
-	struct ip_tunnel_net *itn = net_generic(net, t->ip_tnl_net_id);
+	int err = 0;
+
+	itn = net_generic(net, t->ip_tnl_net_id);
 
 	switch (cmd) {
 	case SIOCGETTUNNEL:
@@ -984,7 +987,8 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 				goto done;
 			dev = t->dev;
 		}
-		unregister_netdevice(dev);
+
+		ip_tunnel_dellink(dev, &dev_kill_list);
 		err = 0;
 		break;
 
@@ -993,6 +997,8 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 	}
 
 done:
+	unregister_netdevice_many(&dev_kill_list);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_ctl);
@@ -1166,7 +1172,7 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			unregister_netdevice_queue(t->dev, head);
+			ip_tunnel_dellink(t->dev, head);
 	}
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
@@ -1297,11 +1303,6 @@ EXPORT_SYMBOL_GPL(__ip_tunnel_init);
 void ip_tunnel_uninit(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	struct net *net = tunnel->net;
-	struct ip_tunnel_net *itn;
-
-	itn = net_generic(net, tunnel->ip_tnl_net_id);
-	ip_tunnel_del(itn, netdev_priv(dev));
 
 	dst_cache_reset(&tunnel->dst_cache);
 }
-- 
2.55.0.1003.g10538fe699-goog

