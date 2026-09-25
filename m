Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA649BD8B;
	Fri, 25 Sep 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336570; cv=none; b=Vpw14cPk0dvZrtxqL3T6Ml6fXZVpOcRtutUFz4TJgpsylKn/uIclJcxnu1JiGwQsshCheFlfQFl634Ja8C9gty/PXSCrcPMvEuort7rG1QH2S86kevhZmESbcP71pE7zv0In+XK6TPtFPQ0tvuzSewG5xtdfoxOwH+SOvMWyHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336570; c=relaxed/simple;
	bh=QMG1pgBDsv0Gpu5j+ef9da6C6vIIRaNkGg2UJFAea9k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=od7vg+AtQE6Yu5I+dUhCg3pwrVsy/+ngENs4HVGNUOCUX7bYHQwJ3vuJXjOmTYw8mK3pPfyhZPqzZilqxMN1/SgB69MTt0yC8GOWVZoZwymZRjfYejL7QlpwhmEbR1AtH5rDYEmaTdwXrPtBjn2SmBjNDlLrVHwFlZgGy8GofsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVYcb01+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVYcb01+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48181F000FF;
	Fri, 25 Sep 2026 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336568;
	bh=ytWdxFwe/4edYt3NGYP9LBKHLPhDgSO5r+cvEq/HqIQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eVYcb01+BlgVKA39o/uFuKw7TT4IDwudTVcBzacamCZT2VsquwG/tD5XiLsDddknO
	 VADN2FfXlp/FDM68OOS4b4LIgUXhKlM6tI4kpsxhjUz7K2hZV+uSqV1XdAIHfNMlZf
	 jf/EPm1IzlNjgGsWamfZZEurS2GSyUoXEACRNBnYwirf+/1rq3VarcNwOGCggJkTxq
	 HDzTjFbr5SzAIgzw7Pu3hQ/9Y1qbV3EHk6/D9NhWHa4POtvanwUwIHv1vpfZ04yhza
	 qj+f3S9GYk3fq/KR3VhjGRBffV1A+ZebdueDlPtkPfE1b+faUWImBTbOk4aafpNVP0
	 pwM+T1XKBJAzQ==
Subject: Re: [PATCH net v2] net: stmmac: propagate PTP addend and system time
 programming errors
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 11:42:47 +0000
Message-ID: <179033656748.2160803.6725984933967085758@kernel.org>
In-Reply-To:
 <20260924-stmmac-ptp-added-systime-error-v2-1-beb2a6b5f866@oss.qualcomm.com>
References:
 <20260924-stmmac-ptp-added-systime-error-v2-1-beb2a6b5f866@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 4 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix stops at returning an error.
- [Medium] The patch is titled 'propagate PTP addend and system time
  programming errors', but the PHC callbacks that call the same hooks…
- [Medium] The new failure paths leave timestamping enabled with stale
  state.
- [Medium] The patch reorders stmmac_dl_ts_coarse_set() so that
  priv->systime_flags is copied into a local variable at entry, all…
- [Medium] stmmac_restore_subsecond_increment() calls
  stmmac_config_addend() unconditionally and ignores its result,…
- [Low] stmmac_dl_ts_coarse_set() can now return -EINVAL (sub-second
  increment computed as 0) or -ETIMEDOUT (TSADDREG poll timeout in…
- [Low] The new rollback in stmmac_update_subsecond_increment() (line
  658) passes priv->default_addend to…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the devlink
  'phc_coarse_adj' param (priv->tsfupdt_coarse) is not honoured when…
- [Medium] This problem wasn't introduced by this patch, but
  stmmac_update_subsecond_increment() and the new…

--

net: stmmac: propagate PTP addend and system time programming errors

This patch makes stmmac_update_subsecond_increment(),
stmmac_init_tstamp_counter() and stmmac_dl_ts_coarse_set() return the
errors from addend and system time programming instead of always
returning success. It also adds stmmac_restore_subsecond_increment() to
roll back the PTP configuration when programming fails.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..fae2a90283ce4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -601,31 +601,63 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
>  	}
>  }
>  
> -static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
> +static void stmmac_restore_subsecond_increment(struct stmmac_priv *priv,
> +					       u32 default_addend,
> +					       u32 systime_flags)
>  {
>  	bool xmac = dwmac_is_xmac(priv->plat->core_type);
>  	u32 sec_inc = 0;
> +
> +	stmmac_config_addend(priv, priv->ptpaddr, default_addend);
> +	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
> +	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
> +					   priv->plat->clk_ptp_rate,
> +					   xmac, &sec_inc);
> +	priv->default_addend = default_addend;
> +	priv->sub_second_inc = sec_inc;
> +}

[Severity: Medium]
Is it safe to call stmmac_config_addend() again here and ignore its
result?

When this rollback runs because config_addend() has just timed out in
stmmac_update_subsecond_increment(), PTP_TCR_TSADDREG may still be set.
One way to get there is a PTP ref clock domain that is not running,
since stmmac_setup_ptp() only warns when clk_prepare_enable() fails.
config_addend() then overwrites PTP_TAR and sets TSADDREG again while
the previous update is still pending:

