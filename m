Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0163D3CFF
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445652; cv=none; b=JK+2G13HpXknD7CW4OMUn8Ma3Ii3C9f/+tsd74hCIn4aWidGvbwS0gWC88gmljv8IsxKgNTf4d9ILaNeXtCZiHRt1V57b1hd7r0PjtEcf8gRMJFvDWce49qJ/H2klfJO2MH+ZJGdA4xPU/p6WE/WPO4Lrc35slRkOiEQpWcAvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445652; c=relaxed/simple;
	bh=QRbBWTzKqG6UZTKQ4O4Q9KAt4cQmNetVtaYKFaP7KqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ky339qE8kXRIPL8fL/qwG8skT7XqXpcdL5eF0cFWnfZ13r/qVBzqlgCGtQDza63rmXAZGOpz3FRGdIQex/jKV7mlwnOtNE7pujZAXqLXD46HlEKoW8BI2ymJnp3coU7aztzgPwdB52PZyu0iOE5P9yxVA7arsvTgqznFKMhVG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=g3OU/9C+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="g3OU/9C+"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5337fb43c16so26864531cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791445649; x=1792050449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBt09e6X116fpikNWJ8doAPuw7URW+MowBdwTa6ZXP8=;
        b=g3OU/9C+EvFCom5uwihKmOX8XVgxcKImJjCNCgDHpcZRbCH9RlO+A9rScD9bCzdaI/
         9ByyCXgnD8f/z6Uy8Uhx1wppV53OlRCknqWBzLV/JjK06/dndyLzT7HnPocCeE3Y0ZIt
         RjHlROHkemtyArpJCc7rykjLeROCROu1vGNac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445649; x=1792050449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBt09e6X116fpikNWJ8doAPuw7URW+MowBdwTa6ZXP8=;
        b=p1pdPDSVGL5bkueHy/ULgmFgm51radCq4Ow/ULXTl426Zt/r4DjvAv9D2PtTLx5b/r
         2JBVEHqp+EuTFqR6oNKFNlONSFVkRqgcyWsFG8NvrRQGUmJbLtF3Fl9UQVgHm/7t1iog
         vN3ioy6GuzdxXVW6E5MUkv4GCRmktWeiBxCJgSkCGH3ucM9MZSBMSFIqk0AVo2c+H95B
         KbqhoZjwvFOYe4aqtxVK54OK+aRh1w5GrjCRY14XlcJzsS52ZwdNUrWf+6coeW5SmhWl
         rwCZHlHgOIib3QI8IAf+7vN8i3lEOJlx9tMy99iUtEvHjxD9hFrfuln+ZYbPq39lBHtM
         uOHg==
X-Gm-Message-State: AFuF++nAZtFzdgJv5i1vT3pBeR1Rns2pl7zZeGLPuWW7kqvMW93xrpsq
	zj/qcySPSWQl+d1lpvcZGF608KgBSjXZI5hIH40FITPQn61Bfz/UbZBfeXne4/byHgVgW6rv0F3
	abBgX8w==
X-Gm-Gg: AYBFou0pmEPUFBDAHzU+56+Eg/m3JJFTauwiKsJ7d+Tj6plQKANo/Uf9cpDHoBUySmv
	9/kJylQrrWS8rHj6busQYulm77zfuZpnHpsj30pOUrDR0FcNjWQwP7EK7NP/n0vhABLnjiuSzOR
	UF74uZYQEYvnwnP3XhjH9Ff+3iELnLv1d1rx9IgdvF5ZYOqqEJsqeTE13wkkVfoTMdAiOGYMg+7
	vVH6UyVAoxIUcbFEE5p81qlXJ5JDoCvuoQJhH97354lDn/tw5sRqMzPoVdOLoTFk8V9gZMXZ6f7
	Bk28hyCmCrbTw1aYRvnSnwVuCBIc2AJ1dw5Os1gHAWareP7nTbunxE+9/C1mn8gQiRRVy2svdTa
	cO5/ahSk+IZDKc8k3os8r5OGAlRYUc9ojCS1MwAeqpYSGXfiRzp+uaCJUVVUwgsgEh6DAaxDCPH
	df628stHsHmF8BtQezJd1sGtBBWRo8Xy15S2cej3S9pOn93FCg2F8iUwjRo+emld2QEbAT2p4ot
	SY17OmclWL/o4YSwXlgHLW5Ph//F5l84obA6VpPj3COwwFYr5s=
