Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.238.174.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200967;
	b=tuiH7OKwDuwKCzDg5n12bKnEGDBkJ/eHfx7UYDozN+PmpU125pegmD0h9+nH8ZKQLHSy
	 Jes4KnPMqv1woa697ZNlSDPegrK5nESP9rnB6IqEx0nubOnfIszz4363Zlee2kxVviA/J
	 kTFbkGN+ENFags5AFmV/7qEXFdxRWXcSLpSOEXUX8HO0lQHKNJRN3ATz12CFS3rixCyNi
	 ESrO4RRkVVG5/uzrqFiluqjRdWizM88av2MsGcThVS2LCA7kJM7hrKoLWxfL9wTNuJb6C
	 zYZxBsR4NWLzU+WhJG3Xsw7pXLWQe+1Bv7kzditzvIf0FnomuNIjGrID5zxGAnDs7Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200967;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:
	 Content-Type;
	bh=qGRmNggSaPp8mWkkEQlD8kxUR423ZcG9+LSn2ibB6HM=;
	b=vjhuXmolRG92NC61EB/7vQDBdp3CZixEZDm2qYZAJEHOoieIC4kBO8zAiTq7jQMxEa/i
	 IiJY74DoMlgO96PxVO5W4txuIi4BCbwHq0JxH4nbDTYDoIL1hHqyRBUcT7euAbUV6loeZ
	 tk9fgCTS8zoUy/xPiwPb5yU1hNaG9oq3n2yurdHkHmkIcLizslqneTkwgMy/gr8crAovj
	 /jzOEyizmFLVUmUHNEbUGp5ZuPDmhJ6ziu6Ig5Y2JYHPg7bQ5vGLm31WK6KX13funF4Cn
	 wf1Vnc5lT16q83xyDceDGoLidRrNqyR/JQdUC9M6jxJovSPHtLYXU9m5rLZmYOnWSHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ssi.bg;
	spf=pass smtp.mailfrom=ssi.bg;
	dkim=pass header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=EJ5WAzHG;
	arc=none smtp.remote-ip=193.238.174.39
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF4606AB2B;
	Wed, 28 Oct 2026 15:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27FF4606AB2B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=ssi.bg header.i=@ssi.bg header.a=rsa-sha256 header.s=ssi header.b=EJ5WAzHG
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 846BB21F6D;
	Wed, 28 Oct 2026 17:22:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=qGRmNggSaPp8mWkkEQlD8kxUR423ZcG9+LSn2ibB6HM=; b=EJ5WAzHGKKQF
	gIHozt7WR3TkigkU74+wh7TyKYh8lgsjr8a4caRnGha6k4D+KWs95IpfwHVwjzf0
	Fv4i6rRUvjKwLRHdALBEVQG0s2ErjTggT8jLq/MHa46RWxZJPEA/9KDx0Pszg3ne
	K4328bA1zS4xh/vXZSTK9uecgY1kErQp0D3PhvKW24Q2fHIMBUG2831AJI1cGKuL
	TeOOL0c8XzwspPgGn66JG/4E9ADKg6vU4RVFFW2IuOmRQprEjv47z6kqsC9Y9BTo
	yqno9kyznagqWymfPgqmESem7iAV5/QQ0enURfoJW7xcoZd+pDoahtqgwn/6s6x6
	qv8hssZ1Pkrt0hUZAYY/a5+DptkvVmuW7uxBcNFx/pGnnhYxxuDYqt/tvmjVL5vW
	NavyUnatxCL/FimsX3UVeqH0poitzDUqkzVYjgUT+mNS4lXhM9OOUHZImeYKAwbr
	HnJ/ab8FiW3R4p8vYQTYmDGBdkrB1v+YZyoqMsxfazcE6HKdSx54qnpE+ZbKCeZa
	PlDLN091P9+9YcJQffkXG4+8DeLavvE0Oh/ck/upBor2KPaFKuFl7nN+o66uuc5l
	OoGGkCRVZ1RqTubxf2kaGLEw4SKQ7b4rI6+JEZkmvPJ4sh+BMF70k63KwoKqrzXr
	KRenrAzaXEtxozalhGZUrH9ogaR+znY=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Wed, 28 Oct 2026 17:22:36 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id CA8B9608C6;
	Wed, 28 Oct 2026 17:22:35 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 69SFMRhY035032;
	Wed, 28 Oct 2026 17:22:27 +0200
Date: Wed, 28 Oct 2026 17:22:27 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Star Chang <starchang@google.com>
cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, johannes@sipsolutions.net,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        wangroger@google.com
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
In-Reply-To: <20261028061644.2997812-1-starchang@google.com>
Message-ID: <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
References: <20261026150539.1357037-1-starchang@google.com> <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg> <20261028061644.2997812-1-starchang@google.com>
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

On Wed, 28 Oct 2026, Star Chang wrote:

