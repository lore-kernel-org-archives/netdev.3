Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8D41A56F;
	Sat, 29 Aug 2026 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788040721; cv=none; b=DAylg0duQkQNYU+oPkl+STyigYTCj3xBllkRbsz8MZ2yF7p6fRYdZMe3KW3ZTz7vhOLLFOwDuXnL7WXWmTZmAJqgyBI97zQutwRr3rwQk2Q+sgGU5i3lUEvUbEVbyUOjMEAOJP2pUtQcfJyDpNTyvI5M1iRN+ffm5TVuqSBbEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788040721; c=relaxed/simple;
	bh=jp7Lces/2Eg1UQKRgafSHJa0d9mOhphFOk2iZ6Iw1JI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GjdukcglSdjXEwwKJrepZkP59bT7Q8aFQ/wVHry1nw6z0stjlMbu9HRHQ9SZBPGNzmtslCuc9trPBaaCjVoRpCP8C7tg8EYyl9PtLfJMWdaWjok3DW/6evXFw4cOCABWdnh80lGhSio0f66rUixrkWbnGcCqCdKKXZl+f7PuC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f2h2yJOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f2h2yJOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405321F000E9;
	Sat, 29 Aug 2026 21:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788040719;
	bh=pdp2KYYF/8DbOvF5byyXuFVlInYv4CiLt0saQi9aJsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f2h2yJOGpiZ7jQWOsex1MBBGzJDL2xe4GDMoiuttXJpgCWkVoS9zQq2EmHbs5TauG
	 DTTp0Jd6w5/lSnMX/1ECf7h1m1rL98R6Co8g5recVRUDuTclbhBlFj0jRL2zkJknFw
	 CYjzl9QlkJNzQLNUaJkI/JVrDPdgQW5bEhjAehNg=
Date: Sat, 29 Aug 2026 14:58:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com>
Cc: dvyukov@google.com, elver@google.com, glider@google.com,
 jannh@google.com, kasan-dev@googlegroups.com, liam.howlett@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, netdev@vger.kernel.org, pfalcato@suse.de,
 syzkaller-bugs@googlegroups.com, vbabka@suse.cz, Junjie Cao
 <junjie.cao@intel.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in __mmap_complete
Message-Id: <20260829145838.19351db0a28b30b7ccc1b295@linux-foundation.org>
In-Reply-To: <6a934778.4d659fcc.734b4.002f.GAE@google.com>
References: <695aefde.050a0220.1c9965.001c.GAE@google.com>
	<6a934778.4d659fcc.734b4.002f.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Aug 2026 13:56:24 -0700 syzbot <syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following iss
> 
> HEAD commit:    1b78070aaef6 Merge tag 'net-7.3-rc1' of git://git.kernel.o..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=154d7d49580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4aa91d7f20c34417d4e
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134d7d49580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1177ae25580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18856a03a9a3/disk-1b78070a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cc2bc68d7ef4/vmlinux-1b78070a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/05a5e00f8f91/bzImage-1b78070a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

From: Junjie Cao <junjie.cao@intel.com>
Subject: net/sched: taprio: catch up in bounded time when the schedule falls behind
Date: Thu, 20 Aug 2026 14:27:13 +0800

advance_sched() advances exactly one entry per hrtimer expiry.  When the
operational schedule falls behind - the timer was delayed, the CPU was
starved, or the reference clock stepped forward - every elapsed entry is
replayed back to back from hrtimer context with current_entry_lock held,
and each replay rearms the timer with an expiry in the past.  Once the
backlog is large enough the CPU never leaves timer processing and RCU
stalls follow.  syzbot triggers this with schedules whose intervals are
shorter than the cost of servicing one expiry, so the backlog only ever
grows.

Skip complete cycles arithmetically and walk at most one cycle of entries
to land on the entry covering the current time.  Gate close times and
budgets are still only computed for the entry landed on.  An admin
schedule crossed by the jump is picked up by the existing
should_change_schedules() check on the recomputed end time.  The walk is
capped at twice the entry count as a safeguard against degenerate
intervals; leftover backlog is then handled by the next expiry as today.

Link: https://lore.kernel.org/20260820062715.278124-2-junjie.cao@intel.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 net/sched/sch_taprio.c |   56 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

--- a/net/sched/sch_taprio.c~net-sched-taprio-catch-up-in-bounded-time-when-the-schedule-falls-behind
+++ a/net/sched/sch_taprio.c
@@ -916,6 +916,51 @@ static bool should_change_schedules(cons
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
@@ -925,7 +970,7 @@ static enum hrtimer_restart advance_sche
 	int num_tc = netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch = q->root;
-	ktime_t end_time;
+	ktime_t end_time, next_start, now;
 	int tc;
 
 	spin_lock(&q->current_entry_lock);
@@ -961,14 +1006,19 @@ static enum hrtimer_restart advance_sche
 		next = list_next_entry(entry, list);
 	}
 
-	end_time = ktime_add_ns(entry->end_time, next->interval);
+	next_start = entry->end_time;
+	end_time = ktime_add_ns(next_start, next->interval);
 	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
 
+	now = hrtimer_cb_get_time(timer);
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
 
_

