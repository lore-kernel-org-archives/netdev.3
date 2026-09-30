Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4A155757;
	Wed, 30 Sep 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727010; cv=none; b=lHdmyQqufLrpyBDA+m40lHkgGJ99jhPGDZWP7wToPyI3HUwsGXW/Niw+PEVxHgrWcWISPT6GOehQX6iA4tjxuh52Jrk8h4/oMg7WczWiaTWWfKn8DsFkzzOXTlc3WugLCu2MOu5SGk7gqZkprH3OHT77U+E5BTXkED3irdZGn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727010; c=relaxed/simple;
	bh=urY5D1HirS61bTqNbWq1zzLFEJqBSnKxu9gGCuOOFao=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYG+QlYjQ70ON25HLX6sY+uKJ7voTQJ4QHaVZJ/LRHqxLrtQsYDv/ZV0qxn9KohNsMIF66UPWzb74v8qJEbRe1CeG+0U0BwzU/CknG/bUqGxmuSm7v3Xj/zhNqRDjTi9UgOwAhmqlhOfBs8QmRPpuMlyhjdIA+taA1qK1HugAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QignthsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QignthsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E207B1F00898;
	Wed, 30 Sep 2026 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727008;
	bh=KCXS6h+NhVE7z+sy2gU3aqTsRZPsF2DtMF11cLtX3b0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QignthsMheH93/gtuFt2IkBKsVlTUACEPA8cx6vbFa3akYwSxQd4dIBTRWBOYTlch
	 XwMjGNoteeMU5WsV6ncbYsG6z11Mo5grW1fJguZSCUtUmwCK2jo6ISLtRq8eNygzzO
	 mkIPL3Y9COYWjvRmzxf8P630aIXPTdRANqkG34mKw58zcMrFxL5XHjr/Vlv7oMqC3i
	 D2lm5cDKRUD0/S1HXPpVCIYZAxZ5UHAMvPQZMItrMxSMs6fjMoVAjBvl0tary6IeKz
	 Evhcg3a+B+DCk/vA4RFl/syXcW9wsxC4Ao3nlzfz2Y9N4rH6rWxM/o1blo8nE2CAOp
	 JiX5cuBeDL5rw==
Subject:
 Re: [PATCH net] tipc: serialize publication purging with name table updates
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 00:10:07 +0000
Message-ID: <179072700746.434549.6689367628938134483@kernel.org>
In-Reply-To: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
References: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In tipc_update_nametbl() (net/tipc/name_distr.c), the
  WITHDRAWAL branch frees a publication with kfree_rcu(p, rcu) whether…

--

tipc: serialize publication purging with name table updates

This patch changes tipc_publ_notify() so that it moves a failed node's
publications onto a private on-stack list while holding nametbl_lock. It
then unlinks and purges them one at a time, taking and releasing the lock
for each entry. The addr argument is dropped from tipc_publ_notify() and
tipc_publ_purge() because the unlink no longer needs a node lookup.

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b7..34867b69044c0 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c
> @@ -227,38 +227,50 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)

[ ... ]

