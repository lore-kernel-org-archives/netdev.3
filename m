Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9F3F6C30
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145379; cv=none; b=REWYs2vqdfKRpHJIP4VjwyDjIvSgV3NLDa+iy8Tr4zrJK+wqMypLoFtxgNwKUvMzv5UiKOqfGy6S0YT1ZVsHmNkiZiWtMQQXRJLAsorYu9+Fy3FdoafjUv9Hqg35AsejFC82gr4rBngIhHk1lqcxwf0EXk55UsiRWXaSTTAfRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145379; c=relaxed/simple;
	bh=/qV5nBMFZ2u98bH5w7ep3pj2QnMy0NDIwk/23158QaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bt8ooDG/kDqy3Jo9AIuCyGJ2TMXrHmNDrlqWV46tsY2M6vueyedSkO84lqzGWqD5EtV+bjHAjTQTNQXKlmD1gmQ+c+hB909c9vU6BtVD2eA611OPpWaNepT+u4F4rp3skq70QSd8Nqe7rbbjjMGw+EFrEuSEbatApKFYE+6e+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wADmU2lM; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wADmU2lM"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee894b3d8so2287015ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145377; x=1786750177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoYTb8KB4Jy/KXaGS/2PJDBS86ktfGanr8KqkA+uIP4=;
        b=wADmU2lMKjzWx3d0WyZCUG+08ylbld4dNOQGAHLfhs+H3Acy4fwE3Rm3SctejVZv0n
         zI3Px+2jPglGTFbooTvIP8dsBfh4zcx/bHzkJuCT8ImsrhKfrRGBUCJiVYwkEXcCsrOf
         oQXLZOGHz3+riEQrD1vvfF1g0d64/fmabkofZWVZViJfAMFbhBumIWMXpIBvLs/wtLHb
         XKqjO1re1DyiIksETquraQuhPDfodoOzHRh8eX41Z5ur7DPRwvNWFBqo2v8nmeeEgNEn
         tYEeubs4GDvnmHvBdxDOmQMWTC8/TaPDykOHjykb2JxUjGPAMt4Q70iNUceSvnSLXsEl
         m6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145377; x=1786750177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoYTb8KB4Jy/KXaGS/2PJDBS86ktfGanr8KqkA+uIP4=;
        b=deZ8ut4Sr6EQZBmSayEDXsdmy3Q+acGStXNXw5HKjEuP7+Tc9tvRooP85J8rGxvaP5
         VbCVhgDmiWxYpt/OEBmrxyIsD5suWYuIR24eaaZHDLgRyMv8MlswwAoIqOw7Gbr/5JgN
         jUsH9bLtRik2D8tKkSPza9aKPT2MHu32AHhJ6eIG9o1UBqRISbNblGXQGf+kVdIBX2bx
         HcDC/bBMdU/aYkBki1cYdDay+ZCM5bpBbBm7VkyyHva1C1zRNoSgAoL9ECqpNimNNzNp
         Dwp6tIxYTuLdFt/oC6yNtcLBrfgwYi5o+lC4VUgAkHjO0b1A5HsNsIfCwxEMlF8ympVf
         TS6g==
X-Forwarded-Encrypted: i=1; AHgh+RpEQ36dkjtUqSLuLZjPY6jhzi2FhGLf/ckyn48cDJ1VtnH82ivlUNRl4LSkqZ6uw1wGeK0GDeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJCSSW1KmfLbHkUiDNYHrFVu2nGMWXfJsrlXy7rCB0kzkp4vu
	ML7de6VHejHqnvQTzcDH4qt216oMyOfDpxO1o2h4cqScueLyP+grrRHHoGHiVzU6dkV7ZyKC6ez
	1Zsy2JA==
X-Received: from plao6.prod.google.com ([2002:a17:903:3006:b0:2ca:d6d7:6943])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db11:b0:2cc:1452:a014
 with SMTP id d9443c01a7336-2d2a8e977bamr50484995ad.18.1786145377258; Fri, 07
 Aug 2026 16:29:37 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:42 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/13] neighbour: Remove __rcu from neigh_tables[].
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit 1bf20cc62a54 ("neighbour: remove obsolete
EXPORT_SYMBOL()") unexported neigh_table_init(), neigh_table
cannot be registered dynamically.

Let's remove RCU protection for neigh_tables[].

Note that neightbl_set() no longer needs RCU because it holds
spin_lock_bh(&tbl->lock).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6fda0052027b..caa52bf64a2d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1807,7 +1807,7 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
-static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
+static struct neigh_table *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
 
 void neigh_table_init(int index, struct neigh_table *tbl)
 {
@@ -1864,7 +1864,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 	tbl->last_flush = now;
 	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
 
-	rcu_assign_pointer(neigh_tables[index], tbl);
+	neigh_tables[index] = tbl;
 }
 
 /*
@@ -1873,8 +1873,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
  */
 int neigh_table_clear(int index, struct neigh_table *tbl)
 {
-	RCU_INIT_POINTER(neigh_tables[index], NULL);
-	synchronize_rcu();
+	neigh_tables[index] = NULL;
 
 	/* It is not clean... Fix it to unload IPv6 module safely */
 	cancel_delayed_work_sync(&tbl->managed_work);
@@ -1906,10 +1905,10 @@ static struct neigh_table *neigh_find_table(int family)
 
 	switch (family) {
 	case AF_INET:
-		tbl = rcu_dereference_rtnl(neigh_tables[NEIGH_ARP_TABLE]);
+		tbl = neigh_tables[NEIGH_ARP_TABLE];
 		break;
 	case AF_INET6:
-		tbl = rcu_dereference_rtnl(neigh_tables[NEIGH_ND_TABLE]);
+		tbl = neigh_tables[NEIGH_ND_TABLE];
 		break;
 	}
 
@@ -2391,10 +2390,8 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	ndtmsg = nlmsg_data(nlh);
 
-	rcu_read_lock();
-
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
-		tbl = rcu_dereference(neigh_tables[tidx]);
+		tbl = neigh_tables[tidx];
 		if (!tbl)
 			continue;
 
@@ -2408,7 +2405,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (!found) {
-		rcu_read_unlock();
 		err = -ENOENT;
 		goto errout;
 	}
@@ -2537,7 +2533,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 errout_tbl_lock:
 	spin_unlock_bh(&tbl->lock);
-	rcu_read_unlock();
 errout:
 	return err;
 }
@@ -2589,7 +2584,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
 		struct neigh_parms *p;
 
-		tbl = rcu_dereference(neigh_tables[tidx]);
+		tbl = neigh_tables[tidx];
 		if (!tbl)
 			continue;
 
@@ -2949,7 +2944,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	for (t = 0; t < NEIGH_NR_TABLES; t++) {
-		tbl = rcu_dereference(neigh_tables[t]);
+		tbl = neigh_tables[t];
 
 		if (!tbl)
 			continue;
@@ -3162,7 +3157,7 @@ int neigh_xmit(int index, struct net_device *dev,
 		struct neighbour *neigh;
 
 		rcu_read_lock();
-		tbl = rcu_dereference(neigh_tables[index]);
+		tbl = neigh_tables[index];
 		if (!tbl) {
 			rcu_read_unlock();
 			goto out_kfree_skb;
-- 
2.55.0.679.g6767b8d81c-goog

