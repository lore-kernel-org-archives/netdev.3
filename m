Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28C3A4F54
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427082; cv=none; b=t3Dtfa0SOwc2Cv6RWSd9RFf+Eys8moJQpq9M3EEKHNoyzgANjvZW/l3Ft7P9zoCUZUjPcZx7H7npqXSJ4U48wg4GTVvEgtSq8hptsMmbaa5LRZYSowCpF817omSJKQY6zkvTh3cSsWSaJ7geFYpMGz0GS1fXRmzl2hsPPXcg0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427082; c=relaxed/simple;
	bh=h8JPYnO+eqJ9Dc0SIYpANmXnN+I4zCl7ZMLOVzBUjFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ILNv0zTx1OAvcrqZ7noX+WI+wG8CYglSU+VPSSEa53X8j3D2vbNuI3eUiuVmojJqncdEIqrVVhFGrd+h72Dy8tFwhjxNYw4b6UbG1cIforlqb3AVYtDbfgalPbt1SqnuuIGfovIqZVKHCZtEHutVuPCvasGpjncEtiiXj6JbtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgNEE95/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgNEE95/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d992fa39eso3750834a91.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780427080; x=1781031880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAYiUXpXn5CzV5riNOm0WbvL5if0xpSlbCX0VLgoyAQ=;
        b=YgNEE95/bU7viz0SPdc7vgxyUmyO4p7Mgps+CbmN8r/LpmJ5WPhNUjz0tlwnajlGge
         4anf9J5PMPO+j5G1SJXMsENm0kT3Qi/y+q5myFjs3REoLB1qSyo5BfcDKXhgKw2YqUOM
         7brWODjIb9xuUSvTcZunmbxUtwkTbBPTb8E1KUfEp0ZMurB/Xr7NkVj135PqSRMciCUs
         jeCn2kZiEAlCSjmwrFxeVVDyX4GIBb9faCLtz858UdZscyEVaAYMUeVUbVgOGc+MgK+y
         HOkstJmjGXW6+qXrxTnoyzB7eOa/cEkhykI8Gb5Qfqe+eLuXjbVdHCZb4xugK5ROQlbO
         oexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427080; x=1781031880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAYiUXpXn5CzV5riNOm0WbvL5if0xpSlbCX0VLgoyAQ=;
        b=S5XiBScoIJ/G/JI+1W+9aIOvrlDYKKfWQgtM2hMg+64PsZC80+GhGKz1wKGO4bySKC
         HojOucAP+yyB1tjcygyMuh+yI50/e4JMNkyFeQ5q38+vO309VWzS7G0LIo7gkDFe7Csj
         BDalgxqg91G0RtWB6HP01s+5+tgEMUX4vC5fPHc+ieangS8u8V5JnRbmFwzEfH22rF1B
         ZJn7tCKbbI91vdOju7xKdQIgHUNjrT431IXBo7sZ8I+RlkM8/jrn3BOFwmUmsD/MisqO
         T6UzjALzOsu9+Kznk5XPe6+wlmKxfj7W4UUJMiZm+3UlRtubj0/rz6RDGn1XGRFiO26S
         rRuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZKxoue+6q59ZNvsaGeL9WNTF5wrrLxokx4lY1DhtwOFtjt+Tgehj4wy3DQlgzixgWo8+xI2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6y6lSzqhYoPG+Ibu/+pgjn/1du8Gy6yV/ie83JBogSNHfSKVq
	VolpiKVyv2/SWTp8dRHK+cqGBYqGCUPW6cw/AKIAUWjp4XcRfVs32KlfcqOE5LZPwMoNjL7EbMP
	o9wCu1A==
X-Received: from pjyl18.prod.google.com ([2002:a17:90a:ec12:b0:365:ca4c:7afb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b47:b0:366:5c38:fd61
 with SMTP id 98e67ed59e1d1-36e32f1676amr119233a91.12.1780427079873; Tue, 02
 Jun 2026 12:04:39 -0700 (PDT)
Date: Tue,  2 Jun 2026 19:03:42 +0000
In-Reply-To: <20260602190436.139591-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602190436.139591-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602190436.139591-3-kuniyu@google.com>
Subject: [PATCH v5 net-next 2/5] geneve: Pass struct geneve_dev to geneve_create_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a prep patch to make a subsequent patch clean.

We will need to access geneve_dev->cfg.info.key.u.{ipv4,ipv6}.src
in geneve_create_sock() later.

Let's pass down struct geneve_dev from geneve_sock_add() to
geneve_create_sock() instead of individual config fields.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 8413c21fee6f..7e8c3023842e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -760,9 +760,10 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return -EPFNOSUPPORT;
 }
 
-static struct sock *geneve_create_sock(struct net *net, bool ipv6,
-				       __be16 port, bool ipv6_rx_csum)
+static struct sock *geneve_create_sock(struct net *net,
+				       struct geneve_dev *geneve, bool ipv6)
 {
+	struct ip_tunnel_info *info = &geneve->cfg.info;
 	struct udp_port_cfg udp_conf;
 	struct socket *sock;
 	int err;
@@ -772,13 +773,13 @@ static struct sock *geneve_create_sock(struct net *net, bool ipv6,
 	if (ipv6) {
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
-		udp_conf.use_udp6_rx_checksums = ipv6_rx_csum;
+		udp_conf.use_udp6_rx_checksums = geneve->cfg.use_udp6_rx_checksums;
 	} else {
 		udp_conf.family = AF_INET;
 		udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
 	}
 
-	udp_conf.local_udp_port = port;
+	udp_conf.local_udp_port = info->key.tp_dst;
 
 	/* Open UDP socket */
 	err = udp_sock_create(net, &udp_conf, &sock);
@@ -970,8 +971,8 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 }
 
 /* Create new listen socket if needed */
-static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
-						bool ipv6, bool ipv6_rx_csum)
+static struct geneve_sock *geneve_socket_create(struct net *net,
+						struct geneve_dev *geneve, bool ipv6)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct udp_tunnel_sock_cfg tunnel_cfg;
@@ -983,7 +984,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sk = geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
+	sk = geneve_create_sock(net, geneve, ipv6);
 	if (IS_ERR(sk)) {
 		kfree(gs);
 		return ERR_CAST(sk);
@@ -1073,8 +1074,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 		goto out;
 	}
 
-	gs = geneve_socket_create(net, geneve->cfg.info.key.tp_dst, ipv6,
-				  geneve->cfg.use_udp6_rx_checksums);
+	gs = geneve_socket_create(net, geneve, ipv6);
 	if (IS_ERR(gs))
 		return PTR_ERR(gs);
 
-- 
2.54.0.1013.g208068f2d8-goog

