Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78243BCD34
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097768; cv=none; b=Btadc1ap3i7oXR8UJlkcLgWOuE+dB62TO0v8JoRyd6zassJzsBE7Wnwk8PNQNVdIuk4KZPOaaUuorq1dtl6jyQXs9wihxZOVtxPMJgF+rlBhamqikgc8L0FTsWwPWuEOPrhkgIWeAKeXptOHX3jEAb2sv77OhYpckYJtGo6CcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097768; c=relaxed/simple;
	bh=+s3Be2SAguQ7U/7sLekFSBzUDzNXkRRmRN9wvmEZ3P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6JAWJ5uJq58VegxV8I5YdrD353oZVpdN9eQjQ93trgmQfywYSvxAUWK89miGkf84AQOZiYpMO3S183vrav1WJPZkEvvz4T55TVI7YX4kuDlCz/ndGFceyGLow0Ms9G3uTGJUBgIZoRdq1HZaDq5kFeJ+4ojMuKaAsdZPQgqOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYOwkMDv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYOwkMDv"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ed2a06b9eso15202997b3.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097756; x=1785702556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfMs2PsJkuXBuNdefbYmI+UYUVlyWWZwc3YoVTl0+bY=;
        b=pYOwkMDvLpwyPu41qipusstoaui9YDPh4GDlyAEs+q5TJRU9B309Yx7FVlAAjErRvp
         lH87nP/zE1XHF2PQOBEBU70tuKfqvidhzuhpEy6/Zrz58jLdRx45t3TMislDQITc6BQc
         xqrd2eKLxZjrn0Idwa4mCoh5aWXClOMfbCdTPe1cWs/P/FgZie0RynQY88otShdZic/B
         3zr/Kds4oE7k4m1An2qbIirV/VuFU8uicMIjeQ6I8GrB8OQmyCQ9wGWhHIMjG6yp3DLT
         0UJHnb0iMY1kcSwhMD9vxFvjDKsHegAbpNqd9Dc87LAdeOCFnJlNduG1XGEwZWMDuvnS
         JN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097756; x=1785702556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KfMs2PsJkuXBuNdefbYmI+UYUVlyWWZwc3YoVTl0+bY=;
        b=NefP4AVfI8xUOO1n0zw7SRE/Dp2hog3lJoH2xOkMhWRQTj5L3JZHYgcS3Y80v3HD1E
         9YLE5z/SpuQ+/CiWf7xGCm4XQk7ys3BO3j3hpagXwimX07HHLGknE3dy46KZpnyxgigv
         m26d8KyLjth7dyXaSUG1JgIPus4kigwX3ZHf9LMZOyXYjTq5rKGfZvI0kYEQRgBMF0Gn
         jGhvHbq+b/DPc4hxgebDu7hk2+owxS7jLplDn/aeEx4JNLuYdifkzgIwjUeANTE6b2Ki
         2FobuKnUhHj89FpMSIRzjOwAVJjphZYLdHjXoDE5MR/dGqwzhJ5zkRjYCgUXzu93HWmp
         FpGA==
X-Gm-Message-State: AOJu0YxtfHkXKAwD3US+WotM2zoGhaYdLfibWwCdSsbz1W2mLJaBSw9z
	RFBwlqMIWV8T+ci5Ysn9+7UnYmXIJ0az2F1DpUA2xnSiZiQntdCooqZC2wyB6gSG
X-Gm-Gg: AR+sD13WizGOq+mWqKyh8fajWv+HFPGPBUNm/NDf3GTA6+hFYhpJsnUZrsqKCxnf7Kk
	i8CO2ujYHK6l7yPiuGuI8VyEXx7hEyEqat31sZwP8GzGUnv4EptOw0QsgEXzFLgyd2181McT2P8
	Cnbl6McA9/nKwAoLsiJ9I83T2DrUt3j1y8m0hIENgOhnaoss++Halx1aLlgOXfehW3GWjmV4nru
	oHSgmeoy9C0M+pI49PzOrq54XNaRpZRg+vPK9GTYyMgkJAuEvOPllpHn1A7PuIOHwmkk56zzO0R
	K6ihXyWzTfzwxSL7eADBRziGTtEbePS0R+wqMyENhoD11RPknhU1FuVGf9eQmRCIUug1GgO3kvM
	TtGSo5W3pMCpMGTeeIW2TsryYBpTut0vM9EVhdI7wP1bAj4zKXuFimVG0gML5Ty7txm0wSmBjwq
	CZMAen/FfG7Fp2W/0LppZAYbTSl3u7hXH1/Y2LbL40y/V1Krjm3Y93JM8EFktdQOQsIz3mnaf1t
	/PwZIJIgFw=
