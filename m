Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628867;
	b=D4i+c6hSr6MA4AyxgY2Wa1+LydSRjQBR66mT3kHYliNBJXdTuFlBcQGhu6H9eGCF+Xvy
	 6I984kbd2wAMasg/dxBOSfenr+EAlicNpVOA3vPzYAw/WLePWDLBjn1qzT0pFJL9fkeLm
	 v0NMSTJ3kbAbsAHpgLFtje9CQi4hCTwg3Pt0vlkXlXK349ifx736pVszPWq4Walu/vY4e
	 6n1Ag9aUJNuO3VTPkNnuCdchY/yRUr5KvIc6gjtJI8xnnlyya3fPy7wSbf+tE4dO/s3nP
	 8MiFApWNR7BZf3lvoRR1jOvk2Ur5UvAJUzntqEhLhzAiq49agU7RtE7IzN62Xgese/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=43/uBb+f6KI/ffE+19avu1Bbtvv0w15Hz6lFMOMV2+s=;
	b=anpBQs+9vclea5sqNFfmKAhV43s6uhcGSZuGwqHI13uH8lAKrKIXIlEIT05C/fwyOxsl
	 pO/IRr2/plCfvwC+ELKl6fRN27rIRgbhJJ7Wqd7cn19vyn0G/Mc8jF9FRNY7pK8TS0TiW
	 EWmHilGg5H8xR/1zUelt0y9MWfqOMwpyLGyKUs7omad6oPEHkLXlmIcJyZGQ7zJzMFRIr
	 bVMtQZyWb9X9CsGn+Gl262N27ebvUDY0PAdxx2yloRLtu8sJqb/C9iBJZUt4nSfLKiOQr
	 8pYxkIFXfvQUG741YCS0OvulEEapjJl8aUDr668CaGAcZHlw9ttimnQAOwUY5fDa0hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aWQP0kUa;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0B606A331
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B0B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aWQP0kUa
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so1896808a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628866; x=1795233666; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43/uBb+f6KI/ffE+19avu1Bbtvv0w15Hz6lFMOMV2+s=;
        b=aWQP0kUae/ZQWWYTHOXYj165wNiBqluHpx8Kk5FlDjCL8b5bUJ/7OtkMnZX/YoE7sA
         R8L06Od+yx7qJGW5zTFwndNLWtnfkxe+WjEbZa0I/peRL5aZ2+tZPo74r696EoCPlXAw
         xWKupa5r074BEGwJtk9E7JabD4YQUY41Kjw7A8dVVBcxVaCLEg2axZe+1xx7aARiFwCQ
         RW5UfDbf59C2SqmpKyqpSrVYs1EZI5z9V8Z9wJFTwp4/c9YH4uSb8JvMpTmNGyGkiIOw
         JTO2RwHhVJfOzWwQTpTcEIZPErZjZBCxs9PJi6AWnGRZrPVf4JmmAlkdxgDLFp/IBHss
         JWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628866; x=1795233666;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43/uBb+f6KI/ffE+19avu1Bbtvv0w15Hz6lFMOMV2+s=;
        b=0NlskUa8pgTSFG4mb+gPW7KdY3Dhktrwa/I7zflkcdFcmFS19CohR8lK1eFcs+4xDO
         keoCR6sgLhR8XQhCZhS80nDfH+uaSbMeRjRvW5ZE10/IXA9/N+QNhtZszBHcP3SA06Xe
         AJHvhLPSFcVIYRZaKkWl54NRokuof8G1zpf8HLw5BzujmVu5BUa88CBtTd4PqOHZutPE
         kt3GXVuVwP2dPKVCD69nDLS5k+uxkAYc1cZ815mV7duql59vsRF9SnURPxtNgh1RI+qt
         pd+xoJ9Ouh9yP7o6Ee1S/rgiNPPXcRi4doDLnQUJLRXV1RCJ9wcaUa2Y1/ngsHMEtld+
         opLQ==