X-Received: by 2002:ac8:5c83:0:b0:533:8900:4eb2 with SMTP id d75a77b69052e-5357573264amr78725401cf.58.1791445648684;
        Thu, 08 Oct 2026 00:47:28 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357213f3dcsm38253961cf.17.2026.10.08.00.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:47:28 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next 1/4] net/sched/sch_cake: serialize reconfiguration with the datapath
Date: Thu,  8 Oct 2026 03:47:09 -0400
Message-Id: <QDISC-5RTM.v1.20261007130704-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: fix
autorate reconfiguration throttling").  That change only stored
last_reconfig_time; it did not address the concurrency between the
autorate rate update in cake_enqueue() and the netlink reconfiguration
path, which the original review flagged.

cake_change() -> cake_config_change() updates the fields of the shared
struct cake_sched_config under RTNL but NOT under the qdisc lock: it
only took sch_tree_lock() later, around cake_reconfigure().  The datapath
in turn serializes cake_enqueue() with itself under the qdisc lock, and
its autorate-ingress path stores the estimated rate into
q->config->rate_bps.  Two writers therefore update the same rate with no
common lock:

  CPU0: cake_enqueue() sees CAKE_FLAG_AUTORATE_INGRESS, computes an
        estimate, and is about to store it.
  CPU1: 'tc qdisc change ... bandwidth X' clears autorate in its local
        rate_flags, writes rate_bps = X, publishes the cleared flag, and
        waits in sch_tree_lock().
  CPU0: stores the estimate, calls cake_reconfigure(), and unlocks.
  CPU1: reconfigures from the estimate and returns.

The qdisc is left with autorate disabled but with the estimate installed
instead of X.  On 32-bit machines the unlocked 64-bit rate_bps store is
also not atomic, so a reader can observe a torn rate.  iproute2 reaches
this because parsing 'bandwidth X' sets autorate = 0 and emits both
TCA_CAKE_BASE_RATE64 and TCA_CAKE_AUTORATE.

Commit the parsed configuration and reconfigure while holding the same
qdisc lock that serializes the datapath, so the netlink writer and the
autorate writer can no longer interleave.  Make rate_bps an atomic64_t
so a 64-bit rate update is atomic on 32-bit machines as well, and keep
the READ_ONCE()/WRITE_ONCE() annotations for the remaining lockless
readers (cake_config_dump(), which runs without the lock, and the
cake_mq shared config, which readers observe under different child
locks).

Conditions to recreate the bug: build with CONFIG_KCSAN=y (the race is
otherwise not observable on 64-bit), put cake in autorate-ingress on a
device, drive bursty traffic with gaps so the 250ms autorate
reconfiguration fires, and concurrently loop 'tc qdisc change dev ...
cake bandwidth <N>kbit autorate-ingress'.  The lost update of the
installed rate is reproducible without a sanitizer by running bursty
senders while repeatedly changing an autorate qdisc to a fixed
'bandwidth X' and reading the installed rate back.

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_cake.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..1c29695dc928 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -199,7 +199,7 @@ struct cake_tin_data {
 }; /* number of tins is small, so size of this struct doesn't matter much */
 
 struct cake_sched_config {
-	u64		rate_bps;
+	atomic64_t	rate_bps;
 	u64		interval;
 	u64		target;
 	u64		sync_time;
@@ -1906,7 +1906,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			if (ktime_after(now,
 					ktime_add_ms(q->last_reconfig_time,
 						     250))) {
-				q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
+				atomic64_set(&q->config->rate_bps,
+					     (q->avg_peak_bandwidth * 15) >> 4);
 				q->last_reconfig_time = now;
 				cake_reconfigure(sch);
 			}
@@ -2021,7 +2022,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	    now - q->last_checked_active >= q->config->sync_time) {
 		struct net_device *dev = qdisc_dev(sch);
 		struct cake_sched_data *other_priv;
-		u64 new_rate = q->config->rate_bps;
+		u64 new_rate = atomic64_read(&q->config->rate_bps);
 		u64 other_qlen, other_last_active;
 		struct Qdisc *other_sch;
 		u32 num_active_qs = 1;
@@ -2042,7 +2043,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		}
 
 		if (num_active_qs > 1)
