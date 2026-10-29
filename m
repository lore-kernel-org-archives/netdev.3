Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296247;
	b=Jl+43H1nJ77Qz65cjnoJ83z2Uegx+27n5q5hzbP+eTz5yZZvu3WchV/sx+WcucE9HezT
	 M6kwniozw4Msh40KHAziqPrPbz9iCWovQsW/zwxRJ0It6z7Kkoi77R6eTk/GGiFoTjUn8
	 myl95/PLeZ2x13igZFVO9sCE0WlbUDWUh/sGwAg2Q8NJJjgkoQOqbF8rBeoDBZE3a7m8g
	 z5wDVVeUYXdl3Yqjaxgbge4OZrz//DzQ7HEz1rSaD3uR6AzJjtIJDqkTxO3Q1Jviqvaa/
	 Mh3gAVOzaxYGo+14MgVYNRgGQ4rqTr2yAqBij5meHp7bX+spHiEH5DGu1/6i+2C9QDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296247;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=GIdGNSs92/yJD4fjsnq7Lh+u1YCqxIe/djFELvabYuk=;
	b=jD0ZFUzsF7xwCjYLvS0/4qfzrU7NjKY3BdSxBo0kkc3UjRIlDZNWa4BJxmvaGm5U4kh+
	 vtTpArPXr6yOxLshRxMhh11HFrh0rxM86a2+AXh6cCJ66HQsizF3FFf3kc+jAa0e5zGFP
	 UT06dPbPRTwTlrjjtRRcRbwk5C1KE/bIdZIRtMuw/rfs6VsAypKh13q4UJvwn4cbHDi60
	 l/Mzs2z3XlapnFN1zbPNI3nBErUIppH5xz65OCr6neruCxPwW8dJF8JmBFXmHoLMFEABK
	 8Ji60rG+NZW1noUO6WTEgkYwCVkjkb3x9hVKuUckcdlxiJEYG+ebyXwX8S2b1Bs3nfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="0NhX6l/8";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB9606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADBB9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0NhX6l/8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 15A581A13AA;
	Thu, 29 Oct 2026 17:50:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D477C6076A;
	Thu, 29 Oct 2026 17:50:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7FE410328F94;
	Thu, 29 Oct 2026 18:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793296239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GIdGNSs92/yJD4fjsnq7Lh+u1YCqxIe/djFELvabYuk=;
	b=0NhX6l/8WB2hFHNnu2FuFPsEhbrlUlC4pIPXwgTjokG7wSG3ejveHqPiFd0gyArz/nAld4
	aWorvYNT/M1zXk1pP75GZ7n2MqHgEBsCYO7UOUEfpUzSmo0A9eVtCkQQieLsua7Ob2B5YZ
	jyVIzjBLHPig3zTUiQsssl4F/se83ErZesRVtPP9YAfK4AI2whZvl9y1iDf6aj7hlLLkrD
	8l/fa8fIZeNmfgPdJkULGLckW0o21qpltW366AQv8FbJj2BoPJSlB5cnSn+aSxtaNKVL0t
	FgN8dy/Rj0mwI7vCLGdL2r5TaJvkmrX+a/vtgmxZF7UCdW2pFnNL6T04/1gU4Q==
Message-ID: <a78ee9d9-3b21-4715-b545-5123d768d084@bootlin.com>
Date: Thu, 29 Oct 2026 18:50:29 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jose Abreu <Jose.Abreu@synopsys.com>,
 James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>
References: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
 <20261029-stmmac-est-fixes-v5-3-85b830a795a9@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261029-stmmac-est-fixes-v5-3-85b830a795a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 10/29/26 11:33, Lorenzo Bianconi wrote:
