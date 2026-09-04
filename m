Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617633ACA7E
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491404; cv=none; b=eVtfpsdstFS4x4ASg+dSwIQAbfbVSNshxRgq/ETqgnHisngMX+6aLZVzGVbRPvNa9hD5rlh+5/WU01xB6F0no2p6zOdRTM05lSn/pPlfKdPrVUZ4biapO0IfH/T8L7R6/Kw9rb5cFOw5MpIDubaJqBmPLCyz/dZiytWCwaJXi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491404; c=relaxed/simple;
	bh=P2jZzOfMqLNC5m71wGxXRrkSsSGMJGGDPFXUh/MEnqk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWQEiO6vxxdeBLdTrloEqqDXRBQKC87OVl4Ssn/3l/5AAUDcy1Lu970zSSeAZ7lzvCtBrRgfI2IJNp9scsHAoQKacz37PnMbIkfRLtc96LadBJWDDwOm6sDFq6451zk9YRzX85iW1FOWLq7ppnlIYme7ueCE9KqpxSWzdROnR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3rA+2i4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3rA+2i4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3611F00A3D;
	Fri,  4 Sep 2026 03:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491403;
	bh=DXu3PS/6iiovko6NXnrgbe1w1DFAhiX6HDfJ9kcHNQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B3rA+2i49gRe0AX3gXa0h/XyWNAQqRG4E8wFqiWg6noiJE2bY5kz7IhgN9uZ+m428
	 NNzf122RE+i6Sq1+dAnmjqN/P5v1UZ+H9HGU2VJ0toZPQeAH4Zid7RA6fBDpHVBt1w
	 LaldniEmMcuKZ1s/HzLo4/TiT7ptqJk+Jm2Cf1hU8OH5sJkzB7eDu86Fx/aTWJnvMM
	 v9AMshfRa5NJsk/0+fKi8hs8W3rAdhj3BgcD0rBmRWUbHWDMXgIuW4TlYVxEes3mwP
	 1dKlD67+Rt0tKQUgHghYCq/fl4VOVIe8hw+Dlf2oQgiqW9QxQRX4LjWqTJXF8Xsujf
	 hXSah0ZD6fLyA==
Subject: Re: [PATCH v6 net-next 11/15] neighbour: Convert neigh_table.entries
 to refcount_t.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 razor@blackwall.org
Date: Fri, 04 Sep 2026 03:10:02 +0000
Message-ID: <178849140215.4131868.10205662438617953828@kernel.org>
In-Reply-To: <20260902203722.926528-12-kuniyu@google.com>
References: <20260902203722.926528-12-kuniyu@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] neigh_table_free() frees RCU-published, table-owned resources
  with no grace period, while the objects that point at the table are…
- [Low] Teardown ordering concern: neigh_table_clear() ends with
  neigh_table_put(), dropping the base reference installed by…

--

neighbour: Convert neigh_table.entries to refcount_t.

This converts neigh_table.entries from atomic_t to refcount_t and adds
neigh_table_get()/neigh_table_put() helpers plus a new neigh_table_free()
so that the table resources are released only when the last neighbour is
gone.  neigh_table_clear() now just drops the base reference taken in
neigh_table_init().

A couple of questions about the new teardown path below.

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 36488dbd1512..7dc8f0cdbb45 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -55,6 +55,23 @@ static void neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
>  static void __neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
>  static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
>  			  bool skip_perm);
> +static void neigh_table_free(struct neigh_table *tbl);
> +
> +static void neigh_table_get(struct neigh_table *tbl)
> +{
> +	refcount_inc(&tbl->entries);
> +}
> +
> +static void neigh_table_put(struct neigh_table *tbl)
> +{
> +	if (refcount_dec_and_test(&tbl->entries))
> +		neigh_table_free(tbl);
> +}
> +
> +static int neigh_table_entries(struct neigh_table *tbl)
> +{
> +	return refcount_read(&tbl->entries) - 1;
> +}
>  
>  #ifdef CONFIG_PROC_FS
>  static const struct seq_operations neigh_stat_seq_ops;

[ ... ]

> @@ -1845,6 +1862,7 @@ void neigh_table_init(struct neigh_table *tbl)
>  	tbl->last_flush = now;
>  	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
>  
> +	refcount_set(&tbl->entries, 1);
>  	spin_lock_init(&tbl->lock);
>  	mutex_init(&tbl->phash_lock);
>  	skb_queue_head_init_class(&tbl->proxy_queue,

[ ... ]

> @@ -924,7 +941,7 @@ void neigh_destroy(struct neighbour *neigh)
>  
>  	neigh_dbg(2, "neigh %p is destroyed\n", neigh);
>  
> -	atomic_dec(&neigh->tbl->entries);
> +	neigh_table_put(neigh->tbl);
>  	kfree_rcu(neigh, rcu);
>  }
>  EXPORT_SYMBOL(neigh_destroy);

[ ... ]

> @@ -1874,6 +1892,21 @@ void neigh_table_init(struct neigh_table *tbl)
>  	panic("cannot allocate memory");
>  }
>  
> +static void neigh_table_free(struct neigh_table *tbl)
> +{
> +	struct neigh_hash_table *nht;
> +
> +	free_percpu(tbl->stats);
> +	tbl->stats = NULL;
> +
> +	kfree(tbl->phash_buckets);
> +	tbl->phash_buckets = NULL;
> +
> +	nht = rcu_dereference_protected(tbl->nht, 1);
> +	tbl->nht = NULL;
> +	neigh_hash_free_rcu(&nht->rcu);
> +}

