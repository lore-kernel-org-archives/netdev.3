Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84A3A2E28;
	Mon, 12 Oct 2026 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845600; cv=none; b=ECv8EJSGyYqg9UwlZk9wl3DyLXvLhzUH/oLZ7s0Tb3L2teZ84SmV2JPLXlKVvoAxR5KugZ6n5njmf/38e3fSP/Q915RKGJS6F8Tkjs3v9IGFNPs5GYVFfPD0E+5djnZouww7JXLzBhbOXdxsfjUXjrimMgBdWG28WA5z0Hl02j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845600; c=relaxed/simple;
	bh=QKLFS6h5vmh0bfFzlLeaMUIP0TIZeyxgb+FOI6Y66GU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTDr0WhrNayc/xZEc7IVYkHCWMB6+1fOSRSpzbCPsdVcwkBea9o0vyM0PXVXUsWPXt/w2K8mub6GRIMXHBJnp6SY4GCfRkxb85BJoee/McyY/aSptRtUiAB8PMUaYmj2CS+ECOD0caQQobMQuMyWXd9SBKBZcs5ZevXCuqKbTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6NremcM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6NremcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791845599; x=1823381599;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QKLFS6h5vmh0bfFzlLeaMUIP0TIZeyxgb+FOI6Y66GU=;
  b=N6NremcMS4DIdB6aMURUyXa2v7pgbj0cpAdBBsQNUPK6ty+KKYiUjc9R
   g2BNwt25c2woAafUMQ6PPnGItzpJIxOmzja1r0zZMAoAZQcWIu6mconPw
   nIQGHVnVLnSz0OOHDRyqZc1AJ2JFb0GdfImf51iZSl3jQcoLo8ACjjZdl
   1B86mE+mgzFXwOmw61ONXs4DUIsH4fm4tAq/AodYzYI9k7d+vylksh9lb
   Xb7bkzp1xRdOCjHWqq0C1Hy1Zk21vVoMdgeIzpmViYlt5xPP0jlVkBnJd
   aQaJ5RXmemGm7f4dhUG9BsT6RAUgVTCMh728b+AHno7svuTAbgNB5N0n4
   Q==;
X-CSE-ConnectionGUID: a1XViGtlSP2rucTFwGqc6g==
X-CSE-MsgGUID: Z6x9jzkOQka5zwuhgsIjhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="448729"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="448729"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:53:18 -0700
X-CSE-ConnectionGUID: C/DEypYpR3epeort+QbWig==
X-CSE-MsgGUID: 21eJ7L1eRXipUJZhrHFH9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="945329"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.241.243.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:53:19 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+e044a9b6370ed8ca9737@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 2/2] net/sched: taprio: do not replay missed
 entries in advance_sched()
In-Reply-To: <20261009123309.284193-3-krystianmkaniewski@gmail.com>
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
 <20261009123309.284193-3-krystianmkaniewski@gmail.com>
Date: Mon, 12 Oct 2026 15:53:18 -0700
Message-ID: <87ik36lee9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> advance_sched() advances the software schedule by one entry per hrtimer
> expiry and rearms the timer at the nominal end of that entry, without
> reading the clock. When that time has already passed, the hrtimer core
> runs the callback again inside the same interrupt, once for every missed
> entry.
>
> syzbot hits this with a single 127 ns entry on a veth device.
> fill_sched_entry() only rejects intervals below the transmission time of
> a minimum sized frame, which is 48 ns at the 10 Gb/s reported by veth,
> so 127 ns is accepted. One expiry takes longer than 127 ns, so the
> backlog grows instead of shrinking, the CPU stays in the timer interrupt
> and RCU reports a stall. Lateness from a forward step of CLOCK_REALTIME
> or CLOCK_TAI, from resume with CLOCK_BOOTTIME, or from a long time with
> interrupts disabled leads to the same replay with any interval.
>
> Record when the schedule starts and the period after which it repeats,
> which is the cycle time, or the sum of the intervals when the entries
> end before the cycle does. Whenever the entry that advance_sched() is
> about to start has already ended, find the entry in progress from these
> two values and continue from there. This selects the entry and the end
> time that the replay would have reached, so a schedule that keeps up
> with its timer behaves as before. The same check covers the first entry
> after taprio_change() resets the current entry of a running schedule,
> and the first entry of an admin schedule that takes over late.
>
> advance_sched() now evaluates should_change_schedules() once on the
> caught up end time instead of once per missed entry. That is only
> equivalent if the test is monotonic in the end time, so make the
> cycle_time_extension sum in that helper saturate instead of wrap. The
> extension comes from netlink as an unbounded signed value.
>
> This bounds the work done per expiry. It does not limit how often the
> timer fires. Unless the clock is stepped backward between the hrtimer
> core reading it and the callback reading it, the timer is rearmed after
> the current time and the CPU leaves the timer interrupt between
> expiries. On the high-resolution hard interrupt path, a schedule whose
> intervals are shorter than one expiry is then held back by the hang
> detection in hrtimer_interrupt().
>
> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> Reported-by: syzbot+e044a9b6370ed8ca9737@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e044a9b6370ed8ca9737
> Assisted-by: Codex:gpt-6.1-sol
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---

