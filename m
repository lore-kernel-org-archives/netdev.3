Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E9134CCF;
	Sun, 20 Sep 2026 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789942732; cv=none; b=kYFG+7VdUtMml0ktL6mMz6dZO8iC8j99ERNP1zwjJdFa0rsacYJbKIM7Y6a/UhjknBRoDlVim4GeX5p2Q8VH3FLgeSCYii2s+s81+/pciI3P6+3tOLo8uY6ZDvZN3rxPwnS8PNT89Z8v2Rd6Nny5tOtoIi3JNEksKFVPUAEKMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789942732; c=relaxed/simple;
	bh=tunxSH7Vy0oNLKwcFoWpxucWz5WWt+mEER2EmCGOjUs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=macH8jnpzoj3NR6tfY+yuO+BQ1I5On675ofWbNJ59gGR+2SQsVUF7GKH4+jzZC4WjS/0I45B5NI9QamQE0cx1GWkdkuo4QprQp+BBMqQ1sZFFDFhRtD04m3fQRGVqmp8O41QXxbKkN3kdsp4p7YV7BBCZPtav/dQc8hxB9G+JGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2uYYyAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2uYYyAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719D71F000FF;
	Sun, 20 Sep 2026 22:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789942730;
	bh=HlU4VtQzAA5dJyBq5icoe66mdwUSF8mdWmk837/8fe4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J2uYYyAwGeidsHlGbMMyr86y/z/i3FbM2wvZegcrT2X71F7aipl/uZN7OkdIYAY8z
	 koUeMThWta68eoo6hZVtxSNh2HHnf4jUt6e2syER0ZEgH985auMZ71qPyTMATFSEO9
	 +gTvo6tJ1bOUL5uhQuLvx9oT+RKHJqnXfl8bdDwo0ZVKrOz6WKxv36fLvogBOIWGDl
	 pCf2PPcnCvUP3MKgF6oTRG+Oe9UL2zY/kzv5Lq/9BQkDhAnsGRs3NmE1rVLSD5cNTv
	 APQTB9evGFcOpDWFAkcLzGPUxVpKurJQzBNFphaZynaZdqOqR+niDbhB3vCeclVd6l
	 S0p+2TyyBAy5A==
Subject: Re: [PATCH] ipmr: validate IPv4 header length in reg_vif_xmit() and
 zero iphdr in ipmr_get_route()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:18:49 +0000
Message-ID: <178994272995.2160803.16678167410882495802@kernel.org>
In-Reply-To: <20260919221737.3708462-1-benquike@gmail.com>
References: <20260919221737.3708462-1-benquike@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In `rt_fill_info()` (net/ipv4/route.c:3089-3095) the patch adds
  `nlmsg_end(skb, nlh)` on the path where `ipmr_get_route()` returned 0,…
- [High] Two factual claims in the changelog are contradicted by the
  code.
- [Medium] The commit message does not describe the net/ipv4/route.c
  change at all, and misattributes the ipmr.c memset to route.c.
- [Medium] The new early `nlmsg_end(skb, nlh)` in `rt_fill_info()`
  produces a reply format that no other exit of that function produces…

--

ipmr: validate IPv4 header length in reg_vif_xmit() and zero iphdr in ipmr_get_route()

This adds a pskb_may_pull() check to reg_vif_xmit() before the encapsulated
packet is handed to ipmr_cache_report(), zeroes the synthetic IPv4 header
built in ipmr_get_route(), and adds an nlmsg_end() call to one early return
in rt_fill_info().

A few questions below about the changelog and about the route.c hunk.

>     Fix two bugs in IPv4 multicast routing:
>     
>     1. In reg_vif_xmit() (net/ipv4/ipmr.c), verify that the skb contains a
>        full IPv4 header with ihl >= 5 before reading ip_hdr(skb) and passing
>        the encapsulated PIM register packet to ipmr_cache_report().
>     2. In ipmr_get_route() and inet_rtm_getroute() (net/ipv4/route.c), zero-
>        initialize the synthetic IPv4 header pushed onto the RTM_GETROUTE
>        probe skb so uninitialized slab bytes in iph->ihl / iph->tos /
>        iph->frag_off do not corrupt fib_multipath_hash() or
>        ipmr_cache_alloc().

[Severity: Medium]
Does the changelog match the diff?  The patch has three hunks:

  - pskb_may_pull() in reg_vif_xmit(), net/ipv4/ipmr.c
  - memset(iph, 0, sizeof(*iph)) in ipmr_get_route(), net/ipv4/ipmr.c
  - nlmsg_end(skb, nlh) in rt_fill_info(), net/ipv4/route.c

Point 2 says the zero-initialization happens "In ipmr_get_route() and
inet_rtm_getroute() (net/ipv4/route.c)", but there is no memset added to
route.c and inet_rtm_getroute() is not touched.  The only route.c change is
the nlmsg_end() call, which alters what userspace receives on a
RTM_GETROUTE reply and is not mentioned in the changelog at all.

Could these be split into separate patches, each with its own Fixes: tag,
so a stable backporter can see that a Netlink reply framing change rides
along with the two memory-safety changes?

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c45..8242ab62d1b3 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -545,6 +545,13 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
>  		return err;
>  	}
>  
> +	if (!pskb_may_pull(skb, sizeof(struct iphdr))) {
> +		DEV_STATS_INC(dev, tx_dropped);
> +		rcu_read_unlock();
> +		kfree_skb(skb);
> +		return NETDEV_TX_OK;
> +	}
> +

