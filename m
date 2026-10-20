Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494016;
	b=bdAjKxoeAfEIfWFpE9ZCTd0GW7J4ihqk9mVwAw2rzP4/Ewtf+/6eaNNmoasV8zG8TQT6
	 JsllKez/YgTU+VhlkUluP/Nfx3cn4UCUSpZ6WrGf6CvcFdnsLKdfnHzigX76/y9P8N2i6
	 EzHpk5TdwyxYgIpskM2K1gHc6YzsElwEtb14HLJ+pVIiNyLHvkQn7RZDFrdBTH/sSrUFl
	 OVyaHQEBOVtMTc0TfX44YoPeAXXGAs4kw8japQvQj8FUrAdWQKLHW+ukg/0Trhbio5Eav
	 IGVisNn1Y+y9J4Ycz7sIkLGp8sdQtQ8ex4GNBAv+Z6tA2yhjvetxxreGKpyL7DchdCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=o8s7jLwbwEzkdmp69F3R584GvBbqe/nWZgEc2v9hYWw=;
	b=0Rx740u51RTWq/8F0n2uY5epUs76BXu/V/Xq+hrTM1XHYKMJjTXnAy8gnfhkf1yCRDoF
	 OP+PwHoaTzuxKc9KKOqt1ZdWkvcZkbXborpKnUefQMqqPDMvodD054pY2CgzzYTpROdEF
	 Yoq/ySHlNP29vsCeSGpsZnodtO6uSVupNI7kC4s8nNc77jozLDvUpo694qPj7tVa7QIgy
	 Xh3AAeGggfol5vToESKJRAG1qk9ZfvwgdhOaN1EHm1ODJrJOpqhwjZ02B6YHxkN4CZ16d
	 gGNkXuutacEonNjr+f3J0oI7N092dIw7l7Q+CqaqPiApauuHXb4QyG9IbeH8tf2D5ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=k03Ywafi;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0B606A332
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF0B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=k03Ywafi
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5365b48238dso20402571cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792494014; x=1793098814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o8s7jLwbwEzkdmp69F3R584GvBbqe/nWZgEc2v9hYWw=;
        b=k03YwafitnVoPt/DlvMtJ2aC3NEYocSi3MJiUOQoGX+JeVYV4fde6wGRGJHp/8Q+jj
         Sav/MYIMFL4AoWdkU7Vjt5gb5EjFTjr8wAi6TpyHJaNZKbXsEhEbKl2mHCXrr5lWKATw
         B0Y8lCGWDNn0Tw4gk1HIQZ2JGKepJ7ytJcEIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494014; x=1793098814;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8s7jLwbwEzkdmp69F3R584GvBbqe/nWZgEc2v9hYWw=;
        b=Y8DnijYx0TJKRqQMt+V/VmHRs3UcqZO9AQg4EjjYO4VBNQo/0OoQ0mj6WIovJEgxIk
         BBLx2gfPIV7n9hpzmjrvip2z4BLxrHstmDgXNXuQLSVhjTkbQdEd+t09Nr2c1wLKd0Kx
         riK+UPtz89AqKW6/dQTAU/RzEm68VBTQ4P17ZieS/6b4lSM76wPs+voU06/mNd6Shhj8
         pasKCZ69tjKgs5ehcQUySLKtBdhB2jTfwAfOuZyaVXFcV9U4mFY+FhMbT5ghFl6YCI33
         STgzICr/DQM11MMh0VQ1bY4dO+JouOuq83U9DQz1KLIDjHXA4m760dD71QNJnhVeazWA
         MtBg==
X-Gm-Message-State: AFq9FYJYsLFscwS5MwY4wjFHIYbN7zvN3VAOWyt4Pvxck9Q7QZh/CYls
	YOWe2LOGSiYvjIZ19gM7HPy+C3RkRUjBkxpVa9BlsAGzyXRq8pcADiXsAB0fGE4mY3DHjVVYHUv
	MQio=
