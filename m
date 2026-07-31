Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081B468C23
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516379; cv=none; b=tAlmdeCCwaOGXONjMR0qPKHWADLi8NQUAbcAPjZ0goO3t6gy+FGuU/Ldm2OGlm/O449GEo+fzWOtNGsQDqeBaOSmLImeeH9AeCta3tqpT+Fv51eJr9R3T5qAsjz8JN0fmjUvJGz2rQLQnpDGG9N3nNDdKyY5a1EiOZtkmrNEJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516379; c=relaxed/simple;
	bh=HvXC7My+C9wD7ZpBigTIoU1OByFMCQ38cBOggZJTL7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SNuo7n8HaJmZl5tlHpWGNWxg0h+iezmQ7MyFJhsQxpRXOYOTGjU7bbJA7yDzna2hJzPUCgzVKkYpLZZQTJMILQDQavCPom5WZmKD2K12HqKzmA/FzauFV3FWMmQVNXtiQsQ4blxMgY1DSliwts75AtVLVwIPz8rkAfyegfQruOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEBQhfxz; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEBQhfxz"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc6dd43737so25576025ad.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785516377; x=1786121177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osjh6i84XXjsTS1Oq5pRDD3g+N45uKIPW1ZN1vF5UWQ=;
        b=DEBQhfxzpfFI/3plIDw9G1KeMjwF+ZtzNNNQBaMwKTmNYfM2v4wOcfRK6k4DzAZGFX
         D0fDqUGcEQgSZK5c9kJRyIJwdNFB1zKAbVh1EF8FRC/dHFpMNcQf3kJFoTjs+EoJ8gXr
         v4k+N6CQH3qq3V/jBfpsqN946+X0wDAZFKRiOvLPQvfIzSlSLua/Yt1HdnRdvwqmPbPj
         WHrvr2fOOkHu+kQDh2ADchbrxyJPQH2L5qEl5LoxPdFN1Mg3CcICB+R4nVqmOA1jp6rI
         Vv3Fuyy8h7RL7UxSS1Zsfg5LGW4JFvdePG+mNEyb7Hlxt8suz/GdHtSCbxmYy6hIQsYm
         ioPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516377; x=1786121177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=osjh6i84XXjsTS1Oq5pRDD3g+N45uKIPW1ZN1vF5UWQ=;
        b=POwjWgrcJobSSbfR9cOPq2Ke4e2QnXYsAzEOJSWBXOUOtL/vpezElNiDFT8v4gwhkD
         m195yJLiCy0txt/DfSfsnDjrpoBYAMdpO6wb+lQ+U06jEpqkdhgAYeYFkqjJWDYBB5sW
         oeHJWqRwg/DktzEWGupFEBfLMqF97Ss5h0YNgR53DTPvSA8lSCmfGiCDrPHOa5SinWG+
         1xz8GC0EwjRwV7sCHZ+mRvgyHUmZMR9ck/RoEIyecQlOkeIa2tfmGM4aKX/VZJZ15ION
         9vSB6NFThiVqIzmQD7q8J2FLgJmN8aPQT+/gdJgxWVOL2SS9c5F86q7gF4Uwa3LeeAQX
         3yAQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDelfFKeI2Diy/cPrmgaomQaiw3IuS+ojc2alx/U8HIKn/WNEtcXYR/KgK8yHmp6sN6eJb0cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydnG222gzV1YcKWluG0aBdXN+QOhwOsISl56uWBxL7EDE/Njjd
	11L6EjZAN/qLB1QNMsEyAddIBJFKC/ASERZ9NE4kqh8v0hcPO3wcyj/GG69Fer2addV0Bri+1JK
	zgZ/Yjw==
X-Received: from pjyd7.prod.google.com ([2002:a17:90a:dfc7:b0:38f:2371:f421])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0b:b0:38e:7f1b:f01
 with SMTP id 98e67ed59e1d1-38fbc5428d7mr480168a91.36.1785516377019; Fri, 31
 Jul 2026 09:46:17 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:45:53 +0000
In-Reply-To: <20260731164612.2148830-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731164612.2148830-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731164612.2148830-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/3] geneve: Unlink geneve->sock[46].hlist[46].hlist
 in __geneve_sock_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, geneve->sock[46].hlist[46] is unliked from
geneve_sock.vni_list in geneve_stop() and geneve_sock.refcnt is
decremented for each socket later in __geneve_sock_release().

The following patch will introduce a mutex in geneve_net to
protect geneve_sock.{refcnt,vni_list}.

However, udp_tunnel_notify_del_rx_port() must be outside of the
lock to avoid AB-BA deadlock.

To make the change cleaner, let's move hlist_del_init_rcu()
from geneve_stop() to __geneve_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 542e53f9dc3e..bd4fc6dba2fa 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1052,9 +1052,30 @@ static struct geneve_sock *geneve_socket_create(struct net *net,
 	return gs;
 }
 
-static void __geneve_sock_release(struct geneve_sock *gs)
+static void __geneve_sock_release(struct geneve_dev *geneve, bool ipv6)
 {
-	if (!gs || --gs->refcnt)
+	struct geneve_dev_node *node;
+	struct geneve_sock *gs;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (ipv6) {
+		gs = rtnl_dereference(geneve->sock6);
+		rcu_assign_pointer(geneve->sock6, NULL);
+		node = &geneve->hlist6;
+	} else
+#endif
+	{
+		gs = rtnl_dereference(geneve->sock4);
+		rcu_assign_pointer(geneve->sock4, NULL);
+		node = &geneve->hlist4;
+	}
+
+	if (!gs)
+		return;
+
+	hlist_del_init_rcu(&node->hlist);
+
+	if (--gs->refcnt)
 		return;
 
 	list_del(&gs->list);
@@ -1065,19 +1086,10 @@ static void __geneve_sock_release(struct geneve_sock *gs)
 
 static void geneve_sock_release(struct geneve_dev *geneve)
 {
-	struct geneve_sock *gs4 = rtnl_dereference(geneve->sock4);
 #if IS_ENABLED(CONFIG_IPV6)
-	struct geneve_sock *gs6 = rtnl_dereference(geneve->sock6);
-
-	rcu_assign_pointer(geneve->sock6, NULL);
-#endif
-
-	rcu_assign_pointer(geneve->sock4, NULL);
-
-	__geneve_sock_release(gs4);
-#if IS_ENABLED(CONFIG_IPV6)
-	__geneve_sock_release(gs6);
+	__geneve_sock_release(geneve, true);
 #endif
+	__geneve_sock_release(geneve, false);
 }
 
 static struct geneve_sock *geneve_find_sock(struct net *net,
@@ -1187,10 +1199,6 @@ static int geneve_stop(struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
 
-	hlist_del_init_rcu(&geneve->hlist4.hlist);
-#if IS_ENABLED(CONFIG_IPV6)
-	hlist_del_init_rcu(&geneve->hlist6.hlist);
-#endif
 	geneve_sock_release(geneve);
 	return 0;
 }
-- 
2.55.0.571.g244d577d93-goog

