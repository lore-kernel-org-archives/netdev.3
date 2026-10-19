Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F13E8C70;
	Mon, 19 Oct 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396724; cv=none; b=FlASgqHXcz1Ct4QvAwdDLB9+ODgI+OqSlxOJDY1gzR7s/EWjKIau/h/G8J5NhWqqGWHON981JBkwAQx+rj5Z6Ipevwzyw5gLh5U/+BUwnjcGDFP9rPx01/Acj7DBfGeB/qHHMXZ7NfmIR6VDupwGMHkwsEkjLTJ2DTiTxZbgdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396724; c=relaxed/simple;
	bh=V0VIqDVyiPPQJ+caJbPRvCvUhmLBJmBJ39zRFbxwIvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uR4OAAQRQg/lXIIwr+6yzwdIsjHPIPkAfYbYJaCz9US62TvvzptoOnMR1BthTuWNA9Oz3WrerjW15S3PvFzKQ42jYcilxOFNYFb92mbYLq+0R84t1TnMfe0EII7bP5Pj/NYqsdh84w+piSPp43+mcq+lwne9svS9yinks8lIk5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lW3gZU1F; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lW3gZU1F"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E7E63C5CD5A;
	Mon, 19 Oct 2026 07:59:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA2C5606D2;
	Mon, 19 Oct 2026 07:58:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FF0A10328429;
	Mon, 19 Oct 2026 09:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792396717; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NYrf3UgXP5DXfY3kt/urngIbizBWIl4Prx1hFfMMht4=;
	b=lW3gZU1F/b/XgskjtbHeWUXleyoE6/Ao9cUMr7VJcryyvtqxE3jcorbEiG4quyYfbzLnTK
	3yja1CP5VGO5cQbfeG+FZmXTeAaVtnydtZKPK9JNXWBOq64G4kSPREwaoxebjqlgJbrNkR
	mE7KwToXnsGH67mMtR6hfIUeivHwqTjpD2AWJEOs/VS9TnpV08uf1+Hxp7qdgLn81x0Zh9
	vQeKOwSvzaXlJ/1+MUbba7+CBBNGu0Py8gHRjCiGwwjIgYyMngo91qasz8VYvi46SUwnOB
	tyaIKF1enK62ejkB/zTK1UEQq0zcN3gnF7U5gtpZju998slcU9NbSIBkE9SFKA==
Message-ID: <7980859d-bc9e-4886-8096-ea5254bae8d4@bootlin.com>
Date: Mon, 19 Oct 2026 09:58:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: stmmac: dwxgmac2: Add XGMAC 3.01a
 support
To: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: Daniel Thompson <daniel@riscstar.com>, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 richardcochran@gmail.com, p.zabel@pengutronix.de, peppe.cavallaro@st.com,
 joabreu@synopsys.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261019030129.1470307-1-elder@riscstar.com>
 <20261019030129.1470307-4-elder@riscstar.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261019030129.1470307-4-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/19/26 05:01, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> XGMAC 2.x and 3.x are architecturally very similar.  That means that