X-Gm-Gg: AYBFou0Z3XdcOsP0Q/8+EgcMiQN6dtrK1oen1uEePJj1u6gJh0ettM7ZDWZ5wdcORd1
	1aINbpz5CEJNuGUU/TSQarGjZtX6ui+QGSuMZOf1N7uAo/9s5Hy8QsnswP+zueZZhLuyuJ2R77B
	ochZg8axv3mmO+cAp7YkNF4ty08wQa1DXAWRCFfSehyY9QRh2+gY8zVVZCiVf243O40RFyLbrF/
	wG6k8nj7lp84rYRZODVx8fZ9GZTAA/eAadr6E+swrPtY9c+C9lpXbCBZETsIoLAw+S+A1GKhFM6
	WWVxTGoznKmqy3vZpHilXYsKI7Cc+Vpr4M1ImhdK0MjRKVgkOdgZs2obKY7UyRk6uD0XsNi3+Qj
	kvyD9L4f7saqIdSX2G3h7BqfLrHrn7PPY3lYrqek5Fre5IhiXLjX8V9HOuiJEh7vuEeIKhsN5p4
	9ER9ogDEKiRI1Y4KeIDEw/JaQBnWXA4thIWXiPXtXmA4+tU1ylRZmjvPB9DBEhdAnSKDOLWgJlM
	vcj5TRFUcw1ghwjlJ8PdOCNnGl+THQkV0QIZnGOS0OwwGOk3Lmluqg=
X-Received: by 2002:a05:622a:4187:b0:536:6ff4:652e with SMTP id d75a77b69052e-5366ff472a9mr70980151cf.56.1792494014493;
        Tue, 20 Oct 2026 04:00:14 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040e6667sm23382356d6.39.2026.10.20.04.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:00:13 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v3 1/4] net/sched/sch_cake: serialize reconfiguration with the datapath
Date: Tue, 20 Oct 2026 07:00:05 -0400
Message-Id: <QDISC-5RTM.v3.r0.20261020053711-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com>
References: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: fix
autorate reconfiguration throttling").  That change only stored
last_reconfig_time; it did not address the concurrency between the
autorate rate update in cake_enqueue() and the netlink reconfiguration
path, which the original review flagged.

The issue:
cake_change() -> cake_config_change() updates the fields of the shared
struct cake_sched_config under RTNL but not under the qdisc lock: it only
took sch_tree_lock() later, around cake_reconfigure().  The datapath in
turn serializes cake_enqueue() with itself under the qdisc lock, and its
autorate-ingress path stores the estimated rate into
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
instead of X.

The fix:
Commit the parsed configuration and reconfigure while holding the same
qdisc lock that serializes the datapath, so the netlink writer and the
autorate writer can no longer interleave.  rate_bps needs no atomic: it is
only ever loaded and stored, so plain READ_ONCE()/WRITE_ONCE() annotations
are enough for the accesses that run outside the lock.  The lockless
paths read the rate once into a local and reuse that value, so a single
coherent snapshot is used per operation.

The annotations do not make a 64-bit access single-copy atomic on 32-bit:
READ_ONCE()/WRITE_ONCE() are still two 32-bit accesses there.  The lockless
readers -- cake_config_dump() and the cake_mq children, which observe the
shared config under a different child's lock -- can therefore still see a
torn rate on 32-bit.  That rate is an advisory shaper value and is accepted
as best-effort; the state that must be consistent (the configured rate and
the autorate flag) is written under the qdisc lock.

