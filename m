Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A20375AC4
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285101; cv=none; b=vBWocGM+mOUjPWBmsPjcUCuT+ydhM7njud40bALiE5UXiyORFDT4QYqrQPstdij+r0qCCBIoGV9IGI8VL5R9XGpKWlNB41876A4BuY9iaxd6WNKbwYvHJUvUld/q+mQyzD2ZetdTM5KEdyXpm99ZUdOiYUGQJLAd1K8ZkUCoh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285101; c=relaxed/simple;
	bh=87GRfdtqLbN68pHQ3bOe7uz4iAFYn8uH5iqeMR10srI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyMHV6ZryiMH3HxBr+32T3u1FPSqYO1l5kJipsx/g/etpQpy/obo880Zdw36oXLsM/NJvIp4fshH3D9mgIj7Q+ndisQyFwhgJK7xFFSYD0SyAT834mL/O0mptlfm0Kxf30wln/LI7QeMxnMUhYGY7rw9oiih6FqS3BQPye7dnmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmqEVk1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmqEVk1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ED31F000FF;
	Tue,  6 Oct 2026 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791285099;
	bh=6q80GLIOo4mbZosSnlYuAhDZl1QZK0wGSOYq1WsPag0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YmqEVk1ZzFj/N+86gOCMb1zRFenDeOXuVoY7jVRpEVQC6TbKzos7EUep6bVyiftTd
	 fxjspMwlryFuaDuKD5UhyTNulf71nBcSTqdT3L0ikdf+mF2BkUY4k722oNQF3Ekky7
	 C1hKYiJFdUHANgTgpVgCCAM6ZdpArcCwI/RTryBAXKncpYempvnmb8wmt9QEHVkowz
	 VW4D2z8XYpt7uqaVFZ/bvHmeduyYNwAA3E09RWfy6BSW76bBtdf5KGe3NRyk2h2mMO
	 B5bpesZJjsL+6jSREJjBM9VeJzFurUTW4RK934GVxeBvwz1ULUxm+4FehyBB7y57C1
	 HJ1q0M5w7WGHg==
Subject: Re: [PATCH net] net: stmmac: serialize PTP timestamping configuration
 with priv->lock
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 06 Oct 2026 11:11:38 +0000
Message-ID: <179128509861.434549.666442739990534480@kernel.org>
In-Reply-To:
 <20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com>
References:
 <20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] The tag `Fixes: 4347287b8627 ("net: stmmac: propagate PTP
  addend and system time programming errors")` names a SHA that does not…
- [Medium] PTP_TCR and PTP_TAR are still programmed concurrently under
  two different locks.
- [Low] In stmmac_hwtstamp_set()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the patch moves…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  stmmac_dl_ts_coarse_set() reprograms PTP_TCR, PTP_SSIR and PTP_TAR and…
- [Low] This problem wasn't introduced by this patch, but in
  stmmac_update_subsecond_increment() the rollback is incomplete when…

--

net: stmmac: serialize PTP timestamping configuration with priv->lock

This patch takes priv->lock in stmmac_hwtstamp_set() and in
stmmac_dl_ts_coarse_set(). The goal is to serialize updates to
systime_flags/tsfupdt_coarse and the PTP_TCR programming between the
RTNL-held hwtstamp path and the devl_lock-held devlink parameter path. The
hardware capability check in stmmac_hwtstamp_set() also moves under the
lock.

> Fixes: 4347287b8627 ("net: stmmac: propagate PTP addend and system time programming errors")

[Severity: Medium]
Is this the right Fixes target? 4347287b8627 does not seem to resolve in
the tree. The quoted subject matches 232d49dd4b40, which is the parent of
this patch.

The race also looks older than that commit. Before 232d49dd4b40,
stmmac_dl_ts_coarse_set() already did three things under devl_lock only:

- wrote priv->tsfupdt_coarse
- did a read-modify-write of priv->systime_flags
- called stmmac_update_subsecond_increment()

Meanwhile stmmac_hwtstamp_set() read tsfupdt_coarse and rewrote
systime_flags and PTP_TCR under RTNL.

Should this be the following instead?

Fixes: 6920fa0c764d ("net: stmmac: Add a devlink attribute to control timestamping mode")

