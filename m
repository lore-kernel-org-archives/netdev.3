Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3785368D42;
	Mon, 27 Jul 2026 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139912; cv=none; b=DKC5LFODH/aInxdYpzW3ODub229mwDF+ngdDaGIjcQR2Ek33wqZ104B/32zFnyr2kAGleB89tsnw94EceoJnkdBEO/8WWj0XI64vdBMgxclNGAzPe2P1JLe9h9RK61bC1uUf2tdssljCMJQYj0mF8XnIl2Xr7zDbcPkTZuy1ZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139912; c=relaxed/simple;
	bh=7a8ht4g1gQ+LlsfWON/B35MWFEnoJ/t41lGSGmpJiq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmJs36jn3T1qhfFyZAaKIoK6rxqnTd8H1XTuqAKhxZbHDhnAbkTC7zWI6BrlITCikZdaFYblPx8A3361QUx3qVXysvYFSCgTOY7b19O2h/IzTyQ2VtDVjau1lCBrzvpDz8yb1jGquCQjwH2bT7wR6z0FDPES44/1NtXUWat5g7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LO4yI3cX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LO4yI3cX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 421ED4E40F92;
	Mon, 27 Jul 2026 08:11:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 06272601BE;
	Mon, 27 Jul 2026 08:11:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8111911C12243;
	Mon, 27 Jul 2026 10:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785139906; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nKa8XSu47DLzEg4eeaPfmMAiuo/GOOsLCJU6TJ0k7LA=;
	b=LO4yI3cXRdAyaI3myrjwfXedgQocVB83IBPr9x6NF8O8Uv1R2/queGYeu4mPNXAyt9JhYU
	VSoDqzroqt3RNXUyWRfIBgZTXE8H6BH5F85hciTwxXW/Xrl9bbuOJylxX+j0wPAT5S1XkB
	lZxQYS+ukOtbZbg5tc7UEz6D4oJwUfvMuXKhci+Fyalx2nZPC72bHyu97FC+FLMycy5gjV
	fswosZT41fOCWfLSpr8pZP02YuXiWztXOHOGQOlijw7g7utaSAwY8YuFvecobGxKM7Whe4
	REt0EVwE4biL1TonCXC48n+paV2eW20FjfMKNjy4XZHJQdEDbmYdjOqLA+stQQ==
Message-ID: <70cf4cfa-c329-41a5-b335-561a565627d9@bootlin.com>
Date: Mon, 27 Jul 2026 10:11:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: fpe: Keep pmac always enabled
To: muhammad.nazim.amirul.nazle.asmade@altera.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260727051303.14925-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260727051303.14925-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/27/26 07:13, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The preemptive MAC in DWMAC is always enabled, meaning DWMAC is always
> ready to receive preemptive mPackets. Keep pmac_enabled true at init
> time and reject attempts to disable it via ethtool set_mm.
> 
> The FPE residual queue (fprq) controls which Rx queue receives residual
> preemptive mPackets from the pmac. Move its configuration from
> stmmac_fpe_configure_tx() to stmmac_fpe_configure_pmac() where it
> logically belongs.
> 
> Also add a missing return in stmmac_fpe_init() so that the pmac_enabled
> initialization is not reached on hardware where FPE is not supported by
> the driver.

Can you split this up into individual patches, one for the stmmac_set_mm() and
stmmac_fpe_init() to validate that we keep pmac on, one for the missing return,
and one for the pmac configuration in the right fonction ?

Also one comment bellow :> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  7 ++++
>  .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 34 ++++++++++++-------
>  2 files changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 92585d27ab88..8ebdd249e5c8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -1064,6 +1064,13 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>  	if (err)
>  		return err;
>  
> +	if (!priv->dma_cap.fpesel)
> +		return -EOPNOTSUPP;
> +
> +	/* DWMAC always have preemptible MAC enabled */
> +	if (!cfg->pmac_enabled)
> +		return -EINVAL;
> +
>  	stmmac_fpe_set_add_frag_size(priv, frag_size);
>  	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index c54c70224351..2bfa84ad04a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -47,20 +47,13 @@ static void stmmac_fpe_configure_tx(struct ethtool_mmsv *mmsv, bool tx_enable)
>  	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
>  	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
>  	const struct stmmac_fpe_reg *reg = cfg->reg;
> -	u32 num_rxq = priv->plat->rx_queues_to_use;
>  	void __iomem *ioaddr = priv->ioaddr;
> -	u32 value;
>  
> -	if (tx_enable) {
> +	if (tx_enable)
>  		cfg->fpe_csr = STMMAC_MAC_FPE_CTRL_STS_EFPE;
> -		value = readl(ioaddr + reg->rxq_ctrl1_reg);
> -		value &= ~reg->fprq_mask;
> -		/* Keep this SHIFT, FIELD_PREP() expects a constant mask :-/ */
> -		value |= (num_rxq - 1) << __ffs(reg->fprq_mask);
> -		writel(value, ioaddr + reg->rxq_ctrl1_reg);
> -	} else {
> +	else
>  		cfg->fpe_csr = 0;
> -	}
> +
>  	writel(cfg->fpe_csr, ioaddr + reg->mac_fpe_reg);
>  }
>  
> @@ -68,10 +61,11 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
>  {
>  	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
>  	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
> +	u32 num_rxq = priv->plat->rx_queues_to_use;
>  	const struct stmmac_fpe_reg *reg = cfg->reg;
>  	void __iomem *ioaddr = priv->ioaddr;
>  	unsigned long flags;
> -	u32 value;
> +	u32 value, value_2;
>  
>  	spin_lock_irqsave(&priv->hw->irq_ctrl_lock, flags);
>  	value = readl(ioaddr + reg->int_en_reg);
> @@ -83,6 +77,14 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
>  
>  			value |= reg->int_en_bit;
>  		}
> +		/* Frame Preemption Residue Queue is the Rx Queue to which
> +		 * residual preemptive mPackets must be forwarded from the pmac.
> +		 */
> +		value_2 = readl(ioaddr + reg->rxq_ctrl1_reg);
> +		value_2 &= ~reg->fprq_mask;
> +		/* Keep this SHIFT, FIELD_PREP() expects a constant mask :-/ */

you can use u32_replace_bits for non constant expr :

https://elixir.bootlin.com/linux/v7.2-rc4/source/include/linux/bitfield.h#L236

(it's autogenerated and not documented, hence very hard to find IMO)

Maxime
