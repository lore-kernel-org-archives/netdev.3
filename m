Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04F26FD9B;
	Thu,  3 Sep 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788395774; cv=none; b=bypdpGuEZa/AvrKzwfPYCgXRITVG/nMP4YsAiKGNyYkiNTei3fwvIbYMP1/W4bqoTSsST3/+oJjs5s3KRCf/WgCJLYz7fk0iRm6IP43OaZ+oYd2HAtw3qQqId5ZCrTYP98AExmnH8mF3YgUSl52nft4Z6V6U/WuLplDGwb6+gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788395774; c=relaxed/simple;
	bh=LmgEmsYcQWsfhNnkH1A0G4Z+9NO+ltICAddaBBqbAVY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jO2S35d4lIkeSVJt84/a4vvEgO36kVNHpIxV751xEKbONs4byOeF5pr0qQEyzkjANCpzl3bRY5UG4c5KDmRROK++K8kQXwAqaxPPwt/xKXI3rs3de3TxcFjuyawY+3J+4PH993nNrnSKwkAzIzYQR+CzF3XMEvVfSGjXuQmihjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbQV449q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbQV449q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847BD1F00A3A;
	Thu,  3 Sep 2026 00:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788395772;
	bh=TyHYg0vhFMbcDU/ElIs1W6Oc764INMVYJqwl3+QuBXg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VbQV449qUkxk6pxxI19ti1/e8xkjopcZhjonBnGnoHQiP5dSapRXQwrT22pXbDFH1
	 fI19LDjUoG+rNkfZ+kyyZuyLUv8ByI5zI9VFoDfZdLE4oXzax/kbDQT2wujxxrqnAv
	 es5NsjkCafAnR4DXjopzX/uKAIqZ1eS/5O0EK/ZTXDl+wb3aTphOD8Jkc9UjFqThVJ
	 5/BaPisi7YkV3V7JsoqsG9mgejYFmyN+RdaCSuBotcZz5aRlUB/qn5wznoCM9FZX7t
	 QEniW3IfofIwp9wOLyAwV49k4HjYpGyQRdQS0Akao/sp1KaezHU9uaG2rw1oTzAI38
	 x27pYGw8bDvZg==
Subject: Re: [net,v3] net/sched: taprio: catch up in bounded time when the
 schedule falls behind
From: netdev-bot+sashiko@kernel.org
To: junjie.cao@intel.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, vinicius.gomes@intel.com, akpm@linux-foundation.org,
 hdanton@sina.com, uladzislau.zhauniarovich@gmail.com, bestswngs@gmail.com,
 syzbot+19d01f6082ec61dd45b2@syzkaller.appspotmail.com,
 syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com,
 syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com,
 syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 00:36:11 +0000
Message-ID: <178839577112.3394541.14233212109648080060@kernel.org>
In-Reply-To: <20260901093340.420809-1-junjie.cao@intel.com>
References: <20260901093340.420809-1-junjie.cao@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

- [Medium] Data race on a live, RCU-published `struct sched_entry`: the
  new catch-up walk in `advance_sched()`…

Pre-existing issues:
- [Low] Claim that the new `sched_gate_list::period` contract
  (min(cycle_time, sum of intervals), net/sched/sch_taprio.c:86-89) is…

--

net/sched: taprio: catch up in bounded time when the schedule falls behind

advance_sched() used to advance exactly one schedule entry per hrtimer
expiry, so a delayed timer or a stepped reference clock made it replay the
whole backlog from timer context.  This patch skips whole periods
arithmetically, records the software period as min(cycle_time, sum of
intervals) at parse time, and caps the remaining walk at twice the entry
count.

Closes: https://syzkaller.appspot.com/bug?extid=19d01f6082ec61dd45b2
Closes: https://syzkaller.appspot.com/bug?extid=8785aaf121cfb2141e0d
Closes: https://syzkaller.appspot.com/bug?extid=2642f347f7309b4880dc
Closes: https://syzkaller.appspot.com/bug?extid=e4aa91d7f20c34417d4e

> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 39ac5b97aa3af..901dfd2484e10 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -83,6 +83,10 @@ struct sched_gate_list {
>  	s64 cycle_time;
>  	s64 cycle_time_extension;
>  	s64 base_time;
> +	/* min(cycle_time, sum of intervals): the software schedule restarts
> +	 * the list after the last entry even when cycle_time is not up yet.
> +	 */
> +	s64 period;
>  };

[Severity: Low]
This is a pre-existing issue and not introduced by the patch, but now that
the effective software repetition length has a name, should the sites that
test for an "always open" gate use it too?

The "never closes" tests all compare against cycle_time rather than the new
period:

net/sched/sch_taprio.c:advance_sched() {
	if (next->gate_duration[tc] == oper->cycle_time)
		next->gate_close_time[tc] = KTIME_MAX;
}

net/sched/sch_taprio.c:taprio_set_budgets() {
	/* Traffic classes which never close have infinite budget */
	if (entry->gate_duration[tc] == sched->cycle_time)
		budget = INT_MAX;
}

The same equality against cycle_time is used in
taprio_update_queue_max_sdu() and setup_first_end_time(), while
taprio_calculate_gate_durations() accumulates gate_duration over the whole
circular list:

