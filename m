Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8372427FA8
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145386; cv=none; b=HjwAhBZ7znu27zsuMhp/zXxXCdc0dFPpITwvNiQbm/BU0NDLfyRjbnu879sFYZAv7Os0N7NHHsLqFw/S2Uc610BD6uJW4BKE2jMc/vDOoqbjqpkWl5h3PGFOqtosIF2VqvG8MYp+zRJbDDVqTE1nDH+gw/4MEYQKfMyIZVukiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145386; c=relaxed/simple;
	bh=xkMs1ottVDa7T2Qr33twwwvPlkGXfQVCcJz3LAzjYrQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SXuwc4Hq0fK2hSIygMdsPGDoL4m2sNaqTezAB7kD/JcljrFaBjqZNSSUtrewhbFc+t7OirrLxmHaWSGYmESEuKoyN+wxGHAUmWAmseQRsx8lMJ0G7hZOT3sAx0DAmhUVbGDVEcr4CSRaYnEpREiX953UKFEgSKEguF9eOIP2W50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EExbEDoD; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EExbEDoD"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e04598adeso42907b3a.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145384; x=1786750184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OjTlp0SluaOs5k2MAx4xnwS10zBMIH4AOWKtZRR5WFc=;
        b=EExbEDoDYOg62ULucb2gPFLKZcO5vzeZwQwDThFIT+7JsBcSEh6zgHec0SdIxrW83W
         dHg4YlAJop0IPsw8J/la10yejNPlaoZqWCvzrj2+n7tV/GkdV36y2+coQYZAD7vD6G3g
         1ZnZUn32r2IiptPbP2z2pbv1g4qcYqXQ3GV8hzvKDUiwkEyybDlYHgxblerJ2kdW188v
         4rXvFDaVq/3Mrs7HprnXLejdFGI2eMT2blXl7arjfsSpNdPqMyjp5pmGYmErHH/WQIzs
         zK97xbcltQ2fvAgQ96/0JEeg0uMf53LPUw5AqxPM2cfeeASMc2J87wxEbsO0s80Qj/ca
         fzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145384; x=1786750184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OjTlp0SluaOs5k2MAx4xnwS10zBMIH4AOWKtZRR5WFc=;
        b=oD3wxVs+RqekRMsd8kpUieOM84d5CvDAFnGTnLcXfA5UBpF6zTx6A1JV3fCOKlXp/1
         CHi+HLXsR/iUic/dzv/QxuC6i1cv+kikZYq9Zx0VDbK4EY39FqdN6qJs/V1D1HRSb04r
         Pf3XLKgLJt8CWLVkh0xNlpzuVLByh6qrb4jf2UyCQhEWy8SWhl6RCYnLYILqsSPZGBHp
         rcZF4PP1c0uG7vYFy7vpjtWR0rN+nPra4WmzcTX792hHd0maB444wLOYqCaj/hSJASe1
         gbQu7F+/03qdGvLitirgB0MUptr0s1Hkg2aK5+N4WM4OV/N6LgAWPiV9eEKO63fET2Qs
         BrgQ==
X-Forwarded-Encrypted: i=1; AHgh+RorMcduV8npLFbBg1I3o+X5UULcOfTQw5cqSnBaFaNUDAFcM5PLCsi90+nvON8kw2GO5W1Pwy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdZVuj/wmU/zn+X6aQ37Pc7ujJiYDble3eT+anjuYTf628nq/
	Y6eV8qZqx6pvbbN0VTHyeJxwH6T+NbKrOOddhUokOI2IEW8doXXxoaZNDKDbYI4zlaN4PcjW4eo
	3PtUESQ==
X-Received: from pgct6.prod.google.com ([2002:a05:6a02:5286:b0:c85:98b1:c613])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:399f:b0:848:42a7:1854
 with SMTP id d2e1a72fcca58-84f4fee21bemr14065202b3a.39.1786145383945; Fri, 07
 Aug 2026 16:29:43 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:50 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/13] neighbour: Remove unnecessary net_eq().
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
index 23ce17de23e3..e22b0fe4b952 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1732,13 +1732,13 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
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
 
@@ -2456,8 +2456,8 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (tbp[NDTPA_IFINDEX])
 			ifindex = nla_get_u32(tbp[NDTPA_IFINDEX]);
 
-		p = lookup_neigh_parms(tbl, net, ifindex);
-		if (p == NULL) {
+		p = lookup_neigh_parms(tbl, ifindex);
+		if (!p) {
 			err = -ENOENT;
 			goto errout_tbl_lock;
 		}
@@ -2538,12 +2538,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 
@@ -2626,9 +2620,6 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		nidx = 0;
 		p = list_next_entry(&tbl->parms, list);
 		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
-			if (!net_eq(neigh_parms_net(p), net))
-				continue;
-
 			if (nidx < neigh_skip)
 				goto next;
 
@@ -2806,12 +2797,11 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
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
@@ -2823,7 +2813,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			s_idx = 0;
 		idx = 0;
 		neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[h]) {
-			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
+			if (idx < s_idx)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
@@ -3228,10 +3218,6 @@ static struct neighbour *neigh_get_valid(struct seq_file *seq,
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
2.55.0.679.g6767b8d81c-goog

