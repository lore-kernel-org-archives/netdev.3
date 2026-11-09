Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267065;
	b=UW0pr3TSZOibVJ9RvDr5CQS1Kak/suEzuUrgGhNVLHzTYnpzziuyu7q1MSM/MnOPSajT
	 lWPfehm0OAhBw3rpen8Pz5QuTGjPwnYEjkpJxW1JjICLmsqm+uMZQZ8CG0lArTyi6szh1
	 Ho4aMjqDKHBcIQt3WeMKcaP7kLl7zKfG6u3zxNFJ/welmLD80VY72m1kdc3WvDQEibApX
	 7JyRwgcVKt+Klya+8z7hesgnDdxbNhIjg/9r0TVu/sM34NKla4eb+/sWRLNb7mSvjZMX/
	 s+kCYINmwgGwuw/drUdYO8lpjVjy/W0x7LpYJfGqoMsZbZWf/AfFAzhseEXin7jSzSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267065;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Yp7+MFo6ivpVY8je3iQxlPFI1fVKcXYVEZ5Inw0sQnA=;
	b=pCDy40Nf5k5fLRwgwMJA2xbsMs0jCAJy9Fr7EJkSsKKoeEP4r0YlVgWFgz6dXPawuEbs
	 nIOdW44QnWBiBSfMYl0GI1fInZBuuO6MuK51h33B3jYzLtrlJ/09iar9hONgLqSnDFpvm
	 lEnDTfdumfMjqzeES8EvZ9rf/U2tOTcnK4uXGuxUyNZXewTkvJGA9eFmW20fkEqMSH4TS
	 2s7tGj79Kufete1ACzAUpdn50ihOGPoueESli4UPWlpC9OTlmN0a3kO7GWB/EFrIgOcYo
	 Ou9Wd73uRP23eOCxxOWo8EPpsZn1bTicFy/j/rKhji9qf/RRHl6oYsjKoWd1sJPKWwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K94AOvJ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C45606A330;
	Mon,  9 Nov 2026 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K94AOvJ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A06D1F008A2;
	Mon,  9 Nov 2026 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267064;
	bh=Yp7+MFo6ivpVY8je3iQxlPFI1fVKcXYVEZ5Inw0sQnA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K94AOvJ1+SDRBrVppqJqmiroNDOq/QVXXAE5voRhQ2kSajmyphEi21mH3X454nV3R
	 RL/Eua1oHEFGA4Gjn7gL4JIXKsumOwuGOWOysuOo/6DPMB2G9BZVYh9FyRUKCWl4Gs
	 3IkxNgBBy8cEvlPQbpgLTWM9T4X5LVp4gKhrDMTTdU5+lZ34lVG0NLVPsvcKmy4hwd
	 dQf8+lVkZV2XdGpXeg5/Eg3+9a/WcY9xB1/gfWrUExoDNzHOoNNoP9xXHbDLs13OJb
	 U3P2Vf6FpneuhVTz6KyaUvR8A6LIpTHHqoGm16s5ApW1atlJJFWGTq9ALP+lPGON3r
	 FFd5pNTbF8pdw==
Subject: Re: [PATCH net-next 1/6] eth: mpnic: Tx checksum offload
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:31:03 +0000
Message-ID: <179426706384.994134.13046661968612847431@kernel.org>
In-Reply-To: <20261106-mpnic-lso-v1-1-e943ff1493e4@gmail.com>
References: <20261106-mpnic-lso-v1-1-e943ff1493e4@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] mpnic_tx_offloads()
  (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c) increments…
- [Low] The new mpnic_features_check() calls skb_mac_header_len(skb) for
  every CHECKSUM_PARTIAL skb without checking that a MAC header has been…

--

eth: mpnic: Tx checksum offload

