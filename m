Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474130DEA6
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060316; cv=none; b=nPyVFsxQXu9spD31zxklYXir6Mjor5207AOkXLqYx8Vc63gB5MSPi3RDUcNNAFGsbbMNTGgHtQU3YBhj1eFeijKfEc5sdsua26EYIOeOGLWARpqD4nBET0xxUVdYaRNkP5c0CXDGcAYW4qShJzWduOj4UE16cEQ3SA/h4NegZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060316; c=relaxed/simple;
	bh=44bh7d6MjMdpUX7hz0JFItx7FHhJokMrWspdK/6JFKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na9oOcvW/BcSqEr7ScOOYhVunXymQlMEvnEu/R0Map/89igmhAeazzzvrT8OD4RvdWYxBJco6GBDAZvIWUV6HJRP6u2pO1QCLk6VQY9bCrsHwSlsfKvuoSVYvajXN6ezHN/YGq061cqadud+vUS0Kxotv/E4Gr15fgIruP02qPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+h2OjEM; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+h2OjEM"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aae3147so2835548d50.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060298; x=1789665098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mg6CO7/NgNV2X5AxvQzb5iai3z5sSjGBUrOmmV0+CU=;
        b=W+h2OjEM1cvlvaVLPpOcH6kb61VpwP4H6d2qFOExgvmyngN/w2KvEdmbPG/LYBH0Wg
         YlcP82+cK8OwjlRUb6sKjY050v2w3+wbuiYukqb4ZIDNnD8mVlTnMHBBhU2FuAqF2r/w
         84NL0M1nLcx43Da+Gond1d2xi+xTYeseBjE2DNPVCMWKoO0AQvaWA9tCFYcX9riFNV5X
         s5wOm9uByfxC2H+zD051Ac9wz44NXrt4VxmAaDosZIRWoBdIF2IdWMk7H9tFRvR+GgyY
         I6km1deUj6ZTSyUbnC1Q4IZeqDuXWF3PoMIf5HJMcIUQZcEQgLYvNnP8s06M7WSrL1p4
         gSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060298; x=1789665098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mg6CO7/NgNV2X5AxvQzb5iai3z5sSjGBUrOmmV0+CU=;
        b=enYKAltthE2fkIjZuk3JXgAwF+wv0EmYV0MU4GH41cALGPmsZA6aG6UlfFfXI5R1UV
         IGSVSE8DzN+nvmdrrJz94fVXPMxLt/3is1ERqglHqR6vaISwuqBR9wJCfbAu4Gf8TCC5
         5W3eWRAH3ehGKsVhxTQK8j8nK6F8TIpfofi+pHq6c4siOJWySMcwcX7GjINRkaUvtVU3
         2AMR6AXYraXyS+sGgZrMFu0k51NYEOvy6iTiRTsXqR7qVpS9jAp/f69r9QtKuIYA0dMN
         QuEw8DMHwTX5BIUXNBJXYE9ruQOcnLY9MiDUh6LQ7YPbENKTHJs+I9NlJYNk36ai0fjG
         osbA==
X-Gm-Message-State: AFuF++klVOkGsr8k7NBPP2fA74Ryuzdbd3s5sBr4GKfRJAJhODf0rObV
	PatRx6KuLLreIulIHaj/OdX4YSk9tFuzt6HK9gZXa/bm/dF5mokpOABftvl08Q==
X-Gm-Gg: AYBFou3QFWyWwyFuV+0eveDO5HvGpEWWY8tLiIXvL2B1lbHedig1ksmF04J1JNXGjov
	4fWHGgIxTFMcvxk4XGQ55MelfwCj8zhpHU00Wctl7V2TCMhDc6xXdWm4KHV8APXEjP4b6/qynQw
	SW3JoBoO6BMzJbDXIfdwQu+oNopV4eSBgqx4eO00YVs5P33HKqVHGbsZ91LqDiA3qGxKvMieX0Z
	+66H7bV2F9gqaMY001nh3rHxm7WolCbHi5QUsBVHcv7JArqj2c6RKuNvDYK6LGkZUmTPUMMrwrN
	33BGIXZb9H3YmXErW0xs1mUYAg+t3FzVjTL2SoM6+4j5Q8e8wj+VgVXp5k9b2sCV7tPCupKl4Fq
	1K0IDvjvh0ho5269c1lrvHNRbJ5K/Y016EEjJhiAv+CmGETiQYPLYV1PUMMM90F0YKxWTLLwBxg
	KLyJBDhX0f+mzMPznG8golio5/3NDKbk62A8yug65l8B8atE+OAs3YYp+V0oxpPVieAwbPQyzw3
	C0gQRqZBmyupGNaaL7hCVrU3uuwRQhdZEQIqWS3UMElOGYYzu/PenvC8wIvFnK0JXA3bj0wuHw4
X-Received: by 2002:a05:690e:4545:20b0:668:db:8c35 with SMTP id 956f58d0204a3-67124621789mr82946d50.20.1789060298092;
        Thu, 10 Sep 2026 10:11:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:11:37 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v9 2/7] net_sched: sch_fq: check device pacing offload
Date: Thu, 10 Sep 2026 13:10:21 -0400
Message-ID: <20260910171131.2532487-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Network devices can modify pacing offload administratively or device
renegotiation.

In FQ, only offload if the feature is enabled and within the supported
device horizon.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/sched/sch_fq.c | 53 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 6144b5686f13..fdd9380e445c 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -301,6 +301,26 @@ static void fq_gc(struct fq_sched_data *q,
 	q->stat_gc_flows += fcnt;
 }
 
