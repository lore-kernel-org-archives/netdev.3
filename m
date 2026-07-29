Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414CB1F942;
	Wed, 29 Jul 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306709; cv=none; b=VrzKVVfpBGTZl8uMkQba8q5oDR34IKKwvEoNlj3WYKEadNFrCaQ2nwUTaC9E9LWlOa5sBejENzYy57nAYzoGON0HFwHud1NxJCxMAfhGeS/Q2OjhhtiP2nW/eMmZjMnxDSAf0ZmfVi/ypBHDsHOG97Hz1w3yI1ybtnQk43gMWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306709; c=relaxed/simple;
	bh=cIaXkqHX2hDxcuEBse6amWBsm8PSqiKh727iM8oVj00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFJQdNxEL057+K3ZvgBTPxdPNc2Hs5AwB49g8F25gfkB3MMN8KzFGqhHmfVlePSSzAGb2l689qkRfNCcMUmeWFb3qhpE6V3MRCqWZypr9rF9Dcmo18CPwNvMFT4gt/qL5vW5gVkSSml2GUWEfweejWK8O3Lm7MsEKgMGt5mWqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I1AuWWVa; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I1AuWWVa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4BF4C4E40F14;
	Wed, 29 Jul 2026 06:31:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 04FCB6039A;
	Wed, 29 Jul 2026 06:31:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76B1A11C149A4;
	Wed, 29 Jul 2026 08:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785306703; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Wza0gQKDNfUyly9bD6ErS8rm8BTSaupfrvUBF5YvgpE=;
	b=I1AuWWVaAm9jEXgBwPSUoIixnZLfQGlMuV084pVPsvUjvm6X1I6BB0oxNGsjnl2tSxmA38
	MXIEDTlL03ENJEdtBnJs3+yNeTKRU0Ct4mK1rT9Yi3tR1pDKQ5v07tclusefzNGccdOFrk
	yo5ZOqdjTJHW5jzU6C2kvHl8FFYjQVEX4x9Z7VMFmomXRCEjqDRdLwL6uf5omHhfsUCCEO
	dlcoHT4QjwIamSdC2sAtSuxkdzTIXFuUG83S32YHAqiasDtnQN5Qc54BHy8GUYW/kaMfYE
	O4AgU9ZUCW32Q/tdejW5rLRPnzfNgevAcNd8eJ052V4c2hcMCAPTo7Iq/ydzaw==
Message-ID: <07c55657-cc7e-433c-89e9-a21688ee8ba6@bootlin.com>
Date: Wed, 29 Jul 2026 08:31:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: stmmac: fpe: Move fprq configuration to
 stmmac_fpe_configure_pmac()
To: muhammad.nazim.amirul.nazle.asmade@altera.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260729015247.25774-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260729015247.25774-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/29/26 03:52, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The Frame Preemption Residue Queue (fprq) controls which Rx queue
> receives residual preemptive mPackets from the pmac. This is a pmac
> concern, not a TX concern, so move its configuration from
> stmmac_fpe_configure_tx() to stmmac_fpe_configure_pmac() where it
> logically belongs.
> 
> Use u32_replace_bits() instead of the open-coded mask/shift sequence.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index 3436e962a238..27e500edc8ac 100644
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
> @@ -68,6 +61,7 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
>  {
>  	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
>  	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
> +	u32 num_rxq = priv->plat->rx_queues_to_use;
>  	const struct stmmac_fpe_reg *reg = cfg->reg;
>  	void __iomem *ioaddr = priv->ioaddr;
>  	unsigned long flags;
> @@ -83,6 +77,12 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
>  
>  			value |= reg->int_en_bit;
>  		}
> +		/* Frame Preemption Residue Queue is the Rx Queue to which
> +		 * residual preemptive mPackets must be forwarded from the pmac.
> +		 */
> +		writel(u32_replace_bits(readl(ioaddr + reg->rxq_ctrl1_reg),
> +					num_rxq - 1, reg->fprq_mask),
> +		       ioaddr + reg->rxq_ctrl1_reg);
>  	} else {
>  		value &= ~reg->int_en_bit;
>  	}

Not a bit fan of the writel(u32_replace(readl(...))) but I don't feel strong
enough about that to warrant a resend 

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

