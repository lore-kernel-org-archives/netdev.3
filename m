Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5343FD0B;
	Thu,  6 Aug 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014679; cv=none; b=No/xq0sH/iYsX8hIsPoVkI0bSFaDXua2fvRmUGp+T9oEholxo3jvSxUfWIyE2OP2ZU/bWlyxmu3fye7kqQytghTVelMKIZiOKSYmCrNkWr4xXgwfLwiAXqtfP+42DGsE9sp7Aoew4TWWIeXAu442iTCzO5cQNvRkiUEzIoeK3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014679; c=relaxed/simple;
	bh=jM7QhXtGyphW9uInFqnd6yXmuv6fIvWUUj7d9YIJDSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgEBZkJKfNcUE9PW7BHu5lV6qEEqifUzNt+5TWCqDeercxfrXomB/gvpj5R0jOvKxxmfHMVhDFerJF3TZRrOllOSj5L8E8sO8ps7t4VR7DK5zOywDz9YwhOnIdOvyY3nOGG4cBHlVagoIsNrPpaJTL92Dge/XnUdMWGv5BZGJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3cYvQYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3cYvQYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EB71F00A3A;
	Thu,  6 Aug 2026 11:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786014670;
	bh=YEM6tuzrrV+758mV8ftM+RCEoNJEyN7le8XFuhHw68I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3cYvQYHTOOqPIn86WXNCyIlmOctSA9gbLhP7G8E0zbxBZxTBfAifvQYHEm5pwoZx
	 FIMbM7irG+Bjzpph7Itm4j4JDdkFN5rpRsv/+Plcp7dRjSKYrFkXASXkyWWawjg9Vy
	 pjkgmiIkkHxqTo6cu1UE9qFBfZPWgsm72zajQF/nJKL9ojsCNrRu1QEE1gWMv1DSpS
	 7yeGWt1+Ry6rPSTcqVurunYXhW03UW1Zu+nfjHHdS+AuLv5x48zJdx9Ll2S9T3xnDe
	 q1+4/GCuVtfQUi6ar6zFFSg5+k47P3NUxyOFxA29bZKeUvBYYT4XKTGkrB4hM7hl16
	 ZXkt9BmrBMMgQ==
From: Simon Horman <horms@kernel.org>
To: nashuiliang@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	willemb@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	skhawaja@google.com,
	sdf.kernel@gmail.com,
	ncardwell@google.com,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Thu,  6 Aug 2026 12:10:54 +0100
Message-ID: <20260806111054.648657-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804024053.765-1-nashuiliang@gmail.com>
References: <20260804024053.765-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804024053.765-1-nashuiliang@gmail.com?part=1
---
--- Patch [1]: [PATCH net-next v7] net: reduce RFS/ARFS flow updates by checking LLC affinity ---
commit a4fc10ca836e4630c08de840b94b9f47a375f4d6
Author: Chuang Wang <nashuiliang@gmail.com>

net: reduce RFS/ARFS flow updates by checking LLC affinity

This patch makes rps_record_sock_flow() skip the flow table update when the
new CPU shares an LLC with the previously recorded one, gated by a new
sysctl net.core.rps_feat_llc_affinity. It also converts
sock_rps_record_flow_hash() and sock_rps_record_flow() from static inlines
into exported out-of-line functions.

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

[Severity: Medium]
[Finding: main-2-4]
[Sources: opus-5]
Should the skip decision also require that old_val belongs to the same
flow?  The slot index here is only a masked hash:

	unsigned int index = hash & rps_tag_to_mask(tag_ptr);

so distinct flows share slots.  get_rps_cpu() re-validates the stored hash
bits for exactly that reason:

	ident = READ_ONCE(sock_flow_table[flow_id].ent);
	if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
		goto try_rps;

With the CPU extraction fixed (see the comment on rps_llc_check() below),
if flow A owns the slot with (hashA, cpu3) and flow B then records from a
CPU sharing an LLC with cpu3, rps_llc_check() returns false, the slot keeps
hashA, and every packet of B fails the hash test in get_rps_cpu() and falls
back to plain RPS.  Flow B can then never install its own entry.

The same applies to the sentinel.  rps_sock_flow_sysctl() initializes every
entry:

	for (i = 0; i < size; i++)
		sock_table[i].ent = RPS_NO_CPU;

and _sock_rps_delete_flow() writes RPS_NO_CPU back on teardown.  With the
intended mask, RPS_NO_CPU & rps_cpu_mask decodes to nr_cpu_ids - 1 on
power-of-two CPU counts, which is a valid and usually active CPU, so the
first record for a flow can be suppressed and the slot can stay at
RPS_NO_CPU.

