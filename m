Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A73002DD
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448282; cv=none; b=ZkFUlcpixpqOhD9N99raWTgWFyVwrXL+0zNj39UGAYA8tzoKGQdLEekC86ZJsWkLeTeLcrQ9yQeE4LanGgxFaNcX01Br+a77S2fs6P5FEjJjTZ5rOJQ17M2myqWxLcbQ1d9SBVXsOp5IwefqU9ieflf3++iUSf0iqFP6b3XgDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448282; c=relaxed/simple;
	bh=uFR7vBuWQagDMRmgM/HsVeH+mpsqJ1cvp7EBPDEd+bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp0lxE4ZK2cxLj3Ma8V2FwYrx7ijqyk+LVLnHrk0uiL+YxJGwcUb96HjKrZfZyusIleb7nW8aZlInXyV3DNnkgJ7sZ+1SuDRxidFo+SVWTOW8ZxIzJjyuLfo6siCPN/c8M/nBU1McKoh5M283yY23SuCoZkLIUPS3tZXUtcmcL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u9irlMhG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u9irlMhG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A0B544E41176;
	Thu,  8 Oct 2026 08:31:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7498E60341;
	Thu,  8 Oct 2026 08:31:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF23F10333858;
	Thu,  8 Oct 2026 10:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791448277; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=bI7GgFRD6iktaLoy35f6z/lIHR9Bbuj2DKLMv7QQRjo=;
	b=u9irlMhGN6Mf706UjIWpGAmJjw/7cTHRtcEuqd5/xVJFAlA3bw5vh1C6TWFX10N8zvrWcS
	7BxUiuftHSEOwZgh0oVEQs3s9aw7iC/zHNB9HIYVdzMpDfpiCFfpt7d4ZewDsGu0p12a4C
	vx49jw16atuv1BVJWsLYh/YjPiED00EFX4pis+x7ecRZgAuKK5lh08gVhqkIz8JPF6k7lu
	TIDARs+Bo5xSNnF+NGqkv5GkMxottF8nXr9rr1uvNzez6Xmw0REbIVog5fS4VTOgQq4UUv
	3u+VORirT51zNvv+S2MaSEVCjjgQEY0i0FjJELEAC2UatlqQberiDRRgtunA6g==
Message-ID: <4bbf3581-1502-423b-992c-e326dc8270a0@bootlin.com>
Date: Thu, 8 Oct 2026 10:31:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 06/10] net: au1000: move setting of netops to fix
 crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Runyu Xiao <runyu.xiao@seu.edu.cn>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-7-mmyangfl@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261008022656.3592191-7-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/8/26 04:26, David Yang wrote:
> au1000_probe() calls au1000_mii_probe(), which connects the PHY,
> before dev->netdev_ops is assigned. phy_attach_direct() ->
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
>  drivers/net/ethernet/amd/au1000_eth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
> index 5a04056e38fa..8682323d693f 100644
> --- a/drivers/net/ethernet/amd/au1000_eth.c
> +++ b/drivers/net/ethernet/amd/au1000_eth.c
> @@ -1225,6 +1225,8 @@ static int au1000_probe(struct platform_device *pdev)
>  		goto err_mdiobus_reg;
>  	}
>  
> +	dev->netdev_ops = &au1000_netdev_ops;
> +
>  	err = au1000_mii_probe(dev);
>  	if (err != 0)
>  		goto err_out;
> @@ -1263,7 +1265,6 @@ static int au1000_probe(struct platform_device *pdev)
>  
>  	dev->base_addr = base->start;
>  	dev->irq = irq;
> -	dev->netdev_ops = &au1000_netdev_ops;
>  	dev->ethtool_ops = &au1000_ethtool_ops;
>  	dev->watchdog_timeo = ETH_TX_TIMEOUT;
>  

