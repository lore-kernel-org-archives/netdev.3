Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4242DA3D
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403983; cv=none; b=foacSGVkL6AK8IOjhura6f7x018FWK/jBzjns7LsJkCVXjyS6BiPE3fWH95B7mWYnH2t8pwT6O78v6Uozhogtj3rYHBAQvAznXCvu9RSKoSs/SIg3rJo/oOYLou4UjVhkhubJPTAffmHUUoVnL/6KtDRVL8pdgPXAF/aJOmDfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403983; c=relaxed/simple;
	bh=JQxIuIP7nvui2ei/GiEX+DGinAjxgQDH6V9QhSCkM48=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWFCVrg4xasZ+JAHd7uoHnTD/arWhef/X//lFVSjpTvfLkrXB1IIIe7A60OfSqKdicTznopmekOvSRi/TPIpt8Bf8NF8vknpqsXaCKoIbsguXwDDot0N/XvbeeDxzviG2fDrbjkmRZ06Ueg0/7TYe9ywETKZvvd9zoJVwHCGnko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9QFQG2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9QFQG2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF381F000FF;
	Wed,  7 Oct 2026 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791403981;
	bh=ddzayZHJwQWYdGnrPkex4Zp4YlGJrbGVoz3iRXkBQ0o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U9QFQG2UDxUWQEfPXl8CJS5VeoxdxOao3ZhrD5wufv1SWNFdKOcmzZ/xHKpp5snFC
	 NS/vRCHTeYc3CXA2+CihxOE2lF5DxRronKLPDS/tqZt4OUOXADxq+/ULI9sZg3Vdir
	 eS1z/oMCv4sbhzyCDmlXmpI1NJ/UoU0BiySnxAzjurmS3O43zdWerdGUDf7YrZmMmA
	 wGgVmgGslR0wDx+jxF62NMsdiYIcZAUXntJ2PNAEwR7VPJgJW4ENg1J067diOtlmrR
	 uvoFfvNfQCVPuZnMRnRB4EjgEgwaXuCCOHEcmyLMIistXCAaKiDSPlt2paH5jQTYuw
	 wr7QJoSgGyAzg==
Subject: Re: [PATCH net v2] net: stmmac: serialize PTP timestamping
 configuration with priv->lock
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, kory.maincent@bootlin.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 07 Oct 2026 20:13:00 +0000
Message-ID: <179140398033.434549.9800494190352310717@kernel.org>
In-Reply-To:
 <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
References:
 <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the devlink path can still race with an
  RTNL-only path on the timestamping state.
- [Low] In stmmac_hwtstamp_set(), the patch moves the
  '!(priv->dma_cap.time_stamp || priv->adv_ts)' -EOPNOTSUPP check after…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  stmmac_dl_ts_coarse_set() does PTP register MMIO with no…
- [Medium] This problem wasn't introduced by this patch, but the PHC
  clock callbacks in stmmac_ptp.c still touch the same PTP registers and…
- [Medium] This problem wasn't introduced by this patch, but the kernel-
  doc of stmmac_init_tstamp_counter() says it 'Will be rerun after…

--

net: stmmac: serialize PTP timestamping configuration with priv->lock

This patch takes priv->lock in both stmmac_dl_ts_coarse_set() and
stmmac_hwtstamp_set(). The goal is to stop the devlink phc_coarse_adj
handler and the SIOCSHWTSTAMP handler from racing on systime_flags,
tsfupdt_coarse and the PTP_TCR programming. It also moves the hardware
capability check in stmmac_hwtstamp_set() under the new lock.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9741f97fa37a2..a6793054a1796 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -685,14 +685,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  	u32 snap_type_sel = 0;
>  	u32 ts_master_en = 0;
>  	u32 ts_event_en = 0;
> -
> -	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> -		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> -		priv->hwts_tx_en = 0;
> -		priv->hwts_rx_en = 0;
> -
> -		return -EOPNOTSUPP;
> -	}
> +	int ret = 0;
>  
>  	if (!netif_running(dev)) {
>  		NL_SET_ERR_MSG_MOD(extack,
> @@ -700,13 +693,23 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  		return -ENODEV;
>  	}
>  
> -	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
> -		   __func__, config->flags, config->tx_type, config->rx_filter);
> -
>  	if (config->tx_type != HWTSTAMP_TX_OFF &&
>  	    config->tx_type != HWTSTAMP_TX_ON)
>  		return -ERANGE;
>  
> +	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
> +		   __func__, config->flags, config->tx_type, config->rx_filter);
> +
> +	mutex_lock(&priv->lock);
> +
> +	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> +		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> +		priv->hwts_tx_en = 0;
> +		priv->hwts_rx_en = 0;
> +		ret = -EOPNOTSUPP;
> +		goto unlock;
> +	}

