Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4728E370D6E
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611578; cv=none; b=PGwt15lW9w+RrT07QhECgNMu5VAijmFiYRc5EOMhcR9T8/DOj2IrPvQNlg831zbWZdayB4b+5gFgHbz2lDqy2L9W043lucJq0jzuvDjYqMnlrzhGxEUOEfB98Gn75vR3Q6nn1cdp0o4EDniH4ftFAM+srmFCPxItyNHs3nrHjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611578; c=relaxed/simple;
	bh=LWlDKF50WQzp/8c5IiMmc5IqPdNFpeMIxfZ1jFvg9O0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lEvFGw7Du35lpRNz+tHtGlyWBwPFodjY2Mqa70pGCKI0cIq2vospQGa2xBCEvyEe9mrnHXfL6J/10kKMuWTvtqxff+4Lmk/rUk3WQxMR8vVU+syjfC8g7QLfUSut17USRgo0whABeP4flh6HG8SznOrVZ77LtiqTGgSnXzLwSNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOgkK5i7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOgkK5i7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034401F000FF;
	Sat, 10 Oct 2026 05:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791611576;
	bh=0K6hmcX6NNTeJvar8oL2JSoi1NMF+DBugT04LsGaiE8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QOgkK5i7ILAQ053kTre8ejyvMSVGK1O7XQgMyb+cm5sobOwgrZMXtmUlfSLL8wV37
	 /Z4YzO6BGNAbES5VdPXsNWpKcopBeHhgbHwDUPmK77YpHcPdLygpD5dRTEkmn58X6b
	 dwWgZptPE9rxco1KIFyQlrFI01B9km16zhub2BISMAe9xlx9QfLAx0iEYQEOw3F9BT
	 KXEuxKlX/Qtov7N0FmwOsnr6S7Bx+dXr4wFY+w9Z0uUO1GhkApTEWKx5cJwJHMPL6v
	 KoCi5a2M5+xXfQWdqToecAE9gVD+lmSMuBuMuwDqA4GOSOipT1tvsQPKsFGdbmdQVS
	 MJAYRODVMAQrg==
Subject:
 Re: [PATCH net] net/sched: act_api: take tcfa_lock for hardware stats updates
From: netdev-bot+sashiko@kernel.org
To: acassen@corp.free.fr
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vladbu@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org
Date: Sat, 10 Oct 2026 05:52:55 +0000
Message-ID: <179161157546.434549.9093736644956306615@kernel.org>
In-Reply-To: <20261009051703.3615846-1-acassen@corp.free.fr>
References: <20261009051703.3615846-1-acassen@corp.free.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The per-CPU branch of tcf_action_update_stats()
  (net/sched/act_api.c) is still racy after this patch.

--

net/sched: act_api: take tcfa_lock for hardware stats updates

This commit takes tcfa_lock with spin_lock_bh() around hardware stats
updates in tcf_action_update_stats() for actions without per-CPU stats.
It also moves the preempt_disable()/preempt_enable() pair from the two
callers into the per-CPU branch of tcf_action_update_stats(), so that
PREEMPT_RT does not take a spinlock_t with preemption disabled.

> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index e45a63be397ce..f6f8cd0a5af64 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c

[ ... ]

> @@ -1588,6 +1586,7 @@ void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
>  			     u64 drops, bool hw)
>  {
>  	if (a->cpu_bstats) {
> +		preempt_disable();
>  		_bstats_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
>  
>  		this_cpu_add(a->cpu_qstats->drops, drops);
> @@ -1595,13 +1594,16 @@ void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
>  		if (hw)
>  			_bstats_update(this_cpu_ptr(a->cpu_bstats_hw),
>  				       bytes, packets);
> +		preempt_enable();
>  		return;
>  	}

[Severity: High]
The commit message says pinning the CPU is enough for the per-CPU path. Is
it, given that BH stays enabled here?

This per-CPU branch is the default, used unless
TCA_ACT_FLAGS_NO_PERCPU_STATS is set. The hardware stats writer reaches it
from process context:

tcf_dump_walker()  (holds mutex idrinfo->lock)
  tcf_action_update_hw_stats()
    tcf_action_stats_update()
      tcf_gact_stats_update()
        tcf_action_update_stats()

fl_hw_update_stats() / mall_stats_hw_filter()
  tcf_exts_hw_stats_update()
    ...
      tcf_action_update_stats()

A softirq on the same CPU can run while this writer is between
u64_stats_update_begin() and u64_stats_update_end() in _bstats_update().
That softirq can write the same per-CPU syncp from the software datapath:

tcf_gact_act()
  tcf_action_update_bstats()
    bstats_update(this_cpu_ptr(a->cpu_bstats), skb)

It can also read it from the rate estimator:

est_timer()
  est_fetch_counters()
    gnet_stats_add_basic()
      gnet_stats_add_basic_cpu()
        u64_stats_fetch_begin(&bcpu->syncp)

On 32-bit, u64_stats_add() is a plain p->v += val, and
__u64_stats_update_begin() only does preempt_disable_nested() plus
write_seqcount_begin(). Neither of those keeps BH out.

Could a softirq bstats_update() that lands inside the interrupted
read-modify-write then be overwritten, losing updates?

And if est_timer fires on this CPU while the writer holds the seqcount
odd, would read_seqcount_begin() spin forever? The interrupted writer
can't resume until the softirq returns. The estimator takes tcfa_lock
through e->stats_lock in est_fetch_counters(), but the per-CPU writer
never takes that lock, so it doesn't help here.

These look like the same symptoms the commit message describes ("lose
counter updates", "seqcount odd and make its readers spin forever"). They
seem to be fixed only for the non-per-CPU branch.

The race was already present through the callers' preempt_disable()
before this patch. Since this hunk rewrites that block, would
local_bh_disable()/local_bh_enable() work instead of
preempt_disable()/preempt_enable() here? That would also keep the task
on the current CPU and is safe on PREEMPT_RT.

>  
> +	spin_lock_bh(&a->tcfa_lock);
>  	_bstats_update(&a->tcfa_bstats, bytes, packets);
>  	atomic_add(drops, &a->tcfa_drops);
>  	if (hw)
>  		_bstats_update(&a->tcfa_bstats_hw, bytes, packets);
> +	spin_unlock_bh(&a->tcfa_lock);
>  }
>  EXPORT_SYMBOL(tcf_action_update_stats);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051703.3615846-1-acassen%40corp.free.fr
