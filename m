Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614371;
	b=Ui7f6636wczR+qqFCoZTwbXCDQzVyNblkFnm6Dc6RRdEiHTNyw611SUSv+9c5VU72DFC
	 63OGu8ORPhuG5Oky1hix4lM1L1BbGq7lYVOj5SiM8jNHEml/oVvSe+rX4kGfs5anEF3je
	 Ln/aCrBMA31eI7CjFa0V39dR4eRd/DOjVlYUbRnCp7OYlzutVYR/XVNcwgySmGveH2nZ8
	 gwcIVrsuAaIzn7cn4d8ZUrEM8VK5b8fHbZ6Ot674WyZ8QQQcxCCFvHql++oJH+EQGxzUa
	 eHOsd1aCYgivDX0l44h7ql93MiInwNx072Qk1tWOn+qlRdOqyTTk0YWBWyuy9CVwMfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614371;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=10M1G/t/korwKZ2sRQj6Qe5dF4CowjfWMMV1uNJdnG0=;
	b=iUpOnxz6ZSoArJLQBZu4l+C/4g3nhB7wHyif2jXSafqTxeP2RenS2j39OtcGGZ2AzBCe
	 vfkZynmW535vWE5vP0/5jQtFX9QVFYtDTyiN4xeqcBFsoOBLNWiVNyp0g4cEGfkkmzMZ3
	 BReVTbwtUyI5ebXLU5r88sBjcdOLJOPXjiI7Tpv8TWHX173QjaQUg/L+Jo5E/z+SdP9SZ
	 Nf/Fbk+JfdJkAFperKoroW0A+PzMU/2+NqX+MFlddeF9hHJqpHF0l2ZvSISJAUwWI+Xmf
	 pjAhzCVH3TqHzhkDpvL4Ws3D5PAoio1DNl1BOt4VCd5TUSPGijkZnALcXVHhuW8nIbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDYMVCyQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0941606A896
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDYMVCyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E420F1F000C4;
	Fri, 13 Nov 2026 23:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614370;
	bh=10M1G/t/korwKZ2sRQj6Qe5dF4CowjfWMMV1uNJdnG0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YDYMVCyQJVbzs9FhEvLBZlNImnkb5pu1WViGEFde+3I5OsB04Rv2T3ZosGe2v5M3/
	 Dk1Xnl97rmHadmvST6uDgbF9dihuVr534MuwaB0lbcDC1QYHEOGdWQmbY5wir7SyfV
	 XbOVFPo1Oh8RArpiI9AMVCcJ1gBKp7wK15xRjXdBP7T5oh7D7dkpMBg8D8HWtqgPW8
	 mY9UsuCHYTOo6oTwWDV3r8LoPA1ifhq8JUhPSDs8EDc3uaplJ2ynuRFxGqaL+JzHFa
	 f4JX/uQ/k0B2R2QNeUALKPNa1f+ynIwdz14rqiZhVD+FEaQBPBUFh6Y5cXKVCkuZPU
	 +71/unZsDqCmA==
Subject: Re: [PATCH net] net: stmmac: re-base EST after PTP settime64
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Fri, 13 Nov 2026 23:59:29 +0000
Message-ID: <179461436943.2199510.3966572269599982119@kernel.org>
In-Reply-To: <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
References: <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message gets stmmac_adjust_time() wrong, and it
  uses that function as the model for the new code.
