Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260673;
	b=lGP0xUj3nm7hlqnlLDIAqNoTIyKQoZ1e1zz4k+UWjrc3nJBTpGXx9fqcPwA9Fvi2lFXQ
	 KApaOydiG+NgZZhvPGzCYdoLSQSyUUW7stu3IwHVOdLRV1TGXyCHrQp+bzIzg+dnXOKvF
	 fdHQQ2QsST7nNpHyky2/3A02qSeVEanruVGh5dM+pXZ/Rrvmd4w6WNAkhDBYh/DOFTopY
	 u9ih7JTZCRUBJRBSZwGPucgXcmjko69RI7+dHFsx8J/iaeoMdSoim77I/jPJTyS8XmrJ1
	 x2Aj9C7Jd19Un2lihoHxuhiSbTkUj6CWUXLVOK2/4DTMYlmHBQD0zHcrs4WPjDPYz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260673;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=289kZZ1/nkDhGKXIhpS5F5P0X4MaBgwQ5nuxC8dw4d0=;
	b=nT2fdqowOEVZsJYxjAuvpLVU980herHO2J8rL4JcEClaPoRaHksC8DoOemH0+XYurvlA
	 c2o1M8UEFUNDGpAurDVEg1PSWta3CaITcjl2zW2ry9Yrh1uWArxnHAN4tppv7HkMHHXoU
	 jOGs+QgKbh3bDO2PviY1A6ljDdrcTu7fR4ReKGwkWViWYdw7Zd/LBjkiaMy9+C5FmEqBE
	 ZAUBV64z9dqQWACArZ3pWCMHmXrOmO2yFT1pJA6QnHuIKI2l3LA+Ph+9kgxz05CeUmSvY
	 BOvyDznPF+PH/BehVHuig5zt45D1ndVZ5GRHpFnyLxqXFD3CEnNhWWXJEQp7OEr9gJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hi+mzQl3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E4606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hi+mzQl3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4491F01828;
	Thu, 29 Oct 2026 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793260672;
	bh=289kZZ1/nkDhGKXIhpS5F5P0X4MaBgwQ5nuxC8dw4d0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hi+mzQl38D9qlo9q7fBAIiD5OmatwQ0Q3AFJ+Sp7akN37lYfcsJ7NeIMLZYwmzl50
	 3eM/u2d9W98hlqDkS68N0RcHIULqdg86yqtBvPmszVfTDj0avflGSUZhb38D6aN3ds
	 8poizS666U844EJ/xunsambKRqFeO80qhGg6iJDdKIVZnkbDxKlgb3V0UG96eCLO4n
	 V7WruGu4bUtM15fLcDNfasdWHaEZcbl+uDd8CEb/GvPrsjcl0eC2BTx0F7wXLVQ7zJ
	 4UdRWTW3tMF9//pxNOZSdoHHBw/D/yDXXP3cUNB/0uJ121LasSh/fcdt02tuPQkRnn
	 h5w3wMtIFa5NA==
