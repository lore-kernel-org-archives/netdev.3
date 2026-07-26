Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA1379C3E
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097754; cv=none; b=l/95sDFqvvl20RHigilyVahURQvu+Gm734XkwAzqqFWhYrvJTxu6s7PqPkmQ0gpdZ/oWDaKRpZeKv+e9UAzg5MckdgSZOkKibmQyk41F4KeoVhLOJnpPbJT06/UZPSaNRZ3stOxyNE9X0rwkuup+bmocUg31Zoqi/eztYDAqWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097754; c=relaxed/simple;
	bh=R07v5r/3EKZH4RI7nN59gSKnzszYAPNhYuInTV6s9Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amdjyXBDTGtw0LNpYvcMaBxzF3VhyMaQGO00Qd41KdNxeESHh1bPtPkQ7lHmZ5RU01LsHBLjVJk1FNosz005S9h/H6vYXuCr38+ihlfX5PRNJRCAHP74E21usnefP1WhKFDLwZ2YlpOzmxLSf9z+3t+NB0eM4e5ejPs13/5KNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N77Gt9n2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N77Gt9n2"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81f64e8dfbcso20766527b3.2
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097751; x=1785702551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mJQZaEZLVGAVK6oGKY8nnPB72V7EJUqO81tk2Sc+rGk=;
        b=N77Gt9n2VhqOC/Rg82GbPkdsOdoK2J1lmbwKrLQBggc3u9s/qn2p8Tn5JCqc32Z9P8
         UFB05w578iYiKF5waL2Z1XZliiO0zMksEOlRjpcwpNaJeM4aRblRLzMuejJWfhdKDJvn
         u/Ghb9ob3ZoqplZnXH4t5U6OWhOGUEz8H32cWMfl7LxR1WE1HOiPhyEwKmvlBBKetIR5
         3f88xU9dLwOKwzjzf9XkaDY2Zsc62G6a5ZgcNsFKY8VJdQ7Su/xho9hLxldOApFqUs6u
         cgA9qx3VWjzZusx6nbWQl1yTT9Sz1Axts5aIf4Chu59/qAx5JYFLLij9+Jo8EZba5Tyd
         GGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097751; x=1785702551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mJQZaEZLVGAVK6oGKY8nnPB72V7EJUqO81tk2Sc+rGk=;
        b=lhYk5K0k+9lRC2RS7N/j2/4PfHDih+rBthTf8gUOrOzDUNRmGGyVYbmerZdyY3fQZA
         zlAW0bmBFqlUYwNhEAyAP+q2NjvthZBmSINfPKZufFvxWaVRZ9GT6HhVvD3Wd0pPgwVN
         HJLQbc4sLgk4f/haKqLq0KoaN9SLzfToZyDYrRrtE/YjH/9niFn27reVECW1Bk5JSTT+
         RCX9xOMIlh94ggpNLRbqxKIhpLWCK+9LmjEVmSVqfjhH1uiqpELmwJ9oX2asznoHTEYp
         vKryDbkGh/fYdbKMuj2/vevlctwBj7g6PGLRyG+T7RdBuLMXc0ITpepVmaIEYzEgrnhM
         ccXQ==
X-Gm-Message-State: AOJu0Yx+Ypxu8DsdVyx7HXuKbEkaN5iFp00X9EObLxqW7mVM+TttEv/5
	G0+l00OxQ097F8egF8Ry2K4FR1aWWuRbMaIr+fztUZZqy0B7M/LhOrLpHDVpn4jb
X-Gm-Gg: AR+sD12Ja/o+nOW3tmn21PULuAKD2XhXsVVAfehUPLh5fkQ+4tZHJyTuXwCtkJAvW3S
	N3SUO4aV4J5rQ1O2R1aq5xvbL76UlQMEFXqthVJ5ax98OiBzKPMOiODM/xUwcE27O9vQdJWxwQF
	SH2UkVY6JDBNQVVyF0A+OFVv9cV9e1IrfBMDhipqW/rbl2gMzqHn82x2x5lMgyzXl0jKGEyfS13
	9UBnEb5JBRQcJ20gnrlALahYey21paubJFqh6EEyHaQ0IPjnP3qc1ArccqvSIefnzEweKU4pY78
	UPtQsM7B9Pdb4mkf1W+MNZPcWcKLnG+yA1Cq6WkjNwqGgRAyvYcXB8NEWv8iml0TZm433+xhMMu
	mNkrZSK4dspgwteiVuEA8N6jlnCDm/i8fmajdPpIBjyY9l3Ptqpna/uQk1YUE4uHBN8NAnH+MO2
	1e7nW0IAEtT30TVQOBRLhPmxPGASUJDpkW/4DT/arpfwvgxhDsQIcgnF3oDQF0ZAh4nNrh/fNl
X-Received: by 2002:a05:690c:4b13:b0:7fe:4069:d3fe with SMTP id 00721157ae682-81f69d44a11mr20993847b3.30.1785097751523;
        Sun, 26 Jul 2026 13:29:11 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm23339467b3.13.2026.07.26.13.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:29:10 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	mohsin.bashr@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 2/7] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Sun, 26 Jul 2026 16:28:46 -0400
Message-ID: <20260726202902.760552-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
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
index 0746e8da078a..cbf015df68cc 100644
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

