Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010B3D904C
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997472; cv=none; b=Vq+lEPB50/DoXSwMZUPJfNpviF50RkeUlphHRvEMGWFvY2Ae9Qs6w65oyT8gu60vJYEPqBN6t7R42b835b3Ya6HeJrZCxs2E3LZHI6vxZxW+MW/QStpxI08VIv9KdOhhK/oAs7qzBDZiHYFmzbXTR4VSUJEaOvfEc2vBibLKJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997472; c=relaxed/simple;
	bh=ekb8cnXJN6IhVShuPmqPv5+DOjSyCuJ0BV8cevW4n38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cNvdP8wDLwarssdL5op69zdDLb+XO867+UGTpBf3MMyxkK6saI4SLd6M8mhh0pVyqPCvILUUHClSI415xRgAp3bvA4phFJam+ZnCAtv9XevYXw6W/fpWJilsFQr5L0BpmGpF0QUKKK6r7QYR4dBU0Mo53+EYtHdme90Gqlti4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cz08yecl; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cz08yecl"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso11442895a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788997469; x=1789602269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIQMjAqTIwtT9S0LMA4qcau8Y2sq3v6Hjp+lwZWXkSg=;
        b=Cz08yecljWAhGPHjyFUoQRxSn4/Ys59QJJeOoJeBj0vsnT6MMCvgjEOmZuEfrn3agM
         0p01xxrvHbfMJCONL7rMS9xPpbFHitBomJ4GnVkTM8jg6T7JIDOKVF9wbwE370V8lrTl
         eNUfQ8hI2HQOKu7DDvTT3R0SsX1s+wuIreWBZI/0oitGUwnDuCzPqIb2DL6z/MYVz26I
         PqJ8DBT3DLHr5xuALx1/eKOhrlodIf7MbGcQXQUSM1YweyCzhqOG0/9moOT/NvX7KOfc
         f2GhQzNIOVcTE9WVyx0yjdiMvP+r3gum3/Wn6r/ry2hbE6OXgdQ7fAA7PEtRN9NzUuMb
         U/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997469; x=1789602269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rIQMjAqTIwtT9S0LMA4qcau8Y2sq3v6Hjp+lwZWXkSg=;
        b=QbbHK0dU6NzBRFchisnjTMuGbg7Hx7nBborhS9QQJ5SK8S26aKVKrhiM7mzmA7hNGC
         onIy40zHkpOsSUlZ4LOuGSoyk2nW6DJeybirT77ywqvHWGa0s68uTFB8DS4C+WXCdkjm
         uRWSoXKL2KUrarFQMoimxfrEy3juiKQaKyL0cslfcBlmU4N7HH4EBi1qBZUK31F80fNj
         bzMRU1hXO/Clv6S35yS0gyV4v6xgfZsJU/HIGhJkRhyoLKlK442MaBck82+6k8X6rGkK
         o/IORs9AuwlxqlgQL+M1vwwpHVG1QU5jgzeZXLs4FvB22dDdSZkvyystMgY37UeP4MDj
         6A2g==
X-Forwarded-Encrypted: i=1; AKwUvBwGhPNuYivZN1Jw01mvJDiXwki8rCs9G3Mf0x6ZPGJ85JyLKgCBOjQc0ABAXsdsD+r39CToP80=@vger.kernel.org
X-Gm-Message-State: AFuF++m7lOwX+EeaeRlI4S2TLZp38ccwdASEEy+fzAVmg4OKBP/3S+n6
	n61MMSQNCSdZK662ibWF72HFgCb7WH6xkHpGYZTJdypk1KbMmgZqDpYehw6X7hen+hHkFou1h/h
	Ft38Ijg==
X-Received: from pjbgz14.prod.google.com ([2002:a17:90b:ece:b0:383:c59b:fc00])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c52:b0:396:d27b:89b9
 with SMTP id 98e67ed59e1d1-39b2612ccddmr55956459a91.10.1788997469309; Wed, 09
 Sep 2026 16:44:29 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:43:47 +0000
In-Reply-To: <20260909234422.2416506-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909234422.2416506-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909234422.2416506-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 4/7] ip_tunnel: Centralise ip_tunnel_del() to ip_tunnel_dellink().
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

