Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267070;
	b=p7FuAnIH5PuVHSmQKbCibD/VjaO21T+W4aT/k26Sa6MXMyYOvyQqKCFFKfbJizKnRFhw
	 i4nbkWqnWDefQIzfaX9lMOtrbkfrRBibP68ulU1ohyO09wQ5G5tdLqkJc8Ehbe+M7zCpD
	 Bly5gnOBTszlbgS3J9RYNg67NkVQnYszYQKOdetdVpZO5Bw/IC9F6dJLpD+UteuxPsu8l
	 MZKOn3PKYjebiOxNS8RbhJfkGrCJJaaj9M6P48R4yE1dSo/bVEvsCnYVJjUzXqvIZc3rb
	 O5uzisCjIianoO8eRvKnRy5mj8iMCsuqneizxWVpA3NNpSH9ddaJcT64aksu27Q6nRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267070;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+991lt0Xh67bkBKdZggWry2WoOUAzRXUj/nfqoAatHc=;
	b=O0or+J6pXv73YDcYqXTot/ClDICD9HLlutG0Yy9NpnsoxSC4k7nQUO4UgAyowr4bsYrm
	 jeoofs/Ps/m/RshjklZGzRvAgFhMVm0g5gETWh1DOkdLyt34P+Ic8DYKy7LhKl2r/eQSg
	 U8PZSPBNHDWGDY7vsn2CscKITTUGQrSP3IeG0fii8vsTdN82HTjvxcKSC77OENIO/Yzbf
	 zKkYu41LbudhZHoNRXJhsuYUN4MJMtkCsS4PLpJ3vbri7djXD4FTG5elvrEs04lM0Hb0f
	 ypOJWY4fAO5xCBk787iMs1O5jgcOWsVWGXRAE/c5EC8VDJ/Ol5z6JXQDSeAPx9qUJPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFgUAw73;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE7606A335;
	Mon,  9 Nov 2026 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFgUAw73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C941F008A1;
	Mon,  9 Nov 2026 23:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267069;
	bh=+991lt0Xh67bkBKdZggWry2WoOUAzRXUj/nfqoAatHc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bFgUAw73VbNvJhTCBvvLsZRceoPHyECWs63U5UIrnZ/9EdESxATAnc1R9rNNzQUUc
	 2sXhYlr8ruEVce0UFzhfxlBBzYnwbH18wNu0L4on9tIqrZxkzLtImBhGFjXSbaNyjv
	 C918Jrn0wcsjMEkSj9i5jf5tsCTGzndKFog98lZBAZ2nHQ+iweLberCDrzOa4QNMtq
	 I9HxCeH6k0GeWcn4rh2ONZEbONfsOqCQSVVFnodhyvNQNUmxsIHjrPivXn6fbc/AdT
	 /nlIn0Itg2SMoLBZnv04Sx4KWDBW7nj4A6nv4uBLuTRWSXjmgvEA5RV+vYWTyj0XCz
	 Z+JHGFiRzPvlQ==
Subject: Re: [PATCH net-next 5/6] eth: mpnic: IPv4 and IPv6 in IPv6 tunnel
 segmentation
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:31:08 +0000
Message-ID: <179426706883.994134.14513321289855708811@kernel.org>
In-Reply-To: <20261106-mpnic-lso-v1-5-e943ff1493e4@gmail.com>
References: <20261106-mpnic-lso-v1-5-e943ff1493e4@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mpnic_ipxip6_gso_ok()
  (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c) never checks that the…
- [Medium] eth: mpnic: stale inner transport offset used in
  mpnic_tx_fill_hdrs()
- [Low] The commit message does not mention that this patch turns on
  hardware TX checksum offload for all encapsulated traffic.

--

eth: mpnic: IPv4 and IPv6 in IPv6 tunnel segmentation

This commit adds 4-in-6 and 6-in-6 TSO support to mpnic. It advertises
NETIF_F_GSO_IPXIP6, sets hw_enc_features, and fills the outer L3 header
length and the new V6V6/V6V4 L3 types in the TX descriptor. A new helper,
mpnic_features_check_encap_gso(), checks the outer IPv6 extension headers
before it allows hardware segmentation.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> index 83be45031a30b..e391ca6483e09 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c

[ ... ]

> @@ -336,6 +337,7 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
>  
>  	netdev->hw_features |= netdev->features;
>  	netdev->vlan_features |= netdev->features;
> +	netdev->hw_enc_features |= netdev->features;

