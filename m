Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C7314A83;
	Sat,  5 Sep 2026 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638751; cv=none; b=UOxGoYhQowTb1l4P0QuqV27b2wfBE0C/qLdHpDSZ2wOfyZoSEhfswJoS3kIcNZcbIG5wMeqdTBbKS1n49jyZP7uEVFv+mJ7n9Lo5YShd55Qo6YLoOwlyQyoRU56xSga5QT/iMU9zH+ESRk6jsDsNptvq0ett5fK4IBZ2RL6LlL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638751; c=relaxed/simple;
	bh=74GoPoepf9uUWrJ7zE98kdJZeLGan5Qu2KH16saz6Yw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A3NocLkPbEShWwiKRrqj6CBZIFQBVSeoTzI3hHv+u9gAl4pQLdbjoOoD/dvKXq7c3dufHQPXiZFR1LXMq074zoq9nIGkqicMyrrqk5oJHKUNX3V8UdisCnk2qQywAXWnYdIDsV+7VANJD5GhAOYpPODSGZtiSQ1A10YGBeenqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW4h7/ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW4h7/ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEF31F00A3A;
	Sat,  5 Sep 2026 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638749;
	bh=eG+joLFXyi1YFshmvc0VaePPUpkxB8Vc/bsrxdq3FbY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fW4h7/zeLlh5qtkO70LNhTPEDtwursOHzD42/HYoQObX1/+eemUa+ubr9y9fxLGD9
	 zuHMmyezoBPU9kZ/vc1BBfq5SC4wxRKXWdyKOU5ArvxAzk6y0bS0aLxp/C/G1uk0Ds
	 ya0AZHtG61E9+7H21NNIH+4aPZJOKTPYfBasvh3B1iMFcTZ17MF8vrlb5n4/bSkf2B
	 fULcQl5pKB8OeCTCyfGOjnKdwlltovHLsEenZiN9q0dM4vxDX8w+K2kGiD6E59Fn2E
	 rJketOdHwGClQHUAcnRmYM0M/f/H/2+3yXunq3kUv0gERsisXI9KR1rndAEJMxxgCj
	 4u3xFtDbsghZA==
Subject: Re: [PATCH net-next v8] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
From: netdev-bot+sashiko@kernel.org
To: nashuiliang@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 sdf.kernel@gmail.com, liuhangbin@gmail.com, skhawaja@google.com,
 ncardwell@google.com, martin.lau@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 05 Sep 2026 20:05:48 +0000
Message-ID: <178863874807.219967.3784447414481415437@kernel.org>
In-Reply-To: <20260902025203.4741-1-nashuiliang@gmail.com>
References: <20260902025203.4741-1-nashuiliang@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] rps_llc_check() (net/core/dev.c:5275) makes its keep-or-update
  decision purely from the CPU field of the flow-table word, discarding…
- [Medium] sock_rps_record_flow() and sock_rps_record_flow_hash() are
  converted from static inlines in include/net/rps.h into out-of-line…
- [Low] The patch adds a permanent user-visible sysctl
  (net.core.rps_feat_llc_affinity, net/core/sysctl_net_core.c:558-564)…
- [Low] The patch contains changes that are dead or unrelated to the
  feature.

--

net: reduce RFS/ARFS flow updates by checking LLC affinity

This adds a new sysctl, net.core.rps_feat_llc_affinity, which makes
rps_record_sock_flow() skip the flow table update when the old and new
CPUs share a last level cache, in order to reduce ndo_rx_flow_steer
churn.  It also converts sock_rps_record_flow() and
sock_rps_record_flow_hash() from static inlines into exported
out-of-line functions.

A few questions below.

> diff --git a/include/net/rps.h b/include/net/rps.h
> index e33c6a2fa8bbc..6dacf0888a6c2 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h

[ ... ]