> The core soft reset issued by stmmac_init_dma_engine(), called from
> stmmac_hw_setup(), clears the MTL_EST registers. Nothing re-applies the
> taprio offload afterwards, so priv->est->enable stays true while the
> hardware EST block is left disabled: taprio keeps being reported as
> offloaded, the TX/XDP paths keep dropping frames larger than
> priv->est->max_sdu[], and the programmed base time is stale.
> 
> Re-apply the offload from __stmmac_open() and stmmac_resume() after PTP
> has been brought up. The base time is recomputed from the reserved base
> time and the current PTP time, because the timestamp counter has been
> re-initialised and the previously programmed base time cannot be reused.
> 
> Factor the recompute-and-program sequence into __stmmac_setup_est(),
> which must be called with est_lock held, and into stmmac_setup_est(),
> which takes the lock and re-applies the offload only when it is
> currently enabled and PTP has been brought up. Use the same helper in
> stmmac_adjust_time() so the PTP adjust path shares the base time
> computation.
> 
> Only tc_taprio_configure() updates priv->est->enable: it is set when a
> REPLACE succeeds and cleared on DESTROY or a programming failure. The
> re-apply helpers leave it untouched, so the flag records that an offload
> is installed rather than the current hardware programming state.
> __stmmac_setup_est() only reprograms the EST block, and
> stmmac_setup_est() replays the FPE mapping afterwards. On a failed
> re-apply the open and resume callers abort, while stmmac_adjust_time()
> keeps the offload configured.
> 
> The same reset also discards the FPE preemption programming, and on XGMAC
> stmmac_dma_tx_mode() overwrites the queue-to-traffic-class map. Save the
> preemptible traffic class mask in priv->est->pclass when a REPLACE
> succeeds and replay the FPE mapping from stmmac_setup_est() as well.
> 
> Re-applying the offload is best-effort with respect to PTP:
> stmmac_setup_est() does nothing when PTP was not enabled (for example
> when clk_ptp_rate is 0), so a missing PTP reference clock does not by
> itself fail ndo_open(). If re-applying the EST or FPE programming fails
> while restoring the interface, the failure is fatal to the caller:
> __stmmac_open() aborts the open, and stmmac_resume() takes the same error
> path already used for a failed timestamp counter restore.
> 
> Since __stmmac_open() and stmmac_resume() now trust priv->est->enable,
> also make tc_taprio_configure() consistent: hold est_lock across the
> whole validate-and-program sequence, build the gate list in a temporary
> buffer, and only commit it and enable EST after validation and hardware
> programming succeed. A REPLACE rejected during validation then leaves the
> currently installed schedule intact in both software and hardware, while
> a hardware or FPE mapping failure disables EST instead of leaving a stale
> enable flag behind. Reject cycle times whose seconds field would not fit
> in priv->est->ctr[1].
> 
> Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

