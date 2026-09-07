Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55643BDB9
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821937; cv=none; b=chUdPHLEmcor0I6FaH+S/zTYE16hSxwTPsQ03a3n/c4WVRmBmTn51FMQiN5vHnarfWDbe2dW0L6CKNUM8nkd+io0BmdIFfcb7llvriJLmLev50POWOSwjDKgxG1CQpE0U5NBZRb+2Bo3nx5v5Hy0UWP/ebq4+T49ml7MObVUoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821937; c=relaxed/simple;
	bh=6rZoiXV5GkYLnfVyF4OoL8LqNc3AW6ZIWJWHMrb4WZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LI5bHUANGBddyOI0yOzbtbhP5U6enobyo2bgDfBWjhQu6AVcRTDQ3Sof/TyvL4Kke9DFZRo1hn7Jj8uZRnqgCe9u1rEMoPCsfZ4j+C10fOPAkzTv2TlrXPkzRFh82lfJlAvW52rA1O9LhL4ug0WKObfHxI5nhpMLVDKgssLApvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFBat17u; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFBat17u"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6fb956002so55204425ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788821935; x=1789426735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7FE+ctvFxs6x9jU2YrVB39dn28KtIk7w7wKgkkAtC4=;
        b=dFBat17uT0D+Chkp/7Ni2jfJMxv9L8wWB02908VUn20RQiPfnHleG065zeNXuWWt65
         U1f/zCrsClW1C0YcG1D1D1nV3dee8vXBKTooEH3ZzZW7YaUSXkW6PoL/RPw5+7bRUyon
         8ewgLhnxvjUG6DWHhtJ30jhk4/6RciCg83vNkt5/kB+ye5o8kTPVGYaO/QAMdweNAaed
         jidodCAeGY6cbsMU/HsfIVBaJ6GvBRgzrfF4IMq0xrFjrrNPMqOpLLEkNIXmlb4GJl/3
         wy8tOuNWcttvW4HmyPHyNqFMa9zlTqTwDuKwc0n8jg5rbvdJagQF5bY2TQpW8nMR6iLH
         7hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821935; x=1789426735;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7FE+ctvFxs6x9jU2YrVB39dn28KtIk7w7wKgkkAtC4=;
        b=T4CLvpykvaVgUSFJ0VdUZ9S1Trk9gg7Hj/UE083SmH0T0oyeOPskhQ0m4uSs7i8n8f
         rETGKYN+VEZvZ/AE/tPKuGbgThBBdeqvta+ypxpYSv0uHUcO2r79zrge3Ssm70iJ/QJt
         dTXOudQvHN2X1qAEqXW1rTtHTMQ4iOYVz0VhNloVKyEh5tscpYUcZaq5YqDjn2/xdgFO
         v4P2qvbC0LeE1ucinMA6TzHjibA3gwHCl3oxtsopahaRu7//Eq7AToSZiyTgoDS9AdXL
         2Gf6MYRs1LUl2s4MkjzX4RoAeh+RxUjIduBlcuguRIMaieKJ50tuZMVpeICRu9ztTE1w
         fQvA==
X-Forwarded-Encrypted: i=1; AKwUvByRG5hDTnLPqD3vOUkoV5+GskVwhTi+SdFgEp5Ftoi6tsnOjiddnuAyerh6NyyoMGA8jb69CuE=@vger.kernel.org
X-Gm-Message-State: AFuF++k8TnebBDEsV/QVxCtf6E/nbKwZu0VMY8Tt72/SXY8kOI0AxEo4
	ozDfBf7rIhmfHWXHj5gS8HRMe/XCrbNyPdcrCwpoQi2PxTOpgWYCE4gCwIiYqnU9z9cmjBjKpmz
	wUXBVIQ==
X-Received: from pldu5.prod.google.com ([2002:a17:903:1085:b0:2db:1c75:39b8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a4e:b0:2db:39da:90f4
 with SMTP id d9443c01a7336-2db39da9336mr206138045ad.6.1788821935386; Mon, 07
 Sep 2026 15:58:55 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:56:47 +0000
In-Reply-To: <20260907225846.3787676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907225846.3787676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907225846.3787676-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/7] ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip_tunnel_dellink() ignores itn->fb_tunnel_dev, so the per-netns
fallback tunnel device cannot be removed by userspace.

This also makes default_device_exit_batch() impossible to remove
the device since it calls ->dellink().

So, ip_tunnel_delete_net() has to iterate devices in the dying netns
and call unregister_netdevice_queue() directly.

But then, this duplicates ip_tunnel_del() in ip_tunnel_dellink()
and ip_tunnel_uninit().

Let's set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net() and
remove for_each_netdev_safe() in ip_tunnel_delete_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ip_tunnel.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6bcf01411d0..d29e2ba7cdd3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1155,26 +1155,19 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 			  struct list_head *head)
 {
 	struct ip_tunnel_net *itn = net_generic(net, id);
-	struct net_device *dev, *aux;
 	int h;
 
 	ASSERT_RTNL_NET(net);
 
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == ops)
-			unregister_netdevice_queue(dev, head);
+	WRITE_ONCE(itn->fb_tunnel_dev, NULL);
 
 	for (h = 0; h < IP_TNL_HASH_SIZE; h++) {
-		struct ip_tunnel *t;
-		struct hlist_node *n;
 		struct hlist_head *thead = &itn->tunnels[h];
+		struct hlist_node *n;
+		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			/* If dev is in the same netns, it has already
-			 * been added to the list by the previous loop.
-			 */
-			if (!net_eq(dev_net(t->dev), net))
-				unregister_netdevice_queue(t->dev, head);
+			unregister_netdevice_queue(t->dev, head);
 	}
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
@@ -1310,8 +1303,6 @@ void ip_tunnel_uninit(struct net_device *dev)
 
 	itn = net_generic(net, tunnel->ip_tnl_net_id);
 	ip_tunnel_del(itn, netdev_priv(dev));
-	if (itn->fb_tunnel_dev == dev)
-		WRITE_ONCE(itn->fb_tunnel_dev, NULL);
 
 	dst_cache_reset(&tunnel->dst_cache);
 }
-- 
2.55.0.1003.g10538fe699-goog

