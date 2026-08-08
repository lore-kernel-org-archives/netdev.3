Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA62D8796
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204363; cv=none; b=FsJEwAwzOzC9P9Pe9OJ1Wn71JsBiuG9dzQGfszb0P0sKwLhdmq9z7DMwx0YOXuH1zN5oSW3khieijRxUlI+Ith/zl86t0JBrNL+MisX3pxZ+kDtJQa3l4zMIm7f3Z+Nil4vUBOK0gycL0bHmOfadjvlvaQlRW2RD8hjTwscWeEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204363; c=relaxed/simple;
	bh=q+qMQhAagbu4g4zdg1xSBEtrZy3xG3F+qHQRjjbqV2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHaNKaoCeYxtVSP2FRoQ+o5PHZd3QEGvjDNogwQYoERDDhZD1GcNhHKWyZ8BNZnkeAmyVQl3ci3eqO/3vTskACtlnJ/N2wNQWeiD8KnDe8p23Qzx3yfAIKX4sJUCsmzStjjGJUIhIlZ7LqMGJJBXYnSw2SdYc4bdQ32AuebMVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW9vc9gf; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW9vc9gf"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80cebd41372so7076077b3.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204361; x=1786809161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZifFpVx4BW7pemc+Qe2nKHeySWm1EELGJZ9eoiY9qdA=;
        b=ZW9vc9gffeWo3kvzZ+gPGjYb4XJxS2gdoFak9F5eZaX6FxMHmhyKAOtGV9aoygfv6p
         mYwzPSTi9ZkjUIC76Jgk+zYu5qgXc2zt3G3Mg8gxPz7vscTpqyEE3CVK0TfEvJGGiqpv
         3po2RKHYUfJNG3OWT7BjUXrjx1jAgHzA2akPhmzSPOoX8Ptc11GJm5n+0670chxqtZF1
         uiMe51S2FySK3YqkI+kXh9zi5alVP/Repb1t6XvaaI8DOboXfUjOjkm9gHJjXDPTKJa7
         ZFMTSMCsLSvIleuZq15ZaDNbzumt7B/Sxl/Dju5JAzfLS1uhwtyjp/i1dM/rUTR6b9Eq
         LqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204361; x=1786809161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZifFpVx4BW7pemc+Qe2nKHeySWm1EELGJZ9eoiY9qdA=;
        b=bpm0bFZbf4+Q37wYwzo/hGbwdaMJ8/kkeGI6NHF6/9Oc0qFjRsXMJQNbOpes2nLcBy
         Nj9qeRrQrJbt3jPfhQbWIamaplMzmvEz+YV6rndxB7d63M1D1wihqEBQnZdEGUPiNIUq
         P/89EK75yIAPEf58qlti5nQidxXLWYMO5oY/EJPXa7AUnk0cpnuQ45o0k+GcnUz3MzKx
         2XERLSVqgRNkO/94maTyzyKeEL4mN8lapZr1FIXb1bKnB/NQ4w8JhKqYWeO+xZA8HUJK
         4/JQ7WjBVvN7LE69/FZUxi2tdoj09oUROhyawjzrJ1HlJ10uvT2oakHKI8F1NNAQtEBv
         c2qA==
X-Gm-Message-State: AOJu0Yx3774m2pFTDa3vT6APP6ajo98fkhLn+1WYnIqNo2cFl0Vs5Rlz
	t/SjwKGgrap2I7Uw+ipW5Pm+AkzqOWlX6RKll2kJckieVncYUfbsUglExuBZnA==
X-Gm-Gg: AR+sD11YjUyn5TXJCxOaQyfPgfatWGuA+26oaaeeiCTn5Q8zqI4+9wMWGrXsaXJ2p5V
	ta0FWJfzMuXgGQYiOqHW6SqRtxcjHzowzc1Hzlhs+QVYZJhoDsdEa4IPL5uLM/x63EiUgZf2q7m
	hKA/HwU6mmsalPbC/CGRTde5cEdSmhbA0BrLDXCMEga3A+XTMY15WQ8VOX0cNCSCTTlBmDQeRmO
	WSXr50lZ3+S1I/yP+Tz5+zffEWcr2M3gAAbw2fwqW17Lt/8f/9qNPWcB0ggkppvx8YYer0KYo6e
	PlFBkfbqGjIU42182FxOg6AcQOHMMzNTBtoHC0OH8HYlYer531n0I8v6aOTGR99UbVq60EQa93N
	W/BXSYr1Owr1UiKvGe5JJm6sjiTpG+3vNvS6+H6Pbd5b/zazFwWJYb8y6wJivrCx3z5+HPEbt9f
	rm8D9g/hinlIkE454FcJW1bVn6JZ0bxWuPTDv3VpcLG6+Vp89ZeTSG3JlEISs2HsDJBqlUfuH0V
	Cu0H9JhKORJ620xume5YGzlAEtJB28GGC6ZNb3EFoQ71nde3VXPEW8MeoU=