[Severity: Low]
This line in mpnic_netdev_alloc() copies the whole feature set into
hw_enc_features, not only NETIF_F_GSO_IPXIP6. Was it meant to also turn on
NETIF_F_HW_CSUM, TSO, TSO6, TSO_ECN and GSO_UDP_L4 for all encapsulated
traffic?

Before this patch the driver did not set hw_enc_features. The only bits came
from register_netdevice():

    dev->hw_enc_features |= NETIF_F_SG | NETIF_F_GSO_PARTIAL;

netif_skb_features() masks encapsulated skbs with hw_enc_features. So until
now, CHECKSUM_PARTIAL tunnel packets were checksummed in software. That
covers VXLAN, GENEVE, GRE, IPIP/SIT, and the segments that software GSO
produces from them.

With this change those packets reach mpnic_tx_offloads() with
MPNIC_TWD_FLAG_REQ_CSO set. The non-GSO path in mpnic_tx_fill_hdrs() then
sets L3_IHLEN to cover everything from the outer IP header up to the inner
L4 header. Because TSO is now in hw_enc_features, register_netdevice() also
adds NETIF_F_TSO_MANGLEID there.

mpnic_features_check() still enforces the alignment and header length
limits, so this looks functionally ok. The commit message, though, only
describes 4-in-6 and 6-in-6 segmentation.

Could the commit message mention the tunnel checksum offload? If the wider
change isn't intended, could hw_enc_features be limited to the bits IPXIP6
needs?

>  
>  	netdev->min_mtu = IPV6_MIN_MTU;
>  	netdev->max_mtu = MPNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 9dd61b6d374c7..c349e54a35470 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -363,6 +376,32 @@ netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
>  	return mpnic_xmit_frame_ring(skb, mpn->tx[skb_get_queue_mapping(skb)]);
>  }
>  
> +static bool mpnic_ipxip6_gso_ok(struct sk_buff *skb)
> +{
> +	struct ipv6hdr *ip6h;
> +	__be16 frag_off;
> +	u8 nexthdr;
> +	int start;
> +
> +	ip6h = ipv6_hdr(skb);
> +	nexthdr = ip6h->nexthdr;
> +	start = skb_network_offset(skb) + sizeof(*ip6h);
> +	start = ipv6_skip_exthdr(skb, start, &nexthdr, &frag_off);

[Severity: Medium]
Should mpnic_ipxip6_gso_ok() check that ip6h->version == 6 before it
parses this header as IPv6?

A set SKB_GSO_IPXIP6 bit doesn't guarantee that the outermost header is
IPv6. iptunnel_handle_offloads() only resets the inner headers on the first
encapsulation, and it ORs in the gso_type bits.

Take a 4-in-6 ip6_tnl packet that is then sent over a sit tunnel. It ends
up with an outer IPv4 header and gso_type TCPV4 | IPXIP6 | IPXIP4.
inner_network_header still points at the innermost IPv4 header.

mpnic_tx_fill_hdrs() labels any encapsulated GSO skb as outer IPv6:

    hdrs->l3_type = inner_ip_hdr(skb)->version == 4 ?
            MPNIC_TWD_L3_TYPE_V6V4 : MPNIC_TWD_L3_TYPE_V6V6;

The fbnic gate this code appears to follow rejects this case in
fbnic_features_check_encap_gso():

    if (ip6_hdr->version != 6)
        return features & ~FBNIC_TUN_GSO_FEATURES;

With only this patch applied, the nested case still falls back to software
GSO, because IPXIP4 is not supported yet. The gate is still the same at the
end of the series, though.

After "eth: mpnic: add GSO_PARTIAL for other tunnels", a true return from
mpnic_ipxip6_gso_ok() makes mpnic_features_check_encap_gso() return early.
That skips the outer IPv4 check:

    if (iph->version == 4 && !(iph->frag_off & htons(IP_DF)))
        return features & ~NETIF_F_GSO_MASK;

It also skips the TSO_MANGLEID requirement.

With a sit tunnel using nopmtudisc, the outer DF bit is clear and byte 6 of
the IPv4 header is 0, which is read as NEXTHDR_HOP. ipv6_skip_exthdr() then
treats bytes of the middle IPv6 addresses as extension headers.

With addresses such as saddr[12..13] = 0x33,0x00 and daddr[4..5] =
0x04,0x01, the walk ends exactly at inner_network_offset with
nexthdr == IPPROTO_IPIP, and the gate passes.

Could that send every GSO_PARTIAL segment with the same outer IPv4 ID while
DF is clear? That is the case the later DF check is meant to prevent.

SKB_GSO_DODGY packets built by BPF (bpf_skb_adjust_room() with
BPF_F_ADJ_ROOM_ENCAP_L3_IPV6), or GRO packets with a bogus version nibble,
could also reach the device labelled V6V6/V6V4 when the outer version is
not 6. Software GSO doesn't check the version either, so the effect on the
hardware in that case is unclear.

Would a check like the one fbnic has be enough here?

    if (ip6h->version != 6)
        return false;

The inner version could optionally be checked against the nexthdr value
accepted here as well.

> +
> +	return !frag_off && start == skb_inner_network_offset(skb) &&
> +	       (nexthdr == IPPROTO_IPV6 || nexthdr == IPPROTO_IPIP);
> +}
> +
> +static netdev_features_t
> +mpnic_features_check_encap_gso(struct sk_buff *skb, netdev_features_t features)
> +{
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP6 &&
> +	    mpnic_ipxip6_gso_ok(skb))
> +		return features;
> +
> +	return features & ~NETIF_F_GSO_IPXIP6;
> +}

