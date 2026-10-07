Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897D3B8D7B
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393740; cv=none; b=BkiIi15nQNW+HRxUc3qjIhMg3mWK66bdSRMvcCp6xD09R7EW7hoQAmaxleUPTD56SoyZAyQkTFjMlJLC2SjvpRWj/zoWV+IzcBHUjkFg9A02WAt5b9Mncw1BkCQVGhGdCs3HA95O0TlJjE3q8d8WpzHYwlAfo44KEbQOshup7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393740; c=relaxed/simple;
	bh=fF13zH/JIhgf6GfHiSIVZb3oexzCs01vgNGhZLHQSPA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWRDMJ5hFGOtXCKYR3ax9xuUSFoEaQKBpPyiP0eirtYrz/ReB/y9HfTZJ0T+ycBo0fVTxbr9jPUMGEOlXJ7eDNV3FL3oxSKqglfZecxHT7+XRYXaM43Tw1Va2rH9mK1KnKNPDKYaecNGvDcu6fT635lbMshfWTQqZcCSVwSvf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBLZ+xga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBLZ+xga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBC61F000FF;
	Wed,  7 Oct 2026 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791393738;
	bh=9sUz2oR+IMYh+0s++Riluyd1PBaCGKVUoHsgZePApLs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kBLZ+xgaZCICLy6o3XEazsNxD/W+GxSlb0ofJ05rGzgZY5xDAR8Ar5azyza9ugy2c
	 YhaGUvEW5sY8iOSb1Wa8zX37WVCqdx/yoTGzwdMmSyAtx9SIj1js+xecQCDxMiDeK4
	 wq9aFBzQ+2Q2pChMG4Sfy381Zvbw72pJuTjFLoqjZCOOA4ISZZaKnpYY/dLyL56+bm
	 8WUoo0YQTaGhZKb/BVTuTSbt9DpX44DyX8sxPB0T1ChqcWcg+/VcRw1zyzDLgW3pCU
	 gJRwG2jzjrXd0QbkX8rF88ZVOUfLcUijou1Lcm0eOrsoVpbfyX/gcRveeg1gB4a7m2
	 6GFhtd5LY7Rdw==
Subject: Re: [PATCH net v2] tipc: fix several race conditions caused by
 tipc_node_write_unlock()
From: netdev-bot+sashiko@kernel.org
To: tung.quang.nguyen@est.tech
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, nicoyip.dev@gmail.com, lkp@intel.com
Date: Wed, 07 Oct 2026 17:22:17 +0000
Message-ID: <179139373734.434549.8409205365763100703@kernel.org>
In-Reply-To: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
References: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 (1) · High: 1 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch changes which node's publ_list a remote publication
  goes on, but does not check that the message's orignode matches that…
- [Medium] Moving tipc_node_xmit() out of tipc_named_node_up() means the
  bulk snapshot for a new peer is no longer sent atomically with respect…
- [Low] The first race in the commit message does not match the code.
- [Low] The patch edits the kernel-doc for tipc_update_nametbl() and
  tipc_named_rcv() to add @publ_list but leaves the locking contract…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the patch
  rewrites the affected call and changes how it fails.
- [High] named_distribute() dereferences NULL when nt->cluster_scope is
  empty.

--

tipc: fix several race conditions caused by tipc_node_write_unlock()

This commit keeps the node write lock held while tipc_node_write_unlock()
handles link and node up/down events. It also moves publ_list locking out
of tipc_node_subscribe()/tipc_node_unsubscribe() and into the callers of
tipc_named_rcv(). Name distribution messages built under the lock are now
sent after the lock is dropped.

Closes: https://lore.kernel.org/netdev/20261001182924.3928331-2-nicoyip.dev@gmail.com/
Closes: https://lore.kernel.org/netdev/20261001182924.3928331-3-nicoyip.dev@gmail.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202610060355.bPzTfoXZ-lkp@intel.com/

> - A race between link-up and link-down events can occur when the
> link-down thread is interrupted before removing a publication from
> nt->cluster_scope, and the link-up event inserts a publication into
> nt->cluster_scope.

[Severity: Low]
Is this description accurate? tipc_node_write_unlock() builds the
link-state publication with node scope:

	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_NODE_SCOPE,
		   TIPC_LINK_STATE, n->addr, n->addr);

tipc_named_publish() puts node scope publications on nt->node_scope, not
on nt->cluster_scope:

	if (p->scope == TIPC_NODE_SCOPE) {
		list_add_tail_rcu(&p->binding_node, &nt->node_scope);
		return NULL;
	}

The insert in tipc_nametbl_publish() and the removal in
tipc_nametbl_withdraw() also both run under tn->nametbl_lock.

Releasing the node lock early could reorder link-up and link-down
handling and leave a stale link-state entry in node_scope. That looks
different from the cluster_scope use-after-free described here.

Could the commit message describe the race that change 1 actually
addresses?

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b7..dcb15de42a9ee 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c

[ ... ]

