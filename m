Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA6473C76;
	Wed, 23 Sep 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197878; cv=none; b=eBKIFhzwHDCsR0azX19NmK9Va5dLIVcjYbms6R90rBh4L1ZShgYiD/kcge70vCNtVeB0ZbShlztoAJ2re3x2Z44iJVCxzP7h9Q9l7gz5C+n/R5i6ZnQTNRk6DuXh8Udi9GjlO0kMhSvZwWfZh6ycMPjIA7lPUYZfmk5mnlvIf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197878; c=relaxed/simple;
	bh=n0Di7QFCDW1ec8zaNrCd0n/Ykeq0YhiRrQLSvTe2vZQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZUSAHup2x2Rs+B5DG0IE7DEz0+3h+3LtLudSBS3h9poo28nrxkG4M5NPPsnhAErszDaHnhzS5FUtshaOvnOkKhMcDRVXVP9+VKWJuqTEtg3+B6Yh7/bqkIGlU7HsOxk9TxgMCkwh9ugtUEgN6V9LpMy/RLUNbPg0zqCgEQ8AWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV5gtvRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV5gtvRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83661F00893;
	Wed, 23 Sep 2026 21:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790197873;
	bh=TGDpbCrBe6z1/4wzNRXJYGG4Dvx4grNkKs4vmUs9dtE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RV5gtvRLREMAjeElbgzRKMVlltWBZHEqHjPfaSltCv+BThUiWQjzorfEGTCge43+c
	 xaOt9tvQ8r9BM+mt3HdDcIbk6r8NmdbfUnjyv5SE8biYwCWilKCTL5hn+PEUuPvrid
	 5OijxXiwHwG+A03ijovLwHF25GemYIS1G9S+RMao+4xv81EtFS+GR4K9hxYRt1oHlM
	 TFJFJIk6s9+ycdRlQ92jzynJRsrhB/nrz37ovDPx+5Y1QmWYhwyoQ3Gj4EwN8ZEMyO
	 e/kKU05ajwpFJZNLiEPSm3Vo4gWnTlJ0z6B2XaEWwkf07peZuqZH6p8Y2voBHA4Nwr
	 Pv2pySXCEUY0g==
Subject: Re: [PATCH net-next 1/4] net: macb: Preserve timestamp settings on
 rejected requests
From: netdev-bot+sashiko@kernel.org
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com, rafalo@cadence.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, nb@tipi-net.de, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 21:11:12 +0000
Message-ID: <179019787253.2160803.7291255810033636268@kernel.org>
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-1-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-1-9d1abaa53296@khu.ac.kr>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete NCR lock coverage: gem_set_hwtst()
  (drivers/net/ethernet/cadence/macb_ptp.c:449-461) now performs its NCR…

Pre-existing issues:
- [Low] (Validated as FIXED LATER IN THIS SERIES — baseline decision
  false.) At this commit gem_set_hwtst() only OR-s MACB_BIT(OSSMODE)…
- [Low] (Validated as having no functional consequence — baseline
  decision false.) bp->tstamp_config is published under bp->lock in…

--

net: macb: Preserve timestamp settings on rejected requests

gem_set_hwtst() used to program the TX one-step-sync bit before validating
the RX filter, so a request rejected with -ERANGE could leave the hardware
out of sync with the cached configuration. The patch validates both the TX
type and the RX filter first, keeps the adjusted RX filter in a local, then
applies TXBDCTRL/RXBDCTRL and the NCR update under bp->lock, dropping the
gem_ptp_set_one_step_sync() and gem_ptp_set_ts_mode() helpers.

(No Link: tags in the commit header.)

> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index 14ae57fa00cba..4dbb6daa6be53 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c

[ ... ]

