Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220636;
	b=fnvK17v6ePcX88zNfYZxEUAP2qkVCbJq4hT8g2YiXC6fn7J2TjNPn55FCohrKiyRnYOw
	 5SctDn0WOlWSSy0yzc1ZZE16ZgPSL0hbsEOh+XUqmijVK23Fgt95UzjeFjPJixAljH9Pl
	 o7KFU6yWCAJNdHlxYIQsqSUiF9mI/1EI+iNDcXYPe8tFccodEbBh4GazOTVKm0HvIFOI/
	 VvowfKvXuRibXLwyyizzXyD8u5+x1SbzgdCbEoOAIYmyDCTOaklRP1/w93e26UWALtt3j
	 JmwaZq3uAUV9qb/vTY5E8xKLr9mOkUSU+G9TBjpxkHxWvIe0xzhAC+UAxwdPrT5RAXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220636;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JWGXSQ0hUQUGHoC4dVJ49MPWtJvFZTUeG1TXP2ZaI3g=;
	b=roWvUrbfxdVU5Yo0uTV5tJJtD6EkdDi/uJ47t7BmdCpd+qDyyyiaoiwjnpwth3OVlToN
	 uiqNXGLtIh1NqlA860rNspXusQPuDVzdTvFjLQz0RkQL/Orc9Cl5dIqCj8gO3r2PWOapu
	 acyXyTIUkPuv1llxnR89diHoIiKh4KCz7tuFpxb73gzqmq50kRPXFyNrtlzssjnkGG2Md
	 JYTSAdKvIxHAonm4K3WSGqMea+XUT261Ls/fdldJJ44j1xgYCl+z7QhdhgpIojVF0N3w5
	 ItzQFIbIH/wiQoFItyzpNawkjjLdPBsNNFXnpzVYF4j+B8J45DgnG1tC/yS1GzstEnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChR5inIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF518606A323;
	Mon,  9 Nov 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChR5inIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D701F0089F;
	Mon,  9 Nov 2026 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794220635;
	bh=JWGXSQ0hUQUGHoC4dVJ49MPWtJvFZTUeG1TXP2ZaI3g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ChR5inIeuioYwn2lnClX1r47ujkSy3cnVwlYioF4BFRS0jInmFSD8MS8Eh7Q+v6Op
	 lPAJKxmTWbQWxanhbExqOG+PavGbimGM2EosCDYi8dzt5A9eno9sYoLPOsrZIn+Vj7
	 KVFLYYTCr7OfIH4wjiziV0oOIDbC8u3PGE7iBh2bISAHMc1RF4lFBNvUQ0RE93wcAZ
	 GJdphuurrKPfvwED0gYeuzvsDZKWlBcc5MotiuMuNsCF2TRyiVcPLnyDK0HYDzIf3V
	 ue1xRXLk6W14/9KPiEtB9WUYOfnICb//YIsKxoJWZDCq5ssBgRZuwpTDvgN/JhjX7w
	 11NamFqqe7Zgg==
Subject: Re: [PATCH net-next 2/3] net: sb1250-mac: Advertise and honor RX
 checksum offload
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, macro@orcam.me.uk
Date: Mon, 09 Nov 2026 10:37:14 +0000
Message-ID: <179422063443.994134.7898125324608942943@kernel.org>
In-Reply-To: <20261105193435.2050321-3-f.fainelli@gmail.com>
References: <20261105193435.2050321-3-f.fainelli@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] sbdma_rx_process()
  (drivers/net/ethernet/broadcom/sb1250-mac.c:1146-1149) reads the…
