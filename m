Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594837F010
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155732; cv=none; b=PMl0yByQaz4RybGvGzX6G6N1+pmnivs8IOfOacNvo2cgTVtPCjG7VRNZZjiLbWiXCAIHzhjmkAgyU51ZcOow8oAiVIaLuCKjL3Ka6OlzeMpGStNgEQy8tttQYYw1iGTK+2kVbErJ9Il3XBiAbOAyUyy0WKEUGlYGjcvrCqxgT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155732; c=relaxed/simple;
	bh=FMLslxxgwr0bHfK4he4c1wYHj57ChzWRTxlIKuAv4ss=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdRF3KZHqBEt9czrPWoSzysn4muuxXYdm+u/bnOeIGSFDOI5q+ujIJqEONC5ziuEbUAYceHKjY73YnW4WlCiddh3lpF+G43PeoMNceIF0VPg5yOCWt4jdphs31pRnfI25HoogEGs2fUBedGSynVShysNtRmT8YEyKmaKmK+sbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIqViWZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIqViWZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FF61F000FF;
	Wed, 23 Sep 2026 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790155730;
	bh=OcSJyhQEgU1pfRvnvm4eLiugclJgvqsOQ+Wtlw1EopA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GIqViWZqE7ghZU0kWArBjpUPg6cs0Rq9eqJZBJU88ukYjKJ//epUw6kqTkVsvqHQ8
	 0XjHMQ+HGsNNLbDpLKlItqupC5A5T3SPyxhYEXR1QQDLj1y4NwIQu2yVOgTZyN9sib
	 2jkYkTSiPyRi8einUOFnWS8POtpMDKdzCdDO798qacul8tRmTU3zY3V+0vE5Ouzyrt
	 vxa5e4li1ve6eM//a+gVNLa+UhHX8Q/93/fnQp5AxjT3lx50qSE0+Q4bVBonkvtrPm
	 8DyNu9ePX2YG8JbXeqhxVIzJ9/7JP4s+pqkE1nbqcTM4p3X0L/Tav75vqsBbyqfJT8
	 v8p1+U6C14TCg==
Subject: Re: [PATCH net] net: flush skb_defer_nodes in dev_cpu_dead()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kris.pan@intel.com
Date: Wed, 23 Sep 2026 09:28:50 +0000
Message-ID: <179015573006.2160803.8476413815394184466@kernel.org>
In-Reply-To: <20260921182700.1796214-1-edumazet@google.com>
References: <20260921182700.1796214-1-edumazet@google.com>
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

Critical: 0 · High: 1 · Medium: 0 (3) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new WRITE_ONCE(oldsd->defer_ipi_scheduled, 0) in
  dev_cpu_dead() revokes CSD ownership that another task may still hold,…

Pre-existing issues:
- [Medium] Residual page_pool_destroy() stall with all CPUs online: skbs
  sitting in the skb_defer_node list of an *online* CPU below the…
- [Medium] __skb_defer_free_flush() returns early when the llist is empty
  and therefore never executes atomic_long_set(&sdn->defer_count, 0) -…
- [Medium] dev_cpu_dead() is extended to drain
  net_hotdata.skb_defer_nodes, but the neighbouring per-CPU skb queue…
- [Low] Documentation/admin-guide/sysctl/net.rst describes skb_defer_max
  as the 'Max size (in skbs) of the per-cpu list of skbs being freed by…

--

net: flush skb_defer_nodes in dev_cpu_dead()

This adds a drain of net_hotdata.skb_defer_nodes to dev_cpu_dead() so skbs
deferred to a CPU that goes offline are not stranded, extends that drain to
every CPU's slot for a NUMA node whose last CPU just went away, and resets
defer_ipi_scheduled when smp_call_function_single_async() fails.  It also
re-checks cpu_online(cpu) and the current CPU after llist_add() in
skb_attempt_defer_free().

