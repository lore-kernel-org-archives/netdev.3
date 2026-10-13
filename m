Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7A33936F;
	Tue, 13 Oct 2026 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900111; cv=none; b=VXdpdZ/NWSfsk7cd5qJjcnHb4ZZ+w16JI7HNOA2RHEGJcdQnTUiLjFPHld/eY4nprt6nokz0nplN5RaMDseYLXMjMt2bM7cyDXmJRrXuLYBm9JXPEv2pIxRI91xShfevYWnO17ZMv5vqp167UwjvyxkDW4HYzKO6T3s4gzt6B4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900111; c=relaxed/simple;
	bh=L0ZRVAr8xzD9QvyDSytgqwO20BuMs2GvDEun4CxFakM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtcU/0wmdPa6F3fbjbpVhw2r7VG9CpjaJhwYxxZ79/Hjm+6ij6m/qZuHYfQ3vycfYC2wdlFdhskFu5qsM80iT9vyeminwgmvd3u4b+vhe1gkGjGFQDbvJQH/r4CLWHycujmf89o+jrnA0NZM2Q6RlfMuVY7lyNSHoZ4yV3Uy/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvN+TB13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvN+TB13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6B01F00898;
	Tue, 13 Oct 2026 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900110;
	bh=COEk+gwQORM/abUvc204Nyd9e/Egv41L399rPDFFUvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TvN+TB13vY7tAFBceTL+AELr4doodKiSxXafubBUPy+a3YZhxdSK+i4nodABnUqij
	 ial6n370mcm2t0Oi9Hzr+eSRS9p0QmOtGl5A+hvrOPpP9bEb3sjM4VbHTJYd+WpQPG
	 IzgW+KYlhhPRIp5Y3q7cXfaPs37JRIDk3siDBwla9vkaIibRvwF0RDA7Md+nsVAi0N
	 Z37zwEVwZxuuH/nOqDuyWK5q5dl8zKwsfrHYDOnN4tYkqcxUso6U/7AZc6xNOaN+ug
	 64viynryMlubHsB3TAXkYMTrlpODw5QpzmUOqQgYJxqDmW0tyxF2u2yvw5NbdpjZBx
	 hVlSb+rSQPOQA==
Subject: Re: [PATCH net v3 1/6] amt: fix use-after-free when a Membership
 Update re-arms a freed tunnel
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Tue, 13 Oct 2026 14:01:49 +0000
Message-ID: <179190010922.434549.7719203541619227350@kernel.org>
In-Reply-To: <20261012125943.558629-2-omar@blockcast.net>
References: <20261012125943.558629-2-omar@blockcast.net>
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

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix stops a concurrent Membership Update from re-arming
  gc_wq, but that Update can still arm other delayed work that points at…
- [High] amt_dev_stop() replaced the RCU-safe list_del_rcu() loop with
  list_splice_init(&amt->tunnel_list, &doomed), which moves the RCU-…
- [Low] At this commit, a tunnel that only ever received a Request lives
  three times as long (3*GMI instead of GMI), and the commit message…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but tunnel
  teardown does not wait for a group_timer callback that is already…

--

amt: fix use-after-free when a Membership Update re-arms a freed tunnel

