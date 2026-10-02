Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488A2110E
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903584; cv=none; b=ciLBIyBnN1UEc0F8Ska8sCCoefY/S3dn9kKys9vFwdcL05slJoeuq3RT6SitBDzaQpyzqmyHPwYYv3dFXO/07li4HmSxw4YQyumz5l8tU71HqY980PNca5HbCRtA4X8aXJ9tL2raYg7I4QAiziuTUxZmt31V3z6hrHfNUwnS4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903584; c=relaxed/simple;
	bh=RtN6cuk089rJfKcqxE8ukDwVRbDRsgKr4+A/63DvSXk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oB4Ox1sm+RtyPq62uxuySlAUUWTMkCLP9mHBULKUv1+waQAXDKcdVQMCIxTUNw83yAIeO1XcDlxv2edpxBw4kUY143wElustIbtdvCoFEAdREaF0U2fRpZ0LlLZGVyxbZyVrhCHUw/LHRIDlqsNbtYuymHClPGTWYztUwfc/fJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtgl3YNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtgl3YNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61F21F00893;
	Fri,  2 Oct 2026 01:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790903582;
	bh=aoTpE2ADbHhF5AHqrYirj9w5G28axss/o40l2agnYxk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vtgl3YNnHEM7VrwDEspm3/7ijP1wuieewKYjMPKhJ5va5b4kHSwNKJdQLhR+HOaCd
	 +ayuuTU9/oGLlawC92wTEd1jQrKBrcFoNgVaDmjmiE6QCCx59uWnSWRG/6iR1kl3xY
	 sKq634XFsGH5HU0vCIwtBEs90UK88F4S+bm4F/E0l+vpshWBsOXN4O75xVl2BpFYgY
	 mljo8Ap02RXmRqHRYAr8ndWLIwGWPtw73jiQd1DpfUXPez6DA9LGkipH6/tH5VYH6Z
	 8H5KzfKHnbuwi1fuq54OC1JyhVphxV4QwfR9063wPSJ4s6ClcflLKEJ7f4s7Qk4VLd
	 FzHuWGby9lSSw==
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Fri, 02 Oct 2026 01:13:01 +0000
Message-ID: <179090358124.434549.2519589736975087239@kernel.org>
In-Reply-To:
 <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
References:
 <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Every ifup and every resume now silently resets the documented
  runtime devlink parameter `phc_coarse_adj`.
- [Medium] The commit message says that on failure the patch will 'roll
  back the partially applied configuration so the hardware and the…
- [Medium] After a failed timestamp-counter init, later timestamping and
  TAPRIO operations can still use the failed counter.
- [Medium] The hardware rollback in stmmac_update_subsecond_increment()
  is incomplete when stmmac_config_addend() times out (line 647).
- [Medium] The patch opens a lost-update race between
  stmmac_dl_ts_coarse_set() and the rtnl-protected timestamping paths.
- [Medium] When stmmac_init_systime() fails, stmmac_init_tstamp_counter()
  calls stmmac_restore_subsecond_increment(priv, default_addend) (line…

Pre-existing issues:
- [Low] The kernel-doc for stmmac_init_timestamping() says 'This function
  also registers the ptp driver.', but the function only configures the…

--

net: stmmac: propagate PTP addend and system time programming errors

This patch makes stmmac_update_subsecond_increment(),
stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
settime64/adjfine PHC callbacks return the errors from the addend and
system time programming hooks instead of always reporting success. On
failure it rolls back the partially applied configuration, and it adds a
guard against a zero sub-second increment. It also resets the persistent
timestamping state whenever timestamping is (re)initialized.

> settime64/adjfine callbacks instead of silently returning success. On
> failure, roll back the partially applied configuration so the hardware
> and the driver bookkeeping stay consistent, and report the reason
> through the devlink extack.

[Severity: Medium]
Does this hold for both failure paths?

In stmmac_update_subsecond_increment(), stmmac_config_addend() can time out.
At that point PTP_TAR already holds the new addend and TSADDREG is still
pending. The error label only restores the PTP_TCR flags and the sub-second
increment. The hardware can then end up with a new-mode addend and an
old-mode SSINC, while priv->default_addend keeps the old value.

In stmmac_init_tstamp_counter(), the rollback through
stmmac_restore_subsecond_increment() uses priv->systime_flags. By then,
stmmac_init_timestamping() has already overwritten that field with the new
fine-mode defaults. So the SSINC is recomputed for the new flags, but the
old default_addend is restored. That addend can be 0 on first open or a
coarse-mode value, and any addend applied by adjfine is lost.

Both cases are covered in more detail inline below. Could the commit message
and the "Restore previous configuration" comments be changed to match what
the error paths actually leave behind?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ec62fa7418f41..9741f97fa37a2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -601,31 +601,64 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,

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
> +	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
> +	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
> +					   priv->plat->clk_ptp_rate, xmac,
> +					   NULL);
> +	return ret;
>  }