> @@ -396,25 +386,17 @@ int gem_get_hwtst(struct net_device *netdev,
>  	return 0;
>  }
>  
> -static void gem_ptp_set_one_step_sync(struct macb *bp, u8 enable)
> -{
> -	u32 reg_val;
> -
> -	reg_val = macb_readl(bp, NCR);
> -
> -	if (enable)
> -		macb_writel(bp, NCR, reg_val | MACB_BIT(OSSMODE));
> -	else
> -		macb_writel(bp, NCR, reg_val & ~MACB_BIT(OSSMODE));
> -}
> -
>  int gem_set_hwtst(struct net_device *netdev,
>  		  struct kernel_hwtstamp_config *tstamp_config,
>  		  struct netlink_ext_ack *extack)
>  {
> +	u32 ncr_mask = 0;
>  	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
>  	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
> +	int rx_filter = tstamp_config->rx_filter;
>  	struct macb *bp = netdev_priv(netdev);
> +	unsigned long flags;
> +	u32 ncr_bits = 0;
>  	u32 regval;
>  
>  	if (!macb_dma_ptp(bp))
> @@ -424,18 +406,17 @@ int gem_set_hwtst(struct net_device *netdev,
>  	case HWTSTAMP_TX_OFF:
>  		break;
>  	case HWTSTAMP_TX_ONESTEP_SYNC:
> -		gem_ptp_set_one_step_sync(bp, 1);
> -		tx_bd_control = TSTAMP_ALL_FRAMES;
> -		break;
> +		ncr_bits |= MACB_BIT(OSSMODE);
> +		fallthrough;
>  	case HWTSTAMP_TX_ON:
> -		gem_ptp_set_one_step_sync(bp, 0);
> +		ncr_mask |= MACB_BIT(OSSMODE);
>  		tx_bd_control = TSTAMP_ALL_FRAMES;
>  		break;

[Severity: Low]

This isn't a bug introduced by this patch, but a note on which NCR bits
end up in ncr_mask.

MACB_BIT(OSSMODE) is only added to ncr_mask in the HWTSTAMP_TX_ON arm, and
HWTSTAMP_TX_OFF breaks out without touching ncr_mask, so is a previously
programmed NCR.OSSMODE ever cleared when timestamping is turned off?
MACB_BIT(SRTSM) is likewise only added in the PTPv2 group below, so the
FILTER_NONE, FILTER_ALL and PTPv1 arms leave NCR.SRTSM as it was.

When both switches leave ncr_mask == 0 (tx_type HWTSTAMP_TX_OFF plus
rx_filter HWTSTAMP_FILTER_NONE), the if (ncr_mask) guard further down skips
the NCR write entirely, while TXBDCTRL/RXBDCTRL and bp->tstamp_config are
still updated to the disabled state.

The behaviour matches the pre-patch code, since gem_ptp_set_one_step_sync()
was not called for HWTSTAMP_TX_OFF either and SRTSM was only ever set, so
this is not a new regression. It is also addressed later in the series,
where ncr_mask becomes an unconditional
MACB_BIT(OSSMODE) | MACB_BIT(SRTSM) and the read-modify-write is no longer
guarded, in "net: macb: Disable one-step mode when TX timestamping is off"
and "net: macb: Clear SRTSM outside PTPv2 receive filters".

>  	default:
>  		return -ERANGE;
>  	}
>  
> -	switch (tstamp_config->rx_filter) {
> +	switch (rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		break;
>  	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> @@ -451,25 +432,33 @@ int gem_set_hwtst(struct net_device *netdev,
>  	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>  	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>  	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> -		rx_bd_control =  TSTAMP_ALL_PTP_FRAMES;
> -		tstamp_config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> -		regval = macb_readl(bp, NCR);
> -		macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));
> +		rx_bd_control = TSTAMP_ALL_PTP_FRAMES;
> +		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> +		ncr_mask |= MACB_BIT(SRTSM);
> +		ncr_bits |= MACB_BIT(SRTSM);
>  		break;
>  	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>  	case HWTSTAMP_FILTER_ALL:
>  		rx_bd_control = TSTAMP_ALL_FRAMES;
> -		tstamp_config->rx_filter = HWTSTAMP_FILTER_ALL;
> +		rx_filter = HWTSTAMP_FILTER_ALL;
>  		break;
>  	default:
> -		tstamp_config->rx_filter = HWTSTAMP_FILTER_NONE;
>  		return -ERANGE;
>  	}
>  
> -	bp->tstamp_config = *tstamp_config;
> +	spin_lock_irqsave(&bp->lock, flags);
> +	if (ncr_mask) {
> +		regval = macb_readl(bp, NCR);
> +		regval = (regval & ~ncr_mask) | ncr_bits;
> +		macb_writel(bp, NCR, regval);
> +	}

[Severity: Medium]

The changelog says "Protect the NCR read-modify-write with bp->lock". Do
the other NCR read-modify-write sites in this driver take bp->lock too?

macb_mac_link_up() in macb_main.c does its NCR update after releasing
bp->lock:

	spin_unlock_irqrestore(&bp->lock, flags);
	...
	/* Enable Rx and Tx; Enable PTP unicast */
	ctrl = macb_readl(bp, NCR);
	if (gem_has_ptp(bp))
		ctrl |= MACB_BIT(PTPUNI);

	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

macb_mac_link_down() does the same unlocked:

	/* Disable Rx and Tx */
	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
	macb_writel(bp, NCR, ctrl);

and macb_hresp_error_task() carries an NCR image across the ring and buffer
re-initialisation before writing it back, also without bp->lock.

macb_mac_link_up() and macb_mac_link_down() are reached from
phylink_resolve(), which holds pl->phydev_mutex, phy->lock and
pl->state_mutex, but neither rtnl nor bp->lock:

	phylink_resolve()
	  -> phylink_link_up() -> macb_mac_link_up()
	  -> phylink_link_down() -> macb_mac_link_down()

So can these run concurrently with the rtnl-serialized ndo_hwtstamp_set()
path that ends up here?

If they can, is either of these lost-update outcomes possible?

- the OSSMODE/SRTSM bits just programmed here are erased by the link
  callback writing back its older NCR image, while bp->tstamp_config (what
  gem_get_hwtst() returns) still reports one-step-sync or PTPv2 RX
  filtering as enabled

- MACB_BIT(RE) | MACB_BIT(TE) | MACB_BIT(PTPUNI) from macb_mac_link_up()
  are erased by the write-back here, leaving the MAC receiver and
  transmitter disabled while the carrier stays up until the next link
  transition

macb_hresp_error_task() seems to give the widest window, since the NCR
snapshot is taken before mog_init_rings()/macb_init_buffers() and written
back afterwards. Should these NCR read-modify-writes be brought under
bp->lock as well for the new critical section to actually be exclusive?

>  
> -	if (gem_ptp_set_ts_mode(bp, tx_bd_control, rx_bd_control) != 0)
> -		return -ERANGE;
> +	gem_writel(bp, TXBDCTRL, GEM_BF(TXTSMODE, tx_bd_control));
> +	gem_writel(bp, RXBDCTRL, GEM_BF(RXTSMODE, rx_bd_control));
> +
> +	tstamp_config->rx_filter = rx_filter;
> +	bp->tstamp_config = *tstamp_config;
> +	spin_unlock_irqrestore(&bp->lock, flags);

[Severity: Low]

This is a pre-existing property rather than something this patch
introduces, but does taking bp->lock around the bp->tstamp_config
assignment buy anything with respect to the fast-path readers?

gem_ptp_do_txstamp() and gem_ptp_do_rxstamp() in macb.h read the same
fields from NAPI/softirq context with no lock:

	if (bp->tstamp_config.tx_type == TSTAMP_DISABLED)
		return;
	...
	if (bp->tstamp_config.rx_filter == TSTAMP_DISABLED)
		return;

so a poll running during the update can still observe a new tx_type with
an old rx_filter. Both fields are naturally aligned int members of
struct kernel_hwtstamp_config, so no torn value is possible, and
gem_ptp_rxstamp()/gem_ptp_txstamp() re-check DMA_RXVALID/DMA_TXVALID in the
descriptor, so the worst case looks like one in-flight frame evaluated
against a mixed configuration during reconfiguration. The unlocked
publication predates this patch, which did the assignment with no lock at
all, so this is only a note that the new section is not atomic for those
readers.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296%40khu.ac.kr
