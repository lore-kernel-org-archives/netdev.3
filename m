Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60648D88E;
	Thu, 10 Sep 2026 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046508; cv=none; b=ZL2zIf6nQYWB2hUTGDV2fTxHJXu1AhVqE/NKKxGhJLbHgFMOw9pi8f91nqkB98TZpg8rSz5lLkLVtTSWqhqs3DdqmxvURhJ3Em1Toe07FBmjHMorypDF+zvOCQ+SW2lDK74Fj2ZcQ//lX5yqgRITDoCJfi6if0e9S8rPmg8IkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046508; c=relaxed/simple;
	bh=PzwgKZqBgBxUTk3mZgkFp3OS+77YN75PqU+leHCr5iI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KgcWechuiMtm8G8vHkwQ43t7D31Dsazmy9bq1qJ6cmQLq4LtoDGSsxDRxgQmlNdA1r7OeNrYr/PoPGDgoO+W256V/VmllBWqQBhUl6ZgPzcsUiFDm+OzZkvn7rye1dl0dVmDKuFw+8J9xN3FpJvJpkjE1JJVcHNxg+LlmUj1ZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvXFXFny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvXFXFny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD7C1F000FF;
	Thu, 10 Sep 2026 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046500;
	bh=XfSAjJWUqJJ7+mxfcDcdQLKBKAoUnDYGI6OdwN5RDBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QvXFXFnyIkyH+0MXQBt0dmKR7FyJEOBmtJY0a4ORt5crqU1tpzv+odLk4XmVddvM+
	 5FER3oGYW3DrGx1d1+pO1O8SRFNYonMsnIyZYGjR7xgtfd8LMWJFPMvL+enq/N5Nuv
	 +h3039zzHSwAn346HYAHYV0uW6kceKw1l3/K+0+j4VyiY5fargzMF3vN+5lVD5bTsX
	 TfPnuASC2D486JVtsQmRroxzvb3hqVngkslf16TEbc9AJG3d4+yClpriT2NLZqRSL0
	 4Rl1WVktwSQGj7fKcHOZAGGGnAdnjwUJcPb7ANTN6zhpR0NalalI7XrMTGYh2eZOrw
	 JPzHAqzusxqpQ==
Subject: Re: [PATCH v2] rxrpc: Fix use-after-free in rxrpc_destroy_all_peers()
From: netdev-bot+sashiko@kernel.org
To: elver@google.com
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 syzkaller-bugs@googlegroups.com,
 syzbot+c876adfab6362679008c@syzkaller.appspotmail.com
Date: Thu, 10 Sep 2026 13:21:39 +0000
Message-ID: <178904649905.219967.13039055478544896758@kernel.org>
In-Reply-To: <20260907222242.3361174-2-elver@google.com>
References: <20260907222242.3361174-2-elver@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 3 · Medium: 2 · Low: 0

- [High] Moving rxrpc_destroy_all_calls()/rxrpc_destroy_all_connections()
  into the new .pre_exit hook deadlocks netns teardown whenever the kafs…
- [High] The patch hardens only the reader side of the peer hash.
- [High] The changelog's justification for the .pre_exit split is not
  what the code does.
- [Medium] Ordering regression in the leak checks: rxrpc_exit_net() now
  runs rxrpc_destroy_all_peers()/rxrpc_destroy_all_locals() with no…
- [Medium] rxrpc_destroy_all_peers() (net/rxrpc/peer_object.c:452-476)
  now performs an unbounded pr_err() loop over all 1024 hash buckets and…

--

rxrpc: Fix use-after-free in rxrpc_destroy_all_peers()

This takes rxnet->peer_hash_lock with spin_lock_bh() around the leaked-peer
walk in rxrpc_destroy_all_peers() to fix a syzbot-reported KASAN
slab-use-after-free, and additionally splits netns teardown so that calls,
connections and the keepalive work are cleaned up from a new .pre_exit
handler while the peer and local endpoint leak checks stay in .exit.

Link: https://syzkaller.appspot.com/ai_job?id=7fecbeb2-cd9b-4ca2-8149-48663e20b153

A few questions below, mostly about the .pre_exit split rather than the
locking hunk.

First, about the changelog:

> Additionally, split netns teardown by implementing .pre_exit in
> rxrpc_net_ops to clean up calls, connections, and keepalive work. This
> ensures in-flight references are released before cleanup_net() executes
> its intermediate synchronize_rcu(), so that peer and local endpoint leak
> checks in rxrpc_exit_net() run only after deferred RCU releases complete,
> avoiding spurious leak warnings.

[Severity: High]
Is this description accurate?

The relative order of the four teardown steps is unchanged: before the
patch rxrpc_exit_net() already ran calls -> connections -> peers -> locals,
so moving the first two into .pre_exit does not reorder them with respect
to the leak checks.

The only new event inserted between them is the grace-period wait in
ops_undo_list():

net/core/net_namespace.c:ops_undo_list() {
	...
	if (expedite_rcu)
		synchronize_rcu_expedited();
	else
		synchronize_rcu();
	...
}

