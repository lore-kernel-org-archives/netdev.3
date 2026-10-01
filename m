Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF655522688
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877130; cv=none; b=iYemMb8y2P4GOggRM9hTKIMPtQ4arb9nlMS27wf5WWbg03SbhKiaUBItYs0mkXa2Zl3n9H8gWR9zZ9LcmCT0TYGfNLPiynofk4Li+Xz8PkkhQN1U4BLjQYFC9OobpwdMAqGWyDLrKuioOCeO3pcPkZHOYA4OKLjxgJVZXqKPHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877130; c=relaxed/simple;
	bh=LdfKx1PeNI3yQqsUwxb4FpCO5WbcMU+A2E8daoPmSow=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l22n2RIarNvilEXil71/Rup8h+g9O5CKnMUChWNOtvuoyQbvGkM+8Ul6lYy04j8AIpcyY/mXBu6qqshvZQPwI5CNm9b9h+y/AYhF2eKVVRBtCuDXzB4BMJZDyDc4KTTyuImYJJ0n+c1wEaouph+/5O1rxOr0XLL5PAHdJRbkBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhEtMZPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhEtMZPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF701F000FF;
	Thu,  1 Oct 2026 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790877123;
	bh=c0n8hiMWdHPDoja+vR4Vf++YtPwach5g9ZwEevjKViA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mhEtMZPNosxMLN3v3V3aoubWqGa5XaI0BCukAuQ58tRDAGmv2IApDm2OrmjtaLw4/
	 iJqkrD/RHpDSD2BSG+ds927Tvfk7JgzvIv7/23QyWkkoT+j6tJw4K9IjJpNhkn8dcK
	 9/6EBn5TzmPHyp50Wked7hXBvGxvpoBrZXEpnGddjp2FAo1R7p7xWd7KcUMqq8IJQ8
	 YEzp8iECycV99UQvr8md8Fi8BLzw28SWvr7WBGfUH4sDdw7rZAcB2jQU77tL4JDc1E
	 oqFq3K1v79u281vaO5nW23v1hfafagNCYnpLqY3vodPckwBrzXHA/CVHNinfI6b5gM
	 isTaY0XdIO1jg==
Subject: Re: [PATCH v2 net 1/2] net: always dissect GSO packets in
 __virtio_net_hdr_to_skb()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, mst@redhat.com, netdev@vger.kernel.org
