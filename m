Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616568;
	b=K465P2glT33Dr/VZi+cGbHXukcp85MARCSnTqjuL0SbKQjYwoA+Lg7nmXOVQJeXloVav
	 ILjCr26/7xtQg3+x1Fmv45y6G24M3GEb07pxbEF1wL6i3KPRqqTlEOBOGykH7lpQqIJjt
	 WXGKHgmdNxVO0azibLhxgB7vpy6Qk3SEz75j/XPLzlXPvCb6apWZkyscaQNvu1BtOPopx
	 mMT9QrKuLCHgqmJHLZG//MybX4igpKaV3whO7t4cDNjwbEoHCFZUEqKchpQ2p+rIanYhY
	 1OyEoE2EH7A38TVqooswOmzs2zURLMN51fdJqlcvWzta53aWuLmyl2zedLn/vI3Pglg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616568;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HDDq/MvvkV1iflnZhi9UKrVHsp1+yAZtEKY+IxthsFk=;
	b=s02IP1+H4nl2pylpdTcIwyFxp8std68EWyMW00A0kkcHujUKpQ/i7eJeVoKedF5BocQx
	 hp7q5Ffi79fnVtcM7vVW8Mi+9yUPV3X++wydVAM1ovImtU3edPsvRJQ+bKMptz/nZA91N
	 eYz/a+ccbTKArQit7lf+cjO3/rifT1sTknSJycl75LEU1coJdtPZmx3J1cSajGv/yahKO
	 458vwGvONn9KRsPOoJ1r7cQzokjcXBphbzRhSG4JXSwdak3Qrkf3Fhue29YT+V9m3RZJY
	 7UrIK5OzaSyoE2L7JrIXxeAO3y1Pq19+xtlvaRlLZGdpc9ZUHCJanlwPvZq3Yls6bSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkSzUU61;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC6606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkSzUU61
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6921F000C1;
	Mon,  2 Nov 2026 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616567;
	bh=HDDq/MvvkV1iflnZhi9UKrVHsp1+yAZtEKY+IxthsFk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AkSzUU61h3yRkfMSMNL0m5COw/8VI4gR3K8LuztxSP34FgwrIOMHxuEGqnnPS16sQ
	 MJw5D0i/KTOBCmsI2tLaBtmRm0CUnr2gijFu4d4llo4PbTMu9pGV/SL3DoOPcZg4Q6
	 5WxR3lvaeEIfymoaw32ASdZSpcNeyAzyaXKDwLZ0pvR0o/cmlsKTbR1cRcE/vgDOOv
	 b7Z/jdZDsjC1ity0i5VtkRTszg2wVY9CCDiWbHkJlUWErPbewBmy7RKcACn8CQRpy5
	 obMKx0bf7YzW3qR/zrUW4Z5iuPgtcJi/rFsZ0Broj+qyZJHCTBftlAHqWgNsd2mHRd
	 q9Bjdtx0ghTwQ==
Subject: Re: [PATCH net v5 2/3] net: stmmac: pass the desired EST enable state
 to est_configure()
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
 james.hilliard1@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rayagond@vayavyalabs.com
Date: Mon, 02 Nov 2026 10:49:26 +0000
Message-ID: <179361656635.3131.18359030964578099180@kernel.org>
In-Reply-To: <20261029-stmmac-est-fixes-v5-2-85b830a795a9@oss.qualcomm.com>
References: <20261029-stmmac-est-fixes-v5-2-85b830a795a9@oss.qualcomm.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit says "No functional change intended", but there is a
  change when stmmac_adjust_time() runs concurrently.

Pre-existing issues:
- [High] This happens at this commit in tc_taprio_configure()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c).
- [High] At this commit stmmac_adjust_time() (stmmac_ptp.c:72) checks
  priv->est->enable without est_lock.
- [Medium] est_configure()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_est.c) rewrites…
- [Medium] At this commit stmmac_adjust_time() decides est_rst from an
  unlocked read of priv->est->enable (stmmac_ptp.c:72-73) and drops…

--

net: stmmac: pass the desired EST enable state to est_configure()

This patch adds an explicit enable argument to est_configure() so it no
longer reads cfg->enable. The callers in stmmac_adjust_time() and
tc_taprio_configure() now pass true or false directly, and they still set
priv->est->enable around the EST programming as before.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> index afc516059b897..f15d4d046aa74 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c