[Severity: Low]
Was the capability check meant to move after the netif_running() and
tx_type checks? The commit message does not mention this change.

Before this patch, hardware without timestamping support always got
-EOPNOTSUPP with "No support for HW time stamping".

Now, if the interface is down on such hardware, it gets -ENODEV with
"Cannot change timestamping configuration while down". A tx_type other
than OFF/ON gets -ERANGE. HWTSTAMP_TX_ONESTEP_SYNC is one example, and
net_hwtstamp_validate() accepts it.

dev_set_hwtstamp() only checks netif_device_present() before calling into
the driver, so userspace will see the different errno.

The new locking does not seem to need this reordering. Could the
capability check stay first?

[ ... ]

> @@ -859,8 +863,10 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);

[Severity: Medium]
This is a pre-existing issue, but the PHC callbacks in stmmac_ptp.c touch
the same PTP_TCR register and fields under a different lock,
priv->ptp_lock. Taking priv->lock here does not serialize against them.

Three callbacks do a readl/modify/writel of PTP_TCR to set TSADDREG,
TSUPDT or TSINIT:

stmmac_adjust_freq()->config_addend()
stmmac_adjust_time()->adjust_systime()
stmmac_set_time()->init_systime()

For example, config_addend() does:

	value = readl(ioaddr + PTP_TCR);
	value |= PTP_TCR_TSADDREG;
	writel(value, ioaddr + PTP_TCR);

config_hw_tstamping() also does a read-modify-write of PTP_TCR, under
priv->lock only. It is called here and from
stmmac_dl_ts_coarse_set()->stmmac_update_subsecond_increment():

	u32 regval = readl(ioaddr + PTP_TCR);

	regval &= ~STMMAC_HWTS_CFG_MASK;
	regval |= data;

	writel(regval, ioaddr + PTP_TCR);

Suppose a PHC op reads PTP_TCR before this write and writes it back after.
Can that bring back old mode bits such as TSCFUPDT?

If so, config_sub_second_increment() would pick SSIR from the reverted
TCR. The hardware would then no longer match priv->systime_flags and
tsfupdt_coarse.

There are two related unlocked reads:

- stmmac_adjust_freq() reads priv->default_addend with no lock.
- stmmac_enable(PTP_CLK_REQ_PEROUT) reads priv->sub_second_inc and
  priv->systime_flags under ptp_lock, while the writers hold priv->lock.

Can stmmac_enable() see a sub_second_inc and systime_flags pair that do
not match?

>  
>  	priv->tstamp_config = *config;

[Severity: Medium]
This is a pre-existing issue, but the kernel-doc of
stmmac_init_tstamp_counter() says:

 * Will be rerun after resuming from suspend, case in which the timestamping
 * flags updated by stmmac_hwtstamp_set() also need to be restored.

Is that still accurate? stmmac_resume() calls stmmac_init_timestamping().
That function resets the state before it calls
stmmac_init_tstamp_counter():

	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
	priv->systime_flags = STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT;
	priv->tsfupdt_coarse = false;

hwts_tx_en and hwts_rx_en are cleared too. That means the configuration
stored here is lost across suspend/resume, and so is the devlink
phc_coarse_adj setting. Devlink get then reports false.