amt_update_handler() no longer re-arms tunnel->gc_wq. It now stamps a new
tunnel->last_seen field, and amt_tunnel_expire() either re-arms itself or
frees the tunnel under amt->lock. The patch also adds a tunnel->dead flag,
and amt_dev_stop() now marks tunnels dead and splices the tunnel list out
under amt->lock before freeing them.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index b53f8ec556615..b284fa7b7307e 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -2494,9 +2515,12 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
>  		if (tunnel->ip4 == saddr) {
>  			if ((nonce == tunnel->nonce &&
>  			     response_mac == tunnel->mac)) {
> -				mod_delayed_work(amt_wq, &tunnel->gc_wq,
> -						 msecs_to_jiffies(amt_gmi(amt))
> -								  * 3);
> +				/* Refresh liveness only.  gc_wq is re-armed by
> +				 * amt_tunnel_expire() itself from last_seen, never
> +				 * from here, so this cannot re-queue the work of a
> +				 * tunnel that is being freed.
> +				 */
> +				WRITE_ONCE(tunnel->last_seen, jiffies);
>  				goto report;

[Severity: High]
The Update path no longer re-arms gc_wq. Can it still arm other delayed
work that points at a tunnel being freed?

amt_update_handler() still holds only rcu_read_lock(), and it never checks
the new tunnel->dead flag. After the goto report it does this:

drivers/net/amt.c:amt_update_handler() {
    ...
		spin_lock_bh(&tunnel->lock);
		amt_igmp_report_handler(amt, skb, tunnel);
		spin_unlock_bh(&tunnel->lock);
    ...
}

The MLD branch does the same.

Suppose amt_tunnel_expire() reads last_seen before this WRITE_ONCE() is
visible. It then goes ahead with the teardown:

CPU1 (amt_tunnel_expire)            CPU2 (amt_update_handler)
                                    finds tunnel in RCU walk
deadline = READ_ONCE(last_seen)...
tunnel->dead = true;
list_del_rcu(&tunnel->list);
amt_clear_groups(tunnel);
kfree_rcu(tunnel, rcu);
                                    WRITE_ONCE(tunnel->last_seen, jiffies);
                                    spin_lock_bh(&tunnel->lock);
                                    amt_igmp_report_handler()
                                      amt_igmpv2_report_handler()
                                        amt_add_group()
                                          gnode->tunnel_list = tunnel;
                                          hlist_add_head_rcu(...)
                                        mod_delayed_work(group_timer)
                                        dev_hold(amt->dev)

Nothing deletes that gnode afterwards. Would the gnode, its sources and
the netdev reference all leak?

The tunnel is freed once the grace period ends. When group_timer fires,
amt_group_work() loads gnode->tunnel_list and calls
spin_lock_bh(&tunnel->lock) on the freed tunnel. amt_del_group() also
writes gnode->tunnel_list->nr_groups.

The commit message describes this same class of bug: an Update holding a
cached tunnel pointer arms delayed work that outlives the tunnel.

amt_dev_stop() seems to have the same window. An Update that found the
tunnel before the list_splice_init() can add groups after
amt_clear_groups() has run. This path looks unchanged through the end of
the series.

Could amt_update_handler() check tunnel->dead under tunnel->lock and bail
out before calling the report handlers? Both freers set dead before
amt_clear_groups() takes tunnel->lock, so that check should close the
window.

[ ... ]

> @@ -2732,6 +2756,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	for (i = 0; i < amt->hash_buckets; i++)
>  		INIT_HLIST_HEAD(&tunnel->groups[i]);
>  
> +	tunnel->last_seen = jiffies;
>  	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
>  
>  	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);

[Severity: Low]
Does this extend the lifetime of a Request-only tunnel from GMI to 3*GMI?

amt_request_handler() still arms the first expiry at one GMI:

	mod_delayed_work(amt_wq, &tunnel->gc_wq,
			 msecs_to_jiffies(amt_gmi(amt)));

When that work fires, amt_tunnel_expire() computes:

	deadline = READ_ONCE(tunnel->last_seen) +
		   msecs_to_jiffies(amt_gmi(amt)) * 3;

The deadline has not passed yet, so it re-arms for roughly another 2*GMI.
Before this patch, a tunnel that only received a Request was freed after
GMI. Unauthenticated Requests can now hold max_tunnels slots three times
longer, and the commit message does not mention the change.

The new comment in struct amt_tunnel_list also describes last_seen as the
"Last time a valid Membership Update refreshed this tunnel". At this
commit the Request path writes it as well.

A later commit in the series, "amt: do not create tunnel state for
unauthenticated Requests", seems to fix this. That commit stops the
Request path from allocating tunnels, which also makes the struct comment
accurate.

[ ... ]

> @@ -3053,6 +3078,7 @@ static int amt_dev_stop(struct net_device *dev)
>  	struct amt_tunnel_list *tunnel, *tmp;
>  	struct sk_buff *skb;
>  	struct sock *sk;
> +	LIST_HEAD(doomed);
>  	int i;
>  
>  	disable_delayed_work_sync(&amt->req_wq);
> @@ -3079,9 +3105,19 @@ static int amt_dev_stop(struct net_device *dev)
>  	amt->req_cnt = 0;
>  	WRITE_ONCE(amt->remote_ip, 0);
>  
> -	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
> -		list_del_rcu(&tunnel->list);
> -		amt->nr_tunnels--;

[ ... ]

> +	spin_lock_bh(&amt->lock);
> +	list_for_each_entry(tunnel, &amt->tunnel_list, list)
> +		tunnel->dead = true;
> +	list_splice_init(&amt->tunnel_list, &doomed);
> +	amt->nr_tunnels = 0;
> +	spin_unlock_bh(&amt->lock);

[Severity: High]
Is list_splice_init() safe here while RX readers may still be walking
amt->tunnel_list with list_for_each_entry_rcu()?

The old loop used list_del_rcu(). After this splice, the last tunnel's
->next points at the on-stack doomed head. amt->tunnel_list is
reinitialised to empty, with no grace period in between.

The only grace period in amt_dev_stop() is the synchronize_net() before
udp_tunnel_sock_release(). udp_tunnel_sock_release() clears sk_user_data
with rcu_assign_sk_user_data(sk, NULL), then shuts down and releases the
socket without waiting for readers.

So an amt_rcv() call that already loaded amt from sk_user_data could
still be inside amt_request_handler() or amt_update_handler():

	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
		if (tunnel->ip4 == saddr) {

A reader that has already passed the last tunnel would never reach the
terminator, &amt->tunnel_list. Would it then treat &doomed as a struct
amt_tunnel_list and read ip4 from stack memory past the list_head? It
would then follow doomed.next back to the first tunnel and loop in softirq
under rcu_read_lock().

That would stall RCU, which also holds up the pending kfree_rcu() calls.
Once amt_dev_stop() returns and its stack frame is reused, the reader
follows garbage pointers. If the stack bytes happen to match saddr, the
send: path in amt_request_handler() writes tunnel->nonce through the bogus
pointer.

There is a second problem. A reader that reaches the allocation in
amt_request_handler() after the splice (amt_tunnel_get_or_create() later
in the series) can list_add_tail_rcu() a new tunnel onto the emptied
amt->tunnel_list. Nothing in this stop path frees that tunnel.

Would list_splice_init_rcu(), which waits for a grace period, or keeping
list_del_rcu() work better here? This code also looks unchanged at the end
of the series.

> +
> +	list_for_each_entry_safe(tunnel, tmp, &doomed, list) {
>  		cancel_delayed_work_sync(&tunnel->gc_wq);
>  		amt_clear_groups(tunnel);
>  		kfree_rcu(tunnel, rcu);

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Does this
teardown wait for a gnode->group_timer callback that is already running?

amt_clear_groups() calls amt_del_group() for each group under
tunnel->lock. amt_del_group() only does a non-synchronous cancel:

drivers/net/amt.c:amt_del_group() {
	if (cancel_delayed_work(&gnode->group_timer))
		dev_put(amt->dev);
	hlist_del_rcu(&gnode->node);
	gnode->tunnel_list->nr_groups--;
	...
	kfree_rcu(gnode, rcu);
}

If amt_group_work() is already running, cancel_delayed_work() returns
false. amt_group_work() loads the tunnel pointer outside any RCU read
section:

	struct amt_tunnel_list *tunnel = gnode->tunnel_list;
	...
	spin_lock_bh(&tunnel->lock);

If the callback is preempted before spin_lock_bh(), could the grace period
finish so that it takes tunnel->lock inside a freed tunnel?

If the memory has not been freed yet, the callback takes tunnel->lock once
amt_clear_groups() drops it. For an EXCLUDE mode group the source lists
are empty by then, so delete_group stays true and amt_del_group() runs a
second time.

Would that call hlist_del_rcu() again on a node whose pprev is already
LIST_POISON2? It would also decrement nr_groups twice and call
kfree_rcu(gnode) twice.

amt_tunnel_expire() has the same issue, since it also calls
amt_clear_groups() before kfree_rcu(tunnel). Only gc_wq is cancelled
synchronously here; the per-group work is never waited for.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012125943.558629-1-omar%40blockcast.net