[ ... ]

> @@ -62,7 +62,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
>  		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
>  			 EST_GMAC5_PTOV_SHIFT;
>  	}
> -	if (cfg->enable)
> +	if (enable)
>  		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;
>  	else
>  		ctrl &= ~EST_EEST;

[Severity: Medium]
This isn't a bug introduced by this patch, but when enable is false,
est_configure() still rewrites BTR, TER, LLR, CTR and the whole GCL
through est_write() before it gets here:

    ret |= est_write(est_addr, EST_BTR_LOW, cfg->btr[0], false);
    ...
    if (ret)
        return ret;

    for (i = 0; i < cfg->gcl_size; i++) {
        ret = est_write(est_addr, i, cfg->gcl[i], true);
        if (ret)
            return ret;
    }

If one of the SRWO polls in est_write() times out, the function returns
before it clears EST_EEST here and before it zeroes EST_INT_EN.

The disable callers ignore that return value and set
priv->est->enable = false anyway. These are the disable: label in
tc_taprio_configure() and the quiesce block in stmmac_adjust_time().

On TAPRIO_CMD_DESTROY, tc_taprio_configure() returns only the result of
stmmac_fpe_map_preemption_class(), so taprio treats the offload as
removed.

Could the MAC keep gating TX with the old schedule, with EST interrupts
still on, while software thinks EST is off? This ordering is unchanged at
the end of the series.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index e54a3c8878265..9a32af00d7d2d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -74,7 +74,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		mutex_lock(&priv->est_lock);
>  		priv->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->est,
> -				     priv->plat->clk_ptp_rate);
> +				     priv->plat->clk_ptp_rate, false);
>  		mutex_unlock(&priv->est_lock);
>  	}

[Severity: High]
This is a pre-existing issue, but the check that guards this block reads
priv->est->enable without holding est_lock:

    if (priv->est && priv->est->enable) {
        est_rst = true;
        mutex_lock(&priv->est_lock);

A TAPRIO_CMD_REPLACE in tc_taprio_configure() drops est_lock between
steps:

    mutex_lock(&priv->est_lock);
    memset(priv->est, 0, sizeof(*priv->est));
    mutex_unlock(&priv->est_lock);
    ...
    mutex_lock(&priv->est_lock);
    priv->est->gcl_size = size;
    priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
    mutex_unlock(&priv->est_lock);

    for (i = 0; i < size; i++) {
        ...
        priv->est->gcl[i] = delta_ns | (gates << wid);
    }

    mutex_lock(&priv->est_lock);
    /* ctr[] and btr_reserve[] are filled only here */

Suppose the second est_lock section of stmmac_adjust_time() runs in that
gap. It then computes:

    cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
                 priv->est->ctr[0];    /* still 0 */
    time = stmmac_calc_tas_basetime(basetime, current_time_ns,
                                    cycle_time);

and stmmac_calc_tas_basetime() does:

    n = div64_s64(ktime_sub_ns(current_time, old_base_time),
                  cycle_time);

Can this divide by zero and oops on x86? It would also program a GCL
that is still half written through est_configure(..., true).

This looks to be addressed later in the series by "net: stmmac: re-apply
taprio offload in __stmmac_open() and stmmac_resume()". That commit:

  - holds est_lock across the whole validate, memset and program
    sequence in tc_taprio_configure()
  - sets enable only after programming succeeds
  - checks enable under est_lock in stmmac_adjust_time()

> @@ -105,7 +105,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		priv->est->btr[1] = (u32)time.tv_sec;
>  		priv->est->enable = true;
>  		ret = stmmac_est_configure(priv, priv, priv->est,
> -					   priv->plat->clk_ptp_rate);
> +					   priv->plat->clk_ptp_rate, true);
>  		mutex_unlock(&priv->est_lock);
>  		if (ret)
>  			netdev_err(priv->dev, "failed to configure EST\n");

[Severity: Medium]
This isn't a bug introduced by this patch, but est_rst comes from the
unlocked check before the first critical section. Nothing is re-checked
here after est_lock was dropped around the systime step.

A TAPRIO_CMD_DESTROY can land in that gap:

