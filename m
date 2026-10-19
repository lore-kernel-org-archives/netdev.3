Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792449557;
	b=d9cJvZLPawpwz7UhD48VSgoNFg3xfDUg8oDzk0hqfQmEqjiEgw+buFFwg9c2shSg7Wk2
	 D5PukZ4++Typ4uzJMLrsnA/+BfO5u8HegwQwlxXb7M3qJOafGzMZyAWmDBiC8P/ilktkW
	 ZCmkKXP9mOzfVd+d9NLfbCC4cXL5ryixosji+76NrV0k0bATUUtL1silhFF37sr3Qvn+x
	 aMBlJCUANu3Ygz8IUQcmWmVAWHlZ9TMz7X6fkluG+a8aKUtXzaIJpDyWNFLKag+Ul2Mc+
	 21DlZXMiHtmCtRX6VcFlVkhV9sEbGSFDBPs3/Q+3OTkLxD/8mdWKVMmIrda5tcwd3eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449557;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iVicnuw5H5/wmwwsIU/+q31coS/UK87CGBJ64fdu6IY=;
	b=3Yxk7UrxdMmdl3ctgt8v0quEEHrNN0OBj+vZ9duHbCoa5lzTXJMBrzu1WkKbfE6ZzzaA
	 0G35ueXllZNM+VSjVwZ0pw28wsPlu80/uYX/mr/9zotTSHzNl9joPQ7Ud8qb0HWa6y0sU
	 30ahzYVdxWyCRZ1fqZ8J0J30YqrzXsz4drjCh2dxAQydLJvnme8KjgqOfz17Pt5NU184R
	 8DONNPEWOEt02TjWWklLjX2UiU1juRY+n3zMBmg/QiPaaUQLXn6Hj8LB2+zK97tdjNyB1
	 b8hEYKRY2i5crYC79RY/Uy1jzTKBhA7X66AjHVwqG4o6m+Okgiufv95iQVhEeESuSiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I3Oej/Sd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD58606A319;
	Mon, 19 Oct 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3Oej/Sd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DA11F000C4;
	Mon, 19 Oct 2026 22:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792449556;
	bh=iVicnuw5H5/wmwwsIU/+q31coS/UK87CGBJ64fdu6IY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I3Oej/Sd4MFInT7nmMo0NRE2RDaSHXBbMedPRmi1orUNIXIrkUx9qG3ibXb87cRqn
	 MGCpgHTPogrnzqOTQuaPfiBAR1ZKLIyxYnxLuzUZ0Inn8WjIzy4jUVnCDy8dLtz6Yt
	 rNAmLY5TcF+vBitiNNP4p+QKj55M+RT7GQ+nlyPxFQosFfT6Xz+Y7vPiKW2PtJJq8+
	 w9k4tET5f/VcULPRDS5NJOXRFMPUfU+GKoq5RKwk7MaTXwQCgMNczmxW0h29/2sU+X
	 H1eFX4Nm3bl1nzmD/PefJfmZco5VZG4WBI2e6YxPqTC1f21wypo4txNTkHPsV0B4SA
	 1X4eS8DU4EnNw==
Subject: Re: [PATCH net v4 1/5] amt: fix use-after-free when a Membership
 Update re-arms a freed tunnel
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Mon, 19 Oct 2026 22:39:15 +0000
Message-ID: <179244955529.3135.5434983972100868824@kernel.org>
In-Reply-To: <20261015220648.1545576-2-omar@blockcast.net>
References: <20261015220648.1545576-2-omar@blockcast.net>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In this patch's version, amt_tunnel_expire()
  (drivers/net/amt.c:1374-1383) sets tunnel->dead under tunnel->lock.
- [Medium] The commit message only describes tunnel gc_wq,
  amt_update_handler(), amt_tunnel_expire() and amt_dev_stop().
- [Medium] In this patch, amt_request_handler()
  (drivers/net/amt.c:2783-2791) sets tunnel->last_seen = jiffies and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new
  gnode->dead/snode->dead checks do not stop a use-after-free when a…

--

amt: fix use-after-free when a Membership Update re-arms a freed tunnel

