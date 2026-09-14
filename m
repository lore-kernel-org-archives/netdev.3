Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4747ACCC;
	Mon, 14 Sep 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395472; cv=none; b=DSzyn57jFvCaS8d+4rMfCzlA+FRjhsSKOdaR9cSMFqq/Cb4A1hqwlJ87bEnDg0bKb5wq91WcwLsYrTbCsdk1Uoir38qAJujKSFSwTSGVYJcpE7ODZMcXZBk343UQHA7UeDJQEd2WRK9ov57nDabLwAjWVER+zUKbFrBOHXyOsrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395472; c=relaxed/simple;
	bh=SDqAZti/BCotUVGV4wz0wJY55FTzMyO0+5R5FdBHTJA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tm2n6ZJQdYYRIBHOiYSut9VhlUUsbLjGLe7sOT8kyG+Qmoif3WgBq8Qk/NP0lGjsz/lqsFpq5Zdid4JSEmvKULTYCtOkH7xCE4u4vOcGLFhBJ4FNqWMbvV2DN6wKCZNK47nQ/OeGD88ha4fjbZzA5HXYqudJpauhIZZbwzU46NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=2fotui9Y; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="2fotui9Y"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95983A91DB;
	Mon, 14 Sep 2026 16:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789395467; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=//gKRI6vJSt4tiZ77db84KWCpaV85uXVckkTDkSP5og=;
	b=2fotui9Y6irYr6DzUhfTUYI2wQDd/7FxAw3DALcVwZsSXBF+kP9pbUDJHG09AH0RkOFbaw
	D20Ljfmxmgfzm+qidEu20PpuixJeJWviA3/dBO4qdyJky67/I2a3SjUM0V+516cNZumNCz
	9xvPoHtvfnf2E3Qur/mgSO3gvm26unWVu237iqsrZ3jPi/f0HmFsypg1Y2j1lfy0VdqCC4
	Jzy2u0FT+qPFjKmGroVjkpW9xJrlBcLFhGh0pnNwYQRBYiwdC1/0hIC2oFksaQIf4HHxBi
	U7PNpldO9zyCpK85FvgPc+6sjb2Vd/MZbqxFa6WG59kIZzWWvtokt2w1nOwVBw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 16:17:47 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
In-Reply-To: <20260914-ax88179a-v11-8-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-8-5ea7a925ba6d@birger-koblitz.de>
Message-ID: <9217e516e7725ee9b5f982af380eae87@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.9.2026 14:46, Birger Koblitz wrote:
> Configure phylink to work with the PHYs in the AX88197A controllers
> and provide ethtool get/set eee operations calling into phylink.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/usb/ax88179a_devices.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/usb/ax88179a_devices.c 
> b/drivers/net/usb/ax88179a_devices.c
> index 
> 80cabe3557cdef8267c365fccc0bc379936bb241..97aad545daee1dd1f5c4d63a1276523589c9617f 
> 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -206,6 +206,20 @@ static int ax88179a_get_eeprom_len(struct 
> net_device *net)
>  		return AX88179A_EEPROM_LEN;
>  }
> 
> +static int ax88179a_get_eee(struct net_device *net, struct 
> ethtool_keee *edata)
> +{
> +	struct ax88179_data *ax179_data = netdev2data(net);
> +
> +	return phylink_ethtool_get_eee(ax179_data->phylink, edata);
> +}
> +
> +static int ax88179a_set_eee(struct net_device *net, struct 
> ethtool_keee *edata)
> +{
> +	struct ax88179_data *ax179_data = netdev2data(net);
> +
> +	return phylink_ethtool_set_eee(ax179_data->phylink, edata);
> +}
> +
>  static const struct ethtool_ops ax88179a_ethtool_ops = {
>  	.get_link		= ethtool_op_get_link,
>  	.get_msglevel		= usbnet_get_msglevel,
> @@ -215,6 +229,8 @@ static const struct ethtool_ops 
> ax88179a_ethtool_ops = {
>  	.get_eeprom_len		= ax88179a_get_eeprom_len,
>  	.get_eeprom		= ax88179_get_eeprom,
>  	.set_eeprom		= ax88179_set_eeprom,
> +	.get_eee		= ax88179a_get_eee,
> +	.set_eee		= ax88179a_set_eee,
>  	.nway_reset		= usbnet_nway_reset,
>  	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
>  	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
> @@ -440,6 +456,10 @@ static int ax88179a_phylink_setup(struct usbnet 
> *dev)
>  		phy_if_mode = PHY_INTERFACE_MODE_SGMII;
>  	}
> 
> +	memcpy(data->phylink_config.lpi_interfaces,
> +	       data->phylink_config.supported_interfaces,
> +	       sizeof(data->phylink_config.lpi_interfaces));
> +
>  	phylink = phylink_create(&data->phylink_config, dev->net->dev.fwnode,
>  				 phy_if_mode, &ax88179a_phylink_mac_ops);
>  	if (IS_ERR(phylink))


Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
