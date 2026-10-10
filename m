Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E912AEF5;
	Sat, 10 Oct 2026 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666534; cv=none; b=n9cwbVaRFoIqez65RwbwBQcOpzWvmokfJBzzurAvWQ4NMIBSHrU7aCjJ+1PpZ8Fa6VEMR2e2zbhnIkRRSocOeJUgN5UvOdQkQqdUBo+1vt0W4ZHdnzdGNu7SqA6koojqF0So/jZRuSiGVfgRwQqL38ilyT118h3B67rt9i1AEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666534; c=relaxed/simple;
	bh=4sZT1lidg2qUi9wNSszlyezNz1ZQ6LWJsNuulAFWDec=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNBw6Qy4QS4qUHvKbb1bN46ISgDGwcShY+YVm7nOiBtFYvU9RFLjTRtKVHND5sYajuN6tg/5hOZTao0zSsRf97KAs5zfZLa4KDQmgBMcD3Iy17pN4M3ZDzVVfVt7/2p5oZ6S0x3cIVRNNzX3EQQCxMSo+nMLve6xcd/g0tYjNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fStO893j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fStO893j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739F01F000FF;
	Sat, 10 Oct 2026 21:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791666533;
	bh=wGum4GbKA1QmItEo32DpAURITDeGtaFPXEbkaSVSSsU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fStO893jPnxAqdN8Yc602oQ49jgz4rlhJsP0iH7tRVY8ockG+VVxw9gAyzFmMDFt4
	 8C/w/nDe8R9Nw9WslY6+sJ9Ldxp55nGMfSqIETvG3LzRC70uyLSv3q05SJdrlsSySx
	 o3lVZN4iMKNWYu7//b7pvNsba118a23omwRYfxL/hkDsMpjDyA7JRegKL+ijGPBlP8
	 BCMDLfmCyPIoQk8IdaKXUPABxFk+0/5i+nLffADgTpVurhjBUOI8Qp866//FeC92l8
	 oPBL5p65cKGxx4VtPlS29ipkgiuGfAoGbkv98nmUDhj1K1vFusfuPwJPKsVt07YKzJ
	 VcX30QW6Y3FpQ==
Subject: Re: [PATCH net v2 1/3] amt: key relay tunnel state on the (address,
 port) endpoint, not the address
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Sat, 10 Oct 2026 21:08:51 +0000
Message-ID: <179166653195.434549.4491351472065396785@kernel.org>
In-Reply-To: <20261009201455.1904698-2-omar@blockcast.net>
References: <20261009201455.1904698-2-omar@blockcast.net>
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

Critical: 0 (1) · High: 1 · Medium: 1 · Low: 1 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Keying the tunnel lookup on (saddr, sport) instead of saddr
  alone removes the only limit on how many tunnels one source address…
- [Medium] The new `amt->dev->stats.rx_dropped++` on the "Invalid MAC"
  arm of amt_update_handler() counts each rejected Update twice.
- [Low] The new `amt->dev->stats.rx_dropped++` in amt_update_handler() is
  a plain read-modify-write of the shared net_device counter from…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but it is a
  remotely reachable use-after-free that is still present at the end of…
- [Low] amt_request_handler() does its (ip4, source_port) lookup
  locklessly, then takes amt->lock and allocates without looking again.
- [Low] In amt_request_handler() a new tunnel is published with
  list_add_tail_rcu() before tunnel->key is set, and…

--

amt: key relay tunnel state on the (address, port) endpoint, not the address