Closes: https://lore.kernel.org/netdev/20260916003430.3612956-1-kris.pan@intel.com/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index c67900354fa64..c4151393cc819 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5376,7 +5376,8 @@ void kick_defer_list_purge(unsigned int cpu)
>  		backlog_unlock_irq_restore(sd, flags);
>  
>  	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
> -		smp_call_function_single_async(cpu, &sd->defer_csd);
> +		if (smp_call_function_single_async(cpu, &sd->defer_csd))
> +			WRITE_ONCE(sd->defer_ipi_scheduled, 0);
>  	}
>  }
>  
> @@ -6900,25 +6901,35 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
>  }
>  EXPORT_SYMBOL(napi_complete_done);
>  
> -static void skb_defer_free_flush(void)
> +static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
>  {
>  	struct llist_node *free_list;
>  	struct sk_buff *skb, *next;
> +
> +	if (llist_empty(&sdn->defer_list))
> +		return;
> +	atomic_long_set(&sdn->defer_count, 0);
> +	free_list = llist_del_all(&sdn->defer_list);

[Severity: Medium]
This isn't a bug introduced by this patch, but can the early return on an
empty list latch defer_count permanently above the limit?

The atomic_long_set(&sdn->defer_count, 0) here is the only reset of that
counter in the tree, and it is skipped when the list is empty.
skb_attempt_defer_free() increments before it tests, and does not decrement
on the bail-out path:

net/core/skbuff.c:skb_attempt_defer_free() {
	defer_count = atomic_long_inc_return(&sdn->defer_count);

	if (defer_count >= defer_max)
		goto nodefer;
}

Two ways to reach counter >= sysctl_skb_defer_max with an empty list:

 - an admin sets net.core.skb_defer_max to 1 (the sysctl has only
   SYSCTL_ZERO as a lower bound, and only the value 0 flips
   skb_defer_disable_key) and then restores 128, leaving the counter
   already above the restored limit;

 - a flusher delayed between atomic_long_set(0) and llist_del_all() lets
   producers push the counter up to defer_max while the following
   llist_del_all() captures all their skbs.

>From then on every deferral for that (cpu, node) slot increments and takes
the nodefer path, the list stays empty, and every flush - including the new
skb_defer_node_flush() calls in dev_cpu_dead() - returns immediately, so
the slot never recovers.  Would resetting defer_count unconditionally
before the llist_empty() check address that?

>  
> -		if (llist_empty(&sdn->defer_list))
> -			continue;
> -		atomic_long_set(&sdn->defer_count, 0);
> -		free_list = llist_del_all(&sdn->defer_list);
> -
> -		llist_for_each_entry_safe(skb, next, free_list, ll_node) {
> -			prefetch(next);
> -			napi_consume_skb(skb, 1);
> -		}
> +		__skb_defer_free_flush(sdn, 1);
>  	}
>  }
>  

[ ... ]

> @@ -12957,6 +12969,18 @@ static int dev_cpu_dead(unsigned int oldcpu)
>  		rps_input_queue_head_incr(oldsd);
>  	}
>  
> +	WRITE_ONCE(oldsd->defer_ipi_scheduled, 0);

[Severity: High]
Can this store revoke CSD ownership that another task still holds?

defer_ipi_scheduled acts as the ownership token for &sd->defer_csd: the
winner of the cmpxchg in kick_defer_list_purge() is the only task allowed
to submit that csd, which is what satisfies the serialization requirement
documented above smp_call_function_single_async() in kernel/smp.c.

kick_defer_list_purge() is reachable from preemptible process context:

tcp_recvmsg()
  tcp_eat_recv_skb()
    skb_attempt_defer_free()
      kick_defer_list_purge()

so a task can win the cmpxchg and be preempted before it ever enters
smp_call_function_single_async(), which only disables preemption
internally.  If oldcpu is offlined in that window, this WRITE_ONCE() clears
the token while that task still owns it.  After the CPU comes back online a
second task can win the cmpxchg, and both can then be inside
smp_call_function_single_async() for the same csd:

kernel/smp.c:smp_call_function_single_async() {
	if (csd->node.u_flags & CSD_FLAG_LOCK) {
		err = -EBUSY;
		goto out;
	}

	csd->node.u_flags = CSD_FLAG_LOCK;
}

That test-then-set is not atomic across CPUs, so both can pass it and both
call __smp_call_single_queue(), doing llist_add() twice with the same node.
The second adder can observe head->first == node and store
node->next = node, which is a self-loop in the target CPU's
call_single_queue and makes the traversal in
__flush_smp_call_function_queue() spin in hardirq context.

Is the store needed at all?  The new error handling added to
kick_defer_list_purge() in this patch already has the owner release the
token when submission is refused, and a csd that was successfully queued is
unlocked and executed by smpcfd_dying_cpu() at CPUHP_AP_SMPCFD_DYING, which
runs before CPUHP_NET_DEV_DEAD.  Would dropping this line be the simpler
fix?

> +	for_each_node(node)
> +		skb_defer_node_flush(per_cpu_ptr(net_hotdata.skb_defer_nodes,
> +						 oldcpu) + node);

