Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801844;
	b=kV6upiLIYYAfrcyDhP0Y7O49uf/1CfMqEVqA2MRc0xosGTNFoljCD1Vv68A4Wy4iRGoY
	 pGUFi6kQd2h1N5gQeB4qPItOQSmnfDwxHyVf4qyx/yGZh/fnWUc9NaYSu806epq+oJ28n
	 Sw955K5x3HbeHiunwaYl2w49E8vOF1JBDMtdtnIFUtSYOR6rCr70WB6BkCWQ9eqrj68rQ
	 seA0v/YeMCnJF8TZGis32Ep4uVl8zqM25+fN+jgWQt8jjDNCZzxmD7xm7wgkqLv/xppKt
	 uMu+24igfpXhOaot++ylxKtpud2EaMgYUbsMIsOcBSC0ohXdb7P0ckXNdwbZyE7T8cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/1tmgFLs2mOTEF6LyGRSrCTHs/qRgpRA68AhdZIT8WU=;
	b=deb1Nn7cciTh5xTlltHmhUqud985W3QisDvAz9mLyMqY521c+0rt+LXPx+b56PG3y784
	 PhgMSf0fBAw6t0emBbsGz6um1yeHf9vyNUuW+iweyrG4XwxH1heGoU5M24Amugb+b9NOs
	 HIv9fpcAlBawVo701evNauFXUTLL4YIV9mZiGdMTuE5O3vyK14PwvT/Hn+PIWW4QOzu9Z
	 RNNjuZnfEJD8epyRUZu9srIPlgSSeo/Ygwm1k8VwGC7sOg2rsMPIExPsf79nAIex/+jOs
	 1Gmpv7tGfjj2D+sA7oxWBzxgHXEsQ/tbRmH5dQrED9KEFNkxxrArlnMQLkHUk75cH+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WufsrrZ3;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46295606A32F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46295606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WufsrrZ3
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c434376dbebso144623166b.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801843; x=1794406643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/1tmgFLs2mOTEF6LyGRSrCTHs/qRgpRA68AhdZIT8WU=;
        b=WufsrrZ3rUFUDVPDMc0LK6DiRG4ohlfNeNF+cEzv9iVpip/WRkiSQQ8TqCW0nIjQu+
         NliDntRZe6n75u95WSaDgjn1xeruEwFxSFOjSHs27ajdCJedeC5sgYanTYn3OrFnapxc
         meF3sd8cqSSSAXBlz6f0jlIaIFbMWFxmkUIW6sCqy6+21VBgqVfHYrfKJz4U8vYgNNVL
         bZswGlEuMwJVacPlQOq7810zaBSPrkPAz+MYFEqcUYFEXJMBkObkXBZYkHRy/htJtuAe
         BCok71GIBtdJ0TMTZ4GJcel1/WpYNkGD4sV3ZBaP0HTMO24DbU+Au0sI7B5zo5PUXfQd
         7WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801843; x=1794406643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/1tmgFLs2mOTEF6LyGRSrCTHs/qRgpRA68AhdZIT8WU=;
        b=JtIMLZte9wb/AycK4FcVQYF6FIT2f009V+OfKcvECMPmb6ITWrKWx4YPIIv9FJaCq0
         z8Lmg/L5WSuRWO+BLVj1ICtLfEYyLefWmlIcD8KdUAFo6rE22k2J2ERWrtD8GDFyMom5
         t+N3KEF61i7j6pPDy66qgvZlD+QPpGysXu/4F8Hx+ENUqq+dXafll0L5g7JfkxMK5ly6
         rB2kCbMzuHBxKrOKnE3hnc6nCgUWurXXd+dGw/TuJCtEDTEC7YAEDcSOSygWKqej4064
         JFWgBHMxD32+BSDd085gE01q1MFkReWYS9ghuOhwA+QVsSiDJgnqFqqs68ITk3GxpJAp
         Z6YA==
X-Forwarded-Encrypted: i=1; AKwUvBzJWDKXoQqL8e4Knl0VWYLT6xaT9Rh/a0bloizOFXvv42LNwfJNKa6PddNWWIsLupUS32bE2TY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u5XQIy9EQzGvXeWYZkN/IdGKjmHM6vlsV5i4gRgECAIw986aZ
	0FnlnA2xLVuWUqpcTE3mCeYkSNtjbP3p4iJuz5GpNMVuRfOOcGk9i60l
