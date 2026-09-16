Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACE4F4755
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564961; cv=none; b=PWB+Ywe8ubO6MEcuPXSc9W3VjldApYdh5aG9FI6x0RVWoU3R7l9IFNGwVl+Q+THzgt0MTZwbTXWC4NZfUzXzc8okTbHHIxHy2xyra0gcRosd4o5+xUwYY4n5lg1KckRQ5yjtuB8JzFOd1kH07zwrNKDct8n2yKEbeQnEsxqB5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564961; c=relaxed/simple;
	bh=NnfxvDol7juRXHpMlIgXvr43eIfEqnghTp3t+8bvttQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fyf0rkIpvjPCED0/ErksVaVP+2kjqVntM3ydG6ZMS2uX5dQD/UCboWayB50KvGeirHfP+RzlT9V0H3cly2hZNH8TRZrR+40+Kexmly/pYbfWbRnuZ68Qj3vCKp4/epjiF5M+Po9MjG9wZbJgJ6Sq8233psvpl2HElmepHzvbACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSjjN95Z; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSjjN95Z"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939c30aa9a0so515807785a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789564956; x=1790169756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/L3nudeAY/gfOdVzKZkY8dFqlxgO7MoVfZmwuvPFXSk=;
        b=nSjjN95Zm2VzDSdT+L/ax+SmWs5Nqnc6hShDKwl49YCoG6RgQRWswup8jawtvx/HKa
         zZ8bW5eHP0IuQEzK95rKzU0nmHej5/rDqzxVz/YNE/grZt0VnLsoXttue3jYJc7JjcgR
         INIhrpFVgPrVtYWXOt5mPXLaQRqjKumxdjF8czd1Wa7QpuCKDLpNu+etxnDz9KNbdGj3
         3xCb7lbMIAKOhTutT4aomr8MA0UIlfA4hqyhHaaY2fdvIeGxr+Tsk6MaQylGJG4nod+2
         O0wS1soMwswpCawJSkhoTbCb9R+Ah4n892od9fxrgR4AXqg9981n7r1H+4xo9beIsVyZ
         TqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564956; x=1790169756;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/L3nudeAY/gfOdVzKZkY8dFqlxgO7MoVfZmwuvPFXSk=;
        b=Nuxyc1ibLpMTApmAyQSDr0m4MVmWaydTMKVF7quCbk4DMz3mPXJO4ka8S9giLwsTyx
         RqMLUiUhkHFDMbe3tpY0rvisnNjW+gYNhqWokOpH6Eitly+yiPPAZogzjI3u456W3jfD
         bjq2nt9LsOPMFRH43+U15w60WvzRVo9su8R0x7XDPDbzTa8n4Tnjx9qVqYXa2wfhG84e
         MpQkC1yqrq3k8ajT98MvS04K7be9KIt7BbEKPwNmPyUtt5MSHKaZw6DYlUJhoWC8eJMK
         4Ym6q759GII0MkzF2eLEoXU92gDixbH7cH3RPBN+ImKSyvdEZIBsn9kS6wKJzgZqTpnB
         tITg==
X-Forwarded-Encrypted: i=1; AKwUvBxR69Anv9mUloXtnE62jd18Bl9lZNXjzMIWtrkXjkbODsrMEg8G7KuvwYKyyOcpwRKtLCaVZxg=@vger.kernel.org
X-Gm-Message-State: AFuF++mZKmsphF4WpHtA4tMWNTT6kgpGKcMuPkAj0Gy5Z872RG2HumW9
	XfY3b1GNtqs1Y3Ks9Wd2xVD8mRPobECiyqQIP0SI6ychfIq0TAT23xYVueZFxln7QruE9jSeQ2E
	fjfYTe5iRRx34og==
X-Received: from qknwb7.prod.google.com ([2002:a05:620a:4d47:b0:936:83e0:b604])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8006:b0:92e:e559:fe6b with SMTP id af79cd13be357-93bb772ad85mr360895385a.7.1789564955136;
 Wed, 16 Sep 2026 06:22:35 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:22:30 +0000
In-Reply-To: <20260916132231.1780091-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916132231.1780091-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132231.1780091-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] net: rmnet: annotate data-races around mux_id
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>, 
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

priv->mux_id is written under RTNL from rmnet_vnd_newlink() and
rmnet_changelink(), but rmnet_egress_handler() reads it from the
transmit path without any lock.

Likewise ep->mux_id is written under RTNL from rmnet_changelink(),
while rmnet_get_endpoint() reads it from the receive path under
RCU only.

Add the missing READ_ONCE()/WRITE_ONCE() annotations.

While at it, publish ep->mux_id before inserting the endpoint in
its new bucket in rmnet_changelink(). Otherwise a concurrent
rmnet_get_endpoint() walking the new bucket could find the
endpoint still carrying its old mux_id, and drop the packet.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c   | 6 +++---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c | 2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 59ef8b4ce5321ebbd1d416fd9da0a820e53ecf9e..248a9d822409b7cbf3739c085487644b7025dd37 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -331,11 +331,11 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 			}
 
 			hlist_del_init_rcu(&ep->hlnode);
+			WRITE_ONCE(ep->mux_id, mux_id);
 			hlist_add_head_rcu(&ep->hlnode,
 					   &port->muxed_ep[mux_id]);
 
-			ep->mux_id = mux_id;
-			priv->mux_id = mux_id;
+			WRITE_ONCE(priv->mux_id, mux_id);
 		}
 	}
 
@@ -427,7 +427,7 @@ struct rmnet_endpoint *rmnet_get_endpoint(struct rmnet_port *port, u8 mux_id)
 
 	hlist_for_each_entry_rcu(ep, &port->muxed_ep[mux_id], hlnode,
 				 lockdep_rtnl_is_held()) {
-		if (ep->mux_id == mux_id)
+		if (READ_ONCE(ep->mux_id) == mux_id)
 			return ep;
 	}
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index d4fec2fff227cd93f14eb1802aff185e6d496786..aa5523f4618eb350ec3da20b7f085d955b3403a2 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -261,7 +261,7 @@ void rmnet_egress_handler(struct sk_buff *skb)
 	orig_dev = skb->dev;
 	priv = netdev_priv(orig_dev);
 	skb->dev = priv->real_dev;
-	mux_id = priv->mux_id;
+	mux_id = READ_ONCE(priv->mux_id);
 
 	port = rmnet_get_port_rcu(skb->dev);
 	if (!port)
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 4f0ddcedfa9790dc5843fdea85b2da4bc8329775..9594c97c918565e93ac70ac73340f705b391bd18 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -332,7 +332,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 
 		rmnet_dev->rtnl_link_ops = &rmnet_link_ops;
 
-		priv->mux_id = id;
+		WRITE_ONCE(priv->mux_id, id);
 
 		netdev_dbg(rmnet_dev, "rmnet dev created\n");
 	}
-- 
2.55.0.1032.g73a4cd73de-goog

