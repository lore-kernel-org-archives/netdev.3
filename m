Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A537DAA3;
	Sat, 10 Oct 2026 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666537; cv=none; b=dqTng2H6MLgr9ltuZZaZ3frAe5nsfOOBqHsOKifGt3An+bgC3x3gMuriPeDk9gvJGj1xOj/VMGVIme02h1BJqe3kdaYUCg8zUmcwbCRJWRcqFaDCmMOgAT+7omoxr6PH1EOSZSK8BUCORHNaUnVEq9SeM1fb3WwAVT4gaUM5Axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666537; c=relaxed/simple;
	bh=HxDJlHv2+RP53Mbg0H6pjNP4IbMrftYYh/csz6mC9xo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1wup5ecM8LjC6apfPl5Pfs8ScUD14aaa6iURx/Eb1D5GnjX4GxKEeKOz89VyDw3O4SiKwStISVqyf8gjDeHMoBloIXv/dVoiuFsINf5/YS+b3VFw6y/0TfgSRK5dcErGrKQFMdsWWjmbjLlFxSghbY7xkDlmCjsUdTfK+CQQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGxZXkQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGxZXkQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100231F000FF;
	Sat, 10 Oct 2026 21:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791666535;
	bh=JVPUal05KatY+z/I78apTnxe8d9zpa4SJXc95q/sBUw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PGxZXkQ0xoJrKS6FgIkgMNoTVIIpntf0x/DOOcVydJxGUHHW+l0C8wwpMrTvh4tCb
	 ssO8Lgr4kBMiHqa9ldphfaQfPTz1dlnv8sMpp0YFrGTeS2VIl8w5XH8stdL7GDwF5Q
	 gRCL46R6mOlqrdTG3Tunz+xUy2RSrQD33fuPmTLGQgXcy+3NlhN86JkdmLRZF1+FzD
	 OQNIinGtvQjM+Qh6/Q5FVUAhhc4SPcauSmr/MECiutQEdlaBPrsjQGxdUD3AuMnI+W
	 ItTfv6WTFM3d2dUdIvf/NkV9sZjfh64Ju7DmbzW1OuRvngHHb0JW01txGCzdrB7NG+
	 ImNWHYaqFZB7w==
Subject: Re: [PATCH net v2 3/3] amt: do not create tunnel state for
 unauthenticated Requests
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Sat, 10 Oct 2026 21:08:54 +0000
Message-ID: <179166653457.434549.4036433539604908701@kernel.org>
In-Reply-To: <20261009201455.1904698-4-omar@blockcast.net>
References: <20261009201455.1904698-4-omar@blockcast.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Response MACs now expire after 60–120 s.
- [Medium] When the table is full, the relay now refuses only after
  sending a Query.
- [Medium] Every Membership Update rejected for a bad MAC is counted
  twice in rx_dropped.
- [Medium] At device open, packets can be checked against MAC keys that
  are still zero, which lets an attacker create tunnels for spoofed…
- [Low] Parts of the commit message are wrong for the tree this patch
  applies to, and one behaviour change is not mentioned.
- [Low] The selftest's explanation is now out of date.

Pre-existing issues:
- [High] Use-after-free: an Update can re-arm gc_wq on a tunnel that
  amt_tunnel_expire() is unlinking and freeing.
- [High] This problem wasn't introduced by this patch, but amt_dev_stop()
  can unlink and free a tunnel at the same time as that tunnel's…

--

amt: do not create tunnel state for unauthenticated Requests

With this commit, amt_request_handler() no longer allocates tunnel state
for unauthenticated Relay Membership Requests. On Request the relay
computes the response MAC without storing anything. On Update it
recomputes the MAC, accepting either the current or the previous secret.
A tunnel is created only after that check passes.

> Note for reviewers: the MAC covers the UDP source port, so a NAT
> rebinding between Request and Update now changes the recomputed MAC where
> the stored value would have survived it.

[Severity: Low]
Is this accurate for the tree this applies to? In the parent, the Update
lookup already required a matching port:

-		if (tunnel->ip4 == saddr &&
-		    tunnel->source_port == sport) {

The stored MAC was also already computed over tunnel->source_port. So an
Update from a rebound port already matched no tunnel and was dropped.
That behaviour came from "amt: key relay tunnel state on the (address,
port) endpoint, not the address", not from this patch.

> Once full, every further
> Request also emits an ICMP_DEST_UNREACH to the spoofed source, turning
> the relay into an ICMP reflector.

The ICMP reflector is listed as one of the problems being fixed. However,
amt_request_handler() still sends an unsolicited Membership Query to
every claimed source. Only the type of the reply has changed.

The commit message also doesn't say that "relay full" is now reported on
the Update path rather than the Request path. A refused gateway now
always gets a Query, becomes ready, and then gets ICMP host unreachable
for each Update.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 492d450fdb55c..bc8e552a9bad4 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -925,7 +934,8 @@ static void amt_secret_work(struct work_struct *work)
>  					   secret_wq);
>  
>  	spin_lock_bh(&amt->lock);
> -	get_random_bytes(&amt->key, sizeof(siphash_key_t));
> +	amt->key[1] = amt->key[0];
> +	get_random_bytes(&amt->key[0], sizeof(siphash_key_t));
>  	spin_unlock_bh(&amt->lock);
>  	mod_delayed_work(amt_wq, &amt->secret_wq,
>  			 msecs_to_jiffies(AMT_SECRET_TIMEOUT));

