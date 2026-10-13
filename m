Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAA4F052A;
	Tue, 13 Oct 2026 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900116; cv=none; b=sCcS5LZF05pe6H/dlcLkY8LfUf7WvYc3ebdRL2eDogmDsFU+z/uUd5XMlSCMADAjRwfMR/TBQAWgziKLUsVhDaA5hwfLE3HOpKqGIL956NnkaGwLOqa+Bb5QL+9F8CL6wS4J0gkY1y1DDTTrgiv9nw66vg2UuqmvbqIbEuzyO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900116; c=relaxed/simple;
	bh=524txU3e5VTth/mG1B9N4fR3pBhUjeROI6mrtMTM3e8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JmoB2xa6gIWmiL37fJS//2hXyxfmtkEbvZWSJoezfCGyiniB6zq7Eny9aTXFhr4NLeM5QuZ3SOAcGe8gCMvAG2zwZKnq9hbKLQ69oQB9Bki+zTlpAurDo7NghQT7mVyGfgvoeSPkF8iTrRCTf4yxffXRyq7KuXUSjzDIwwYi/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMXXObwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMXXObwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609631F00898;
	Tue, 13 Oct 2026 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900114;
	bh=Ak/fXqyyTWrHjNtmrxRqjan9FnD6djc0o92PY6sgEi8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cMXXObwpZamNepiqwvDTOlKk16I3zB/pWnjjE8MoTQI+L5LgTGnjnOErl3y9jeLiz
	 +HmYsW8a+zbd/m+QGUVEkLaYT+Lzc5ja+UL4DlIZjoQjjQRuEI6u/1d7SnGjnHl7m0
	 li7XtgXnKDt0CyAg7fi7rqdi+BDCjROn8NgaBjkoIpgPsVGkss/aEGSPmylIlClC28
	 tT5HBr8JfmqxHcNS44QopQ6zEj29HKAFspQBL99nPmjaOJS0JFgEqSjxpYMab43GJv
	 +nHvogWfFW5LLTcFG23YDTRYGRP+cnxDRVcNMVUF8ltQCefoqpc+qpMySzXPcjKdX7
	 lYX+ur+bMx/Fg==
Subject: Re: [PATCH net v3 6/6] amt: do not create tunnel state for
 unauthenticated Requests
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Tue, 13 Oct 2026 14:01:53 +0000
Message-ID: <179190011397.434549.2447036763097813905@kernel.org>
In-Reply-To: <20261012125943.558629-7-omar@blockcast.net>
References: <20261012125943.558629-7-omar@blockcast.net>
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

Critical: 0 · High: 0 (3) · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch says three secret generations keep a response MAC
  valid "for 120-180s, at least the amt_gmi() the Query advertised".
- [Medium] amt_request_handler() still sends
  icmp_ndo_send(ICMP_DEST_UNREACH, ICMP_HOST_UNREACH) to the claimed,…
- [Medium] The patch withholds the Query when a later verified Update
  could not be admitted.
- [Low] The comment on AMT_MAX_TUNNELS_PER_SRC in include/net/amt.h says
  deployments needing more than 16 tunnels behind one address "use the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it remains on
  the path the patch rewrites.
- [High] This problem wasn't introduced by this patch, but tunnel
  teardown can free a group and its tunnel while amt_source_work() is…
- [High] This problem wasn't introduced by this patch, but the patch
  moves tunnel allocation to a site where it stays open.

--

amt: do not create tunnel state for unauthenticated Requests

This patch stops amt_request_handler() from allocating tunnel state for
unauthenticated Membership Requests. amt_update_handler() now recomputes
the keyed MAC from packet fields against three rotating secrets. Tunnel
state is created only after an Update verifies, in the new
amt_tunnel_get_or_create(), which also enforces a fixed per-source cap.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index fec32650cb91f..2d9f2d95bd959 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -925,7 +934,13 @@ static void amt_secret_work(struct work_struct *work)
>  					   secret_wq);
>  
>  	spin_lock_bh(&amt->lock);
> -	get_random_bytes(&amt->key, sizeof(siphash_key_t));
> +	/* Rotate: keep the two previous generations so a MAC handed out just
> +	 * before a rotation still verifies for up to three AMT_SECRET_TIMEOUT
> +	 * windows (120-180s), covering the amt_gmi() the Query advertised.
> +	 */
> +	amt->key[2] = amt->key[1];
> +	amt->key[1] = amt->key[0];
> +	get_random_bytes(&amt->key[0], sizeof(siphash_key_t));

[Severity: Medium]
Do three generations actually cover amt_gmi()?

AMT_SECRET_TIMEOUT is 60000 ms and only key[0..2] are kept. A MAC minted
just before a rotation therefore verifies for as little as 120s, and at
most 180s.

With the relay defaults from amt_newlink() (qrv = 2, qi = 125, qri = 10),
amt_gmi() is ((2 * 125) + 10) * 1000 = 260s. The commit message quotes
that figure itself.

Even the 120s floor is shorter than the 125s QQIC that amt_build_igmp_gq()
advertises:

    ihv3->qqic	= amt->qi;