Subject: Re: [PATCH net v4 3/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
 james.hilliard1@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rayagond@vayavyalabs.com
Date: Thu, 29 Oct 2026 07:57:50 +0000
Message-ID: <179326067100.3134.15863707026342807337@kernel.org>
In-Reply-To: <20261026-stmmac-est-fixes-v4-3-999dac4de44f@oss.qualcomm.com>
References: <20261026-stmmac-est-fixes-v4-3-999dac4de44f@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch says it re-applies "the taprio offload" after the
  core soft reset, but it only replays the EST block.
- [Medium] The patch handles a failed EST re-apply inconsistently between
  open and resume.
- [Medium] A taprio REPLACE that is rejected only by the software checks
  in dwmac5_fpe_map_preemption_class() still tears down the installed…
- [Medium] stmmac_adjust_time() checks and clears priv->est->enable in
  one est_lock section (stmmac_ptp.c:72-79), drops the lock while it…

Pre-existing issues:
- [Low] The TX hot paths (stmmac_xmit around stmmac_main.c:4861,
  stmmac_tso_xmit, the XSK zero-copy path around 2753, and…

--

net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()

The core soft reset in stmmac_hw_setup() clears the MTL_EST registers. This
patch re-programs EST from __stmmac_open() and stmmac_resume(), recomputing
the base time from the reserved base time and the current PTP time, and
reuses the same helper in stmmac_adjust_time(). It also reworks
tc_taprio_configure() to hold est_lock across validation and programming,
and to set priv->est->enable only after hardware programming succeeds.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> index f70221c9c84af..0f0f162794c84 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h

[ ... ]

> @@ -65,3 +68,18 @@
>  #define EST_GCL_DATA			0x00000034
>  
>  extern const struct stmmac_est_ops dwmac510_est_ops;
> +
> +int __stmmac_setup_est(struct stmmac_priv *priv);
> +static inline int stmmac_setup_est(struct stmmac_priv *priv)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&priv->est_lock);
> +	if (priv->est && priv->est->enable)
> +		ret = __stmmac_setup_est(priv);

[Severity: Medium]

The commit message says this re-applies "the taprio offload" after the core
soft reset. Does stmmac_setup_est() restore everything that taprio
programmed, or only the EST block?

On a successful TAPRIO_CMD_REPLACE, tc_taprio_configure() also calls:

	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
					      qopt->mqprio.preemptible_tcs);

On GMAC5, dwmac5_fpe_map_preemption_class() writes FPE_MTL_PREEMPTION_CLASS
in GMAC5_MTL_FPE_CTRL_STS. On XGMAC, dwxgmac3_fpe_map_preemption_class()
also writes the per-queue XGMAC_Q2TCMAP field and XGMAC_MTL_FPE_CTRL_STS,
even when pclass is 0. During stmmac_hw_setup(), dwxgmac2_dma_tx_mode() then
rewrites Q2TCMAP back to the channel index:

	value |= FIELD_PREP(XGMAC_Q2TCMAP, channel);

preemptible_tcs is not saved in priv, and stmmac_fpe_map_preemption_class()
is only called from stmmac_tc.c. That means neither __stmmac_open() nor
stmmac_resume() can replay it.

So what happens after ifdown/ifup, an MTU or ring size change, or
suspend/resume? On GMAC5, would the preemptible TCs silently turn into
express TCs? On XGMAC, would the queues go back to the default queue == TC
mapping, so the EST gate masks no longer cover the intended queues?

Meanwhile __stmmac_setup_est() sets priv->est->enable = true, so taprio
would keep reporting the full offload as installed.

> +	mutex_unlock(&priv->est_lock);
> +
> +	return ret;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9e09e11cc35e5..a13a3790207d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -4201,6 +4202,10 @@ static int __stmmac_open(struct net_device *dev,
>  	if (ret)
>  		goto ptp_error;
>  
> +	ret = stmmac_setup_est(priv);
> +	if (ret)
> +		goto est_error;
> +
>  	stmmac_init_coalesce(priv);
>  
>  	phylink_start(priv->phylink);

[ ... ]

> @@ -8518,6 +8523,10 @@ int stmmac_resume(struct device *dev)
>  		ret = stmmac_init_timestamping(priv);
>  		if (ret)
>  			goto error_stop_dma;
> +
> +		ret = stmmac_setup_est(priv);
> +		if (ret)
> +			goto error_stop_dma;
>  	}
>  
>  init_coalesce:

[Severity: Medium]

The callers seem to handle a failed EST re-apply in different ways. There
are a few cases.

In __stmmac_open(), stmmac_setup_ptp() can return 0 without enabling PTP:

stmmac_setup_ptp() {
    ...
	if (stmmac_init_ptp_clk_freq(priv)) {
		clk_disable_unprepare(priv->plat->clk_ptp_ref);
		return 0;
	}
    ...
}

This can happen when clk_ptp_rate is 0. For example, qcom-ethqos re-reads
clk_get_rate() in ethqos_ptp_clk_freq_config() on every open, so the rate
can become 0 after an earlier successful taprio REPLACE.

