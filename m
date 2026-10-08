Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA346D567
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448262; cv=none; b=KtR2J9J/9Z5qoNq71RB1xLgxSC58xjYjHqEp1XkgdY2lEEWytcUsfr4K9FaD07PBlKDtY8KSEgjszEz0OO2UjbbjskXsg2Rj44AqAmyEH1b5UC2ULcs1YxvopV7GEQV1muvoV346eA/a8LYECT/wCi4TNf/RXrHW2t0TBRJqWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448262; c=relaxed/simple;
	bh=VQRhDymlHxO4P15VM7Zlak+T81ZfGzO7SacCihV8224=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lehfxLeQxBG11s4+UjyKhGvlBoeKywy5EM1s2g5zyYyiMYny0WUVP+4B2WPK1Kd2cgfkQRWd+1+bL8XWTsbnmuXHXQW03HEG1Fya6U6LvFiaC2im0OMLoylv7J/9M4ajERpLskLxj5ES20nfzf19jxKXuRf5EkGQ8LskPhw1sxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=STo/Jjwc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="STo/Jjwc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8A96D1A1185;
	Thu,  8 Oct 2026 08:30:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D81660341;
	Thu,  8 Oct 2026 08:30:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E66AE10333850;
	Thu,  8 Oct 2026 10:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791448258; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=C8HerE4JC8nfRjub4rsf8mucx/GS3daCCcx3JUHV+As=;
	b=STo/Jjwc2OQdmXHw0M5scCfqG7Joy1lnnPSPQBCWUq9fcq9K32y3153GIAZ+KR5MhYiKiR
	m+Civc4hdj51qVGXPJvk7Cqr2COY2FyApwqzVYvthAdAs29cFe7ae8nsoHBWN0bxnSzEKQ
	cZrbqbzEWLIqyCyDyJ1GHLtPwwlvMeSsMNFnb3nQ2M2cEIq1+f9+1x4XfaZAop7T7AvgiT
	eM6lT6RQCFLab/C8bN2HEwZSJLGXs8D33iWL2mXvXZN3adLsvZo4+lmaVGZLTQIYu9m+00
	IZ6tOQXxgaVTyThXjTAeTJKS9ac9zFCT6zwRy12Ll+EdgVc4WqVeRf830N8V/A==
Message-ID: <cb745ce9-c100-4c16-b9b1-670379d0bdef@bootlin.com>
Date: Thu, 8 Oct 2026 10:30:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 04/10] net: ethernet: adi: Move setting of netops to
 fix crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Ciprian Regus <ciprian.regus@analog.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Nicolai Buchwitz <nb@tipi-net.de>,
 linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-5-mmyangfl@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261008022656.3592191-5-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/8/26 04:26, David Yang wrote:
> adin1140_probe() calls adin1140_phy_init(), which connects the PHY,
> before netdev->netdev_ops is assigned. phy_attach_direct() ->
> phy_link_topo_add_phy() reads dev->netdev_ops through
> netdev_need_ops_lock() since the commit in question, so probing crashes
> with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.
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
>  drivers/net/ethernet/adi/adin1140.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/adi/adin1140.c b/drivers/net/ethernet/adi/adin1140.c
> index 93710baca151..ca96a919c24b 100644
> --- a/drivers/net/ethernet/adi/adin1140.c
> +++ b/drivers/net/ethernet/adi/adin1140.c
> @@ -733,6 +733,8 @@ static int adin1140_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	netdev->netdev_ops = &adin1140_netdev_ops;
> +
>  	ret = adin1140_phy_init(priv, spi);
>  	if (ret)
>  		return ret;
> @@ -748,7 +750,6 @@ static int adin1140_probe(struct spi_device *spi)
>  
>  	netdev->if_port = IF_PORT_10BASET;
>  	netdev->irq = spi->irq;
> -	netdev->netdev_ops = &adin1140_netdev_ops;
>  	netdev->ethtool_ops = &adin1140_ethtool_ops;
>  	netdev->netns_immutable = true;
>  	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE |

