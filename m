Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634518;
	b=pw3c7mVaoOA7rVesVwxXCS9ivKAd+hMMIEZ21qgVzuA07ez+JWS3oRcYsMMd8iSBgzbd
	 iF/uzwKaib4y16Q7JBlm3MEfhVP46+Ox0Jwv6CTlkeZMBj28333PE6cmB93jXEV6+DL8G
	 0f30ltYm9PDc2AYr7rpuHLnzQ58olymU0nugen7xjokDbntYriiSpHRKRrddkvK2tYz1S
	 tE4sBCk1AxrxMraZjGRYFY0G4jIBvTcx91zSyPl+zZJDLKNS4XXJjh2z0swESNvoCMFT2
	 IE1z1VnAbeG61Zk0pP6fjEksbhob9LKnfyEGwK271xoez+zpMFTGaQVoL3um4Q8j/Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634518;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JizkY6RQw85+M+7HrEzzFgyVMl7LWpk8mebiUA+WKrs=;
	b=ReCOHplfjiJhkJ8IFJkaJFp5vk6b3n8iSJGxl1vdaJjnWuDCBo1uUjM2WCwY7kd9Vwn5
	 vmABDJI7LlB2zUAKtDnO4OL58WqHbGKVf5n4PV+B+LwUhjcDswo7ZCDGYy65PijdmtP0e
	 z2w++yC3WHgZetQqInfLwFhnhZ+TKfGfJTRD1v5TyRrLJpf8sTJq552NfzZdZe5OeImH/
	 K7u219eoIcOqIHYsMHeGbbk2fAOvo9uxKyJDvYNWjNRrccKzwXBkPWm3iKMMTuaSA8vCj
	 2tK6vvPFUsrn2mTMJuUslxBsSRIl3CZSiU8RULjilX1jt6vU6dcpbLehnYIvEbMbW4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mypvE88V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF2606A319;
	Thu, 22 Oct 2026 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mypvE88V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28D41F000C1;
	Thu, 22 Oct 2026 02:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634517;
	bh=JizkY6RQw85+M+7HrEzzFgyVMl7LWpk8mebiUA+WKrs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mypvE88VWLhc22iiz8845ISZKAwFtObGQZs3O5SEbhji+PLKosFwnnDA1HJxAUXtG
	 EIPqdLvKLnuUEdmcAGHdOdHRDJwSgrNU3nRHuFnkIQCQTRsx5TZMUt+JZHoyBupTS1
	 zJHUWHvsvWgDnyPCXCfyZmWgpiEyfSwNFmhMwcu0NTPp0f+h6vZzyYLSuc1uUqKaF+
	 MWxZSs8H4HJHAX9DZuE+BwTgJu2W3PfFoJxjEzwWRPmxpaYc3TBTM6AN3aog+tkjJ9
	 qohh7vmPTNZI5aHF0q3GwvL58wJ1O83N8784b5jh2ISg83YELtsBoU2klqYQ/7Dumu
	 Fhre5EyeeyAbw==
Subject: Re: [PATCH net v2] net: ag71xx: re-enable TX interrupts on RX OOM
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 02:01:56 +0000
Message-ID: <179263451640.3135.7594958508098386565@kernel.org>
In-Reply-To: <20261019020147.213746-1-rosenp@gmail.com>
References: <20261019020147.213746-1-rosenp@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 3 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The RX-OOM exit in ag71xx_poll()
  (drivers/net/ethernet/atheros/ag71xx.c, around line 1732) now calls…
- [Low] NAPI can now be scheduled with TX_PS unmasked, which the driver
  did not allow before.
- [Low] In ag71xx_poll()'s OOM exit (lines 1731-1732), the new TX unmask
  runs after an unchecked napi_complete().
- [Low] The concern says the unlocked INT_ENABLE read-modify-write
  (ag71xx_sb/ag71xx_cb, lines 417-435), together with the new TX unmask,…

Pre-existing issues:
- [Low] The concern says the new TX enable in the OOM path can set TX_PS
  in AG71XX_REG_INT_ENABLE again after ag71xx_hw_stop() has cleared it,…

--

net: ag71xx: re-enable TX interrupts on RX OOM

This commit makes the RX out-of-memory exit in ag71xx_poll() unmask the
TX interrupt after napi_complete(). Before this change, INT_POLL stayed
masked until the OOM timer fired, so TX completions were held off for
about 100ms.

> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index 4e4794c4dfdce..3e582a7fa314a 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1729,6 +1729,7 @@ static int ag71xx_poll(struct napi_struct *napi, int limit)
>  
>  	mod_timer(&ag->oom_timer, jiffies + AG71XX_OOM_REFILL);
>  	napi_complete(napi);
> +	ag71xx_int_enable(ag, AG71XX_INT_TX);

[Severity: Medium]
With TX_PS unmasked here, does every TX completion during RX OOM now run
a full poll that lands back on the oom label?

