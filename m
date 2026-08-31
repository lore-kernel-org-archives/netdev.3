Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B183AC0FC;
	Mon, 31 Aug 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163134; cv=none; b=IOxBi4wRAMTEOdTNz0O0741WIFZA2wVyRU2mNU7vJKrsmn/DnF89kW3rTZgVrTdRe4npHjisshTTny+RsAjPeqp6OiS5l8I/CGNAWj9VrpezCh0vhVP9SWYisd3Ba9vusCmK3UjyS8F+M8aj4EaJUu/H9K0fS7ykwm6PdUWNBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163134; c=relaxed/simple;
	bh=ihu27po+MSYTkCfgNeihbJuHt37fI8PUzCU6EmX1XnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvWHteYBAlx8YJ62fZ+oRyJMua3rj0cLtGZ3Kwoqq2BV3yGfAMgDxFdsjLS08hzLUPkVlqM9WlaARNfvZfceaWkwxxP3ASo2z/2o46oPlgOYJ7Qj3MUz8RUxJz3/1yIwB03MwmhlYTv9XG5LmLJk/NqRNmw7Cn8mDUZsKm8zHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zmyopjxG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zmyopjxG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 379F24E41463;
	Mon, 31 Aug 2026 07:58:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 09F88601E1;
	Mon, 31 Aug 2026 07:58:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 270B811C783B9;
	Mon, 31 Aug 2026 09:58:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788163126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tyQu/2/Mg8KmAYomHE0uTCEdQlUlumYeDgFTTXDPZW0=;
	b=zmyopjxGE3DfwUOnguKowfJywKGPlnIHXFsgNlj8e/AerT3dgZx0+LfAjjiSPHLJCH69eS
	oLR6o3S/2CO+f3rGq7eNkTgOplksmOodCD7iHvSQASgqzcou4leOLy59TTI2WaAn4YuM0c
	IRs/aB03RotQ2FvzYYR3r9dZDp9VKvNbgeBiIaPL7LH6j+5+UlF4NbYrapMf+kg31nVXDM
	vfRtGunesFKcKa8urt577LUAyUx2h76A7HP7l8xcKIoe5/z9OE+r9BO5DPEdfmAwIzVPM2
	gayHrsHc4Ji34xsJlvMPkf9AZ2nBUMyvtDkhqufzyptGFG9ncIr6EaX7nc+yvA==
Message-ID: <b5680417-53e6-4a87-861e-40765a6ccada@bootlin.com>
Date: Mon, 31 Aug 2026 09:58:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/6] net: phy: unregister SFP upstream before port
 cleanup
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org,
 andrew@lunn.ch, kuba@kernel.org
Cc: hkallweit1@gmail.com, chleroy@kernel.org, qingfang.deng@siflower.com.cn,
 hao.guan@siflower.com.cn, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
 <20260823035600.188864-3-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260823035600.188864-3-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/23/26 05:55, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> Commit 4497f5028675 ("net: phy: Clean the phy_ports after unregistering
> the downstream SFP bus") established that an SFP upstream must be
> unregistered before its phy_ports are destroyed because SFP callbacks
> may access these ports.
> 
> phy_setup_ports() does not follow this order when a later port setup
> step fails after phy_sfp_probe() succeeds. It destroys the SFP phy_port
> and leaves phy_probe() to unregister the upstream later, creating a race
> between port destruction and SFP upstream callbacks.
> 
> The error unwind is also split across three functions. If
> phy_setup_sfp_port() fails, phy_sfp_probe() leaves the upstream
> registered and relies on phy_probe() to remove it after
> phy_setup_ports() returns.
> 
> Make each layer unwind the resources it successfully set up. Unregister
> only the upstream in phy_sfp_probe() when SFP port setup fails, since
> the failed port has already been destroyed. Add phy_sfp_release() for a
> successful SFP probe, and make phy_setup_ports() use it before cleaning
> up the remaining ports. Once phy_setup_ports() has rolled back all port
> setup, make phy_probe() skip this cleanup.
> 
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks for this cleanup,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/phy_device.c | 49 ++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 2cf70471ae089..4b9b2300422fb 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1723,12 +1723,41 @@ static int phy_sfp_probe(struct phy_device *phydev)
>  			phydev->sfp_bus = NULL;
>  	}
>  
> -	if (!ret && phydev->sfp_bus)
> +	if (!ret && phydev->sfp_bus) {
>  		ret = phy_setup_sfp_port(phydev);
> +		if (ret) {
> +			sfp_bus_del_upstream(phydev->sfp_bus);
> +			phydev->sfp_bus = NULL;
> +		}
> +	}
>  
>  	return ret;
>  }
>  
> +/**
> + * phy_sfp_release - release resources set up by phy_sfp_probe()
> + * @phydev: the PHY device
> + *
> + * Release the SFP resources set up by a successful phy_sfp_probe(). Unregister
> + * the upstream before destroying its phy_port, so SFP upstream callbacks cannot
> + * race with port destruction.
> + */
> +static void phy_sfp_release(struct phy_device *phydev)
> +{
> +	struct phy_port *port, *tmp;
> +
> +	sfp_bus_del_upstream(phydev->sfp_bus);
> +	phydev->sfp_bus = NULL;
> +
> +	list_for_each_entry_safe(port, tmp, &phydev->ports, head) {
> +		if (!port->is_sfp)
> +			continue;
> +
> +		phy_del_port(phydev, port);
> +		phy_port_destroy(port);
> +	}
> +}
> +
>  static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
>  {
>  	return phydrv->config_intr && phydrv->handle_interrupt;
> @@ -3547,13 +3576,13 @@ static int phy_setup_ports(struct phy_device *phydev)
>  	if (!phydev->is_genphy_driven) {
>  		ret = phy_sfp_probe(phydev);
>  		if (ret)
> -			goto out;
> +			goto err_ports;
>  	}
>  
>  	if (phydev->n_ports < phydev->max_n_ports) {
>  		ret = phy_default_setup_single_port(phydev);
>  		if (ret)
> -			goto out;
> +			goto err_sfp;
>  	}
>  
>  	linkmode_zero(ports_supported);
> @@ -3580,7 +3609,9 @@ static int phy_setup_ports(struct phy_device *phydev)
>  
>  	return 0;
>  
> -out:
> +err_sfp:
> +	phy_sfp_release(phydev);
> +err_ports:
>  	phy_cleanup_ports(phydev);
>  	return ret;
>  }
> @@ -3744,7 +3775,7 @@ static int phy_probe(struct device *dev)
>  
>  	err = phy_setup_ports(phydev);
>  	if (err)
> -		goto out_sfp_release;
> +		goto out_reset;
>  
>  	phy_advertise_supported(phydev);
>  
> @@ -3816,9 +3847,7 @@ static int phy_probe(struct device *dev)
>  		phy_led_triggers_unregister(phydev);
>  
>  out_sfp_release:
> -	sfp_bus_del_upstream(phydev->sfp_bus);
> -	phydev->sfp_bus = NULL;
> -
> +	phy_sfp_release(phydev);
>  	phy_cleanup_ports(phydev);
>  
>  out_reset:
> @@ -3842,9 +3871,7 @@ static int phy_remove(struct device *dev)
>  
>  	phydev->state = PHY_DOWN;
>  
> -	sfp_bus_del_upstream(phydev->sfp_bus);
> -	phydev->sfp_bus = NULL;
> -
> +	phy_sfp_release(phydev);
>  	phy_cleanup_ports(phydev);
>  
>  	if (phydev->drv && phydev->drv->remove)