X-Gm-Gg: AYBFou3OMChtcCacAbkrFnL1qMvrfbPe1OCuuv/K2vNo3FKvARZ3y51NsbWEz7VWURx
	3+Evy2qyhhIuL3bZTbqJPPpSf8Eyp9wpl+88GWtlTZqrbW+l/YUWQppJ/gS5QWGulKedsVTP9sh
	JGdSYz7YaHzvvf6PRPeyrABM9jxAgd4ETrN2eQ/Vsg3VLp15kSddGfPORu84LkeM/mKjztrEsdc
	Ia8kdyi8blkncIEMUocfPWbDvkBqBrUmf2CMgqblN6lQUgmhXgUJBVK471KAeCc+kye87fjRT2x
	CI5d9wCAoMAk0cLIDqk6zCOFABoKZzUjjLZxo28161+W3rnSmYyL2KNmDgVSfKaUuCU+cfFlQ3H
	QmYyAvNApRfvNp4e2egpf/yOK9YItaZcNfZZ9AIUwlbBVHlQkkJ/9tHxogdxlcPP63M2VQVBfn9
	FvxUkfJay7NakiOAPE6E9RZiAp9/N7UD9FcT18u0FxNRTS+498grXzFI9kgT6l7G6IReuROmMxO
	Xvg07IpGeVsfFKzyysSpdQcyrj6MCwqz8CVGOXX7C9DPCrUESDX9B4iJMQXPS9fOIoT6CCzJDF8
	F60vj+hzmcO6Ms1UCm++N9ns1Y2Amt4nrGmlFx5OUvXLDvwYHzlDHj/RQBexRaBzSnSLgS9Av5c
	jyPT0TyfGFLT6hAaLjsKEtFs3K7UESCy3BADSvas91STdsSE+nWEOP4By9GUk0dIPHm13V8KMrh
	un6CYq6jJjUFuUCLOkNX4oGt5AjXqEca/4SuxTdOGCXtnQle2/ewN7OdZvuilhkdCM2uE+4Sf6Q
	w==
X-Received: by 2002:a17:907:96a9:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c4ca7aa0488mr1372491366b.15.1793801842262;
        Wed, 04 Nov 2026 06:17:22 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e43e2eesm77311566b.31.2026.11.04.06.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:17:21 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vedang Patel <vedang.patel@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e044a9b6370ed8ca9737@syzkaller.appspotmail.com
Subject: [PATCH net v3 3/3] net/sched: taprio: do not replay missed entries in advance_sched()
Date: Wed,  4 Nov 2026 15:17:13 +0100
Message-ID: <20261104141713.355958-4-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104141713.355958-1-krystianmkaniewski@gmail.com>
References: <20261104141713.355958-1-krystianmkaniewski@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

advance_sched() advances the software schedule by one entry per hrtimer
expiry and rearms the timer at the nominal end of that entry, without
reading the clock. When that time has already passed, the hrtimer core
runs the callback again inside the same interrupt, once for every missed
entry.

syzbot hits this with a single 127 ns entry on a veth device.
fill_sched_entry() only rejects intervals below the transmission time of
a minimum sized frame, which is 48 ns at the 10 Gb/s reported by veth,
so 127 ns is accepted. One expiry takes longer than 127 ns, so the
backlog grows instead of shrinking, the CPU stays in the timer interrupt
and RCU reports a stall. Lateness from a forward step of CLOCK_REALTIME
or CLOCK_TAI, from resume with CLOCK_BOOTTIME, or from a long time with
interrupts disabled leads to the same replay with any interval.

Record when the schedule starts and the period after which it repeats,
which is the cycle time, or the sum of the intervals when the entries
end before the cycle does. Whenever the entry that advance_sched() is
about to start has already ended, find the entry in progress from these
two values and continue from there. This selects the entry and the end
time that the replay would have reached, so a schedule that keeps up
with its timer behaves as before. The same check covers the first entry
after taprio_change() resets the current entry of a running schedule,
and the first entry of an admin schedule that takes over late.

advance_sched() now evaluates should_change_schedules() once on the
caught up end time instead of once per missed entry. This relies on
should_change_schedules() saturating the cycle_time_extension sum, which
makes the test monotonic in end_time. One check after catching up is
therefore equivalent to the repeated checks.

