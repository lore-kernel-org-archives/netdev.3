Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC83DB64B;
	Tue, 13 Oct 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874824; cv=none; b=LdiGURFzTt7jGsOt7dnQY4AnnPE0G/7VTvmQYzZLZ2tzQUlQIjl0b4/vfTlRI4MeobgRPMfPeWWm/7M08DzFg1WKNI2JLnx6ronW8D9+J0tLWO05E37cC2wg/5YhGulMC/38bNywGbA0cBIF0ospQH3X0mTJKYoJ3L5tSf7SJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874824; c=relaxed/simple;
	bh=WQNkE8bnxdVoHwqoouuYPQm2kWDIeTFB/Qsc/jPAAS8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ec6F2rmMW3WatcqdZvRe/TF7WYaRiMOygIlq8ocRduEpZnLdPfwzsgY6ty/2TGpyY5BV5oc0qAc1qbpzlF4PqEYQ9DNYAYZTXgRUqU/q3eJquN2Nuvwl6gFp4q2b7qE/b+hC/QHs5E1r1iqfotdSnI4cIBi+QLrkFyRaUcOK5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6fVGy4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6fVGy4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C541F00893;
	Tue, 13 Oct 2026 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874821;
	bh=oitl4HmmFit32PrnFscNWpDFV9x3qChp/x9HvOJUmCo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U6fVGy4Gacb6DApxTRJH8EnyshDsgwHI/iTGQxF+ghGQRrmb8u0JwkEuh+Gham2CX
	 yHpJCzUabBk4qZB7xLkkurVFcSJFp7ZkrtYCxFWPZ1qBOvciZ0KYon/Cf/xppNIAk8
	 VPwXrcTOYNGsOBimHVFdvxLwwljBbxkXqmwnO4WTmtOKe9h6qUKNEYVYkEj87XSaTs
	 hCbIDXYhYINpE7L0+pU+HAQuEehSY+fBhlkT64QDj8sgFetFCWEqTcAcvZw6Lcm0pH
	 PjSkx7g5CmVbsJLkpTwqqL/6QaVtfPTTgeVqNr6JiMbpQIR/gGqj/Ni1MYkl4hpWvP
	 IJ38wSk05Uenw==
Subject: Re: [PATCH net-next v11] net: reduce ARFS flow updates by checking
 LLC affinity
From: netdev-bot+sashiko@kernel.org
To: nashuiliang@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, sdf.kernel@gmail.com,
 liuhangbin@gmail.com, skhawaja@google.com, ncardwell@google.com,
 roman.gushchin@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 07:00:20 +0000
Message-ID: <179187482010.434549.10175777615206996282@kernel.org>
In-Reply-To: <20261012060152.2930-1-nashuiliang@gmail.com>
References: <20261012060152.2930-1-nashuiliang@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new LLC skip in set_rps_cpu() (net/core/dev.c:5196-5199)
  assumes that `old_cpu` shows where the NIC currently delivers the flow.
- [Low] The new user-visible sysctl net.core.arfs_llc_affinity
  (net/core/sysctl_net_core.c:563-569) has no documentation.
- [Low] The config guards for the sysctl and its only user do not match.
- [Low] The commit message says the results "demonstrate that filtering
  updates by LLC affinity significantly reduces driver lock contention…
- [Low] In this tree, cpus_share_cache() (kernel/sched/core.c:4008-4014)
  returns `per_cpu(sd_llc_id, a) == per_cpu(sd_llc_id, b)`.

--

net: reduce ARFS flow updates by checking LLC affinity

This commit adds an opt-in sysctl, net.core.arfs_llc_affinity. When it is
set, set_rps_cpu() skips the ARFS hardware steering update
(ndo_rx_flow_steer) if the flow's previous RFS CPU and the new one share
an LLC. The rflow->cpu bookkeeping is still updated, so software RFS keeps
steering packets to the CPU the application runs on.

> These results demonstrate that filtering updates by LLC affinity
> significantly reduces driver lock contention and improves overall
> CPU efficiency under heavy network load.

[Severity: Low]

Does the data above support this claim? The only number given is the
mlx5e_rx_flow_steer() call rate, which drops from about 200k/s to about
10/s. There are no throughput, latency, CPU utilisation or lock
contention numbers.

The commit message also leaves out the trade-off. When the hardware
update is skipped, the flow stays on its old queue. get_rps_cpu() then
hands every packet to next_cpu with a remote enqueue_to_backlog() plus an
RPS IPI. After a completed ARFS steer, the packet would instead be
handled on the queue's own IRQ CPU.

The phrase "subsequent packets take the fast path in get_rps_cpu()
(tcpu == next_cpu)" could be read as local processing. The packets are
still moved to a remote CPU.

The opening paragraph names rps_record_sock_flow() as the motivation.
Since v10, though, the patch only changes set_rps_cpu() and get_rps_cpu().
Could that paragraph be reworded to match?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index a6951ea08961e..434ad5499906d 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -5179,6 +5180,24 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
>  		    !(dev->features & NETIF_F_NTUPLE))
>  			goto out;
> +
> +		/*
> +		 * ARFS LLC Affinity Feature:
> +		 * Reduce ARFS flow updates by checking LLC affinity.
> +		 *
> +		 * Frequent flow table updates can trigger constant hardware steering
> +		 * reconfigurations (e.g., ndo_rx_flow_steer), leading to significant
> +		 * contention on driver internal locks (like mlx5's arfs_lock).
> +		 *
> +		 * Skip the expensive hardware steering update if the flow's previous
> +		 * target CPU and the new one share the last level cache: cache locality
> +		 * for the application is preserved either way.
> +		 */
> +		if (static_branch_unlikely(&arfs_llc_affinity) &&
> +		    old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
> +			cpus_share_cache(old_cpu, next_cpu))
> +			goto out;