CPU1 (stmmac_adjust_time)        CPU2 (tc_taprio_configure, DESTROY)
est_rst = true
priv->est->enable = false
est_configure(..., false)
mutex_unlock(&priv->est_lock)
                                 disable:
                                 priv->est->enable = false
                                 est_configure(..., false)
                                 returns success
stmmac_adjust_systime()
mutex_lock(&priv->est_lock)
priv->est->enable = true
est_configure(..., true)

Does this bring back a schedule that taprio has already removed? The
xmit paths would then also enforce the priv->est->max_sdu[] drops again.

The same later commit, "net: stmmac: re-apply taprio offload in
__stmmac_open() and stmmac_resume()", appears to fix this. It re-checks
priv->est && priv->est->enable under est_lock before calling
__stmmac_setup_est(), and stmmac_adjust_time() no longer writes the
enable flag.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index aea235a69105e..ac926c60f9f9a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1090,7 +1090,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
>  	ret = stmmac_est_configure(priv, priv, priv->est,
> -				   priv->plat->clk_ptp_rate);
> +				   priv->plat->clk_ptp_rate, true);

[Severity: Low]
The commit message says:

  No functional change intended: the callers keep toggling
  priv->est->enable around the EST programming, as before.

Does that still hold when stmmac_adjust_time() runs at the same time?

Before this patch, this call read cfg->enable under est_lock. The REPLACE
path sets enable = true in an earlier critical section and then drops
est_lock while it fills the GCL. Consider this sequence:

CPU1 (tc_taprio_configure, REPLACE)  CPU2 (stmmac_adjust_time)
priv->est->enable = true
mutex_unlock(&priv->est_lock)
fill priv->est->gcl[]
                                     priv->est->enable = false
                                     est_configure(..., false)
                                     mutex_unlock(&priv->est_lock)
mutex_lock(&priv->est_lock)
est_configure(..., true)
                                     stmmac_adjust_systime()

With the old code, the REPLACE would program EST with EEST cleared,
because cfg->enable was false. EST then stayed off across the time step.

With the hard-coded true, EST is turned on with a BTR computed from the
pre-step time. The PHC step then happens with EST active while
priv->est->enable is false, until the second section of
stmmac_adjust_time() reprograms it.

The underlying race is pre-existing, since no lock covers the time step
together with the EST programming. Still, this interleaving behaves
differently after this patch, and the window remains at the end of the
series.

>  	mutex_unlock(&priv->est_lock);
>  	if (ret) {
>  		netdev_err(priv->dev, "failed to configure EST\n");
> @@ -1109,7 +1109,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		mutex_lock(&priv->est_lock);
>  		priv->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->est,
> -				     priv->plat->clk_ptp_rate);
> +				     priv->plat->clk_ptp_rate, false);

[Severity: High]
This is a pre-existing issue, but the entry validation loop earlier in
tc_taprio_configure() returns directly instead of going through this
disable: label:

    priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
    mutex_unlock(&priv->est_lock);

    for (i = 0; i < size; i++) {
        ...
        if (delta_ns > GENMASK(wid - 1, 0))
            return -ERANGE;
        if (gates > GENMASK(31 - wid, 0))
            return -ERANGE;
        ...
        default:
            return -EOPNOTSUPP;
        }

By that point priv->est has already been memset. So a REPLACE with one
invalid interval, gate mask or command leaves enable == true while ctr[]
and btr_reserve[] are zero.

taprio_disable_offload() does not call back into the driver when the
first offload attempt failed, so nothing clears the flag later.

A later clock_adjtime(ADJ_SETOFFSET) on the PHC then does:

stmmac_adjust_time()
  cycle_time = 0
  stmmac_calc_tas_basetime(0, now, 0)
    div64_s64(now, 0)

Can this divide by zero and oops on x86?

This also looks to be fixed later in the series by "net: stmmac: re-apply
taprio offload in __stmmac_open() and stmmac_resume()". That commit
validates every entry into a temporary kcalloc() buffer before it touches
priv->est, and sets enable only after programming succeeds.

>  		/* Reset taprio status */
>  		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
>  			priv->xstats.max_sdu_txq_drop[i] = 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-stmmac-est-fixes-v5-0-85b830a795a9%40oss.qualcomm.com
