Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.238.174.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103439;
	b=5fk14wivDvn9qyAjmJ3wgSW9KQi9iHVU80yXfedJ/GU940R4MpOEKXr5+VCxvd0CPTGG
	 U8qxCDiTd7UnHbzTcOU7RCODo+o4j1YhEDpunU2qSEzY2VE+nu5xRAI6TuXIh1jjtzetZ
	 Bohq4228Hu9SSIK09Tw7TTCo7bbWS+cMNINrXv4wonO479K8RChRnng2Te84kQzVBukMl
	 M1b/ftc3z0Re1hPjT/aorATRfyVJal9cYzytdwYG4bbWzfZ++uujMCZpEs/VPfINFpghK
	 cbE9uUBPfVrRxEr5nqQRpvl9STYNVMqFJ97OL5WlMUhpT1p8Np5Iwl2H5oz5nJ/Of9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103439;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:
	 Content-Type;
	bh=OWa46KzbFqZ91wj51JOTyCuFGEpI3WQbD14F/DuR36M=;
	b=eIPFh2xELednV8VxTJVj6CoSQHrf0gKFVy9XYprgU9oADsBC7TG7ytHhhcyXgMo2NhS0
	 Vy9b4PnELZueQhbAKc7e2Z9Isaenpk3pmyWYoZ586iAtgpq9Je68UsL62GhMczhSzZUmg
	 yBhJHeNJZzjog2Gndq6IJjUGVSInjGj3qBaTp33hJD22Tt5UbidxsWiwJOIe4cJ7J1GC6
	 df2eo+cXPNTCTHvGvFQKbvW5qjzfH5iHlaKrHTh3o4MLAKZlJBsZXSxEtQAvjbgREqKox
	 BVz5UReJCw/hc7Dkoq5fwzYWozfu/6yHahrRel2ZN/RaQ+QOcTmWMtv4KW0DL8+3jug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ssi.bg;
	spf=pass smtp.mailfrom=ssi.bg;
	dkim=pass header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=ROeBQYV4;
	arc=none smtp.remote-ip=193.238.174.39
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F784606A320;
	Tue, 27 Oct 2026 12:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F784606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=ROeBQYV4
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 7F9A6225BB;
	Tue, 27 Oct 2026 14:17:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=OWa46KzbFqZ91wj51JOTyCuFGEpI3WQbD14F/DuR36M=; b=ROeBQYV47Enn
	bmiLvmbBrSCW3//IQtUQM1bfV7vhHM9zC0hrDLQPGO/bDEqUmvpDFb/qAlKk4Jdq
	bYV/qQ0rRaskyOJeTrM/S1WJcAR/HnNkqn1MoBMRqAfqamHI6eR34TjuK2XlzsSb
	b1eKUoYfhbKPtwBadf/JInROwo/jGz1y0YeCbEtpSJ/0PmSFBdAYgSG6nYB/ibXV
	4N6srhYAc0u8KJuyHa0aZvG6sUOwoqI1Hgs7c57YJ7dwXfYOqgO+MEb1hsNhZ7g6
	MBfnTItNKRWkNXwnYeQk10PTedi+2DIhMr/EeVtVJbReM2zp3JjBHskvs84XYhxV
	lir/Tj8jaQWp0J71A92lR0no8Om665Dn6qP9JwX+71TKCZ888QIERImctqDRjocC
	qbW/7bAoznMYlsFGtmSnmuL6FJq9V8NpZFCPGdwFC6DFd0DZF2Qo05fS+bl5cj9v
	2e0FKKQUWLUkx9Atz6hHLr14eNJFVOBNxTbODS1OfLrztAQtZkiH66XZmzCjVyAR
	pnQ+OQYu/T7tbVuqKaBr2huQTKcBPaVTQoU3kT8ZZ2HvbcjoB3RzVTndEnehnkvE
	aO/c6pWNyT7HHHwYY/7kUVQYTwXkrPhnR28qtmf+UeevqoCHOsFDs5fJUhi+eFyQ
	wTKjLHWU/xtJCVWsEt4SMy7kJy5uZew=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Tue, 27 Oct 2026 14:17:08 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 20E3C60211;
	Tue, 27 Oct 2026 14:17:08 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 69RCGweS045526;
	Tue, 27 Oct 2026 14:16:59 +0200
Date: Tue, 27 Oct 2026 14:16:58 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Star Chang <starchang@google.com>
cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, johannes@sipsolutions.net,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
In-Reply-To: <20261027015619.1745984-1-starchang@google.com>
Message-ID: <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg>
References: <20261026150539.1357037-1-starchang@google.com> <20261027015619.1745984-1-starchang@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Tue, 27 Oct 2026, Star Chang wrote:

