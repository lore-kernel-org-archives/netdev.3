Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA9440A24
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821940; cv=none; b=ohykOFRr1zJqQPHByW2ZV3wCkS5BHmNRF4LWF2SfFmqCjqbzNjLx0uZOnIAL5NEVvY05JRdFhCERcw2LbQDb2dj8qsVZnH7Lrb0lFKCuE0FuJMC0x3tevx6lgjz9PSsoZDLCTRzZwIZ1VcZYeyYOQrID55fCpTwGdT6oD/nheXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821940; c=relaxed/simple;
	bh=cp43fHmgHlbMCEgPJIQWQoxL5TDExDyjispxCD8X4i4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FTY1fVoOsXNGJiVDeez5mG+BrH9WCBVHp/OUIJPuOxj1zurbBCQ7kp6egmtBoWbbx4WP/HH72j9SKdo/h2ufnbs5R+a7uO5y10wzQPi8sfIQEnlzEqO09bFudE7GB5iV8bMVZlB4HmRDC9B7eriq5XOSE1WkkyqS0kvVG2zDC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSZrh6wV; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSZrh6wV"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso4754620a91.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788821938; x=1789426738; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPeHoAp96qVJQtBdKQRtObanZSycV+yeuM3H6wqItRA=;
        b=pSZrh6wVzA3gtOWnSospWhx1jo/TemPKC1nMB7Y5+/JmGWT5IXM1y6n5RIwSu454kj
         xJeZnFJeJlHWPMr10X8iabfUlSpUEcrzrozQc70S5GvNoJTftnjrgqwzYj46zzL3TToY
         oYG1Nzt3Sq7P7XENeOlG4ggH8VKdu30eAoaAWgqpUPIzY7HqcSWnX++FcWxsqb552mSw
         9FUPL3ifzSNHsWcF6vsPeHpZ+pdtpUdRk8TFPcP/19YyrGzuWYQI4UIvCCPyhwsUBua8
         t47VrBZ7CfkE+z3WQ9tRmmkXFSQ1QuTX+4g3sDh7ETAg9ET2GDDOJX86FCU8nvViRXKO
         o6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821938; x=1789426738;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPeHoAp96qVJQtBdKQRtObanZSycV+yeuM3H6wqItRA=;
        b=omc7u3zxHFA8hSVnjTiNGLYqesPpNoUwFfjb9A/flfOR6AC7IznLH5gpuXiFzBT9Bd
         hNSrjmRPna05e8Tw2QUTNA2uHx08EUgO7UhlfTWqCBJEcCl4I8XgvzHYemrHcmlnlbJ7
         j+6gG8sdp1qVF0Fulznmq/7YAIhXROjC8fU8yYvbBKp84bo/EWpWFclpHTB93o09w2/J
         SR2o95ISM2+lAgx9X/sJqLfob4tV60DSkFPR6osU8O9WpL/jyVWc2YeEml6TJyIJSNl6
         T6UmTM/wGfX3Vu7MfASQ44XV8By2VJANFVlmiTIiTmPjcaOlr8lR0mIh3rRDG6GRK7ZI
         7qOg==
X-Forwarded-Encrypted: i=1; AKwUvBxWDram/3q7LPGwjmcIVBJLsNJ+xeDt2C0F36mGwBgbMZeRY0PAgk2H7IOLGuCijfDcb7+MVjw=@vger.kernel.org
X-Gm-Message-State: AFuF++lG2IQfmNydKUxCHBfAQvdJoyPHF15TMPhRo83iRMRfYj/ITgRQ
	C+hnRBXnm/x11SybE6MMAa0dNM5mOsLTkq/2x1+HBzv+yGzTtM9jKw0/4Qb48pnr+YpzKSuYcJK
	YzXRdSQ==
X-Received: from pjbgg16.prod.google.com ([2002:a17:90b:a10:b0:39b:8e8b:e1f3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc5:b0:37f:e1b6:4c7d
 with SMTP id 98e67ed59e1d1-39b26190c25mr38002011a91.6.1788821937878; Mon, 07
 Sep 2026 15:58:57 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:56:50 +0000
In-Reply-To: <20260907225846.3787676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907225846.3787676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907225846.3787676-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/7] ip_tunnel: Unify error paths in
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