[Severity: Medium]
Does this give every response MAC a fixed lifetime that is shorter than
the Query Interval the relay advertises?

amt_secret_work() runs every AMT_SECRET_TIMEOUT (60000 ms) and only one
previous key is kept. A MAC issued at time t therefore stops verifying in
amt_update_handler() at the second rotation after t, which is 60 to 120
seconds later.

Before this patch, each tunnel copied amt->key when it was created, and
that copy never rotated. A gateway's (nonce, MAC) stayed valid for the
whole life of the tunnel.

The relay advertises QQIC = amt->qi (AMT_INIT_QUERY_INTERVAL, 125) in
amt_build_igmp_gq() and amt_build_mld_gq(). Gateways reuse the cached
nonce and MAC from the last Query for every Update, including unsolicited
joins and leaves:

drivers/net/amt.c:amt_send_membership_update() {
    ...
	amtmu->nonce		= amt->nonce;
	amtmu->response_mac	= amt->mac;
    ...
}

Take a third-party gateway that paces its Requests by the advertised
125 second interval. Its joins and leaves would be dropped as "Invalid
MAC" during the last 5 to 65 seconds before each refresh. A lost join
means no multicast until the next cycle. A lost leave means the relay
keeps forwarding until gc.

The Linux gateway in this file sends a new Request about every 2 seconds
(amt_event_send_request() with req_cnt reset by each Query), so it is
not affected.

The commit message describes the two-key window only as covering "an
exchange straddling a rotation". Should it mention this lifetime limit?
Alternatively, should the rotation period or the number of kept keys be
tied to amt->qi?

> @@ -1115,9 +1125,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
>  			    0);
>  }
>  
> +/* Send a Membership Query to a source that has not been authenticated yet.
> + *
> + * No per-source state exists at this point and none is created: the nonce and
> + * the keyed MAC are carried in the Query and recomputed from the Membership
> + * Update when it comes back, so everything this needs is passed by value.
> + */

[Severity: Low]
This isn't a bug, but the comment above test_query_egress() in
tools/testing/selftests/net/amt.sh still describes the Query as tied to
a tunnel:

# The relay sends its General Queries straight from the receive path, in
# the same context that found the tunnel. A query queued on the amt device
# instead could outlive the tunnel it was built for.

After this change amt_request_handler() neither looks up nor creates a
tunnel. Should the selftest comment be updated to match?

>  static bool amt_send_membership_query(struct amt_dev *amt,
>  				      struct sk_buff *skb,
> -				      struct amt_tunnel_list *tunnel,
> +				      __be32 daddr, __be16 dport,
> +				      __be32 nonce, u64 mac,
>  				      bool v6)

[ ... ]

> @@ -2496,36 +2573,58 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(key); i++) {
> +		u64 mac = siphash_3u32((__force u32)saddr,
> +				       (__force u32)sport,
> +				       (__force u32)nonce,
> +				       &key[i]) >> 16;

[ ... ]

> +		if (response_mac == mac) {
> +			verified = true;
> +			break;
>  		}
>  	}
>  
> -	return true;
> +	if (!verified) {
> +		/* Count the drop: an unauthenticated Update is not observable
> +		 * from the gateway's own side.
> +		 */
> +		netdev_dbg(amt->dev, "Invalid MAC\n");
> +		amt->dev->stats.rx_dropped++;
> +		return true;
> +	}

[Severity: Medium]
Is this packet counted twice in rx_dropped?

amt_update_handler() increments rx_dropped and returns true. amt_rcv()
then takes its drop path for the same skb:

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

The extra increment came in with "amt: key relay tunnel state on the
(address, port) endpoint, not the address". This patch moves it but
keeps it, so every spoofed or stale-MAC Update raises rx_dropped by 2.

> +
> +	tunnel = amt_tunnel_get_or_create(amt, saddr, sport);
> +	if (!tunnel) {
> +		/* Out of tunnel slots.  Unlike the Request path this reply
> +		 * only ever goes to a source that has proved it received our
> +		 * Query, so it cannot be used to reflect at a third party.
> +		 */
> +		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
> +		return true;
> +	}

[Severity: Medium]
When the table is full, does this stop the gateway from ever falling back
to rediscovery?

amt_request_handler() now answers every Request with a Query, whatever
the capacity, and the refusal only happens here. With the gateway code in
this file, the sequence becomes:

gateway: amt_membership_query_handler()
    amt->req_cnt = 0;  (ready4/ready6 set to true)
gateway sends Update
relay: amt_update_handler() -> icmp_ndo_send(ICMP_HOST_UNREACH)
gateway: amt_err_lookup()
    mod_delayed_work(amt_wq, &amt->req_wq, 0);
gateway: amt_event_send_request() sees req_cnt == 0, sends a new Request
relay answers with another Query, and req_cnt is reset again

