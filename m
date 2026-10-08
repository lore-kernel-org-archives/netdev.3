Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E813CC9EA
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488320; cv=none; b=RLzotzVkI+eD6lZBoceA9L9pKSgWNVMW1HM58iPSJHsZLFLA4mTdz4x0BOq9k6mJVpiALAySIB8edZZj8yzcarCf7KEFa2wpUThkok/1SOJgvTG5L0zEpypoCEUnpQr5m4B2nSZpOXJC+4QHL9E6SD/lREazjrzCNdh+F8ce63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488320; c=relaxed/simple;
	bh=JSegWhceC5zEbs7JwtymVlbfLeIUzgBl37l/+yW6jwk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G9oK4kHfdGkUxAmApkyKw7rswUfskRliqMBw6dEOqx4XLVMHQUaefUNwwlbdrhptdUde7oyRe1IifbduhzukUW0z3zkWJupofuzcIod6gdAggUyfU5uoJ21T23xPjn4sBYAM8L0ak9loaIgjRtQPfvuAXLQUB2THLsE3pbGsPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULlHbaeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULlHbaeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959F51F00893;
	Thu,  8 Oct 2026 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791488319;
	bh=hr5uCWkWqNn7NxLmlKAVhoxgcpQvmc92VW1DkbGsRtY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ULlHbaeoRWnN+AqxscMEhjT9paFSTIhioemOvd6O6qhtMigmTKetKUwxp753Y16AG
	 WcAXTFaq0WzQwLg6hy7dglwMMNlyjH39M1UawJRiWQ19n8OBdOakhDjPZrtLc2lTrr
	 tPkeZCHKFZ39XTfv32Um08Mql/Wkm3vEG1XTpiMZYBtxlycM76z/Y7la6j5RpCNhBX
	 aqwLVFrrBipBI/YyhUoYeigSg14TwIFirno+0r+bZnIlMDhhRSeCAvVCVHbmy9mSa3
	 MUiRAYkt8IcsfA5TBzWgrum4C9/2WjWfLZiL4gXbpDoiwTE0LFvraYNNNxkPnhMdFU
	 6StVaLTIqvLGg==
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to VLAN,
 IPv6 and IP options
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, mst@redhat.com, jasowangio@gmail.com,
 willemb@google.com, habte.yibelo@gmail.com
Date: Thu, 08 Oct 2026 19:38:38 +0000
Message-ID: <179148831819.434549.14553358529954439471@kernel.org>
In-Reply-To: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves the UDP-tunnel path, virtio_net_hdr_tnl_to_skb()
  in include/linux/virtio_net.h, with the same weakness it removes from…
- [High] virtio_net_hdr_thoff_valid() decides whether skb->data starts
  with an Ethernet header only from `skb->dev->type == ARPHRD_ETHER`…
- [Medium] On the non-ARPHRD_ETHER branch, virtio_net_hdr_thoff_valid()
  leaves proto = 0 and then guesses the L3 protocol from the version…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but UML's
  raw_verify_header() (arch/um/drivers/vector_transports.c:213) discards…

--

net: extend virtio_net_hdr csum_start checks to VLAN, IPv6 and IP options

This patch replaces the fixed nh_min_len check on csum_start in
__virtio_net_hdr_to_skb() with a new helper, virtio_net_hdr_thoff_valid().
On ARPHRD_ETHER devices the helper parses the Ethernet header and any VLAN
tags. On other devices it uses skb_network_offset(). It then checks the
transport offset against the IPv4 IHL and the IPv6 header length.

Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo@gmail.com/

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..6a30f58d9d65f 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -48,6 +48,52 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static inline bool virtio_net_hdr_thoff_valid(const struct sk_buff *skb,
> +					      unsigned int nh_min_len)
> +{

[ ... ]

> +	if (skb->dev->type == ARPHRD_ETHER) {
> +		if (unlikely(thoff < ETH_HLEN))
> +			return false;
> +		nhoff = ETH_HLEN;
> +		proto = eth_hdr(skb)->h_proto;
> +		if (eth_type_vlan(proto)) {
> +			proto = __vlan_get_protocol(skb, proto, &nhoff);
> +			if (!proto)
> +				return false;
> +		}
> +	} else {
> +		nhoff = skb_network_offset(skb);
> +	}

[Severity: High]
Does skb->dev->type reliably tell us what framing is at skb->data?

For tun, IFF_TUN/IFF_TAP decides the framing in tun_get_user(). TUNSETLINK
lets the fd owner set dev->type to any value while the device is down:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
	case TUNSETLINK:
    ...
			tun->dev->type = (int) arg;
    ...
}

That seems to allow two cases.

Case 1: an IFF_TAP device with dev->type != ARPHRD_ETHER. tun_get_user()
calls skb_set_network_header(skb, ETH_HLEN). skb->protocol is still 0,
because eth_type_trans() only runs after tun_vnet_hdr_tnl_to_skb().

The helper then takes the else branch with nhoff = 14 and does no VLAN
parsing. For an 802.1Q frame, data[14] is the TCI, and its top nibble is
the PCP/DEI bits chosen by the sender.

If that nibble is not 4 or 6, only thoff >= 34 is enforced. The real IPv4
header starts at offset 18 and can run to offset 78 with options. Doesn't
that leave the VLAN case open?