This one I need more time to review, from a quick look it looks good.
Just a few minor comments for now.

>  struct taprio_sched {
> @@ -902,8 +909,19 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
>  	 * plus the amount that can be extended would fall after the
>  	 * next schedule base_time, we can extend the current schedule
>  	 * for that amount.
> +	 *
> +	 * cycle_time_extension is an unbounded signed value from netlink, so
> +	 * clamp the sum instead of letting it wrap. A wrap would make this
> +	 * test non-monotonic in end_time, and advance_sched() relies on it
> +	 * being monotonic to check it once after catching up instead of once
> +	 * per skipped entry.
>  	 */
> -	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
> +	if (oper->cycle_time_extension > 0 &&
> +	    end_time > KTIME_MAX - oper->cycle_time_extension)
> +		extension_time = KTIME_MAX;
> +	else
> +		extension_time = ktime_add_ns(end_time,
> +					      oper->cycle_time_extension);
>

This one I could argue that it could be in a separate patch. As the
wrapping could cause issues even before these changes, no?

>  	/* FIXME: the IEEE 802.1Q-2018 Specification isn't clear about
>  	 * how precisely the extension should be made. So after
> @@ -915,6 +933,51 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
>  	return false;
>  }
>  
> +/* Returns the entry of @sched which is in progress at @now, the one that
> + * advance_sched() reaches by moving one entry per expiry from the start of
> + * the schedule, and sets @start and @end to the times at which it started
> + * and ends. Also sets the end of the cycle which contains it.
> + */
> +static struct sched_entry *taprio_entry_at(struct sched_gate_list *sched,
> +					   ktime_t now, ktime_t *start,
> +					   ktime_t *end)
> +{

I like the idea of having this primitive.

> +	struct sched_entry *entry, *found = NULL;
> +	ktime_t cycle_start = sched->start_time;
> +	s64 offset, entry_end = 0, elapsed = 0;
> +
> +	if (ktime_after(now, cycle_start)) {
> +		s64 periods = div64_s64(ktime_sub(now, cycle_start),
> +					sched->period);
> +
> +		cycle_start = ktime_add_ns(cycle_start,
> +					   periods * sched->period);
> +	}
> +	offset = ktime_sub(now, cycle_start);
> +
> +	/* The offset is less than one period, so an entry which ends after
> +	 * @now is found at the latest at the entry which reaches the end of
> +	 * the cycle, or at the last entry. A schedule has at least one entry,
> +	 * so the loop always sets found.
> +	 */
> +	list_for_each_entry(entry, &sched->entries, list) {
> +		entry_end = min_t(s64, elapsed + entry->interval,
> +				  sched->cycle_time);
> +		if (offset < entry_end ||
> +		    list_is_last(&entry->list, &sched->entries)) {
> +			found = entry;
> +			break;
> +		}
> +		elapsed = entry_end;
> +	}
> +
> +	*start = ktime_add_ns(cycle_start, elapsed);
> +	*end = ktime_add_ns(cycle_start, entry_end);
> +	sched->cycle_end_time = ktime_add_ns(cycle_start,
> sched->cycle_time);

Having this side effect here was unexpected. I think this would make
more sense outside this function.

> +
> +	return found;
> +}
> +
>  static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  {
>  	struct taprio_sched *q = container_of(timer, struct taprio_sched,
> @@ -923,8 +986,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	struct sched_gate_list *oper, *admin;
>  	int num_tc = netdev_get_num_tc(dev);
>  	struct sched_entry *entry, *next;
> +	ktime_t end_time, start, now;
>  	struct Qdisc *sch = q->root;
> -	ktime_t end_time;
>  	int tc;
>  
>  	spin_lock(&q->current_entry_lock);
> @@ -938,6 +1001,15 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	if (!oper)
>  		switch_schedules(q, &admin, &oper);
>  
> +	/* The entry selected below can be over already, after a clock step,
> +	 * a long time with interrupts disabled, or because the intervals are
> +	 * shorter than one expiry takes. Moving on by one entry and arming the
> +	 * timer in the past would run this function again for every missed
> +	 * entry without leaving the timer interrupt. Take the entry which is in
> +	 * progress now instead, so that the timer is always armed after now.
> +	 */
> +	now = taprio_get_time(q);
> +
>  	/* This can happen in two cases: 1. this is the very first run
>  	 * of this function (i.e. we weren't running any schedule
>  	 * previously); 2. The previous schedule just ended. The first
> @@ -948,27 +1020,26 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  		next = list_first_entry(&oper->entries, struct sched_entry,
>  					list);
>  		end_time = next->end_time;
> -		goto first_run;
> -	}
> -
> -	if (should_restart_cycle(oper, entry)) {
> -		next = list_first_entry(&oper->entries, struct sched_entry,
> -					list);
> -		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time,
> -						    oper->cycle_time);
> +		if (likely(ktime_after(end_time, now)))
> +			goto first_run;
> +		/* Also after taprio_change() while the schedule runs */
> +		next = taprio_entry_at(oper, now, &start, &end_time);
>  	} else {
> -		next = list_next_entry(entry, list);
> -	}
> -
> -	end_time = ktime_add_ns(entry->end_time, next->interval);
> -	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
> +		if (should_restart_cycle(oper, entry)) {
> +			next = list_first_entry(&oper->entries,
> +						struct sched_entry, list);
> +			oper->cycle_end_time =
> +				ktime_add_ns(oper->cycle_end_time,
> +					     oper->cycle_time);
> +		} else {
> +			next = list_next_entry(entry, list);
> +		}
>  
> -	for (tc = 0; tc < num_tc; tc++) {
> -		if (next->gate_duration[tc] == oper->cycle_time)
> -			next->gate_close_time[tc] = KTIME_MAX;
> -		else
> -			next->gate_close_time[tc] = ktime_add_ns(entry->end_time,
> -								 next->gate_duration[tc]);
> +		start = entry->end_time;
> +		end_time = ktime_add_ns(start, next->interval);
> +		end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
> +		if (unlikely(!ktime_after(end_time, now)))
> +			next = taprio_entry_at(oper, now, &start, &end_time);
>  	}
>  
>  	if (should_change_schedules(admin, oper, end_time)) {
> @@ -978,8 +1049,20 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  		 */
>  		next = list_first_entry(&oper->entries, struct sched_entry, list);
>  		end_time = next->end_time;
> +		if (likely(ktime_after(end_time, now)))
> +			goto set_budgets;
> +		next = taprio_entry_at(oper, now, &start, &end_time);
> +	}
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		if (next->gate_duration[tc] == oper->cycle_time)
> +			next->gate_close_time[tc] = KTIME_MAX;
> +		else
> +			next->gate_close_time[tc] =
> +				ktime_add_ns(start, next->gate_duration[tc]);
>  	}
>  
> +set_budgets:
>  	next->end_time = end_time;
>  	taprio_set_budgets(q, oper, next);
>  
> @@ -1285,7 +1368,8 @@ static void setup_first_end_time(struct taprio_sched *q,
>  {
>  	struct net_device *dev = qdisc_dev(q->root);
>  	int num_tc = netdev_get_num_tc(dev);
> -	struct sched_entry *first;
> +	struct sched_entry *first, *entry;
> +	s64 intervals = 0;
>  	ktime_t cycle;
>  	int tc;
>  
> @@ -1297,6 +1381,11 @@ static void setup_first_end_time(struct taprio_sched *q,
>  	/* FIXME: find a better place to do this */
>  	sched->cycle_end_time = ktime_add_ns(base, cycle);
>  
> +	list_for_each_entry(entry, &sched->entries, list)
> +		intervals += entry->interval;
> +	sched->start_time = base;
> +	sched->period = min_t(s64, intervals, cycle);
> +
>  	first->end_time = ktime_add_ns(base, first->interval);
>  	taprio_set_budgets(q, sched, first);
>  
> -- 
> 2.53.0
>

-- 
Vinicius
