Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616569;
	b=bvSBtdvt4oiX6d7u31Bf7R8z0SFX8KMqcxbkaZ4rJe4NhK7LDV6de50bn5ZrF1JTBIYD
	 MLAqWgpHtvnX9DUh1ksZB5qikQOC5vb231WaGLwGcejM8mR1jQ+YNPuVwNz+ZXSIy44Lf
	 FlUXJJ0okhpx1W0WSVC6xDEAr7eX9URL1DARpXg00KsIuTRTdaCTTIcmKVNdrI1aAQ9VT
	 7QYpAxKzQbdCukhN556a2XBlGsLHHbwl3YIQ9xmhNfECEnWfsIbvnwns8FF8ogWkBVfcH
	 4wWrrBAffDyUJUL/abKjndDNyXIKdW//6w5DvXZH8ykKWT7vH8LDO+/Y4ljh0IuRNqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616569;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ItIyALDGqlH9IOnQRZ8DGIvFk+pxPZf803zlZB+SyQw=;
	b=W6Oted5YJ0puX4fsVY2XuBieqBgkxOEawKP7FNZeJ9UunM+jhfi3CFLqEMp1ynmD8l6h
	 CkjyZ1YvbnzsCrLlnPj/9GBDHtAzj0v2NyndmLlquoiwIfhdMIu6Uoh0zs5WQEDQhPo+E
	 iE/Q8TeCybnL7/6xyb9+rc53EwTv8unOSsENTuKEi6W9GBKs7/iTD5JoaiLbOfsvxlpM4
	 2IlCGDIQUiKzcsy80rn52Us8hpDuB8Xcl6qKRCMx3wn7G7mMSIoIy5C3vjHTa3TLl+FXF
	 YYrwiGJL2N6iugAD0KcnT4zU1OXUE7hxD6hWhgF8kYaQMQ4qg9ZQXRIILH7Agty2VBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIZag5si;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADF606A338
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIZag5si
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B5C1F0093A;
	Mon,  2 Nov 2026 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616569;
	bh=ItIyALDGqlH9IOnQRZ8DGIvFk+pxPZf803zlZB+SyQw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AIZag5siHbH+iMEew6VSCTdPr/yu9ADe4IoY8mRaZLal8OX2Fjll23V+Z3CNxXY00
	 o6XTCf1UQChxNAogfxtiNCCiFx9x3fNRl3jw145+whPbf9NdVaKOvlDCesYgjovPK0
	 uFIcneK4jg1Qt2IvTufS9cZzQ+FAuIAyHK+GgwpktDMlcmBCXcRaFk92UvFXePJRSX
	 zgWmWwNOpQDx6unp7ObbiCx3Vhv1lClus6taj0/D2AOH6t2J3W1qlBOCED6sjcLUxG
	 6UQpyExc/N+a08Kwk9G33bLiF4U8/WcLZsDbzxS1sqoVSVDezyso/exTfzEmS2XZB2
	 AmiFFe5XqzrnA==
