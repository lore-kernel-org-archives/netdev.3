Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676490;
	b=cK4HLWfU6o9AvOBMTSa6UYQuZLq/QmEYZQqXoATstqv0goXwYVieIkTMXh3nUzIotqNz
	 3t9vk4DbRIjJ/RByJ/gKYxLVFdN0ZQGa5J0bUklDbsfkPeC+KtzQnRT0mfwfhvmdqCsoD
	 FckBiWUAnuMb2xpw+jvASsHh9jt7x/gNR+RzhDnvPS//1oHO1xcVTD+xroQI5E92lm5N6
	 O5jUlF8kT5OL4x7Th14/i9/H3/dVAtKBE0kxcqkllKFbQsBRMTgnKQJEhhPcfz+Z7QH9R
	 3Y7OMbX4W0W/ibvQbooMA0bRZNnd/MMlscqw0fUlEFnYa9R05EndrObRzA1u7XCceNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676490;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IT22gR2pwKiJhADmHWP/+r0coNccC8xLlTiDO/rBpoY=;
	b=MJymJkzU4ma3c/0+txhrMNYMWf+lZEnex67bNkEgfHSDTbEl4GTlDj5rwXhg/YtMtx7q
	 x6tG3bWRhdMy0VBUCFTTg1T8LHw0qvQmORVFSjGY2w9O1DRzHxcA1e0ilpHkJcndcTwrO
	 F3M+Oa4NJQ3crIuEUd6o0IoFaugVWZJc3VznuBfvNYCNyR5NOJfRSicTsgu63egF2o1/I
	 ng/kAPn1AdozNnVebWPjU67eA362mvKHzVLIdXTIGcRZpNAtI7BpwTq65mQgI68XeGR4X
	 X48fpoogQHZyWOSopIPXg6x8/7GD9DnS3pI0+xR4o6fAHjFWz9oNMYu9zVB/YC7PTaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsHluK77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F004606A324;
	Tue,  3 Nov 2026 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsHluK77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893541F000C1;
	Tue,  3 Nov 2026 03:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676490;
	bh=IT22gR2pwKiJhADmHWP/+r0coNccC8xLlTiDO/rBpoY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dsHluK7762BZ80/LESPY/xhDZDWPXpmU9W48PG4h3UMez8w68s+LNv80MHWQ0RTac
	 5XeeVLn5sew2Y3XC7g5qtyA3yu7+r2z++Pc5qpuEHKGLcm+IW4q2BDgoPoCdmSvOqA
	 GwnhOmGTMQm8tsCk/Ab4Ea5hYSv8kipAB9VIMQBv75X830u0SH7aBclarZ2aRMGZek
	 WUW8bPm81HISM7t6YfnllVatmV1b2zsRVLUisNRcuafYrYSuUlWwkkfuJD02l1tcSD
	 R/NNDY+smO/ubpd5Xd0TRx/omX4XiX0+NyKPuj/0ct4dWaiC6/sk1GVDfXpoH0YBNO
	 PSaO+a83mAadQ==
Subject: Re: [PATCH net v5] arp: Fix Hole-196 vulnerability by dropping
 unicast ARP replies in L2 BMC
From: netdev-bot+sashiko@kernel.org
To: starchang@google.com
Cc: netdev@vger.kernel.org, ja@ssi.bg, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, johannes@sipsolutions.net, johannes.berg@intel.com,
 linux-kernel@vger.kernel.org, wangroger@google.com
Date: Tue, 03 Nov 2026 03:28:09 +0000
Message-ID: <179367648906.488856.5105608241587328517@kernel.org>
In-Reply-To: <20261030031136.607720-1-starchang@google.com>
References: <20261030031136.607720-1-starchang@google.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not close the Hole-196 ARP cache-poisoning attack
  it claims to fix.
- [Medium] The patch rests on a false protocol premise, and with the
  sysctl enabled it breaks legitimate traffic without saying so.
