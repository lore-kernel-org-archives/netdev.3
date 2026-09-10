Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91A53D0BB
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060322; cv=none; b=B0jbZqGivDL/mtEiRCjdiqApm2KHGg08Njh+oKhYen9XKcwqIQdYmAMS1Dac9Il9SAlb6XFbqacH2NGUuMfUITDCmQiJo2Sjcsujrt1uTQVI8eTFe4NsBOqqKvSi9KGw/ra+lz8FNI0OCyPpjLRu1E2lBzoWBeU710daA28Gnd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060322; c=relaxed/simple;
	bh=7dS9wpp2YccmxHIywJXeSpOMA2g4XHnwuDriRcxrCuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEpSOp/aC5ax2oDt63LYQLhkUQSPBGf+mcyd1A6ourae2U036SEWxNj21rZyAI3Px3OEyVk3ve8+tkAczFcIYmqpKAumT/icvvvqIpW9Hgdn317+ZqqSEuL5nB1dh74zEzGJY59PyeooRh9nZIcy+Vt+9dv7CtcvusqzsvHmoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfjtubam; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfjtubam"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-671061b015eso2901295d50.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060299; x=1789665099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k/MRknm2NzoW/h6T0OXKbuYc1GhrCHd3P2gwiJO8u9s=;
        b=SfjtubamJI6jH2AuvXaO8HciEE3PhIFFGOesDb8ISGmzfoO9/yCfTp/GOAOkYLVJi3
         wKUrhfpivl5rV/SJ2PWCt+33bCadcmL+/23X36PP53HclIh+6Ns/I8A8jqrRTqcrYCC6
         1Yb84FP5uNe5Kr0Rw2HRTfuge0X/w0lJc3SUcoaiMouwM07WCHdfGx4X7Zs2OyCIi61M
         goZGNnDvLxIW8WSYXnLM7JKPtAqPX71o31gbdOxfKoBF7nsrHPbj5J/jVyLLYZ6QGqH5
         7WkW996ikFwPm5TjS5ukOmq89L7hUlPqkoGUD/HRLhs3H+w02q9/3V0vYcmGo2MF3wbc
         3P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060299; x=1789665099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k/MRknm2NzoW/h6T0OXKbuYc1GhrCHd3P2gwiJO8u9s=;
        b=TO+ILcLbutFodMIoI6cWjKj0IvwcexTrtnPKpf7TNZyNAG7DtAXeKkKQUSyHuUfz0o
         JjYs2bKt+YUe5tfxAjxNKYYVpTla3U/uSxWyfmh1bUZzleZjcStTIU+xzSEHWJfX/Zst
         ks2xNaL8XiN64oRUIgsH3cD82DeR0LZy3TJ/yP3XduSfjBjd+eocg99dBbW8fzbWcCev
         fYIAStlM8fpQeb35lnVeZmmAqzz9CVpC4m7GEDW31YFe50jYB5DxFfuHFBODIon+L/z4
         b1gQufnJhnGU9nFieTNmkpMSnGhQ3qU0at6CL3eoekJwQ+jAtVAejib8A04fCIVCSOGM
         SVLw==
X-Gm-Message-State: AFuF++kmAN79Ew6y9UUjp7u2e8RgZCe1M1IJED8bh0B77qF3tSY6CgR6
	/irJX7P/tttr6oUfde+W+v5yuxR17jbBv0Zd6DITyYaFea4Zx8wLXwgNUcCe4g==
X-Gm-Gg: AYBFou1YkKDAJhcy1Q3Q+i69duV5RdAH6cSJjd9dKM/HwxrqkevnXwTDLLWWgktfHGp
	G7dYRVXbFcAy09HlMyiqJIfikQKdWbcgJkIp9iQKksEj3KmmbXJlxRFTncAeNxU7Mq9TsfyE5v+
	qUfeY+B2Irteh+so9G2v1ztWFiTYrQ2sTnPKk3fbkHE6SAG93Q/0T+WsuF0yDlecXpdESgcR5mq
	sBqgg6Oy6OCn9pRjMzK9eLSqBPNcrWNC3iaLMYeRac1CQbXbZldf3Ss+JlZ3ZLALL3VQgmRIbj3
	VD0I5MrbwBRxja0/Bpa+deIeDXFnaNeLHAyj788LUUexG5CAD+T+U3sglj/ZWT0eNhJ0XTnStRM
	/hfePluuFAJGgtkFAKm26siFOm1zXem2XbZOIrGcHJaAWqGxiS9fTSlx4qlfp9Motr6OTEp6zDv
	Z9e1dQ7Jwfs1FJM82MLxMKsxCPnp0nLlGZBnNwiGFq6JwhmmVxgbwQ47XwNtykmsSQBZa/pjefQ
	N3HyA4frN4orFZvlcDy1acA7l0BJKKP7pvjONoWa67baTD6yy+AWsNLN4lzn2R3hU273IBIXsxD
X-Received: by 2002:a05:690e:1919:b0:66f:c1bc:c078 with SMTP id 956f58d0204a3-671246cfab9mr151451d50.64.1789060298970;
        Thu, 10 Sep 2026 10:11:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:11:38 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v9 3/7] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Thu, 10 Sep 2026 13:10:22 -0400
Message-ID: <20260910171131.2532487-4-willemdebruijn.kernel@gmail.com>
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
  v8 -> v9
    - (minor) use SKB_CLOCK_REALTIME instead of 0
    - (minor) remove comments to bot below the --- separator
  v6 -> v7
    - timer drift logic fix moved to separate commit
  v5 -> v6
    - switch to skb_set_delivery_time to also clear SKB_CLOCK_REALTIME
    - add fq_offload_slack_ns
  v3 -> v4
    - also reset tstamp_type
    - minor: initialize time_next_packet for more obvious correctness
---
 net/sched/sch_fq.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index fdd9380e445c..60ad87cb1275 100644
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
@@ -421,6 +424,10 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 			smp_store_release(&sk->sk_pacing_status,
 					  SK_PACING_FQ);
 
+		if (offload_horizon &&
+		    fq_skb_cb(skb)->time_to_send <= now + fq_offload_slack_ns)
+			skb_set_delivery_time(skb, 0, SKB_CLOCK_REALTIME);
+
 		return &q->internal;
 	}
 
@@ -731,6 +738,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	u64 offload_horizon = fq_offload_horizon(sch, q);
 	struct fq_perband_flows *pband;
 	struct fq_flow_head *head;
+	u64 time_next_packet = 0;
 	struct sk_buff *skb;
 	struct fq_flow *f;
 	unsigned long rate;
@@ -745,7 +753,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	if (skb) {
 		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
-		goto out;
+		return skb;
 	}
 
 	now = ktime_get_ns();
@@ -782,8 +790,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 
 	skb = fq_peek(f);
 	if (skb) {
-		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
-					     f->time_next_packet);
+		time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
+					 f->time_next_packet);
 
 		if (now + offload_horizon < time_next_packet) {
 			head->first = f->next;
@@ -862,6 +870,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	}
 
 out:
+	if (offload_horizon &&
+	    time_next_packet && time_next_packet <= now + fq_offload_slack_ns)
+		skb_set_delivery_time(skb, 0, SKB_CLOCK_REALTIME);
+
 	return skb;
 }
 
-- 
2.55.0.1007.g17ff1f9808-goog

