Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575474A8410
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145269; cv=none; b=q0NH1dUGR+Raow3js/p4/++wqBi5KKQTHVeyPj3/XLFPsV3kHoWPdHTLSqHR/SK62AlgbO22SOFUBx8i6BLR//TM+MPKf+TSYlsmftaIEl2DZU2LTY5OA0v7qOS1WE1kvobZfyAYamX6ljzHzq1EU6Ghmytqafp51zZnpL9Nu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145269; c=relaxed/simple;
	bh=GQ2BH03BsV0QKZ1n0yPFzr5IFeOCbgiNfPSpUVuIC/8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hPNLAWNSvCNn+S89lDVGPqHoo1jtHlIAipVdsg0IyVdd9dsrBUvcQjezgY7hnvVSuUWVSreH9DPXv/CxwQXBziMqr3tfBMAXiHyBPpgQRnZHXoziR0q39VA2mnuhTh3hCil5oJcF4Rq87pCBfg/cm947oBkdhByvOguA4XDQFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0Z0L7x5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0Z0L7x5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA901F000FF;
	Fri, 11 Sep 2026 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145265;
	bh=M0kDMXEVgIwGeB9zKRM3MYwNmgd7lB+AIJRnR1JFGdE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q0Z0L7x5Dq+1+bKoW0r76+L4uMzQnbgVOiaLpzAFV9IFYTPmMofny/8OOh9d83pwm
	 8/PVZHez1g7gnVIkKvmaqQfoxJG4yVYDZYWnGqEQhu0xO7tDrMP6QtL3QTFlinVRM4
	 zmTxnsw7rcK53myNHlYmEye+/WnYf9cuEFdNo7coe9J3JPUAIKcOLwnW3paS/dSwx8
	 3FeeLb6AzD6jKxxyQjsm07PSZzI8ITXqNpFutj4IfgBrJuLRuD7kmXSXgX9s3Amy5o
	 IojMIfVZkgkwexAJmBfukegx2uHFvPWJh0iqW9cN+Yj+sjtB7YqpIkvBTNV1GFAkhN
	 4vj0p5Yty8S/Q==
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, rayagond@vayavyalabs.com, treding@nvidia.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Fri, 11 Sep 2026 16:47:43 +0000
Message-ID: <178914526371.219967.12944153736114258641@kernel.org>
In-Reply-To:
 <20260910-stmmac-ptp-error-propagate-v3-1-4f386e8256b6@oss.qualcomm.com>
References:
 <20260910-stmmac-ptp-error-propagate-v3-1-4f386e8256b6@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 4 · Low: 0

- [Medium] The `!priv->plat->clk_ptp_rate` -> -EINVAL guard is deleted
  from stmmac_init_tstamp_counter()…
- [Medium] stmmac_hwtstamp_set() (stmmac_main.c:656) and
  stmmac_hwtstamp_get() (stmmac_main.c:846) now reject hardware…
- [Medium] stmmac_update_subsecond_increment() now returns the
  stmmac_config_addend() error, but by the time that error is produced…
- [Medium] Making stmmac_setup_ptp() failure abort __stmmac_open() adds a
  new route by which open fails *after* a preceding __stmmac_release()…

--

net: stmmac: propagate PTP init failures in __stmmac_open() and stmmac_resume()

This makes stmmac_setup_ptp() return an error code and propagates PTP
setup failures out of __stmmac_open() and stmmac_resume(), stopping the
DMA engines on failure.  It also propagates the addend and system time
programming errors out of stmmac_update_subsecond_increment() and
stmmac_init_tstamp_counter(), and adds a stmmac_check_timestamp_cap()
helper used to gate the timestamping paths.

Link to v2: https://lore.kernel.org/r/20260907-stmmac-ptp-error-propagate-v2-1-4a2e8e41e860@oss.qualcomm.com
Link to v1: https://lore.kernel.org/r/20260904-stmmac-ptp-error-propagate-v1-1-80f01b03dafa@oss.qualcomm.com

