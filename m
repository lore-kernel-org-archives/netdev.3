Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985647729B;
	Thu,  8 Oct 2026 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448354; cv=none; b=EcJv6Wl8G30csaNhdkH4rXX+s3PW+/zXVgUMOdq+GiV3bRhG1tAGpxsvq0cZQLJe2jJDuWtKMdXQd9vUCPJ11aA27RJwSkv6DU1Ytac4khC8/gkb1KnhYE6qwN4//UBw0QnNqJR0ZCc9AC73sCGk70FmBhpOtChscfrqx419tiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448354; c=relaxed/simple;
	bh=yv8u3V2e4v07+0aEO6mjgnTL9YesGuzI+E2aUgXhcG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFLi5dMJuvvwul167oZAWYOXsMWGSjNAQjXxUBJSbPQJoEL6O7uDdUhsCq8c/cJpqsU14JV3jIOr2oS/CWb5ETB4tSdIXkxM9fWe+uepz8+2v1Ev9DybrnVLipqHbiPaBkjy2v9z97FM19JucQSu+okuMOmWGEKdbdMC+XGra3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bgLdc+Rd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bgLdc+Rd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B9E834E41181;
	Thu,  8 Oct 2026 08:32:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8DFD260341;
	Thu,  8 Oct 2026 08:32:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9B1210333853;
	Thu,  8 Oct 2026 10:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791448349; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gl41XFpDZAzGPhLc87UB5iDf8jYnryqIe5ze7K2TtvY=;
	b=bgLdc+RdLIMpPCmcAMjt4JHeAr8+8qx7Um7aIiL/oThFWxQnN5GPPrD2PeDNaT9hzuarQN
	hbPEWNDjsVMBWaPPzAuAFA9ov3vppBDMjmIey12+FWpjffAp6lvS3E3g0Tq/YlqUF2MeHQ
	PEFd2k1zSXlO/EhoseFlKq/venzV/lLoKls75WccPshWTN95UA0lJDIZmZLbyW2oTkUeK0
	PagJub7wYjjSnaV05Y3VHrXFT3jmwQBAfScKSUvayYolnVOAuXmaim5u1A8ZwSDqWcCwy6
	o8HVUsSe+EbqVwz3NHQ6ylWyO2FYRKFcHpHjmYIWBQpPgKzWZrFm9IORVcJZJA==
Message-ID: <c4d1c8e6-ed86-416b-94af-c3d8f1075253@bootlin.com>
Date: Thu, 8 Oct 2026 10:32:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 10/10] microchip: lan865x: move setting of netops to
 fix crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, Jacob Keller <jacob.e.keller@intel.com>,
 linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-11-mmyangfl@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261008022656.3592191-11-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/8/26 04:26, David Yang wrote:
> lan865x_probe() assigns netdev_ops only after oa_tc6_init(), which
> connects the internal MAC-PHY through phy_connect_direct().
> phy_attach_direct() -> phy_link_topo_add_phy() reads dev->netdev_ops
> through netdev_need_ops_lock() since the commit in question, so probing
> crashes with a NULL pointer dereference when CONFIG_NET_SHAPER is
> enabled.
> 
> Assign netdev_ops before the PHY attach, as was done for emac in commit
> 7c9f391ec89c ("net: emac: move setting of netops to fix crash").
> 
> Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

> ---
>  drivers/net/ethernet/microchip/lan865x/lan865x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> index 26a2761332a5..633d00857774 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -346,6 +346,8 @@ static int lan865x_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, priv);
>  	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
>  
> +	netdev->netdev_ops = &lan865x_netdev_ops;
> +
>  	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
>  	if (!priv->tc6) {
>  		ret = -ENODEV;
> @@ -397,7 +399,6 @@ static int lan865x_probe(struct spi_device *spi)
>  
>  	netdev->if_port = IF_PORT_10BASET;
>  	netdev->irq = spi->irq;
> -	netdev->netdev_ops = &lan865x_netdev_ops;
>  	netdev->ethtool_ops = &lan865x_ethtool_ops;
>  
>  	ret = register_netdev(netdev);

