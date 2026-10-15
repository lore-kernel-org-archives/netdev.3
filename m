Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C623CF699
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060374; cv=none; b=idYqjOW5lmtzUbH14T+XXlGLURsGg1m0jz8Fc8WfgGZMYy8NTvG6G2drkuSyIjTIdU59UiY/1u15F4j0h/ekQXN0vjg1aegtaI/YYsg52ZL9tje8bdLge3lxdg8fMlh92h/Ib+W70EQo4vYejMmbxGspO6ttSIA+fFbihWxhBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060374; c=relaxed/simple;
	bh=VmwVC3z7R0x5li2+jpa6eiWczFRNFMZvHNwb0H0F1jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMhueXy6gq5km+znWQgiTIh6eSnPhJUHutrmxBGU2wPnZJ13gGxaYJ7ykZ65qzhzmt3RhMnPLjF307+Z1b8cKH6rTDjkedYnPIyF4AXZgewZWPXnQgiMZOpqPBk5NPXjwSf8uYJK4XTqB+MSpvUdrTL6UABqQj/hVX0W7TqBky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=TzMYhVB6; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="TzMYhVB6"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-917a4b69a79so60696836d6.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792060372; x=1792665172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLIkzoYXG1Kln9Y1WBkDSiySFhY2wZnV2u+5d5Kewr4=;
        b=TzMYhVB6aqTxzbc+f18yYvtXxQXUXsEg7Jr2vgae+gthLvRx5gj36ABp1x3+tZuqUN
         cLNSWrIx2xWGICBKQcwkd22fipMyZrL1su7Rj0N/+bl8OTax7ErOtF9WGYyjaYN96pFP
         mi2CREAx9rLWKRQbKimz4UtI/L6ivRZNiG93Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792060372; x=1792665172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLIkzoYXG1Kln9Y1WBkDSiySFhY2wZnV2u+5d5Kewr4=;
        b=wS+D7MzjfM13YlNVApo01+rKDZTZeHOdv2x5zZW/DoxMNVQx7rgK0rzVeg2OYeF38W
         PZAfURw6rALCLbofwdF3gCQwTvy4bYPsjXSbF2+95n7lGval1JbkHlMJ1JAVqi/z6nL2
         ix8yyD4Lz6OjUJuse23z7YzPO89jR2YQ++KZpgrFq1z9xsgNUjXm+3iob0zN8lus5Xfu
         1E01hkmbaJCymh0SPmjDn6S/hnXVsDFUeQ9ru9khCIOa/hCjmsk55AsDlqFg0XuXRSsn
         DrcbWMVYdnIW8Zn9v0DrqYz6Z5bBfiD5e61cHlKx5XVn0KV4QbgOBFCAhte8U/AKjdjV
         Urww==
X-Gm-Message-State: AFq9FYIwsOvxg2tdsFZLTbFCPPZ3RWA635b0Yoi4lgR43/u+ZIds2hIg
	viHx7s2oEWSqRaDWWKYCIgXT56FqyH2BLN8gEdHa8RxnDRnQMZbjvzFd6KluqTw6uTi2yWCYaEY
	AOdc=
X-Gm-Gg: AYBFou3LsLlkpXDmI2j9qxYFHwpECuVl62WSz2kxOKaNcGkBBeraEvKN1dRojy8OhuL
	fxrSetrwiDN0U4RpEtobeaNqH6HvcCMw6D4rroGQHW0RVGe12zGtOP668B3dsNLHr5f4popoxGI
	3jK1RZVF+Tr93rCNoh8xerfxJc2FTImn1LDSd72VLMwzDOSpQFcGZ0xYmFXWz0Trw6hkkIhJcT0
	/tzsrSZtFT8KKEUtuO+ebhqGzMoVaiJ2t9HD5U+7IKOyERTgOWlMmyz6CRcba/xf2ZufRroMcQe
	4mmq8MkJ0CYjypGUADrPWZ3Bnb9pT9RIR5qOuuS8yDdZp6bKbj6TwgZqO4ddX5ZhMywVeELoWD2
	p0A7te7BL7nmYfCD04Jt2Jf+7VfwMMkVx9fAY1lVdI8ysjJmi1zUvfc2/c/Y7flaQDH4m+WTRcp
	8VXghP2UmNErRF4OoI3emv0MG7aQ6/NnA7DZqwvgjJxVfapCAEsVj37FtmPtObpOLMV6i6MX0Uk
	WJ6cSzT39esgOB8OdL+a7eKqsWreLoiIEWFODODLwCK
X-Received: by 2002:a05:620a:6f82:10b0:93e:fc4e:c4aa with SMTP id af79cd13be357-93efc4ee7afmr849923385a.45.1792060371848;
        Thu, 15 Oct 2026 03:32:51 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ba684f404sm55261936d6.31.2026.10.15.03.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:32:51 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/4] net/sched/sch_cake: serialize reconfiguration with the datapath
Date: Thu, 15 Oct 2026 06:32:42 -0400
Message-Id: <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
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
cover the readers that run outside the lock (cake_config_dump(), which is
not serialized, and the cake_mq shared config, observed under different
child locks).

Conditions to recreate the bug: build with CONFIG_KCSAN=y.  Two distinct
effects are reachable.  (a) The lost update of the installed rate is
reproducible without a sanitizer: put cake in autorate-ingress on a
device, drive bursty traffic with gaps so the 250ms autorate
reconfiguration fires, and concurrently loop 'tc qdisc change dev ...
cake bandwidth <N>kbit autorate-ingress', then read the installed rate
back and observe the estimate instead of the configured rate.  (b) The
non-atomic 64-bit store that KCSAN reports needs a 32-bit machine, where
the torn store of rate_bps is observable; on 64-bit the value is written
atomically and KCSAN flags only the unsynchronized access.

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_cake.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..a05da73b5f84 100644
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
@@ -2021,7 +2022,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	    now - q->last_checked_active >= q->config->sync_time) {
 		struct net_device *dev = qdisc_dev(sch);
 		struct cake_sched_data *other_priv;
-		u64 new_rate = q->config->rate_bps;
+		u64 new_rate = READ_ONCE(q->config->rate_bps);
 		u64 other_qlen, other_last_active;
 		struct Qdisc *other_sch;
 		u32 num_active_qs = 1;
@@ -2042,7 +2043,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		}
 
 		if (num_active_qs > 1)
-			new_rate = div64_u64(q->config->rate_bps, num_active_qs);
+			new_rate = div64_u64(READ_ONCE(q->config->rate_bps),
+					     num_active_qs);
 
 		cake_configure_rates(sch, new_rate, true);
 		q->last_checked_active = now;
@@ -2626,12 +2628,12 @@ static void cake_reconfigure(struct Qdisc *sch)
 	struct cake_sched_config *q = qd->config;
 	u32 buffer_limit;
 
-	cake_configure_rates(sch, qd->config->rate_bps, false);
+	cake_configure_rates(sch, READ_ONCE(qd->config->rate_bps), false);
 
 	if (q->buffer_config_limit) {
 		buffer_limit = q->buffer_config_limit;
-	} else if (q->rate_bps) {
-		u64 t = q->rate_bps * q->interval;
+	} else if (READ_ONCE(q->rate_bps)) {
+		u64 t = READ_ONCE(q->rate_bps) * q->interval;
 
 		do_div(t, USEC_PER_SEC / 4);
 		buffer_limit = max_t(u32, t, 4U << 20);
@@ -2784,9 +2786,16 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2795,13 +2804,13 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
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
