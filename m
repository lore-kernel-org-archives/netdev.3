Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478137;
	b=H8t/me2noAbWRaJzsJ9sl0FbV7Gf+3TNhrbVV8QQp1JvFpbXt8Y5b2YUm8kDEXhoVgY5
	 imzdNcbNmu1E8VN3SRKX/P9++yBrOZnHJpfasK0DO4hl+3Yjqcl7Xkqh3gam2t54uPorw
	 5TyrGnwB9kLCQKaKjb1mf417HNLcNujtm7GiLBzmngkSVCOmHT+P3flJrpqnO0jyS82Ye
	 GQPfuZMTdkieaquynvTh3l3k2i5W7PotdmANe0GKq6VHq8iyknZkiYVoIpomqoFsCAlFq
	 YC4ZAhSguQWqtOGuthwO7j0Jv2BMkgNQeIQziuPTknkN8Jt9nxx4jD70Afenzqz4vDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478137;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9MoWrZ01MvLCswjQtum5NRuL88rMY2EPIT05IIXNVrc=;
	b=NDEQmQ+/hQ71Uty5RghZ9JXRC//pfSNX+cCrpxAeLXk+u1J1h8cvwJuHCNX3DhXdJt6I
	 reu9NXM832Vt3WPH3DaCAHtI1PkJzJGeHPAA9NL7w8KAIInoGEaHlNLozLUDKRSrlQ+BS
	 NTd9f+I99/dmZUPddf7JfyxfdVw+jDKuOZ1hLf+yGVjNbywRk7ocyajWjapScOOFgHHHU
	 QkPOLMbSxAKB0ziFgZy8mMhHLBjUd5j+Hx09/HEJKevDoP4cnTRAxnOICvfXokpikAv3m
	 f4Fgu5D98uvQlP06VxicvbyV6S63yl/VBJwhgucA/eh9ts+EUkF21c4jUuUMsjWKbLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiXMBpMe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C398606A882;
	Thu, 12 Nov 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiXMBpMe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B3E1F00A05;
	Thu, 12 Nov 2026 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478136;
	bh=9MoWrZ01MvLCswjQtum5NRuL88rMY2EPIT05IIXNVrc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JiXMBpMe2wqNhjeXUiKa970NELVDjpwvX5CkTomGVwYPGY9fK71lvzwLcDpmebLgj
	 eAkSrgLk9ui8a4wL4SYWitHFs+nxWR69Z7JCNVdcHV0SUwB/sc3YSVnUGdaB1Iz/M1
	 xtaJ6VWtOeDuaAo/azRqY1q253OPVysF1QhQMc3RZIqb8vuMh4gpKoJ0M3B3oHa3eB
	 ZTD18iTagKGOC9+8mVzppDTXXFkd86oQsE8cSb0Xp5GfXwDAij8g58P/Rc+0y3tbkm
	 G0bZPeymp12LQffluz8cu9r/7Q2Hocbc3OnkpL/8nAgoS2xeKNc6l8YXG3sCB4PiZK
	 WhMAG4ra6UiqQ==
Subject: Re: [PATCH net-next v2 3/6] eth: mpnic: TCP segmentation offload
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 10:08:55 +0000
Message-ID: <179447813579.2199510.17629296645152623901@kernel.org>
In-Reply-To: <20261110-mpnic-lso-v2-3-ccd37b051d08@gmail.com>
References: <20261110-mpnic-lso-v2-3-ccd37b051d08@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, mpnic_xmit_frame_ring()
  (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:306) calls…
- [Medium] eth: mpnic: GSO validation bypass in mpnic_features_check()

--

eth: mpnic: TCP segmentation offload

This adds hardware segmentation for non-encapsulated TCPv4/TCPv6 packets
to the mpnic driver. It also programs the TOF mode and TCP flag clear
registers, and reports hw_gso_wire_packets through the netdev qstats API.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index a35ce8998409d..b78f8599bbe8f 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -312,6 +368,10 @@ netdev_features_t mpnic_features_check(struct sk_buff *skb,
>  	    l2len + i3len + sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE > 256)
>  		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>  
> +	if (skb_is_gso(skb) &&
> +	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
> +		return features & ~NETIF_F_GSO_MASK;
> +
>  	return features;
>  }

