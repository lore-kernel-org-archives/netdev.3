Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61178348C7D
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515464; cv=none; b=eWlZ87hSG5Ob+wZLI3gBRqDxXxGTubG6JlJjhqQC8VFWbD1Hd8bkc0fHK1wueELrjLHGPG4GIqEtkrC1qiUPmjq6McUuK79DDXYRgL0SPR0v+uu6eqPQY9HHl+tvOQlBuSPJ8wxYig5C/UoeISuMFUnsfVoe0RrLdBD4VUJO6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515464; c=relaxed/simple;
	bh=11qX3ADQzYDDWACp0vQjnq9UegF0RkPF5n7qurTYA4w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xqfo6SmnSLUGJvbzSqZDMsrWgvLvHTUv1dt0y97blT3LJvGGYEY8d+6BYNVXIpBI6efC25NhCBO0v6Y+mHJNOYA+jsjiYrzJbdRmCpXhFJuh5ZzzcCiaIkLtqCS/RqtyqX0ToBS4HBIwmJTUIYE6iXi0ZWY7A//q7Zhx/xRNq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHkHGkNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHkHGkNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B591F00893;
	Sun, 27 Sep 2026 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790515463;
	bh=q7oiKhQ1n05jwOVpi35qh483ffcsJ4Q2UYXV0Kk7wLw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AHkHGkNShBmIHvoymuhNuIpsjJCjySR62YPrbpXg8azExyB+1S0+bLv9iGTQUwOWQ
	 k7Y9SaFI0xiOPU72qMuHUr+FRfwkltVjFfSzGOqFULctVWghcNU7inW4CmHe4cF1QY
	 KztRyQa98wfgW+R5c5vIaZPak6RcW1fE8GaWCLJrgrBWIxC6MZqhMb2jJQSD297Peq
	 H8aMUrEfrJwQ6is6yk1ldWVnXYnxPETWI6Skl5zbMYRIjkVNDbNJQ8nVHj2J9M65NV
	 Mr2hczMoW5y6WcpNCONQXOpn3PdgSq0S/HjhZJQT9Jl78t4E3/b+cUgHy5ijmXQ0UY
	 k9HNYN+W5Cyqw==
Subject:
 Re: [PATCH net-next v6 2/8] hsr: Use skb_clone() while adding the HSR header
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Sun, 27 Sep 2026 13:24:21 +0000
Message-ID: <179051546172.2160803.467016128961136079@kernel.org>
In-Reply-To: <20260923-hsr_ptp-v6-2-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-2-6ea07b3fb8a8@linutronix.de>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] hsr_create_tagged_frame() in net/hsr/hsr_forward.c now builds
  the tagged frame with skb_clone() + skb_cow_head(), but it still runs…
- [Medium] hsr_create_tagged_frame() now calls
  skb_set_network_header(skb, ETH_HLEN + HSR_HLEN) and…
- [Medium] For locally originated and interlink frames,
  hsr_create_tagged_frame() now places network_header after the HSR tag…
- [Low] In hsr_create_tagged_frame(), the new `pskb_may_pull(skb,
  HSR_HLEN + movelen)` (line 366) runs before skb_push(), while…

--

hsr: Use skb_clone() while adding the HSR header

This patch changes hsr_create_tagged_frame() to build the tagged frame
with skb_clone() and skb_cow_head() instead of __pskb_copy(). The goal is
to keep skb_shared_info, and with it any timestamp request. The
NETIF_F_HW_HSR_TAG_INS case now returns right after the clone, and the
network header and mac_len are now set explicitly after the HSR tag is
inserted.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 44f6d9c83180a..d5e6597917c26 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -342,16 +342,18 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  		/* set the lane id properly */
>  		hsr_set_path_id(frame, hsr_ethhdr, port);
>  		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
> -	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> -		return skb_clone(frame->skb_std, GFP_ATOMIC);
>  	}
>  
> -	/* Create the new skb with enough headroom to fit the HSR tag */
> -	skb = __pskb_copy(frame->skb_std,
> -			  skb_headroom(frame->skb_std) + HSR_HLEN, GFP_ATOMIC);
> +	skb = skb_clone(frame->skb_std, GFP_ATOMIC);
>  	if (!skb)
>  		return NULL;
> -	skb_reset_mac_header(skb);
> +
> +	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
> +		return skb;
> +
> +	/* Ensure the cloned skb has enough headroom to fit the HSR tag */
> +	if (skb_cow_head(skb, HSR_HLEN))
> +		goto err;
>  
>  	if (skb->ip_summed == CHECKSUM_PARTIAL)
>  		skb->csum_start += HSR_HLEN;