With that tag, stable trees that have the devlink parameter but not
232d49dd4b40 would also pick up the fix.

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
> +

[Severity: Low]
Was moving the capability check intended? It used to be the first check
in stmmac_hwtstamp_set(). Now it comes after the netif_running() and
tx_type checks.

The commit message does not mention the move. Userspace sees the
difference through SIOCSHWTSTAMP and ethtool tsconfig-set, via
dev_set_hwtstamp_phylib()->ndo_hwtstamp_set():

- On a MAC without timestamping support, a down interface now gets
  -ENODEV with "Cannot change timestamping configuration while down".
  It used to get -EOPNOTSUPP with "No support for HW time stamping".

- On such a MAC, an unsupported tx_type such as HWTSTAMP_TX_ONESTEP_SYNC
  now gets -ERANGE instead of -EOPNOTSUPP.

- On those early returns, hwts_tx_en and hwts_rx_en are no longer
  cleared.

The serialization does not seem to need the move:

- dma_cap.time_stamp is fixed at probe.
- adv_ts is written by stmmac_init_timestamping() on the open path
  without priv->lock, so reading it under the lock does not protect it.

Could the check stay at the top of the function?

>  	if (priv->adv_ts) {
>  		switch (config->rx_filter) {
>  		case HWTSTAMP_FILTER_NONE:

[ ... ]

> @@ -859,8 +863,10 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
>  
>  	priv->tstamp_config = *config;
> +unlock:
> +	mutex_unlock(&priv->lock);
>  
> -	return 0;
> +	return ret;
>  }

[Severity: Medium]
Can the PTP_TCR read-modify-write here still interleave with the PHC
callbacks in stmmac_ptp.c? Those callbacks take priv->ptp_lock, not
priv->lock, so neither lock excludes the other.

For example, stmmac_adjust_freq() does:

stmmac_adjust_freq()
  addend = adjust_by_scaled_ppm(priv->default_addend, scaled_ppm);
  write_lock_irqsave(&priv->ptp_lock, flags);
  stmmac_config_addend()
    writel(addend, ioaddr + PTP_TAR);
    value = readl(ioaddr + PTP_TCR);
    value |= PTP_TCR_TSADDREG;
    writel(value, ioaddr + PTP_TCR);

stmmac_adjust_time()->adjust_systime() does the same with PTP_TCR_TSUPDT.
stmmac_set_time()->init_systime() does the same with PTP_TCR_TSINIT.

Suppose one of these reads PTP_TCR before config_hw_tstamping() writes it
here, or in stmmac_dl_ts_coarse_set(), and writes it back afterwards. The
stale TSCFUPDT and filter bits would then be restored. PTP_TCR would no
longer match priv->systime_flags and priv->tsfupdt_coarse.

There are two related cases:

- stmmac_adjust_freq() reads priv->default_addend without any lock.
  During a coarse to fine devlink switch, it could latch a TAR value
  computed from the old addend.

- For PEROUT, stmmac_enable() passes priv->sub_second_inc and
  priv->systime_flags to flex_pps_config under ptp_lock only. It could
  see a mismatched pair.

These PHC paths behaved the same way before this patch. Still, the commit
message says the configuration is now "updated under a single lock".
Should the PTP_TCR/PTP_TAR writers in stmmac_ptp.c be covered by the same
lock?

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
Does this close the race the commit message describes? The open path
writes the same state while holding only RTNL:

__stmmac_open()
  stmmac_setup_ptp()
    stmmac_init_timestamping()
      priv->systime_flags = STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT;
      priv->tsfupdt_coarse = false;
      ...
      stmmac_init_tstamp_counter()
        stmmac_update_subsecond_increment(priv, priv->systime_flags);

Only stmmac_resume() calls stmmac_init_timestamping() with priv->lock
held. The devlink param set path does not take RTNL. So devlink (devl_lock
plus priv->lock) and open (RTNL only) share no lock.

Consider this sequence:

CPU0 (devlink, vbool=true)
stmmac_dl_ts_coarse_set()
  systime_flags = priv->systime_flags;
  programs coarse PTP_TCR/PTP_SSIR/PTP_TAR
  still inside config_addend()

CPU1 (ip link set up, or an MTU change via stmmac_change_mtu())
__stmmac_open()->stmmac_setup_ptp()->stmmac_init_timestamping()
  priv->tsfupdt_coarse = false;
  programs fine PTP_TCR/PTP_SSIR/PTP_TAR

CPU0
  stores coarse sub_second_inc and default_addend
  priv->tsfupdt_coarse = true;
  priv->systime_flags = systime_flags;  /* coarse */

The software state now says coarse mode while the hardware runs in fine
mode. The next stmmac_hwtstamp_set() would program PTP_TCR without
TSCFUPDT on top of the fine-mode SSIR. Would the PHC then advance at twice
the real rate?

This function also does not check netif_running(). It can program PTP
registers while stmmac_hw_setup() is resetting the DMA/MAC. It can also
run while __stmmac_release()->stmmac_release_ptp() is disabling
clk_ptp_ref.

stmmac_init_timestamping() still reads and writes systime_flags and
tsfupdt_coarse and calls stmmac_config_hw_tstamping() outside priv->lock.
Is the "single lock" statement in the commit message accurate in that
case?

>  	if (ctx->val.vbool)
>  		systime_flags &= ~PTP_TCR_TSCFUPDT;
>  	else

[Severity: Medium]
This problem was not introduced by this patch. After this point,
stmmac_dl_ts_coarse_set() calls stmmac_update_subsecond_increment(). That
reprograms PTP_TCR, PTP_SSIR and PTP_TAR and busy-polls TSADDREG. There is
no netif_running() check, no runtime PM reference and no check that
clk_ptp_ref is enabled.

The devlink parameter is registered in __stmmac_dvr_probe(), which then
does:

	/* Let pm_runtime_put() disable the clocks.
	 * If CONFIG_PM is not enabled, the clocks will stay powered.
	 */
	pm_runtime_put(device);

stmmac_release() calls stmmac_release_ptp():

	stmmac_ptp_unregister(priv);
	clk_disable_unprepare(priv->plat->clk_ptp_ref);

and then pm_runtime_put(). Runtime suspend then gates stmmac_clk and pclk
through stmmac_pltfr_runtime_suspend()->stmmac_bus_clks_config(priv,
false).

Running "devlink dev param set ... phc_coarse_adj" on a down interface
would then do MMIO on a MAC whose bus clock may be gated. Other
register-access paths in the driver avoid this:

- MDIO, set_mac_address and VLAN add/kill call
  pm_runtime_resume_and_get() first.
- stmmac_hwtstamp_set() returns -ENODEV when the interface is down.

On some SoCs, MMIO to a clock-gated peripheral can hang the interconnect
or raise an external abort. At minimum the write is lost, or TSADDREG
never clears, which costs a 100 ms atomic busy-poll and returns an error.

The setting would not last anyway. The next open resets it, since
stmmac_init_timestamping() sets tsfupdt_coarse = false.

> @@ -7768,13 +7777,15 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  	if (ret) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to reconfigure PTP adjustment");
> -		return ret;
> +		goto unlock;
>  	}

[Severity: Low]
This is a pre-existing issue. Is the rollback in
stmmac_update_subsecond_increment() complete when stmmac_config_addend()
fails?

By the time the TSADDREG poll times out, config_addend() has already
written the new mode's addend to PTP_TAR and issued TSADDREG. The error
label only restores PTP_TCR and PTP_SSIR:

error:
	/* Restore previous configuration */
	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
					   priv->plat->clk_ptp_rate, xmac,
					   NULL);

TSADDREG is not in STMMAC_HWTS_CFG_MASK, so the TCR read-modify-write
leaves it set. Suppose the pending latch completes later. The accumulator
would use the rejected mode's addend while TCR/SSIR are back in the old
mode. priv->default_addend would still hold the old value.

The sibling helper stmmac_restore_subsecond_increment() does reprogram the
addend on rollback.

Here, stmmac_dl_ts_coarse_set() reports the failure through extack and
returns an error, but the hardware is left partly changed. This error path
came from the parent commit 232d49dd4b40.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624%40oss.qualcomm.com
