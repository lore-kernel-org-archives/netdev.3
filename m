Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F34DA9B8;
	Thu, 24 Sep 2026 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284451; cv=none; b=XfBMoOgetyIa6itmF8f96IZqPjpsxVKDKbUH6tKr1TcM65zN8/KENybZaP49aFqEKnvICRdHhukaRXiE4Dcp0o9VtfazfNjd1PokqmWVrrILZS226L/VTpfgbyVqbjUKdd4MXqIp7KC+/OIMCDWUSmWTLMWqB+fKyFnLDcFJOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284451; c=relaxed/simple;
	bh=plqFrqty/+pubJn1dHXjldbKqgth+rPlKlFqIxFmqEE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QfYj5dntg1VouqbF4d0GIM/tFdy1PmozOrOF40MSbcxQ4jMAlvERPCCGPABWYXtlWF6fpT8XiK+3Z8BvyEHVgPWXAp6PZuXtlzH85VrBazGZUIMGNKQBlTZrTEpk9dCtwX7SKDXS4SvKfcfm9Zi7Z69YmeK9HFzvwlWlxeVaAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0+gwX1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0+gwX1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C12F1F000FF;
	Thu, 24 Sep 2026 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790284447;
	bh=wzFeuEwFzk2gNNE3auknBOthNjhMJtaPjRBIKenQU3E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m0+gwX1PK6vkC5Oh4HWmhrs38RhjM23Zu0Zyk6NhiMYBFzbZ5PwETQegG9toK01LZ
	 ghCwL6jvSDjS0H5dDt5U+PfpCjjXYwnTa3ivpdAcs812LlSdOaZg0o0QDUKU+FWtEa
	 OEr5ghz+Gh+pUGfG+esiWhreBQOqpW3jqULBWVAGYwIEWsqHCel5pTllw8K6BYKaAG
	 pl+9LnAJpMAWunFis50ApprQ6tKKZwqGKg7UKrlsMFPOmM5nRqVBB75K5S8yvJaDg9
	 DEvLxa29yF8/RK56aTymAe5c+2DpZAaMtgl3v/lWxLL+CwSV2Ipwb0BCcba9fAzuz0
	 A4jjCCJCQ3KyQ==
Subject: Re: [PATCH net-next v2 1/3] net: macb: Preserve timestamp settings on
 rejected requests
From: netdev-bot+sashiko@kernel.org
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com, rafalo@cadence.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, nb@tipi-net.de, linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 21:14:05 +0000
Message-ID: <179028444580.2160803.8225052097255780320@kernel.org>
In-Reply-To: <20260923-macb-hwtstamp-rework-v2-1-75c909b2676d@khu.ac.kr>
References: <20260923-macb-hwtstamp-rework-v2-1-75c909b2676d@khu.ac.kr>
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

Critical: 0 · High: 0 · Medium: 1 (3) · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] gem_set_hwtst() in drivers/net/ethernet/cadence/macb_ptp.c now
  claims to protect the NCR read-modify-write (the OSSMODE/SRTSM update)…

Pre-existing issues:
- [Medium] NCR PTP bits stay set on accepted requests in gem_set_hwtst()
  (drivers/net/ethernet/cadence/macb_ptp.c).
- [Medium] In this patch, gem_set_hwtst() accepts
  HWTSTAMP_FILTER_PTP_V1_L4_SYNC and HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ…
- [Medium] macb_resume() in drivers/net/ethernet/cadence/macb_main.c
  overwrites NCR with `macb_writel(bp, NCR, MACB_BIT(MPE))`, which…
