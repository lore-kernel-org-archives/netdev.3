Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C53112C1;
	Fri, 17 Jul 2026 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302831; cv=none; b=c5hyCklic3QlJQcQkYBAacPStlrvbdEWeQRaHGByzg7Krwc7b2cKMivAjMVeD4XM63LPmirm3hN0Dnqw60/fuehsuUqZolfchkpLW69pOGSd7kPVHwyEXlPHNaK+o0rIcaizqIytuWmin93lpLIGQFHLoQnDo9M7/1y9lWZKhcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302831; c=relaxed/simple;
	bh=3pSOTf1A8nX4QMA1fAxgQQSsj+twgjuFlI4Oh7RyCCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0KMoB0xlSBlGOnyic4uyA/MI6ZeBtXtZdQPr8IcxrJHq1Bu3qXqGsVbdmW9uL2zkXW6QYVE2CQYu804o4jf+2Lj2o0KhAUYMaynhc5NDfIGW3jIGN64GAHUCEd380TPGwZF4qkoiK61uxC0dbKmbeD4+m8/wRbfcWjtTwn93lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0dflgpbk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0dflgpbk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aNMH7FWgBIsxZpXSMMdNy6EHMmXzocwCw0zMUqGz1gA=; b=0dflgpbkqX0ytFmipEdvWhJVdI
	5Pf8lVfrHt1vl5sYtrmJ0zJAcVF294lhVP5Zc2Ho3uYhPy67URIx//QuxPNLASqCwlYxUzG1798q4
	k9rxZBpQTQCf5J6lzAejPo4g0D4rsK4dgttfbVkYzZ/wBYuuzhq9vy8NxdZ31Ntr3puA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkkfq-00Cpj1-4b; Fri, 17 Jul 2026 17:40:26 +0200
Date: Fri, 17 Jul 2026 17:40:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: tresonic <tresonic@mail.de>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
	rmk+kernel@armlinux.org.uk, kuba@kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
Message-ID: <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>

> I tested the changes as you suggested and it seems DMA_CHAN_INTR_ENA_RPS in DMA_CHAN_INTR_ABNORMAL_4_10 broke it.
> With this change on master suspend is working:
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> index 43b036d4e95b..e907142c9ee2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -121,7 +121,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>                                          DMA_CHAN_INTR_ENA_TIE)
>  
>  #define DMA_CHAN_INTR_ABNORMAL_4_10    (DMA_CHAN_INTR_ENA_AIE_4_10 | \
> -                                        DMA_CHAN_INTR_ENA_RPS | \
>                                          DMA_CHAN_INTR_ENA_RBU | \
>                                          DMA_CHAN_INTR_ENA_FBE)
>  /* DMA default interrupt mask for 4.10a */

OK, that narrows it down a bit.

I made the guess it is an interrupt storm during suspend, because
interrupts are not disabled. DMA_CHAN_INTR_ABNORMAL_4_10 is written to
hardware in dwmac410_dma_init_channel(). However, i don't see anywhere
these interrupts are clear? struct stmmac_dma_ops has an init_chan
operation, but there is no opposite operation to reset a channel?
There is however disable_dma_irq. Maybe DMA_CHAN_INTR_ENA_RPS can be
cleared there?

But i'm also having trouble finding where dwmac4_disable_dma_irq() is
actually called. It is called from stmmac_disable_rx_queue() and
stmmac_disable_tx_queue() but they only seem to be used in the XDP
code.

Are the DMAs being stopped during suspend? I don't know this driver
well enough to answer that.

Can you scatter some printk() around and see what actually happens on
suspend. See if you can find somewhere to disable that one interrupt?

	 Andrew
