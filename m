Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9C2DE6FF
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760317; cv=none; b=s7AGQ1Nw3vmSY86EqPhe4oMJFXtI4JQHvvCPfIA/Ku9hdbcAStsXo0RYTmfEtCTUtL34m/G1zi2FEfh06BxwnwuTovTGUjP4OU+ys+NyQwH2p1zR2ftjWaVZIRjaeO7x83ZLCoyLeSn/z2LdCeZs61FA+Ei5OW0j8aUDq+WAfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760317; c=relaxed/simple;
	bh=Y4+UIpcDLEr5sG3IN4JfWgsWsPtkzxPTHUA3fEo3D1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHoBwkJj637B+10JevZC5kUuuaVzG6llD3XrpVn1Ib49Wwz0/VmRxsE67Cw4R36APbWFwd+JEfDKmWXLLI58ajaqTxojYRr6/fEJnAIeeu351lPU2p7RsF/x5ZJdbk+XbQ2HVUUvK+oHI76mrB9xUiMkpizeiVcBxWtBDXA/DeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCLhon/F; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCLhon/F"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so134869015ad.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779760316; x=1780365116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWSTvOF/gzpYSCqq/FR9TOCszX7XxtE0WLsWHlZ8hBs=;
        b=YCLhon/FHeAnHHeG55bEU5veXKeKwYLsMwWloxdY7e2Z5Qd5DDJBxCGr/6w8yZWIPz
         nasqU54hRCQGnPxyGkwkxza1uKdwbdbPWjzgon268R6esgd7d52fk/pNZKpDrxP2xN3m
         Q/jLAZrVq3VRwBcflJk4ofm4IKDj9ACtvFCTiL2wKfrDLztV1aLQLZ5vW2WXr5GCGnQf
         3rsLO2hXPYg4SP2ddFp3eT4VB+7+RkNdP4baFVeqSXl08ZYwwzCnADrTcJsNRn8UnNdP
         3BzPbyEYGfMPdqmfUmhiLWO/qnyjLipKYG4CUJ4dKQjFljHwLDeGTeoPyRr4V187KB/I
         YR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779760316; x=1780365116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWSTvOF/gzpYSCqq/FR9TOCszX7XxtE0WLsWHlZ8hBs=;
        b=XG1AvKPxoObkiXEF1YuewyA30RvQxWYHQe64KoCMsJBofF6eG+rt7O6oeZwbaGRHkP
         LdBw7BwAxrve5L8CYEqbbUB8LX3Esb+2UkML5hAGHSB0kzHrvJ/EaORQQ8JlXQwAArtO
         kUCwQt9TbUP68FjEy9y6h0e0TeddnAYqvxlos76VX6oTDQfu6Ipl6uTIsIx0VfEzkSMI
         KRXstUPEBjVNhvqRuqEMjIHS/t1LdEt9iIeaugMuvmfJgb2Oa6Oo6XWZZ+0qbqaKXWfj
         kfywcMdi5CgwWjtGOvXcAilb8Ksr9b1tdx5OQf05X9ej9xvIyPnPHF9TaxruZxPyQUU7
         AhBg==
X-Forwarded-Encrypted: i=1; AFNElJ9OQ4rgtJ59sAdkDE7BQSmkgm0SpXkCf1wcWnlmHHR1/0N0uebsjTDu5PxDXMbXz5zxZVMbOE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTv/vQUsD0JAHy/Lmii4W0y6Euoia0iqxEqOxA8I34ULd1EM9
	oEH3EWiCfhIczOv5KAleDtewNW8ZsD4lfBcqd69Ca9Jo0mn8K8nYyDP7LhTJhCs/YImTd+Yv/KH
	Ejbp+ZA==
X-Received: from plbbi11.prod.google.com ([2002:a17:902:bf0b:b0:2ae:815a:73f4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:2b4:5aff:de60
 with SMTP id d9443c01a7336-2beb06fc2c0mr198171305ad.22.1779760315914; Mon, 25
 May 2026 18:51:55 -0700 (PDT)
Date: Tue, 26 May 2026 01:51:15 +0000
In-Reply-To: <20260526015152.2409183-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526015152.2409183-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526015152.2409183-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 3/5] geneve: Pass struct geneve_dev to geneve_find_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a prep patch to make a subsequent patch clean.

We will need to access geneve_dev->cfg.info.key.u.{ipv4,ipv6}.src
in geneve_find_sock() later and extend conditions there.

Let's pass down struct geneve from geneve_sock_add() to
geneve_find_sock() and flatten the conditional logic.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7e8c3023842e..4f841eced028 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1040,35 +1040,41 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 #endif
 }
 
-static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
-					    sa_family_t family,
-					    __be16 dst_port,
-					    bool gro_hint)
+static struct geneve_sock *geneve_find_sock(struct net *net,
+					    struct geneve_dev *geneve, bool ipv6)
 {
+	struct geneve_net *gn = net_generic(net, geneve_net_id);
+	struct ip_tunnel_info *info = &geneve->cfg.info;
+	sa_family_t family = ipv6 ? AF_INET6 : AF_INET;
+	bool gro_hint = geneve->cfg.gro_hint;
+	__be16 dst_port = info->key.tp_dst;
 	struct geneve_sock *gs;
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
-		if (inet_sk(gs->sk)->inet_sport == dst_port &&
-		    geneve_get_sk_family(gs) == family &&
-		    gs->gro_hint == gro_hint) {
-			return gs;
-		}
+		if (inet_sk(gs->sk)->inet_sport != dst_port)
+			continue;
+
+		if (geneve_get_sk_family(gs) != family)
+			continue;
+
+		if (gs->gro_hint != gro_hint)
+			continue;
+
+		return gs;
 	}
+
 	return NULL;
 }
 
 static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 {
 	struct net *net = geneve->net;
-	struct geneve_net *gn = net_generic(net, geneve_net_id);
-	bool gro_hint = geneve->cfg.gro_hint;
 	struct geneve_dev_node *node;
 	struct geneve_sock *gs;
 	__u8 vni[3];
 	__u32 hash;
 
-	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET,
-			      geneve->cfg.info.key.tp_dst, gro_hint);
+	gs = geneve_find_sock(net, geneve, ipv6);
 	if (gs) {
 		gs->refcnt++;
 		goto out;
@@ -1080,7 +1086,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 
 out:
 	gs->collect_md = geneve->cfg.collect_md;
-	gs->gro_hint = gro_hint;
+	gs->gro_hint = geneve->cfg.gro_hint;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		rcu_assign_pointer(geneve->sock6, gs);
-- 
2.54.0.746.g67dd491aae-goog