- [Low] gem_get_ts_info() in drivers/net/ethernet/cadence/macb_main.c
  advertises only `(1 << HWTSTAMP_FILTER_NONE) | (1 <<…
- [Low] gem_set_hwtst() now updates bp->tstamp_config with a whole-struct
  copy under bp->lock.

--

net: macb: Preserve timestamp settings on rejected requests

This commit reworks gem_set_hwtst() to validate both the TX type and the
RX filter before touching any register. The adjusted RX filter is kept
local until validation succeeds. The NCR read-modify-write, the
TXBDCTRL/RXBDCTRL writes and the cache update are then done together
under bp->lock.

> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index 14ae57fa00cba..02face93a53a1 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c

[ ... ]

> @@ -424,18 +406,19 @@ int gem_set_hwtst(struct net_device *netdev,
>  	case HWTSTAMP_TX_OFF:
>  		break;

[Severity: Medium]
This isn't a bug introduced by this patch, but should HWTSTAMP_TX_OFF also
add OSSMODE to ncr_mask?

Only HWTSTAMP_TX_ON clears OSSMODE here. If a ONESTEP_SYNC request is
followed by a TX_OFF request, NCR.OSSMODE stays set. At the same time,
TXBDCTRL is programmed as TSTAMP_DISABLED and bp->tstamp_config.tx_type
reports HWTSTAMP_TX_OFF.

In this patch, SRTSM has the same history dependence. ncr_mask starts at
0 and SRTSM is only added in the PTP_V2 branch. The if (ncr_mask) guard
also skips the NCR write entirely for TX_OFF with a non-V2 filter. So a
V2_EVENT -> NONE/ALL transition leaves SRTSM set.

The SRTSM half is fixed later in the series by "net: macb: Clear SRTSM
outside PTPv2 receive filters". That patch starts ncr_mask at
MACB_BIT(SRTSM) and drops the guard. The OSSMODE half still appears to be
there at the end of the series.

This patch already rewrites the logic into the mask/bits scheme. Would an
unconditional ncr_mask |= MACB_BIT(OSSMODE) cover it?

>  	case HWTSTAMP_TX_ONESTEP_SYNC:
> -		gem_ptp_set_one_step_sync(bp, 1);
> +		ncr_bits |= MACB_BIT(OSSMODE);
> +		ncr_mask |= MACB_BIT(OSSMODE);
>  		tx_bd_control = TSTAMP_ALL_FRAMES;
>  		break;
>  	case HWTSTAMP_TX_ON:
> -		gem_ptp_set_one_step_sync(bp, 0);
> +		ncr_mask |= MACB_BIT(OSSMODE);
>  		tx_bd_control = TSTAMP_ALL_FRAMES;
>  		break;
>  	default:
>  		return -ERANGE;
>  	}
>  
> -	switch (tstamp_config->rx_filter) {
> +	switch (rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		break;
>  	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:

[Severity: Medium]
This is a pre-existing issue, but the two V1 L4 filters below are accepted
with a bare break:

	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
		break;
	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
		break;

rx_bd_control stays TSTAMP_DISABLED, so RXBDCTRL is programmed as
disabled. The non-zero filter is still returned to the caller unchanged
and stored in bp->tstamp_config.

Won't gem_ptp_do_rxstamp() then treat RX stamping as enabled, while no RX
timestamps are actually delivered?

This looks to be resolved later in the series by "net: macb: Enable RX
timestamping for specific PTPv1 filters". There, both cases fall through
to the HWTSTAMP_FILTER_ALL branch.

> @@ -451,25 +434,33 @@ int gem_set_hwtst(struct net_device *netdev,
>  	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>  	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>  	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> -		rx_bd_control =  TSTAMP_ALL_PTP_FRAMES;
> -		tstamp_config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> -		regval = macb_readl(bp, NCR);
> -		macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));
> +		rx_bd_control = TSTAMP_ALL_PTP_FRAMES;
> +		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;

[Severity: Low]
This isn't a bug introduced by this patch, but gem_get_ts_info() in
macb_main.c only advertises these filters:

	info->rx_filters =
		(1 << HWTSTAMP_FILTER_NONE) |
		(1 << HWTSTAMP_FILTER_ALL);

gem_set_hwtst() accepts nine PTP V2 filters. For them it programs
TSTAMP_ALL_PTP_FRAMES plus SRTSM and reports HWTSTAMP_FILTER_PTP_V2_EVENT
back to the caller.

Should HWTSTAMP_FILTER_PTP_V2_EVENT be listed in rx_filters, so that
ethtool -T matches what the setter applies?

> +		ncr_mask |= MACB_BIT(SRTSM);
> +		ncr_bits |= MACB_BIT(SRTSM);
>  		break;

[ ... ]

> -	bp->tstamp_config = *tstamp_config;
> +	spin_lock_irqsave(&bp->lock, flags);
> +	if (ncr_mask) {
> +		regval = macb_readl(bp, NCR);
> +		regval = (regval & ~ncr_mask) | ncr_bits;
> +		macb_writel(bp, NCR, regval);
> +	}

[Severity: Medium]
The commit message says "Protect the NCR read-modify-write with bp->lock".
Does bp->lock actually serialise this against the other NCR writers?

Some NCR read-modify-write paths in macb_main.c don't take bp->lock. They
could write back a stale NCR value and drop the OSSMODE/SRTSM bits set
here.

macb_mac_link_up() releases bp->lock before it updates NCR. It runs from
phylink's resolve work, not under RTNL:

	spin_unlock_irqrestore(&bp->lock, flags);
	...
	/* Enable Rx and Tx; Enable PTP unicast */
	ctrl = macb_readl(bp, NCR);
	if (gem_has_ptp(bp))
		ctrl |= MACB_BIT(PTPUNI);

	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

macb_hresp_error_task() is queued on system_bh_wq from
macb_interrupt_misc() on HRESP. It saves NCR, reinitialises the rings and
buffers, and then writes the saved value back, all without bp->lock:

	ctrl = macb_readl(bp, NCR);
	ctrl &= ~(MACB_BIT(RE) | MACB_BIT(TE));
	macb_writel(bp, NCR, ctrl);
	...
	ctrl |= MACB_BIT(RE) | MACB_BIT(TE);
	macb_writel(bp, NCR, ctrl);

One possible interleaving:

CPU1 (macb_mac_link_up() or macb_hresp_error_task())
  ctrl = macb_readl(bp, NCR);          /* OSSMODE == 0 */

CPU2 (gem_set_hwtst(), HWTSTAMP_TX_ONESTEP_SYNC)
  spin_lock_irqsave(&bp->lock, flags);
  macb_writel(bp, NCR, regval);        /* OSSMODE == 1 */
  bp->tstamp_config = *tstamp_config;
  spin_unlock_irqrestore(&bp->lock, flags);

CPU1
  macb_writel(bp, NCR, ctrl | ...);    /* OSSMODE == 0 again */

At this point the setter has returned 0 and bp->tstamp_config says
one-step is active. The TX completion path skips TX timestamp reporting
for one-step Sync frames via ptp_one_step_sync(), but the MAC no longer
inserts originTimestamp.

spin_lock_irqsave() only disables interrupts on the local CPU, so it does
not exclude these paths when they run on another CPU.

Do these other NCR read-modify-write sites also need bp->lock, or some
other shared serialisation, for this protection to hold?

>  
> -	if (gem_ptp_set_ts_mode(bp, tx_bd_control, rx_bd_control) != 0)
> -		return -ERANGE;
> +	gem_writel(bp, TXBDCTRL, GEM_BF(TXTSMODE, tx_bd_control));
> +	gem_writel(bp, RXBDCTRL, GEM_BF(RXTSMODE, rx_bd_control));
> +
> +	tstamp_config->rx_filter = rx_filter;
> +	bp->tstamp_config = *tstamp_config;

[Severity: Low]
This is a pre-existing issue, but the packet-path readers of this cache
don't take bp->lock. gem_ptp_do_txstamp() is called from
macb_tx_complete() under queue->tx_ptr_lock, and gem_ptp_do_rxstamp() is
called from gem_rx(). Both are in macb.h and use plain loads:

	if (bp->tstamp_config.tx_type == TSTAMP_DISABLED)
		return;
	...
	if (bp->tstamp_config.rx_filter == TSTAMP_DISABLED)
		return;

The writer and the readers share no lock. Is this a data race that KCSAN
would report?

During a reconfiguration, readers may also see the new cached mode before
or after the register writes take effect. Before this patch the store had
no lock at all.

> +	spin_unlock_irqrestore(&bp->lock, flags);
>  
>  	return 0;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but does the cached config
stay in sync with the hardware across suspend/resume?

macb_resume() in macb_main.c overwrites NCR, which clears OSSMODE and
SRTSM:

	macb_writel(bp, NCR, MACB_BIT(MPE));
	macb_init_hw(bp);
	...
	if (bp->ptp_info)
		bp->ptp_info->ptp_init(netdev);

gem_ptp_init() sets up the clock info, timer and TSU and registers the
PTP clock. It never reapplies NCR, TXBDCTRL or RXBDCTRL from
bp->tstamp_config.

After resume, gem_get_hwtst() can report a mode the hardware no longer
has, such as HWTSTAMP_TX_ONESTEP_SYNC or HWTSTAMP_FILTER_PTP_V2_EVENT.

With one-step PTP, won't the MAC stop inserting originTimestamp until
the configuration is set again?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-macb-hwtstamp-rework-v2-0-75c909b2676d%40khu.ac.kr
