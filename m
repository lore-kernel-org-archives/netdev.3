Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792449559;
	b=ZgZgJ1Tc74mR/ToRZJ3EoKlRnHms7Xrx4L8hFRIa95TGIoj6MdXArZf6MIQHRnnztJNK
	 IRrO7nL/MomAWkrsMXn0hxqow7DvnzWON/iEX5afpy2vOeWY9evi9UpiZlO8yzkkDbz93
	 Sfw+BPxGER+oxljAlcfHRp5KoqjUz67C4IumN46wbFUsP4aRrxMWjtZTtkogyBZinkSrk
	 3A6Dn9LIFXjgROH96+YlWL5G5JJ6Za83PDQXDg0F5C5BhfA/yfHpPrZMD7910F+jB4xdj
	 GD9bojlUmQq5MyooFZy5ih6/cWch4tdiwYa3SIZ4NjwUO2DGsm3sU35oMD21NvJIOxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449559;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lDKjPKw6zPt7d3U6aSMjy9p4YLE2l6z2F69BZ73q0no=;
	b=rdIAf5/7keh8jj4sDu/hRYadQlw6f1BqIrIdEb0R3WRDevYPQ/FFPPOROZg2Nxfe3MJL
	 YxpV+xKIBRAd+KeB3jmRuFwAmsXAjoYj2a2G1L1zoMB/vMfzXPIQzNhp1/Dk3GHb4rRjf
	 3Efv+UoO1vxe5uR0mpIw1J3TQk0wdhaTqbis2WLb1b/L+klTxzkuSPfZwQhiERv5fTVzX
	 5yACb1ib1wKukN/9BM1f3qXpx+E5KSx8AyPAxH4kDK/iLZwUgKEu1WVI3zgO3g3cq0vGB
	 6bDIOPpFjnrTR9dUamcDtEpTsJCc2wvvsb5by/JUlUcVQ7Qhe7SYSxCyYC7qRbHpRqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmVKqJuJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59051606A31C;
	Mon, 19 Oct 2026 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmVKqJuJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0C31F000C4;
	Mon, 19 Oct 2026 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792449558;
	bh=lDKjPKw6zPt7d3U6aSMjy9p4YLE2l6z2F69BZ73q0no=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jmVKqJuJUhG5E/5MxyzVD59HpwB57DmaZwrJ4FiynsiO619awnwsBiU1W1Rz/Ykjh
	 a5V6gpNUi51LBRclDbdmgd3geBKgxePIoP6p4pL+XIEUUtlztIy4w2va8q11QBlgEv
	 /6byP8mOWg/uB3EFwvZh4UubHl+SPg9tgEHDi7WuvbKkNNalVblH9GHFhzTtdE0nBf
	 B99nCnX8+kkpuQXJJZJmollBOX97U/1QQnrw3aZMyFFrPoflaQli9qdNza6i9vQZb2
	 ii5sCuW26TBGuPMQm4jVNw51ClYzQM9D+LBz8xQL0ihJDQm9epp05+4WXlF7x6uH6c
	 6KhXrCH70Q/xg==
Subject: Re: [PATCH net v4 5/5] amt: harden relay authentication and teardown
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Mon, 19 Oct 2026 22:39:17 +0000
Message-ID: <179244955783.3135.1555766273548436797@kernel.org>
In-Reply-To: <20261015220648.1545576-6-omar@blockcast.net>
References: <20261015220648.1545576-6-omar@blockcast.net>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message claims tunnel and multicast-state teardown is
  now "safe against concurrent RCU readers and delayed workers" because…
- [Medium] Much of the commit message describes work that this commit
  does not contain.
- [Medium] Every unauthenticated AMT Request now takes the device-wide
  amt->lock with BH disabled and walks the entire amt->tunnel_list while…
- [Low] The patch rewrites the comment on struct amt_tunnel_list::dead in
  include/net/amt.h.
- [Low] amt_update_handler() sends ICMP_DEST_UNREACH/ICMP_HOST_UNREACH to
  the gateway whenever amt_tunnel_get_or_create() returns NULL, and its…

--

amt: harden relay authentication and teardown

This commit makes relay Membership Requests stateless. The Query MAC is
derived from the source address, port, nonce and a rotating key, and the
Membership Update is authenticated before any tunnel state is created.
Tunnels are now keyed by (address, port) with a per-source cap, and four
key generations are kept so a gateway can renew its MAC across rotations.

> Keep relay Requests stateless: derive the Membership Query MAC from the
> source address, source port, nonce, and current key, then authenticate the
> Membership Update before decapsulating it or creating tunnel state. Key tunnel
> state by the (address, port) endpoint and reject new endpoints at the global
> or per-source cap without reflecting ICMP. Keep four key generations so a
> gateway can renew its MAC across rotations.
>
> Make tunnel and multicast state teardown safe against concurrent RCU readers
> and delayed workers. Mark tunnels, groups, and sources dead under their locks;
> have group and source workers hold RCU while finding their owners and checking
> that state; and release the group timer's device reference on every exit path.
> Recheck tunnel liveness before a Membership Update can arm group work.
>
> A deferred gateway Query is accepted only if its relay address still matches
> the current relay, and transmit error/drop counters use the concurrent-safe
> netdev statistics helpers.

