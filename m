Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306582;
	b=sUtYOSvfomSOZD26uNryaxp/3DskRkKnzaYVkPQKHjjsta4T3N73F4WC13An3QYoMdnO
	 abqtQCl5UaQR32AiYmbY1/M/Xy8ThMJCXdC++PrtUWyc5nkT5Squnm1iEHwv/g9gYXolN
	 qkmiB3KeJ5F7Licpqpt/NdUCMfMNFIdrYG6Qjtq5LG1NomAFJJDb2paJo6NGz+UQlpdKM
	 EQMto4fJI6CpSQQn6zuuiTqPTdwauF17GpZ3A5Amk1ZbgMRTvCZOBWP7Qn7SJzb6bHXDP
	 YN4MRJ/Dey3RqQ4YaqcWw5BSSlRGB9wXHtKsKUwMVOt1nWqeGDkirPTurhC0V+AAbCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306582;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8EB6X63HmhBGoe3hO+SAln0p99Qs0qSFgOHbULntMgg=;
	b=m3z2APl+k+32nUvuhaH/CMxtHA6yRo45vgLeAbDbYZsJ56ZE7y0rs0Yvl2M0XcHTvASN
	 ROD4e8+9LoDlB8pAvS7Jxn5LvoqC5GyqdUd1FuUqezX1WY77dBA3qth58blchmUwfN+Pj
	 9xb4yPmh4xDhWzMnBVB5md0VPdfzarGfNXjD5GMMKnnZEjg5z/fdkC68Ed1E9b4iMDjPa
	 xGzSxhNeLqHi2RVKRS4sDG/l/CLQbmOHXDexFGoFNHQUO8yVyMKoAPkQf49mkTyz8aPYm
	 FGxbkYg65gkiptGTiEezybf27F1s14Gh+Z1+DaL2LlSRXZFNa2ud9x3+O8E1HuSeZCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goctmxa8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AE606A323;
	Thu, 29 Oct 2026 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goctmxa8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF71F01816;
	Thu, 29 Oct 2026 20:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306581;
	bh=8EB6X63HmhBGoe3hO+SAln0p99Qs0qSFgOHbULntMgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=goctmxa8iCNCTXPaqmqzpPIfiqon7STyRcvOyHHTijPsV+Fnq7ortlEBHraN1S4Xo
	 39XZtzStG0wciE448bKaFD+ifVKnWWI2wqq+CgiJbHGJy9FRlJHZk5vX779dqNz/z6
	 OeujThPuSrlCeCv8DkduIaUJpUJWA1RdTdtIc/oyQmAg0WIS8XLxU90PZv7WILdWjj
	 wXJQhQ9ELe26EjN+05T5X2rhV8+AChDJNDPTXpriAWtHuEE56tVfEWt/SSg2dyVfiW
	 b3CQDuaRb9a/p9RMMhMxRtHg6Cx9FECGMsJrp41f1lXqe4XBM8NPRQrMu5kyQ7XB0j
	 VVw16/3GX/Omg==
Subject: Re: [PATCH net v2] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
From: netdev-bot+sashiko@kernel.org
To: starchang@google.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 20:43:00 +0000
Message-ID: <179330658024.3134.909462706253869343@kernel.org>
In-Reply-To: <20261026144032.1338614-1-starchang@google.com>
References: <20261026144032.1338614-1-starchang@google.com>
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

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new ARP check in arp_process() (net/ipv4/arp.c) does not
  stop the ARP-cache poisoning over L2 broadcast/multicast that the…
- [High] Use-after-free read of a stale IP header pointer in
  ip_rcv_finish_core() (net/ipv4/ip_input.c).
- [Medium] The new UDP destination-port-68 exemption in
  ip_rcv_finish_core() (net/ipv4/ip_input.c) weakens existing protection…
- [Medium] The documented behaviour of the IPv4
  drop_unicast_in_l2_multicast sysctl no longer matches the code, and…
- [Medium] The commit message lists 'Dropped packets were silently
  discarded without warnings or MIB stats' as a gap it fixes.
- [Medium] In arp_process(), the new filter drops every ARP Reply
  received via L2 broadcast/multicast unless sip == tip and tha == sha,…
- [Medium] The patch adds net_warn_ratelimited() to receive-path drops
  that any station sending L2 broadcast/multicast frames can trigger at…
- [Low] The patch is titled 'net: Fix Hole-196 vulnerability' and
  described as closing gaps in the existing sysctl, but it has no Fixes:…
- [Low] The new is_valid_garp predicate in arp_process() duplicates, and
  disagrees with, the existing arp_is_garp() helper in the same file,…

