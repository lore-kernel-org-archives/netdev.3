Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D55221C2;
	Thu, 15 Oct 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086951; cv=none; b=NmGImTKbRthBjltx2EzKnp5IuoTooSKOiv7BkraM6BBltRVngFh3gjXvatFiXdePMu16gb5Ep2WaUg688AyWhvv6d1m2R1RAcIc6L+l9MJd/yJtYMTrzqxLszpTF6Qwf1Kk0q9bSZLuL6fPeLckkQc4xaKafn6lYjDwdgd/zbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086951; c=relaxed/simple;
	bh=fmHIgjl2GSZoL07TNKHgQlWAFox1RYvGFcivGGLdCXA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gz/2wurqq2QZYRcfYe1vLgH+bYSqR74uwnB9H+v+TivaG8to1SQSL4wCVqj8ZxogYAbyZfiD5LZWoztk8SJ+rIIRwkq9QOUd1qidoPW5OFWA3cjW8itsAeaJ9ODjk86ZvswFcinE/JY+BeejfE9D1QPGz8RmX8jbwPwdRYuNl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMqVlsRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMqVlsRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8A91F000C7;
	Thu, 15 Oct 2026 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792086938;
	bh=8FVSRhIY/zA5GK19HOsa4msliOtNTbH3X7xUynyLW/g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mMqVlsRSIGicwoFYWXR+d1wRJ7AT/YPzBSp1AIpiTx5cdoOR1zds9mAZKhOMqlHc0
	 JsImrNkBP0FBbfMbNcoHd6mRrz7r8qPgUvmS0BQvpaWzFNYW1RJwTqspApk8AXi2cY
	 jT+sQK60exESLWOUFaKH7hXhYhxQLFTU3bIFuEf67NOaMKGghZbUMHra0D+bU3mGlY
	 jBoEQNZvmExV9FvGerrZK6wwZ8Zex+pFkZ+eqfMXm3W1AtG+/n3EMdGtNJX1RLYpQf
	 bqUBEKXRdgPMLuHhgduzwpEZFvYx0k331Gr0x7Uai1B7LSu79oW/PziqTAGr0nt6Zb
	 7bn6jSW9swvng==
Subject: Re: [PATCH net v4 5/5] amt: harden relay tunnel lifetime and request
 admission
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Thu, 15 Oct 2026 17:55:37 +0000
Message-ID: <179208693703.434549.2704731380004848658@kernel.org>
In-Reply-To: <20261013175407.947606-6-omar@blockcast.net>
References: <20261013175407.947606-6-omar@blockcast.net>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit "amt: make pre-query report drops visible" (in this
  baseline-to-target range) converted only amt_dev_xmit()'s counter…
- [Low] Two new comments about the per-source tunnel cap describe the
  code wrongly.
- [Low] The selftest comment above test_query_egress()
  (tools/testing/selftests/net/amt.sh:256-259) is now stale.
- [Low] amt_update_handler() now reads tunnel->dead with READ_ONCE()
  while holding tunnel->lock (drivers/net/amt.c:2696 and 2720).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the
  group/source workers can still race with group deletion and cause a…

--

amt: harden relay tunnel lifetime and request admission

This patch makes AMT relay Membership Requests stateless. The Query MAC is
derived from the source address, port, nonce and a rotating key, and tunnel
state is only created once a Membership Update has been authenticated.
Tunnels are keyed by (address, port), four key generations are kept, new
endpoints over the global or per-source limits are dropped silently, and
tunnel->dead is rechecked under tunnel->lock in the Update path.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 884f27fd84a4a..0124f1be673b3 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -797,7 +802,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
>  		return;
>  
>  	skb_pull(skb, sizeof(struct ethhdr));
> -	if (amt_send_membership_query(amt, skb, tunnel, false)) {
> +	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
> +				      false)) {
>  		amt->dev->stats.tx_dropped++;
>  		kfree_skb(skb);
>  	}

[Severity: Medium]
The previous patch in this series, "amt: make pre-query report drops
visible", changed amt_dev_xmit() to use DEV_STATS_INC() for tx_dropped and
tx_errors "so concurrent increments are not lost". Can concurrent
increments still be lost on this counter?

amt_send_igmp_gq() and amt_send_mld_gq() still do a plain read-modify-write
on the same field:

    amt->dev->stats.tx_dropped++;

In relay mode, amt_request_handler() runs from UDP softirq on one CPU, and
amt_dev_xmit() can take its free path on another CPU at the same time:

    free:
        dev_kfree_skb(skb);
        DEV_STATS_INC(dev, tx_dropped);

Nothing serialises these two paths. The plain store can therefore
overwrite the atomic increment.

The tx_errors++ sites in amt_send_discovery(), amt_send_request(),
amt_send_advertisement() and similar helpers mix the two kinds of update
in the same way.

Should these sites use DEV_STATS_INC() as well?

[ ... ]

> @@ -1115,9 +1131,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
>  			    0);
>  }
>  
> +/* Send a Membership Query to a source that has not been authenticated yet.
> + *
> + * No per-source state exists at this point and none is created: the nonce and
> + * the keyed MAC are carried in the Query and recomputed from the Membership
> + * Update when it comes back, so everything this needs is passed by value.
> + */
>  static bool amt_send_membership_query(struct amt_dev *amt,
>  				      struct sk_buff *skb,
> -				      struct amt_tunnel_list *tunnel,
> +				      __be32 daddr, __be16 dport,
> +				      __be32 nonce, u64 mac,
>  				      bool v6)

