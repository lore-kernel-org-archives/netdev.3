Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213D3290C7
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381504; cv=none; b=QIlIGYBog0qwAq786aqGyjWxAPvhkM8ToCavI04WcVaL4tFMKopKX0grZbxGqs4fev5DGHsBj8kZGl9UkLUajA80li8xF31xT04M6T1zzTJNRT9+N1QYkw/1bt3MfiU2vTtYCE54q7gRYN+7oWSCtG15359KahwJrX/naEEA7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381504; c=relaxed/simple;
	bh=GaR4asFVTy3A0QvV5hdPRcuMChSTjfIHcw3y4YQoI00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mcewu5h+TAK3OidAXVnT1kW34crtZigzgG6wycOVtXMOKKhZL5d+8zdrADk1ZyraPYssmgvf1ZZDlIdr4yHIBMN25wrrYJddj/qyAB8K9OF7k1rSphj7BvAsqYJFA9cojCorCkn6Hls7xbLyUaWPb2N9pfrrJ0p7jnJ6REoMI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uixDkaei; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uixDkaei"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-855315ccb64so1332001b3a.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381502; x=1788986302; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x4gLp4lSBmusCMIgV4EPnt/Bb/+fQplPalF7+f7iaRE=;
        b=uixDkaei0+Bbu4paU777DFfp/qVide1PdA06rC+N5+9IHXdMsrLthXDBexrr6Ek/WZ
         +uN/gtWI/Vr+rXpXi4lw0oWPWwtTgB1/Fz6HUev8lEApOFNQHOUSmbtkrlvZKARuWpXQ
         72FARBkKl3pJqEJ+OKdPnD6FXhLp3h7/ivxDOutDz7Sv4zIBf4/UlUaiV4Y2U4tCbUpt
         H0L50R7q9gONzGfJye9kMGxLBDJHCFJ30JbvlfGVYvcowuWhyRJL51mlc35oAZEfT6CM
         wXvTNCqhp9ZCx84dfbMHO2rRK3gojxLpheWXfINcx0DsWrZpTrDwS5sZjGQJdIVCfPk+
         NmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381502; x=1788986302;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4gLp4lSBmusCMIgV4EPnt/Bb/+fQplPalF7+f7iaRE=;
        b=jUr+ngQpGuC7wa3YI19aAXdLxO5/aTznNLFhMNpR7rNgNFkdJo7LRmQoy4mTs5nweX
         aY6U0gC82oxofLiw+Wblx2q2m/p7HkMbep2/oSjdEpQu2zs/zwGfB/kI9aCKdmbqzhFz
         g8QFh8aFQ0bs3JOWp4PxFvKSn8TsAK9A5Ik+iYS1tyzJmcJmWUgbTXpiH3gpZGk9+rzb
         RHiDYEJlmaFA8gfpxDz9+AP6dZD6qkY8q8Ti/3W9WTFC5RfXNQw3uu3tWKUlONT2JLbx
         l1CJ9QyVmvHPrHjp6Fbr4b+g2jdX9aZYsTD1GPpW0txv6lV1IVdhHdHT4C3w6IaYz4nk
         blQw==
X-Forwarded-Encrypted: i=1; AKwUvBxAIiYayiIgq1FZAyJWAkOW1M151JTd1NbUhW5j/HeI43q9Po/4xsxCTB3vSNEJ674E+qAkFeo=@vger.kernel.org
X-Gm-Message-State: AFuF++nibuuFUg/woiPvkxldPX5oGIdxgepVKeyB89ro3oehLWBAcbv5
	p0fGHyQZ+T2nMdjbRXw9XGcuCET/O0IJSSRfKWTkOKh3BvbRV0/BjKNK63nuViNGgzrD9rEXI1/
	bem7GVg==
X-Received: from pfst14.prod.google.com ([2002:aa7:8f8e:0:b0:848:4fa9:d9d5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10ca:b0:845:e7ee:eae7
 with SMTP id d2e1a72fcca58-85ed1b0dee7mr9924968b3a.5.1788381501496; Wed, 02
 Sep 2026 13:38:21 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:55 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-15-kuniyu@google.com>
Subject: [PATCH v6 net-next 14/15] neighbour: Remove unnecessary net_eq().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

neigh_table is now per-netns, and net_eq() is no longer needed.

Let's remove them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: Split pneigh part into the prev patch
---
 net/core/neighbour.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9649b979918f..27602bcbeb69 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2662,9 +2662,6 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		nidx = 0;
 		p = list_next_entry(&tbl->parms, list);
 		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
-			if (!net_eq(neigh_parms_net(p), net))
-				continue;
-
 			if (nidx < neigh_skip)
 				goto next;
 
@@ -2842,12 +2839,11 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
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
@@ -2859,7 +2855,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			s_idx = 0;
 		idx = 0;
 		neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[h]) {
-			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
+			if (idx < s_idx)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
@@ -3264,10 +3260,6 @@ static struct neighbour *neigh_get_valid(struct seq_file *seq,
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
2.55.0.970.g62bdec98f9-goog

