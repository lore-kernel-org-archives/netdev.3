Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6D3A9619;
	Thu, 15 Oct 2026 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086941; cv=none; b=I3KWF5EVcSk9aYJbUXF2h4nbjcdxrlefZImHcjoIGw8KFfDIM6Sk7NepoU/V1Sp2WCK58WswwQXtIqLj4yNXUGEwU/ELSAo/4aYYmmhfMp4uPUQOjxkosxqN0RSZxb5YXs5IqWyB1jMjcQ5d45ZFi23vXWtLphK0h4BfprS63Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086941; c=relaxed/simple;
	bh=Rpc4bXyUTOVAnD4jKdHx/j2QkPdIiKR06iHP13Hnzp0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bY/WjCy3BY4lpLMQ76+TJmFESzVOSHWjkREd1RJIZA1LiP9X4v6Uujci16K90Kr+wpoaxaOQFAPOGJ+J5SDrlxWPLY2TuH9Uej0PmYw5wOGAv+hzkghFrN/ZZcvu4topg5LO3j/G8fqT6F3dywPS3CtP7jtV/vXQTRq3pLKVeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWShhLZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWShhLZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B771F000C4;
	Thu, 15 Oct 2026 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792086934;
	bh=8b2/6l+hVZAak0z1XeGggNTyrxOUsVZpBUrCxAvyc5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CWShhLZLRJJu0O1emziKb29du6PDX7oGjQoOM6Y+noBLWP5F5TrslOVzMlg7tPtA/
	 N02uCLtVx1EGwh4wDzq1wWC/EszH9lnBd44fQFLATazhrAxlxCBtm4XhGqzJ5aGL4C
	 P62radyLSpCtt17CMpjdwEI30a22h6Z+RT3dCLoqhZ0vtJVyYk2LYgqMOfYBcXr/w1
	 J5ixLkFwpThHqmoAMBUQ1/oHCE7rymO2w/dpt7OHjbfcUC7FnvP3kNvkK/T4Px3VuE
	 lM6RnchTcMatu6nBvA1DyNSaRcCoYOQ192bwieDlnFbfP9xyUbRhYmcfJ4xs5j04JJ
	 Z4w1KwMO1ZXJw==
Subject: Re: [PATCH net v4 1/5] amt: fix use-after-free when a Membership
 Update re-arms a freed tunnel
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Thu, 15 Oct 2026 17:55:33 +0000
Message-ID: <179208693370.434549.7025629171594378280@kernel.org>
In-Reply-To: <20261013175407.947606-2-omar@blockcast.net>
References: <20261013175407.947606-2-omar@blockcast.net>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] At this commit the Update-vs-teardown race is only partly
  closed.
- [Medium] At this commit the initial gc_wq arm and the new expiry
  deadline disagree.
- [Medium] At this commit amt_dev_stop() sets ->dead on all tunnels in
  one amt->lock section and unlinks them later in separate amt->lock…
- [Low] The new comments disagree about which code frees a tunnel.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but tearing down a
  group does not wait for a group_timer callback that is already running.

--

amt: fix use-after-free when a Membership Update re-arms a freed tunnel

This patch stops amt_update_handler() from re-arming a relay tunnel's
gc_wq. The Update path now only stamps tunnel->last_seen, and
amt_tunnel_expire() uses last_seen under amt->lock to decide whether to
re-arm itself or free the tunnel. It also adds a dead flag and changes
amt_dev_stop() to mark every tunnel dead under amt->lock, then unlink and
free them one at a time.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index b53f8ec556615..530650d5c19e9 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -1328,8 +1328,30 @@ static void amt_tunnel_expire(struct work_struct *work)

[ ... ]

>  	spin_lock_bh(&amt->lock);
> +	/* amt_dev_stop() has taken ownership of the teardown. */
> +	if (tunnel->dead) {
> +		spin_unlock_bh(&amt->lock);
> +		return;
> +	}
> +	/* A Membership Update may have refreshed the tunnel after this work
> +	 * was queued.  Re-arm from last_seen rather than letting
> +	 * amt_update_handler() re-arm gc_wq: this handler is then the only
> +	 * context that frees the tunnel (and the only one amt_dev_stop() has
> +	 * to cancel), which closes the use-after-free where a concurrent
> +	 * Update re-armed gc_wq on a tunnel this function had already
> +	 * list_del_rcu()'d and kfree_rcu()'d.
> +	 */

[Severity: Low]
This isn't a bug, but the comments in this patch don't agree on which
code frees a tunnel. This one says amt_tunnel_expire() is "the only
context that frees the tunnel". The new comment in amt_dev_stop() says
"this path is then the sole freer", and amt_dev_stop() does call
kfree_rcu() on every tunnel left on the list.

