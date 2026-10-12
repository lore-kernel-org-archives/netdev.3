Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9549381EBD;
	Mon, 12 Oct 2026 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813285; cv=none; b=GZpwVSpforXWSepMvsgK/ZyMTn3VmBQ96lqjSxpo1qmuMtXM2Uh8Mhe0/w19QccA1ytjPqp/ZYq5Bgv1KrIk8SAUHB4YhedDEOrvWgd4YsfLA6diutJj42mRN0C50+lCm/vm6z3YQAPVCmgNmB/bDSgy6dAi7uLD4OLAHS50yF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813285; c=relaxed/simple;
	bh=qsHhbyHd5ClEZ7oMoiJT8a3BMLWB+4J+MzNBY5jNaxk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MU9bRexAq9zCC9GBO1gUPcmO0H9ggMRfnyxrQCHViPClJtaU4maMNPdRXJcjU7DAXpG52CkVeURX2rdr4//oKbeeFFRCBaUZDa2+HwnrCV1ZYFtmdtCA0VZxmd20yExma78DHUcP0rxgPUNuLtEy3oceJneACyC6Zwtai2zISZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOwMkcw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOwMkcw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F891F0089B;
	Mon, 12 Oct 2026 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791813283;
	bh=M6rLpFajnX3vFtlMbngZuiF+uDlviL+v1lN0wEQgdBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nOwMkcw6PDNOfrrtjGI6MTQmJuxwp5Um/OuL1fOic+KDGDhmEn+izpINDX/nMMdDM
	 HNS1FQTKJya3tx4GSZPfrqSo2y+q2jepYAzfhbZqUxWig5u3W8OjfGiz0Rm4/KvN6x
	 BwsBDDrkkX74FUOk/nIeWJwhuriYgNWbYC0rkvoNFptWfy+mbsyWUscr6IY18XLaSL
	 SRma88aCRiUY5xAcZFZrSGwHhfxb8Nto6ZJxfrLtq/7jdsgM7DgugN8u7MJz0uIuXJ
	 HWKym0aHKFRgAohiA/8Zn30LU+3Y5Tmh6gvbF8uRDkwEKAceLx+r1ikntUatLoOkI2
	 AS8SC28X30cBQ==
Subject: Re: [PATCH net-next v10] net: reduce ARFS flow updates by checking
 LLC affinity
From: netdev-bot+sashiko@kernel.org
To: nashuiliang@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, sdf.kernel@gmail.com,
 liuhangbin@gmail.com, skhawaja@google.com, ncardwell@google.com,
 roman.gushchin@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 13:54:42 +0000
Message-ID: <179181328227.434549.4613846834686834625@kernel.org>
In-Reply-To: <20261008133252.3750-1-nashuiliang@gmail.com>
References: <20261008133252.3750-1-nashuiliang@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the new LLC shortcut in set_rps_cpu()
  (net/core/dev.c:5196-5199) fires, it skips ndo_rx_flow_steer().
- [Medium] The new check in set_rps_cpu() relies on
  cpus_share_cache(old_cpu, next_cpu), which in this tree compares raw…
- [Low] The new comment in set_rps_cpu() says 'Reduce RFS/ARFS flow
  updates by checking LLC affinity' and 'This strategy only updates the…
