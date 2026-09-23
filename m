Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1343C0A13;
	Wed, 23 Sep 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197885; cv=none; b=TEXTEfhnFsQf6ubF5njrvwnqCPlGh3/2/l+Gb8cEEFsjMGOxJHTbaOR+PcTygybb28RxThNaYGPbNHf7lkuRLdfLVZtNdRgwihRWPPyjuDGl40u6lw8YJ6wwczF5qu5zsPO7W5JYQJ9PtLKP7EImWcvCd8bdXtgvMKh3wi0YXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197885; c=relaxed/simple;
	bh=ixWdPTKlMoQFOib4joEUlVJ9jsuhtDHw7falvoWX+CA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chGpoMxD76xFuKRZdEwpfkOUuquexmPyJN/jJAUc1elZY0ZGe3YdsJT4nnPbhjBc66dTyvQLTWtBQUMxYqvLVZtJ1ztj1U6vgOG928G/zK3Pib3R/RXehNhv47MrgiKSIdOBUAS2nkFZALrBXrZ7wWGw03RyoLWNpBuqTctVA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V670hwKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V670hwKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330EE1F00898;
	Wed, 23 Sep 2026 21:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790197874;
	bh=N/2gVNmUkYVUouv/Z3mLtPZFd5sd1t9WObCYrsAlUZg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V670hwKDOCbZJ9RNdaCpehFQz4Be2ZRuF8/bXKUSThOb8sEWfhbHUCLsUZzeBbi7g
	 u2UQ7OyvQMHhkeGO068NGAkS7QbLnGcO1mA9yXSsYQMwIAqWODmgSP9TumRU2oFxz7
	 fH7lCjCE57AlIswtF0ARRMhZDVp4+SWg/2Dpk5L/8s57Ih9n8ROZBJnpjQZdUU9l/R
	 rN9WJ1Hj0ACA0VX71wpuP7KgNpgbZSxmvGVYXn37DCbybKyt5MesYOlE0UhU2DYWu3
	 LDUzTWLmJnpkCDD/InMQdFM9ofEaEYwGnOdxMZI4t6anS9Ifl0Rt8xlRIRypJrlfRT
	 LPxAiZ3ClSP7Q==
Subject: Re: [PATCH net-next 3/4] net: macb: Disable one-step mode when TX
 timestamping is off
From: netdev-bot+sashiko@kernel.org
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com, rafalo@cadence.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, nb@tipi-net.de, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 21:11:13 +0000
Message-ID: <179019787374.2160803.8319853931477161617@kernel.org>
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-3-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-3-9d1abaa53296@khu.ac.kr>
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

- [Medium] gem_set_hwtst() now performs an unconditional read-modify-
  write of NCR under bp->lock (macb_ptp.c:446-448), including for…

--

net: macb: Disable one-step mode when TX timestamping is off

gem_set_hwtst() left NCR.OSSMODE set when switching from
HWTSTAMP_TX_ONESTEP_SYNC to HWTSTAMP_TX_OFF.  The patch always includes
OSSMODE in the NCR update mask and sets the bit only for
HWTSTAMP_TX_ONESTEP_SYNC, so the empty-mask check around the NCR
read-modify-write is dropped.

> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index b6d17fef429f6..6376b663130d8 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c

[ ... ]

> @@ -445,11 +444,9 @@ int gem_set_hwtst(struct net_device *netdev,
>  	}
>  
>  	spin_lock_irqsave(&bp->lock, flags);
> -	if (ncr_mask) {
> -		regval = macb_readl(bp, NCR);
> -		regval = (regval & ~ncr_mask) | ncr_bits;
> -		macb_writel(bp, NCR, regval);
> -	}
> +	regval = macb_readl(bp, NCR);
> +	regval = (regval & ~ncr_mask) | ncr_bits;
> +	macb_writel(bp, NCR, regval);

[Severity: Medium]
Is bp->lock enough to make this NCR read-modify-write atomic against the
other NCR writers in the driver?

macb_tx_lpi_set() in macb_main.c documents bp->lock as the intended
serialisation for NCR:

	lockdep_assert_held(&bp->lock);

	ncr = macb_readl(bp, NCR);

but several other NCR read-modify-write sites do not take it.
macb_mac_link_down():

	/* Disable Rx and Tx */
	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
	macb_writel(bp, NCR, ctrl);

macb_mac_link_up() drops bp->lock first and only then touches NCR:

	spin_unlock_irqrestore(&bp->lock, flags);
	...
	/* Enable Rx and Tx; Enable PTP unicast */
	ctrl = macb_readl(bp, NCR);
	if (gem_has_ptp(bp))
		ctrl |= MACB_BIT(PTPUNI);

	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

macb_interrupt_misc() does the same thing from hardirq context, and
macb_hresp_error_task() from a work item, neither under bp->lock.

gem_set_hwtst() runs from ndo_hwtstamp_set under rtnl, while
mac_link_up/mac_link_down run from phylink_resolve() under
pl->state_mutex, so can these two run concurrently on different CPUs?

If so, can the OSSMODE clear be lost like this?

CPU0 phylink_resolve()->macb_mac_link_up()
	ctrl = macb_readl(bp, NCR);		/* OSSMODE still set */

CPU1 gem_set_hwtst(HWTSTAMP_TX_OFF)
	regval = (regval & ~MACB_BIT(OSSMODE));
	macb_writel(bp, NCR, regval);
	bp->tstamp_config = *tstamp_config;	/* records TX_OFF */

CPU0
	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
						/* OSSMODE back on */

That leaves one-step insertion enabled in hardware while the cached
config reports HWTSTAMP_TX_OFF, which is the divergence the commit
message describes removing.

The reverse direction looks newly reachable too, since a
HWTSTAMP_TX_OFF plus HWTSTAMP_FILTER_NONE request previously skipped the
register access entirely and now always writes NCR:

CPU0 gem_set_hwtst()
	regval = macb_readl(bp, NCR);		/* RE|TE set */

CPU1 macb_mac_link_down()
	macb_writel(bp, NCR, ctrl & ~(RE|TE));

CPU0
	macb_writel(bp, NCR, regval & ~ncr_mask);	/* RE|TE restored */

Would it make sense to convert the remaining NCR read-modify-write sites
to take bp->lock, so the assumption this patch relies on actually holds?
Note spin_lock_irqsave() here does not exclude the macb_interrupt_misc()
NCR update running on another CPU.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296%40khu.ac.kr
