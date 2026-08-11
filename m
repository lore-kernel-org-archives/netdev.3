Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A660392C24
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415109; cv=none; b=A3xiViNPuVPUcsUMR9XdnFJUGaCQr7hPVy8Yp8xTBOofhjGzr9ydW1GGs3y8+l9zqZwtuf7hXG8kD5xL8xGTLF0ZoQwXg5dqOsGG0byewGZGaO/rqHMWFVQKC4NC/SYYvsxjLCyrDphZHTPYURx1gG55IwwtzVrXIYP4FtU7TsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415109; c=relaxed/simple;
	bh=FJ4vtO2wNxkQZgQ1cOzXMbTRmHreIBhJs8p7W9XlMBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRI3tt5XRtygAQYUniVQtYPeMFUVEj1byBXbD5im/swoTBEV5e2jmIBz2PfuoCXkicq/3dTvIKlsMsLADb33EYLfqeEheaOeDKyAxoXbiEPQEPP6+vvHzZnS14zhGkghM8l8W4hsdl2HRXtbUOsKvKBKZXu2RoqB1WUV50gCgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFR09G7W; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFR09G7W"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so467920a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415103; x=1787019903; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLfLeE8kWjLAfopE7xVxnDAL9Zp1JOAQGlwN9GWFL2c=;
        b=wFR09G7W2yUy/iDtzro2xLGKYE/uGoaC9GXwTGQh4cdJoyAFreFgip7GQ2zkusx8ON
         +1+w4AEWgEAv6qkBCEmE1/vCKlQt70itZBpWVyBDTrfVFDTqobQ/HuZsgO9hahbviYsf
         EIfim63FV+cUwYcxu+w3v/E/Va8jYkq5ajcao+U5wtFwYijVhWQxn2h9fHUG357W1kL7
         Dyl7eAGEyLYRgD5fKKB9EUIYQmv3Thqni3oW8F6krZfM5VTFPt60+lII2Tnzw/DTMoeu
         0RrbgYWHjNa7Qir/1g9MOUXNoN2zOGktlQCMEUpDucW5fXySacdAqda4egrAzqpJyxI0
         RMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415103; x=1787019903;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLfLeE8kWjLAfopE7xVxnDAL9Zp1JOAQGlwN9GWFL2c=;
        b=sVA+eh3MSM2CwmDQg6sYEP1s8ebI9ygmACoT8mnCrV06iIXOTIEtIXTT0CIPlarwVE
         WWA90+iJ/0hzkznwpFcfAJvH01NyaiVMezc/+iQ0SU9RGlPNF0zALrsvkzspYyi40n98
         VrzbOaCP4Tbwh7y6LJKLORfhKtAoPwmdceZlNZa24hOrmGfVVofvtbdHbm4MAulCVSJq
         xPuRQsymAKdlx6huFkDXn9N9H2wshMU/EZeuzODxyHb5zzE3+dpa3Pm5ZwFPE3pXbJvR
         QLpzKElPYmu4I0+XWLnlEPEXDtz38WFKRUUXTHMnQ8kGqzLRRB7u3uJeFIpluYENbcnS
         ewww==
X-Forwarded-Encrypted: i=1; AHgh+Rra3raejTceGHckcA6Ug0R6tc47wS5BnKkYTVvY87HJ+/mcMa8NgPhHRxWKd5+ACPvcIiUztF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGxVXuk3kc6oQkt8sq1+bn0uTuKmJL8YtCV1yQCuHVgicN3+E
	1aAUvxYmAbRVhYZeDlNAyzNZEdFVDRaTbaUwoY5iT5rzP6k+jPT+cFwatWA+uMo43yxAMw/LiiT
	27LUzpQ==
X-Received: from pjbcv18.prod.google.com ([2002:a17:90a:fd12:b0:38e:7f2c:2c4b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:43:b0:38e:b3fd:d584
 with SMTP id 98e67ed59e1d1-392d61ada4fmr1249956a91.15.1786415103346; Mon, 10
 Aug 2026 19:25:03 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:48 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-15-kuniyu@google.com>
Subject: [PATCH v3 net-next 14/15] neighbour: Remove unnecessary net_eq().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_table is now per-netns, and net_eq() is no longer needed.

Let's remove them.

As a bonus, each netns can configure the default table param
(ifindex==0) and GC parameters via RTM_SETNEIGHTBL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Split pneigh part into the prev patch
---
 net/core/neighbour.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9cb8e68246a8..07c62268fc3b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1746,13 +1746,13 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 }
 
 static inline struct neigh_parms *lookup_neigh_parms(struct neigh_table *tbl,
-						      struct net *net, int ifindex)
+						     int ifindex)
 {
 	struct neigh_parms *p;
 
 	list_for_each_entry(p, &tbl->parms_list, list) {
-		if ((p->dev && p->dev->ifindex == ifindex && net_eq(neigh_parms_net(p), net)) ||
-		    (!p->dev && !ifindex && net_eq(net, &init_net)))
+		if ((p->dev && p->dev->ifindex == ifindex) ||
+		    (!p->dev && !ifindex))
 			return p;
 	}
 
@@ -2475,8 +2475,8 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (tbp[NDTPA_IFINDEX])
 			ifindex = nla_get_u32(tbp[NDTPA_IFINDEX]);
 
-		p = lookup_neigh_parms(tbl, net, ifindex);
-		if (p == NULL) {
+		p = lookup_neigh_parms(tbl, ifindex);
+		if (!p) {
 			err = -ENOENT;
 			goto errout_tbl_lock;
 		}
@@ -2557,12 +2557,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	err = -ENOENT;
-	if ((tb[NDTA_THRESH1] || tb[NDTA_THRESH2] ||
-	     tb[NDTA_THRESH3] || tb[NDTA_GC_INTERVAL]) &&
-	    !net_eq(net, &init_net))
-		goto errout_tbl_lock;
-
 	if (tb[NDTA_THRESH1])
 		WRITE_ONCE(tbl->gc_thresh1, nla_get_u32(tb[NDTA_THRESH1]));
 
@@ -2645,9 +2639,6 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		nidx = 0;
 		p = list_next_entry(&tbl->parms, list);
 		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
-			if (!net_eq(neigh_parms_net(p), net))
-				continue;
-
 			if (nidx < neigh_skip)
 				goto next;
 
@@ -2825,12 +2816,11 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			    struct netlink_callback *cb,
 			    struct neigh_dump_filter *filter)
 {
-	struct net *net = sock_net(skb->sk);
-	struct neighbour *n;
-	int err = 0, h, s_h = cb->args[1];
 	int idx, s_idx = idx = cb->args[2];
-	struct neigh_hash_table *nht;
+	int err = 0, h, s_h = cb->args[1];
 	unsigned int flags = NLM_F_MULTI;
+	struct neigh_hash_table *nht;
+	struct neighbour *n;
 
 	if (filter->dev_idx || filter->master_idx)
 		flags |= NLM_F_DUMP_FILTERED;
@@ -2842,7 +2832,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			s_idx = 0;
 		idx = 0;
 		neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[h]) {
-			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
+			if (idx < s_idx)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
@@ -3247,10 +3237,6 @@ static struct neighbour *neigh_get_valid(struct seq_file *seq,
 					 loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
-
-	if (!net_eq(dev_net(n->dev), net))
-		return NULL;
 
 	if (state->neigh_sub_iter) {
 		loff_t fakep = 0;
-- 
2.55.0.691.gc56d675ccc-goog

