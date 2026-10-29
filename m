Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793248063;
	b=HhLKQvTTK+aWoJkvvcZt5HKwWDznzcVLcgdUYZlbG6T9JeuziQFMOeruvEB1XKd5nKKx
	 zVeFl31okF71tRKcypqpLo97OniOTMhA7trSfLAYN4rfOM86iEWnWdAosbLo6tnic/eu8
	 K18M9f6KUYiv61GNAu2q/mMR51MqvZT9PFR55gJkt6i71Uk17vJOq2aj7Vx3xC60IP8Dm
	 crypJNWDVcWVIB5GSaKKpmo99WqnPJ/1SDZAaqnhszIqb+MuxwCVnqwowK0oE7evYwuAK
	 G9b5TC2OaafCwAsq0WjrCpXRfMC+sfK8LPzMB3DAFAucysqZrGvSx5jaMmrv1jiLK8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248063;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gqcoFML3qBTs9MfGY/GKJJpvF3WSMHHzWY7jOjJgKRo=;
	b=fp5Q1VVewkgZ6hl2NCoJB/Rd5HIdXmQBS9cXmRSE6uxU2lAgTThiTxH4/SW3rZ1lTjNe
	 uLgXa2ymomlfn92aD9qh0J7Pyn/Zr+HrKktFPrBREZ6HaeRiKzpM6fxR8r+iimEzfmoEI
	 VuaBiic95lwM10qun5kmZBHk3MJG2yENaBMFVwtlG1Pd+XEhZlN4IZ1+dj7F4m1Km/xZ5
	 937XEsiZMJFGdEtiqHHi2L7upDeQsZeBjLSVzG7kJmUI7E7zGOyNm6Vspv3XNw/yXsX+m
	 ieLNMVGvqJoYuogZwH9nT6N5RbVC9z7mvLP+UTHpXdyEoSFpwgVpMAfWhJ8RzNMRFBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQ9+ON2G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96A60A2607
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQ9+ON2G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7E61F01825;
	Thu, 29 Oct 2026 04:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793248062;
	bh=gqcoFML3qBTs9MfGY/GKJJpvF3WSMHHzWY7jOjJgKRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mQ9+ON2GZB6K1sWuJR3AZ4H2hqmVd7B1rfHHvn6lpuTVwSIIph3k/n5C0dwxqMewh
	 ZCTqEU+A7zsT/igN9Ze6toiyCJej3ujNl8wKhEAofMFRZtsSQoNnDJEf/EW4aERFn/
	 yfRzRYY2ckrqt7dppiP1c7VjpSv2pU4IGo4e49M7dNqvkuEy/ng0rsFdc6vG7LFdqP
	 J1Gsmo71vPjLd6cOxzrjGo9yWNYfQJKXt/W1cILyc0GeK6kGyMEkSct2mANeXTtbPA
	 KiAoHmPk0yhb3k/goEC0k38mfYK/54kXqhpBybcrZYdHNap8V4L/utuDt7WaiM8Zq0
	 qo3ePmGBRTn5Q==
Subject:
 Re: [PATCH net 2/2] tipc: fix NULL pointer dereference in named_distribute()
From: netdev-bot+sashiko@kernel.org
To: tung.quang.nguyen@est.tech
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net,
 syzbot+64197f7577a09686ffdb@syzkaller.appspotmail.com
