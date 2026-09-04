Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D093AFD12
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491403; cv=none; b=O3Lqs4gT7k+t+OGQ84RYkwp0msnPblRSERZwNFaDOGYmBW/8rXTPUgTByVdYsTMHVppJvNBnkDH9at7FTU3oEXlt4AV3xSEKgFaJTAWAtZ+dORUxUGQgh89/MVtpQT9siADOQj2QPjSAvT9oAUP5VMNywChp1jhJpJ3J4EBdDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491403; c=relaxed/simple;
	bh=Mhxxn44zEeCngs6u2N5tEYGJnTb+L53W9h2yYCwsQys=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xkz6lGFD9y5iciWZZxRxZLA1SGTfh6jTweTg+b+8dDH0n7ZiXx/mDg25E+cfDT6oMwqDZ7O/GpcTFMn+gUgO/E4ia8lQT8D2MgN5UDi98kQZC9CELvcYR0wm7AdAjOu7CHukdn/JerKUiQ6n3zUpk5/oncXd9WkuuVYav3ElFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlDu9y+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlDu9y+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B45C1F00A3E;
	Fri,  4 Sep 2026 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491402;
	bh=MY70Qssg3YUA6rTWVbOQHy/m6qZc9hUzY6XprGYfPJA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HlDu9y+Nmig3POecGzShsRFfCGl+MEXQBWG0bwhB+CUCJRv+3tptBTd/ZcGakOdfj
	 GJir+L3sP7yRzK5GDG82jBs3HhI9ZEo0xG1V2ccECCRV/5SXwSi4YoLcb0SzdNOGgo
	 3RqQppHDE0eKZRHASzUx+Toqw1WOZ+XjOJ72MFK9dIQHDWNEa5tZtni0CRHJY4Geua
	 o32TVhz2p/vuzdeIB8TksVjxgQmg7NJ8WtCVaWitq97YIhQoaLGCE28+6iRIqPbJ7T
	 g8ZTRGkVvijYK9w7wCmri+Q3wcq9NC1ThD7/fUwXKMgXiMgDozC58nFkfMvS4b363D
	 XPmZvSrjuyeJQ==
Subject: Re: [PATCH v6 net-next 10/15] neighbour: Clean up neigh_table_init()
 and neigh_table_clear().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 razor@blackwall.org
Date: Fri, 04 Sep 2026 03:10:00 +0000
Message-ID: <178849140082.4131868.5096987849252659627@kernel.org>
In-Reply-To: <20260902203722.926528-11-kuniyu@google.com>
References: <20260902203722.926528-11-kuniyu@google.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

