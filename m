Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413B49EC53
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287623; cv=none; b=D9mUz8+RBzw5VMJwLTVcboW4KDxoNpNGooL0fpJmHJyWi/kJnwBtvKhnUmkPic7V6AJqeycD6HYmfKXh5/GWmsMOGQumHNUFfsIb+/cuFiHBkUkX1gPNHJis95BTLKWGdvbNr+ThI7DFhhRwtHbJugXXMU+qXxMVg41CVjPnipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287623; c=relaxed/simple;
	bh=jcFkuJhE/UADtSxvoiKHpSyf1xc0vTRwg88LOQE9U1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLtI+HG4ryCJbFwMcjZHPHADSsnIbL4MFzu1ebp625DIMKXMetn6a8biTerFzFv6pkfSKRNghHnFLNEvFkVHiEUHjYl7WvXjDpXQXOcsSpMBEEmK2FDrbG84wk+vT1+Jjfdes98W6ugZ4D2aErdUaz1rMwzys5QBSTh/R7riXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oU2OFHpQ; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oU2OFHpQ"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85321e37104so170708b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287621; x=1788892421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnnSLW+SChNX1aB1gN+IhC1WrYzZcFq+Twk/rWPhSCA=;
        b=oU2OFHpQYBWksm7s5Vr9HQ/m3J0RWunDDx3f28dHl/qE+PTZmZlLR06V2bkAiQZR3X
         rQQT/d+Fv7V+PK4V707X6HvmX4E2LXvECLaPDb+RqnPCRWY/IfMF9aZhCsJVSzXu8omr
         lKENpab2TWxP0rpJYtEDID9JgM0prgbXnnDS+jmy2uR/4KsWoOK9daiQYpHUPbNjOloi
         uwev3UhpB0roLTapdeLoLrneG2Z0X03GHHQEn3RMOQdI++Gz53AmtIZhBK/NESr9Tz7V
         6G/ET28OiwheWySqkvJ/tZ5APcIvZnbbmkF/E7WxWQCJwNv7Z8MyBSU6kTd1uPxwNSsE
         NCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287621; x=1788892421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnnSLW+SChNX1aB1gN+IhC1WrYzZcFq+Twk/rWPhSCA=;
        b=J9/VPtPPzSFdqKrn5VAdDCx3Vtve+wCFsV5q/28gBc3Vebo6vrPm0pXC0F1rsddC50
         y2gzeXMD/wtSXUc0VVlbMtJJE6XCih2Pz+ohl1QXiaYHPxmtdLMhNkNB2/4ZIWq6uqmC
         YMXJ+Zw5IOSrp6q9wcwR3kSLciIPqiBQxhfkXvbPqXVttclc/dduwHZ2iWRc7Lz+zLse
         lR8Zd3gls2nCzYnbpq0vjg5mVMCp3kdXkUffINOtiYiZmrgWJACuAV8aSAsg1I0TPT81
         na/AZ+x1pbctjfeFLxUBPCvuWdZyv8vmX4Jx2lGdwajkACEyugiY4SGygaMAn5OTvFeH
         yJgw==
X-Forwarded-Encrypted: i=1; AHgh+RrCmS5Wp5UVmtDHmLPISDG7pAogVS1r6pl2zpQm7wdahjnghaRlPuijcekXJ3DEnKq0F3LZHtY=@vger.kernel.org
X-Gm-Message-State: AFuF++mgNhQLvM0QCagaa4MOWLtT9YjbzFiWZlKm0rTnFOo8QTw+3nLW
	sEimWK5H2QTJQlbQRfFG2FEPV5MBdTUQxdUqD9L4tuv9k1j3LO4ZbfB4RcmgCtziTNnaYW4IOWS
	D46b0dw==
X-Received: from pfmu26.prod.google.com ([2002:aa7:839a:0:b0:84f:b437:398d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a21e:b0:842:55b6:f5a1
 with SMTP id d2e1a72fcca58-8562868f7b6mr48916444b3a.6.1788287621069; Tue, 01
 Sep 2026 11:33:41 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:33:03 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-15-kuniyu@google.com>
Subject: [PATCH v5 net-next 14/15] neighbour: Remove unnecessary net_eq().
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
index 7054b05625b1..9b28f40b019a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2660,9 +2660,6 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		nidx = 0;
 		p = list_next_entry(&tbl->parms, list);
 		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
-			if (!net_eq(neigh_parms_net(p), net))
-				continue;
-
 			if (nidx < neigh_skip)
 				goto next;
 
@@ -2840,12 +2837,11 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
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
@@ -2857,7 +2853,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			s_idx = 0;
 		idx = 0;
 		neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[h]) {
-			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
+			if (idx < s_idx)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
@@ -3262,10 +3258,6 @@ static struct neighbour *neigh_get_valid(struct seq_file *seq,
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
2.55.0.966.g6673acef38-goog