X-Received: by 2002:a05:690c:c4e7:b0:81e:a471:e893 with SMTP id 00721157ae682-81f69d25f04mr18989347b3.24.1785097755826;
        Sun, 26 Jul 2026 13:29:15 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm23339467b3.13.2026.07.26.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:29:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 7/7] net: pktgen: add support for SO_TXTIME
Date: Sun, 26 Jul 2026 16:28:51 -0400
Message-ID: <20260726202902.760552-8-willemdebruijn.kernel@gmail.com>
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

Introduce support for setting the SO_TXTIME delivery txtime on
generated packets. This allows testing pacing and scheduling features
in the network stack (e.g., sch_fq, sch_taprio) and drivers.

Add a new flag 'TXTIME' to enable this feature.

Add two new configuration parameters:

- txtime_delay: offset from now in ns
- txtime_clockid: clock to use (monotonic, realtime, tai)

The queue_xmit mode can clear skb->tstamp in-flight, so this must be
used without clone_skb.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Sashiko: ignore data races in the control fields. Pktgen requires
superuser privileges, has many such races already, which are benign.

Changes
  v1 -> v2
    - avoid data race on txtime_delay
    - same on flags
    - (minor) style: avoid two >80 column warnings (checkpatch)
  v1: https://lore.kernel.org/netdev/20260706133433.3142805-8-willemdebruijn.kernel@gmail.com/

fixup pktgen: txtime_delay READ_ONCE
---
 net/core/pktgen.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 5b4dd04d6124..7897e4220513 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -201,6 +201,7 @@
 	pf(SVID_RND)		/* Random SVLAN ID */			\
 	pf(NODE)		/* Node memory alloc*/			\
 	pf(SHARED)		/* Shared SKB */			\
+	pf(TXTIME)		/* SO_TXTIME support */			\
 
 #define pf(flag)		flag##_SHIFT,
 enum pkt_flags {
@@ -291,6 +292,10 @@ struct pktgen_dev {
 	struct page *page;
 	u64 delay;		/* nano-seconds */
 
+	/* TXTIME support */
+	u64 txtime_delay;	/* transmit time delay in ns */
+	clockid_t txtime_clockid; /* clockid for SO_TXTIME */
+
 	__u64 count;		/* Default No packets to send */
 	__u64 sofar;		/* How many pkts we've sent so far */
 	__u64 tx_bytes;		/* How many bytes we've transmitted */
@@ -666,6 +671,17 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 	if (pkt_dev->node >= 0)
 		seq_printf(seq, "     node: %d\n", pkt_dev->node);
 
+	if (pkt_dev->flags & F_TXTIME) {
+		clockid_t clockid = READ_ONCE(pkt_dev->txtime_clockid);
+
+		seq_printf(seq, "     txtime_delay: %llu\n",
+			   (unsigned long long)pkt_dev->txtime_delay);
+		seq_printf(seq, "     txtime_clockid: %s\n",
+			   clockid == CLOCK_MONOTONIC ? "monotonic" :
+			   clockid == CLOCK_REALTIME ? "realtime" :
+			   clockid == CLOCK_TAI ? "tai" : "unknown");
+	}
+
 	if (pkt_dev->xmit_mode == M_NETIF_RECEIVE)
 		seq_puts(seq, "     xmit_mode: netif_receive\n");
 	else if (pkt_dev->xmit_mode == M_QUEUE_XMIT)
@@ -1141,6 +1157,50 @@ static ssize_t pktgen_if_write(struct file *file,
 			(unsigned long long) pkt_dev->delay);
 		return count;
 	}
+	if (!strcmp(name, "txtime_delay")) {
+		max = min(10, count - i);
+		len = num_arg(&user_buffer[i], max, &value);
+		if (len < 0)
+			return len;
+
+		/* in queue_xmit mode fq may clear tstamp, do not reuse skb */
+		if (value > 0 && pkt_dev->clone_skb > 0)
+			return -EINVAL;
+
+		WRITE_ONCE(pkt_dev->txtime_delay, (u64)value);
+		sprintf(pg_result, "OK: txtime_delay=%llu",
+			(unsigned long long)value);
+		return count;
+	}
+	if (!strcmp(name, "txtime_clockid")) {
+		char clockstr[32];
+		clockid_t clk;
+
+		memset(clockstr, 0, sizeof(clockstr));
+		max = min(sizeof(clockstr) - 1, count - i);
+		len = strn_len(&user_buffer[i], max);
+		if (len < 0)
+			return len;
+
+		if (copy_from_user(clockstr, &user_buffer[i], len))
+			return -EFAULT;
+
+		if (!strcmp(clockstr, "monotonic")) {
+			clk = CLOCK_MONOTONIC;
+		} else if (!strcmp(clockstr, "realtime")) {
+			clk = CLOCK_REALTIME;
+		} else if (!strcmp(clockstr, "tai")) {
+			clk = CLOCK_TAI;
+		} else {
+			sprintf(pg_result, "ERROR: unknown clockid '%s'",
+				clockstr);
+			return -EINVAL;
+		}
+
+		sprintf(pg_result, "OK: txtime_clockid=%s", clockstr);
+		WRITE_ONCE(pkt_dev->txtime_clockid, clk);
+		return count;
+	}
 	if (!strcmp(name, "rate")) {
 		max = min(10, count - i);
 		len = num_arg(&user_buffer[i], max, &value);
@@ -1238,6 +1298,8 @@ static ssize_t pktgen_if_write(struct file *file,
 		if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
 				  !(pkt_dev->flags & F_SHARED)))
 			return -EINVAL;
+		if (value > 0 && READ_ONCE(pkt_dev->txtime_delay))
+			return -EINVAL;
 
 		pkt_dev->clone_skb = value;
 
@@ -2321,6 +2383,21 @@ static void pktgen_setup_inject(struct pktgen_dev *pkt_dev)
 }
 
 