Date: Thu, 29 Oct 2026 04:27:41 +0000
Message-ID: <179324806118.3134.17988237576778799130@kernel.org>
In-Reply-To: <20261028033722.125477-3-tung.quang.nguyen@est.tech>
References: <20261028033722.125477-3-tung.quang.nguyen@est.tech>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 3 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The fix is incomplete: a TIPC peer can still trigger the
  NULL dereference in named_distribute() (buf_msg(skb_peek_tail(list))…
- [Medium] The commit message lists "three major changes", all internal
  refactoring.
- [Medium] The new deferred-bulk flag n->dist_bulk can go stale and cause
  a second bulk distribution within one node session.
- [Medium] tipc: race in tipc_net_finalize() causes self-node publish to
  fail with -EEXIST
- [Low] The comment on the tn->nt_stop check in __tipc_named_distribute()
  says it protects against the name table having been deleted at…
- [Low] The new comment in tipc_service_delete() (net/tipc/name_table.c)
  says "tipc_nametbl_withdraw() does not delete 'p->binding_node' with…

Pre-existing issues:
- [Medium] tipc_named_reinit(), called from tipc_net_finalize(), sets
  nt->rc_dests = 0 unconditionally.
- [Medium] tipc_node_distribute() can leak SKBs, and the new timer path
  tipc_named_distribute() now reaches it too.

--

tipc: fix NULL pointer dereference in named_distribute()

This patch fixes a syzbot-reported NULL dereference in named_distribute().
The cause is a race between tipc_net_finalize() and the node-up bulk
distribution. The patch inserts the node's self-address TIPC_NODE_STATE
publication on demand from node-up or the node timer. It defers the bulk to
the node timer when the address is not set yet, and it adds error
propagation for allocation failures.

Closes: https://syzkaller.appspot.com/bug?extid=64197f7577a09686ffdb

> To facilitate the implementation, three major changes are made:
> - Move the sc->lock acquisition out of tipc_service_insert_publ() and into its
>   callers.
> - Add an output parameter (*err) to tipc_nametbl_publish() to detect memory
>   allocation errors.
> - Add three fields (nt_stop, nt_self_node_exist, and node_addr_set) to struct
>   tipc_net to synchronize the insertion and deletion of the node's self-address
>   publication.

[Severity: Medium]

These three items read as internal refactoring. The patch also changes
behaviour in several ways that the commit message does not mention. Should
these be described, or split into separate patches?

tipc_update_nametbl() now drops every peer PUBLICATION or WITHDRAWAL of
type TIPC_NODE_STATE whose range equals our address. It also logs "Can't
update duplicate node-up pub".

In tipc_node_write_unlock(), -ENOBUFS from tipc_named_node_up() now takes
down every link to the peer through the new tipc_node_down(). In the
parent commit ("tipc: fix self-deadlock in tipc_named_node_up") it only
called tipc_node_link_down(n, bearer_id, false).

An allocation failure while publishing the node-scope TIPC_LINK_STATE
binding on LINK_UP used to be ignored. It now forces that link down, which
seems unrelated to the named_distribute() race.

tipc_node_timeout() now forces every link to the peer down when the
deferred bulk redistribution returns -ENOBUFS.

Separately, can this new branch in tipc_nametbl_publish() ever run?

	if (!skb && p->scope == TIPC_CLUSTER_SCOPE && err)
		*err = -ENOBUFS;

The only caller that passes a non-NULL err is tipc_node_write_unlock(), and
it publishes TIPC_LINK_STATE with TIPC_NODE_SCOPE. tipc_net_finalize() and
tipc_sk_publish() both pass NULL.

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index a60f213ed1182..345bd767983e9 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c

[ ... ]

> @@ -191,6 +197,94 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
>  	hdr = buf_msg(skb_peek_tail(list));
>  	msg_set_last_bulk(hdr);
>  	msg_set_named_seqno(hdr, seqno);
> +
> +	return 0;
> +}

[ ... ]