X-Forwarded-Encrypted: i=1; AL+hErErw35zYs8qZJU0cBuYiKXAdWH2AmLOAyw9mZrKaniTx3qgJpPhKok6GN+y9RbR8v8hBEeumyc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GRvgvrJtk7/0l4vcU06nBC/eXHyHSvpEcrXpnbbQQJupFThQ0
	Tadb8NqxVo4+l8GpV7qVIpw6cx2Fk0CxazGqor+imovu5oNudyBTIULhtgHWIGm0eTjhyJSTBWq
	wZiWQ5A==
X-Received: from pjbbp7.prod.google.com ([2002:a17:90b:c07:b0:3b1:2eb3:19c7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5845:b0:3b0:968f:fdef
 with SMTP id 98e67ed59e1d1-3b1b0cfd862mr4873679a91.49.1794628865665; Fri, 13
 Nov 2026 20:01:05 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:46 +0000
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
Message-ID: <20261114040101.1043546-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/8] tcp: Stop collapsing if not bloated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Even when a skb is not bloated, tcp_collapse() starts collapsing
if the next skb has overlapping data.

Also, tcp_collapse() does not stop until it reaches the tail or
unmergable skb (SYN/FIN, unreadable frags).

Assume we detect a low-density skb followed by fully-packed 4K-MSS
GRO skbs:

             skb->len  truesize  scaling_ratio
  skb    #1      1448      2944      125 (49%)
  skb    #2     65536     66432      252 (98%)
  skb    #3     65536     66432      252 (98%)
  ...
  skb    #9     65536     66432      252 (98%)
  --------------------------------------------
  total                  534400

Then, even the high-density skbs are repacked into lower-density
skbs, and we end up consuming much more memory.

             skb->len  truesize  scaling_ratio
  nskb   #1      3776      4352      222 (86%)
  nskb   #2      3776      4352      222 (86%)
  ...
  nskb #139      3776      4352      222 (86%)
  nskb #140       872      2304       96 (37%)
  --------------------------------------------
  total                  607232 (+72832!)

Even if we find a collapsible skb, we should not collapse
subsequent skbs with scaling_ratio >= TCP_COLLAPSE_SCALING_RATIO.

Conversely, even if tp->scaling_ratio is smaller than
TCP_COLLAPSE_SCALING_RATIO, we should repack skbs once we
start collapsing, which results in higher-density skb.

Let's remove the next skb condition in the first loop,
search for collapsible bloated skb range, and repeat
collapsing for each range.

Note that even when the next skb is not bloated, we must
collapse it for OOO rbtree if it has overlapping data.

	if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
	    !tcp_collapse_skb_bloated(n, sub_end,
				      TCP_COLLAPSE_SCALING_RATIO))

For example, bloated skb_1 and non-bloated skb_2 have overlapping
data and only skb_1 is collapsed to nskb_1 and nskb_2.

   skb_1 = [1000, 5000]
   skb_2 = [2000, 66000]

Then, nskb_2 will be inserted after skb_2 in rbtree, wrongly
setting tp->ooo_last_skb to 5000.

  nskb_1 = [1000, 4776]
   skb_2 = [2000, 66000]
  nskb_2 = [4776, 5000]

This case is still inefficient, but a later patch handles this.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 66 +++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e07f43347409..5bd42a74c6f5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5839,7 +5839,7 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 }
 
 /* Collapse contiguous sequence of skbs head..tail with
- * sequence numbers start..end.
+ * sequence numbers start..sub_end.
  *
  * If tail is NULL, this means until the end of the queue.
  *
@@ -5848,15 +5848,18 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
  */
 static void
 tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
-	     struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end)
+	     struct sk_buff *head, struct sk_buff *tail, u32 start)
 {
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
 	u8 scaling_ratio;
+	u32 sub_end;
 
 	scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
 			    TCP_COLLAPSE_SCALING_RATIO);
 
