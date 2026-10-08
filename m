Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3B451991
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448339; cv=none; b=S/Y85t+FaTaNMBlF2npqhRjvOoTXTmRf8x3T38WNzx+RBazd5hW+kTPSIWpz7uGAiN0nIVxFlWQrh+fZYgSk6/rTKHLEtR2ErCb03l0/Q4ulPzm9QBk6WCeKvVGMk6ivJ1KGdLkt8czR4k/1EgILb9wChcczYoN/HL2W0Njdztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448339; c=relaxed/simple;
	bh=mKPxpFXIIF8Czy3FxcgFWg1HjY+yIVit76orNJybYUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZ+w6TKfrk7kzYC6JVZUsEq209opdLjvtmMhT123pAXVhlInJ2CiwHMrTvjSemQDhUb/QeCBB7yoXvNsDxEBiSf+yxDzWcpf3ST/mxtR/m9K7AGZ0wqF/7bgQ33FucuVI9i/hZ9C5SZuW6iC7VyAg0qwFuH4Q4QT8OSd/AoUSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yyHoI/ox; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yyHoI/ox"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B2F391A1185;
	Thu,  8 Oct 2026 08:32:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8189360341;
	Thu,  8 Oct 2026 08:32:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1E6E10333850;
	Thu,  8 Oct 2026 10:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791448333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DKhOUStc32yyJJh2yPmsAjtT0L8xYwJmDHCV2AfoKVk=;
	b=yyHoI/oxSfdhJNEDv3/CTjikWXWJLcVViQRDKXaycfcuAlZd406+P127DWOfiugd/D3kPT
	es+l7ZPrDzzrxVzEGCjdfBHqn7srcDW5pvXitk5X0S/rgaiyKfa/KIOglKufZH+/7Jcr/1
	iVlNRIJpJJSsJfTI9eA979l45dSzZr5V3SYh7GgA44kO6BrtmjUaBJaLQ+CW6/DU1jaS8l
	4midyiJUTxJjAnIt/t7/7RoKpo8VHigd7tpdij5H1ztJ9DZHdjDjqdsI5py7gbVE8Tf4eF
	2MUU0LmXwD+78xuwBWZ2abmo8JXhrmrhTcsfEXOgsygxxCmHje1udtX2G7+HxA==
Message-ID: <85184f37-32d8-42ce-90db-46cde769ecf5@bootlin.com>
Date: Thu, 8 Oct 2026 10:32:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/10] net: ti: icssm-prueth: Move setting of netops
 to fix crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: MD Danish Anwar <danishanwar@ti.com>, Parvathi Pudi
 <parvathi@couthit.com>, Roger Quadros <rogerq@kernel.org>,
 Mohan Reddy Putluru <pmohan@couthit.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Nicolai Buchwitz <nb@tipi-net.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-10-mmyangfl@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261008022656.3592191-10-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/8/26 04:26, David Yang wrote:
> icssm_prueth_netdev_init() calls of_phy_get_and_connect() before
> ndev->netdev_ops is assigned. phy_attach_direct() ->
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
>  drivers/net/ethernet/ti/icssm/icssm_prueth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index b7e94244355a..b42c98e861e0 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> @@ -1563,6 +1563,8 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>  	}
>  	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>  
> +	ndev->netdev_ops = &emac_netdev_ops;
> +
>  	/* connect PHY */
>  	emac->phydev = of_phy_get_and_connect(ndev, eth_node,
>  					      icssm_emac_adjust_link);
> @@ -1590,7 +1592,6 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>  	}
>  
>  	ndev->dev.of_node = eth_node;
> -	ndev->netdev_ops = &emac_netdev_ops;
>  
>  	netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
>  

