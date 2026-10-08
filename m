Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94C480DEC;
	Thu,  8 Oct 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452415; cv=none; b=QYim1yrG0ijHOtqHefyEY3o7UEDzHRfaNI94SEu5xlCN6UDyhna91W/6Xwyukmc7yprsn5PsmbSYpipftCyk/y+KA+0WRWq3TKCZLnOJpKn8X6CCM4atA8fp3ppNsYS7X2VsRTrPOIdnaOT79uXCheSiwlbBig+PG5uOMzK0Yl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452415; c=relaxed/simple;
	bh=GCQojUv1DY4mrewi2t9AhowzpkOd6UZ3EXwLQFLuPRE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=muxzJj0mFHhtz0ATIcWSHU5HjwDkO2nC+OdSocGf5KrtEwxyzRM6Fmskhnx6RB+4fFsxD8cvKzaqcWJWarYDZOu7B8hI7XVPWNRc1dtnrilhPSXZ4N4qram6clM9puUu6AQ9fkWNVKmTcOGywnNSmrku2fhM7xbSHvCjf6WqXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIJEjOtA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIJEjOtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EBE1F000FF;
	Thu,  8 Oct 2026 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791452414;
	bh=+ik3PHp+piofcVAGeBneTQR00S8udk9xZ2pedCIUsM4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kIJEjOtA69ORbHzkECokuZMeYA0Tkh+gUCTPn6Y/IbaBh/l0+MiL3VuNoBwTeDDqh
	 SGnyW5WlT/khJei1M7GTpZHLJgQxb/kkRgxJbW8GsBuvUd0UqK1SWBKG6MMyit+sw3
	 ClO6ea4QsN9A/fblkH05vTcMywi4qB0T1d2bbgKP7cREjLPP78zG+xXqnfk1154iE+
	 C19ACR07CUZWYrd8ABbvfiN4Mf2imOo0P+ibUG1f7ZHWjsonHD2sk6gZjfvMKwzwjY
	 /rJszx14OpONBTVC4hS2VY7MfBihtJpg1y+dYm7fRr5MkG/FDgKfOPwdwTTxSXNgQ7
	 Gb6jTY9oLOf3g==
Subject: Re: [PATCH net-next v3 5/8] net: bcmgenet: derive the receive buffer
 length from the MTU
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Date: Thu, 08 Oct 2026 09:40:13 +0000
Message-ID: <179145241305.434549.6513642342117691943@kernel.org>
In-Reply-To: <20261007-nb-genet-mtu-nn-v2-v3-5-74a796c019ce@tipi-net.de>
References: <20261007-nb-genet-mtu-nn-v2-v3-5-74a796c019ce@tipi-net.de>
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

- [Medium] In bcmgenet_set_mtu_regs()
  (drivers/net/ethernet/broadcom/genet/bcmgenet.c), UMAC_MAX_FRAME_LEN…

--

net: bcmgenet: derive the receive buffer length from the MTU

This commit computes the RBUF packet ready threshold from the MTU and
derives the receive buffer length from it, replacing the fixed 2048 byte
RX_BUF_LENGTH. UMAC_MAX_FRAME_LEN and the TDMA flow period are now also
derived from the MTU, and the TBUF threshold is programmed at its maximum.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 83ffc4a2a2a72..4a4b0c46f8986 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2630,6 +2648,44 @@ static void bcmgenet_link_intr_enable(struct bcmgenet_priv *priv)

[ ... ]

> +/* Program the MTU dependent registers. Call with the MAC disabled. */
> +static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
> +{
> +	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
> +
> +	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN(mtu), UMAC_MAX_FRAME_LEN);

[Severity: Medium]

Will this drop standard size frames once the MTU is lowered?

Before this patch, UMAC_MAX_FRAME_LEN was always 1536. Now it is
ENET_MAX_FRAME_LEN(mtu), which is mtu + 36, and nothing keeps it from
going lower.

The commit message says:

  The MTU is still fixed at ETH_DATA_LEN

Only the upper bound is fixed, though. bcmgenet does not override
min_mtu, so ether_setup() still allows any MTU from 68 up to 1500:

net/ethernet/eth.c:ether_setup() {
    ...
	dev->min_mtu		= ETH_MIN_MTU;
	dev->max_mtu		= ETH_DATA_LEN;
    ...
}

This commit has no ndo_change_mtu, so __netif_set_mtu() only updates
dev->mtu. The next open or full resume then writes the smaller value:

init_umac()
  bcmgenet_set_mtu_regs(priv, priv->dev->mtu)
    bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN(mtu), UMAC_MAX_FRAME_LEN)

Take an MTU below about 1482, for example 1400 for a tunnel overlay, or
1280. Full size 1514/1518 byte frames from LAN peers would then be over
the MAC limit. They would get DMA_RX_LG and be dropped in
bcmgenet_desc_rx():

	if (dma_flag & DMA_RX_LG)
		u64_stats_inc(&stats->length_errors);
	...
	page_pool_put_full_page(ring->page_pool, rx_page,
				true);

Before this patch, the MAC accepted these frames whatever the MTU was.
Full size UDP, broadcast, multicast or forwarded traffic that used to be
received would now be lost.

This still happens at the end of the series. The later commit "net:
bcmgenet: allow the MTU to be changed" adds bcmgenet_change_mtu(), which
applies the smaller limit straight away on a running interface.

That later commit does fix two related cases here. One is the stale,
too-small limit left after raising the MTU on a running interface. The
other is the WoL fast resume mismatch between TDMA_FLOW_PERIOD and
UMAC_MAX_FRAME_LEN.

Would it work to program max(mtu, ETH_DATA_LEN) into UMAC_MAX_FRAME_LEN,
and to update the commit message to match?

> +
> +	/* GENET v1 maps other registers at these offsets */
> +	if (GENET_IS_V1(priv))
> +		return;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce%40tipi-net.de
