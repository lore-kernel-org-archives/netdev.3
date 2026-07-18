Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94551E2858;
	Sat, 18 Jul 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383592; cv=none; b=dtGKDEjVi5Rsg52+ZepSDbJPpaqhnGr3oedn3Nt2JMju0rT3Eihkd4D1I71/2bpLcbAkkVcKFHa0N0nFsDsvpRla+q2qMzGeuCl5gZ0YvId65KOw8IG1DhXCY76OhytDzVo1FbDsBExsgg740nefLHpGay605XbQ38zvAz16Qsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383592; c=relaxed/simple;
	bh=JH3LsEGmdh3VJbyJkn95aAZD5i8OcsLJpn77aHaAyvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbaSy/20eUBHDgx+wYksjElA5/Bv4Wjmx2hXHvwNe+z1aC+KiOWhVm7DFMSAOYi8UrUB1SKtnLnp40MLGiiH3Fx44yphAsoToRJS0GPvfv4JKvtVSDeNtPk/6LlLCZXidJo7t0DdrJc1ddfQwptDXX4pj/0MMkRFLBPSyzP9cnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VB5UATJP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VB5UATJP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=49LTXvKFeAPlDpQTEthidff6xNCxgQTzRd84k2/37vQ=; b=VB5UATJP2lmlOVP4d02usRdxQH
	Jji2lPj8sZ5C1aixHPHVTQXyHv96Jr75Df+UatdUB8rQBjbzGkATEWhrPWaJN2p3qqH36yIn3Hgfm
	7muX8r5M5qp/PXwfHPzuf1bkZUV5YhuPnspPm75bIEIgXh2+tFhAYsXzPTKX5ia6l6DY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wl5gQ-00Cwza-5j; Sat, 18 Jul 2026 16:06:26 +0200
Date: Sat, 18 Jul 2026 16:06:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: tresonic <tresonic@mail.de>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
	rmk+kernel@armlinux.org.uk, kuba@kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
Message-ID: <cf52e605-9b0f-4c95-9c90-ce827b7f56fd@lunn.ch>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
 <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
 <09ee8651-4f29-4ae0-8e82-a32a1f7ad04a@lunn.ch>
 <97d803a5-ca6e-4d4a-adc2-f97cabfded65@mail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d803a5-ca6e-4d4a-adc2-f97cabfded65@mail.de>

>  {
>  	u8 rx_channels_count = priv->plat->rx_queues_to_use;
>  	u8 tx_channels_count = priv->plat->tx_queues_to_use;
> +	u8 max_chan = max(rx_channels_count, tx_channels_count);
>  	u8 chan;
>  
> -	for (chan = 0; chan < rx_channels_count; chan++)
> -		stmmac_stop_rx_dma(priv, chan);
> -
> -	for (chan = 0; chan < tx_channels_count; chan++)
> -		stmmac_stop_tx_dma(priv, chan);
> +	for (chan = 0; chan < max_chan; chan++) {
> +		if (chan < rx_channels_count)
> +			stmmac_stop_rx_dma(priv, chan);
> +		if (chan < tx_channels_count)
> +			stmmac_stop_tx_dma(priv, chan);
> +		stmmac_deinit_chan(priv, priv->ioaddr, chan);
> +	}

It is a personal preference, but i would keep the code simple, stupid,
KISS.

Keep the two loops as they are. And add a third loop calling
stmmac_deinit_chan(). That then mirrors the code in
stmmac_init_dma_engine() which also has three loops.

I would also rename max_chan to dma_csr_ch so it has the same name as
in stmmac_init_dma_engine(). As i said, stmmac has pretty bad naming,
mirror functions are not obvious, but when adding new code, we should
try to do better.

    Andrew