> @@ -218,8 +218,7 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
>  	spin_unlock_bh(&tn->nametbl_lock);
>  
>  	read_lock_bh(&nt->cluster_scope_lock);
> -	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
> -	tipc_node_xmit(net, &head, dnode, 0);
> +	named_distribute(net, xmitq, dnode, &nt->cluster_scope, seqno);
>  	read_unlock_bh(&nt->cluster_scope_lock);
>  }

[Severity: Medium]
Can a withdrawal now overtake the bulk that is sent to a newly up peer?

Before this change, cluster_scope_lock was held for reading across both
named_distribute() and tipc_node_xmit(). tipc_named_withdraw() needs the
write side of that lock for list_del(&p->binding_node). So a withdrawal
either happened before the snapshot, or its WITHDRAWAL was built after
the bulk was already queued on the link.

Now the lock is dropped right after named_distribute(), and
tipc_node_write_unlock() sends the bulk only after the node lock is
released:

	write_unlock_bh(&n->lock);

	if (!skb_queue_empty(&xmitq))
		tipc_node_xmit(net, &xmitq, node, 0);

One possible ordering:

CPU0 (link up)
tipc_node_write_unlock()
  tipc_named_node_up()
    named_distribute()          <- publication P copied into bulk B
    read_unlock_bh(&nt->cluster_scope_lock)

CPU1 (unbind or close)
tipc_sk_withdraw()
  tipc_nametbl_withdraw()
    tipc_named_withdraw()       <- P removed, WITHDRAWAL W built
  tipc_node_broadcast()
    tipc_node_xmit_skb()
      tipc_node_xmit()          <- waits in tipc_node_read_lock(n)

CPU0
  write_unlock_bh(&n->lock)     <- CPU1 now enqueues W
  tipc_node_xmit(&xmitq)        <- B enqueued after W

In replicast mode, tipc_node_broadcast() already sends W to the new peer,
because node_is_up(n) is already true. Replicast mode means rc_dests > 0,
which tipc_named_node_up() itself sets for a peer without
TIPC_NAMED_BCAST, or BCLINK_MODE_RCAST. Both messages use selector 0.

The peer would treat W as a no-op and then install P from B. That leaves
a stale binding to a port that no longer exists until this node goes
down. A peer with TIPC_NAMED_BCAST could be affected the same way when
its bc_entry.named_open is stale.

[ ... ]

> @@ -272,12 +270,14 @@ void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
>   * @i: location of item in the message
>   * @node: node address
>   * @dtype: name distributor message type
> + * @publ_list: list of remote publications of a specific node
>   *
>   * tipc_nametbl_lock must be held.
>   * Return: the publication item if successful, otherwise NULL.
>   */
>  static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
> -				u32 node, u32 dtype)
> +				u32 node, u32 dtype,
> +				struct list_head *publ_list)

[Severity: Low]
This isn't a bug, but tipc_node_subscribe() and tipc_node_unsubscribe()
are now just list_add_tail() and list_del_init(). The only thing
protecting publ_list is the caller holding the owning node's write lock.

Should this comment, and the new @publ_list text for tipc_named_rcv(),
state that requirement as well as tipc_nametbl_lock?

The Return: line in this block also describes a publication pointer,
but tipc_update_nametbl() is declared bool.