net/sched/sch_taprio.c:taprio_calculate_gate_durations() {
		cur = list_next_entry_circular(cur, &sched->entries, list);
	} while (cur != entry);
}

So gate_duration[tc] can be at most the sum of the intervals.  When
cycle_time is configured larger than that sum, does a gate that is open in
every entry still match "== cycle_time", or does it end up with a finite
gate_close_time and a finite byte budget instead of KTIME_MAX / INT_MAX?

> @@ -952,23 +958,49 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  		goto first_run;
>  	}
>  
> -	if (should_restart_cycle(oper, entry)) {
> -		next = list_first_entry(&oper->entries, struct sched_entry,
> -					list);
> -		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time,
> -						    oper->cycle_time);
> -	} else {
> -		next = list_next_entry(entry, list);
> +	now = hrtimer_cb_get_time(timer);
> +	end_time = entry->end_time;
> +	behind = ktime_sub(now, end_time);
> +
> +	/* Behind, e.g. delayed timer or stepped clock: skip whole periods
> +	 * arithmetically and walk at most one more to the entry covering
> +	 * now, instead of replaying the backlog one expiry at a time. The
> +	 * cap bounds the walk; a leftover is picked up by the next expiry.
> +	 */
> +	if (unlikely(behind >= oper->period)) {
> +		s64 jump = div64_s64(behind, oper->period) * oper->period;
> +
> +		end_time = ktime_add_ns(end_time, jump);
> +		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time, jump);
>  	}
>  
> -	end_time = ktime_add_ns(entry->end_time, next->interval);
> -	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
> +	budget = 2 * oper->num_entries;
> +	do {
> +		if (should_restart_cycle(oper, entry, end_time)) {
> +			next = list_first_entry(&oper->entries,
> +						struct sched_entry, list);
> +			oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time,
> +							    oper->period);
> +		} else {
> +			next = list_next_entry(entry, list);
> +		}
> +
> +		next_start = end_time;
> +		end_time = ktime_add_ns(next_start, next->interval);
> +		end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
> +		entry = next;
> +	} while (unlikely(ktime_compare(end_time, now) <= 0) && budget--);
>  
> +	/* next can be the entry already published as q->current_entry (a
> +	 * single-entry schedule, or a catch-up of whole periods), so the
> +	 * close times and budgets below are rewritten in place while
> +	 * taprio_dequeue_from_txq() may be reading them.
> +	 */
>  	for (tc = 0; tc < num_tc; tc++) {
>  		if (next->gate_duration[tc] == oper->cycle_time)
>  			next->gate_close_time[tc] = KTIME_MAX;
>  		else
> -			next->gate_close_time[tc] = ktime_add_ns(entry->end_time,
> +			next->gate_close_time[tc] = ktime_add_ns(next_start,
>  								 next->gate_duration[tc]);
>  	}

[Severity: Medium]
Can this race on the live entry be avoided rather than documented?

The walk reassigns entry = next on every iteration, so after num_entries
steps it lands back on the entry that is still published in
q->current_entry.  With the leftover r = behind % period, the extra step is
taken whenever r >= period - interval(current entry), so multi-entry
schedules can reach the case too, not just the single-entry one.

Once next == q->current_entry, advance_sched() rewrites gate_close_time[]
with plain 64-bit stores while the dequeue path reads it lockless:

net/sched/sch_taprio.c:taprio_entry_allows_tx() {
	return ktime_before(skb_end_time, entry->gate_close_time[tc]);
}

net/sched/sch_taprio.c:taprio_dequeue_from_txq() {
	if (gate_mask != TAPRIO_ALL_GATES_OPEN &&
	    !taprio_entry_allows_tx(guard, entry, tc))
		return NULL;

	/* ... and no budget. */
	if (gate_mask != TAPRIO_ALL_GATES_OPEN &&
	    taprio_update_budgets(entry, len, tc, num_tc) < 0)
		return NULL;
}

advance_sched() holds q->current_entry_lock and runs from the hrtimer
(HRTIMER_MODE_ABS, hardirq), while taprio_dequeue() ->
taprio_dequeue_tc_priority() -> taprio_dequeue_from_txq() only holds
rcu_read_lock() and never takes that lock.  On 32-bit, can
taprio_entry_allows_tx() observe a torn ktime_t here, since neither side
uses READ_ONCE()/WRITE_ONCE()?

The budget reset has the same overlap:

net/sched/sch_taprio.c:taprio_set_budgets() {
		atomic_set(&entry->budget[tc], budget);
}

Can this atomic_set() on the published entry discard a concurrent
atomic_sub()/atomic_sub_return() from taprio_update_budgets(), letting a
frame be released against a freshly reset budget?

The comment added above the loop states the overlap exists ("next can be
the entry already published as q->current_entry ... rewritten in place
while taprio_dequeue_from_txq() may be reading them").  Would it be
preferable to keep the writer off the published entry, for example by
stopping the walk one step earlier or by publishing before rewriting, so
the guard band and byte budget are not mutated underneath a reader?

[ ... ]

> @@ -1172,6 +1203,7 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
>  		return -EINVAL;
>  	}
>  
> +	new->period = min(new->cycle_time, cycle);
>  	taprio_calculate_gate_durations(q, new);
>  
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901093340.420809-1-junjie.cao%40intel.com