- [Low] The patch adds a user-visible sysctl,
  /proc/sys/net/core/rps_feat_llc_affinity (net_core_table,…
- [Low] The aRFS section of Documentation/networking/scaling.rst (lines
  443-448) says the stack 'automatically calls this function…
- [Low] The rps_feat_llc_affinity static key (dev.c:5125) and its sysctl
  (sysctl_net_core.c:563-569) are built under CONFIG_RPS.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but writing 1 to
  /sys/class/net/<dev>/queues/rx-N/rps_flow_cnt gives a flow table whose…

--

net: reduce ARFS flow updates by checking LLC affinity

With this commit, set_rps_cpu() skips the ndo_rx_flow_steer() call when
the flow's previous target CPU and the new one share an LLC. rflow->cpu
is still updated in that case. A new sysctl,
net.core.rps_feat_llc_affinity, backed by a static key and off by
default, turns the behaviour on.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f587645e930a1..8b046100525a4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5122,6 +5122,7 @@ struct static_key_false rps_needed __read_mostly;
>  EXPORT_SYMBOL(rps_needed);
>  struct static_key_false rfs_needed __read_mostly;
>  EXPORT_SYMBOL(rfs_needed);
> +struct static_key_false rps_feat_llc_affinity __read_mostly;
>
>  static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
>  {

[Severity: High]
This regression wasn't introduced by this patch, but can rfs_slot()
return an index past the end of a one-entry flow table?

Writing 1 to /sys/class/net/<dev>/queues/rx-N/rps_flow_cnt gives
mask = 0 in store_rps_dev_flow_table_cnt(). The runtime ilog2(0) is -1,
so the encoded log becomes 0:

    tag_ptr |= (ilog2(mask) + 1);

rfs_slot() then calls hash_32(hash, 0), which does:

    return __hash_32(val) >> (32 - bits);

Shifting a u32 by 32 is undefined. On x86-64 and arm64 the shift count
is masked, so the full 32-bit hash product comes back instead of 0.

get_rps_cpu() uses that value directly:

    rflow = flow_table + flow_id;

set_rps_cpu() later writes through the same pointer with
WRITE_ONCE(rflow->cpu, next_cpu) and the last_qtail update. On the aRFS
path it also writes to the target queue's tmp_rflow.

rps_may_expire_flow() checks flow_id against 1UL << log, but
get_rps_cpu() and set_rps_cpu() don't.

Could this cause out-of-bounds reads and writes in NET_RX softirq? That
would need CAP_NET_ADMIN to configure such a table and
rps_sock_flow_entries to be set. It looks like this goes back to commit
a435163d3100b0.

[ ... ]

> @@ -5179,6 +5180,24 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
>  		    !(dev->features & NETIF_F_NTUPLE))
>  			goto out;
> +
> +		/*
> +		 * RPS LLC Affinity Feature:
> +		 * Reduce RFS/ARFS flow updates by checking LLC affinity.
> +		 *
> +		 * Frequent flow table updates can trigger constant hardware steering
> +		 * reconfigurations (e.g., ndo_rx_flow_steer), leading to significant
> +		 * contention on driver internal locks (like mlx5's arfs_lock).
> +		 *
> +		 * This strategy only updates the flow record if it migrates across LLC
> +		 * boundaries. This minimizes expensive hardware updates while
> +		 * preserving cache locality for the application.
> +		 */

[Severity: Low]
This isn't a bug, but does this comment still match the code now that
the check lives in set_rps_cpu()? After goto out, the code still runs:

    head = READ_ONCE(per_cpu(softnet_data, next_cpu).input_queue_head);
    rps_input_queue_tail_save(&rflow->last_qtail, head);
    ...
    WRITE_ONCE(rflow->cpu, next_cpu);

So the flow record is updated every time, and only the
ndo_rx_flow_steer() call is skipped. The commit message agrees: "The
per-queue flow bookkeeping (rflow->cpu) is still updated".

The comment looks left over from v9, where the check was in
rps_record_sock_flow().

> +		if (static_branch_unlikely(&rps_feat_llc_affinity) &&
> +		    old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
> +			cpus_share_cache(old_cpu, next_cpu))
> +			goto out;

[Severity: Medium]
Does old_cpu reliably show where the hardware is delivering this flow
right now?

old_cpu is the tcpu that get_rps_cpu() reads from rflow->cpu in the
arrival queue's software table. set_rps_cpu() writes next_cpu into
rflow->cpu on every goto out path, including paths that never install a
hardware filter. One is a driver failure:

    rc = dev->netdev_ops->ndo_rx_flow_steer(dev, skb,
                                            rxq_index, flow_id);
    if (rc < 0)
        goto out;

For example, mlx5e_rx_flow_steer() returns -EPERM when ARFS is disabled
and -ENOMEM when the GFP_ATOMIC allocation fails. Another is the
collision skip:

    if (hash != READ_ONCE(tmp_rflow->hash) ||
        next_cpu == tmp_cpu)
        goto out;

Hash slots are also shared between flows and never reset, so the
arrival queue's slot can hold a stale or colliding CPU.

Here is an example. Flow F arrives by RSS on queue R, whose IRQ CPU is
in LLC A. The application runs on CPU Y in LLC B, and the earlier steer
to Y failed or collided. When the application moves to CPU Z, also in
LLC B:

get_rps_cpu()
  set_rps_cpu(dev, skb, rflow, Y, Z, hash)
    cpus_share_cache(Y, Z) is true
    goto out
  rflow->cpu = Z

>From then on tcpu == next_cpu, so set_rps_cpu() is not called again for
this flow. Any later move inside LLC B takes the same shortcut.

Could F stay on the remote queue R indefinitely, with every packet
crossing LLCs through an RPS backlog enqueue and an IPI? Before this
patch, every CPU change retried ndo_rx_flow_steer().

The commit message says "cache locality for the application is
preserved either way". That seems to hold only when the hardware
already delivers to old_cpu's LLC, and nothing here checks that.

Would it be better to compare next_cpu with the CPU that services the
arrival queue (smp_processor_id() on this path, or the rmap CPU for
skb_get_rx_queue())? Another option is to skip only when a filter is
known to be installed.

[Severity: Medium]
How does this check behave for CPUs that have no sched domain?

cpus_share_cache() compares the raw sd_llc_id values:

    return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);

