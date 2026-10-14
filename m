Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048C547077;
	Wed, 14 Oct 2026 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948816; cv=none; b=Bg9Gv/zl2nVpWbAGpx2dFg6PTnFYlrfBN08U732CliY9OG7QeURXaTUAqRIVaLw+9mNriSnmLzjB/Ss1eUEeNTp8fQ8XIvGdjNl72zQ/0HJMH9LbUWD2Cf6sIx5ejEP0RVTCf5QWce9r+Z3Xbhv/BzT0xDUWtyrU7h47BPQhL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948816; c=relaxed/simple;
	bh=r39beAuAkthbHXH+Rc/6tCUvIwflvav8kC/AwUKJwdU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6N3UP8YnY6tA4n6k2bDTTWOtICKnTjI7VV++Z4Y2tmGPeMKVlhG9+lveHjGipv44ir+iem3/kb1hdHI88NQo8SXTNysVwgUv0Pj1ThqBs+AGXwlYM344Qhr5A6B64C9s1LamhfaKc2jZiFrhBY+sVsaC/dZ3IUgPRr5OLlYwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6DaU3oE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6DaU3oE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917051F000FF;
	Wed, 14 Oct 2026 03:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791948815;
	bh=hdVNPXX+mEqB47rmv2rjd64sgDnMvE06aSM5G9mVz1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i6DaU3oEW6StgoHEucwsLxIexAeZ6IfTkIAWUzyuJItqz3+iBwYQqVURxC9BOknm2
	 PFNfZSpN0pXT85BVlOuQFr/sWC0PiKR/7K4vkRb8atx3vaNn3zMLiaEVFrrc8/gFPT
	 JgaAxqDoRlPK2NF4KnL/tuIisBr3htNrM7c0Daz5S/oxI0qkuPhF7krv7KiUFf8y5n
	 LWXCZkBaLCitGg38/rLNnX0sTotKxkA5EYUQPWBqgOk6t3BtsYkVTpWWagyp3mj+h9
	 KA1hUVpyTzzJbIFizddSFgE3XAwdvphkFbd7C7CLJCx4bmeYNTkLIhMX90Fkh+03Vd
	 lN35IydPUHeaw==
Subject: Re: [PATCH net] net: stmmac: xgmac: do not treat TBU as a TX event
From: netdev-bot+sashiko@kernel.org
To: zhangfeionline@gmail.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 chenchuangyu@xiaomi.com, horms@kernel.org, zhangpengfei16@xiaomi.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 03:33:34 +0000
Message-ID: <179194881415.434549.5017437610608933310@kernel.org>
In-Reply-To: <20261013024747.2688984-1-zhangfeionline@gmail.com>
References: <20261013024747.2688984-1-zhangfeionline@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Removing XGMAC_TBU from the TX condition in
  dwxgmac2_dma_interrupt() also removes an incidental TX-reclaim trigger.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the
  dwmac4/GMAC5 core has the same defect that this patch fixes for XGMAC.

--

net: stmmac: xgmac: do not treat TBU as a TX event

This patch removes XGMAC_TBU from the TX condition in
dwxgmac2_dma_interrupt(), so only TI schedules TX processing. TBUE is
not enabled and only enabled bits are acknowledged, so TBU was never
cleared. With a shared interrupt, that meant every interrupt scheduled
TX NAPI on every idle TX channel.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index ff83858ebc1f3..0a6e82a155c0e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -346,7 +346,7 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
>  		u64_stats_update_end(&stats->syncp);
>  		ret |= handle_rx;
>  	}
> -	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> +	if (likely(intr_status & XGMAC_TI)) {

[Severity: Medium]
Can the XDP_TX and ndo_xdp_xmit path stall permanently on XGMAC in
shared-IRQ mode when the TX coalesce timer is disabled?

__stmmac_set_coalesce() accepts tx-usecs=0 as long as tx-frames is
nonzero. stmmac_tx_timer_arm() then returns early:

    if (!tx_coal_timer)
        return;

stmmac_xdp_xmit_xdpf() sets IOC only on a tx_coal_frames boundary. It
has no !netdev_xmit_more() fallback like stmmac_xmit(). It also stops
taking new frames at 3/4 ring occupancy:

	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
		return STMMAC_XDP_CONSUMED;
	...
	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
		set_ic = true;
	else
		set_ic = false;

Take a 64 entry TX ring (stmmac_set_ringparam() accepts
DMA_MIN_TX_SIZE) with tx-frames=64 and tx-usecs=0. Starting from an
empty ring, only 48 XDP_TX frames get in. None of them reaches the IOC
boundary, so no TI is raised.

Before this patch, the sticky TBU bit made every later shared
interrupt return handle_tx and run stmmac_tx_clean(). That includes
the RX interrupts that drive XDP_TX.

stmmac_napi_poll_rx() does not call stmmac_tx_clean(). After this
change, would dirty_tx never advance on that queue? If so, every
further XDP_TX or redirect frame would be dropped with
STMMAC_XDP_CONSUMED. Only skb TX on the same queue or a reconfiguration
would recover it.

More generally, with tx-usecs=0, trailing XDP frames below tx-frames
would no longer be reclaimed on the next interrupt. The same gap
already exists in XGMAC per-channel MSI mode. This patch exposes it in
shared-IRQ mode as well.

The commit message says that what remains is "real TX and the TX
coalesce timer". Does that also hold when the timer is disabled?

[Severity: Medium]
This isn't a bug introduced by this patch, but does
dwmac4_dma_interrupt() in dwmac4_lib.c have the same sticky TBU
problem?

drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c:dwmac4_dma_interrupt() {
    ...
	if (unlikely(intr_status & DMA_CHAN_STATUS_TBU))
		ret |= handle_tx;
	...
	writel(intr_status & intr_en,
	       ioaddr + DMA_CHAN_STATUS(dwmac4_addrs, chan));
    ...
}

DMA_CHAN_INTR_NORMAL and DMA_CHAN_INTR_NORMAL_4_10 in dwmac4_dma.h
only contain NIE, RIE and TIE, and no TBUE bit is defined. So TBU is
never part of intr_en. Once a TX channel goes idle, its TBU status bit
is never cleared.

In shared-IRQ mode, stmmac_dma_interrupt() calls
stmmac_napi_check(priv, chan, DMA_DIR_RXTX) for every channel, and the
status is not masked for that direction. This looks like it would
schedule TX NAPI and stmmac_tx_clean() on every idle TX channel for
every interrupt. That is the same behaviour measured for XGMAC in the
commit message.

Since commit 1975df880b959e, TBU is no longer counted in
tx_normal_irq_n on this core. That would hide the effect from the
statistic used to diagnose the XGMAC case.

Should the dwmac4 implementation behind the same dispatcher get the
same change?

>  		u64_stats_update_begin(&stats->syncp);
>  		u64_stats_inc(&stats->tx_normal_irq_n[chan]);
>  		u64_stats_update_end(&stats->syncp);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013024747.2688984-1-zhangfeionline%40gmail.com