-			new_rate = div64_u64(q->config->rate_bps, num_active_qs);
+			new_rate = div64_u64(atomic64_read(&q->config->rate_bps), num_active_qs);
 
 		cake_configure_rates(sch, new_rate, true);
 		q->last_checked_active = now;
@@ -2626,12 +2627,12 @@ static void cake_reconfigure(struct Qdisc *sch)
 	struct cake_sched_config *q = qd->config;
 	u32 buffer_limit;
 
-	cake_configure_rates(sch, qd->config->rate_bps, false);
+	cake_configure_rates(sch, atomic64_read(&qd->config->rate_bps), false);
 
 	if (q->buffer_config_limit) {
 		buffer_limit = q->buffer_config_limit;
-	} else if (q->rate_bps) {
-		u64 t = q->rate_bps * q->interval;
+	} else if (atomic64_read(&q->rate_bps)) {
+		u64 t = atomic64_read(&q->rate_bps) * q->interval;
 
 		do_div(t, USEC_PER_SEC / 4);
 		buffer_limit = max_t(u32, t, 4U << 20);
@@ -2686,8 +2687,8 @@ static int cake_config_change(struct cake_sched_config *q, struct nlattr *opt,
 	}
 
 	if (tb[TCA_CAKE_BASE_RATE64])
-		WRITE_ONCE(q->rate_bps,
-			   nla_get_u64(tb[TCA_CAKE_BASE_RATE64]));
+		atomic64_set(&q->rate_bps,
+			     nla_get_u64(tb[TCA_CAKE_BASE_RATE64]));
 
 	if (tb[TCA_CAKE_DIFFSERV_MODE])
 		WRITE_ONCE(q->tin_mode,
@@ -2784,9 +2785,16 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EOPNOTSUPP;
 	}
 
+	/* Once the qdisc is live, commit and reconfigure under the lock that
+	 * serializes the datapath, so a concurrent 'tc qdisc change' and the
+	 * autorate update cannot lose the configured rate.
+	 */
+	if (qd->tins)
+		sch_tree_lock(sch);
+
 	ret = cake_config_change(q, opt, extack, &overhead_changed);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	if (overhead_changed) {
 		WRITE_ONCE(qd->max_netlen, 0);
@@ -2795,13 +2803,13 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(qd->min_adjlen, ~0);
 	}
 
-	if (qd->tins) {
-		sch_tree_lock(sch);
+	if (qd->tins)
 		cake_reconfigure(sch);
+unlock:
+	if (qd->tins)
 		sch_tree_unlock(sch);
-	}
 
-	return 0;
+	return ret;
 }
 
 static void cake_destroy(struct Qdisc *sch)
@@ -2818,7 +2826,7 @@ static void cake_config_init(struct cake_sched_config *q, bool is_shared)
 	q->tin_mode = CAKE_DIFFSERV_DIFFSERV3;
 	q->flow_mode  = CAKE_FLOW_TRIPLE;
 
-	q->rate_bps = 0; /* unlimited by default */
+	atomic64_set(&q->rate_bps, 0); /* unlimited by default */
 
 	q->interval = 100000; /* 100ms default */
 	q->target   =   5000; /* 5ms: codel RFC argues
@@ -2889,7 +2897,7 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	cake_reconfigure(sch);
-	qd->avg_peak_bandwidth = q->rate_bps;
+	qd->avg_peak_bandwidth = atomic64_read(&q->rate_bps);
 	qd->min_netlen = ~0;
 	qd->min_adjlen = ~0;
 	qd->active_queues = 0;
@@ -2917,7 +2925,7 @@ static int cake_config_dump(struct cake_sched_config *q, struct sk_buff *skb)
 		goto nla_put_failure;
 
 	if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64,
-			      READ_ONCE(q->rate_bps), TCA_CAKE_PAD))
+			      atomic64_read(&q->rate_bps), TCA_CAKE_PAD))
 		goto nla_put_failure;
 
 	flow_mode = READ_ONCE(q->flow_mode);
-- 
2.43.0

