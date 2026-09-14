Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456240B373
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374857; cv=none; b=uWgDsuPbcbrh+n6quHdRRT0UmVFDffX7siMP2LFgUuqMiZgyEZcW28AJYRWbJYSschKQqH06w+NgZhn67ytuqUf0tJ8MlCZ/jmw70bcKIBFhNhCdraiQPzH6iFKeABL4M26Qc5yCmg02/c8w408BY0E9gdmbL9x9Nl+CWX6P9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374857; c=relaxed/simple;
	bh=Uu+oiFXchidk8D1lUPv93mJ6OCZhXrni+6dCH5G2OVg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nReUrHbsDoAUje93rGFarkrwiLtyhsFWbjXwJYQosIAWIBji9692o7FhWQHBBBP8lsnX01Ddw8zb7cHwcOAWwZxIYBCkG6nzfTkaLyzenQ65g4PxuZgDV+RhypijbWVPa91+U7cEpsYMkvdPm9SMDGTyLM9ZpjzsLYX7D83qlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm0NbYTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm0NbYTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1B71F000FF;
	Mon, 14 Sep 2026 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789374855;
	bh=t9H+mXiJ6TDKvzBHHi4QZY3kNEc1Ucx1P6810cOCEt8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xm0NbYTqXq5KB5LSQ/FFL+CAPHA/mEFDgOEySrh3+YpIfDYoJzUX6oo4L7muNl4Od
	 y26ZZNquK5QId63bk8aH3/zkBoC9yJCs6GBfF8+pA/rZhYRvOHFK1AKdpAOahLzTf0
	 PzgLFRgPFg+3V5bJ7TAY0NuRiqG4oAMGvlCLkNJplPeDHFzlgSa697QIzx2ViGzBMe
	 EB1gUzQeJ70y/m/pqlym3oWMkWRPKluRuVffbp/GLIoGuqQ+y4jtLy0uUqN7WDvlHD
	 FmwiDbdzQmJFaQwjn/UtJ/nlcGOfW0AA36qDJCkPfHPomoDFuSLUkNdzFik7E5uWz3
	 VNtzZiydUl67A==
Subject: Re: [PATCH net v4] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, rayagond@vayavyalabs.com, treding@nvidia.com,
 linux@armlinux.org.uk, qiangqing.zhang@nxp.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 14 Sep 2026 08:34:13 +0000
Message-ID: <178937485371.22033.14951761320111266794@kernel.org>
In-Reply-To:
 <20260913-stmmac-ptp-error-propagate-v4-1-a947aceac928@oss.qualcomm.com>
References:
 <20260913-stmmac-ptp-error-propagate-v4-1-a947aceac928@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 (3) · Low: 2