X-Received: by 2002:a05:690c:4d02:b0:80d:964f:88fd with SMTP id 00721157ae682-8201f0c14a8mr195952687b3.5.1786204360620;
        Sat, 08 Aug 2026 08:52:40 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f79a6c6dsm27839747b3.48.2026.08.08.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:52:40 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 2/6] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Sat,  8 Aug 2026 11:51:40 -0400
Message-ID: <20260808155217.885299-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

When hardware offload is enabled, FQ will forward packets to the
netdevice for pacing. The device has to test that skb->tstamp is
in the future.

Avoid this cost for packets whose txtime has already passed, by
clearing skb->tstamp.

Also disable timer drift logic when offload is enabled, because
time_next_packet can exceed now causing a negative value.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v3 -> v4
    - also reset tstamp_type
    - minor: initialize time_next_packet for more obvious correctness

Sashiko, ignore pre-existing issues. In particular, effects on
non-EDT packets and when queue or sk rate limit is set.

Sashiko, pacing offload is an optimization. Ignore that some packets
may not get offloaded, e.g., when txtime is a few usec in the future.

Claude suggests to only call __skb_clear_delivery_time in one location
in fq_dequeue. Unfortunately the separate fastpath location is needed
as that avoids computing now in fq_dequeue for these fastpath packets.
---
 include/linux/skbuff.h | 17 ++++++++++++-----
 net/sched/sch_fq.c     | 19 +++++++++++++++----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..b3445ad5a35c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4490,20 +4490,27 @@ static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
 
-/* It is used in the ingress path to clear the delivery_time.
- * If needed, set the skb->tstamp to the (rcv) timestamp.
- */
-static __always_inline void skb_clear_delivery_time(struct sk_buff *skb)
+static __always_inline void __skb_clear_delivery_time(struct sk_buff *skb,
+						      bool want_tstamp)
 {
 	if (skb->tstamp_type) {
 		skb->tstamp_type = SKB_CLOCK_REALTIME;
-		if (static_branch_unlikely(&netstamp_needed_key))
+		if (want_tstamp &&
+		    static_branch_unlikely(&netstamp_needed_key))
 			skb->tstamp = ktime_get_real();
 		else
 			skb->tstamp = 0;
 	}
 }
 
+/* It is used in the ingress path to clear the delivery_time.
+ * If needed, set the skb->tstamp to the (rcv) timestamp.
+ */
+static __always_inline void skb_clear_delivery_time(struct sk_buff *skb)
+{
+	__skb_clear_delivery_time(skb, true);
+}
+
 static inline void skb_clear_tstamp(struct sk_buff *skb)
 {
 	if (skb->tstamp_type)
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..8d7458c38409 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -399,6 +399,11 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 		    READ_ONCE(sk->sk_pacing_status) != SK_PACING_FQ)
 			smp_store_release(&sk->sk_pacing_status,
 					  SK_PACING_FQ);
+
+		if (q->offload_horizon &&
+		    fq_skb_cb(skb)->time_to_send <= now)
+			__skb_clear_delivery_time(skb, false);
+
 		return &q->internal;
 	}
 
@@ -707,6 +712,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct fq_perband_flows *pband;
 	struct fq_flow_head *head;
+	u64 time_next_packet = 0;
 	struct sk_buff *skb;
 	struct fq_flow *f;
 	unsigned long rate;
@@ -721,7 +727,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	if (skb) {
 		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
-		goto out;
+		return skb;
 	}
 
 	now = ktime_get_ns();
@@ -758,8 +764,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 
 	skb = fq_peek(f);
 	if (skb) {
-		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
-					     f->time_next_packet);
+		time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
+					 f->time_next_packet);
 
 		if (now + q->offload_horizon < time_next_packet) {
 			head->first = f->next;
@@ -828,11 +834,16 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		 * f->time_next_packet was set when prior packet was sent,
 		 * and current time (@now) can be too late by tens of us.
 		 */
-		if (f->time_next_packet)
+		if (f->time_next_packet && f->time_next_packet < now)
 			len -= min(len/2, now - f->time_next_packet);
 		f->time_next_packet = now + len;
 	}
+
 out:
+	if (q->offload_horizon &&
+	    time_next_packet && time_next_packet <= now)
+		__skb_clear_delivery_time(skb, false);
+
 	return skb;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