The commit message says:

    Three generations keep a MAC valid for 120-180s, at least the
    amt_gmi() the Query advertised; two generations (120s floor) could
    expire a MAC before the interval it promised.

The same claim is repeated in the new amt_update_handler() comment. Also,
two generations would give a 60s floor, not 120s.

Before this patch, tunnel->mac was stored and stayed valid until the
gateway's next Request replaced it. Take a gateway that refreshes its
Request at the advertised 125s QQIC and got its MAC just before a
rotation. Won't its Updates in the last few seconds of each interval be
dropped in amt_update_handler() as "Invalid MAC", even on an established
tunnel?

The Linux gateway re-requests often enough to avoid this. Third-party
gateways that pace Requests by QQIC would not.

>  	spin_unlock_bh(&amt->lock);

[ ... ]

> @@ -2490,14 +2511,99 @@ static bool amt_membership_query_handler(struct amt_dev *amt,

[ ... ]

> +static struct amt_tunnel_list *amt_tunnel_get_or_create(struct amt_dev *amt,
> +							__be32 saddr,
> +							__be16 sport)
> +{
> +	struct amt_tunnel_list *tunnel;
> +	int per_src = 0;
> +	int i;
> +
> +	tunnel = amt_tunnel_lookup(amt, saddr, sport);
> +	if (tunnel)
> +		return tunnel;

[Severity: High]
This isn't a bug introduced by this patch, but this lockless lookup can
return a tunnel that amt_tunnel_expire() has already marked dead. Does
anything stop the Update path from adding groups to it?

amt_update_handler() takes tunnel->lock and calls
amt_igmp_report_handler() or amt_mld_report_handler(). These can call
amt_add_group(), which stores the tunnel pointer in gnode->tunnel_list and
arms gnode->group_timer with dev_hold(). Nothing on that path checks
tunnel->dead.

A possible interleaving:

CPU1 (amt_update_handler)            CPU2 (amt_tunnel_expire)
amt_tunnel_lookup() finds tunnel
                                     reads stale last_seen
                                     tunnel->dead = true;
                                     list_del_rcu(&tunnel->list);
                                     amt_clear_groups(tunnel);
WRITE_ONCE(tunnel->last_seen, ...);
spin_lock_bh(&tunnel->lock);
amt_igmp_report_handler()
    amt_add_group()   /* new gnode on dying tunnel */
                                     kfree_rcu(tunnel, rcu);

When the orphaned group_timer fires later:

amt_group_work()
    struct amt_tunnel_list *tunnel = gnode->tunnel_list;
    ...
    spin_lock_bh(&tunnel->lock);    /* tunnel already freed */

The same window exists for Updates still in flight while amt_dev_stop()
runs amt_clear_groups().

The comment above WRITE_ONCE(tunnel->last_seen, jiffies) says this "cannot
re-queue the work of a tunnel that is being freed". That holds for gc_wq,
but not for group_timer.

Would checking READ_ONCE(tunnel->dead) under tunnel->lock in the Update
path, and bailing out, close this? ->dead is set before amt_clear_groups()
takes tunnel->lock.

> +
> +	spin_lock_bh(&amt->lock);

[ ... ]

> +	if (amt->nr_tunnels >= amt->max_tunnels ||
> +	    per_src >= AMT_MAX_TUNNELS_PER_SRC) {
> +		spin_unlock_bh(&amt->lock);
> +		return NULL;
> +	}

[Severity: High]
This is a pre-existing issue, but the patch moves tunnel allocation here.
Neither amt_update_handler() nor amt_tunnel_get_or_create() checks whether
the device is running or stopping. Can a tunnel be created after
amt_dev_stop() has drained the list?

amt_dev_stop() does:

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

udp_tunnel_sock_release() clears sk_user_data but doesn't wait for
amt_rcv() callers that already fetched amt. A verified Update received
between synchronize_net() and that clear can get here after the splice.
It would then list_add_tail_rcu() a new tunnel and arm its gc_wq for
3 * amt_gmi().

This stop never tears that tunnel down. amt_dev_uninit() and amt_dellink()
do no tunnel cleanup, and needs_free_netdev is set. After the device is
deleted, amt_tunnel_expire() would do spin_lock_bh(&tunnel->amt->lock) on
a freed amt_dev.

Separately, list_splice_init() is not RCU-safe on the RCU-traversed
tunnel_list. A concurrent amt_tunnel_lookup() or amt_dev_xmit() reader at
the last entry can follow ->next to the on-stack doomed head. The splice
came from an earlier commit in this series.

__LINK_STATE_START is cleared before ndo_stop. Would a netif_running()
check at the start of amt_update_handler(), or under amt->lock here, close
the creation race?

[ ... ]

> +	/* Publish only once the entry is fully initialised. */
> +	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
> +	amt->nr_tunnels++;
> +	mod_delayed_work(amt_wq, &tunnel->gc_wq,
> +			 msecs_to_jiffies(amt_gmi(amt)) * 3);
> +	spin_unlock_bh(&amt->lock);

[Severity: High]
This isn't a bug introduced by this patch. Tunnels created here are torn
down later by amt_tunnel_expire() or amt_dev_stop(). Can that teardown
free a group and its tunnel while amt_source_work() is still running for
one of the group's sources?

amt_source_work() reads the parent pointer before it takes any lock or
RCU read lock:

    tunnel = gnode->tunnel_list;
    spin_lock_bh(&tunnel->lock);
    rcu_read_lock();

The teardown path is amt_clear_groups()->amt_del_group()->
amt_destroy_source(), and amt_destroy_source() only cancels
asynchronously:

    cancel_delayed_work(&snode->source_timer);
    hlist_del_init_rcu(&snode->node);

kfree_rcu(gnode, rcu) and kfree_rcu(tunnel, rcu) are then queued while
the source work may still be running.

With CONFIG_PREEMPT, the worker can be preempted between reading
gnode->tunnel_list and spin_lock_bh(). It is not in an RCU reader at that
point, so the grace period can complete and spin_lock_bh(&tunnel->lock)
runs on freed memory.

Without preemption, the worker can be spinning on tunnel->lock while
amt_clear_groups() holds it. It then calls amt_destroy_source() a second
time on an snode that is already on source_gc_list. hlist_del_init_rcu()
unlinks it from source_gc_list without source_gc_lock, racing
__amt_source_gc_work(), and nr_sources is decremented twice.

amt_dev_stop() only syncs gc_wq and never drains these source works.

[ ... ]

> @@ -2740,67 +2882,42 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)

[ ... ]

> +	spin_lock_bh(&amt->lock);
> +	key = amt->key[0];
> +	full = amt->nr_tunnels >= amt->max_tunnels;
>  	spin_unlock_bh(&amt->lock);

[ ... ]

> +	/* When the table is full, refuse a source that holds no tunnel without
> +	 * sending a Query.  A silent Query would keep the gateway believing the
> +	 * exchange is progressing while its later, verified Update is refused;
> +	 * withholding it lets the gateway's req_cnt climb and drive rediscovery
> +	 * instead.  The ICMP is rate-limited and no state is allocated, so this
> +	 * is not the reflector the pre-verification allocation path used to be.
> +	 * A source that holds a tunnel is answered: its periodic Request is how
> +	 * it renews the response MAC its Updates echo.
>  	 */

[Severity: Medium]
Should the full check above also account for AMT_MAX_TUNNELS_PER_SRC?

It only looks at the global limit. amt_tunnel_get_or_create() also refuses
when per_src >= AMT_MAX_TUNNELS_PER_SRC.

Suppose a source address already holds 16 tunnels and sends a Request
from a new port, for example another gateway behind the same NAT address:

  amt_request_handler() answers with a Query
  gateway: amt_membership_query_handler() sets ready4/ready6, req_cnt = 0
  amt_update_handler()->amt_tunnel_get_or_create() returns NULL
  amt_update_handler() sends ICMP host unreachable
  gateway: amt_err_lookup() does mod_delayed_work(amt_wq, &amt->req_wq, 0)
  next Request is answered with another Query, req_cnt reset again

Doesn't this loop indefinitely? It is the "silent Query" case this comment
says it avoids, and the gateway never reaches rediscovery.

[ ... ]

> -	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
> +	if (full && !amt_tunnel_lookup(amt, iph->saddr, udph->source)) {
> +		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
>  		return true;
> +	}

[Severity: Medium]
Is this still an ICMP reflector toward spoofed sources?

A spoofed victim address never holds a tunnel. So every spoofed Request
that arrives while the table is full still sends ICMP_DEST_UNREACH to its
claimed source, using the same icmp_ndo_send() call as the old full-table
path.

Filling the table now takes verified tunnels. With AMT_MAX_TUNNELS_PER_SRC
at 16, that is 128 / 16 = 8 real IP addresses, or just a table that is
legitimately full of real gateways.

The comment says "is not the reflector the pre-verification allocation
path used to be". The commit message says "The ICMP is rate-limited and
allocates nothing, unlike the old reflector".

The old full-table path also returned before kzalloc() and had the same
icmp_global/inet_peer rate limiting. Also, the ICMP path can allocate: for
each new spoofed destination,
__icmp_send()->icmpv4_xrlim_allow()->inet_getpeer_v4() can create an
inet_peer.

Each spoofed Request also uses up part of the host-wide icmp_msgs_per_sec
budget.

Are these claims in the comment and commit message accurate?

[ ... ]

> diff --git a/include/net/amt.h b/include/net/amt.h
> index 0520121ded649..1c7c144e4db31 100644
> --- a/include/net/amt.h
> +++ b/include/net/amt.h

[ ... ]

> @@ -394,6 +393,12 @@ struct amt_dev {
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
Which configurable per-source bound does this comment refer to?

This tree exposes only IFLA_AMT_MAX_TUNNELS in include/uapi/linux/amt.h,
and there is no module parameter. The check in amt_tunnel_get_or_create()
is unconditional, so a relay with more than 16 gateways behind one public
address has no way to raise it.

This patch carries a Fixes: tag and is described as backportable. Should
the comment avoid pointing stable users at a mechanism that does not exist
here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012125943.558629-1-omar%40blockcast.net
