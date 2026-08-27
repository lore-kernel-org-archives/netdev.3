Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E43FCB2F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820818; cv=none; b=R6GVsbIm6C78oFUILBFv74FwUdUMTc5BG2EGFfMCAF7j2PDhd1qSBXDHS/jYAWuNcgsvU61W7YyFGxgymgLSA9M55Qngq15W4YYQX4Vl40lC/nvZU4NOUEQKh592wL4fGIvE12H0ocMqZwUQLxm9BUdcDa1Vw7hAoYmcAytI0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820818; c=relaxed/simple;
	bh=ggUUSaZZQcCofyR7BBp/fsPQZooZrTSifTmmzhtzPYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntQWJJ/KkloVzixfQU41vW8MDIJN3TgEP+JTOv7oFkhRXdnvvE4K6yVEZdDEzRkPRLEh8iUjbeaJ1LoUbDT0as/hsf+TuVT1TguPLcMDUoi0bBQrmIYi2zWpwKtWwG/bImVecPe08+D903gygymdT2qz31s4ERFjyBq5uadsKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG0fM3x3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG0fM3x3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7BA1F000E9;
	Thu, 27 Aug 2026 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787820817;
	bh=uTzQa01wp23mjn8/3lUkKaTv9u00TDpwkGLS3/GoyBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TG0fM3x3KAQXYWUlCR+JwzrXafelALwPmSGlx2D5dVhfz3C/IBARUACSeFmUB+B8s
	 5FPQhkp6e8FRPqth2fHYQVQMvVHI/4qT9y3zkRZD15LDAaKrQgz4YfTaS/lXSdfjxG
	 /E6+VKV096Uv9YKLbJk0nDpGAbdtdGrPtq3Jd6o7j8FGjFhII7sArtnhwfOQiQE58A
	 oAaB+8fac/O5PB55+wRBZcxTBefL6w2WsgvnLBI1gIKcY+ApnccHA5wyQB9Ufb6QuT
	 0rKKxsrDj05ixwPikh37q2Sudk1Z6brgBOaFrtyZN043DIx8NpFb5+HKIaW1LG7JuK
	 TZLf6f7NsT6/g==
Date: Thu, 27 Aug 2026 09:53:32 +0100
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	baowen.zheng@corigine.com, louis.peens@corigine.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org
Subject: Re: [PATCH net 4/4] net/sched: act_mirred: account for
 TCA_MIRRED_BLOCKID in get_fill_size
Message-ID: <20260827085332.GC396647@horms.kernel.org>
References: <20260824153903.4143642-1-victor@mojatatu.com>
 <20260824153903.4143642-5-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824153903.4143642-5-victor@mojatatu.com>

On Mon, Aug 24, 2026 at 12:39:03PM -0300, Victor Nogueira wrote:
> tcf_mirred_get_fill_size() only budgets TCA_MIRRED_PARMS, but
> tcf_mirred_dump() also emits TCA_MIRRED_BLOCKID whenever the action was
> created with a block instead of a device. So tcf_mirred_get_fill_size is
> missing 8 bytes in its accounting.
> 
> Fix this issue by accounting for TCA_MIRRED_BLOCKID unconditionally:
> it costs 8 bytes for device-mirred actions and avoids having to read
> tcfm_blockid outside tcf_lock, where a concurrent replace could change
> it between sizing and dumping.
> 
> Note: Dumping mirred with blocks currently works in most use cases, but
> would break in some corner cases, for example, if there are 20 blockcast
> mirred actions in one request, each with a non-ANY hw_stats and a
> non-zero user flag, with a listener on RTNLGRP_TC (or NLM_F_ECHO):
> 
> budget 180 B/action -> attr_size = 20*180 + 24 = 3624
>                     -> alloc_skb(3776) = 3776, tailroom exactly 3776
> emitted 196 B/action -> 20*196 + 24 = 3944 > 3776
>                      -> tca_get_fill() fails
> 
> Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Hi Victor,

Although the issue flagged below by an AI-generated review of this patch[1]
may be strictly out of scope for this patchset I am pasting it here
because I see that quite some work is being undertaken to correct
get_fill_size issues and I wanted to be sure that this is considered
on the scope of that broader set of work.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor%40mojatatu.com

AI-generated review text:

  This is a pre-existing issue and not something this patch introduces, but
  while the audit is being done on get_fill_size callbacks, was act_gate
  looked at?  Its shortfall is unbounded rather than a fixed 8 bytes.

  net/sched/act_gate.c:tcf_gate_get_fill_size() {
	return nla_total_size(sizeof(struct tc_gate));
  }

  That is 24 bytes, while tcf_gate_dump() emits TCA_GATE_BASE_TIME,
  TCA_GATE_CYCLE_TIME and TCA_GATE_CYCLE_TIME_EXT via nla_put_u64_64bit(),
  plus TCA_GATE_CLOCKID, TCA_GATE_FLAGS, TCA_GATE_PRIORITY, TCA_GATE_TM and
  a per-entry nest:

  net/sched/act_gate.c:tcf_gate_dump() {
	...
	entry_list = nla_nest_start_noflag(skb, TCA_GATE_ENTRY_LIST);
	if (!entry_list)
		goto nla_put_failure;
	list_for_each_entry(entry, &p->entries, list) {
		if (dumping_entry(skb, entry) < 0)
			goto nla_put_failure;
	}
	...
  }

  Each TCA_GATE_ONE_ENTRY costs roughly 40 bytes, and parse_gate_list() puts
  no bound on the entry count:

  net/sched/act_gate.c:parse_gate_list() {
	nla_for_each_nested(n, list_attr, rem) {
		if (nla_type(n) != TCA_GATE_ONE_ENTRY) {
	...
  }

  So for one gate action the emitted dump is about 256 B plus 40 B per gate
  control list entry, against tcf_action_fill_size() returning 264 + 24 =
  288 B with an NLMSG_GOODSIZE floor of about 3776 B on x86_64.  Beyond
  roughly 88 entries, does tca_get_fill() start failing?

  If it does, two effects follow.  RTM_GETACTION on such an action returns
  -EINVAL unconditionally, since tcf_get_notify() builds the reply even with
  no listener.  And on RTM_NEWACTION with an RTNLGRP_TC listener or
  NLM_F_ECHO, the failure happens after the action is created:

  net/sched/act_api.c:tcf_action_add() {
	ret = tcf_add_notify(net, n, actions, portid, attr_size, extack);
	/* only put bound actions */
	tca_put_bound_many(actions, init_res);
	return ret;
  }

  leaving the gate action installed while userspace is told the command
  failed.  Would it make sense to mention act_gate in the series, or fix it
  in the same audit, so readers do not assume the sizing audit is complete?
