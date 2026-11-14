Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628866;
	b=iYgakKTkOfU7y42Ds09LD7xFO5ZfCKjlCtUMB09o/CjDGDI7ltr12mVrRzRT6Q5Z/tFF
	 53lZEdqAT3ckiHb+2aJ6lI2LMdCWuwOPBF9nST1UyGeXQGmsDO8XtSoVBh+FhC9/9hfWO
	 M2hkm4ZmkcfRdsSV3CK2CFWMZxyICe2QL2EaLqebzpUFqEST7PcRSb0FY8FVpJf3sG5Sl
	 D2af5WArOJdTO3k/M6lLJc1qV/xsjQ/cyhg7Qukbz+Ua/sOsQ9rvyNzQaztghEXMNTjo7
	 TIRkAj6OZIdYP518Ucaoe/6JOXjSDderTApmQWtPjV7Ul+g2Y/YfPP7zjs932x08B2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Tiw4nZDJPSstIlaR8MOmBCFoRbMNr1ciz202ri/dK8Q=;
	b=ks51t3NBdEmWxkgkLmU9wK4wDfGGTiM14PZ9rpZl6ljR8vbs6L3W8UB24cjuqgMOHP7L
	 XrDKPF8Z8QFrzGFt/dqTDF17xV5jZp4ylG6r5MAqalBpgoz04DhV7pjZzhBXDT/GCycbZ
	 fusJa0w95L3w5Tf4/mOfiDBr1wkXcz0H10/AwJvqwuaIOt7AbjXhuXiUPQQBn+MuS+/eg
	 ofjA7Fs0hMjOqNI1u+slA6INjNII2IW70sp1JtKplwkgc/qbQ8TSmrCqyvNzCASkLNMLn
	 lSYtQTgygh8EWP8pjr5grNxxjbwyt5tbz76czq1LcpN0g+dJudXLEOts4DsUwg+/nvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="LgBcJ/r6";
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3539606A32D
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3539606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LgBcJ/r6
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso1124279a91.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628865; x=1795233665; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tiw4nZDJPSstIlaR8MOmBCFoRbMNr1ciz202ri/dK8Q=;
        b=LgBcJ/r6BW4e5MI2fErxkb0gWLHnDkX1YSNG+8aLQHlZiH0UxRuFgpwjMIvIt3+Sm3
         LGDpd53eWHaiARHq+UXoj4blMN7Gyx7jXvIGGna83WlEj+ap0lmNk80EtyOJXgM+TJB9
         1FdQx1AiPHuXTuYUoQ8992AuKjGWUaqAhGx0HefL+dqsX+Z6gd88qANxjEG6BKCksRyb
         OtkRHpCPgMeZ3+pec4YNXDi4/jfkx+NO8yxr0FRD8xIQGsjz4p1hcFWygk+9VQJN1XTU
         StirPpFllgSe1TBbb2xZZiuspMk7V4vxYm/UmqQVGu5PeXPGM37UNFzhBBJ5WJPKIm97
         Eg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628865; x=1795233665;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tiw4nZDJPSstIlaR8MOmBCFoRbMNr1ciz202ri/dK8Q=;
        b=Y6V7F6Biu4rPQDvexs97keXRPAv7x2HBAyb6vO4UZl63c+om3pM46CxJXiLB/WDGBm
         E3F3wfvciESeRRI3L15HmqyZ6/fm6AsdHsMQKJxrqjMoLiUPYb5U7ubpo0Mj6Sk40rpj
         p7AuYJMwdl2zJD40yaeCT0+QXdyPgMkd71OcD7Z6n+GrD3nElMhwak+AX0BJqNOQhIaD
         3CXb6UjZG46L7/sT3z4nePBoM8CTX6v3NwEgcTL4pUbENYrWQNt90II97dTdunyPinMS
         B1qYhtJ86aoKOCKKWw+WVm191fSzZycdif7HZH4HOBJOVfnrJiC5zMV0YcZMbdwq8zK0
         r1ew==
