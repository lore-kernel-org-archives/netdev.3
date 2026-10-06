Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC143B71DA;
	Tue,  6 Oct 2026 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276370; cv=none; b=ULzDK+pp2AKcbYB2hXkF3oQaXMuG4CtIr9rR3IJyxixFeVMIakf8ETSN7DB9a3FWJMaB6nKuifPmaCwkMOC9mTrj9uD23OkkIY77lJoB1utiDXDeyMGkiFry+o258BizDHr7/JxJl0kPxycRKSixk46mtV3a95BXGY7wQ+NiZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276370; c=relaxed/simple;
	bh=4IuTybBRhneT0g5b6KClGXQz4z3w9IVHnmEyuH6YHms=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfMw1jCp2mZXKaDuP2ZApXBQRWEo1nufXQ9JzT2FDq7nOrFIpQO7yDaXf0LBCzgS58uUmyEvj2KOiJb6s+LPuIBnB4AIDvUpNg4KfVZT5HZW1v4ZQ/z9CsXNesDd5PGZ6iXpLktpnMh+Q9kKqEmnhYaQtB2EJ0e/Y+AhWXjkWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN+/sy7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN+/sy7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3531F00893;
	Tue,  6 Oct 2026 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276368;
	bh=teErlWB0kdY/VlDmsu0E6Z/6QD+HOCMgO9e88QE7GJ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cN+/sy7kRDEWoVl9VbigdX6Km5N0ju4sDk7MImuqNbacPjcfVV4BKd7gEm3e57taI
	 ONp7J3E0ZFtIOoe8Ym8l1qFQbpgYDC8rSzuJu3hMsaSTCWdl037YB8ID5Uxku3Xj5M
	 8RZFmxAkHE2/PCzX0PSnKiSjJQBxHsKa6mnAHkiAt3tyblmsclRw5XnHXJbxx7Uulp
	 Gwvq9dJxzs/Ox1tq2CliqONHXO7CC3T23SRNPup3aSE673XgMwBTNFxIjv+7d2+Z9N
	 R/ZyRDg80ADLG5ystJyu9O6sTCyvrFD7C4+8J5fDrNAcSJauvSg1tkwzVaAPYu+OIw
	 tb+hgD30b+3sg==
Subject: Re: [PATCH net] net: Fix Hole-196 vulnerability by dropping unicast
 ARP/IP in L2 BMC
From: netdev-bot+sashiko@kernel.org
To: starchang@google.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, wangroger@google.com
Date: Tue, 06 Oct 2026 08:46:07 +0000
Message-ID: <179127636762.434549.4437638002382249563@kernel.org>
In-Reply-To: <20261002082336.608201-1-starchang@google.com>
References: <20261002082336.608201-1-starchang@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 6 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit says ARP poisoning through L2 broadcast/multicast
  frames was possible and claims to fix it.
- [Medium] In ip_rcv_finish_core() (net/ipv4/ip_input.c), the new DHCP
  exemption weakens the existing drop_unicast_in_l2_multicast protection.