This bounds the work done per expiry. It does not limit how often the
timer fires. Unless the clock is stepped backward between the hrtimer
core reading it and the callback reading it, the timer is rearmed after
the current time and the CPU leaves the timer interrupt between
expiries. On the high-resolution hard interrupt path, a schedule whose
intervals are shorter than one expiry is then held back by the hang
detection in hrtimer_interrupt().

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Reported-by: syzbot+e044a9b6370ed8ca9737@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e044a9b6370ed8ca9737
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
 - move cycle-time-extension overflow handling to patch 2 (Vinicius)
 - return the cycle end from taprio_entry_at() and update
   cycle_end_time in advance_sched() (Vinicius)
 - add Acked-by from Vinicius
 - drop the obsolete Assisted-by trailers
 - rebase onto current net/main
v2: https://lore.kernel.org/all/20261009123309.284193-3-krystianmkaniewski@gmail.com/
 - taprio_entry_at(): do not use the list iterator after the loop.
   Return the entry through a separate pointer that is set inside the
   loop, and say in the comment why it is always set (Jakub)
 - wrap the lines longer than 80 columns, with a local variable for the
   number of elapsed periods in taprio_entry_at()
v1: https://lore.kernel.org/all/20261006113335.241564-3-krystianmkaniewski@gmail.com/

 net/sched/sch_taprio.c | 127 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 21 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index e4c937cf74c10f..5a1dca9d5e9dec 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -90,6 +90,13 @@ struct sched_gate_list {
 	s64 cycle_time;
 	s64 cycle_time_extension;
 	s64 base_time;
+	/* The software schedule starts at start_time and repeats every period,
+	 * which is the cycle time, or the sum of the intervals when the
+	 * entries end before the cycle does, because advance_sched() then
+	 * starts the list again right after the last entry.
+	 */
+	ktime_t start_time;
+	s64 period;
 };
 
 struct taprio_sched {
@@ -942,16 +949,61 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
 	return false;
 }
 
+/* Return the entry of @sched which is in progress at @now, the one that
+ * advance_sched() reaches by moving one entry per expiry from the start of
+ * the schedule. Set @start and @end to the times at which it started and
+ * ends, and @cycle_end to the end of the cycle which contains it.
+ */
+static struct sched_entry *
+taprio_entry_at(const struct sched_gate_list *sched, ktime_t now,
+		ktime_t *start, ktime_t *end, ktime_t *cycle_end)
+{
+	struct sched_entry *entry, *found = NULL;
+	ktime_t cycle_start = sched->start_time;
+	s64 offset, entry_end = 0, elapsed = 0;
+
+	if (ktime_after(now, cycle_start)) {
+		s64 periods = div64_s64(ktime_sub(now, cycle_start),
+					sched->period);
+
+		cycle_start = ktime_add_ns(cycle_start,
+					   periods * sched->period);
+	}
+	offset = ktime_sub(now, cycle_start);
+
+	/* The offset is less than one period, so an entry which ends after
+	 * @now is found at the latest at the entry which reaches the end of
+	 * the cycle, or at the last entry. A schedule has at least one entry,
+	 * so the loop always sets found.
+	 */
+	list_for_each_entry(entry, &sched->entries, list) {
+		entry_end = min_t(s64, elapsed + entry->interval,
+				  sched->cycle_time);
+		if (offset < entry_end ||
+		    list_is_last(&entry->list, &sched->entries)) {
+			found = entry;
+			break;
+		}
+		elapsed = entry_end;
+	}
+
+	*start = ktime_add_ns(cycle_start, elapsed);
+	*end = ktime_add_ns(cycle_start, entry_end);
+	*cycle_end = ktime_add_ns(cycle_start, sched->cycle_time);
+
+	return found;
+}
+
 static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 {
 	struct taprio_sched *q = container_of(timer, struct taprio_sched,
 					      advance_timer);
 	struct net_device *dev = qdisc_dev(q->root);
+	ktime_t cycle_end, end_time, start, now;
 	struct sched_gate_list *oper, *admin;
 	int num_tc = netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch = q->root;
-	ktime_t end_time;
 	int tc;
 
 	spin_lock(&q->current_entry_lock);
@@ -965,6 +1017,15 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	if (!oper)
 		switch_schedules(q, &admin, &oper);
 
+	/* The entry selected below can be over already, after a clock step,
+	 * a long time with interrupts disabled, or because the intervals are
+	 * shorter than one expiry takes. Moving on by one entry and arming the
+	 * timer in the past would run this function again for every missed
+	 * entry without leaving the timer interrupt. Take the entry which is in
+	 * progress now instead, so that the timer is always armed after now.
+	 */
+	now = taprio_get_time(q);
+
 	/* This can happen in two cases: 1. this is the very first run
 	 * of this function (i.e. we weren't running any schedule
 	 * previously); 2. The previous schedule just ended. The first
@@ -975,27 +1036,31 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 		next = list_first_entry(&oper->entries, struct sched_entry,
 					list);
 		end_time = next->end_time;
-		goto first_run;
-	}
-
-	if (should_restart_cycle(oper, entry)) {
-		next = list_first_entry(&oper->entries, struct sched_entry,
-					list);
-		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time,
-						    oper->cycle_time);
+		if (likely(ktime_after(end_time, now)))
+			goto first_run;
+		/* Also after taprio_change() while the schedule runs */
+		next = taprio_entry_at(oper, now, &start, &end_time,
+				       &cycle_end);
+		oper->cycle_end_time = cycle_end;
 	} else {
-		next = list_next_entry(entry, list);
-	}
-
-	end_time = ktime_add_ns(entry->end_time, next->interval);
-	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
+		if (should_restart_cycle(oper, entry)) {
+			next = list_first_entry(&oper->entries,
+						struct sched_entry, list);
+			oper->cycle_end_time =
+				ktime_add_ns(oper->cycle_end_time,
+					     oper->cycle_time);
+		} else {
+			next = list_next_entry(entry, list);
+		}
 
