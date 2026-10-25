Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941670;
	b=XwAeQAFTOntHNJUffguSw9FjBbjt922SsxY/HthDPclS3IF8i/YuSUrPzjkW8GqbxOtx
	 v+CC1Z8zP7tdv7pn7XOrK0r1J5/w9cAMT3lYlZn4U/MOh5fst0HyoETBlLYeCyBmVaKSR
	 GfNIZLUqiCf4Xm74br1jIHsHYc4hfDEFT4e40QbAfdu/SFofsChfEhQKnybdacqvz9Bwf
	 qyqu9+At4MzL8+wLyjjJEVhMHA/BtGv8doh1KMkhIP0U+qWY97aNe8Ob+R7vNWn9an2xj
	 gdwjmyR+qBD75yUQCuU/IS8oU2nL1AubHny4GwcE/lxiLuOiPNvO8iq9Nx2/oHumNOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941670;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Sx0LzuIkZ5ltt52i9FyvQMOhTGAeKY8kKDghXcovPYU=;
	b=AUravqiwk6H2d7yd723x+fNBlYntpE8tRc79Liv0iVjfZCqDKjeIG1fnXXeQFnqCmGih
	 awdmSS6+/mEDDihtZgJmAnXybu3VL/WFceebemEUL37POAy3m2/WoG7XbbLdRubRQAn7F
	 Yq/UuhW6d1bilgbmkarZXhBubiH97N1ZekKRw0r8Q4myBe7ODnFwemSvvkLPBaafGfPgS
	 2R9BxtgB6PbG0rVKayIUcN5BVi/DkSDMqX5QN26+BASvjz+yMW+ynmD8AH/wV1qKPUQ04
	 nU0i/zu1m9gvLREnEjFEvKlRVb+KzmFb7uTW/9lNiAoQkpkhPL6mRYcv1RoUN1Uh2IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QagvWmzO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7860A2606;
	Sun, 25 Oct 2026 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QagvWmzO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BD01F031E2;
	Sun, 25 Oct 2026 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792941669;
	bh=Sx0LzuIkZ5ltt52i9FyvQMOhTGAeKY8kKDghXcovPYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QagvWmzOKImpvs8gBLEHjFBZjIwc4NKMXcVod+hWtcPNJMyOXY4ZPCF3uRSUp2/UE
	 nd0b8IMxJcdkZcai1gx7CFDPt/70H6sY4ToOw3/LhIMB0TRHB5FDdGKLxA0VegvCLT
	 9xwP/l8vrmNVmqMoj82fjXGZiVULsC8FSgrbFYkesrEVrojQCoHNBKjSbYGyVX+ig5
	 P/JAoZpVFFnbLlHKuiYAhtjWAqo/eX6EXj9HkckgIy8c3rlkoRl1U9tCl1qY1WjrGn
	 WaVXgaFMI96VxQm0k9Oc8inXGEJerwVI+OJPEkGP+5RlnonqXzTJmHLtUZDGSFWCaP
	 JdewtMzsibcSw==
Subject:
 Re: [PATCH v5 net 3/4] net: enetc: ensure head buffer has at least 16 octets
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 15:21:08 +0000
Message-ID: <179294166830.3134.4811377231492994984@kernel.org>
In-Reply-To: <20261021145314.1435049-4-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-4-vladimir.oltean@nxp.com>
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

- [Low] At this commit, the 16-octet minimum for the head BUFF_LEN and
  for FRM_LEN is enforced only in the non-GSO skb branch of…
- [Low] The commit message says the pskb_may_pull() handling "is case 5
  below".

Pre-existing issues:
- [Medium] In enetc_start_xmit(), when an skb has
  ENETC_F_TX_ONESTEP_SYNC_TSTAMP set, the caller takes the…

--

net: enetc: ensure head buffer has at least 16 octets

On the non-GSO path, enetc_start_xmit() now uses pskb_may_pull() to move
bytes from the paged area into the head when the head buffer is shorter
than 16 octets. The ENETC does not accept a first TX BD with BUFF_LEN
below 16. Such a descriptor stalls the TX ring consumer index and leads
to an IRQ storm.

Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/

