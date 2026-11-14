Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628869;
	b=iikZqpOfuUNgDB8cksfXR0YoaFVVlqcCR02c7qdMG5VtY7xPr6dYf4UYT8JfOA9hoSD6
	 Gj0cpX5yoYtRxZoJHjGWvEZLi3F+ZU9zNnf61YqE3sV1H3aUXVdA7PtOF07dVT+O/gQGV
	 vXxRDE8+erq1pLSv8/U5bTQwL5ILAhFXQ+CR6mYPkmWetAZEveJeAYjsFtx0uJSGs073p
	 r3ZaZqh2HgnJa1zE8dJpzs+0SDHkCZ2KHcSvYMn5du1tdqhapWqAddwiIHBOSqqlW59qn
	 dkuiabwP/lK89R7yzXnkXdkB2HKlnMWRcnxA/GK4MNsUt1+7WL8QfMdoXyVatw8gn2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=y29UP3jpOWfTq1uX8hhzCUiKjleRf5MbR0+jVygMBX0=;
	b=tp+nHCh18UGKzmfec/fuqrXnT77trSSUzaVLaj9C1UNNa6tIJnbtVD1kjHIwAikJ2fZE
	 cjspfIq4+aVD0L5LCk+0uaiFjUbt5KYDb73MMmwIGCmeZjMXeE+YZ5LDN5BD9LsqUgHyU
	 QcYtqHerzqwHHRYl/huIu4Wmv3f2atrfyZAnfbcby4m54pAa6riRaIj+YCxOgbKOM0Avl
	 nOdPiKmty8+bqTblQ5i5sEb36PQXm6HxezxZDzcW+dU04wGhCF+Rl1MkIGJpzNO0MzlYM
	 Qgppxo0uyT90qLLkq1XoqWOGn43AO+9pNenpSOt+tRp+IbxWWDeAxbZsOTm8ilI8V3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VLgLDckt;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A97606A89D
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A97606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VLgLDckt
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a06750c74fso1585799b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628868; x=1795233668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y29UP3jpOWfTq1uX8hhzCUiKjleRf5MbR0+jVygMBX0=;
        b=VLgLDcktfIapLfgmrCvQjnAYNLIPOXNJbrmIzhQZMeRtokxN2qW/OZCpqwC787MiEC
         Jky+uBC5aEjstv/HpOizpdo8MtIJOZOzZ5crsJHEj/Qy7NyGJzRngVHjSbDwzu92phSd
         5/B/BCDTG+PdNU4/jm73cHN9G7eH7Y3cjBAxdAD5bg2F33eej2XA319eQq4OmV5q+T6B
         jVOOFcxfgJt1zPhAA/BFoif9PB7XRqpomwR4lu3xFabRLDwIZ46n18XPmeP94mkTATBy
         9Zp1hHP4ukgFeH4HAV0WE0gu1imt95n2hSICgIt2yiuMciAE+UwBDkitx4wqeB1lZszo
         ITgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628868; x=1795233668;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y29UP3jpOWfTq1uX8hhzCUiKjleRf5MbR0+jVygMBX0=;
        b=Hfn5rw7i99Z9mY3ABPSmFWg3qrRQwj38az4RtoGScRa3A8kTKZbdvqlrjvpeoVDvtS
         AZddNq7qdRriWFRLhKx+c2Dqu1OgQ5i4ImW6nPxjspV5Slj+JQDbTLmotFioMBYQe09l
         ocULdXVC0EaH2V4PzCUfofzGVFlJldy9T59bGM2dfUKtuU4PxpuZD4uQSrgaLugTJSlL
         VIUGyT0zVfRV3t7p2FA+H9aEnMY8MqlliDPkIoBnZHFcqRxfIa0+F8p7kz6m3QMDMo19
         6yHwD9bOeLDW/q2tEnzoiF6kr5t9aUoHc1JzXzws/rb4cQZtNJ6X0x5Ib4ySR+dbUc2p
         nR/g==
X-Forwarded-Encrypted: i=1; AL+hErHg2WxikudK3oMOJK9+vEFLZE4NIqEJSUqYU7Va8sb8LHTBPlJpVz/qmLBFmYPrDD1s7unWXdA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ht1H0bPhwOzzO3o3cFwjh57tEHqZHKMVtPtzbk/VvzveYKKa5
	NUefqvT9+elUuxgfFZl5kGSc8wWC1c3DbTxmQkMbuzYe4PbRrbW9s0IPhmYqHMw4ZcWuszmYKuG
	4JZhW/A==
