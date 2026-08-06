Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF53B388E
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978720; cv=none; b=LVZaufh0QeZG3gcj2Pd5QOqNniVvFVCviNlrT93zHpPK4NkeljUcL6/5Fi1ZaGG7UQ70+3ZyTa9QKS7u+4tvuIPgzRAYhEhHDWJS+cEccmHCnicCwNiTSpK8U9iFjMMsSFtavc/mUBJ0qaN/7OeK/5E2RcWs+oeA0WzlNSAmuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978720; c=relaxed/simple;
	bh=GrLSpPAUUJWqg3BsT0QHw6tXGTYenRVD7IL4Kj1iY7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mfet744pdODpKiCDSrYyhQzKaqcgwg9icf1ZlCjjeZihkBD6DzMxIcxfZtYlvWKO3eHhXGVp7lIwyG87P+CWXjxqFkB00ZfjxUKJLG68SRMNfV/yOg6danyPAM61TDNNoeIU2ltAwgTCMJxL58Tr3/V+pj5Oaak1Dv5BQyk7VmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVPQiAvG; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVPQiAvG"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso2038529b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978718; x=1786583518; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oIohbRbvXz9kIJzbDoWhXsSvo+cpbAQ9HPWSY8ee08A=;
        b=NVPQiAvGtmOOX9wYU06y3c9O7wgTWV9hBlYGQ63cYbo/1ocSFUenzbFB/9eqszWdYy
         Jc3bN4oLGw3gg2OmM16fA6+68LsJ4s5heegLougP4oL81+U3IB9/ziVs76MvHMDRL0tI
         Mgg4MzUkXHW6KySMwBUTfDl3SBSFPXwdE4AJxax0IAQH0JbkBCsEzchOeiiCxkYbg6fA
         WR1zfB+rXARMIV3eYcJmOkl8vAvLm6StxhcHPlEUx0+KY/IrMyrO7BAKbKxT1TIS9IUL
         v6t8YWyJN9KDVzvXF9w4bt3EgvSte/f5D/lakqIDqppA7fXIeKyiTtocFUwbdFqw6OPK
         w3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978718; x=1786583518;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIohbRbvXz9kIJzbDoWhXsSvo+cpbAQ9HPWSY8ee08A=;
        b=SJvY14QdId4OXuDfcyJag9LHSCv6wKnhOwKW5j5XKSpJ5m0dpWRJ8MaWoBRsw5e3y8
         EU4lWnkXfoGoakw3MRUcTbepHV0EzwC4jFZ3gC51Z0JIqZsSi6yRir18HezQXgxRWNDY
         FYuDBXzn5wJIBf/SzxtpkRpgV1u47abM07AFIFuM3IfIzLJhqKSyPn+8oA44AoJtpBO2
         cfelPkPIIUN25NBNAuIyE7FjjUUrw8J9sL1wkZT4nSiM9E6K3o5zko1DTwneIQHuI30p
         mxjLE0qgEOjLLZdP8F9oa2qTjl1vPjejgw3/c9MNjqhTbQfVTLLbeQp44RCavdLiipCb
         /2eg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3rexi+GKR/byRhXqY4Uvu/7+wG6zypQrdEc0NYx99YfkMCeH6yHxIUfYvxa31NJ0+WIz1zuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHpl5E3AazRF/c3ClXdneKeXrmueiFJuNxSy2db38XKvdP06H
	BwZivZN67kPBVH8u4LPYiw8mgW73Led4u9lhPrEcAVy3HXqRm9AR9aaez1ZfYTRo6BDTvFa1Jyg
	bZSDBMg==
X-Received: from pfbbu11.prod.google.com ([2002:a05:6a00:410b:b0:848:8b16:23d6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d81:b0:848:6c9c:4074
 with SMTP id d2e1a72fcca58-84f2dff6cd5mr11490330b3a.1.1785978717742; Wed, 05
 Aug 2026 18:11:57 -0700 (PDT)
Date: Thu,  6 Aug 2026 01:11:26 +0000
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806011152.1170012-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806011152.1170012-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/11] neighbour: Remove __rcu from neigh_tables[].
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
 net/ipv4/arp.c       |  3 +++
 2 files changed, 12 insertions(+), 14 deletions(-)

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
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index d409f606aec0..66063dd00aaa 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1495,9 +1495,12 @@ static const struct seq_operations arp_seq_ops = {
 
 static int __net_init arp_net_init(struct net *net)
 {
+#ifdef CONFIG_PROC_FS
 	if (!proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
 			sizeof(struct neigh_seq_state)))
 		return -ENOMEM;
+#endif
+
 	return 0;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