> @@ -55,11 +56,14 @@ struct rps_sock_flow_table {
>  
>  #define RPS_NO_CPU 0xffff
>  
> +bool rps_llc_check(u32 old_val, u32 new_val);
> +
>  static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
>  {
>  	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
>  	u32 val = hash & ~net_hotdata.rps_cpu_mask;
>  	struct rps_sock_flow_table *table;
> +	u32 old_val;
>  
>  	/* We only give a hint, preemption can change CPU under us */
>  	val |= raw_smp_processor_id();
> @@ -68,7 +72,8 @@ static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
>  	/* The following WRITE_ONCE() is paired with the READ_ONCE()
>  	 * here, and another one in get_rps_cpu().
>  	 */
> -	if (READ_ONCE(table[index].ent) != val)
> +	old_val = READ_ONCE(table[index].ent);
> +	if (old_val != val && rps_llc_check(old_val, val))
>  		WRITE_ONCE(table[index].ent, val);
>  }
>  
> @@ -136,25 +141,8 @@ static inline bool rfs_is_needed(void)
>  #endif
>  }
>  
> -static inline void sock_rps_record_flow_hash(__u32 hash)
> -{
> -#ifdef CONFIG_RPS
> -	if (!rfs_is_needed())
> -		return;
> -
> -	_sock_rps_record_flow_hash(hash);
> -#endif
> -}
> -
> -static inline void sock_rps_record_flow(const struct sock *sk)
> -{
> -#ifdef CONFIG_RPS
> -	if (!rfs_is_needed())
> -		return;
> -
> -	_sock_rps_record_flow(sk);
> -#endif
> -}
> +void sock_rps_record_flow_hash(__u32 hash);
> +void sock_rps_record_flow(const struct sock *sk);

[Severity: Medium]
These two helpers were static inline, so the rfs_is_needed() static
branch test was inlined into every caller: a patched-out jump label when
RFS is off, and nothing at all for CONFIG_RPS=n because the whole body
was inside #ifdef CONFIG_RPS.

After this change every call site on the socket fast path
(inet_send_prepare(), inet_recvmsg(), tcp_recvmsg(), af_inet6, mptcp,
sctp, tun, io_uring zcrx) emits an out-of-line call before the static
branch is evaluated, including CONFIG_RPS=n builds where the callee body
is empty.

The changelog says this "resolves a symbol visibility compilation error
triggered by 'tun' using sock_rps_record_flow_hash()".  Isn't the actual
undefined symbol the newly added rps_llc_check(), which is called from
the still-inline rps_record_sock_flow()?  Would EXPORT_SYMBOL() on
rps_llc_check(), or keeping the LLC test inline, be enough and leave
these helpers inlined?

Note also that rps_record_sock_flow() now calls rps_llc_check()
unconditionally, so the rps_feat_llc_affinity static branch is only
evaluated inside the callee, after the call overhead has been paid.

