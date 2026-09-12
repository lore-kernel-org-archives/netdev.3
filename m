Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B143B27FB
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254051; cv=none; b=qB4eiN0+MDtFyFk0kgX1UpWm7gaU6aPfF72+A+AEwV8gg++GgezlnBPV3D1n8xklQaJvst0iVUNnrtUqGU5RXp0EEtYXuu8YtoP9deEQehgibmqwObrdkw9z79bGNJtPNPUDWgo9nlrt0B6BWjW4mTwfAsCU/UWHqRFHQpUSPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254051; c=relaxed/simple;
	bh=8FKedSgi7kwp3VVS2I9jPh+SA6XWPBA7KxLxMKyYytY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dAKwc9QyA6NlAgJKCy7E2vACPQCmU+QM3JGiY74Cchb69RfvR5AgIQd/rvg+yvdh4yATsQltZUH04Z4/i4YbuMobxeBOjjlrELlcMHamUBxkxDFDGTKGQaOpeK4GXjVcqEIv+B0M4tt/KQj/PfOlsypZ4J6zV4QsPTchFsRs3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZ1ZWkDT; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZ1ZWkDT"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4c1fc9ceaso1764372a12.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789254049; x=1789858849; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9cDgoTuHI7tdleBfI+VK6AuOs796aB0wnF1uGaCOJ4=;
        b=rZ1ZWkDTT9yhMqv77f6GNEr3KBGiX6uZBMa7MSGHXYHzwMDip7FcaZH3sxIRYC+ync
         e+qTrUymwagHpA1YBszpj+uU5Rkgq3sRlzQCc92zwIh6zV7Ta1lWG8QITJT05Ch5UxD/
         xfDVozdcEkbMk2lP83xAhUDy6elLP6EFH6WJ5qNlx+MFNH3BvbEYf82NpmQYt/0azA+F
         Oi2fy0BkAKQQtjK+5qO1XljW8aTt47D5z3aGh9sS4QZjUKjybMrekDcimGUv+O2kZaCd
         Ub5vvkwDdgra5Ain0Qyrr019Mj9SAhYFiz2bFZ8PH0K7IqlONI4Pt06xcqppvadspnEM
         Qb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254049; x=1789858849;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9cDgoTuHI7tdleBfI+VK6AuOs796aB0wnF1uGaCOJ4=;
        b=XIBj9TW5Jrwq22DnIH7mX6Tggigp5BFaRCChGHPFrBMzee9nfXbraR5S91KGy6kMOe
         CzyCUBMo6OCj4bU3yzwjXm3CtRefFdszrqnUjOegbFldP1wZ/oc7KwLneRBd0Yq2lWfm
         H/8epqbCYrlh+6lEQHQwUoHfeQ21OP9z5VWSCKLfjb1OB4yHZf0G3mngO8FKcvRzQalt
         R9PSci/Eohi5m4qgis39nJiORaBw12dhKzO0GbCD8qlOdOvpCLVpzn5KlR8iL6JXmyZe
         FlsRgdxsFg6wou7J+5jR1AjCqsjjy6RWTJVHVBkXLTfImC1J4YuPHRPNapV3dmtB3YlB
         STaA==
X-Forwarded-Encrypted: i=1; AKwUvBzX24IJpFjfmGGV5tJ55vJLMlEcC3Xs6BiKUp5V6txHLBJNECSnGFxnInF+TyUfNJZQnoLLHDo=@vger.kernel.org
X-Gm-Message-State: AFuF++lSOBcBb6fXMKvFVOqCSxjF0v77W2wDtJt1FPKb+HewDQuBXMXf
	zLWYHh1VJrdSfc8ajhC+qq6ibTQJnl3Wz0JL4Bd+7SjWGn9QovL1biXdICsS8Gkt+PDnz5QIsv/
	yQFI8VA==
X-Received: from pjbck14.prod.google.com ([2002:a17:90a:fe0e:b0:39d:bebd:df7d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53d0:b0:398:9bd1:3216
 with SMTP id 98e67ed59e1d1-39d9c3597b5mr16669591a91.23.1789254048904; Sat, 12
 Sep 2026 16:00:48 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:00:30 +0000
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912230043.2586313-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912230043.2586313-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 4/7] ip_tunnel: Centralise ip_tunnel_del() to ip_tunnel_dellink().
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
index e6bbc5e4c357..7d7baaa57741 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -895,10 +895,13 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
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
@@ -982,7 +985,8 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 				goto done;
 			dev = t->dev;
 		}
-		unregister_netdevice(dev);
+
+		ip_tunnel_dellink(dev, &dev_kill_list);
 		err = 0;
 		break;
 
@@ -991,6 +995,8 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 	}
 
 done:
+	unregister_netdevice_many(&dev_kill_list);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_ctl);
@@ -1164,7 +1170,7 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			unregister_netdevice_queue(t->dev, head);
+			ip_tunnel_dellink(t->dev, head);
 	}
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
@@ -1295,11 +1301,6 @@ EXPORT_SYMBOL_GPL(__ip_tunnel_init);
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
2.55.0.1007.g17ff1f9808-goog

