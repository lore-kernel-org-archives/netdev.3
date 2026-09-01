Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79147799B;
	Tue,  1 Sep 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255247; cv=none; b=F+xtfoXjhNFtZ1WC+GilD5OsyJ98RyOG1G1VkjIrz0ZKvkqpRvP0a/JXGfNRQ47RpWgi3pJCSaiRHqMNsCq2UcNC1OWUwXTGtN0K7gGX9OfcCf255HlPR+KQHHtdi7K5mH0VfdGpVUkrfBNCI4IQQTcC3TserGHRD/F7vubM46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255247; c=relaxed/simple;
	bh=no2C7SzzXmZ/2O47j+p1G4ygGQzCcvd/80BLeF76Tx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyoYJaBNOMxn4EKRRos2weHpuRtLyCqjWuzJpztBJSjgzBaWh3F7UcX1eyvNLzd608KUswmPQ872E2VoHxOz8kI4frRaDTwDRXR0DW7F8fdiNry0pZQFCIO5VuSY3ltjYM/ewW0zNrTzXmfL+YBayMnt3YIohSutqBb9qlhNe6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvMRjcLQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvMRjcLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788255237; x=1819791237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=no2C7SzzXmZ/2O47j+p1G4ygGQzCcvd/80BLeF76Tx4=;
  b=UvMRjcLQ/UNc2I+tK/SlfnT9lT9/LVe7z8fXntC6r/4rteIGFVcIQKzM
   oet8agzCiQB9uI44aRAp5LTRF8VDhLEMcQoSKslyI4as2uISyl3z0cQRO
   BEs8gIbftJKNW5m6OYD5feWCGMVsildmgmQD11b/3yIaJ3M1PIMYWccDZ
   97nqJpCit7gTBRdpRCUva8VuRdQuAtDhqPW9Fp1ZYe/avd5F68pJlr7gV
   +jnB4jtixJjOVnl2i8xyXX5xeLx7Y9MCW0BQXE/zJ6IfqzefRbTFxJ509
   5+vhvXoLT9kjms5IrWs4NxF2Pr9aug6nGgj/bxfz+wqZXZYnck0Eg1gGV
   Q==;
X-CSE-ConnectionGUID: cdwKL8HsSP2XadM+AAQdSA==
X-CSE-MsgGUID: O0Dy9F/6QLmEoE84GCBCYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92495295"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92495295"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:33:53 -0700
X-CSE-ConnectionGUID: 7vkGrgPlRBqwU6zn5cELsg==
X-CSE-MsgGUID: 8+EjInTCQvW5+piB0zt/Uw==
X-ExtLoop1: 1
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:33:48 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	vinicius.gomes@intel.com,
	akpm@linux-foundation.org,
	hdanton@sina.com,
	uladzislau.zhauniarovich@gmail.com,
	bestswngs@gmail.com,
	syzbot+19d01f6082ec61dd45b2@syzkaller.appspotmail.com,
	syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com,
	syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com,
	syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net/sched: taprio: catch up in bounded time when the schedule falls behind
Date: Tue,  1 Sep 2026 17:33:39 +0800
Message-ID: <20260901093340.420809-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

advance_sched() advances exactly one entry per hrtimer expiry. When the
operational schedule falls behind - the timer was delayed, the CPU was
starved, or the reference clock stepped forward - every elapsed entry is
replayed back to back from hrtimer context with current_entry_lock held,
and each replay rearms the timer with an expiry in the past. Once the
backlog is large enough the CPU never leaves timer processing and RCU
stalls follow. syzbot triggers this with schedules whose intervals are
shorter than the cost of servicing one expiry, so the backlog only ever
grows.

Skip whole periods arithmetically and walk at most one more to the entry
covering the current time. The software schedule restarts the list after
its last entry even when that is before cycle_time, so its period is
min(cycle_time, sum of intervals); record it at parse time. Advance
cycle_end_time by the period as well: with cycle_time it runs ahead of
the entries by the difference every lap, and skipping whole laps at once
would overflow it within minutes for a schedule with nanosecond
intervals and a cycle_time of seconds. Gate close times and budgets are
still only computed for the entry landed on, and an admin schedule
crossed by the jump is picked up by the existing
should_change_schedules() check on the recomputed end time. The walk is
capped at twice the entry count; a leftover is handled by the next
expiry as today.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Reported-by: syzbot+19d01f6082ec61dd45b2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=19d01f6082ec61dd45b2
Tested-by: syzbot+19d01f6082ec61dd45b2@syzkaller.appspotmail.com
Reported-by: syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8785aaf121cfb2141e0d
Tested-by: syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com
Reported-by: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2642f347f7309b4880dc
Tested-by: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com
Reported-by: syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e4aa91d7f20c34417d4e
Tested-by: syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
v3:
- jump in whole periods of min(cycle_time, sum of intervals) rather
  than cycle_time, and fold the walk into advance_sched() instead of a
  helper duplicating its step (Jakub)
- treat end == now as behind; comment on the cap and on rewriting the
  published entry (Jakub)
- advance cycle_end_time by the period as well, not left alone as I
  said in the v2 thread: with cycle_time it runs ahead of the entries
  by (cycle_time - sum) per lap, and skipping whole laps turns that
  into an s64 overflow within minutes for a schedule with nanosecond
  intervals and a cycle_time of seconds