[Severity: Medium]
Does this message match what the patch contains?

Compared with the parent commit ("amt: make pre-query report drops
visible"), most of the teardown work in the second paragraph is not in
this patch:

- amt_source_work() only gets a comment rewording.
- amt_group_work() is not modified.
- The only new liveness check is the tunnel->dead recheck in
  amt_update_handler().

The dead flags on groups and sources, the rcu_read_lock() in the group
and source workers, and the dev_put() on every amt_group_work() exit path
appear to come from the earlier commit "amt: fix use-after-free when a
Membership Update re-arms a freed tunnel".

The third paragraph also describes code that already exists. The parent
already has this in amt_membership_query_handler():

	/* A deferred query may outlive a relay address change. */
	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
		return true;

The tx_errors/tx_dropped sites there already use DEV_STATS_INC() as well.

The first paragraph says new endpoints at the cap are rejected "without
reflecting ICMP". However, amt_update_handler() still calls
icmp_ndo_send() when amt_tunnel_get_or_create() returns NULL.

The message also doesn't describe the bug being fixed. Before this patch,
one spoofed Request with an established gateway's source address
overwrote tunnel->nonce and tunnel->mac and cut that gateway off. Spoofed
Requests could also fill max_tunnels. Right now this is only explained in
the comment above amt_request_handler().

Could the message be reworded to describe what this patch actually
changes and which problem it fixes?

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index c6924ab40f223..ba2734c672f78 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -309,8 +309,8 @@ static void amt_source_work(struct work_struct *work)
>  		if (!gnode->nr_sources)
>  			amt_del_group(amt, gnode);
>  	} else {
> -		/* When a router filter-mode for a group is EXCLUDE,
> -		 * source records are only deleted when the group timer expires
> +		/* When a router filter-mode for the group is EXCLUDE, source
> +		 * records are only deleted when the group timer expires.
>  		 */
>  		snode->status = AMT_SOURCE_STATUS_D_FWD;
>  	}

[Severity: High]
The commit message says teardown is now safe against delayed workers
because the group and source workers hold RCU while finding their owners.
Does calling rcu_read_lock() inside the work function close that window?

amt_source_work() starts like this:

	rcu_read_lock();
	gnode = READ_ONCE(snode->gnode);
	amt = READ_ONCE(gnode->amt);
	tunnel = READ_ONCE(gnode->tunnel_list);
	spin_lock_bh(&tunnel->lock);
	if (READ_ONCE(snode->dead) || READ_ONCE(gnode->dead)) {

amt_group_work() does the same with gnode->tunnel_list and gnode->amt.

By the time either function runs, process_one_work() has already cleared
the pending bit. The freers use non-sync cancels, so they don't wait for
a work that is already running:

amt_del_group()
    if (cancel_delayed_work(&gnode->group_timer))  <- false if running
        dev_put(amt->dev);
    hlist_del_rcu(&gnode->node);
    ...
    kfree_rcu(gnode, rcu);

The other freers follow the same pattern:

- amt_destroy_source() calls cancel_delayed_work(&snode->source_timer)
  and hands snode to __amt_source_gc_work(), which frees it with
  kfree_rcu().
- amt_tunnel_expire() calls amt_clear_groups() and then
  kfree_rcu(tunnel).
- amt_dev_stop() does the same, but synchronously cancels only
  tunnel->gc_wq.

On a preemptible RCU kernel, a kworker preempted after the dequeue but
before its rcu_read_lock() does not hold up the grace period:

kworker                              other CPU
process_one_work()
  clears pending bit
  <preempted>
                                     amt_update_handler() leave path
                                       amt_del_group()
                                         cancel_delayed_work() == false
                                         kfree_rcu(gnode, rcu)
                                     grace period ends, gnode freed
amt_group_work()
  rcu_read_lock()
  tunnel = READ_ONCE(gnode->tunnel_list)   <- freed memory
  spin_lock_bh(&tunnel->lock)

Can gnode, snode or the tunnel be freed before the worker dereferences
them? The dead checks only run after those loads. The dev_hold() taken
for the group timer keeps amt->dev alive, but not gnode or the tunnel.

The worker code itself isn't changed here, but the message claims this
class is now handled. Would the freers need to wait for these works (a
sync cancel outside the spinlocks), or the work hold a reference on
gnode and the tunnel?

[ ... ]

> @@ -2540,34 +2652,58 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)

[ ... ]

> +	tunnel = amt_tunnel_get_or_create(amt, saddr, sport);
> +	if (!tunnel) {
> +		/* Out of tunnel slots.  Unlike the Request path this reply only
> +		 * ever goes to a source that proved it received our Query,
> +		 * so it
> +		 * cannot be used to reflect at a spoofed third party.
> +		 */
> +		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
> +		return true;
> +	}