As a result, this give-up branch in amt_event_send_request() can no
longer be reached:

	if (amt->req_cnt > AMT_MAX_REQ_COUNT) {
		...
		WRITE_ONCE(amt->remote_ip, 0);
		amt_update_gw_status(amt, AMT_STATUS_INIT, false);

Before this patch, a full relay answered the Request with ICMP and sent
no Query. req_cnt kept climbing, and the gateway went back to discovery,
where an anycast discovery address could pick another relay.

Now the gateway keeps cycling through Request, Query, Update and ICMP
with a relay that will never admit it, and it reports ready4/ready6 as
true the whole time. Is this change in behaviour intended?

> +
> +	mod_delayed_work(amt_wq, &tunnel->gc_wq,
> +			 msecs_to_jiffies(amt_gmi(amt)) * 3);

[Severity: High]
This is a pre-existing issue, but can this re-arm gc_wq on a tunnel that
amt_tunnel_expire() is in the middle of freeing?

amt_tunnel_get_or_create() returns an existing tunnel either from the
lockless walk or from the re-check after amt->lock is dropped. Here the
only protection is rcu_read_lock_bh() from amt_rcv(). Suppose the
tunnel's gc_wq has already started running:

CPU1 (amt_wq)
amt_tunnel_expire()
    spin_lock_bh(&amt->lock);
    list_del_rcu(&tunnel->list);
    amt->nr_tunnels--;
    amt_clear_groups(tunnel);
    spin_unlock_bh(&amt->lock);
    kfree_rcu(tunnel, rcu);

CPU2 (amt_rcv)
amt_update_handler()
    tunnel = amt_tunnel_get_or_create(...);  /* same tunnel */
    mod_delayed_work(amt_wq, &tunnel->gc_wq, ...);
    amt_igmp_report_handler(amt, skb, tunnel);

The work is running rather than pending, so mod_delayed_work() queues it
again and arms a timer inside an object that is waiting for kfree_rcu().
The report handler also attaches new group and source nodes after
amt_clear_groups() has already run.

When that timer fires, amt_tunnel_expire() runs on freed memory. It calls
list_del_rcu() on a poisoned entry and decrements nr_tunnels a second
time, which underflows it and bypasses max_tunnels. The orphaned group
nodes leak, with timers that point at the freed tunnel.

The lookup has now moved into a new helper. Would it be worth checking
under amt->lock that the tunnel is still on the list (or not marked dead)
before gc_wq is re-armed?

[ ... ]

> @@ -3061,7 +3128,7 @@ static int amt_dev_open(struct net_device *dev)
>  	amt->req_cnt = 0;
>  	WRITE_ONCE(amt->remote_ip, 0);
>  	amt->nonce = 0;
> -	get_random_bytes(&amt->key, sizeof(siphash_key_t));
> +	get_random_bytes(&amt->key, sizeof(amt->key));

[Severity: Medium]
Can Updates be verified against all-zero keys while the device is being
opened?

amt_socket_create() -> setup_udp_tunnel_sock() publishes sk_user_data,
installs encap_rcv = amt_rcv and enables encap before it returns. The
keys are seeded only after that, and without amt->lock:

amt_dev_open()
    err = amt_socket_create(amt);
    ...
    get_random_bytes(&amt->key, sizeof(amt->key));

On the first bring-up the netdev private data is zero-filled, so key[0]
and key[1] are both zero during that window.

With this patch, the only check before admitting a tunnel is recomputing
siphash_3u32(saddr, sport, nonce, key) >> 16. A spoofed Update carrying a
MAC computed offline under the zero key would pass amt_update_handler()
and get a tunnel, plus group joins that forward multicast to the spoofed
address. That entry stays after the keys are randomized.

amt_request_handler(), amt_update_handler() and amt_secret_work() all
access amt->key[] under amt->lock, so readers here can also see a
half-written key. Should the keys be seeded under amt->lock before
amt_socket_create() is called?

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
While looking at tunnel lifetime, though, can amt_dev_stop() double free
a tunnel whose amt_tunnel_expire() is running at the same time?

drivers/net/amt.c:amt_dev_stop() {
    ...
	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
		list_del_rcu(&tunnel->list);
		amt->nr_tunnels--;
		cancel_delayed_work_sync(&tunnel->gc_wq);
		amt_clear_groups(tunnel);
		kfree_rcu(tunnel, rcu);
	}
    ...
}

amt->lock is not held here, and the tunnel is unlinked before gc_wq is
cancelled.

Suppose amt_tunnel_expire() is already running for that tunnel. It takes
amt->lock and calls list_del_rcu() on an entry that dev_stop has already
unlinked, which writes through LIST_POISON2.

cancel_delayed_work_sync() then waits for expire, which calls
kfree_rcu(tunnel), and dev_stop calls kfree_rcu(tunnel) a second time.
nr_tunnels is also decremented twice.

>  
>  	amt->status = AMT_STATUS_INIT;
>  	if (amt->mode == AMT_MODE_GATEWAY) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009201455.1904698-1-omar%40blockcast.net
