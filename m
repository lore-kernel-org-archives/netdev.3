Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C9E2848BE
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788008378; cv=none; b=ZK0uk82Il3TXIZN5C8H7+XKNoeCPb/PCQ5KJ1VQWZD8JFHA0DKAhirWdG+XZDLgWcIcjAonjGGY3xT3p25Vbs42aSuI74B1z6lA9CFHT77X75LGT6RDuD6O9cK0pPPLJWq6gJ7csIE//iSMwiHDJUs46VWS8Bb1JaWddEdeQ87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788008378; c=relaxed/simple;
	bh=2ycYbbpNGSpzUXcGe+o946SclPa6PHpkQZV9848KdVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwZu9t7NrtSBMlvDYL2P+tzCngIq0mJrVgkc4L3lJHURRmuppQMmNx4aFDrU444CbYDwEMnkTqKGL8ll9Gkx6nRKPCdd2/2DKVBFhqnWIrMaNU9aSdqu/RkVfMV4GB1NThSGzIVxWFdijMBxnPsVxR5FOY2NK+IoPlPBEKX7nH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0iX0ox62; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0iX0ox62"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C724D1A181F;
	Sat, 29 Aug 2026 12:59:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 854186053C;
	Sat, 29 Aug 2026 12:59:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0101111C781D9;
	Sat, 29 Aug 2026 14:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788008359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TRRAn3ayWpp6KkR8fe/DKlKoibDKlKjshRYEpoSI6+M=;
	b=0iX0ox62T/oe9zqr19dwg/emDTB+bsDyVxp2Nu7bNqkJ0jtJ+FQoZOTWs+62bF19ePknGU
	IKDVZ8CJGKTqR4QyX2D6EAGuOWWCXkztd4L4NMjTb8Pzks7dm5KeZc3D1Lpa8bg8T2Rmr7
	j/6RZhTjaKcwyjNvXUS3uxaMrpg5ggYPuhm0UCyjwvmohpKYr3CNfeVw+zpRhtrair5MXK
	UN2jlm/pDLM9amrVqWk2KzNDCic2wVWSVUhzz5BFTQHiKWSiwfGAltl6vrEQGRVYAYUajY
	n++s3B5cD+wuAzUytmOmJCYURANix8Lkadp58qi3upHrU6pkUUz3Of3u86oNTg==
Message-ID: <4d333480-758e-4061-9c8a-39959bd6a8f9@bootlin.com>
Date: Sat, 29 Aug 2026 14:59:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: re-apply taprio offload in
 __stmmac_open()
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>
References: <20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 8/29/26 11:56, Lorenzo Bianconi wrote:
> The core soft reset issued in stmmac_init_dma_engine() clears the
> MTL_EST registers, but nothing re-applies the taprio offload after it:
> priv->est->enable stays true while the hardware EST block is left
> disabled. The TX/XDP paths then keep dropping frames larger than
> priv->est->max_sdu[] and taprio is reported as offloaded, although the
> EST block is not programmed.
> 
> Re-apply the taprio offload in __stmmac_open() after PTP is up. The
> base time is recomputed from the reserved base time and the current PTP
> time, since the timestamp counter has been re-initialized and the
> previously programmed base time is stale.
> Introduce the stmmac_setup_est utility routine.
> 
> Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sorry I realise I didn't reply to your V1 question :( What you did is
what I meant, so it's all good :)

