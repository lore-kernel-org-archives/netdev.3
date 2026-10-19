Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B84E8DF2
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410201; cv=none; b=E5kgNhlHB0h5bVjMb2kOBqXlm0FgDbHmZQ/AlmR1Ug7bGow6QX3UA7/hqK/Wel3eRBMP2WSMoB3Jk1XT7lWoOGbJ886S9knvwsTD3PFiXxSGlgeeQMZstchOWs7+WhOg55GFT1ARkZNfDam0AsOfxQmt9iuFuJLrXSEnOeKs7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410201; c=relaxed/simple;
	bh=IJq3oe026Ch/NagbToM44x+lPwduVJbz5KUxBGV5slU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjyI3Bf2U6ag7aZMS4BCdJpxJT8L3/kMh7jbHbFeuW43H5yW7rbSVTdJ+HJ3Oaq3MwMiuMrvERZ39FNFNgkOObLM2B5+QCGXw3z7PemkSPtbFOlpBOY/KaGXUID4GLR3jZX7+zbk8Ma8SNXmdT/tdAmCZNAkqOPl9B2VHdMkJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHr3iv6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHr3iv6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439891F000C4;
	Mon, 19 Oct 2026 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792410193;
	bh=hASnv+sShbpSN84lIK0vwzCccQ7DGFNvDbQRK1Twa1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gHr3iv6CinGvRkRBuYrfe0QaAgH6mesatPs+ujwnE3VoJm/pdD+RxcNReTK1GJfPb
	 uHSe4BGdl/C+3cWW37GvSB9/iYq1qBBtjMPTiXL4HM0/epWdc86S5ag7UvAceYxqzz
	 y+kziKBI1yrL7eLJy8Poey0rW4rY50gCqd2CmTIZYa4h7hch1OMpOjMD7QH9vuRpCH
	 nqBrUp7afUy7HtFSSTUWM3/E9UrvNN/i0cyTV5DpdBVjmwLM4OTQFGiSKFJ/9Vd2/F
	 tBQul50vkCrz8pAnF/5tzvSiKHmyIjRtKl6nucDSf1Dt4VNbYYj4U9wlDnU44GdwIZ
	 B7IdNxgwtQsyg==
Subject: Re: [PATCH] net: stmmac: remove STMMAC_DOWN check to avoid irq storm
From: netdev-bot+sashiko@kernel.org
To: chuanx2070@163.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 19 Oct 2026 11:43:12 +0000
Message-ID: <179241019282.3135.17755153635935720256@kernel.org>
In-Reply-To: <20261015112415.437900-1-chuanx2070@163.com>
References: <20261015112415.437900-1-chuanx2070@163.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch moves the STMMAC_DOWN check so it runs after the
  hardware interrupt status has been read and cleared.
- [Low] The commit fixes a user-visible bug: an interrupt storm (a hard-
  IRQ livelock on UP, or on the CPU running the stmmac_wq reset worker)…

--

net: stmmac: remove STMMAC_DOWN check to avoid irq storm

This patch removes the early STMMAC_DOWN return from the stmmac interrupt
handlers, so the device status registers are always read and cleared. The
STMMAC_DOWN check now sits inside stmmac_safety_feat_interrupt() and
stmmac_napi_check(), after the status has been read, and events are dropped
while the bit is set. The goal is to avoid an interrupt storm on
level-triggered IRQ lines during an adapter reset.

[ ... ]

> is re-entered forever. Since the handler returns IRQ_HANDLED,
> note_interrupt() never flags the IRQ as spurious and never disables it,
> resulting in an interrupt storm.
>
> Signed-off-by: Xiaochuan Li <chuanx2070@163.com>

[Severity: Low]
Should this have a Fixes: tag? The STMMAC_DOWN early return in
stmmac_interrupt() was added by:

34877a15f787 ("net: stmmac: Rework and fix TX Timeout code")

The same check was later copied into stmmac_mac_interrupt(),
stmmac_safety_interrupt(), stmmac_msi_intr_tx() and stmmac_msi_intr_rx() by:

8532f613bc78 ("net: stmmac: introduce MSI Interrupt routines for mac, safety, RX & TX")

