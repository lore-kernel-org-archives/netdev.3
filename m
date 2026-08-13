Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFD43F4C0
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608178; cv=none; b=MsAWsv0L9WkQpqnReGRNNu77NlYNgK4BhR/83ROqpe1LVsBLF8WUAsPnUazLjSajS7IpoACfQSoSebCLVZaMDxAcg4642FRY2iVvEBoV9LFno0Ld5GmBnNJsqGGNGtbYeHD57DQprVX5y0YmC4de2i5lwMZgJ0aaW3DdKuO4sh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608178; c=relaxed/simple;
	bh=zyRwRB9yMop6I+ZMMrCYAWXupTJTVDfErn7g98EpeUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D1e0H9zYXiR97SFxVtLFiAFxZpsZiTaBdyXxu8VBNZrqiFRlfjkmUB0WO6Bp+pF0RgRqnWZrQOsQ7OowslPjivTCYxIikR6LgBHK+J0RyC0rip+YAYOowTpFOCgRT8wgwvqP3sVkDPFr6KcNhe60hMAqJM7h+1G+6ErSkwAD0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dF9xoToy; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dF9xoToy"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so4252777a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608174; x=1787212974; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IW77I1eBsfNnU8piLEXVNQmDYq0kAT/RFknBSpArlvw=;
        b=dF9xoToyw0yvWQB6Q+lb5sc3ocxmBSlAq2FAcmCOv5v0TL1aYqv4ZebMKAmJYDL1BT
         BamviXnVrkRI2zXE8BExnW2D7GWjgvOZqmmclniALEYXSmGJDYCrf+Rp2uELNeOKg4kE
         0yCjPWsiJze7jqwxqHGgY0ZaNDRb/wzJ6nOEFNfbonX7FguTYYKtPACoNLJIbw6Oy6o2
         WHin4sDclD5aFV58xKKY1hA+eyuFHAeeHYIUjtqN1tyZ02DaQXYEvV9txAtrCbqabeGV
         t2/FWpOzJ2HM+fvsWTI6YrOzOl+JxVPEvNDLsB795DUiiPmtONnHugjJa57rWV8RrRjl
         ztOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608174; x=1787212974;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IW77I1eBsfNnU8piLEXVNQmDYq0kAT/RFknBSpArlvw=;
        b=ErWu/C+u0W/bhv9358CDo2dbjJWIPMVOilqNdJeZKzSygW17dmo53wQ5sDmfMfQeQk
         JaZNwrOI0I/QPHNHcD9dTK2ll8eIqmhIVGmeuPHkUcMSq8/6rIWcsSP1Glof2ZqQZuQc
         zWC23eiSKvvwyZ0sygTJ1yfuMnqm3DuL+shdnhXaztXLA9jMRalMHvyLg8wEEXa+6QU5
         PZf/dBx7iWNa2MQ+UJEM/J9nMvpfKyQuP4bILELa2SijKTtqjFXpEJdrxpotn/x2eZI1
         Ff9qv8ggbYieexNISjXKfadAdiW+ca+NKPWPYr66tUdxXfSoaiXmmL+CLam+N1jJwV2q
         DN1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqFxOJnhxk7AfuMA2wNN7TnRoeerhpx+cbkhBH2IqMU4WTfu3R23VSJUgyZll928DMGPbwxJ24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoopkvjSoMRq2IKqU9pSoNzDUE1hsx9SujnG13WP28m9Nif6NC
	Ht9KKsWjh8sL0ketOOWYUTw1i9tmfYF+jGnz0K5pCAgSaAVe20Zh7nb1eVlQL3dMcvnZzDM1464
	VRfXoCg==
X-Received: from pjbbu9.prod.google.com ([2002:a17:90a:ee49:b0:38f:659:4491])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da90:b0:38e:2f21:3bb5
 with SMTP id 98e67ed59e1d1-3931e3a41eemr5288020a91.21.1786608174313; Thu, 13
 Aug 2026 01:02:54 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:19 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-6-kuniyu@google.com>
Subject: [PATCH v4 net-next 05/15] neighbour: Remove __rcu from neigh_tables[].
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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
2.55.0.691.gc56d675ccc-goog

