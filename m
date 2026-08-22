Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA13537F9;
	Sat, 22 Aug 2026 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430017; cv=none; b=bi49ZrWQ2Q7IHK4GRuiEqyt35TTiMkuK8gLQj4twg3GCA4uEPUwlR8s0LqCIozkKZ7EiWOrzgaen6Ji/FVivzALJSnqBO0++sQIh82N509JhWmbIEhN5XQwOZKDnPR5RlVacMBqAUhyyDHDJxesJHqsCa4BIZfsDDMeGWWejohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430017; c=relaxed/simple;
	bh=5h72g/zzrOeltfq/dqMBOaM0J2KXToCScVOewaomkog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV34b7cfiqu/kv6rZJO7FoEljhJweEWu+sk73JXtqdsR6H0M4oKmZ1KHq8QOyXpgmsHH+5GEs2IzW9/bpnT1CTEyNO8/gZregem4152uhWUmrfLI+RZUsalJK3ZlDz940n+LqE8mjnRS6ysRUypyRFBrghut8RFFdDvvnLYfT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWT4LlRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWT4LlRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01A31F000E9;
	Sat, 22 Aug 2026 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430013;
	bh=7Z9x5qxv465JzS86KwfX75Nr/7vCi0SV2kb9LycxQhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VWT4LlRGh8FuDQmdLqzZWAuwaMIQRGKCM44PvTWordoUNFpEi+sTBQKI2IJZgLa0E
	 +fpp6DXjAV4Yfl3BlA9uZntlNvo4vhPlx+zCbWDfromgFQKr1qxQruVftLYKBmNjN2
	 IdfQT1skEuQ/yn9nvBsuVAWIV0SEqOEsvKWH0Q0ui4IgLWz9+4vxvfwDaXk/AkPo8y
	 QufLpYeemIAIQR3J7QwpZZjRAWgtYHRk6K8oNBKXNz2cD0jzOb+lmySAkkWJfsVCKI
	 eFTKiHp7wffVSaAUiAsLzNaZ4JzsgG3sQWRBK0pIWWOIyqlRqWHk9xq37nPqP3raoH
	 evtntDt8U7guw==
From: Jakub Kicinski <kuba@kernel.org>
To: eadavis@qq.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Po.Liu@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net/sched: act_gate: Limit the max value for cycletime
Date: Sat, 22 Aug 2026 13:20:12 -0700
Message-ID: <20260822202012.2229309-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_19FD76F366C43D4737EE9682371A4BF87409@qq.com>
References: <tencent_19FD76F366C43D4737EE9682371A4BF87409@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/sched: act_gate: Limit the max value for cycletime

The patch clamps a user supplied TCA_GATE_CYCLE_TIME to S64_MAX in
tcf_gate_init() before storing it in p->tcfg_cycletime, so that the
ktime_t (s64) arithmetic used to compute gate close times does not see a
negative cycle.  It is tagged as the fix for a syzbot soft lockup inside
gate_timer_func().

Closes: https://syzkaller.appspot.com/bug?extid=0054fed3dc9085390f51

> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index fdbfcaa3e2ab..ad5a6d75bbda 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -501,6 +501,8 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>  			cycle = ktime_add_ns(cycle, entry->interval);
>  		cycletime = cycle;
>  	}
> +	if (cycletime > S64_MAX)
> +		cycletime = S64_MAX;

[Severity: High]
This isn't a bug introduced by this patch, since cycletime == S64_MAX
combined with a non-zero basetime already wrapped before it, but does
clamping to S64_MAX actually close the reported soft lockup?

The consumers do not use the cycle value on its own, they compute an
absolute expiry as base + (n + 1) * cycle with plain signed ktime
arithmetic:

net/sched/act_gate.c:gate_get_start_time() {
	...
	cycle = param->tcfg_cycletime;

	n = div64_u64(ktime_sub_ns(now, base), cycle);
	*start = ktime_add_ns(base, (n + 1) * cycle);
}