- [Medium] The patch's GARP exemption does not match the kernel's own
  GARP definition, and as a result the updated sysctl documentation is…
- [Low] The patch reuses an IP-specific drop reason and RFC justification
  for ARP, so both in-tree descriptions now misdescribe the new code.

--

arp: Fix Hole-196 vulnerability by dropping unicast ARP replies in L2 BMC

This patch extends the drop_unicast_in_l2_multicast sysctl to ARP. When
the sysctl is set, arp_process() drops ARP replies that arrive in L2
broadcast or multicast frames unless sip == tip. Gratuitous ARP is left
to drop_gratuitous_arp, ARP requests are not filtered, and the sysctl
documentation is updated to match.

> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index d3523c9064a22..0747ff20ba472 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2301,8 +2301,8 @@ promote_secondaries - BOOLEAN
>  	Default: 0 (disabled)
>  
>  drop_unicast_in_l2_multicast - BOOLEAN
> -	Drop any unicast IP packets that are received in link-layer
> -	multicast (or broadcast) frames.
> +	Drop any unicast IP packets and non-GARP ARP replies that are
> +	received in link-layer multicast (or broadcast) frames.
>  
>  	This behavior (for multicast) is actually a SHOULD in RFC
>  	1122, but is disabled by default for compatibility reasons.

[Severity: Low]
This isn't a bug, but the next paragraph still cites RFC 1122 as the
reason for this behaviour. RFC 1122 section 3.3.6 covers IP datagrams
and says nothing about filtering ARP replies.

The new drop in arp_process() has a similar problem. It reports
SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST, which
include/net/dropreason-core.h documents as:

	 * @SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST: destination address of L2 is
	 * multicast, but L3 is unicast.

The ARP check looks at ar_op and sip != tip, not at an L3 destination
address. So drop_monitor and kfree_skb tracepoint users would see these
ARP drops described as L3 unicast in L2 multicast.

Would a separate drop reason, or updated kernel-doc, fit better here?

> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 1ca4ced280aef..8736092d5c629 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -794,6 +794,26 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	    (!IN_DEV_ROUTE_LOCALNET(in_dev) && ipv4_is_loopback(tip)))
>  		goto out_free_skb;
>  
> +/*
> + * Hole-196 defense for ARP:
> + * If drop_unicast_in_l2_multicast is enabled, drop ARP Replies received
> + * in L2 BMC frames unless they are Gratuitous ARP (sip == tip).
> + *
> + * Standard ARP Replies are strictly unicast (PACKET_HOST). An ARP Reply
> + * in an L2 broadcast frame with (sip != tip) is an injected unicast packet.

[Severity: Medium]
Is this premise accurate? The commit message makes the same claim:

  "Under standard networking behavior, a non-GARP ARP reply is strictly
  meant to be delivered as an L2 unicast frame (PACKET_HOST) to the
  requester."

RFC 3927 section 2.5 requires ARP packets whose sender is an IPv4
link-local (169.254/16) address to be sent as link-layer broadcast, and
that includes replies. RFC 5227 section 2.6 also discusses broadcast
ARP replies.

Take a host with drop_unicast_in_l2_multicast=1 that ARPs for such a
peer. The solicited reply arrives with pkt_type == PACKET_BROADCAST,
ar_op == ARPOP_REPLY and sip != tip, so the new branch drops it.

Nothing else in arp_process() resolves the entry. Wouldn't the
neighbour stay INCOMPLETE and then go FAILED, so IPv4 connectivity to
that peer is lost?

The existing code in arp_process() already treats broadcast replies as
valid input:

		/* Broadcast replies and request packets
		   do not assert neighbour reachability.
		 */
		if (arp->ar_op != htons(ARPOP_REPLY) ||
		    skb->pkt_type != PACKET_HOST)
			state = NUD_STALE;

The sysctl was documented as covering unicast IP packets. This change
widens it to ARP without mentioning the compatibility impact, and with
the Fixes: tag it would also go to stable. Should the documentation at
least call this out?