X-Received: from pgdo5-n2.prod.google.com ([2002:a05:6a02:6205:20b0:cca:5338:9514])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d74c:b0:3e2:8597:44e6
 with SMTP id adf61e73a8af0-3f7a76c4f28mr3841534637.50.1794628868101; Fri, 13
 Nov 2026 20:01:08 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:49 +0000
In-Reply-To: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114040101.1043546-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 6/8] tcp: Allocate all new skb before collapsing.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At the final stage, tcp_collapse() iterates over collapsible
candidate skbs and repacks them to new skbs.

In each iteration, a new skb is allocated and inserted to the
receive queue or a temporary list for RB tree.

If alloc_skb() fails while splitting a large bloated skb across
multiple new skbs, the partially-copied skb is not removed and
new skbs remain in the queue as duplicates, consuming more memory.

It is only when all candidates are properly collapsed that
we can save memory.

To avoid complicated rollback, let's preallocate skbs before
collapsing.

Now all skb in [start, sub_end) must be allocated in a batch,
so the section size is normally capped at TCP_COLLAPSE_MAX_TOTAL_SIZE
(16 skbs), except when a single bloated skb or overlapping OOO skbs
must be collapsed together to free the original skb or keep the
rbtree monotonic.

Once the size exceeds the limit, the remaining skbs are re-evaluated
from restart:.

Note that the next skb can be skipped if its density already meets
tp->scaling_ratio, and each cut adds at most one remainder skb
(~3.4% worst-case truesize overhead on 4 KiB pages), which is a
small tradeoff to bound the temporary allocation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fe71305f6e67..9f32577b0b53 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5812,6 +5812,7 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *skb, struct sk_buff_head *li
 #define TCP_COLLAPSE_SCALING_RATIO				\
 	((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /	\
 	 (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
+#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)
 
 static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
 				     u32 start, u8 scaling_ratio)
@@ -5852,8 +5853,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 {
 	int old_truesize, new_truesize;
 	struct sk_buff *skb = head, *n;
-	struct sk_buff_head tmp;
+	struct sk_buff_head tmp, pool;
 	int remainder, nskbs;
+	struct sk_buff *nskb;
 	u8 scaling_ratio;
 	u32 sub_end;
 
@@ -5861,6 +5863,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			    TCP_COLLAPSE_SCALING_RATIO);
 
 	__skb_queue_head_init(&tmp);
+	__skb_queue_head_init(&pool);
 
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
@@ -5908,8 +5911,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* seq and end_seq must increase monotonically for rbtree. */
 		if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
-		    !tcp_collapse_skb_bloated(n, sub_end,
-					      TCP_COLLAPSE_SCALING_RATIO))
+		    (TCP_SKB_CB(n)->end_seq - start >= TCP_COLLAPSE_MAX_TOTAL_SIZE ||
+		     !tcp_collapse_skb_bloated(n, sub_end,
+					       TCP_COLLAPSE_SCALING_RATIO)))
 			break;
 
 		sub_end = TCP_SKB_CB(n)->end_seq;
@@ -5924,6 +5928,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	if (remainder) {
 		nskbs++;
 		new_truesize += SKB_ALLOCSIZE(remainder);
+	} else {
+		remainder = TCP_COLLAPSE_MAX_SIZE;
 	}
 
 	if (old_truesize <= new_truesize) {
@@ -5932,14 +5938,19 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		goto restart;
 	}
 
-	while (before(start, sub_end)) {
-		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end - start);
-		struct sk_buff *nskb;
-
-		nskb = alloc_skb(copy, GFP_ATOMIC);
+	while (nskbs--) {
+		nskb = alloc_skb(nskbs ? TCP_COLLAPSE_MAX_SIZE : remainder,
+				 GFP_ATOMIC);
 		if (!nskb)
 			goto end;
 
+		__skb_queue_tail(&pool, nskb);
+	}
+
+	while (before(start, sub_end)) {
+		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end - start);
+
+		nskb = __skb_dequeue(&pool);
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		TCP_SKB_CB(nskb)->has_rxtstamp = false;
 		skb_copy_decrypted(nskb, skb);
@@ -5985,6 +5996,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 end:
 	skb_queue_walk_safe(&tmp, skb, n)
 		tcp_rbtree_insert(root, skb);
+
+	__skb_queue_purge_reason(&pool, SKB_CONSUMED);
 }
 
 /* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
-- 
2.56.0.611.g1030f0b940-goog