Conditions to recreate the bug:
The lost update (a) needs no sanitizer. Put cake in autorate-ingress on a
device, drive bursty traffic with gaps so the 250 ms autorate reconfiguration
fires, and concurrently loop 'tc qdisc change ... cake bandwidth <N>kbit'
without autorate-ingress (specifying a bandwidth clears the flag).
If the autorate store lands after the change wrote its rate but before the
change reconfigures, the qdisc ends up with autorate disabled and the estimate
installed instead of <N>; reading the rate back then shows the estimate, which
an unfixed kernel can do and a fixed one cannot.
(b) The unsynchronized access is reported by KCSAN: build with CONFIG_KCSAN=y
and run the same trigger with the change loop keeping autorate-ingress set;
KCSAN reports a data race in cake_config_change / cake_enqueue.
The non-atomic 64-bit store only shows up as tearing on a 32-bit machine;
on 64-bit the store is atomic and KCSAN flags the access discipline instead.

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
Link: https://lore.kernel.org/netdev/875wzctsky.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/87ld7t3kl3.fsf@all.your.base.are.belong.to.us/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

v2 -> v3:
- Reuse the rate snapshot in cake_dequeue() and cake_reconfigure() instead
  of a second READ_ONCE() per use, and order the declarations longest-first
  (Björn Töpel).
- Commit log: scope the annotation claim.  READ_ONCE()/WRITE_ONCE() do not
  make a 64-bit access single-copy atomic on 32-bit, so the lockless
  cake_config_dump()/cake_mq readers remain best-effort (Sashiko nipa).
- Conditions: make recipe (a) distinguish fixed from unfixed (the change
  must clear autorate) and separate the KCSAN-only effect (b).

v1 -> v2:
- Drop atomic64_t for rate_bps.  Per Toke's v1 review, rate_bps takes only
  non-RMW ops, so per atomic_t.txt SEMANTICS a plain u64 with READ_ONCE()/
  WRITE_ONCE() annotations is the right shape (no atomic needed).  Reverts
  the struct field to u64 and every atomic64_* back to READ_ONCE()/
  WRITE_ONCE().  The cake_change() commit-and-reconfigure-under-sch_tree_lock
  fix (the real race fix) is unchanged.

 net/sched/sch_cake.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..d71617aa56d9 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1906,7 +1906,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			if (ktime_after(now,
 					ktime_add_ms(q->last_reconfig_time,
 						     250))) {
-				q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
+				WRITE_ONCE(q->config->rate_bps,
+					   (q->avg_peak_bandwidth * 15) >> 4);
 				q->last_reconfig_time = now;
 				cake_reconfigure(sch);
 			}
@@ -2019,9 +2020,9 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 
 	if (q->config->is_shared && q->rate_ns &&
 	    now - q->last_checked_active >= q->config->sync_time) {
+		u64 new_rate = READ_ONCE(q->config->rate_bps);
 		struct net_device *dev = qdisc_dev(sch);
 		struct cake_sched_data *other_priv;
-		u64 new_rate = q->config->rate_bps;
 		u64 other_qlen, other_last_active;
 		struct Qdisc *other_sch;
 		u32 num_active_qs = 1;
@@ -2042,7 +2043,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		}
 
 		if (num_active_qs > 1)
-			new_rate = div64_u64(q->config->rate_bps, num_active_qs);
+			new_rate = div64_u64(new_rate, num_active_qs);
 
 		cake_configure_rates(sch, new_rate, true);
 		q->last_checked_active = now;
@@ -2625,13 +2626,15 @@ static void cake_reconfigure(struct Qdisc *sch)
 	struct cake_sched_data *qd = qdisc_priv(sch);
 	struct cake_sched_config *q = qd->config;
 	u32 buffer_limit;
+	u64 rate_bps;
 
-	cake_configure_rates(sch, qd->config->rate_bps, false);
+	rate_bps = READ_ONCE(qd->config->rate_bps);
+	cake_configure_rates(sch, rate_bps, false);
 
 	if (q->buffer_config_limit) {
 		buffer_limit = q->buffer_config_limit;
-	} else if (q->rate_bps) {
-		u64 t = q->rate_bps * q->interval;
+	} else if (rate_bps) {
+		u64 t = rate_bps * q->interval;
 
 		do_div(t, USEC_PER_SEC / 4);
 		buffer_limit = max_t(u32, t, 4U << 20);
@@ -2784,9 +2787,16 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2795,13 +2805,13 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
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
-- 
2.43.0

