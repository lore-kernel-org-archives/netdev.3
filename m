Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FA382F1C;
	Thu, 23 Apr 2026 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964864; cv=none; b=oW9kCt647Co6Q2p/jEYZDxO3gU9J/M7yYyESjlWpGkLU4UbZk/LZgwzhVVJIQg6QpsFvMSIdakEOL8sxR6sQtzsJ6qYEP9Hvn38zGG83cX8MB4cYWbp6D8F8IAd5+Bqtjb6bbqrPG0kt3rgYez5aL8fUrx2KB6dJOM4vK1wDZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964864; c=relaxed/simple;
	bh=jBKjEIuPSlZzDaUvUOYnX/91w3hhboRJThqHrStltBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4QXmQFtKfaQE3M0zhLlv09XnZ9dqW6Y7zTkR9zSK08i4cG8gthfLr3uVCX0XGjm8afIYYHRf1m40uo6DOYxRqwBiwOOU3a9Qe/+uIqgGoRklx5e/g3PiQf+x5kVWgxMD8UvSNzJX1OsC2eoby0xnjTDAZazg21u2+p4D/uuFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3ap0dhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3ap0dhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3EFC2BCAF;
	Thu, 23 Apr 2026 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776964864;
	bh=jBKjEIuPSlZzDaUvUOYnX/91w3hhboRJThqHrStltBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b3ap0dhExrR7kB+k8pXOh/WcxIWkRs3ofPa6f0Oxkmw9RcHmLNAE3SEUzkS3F96hK
	 vV2RH/vJ9PBuT0V19U7adQWYZVelk7LC0+02TasTyfKMc34eW7v6NCk8JXF7Y1kMPQ
	 xc4ZZSD+o/p2Fr8WS+f1hjABlifRza3tODtIhQ4MW7kqYJMx7EDDcpMWg14F6FcSWJ
	 70OVksHxlZBmKZDY26cEcdst4QHqQfv2rjNZGao5Bzt2NU/rzXI8jtlEvfHVPbm2AN
	 EnfyIrywEVu4FU928tB7AclKRFxf24XtOdE09YO85UeHqYnvt0KkGngARhljX77AZd
	 hkFxLo2pMU+0g==
Date: Thu, 23 Apr 2026 10:21:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no,
 ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com, albert-al.lee@airoha.com
Subject: Re: [PATCH v3] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
Message-ID: <20260423102102.0192b7de@kernel.org>
In-Reply-To: <20260420134506.35164-1-lucienzx159@gmail.com>
References: <20260420134506.35164-1-lucienzx159@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Since you need to repost to fix the fixes tag, plaese also improve the
error handling

On Mon, 20 Apr 2026 21:45:06 +0800 Lucien.Jheng wrote:
>  static int an8811hb_probe(struct phy_device *phydev)
>  {
> +	struct mdio_device *mdiodev;
>  	struct en8811h_priv *priv;
>  	int ret;
>  
> @@ -1175,10 +1281,22 @@ static int an8811hb_probe(struct phy_device *phydev)
>  		return -ENOMEM;
>  	phydev->priv = priv;
>  
> +	mdiodev = mdio_device_create(phydev->mdio.bus,
> +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
> +	if (IS_ERR(mdiodev))
> +		return PTR_ERR(mdiodev);
> +
> +	ret = mdio_device_register(mdiodev);
> +	if (ret) {

goto err_dev_free;

> +		mdio_device_free(mdiodev);
> +		return ret;
> +	}
> +	priv->pbusdev = mdiodev;
> +
>  	ret = an8811hb_load_firmware(phydev);
>  	if (ret < 0) {
>  		phydev_err(phydev, "Load firmware failed: %d\n", ret);
> -		return ret;
> +		goto error;

goto err_dev_create;

>  	}
>  
>  	en8811h_print_fw_version(phydev);
> @@ -1191,22 +1309,27 @@ static int an8811hb_probe(struct phy_device *phydev)
>  
>  	ret = en8811h_leds_setup(phydev);
>  	if (ret < 0)
> -		return ret;
> +		goto error;
>  
>  	priv->phydev = phydev;
>  	/* Co-Clock Output */
>  	ret = an8811hb_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
>  	if (ret)
> -		return ret;
> +		goto error;
>  
>  	/* Configure led gpio pins as output */
>  	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
>  				      AN8811HB_GPIO_OUTPUT_345,
>  				      AN8811HB_GPIO_OUTPUT_345);
>  	if (ret < 0)
> -		return ret;
> +		goto error;
>  
>  	return 0;
> +
> +error:

err_dev_free:

> +	mdio_device_remove(priv->pbusdev);

err_dev_create:

> +	mdio_device_free(priv->pbusdev);
> +	return ret;
