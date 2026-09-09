Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566064921A6
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944786; cv=none; b=fxHlqQ/4qR2aj/XeeV0Es/mO2I4okf7OBKY6z8M3ZUTLuLtf5ET1P2DvswceuS4ZsNYeR+aeCgCdlaZEaZiytUBaMIEdbWyQYZiH3bgh/gfNK8fwMKGucnJWI5u1FyhrTatVYeQxCfgO23jqdhwvlIhWg1FZecPDsy6P8QMnvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944786; c=relaxed/simple;
	bh=Jev1JzEt91ORb5OHLsWSTFXLyjNPmERoXXeEN7gkn30=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWcghEyKfkCfMM+MygsVCDuO0P/5a/BrtpVjJLwORdd/le22K2DDd4ZSkaKi0OS9sweOI8VtBXwg+FyG1/cdiclYhfAIUQi0lZsKR/H+lsd8uXu/aHwe/9rlt2jfZxkPLlhlhKyyxpKqeAi0dTpOFwqo9lpCr5MDhbF3usMn1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+qngh35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+qngh35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519681F00A3E;
	Wed,  9 Sep 2026 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944784;
	bh=wwtkeblvzufsHH+y90/cObbBMVVMEPgv/rcrKemjHNE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i+qngh35KMZePm2OOxmjwxhA5xRno0R4C6eMNA2mGUhO5lCeJnFvb2ZwrZUBYZop8
	 ybpLM2X05ln8Xo9e2Lqqrvjda/yJtAJMkQj0fPd1n1kGW2oGZLmxQlgVaP/EpuXaJf
	 6OVJ1Izg+atsxsHXU111qOP3JUAADg8qvgFMpWf/1rzkSp2D3wwnpU2zplMkLfAxWf
	 bDy90xh5ZZ+YDhU1X2GHZ35JPMBfArWBBhIP2v6U9vkjS9FQoSi+L7Rmd64w+gi80J
	 JexkaMFgx0kqgSOZNaVboq+q+nzTv7RXIXhoIRSj9I9IIlNm3R38dbmNvgyKFvNf3i
	 QWdRzcUsMIXLw==
Subject: Re: [PATCH net] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, rayagond@vayavyalabs.com, treding@nvidia.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 09 Sep 2026 09:06:22 +0000
Message-ID: <178894478282.219967.9123750287154631714@kernel.org>
In-Reply-To:
 <20260904-stmmac-ptp-error-propagate-v1-1-80f01b03dafa@oss.qualcomm.com>
References:
 <20260904-stmmac-ptp-error-propagate-v1-1-80f01b03dafa@oss.qualcomm.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 2

- [High] Undisclosed functional regression: PTP setup failures are now
  fatal to `ndo_open()` and to system resume.
- [Medium] Unbalanced clk_ptp_ref enable/disable against the platform
  noirq PM callbacks.
- [Low] The kernel-doc block above `stmmac_init_timestamping()`
  (stmmac_main.c:893-899) still states 'this is to verify if the HW…
- [Low] Both new unwind paths halt the DMA but never undo
  `stmmac_hw_setup()`'s `stmmac_mac_set(priv, priv->ioaddr, true)`…

Pre-existing issues:
- [High] Pre-existing double free / use-after-free of the DMA descriptor
  rings, whose trigger set this patch widens.

--

net: stmmac: propagate PTP init failures in __stmmac_open() and stmmac_resume()

