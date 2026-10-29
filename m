Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292984;
	b=yaQdIweRccaQkYwnRnW38IRXT7SIrWEm2FM8GDZaVVU6CKjlqX3423qerOYCOVfp3lcy
	 9RjTegQsI+pD3SHpBjOF7+FxCv/Pjx7uz3NMMcB+IinTRGlgPqJq0bFxtajMMyU6U3hRR
	 Z2hqrwd9I7WTQThSUkfGoa/z98behtVw3j4rXUwjK6/VNfBHhFfFMvMTNk5SoT21bCdC7
	 NVU+6Sy/bUplRp8toRdsPaPkV7UEOS4w7webGlTlsqRdMyiNKUapHPMAzF15FYQEq9dik
	 X2JsexD/0LQaxNtS9cKmjr/uuW8QuWNfm0w95xdnIvz2mnGtsd3cwLk0LQids8Qq88g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292984;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zAfT8B4pTMhBnh03jvJKnth5Lkg6XbG+venp0/K8n5o=;
	b=2KWQ5jexUT3kq3S9h+MiFBDD5M/lk9OgIAp37LAFyC4kjz0GjUv2XtcVdEPCuU+ZVPfi
	 FvqgKPf5V+CMp4aLx5WBoRcyH9Zai7pbQTk+pqR9m1Ndf1p63c00n29gWY6KfF2/xc5BG
	 RZw4VjxAGZnbBOVyYdyGS3plr1p8gf1lPlnFChDH5c2iWhrtV2NCWEcbDU3MXJnxZL+kT
	 V4rDFt0xKs9QckXAlVTzfxmnazO+u76NX3QNFzWBS3F1uY417hiQ4J/2dWo5KXUKcg+WF
	 2HGrzKymctDdPHcWZu5ioArdRcyrlEjAV1RIQbq5xkF3dPyIrDw04OXrA8JbFTKtYDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boEbotou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BD606A31A;
	Thu, 29 Oct 2026 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boEbotou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5DB1F01826;
	Thu, 29 Oct 2026 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292983;
	bh=zAfT8B4pTMhBnh03jvJKnth5Lkg6XbG+venp0/K8n5o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=boEbotouGERozQqDHYCiEv3UnSJfnBtxJtz0uMGLDAo5CGMrsjS/GRydBIXhjzg37
	 bRhdlpqHzM7EEMM44LQirEVMe0yulsU4N9iuBuwdaNFCXu2A4ZMH2j4Yb2lnYdjCoR
	 EWbLTsgViLB1bx6Fvzfm1b91rAFys7WK4ZZADBeANIYnPJrVgD3j9/uTu2xV4LiwaH
	 mMGwNawornRNK9LcpH9lVnDMg4oi/nF0r0L5wN+/piKycQYr+AZYF26jqq4ZV8P2dl
	 QYrMrWr1HHC42rlO6GENlVRmWLI/0EAHSONv7JS+soWKhWqB6LnYqXxFnbjfT2BbW1
	 vjmC7oJOXDAaA==
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
From: netdev-bot+sashiko@kernel.org
To: starchang@google.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ja@ssi.bg, johannes@sipsolutions.net,
 johannes.berg@intel.com, linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 16:56:22 +0000
Message-ID: <179329298204.3134.8449668897281901896@kernel.org>
In-Reply-To: <20261027015619.1745984-1-starchang@google.com>
References: <20261027015619.1745984-1-starchang@google.com>
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

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The ARP side of the Hole-196 fix can be bypassed by changing one
  field.
- [High] Use-after-free read in ip_rcv_finish_core()
  (net/ipv4/ip_input.c:467-484).
- [Medium] The new DHCP exemption in ip_rcv_finish_core()
  (net/ipv4/ip_input.c:463-490) weakens the existing Hole-196 drop, and…
- [Medium] Turning on drop_unicast_in_l2_multicast now drops every ARP
  Reply that arrives in an L2 broadcast/multicast frame unless it…
- [Low] The patch changes the behaviour of the per-interface IPv4 sysctl
  drop_unicast_in_l2_multicast without updating…
- [Low] The commit message misstates the existing behaviour, and the IPv6
  hunk tagged as a fix only adds a printk.