stmmac_hwtstamp.c:config_addend() {
	writel(addend, ioaddr + PTP_TAR);
	/* issue command to update the addend value */
	value = readl(ioaddr + PTP_TCR);
	value |= PTP_TCR_TSADDREG;
	writel(value, ioaddr + PTP_TCR);
	...
}

The DWMAC programming model expects this bit to read 0 before it is set
again. The call also adds a second 100 ms readl_poll_timeout_atomic()
busy-wait, so the failing devlink path spins for about 200 ms.

If the pending update latches later, TAR could end up holding the old
value (or 0 on the first open after probe) rather than the one just
computed.

On the TSINIT timeout path in stmmac_init_tstamp_counter(), the TCR
read-modify-write in config_addend() also writes the still-pending
TSINIT bit back as 1, so the pending system time load is not cancelled.

In every case, the helper then sets priv->default_addend and
priv->sub_second_inc as if the old configuration had been restored in
hardware.

[Severity: Medium]
This isn't a bug introduced by this patch, but
stmmac_update_subsecond_increment() and this new helper program
PTP_TCR, PTP_SSIR and PTP_TAR, and update priv->default_addend and
priv->sub_second_inc, without holding priv->ptp_lock. Both run from the
devlink set path while the PHC is registered.

The PHC callbacks use that lock around the same registers:

stmmac_ptp.c:stmmac_adjust_freq() {
	...
	write_lock_irqsave(&priv->ptp_lock, flags);
	stmmac_config_addend(priv, priv->ptpaddr, addend);
	write_unlock_irqrestore(&priv->ptp_lock, flags);
	...
}

stmmac_enable() also reads priv->sub_second_inc and
priv->systime_flags under ptp_lock for PEROUT.

Could a concurrent adjfine and phc_coarse_adj devlink set lose a TCR
mode change, or program a TAR derived from a stale default_addend? This
error path adds one more unlocked config_addend() plus
config_hw_tstamping() sequence.

> +
> +static int stmmac_update_subsecond_increment(struct stmmac_priv *priv,
> +					     u32 systime_flags)
> +{

[ ... ]

> +	ret = stmmac_config_addend(priv, priv->ptpaddr, val);
> +	if (ret)
> +		goto error;
> +
> +	priv->sub_second_inc = sec_inc;
> +	priv->default_addend = val;
> +
> +	return 0;
> +error:
> +	/* Restore previous configuration */
> +	stmmac_restore_subsecond_increment(priv, priv->default_addend,
> +					   priv->systime_flags);

[Severity: Low]
Is priv->default_addend really the previous configuration here?
stmmac_adjust_freq() programs an adjusted addend into PTP_TAR but does
not update default_addend:

	addend = adjust_by_scaled_ppm(priv->default_addend, scaled_ppm);

If a phc_coarse_adj devlink set fails (for example with sec_inc == 0),
the rollback writes the nominal addend into PTP_TAR. That drops the
frequency correction the servo had applied, so a failed operation still
changes the PHC frequency, which the "Restore previous configuration"
comment doesn't reflect.

> +	return ret;
>  }
>  
>  /**
> @@ -864,25 +896,37 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
>  static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
>  				      u32 systime_flags)
>  {

[ ... ]

>  	/* lower 32 bits of tv_sec are safe until y2106 */
> -	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec);
> +	ret = stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
> +				  now.tv_nsec);
> +	if (ret)
> +		goto error;

[Severity: Medium]
The subject says addend and system time programming errors are now
propagated, but the PHC callbacks that call the same hooks still drop
the result:

stmmac_ptp.c:stmmac_set_time() {
	...
	write_lock_irqsave(&priv->ptp_lock, flags);
	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
	write_unlock_irqrestore(&priv->ptp_lock, flags);

	return 0;
}

stmmac_adjust_freq() also ignores the return of stmmac_config_addend()
and returns 0.

When the TSINIT or TSADDREG poll times out, clock_settime() or
clock_adjtime() from ptp4l or phc2sys still reports success. Should
settime64 and adjfine return the error too, since the ptp_clock_info
callbacks are allowed to fail?

> +
> +	priv->systime_flags = systime_flags;

[Severity: High]
This is a pre-existing issue, but this path is being reworked here:
stmmac_init_timestamping() always sets PTP_TCR_TSCFUPDT and ignores
priv->tsfupdt_coarse:

	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
					       PTP_TCR_TSCFUPDT);

Suppose phc_coarse_adj is set to true and then the interface goes down
and up (or through suspend/resume). config_sub_second_increment() then
programs the fine mode SSINC (2e9 / clk_ptp_rate) and the ~2^31 addend.
priv->tsfupdt_coarse stays true, so stmmac_dl_ts_coarse_get() still
reports coarse mode.