> +static int __tipc_named_distribute(struct net *net, u32 dnode,
> +				   struct sk_buff_head *head)
> +{
> +	struct name_table *nt = tipc_name_table(net);
> +	struct tipc_net *tn = tipc_net(net);
> +
> +	/* Name table has been deleted after namespace teardown or
> +	 * TIPC module exit.
> +	 */
> +	if (unlikely(tn->nt_stop))
> +		return 0;

[Severity: Low]

Can this check protect against a deleted name table? tipc_named_node_up()
already dereferences nt before __tipc_named_distribute() reads nt_stop:

	if (!(capabilities & TIPC_NAMED_BCAST))
		nt->rc_dests++;
	rc = __tipc_named_distribute(net, dnode, &head);

The scenario also does not look reachable. tipc_exit_net() runs
tipc_net_stop() first, which goes through
tipc_node_stop()->tipc_node_delete()->timer_delete_sync(). It then runs
cancel_work_sync(&tn->work), and only after that tipc_nametbl_stop().
tipc_nametbl_stop() sets nt_stop just before kfree_rcu(nt).

The only other caller of tipc_nametbl_stop() is the tipc_init_net() error
path, and no nodes exist at that point.

Is nt_stop needed at all? The commit message says it helps to "synchronize
the insertion and deletion of the node's self-address publication", which
does not seem accurate either.

> +
> +	/* Node's self-address is not set yet */
> +	if (!atomic_read(&tn->node_addr_set)) {
> +		/* Defer the distribution to node's timer */
> +		tipc_node_set_dist_bulk(net, dnode);
> +		return 0;
> +	}

[ ... ]

> +int tipc_named_distribute(struct net *net, u32 dnode)
> +{
> +	struct tipc_net *tn = tipc_net(net);
> +	struct sk_buff_head head;
> +	int bearer_id = 0;
> +	int rc = 0;
> +
> +	__skb_queue_head_init(&head);
> +	spin_lock_bh(&tn->nametbl_lock);
> +	rc = __tipc_named_distribute(net, dnode, &head);
> +	if (!rc && !skb_queue_empty(&head))
> +		rc = tipc_node_distribute(net, &head, dnode, &bearer_id, 0);

[Severity: Medium]

This is a pre-existing issue, not introduced by this patch, but the new
timer path through tipc_named_distribute() now reaches it as well. Can
tipc_node_distribute() leak skbs on its local xmitq?

When tipc_link_xmit() sends a multi-packet bulk, earlier packets may
already be cloned onto xmitq when a later skb_clone() fails:

	_skb = skb_clone(skb, GFP_ATOMIC);
	if (!_skb) {
		kfree_skb(skb);
		__skb_queue_purge(list);
		return -ENOBUFS;
	}

tipc_node_distribute() then skips the transmit and never purges xmitq:

	if (likely(rc != -ENOBUFS))
		tipc_bearer_xmit(net, *bearer_id, &xmitq, &maddr, n);

	tipc_node_put(n);

tipc_node_xmit() had the same pattern, and tipc_named_node_up() used it
before. tipc_node_distribute() was copied from it in the preceding commit
"tipc: fix self-deadlock in tipc_named_node_up".

> +	spin_unlock_bh(&tn->nametbl_lock);

[ ... ]

> @@ -426,5 +531,6 @@ void tipc_named_reinit(struct net *net)
>  	list_for_each_entry_rcu(p, &nt->cluster_scope, binding_node)
>  		p->sk.node = self;
>  	nt->rc_dests = 0;
> +	tn->nt_stop = false;
>  	spin_unlock_bh(&tn->nametbl_lock);
>  }

[Severity: Medium]

This is a pre-existing issue, not introduced by this patch. The patch now
explicitly supports node-up before finalize, though, so it seems relevant
here.

tipc_net_finalize() calls tipc_named_reinit(), which resets nt->rc_dests to
0 unconditionally. That wipes out the increment tipc_named_node_up() has
already made for any peer without TIPC_NAMED_BCAST that came up before
finalize:

tipc_named_node_up()
  nt->rc_dests++;
  __tipc_named_distribute()
    tipc_node_set_dist_bulk()     <- only the bulk is deferred
...
tipc_net_finalize()
  tipc_named_reinit()
    nt->rc_dests = 0;

Would later publications then see rc_dests == 0 and go out over the
broadcast link? Legacy peers do not accept name distribution that way.

When such a peer goes down, tipc_publ_notify() does nt->rc_dests--, which
wraps the u32 to 0xFFFFFFFF. tipc_node_broadcast() receives that as int -1
and stays in replicast from then on.

> diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
> index 8924bdb6a443f..3bcb8762bc9cc 100644
> --- a/net/tipc/name_table.c
> +++ b/net/tipc/name_table.c

[ ... ]

> +int tipc_nametb_insert_self_node_pub(struct net *net)
> +{

[ ... ]

> +	spin_lock_bh(&sc->lock);
> +	sr = tipc_service_find_range(sc, &ua);
> +	/* 1. tipc_net_finalize_work() is not scheduled because of namespace
> +	 *    teardown.
> +	 * 2. Or tipc_net_finalize() ---> tipc_nametbl_publish() has failed
> +	 *    to insert node self address publication into nt->cluster_scope
> +	 *    due to memory allocation failure.
> +	 * 3. Or tipc_net_finalize() ---> tipc_nametbl_publish() has not
> +	 *    executed yet.
> +	 */
> +	if (!sr) {

[ ... ]

> +exit:
> +	spin_unlock_bh(&sc->lock);
> +	return 0;
> +}

[Severity: Medium]
Is there a window between setting node_addr_set and the
tipc_nametbl_publish() call that follows it? node_addr_set is written
here without tn->nametbl_lock, but __tipc_named_distribute() reads it
under that lock. A node-up, or the node timer, can run in between. That
could be on another CPU, or in softirq on this one. It then does the
self-node insert first:

CPU0                          CPU1
tipc_net_finalize()
  atomic_set(node_addr_set)
                              tipc_named_node_up() or
                              tipc_node_timeout()
                                __tipc_named_distribute()
                                  tipc_nametb_insert_self_node_pub()
                                  tn->nt_self_node_exist = true;
                                  named_distribute()  <- dnode only
  tipc_nametbl_publish()
    tipc_nametbl_insert_publ()
      tipc_service_insert_publ()  <- duplicate, -EEXIST

tipc_nametb_insert_self_node_pub() builds the publication with the same
key, sk.ref and sk.node that tipc_net_finalize() passes. The duplicate
check in tipc_service_insert_publ() therefore rejects the second insert.
That prints the non-ratelimited "Failed to bind to" pr_warn() for what
is really an expected race. tipc_nametbl_publish() then returns NULL
without calling tipc_named_publish() or tipc_node_broadcast().

In that case the TIPC_NODE_STATE binding reaches only dnode, through
its bulk. Peers that are already up never get the broadcast that
finalize normally sends. They depend on their own deferred dist_bulk
being processed later. Is that intended?

The new comment above the call says the publication is redistributed
if tipc_nametbl_publish() fails. The -EEXIST case is not really a
failure, though, and it still warns.

Would it work to set node_addr_set only after tipc_nametbl_publish()
has returned? Alternatively, tipc_net_finalize() could insert the
publication under tn->nametbl_lock and set nt_self_node_exist there, so
both paths agree on which one owns the insert.

[Severity: Critical]

Can a [self,self] TIPC_NODE_STATE range that holds only a peer's entry make
this function return 0 without adding anything to nt->cluster_scope? The
function only checks that the range exists. It does not check that the
range holds this node's own publication, or that anything is linked on
nt->cluster_scope.

The new filter in tipc_update_nametbl() is skipped while tn->node_addr is
still 0:

	if (unlikely(type == TIPC_NODE_STATE && tn->node_addr &&
		     lower == tn->node_addr && upper == tn->node_addr)) {

During the address trial, tipc_disc_addr_trial_msg() schedules tn->work but
lets link setup continue while self == 0. The peer can see our trial
address, because we put it in prevnode in our discovery messages.
tipc_named_rcv() takes node = msg_orignode(hdr) without checking it against
the link peer.

So a peer could send an item like {type=TIPC_NODE_STATE,
lower=upper=trial_addr, port=0, key=trial_addr} with orignode=trial_addr.
orignode=0 would also work, because the !_p->sk.node test in
tipc_service_insert_publ() treats it as a wildcard. The sequence would then
be:

tipc_net_finalize()
  atomic_set(&tn->node_addr_set, 1);
  tipc_nametbl_publish(net, &ua, &sk, addr, NULL)
    tipc_service_insert_publ()   <- duplicate, -EEXIST, ignored

tipc_named_node_up() or tipc_node_timeout()->tipc_named_distribute()
  __tipc_named_distribute()
    tipc_nametb_insert_self_node_pub()   <- range found, returns 0
    tn->nt_self_node_exist = true;
    named_distribute(net, head, dnode, &nt->cluster_scope, ...)
      hdr = buf_msg(skb_peek_tail(list));   <- list is empty

With no cluster-scope user bindings, nt->cluster_scope is empty at this
point. The topology server binds with TIPC_NODE_SCOPE, so it does not add
anything. Would this hit the same NULL dereference in buf_msg() that the
patch sets out to fix, in softirq or timer context?

Even with an honest orignode, a planted [self,self] range still makes this
helper skip the insert. That reopens the window between
atomic_set(&tn->node_addr_set, 1) and tipc_nametbl_publish() in
tipc_net_finalize().

Would it be safer to check that our own publication is actually on
nt->cluster_scope? It might also help to have named_distribute() handle an
empty list, for example by returning early when skb_peek_tail(list) is
NULL.

[ ... ]

> @@ -940,6 +1043,15 @@ static void tipc_service_delete(struct net *net, struct tipc_service *sc)
>  	rbtree_postorder_for_each_entry_safe(sr, tmpr, &sc->ranges, tree_node) {
>  		list_for_each_entry_safe(p, tmp, &sr->all_publ, all_publ) {
>  			tipc_service_remove_publ(sr, &p->sk, p->key);
> +			/* tipc_nametbl_withdraw() does not delete
> +			 * 'p->binding_node' with type TIPC_NODE_STATE and
> +			 * range [tn->node_addr, tn->node_addr] from
> +			 * 'tn->cluster_scope'. So, delete it here.
> +			 */

[Severity: Low]

Is this comment accurate? tipc_nametbl_withdraw() calls
tipc_named_withdraw() for each publication it removes, and
tipc_named_withdraw() begins with an unconditional:

	list_del(&p->binding_node);

The self-node publication is still linked here only because nothing ever
withdraws it. tipc_net_stop() just calls tipc_bearer_stop() and
tipc_node_stop().

cluster_scope is also a member of struct name_table, not struct tipc_net,
so 'tn->cluster_scope' should probably read 'nt->cluster_scope'.

If a later change follows this comment and adds a withdraw call, would this
list_del() then remove the same entry twice?

> +			if (p->sr.type == TIPC_NODE_STATE &&
> +			    p->sr.lower == tn->node_addr &&
> +			    p->sr.upper == tn->node_addr)
> +				list_del(&p->binding_node);
>  			kfree_rcu(p, rcu);
>  		}

[ ... ]

> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index b19d6652dc731..f566472a411fc 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c

[ ... ]

> @@ -420,6 +430,8 @@ static void tipc_node_write_unlock(struct tipc_node *n)
>  	n->action_flags &= ~(TIPC_NOTIFY_NODE_DOWN | TIPC_NOTIFY_NODE_UP |
>  			     TIPC_NOTIFY_LINK_DOWN | TIPC_NOTIFY_LINK_UP);
>  
> +	if (flags & TIPC_NOTIFY_NODE_DOWN)
> +		n->dist_bulk = false;
>  	write_unlock_bh(&n->lock);

[ ... ]

> +void tipc_node_set_dist_bulk(struct net *net, u32 addr)
> +{
> +	struct tipc_node *node;
> +
> +	node = tipc_node_find(net, addr);
> +	if (node) {
> +		tipc_node_write_lock(node);
> +		node->dist_bulk = true;
> +		tipc_node_write_unlock_fast(node);
> +		tipc_node_put(node);
> +	}
> +}

[Severity: Medium]

Can n->dist_bulk go stale and trigger a second bulk within one node
session?

tipc_node_write_unlock() clears the flag on TIPC_NOTIFY_NODE_DOWN under
n->lock. tipc_named_node_up() runs only after that lock is dropped, and
tipc_node_set_dist_bulk() sets the flag without checking whether the node
has gone down in the meantime:

CPU0                                  CPU1
tipc_node_write_unlock() (NODE_UP)
  write_unlock_bh(&n->lock);
                                      link failure, NODE_DOWN
                                        n->dist_bulk = false;
  tipc_named_node_up()
    __tipc_named_distribute()
      node_addr_set == 0
      tipc_node_set_dist_bulk()
        node->dist_bulk = true;

Suppose the peer comes back after finalize has set node_addr_set. The new
NODE_UP sends a normal bulk right away. Later the node timer finds the
stale flag and sends a second one.

tipc_node_timeout() has a similar window. It reads and clears the flag
under n->lock, but calls tipc_named_distribute() after unlocking without
checking again.

On the receiver, tipc_named_dequeue() advances rcv_nxt to the extra bulk's
seqno and drops queued messages with a lower seqno:

	if (msg_is_last_bulk(hdr)) {
		*rcv_nxt = seqno;
		*open = true;
	}
	...
	if (less(seqno, *rcv_nxt)) {
		__skb_unlink(skb, namedq);
		kfree_skb(skb);

Could a withdrawal that has not been applied yet be lost this way, leaving
a stale binding on the peer? The duplicate items would also trigger the
non-ratelimited pr_warn() in tipc_service_insert_publ().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028033722.125477-1-tung.quang.nguyen%40est.tech