This commit adds generic Tx checksum offload (NETIF_F_HW_CSUM) to the
mpnic driver. It also adds an ndo_features_check callback that checks
the skb header lengths and checksum offset fit into the Tx descriptor
fields and the 256 byte header limit. CSO frames are counted and
reported through the netdev qstats API.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 93abdec44642f..edb087b12a1e2 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> +static void
> +mpnic_tx_offloads(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
> +{
> +	struct mpnic_tx_hdrs hdrs = {};
> +
> +	if (skb->ip_summed != CHECKSUM_PARTIAL)
> +		return;
> +
> +	mpnic_tx_fill_hdrs(skb, &hdrs);
> +
> +	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_CSUM_OFFSET,
> +					skb->csum_offset / 2) |
> +			     MPNIC_TWD_FLAG_REQ_CSO);
> +
> +	u64_stats_update_begin(&ring->stats.syncp);
> +	u64_stats_inc(&ring->stats.twq.csum_partial);
> +	u64_stats_update_end(&ring->stats.syncp);

[ ... ]

> @@ -230,6 +263,8 @@ static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
>  	MPNIC_XMIT_CB(skb)->bytecount = skb->len;
>  	MPNIC_XMIT_CB(skb)->desc_count = 0;
>  
> +	mpnic_tx_offloads(ring, skb, meta);
> +
>  	if (mpnic_tx_map(ring, skb, meta))
>  		goto err_free;
>  

[Severity: Low]
By this point mpnic_tx_offloads() has already incremented
twq.csum_partial. mpnic_tx_map() can then fail if skb_headlen() or a
frag size is above FIELD_MAX(MPNIC_TWD_LEN), or on dma_mapping_error().
In that case the err_free path frees the skb and counts it as dropped:

err_free:
	dev_kfree_skb_any(skb);
	ring->tx_buf[tail] = NULL;
	ring->tail = tail;
err_drop:
	...
	u64_stats_inc(&ring->stats.twq.dropped);

Does the csum_partial increment stay in place for a frame that was
never sent?

mpnic_get_queue_stats_tx() reports this counter as needs_csum, and
mpnic_aggregate_ring_twq_counters() adds it into base->tx.csum_partial.
So dropped frames would also be counted as checksum offloaded frames.

Could the counter be bumped only after mpnic_tx_map() succeeds?

The same ordering is still there at the end of the series (in "eth:
mpnic: add GSO_PARTIAL for other tunnels"). There, mpnic_tx_lso() also
increments hw_gso and hw_gso_wire before mpnic_tx_map() runs.

> @@ -256,6 +291,30 @@ netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
>  	return mpnic_xmit_frame_ring(skb, mpn->tx[skb_get_queue_mapping(skb)]);
>  }
>  
> +netdev_features_t mpnic_features_check(struct sk_buff *skb,
> +				       struct net_device *dev,
> +				       netdev_features_t features)
> +{
> +	unsigned int l2len, i3len;
> +
> +	if (skb->ip_summed != CHECKSUM_PARTIAL)
> +		return features;
> +
> +	l2len = skb_mac_header_len(skb);

[Severity: Low]
Can this run before the MAC header has been set? skb_mac_header_len()
starts with:

	DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));

ndo_features_check is called via netif_skb_features(). The IP GSO slow
paths call that before the L2 header exists, and before
__dev_queue_xmit() calls skb_reset_mac_header():

ip_finish_output_gso()
  netif_skb_features()
    mpnic_features_check()
      skb_mac_header_len()

ip6_finish_output_gso_slowpath_drop() does the same on the IPv6 side.

At that point a locally generated TCP or UDP GSO skb is
CHECKSUM_PARTIAL, and its mac_header is still ~0 from allocation. TCP
builds software GSO skbs even without NETIF_F_TSO, because
sk_setup_caps() adds NETIF_F_GSO_SOFTWARE. So this path can be hit,
for example, when the PMTU drops after the MSS was chosen.

With CONFIG_DEBUG_NET the warning fires. Without it, l2len becomes
network_header - 0xffff as an unsigned int, which fails FIELD_FIT().
The CSUM and GSO features are then masked and segmentation falls back
to software checksums, so the traffic itself stays correct.

Would skb_network_offset() avoid depending on mac_header here? At
ndo_start_xmit time skb->data points at the L2 header, and the slow
path only needs a conservative answer.

fbnic_features_check() in drivers/net/ethernet/meta/fbnic has the same
pattern. This code is also unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-mpnic-lso-v1-0-e943ff1493e4%40gmail.com