The next SIOCSHWTSTAMP clears TSCFUPDT in stmmac_hwtstamp_set():

	priv->systime_flags = STMMAC_HWTS_ACTIVE;
	if (!priv->tsfupdt_coarse)
		priv->systime_flags |= PTP_TCR_TSCFUPDT;

It then only calls stmmac_config_hw_tstamping(), and SSIR and TAR are
not reprogrammed.

Does that leave the hardware in coarse mode, adding twice the clock
period on every cycle, so the PHC runs about twice as fast?

>  
>  	return 0;
> +error:
> +	/* Restore previous configuration */
> +	stmmac_restore_subsecond_increment(priv, default_addend,
> +					   priv->systime_flags);
> +
> +	return ret;
>  }

[Severity: Medium]
Can this failure path leave timestamping enabled with stale state?

stmmac_hwtstamp_set() sets priv->hwts_rx_en, priv->hwts_tx_en,
priv->tstamp_config and a priv->systime_flags value that includes TSENA
and the RX filter bits. None of these is cleared on close or suspend.

On a later open or resume, if stmmac_init_tstamp_counter() fails, this
rollback writes the old priv->systime_flags, filter bits included, back
into PTP_TCR. The rollback in stmmac_update_subsecond_increment() does
the same. stmmac_init_timestamping() then returns early:

	if (ret) {
		netdev_warn(priv->dev, "PTP init failed\n");
		return ret;
	}

and never reaches:

	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
	priv->hwts_tx_en = 0;
	priv->hwts_rx_en = 0;

TX timestamp requests and RX timestamp delivery in
stmmac_get_rx_hwtstamp() would then keep running on a counter whose
init just failed, and stmmac_hwtstamp_get() reports the stale config.

Before this patch, these paths always reached the reset, and TCR was
left at STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT with no filters.

[Severity: High]
The error now reaches stmmac_init_timestamping(), but do any callers
act on it?

stmmac_resume() ignores the result:

	stmmac_init_timestamping(priv);

	stmmac_init_coalesce(priv);

After the MAC reset in stmmac_hw_setup(), a TSADDREG or TSINIT timeout
here leaves the PHC registered at open still in place. gettime64,
adjfine, settime64 and tc_taprio_configure(), which calls gettime64 for
the EST base time, keep using a counter that was never re-initialized.

On open, stmmac_setup_ptp() only skips registration:

	if (stmmac_init_timestamping(priv) == 0)
		stmmac_ptp_register(priv);

The interface still comes up. stmmac_hwtstamp_set() only checks the
timestamp capability bits and netif_running(), so SIOCSHWTSTAMP can
still turn on packet timestamping with the uninitialized counter and
return 0.

The commit message describes the problem as the driver that "keeps
operating as if timestamping were up" and names TAPRIO/EST. On the
resume path, the only visible change seems to be the "PTP init failed"
warning. Isn't that still the situation this patch is meant to fix?

>  
>  /**
> @@ -7693,18 +7737,23 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  {
>  	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
>  	struct stmmac_priv *priv = dl_priv->stmmac_priv;
> +	u32 systime_flags = priv->systime_flags;
> +	int ret;

[ ... ]

> -	stmmac_update_subsecond_increment(priv);
> +	ret = stmmac_update_subsecond_increment(priv, systime_flags);
> +	if (ret)
> +		return ret;

[Severity: Low]
This now returns -EINVAL or -ETIMEDOUT to devlink without filling in
the extack it receives. Would an NL_SET_ERR_MSG_MOD() help user space
understand why setting phc_coarse_adj failed?

> +
> +	priv->tsfupdt_coarse = ctx->val.vbool;
> +	priv->systime_flags = systime_flags;

[Severity: Medium]
Does moving these assignments after the hardware programming widen a
race with stmmac_hwtstamp_set()? The devlink set callback runs under
the devlink instance lock and stmmac_hwtstamp_set() runs under RTNL, so
the two paths share no lock.

CPU0 (devlink, vbool = true)
stmmac_dl_ts_coarse_set()
  systime_flags = priv->systime_flags, TSCFUPDT cleared
  stmmac_update_subsecond_increment()
    writes TCR in coarse mode and the coarse SSIR
    config_addend() polls TSADDREG for up to 100 ms

CPU1 (SIOCSHWTSTAMP)
stmmac_hwtstamp_set()
  reads priv->tsfupdt_coarse == false
  priv->systime_flags = ACTIVE | TSCFUPDT | filters
  writes TCR back to fine mode

CPU0
  priv->tsfupdt_coarse = true
  priv->systime_flags = stale copy, no TSCFUPDT and no filters

The hardware ends up in fine mode with the coarse SSIR and addend, so
the PHC runs at the wrong rate. priv->systime_flags then matches neither
the hardware nor the hwtstamp request, and it is used later by flex PPS
in stmmac_enable() and by the new restore paths.

The old code set tsfupdt_coarse before the MMIO programming, so the
window was only a few instructions. Here it covers the whole
programming sequence, including the poll.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-stmmac-ptp-added-systime-error-v2-1-beb2a6b5f866%40oss.qualcomm.com
