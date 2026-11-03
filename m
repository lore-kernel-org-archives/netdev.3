Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727720;
	b=W6y7zKzo9p99yFWGHOOVIooOL9NMOObjGhX6Ku7PgLjwF0B+ACSq8FEd0BTZzpDzvvN2
	 66xbmUzS01WbbdPWDKM1xcQyK+ALV9vSAmIv6j+UxR1WwzOIPhXzpYqrn4QRq2GgaDjmX
	 J5fBIdHb2mVEjlrIJI93f3Y48ByxzN6wU+KfMOxuloR/dT4ulRAWiNJEMNq2Z4nnE0ZtV
	 GsvOZk9Eu/IVTDIWkjNmBvBqCvABVcxcrtFbYz0BSji+SDngPq0/4f3y/jlzUs7k7+XRI
	 2UkYf/AHOvi8ZrYriIN2Kw4n1+3y4xeBUwErbn96Ba/Dzfvz+vztnEOnjdTBTy8t7Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727720;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JNql26aG9tHWF88Mct64KKU+7DOWTgodN+wsEguXuiY=;
	b=2Q3ErxoLb+/yk1OYKjwoMD/HfJ7IAyw7UvBDXxE5f1OIbLrT1nmvowLKSluGWHOGU4+d
	 Z9fLz792cUbwZXcS6tXEkHoIhQJNewroAqO45fOy6+6GNCYQ7OwDP/XqV+t/DLFAmMo/0
	 VO0f2XkZ+mohWJK88EKh9i0cyOWjz3S31t424PTajP9sdcSY0Q6iFOUdeA5QPGXhrtv6x
	 G3tPsSkS93LXOY26rAt4+kcF4RVPTPEDSQVa2WgM3EWd/oGt778Gf2T9S3wKZw+TrPZ4l
	 7E+9Sp0vFY6OlMmVMfclfgfmItb4GDDmefPzOvP8mDCdbpvDdqzJog3zY0iA5hDuC5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWm7cxrA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C8606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWm7cxrA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF8A1F000C1;
	Tue,  3 Nov 2026 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793727720;
	bh=JNql26aG9tHWF88Mct64KKU+7DOWTgodN+wsEguXuiY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MWm7cxrASKpB82B9begYNRYvlW6WNShcwrpSAcwcPupfHMU+fsYi4GDbhnP0Z2kS3
	 rpCNuls25k5rOPDCzi0bnszkzNXFg1nt7TDt/xWmsYLAKE/fc5MKPdnz1yH7UTEuNr
	 BW8q2TEtZYgz75uRFBVWq/7CjalRhs3ISrt6PbC3C9rr3wx6jqL3dtS8L0iVBPSYJ2
	 pfL95dsASBDnzvwCnrApknamKqlG/izJnO9Xb1/ve5oMzK2lJW3MaamOHJ4Fuqyyab
	 QDrQvmQzef+cgkPO5/uMZW84ymDI0xopWD9zpTVBWz654z9fcO455nGrIO5GmxJ29o
	 CiyRmJfUPB9KQ==
Subject:
 Re: [PATCH net] net: stmmac: keep est_lock across PTP clock adjustment
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 03 Nov 2026 17:41:58 +0000
Message-ID: <179372771896.488856.1466229272637573919@kernel.org>
In-Reply-To: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
References: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch closes the EST-vs-clock-step window only in
  stmmac_adjust_time(), which serves adjtime/ADJ_SETOFFSET.

Pre-existing issues:
- [Medium] stmmac_adjust_time() discards the return value of every step
  in its disable/step/re-base sequence and always returns 0.

--

net: stmmac: keep est_lock across PTP clock adjustment

Before this patch, stmmac_adjust_time() dropped priv->est_lock while it
stepped the PTP clock. A concurrent tc_taprio_configure() could then
program EST with a base time taken from the clock before the step. The
patch keeps est_lock held across the whole disable/step/reprogram
sequence.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index a37405534bebf..6ad6c2f52a0d2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -73,14 +73,12 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	if (priv->est && priv->est->enable)
>  		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate, false);

[Severity: Medium]
This isn't a bug introduced by this patch, but stmmac_adjust_time()
ignores the return value of all three steps in this sequence and always
returns 0.

The disable call above can fail before EST_EEST is cleared.
est_configure() returns early on a zero ptp_rate or on an est_write()
SRWO poll timeout, and both returns come before the EST_CONTROL write:

drivers/net/ethernet/stmicro/stmmac/stmmac_est.c:est_configure() {
	if (!ptp_rate) {
		netdev_warn(priv->dev, "Invalid PTP rate");
		return -EINVAL;
	}

	ret |= est_write(est_addr, EST_BTR_LOW, cfg->btr[0], false);
	...
	if (ret)
		return ret;
	...
	else
		ctrl &= ~EST_EEST;

	writel(ctrl, est_addr + EST_CONTROL);
	...
}

In that case, is the clock stepped with the old schedule still armed?

stmmac_adjust_systime() can return -ETIMEDOUT if PTP_TCR_TSUPDT never
clears. Even then, the code recomputes the base time and re-enables EST.

If __stmmac_setup_est() fails, it logs "failed to re-configure EST" and
the error is dropped. EST_EEST and EST_INT_EN can then stay cleared while
priv->est->enable stays true.

In all three cases, ptp_clock_adjtime() reports success to userspace.

Commit 23d96de472f7 says that the third case is intentional: "On a
failed re-apply the open and resume callers abort, while
stmmac_adjust_time() keeps the offload configured." Should the disable
and adjust_systime failures still be propagated, though?

> -	mutex_unlock(&priv->est_lock);
>
>  	write_lock_irqsave(&priv->ptp_lock, flags);
>  	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
>  	write_unlock_irqrestore(&priv->ptp_lock, flags);
>
>  	/* Calculate new basetime and re-configured EST after PTP time adjust. */
> -	mutex_lock(&priv->est_lock);
>  	if (priv->est && priv->est->enable)
>  		__stmmac_setup_est(priv);
>  	mutex_unlock(&priv->est_lock);

[Severity: Medium]
This closes the window for adjtime, but what about the settime64 path?
The commit message says:

  Keep est_lock held for the whole disable/step/reprogram sequence so no
  other EST user can program the block while the clock is being stepped.

stmmac_set_time() also steps the PHC, but it only takes ptp_lock:

drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:stmmac_set_time() {
	...
	write_lock_irqsave(&priv->ptp_lock, flags);
	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
	write_unlock_irqrestore(&priv->ptp_lock, flags);

	return 0;
}

It never takes est_lock, never disables EST before the step and never
calls __stmmac_setup_est() afterwards.

tc_taprio_configure() holds est_lock, reads the clock with gettimex64(),
computes priv->est->btr[] with stmmac_calc_tas_basetime(), and then calls
stmmac_est_configure(..., true). A concurrent
clock_settime()->ptp_clock_settime()->stmmac_set_time() is not excluded
by est_lock, so it can step the clock between that read and the
programming.

Doesn't that leave the same stale base time race open through settime64?

There is a second effect. A taprio schedule installed before a
clock_settime() is never re-based, so it keeps its old base time until
taprio is reconfigured.

Should stmmac_set_time() use the same disable/step/__stmmac_setup_est()
sequence under est_lock? Should the commit message mention this path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d%40oss.qualcomm.com
