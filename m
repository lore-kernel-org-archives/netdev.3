Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261362;
	b=ipNC4zFnYnWABy1UKy4ZPqLSyj4zcchC2F/1CuLNx/Msp87V/DPeO4zRRJzWg7XJuz0P
	 Vv4Fq62f7xBtmMa4joPsCSfFDpN/bXrmp06x6Jq7O+XAgo4l2lcvF0ch0dZWH4+0WvE1k
	 hc1uxGdHs5c+grdE9Pe2IrJSoEvcPhmD5B8WHHCs76/LJkk2AzwqztB69MWNrA0mKtnYe
	 ce9ruTtUIWNKx9wpQVZEMm7tbRGurgGgXTSEz8WRUwW1/3ZlcnHnyUAbOzwIZxOKSTYbr
	 DqbImuXh7A4evs+x4B/hNYprGUB/6PNHSoioMt3ZG2VcF1Hn3YAYs7xa0YArHYyb3eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261362;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SIToZkKJiTtocWGYYd40RoA4lGJhq2+ecl7+6P+eM1U=;
	b=Ff60Jxeu2VBKu39XND1mCHl9+vZZuI8Tv9GlCM3+0xSPSLR6JbjthI/LZvG1NKcMAvCC
	 ayT9BKUsrvwM8Bj4kY6MHLAggC8t1EVJwOQ9i1oeNm0sZRXOhttMNehqWGiZBJMExcFLb
	 dinx9Fsq5Gpa8JvGbG5mLsiKvGnjtAGH76BVnQRBv6gF7O6yjGHIeNZRhYKBSHsq5Ommq
	 qRbxXsAIsJXnGGcOFwTeumsy79JCqQKx/MJQrT/bG7mOi5sbzF3+Djm/CaXYL5q1mEtR4
	 s3LioCsRJZE5iobxDNyec+zcEMSJTpoaweI8mecmXrpHxbWy1MybXwTA0VAMP1OHzug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Zvg33d27;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124B606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8124B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Zvg33d27
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C21D5C4CBC2;
	Thu, 29 Oct 2026 08:10:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E29160360;
	Thu, 29 Oct 2026 08:09:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8C52103290D0;
	Thu, 29 Oct 2026 09:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793261357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SIToZkKJiTtocWGYYd40RoA4lGJhq2+ecl7+6P+eM1U=;
	b=Zvg33d27e49cp7GF2v+hjaJmeasHG4kDoeNlNOWurUCseSJEtZ7HqOk8tEK1qk+8gxOlyQ
	GUgO8BAulmvU7Zlv1proWthMt0rk/kWiA+2L3BvWfdWtDmRxrT174ik6evleh9IR3oo7et
	mURYdbnEcaDdvEaeSQkBZ73c9Gte21dTY4Z3nDr/Sn/26Ny3LaOxRuaEly+6X+X+r0m9a+
	2+e3G8wjz1XY0pweycwgModFULQvVw974N7gCs/z8Yt9ZgzGyYic8QT1Bwfse5/DeA91Ue
	h2L0MEAu4l7+JEONfbn/uYzrZ6NiBavzNeDL8F+EelInmsnX7Uu7REOdriXGqw==
Message-ID: <29d6ab3e-be31-4d11-8060-85c1ced14387@bootlin.com>
Date: Thu, 29 Oct 2026 09:09:11 +0100
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
Subject: Re: [PATCH net v4 2/3] net: stmmac: pass the desired EST enable state
 to est_configure()
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jose Abreu <Jose.Abreu@synopsys.com>,
 James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
 <20261026-stmmac-est-fixes-v4-2-999dac4de44f@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261026-stmmac-est-fixes-v4-2-999dac4de44f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/26/26 17:55, Lorenzo Bianconi wrote:
> Pass the desired EST enable state explicitly to est_configure() instead
> of having it derive from cfg->enable. This decouples the hardware
> programming state from the priv->est->enable flag, which records whether
> the taprio offload is attached.
> 
> No functional change intended: the callers keep toggling
> priv->est->enable around the EST programming, as before.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 6 +++---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 4 ++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 50b590d67d87..b28509555d81 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -620,7 +620,7 @@ struct stmmac_mmc_ops {
>  
>  struct stmmac_est_ops {
>  	int (*configure)(struct stmmac_priv *priv, struct stmmac_est *cfg,
> -			 unsigned int ptp_rate);
> +			 unsigned int ptp_rate, bool enable);
>  	void (*irq_status)(struct stmmac_priv *priv, struct net_device *dev,
>  			   struct stmmac_extra_stats *x, u32 txqcnt);
>  };
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> index afc516059b89..f15d4d046aa7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> @@ -26,7 +26,7 @@ static int est_write(void __iomem *est_addr, u32 reg, u32 val, bool gcl)
>  }
>  
>  static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
> -			 unsigned int ptp_rate)
> +			 unsigned int ptp_rate, bool enable)
>  {
>  	void __iomem *est_addr = priv->estaddr;
>  	int i, ret = 0;
> @@ -62,7 +62,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
>  		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
>  			 EST_GMAC5_PTOV_SHIFT;
>  	}
> -	if (cfg->enable)
> +	if (enable)
>  		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;
>  	else
>  		ctrl &= ~EST_EEST;
> @@ -70,7 +70,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
>  	writel(ctrl, est_addr + EST_CONTROL);
>  
>  	/* Configure EST interrupt */
> -	if (cfg->enable)
> +	if (enable)
>  		ctrl = EST_IECGCE | EST_IEHS | EST_IEHF | EST_IEBE | EST_IECC;
>  	else
>  		ctrl = 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index e54a3c887826..9a32af00d7d2 100644
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
>  
> @@ -105,7 +105,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		priv->est->btr[1] = (u32)time.tv_sec;
>  		priv->est->enable = true;
>  		ret = stmmac_est_configure(priv, priv, priv->est,
> -					   priv->plat->clk_ptp_rate);
> +					   priv->plat->clk_ptp_rate, true);
>  		mutex_unlock(&priv->est_lock);
>  		if (ret)
>  			netdev_err(priv->dev, "failed to configure EST\n");
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index aea235a69105..ac926c60f9f9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1090,7 +1090,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
>  	ret = stmmac_est_configure(priv, priv, priv->est,
> -				   priv->plat->clk_ptp_rate);
> +				   priv->plat->clk_ptp_rate, true);
>  	mutex_unlock(&priv->est_lock);
>  	if (ret) {
>  		netdev_err(priv->dev, "failed to configure EST\n");
> @@ -1109,7 +1109,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		mutex_lock(&priv->est_lock);
>  		priv->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->est,
> -				     priv->plat->clk_ptp_rate);
> +				     priv->plat->clk_ptp_rate, false);
>  		/* Reset taprio status */
>  		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
>  			priv->xstats.max_sdu_txq_drop[i] = 0;
> 