- [High] net/core/neighbour.c:neigh_table_clear() now reclaims the RCU-
  published neighbour hash table synchronously: `nht =…

Pre-existing issues:
- [Low] neigh_table_clear() (net/core/neighbour.c:1881-1906) frees table-
  wide resources (free_percpu(tbl->stats) at 1895,…

--

neighbour: Clean up neigh_table_init() and neigh_table_clear().

This reworks neigh_table_init() to allocate everything up front and unwind
on failure, and reorders neigh_table_clear() to mirror it. The teardown
side also switches to timer_shutdown_sync(), drops the explicit
pneigh_queue_purge(), replaces pr_crit() with DEBUG_NET_WARN_ON_ONCE(), and
calls neigh_hash_free_rcu() directly instead of via call_rcu().

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 34da4cdc813d..36488dbd1512 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c

[ ... neigh_table_init() hunk snipped ... ]

> @@ -1869,26 +1880,27 @@ void neigh_table_init(struct neigh_table *tbl)
>   */
>  int neigh_table_clear(struct neigh_table *tbl)
>  {
> -	/* It is not clean... Fix it to unload IPv6 module safely */
> +	struct net *net __maybe_unused = &init_net;
> +	struct neigh_hash_table *nht;
> +
>  	cancel_delayed_work_sync(&tbl->managed_work);
>  	cancel_delayed_work_sync(&tbl->gc_work);
> -	timer_delete_sync(&tbl->proxy_timer);
> -	pneigh_queue_purge(&tbl->proxy_queue, NULL, tbl->family);
> +	timer_shutdown_sync(&tbl->proxy_timer);
> +
>  	neigh_ifdown(tbl, NULL);
> -	if (atomic_read(&tbl->entries))
> -		pr_crit("neighbour leakage\n");
> +	DEBUG_NET_WARN_ON_ONCE(atomic_read(&tbl->entries));

[Severity: Low]

This isn't a bug introduced by this patch, but the diagnostic swap makes a
pre-existing lifecycle problem invisible on production kernels: with
CONFIG_DEBUG_NET=n, DEBUG_NET_WARN_ON_ONCE() compiles to nothing, so the
"still have entries" condition that previously always printed is no longer
reported.

The table-owned resources are still freed unconditionally just below, and a
neighbour destroyed afterwards touches them:

net/core/neighbour.c:neigh_destroy() {
	NEIGH_CACHE_STAT_INC(neigh->tbl, destroys);
	...
	atomic_dec(&neigh->tbl->entries);
}

The unconditional freeing itself is unchanged from the baseline, and the
next patch in the series, "neighbour: Convert neigh_table.entries to
refcount_t", defers freeing of tbl->stats, tbl->phash_buckets and tbl->nht
into neigh_table_free() once the last reference is dropped.

Is dropping the production-visible message intentional for this
intermediate commit?

>  
> -	call_rcu(&rcu_dereference_protected(tbl->nht, 1)->rcu,
> -		 neigh_hash_free_rcu);
> -	tbl->nht = NULL;
> +	remove_proc_entry(tbl->id, net->proc_net_stat);
> +
> +	free_percpu(tbl->stats);
> +	tbl->stats = NULL;
>  
>  	kfree(tbl->phash_buckets);
>  	tbl->phash_buckets = NULL;
>  
> -	remove_proc_entry(tbl->id, init_net.proc_net_stat);
> -
> -	free_percpu(tbl->stats);
> -	tbl->stats = NULL;
> +	nht = rcu_dereference_protected(tbl->nht, 1);
> +	tbl->nht = NULL;
> +	neigh_hash_free_rcu(&nht->rcu);

[Severity: High]

Can this free the neighbour hash table while lockless readers still hold a
pointer to it?

neigh_hash_free_rcu() is an RCU callback body, so calling it directly
releases both the bucket array and the table object immediately:

net/core/neighbour.c:neigh_hash_free_rcu() {
	...
	kfree(nht->hash_heads);
	kfree(nht);
}

Nothing in the new teardown sequence waits for a grace period:
cancel_delayed_work_sync() twice, timer_shutdown_sync(), neigh_ifdown()
and remove_proc_entry(). neigh_ifdown() only takes tbl->lock, which the
readers never take.

The readers dereference tbl->nht under RCU with no NULL check:

include/net/neighbour.h:___neigh_lookup_noref() {
	struct neigh_hash_table *nht = rcu_dereference(tbl->nht);
	...
	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
	neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[hash_val])
}

so a reader that already loaded nht reads hash_shift, hash_rnd and
hash_heads out of freed slab memory and then follows whatever hlist
contents are left there. neigh_lookup(), neigh_dump_table(),
neigh_seq_start() and neightbl_fill_info() have the same shape.

Is the table still published while this runs? ndisc_cleanup() calls
neigh_table_clear(&nd_tbl) before unregister_pernet_subsys(&ndisc_net_ops),
and the pernet exit path is what clears net->neigh_tables[NEIGH_ND_TABLE],
so nd_tbl remains installed in every netns during the free. An
unprivileged RTM_GETNEIGH dump reaches it holding only rcu_read_lock():

net/core/neighbour.c:neigh_dump_info() {
	rcu_read_lock();
	for (t = 0; t < NEIGH_NR_TABLES; t++) {
		tbl = net->neigh_tables[t];

and ndisc_cleanup() is live today from the module-init error unwind:

net/ipv6/af_inet6.c:inet6_init() {
igmp_fail:
	ndisc_cleanup();

The peer site retiring the same object type still uses a grace period:

net/core/neighbour.c:neigh_hash_grow() {
	rcu_assign_pointer(tbl->nht, new_nht);
	call_rcu(&old_nht->rcu, neigh_hash_free_rcu);
}

Would keeping call_rcu()/kfree_rcu(), or inserting a synchronize_net()
before the free, be preferable here? The plain NULL store into the __rcu
pointer tbl->nht predates this patch; what is new is the access to freed
memory. This also does not appear to be addressed later in the series: at
the end of the range the same unsynchronised free lives in
neigh_table_free(), now additionally doing kfree(tbl), while
neigh_table_unregister() clears net->neigh_tables[index] and calls
neigh_table_clear()/neigh_table_put() with no grace period in between.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902203722.926528-1-kuniyu%40google.com
