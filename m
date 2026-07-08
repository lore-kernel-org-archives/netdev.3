Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150E409600
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502174; cv=none; b=qb077BagLUD1/uqLPFKxFHFpOpXOSqKVXxl1onGWcQXAxWSk9OoG8ert67mXOdhxEK2htPySwbvLdZV5gaA+mGs2bW3lq61yR4uARmOT4w9YXGC7VNJT6Q/ippOFA2JvOyqmrrgQXQrPF7HFyh/Ku4DkRZjpytdutTSTmMWJ8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502174; c=relaxed/simple;
	bh=wfg0mXHJNXcM6eMr/sjVc2ZVkhsTW8b/GaVJ+8zp73I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNMn9A4qdbUmdP/if6G9YCQhUjIjZGoozBKey1CnaBZQNWcH4Xli4mGlODbu/duSS690OrMbzD4BH5eOlz+t3wtVw5yGmcX18gfvNP7xzJ2j5wT2LjOekE4QSlOCaIwbXG5h6KZ0jMYt9S+H7ifrBuAeJTQ+EPBu+2txGjXpxLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ru94O26T; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ru94O26T"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 06C91C8F445;
	Wed,  8 Jul 2026 09:16:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BF8F60337;
	Wed,  8 Jul 2026 09:16:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83A6411BC0CFE;
	Wed,  8 Jul 2026 11:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783502168; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qOMFD/APDtG7nBqOMYfX/IhIsViQVFXVhI6H/yMdvHo=;
	b=ru94O26T43mlxL2cIBX5lzUbVlmEHXENjSYkidWcZ4fB4BNAHeZORh+6LVllswrshyMRUK
	g6u6c/gM9RhAgallDLmQti6HwsxELEQnBgJBybPJs3xohzndsgOBdfnCj0PjjDn+i0gCqU
	xOKqt8v/5ye+ltJaHOKVGQeHGNAUcWIs1Tnbn4GDJ6dKyAo4Ys5Lj+Q0NI9y/GhJkQ5twI
	M3/vuMt7PSK5rwxB1ZZQsGt1v0Dzz+FhCeMhgmBCTb+VGEgUsFI6/DK+Jirpz8G44nTq8H
	LQv9+McURbD8FwAiF8+uG4UkjhFt9G1RiApWT4mIwi3DFKgsvUQEQkQw1Kt8xw==
Message-ID: <c8cbf359-e224-44c6-8692-9e1d1527ae0c@bootlin.com>
Date: Wed, 8 Jul 2026 11:16:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup when
 opening the interface
To: Stefan Agner <stefan@agner.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
References: <message-id-of-your-v1-mail>
 <20260707195425.405989-1-stefan@agner.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260707195425.405989-1-stefan@agner.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Stefan,

On 7/7/26 21:54, Stefan Agner wrote:
> Since the referenced commit, changing the MTU on a running interface no
> longer disconnects and reconnects the PHY; __stmmac_release() merely
> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
> is not enabled. __stmmac_open() then performs the DMA software reset in
> stmmac_hw_setup() before phylink_start() resumes the PHY again.
> 
> IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
> powered down, and stmmac requires a running receive clock for the DMA
> software reset to complete (the phylink config sets mac_requires_rxc).
> On such setups, e.g. the RK3566-based Home Assistant Green with an
> RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
> leaves the interface dead:
> 
>   rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
>   rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initialization failed
>   rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
>   rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface after MTU change
> 
> In the field this is triggered by NetworkManager applying an MTU while
> activating the connection, breaking networking entirely.
> 
> Resume the PHY in __stmmac_open() before the hardware setup, making it
> the counterpart of the phylink_stop() in __stmmac_release(), like
> stmmac_resume() already does for the same reason. phylink_start() also
> resumes the PHY, but only after stmmac_hw_setup(), and it cannot be
> moved before the hardware setup since it may bring the link up
> immediately from a workqueue, racing with the initialization (see the
> comment in stmmac_resume()). For the regular ndo_open path the PHY has
> just been attached and is not suspended, in which case
> phylink_prepare_resume() does nothing.
> 
> Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open()/release()")
> Link: https://github.com/home-assistant/operating-system/issues/4858
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I was able to reproduce the issue on imx8mp and socfpga. Adding this case to
my periodic test list...

Indeed the assymetry isn't very nice, OTOH there's not phylink counterpart
for phylink_prepare_resume(). This helper was added for the suspend/resume
case, and only for it as the doc states, it just happens to do exactly
what we need to fix the issue :

/**
 * phylink_prepare_resume() - prepare to resume a network device
 * @pl: a pointer to a &struct phylink returned from phylink_create()
 *
 * Optional, but if called must be called prior to phylink_resume().
 *
 * Prepare to resume a network device, preparing the PHY as necessary.
 */
void phylink_prepare_resume(struct phylink *pl)

I think this helper should be renamed and the doc updated, stmmac is the
sole user, and it's really about controlling that rxc and not about
suspend / resume. Resuming from suspend is just one of the cases where we
need that RXC early on.

So either something like 'phylink_prepare_start_or_resume' but it's long,
or maybe we can be more explicit about it and simply call it:

phylink_start_rxc(pl)

(without a corresponding stop)

Maxime