[Severity: Medium]
This is a pre-existing gap rather than something this patch introduces, but
while dev_cpu_dead() is being extended to release per-CPU skb references,
should oldsd->xfrm_backlog be drained here too?

With CONFIG_XFRM_OFFLOAD the producer is strictly local:

net/xfrm/xfrm_device.c:xfrm_dev_resume() {
		sd = this_cpu_ptr(&softnet_data);
		skb_queue_tail(&sd->xfrm_backlog, skb);
		raise_softirq_irqoff(NET_TX_SOFTIRQ);
}

and the only consumer is xfrm_dev_backlog(sd) called from net_tx_action()
with sd = this_cpu_ptr(&softnet_data), so anything left on
oldsd->xfrm_backlog when the CPU dies stays pinned until that CPU is
brought back online, which is the same stranded-skb and page_pool-inflight
condition this patch targets.

The commit message says dev_cpu_dead() "drains its softnet queues
(completion_queue, output_queue, poll_list, process_queue, and
input_pkt_queue)" - is that list complete given xfrm_backlog is also a
softnet_data queue that is never drained there?

> +	node = cpu_to_node(oldcpu);
> +	if (node_possible(node) &&
> +	    !cpumask_intersects(cpumask_of_node(node), cpu_online_mask)) {
> +		for_each_possible_cpu(cpu)
> +			skb_defer_node_flush(per_cpu_ptr(net_hotdata.skb_defer_nodes,
> +							 cpu) + node);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 609f2c7f4a47a..14a9ee1344890 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -7379,7 +7380,7 @@ nodefer:	kfree_skb_napi_cache(skb);
>  	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
>  	DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
>  
> -	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + numa_node_id();
> +	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);

[Severity: Low]
This isn't a bug introduced here, but the new per-node flush loops make it
visible that the skb_defer_max documentation no longer matches the layout.

Documentation/admin-guide/sysctl/net.rst still describes it as:

	Max size (in skbs) of the per-cpu list of skbs being freed
	by the cpu which allocated them.

	Default: 128

net_dev_init() allocates nr_node_ids slots per CPU:

net/core/dev.c:net_dev_init() {
	net_hotdata.skb_defer_nodes =
		 __alloc_percpu(sizeof(struct skb_defer_node) * nr_node_ids,
}

and the limit is compared against the counter of the single node-indexed
slot selected above, so a target CPU can hold roughly
nr_node_ids * skb_defer_max skbs.  Should the documentation be updated to
say the limit is per (cpu, node) list?

>  
>  	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
>  	defer_count = atomic_long_inc_return(&sdn->defer_count);
> @@ -7389,6 +7390,11 @@ nodefer:	kfree_skb_napi_cache(skb);
>  
>  	llist_add(&skb->ll_node, &sdn->defer_list);
>  
> +	if (unlikely(!cpu_online(cpu) || my_cpu != raw_smp_processor_id())) {
> +		skb_defer_node_flush(sdn);
> +		return;
> +	}
> +
>  	/* Send an IPI every time queue reaches half capacity. */
>  	kick = (defer_count - 1) == (defer_max >> 1);

[Severity: Medium]
This is a pre-existing property of the deferral design rather than
something this patch adds, but does it also leave a page_pool_destroy()
stall reachable with all CPUs online?

This equality test is the only producer of an IPI kick, and
kick_defer_list_purge() has just this one caller.  Below the
(defer_max >> 1) edge nothing asks the owning CPU to flush, and the only
periodic drain is skb_defer_free_flush(), which runs solely on the owning
CPU from net_rx_action(), napi_threaded_poll() and the busy-poll path.

So if CPU A consumes a handful of skbs allocated by CPU B, no IPI is sent,
and CPU B then stays idle (no further NET_RX_SOFTIRQ), those skbs and any
page_pool fragments they hold are pinned for as long as B stays idle.  If
the NIC owning the pool is removed in that window,
page_pool_release_retry() keeps requeueing itself:

net/core/page_pool.c:page_pool_release_retry() {
	schedule_delayed_work(&pool->release_dw, DEFER_TIME);
}

with a warning every DEFER_WARN_INTERVAL and the pool never freed.  The new
dev_cpu_dead() drain covers the offline case described in the commit
message; is anything planned for the idle-but-online alloc_cpu case, for
instance kicking the defer lists from the page_pool teardown path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921182700.1796214-1-edumazet%40google.com
