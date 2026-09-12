Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA703793A6
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254049; cv=none; b=dFLjroK97OeMZqWEGb8Xil/SM4LFflf/UX4/GQHSPUhVH0rerQatG7U/uICih9w/uxtl/tdaPDlwZoNxsTerSuwfnAQyU+gDRAM8lc8SzF1uHbRJFPaeqkEsy6HyAQ40tHSe4bkKHxEj3qMLN4hUxZmgL75WQ1va6ZRdJOzt0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254049; c=relaxed/simple;
	bh=Lk9eUlZaF/DePDG4JbjtpBe3kJ76fFH7nPZ5CIQs8Z4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HAoJAGbewEAoCtr+yWKAt1FAhNLKYDQbaspS9JnRxkG7MY7NS4C19jBAYE1KxNEKjizLACKj2ZnbM1lIbQ95k//Pg1iBjvQr/SK6YL3EeDrl7si8ilfpXwlcyWqg8fjmgHbCWK4zFlpLXmTwEJeMX3PPzU3Cf5O/jHNp9WaSmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VK/kDi+4; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VK/kDi+4"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so2115936a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789254048; x=1789858848; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n/x+2rGV+mTu2ADx7H/fzKnkMhkI5V2pKrqMJFFvEwY=;
        b=VK/kDi+4Lz5FiWHpUdbXsDsR1MhYhgOQW8qgCGx8yLTBdh1YrGMpngjYQJXXlyqePI
         9OlVl7WhxaMsOId9NBnyCkLdWHnqPUYGA9chiJmRCW049c8A6h/NNikdm6UY8wUTLvSs
         yuHQ8KgxetBu82OeI6+kbH/5XiJdFuFsCKzPr9XFhiXcY8/QI0CI/MFai3O19JGSrp3F
         3mvjQNsAZ7wj4AeSIWA7cC53ERCnsMxI7Wv8z82+YZxfvPRizqA8Y9L0VnqN5Jg6xIo2
         PzIvnR7I08lBHkO3Azm35IOeRa7IF/fQjN2yw/b/kaltEnuWktiK35CeICBbMQq4+thC
         /Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254048; x=1789858848;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/x+2rGV+mTu2ADx7H/fzKnkMhkI5V2pKrqMJFFvEwY=;
        b=LZ6hIMYK5JOFhXrYmnEZNOdM16r/XIWMDOKnSgfqXZVYFaFwyOg2pwGhFK1XmWUIjh
         SbBuXscqeJyJeQP8kEV7XUcaOo9e4B0XGY7W9Y6PTHv568cJ/fyvm9GwlkvL1SmMiEes
         QcqYEkaeyVracZsI0cwUlSQKrMS9Mrk59ETDTuno1gjBbV7e43gbrl+6d+y2no4lhhn9
         0ue0vamPAVPrSve0NPDXqJOjZp1QYZBELaY/DyGa7PS1KQ/phnzYhf13sftih+MD70jk
         5NUwId/nhiA/pzzwSZ5QHYAXBYKMI8IFzulWtnKP3BT6kp8rvP+xlImvvhGqJCn21Uzr
         SwRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzALGXd3NAaBetgXtXuhihIkpU547UM+LnCvvECrhUlRnTtXEKLNP1eR1GuP27/brL54QtjcSA=@vger.kernel.org
X-Gm-Message-State: AFuF++lAQdWSP/tziackTVs1CKGaC0x7L15ZGFr65gn/VwmBcD4FPBMK
	KaCpXNLBGE8XM6Ag8gneozSE4e/vbFwSWdVB2DO68ZFWLV4dD1daBCZmYzccMw2YN3ITMtvuAnP
	bEc2bPw==
X-Received: from pfgf15-n2.prod.google.com ([2002:a05:6a00:c58f:20b0:84b:57b7:60c5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3391:b0:848:2ab3:ddeb
 with SMTP id d2e1a72fcca58-86b31805fdamr18580618b3a.14.1789254047322; Sat, 12
 Sep 2026 16:00:47 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:00:28 +0000
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912230043.2586313-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912230043.2586313-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 2/7] ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().
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
index 13b5e35e8790..d74200ab5762 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1153,26 +1153,19 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
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
@@ -1308,8 +1301,6 @@ void ip_tunnel_uninit(struct net_device *dev)
 
 	itn = net_generic(net, tunnel->ip_tnl_net_id);
 	ip_tunnel_del(itn, netdev_priv(dev));
-	if (itn->fb_tunnel_dev == dev)
-		WRITE_ONCE(itn->fb_tunnel_dev, NULL);
 
 	dst_cache_reset(&tunnel->dst_cache);
 }
-- 
2.55.0.1007.g17ff1f9808-goog