That waits for a grace period, not for already-queued call_rcu()/kfree_rcu()
callbacks to execute, which is what rcu_barrier() (the v1 approach) did.

Also, rxrpc itself does not release peer references from an RCU callback.
rxrpc_destroy_call() drops the peer synchronously before queueing the
callback:

net/rxrpc/call_object.c:rxrpc_destroy_call() {
	...
	rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
	rxrpc_put_local(call->local, rxrpc_local_put_call);
	key_put(call->key);
	call_rcu(&call->rcu, rxrpc_rcu_free_call);
}

and rxrpc_clean_up_connection() does the same before call_rcu(&conn->rcu,
...), both already covered by the pre-existing wait_var_event(nr_calls) and
wait_var_event(nr_conns).

The peer references that really are dropped from an RCU callback belong to
kafs (afs_free_addrlist() calling rxrpc_kernel_put_peer() for each address),
and those callbacks are queued from afs_net_exit(), i.e. after the
intermediate synchronize_rcu(), so the split cannot drain them either.

Spurious reports also still look possible: a peer whose refcount already
reached zero but which is blocked on peer_hash_lock inside
__rxrpc_put_peer() is still linked and gets printed as
"Leaked peer <id> {0}".

Could the changelog be reworded to describe what the split actually
achieves?

> diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
> index 9a9834145e81e..1691167353663 100644
> --- a/net/rxrpc/net_ns.c
> +++ b/net/rxrpc/net_ns.c
> @@ -97,10 +97,7 @@ static __net_init int rxrpc_init_net(struct net *net)
>  	return ret;
>  }
>  
> -/*
> - * Clean up a per-network namespace record.
> - */
> -static __net_exit void rxrpc_exit_net(struct net *net)
> +static __net_exit void rxrpc_pre_exit_net(struct net *net)
>  {
>  	struct rxrpc_net *rxnet = rxrpc_net(net);
>  
> @@ -111,14 +108,24 @@ static __net_exit void rxrpc_exit_net(struct net *net)
>  	timer_delete_sync(&rxnet->peer_keepalive_timer);
>  	rxrpc_destroy_all_calls(rxnet);
>  	rxrpc_destroy_all_connections(rxnet);
> +}

[Severity: High]
Can this hang netns teardown when kafs is loaded?

ops_undo_list() runs every ops->pre_exit() before any ops->exit():

net/core/net_namespace.c:ops_undo_list() {
	...
	list_for_each_entry_continue_reverse(ops, ops_list, list) {
		hold_rtnl |= !!ops->exit_rtnl;
		ops_pre_exit_list(ops, net_exit_list);
	}
	...
}

kafs has no .pre_exit:

fs/afs/main.c:
static struct pernet_operations afs_net_ops = {
	.init	= afs_net_init,
	.exit	= afs_net_exit,
	...
};

so afs_close_socket(), the only path that reaches
rxrpc_discard_prealloc(), cannot run until rxrpc_pre_exit_net() has already
returned. afs_net_init() -> afs_open_socket() charges rxrpc_max_backlog
preallocated service calls (rxrpc_alloc_call() does
atomic_inc(&rxnet->nr_calls)) and the matching prealloc service
connections in every namespace.

That leaves rxrpc_destroy_all_calls() waiting on a counter that nothing can
decrement:

net/rxrpc/call_object.c:rxrpc_destroy_all_calls() {
	...
	atomic_dec(&rxnet->nr_calls);
	wait_var_event(&rxnet->nr_calls, !atomic_read(&rxnet->nr_calls));
}

with the cleanup_net worker holding pernet_ops_rwsem for read, and after
printing "Call ... still in use" for the prealloc calls.

If the call backlog were somehow empty, would rxrpc_destroy_all_connections()
then trip on the still-linked AFS prealloc service conns?

net/rxrpc/conn_object.c:rxrpc_destroy_all_connections() {
	...
	BUG_ON(leak);

	ASSERT(list_empty(&rxnet->conn_proc_list));
	...
}

Before the patch all four steps ran from .exit, which executes after
afs_net_exit() has closed the socket and discarded the preallocation. Does
the reported use-after-free need the split at all, or is the peer_hash_lock
hunk alone sufficient?

> +
> +/*
> + * Clean up a per-network namespace record.
> + */
> +static __net_exit void rxrpc_exit_net(struct net *net)
> +{
> +	struct rxrpc_net *rxnet = rxrpc_net(net);
> +
>  	rxrpc_destroy_all_peers(rxnet);
>  	rxrpc_destroy_all_locals(rxnet);
>  	proc_remove(rxnet->proc_net);
>  }

[Severity: Medium]
With both drains moved out, rxrpc_exit_net() now reaches the peer and local
leak checks with no preceding quiescence step, while the socket closures
that generate asynchronous peer releases happen in the same .exit phase
just before it (.exit hooks run in reverse registration order, so
afs_net_exit() precedes rxrpc_exit_net()):

