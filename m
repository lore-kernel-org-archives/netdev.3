Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793737D13D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596830; cv=none; b=LGge04XJ+jcuw9TQz2wGK+opcb6l3URMpepsYLW7eiiTaAdbjUC5uPcFtKNHiXM42H/4lbAsH9ans3LLjMBIWcLvi8OWNQr8/Q0+OBLYgqTs4QRQnGVXqDw0DeCTI+rNEF4Lli4CF/T2mQ089nFz9hbWkxyAA1JWJXQ0pauIFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596830; c=relaxed/simple;
	bh=WkFdB7ktGo8Ohcm+AiZxjGM3gpHZ9p1SVWCAdzIQoKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVyvP9Gn8cjfm55/FqWUDQNgQEIse5rAGpJHp6nFx3RdmtSewD8Bzk/Q04k8DcIPxpnmVYqWVvlaALcogmPfdsNX1uC24QUAQjIqCjRpL2jD8f5S8ppIC5hmG49w0K06Yy9PExfiHOHlLhjHsP+Y44jwes/wMAaC85e/Bc/hNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ii5cHLfi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ii5cHLfi"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so12986247a91.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596828; x=1776201628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WbXWKdD/9YPvrCDd7kC3HwLXdwtJXHpbid0pCWFnhY=;
        b=ii5cHLfiwH7SJSXJrPtqk4xhYsFh/N8kJftaOWpqp/F9mIDWyoO/GvHHgiAf0u96Ef
         d2y/KcncGuilhXiYNd8Mu/WSoC/LI1/gardrFxiKcwy3QDMtNPZSNmuAYQyvBsEE9XLE
         bFqps5hory7uIzKr7aiXKrxT/FSzKnWvgqmXkKPsYFKZI/V170ROBlvvfd90fwR9/9NZ
         ZNRlJXAgXWPm9FjaMk5LmZpCOq1SKLWLKv0uLZR7dikz4AuIB5a2bQbJQUtT/juezSA7
         U6zEGxBMNUiFeJU2TUhmw9gLaFHz3NtJu0mSuI9NprEGPX43mvliG1ekO9PwuEeDPCvK
         lLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596828; x=1776201628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WbXWKdD/9YPvrCDd7kC3HwLXdwtJXHpbid0pCWFnhY=;
        b=B79f8pOTO9AeZ0u9oYSQll8/nQjP9xCxAx4aDY6S70+G5JFWndHEiVXebHcaF3XCI7
         Nf1Ra2XzXccRx+PMpcc/KsVb4Sx8kJzTPdg0vAWGDMYbCIG13JaMarLyu00cVl7uiAHb
         tdTL9uE8l7bIFvNhj14uN2MM2abRfANmiw8olUPpxOOcLXXBDJfEoblSB6/WXuwb9jas
         I7joxUUE2fVkMAlFNmP3JiCBeDxy+xlhRoXro8co+6q5GHxGkhzCLhpyA7JlEdWYhvf+
         Mw07ntYQwqCw4/xsUfaFG94d08Al/VLHwvLabdGy+tuuAQdBUHVyxPPEyt+7c6OXlue2
         KFHA==
X-Forwarded-Encrypted: i=1; AJvYcCU8OSr2/8nFMLqIWwE4N+nb173Pa9dplS/UyoKmulfYs62HiebbKkRrPLc6pa1ihqcVLTQxtS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7wdx0Rnm/S7NCB2jM1RtCvA/zHeVw//rSQu1ynluPoBQcl75
	bhS/oLeIK89/Mqv2wZ/kLoqxQm1UePA6M/HejohMf0slGye5vSBEgRrbnoomOF9qGPTTyFvy34u
	xHesDoA==
X-Received: from pjqs7.prod.google.com ([2002:a17:90a:ad87:b0:35d:9631:364])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39c4:b0:35d:a2d3:5c2e
 with SMTP id 98e67ed59e1d1-35de6956185mr18790769a91.20.1775596828018; Tue, 07
 Apr 2026 14:20:28 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:48 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-16-kuniyu@google.com>