[Severity: Medium]
Is it safe to free these RCU-published members synchronously here?
neigh_table_free() calls free_percpu(tbl->stats), kfree(tbl->phash_buckets)
and invokes the RCU callback neigh_hash_free_rcu() directly, with no
grace period in between.

At the same time neigh_destroy() drops the table reference before the
neighbour body is retired:

	neigh_table_put(neigh->tbl);
	kfree_rcu(neigh, rcu);

If that put is the last one, the table (the pointee) is reclaimed
immediately while the neighbour holding neigh->tbl survives a full grace
period.

Lockless readers hold no-ref neighbour pointers under rcu_read_lock() and
dereference the table through them, for example in __neigh_event_send():

	NEIGH_CACHE_STAT_INC(neigh->tbl, unres_discards);

which is reached from the transmit path
ip_finish_output2()/ip6_finish_output2() -> neigh_output() ->
neigh_event_send().  tbl->nht is read via rcu_dereference() in
___neigh_lookup_noref(), and tbl->phash_buckets is declared __rcu and
walked by pneigh_lookup().

The same file retires nht only after a grace period:

net/core/neighbour.c:neigh_hash_grow() {
	...
	rcu_assign_pointer(tbl->nht, new_nht);
	call_rcu(&old_nht->rcu, neigh_hash_free_rcu);
	...
}

Note also that neigh_table_put() can now reach this free from softirq
context, since neigh_timer_handler() -> neigh_release() -> neigh_destroy()
runs long after neigh_table_clear() returned, and neigh_destroy() releases
the netdev reference before the table reference, so netdev_wait_allrefs()
does not order it either.

Most reader windows do look drained in practice (cleanup_net() runs
synchronize_rcu_expedited() before the pernet exit ops, and
unregister_netdevice_many_notify() runs synchronize_net() before the
neighbour flush), so I could not show a reader that is still in flight at
that instant.  Still, would it be better to defer this free with
call_rcu()/kfree_rcu(), or to drop the table reference from the
neighbour's own RCU callback, especially since the follow-up patch adds
kfree(tbl) to this function?

>  /*
>   * Only called from ndisc_cleanup(), which means this is dead code
>   * because we no longer can unload IPv6 module.
> @@ -1881,26 +1914,15 @@ void neigh_table_init(struct neigh_table *tbl)
>  int neigh_table_clear(struct neigh_table *tbl)
>  {
>  	struct net *net __maybe_unused = &init_net;
> -	struct neigh_hash_table *nht;
>  
>  	cancel_delayed_work_sync(&tbl->managed_work);
>  	cancel_delayed_work_sync(&tbl->gc_work);
>  	timer_shutdown_sync(&tbl->proxy_timer);
>  
>  	neigh_ifdown(tbl, NULL);
> -	DEBUG_NET_WARN_ON_ONCE(atomic_read(&tbl->entries));
> -
>  	remove_proc_entry(tbl->id, net->proc_net_stat);
>  
> -	free_percpu(tbl->stats);
> -	tbl->stats = NULL;
> -
> -	kfree(tbl->phash_buckets);
> -	tbl->phash_buckets = NULL;
> -
> -	nht = rcu_dereference_protected(tbl->nht, 1);
> -	tbl->nht = NULL;
> -	neigh_hash_free_rcu(&nht->rcu);
> +	neigh_table_put(tbl);
>  
>  	return 0;
>  }

[Severity: Low]
This is more of an ordering question.  neigh_table_clear() drops the base
reference installed by refcount_set(&tbl->entries, 1) in
neigh_table_init(), but at this commit the table is still published: in
ndisc_cleanup() the call order is neigh_table_clear(&nd_tbl) followed by
unregister_pernet_subsys(&ndisc_net_ops).

Once the base reference is gone, neigh_table_entries() returns
refcount_read() - 1, which is entries - 1 in general and -1 when the last
neighbour is gone.  That value feeds the __u32 uAPI field:

	.ndtc_entries		= neigh_table_entries(tbl),

and the %08x in neigh_stat_seq_show(), where it would print as ffffffff.

Checking the rest of the series, this looks unreachable in the final
state: neigh_table_unregister() sets net->neigh_tables[index] = NULL
before calling neigh_table_clear(), the proc entry is removed and drained
before the put, and ndisc_cleanup() no longer calls neigh_table_clear()
at all.  At this commit the only caller is the inet6_init() error path
that the comment above already describes as dead code.

Would it still be worth dropping the base reference only after the table
is unpublished, so the biased accessor is never read without it?

> @@ -2275,7 +2297,7 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
>  		struct ndt_config ndc = {
>  			.ndtc_key_len		= tbl->key_len,
>  			.ndtc_entry_size	= tbl->entry_size,
> -			.ndtc_entries		= atomic_read(&tbl->entries),
> +			.ndtc_entries		= neigh_table_entries(tbl),
>  			.ndtc_last_flush	= jiffies_to_msecs(flush_delta),
>  			.ndtc_last_rand		= jiffies_to_msecs(rand_delta),
>  			.ndtc_proxy_qlen	= READ_ONCE(tbl->proxy_queue.qlen),
> @@ -3495,7 +3517,7 @@ static int neigh_stat_seq_show(struct seq_file *seq, void *v)
>  	seq_printf(seq, "%08x %08lx %08lx %08lx   %08lx %08lx %08lx   "
>  			"%08lx         %08lx         %08lx         "
>  			"%08lx       %08lx            %08lx\n",
> -		   atomic_read(&tbl->entries),
> +		   neigh_table_entries(tbl),
>  
>  		   st->allocs,
>  		   st->destroys,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902203722.926528-1-kuniyu%40google.com
