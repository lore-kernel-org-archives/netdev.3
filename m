Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267068;
	b=i4u5i18VJuXULFtycSWIkGncjbIzkSeTLubmInQ5p1sVvyH46pWPdUT+pPi+DBX7A8AW
	 3oZpV3siyA7i33cXrCzmj9EiUfuGwXXM2qGiHk1RSpWDqP3yAZ16ERKvU+okSgk9jhgMs
	 7o3VBiwkWOnDCaX06p3IzUfG1QwkRydB60KDAMAzvnrmafAAqWgAqfGb4kfhixxF5N9qL
	 ZIenmPP2M+g71J1OWjLHqcjbhouh77o7FmwXzYK/o+kOYv5qhovVXmWye3FTkGrzM2xd7
	 Tc2t7ty38XgH+pI9U9+OdJVr3bTGPUsK0kV3G7CbowIwhbX5OxBfAmsNdeIY+QR1jig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267068;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qkbYvrF9rtrrYRmustWbe82oT7X90+wNssHyXMtmJjg=;
	b=FVK/LNEBThdywwPqVAVap/T3vqfyLW+hTyjr8qZ1aLQtRMo+DF40BaG18saK9+FX6H2R
	 6n66S4gMBrXzxZOmbSUXvIPzu+Fq5N6QuwfV8RBFkKZ9vFE0WI0y+c4nsASK1D4RA1HMV
	 ed68Gsp6O4QeL8PCzjHUmsbYzc71e1E6Rd+MGl6rMF31Yyvt4z0SG8PxVrSy1d14+jq68
	 XcPb5QXdkP6GnIx7z52sqyR5DcxNP0ZgukGXIcE9S3pnHEelsT7e36dxyOcRo2PFrQlqw
	 rOm1Q8kKIOECXCQzR8x9QybQcFKkOI/PP2TfnytqNnaIr9VDdvI5S46ctLoXJhwapDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngySx6AP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677A606A321;
	Mon,  9 Nov 2026 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngySx6AP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A81F008A1;
	Mon,  9 Nov 2026 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267067;
	bh=qkbYvrF9rtrrYRmustWbe82oT7X90+wNssHyXMtmJjg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ngySx6APuRS6wnK6gY/GLgYbt2sexRXWkBgC38LPyM0XyhK1CLyXA055syL1tgciF
	 Jwn3r1u0MwvsIHsQ3eWQ7QoIoGWEPzIQlFu68xP2Ic7wpXZ6x7TL0LJH/jF0hpBa9x
	 mNkN8oPxBRGdazmfbx6QXjpDbBoxYIlyMAMH9yAWdVud3IcTVxpwJwbIWj4PvIqfbs
	 y1uOYUQWRidSlgIW0tTQl1d8I946Fr+iKcibdVx6lycO43kU2ixTWMXDfhgW6Bm+rE
	 EAanx4DXQuex/t7Q64ZYWDtDjL84Ja1gQnm6E4nsA57S+HyOi/3OtWwT3CufCbHoM7
	 smns+W/pMqBMw==
Subject: Re: [PATCH net-next 3/6] eth: mpnic: TCP segmentation offload
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:31:06 +0000
Message-ID: <179426706639.994134.3147617580581432736@kernel.org>
In-Reply-To: <20261106-mpnic-lso-v1-3-e943ff1493e4@gmail.com>
References: <20261106-mpnic-lso-v1-3-e943ff1493e4@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mpnic_tx_lso() writes skb_shinfo(skb)->gso_size straight into
  the 14-bit MPNIC_TWD_MSS descriptor field with MPNIC_TWD_FLAG_REQ_LSO…
- [Medium] mpnic_xmit_frame_ring() pads every frame to 60 bytes in
  software (`skb_put_padto(skb, MPNIC_MIN_FRAME_LEN)`, line 307).
- [Low] The two places that feed the per-ring `twq.dropped` counter now
  count in different units.
- [Low] mpnic_tx_lso() bumps the new qstats counters `twq.hw_gso` and
  `twq.hw_gso_wire` (mpnic_txrx.c lines 259-260) before the frame is…

--

eth: mpnic: TCP segmentation offload

This adds hardware segmentation for non-encapsulated TCPv4/TCPv6 packets.
The TCP checksum is seeded with zero length, and the TOF block is set up
for incrementing IPv4 IDs and for clearing TCP flags per segment. GSO super
and wire packets are counted and reported through the netdev qstats API.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 680625810ec03..e2e6ab6d3c591 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -215,30 +218,82 @@ mpnic_tx_map(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)

[ ... ]

> +static bool
> +mpnic_tx_lso(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
> +{

[ ... ]

> +	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_L4_HLEN, l4len / 4) |
> +			     FIELD_PREP(MPNIC_TWD_MSS, shinfo->gso_size) |
> +			     MPNIC_TWD_FLAG_REQ_LSO);

[Severity: Medium]
Can the device send runt frames for the last segment here?

mpnic_xmit_frame_ring() pads every frame in software:

	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
		goto err_drop;

That suggests the TX path needs at least 60 bytes from the driver. For a
TSO skb the padding does nothing, because the super-packet is always longer
than 60 bytes, and the device builds each segment itself.