- [Low] The new comment and the `is_valid_garp` predicate in
  arp_process() define GARP differently from the GARP helper already in…
- [Low] The three places that enforce drop_unicast_in_l2_multicast report
  drops differently.
- [Low] The IPv4 and IPv6 sysctls named drop_unicast_in_l2_multicast now
  behave differently, while their documentation (ip-sysctl.rst:2303 and…
- [Low] The patch adds net_warn_ratelimited() on four drop paths, and any
  L2 peer can trigger all of them at line rate with crafted frames:…

--

net: Fix Hole-196 vulnerability by dropping unicast ARP/IP in L2 BMC

This patch extends the drop_unicast_in_l2_multicast sysctl so that it also
drops ARP replies and unicast-THA ARP requests that arrive in L2
broadcast/multicast frames, with an exemption for gratuitous ARP. It also
exempts non-fragmented UDP traffic to port 68 from the IPv4 drop. It adds
rate-limited warnings and an IPv4 MIB counter on the drop paths.

> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 1ca4ced280aef..9f6715a5b5475 100644
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

[Severity: Low]
Should Documentation/networking/ip-sysctl.rst be updated as well? The IPv4
entry still says:

    drop_unicast_in_l2_multicast - BOOLEAN
	Drop any unicast IP packets that are received in link-layer
	multicast (or broadcast) frames.

After this patch the same knob also filters ARP in arp_process(). It also
no longer drops every unicast IP packet in ip_rcv_finish_core(), because
UDP datagrams to port 68 are now let through.

> +		bool is_valid_garp = (sip == tip) && tha &&
> +				     !memcmp(tha, sha, dev->addr_len);

[Severity: Low]
Does this GARP definition match arp_is_garp() in the same file? The
existing helper only requires tha == sha for replies:

net/ipv4/arp.c:arp_is_garp() {
	bool is_garp = tip == sip;

	/* Gratuitous ARP _replies_ also require target hwaddr to be
	 * the same as source.
	 */
	if (is_garp && ar_op == htons(ARPOP_REPLY))
		is_garp =
			...
			tha &&
			!memcmp(tha, sha, dev->addr_len);
    ...
}

The new is_valid_garp applies the tha == sha test to requests too.

The comment above says RFC 5227 Address Announcements require
tha == sha. RFC 5227 announcements are actually requests with THA zeroed.
They only get past this block because is_valid_ether_addr() is false for
an all-zero THA.

Everywhere else in arp.c, a sip == tip request with a unicast THA that
differs from sha counts as GARP. Here it is dropped as a "unicast THA ARP
Req" instead of deferring to DROP_GRATUITOUS_ARP, as the comment
describes. Is that intended?

> +
> +		if (arp->ar_op == htons(ARPOP_REPLY) && !is_valid_garp) {
> +			net_warn_ratelimited("Drop ARP Reply in L2 BMC on %s\n",
> +					     dev->name);
> +			goto out_free_skb;
> +		}

[Severity: Medium]
Does this drop legitimate solicited ARP replies that are sent as
link-layer broadcast?

Nothing here checks for an outstanding INCOMPLETE neighbour entry for
sip, so every non-GARP reply in a broadcast/multicast frame is discarded.
RFC 3927 requires IPv4 link-local (169.254/16) hosts to send all ARP
packets, replies included, as link-layer broadcast. A host with the sysctl
set may then fail to resolve those neighbours.

Further down, arp_process() handles broadcast replies on purpose:

	/* Broadcast replies and request packets
	   do not assert neighbour reachability.
	 */
	if (arp->ar_op != htons(ARPOP_REPLY) ||
	    skb->pkt_type != PACKET_HOST)
		state = NUD_STALE;

Once the sysctl is enabled, broadcast replies can no longer reach that
path. GARP replies whose THA is zero or broadcast instead of sha are
dropped too.

Before this patch the sysctl only affected IP packets, so existing users
will see their ARP behaviour change.

[Severity: Low]
The commit message says MIB counters are incremented for dropped frames.
Both new ARP drops end up here, though:

out_free_skb:
	kfree_skb(skb);
	return NET_RX_DROP;

That reports SKB_DROP_REASON_NOT_SPECIFIED and increments no counter. The
IPv4 and IPv6 paths use SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST. Could
these drops use kfree_skb_reason() with that reason for consistency?

> +		if (dev->addr_len == ETH_ALEN && tha &&
> +		    is_valid_ether_addr(tha) && !is_valid_garp) {
> +			net_warn_ratelimited("Drop unicast THA ARP Req in L2 BMC on %s\n",
> +					     dev->name);
> +			goto out_free_skb;
> +		}
> +	}