[Severity: Low]
Is every NULL return from amt_tunnel_get_or_create() really "out of
tunnel slots"? It also returns NULL when the device isn't running and
when the GFP_ATOMIC allocation fails:

	if (!netif_running(amt->dev)) {
		spin_unlock_bh(&amt->lock);
		return NULL;
	}

	tunnel = kzalloc(sizeof(*tunnel) + ...
			 GFP_ATOMIC);
	if (!tunnel) {
		spin_unlock_bh(&amt->lock);
		return NULL;
	}

In those cases a verified gateway still gets ICMP_HOST_UNREACH. This
includes an Update that arrives after __dev_close_many() clears
__LINK_STATE_START but before amt_dev_stop() releases the socket.

On the gateway side, amt_err_lookup() handles that ICMP like this:

	case AMT_MSG_MEMBERSHIP_UPDATE:
		if (READ_ONCE(amt->status) >= AMT_STATUS_RECEIVED_ADVERTISEMENT)
			mod_delayed_work(amt_wq, &amt->req_wq, 0);

amt_event_send_request() then runs with req_cnt == 0, which clears
ready4/ready6 and picks a new nonce. Reports are dropped until a new
Query arrives.

Under sustained atomic allocation pressure, can this become a
Request/Query/Update/ICMP cycle paced by the round-trip time? The old
Request path sent ICMP only for the capacity case and dropped silently
when kzalloc() failed.

[ ... ]

> @@ -2764,60 +2922,40 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	if (amtrh->reserved1 || amtrh->reserved2 || amtrh->version)
>  		return true;
>  
> -	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> -		if (tunnel->ip4 == iph->saddr)
> -			goto send;
> -
> -	spin_lock_bh(&amt->lock);
> -	if (amt->nr_tunnels >= amt->max_tunnels) {
> -		spin_unlock_bh(&amt->lock);
> -		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
> +	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
>  		return true;
> -	}
>  
> -	tunnel = kzalloc(sizeof(*tunnel) +
> -			 (sizeof(struct hlist_head) * amt->hash_buckets),
> -			 GFP_ATOMIC);
> -	if (!tunnel) {
> -		spin_unlock_bh(&amt->lock);
> -		return true;
> +	/* Snapshot the secret and tunnel limits on the same locked walk. */
> +	spin_lock_bh(&amt->lock);
> +	key = amt->key[0];
> +	full = amt->nr_tunnels >= amt->max_tunnels;
> +	list_for_each_entry(tunnel, &amt->tunnel_list, list) {
> +		if (tunnel->ip4 != iph->saddr)
> +			continue;
> +		per_src++;
> +		if (tunnel->source_port == udph->source)
> +			have = true;
>  	}

[ ... ]

>  	spin_unlock_bh(&amt->lock);

[Severity: Medium]
Every unauthenticated Request now takes the device-wide amt->lock with BH
disabled and walks the whole tunnel_list while holding it. Because the
walk counts per_src, it doesn't stop at a match.

Before this patch, an existing endpoint was found with a lockless
list_for_each_entry_rcu() walk, and the locked section for new sources
was O(1).

amt_update_handler() now also takes the same lock for every Update,
forged ones included, just to copy the key array before checking the
MAC:

	spin_lock_bh(&amt->lock);
	for (i = 0; i < ARRAY_SIZE(key); i++)
		key[i] = amt->key[i];
	spin_unlock_bh(&amt->lock);

Can a flood of spoofed Requests serialize all RX CPUs on amt->lock, with
the hold time growing with nr_tunnels? max_tunnels comes from
IFLA_AMT_MAX_TUNNELS with no upper bound. Legitimate tunnel creation,
Update key snapshots and amt_tunnel_expire() all contend on the same
lock.

amt_tunnel_get_or_create() already rechecks both caps under the lock.
Could the per_src/have scan here be a lockless RCU walk instead, and the
key read use a seqcount or an RCU-published key array?

[ ... ]

> diff --git a/include/net/amt.h b/include/net/amt.h
> index ffe231b87ec28..1b4283efa0fc8 100644
> --- a/include/net/amt.h
> +++ b/include/net/amt.h
> @@ -242,20 +242,16 @@ struct amt_tunnel_list {

[ ... ]

> -	/* Set under amt->lock and tunnel->lock by whichever freer reaches the
> -	 * tunnel first; the other then leaves it alone, so it is freed once.
> +	/* Set under amt->lock by whichever freer reaches the tunnel first;
> +	 * the other then leaves it alone, so the tunnel is freed exactly once.
>  	 */
>  	bool			dead;

[Severity: Low]
Should this comment still mention tunnel->lock? Both writers still set
the flag with tunnel->lock nested inside amt->lock. In
amt_tunnel_expire() and amt_dev_stop():

	spin_lock_bh(&tunnel->lock);
	WRITE_ONCE(tunnel->dead, true);
	spin_unlock_bh(&tunnel->lock);

The new checks this patch adds to amt_update_handler() hold only
tunnel->lock:

		spin_lock_bh(&tunnel->lock);
		if (READ_ONCE(tunnel->dead)) {

These readers are serialized against teardown only because the writers
also take tunnel->lock, and the rewritten comment no longer says that.
If a later change follows the comment and drops the inner tunnel->lock,
won't the liveness recheck in amt_update_handler() quietly stop working?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015220648.1545576-1-omar%40blockcast.net
