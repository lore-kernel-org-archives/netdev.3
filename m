Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE463FF1DA;
	Fri, 15 May 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860447; cv=none; b=IxBUXjQYQH6bRz7u2ALAFfSdS7TcHhideMj6IqIePJyNN+qubp1rK+RxzDf8ASb2xV22rtobOzlF177jOg/epv7B+ilciOV67a3O+7vLtHoCOuzipZpAoE0QT8PPMvhfTdth6c9PvJYnRjiG771KxleI11OSOOHIr/oS1i+KbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860447; c=relaxed/simple;
	bh=2m6hNE+rGWWRszgjJjZdV3kXtKuk3ayDQEvlVFEHccg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nyv/BlwcDuvt0BbJU6rpobYqC6sjFIewzFDQFCfsljTXc26mTYsG+wXqem4JiVsYCB474exD8HZGohziY6adZ/8p2l9aOWkHeK9+zHozcszWW1k+UbJc52pmgr83Ch841YAwOdgfXLmkUMKOPk18Za6N+yIImPKILL1vAH/PbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K3DxjwsM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K3DxjwsM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CFB244E42CAD;
	Fri, 15 May 2026 15:54:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9D585606FD;
	Fri, 15 May 2026 15:54:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D1DC11AF82F1;
	Fri, 15 May 2026 17:54:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778860443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jgFFboY+gNJXBunWTKjK4mQbM9XZJIPH3hYlzV0QAxQ=;
	b=K3DxjwsMHzxTrUYCC2Nhvd2XryYHdkaq49tQzPVbsfh+OgaIjOUOoluVpVBtoH2IxNO1rb
	vh3uMdilL9Gq1wrotNbHe/bheW4XyShgwa7JATN6cTMAgzj9BQsVe3ZXz+vqD5F5qb2hCw
	mLdUY/0eDPHsA1ntKYxnOnUiYcbjUpGkN0SkIclTB8bgE+B1Fzui7WTHXD2QUWzsntrLeu
	o/NniAOtMEdfctsDZeMurgYwhgUT2P8XgpX+ak7wLTwyQR6zSo0FdwpSA8rLPqsenJpTSe
	U3gQEbY5QWZ17kn6+q7Ez/OVlaFIUzo88tyda0L1+dPtjlJjzIEV20UhIEWtVA==
Message-ID: <3e698b9d-254a-4112-9cd5-217447efc8d3@bootlin.com>
Date: Fri, 15 May 2026 17:54:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net-next] net: mdio: mscc-miim: Use
 devm_of_mdiobus_register()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
 <139ebd0e3698de5e785bb0c70a4d4da43925a7ae.1778856199.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <139ebd0e3698de5e785bb0c70a4d4da43925a7ae.1778856199.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 5/15/26 16:50, Christophe JAILLET wrote:
> Use devm_of_mdiobus_register() instead of hand writing it.
> This saves some lines of code.
> 
> The remove function can be removed completely and the
> platform_set_drvdata() call at the end of the probe is now also useless and
> can be removed as-well.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> Compile tested only.
> ---
>   drivers/net/mdio/mdio-mscc-miim.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
> index 4d8f60d458b8..7bdcf3e9baa0 100644
> --- a/drivers/net/mdio/mdio-mscc-miim.c
> +++ b/drivers/net/mdio/mdio-mscc-miim.c
> @@ -322,22 +322,13 @@ static int mscc_miim_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = of_mdiobus_register(bus, np);
> +	ret = devm_of_mdiobus_register(dev, bus, np);
>   	if (ret < 0)
>   		return dev_err_probe(dev, ret, "Cannot register MDIO bus\n");
>   
> -	platform_set_drvdata(pdev, bus);
> -
>   	return 0;
>   }
>   
> -static void mscc_miim_remove(struct platform_device *pdev)
> -{
> -	struct mii_bus *bus = platform_get_drvdata(pdev);
> -
> -	mdiobus_unregister(bus);
> -}
> -
>   static const struct mscc_miim_info mscc_ocelot_miim_info = {
>   	.phy_reset_offset = MSCC_PHY_REG_PHY_CFG,
>   	.phy_reset_bits = PHY_CFG_PHY_ENA | PHY_CFG_PHY_COMMON_RESET |
> @@ -363,7 +354,6 @@ MODULE_DEVICE_TABLE(of, mscc_miim_match);
>   
>   static struct platform_driver mscc_miim_driver = {
>   	.probe = mscc_miim_probe,
> -	.remove = mscc_miim_remove,
>   	.driver = {
>   		.name = "mscc-miim",
>   		.of_match_table = mscc_miim_match,