stmmac_setup_est() still runs in that case. __stmmac_setup_est() reads the
time through gettimex64 with the timestamp counter never initialised, and
est_configure() returns -EINVAL for a zero ptp_rate. Wouldn't ndo_open then
fail, where it succeeded before this patch?

In stmmac_resume(), any EST programming error (for example -ETIMEDOUT from
est_write()) now goes to error_stop_dma. That path stops DMA, disables the
MAC, powers down the serdes and returns without calling
netif_device_attach(), while netif_running() is still true. Is it intended
that losing EST now leaves the interface dead after resume?

Also in stmmac_resume(), when stmmac_init_ptp_clk_freq() fails, the code
jumps to init_coalesce and skips stmmac_setup_est(). Resume then returns
success with priv->est->enable still true, even though the soft reset has
cleared MTL_EST. Isn't that the stale state the commit message says it
removes?

When __stmmac_setup_est() fails, it returns without clearing
priv->est->enable:

	if (err) {
		netdev_err(priv->dev, "failed to re-configure EST\n");
		return err;
	}

For the open and resume callers the flag was already true on entry. It
stays true while EEST is off or only partly programmed. The commit message
says the helper "only marks the offload enabled once the hardware
programming succeeds". Does that hold for these callers?

Finally, stmmac_adjust_time() ignores the return value of the same helper.
Should the three callers share one failure policy?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 9a32af00d7d2d..81ee896698653 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c

[ ... ]

> @@ -69,14 +69,14 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	nsec = reminder;
>  
>  	/* If EST is enabled, disabled it before adjust ptp time. */
> +	mutex_lock(&priv->est_lock);
>  	if (priv->est && priv->est->enable) {
>  		est_rst = true;
> -		mutex_lock(&priv->est_lock);
>  		priv->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate, false);
> -		mutex_unlock(&priv->est_lock);
>  	}
> +	mutex_unlock(&priv->est_lock);
>  
>  	write_lock_irqsave(&priv->ptp_lock, flags);
>  	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
> @@ -84,31 +84,9 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  
>  	/* Calculate new basetime and re-configured EST after PTP time adjust. */
>  	if (est_rst) {
> -		struct timespec64 current_time, time;
> -		ktime_t current_time_ns, basetime;
> -		u64 cycle_time;
> -
>  		mutex_lock(&priv->est_lock);

[ ... ]

> -		ret = stmmac_est_configure(priv, priv, priv->est,
> -					   priv->plat->clk_ptp_rate, true);
> +		__stmmac_setup_est(priv);
>  		mutex_unlock(&priv->est_lock);
> -		if (ret)
> -			netdev_err(priv->dev, "failed to configure EST\n");
>  	}

[Severity: Medium]

est_lock is dropped between clearing priv->est->enable and calling
__stmmac_setup_est() here. est_rst is not re-checked once the lock is taken
again. Can a taprio operation that runs inside that window get overridden?

ptp_clock_adjtime() does not take RTNL, so this ordering looks possible:

CPU1 (stmmac_adjust_time)
  mutex_lock(&priv->est_lock);
  est_rst = true;
  priv->est->enable = false;
  mutex_unlock(&priv->est_lock);
  stmmac_adjust_systime();

CPU2 (tc_taprio_configure, TAPRIO_CMD_DESTROY)
  mutex_lock(&priv->est_lock);
  priv->est->enable = false;
  stmmac_est_configure(..., false);
  stmmac_fpe_map_preemption_class(..., 0);
  mutex_unlock(&priv->est_lock);

CPU1
  mutex_lock(&priv->est_lock);
  __stmmac_setup_est(priv);
    stmmac_est_configure(..., true);
    priv->est->enable = true;

A REPLACE that fails and goes to disable: would race the same way.

The disable: path leaves gcl, ctr, btr_reserve and max_sdu[] in priv->est.
Would the old schedule, or the rejected one, then be programmed back into
hardware with enable set to true after the qdisc offload is gone? If so, the
TX/XDP paths would keep dropping frames larger than the stale max_sdu[].

