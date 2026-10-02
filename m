Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A335E1B8;
	Fri,  2 Oct 2026 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921444; cv=none; b=COQlQgXQidB+c2ILtukW1mBmTLiiZlZbbje5ZQBR1XSCjicxvW3T3RvHv7SZDHaGXsuZDdxiZB5T+PjZCGlwwiV0EBCkFrpZCbYJSzgxdWrNEEENZ6VI3UBdY894Kst1YeRAxTIriXaE1unTpxMaQGftOasTkgaPVkZYaaeA9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921444; c=relaxed/simple;
	bh=BW7RQTsl2s+ZBFOqAr6zScpxVV5GuF9Dv41KF0SgrJU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ruOIP60I9viNuFqGb5SOWC3oCAdF+IJvwxEcn1v3fJ6h8YRcTphJnTWmWt/pGzpxnMVJbr7U1TZHc5X2WADNv+fWTUbA//jCi9WdUgmUMadGxaOCfsdDCuycKTWDfo8W+2zn06SjBiYKEZLe/Ay11qMY7ZBvU7cEGI0rblrA9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fpb7giCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fpb7giCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CEB1F000FF;
	Fri,  2 Oct 2026 06:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790921443;
	bh=A5lYYuLaIw5WEDi0faIU1nUW/WFfPzGQ5yADyJaFr0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fpb7giCOYZZUvMvovxnuMTNv70v4P+oqEQMdAlQEG3pLpnxwVRHTDxdj/4IIN5zHY
	 lxswPgA0gJZcVTchBonUAvJjqLLdoc3Jmm1t3BS7uEOIanTJDA71haLbXpMPy0bwMB
	 I+KjRYuJdYL0MXXJzC+7PkTi+IG+jC2CGf9odmNyTEDuyQQMDMvosU6lT3qndaXY4G
	 6jlCpldMRz/VlemI6NUO2Tl+2PTd2sjraOLxQZoJLzMwVatG5BTSNmcdhBJ9DX7OY5
	 vwdpuZDOoO05S4uL9ARsTXUMS5j0iBapuT/VDgSMHD/FhS46OiCTmCvQIAmsH2EMvV
	 2AzKjC7HPNW6A==
Subject: Re: [PATCH] net: stmmac: Disable checksum insertion for XDP frame TX
From: netdev-bot+sashiko@kernel.org
To: jszhang@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 06:10:41 +0000
Message-ID: <179092144172.434549.9814970691717018165@kernel.org>
In-Reply-To: <20260929121025.20821-1-jszhang@kernel.org>
References: <20260929121025.20821-1-jszhang@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes only one of the two stmmac XDP-family TX
  paths.
- [Medium] The patch changes user-visible behavior in a way the commit
  message does not mention.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  stmmac_xdp_xmit_xdpf() in…

--

net: stmmac: Disable checksum insertion for XDP frame TX

This commit stops stmmac_xdp_xmit_xdpf() from requesting hardware
checksum insertion for XDP_TX and ndo_xdp_xmit frames. It now passes
false as the csum argument to stmmac_prepare_tx_desc(), so these frames
go out with their checksum fields unchanged.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ec62fa7418f41..81c1a93c9d90d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5254,7 +5253,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
>  
>  	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
> -			       csum, priv->descriptor_mode, true, true,
> +			       false, priv->descriptor_mode, true, true,
>  			       xdpf->len);

[Severity: Medium]
Does the AF_XDP zero-copy TX path need the same change? It shares this
TX ring, and stmmac_xdp_xmit_zc() still sets csum based only on what the
queue supports:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_xdp_xmit_zc() {
    ...
	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
    ...
		stmmac_prepare_tx_desc(priv, tx_desc, 1, xdp_desc.len,
				       csum, priv->descriptor_mode, true, true,
				       xdp_desc.len);
    ...
}

When csum_flag is true, every descriptor backend turns on full checksum
insertion. That is TX_CIC_FULL for the dwmac4, enhanced and normal
descriptors, and XGMAC_TDES3_CIC = 0x3 for xgmac.

An XSK frame cannot ask for checksum offload, because
stmmac_xsk_tx_metadata_ops has no .tmo_request_checksum:

static const struct xsk_tx_metadata_ops stmmac_xsk_tx_metadata_ops = {
	.tmo_request_timestamp		= stmmac_xsk_request_timestamp,
	.tmo_fill_timestamp		= stmmac_xsk_fill_timestamp,
	.tmo_request_launch_time	= stmmac_xsk_request_launch_time,
};

For the same reason, netdev_nl_dev_fill() never reports
NETDEV_XSK_FLAGS_TX_CHECKSUM for stmmac. Yet on a queue that supports
checksum offload, the MAC still rewrites the IP and L4 checksums of every
AF_XDP zero-copy frame.

The commit message describes exactly this case: a frame with no TX
checksum offload request whose existing checksum gets overwritten.

Should stmmac_xdp_xmit_zc() also pass false? Another option is to
implement tmo_request_checksum, so insertion is enabled only for frames
that ask for it. Either change would probably need its own Fixes: tag
pointing at the XSK zero-copy TX commit.

[Severity: Medium]
Could frames that relied on the old behavior now go out with bad L4
checksums? With CIC=FULL the hardware computes the pseudo-header itself
and ignores the existing checksum field. That used to fix up redirected
frames whose L4 checksum held only the pseudo-header sum.

veth is one source of such frames. VETH_FEATURES includes
NETIF_F_HW_CSUM, so TCP/UDP traffic from the peer is CHECKSUM_PARTIAL.
veth_xdp_rcv_skb() then converts the skb to an xdp_buff without
completing the checksum:

veth_xdp_rcv_skb()
  XDP_REDIRECT -> xdp_do_redirect()
    stmmac_xdp_xmit()
      stmmac_xdp_xmit_xdpf()   /* csum is now always false */

After this patch those frames leave with only the partial checksum, and
receivers drop them.

The new behavior matches other XDP drivers, and the root cause is
arguably on the sending side. However, the commit message only says:

    so that the packet is sent with its checksum fields unchanged.

Could the message mention this trade-off? A concrete case where the old
behavior caused harm would also help maintainers and stable backporters
weigh the change.

>  
>  	tx_q->tx_count_frames++;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Can the
modulo just after this line divide by zero?

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_xdp_xmit_xdpf() {
    ...
	tx_q->tx_count_frames++;

	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
		set_ic = true;
    ...
}

__stmmac_set_coalesce() rejects the settings only when both values are
zero:

	if ((ec->tx_coalesce_usecs == 0) &&
	    (ec->tx_max_coalesced_frames == 0))
		return -EINVAL;

So a command like "ethtool -C ethX tx-usecs 1000 tx-frames 0" stores 0
in priv->tx_coal_frames[queue]. After that, every XDP_TX frame from
stmmac_xdp_xmit_back() and every frame from stmmac_xdp_xmit() hits this
modulo. On x86 that causes a divide error oops in softirq context.

stmmac_xdp_xmit_zc() and the skb xmit paths already check for this:

		if (!priv->tx_coal_frames[queue])
			set_ic = false;
		else if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)

Should stmmac_xdp_xmit_xdpf() have the same check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929121025.20821-1-jszhang%40kernel.org
