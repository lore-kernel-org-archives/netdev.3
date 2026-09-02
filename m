Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DD4A9D4E
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381468; cv=none; b=twqBwvMMGbrz1dfMURoauRvRcf/sAijXg8qTDA/98ZnyMQo50F1Fjf4SjeBtAMSj7QuOnkOc5hUbCsa+nSnsT61jlbbHYEGM04s9+wDiyRusQaRfMDayNX8TVsBJcTcLUgl/mGZnhy6z2dViuwE9m8gVjW+cWAI7GKeAH+UCX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381468; c=relaxed/simple;
	bh=ha/UC6LNs7GEzoCFkd/xjLbMZB7B7/fgawiv/nStdIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nNiuxObODgT0TJAIVDLlq/7fy52Dyj9PVK0dE4FT967YXA+5hihzPuVfi3MUpUtW9cWKBaOldyRegw2tOr1RTRGMr7dd21XL3jLWwlkGt9JeM6IdVNiOFh92CCA/8rdWznbd5JPsxHnLjUTxsO7zEyuzQD2ZQUWXAKP6ML2DSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NI6F3gbE; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NI6F3gbE"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d52734fc41so28796655ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381466; x=1788986266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHKR7JwSGNccKI9dlanZy6e5APS/EKMdfnCJ27K1eqA=;
        b=NI6F3gbEieJA1f7cpIMvFDDpZM9Lj4ni5fGz8nvfJLZPuGG2c4/bWuRWO88J1Yi03a
         ZAKzkoDxirufBeMSHLOl5V3Yl+/M3GCBT2wMQqT5Po14mm8eArjUNykU5xNV6wM9cHH4
         0KwMEitiTNQ5UCYFxlwGXbZgZncEQYAldaxYdm09F5kfpLnrpNvKRdvom7cPr39iY/OY
         FHhKuVqKPvlMxI/La0DF1rICp4iQuxbbKAhviBBjCVBHnRSgEplJ5h0bYr4mA776IiGf
         WVyoKbMTpplMGnhDKB6NLBNOhQuQEFo1Cd0yzr3aRb5S31rTjgAnhTEsSZzW+LvQ7AXm
         TavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381466; x=1788986266;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QHKR7JwSGNccKI9dlanZy6e5APS/EKMdfnCJ27K1eqA=;
        b=N4wfwk7qdweWZaHQuGRwgK0NsW+bk2pJK5oheJQaPcNw4w9FR7L/fk84pGzwtHn5TO
         tcgJKvMnK1TzOXmA9l9MJ/Io+iJowZo3GEpahLfSrVVPR55BCs7FCZr3bGTmKbJUXRYW
         yaxOqKj758R4Lzq5BNhsaRUCOuUS2+LnfiowVfSbp1E+p4Y9wXMXViZqXYlL8tFtTjha
         JmO+DC/190HuNKFhFgS3h/bGOFm17xymv+5N5FCIUcR2n2Ky7uU8NWMLYoKA2vYpVN08
         PlJY7e2T0cLFUp+uI1u2zzfl5fWqJwf8JbmoOlsdAZXhH44lf6ugPdt/z+rxbvtkKYqZ
         LT7w==
X-Forwarded-Encrypted: i=1; AKwUvBzXHEZIM5WA48+ZRmDFaTAfm1J/DM4O2GcrBelD3QmbtViXzZMFFDqHW2fHlnBOND9u0U2v5yE=@vger.kernel.org
X-Gm-Message-State: AFuF++koGK/kAVJQTYLu88wZuC3otTun+su/PZSeEs894jMnn9lthmw7
	u2Sx1YesE9ICkIoKqK0948jRzFScIVfK/6yo1bqB83EU2kqcswy0Ji/7muZg34Ye0f5NbW0iX45
	iKkKW7w==
X-Received: from plbkp7.prod.google.com ([2002:a17:903:2807:b0:2d7:3fd9:1879])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a68:b0:2d8:d4d0:7932
 with SMTP id d9443c01a7336-2daec7a260dmr99079635ad.22.1788381466121; Wed, 02
 Sep 2026 13:37:46 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:46 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-6-kuniyu@google.com>
Subject: [PATCH v6 net-next 05/15] neighbour: Remove __rcu from neigh_tables[].
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

Since commit 1bf20cc62a54 ("neighbour: remove obsolete
EXPORT_SYMBOL()") unexported neigh_table_init(), neigh_table
cannot be registered dynamically.

Let's remove RCU protection for neigh_tables[].

Note that neightbl_set() no longer needs RCU because it holds
spin_lock_bh(&tbl->lock).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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
2.55.0.970.g62bdec98f9-goog