- [Medium] stmmac_setup_ptp()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:940) now gates the…
- [Medium] The patch unifies two of the three hardware-timestamping ABI
  gates on stmmac_check_timestamp_cap() ((dma_cap.time_stamp ||…
- [Medium] In stmmac_resume(), when the newly propagated
  stmmac_init_timestamping() failure is taken (stmmac_main.c:8371-8375…
- [Low] The commit message claims that after applying
  stmmac_check_timestamp_cap() to the hwtstamp get path and the ethtool…
- [Low] The kernel-doc of stmmac_init_timestamping()
  (stmmac_main.c:889-895) still reads 'Description: this is to verify if…

Pre-existing issues:
- [Medium] stmmac_get_ts_info() (stmmac_ethtool.c:1010-1019) sets
  info->phc_index = 0 when priv->ptp_clock is NULL while still…
- [Medium] stmmac_change_mtu() (stmmac_main.c:6181-6199) tears the
  running interface down with __stmmac_release() and then calls…
- [Medium] priv->ptp_enabled is used as the single ownership token for
  the clk_ptp_ref prepare/enable reference, but the platform noirq PM…

--

net: stmmac: propagate PTP init failures in __stmmac_open() and stmmac_resume()

stmmac_setup_ptp() now returns an error code so that the PTP reference clock
enable and stmmac_init_timestamping() failures are propagated by
__stmmac_open() and stmmac_resume(), which stop the DMA engines and disable
the MAC on failure.  A new stmmac_check_timestamp_cap() helper folds the
hardware timestamping capability and a non-zero PTP reference clock rate
into one test used by the hwtstamp get path, the ethtool ts_info path and
the devlink registration.  The platform noirq PM callbacks gate the
clk_ptp_ref enable/disable on the new priv->ptp_enabled flag.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 7582fca637419..c781cf3441fc3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h

[ ... ]

> @@ -419,6 +421,17 @@ int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
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
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 154cc0c7623da..7758b854700a3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -1007,8 +1007,7 @@ static int stmmac_get_ts_info(struct net_device *dev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> -	if ((priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
> -
> +	if (stmmac_check_timestamp_cap(priv)) {
>  		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
>  					SOF_TIMESTAMPING_TX_HARDWARE |
>  					SOF_TIMESTAMPING_RX_HARDWARE |

[Severity: Low]

The commit message says that after applying the helper to the hwtstamp get
path and the ethtool ts_info path, "so all of them consistently report
-EOPNOTSUPP when timestamping is not usable".

Does the ethtool path do that?  When stmmac_check_timestamp_cap() is false,
stmmac_get_ts_info() takes the else branch and calls
ethtool_op_get_ts_info(), which succeeds:

net/ethtool/ioctl.c:ethtool_op_get_ts_info() {
	info->so_timestamping =
		SOF_TIMESTAMPING_TX_SOFTWARE |
		SOF_TIMESTAMPING_RX_SOFTWARE |
		SOF_TIMESTAMPING_SOFTWARE;
	info->phc_index = -1;
	return 0;
}

So ethtool -T returns 0 with software-only capabilities rather than
-EOPNOTSUPP.  Could that sentence be adjusted?

[Severity: Medium]

This isn't a bug introduced by this patch, but while the gate here is being
narrowed, the phc_index assignment just below it still reports a valid index
when no PTP clock exists:

		if (priv->ptp_clock)
			info->phc_index = ptp_clock_index(priv->ptp_clock);
		else
			info->phc_index = 0;

The ethtool convention for "no associated PHC" is -1, as
ethtool_op_get_ts_info() does.  Index 0 points userspace at some other
device's PTP clock.

This branch is reachable before the first ifup, since the gate is a pure
capability plus clk_ptp_rate test independent of PTP registration, and also
after ptp_clock_register() fails, where stmmac_ptp_register() leaves
priv->ptp_clock NULL.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 62c3441911e71..9d2c6bf68575f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -653,7 +653,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  	u32 ts_master_en = 0;
>  	u32 ts_event_en = 0;
>  
> -	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> +	if (!priv->plat->clk_ptp_rate ||
> +	    !(priv->dma_cap.time_stamp || priv->adv_ts)) {
>  		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
>  		priv->hwts_tx_en = 0;
>  		priv->hwts_rx_en = 0;

[Severity: Medium]

Is the remaining divergence between this predicate and
stmmac_check_timestamp_cap() intended?  The set path tests priv->adv_ts,
while the get and ethtool paths now test priv->dma_cap.atime_stamp.

priv->adv_ts is not a capability bit, it is derived in
stmmac_init_timestamping():

	priv->adv_ts = 0;
	if (xmac && priv->dma_cap.atime_stamp)
		priv->adv_ts = 1;
	else if (priv->extend_desc && priv->dma_cap.atime_stamp)
		priv->adv_ts = 1;

On a non-xmac core that reports atime_stamp=1 with time_stamp=0 and runs
without extended descriptors, adv_ts stays 0, so ethtool -T and
SIOCGHWTSTAMP advertise hardware timestamping while SIOCSHWTSTAMP returns
-EOPNOTSUPP with "No support for HW time stamping".

adv_ts is also only assigned once PTP setup has run, so this gate answers
differently before and after the first ifup, whereas the other two are
static.

Does that fit the commit message claim that "all of them consistently
report -EOPNOTSUPP when timestamping is not usable"?

> @@ -843,7 +844,7 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> -	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
> +	if (!stmmac_check_timestamp_cap(priv))
>  		return -EOPNOTSUPP;
>  
>  	*config = priv->tstamp_config;
> @@ -900,11 +901,6 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
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

[Severity: Low]

With the capability check removed here, should the kernel-doc directly above
stmmac_init_timestamping() be refreshed as well?  It still reads:

/**
 * stmmac_init_timestamping - initialise timestamping
 * @priv: driver private structure
 * Description: this is to verify if the HW supports the PTPv1 or PTPv2.
 * This is done by looking at the HW cap. register.
 * This function also registers the ptp driver.
 */

Both statements now belong to stmmac_setup_ptp(), which holds the
stmmac_check_timestamp_cap() test and the stmmac_ptp_register() call.  This
matters for readers of stmmac_resume(), which calls
stmmac_init_timestamping() directly under the new priv->ptp_enabled gate.

> @@ -937,24 +933,43 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
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

[Severity: Medium]

Can this early return permanently disable PTP on platforms whose PTP rate is
programmed by the very code the gate skips?

stmmac_check_timestamp_cap() returns false when priv->plat->clk_ptp_rate is
zero, but the only run-time writer of that field is
plat->ptp_clk_freq_config(), which runs downstream in
stmmac_init_timestamping():

	if (priv->plat->ptp_clk_freq_config)
		priv->plat->ptp_clk_freq_config(priv);

On dwmac-qcom-ethqos that callback is what establishes the rate:

dwmac-qcom-ethqos.c:ethqos_ptp_clk_freq_config() {
	err = clk_set_rate(plat_dat->clk_ptp_ref, ULONG_MAX);
	if (err)
		netdev_err(priv->dev, "Failed to max out clk_ptp_ref: %d\n", err);
	plat_dat->clk_ptp_rate = clk_get_rate(plat_dat->clk_ptp_ref);
}

The value the gate samples comes from probe time:

stmmac_platform.c:stmmac_probe_config_dt() {
		plat->clk_ptp_rate = clk_get_rate(plat->clk_ptp_ref);
}

If that probe-time read is zero, the pre-patch flow still recovered: the ref
clock was enabled unconditionally, ptp_clk_freq_config() programmed the rate,
and the !clk_ptp_rate check in stmmac_init_tstamp_counter() then passed.
With this gate, clk_ptp_ref is never enabled, stmmac_init_tstamp_counter()
and stmmac_ptp_register() never run, priv->ptp_enabled stays false so
stmmac_resume() skips timestamping too, and hwtstamp get plus ethtool -T
report no hardware timestamping.  Nothing is surfaced because
stmmac_setup_ptp() returns 0.

Would it be safer to evaluate clk_ptp_rate only after
plat->ptp_clk_freq_config() has had a chance to program it?

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
> +	priv->ptp_enabled = true;
> +
> +	return 0;
>  }
>  
>  static void stmmac_release_ptp(struct stmmac_priv *priv)
>  {
> +	if (!priv->ptp_enabled)
> +		return;
> +
>  	stmmac_ptp_unregister(priv);
>  	clk_disable_unprepare(priv->plat->clk_ptp_ref);
> +	priv->ptp_enabled = false;
>  }
>  
>  static void stmmac_legacy_serdes_power_down(struct stmmac_priv *priv)
> @@ -4161,10 +4176,12 @@ static int __stmmac_open(struct net_device *dev,
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
>  
>  	stmmac_init_coalesce(priv);
>  
> @@ -4189,7 +4206,10 @@ static int __stmmac_open(struct net_device *dev,
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

[Severity: Medium]

This is a pre-existing issue, not introduced by this patch, but the new PTP
failure branch adds another way of reaching it.  stmmac_change_mtu() tears
the live interface down and reopens it:

stmmac_main.c:stmmac_change_mtu() {
		__stmmac_release(dev);

		ret = __stmmac_open(dev, dma_conf);
		if (ret) {
			free_dma_desc_resources(priv, dma_conf);
			kfree(dma_conf);
			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
			return ret;
		}
}

There is no rollback to the previous configuration and no transition out of
the running state, so netif_running() stays true while queues, IRQs,
descriptors, phylink, MAC and DMA are all down.  In the baseline this was
already reachable via the stmmac_hw_setup() and stmmac_request_irq()
failures; after this change a clk_prepare_enable(clk_ptp_ref) or
stmmac_init_timestamping() failure during an MTU change can put the
interface in the same state.

[ ... ]

> @@ -8346,13 +8365,14 @@ int stmmac_resume(struct device *dev)
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
> +	if (priv->ptp_enabled) {
> +		ret = stmmac_init_timestamping(priv);
> +		if (ret)
> +			goto error_stop_dma;
> +	}

[Severity: Medium]

Should this failure path also drop the PTP-side state?  The open path is now
consistent, since a stmmac_setup_ptp() failure leaves priv->ptp_enabled
false with no PHC registered, but the resume path is not.

On the goto error_stop_dma path, priv->ptp_enabled stays true, the PTP clock
stays registered, and priv->systime_flags, sub_second_inc, default_addend and
tstamp_config still describe the pre-suspend hardware state that the DMA
software reset in stmmac_hw_setup() has just cleared.  ethtool ts_info,
SIOCGHWTSTAMP and /dev/ptpN then keep advertising working hardware
timestamping over a non-running counter.

That looks like the exact divergence the commit message describes: "the MAC
system time counter is left in its post-reset, non-running state, while the
driver keeps operating as if timestamping were up", including the EST base
time derived from a non-advancing counter.

One way to reach it is stmmac_init_tstamp_counter() failing on its
!plat->clk_ptp_rate check after plat->ptp_clk_freq_config() re-reads a zero
rate during resume.

>  
>  	stmmac_init_coalesce(priv);
>  	phylink_rx_clk_stop_block(priv->phylink);
> @@ -8376,6 +8396,16 @@ int stmmac_resume(struct device *dev)
>  	netif_device_attach(ndev);
>  
>  	return 0;
> +
> +error_stop_dma:
> +	stmmac_stop_all_dma(priv);
> +	stmmac_mac_set(priv, priv->ioaddr, false);
> +error_unlock:
> +	stmmac_legacy_serdes_power_down(priv);
> +	mutex_unlock(&priv->lock);
> +	rtnl_unlock();
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(stmmac_resume);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 6128ed1bd521a..19d4815544990 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -959,7 +959,8 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
>  
>  	if (!priv->wolopts) {
>  		/* Disable clock in case of PWM is off */
> -		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> +		if (priv->ptp_enabled)
> +			clk_disable_unprepare(priv->plat->clk_ptp_ref);
>  
>  		ret = pm_runtime_force_suspend(dev);
>  		if (ret)
> @@ -984,6 +985,9 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
>  		if (ret)
>  			return ret;
>  
> +		if (!priv->ptp_enabled)
> +			return 0;
> +
>  		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
>  		if (ret < 0) {
>  			netdev_warn(priv->dev,

[Severity: Medium]

This is a pre-existing imbalance rather than something this patch
introduces, but since priv->ptp_enabled now becomes the ownership token for
the clk_ptp_ref reference, can the two error paths here leave it out of sync
with the reference actually held?

In stmmac_pltfr_noirq_suspend(), the clock is dropped and then
pm_runtime_force_suspend() may fail and return, so ptp_enabled stays true
with no reference held, and the failing device is not resumed by
dpm_resume_noirq().

In stmmac_pltfr_noirq_resume(), a failing clk_prepare_enable() returns while
ptp_enabled is still true, and a failing resume_noirq does not abort the PM
resume sequence.

In both cases the next teardown drops a reference that was never acquired:

stmmac_main.c:stmmac_release_ptp() {
	if (!priv->ptp_enabled)
		return;

	stmmac_ptp_unregister(priv);
	clk_disable_unprepare(priv->plat->clk_ptp_ref);
}

The same underflow existed in the baseline, where both callbacks and
stmmac_release_ptp() touched clk_ptp_ref unconditionally, so the gate
reproduces the old behaviour whenever ptp_enabled is true.  Would it be
worth clearing or restoring the flag on these two error returns while the
ownership rules are being written down?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913-stmmac-ptp-error-propagate-v4-1-a947aceac928%40oss.qualcomm.com