Date: Thu, 01 Oct 2026 17:52:02 +0000
Message-ID: <179087712222.434549.10051297010561024620@kernel.org>
In-Reply-To: <20260928144254.3361044-2-edumazet@kernel.org>
References: <20260928144254.3361044-2-edumazet@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] `__skb_flow_dissect()` sets `key_control->thoff = min_t(u16,
  nhoff, skb ?

Pre-existing issues:
- [Medium] In af_packet, `packet_parse_headers()` runs before
  `virtio_net_hdr_to_skb()` (`packet_snd()` lines 3130/3133;…
- [Low] In the UML vector driver, `prep_skb()` sets `skb->len` to the
  full receive-buffer capacity (`skb_put(result, vp->max_packet)`, plus…

--

net: always dissect GSO packets in __virtio_net_hdr_to_skb()

This patch drops the skb->network_header condition and the unvalidated
fallback in __virtio_net_hdr_to_skb(). Every GSO packet without
VIRTIO_NET_HDR_F_NEEDS_CSUM is now flow-dissected and gets a transport
header. The tun, virtio_net and UML vector callers now set skb->dev and
skb->network_header before the conversion, and the
virtio_net_hdr_match_proto() check now runs after dissection.

Closes: https://lore.kernel.org/netdev/20260927163117.746432-2-bestswngs@gmail.com/

> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index ddd127ee9678..e1fb2a76fdff 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -209,6 +209,7 @@ static int raw_verify_header(
>  	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
>  		return 1;
>  
> +	skb_set_network_header(skb, ETH_HLEN);
>  	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());

[Severity: Low]
This isn't a bug introduced by this patch, but raw_verify_header() now
takes the dissection path. At this point, isn't skb->len still the full
receive buffer capacity rather than the length actually received?

prep_skb() sizes the skb up front:

arch/um/drivers/vector_kern.c:prep_skb() {
    ...
	skb_put(result, vp->max_packet);
	result->data_len = len - vp->max_packet;
    ...
}

Both vector_legacy_rx() and vector_mmsg_rx() call verify_header() before
pskb_trim() cuts the skb down to the received length:

vector_legacy_rx()
    header_check = vp->verify_header(vp->header_rxbuffer, skb, vp);
    ...
    pskb_trim(skb, pkt_len - vp->rx_header_size);

So the dissection, pskb_may_pull() of thoff + thlen and
skb_set_transport_header() all work on stale buffer bytes past the
received length.

After the trim, can a short frame with a GSO vnet header end up with
transport_header and GSO metadata beyond skb->tail?

The reads stay inside the allocated linear head. Triggering this needs
the host peer to send a GSO vnet header for a frame shorter than its
headers. The verify-before-trim ordering predates this patch, and the
old fallback also set gso_size/gso_type from the untrimmed length.

>  	return 0;
>  }

[ ... ]

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index c381b916c1b5..d6466f96cdd0 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -111,48 +111,38 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		p_off = nh_min_len + thlen;
>  		if (!pskb_may_pull(skb, p_off))
>  			return -EINVAL;
> -	} else {
> +	} else if (gso_type) {
>  		/* gso packets without NEEDS_CSUM do not set transport_offset.
>  		 * probe and drop if does not match one of the above types.
>  		 */

[ ... ]

> +		struct flow_keys_basic keys;
> +
> +		if (!skb->protocol) {
> +			skb->protocol = dev_parse_header_protocol(skb);
> +			if (!skb->protocol)
> +				virtio_net_hdr_set_proto(skb, hdr);
> +		}
>  retry:

[ ... ]

> +		if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
> +						      NULL, 0, 0, 0,
> +						      0)) {
> +			/* UFO does not specify ipv4 or 6: try both */
> +			if (gso_type & SKB_GSO_UDP &&
> +			    skb->protocol == htons(ETH_P_IP)) {
> +				skb->protocol = htons(ETH_P_IPV6);
> +				goto retry;
>  			}
> +			return -EINVAL;
> +		}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The
commit message mentions VLAN-tagged frames, though. For af_packet VLAN
frames, does this dissector call get a protocol and a network offset
that describe different headers?

packet_snd() calls packet_parse_headers() before
virtio_net_hdr_to_skb(). tpacket_snd() does the same through
tpacket_fill_skb():

net/packet/af_packet.c:packet_parse_headers() {
    ...
	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
		skb_set_network_header(skb, depth);
}

For VLAN-tagged frames this moves network_header past the tags, but
skb->protocol stays ETH_P_8021Q or ETH_P_8021AD.

The call here passes data == NULL, so the dissector uses
proto = skb->protocol and nhoff = skb_network_offset(skb). It then
reads the inner L3 header as a vlan_hdr:

net/core/flow_dissector.c:__skb_flow_dissect() {
    ...
		proto = vlan->h_vlan_encapsulated_proto;
    ...
}

That value would come from the IPv4 tot_len field or the IPv6 payload
length bytes. Would VLAN GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM
sent through AF_PACKET with PACKET_VNET_HDR then fail with -EINVAL? And
could they be misparsed if those bytes happen to form a valid ethertype?

tap_get_user() keeps network_header at ETH_HLEN while it calls
tun_vnet_hdr_to_skb(), and only moves it for VLAN afterwards. That is
the layout this helper expects.

The af_packet network header adjustment comes from commit dfed913e8b55a
("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO"). These
skbs already hit the same dissector call before this patch.

>  
> -			p_off = keys.control.thoff + thlen;
> -			if (!pskb_may_pull(skb, p_off) ||
> -			    keys.basic.ip_proto != ip_proto)
> -				return -EINVAL;
> +		p_off = keys.control.thoff + thlen;
> +		if (!pskb_may_pull(skb, p_off) ||
> +		    keys.basic.ip_proto != ip_proto ||
> +		    !virtio_net_hdr_match_proto(keys.basic.n_proto,
> +						hdr_gso_type))
> +			return -EINVAL;
>  
> -			skb_set_transport_header(skb, keys.control.thoff);
> -		} else if (gso_type) {
> -			p_off = nh_min_len + thlen;
> -			if (!pskb_may_pull(skb, p_off))
> -				return -EINVAL;
> -		}
> +		skb_set_transport_header(skb, keys.control.thoff);

[Severity: Medium]
Can keys.control.thoff be truncated here for large skbs?
__skb_flow_dissect() ends with:

net/core/flow_dissector.c:__skb_flow_dissect() {
    ...
out:
	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
    ...
}

min_t(u16, ...) casts skb->len to 16 bits. When skb->len is in
[65536, 65536 + nhoff), the result wraps to a small value.

With this patch, tun_get_user() calls tun_vnet_hdr_tnl_to_skb() before
eth_type_trans():

	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
	...
	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
		skb->protocol = eth_type_trans(skb, tun->dev);

So skb->len still includes the 14-byte Ethernet header during
dissection. Take an IFF_TAP frame with skb->len = 65540 and a plain
IPv4/TCP header (real nhoff of 34). That gives
thoff = (u16)65540 = 4.

ip_proto and n_proto are still correct, so every check above passes.
pskb_may_pull() pulls only 24 bytes, and skb_set_transport_header(skb, 4)
points into the destination MAC. The later skb_probe_transport_header()
in tun_get_user() does nothing, because the transport header is already
set.

Before this patch, tun got its transport header from
skb_probe_transport_header() after eth_type_trans() had pulled 14
bytes. Frames of 65536..65549 bytes were not affected.

This does not look like an out-of-bounds read, since
transport_header + 12 falls inside the pulled thoff + thlen bytes. But
would tcp_hdrlen() in skb_gso_transport_seglen() and
qdisc_pkt_len_init() then read the wrong bytes? That would give wrong
qdisc pkt_len and gso_segs accounting, and a wrong tbf MAC length check.

It also seems to contradict this part of the commit message:

    so all GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are
    flow-dissected, have their transport header pulled into linear
    data, and have skb->transport_header set.

In this case the real TCP header at offset 34..54 can stay in page
frags.

This is reachable through IFF_TAP with IFF_VNET_HDR, from a vhost-net
guest or an unprivileged tun owner in a user namespace. tun_alloc_skb()
allows skb->len well above 64K. tun_xdp_one() does not look affected,
since datasize is limited to one page.

>  	}
>  
>  	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928144254.3361044-1-edumazet%40kernel.org