>  void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
> -		      u32 addr, u16 capabilities)
> +		      u16 capabilities)
>  {
>  	struct name_table *nt = tipc_name_table(net);
>  	struct tipc_net *tn = tipc_net(net);
>  
> -	struct publication *publ, *tmp;
> +	struct publication *publ;
> +	LIST_HEAD(purge_list);
> +
> +	spin_lock_bh(&tn->nametbl_lock);
> +	/* Leave new publications on the node's list during the purge. */
> +	list_splice_init(nsub_list, &purge_list);
> +	spin_unlock_bh(&tn->nametbl_lock);
> +
> +	for (;;) {
> +		spin_lock_bh(&tn->nametbl_lock);
> +		if (list_empty(&purge_list)) {
> +			spin_unlock_bh(&tn->nametbl_lock);
> +			break;
> +		}
> +		publ = list_first_entry(&purge_list, struct publication,
> +					binding_node);
> +		list_del_init(&publ->binding_node);
> +		tipc_publ_purge(net, publ);
> +		spin_unlock_bh(&tn->nametbl_lock);
> +	}

[Severity: Critical]

The commit message says "Concurrent withdrawals can still unlink entries
from this private list". Is that always the case?

The WITHDRAWAL branch in tipc_update_nametbl() frees the publication even
when binding_node was never unlinked:

net/tipc/name_distr.c:tipc_update_nametbl() {
    ...
	} else if (dtype == WITHDRAWAL) {
		p = tipc_nametbl_remove_publ(net, &ua, &sk, key);
		if (p) {
			tipc_node_unsubscribe(net, &p->binding_node, node);
			kfree_rcu(p, rcu);
			return true;
		}
    ...
}

tipc_node_unsubscribe() returns without calling list_del_init() in two
cases:

net/tipc/node.c:tipc_node_unsubscribe() {
	if (in_own_node(net, addr))
		return;

	n = tipc_node_find(net, addr);
	if (!n) {
		pr_warn("Node unsubscribe rejected, unknown node 0x%x\n", addr);
		return;
	}
    ...
}

In both cases the freed publication stays linked on n->publ_list. This
loop then splices it into purge_list, writes to it with list_del_init(),
and reads p->scope, p->sr, p->sk and p->key in tipc_publ_purge().

The lock is dropped and BH is re-enabled between iterations, so a grace
period can end in the middle of the loop. Can a later iteration then touch
a publication that kfree_rcu() has already freed?

One way to make tipc_node_find() fail while the purge is running:

CPU B: tipc_named_rcv() holds nametbl_lock and has already dequeued a
       WITHDRAWAL from node N (node_lost_contact() only purges what is
       still left in bc_entry.namedq)
CPU A: tipc_node_write_unlock()->tipc_publ_notify() waits on
       nametbl_lock
CPU C: tipc_nl_peer_rm()->tipc_node_delete() removes N from the hash
       once N is SELF_DOWN_PEER_LEAVING or SELF_DOWN_PEER_DOWN
CPU B: tipc_update_nametbl()->tipc_node_unsubscribe() fails the lookup,
       then kfree_rcu(p) runs with p still on N->publ_list
CPU A: list_splice_init() moves p onto purge_list, and a later iteration
       accesses p

A second path does not depend on the purge race. tipc_named_rcv() takes
the node from the header the peer sends, and nothing validates it:

		node = msg_orignode(hdr);

tipc_service_remove_publ() treats node == 0 as a wildcard:

		if (p->key != key || p->sk.ref != sk->ref ||
		    (node && node != p->sk.node))
			continue;

A peer with a link could send a WITHDRAWAL with orignode 0 that matches a
publication from node X. That publication is removed and freed. Because
in_own_node(net, 0) is true, tipc_node_unsubscribe() skips the unlink, and
the freed entry stays on X->publ_list.

>From then on, list_add_tail() in tipc_node_subscribe(), list_del_init()
on neighbouring entries, and the splice and walk here when X goes down
would all operate on freed memory. The spoofing itself predates this
patch, but it produces the same state that this loop assumes cannot
happen.

Could the WITHDRAWAL branch always do list_del_init(&p->binding_node)
under nametbl_lock? Every writer of binding_node for remote publications
already holds that lock.

Separately, could tipc_named_rcv() reject an orignode of 0 or our own
address, or require it to match the owner of the removed publication?
Without that check, a spoofed withdrawal can also free local publications
that are still on the socket and cluster_scope lists.

The kernel-doc for struct publication in net/tipc/name_table.h also still
says:

 * - Remote publications: in node->publ_list;

While a purge is running, binding_node is on the on-stack purge_list.
Should that comment be updated too?

>  
> -	list_for_each_entry_safe(publ, tmp, nsub_list, binding_node)
> -		tipc_publ_purge(net, publ, addr);
>  	spin_lock_bh(&tn->nametbl_lock);
>  	if (!(capabilities & TIPC_NAMED_BCAST))
>  		nt->rc_dests--;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927180806.1315902-1-nicoyip.dev%40gmail.com
