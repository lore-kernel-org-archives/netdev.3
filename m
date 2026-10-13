Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8933BBFDE;
	Tue, 13 Oct 2026 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900114; cv=none; b=a/INEVJtSlXjSKxdWa3ZxiXhHrmGRPw0qWYb9xk42btq7QkhKnA15uFL0Wkw4W2/Plz7HkMS37GWdZwpHlAX6JXBKru3Yulp1ZA/NSjQsCv05cY9W3nATksahMS9yCM77YhHSkFv9Bik5LaOyyuxS0eTpibbvqdn3oFybgMPXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900114; c=relaxed/simple;
	bh=w5FL9RNExw3bY8piaYlmuJn4o2n2AhHA8hIo+dpDhSo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qP7JRlX3j79mJitLz+vPcVtiOeqEJgEK6C7TvO+BouKdq3ndxFMkJKK8cTyUHByc6SELSaT8FwmTkSGspCtLCle66K4jdId4gutI7fA3yoMepxpNv7bjAMQtI5UyWjZIr+rZ2BinhQFrtywP227Qqnld8BlIqAcTJvU/hCBazgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS0J3+sP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS0J3+sP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE531F00893;
	Tue, 13 Oct 2026 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900112;
	bh=V8IPCcyqZDKpqkfdwrfktRi8wy6COjwoS7AKatc7hkA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WS0J3+sPW2xw19MUzQQ/Ls2SAKy2FW8VcjRphG1e7YrhYjSP0yTrCHrF9nJdqWmuz
	 q7TqxSirCK9d3JdmKpcNB9/gzknY4gTAEKGppXU5jj5LhWbazODv+znrt40aPwMQva
	 7GXeQwZwOM+eySPAMaS49Joo0bJT48QjWBjwOzOjmhh3c9UE1NlxqHqREmnCkSO0jo
	 b2vLR/hNUNj11dg8kH4Xo1VMIMnL58+56xcxvWqyXjarnLmvc6IW+m3Np+YRdQFF3T
	 zurMWK/3Sdhy0Q7aFwMdmBvR4DPG1flWgit3yDaDVI0AOx2v8OQXSYqhpNa9FgsZc8
	 VU0WVa8eWVMow==
Subject: Re: [PATCH net v3 4/6] amt: key relay tunnel state on the (address,
 port) endpoint, not the address
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Tue, 13 Oct 2026 14:01:51 +0000
Message-ID: <179190011156.434549.10635977207070103643@kernel.org>
In-Reply-To: <20261012125943.558629-5-omar@blockcast.net>
References: <20261012125943.558629-5-omar@blockcast.net>
X-sashiko-severity: Critical
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

Critical: 1 · High: 1 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The Update-versus-expiry use-after-free that the commit
  "amt: fix use-after-free when a Membership Update re-arms a freed…
- [High] In amt_dev_stop() (drivers/net/amt.c), the tunnel list is moved
  onto a local stack list with list_splice_init() while RCU receive…
- [Medium] At the reviewed commit, keying tunnels on (address, port) in
  amt_request_handler() removes the implicit limit of one tunnel per…

Pre-existing issues:
- [Medium] At the reviewed commit, amt_request_handler() does a lockless
  RCU lookup and then allocates and inserts a tunnel under amt->lock…
- [Low] At the reviewed commit, the send: path in amt_request_handler()
  writes tunnel->nonce and tunnel->mac (a u64:48 bitfield) with no lock,…

--

amt: key relay tunnel state on the (address, port) endpoint, not the address

