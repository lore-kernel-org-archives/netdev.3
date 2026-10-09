Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EBA17A305
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549207; cv=none; b=V0TzKd5uBwWMzJLgaTqdcAFSjhWg8bwDgJUR6XZYZYOdammdBlhndmWg9CWuZDiMJaJD4qQ3FuWcrW/Qpd5zhG0UT8TYB9PKIIMfxiAkHpDPtE5pODuPA+K4VjdMapKCeVtIupbZQlzbglFt+nZQiqULD77SxAZ/WVJ0PyxhZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549207; c=relaxed/simple;
	bh=SrkKeLgxtrps6UObR45wDUKsMFbP0kp95Kr0ncCZDT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuAI31os366ZRmOfyBTVoc4c0ZmaGxgALsYkgLJysIoB1aPN9NrEujNFJu9qIKBxbACXO4vW9cHPX2ZGRqBRRuW0vsC9X6+ABhgZfTlbWo9vCxDcIu2AIbjFVTH6M/3Q0ud6Ss/nexoRvcfHrKSMxnY3796kETWZuIhCpoJNJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccDW53UD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccDW53UD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a061a13884so35181405e9.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791549198; x=1792153998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vv0j7bVEYRbiLUVVlkzl8ZbxApfBc3Ek5gQ0XvaibBo=;
        b=ccDW53UD75m172uQmZVWAna3TjWu9iZxbolP4ugu4JoZZb9XwhQ5cyQJrufAq7bwsD
         tbaJB6uvoRyB0H1EJGLWIyrzwIfa1zdRZJB1/gg6BD65BQZ1dIU9T6mdqXFY18FaRry+
         anfukKB649cXWVelMpfp2DZnvwcomBmBXwmkq/nepT83kZX5201X3KkPbOkVzOrxA0bR
         2pM/nvZqdwrRle21dTnGadFXJH5Y57yyvY4P79nkfv1CnB7ep3todiLw7TOiDeF0FygL
         YaSOUfxqjmZTQVu7shwLLXIjpN1pcxVRSOODKKLXkXgWc61JaVndk6I3EBLB+qOg5DxI
         ehEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791549198; x=1792153998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vv0j7bVEYRbiLUVVlkzl8ZbxApfBc3Ek5gQ0XvaibBo=;
        b=YBx1pX73nszZzHd/s2gq30ab6IcCZC+0+yWwY9kePh2Y0kfURlrTZo9nHI57Xhaw4O
         mJ/o2L5M4qWSwYMDaPhdy35/uhQImTWlPAyF0vq89Ta87DFit9qlt9dh4qkLMARkDu0x
         e3xU/wvDb617X4XFC7uLhxiLoB5d3bAlUapCVRiuWLx1gzyQQ3YnnwZ5a/VPanifHUmw
         c/ZbaoemVr6GApKuC+lFng6kQt7YIcTbiAIs1KHkpWlq0fs0SDfcCuSdruLgOEI9cfsj
         42hk95YU9cEHU03K/eaUlW2w0lMyM06mzkXZgtEQC6gdrb6z/HBxL0nfPttbl1jVnfzX
         cYiw==
X-Forwarded-Encrypted: i=1; AKwUvBy0TsriaXu2Hj0xz0BltOU9bZAaPkB9OKGlxsPtiuQObB0oW2wyOZu7sxwK6uw5vIjZB3zX3aI=@vger.kernel.org
X-Gm-Message-State: AFuF++nPTYeOcavAURt71Q2uYbbGqpN6qNqCW1kZbr+OSCY2Xbl17K0D
	pdDtiEP+UiPYjucxLrGKCebDKZVxwLLlAEZCIFBR8Dr5bxx9iuk4Thkc
