Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793248061;
	b=Zgo6TflEPyXqXojOV98RU6pHw5BosHZ068OSJDIO5hYVpo5o61wBrrAr6hyKDUeEXCek
	 hIvWzPL+sBAhzZXEXFxIwGF507iW7KQPkRzR/xf8TuAhK+pCqev3cJai7pUDTuEI9s2Z5
	 uoDq047FiRnT7AXfx2I8BDpLDKsxgRnS9u9X5NLURUd+yx15YJFKcBIX++/yf8ZSo4R2v
	 vtzyrcX2GMbu3vua7pKWgU/urghKqiavnSB05RCsnIRBhiLB6XceIdRHug7HbQNsMTjIL
	 o8Q04AGjXK2a3ZlUKpf2MEv2IPXOs2GXbfcO/WBJwrhDOpl8VK+HdcVfrVGudUep9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248061;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zRoJLJtdzSMp0vF6NxAkDF4KFWE1SYbcm7Ut9+3FXCg=;
	b=pL0QCK1E5qcBs9tg1nkgMUNTTV5JuIF1Nj0ilKUxtrufV+fV1ceiRrF2D3552hxBhwoM
	 rkUt2DKh34n62j/SB+zgBM27+mH6dzYfLQ+XRsMgCi/Ujlo5I3HcjUfTgZzB1Lw6Fr55E
	 5a3ZS5faqbvRiSFNad6Tp6BJ81Dlx9YadrCZfkv06u12pdynd81VCQBHgSNzr1LoxyORf
	 i6SNoIiqoBYEArDFU9CYqRiS6o7fGutz9HzSTEysndFBfC3mRMYjPjb3dDZqFH5pK61do
	 3te3VAdIVW+Vyk/gPO6Ab9u2gUPFPPpIUnqZX7ixLy6hGH8skyfR3IW+G/rB4l7YcQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N30Vm+bI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDCA606A31F
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N30Vm+bI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FAB1F031E5;
	Thu, 29 Oct 2026 04:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793248061;
	bh=zRoJLJtdzSMp0vF6NxAkDF4KFWE1SYbcm7Ut9+3FXCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N30Vm+bIAAa8JppvPmg+3+3kim8JJwVPpB2TrUi2ickrowW1VRmnxgVH2eltjPwbM
	 maVdKQwC1+LZuCY5NR2IDkRy8j3IILjRrda67ykIgr1ZZ7eheB+UxbrphfUiGDC/AY
	 kCRhN4zIE641SKX3sbtmhcoG/fx8hR3nUGPgAlOUMUkPXQJMkclnKtmIC6OFzVY2ke
	 xerPouJ02bWrLU9f9ChR35hoOMTg261pbv1uD+z8tcDtX+bNqIocapJs/hGUl6ODJK
	 ucj7PsWlRxLncKblfxMm1gncIhWYR5rZdpHkPdGUlRTDJOCq4tTOHAs6mo9XLDop+f
	 rgQjtwdqsnWtQ==
Subject: Re: [PATCH net 1/2] tipc: fix self-deadlock in tipc_named_node_up
From: netdev-bot+sashiko@kernel.org
To: tung.quang.nguyen@est.tech
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net,
 syzbot+64197f7577a09686ffdb@syzkaller.appspotmail.com
Date: Thu, 29 Oct 2026 04:27:40 +0000
Message-ID: <179324806006.3134.8900462366055369800@kernel.org>
In-Reply-To: <20261028033722.125477-2-tung.quang.nguyen@est.tech>
References: <20261028033722.125477-2-tung.quang.nguyen@est.tech>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At the target commit, the -ENOBUFS recovery for bulk name
  distribution can reset a link other than the one that failed.
- [Medium] tipc: leak of cloned skbs in xmitq on -ENOBUFS in
  tipc_node_distribute()
- [Low] The commit message leaves out several behaviour changes and
  misdescribes the new helper.
- [Low] The new kernel-doc for tipc_node_distribute() lists the return
  value as `-ENOBUF` (net/tipc/node.c:1798).

Pre-existing issues:
- [High] named_distribute() runs `hdr = buf_msg(skb_peek_tail(list));`
  (name_distr.c:191) whether or not anything was queued.
- [Medium] At the target commit named_distribute() is still `static
  void`.
- [Medium] This problem wasn't introduced by this patch, but it is copied
  into the new code.

--

tipc: fix self-deadlock in tipc_named_node_up

This patch removes nt->cluster_scope_lock and uses tn->nametbl_lock to
protect the cluster_scope list. That breaks a self-deadlock in which
tipc_named_node_up() held the read lock across tipc_node_xmit() ->
tipc_node_link_down() -> tipc_nametbl_withdraw().

It adds tipc_node_distribute(), which transmits like tipc_node_xmit() but
does not reset the link, plus a shared helper, tipc_node_build_list().
tipc_named_node_up() now returns an error code, and
tipc_node_write_unlock() resets the link when that code is -ENOBUFS.

