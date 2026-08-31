Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016F302CC1
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211950; cv=none; b=M1zx2W5ceyt6HvUgN0zUcpLjXNWxZYrB+ICTJQplwcjsQRPCwaBEpRERodBLlnlvnFWjUuhOg0x4eC3FMKqd3ePYSRSHJf6V8yzVQqoHcwPGv/pk0FsPHsy02NmAUvc2yF3leJlzTAIQAnmk2ufcTRdD0tTK2U+P5sE/Rd2DJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211950; c=relaxed/simple;
	bh=gQ/AH9QS1AeP33hITRcdU0qfxqdKMtfVOxyzjIcYVbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry+ekXBIHaWfzyw1dpGR2zZ0zVLXhKeo63fd3JCsK+PUq4d+24NUyxGGBO0iZBpwKEAfZN6DVV1wst44E5/uBA9mZdrwBUuUpVxiI9a5BuLZhIuulBWoMjNYFnydxe81/1z1i4jloWRo2qvPP/T5xUivE4W4k6yZDHIVY4daTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYarZK7T; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYarZK7T"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ed2a06b9eso2350217b3.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211948; x=1788816748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o31oatDPPN04GdkXGFwCe/6RoU52wA5TDD7YymBJNzw=;
        b=nYarZK7TF+wfVfP7ZpqvWxS0saCPk0zTFbf+owNMnN4Ictd2H4Q6Z6FT7nE+xN8o/q
         smhXpQZWhKplpRQLyqzEZ7YzBwORngn7jEt83UPWNL+RkRTf2+Cahy4TvGWm3LZoIHji
         dvHrBsZaUh0wZ6l8Um5zy+VpJ2xmP6W5VQKMTxNK1xsZLq7OZDq/NZi4Ob2YD57RKlNj
         kf0Oj3LRWA5w3ogrmubN/jWdznoJFJcK4wB4kQxSh4al3kgYrq461tFH8HYhrZiFIfd1
         Vfbhvuqbeg8MEnIcXsDjbWTRhF9MwQnKWsTfCtQMWT2BfTltWodywhsSGmGFIC6YnyiR
         hlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211948; x=1788816748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o31oatDPPN04GdkXGFwCe/6RoU52wA5TDD7YymBJNzw=;
        b=jZ6/hMZ6ybNxtaKnjCy4kwiZs4z1nyr7LVidOiRnFB/d+cErcpczXLYrZv+yzHd0/c
         Xi1IfPw55okFTBaFDuc3gRNM20AcpnVSxzdHsIhnfNfUdrIBHBZcZ00TSxEIQMsAiO9h
         v1iOB8cbBKCz7fidlYd2SOWP9MSad5nfy+PYb5r0HxYUdV4eAGE6WSqSHOupIqufxNhu
         C+0BdcVjyVvVA5cP3KbxBXQrEHsb9slROBKLHVET44t5sbsSKweYZe+usmLyhTHnzr1z
         S4Sv1qDbsauAr6rqkKT/MA3ld4jfSwTJkTcxhZa3EB0ASqZN6ahSnj/H8arYVoGvRokh
         BMvg==
X-Gm-Message-State: AFuF++npiHuyZxR/bE0UXGQa/LsFOl3LNIx6ej6vDEOOuTJf1KQ35WQR
	0ce38dvfz3Kc8KNcgi+RTRjFyxd1VzJmYXXNI4PqWLYBVsXlhvGiP+Smv6dFKw==
X-Gm-Gg: AYBFou1mjPUYDvbxSS7gxXWFI6y3Xx+ayjFScrrWmQRgKGzz5hi77mzueM+EiTK4JpF
	/x1DEXGnIVL94NIJ1zRJ0cEfrcXSEJ4ofSqQVQ+JazlBwJU6B0EWvRZ+18ugEAM1lTWCIy9r/mB
	1+jV8r79ocjWrlyptDuvU8wDtws0YxpiKp2VIRfT2PImUVcGYwL8Vc231Lds2nGAZvg93VUHyYm
	YLLbSui82qjtyuEz4iUdIu1nv+whG0sQUpEhrwzZaotFOlZTEadt9WhqH5TSZEWdoKg+lTyWBAW
	ULpK8TxZ8NC5uedIyyHNxVn9q1f3yM2yYLLB9d412FJN5NbjJBLzMtrNDYeVXsoE4hgK8RwSF73
	UXBZn93Rg774tNR5eeG/eYM9gD213PmE1bVUHjPg7h2y7LhDuMOkk5vPPA3D0D7FPMBB8OaVJl6
	AmxigIjyWP40Ym1tm07d90yBdAT/LeO4nc8KHyJFoyey+5x7dCgEpRTnwcHcZA+8Ch9clVfUWn+
	1xxrz/hdTlYuvIO9D3Q4Pd+pfZab1QBUckJILKELsDw/TZyZ4CXp3fM9r3BO1jk
X-Received: by 2002:a05:690c:a584:b0:833:f9bd:b289 with SMTP id 00721157ae682-85d6c9ea406mr99143907b3.31.1788211948056;
        Mon, 31 Aug 2026 14:32:28 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8616243a833sm45474307b3.13.2026.08.31.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:32:27 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 2/6] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Mon, 31 Aug 2026 17:26:11 -0400
Message-ID: <20260831213221.1370774-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
References: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
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
2.55.0.897.gb25b4bd76c-goog