>  {
>  	struct publication *p = NULL;
>  	u32 lower = ntohl(i->lower);
> @@ -301,13 +301,13 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
>  	if (dtype == PUBLICATION) {
>  		p = tipc_nametbl_insert_publ(net, &ua, &sk, key);
>  		if (p) {
> -			tipc_node_subscribe(net, &p->binding_node, node);
> +			tipc_node_subscribe(&p->binding_node, publ_list);
>  			return true;
>  		}
>  	} else if (dtype == WITHDRAWAL) {
>  		p = tipc_nametbl_remove_publ(net, &ua, &sk, key);
>  		if (p) {
> -			tipc_node_unsubscribe(net, &p->binding_node, node);
> +			tipc_node_unsubscribe(&p->binding_node);
>  			kfree_rcu(p, rcu);
>  			return true;
>  		}

[Severity: High]
Is publ_list guaranteed to belong to the node that the item names?

tipc_named_rcv() takes node from the message header:

	node = msg_orignode(hdr);

But publ_list is &n->publ_list of the node that tipc_rcv() or
tipc_node_bc_rcv() found via msg_prevnode() (or destnode). That is also
the node whose lock is held:

	tipc_node_write_lock(n);
	tipc_named_rcv(net, &n->bc_entry.namedq,
		       &n->publ_list,
		       ...

Nothing compares orignode with n->addr. tipc_data_input() also queues
NAME_DISTRIBUTOR messages to namedq without checking it.

Before this patch, tipc_node_subscribe() and tipc_node_unsubscribe() looked
up the node by orignode and took that node's lock. A publication with
sk.node == Y was therefore always on Y->publ_list and only changed under
Y->lock.

Now a peer N can send a WITHDRAWAL with orignode == Y. It can learn the
type, range, port and key of Y's publications from normal name
distribution. tipc_nametbl_remove_publ() then matches Y's publication,
and list_del_init() unlinks it from Y->publ_list while only N->lock and
nametbl_lock are held.

Can that race with a node-down walk of Y->publ_list?

CPU0
tipc_node_write_unlock(Y)          <- holds Y->lock, NODE_DOWN set
  tipc_publ_notify(&Y->publ_list)
    list_for_each_entry_safe(publ, tmp, ...)
      tipc_publ_purge(publ)        <- nametbl_lock per entry only

CPU1
tipc_rcv(N)                        <- holds N->lock only
  tipc_named_rcv(&N->publ_list)
    tipc_update_nametbl(WITHDRAWAL, node = Y)
      list_del_init(&tmp->binding_node)

If the unlinked entry is CPU0's saved tmp, it now points to itself. Then
tipc_publ_purge(tmp) finds nothing and the loop never ends, with BH
disabled and Y->lock held for write.

This looks like the same publ_list race that the commit message says is
fixed.

With in_own_node() removed, a PUBLICATION whose orignode is the local
address or 0 is also linked onto the peer's publ_list now.

Could n->addr be passed down so that items whose orignode does not match
it are dropped?

[ ... ]

> diff --git a/net/tipc/net.c b/net/tipc/net.c
> index 7e65d0b0c4a8d..1e445c5abc0f5 100644
> --- a/net/tipc/net.c
> +++ b/net/tipc/net.c

[ ... ]

> @@ -138,7 +140,9 @@ static void tipc_net_finalize(struct net *net, u32 addr)
>  	tipc_named_reinit(net);
>  	tipc_sk_reinit(net);
>  	tipc_mon_reinit_self(net);
> -	tipc_nametbl_publish(net, &ua, &sk, addr);
> +	tipc_nametbl_publish(net, &ua, &sk, addr, &skb, &rc_dests);
> +	if (skb)
> +		tipc_node_broadcast(net, skb, rc_dests);
>  }

[Severity: High]
This is a pre-existing issue, but what happens if tipc_nametbl_publish()
returns NULL here? That can happen when the GFP_ATOMIC allocation in
tipc_publ_create() fails.

At that point the node address has already been set by cmpxchg() and
tipc_set_node_addr(). The cluster scope TIPC_NODE_STATE binding is what
normally keeps nt->cluster_scope non-empty.

If there are no user cluster scope bindings, named_distribute() then
runs on an empty list when the first peer comes up:

tipc_node_write_unlock()
  tipc_named_node_up()
    named_distribute()

It still does this unconditionally:

	hdr = buf_msg(skb_peek_tail(list));

skb_peek_tail() returns NULL for an empty queue, so buf_msg() would
dereference NULL. The new skb_queue_empty(&xmitq) check in
tipc_node_write_unlock() runs after this point and does not help.

> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index d7cbfa786c132..182c6dbfa49d2 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c

[ ... ]

> @@ -653,40 +659,14 @@ void tipc_node_stop(struct net *net)

[ ... ]

> -void tipc_node_unsubscribe(struct net *net, struct list_head *subscr, u32 addr)
> +void tipc_node_unsubscribe(struct list_head *subscr)
>  {
> -	struct tipc_node *n;
> -
> -	if (in_own_node(net, addr))
> -		return;
> -
> -	n = tipc_node_find(net, addr);
> -	if (!n) {
> -		pr_warn("Node unsubscribe rejected, unknown node 0x%x\n", addr);
> -		return;
> -	}
> -	tipc_node_write_lock(n);
>  	list_del_init(subscr);
> -	tipc_node_write_unlock_fast(n);
> -	tipc_node_put(n);
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but removing in_own_node()
changes how it plays out. Can a peer free a local publication by sending
a WITHDRAWAL with orignode set to 0 or to our own address?

tipc_service_remove_publ() treats node 0 as a wildcard and does not check
scope:

	if (p->key != key || p->sk.ref != sk->ref ||
	    (node && node != p->sk.node))
		continue;

The type, range, port and key of cluster scope publications are known
from normal name distribution. So tipc_update_nametbl() can kfree_rcu() a
publication owned by a local socket. Its p->binding_sock stays on
tsk->publications, and nt->local_publ_count is not decremented.

After the grace period, tipc_sk_withdraw() on unbind or close walks
tsk->publications and reads the freed p->scope and p->sr. In addition,
list_add(&p->binding_sock, &tsk->publications) in tipc_sk_publish()
writes into the freed neighbour.

Before this patch, in_own_node() made tipc_node_unsubscribe() return
early, so p->binding_node stayed on nt->cluster_scope after the free.
Without that check, list_del_init() now removes it from nt->cluster_scope
(or from the RCU list nt->node_scope) without cluster_scope_lock and
without list_del_rcu(). That races with named_distribute() and with
tipc_named_publish()/tipc_named_withdraw().

Should orignode be validated before these items are applied to the name
table?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006052312.30382-1-tung.quang.nguyen%40est.tech
