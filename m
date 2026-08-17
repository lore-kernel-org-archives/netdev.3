Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AC33CEA5
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944178; cv=none; b=dKB2zNATv5FAPVFjEiY+GyTp+/812bPFIIRlGdZz4StAFMZUrYE31M9w9QuYUh+b+f229CYI4SuXOPWmZ44TuXdYCJVQoMBHCICo6mKy8O5FOz7YLmEwUd5RD8QIbBHsBBVVntiivpuBJL4ckSXjDnnxHNPUDa8h5G9BUJadiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944178; c=relaxed/simple;
	bh=f34qalG72+wQKC69HJWsF1lFV8zxvD0DD4VhCE1o7BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnBFkVGrJZLwTnhljm+FBNboP64Epoa2oY2mt4W+BbEEnWCZIl8+eBuJzvF5NU/RYaJVeXkcMP5VosRFgOmVvKuCE3E7nrRMsdiilML+rWabPMb76gRmfVdWH1asL6TtMXyGO92hY1tfnJL5vJdu7nwMhllpb/nR9ZWpz/cW+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZY4VW2j; arc=none smtp.client-ip=95.215.58.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZY4VW2j"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f34qalG72+wQKC69HJWsF1lFV8zxvD0DD4VhCE1o7BI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786944172; v=1; x=1787548972;
 b=fZY4VW2jrztFPGd+PEX1YF1WhoERneEPZuKHFuWjSZAMLuOtRatWin5hzJ8P5LwrIPgBwfe9
 vFppRCmuI3jxIx1R6QJI2ttnTI0eFPdRNwjcziOsdJmmZ+df8Y+YPPlidcM2iEA6CSOZIBv7cbW
 /TuESvNUP6TWySNVBDtXr66Y=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost (2408:84e1:426:d677:802:e2c9:7497:438a)
	by smtp.migadu.com with ESMTPS id 0a635fc3c9960c07;
	Mon, 17 Aug 2026 05:22:52 +0000
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	hdanton@sina.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in exit_to_user_mode_loop
Date: Mon, 17 Aug 2026 02:21:46 -0500
Message-ID: <20260817072146.313493-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6887ebf4.a00a0220.b12ec.00ae.GAE@google.com>
References: <6887ebf4.a00a0220.b12ec.00ae.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git 24ef02f934eeb48830cff6b739abc3c62b1d107b

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 299234a5f0fe..7519bc5c1aff 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -259,6 +259,26 @@ static int length_to_duration(struct taprio_sched *q, int len)
 	return div_u64(len * atomic64_read(&q->picos_per_byte), PSEC_PER_NSEC);
 }
 
+/* Software schedules service one hrtimer expiry per entry; intervals
+ * shorter than the expiry service cost rearm the timer with an expiry
+ * already in the past and storm the CPU. 100us leaves margin above the
+ * measured cost on debug configurations.
+ */
+#define TAPRIO_MIN_SW_INTERVAL_NS	(100 * NSEC_PER_USEC)
+
+static s64 taprio_min_interval(struct taprio_sched *q)
+{
+	s64 min_interval = length_to_duration(q, ETH_ZLEN);
+
+	/* Only pure software schedules arm the per-entry hrtimer. */
+	if (!FULL_OFFLOAD_IS_ENABLED(q->flags) &&
+	    !TXTIME_ASSIST_IS_ENABLED(q->flags))
+		min_interval = max_t(s64, min_interval,
+				     TAPRIO_MIN_SW_INTERVAL_NS);
+
+	return min_interval;
+}
+
 static int duration_to_length(struct taprio_sched *q, u64 duration)
 {
 	return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
@@ -915,6 +935,51 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
 	return false;
 }
 
+/* The operational schedule fell behind, e.g. because the timer was delayed
+ * or the reference clock stepped forward. Advancing one entry per timer
+ * expiry would replay the whole backlog from hrtimer context, so skip
+ * complete cycles arithmetically and walk the remaining entries to land on
+ * the entry covering the current time.
+ */
+static void taprio_catch_up(struct sched_gate_list *oper,
+			    struct sched_entry **next, ktime_t *next_start,
+			    ktime_t *end_time, ktime_t now)
+{
+	int budget = 2 * oper->num_entries + 1;
+	struct sched_entry *entry = *next;
+	ktime_t start = *next_start;
+	ktime_t end = *end_time;
+	s64 behind = ktime_sub(now, end);
+
+	if (oper->cycle_time > 0 && behind >= oper->cycle_time) {
+		s64 jump = div64_s64(behind, oper->cycle_time) * oper->cycle_time;
+
+		start = ktime_add_ns(start, jump);
+		end = ktime_add_ns(end, jump);
+		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time, jump);
+	}
+
+	while (ktime_before(end, now) && --budget) {
+		if (list_is_last(&entry->list, &oper->entries) ||
+		    ktime_compare(end, oper->cycle_end_time) == 0) {
+			entry = list_first_entry(&oper->entries,
+						 struct sched_entry, list);
+			oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time,
+							    oper->cycle_time);
+		} else {
+			entry = list_next_entry(entry, list);
+		}
+
+		start = end;
+		end = ktime_add_ns(end, entry->interval);
+		end = min_t(ktime_t, end, oper->cycle_end_time);
+	}
+
+	*next = entry;
+	*next_start = start;
+	*end_time = end;
+}
+
 static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 {
 	struct taprio_sched *q = container_of(timer, struct taprio_sched,
@@ -924,7 +989,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	int num_tc = netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch = q->root;
-	ktime_t end_time;
+	ktime_t end_time, next_start, now;
 	int tc;
 
 	spin_lock(&q->current_entry_lock);
@@ -960,14 +1025,19 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 		next = list_next_entry(entry, list);
 	}
 
-	end_time = ktime_add_ns(entry->end_time, next->interval);
+	next_start = entry->end_time;
+	end_time = ktime_add_ns(next_start, next->interval);
 	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
 
+	now = taprio_get_time(q);
+	if (unlikely(ktime_before(end_time, now)))
+		taprio_catch_up(oper, &next, &next_start, &end_time, now);
+
 	for (tc = 0; tc < num_tc; tc++) {
 		if (next->gate_duration[tc] == oper->cycle_time)
 			next->gate_close_time[tc] = KTIME_MAX;
 		else
-			next->gate_close_time[tc] = ktime_add_ns(entry->end_time,
+			next->gate_close_time[tc] = ktime_add_ns(next_start,
 								 next->gate_duration[tc]);
 	}
 
@@ -1038,7 +1108,7 @@ static int fill_sched_entry(struct taprio_sched *q, struct nlattr **tb,
 			    struct sched_entry *entry,
 			    struct netlink_ext_ack *extack)
 {
-	int min_duration = length_to_duration(q, ETH_ZLEN);
+	s64 min_duration = taprio_min_interval(q);
 	u32 interval = 0;
 
 	if (tb[TCA_TAPRIO_SCHED_ENTRY_CMD])
@@ -1166,7 +1236,7 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 		new->cycle_time = cycle;
 	}
 
-	if (new->cycle_time < new->num_entries * length_to_duration(q, ETH_ZLEN)) {
+	if (new->cycle_time < (s64)new->num_entries * taprio_min_interval(q)) {
 		NL_SET_ERR_MSG(extack, "'cycle_time' is too small");
 		return -EINVAL;
 	}
