Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941668;
	b=MbyUJ/sgkcV1bY3xDVDpvTGBGv8rocQC8I2RxqyNxcRHM71mUJ0dSYqjaKWODd1Tux1a
	 0dOcC+pwvFG0MbFjdUN60usH31URI9ny6LV/eXS4T60lTMjrHJSXFUVjyY0DUJR7gPcFb
	 90Ie9cwC+KxpvfYFqiglf3HQrqmpVUmWC7g34TKrr2jGaq3cgO4SnT6ykj/4IytXkq4Gd
	 BJr012aqQhifGASrIiGoCZVPwphd6uYMGndSJHhHlq8hx0/YSulk4zEeWiNpaNcvEwJbj
	 UTlRAxumxQpGaGX32oj9FT2yLsnUczLezcc0MXwbRdFn501jHxSaNlY3e2SYPIASA3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941668;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=92s3Kw6ueFmGwEkQwkq3Wa12xqNg8I/1rNydhWYN50A=;
	b=4bB9H49BXkW2713c/pXuzADwyHJxWcYB9eU8ixKYprqT+ANhPVihwc2hRBYIM81V0pyv
	 UfzXHGC8N0ZHaoqDaXu1ZYGqtjz2ttmJfxL2s1yxrqzrEe7YoovW7jS7uZPgv9AhvrJoS
	 EhT6pM+4z1YY4Hvk5rO9y9IKyQmq0cZw0NKZKBdC6DgyGJvhWBKxUwXh1Xm3IZize/hYZ
	 B6stsTO22COkoWd7Xf5TEweNbf+F2WJVVWFXjnLZQC1y8XlqPGJTwZJdZ/XvNm4WlGEW6
	 3SpA8cGldRnzElCL+jOn3+NcafYtjT2llK/k82dZ3z39YwVBIiXjh1F3vB73tRv62Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dy2FI8KF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FC606A31B;
	Sun, 25 Oct 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dy2FI8KF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4167C1F01828;
	Sun, 25 Oct 2026 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792941668;
	bh=92s3Kw6ueFmGwEkQwkq3Wa12xqNg8I/1rNydhWYN50A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dy2FI8KFsPIQpboMwX6NVHHojuZMSYfPLsA+R0GWhdrWhbHWfgxgmzq7UxSBBPFvU
	 p+84EHeiziexnVTESwp6eoSyfut6xN9IYa0jrnZRckLpB0lEeBb/8ymFnVFDaqSWWZ
	 KgGAkDx0NQTIY0DIzlvLF67u0AtS202VNxkLZj7ts2VQoF7N6vPe9NM2yVBh/gdvpJ
	 c3GP1QOYipLOt/InYL1J3BnvKqOEcasWDRVQJdiZZg5A5Lb7Xu5bLFXSblahEM+SCv
	 CMPC2sCxxh5Mq3xRD/FFoD0UijD0u+AkGmdcOMGrvJ1GKZu8D8cn6LdEpAw+bi6djM
	 z5eXq42ZU7Q/A==
Subject: Re: [PATCH v5 net 2/4] net: enetc: do not rely on mEMAC hardware
 frame padding
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 15:21:06 +0000
Message-ID: <179294166680.3134.335406141769701248@kernel.org>
In-Reply-To: <20261021145314.1435049-3-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-3-vladimir.oltean@nxp.com>
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

- [Medium] In enetc_start_xmit(), the new early exit `if
  (eth_skb_pad(skb)) return NETDEV_TX_OK;` runs after the…
- [Medium] enetc_tso_count_descs() now reserves tso_count_descs(skb) +
  gso_segs, i.e. 3*gso_segs + nr_frags, or 4*gso_segs + nr_frags with a…
- [Low] This patch leaves the XDP transmit paths unpadded.

--

net: enetc: do not rely on mEMAC hardware frame padding

This commit pads short frames to ETH_ZLEN in software on the enetc
transmit path, instead of relying on the mEMAC, because the padding the
LS1028A MAC inserts is sometimes not zero. Non-GSO skbs are padded with
eth_skb_pad(). Software TSO segments shorter than ETH_ZLEN get an extra
BD that points to a shared, zeroed DMA-coherent buffer, and the
worst-case TSO descriptor reservation grows by one BD per segment.

> To be defensive and not leak any sensitive information from the SoC,
> let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
> have to do anything.

[Severity: Low]
Does this cover the XDP transmit paths? enetc_xdp_tx() is reached from
XDP_TX in enetc_clean_rx_ring_xdp() and from enetc_xdp_xmit(). It still
uses the raw frame length and adds no padding:

	while (unlikely(!tmp_tx_swbd->is_eof)) {
		tmp_tx_swbd++;
		frm_len += tmp_tx_swbd->len;
	}

