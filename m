Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6C43F4CE
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608183; cv=none; b=B3epGRc7NaqB8uWgH+Xwmy2Tio4FLklw3qBp3xJCBR4i1TXNdpmXE0gDBAFg8fhkXNi1haEXw1LRAanZ4JUzJmoGqbc3EIlUxfaFitZjivw/1zMRA7HDuDm1BHJffmEF61Sy7R3eC/QuJulAMRIGxEH6w88T0fVwZewGgDu5AME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608183; c=relaxed/simple;
	bh=nXJSnZJoqThomALX/AChxj4sg/xdtvhCk/XRMye3o1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ffa/snp4W0VIQEzOHPiCi0AyiSIDqgNd94tZvQWKG5UDYj4hlyd2F3xSTc1aYpME657svknD+HbbD8Nn/qU5zOdMybCI+EDRBZdHDeWa4mgAZ++q/f/JpldzR6uBKsaJ9ITX3lRwirMWrX+UZu56ruZewYswKBYjXeLUG60lJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYeFlJFm; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYeFlJFm"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbee8d434b8so588760a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608181; x=1787212981; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+H9/4FlbYqqCnhoTnyaRqgzXigowM0EwaFgiVURZjdg=;
        b=bYeFlJFmpQMBqCsP3obc2KUSRi8ddzsp6BB0Ux6MbNCKS2lDvHgQRkcTqf5Fm0NuBp
         bO/hkNXi1Bv+hqNw8wKv8t0BLjnRw0n/8+TkI3DUEMbM9x4M7eUOu3j3v4TbU6crO47g
         dVlG0LAB6qGKYPgYnayYSrFBt3olv0khX2cmQ7Tk/WVgvSoRrTZ/cwtByN3TOjTItmmP
         G/Q2iK51Qjkgn5bLzTw6Kc84/miJHKyOZHQ09UvYJCt7Iiipi1WTsts+arWtFN9WVixf
         ox/+FEZd9fWoom2DkCBqmbI4N3epGO06MHLXeg4/EYSGMDSKjhVmG01SoJVtBbsUTNJF
         Z+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608181; x=1787212981;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+H9/4FlbYqqCnhoTnyaRqgzXigowM0EwaFgiVURZjdg=;
        b=n7j1dp8OPZgAgAI576MYfOjCVDpihwStf1ystPPXB4gvR25DIj1/g9BaKTb3i1e2PC
         A/+ZBnhkvdK5Ptv7vvqiuAUhCTAmqKQ6ot3zg97AYPbCIUXoYBC2oMWR1N9NVLpKqMMg
         JYnLG9I7qNIcjHQtlB7LBitkmvRciZydZOydm8teQiUxkl35C27IJBAl5Rx8XfD9oE/4
         mTezCKY4f0eUobTz+ZnLpoN0BtaRf0VSg5nQUF9l9Oiw7bmOCgCdvi7WhOXcGNWiXh52
         /D5qFi8NqiEdKGYr0qiYLWT1OCtwIXlByJssEqxT5/nMPHkbMKJKHm3d+Tz2YQNqKsLf
         5+hQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlKY7DSD2xtuZ2YAahDXr+rsiilgH0y7Z1GxcHCNycfmb4mFGVVm2i+CS+cUqKUUxNW2pZ4EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbRshrQ17ChX1x/8znKMXOhs7JksnpaA6PKJBhs9qNWox+/cQ
	T0Xs4JMwP0OzP9G12lcDuqFuOXTjdOBoqZ0bJ/9MLcy8BFQPYHAr7vFNKeXuiZjkNxiJXHQZrUx
	39k91qw==
X-Received: from pgmc38.prod.google.com ([2002:a63:1c66:0:b0:c9a:c533:8316])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6d87:b0:3bf:a7d5:df34
 with SMTP id adf61e73a8af0-3cc57829946mr3175861637.0.1786608181405; Thu, 13
 Aug 2026 01:03:01 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:28 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-15-kuniyu@google.com>
Subject: [PATCH v4 net-next 14/15] neighbour: Remove unnecessary net_eq().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_table is now per-netns, and net_eq() is no longer needed.

Let's remove them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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
2.55.0.691.gc56d675ccc-goog