>  
>  static inline void sock_rps_delete_flow(const struct sock *sk)
>  {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 38336858c168f..b27839eb594d6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5052,6 +5052,8 @@ struct static_key_false rps_needed __read_mostly;
>  EXPORT_SYMBOL(rps_needed);
>  struct static_key_false rfs_needed __read_mostly;
>  EXPORT_SYMBOL(rfs_needed);
> +struct static_key_false rps_feat_llc_affinity __read_mostly;
> +EXPORT_SYMBOL(rps_feat_llc_affinity);

[Severity: Low]
Is this export needed?  A grep at this commit shows
rps_feat_llc_affinity referenced only by the extern in include/net/rps.h,
net/core/dev.c and net/core/sysctl_net_core.c, and since this patch moves
sock_rps_record_flow*() out of line, the chain
rps_record_sock_flow() -> rps_llc_check() is now reachable only from
built-in code.

Two small unrelated items in the same patch: the two multi-line comments
added in rps_llc_check() below start their text on the line after the
"/*", whereas the surrounding comments in net/core/dev.c (for example in
rps_flow_is_active() and get_rps_cpu()) start on the "/*" line; and the
hunk in net/core/sysctl_net_core.c adds a blank line before
"#endif /* CONFIG_RPS */" which is whitespace only.

>  
>  static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
>  {
> @@ -5263,6 +5265,48 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  	return cpu;
>  }
>  
> +/**
> + * rps_llc_check - determine if RPS flow table should be updated.
> + * @old_val: previous flow record value.
> + * @new_val: target flow record value.
> + *
> + * Return: true if the record needs an update, false otherwise.
> + */
> +bool rps_llc_check(u32 old_val, u32 new_val)
> +{
> +	u32 old_cpu = old_val & net_hotdata.rps_cpu_mask;
> +	u32 new_cpu = new_val & net_hotdata.rps_cpu_mask;

[Severity: High]
Both operands are reduced to a CPU number here, and the flow identity
bits of the table word are discarded.  Can this suppress the very first
record for a flow?

table[index].ent is a composite value, (hash & ~rps_cpu_mask) | cpu, and
every entry starts out as the RPS_NO_CPU sentinel:

net/core/sysctl_net_core.c:rps_sock_flow_sysctl()
			net_hotdata.rps_cpu_mask =
				roundup_pow_of_two(nr_cpu_ids) - 1;
			...
		for (i = 0; i < size; i++)
			sock_table[i].ent = RPS_NO_CPU;

With a power of two nr_cpu_ids (the 128*2 thread AMD host in the
changelog gives mask = 255), RPS_NO_CPU & mask == nr_cpu_ids - 1, which
is a valid and normally active CPU id, so the escape hatch below never
fires for an entry that was never recorded.

If the recording CPU happens to share an LLC with nr_cpu_ids - 1,
rps_llc_check() returns false and rps_record_sock_flow() skips the
WRITE_ONCE(), so this flow's hash tag is never published.  get_rps_cpu()
then rejects the entry:

		if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
			goto try_rps;

Doesn't that turn RFS/aRFS off entirely for every flow whose consumer
thread runs in the LLC containing the last CPU, rather than steering it
at LLC granularity?  The same applies when the slot is currently held by
a different flow that hashed to the same index, and it can recur at
runtime since _sock_rps_delete_flow() writes RPS_NO_CPU back on socket
teardown:

include/net/rps.h:_sock_rps_delete_flow()
		if (READ_ONCE(table[index].ent) != RPS_NO_CPU)
			WRITE_ONCE(table[index].ent, RPS_NO_CPU);

Would it be more accurate to apply the LLC heuristic only when the
existing record already belongs to this flow, that is when
((old_val ^ val) & ~net_hotdata.rps_cpu_mask) == 0, and always write when
the hash portion differs?

If so, does that also change the reported drop of mlx5e_rx_flow_steer
from ~335,000 to ~23,000 counts/sec, since part of it would come from
flows that lost steering rather than from flows steered per LLC?

> +
> +	/*
> +	 * RPS LLC Affinity Feature:
> +	 * Reduce RFS/ARFS flow updates by checking LLC affinity.
> +	 *
> +	 * Frequent flow table updates can trigger constant hardware steering
> +	 * reconfigurations (e.g., ndo_rx_flow_steer), leading to significant
> +	 * contention on driver internal locks (like mlx5's arfs_lock).
> +	 *
> +	 * This strategy only updates the flow record if it migrates across LLC
> +	 * boundaries. This minimizes expensive hardware updates while preserving
> +	 * cache locality for the application.
> +	 */
> +	if (static_branch_unlikely(&rps_feat_llc_affinity)) {
> +		/* Force update if the recorded CPU is invalid or has gone offline */
> +		if (old_cpu >= nr_cpu_ids || !cpu_active(old_cpu))
> +			return true;
> +
> +		/*
> +		 * If CPUs do not share a cache, allow the update to prevent
> +		 * expensive remote memory accesses and cache misses.
> +		 */
> +		if (!cpus_share_cache(old_cpu, new_cpu))
> +			return true;
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +

[ ... ]

> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index eb35da3556f4a..9b6702f5eab19 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c

[ ... ]

> @@ -554,6 +555,13 @@ static struct ctl_table net_core_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= rps_sock_flow_sysctl
>  	},
> +	{
> +		.procname	= "rps_feat_llc_affinity",
> +		.data		= &rps_feat_llc_affinity.key,
> +		.maxlen		= sizeof(rps_feat_llc_affinity.key),
> +		.mode		= 0644,
> +		.proc_handler	= proc_do_static_key
> +	},

[Severity: Low]
This adds a permanent user visible knob, but the patch touches no file
under Documentation/, and a grep for rps_feat_llc_affinity finds hits only
in include/net/rps.h, net/core/dev.c and net/core/sysctl_net_core.c.

Documentation/networking/scaling.rst, which documents
rps_sock_flow_entries and rps_flow_cnt, currently states:

  rps_sock_flow_table is a global flow table that contains the *desired*
  CPU for flows: the CPU that is currently processing the flow in
  userspace.  Each table value is a CPU index that is updated during
  calls to recvmsg and sendmsg

When the new knob is enabled, rps_llc_check() deliberately keeps a
different CPU in the entry as long as it shares an LLC, so that text no
longer describes the behaviour.  Could scaling.rst be updated with the
knob's default, accepted values and topology dependence?

Also, the rps_feat_ infix differs from the existing rps_* and rfs_*
sysctl names, and it cannot be changed once the ABI is exposed.  Was a
name like rps_llc_affinity considered?

>  #endif
>  #ifdef CONFIG_NET_FLOW_LIMIT
>  	{

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902025203.4741-1-nashuiliang%40gmail.com