The reset was added on purpose by commit 232d49dd4b40 ("net: stmmac:
propagate PTP addend and system time programming errors"). Even before
that, systime_flags was overwritten on reinit.

Should the comment or the resume behavior be updated?

> +unlock:
> +	mutex_unlock(&priv->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -7753,9 +7759,12 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  {
>  	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
>  	struct stmmac_priv *priv = dl_priv->stmmac_priv;
> -	u32 systime_flags = priv->systime_flags;
> +	u32 systime_flags;
>  	int ret;
>  
> +	mutex_lock(&priv->lock);
> +
> +	systime_flags = priv->systime_flags;

[Severity: High]
Does this fully close the race described in the commit message?

The devlink set handler holds devl_lock and priv->lock, but not RTNL. The
open path updates the same state while holding only RTNL:

stmmac_open() / stmmac_change_mtu()
  __stmmac_open()
    stmmac_setup_ptp()
      stmmac_init_timestamping()
        stmmac_init_tstamp_counter()
          stmmac_update_subsecond_increment()

stmmac_init_timestamping() does:

	priv->systime_flags = STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT;
	priv->tsfupdt_coarse = false;

It also resets hwts_tx_en, hwts_rx_en and tstamp_config, then programs
PTP_TCR, PTP_SSIR and PTP_TAR. None of this takes priv->lock.

Could this interleaving happen?

CPU0 (devlink phc_coarse_adj=true)
stmmac_dl_ts_coarse_set()
  systime_flags = priv->systime_flags;
  stmmac_update_subsecond_increment()   /* coarse TCR/SSIR/TAR */

CPU1 (ip link set up, or an MTU change)
stmmac_init_timestamping()
  priv->systime_flags = STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT;
  priv->tsfupdt_coarse = false;
  stmmac_init_tstamp_counter()          /* fine mode */

CPU0
  priv->tsfupdt_coarse = ctx->val.vbool;
  priv->systime_flags = systime_flags;

The hardware is then in fine mode, while priv->systime_flags and devlink
get both say coarse. Other orderings can leave sub_second_inc and
default_addend out of step with PTP_TCR.

The commit message says the configuration "is updated under a single
lock", but the open and MTU change paths never take priv->lock. Should
the open path's timestamping reinit also take priv->lock? Another option
is to serialize the devlink setter with RTNL.

>  	if (ctx->val.vbool)
>  		systime_flags &= ~PTP_TCR_TSCFUPDT;
>  	else
> @@ -7768,13 +7777,15 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  	if (ret) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to reconfigure PTP adjustment");
> -		return ret;
> +		goto unlock;
>  	}

[Severity: High]
This is a pre-existing issue, but can stmmac_dl_ts_coarse_set() do PTP
register MMIO while the device clocks are gated?

The devlink param is registered at probe through stmmac_register_devlink(),
and probe ends with pm_runtime_put(). stmmac_release() also calls
pm_runtime_put(), after stmmac_release_ptp() has disabled clk_ptp_ref.
stmmac_runtime_suspend() then gates stmmac_clk and pclk through
stmmac_bus_clks_config(priv, false).

The devlink path has no netif_running() check and no
pm_runtime_resume_and_get(). So with the interface down, or never opened,
this path runs:

devlink dev param set ... name phc_coarse_adj value true cmode runtime
  stmmac_dl_ts_coarse_set()
    stmmac_update_subsecond_increment()
      config_hw_tstamping()
        readl(ioaddr + PTP_TCR)

On many ARM SoCs, could this trigger an external abort or a bus hang?

On platforms where the access does not fault, the TSADDREG handshake can
busy-wait in readl_poll_timeout_atomic() for up to 100 ms. With this patch
that wait happens while holding priv->lock.

stmmac_hwtstamp_set() refuses to run while the interface is down. The MDIO
accessors take a runtime PM reference before doing MMIO. Should the
devlink setter do one of these too?

This goes back to commit 6920fa0c764d, and the added priv->lock does not
change it.

>  
>  	priv->tsfupdt_coarse = ctx->val.vbool;
>  	priv->systime_flags = systime_flags;
> +unlock:
> +	mutex_unlock(&priv->lock);
>  
> -	return 0;
> +	return ret;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45%40oss.qualcomm.com