> for everything except one erratum we can simply use the XGMAC 2.x
> callback functions in the stmmac_dma_ops structure.
> 
> Only the set_rx_ring_len callback is specific to XGMAC 3.01.  It
> limits the number of outstanding write requests that can be serviced
> per DMA.
> 
> The other erratum addressed in this patch is simply a comment to
> ensure that a feature that stmmac doesn't currently use is not enabled
> without contemplating the errata.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 52 +++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index f8ab347f7b5b9..0fe86e9942334 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -374,6 +374,8 @@
>  #define XGMAC_DMA_CH_RxDESC_TAIL_LPTR(x)	(0x0000312c + (0x80 * (x)))
>  #define XGMAC_DMA_CH_TxDESC_RING_LEN(x)		(0x00003130 + (0x80 * (x)))
>  #define XGMAC_DMA_CH_RxDESC_RING_LEN(x)		(0x00003134 + (0x80 * (x)))
> +#define XGMAC_OWRQ			GENMASK(25, 24)
> +#define XGMAC_RDRL			GENMASK(15, 0)
>  #define XGMAC_DMA_CH_INT_EN(x)		(0x00003138 + (0x80 * (x)))
>  #define XGMAC_NIE			BIT(15)
>  #define XGMAC_AIE			BIT(14)
> @@ -465,6 +467,7 @@
>  extern const struct stmmac_ops dwxgmac210_ops;
>  extern const struct stmmac_ops dwxlgmac2_ops;
>  extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
> +extern const struct stmmac_dma_ops dwxgmac301_dma_ops;
>  extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
>  
>  #endif /* __STMMAC_DWXGMAC2_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index ff83858ebc1f3..f9a77d641eb65 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -36,6 +36,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>  	 * Route DMA interrupts to per-channel lines when multi-MSI enabled.
>  	 */
>  	if (dma_cfg->multi_msi_en) {
> +		/*
> +		 * A friendly warning to future adventurers. If Descriptor Posted
> +		 * Write support, which is off by default, is ever enabled then be sure
> +		 * to make it optional. This is required by errata for at least XGMAC
> +		 * 3.01A... and the XGMAC 2.x and 3.x are architecturally similar so we
> +		 * use dwxgmac2 support for the 3.x family as well.
> +		 */
>  		value = readl(ioaddr + XGMAC_DMA_MODE);
>  		value = u32_replace_bits(value, XGMAC_INTM_MODE1,
>  					 XGMAC_INTM_MASK);
> @@ -492,6 +499,20 @@ static void dwxgmac2_set_rx_ring_len(struct stmmac_priv *priv,
>  	writel(len, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(chan));
>  }
>  
> +static void dwxgmac301_set_rx_ring_len(struct stmmac_priv *priv,
> +				       void __iomem *ioaddr, u32 len, u32 chan)
> +{
> +	u32 val = FIELD_PREP(XGMAC_RDRL, len);
> +
> +	/*
> +	 * Reduce the number of outstanding write requests to 3 (from default
> +	 * of 4). This is an errata workaround for XGMAC 3.01a.
> +	 */
> +	val |= FIELD_PREP(XGMAC_OWRQ, 3);
> +
> +	writel(val, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(chan));
> +}
> +
>  static void dwxgmac2_set_tx_ring_len(struct stmmac_priv *priv,
>  				     void __iomem *ioaddr, u32 len, u32 chan)
>  {
> @@ -621,3 +642,34 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
>  	.enable_sph = dwxgmac2_enable_sph,
>  	.enable_tbs = dwxgmac2_enable_tbs,
>  };
> +
> +/* All but one field are the same as dwxgmac210_dma_ops */
> +const struct stmmac_dma_ops dwxgmac301_dma_ops = {
> +	.reset = dwxgmac2_dma_reset,
> +	.init = dwxgmac2_dma_init,
> +	.init_chan = dwxgmac2_dma_init_chan,
> +	.init_rx_chan = dwxgmac2_dma_init_rx_chan,
> +	.init_tx_chan = dwxgmac2_dma_init_tx_chan,
> +	.axi = dwxgmac2_dma_axi,
> +	.dump_regs = dwxgmac2_dma_dump_regs,
> +	.dma_rx_mode = dwxgmac2_dma_rx_mode,
> +	.dma_tx_mode = dwxgmac2_dma_tx_mode,
> +	.enable_dma_irq = dwxgmac2_enable_dma_irq,
> +	.disable_dma_irq = dwxgmac2_disable_dma_irq,
> +	.start_tx = dwxgmac2_dma_start_tx,
> +	.stop_tx = dwxgmac2_dma_stop_tx,
> +	.start_rx = dwxgmac2_dma_start_rx,
> +	.stop_rx = dwxgmac2_dma_stop_rx,
> +	.dma_interrupt = dwxgmac2_dma_interrupt,
> +	.get_hw_feature = dwxgmac2_get_hw_feature,
> +	.rx_watchdog = dwxgmac2_rx_watchdog,
> +	.set_rx_ring_len = dwxgmac301_set_rx_ring_len,	/* Only 3.01 */
> +	.set_tx_ring_len = dwxgmac2_set_tx_ring_len,
> +	.set_rx_tail_ptr = dwxgmac2_set_rx_tail_ptr,
> +	.set_tx_tail_ptr = dwxgmac2_set_tx_tail_ptr,
> +	.enable_tso = dwxgmac2_enable_tso,
> +	.qmode = dwxgmac2_qmode,
> +	.set_bfsize = dwxgmac2_set_bfsize,
> +	.enable_sph = dwxgmac2_enable_sph,
> +	.enable_tbs = dwxgmac2_enable_tbs,
> +};

