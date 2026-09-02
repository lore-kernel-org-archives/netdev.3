Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7D44E66A
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373077; cv=none; b=AmnarDuaDD3VkhG8RX/aLliuWQjLBsZ/isemxDlmPQHq8jq0hyY/GzKTqekNQEv8px19+ctC8XZjl8uPYM/hy/eHFT/67wUmZwscSMNvVOTyH2JBJIs1I5NXg3w1ORGtsEAdXrHdTnXuxqBS5Z63LdM1yieY09/kW2qXHVwlU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373077; c=relaxed/simple;
	bh=AX3m6ORR0iKDHRFB+WG6SPme+Cb6zSYAf+2xfQyW4QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJsKmp5XRGYVilT6rZwjSMZMdxMxo8qrkFZX+QF6/nKtpiFGMSvuiyoq4OOpdlbaW6A5JtjIbcag5N/V6vZICUiJOw648mTlkvFclAWeFlmN9V+v37J0OawP8TapxNk8M6EUQ5BRJ4N2Ymv4PQVv5Yk64C7VVfYEQUS0d3OiV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV30sTcy; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV30sTcy"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-866e57f63a3so19475007b3.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373075; x=1788977875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9dmcVAhA3wuvcMfAcuC2/oqhQ3SPaSMtYMicaxlu5Bs=;
        b=IV30sTcyEQzBEoOyhfK0In0F923iMVwmUXAu2Q2X9UM1ReyhxXmJWo/czmeS/nfWdR
         goBSmsPvXuHdsUwsuQicT24fDbcSy0Ov8Q/W5FU5MRDvjdlqIfPWI2u2uvg8vx9Ksfqs
         bKNzCpI4aM3N8U4kh9LOfPkthSs/ceEvvV3nADW7sfLkpQsW1CDRc0fCI9zrvbmpUb5d
         0wNbv+PLal29ICS/z48MbKO3874NVqH5fKBKlhImyUXvxt2KgmjqgSKGW9+42sNvz3lm
         x2oF/1F7piuCkFOAO+Sg/Fy9MooTYZmJ3J1oLj4SpAtRqjdxdV2GBm3eBtn+9lW4EHy0
         /AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373075; x=1788977875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9dmcVAhA3wuvcMfAcuC2/oqhQ3SPaSMtYMicaxlu5Bs=;
        b=F6xyjLqpslG3pJOcZ+wt2K+LQZXV0EguwRlebqrU9s909MhZGbnnVtPtjp+iBzEaUt
         8kbxJ0JllhCGc4YfOk7va7LrAY+tdl4KKCixtdXR8BBgg5DeYSTG8FsCMDiXLVCulBVC
         n/APdzltY8J1XEDVORatISU5ByUZUvdqNqNe6FM4BR5fK1IbN0XHxA0M9a1P1csUsod9
         ozkXPbtBVDnNnR+dw0OTiZR3sYEOtLodaXlbcrgpF9OiXuFZiofLTxBSAbhISNEANDJp
         WBTE8Rzr6Fg4gOVD+SkLc58q0jC/gQInjAGQ+4MCmRt8p8U8nFJ6G34VnKfd8T8Ix9j7
         akkA==
X-Gm-Message-State: AFuF++lwU084m8pbx12Gvvqef+2ZGgsGrERB19eWKtZZLLZEqpl7U2s5
	cbNJCEpM5pvRNyqfEr/IkWcgojDK9y39wnGo6h9D6O1TiRlhh4cdxWcVOV4Bkg==
