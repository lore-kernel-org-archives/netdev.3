Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BB4A2E1F;
	Sun, 18 Oct 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328648; cv=none; b=e9GczNiibYHO92AGriGDjd1wAH49DkzO4Bp7CsaX6UFzHfE7Sui58MlNM6GpxQM40V8CC6xvLulOyJO+MikPY/G8qfuUkOgbBcMqtninVXpGYvGk3Hhne40qUZyJTlvSy7C7zI2dYwSyDrwa89+91O92L7WCL5VPNbaqSMEdPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328648; c=relaxed/simple;
	bh=CTBZjPe5YoOg6Sl3T4WvyA9RXgJmWOuttfpvu3HaBeE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNr1z+gos7D7qXbrBkSSSauG6qk1Emx6YoFCb5TdEKgdW8SWarOvzLt0Ol0kM+5xUK2PLlY3kzWXIbe/dPdf70DGlbpsNpdUxMWqOKjfr/abdJvVRxzzeYKmKCdr0B5ZaS8PxbwL63uaW/XvudZk2NRGc+ULAdDFzTupDP8l928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuymPHg2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuymPHg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA831F000C5;
	Sun, 18 Oct 2026 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792328647;
	bh=bNYaS60Hmvjj2uS9tm3yDAErMARRLjvnPsq/1nR9cIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FuymPHg2X+uJjK3uDDh7LVvKs+ob4003AnLOAUg0tkMJZ/dj9mz2z3IJfT/d0+0gH
	 MkpmGJP/Q8s53tuO6gIW4SBYO+3PYVdISM74yRWfrvjGb5mhf/J7Ihhv+fUWrfqLY+
	 EZtr/6ZWrKctBXp1rTAOv5+lnBLFlMLtypKA4yMeoLykZFDMv7PrXaaj+6RjXhdSf7
	 wU3Ey6/E2Fq6Rpnw9rUPgosbUSp48lmPEl9tdYIfvcj3F+yZGBGrd0QEQGFvAzeRdT
	 jmtYCHtDyQw05ncY0QPvLTGgBdhlTaNM6zo7/FTjxruK4s1cuqgjQyczwuRHmyrP0x
	 2kyl+d7K1nOnA==
Subject: Re: [PATCH net v2] seg6: Fix unset mac header in SRv6 End.DT VRF
 decapsulation
From: netdev-bot+sashiko@kernel.org
To: yymhvert@gmail.com
Cc: andrea.mayer@uniroma2.it, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, co+98d7de09cd94fec5@bugs.sh
Date: Sun, 18 Oct 2026 13:04:06 +0000
Message-ID: <179232864641.3135.3823569541245857805@kernel.org>
In-Reply-To: <20261017120144.3059-1-yymhvert@gmail.com>
References: <20261017120144.3059-1-yymhvert@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In end_dt_vrf_rcv() (net/ipv6/seg6_local.c), the new code
  restores only skb->mac_header.

--

seg6: Fix unset mac header in SRv6 End.DT VRF decapsulation

After the VRF rx handler returns, this patch makes end_dt_vrf_rcv()
restore a valid mac header that points at the network header. It only
does this when the VRF has not rebuilt one for sniffers. This fixes an
out of bounds read during UDP GSO re-segmentation: skb_mac_offset() on an
unset mac header gave a huge __skb_push() length.

> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 53f7b24525759..8bc13420f9942 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1200,6 +1200,14 @@ static struct sk_buff *end_dt_vrf_rcv(struct sk_buff *skb, u16 family,
>  		/* the skb buffer was consumed by the handler */
>  		return NULL;
>  
> +	/* the VRF device had its chance to rebuild the mac header for
> +	 * sniffers; restore a valid one pointing at the network header,
> +	 * like any L3 device without an L2 header, before the packet
> +	 * continues up the stack.
> +	 */
> +	if (!skb_mac_header_was_set(skb))
> +		skb_reset_mac_header(skb);

[Severity: Medium]
Should this also call skb_reset_mac_len()?

As far as I can tell, skb->mac_len still holds the outer frame's L2
length at this point. On Ethernet ingress, __netif_receive_skb_core() set
it to ETH_HLEN for the outer SRv6 packet. decap_and_validate() only
resets the network and transport headers:

    skb_reset_network_header(skb);
    skb_reset_transport_header(skb);

On the VRF side, mac_len is only fixed in vrf_prepare_mac_header(), which
always does both resets together:

drivers/net/vrf.c:vrf_prepare_mac_header() {
    ...
	skb_reset_mac_header(skb);
	skb_reset_mac_len(skb);
    ...
}

That helper only runs when a sniffer is attached to the VRF
(!list_empty(&vrf_dev->ptype_all)). It is also skipped on the IPv4
multicast, PACKET_LOOPBACK and IPv6 strict/link-local paths.

Without a sniffer, the packet leaves end_dt_vrf_rcv() with mac_header
equal to network_header but mac_len still 14. It then goes through
ip_route_input() / ip6_route_input() and dst_input(). It never passes
through __netif_receive_skb_core() again, so mac_len is never recomputed.

skb_mac_header_was_set() now returns true, so helpers that rebuild an L2
header from mac_len use the stale value. For example, in
xfrm4_remove_tunnel_encap() and xfrm6_remove_tunnel_encap():

	skb_reset_network_header(skb);
	skb_mac_header_rebuild(skb);
	if (skb->mac_len)
		eth_hdr(skb)->h_proto = skb->protocol;

Would this copy 14 bytes of the ESP packet's outer IP header into a fake
Ethernet header and then write h_proto into it? The skb is then
re-injected via gro_cells/netif_rx, where GRO and taps can see that
header. The BEET and iptfs rebuild paths look similar.

Also, seg6_do_srh() used to reject these skbs for L2ENCAP and
L2ENCAP_RED:

	case SEG6_IPTUN_MODE_L2ENCAP:
	case SEG6_IPTUN_MODE_L2ENCAP_RED:
		if (!skb_mac_header_was_set(skb))
			return -EINVAL;

		if (pskb_expand_head(skb, skb->mac_len, 0, GFP_ATOMIC) < 0)
			return -ENOMEM;

		skb_mac_header_rebuild(skb);
		skb_push(skb, skb->mac_len);

That check now passes. Would 14 bytes of the inner IP header then be
pushed as the destination MAC, source MAC and ethertype, and the result
encapsulated and transmitted? The __seg6_do_srh_encap() and inline encap
paths look like they build a fake L2 header in the headroom the same way.

I didn't find an out-of-bounds access from this, because the stripped
outer headers leave enough headroom. Before this patch, the xfrm path
wrote h_proto at head + 0xffff + 12, so the patch does remove that write.

The UDP GSO crash from the changelog is also fixed, because
__skb_gso_segment() resets both mac_header and mac_len before calling
skb_mac_gso_segment().

The new comment doesn't seem to hold, and neither does this part of the
commit message:

    when no rebuild happened, the packet now carries the
    same mac header state as any packet received on an L3 device.

A packet received on an L3 device has mac_len == 0. Would doing both
resets, the way vrf_prepare_mac_header() does, make the code match the
description?

	if (!skb_mac_header_was_set(skb)) {
		skb_reset_mac_header(skb);
		skb_reset_mac_len(skb);
	}

> +
>  	/* when a packet is received by a VRF or by one of its slaves, the
>  	 * master device reference is set into the skb.
>  	 */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017120144.3059-1-yymhvert%40gmail.com