[Severity: Low]
This isn't a bug, but the comment above test_query_egress() in
tools/testing/selftests/net/amt.sh still describes the old design:

    # The relay sends its General Queries straight from the receive path, in
    # the same context that found the tunnel. A query queued on the amt device
    # instead could outlive the tunnel it was built for.

After this patch, amt_request_handler() replies to a Request without
looking up or creating a tunnel. The Query helpers now take daddr, dport,
nonce and mac by value.

Should the selftest comment be updated to match? The egress check itself
still looks useful.

[ ... ]

> @@ -2556,6 +2693,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
>  		}
>  
>  		spin_lock_bh(&tunnel->lock);
> +		if (READ_ONCE(tunnel->dead)) {
> +			spin_unlock_bh(&tunnel->lock);
> +			return true;
> +		}
>  		amt_igmp_report_handler(amt, skb, tunnel);
>  		spin_unlock_bh(&tunnel->lock);

[Severity: Low]
This check reads tunnel->dead with READ_ONCE() while holding tunnel->lock.
Both writers use a plain store and hold only amt->lock:

amt_tunnel_expire():
    tunnel->dead = true;
    rcu_read_lock();
    list_del_rcu(&tunnel->list);

amt_dev_stop():
    list_for_each_entry(tunnel, &amt->tunnel_list, list)
        tunnel->dead = true;

In amt_tunnel_expire(), the store happens before amt_clear_groups() takes
tunnel->lock, so it can run concurrently with this load.

The logic itself still holds, because of the tunnel->lock release/acquire
in amt_clear_groups(). Would KCSAN still report this as a data race?
Should the two writers use WRITE_ONCE()?

> @@ -2576,6 +2717,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
>  		}
>  
>  		spin_lock_bh(&tunnel->lock);
> +		if (READ_ONCE(tunnel->dead)) {
> +			spin_unlock_bh(&tunnel->lock);
> +			return true;
> +		}
>  		amt_mld_report_handler(amt, skb, tunnel);
>  		spin_unlock_bh(&tunnel->lock);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The new
dead checks only cover the Update path. Can the group and source timer
workers still race with group deletion?

amt_group_work() reads its owners and takes the tunnel lock before it has
any lifetime protection:

    struct amt_tunnel_list *tunnel = gnode->tunnel_list;
    struct amt_dev *amt = gnode->amt;
    ...
    spin_lock_bh(&tunnel->lock);

amt_source_work() follows the same pattern.

amt_del_group() does not wait for a worker that is already running:

    if (cancel_delayed_work(&gnode->group_timer))
        dev_put(amt->dev);
    hlist_del_rcu(&gnode->node);
    ...
    kfree_rcu(gnode, rcu);

amt_del_group() is called from several places:

  - amt_clear_groups(), from amt_tunnel_expire() and from amt_dev_stop().
    amt_dev_stop() only sync-cancels tunnel->gc_wq.
  - Leave handlers such as amt_igmpv2_leave_handler().

amt_wq is WQ_UNBOUND.

Two outcomes look possible.

On preemptible kernels, the worker can be preempted before spin_lock_bh().
It is not an RCU reader at that point. After the grace period it can
resume and access a freed gnode or tunnel.

On any kernel, the worker can spin on tunnel->lock while the deleter holds
it. Once the lock is released, the worker sees MCAST_EXCLUDE with empty
source buckets and calls amt_del_group(amt, gnode) a second time.
hlist_del_rcu() then writes through LIST_POISON2, and kfree_rcu() runs
twice on the same gnode.

[ ... ]

> diff --git a/include/net/amt.h b/include/net/amt.h
> index 0520121ded649..63bb647a4780f 100644
> --- a/include/net/amt.h
> +++ b/include/net/amt.h

[ ... ]

> @@ -394,6 +392,12 @@ struct amt_dev {
>  #define AMT_SECRET_TIMEOUT	60000
>  #define IANA_AMT_UDP_PORT	2268
>  #define AMT_MAX_TUNNELS         128
> +/* Per-source tunnel cap.  A single gateway needs at most one tunnel per
> + * family; this stops one verified source endpoint from monopolising the
> + * AMT_MAX_TUNNELS-slot table.  Deployments that legitimately need more behind
> + * one address (e.g. CGNAT) use the configurable net-next per-source bound.
> + */
> +#define AMT_MAX_TUNNELS_PER_SRC 16

[Severity: Low]
Is this comment accurate? What does "the configurable net-next per-source
bound" refer to?

The IFLA_AMT_* attributes in include/uapi/linux/amt.h include no
per-source limit. amt_newlink() applies IFLA_AMT_MAX_TUNNELS only to
amt->max_tunnels. Both amt_tunnel_get_or_create() and amt_request_handler()
compare against the fixed AMT_MAX_TUNNELS_PER_SRC.

The "one tunnel per family" rationale also appears in the
amt_tunnel_get_or_create() comment. It doesn't seem to match the data
model:

  - struct amt_tunnel_list has no family field.
  - Tunnels are keyed only by (ip4, source_port).
  - amt_update_handler() feeds both IGMP and MLD reports into the same
    tunnel.

So a single gateway endpoint uses one tunnel, and the comment doesn't
explain why the value is 16.

Could both comments describe the actual limit and the reason for 16?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013175407.947606-1-omar%40blockcast.net
