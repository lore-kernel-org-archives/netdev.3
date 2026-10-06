Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA173E5A0A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286430; cv=none; b=FY591ktMT8aq3Y/VAR81iGCHorCvDuGUbaRgUif6swbgPBOSnhk3OgTVLAXiPnkQI5gYO3BZkhrSSNCAJzJT9n7A2Bu71nOrCXfYbrYWJfcq0Jzg5seh/wLYu3ayHZxw5zL5Qf9ZC2GdkPe3YANxC0u2fnhVbSs2Fiz4gd9RBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286430; c=relaxed/simple;
	bh=YLDK7b3fqULpxyasmtDpYQSv0LXR61JaEyGc1EB0G0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy3g5BpIXsIe+rZyUUKgQzkTYbWl+fR5HA24VLWV35eCYFbYmvz+rCAuDvMops8OxGPVfQiOVewN9Wlqq++cY76jAXDEIAe0No8wu0h5sfZabu+fvt7cAANRkH2ZsL82Y+QhWg7yz9nWODrclO5UggUT0kawg2QXfbO1FdN8GgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbaJgTCC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbaJgTCC"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso704172a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791286427; x=1791891227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=me56YRz135/44ciBCXAfpyrNZuDJ/tYBkARbvU1H0RI=;
        b=rbaJgTCC35QGG8MHUcGZ0/Ci1J0mAtx133H4jdQ0TWrZC94iV/HD3CZqpsxC1OyZoN
         KJTIpdKE19HgFwA8PsTpAeuPLOzHtZARzopuFRl2Gi5sDmSeYCm5SAIwIqi3q74T3Pns
         /f5bpGAUYDD8QI7faqDpou4ktRYwLXqrTZJkeXwCV+ZzYqpxGLaEN46Z5Yq6xjvICjLV
         0kjQB5z4JFlGIQy66sXbobYajRdrGj+jo9I2TTUUO5W465TkCqebj5StuuERSrRFNZJ7
         DBjwUvvCSMLai8q+tHX2zbe0UzzGbHk1BoKDm8oQBqposv2KC1jTc2W85H9sIEzDfj32
         buQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286427; x=1791891227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=me56YRz135/44ciBCXAfpyrNZuDJ/tYBkARbvU1H0RI=;
        b=JJRWsOoxcelPBdGFQH128jcmOJkxizBHJRPrQswYh3Vp0VuBe5j+YGh0nkSe+9593m
         v1kVYVG3NDLi2v/MgkxGbvEUY8Co88+8ae6IFBEhFgUaqV1CiVUErdRDXJk/UasTWGJG
         CUuTHkBcJrCzz7t+k3gBUrrOgx57kkp6PnBc7FS65N/WXoXBXm8wSGggyh4TlE+2TD5M
         1Bp0Jqw/RqM2j7BmaSXTaSpFDTJ8VHpEQipb9xRmLMCQ9Md+pjtSoevd6ggs+7LMVAuH
         ahwb1NRtwJMLPFgReXlZEgYTgMKIOTQ5oSg08z9NCcsEbxhmVK818wN7gA0C+cYhhuN3
         unMg==
X-Forwarded-Encrypted: i=1; AKwUvByGpHguIuzRDbCqfNSmDL5LiDNyOTzMeGqGcVE7j8GnoxraWFvpR88ayzAS7LeA/KW0jXqtLcY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJm/LQ1aWGoePZBeEQadg4MISsWnF41GpBKgqw62jTfnVT+DKLp
	1QHwYCBvQzmT5kFJMlTO7ksCWAIrqS2KVd2HvHGUeguFnBKM2U/r1dn/
X-Gm-Gg: AYBFou3EyEqkVmdgKNkFyYc4SYF0cZ++U8eaU7T1DSb3jig0Qv2A9WdS0MGGDK8bnlS
	/KqAXCCbcAgFC9cOVAHZPSji59uCrtSSkbfSTkoW80CmWLgVsdPFr1p0mksyzSTdPxAUin6iXZ0
	SNT4pBHbsUcRF52rohJGDssJ1ujkGhh11jbhvT0PrHvfXDguXyrOd7/pb7Nci1a27/OJhSfrUig
	A/llPN2WZfGdv4zPHE9InYg0pv5ESJhRlzIJlrZ/CegR/6FaD4jPAnRXS0z/g+K1iLRetFk+qFo
	J+GZCFB5Moqs5kEzlmc8rYl/O7HJ9vFe25JiYpqWzrcaaAtenkmclLiQcz6Uq4FMozWS7HPx9Pa
	RYf0oyWBDmTKN9GHnxu7XIYeM1ga5hvfutsw15EwEMQyUjnotoKtYQYzzLYVQAzBLOyL1zpLScZ
	5cTve895OZd+mOqzUHBOZAuSnPjPJMx18kjSUZ8spXiJH2+EVsg1WhswsBhPxxIyMA6FHTidvFO
	cUMqsdubzhJephQ+Cbh+cZLKcCY0siPyOBZEbYDCjZ/gSg9QsmItItcFCjl57TA+m95K6FN4oL0
	j4msBN4bxXvTompFrAuuJPwDAof+n1JTRfLsfBu9VmupCE7EzVWlOcGjoP1dKYGgOVrdXXs0weJ
	UAEjGOM8jVuzjQTvV835OClAoemJk
X-Received: by 2002:a05:6402:4518:b0:6ac:9375:a161 with SMTP id 4fb4d7f45d1cf-6afe29e147bmr1183900a12.28.1791286425871;
        Tue, 06 Oct 2026 04:33:45 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e5937sm4465468a12.11.2026.10.06.04.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:33:45 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e044a9b6370ed8ca9737@syzkaller.appspotmail.com