Subject: Re: [PATCH net v5 3/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
 james.hilliard1@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rayagond@vayavyalabs.com
Date: Mon, 02 Nov 2026 10:49:27 +0000
Message-ID: <179361656787.3131.5817596791384004529@kernel.org>
In-Reply-To: <20261029-stmmac-est-fixes-v5-3-85b830a795a9@oss.qualcomm.com>
References: <20261029-stmmac-est-fixes-v5-3-85b830a795a9@oss.qualcomm.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A taprio REPLACE that fails the FPE callback's software
  validation destroys the installed hardware schedule, even though the…
- [Low] stmmac_adjust_time() still uses two separate est_lock critical
  sections: it disables EST, runs adjust_systime under ptp_lock only,…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  a new way to reach it.
- [Low] The TX/XDP hot paths (stmmac_main.c:2753, 4861, 5286) read
  priv->est, priv->est->enable and priv->est->max_sdu[] with no lock and…

--

net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()

This commit re-applies the taprio EST offload and the FPE preemption
mapping after the core soft reset, in __stmmac_open() and stmmac_resume().
The base time recompute moves into __stmmac_setup_est() and
stmmac_setup_est().

tc_taprio_configure() now holds est_lock across validation and
programming, builds the gate list in a temporary buffer, and sets
priv->est->enable only after success.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2163e79fea9a4..d1e3d2cc77670 100644
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

[Severity: High]
This issue predates the patch, but the new est_error exit gives it one
more trigger. If stmmac_setup_est() fails during an MTU change, is the
running netdev left with freed rings and TX hrtimers that were never
initialised?

stmmac_change_mtu() calls __stmmac_release() and then
__stmmac_open(dev, dma_conf), which memcpy()s the kzalloc'd dma_conf into
priv->dma_conf. The est_error exit returns before stmmac_init_coalesce(),
so hrtimer_setup() never runs on the txtimers.

stmmac_change_mtu() then does:

	ret = __stmmac_open(dev, dma_conf);
	if (ret) {
		free_dma_desc_resources(priv, dma_conf);
		kfree(dma_conf);
		...
		return ret;
	}

and the interface stays up. On the next ifdown, __stmmac_release() calls
hrtimer_cancel() on priv->dma_conf.tx_queue[chan].txtimer, and
hrtimer_active() dereferences a NULL timer->base. After that,
free_dma_desc_resources(priv, &priv->dma_conf) frees the same rings a
second time.

Failures in stmmac_hw_setup() and stmmac_setup_ptp() already reach this
path. A failed EST/FPE replay is a new way in.

>  
>  	phylink_start(priv->phylink);
> @@ -4224,7 +4229,7 @@ static int __stmmac_open(struct net_device *dev,
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> -
> +est_error:
>  	stmmac_release_ptp(priv);
>  ptp_error:
>  	stmmac_stop_all_dma(priv);

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 9a32af00d7d2d..a37405534bebf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c

[ ... ]

> @@ -69,47 +69,21 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	nsec = reminder;
>  
>  	/* If EST is enabled, disabled it before adjust ptp time. */
> -	if (priv->est && priv->est->enable) {
> -		est_rst = true;
> -		mutex_lock(&priv->est_lock);
> -		priv->est->enable = false;
> +	mutex_lock(&priv->est_lock);
> +	if (priv->est && priv->est->enable)
>  		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate, false);
> -		mutex_unlock(&priv->est_lock);
> -	}
> +	mutex_unlock(&priv->est_lock);
>  
>  	write_lock_irqsave(&priv->ptp_lock, flags);
>  	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
>  	write_unlock_irqrestore(&priv->ptp_lock, flags);
>  
>  	/* Calculate new basetime and re-configured EST after PTP time adjust. */

[ ... ]

> +	mutex_lock(&priv->est_lock);
> +	if (priv->est && priv->est->enable)
> +		__stmmac_setup_est(priv);
> +	mutex_unlock(&priv->est_lock);

[Severity: Low]
Can stmmac_setup_est() turn EST back on between these two est_lock
sections?

The first section no longer clears priv->est->enable, so any est_lock
user that runs while the time is being stepped still sees
enable == true.

In __stmmac_open(), stmmac_setup_est() runs right after
stmmac_setup_ptp() has registered the PHC. clock_adjtime() is not
serialised by rtnl:

CPU0 (stmmac_adjust_time)          CPU1 (__stmmac_open)
  disable EST, drop est_lock
                                     stmmac_setup_est()
                                       sees enable == true
                                       __stmmac_setup_est() enables EST
                                       with a pre-step base time
  stmmac_adjust_systime()
    (EST running across the step)
  __stmmac_setup_est()

A taprio REPLACE can race with adjust_time in the same way.

Before this patch, clearing enable during the window kept other paths
from re-arming EST. Would holding est_lock across the disable, the
adjust and the re-enable close this window?

> 
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index ac926c60f9f9a..10b61fa2c27c5 100644
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
This is a pre-existing issue that the patch did not introduce.
stmmac_xmit(), stmmac_xdp_xmit_xdpf() and the other TX paths read
priv->est, priv->est->enable and priv->est->max_sdu[] without est_lock
and without READ_ONCE():

	if (priv->est && priv->est->enable &&
	    priv->est->max_sdu[queue]) {

If a REPLACE runs while traffic is being sent, can this memset() and the
plain stores after it race with those readers? That could drop a frame
by mistake, or let one through past max_sdu, while the schedule is being
reconfigured.

Setting enable last in this patch does make the window smaller.

> +	memcpy(priv->est->gcl, gcl, sizeof(*gcl) * qopt->num_entries);
> +	priv->est->gcl_size = qopt->num_entries;
> +

[ ... ]

> @@ -1091,7 +1109,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  	ret = stmmac_est_configure(priv, priv, priv->est,
>  				   priv->plat->clk_ptp_rate, true);
> -	mutex_unlock(&priv->est_lock);
>  	if (ret) {
>  		netdev_err(priv->dev, "failed to configure EST\n");
>  		goto disable;
> @@ -1102,11 +1119,16 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	if (ret)
>  		goto disable;
>  

[Severity: Medium]
If a REPLACE fails FPE validation, is the installed schedule still torn
down?

The commit message says:

  A REPLACE rejected during validation then leaves the currently
  installed schedule intact in both software and hardware

However, by the time stmmac_fpe_map_preemption_class() runs, priv->est
has already been memset and overwritten, and
stmmac_est_configure(..., true) has programmed the new schedule.

dwmac5_fpe_map_preemption_class() only does software validation, and it
can return -EINVAL. One example:

	if (priv->xmit_qdisc.algo == MTL_TX_ALGORITHM_SP) {
		NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
		return -EINVAL;
	}

It can also fail on a TXQ weight mismatch. Either error takes the
disable path, which clears priv->est->enable and turns off EST in
hardware.

Meanwhile taprio_change() sees the error, jumps to free_sched, and keeps
the old schedule along with its full-offload state.

For example, on DWMAC5 with FPE: install an all-express schedule that
has a multi-queue TC, then REPLACE it with that TC marked preemptible.
The user gets -EINVAL and the qdisc still reports the old schedule as
offloaded. But hardware gating and max_sdu enforcement are gone, and a
later reopen or resume will not bring them back because enable is now
false.

Could the FPE validation run before priv->est is changed and EST is
programmed?

> +	priv->est->pclass = qopt->mqprio.preemptible_tcs;
> +	priv->est->enable = true;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-stmmac-est-fixes-v5-0-85b830a795a9%40oss.qualcomm.com