> Hi Julian,
> 
> Thank you very much for the insightful review and for pointing out the RFC 826 and RFC 2002 references.
> 
> You are completely right on both points:
> 1. Per RFC 826, the Target Hardware Address (tha) in an ARP Request has no protocol meaning, and Linux updates neighbor entries using (sip, sha), never tha. Inspecting tha on ARP Requests was a fundamental mistake and would break legitimate devices that leave arbitrary/unicast addresses in tha.
> 2. In RFC 2002 (section 4.6), many real-world GARP reply implementations legitimately set tha to the broadcast address (ff:ff:ff:ff:ff:ff) since the announcement is broadcast to all hosts. Requiring tha == sha in our check was overly restrictive and would cause false-positive drops for legitimate GARP replies.
> 
> Regarding your question about arp_accept:
> In our testing, arp_accept = 0 successfully prevents creating *new* neighbor entries from unsolicited broadcasts. However, in typical client scenarios, the victim station almost always already has an existing neighbor entry for its default gateway (i.e. n is not NULL in arp_process).
> 
> When n already exists, arp_accept is bypassed, and once the 1-second LOCKTIME window has passed, arp_process() calls:
>     neigh_update(n, sha, state, NEIGH_UPDATE_F_OVERRIDE, 0);
> which executes memcpy(&neigh->ha, lladdr, dev->addr_len) in __neigh_update(), overwriting the gateway's cached MAC address with the attacker's MAC.
> 
> In a Wi-Fi (Hole-196) scenario where clients share the GTK, an attacker cannot forge unicast frames directly to the victim, so they broadcast an unsolicited unicast ARP Reply (sip = gateway_ip, sha = attacker_mac, tip = victim_ip) over L2 broadcast (PACKET_BROADCAST).
> 
> Under standard networking behavior, a non-GARP ARP Reply is strictly meant to be delivered as an L2 unicast frame (PACKET_HOST) to the requester. The only legitimate reason an ARP Reply is ever sent over L2 broadcast is for Gratuitous ARP (sip == tip).
> 
> Based on your feedback, we plan to completely drop all checks on tha, leave ARP Requests entirely untouched, and strictly narrow the ARP defense to drop ARP Replies received over L2 BMC *only* if they are not Gratuitous ARP (sip != tip):

	Sashiko gives also example with RFC 3927 Section 2.5 and 4
where ARP packets (especially replies) with sip in 169.254.0.0/16
MUST be sent as broadcasts, so that boxes can detect that
their address is configured also on another host. So, may be
we should not drop sip in 169.254.0.0/16. But it is another open door.

	As for the received broadcast requests, it is still possible
to send replies where needed but to skip the step where we use sha
to update the cache for sip. We can set some flag 'cacheupd' early
and later to check it. The result will be:

- ARP Probes: replied as usually (there is no cache update for sip 0)
- n = neigh_event_ns(): avoided but replies are sent if !dont_send
- do not lookup for n, jump before the lookup
- ARP Announce (GARP): ignored, sorry, the attacker announces
new sha for GWIP

> 
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -791,32 +791,18 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	    (!IN_DEV_ROUTE_LOCALNET(in_dev) && ipv4_is_loopback(tip)))
>  		goto out_free_skb;
>  
>  	if ((skb->pkt_type == PACKET_BROADCAST ||
>  	     skb->pkt_type == PACKET_MULTICAST) &&
>  	    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {
> -		bool is_valid_garp = (sip == tip) && tha &&
> -				     !memcmp(tha, sha, dev->addr_len);
> -
> -		if (arp->ar_op == htons(ARPOP_REPLY) && !is_valid_garp) {
> -			net_warn_ratelimited("Drop ARP Reply in L2 BMC on %s\n",
> +		/*
> +		 * Standard ARP Replies are strictly unicast (PACKET_HOST).
> +		 * An ARP Reply in an L2 broadcast frame with (sip != tip)
> +		 * is an injected unicast reply. Legitimate GARP (sip == tip)
> +		 * is preserved and defers to DROP_GRATUITOUS_ARP.
> +		 * ARP Requests are left untouched per RFC 826.
> +		 */
> +		if (arp->ar_op == htons(ARPOP_REPLY) && sip != tip) {
> +			net_warn_ratelimited("Drop non-GARP ARP Reply in L2 BMC on %s\n",
>  					     dev->name);
>  			goto out_free_skb;
>  		}
> -		if (dev->addr_len == ETH_ALEN && tha &&
> -		    is_valid_ether_addr(tha) && !is_valid_garp) {
> -			net_warn_ratelimited("Drop unicast THA ARP Req in L2 BMC on %s\n",
> -					     dev->name);
> -			goto out_free_skb;
> -		}
>  	}
> 
> With this approach:
> 1. ARP Requests are completely untouched (fully adhering to RFC 826).

	See above

> 2. Legitimate GARP announcements (sip == tip) for VRRP/HSRP router failovers are preserved regardless of what value they put in tha (respecting RFC 2002).

	Drop them. Or leave it to DROP_GRATUITOUS_ARP to decide,
it is per iface too. There should be no chance to update cache
from broadcasts.

> 3. Injected unicast ARP Replies in L2 BMC (sip != tip) that poison existing gateway entries are dropped.
> 
> Does this sound like the right direction to you for v5?

	Yep. But not sure for the IP part...

> Thanks again for your time, guidance, and expertise!
> 
> Best regards,
> Star Chang

Regards

--
Julian Anastasov <ja@ssi.bg>