- [Medium] The RX checksum engine's IP-header-offset setup, which the
  probe comment calls necessary ("This is needed for PASS2 for Rx H/W…

--

net: sb1250-mac: Advertise and honor RX checksum offload

This patch adds NETIF_F_RXCSUM to hw_features. It also enables the
offload by default on chip revisions where sbmac_set_iphdr_offset()
reports hardware checksum support. The receive path now tests the active
feature bit, not sc->rx_hw_checksum, before it marks packets
CHECKSUM_UNNECESSARY.

> diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
> index 1843b52e96f51..546415d3134c6 100644
> --- a/drivers/net/ethernet/broadcom/sb1250-mac.c
> +++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
> @@ -1142,8 +1142,8 @@ static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
>  				 * the kernel
>  				 */
>  				sb->protocol = eth_type_trans(sb,d->sbdma_eth->sbm_dev);
> -				/* Check hw IPv4/TCP checksum if supported */
> -				if (sc->rx_hw_checksum == ENABLE) {
> +				/* Honor the RX checksum offload feature setting. */
> +				if (dev->features & NETIF_F_RXCSUM) {
>  					if (!((dsc->dscr_a) & M_DMA_ETHRX_BADIP4CS) &&
>  					    !((dsc->dscr_a) & M_DMA_ETHRX_BADTCPCS)) {
>  						sb->ip_summed = CHECKSUM_UNNECESSARY;

[Severity: High]
In sbdma_rx_process(), is M_DMA_ETHRX_BADTCPCS tested against the right
descriptor word? The header defines it as a dscr_b bit:

arch/mips/include/asm/sibyte/sb1250_dma.h:
/* Note: This bit is in the DSCR_B options field */
#define M_DMA_ETHRX_BADTCPCS	_SB_MAKEMASK1(0)

In dscr_a, bit 0 is the low bit of the RX buffer's physical address,
which sbdma_add_rcvbuffer() programs:

	dsc->dscr_a = virt_to_phys(sb_new->data) |
		V_DMA_DSCRA_A_SIZE(NUMCACHEBLKS(pktsize + NET_IP_ALIGN)) |
		M_DMA_DSCRA_INTERRUPT;

sb_new->data is set up with sbdma_align_skb(sb_new, SMP_CACHE_BYTES,
NET_IP_ALIGN). The address is therefore cache-line aligned plus 2, so
that bit is always 0.

If so, the hardware's TCP checksum result is never read. Any frame with
a valid IPv4 header checksum gets CHECKSUM_UNNECESSARY. That includes
TCP segments the hardware flagged as having a bad TCP checksum, and the
stack then skips software verification of the payload.

This decoding seems to go back to the original driver code. Still, the
commit message says "The driver already trusts hardware RX checksum
status". This patch rewrites the same conditional and makes it a
default-on offload that ethtool reports.

Should this test dsc->dscr_b & M_DMA_ETHRX_BADTCPCS instead? The same
loop already reads dscr_b through G_DMA_DSCRB_PKT_SIZE(), so the
hardware does write that word back.

The later patch in the series ("Add ethtool autonegotiation restart
support") doesn't change this check either.

> @@ -2214,6 +2214,10 @@ static int sbmac_init(struct platform_device *pldev, long long base)
>  
>  	/* This is needed for PASS2 for Rx H/W checksum feature */
>  	sbmac_set_iphdr_offset(sc);
> +	if (sc->rx_hw_checksum == ENABLE) {
> +		dev->hw_features |= NETIF_F_RXCSUM;
> +		dev->features |= NETIF_F_RXCSUM;
> +	}

[Severity: Medium]
Is the IP header offset that the checksum engine relies on actually
programmed while the interface is running? The comment above calls it
necessary, but sbmac_set_iphdr_offset() does:

	/* Hard code the off set to 15 for now */
	reg = __raw_readq(sc->sbm_rxfilter);
	reg &= ~M_MAC_IPHDR_OFFSET | V_MAC_IPHDR_OFFSET(15);
	__raw_writeq(reg, sc->sbm_rxfilter);

Because of operator precedence, this only masks the register and never
writes 15 into the field. S_MAC_IPHDR_OFFSET is 8 and the field is 8
bits wide, so the field ends up as the old value's low four bits.

There is a second problem. The path sbmac_open() ->
sbmac_set_channel_state() -> sbmac_channel_start() writes the whole of
sbm_rxfilter:

	__raw_writeq(0, s->sbm_rxfilter);
	...
	__raw_writeq(M_MAC_UCAST_EN | M_MAC_BCAST_EN, s->sbm_rxfilter);

That resets IPHDR_OFFSET to 0. sbmac_mii_poll() also calls
sbmac_channel_start() on link changes, and nothing reprograms the field
afterwards.

So while traffic is flowing, the checksum engine uses an IP header
offset the driver never intended. NETIF_F_RXCSUM is now advertised and
turned on by default based only on the revision check, and
sbdma_rx_process() trusts the engine's status bits.

Could the field be set with something like:

	reg &= ~M_MAC_IPHDR_OFFSET;
	reg |= V_MAC_IPHDR_OFFSET(15);

and kept across the rxfilter writes in sbmac_channel_start()? This code
predates the patch, and the later patches in the series don't touch it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105193435.2050321-1-f.fainelli%40gmail.com