-	for (tc = 0; tc < num_tc; tc++) {
-		if (next->gate_duration[tc] == oper->cycle_time)
-			next->gate_close_time[tc] = KTIME_MAX;
-		else
-			next->gate_close_time[tc] = ktime_add_ns(entry->end_time,
-								 next->gate_duration[tc]);
+		start = entry->end_time;
+		end_time = ktime_add_ns(start, next->interval);
+		end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
+		if (unlikely(!ktime_after(end_time, now))) {
+			next = taprio_entry_at(oper, now, &start, &end_time,
+					       &cycle_end);
+			oper->cycle_end_time = cycle_end;
+		}
 	}
 
 	if (should_change_schedules(admin, oper, end_time)) {
@@ -1005,8 +1070,22 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 		 */
 		next = list_first_entry(&oper->entries, struct sched_entry, list);
 		end_time = next->end_time;
+		if (likely(ktime_after(end_time, now)))
+			goto set_budgets;
+		next = taprio_entry_at(oper, now, &start, &end_time,
+				       &cycle_end);
+		oper->cycle_end_time = cycle_end;
+	}
+
+	for (tc = 0; tc < num_tc; tc++) {
+		if (next->gate_duration[tc] == oper->cycle_time)
+			next->gate_close_time[tc] = KTIME_MAX;
+		else
+			next->gate_close_time[tc] =
+				ktime_add_ns(start, next->gate_duration[tc]);
 	}
 
+set_budgets:
 	next->end_time = end_time;
 	taprio_set_budgets(q, oper, next);
 
@@ -1319,7 +1398,8 @@ static void setup_first_end_time(struct taprio_sched *q,
 {
 	struct net_device *dev = qdisc_dev(q->root);
 	int num_tc = netdev_get_num_tc(dev);
-	struct sched_entry *first;
+	struct sched_entry *first, *entry;
+	s64 intervals = 0;
 	ktime_t cycle;
 	int tc;
 
@@ -1331,6 +1411,11 @@ static void setup_first_end_time(struct taprio_sched *q,
 	/* FIXME: find a better place to do this */
 	sched->cycle_end_time = ktime_add_ns(base, cycle);
 
+	list_for_each_entry(entry, &sched->entries, list)
+		intervals += entry->interval;
+	sched->start_time = base;
+	sched->period = min_t(s64, intervals, cycle);
+
 	first->end_time = ktime_add_ns(base, first->interval);
 	taprio_set_budgets(q, sched, first);
 
-- 
2.53.0

