Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959953DBD5E
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254051; cv=none; b=XXi+FEhadiB/zdoa0oCs9BgcA91zwL3s5d8Iz+FA2YHiam8lfanMTSQ3EZGB9yXLOwsqLQ/9khLJMrAweobIFrMFu697X0TS9WRhnR5LUdTdl86vVbEuRTjaBgsBGKiNzchulYNNCF1KrDEluu0gskMXGZglz2sGP1Z56aQRT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254051; c=relaxed/simple;
	bh=6CsDo1cLIKeCYz/9hvlxQdfYlCn/P0tsMp2wPioW530=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CtoNAH3Lp7vK+J4Dd0uJ9wfnN4sMV9BL0vla7N7zvQxBoKyDytKkFxB7jISHtNR9kFL8ntz0/J9Ri5eVA4xY+xDt4kjhYSNpFEmLDVZLSB957nA6PAjaWJ11mnDnrZUrT2sVwYjBMlGHogteZ7h5Ecw6p16LNPq/EVnRT+/wy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMR8SBPw; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMR8SBPw"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb687f82eso27123905ad.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789254050; x=1789858850; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mgVAtM5yD/HuHfoAg3zqnLyw6/hZM0TAjf+HWpcC2Sg=;
        b=MMR8SBPw8EtHO37pYUeqrUof7wgi/Lbv1FJpL2R790ThbNvcqOGIN1cGtLKU0KGOHG
         eqXqh3LZQpepVWY9MxPPyVO/HjQr/w0MEeCcrv/df4O6udCQAr+V3Lrxd38yr3PXmQ5V
         MbvvCDVeuw3izMcvLVy2e924PS00gEuswbMyve6R7OSVbzdCPx7VuQCVQ3Our0ezV6y1
         XzoldUwyaXWCl5SNNZwIyfvQO4dy8wgxDRQDRcu81mtLuM7NygOFBVPSaD9TirkSWlOB
         Qyx02S5Bk/KX4GcNkg3ZR5a1mua7/Jg04gQfAHUoo9487RoyB0G3dmx0IniDLdXtJe6l
         75CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254050; x=1789858850;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mgVAtM5yD/HuHfoAg3zqnLyw6/hZM0TAjf+HWpcC2Sg=;
        b=RzFTiJqBb2ob6d/0gEyea6Nzrd8rvbfSx6gfuoV1XDx9ckieq/wQ6cm7kpOPlwhe+R
         CHqDq49CSF5tj5tA/zgH8J1yuBY9A0CGY5pNw57yp22yacVD87tnRaENB/mSS1/CVzQ2
         nLkmOggKZ0C3tL1ZbZ0Otlw9MxmqSmCO8cafSy3b4mb3bMlWx7/9RSNjD13+63mxakdO
         JNfZQ4ZTq9djoUuBlamXBz4HAx6BQ2f4qLqFfzF0H/YUM8R5NFFKbU0nmDajGDDdMNDm
         KL2z73L7Lw+CP6ds1ZgRcCCzhvKgzOUvsMVqk04EbVOBhNyxP76DXkbhrRMCMoEvQ2qN
         0KhA==
X-Forwarded-Encrypted: i=1; AKwUvBzGkpZK/UsNhRhgH1F1zfoKLMvJNWbTXbZYGVQvRQpTJ7oVyWnnAuxvzWZpMoaMoBJhR5VuYjE=@vger.kernel.org
X-Gm-Message-State: AFuF++nxml7tpXMBxUKYhMW0xNo/OdsR+M+hJKX+XrRaEV3CPge3r4wD
	wAixrJcD6M/ZV8Pkh8WbIdfiyOcp0lsNBFy2/rJHy6H/NXsSYKb7EwycRcaq+aJgkx8iWYSOrkF
	LveOmFw==
X-Received: from pllk2.prod.google.com ([2002:a17:902:7602:b0:2d6:eed7:9d44])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac4:b0:2db:20fa:9443
 with SMTP id d9443c01a7336-2dd4bd64dbbmr78172245ad.13.1789254049729; Sat, 12
 Sep 2026 16:00:49 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:00:31 +0000
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912230043.2586313-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912230043.2586313-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 5/7] ip_tunnel: Unify error paths in
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
index 7d7baaa57741..d560ae9f0222 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1179,21 +1179,23 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
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
@@ -1220,22 +1222,26 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
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
@@ -1243,8 +1249,10 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
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
 
@@ -1257,13 +1265,16 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
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
2.55.0.1007.g17ff1f9808-goog