- the walk finishes within num_entries steps once the first expiry has
  been serviced; a schedule whose cycle_time is shorter than its first
  entry starts with cycle_end_time behind that entry and takes one more
  expiry to line up, where today it replays until it does
- drop the minimum-interval patch and its selftest (Jakub)
- tags for a fourth syzbot bucket, tested by akpm with the v2 patch
  alone; all four re-tested with this version
v2: https://lore.kernel.org/all/20260820062715.278124-1-junjie.cao@intel.com/
- take now from the timer's clock base (Hillf Danton)
v1: https://lore.kernel.org/all/20260818071706.251035-1-junjie.cao@intel.com/

 net/sched/sch_taprio.c | 72 ++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 39ac5b97aa3a..901dfd2484e1 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -83,6 +83,10 @@ struct sched_gate_list {
 	s64 cycle_time;
 	s64 cycle_time_extension;
 	s64 base_time;
+	/* min(cycle_time, sum of intervals): the software schedule restarts
+	 * the list after the last entry even when cycle_time is not up yet.
+	 */
+	s64 period;
 };
 
 struct taprio_sched {
@@ -871,12 +875,13 @@ static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
 }
 
 static bool should_restart_cycle(const struct sched_gate_list *oper,
-				 const struct sched_entry *entry)
+				 const struct sched_entry *entry,
+				 ktime_t end_time)
 {
 	if (list_is_last(&entry->list, &oper->entries))
 		return true;
 
-	if (ktime_compare(entry->end_time, oper->cycle_end_time) == 0)
+	if (ktime_compare(end_time, oper->cycle_end_time) == 0)
 		return true;
 
 	return false;
@@ -925,8 +930,9 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	int num_tc = netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch = q->root;
-	ktime_t end_time;
-	int tc;
+	ktime_t end_time, next_start, now;
+	int budget, tc;
+	s64 behind;
 
 	spin_lock(&q->current_entry_lock);
 	entry = rcu_dereference_protected(q->current_entry,
@@ -952,23 +958,49 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 		goto first_run;
 	}
 
-	if (should_restart_cycle(oper, entry)) {
-		next = list_first_entry(&oper->entries, struct sched_entry,
-					list);
-		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time,
-						    oper->cycle_time);
-	} else {
-		next = list_next_entry(entry, list);
+	now = hrtimer_cb_get_time(timer);
+	end_time = entry->end_time;
+	behind = ktime_sub(now, end_time);
+
+	/* Behind, e.g. delayed timer or stepped clock: skip whole periods
+	 * arithmetically and walk at most one more to the entry covering
+	 * now, instead of replaying the backlog one expiry at a time. The
+	 * cap bounds the walk; a leftover is picked up by the next expiry.
+	 */
+	if (unlikely(behind >= oper->period)) {
+		s64 jump = div64_s64(behind, oper->period) * oper->period;
+
+		end_time = ktime_add_ns(end_time, jump);
+		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time, jump);
 	}
 
-	end_time = ktime_add_ns(entry->end_time, next->interval);
-	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
+	budget = 2 * oper->num_entries;
+	do {
+		if (should_restart_cycle(oper, entry, end_time)) {
+			next = list_first_entry(&oper->entries,
+						struct sched_entry, list);
+			oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time,
+							    oper->period);
+		} else {
+			next = list_next_entry(entry, list);
+		}
+
+		next_start = end_time;
+		end_time = ktime_add_ns(next_start, next->interval);
+		end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
+		entry = next;
+	} while (unlikely(ktime_compare(end_time, now) <= 0) && budget--);
 
+	/* next can be the entry already published as q->current_entry (a
+	 * single-entry schedule, or a catch-up of whole periods), so the
+	 * close times and budgets below are rewritten in place while
+	 * taprio_dequeue_from_txq() may be reading them.
+	 */
 	for (tc = 0; tc < num_tc; tc++) {
 		if (next->gate_duration[tc] == oper->cycle_time)
 			next->gate_close_time[tc] = KTIME_MAX;
 		else
-			next->gate_close_time[tc] = ktime_add_ns(entry->end_time,
+			next->gate_close_time[tc] = ktime_add_ns(next_start,
 								 next->gate_duration[tc]);
 	}
 
@@ -1130,6 +1162,8 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 				 struct sched_gate_list *new,
 				 struct netlink_ext_ack *extack)
 {
+	struct sched_entry *entry;
+	ktime_t cycle = 0;
 	int err = 0;
 
 	if (tb[TCA_TAPRIO_ATTR_SCHED_SINGLE_ENTRY]) {
@@ -1152,13 +1186,10 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 	if (err < 0)
 		return err;
 
-	if (!new->cycle_time) {
-		struct sched_entry *entry;
-		ktime_t cycle = 0;
-
-		list_for_each_entry(entry, &new->entries, list)
-			cycle = ktime_add_ns(cycle, entry->interval);
+	list_for_each_entry(entry, &new->entries, list)
+		cycle = ktime_add_ns(cycle, entry->interval);
 
+	if (!new->cycle_time) {
 		if (cycle < 0 || cycle > INT_MAX) {
 			NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
 			return -EINVAL;
@@ -1172,6 +1203,7 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 		return -EINVAL;
 	}
 
+	new->period = min(new->cycle_time, cycle);
 	taprio_calculate_gate_durations(q, new);
 
 	return 0;
-- 
2.43.0

