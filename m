Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB01C8604;
	Sun, 20 Sep 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866111; cv=none; b=XeuCINAaayOiL/1SMI+9r5tXlYMSvYhZbHtBon5svQ2ZT4H3ZsJBNCNT0+CDWIu24S74bJwZ685DOb2hEHiM6NA/U7fczKIoOq6A6yWp4d0U8/IQMIrSFsYDY0Fx2BQ0vPnGnzKKL/F8YIJufb/oMZWTqX/9gEMRJn8tA+Y82xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866111; c=relaxed/simple;
	bh=mBqso6p9jXaIadDJjxNGRcjzykNgmLSnbRHoLltejyw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1ro2QpqdvO7kkVNZezSU8qIFJu4h9QLpj7vLEhQBSOmKc8FFYDiFRVdVmogYS34SQc0PXXXZ8nSHax7PKqX8WdffeCl1bGqNn6BpPLYjSmutSagDVrce05FES8GlP9qR2jjFTaIqoJouc80YFcAn4CpxffrcHhPgcFBf+ZgGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOMMl7iX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOMMl7iX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0861F000FF;
	Sun, 20 Sep 2026 01:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789866109;
	bh=2GcTJKx+ekMWd5ofFW6bC8RsA5w08X8k/45sHNl/H1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SOMMl7iXfGuDeFIavjZuKiXvKQRmDeRk81DolkorOvs4Ma0YkBHte9OtmyfHtPeEz
	 gp8wtru0P3dgbk6rpc+PekYBo6Zy5qVQYp3OEZNnBuVmzDPfWn2520f2LkaK0Tuia1
	 1UjhXFmK/QOOkVUS77ZcRDwf1BFlCm0e/rbDxzCLGSJFU1EIkSCJ2zRgx5T3aMV3+q
	 R0qi2+yUdEzfhZeiUwfvgTnf5o8BimFKRo6uRFMgdajhQon78J14/0k9qEo0HGsd//
	 u4J067/cmRnlNlpliTlqlAPrrC0T38nx9SB5Yiinq4BQBxLz6F+iV2zFIneHhUEXBQ
	 9I/lGTHuEu/Ag==
Subject:
 Re: [PATCH net v3] net: iterate online nodes in skb_defer_free_flush()
From: netdev-bot+sashiko@kernel.org
To: kris.pan@intel.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, atomasov@redhat.com,
 oliver.sang@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 01:01:48 +0000
Message-ID: <178986610872.2160803.4250787247100119943@kernel.org>
In-Reply-To: <20260916003430.3612956-1-kris.pan@intel.com>
References: <20260916003430.3612956-1-kris.pan@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] dev_cpu_dead() drains the per-(cpu,node) deferred-free lists
  with llist_del_all() but never resets the paired sdn->defer_count.
- [Medium] The commit folds a pre-existing memory-leak fix into a hot-
  path NUMA-iteration optimisation and attributes both to Fixes:…
- [Medium] The new drain in dev_cpu_dead() is a one-shot sweep with no
  synchronization against skb_attempt_defer_free(), leaving the bug…

--

net: iterate online nodes in skb_defer_free_flush()

The patch switches skb_defer_free_flush() from for_each_node() to
for_each_online_node() so the softirq flush loop no longer walks per-node
lists for nodes that are only possible. It also adds two new drain loops to
dev_cpu_dead() so that skbs queued on the offlining CPU, or queued at the
offlining CPU's node index on other CPUs, are freed.

Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com

A couple of questions on the commit message first:

>     Since the flush now skips offline nodes, also drain the per-node
>     lists in dev_cpu_dead().  A skb is queued on the alloc CPU's list at
>     the freeing CPU's node index; if that node is offlined before the
>     alloc CPU flushes, the skb is stranded.  Likewise, skbs queued on a
>     CPU that later goes offline are never freed, since its softirq no
>     longer runs.
>
>     Fixes: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()")

[Severity: Medium]
Is the Fixes tag correct for the second half of this change?

Looking at 5628f3fe3b16, it only moved sd->defer_list / sd->defer_count into
the per-node net_hotdata.skb_defer_nodes array and adjusted
skb_defer_free_flush() and skb_attempt_defer_free().  It does not touch
dev_cpu_dead() at all.

So the "skbs queued on a CPU that later goes offline are never freed" leak
also existed before 5628f3fe3b16, when the single per-CPU sd->defer_list was
likewise never drained by dev_cpu_dead().  Only the part about lists indexed
by a node that may leave node_online_map is a consequence of the
for_each_online_node() switch here.

Following this Fixes tag, a stable backport would only reach trees that
already contain 5628f3fe3b16 and would leave the same leak in older trees.
Would it make sense to split the dev_cpu_dead() drain (stable candidate,
with its own Fixes tag) from the flush-loop optimisation?