This converts stmmac_setup_ptp() from void to int so that the PTP
reference clock enable and stmmac_init_timestamping() failures are
propagated, and adds unwind paths in __stmmac_open() and stmmac_resume()
for those failures.  The HW timestamp capability check moves out of
stmmac_init_timestamping() into the new stmmac_check_timestamp_cap()
helper.

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 24656b35350b1..d33c82bd3ee46 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -885,6 +885,11 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
>  	return 0;
>  }
>  
> +static bool stmmac_check_timestamp_cap(struct stmmac_priv *priv)
> +{
> +	return priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp;
> +}
> +
>  /**
>   * stmmac_init_timestamping - initialise timestamping
>   * @priv: driver private structure
> @@ -900,11 +905,6 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
>  	if (priv->plat->ptp_clk_freq_config)
>  		priv->plat->ptp_clk_freq_config(priv);
>  
> -	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
> -		netdev_info(priv->dev, "PTP not supported by HW\n");
> -		return -EOPNOTSUPP;
> -	}
> -

[Severity: Low]
Should the kernel-doc block just above stmmac_init_timestamping() be updated
in the same patch?  It still says:

	 * Description: this is to verify if the HW supports the PTPv1 or PTPv2.
	 * This is done by looking at the HW cap. register.
	 * This function also registers the ptp driver.

After this hunk the HW cap. register check lives in
stmmac_check_timestamp_cap()/stmmac_setup_ptp(), which is also why
stmmac_resume() now has to open-code "if (stmmac_check_timestamp_cap(priv))",
and stmmac_ptp_register() is only called from stmmac_setup_ptp().  The
-EOPNOTSUPP return the description implies is no longer produced by any
path here, and the function's new error returns are not described.

>  	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
>  					       PTP_TCR_TSCFUPDT);
>  	if (ret) {
> @@ -937,22 +937,39 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
>  	return 0;
>  }
>  
> -static void stmmac_setup_ptp(struct stmmac_priv *priv)
> +static int stmmac_setup_ptp(struct stmmac_priv *priv)
>  {
>  	int ret;
>  
> +	if (!stmmac_check_timestamp_cap(priv)) {
> +		netdev_info(priv->dev, "PTP not supported by HW\n");
> +		return 0;
> +	}
> +
>  	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);

[Severity: Medium]
Does this early return unbalance clk_ptp_ref against the platform noirq PM
callbacks?

Before this patch stmmac_setup_ptp() always did clk_prepare_enable() on open
and stmmac_release_ptp() always did clk_disable_unprepare() on close, so a
running interface always held one enable/prepare reference.  With the new
capability gate in both functions, hardware whose dma_cap.time_stamp and
dma_cap.atime_stamp are clear never gets the clock enabled.  Note
stmmac_hw_init() leaves priv->dma_cap all-zero when there is no HW feature
register ("No HW DMA feature register supported").

stmmac_pltfr_noirq_suspend() in stmmac_platform.c still does this
unconditionally for any running non-WoL interface:

	if (!priv->wolopts) {
		/* Disable clock in case of PWM is off */
		clk_disable_unprepare(priv->plat->clk_ptp_ref);

With the enable/prepare counts at zero, does that hit the clk core
enable_count/prepare_count underflow warning?  And after
stmmac_pltfr_noirq_resume() re-enables it unconditionally, the close path
stmmac_release_ptp() now returns early for the same hardware, so does that
reference stay held for good?

These four sites appear to be the only clk_ptp_ref enable/disable users, and
stmmac_pltfr_pm_ops installs those noirq callbacks for a large number of
platform glue drivers.