X-Forwarded-Encrypted: i=1; AL+hErFmNT4V8h9LEYSc/imsDU/UYQe+81wxn3ZdD8XRFvUx2S/LrQKHj3I9JQecVVHFWNQU8I66Tg4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DVAUqbzLCieRngrj8tJNAgrj/hsfmqBkc6EK1zRzOC6cqSihe
	BZ0VoByhZ2MUzXEPZyygYTBW0SWhZYKU4JPWIr01Z4HP+O5x4Q8gYuP4XlS8aBiuECS1WGroumD
	LMHVzoA==
X-Received: from pgqs26.prod.google.com ([2002:a65:691a:0:b0:cdb:91c5:5e0b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3808:b0:3ae:533e:7e3c
 with SMTP id 98e67ed59e1d1-3b1b0a4df89mr4555978a91.35.1794628864892; Fri, 13
 Nov 2026 20:01:04 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:45 +0000
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
Message-ID: <20261114040101.1043546-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/8] tcp: Don't collapse high density skb.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tcp_collapse() starts collapsing skb to a new skb if either
of the following is true:

  1. skb is less dense compared to tp->scaling_ratio
  2. skb has read data before @start

However, this could make situation worse.

The new skb size is SKB_TRUESIZE(SKB_MAX_ORDER(0, 0)) at most,
and with PAGE_SIZE being 4K, its scaling_ratio is 222 (86%).

If 4K-MSS GRO skb updates tp->scaling_ratio, it can be larger
than 222.

Then, even the newly collapsed skb could be detected as bloated
by the next tcp_collapse().

Also, even when only a few bytes are read from GRO skb, it is
collapsed by the 2nd rule, making less-efficient skb.

Let's cap tp->scaling_ratio with the collapsed skb's maximum
scaling_ratio and use unread bytes for bloat detection.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 32e63d089db8..e07f43347409 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5808,6 +5808,19 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *skb, struct sk_buff_head *li
 	return skb_rb_next(skb);
 }
 
+#define TCP_COLLAPSE_MAX_SIZE	SKB_MAX_ORDER(0, 0)
+#define TCP_COLLAPSE_SCALING_RATIO				\
+	((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /	\
+	 (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
+
+static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
+				     u32 start, u8 scaling_ratio)
+{
+	int unread = TCP_SKB_CB(skb)->end_seq - start;
+
+	return __tcp_win_from_space(scaling_ratio, skb->truesize) > unread;
+}
+
 static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 					struct sk_buff_head *list,
 					struct rb_root *root)
@@ -5839,6 +5852,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 {
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
+	u8 scaling_ratio;
+
+	scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
+			    TCP_COLLAPSE_SCALING_RATIO);
 
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
@@ -5855,15 +5872,14 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* The first skb to collapse is:
 		 * - not SYN/FIN and
-		 * - bloated or contains data before "start" or
+		 * - the unread portion starting from "start" is bloated, or
 		 *   overlaps to the next one and mptcp allow collapsing.
 		 */
 		if (!skb_frags_readable(skb) ||
 		    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
 			goto skip_this;
 
-		if (tcp_win_from_space(sk, skb->truesize) > skb->len ||
-		    before(TCP_SKB_CB(skb)->seq, start))
+		if (tcp_collapse_skb_bloated(skb, start, scaling_ratio))
 			break;
 
 		if (n && n != tail && skb_frags_readable(n) &&
@@ -5882,7 +5898,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	__skb_queue_head_init(&tmp);
 
 	while (before(start, end)) {
-		int copy = min_t(int, SKB_MAX_ORDER(0, 0), end - start);
+		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, end - start);
 		struct sk_buff *nskb;
 
 		nskb = alloc_skb(copy, GFP_ATOMIC);
-- 
2.56.0.611.g1030f0b940-goog