fs/afs/main.c:afs_net_exit() {
	...
	afs_wait_for_servers(net);
	afs_close_socket(net);
	...
}

Previously rxrpc_destroy_all_calls() (wait for nr_calls == 0) and
rxrpc_destroy_all_connections() (flush_workqueue plus wait for
nr_conns == 0) ran immediately before the peer walk and drained exactly the
releases produced by those closures. Now they run before the events they
were draining.

Can rxrpc_destroy_all_peers() therefore print "Leaked peer" for peers whose
release is still in flight, in particular the peer references dropped from
afs_free_addrlist(), queued during afs_net_exit() and hence after the
core's intermediate synchronize_rcu()?

For the record, the related worry about rxrpc_destroy_all_locals() hitting
BUG() does not seem to hold: rxrpc_alloc_peer() takes only a plain
rxrpc_get_local() reference, and the hlist_del_init_rcu(&local->link) unlink
is driven by active_users reaching zero and completes synchronously inside
rxrpc_unuse_local()'s kthread_stop(), which for kafs happens inside
afs_close_socket().

[ ... ]

> diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
> index fa9a406e11683..faa2983638b2b 100644
> --- a/net/rxrpc/peer_object.c
> +++ b/net/rxrpc/peer_object.c
> @@ -454,6 +454,12 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
>  	struct rxrpc_peer *peer;
>  	int i;
>  
> +	/*
> +	 * Prevent use-after-free if a peer is concurrently unlinked from the
> +	 * hash table and freed via RCU during iteration.
> +	 */
> +	spin_lock_bh(&rxnet->peer_hash_lock);
> +
>  	for (i = 0; i < HASH_SIZE(rxnet->peer_hash); i++) {
>  		if (hlist_empty(&rxnet->peer_hash[i]))
>  			continue;

[Severity: Medium]
Should the number of reported peers be capped now that the walk runs with
BH disabled?

The loop covers all 1024 buckets and every peer in them, with one pr_err()
per peer and no output limit, whereas the call reporter deliberately stops
early:

net/rxrpc/call_object.c:rxrpc_destroy_all_calls() {
	...
			if (++shown >= 10)
				break;
	...
}

Before the patch this loop ran in plain preemptible process context. A peer
refcount leak (the very condition this diagnostic exists to report, and the
class addressed by the referenced Fixes: commit) can leave a large number of
peers hashed, so this becomes a long atomic section full of printk() calls
to a possibly slow console.

peer_hash_lock is also taken from softirq context (rxrpc_lookup_peer(),
rxrpc_new_incoming_peer(), and __rxrpc_put_peer()), so does holding it
across that burst stall packet input for any still-live local endpoint in
the namespace, and can it trip softlockup or RCU-stall watchdogs?

Collecting under the lock and printing outside it, or capping the count as
the call and conn reporters do, would avoid that.

>  
> @@ -465,6 +471,8 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
>  			       &peer->srx.transport);
>  		}
>  	}
> +
> +	spin_unlock_bh(&rxnet->peer_hash_lock);
>  }

[Severity: High]
This hardens the reader side, but rxrpc_destroy_all_peers() still only
reports peers; it neither frees them nor waits for outstanding peer
references, so rxrpc_exit_net() can return with peers still holding a
pointer into rxnet.

rxnet is net_generic memory freed by ops_free_list() at the end of
ops_undo_list(), which happens before cleanup_net()'s rcu_barrier():

net/core/net_namespace.c:cleanup_net() {
	...
	ops_undo_list(&pernet_list, NULL, &net_exit_list, true);

	up_read(&pernet_ops_rwsem);

	/* Ensure there are no outstanding rcu callbacks using this
	 * network namespace.
	 */
	rcu_barrier();
	...
}

A concrete late-put path exists in kafs: afs_put_addrlist() does
call_rcu(&alist->rcu, afs_free_addrlist), and the callback drops the peer
references:

fs/afs/addr_list.c:afs_free_addrlist() {
	...
	for (i = 0; i < alist->nr_addrs; i++)
		rxrpc_kernel_put_peer(alist->addrs[i].peer);
	...
}

Those call_rcu()s are queued during afs_net_exit(), i.e. in the .exit phase
after the core's intermediate synchronize_rcu(), and nothing waits for them.
When the callback finally runs:

net/rxrpc/peer_object.c:__rxrpc_put_peer() {
	struct rxrpc_net *rxnet = peer->local->rxnet;
	...
	spin_lock_bh(&rxnet->peer_hash_lock);
	hash_del_rcu(&peer->hash_link);
	...
}

Can this write into the already-freed rxrpc_net block? Calls and connections
are covered by bias counters plus wait_var_event(&rxnet->nr_calls) and
wait_var_event(&rxnet->nr_conns), but there is no equivalent drain for peer
references held outside calls and conns. Would a peer bias counter plus
wait, or a barrier, be needed to close this?

>  
>  /**

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907222242.3361174-2-elver%40google.com