sd_llc_id defaults to -1. It is only assigned for CPUs in the map
passed to build_sched_domains(), and sched_init_domains() masks that
map with housekeeping_cpumask(HK_TYPE_DOMAIN). CPUs isolated with
isolcpus=domain therefore keep -1.

sched_cpu_deactivate() also resets sd_llc_id to -1, through
sched_domains_free_llc_id() -> __sched_domains_free_llc_id(), while
the CPU is still cpu_online().

If so, any two isolated CPUs compare as sharing an LLC, even when they
are on different sockets. With rps_feat_llc_affinity enabled, a flow
whose consumer moves between isolated CPUs on different LLCs would skip
ndo_rx_flow_steer() and record rflow->cpu = next_cpu. Wouldn't that
flow then never be re-steered?

A short-lived version of this looks possible during hotplug. A
deactivating old_cpu (still online, sd_llc_id == -1) could be compared
with an isolated or offline next_cpu. Nothing here checks whether
next_cpu is online.

[Severity: Low]
Should Documentation/networking/scaling.rst be updated as well? Its
Accelerated RFS section says the stack "automatically calls this
function every time a flow entry in rps_dev_flow_table is updated".

With rps_feat_llc_affinity enabled, set_rps_cpu() updates the entry
(last_qtail and cpu) but skips ndo_rx_flow_steer() when old_cpu and
next_cpu share an LLC. The hardware filter then keeps pointing at the
old queue, and software RFS forwards packets to next_cpu.

[ ... ]

> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 473c162736d69..6043ccb52cffa 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -560,6 +560,13 @@ static struct ctl_table net_core_table[] = {
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
>  #endif

[Severity: Low]
Should this new sysctl get an entry in
Documentation/admin-guide/sysctl/net.rst? high_order_alloc_disable,
another proc_do_static_key knob in this table, is documented there.
rps_sock_flow_entries is covered in Documentation/networking/scaling.rst.
rps_feat_llc_affinity has no entry anywhere under Documentation/.

The name also suggests it affects plain RPS. In fact it only takes
effect on the aRFS path, when skb_rx_queue_recorded(), dev->rx_cpu_rmap
and NETIF_F_NTUPLE are all set. Could the documentation say this, and
also give the default (off) and the accepted values (0/1)?

[Severity: Low]
This entry and the rps_feat_llc_affinity key are built under
CONFIG_RPS. The key's only reader is in set_rps_cpu(), inside
#ifdef CONFIG_RFS_ACCEL, and RFS_ACCEL can be turned off on its own:

    config RFS_ACCEL
        bool "Hardware acceleration of RFS"
        depends on RPS

On a kernel with RPS=y and RFS_ACCEL=n, won't this sysctl accept writes
and toggle a static key that nothing reads? The new old_cpu argument to
set_rps_cpu() is also unused in that configuration.

Would it make sense to put the key and this sysctl entry under
CONFIG_RFS_ACCEL?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008133252.3750-1-nashuiliang%40gmail.com