> Fix this issue by:
> - Removing cluster_scope_lock, which protects the name table's cluster_scope
>   list. Use nametbl_lock instead to protect the list against races when multiple
>   threads concurrently call tipc_named_publish(), tipc_named_withdraw(),
>   and tipc_named_node_up().
>
> - Introducing a new function, tipc_node_distribute(), which is similar to
>   tipc_node_xmit() but does not call tipc_node_link_down(). Both functions call
>   the newly introduced tipc_node_build_list(), which builds a list of messages
>   in sequence.

[Severity: Low]
Could the commit message cover a few more of the behaviour changes in this
patch?

The link reset on bulk failure is still there. It moved into
tipc_node_write_unlock():

	if (rc == -ENOBUFS)
		tipc_node_link_down(n, bearer_id, false);

tipc_named_node_up() now also maps -EMSGSIZE to -ENOBUFS, so an oversized
bulk now resets the link. Before this patch, tipc_node_xmit() returned
-EMSGSIZE and the void tipc_named_node_up() ignored it. The -ELINKCONG
mapping has a comment, but this one does not.

The message says nametbl_lock now protects the cluster_scope list. In fact
the whole transmit now runs under spin_lock_bh(&tn->nametbl_lock):
tipc_node_find(), the node read lock, le->lock, tipc_link_xmit(), and
tipc_bearer_xmit() all the way down to the media send_msg().

Also, tipc_node_build_list() does more than build a list of messages. It
either delivers to the peer namespace through tipc_lxc_xmit() or enqueues
on the link through tipc_link_xmit().

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b7..a60f213ed1182 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c

[ ... ]

> @@ -202,25 +198,39 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
>   * @net: the associated network namespace
>   * @dnode: destination node
>   * @capabilities: peer node's capabilities
> + *
> + * Return:
> + * * 0               - Success
> + * * -ENOBUFS        - No buffer space is available
> + * * -EHOSTUNREACH   - Destination node does not exist or cannot be reached
> + *
>   */
> -void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
> +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
>  {
>  	struct name_table *nt = tipc_name_table(net);
>  	struct tipc_net *tn = tipc_net(net);
>  	struct sk_buff_head head;
> -	u16 seqno;
> +	int bearer_id = 0;
> +	int rc = 0;
>  
>  	__skb_queue_head_init(&head);
>  	spin_lock_bh(&tn->nametbl_lock);
>  	if (!(capabilities & TIPC_NAMED_BCAST))
>  		nt->rc_dests++;
> -	seqno = nt->snd_nxt;
> +	named_distribute(net, &head, dnode, &nt->cluster_scope, nt->snd_nxt);
> +	if (!skb_queue_empty(&head))
> +		rc = tipc_node_distribute(net, &head, dnode, &bearer_id, 0);

[Severity: High]
This is a pre-existing issue, but can named_distribute() dereference NULL
here when nt->cluster_scope is empty?

named_distribute() runs this whether or not it queued anything:

	hdr = buf_msg(skb_peek_tail(list));
	msg_set_last_bulk(hdr);

The list can be empty here. That happens if the TIPC_NOTIFY_NODE_UP event
is handled before tipc_net_finalize() has published the self
TIPC_NODE_STATE name, or if that publish failed. skb_peek_tail() then
returns NULL, and buf_msg(NULL) is dereferenced in softirq context.

A remote peer bringing up a link can trigger this. A syzbot report shows
the path tipc_rcv() -> tipc_node_write_unlock() -> tipc_named_node_up().

The new skb_queue_empty() check only runs after the dereference.

The follow-up patch "tipc: fix NULL pointer dereference in
named_distribute()" appears to fix this. It routes the call through
__tipc_named_distribute(), which makes sure the self publication is on
nt->cluster_scope, or defers the bulk, before named_distribute() runs.

[Severity: Medium]
This isn't a bug introduced by this patch, but the new kernel-doc says
tipc_named_node_up() returns -ENOBUFS when no buffer space is available.
Can that happen for allocation failures?

named_distribute() is still void. When named_prepare_buf() fails, it
returns without purging the partial list and without setting last_bulk or
the seqno:

			if (!skb) {
				pr_warn("Bulk publication failure\n");
				return;
			}

rc is only set from tipc_node_distribute(), so this case returns 0. The
new -ENOBUFS recovery in tipc_node_write_unlock() never runs. The peer's
tipc_named_dequeue() never sees last_bulk, so the peer's name table stays
stale.

The follow-up patch "tipc: fix NULL pointer dereference in
named_distribute()" seems to fix this. There, named_distribute() purges
the list and returns -ENOBUFS, and tipc_named_node_up() passes that
error up.

[ ... ]

> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 53b0993c2c233..b19d6652dc731 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c

[ ... ]

> @@ -435,6 +436,9 @@ static void tipc_node_write_unlock(struct tipc_node *n)
>  		tipc_mon_peer_down(net, node, bearer_id);
>  		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref);
>  	}
> +
> +	if (rc == -ENOBUFS)
> +		tipc_node_link_down(n, bearer_id, false);