> Wi-Fi 802.11 to 802.3 frame translation allows attackers to inject
> unicast L3 packets or ARP payloads inside GTK-encrypted L2 broadcast
> and multicast (BMC) frames (the "Hole-196" vulnerability).
> 
> While the `drop_unicast_in_l2_multicast` sysctl was introduced to drop
> unicast IPv4/IPv6 packets received over L2 BMC, it had several gaps:
> 
> 1. ARP packets were not checked in `net/ipv4/arp.c`, allowing attackers
>    to perform ARP poisoning via L2 BMC frames (`group-arp-unicast`).
> 2. Enforcement lacked DHCP client (UDP port 68) exemption, which could
>    discard legitimate DHCP server responses sent via L2 broadcast.
> 3. Dropped packets were silently discarded without warnings or MIB stats.
> 
> The issue was identified via manual code inspection and protocol security
> analysis of cross-station frame injection in 802.11 shared-key (GTK)
> networks. In laboratory testing, crafted 802.11 broadcast frames containing
> unicast ARP payloads (e.g. ARPOP_REQUEST / ARPOP_REPLY with tha set to a
> victim's unicast MAC) bypassed the existing sysctl, poisoning the victim's
> ARP cache. Furthermore, per RFC 2131 inspection, unconditionally dropping
> L2 broadcast frames carrying unicast IP addresses discards standard DHCP
> server responses (DHCPOFFER/DHCPACK) destined for UDP port 68 during lease
> negotiation.
> 
> Enhance `drop_unicast_in_l2_multicast` sysctl enforcement:
> - Extend sysctl checks to `net/ipv4/arp.c` (`arp_process()`) to drop
>   unsolicited ARP Replies and ARP Requests with a non-zero unicast
>   Target Hardware Address (tha) received over L2 BMC.
> - Exempt Gratuitous ARP (GARP) and RFC 5227 Address Announcements
>   (`sip == tip`) from L2 BMC unicast drop logic so they defer to the
>   `DROP_GRATUITOUS_ARP` sysctl, preserving VRRP/HSRP router failover.
> - Exempt non-fragmented DHCP client traffic (UDP dest port 68) in
>   `net/ipv4/ip_input.c` and safely reload `ip_hdr(skb)` after
>   `pskb_may_pull()` to prevent dangling pointer access.
> - Log rate-limited warnings (`net_warn_ratelimited`) and increment MIB
>   error counters (`IPSTATS_MIB_INHDRERRORS`) for dropped frames.
> 
> Fixes: 12b74dfadb5a ("ipv4: add option to drop unicast encapsulated in L2 multicast")
> Fixes: abbc30436d39 ("ipv6: add option to drop unicast encapsulated in L2 multicast")
> Signed-off-by: Star Chang <starchang@google.com>
> ---
> v3 -> v4:
>   - Fix broken newline syntax in net_warn_ratelimited() string literal
>     in net/ipv4/ip_input.c that caused build failures across 32-bit,
>     allmodconfig, and clang CI builds.
>   - CC Julian Anastasov (ja@ssi.bg) per netdev-bot blamed author check.
> v2 -> v3:
>   - Add Fixes: tags for commits 12b74dfadb5a and abbc30436d39.
>   - Reformat lines in net/ipv4/ip_input.c to adhere strictly to the 80-column limit.
>   - CC maintainers Ido Schimmel and Simon Horman per netdev bot check.
> v1 -> v2:
>   - Clarified discovery method and triggering context per netdev-bot feedback.
> 
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index d409f606aec0..ad23db2e2f59 100644
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
> +		bool is_valid_garp = (sip == tip) && tha &&
> +				     !memcmp(tha, sha, dev->addr_len);

	I'm not sure how much from the Sashiko review is addressed:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002082336.608201-1-starchang%40google.com

	But matching sha and tha for requests is wrong.

From RFC 826:

===
The target hardware address is included for completeness and
network monitoring.  It has no meaning in the request form, since
it is this number that the machine is requesting.  Its meaning in
the reply form is the address of the machine making the request.
===

	tha is used only for monitoring. Linux copies sha from
requests into tha field in the reply. It does not use the tha
to update the cached entry, instead sha is used for this.

	From RFC 2002, section 4.6, about Gratuitous ARP:

===
When using an ARP Reply packet, the
Target Hardware Address is also set to the link-layer address to
which this cache entry should be updated (this field is not used
in an ARP Request packet).
===

	It means to store the sender address there too. But as we
see nobody updates cache from tha, only from sha. But there are
GARP implementations that store broadcast address in tha when
sending broadcast GARP reply, may be because the packet is intended
to ALL, not just to simulate a reply packet addressed to the sender.

	So, I'm not sure why arp_is_garp() requires tha and
sha to match for GARP reply. It is too restrictive for no good
reason. We can safely ingore tha in arp_process. Let the packet
capture tools to check it, for monitoring purposes. There we can
see in tha to which hosts the packet was sent.

	As for the ARP broadcasts, we already have "arp_accept"
sysctl that prevents new entries to be added to cache. Can it
help for your ARP tests?

> +
> +		if (arp->ar_op == htons(ARPOP_REPLY) && !is_valid_garp) {
> +			net_warn_ratelimited("Drop ARP Reply in L2 BMC on %s\n",
> +					     dev->name);
> +			goto out_free_skb;
> +		}
> +		if (dev->addr_len == ETH_ALEN && tha &&
> +		    is_valid_ether_addr(tha) && !is_valid_garp) {
> +			net_warn_ratelimited("Drop unicast THA ARP Req in L2 BMC on %s\n",
> +					     dev->name);
> +			goto out_free_skb;
> +		}
> +	}

Regards

--
Julian Anastasov <ja@ssi.bg>