[Severity: High]
The changelog promises an "ihl >= 5" check here, but this code only
guarantees that 20 bytes are linear.  It never reads ip_hdr(skb)->ihl, so
an skb with 20 or more pullable bytes and ihl < 5 (or ihl * 4 > skb->len)
still gets counted in tx_bytes/tx_packets and passed on to
ipmr_cache_report(), which derives the header length from that same
unvalidated field:

net/ipv4/ipmr.c:ipmr_cache_report() {
	...
	const int ihl = ip_hdrlen(pkt);
	...
}

Should the check also validate ihl, or should the changelog drop the
"with ihl >= 5" wording?

>  	DEV_STATS_ADD(dev, tx_bytes, skb->len);
>  	DEV_STATS_INC(dev, tx_packets);
>  
> @@ -2492,6 +2499,7 @@ int ipmr_get_route(struct net *net, struct sk_buff *skb,
>  		skb_push(skb2, sizeof(struct iphdr));
>  		skb_reset_network_header(skb2);
>  		iph = ip_hdr(skb2);
> +		memset(iph, 0, sizeof(*iph));
>  		iph->ihl = sizeof(struct iphdr) >> 2;

[Severity: High]
Is the stated rationale for this memset right?  iph->ihl is assigned on
the very next line, so it cannot be uninitialized, and neither
fib_multipath_hash() nor ipmr_cache_alloc() reads this synthetic header.

What the memset does appear to fix is an infoleak: with iph->ihl = 5, the
IGMPMSG_NOCACHE path reached via ipmr_cache_unresolved() copies the whole
20-byte header out to the mroute socket:

net/ipv4/ipmr.c:ipmr_cache_report() {
	...
	skb_put(skb, ihl);
	skb_copy_to_linear_data(skb, pkt->data, ihl);
	...
}

so tos, tot_len, id, frag_off, ttl, protocol and check were coming from
uninitialized headroom bytes.  Could the changelog describe that instead?

>  		iph->saddr = saddr;
>  		iph->daddr = daddr;
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 37674d76f90f..1cba70e38507 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -3087,8 +3087,10 @@ static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
>  							 r, portid);
>  
>  				if (err <= 0) {
> -					if (err == 0)
> +					if (err == 0) {
> +						nlmsg_end(skb, nlh);
>  						return 0;
> +					}
>  					goto nla_put_failure;
>  				}

[Severity: High]
Can this change what userspace sees for RTM_GETROUTE?  A return of 0 from
ipmr_get_route() means the MFC lookup missed and a copy of the half-built
reply was queued for a deferred answer:

net/ipv4/ipmr.c:ipmr_get_route() {
	...
	skb2 = skb_realloc_headroom(skb, sizeof(struct iphdr));
	...
	err = ipmr_cache_unresolved(mrt, vif, skb2, dev);
	rcu_read_unlock();
	return err;
}

The early return is taken before RTA_IIF and before rtnl_put_cacheinfo(),
so nlmsg_end() now stamps a full nlmsg_len onto a message that has neither
RTA_CACHEINFO nor RTA_IIF.  inet_rtm_getroute() only bails on negative
errors:

net/ipv4/route.c:inet_rtm_getroute() {
	...
	if (err < 0)
		goto errout_rcu;

	rcu_read_unlock();

	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
	...
}

so this short message is sent, and a second message with the same
nlmsg_seq/portid follows later, either the real answer finalized in
ipmr_cache_resolve():

net/ipv4/ipmr.c:ipmr_cache_resolve() {
	...
			nlh->nlmsg_len = skb_tail_pointer(skb) -
					 (u8 *)nlh;
	...
		rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
}

or an NLMSG_ERROR from ipmr_destroy_unres():

net/ipv4/ipmr.c:ipmr_destroy_unres() {
	...
			nlh->nlmsg_type = NLMSG_ERROR;
			nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
	...
			e->error = -ETIMEDOUT;
	...
}

RTM_GETROUTE is a GET operation and so skips the CAP_NET_ADMIN check in
rtnetlink_rcv_msg(), meaning an unprivileged socket can reach this whenever
a multicast routing daemon has MC_FORWARDING enabled.

Rather than finalizing the premature message, would it be better to signal
the caller that this skb must not be sent at all?

[Severity: Medium]
Does this leave IPv4 and IPv6 emitting different replies for the same
situation?  Every other success exit of rt_fill_info() goes through:

net/ipv4/route.c:rt_fill_info() {
	...
	if (rtnl_put_cacheinfo(skb, &rt->dst, 0, expires, error) < 0)
		goto nla_put_failure;

	nlmsg_end(skb, nlh);
	return 0;
	...
}

so RTA_CACHEINFO is otherwise unconditional in a finalized message.  The
matching construct in the IPv6 path is untouched:

net/ipv6/route.c:rt6_fill_node() {
	...
		if (ipv6_addr_is_multicast(&rt6_dst->addr)) {
			int err = ip6mr_get_route(net, skb, rtm, portid);

			if (err == 0)
				return 0;
	...
}

For "ip route get <mcast>" against an unresolved MFC entry, IPv4 now sends
a length-finalized RTM_NEWROUTE while IPv6 still sends the non-finalized
one.  Should both families be handled the same way?

>  			} else

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919221737.3708462-1-benquike%40gmail.com