LGTM, I ran a quick test on AgileX5 (dwxgmac w/ EST) and imx8mp, seems
to solve the EST config being lost after link flap/MTU changes :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks :)

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 55 ++++++++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  8 +++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 44 +++---------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 88 ++++++++++++++---------
>  6 files changed, 139 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 93292014c393..b76acfe0d958 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -239,6 +239,7 @@ struct stmmac_est {
>  	u32 gcl[EST_GCL];
>  	u32 gcl_size;
>  	u32 max_sdu[MTL_MAX_TX_QUEUES];
> +	u32 pclass;
>  };
>  
>  struct stmmac_msi {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> index f15d4d046aa7..59e9a54e864d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> @@ -80,6 +80,61 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
>  	return 0;
>  }
>  
> +int __stmmac_setup_est(struct stmmac_priv *priv)
> +{
> +	struct timespec64 current_time, time;
> +	ktime_t current_time_ns, basetime;
> +	u64 cycle_time;
> +	int err;
> +
> +	lockdep_assert_held(&priv->est_lock);
> +
> +	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
> +				       NULL);
> +	current_time_ns = timespec64_to_ktime(current_time);
> +
> +	time.tv_nsec = priv->est->btr_reserve[0];
> +	time.tv_sec = priv->est->btr_reserve[1];
> +	basetime = timespec64_to_ktime(time);
> +
> +	cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC + priv->est->ctr[0];
> +
> +	time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);
> +	priv->est->btr[0] = (u32)time.tv_nsec;
> +	priv->est->btr[1] = (u32)time.tv_sec;
> +
> +	err = stmmac_est_configure(priv, priv, priv->est,
> +				   priv->plat->clk_ptp_rate, true);
> +	if (err) {
> +		netdev_err(priv->dev, "failed to re-configure EST\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int stmmac_setup_est(struct stmmac_priv *priv)
> +{
> +	int ret = 0;
> +
> +	if (!priv->ptp_enabled)
> +		return 0;
> +
> +	mutex_lock(&priv->est_lock);
> +	if (priv->est && priv->est->enable) {
> +		ret = __stmmac_setup_est(priv);
> +		if (ret)
> +			goto unlock;
> +
> +		ret = stmmac_fpe_map_preemption_class(priv, priv->dev, NULL,
> +						      priv->est->pclass);
> +	}
> +unlock:
> +	mutex_unlock(&priv->est_lock);
> +
> +	return ret;
> +}
> +
>  static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
>  			   struct stmmac_extra_stats *x, u32 txqcnt)
>  {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> index f70221c9c84a..5e07b84957f3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> @@ -4,6 +4,9 @@
>   * stmmac EST(802.3 Qbv) handling
>   */
>  
> +#ifndef __STMMAC_EST_H__
> +#define __STMMAC_EST_H__
> +
>  #define EST_GMAC4_OFFSET		0x00000c50
>  #define EST_XGMAC_OFFSET		0x00001050
>  
> @@ -65,3 +68,8 @@
>  #define EST_GCL_DATA			0x00000034
>  
>  extern const struct stmmac_est_ops dwmac510_est_ops;
> +
> +int __stmmac_setup_est(struct stmmac_priv *priv);
> +int stmmac_setup_est(struct stmmac_priv *priv);
> +
> +#endif /* __STMMAC_EST_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2163e79fea9a..d1e3d2cc7767 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -48,6 +48,7 @@
>  #include "stmmac_ptp.h"
>  #include "stmmac_fpe.h"
>  #include "stmmac.h"
> +#include "stmmac_est.h"
>  #include "stmmac_pcs.h"
>  #include "stmmac_xdp.h"
>  #include <linux/reset.h>
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
> @@ -4224,7 +4229,7 @@ static int __stmmac_open(struct net_device *dev,
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> -
> +est_error:
>  	stmmac_release_ptp(priv);
>  ptp_error:
>  	stmmac_stop_all_dma(priv);
> @@ -8527,6 +8532,10 @@ int stmmac_resume(struct device *dev)
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
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 9a32af00d7d2..a37405534beb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -8,6 +8,7 @@
>    Author: Rayagond Kokatanur <rayagond@vayavyalabs.com>
>  *******************************************************************************/
>  #include "stmmac.h"
> +#include "stmmac_est.h"
>  #include "stmmac_ptp.h"
>  
>  #define PTP_SAFE_TIME_OFFSET_NS	500000
> @@ -54,8 +55,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	u32 sec, nsec;
>  	u32 quotient, reminder;
>  	int neg_adj = 0;
> -	bool xmac, est_rst = false;
> -	int ret;
> +	bool xmac;
>  
>  	xmac = dwmac_is_xmac(priv->plat->core_type);
>  
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
> -	if (est_rst) {
> -		struct timespec64 current_time, time;
> -		ktime_t current_time_ns, basetime;
> -		u64 cycle_time;
> -
> -		mutex_lock(&priv->est_lock);
> -		priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops,
> -					       &current_time, NULL);
> -		current_time_ns = timespec64_to_ktime(current_time);
> -		time.tv_nsec = priv->est->btr_reserve[0];
> -		time.tv_sec = priv->est->btr_reserve[1];
> -		basetime = timespec64_to_ktime(time);
> -		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
> -			     priv->est->ctr[0];
> -		time = stmmac_calc_tas_basetime(basetime,
> -						current_time_ns,
> -						cycle_time);
> -
> -		priv->est->btr[0] = (u32)time.tv_nsec;
> -		priv->est->btr[1] = (u32)time.tv_sec;
> -		priv->est->enable = true;
> -		ret = stmmac_est_configure(priv, priv, priv->est,
> -					   priv->plat->clk_ptp_rate, true);
> -		mutex_unlock(&priv->est_lock);
> -		if (ret)
> -			netdev_err(priv->dev, "failed to configure EST\n");
> -	}
> +	mutex_lock(&priv->est_lock);
> +	if (priv->est && priv->est->enable)
> +		__stmmac_setup_est(priv);
> +	mutex_unlock(&priv->est_lock);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index ac926c60f9f9..10b61fa2c27c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -966,11 +966,12 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
>  static int tc_taprio_configure(struct stmmac_priv *priv,
>  			       struct tc_taprio_qopt_offload *qopt)
>  {
> -	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
> +	u32 wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
>  	struct netlink_ext_ack *extack = qopt->mqprio.extack;
>  	struct timespec64 time, current_time, qopt_time;
>  	ktime_t current_time_ns;
>  	int err, i, ret = 0;
> +	u32 *gcl = NULL;
>  	u64 ctr;
>  
>  	if (qopt->base_time < 0)
> @@ -1013,42 +1014,46 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	mutex_lock(&priv->est_lock);
> +
>  	if (qopt->cmd == TAPRIO_CMD_DESTROY)
>  		goto disable;
>  
> -	if (qopt->num_entries > dep)
> -		return -EINVAL;
> -	if (!qopt->cycle_time)
> -		return -ERANGE;
> -	if (qopt->cycle_time_extension >= BIT(wid + 7))
> -		return -ERANGE;
> +	if (qopt->num_entries > dep) {
> +		ret = -EINVAL;
> +		goto error_unlock;
> +	}
>  
> -	if (!priv->est) {
> -		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
> -					 GFP_KERNEL);
> -		if (!priv->est)
> -			return -ENOMEM;
> -	} else {
> -		mutex_lock(&priv->est_lock);
> -		memset(priv->est, 0, sizeof(*priv->est));
> -		mutex_unlock(&priv->est_lock);
> +	if (!qopt->cycle_time ||
> +	    qopt->cycle_time > (u64)U32_MAX * NSEC_PER_SEC) {
> +		ret = -ERANGE;
> +		goto error_unlock;
>  	}
>  
> -	size = qopt->num_entries;
> +	if (qopt->cycle_time_extension >= BIT(wid + 7)) {
> +		ret = -ERANGE;
> +		goto error_unlock;
> +	}
>  
> -	mutex_lock(&priv->est_lock);
> -	priv->est->gcl_size = size;
> -	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
> -	mutex_unlock(&priv->est_lock);
> +	gcl = kcalloc(qopt->num_entries, sizeof(*gcl), GFP_KERNEL);
> +	if (!gcl) {
> +		ret = -ENOMEM;
> +		goto error_unlock;
> +	}
>  
> -	for (i = 0; i < size; i++) {
> +	for (i = 0; i < qopt->num_entries; i++) {
>  		s64 delta_ns = qopt->entries[i].interval;
>  		u32 gates = qopt->entries[i].gate_mask;
>  
> -		if (delta_ns > GENMASK(wid - 1, 0))
> -			return -ERANGE;
> -		if (gates > GENMASK(31 - wid, 0))
> -			return -ERANGE;
> +		if (delta_ns > GENMASK(wid - 1, 0)) {
> +			ret = -ERANGE;
> +			goto error_unlock;
> +		}
> +
> +		if (gates > GENMASK(31 - wid, 0)) {
> +			ret = -ERANGE;
> +			goto error_unlock;
> +		}
>  
>  		switch (qopt->entries[i].command) {
>  		case TC_TAPRIO_CMD_SET_GATES:
> @@ -1060,13 +1065,26 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			gates &= ~BIT(0);
>  			break;
>  		default:
> -			return -EOPNOTSUPP;
> +			ret = -EOPNOTSUPP;
> +			goto error_unlock;
>  		}
>  
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
> +	memcpy(priv->est->gcl, gcl, sizeof(*gcl) * qopt->num_entries);
> +	priv->est->gcl_size = qopt->num_entries;
> +
>  	/* Adjust for real system time */
>  	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
>  				       NULL);
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
> +	priv->est->pclass = qopt->mqprio.preemptible_tcs;
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
> @@ -1116,10 +1138,12 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			priv->xstats.mtl_est_txq_hlbf[i] = 0;
>  			priv->xstats.mtl_est_txq_hlbs[i] = 0;
>  		}
> -		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	err = stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
> +error_unlock:
> +	mutex_unlock(&priv->est_lock);
> +	kfree(gcl);
>  
>  	return qopt->cmd == TAPRIO_CMD_DESTROY ? err : ret;
>  }
> 

