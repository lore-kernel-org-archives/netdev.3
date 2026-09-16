Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CE2EC56E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599849; cv=none; b=b/iQRT4owauu+EYLlCGHgBw219zaoA5RDMDW3AdoV/zWFW4aQLIfsYjKf8W5aTjWsccfEB73w8+wT+N5VBVLtBl4jHCCxJE53TX9JJoLY5ZsomdoV4a2QKBj2MHGylzIjb/ihoiS22hPn2F9X5uaJMBDes7PIugKzlMn0j6v7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599849; c=relaxed/simple;
	bh=eKaFrMB6HCNhBcp8aXwq5IASyTAgjlMDjiAEohSMo+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lwtn4r3oVbeF12VEaCEuOAeU/pwwKUhWgFmDl9h/oBsCqWl35e+0FRuh3iCkhp9Pcd9NUocZSceMdmHebMjcZn5Ag72eNnWSZ/MgxKGGG6nvfRrS+pyE5ssRLXHL3h3tpI/atS6XqJpKFwBZkVunIaxHRP6iRQJU9pQZpbAbHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1wTxmpl; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1wTxmpl"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so189263a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789599837; x=1790204637; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zxv8PzmTx9bls44AYlQgaVwbVWr4XWz+LL7dfVydGo=;
        b=k1wTxmplp0ITJ9U8yDsIBEvzhNzlr9z0RkyLz3yJDH3cIBMD+9h8H6ir0tQgA/syv7
         iZATyeJpomVWhvDSu5CjilWLRhBtLRMjtyVS9KnUMTfvAd/tfTBNAi7WNobxtgMOegmO
         Cc1ZB8o2IVhhFJSVHHRY3Bsb6V+ggWLoMDP3cl6Gei2jXZdrDhxd4BvCinQ6QD5zq5aH
         IQgmA4fg6z014Ko69xYS7vhccXPsY1yfWWPNCR+NPjBJy/b5PJZaF/Rapkr4ezAHOUU6
         wC7kLrUGnIZ3RJ5Zowopl3cMiByZyoXhn6m0n123QZupx8pfk0udBC5PuoTk03f4u0G2
         nNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789599837; x=1790204637;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zxv8PzmTx9bls44AYlQgaVwbVWr4XWz+LL7dfVydGo=;
        b=j4yF1By9Aqv2IXP8Q9j6yX0+7FsMMbLUc+GICubpcTlYPJOvSApT98I+iVlQ1p0TjZ
         F4Gl6db1TYjih45Jdo7ERErt+ymgwrcYxO8OcFPrcnnRtGFPrA0O0j/9FtWhGNW0H4GS
         B42HHFF0MfwLV++9qWldgZJlOpuJhcM3kHUB1/mogKAVkBSvCt8ey0Dx6+D99mFDShDG
         Lxf9hJ1XAdlgV3DlTFlz3G9PJJCJrpSiNbbDwtFpBP5/RNEtdDgb7dAXBXwPB2CXDk04
         wq/6IvomLCF1tLTbKdNMU4BfiuQwwApxM1FQTi1zGAXJ3TrR23r/+NK8yLyJau5l6cZH
         2NzA==
X-Forwarded-Encrypted: i=1; AKwUvBwz7o8AlT3YVaxC53RyCkl5/BKJd4ay3o82PRoSwOZ/yt2znauCnIcKbBJJ/Qtli9CUs3nyBHI=@vger.kernel.org
X-Gm-Message-State: AFuF++npWNBxaLGNFGd35kO5wsE8CROmKIbnZkv5b2zCbDfNScIDCaWE
	FDuD8I0OXO+LqO71UDVdqEM1lrqAMpGzPuI23VryYqWRrMP3wLSA3A6lX5XLYwWAE0S1fEOwAGi
	De2Wopg==
X-Received: from pfoo22.prod.google.com ([2002:a05:6a00:1a16:b0:86a:6e68:ffac])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d13:b0:845:c694:5c3d
 with SMTP id d2e1a72fcca58-872372c38b0mr9455015b3a.1.1789599837262; Wed, 16
 Sep 2026 16:03:57 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:02:22 +0000
In-Reply-To: <20260916230353.367014-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916230353.367014-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916230353.367014-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/6] ip6_gre: Clear ign->fb_tunnel_dev in ip6gre_exit_rtnl_net().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip6gre_dellink() ignores itn->fb_tunnel_dev, so the per-netns
fallback tunnel device cannot be removed by userspace.

This also makes default_device_exit_batch() impossible to remove
the device since it calls ->dellink().

So, ip6gre_exit_rtnl_net() has to iterate devices in the dying
netns and call unregister_netdevice_queue() directly, and
ip6gre_tunnel_unlink() must be called at ->ndo_uninit().

For per-netns device unregistration, we want to check if the
device is being removed in ->dellink(), for which we must call
ip6gre_tunnel_unlink() before unregister_netdevice_queue().

As a prep, let's set itn->fb_tunnel_dev to NULL and remove
remove for_each_netdev_safe() in ip6gre_exit_rtnl_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_gre.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d3a879fa296e..d5d98474aeb5 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -374,8 +374,6 @@ static void ip6gre_tunnel_uninit(struct net_device *dev)
 
 	ip6gre_tunnel_unlink_md(ign, t);
 	ip6gre_tunnel_unlink(ign, t);
-	if (ign->fb_tunnel_dev == dev)
-		WRITE_ONCE(ign->fb_tunnel_dev, NULL);
 	dst_cache_reset(&t->dst_cache);
 	netdev_put(dev, &t->dev_tracker);
 }
@@ -1552,29 +1550,20 @@ static void __net_exit ip6gre_exit_rtnl_net(struct net *net,
 					    struct list_head *dev_kill_list)
 {
 	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
-	struct net_device *dev, *aux;
 	int prio;
 
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == &ip6gre_link_ops ||
-		    dev->rtnl_link_ops == &ip6gre_tap_ops ||
-		    dev->rtnl_link_ops == &ip6erspan_tap_ops)
-			unregister_netdevice_queue(dev, dev_kill_list);
+	WRITE_ONCE(ign->fb_tunnel_dev, NULL);
 
 	for (prio = 0; prio < 4; prio++) {
 		int h;
 
 		for (h = 0; h < IP6_GRE_HASH_SIZE; h++) {
 			struct hlist_head *head = &ign->tunnels[prio][h];
+			struct hlist_node *tmp;
 			struct ip6_tnl *t;
 
-			hlist_for_each_entry(t, head, hash_node) {
-				/* If dev is in the same netns, it has already
-				 * been added to the list by the previous loop.
-				 */
-				if (!net_eq(dev_net(t->dev), net))
-					unregister_netdevice_queue(t->dev, dev_kill_list);
-			}
+			hlist_for_each_entry_safe(t, tmp, head, hash_node)
+				unregister_netdevice_queue(t->dev, dev_kill_list);
 		}
 	}
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

