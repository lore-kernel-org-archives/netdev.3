Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085B29405;
	Sat, 18 Jul 2026 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784333822; cv=none; b=OEhieV6I7rMwXSAcr9bAcvdsaW0j6Z/XwDN4Z478Lh/xzbhuzx/J6XYxPhFeaD+t5u57hYGmyYV5x8F6H+VgzneW9QngBTVRcT/p8VsMej/MXC3cbKxQ61l/m116vbLXB2WIsrdWpx+4mfyJOVIN2jhj3RN/fIRXLAteLC3K6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784333822; c=relaxed/simple;
	bh=mws2OYrwRt5mwEZEHRos6WBf3Dk14UMGnk0aUYS7Fy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8v7fgF+z3Zhs+IRrNZe5q3h4XpOjv32+iFMTmmsT4NJZtFc+kkAof0dxeCqZgqoL5ebTNDaPJfBabqkwRD2zXbkOrldnbazsDe5X2Xla/9F72+iGYBGz/RoMy/N1ELYBo25KhjUIFnEGuycDq1grv4P4LbtmsoEZqaVdlT51CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AV4kJG1n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AV4kJG1n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FeZRh+hFE/fhoh04Fijc2iDsYBofp7xVpzEQlJROusc=; b=AV4kJG1nQLqTJRyCcTvBJPH5ze
	SQ1qY+eyhLPYxr00nGK/tGfKewgqng66K8tu4KmrQhKQPmy6qmEjDRyoI0wq8CW0julLVyRh8ChMg
	F0pvvOHjS1nQucylK+bxfiKoLHhwVgyy7b8+Csu0YNWNhLQE5qrarA3pdzBNAFEvygUE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wksjb-00Ct2b-Jf; Sat, 18 Jul 2026 02:16:51 +0200
Date: Sat, 18 Jul 2026 02:16:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: tresonic <tresonic@mail.de>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
	rmk+kernel@armlinux.org.uk, kuba@kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
Message-ID: <09ee8651-4f29-4ae0-8e82-a32a1f7ad04a@lunn.ch>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
 <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>

> It seems your assumptions are correct. If i do
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> index a0249715fafa..487efc746b20 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> @@ -129,6 +129,8 @@ void dwmac4_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>         const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
>         u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
>  
> +       value &= ~DMA_CHAN_INTR_ENA_RPS;
> +
>         if (rx)
>                 value &= ~DMA_CHAN_INTR_ENA_RIE;
>         if (tx)
> 
> I can suspend and resume!

Cool. So we might be going in the correct direction.

> Could it be sufficient to just do this and reenable on dwmac4_enable_dma_irq?

Unfortunately, it is not as simple as that.

The driver implements NAPI. Interrupts are expensive, so what NAPI
does is after there is an interrupt indicating there are received
packets, and there are more than 64 packets to be received, it
disables interrupts, and goes into polling made. Whenever it polls, if
there are packets available it keeps on polling. Only when polling
indicates there are no more packets, are interrupts re-enabled and
polling stopped.

You can see parts of this logic in stmmac_napi_poll_rx().

This means it cannot be done here. We need a function which is only
called on suspend, and probably release.

The interrupt is being enabled in the init_chan call in
stmmac_dma_ops. Ideally, it should be disabled in a mirror function,
which currently does not exist. So maybe deinit_chan() needs
adding. But where to call it from? init_chan() is called from
stmmac_init_dma_engine(), from stmmac_hw_setup(). stmmac_resume() does
call this. So we need something in stmmac_suspend(). Maybe in
stmmac_stop_all_dma()?

stmmac is messy, there are often not mirror functions. If there is a
stmmac_init_dma_engine() there should be
stmmac_deinit_dma_engine(). If there is stmmac_hw_setup() there should
be stmmac_hw_tairdown(). But none of these seem to exist. 

Anyway, do you want to try to implement deinit_chan() and call it from
stmmac_stop_all_dma()?

   Andrew