[Severity: Medium]
If stmmac_config_addend() times out, does the new addend stay latched?

config_addend() writes PTP_TAR and sets TSADDREG before it polls:

drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c:config_addend() {
    ...
	writel(addend, ioaddr + PTP_TAR);
	/* issue command to update the addend value */
	value = readl(ioaddr + PTP_TCR);
	value |= PTP_TCR_TSADDREG;
	writel(value, ioaddr + PTP_TCR);
    ...
}

So on -ETIMEDOUT, the TAR write and the latch request are both still
pending.

config_hw_tstamping() does a read-modify-write that clears only the
STMMAC_HWTS_CFG_MASK bits. TSADDREG is not in that mask, so TSADDREG=1 is
written back. PTP_TAR is never restored.

Here is an example. Switch devlink phc_coarse_adj from fine to coarse on a
125 MHz PTP clock, and val computes to 0. If TSADDREG then times out, the
rollback puts the MAC back in fine mode (TSCFUPDT=1) with the old SSINC.
priv->default_addend still holds the old fine value.

If the pending latch completes later, the fine-mode accumulator runs with
addend 0. The counter would stop advancing until the next adjfine.

The v3 changelog says "Do not run stmmac_config_addend() in
stmmac_update_subsecond_increment() error path", which leaves this case
open. Is that intended?

> @@ -854,35 +887,42 @@ static int stmmac_hwtstamp_get(struct net_device *dev,

[ ... ]

> -static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
> -				      u32 systime_flags)
> +static int stmmac_init_tstamp_counter(struct stmmac_priv *priv)
>  {
> +	u32 default_addend = priv->default_addend;
>  	struct timespec64 now;
> +	int ret;

[ ... ]

> +	ret = stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
> +				  now.tv_nsec);
> +	if (ret)
> +		goto error;
>  
>  	return 0;
> +error:
> +	/* Restore previous configuration */
> +	stmmac_restore_subsecond_increment(priv, default_addend);
> +
> +	return ret;
>  }

[Severity: Medium]
What does this restore when stmmac_init_systime() fails?

Before calling in here, stmmac_init_timestamping() has already set
priv->systime_flags to STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT. So
stmmac_restore_subsecond_increment() writes the same fine-mode TCR and SSIR
values that were just programmed. The only real rollback is PTP_TAR, which
is set to the saved default_addend.

On first open that saved value is 0, because netdev priv is zeroed. In fine
mode an addend of 0 means the accumulator never overflows, so the counter is
frozen. On resume after coarse mode was active, the saved value is the
coarse addend. At 125 MHz that is 0, while fine mode needs 0x80000000.

stmmac_restore_subsecond_increment() also stores this value:

	priv->default_addend = default_addend;

Later stmmac_adjust_freq() calls then scale from a base of 0. The PHC stays
registered on resume, so can it recover without a full re-init?

There is also an ordering question in stmmac_restore_subsecond_increment():

	stmmac_config_addend(priv, priv->ptpaddr, default_addend);
	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);

After a TSINIT timeout, TSINIT is still set in PTP_TCR. config_addend() does
its own read-modify-write of PTP_TCR, which keeps TSINIT=1 and adds
TSADDREG. It then busy-waits up to another 100 ms on a clock domain that is
probably not responding. Is that extra wait in the failure path expected?

> @@ -905,8 +945,14 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. The
kernel-doc above stmmac_init_timestamping() still says:

 * This function also registers the ptp driver.

The function does not register anything. The caller, stmmac_setup_ptp(),
does:

	if (stmmac_init_timestamping(priv) == 0)
		stmmac_ptp_register(priv);

Could that line in the comment be dropped?

>  		return -EOPNOTSUPP;
>  	}
>  
> -	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
> -					       PTP_TCR_TSCFUPDT);
> +	/* Reset hw ts configuration */
> +	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
> +	priv->systime_flags = STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT;
> +	priv->tsfupdt_coarse = false;

[Severity: Medium]
Does this throw away the devlink phc_coarse_adj setting on every open and
resume?

stmmac_init_timestamping() runs from stmmac_setup_ptp() on open and from
stmmac_resume(). The phc_coarse_adj parameter is registered with only
DEVLINK_PARAM_CMODE_RUNTIME, and the devlink core does not cache runtime
values. stmmac_dl_ts_coarse_get() just reports the field:

	ctx->val.vbool = priv->tsfupdt_coarse;

So after "ip link set dev X down/up", an MTU change that reopens the device,
or a suspend/resume, the PHC goes back to fine mode and devlink reports
false.

