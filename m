Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885C33A6F8;
	Sat, 28 Feb 2026 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772321164; cv=none; b=Vhk+KyxUxvVZoEv4R/lWRDxxNHkZPHNpqYKVDsmX7CSw+7CdX7UCDy2cdp+IXj+ZbMddXRT8RAQtWtCbmabwgO36OEHLecSVuoWd3obtGXmkh5TdlBdXLiKqBESDNdfDHUdNQ/l2z9w78/x0L86raOvqnzNZ8ZhwNJ6sUASjA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772321164; c=relaxed/simple;
	bh=vg+HokoOuR75m6XVzmXkNZIICPQaP9901HRxF4Jxgt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0ysLCveprUwHbU6OLFo5cO/+yzx0hUYz22Vj2mentCruqiw48ed7+uOKIq6xSYKPJV64qAdW04FkC6z6U1Cu+u0nq5PRZnadS/JQLnCVSR/n6SbVr+J8HuwQjNgLJiXNCY2sX2coTn/0IbuIuHWSim7hXqbYr+scjhelPp3yBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfIHjwV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfIHjwV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61D2C116D0;
	Sat, 28 Feb 2026 23:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772321163;
	bh=vg+HokoOuR75m6XVzmXkNZIICPQaP9901HRxF4Jxgt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfIHjwV2AGGJI+s8n3pFjNsKSBZratpAEwhfzEZ0sy9pJTGOqbo2YPKF+aHu4/9Rx
	 HkHjhO7aao/ieVo//rVk8f6l9xcrSlNb07pCDGHoTIqfQjYIxbkIcJRp8mWrw5XoaN
	 mwc1NnHQXsnKHLopsn3IBgCn/X5AnNEW259fUP3aygq7RMV4Y7IGkGCm37eJie/jKC
	 3PDiQmB8G7B48lFz8DUFigFLmNVs6mpVuN7bygG0EastmuTq2GOjIXHYjg9uSoNFR0
	 sp1H5gzo1OwfSkJ03eMXcvWnm9nnRjaPv0z4/I3TZNhwjvxfFm/Fzk12oq88g1s7jD
	 8SvNhz52LQCLA==
From: Jakub Kicinski <kuba@kernel.org>
To: conor@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	richardcochran@gmail.com,
	abin.joseph@amd.com,
	robh@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	theo.lebrun@bootlin.com,
	pjw@kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	krzk+dt@kernel.org,
	sean.anderson@linux.dev,
	aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org,
	alex@ghiti.fr,
	devicetree@vger.kernel.org,
	palmer@dabbelt.com,
	nicolas.ferre@microchip.com,
	vineeth.karumanchi@amd.com,
	claudiu.beznea@tuxon.dev,
	samuel.holland@sifive.com,
	daire.mcnamara@microchip.com,
	conor+dt@kernel.org,
	dave.stevenson@raspberrypi.com,
	linux-riscv@lists.infradead.org,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	narmstrong@baylibre.com,
	pabeni@redhat.com
Subject: Re: [net-next,v2,2/8] net: macb: rename macb_default_usrio to at91_default_usrio as not all platforms have mii mode control in usrio
Date: Sat, 28 Feb 2026 15:26:00 -0800
Message-ID: <20260228232600.4187398-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226-enjoyer-shock-e17f9dc7cbdb@spud>
References: <20260226-enjoyer-shock-e17f9dc7cbdb@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: rename macb_default_usrio to at91_default_usrio as not all
platforms have mii mode control in usrio

This patch renames macb_default_usrio to at91_default_usrio to better
reflect that the usrio configuration is platform-specific, and
introduces a new capability flag (MACB_CAPS_USRIO_HAS_MII) to gate MII
mode configuration code for platforms that actually support it.

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -779,6 +779,7 @@ #define MACB_CAPS_DMA_64B			BIT(21)
>  #define MACB_CAPS_DMA_PTP			BIT(22)
>  #define MACB_CAPS_RSC				BIT(23)
>  #define MACB_CAPS_NO_LSO			BIT(24)
> +#define MACB_CAPS_USRIO_HAS_MII			BIT(25)
>
>  /* LSO settings */
>  #define MACB_LSO_UFO_ENABLE			0x01
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4614,13 +4614,15 @@
>
>  	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
>  		val = 0;
> -		if (phy_interface_mode_is_rgmii(bp->phy_interface))
> -			val = bp->usrio->rgmii;
> -		else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
> -			 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> -			val = bp->usrio->rmii;
> -		else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> -			val = bp->usrio->mii;
> +		if (bp->caps & MACB_CAPS_USRIO_HAS_MII) {
> +			if (phy_interface_mode_is_rgmii(bp->phy_interface))
> +				val = bp->usrio->rgmii;
> +			else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
> +				 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> +				val = bp->usrio->rmii;
> +			else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> +				val = bp->usrio->mii;
> +		}
>
>  		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
>  			val |= bp->usrio->refclk;

Can bp->usrio be NULL here? The new MACB_CAPS_USRIO_HAS_MII capability
gates the MII-related dereferences of bp->usrio, but bp->usrio is also
dereferenced when MACB_CAPS_USRIO_HAS_CLKEN is set.

With the change to default_gem_config later in this patch:

static const struct macb_config default_gem_config = {
	...
	.usrio = NULL,
	...
};

A device that matches the generic 'cdns,macb' compatible string (without
specific .data) will get bp->usrio = NULL during probe. If the device
tree then has 'cdns,refclk-ext', macb_configure_caps() adds
MACB_CAPS_USRIO_HAS_CLKEN without checking if bp->usrio is valid:

macb_configure_caps() {
	...
	if (of_property_read_bool(np, "cdns,refclk-ext"))
		bp->caps |= MACB_CAPS_USRIO_HAS_CLKEN;
	...
}

Then in macb_init(), the code would dereference bp->usrio->refclk with
bp->usrio being NULL, causing a crash.

The MACB_CAPS_USRIO_HAS_MII gate only protects the MII-related
dereferences above, not the CLKEN dereference.

> @@ -4638,13 +4640,6 @@
>  	return 0;
>  }
>
> -static const struct macb_usrio_config macb_default_usrio = {
> -	.mii = MACB_BIT(MII),
> -	.rmii = MACB_BIT(RMII),
> -	.rgmii = GEM_BIT(RGMII),
> -	.refclk = MACB_BIT(CLKEN),
> -};
> -

[ ... ]

> @@ -5219,6 +5214,13 @@ static int eyeq5_init(struct platform_device *pdev)
>  	return ret;
>  }
>
> +static const struct macb_usrio_config at91_default_usrio = {
> +	.mii = MACB_BIT(MII),
> +	.rmii = MACB_BIT(RMII),
> +	.rgmii = GEM_BIT(RGMII),
> +	.refclk = MACB_BIT(CLKEN),
> +};
> +

[ ... ]

> @@ -5432,7 +5448,7 @@ MODULE_DEVICE_TABLE(of, macb_dt_ids);
>  	.dma_burst_length = 16,
>  	.clk_init = macb_clk_init,
>  	.init = macb_init,
> -	.usrio = &macb_default_usrio,
> +	.usrio = NULL,
>  	.jumbo_max_len = 10240,
>  };
>
-- 
pw-bot: cr