This commit adds the UDP source port to the relay tunnel lookups in
amt_request_handler() and amt_update_handler(), so tunnels are keyed on
the (address, port) endpoint described in RFC 7450 s4.2.2.
amt_update_handler() saves the source port before iptunnel_pull_header()
strips the encapsulation. The commit message notes that this removes the
implicit one-tunnel-per-address bound, which is to be restored separately.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 550b0a5e73766..2feb418e87edb 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -2512,7 +2515,8 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	skb_reset_network_header(skb);
>  
>  	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
> -		if (tunnel->ip4 == saddr) {
> +		if (tunnel->ip4 == saddr &&
> +		    tunnel->source_port == sport) {

[Severity: High]
This patch doesn't change it directly, but this lockless walk of
amt->tunnel_list can now race with the list_splice_init() that
"amt: fix use-after-free when a Membership Update re-arms a freed tunnel"
added to amt_dev_stop() earlier in this series. Is that safe?

amt_dev_stop() has one grace period, and it runs before
udp_tunnel_sock_release() clears sk_user_data:

drivers/net/amt.c:amt_dev_stop() {
	...
	RCU_INIT_POINTER(amt->sk, NULL);
	synchronize_net();
	if (sk)
		udp_tunnel_sock_release(sk);
	...
	spin_lock_bh(&amt->lock);
	list_for_each_entry(tunnel, &amt->tunnel_list, list)
		tunnel->dead = true;
	list_splice_init(&amt->tunnel_list, &doomed);
	amt->nr_tunnels = 0;
	spin_unlock_bh(&amt->lock);
	...
}

udp_tunnel_sock_release() calls rcu_assign_sk_user_data(sk, NULL) but does
not wait for receivers that are already running. A Membership Update that
arrives after the synchronize_net() can therefore still get amt in
amt_rcv(). amt_update_handler() has no netif_running() check before this
walk.

Suppose the reader is mid-walk when the splice happens. The last entry's
next pointer then points at &doomed on amt_dev_stop()'s stack, and
doomed.next points back to the first tunnel. The loop only stops at
&amt->tunnel_list. If no key matches, wouldn't the reader treat &doomed as
a struct amt_tunnel_list, read ip4/source_port from the stack, and keep
looping?

Once amt_dev_stop() returns and that stack slot is reused, the reader
follows garbage pointers. If the garbage happens to match the key, the
WRITE_ONCE(tunnel->last_seen, jiffies) below writes through it. The
baseline removed each entry with list_del_rcu(), which did not have this
problem.

There is a second issue in the final state of the series. A lockless miss
in amt_tunnel_get_or_create() falls through to the locked path. That path
sees the now-empty list with nr_tunnels == 0, so it can add a new tunnel
with gc_wq armed after amt_dev_stop() has finished its cleanup pass.

>  			if ((nonce == tunnel->nonce &&
>  			     response_mac == tunnel->mac)) {
>  				/* Refresh liveness only.  gc_wq is re-armed by

[Severity: Critical]
Can a Membership Update still add a group to a tunnel that
amt_tunnel_expire() has already torn down?

The tunnel is found here without a lock. The Update then only does
WRITE_ONCE(tunnel->last_seen, jiffies) before report processing. Nothing
checks tunnel->dead under amt->lock or tunnel->lock.

Meanwhile, amt_tunnel_expire() can read the old last_seen under amt->lock
and retire the tunnel:

drivers/net/amt.c:amt_tunnel_expire() {
	...
	tunnel->dead = true;
	rcu_read_lock();
	list_del_rcu(&tunnel->list);
	amt->nr_tunnels--;
	amt_clear_groups(tunnel);
	rcu_read_unlock();
	spin_unlock_bh(&amt->lock);
	kfree_rcu(tunnel, rcu);
}

The Update may take tunnel->lock after amt_clear_groups() has finished. In
that case amt_igmp_report_handler()->amt_igmpv2_report_handler()->
amt_add_group() links a new gnode into the dead tunnel's groups[] and arms
gnode->group_timer for amt_gmi() ms.

RCU keeps the tunnel alive only until the Update's amt_rcv() read section
ends. When group_timer fires later:

amt_group_work()
    struct amt_tunnel_list *tunnel = gnode->tunnel_list;
    ...
    spin_lock_bh(&tunnel->lock);
    ...
    amt_del_group()
        gnode->tunnel_list->nr_groups--;

Don't both of these access the freed tunnel, one of them as a write?

A gateway that received the relay's Query can produce a valid MAC. It can
let the tunnel approach last_seen + 3 * amt_gmi() and then send IGMPv2
joins in Membership Updates around the expiry time.

The baseline already had this group_timer race. However, "amt: fix
use-after-free when a Membership Update re-arms a freed tunnel" earlier in
this series says it closes the Update-versus-expiry use-after-free, and it
only replaced the gc_wq re-arm with a timestamp. The same structure
remains at the end of the series.

[ ... ]

> @@ -2729,7 +2733,8 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  		return true;
>  
>  	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> -		if (tunnel->ip4 == iph->saddr)
> +		if (tunnel->ip4 == iph->saddr &&
> +		    tunnel->source_port == udph->source)
>  			goto send;

[Severity: Medium]
With the port in this lookup, a Request from a new source port always
misses and goes on to allocate a tunnel. The Request is not authenticated
at this point, and only the global nr_tunnels >= max_tunnels check
applies. Can one host take every tunnel slot just by changing its source
port?

By joining the same group on each of those tunnels, the host could also
make amt_dev_xmit() send many copies of the same data toward one address.

The commit message says the per-source bound will come back in a separate
net-next patch. Within this series, "amt: do not create tunnel state for
unauthenticated Requests" later removes allocation from the Request path.
Tunnels are then created only after MAC verification, in
amt_tunnel_get_or_create(), and that commit adds a per-source cap checked
under amt->lock (AMT_MAX_TUNNELS_PER_SRC, 16) with no new UAPI.

Should that bound be part of this patch, or should this patch be ordered
after that change?

>  
>  	spin_lock_bh(&amt->lock);

[Severity: Medium]
This is a pre-existing issue that this patch did not introduce, but the
insert under amt->lock does not repeat the (ip4, source_port) lookup. If
two Requests from the same endpoint are handled at once, could both miss
the lockless walk and each insert a tunnel with the same key?

amt_update_handler() stops at the first key match. If that tunnel's
nonce/mac belong to the other Request, the gateway's Updates are dropped
at "Invalid MAC" until it sends its next Request.

Later in this series, "amt: do not create tunnel state for unauthenticated
Requests" removes allocation from this path. Its
amt_tunnel_get_or_create() repeats the walk under amt->lock before
inserting.

[ ... ]

> @@ -2768,6 +2773,12 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	spin_unlock_bh(&amt->lock);
>  
>  send:
> +	/* source_port is part of the tunnel's identity and is set once, in
> +	 * the allocation path above; the lookup only reaches here on an exact
> +	 * (address, port) match, so it already equals udph->source.  Do not
> +	 * "refresh" it here: doing so let a colliding Request from a new port
> +	 * steal an established tunnel outright.
> +	 */
>  	tunnel->nonce = amtrh->nonce;
>  	mac = siphash_3u32((__force u32)tunnel->ip4,
>  			   (__force u32)tunnel->source_port,

[Severity: Low]
This isn't a bug introduced by this patch, but tunnel->nonce and
tunnel->mac (a 48-bit bitfield) are written here without a lock.
amt_update_handler() reads the same pair without a lock as its
authenticity check:

	if ((nonce == tunnel->nonce &&
	     response_mac == tunnel->mac)) {

Could two concurrent Requests, or a Request racing an Update, leave or
observe a mixed nonce/mac pair, so that a valid Update gets rejected?

Later in this series, "amt: do not create tunnel state for unauthenticated
Requests" removes the stored per-tunnel nonce/mac/key. After that change,
the Update path recomputes the MAC using a copy of amt->key[] taken under
amt->lock.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012125943.558629-1-omar%40blockcast.net