ENETC_PM0_CMD_TXP is still set in enetc_configure_port_mac(). That means
the mEMAC would still pad short XDP_TX and XDP_REDIRECT frames on LS1028A
after this commit.

The last patch in the series, "net: enetc: pad short XDP frames in
software", seems to fix this by appending a tx_pad BD in enetc_xdp_tx().
So this only affects the intermediate state of the series.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index ab4bfefda6c8f..f0f9ba94b4df6 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c

[ ... ]

> @@ -690,7 +706,8 @@ static int enetc_lso_count_descs(const struct sk_buff *skb)
>  
>  static int enetc_tso_count_descs(const struct sk_buff *skb)
>  {
> -	int count = tso_count_descs(skb);
> +	/* +gso_segs to cover one pad BD per segment */
> +	int count = tso_count_descs(skb) + skb_shinfo(skb)->gso_segs;

[Severity: Medium]
Can reserving a pad BD for every segment push the reservation past the
ring size for skbs that used to transmit fine?

Every segment only needs a pad BD when hdr_len + gso_size < ETH_ZLEN.
Otherwise at most the last, shorter segment needs one. With this change
the reservation becomes 3 * gso_segs + nr_frags, or 4 * gso_segs +
nr_frags with a VLAN tag.

The TX ring is fixed at ENETC_TX_RING_DEFAULT_SIZE (2048), so
enetc_bd_unused() returns at most 2047. The driver does not lower
gso_max_segs or tso_max_segs. A software TSO skb with more than about 677
segments (about 507 with VLAN) can now never fit. Before this patch the
limit was about 1015 segments (677 with VLAN).

For example, a TCP flow with an MSS of about 88 bytes and a 64KB GSO skb
has about 744 segments. enetc_start_xmit() then does this even on an
empty ring:

	if (enetc_bd_unused(tx_ring) < enetc_tso_count_descs(skb)) {
		netif_stop_subqueue(ndev, tx_ring->index);
		return NETDEV_TX_BUSY;
	}

enetc_clean_tx_ring() only wakes the queue after it completes a frame,
and the driver has no ndo_tx_timeout. Wouldn't the requeued skb then
block this TX queue until ifdown/ifup?

The same stall already happened above about 1015 segments; this change
lowers the threshold.

Could pad BDs be reserved only when padding can happen (gso_segs pad BDs
if hdr_len + gso_size < ETH_ZLEN, otherwise one)? Alternatively,
netif_set_tso_max_segs() could cap the segment count so the worst case
fits in the ring.

>  
>  	/* Each segment also needs an extension BD for VLAN insertion */
>  	if (skb_vlan_tag_present(skb))

[ ... ]

> @@ -1053,6 +1088,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  			enetc_unlock_mdio();
>  		}
>  	} else {
> +		if (eth_skb_pad(skb))
> +			return NETDEV_TX_OK;
> +

[Severity: Medium]
Can this early return leak the ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS bit?

For one-step PTP Sync skbs, enetc_start_xmit() has already taken the bit
by the time it gets here:

	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
					  &priv->flags)) {
			skb_queue_tail(&priv->tx_skbs, skb);
			return NETDEV_TX_OK;
		}
	}

An L2 PTP Sync is 14 + 44 = 58 bytes, so it now always goes through
eth_skb_pad(). If the skb is cloned or lacks tailroom, the call chain
eth_skb_pad()->skb_put_padto()->__skb_pad() calls
pskb_expand_head(GFP_ATOMIC). If that fails, the skb is freed and an
error is returned.

The bit is only released in enetc_tx_onestep_tstamp():

	clear_bit_unlock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS, &priv->flags);

That work is scheduled from enetc_clean_tx_ring() when the one-step skb
completes on the TX ring. A dropped skb never reaches the ring, so the
work never runs.

After that, wouldn't every later one-step Sync fail
test_and_set_bit_lock() and be added to priv->tx_skbs, with nothing left
to dequeue it? One-step PTP transmit would stop for good and tx_skbs
would grow without bound. The bit also survives ifdown/ifup, because
enetc_tx_onestep_tstamp_init() only reinitializes the work and the queue.

The worker hits the same path when it calls enetc_start_xmit() on a
dequeued skb. The existing drop_packet_err and NETDEV_TX_BUSY exits have
the same problem. So does the pskb_may_pull() drop added by the next
patch, "net: enetc: ensure head buffer has at least 16 octets".

Could the bit be released (and tx_skbs drained) on every exit that does
not post the skb to the ring? Or could the padding happen before the
bit-lock is taken?

>  		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
>  			if (unlikely(skb_linearize(skb)))
>  				goto drop_packet_err;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021145314.1435049-1-vladimir.oltean%40nxp.com