Without a Fixes: tag, or a Cc: stable, stable maintainers can't easily tell
that this is a fix or which trees need it.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b837e8e27a352..ec7ca45a9ba61 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3063,6 +3063,13 @@ static bool stmmac_safety_feat_interrupt(struct stmmac_priv *priv)
>  
>  	ret = stmmac_safety_feat_irq_status(priv, priv->dev,
>  			priv->ioaddr, priv->dma_cap.asp, &priv->sstats);
> +
> +	/* Status is read/cleared; do not escalate to a global error reset
> +	 * while the interface is going down.
> +	 */
> +	if (test_bit(STMMAC_DOWN, &priv->state))
> +		return false;
> +
>  	if (ret && (ret != -EINVAL)) {
>  		stmmac_global_err(priv);
>  		return true;
> @@ -3085,6 +3092,12 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan, u32 dir)
>  	rx_napi = rx_q->xsk_pool ? &ch->rxtx_napi : &ch->rx_napi;
>  	tx_napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
>  
> +	/* Status was already read (and clear) above, so the irq line is
> +	 * deasserted, Drop the event while the interface is going down.
> +	 */
> +	if (test_bit(STMMAC_DOWN, &priv->state))
> +		return 0;
> +

[Severity: High]
Is "while the interface is going down" accurate here? STMMAC_DOWN is set and
cleared only in stmmac_reset_subtask(), and it stays set across dev_open()
as well as dev_close():

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_reset_subtask() {
    ...
	set_bit(STMMAC_DOWN, &priv->state);
	dev_close(priv->dev);
	dev_open(priv->dev, NULL);
	clear_bit(STMMAC_DOWN, &priv->state);
    ...
}

By the time dev_open() returns, __stmmac_open() has already set up DMA,
called phylink_start(), requested the IRQs, enabled NAPI and the TX queues,
and called stmmac_enable_all_dma_irq(). The NETDEV_UP notifiers also run
before clear_bit().

Can interrupts from the reopened, running hardware in that window be
acknowledged and then lost? stmmac_dma_interrupt_status() has already
written the W1C status, for example in dwmac4_dma_interrupt():

	writel(intr_status & intr_en,
	       ioaddr + DMA_CHAN_STATUS(dwmac4_addrs, chan));

Then stmmac_napi_check() returns 0 without scheduling NAPI. Before this
patch, the status stayed latched and was serviced once STMMAC_DOWN was
cleared.

Here are some of the cases.

If RI is dropped and the RX ring fills inside the window, RX DMA suspends
with RBU. dwmac4_dma_interrupt() only counts RBU in rx_buf_unav_irq and
never returns handle_rx. Does RX then stay stalled, because
stmmac_rx_refill() never runs, until the next ifdown/up or reset?

If TI is dropped and tx_coal_timer is 0, stmmac_tx_timer_arm() returns
early. What reclaims those TX descriptors in that case?

Because the status is 0, stmmac_dma_interrupt() and stmmac_msi_intr_tx()
also skip this for a stopped TX DMA channel:

	if (unlikely(status[chan] & tx_hard_error_bump_tc)) {
		stmmac_bump_dma_threshold(priv, chan);
	} else if (unlikely(status[chan] == tx_hard_error)) {
		stmmac_tx_err(priv, chan);

That leaves recovery to the netdev watchdog.

In stmmac_safety_feat_interrupt(), an uncorrectable ASP error reported by
the reinitialised hardware never reaches stmmac_global_err(). In
stmmac_interrupt(), the false return also falls through into
stmmac_common_interrupt() and stmmac_dma_interrupt() on hardware that has
just reported a fatal error.

On the close side, __stmmac_release() calls stmmac_disable_all_queues()
(napi_disable) before stmmac_free_irq(), so napi_schedule_prep() already
fails there. That suggests the new check only changes behaviour during the
reopen half of the reset.

Would it work to clear STMMAC_DOWN, or use a separate close-only state,
before the DMA IRQs are re-enabled? Or to keep handling events normally and
rely on napi_disable() during close?

>  	if ((status & handle_rx) && (chan < priv->plat->rx_queues_to_use)) {
>  		if (napi_schedule_prep(rx_napi)) {
>  			spin_lock_irqsave(&ch->lock, flags);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015112415.437900-1-chuanx2070%40163.com