A few questions on the new capability gate and on the newly propagated
errors below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 7582fca637419..0a00490832f3c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -419,6 +419,17 @@ int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
>  
>  struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev);
>  
> +static inline bool stmmac_check_timestamp_cap(struct stmmac_priv *priv)
> +{
> +	if (!priv->dma_cap.time_stamp && !priv->dma_cap.atime_stamp)
> +		return false;
> +
> +	if (!priv->plat->clk_ptp_rate)
> +		return false;
> +
> +	return true;
> +}
> +
>  static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
>  {
>  	return !!priv->xdp_prog;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5fe7e95fdd345..7f5ada1132c41 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -601,7 +601,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
>  	}
>  }
>  
> -static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
> +static int stmmac_update_subsecond_increment(struct stmmac_priv *priv)
>  {
>  	bool xmac = dwmac_is_xmac(priv->plat->core_type);
>  	u32 sec_inc = 0;
> @@ -625,7 +625,7 @@ static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
>  	 */
>  	temp = (u64)(temp << 32);
>  	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
> -	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
> +	return stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
>  }
>  
>  /**
> @@ -653,7 +653,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  	u32 ts_master_en = 0;
>  	u32 ts_event_en = 0;
>  
> -	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> +	if (!stmmac_check_timestamp_cap(priv)) {
>  		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
>  		priv->hwts_tx_en = 0;
>  		priv->hwts_rx_en = 0;
> @@ -843,7 +843,7 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> -	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
> +	if (!stmmac_check_timestamp_cap(priv))
>  		return -EOPNOTSUPP;
>  
>  	*config = priv->tstamp_config;

[Severity: Medium]
Should the advertising side of this uAPI learn about the new
clk_ptp_rate requirement too?

Before this change stmmac_hwtstamp_get() used a predicate identical to
stmmac_get_ts_info() in stmmac_ethtool.c, so the two agreed.  That
function still keys on the dma_cap bits alone:

drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c:stmmac_get_ts_info() {
	if ((priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {

		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
					SOF_TIMESTAMPING_TX_HARDWARE |
					SOF_TIMESTAMPING_RX_HARDWARE |
					SOF_TIMESTAMPING_RAW_HARDWARE;
	...
}

On the platform class the commit message describes as "PTP-capable
silicon but an unconfigured PTP clock", where plat->clk_ptp_rate ends up
0, does ethtool -T then keep claiming full hardware timestamping and the
complete rx_filters/tx_types bitmaps while every SIOCSHWTSTAMP and
SIOCGHWTSTAMP returns -EOPNOTSUPP?

The commit message says the helper is applied to the get/set paths "so
they consistently report -EOPNOTSUPP when timestamping is not usable" -
should stmmac_get_ts_info() be part of that consistency?

While looking at that function, when no PHC is registered it reports
info->phc_index = 0, which is a valid index owned by some other device.
Is that intended?

> @@ -865,32 +865,32 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
>  				      u32 systime_flags)
>  {
>  	struct timespec64 now;
> -
> -	if (!priv->plat->clk_ptp_rate) {
> -		netdev_err(priv->dev, "Invalid PTP clock rate");
> -		return -EINVAL;
> -	}
> +	int ret;

[Severity: Medium]
Is the new gate a full replacement for this guard, given the ordering?

This was the only clk_ptp_rate validation that ran after
priv->plat->ptp_clk_freq_config().  stmmac_check_timestamp_cap() is
evaluated in stmmac_setup_ptp() and in stmmac_resume() before
stmmac_init_timestamping() invokes the platform hook, and that hook can
rewrite the very value the gate sampled:

drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c:ethqos_ptp_clk_freq_config() {
	/* Max the PTP ref clock out to get the best resolution possible */
	err = clk_set_rate(plat_dat->clk_ptp_ref, ULONG_MAX);
	if (err)
		netdev_err(priv->dev, "Failed to max out clk_ptp_ref: %d\n", err);
	plat_dat->clk_ptp_rate = clk_get_rate(plat_dat->clk_ptp_ref);
}