The dead field comment in include/net/amt.h says either function may free
the tunnel, whichever gets there first. The commit message says "the only
context that frees a tunnel on the timeout path".

Could this comment keep the "on the timeout path" qualifier? Both comments
are still unchanged at the end of the series.

[ ... ]

> @@ -2494,9 +2516,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
>  		if (tunnel->ip4 == saddr) {
>  			if ((nonce == tunnel->nonce &&
>  			     response_mac == tunnel->mac)) {
> -				mod_delayed_work(amt_wq, &tunnel->gc_wq,
> -						 msecs_to_jiffies(amt_gmi(amt))
> -								  * 3);
> +				/* Refresh liveness only.  gc_wq is
> +				 * re-armed by amt_tunnel_expire() itself
> +				 * from last_seen, never from here, so this
> +				 * cannot re-queue the work of a tunnel
> +				 * that is being freed.
> +				 */
> +				WRITE_ONCE(tunnel->last_seen, jiffies);
>  				goto report;

[Severity: Critical]
Can this cached tunnel pointer still be used after teardown? The tunnel
comes from a lockless list_for_each_entry_rcu() walk. After goto report,
amt_update_handler() does this without checking tunnel->dead:

    spin_lock_bh(&tunnel->lock);
    amt_igmp_report_handler(amt, skb, tunnel);
    spin_unlock_bh(&tunnel->lock);

If amt_tunnel_expire() or amt_dev_stop() runs at the same time:

CPU1 (amt_tunnel_expire)
  tunnel->dead = true;
  list_del_rcu(&tunnel->list);
  amt_clear_groups(tunnel);   /* takes and drops tunnel->lock */
  kfree_rcu(tunnel, rcu);

CPU2 (amt_update_handler)
  spin_lock_bh(&tunnel->lock);
  amt_igmp_report_handler()
    amt_igmpv2_report_handler()
      amt_add_group()
        gnode->tunnel_list = tunnel;
        hlist_add_head_rcu(&gnode->node, &tunnel->groups[hash]);

Nothing ever clears the new gnode, and its group_timer is armed with
dev_hold(). After the grace period the tunnel is freed, and
amt_group_work() later does this on freed memory:

    struct amt_tunnel_list *tunnel = gnode->tunnel_list;
    ...
    spin_lock_bh(&tunnel->lock);

The gnode and the netdev reference also leak. This is the same
cached-pointer pattern the commit message describes. The MLD path
(amt_mld_report_handler()) has the same gap.

The later patch "amt: harden relay tunnel lifetime and request admission"
adds a READ_ONCE(tunnel->dead) check under tunnel->lock before both report
handlers. That closes this window, but the check is not present at this
commit.

Even with that check, an Update that stamps last_seen just after
amt_tunnel_expire() reads it at the 3 * GMI boundary loses that one
refresh. This only drops the report and does not cause a memory-safety
problem.

[ ... ]

> @@ -2732,6 +2758,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	for (i = 0; i < amt->hash_buckets; i++)
>  		INIT_HLIST_HEAD(&tunnel->groups[i]);
>  
> +	tunnel->last_seen = jiffies;
>  	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
>  
>  	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);

[Severity: Medium]
amt_request_handler() still arms gc_wq for a single GMI a few lines below:

    mod_delayed_work(amt_wq, &tunnel->gc_wq,
                     msecs_to_jiffies(amt_gmi(amt)));

amt_tunnel_expire() now uses a 3 * GMI deadline:

    deadline = READ_ONCE(tunnel->last_seen) +
               msecs_to_jiffies(amt_gmi(amt)) * 3;
    if (time_before(jiffies, deadline)) {
        mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - jiffies);

When the work first fires at 1 * GMI, time_before() is true, so the work
re-arms for about 2 * GMI more instead of freeing the tunnel.

Does a tunnel created by a Request, and never confirmed by a MAC-valid
Membership Update, now live for 3 * GMI instead of 1 * GMI? That would
hold its max_tunnels slot three times longer than before.

Also, the new last_seen comment in include/net/amt.h says "Last time a
valid Membership Update refreshed this tunnel". At this commit the Request
path sets it without any Update.

The later patch "amt: harden relay tunnel lifetime and request admission"
makes amt_request_handler() stateless. It creates tunnels only in
amt_tunnel_get_or_create(), which arms gc_wq for 3 * GMI, so the arm time
and the deadline match by the end of the series. They don't match at this
commit.

[ ... ]

> @@ -3079,9 +3106,31 @@ static int amt_dev_stop(struct net_device *dev)
>  	amt->req_cnt = 0;
>  	WRITE_ONCE(amt->remote_ip, 0);
>  
> -	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
> -		list_del_rcu(&tunnel->list);
> -		amt->nr_tunnels--;
> +	/* Mark every tunnel dead first, so a concurrent amt_tunnel_expire()
> +	 * sees ->dead and bails instead of freeing a tunnel in parallel; this
> +	 * path is then the sole freer.
> +	 */
> +	spin_lock_bh(&amt->lock);
> +	list_for_each_entry(tunnel, &amt->tunnel_list, list)
> +		tunnel->dead = true;
> +	spin_unlock_bh(&amt->lock);

[Severity: Medium]
Can a new tunnel be added between this marking pass and the unlink loop
below? The unlink loop takes amt->lock again for each entry and never sets
->dead itself.

The RX path doesn't seem to be quiesced at this point. Earlier in
amt_dev_stop():

    RCU_INIT_POINTER(amt->sk, NULL);
    synchronize_net();
    if (sk)
        udp_tunnel_sock_release(sk);

amt_rcv() finds the device through rcu_dereference_sk_user_data(sk).
udp_tunnel_sock_release() clears sk_user_data after synchronize_net() and
does not wait for another grace period. amt_request_handler() also has no
netif_running() check before list_add_tail_rcu() and arming gc_wq.

So a Request still in flight could publish a tunnel with dead == false and
gc_wq armed after this pass. That tunnel could stay on tunnel_list after
stop.

If its gc_wq instead runs between the list_del_rcu() below and
cancel_delayed_work_sync(), amt_tunnel_expire() sees dead == false. Both
contexts would then unlink and kfree_rcu() the same tunnel. That needs
gc_wq, armed for at least one GMI, to fire inside a very short window, so
it is unlikely.

The later patch "amt: harden relay tunnel lifetime and request admission"
moves tunnel creation into amt_tunnel_get_or_create(). That function checks
!netif_running(amt->dev) under amt->lock, which closes this by the end of
the series.

[ ... ]

> +	for (;;) {
> +		spin_lock_bh(&amt->lock);
> +		tunnel = list_first_entry_or_null(&amt->tunnel_list,
> +						  struct amt_tunnel_list, list);
> +		if (tunnel) {
> +			list_del_rcu(&tunnel->list);
> +			amt->nr_tunnels--;
> +		}
> +		spin_unlock_bh(&amt->lock);
> +		if (!tunnel)
> +			break;
> +
>  		cancel_delayed_work_sync(&tunnel->gc_wq);
>  		amt_clear_groups(tunnel);
>  		kfree_rcu(tunnel, rcu);

[Severity: High]
This isn't a bug introduced by this patch, but does group teardown wait
for a group_timer callback that is already running? amt_del_group() does:

    if (cancel_delayed_work(&gnode->group_timer))
        dev_put(amt->dev);
    hlist_del_rcu(&gnode->node);
    gnode->tunnel_list->nr_groups--;
    ...
    kfree_rcu(gnode, rcu);

cancel_delayed_work() returns false once amt_group_work() has started.
amt_group_work() reads gnode->tunnel_list and amt->hash_buckets before it
takes tunnel->lock. It never checks whether the gnode was already deleted.

Take an IGMPv2 group (MCAST_EXCLUDE, group_timer armed at GMI). If a
remote IGMPv2 Leave, or amt_clear_groups(), gets tunnel->lock while that
timer is running:

CPU1
amt_igmpv2_leave_handler()
  amt_del_group(amt, gnode)
    hlist_del_rcu(&gnode->node);
    kfree_rcu(gnode, rcu);

CPU2
amt_group_work()
  spin_lock_bh(&tunnel->lock);
  /* still MCAST_EXCLUDE, no sources, delete_group = true */
  amt_del_group(amt, gnode)
    hlist_del_rcu(&gnode->node);   /* pprev is LIST_POISON2 */

Would the second hlist_del_rcu() oops here? This path also decrements
nr_groups a second time and calls kfree_rcu() a second time.

On preemptible kernels, amt_group_work() can also be preempted before
spin_lock_bh(). The gnode's kfree_rcu() does not wait for it. Neither does
the tunnel's kfree_rcu() here, which follows amt_clear_groups() in
amt_dev_stop() or amt_tunnel_expire(). On resume, the work could touch
freed gnode and tunnel memory, including spin_lock_bh() on a freed
tunnel->lock. The dev_hold() taken when group_timer is armed only keeps
the netdev alive.

amt_dev_stop() only calls cancel_delayed_work_sync() on gc_wq, not on the
group or source timers. This code is unchanged through the end of the
series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013175407.947606-1-omar%40blockcast.net