Would something like this before the CPU comparison be more correct?

	if ((old_val ^ new_val) & ~net_hotdata.rps_cpu_mask)
		return true;

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
[Finding: main-1-1]
[Sources: opus-5]
The changelog says:

  "Additionally, export sock_rps_record_flow_hash() and
  sock_rps_record_flow(). This resolves a symbol visibility compilation
  error triggered by 'tun' using sock_rps_record_flow_hash() in
  tun_flow_update() when CONFIG_TUN is built as a module."

Is that error pre-existing?  Before this patch both helpers were static
inline in include/net/rps.h, so tun.ko and sctp.ko referenced no external
symbol.  The undefined-symbol reports quoted in the v4/v5 notes look like
they come from this patch adding a call to the non-exported rps_llc_check()
inside the inline rps_record_sock_flow().

Should the changelog say that instead?

Also, does turning these into out-of-line calls change the RFS fast path?
The rfs_is_needed() static-key test previously compiled to a nop at each
call site (tcp_recvmsg, tcp_sendmsg, inet_accept, sctp, tun), and on
CONFIG_RPS=n the whole thing compiled away.  Now every call site performs a
real call, including on CONFIG_RPS=n where the new definitions sit after
"#endif /* CONFIG_RPS */" with empty bodies.  An alternative would be to
keep the inlines and export rps_llc_check() only.