Note that clk_ptp_rate is stored even when clk_set_rate() failed.  With
the guard gone, nothing revalidates the post-hook value before it is
used as a divisor:

__stmmac_open()
  stmmac_setup_ptp()			<- gate uses probe-time rate
    stmmac_init_timestamping()
      priv->plat->ptp_clk_freq_config()	<- rate rewritten here
      stmmac_init_tstamp_counter()
        stmmac_update_subsecond_increment()
          stmmac_config_sub_second_increment(priv, priv->ptpaddr,
                                             priv->plat->clk_ptp_rate, ...)
          priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);

If the post-hook rate is 0, can this divide by zero, or on arm64 where
udiv yields 0 program PTP_SSIR = 0 and addend = 0 while
stmmac_setup_ptp() returns 0 and stmmac_ptp_register() exposes a PHC
whose counter never advances?  That is the non-running counter state the
commit message says it eliminates.

There is also the mirror case: on a platform whose probe-time
clk_get_rate() reads 0 but whose ptp_clk_freq_config() hook would
program a valid rate, does the hook now never run at all, so the port is
permanently reported as PTP-less where before it configured itself at
first open?

>  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
>  	priv->systime_flags = systime_flags;
>  
> -	stmmac_update_subsecond_increment(priv);
> +	ret = stmmac_update_subsecond_increment(priv);
> +	if (ret)
> +		return ret;
>  
>  	/* initialize system time */
>  	ktime_get_real_ts64(&now);
>  
>  	/* lower 32 bits of tv_sec are safe until y2106 */
> -	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec);
> -
> -	return 0;
> +	return stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
> +				   now.tv_nsec);
>  }

[ ... ]