[Severity: High]
Can the ARP poisoning described in the commit message still happen with
the sysctl enabled?

For requests, THA plays no part in neighbour learning. Take a forged L2
broadcast ARP request with:

  - sip = the gateway
  - sha = the attacker's MAC
  - tip = a local address
  - THA = 00:00:00:00:00:00 (normal for real requests) or
    ff:ff:ff:ff:ff:ff

is_valid_ether_addr() is false for both THA values, so the frame gets
past this block and reaches:

		if (addr_type == RTN_LOCAL) {
			...
			if (!dont_send) {
				n = neigh_event_ns(tbl, sha, &sip, dev);

neigh_event_ns() then creates or updates the gateway's entry with the
attacker's MAC, using NEIGH_UPDATE_F_OVERRIDE.

Replies have a similar bypass. Take a reply with sip == tip == the gateway
and sha == tha == the attacker's MAC:

  - It satisfies is_valid_garp, so it skips both new checks.
  - With DROP_GRATUITOUS_ARP at its default of 0, it reaches arp_is_garp().
  - arp_is_garp() returns true for a unicast sip.

The result is:

		override = time_after(jiffies,
				      n->updated +
				      NEIGH_VAR(n->parms, LOCKTIME)) ||
			   is_garp;

and neigh_update() overwrites the existing gateway entry.

Gating on THA doesn't change what is learned from sha and sip. Does this
approach need rethinking, rather than more THA cases?

[ ... ]

> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 9860178752b8c..7d6d3e72e557b 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -456,10 +456,37 @@ static int ip_rcv_finish_core(struct net *net,

[ ... ]

>  		if (in_dev &&
>  		    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {
> -			drop_reason = SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST;
> -			goto drop;
> +			bool is_dhcp_resp = false;
> +
> +			iph = ip_hdr(skb);
> +			if (iph->protocol == IPPROTO_UDP &&
> +			    !ip_is_fragment(iph) &&
> +			    pskb_may_pull(skb, iph->ihl * 4 +
> +					       sizeof(struct udphdr))) {
> +				const struct udphdr *uh;
> +
> +				iph = ip_hdr(skb);
> +				uh = (const struct udphdr *)
> +					(skb_network_header(skb) +
> +					 iph->ihl * 4);
> +				if (uh->dest == htons(68))
> +					is_dhcp_resp = true;
> +			}

[Severity: Medium]
Does this exemption weaken the protection the sysctl is meant to provide?

Before this patch, every unicast IP packet in an L2 broadcast/multicast
frame was dropped when the sysctl was set. Now any non-fragmented UDP
datagram with destination port 68 is accepted. Source port, addresses and
payload are not checked.

So a forged DHCPACK, DHCPNAK or FORCERENEW, or anything else sent to port
68, injected in a GTK-encrypted broadcast, would reach a client that uses
a UDP socket bound to its leased address.

The commit message says this preserves DHCPOFFER/DHCPACK delivery. Is that
case actually reachable here?

Per RFC 2131 section 4.1, servers do one of two things:

  - IP-broadcast to 255.255.255.255, which routes as RTN_BROADCAST and
    never reaches this branch.
  - L2-unicast to chaddr/yiaddr, which arrives as PACKET_HOST.

In INIT/SELECTING the client doesn't own yiaddr yet, so
ip_route_input_slow() takes:

	if (!IN_DEV_FORWARD(in_dev)) {
		err = -EHOSTUNREACH;
		goto no_route;
	}

The OFFER then ends up in ip_error() rather than at a port 68 socket.

Clients that use AF_PACKET see the frame before IP input, so this drop
never affected them.

[Severity: Low]
ip6_rcv_core() gets no matching DHCPv6 (UDP port 546) exemption. The IPv4
and IPv6 drop_unicast_in_l2_multicast sysctls now behave differently,
while their ip-sysctl.rst entries are still worded the same.

If the IPv4 rationale holds, doesn't IPv6 need the same exemption? If it
doesn't hold, is the IPv4 exemption needed at all?

> +
> +			if (!is_dhcp_resp) {
> +				net_warn_ratelimited("Drop unicast IP %pI4 in L2 BMC on %s\n",
> +						     &iph->daddr, dev->name);

[Severity: High]
Can iph be stale here when pskb_may_pull() fails?

iph is only reloaded in the success branch. pskb_may_pull() can
reallocate skb->head and still return false:

include/linux/skbuff.h:pskb_may_pull_reason() {
	...
	skb_might_realloc(skb);

	if (likely(len <= skb_headlen(skb)))
		return SKB_NOT_DROPPED_YET;

	if (unlikely(len > skb->len))
		return SKB_DROP_REASON_PKT_TOO_SMALL;

	if (unlikely(!__pskb_pull_tail(skb, len - skb_headlen(skb))))
		return SKB_DROP_REASON_NOMEM;
	...
}

There are two ways to get there:

  - With CONFIG_FAIL_SKB_REALLOC, skb_might_realloc() calls
    pskb_expand_head(), which frees the old head of a non-cloned skb. A
    UDP packet whose tot_len equals the IP header length then returns
    PKT_TOO_SMALL.
  - Without fault injection, __pskb_pull_tail() can call
    pskb_expand_head() when eat > 0 or the skb is cloned. It can then
    still return NULL on the frag_list path, if skb_clone() or pskb_pull()
    fails.

Either way, is_dhcp_resp stays false and &iph->daddr is read through the
freed head for the %pI4 print.

The commit message says ip_hdr(skb) is reloaded after pskb_may_pull() to
prevent dangling pointer access, but that only covers the success path.
Would it work to reload iph unconditionally after the call, or to save
daddr before it?

[Severity: Low]
Are these new net_warn_ratelimited() calls needed? That means this one,
the one in ip6_rcv_core(), and the two in arp_process(). Any L2 peer can
trigger them at line rate with crafted frames.

net_ratelimit() uses a single global state shared by every
net_*_ratelimited() caller:

net/core/utils.c:
DEFINE_RATELIMIT_STATE(net_ratelimit_state, 5 * HZ, 10);

A steady flood would keep unrelated networking warnings suppressed, and
it would fill the log with attacker-chosen addresses.

The RFC 1122 text quoted just above this code says to silently discard.
These drops are also already visible through
SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST.

> +				__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
> +				drop_reason =
> +					SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST;
> +				goto drop;
> +			}
>  		}
>  	}
>  
> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index d332ec60f9150..816ee7874076b 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -278,6 +278,8 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
>  	    (skb->pkt_type == PACKET_BROADCAST ||
>  	     skb->pkt_type == PACKET_MULTICAST) &&
>  	    READ_ONCE(idev->cnf.drop_unicast_in_l2_multicast)) {
> +		net_warn_ratelimited("IPv6: Drop unicast IP %pI6c in L2 BMC on %s\n",
> +				     &hdr->daddr, dev->name);
>  		SKB_DR_SET(reason, UNICAST_IN_L2_MULTICAST);
>  		goto err;
>  	}

[Severity: Low]
The commit message says:

    3. Dropped packets were silently discarded without warnings or MIB stats.

For IPv6 that doesn't look accurate. This drop already goes through the
err label:

err:
	__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
	SKB_DR_OR(reason, IP_INHDR);

Both IPv4 and IPv6 also already reported
SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST.

So the only IPv6 change is this printk, and it carries
Fixes: abbc30436d39, which makes it a stable candidate. Is that tag
appropriate for this hunk?

Two other points don't match the description either:

  - The new ARP drops get no counter at all.
  - The new IPv4 counter records a policy drop as
    IPSTATS_MIB_INHDRERRORS, even though the header is well-formed.

Could the commit message be updated to describe what actually changed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027015619.1745984-1-starchang%40google.com