With this patch, amt_update_handler() only records tunnel->last_seen and no
longer re-arms gc_wq. amt_tunnel_expire() now decides from last_seen,
under amt->lock, whether to re-arm itself or free the tunnel. The patch
also changes amt_dev_stop() to mark tunnels dead under amt->lock and
unlink them one at a time, and it adds dead flags to the tunnel, group
and source nodes.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index b53f8ec556615..b06916c7d57d5 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -215,9 +215,14 @@ static struct amt_group_node *amt_lookup_group(struct amt_tunnel_list *tunnel,
>  
>  static void amt_destroy_source(struct amt_source_node *snode)
>  {
> -	struct amt_group_node *gnode = snode->gnode;
> +	struct amt_group_node *gnode;
>  	struct amt_tunnel_list *tunnel;
>  
> +	if (READ_ONCE(snode->dead))
> +		return;
> +	WRITE_ONCE(snode->dead, true);
> +	gnode = snode->gnode;
> +
>  	tunnel = gnode->tunnel_list;
>  
>  	if (!gnode->v6) {
> @@ -249,6 +254,9 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
>  	struct hlist_node *t;
>  	int i;
>  
> +	if (READ_ONCE(gnode->dead))
> +		return;
> +	WRITE_ONCE(gnode->dead, true);
>  	if (cancel_delayed_work(&gnode->group_timer))
>  		dev_put(amt->dev);
>  	hlist_del_rcu(&gnode->node);

[Severity: Medium]

The commit message covers the tunnel gc_wq race and the changes to
amt_update_handler(), amt_tunnel_expire() and amt_dev_stop(). Several hunks
in the diff are outside that description:

  - a dead flag added to struct amt_source_node and struct amt_group_node
  - amt_destroy_source() and amt_del_group() made idempotent
  - amt_source_work() and amt_group_work() restructured: rcu_read_lock()
    moved ahead of the gnode reads, the RCU/spinlock nesting swapped, and
    new early exits added, one of which calls dev_put(amt->dev) when
    gnode->dead is set

Which race do the group/source changes fix? And why is the dev_put() on
the new gnode->dead exit path balanced?

The last patch in the series, "amt: harden relay authentication and
teardown", describes these same changes in its own commit message ("Mark
tunnels, groups, and sources dead under their locks; have group and source
workers hold RCU while finding their owners..."). The code itself goes in
here, though.

Could these hunks either move to that patch or be described in this commit
message?

[ ... ]

> @@ -403,26 +418,35 @@ static void amt_group_work(struct work_struct *work)
>  	struct amt_group_node *gnode = container_of(to_delayed_work(work),
>  						    struct amt_group_node,
>  						    group_timer);
> -	struct amt_tunnel_list *tunnel = gnode->tunnel_list;
> -	struct amt_dev *amt = gnode->amt;
> +	struct amt_tunnel_list *tunnel;
> +	struct amt_dev *amt;
>  	struct amt_source_node *snode;
>  	bool delete_group = true;
>  	struct hlist_node *t;
>  	int i, buckets;
>  
> +	rcu_read_lock();
> +	tunnel = READ_ONCE(gnode->tunnel_list);
> +	amt = READ_ONCE(gnode->amt);
>  	buckets = amt->hash_buckets;
>  
>  	spin_lock_bh(&tunnel->lock);
> +	if (READ_ONCE(gnode->dead)) {
> +		spin_unlock_bh(&tunnel->lock);
> +		rcu_read_unlock();
> +		dev_put(amt->dev);
> +		return;
> +	}

[Severity: High]

This isn't a bug introduced by this patch, but can the new gnode->dead
check actually protect amt_group_work() from amt_del_group()?

amt_del_group() does a non-sync cancel and then frees the gnode:

    if (cancel_delayed_work(&gnode->group_timer))
        dev_put(amt->dev);
    hlist_del_rcu(&gnode->node);
    ...
    kfree_rcu(gnode, rcu);

process_one_work() clears PENDING before it calls amt_group_work(), so
cancel_delayed_work() returns false and does not wait. The rcu_read_lock()
above is only taken after the callback has started. A kfree_rcu() queued
between the PENDING clear and rcu_read_lock() is therefore not held off.
With CONFIG_PREEMPT_RCU the kworker can be preempted in that window and a
grace period can complete.

In that case the callback reads gnode->tunnel_list, gnode->amt and
gnode->dead from freed memory. It then calls spin_lock_bh() through a stale
tunnel pointer and dev_put() on a stale amt->dev.

A remote gateway can reach amt_del_group() at the same time, for example
with an IGMPv2 Leave through amt_igmpv2_leave_handler() or an MLDv1 Done
sent just as group_timer fires.

amt_source_work() has the same pattern with snode->gnode and
gnode->tunnel_list. __amt_source_gc_work() also frees snodes without
calling cancel_delayed_work_sync() on snode->source_timer.

The flag lives inside the object being freed, so it can't protect the
callback that loads it. Would this need synchronous cancellation, or a
reference that covers the callback's entry?

As far as I can tell, the final patch in the series ("amt: harden relay
authentication and teardown") does not change amt_del_group(),
amt_group_work(), amt_source_work() or __amt_source_gc_work(), so the
problem is still there at the end of the series.

[ ... ]

> @@ -1328,8 +1350,30 @@ static void amt_tunnel_expire(struct work_struct *work)
>  						      struct amt_tunnel_list,
>  						      gc_wq);
>  	struct amt_dev *amt = tunnel->amt;
> +	unsigned long deadline;
>  
>  	spin_lock_bh(&amt->lock);

[ ... ]

> +	deadline = READ_ONCE(tunnel->last_seen) +
> +		   msecs_to_jiffies(amt_gmi(amt)) * 3;
> +	if (time_before(jiffies, deadline)) {
> +		mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - jiffies);
> +		spin_unlock_bh(&amt->lock);
> +		return;
> +	}
> +	spin_lock_bh(&tunnel->lock);
> +	WRITE_ONCE(tunnel->dead, true);
> +	spin_unlock_bh(&tunnel->lock);
>  	rcu_read_lock();
>  	list_del_rcu(&tunnel->list);
>  	amt->nr_tunnels--;

[ ... ]

> @@ -2494,9 +2538,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
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

[Severity: High]

Does this fully close the race the commit message describes? The Update
path still holds the tunnel pointer it cached from the RCU walk. After
goto report it does:

amt_update_handler()
    spin_lock_bh(&tunnel->lock);
    amt_igmp_report_handler(amt, skb, tunnel);
    spin_unlock_bh(&tunnel->lock);

The amt_mld_report_handler() path is the same, and neither path checks
tunnel->dead.

last_seen is written here without amt->lock. amt_tunnel_expire() can
therefore read the old value, decide the tunnel has expired, and run:

amt_tunnel_expire()
    WRITE_ONCE(tunnel->dead, true);
    list_del_rcu(&tunnel->list);
    amt_clear_groups(tunnel);
    kfree_rcu(tunnel, rcu);

Suppose the Update takes tunnel->lock after amt_clear_groups() has released
it. Could amt_add_group() then link a new gnode into the dying tunnel and
arm group_timer with dev_hold()? For example, in
amt_igmpv2_report_handler():

    if (!mod_delayed_work(amt_wq, &gnode->group_timer,
                          msecs_to_jiffies(amt_gmi(amt))))
        dev_hold(amt->dev);

When group_timer fires later, amt_group_work() reads gnode->tunnel_list
and calls spin_lock_bh(&tunnel->lock) on the freed tunnel. The gnode and
the device reference also look leaked.

This is the same class of problem the commit message sets out to close: an
Update holding a cached tunnel pointer arms delayed work that outlives the
tunnel.

The later patch in this series, "amt: harden relay authentication and
teardown", adds a tunnel->dead check after both spin_lock_bh(&tunnel->lock)
calls in amt_update_handler(). This patch carries the Fixes: tag, so would
it make sense to move that check here?

[ ... ]

> @@ -2732,6 +2780,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	for (i = 0; i < amt->hash_buckets; i++)
>  		INIT_HLIST_HEAD(&tunnel->groups[i]);
>  
> +	tunnel->last_seen = jiffies;
>  	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
>  
>  	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
> @@ -2739,7 +2788,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
>  	amt->nr_tunnels++;
>  	mod_delayed_work(amt_wq, &tunnel->gc_wq,
> -			 msecs_to_jiffies(amt_gmi(amt)));
> +			 msecs_to_jiffies(amt_gmi(amt)) * 3);
>  	spin_unlock_bh(&amt->lock);

[Severity: Medium]

Is this lifetime change intended? Before this patch, a tunnel created by a
Request had gc_wq armed for GMI. Only an authenticated Membership Update
extended it to 3*GMI.

Now the initial arm here and the re-arm in amt_tunnel_expire() both use
last_seen + 3*GMI. A tunnel that never sends an Update therefore lives
3*GMI.

Requests carry no MAC, so spoofed sources can now hold each of the
max_tunnels slots three times as long. The commit message doesn't mention
this change.

The later patch "amt: harden relay authentication and teardown" makes
amt_request_handler() stateless, so tunnels are only created after a
verified Update. That removes the problem in the final tree.

Could this patch keep the old GMI lifetime for tunnels that have never
sent an Update, or at least describe the change in the commit message?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015220648.1545576-1-omar%40blockcast.net