Also, the message states that skb_attempt_defer_free() "only queues skbs on
the current CPU's node ... which is always online", but the first new loop in
dev_cpu_dead() iterates for_each_node(), i.e. all possible nodes.  Which of
the two assumptions is intended?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index ecfbd72d5d1a4..896498b349500 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6907,7 +6907,7 @@ static void skb_defer_free_flush(void)
>  	struct skb_defer_node *sdn;
>  	int node;
>  
> -	for_each_node(node) {
> +	for_each_online_node(node) {
>  		sdn = this_cpu_ptr(net_hotdata.skb_defer_nodes) + node;
>  
>  		if (llist_empty(&sdn->defer_list))

[ ... ]

> @@ -12957,6 +12960,26 @@ static int dev_cpu_dead(unsigned int oldcpu)
>  		rps_input_queue_head_incr(oldsd);
>  	}
>  
> +	/* Drain skbs deferred to the offlining CPU: its softirq no longer
> +	 * runs, so skb_defer_free_flush() would never free them.  Also drain
> +	 * skbs deferred to this CPU's node, which may leave node_online_map
> +	 * and thus be skipped by the for_each_online_node() loop in
> +	 * skb_defer_free_flush().
> +	 */
> +	for_each_node(node) {
> +		sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, oldcpu) + node;
> +		free_list = llist_del_all(&sdn->defer_list);
> +		llist_for_each_entry_safe(skb, next, free_list, ll_node)
> +			dev_consume_skb_any(skb);
> +	}
> +	node = cpu_to_node(oldcpu);
> +	for_each_online_cpu(cpu) {
> +		sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + node;
> +		free_list = llist_del_all(&sdn->defer_list);
> +		llist_for_each_entry_safe(skb, next, free_list, ll_node)
> +			dev_consume_skb_any(skb);
> +	}
> +
>  	return 0;
>  }

[Severity: High]
Should both new loops in dev_cpu_dead() also reset sdn->defer_count when
they steal the list?

The existing consumer always pairs the two:

net/core/dev.c:skb_defer_free_flush() {
	...
		if (llist_empty(&sdn->defer_list))
			continue;
		atomic_long_set(&sdn->defer_count, 0);
		free_list = llist_del_all(&sdn->defer_list);
	...
}

The producer increments before the limit test and does not undo the
increment on the reject path:

net/core/skbuff.c:skb_attempt_defer_free() {
	...
	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
	defer_count = atomic_long_inc_return(&sdn->defer_count);

	if (defer_count >= defer_max)
		goto nodefer;

	llist_add(&skb->ll_node, &sdn->defer_list);
	...
}

so defer_count can already be at or above sysctl_skb_defer_max while skbs
are queued.

If either new loop empties such a list without clearing the counter, can
that slot ever recover?  Every later skb_attempt_defer_free() for that
(cpu, node) increments the counter, sees defer_count >= defer_max, and goes
to nodefer before llist_add(), so the list stays empty and
skb_defer_free_flush() skips it on the llist_empty() fast path and never
runs atomic_long_set().

The second loop does this to lists owned by CPUs that are still online, so
would a still-running CPU permanently lose deferred freeing for the
offlined CPU's node index?

There is a milder variant as well: any residual non-zero count makes

	kick = (defer_count - 1) == (defer_max >> 1);

unable to fire for the values it skipped, so an idle target CPU may not get
the kick_defer_list_purge() IPI and queued skbs would wait for some
unrelated NET_RX_SOFTIRQ.

Nothing appears to repair this on the way back up either, since the startup
callback is NULL:

net/core/dev.c:net_dev_init() {
	...
	rc = cpuhp_setup_state_nocalls(CPUHP_NET_DEV_DEAD, "net/dev:dead",
				       NULL, dev_cpu_dead);
	...
}

[Severity: Medium]
Can an skb still be queued onto the dead CPU's list after these loops have
run?

skb_attempt_defer_free() checks cpu_online() and only later performs the
llist_add(), with no preempt_disable(), no RCU section and no re-check:

net/core/skbuff.c:skb_attempt_defer_free() {
	...
	cpu = skb->alloc_cpu;
	if (cpu == raw_smp_processor_id() ||
	    WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
	    !cpu_online(cpu)) {
nodefer:	kfree_skb_napi_cache(skb);
		return;
	}
	...
	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + numa_node_id();
	...
	llist_add(&skb->ll_node, &sdn->defer_list);
	...
}

Its process-context callers run preemptible, for example
skb_consume_udp() in net/ipv4/udp.c, tcp_eat_recv_skb() in net/ipv4/tcp.c
and mptcp_eat_recv_skb() in net/mptcp/protocol.c.

So the sequence would be:

CPU A (recvmsg)                        CPU B offlined
skb_attempt_defer_free()
  cpu_online(B) == true
  <preempted>
                                       dev_cpu_dead() runs both drain loops
  llist_add(... B's list ...)

After that, B's softirq never runs skb_defer_free_flush(), and the second
loop here only sweeps index cpu_to_node(oldcpu) on online CPUs, so that slot
is not visited again.  Is the skb then leaked for as long as B stays
offline, and would page_pool pages carried by it hold up
page_pool_destroy()?

Since the commit message presents "skbs queued on a CPU that later goes
offline are never freed" as fixed, would some ordering between the producer
and teardown (a re-check under a hotplug-safe section, or draining from
another CPU's flush path) be needed rather than a single sweep?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916003430.3612956-1-kris.pan%40intel.com