[Severity: Medium]
Does this MSS check cover every GSO skb that reaches mpnic_tx_lso()?
Earlier in mpnic_features_check() there is an early return when
skb->ip_summed != CHECKSUM_PARTIAL. For those skbs, neither the header
geometry checks above nor the new gso_size check run, and NETIF_F_TSO
and NETIF_F_TSO6 stay set.

Those skbs can still end up offloaded. __virtio_net_hdr_to_skb()
accepts VIRTIO_NET_HDR_GSO_TCPV4/TCPV6 without
VIRTIO_NET_HDR_F_NEEDS_CSUM. So a tap or virtio guest, or a
PACKET_VNET_HDR sender, can hand us a GSO skb with CHECKSUM_NONE and
SKB_GSO_DODGY.

The path from there looks like this:

- validate_xmit_skb() sees netif_needs_gso() and calls
  skb_gso_segment().
- tcp4_gso_segment() or tcp6_gso_segment() seeds the pseudo-header
  checksum and switches ip_summed to CHECKSUM_PARTIAL.
- tcp_gso_segment() then returns NULL, because skb_gso_ok() is still
  true for the advertised features.

The original skb then goes to mpnic_xmit_frame() unsegmented, having
skipped every check in this function.

In mpnic_tx_lso(), shinfo->gso_size then goes into the 14-bit
MPNIC_TWD_MSS field unchecked. gso_features_check() only bounds
gso_segs and skb->len. A gso_size of 16384 with a total length under
64K therefore gets through, and FIELD_PREP() truncates it to an MSS
of 0.

The header lengths that mpnic_tx_offloads() writes into
MPNIC_TWD_L2_HLEN and MPNIC_TWD_L3_IHLEN are also unvalidated for
these skbs. The same goes for the even-length and 256 byte header
limits. Here the transport header was set by the flow dissector, not
by a trusted stack.

What does the hardware do with an MSS of 0, or with truncated header
lengths? At best it seems to put malformed segments on the wire.

I see two possible fixes, and I'm not sure which you'd prefer:

- Clear NETIF_F_GSO_MASK for GSO skbs that are not CHECKSUM_PARTIAL
  yet.
- Move the gso_size check above the early return, and validate the
  headers from skb_transport_header() in that case.

Either way, this patch is the one that turns TSO on, so the fix
probably belongs here.

[Severity: Medium]
Can a TCP GSO skb shorter than MPNIC_MIN_FRAME_LEN get to hardware LSO
here? The only GSO fallback in this check is for a gso_size that doesn't
fit MPNIC_TWD_MSS. Eth + IPv4 + TCP headers add up to 54 bytes, so a TCPv4
GSO skb can be 56 bytes long with gso_size 1 and gso_segs 2.

mpnic_xmit_frame_ring() pads every skb before the offloads are set up:

	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
		goto err_drop;

That puts the zero pad inside the buffer lengths that mpnic_tx_map()
programs. Will the LSO engine then segment the pad as TCP payload? That
would produce more wire segments than shinfo->gso_segs, carrying zero
bytes at sequence numbers past the real data.

The checksum seed also looks wrong for these skbs. mpnic_tx_lso() takes
the length out of the pseudo-header using the padded skb->len:

	payload_len = cpu_to_be16(skb->len - skb_checksum_start_offset(skb));
	csum_replace_by_diff(&tcph->check, (__force __wsum)payload_len);

The sender, or tcp4_gro_complete(), seeded tcph->check with the unpadded
L4 length. So the seed ends up off by the pad size. Won't every segment
the hardware generates then carry a bad TCP checksum?

One way to reach this is a remote peer sending back-to-back non-PSH
1-byte segments. A forwarding host GRO-merges them and sends them out an
mpnic port. tun/tap/virtio and PACKET_VNET_HDR sources can also build
such skbs.

Now that NETIF_F_TSO is advertised, these skbs reach the driver
unsegmented. Before this patch GSO was never offloaded, so the padding
did no harm.

The next patch in the series, "eth: mpnic: UDP segmentation offload",
adds skb->len < MPNIC_MIN_FRAME_LEN to this condition. Could that check
move into this patch, so this commit doesn't send bad segments on its own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-mpnic-lso-v2-0-ccd37b051d08%40gmail.com