+static u64 fq_offload_horizon(const struct Qdisc *sch,
+			      const struct fq_sched_data *q)
+{
+	const struct net_device *dev;
+	u64 offload_horizon;
+
+	offload_horizon = READ_ONCE(q->offload_horizon);
+	if (!offload_horizon)
+		return 0;
+
+	dev = qdisc_dev(sch);
+	if (!dev->pacing_offload)
+		return 0;
+
+	if (offload_horizon > READ_ONCE(dev->max_pacing_offload_horizon))
+		return 0;
+
+	return offload_horizon;
+}
+
 /* Fast path can be used if :
  * 1) Packet tstamp is in the past, or within the pacing offload horizon.
  * 2) FQ qlen == 0   OR
@@ -312,12 +332,12 @@ static void fq_gc(struct fq_sched_data *q,
  * FQ can not use generic TCQ_F_CAN_BYPASS infrastructure.
  */
 static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb,
-			      u64 now)
+			      u64 now, u64 offload_horizon)
 {
 	const struct fq_sched_data *q = qdisc_priv(sch);
 	const struct sock *sk;
 
-	if (fq_skb_cb(skb)->time_to_send > now + q->offload_horizon)
+	if (fq_skb_cb(skb)->time_to_send > now + offload_horizon)
 		return false;
 
 	if (sch->q.qlen != 0) {
@@ -338,7 +358,7 @@ static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb,
 		/* Ordering invariants fall apart if some delayed flows
 		 * are ready but we haven't serviced them, yet.
 		 */
-		if (q->time_next_delayed_flow <= now + q->offload_horizon)
+		if (q->time_next_delayed_flow <= now + offload_horizon)
 			return false;
 	}
 
@@ -357,6 +377,7 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 				   u64 now)
 {
 	struct fq_sched_data *q = qdisc_priv(sch);
+	u64 offload_horizon = fq_offload_horizon(sch, q);
 	struct rb_node **p, *parent;
 	struct sock *sk = skb->sk;
 	struct rb_root *root;
@@ -393,12 +414,13 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 		sk = (struct sock *)((hash << 1) | 1UL);
 	}
 
-	if (fq_fastpath_check(sch, skb, now)) {
+	if (fq_fastpath_check(sch, skb, now, offload_horizon)) {
 		q->internal.stat_fastpath_packets++;
 		if (skb->sk == sk && q->rate_enable &&
 		    READ_ONCE(sk->sk_pacing_status) != SK_PACING_FQ)
 			smp_store_release(&sk->sk_pacing_status,
 					  SK_PACING_FQ);
+
 		return &q->internal;
 	}
 
@@ -661,12 +683,13 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return NET_XMIT_SUCCESS;
 }
 
-static void fq_check_throttled(struct fq_sched_data *q, u64 now)
+static void fq_check_throttled(struct fq_sched_data *q, u64 now,
+			       u64 offload_horizon)
 {
 	unsigned long sample;
 	struct rb_node *p;
 
-	if (q->time_next_delayed_flow > now + q->offload_horizon)
+	if (q->time_next_delayed_flow > now + offload_horizon)
 		return;
 
 	/* Update unthrottle latency EWMA.
@@ -677,7 +700,7 @@ static void fq_check_throttled(struct fq_sched_data *q, u64 now)
 		q->unthrottle_latency_ns -= q->unthrottle_latency_ns >> 3;
 		q->unthrottle_latency_ns += sample >> 3;
 	}
-	now += q->offload_horizon;
+	now += offload_horizon;
 
 	q->time_next_delayed_flow = ~0ULL;
 	while ((p = rb_first(&q->delayed)) != NULL) {
@@ -705,6 +728,7 @@ static struct fq_flow_head *fq_pband_head_select(struct fq_perband_flows *pband)
 static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 {
 	struct fq_sched_data *q = qdisc_priv(sch);
+	u64 offload_horizon = fq_offload_horizon(sch, q);
 	struct fq_perband_flows *pband;
 	struct fq_flow_head *head;
 	struct sk_buff *skb;
@@ -725,7 +749,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	}
 
 	now = ktime_get_ns();
-	fq_check_throttled(q, now);
+	fq_check_throttled(q, now, offload_horizon);
 	retry = 0;
 	pband = &q->band_flows[q->band_nr];
 begin:
@@ -761,7 +785,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
 					     f->time_next_packet);
 
-		if (now + q->offload_horizon < time_next_packet) {
+		if (now + offload_horizon < time_next_packet) {
 			head->first = f->next;
 			f->time_next_packet = time_next_packet;
 			fq_flow_set_throttled(q, f);
@@ -836,6 +860,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		}
 		f->time_next_packet = now + len;
 	}
+
 out:
 	return skb;
 }
@@ -1183,11 +1208,15 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		u64 offload_horizon = (u64)NSEC_PER_USEC *
 				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
 
-		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
-			WRITE_ONCE(q->offload_horizon, offload_horizon);
-		} else {
+		if (offload_horizon && !qdisc_dev(sch)->pacing_offload) {
+			NL_SET_ERR_MSG_MOD(extack, "device pacing offload is disabled");
+			err = -EINVAL;
+		} else if (offload_horizon >
+			   qdisc_dev(sch)->max_pacing_offload_horizon) {
 			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
 			err = -EINVAL;
+		} else {
+			WRITE_ONCE(q->offload_horizon, offload_horizon);
 		}
 	}
 	if (!err) {
-- 
2.55.0.1007.g17ff1f9808-goog