[Severity: Medium]

Is old_cpu a reliable sign of where the NIC currently delivers this flow?

get_rps_cpu() passes in tcpu = rflow->cpu. That value is read from the
hashed slot in the flow table of the queue the packet arrived on. It only
records the last software RFS target for that slot, and it may have no
hardware filter behind it. For example:

- ndo_rx_flow_steer() returned rc < 0, but set_rps_cpu() still did
  WRITE_ONCE(rflow->cpu, next_cpu) on the arrival queue's slot.
  mlx5e_rx_flow_steer() can return -EPROTONOSUPPORT, -ENOMEM, or -EPERM
  while MLX5E_ARFS_STATE_ENABLED is clear.

- The tmp_rflow collision check or the !q_tag_ptr check took goto out.

- The slot still holds a CPU left by an earlier flow that hashed to the
  same rfs_slot(). store_rps_dev_flow_table_cnt() sets RPS_NO_CPU only
  when the table is allocated.

- The driver flushed or re-created its filters.

In each of these cases, if old_cpu and next_cpu share an LLC, the new
check skips ndo_rx_flow_steer() and then reaches:

	WRITE_ONCE(rflow->cpu, next_cpu);

On later packets tcpu == next_cpu, so get_rps_cpu() never calls
set_rps_cpu() again. Hardware steering is not retried while the
application stays within that LLC. A new flow that lands on a stale slot
in the same LLC would never get an ARFS filter at all.

Before this patch, every CPU change triggered a new steering attempt, so
a failed or missing filter recovered on its own.

Without a filter, the flow stays on its RSS queue, which may be serviced
in another LLC or NUMA node. Every packet is then handed over by software
RFS. cpu_rmap_update() ranks queues by sibling, package and NUMA node,
not by LLC. Nothing guarantees an LLC relationship between the receiving
queue and old_cpu. Doesn't that contradict "cache locality for the
application is preserved either way"?

Could the skip be limited to the case where this flow has a live
hardware filter, for example rflow->filter != RPS_NO_FILTER &&
rflow->hash == hash? Another option would be to compare next_cpu with
the CPU that actually services the receiving queue, rather than with
rflow->cpu.

[Severity: Low]

Can cpus_share_cache() return true here for CPUs in different LLCs? In
this tree it is:

kernel/sched/core.c:cpus_share_cache() {
	if (this_cpu == that_cpu)
		return true;

	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
}

sd_llc_id defaults to -1. It is assigned only in build_sched_domains()
and reset to -1 by __sched_domains_free_llc_id().

sched_cpu_deactivate() calls sched_domains_free_llc_id(cpu) while the CPU
is still in cpu_online_mask. CPUs outside any sched domain, such as
isolcpus=domain CPUs, keep -1 permanently.

The new check guards old_cpu only with cpu_online(), and next_cpu only
with nr_cpu_ids. If both CPUs carry the -1 sentinel, they compare as
sharing an LLC and ndo_rx_flow_steer() is skipped. That could happen when
an application migrates between two isolated CPUs in different LLCs, or
during a hotplug window.

The sentinel handling belongs to the scheduler, but should this new
networking user guard against it?

> +
>  		rxq_index = cpu_rmap_lookup_index(dev->rx_cpu_rmap, next_cpu);
>  		if (rxq_index == skb_get_rx_queue(skb))
>  			goto out;

[ ... ]

> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 473c162736d69..9ce0bbe454c83 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -560,6 +560,13 @@ static struct ctl_table net_core_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= rps_sock_flow_sysctl
>  	},
> +	{
> +		.procname	= "arfs_llc_affinity",
> +		.data		= &arfs_llc_affinity.key,
> +		.maxlen		= sizeof(arfs_llc_affinity.key),
> +		.mode		= 0644,
> +		.proc_handler	= proc_do_static_key
> +	},
>  #endif

[Severity: Low]

Should this entry, and the arfs_llc_affinity definition in
net/core/dev.c, be under CONFIG_RFS_ACCEL instead of CONFIG_RPS?

The only reader, static_branch_unlikely(&arfs_llc_affinity) in
set_rps_cpu(), sits inside #ifdef CONFIG_RFS_ACCEL. RFS_ACCEL can be
turned off on its own ("depends on RPS" in net/Kconfig).

On CONFIG_RPS=y, CONFIG_RFS_ACCEL=n kernels,
/proc/sys/net/core/arfs_llc_affinity is still registered and accepts
writes that flip the key, but nothing changes.

[Severity: Low]

This isn't a bug, but net.core.arfs_llc_affinity isn't documented in
Documentation/admin-guide/sysctl/net.rst. That file covers other
net.core knobs, such as rps_default_mask and high_order_alloc_disable.

The Accelerated RFS section of Documentation/networking/scaling.rst also
still says:

  The network stack automatically calls this function every time a flow
  entry in rps_dev_flow_table is updated.

With the knob enabled, set_rps_cpu() now updates rflow->cpu and
rflow->last_qtail without calling ndo_rx_flow_steer() whenever the two
CPUs share an LLC.

Could the documentation describe the new knob, its default (0) and
accepted values, and this exception in scaling.rst?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012060152.2930-1-nashuiliang%40gmail.com
