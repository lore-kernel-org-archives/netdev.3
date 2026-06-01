Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553C38F239;
	Mon,  1 Jun 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306447; cv=none; b=sbqxxZMXNn6w3CoOhlxaw8JFQrfoCpeL8rCjngCBI0ziGTTFqAqH34+fWCfsyaDesDO2iBj/IApDJWgFOCruGjtCS1urKqoICpDmYzDalLRxhrKQi6erfzXm6ByLjIrhSaK1dNs4sPmTOt+bh93Tm8DmMr8RVpTxyqpPjzUymdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306447; c=relaxed/simple;
	bh=SpNU5lkKaoh2T8XyUcCLmJSct3h0bxzkJJOVk9g3AmM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D/JC8Xm3FIWkAXfyDvNHGuIX2RFVF71zNWpPJ5ayI8gmsb8n+jHDEUCKgSLtd9/MtJktZK1On3aDYZQnT7/gwOCvlP7PK2+f27CRpDrLHRXHLgoIKOYtlzi14nBKuYcLBYu2NhOkhjjUi3Dvkx/VLQSeqvgZOq0RoQEWk44VeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=EjdYs06h; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="EjdYs06h"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E933CA01FB;
	Mon,  1 Jun 2026 11:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780306443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n22Kt3rk1jFC5qE9hhtSrtH0b/EPbV+dHVc+6pLORH4=;
	b=EjdYs06hA2A74uh2nxpt5czJQrJO1mcdpIGaoLyr5iHQZKU3hbiJbROJTonl+1dx9u09QX
	ZVB7wZRg1wJ5OETVJ2xGJZBSKCqJlVE4guLWUD060FxaZGBdMMdw/e9Fnsit4mIZ+QRDgy
	K8lkGmnZgwUXmg/Vct7dveVygtjLS/70RtAUMl8Jq/EISdnmDW1rguJ+2zPjGwgqStfy4D
	tbpH/z2WDBTvoaAq7KhOxyR8fWptIsPwDPFTuF6dq8KRbcmA0ihNZzTqjez3GE1wmV6EXF
	g0Xcq7dSfZ0pMLNkuJ+cyfegvwEOUCRjXuamfHVx3PmU2gAD4sxz8f9z0bfDXA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 11:34:02 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/5] net: dsa: microchip: Add fallback Micrel
 compatibles
In-Reply-To: <20260526-ks8995-to-ksz8-v3-1-c530f651989f@kernel.org>
References: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
 <20260526-ks8995-to-ksz8-v3-1-c530f651989f@kernel.org>
Message-ID: <1359de47ba80bf8bbef7b5431699663d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 26.5.2026 17:59, Linus Walleij wrote:
> Because of forking paths when Micrel was acquired by Microchip,
> two devices also exist with the micrel,* prefix bindings.
> Add these to the KSZ SPI driver so users can use the more capable
> driver.
> 
> Make the KS8995 driver mutually exclusive with this driver
> to avoid probe races.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/Kconfig             |  1 +
>  drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 4ab567c5bbaf..e704ab702c18 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -100,6 +100,7 @@ config NET_DSA_RZN1_A5PSW
>  config NET_DSA_KS8995
>  	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
>  	depends on SPI
> +	depends on !NET_DSA_MICROCHIP_KSZ_SPI
>  	select NET_DSA_TAG_NONE
>  	help
>  	  This driver supports the Micrel KS8995 family of 10/100 Mbit 
> ethernet
> diff --git a/drivers/net/dsa/microchip/ksz_spi.c 
> b/drivers/net/dsa/microchip/ksz_spi.c
> index 373e9054947c..77aecac32466 100644
> --- a/drivers/net/dsa/microchip/ksz_spi.c
> +++ b/drivers/net/dsa/microchip/ksz_spi.c
> @@ -224,6 +224,21 @@ static void ksz_spi_shutdown(struct spi_device 
> *spi)
>  }
> 
>  static const struct of_device_id ksz_dt_ids[] = {
> +	/*
> +	 * Legacy Micrel bindings. In 2015 Microchip acquired
> +	 * Micrel which is the originator of the KSZ series, and
> +	 * devices branded for Micrel already existed, as well as
> +	 * some device tree bindings. These two products are identical
> +	 * to the same Microchip products.
> +	 */
> +	{
> +		.compatible = "micrel,ksz8864",
> +		.data = &ksz_switch_chips[KSZ8864]
> +	},
> +	{
> +		.compatible = "micrel,ksz8795",
> +		.data = &ksz_switch_chips[KSZ8795]
> +	},
>  	{
>  		.compatible = "microchip,ksz8463",
>  		.data = &ksz_switch_chips[KSZ8463]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
