Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D54242D88;
	Sun, 27 Sep 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532101; cv=none; b=JdOSqeI6PreAkPyvlRFeIO04B+YoFDQTfrreOXfZpBLvtsCjYRq8jhhY5q+rOralIQJAvIwU8LEKJZTJQcRot6AW7aSGF5Cn8K6x+pXuNG+QPD2MwCR6Qy3Z2vCxy5wrPTa4IxK6xmJ8PhOuA6yuRu9WgxlSop/0EKj7geCghDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532101; c=relaxed/simple;
	bh=OQvMtvW7I64obT70i+CqtdJubMB2TlFF2F23VJ9GmmU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g2zUzdoD2X+qeJI4v0GAQwJApaGCK8RudNOI1bYxY6chlURpVypUC7Auwf9djhBVvhAuH41GENzNLfeEtJqbI+FITKvCLmA3HRHzjmYc9USsXUgHliftz7NjkCo8K9xJGjXquxbWPyvtVPYfbV6633hBVd/K8ZD56cbFCoXrjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aco+1aeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aco+1aeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40251F000FF;
	Sun, 27 Sep 2026 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790532099;
	bh=k6trIV9h7HjBSL6PK91kBAVBcfY8xywvOF19t3aRIJA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Aco+1aeP0kI4+Ndd3q1PF8mQidb/0t2hDwUGSsVQsLjp6HMOEOucN/Di4Wkchq7iG
	 r19AG5MuzbAove8IWSsqwoSMD9fb0jwX0kDgkkJEd4KXr7fuQLtOYmtp6HbPygkhPx
	 aFMiUNx88UwhQZZ2iOr0y7BZsDmtaMNfi/ckqeWI8qH/A/fwkCZ2TCNsyYr/n6gL4K
	 26ec6czMYTjg8LWSSwCdiaEfFjG9ymvXi2brOiEEz8/PGGC/AXSA5terbre9jdYkwq
	 NXGP9y8B6QhkUUZo7CCoiDrxg18mEyvlR+He9JGR2oi6k9gdslYLmWYYbIST8rYiHE
	 u+QDvZkkIh6bA==
Subject: Re: [PATCH net v3] netpoll: bound the deferred transmit queue
From: netdev-bot+sashiko@kernel.org
To: zack.gomez@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, leitao@debian.org,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 18:01:38 +0000
Message-ID: <179053209847.2160803.7321222367007767138@kernel.org>
In-Reply-To: <20260923181111.1182838-1-zack.gomez@gmail.com>
References: <20260923181111.1182838-1-zack.gomez@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] netpoll: percpu allocation in __netpoll_send_skb triggers
  PREEMPT_RT/NMI crashes
- [Medium] The FULL_RING drop reason that v2 added ("free with
  SKB_DROP_REASON_FULL_RING") is thrown away on the netconsole path that…

--

netpoll: bound the deferred transmit queue

This patch caps npinfo->txq at NETPOLL_TXQ_MAX (1024) skbs per device.
When the queue is full, __netpoll_send_skb() now drops new skbs instead of
letting them pile up. Each drop is counted in the device's tx_dropped, and
the skb is freed with SKB_DROP_REASON_FULL_RING.

> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index fe1e0cda5d6bf..aafbb19a28870 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c

[ ... ]

> @@ -314,6 +323,12 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
>  	}
>  
>  	if (!dev_xmit_complete(status)) {
> +		if (skb_queue_len_lockless(&npinfo->txq) >= NETPOLL_TXQ_MAX) {
> +			dev_core_stats_tx_dropped_inc(dev);
> +			dev_kfree_skb_irq_reason(skb,
> +						 SKB_DROP_REASON_FULL_RING);

[Severity: High]
Can the first drop on a device end up in the percpu allocator with
hard IRQs disabled?

__netpoll_send_skb() asserts lockdep_assert_irqs_disabled(), and
netpoll_send_skb() gets here under local_irq_save(). When
dev->core_stats is still NULL, dev_core_stats_tx_dropped_inc() goes
through netdev_core_stats_inc() into netdev_core_stats_alloc(). That
calls alloc_percpu_gfp() with GFP_ATOMIC. For atomic requests,
pcpu_alloc_noprof() takes the global pcpu_lock with
spin_lock_irqsave().

On PREEMPT_RT, pcpu_lock is a sleeping lock. Taking it here with
interrupts hard-disabled is a sleeping-in-atomic bug.

There is also a problem on any config. If the console is flushed from
NMI context, for example a watchdog panic, and the interrupted code on
that CPU already holds pcpu_lock, this deadlocks.

The allocation happens only once per device, and only after 1024 skbs
are already parked. But that is exactly the flood or panic scenario
this patch is meant to survive.

The cover letter compares this with the GFP_ATOMIC skb allocation
find_skb() already does on this path. The two differ, though:
find_skb() can fall back to the preallocated skb pool, while the
percpu allocator always goes through pcpu_lock and has no fallback.

You offered to allocate the core stats at netpoll setup instead. Would
doing that in __netpoll_setup() be the better option? It runs in
process context for every device that owns an npinfo->txq. That
includes the lower devices that bond, team, bridge and vlan set up
through their ndo_netpoll_setup callbacks.

netdev_core_stats_alloc() is local to net/core/dev.c, so this probably
needs a small helper exposed from there. Or do you have a different way
to keep the tx_dropped accounting off the allocator in this context?

[Severity: Medium]
Will the FULL_RING reason reach drop monitoring tools on the netconsole
path?

dev_kfree_skb_irq_reason() only stores the reason in
get_kfree_skb_cb(skb)->reason and parks the skb on the per-CPU
softnet_data.completion_queue. The one consumer that reads that reason
and calls trace_kfree_skb() is net_tx_action().

netpoll_zap_completion_queue() also drains the same queue, and it frees
irq-freeable skbs with __kfree_skb():

net/core/netpoll.c:netpoll_zap_completion_queue() {
    ...
			if (!skb_irq_freeable(skb)) {
				refcount_set(&skb->users, 1);
				dev_kfree_skb_any(skb); /* put this one back */
			} else {
				__kfree_skb(skb);
			}
    ...
}

__kfree_skb() calls skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED)
and emits no kfree_skb tracepoint. The dev_kfree_skb_any() requeue path
overwrites the stored reason.

netconsole calls netpoll_zap_completion_queue() at the start of every skb
allocation, and netpoll_poll_dev() calls it too:

drivers/net/netconsole.c:find_skb() {
    ...
	netpoll_zap_completion_queue();
repeat:
    ...
}

During a sustained flood, which is the case this patch targets, the next
message on the same CPU would normally drain the FULL_RING skbs before
NET_TX_SOFTIRQ runs. netconsole skbs have no destructor, nfct, dst,
secpath or frag_list, so skb_irq_freeable() is true and they take the
silent __kfree_skb() path.

As a result, could dropwatch and perf skb:kfree_skb see few or none of
these drops, even though tx_dropped counts all of them? The commit message
says the skbs are "freed with SKB_DROP_REASON_FULL_RING". Is that accurate
for this path?

> +			goto out;
> +		}
>  		skb_queue_tail(&npinfo->txq, skb);
>  		schedule_delayed_work(&npinfo->tx_work,0);
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923181111.1182838-1-zack.gomez%40gmail.com