X-Gm-Gg: AYBFou1XfpYSvxSdVXDJ+v4WaAc88KnG/ahHr552wxb4dXQvhYYdOD0n72LS5/3QeGZ
	wcJqTLfuf00K/nadVFtj3mywT3V5wetfLfOT7yJ103RPexbLURW7mi05aJ+sSMEppdaQX8cIPr4
	5TQVwtoGxZr0FyGtgEDh4MMFjMvHLEj+9pi3qgkjfUysScsX1ePyWCrazoGrAt+fC9+jVs/Mu6n
	syye0qpaiYOfV4wpTu7tD6vFELHodUCYLIEamEVzL832KP2NCHXoe+5yFow0s0li7BFY/WX4aK5
	g0WPU9PLLKSTNYZf4Ts+5TPcyNVvZXWgouJ2f0rWngQ0bron0rAM/BXeYg56YkecE0Ct3x8BUlZ
	2HzqGgYBI94Al2S0n1Xr2U5UMU+As/mpEG/CgUJRWWwOxVoNfyirdXUB777wWPjzMNtBiLNpfsF
	VLjds0JS7Ac6NGgCGncHKvL3m1aXdWpRn7khupbPVGl04OMc4VMa5DO4elg+bf6oTQ1qh/0rlWY
	Yipm9cbq5VcF7e6dr5bhTX4QMeJ9hhZiHprHEBBZd85+jMDSHPXZG7Vgdmu7eLj
X-Received: by 2002:a05:690c:a64b:b0:81e:c972:e8c3 with SMTP id 00721157ae682-86c54553caamr30013577b3.29.1788373074980;
        Wed, 02 Sep 2026 11:17:54 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784192bsm23162297b3.30.2026.09.02.11.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:17:54 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v8 2/6] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Wed,  2 Sep 2026 14:17:12 -0400
Message-ID: <20260902181747.2483351-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
In-Reply-To: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
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

Also clear slightly into the future, for EDT timestamps that are
so close to now that they fall within a reasonable normal Tx
latency. This slack is set to 400 nsec.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v6 -> v7
    - timer drift logic fix moved to separate commit
  v5 -> v6
    - switch to skb_set_delivery_time to also clear SKB_CLOCK_REALTIME
    - add fq_offload_slack_ns
  v3 -> v4
    - also reset tstamp_type
    - minor: initialize time_next_packet for more obvious correctness

Sashiko, ignore pre-existing issues. In particular, effects on
non-EDT packets and when queue or sk rate limit is set.

Sashiko, pacing offload is an optimization. Ignore that some packets
may not get offloaded, e.g., when txtime is a few usec in the future.

Claude suggests to only clear delivery time in one location
in fq_dequeue. Unfortunately the separate fastpath location is needed
as that avoids computing now in fq_dequeue for these fastpath packets.
---
 net/sched/sch_fq.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cf7afda699f..322120760507 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -159,6 +159,9 @@ struct fq_sched_data {
 	u64		stat_allocation_errors;
 };
 
+/* EDT timestamps to clear beyond now. */
+static const int fq_offload_slack_ns = 400;
+
 /* return the i-th 2-bit value ("crumb") */
 static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
 {
@@ -399,6 +402,11 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 		    READ_ONCE(sk->sk_pacing_status) != SK_PACING_FQ)
 			smp_store_release(&sk->sk_pacing_status,
 					  SK_PACING_FQ);
+
+		if (q->offload_horizon &&
+		    fq_skb_cb(skb)->time_to_send <= now + fq_offload_slack_ns)
+			skb_set_delivery_time(skb, 0, 0);
+
 		return &q->internal;
 	}
 
@@ -707,6 +715,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct fq_perband_flows *pband;
 	struct fq_flow_head *head;
+	u64 time_next_packet = 0;
 	struct sk_buff *skb;
 	struct fq_flow *f;
 	unsigned long rate;
@@ -721,7 +730,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	if (skb) {
 		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
-		goto out;
+		return skb;
 	}
 
 	now = ktime_get_ns();
@@ -758,8 +767,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 
 	skb = fq_peek(f);
 	if (skb) {
-		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
-					     f->time_next_packet);
+		time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
+					 f->time_next_packet);
 
 		if (now + q->offload_horizon < time_next_packet) {
 			head->first = f->next;
@@ -836,7 +845,12 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		}
 		f->time_next_packet = now + len;
 	}
+
 out:
+	if (q->offload_horizon &&
+	    time_next_packet && time_next_packet <= now + fq_offload_slack_ns)
+		skb_set_delivery_time(skb, 0, 0);
+
 	return skb;
 }
 
-- 
2.55.0.970.g62bdec98f9-goog

