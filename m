Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8D4734C7;
	Wed, 23 Sep 2026 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197885; cv=none; b=EZYm744xj0HH2081i03DOT2CnPrka2vLWym3DFsJMvf5KGVvY4wcdXJrEQ2MksX07wVYL4xxktCiL4JY5SwMqMpHeBB90TGoY0071U3NIxvkvaryLVavLLkzU8UIXpBA3Tl20RtiSorFz+W4GwNEXejE01zogJHrJ5FuU6cwT+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197885; c=relaxed/simple;
	bh=qF7oLSxPyGx6IHLSJXArA9n5pRh1BO/YumeouYEfrOc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hR5fZfNEXFzBD/lM8Sg+hMKVyUKUNSoDPssDumRjZsM+XkUL19a2GO9cD/U5pxZuEpsE4n7bInKoyIk6NHzDrx/7xFjWJUTbf6Rsg7EwNgAvY3VSLIbAHGXqEu94Acg9GllUU7zrjtceIP4q1b4dhtmE3n29tLn9kUAOiNFVuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq9yWXnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq9yWXnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F1A1F0089A;
	Wed, 23 Sep 2026 21:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790197876;
	bh=mZc34a62xjV+Gin6pKzLHVBzTPEOPGl5srNpUH0bHq8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nq9yWXnkVw0ifBCGsgWDm/ThmBErrWCba3lvie1M2EjJekCqRqEXhpvGPWyGRLlkU
	 zQ9LYxXtGnzupxfCi3Hi+Mx9KhK9ye93p2ETf+L9xzltrnTUXTdZIJixo4nVys8PpM
	 FSbexCE38jB+97KcIalLP8E/EsVXkQZODy4dPRuN3PVPfVFIo0u3pVL4bNIAZuh/mA
	 gTHForvkOeQmfJpEnphCe/aHj18CPviVQts3n80rIE3Th8GQ8oKrUrUwbEwCCyCOU6
	 Pcj7uckAHrPPoS3coOmkBeoIOSz2s3IYQbRkcvu2o8e23YD4aECYzJIx3oa6rhS+gE
	 pmKCm8iqP+dSw==
Subject:
 Re: [PATCH net-next 4/4] net: macb: Clear SRTSM outside PTPv2 receive filters
From: netdev-bot+sashiko@kernel.org
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com, rafalo@cadence.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, nb@tipi-net.de, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 21:11:15 +0000
Message-ID: <179019787507.2160803.11061612649077740296@kernel.org>
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-4-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-4-9d1abaa53296@khu.ac.kr>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Missing `Fixes:` tag and no stated user-visible impact.

Pre-existing issues:
- [Medium] ABI advertisement vs. implementation mismatch:
  gem_get_ts_info() (drivers/net/ethernet/cadence/macb_main.c:3772-3774)…
- [Medium] PTP timestamping hardware state is lost across system
  suspend/resume while the cached configuration is kept.
- [Medium] Lost-update race on the NCR MMIO register: gem_set_hwtst()
  performs its read-modify-write of NCR under…

--

net: macb: Clear SRTSM outside PTPv2 receive filters

The patch moves MACB_BIT(SRTSM) into the unconditional NCR read-modify-write
mask in gem_set_hwtst(), so the bit is now programmed from the currently
selected RX filter instead of only ever being set. Switching away from a
PTPv2 filter therefore clears it.

A few questions below, mostly about pre-existing behaviour in the same
function.

>     net: macb: Clear SRTSM outside PTPv2 receive filters
>
>     A PTPv2 receive filter sets NCR.SRTSM, but switching to NONE, ALL or a
>     PTPv1 filter leaves it set. As a result, selecting the same filter can
>     produce a different register setting depending on whether PTPv2 was
>     used before.

[Severity: Low]
Should this carry a Fixes: tag?  git blame at the parent commit points the
sticky bit at ab91f0a9b5f4 ("net: macb: Add hardware PTP support"), which
introduced:

	regval = macb_readl(bp, NCR);
	macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));