> @@ -900,11 +900,6 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
>  	if (priv->plat->ptp_clk_freq_config)
>  		priv->plat->ptp_clk_freq_config(priv);
>  
> -	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
> -		netdev_info(priv->dev, "PTP not supported by HW\n");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
>  					       PTP_TCR_TSCFUPDT);
>  	if (ret) {
> @@ -937,22 +932,39 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
>  	return 0;
>  }
>  
> -static void stmmac_setup_ptp(struct stmmac_priv *priv)
> +static int stmmac_setup_ptp(struct stmmac_priv *priv)
>  {
>  	int ret;
>  
> +	if (!stmmac_check_timestamp_cap(priv)) {
> +		netdev_info(priv->dev, "PTP not supported\n");
> +		return 0;
> +	}
> +
>  	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		netdev_warn(priv->dev,
>  			    "failed to enable PTP reference clock: %pe\n",
>  			    ERR_PTR(ret));
> +		return ret;
> +	}
>  
> -	if (stmmac_init_timestamping(priv) == 0)
> -		stmmac_ptp_register(priv);
> +	ret = stmmac_init_timestamping(priv);
> +	if (ret) {
> +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> +		return ret;
> +	}
> +
> +	stmmac_ptp_register(priv);
> +
> +	return 0;
>  }
>  
>  static void stmmac_release_ptp(struct stmmac_priv *priv)
>  {
> +	if (!stmmac_check_timestamp_cap(priv))
> +		return;
> +
>  	stmmac_ptp_unregister(priv);
>  	clk_disable_unprepare(priv->plat->clk_ptp_ref);
>  }
> @@ -4161,10 +4173,12 @@ static int __stmmac_open(struct net_device *dev,
>  	ret = stmmac_hw_setup(dev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -		goto init_error;
> +		return ret;
>  	}
>  
> -	stmmac_setup_ptp(priv);
> +	ret = stmmac_setup_ptp(priv);
> +	if (ret)
> +		goto ptp_error;

[Severity: Medium]
Can this new failure route leave the clk_ptp_ref enable/prepare count
below zero?

stmmac_change_mtu() releases and reopens the interface, and on reopen
failure it only frees the new dma_conf while the netdev stays up:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_change_mtu() {
	__stmmac_release(dev);

	ret = __stmmac_open(dev, dma_conf);
	if (ret) {
		free_dma_desc_resources(priv, dma_conf);
		kfree(dma_conf);
		netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
		return ret;
	}
}

So with a PTP programming failure, for example an init_systime() or
config_addend() poll timeout:

__stmmac_release() -> stmmac_release_ptp() -> clk_disable_unprepare()   (count 0)
__stmmac_open() -> stmmac_setup_ptp() -> clk_prepare_enable()           (count 1)
                   stmmac_init_timestamping() fails
                   clk_disable_unprepare()                             (count 0)
                   goto ptp_error, error returned, netdev still up
later ip link set down -> __stmmac_release() -> stmmac_release_ptp()
                       -> clk_disable_unprepare()                      (count 0 already)

Since stmmac_release_ptp() decides purely from the re-evaluated
capability predicate, and dma_cap plus clk_ptp_rate are unchanged, does
the second clk_disable_unprepare() hit WARN_ON(core->enable_count == 0)
and underflow prepare_count?  A system suspend in the same window looks
like it reaches the same double disable through
stmmac_pltfr_noirq_suspend(), which now disables clk_ptp_ref whenever
netif_running() and the predicate are true.

Given the Fixes: 0ad2be79f254 ("net: stmmac: Balance PTP reference clock
enable/disable") tag, would tracking whether the clock was actually
acquired, or tearing the interface down when the reopen fails, be a
better fit than keying the disable off the capability predicate?

>  
>  	stmmac_init_coalesce(priv);
>  
> @@ -4189,7 +4203,10 @@ static int __stmmac_open(struct net_device *dev,
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
>  	stmmac_release_ptp(priv);
> -init_error:
> +ptp_error:
> +	stmmac_stop_all_dma(priv);
> +	stmmac_mac_set(priv, priv->ioaddr, false);
> +
>  	return ret;
>  }
>  
> @@ -7685,9 +7702,7 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  	/* In Coarse mode, we can use a smaller subsecond increment, let's
>  	 * reconfigure the systime, subsecond increment and addend.
>  	 */
> -	stmmac_update_subsecond_increment(priv);
> -
> -	return 0;
> +	return stmmac_update_subsecond_increment(priv);
>  }

[Severity: Medium]
Should the software state be rolled back when this now-propagated error
fires?

By the time the error is produced, stmmac_dl_ts_coarse_set() has already
committed priv->tsfupdt_coarse and flipped PTP_TCR_TSCFUPDT in
priv->systime_flags, and stmmac_update_subsecond_increment() has already
written PTP_TCR and PTP_SSIR and cached priv->sub_second_inc and
priv->default_addend.  The only failure mode of the addend write is a
poll timeout:

drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c:config_addend() {
	return readl_poll_timeout_atomic(ioaddr + PTP_TCR, value,
					 !(value & PTP_TCR_TSADDREG),
					 10, 100000);
}

so the addend register keeps its previous value while the update-mode
bit and the sub-second increment have been reprogrammed.  In fine update
mode, does the system time counter then advance at a rate matching
neither the old nor the new configuration, with priv->default_addend no
longer describing the register contents?

Also, devlink is told the set failed, but stmmac_dl_ts_coarse_get()
unconditionally reports the already-mutated boolean:

	ctx->val.vbool = priv->tsfupdt_coarse;

so a rejected set reads back as applied.  Would committing
priv->tsfupdt_coarse and priv->systime_flags only after successful
programming, or restoring them on failure, be preferable here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910-stmmac-ptp-error-propagate-v3-1-4f386e8256b6%40oss.qualcomm.com