Subject: [PATCH v3 net-next 15/15] ip6mr: Replace RTNL with a dedicated mutex
 for MFC.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip6mr does not have rtnetlink interface for MFC unlike ipmr,
which uses dev_get_by_index_rcu() to set struct mfcctl.mfcc_parent.

ip6mr_mfc_add() and ip6mr_mfc_delete() are called under RTNL
from ip6_mroute_setsockopt() only.

There are no RTNL dependant, but ip6_mroute_setsockopt() reuses
RTNL just for mrt->mfc_hash and mrt->mfc_cache_list.

Let's replace RTNL with a new per-netns mutex.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6mr.c         | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index df00567374f4..6453d70d5946 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -114,6 +114,7 @@ struct netns_ipv6 {
 #endif
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	atomic_t		ipmr_seq;
+	struct mutex		mfc_mutex;
 #endif
 	atomic_t		dev_addr_genid;
 	atomic_t		fib6_sernum;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b1443fb65b40..e4c31d05744b 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1256,7 +1256,6 @@ static int ip6mr_mfc_delete(struct mr_table *mrt, struct mf6cctl *mfc,
 {
 	struct mfc6_cache *c;
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ip6mr_cache_find_parent(mrt, &mfc->mf6cc_origin.sin6_addr,
 				    &mfc->mf6cc_mcastgrp.sin6_addr, parent);
@@ -1346,6 +1345,8 @@ static int __net_init ip6mr_net_init(struct net *net)
 	LIST_HEAD(dev_kill_list);
 	int err;
 
+	mutex_init(&net->ipv6.mfc_mutex);
+
 	err = ip6mr_notifier_init(net);
 	if (err)
 		return err;
@@ -1474,7 +1475,6 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 			ttls[i] = 1;
 	}
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ip6mr_cache_find_parent(mrt, &mfc->mf6cc_origin.sin6_addr,
 				    &mfc->mf6cc_mcastgrp.sin6_addr, parent);
@@ -1553,6 +1553,7 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 static void mroute_clean_tables(struct mr_table *mrt, int flags,
 				struct list_head *dev_kill_list)
 {
+	struct net *net = read_pnet(&mrt->net);
 	struct mr_mfc *c, *tmp;
 	int i;
 
@@ -1569,18 +1570,21 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 
 	/* Wipe the cache */
 	if (flags & (MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC)) {
+		mutex_lock(&net->ipv6.mfc_mutex);
+
 		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
 			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC_STATIC)) ||
 			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC)))
 				continue;
 			rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
 			list_del_rcu(&c->list);
-			call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
-						       FIB_EVENT_ENTRY_DEL,
+			call_ip6mr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL,
 						       (struct mfc6_cache *)c, mrt->id);
 			mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
 			mr_cache_put(c);
 		}
+
+		mutex_unlock(&net->ipv6.mfc_mutex);
 	}
 
 	if (flags & MRT6_FLUSH_MFC) {
@@ -1763,15 +1767,18 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			return -EFAULT;
 		if (parent == 0)
 			parent = mfc.mf6cc_parent;
-		rtnl_lock();
+
+		mutex_lock(&net->ipv6.mfc_mutex);
+
 		if (optname == MRT6_DEL_MFC || optname == MRT6_DEL_MFC_PROXY)
 			ret = ip6mr_mfc_delete(mrt, &mfc, parent);
 		else
 			ret = ip6mr_mfc_add(net, mrt, &mfc,
 					    sk ==
-					    rtnl_dereference(mrt->mroute_sk),
+					    rcu_access_pointer(mrt->mroute_sk),
 					    parent);
-		rtnl_unlock();
+
+		mutex_unlock(&net->ipv6.mfc_mutex);
 		return ret;
 
 	case MRT6_FLUSH:
-- 
2.53.0.1213.gd9a14994de-goog

