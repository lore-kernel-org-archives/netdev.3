Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9834D90D7;
	Thu, 27 Aug 2026 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858216; cv=none; b=r5cy1pC0DNq5eBJqMtOa0CuuEUHpJovob97fWFSz5Hkegc3ARNV7OEt+n+aqO6cCDar6PG0sTcaaIyfKo/mTN/jWUXPz4T6UIMT6Yc+qAx7ET4kzpqn4L7IK1Sk4rF0T+mNuv3NpkfBi90wXQJJI4s4H7uM/e31bikMtlTmtH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858216; c=relaxed/simple;
	bh=nSFk8QouRqcAXjH7QIybL3wuGPyMySxvatnHLlktdPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rabCtpyAXqnysRI05VBgQwo+rERDBgGX0dLAtG+UrBcDhfExWrmdpSYnlTaGT/grjWQD+7zFzErPq8vXsmWtI8uXpKPwkMOwVnAUIquglaijkwwV7e3fLWOTGRTSXbpP/kl3t6N0CYQc5drtAhL7NGxZ4AhnP8mKqHxufDi/4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYwuHUcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYwuHUcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3B01F000E9;
	Thu, 27 Aug 2026 19:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858211;
	bh=7C8Z12fKP6kI3oIQBClFYdSRmzrNjKlRiXLKPOAuEnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYwuHUcOhJJT7yCWcTFtHz39KqL1yzhCVqJ5VK9In+xFvtSvNaZ2KwYSvRmeBOp77
	 t1E6e4oUpn9WLBOFcKhShVsAnKjGZXWMNtG7gnDQtAJDAe/pHX9OvcN5g11WCKZgoJ
	 qliOcl59XcEuPIJvo8h2cCuO8FRT1LUBa+pGv2qh9XycooSU8qvI0E7omHZ5+3di8G
	 Bl29ZcQLfWBh0z8KDDDM0pqfFEVOq3Hu4xaiyq4q516tNPcADwJCbjZPf5397QMJhA
	 YbqnS4o5ebYheNxHsk/j8KsX/Qm3/SyOdxAqSngXnKrOrD8/xxjtIsUikGxPJgqnXD
	 1QhmSnyB8CkJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: eadavis@qq.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	Po.Liu@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v3] net/sched: act_gate: Limit the max value for cycletime
Date: Thu, 27 Aug 2026 12:15:47 -0700
Message-ID: <20260827191547.4004973-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_FAEDEECDD478AE6DFC2DE96D389440E96A0A@qq.com>
References: <tencent_FAEDEECDD478AE6DFC2DE96D389440E96A0A@qq.com>
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

This changes the act_gate netlink policy so that TCA_GATE_CYCLE_TIME is
validated with NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64) against a range of
0 to S64_MAX, with the intent of preventing an s64 overflow in
gate_timer_func() that led to a soft lockup reported by syzbot.

Closes: https://syzkaller.appspot.com/bug?extid=0054fed3dc9085390f51

A couple of questions on the changelog and on the diff below.

> Modify the cycletime range in the policy to (0, S64_MAX), when parsing
> cycletime, ensuring its value does not exceed S64_MAX guarantees that the
> hrtimer can correctly calculate a valid expiry time.

[Severity: Low]
Should this read [0, S64_MAX] instead of (0, S64_MAX)?

gate_cycle_time_range uses .min = 0 and the range check in
nla_validate_int_range_signed() is inclusive, so a cycletime of 0 is still
accepted, and it keeps its special meaning in tcf_gate_init():

	if (!cycletime) {
		struct tcfg_gate_entry *entry;
		ktime_t cycle = 0;

		list_for_each_entry(entry, &p->entries, list)
			cycle = ktime_add_ns(cycle, entry->interval);
		cycletime = cycle;
	}

As written, the open interval wording suggests 0 is now rejected, which a
backporter might rely on.

> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index fdbfcaa3e2ab9..4c4a0f80dec1f 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -166,13 +166,19 @@ static const struct nla_policy entry_policy[TCA_GATE_ENTRY_MAX + 1] = {
>  	[TCA_GATE_ENTRY_MAX_OCTETS]	= { .type = NLA_S32 },
>  };
>  
> +static const struct netlink_range_validation_signed gate_cycle_time_range = {
> +	.min = 0,
> +	.max = S64_MAX,
> +};
> +
>  static const struct nla_policy gate_policy[TCA_GATE_MAX + 1] = {
>  	[TCA_GATE_PARMS]		=
>  		NLA_POLICY_EXACT_LEN(sizeof(struct tc_gate)),
>  	[TCA_GATE_PRIORITY]		= { .type = NLA_S32 },
>  	[TCA_GATE_ENTRY_LIST]		= { .type = NLA_NESTED },
>  	[TCA_GATE_BASE_TIME]		= { .type = NLA_U64 },
> -	[TCA_GATE_CYCLE_TIME]		= { .type = NLA_U64 },
> +	[TCA_GATE_CYCLE_TIME]		=
> +		NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64, &gate_cycle_time_range),

[Severity: High]
Does capping cycletime at S64_MAX actually remove the soft lockup?

The expiry is not computed from cycletime alone. In gate_get_start_time():

	base = ns_to_ktime(param->tcfg_basetime);
	now = gate_get_time(gact);

	if (ktime_after(base, now)) {
		*start = base;
		return;
	}

	cycle = param->tcfg_cycletime;

	n = div64_u64(ktime_sub_ns(now, base), cycle);
	*start = ktime_add_ns(base, (n + 1) * cycle);

TCA_GATE_BASE_TIME is left as { .type = NLA_U64 } with no range, so with
basetime = 1 and cycletime = S64_MAX (both accepted by the new policy)
n becomes 0 and the addition is 1 + (2^63 - 1), which wraps to S64_MIN
since ktime_add_ns() is plain 64-bit addition.

gate_start_timer() only clamps downward:

	start = min_t(ktime_t, start, expires);

	hrtimer_start(&gact->hitimer, start, HRTIMER_MODE_ABS_SOFT);

so the wrapped negative value is armed as an absolute expiry in the past.
The catch-up branch of gate_timer_func() then recomputes the same value on
every invocation:

	if (ktime_after(now, close_time)) {
		ktime_t cycle, base;
		u64 n;

		cycle = p->tcfg_cycletime;
		base = ns_to_ktime(p->tcfg_basetime);
		n = div64_u64(ktime_sub_ns(now, base), cycle);
		close_time = ktime_add_ns(base, (n + 1) * cycle);
	}
	...
	hrtimer_set_expires(&gact->hitimer, close_time);
	...
	return HRTIMER_RESTART;

which looks like the same "gate_timer_func in hrtimer_run_softirq" pattern
from the report, reachable via RTM_NEWACTION with basetime = 1,
cycletime = S64_MAX and one entry with a non-zero interval. A wide band of
policy-legal pairs wraps the same way, for example cycletime = S64_MAX - 10
with basetime = 10^12.

Would bounding the whole base + (n + 1) * cycle arithmetic be needed here,
the way sch_taprio.c does it?

	static const struct netlink_range_validation_signed taprio_cycle_time_range = {
		.min = 0,
		.max = INT_MAX,
	};
-- 
pw-bot: cr
