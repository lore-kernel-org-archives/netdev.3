Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CB431481
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213250; cv=none; b=PL9xIHR5ptLK2pucPtF9N46OzHlUU3XsLZQ22fgvVGrJi1Vt0td4YZLu+Hdb8Zelfg0aXzMjVGQvDmaiRpi9VuHTi/FKLrvCPqN5pQ0XaYzi9LZ+yB4ynjRM2ijXisX7ynAcmMd3HfX1ZhvJVeVi8xX6b9pd6ulfedaiQC3RfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213250; c=relaxed/simple;
	bh=mP3pG57rJTV2ZTAz+cMMP7Peezbrk9v36gyIsOtVlP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUYglLHX3M+txvtGEpIKfycRiIlFOyhA78O7Xt1BZPSDdqoSS3ikJZrSFnenm+qzsBMmA87iJmtr1+kRFtzjM5dWni1lF/ciPAz2WE7czlokNiLVfttympOyaYlRbuaWQAEjhEuM1H9cOhFCpwlhb0/ZmcN9RvLFB7FlgDcRHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBbblZjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBbblZjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5651F000E9;
	Thu, 16 Jul 2026 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213241;
	bh=6CAKbgyftkiskkEbzPPx9RSTGyx/cfVOOyxSIHt+e34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBbblZjHXS8IoerjJHGoMTyrIslZrJ8ck+FHf3Q7CUCLqeakG2Y+mbmy2SdSp4a8G
	 3x76rsOSi5WuCcmQzkpjSSLmLPMzL3f554OFJlQmR6vVd91yDnOKgDuk3EaM0eAmxA
	 8nYyz40/SrDwbs+2XhOOEM4M08bXtAlaCZGkq+DLK8znRbGr2IMHbAmPtNoW/sJNAc
	 a+QTIfZxdU1CzlKE3ZYdOgf9RnPZtp3yKY99ohJQ5lUZssa3TfkxaFPxQ/tR8wASW/
	 SKHN+hoqhWxGO82zzvlG10loXUnzH8XBeSK8CgJPMcG4OpZlYTppf9/1/9jJM/ogq9
	 768PhxH6aimHA==
From: Simon Horman <horms@kernel.org>
To: alice.kernel@fastmail.im
Cc: Simon Horman <horms@kernel.org>,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lucien.xin@gmail.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	dsahern@kernel.org,
	razor@blackwall.org,
	shuah@kernel.org,
	stfomichev@gmail.com,
	andrew+netdev@lunn.ch,
	fw@strlen.de,
	netdev@vger.kernel.org,
	alice@isovalent.com
Subject: Re: [PATCH net-next v9 1/9] net: Use helpers to get/set UDP len tree-wide
Date: Thu, 16 Jul 2026 15:46:21 +0100
Message-ID: <20260716144620.331419-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710134242.216538-2-alice.kernel@fastmail.im>
References: <20260710134242.216538-2-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [1]: [PATCH net-next v9 1/9] net: Use helpers to get/set UDP len tree-wide ---
commit 113d28557bcedccc492f330fafdaaf1377eb2e79
Author: Alice Mikityanska <alice@isovalent.com>
    
net: Use helpers to get/set UDP len tree-wide
    
This commit introduces helpers for setting and getting the UDP header length
tree-wide. It prepares the codebase to support BIG TCP for UDP tunnels by
explicitly handling cases where UDP length might be 0 for packets larger
than 65535 bytes.

> diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
> index 0a506c77283dd..ed4227e6db744 100644
> --- a/net/6lowpan/nhc_udp.c
> +++ b/net/6lowpan/nhc_udp.c
> @@ -88,16 +88,16 @@ static int udp_uncompress(struct sk_buff *skb, size_t needed)
>  	switch (lowpan_dev(skb->dev)->lltype) {
>  	case LOWPAN_LLTYPE_IEEE802154:
>  		if (lowpan_802154_cb(skb)->d_size)
> -			uh.len = htons(lowpan_802154_cb(skb)->d_size -
> -				       sizeof(struct ipv6hdr));
> +			udp_set_len_short(&uh, lowpan_802154_cb(skb)->d_size -
> +					  sizeof(struct ipv6hdr));

[Severity: High]
If a crafted packet specifies a datagram size smaller than
sizeof(struct ipv6hdr), won't this subtraction underflow?

The resulting massive unsigned value passed to udp_set_len_short() would
then trigger the DEBUG_NET_WARN_ON_ONCE, potentially causing a panic if
panic_on_warn is set.

> [ ... ]
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 29651b1a0bc70..493e2b9e16fbc 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> [ ... ]
> @@ -915,12 +914,12 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
>  int udp_gro_complete(struct sk_buff *skb, int nhoff,
>  		     udp_lookup_t lookup)
>  {
> -	__be16 newlen = htons(skb->len - nhoff);
>  	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
> +	unsigned int newlen = skb->len - nhoff;
>  	struct sock *sk;
>  	int err;
>  
> -	uh->len = newlen;
> +	udp_set_len_short(uh, newlen);

[Severity: High]
If gro_max_size is configured larger than 65535 (which is supported and used
for BIG TCP), can't UDP GRO aggregate packets such that newlen > 65535?

This would instantly trigger the DEBUG_NET_WARN_ON_ONCE inside
udp_set_len_short() for legitimate large packets.

> [ ... ]
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index 9ab3728f9630b..0fccb38f074d2 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -178,7 +178,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
>  
>  	uh->dest = dst_port;
>  	uh->source = src_port;
> -	uh->len = htons(skb->len);
> +	udp_set_len_short(uh, skb->len);

[Severity: High]
When transmitting a TCP BIG TCP packet (which can be > 64K) over a UDP
tunnel like VXLAN, skb->len will exceed 65535.

Does using udp_set_len_short() here incorrectly trigger the warning for
valid large GSO payloads?

> [ ... ]
> diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
> index 9adb5775487fa..dcff7fb16ff64 100644
> --- a/net/ipv6/ip6_udp_tunnel.c
> +++ b/net/ipv6/ip6_udp_tunnel.c
> @@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
>  	uh->dest = dst_port;
>  	uh->source = src_port;
>  
> -	uh->len = htons(skb->len);
> +	udp_set_len_short(uh, skb->len);

[Severity: High]
This appears to have the same issue as IPv4 tunnels. If a large GSO payload
is sent through an IPv6 UDP tunnel, won't skb->len exceed 65535 and trigger
the warning?