The other place that builds systime_flags, stmmac_hwtstamp_set(), still
honours the setting:

	priv->systime_flags = STMMAC_HWTS_ACTIVE;
	if (!priv->tsfupdt_coarse)
		priv->systime_flags |= PTP_TCR_TSCFUPDT;

The commit message explains the reset "so a failed init does not leave TX/RX
timestamping enabled on a counter that never started". tsfupdt_coarse is a
clock mode chosen by the user, not a timestamp-enable flag.

Before this patch the bool was kept, even though the hardware was forced to
fine mode, which was a separate inconsistency. Would it work to keep
tsfupdt_coarse and derive the flags from it, for example:

	priv->systime_flags = STMMAC_HWTS_ACTIVE |
			      (priv->tsfupdt_coarse ? 0 : PTP_TCR_TSCFUPDT);

Documentation/networking/devlink/stmmac.rst recommends coarse mode for Grand
Master operation. With this reset, that setup falls back to fine mode after
any suspend/resume or link down/up.

> +	priv->hwts_tx_en = 0;
> +	priv->hwts_rx_en = 0;
> +
> +	ret = stmmac_init_tstamp_counter(priv);
>  	if (ret) {
>  		netdev_warn(priv->dev, "PTP init failed\n");
>  		return ret;

[Severity: Medium]
The error is now returned from here, but do the callers do anything with it?

On open, stmmac_setup_ptp() only skips stmmac_ptp_register(), and
__stmmac_open() still succeeds. On resume the return value is ignored:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_resume() {
    ...
	stmmac_init_timestamping(priv);
    ...
}

The PHC stays registered, stmmac_get_time() keeps returning success with the
stopped counter's value, and the device is reattached.

hwts_tx_en/hwts_rx_en are cleared before init, and nothing records that init
failed. A later stmmac_hwtstamp_set() checks only:

	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {

and netif_running(). It then sets hwts_rx_en/hwts_tx_en, programs PTP_TCR
and returns success without retrying init. If resume fails, adv_ts keeps its
earlier value.

tc_taprio_configure() in stmmac_tc.c also still takes the EST base time from
the counter without checking whether init succeeded:

	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);

The commit message gives TAPRIO/EST as the motivation, and describes the old
behaviour as the driver "operating as if timestamping were up". Isn't the
resume path still doing that?

[ ... ]

> @@ -7711,18 +7753,26 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  {
>  	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
>  	struct stmmac_priv *priv = dl_priv->stmmac_priv;
> +	u32 systime_flags = priv->systime_flags;
> +	int ret;

[ ... ]

> -	stmmac_update_subsecond_increment(priv);
> +	ret = stmmac_update_subsecond_increment(priv, systime_flags);
> +	if (ret) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "failed to reconfigure PTP adjustment");
> +		return ret;
> +	}
> +
> +	priv->tsfupdt_coarse = ctx->val.vbool;
> +	priv->systime_flags = systime_flags;

[Severity: Medium]
Can this snapshot-then-commit ordering lose an update made at the same time
by stmmac_hwtstamp_set()?

The devlink param set runs under devl_lock only, without rtnl.
stmmac_hwtstamp_set() (rtnl) and stmmac_init_timestamping() (rtnl, plus
priv->lock on resume) write the same fields and PTP_TCR, and neither takes
devl_lock.

This function now takes a snapshot of the flags and then programs PTP_TCR,
SSIR and TAR. That includes a TSADDREG poll of up to 100 ms. Only after that
are tsfupdt_coarse and systime_flags published. When enabling coarse mode,
this sequence looks possible:

devlink                                SIOCSHWTSTAMP
stmmac_dl_ts_coarse_set()
  systime_flags = priv->systime_flags
  stmmac_update_subsecond_increment()
    TCR coarse, coarse SSINC/addend
                                       stmmac_hwtstamp_set()
                                         sees tsfupdt_coarse == false
                                         priv->systime_flags =
                                           ACTIVE | TSCFUPDT | filters
                                         hwts_rx_en = 1
                                         TCR fine
  priv->tsfupdt_coarse = true
  priv->systime_flags = systime_flags
    (filter bits from hwtstamp_set lost)

The result is PTP_TCR in fine mode with the coarse SSINC and addend. At
125 MHz that addend is 0, so the PHC is frozen. default_addend is also 0, so
adjfine cannot recover it.

priv->systime_flags would also no longer match hwts_rx_en, tstamp_config,
or what stmmac_enable() passes to flex_pps_config for PEROUT.

Before this patch, tsfupdt_coarse was stored first, and priv->systime_flags
was read right before the hardware write. That order did not give this
mismatch. Is something serializing these paths that I'm missing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4%40oss.qualcomm.com
