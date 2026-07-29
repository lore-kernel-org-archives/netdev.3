Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CE44161B
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317193; cv=none; b=Sd3E/PlbUuYoAKkho7sQ/giFBGwKNSy3nO9sQxaU2ucFAhbyXxXAl9SPEZZEGNtXaZqu4kdBe76ItEul4W06G2aFJXWvzGhQ+momHZy7DTJHzChuZ2ZFgsWO3Fto2qw2czRtBEP83cvbMGC9OUZd0q1iMvbIQ4Z5ydIFaR9p/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317193; c=relaxed/simple;
	bh=g96Gt1HJmxN7rSJfrKxHGq4af/kEWfCPpSaBpCJfAwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9DXPLCsnyRe2SmPbKddgpdA3IaBzpgrSpqBIGV0sZi/QPsXR3mZB9yYclnskPMv4Ordp2H0cRMbNlxGwaM84L8YUkNZQbDwuEMKE6lJjaoLaosb8TIbHw/GyDr+SnVB5FuA0GUVcJOvBMA8tJ9i+KCjFGgN8V5EH6UKajV0Dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gjak/ta4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gjak/ta4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B0B651A12F6;
	Wed, 29 Jul 2026 09:26:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 833FE6039A;
	Wed, 29 Jul 2026 09:26:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6DB211C14B68;
	Wed, 29 Jul 2026 11:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785317181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oCT1EX6zccw94yOyJUeq8eOZ3JEcQC6kY4rDTxt/Cg4=;
	b=gjak/ta47z3NaWT4OdLsnfIEadlR71jny1KuHDPizBbtF3RClS/Ied5ezuuJYQe+ZYiQew
	SdekbEPJzijbC8GFvgxZbfkDOYng8t4omp+ERuCjiw7wAvkMQX/2lMvn/FzCS2LI9Y9JKC
	57M0EBeXkuuFEuO07lkt8QSvXZmbGqAYI/+shVWNJQe52c1W4nn0osrLeCta9Hm2V6s+JX
	5hzHqF1LcqjRERPooiJIP03s6TrTsQ4vIcxMfUVKl6ZyqG95GaHbLCAVllSGnxKm1K0VXf
	sHyyAIv4/DDFeiHXk+zpkImKzhcYFWMk+igXJI/abjeMpVBn0ZgPauKj+Cih/w==
Message-ID: <ac15d16e-1e3e-4b44-9e24-f12ef2e9d91c@bootlin.com>
Date: Wed, 29 Jul 2026 11:26:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: stmmac: dwxgmac2: configure INTM for
 per-channel interrupt routing
To: Zxyan Zhu <zxyan0222@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260729023653.1162763-1-zxyan0222@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260729023653.1162763-1-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 7/29/26 04:36, Zxyan Zhu wrote:
> The XGMAC DMA_MODE register has an INTM field (bits 13:12) that
> controls interrupt routing behavior for DMA transfer completion
> events:
> 
>   00 (default): sbd_perch_* are pulse signals, sbd_intr_o is also
>                 asserted for each completion event.
>   01:          sbd_perch_* are level signals, sbd_intr_o is NOT
>                 asserted for packet transfer completion events.
> 
> When multi-MSI is enabled, per-channel TX/RX interrupts are expected
> to arrive on their dedicated lines.  In the default INTM=00 mode,
> sbd_intr_o also fires for DMA completion events, but the multi-MSI
> handler stmmac_mac_interrupt() only processes MAC-layer events (LPI,
> PMT, timestamps) and returns IRQ_NONE for every DMA completion
> interrupt, resulting in a continuous stream of unhandled interrupts
> on the common IRQ.
> 
> Hardware verification with XGMAC and multi-MSI enabled:
> 
>   INTM=00: 5.4 million common IRQ interrupts in 3 seconds, ~1.8
>            million IRQ_NONE returns per second.
>   INTM=01: 0 common IRQ interrupts, per-channel IRQs work normally,
>            10G line rate works correctly.
> 
> Set INTM to mode 1 when multi-MSI is enabled.  This matches the
> existing GMAC4 implementation.
> 
> XGMAC multi-MSI has never worked correctly since it was introduced.
> 
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 10 ++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 61b6d45a02f5..f8ab347f7b5b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -320,6 +320,8 @@
>  /* DMA Registers */
>  #define XGMAC_DMA_MODE			0x00003000
>  #define XGMAC_SWR			BIT(0)
> +#define XGMAC_INTM_MASK			GENMASK(13, 12)
> +#define XGMAC_INTM_MODE1		0x1
>  #define XGMAC_DMA_SYSBUS_MODE		0x00003004
>  #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
>  #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 03437f1cf3df..ff83858ebc1f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -31,6 +31,16 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>  		value |= XGMAC_EAME;
>  
>  	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	/*
> +	 * Route DMA interrupts to per-channel lines when multi-MSI enabled.
> +	 */
> +	if (dma_cfg->multi_msi_en) {
> +		value = readl(ioaddr + XGMAC_DMA_MODE);
> +		value = u32_replace_bits(value, XGMAC_INTM_MODE1,
> +					 XGMAC_INTM_MASK);
> +		writel(value, ioaddr + XGMAC_DMA_MODE);
> +	}
>  }
>  
>  static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> 
> base-commit: 1df10cef2d1e7f9f2fb7eddb67fc70d3abf101f9