Subject: [PATCH net 2/2] net/sched: taprio: do not replay missed entries in advance_sched()
Date: Tue,  6 Oct 2026 13:33:35 +0200
Message-ID: <20261006113335.241564-3-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006113335.241564-1-krystianmkaniewski@gmail.com>
References: <20261006113335.241564-1-krystianmkaniewski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
caught up end time instead of once per missed entry. That is only
equivalent if the test is monotonic in the end time, so make the
cycle_time_extension sum in that helper saturate instead of wrap. The
extension comes from netlink as an unbounded signed value.

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
Assisted-by: Codex:gpt-6.1-sol
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
 net/sched/sch_taprio.c | 125 +++++++++++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 22 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1f753911cdfec..517c0b8b6dac6 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -83,6 +83,13 @@ struct sched_gate_list {
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
@@ -902,8 +909,18 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
 	 * plus the amount that can be extended would fall after the
 	 * next schedule base_time, we can extend the current schedule
 	 * for that amount.
+	 *
+	 * cycle_time_extension is an unbounded signed value from netlink, so
+	 * clamp the sum instead of letting it wrap. A wrap would make this
+	 * test non-monotonic in end_time, and advance_sched() relies on it
+	 * being monotonic to check it once after catching up instead of once
+	 * per skipped entry.
 	 */
-	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
+	if (oper->cycle_time_extension > 0 &&
+	    end_time > KTIME_MAX - oper->cycle_time_extension)
+		extension_time = KTIME_MAX;
+	else
+		extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
 
 	/* FIXME: the IEEE 802.1Q-2018 Specification isn't clear about
 	 * how precisely the extension should be made. So after
@@ -915,6 +932,45 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
 	return false;
 }
 
+/* Returns the entry of @sched which is in progress at @now, the one that
+ * advance_sched() reaches by moving one entry per expiry from the start of
+ * the schedule, and sets @start and @end to the times at which it started
+ * and ends. Also sets the end of the cycle which contains it.
+ */
+static struct sched_entry *taprio_entry_at(struct sched_gate_list *sched,
+					   ktime_t now, ktime_t *start,
+					   ktime_t *end)
+{
+	ktime_t cycle_start = sched->start_time;
+	s64 offset, entry_end = 0, elapsed = 0;
+	struct sched_entry *entry;
+
+	if (ktime_after(now, cycle_start))
+		cycle_start = ktime_add_ns(cycle_start,
+					   div64_s64(ktime_sub(now, cycle_start),
+						     sched->period) * sched->period);
+	offset = ktime_sub(now, cycle_start);
+
+	/* The offset is less than one period, so an entry which ends after
+	 * @now is found at the latest at the entry which reaches the end of
+	 * the cycle, or at the last entry.
+	 */
+	list_for_each_entry(entry, &sched->entries, list) {
+		entry_end = min_t(s64, elapsed + entry->interval,
+				  sched->cycle_time);
+		if (offset < entry_end ||
+		    list_is_last(&entry->list, &sched->entries))
+			break;
+		elapsed = entry_end;
+	}
+
+	*start = ktime_add_ns(cycle_start, elapsed);
+	*end = ktime_add_ns(cycle_start, entry_end);
+	sched->cycle_end_time = ktime_add_ns(cycle_start, sched->cycle_time);
+
+	return entry;
+}
+
 static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 {
 	struct taprio_sched *q = container_of(timer, struct taprio_sched,
@@ -923,8 +979,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	struct sched_gate_list *oper, *admin;
 	int num_tc = netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
+	ktime_t end_time, start, now;
 	struct Qdisc *sch = q->root;
-	ktime_t end_time;
 	int tc;
 
 	spin_lock(&q->current_entry_lock);
@@ -938,6 +994,15 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
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
@@ -948,27 +1013,25 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
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
+		next = taprio_entry_at(oper, now, &start, &end_time);
 	} else {
-		next = list_next_entry(entry, list);
-	}
-
-	end_time = ktime_add_ns(entry->end_time, next->interval);
-	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
+		if (should_restart_cycle(oper, entry)) {
+			next = list_first_entry(&oper->entries,
+						struct sched_entry, list);
+			oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time,
+							    oper->cycle_time);
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
+		if (unlikely(!ktime_after(end_time, now)))
+			next = taprio_entry_at(oper, now, &start, &end_time);
 	}
 
 	if (should_change_schedules(admin, oper, end_time)) {
@@ -978,8 +1041,20 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 		 */
 		next = list_first_entry(&oper->entries, struct sched_entry, list);
 		end_time = next->end_time;
+		if (likely(ktime_after(end_time, now)))
+			goto set_budgets;
+		next = taprio_entry_at(oper, now, &start, &end_time);
+	}
+
+	for (tc = 0; tc < num_tc; tc++) {
+		if (next->gate_duration[tc] == oper->cycle_time)
+			next->gate_close_time[tc] = KTIME_MAX;
+		else
+			next->gate_close_time[tc] = ktime_add_ns(start,
+								 next->gate_duration[tc]);
 	}
 
+set_budgets:
 	next->end_time = end_time;
 	taprio_set_budgets(q, oper, next);
 
@@ -1285,7 +1360,8 @@ static void setup_first_end_time(struct taprio_sched *q,
 {
 	struct net_device *dev = qdisc_dev(q->root);
 	int num_tc = netdev_get_num_tc(dev);
-	struct sched_entry *first;
+	struct sched_entry *first, *entry;
+	s64 intervals = 0;
 	ktime_t cycle;
 	int tc;
 
@@ -1297,6 +1373,11 @@ static void setup_first_end_time(struct taprio_sched *q,
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