ag71xx_interrupt() schedules the whole NAPI poll for any INT_POLL bit:

    if (likely(status & AG71XX_INT_POLL)) {
        ag71xx_int_disable(ag, AG71XX_INT_POLL);
        ...
        napi_schedule(&ag->napi);
    }

While allocation keeps failing, ag71xx_poll() goes straight back to oom:

    rx_done = ag71xx_rx_packets(ag, limit);

    if (!rx_ring->buf[rx_ring->dirty % rx_ring_size].rx.rx_buf)
        goto oom;

Each of these passes does three things:

  - ag71xx_rx_packets()->ag71xx_ring_rx_refill() tries another atomic
    napi_alloc_frag().
  - It prints netif_err(ag, rx_err, ndev, "out of memory\n") again, with
    no ratelimit. NETIF_MSG_RX_ERR is in AG71XX_DEFAULT_MSG_ENABLE, so
    this message shows with default settings.
  - mod_timer() pushes oom_timer forward again.

Before this change the path ran at most once per AG71XX_OOM_REFILL. Now
it can run once per TX IRQ for as long as memory stays short and TX
traffic keeps flowing.

The commit message says TX delivery is restored "while NAPI waits for RX
buffer memory". It looks like NAPI actually keeps retrying at the TX
interrupt rate, and the OOM_REFILL backoff no longer applies. Is that
intended?

[Severity: Low]
Does this break the driver's rule of masking interrupts before NAPI is
scheduled?

ag71xx_interrupt() always masks AG71XX_INT_POLL before napi_schedule().
ag71xx_oom_timer_handler() schedules NAPI without masking anything:

    static void ag71xx_oom_timer_handler(struct timer_list *t)
    {
        struct ag71xx *ag = timer_container_of(ag, t, oom_timer);

        napi_schedule(&ag->napi);
    }

That was fine while the OOM exit left all of INT_POLL masked. With TX_PS
now unmasked, a poll started by the timer can run with TX interrupts
live. A TX IRQ during that poll masks POLL partway through and sets
NAPI_STATE_MISSED.

The reverse case can also happen. A poll driven by a TX IRQ can leave
the OOM state through the normal exit, which calls
ag71xx_int_enable(ag, AG71XX_INT_POLL). The oom_timer armed above is
never cancelled, so it later schedules a spurious poll with all POLL
interrupts enabled.

Neither case seems to corrupt state. Is the extra poll and interrupt
traffic expected, though?

[Severity: Low]
This isn't a bug introduced by this patch, but can this new enable set
TX_PS in AG71XX_REG_INT_ENABLE again after ag71xx_hw_stop() has cleared
it?

ag71xx_hw_disable() stops the hardware before it quiesces NAPI and the
timer:

    ag71xx_hw_stop(ag);
    ag71xx_dma_reset(ag);

    napi_disable(&ag->napi);
    timer_delete_sync(&ag->oom_timer);

ag71xx_fast_reset() does not quiesce NAPI at all. The normal exit in
ag71xx_poll() already re-enables AG71XX_INT_POLL in the same window, so
the window predates this change.

The new line's effect there looks negligible:

  - ag71xx_dma_reset() clears the pending PS count.
  - TX DMA is stopped.
  - ag71xx_hw_start() later overwrites INT_ENABLE with AG71XX_INT_INIT.

[Severity: Low]
Should this unmask depend on what napi_complete() returns?

include/linux/netdevice.h documents napi_complete_done() as returning
"false if device should avoid rearming interrupts".
Documentation/networking/napi.rst says "IRQ should only be unmasked
after a successful call to napi_complete_done()".

napi_complete_done() returns false in these cases:

  - NAPIF_STATE_NPSVC or NAPIF_STATE_IN_BUSY_POLL is set.
  - NAPIF_STATE_MISSED was set, and NAPI has been rescheduled.

TX_PS can now be unmasked during timer-driven polls, so MISSED can
happen here. In those cases TX is unmasked while NAPI is still
scheduled, which gives a spurious IRQ.

This would follow the documented contract:

    if (napi_complete(napi))
        ag71xx_int_enable(ag, AG71XX_INT_TX);

The existing normal exit path has the same unchecked pattern, but this
patch adds a new instance of it.

[Severity: Low]
ag71xx_int_enable() does an unlocked read-modify-write of
AG71XX_REG_INT_ENABLE through ag71xx_sb():

    iowrite32(ioread32(r) | mask, r);

Could the new TX unmask race with ag71xx_int_disable() in
ag71xx_interrupt() and lose an update?

As far as I can tell this is harmless in practice:

  - AG71XX depends on ATH79 || COMPILE_TEST, and ATH79 is uniprocessor.
    Two polls can't interleave their read-modify-writes.
  - A hardirq that preempts this read-modify-write can only lose its own
    mask. TX_PS stays asserted and the line is level-sensitive, so the
    interrupt fires again and ag71xx_interrupt() masks POLL again.

The worst case looks like one extra interrupt.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019020147.213746-1-rosenp%40gmail.com
