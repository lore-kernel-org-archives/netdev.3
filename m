Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC652ED5D
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997472; cv=none; b=M3MSQrLJ+NJkrtk2pfm0djzbWiSCI1YIvqvRO0TCtXXyplz3MW7Za0MaKb3RnKdSSW4xUY6NPPkOI1w80bLlWdOTX8RSv4aKGoyVxwtgeyBH7XMMsBOC22tQ4EbeUm5EeIWgNG3IwzqVlKBtNqF5StdXh/TFP/ECWPli7UsAPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997472; c=relaxed/simple;
	bh=cp43fHmgHlbMCEgPJIQWQoxL5TDExDyjispxCD8X4i4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tGWjXSG7RreWuJ1E27ILPkK0zVsInrkjCqQ7N6JuwrQMoNgaLLqPzNCkXkFWMazbGwfeUOrB60pyDsyGAijJYftUByHEkVgPUFJKHV1TduD/AN2xZ8vQTdF4F1vV8aJ8V3JOY/KPqIsOBQV6bK2a38hRHwb5+QiYh5mpF2SCeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6y64Yjc; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6y64Yjc"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so8362792a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788997470; x=1789602270; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPeHoAp96qVJQtBdKQRtObanZSycV+yeuM3H6wqItRA=;
        b=D6y64Yjcub6DBu10w4lHuib8kEjpgxHFZ4NwdJ9bDbc1K7CJGFNQYMQGMWJJA4kqfM
         Qx3t5jriuAYStf02CqmGC+oiBh1qoFLNwPPISkEh91JhXZszbO0fPiP4f9QopLA/kDYh
         LjmSheMXDAcHiMls6G9Gc1uxmjWwSAJXI8o8smI50v4pLX3YwvySbfQEqiIya75gCXQu
         WsOC6lx6G0fK/EPFOm3m4FsWbkrcNJuGwQTR8ZD+B5N5iefB46EizYdaBdKX0xF4SqBB
         ICXCTD/ps5AbH3t476OdOJZPHBjgu8Q03nQJCaLICFcJxoP32AqQlISsHi11unjEyJ3l
         5juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997470; x=1789602270;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPeHoAp96qVJQtBdKQRtObanZSycV+yeuM3H6wqItRA=;
        b=YJhF6/6s4KWm1McjmcGMwNr9uKuRzYczHzLhhG51t18dTasOEGshvWkpgd6Vs9ZyiB
         FV3vlKq5AJuBMgtoUI4nLgMxW/E6G6Clnsz/gZZNbbUYogn6Pr4Ajda413WEdvq2n/H/
         pPAJMSkrF6ooKUuy9rDEnVZVOF+3iM3JS1aLKkKH6LF/lgwAyU5PcIUSHVUKmFOy+uZF
         Uh1hDoeJpfw8hHkkO+rKUlaPJcQk6p0T5gkLbB1ozdZxgaDrseydrc6h00LEzZHkNGWe
         YaOX3Ux77v1RL94HNYWXHu/lFRiroEMbHuZYj/ZGt2ElhxGKoQJShOuxI5ZaSs5gKoNc
         G28g==
X-Forwarded-Encrypted: i=1; AKwUvByLf1wKvEe9KLzP5Cnh+SlRXT4IP/YmXLk/48WqNy1QjzDBTai6tGm/YQshBWpAqCgAkYpzFhQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nYPlFkBiF6P8rmY76gJaluTQ0n2lv8KG002Q1UBOAMqGceGwKY
	kLye0Fkc6O398E5NkJvs34+EDAjyMm4XDyAPuvv2Hl33tR/ei0Xob77uUGOLkp0YMykyPKAVxN6
	qO8HU8w==
X-Received: from pgbm9-n2.prod.google.com ([2002:a05:6a02:6189:20b0:cc1:a31f:2d16])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a109:b0:3d3:aec2:4dcb
 with SMTP id adf61e73a8af0-3dacbf2a0f9mr5877115637.23.1788997470121; Wed, 09
 Sep 2026 16:44:30 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:43:48 +0000
In-Reply-To: <20260909234422.2416506-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909234422.2416506-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909234422.2416506-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 5/7] ip_tunnel: Unify error paths in
 ip_tunnel_newlink() and ip_tunnel_changelink().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch will introduce per-netns mutex and acquire it
in ip_tunnel_newlink() and ip_tunnel_changelink().

To make the diff cleaner, let's unify the error paths.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ip_tunnel.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 5833f93c1964..3ba03c2b3b90 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1181,21 +1181,23 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
 		      __u32 fwmark)
 {
-	struct ip_tunnel *nt;
 	struct ip_tunnel_net *itn;
+	struct ip_tunnel *nt;
+	int err = 0;
 	int mtu;
-	int err;
 
 	nt = netdev_priv(dev);
 	itn = net_generic(net, nt->ip_tnl_net_id);
 
 	if (nt->collect_md) {
 		if (rtnl_dereference(itn->collect_md_tun))
-			return -EEXIST;
+			err = -EEXIST;
 	} else {
 		if (ip_tunnel_find(itn, p, dev->type))
-			return -EEXIST;
+			err = -EEXIST;
 	}
+	if (err)
+		goto out;
 
 	nt->net = net;
 	nt->parms = *p;
@@ -1222,22 +1224,26 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 		goto err_dev_set_mtu;
 
 	ip_tunnel_add(itn, nt);
-	return 0;
+out:
+	return err;
 
 err_dev_set_mtu:
 	unregister_netdevice(dev);
 err_register_netdevice:
-	return err;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_newlink);
 
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 			 struct ip_tunnel_parm_kern *p, __u32 fwmark)
 {
-	struct ip_tunnel *t;
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct net *net = tunnel->net;
-	struct ip_tunnel_net *itn = net_generic(net, tunnel->ip_tnl_net_id);
+	struct ip_tunnel_net *itn;
+	struct ip_tunnel *t;
+	int err = 0;
+
+	itn = net_generic(net, tunnel->ip_tnl_net_id);
 
 	if (dev == itn->fb_tunnel_dev)
 		return -EINVAL;
@@ -1245,8 +1251,10 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 	t = ip_tunnel_find(itn, p, dev->type);
 
 	if (t) {
-		if (t->dev != dev)
-			return -EEXIST;
+		if (t->dev != dev) {
+			err = -EEXIST;
+			goto out;
+		}
 	} else {
 		t = tunnel;
 
@@ -1259,13 +1267,16 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 				nflags = IFF_POINTOPOINT;
 
 			if ((dev->flags ^ nflags) &
-			    (IFF_POINTOPOINT | IFF_BROADCAST))
-				return -EINVAL;
+			    (IFF_POINTOPOINT | IFF_BROADCAST)) {
+				err = -EINVAL;
+				goto out;
+			}
 		}
 	}
 
 	ip_tunnel_update(itn, t, dev, p, !tb[IFLA_MTU], fwmark);
-	return 0;
+out:
+	return err;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_changelink);
 
-- 
2.55.0.1003.g10538fe699-goog

