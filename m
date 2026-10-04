Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9549480DEB;
	Sun,  4 Oct 2026 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791148424; cv=none; b=O0XgxLWzTbTPmkS7yK67GL6elTzAPXyuLVX15rOEr86GihGuGptLGWYslxLOUdqZOeIsd56IQVOcIDr8EPC0HoXvTs+Wx0ayx19vgWEPHt3MimISoIc89pOGnYTMEwPuNfMX44UwG0TYzhLkRGYVC0bloAFoS+wv8kQIvNFcgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791148424; c=relaxed/simple;
	bh=NFYhCoYyRwrUc0Lyiyp3uLvg7G1eCSWrSipN36e/iwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeaqf1eDrmzU2TjIHIe0XJT0+PgGi2ozMuuQ2n6w9UWqZRYiGa3nk6ZH4QRXUdBQgGTI2655GErVMQ9fFTmv7jNqEBYQDS565vvovhmJTFhFV7d7CzVJ2S0Ta0iEkGsedwzepLhlSHNdEL71Dqdf3Ws65vgUnERTAJ6EytO0flY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kCUsydxH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kCUsydxH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1B5AB1A113A;
	Sun,  4 Oct 2026 21:13:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2DFD604FE;
	Sun,  4 Oct 2026 21:13:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD9731032820F;
	Sun,  4 Oct 2026 23:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791148417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nXPXirW3eRDsSI9mvG4DFF7E3a00ea/RwmInqyXUVd4=;
	b=kCUsydxHi1pBYG/VMU/FQcimtNJep3NIuesye/jvgOjSjEhH/76NRdMy4W334dzAh2mwqL
	NAJrzK4xjqvAQEWVQPuKKWXqgC7W993Gfw7IanqW/t0bd2hSCIZ8YHThNyq8lPs7XLmL+c
	sj8d3hdOigyOeVezUEzMB0h6XSzD+4RUTVJHTD+EoVPHOHXabzSdpDL6RrFoqjTImoGhlX
	xk6jjh850A9O8vO5ZjhDzfrhIrbACQKXO3O/G6ycuany91IVzTe3wlEXh6S7EltG9da2Eo
	INQJBZJLmavvZBTml0LeAhLl7Mt9OxbwWQKNXhSHnfHzXN3ud2jt/NntjLibew==
Message-ID: <aafea01f-546e-47de-9e1d-e404450e78c5@bootlin.com>
Date: Sun, 4 Oct 2026 23:13:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] net: stmmac: dwmac-meson8b: add support for the
 Amlogic T7
To: Lucas Tanure <tanure@linux.com>, xianwei.zhao@amlogic.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261004144046.391444-1-tanure@linux.com>
 <20261004144046.391444-4-tanure@linux.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261004144046.391444-4-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lucas,

On 10/4/26 16:40, Lucas Tanure wrote:
> The glue registers on the T7 are laid out exactly as the G12A ones, RX
> delay field included, so the T7 can reuse the G12A settings.
> 
> What the T7 does not share is how the controller reaches DRAM: the bus
> path goes through a pipeline stage with a gate of its own, and no device
> other than the controller has any use for that gate. Claim it and hold
> it enabled for as long as the controller is bound, otherwise it is
> switched off as unused and a transfer that has been started can never
> complete.
> 
> Give the T7 match data of its own so that only it looks the clock up,
> and require the clock instead of treating it as optional: the controller
> cannot do DMA without it, and failing the probe with a clear message
> beats booting and hitting an undiagnosable hang later.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---

[...]

>  
> +static const struct meson8b_dwmac_data meson_t7_dwmac_data = {
> +	.set_phy_mode = meson_axg_set_phy_mode,
> +	.has_prg_eth1_rgmii_rx_delay = true,

Hmpf sorry this falls onto your series, but looking at the code it seems
that this glue has the RGMII handling backwards...

In meson8b_init_rgmii_delays :

         switch (dwmac->phy_mode) {                           
         case PHY_INTERFACE_MODE_RGMII:                       
                 delay_config = tx_dly_config | rx_adj_config;
                 break;                                       
         case PHY_INTERFACE_MODE_RGMII_RXID:                  
                 delay_config = tx_dly_config;                
                 cfg_rxclk_dly = 0;                           
                 break;                                       
         case PHY_INTERFACE_MODE_RGMII_TXID:                  
                 delay_config = rx_adj_config;                
                 break;                                       
         case PHY_INTERFACE_MODE_RGMII_ID:                    
         case PHY_INTERFACE_MODE_RMII:                        
                 delay_config = 0;                            
                 cfg_rxclk_dly = 0;                           

This is the behaviour one would expect from a PHY perspective.

And indeed, 66 amlogic dts have "phy-mode = rgmii".

grep "phy-mode = \"rgmii\"" $(find arch/ | grep amlogic) | wc -l
66

I really think all these 66 "rgmii" instance should have been "rgmii-id"...

It's probably too late to change that though :(

Maxime