>  
>  static inline void sock_rps_delete_flow(const struct sock *sk)
>  {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c1c1be1a6962f..ab74616f95892 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -5218,6 +5220,55 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
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
> +	u32 old_cpu = old_val & ~net_hotdata.rps_cpu_mask;
> +	u32 new_cpu = new_val & ~net_hotdata.rps_cpu_mask;

[Severity: Critical]
[Finding: main-1-0]
[Sources: opus-5]
Is the mask polarity inverted here?  The entry format comment in
include/net/rps.h says the upper part holds the high-order hash bits and
the lower part holds the CPU number, and both the producer and the existing
consumer agree with that:

rps_record_sock_flow():
	u32 val = hash & ~net_hotdata.rps_cpu_mask;
	val |= raw_smp_processor_id();

get_rps_cpu():
	if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
		goto try_rps;
	next_cpu = ident & net_hotdata.rps_cpu_mask;

So old_cpu and new_cpu as computed above are flow hash bits, not CPU ids.
Two consequences seem to follow.

First, hash & ~rps_cpu_mask is either 0 or a multiple of rps_cpu_mask + 1,
which equals roundup_pow_of_two(nr_cpu_ids), so the first guard

	if (old_cpu >= nr_cpu_ids || !cpu_active(old_cpu))
		return true;

is true for every non-zero value and rps_llc_check() returns true
unconditionally.  Does the LLC filtering ever run?  If it does not, where
does the ~93% reduction in mlx5e_rx_flow_steer reported in the changelog
come from?

Second, in the remaining case where the stored hash bits happen to be zero
(recorded hash smaller than roundup_pow_of_two(nr_cpu_ids)), old_cpu is 0,
which is active and normally present in current->cpus_ptr, so the code
reaches cpus_share_cache(old_cpu, new_cpu) with new_cpu being an arbitrary
hash-derived value that is never range checked:

kernel/sched/core.c:cpus_share_cache() {
	if (this_cpu == that_cpu)
		return true;

	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
}

Can this index __per_cpu_offset[] out of bounds and dereference the
resulting address?  The hashes come from remote 4-tuples and this runs on
the socket receive/transmit path.

Would using val & net_hotdata.rps_cpu_mask for both extractions, plus a
new_cpu < nr_cpu_ids check before cpus_share_cache(), be the intended
logic?

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
> +		 * Force an update if the current task is no longer permitted
> +		 * to run on the old_cpu.
> +		 */
> +		if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
> +			return true;

[Severity: Medium]
[Finding: main-5-11]
[Sources: opus-5]
Is current the task that owns this flow?  tun_flow_update() calls
sock_rps_record_flow_hash(e->rps_rxhash) and its callers are tun_get_user()
and tun_xdp_one(), so current there is the tun or vhost writer thread, not
the application that will recvmsg() the flow.  The affinity of that
unrelated task does not say where the consumer runs.

Also, p->cpus_ptr is not always &p->cpus_mask:

kernel/sched/core.c:set_cpus_allowed_common() {
	if (ctx->flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
		p->cpus_ptr = ctx->new_mask;
		return;
	}
	...
}

Inside a migrate_disable() region (including PREEMPT_RT spin_lock
sections), cpus_ptr is cpumask_of(rq->cpu), so this test is false for every
old_cpu other than the current one and rps_llc_check() degenerates to
"always update".  The mask is also read with no serialization against a
concurrent sched_setaffinity() or cpuset change.

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
>  #ifdef CONFIG_RFS_ACCEL
>  
>  /**

[ ... ]

> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index b508618bfc123..b6d4ebcbb6a68 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -210,6 +210,33 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
>  	kvfree_rcu_mightsleep(tofree);
>  	return ret;
>  }
> +
> +static int rps_feat_llc_affinity_sysctl(const struct ctl_table *table, int write,
> +					void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	u8 curr_state;
> +	int ret;
> +	const struct ctl_table tmp = {
> +		.data = &curr_state,
> +		.maxlen = sizeof(curr_state),
> +		.mode = table->mode,
> +		.extra1 = table->extra1,
> +		.extra2 = table->extra2
> +	};
> +
> +	curr_state = static_branch_unlikely(&rps_feat_llc_affinity) ? 1 : 0;
> +
> +	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
> +	if (write && ret == 0) {
> +		if (curr_state && !static_branch_unlikely(&rps_feat_llc_affinity))
> +			static_branch_enable(&rps_feat_llc_affinity);
> +		else if (!curr_state && static_branch_unlikely(&rps_feat_llc_affinity))
> +			static_branch_disable(&rps_feat_llc_affinity);
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
[Finding: main-5-9]
[Sources: opus-5]
Can two concurrent writers to this file race?  The snapshot, the parse and
the toggle are done with no serialization, while the in-tree helper for the
same job takes a mutex:

kernel/sysctl.c:proc_do_static_key() {
	static DEFINE_MUTEX(static_key_mutex);
	...
	mutex_lock(&static_key_mutex);
	val = static_key_enabled(key);
	ret = proc_dointvec_minmax(&tmp, dir, buffer, lenp, ppos);
	...
	mutex_unlock(&static_key_mutex);
}

If CPU0 is inside static_key_enable_cpuslocked():

	if (atomic_read(&key->enabled) == 0) {
		atomic_set(&key->enabled, -1);
		jump_label_update(key);
		atomic_set_release(&key->enabled, 1);
	}

then CPU1 entering static_key_disable_cpuslocked() reads the transient -1
before taking jump_label_lock():

	if (atomic_read(&key->enabled) != 1) {
		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
		return;
	}

which warns and drops the disable request, leaving the key in the state the
administrator did not ask for.  Would reusing proc_do_static_key() be
simpler here?  It also enforces the CAP_SYS_ADMIN check that this handler
omits.

The "if (curr_state && !static_branch_unlikely(...))" pre-checks look
redundant since enable and disable are idempotent, and they only widen the
window.

> +
>  #endif /* CONFIG_RPS */
>  
>  #ifdef CONFIG_NET_FLOW_LIMIT
> @@ -554,6 +581,14 @@ static struct ctl_table net_core_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= rps_sock_flow_sysctl
>  	},
> +	{
> +		.procname   = "rps_feat_llc_affinity",
> +		.maxlen     = sizeof(u8),
> +		.mode       = 0644,
> +		.proc_handler   = rps_feat_llc_affinity_sysctl,
> +		.extra1     = SYSCTL_ZERO,
> +		.extra2     = SYSCTL_ONE
> +	},

[Severity: Low]
[Finding: main-1-2]
[Sources: opus-5]
Could this new sysctl get a documentation entry?  Neither the tunable list
in the RFS Configuration section of Documentation/networking/scaling.rst nor
Documentation/admin-guide/sysctl/net.rst mentions rps_feat_llc_affinity, its
semantics or its default.

The same file also states:

  "rps_sock_flow_table is a global flow table that contains the *desired*
  CPU for flows: the CPU that is currently processing the flow in
  userspace.  Each table value is a CPU index that is updated during calls
  to recvmsg and sendmsg (specifically, inet_recvmsg(), inet_sendmsg() and
  tcp_splice_read())."

With the feature enabled the entry is deliberately left stale whenever
rps_llc_check() returns false, so that description no longer holds.  Should
it be updated in the same patch?

>  #endif
>  #ifdef CONFIG_NET_FLOW_LIMIT
>  	{