[Severity: Medium]
Can this reset a different link from the one the bulk failed on?

Here bearer_id comes from n->link_id. It is saved before n->lock is
dropped:

	bearer_id = n->link_id & 0xffff;

The bulk is sent on whichever bearer tipc_node_build_list() picks later,
in a separate lock section:

	*bearer_id = n->active_links[selector & 1];

tipc_named_node_up() receives that bearer from tipc_node_distribute() in
its local bearer_id, then discards it and returns only rc.

Suppose a higher priority second link comes up in that window.
__tipc_node_link_up() puts the new bearer in both active slots, and the
bulk then fails on the new link. The old, healthy link is the one that
gets reset, and the bulk is never resent. The old tipc_node_xmit() path
reset the bearer it had actually used.

In the follow-up patch "tipc: fix NULL pointer dereference in
named_distribute()" this call becomes tipc_node_down(n), which brings
down every bearer. So the problem seems to be gone by the end of the
series.

[ ... ]

> @@ -1715,42 +1763,66 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,

[ ... ]

> +/**
> + * tipc_node_distribute() - distribute list of messages to specific destination
> + * @net: the applicable net namespace
> + * @list: chain of buffers containing message
> + * @dnode: address of destination node
> + * @bearer_id: id of the bearer
> + * @selector: a number used for deterministic link selection
> + *
> + * Return:
> + * * 0              - Success
> + * * -ELINKCONG     - Link is congested
> + * * -EHOSTUNREACH  - Host is not reachable
> + * * -EMSGSIZE      - Message's size is too big
> + * * -ENOBUF        - No buffer space is available

[Severity: Low]
This isn't a bug, but -ENOBUF should be -ENOBUFS. The typo seems to have
been copied from the tipc_node_xmit() comment, and it is still there at
the end of the series.

> + *
> + */
> +int tipc_node_distribute(struct net *net, struct sk_buff_head *list,
> +			 u32 dnode, int *bearer_id, int selector)
> +{

[ ... ]

>  	__skb_queue_head_init(&xmitq);
> -	le = &n->links[bearer_id];
> -	spin_lock_bh(&le->lock);
> -	rc = tipc_link_xmit(le->link, list, &xmitq);
> -	spin_unlock_bh(&le->lock);
> -	tipc_node_read_unlock(n);
> +	rc = tipc_node_build_list(n, list, &xmitq, selector, &maddr,
> +				  bearer_id, &lxc);
> +	if (lxc) {
> +		tipc_node_put(n);
> +		return 0;
> +	}
>  
> -	if (unlikely(rc == -ENOBUFS))
> -		tipc_node_link_down(n, bearer_id, false);
> -	else
> -		tipc_bearer_xmit(net, bearer_id, &xmitq, &le->maddr, n);
> +	if (likely(rc != -ENOBUFS))
> +		tipc_bearer_xmit(net, *bearer_id, &xmitq, &maddr, n);

[Severity: Medium]
This is a pre-existing issue, but can the clones already queued on
xmitq leak when tipc_link_xmit() returns -ENOBUFS here?

tipc_link_xmit() takes each skb off list, puts it on l->transmq and
puts a skb_clone() of it on the caller's xmitq. Suppose skb_clone()
fails on a later skb in the list. It frees that skb, purges list and
returns -ENOBUFS, but the clones from the earlier iterations stay on
xmitq.

On -ENOBUFS, tipc_node_distribute() skips tipc_bearer_xmit() and
returns. Nothing ever purges the stack-local xmitq, so those clones
are lost.

The refactored tipc_node_xmit() has the same problem. It calls
tipc_node_link_down() instead. That only cleans up the link's own
queues, not the caller's xmitq.

This needs a multi-buffer list, for example a bulk from
named_distribute() when nt->cluster_scope spans more than one MTU. It
also needs a GFP_ATOMIC failure in softirq context, so it is most
likely under memory pressure.

Both callers now go through tipc_node_build_list(). Would it make
sense to purge xmitq there on -ENOBUFS? Or should tipc_link_xmit()
clean up the clones it queued before returning the error?

[Severity: Medium]
This is a pre-existing issue, but are the skb clones on xmitq leaked when
rc is -ENOBUFS?

tipc_link_xmit() clones each skb onto xmitq. If skb_clone() fails on a
later skb, it returns -ENOBUFS and the earlier clones stay queued:

			_skb = skb_clone(skb, GFP_ATOMIC);
			if (!_skb) {
				kfree_skb(skb);
				__skb_queue_purge(list);
				return -ENOBUFS;
			}

On -ENOBUFS this function skips tipc_bearer_xmit() and never purges the
stack-local xmitq. The refactored tipc_node_xmit() does the same, as did
the original version.

Would a __skb_queue_purge(xmitq) on -ENOBUFS in tipc_node_build_list()
cover both callers? The leak is still present at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028033722.125477-1-tung.quang.nguyen%40est.tech
