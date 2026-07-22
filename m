Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910543C04A
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753107; cv=none; b=Oo6GgQQN4zHEOrSk8iWoiZ/0arzMx1U+hhS72GSPdPoI9oANsq31EXzq3jN0qSzbVekah/Z1/EJbwncLkGdKtGL2d9eZ/2Cbj1+CFnQvFQi1C6OkIjKG5Xohlt3Yi96PScMzH7Z6qa0veT12SHNaMlf1piPuG7YDHQP6HKAO5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753107; c=relaxed/simple;
	bh=Oe8sMDXTgYZbHpucMwt4Ltri3OAa7lfxKOaUfNe9OQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOYnccG3W+yILRHtdgQAUgXMxP8P2EEJOyAaEexKGskwLCpvbGDxN1Id/pG05eJiKLXSrfOUs2GF7Chbg0UQtEjxALmnA11PH3S+NpNLMHRO/iu8CbOEmYF0TxBopIz7aVYcJpafVNbCcfe+jfrjDF4K5CuUPaXadbJklEabCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAQ3WZo8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAQ3WZo8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81e83f1f15aso62701727b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753104; x=1785357904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1e+FEkn8ZNVfswNcJcEhwet1VhYX6YaEYqSmwraWl2w=;
        b=cAQ3WZo8bAEeNa1l2EFzkqomGyMuEAvP9Z+G8bRCzOVismOe1fa6tsqSWwLJBr1u85
         KKBPvtHEhCU2PitJu/O/qNy4gZBw8cE30uGT1//dPvr714aqqEM0OVKQGAeI3ZvHq6pl
         4zkGWlj8TSxd35hLP05P5OpBfAfAo1bsN8BXGJWEXAjf7lm8bVFoRrUVsC2e045QCVpY
         l+nS/8aEySsRZYZFWH+pznKP29/PVO66wrpr94GIhKQaDiRca9tKmaNBZo6ovlFlfd6E
         k9g9IwWmK7un+6B9k3mp72iOvraamBGRHMoeOFyXcMgCVcOb6SHYHUlmXI3ys7yKU8b4
         nqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753104; x=1785357904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1e+FEkn8ZNVfswNcJcEhwet1VhYX6YaEYqSmwraWl2w=;
        b=Cb5uBv7Ii7CJ/BMGBqClsICISAQ1l7+JCqccJpUIpeq1jg3bTwh22M4IsGRmEi8B+d
         zGIY457L0+29w5H8KvV5Ihax52JDrcNYyt9yBT45+gAtWJXmgszmPZl8zQ2+TMc4vRhU
         KW81pZS6uS87qKwDVBJWi34K1t5LZpwPDaJVrLuoI/UyXtSH2KJDeSwetFGPtAtAyJe8
         zno5vEo6l1Er/YZhntdFyru9KfrgUTCXNAFzKZW1jrzHM9UirEZCYlP5fq/i6O1JvRqo
         m0n8ZpcdFKQ6O1u8IRr5RFp/Eg0e4dM274xhrV/k0m16MXYQZ236zmsL2Ri0EZdYBy3B
         VPQQ==
X-Gm-Message-State: AOJu0YxNLCXIlopN07hbWgiFvdamZ14u8az1rX/BOuEMmqX01V71npMv
	Em42mJfhhiZEkDH7R1ZhDtpE7FDh2/++7biza6GFc5esz+Q+i5c+LP1C9FypIdCF
X-Gm-Gg: AR+sD12GnUkvOs7CAVqNsoH5oRmjCtx2k6ESfSjIm6nQ9y+q6xmwVMgZn9+M2j9ghG4
	0eCs9xe2xeBVxwMenDeXZEYUqxbGf8ctMJJwtsfx6OI8FZJldCc7DLUzBs3AODkAJhkht54nxQM
	iGc3RKCqwz18Fq9FImXdPqcGEmqp6o1yzEZIw2lbp5lsFCIC7T1oeQ0p1k4wnB5QYGJPxfHjFKl
	e061V+zZAUH+syog0IPfi+p4xBlNPsaxHe/CfWJltRGZJ+Ei07Z5lY60PZgVcv5pLJAXiDcBE19
	caRFHuqkQzmLRU3YCjWN+ZhfUvylG11XaP0pjLONBhLL9BC+w9InKl6UCMSazJfI6qNqfbi3dEd
	I2h+aUDK5sLAw6V0XngE3G7hyp2MTcRK7AlxsnnV/RuXb02hGXNhpwlGuHTVdZ/JqCOcEEi6tBg
	mng/qczt1AxT8rny3agaX5RBzq5p+FXtD2HcoUNM+d/27ks1w7PIOsANl9+W80c+7j6520DhzUA
	HlacQ==
X-Received: by 2002:a05:690c:c704:b0:81c:adf8:c312 with SMTP id 00721157ae682-81f33d3bbd0mr13085327b3.29.1784753103814;
        Wed, 22 Jul 2026 13:45:03 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33bf2df0sm19506797b3.6.2026.07.22.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:45:03 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 2/7] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Wed, 22 Jul 2026 16:43:48 -0400
Message-ID: <20260722204454.3234605-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
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

Sashiko, ignore pre-existing issues. In particular, effects on
non-EDT packets and when queue or sk rate limit is set.

Sashiko, pacing offload is an optimization. Ignore that some packets
may not get offloaded, e.g., when txtime is a few usec in the future.
---
 net/sched/sch_fq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index d4cc8bc9fa06..36006f69a875 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -399,6 +399,11 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 		    READ_ONCE(sk->sk_pacing_status) != SK_PACING_FQ)
 			smp_store_release(&sk->sk_pacing_status,
 					  SK_PACING_FQ);
+
+		if (q->offload_horizon &&
+		    fq_skb_cb(skb)->time_to_send <= now)
+			skb->tstamp = 0;
+
 		return &q->internal;
 	}
 
@@ -707,6 +712,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct fq_perband_flows *pband;
 	struct fq_flow_head *head;
+	u64 time_next_packet;
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
@@ -828,11 +834,15 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
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
+	if (q->offload_horizon && time_next_packet <= now)
+		skb->tstamp = 0;
+
 	return skb;
 }
 
-- 
2.55.0.229.g6434b31f56-goog