--

net: Fix Hole-196 vulnerability by dropping unicast ARP/IP in L2 BMC

This patch extends the drop_unicast_in_l2_multicast sysctl to
arp_process(). With it enabled, ARP Replies and ARP Requests with a
unicast target hardware address are dropped when they arrive in L2
broadcast/multicast frames.

It also exempts non-fragmented UDP packets to port 68 from the IPv4 drop
in ip_rcv_finish_core(). Rate-limited warnings are added to the IPv4,
IPv6 and ARP drop paths, plus an INHDRERRORS counter on the IPv4 path.

> net: Fix Hole-196 vulnerability by dropping unicast ARP/IP in L2 BMC

[Severity: Low]
The subject calls this a vulnerability fix, but there is no Fixes: tag
and no target tree.

Most of the patch changes what the sysctl does:

  - ARP filtering under a knob documented as IP-only
  - a new UDP/68 exemption
  - new logging

Is this meant for net-next? If it is meant as a fix, should it carry a
Fixes: tag for the commit that added drop_unicast_in_l2_multicast? That
would keep stable backports from picking up a user-visible behaviour
change based on the subject alone.

> 3. Dropped packets were silently discarded without warnings or MIB stats.

[Severity: Medium]
Is this accurate? In ip6_rcv_core() the existing drop already jumps to
err, which counts the packet:

err:
	__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
	SKB_DR_OR(reason, IP_INHDR);

IPv4 and IPv6 also already reported SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST
through kfree_skb_reason(), so the IPv6 hunk only adds a log line.

The new ARP drops in arp_process() do the opposite. They use goto
out_free_skb, which is a plain kfree_skb(skb) with no MIB counter and no
drop reason.

Should the ARP drops use SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST and a
counter, as the commit message describes for all dropped frames?

> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 1ca4ced280ae..9f6715a5b547 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -794,6 +794,35 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	    (!IN_DEV_ROUTE_LOCALNET(in_dev) && ipv4_is_loopback(tip)))
>  		goto out_free_skb;
>  
> +/*
> + * Hole-196 defense for ARP:
> + * If drop_unicast_in_l2_multicast sysctl is enabled on this interface,
> + * drop ARP Replies in L2 BMC frames, and ARP Requests in L2 BMC frames
> + * that specify a non-zero unicast Target Hardware Address (tha).
> + *
> + * Legitimate Gratuitous ARP (GARP) and RFC 5227 Address Announcements
> + * require (sip == tip) and tha matching sha (tha == sha). Only valid
> + * GARP frames are exempted so they defer to DROP_GRATUITOUS_ARP below.
> + */
> +	if ((skb->pkt_type == PACKET_BROADCAST ||
> +	     skb->pkt_type == PACKET_MULTICAST) &&
> +	    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {

[Severity: Medium]
Documentation/networking/ip-sysctl.rst still describes the IPv4 knob
this way:

drop_unicast_in_l2_multicast - BOOLEAN
	Drop any unicast IP packets that are received in link-layer
	multicast (or broadcast) frames.

After this patch the same devconf bit behaves differently:

  - It drops ARP Replies and unicast-THA ARP Requests here, and ARP
    is not IP.
  - It no longer drops every unicast IP packet in
    ip_rcv_finish_core(), because of the UDP dport 68 exemption.

The IPv6 entry and ip6_rcv_core() keep the strict behaviour, with no
DHCPv6 port 546 exemption and no ND filtering. So the same documented
knob now differs per address family.

Should ip-sysctl.rst be updated as part of this change?

> +		bool is_valid_garp = (sip == tip) && tha &&
> +				     !memcmp(tha, sha, dev->addr_len);

[Severity: Low]
This duplicates arp_is_garp(), which arp_process() already calls later,
and the two disagree. arp_is_garp() requires tha == sha only for
replies:

	bool is_garp = tip == sip;

	/* Gratuitous ARP _replies_ also require target hwaddr to be
	 * the same as source.
	 */
	if (is_garp && ar_op == htons(ARPOP_REPLY))
		is_garp =
			...
			tha &&
			!memcmp(tha, sha, dev->addr_len);

The new predicate requires tha == sha for both opcodes. Take a
gratuitous Request with sip == tip and a unicast tha that differs from
sha:

  - arp_is_garp() treats it as GARP.
  - This code drops it as a unicast THA request.

That means it never reaches the DROP_GRATUITOUS_ARP check that the
comment says it defers to. That check also treats any sip == tip frame
as gratuitous.

Is the comment right that GARP and RFC 5227 announcements "require
(sip == tip) and tha matching sha (tha == sha)"? RFC 5227 says tha is
ignored and SHOULD be zero. The kernel's own
inetdev_send_gratuitous_arp() sends:

	arp_send(ARPOP_REQUEST, ETH_P_ARP,
		 ifa->ifa_local, dev,
		 ifa->ifa_local, NULL,
		 dev->dev_addr, NULL);

and arp_create() zeroes tha. That frame gets through only because
is_valid_ether_addr() is false for a zero address. It is not
recognised as GARP.

On ARPHRD_IEEE1394, tha is NULL, so is_valid_garp can never be true.
Would every broadcast ARP Reply on those devices be dropped, GARP
included?

> +
> +		if (arp->ar_op == htons(ARPOP_REPLY) && !is_valid_garp) {
> +			net_warn_ratelimited("Drop ARP Reply in L2 BMC on %s\n",
> +					     dev->name);
> +			goto out_free_skb;
> +		}

[Severity: Medium]
This drops every ARP Reply that arrives in an L2 broadcast/multicast
frame unless sip == tip and tha == sha. That includes replies to our own
outstanding requests. The commit message talks about "unsolicited ARP
Replies". Is dropping solicited replies intended too?

Two cases look affected.

First, RFC 3927 section 2.5 requires ARP replies from IPv4 link-local
(169.254/16) senders to be link-layer broadcast. Those have sip != tip,
so they are always dropped here. Would that break link-local neighbour
resolution and conflict defence when the sysctl is on?

Second, gratuitous replies with sip == tip and tha set to
ff:ff:ff:ff:ff:ff or zero used to reach the "Update our ARP tables"
block, where neigh_update(n, sha, ...) refreshes an existing entry for
sip. Some failover implementations send this format, and they are now
dropped first. Does that conflict with "preserving VRRP/HSRP router
failover" in the commit message?

The existing neighbour update code already expects broadcast replies:

		/* Broadcast replies and request packets
		   do not assert neighbour reachability.
		 */
		if (arp->ar_op != htons(ARPOP_REPLY) ||
		    skb->pkt_type != PACKET_HOST)
			state = NUD_STALE;

> +		if (dev->addr_len == ETH_ALEN && tha &&
> +		    is_valid_ether_addr(tha) && !is_valid_garp) {
> +			net_warn_ratelimited("Drop unicast THA ARP Req in L2 BMC on %s\n",
> +					     dev->name);
> +			goto out_free_skb;
> +		}

[Severity: High]
Does this stop the ARP cache poisoning described in the commit message?
The neighbour cache is written from sha and sip, not from tha.

Consider a broadcast ARP Request with:

  tha = 00:00:00:00:00:00 (or ff:ff:ff:ff:ff:ff)
  tip = victim's IP
  sip = gateway IP
  sha = attacker MAC

It passes both new checks: it is not a Reply, and
is_valid_ether_addr(tha) is false. Since sip != tip, DROP_GRATUITOUS_ARP
does not apply either. Then:

arp_process()
  ip_route_input_noref(skb, tip, sip, 0, dev) == 0, rt_type RTN_LOCAL
  arp_ignore() returns 0 by default
  neigh_event_ns(tbl, sha, &sip, dev)
    neigh_update(neigh, lladdr, NUD_STALE, NEIGH_UPDATE_F_OVERRIDE, 0);

That overwrites the victim's entry for the gateway with the attacker's
MAC. For packets that pass this filter, the "Update our ARP tables"
block also rewrites any existing entry for sip from sha.

A forged broadcast GARP Reply (sip == tip, tha == sha) is exempted on
purpose. Later it gets override forced because arp_is_garp() returns
true:

		override = time_after(jiffies,
				      n->updated +
				      NEIGH_VAR(n->parms, LOCKTIME)) ||
			   is_garp;

The lab test in the commit message sets tha to the victim's unicast
MAC, but tha plays no part in the poisoning. Wouldn't the filter need
to act on what is learned from sha/sip, rather than on tha, to close
this?

> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 9860178752b8..f863aa293020 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -456,10 +456,33 @@ static int ip_rcv_finish_core(struct net *net,

[ ... ]

>  		if (in_dev &&
>  		    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {
> -			drop_reason = SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST;
> -			goto drop;
> +			bool is_dhcp_resp = false;
> +
> +			iph = ip_hdr(skb);
> +			if (iph->protocol == IPPROTO_UDP && !ip_is_fragment(iph) &&
> +			    pskb_may_pull(skb, iph->ihl * 4 + sizeof(struct udphdr))) {
> +				const struct udphdr *uh;
> +
> +				iph = ip_hdr(skb);
> +				uh = (const struct udphdr *)(skb_network_header(skb) +
> +							    iph->ihl * 4);
> +				if (uh->dest == htons(68))
> +					is_dhcp_resp = true;

[Severity: Medium]
Does this exemption weaken the existing protection without reaching its
goal? Before the patch, every unicast IPv4 packet in an L2 BMC frame was
dropped. Now any non-fragmented unicast UDP datagram to port 68 gets
through. There is no check for source port 67 or for a DHCP payload.

Under RFC 2131 section 4.1, a server sends replies in one of two ways,
and neither reaches this check:

  - to IP broadcast 0xffffffff, which is RTN_BROADCAST and takes the
    earlier branch
  - as L2 unicast to chaddr, which is PACKET_HOST

During lease negotiation the client has no IPv4 address yet, so
ip_route_input_slow() fails fib_lookup and takes this path:

no_route:
	RT_CACHE_STAT_INC(in_no_route);
	res->type = RTN_UNREACHABLE;
	res->fi = NULL;
	res->table = NULL;
	goto local_input;

and then at local_input:

	if (res->type == RTN_UNREACHABLE) {
		rth->dst.input= ip_error;

So an exempted DHCPOFFER/DHCPACK is dropped by ip_error() anyway.

What the exemption does allow is unicast UDP:68 injection into
configured hosts, such as a forged DHCPACK during RENEW, or FORCERENEW.
The sysctl used to block that. Is this intended?

> +			}
> +
> +			if (!is_dhcp_resp) {
> +				net_warn_ratelimited("Drop unicast IP %pI4 in L2 BMC on %s\n",
> +						     &iph->daddr, dev->name);

[Severity: High]
Can iph point at freed memory here? It is only reloaded when
pskb_may_pull() succeeds, but pskb_may_pull() can reallocate skb->head
and still return false.

pskb_may_pull_reason() calls skb_might_realloc() before checking the
length:

	skb_might_realloc(skb);

	if (likely(len <= skb_headlen(skb)))
		return SKB_NOT_DROPPED_YET;

	if (unlikely(len > skb->len))
		return SKB_DROP_REASON_PKT_TOO_SMALL;

With CONFIG_FAIL_SKB_REALLOC, skb_might_realloc() runs
pskb_expand_head() and frees the old head. A crafted UDP packet with
tot_len=20 and no UDP header then fails the len > skb->len check.

__pskb_pull_tail() can also expand the head when eat > 0 or the skb is
cloned, and then return NULL in the frag_list path, for example when
skb_clone(list, GFP_ATOMIC) fails.

In both cases is_dhcp_resp stays false, and &iph->daddr reads the old
head. The commit message says the reload is there "to prevent dangling
pointer access". Should iph be reloaded unconditionally after the pull,
or should daddr be saved before it?

> +				__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
> +				drop_reason = SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST;
> +				goto drop;
> +			}
>  		}
>  	}
>  
> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index d332ec60f915..816ee7874076 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -278,6 +278,8 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
>  	    (skb->pkt_type == PACKET_BROADCAST ||
>  	     skb->pkt_type == PACKET_MULTICAST) &&
>  	    READ_ONCE(idev->cnf.drop_unicast_in_l2_multicast)) {
> +		net_warn_ratelimited("IPv6: Drop unicast IP %pI6c in L2 BMC on %s\n",
> +				     &hdr->daddr, dev->name);

[Severity: Medium]
Any station that can send L2 broadcast/multicast frames can trigger
this warning whenever it likes. The same goes for the new warnings in
ip_rcv_finish_core() and the two ARP drops in arp_process().

net_warn_ratelimited() goes through net_ratelimit(), which shares one
ratelimit state with every net_*_ratelimited() caller:

#define net_ratelimited_function(function, ...)			\
do {								\
	if (net_ratelimit())					\
		function(__VA_ARGS__);				\
} while (0)

Couldn't the GTK-holding attacker this sysctl targets keep that budget
used up? That would hide unrelated networking warnings and fill dmesg
with addresses the attacker chooses.

RFC 1122 section 3.3.6, quoted in ip_rcv_finish_core(), says these
datagrams SHOULD be silently discarded. The existing
SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST already shows them through the
kfree_skb tracepoint. Would leaving these drops silent be preferable?

>  		SKB_DR_SET(reason, UNICAST_IN_L2_MULTICAST);
>  		goto err;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026144032.1338614-1-starchang%40google.com