The last segment carries (skb->len - hdrlen) % gso_size bytes of payload.
For IPv4 TCP without options (54 bytes of headers) and a remainder of 1 to
5 bytes, that is a 55 to 59 byte frame. A TCP_NODELAY sender with
timestamps disabled can produce this, for example 1449 bytes at MSS 1448.

Neither mpnic_features_check() nor mpnic_tx_lso() guards against this.
mpnic_txglb_init() also doesn't configure any MAC or TOF auto-pad.

Does the segmentation engine pad the segments it generates to the Ethernet
minimum? If it doesn't, the link partner would drop those tail segments.
This also looks unchanged at the end of the series.

> +
> +	hdrlen = skb_checksum_start_offset(skb) + l4len;
> +	MPNIC_XMIT_CB(skb)->bytecount += (shinfo->gso_segs - 1) * hdrlen;
> +	MPNIC_XMIT_CB(skb)->gso_segs = shinfo->gso_segs;
> +
> +	u64_stats_update_begin(&ring->stats.syncp);
> +	u64_stats_inc(&ring->stats.twq.hw_gso);
> +	u64_stats_add(&ring->stats.twq.hw_gso_wire, shinfo->gso_segs);
> +	u64_stats_update_end(&ring->stats.syncp);

[Severity: Low]
Should hw_gso and hw_gso_wire be incremented only after the frame has
actually been handed to the device?

mpnic_tx_lso() is called from mpnic_tx_offloads(), which runs before
mpnic_tx_map() in mpnic_xmit_frame_ring():

	if (mpnic_tx_offloads(ring, skb, meta))
		goto err_free;

	if (mpnic_tx_map(ring, skb, meta))
		goto err_free;

Say mpnic_tx_map() then fails, either on a DMA mapping error or on a
fragment larger than MPNIC_TWD_LEN. The skb is freed and counted as
dropped, but hw_gso and hw_gso_wire are not rolled back. The same happens
to queued TSO skbs that mpnic_clean_twq0() discards with discard set.

mpnic_get_queue_stats_tx() and mpnic_get_base_stats() export these as
tx-hw-gso-packets and tx-hw-gso-wire-packets. They also add hw_gso_wire
into tx-needs-csum.

netdev.yaml defines these counters as packets the device segmented and the
wire packets it generated. On these paths the reported values include
super-packets the device never segmented. The existing csum_partial
counter has the same count-at-enqueue pattern.

[ ... ]

> @@ -312,6 +369,10 @@ netdev_features_t mpnic_features_check(struct sk_buff *skb,
>  	    l2len + i3len + sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE > 256)
>  		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>  
> +	if (skb_is_gso(skb) &&
> +	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
> +		return features & ~NETIF_F_GSO_MASK;

[Severity: Medium]
Is the 14-bit field width the only limit the hardware puts on gso_size?

This check only rejects gso_size > 16383. There is no minimum MSS, and
nothing compares gso_size plus the header length against the largest frame
the device supports (MPNIC_MAX_JUMBO_FRAME_SIZE, 9742).

gso_size can come from an untrusted sender:

- virtio_net_hdr_to_skb() is used by tun, tap, macvtap and packet sockets
  with vnet headers. It only raises a small TCP gso_size to
  TCP_MIN_GSO_SIZE, which is 8, and marks the skb SKB_GSO_DODGY.
- mpnic doesn't advertise NETIF_F_GSO_ROBUST, so tcp_gso_segment() only
  recomputes gso_segs and passes the original skb to the driver.
- On bridged paths, is_skb_forwardable() skips the MTU check for GSO skbs.

So a guest or tap user could make mpnic_tx_lso() program MPNIC_TWD_MSS in
two problem ranges:

- 8, which means thousands of segments per 64KB descriptor.
- Roughly 9.7K to 16383, which asks for frames larger than the device
  supports.

How does the device handle either case?

Drivers such as i40e and ice clear NETIF_F_GSO_MASK in ndo_features_check
when the MSS is too small. Would a similar lower bound make sense here,
along with an upper bound tied to the maximum frame size? This also looks
unchanged at the end of the series.

>  	return features;
>  }
>  
> @@ -357,7 +418,7 @@ static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
>  		}
>  
>  		total_bytes += MPNIC_XMIT_CB(skb)->bytecount;
> -		total_packets++;
> +		total_packets += MPNIC_XMIT_CB(skb)->gso_segs;

[Severity: Low]
Does this leave twq.dropped counting in two different units?

When mpnic_clean_twq0() runs with discard set, total_packets now adds wire
segments to the drop counter:

	if (discard) {
		...
		u64_stats_add(&ring->stats.twq.dropped, total_packets);

The error path in mpnic_xmit_frame_ring() still counts one per skb:

err_drop:
	...
	u64_stats_inc(&ring->stats.twq.dropped);

TSO skbs also reach that path when the new skb_cow_head() in
mpnic_tx_lso() fails, or when mpnic_tx_map() fails.

Both counts reach rtnl_link_stats64.tx_dropped through mpnic_get_stats64()
and mpnic_aggregate_ring_twq_counters(). A dropped TSO super-packet
therefore counts as gso_segs or as 1, depending on where it was dropped.
Before this patch both sites counted skbs. This also looks unchanged at the
end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-mpnic-lso-v1-0-e943ff1493e4%40gmail.com