+static ktime_t ktime_get_clock(clockid_t clockid)
+{
+	switch (clockid) {
+	case CLOCK_REALTIME:
+		return ktime_get_real();
+	case CLOCK_MONOTONIC:
+		return ktime_get();
+	case CLOCK_TAI:
+		return ktime_get_clocktai();
+	default:
+		WARN_ON_ONCE(1);
+		return ktime_get();
+	}
+}
+
 static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 {
 	ktime_t start_time, end_time;
@@ -3510,7 +3587,8 @@ static void pktgen_wait_for_skb(struct pktgen_dev *pkt_dev)
 
 static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 {
-	bool skb_shared = !!(READ_ONCE(pkt_dev->flags) & F_SHARED);
+	u32 flags = READ_ONCE(pkt_dev->flags);
+	bool skb_shared = !!(flags & F_SHARED);
 	struct net_device *odev = pkt_dev->odev;
 	struct netdev_queue *txq;
 	unsigned int burst = 1;
@@ -3545,6 +3623,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 	/* If no skb or clone count exhausted then get new one */
 	if (!pkt_dev->skb || (pkt_dev->last_ok &&
 			      ++pkt_dev->clone_count >= clone_skb)) {
+		u64 txtime_delay;
+
 		/* build a new pkt */
 		kfree_skb(pkt_dev->skb);
 
@@ -3557,6 +3637,16 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		}
 		pkt_dev->last_pkt_size = pkt_dev->skb->len;
 		pkt_dev->clone_count = 0;	/* reset counter */
+
+		txtime_delay = READ_ONCE(pkt_dev->txtime_delay);
+		if (flags & F_TXTIME && txtime_delay) {
+			clockid_t clk = READ_ONCE(pkt_dev->txtime_clockid);
+			ktime_t txtime = ktime_add_ns(ktime_get_clock(clk),
+						      txtime_delay);
+
+			skb_set_delivery_type_by_clockid(pkt_dev->skb, txtime,
+							 clk);
+		}
 	}
 
 	if (pkt_dev->delay && pkt_dev->last_ok)
@@ -3869,6 +3959,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 	pkt_dev->burst = 1;
 	pkt_dev->node = NUMA_NO_NODE;
 	pkt_dev->flags = F_SHARED;	/* SKB shared by default */
+	pkt_dev->txtime_clockid = CLOCK_MONOTONIC;
 
 	err = pktgen_setup_dev(t->net, pkt_dev, ifname);
 	if (err)
-- 
2.55.0.229.g6434b31f56-goog