> -	if (ret < 0)
> +	if (ret < 0) {
>  		netdev_warn(priv->dev,
>  			    "failed to enable PTP reference clock: %pe\n",
>  			    ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = stmmac_init_timestamping(priv);
> +	if (ret) {
> +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> +		return ret;
> +	}
>  
> -	if (stmmac_init_timestamping(priv) == 0)
> -		stmmac_ptp_register(priv);
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
> @@ -4161,10 +4178,12 @@ static int __stmmac_open(struct net_device *dev,
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

[Severity: High]
Can this make "ip link set dev ethX up" fail on configurations that work
today?

stmmac_setup_ptp() -> stmmac_init_timestamping() -> stmmac_init_tstamp_counter()
returns -EINVAL for a zero PTP rate:

	if (!priv->plat->clk_ptp_rate) {
		netdev_err(priv->dev, "Invalid PTP clock rate");
		return -EINVAL;
	}

Before this patch that only produced the "PTP init failed" warning and the
interface still came up without timestamping.

Is "timestamp capable but clk_ptp_rate == 0" a real configuration?
stmmac_register_devlink() already tolerates exactly that combination:

	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp) ||
	    !priv->plat->clk_ptp_rate)
		return 0;

and stmmac_probe_config_dt() derives the rate from a clock that may be NULL:

	if (IS_ERR(plat->clk_ptp_ref)) {
		plat->clk_ptp_rate = clk_get_rate(plat->stmmac_clk);
		plat->clk_ptp_ref = NULL;

with clk_get_rate(NULL) returning 0 (plat->stmmac_clk is left NULL on the
"Cannot get CSR clock" path, and is not fetched at all for
snps,dwc-qos-ethernet-4.10).

On such a board, would the interface become permanently un-openable for
users who never touch PTP or TAPRIO?  The same question applies to
stmmac_resume() below, where the new goto skips netif_device_attach() and
leaves a previously working link down.  Since there are two Fixes: tags this
will be picked up for stable, so it may be worth spelling the behaviour
change out in the changelog, or keeping the failure non-fatal for the
datapath and only refusing the PTP/EST-dependent features.

>  	stmmac_init_coalesce(priv);
>  
> @@ -4187,9 +4206,10 @@ static int __stmmac_open(struct net_device *dev,
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> -
>  	stmmac_release_ptp(priv);
> -init_error:
> +ptp_error:
> +	stmmac_stop_all_dma(priv);
> +
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the new ptp_error exit widens
the set of ways __stmmac_open() can fail after it has already done:

	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));

so priv->dma_conf holds its own copy of every pointer in the caller's
dma_conf.  On the MTU reopen path the caller reacts to failure like this:

stmmac_change_mtu()
	ret = __stmmac_open(dev, dma_conf);
	if (ret) {
		free_dma_desc_resources(priv, dma_conf);
		kfree(dma_conf);

The interface is left administratively up, and priv->dma_conf still points
at the freed dma_alloc_coherent() buffers and the freed tx_skbuff/rx_skbuff
arrays, since nulling pointers inside the caller's copy cannot clear the
memcpy'd copy.  A later "ip link set dev ethX down" then runs:

__stmmac_release()
	stmmac_stop_all_dma(priv);
	/* Release and free the Rx/Tx resources */
	free_dma_desc_resources(priv, &priv->dma_conf);

Does that free the same rings a second time?  The pre-existing trigger was
an stmmac_request_irq() failure via irq_error; with this patch a PTP
reference clock enable failure reaches the same state.

[Severity: Low]
Should this unwind also clear the MAC Rx/Tx enable that stmmac_hw_setup()
set?

stmmac_hw_setup() does:

	/* Enable the MAC Rx/Tx */
	stmmac_mac_set(priv, priv->ioaddr, true);

stmmac_stop_all_dma() only clears the DMA channel start bits and deinits the
channels.  The MAC enable is cleared in the mac_link_down callback, in the
reset path and in stmmac_suspend(), and on the ptp_error path
phylink_start() was never reached, so mac_link_down() cannot run.
stmmac_open() then frees the descriptor rings and drops the runtime-PM
reference, leaving the MAC clock-gated with its Rx/Tx still armed.  All
stmmac_hw_setup() failure returns happen before the stmmac_mac_set() call,
so this residue is specific to the new post-setup failure exits.

> @@ -8326,13 +8346,14 @@ int stmmac_resume(struct device *dev)
>  	ret = stmmac_hw_setup(ndev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -		stmmac_legacy_serdes_power_down(priv);
> -		mutex_unlock(&priv->lock);
> -		rtnl_unlock();
> -		return ret;
> +		goto error_unlock;
>  	}
>  
> -	stmmac_init_timestamping(priv);
> +	if (stmmac_check_timestamp_cap(priv)) {
> +		ret = stmmac_init_timestamping(priv);
> +		if (ret)
> +			goto error_stop_dma;
> +	}
>  
>  	stmmac_init_coalesce(priv);
>  	phylink_rx_clk_stop_block(priv->phylink);
> @@ -8356,6 +8377,15 @@ int stmmac_resume(struct device *dev)
>  	netif_device_attach(ndev);
>  
>  	return 0;
> +
> +error_stop_dma:
> +	stmmac_stop_all_dma(priv);
> +error_unlock:
> +	stmmac_legacy_serdes_power_down(priv);
> +	mutex_unlock(&priv->lock);
> +	rtnl_unlock();
> +
> +	return ret;
>  }

[Severity: Low]
Same question on the resume side: stmmac_suspend() explicitly did

	stmmac_mac_set(priv, priv->ioaddr, false);

but error_stop_dma/error_unlock stops the DMA and calls
stmmac_legacy_serdes_power_down() while the MAC Rx/Tx enabled by
stmmac_hw_setup() is still set, so the SerDes is removed under an enabled
MAC.  Would adding stmmac_mac_set(priv, priv->ioaddr, false) to this unwind
restore the state that stmmac_suspend() had established?

Also, on this path netif_device_attach() is never reached while
netif_running() is still true, so the netdev stays detached after a resume
failure.  Is that the intended outcome for a PTP init error?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-stmmac-ptp-error-propagate-v1-1-80f01b03dafa%40oss.qualcomm.com