Case 2: an IFF_TUN device with dev->type == ARPHRD_ETHER. Here skb->data
starts at the L3 header (skb_reset_network_header()). The helper still
parses it as Ethernet, with nhoff = ETH_HLEN and h_proto taken from bytes
12-13 of the IP header, which is the source address.

A valid IPv4/TCP packet with csum_start = 20 now fails
thoff < nhoff + nh_min_len (20 < 34). An IPv6 packet with csum_start = 40
also fails (40 < 54). The old check accepted both. Is this a regression for
such setups?

Could the caller pass in the framing, instead of the helper relying on
dev->type?

> +
> +	if (unlikely(thoff < nhoff + nh_min_len))
> +		return false;
> +
> +	iph = (const void *)(skb->data + nhoff);
> +	if (!proto) {
> +		if (iph->version == 4)
> +			proto = htons(ETH_P_IP);
> +		else if (iph->version == 6)
> +			proto = htons(ETH_P_IPV6);
> +	}
> +
> +	if (proto == htons(ETH_P_IP) || skb->protocol == htons(ETH_P_IP)) {
> +		if (unlikely(iph->ihl < 5))
> +			return false;
> +		nh_min_len = max_t(u32, iph->ihl * 4, nh_min_len);
> +	}

[Severity: Medium]
Should the version nibble guess be skipped when skb->protocol already
names a non-IP protocol?

The commit message says:

  - For non-IP protocols, require only nhoff + nh_min_len. No in-tree
    non-IP protocol generates CHECKSUM_PARTIAL itself. They only carry it
    when encapsulating IP (e.g., MPLS), in which case csum_start lies
    beyond an inner IP header.

Take IFF_TUN without IFF_NO_PI and with pi.proto = ETH_P_MPLS_UC.
tun_get_user() calls skb_reset_network_header() and sets
skb->protocol = pi.proto. So nhoff = 0, and data[0] is the top byte of
the MPLS label.

For labels 0x40000-0x4FFFF, iph->version reads as 4 and iph->ihl reads as
label bits 15..12. ihl < 5 is rejected outright. ihl >= 7 requires
thoff >= 28, so a valid MPLS + IPv4/TCP packet with csum_start = 24 is
rejected.

For labels 0x60000-0x6FFFF, the version reads as 6 and nh_min_len becomes
40, so csum_start = 24 fails as well.

The old check accepted these packets. Should proto be guessed from the
version only when skb->protocol is 0, ETH_P_IP or ETH_P_IPV6?

[ ... ]

> @@ -104,7 +150,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  
>  		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
> -		if (skb_transport_offset(skb) < nh_min_len)
> +		if (!virtio_net_hdr_thoff_valid(skb, nh_min_len))
>  			return -EINVAL;

[Severity: High]
Does the UDP tunnel path get the same coverage? Before it calls into here,
virtio_net_hdr_tnl_to_skb() still checks its offsets only against fixed
lengths:

include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
    ...
	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);

	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
	outer_th = le16_to_cpu(vhdr->outer_th_offset);
	if (outer_th < outer_l3min ||
	    inner_nh < outer_th + sizeof(struct udphdr) ||
	    inner_th < inner_nh + inner_l3min)
		return -EINVAL;

	/* Let the basic parsing deal with plain GSO features. */
	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
				      hdr->gso_type & ~gso_tunnel_type);
    ...
	skb->transport_header = outer_th + skb_headroom(skb);
    ...
}

For tunnel packets, csum_start is inner_th. virtio_net_hdr_thoff_valid()
checks it only against the outer L2/L3 headers, so inner_th can still point
inside inner IPv4 options.

After that, skb->transport_header is overwritten with outer_th, which was
only checked against the fixed 34/54. Two examples:

  - an 802.1Q tagged outer frame, with outer IPv4 at bytes 18..38
  - an untagged outer IPv4 header with ihl = 15, at bytes 14..74

In both, outer_th = 34 passes and the outer transport header ends up
inside the outer IP header.

There are two ways to reach this:

  tun_get_user()->tun_vnet_hdr_tnl_to_skb()->virtio_net_hdr_tnl_to_skb()
  when vnet_hdr_sz >= TUN_VNET_TNL_SIZE

  virtnet_receive_done()->virtio_net_hdr_tnl_to_skb()
  when rx_tnl is negotiated

Should the tunnel path get the same VLAN and IP option handling? If not,
should the commit message say that this path is not covered?

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch.
raw_verify_header() in arch/um/drivers/vector_transports.c ignores the
return value of virtio_net_hdr_to_skb():

	skb_set_network_header(skb, ETH_HLEN);
	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
	return 0;

vector_legacy_rx() and vector_mmsg_rx() only drop the packet on a negative
return. So if skb_partial_csum_set() succeeds and
virtio_net_hdr_thoff_valid() then fails, the skb is still delivered. It
arrives as CHECKSUM_PARTIAL with a transport header inside L3.

The old nh_min_len check was ignored in the same way. The vnet header here
comes from the host kernel's packet socket, not from untrusted input.

Should raw_verify_header() pass the error up so the new check applies to
this caller?

>  
>  		nh_min_len = skb_transport_offset(skb);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007163819.3041710-1-willemdebruijn.kernel%40gmail.com