- [Medium] The documented ABI of the IPv4 sysctl
  drop_unicast_in_l2_multicast (Documentation/networking/ip-…
- [Medium] The patch adds net_warn_ratelimited() calls to RX paths that a
  remote attacker can trigger: ip_rcv_finish_core() (IPv4),…
- [Medium] The new is_valid_garp predicate in arp_process(), (sip == tip)
  && tha && !memcmp(tha, sha, dev->addr_len), requires THA==SHA for both…
- [Medium] The commit message says it drops 'unsolicited ARP Replies'
  received over L2 BMC.
- [Medium] In ip_rcv_finish_core() (net/ipv4/ip_input.c), the new code
  reloads `iph = ip_hdr(skb)` only inside the success branch of…
- [Low] The patch's subject is 'Fix Hole-196 vulnerability' and its body
  lists defects in the existing drop_unicast_in_l2_multicast behaviour…
- [Low] The new ARP drop branches in arp_process() jump to out_free_skb,
  which calls plain kfree_skb(skb).

--

net: Fix Hole-196 vulnerability by dropping unicast ARP/IP in L2 BMC

This commit makes the drop_unicast_in_l2_multicast sysctl apply to ARP in
arp_process(). It also exempts non-fragmented UDP traffic to port 68 from
the IPv4 drop in ip_rcv_finish_core(), and adds rate-limited warnings and
MIB counters for dropped frames.

> net: Fix Hole-196 vulnerability by dropping unicast ARP/IP in L2 BMC

[ ... ]

> Signed-off-by: Star Chang <starchang@google.com>

[Severity: Low]
Should this have a Fixes: tag? The subject says it fixes a vulnerability,
and the body lists gaps in the existing behaviour. The IPv4 enforcement
being changed came from commit 12b74dfadb5a ("ipv4: add option to drop
unicast encapsulated in L2 multicast"). There is also no sign of which
tree (net or net-next) this is aimed at.

The ARP filtering looks like new functionality rather than a fix. Would it
make sense to split it out and send it to net-next on its own?

> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 60009d92e0710..f8e90f89ab620 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -791,6 +791,35 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
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
Documentation/networking/ip-sysctl.rst still describes the IPv4 knob as:

    drop_unicast_in_l2_multicast - BOOLEAN
	Drop any unicast IP packets that are received in link-layer
	multicast (or broadcast) frames.

After this patch the same knob also filters ARP, which is not IP. And
ip_rcv_finish_core() no longer drops "any" unicast IP, because UDP to
port 68 is exempt.

Should the documentation be updated to match? Systems that already have
the knob enabled will get the new ARP filtering without having asked for
it.

> +		bool is_valid_garp = (sip == tip) && tha &&
> +				     !memcmp(tha, sha, dev->addr_len);

[Severity: Medium]
Is this predicate consistent with arp_is_garp()? That function requires
THA == SHA only for replies:

net/ipv4/arp.c:arp_is_garp() {
    ...
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

Here, a broadcast gratuitous request with sip == tip and a unicast THA
that differs from SHA fails is_valid_garp. The is_valid_ether_addr(tha)
check below then drops it, even with drop_gratuitous_arp disabled.

Gratuitous replies with sip == tip and THA != SHA (for example a
broadcast THA) are dropped by the reply check.

Doesn't this conflict with the commit message, which says sip == tip
announcements "defer to the DROP_GRATUITOUS_ARP sysctl"?

The comment above also says GARP and RFC 5227 announcements "require ...
tha matching sha". RFC 5227 actually says THA is ignored and should be
zero. The kernel's own inetdev_send_gratuitous_arp() passes a NULL
target_hw, and arp_create() encodes that as all zeros. Those frames get
through only because is_valid_ether_addr() is false for a zero THA, not
because of this exemption.

Could the comment be corrected?

> +
> +		if (arp->ar_op == htons(ARPOP_REPLY) && !is_valid_garp) {
> +			net_warn_ratelimited("Drop ARP Reply in L2 BMC on %s\n",
> +					     dev->name);
> +			goto out_free_skb;
> +		}

[Severity: Medium]
The commit message says this drops "unsolicited ARP Replies". The code
drops every non-GARP reply that arrives in a broadcast or multicast frame,
including replies to a request this host sent. Nothing checks for a
pending neighbour resolution. Is that intended?

Later in arp_process(), broadcast replies are handled deliberately:

		/* Broadcast replies and request packets
		   do not assert neighbour reachability.
		 */
		if (arp->ar_op != htons(ARPOP_REPLY) ||
		    skb->pkt_type != PACKET_HOST)
			state = NUD_STALE;

With the sysctl enabled, peers that answer with broadcast replies would
become unreachable. IPv4 link-local hosts are one example, since RFC 3927
section 2.5 requires ARP packets from a link-local source to be sent as
link-layer broadcast.

> +		if (dev->addr_len == ETH_ALEN && tha &&
> +		    is_valid_ether_addr(tha) && !is_valid_garp) {
> +			net_warn_ratelimited("Drop unicast THA ARP Req in L2 BMC on %s\n",
> +					     dev->name);
> +			goto out_free_skb;
> +		}

[Severity: High]
Does this actually stop ARP poisoning through L2 broadcast frames? A
normal forged request has THA 00:00:00:00:00:00 or ff:ff:ff:ff:ff:ff, and
is_valid_ether_addr() is false for both. So a GTK-encrypted broadcast
request like this passes the block:

    sha = attacker MAC, sip = gateway IP, tip = victim IP, tha = 0

For a local tip, arp_process() then reaches:

				n = neigh_event_ns(&arp_tbl, sha, &sip, dev);

and neigh_event_ns() always overrides:

net/core/neighbour.c:neigh_event_ns() {
    ...
	if (neigh)
		neigh_update(neigh, lladdr, NUD_STALE,
			     NEIGH_UPDATE_F_OVERRIDE, 0);
    ...
}

One frame is enough to replace the gateway's entry with the attacker's
MAC.

Requests with a non-local tip still override once LOCKTIME has expired:

		override = time_after(jiffies,
				      n->updated +
				      NEIGH_VAR(n->parms, LOCKTIME)) ||
			   is_garp;

Valid GARPs (sip == tip, tha == sha) are exempted, and arp_is_garp() sets
override for them. Unless drop_gratuitous_arp is also enabled, they can
poison the cache directly too.

The commit message says ARP poisoning via L2 BMC frames is being closed.
Should the filter be reworked, or the claim narrowed?

> +	}

[Severity: Low]
Both new ARP drops jump to out_free_skb:

out_free_skb:
	kfree_skb(skb);
	return NET_RX_DROP;

That records SKB_DROP_REASON_NOT_SPECIFIED and updates no counter. The
IPv4 and IPv6 sites for the same sysctl use
SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST and IPSTATS_MIB_INHDRERRORS.

The commit message says the patch will "increment MIB error counters
(IPSTATS_MIB_INHDRERRORS) for dropped frames", but ARP drops are only
logged. It also lists missing MIB stats as a gap, yet the err: label in
ip6_rcv_core() already incremented IPSTATS_MIB_INHDRERRORS before this
patch.

Should the ARP drops use kfree_skb_reason() with
SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST?

[ ... ]

> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 9860178752b8c..f863aa2930208 100644
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
Doesn't this reopen part of what the sysctl used to block? Before the
patch, every unicast IPv4 packet in an L2 BMC frame was dropped. Now any
non-fragmented UDP datagram with destination port 68 is accepted. The
source port, route type and payload are not checked.

A GTK holder can again inject unicast UDP/68 datagrams into the local
stack, such as a forged DHCPOFFER, ACK or NAK, or any other payload.

Is there a DHCP server that sends unicast IP inside an L2 broadcast?
RFC 2131 broadcast replies go to 255.255.255.255, which is RTN_BROADCAST
and never reaches this branch. Unicast replies arrive as PACKET_HOST,
which does not reach it either.

Forwarding is not affected, because ip_forward() drops anything that is
not PACKET_HOST. The exposure is limited to local delivery.

> +			}
> +
> +			if (!is_dhcp_resp) {
> +				net_warn_ratelimited("Drop unicast IP %pI4 in L2 BMC on %s\n",
> +						     &iph->daddr, dev->name);

[Severity: Medium]
Can iph be stale here? It is reloaded only when pskb_may_pull() succeeds.
When pskb_may_pull() returns false, %pI4 uses the iph loaded before the
call. pskb_may_pull() can reallocate the head and still fail.

pskb_may_pull_reason() calls skb_might_realloc() before it checks the
length:

include/linux/skbuff.h:pskb_may_pull_reason() {
    ...
	skb_might_realloc(skb);

	if (likely(len <= skb_headlen(skb)))
		return SKB_NOT_DROPPED_YET;

	if (unlikely(len > skb->len))
		return SKB_DROP_REASON_PKT_TOO_SMALL;
    ...
}

With CONFIG_FAIL_SKB_REALLOC, skb_might_realloc() calls
pskb_expand_head(), and the function then fails with PKT_TOO_SMALL for a
UDP payload shorter than 8 bytes. Without fault injection,
__pskb_pull_tail() can call pskb_expand_head() first and then return NULL
if skb_clone() or pskb_pull() fails in the frag_list path.

In both cases %pI4 reads 4 bytes from the freed head. Would reloading iph
after the whole if block, or printing ip_hdr(skb)->daddr, fix this?

> +				__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
> +				drop_reason = SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST;
> +				goto drop;
> +			}
>  		}
>  	}

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

[Severity: Medium]
Is a warning appropriate on a path that any station in the BSS can
trigger? This call, the IPv4 one in ip_rcv_finish_core() and the two in
arp_process() all go through net_ratelimit(), which uses one global
state:

net/core/utils.c:
DEFINE_RATELIMIT_STATE(net_ratelimit_state, 5 * HZ, 10);

A remote sender can keep that budget used up. dmesg then fills with
addresses the sender chooses, and unrelated networking warnings are
suppressed.

The IPv4 comment quotes RFC 1122 saying such datagrams should be silently
discarded. These drops were also already visible before the patch through
SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST (the kfree_skb tracepoint and
drop_monitor), and IPv6 already counted them in IPSTATS_MIB_INHDRERRORS.

The commit message says they "were silently discarded without warnings
or MIB stats". Is that accurate?

>  		SKB_DR_SET(reason, UNICAST_IN_L2_MULTICAST);
>  		goto err;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002082336.608201-1-starchang%40google.com