__stmmac_open() and stmmac_resume() now trust that flag, so the schedule
would also be re-armed on every ifup and resume. taprio would not send
another DESTROY because q->offloaded is already false.

Should the decision to re-enable be re-validated under est_lock before
__stmmac_setup_est() is called?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index ac926c60f9f9a..95c5f6100c66a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1060,13 +1065,26 @@ static int tc_taprio_configure(struct stmmac_priv *priv,

[ ... ]

> -		priv->est->gcl[i] = delta_ns | (gates << wid);
> +		gcl[i] = delta_ns | (gates << wid);
>  	}
>  
> -	mutex_lock(&priv->est_lock);
> +	if (!priv->est) {
> +		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
> +					 GFP_KERNEL);
> +		if (!priv->est) {
> +			ret = -ENOMEM;
> +			goto error_unlock;
> +		}
> +	} else {
> +		memset(priv->est, 0, sizeof(*priv->est));
> +	}

[Severity: Low]

This is a pre-existing issue and was not introduced by this patch. The TX
hot paths read priv->est, priv->est->enable and priv->est->max_sdu[] with
plain loads and without est_lock. For example, in stmmac_xmit():

	if (priv->est && priv->est->enable &&
	    priv->est->max_sdu[queue]) {

stmmac_tso_xmit(), stmmac_xdp_xmit_zc() and stmmac_xdp_xmit_xdpf() do the
same.

The writers hold only est_lock. They use plain stores, a memset() of the
live struct, and a devm_kzalloc() pointer publish with no release ordering.

Could a REPLACE that runs concurrently with transmit briefly let oversize
frames through, or drop them? Two ways this could happen: the memset
temporarily zeroes max_sdu[], or a weakly ordered CPU sees the new pointer
before its zeroing is visible.

This patch does improve the ordering somewhat, since enable is now set only
after max_sdu[] is populated. The effect is limited to transient per-packet
filtering decisions.

> +	memcpy(priv->est->gcl, gcl, sizeof(*gcl) * qopt->num_entries);
> +	priv->est->gcl_size = qopt->num_entries;
> +
>  	/* Adjust for real system time */
>  	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
>  				       NULL);

[ ... ]

> @@ -1102,11 +1119,15 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	if (ret)
>  		goto disable;

[Severity: Medium]

The commit message says "A rejected REPLACE then leaves the currently
installed schedule intact in both software and hardware". However,
stmmac_fpe_map_preemption_class() can still reject the request after
priv->est has been memset, overwritten with the new schedule and programmed
into hardware.

dwmac5_fpe_map_preemption_class() returns -EINVAL with an extack message
based only on configuration checks, before it writes any register:

		if (priv->xmit_qdisc.algo == MTL_TX_ALGORITHM_SP) {
			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
			return -EINVAL;
		}

It does the same for unequal queue weights within a TC. That error goes to
disable:, which clears priv->est->enable, disables EST in hardware and
resets the preemption class to 0.

On the taprio side, taprio_enable_offload() returns the error before it
touches q->offloaded, which stays true from the previous schedule.
taprio_change() then goes to free_sched without installing the new admin
schedule. Doesn't this leave the qdisc reporting the old schedule as
offloaded while hardware EST is off?

enable is now false, so stmmac_setup_est() will not restore the schedule on
a later open or resume either.

One way to hit this:

1. Install an express-only schedule with a TC mapped to two queues. This is
   accepted, because pclass == 0 skips the checks.
2. Run tc qdisc change to mark that TC preemptible.

Should the FPE mapping checks run before the installed configuration is
replaced?

> +
> +	priv->est->enable = true;
> +
> +	mutex_unlock(&priv->est_lock);
> +	kfree(gcl);
> +
>  	return 0;
>  
>  disable:
>  	if (priv->est) {
> -		mutex_lock(&priv->est_lock);
>  		priv->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate, false);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-stmmac-est-fixes-v4-0-999dac4de44f%40oss.qualcomm.com