+	__skb_queue_head_init(&tmp);
+
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
 	 */
@@ -5872,38 +5875,48 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* The first skb to collapse is:
 		 * - not SYN/FIN and
-		 * - the unread portion starting from "start" is bloated, or
-		 *   overlaps to the next one and mptcp allow collapsing.
+		 * - the unread portion starting from "start" is bloated.
 		 */
-		if (!skb_frags_readable(skb) ||
-		    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
-			goto skip_this;
-
-		if (tcp_collapse_skb_bloated(skb, start, scaling_ratio))
-			break;
-
-		if (n && n != tail && skb_frags_readable(n) &&
-		    tcp_skb_can_collapse_rx(skb, n) &&
-		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq)
+		if (skb_frags_readable(skb) &&
+		    !(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
+		    tcp_collapse_skb_bloated(skb, start, scaling_ratio))
 			break;
 
-skip_this:
 		/* Decided to skip this, advance start seq. */
 		start = TCP_SKB_CB(skb)->end_seq;
 	}
 
 	if (!skb || skb == tail)
-		return;
+		goto end;
 
-	__skb_queue_head_init(&tmp);
+	/* Second, find consecutive collapsible skb. */
+	sub_end = TCP_SKB_CB(skb)->end_seq;
+
+	for (n = tcp_skb_next(skb, list); n && n != tail; n = tcp_skb_next(n, list)) {
+		if (!skb_frags_readable(n) ||
+		    TCP_SKB_CB(n)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN) ||
+		    !tcp_skb_can_collapse_rx(skb, n))
+			break;
+
+		if (!after(TCP_SKB_CB(n)->end_seq, sub_end))
+			continue;
+
+		/* seq and end_seq must increase monotonically for rbtree. */
+		if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
+		    !tcp_collapse_skb_bloated(n, sub_end,
+					      TCP_COLLAPSE_SCALING_RATIO))
+			break;
 
-	while (before(start, end)) {
-		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, end - start);
+		sub_end = TCP_SKB_CB(n)->end_seq;
+	}
+
+	while (before(start, sub_end)) {
+		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end - start);
 		struct sk_buff *nskb;
 
 		nskb = alloc_skb(copy, GFP_ATOMIC);
 		if (!nskb)
-			break;
+			goto end;
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		TCP_SKB_CB(nskb)->has_rxtstamp = false;
@@ -5942,15 +5955,11 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			}
 			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 				skb = tcp_collapse_one(sk, skb, list, root);
-				if (!skb ||
-				    skb == tail ||
-				    !tcp_skb_can_collapse_rx(nskb, skb) ||
-				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
-				    !skb_frags_readable(skb))
-					goto end;
 			}
 		}
 	}
+
+	goto restart;
 end:
 	skb_queue_walk_safe(&tmp, skb, n)
 		tcp_rbtree_insert(root, skb);
@@ -5989,7 +5998,7 @@ static void tcp_collapse_ofo_queue(struct sock *sk)
 			if (range_truesize != head->truesize ||
 			    end - start >= SKB_WITH_OVERHEAD(PAGE_SIZE)) {
 				tcp_collapse(sk, NULL, &tp->out_of_order_queue,
-					     head, skb, start, end);
+					     head, skb, start);
 			} else {
 				sum_tiny += range_truesize;
 				if (sum_tiny > sk->sk_rcvbuf >> 3)
@@ -6103,8 +6112,7 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 		if (!skb_queue_empty(&sk->sk_receive_queue))
 			tcp_collapse(sk, &sk->sk_receive_queue, NULL,
 				     skb_peek(&sk->sk_receive_queue),
-				     NULL,
-				     tp->copied_seq, tp->rcv_nxt);
+				     NULL, tp->copied_seq);
 
 		if (tcp_can_ingest(sk, in_skb))
 			return 0;
-- 
2.56.0.611.g1030f0b940-goog