This looks fine to me, thanks !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> ---
> Changes in v2:
> - Rename stmmac_est_reconfigure() in stmmac_setup_est().
> - Rely on stmmac_setup_est() in tc_taprio_configure().
> - Link to v1: https://lore.kernel.org/r/20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 33 +++++++++++++++++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 16 +++++++++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 26 ++----------------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 27 ++++++-------------
>  5 files changed, 59 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> index afc516059b89..bbebd33c8a88 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> @@ -80,6 +80,39 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
>  	return 0;
>  }
>  
> +int stmmac_setup_est(struct stmmac_priv *priv)
> +{
> +	struct timespec64 current_time, time;
> +	ktime_t current_time_ns, basetime;
> +	u64 cycle_time;
> +	int err;
> +
> +	mutex_lock(&priv->est_lock);
> +
> +	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
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
> +				   priv->plat->clk_ptp_rate);
> +
> +	mutex_unlock(&priv->est_lock);
> +
> +	if (err)
> +		netdev_err(priv->dev, "failed to re-configure EST\n");
> +
> +	return err;
> +}
> +
>  static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
>  			   struct stmmac_extra_stats *x, u32 txqcnt)
>  {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> index f70221c9c84a..f620d3331c2c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> @@ -65,3 +65,5 @@
>  #define EST_GCL_DATA			0x00000034
>  
>  extern const struct stmmac_est_ops dwmac510_est_ops;
> +
> +int stmmac_setup_est(struct stmmac_priv *priv);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d576059c04df..b30036428188 100644
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
> @@ -4153,11 +4154,22 @@ static int __stmmac_open(struct net_device *dev,
>  	ret = stmmac_hw_setup(dev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -		goto init_error;
> +		return ret;
>  	}
>  
>  	stmmac_setup_ptp(priv);
>  
> +	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
> +	 * registers, so re-apply the taprio offload after PTP is up.
> +	 */
> +	if (priv->est && priv->est->enable) {
> +		ret = stmmac_setup_est(priv);
> +		if (ret < 0) {
> +			priv->est->enable = false;
> +			return ret;
> +		}
> +	}
> +
>  	stmmac_init_coalesce(priv);
>  
>  	phylink_start(priv->phylink);
> @@ -4181,7 +4193,7 @@ static int __stmmac_open(struct net_device *dev,
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
>  	stmmac_release_ptp(priv);
> -init_error:
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 960249960004..917ef7ddcae6 100644
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
> @@ -55,7 +56,6 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	u32 quotient, reminder;
>  	int neg_adj = 0;
>  	bool xmac, est_rst = false;
> -	int ret;
>  
>  	xmac = dwmac_is_xmac(priv->plat->core_type);
>  
> @@ -84,30 +84,8 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  
>  	/* Calculate new basetime and re-configured EST after PTP time adjust. */
>  	if (est_rst) {
> -		struct timespec64 current_time, time;
> -		ktime_t current_time_ns, basetime;
> -		u64 cycle_time;
> -
> -		mutex_lock(&priv->est_lock);
> -		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
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
>  		priv->est->enable = true;
> -		ret = stmmac_est_configure(priv, priv, priv->est,
> -					   priv->plat->clk_ptp_rate);
> -		mutex_unlock(&priv->est_lock);
> -		if (ret)
> -			netdev_err(priv->dev, "failed to configure EST\n");
> +		stmmac_setup_est(priv);
>  	}
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 14cabe76e53e..b41df317d73c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -10,6 +10,7 @@
>  #include "dwmac4.h"
>  #include "dwmac5.h"
>  #include "stmmac.h"
> +#include "stmmac_est.h"
>  
>  static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
>  {
> @@ -968,8 +969,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  {
>  	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
>  	struct netlink_ext_ack *extack = qopt->mqprio.extack;
> -	struct timespec64 time, current_time, qopt_time;
> -	ktime_t current_time_ns;
> +	struct timespec64 time;
>  	int i, ret = 0;
>  	u64 ctr;
>  
> @@ -1069,34 +1069,23 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	}
>  
>  	mutex_lock(&priv->est_lock);
> -	/* Adjust for real system time */
> -	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> -	current_time_ns = timespec64_to_ktime(current_time);
> -	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
> -					qopt->cycle_time);
> -
> -	priv->est->btr[0] = (u32)time.tv_nsec;
> -	priv->est->btr[1] = (u32)time.tv_sec;
>  
> -	qopt_time = ktime_to_timespec64(qopt->base_time);
> -	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
> -	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
> +	time = ktime_to_timespec64(qopt->base_time);
> +	priv->est->btr_reserve[0] = (u32)time.tv_nsec;
> +	priv->est->btr_reserve[1] = (u32)time.tv_sec;
>  
>  	ctr = qopt->cycle_time;
>  	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
>  	priv->est->ctr[1] = (u32)ctr;
>  
>  	priv->est->ter = qopt->cycle_time_extension;
> -
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
> -	ret = stmmac_est_configure(priv, priv, priv->est,
> -				   priv->plat->clk_ptp_rate);
>  	mutex_unlock(&priv->est_lock);
> -	if (ret) {
> -		netdev_err(priv->dev, "failed to configure EST\n");
> +
> +	ret = stmmac_setup_est(priv);
> +	if (ret)
>  		goto disable;
> -	}
>  
>  	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
>  					      qopt->mqprio.preemptible_tcs);
> 
> ---
> base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
> change-id: 20260824-stmmac-est-reapply-after-open-181d70a15eb6
> 
> Best regards,