[ ... ]

> @@ -228,9 +232,17 @@ static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
>  	else
>  		hdrs->l4_type = MPNIC_TWD_L4_TYPE_UDP;
>  
> -	hdrs->i3len = skb_transport_offset(skb) - skb_network_offset(skb);
> -	hdrs->l3_type = ip_hdr(skb)->version == 4 ?
> -			MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
> +	if (!skb->encapsulation) {
> +		hdrs->i3len = skb_transport_offset(skb) - net_off;
> +		hdrs->l3_type = ip_hdr(skb)->version == 4 ?
> +				MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
> +	} else {
> +		inner_off = skb_inner_network_offset(skb);
> +		hdrs->o3len = inner_off - net_off;
> +		hdrs->i3len = skb_inner_transport_offset(skb) - inner_off;
> +		hdrs->l3_type = inner_ip_hdr(skb)->version == 4 ?
> +				MPNIC_TWD_L3_TYPE_V6V4 : MPNIC_TWD_L3_TYPE_V6V6;
> +	}
>  }
>  
>  static bool

[Severity: Medium]
Can skb_inner_transport_offset() be relied on here? In the
encapsulated GSO branch, mpnic_tx_fill_hdrs() takes the inner L3
length from inner_transport_header. The rest of the TX path finds the
L4 header through skb_checksum_start():

  - mpnic_features_check() validates i3len that way.
  - mpnic_tx_lso() seeds the L4 checksum at skb_checksum_start(skb).
  - mpnic_tx_lso() also reads the L4 header length from there.

If the two offsets differ, MPNIC_TWD_L3_IHLEN no longer agrees with
where the driver says the L4 header is.

They can differ. Take an IPv6 GSO packet with an inner extension
header, such as destination options or a routing header.
ip6_rcv_core() sets transport_header to network_header +
sizeof(struct ipv6hdr), which points at the first extension header
and not at TCP/UDP.

Suppose the packet is then encapsulated by one of these:

  - bpf_lwt_push_ip_encap()
  - bpf_skb_adjust_room()
  - seg6_do_srh()
  - the IPVS tunnel xmit
  - the nf_flow_table tunnel push

In each case inner_transport_header is copied from that unadvanced
transport_header.

validate_xmit_skb() only calls skb_set_inner_transport_header() with
skb_checksum_start_offset() when netif_needs_gso() is false.
SKB_GSO_DODGY can be set by virtio_net_hdr_to_skb(), and
bpf_lwt_push_ip_encap() and bpf_skb_net_grow() add it
unconditionally. Without NETIF_F_GSO_ROBUST, netif_needs_gso() is
then true and __skb_gso_segment() runs.

For a dodgy skb, ip6ip6_gso_segment() -> ipv6_gso_segment() ->
tcp_gso_segment() only validates the packet, updates gso_segs and
returns NULL segs. The inner ipv6_gso_segment() then jumps to out
before skb_reset_inner_headers(). So when mpnic_xmit_frame() gets
the skb, inner_transport_header still points at the inner extension
header.

In that case hdrs->i3len is short by the length of the inner
extension headers. The descriptor tells the device that L4 starts
somewhere other than where mpnic_tx_lso() seeded the pseudo-header
checksum. That would corrupt the hardware-segmented frames on the
wire, and a guest or a BPF program can trigger it.

Would it be better to compute this as
skb_checksum_start_offset(skb) - inner_off, which matches
mpnic_features_check(), mpnic_tx_lso() and fbnic_tx_lso()? The
GSO_PARTIAL branch added later in the series also uses
skb_inner_transport_offset() and may need the same change.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-mpnic-lso-v1-0-e943ff1493e4%40gmail.com
