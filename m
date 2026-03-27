Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5D3D75DF
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601272; cv=none; b=i0nuNamicdiyyVR4nal/f5Z/zWK/TC5mZz58GQy6aIomD7BsSAENBDE49hpP+80J/J+nH8mxW9XDfQR/v+NT0NCQ3LY3Ze1yqU/kWeWF/VmLc2fg1ln9uYcYjWdZ75lZVbjgdXA81002uaN5y++wAWaxv6U7S0+3WX0/a2GzqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601272; c=relaxed/simple;
	bh=cjx0Ar95zul6yedM17wSVBe+5eKaNg9WYiXHNBFawlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1rTZxq5vNML2Twgq20RzL0O8jEzbN3W2+nCXyKpjG2Lrr5Kirw3DEceZd8cfiOLe/cHPWjE+3GfV1H3j+8a4lMxeuPLz+95y+gSm/fw9sMd5Ewd50JWnE/StEHxvdadaVCmxnasXe/RZahRBP1YF908kXQ+9trDsFFAEJm62Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B6Hq1Iqh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B6Hq1Iqh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 29ED9C406B4;
	Fri, 27 Mar 2026 08:48:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A63860230;
	Fri, 27 Mar 2026 08:47:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A83DD10450F33;
	Fri, 27 Mar 2026 09:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774601266; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VMjRGKP0MWL1Fn7wgmAUOQV5Tnmyq0Po0dMJmdwqM6o=;
	b=B6Hq1IqhoRNVkQt9iXsYm8MNDvCfFMARgWG19zmu2rGVmNvwmJG7guirSwZYBCw60H1ysw
	8MDjKRhQW6AAPc0jtzpAJcPHBJXuPPlNctScC2bQk3xZpA0LwNB3a3UYksTQVt/WrzIA9Q
	wGQ1pdamUuQmqQIJwbX1FvHg4FqAVMVu9S2WQaNMBu7h+JJ/rfbuRQwH0Q2CKUcAprbZe2
	Nc0OVaxo5L6SYGzSPA99MWb1lvgOHaMDk2N+DsWLjLTi6u5J3wgMssFCI1KcU3G/BgCMOK
	cFwc/hNrrR8KF5DbrtJ8QVEXIz0gpYe7FXQhy/v7f6T3b/T2uzcronF+q0PyAg==
Message-ID: <72b79059-25e1-4209-a0dc-30dc0c310aff@bootlin.com>
Date: Fri, 27 Mar 2026 09:47:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: lan743x: add support for RMII interface
To: Thangaraj Samynathan <thangaraj.s@microchip.com>,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 Raju.Lakkaraju@microchip.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260327054008.79294-1-thangaraj.s@microchip.com>
 <20260327054008.79294-3-thangaraj.s@microchip.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260327054008.79294-3-thangaraj.s@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 27/03/2026 06:40, Thangaraj Samynathan wrote:
> Enable RMII interface in the lan743x driver for PHY and MAC
> configuration.
> 
> - Select RMII interface in lan743x_phy_interface_select().
> - Update phylink supported_interfaces and MAC capabilities.
> - Enable RMII via RMII_CTL in lan743x_hardware_init().
> - Define RMII_CTL register and enable bit in lan743x_main.h.
> 
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 18 ++++++++++++++++++
>  drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index b7b1584d867d..86d35810460f 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1370,6 +1370,8 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
>  
>  	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
>  		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
> +	else if (adapter->is_pci11x1x && adapter->is_rmii_en)
> +		adapter->phy_interface = PHY_INTERFACE_MODE_RMII;
>  	else if (id_rev == ID_REV_ID_LAN7430_)
>  		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
>  	else if ((id_rev == ID_REV_ID_LAN7431_) && (data & MAC_CR_MII_EN_))
> @@ -3158,6 +3160,13 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
>  		__set_bit(PHY_INTERFACE_MODE_MII,
>  			  adapter->phylink_config.supported_interfaces);
>  		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  adapter->phylink_config.supported_interfaces);
> +		adapter->phylink_config.mac_capabilities &= ~MAC_1000FD;

Some followup should take care of removing the 1000FD cap for MII as
well. Same for the LPI caps, is there a similiar limitation for MII ?

Otherwise, this patch looks good to me so,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>	

Maxime

