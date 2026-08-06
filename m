Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234944CA27E
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058966; cv=none; b=gy8tlT3C+zP2aDYX/ap2D7CJOzwOgRKLnsoVG0ELhcVz33rjDk4iPbnzNCZxx09hAInQpllEHDaa9T0laJjwJifzh9b1UAuoQfyMs/trJRXQCUsscLq9OxmTGrA1UxuwRSqpyMmEHKygzube3f1gXRMa7drrpcx4voBKoeFhkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058966; c=relaxed/simple;
	bh=q+qMQhAagbu4g4zdg1xSBEtrZy3xG3F+qHQRjjbqV2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWVWoTa8y7yATNksyxg/0bKtmer8ZcYCCqaI6M48zszqWmE8LkYlcc+10lWgaVwhx/eN0YILUIj9Smkrbm9uVuLEX7exLWUaavegBr1yOkJgiLPJ8kVKoGRjJMRd/GGpnCAYHaYdgbVZK6L7eb3BIUh0IeVMq9ZJ8pwZNZhGpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYXVFIEG; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYXVFIEG"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6688a2dceb8so1850639d50.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 16:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786058964; x=1786663764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZifFpVx4BW7pemc+Qe2nKHeySWm1EELGJZ9eoiY9qdA=;
        b=SYXVFIEGI8xFqcL4291aku/2ufQv+M54oPpbXj9kgrXBIJJfiHJNy/uAz1vQtvRtRb
         tH96xsgy+K4zXL84y40vsFZLnHVPNZMqWcPB9DWAkEOjVXfbEN3CW+yA4fN+1oJPJI0M
         XXW8aBPKTAGbc1kQ/VJWx+70i60xbf5Dhtr7TX5PBD51jFt2PE6FoNsaV20lycqKhRks
         xPxyOwEx4x0pMI/cbpcHl7HQoETI/ptrpWiH2s2qld82sxRfoWsigHisrzfbLwPftcyd
         JbBIPic4uHbWWTwudTrQyzVSZcdKg55+4r+KLwREU17n+uji0amad/TsbUjmysIEYn5T
         repw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786058964; x=1786663764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZifFpVx4BW7pemc+Qe2nKHeySWm1EELGJZ9eoiY9qdA=;
        b=EutWEpw9AVZlJurqnfgeef/8LD0mOY5gRaSGIO6abM4doXOxbLsgZuBNgSr5BNv/7B
         jWeovS+URYVmBcPex2PlpxPImkkFKIidMm60FYrsc+bgFNVipVQzroqZeFyVK5x7OsEE
         rMiiY0EuwpD8oKpy9orBKgvNpgUjeAnhucV50o7ofho2xTHRs+gggCB2d3rNmOqNQDxZ
         rIrqPBEOkH3Zau7HFZdTSnxvVuBGGvOeS+m2vSXrDHiHNUmr1eGBv5OydjDYGQ+/lY4F
         xJDXEq/Fxit6fziF1mhlvxw9HENNZGKENxyrflhm7SrV3W5COQpPaM1ZtDzzIbFkVDhb
         qGRQ==
X-Gm-Message-State: AOJu0YxtXqRzYyRGRvCYoew/Y8enCL87Sd1dB1fMZHVuyqxL2kiNFDyR
	YkSpHZXM/mtid+Gd/xjX1fo1njApPd50XadJ36nhcUh+pgRkE+8wGQXK20v4xg==
X-Gm-Gg: AR+sD10JT+a/QBXPaQ/+BqqzyU05vOSZUTFajEEHeVOtF71GLTOzsCKo0F9ib7JYUbE
	qHfHBo6rIEvYCeMaYJKMP7tDUn4tL0mu+aOTl2TzVNfwL6fxCKa71XPhXWIBxki4HKiUy1HEkid
	ZMLO++2uBkUAq2sRpy9QCrlniiqsqMwV2hwvPK88A7khpQ9igGNHd32QKm9yyF6pYtirlIQEj9M
	8umrW/p37nj9vVTY+vskRiCiCdk/J5YVY0yMVJMjKAIC1kg5rCbsAYoPNaRpz7rosjgXohIFnNs
	8kVTqVKvDY+8fLlmy/YbR2nb1eU0j1pdDCnCre9h2pU98CsFLzwW2zUC6Wt3VJTn2wYrJYs0MaY
	A+vJR0t1y3hQCEs+ElM7XSJcBMs/RMFotpJyLlmH8O0B711yFL3T1yOp/cK/GUf66yBkT3UVvkq
	rXi9N+ls9KLCaxHYeMrOuJA9n0yDezlhtDlcXqBdSkGicZ8dXZ47/R1qMRt2dfQSKxjTLmTKBKo
	FHN5qQy+yf3HW0woias99QBRT+rC9hovtD7J5DpJzi/6FX0t8nFfNtpcnE=
X-Received: by 2002:a05:690e:45:b0:667:b645:5303 with SMTP id 956f58d0204a3-6699aba143dmr8358514d50.33.1786058964059;
        Thu, 06 Aug 2026 16:29:24 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:29:21 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 2/6] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Thu,  6 Aug 2026 19:25:59 -0400
Message-ID: <20260806232913.4020403-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
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