With cycle == S64_MAX and any non-zero basetime that is not in the
future, div64_u64(now - base, S64_MAX) is 0, so the addition is
base + S64_MAX and wraps negative (for a basetime of 1000 ns, start
becomes S64_MIN + 1000).  gate_start_timer() then takes
min_t(ktime_t, start, expires) and arms the timer with that past
absolute value in HRTIMER_MODE_ABS_SOFT.

gate_timer_func() recomputes the same wrapped value on every invocation:

net/sched/act_gate.c:gate_timer_func() {
	...
	if (ktime_after(now, close_time)) {
		cycle = p->tcfg_cycletime;
		base = ns_to_ktime(p->tcfg_basetime);
		n = div64_u64(ktime_sub_ns(now, base), cycle);
		close_time = ktime_add_ns(base, (n + 1) * cycle);
	}
	...
	hrtimer_set_expires(&gact->hitimer, close_time);
	...
	return HRTIMER_RESTART;
}

Since the expiry never advances past now, doesn't __hrtimer_run_queues()
keep re-running the callback in the same softirq pass, reproducing the
watchdog trace quoted in the changelog?  Only basetime == 0
self-corrects, because 0 + S64_MAX stays positive, which would explain
why the syzbot reproducer no longer trips; adding a base-time of 1000
appears to trip it again.

Two follow-on effects of that loop: gate_timer_func() re-takes
gact->tcf_lock on every iteration, and hrtimer_cancel() in
tcf_gate_cleanup() (and on the replace path in tcf_gate_init()) can
never see the perpetually re-armed timer dequeued, so the params and
entry list are never handed to call_rcu(&p->rcu,
tcf_gate_params_free_rcu).

Note also that TCA_GATE_BASE_TIME is read with a plain nla_get_u64()
and gate_policy declares it as unrestricted NLA_U64, so any
basetime/cycletime pair whose sum exceeds S64_MAX wraps the same way,
for example cycletime = 2^62 with basetime = 3 * 2^62.  Would bounding
the computed expiry instead (basetime + cycletime <= KTIME_MAX), or
rejecting the input in a narrower range as sch_taprio does, be a better
fit?

Related to this, the changelog says:

    When initializing cycletime, ensuring its value does not exceed
    S64_MAX guarantees that the hrtimer can correctly calculate a valid
    expiry time.

Given the wrap in base + (n + 1) * cycle above, is that guarantee
accurate for non-zero basetime?

[Severity: Medium]
Should an out-of-range cycle time be rejected rather than silently
rewritten?

gate_policy declares the attribute with no range restriction:

	[TCA_GATE_CYCLE_TIME]		= { .type = NLA_U64 },

and tcf_gate_dump() echoes the stored value back in the same attribute:

	if (nla_put_u64_64bit(skb, TCA_GATE_CYCLE_TIME,
			      p->tcfg_cycletime, TCA_GATE_PAD))

so a request with cycle-time 0xffffffffffffffff now succeeds, while a
subsequent dump reports S64_MAX.  There is no -EINVAL, no
NL_SET_BAD_ATTR and no extack message on that path.

A later replace that omits the attribute also inherits the rewritten
value:

net/sched/act_gate.c:tcf_gate_init() {
	...
			if (!err && !tb[TCA_GATE_CYCLE_TIME])
				cycletime = cur_p->tcfg_cycletime;
	...
}

Every other invalid input in this file is rejected with -EINVAL plus
extack (interval == 0 in fill_gate_entry(), bad clockid in
gate_clock_resolve(), empty entry list), and the same knob in
sch_taprio is rejected rather than clamped:

net/sched/sch_taprio.c:parse_taprio_schedule() {
	...
		if (cycle < 0 || cycle > INT_MAX) {
			NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
			return -EINVAL;
		}
	...
}

The branch immediately above the new check cannot exceed S64_MAX, since
intervals are non-zero u32 values and roughly 2^31 entries would be
needed, so the check only covers the user supplied attribute.  Could it
move to the parse stage and return -EINVAL with NL_SET_BAD_ATTR on
TCA_GATE_CYCLE_TIME instead?

>  	p->tcfg_cycletime = cycletime;
>  	p->tcfg_cycletime_ext = cycletime_ext;
>
-- 
pw-bot: cr
