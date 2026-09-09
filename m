Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D950AC28
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997470; cv=none; b=h3Xqcc7vvsLNQWK1sulEI+mrbJuRJhbqDdIKAq8V0T5Kb/q3J1QRTNgJ0u7ZVge8VP2uN0iu3CkRKkFCLjIZpf39a6cngMWWjQEH+mRHTm9E+n2eO/OgBfe/QzKyNs5/0viPC++TzxlSgbP2PNGG0C23jOWkUQDZeyyY0mL1Y5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997470; c=relaxed/simple;
	bh=ffwWF3/YyY9uDUNl7DIeKOC3iZ0LFwQ8VGX3iR4LyFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SCEZdTr/0HCN6NmofUKuni6BoIeYPj9dThzEPU0P+FGe9lueIpPSNvSfIhN1sPnOlj+P6hvVV4WFs3NFS8KxEnd5TbRQIC/btjtY3mYCrKdVfet+BTv/+mN8IswbpuuJAKlogMzEyzzmerfW687VfGIoqCmU5eA06Xxjjat8bdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2s/iDZ+; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2s/iDZ+"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc435388657so4893516a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788997469; x=1789602269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4pAIBKSwp3ppogrfD2Ya3loccy55lJwaI8+BS9o4Rw=;
        b=B2s/iDZ+3XKX5Ejj8JRTH8eQeJSTwDTf6ihSNSlSxJXmY2wdhiCgxUMqHaS6r97dq2
         cvaDakC8nehccryus6Sry+dJM9u9BKqYGJ/sfadu+OaSBvvQVq+o4kGE2pyWkwYPrBKs
         KwzG+jWvQEadaQAv4IpKKa1fGFRtI/ytT8ZB/Ew6c8MYG5zx8Wod2+3R0cG2RfJE+In/
         vENL8x2T9UK+Ng++xRptv+niBazh/dKU1y+1wmmGkPt86bSfjOiyHTxbw1Kb230h6wvv
         ynRRZbqkppq0DNq98sytHl9XySc9SnV9O5UohVhbPQJ0Icgaen96kQfQ0j1KAvscpXHI
         s6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997469; x=1789602269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4pAIBKSwp3ppogrfD2Ya3loccy55lJwaI8+BS9o4Rw=;
        b=EP5/EjGv3V2djHWD5yOqC5lqU4aYRVg0ka4sfeoh2GZ+Ro9yn3oTOYCLbniu8osN88
         Yt0Cvd5Qhy+GBwW8CnhjjnWcsUW6J31WfRsMoMGrKC8SoaCGkWdYlJTTUjQGoQZTUwoa
         caEt04BST7Krz/VZpJYEYwImWkMAG2+2QUqupHnLcso5q3hdwB3mtyx6f5d3XaMADiXN
         MySo0HypoClZwjrs4MyokMjz+TRwMzV1iQ5AKGRKEbVlQPg2GM9OZ5NPqRj5xSO6HMII
         FNSwjIv58B+C1R3vgW1f9K9vsrRJpH7pxdtnSAHtLEU6F1V5ceC3hQ3qFH19Lqv1y19Y
         HW1A==
X-Forwarded-Encrypted: i=1; AKwUvBzdaclaDXStk7BE+vOilSLnit5KLClEzMtBwfe7so1vQKSkL8YkCIR79CoelsQOqOI67JSLU8o=@vger.kernel.org
X-Gm-Message-State: AFuF++m2GRTBtEYkH9VXIy2mvKFiS7V0MGwdmXvrJFz3ENgQmyc1+YNv
	ttKxSlK3IVxBLnyR3iFmM5fK61zIPhnWW6G81qUuLbL4CcRz5ktfHih8c4mHTwwI1mN2IH3a9jw
	J4vyjpQ==
X-Received: from pfjx27.prod.google.com ([2002:aa7:9a5b:0:b0:863:3d0f:d594])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:729d:b0:3d3:ae0f:5268
 with SMTP id adf61e73a8af0-3da3a152b4bmr56347440637.20.1788997468380; Wed, 09
 Sep 2026 16:44:28 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:43:46 +0000
In-Reply-To: <20260909234422.2416506-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909234422.2416506-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909234422.2416506-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 3/7] ip_tunnel: Don't pass rtnl_link_ops to ip_tunnel_delete_net().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip_tunnel_delete_net() no longer uses the 3rd argument,
struct rtnl_link_ops *ops.

Let's remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip_tunnels.h | 1 -
 net/ipv4/ip_gre.c        | 6 +++---
 net/ipv4/ip_tunnel.c     | 1 -
 net/ipv4/ip_vti.c        | 2 +-
 net/ipv4/ipip.c          | 2 +-
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7c9aadfe8fe3..b0f9d02a7f18 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -398,7 +398,6 @@ int ip_tunnel_get_iflink(const struct net_device *dev);
 int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 		       struct rtnl_link_ops *ops, char *devname);
 void ip_tunnel_delete_net(struct net *net, unsigned int id,
-			  struct rtnl_link_ops *ops,
 			  struct list_head *dev_to_kill);
 
 void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 82309efd417e..5e877018e006 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1084,7 +1084,7 @@ static int __net_init ipgre_init_net(struct net *net)
 static void __net_exit ipgre_exit_rtnl(struct net *net,
 				       struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, ipgre_net_id, &ipgre_link_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, ipgre_net_id, dev_to_kill);
 }
 
 static struct pernet_operations ipgre_net_ops = {
@@ -1728,7 +1728,7 @@ static int __net_init ipgre_tap_init_net(struct net *net)
 static void __net_exit ipgre_tap_exit_rtnl(struct net *net,
 					   struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, gre_tap_net_id, &ipgre_tap_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, gre_tap_net_id, dev_to_kill);
 }
 
 static struct pernet_operations ipgre_tap_net_ops = {
@@ -1747,7 +1747,7 @@ static int __net_init erspan_init_net(struct net *net)
 static void __net_exit erspan_exit_rtnl(struct net *net,
 					struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, erspan_net_id, &erspan_link_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, erspan_net_id, dev_to_kill);
 }
 
 static struct pernet_operations erspan_net_ops = {
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d29e2ba7cdd3..1696ba1f3ed9 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1151,7 +1151,6 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 EXPORT_SYMBOL_GPL(ip_tunnel_init_net);
 
 void ip_tunnel_delete_net(struct net *net, unsigned int id,
-			  struct rtnl_link_ops *ops,
 			  struct list_head *head)
 {
 	struct ip_tunnel_net *itn = net_generic(net, id);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 3b80929994a0..c4f14d42df24 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -526,7 +526,7 @@ static int __net_init vti_init_net(struct net *net)
 static void __net_exit vti_exit_rtnl(struct net *net,
 				     struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, vti_net_id, &vti_link_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, vti_net_id, dev_to_kill);
 }
 
 static struct pernet_operations vti_net_ops = {
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index f684baf8e58f..2ffe64e736e0 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -645,7 +645,7 @@ static int __net_init ipip_init_net(struct net *net)
 static void __net_exit ipip_exit_rtnl(struct net *net,
 				      struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, ipip_net_id, &ipip_link_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, ipip_net_id, dev_to_kill);
 }
 
 static struct pernet_operations ipip_net_ops = {
-- 
2.55.0.1003.g10538fe699-goog