and nothing in the tree ever cleared it since.  The three sibling patches
in this series that touch the same function ("net: macb: Preserve timestamp
settings on rejected requests", "net: macb: Enable RX timestamping for
specific PTPv1 filters", "net: macb: Disable one-step mode when TX
timestamping is off") all carry Fixes: ab91f0a9b5f4.

This patch also depends on the ncr_mask read-modify-write added by
"net: macb: Preserve timestamp settings on rejected requests", so without
a tag stable trees would get patches 1-3 and not this one, leaving the
SRTSM half of the same defect in place.

The changelog stops at "produce a different register setting" and never
names the user-visible effect.  Can the consequence of leaving SRTSM set
for a NONE/ALL/PTPv1 filter be spelled out, so it is clear whether this is
a functional fix or a consistency cleanup?

> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index 6376b663130d8..637d0da3278c8 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -390,7 +390,7 @@ int gem_set_hwtst(struct net_device *netdev,
>  		  struct kernel_hwtstamp_config *tstamp_config,
>  		  struct netlink_ext_ack *extack)
>  {
> -	u32 ncr_mask = MACB_BIT(OSSMODE);
> +	u32 ncr_mask = MACB_BIT(OSSMODE) | MACB_BIT(SRTSM);

[Severity: Medium]
This is a pre-existing issue, but can the NCR update programmed here be
lost?  gem_set_hwtst() does its read-modify-write under bp->lock:

	spin_lock_irqsave(&bp->lock, flags);
	regval = macb_readl(bp, NCR);
	regval = (regval & ~ncr_mask) | ncr_bits;
	macb_writel(bp, NCR, regval);

while macb_mac_link_up() in macb_main.c drops bp->lock and then touches the
same register with no lock held:

	spin_unlock_irqrestore(&bp->lock, flags);
	...
	/* Enable Rx and Tx; Enable PTP unicast */
	ctrl = macb_readl(bp, NCR);
	if (gem_has_ptp(bp))
		ctrl |= MACB_BIT(PTPUNI);

	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

gem_set_hwtst() runs from ndo_hwtstamp_set under rtnl, and
macb_mac_link_up() from the phylink resolve worker under phylink's
state_mutex, so the two are not serialised against each other:

CPU0 (phylink resolve)          CPU1 (SIOCSHWTSTAMP)
ctrl = macb_readl(bp, NCR);
                                spin_lock_irqsave(&bp->lock);
                                macb_writel(bp, NCR, ... SRTSM/OSSMODE ...);
                                bp->tstamp_config = *tstamp_config;
                                spin_unlock_irqrestore(&bp->lock);
macb_writel(bp, NCR, ctrl | RE | TE);

Does that leave the hardware bit disagreeing with bp->tstamp_config, i.e.
the same "the bit does not follow the currently selected filter" symptom
the changelog describes, now for SRTSM as well as OSSMODE?  Would moving
the RE/TE/PTPUNI update in macb_mac_link_up() inside bp->lock be the right
fix, so all NCR read-modify-writes share one lock?

[Severity: Medium]
This isn't a bug introduced by this patch either, but what happens to these
bits across suspend/resume?  macb_resume() in macb_main.c blanks the
register:

	macb_writel(bp, NCR, MACB_BIT(MPE));
	macb_init_hw(bp);

which clears OSSMODE and SRTSM, and macb_init_hw() only programs NCFGR and
the DMA registers.  Grepping the driver, the only writer of GEM_TXBDCTRL
and GEM_RXBDCTRL is gem_set_hwtst():

	gem_writel(bp, TXBDCTRL, GEM_BF(TXTSMODE, tx_bd_control));
	gem_writel(bp, RXBDCTRL, GEM_BF(RXTSMODE, rx_bd_control));

and the re-invoked gem_ptp_init() only restores the timer/TSU and registers
the PTP clock.

bp->tstamp_config survives suspend, so gem_get_hwtst() keeps returning the
old tx_type and rx_filter:

	*tstamp_config = bp->tstamp_config;

while the descriptors no longer carry timestamps, so RX frames get no
hwtstamp attached and every timestamped transmit ends in:

	if (!GEM_BFEXT(DMA_TXVALID, desc->ctrl)) {
		dev_warn_ratelimited(&bp->pdev->dev, "Timestamp not set in TX BD as expected\n");
		return;
	}

with skb_tstamp_tx() never called and no error reported to userspace.  Since
SRTSM is now derived strictly from the cached filter, does this patch extend
that cached-versus-hardware divergence to SRTSM too, and should the resume
path re-apply bp->tstamp_config?

>  	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
>  	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
>  	int rx_filter = tstamp_config->rx_filter;
> @@ -429,7 +429,6 @@ int gem_set_hwtst(struct net_device *netdev,
>  	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>  		rx_bd_control = TSTAMP_ALL_PTP_FRAMES;
>  		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> -		ncr_mask |= MACB_BIT(SRTSM);
>  		ncr_bits |= MACB_BIT(SRTSM);
>  		break;

[Severity: Medium]
This is pre-existing and not introduced here, but are these PTPv2 filters
reachable through the advertised capabilities?  gem_get_ts_info() in
macb_main.c reports only:

	info->rx_filters =
		(1 << HWTSTAMP_FILTER_NONE) |
		(1 << HWTSTAMP_FILTER_ALL);

yet this switch accepts all nine HWTSTAMP_FILTER_PTP_V2_* values, programs
distinct hardware state for them (rx_bd_control = TSTAMP_ALL_PTP_FRAMES plus
NCR.SRTSM), normalises rx_filter to HWTSTAMP_FILTER_PTP_V2_EVENT, caches it
in bp->tstamp_config and returns it to userspace.  gem_get_hwtst() then
reports PTP_V2_EVENT as active, a filter ethtool -T says is unsupported.

Should gem_get_ts_info() advertise the PTPv2 bits, or should gem_set_hwtst()
reject them with -ERANGE?  This matters for the patch because the newly
unconditional SRTSM clear is only observable on transitions to and from
those unadvertised PTPv2 filters.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296%40khu.ac.kr