[Severity: High]
Is this csum_start adjustment still correct after the switch to
skb_clone()?

With __pskb_copy(), skb_copy_header() copied csum_start as a raw offset
from head into a buffer with HSR_HLEN more headroom. That made the
+HSR_HLEN necessary.

Now skb_clone() copies csum_start unchanged. The clone's header is always
cloned, so skb_cow_head() goes through pskb_expand_head(), which already
rebases the offset:

net/core/skbuff.c:skb_headers_offset_update() {
    ...
	if (skb->ip_summed == CHECKSUM_PARTIAL)
		skb->csum_start += off;
    ...
}

The skb_push() and memmove() below only move the Ethernet/VLAN header into
the headroom. L3/L4 stay where they are. That seems to leave csum_start
HSR_HLEN bytes past the real L4 header.

hsr_dev_setup() sets NETIF_F_HW_CSUM on the hsr device, so locally sent
TCP/UDP is CHECKSUM_PARTIAL. Consider a slave without
NETIF_F_HW_HSR_TAG_INS that falls back to skb_checksum_help() for
ETH_P_HSR. Wouldn't the checksum be computed from the wrong start and
written to the wrong offset (into the padding for a short ACK)?

When the linear area ends right after a 20 byte TCP header, would it hit
WARN_ONCE("offset+2 (%zu) > skb_headlen() (%u)\n") and drop the frame?
Slaves with HW_CSUM would get the shifted csum_start in their descriptors.

This line is still unchanged at the end of the series.

> @@ -360,15 +362,24 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  	if (frame->is_vlan)
>  		movelen += VLAN_HLEN;
>  
> +	/* The entire header area needs to be linear */
> +	if (!pskb_may_pull(skb, HSR_HLEN + movelen))
> +		goto err;

[Severity: Low]
This pull runs before skb_push(), while skb->data still points at the
original MAC header. The extra HSR_HLEN bytes come from headroom that
skb_cow_head() already guaranteed. Would pskb_may_pull(skb, movelen) be
enough here?

As written it requires skb->len >= movelen + HSR_HLEN. fill_frame_info()
only checks:

	if (skb->mac_len < sizeof(struct ethhdr))
		return -EINVAL;

So 14 to 19 byte frames (18 to 23 with VLAN) now reach the err label and
get freed. For example, AF_PACKET SOCK_RAW on the hsr device can send
them.

Before this patch, hsr_fill_tag() padded such frames and forwarded them:

	if (skb_put_padto(skb, ETH_ZLEN + HSR_HLEN))
		return NULL;

This is also still present at the end of the series.

> +
>  	src = skb_mac_header(skb);
>  	dst = skb_push(skb, HSR_HLEN);
>  	memmove(dst, src, movelen);
> +	skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);

[Severity: Medium]
Should this offset include VLAN_HLEN when frame->is_vlan is set?

In that case movelen includes VLAN_HLEN, and hsr_fill_tag() puts the HSR
tag after the VLAN header:

	hsr_ethhdr = (struct hsr_ethhdr *)(pc + VLAN_HLEN);

So L3 starts at mac + ETH_HLEN + VLAN_HLEN + HSR_HLEN. As written,
network_header points 4 bytes into the HSR tag, and skb_reset_mac_len()
sets mac_len to 20 for in-band 802.1Q frames.

Two ways to get such frames: an 8021q upper with txvlan turned off on the
hsr device, or AF_PACKET frames that carry an 802.1Q header.

Before this line, skb_clone() plus skb_cow_head() had already left
network_header at the real L3 offset. The explicit set overwrites it. This
is still present at the end of the series.

[Severity: Medium]
Separately, hsr_fill_tag() sets skb->protocol to ETH_P_HSR or ETH_P_PRP.
For those protocols the flow dissector expects a struct hsr_tag at
skb_network_offset():

net/core/flow_dissector.c:__skb_flow_dissect() {
    ...
		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
		...
		proto = hdr->encap_proto;
		nhoff += HSR_HLEN;
    ...
}

With network_header now past the HSR tag, won't the dissector treat the
inner IP header as the HSR tag? It would take encap_proto from the IP ID
field and then skip another 6 bytes.

The old __pskb_copy() path left network_header at the start of the HSR
tag for locally originated frames, so dissection of those frames used to
work. Ring-forwarded frames already had this layout from
hsr_handle_frame(), but this patch extends it to local and interlink
traffic.

This would affect egress tc flower matching on the slave (fl_classify()).
It would also affect skb_get_hash() for traffic without a precomputed
hash, which could spread one flow across fq_codel buckets or TX queues.
It is not fixed later in the series.

>  	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-hsr_ptp-v6-0-6ea07b3fb8a8%40linutronix.de