X-Gm-Gg: AYBFou0epHQP39DyX7Q9kCZpuqEfGOYOxgDR6szsLHnpMPmPmCxccyC4yObWZrU54Yj
	hkcEF+UR4iIMeurfuI9iAkk25pV91EaWG5NJ7wYgiicsmP/ORq5veDk/tAcjnxvflC7XW27dIr6
	ClwTb9nUM5VZcf81FqDh+xmsf2EKR4etdyUD1Jzs0vAl8jebG1HirlUzeMxZUaRuX+ccOrLiD8a
	yCSfZvY21kj5enANK+gEC0reLhlGFXXfk+sinhW8EwfW+s9lWGi2x9T3LBXd5DBcwRUL/Z8uoFJ
	CpX67a9gQi4a90c4oQmuVhOWTB/hwIRw1Fx2zFLf8WHinHgTL4VnIxgifnnbnai5Euph9x+Yutf
	W9730in/Fh2cuINwkjeuYzinDW/T6pmsa8+c3orf3o1jMjBjfn3VbmtVYgsdxZe9IGprSH8Nhca
	PP+rcQllSwZ3rQ/IuyRuCTJjeQ2v+hKYGa0THP9d0w01l0F0/h1fm/Ee70qT7XAiC/aZ6SWn7p/
	S1178R79w+v3Yr7stD6zaAsI4n0uyqp2u3vpczkao7nUVkOyqF5nWXZU2CYvfwHyvM0fLl2Hr7/
	8SPlATJrVzlIE9OakDb771RuRg5YQo4G87q2ZnQbg28TdR2YRGoEHp6tza6jfeVyMJmFCH1SrSx
	1PAxqXCuBeexZIJQ+WeB15DhWgYgDyw==
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id 5b1f17b1804b1-4a18e4b8966mr30703645e9.26.1791549197845;
        Fri, 09 Oct 2026 05:33:17 -0700 (PDT)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acee65sm3650230f8f.49.2026.10.09.05.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:33:16 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] net/sched: taprio: do not replay missed entries in advance_sched()
Date: Fri,  9 Oct 2026 14:33:09 +0200
Message-ID: <20261009123309.284193-3-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
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
v2:
 - taprio_entry_at(): do not use the list iterator after the loop.
   Return the entry through a separate pointer that is set inside the
   loop, and say in the comment why it is always set (Jakub)
 - wrap the lines longer than 80 columns, with a local variable for the
   number of elapsed periods in taprio_entry_at()
v1: https://lore.kernel.org/all/20261006113335.241564-3-krystianmkaniewski@gmail.com/

 net/sched/sch_taprio.c | 133 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 111 insertions(+), 22 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1f753911cdfec..f4ee009dcd5d1 100644
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
@@ -902,8 +909,19 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
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
+		extension_time = ktime_add_ns(end_time,
+					      oper->cycle_time_extension);
 
 	/* FIXME: the IEEE 802.1Q-2018 Specification isn't clear about
 	 * how precisely the extension should be made. So after
@@ -915,6 +933,51 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
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
+	sched->cycle_end_time = ktime_add_ns(cycle_start, sched->cycle_time);
+
+	return found;
+}
+
 static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 {
 	struct taprio_sched *q = container_of(timer, struct taprio_sched,
@@ -923,8 +986,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	struct sched_gate_list *oper, *admin;
 	int num_tc = netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
+	ktime_t end_time, start, now;
 	struct Qdisc *sch = q->root;
-	ktime_t end_time;
 	int tc;
 
 	spin_lock(&q->current_entry_lock);
@@ -938,6 +1001,15 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
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
@@ -948,27 +1020,26 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
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
+		if (unlikely(!ktime_after(end_time, now)))
+			next = taprio_entry_at(oper, now, &start, &end_time);
 	}
 
 	if (should_change_schedules(admin, oper, end_time)) {
@@ -978,8 +1049,20 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
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
+			next->gate_close_time[tc] =
+				ktime_add_ns(start, next->gate_duration[tc]);
 	}
 
+set_budgets:
 	next->end_time = end_time;
 	taprio_set_budgets(q, oper, next);
 
@@ -1285,7 +1368,8 @@ static void setup_first_end_time(struct taprio_sched *q,
 {
 	struct net_device *dev = qdisc_dev(q->root);
 	int num_tc = netdev_get_num_tc(dev);
-	struct sched_entry *first;
+	struct sched_entry *first, *entry;
+	s64 intervals = 0;
 	ktime_t cycle;
 	int tc;
 
@@ -1297,6 +1381,11 @@ static void setup_first_end_time(struct taprio_sched *q,
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