- [Medium] stmmac_adjust_time() and stmmac_set_time() are the .adjtime
  and .settime64 callbacks in the same ops tables (stmmac_ptp.c lines…
- [Medium] In stmmac_set_time() the new code ignores the return values of
  both stmmac_est_configure(..., false) and __stmmac_setup_est(), and…

--

net: stmmac: re-base EST after PTP settime64

This patch makes stmmac_set_time() take est_lock and disable EST before
it steps the PHC with stmmac_init_systime(). Afterwards it re-bases EST
through __stmmac_setup_est(). The goal is to stop EST from running with
a stale base time after clock_settime() on the PHC.

> stmmac_set_time() initializes the PTP clock through
> stmmac_init_systime() (TSINIT) while holding only ptp_lock.  It neither
> takes est_lock nor disables and re-bases EST around the step, unlike
> stmmac_adjust_time(), which performs TSUPDT through
> stmmac_adjust_systime() under est_lock.

[ ... ]

> Take est_lock for the whole disable/step/reprogram sequence, as
> stmmac_adjust_time() does: disable EST before initializing the clock and
> call __stmmac_setup_est() afterwards so the base time is recomputed from
> the reserved taprio base time and the new clock.

[Severity: Medium]
Does this match what stmmac_adjust_time() does? In stmmac_ptp.c,
stmmac_adjust_time() releases est_lock before the step and takes it
again afterwards:

stmmac_adjust_time() {
    ...
	mutex_lock(&priv->est_lock);
	if (priv->est && priv->est->enable)
		stmmac_est_configure(priv, priv, priv->est,
				     priv->plat->clk_ptp_rate, false);
	mutex_unlock(&priv->est_lock);

	write_lock_irqsave(&priv->ptp_lock, flags);
	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
	write_unlock_irqrestore(&priv->ptp_lock, flags);

	mutex_lock(&priv->est_lock);
	if (priv->est && priv->est->enable)
		__stmmac_setup_est(priv);
	mutex_unlock(&priv->est_lock);
    ...
}

So TSUPDT runs under ptp_lock only, not under est_lock. The new
stmmac_set_time() holds est_lock across the write side of ptp_lock, and
stmmac_adjust_time() never nests the locks that way.

The est_lock -> ptp_lock (read) ordering does already exist through
__stmmac_setup_est()->gettimex64(), and stmmac_init_systime() does use
readl_poll_timeout_atomic(). That part of the ordering argument holds. The
precedent of stmmac_adjust_time() holding est_lock across the step does
not.

Could the commit message describe what stmmac_adjust_time() actually
does?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 31a66e855d6b1..6370bdc6c58b5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -129,10 +129,19 @@ static int stmmac_set_time(struct ptp_clock_info *ptp,
>  	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
>  	unsigned long flags;
>  
> +	mutex_lock(&priv->est_lock);

[Severity: Medium]
stmmac_set_time() now holds est_lock for the whole disable/step/re-base
sequence. Its sibling .adjtime callback, stmmac_adjust_time(), still
releases est_lock between disabling EST and the TSUPDT step (see the
snippet above).

Can tc_taprio_configure() still get into that window?

CPU1                                  CPU2
stmmac_adjust_time()
  mutex_lock(&priv->est_lock)
  stmmac_est_configure(..., false)
  mutex_unlock(&priv->est_lock)
                                      tc_taprio_configure()
                                        mutex_lock(&priv->est_lock)
                                        gettimex64()  /* pre-step clock */
                                        stmmac_est_configure(..., true)
                                        priv->est->enable = true
                                        mutex_unlock(&priv->est_lock)
  write_lock_irqsave(&priv->ptp_lock)
  stmmac_adjust_systime()  /* EST enabled in hardware */
  write_unlock_irqrestore(&priv->ptp_lock)
  mutex_lock(&priv->est_lock)
  __stmmac_setup_est()

In that case EST is running in hardware while the clock is stepped. That
goes against the "If EST is enabled, disabled it before adjust ptp time"
comment in stmmac_adjust_time(). The later __stmmac_setup_est() re-base
corrects the base time, so the effect lasts only as long as the window.

The commit message treats stmmac_adjust_time() as already covering this
case. Should stmmac_adjust_time() also hold est_lock across the step, so
that the .adjtime and .settime64 paths behave the same way?

> +	if (priv->est && priv->est->enable)
> +		stmmac_est_configure(priv, priv, priv->est,
> +				     priv->plat->clk_ptp_rate, false);
> +
>  	write_lock_irqsave(&priv->ptp_lock, flags);
>  	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
>  	write_unlock_irqrestore(&priv->ptp_lock, flags);
>  
> +	if (priv->est && priv->est->enable)
> +		__stmmac_setup_est(priv);
> +	mutex_unlock(&priv->est_lock);
> +
>  	return 0;
>  }

[Severity: Medium]
Should the return values of stmmac_est_configure(..., false) and
__stmmac_setup_est() be checked here?

est_configure() in stmmac_est.c writes each register through est_write().
est_write() polls with readl_poll_timeout() and can return -ETIMEDOUT. On
any failure, est_configure() returns early, before it writes EST_CONTROL
and EST_INT_EN:

est_configure() {
    ...
	if (ret)
		return ret;

	for (i = 0; i < cfg->gcl_size; i++) {
		ret = est_write(est_addr, i, cfg->gcl[i], true);
		if (ret)
			return ret;
	}
    ...
}

If the disable call fails, EEST stays set and stmmac_init_systime()
steps the clock while EST is still running. That is the situation this
patch is meant to avoid.

If the disable succeeds but the re-enable inside __stmmac_setup_est()
fails, EST stays off in hardware. __stmmac_setup_est() only logs the
error:

__stmmac_setup_est() {
    ...
	if (err) {
		netdev_err(priv->dev, "failed to re-configure EST\n");
		return err;
	}
    ...
}

priv->est->enable is still true and stmmac_set_time() returns 0. Taprio
then believes the gate schedule is active until taprio is reconfigured.
On a similar failure, tc_taprio_configure() clears priv->est->enable, and
stmmac_setup_est() passes the error up.

stmmac_adjust_time() already ignores these return values in the same way.
This patch adds the same pattern to the settime64 path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6%40oss.qualcomm.com