This patch adds the UDP source port to the relay tunnel lookups in
amt_request_handler() and amt_update_handler(), so tunnels are keyed on
the (address, port) endpoint as RFC 7450 s4.2.2 describes. It also counts
"Invalid MAC" Update drops in rx_dropped.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index b53f8ec556615..ed82f8fac3f0a 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -2491,7 +2494,8 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	skb_reset_network_header(skb);
>  
>  	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
> -		if (tunnel->ip4 == saddr) {
> +		if (tunnel->ip4 == saddr &&
> +		    tunnel->source_port == sport) {
>  			if ((nonce == tunnel->nonce &&
>  			     response_mac == tunnel->mac)) {
>  				mod_delayed_work(amt_wq, &tunnel->gc_wq,

[Severity: Critical]
This problem is older than this patch, but can this mod_delayed_work()
re-arm gc_wq on a tunnel that amt_tunnel_expire() is about to free?

The tunnel comes from a lockless RCU walk, and nothing checks that it is
still on the list before the work is re-armed. The workqueue clears the
pending bit before it calls amt_tunnel_expire(), which then does:

	spin_lock_bh(&amt->lock);
	rcu_read_lock();
	list_del_rcu(&tunnel->list);
	amt->nr_tunnels--;
	amt_clear_groups(tunnel);
	rcu_read_unlock();
	spin_unlock_bh(&amt->lock);
	kfree_rcu(tunnel, rcu);

Here is one possible sequence:

CPU1                                CPU2
                                    amt_rcv()
                                      rcu_read_lock_bh()
                                      amt_update_handler()
                                        finds tunnel in tunnel_list
gc_wq fires, pending cleared
amt_tunnel_expire()
  list_del_rcu(&tunnel->list)
                                        mod_delayed_work(&tunnel->gc_wq)
                                          re-arms gc_wq.timer
  kfree_rcu(tunnel, rcu)
                                      rcu_read_unlock_bh()
tunnel freed after grace period,
gc_wq.timer still queued

The gc_wq expiry is much longer than a grace period, so the timer would
still be in the timer wheel after the tunnel is freed. When it fires,
delayed_work_timer_fn() would work on freed memory. A second
amt_tunnel_expire() would then repeat list_del_rcu() and underflow
nr_tunnels.

This patch makes the race easier to hit, because one host can now hold
many tunnels that expire separately. The same window still exists at the
end of the series. The locked re-check in amt_tunnel_get_or_create() can
find the tunnel while amt_tunnel_expire() waits on amt->lock, and the
caller re-arms gc_wq after it unlocks.

> @@ -2499,7 +2503,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
>  								  * 3);
>  				goto report;
>  			} else {
> +				/* The endpoint match is unique, so no other
> +				 * tunnel can validate this Update. Count the
> +				 * drop: an unauthenticated Update is not
> +				 * observable from the gateway's own side.
> +				 */

[Severity: Low]
This race is older than this patch, but is the endpoint match really
unique? amt_request_handler() does its (ip4, source_port) lookup without
amt->lock, then takes amt->lock and allocates without looking again:

	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
		if (tunnel->ip4 == iph->saddr &&
		    tunnel->source_port == udph->source)
			goto send;

	spin_lock_bh(&amt->lock);
	if (amt->nr_tunnels >= amt->max_tunnels) {

Two concurrent Requests from the same endpoint could create duplicate
tunnels. The early return on this Invalid MAC arm assumes there is only
one.

Later in the series, "amt: do not create tunnel state for unauthenticated
Requests" seems to fix this. Its amt_tunnel_get_or_create() re-checks
under amt->lock, and that commit also removes this comment.

>  				netdev_dbg(amt->dev, "Invalid MAC\n");
> +				amt->dev->stats.rx_dropped++;

[Severity: Medium]
Does this count each rejected Update twice? amt_update_handler() returns
true here, and amt_rcv() already counts that on its drop path:

drivers/net/amt.c:amt_rcv() {
    ...
		case AMT_MSG_MEMBERSHIP_UPDATE:
			err = amt_update_handler(amt, skb);
			if (err)
				goto drop;
    ...
drop:
	if (err) {
		amt->dev->stats.rx_dropped++;
		kfree_skb(skb);
    ...
}

If so, this part of the commit message is not accurate:

  "Also count the "Invalid MAC" drop in rx_dropped. It is currently a
  netdev_dbg only"

Before this patch, the drop was already counted once through amt_rcv().
The double count is still there at the end of the series, in the
!verified branch of amt_update_handler() after "amt: do not create tunnel
state for unauthenticated Requests".

Could the added increment be removed?

[Severity: Low]
Separately, this is a plain read-modify-write of dev->stats.rx_dropped in
softirq context. amt_rcv() can run on several CPUs at once, so concurrent
invalid Updates can lose increments. This increment also races with the
plain increment at the drop label in amt_rcv().

Removing the extra increment above would fix this too. If it stays, would
DEV_STATS_INC() be the right form?

>  				return true;
>  			}
>  		}

[ ... ]

> @@ -2705,7 +2715,8 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  		return true;
>  
>  	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> -		if (tunnel->ip4 == iph->saddr)
> +		if (tunnel->ip4 == iph->saddr &&
> +		    tunnel->source_port == udph->source)
>  			goto send;
>  
>  	spin_lock_bh(&amt->lock);

[Severity: High]
With the port added to the key, can one host using its own address fill
the whole tunnel table?

Every Request from a new UDP source port now misses this lookup and
allocates a new amt_tunnel_list. The only admission check left is the
device-wide one just below:

	if (amt->nr_tunnels >= amt->max_tunnels) {
		spin_unlock_bh(&amt->lock);
		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
		return true;
	}

A host can open max_tunnels (default 128) sockets on different ports and
send a Request from each. It receives the Membership Query on each port,
since it owns them, and answers with valid Updates. Each refreshing Update
keeps its entry alive through mod_delayed_work() in amt_update_handler().
Once the table is full, every other gateway's Request gets
ICMP_HOST_UNREACH.

No spoofing is needed, so source address filtering does not help. Before
this patch, a non-spoofing host could hold at most one tunnel.

Each of these tunnels also has its own group and source state, and
amt_dev_xmit() calls amt_send_multicast_data() once per tunnel. Would the
relay then send up to max_tunnels copies of each joined stream to the
same address?

The commit message mentions this:

  "Note this removes an accidental bound: while tunnels were keyed on the
  address alone, one source address could never hold more than one
  tunnel, whatever it did. [ ... ] it is restored in a companion net-next
  patch ("amt: bound relay tunnels admitted per source address") rather
  than here, since it adds UAPI and this is a fix."

This patch has a Fixes: tag, so it may be backported to stable without
the net-next patch. Should the per-source bound go in with this fix?

The problem also remains at the end of the series. After "amt: do not
create tunnel state for unauthenticated Requests", the only limit in
amt_tunnel_get_or_create() is still nr_tunnels >= max_tunnels. A
non-spoofing host passes MAC verification on each of its own ports.

[ ... ]

> @@ -2743,6 +2754,14 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	spin_unlock_bh(&amt->lock);
>  
>  send:
> +	/* source_port is part of the tunnel's identity and is set once, in

[ ... ]

> +	 */
>  	tunnel->nonce = amtrh->nonce;
>  	mac = siphash_3u32((__force u32)tunnel->ip4,
>  			   (__force u32)tunnel->source_port,

[Severity: Low]
This problem is older than this patch, but the allocation path above
publishes the tunnel before its key is set:

	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
	tunnel->key = amt->key;

Here, tunnel->nonce and tunnel->mac are also written without a lock, while
amt_update_handler() reads them locklessly.

Could a concurrent Request that finds the new entry compute tunnel->mac
with a zero key? Could amt_update_handler() see a nonce/mac pair that
comes from two different Requests?

Later in the series, "amt: do not create tunnel state for unauthenticated
Requests" appears to resolve this. It removes the per-tunnel nonce, key
and mac, and amt_tunnel_get_or_create() publishes only fully initialised
entries.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009201455.1904698-1-omar%40blockcast.net