> Because the driver now pads linear skbs to ETH_ZLEN for other reasons
> too, we just need to ensure the head buffer has at least 16 bytes.
> This can be done using pskb_may_pull(), which moves that number of bytes
> from the paged area into the head. This is case 5 below.
>
>   skb_headlen (H) | skb->len (L) | linear? | handled by
>   ----------------+--------------+---------+---------------------------------------
>    H == L         | L < 60       |  yes    | eth_skb_pad() (pads head to 60)
>    H == L         | L >= 60      |  yes    | already valid, no-op
>    H < 16         | L < 60       |  no     | eth_skb_pad() (linearizes + pads to 60)
>    H < 16         | L >= 60      |  no     | pskb_may_pull() (pulls frags into head)
>    H >= 16        | L >= 60      |  no     | already valid, no-op

[Severity: Low]
This isn't a bug, but should "case 5" be "case 4"? The pskb_may_pull()
case (H < 16, L >= 60) is the fourth row. The fifth row (H >= 16,
L >= 60) is the no-op case.

The table also has no row for the non-linear H >= 16, L < 60 case.
eth_skb_pad() handles that one too, because
skb_put_padto()->__skb_pad() linearizes a non-linear skb before padding.

Could that row be added so the case analysis is complete?

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index f0f9ba94b4df6..f5a47d53d2bea 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1091,6 +1091,12 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  		if (eth_skb_pad(skb))
>  			return NETDEV_TX_OK;
>  
> +		if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
> +			     !pskb_may_pull(skb, ENETC_MIN_BUFF_SIZE))) {

[Severity: Low]
This covers the non-GSO skb path. Can the XDP transmit path still build
a first BD with BUFF_LEN < 16?

enetc_xdp_xmit()
  enetc_xdp_frame_to_xdp_tx_swbd()   <- head len is xdp_frame->len
  enetc_xdp_tx()
    enetc_xdp_map_tx_buff()

drivers/net/ethernet/freescale/enetc/enetc.c:enetc_xdp_map_tx_buff() {
    ...
	txbd->buf_len = cpu_to_le16(tx_swbd->len);
	txbd->frm_len = cpu_to_le16(frm_len);
    ...
}

Neither length is checked against ENETC_MIN_BUFF_SIZE at this commit.
Two kinds of frame could still produce the invalid BD:

  - a redirected frame that bpf_xdp_adjust_tail() shrank to ETH_HLEN
  - a multi-buffer xdp_frame with a 14-15 byte head

Either one looks like it could cause the TBaCIR stall and IRQ storm
described in the commit message.

The later patch in this series, "net: enetc: pad short XDP frames in
software", appears to close this. It makes enetc_xdp_tx() drop frames
whose first buffer is shorter than ENETC_MIN_BUFF_SIZE, and it adds a
pad BD so that FRM_LEN reaches ETH_ZLEN. enetc_xdp_xmit() and the XDP_TX
path both go through enetc_xdp_tx(), so the gap only exists at this
intermediate commit.

> +			dev_kfree_skb_any(skb);
> +			return NETDEV_TX_OK;
> +		}

[Severity: Medium]
This is a pre-existing issue that was not introduced by this patch, but
the new drop path inherits it. If the skb has
ENETC_F_TX_ONESTEP_SYNC_TSTAMP set, enetc_start_xmit() has already taken
the bit at the top of the function:

	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
					  &priv->flags)) {
			skb_queue_tail(&priv->tx_skbs, skb);
			return NETDEV_TX_OK;
		}
	}

If pskb_may_pull() fails here, the skb is freed. The bit is not cleared
and priv->tx_onestep_tstamp is not scheduled.

Only enetc_tx_onestep_tstamp() releases the bit. That work is scheduled
only from enetc_clean_tx_ring(), when a one-step skb completes in the TX
ring, and a dropped skb never gets there.

After such a drop, would every later one-step Sync skb stay in
priv->tx_skbs forever, with the queue growing without bound?

The existing drop_packet_err label already leaks the bit the same way.
It is reached on skb_linearize() failure, or when DMA mapping fails and
count is zero. A common drop path that releases the bit (or schedules
the work) for one-step skbs would fix both cases, separately from this
patch.

>  
>  		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
>  			if (unlikely(skb_linearize(skb)))
>  				goto drop_packet_err;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021145314.1435049-1-vladimir.oltean%40nxp.com