> + * Legitimate GARP (sip == tip) is preserved and defers to DROP_GRATUITOUS_ARP.
> + * ARP Requests are left untouched per RFC 826.
> + */
> +	if ((skb->pkt_type == PACKET_BROADCAST ||
> +	     skb->pkt_type == PACKET_MULTICAST) &&
> +	    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {
> +		if (arp->ar_op == htons(ARPOP_REPLY) && sip != tip) {

[Severity: High]
Does this close the cache poisoning path described in the commit
message? Only broadcast replies with sip != tip are dropped. A GTK
holder can still overwrite the victim's gateway entry with broadcast
frames that pass this check.

The first way is a broadcast ARP request with sip = gateway IP,
sha = attacker MAC and tip = victim IP. With the default arp_ignore=0
and arp_filter off, it takes the RTN_LOCAL branch in arp_process():

			if (!dont_send) {
				n = neigh_event_ns(tbl, sha, &sip, dev);

neigh_event_ns() then overrides without any condition:

net/core/neighbour.c:neigh_event_ns() {
    ...
	if (neigh)
		neigh_update(neigh, lladdr, NUD_STALE,
			     NEIGH_UPDATE_F_OVERRIDE, 0);
    ...
}

So the LOCKTIME window the commit message relies on doesn't apply on
this path.

The second way is a broadcast GARP with sip == tip == gateway IP. It
can be a request, or a reply with tha == sha. It passes the new check,
and drop_gratuitous_arp defaults to 0.

arp_is_garp() then returns true because the gateway address is
RTN_UNICAST. That forces the override in the update block:

		override = time_after(jiffies,
				      n->updated +
				      NEIGH_VAR(n->parms, LOCKTIME)) ||
			   is_garp;
		...
		neigh_update(n, sha, state,
			     override ? NEIGH_UPDATE_F_OVERRIDE : 0, 0);

Broadcast requests whose tip is not local also fall through to that
block. They overwrite an existing sip entry once LOCKTIME has passed,
which is the same primitive this patch blocks for replies.

With drop_unicast_in_l2_multicast=1 set as the documentation suggests,
the attack in the commit message still seems possible with these
frames. RFC 826 requires requests to be merged into the cache, so a
filter based on opcode and sip may not be enough. Should the subject
and changelog claim be narrowed, or the approach reworked?

[Severity: Medium]
Is sip == tip alone the right GARP exemption here? arp_is_garp() is
stricter for replies:

net/ipv4/arp.c:arp_is_garp() {
	bool is_garp = tip == sip;
	...
	if (is_garp && ar_op == htons(ARPOP_REPLY))
		is_garp =
			...
			tha &&
			!memcmp(tha, sha, dev->addr_len);

	if (is_garp) {
		*addr_type = inet_addr_type_dev_table(net, dev, sip);
		if (*addr_type != RTN_UNICAST)
			is_garp = false;
	}
	...
}

Consider a broadcast reply with sip == tip == gateway IP,
sha = attacker MAC and tha != sha. The kernel's own definition says it
is not GARP, but this check doesn't drop it.

With drop_gratuitous_arp at its default of 0, ipv4_neigh_lookup() finds
the existing gateway entry. neigh_update() then overwrites it once
LOCKTIME has passed. If tha == sha as well, arp_is_garp() returns true
and the overwrite is immediate.

That is the commit message's scenario with tip set equal to sip. The
updated ip-sysctl.rst text says non-GARP ARP replies are dropped. Does
that match what is implemented here?

This overlaps with the question above. The separate point is the
mismatch between the exemption and the documented behaviour. Should
the documentation also say that drop_gratuitous_arp has to be enabled
for the described protection?

> +			kfree_skb_reason(skb,
> +					 SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST);
> +			return NET_RX_DROP;
> +		}
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030031136.607720-1-starchang%40google.com
